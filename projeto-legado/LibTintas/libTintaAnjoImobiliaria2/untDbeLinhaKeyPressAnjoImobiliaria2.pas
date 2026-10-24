unit untDbeLinhaKeyPressAnjoImobiliaria2;

interface

uses
  untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeLinhaKeyPressAnjoImobiliaria2 = class(TAbstractLibTintaControleVisualEvento)
  Private
    arrTitCol: Array of String;
    Procedure pAddNomeColuna(strNomCol: String);
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation


procedure TDbeLinhaKeyPressAnjoImobiliaria2.OnKeyPress(Sender: TObject; var Key: Char);
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
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   L.LIN_CODLIN, '; pAddNomeColuna('Código Linha');
        strSQL := strSQL + '   L.LIN_DESCRI, '; pAddNomeColuna('Descrição Linha');
        strSQL := strSQL + '   L.AUTOINCREM ';
        strSQL := strSQL + ' FROM   ';
        strSQL := strSQL + '   AN2_CADLIN L  ';
        strSQLWhere := '';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitCol, ['LIN_CODLIN'], 'AUTOINCREM', 'AN2_CADLIN',
           'untDbeLinhaKeyPressAnjoImobiliaria2', 'Consulta de Linha - Anjo Imobiliaria 2', qryCadLin, [], []) Then
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

procedure TDbeLinhaKeyPressAnjoImobiliaria2.pAddNomeColuna(strNomCol: String);
begin
  SetLength(arrTitCol, Succ(Length(arrTitCol)));
  arrTitCol[High(arrTitCol)] := strNomCol;
end;

end.
