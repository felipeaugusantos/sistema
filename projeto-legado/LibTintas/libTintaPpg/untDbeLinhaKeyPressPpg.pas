unit untDbeLinhaKeyPressPpg;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeCodLinKeyPress = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

procedure TDbeCodLinKeyPress.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryCadLin: IDataSet;

  strSQL     : String;
  strSQLWhere: String;
  strSQLGroup: String;

  arrTitCol: Array of String;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

begin
  Try
    Try
      qryCadLin := TAutcomTintaFactory.Get.fGetDataSet;

      if TAutcomTintaFactory.Get.fEntraCons(Key) then
      begin
        Key := #0;
        strSQL := strSQL + ' SELECT           ';
        strSQL := strSQL + '     BAS_TIPO__,  '; pAddNomeColuna('Tipo');
        strSQL := strSQL + '     AUTOINCREM ';
        strSQL := strSQL + ' FROM   ';
        strSQL := strSQL + '   PPG_CADBAS ';

        strSQLWhere := ' WHERE TRUE';

        strSQLGroup := 'GROUP BY BAS_TIPO__ ';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrTitCol, ['BAS_TIPO__'], 'AUTOINCREM',
           'PPG_CADBAS', 'untDbeCodLinKeyPress', 'Consulta de Tipo - Ppg', qryCadLin, [], []) Then
        Begin
          GetFieldByControle('dbeTipo').AsString := qryCadLin.FieldByName('BAS_TIPO__').AsString;
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
