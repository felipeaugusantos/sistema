unit untDbeMontadoraKeyPressPpg;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeCodMonKeyPress = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

procedure TDbeCodMonKeyPress.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryCadLin: IDataSet;

  strSQL     : String;

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
        strSQL := strSQL + '     MON_CODMON,  '; pAddNomeColuna('Código');
        strSQL := strSQL + '     MON_DESCRI,  '; pAddNomeColuna('Descrição');
        strSQL := strSQL + '     AUTOINCREM ';
        strSQL := strSQL + ' FROM   ';
        strSQL := strSQL + '   PPG_CADMON';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL], arrTitCol, ['MON_CODMON'], 'AUTOINCREM',
           'PPG_CADMON', 'untDbeCodMonKeyPress', 'Consulta de Montadora - Ppg', qryCadLin, [], []) Then
        Begin
          GetFieldByControle('dbeMontadora').AsString := qryCadLin.FieldByName('MON_CODMON').AsString;
          tela['edtDescMontadora']['Text'].Value      := qryCadLin.FieldByName('MON_DESCRI').AsString;

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
