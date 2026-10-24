unit untDbeDesProKeyPressNovasFormulasLukscolor;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeDesProKeyPressNovasFormulasLukscolor = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetMenorUnidade(strProdKey, strCodBas, strSubKey: String): String;
    function fRetSubKeyUnidade(strBase, strProKey, strUnidade:String): String;
    function fRetQtdUnidade(strBase, strProKey, strSubKey, strUnidade:String):Double;
    function fRetDescricaoBase(strCodBas, strProdKey, strSubKey, strUnidad:String):String;
    function fRetDescUnidade(strCodUni: String): String;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeDesProKeyPress }

function TDbeDesProKeyPressNovasFormulasLukscolor.fRetDescricaoBase(strCodBas,
  strProdKey, strSubKey, strUnidad: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '  SELECT                         ' +
                '    BAS_DESCRI                   ' +
                '  FROM                           ' +
                '    LKD_CADBAS                   ' +
                '  WHERE                          ' +
                '    BAS_BASE__ = :BASE           ' ;

  If Not TStrUtils.fEmptyStr(strProdKey) Then
    qryGen.SQL := qryGen.SQL + '  AND BAS_PROKEY = :PROKEY  ';

  If Not TStrUtils.fEmptyStr(strSubKey) Then
    qryGen.SQL := qryGen.SQL + '  AND BAS_SUBKEY = :SUBKEY  ';

  If Not TStrUtils.fEmptyStr(strUnidad) Then
    qryGen.SQL := qryGen.SQL + '  AND BAS_UNIDAD = :UNIDAD  ';

  qryGen.ParamByName('BASE').AsString := strCodBas;

  If Not TStrUtils.fEmptyStr(strProdKey) Then
    qryGen.ParamByName('PROKEY').AsString := strProdKey;

  If Not TStrUtils.fEmptyStr(strSubKey) Then
    qryGen.ParamByName('SUBKEY').AsString := strSubKey;

  If Not TStrUtils.fEmptyStr(strUnidad) Then
    qryGen.ParamByName('UNIDAD').AsString := strUnidad;

  qryGen.Open;

  If TStrUtils.fEmptyStr(GetFieldByControle('dbeDescri').AsString) Then
    Result := qryGen.FieldByName('BAS_DESCRI').AsString
  Else
    Result := GetFieldByControle('dbeDescri').AsString;
end;

function TDbeDesProKeyPressNovasFormulasLukscolor.fRetDescUnidade(
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

function TDbeDesProKeyPressNovasFormulasLukscolor.fRetMenorUnidade(
  strProdKey, strCodBas, strSubKey: String): String;
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
                '   FROM LKD_CADBAS           ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  WHERE BAS_PROKEY = :PROKEY    ' +
                '    AND BAS_BASE__ = :CODBAS    ' +
                '  ORDER BY BAS_UNIDAD           ';

  qryGen.ParamByName('PROKEY').AsString := strProdKey;
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


function TDbeDesProKeyPressNovasFormulasLukscolor.fRetQtdUnidade(strBase,
  strProKey, strSubKey, strUnidade: String): Double;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   SELECT BAS_QTDEMB   FROM LKD_CADBAS             ' +
                '     WHERE BAS_BASE__ = :BASE AND                  ' +
                '   BAS_PROKEY = :PROKEY AND                        ' +
                '     BAS_SUBKEY = :SUBKEY AND                      ' +
                '   BAS_UNIDAD  = :UNIDAD                           ' ;
  qryGen.ParamByName('BASE').AsString := strBase;
  qryGen.ParamByName('PROKEY').AsString := strProKey;
  qryGen.ParamByName('SUBKEY').AsString := strSubKey;
  qryGen.ParamByName('UNIDAD').AsString := strUnidade;
  qryGen.Open;

  Result := qryGen.FieldByName('BAS_QTDEMB').AsFloat;
end;

function TDbeDesProKeyPressNovasFormulasLukscolor.fRetSubKeyUnidade(strBase,
  strProKey, strUnidade: String): String;
var
  qryGen: IDataSet;
  strSub, strSub1, strSub2: String;
begin
  Result := '';
  strSub := '';
  strSub1 := '';
  strSub2 := '';


  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   SELECT BAS_SUBKEY FROM LKD_CADBAS       ' +
                '     WHERE BAS_BASE__ = :BASE              ' +
                '   AND BAS_PROKEY = :PKEY                  ' +
                '   AND BAS_UNIDAD = :UNDE                  ';

  qryGen.ParamByName('BASE').AsString := strBase;
  qryGen.ParamByName('PKEY').AsString := strProKey;
  qryGen.ParamByName('UNDE').AsString := strUnidade;
  qryGen.Open;

  While Not qryGen.Eof Do
  Begin
    If qryGen.ParamByName('UNDE').AsString = 'LT' Then
      strSub := qryGen.FieldByName('BAS_SUBKEY').AsString
    Else If qryGen.ParamByName('UNDE').AsString = 'GL' Then
      strSub1 := qryGen.FieldByName('BAS_SUBKEY').AsString
    Else If qryGen.ParamByName('UNDE').AsString = 'LA' Then
      strSub2 := qryGen.FieldByName('BAS_SUBKEY').AsString;

    qryGen.Next;
  End;

  If Not TStrUtils.fEmptyStr(strSub) Then
    Result := strSub
  Else If Not TStrUtils.fEmptyStr(strSub1) Then
    Result := strSub1
  Else If Not TStrUtils.fEmptyStr(strSub2) Then
    Result := strSub2;

end;

procedure TDbeDesProKeyPressNovasFormulasLukscolor.OnKeyPress(Sender: TObject; var Key: Char);
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
          strFiltro := strFiltro + ' AND BAS_BASE__ = ' + QuotedStr(tela['dbeBase']['Text'].Value);
        End;

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'LKD_CADBAS', 'untDbeDesProKeyPressNovasFormulasLukscolor',
           'Cadastro de Base - Lukscolor Imobiliária', 'BAS_CODITE', strFiltro) Then
        Begin
          GetFieldByControle('dbeBase').AsString   := qryAux.FieldByName('BAS_BASE__').AsString;
          GetFieldByControle('dbeProdKey').AsString := qryAux.FieldByName('BAS_PROKEY').AsString;

          GetFieldByControle('dbeCodUni').AsString := fRetMenorUnidade(GetFieldByControle('dbeProdKey').AsString,
                                                                       GetFieldByControle('dbeBase').AsString,
                                                                       GetFieldByControle('dbeSubKey').AsString);

          GetFieldByControle('dbeSubKey').AsString := fRetSubKeyUnidade(GetFieldByControle('dbeBase').AsString,
                                                                        GetFieldByControle('dbeProdKey').AsString,
                                                                        GetFieldByControle('dbeCodUni').AsString);

          Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetFieldByControle('dbeCodUni').AsString);



          GetFieldByControle('dbeDescri').AsString := fRetDescricaoBase(GetFieldByControle('dbeBase').AsString,
                                                                        GetFieldByControle('dbeProdKey').AsString,
                                                                        GetFieldByControle('dbeSubKey').AsString,
                                                                        GetFieldByControle('dbeCodUni').AsString);

          GetFieldByControle('dbeQtdEmb').AsFloat := fRetQtdUnidade(GetFieldByControle('dbeBase').AsString,
                                                                    GetFieldByControle('dbeProdKey').AsString,
                                                                    GetFieldByControle('dbeSubKey').AsString,
                                                                    GetFieldByControle('dbeCodUni').AsString);

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
