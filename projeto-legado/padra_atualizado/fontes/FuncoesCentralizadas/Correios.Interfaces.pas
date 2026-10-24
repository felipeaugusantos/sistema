{*******************************************************}
{ unit compartilhada entre o Autcom e a libCorreios.dll }
{ ATENÇÃO: não alterar os métodos existentes dessa      }
{ interface. Se necessário, somente crie novos métodos! }
{*******************************************************}
unit Correios.Interfaces;

interface

uses
  Correios.Types;

type
  ICorreios = interface
    ['{C9028AB9-71DB-4C68-9FB7-57FF7A4EBD6E}']
    function ConsultaCep(const ACep: String; out ACidade, AEndereco, ABairro, AEstado: String): Boolean; stdcall;
    function GetServicosCliente(const ANumContrato, ANumCartao: String; const AHomologacao: Boolean): TServicosCliente; stdcall;
    function EnviaPreListaPostagem(const ADadosPostagem: TDadosPostagem; out AJsonEnv, AJsonRet, AIdPostagem, ACodObjeto: String): Boolean; stdcall;
  end;

implementation

end.
