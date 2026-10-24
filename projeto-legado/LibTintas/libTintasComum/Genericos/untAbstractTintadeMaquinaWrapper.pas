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
    function GetNomeTinta: String; Virtual;
    function GetNomeForm: String; Virtual;
    function fGetSelectFrom(const configurador: IConfiguradorConsulta): String; virtual; abstract;
    function GetConsultaComp(strTabPre: String): IConsultaComp; virtual; abstract;
    function GetNomeTabela: String; virtual; abstract;
    function fGetWhere: String; virtual; abstract;
    function fGetGroup: String; virtual;
    function GetLinhaWandaPro: String; virtual;
    function GetLinhaAutomotiva : string; virtual;
    function fGetCamposSelect(blnTodos: boolean; const configurador: IConfiguradorConsulta): String; virtual;

  end;

implementation

uses
  untLibTintaFactory;

{ TAbstractTintadeMaquinaWrapper }

function TAbstractTintadeMaquinaWrapper.fGetCamposSelect(
  blnTodos: boolean; const configurador: IConfiguradorConsulta): String;
  var
    intCont: integer;
begin
  Result := '';
  Result := Result + ' SELECT ' + #$D#$A;

  For intCont := 0 To configurador.fGetQtdColunas - 1 Do
  Begin
    If blnTodos
      Or(configurador.fGetDisponivel(intCont)) Then
    Result := Result + ' ' + configurador.fGetNomeCampoColuna(intCont) + #$D#$A + ', ';
  End;
  Result := Result + GetCampoAutoIncrem + ', ';

  Result := Copy(Result, 1, LastDelimiter(',', Result) - 1) + ' ';

  Result := Result + ' FROM ' + fGetSelectFrom(configurador) + ' ';
end;


function TAbstractTintadeMaquinaWrapper.fGetGroup: String;
begin
  Result := '';
end;

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
  Result := Result + ' SELECT  ';

  For intCont := 0 To configurador.fGetQtdColunas - 1 Do
  Begin
    If blnTodos
      Or (configurador.fGetdisponivel(intCont) And configurador.fGetVisivel(intCont)) Then
      Result := Result + ' ' + configurador.fGetNomeCampoColuna(intCont) + ', ';
  End;

  Result := Result +  GetCampoAutoIncrem + ',';

  Result := Copy(Result, 1, LastDelimiter(',', Result) - 1) + ' ';

  Result := Result + ' FROM ' + fGetSelectFrom(configurador) + ' ';
  Result := Result + ' WHERE TRUE ';
end;

function TAbstractTintadeMaquinaWrapper.GetIdePro: String;
begin
  Result := TLibTintaFactory.GetLibTinta.GetIdePro;
end;

function TAbstractTintadeMaquinaWrapper.GetLinhaAutomotiva: string;
begin
  Result := '';
end;

function TAbstractTintadeMaquinaWrapper.GetLinhaWandaPro: String;
begin
  Result := '';
end;

function TAbstractTintadeMaquinaWrapper.GetNomeForm: String;
begin
  Result := TLibTintaFactory.GetLibTinta.GetNomeTinta;
end;

function TAbstractTintadeMaquinaWrapper.GetNomeTinta: String;
begin
  Result := TLibTintaFactory.GetLibTinta.GetNomeTinta;
end;

end.
