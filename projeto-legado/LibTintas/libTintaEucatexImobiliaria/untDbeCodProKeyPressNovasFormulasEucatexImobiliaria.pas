unit untDbeCodProKeyPressNovasFormulasEucatexImobiliaria;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeCodProKeyPressNovasFormulasEucatexImobiliaria = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetMenorVolume(strProdut, strCodBas, strUnidad: String): Double;
    function fRetMenorUnidade(strLinha, strCodBas: String): String;
    function fRetDescUnidade(strCodUni: String): String;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodProKeyPress }

function TDbeCodProKeyPressNovasFormulasEucatexImobiliaria.fRetDescUnidade(
  strCodUni: String): String;
begin
  Result := 'Litros';
  If Pos(strCodUni, 'LT_QT_') > 0 Then
  Begin
    If strCodUni = 'LT' Then
      Result := 'Litros'
    Else
      Result := 'Quarto';
  End
  Else If strCodUni = 'GL' Then
    Result := 'Galão'
  Else If strCodUni = 'LA' Then
    Result := 'Lata';
end;

function TDbeCodProKeyPressNovasFormulasEucatexImobiliaria.fRetMenorUnidade(strLinha,
  strCodBas: String): String;
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
  qryGen.SQL := ' SELECT *                       ' +
                '   FROM EUC_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  WHERE BAS_PRODUT = :PRODUT    ' +
                '    AND BAS_DESCRI = :CODBAS    ' +
                '  ORDER BY BAS_CODUNI           ';
  qryGen.ParamByName('PRODUT').AsString := strLinha;
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

function TDbeCodProKeyPressNovasFormulasEucatexImobiliaria.fRetMenorVolume(
  strProdut, strCodBas, strUnidad: String): Double;
var
  qryGen: IDataSet;
begin
  Result := 0.800;

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT A.BAS_EMBALA              ' +
                '   FROM EUC_CADBAS A             ' +
                '  INNER JOIN CADITE B            ' +
                '     ON B.ITE_CODITE = A.BAS_CODITE ' +
                '  WHERE A.BAS_DESCRI = :DESBAS    ' +
                '    AND A.BAS_PRODUT = :PRODUT    ' +
                '    AND A.BAS_CODUNI = :UNIDAD    ' +
                '  ORDER BY A.BAS_EMBALA ASC       ' +
                '  LIMIT 1 ';
  qryGen.ParamByName('DESBAS').AsString := strCodBas;
  qryGen.ParamByName('PRODUT').AsString := strProdut;
  qryGen.ParamByName('UNIDAD').AsString := strUnidad;
  qryGen.Open;

  If qryGen.IsEmpty Then
    Exit;

  Result := qryGen.FieldByName('BAS_EMBALA').AsFloat;
end;

procedure TDbeCodProKeyPressNovasFormulasEucatexImobiliaria.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAux: IDataSet;
  strFiltro: String;
begin
  Try
    Try
      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key       := #0;

        qryAux    := TAutcomTintaFactory.Get.fGetDataSet;

        strFiltro := '';

        If (Not TStrUtils.fEmptyStr(tela['dbeBase']['Text'].Value)) Then
        Begin
          strFiltro := strFiltro + ' AND BAS_DESCRI = ' + QuotedStr(tela['dbeBase']['Text'].Value);
        End;

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'EUC_CADBAS', 'untDbeCodProKeyPressNovasFormulasEucatexImobiliaria',
          'Consulta de Bases - Eucatex Imobiliária', '', strFiltro) Then
        Begin
          GetFieldByControle('dbeBase').AsString    := qryAux.FieldByName('BAS_DESCRI').AsString;
          GetFieldByControle('dbeProduto').AsString := qryAux.FieldByName('BAS_PRODUT').AsString;
          GetFieldByControle('dbeUnidad').AsString  := fRetMenorUnidade(qryAux.FieldByName('BAS_PRODUT').AsString, qryAux.FieldByName('BAS_DESCRI').AsString);
          GetFieldByControle('dbeEmbalagem').AsFloat := fRetMenorVolume(qryAux.FieldByName('BAS_PRODUT').AsString,
                                                                        qryAux.FieldByName('BAS_DESCRI').AsString,
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
