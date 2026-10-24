unit Reforma.Repositorio.Conversao;

// REFTRI-03: o que a conversao (REFTRI-02) fez com o produto, para a aba 2 mostrar com CFG_REFCIS = 'S'. Antes e a
// ITEREO (valores de antes da conversao) e Apos e a ITEREF (valores aplicados). Somente leitura, pela consulta do host
// (so SELECT, com parametros); nada aqui grava.
//
// Linha lida: a da empresa logada na ultima conversao aplicada ao item - ITEREF com REF_APLICADO = 'S' e maior REF_ID.
// A chave unica e REF_CHAVE + empresa + item: uma filial pode ter entrado na conversao de mais de uma matriz. A ITEREO
// e a do mesmo REF_CHAVE, para os dois lados sairem da mesma conversao.
//
// Os datasets tem a estrutura de campos da simulacao (pCriarCamposFormacao): a aba 2 liga neles os mesmos controles.
// Coluna que a tabela daquela base nao tem (Suframa, por exemplo) ou que veio NULL fica 0 (ITE_PREDOL fica 'N').
// As colunas existentes sao lidas do information_schema uma vez, na primeira carga.

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  UniClientDataSet,
  Reforma.Contrato.Host;

type
  TConsultaConversao = class
  strict private
    FHost: IReformaHost;
    FAntes: TUniClientDataSet;
    FApos: TUniClientDataSet;
    // Colunas de cada tabela que tambem sao campos do dataset, na ordem do dataset.
    FColunasAntes: TArray<string>;
    FColunasApos: TArray<string>;
    FColunasLidas: Boolean;
    // Item da ultima carga com sucesso; Carregar do mesmo item nao refaz o SELECT.
    FCodigoItem: string;
    FCarregado: Boolean;
    procedure pLerColunas;
    function fColunasDaTabela(const Existentes: TDictionary<string, Boolean>; const Tabela: string;
      const Dados: TUniClientDataSet): TArray<string>;
    function fLerApos(const CodigoItem: string; out Chave: string): Boolean;
    function fLerAntes(const CodigoItem, Chave: string): Boolean;
    procedure pCopiar(const Consulta: IReformaConsulta; const Colunas: TArray<string>; const Dados: TUniClientDataSet);
    procedure pEsvaziar;
  public
    constructor Create(const Host: IReformaHost);
    destructor Destroy; override;
    // Le a ITEREF e a ITEREO do item. False quando nao ha linha na ITEREF (os dois datasets ficam vazios) ou a
    // leitura falhou; nenhuma excecao sai daqui.
    function Carregar(const CodigoItem: string): Boolean;
    // A proxima Carregar le de novo, mesmo para o mesmo item.
    procedure Invalidar;
    property Antes: TUniClientDataSet read FAntes;
    property Apos: TUniClientDataSet read FApos;
  end;

implementation

uses
  System.Variants,
  Data.DB,
  Reforma.Repositorio.Estrutura,
  Reforma.Simulacao.Modelo;

const
  TABELA_ANTES = 'ITEREO';
  TABELA_APOS = 'ITEREF';

constructor TConsultaConversao.Create(const Host: IReformaHost);
begin
  inherited Create;
  FHost := Host;
  FAntes := TUniClientDataSet.Create(nil);
  pCriarCamposFormacao(FAntes);
  FApos := TUniClientDataSet.Create(nil);
  pCriarCamposFormacao(FApos);
end;

destructor TConsultaConversao.Destroy;
begin
  FreeAndNil(FApos);
  FreeAndNil(FAntes);
  inherited Destroy;
end;

// So as colunas da lista fixa do plugin (COLUNAS_ITEGER e COLUNAS_PROPRIAS) que existem na tabela e no dataset: os
// nomes no SQL nunca vem de fora.
function TConsultaConversao.fColunasDaTabela(const Existentes: TDictionary<string, Boolean>; const Tabela: string;
  const Dados: TUniClientDataSet): TArray<string>;
var
  Coluna: string;
  Lista: TList<string>;
begin
  Lista := TList<string>.Create;
  try
    Lista.AddRange(COLUNAS_ITEGER);
    Lista.AddRange(COLUNAS_PROPRIAS);
    Result := nil;
    for Coluna in Lista do
      if Existentes.ContainsKey(Tabela + '.' + Coluna) and Assigned(Dados.FindField(Coluna)) then
        Result := Result + [Coluna];
  finally
    Lista.Free;
  end;
end;

procedure TConsultaConversao.pLerColunas;
var
  Consulta: IReformaConsulta;
  Existentes: TDictionary<string, Boolean>;
