{******************************************************************************************}
{* Interface que representa o Auttin.exe, assim a dll especifica da tinta não precisa ter *}
{* conhecimento das implemtações do auttin, como por exemplo a tela de geração            *}
{***************************************************************************************PH*}
unit untIAuttinWrapper;

interface

uses
  untIGravandoExecucaoNome, untIConfiguradorTinta, untICadLibTintas;

type
  IAuttinWrapper = interface
    ['{38E5E5E7-1C6D-450A-943F-6ED1B302E739}']
    procedure ProcessarArquivos(const strNomeTinta: string; const arrProcessadores: array of IGravandoExecucaoNome);
    procedure Configurar(const configuradorTinta: IConfiguradorTinta);
    procedure Cadastrar(const cadLibTintas: ICadLibTintas);
  end;

implementation

end.
