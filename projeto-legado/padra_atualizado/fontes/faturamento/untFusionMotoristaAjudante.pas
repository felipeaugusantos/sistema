unit untFusionMotoristaAjudante;

{ * Campo não obrigatório
  # Campo obsoleto

  // EXEMPLO -- DESCRIÇÃO }

interface

uses
  System.Generics.Collections;

type
  TFusionMotoristaAjudante = class
  private
    campo_alt :String; // NEW_825 --	Este campo é por padrão "NEW_825". Serve para verificação interna do sistema
  public
    seq_id :String; // 898651	-- É repetido o codigo do ERP. * Esse id muda em algumas empresas específicas
    codigo_erp :String; // 898651	-- Codigo do condutor no sistema ERP.
    nome :String; // FULANO DA SILVA -- Nome do condutor
    cpf :String; //	000111222-33 -- CPF do condutor
    {*}cep :String; //	52000000 -- CEP do condutor
    {*}endereco :String; // RUA XYZ, 9999 -- Endereco do condutor
    {*}cidade :String; // Recife -- Cidade do condutor
    {*}uf :String; // PE -- UF do condutor
    {*}telefone :String; // 0218199998877 --	telefone para contato, podendo ser celular ou fixo
    tipo :String; // Motorista -- função do funcionario(Motorista ou Ajudante)

    constructor Create;

    function fGerarJson: String; overload;
    function fGerarJson(AarrMotoristas: array of TFusionMotoristaAjudante): String; overload;
  end;

implementation

uses
  REST.JSON, System.JSON;

{ TFusionMotorista }

function TFusionMotoristaAjudante.fGerarJson: String;
begin
  campo_alt := 'NEW_825';
  seq_id := codigo_erp;

  Result := '[' +TJson.ObjectToJsonString(Self) +']';
end;

constructor TFusionMotoristaAjudante.Create;
begin
  cep := '';
  endereco := '';
  cidade := '';
  uf := '';
  telefone := '';
end;

function TFusionMotoristaAjudante.fGerarJson(AarrMotoristas: array of TFusionMotoristaAjudante): String;
var
  intCont: Integer;
begin
  Result := '[';

  for intCont := 0 to Pred(Length(AarrMotoristas)) do
  begin
    AarrMotoristas[intCont].campo_alt := 'NEW_825';
    AarrMotoristas[intCont].seq_id := Copy(AarrMotoristas[intCont].codigo_erp, 1, Length(AarrMotoristas[intCont].codigo_erp) - 1);

    Result := Result + TJson.ObjectToJsonString(AarrMotoristas[intCont]);

    if (intCont < Pred(Length(AarrMotoristas))) then
      Result := Result +',';
  end;

  Result := Result + ']';
end;

end.

