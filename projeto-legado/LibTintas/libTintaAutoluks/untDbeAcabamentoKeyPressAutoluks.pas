unit untDbeAcabamentoKeyPressAutoluks;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeAcabamentoKeyPressAutoluks = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  Private
    arrTitCol: Array of String;
    Procedure pAddNomeColuna(strNomCol: String);
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

procedure TDbeAcabamentoKeyPressAutoluks.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryCadPro : IDataSet;
  strSQL,
  strSQLWhere,
  strSQLGroup : String;
begin
  Try
    Try
      qryCadPro := TAutcomTintaFactory.Get.fGetDataSet;

      if TAutcomTintaFactory.Get.fEntraCons(Key) then
      begin
        Key := #0;
        strSQL := strSQL + ' SELECT ALK_ACABAM   '; pAddNomeColuna('Acabamento');
        strSQL := strSQL + '      , AUTOINCREM   ';
        strSQL := strSQL + '   FROM ALK_CADALK   ';

        strSQLWhere := ' WHERE TRUE';
        strSQLGroup := '  GROUP BY ALK_ACABAM';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrTitCol, ['ALK_ACABAM'], 'AUTOINCREM',
           'ALK_CADALK', 'untDbeAcabamentoKeyPressAutoluks', 'Consulta de Acabamentos - Autoluks', qryCadPro, [], []) Then
        Begin
          tela['dbeAcabamento']['Text'].Value := qryCadPro.FieldByName('ALK_ACABAM').AsString;
          tela.SelectNext;
        End;
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;
procedure TDbeAcabamentoKeyPressAutoluks.pAddNomeColuna(strNomCol: String);
begin
  SetLength(arrTitCol, Succ(Length(arrTitCol)));
  arrTitCol[High(arrTitCol)] := strNomCol;
end;

end.
