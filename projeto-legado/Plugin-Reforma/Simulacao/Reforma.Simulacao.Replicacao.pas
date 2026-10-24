unit Reforma.Simulacao.Replicacao;

// REFTRI-01: a REFPRE acompanha o que o cadastro faz com os precos ao gravar o produto. O host diz quais empresas e
// itens a gravacao alcancou (as outras empresas e o grupo de preco ITE_CODGPR) e por qual regra
// (IReformaHost.AlvosReplicacao). Cada alvo recebe a linha dele na REFPRE pela mesma regra:
//  - trCopia: os campos iguais aos da empresa logada (grupo de preco, ou empresa sem CFG_INFMAT);
//  - trConfiguracaoPropria (CFG_INFMAT): desconto, precos e comissoes iguais. A despesa operacional e a da empresa
//    quando o host a manteve. A margem de cada tabela e refeita pelo custo do Calculo Novo daquela empresa, mantendo
//    o preco, com as configuracoes dela (ICalculoMargemHost.MargemNaEmpresa);
//  - trSoCusto (empresa fora do grupo de preco, alcancada porque a logada e a responsavel pelo fornecedor): so o
//    desconto PIS/COFINS, e a margem refeita quando o host a refaz. Sem linha na REFPRE nao ha o que acompanhar.
// Roda dentro da transacao da gravacao do produto, depois de o host gravar as outras empresas: o produto delas ja esta
// no banco (IReformaHost.ProdutoNaEmpresa).

interface

uses
  Reforma.Contrato.Tipos,
  Reforma.Contrato.Host,
  Reforma.Contrato.Gravacao,
  Reforma.Calculo.Modelo,
  Reforma.Calculo.Formacao,
  Reforma.Repositorio.Refpre;

type
  TReplicacaoRefpre = class
  strict private
    FHost: IReformaHost;
    FCalculo: ICalculoFormacao;
    FRefpre: TRepositorioRefpre;
    procedure pRecalcularMargens(const Alvo: TAlvoReplicacao; const Produto: IDadosProduto;
      const Aliquotas: TAliquotasReforma; var Valores: TValoresRefpre);
    function fValoresDoAlvo(const Alvo: TAlvoReplicacao; const Origem: TValoresRefpre;
      const Aliquotas: TAliquotasReforma; out Valores: TValoresRefpre): Boolean;
  public
    constructor Create(const Host: IReformaHost; const Calculo: ICalculoFormacao; const Refpre: TRepositorioRefpre);
    // Origem: a linha que a empresa logada acabou de gravar para CodigoItem.
    function Replicar(const CodigoItem: string; const Origem: TValoresRefpre;
      const Aliquotas: TAliquotasReforma): TResultadoGravacao;
  end;

implementation

uses
  System.SysUtils,
  System.Variants;

function fNumero(const Valor: Variant): Double;
begin
  if VarIsNull(Valor) or VarIsEmpty(Valor) then
    Result := 0
  else
    Result := VarAsType(Valor, varDouble);
end;

constructor TReplicacaoRefpre.Create(const Host: IReformaHost; const Calculo: ICalculoFormacao;
  const Refpre: TRepositorioRefpre);
begin
  inherited Create;
  FHost := Host;
  FCalculo := Calculo;
  FRefpre := Refpre;
end;

// Mesma conta da carga do lado Novo, com o produto da outra empresa: desconto PIS/COFINS, impostos federais zerados.
// Tabela sem preco informado (NULL) fica como esta.
procedure TReplicacaoRefpre.pRecalcularMargens(const Alvo: TAlvoReplicacao; const Produto: IDadosProduto;
  const Aliquotas: TAliquotasReforma; var Valores: TValoresRefpre);
var
  Formacao: TFormacaoCusto;
  Tabela: Integer;
