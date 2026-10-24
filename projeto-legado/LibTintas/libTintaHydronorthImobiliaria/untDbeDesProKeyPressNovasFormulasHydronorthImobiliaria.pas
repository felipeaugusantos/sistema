unit untDbeDesProKeyPressNovasFormulasHydronorthImobiliaria;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeDesProKeyPressNovasFormulasHydronorthImobiliaria = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetMenorUnidade(strProdut, strCodBas: String): String;
    function fRetDescUnidade(strCodUni: String): String;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeDesProKeyPress }


function TDbeDesProKeyPressNovasFormulasHydronorthImobiliaria.fRetDescUnidade(
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

function TDbeDesProKeyPressNovasFormulasHydronorthImobiliaria.fRetMenorUnidade(
  strProdut, strCodBas: String): String;
var
  qryGen: IDataSet;
  strLitro,
  strGalao,
  strLata: String;

begin
  strLitro := '';
  strGalao := '';
  strLata  := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT BAS_CODEMB              ' +
                '      , EMB_CODUNI              ' +
                '   FROM HYD_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  INNER JOIN HYD_CADEMB         ' +
                '     ON EMB_CODEMB = BAS_CODEMB ' +
                '  WHERE BAS_BASE__ = :DESBAS    ' +
                '    AND BAS_PRODUT = :PRODUT    ' +
                '  ORDER BY EMB_TAMEMB           ' ;
  qryGen.ParamByName('DESBAS').AsString := strCodBas;
  qryGen.ParamByName('PRODUT').AsString := strProdut;
  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If Pos(qryGen.FieldByName('EMB_CODUNI').AsString, 'LT_QT_') > 0 Then
      strLitro := qryGen.FieldByName('BAS_CODEMB').AsString
    Else If qryGen.FieldByName('EMB_CODUNI').AsString = 'GL' Then
      strGalao := qryGen.FieldByName('BAS_CODEMB').AsString
    Else If qryGen.FieldByName('EMB_CODUNI').AsString = 'LA' Then
      strLata := qryGen.FieldByName('BAS_CODEMB').AsString;

    qryGen.Next;
  End;

  If (Not TStrUtils.fEmptyStr(strLitro)) Then
    Result := strLitro
  Else If (Not TStrUtils.fEmptyStr(strGalao)) Then
    Result := strGalao
  Else If (Not TStrUtils.fEmptyStr(strLata)) Then
    Result := strLata;

end;

procedure TDbeDesProKeyPressNovasFormulasHydronorthImobiliaria.OnKeyPress(Sender: TObject; var Key: Char);
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

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'HYD_CADBAS', 'untDbeDesProKeyPressNovasFormulasHydronorthImobiliaria',
           'Cadastro de Base - Hydronorth Imobiliária', 'BAS_CODITE', strFiltro) Then
        Begin
          GetFieldByControle('dbeBase').AsString   := qryAux.FieldByName('BAS_BASE__').AsString;
          GetFieldByControle('dbeProdut').AsString := qryAux.FieldByName('BAS_PRODUT').AsString;

          strUnidade := fRetMenorUnidade(qryAux.FieldByName('BAS_PRODUT').AsString, qryAux.FieldByName('BAS_BASE__').AsString);

          GetFieldByControle('dbeEmbala').AsString := strUnidade;

          Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(strUnidade);
//          Tela['edtSigUni']['Text'].Value := strUnidade;
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
