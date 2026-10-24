unit untDbeCodProKeyPressNovasFormulasCalamar;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeCodProKeyPressNovasFormulasCalamar = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetMenorUnidade(strProdut, strCodBas: String): String;
    function fRetDescUnidade(strCodUni: String): String;
    function fRetUnidadeEmbalagem(strCodEmb:String):String;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodProKeyPress }



function TDbeCodProKeyPressNovasFormulasCalamar.fRetDescUnidade(
  strCodUni: String): String;
begin
  Result := 'Litros';
  If strCodUni = 'LT' Then
    Result := 'Litros'
  Else If strCodUni = 'QT' Then
    Result := 'Quarto'
  Else If strCodUni = 'GL' Then
    Result := 'Galão'
  Else If strCodUni = 'LA' Then
    Result := 'Lata';
end;

function TDbeCodProKeyPressNovasFormulasCalamar.fRetMenorUnidade(
  strProdut, strCodBas: String): String;
var
  qryGen: IDataSet;
  strLitro,
  strGalao,
  strQuarto,
  strLata: String;
begin
  strLitro := '';
  strGalao := '';
  strLata  := '';
  strQuarto := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT BAS_CODEMB              ' +
                '      , EMB_CODUNI              ' +
                '   FROM CAL_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  INNER JOIN CAL_CADEMB         ' +
                '     ON EMB_CODEMB = BAS_CODEMB ' +
                '  WHERE BAS_CODBAS = :DESBAS    ' +
                '    AND BAS_DESCRI = :PRODUT    ' +
                '  ORDER BY EMB_TAMEMB           ' ;
  qryGen.ParamByName('DESBAS').AsString := strCodBas;
  qryGen.ParamByName('PRODUT').AsString := strProdut;
  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If qryGen.FieldByName('EMB_CODUNI').AsString = 'QT' Then
      strQuarto := qryGen.FieldByName('BAS_CODEMB').AsString
    Else If qryGen.FieldByName('EMB_CODUNI').AsString = 'LT' Then
      strLitro := qryGen.FieldByName('BAS_CODEMB').AsString
    Else If qryGen.FieldByName('EMB_CODUNI').AsString = 'GL' Then
      strGalao := qryGen.FieldByName('BAS_CODEMB').AsString
    Else If qryGen.FieldByName('EMB_CODUNI').AsString = 'LA' Then
      strLata := qryGen.FieldByName('BAS_CODEMB').AsString;

    qryGen.Next;
  End;

  If (Not TStrUtils.fEmptyStr(strQuarto)) Then
    Result := strQuarto
  Else If (Not TStrUtils.fEmptyStr(strLitro)) Then
    Result := strLitro
  Else If (Not TStrUtils.fEmptyStr(strGalao)) Then
    Result := strGalao
  Else If (Not TStrUtils.fEmptyStr(strLata)) Then
    Result := strLata;

end;

function TDbeCodProKeyPressNovasFormulasCalamar.fRetUnidadeEmbalagem(
  strCodEmb: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT EMB_CODUNI ' +
                '   FROM CAL_CADEMB ' +
                ' WHERE EMB_CODEMB = :CODEMB  ';
  qryGen.ParamByName('CODEMB').AsString := strCodEmb;
  qryGen.Open;

  Result := qryGen.FieldByName('EMB_CODUNI').AsString;
end;

procedure TDbeCodProKeyPressNovasFormulasCalamar.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAux: IDataSet;
  strUnidade: String;
  strUniEmbalagem:String;
begin
  Try
    Try
      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;

        qryAux       := TAutcomTintaFactory.Get.fGetDataSet;

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'CAL_CADBAS', 'untDbeCodProKeyPressNovasFormulasCalamar',
           'Cadastro de Base - Calamar - Imobiliaria', 'BAS_CODITE', '') Then //AND BAS_UNIDAD = "LT"
        Begin
          GetFieldByControle('dbeBase').AsString   := qryAux.FieldByName('BAS_CODBAS').AsString;
          //GetFieldByControle('dbeProdut').AsString := qryAux.FieldByName('BAS_DESCRI').AsString;

          strUnidade := fRetMenorUnidade(qryAux.FieldByName('BAS_DESCRI').AsString, qryAux.FieldByName('BAS_CODBAS').AsString);


          GetFieldByControle('dbeEmbala').AsString := strUnidade;
          strUniEmbalagem := fRetUnidadeEmbalagem(GetFieldByControle('dbeEmbala').AsString);
          Tela['edtUniEmb']['Text'].Value := strUniEmbalagem;
          Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(strUniEmbalagem);

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
