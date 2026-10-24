unit untDbeAcbNovasformulasKeyPressMontana;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeAcbNovasformulasKeyPressMontana = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses untStrUtils;

procedure TDbeAcbNovasformulasKeyPressMontana.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAcabam   : IDataSet;
  strSQL      : String;
  strSQLWhere : String;
  strRetorno  : String;
  arrTitCol   : Array of String;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

begin
  Try
    Try
      qryAcabam    := TAutcomTintaFactory.Get.fGetDataSet;

      TAutcomTintaFactory.Get.fSenderName('untDbeAcbNovasformulasKeyPressMontana');

      if TAutcomTintaFactory.Get.fEntraCons(Key) then
      begin
        Key := #0;

        strSQL := strSQL + ' SELECT A.BAS_ACABAM '; pAddNomeColuna('Acabamento');
        strSQL := strSQL + '      , A.BAS_PRODUT '; pAddNomeColuna('Produto');
        strSQL := strSQL + '      , A.BAS_DESCRI '; pAddNomeColuna('Base');
        strSQL := strSQL + '      , A.BAS_UNIDAD '; pAddNomeColuna('Unidade');
        strSQL := strSQL + '      , A.AUTOINCREM ';
        strSQL := strSQL + '   FROM MON_CADBAS A';
        strSQL := strSQL + '  INNER JOIN CADITE ON ITE_CODITE = A.BAS_CODITE ';

        strSQLWhere := ' WHERE ((A.BAS_ACABAM IS NOT NULL) AND (A.BAS_ACABAM  <> "")) ';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere ], arrTitCol,
              ['BAS_ACABAM'], 'AUTOINCREM', 'MON_CADBAS', 'untDbeAcbNovasformulasKeyPressMontana', 'Consulta de Acabamentos - Montana', qryAcabam, [], []) Then
        Begin
          GetFieldByControle('dbeAcabamento').AsString := qryAcabam.FieldByName('BAS_ACABAM').AsString;
          GetFieldByControle('dbeProduto').AsString    := qryAcabam.FieldByName('BAS_PRODUT').AsString;
          tela['edtBase']['text'].value                := qryAcabam.FieldByName('BAS_DESCRI').AsString;
          GetFieldByControle('dbeUnidade').AsString    := qryAcabam.FieldByName('BAS_UNIDAD').AsString;

          If cadastro.fValidaCampos(tela, 'NFM_ACABAM', GetFieldByControle('dbeAcabamento').AsString, strRetorno) Then
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
