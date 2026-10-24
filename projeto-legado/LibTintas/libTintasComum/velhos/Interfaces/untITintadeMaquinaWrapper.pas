{****************************************************************}
{* Interface responsável pelas informações da consulta da tinta *}
{*************************************************************PH*}
unit untITintadeMaquinaWrapper;

interface

uses
  untIConfiguradorConsulta, untIConsultaComp;

type
  ITintadeMaquinaWrapper = interface
  ['{ED8E778B-8330-4EAD-AE7F-46D4023F301F}']
    procedure Configurar(const configurador: IConfiguradorConsulta);
    function GetIdePro: String;
    function GetCampoAutoIncrem: String;
    function GetNomeTinta: String;
    function fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
    procedure pRestaurarPadrao(const configurador: IConfiguradorConsulta);
    function fGetSelectFrom(const configurador: IConfiguradorConsulta): String;
    function GetConsultaComp: IConsultaComp;
    function GetNomeTabela: String;

    property IdePro: String read GetIdePro;
    property CampoAutoIncrem: String read GetCampoAutoIncrem;
    property NomeTinta: String read GetNomeTinta;
  End;

implementation

end.
