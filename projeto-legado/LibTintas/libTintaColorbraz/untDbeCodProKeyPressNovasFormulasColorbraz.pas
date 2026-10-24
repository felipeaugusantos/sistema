unit untDbeCodProKeyPressNovasFormulasColorbraz;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeCodProKeyPressNovasFormulasColorbraz = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetornaUnidade(strLitro, strGalao, strLata: String): String;
    function fRetMenorUnidade(strCodBas, strProduto: String): String;
    function fRetDescUnidade(strCodUni: String): String;
    function fRetConteudoUnidadeMenor(strCodBas, strProduto, strUnidad: String): Double;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodProKeyPress }

function TDbeCodProKeyPressNovasFormulasColorbraz.fRetConteudoUnidadeMenor(
  strCodBas, strProduto, strUnidad: String): Double;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL + '  SELECT                ';
  qryGen.SQL := qryGen.SQL + '    BAS_CONTEU          ';
  qryGen.SQL := qryGen.SQL + '  FROM                  ';
  qryGen.SQL := qryGen.SQL + '    CLB_CADBAS          ';
  qryGen.SQL := qryGen.SQL + '  WHERE                 ';
  qryGen.SQL := qryGen.SQL + '    BAS_CODBAS = :CODBAS AND        ';
  qryGen.SQL := qryGen.SQL + '    BAS_PRODUT = :PRODUT AND        ';
  qryGen.SQL := qryGen.SQL + '    BAS_UNIDAD = :UNIDAD            ';

  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.ParamByName('PRODUT').AsString := strProduto;
  qryGen.ParamByName('UNIDAD').AsString := strUnidad;
  qryGen.Open;

  Result := qryGen.FieldByName('BAS_CONTEU').AsFloat;
end;

function TDbeCodProKeyPressNovasFormulasColorbraz.fRetDescUnidade(
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

function TDbeCodProKeyPressNovasFormulasColorbraz.fRetMenorUnidade(strCodBas, strProduto: String): String;
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
                '   FROM CLB_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '   WHERE                        ' +
                '     BAS_CODBAS = :CODBAS  AND  ' +
                '     BAS_PRODUT = :PRODUT       ' +
                '  ORDER BY BAS_UNIDAD           ';
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.ParamByName('PRODUT').AsString := strProduto;
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

  Result := fRetornaUnidade(strLitro, strGalao, strLata);
end;

function TDbeCodProKeyPressNovasFormulasColorbraz.fRetornaUnidade(strLitro,
  strGalao, strLata: String): String;
begin
  Result := '';

  If (Not TStrUtils.fEmptyStr(strLitro)) Then
    Result := strLitro
  Else If (Not TStrUtils.fEmptyStr(strGalao)) Then
    Result := strGalao
  Else If (Not TStrUtils.fEmptyStr(strLata)) Then
    Result := strLata;
end;

procedure TDbeCodProKeyPressNovasFormulasColorbraz.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAux: IDataSet;
begin
  Try
    Try
      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;
        qryAux       := TAutcomTintaFactory.Get.fGetDataSet;


        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'CLB_CADBAS', 'untDbeCodProKeyPressNovasFormulasColorbraz',
          'Consulta de Bases - Colorbraz', '', '') Then
        Begin
          GetFieldByControle('dbeBase').AsString    := qryAux.FieldByName('BAS_CODBAS').AsString;
          GetFieldByControle('dbeProduto').AsString := qryAux.FieldByName('BAS_PRODUT').AsString;
          GetFieldByControle('dbeDescri').AsString  := qryAux.FieldByName('BAS_DESCRI').AsString;
          GetFieldByControle('dbeUnidad').AsString  := fRetMenorUnidade(GetFieldByControle('dbeBase').AsString,
            GetFieldByControle('dbeProduto').AsString);
          GetFieldByControle('dbeConteu').AsFloat   := fRetConteudoUnidadeMenor(GetFieldByControle('dbeBase').AsString,
            GetFieldByControle('dbeProduto').AsString, GetFieldByControle('dbeUnidad').AsString);

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