begin
  Existentes := TDictionary<string, Boolean>.Create;
  try
    Consulta := FHost.AbrirConsulta(
      'SELECT TABLE_NAME, COLUMN_NAME FROM information_schema.COLUMNS ' +
      'WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME IN (:ANTES, :APOS)');
    Consulta.DefinirParametro('ANTES', TABELA_ANTES);
    Consulta.DefinirParametro('APOS', TABELA_APOS);
    Consulta.Abrir;
    while not Consulta.Fim do
    begin
      Existentes.AddOrSetValue(UpperCase(VarToStr(Consulta.ValorCampo('TABLE_NAME')) + '.' +
        VarToStr(Consulta.ValorCampo('COLUMN_NAME'))), True);
      Consulta.Proximo;
    end;

    FColunasAntes := fColunasDaTabela(Existentes, TABELA_ANTES, FAntes);
    FColunasApos := fColunasDaTabela(Existentes, TABELA_APOS, FApos);
    FColunasLidas := True;
  finally
    Existentes.Free;
  end;
end;

procedure TConsultaConversao.pEsvaziar;
begin
  FAntes.EmptyDataSet;
  FApos.EmptyDataSet;
end;

procedure TConsultaConversao.pCopiar(const Consulta: IReformaConsulta; const Colunas: TArray<string>;
  const Dados: TUniClientDataSet);
var
  Indice: Integer;
  Campo: TField;
  Coluna: string;
  Valor: Variant;
begin
  Dados.Append;
  for Indice := 0 to Dados.FieldCount - 1 do
  begin
    Campo := Dados.Fields[Indice];
    if Campo.DataType = ftString then
      Campo.AsString := 'N'
    else
      Campo.AsFloat := 0;
  end;

  for Coluna in Colunas do
  begin
    Valor := Consulta.ValorCampo(Coluna);
    if VarIsNull(Valor) or VarIsEmpty(Valor) then
      Continue;

    Campo := Dados.FieldByName(Coluna);
    if Campo.DataType = ftString then
      Campo.AsString := VarToStr(Valor)
    else
      Campo.AsFloat := VarAsType(Valor, varDouble);
  end;
  Dados.Post;
end;

function TConsultaConversao.fLerApos(const CodigoItem: string; out Chave: string): Boolean;
var
  Consulta: IReformaConsulta;
begin
  Chave := '';
  Result := False;
  if Length(FColunasApos) = 0 then
    Exit;

  Consulta := FHost.AbrirConsulta('SELECT REF_CHAVE, ' + string.Join(', ', FColunasApos) + ' FROM ' + TABELA_APOS +
    ' WHERE ITE_CODEMP = :CODEMP AND ITE_CODITE = :CODITE AND REF_APLICADO = ''S''' +
    ' ORDER BY REF_ID DESC LIMIT 1');
  Consulta.DefinirParametro('CODEMP', FHost.CodigoEmpresa);
  Consulta.DefinirParametro('CODITE', CodigoItem);
  Consulta.Abrir;
  if Consulta.Vazia then
    Exit;

  Chave := VarToStr(Consulta.ValorCampo('REF_CHAVE'));
  pCopiar(Consulta, FColunasApos, FApos);
  Result := True;
end;

function TConsultaConversao.fLerAntes(const CodigoItem, Chave: string): Boolean;
var
  Consulta: IReformaConsulta;
begin
  Result := False;
  if Length(FColunasAntes) = 0 then
    Exit;

  Consulta := FHost.AbrirConsulta('SELECT ' + string.Join(', ', FColunasAntes) + ' FROM ' + TABELA_ANTES +
    ' WHERE REF_CHAVE = :CHAVE AND ITE_CODEMP = :CODEMP AND ITE_CODITE = :CODITE');
  Consulta.DefinirParametro('CHAVE', Chave);
  Consulta.DefinirParametro('CODEMP', FHost.CodigoEmpresa);
  Consulta.DefinirParametro('CODITE', CodigoItem);
  Consulta.Abrir;
  if Consulta.Vazia then
    Exit;

  pCopiar(Consulta, FColunasAntes, FAntes);
  Result := True;
end;

function TConsultaConversao.Carregar(const CodigoItem: string): Boolean;
var
  Chave: string;
begin
  if FCarregado and (FCodigoItem = CodigoItem) then
    Exit(not FApos.IsEmpty);

  Result := False;
  FCarregado := False;
  try
    pEsvaziar;
    // Inclusao: o item ainda nao tem codigo e nao ha conversao dele (RF07, grupos em branco).
    if CodigoItem <> '' then
    begin
      if not FColunasLidas then
        pLerColunas;
      // Sem a ITEREF nao ha conversao do item: a ITEREO nem e lida e os dois grupos ficam em branco.
      Result := fLerApos(CodigoItem, Chave);
      if Result then
        fLerAntes(CodigoItem, Chave);
      pAplicarFormatosFormacao(FAntes, FHost.Produto);
      pAplicarFormatosFormacao(FApos, FHost.Produto);
    end;
    FCodigoItem := CodigoItem;
    FCarregado := True;
  except
    // Excecao do host e de outra classe (outro modulo): a falha deixa os grupos em branco, sem derrubar o cadastro,
    // e a proxima entrada na aba tenta de novo.
    Result := False;
    try
      pEsvaziar;
    except
      // Dataset em memoria; nada a fazer se nem isto der.
    end;
  end;
end;

procedure TConsultaConversao.Invalidar;
begin
  FCarregado := False;
  FCodigoItem := '';
end;

end.
