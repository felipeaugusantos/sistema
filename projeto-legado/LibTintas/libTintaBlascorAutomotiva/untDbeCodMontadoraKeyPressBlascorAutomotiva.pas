unit untDbeCodMontadoraKeyPressBlascorAutomotiva;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeCodMontadoraKeyPress = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  Private
    arrTitCol: Array of String;
    Procedure pAddNomeColuna(strNomCol: String);
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

procedure TDbeCodMontadoraKeyPress.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryCadMon: IDataSet;
  strSQL, strSQLWhere: String;
begin
  Try
    Try
      qryCadMon := TAutcomTintaFactory.Get.fGetDataSet;

      if TAutcomTintaFactory.Get.fEntraCons(Key) then
      begin
        Key := #0;
        strSQL := strSQL + ' SELECT            ';
        strSQL := strSQL + '       MON_CODMON, '; pAddNomeColuna('Código');
        strSQL := strSQL + '       MON_DESCRI, '; pAddNomeColuna('Montadora');
        strSQL := strSQL + '       AUTOINCREM  ';
        strSQL := strSQL + '  FROM BLA_CADMON  ';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitCol, ['MON_CODMON'], 'AUTOINCREM',
           'BLA_CADMON', 'untDbeCodMontadoraKeyPressBlascorAutomotiva', 'Consulta de Montadora - Blascor Automotiva', qryCadMon, [], []) Then
        Begin
          GetFieldByControle('dbeMontadora').AsString := qryCadMon.FieldByName('MON_CODMON').AsString;
          tela['edtDesMontadora']['Text'].Value       := qryCadMon.FieldByName('MON_DESCRI').AsString;
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
procedure TDbeCodMontadoraKeyPress.pAddNomeColuna(strNomCol: String);
begin
  SetLength(arrTitCol, Succ(Length(arrTitCol)));
  arrTitCol[High(arrTitCol)] := strNomCol;
end;

end.
