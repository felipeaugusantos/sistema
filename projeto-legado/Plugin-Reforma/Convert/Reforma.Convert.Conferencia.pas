unit Reforma.Convert.Conferencia;

// Fase C do Convert (REFTRI-02, RN18): compara o produto gravado com a ITEREF e com o valor esperado e grava a REFDIV.
// So le o produto. Uma consulta por empresa traz ITEREF, ITEGER e ITEREO lado a lado e a comparacao e feita aqui,
// coluna a coluna, com a lista de colunas da estrutura (as que existem neste banco).
//
// Bloqueantes (impedem a ativacao): CONTAGEM, PENDENTE, VALOR, PREPRO, FEDERAL, PRECOM e GRUPO. Alertas (ALERTA) nao
// bloqueiam. EXCLUIDO e ALTERADO sao eventos de outras fases: ficam na REFDIV entre uma conferencia e outra
// (decisao do usuario, 2026-10-05) e nao contam como bloqueantes.
// Empresa que usa o preco da logada com o item no ITEGER e sem linha na conversao (150.x: sem PREPRO nela; o cadastro
// tambem nao grava) vira ALERTA, sem bloquear (usuario, 2026-10-06).

interface

uses
  System.Generics.Collections,
  Reforma.Contrato.Gravacao,
  Reforma.Contrato.Host,
  Reforma.Contrato.Convert,
  Reforma.Convert.Estrutura;

const
  TIPO_CONTAGEM = 'CONTAGEM';
  TIPO_PENDENTE = 'PENDENTE';
  TIPO_VALOR = 'VALOR';
  TIPO_PREPRO = 'PREPRO';
  TIPO_FEDERAL = 'FEDERAL';
  TIPO_PRECOM = 'PRECOM';
  TIPO_GRUPO = 'GRUPO';
  TIPO_ALERTA = 'ALERTA';
  TIPO_EXCLUIDO = 'EXCLUIDO';
  TIPO_ALTERADO = 'ALTERADO';

  // Por empresa e tipo: o resto so entra na contagem (a REFDIV e para conferir, nao para listar a base inteira).
  LIMITE_DIVERGENCIAS_TIPO = 500;

type
  TDivergencia = record
    Empresa: string;
    Item: string;
    Tipo: string;
    Campo: string;
    Esperado: string;
    Encontrado: string;
  end;

  TConferenciaConvert = class
  strict private
    FHost: IReformaConvertHost;
    FEstrutura: TEstruturaConvert;
    FChave: string;
    FEmpresas: TArray<string>;
    FDecimais: Integer;
    FSomenteAtivos: Boolean;
    // Filtro de itens do operador 998 (Reforma.Convert.Processo.fSqlFiltroItens, alias G): a contagem so conta eles.
    FFiltroItens: string;
    FParametrosFiltro: TArray<TValorCampo>;
    FTabelasAtivas: string;
    FDivergencias: TList<TDivergencia>;
    FBloqueantes: TDictionary<string, Integer>;
    FPorTipo: TDictionary<string, Integer>;
    FAlertas: Integer;
    procedure pRegistrar(const Divergencia: TDivergencia; const Bloqueante: Boolean);
    function fTabelaAtiva(const Tabela: Integer): Boolean;
    function fContar(const Sql: string; const Parametros: array of TValorCampo): Integer;
    procedure pConferirContagem(const Empresa: string);
    procedure pConferirPendentes(const Empresa: string);
    procedure pConferirItens(const Empresa: string; const Logada: Boolean);
    procedure pConferirPrePro(const Empresa: string);
    procedure pConferirDescontos(const Empresa: string);
    procedure pConferirSemLinha(const Logada, Empresa: string);
    function fGravar: TResultadoGravacao;
  public
    // Empresas: a logada primeiro, depois as que usam o preco dela. SomenteAtivos: a conversao so pegou os itens
    // ativos (CADITE.ITE_ITEATI = 'S'), e a contagem segue o mesmo filtro.
    constructor Create(const Host: IReformaConvertHost; const Estrutura: TEstruturaConvert; const Chave: string;
      const Empresas: TArray<string>; const Decimais: Integer; const SomenteAtivos: Boolean;
      const FiltroItens: string = ''; const ParametrosFiltro: TArray<TValorCampo> = nil);
    destructor Destroy; override;
    // Confere tudo e grava a REFDIV (apaga antes a da chave, menos EXCLUIDO e ALTERADO).
    function Executar(const Progresso: IReformaProgresso): TResultadoGravacao;
    function Bloqueantes(const Empresa: string): Integer;
    function TotalBloqueantes: Integer;
    property Alertas: Integer read FAlertas;
  end;

