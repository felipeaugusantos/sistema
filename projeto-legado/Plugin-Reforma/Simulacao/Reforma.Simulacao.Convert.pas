unit Reforma.Simulacao.Convert;

// Aba 4 "Calculo Convert" (usuario, 2026-10-06): o que o Convert gravaria para o produto em tela, para o operador 998
// conferir antes de converter e, depois da conversao, comparar com a aba 1.
//  - A base e a aba 3 em memoria: preco de compra, desconto PIS/COFINS 2027, despesa operacional, comissoes, ICMS de
//    saida e os demais campos de custo. Excecao: preco de venda e margem atuais vem da aba 1, porque o Convert parte do
//    ITEGER e nao dos precos simulados na aba 3 (RN09).
//  - A regra e a do Convert (Reforma.Convert.Regra: desconto, alvos dos radios, comissao) e a conta e a do host
//    (IReformaCalculoConvert.CalcularItemBase, o mesmo CalcularItem da Fase P, so a empresa logada).
//  - Na aba 3 os parametros digitados valem mesmo sem linha na REFPRE: o produto sem REFPRE tem na aba 3 a despesa e
//    as comissoes do proprio produto, que sao as que o Convert usa nesse caso.

interface

uses
  Reforma.Contrato.Host,
  Reforma.Contrato.Convert,
  Reforma.Calculo.Modelo,
  Reforma.Convert.Processo,
  Reforma.Simulacao.Modelo;

// Operador 998, empresa ainda nao convertida (CFG_REFCIS = 'N') e host com o calculo do Convert.
function fAba4Disponivel(const Host: IReformaHost): Boolean;

// Formacao com os valores do Convert (antes do que a tela deriva deles: ver TSimulacaoReforma.MostrarConvert). False
// devolve o motivo em Mensagem.
function fCalcularConvertProduto(const Host: IReformaHost; const Aba3: TSimulacaoReforma;
  const Opcao: TOpcaoConversao; const Origem: TOrigemImpostosConversao; out Formacao: TFormacaoCusto;
  out Mensagem: string): Boolean;

implementation

uses
  System.SysUtils,
  Data.DB,
  Reforma.Contrato.Tipos,
  Reforma.Contrato.Gravacao,
  Reforma.Convert.Regra,
  Reforma.Convert.Estrutura;

const
  OPERADOR_CALCULO_CONVERT = '998';

  // Campos de custo da aba 3 que entram no lugar dos gravados, pelo nome do ITEGER.
  CAMPOS_BASE: array[0..21] of string = (
    'ITE_PRECOM', 'ITE_DESF01', 'ITE_DESF02', 'ITE_DESF03', 'ITE_DESF04', 'ITE_DESF05', 'ITE_DESF06',
    'ITE_ICMENT', 'ITE_IPIENT', 'ITE_FREENT', 'ITE_VALFRE', 'ITE_ACRFIN', 'ITE_SUBSTI', 'ITE_DESADB',
    'ITE_TCIFCU', 'ITE_TSCUST', 'ITE_DEPICO', 'ITE_DEICMS', 'ITE_FATREG', 'ITE_OUTVAL', 'ITE_ICMSAI',
    'ITE_DESOPE');

function fAba4Disponivel(const Host: IReformaHost): Boolean;
var
  Calculo: IReformaCalculoConvert;
begin
  Result := Assigned(Host) and Supports(Host, IReformaCalculoConvert, Calculo) and
    (Trim(Calculo.Operador) = OPERADOR_CALCULO_CONVERT) and not Host.ConfiguracaoBooleana('REFCIS');
end;

// As mesmas fontes da Fase P: 1a linha da IMPTRI (tabela estatica) ou a procedure pela abreviacao do item.
function fAliquotas(const Host: IReformaHost; const Item: string; const Origem: TOrigemImpostosConversao;
  out Aliquotas: TAliquotasReforma; out Mensagem: string): Boolean;
var
  Consulta: IReformaConsulta;
  Abreviacao: string;
  Json: string;
