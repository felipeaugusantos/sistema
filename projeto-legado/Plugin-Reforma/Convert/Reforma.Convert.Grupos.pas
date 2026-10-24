unit Reforma.Convert.Grupos;

// Grupos de preco do Convert (REFTRI-02, usuario, 2026-10-06): a conversao e por grupo, uma empresa por grupo (a que
// converte, como se estivesse logada) e as que usam o preco dela. Mesma fonte da coluna EMPRESAS_PRECO do
// TfrmMonitoramentoEmpresasPrecoMatriz (fRetEmpresasUsamPrecoMatriz do host, por IReformaConvertHost.EmpresasPrecoDe).
//  - conjunto igual ao de outra empresa aparece uma vez so; a empresa do grupo e a que nao usa o preco de outra
//    (EMP_PREMAT <> 'S'), e entre elas a de menor codigo;
//  - conjunto contido em outro some (a loja que so enxerga a si mesma ja esta no grupo da matriz);
//  - dois grupos que se cruzam sem um conter o outro (a mesma loja recebe o preco de mais de uma empresa) aparecem com
//    as lojas compartilhadas na observacao, mas nenhum dos dois pode ser convertido (usuario, 2026-10-07).

interface

uses
  Reforma.Contrato.Convert;

type
  TGrupoPreco = record
    // A que converte (colEmpCodigo).
    Empresa: string;
    // A do grupo primeiro, depois as que usam o preco dela, em ordem de codigo.
    Empresas: TArray<string>;
    // Vazio, ou por que o grupo nao pode ser convertido (configuracao).
    Bloqueio: string;
    // Lojas do grupo que tambem estao em outro grupo ('001, 003'), vazio se nenhuma.
    Compartilhadas: string;
  end;

  TGruposPreco = TArray<TGrupoPreco>;

// Todos os grupos do CADEMP, em ordem de codigo da empresa do grupo.
function fMontarGruposPreco(const Host: IReformaConvertHost): TGruposPreco;
// '001_002_003', como a coluna EMPRESAS_PRECO.
function fTextoEmpresasPreco(const Grupo: TGrupoPreco): string;
// EMPRESAS_NESTE_SERVIDOR (a mesma regra de fEmpresaNesteServidor do host): sem a tabela, todas estao no servidor.
function fEmpresasNoServidor(const Host: IReformaConvertHost): TArray<string>;
function fNoServidor(const Empresas: TArray<string>; const Empresa: string): Boolean;

implementation

uses
  System.SysUtils,
  System.Types,
  System.StrUtils,
  System.Generics.Collections,
  System.Generics.Defaults,
  Reforma.Contrato.Host,
  Reforma.Convert.Estrutura;

type
  TEmpresaPreco = record
    Codigo: string;
    UsaPrecoMatriz: Boolean;
    Conjunto: TArray<string>;
    Chave: string;
  end;

function fOrdenado(const Lista: TArray<string>): TArray<string>;
begin
  Result := Copy(Lista);
  TArray.Sort<string>(Result);
end;

function fContem(const Lista: TArray<string>; const Valor: string): Boolean;
var
  Item: string;
begin
  Result := False;
  for Item in Lista do
    if Item = Valor then
      Exit(True);
end;

// A contem B (todos os de B estao em A).
function fContemTodos(const A, B: TArray<string>): Boolean;
var
  Item: string;
begin
  Result := True;
  for Item in B do
    if not fContem(A, Item) then
      Exit(False);
end;

// As empresas de B que tambem estao em A.
function fComuns(const A, B: TArray<string>): TArray<string>;
var
  Item: string;
begin
  Result := nil;
  for Item in B do
    if fContem(A, Item) then
      Result := Result + [Item];
end;

function fConjunto(const Host: IReformaConvertHost; const Empresa: string): TArray<string>;
var
  Parte: string;
begin
  Result := [Empresa];
  for Parte in SplitString(Host.EmpresasPrecoDe(Empresa), ';_') do
    if (Trim(Parte) <> '') and not fContem(Result, Trim(Parte)) then
      Result := Result + [Trim(Parte)];
  Result := fOrdenado(Result);
end;

function fTextoEmpresasPreco(const Grupo: TGrupoPreco): string;
var
  Empresa: string;
begin
  Result := '';
  for Empresa in Grupo.Empresas do
  begin
    if Result <> '' then
      Result := Result + '_';
    Result := Result + Empresa;
  end;
end;

function fEmpresasNoServidor(const Host: IReformaConvertHost): TArray<string>;
var
  Consulta: IReformaConsulta;
begin
  Result := nil;
  Consulta := Host.AbrirConsulta('SELECT COUNT(*) AS QTD FROM information_schema.TABLES ' +
    'WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = :TABELA');
  Consulta.DefinirParametro('TABELA', 'EMPRESAS_NESTE_SERVIDOR');
  Consulta.Abrir;
  if fNumeroConvert(Consulta.ValorCampo('QTD')) = 0 then
  begin
    // Sem a tabela: todas (Result fica com '*').
    Result := ['*'];
    Exit;
  end;

  Consulta := Host.AbrirConsulta('SELECT SRV_CODEMP FROM EMPRESAS_NESTE_SERVIDOR');
  Consulta.Abrir;
  while not Consulta.Fim do
  begin
    Result := Result + [Trim(fTextoConvert(Consulta.ValorCampo('SRV_CODEMP')))];
    Consulta.Proximo;
  end;
