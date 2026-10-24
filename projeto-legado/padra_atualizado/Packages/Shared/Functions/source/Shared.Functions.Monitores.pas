unit Shared.Functions.Monitores;

interface

uses
  System.SysUtils, System.StrUtils, System.Variants, System.Classes,
  Generics.Collections;

function fNormalizeSQL(const ASQL: string): string;
function fOtimizaInsertReplaceMultiValue(const ASQL: string;
                                         const AIgnoreTable: array of string): string;

implementation

function fParentesesBalanceados(const ASQL: string): Boolean;
var
  intIdx, C: Integer;
  InString: Boolean;
begin
  C := 0;
  InString := False;

  for intIdx := 1 to Length(ASQL) do
  begin
    if ASQL[intIdx] = '"' then
      InString := not InString;

    if not InString then
    begin
      if ASQL[intIdx] = '(' then Inc(C);
      if ASQL[intIdx] = ')' then Dec(C);
      if C < 0 then
        Exit(False);
    end;
  end;

  Result := (C = 0);
end;

function fExtractTableName(const ALinhaNormalizada: string): string;
const
  OFFSET_INTO = 6; // Length(' INTO ')
var
  S: string;
  PosInto, PosPare: Integer;
begin
  Result := '';
  S := UpperCase(ALinhaNormalizada);

  PosInto := Pos(' INTO ', S);
  if PosInto = 0
    then Exit;

  PosInto := PosInto + OFFSET_INTO;

  PosPare := Pos('(', S);
  if PosPare = 0 then
    Exit;

  Result := Trim(Copy(ALinhaNormalizada, PosInto, PosPare - PosInto));
end;

function fLinhaSQLInserteReplaceValida(const ALinha: string): Boolean;
var
  strLinhaNormalizada, strLinhaNormalizadaUpper: string;
  intPos: Integer;
  strValues: string;
begin
  strLinhaNormalizada      := fNormalizeSQL(ALinha);
  strLinhaNormalizadaUpper := UpperCase(strLinhaNormalizada);

  if not ((Copy(strLinhaNormalizadaUpper, 1, 13) = 'REPLACE INTO ') or
          (Copy(strLinhaNormalizadaUpper, 1, 12) = 'INSERT INTO ')) then
  begin
    Result := False;
    Exit;
  end;

  intPos := Pos(' VALUES ', strLinhaNormalizadaUpper);
  if intPos = 0 then
  begin
    Result := False;
    Exit;
  end;

  strValues := Trim(Copy(strLinhaNormalizada, intPos + 8, MaxInt));

  if (strValues = '') or (strValues[1] <> '(') then
  begin
    Result := False;
    Exit;
  end;

  Result := fParentesesBalanceados(strValues);
end;

function fNormalizeSQL(const ASQL: string): string;
type
  TParseState = (
    psNormal,
    psSingleQuote,
    psDoubleQuote,
    psLineCommentDash,
    psLineCommentHash,
    psBlockComment
  );
