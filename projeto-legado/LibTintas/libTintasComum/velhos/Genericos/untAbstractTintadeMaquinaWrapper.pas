{***************************************************************************************}
{* Classe abstrata que implementa a interface ITintadeMaquinaWrapper, responsável pela *}
{* configuração (Ordme dos campos, campos visivel, indices de uma consulta) da tela de *}
{* consulta                                                                            *}
{************************************************************************************PH*}
unit untAbstractTintadeMaquinaWrapper;

interface

uses
  untITintadeMaquinaWrapper, untIConfiguradorConsulta,
  SysUtils, untIConsultaComp, untAbstractLibTinta,
  untILibTinta;

type
  TAbstractTintadeMaquinaWrapper = class(TInterfacedObject, ITintadeMaquinaWrapper)
  public
    procedure Configurar(const configurador: IConfiguradorConsulta); virtual; abstract;
    function GetCampoAutoIncrem: String; virtual; abstract;
    function GetIdePro: String;
    function fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String; virtual;
    procedure pRestaurarPadrao(const configurador: IConfiguradorConsulta); virtual; abstract;
    function GetNomeTinta: String;
    function fGetSelectFrom(const configurador: IConfiguradorConsulta): String; virtual; abstract;
    function GetConsultaComp: IConsultaComp; virtual; abstract;
    function GetNomeTabela: String; virtual; abstract;
  end;

implementation

uses
  untLibTintaFactory;

{ TAbstractTintadeMaquinaWrapper }

function TAbstractTintadeMaquinaWrapper.fGetSelect(const blnTodos: Boolean; const configurador: IConfiguradorConsulta): String;
Var
  intCont: Integer;
begin
  If Not configurador.fVerificaConfigurado Then
  Begin
    configurador.pRestaurarPadrao;
    configurador.pSalvarConfs;
  End;

  Result := '';
  Result := Result + ' SELECT ' + GetCampoAutoIncrem + ', ';

  For intCont := 0 To configurador.fGetQtdColunas - 1 Do
  Begin
    If blnTodos
      Or (configurador.fGetdisponivel(intCont) And configurador.fGetVisivel(intCont)) Then
      Result := Result + ' ' + configurador.fGetNomeCampoColuna(intCont) + ', ';
  End;

  Result := Copy(Result, 1, LastDelimiter(',', Result) - 1) + ' ';

  Result := Result + ' FROM ' + fGetSelectFrom(configurador) + ' ';
  Result := Result + ' WHERE TRUE ';
end;

function TAbstractTintadeMaquinaWrapper.GetIdePro: String;
begin
  Result := TLibTintaFactory.GetLibTinta.GetIdePro;
end;

function TAbstractTintadeMaquinaWrapper.GetNomeTinta: String;
begin
  Result := TLibTintaFactory.GetLibTinta.GetNomeTinta;
end;

end.
