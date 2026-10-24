unit untDbeProdutoKeyPressSparlack;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeProdutoKeyPress = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

procedure TDbeProdutoKeyPress.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryProduto : IDataSet;
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
      qryProduto := TAutcomTintaFactory.Get.fGetDataSet;

      if TAutcomTintaFactory.Get.fEntraCons(Key) then
      begin
        Key := #0;
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   BAS_PRODUT, '; pAddNomeColuna('Produto');
        strSQL := strSQL + '   AUTOINCREM ';
        strSQL := strSQL + ' FROM   ';
        strSQL := strSQL + '   SPA_CADBAS ';
        strSQLWhere := ' WHERE TRUE ';
        strSQLGroup := 'GROUP BY BAS_PRODUT';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrTitCol, ['BAS_PRODUT'], 'AUTOINCREM', 'SPA_CADBAS', 'untDbeProdutoKeyPressSparlack', 'Consulta de Produtos - Sparlack', qryProduto, [], []) Then
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
end.