unit untTConfiguracao;

interface

uses untIConfiguracao;

Type
  TConfiguracao = class(TInterfacedObject, IConfiguracao)
    private
      class var objConfiguracao: IConfiguracao;
      constructor Create;
    public
      function fCfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = '') : Variant;
      class function fGetConfiguracao: IConfiguracao;
  End;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'};
{$ELSE}
  untFuncoesSimples;
{$ENDIF}

{ TConfiguracao }

constructor TConfiguracao.Create;
begin
  //
end;

function TConfiguracao.fCfgSis(strCamCfg: String; varTipVar: TVarType;
  strCodEmp: String): Variant;
begin
{$IFDEF LINUX}
  Result := Services.Core.Settings.fCfgSis(strCamCfg, varTipVar, strCodEmp);
{$ELSE}
  Result := untFuncoesSimples.fCfgSis(strCamCfg, varTipVar, strCodEmp);
{$ENDIF}
end;

class function TConfiguracao.fGetConfiguracao: IConfiguracao;
begin
  If Not Assigned(objConfiguracao) Then
  Begin
    objConfiguracao := TConfiguracao.Create;
  End;

  Result := objConfiguracao;
end;


end.