end;

function fNoServidor(const Empresas: TArray<string>; const Empresa: string): Boolean;
begin
  Result := fContem(Empresas, '*') or fContem(Empresas, Empresa);
end;

function fMontarGruposPreco(const Host: IReformaConvertHost): TGruposPreco;
var
  Consulta: IReformaConsulta;
  Empresas: TList<TEmpresaPreco>;
  Empresa: TEmpresaPreco;
  Candidatas: TDictionary<string, TEmpresaPreco>;
  Escolhida: TEmpresaPreco;
  Grupos: TList<TGrupoPreco>;
  Grupo: TGrupoPreco;
  Conjuntos: TArray<TArray<string>>;
  Indice: Integer;
  Outro: Integer;
  Contido: Boolean;
  Lista: TArray<TGrupoPreco>;
  Compartilhadas: TArray<string>;
  Codigo: string;
begin
  Empresas := TList<TEmpresaPreco>.Create;
  Candidatas := nil;
  Grupos := nil;
  try
    Candidatas := TDictionary<string, TEmpresaPreco>.Create;
    Grupos := TList<TGrupoPreco>.Create;
    Consulta := Host.AbrirConsulta('SELECT EMP_CODEMP, EMP_PREMAT FROM CADEMP ORDER BY EMP_CODEMP');
    Consulta.Abrir;
    while not Consulta.Fim do
    begin
      Empresa.Codigo := Trim(fTextoConvert(Consulta.ValorCampo('EMP_CODEMP')));
      Empresa.UsaPrecoMatriz := SameText(fTextoConvert(Consulta.ValorCampo('EMP_PREMAT')), 'S');
      Empresas.Add(Empresa);
      Consulta.Proximo;
    end;
    Consulta := nil;

    // Um candidato por conjunto: a que nao usa o preco de outra; empate, a de menor codigo (a lista ja esta em ordem).
    for Indice := 0 to Empresas.Count - 1 do
    begin
      Empresa := Empresas[Indice];
      Empresa.Conjunto := fConjunto(Host, Empresa.Codigo);
      Empresa.Chave := string.Join('_', Empresa.Conjunto);
      if not Candidatas.TryGetValue(Empresa.Chave, Escolhida) or
        (Escolhida.UsaPrecoMatriz and not Empresa.UsaPrecoMatriz) then
        Candidatas.AddOrSetValue(Empresa.Chave, Empresa);
    end;

    // Conjunto contido em outro maior some.
    Conjuntos := nil;
    for Escolhida in Candidatas.Values do
      Conjuntos := Conjuntos + [Escolhida.Conjunto];
    for Escolhida in Candidatas.Values do
    begin
      Contido := False;
      for Indice := 0 to High(Conjuntos) do
        if (Length(Conjuntos[Indice]) > Length(Escolhida.Conjunto)) and
          fContemTodos(Conjuntos[Indice], Escolhida.Conjunto) then
        begin
          Contido := True;
          Break;
        end;
      if Contido then
        Continue;

      Grupo.Empresa := Escolhida.Codigo;
      Grupo.Empresas := [Escolhida.Codigo];
      for Indice := 0 to High(Escolhida.Conjunto) do
        if Escolhida.Conjunto[Indice] <> Escolhida.Codigo then
          Grupo.Empresas := Grupo.Empresas + [Escolhida.Conjunto[Indice]];
      Grupo.Bloqueio := '';
      Grupo.Compartilhadas := '';
      if Escolhida.UsaPrecoMatriz then
        Grupo.Bloqueio := 'A empresa usa o preço de outra (EMP_PREMAT = S) e não está no grupo de nenhuma matriz.';
      Grupos.Add(Grupo);
    end;

    Lista := Grupos.ToArray;
    TArray.Sort<TGrupoPreco>(Lista, TComparer<TGrupoPreco>.Construct(
      function(const A, B: TGrupoPreco): Integer
      begin
        Result := CompareStr(A.Empresa, B.Empresa);
      end));

    // Grupos que se cruzam sem um conter o outro: a mesma loja recebe o preco de mais de uma empresa (REPPRC = 2 sem
    // INFMAT: toda empresa replica o preco para as mesmas lojas). O grupo aparece com as lojas compartilhadas e nao
    // pode ser convertido (usuario, 2026-10-07: a tela nao deixa marcar).
    for Indice := 0 to High(Lista) do
    begin
      Compartilhadas := nil;
      for Outro := 0 to High(Lista) do
        if Indice <> Outro then
          for Codigo in fComuns(Lista[Indice].Empresas, Lista[Outro].Empresas) do
            if not fContem(Compartilhadas, Codigo) then
              Compartilhadas := Compartilhadas + [Codigo];
      Lista[Indice].Compartilhadas := string.Join(', ', fOrdenado(Compartilhadas));
    end;

    Result := Lista;
  finally
    Grupos.Free;
    Candidatas.Free;
    Empresas.Free;
  end;
end;

end.
