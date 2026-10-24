unit untDbeAcabamentoKeyPressAnjoAutomotiva;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeAcabamentoKeyPressAnjoAutomotiva = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

procedure TDbeAcabamentoKeyPressAnjoAutomotiva.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryCadPro : IDataSet;
  strSQL,
  strSQLWhere,
  strSQLGroup : String;

  arrTitCol: Array of String;


  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

begin
  Try
    Try
      qryCadPro := TAutcomTintaFactory.Get.fGetDataSet;

      if TAutcomTintaFactory.Get.fEntraCons(Key) then
      begin
        Key := #0;
        strSQL := strSQL + ' SELECT AJT_ACABAM   '; pAddNomeColuna('Acabamento');
        strSQL := strSQL + '      , AUTOINCREM   ';
        strSQL := strSQL + '   FROM AJT_CADAJT   ';

        strSQLWhere := ' WHERE TRUE';
        strSQLGroup := '  GROUP BY AJT_ACABAM';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrTitCol, ['AJT_ACABAM'], 'AUTOINCREM',
           'AJT_CADAJT', 'untDbeAcabamentoKeyPressAnjoAutomotiva', 'Consulta de Acabamentos - Anjo Automotiva', qryCadPro, [], []) Then
        Begin
          tela['dbeAcabamento']['Text'].Value := qryCadPro.FieldByName('AJT_ACABAM').AsString;
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