begin
  Result := False;
  Mensagem := '';
  Aliquotas.Cbs := 0;
  Aliquotas.Ibs := 0;
  Aliquotas.ImpostoSeletivo := 0;

  if Origem = oicTabelaEstatica then
  begin
    // Sem linha, ou campo nulo, a aliquota e zero.
    Consulta := Host.AbrirConsulta('SELECT CBS, IBS, `IS` FROM IMPTRI LIMIT 1');
    Consulta.Abrir;
    if not Consulta.Vazia then
    begin
      Aliquotas.Cbs := fNumeroConvert(Consulta.ValorCampo('CBS'));
      Aliquotas.Ibs := fNumeroConvert(Consulta.ValorCampo('IBS'));
      Aliquotas.ImpostoSeletivo := fNumeroConvert(Consulta.ValorCampo('IS'));
    end;
    Exit(True);
  end;

  Consulta := Host.AbrirConsulta('SELECT ITE_CLAIPI, ITE_EXCIPI, ITE_EXCBFR, ITE_ABFREF FROM CADITE ' +
    'WHERE ITE_CODITE = :CODITE');
  Consulta.DefinirParametro('CODITE', Item);
  Consulta.Abrir;
  if Consulta.Vazia then
  begin
    Mensagem := 'Grave o produto para simular a conversão.';
    Exit;
  end;
  // Mesmo filtro do cadastro: a abreviacao da reforma so vai quando o item tem a excecao marcada.
  Abreviacao := '';
  if fTextoConvert(Consulta.ValorCampo('ITE_EXCBFR')) = 'S' then
    Abreviacao := fTextoConvert(Consulta.ValorCampo('ITE_ABFREF'));
  Json := fJsonItemAliquota(Host.CodigoEmpresa, Item, fTextoConvert(Consulta.ValorCampo('ITE_CLAIPI')),
    fTextoConvert(Consulta.ValorCampo('ITE_EXCIPI')), Abreviacao);

  Consulta := Host.AbrirConsulta('CALL pRefTrib_CalculaAliquotasEfetivasItens(CAST(:PITENS AS JSON))');
  Consulta.DefinirParametro('PITENS', Json);
  Consulta.Abrir;
  if Consulta.Vazia then
    Mensagem := 'A procedure não devolveu alíquota para o item: a conversão pararia nele.'
  else if fTextoConvert(Consulta.ValorCampo('RET_STATUS')) <> 'CALCULADO' then
    Mensagem := 'Sem alíquota pela abreviação do item (a conversão pararia nele): ' +
      fTextoConvert(Consulta.ValorCampo('RET_MENSAGEM'))
  else
  begin
    Aliquotas.Cbs := fNumeroConvert(Consulta.ValorCampo('ALQ_CBS_EFETIVA'));
    Aliquotas.Ibs := fNumeroConvert(Consulta.ValorCampo('ALQ_IBS_TOTAL_EFETIVA'));
    Aliquotas.ImpostoSeletivo := fNumeroConvert(Consulta.ValorCampo('RTE_ALIQIS'));
    Result := True;
  end;
end;

function fCampoBase(const Nome: string; const Valor: Variant): TValorCampo;
begin
  Result.Nome := Nome;
  Result.Valor := Valor;
end;

function fCalcularConvertProduto(const Host: IReformaHost; const Aba3: TSimulacaoReforma;
  const Opcao: TOpcaoConversao; const Origem: TOrigemImpostosConversao; out Formacao: TFormacaoCusto;
  out Mensagem: string): Boolean;
var
  Calculo: IReformaCalculoConvert;
  Produto: IDadosProduto;
  Dados: TDataSet;
  Desconto: Double;
  Aliquotas: TAliquotasReforma;
  Item: TItemOrigemConversao;
  Regra: IRegraPrecoConversao;
  Entrada: TEntradaConversao;
  Base: TArray<TValorCampo>;
  Valores: TValoresConversao;
  Resultado: TResultadoGravacao;
  Campo: string;
  Sufixo: string;
  Tabela: Integer;
