unit untDbeDesProKeyPressNovasFormulasAdvanceTintoSystem;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeDesProKeyPressNovasFormulasAdvanceTintoSystem = class(TAbstractLibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeDesProKeyPress }

procedure TDbeDesProKeyPressNovasFormulasAdvanceTintoSystem.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAux: IDataSet;
  strFiltro: String;
begin
  Try
    Try
      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;

        qryAux       := TAutcomTintaFactory.Get.fGetDataSet;


          strFiltro := strFiltro + ' AND B.BAS_DESCRI LIKE "%PARTE B%" ';
          strFiltro := strFiltro + ' AND BAS_CODEMB = ' + QuotedStr(tela['dbeEmbala']['Text'].Value);



        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'ADT_CADBAS', 'untDbeDesProKeyPressNovasFormulasAdvanceTintoSystem',
           'Cadastro de Base - Catalisadores', 'BAS_CODITE', strFiltro) Then
        Begin

          GetFieldByControle('dbeCta').AsString := qryAux.FieldByName('BAS_CODBAS').AsString;
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
