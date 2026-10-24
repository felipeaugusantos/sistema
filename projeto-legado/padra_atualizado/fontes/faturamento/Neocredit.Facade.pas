unit Neocredit.Facade;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils;

type
  TFacadeNeocredit = class
  public
    class function AnaliseNeocreditAtivada: Boolean;
    class function ExecutarAnaliseLimiteCredito(const AStlPedidos: TStringList): Boolean;
    class function AtualizarAnaliseLimiteCredito(const ACodCli: String): Boolean;
    class function PermiteLiberarPedidoSemAutorizacaoNeocredit(ACodCli: String): Boolean;

  end;

implementation

uses
  Neocredit.Controlador, untFuncoesSimples;

{ TFacadeNeocredit }

class function TFacadeNeocredit.AnaliseNeocreditAtivada: Boolean;
begin
  Result := fCfgSis('NEOCHB') = 'S';
end;

class function TFacadeNeocredit.AtualizarAnaliseLimiteCredito(
  const ACodCli: String): Boolean;
var
  LControlador: TControladorNeocredit;
begin
  If Not TFacadeNeocredit.AnaliseNeocreditAtivada Then
    Exit(True);

  LControlador := nil;
  Try
    LControlador := TControladorNeocredit.Create;
    Result := LControlador.AtualizarAnaliseLimiteCredito(ACodCli);
  Finally
    FreeAndNil(LControlador);
  End;
end;

class function TFacadeNeocredit.ExecutarAnaliseLimiteCredito(
  const AStlPedidos: TStringList): Boolean;
var
  LControlador: TControladorNeocredit;
begin
  If Not TFacadeNeocredit.AnaliseNeocreditAtivada Then
    Exit(True);

  LControlador := nil;
  Try
    LControlador := TControladorNeocredit.Create;
    Result := LControlador.ExecutarAnaliseLimiteCredito(AStlPedidos);
  Finally
    FreeAndNil(LControlador);
  End;
end;

class function TFacadeNeocredit.PermiteLiberarPedidoSemAutorizacaoNeocredit(
  ACodCli: String): Boolean;
var
  LControlador: TControladorNeocredit;
begin
  If Not TFacadeNeocredit.AnaliseNeocreditAtivada Then
    Exit(True);

  LControlador := nil;
  Try
    LControlador := TControladorNeocredit.Create;
    Result := LControlador.PermiteLiberarPedidoSemAutorizacaoNeocredit(ACodCli);
  Finally
    FreeAndNil(LControlador);
  End;
end;

end.
