unit untDbeCodMontadoraKeyPressSalcomix;

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
        strSQL := strSQL + '       SAL_CODMON, '; pAddNomeColuna('Código');
        strSQL := strSQL + '       SAL_DESMON, '; pAddNomeColuna('Descrição');
        strSQL := strSQL + '       AUTOINCREM  ';
        strSQL := strSQL + '  FROM SAL_CADMON  ';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitCol, ['SAL_DESMON'], 'AUTOINCREM',
           'SAL_CADMON', 'untDbeCodMontadoraKeyPressSalcomix', 'Consulta de Montadora - Salcomix', qryCadMon, [], []) Then
        Begin
          tela['dbeMontadora']['Text'].Value    := qryCadMon.FieldByName('SAL_CODMON').AsString;
          tela['edtDesMontadora']['Text'].Value := qryCadMon.FieldByName('SAL_DESMON').AsString;
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
