unit untDbeCodProKeyPressNovasFormulasIquine;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeCodProKeyPressNovasFormulasIquine = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetMenorConteudo(strCodBas, strDesBas, strProdut, strUnidade: String): Double;
    function fRetMenorUnidade(strProdut, strCodBas, strDesBas: String): String;
    function fRetDescUnidade(strCodUni: String): String;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodProKeyPress }

function TDbeCodProKeyPressNovasFormulasIquine.fRetDescUnidade(
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

function TDbeCodProKeyPressNovasFormulasIquine.fRetMenorConteudo(strCodBas,
  strDesBas, strProdut, strUnidade: String): Double;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT BAS_EMBALA           ' +
                '   FROM IQU_CADBAS           ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  WHERE BAS_DESCRI = :DESCRI    ' +
                '    AND BAS_BASE__ = :CODBAS    ' +
                '    AND BAS_PRODUT = :PRODUT    ' +
                '    AND BAS_UNIDAD = :UNIDAD    ' +
                '  ORDER BY BAS_UNIDAD, BAS_EMBALA   ';
  qryGen.ParamByName('PRODUT').AsString := strProdut;
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.ParamByName('DESCRI').AsString := strDesBas;
  qryGen.ParamByName('UNIDAD').AsString := strUnidade;
  qryGen.Open;

  Result := qryGen.FieldByName('BAS_EMBALA').AsFloat;
end;

function TDbeCodProKeyPressNovasFormulasIquine.fRetMenorUnidade(
  strProdut, strCodBas, strDesBas: String): String;
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
  qryGen.SQL := ' SELECT BAS_UNIDAD              ' +
                '   FROM IQU_CADBAS           ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  WHERE BAS_DESCRI = :DESCRI    ' +
                '    AND BAS_BASE__ = :CODBAS    ' +
                '    AND BAS_PRODUT = :PRODUT    ' +
                '  ORDER BY BAS_UNIDAD           ';
  qryGen.ParamByName('DESCRI').AsString := strDesBas;
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.ParamByName('PRODUT').AsString := strProdut;
  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If Pos(qryGen.FieldByName('BAS_UNIDAD').AsString, 'LT_QT_') > 0 Then
      strLitro := qryGen.FieldByName('BAS_UNIDAD').AsString
    Else If qryGen.FieldByName('BAS_UNIDAD').AsString = 'GL' Then
      strGalao := qryGen.FieldByName('BAS_UNIDAD').AsString
    Else If qryGen.FieldByName('BAS_UNIDAD').AsString = 'LA' Then
      strLata := qryGen.FieldByName('BAS_UNIDAD').AsString;

    qryGen.Next;
  End;

  If (Not TStrUtils.fEmptyStr(strLitro)) Then
    Result := strLitro
  Else If (Not TStrUtils.fEmptyStr(strGalao)) Then
    Result := strGalao
  Else If (Not TStrUtils.fEmptyStr(strLata)) Then
    Result := strLata;
end;

procedure TDbeCodProKeyPressNovasFormulasIquine.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAux: IDataSet;
begin
  Try
    Try
      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;

        qryAux       := TAutcomTintaFactory.Get.fGetDataSet;

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'IQU_CADBAS', 'untDbeCodProKeyPressNovasFormulasIquine',
           'Cadastro de Base - Iquine - Imobiliaria', 'BAS_CODITE', '') Then //AND BAS_UNIDAD = "LT"
        Begin
          GetFieldByControle('dbeBase').AsString   := qryAux.FieldByName('BAS_BASE__').AsString;
          GetFieldByControle('dbeDescriB').AsString := qryAux.FieldByName('BAS_DESCRI').AsString;
          GetFieldByControle('dbeProdut').AsString := qryAux.FieldByName('BAS_PRODUT').AsString;

          GetFieldByControle('dbeCodUni').AsString := fRetMenorUnidade(qryAux.FieldByName('BAS_PRODUT').AsString, qryAux.FieldByName('BAS_BASE__').AsString, qryAux.FieldByName('BAS_DESCRI').AsString);
          GetFieldByControle('dbeEmbalagem').AsFloat := fRetMenorConteudo(qryAux.FieldByName('BAS_BASE__').AsString,
                                                                          qryAux.FieldByName('BAS_DESCRI').AsString,
                                                                          qryAux.FieldByName('BAS_PRODUT').AsString,
                                                                          GetFieldByControle('dbeCodUni').AsString);

          Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetFieldByControle('dbeCodUni').AsString);

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
