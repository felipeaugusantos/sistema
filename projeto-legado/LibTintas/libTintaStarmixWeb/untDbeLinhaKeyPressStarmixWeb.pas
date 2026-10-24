unit untDbeLinhaKeyPressStarmixWeb;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeLinhaKeyPressStarmixWeb = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

procedure TDbeLinhaKeyPressStarmixWeb.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryConsulta: IDataSet;
  strSQL,
  strSQLWhere : String;

  arrTitCol: Array of String;


  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

begin
  Try
    Try
      qryConsulta := TAutcomTintaFactory.Get.fGetDataSet;

      if TAutcomTintaFactory.Get.fEntraCons(Key) then
      begin
        Key := #0;
        strSQL := strSQL + 'SELECT ';
        strSQL := strSQL + '   LIN_DESLIN , '; paddNomeColuna('Descrição da Linha');
        strSQL := strSQL + '   STW_CADLIN.AUTOINCREM ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  STW_CADLIN ';

        strSQLWhere := ' WHERE TRUE ';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL,strSQLWhere], arrTitCol, ['LIN_DESLIN'], 'AUTOINCREM', 'STW_CADLIN', 'untDbeLinhaKeyPressStarmixWeb', 'Consulta de Linhas - StarmixWeb', qryConsulta, [], []) Then
        Begin
          GetFieldByControle('dbeLinha').AsString := qryConsulta.FieldByName('LIN_DESLIN').AsString;
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
end.
