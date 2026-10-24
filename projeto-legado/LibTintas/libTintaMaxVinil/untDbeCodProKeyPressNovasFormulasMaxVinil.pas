unit untDbeCodProKeyPressNovasFormulasMaxVinil;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeCodProKeyPressNovasFormulasMaxVinil = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetMenorUnidade(strProdut, strCodBas, strColeca: String): String;
    function fRetMenorConteudo(strBase, strProduto, strColecao, strUnidade: String): Double;
    function fRetDescUnidade(strCodUni: String): String;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodProKeyPress }

function TDbeCodProKeyPressNovasFormulasMaxVinil.fRetDescUnidade(
  strCodUni: String): String;
begin
  Result := 'Litros';
  If Pos(strCodUni, 'LT_QT_') > 0 Then
    Result := 'Litros'
  Else If strCodUni = 'GL' Then
    Result := 'Galão'
  Else If strCodUni = 'LA' Then
    Result := 'Lata'
  Else If strCodUni = 'BD' Then
    Result := 'Balde';
end;

function TDbeCodProKeyPressNovasFormulasMaxVinil.fRetMenorConteudo(strBase,
  strProduto, strColecao, strUnidade: String): Double;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL + '  SELECT          ';
  qryGen.SQL := qryGen.SQL + '    *             ';
  qryGen.SQL := qryGen.SQL + '  FROM            ';
  qryGen.SQL := qryGen.SQL + '    MAX_CADBAS    ';
  qryGen.SQL := qryGen.SQL + '  INNER JOIN CADITE ON      ';
  qryGen.SQL := qryGen.SQL + '    BAS_CODITE = ITE_CODITE       ';
  qryGen.SQL := qryGen.SQL + '  WHERE           ';
  qryGen.SQL := qryGen.SQL + '    BAS_CODBAS = :CODBAS AND      ';
  qryGen.SQL := qryGen.SQL + '    BAS_PRODUT = :PRODUT AND      ';
  qryGen.SQL := qryGen.SQL + '    BAS_UNIDAD = :UNIDAD          ';
  qryGen.SQL := qryGen.SQL + '  ORDER BY BAS_CONTEU ASC         ';

  qryGen.ParamByName('CODBAS').AsString := strBase;
  qryGen.ParamByName('PRODUT').AsString := strProduto;
  qryGen.ParamByName('UNIDAD').AsString := strUnidade;
  qryGen.Open;

  Result := qryGen.FieldByName('BAS_CONTEU').AsFloat;
end;

function TDbeCodProKeyPressNovasFormulasMaxVinil.fRetMenorUnidade(
  strProdut, strCodBas, strColeca: String): String;
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
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL + '  SELECT              ';
  qryGen.SQL := qryGen.SQL + '    *                 ';
  qryGen.SQL := qryGen.SQL + '  FROM                ';
  qryGen.SQL := qryGen.SQL + '    MAX_CADBAS        ';
  qryGen.SQL := qryGen.SQL + '  INNER JOIN CADITE ON          ';
  qryGen.SQL := qryGen.SQL + '    BAS_CODITE = ITE_CODITE           ';
  qryGen.SQL := qryGen.SQL + '  WHERE               ';
  qryGen.SQL := qryGen.SQL + '    BAS_CODBAS = :CODBAS AND    ';
  qryGen.SQL := qryGen.SQL + '    BAS_PRODUT = :PRODUT        ';


  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.ParamByName('PRODUT').AsString := strProdut;
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

  If (Not TStrUtils.fEmptyStr(strLitro)) Then
    Result := strLitro
  Else If (Not TStrUtils.fEmptyStr(strGalao)) Then
    Result := strGalao
  Else If (Not TStrUtils.fEmptyStr(strBalde)) Then
    Result := strBalde
  Else If (Not TStrUtils.fEmptyStr(strLata)) Then
    Result := strLata;
end;

procedure TDbeCodProKeyPressNovasFormulasMaxVinil.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAux: IDataSet;
begin
  Try
    Try
      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;

        qryAux       := TAutcomTintaFactory.Get.fGetDataSet;

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'MAX_CADBAS', 'untDbeCodProKeyPressNovasFormulasMaxVinil',
           'Cadastro de Base - MaxVinil', 'BAS_CODITE', '') Then
        Begin
          GetFieldByControle('dbeBase').AsString   := qryAux.FieldByName('BAS_CODBAS').AsString;
          GetFieldByControle('dbeProdut').AsString := qryAux.FieldByName('BAS_PRODUT').AsString;

          GetFieldByControle('dbeCodUni').AsString := fRetMenorUnidade(GetFieldByControle('dbeProdut').AsString,
                                                                       GetFieldByControle('dbeBase').AsString,
                                                                       '');

          GetFieldByControle('dbeConteudo').AsFloat := fRetMenorConteudo(GetFieldByControle('dbeBase').AsString,
                                                                         GetFieldByControle('dbeProdut').AsString,
                                                                         '',
                                                                         GetFieldByControle('dbeCodUni').AsString);


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
