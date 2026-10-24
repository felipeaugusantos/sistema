unit Shared.Functions.Utils;

interface

uses System.Classes, System.SysUtils, System.StrUtils, Shared.Functions.Interfaces,
  Shared.Functions.Tipos, Shared.Functions.Types, System.Rtti;

type
  TBoolean = record
    Value: Variant;
    function AsString: String;
    class operator Implicit(Value: Variant): TBoolean;
  end;

type
  TFunctionsUtils = class
  private
    class function RetornarCamposSelect(const ASQL: String): ArrOfString;
    class function RetornarNomeTabela(const ASQL: String): String;
    class function RetornarCampoChave(const ASQL: String): ArrOfString;
    class function RetornarCampoChaveSemApelido(const AValue: String): String;
    class function RetornarPosicaoWhere(const ASQL: string): Integer;
  public
    class function DesmembrarSelectParaCampoTabela(const ASQL: string): IResultadoDesmembrarSelectParaCampoTabela;
    class function Boolean(const AValue : Boolean): TBoolean;
  end;

implementation

{ TFunctionsUtils }

function TBoolean.AsString: String;
begin
  result := 'N';

  if (not Self.Value) then
    Exit;

  result := 'S';
end;

class function TFunctionsUtils.Boolean(const AValue: Boolean): TBoolean;
begin
  Result := AValue;
end;

class function TFunctionsUtils.DesmembrarSelectParaCampoTabela(const ASQL: string): IResultadoDesmembrarSelectParaCampoTabela;
var
  LCamposSelect: ArrOfString;
  LNomeTabela  : String;
  LCampoChave  : ArrOfString;
begin
  LCamposSelect := Self.RetornarCamposSelect(ASQL);// Array Of String;
  LNomeTabela   := Self.RetornarNomeTabela(ASQL);
  LCampoChave   := Self.RetornarCampoChave(ASQL); //Array Of String;

  Result :=
    TResultadoDesmembrarSelectParaCampoTabela.New
      .CamposSelect(LCamposSelect)
      .NomeTabela(LNomeTabela)
      .CampoChave(LCampoChave);
end;

class function TFunctionsUtils.RetornarCampoChave(
  const ASQL: String): ArrOfString;
var
  stlCampos: TStringList;
  LSQL: String;
  LPosicaoWhere: Integer;
  LCont: Integer;
begin
  SetLength(Result, 0);

  LPosicaoWhere := Pos('WHERE', ASQL);

  If LPosicaoWhere = 0 Then
  Begin
    Result := [];
    Exit;
  End;

  LSQL := Trim(Copy(ASQL, LPosicaoWhere, Length(ASQL)));
  LSQL := Trim(AnsiReplaceStr(LSQL, ' AND', '^'));
  LSQL := Trim(AnsiReplaceStr(LSQL, 'WHERE', ''));

  try
    stlCampos := TStringList.Create;
    stlCampos.StrictDelimiter := True;
    stlCampos.Delimiter := '^';
    stlCampos.DelimitedText := LSQL;

    for LCont := 0 to stlCampos.Count - 1 do
    begin
      SetLength(Result, Length(Result) + 1);
      Result[LCont] := RetornarCampoChaveSemApelido(stlCampos[LCont]);
    end;
  finally
    FreeAndNil(stlCampos)
  end;
end;

class function TFunctionsUtils.RetornarCampoChaveSemApelido(
  const AValue: String): String;
var
  strPosParam: String;
  strParamNome: String;

  intTamanho: Integer;
begin
  strParamNome := '';
  strPosParam  := Trim(AValue);

  If Pos('LOCATE(', strPosParam) > 0 Then
  Begin
    Result := strPosParam;
    Exit;
  End;

  For intTamanho := 0 To strPosParam.Length - 1 Do
  Begin
    If (strPosParam[intTamanho] = '=') Then
      Break;

    strParamNome := strParamNome + strPosParam[intTamanho];
  End;

  Result := Trim(strParamNome);
end;

class function TFunctionsUtils.RetornarCamposSelect(
  const ASQL: String): ArrOfString;
var
  stlCampos: TStringList;
  LSQL: String;
  LPosicaoFrom: Integer;
  LCont: Integer;
begin
  SetLength(Result, 0);

  LPosicaoFrom := Pos('FROM', ASQL);

  LSQL := Copy(ASQL, 0, LPosicaoFrom - 1);
  LSQL := Trim(AnsiReplaceStr(LSQL, 'SELECT', ''));

  Try
    stlCampos := TStringList.Create;
    stlCampos.StrictDelimiter := True;
    stlCampos.Delimiter := ',';
    stlCampos.DelimitedText := LSQL;

    For LCont := 0 To stlCampos.Count - 1 Do
    Begin
      SetLength(Result, Length(Result) + 1);
      Result[LCont] := stlCampos[LCont];
    End;
  Finally
    FreeAndNil(stlCampos)
  End;
end;

class function TFunctionsUtils.RetornarNomeTabela(const ASQL: String): String;
var
  LPosicaoFrom: Integer;
  LPosicaoWhere: Integer;
  LFrom: String;
begin
  Result := '';

  LPosicaoFrom := Pos('FROM', ASQL);
  LPosicaoWhere := RetornarPosicaoWhere(ASQL);

  LFrom := Trim(Copy(ASQL, LPosicaoFrom, LPosicaoWhere - LPosicaoFrom));
  LFrom := Trim(AnsiReplaceStr(LFrom, 'FROM', ''));

  Result := LFrom;
end;

class function TFunctionsUtils.RetornarPosicaoWhere(
  const ASQL: string): Integer;
begin
  Result := Pos('WHERE', ASQL);

  If (Result > 0) Then
    Exit;

  Result := Length(ASQL) + 1;
end;

class operator TBoolean.Implicit(Value: Variant): TBoolean;
begin
  result.Value := Value;
end;

end.
