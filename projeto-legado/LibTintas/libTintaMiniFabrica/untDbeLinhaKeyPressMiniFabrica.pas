unit untDbeLinhaKeyPressMiniFabrica;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeCodLinKeyPress = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  Private
    arrTitCol: Array of String;
    Procedure pAddNomeColuna(strNomCol: String);

  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

procedure TDbeCodLinKeyPress.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryCadLin: IDataSet;
  strSQL, strSQLWhere: String;
begin
  Try
    Try
      qryCadLin := TAutcomTintaFactory.Get.fGetDataSet;

      if TAutcomTintaFactory.Get.fEntraCons(Key) then
      begin
        Key := #0;
        strSQL := strSQL + ' SELECT           ';
        strSQL := strSQL + '     LIN_CODLIN,  '; pAddNomeColuna('Código');
        strSQL := strSQL + '     LIN_DESCRI,  '; pAddNomeColuna('Linha');
        strSQL := strSQL + '     AUTOINCREM ';
        strSQL := strSQL + ' FROM   ';
        strSQL := strSQL + '   MIF_CADLIN  ';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitCol, ['LIN_DESCRI'], 'AUTOINCREM',
           'MIF_CADLIN', 'untDbeCodLinKeyPress', 'Consulta de Linha - Top MIFt', qryCadLin, [], []) Then
        Begin
          GetFieldByControle('dbeLinha').AsString := qryCadLin.FieldByName('LIN_DESCRI').AsString;
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
procedure TDbeCodLinKeyPress.pAddNomeColuna(strNomCol: String);
begin
  SetLength(arrTitCol, Succ(Length(arrTitCol)));
  arrTitCol[High(arrTitCol)] := strNomCol;
end;

end.
