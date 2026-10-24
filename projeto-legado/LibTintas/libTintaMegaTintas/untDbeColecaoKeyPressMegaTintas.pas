unit unTDbeColecaoKeyPressMegaTintas;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untTipoTinta;

type
  TDbeColecaoKeyPressMegaTintas = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

procedure TDbeColecaoKeyPressMegaTintas.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryCadUni: IDataSet;
  strRetorno, strSQL, strSQLWhere: String;

  arrTitCol: Array of String;


  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

begin
  Try
    Try
      qryCadUni := TAutcomTintaFactory.Get.fGetDataSet;

      if TAutcomTintaFactory.Get.fEntraCons(Key) then
      begin
        Key := #0;
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   A.COL_CODCOL, '; pAddNomeColuna('Código');
        strSQL := strSQL + '   A.COL_DESCRI, '; pAddNomeColuna('Descrição');
        strSQL := strSQL + '   A.AUTOINCREM ';
        strSQL := strSQL + ' FROM   ';
        strSQL := strSQL + '   MEG_COLECA A  ';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitCol, ['COL_DESCRI'], 'AUTOINCREM', 'MEG_COLECA', 'unTDbeColecaoKeyPressMegaTintas', 'Consulta de Coleção - Mega Tintas', qryCadUni, [], []) Then
        Begin
          GetFieldByControle('dbeColecao').AsString := qryCadUni.FieldByName('COL_DESCRI').AsString;

          If cadastro.fValidaCampos(tela, cadastro.GetNomeCampoUnidade, tela['dbeColecao']['Text'].Value, strRetorno) Then
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