function fDivergencia(const Empresa, Item, Tipo, Campo, Esperado, Encontrado: string): TDivergencia;
// INSERT de uma linha da REFDIV, com os textos no tamanho das colunas.
function fComandoDivergencia(const Chave: string; const Divergencia: TDivergencia;
  const Momento: TDateTime): TComandoSql;

implementation

uses
  System.SysUtils,
  System.Variants,
  Reforma.Contrato.Tipos,
  Reforma.Convert.Regra;

const
  COLUNA_TEXTO = 'ITE_PREDOL';

function fDivergencia(const Empresa, Item, Tipo, Campo, Esperado, Encontrado: string): TDivergencia;
begin
  Result.Empresa := Empresa;
  Result.Item := Item;
  Result.Tipo := Tipo;
  Result.Campo := Campo;
  Result.Esperado := Esperado;
  Result.Encontrado := Encontrado;
end;

function fValorOuNulo(const Texto: string; const Tamanho: Integer): Variant;
begin
  if Texto = '' then
    Result := Null
  else
    Result := Copy(Texto, 1, Tamanho);
end;

function fComandoDivergencia(const Chave: string; const Divergencia: TDivergencia;
  const Momento: TDateTime): TComandoSql;
begin
  Result := fComandoConvert(
    'INSERT INTO REFDIV (DIV_CHAVE, DIV_CODEMP, DIV_CODITE, DIV_TIPO, DIV_CAMPO, DIV_ESPERA, DIV_ENCONT, ' +
    'DIV_DTAREG, DIV_HORREG) VALUES (:CHAVE, :CODEMP, :CODITE, :TIPO, :CAMPO, :ESPERA, :ENCONT, :DTAREG, :HORREG)',
    [fParametroConvert('CHAVE', Chave),
     fParametroConvert('CODEMP', Divergencia.Empresa),
     fParametroConvert('CODITE', fValorOuNulo(Divergencia.Item, 20)),
     fParametroConvert('TIPO', Copy(Divergencia.Tipo, 1, 10)),
     fParametroConvert('CAMPO', fValorOuNulo(Divergencia.Campo, 20)),
     fParametroConvert('ESPERA', fValorOuNulo(Divergencia.Esperado, 40)),
     fParametroConvert('ENCONT', fValorOuNulo(Divergencia.Encontrado, 40)),
     fParametroConvert('DTAREG', fDataConvert(Momento)),
     fParametroConvert('HORREG', fHoraConvert(Momento))]);
end;

function fTextoValor(const Valor: Variant): string;
begin
  if VarIsNull(Valor) or VarIsEmpty(Valor) then
    Result := ''
  else if VarIsNumeric(Valor) then
    Result := fNumeroTextoConvert(fNumeroConvert(Valor))
  else
    Result := fTextoConvert(Valor);
end;

// IFNULL(x, 0) dos dois lados, como a checagem de alteracao da Fase A.
function fNumerosDiferentes(const A, B: Variant): Boolean;
begin
  Result := Abs(fNumeroConvert(A) - fNumeroConvert(B)) > TOLERANCIA_CONVERT;
end;

function fValoresDiferentes(const Coluna: string; const A, B: Variant): Boolean;
begin
  if SameText(Coluna, COLUNA_TEXTO) then
    Result := Trim(fTextoConvert(A)) <> Trim(fTextoConvert(B))
  else
    Result := fNumerosDiferentes(A, B);
end;

{ TConferenciaConvert }

constructor TConferenciaConvert.Create(const Host: IReformaConvertHost; const Estrutura: TEstruturaConvert;
  const Chave: string; const Empresas: TArray<string>; const Decimais: Integer; const SomenteAtivos: Boolean;
  const FiltroItens: string; const ParametrosFiltro: TArray<TValorCampo>);
begin
  inherited Create;
  FHost := Host;
  FEstrutura := Estrutura;
  FChave := Chave;
  FEmpresas := Empresas;
  FDecimais := Decimais;
  FSomenteAtivos := SomenteAtivos;
  FFiltroItens := FiltroItens;
  FParametrosFiltro := ParametrosFiltro;
  FTabelasAtivas := Host.TabelasAtivas;
  FDivergencias := TList<TDivergencia>.Create;
  FBloqueantes := TDictionary<string, Integer>.Create;
  FPorTipo := TDictionary<string, Integer>.Create;
