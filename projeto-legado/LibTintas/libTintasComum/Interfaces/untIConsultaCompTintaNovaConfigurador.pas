{*************************************************************************************}
{* Interface que representa as as informações da tela de consulta da tinta que serão *}
{* passadas para as implementações dos botões, assim o implementador dos botões terá *}
{* acesso as informações da tela de consulta                                         *}
{**********************************************************************************PH*}
unit untIConsultaCompTintaNovaConfigurador;

interface

uses
  untIDataSet;

type
  IConsultaCompTintaNovaConfigurador = interface
    ['{D8654BDB-7E19-4207-884B-55E12CE1970C}']
    function GetDataSetConsulta: IDataSet;

    property DataSetConsulta: IDataSet read GetDataSetConsulta;
  end;

implementation

end.
