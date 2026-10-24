unit untDbeDesProKeyPressNovasFormulasResicolor2;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeDesProKeyPressNovasFormulasResicolor2 = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetornaUnidade(strLitro, strGalao, strLata, strBalde: String): String;
    function fRetMenorUnidade(strProdut, strCodBas: String): String;
    function fRetDescUnidade(strCodUni: String): String;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeDesProKeyPress }

function TDbeDesProKeyPressNovasFormulasResicolor2.fRetDescUnidade(
  strCodUni: String): String;
begin
  Result := 'Litro';
  If Pos(strCodUni, 'LT_QT_') > 0 Then
    Result := 'Litro'
  Else If strCodUni = 'GL' Then
    Result := 'Galão'
  Else If strCodUni = 'LA' Then
    Result := 'Lata'
  Else If strCodUni = 'BD' Then
    Result := 'Balde';
end;

function TDbeDesProKeyPressNovasFormulasResicolor2.fRetMenorUnidade(
  strProdut, strCodBas: String): String;
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
  qryGen.SQL := ' SELECT BAS_UNIDAD              ' +
                '   FROM RS2_CADBAS           ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  WHERE BAS_PRODUT = :PRODUT    ' +
                '    AND BAS_CODBAS = :CODBAS    ' +
                '  ORDER BY BAS_UNIDAD           ';
  qryGen.ParamByName('PRODUT').AsString := strProdut;
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
      strLata := qryGen.FieldByName('BAS_UNIDAD').AsString
    Else If qryGen.FieldByName('BAS_UNIDAD').AsString = 'BD' Then
      strBalde := qryGen.FieldByName('BAS_UNIDAD').AsString;

    qryGen.Next;
  End;

  Result := fRetornaUnidade(strLitro, strGalao, strLata, strBalde);
end;

function TDbeDesProKeyPressNovasFormulasResicolor2.fRetornaUnidade(strLitro,
  strGalao, strLata, strBalde: String): String;
begin
  Result := '';

  If (Not TStrUtils.fEmptyStr(strLitro)) Then
    Result := strLitro
  Else If (Not TStrUtils.fEmptyStr(strGalao)) Then
    Result := strGalao
  Else If (Not TStrUtils.fEmptyStr(strLata)) Then
    Result := strLata
  Else If (Not TStrUtils.fEmptyStr(strBalde)) Then
    Result := strBalde;
end;

procedure TDbeDesProKeyPressNovasFormulasResicolor2.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAux: IDataSet;
  strFiltro: String;
begin
  Try
    Try
      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;

        qryAux       := TAutcomTintaFactory.Get.fGetDataSet;

        strFiltro := ''; //' AND BAS_UNIDAD = "LT" ';

        If (Not TStrUtils.fEmptyStr(tela['dbeBase']['Text'].Value)) Then
        Begin
          strFiltro := strFiltro + ' AND BAS_CODBAS = ' + QuotedStr(tela['dbeBase']['Text'].Value);
        End;

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'RS2_CADBAS', 'untDbeDesProKeyPressNovasFormulasResicolor2',
           'Cadastro de Base - Resicolor 2', 'BAS_CODITE', strFiltro) Then
        Begin
          GetFieldByControle('dbeBase').AsString   := qryAux.FieldByName('BAS_CODBAS').AsString;
          GetFieldByControle('dbeProdut').AsString := qryAux.FieldByName('BAS_PRODUT').AsString;
          GetFieldByControle('dbeCodUni').AsString := qryAux.FieldByName('BAS_UNIDAD').AsString;

          GetFieldByControle('dbeCodUni').AsString := fRetMenorUnidade(qryAux.FieldByName('BAS_PRODUT').AsString, qryAux.FieldByName('BAS_CODBAS').AsString);

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