end;

destructor TConferenciaConvert.Destroy;
begin
  FreeAndNil(FPorTipo);
  FreeAndNil(FBloqueantes);
  FreeAndNil(FDivergencias);
  inherited Destroy;
end;

procedure TConferenciaConvert.pRegistrar(const Divergencia: TDivergencia; const Bloqueante: Boolean);
var
  Chave: string;
  Quantidade: Integer;
begin
  if Bloqueante then
  begin
    if not FBloqueantes.TryGetValue(Divergencia.Empresa, Quantidade) then
      Quantidade := 0;
    FBloqueantes.AddOrSetValue(Divergencia.Empresa, Quantidade + 1);
  end
  else
    Inc(FAlertas);

  Chave := Divergencia.Empresa + '|' + Divergencia.Tipo;
  if not FPorTipo.TryGetValue(Chave, Quantidade) then
    Quantidade := 0;
  FPorTipo.AddOrSetValue(Chave, Quantidade + 1);
  if Quantidade < LIMITE_DIVERGENCIAS_TIPO then
    FDivergencias.Add(Divergencia);
end;

function TConferenciaConvert.fTabelaAtiva(const Tabela: Integer): Boolean;
begin
  Result := (Tabela <= Length(FTabelasAtivas)) and (UpCase(FTabelasAtivas[Tabela]) = 'S');
end;

function TConferenciaConvert.fContar(const Sql: string; const Parametros: array of TValorCampo): Integer;
var
  Consulta: IReformaConsulta;
  Parametro: TValorCampo;
begin
  Consulta := FHost.AbrirConsulta(Sql);
  for Parametro in Parametros do
    Consulta.DefinirParametro(Parametro.Nome, Parametro.Valor);
  Consulta.Abrir;
  Result := Round(fNumeroConvert(Consulta.ValorCampo('QTD')));
end;

// Itens no ITEGER da logada = linhas aplicadas dela na ITEREF (item novo depois da preparacao, ou nao convertido).
procedure TConferenciaConvert.pConferirContagem(const Empresa: string);
var
  NoProduto: Integer;
  Convertidos: Integer;
begin
  if FSomenteAtivos then
    NoProduto := fContar('SELECT COUNT(*) AS QTD FROM ITEGER G INNER JOIN CADITE C ON C.ITE_CODITE = G.ITE_CODITE ' +
      'WHERE G.ITE_CODEMP = :CODEMP AND C.ITE_ITEATI = ''S''' + FFiltroItens,
      TArray<TValorCampo>.Create(fParametroConvert('CODEMP', Empresa)) + FParametrosFiltro)
  else
    NoProduto := fContar('SELECT COUNT(*) AS QTD FROM ITEGER G WHERE G.ITE_CODEMP = :CODEMP' + FFiltroItens,
      TArray<TValorCampo>.Create(fParametroConvert('CODEMP', Empresa)) + FParametrosFiltro);
  Convertidos := fContar('SELECT COUNT(*) AS QTD FROM ITEREF WHERE REF_CHAVE = :CHAVE AND ITE_CODEMP = :CODEMP ' +
    'AND REF_APLICADO = ''S''', [fParametroConvert('CHAVE', FChave), fParametroConvert('CODEMP', Empresa)]);
  if NoProduto <> Convertidos then
    pRegistrar(fDivergencia(Empresa, '', TIPO_CONTAGEM, 'ITENS', IntToStr(NoProduto), IntToStr(Convertidos)), True);
end;

procedure TConferenciaConvert.pConferirPendentes(const Empresa: string);
var
  Pendentes: Integer;
begin
  Pendentes := fContar('SELECT COUNT(*) AS QTD FROM ITEREF WHERE REF_CHAVE = :CHAVE AND ITE_CODEMP = :CODEMP ' +
    'AND REF_APLICADO = ''N''', [fParametroConvert('CHAVE', FChave), fParametroConvert('CODEMP', Empresa)]);
  if Pendentes > 0 then
    pRegistrar(fDivergencia(Empresa, '', TIPO_PENDENTE, 'REF_APLICADO', '0', IntToStr(Pendentes)), True);
end;

