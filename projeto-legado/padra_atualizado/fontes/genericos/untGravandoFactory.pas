unit untGravandoFactory;

interface

uses
  untITelaGravandoExecucao, SysUtils, Forms;

type
  TGravandoFactory = class(TInterfacedObject)
  public
    class function Executar(const executor: ITelaGravandoExecucao): Boolean;
  end;

  

implementation

uses untGravando, untTelaGravandoExecutarAcaoWrapper;

{ TGravandoFactory }

class function TGravandoFactory.Executar(const executor: ITelaGravandoExecucao): Boolean;
var
  wrapper: TTelaGravandoExecutarAcaoWrapper;
begin
  wrapper := nil;
  Result := False;
  Try
    Try
      frmGravando := TfrmGravando.Create(Screen.ActiveForm);
      frmGravando.strChave := GUIDToString(ITelaGravandoExecucao);
      wrapper := TTelaGravandoExecutarAcaoWrapper.Create(executor);
      frmGravando.fExecutarAcao := wrapper.Executar;
      frmGravando.ShowModal;
      Result := frmGravando.blnConfirma;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmGravando) then FreeAndNil(frmGravando);
    if Assigned(wrapper) then FreeAndNil(wrapper);
  End;
end;



end.
