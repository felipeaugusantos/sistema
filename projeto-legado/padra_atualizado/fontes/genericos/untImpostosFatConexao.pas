unit untImpostosFatConexao;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  untModulo, untThreadUtils,
{$ENDIF LINUX}
  Faturamento.Interfaces.Conexao, Uni;

type
  TImpostosFatConexao = class(TInterfacedObject, IImpostosFatConexao)
  public
    function Conexao: TUniConnection;

    class function New(): IImpostosFatConexao;
  end;

implementation

{ TImpostosFatConexao }

function TImpostosFatConexao.Conexao: TUniConnection;
begin
{$IFDEF LINUX}
  Result := TUniConnection(objConnectionsManager.CurrentConnection.GetObject);
{$ELSE }
  Result := frmModulo.GetCurrentConnection;
{$ENDIF LINUX}
end;

class function TImpostosFatConexao.New: IImpostosFatConexao;
begin
  Result := Self.Create;
end;

initialization

SetarObjConexao(TImpostosFatConexao.New());

end.