// VALOR, FEDERAL, PRECOM, GRUPO e os alertas de preco/margem, numa consulta so por empresa (ordenada por grupo e
// item). ULTIMO e o maior ITE_CODITE do grupo na conversao: a mesma subconsulta da copia do grupo (RN23).
procedure TConferenciaConvert.pConferirItens(const Empresa: string; const Logada: Boolean);
type
  TLinha = record
    Item: string;
    Grupo: string;
    Ultimo: string;
    Aplicado: Boolean;
    Desconto: Double;
    PrecoCompraAntigo: Variant;
    PrecoVendaAntigo: array[1..QUANTIDADE_TABELAS_PRECO] of Double;
    Novos: TArray<Variant>;
    Atuais: TArray<Variant>;
  end;
var
  Colunas: TColunasItem;
  Sql: string;
  Coluna: string;
  Tabela: Integer;
  Indice: Integer;
  Consulta: IReformaConsulta;
  Linhas: TList<TLinha>;
  Linha: TLinha;
  Referencia: TLinha;
  PosPrecom, PosImpFed, PosSubFed, PosAlqFed: Integer;
  PosPreve, PosMarbr: array[1..QUANTIDADE_TABELAS_PRECO] of Integer;
  Esperado: Double;
  Inicio, Fim, Posicao: Integer;
  Federais: TArray<Integer>;
  TemReferencia: Boolean;

  function fPosicao(const Nome: string): Integer;
  var
    Busca: Integer;
  begin
    Result := -1;
    for Busca := 0 to High(Colunas) do
      if SameText(Colunas[Busca], Nome) then
        Exit(Busca);
  end;

