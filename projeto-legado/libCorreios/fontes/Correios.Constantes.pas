unit Correios.Constantes;

interface

const
  URL_HOMOLOGACAO = 'https://apihom.correios.com.br';
  URL_PRODUCAO    = 'https://api.correios.com.br';

  REQ_TOKEN       = '/token/v1/autentica/cartaopostagem';
  REQ_CEP         = '/cep/v1/enderecos/';
  REQ_SERVICOS    = '/meucontrato/v1/empresas/%s/contratos/%s/servicos?nuCartaoPostagem=%s';
  REQ_PLP         = '/prepostagem/v1/prepostagens';

  STATUS_OK       = 200;
  STATUS_CREATED  = 201;
  APP_JSON        = 'application/json';
  API_TIMEOUT     = 120000;

implementation

end.
