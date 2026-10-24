unit untDbeCodProKeyPressNovasFormulasSparlack;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeCodProKeyPressNovasFormulasSparlack = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetMenorUnidade(strCodBas, strProduto: String): String;
    function fRetDescUnidade(strCodUni: String): String;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodProKeyPress }

function TDbeCodProKeyPressNovasFormulasSparlack.fRetDescUnidade(
  strCodUni: String): String;
begin
  Result := 'Litros';
  If Pos(strCodUni, 'LT_QT_') > 0 Then
    Result := 'Litros'
  Else If strCodUni = 'GL' Then
    Result := 'Galão'
  Else If strCodUni = 'LA' Then
    Result := 'Lata';
end;

function TDbeCodProKeyPressNovasFormulasSparlack.fRetMenorUnidade(strCodBas, strProduto: String): String;
var
  qryGen: IDataSet;
  strLitro,
  strGalao,
  strLata: String;
begin
  Result := '';

  strLitro := '';
  strGalao := '';
  strLata  := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT BAS_CODUNI              ' +
                '   FROM SPA_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  INNER JOIN CADUNI             ' +
                '     ON UNI_CODUNI = BAS_CODUNI ' +
                '  WHERE BAS_CODBAS = :CODBAS    ' +
                '    AND BAS_PRODUT = :PRODUT    ' +
                '  ORDER BY UNI_PESLIT           ';
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.ParamByName('PRODUT').AsString := strProduto;
  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If Pos(qryGen.FieldByName('BAS_CODUNI').AsString, 'QT_') > 0 Then
      strLitro := qryGen.FieldByName('BAS_CODUNI').AsString
    Else If qryGen.FieldByName('BAS_CODUNI').AsString = 'GL' Then
      strGalao := qryGen.FieldByName('BAS_CODUNI').AsString
    Else If qryGen.FieldByName('BAS_CODUNI').AsString = 'BL' Then
      strLata := qryGen.FieldByName('BAS_CODUNI').AsString;

    qryGen.Next;
  End;

  If (Not TStrUtils.fEmptyStr(strLitro)) Then
    Result := strLitro
  Else If (Not TStrUtils.fEmptyStr(strGalao)) Then
    Result := strGalao
  Else If (Not TStrUtils.fEmptyStr(strLata)) Then
    Result := strLata;
end;

procedure TDbeCodProKeyPressNovasFormulasSparlack.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAux     : IDataSet;
  strSQL     : String;
  strSQLWhere: String;

  arrTitCol: Array of String;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

begin
  Try
    Try
      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;

        qryAux       := TAutcomTintaFactory.Get.fGetDataSet;

        strSQL := '';

        strSQL := strSQL + 'SELECT BAS_CODBAS'; pAddNomeColuna('Código');
        strSQL := strSQL + '     , BAS_DESCRI'; pAddNomeColuna('Descrição');
        strSQL := strSQL + '     , BAS_PRODUT'; pAddNomeColuna('Produto');
        strSQL := strSQL + '     , BAS_CODUNI'; pAddNomeColuna('Unidade');
        strSQL := strSQL + '     , A.AUTOINCREM ';
        strSQL := strSQL + '  FROM SPA_CADBAS A ';
        strSQL := strSQL + '  INNER JOIN CADITE ON ITE_CODITE = BAS_CODITE';


        strSQLWhere := '';

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitCol, ['BAS_CODBAS'], 'AUTOINCREM', 'SPA_CADBAS',
          'untDbeCodProKeyPressNovasFormulasSparlack', 'Consulta de Bases - Sparlack', qryAux, [], []) Then
        Begin
          GetFieldByControle('dbeBase').AsString    := qryAux.FieldByName('BAS_CODBAS').AsString;
          Tela['edtBaseDescricao']['Text'].Value    := qryAux.FieldByName('BAS_DESCRI').AsString;
          GetFieldByControle('dbeProduto').AsString := qryAux.FieldByName('BAS_PRODUT').AsString;
          GetFieldByControle('dbeCodUni').AsString  := fRetMenorUnidade( qryAux.FieldByName('BAS_CODBAS').AsString
                                                                       , qryAux.FieldByName('BAS_PRODUT').AsString);

          Tela['Label5']['Caption'].Value := 'Informar a Quantidade sempre em ' + fRetDescUnidade(GetFieldByControle('dbeCodUni').AsString);

          tela.SelectNext;
        End;
      End;
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
