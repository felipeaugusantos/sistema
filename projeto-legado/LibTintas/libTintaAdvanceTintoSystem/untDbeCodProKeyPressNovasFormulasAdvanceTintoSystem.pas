unit untDbeCodProKeyPressNovasFormulasAdvanceTintoSystem;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeCodProKeyPressNovasFormulasAdvanceTintoSystem = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetMenorUnidade(strProdut, strCodBas: String): String;
    function fRetDescUnidade(strCodUni: String): String;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodProKeyPress }



function TDbeCodProKeyPressNovasFormulasAdvanceTintoSystem.fRetDescUnidade(
  strCodUni: String): String;
begin
  Result := 'Quarto';
  If Pos(strCodUni, '102_002_') > 0 Then
    Result := 'Quarto'
  Else If Pos(strCodUni, '101_003_') > 0 Then
    Result := 'Galão'
  Else If Pos(strCodUni, '103_104_') > 0 Then
    Result := 'Lata';
end;

function TDbeCodProKeyPressNovasFormulasAdvanceTintoSystem.fRetMenorUnidade(
  strProdut, strCodBas: String): String;
var
  qryGen: IDataSet;
  strLitro,
  strGalao,
  strLata,
  strDesLt,
  strDesGl,
  strDesLa: String;
begin
  strLitro := '';
  strGalao := '';
  strLata  := '';
  strDesLt := '';
  strDesGl := '';
  strDesLa := '';


  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT *                       ' +
                '   FROM ADT_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  INNER JOIN ADT_CADEMB         ' +
                '     ON EMB_CODEMB = BAS_CODEMB ' +
                '  WHERE BAS_CODBAS = :BASE__    ' +
                '    AND BAS_PRODUT = :PRODUT    ' ;
  qryGen.ParamByName('BASE__').AsString := strCodBas;
  qryGen.ParamByName('PRODUT').AsString := strProdut;
  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If Pos(qryGen.FieldByName('EMB_CODUNI').AsString, 'LT_QT_') > 0 Then
    Begin
      strLitro := qryGen.FieldByName('BAS_CODEMB').AsString;
      strDesLt := qryGen.FieldByName('EMB_DESCRI').AsString;
    End
    Else If qryGen.FieldByName('EMB_CODUNI').AsString = 'GL' Then
    Begin
      strGalao := qryGen.FieldByName('BAS_CODEMB').AsString;
      strDesGl := qryGen.FieldByName('EMB_DESCRI').AsString;
    End
    Else If qryGen.FieldByName('EMB_CODUNI').AsString = 'LA' Then
    Begin
      strLata  := qryGen.FieldByName('BAS_CODEMB').AsString;
      strDesLa := qryGen.FieldByName('EMB_DESCRI').AsString;
    End;

    qryGen.Next;
  End;

  If (Not TStrUtils.fEmptyStr(strLitro)) Then
  Begin
    Result := strLitro;
    Tela['edtDesEmb']['Text'].Value := strDesLt;
  End
  Else If (Not TStrUtils.fEmptyStr(strGalao)) Then
  Begin
    Result := strGalao;
    Tela['edtDesEmb']['Text'].Value := strDesGl;
  End
  Else If (Not TStrUtils.fEmptyStr(strLata)) Then
  Begin
    Result := strLata;
    Tela['edtDesEmb']['Text'].Value := strDesLa;
  End;

end;

procedure TDbeCodProKeyPressNovasFormulasAdvanceTintoSystem.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAux: IDataSet;
  strUnidade: String;
begin
  Try
    Try
      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;

        qryAux       := TAutcomTintaFactory.Get.fGetDataSet;

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'ADT_CADBAS', 'untDbeCodProKeyPressNovasFormulasAdvanceTintoSystem',
           'Cadastro de Base - Advance TintoSystem', 'BAS_CODITE', '') Then //AND BAS_UNIDAD = "LT"
        Begin
          GetFieldByControle('dbeBase').AsString   := qryAux.FieldByName('BAS_CODBAS').AsString;
          Tela['edtDesBas']['Text'].Value := qryAux.FieldByName('BAS_DESCRI').AsString;
          GetFieldByControle('dbeProduto').AsString := qryAux.FieldByName('BAS_PRODUT').AsString;

          strUnidade := fRetMenorUnidade(qryAux.FieldByName('BAS_PRODUT').AsString, qryAux.FieldByName('BAS_CODBAS').AsString);

          GetFieldByControle('dbeEmbala').AsString := strUnidade;

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