begin
  Colunas := FEstrutura.Colunas;
  PosPrecom := fPosicao('ITE_PRECOM');
  PosImpFed := fPosicao('ITE_IMPFED');
  PosSubFed := fPosicao('ITE_SUBFED');
  PosAlqFed := fPosicao('ITE_ALQFED');
  Federais := [PosImpFed, PosSubFed, PosAlqFed];
  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
  begin
    PosPreve[Tabela] := fPosicao('ITE_PREVE' + IntToStr(Tabela));
    PosMarbr[Tabela] := fPosicao('ITE_MARBR' + IntToStr(Tabela));
  end;

  Sql := 'SELECT F.ITE_CODITE, F.REF_APLICADO, F.ITE_DPISCO, IFNULL(C.ITE_CODGPR, '''') AS GRUPO, U.ULTIMO';
  if PosPrecom >= 0 then
    Sql := Sql + ', O.ITE_PRECOM AS O_ITE_PRECOM';
  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
    if PosPreve[Tabela] >= 0 then
      Sql := Sql + ', O.ITE_PREVE' + IntToStr(Tabela) + ' AS O_ITE_PREVE' + IntToStr(Tabela);
  for Coluna in Colunas do
    Sql := Sql + ', F.' + Coluna + ' AS N_' + Coluna + ', G.' + Coluna + ' AS A_' + Coluna;
  Sql := Sql +
    ' FROM ITEREF F' +
    ' INNER JOIN ITEGER G ON G.ITE_CODEMP = F.ITE_CODEMP AND G.ITE_CODITE = F.ITE_CODITE' +
    ' LEFT JOIN ITEREO O ON O.REF_CHAVE = F.REF_CHAVE AND O.ITE_CODEMP = F.ITE_CODEMP AND O.ITE_CODITE = F.ITE_CODITE' +
    ' LEFT JOIN CADITE C ON C.ITE_CODITE = F.ITE_CODITE' +
    // Mesmo "ultimo" do TProcessoConversao.fComandoGrupo: o maior codigo com REFPRE na logada, senao o maior codigo.
    ' LEFT JOIN (SELECT CG.ITE_CODGPR,' +
    '                   COALESCE(MAX(CASE WHEN R.ITE_CODITE IS NOT NULL THEN CG.ITE_CODITE END), MAX(CG.ITE_CODITE)) AS ULTIMO' +
    '              FROM CADITE CG' +
    '             INNER JOIN ITEREF X ON X.ITE_CODITE = CG.ITE_CODITE AND X.REF_CHAVE = :CHAVE2' +
    '              LEFT JOIN REFPRE R ON R.ITE_CODEMP = X.ITE_CODEMP AND R.ITE_CODITE = X.ITE_CODITE AND X.REF_ORIGEM = ''L''' +
    '            WHERE IFNULL(CG.ITE_CODGPR, '''') <> '''' GROUP BY CG.ITE_CODGPR) U ON U.ITE_CODGPR = C.ITE_CODGPR' +
    ' WHERE F.REF_CHAVE = :CHAVE1 AND F.ITE_CODEMP = :CODEMP' +
    ' ORDER BY GRUPO, F.ITE_CODITE';

  Linhas := TList<TLinha>.Create;
  try
    Consulta := FHost.AbrirConsulta(Sql);
    Consulta.DefinirParametro('CHAVE1', FChave);
    Consulta.DefinirParametro('CHAVE2', FChave);
    Consulta.DefinirParametro('CODEMP', Empresa);
    Consulta.Abrir;
    while not Consulta.Fim do
    begin
      Linha.Item := fTextoConvert(Consulta.ValorCampo('ITE_CODITE'));
      Linha.Grupo := Trim(fTextoConvert(Consulta.ValorCampo('GRUPO')));
      Linha.Ultimo := fTextoConvert(Consulta.ValorCampo('ULTIMO'));
      Linha.Aplicado := fTextoConvert(Consulta.ValorCampo('REF_APLICADO')) = 'S';
      Linha.Desconto := fNumeroConvert(Consulta.ValorCampo('ITE_DPISCO'));
      if PosPrecom >= 0 then
        Linha.PrecoCompraAntigo := Consulta.ValorCampo('O_ITE_PRECOM')
      else
        Linha.PrecoCompraAntigo := Null;
      for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
        if PosPreve[Tabela] >= 0 then
          Linha.PrecoVendaAntigo[Tabela] := fNumeroConvert(Consulta.ValorCampo('O_ITE_PREVE' + IntToStr(Tabela)))
        else
          Linha.PrecoVendaAntigo[Tabela] := 0;
      SetLength(Linha.Novos, Length(Colunas));
      SetLength(Linha.Atuais, Length(Colunas));
      for Indice := 0 to High(Colunas) do
      begin
        Linha.Novos[Indice] := Consulta.ValorCampo('N_' + Colunas[Indice]);
        Linha.Atuais[Indice] := Consulta.ValorCampo('A_' + Colunas[Indice]);
      end;
      Linhas.Add(Linha);
      Consulta.Proximo;
    end;
    Consulta := nil;

    for Linha in Linhas do
    begin
      if not Linha.Aplicado then
        Continue;

      // VALOR: o produto ficou com o que a ITEREF guardou.
      for Indice := 0 to High(Colunas) do
        if fValoresDiferentes(Colunas[Indice], Linha.Novos[Indice], Linha.Atuais[Indice]) then
          pRegistrar(fDivergencia(Empresa, Linha.Item, TIPO_VALOR, Colunas[Indice], fTextoValor(Linha.Novos[Indice]),
            fTextoValor(Linha.Atuais[Indice])), True);

      // FEDERAL: zerados na logada e nas que usam o preco dela (RN05).
      for Posicao in Federais do
        if (Posicao >= 0) and (Abs(fNumeroConvert(Linha.Atuais[Posicao])) > TOLERANCIA_CONVERT) then
          pRegistrar(fDivergencia(Empresa, Linha.Item, TIPO_FEDERAL, Colunas[Posicao], '0',
            fTextoValor(Linha.Atuais[Posicao])), True);

      if not Logada then
        Continue;

      // PRECOM (RN02), menos os itens que receberam os valores do ultimo do grupo (RN23).
      if (PosPrecom >= 0) and not VarIsNull(Linha.PrecoCompraAntigo) and
        ((Linha.Grupo = '') or (Linha.Item = Linha.Ultimo)) then
      begin
        Esperado := fPrecoCompraConvertido(fNumeroConvert(Linha.PrecoCompraAntigo), Linha.Desconto, FDecimais);
        if Abs(Esperado - fNumeroConvert(Linha.Novos[PosPrecom])) > TOLERANCIA_CONVERT then
          pRegistrar(fDivergencia(Empresa, Linha.Item, TIPO_PRECOM, 'ITE_PRECOM', fNumeroTextoConvert(Esperado),
            fTextoValor(Linha.Novos[PosPrecom])), True);
      end;

      // Alertas: margem negativa ou preco zerado que tinha valor, nas tabelas ativas.
      for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
      begin
        if not fTabelaAtiva(Tabela) then
          Continue;
        if (PosMarbr[Tabela] >= 0) and (fNumeroConvert(Linha.Novos[PosMarbr[Tabela]]) < 0) then
          pRegistrar(fDivergencia(Empresa, Linha.Item, TIPO_ALERTA, Colunas[PosMarbr[Tabela]], '>= 0',
            fTextoValor(Linha.Novos[PosMarbr[Tabela]])), False);
        if (PosPreve[Tabela] >= 0) and (Abs(fNumeroConvert(Linha.Novos[PosPreve[Tabela]])) <= TOLERANCIA_CONVERT) and
          (Linha.PrecoVendaAntigo[Tabela] > TOLERANCIA_CONVERT) then
          pRegistrar(fDivergencia(Empresa, Linha.Item, TIPO_ALERTA, Colunas[PosPreve[Tabela]],
            fNumeroTextoConvert(Linha.PrecoVendaAntigo[Tabela]), '0'), False);
      end;
    end;

    // GRUPO (RN23): no mesmo grupo e na mesma empresa, todos com os valores do ultimo.
    Inicio := 0;
    while Inicio < Linhas.Count do
    begin
      Fim := Inicio;
      while (Fim + 1 < Linhas.Count) and (Linhas[Fim + 1].Grupo = Linhas[Inicio].Grupo) do
        Inc(Fim);

      if Linhas[Inicio].Grupo <> '' then
      begin
        TemReferencia := False;
        for Posicao := Inicio to Fim do
          if Linhas[Posicao].Item = Linhas[Posicao].Ultimo then
          begin
            Referencia := Linhas[Posicao];
            TemReferencia := True;
          end;

        if TemReferencia then
          for Posicao := Inicio to Fim do
          begin
            Linha := Linhas[Posicao];
            if Linha.Item = Referencia.Item then
              Continue;
            for Indice := 0 to High(Colunas) do
              if fValoresDiferentes(Colunas[Indice], Referencia.Novos[Indice], Linha.Novos[Indice]) then
              begin
                pRegistrar(fDivergencia(Empresa, Linha.Item, TIPO_GRUPO, Colunas[Indice],
                  fTextoValor(Referencia.Novos[Indice]), fTextoValor(Linha.Novos[Indice])), True);
                Break;
              end;
          end;
      end;

      Inicio := Fim + 1;
    end;
  finally
    Linhas.Free;
  end;
