unit untGravandoFactory;

interface

uses
  untGenericGravando, Classes, SysUtils, untAbstractGravandoExecucao;

type
  TGravandoFactory = class abstract (TInterfacedObject)
  public
    class procedure Gravar(AOwner: TComponent; const strNomeTinta: string;
      arrGravandoExecucao: TArrayGravandoExecucao);
    class function ArrayToTArrayGravandoExecucao(
      arrOrigem: array of TAbstractGravandoExecucao): TArrayGravandoExecucao;
  end;

implementation

{ TGravandoFactory }

class function TGravandoFactory.ArrayToTArrayGravandoExecucao(
  arrOrigem: array of TAbstractGravandoExecucao): TArrayGravandoExecucao;
var
  intCont: Integer;
begin
  SetLength(Result, Length(arrOrigem));
  for intCont := 0 to Length(arrOrigem) - 1 do
  begin
    Result[intCont] := arrOrigem[intCont];
  end;
end;

class procedure TGravandoFactory.Gravar(AOwner: TComponent; const strNomeTinta: string;
  arrGravandoExecucao: TArrayGravandoExecucao);
var
  frmGravando: TfrmGenericGravando;
begin
  frmGravando := nil;
  Try
    Try
      frmGravando := TfrmGenericGravando.Create(AOwner, strNomeTinta, arrGravandoExecucao);
      frmGravando.ShowModal;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmGravando) then FreeAndNil(frmGravando);
  End;
end;

end.
