unit untDbeCodEmbKeyPressNovasFormulasChreon;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils;

type
  TDbeCodEmbKeyPressNovasFormulasChreon = class(TAbstractLibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodEmbKeyPress }

procedure TDbeCodEmbKeyPressNovasFormulasChreon.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAux: IDataSet;
  strFiltro: String;
begin
  Try
    Try
      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;

        qryAux := TAutcomTintaFactory.Get.fGetDataSet;

        strFiltro := ' AND EMB_UNIDAD = ' + QuotedStr(tela['dbeCodUni']['Text'].Value);

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux,  'CHR_CADEMB', 'untDbeCodEmbKeyPressNovasFormulasChreon',
           'Cadastro de Embalagens - Chreon', '', strFiltro) Then
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
