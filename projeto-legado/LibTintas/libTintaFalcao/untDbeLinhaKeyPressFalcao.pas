unit untDbeLinhaKeyPressFalcao;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeLinhaKeyPress = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

procedure TDbeLinhaKeyPress.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryLinha : IDataSet;
  strSQL, strSQLWhere, strSQLGroup: String;


  arrTitCol: Array of String;


  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

begin
  Try
    Try
      qryLinha := TAutcomTintaFactory.Get.fGetDataSet;

      if TAutcomTintaFactory.Get.fEntraCons(Key) then
      begin
        Key := #0;
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   BAS_LINHA_, '; pAddNomeColuna('Código');
        strSQL := strSQL + '   BAS_DESLIN, '; pAddNomeColuna('Descrição');
        strSQL := strSQL + '   AUTOINCREM ';
        strSQL := strSQL + ' FROM   ';
        strSQL := strSQL + '   FAL_CADBAS ';
        strSQLWhere := ' WHERE TRUE ';
        strSQLGroup := 'GROUP BY BAS_LINHA_';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrTitCol, ['BAS_LINHA_'], 'AUTOINCREM', 'FAL_CADBAS', 'untDbeLinhaKeyPressFalcao', 'Consulta de Linhas - Falcão', qryLinha, [], []) Then
        Begin
          GetFieldByControle('dbeLinha').AsString     := qryLinha.FieldByName('BAS_LINHA_').AsString;
          GetFieldByControle('dbeLinhaDesc').AsString := qryLinha.FieldByName('BAS_DESLIN').AsString;
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
