unit untDbeCodEmbKeyPressNovasFormulasCalamar;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeCodEmbKeyPressNovasFormulasCalamar = class(TAbstractLibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodEmbKeyPress }
procedure TDbeCodEmbKeyPressNovasFormulasCalamar.OnKeyPress(Sender: TObject; var Key: Char);
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

        strFiltro := '';

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux,  'CAL_CADEMB', 'untDbeCodEmbKeyPressNovasFormulasCalamar',
           'Cadastro de Embalagens - Calamar Imobiliária', '', strFiltro) Then
        Begin
          tela['dbeEmbala']['Text'].Value := qryAux.FieldByName('EMB_CODEMB').AsString;
          tela['edtDesUni']['Text'].Value := qryAux.FieldByName('EMB_DESCRI').AsString;
          tela['edtSigUni']['Text'].Value := qryAux.FieldByName('EMB_CODUNI').AsString;
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
