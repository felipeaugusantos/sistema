unit untDbeDescrProOnKeyPressNovasFormulasBellaCor;

interface

uses

  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeDescrProOnKeyPressNovasFormulasBellaCor = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetMenorUnidade(strDescri, strCodBas: String): String;
    function fRetDescUnidade(strCodUni: String): String;
    function fRetProdutoBellaCor(strProdut: String): String;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodProKeyPress }

function TDbeDescrProOnKeyPressNovasFormulasBellaCor.fRetDescUnidade(
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

function TDbeDescrProOnKeyPressNovasFormulasBellaCor.fRetMenorUnidade(strDescri,
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
  qryGen.SQL := ' SELECT BAS_CODUNI              ' +
                '   FROM BEL_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  WHERE BAS_DESCRI LIKE :DESCRI ' +
                '    AND BAS_CODBAS = :CODBAS    ' +
                '  ORDER BY BAS_CODUNI           ';
  qryGen.ParamByName('DESCRI').AsString := '%' + fRetProdutoBellaCor(strDescri) + '%';
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

function TDbeDescrProOnKeyPressNovasFormulasBellaCor.fRetProdutoBellaCor(
  strProdut: String): String;
begin
  Result := strProdut;

  If Pos('3,2', strProdut) > 0 Then
    Result := Copy(strProdut,1,Pos('3,2', strProdut) - 1)
  Else If Pos('16,2', strProdut) > 0 Then
    Result := Copy(strProdut,1,Pos('16,2', strProdut) - 1)
  Else If Pos('810', strProdut) > 0 Then
    Result := Copy(strProdut,1,Pos('810', strProdut) - 1);
end;

procedure TDbeDescrProOnKeyPressNovasFormulasBellaCor.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAux      : IDataSet;
  strSQLWhere : String;
begin
  Try
    Try
      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;

        qryAux := TAutcomTintaFactory.Get.fGetDataSet;
{
        If (Not TStrUtils.fEmptyStr(tela['dbeBase']['Text'].Value)) Then
        Begin
          strSQLWhere := strSQLWhere + ' AND BAS_CODUNI = "'+tela['dbeCodUni']['Text'].Value+'" '+
                                        ' AND BAS_CODBAS = "'+tela['dbeBase']['Text'].Value+'" ';

          If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'BEL_CADBAS', 'untDbeDescrProOnKeyPressNovasFormulasBellaCor', 'Consulta de Bases - BellaCor','BAS_CODITE', strSQLWhere) Then
          Begin
            GetFieldByControle('dbeProdut').AsString := qryAux.FieldByName('BAS_DESCRI').AsString;
            tela.SelectNext;
          End;

        End;
}
        If (Not TStrUtils.fEmptyStr(tela['dbeBase']['Text'].Value)) Then
        Begin
          strSQLWhere := strSQLWhere + ' AND BAS_CODBAS = "' + tela['dbeBase']['Text'].Value + '"';
        End;

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'BEL_CADBAS', 'untDbeDescrProOnKeyPressNovasFormulasBellaCor',
          'Consulta de Bases - Bellacor','BAS_CODITE', strSQLWhere) Then
        Begin
          GetFieldByControle('dbeBase').AsString   := qryAux.FieldByName('BAS_CODBAS').AsString;
          GetFieldByControle('dbeProdut').AsString := qryAux.FieldByName('BAS_DESCRI').AsString;

          GetFieldByControle('dbeCodUni').AsString := fRetMenorUnidade(qryAux.FieldByName('BAS_DESCRI').AsString, qryAux.FieldByName('BAS_CODBAS').AsString);

          Tela['Label5']['Caption'].Value := 'Informar a Quantidade sempre em ' + fRetDescUnidade(GetFieldByControle('dbeCodUni').AsString);

          tela.SelectNext;
        End;
      end;

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
