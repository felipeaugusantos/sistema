{********************************************************************************************}
{* Classe responsável pela validação das dlls da tinta, com isso é possivel saber se o      *}
{* identificador (IDEPRO) está com alguma dll associada, caso não esteja para a operação do *}
{* usuario, pois a continuidade depende da dll carregada.                                   *}
{*****************************************************************************************PH*}
unit untVerificadorTintaExistente;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  untTintaMaquina, untLibTintaFactory, SysUtils, Classes, untConstantes;

type
  TVerificadorTintaExistente = class(TInterfacedObject)
  private
    class var stlExistentes: TStringList;
    class function GetExstentes(): TStringList;
  public
    class function ExisteTinta(const strIdePro: string; blnExibirMsg: Boolean = True): Boolean;
    class function IsTintaExistente(const strIdePro: string; blnExibirMsg: Boolean = True): Boolean;
  end;

  function IsTintaExistente(const strIdePro: string; blnExibirMsg: Boolean = True): Boolean; stdcall;

implementation

{ TVerificadorTintaExistente }

class function TVerificadorTintaExistente.ExisteTinta(const strIdePro: string; blnExibirMsg: Boolean = True): Boolean;
begin
  if fEmptyStr(strIdePro) then
  begin
    Result := False;
    exit;
  end;
  // O produto tintométrico com identificação [ DAC ] não foi encontrado na lista de tintas de máquina disponíveis.
  // A operação será cancelada.
  Result := GetExstentes.IndexOf(strIdePro) >= 0;
  if not Result then
  begin
    Result := (Assigned(TLibTintaFactory.GetITintadeMaquina(strIdePro)));
  end;

  if not Result And blnExibirMsg then
  begin
    fMensagem('ATENCÃO','Não foi encontrado o módulo do sistema referente a Tinta de Máquina [' + strIdePro + '].' + sLineBreak +
                        'O arquivo referente a Tinta de Máquina [' + strIdePro + '],'  + sLineBreak +
                        'não foi encontrado no diretório das Tintas : '  + sLineBreak +
                        'autcom\auttin\tintas'  + sLineBreak +
                        'Entre em contato com a CITEL para resolvermos o problema.',['&Ok']);
  end;
end;

class function TVerificadorTintaExistente.GetExstentes: TStringList;
begin
  if not Assigned(stlExistentes) then
  begin
    stlExistentes := TStringList.Create;
    stlExistentes.Sorted := True;
    stlExistentes.Duplicates := dupIgnore;

    stlExistentes.Add('ACA');

    stlExistentes.Add('GLA');
    stlExistentes.Add('SAL');

    stlExistentes.Add('NOR');
    stlExistentes.Add('PRODUTO ACABADO');
    stlExistentes.Add('SALCOMIX');
    stlExistentes.Add('GLASURIT');

    stlExistentes.Add('GERAL');
    stlExistentes.Add('USA_FORMUL');
  end;

  Result := stlExistentes;
end;

class function TVerificadorTintaExistente.IsTintaExistente(const strIdePro: string; blnExibirMsg: Boolean = True): Boolean;
begin
  Try
    Result := ExisteTinta(strIdePro, blnExibirMsg);
  Except
    on E: Exception do
    begin
      Result := False;
    end;
  End;
end;

function IsTintaExistente(const strIdePro: string; blnExibirMsg: Boolean = True): Boolean; stdcall;
begin
  Result := TVerificadorTintaExistente.IsTintaExistente(strIdePro, blnExibirMsg);
end;

initialization
  TVerificadorTintaExistente.stlExistentes := nil;

finalization
  if Assigned(TVerificadorTintaExistente.stlExistentes) then FreeAndNil(TVerificadorTintaExistente.stlExistentes);
end.
