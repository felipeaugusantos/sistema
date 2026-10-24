unit untDbeDesProKeyPressNovasFormulasInternational;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeDesProKeyPressNovasFormulasInternational = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetMenorUnidade(strCodBas: String): String;
    function fRetDescUnidade(strCodUni: String): String;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeDesProKeyPress }


function TDbeDesProKeyPressNovasFormulasInternational.fRetDescUnidade(
  strCodUni: String): String;
var
  qryGen: IDataSet;
  strLitro,
  strGalao,
  strLata : String;
begin

  Result := '';
  strLitro := '';
  strGalao := '';
  strLata  := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT BAS_CODEMB              ' +
                '      , EMB_CODUNI              ' +
                '   FROM INT_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  INNER JOIN INT_CADEMB         ' +
                '     ON EMB_CODEMB = BAS_CODEMB ' +
                '  WHERE BAS_CODBAS = :DESBAS    ' +
                '  ORDER BY EMB_TAMEMB         ';
  qryGen.ParamByName('DESBAS').AsString := strCodUni;
  qryGen.Open;

  While Not qryGen.Eof Do
  Begin
    If Pos(qryGen.FieldByName('EMB_CODUNI').AsString, 'LT_QT_') > 0 Then
      strLitro := 'Litro'
    Else If qryGen.FieldByName('EMB_CODUNI').AsString = 'GL' Then
      strGalao := 'Galao'
    Else If qryGen.FieldByName('EMB_CODUNI').AsString = 'LA' Then
      strLata  := 'Lata';

    qryGen.Next;
  End;

  If Not TStrUtils.fEmptyStr(strLitro) Then
    Result := strLitro
  Else If Not TStrUtils.fEmptyStr(strGalao) Then
    Result := strGalao
  Else If Not TStrUtils.fEmptyStr(strLata) Then
    Result := strLata
  Else
    Result := 'Balde';



end;

function TDbeDesProKeyPressNovasFormulasInternational.fRetMenorUnidade(strCodBas: String): String;
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
                '   FROM INT_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  INNER JOIN INT_CADEMB         ' +
                '     ON EMB_CODEMB = BAS_CODEMB ' +
                '  WHERE BAS_CODBAS = :DESBAS    ' +
                '  ORDER BY EMB_TAMEMB         ';
  qryGen.ParamByName('DESBAS').AsString := strCodBas;
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

procedure TDbeDesProKeyPressNovasFormulasInternational.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAux: IDataSet;
  strFiltro: String;
  strUnidade:String;
  strDesUni:String;
begin
  Try
    Try
      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;

        qryAux       := TAutcomTintaFactory.Get.fGetDataSet;

        strFiltro := '';

        If (Not TStrUtils.fEmptyStr(tela['dbeBase']['Text'].Value)) Then
        Begin
          strFiltro := strFiltro + ' AND BAS_CODBAS = ' + QuotedStr(tela['dbeBase']['Text'].Value);
        End;

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'INT_CADBAS', 'untDbeDesProKeyPressNovasFormulasInternational',
           'Cadastro de Base - International', 'BAS_CODITE', strFiltro) Then
        Begin
          GetFieldByControle('dbeBase').AsString   := qryAux.FieldByName('BAS_CODBAS').AsString;

          strUnidade := fRetMenorUnidade(qryAux.FieldByName('BAS_CODBAS').AsString);

          GetFieldByControle('dbeEmbala').AsString := strUnidade;

          strDesUni := fRetDescUnidade(qryAux.FieldByName('BAS_CODBAS').AsString);

          Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + strDesUni;
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