begin
  Formacao := FCalculo.Carregar(Produto, lsFuturo, Aliquotas);
  Formacao.DescontoPisCofins := fNumero(Valores[TRepositorioRefpre.Indice('ITE_DPISCO')]);
  Formacao.DespesaOperacional := fNumero(Valores[TRepositorioRefpre.Indice('ITE_DESOPE')]);
  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
  begin
    Formacao.Tabelas[Tabela].PrecoVenda := fNumero(Valores[TRepositorioRefpre.Indice('ITE_PREVE' + IntToStr(Tabela))]);
    Formacao.Tabelas[Tabela].Comissao := fNumero(Valores[TRepositorioRefpre.Indice('ITE_COMTB' + IntToStr(Tabela))]);
    Formacao.Tabelas[Tabela].MargemBruta := fNumero(Valores[TRepositorioRefpre.Indice('ITE_MARBR' + IntToStr(Tabela))]);
  end;

  FCalculo.RecalcularMargensNaEmpresa(Formacao, Alvo.CodigoEmpresa, Alvo.CodigoItem);

  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
    if not VarIsNull(Valores[TRepositorioRefpre.Indice('ITE_PREVE' + IntToStr(Tabela))]) then
      Valores[TRepositorioRefpre.Indice('ITE_MARBR' + IntToStr(Tabela))] := Formacao.Tabelas[Tabela].MargemBruta;
end;

// False: nada a gravar para o alvo (o item nao existe na empresa, ou trSoCusto sem linha na REFPRE).
function TReplicacaoRefpre.fValoresDoAlvo(const Alvo: TAlvoReplicacao; const Origem: TValoresRefpre;
  const Aliquotas: TAliquotasReforma; out Valores: TValoresRefpre): Boolean;
var
  Existentes: TValoresRefpre;
  TemLinha: Boolean;
  Produto: IDadosProduto;
  Despesa: Integer;
  Desconto: Integer;
begin
  Result := False;
  Valores := Copy(Origem);
  if Alvo.Tipo = trCopia then
    Exit(True);

  Produto := FHost.ProdutoNaEmpresa(Alvo.CodigoEmpresa, Alvo.CodigoItem);
  if not Assigned(Produto) then
    Exit;

  Despesa := TRepositorioRefpre.Indice('ITE_DESOPE');
  Desconto := TRepositorioRefpre.Indice('ITE_DPISCO');
  TemLinha := FRefpre.LerValores(Alvo.CodigoEmpresa, Alvo.CodigoItem, Existentes);

  if Alvo.Tipo = trSoCusto then
  begin
    if not TemLinha then
      Exit;
    Valores := Existentes;
    Valores[Desconto] := Origem[Desconto];
  end
  else if Alvo.DespesaDaEmpresa then
  begin
    // A empresa ficou com a despesa dela no produto: a da linha dela, ou a do produto quando ainda nao tem linha.
    if TemLinha and not VarIsNull(Existentes[Despesa]) then
      Valores[Despesa] := Existentes[Despesa]
    else
      Valores[Despesa] := Produto.ValorNumerico('ITE_DESOPE');
  end;

  if Alvo.RecalculaMargem then
    pRecalcularMargens(Alvo, Produto, Aliquotas, Valores);

  Result := True;
end;

function TReplicacaoRefpre.Replicar(const CodigoItem: string; const Origem: TValoresRefpre;
  const Aliquotas: TAliquotasReforma): TResultadoGravacao;
var
  Alvos: TAlvosReplicacao;
  Alvo: TAlvoReplicacao;
  Valores: TValoresRefpre;
begin
  Result.Sucesso := True;
  Result.LinhasAfetadas := 0;
  Result.Mensagem := '';

  // Excecao do host (classe de outro modulo) nao e reconhecida aqui: vira falha, e o host desfaz a gravacao toda.
  try
    Alvos := FHost.AlvosReplicacao(CodigoItem);
    for Alvo in Alvos do
    begin
      if SameText(Alvo.CodigoEmpresa, FHost.CodigoEmpresa) and SameText(Alvo.CodigoItem, CodigoItem) then
        Continue;

      if not fValoresDoAlvo(Alvo, Origem, Aliquotas, Valores) then
        Continue;

      Result := FRefpre.GravarValores(Alvo.CodigoEmpresa, Alvo.CodigoItem, Valores);
      if not Result.Sucesso then
      begin
        Result.Mensagem := 'REFPRE da empresa ' + Alvo.CodigoEmpresa + ', item ' + Alvo.CodigoItem + ': ' +
          Result.Mensagem;
        Exit;
      end;
    end;
  except
    on E: Exception do
    begin
      Result.Sucesso := False;
      Result.Mensagem := 'Falha ao replicar a REFPRE: ' + E.Message;
    end
    else
    begin
      Result.Sucesso := False;
      Result.Mensagem := 'Falha ao replicar a REFPRE para as outras empresas e o grupo de preco.';
    end;
  end;
end;

end.
