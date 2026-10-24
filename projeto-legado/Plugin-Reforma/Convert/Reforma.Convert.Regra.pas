unit Reforma.Convert.Regra;

// RN09 (REFTRI-02, regra do usuario de 2026-10-05): preco de venda x margem da conversao. Unico ponto da regra.
//  - O custo novo vem do preco de compra do ITEGER com o desconto PIS/COFINS 2027 da REFPRE e dos federais zerados
//    (RN02, RN05); o host o calcula pelo motor nativo.
//  - Recalcular Margem: o preco de venda atual do ITEGER passa a ser o preco com CBS/IBS/IS; o preco novo e ele sem
//    esses impostos, a mesma conta de TCalculadoraPrecoCliente.fAtualizaPrecoVenda do host. A margem e recalculada.
//  - Recalcular Preco de Venda: a margem fica a do ITEGER e o preco de venda e recalculado com o custo novo
//    (mtcMantemMargem; correcao do usuario em 2026-10-05, antes mantinha o preco).
// Em Recalcular Margem o host recebe o preco (mtcMantemPreco) e calcula a margem; em Recalcular Preco de Venda recebe
// a margem e calcula o preco. As aliquotas vem da IMPTRI (tabela estatica) ou da procedure
// pRefTrib_CalculaAliquotasEfetivasItens (abreviacao do item), conforme a tela.

interface

uses
  Reforma.Contrato.Tipos,
  Reforma.Contrato.Convert;

const
  REGRA_PRECO_DEFINIDA = True;

type
  // Valor da REFPRE de uma tabela: Existe = False quando nao ha linha, nao ha coluna ou o valor e NULL.
  TValorRefpre = record
    Existe: Boolean;
    Valor: Double;
  end;

  TValoresRefpreTabelas = array[1..QUANTIDADE_TABELAS_PRECO] of TValorRefpre;

  // Dados do item na empresa logada antes da conversao: ITEGER atual e REFPRE (quando houver).
  TItemOrigemConversao = record
    CodigoItem: string;
    IcmsSaida: Double;
    PrecoVendaAtual: TValoresTabelasConversao;
    MargemAtual: TValoresTabelasConversao;
    ComissaoAtual: TValoresTabelasConversao;
    ComissaoRefpre: TValoresRefpreTabelas;
    // Recalcular Preco de Venda: a margem da REFPRE, quando houver, no lugar da do ITEGER (usuario, 2026-10-06).
    MargemRefpre: TValoresRefpreTabelas;
  end;

  TComissoesConversao = TValoresTabelasConversao;

  IRegraPrecoConversao = interface
    ['{DB87D3D4-A08B-4BF3-8413-FC6A964B2363}']
    function Alvos(const Item: TItemOrigemConversao; const Opcao: TOpcaoConversao;
      const Aliquotas: TAliquotasReforma): TAlvosConversao;
    // Comissao de cada tabela: REFPRE se houver, senao a atual do ITEGER.
    function Comissoes(const Item: TItemOrigemConversao): TComissoesConversao;
  end;

  TRegraPrecoRefpre = class(TInterfacedObject, IRegraPrecoConversao)
  public
    function Alvos(const Item: TItemOrigemConversao; const Opcao: TOpcaoConversao;
      const Aliquotas: TAliquotasReforma): TAlvosConversao;
    function Comissoes(const Item: TItemOrigemConversao): TComissoesConversao;
  end;

function fRegraPreco: IRegraPrecoConversao;

// RN02: novo preco de compra com o desconto PIS/COFINS (percentual). Mesma conta de TCalculoFormacao.PrecoComDesconto
// e da calculadora: fora de 0 < x < 100 o preco fica como esta, sem arredondar.
function fPrecoCompraConvertido(const PrecoCompra, DescontoPisCofins: Double; const Decimais: Integer): Double;

// Preco sem CBS/IBS/IS a partir do preco com eles: TCalculadoraPrecoCliente.fAtualizaPrecoVenda (RN05 do Req. 463837).
function fPrecoSemImpostosReforma(const PrecoComImpostos, IcmsSaida: Double; const Aliquotas: TAliquotasReforma): Double;

// Payload de pRefTrib_CalculaAliquotasEfetivasItens para um item (Convert e aba 4).
function fJsonItemAliquota(const Empresa, Item, Ncm, NcmExcecao, Abreviacao: string): string;

implementation

uses
  System.Math,
  System.JSON;

function fPrecoCompraConvertido(const PrecoCompra, DescontoPisCofins: Double; const Decimais: Integer): Double;
begin
  if (DescontoPisCofins <= 0) or (DescontoPisCofins >= 100) then
    Result := PrecoCompra
  else
    Result := RoundTo(PrecoCompra * (1 - DescontoPisCofins / 100), -Decimais);
end;

function fPrecoSemImpostosReforma(const PrecoComImpostos, IcmsSaida: Double; const Aliquotas: TAliquotasReforma): Double;
begin
  Result := RoundTo(PrecoComImpostos /
    (1 + (1 - IcmsSaida / 100) * ((Aliquotas.Cbs + Aliquotas.Ibs + Aliquotas.ImpostoSeletivo) / 100)), -4);
end;

// Mesmo payload de TCalculadoraPrecoCliente.pCarregaAliquotas do host (um item por chamada, como no cadastro).
function fJsonItemAliquota(const Empresa, Item, Ncm, NcmExcecao, Abreviacao: string): string;
var
  Itens: TJSONArray;
  Linha: TJSONObject;
begin
  Itens := TJSONArray.Create;
  try
    Linha := TJSONObject.Create;
    Linha.AddPair('empresa', Empresa);
    Linha.AddPair('id_item', Item);
    Linha.AddPair('codigo_item', Item);
    Linha.AddPair('ncm', Ncm);
    Linha.AddPair('ncm_excecao', NcmExcecao);
    if Abreviacao <> '' then
      Linha.AddPair('codabf', Abreviacao);
    Itens.AddElement(Linha);
    Result := Itens.ToJSON;
  finally
    Itens.Free;
  end;
end;

function fRegraPreco: IRegraPrecoConversao;
begin
  Result := TRegraPrecoRefpre.Create;
end;

function TRegraPrecoRefpre.Alvos(const Item: TItemOrigemConversao; const Opcao: TOpcaoConversao;
  const Aliquotas: TAliquotasReforma): TAlvosConversao;
var
  Tabela: Integer;
begin
  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
  begin
    if Opcao = ocvRecalcularMargem then
    begin
      Result[Tabela].Modo := mtcMantemPreco;
      Result[Tabela].Valor := fPrecoSemImpostosReforma(Item.PrecoVendaAtual[Tabela], Item.IcmsSaida, Aliquotas);
    end
    else
    begin
      Result[Tabela].Modo := mtcMantemMargem;
      // Margem da REFPRE se houver, senao a do ITEGER, como a comissao (usuario, 2026-10-06).
      if Item.MargemRefpre[Tabela].Existe then
        Result[Tabela].Valor := Item.MargemRefpre[Tabela].Valor
      else
        Result[Tabela].Valor := Item.MargemAtual[Tabela];
    end;
  end;
end;

function TRegraPrecoRefpre.Comissoes(const Item: TItemOrigemConversao): TComissoesConversao;
var
  Tabela: Integer;
begin
  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
    if Item.ComissaoRefpre[Tabela].Existe then
      Result[Tabela] := Item.ComissaoRefpre[Tabela].Valor
    else
      Result[Tabela] := Item.ComissaoAtual[Tabela];
end;

end.
