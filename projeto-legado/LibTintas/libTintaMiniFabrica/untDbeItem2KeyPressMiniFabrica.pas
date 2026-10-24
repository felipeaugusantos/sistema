unit untDbeItem2KeyPressMiniFabrica;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeItem2KeyPressMiniFabrica = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  Private
    arrTitCol: Array of String;
    Procedure pAddNomeColuna(strNomCol: String);
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

procedure TDbeItem2KeyPressMiniFabrica.OnKeyPress(Sender: TObject; var Key: Char);
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
        strSQL := strSQL + ' SELECT ITE_CODITE,    '; pAddNomeColuna('Código');
        strSQL := strSQL + '        ITE_DESITE,    '; pAddNomeColuna('Descrição Item');
        strSQL := strSQL + '        ITE_REFERE,    '; pAddNomeColuna('Referência');
        strSQL := strSQL + '        AUTOINCREM     ';
        strSQL := strSQL + '   FROM CADITE         ';
        strSQLWhere := 'WHERE ITE_ITEATI = "S"';
        strSQLGroup :=  '';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrTitCol, ['ITE_CODITE'], 'AUTOINCREM',
         'CADITE', 'untDbeItem2KeyPressMiniFabrica', 'Consulta de Items - Mini Fábrica', qryCadPro, [], []) Then
        Begin
          tela['dbeCompC']['Text'].Value := qryCadPro.FieldByName('ITE_REFERE').AsString;
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
procedure TDbeItem2KeyPressMiniFabrica.pAddNomeColuna(strNomCol: String);
begin
  SetLength(arrTitCol, Succ(Length(arrTitCol)));
  arrTitCol[High(arrTitCol)] := strNomCol;
end;

end.

