unit untFusionEntregaServico;

{ * Campo não obrigatório
  # Campo obsoleto

  // EXEMPLO -- DESCRIÇÃO }

interface

uses
  { [JSonName('nome_campo')]
    Evita que TJson.ObjectToJsonString corte o primeiro F na serialização }
  REST.Json.Types,
  System.Generics.Collections,
  untFusionEntregaServicoItens;

type
  TFusionEntregaServico = class
  private
    campo_alt :String; // NEW_538. Padrão para verificação no WebService
    [JSonName('fus_id')]
    fus_id :String; // 8814621 --	O mesmo do pedido_erp
    razao_cliente :String; //	ROBERTO MAIA -- Mesmo que descr_cliente. É preciso para confirmar os dados, caso não exista cadastrado anteriormente.
  public
    {*}nf :String; // PE	-- numero da nota fiscal
    {*}chave_nfe :String; // "" -- Chave da nota fiscal eletrônica
    {*}serie :String; //	985874894165 --	codigo da serie da nota fiscal
    {*}tipo :String; // "" - tipo da nota fiscal
    ent_ou_serv :String; // Entrega -- Se é Entrega ou Serviço
    pedido_erp :String; // 21660546	-- Codigo do pedido no seu sistema (ERP)

    [JSonName('forma_pgto')]
    {*}forma_pgto :String; // 1 -- Sem descrição
    status :String; // 1 --	Status 1 são normalmente para coletas. 9 canceladas.
    {*}obs :String; // "" -- Caso for um endereço alternativo, pode-se colocar nesse campo @CEP, sendo o cep no formatao 00000-000
    {*}num_ped_conf :String; // 005073A -- Sem descrição
    {*}carga :String; // "" - Sem descrição
    cubagem :String; // 0.0014875	-- Não precisa ser metro cubico obrigatoriamente. Pode ser qualquer unidade que voce pode trabalhar.
    podeformarcarga :String; //	S	-- caso for cancelada, é passado o parametro "N"
    valor :String; // 7.8 -- Sim, caso não exista pode passar zero.
    peso :String; // 0.2 -- Sem descrição
    {*}qtd_pallets_entrega: Double; // 0.0 -- Quantidade de pallets da entrega
    {*}valor_st :String; // 0 -- Sem descrição
    empresa_fat :String; // A6 --	filial da fatura no ERP
    empresa_log :String; //	A6 --	filial da logística no ERP onde será enviado os produtos.
    empresa_digit :String; //	A6 --	filial da digitação no ERP.
    pedido_orig :String; //	21660546 --	codigo do pedido do ERP
    {*}dt_list_nf :TDateTime; //	1899-12-30 00:00:00 --	será a data da coleta.
//    {*}data_alt :TDateTime; //	2015-03-16 12:14:37	-- nao precisa informar
    nf_cod_rota_erp :String; //	87 --	codigo da rota da nota fiscal
    nf_descricao_rota :String; //	ROTA 87 - CLIENTE LOJA --	descricao da rota da nota fiscal
    descr_cliente :String; //	ROBERTO MAIA LIRA JUNIOR --	descrição do cliente.
    cnpj_cliente :String; //	46012508468	-- sim, pode colocar o cpf
    end_cliente :String; //	RUA DO MACHADO, 1012 -- endereço
    bairro_cliente :String; // AGUA FRIA	-- bairro
    {*}num_end_cliente :String; // "" -- Sem descrição
    uf_cliente :String; // PE --	UF do endereço do cliente
    cidade_cliente :String; // RECIFE	-- cidade do cliente
    cep_cliente :String; //	51120250 --	cep do cliente
    {*}email1_cliente :String; // r.diego@fusion.com	-- email do cliente
    {*}email2_cliente :String; // ramon.d@fusion.com	-- email do cliente
    {*}email3_cliente :String; // term.inal@fretes.com	-- email do cliente
    {*}tel1_cliente :String; //	8134477000 -- telefone do cliente
    {*}tel2_cliente :String; //	8332477000 -- telefone do cliente
    {*}tel3_cliente :String; //	8434455040 -- telefone do cliente
    {*}vlr_credito_cliente :String; //	170	-- caso cliente tenha
    {*}data_cadastro_cliente :TDateTime; // 2006-07-31 14:30:40 -- Sem descrição
    {*}saldo_disp_cliente :String; // 170 -- Sem descrição
    {*}vlr_tits_vencido_cliente :String; // 0 -- Sem descrição
    {*}vlr_tits_vencer_cliente :String; //	0 -- Sem descrição
    {*}status_cred_cliente :String; //	C -- Sem descrição
    codigo_cliente :String; // 56928	-- É o codigo do cliente no erp
    {*}cod_segmento :String; // 2 -- Sem descrição
    {*}descr_segmento :String; // ATACADO -- Sem descrição

    [JSonName('filial_padrao')]
    {*}filial_padrao :String; //	A6 -- Sem descrição
    {*}data_ult_compra :TDateTime; // 2015-03-06 08:20:48 -- Sem descrição

    [JSonName('forma_pgto_cliente')]
    {*}forma_pgto_cliente :String; // 1 -- Sem descrição
    {*}retem_icms_cliente :String; // N -- Sem descrição
    {*}permite_retira_cliente :String; // N -- Sem descrição
    {*}rede_loja_cliente :String; //	9999 -- Sem descrição
    {*}cliente_cod_rota_erp :String; // 119 -- Codigo da praça no seu ERP
    {*}cliente_descricao_rota :String; // GR-05 SUPORTE (UN.6) DIARIAMENTE	-- Descrição da praça no seu ERP
    {*}vendedor_erp :String; // 20 -- Sem descrição
    data_pedido :TDateTime; // 2017-01-26 10:50:00 -- Sem descrição
    {*}codigo_endereco_alt :String; //	147	-- Endereço alternativo, caso precise.
    praca_cod_erp: String;
    praca_descricao: String;
    rota_cod_erp: String;
    rota_descricao: String;

    [JSonName('itens')]
    arrProdutos: array of TFusionEntregaServicoItens;

    constructor Create;
    destructor Destroy; override;
    function fGerarJson: String; Overload;
    function fGerarJson(AarrPedidos: array of TFusionEntregaServico): String; Overload;
  end;

implementation

uses
  REST.JSON, SysUtils;

{ TFusionEntregaServico }

constructor TFusionEntregaServico.Create;
begin
//  arrProdutos := TObjectList<TFusionEntregaServicoItens>.Create;
end;

destructor TFusionEntregaServico.Destroy;
var
  LobjProduto: TFusionEntregaServicoItens;
begin
  for LobjProduto in Self.arrProdutos do
    LobjProduto.Free;
end;

function TFusionEntregaServico.fGerarJson(AarrPedidos: array of TFusionEntregaServico): String;
var
  intCont: Integer;
begin
  Result := '[';

  for intCont := 0 to Pred(Length(AarrPedidos)) do
  begin
    AarrPedidos[intCont].campo_alt := 'NEW_538';
    AarrPedidos[intCont].fus_id := AarrPedidos[intCont].pedido_erp;
    AarrPedidos[intCont].razao_cliente := AarrPedidos[intCont].descr_cliente;

    Result := Result + TJson.ObjectToJsonString(AarrPedidos[intCont]);

    if (intCont < Pred(Length(AarrPedidos))) then
      Result := Result +',';
  end;

  Result := Result + ']';
end;

function TFusionEntregaServico.fGerarJson: String;
begin
  campo_alt := 'NEW_538';
  fus_id := pedido_erp;
  razao_cliente := descr_cliente;

  Result := '['
    +TJson.ObjectToJsonString(Self)
    +']';
end;

end.

