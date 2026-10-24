unit untDbeCodProKeyPressNovasFormulasFutura;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeCodProKeyPressNovasFormulasFutura = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetMenorUnidade(strCodFml, strCodBas, strProdut: String): String;
    function fRetDescUnidade(strCodUni: String): String;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodProKeyPress }

function TDbeCodProKeyPressNovasFormulasFutura.fRetMenorUnidade(
  strCodFml, strCodBas, strProdut: String): String;
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
                '   FROM FUT_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  WHERE BAS_CODFML = :CODFML    ' +
                '    AND BAS_CODBAS = :CODBAS    ' +
                '    AND BAS_PRODUT = :PRODUT    ' +
                '  ORDER BY BAS_CODUNI           ';
  qryGen.ParamByName('CODFML').AsString := strCodFml;
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.ParamByName('PRODUT').AsString := strProdut;
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

function TDbeCodProKeyPressNovasFormulasFutura.fRetDescUnidade(
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

procedure TDbeCodProKeyPressNovasFormulasFutura.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAux: IDataSet;
begin
  Try
    Try
      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;

        qryAux := TAutcomTintaFactory.Get.fGetDataSet;

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'FUT_CADBAS', 'untDbeCodProKeyPressNovasFormulasFutura',
           'Cadastro de Bases - Futura', '', '') Then //AND BAS_CODUNI = "QT"
        Begin
          cadastro.GetQueryCadastro.FieldByName('NFM_CODPRO').AsString := qryAux.FieldByName('BAS_CODFML').AsString;
          cadastro.GetQueryCadastro.FieldByName('NFM_PRODUT').AsString := qryAux.FieldByName('BAS_PRODUT').AsString;
          cadastro.GetQueryCadastro.FieldByName('NFM_SPRODU').AsString := qryAux.FieldByName('BAS_PRODUT').AsString;
          cadastro.GetQueryCadastro.FieldByName('NFM_BASE__').AsString := qryAux.FieldByName('BAS_CODBAS').AsString;
          cadastro.GetQueryCadastro.FieldByName('NFM_DESBAS').AsString := qryAux.FieldByName('BAS_DESCRI').AsString;
//          cadastro.GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := qryAux.FieldByName('BAS_CODUNI').AsString;

          GetFieldByControle('dbeCodUni').AsString := fRetMenorUnidade(qryAux.FieldByName('BAS_CODFML').AsString,
                                                                       qryAux.FieldByName('BAS_CODBAS').AsString,
                                                                       qryAux.FieldByName('BAS_PRODUT').AsString);

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