end;

// 150.x: a PREPRO (de onde o trigger leva ao ITEGER) tambem ficou com a ITEREF, tabela a tabela.
procedure TConferenciaConvert.pConferirPrePro(const Empresa: string);
const
  PARES: array[0..5, 0..1] of string = (
    ('PRO_PRECOM', 'ITE_PRECOM'), ('PRO_PRECUS', 'ITE_PRECUS'), ('PRO_IMPFED', 'ITE_IMPFED'),
    ('PRO_SUBFED', 'ITE_SUBFED'), ('PRO_DESOPE', 'ITE_DESOPE'), ('PRO_ICMSAI', 'ITE_ICMSAI'));
  FEDERAIS: array[0..2] of string = ('PRO_IMPFED', 'PRO_SUBFED', 'PRO_ALQFED');
var
  Sql: string;
  Par: Integer;
  Tabela: Integer;
  Federal: string;
  Consulta: IReformaConsulta;
  Item: string;
  NumeroTabela: Integer;
begin
  Sql := 'SELECT F.ITE_CODITE, P.PRO_NROTAB';
  for Par := Low(PARES) to High(PARES) do
    if FEstrutura.ColunaExiste('PREPRO', PARES[Par, 0]) and FEstrutura.TemColuna(PARES[Par, 1]) then
      Sql := Sql + ', P.' + PARES[Par, 0] + ', F.' + PARES[Par, 1];
  for Federal in FEDERAIS do
    if FEstrutura.ColunaExiste('PREPRO', Federal) and (Pos(', P.' + Federal + ',', Sql + ',') = 0) then
      Sql := Sql + ', P.' + Federal;
  Sql := Sql + ', P.PRO_PREVEN, P.PRO_MARBRU';
  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
    Sql := Sql + ', F.ITE_PREVE' + IntToStr(Tabela) + ', F.ITE_MARBR' + IntToStr(Tabela);
  Sql := Sql +
    ' FROM ITEREF F' +
    ' INNER JOIN PREPRO P ON P.PRO_CODEMP = F.ITE_CODEMP AND P.PRO_CODITE = F.ITE_CODITE' +
    ' WHERE F.REF_CHAVE = :CHAVE AND F.ITE_CODEMP = :CODEMP AND F.REF_APLICADO = ''S''' +
    ' ORDER BY F.ITE_CODITE, P.PRO_NROTAB';

  Consulta := FHost.AbrirConsulta(Sql);
  Consulta.DefinirParametro('CHAVE', FChave);
  Consulta.DefinirParametro('CODEMP', Empresa);
  Consulta.Abrir;
  while not Consulta.Fim do
  begin
    Item := fTextoConvert(Consulta.ValorCampo('ITE_CODITE'));
    NumeroTabela := Round(fNumeroConvert(Consulta.ValorCampo('PRO_NROTAB')));

    for Par := Low(PARES) to High(PARES) do
      if FEstrutura.ColunaExiste('PREPRO', PARES[Par, 0]) and FEstrutura.TemColuna(PARES[Par, 1]) and
        fNumerosDiferentes(Consulta.ValorCampo(PARES[Par, 1]), Consulta.ValorCampo(PARES[Par, 0])) then
        pRegistrar(fDivergencia(Empresa, Item, TIPO_PREPRO, PARES[Par, 0],
          fTextoValor(Consulta.ValorCampo(PARES[Par, 1])), fTextoValor(Consulta.ValorCampo(PARES[Par, 0]))), True);

    if (NumeroTabela >= 1) and (NumeroTabela <= QUANTIDADE_TABELAS_PRECO) then
    begin
      if fNumerosDiferentes(Consulta.ValorCampo('ITE_PREVE' + IntToStr(NumeroTabela)),
        Consulta.ValorCampo('PRO_PREVEN')) then
        pRegistrar(fDivergencia(Empresa, Item, TIPO_PREPRO, 'PRO_PREVEN' + IntToStr(NumeroTabela),
          fTextoValor(Consulta.ValorCampo('ITE_PREVE' + IntToStr(NumeroTabela))),
          fTextoValor(Consulta.ValorCampo('PRO_PREVEN'))), True);
      if fNumerosDiferentes(Consulta.ValorCampo('ITE_MARBR' + IntToStr(NumeroTabela)),
        Consulta.ValorCampo('PRO_MARBRU')) then
        pRegistrar(fDivergencia(Empresa, Item, TIPO_PREPRO, 'PRO_MARBRU' + IntToStr(NumeroTabela),
          fTextoValor(Consulta.ValorCampo('ITE_MARBR' + IntToStr(NumeroTabela))),
          fTextoValor(Consulta.ValorCampo('PRO_MARBRU'))), True);
    end;

    for Federal in FEDERAIS do
      if FEstrutura.ColunaExiste('PREPRO', Federal) and
        (Abs(fNumeroConvert(Consulta.ValorCampo(Federal))) > TOLERANCIA_CONVERT) then
        pRegistrar(fDivergencia(Empresa, Item, TIPO_FEDERAL, Federal, '0', fTextoValor(Consulta.ValorCampo(Federal))),
          True);

    Consulta.Proximo;
  end;
