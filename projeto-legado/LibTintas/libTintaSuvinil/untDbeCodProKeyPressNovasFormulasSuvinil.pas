unit untDbeCodProKeyPressNovasFormulasSuvinil;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeCodProKeyPressNovasFormulasSuvinil = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetMenorUnidade(strCodFml, strCodBas: String): String;
    function fRetDescUnidade(strCodUni: String): String;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodProKeyPress }

function TDbeCodProKeyPressNovasFormulasSuvinil.fRetDescUnidade(
  strCodUni: String): String;
begin
  Result := 'Litros';
  If Pos(strCodUni, 'LT_QT_') > 0 Then
    Result := 'Litros'
  Else If strCodUni = 'GL' Then
    Result := 'Galão'
  Else If strCodUni = 'BD' Then
    Result := 'Balde'
  Else If Pos(strCodUni, 'LA_1J_2J_3J_4J_5J_6J_') > 0 Then
    Result := 'Lata';
end;

function TDbeCodProKeyPressNovasFormulasSuvinil.fRetMenorUnidade(strCodFml,
  strCodBas: String): String;
var
  qryGen: IDataSet;
  strLitro,
  strGalao,
  strLata,
  strBalde: String;
begin
  Result := '';

  strLitro := '';
  strGalao := '';
  strLata  := '';
  strBalde := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT SUV_CODUNI              ' +
                '   FROM SUV_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = SUV_CODITE ' +
                '  WHERE SUV_CODFML = :CODFML    ' +
                '    AND SUV_CODBAS = :CODBAS    ' +
                '  ORDER BY SUV_CODUNI DESC      ';
  qryGen.ParamByName('CODFML').AsString := strCodFml;
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If Pos(qryGen.FieldByName('SUV_CODUNI').AsString, 'LT_QT_') > 0 Then
      strLitro := qryGen.FieldByName('SUV_CODUNI').AsString
    Else If qryGen.FieldByName('SUV_CODUNI').AsString = 'GL' Then
      strGalao := qryGen.FieldByName('SUV_CODUNI').AsString
    Else If Pos(qryGen.FieldByName('SUV_CODUNI').AsString, 'LA_1J_2J_3J_4J_5J_6J_') > 0 Then
      strLata := qryGen.FieldByName('SUV_CODUNI').AsString
    Else If qryGen.FieldByName('SUV_CODUNI').AsString = 'BD' Then
      strBalde := qryGen.FieldByName('SUV_CODUNI').AsString;

    qryGen.Next;
  End;

  If (Not TStrUtils.fEmptyStr(strLitro)) Then
    Result := strLitro
  Else If (Not TStrUtils.fEmptyStr(strGalao)) Then
    Result := strGalao
  Else If (Not TStrUtils.fEmptyStr(strBalde)) Then
    Result := strBalde
  Else If (Not TStrUtils.fEmptyStr(strLata)) Then
    Result := strLata;
end;

procedure TDbeCodProKeyPressNovasFormulasSuvinil.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAux: IDataSet;

begin
  Try
    Try
      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;
        qryAux       := TAutcomTintaFactory.Get.fGetDataSet;


        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'SUV_CADBAS', 'untDbeCodProKeyPressNovasFormulasSuvinil',
          'Consulta de Bases - Suvinil', '', '') Then //AND SUV_CODUNI = "LT"
        Begin
          GetFieldByControle('dbeCodPro').AsString := qryAux.FieldByName('SUV_CODFML').AsString;
          GetFieldByControle('dbeBase').AsString   := qryAux.FieldByName('SUV_CODBAS').AsString;
          GetFieldByControle('dbeDescri').AsString := qryAux.FieldByName('SUV_DESCRI').AsString;

          GetFieldByControle('dbeUnidad').AsString := fRetMenorUnidade(qryAux.FieldByName('SUV_CODFML').AsString, qryAux.FieldByName('SUV_CODBAS').AsString);

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
