{*********************************************************************************************}
{* Interface que representa um configurador da tela de configuração, assim cada configuração *}
{* da tinta pode ser representada de formas distintas na tela.                               *}
{******************************************************************************************PH*}
unit untIConfiguradorTinta;

interface

const
  tpNormal = 1;
  tpDiretorio = tpNormal + 1;
  tpSimNao = tpDiretorio + 1;
  tpTravaPreco = tpSimNao + 1;
  tpSenha = tpTravaPreco + 1;
  tpNumero = tpSenha + 1;
  tpNumeroDecimal = tpNumero + 1;
  tpData = tpNumeroDecimal + 1;
  tpNumero_5 = tpData + 1;
  tpBotao = tpNumero_5 + 1;

type
  TTipoPropriedade = Integer;

type
  IConfiguradorTinta = interface
    ['{573971B7-8979-4AE4-B388-B9DD9CC70F89}']
    function GetIdePro: string;
    function GetPropriedade(const strCodCfg: string): TTipoPropriedade;
    function ConfigurarClick(const strCodCfg: string; const strValCfg: string): string;
    function IsConfiguracaoExistente(const strCodCfg: string): Boolean;
    
    property IdePro: string read GetIdePro;
  end;

implementation

end.
