unit untExecutaSQLReplicacaoTinta;

// Unit criada para executar determinado sql que precisa ser replicado pela tinta de maquina.
// O modulo de replicacao nao é criado na tinta de maquina.
// Criei essa unit para não ter que criar o modulo replicacao dentro da tinta de maquina.

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  untIExecutaSQLReplicacaoTinta, Uni, SysUtils;

type
  TExecutaSQLReplicacaoTinta = class(TInterfacedObject, IExecutaSQLReplicacaoTinta)
  private

  public
    procedure pExecutaSQL(const strSQL: String; const arrParametros: array of string;
      const arrValores: array of Variant);

    constructor Create;
  End;

implementation

{ TExecutaSQLReplicacaoTinta }

constructor TExecutaSQLReplicacaoTinta.Create;
begin
  //
end;

procedure TExecutaSQLReplicacaoTinta.pExecutaSQL(const strSQL: String;
  const arrParametros: array of string; const arrValores: array of Variant);
var
  intParametros: Integer;
  qryGen: TUniQuery;
begin
  qryGen := Nil;
  Try
    qryGen := fCriaQuery();

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.Params.Clear;
    qryGen.SQL.Text := strSQL;

    For intParametros := Low(arrParametros) To High(arrParametros) Do
    Begin
      qryGen.ParamByName(arrParametros[intParametros]).Value := arrValores[intParametros];
    End;

    qryGen.ExecSQL;
  Finally
    If Assigned(qryGen) Then FreeAndNil(qryGen);
  End;
end;

end.