end;

// Alerta de desconto PIS/COFINS fora da faixa (RN02): lido de novo da REFPRE, para valer tambem no botao Conferir.
procedure TConferenciaConvert.pConferirDescontos(const Empresa: string);
var
  Consulta: IReformaConsulta;
begin
  Consulta := FHost.AbrirConsulta(
    'SELECT R.ITE_CODITE, R.ITE_DPISCO FROM REFPRE R' +
    ' INNER JOIN ITEREF F ON F.ITE_CODEMP = R.ITE_CODEMP AND F.ITE_CODITE = R.ITE_CODITE' +
    ' WHERE F.REF_CHAVE = :CHAVE AND F.ITE_CODEMP = :CODEMP AND (R.ITE_DPISCO < 0 OR R.ITE_DPISCO >= 100)' +
    ' ORDER BY R.ITE_CODITE');
  Consulta.DefinirParametro('CHAVE', FChave);
  Consulta.DefinirParametro('CODEMP', Empresa);
  Consulta.Abrir;
  while not Consulta.Fim do
  begin
    pRegistrar(fDivergencia(Empresa, fTextoConvert(Consulta.ValorCampo('ITE_CODITE')), TIPO_ALERTA, 'ITE_DPISCO',
      '0 <= x < 100', fTextoValor(Consulta.ValorCampo('ITE_DPISCO'))), False);
    Consulta.Proximo;
  end;
end;

