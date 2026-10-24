unit untDbeProdutoKeyPressAlterPlus;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeProdutoKeyPress = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  Private
    procedure pAddNomeColuna(strNomCol: String; arrTitCol: Array Of String);
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

procedure TDbeProdutoKeyPress.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryProduto : IDataSet;
  strSQL, strSQLWhere, strSQLGroup: String;
  arrTitCol: Array of String;
begin
  Try
    Try
      qryProduto := TAutcomTintaFactory.Get.fGetDataSet;

      if TAutcomTintaFactory.Get.fEntraCons(Key) then
      begin
        Key := #0;
        SetLength(arrTitCol, Succ(Length(arrTitCol)));

        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   BAS_PRODUT, '; pAddNomeColuna('Produto', arrTitCol);
        strSQL := strSQL + '   AUTOINCREM ';
        strSQL := strSQL + ' FROM   ';
        strSQL := strSQL + '   ALP_CADBAS ';
        strSQLWhere := ' WHERE TRUE ';
        strSQLGroup := 'GROUP BY BAS_PRODUT';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrTitCol, ['BAS_PRODUT'], 'AUTOINCREM', 'ALP_CADBAS', 'untDbeProdutoKeyPressAlterPlus', 'Consulta de Produtos - Alter Plus', qryProduto, [], []) Then
        Begin
          GetFieldByControle('dbeProduto').AsString := qryProduto.FieldByName('BAS_PRODUT').AsString;
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
procedure TDbeProdutoKeyPress.pAddNomeColuna(strNomCol: String;
  arrTitCol: Array of String);
begin
  arrTitCol[High(arrTitCol)] := strNomCol;
end;

end.
