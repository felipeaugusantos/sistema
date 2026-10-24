unit untDbeCodBasKeyPressNovasFormulasMegaTintas;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeCodBasKeyPressNovasFormulasMegaTintas = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetMenorUnidade(strProdut, strCodBas: String): String;
    function fRetDescUnidade(strCodUni: String): String;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodBasKeyPress }

function TDbeCodBasKeyPressNovasFormulasMegaTintas.fRetDescUnidade(
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

function TDbeCodBasKeyPressNovasFormulasMegaTintas.fRetMenorUnidade(strProdut,strCodBas: String): String;
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
                '   FROM MEG_CADBAS              ' +
                '  INNER JOIN CADITE ON ITE_CODITE = BAS_CODITE ' +
                '  WHERE BAS_PRODUT = :PRODUT    ' +
                '    AND BAS_CODBAS = :CODBAS    ' +
                '  ORDER BY BAS_CODUNI           ';
  qryGen.ParamByName('PRODUT').AsString := strProdut;
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If Pos(qryGen.FieldByName('BAS_CODUNI').AsString, 'LT_QT_') > 0 Then
      strLitro := qryGen.FieldByName('BAS_CODUNI').AsString
    Else If qryGen.FieldByName('BAS_CODUNI').AsString = 'GL' Then
      strGalao := qryGen.FieldByName('BAS_CODUNI').AsString
    Else If qryGen.FieldByName('BAS_CODUNI').AsString = 'LA' Then
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

procedure TDbeCodBasKeyPressNovasFormulasMegaTintas.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAux: IDataSet;
  strSQLWhere: String;
begin
  Try
    Try
      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;

        qryAux := TAutcomTintaFactory.Get.fGetDataSet;

        strSQLWhere := ' AND BAS_PRODUT = "'+ GetFieldByControle('dbeProduto').AsString + '"';

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'MEG_CADBAS',
          'untDbeCodBasKeyPressNovasFormulasMegaTintas', 'Consulta de Bases - Mega Tintas', 'BAS_CODITE', strSQLWhere) Then
        Begin
          GetFieldByControle('dbeBase').AsString   := qryAux.FieldByName('BAS_CODBAS').AsString;
          Tela['edtDescricaoBase']['text'].Value   := qryAux.FieldByName('BAS_DESCRI').AsString;
          GetFieldByControle('dbeCodUni').AsString := fRetMenorUnidade(qryAux.FieldByName('BAS_PRODUT').AsString
                                                                     , qryAux.FieldByName('BAS_CODBAS').AsString);

          Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetFieldByControle('dbeCodUni').AsString);
          Tela.SelectNext;
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
