unit untDbeCodProKeyPressNovasFormulasSayerlack;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeCodProKeyPressNovasFormulasSayerlack = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetMenorUnidade(strProdut, strCodBas: String): String;
    function fRetDescUnidade(strCodUni: String): String;
    function fRetUnidadeEmb(strDesEmb:String):String;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodProKeyPress }



function TDbeCodProKeyPressNovasFormulasSayerlack.fRetDescUnidade(
  strCodUni: String): String;
begin
  Result := 'Litros';
  If strCodUni = 'BA' Then
    Result := 'Litros'
  Else If strCodUni = 'QT' Then
    Result := 'Quarto'
  Else If strCodUni = 'GL' Then
    Result := 'Galão'
  Else If strCodUni = 'BH' Then
    Result := 'Lata';
end;

function TDbeCodProKeyPressNovasFormulasSayerlack.fRetMenorUnidade(
  strProdut, strCodBas: String): String;
var
  qryGen: IDataSet;
  strLitro,
  strGalao,
  strLata,
  strQuarto: String;
begin
  strLitro := '';
  strGalao := '';
  strLata  := '';
  strQuarto := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT *                       ' +
                '   FROM SAY_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  INNER JOIN SAY_CADEMB         ' +
                '     ON EMB_DESEMB = BAS_DESEMB ' +
                '  WHERE BAS_CODBAS = :DESBAS    ' +
                '    AND BAS_PRODUT = :PRODUT    ' +
                '   ORDER BY EMB_EMBALA          ' ;

  qryGen.ParamByName('DESBAS').AsString := strCodBas;
  qryGen.ParamByName('PRODUT').AsString := strProdut;
  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If Pos(qryGen.FieldByName('EMB_CODUNI').AsString, 'BA_') > 0 Then
      strLitro := qryGen.FieldByName('BAS_DESEMB').AsString
    Else If Pos(qryGen.FieldByName('EMB_CODUNI').AsString, 'QT_') > 0 Then
      strQuarto := qryGen.FieldByName('BAS_DESEMB').AsString
    Else If qryGen.FieldByName('EMB_CODUNI').AsString = 'GL' Then
      strGalao := qryGen.FieldByName('BAS_DESEMB').AsString
    Else If qryGen.FieldByName('EMB_CODUNI').AsString = 'BH' Then
      strLata := qryGen.FieldByName('BAS_DESEMB').AsString;

    qryGen.Next;
  End;

  If Not (TStrUtils.fEmptyStr(strQuarto)) Then
    Result := strQuarto
  Else If (Not TStrUtils.fEmptyStr(strLitro)) Then
    Result := strLitro
  Else If (Not TStrUtils.fEmptyStr(strGalao)) Then
    Result := strGalao
  Else If (Not TStrUtils.fEmptyStr(strLata)) Then
    Result := strLata;

end;

function TDbeCodProKeyPressNovasFormulasSayerlack.fRetUnidadeEmb(
  strDesEmb: String): String;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   SELECT EMB_CODUNI FROM SAY_CADEMB WHERE EMB_DESEMB = :DESEMB    ';
  qryGen.ParamByName('DESEMB').AsString := strDesEmb;
  qryGen.Open;

  Result := qryGen.FieldByName('EMB_CODUNI').AsString;
end;

procedure TDbeCodProKeyPressNovasFormulasSayerlack.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAux: IDataSet;
  strDesEmb,
  strUniEmb: String;
begin
  Try
    Try
      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;

        qryAux       := TAutcomTintaFactory.Get.fGetDataSet;

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'SAY_CADBAS', 'untDbeCodProKeyPressNovasFormulasSayerlack',
           'Cadastro de Base - Sayerlack - Imobiliaria', 'BAS_CODITE', '') Then //AND BAS_UNIDAD = "LT"
        Begin

          GetFieldByControle('dbeCodBas').AsString  := qryAux.FieldByName('BAS_CODBAS').AsString;
          GetFieldByControle('dbeProduto').AsString := qryAux.FieldByName('BAS_PRODUT').AsString;
          GetFieldByControle('dbeBase').AsString    := qryAux.FieldByName('BAS_BASE__').AsString;


          strDesEmb := fRetMenorUnidade(GetFieldByControle('dbeProduto').AsString, GetFieldByControle('dbeCodBas').AsString);

          GetFieldByControle('dbeEmbalagem').AsString := strDesEmb;

          strUniEmb := fRetUnidadeEmb(strDesEmb);

          Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(strUniEmb);
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
