unit untDataSetViewer;

interface

uses
  DB, Forms, SysUtils;

type
  TDataSetViewer = class(TInterfacedObject)
  public
    class procedure View(const qryDados: TDataSet; const strTitulo: string;
      const strTextoAdicional: string; const blnSomenteLeitura: Boolean = False);
  end;

implementation

uses untGenericDataSetViewer;

{ DataSetViewer }

class procedure TDataSetViewer.View(const qryDados: TDataSet; const strTitulo: string;
  const strTextoAdicional: string; const blnSomenteLeitura: Boolean);
var
  frmDataSet: TfrmGenericDataSetViewer;
begin
  frmDataSet := nil;
  Try
    Try
      frmDataSet := TfrmGenericDataSetViewer.Create(Screen.ActiveForm, qryDados, strTitulo, strTextoAdicional, blnSomenteLeitura);
      frmDataSet.ShowModal;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmDataSet) then FreeAndNil(frmDataSet);
  End;
end;

end.
