unit untDbeCodUniKeyPressKresil;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

Type
  TDbeCodUniKeyPressKresil = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

{ TDbeCodUniKeyPressKresil }

procedure TDbeCodUniKeyPressKresil.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryCadUni: IDataSet;
  strRetorno, strSQL, strSQLWhere: String;
  arrTitCol: Array of String;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;
begin
  Try
    Try
      qryCadUni := TAutcomTintaFactory.Get.fGetDataSet;

      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   U.UNI_CODUNI, '; pAddNomeColuna('Código');
        strSQL := strSQL + '   U.UNI_DESUNI, '; pAddNomeColuna('Descrição');
        strSQL := strSQL + '   U.UNI_SIGUNI, '; pAddNomeColuna('Sigla');
        strSQL := strSQL + '   U.AUTOINCREM ';
        strSQL := strSQL + ' FROM   ';
        strSQL := strSQL + '   CADUNI U  ';
        strSQLWhere := ' WHERE UNI_SIGUNI IN ("QT","BD","GL")';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitCol, ['UNI_DESUNI'], 'AUTOINCREM', 'CADUNI', 'untDbeCodUniKeyPressKrezil', 'Consulta de Unidade - Tintas', qryCadUni, [], []) Then
        Begin
          GetFieldByControle('dbeCodUni').AsString := qryCadUni.FieldByName('UNI_CODUNI').AsString;
          If cadastro.fValidaCampos(tela, cadastro.GetNomeCampoUnidade, tela['dbeCodUni']['Text'].Value, strRetorno) Then
            tela.SelectNext;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally

  End;
end;

end.
