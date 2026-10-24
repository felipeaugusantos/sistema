unit untDbeCodMontadoraKeyPressKillingIndustrial;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeCodMontadoraKeyPress = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

procedure TDbeCodMontadoraKeyPress.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryCadMon: IDataSet;
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
      qryCadMon := TAutcomTintaFactory.Get.fGetDataSet;

      if TAutcomTintaFactory.Get.fEntraCons(Key) then
      begin
        Key := #0;
        strSQL := strSQL + ' SELECT            ';
        strSQL := strSQL + '       MON_CODMON, '; pAddNomeColuna('Código');
        strSQL := strSQL + '       MON_DESCRI, '; pAddNomeColuna('Descrição');
        strSQL := strSQL + '       AUTOINCREM  ';
        strSQL := strSQL + '  FROM KIN_CADMON  ';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitCol, ['MON_DESCRI'], 'AUTOINCREM',
           'KIN_CADMON', 'untDbeCodMontadoraKeyPressKillingIndustrial', 'Consulta de Montadora - Killing Industrial', qryCadMon, [], []) Then
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
end.
