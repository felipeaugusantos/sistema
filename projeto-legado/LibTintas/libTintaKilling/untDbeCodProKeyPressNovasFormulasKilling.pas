unit untDbeCodProKeyPressNovasFormulasKilling;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeCodProKeyPressNovasFormulasKilling = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetMenorUnidade(strCodBas, strForm: String): String;
    function fRetDescUnidade(strCodUni: String): String;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodProKeyPress }

function TDbeCodProKeyPressNovasFormulasKilling.fRetDescUnidade(
  strCodUni: String): String;
begin
  Result := 'Litros';
  If strCodUni = 'AMO' Then
    Result := 'Amostra'
  Else If Pos(strCodUni, 'LT9_') > 0 Then
    Result := 'Litros'
  Else If (strCodUni = 'GM') Or (strCodUni = 'GP') Then
    Result := 'Galão'
  Else If Pos(strCodUni ,'M18_P18_L18_L18._H18_K18_') > 0 Then
    Result := 'Lata';
end;

function TDbeCodProKeyPressNovasFormulasKilling.fRetMenorUnidade(strCodBas, strForm: String): String;
var
  qryGen: IDataSet;
  strLitro,
  strGalao,
  strLata,
  strAmostra: String;
begin
  Result := '';

  strLitro := '';
  strGalao := '';
  strLata  := '';
  strAmostra := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT BAS_CODUNI              ' +
                '   FROM KILD_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  WHERE BAS_CODBAS = :CODBAS    ' +
                '    AND BAS_CODFML = :FORM    ' +
                '  ORDER BY BAS_EMBALA           ';
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.ParamByName('FORM').AsString := strForm;
  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If qryGen.FieldByName('BAS_CODUNI').AsString = 'AMO' Then
      strAmostra := qryGen.FieldByName('BAS_CODUNI').AsString
    Else If Pos(qryGen.FieldByName('BAS_CODUNI').AsString, 'LT9_') > 0 Then
      strLitro := qryGen.FieldByName('BAS_CODUNI').AsString
    Else If (qryGen.FieldByName('BAS_CODUNI').AsString = 'GM') Or (qryGen.FieldByName('BAS_CODUNI').AsString = 'GP') Then
      strGalao := qryGen.FieldByName('BAS_CODUNI').AsString
    Else If Pos(qryGen.FieldByName('BAS_CODUNI').AsString, 'M18_P18_L18_L18._H18_K18_') > 0 Then
      strLata := qryGen.FieldByName('BAS_CODUNI').AsString;

    qryGen.Next;
  End;

  If (Not TStrUtils.fEmptyStr(strAmostra)) Then
    Result := strAmostra
  Else If (Not TStrUtils.fEmptyStr(strLitro)) Then
    Result := strLitro
  Else If (Not TStrUtils.fEmptyStr(strGalao)) Then
    Result := strGalao
  Else If (Not TStrUtils.fEmptyStr(strLata)) Then
    Result := strLata;
end;

procedure TDbeCodProKeyPressNovasFormulasKilling.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAux: IDataSet;
  strSQLWhere: String;
begin
  Try
    Try
      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;

        qryAux       := TAutcomTintaFactory.Get.fGetDataSet;

        strSQLWhere := ''; //strSQLWhere + ' AND BAS_CODUNI = "LT" ';

        If (Not TStrUtils.fEmptyStr(tela['dbeBase']['Text'].Value)) Then
        Begin
          strSQLWhere := strSQLWhere + ' AND BAS_CODBAS = ' + QuotedStr(tela['dbeBase']['Text'].Value);
        End;

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'KILD_CADBAS','untDbeCodProKeyPressNovasFormulasKilling',
        'Consulta de Bases - Killing','', strSQLWhere) Then
        Begin
          GetFieldByControle('dbeBase').AsString    := qryAux.FieldByName('BAS_CODBAS').AsString;
          GetFieldByControle('dbeCodFml').AsString := qryAux.FieldByName('BAS_CODFML').AsString;
          GetFieldByControle('dbeCodUni').AsString  := fRetMenorUnidade(qryAux.FieldByName('BAS_CODBAS').AsString,
                                                                        qryAux.FieldByName('BAS_CODFML').AsString);

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
