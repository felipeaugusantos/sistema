unit untDbeCodProKeyPressNovasFormulasUniverso;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeCodProKeyPressNovasFormulasUniverso = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetMenorUnidade(strLinha, strCodBas: String): String;
    function fRetDescUnidade(strCodUni: String): String;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodProKeyPress }


function TDbeCodProKeyPressNovasFormulasUniverso.fRetDescUnidade(
  strCodUni: String): String;
begin
  Result := 'Litros';
  If strCodUni = 'TT' Then
    Result := 'TT'
  Else If Pos(strCodUni, 'LT_QT_') > 0 Then
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

function TDbeCodProKeyPressNovasFormulasUniverso.fRetMenorUnidade(strLinha,
  strCodBas: String): String;
var
  qryGen: IDataSet;
  strLitro,
  strGalao,
  strTT,
  strLata: String;
begin
  Result := '';

  strLitro := '';
  strGalao := '';
  strLata  := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT BAS_UNIDAD              ' +
                '   FROM UNI_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  WHERE BAS_PRODUT = :PRODUT    ' +
                '    AND BAS_CODBAS = :CODBAS    ' +
                '  ORDER BY BAS_UNIDAD           ';
  qryGen.ParamByName('PRODUT').AsString := strLinha;
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If qryGen.FieldByName('BAS_UNIDAD').AsString = 'TT' Then
      strTT := qryGen.FieldByName('BAS_UNIDAD').AsString
    Else If Pos(qryGen.FieldByName('BAS_UNIDAD').AsString, 'LT_QT_') > 0 Then
      strLitro := qryGen.FieldByName('BAS_UNIDAD').AsString
    Else If qryGen.FieldByName('BAS_UNIDAD').AsString = 'GL' Then
      strGalao := qryGen.FieldByName('BAS_UNIDAD').AsString
    Else If qryGen.FieldByName('BAS_UNIDAD').AsString = 'LA' Then
      strLata := qryGen.FieldByName('BAS_UNIDAD').AsString;

    qryGen.Next;
  End;

  If (Not TStrUtils.fEmptyStr(strTT)) Then
    Result := strTT
  Else If (Not TStrUtils.fEmptyStr(strLitro)) Then
    Result := strLitro
  Else If (Not TStrUtils.fEmptyStr(strGalao)) Then
    Result := strGalao
  Else If (Not TStrUtils.fEmptyStr(strLata)) Then
    Result := strLata;
end;

procedure TDbeCodProKeyPressNovasFormulasUniverso.OnKeyPress(Sender: TObject; var Key: Char);
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

        If (Not TStrUtils.fEmptyStr(tela['dbeCodBase']['Text'].Value)) Then
        Begin
          strFiltro := strFiltro + ' AND BAS_CODBAS = ' + QuotedStr(tela['dbeCodBase']['Text'].Value);
        End;

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'UNI_CADBAS', 'untDbeCodProKeyPressNovasFormulasUniverso',
          'Consulta de Bases - Universo Imobiliária', '', strFiltro) Then
        Begin
          GetFieldByControle('dbeCodBase').AsString    := qryAux.FieldByName('BAS_CODBAS').AsString;
          GetFieldByControle('dbeProduto').AsString := qryAux.FieldByName('BAS_PRODUT').AsString;

          GetFieldByControle('dbeUnidad').AsString  := fRetMenorUnidade(qryAux.FieldByName('BAS_PRODUT').AsString, qryAux.FieldByName('BAS_CODBAS').AsString);

          Tela['lblQtdML']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetFieldByControle('dbeUnidad').AsString);
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