var
  I, L: Integer;
  C, NextC: Char;
  State: TParseState;
  LastSpace: Boolean;
  S: string;
  SB: TStringBuilder;

  procedure AddChar(const AChar: Char);
  begin
    SB.Append(AChar);
  end;

  procedure AddSingleSpace;
  begin
    if not LastSpace then
    begin
      SB.Append(' ');
      LastSpace := True;
    end;
  end;

  function IsSpace(const AChar: Char): Boolean;
  begin
    Result := (AChar = ' ') or (AChar = #9) or (AChar = #10) or (AChar = #13);
  end;

begin
  S := Trim(ASQL);
  L := Length(S);
  LastSpace := False;
  State := psNormal;
  SB := TStringBuilder.Create(L);
  try
    I := 1;
    while I <= L do
    begin
      C := S[I];
      if I < L then
        NextC := S[I + 1]
      else
        NextC := #0;

      case State of
        psNormal:
        begin
          if IsSpace(C) then
          begin
            AddSingleSpace;
          end
          else
          if C = '''' then
          begin
            AddChar(C);
            LastSpace := False;
            State := psSingleQuote;
          end
          else
          if C = '"' then
          begin
            AddChar(C);
            LastSpace := False;
            State := psDoubleQuote;
          end
          else
          if (C = '-') and (NextC = '-') and
             ((I + 2 > L) or (S[I + 2] <= ' ')) then
          begin
            AddChar(C);
            AddChar(NextC);
            LastSpace := False;
            State := psLineCommentDash;
            Inc(I);
          end
          else
          if C = '#' then
          begin
            AddChar(C);
            LastSpace := False;
            State := psLineCommentHash;
          end
          else
          if (C = '/') and (NextC = '*') then
          begin
            AddChar(C);
            AddChar(NextC);
            LastSpace := False;
            State := psBlockComment;
            Inc(I);
          end
          else
          begin
            AddChar(C);
            LastSpace := False;
          end;
        end;

        psSingleQuote:
        begin
          AddChar(C);
          LastSpace := False;

          if C = '\' then
          begin
            if I < L then
            begin
              Inc(I);
              AddChar(S[I]);
            end;
          end
          else
          if C = '''' then
          begin
            if (I < L) and (S[I + 1] = '''') then
            begin
              Inc(I);
              AddChar(S[I]);
            end
            else
              State := psNormal;
          end;
        end;

        psDoubleQuote:
        begin
          AddChar(C);
          LastSpace := False;

          if C = '\' then
          begin
            if I < L then
            begin
              Inc(I);
              AddChar(S[I]);
            end;
          end
          else
          if C = '"' then
          begin
            if (I < L) and (S[I + 1] = '"') then
            begin
              Inc(I);
              AddChar(S[I]);
            end
            else
              State := psNormal;
          end;
        end;

        psLineCommentDash:
        begin
          AddChar(C);
          LastSpace := False;

          if (C = #10) or (C = #13) then
            State := psNormal;
        end;

        psLineCommentHash:
        begin
          AddChar(C);
          LastSpace := False;

          if (C = #10) or (C = #13) then
            State := psNormal;
        end;

        psBlockComment:
        begin
          AddChar(C);
          LastSpace := False;

          if (C = '*') and (NextC = '/') then
          begin
            Inc(I);
            AddChar(S[I]);
            State := psNormal;
          end;
        end;
      end;

      Inc(I);
    end;

    Result := Trim(SB.ToString);
  finally
    SB.Free;
  end;
end;

function fOtimizaInsertReplaceMultiValue(const ASQL: string;
                                         const AIgnoreTable: array of string): string;
const
  OFFSET_VALUES = 8; // Length(' VALUES ')
var
  lstLinhas, lstOutput: TStringList;
  dicGroups: TDictionary<string, TStringList>;
  dicFirstEmit: TDictionary<string, Boolean>;

  intIdx,
  intPos,
  intTab: Integer;

  strLinha,
  strLinhaNormalizada,
  strIntRpl,
  strValues,
  strLinhaNormalizadaUpper: string;

  lstValues: TStringList;
  strTabela: string;
  blnIgnore: Boolean;
  Key, strTabelaIgnorada: string;
begin
  Result := '';

  lstLinhas    := Nil;
  lstOutput    := Nil;
  dicGroups    := Nil;
  dicFirstEmit := Nil;

  try
    lstLinhas    := TStringList.Create;
    lstOutput    := TStringList.Create;
    dicGroups    := TDictionary<string, TStringList>.Create;
    dicFirstEmit := TDictionary<string, Boolean>.Create;

    lstLinhas.Text := ASQL;

    for intIdx := 0 to lstLinhas.Count - 1 do
    begin
      strLinha := Trim(lstLinhas[intIdx]);

      if (Copy(strLinha,1,2) = '--') or (Copy(strLinha,1,2) = '/*') then
        Continue;

      strLinhaNormalizada := fNormalizeSQL(strLinha);
      if not fLinhaSQLInserteReplaceValida(strLinhaNormalizada) then
        Continue;

      strTabela := UpperCase(fExtractTableName(strLinhaNormalizada));

      blnIgnore := False;
      for intTab := Low(AIgnoreTable) to High(AIgnoreTable) do
      begin
        strTabelaIgnorada := UpperCase(Trim(AIgnoreTable[intTab]));
        if strTabelaIgnorada = strTabela then
        begin
          blnIgnore := True;
          Break;
        end;
      end;

      if blnIgnore then
        Continue;

      strLinhaNormalizadaUpper := UpperCase(strLinhaNormalizada);

      intPos := Pos(' VALUES ', strLinhaNormalizadaUpper);
      if intPos = 0 then
        Continue;

      strIntRpl := Trim(Copy(strLinhaNormalizada, 1, intPos + OFFSET_VALUES - 1));
      strValues := Trim(Copy(strLinhaNormalizada, intPos + OFFSET_VALUES, MaxInt));
      if (Length(strValues) > 0) and (strValues[Length(strValues)] = ';') then
        Delete(strValues, Length(strValues), 1);

      if not dicGroups.TryGetValue(strIntRpl, lstValues) then
      begin
        lstValues := TStringList.Create;
        dicGroups.Add(strIntRpl, lstValues);
        dicFirstEmit.Add(strIntRpl, False);
      end;

      lstValues.Add(strValues);
    end;

    for intIdx := 0 to lstLinhas.Count - 1 do
    begin
      strLinha := Trim(lstLinhas[intIdx]);

      if (Copy(strLinha,1,2) = '--') or (Copy(strLinha,1,2) = '/*') then
      begin
        lstOutput.Add(lstLinhas[intIdx]);
        Continue;
      end;

      strLinhaNormalizada := fNormalizeSQL(strLinha);
      if fLinhaSQLInserteReplaceValida(strLinhaNormalizada) then
      begin
        strTabela := UpperCase(fExtractTableName(strLinhaNormalizada));

        blnIgnore := False;
        for intTab := Low(AIgnoreTable) to High(AIgnoreTable) do
        begin
          strTabelaIgnorada := UpperCase(Trim(AIgnoreTable[intTab]));
          if strTabelaIgnorada = strTabela then
          begin
            blnIgnore := True;
            Break;
          end;
        end;

        if blnIgnore then
        begin
          lstOutput.Add(lstLinhas[intIdx]);
          Continue;
        end;

        strLinhaNormalizadaUpper := UpperCase(strLinhaNormalizada);
        intPos := Pos(' VALUES ', strLinhaNormalizadaUpper);
        strIntRpl := Trim(Copy(strLinhaNormalizada, 1, intPos + OFFSET_VALUES - 1));

        if dicFirstEmit[strIntRpl] = False then
        begin
          dicFirstEmit[strIntRpl] := True;

          lstOutput.Add(strIntRpl);
          lstValues := dicGroups[strIntRpl];

          for intTab := 0 to lstValues.Count - 1 do
          begin
            if intTab < lstValues.Count - 1 then
              lstOutput.Add(lstValues[intTab] + ',')
            else
              lstOutput.Add(lstValues[intTab] + ';');
          end;

          lstOutput.Add('');
        end;

        Continue;
      end;

      lstOutput.Add(lstLinhas[intIdx]);
    end;

    Result := lstOutput.Text;
  finally
    if Assigned(dicGroups) then
    begin
      for Key in dicGroups.Keys do
      begin
        if dicGroups.TryGetValue(Key, lstValues) then
          lstValues.Free;
      end;

      dicGroups.Free;
    end;

    if Assigned(dicFirstEmit) then
      dicFirstEmit.Free;

    if Assigned(lstLinhas) then
      lstLinhas.Free;

    if Assigned(lstOutput) then
      lstOutput.Free;
  end;
end;

end.
