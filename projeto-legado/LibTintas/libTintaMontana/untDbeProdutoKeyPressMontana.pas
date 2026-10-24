unit untDbeProdutoKeyPressMontana;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeProdutoKeyPressMontana = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

procedure TDbeProdutoKeyPressMontana.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryConsulta: IDataSet;
  strSQL,
  strSQLWhere,
  strSQLGroup : String;

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
        strSQL := strSQL + '   BAS_PRODUT , '; paddNomeColuna('Produto');
        strSQL := strSQL + '  MON_CADBAS.AUTOINCREM ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  MON_CADBAS ';

        strSQLWhere := ' WHERE TRUE ';
        strSQLGroup := ' GROUP BY BAS_PRODUT';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL,strSQLWhere,strSQLGroup], arrTitCol, ['BAS_PRODUT'], 'AUTOINCREM', 'MON_CADBAS', 'untDbeProdutoKeyPressMontana', 'Consulta de Produtos - Montana', qryConsulta, [], []) Then
        Begin
          GetFieldByControle('dbeProduto').AsString := qryConsulta.FieldByName('BAS_PRODUT').AsString;
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
