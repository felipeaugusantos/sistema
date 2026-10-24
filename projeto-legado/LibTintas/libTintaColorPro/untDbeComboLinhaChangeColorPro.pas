unit untDbeComboLinhaChangeColorPro;

interface

uses untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untIDataSet, untAbstractLibTintaControleVisualEvento,
  untILibTintaControleVisual, untAbstractCadastro, StrUtils;

type
  TDbeComboLinhaChangeColorPro = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  private
    dbeCombo: string;
    dbeLinha: string;
    function fRetCodLinha(strNomLin: String): String;
  published
    constructor Create(const cadastro: TAbstractCadastro; const dbeCombo: string; const dbeLinha: string); reintroduce;
  published
    procedure OnChange(Sender: TObject);
  end;

implementation

{ TDbeCodColKeyPress }

constructor TDbeComboLinhaChangeColorPro.Create(const cadastro: TAbstractCadastro; const dbeCombo: string; const dbeLinha: string);
begin
  inherited Create('OnChange', cadastro);
  Self.dbeCombo := dbeCombo;
  Self.dbeLinha := dbeLinha;
end;

function TDbeComboLinhaChangeColorPro.fRetCodLinha(strNomLin: String): String;
begin
  strNomLin := Trim(AnsiLowerCase(strNomLin));

  Result := '';
  If strNomLin = AnsiLowerCase('Autobase Plus 100:50') Then
    Result := '1'

  Else If strNomLin = AnsiLowerCase('Wandabase HS') Then
    Result := '4'

  Else If strNomLin = AnsiLowerCase('Wandalac') Then
    Result := '6'

  Else If strNomLin = AnsiLowerCase('Wanda PU HS') Then
    Result := '8'

  Else If strNomLin = AnsiLowerCase('Wandacar') Then
    Result := '9'

  Else If strNomLin = AnsiLowerCase('Single Stage Converter') Then
    Result := '11'

  Else If strNomLin = AnsiLowerCase('Autocoat BT100') Then
    Result := '13'

  Else If strNomLin = AnsiLowerCase('Autobase Plus 100:80') Then
    Result := '14'

  Else If strNomLin = AnsiLowerCase('Wanda PU MS') Then
    Result := '58'

  Else If strNomLin = AnsiLowerCase('Autocoat BT120') Then
    Result := '16'

  Else If strNomLin = AnsiLowerCase('Autocoat BT90') Then
    Result := '59'

  Else If strNomLin = AnsiLowerCase('Autocoat BT110') Then
    Result := '15'

  Else If strNomLin = AnsiLowerCase('Autocoat BT130') Then
    Result := '17'

  Else If strNomLin = AnsiLowerCase('Autowave MM') Then
    Result := '27'

  Else If strNomLin = AnsiLowerCase('Autowave MM 2.0') Then
    Result := '67'

  Else If strNomLin = AnsiLowerCase('Tech Fleet PU') Then
    Result := '72'

  Else If strNomLin = AnsiLowerCase('Tech Fleet Epoxy') Then
    Result := '74'

  Else If strNomLin = AnsiLowerCase('Tech Fleet Sintetico') Then
    Result := '75'

  Else If strNomLin = AnsiLowerCase('Tech Fleet Laca') Then
    Result := '76'

  Else If strNomLin = AnsiLowerCase('Autobase Plus Baseline 100:50') Then
    Result := '19'

  Else If strNomLin = AnsiLowerCase('Autobase Plus Baseline 100:80') Then
    Result := '12'
end;

procedure TDbeComboLinhaChangeColorPro.OnChange(Sender: TObject);
var
  strRetorno: String;
begin
  strRetorno:= '';
  Try
    Try
      GetFieldByControle(dbeLinha).AsString := fRetCodLinha(tela[dbeCombo]['Text'].Value);
//      If cadastro.fValidaCampos(tela, cadastro.GetNomeCampoItem + RightStr(strNomeCampo, 2), qryConsulta.FieldByName('BAS_CODBAS').AsString, strRetorno) Then
//        tela.SelectNext;
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