begin
  Result := False;
  Mensagem := '';
  FillChar(Formacao, SizeOf(Formacao), 0);
  try
    if not Supports(Host, IReformaCalculoConvert, Calculo) then
    begin
      Mensagem := 'O sistema não tem o cálculo do Convert: atualize o autcom.exe junto com a DLL.';
      Exit;
    end;

    Produto := Host.Produto;
    Dados := Aba3.Dados;
    if (Produto.Estado = ecInclusao) or (Produto.CodigoItem = '') or not Dados.Active or Dados.IsEmpty then
    begin
      Mensagem := 'Grave o produto para simular a conversão.';
      Exit;
    end;

    // RN02: fora de 0 <= x < 100 vale 0, como na Fase P.
    Desconto := Dados.FieldByName('ITE_DPISCO').AsFloat;
    if (Desconto < 0) or (Desconto >= 100) then
      Desconto := 0;

    if not fAliquotas(Host, Produto.CodigoItem, Origem, Aliquotas, Mensagem) then
      Exit;

    Item.CodigoItem := Produto.CodigoItem;
    Item.IcmsSaida := Dados.FieldByName('ITE_ICMSAI').AsFloat;
    for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
    begin
      Sufixo := IntToStr(Tabela);
      Item.PrecoVendaAtual[Tabela] := Produto.ValorNumerico('ITE_PREVE' + Sufixo);
      Item.MargemAtual[Tabela] := Produto.ValorNumerico('ITE_MARBR' + Sufixo);
      Item.ComissaoAtual[Tabela] := Dados.FieldByName('ITE_COMTB' + Sufixo).AsFloat;
      Item.ComissaoRefpre[Tabela].Existe := False;
      Item.ComissaoRefpre[Tabela].Valor := 0;
      // A margem da aba 3 quando e ela que estara na REFPRE ao converter; senao a do ITEGER, como o Convert.
      Item.MargemRefpre[Tabela].Existe := Aba3.MargemNaRefpre(Tabela);
      Item.MargemRefpre[Tabela].Valor := Dados.FieldByName('ITE_MARBR' + Sufixo).AsFloat;
    end;

    Regra := fRegraPreco;
    Entrada.CodigoItem := Produto.CodigoItem;
    Entrada.PrecoCompra := fPrecoCompraConvertido(Dados.FieldByName('ITE_PRECOM').AsFloat, Desconto,
      Calculo.DecimaisUnitarios);
    Entrada.DespesaOperacional := Dados.FieldByName('ITE_DESOPE').AsFloat;
    Entrada.Alvos := Regra.Alvos(Item, Opcao, Aliquotas);
    Entrada.Comissao := Regra.Comissoes(Item);

    Base := nil;
    for Campo in CAMPOS_BASE do
      Base := Base + [fCampoBase(Campo, Dados.FieldByName(Campo).AsFloat)];
    Base := Base + [fCampoBase('ITE_PREDOL', Dados.FieldByName('ITE_PREDOL').AsString)];
    for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
    begin
      Sufixo := IntToStr(Tabela);
      Base := Base + [fCampoBase('ITE_PREVE' + Sufixo, Item.PrecoVendaAtual[Tabela]),
        fCampoBase('ITE_MARBR' + Sufixo, Item.MargemAtual[Tabela]),
        fCampoBase('ITE_COMTB' + Sufixo, Entrada.Comissao[Tabela])];
    end;

    Resultado := Calculo.CalcularItemBase(Opcao, Entrada, Base, Valores);
    if not Resultado.Sucesso then
    begin
      Mensagem := Resultado.Mensagem;
      Exit;
    end;

    // Os campos de custo que o Convert nao calcula ficam os da aba 3; os calculados vem do host. O preco de compra
    // gravado e o preco com desconto (a linha Preco de Compra da aba mostra o preco com desconto).
    Formacao := fLerFormacao(Dados, Aba3.Formacao, True);
    Formacao.DescontoPisCofins := Desconto;
    Formacao.PrecoCompraComDesconto := Valores.PrecoCompra;
    Formacao.BasePrecoCompra := Formacao.Custo.PrecoCompra;
    Formacao.BaseDescontoPisCofins := Desconto;
    Formacao.Custo.SubFederal := Valores.SubFederal;
    Formacao.PrecoCusto := Valores.PrecoCusto;
    Formacao.ImpostoFederal := Valores.ImpostoFederal;
    Formacao.OutrosValores := Valores.OutrosValores;
    Formacao.IcmsSaida := Valores.IcmsSaida;
    Formacao.DespesaOperacional := Valores.DespesaOperacional;
    Formacao.Aliquotas := Aliquotas;
    for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
    begin
      Formacao.Tabelas[Tabela].PrecoVenda := Valores.PrecoVenda[Tabela];
      Formacao.Tabelas[Tabela].MargemBruta := Valores.MargemBruta[Tabela];
      Formacao.Tabelas[Tabela].Comissao := Valores.Comissao[Tabela];
    end;
    Result := True;
  except
    on E: Exception do
      Mensagem := E.Message;
  end;
end;

end.
