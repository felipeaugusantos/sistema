unit untDbeAcabamentoKeyPressMontana;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeAcabamentoKeyPressMontana = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses untStrUtils;

procedure TDbeAcabamentoKeyPressMontana.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAcabam : IDataSet;
  strSQL      : String;
  strSQLWhere : String;
  strSQLGroup : String;
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

      TAutcomTintaFactory.Get.fSenderName('untDbeAcabamentoKeyPressMontana');

      if TAutcomTintaFactory.Get.fEntraCons(Key) then
      begin
        Key := #0;

        strSQL :=  strSQL +' SELECT BAS_ACABAM '; pAddNomeColuna('Acabamento');
        strSQL :=  strSQL +'      , AUTOINCREM ';
        strSQL :=  strSQL +'   FROM MON_CADBAS ';

        strSQLWhere :=
                  '  WHERE TRUE '+
                  '    AND ((BAS_ACABAM IS NOT NULL) AND (BAS_ACABAM  <> "")) ';
//                  '    AND BAS_PRODUT =  "'+ tela['dbeProduto']['Text'].Value +'"'+
//                  '    AND BAS_UNIDAD = "' + tela['dbeCodUni']['Text'].Value + '"';

        strSQLGroup :=
                  '  GROUP BY BAS_ACABAM ';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere, strSQLGroup], arrTitCol,
              ['BAS_ACABAM'], 'AUTOINCREM', 'MON_CADBAS', 'untDbeAcabamentoKeyPressMontana', 'Consulta de Acabamentos - Montana', qryAcabam, [], []) Then
        Begin
          GetFieldByControle('dbeAcabamento').AsString := qryAcabam.FieldByName('BAS_ACABAM').AsString;

          If Not TStrUtils.fEmptyStr(GetFieldByControle('dbeAcabamento').AsString)Then
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
