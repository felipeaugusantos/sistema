unit untDbeCodBasKeyPressNovasFormulasGrafftex;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeCodBasKeyPressNovasFormulasGrafftex = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetMenorUnidade(strProdut, strCodBas, strColeca: String): String;
    function fRetMenorVolume(strProduto, strBase, strColeca, strUnidade: String): Double;
    function fRetDescUnidade(strCodUni: String): String;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodBasKeyPress }

function TDbeCodBasKeyPressNovasFormulasGrafftex.fRetDescUnidade(
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

function TDbeCodBasKeyPressNovasFormulasGrafftex.fRetMenorUnidade(strProdut,strCodBas, strColeca: String): String;
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
                '   FROM GRA_CADBAS              ' +
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

function TDbeCodBasKeyPressNovasFormulasGrafftex.fRetMenorVolume(strProduto,
  strBase, strColeca, strUnidade: String): Double;
Var
  qryAux: IDataSet;
begin
  Try
    qryAux := TAutcomTintaFactory.Get.fGetDataSet;
    qryAux.Close;
    qryAux.SQL := '';
    qryAux.SQL := qryAux.SQL + '  SELECT                      ';
    qryAux.SQL := qryAux.SQL + '    BAS_EMBALA                ';
    qryAux.SQL := qryAux.SQL + '  FROM                        ';
    qryAux.SQL := qryAux.SQL + '    GRA_CADBAS                ';
    qryAux.SQL := qryAux.SQL + '  INNER JOIN CADITE ON              ';
    qryAux.SQL := qryAux.SQL + '    BAS_CODITE = ITE_CODITE               ';
    qryAux.SQL := qryAux.SQL + '  WHERE                       ';
    qryAux.SQL := qryAux.SQL + '    BAS_CODBAS = :CODBAS AND        ';
    qryAux.SQL := qryAux.SQL + '    BAS_PRODUT = :PRODUT AND        ';
    qryAux.SQL := qryAux.SQL + '    BAS_CODUNI = :UNIDAD            ';

    qryAux.ParamByName('CODBAS').AsString := strBase;
    qryAux.ParamByName('PRODUT').AsString := strProduto;
    qryAux.ParamByName('UNIDAD').AsString := strUnidade;
    qryAux.Open;

    Result := qryAux.FieldByName('BAS_EMBALA').AsFloat;
  Except
    Raise;
  End;
end;

procedure TDbeCodBasKeyPressNovasFormulasGrafftex.OnKeyPress(Sender: TObject; var Key: Char);
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

        strSQLWhere := '';

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'GRA_CADBAS',
          'untDbeCodBasKeyPressNovasFormulasGrafftex', 'Consulta de Bases - Grafftex', 'BAS_CODITE', strSQLWhere) Then
        Begin
          GetFieldByControle('dbeBase').AsString   := qryAux.FieldByName('BAS_CODBAS').AsString;
          GetFieldByControle('dbeProduto').AsString := qryAux.FieldByName('BAS_PRODUT').AsString;
          Tela['edtDescricaoBase']['text'].Value   := qryAux.FieldByName('BAS_DESCRI').AsString;
          GetFieldByControle('dbeCodUni').AsString := fRetMenorUnidade(qryAux.FieldByName('BAS_PRODUT').AsString
                                                                     , qryAux.FieldByName('BAS_CODBAS').AsString,
                                                                       qryAux.FieldByName('BAS_COLECA').AsString);

          GetFieldByControle('dbeVolume').AsFloat  := fRetMenorVolume(GetFieldByControle('dbeProduto').AsString,
                                                                      GetFieldByControle('dbeBase').AsString,
                                                                      GetFieldByControle('dbeColeca').AsString,
                                                                      GetFieldByControle('dbeCodUni').AsString);

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
