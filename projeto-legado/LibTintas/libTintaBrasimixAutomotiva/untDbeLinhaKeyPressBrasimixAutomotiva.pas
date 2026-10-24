unit untDbeLinhaKeyPressBrasimixAutomotiva;

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
  strSQL, strSQLWhere: String;

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
        strSQL := strSQL + '     LIN_CODIGO,  '; pAddNomeColuna('Código');
        strSQL := strSQL + '     LIN_DESCRI,  '; pAddNomeColuna('Descrição');
        strSQL := strSQL + '     LIN_VOLUME,  '; pAddNomeColuna('Volume');
        strSQL := strSQL + '     AUTOINCREM ';
        strSQL := strSQL + ' FROM   ';
        strSQL := strSQL + '   BZA_CADLIN  ';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitCol, ['LIN_DESCRI'], 'AUTOINCREM',
           'BZA_CADLIN', 'untDbeCodLinKeyPress', 'Consulta de Linha - Brasimix Automotiva', qryCadLin, [], []) Then
        Begin
          GetFieldByControle('dbeItemLinha').AsString := qryCadLin.FieldByName('LIN_CODIGO').AsString;
          tela['edtDesLinha']['Text'].Value           := qryCadLin.FieldByName('LIN_DESCRI').AsString;
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
