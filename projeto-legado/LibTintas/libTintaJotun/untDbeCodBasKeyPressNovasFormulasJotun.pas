unit untDbeCodBasKeyPressNovasFormulasJotun;

interface

uses
  untAbstractLibTintaControleVisualEvento, Classes, SysUtils, untStrUtils;

type
  TDbeCodBasKeyPressNovasFormulasJotun = class(TAbstractLibTintaControleVisualEvento)
  private
    function fRetDescUnidade(strCodUni: String): String;

  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

  procedure pRetMenorUnidade(strCodBas, strTipo: String);
  Var _strCodUni : String;
  Var _strEmbala : String;
  Var _strCodBas : String;
  Var _strDesBas : String;


implementation

uses
  untIDataSet, untAutcomTintaFactory;

{ TDeCodBasKeyPress }

function TDbeCodBasKeyPressNovasFormulasJotun.fRetDescUnidade(
  strCodUni: String): String;
begin
  Result := 'Galão';
  If strCodUni = 'GL' Then
    Result := 'Galão'
  Else If strCodUni = 'LA' Then
    Result := 'Lata';
end;

procedure pRetMenorUnidade(strCodBas, strTipo: String);
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
  qryGen.SQL := ' SELECT BAS_EMBALA                ' +
                '      , BAS_CODUNI                ' +
                '      , BAS_DESCRI                ' +
                '      , BAS_CODBAS                ' +
                '   FROM JOT_CADBAS                ' +
                '  INNER JOIN CADITE               ' +
                '     ON ITE_CODITE = BAS_CODITE   ' +
                '  WHERE BAS_CODBAS = :CODBAS      ' +
                '    AND BAS_TIPO__ = :TIPO__      ' +
                '  ORDER BY BAS_EMBALA             ' ;
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.ParamByName('TIPO__').AsString := strTipo;
  qryGen.Open;

  _strCodUni := qryGen.FieldbyName('BAS_CODUNI').AsString;
  _strEmbala := qryGen.FieldbyName('BAS_EMBALA').AsString;
  _strCodBas := qryGen.FieldbyName('BAS_CODBAS').AsString;
  _strDesBas := qryGen.FieldbyName('BAS_DESCRI').AsString;

end;

procedure TDbeCodBasKeyPressNovasFormulasJotun.OnKeyPress(Sender: TObject; var Key: Char);
var
  qryAux: IDataSet;
  strSQLWhere: String;

begin
  Try
    Try
      If TAutcomTintaFactory.Get.fEntraCons(Key) Then
      Begin
        Key := #0;

        qryAux := TAutcomTintaFactory.Get.fGetDataSet;

        strSQLWhere := '';

        If TAutcomTintaFactory.Get.fPesqGenericaTinta(qryAux, 'JOT_CADBAS',
          'untDbeCodBasKeyPressNovasFormulasJotun', 'Consulta de Bases - Jotun', 'BAS_CODITE', strSQLWhere) Then
        Begin
          pRetMenorUnidade(qryAux.FieldByName('BAS_CODBAS').AsString, qryAux.FieldByName('BAS_TIPO__').AsString);

          GetFieldByControle('dbeBase').AsString   := _strCodBas;
          GetFieldByControle('dbeDescri').AsString := _strDesBas + ' - ' + _strCodBas;
          GetFieldByControle('dbeCodUni').AsString := _strCodUni;
          GetFieldByControle('dbeEmbala').AsString := _strEmbala;
          GetFieldByControle('dbeTipo').AsString   := qryAux.FieldByName('BAS_TIPO__').AsString;

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
