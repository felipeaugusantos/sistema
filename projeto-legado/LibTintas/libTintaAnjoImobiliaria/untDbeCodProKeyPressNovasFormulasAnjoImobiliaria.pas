unit untDbeCodProKeyPressNovasFormulasAnjoImobiliaria;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeCodProKeyPressNovasFormulasAnjoImobiliaria = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetMenorUnidade(strProKey, strSubKey, strCodBas: String): String;
    function fRetDescUnidade(strCodUni: String): String;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodProKeyPress }

function TDbeCodProKeyPressNovasFormulasAnjoImobiliaria.fRetDescUnidade(
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

function TDbeCodProKeyPressNovasFormulasAnjoImobiliaria.fRetMenorUnidade(strProKey, strSubKey, strCodBas: String): String;
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
                '   FROM ANJ_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  WHERE BAS_PROKEY = :PROKEY    ' +
                '    AND BAS_SUBKEY = :SUBKEY    ' +
                '    AND BAS_BASE__ = :CODBAS    ' +
                '  ORDER BY BAS_UNIDAD           ';
  qryGen.ParamByName('PROKEY').AsString := strProKey;
  qryGen.ParamByName('SUBKEY').AsString := strSubKey;
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
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

procedure TDbeCodProKeyPressNovasFormulasAnjoImobiliaria.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAux: IDataSet;

begin
  Try
    Try
      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;
        qryAux       := TAutcomTintaFactory.Get.fGetDataSet;


        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'ANJ_CADBAS', 'untDbeCodProKeyPressNovasFormulasAnjoImobiliaria',
          'Consulta de Bases - Anjo Imobiliária', '', '') Then
        Begin
          GetFieldByControle('dbeBase').AsString   := qryAux.FieldByName('BAS_BASE__').AsString;
          GetFieldByControle('dbeProKey').AsString := qryAux.FieldByName('BAS_PROKEY').AsString;
          GetFieldByControle('dbeSubKey').AsString := qryAux.FieldByName('BAS_SUBKEY').AsString;
          GetFieldByControle('dbeDescri').AsString := qryAux.FieldByName('BAS_DESCRI').AsString;

          GetFieldByControle('dbeUnidad').AsString := fRetMenorUnidade( qryAux.FieldByName('BAS_PROKEY').AsString
                                                                      , qryAux.FieldByName('BAS_SUBKEY').AsString
                                                                      , qryAux.FieldByName('BAS_BASE__').AsString);

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
