{**********************************************************************}
{* DLL para consumo de APIs REST.                                     *}
{* Foi criada para ser utilizada em versões antigas do Delphi (cópias *}
{* específicas - ex: G&B), que não possuem os recursos nativos.       *}
{* Obs: usa-se WideString para compatibilidade com versões anteriores *}
{* ao Delphi 2009, que não possuem suporte Unicode.                   *}
{* 22/10/2021 - Reinaldo Silveira                                     *}
{**********************************************************************}
{* Atulizando a DLL para compilação no Delphi 10.3, algumas API estão *}
{* dando erro com o REST do delphi 10.                                *}
{* 08/09/2022 - Matheus Alacrino                                      *}
{**********************************************************************}
library RestApiBoleto;

uses
  ShareMem,
  MidasLib,
  System.SysUtils,
  System.Classes,
  api.rest.main in 'api.rest.main.pas',
  api.rest.core in 'api.rest.core.pas';

{$R *.res}

exports
  Execute,
  ExecuteAuth,
  Execute_,
  ExecuteAuth_;

begin

end.
