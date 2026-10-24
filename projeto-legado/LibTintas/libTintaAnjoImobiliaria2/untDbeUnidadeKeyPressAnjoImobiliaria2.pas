unit untDbeUnidadeKeyPressAnjoImobiliaria2;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeCodUniKeyPress = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  Private
    arrTitCol: Array of String;
    Procedure pAddNomeColuna(strNomCol: String);
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

procedure TDbeCodUniKeyPress.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryCadUni: IDataSet;
  strRetorno, strSQL, strSQLWhere: String;
begin
  Try
    Try
      qryCadUni := TAutcomTintaFactory.Get.fGetDataSet;

      if TAutcomTintaFactory.Get.fEntraCons(Key) then
      begin
        Key := #0;
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   U.UNI_CODUNI, '; pAddNomeColuna('Código');
        strSQL := strSQL + '   U.UNI_DESUNI, '; pAddNomeColuna('Descrição');
        strSQL := strSQL + '   U.UNI_SIGUNI, '; pAddNomeColuna('Sigla');
        strSQL := strSQL + '   U.AUTOINCREM ';
        strSQL := strSQL + ' FROM   ';
        strSQL := strSQL + '   CADUNI U  ';
        strSQLWhere := ' WHERE UNI_SIGUNI IN ("LT","GL","LA", "BD") ';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitCol, ['UNI_DESUNI'], 'AUTOINCREM', 'CADUNI', 'untDbeCodUniKeyPress', 'Consulta de Unidade - AnjoImobiliaria2', qryCadUni, [], []) Then
        Begin
          GetFieldByControle('dbeCodUni').AsString := qryCadUni.FieldByName('UNI_CODUNI').AsString;
          If cadastro.fValidaCampos(tela, cadastro.GetNomeCampoUnidade, tela['dbeCodUni']['Text'].Value, strRetorno) Then
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

procedure TDbeCodUniKeyPress.pAddNomeColuna(strNomCol: String);
begin
  SetLength(arrTitCol, Succ(Length(arrTitCol)));
  arrTitCol[High(arrTitCol)] := strNomCol;
end;

end.
