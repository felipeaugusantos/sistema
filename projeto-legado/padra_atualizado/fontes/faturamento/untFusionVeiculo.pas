unit untFusionVeiculo;

{ * Campo não obrigatório
  # Campo obsoleto

  // EXEMPLO -- DESCRIÇÃO }

interface

uses
  System.Generics.Collections;

type
  TFusionVeiculo = class

  private
    campo_alt :String; //	NEW_762 -- (fixo)	Uso interno do método
    seq_id :String; // 12345 --	código do veiculo no erp
  public
    codigo_erp :String; // 12345 -- código do veiculo no erp
    placa	:String; // KSS9977	-- placa do veiculo
    descricao	:String; // MERCEDES BENZ 15-16 -- descricao do veiculo
    {*}kmAtual	:String; // 567424 --	km atual cadastrado do veiculo.
    {*}modelo :String; //	VOLKSWAGEM --	modelo do veiculo
    {*}anoModelo :String; //	2002 --	ano do modelo do veiculo
    {*}anoFabricacao  :String; // 2001 -- ano fabricado
    {*}qtdMaxEntregas :String; // 30	-- quantidade de entregas que podem ser feitas pelo veiculo
    {*}velocidade_maxima :String; //	80 --	velocidade máxima atingida pelo veículo
    {*}tipo_combustivel :String; //	Diesel --	tipo usado pelo combustivel
    {*}status_inicial :String; //	Livre	-- normalmente é vindo com padrão, que o status é Livre
    peso_max_entregas	:String; // 6500 --	peso maximo para entregas no veiculo
    {*}volume_max_entregas	:String; // 10 --	volume maximo permitido para entrega no veiculo
    {*}qtd_pallets_veiculo	:String; // 10 --	se for utilizado, quantidade máxima de pallets utilizada no veiculo

    constructor Create;

    function fGerarJson: String; Overload;
    function fGerarJson(AarrVeiculos: Array of TFusionVeiculo): String; Overload;
  end;

implementation

uses
  REST.JSON;

{ TFusionMotorista }

function TFusionVeiculo.fGerarJson: String;
begin
  campo_alt := 'NEW_762';
  seq_id := codigo_erp;

  Result := '[' +TJson.ObjectToJsonString(Self) +']';
end;

constructor TFusionVeiculo.Create;
begin
  // Não possui no Autcom
  // Padrão discutido em e-mail
  Self.kmAtual := '0';
  Self.qtdMaxEntregas := '9999';
  Self.volume_max_entregas := '99999';
  Self.qtd_pallets_veiculo := '99';

  // Não possui no Autcom
  Self.velocidade_maxima := ''; //	velocidade máxima atingida pelo veículo
  Self.tipo_combustivel := ''; //	tipo usado pelo combustivel
  Self.peso_max_entregas := '';
end;

function TFusionVeiculo.fGerarJson(AarrVeiculos: array of TFusionVeiculo): String;
var
  intCont: Integer;
begin
  Result := '[';

  for intCont := 0 to Pred(Length(AarrVeiculos)) do
  begin
    AarrVeiculos[intCont].campo_alt := 'NEW_762';
    AarrVeiculos[intCont].seq_id := AarrVeiculos[intCont].codigo_erp;

    Result := Result + TJson.ObjectToJsonString(AarrVeiculos[intCont]);

    if (intCont < Pred(Length(AarrVeiculos))) then
      Result := Result +',';
  end;

  Result := Result + ']';
end;

end.

