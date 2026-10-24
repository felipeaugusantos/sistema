unit untFusionCliente;

{ * Campo não obrigatório
  # Campo obsoleto

  // EXEMPLO -- DESCRIÇÃO }

interface

uses
  { [JSonName('nome_campo')]
    Evita que TJson.ObjectToJsonString corte o primeiro F na serialização }
  REST.Json.Types,
  System.Generics.Collections;

type
  TFusionCliente = class

  private
    campo_alt: String; //	NEW_59
    seq_id: String; // Igual ao codigo_cliente
    razao_cliente: String; //	Igual ao descr_cliente

    // Campos obsoletos. Não são preenchidos, mas devem compor o layout do Json
    {#*}vlr_credito_cliente: String;
    {#*}saldo_disp_cliente: String;
    {#*}vlr_tits_vencido_cliente: String;
    {#*}vlr_tits_vencer_cliente: String;
    {#*}status_cred_cliente: String;

    [JSonName('forma_pgto_cliente')]
    {#*}forma_pgto_cliente: String;
    {#*}bloqueiosefaz: String;
    {#*}rede_loja_cliente: String;
  public
    codigo_cliente: String;	// 513660	codigo do cliente no seu sistema.

    [JSonName('filial_padrao')]
    filial_padrao: String; //	1
    descr_cliente: String; //	ROBERTO MAIA -- descricao/nome fantasia do cliente
    cnpj_cpf_cliente: String; // 46012508468 -- Sim, pode colocar o cnpj. Sem acentuações
    cliente_cod_rota_erp: String; // 1560 -- Codigo da rota do cliente no ERP.
    {*}cod_segmento: String; // 2 -- Valor Livre. Codigo do segmento no ERP
    {*}descr_segmento: String; // ATACADO -- Valor Livre. Descricao do segmento
    cep_cliente: String; //	51120250	-- CEP do endereço do cliente
    end_cliente: String; //	RUA DO MACHADO, 1012 -- Endereço do cliente
    num_end_cliente: String; //	0 -- Numero do local do cliente
    bairro_cliente: String; // AGUA FRIA -- Bairro do cliente
    cidade_cliente: String; // RECIFE	-- Cidade do cliente
    uf_cliente: String; //	PE -- UF do endereço do cliente
    {*}email1_cliente: String; // email1@email.com -- Email para contato
    {*}email2_cliente: String; // email2@email.com --	Email para contato
    {*}email3_cliente: String; // email3@email.com --	Email para contato
    {*}tel1_cliente: String; // 81-3543-1022	telefone para contato(nao obrigatorio)
    {*}tel2_cliente: String; // 81-9999-8877	telefone para contato(nao obrigatorio)
    {*}tel3_cliente: String; // 81-9999-8877	telefone para contato(nao obrigatorio)
    data_cadastro_cliente: TDateTime; // 2008-07-10 11:28:10 --	data de cadastro no ERP
    data_ult_compra: TDateTime; // 2015-03-16 12:15:40 --	sim, data da ultima coleta registrada.
    {*}horarios_entrega: String; // 08:00-12:00;14:00:17:00 --	horarios de entrega/coleta
    {*}prioritario: String; // S na tela de roteirizacao vai ter uma cor diferente, e será entregue primeiro

    function fGerarJson(arrClientes: Array of TFusionCliente): String;
  end;

implementation

uses
  REST.JSON, SysUtils;

{ TFusionCliente }

function TFusionCliente.fGerarJson(arrClientes
  : Array of TFusionCliente): String;
var
  i: Integer;
begin
  if Length(arrClientes) = 0 then
  begin
    campo_alt := 'NEW_59';
    seq_id := codigo_cliente;
    razao_cliente := descr_cliente;
    rede_loja_cliente := '9999';

    // Configurar campos não obrigatórios como vazio
    vlr_credito_cliente := '';
    saldo_disp_cliente := '';
    vlr_tits_vencido_cliente := '';
    vlr_tits_vencer_cliente := '';
    status_cred_cliente := '';
    forma_pgto_cliente := '';
    bloqueiosefaz := '';

    // Remove as acentuações do CPF/CNPJ, se houver
    cnpj_cpf_cliente := cnpj_cpf_cliente.Replace('.', '').Replace('/', '').Replace('-', '').Replace(' ', '');

    Result := '[' +TJson.ObjectToJsonString(Self) +']';
  end
  else
  begin
    Result := '[';

    for i := 0 to Pred(Length(arrClientes)) do
    begin
      arrClientes[i].campo_alt := 'NEW_59';
      arrClientes[i].seq_id := arrClientes[i].codigo_cliente;
      arrClientes[i].razao_cliente := arrClientes[i].descr_cliente;
      arrClientes[i].rede_loja_cliente := '9999';

      // Configurar campos não obrigatórios como vazio
      arrClientes[i].vlr_credito_cliente := '';
      arrClientes[i].saldo_disp_cliente := '';
      arrClientes[i].vlr_tits_vencido_cliente := '';
      arrClientes[i].vlr_tits_vencer_cliente := '';
      arrClientes[i].status_cred_cliente := '';
      arrClientes[i].forma_pgto_cliente := '';
      arrClientes[i].bloqueiosefaz := '';

      // Remove as acentuações do CPF/CNPJ, se houver
      arrClientes[i].cnpj_cpf_cliente :=
        arrClientes[i].cnpj_cpf_cliente.Replace('.', '').Replace('/', '').
          Replace('-', '').Replace(' ', '');

      Result := Result + TJson.ObjectToJsonString(arrClientes[i]);

      if i < Pred(Length(arrClientes)) then
        Result := Result +',';
    end;

    Result := Result + ']';
  end;
end;

end.
