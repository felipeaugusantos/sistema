unit untDbeProdutoKeyPressAutoluks;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeProdutoKeyPressAutoluks = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  Private
    arrTitCol: Array of String;
    Procedure pAddNomeColuna(strNomCol: String);
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

procedure TDbeProdutoKeyPressAutoluks.OnKeyPress(Sender: TObject; var Key: Char);
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
        strSQL := strSQL + ' SELECT ALK_PRODUT    '; pAddNomeColuna('Produto');
        strSQL := strSQL + '      , AUTOINCREM    ';
        strSQL := strSQL + '   FROM ALK_CADALK    ';
        strSQLWhere := ' WHERE TRUE';
        strSQLGroup :=  '  GROUP BY ALK_PRODUT ';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrTitCol, ['ALK_PRODUT'], 'AUTOINCREM',
           'ALK_CADALK', 'untDbeProdutoKeyPressAutoluks', 'Consulta de Produtos - Autoluks', qryCadPro, [], []) Then
        Begin
          tela['dbeProduto']['Text'].Value := qryCadPro.FieldByName('ALK_PRODUT').AsString;
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
procedure TDbeProdutoKeyPressAutoluks.pAddNomeColuna(strNomCol: String);
begin
  SetLength(arrTitCol, Succ(Length(arrTitCol)));
  arrTitCol[High(arrTitCol)] := strNomCol;
end;

end.
