unit untIConsultaCadastroFit;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core;
{$ELSE}
  untFuncoesSimples;
{$ENDIF}

const

  DESC_RAZAO_SOCIAL   = 'Razão Social';
  DESC_NOME_FANTASIA  = 'Nome Fantasia';
  DESC_INSC_EST       = 'Insc. Est.';
  DESC_ENDERECO       = 'Endereço';
  DESC_NUMERO         = 'Número';
  DESC_COMPLEMENTO    = 'Complemento';
  DESC_BAIRRO         = 'Bairro';
  DESC_CEP            = 'CEP';
  DESC_IBGE_CIDADE    = 'Cód. IBGE Cidade';
  DESC_CNPJ           = 'CNPJ';
  DESC_CNAE           = 'CNAE';
  DESC_DATA_ABERTURA  = 'Data de Abertura';
  DESC_SIT_SIMPLES    = 'Situação no Simples Nacional';
  DESC_SIT_SIMEI      = 'Situação no SIMEI';

type
  IConsultaCadastroFit = interface
    procedure pConsulta(dicValoresAtuais,
                        dicResultado: TDicionario;
                        strCnpj: String;
                        blnMostraCnae: Boolean;
                        Var blnTemDivergencia: Boolean;
                        blnPermiteAtualiza: Boolean = True;
                        strOrigem: String = '');
  end;

var
  objConsultaCadastroFit: IConsultaCadastroFit = nil;

implementation

end.


