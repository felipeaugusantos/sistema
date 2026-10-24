unit untDbeDesProKeyPressNovasFormulasWeg;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeDesProKeyPressNovasFormulasWeg = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetMenorUnidade(strBase, strProKey, strSubKey:String): String;
    function fRetDescUnidade(strCodUni: String): String;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeDesProKeyPress }

function TDbeDesProKeyPressNovasFormulasWeg.fRetDescUnidade(
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

function TDbeDesProKeyPressNovasFormulasWeg.fRetMenorUnidade(
  strBase, strProKey, strSubKey:String): String;
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
  qryGen.SQL := ' SELECT * FROM WEG_CADBAS        ' +
                '   INNER JOIN CADITE ON          ' +
                ' ITE_CODITE = BAS_CODITE         ' +
                '   WHERE BAS_BASE__ = :BASE AND  ' +
                ' BAS_PROKEY  = :PROKEY AND       ' +
                '   BAS_SUBKEY = :SUBKEY          ' ;

  qryGen.ParamByName('BASE').AsString := strBase;
  qryGen.ParamByName('PROKEY').AsString := strProKey;
  qryGen.ParamByName('SUBKEY').AsString := strSubKey;
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

procedure TDbeDesProKeyPressNovasFormulasWeg.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAux: IDataSet;
  strFiltro: String;
  strUnidade:String;
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

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'WEG_CADBAS', 'untDbeDesProKeyPressNovasFormulasWeg',
           'Cadastro de Base - Weg', 'BAS_CODITE', strFiltro) Then
        Begin

          GetFieldByControle('dbeBase').AsString   := qryAux.FieldByName('BAS_BASE__').AsString;
          GetFieldByControle('dbeProKey').AsString := qryAux.FieldByName('BAS_PROKEY').AsString;
          GetFieldByControle('dbeSubKey').AsString := qryAux.FieldByName('BAS_SUBKEY').AsString;

          strUnidade := fRetMenorUnidade(GetFieldByControle('dbeBase').AsString, GetFieldByControle('dbeProKey').AsString,
            GetFieldByControle('dbeSubKey').AsString);


          GetFieldByControle('dbeCodUni').AsString := strUnidade;



          Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(strUnidade);

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
