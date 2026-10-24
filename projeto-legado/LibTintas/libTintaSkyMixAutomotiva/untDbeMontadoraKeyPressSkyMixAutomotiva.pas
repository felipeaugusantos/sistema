unit untDbeMontadoraKeyPressSkyMixAutomotiva;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untAbstractCadastro, StrUtils;

type
  TDbeMontadoraKeyPressSkyMixAutomotiva = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

{ TDbeCodColKeyPress }

procedure TDbeMontadoraKeyPressSkyMixAutomotiva.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryMontadora: IDataSet;
  strSQL,
  strSQLWhere,
  strSQLGroup:String;

  strSQLOrder:String;

  arrTitMon:Array Of String;

  procedure pAddNomeColuna(strColuna:String);
  Begin
    SetLength(arrTitMon, Succ(Length(arrTitMon)));
    arrTitMon[High(arrTitMon)] := strColuna;
  End;

begin
  Try
    Try
      qryMontadora := TAutcomTintaFactory.Get.fGetDataSet;

      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;

        strSQL := strSQL + '      SELECT            ';
        strSQL := strSQL + '        MON_CODMON,     '; pAddNomeColuna('Código');
        strSQL := strSQL + '        MON_DESMON,     '; pAddNomeColuna('Montadora');
        strSQL := strSQL + '        AUTOINCREM      ';
        strSQL := strSQL + '      FROM              ';
        strSQL := strSQL + '        SKY_CADMON      ';

        strSQLWhere := '  ';
        strSQLGroup := '  ';

        strSQLOrder := 'MON_CODMON';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrTitMon, [strSQLOrder], 'AUTOINCREM',
          'SKY_CADMON', 'untDbeMontadoraKeyPressSkyMixAutomotiva', 'Consulta de Montadoras - SkyMix Automotiva', qryMontadora, [], []) Then
        Begin
          GetFieldByControle('dbeMontadora').AsString := qryMontadora.FieldByName('MON_CODMON').AsString;
          tela.SelectNext;
        End;
      End;

    Except
      On E: Exception Do
        Raise;
    End;
  Finally

  End;
end;

end.
