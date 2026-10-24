unit untDbeCodProKeyPressNovasFormulasBrasimixImobiliaria;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeCodProKeyPressNovasFormulasBrasimixImobiliaria = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetMenorUnidade(strLinha, strProdut, strCodBas: String): String;
    function fRetMenorVolume(strLinha, strProdut, strCodBas, strUnidad: String): Double;
    function fRetDescUnidade(strCodUni: String): String;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodProKeyPress }

function TDbeCodProKeyPressNovasFormulasBrasimixImobiliaria.fRetDescUnidade(
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

function TDbeCodProKeyPressNovasFormulasBrasimixImobiliaria.fRetMenorUnidade(strLinha, strProdut, strCodBas: String): String;
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
                '   FROM BZI_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  WHERE BAS_LINHA_ = :LINHA_    ' +
                '    AND BAS_BASE__ = :CODBAS    ' +
                '    AND BAS_DESCRI = :DESCRI    ' +
                '  ORDER BY BAS_UNIDAD           ';

  qryGen.ParamByName('LINHA_').AsString := strLinha;
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.ParamByName('DESCRI').AsString := strProdut;
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

function TDbeCodProKeyPressNovasFormulasBrasimixImobiliaria.fRetMenorVolume(
  strLinha, strProdut, strCodBas, strUnidad: String): Double;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT BAS_EMBALA              ' +
                '   FROM BZI_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  WHERE BAS_LINHA_ = :LINHA_    ' +
                '    AND BAS_BASE__ = :CODBAS    ' +
                '    AND BAS_DESCRI = :DESCRI    ' +
                '    AND BAS_UNIDAD = :UNIDAD    ';

  qryGen.ParamByName('LINHA_').AsString := strLinha;
  qryGen.ParamByName('DESCRI').AsString := strProdut;
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.ParamByName('UNIDAD').AsString := strUnidad;
  qryGen.Open;

  Result := qryGen.FieldByName('BAS_EMBALA').AsFloat;
end;

procedure TDbeCodProKeyPressNovasFormulasBrasimixImobiliaria.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAux: IDataSet;

begin
  Try
    Try
      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;
        qryAux       := TAutcomTintaFactory.Get.fGetDataSet;


        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'BZI_CADBAS', 'untDbeCodProKeyPressNovasFormulasBrasimixImobiliaria',
          'Consulta de Bases - Brasimix Imobiliária', '', '') Then
        Begin
          GetFieldByControle('dbeLinha').AsString  := qryAux.FieldByName('BAS_LINHA_').AsString;
          GetFieldByControle('dbeBase').AsString   := qryAux.FieldByName('BAS_BASE__').AsString;
          GetFieldByControle('dbeProduto').AsString := qryAux.FieldByName('BAS_DESCRI').AsString;
          GetFieldByControle('dbeUnidad').AsString := fRetMenorUnidade(qryAux.FieldByName('BAS_LINHA_').AsString,
                                                                       qryAux.FieldByName('BAS_DESCRI').AsString,
                                                                       qryAux.FieldByName('BAS_BASE__').AsString);
          GetFieldByControle('dbeEmbalagem').AsFloat := fRetMenorVolume(qryAux.FieldByName('BAS_LINHA_').AsString,
                                                                        qryAux.FieldByName('BAS_DESCRI').AsString,
                                                                        qryAux.FieldByName('BAS_BASE__').AsString,
                                                                        GetFieldByControle('dbeUnidad').AsString);

          Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetFieldByControle('dbeUnidad').AsString);
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
