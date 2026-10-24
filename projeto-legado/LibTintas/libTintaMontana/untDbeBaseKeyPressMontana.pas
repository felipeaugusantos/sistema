unit untDbeBaseKeyPressMontana;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeBaseKeyPressMontana = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses untStrUtils;

procedure TDbeBaseKeyPressMontana.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryBase     : IDataSet;
  strSQL      : String;
  strSQLWhere : String;
  arrTitCol   : Array of String;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

begin
  Try
    Try
      qryBase := TAutcomTintaFactory.Get.fGetDataSet;

      if TAutcomTintaFactory.Get.fEntraCons(Key) then
      begin
        Key := #0;
        strSQL := strSQL + '  SELECT ';
        strSQL := strSQL + '         M.BAS_CODBAS, '; pAddNomeColuna('Código');
        strSQL := strSQL + '         M.BAS_DESCRI, '; pAddNomeColuna('Descrição');
        strSQL := strSQL + '         U.UNI_SIGUNI, '; pAddNomeColuna('Unidade');
        strSQL := strSQL + '         M.BAS_PRODUT, '; pAddNomeColuna('Produto');
        strSQL := strSQL + '         M.BAS_CODITE, '; pAddNomeColuna('Cód.Item');
        strSQL := strSQL + '         I.ITE_DESITE, '; pAddNomeColuna('Descrição do Item');
        strSQL := strSQL + '         I.ITE_REFERE, '; pAddNomeColuna('Referência');
        strSQL := strSQL + '         M.AUTOINCREM ';
        strSQL := strSQL + '    FROM MON_CADBAS M  ';
        strSQL := strSQL + '   INNER JOIN CADITE I ON I.ITE_CODITE = M.BAS_CODITE  ';
        strSQL := strSQL + '   INNER JOIN CADUNI U ON U.UNI_CODUNI = M.BAS_UNIDAD  ';

        strSQLWhere := 'WHERE TRUE ';

        if Not TStrUtils.fEmptyStr(tela['dbeProduto']['Text'].Value) Then
          strSQLWhere := strSQLWhere + ' AND BAS_PRODUT = "' + tela['dbeProduto']['Text'].Value +'"';

        if Not TStrUtils.fEmptyStr(Tela['dbeCodUni']['text'].Value) Then
          strSQLWhere := strSQLWhere + ' AND BAS_UNIDAD = "' + Tela['dbeCodUni']['text'].Value +'"';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitCol, ['BAS_DESCRI'], 'AUTOINCREM', 'MON_CADBAS', 'untDbeBaseKeyPressMontana', 'Consulta de Bases - Montana', qryBase, [], []) Then
        Begin
          GetFieldByControle('dbeBase').AsString := qryBase.FieldByName('BAS_CODBAS').AsString;
          Tela['edtDesBase']['text'].Value       := qryBase.FieldByName('BAS_DESCRI').AsString;

          If Not TStrUtils.fEmptyStr(GetFieldByControle('dbeBase').AsString)Then
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
