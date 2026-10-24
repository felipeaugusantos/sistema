unit untDbeCodEmbKeyPressNovasFormulasSherwinWilliams;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils;

type
  TDbeCodEmbKeyPressNovasFormulasSherwinWilliams = class(TAbstractLibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodEmbKeyPress }

procedure TDbeCodEmbKeyPressNovasFormulasSherwinWilliams.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAux: IDataSet;
  strSQL: String;
begin
  Try
    Try
      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;

        qryAux       := TAutcomTintaFactory.Get.fGetDataSet;

        strSQL := ' SELECT                        ' +
                  '   EMB_CODEMB    "Código",     ' +
                  '   EMB_QTDEMB    "Quantidade", ' +
                  '   EMB_UNIDAD    "Unidade",    ' +
                  '   AUTOINCREM                  ' +
                  '  FROM SHE_CADEMB              ' +
                  ' WHERE TRUE                    ';


        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux,  'SHE_CADEMB') Then
        Begin
          tela['dbeEmbala']['Text'].Value := qryAux.FieldByName('EMB_CODEMB').AsString;
          tela['edtQtdEmb']['Text'].Value := qryAux.FieldByName('EMB_QTDEMB').AsString;
          tela['edtUniEmb']['Text'].Value := qryAux.FieldByName('EMB_UNIDAD').AsString;

          tela.SelectNext;
        End;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;

end;

end.