// Item da logada que a empresa tem no ITEGER e ficou sem linha na ITEREF: o preco dela nao foi convertido. No 150.x e
// o item sem PREPRO na empresa (registro orfao: o cadastro grava a filial pela PREPRO e tambem o deixaria como esta).
procedure TConferenciaConvert.pConferirSemLinha(const Logada, Empresa: string);
var
  Consulta: IReformaConsulta;
begin
  Consulta := FHost.AbrirConsulta(
    'SELECT L.ITE_CODITE FROM ITEREF L' +
    ' INNER JOIN ITEGER G ON G.ITE_CODEMP = :EMPRESA AND G.ITE_CODITE = L.ITE_CODITE' +
    ' WHERE L.REF_CHAVE = :CHAVE AND L.ITE_CODEMP = :LOGADA' +
    '   AND NOT EXISTS (SELECT 1 FROM ITEREF F WHERE F.REF_CHAVE = L.REF_CHAVE AND F.ITE_CODEMP = G.ITE_CODEMP' +
    '                    AND F.ITE_CODITE = L.ITE_CODITE)' +
    ' ORDER BY L.ITE_CODITE');
  Consulta.DefinirParametro('EMPRESA', Empresa);
  Consulta.DefinirParametro('CHAVE', FChave);
  Consulta.DefinirParametro('LOGADA', Logada);
  Consulta.Abrir;
  while not Consulta.Fim do
  begin
    if FHost.UsaPrePro then
      pRegistrar(fDivergencia(Empresa, fTextoConvert(Consulta.ValorCampo('ITE_CODITE')), TIPO_ALERTA, 'SEM_PREPRO',
        'PREPRO na empresa', 'sem PREPRO: não convertido'), False)
    else
      pRegistrar(fDivergencia(Empresa, fTextoConvert(Consulta.ValorCampo('ITE_CODITE')), TIPO_ALERTA, 'SEM_LINHA',
        'linha na conversão', 'não convertido'), False);
    Consulta.Proximo;
  end;
end;

function TConferenciaConvert.fGravar: TResultadoGravacao;
var
  Comandos: TList<TComandoSql>;
  Divergencia: TDivergencia;
  Momento: TDateTime;
begin
  Momento := FHost.DataHora;
  Comandos := TList<TComandoSql>.Create;
  try
    Comandos.Add(fComandoConvert(
      'DELETE FROM REFDIV WHERE DIV_CHAVE = :CHAVE AND DIV_TIPO NOT IN (''' + TIPO_EXCLUIDO + ''', ''' +
      TIPO_ALTERADO + ''')', [fParametroConvert('CHAVE', FChave)]));
    for Divergencia in FDivergencias do
      Comandos.Add(fComandoDivergencia(FChave, Divergencia, Momento));
    Result := fGravarConvert(FHost, Comandos.ToArray);
  finally
    Comandos.Free;
  end;
end;

function TConferenciaConvert.Executar(const Progresso: IReformaProgresso): TResultadoGravacao;
var
  Indice: Integer;
  Logada: Boolean;
begin
  FDivergencias.Clear;
  FBloqueantes.Clear;
  FPorTipo.Clear;
  FAlertas := 0;

  Progresso.Definir('Conferindo', Length(FEmpresas) * 3 + 1);
  for Indice := 0 to High(FEmpresas) do
  begin
    Logada := Indice = 0;
    if Logada then
    begin
      pConferirContagem(FEmpresas[Indice]);
      pConferirDescontos(FEmpresas[Indice]);
    end;
    pConferirPendentes(FEmpresas[Indice]);
    if not Logada then
      pConferirSemLinha(FEmpresas[0], FEmpresas[Indice]);
    Progresso.Avancar(1);
    pConferirItens(FEmpresas[Indice], Logada);
    Progresso.Avancar(1);
    if FHost.UsaPrePro then
      pConferirPrePro(FEmpresas[Indice]);
    Progresso.Avancar(1);
  end;

  Result := fGravar;
  Progresso.Avancar(1);
end;

function TConferenciaConvert.Bloqueantes(const Empresa: string): Integer;
begin
  if not FBloqueantes.TryGetValue(Empresa, Result) then
    Result := 0;
end;

function TConferenciaConvert.TotalBloqueantes: Integer;
var
  Quantidade: Integer;
begin
  Result := 0;
  for Quantidade in FBloqueantes.Values do
    Inc(Result, Quantidade);
end;

end.
