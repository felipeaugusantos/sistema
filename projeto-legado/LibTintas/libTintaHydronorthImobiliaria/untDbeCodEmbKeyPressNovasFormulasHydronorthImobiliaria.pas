unit untDbeCodEmbKeyPressNovasFormulasHydronorthImobiliaria;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeCodEmbKeyPressNovasFormulasHydronorthImobiliaria = class(TAbstractLibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodEmbKeyPress }
procedure TDbeCodEmbKeyPressNovasFormulasHydronorthImobiliaria.OnKeyPress(Sender: TObject; var Key: Char);
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

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux,  'HYD_CADEMB', 'untDbeCodEmbKeyPressNovasFormulasHydronorthImobiliaria',
           'Cadastro de Embalagens - Hydronorth Imobiliária', '', strFiltro) Then
        Begin
          tela['dbeEmbala']['Text'].Value := qryAux.FieldByName('EMB_CODEMB').AsString;
          tela['edtDesUni']['Text'].Value := qryAux.FieldByName('EMB_DESEMB').AsString;
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
