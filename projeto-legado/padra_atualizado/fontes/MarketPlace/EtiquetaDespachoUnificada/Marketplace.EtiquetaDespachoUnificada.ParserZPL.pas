unit Marketplace.EtiquetaDespachoUnificada.ParserZPL;

// Parser ZPL generico com escalonamento proporcional.
//
// Nao contem heuristicas de marketplace especifico. Pisos de legibilidade
// (fonte, ^FR reverse, ^BC barcode, ^BQ QR) sao parametros passados pelo
// processador de cada marketplace via TConfigPisos.
//
// Operacoes:
//   1. Reescalar coordenadas de ^FO, ^FT (fatorX + fatorY + offset)
//   2. Reescalar fontes ^A0 (fatorY, com piso normal / piso reverse via lookahead ^FR)
//   3. Reescalar ^GB (largura por fatorX, altura por fatorY)
//   4. Reescalar ^FB (largura por fatorX, line spacing por fatorY)
//   5. Reescalar altura de ^BC por fatorY (piso configuravel). ^BY nao escala.
//   6. Reescalar magnification de ^BQ por fatorY (piso configuravel)
//   7. Redimensionar bitmap ^GFA por fatorX/fatorY via CodecGFA
//   8. Manter todo o restante do ZPL byte-a-byte identico

interface

uses
  System.SysUtils, System.Classes,
  Marketplace.EtiquetaDespachoUnificada.CodecGFA;

type
  TConfigPisos = record
    intPisoFont: Integer;         // piso altura/largura ^A0 normal
    intPisoFontReverse: Integer;  // piso ^A0 quando ^FR presente no campo
    intPisoBarcode: Integer;      // piso altura ^BC (Code128)
    intPisoQRMagnif: Integer;     // piso magnification ^BQ

    // Configuracao "sem clamp" — usa 1 em tudo. Util para preview
    // sem risco de layout inflar em fontes pequenas.
    class function CriarPermissiva: TConfigPisos; static;
  end;

  TParserZPL = class
  strict private
    class function fLerNumero(const AstrTexto: String; var AintPos: Integer): Integer; static;
    class function fEscalaFO(const AstrTexto: String; var AintPos: Integer;
                             const AstrPrefixo: String;
                             const AfltFatorX, AfltFatorY: Double;
                             const AintOffsetX, AintOffsetY: Integer): String; static;
    class function fEscalaGB(const AstrTexto: String; var AintPos: Integer;
                             const AfltFatorX, AfltFatorY: Double): String; static;
    class function fEscalaFB(const AstrTexto: String; var AintPos: Integer;
                             const AfltFatorX, AfltFatorY: Double): String; static;
    class function fEscalaA0(const AstrTexto: String; var AintPos: Integer;
                             const AfltFatorY: Double;
                             const ArecPisos: TConfigPisos): String; static;
    class function fEscalaBC(const AstrTexto: String; var AintPos: Integer;
                             const AfltFatorY: Double;
                             const ArecPisos: TConfigPisos): String; static;
    class function fEscalaBQ(const AstrTexto: String; var AintPos: Integer;
                             const AfltFatorY: Double;
                             const ArecPisos: TConfigPisos): String; static;
    class function fEscalaGFA(const AstrTexto: String; var AintPos: Integer;
                              const AfltFatorX, AfltFatorY: Double): String; static;
  public
    class function fRemoverEnvoltorio(const AstrZPL: String): String;
    class function fReescalarCoordenadas(const AstrZPL: String;
                                         const AfltFatorX, AfltFatorY: Double;
                                         const AintOffsetX, AintOffsetY: Integer;
                                         const ArecPisos: TConfigPisos): String;
  end;

implementation

uses
  untFuncoesSimples;

class function TConfigPisos.CriarPermissiva: TConfigPisos;
begin
  Result.intPisoFont         := 1;
  Result.intPisoFontReverse  := 1;
  Result.intPisoBarcode      := 1;
  Result.intPisoQRMagnif     := 1;
end;

class function TParserZPL.fLerNumero(const AstrTexto: String; var AintPos: Integer): Integer;
var
  strNum: String;
begin
  strNum := '';
  while (AintPos <= Length(AstrTexto)) and
        CharInSet(AstrTexto[AintPos], ['0'..'9']) do
  begin
    strNum := strNum + AstrTexto[AintPos];
    Inc(AintPos);
  end;
  Result := StrToIntDef(strNum, 0);
end;

class function TParserZPL.fEscalaFO(const AstrTexto: String; var AintPos: Integer;
                                    const AstrPrefixo: String;
                                    const AfltFatorX, AfltFatorY: Double;
                                    const AintOffsetX, AintOffsetY: Integer): String;
var
  intX, intY: Integer;
begin
  intX := fLerNumero(AstrTexto, AintPos);
  if (AintPos > Length(AstrTexto)) or (AstrTexto[AintPos] <> ',') then
  begin
    Result := AstrPrefixo + IntToStr(intX);
    Exit;
  end;
  Inc(AintPos);
  intY := fLerNumero(AstrTexto, AintPos);

  Result := Format('%s%d,%d',
    [AstrPrefixo,
     Round(intX * AfltFatorX) + AintOffsetX,
     Round(intY * AfltFatorY) + AintOffsetY]);
end;

class function TParserZPL.fEscalaGB(const AstrTexto: String; var AintPos: Integer;
                                    const AfltFatorX, AfltFatorY: Double): String;
var
  intW, intH, intT: Integer;
begin
  intW := fLerNumero(AstrTexto, AintPos);
  if (AintPos > Length(AstrTexto)) or (AstrTexto[AintPos] <> ',') then
  begin
    Result := '^GB' + IntToStr(intW);
    Exit;
  end;
  Inc(AintPos);
  intH := fLerNumero(AstrTexto, AintPos);
  if (AintPos > Length(AstrTexto)) or (AstrTexto[AintPos] <> ',') then
  begin
    Result := Format('^GB%d,%d', [Round(intW * AfltFatorX), Round(intH * AfltFatorY)]);
    Exit;
  end;
  Inc(AintPos);
  intT := fLerNumero(AstrTexto, AintPos);
  if intT > 1 then
    intT := Round(intT * AfltFatorY);
  if intT < 1 then
    intT := 1;
  Result := Format('^GB%d,%d,%d', [Round(intW * AfltFatorX), Round(intH * AfltFatorY), intT]);
end;

class function TParserZPL.fEscalaFB(const AstrTexto: String; var AintPos: Integer;
                                    const AfltFatorX, AfltFatorY: Double): String;
var
  intW, intLinhas, intSpacing: Integer;
  strResto: String;
  intVirg: Integer;
  blnSpacingNeg: Boolean;
begin
  intW := fLerNumero(AstrTexto, AintPos);
  if (AintPos > Length(AstrTexto)) or (AstrTexto[AintPos] <> ',') then
  begin
    Result := Format('^FB%d', [Round(intW * AfltFatorX)]);
    Exit;
  end;
  Inc(AintPos);
  intLinhas := fLerNumero(AstrTexto, AintPos);
  if (AintPos > Length(AstrTexto)) or (AstrTexto[AintPos] <> ',') then
  begin
    Result := Format('^FB%d,%d', [Round(intW * AfltFatorX), intLinhas]);
    Exit;
  end;
  Inc(AintPos);

  blnSpacingNeg := False;
  if (AintPos <= Length(AstrTexto)) and (AstrTexto[AintPos] = '-') then
  begin
    blnSpacingNeg := True;
    Inc(AintPos);
  end;
  intSpacing := fLerNumero(AstrTexto, AintPos);
  if blnSpacingNeg then
    intSpacing := -intSpacing;
  intSpacing := Round(intSpacing * AfltFatorY);

  strResto := '';
  intVirg := AintPos;
  while (intVirg <= Length(AstrTexto)) and (AstrTexto[intVirg] <> '^') do
    Inc(intVirg);
  if intVirg > AintPos then
  begin
    strResto := Copy(AstrTexto, AintPos, intVirg - AintPos);
    AintPos := intVirg;
  end;

  Result := Format('^FB%d,%d,%d%s',
    [Round(intW * AfltFatorX), intLinhas, intSpacing, strResto]);
end;

class function TParserZPL.fEscalaA0(const AstrTexto: String; var AintPos: Integer;
                                    const AfltFatorY: Double;
                                    const ArecPisos: TConfigPisos): String;
var
  intH, intW: Integer;
  strOrient: String;
  intPiso, intLookahead: Integer;
  blnTemFR: Boolean;
begin
  // ^A0<orient>,<h>,<w>   ou   ^A0,<h>,<w>
  strOrient := '';

  if (AintPos <= Length(AstrTexto)) and
     CharInSet(AstrTexto[AintPos], ['N', 'R', 'I', 'B']) then
  begin
    strOrient := AstrTexto[AintPos];
    Inc(AintPos);
  end;

  if (AintPos > Length(AstrTexto)) or (AstrTexto[AintPos] <> ',') then
  begin
    Result := '^A0' + strOrient;
    Exit;
  end;
  Inc(AintPos);

  intH := fLerNumero(AstrTexto, AintPos);

  // Lookahead: detecta ^FR (reverse) entre este ^A0 e o proximo ^FD/^FS.
  // Texto reverso precisa de piso maior porque strokes finos brancos em
  // fundo preto perdem detalhe na impressao termica.
  blnTemFR := False;
  intLookahead := AintPos;
  while intLookahead + 2 <= Length(AstrTexto) do
  begin
    if AstrTexto[intLookahead] = '^' then
    begin
      if (AstrTexto[intLookahead+1] = 'F') and
         ((AstrTexto[intLookahead+2] = 'D') or (AstrTexto[intLookahead+2] = 'S')) then
        Break;
      if (AstrTexto[intLookahead+1] = 'A') and (AstrTexto[intLookahead+2] = '0') then
        Break;
      if (AstrTexto[intLookahead+1] = 'F') and (AstrTexto[intLookahead+2] = 'R') then
      begin
        blnTemFR := True;
        Break;
      end;
    end;
    Inc(intLookahead);
  end;

  if blnTemFR then
    intPiso := ArecPisos.intPisoFontReverse
  else
    intPiso := ArecPisos.intPisoFont;

  if (AintPos > Length(AstrTexto)) or (AstrTexto[AintPos] <> ',') then
  begin
    intH := Round(intH * AfltFatorY);
    if intH < intPiso then intH := intPiso;
    Result := Format('^A0%s,%d', [strOrient, intH]);
    Exit;
  end;
  Inc(AintPos);
  intW := fLerNumero(AstrTexto, AintPos);

  intH := Round(intH * AfltFatorY);
  intW := Round(intW * AfltFatorY);
  if intH < intPiso then intH := intPiso;
  if intW < intPiso then intW := intPiso;

  Result := Format('^A0%s,%d,%d', [strOrient, intH, intW]);
end;

class function TParserZPL.fEscalaBC(const AstrTexto: String; var AintPos: Integer;
                                    const AfltFatorY: Double;
                                    const ArecPisos: TConfigPisos): String;
var
  strOrient: String;
  intAltura: Integer;
  intInicioResto: Integer;
  strResto: String;
begin
  // ^BC<orient>,<altura>,<line>,<lineAbove>,<checkDigit>,<mode>
  strOrient := '';

  if (AintPos <= Length(AstrTexto)) and
     CharInSet(AstrTexto[AintPos], ['N', 'R', 'I', 'B']) then
  begin
    strOrient := AstrTexto[AintPos];
    Inc(AintPos);
  end;

  if (AintPos > Length(AstrTexto)) or (AstrTexto[AintPos] <> ',') then
  begin
    Result := '^BC' + strOrient;
    Exit;
  end;
  Inc(AintPos);

  intAltura := fLerNumero(AstrTexto, AintPos);
  if intAltura > 0 then
  begin
    intAltura := Round(intAltura * AfltFatorY);
    if intAltura < ArecPisos.intPisoBarcode then
      intAltura := ArecPisos.intPisoBarcode;
  end;

  intInicioResto := AintPos;
  while (intInicioResto <= Length(AstrTexto)) and (AstrTexto[intInicioResto] <> '^') do
    Inc(intInicioResto);
  if intInicioResto > AintPos then
  begin
    strResto := Copy(AstrTexto, AintPos, intInicioResto - AintPos);
    AintPos := intInicioResto;
  end
  else
    strResto := '';

  Result := Format('^BC%s,%d%s', [strOrient, intAltura, strResto]);
end;

class function TParserZPL.fEscalaBQ(const AstrTexto: String; var AintPos: Integer;
                                    const AfltFatorY: Double;
                                    const ArecPisos: TConfigPisos): String;
var
  strOrient: String;
  intModel, intMagnif: Integer;
  intInicioResto: Integer;
  strResto: String;
begin
  // ^BQ<orient>,<model>,<magnification>,<errorCorrection>,<mask>
  strOrient := '';

  if (AintPos <= Length(AstrTexto)) and
     CharInSet(AstrTexto[AintPos], ['N', 'R', 'I', 'B']) then
  begin
    strOrient := AstrTexto[AintPos];
    Inc(AintPos);
  end;

  if (AintPos > Length(AstrTexto)) or (AstrTexto[AintPos] <> ',') then
  begin
    Result := '^BQ' + strOrient;
    Exit;
  end;
  Inc(AintPos);

  intModel := fLerNumero(AstrTexto, AintPos);
  if (AintPos > Length(AstrTexto)) or (AstrTexto[AintPos] <> ',') then
  begin
    Result := Format('^BQ%s,%d', [strOrient, intModel]);
    Exit;
  end;
  Inc(AintPos);

  intMagnif := fLerNumero(AstrTexto, AintPos);
  if intMagnif > 0 then
  begin
    intMagnif := Round(intMagnif * AfltFatorY);
    if intMagnif < ArecPisos.intPisoQRMagnif then
      intMagnif := ArecPisos.intPisoQRMagnif;
  end;

  intInicioResto := AintPos;
  while (intInicioResto <= Length(AstrTexto)) and (AstrTexto[intInicioResto] <> '^') do
    Inc(intInicioResto);
  if intInicioResto > AintPos then
  begin
    strResto := Copy(AstrTexto, AintPos, intInicioResto - AintPos);
    AintPos := intInicioResto;
  end
  else
    strResto := '';

  Result := Format('^BQ%s,%d,%d%s', [strOrient, intModel, intMagnif, strResto]);
end;

class function TParserZPL.fEscalaGFA(const AstrTexto: String; var AintPos: Integer;
                                     const AfltFatorX, AfltFatorY: Double): String;
var
  intTotal1, intTotal2, intBpr: Integer;
  intNovoTotal, intNovaBpr: Integer;
  intInicioPayload, intFimPayload: Integer;
  strPayload, strPayloadNovo: String;
begin
  if (AintPos > Length(AstrTexto)) or (AstrTexto[AintPos] <> ',') then
  begin
    Result := '^GFA';
    Exit;
  end;
  Inc(AintPos);

  intTotal1 := fLerNumero(AstrTexto, AintPos);
  if (AintPos > Length(AstrTexto)) or (AstrTexto[AintPos] <> ',') then
  begin
    Result := Format('^GFA,%d', [intTotal1]);
    Exit;
  end;
  Inc(AintPos);

  intTotal2 := fLerNumero(AstrTexto, AintPos);
  if (AintPos > Length(AstrTexto)) or (AstrTexto[AintPos] <> ',') then
  begin
    Result := Format('^GFA,%d,%d', [intTotal1, intTotal2]);
    Exit;
  end;
  Inc(AintPos);

  intBpr := fLerNumero(AstrTexto, AintPos);
  if (AintPos > Length(AstrTexto)) or (AstrTexto[AintPos] <> ',') then
  begin
    Result := Format('^GFA,%d,%d,%d', [intTotal1, intTotal2, intBpr]);
    Exit;
  end;
  Inc(AintPos);

  intInicioPayload := AintPos;
  intFimPayload := AintPos;
  while (intFimPayload <= Length(AstrTexto)) and (AstrTexto[intFimPayload] <> '^') do
    Inc(intFimPayload);
  strPayload := Copy(AstrTexto, intInicioPayload, intFimPayload - intInicioPayload);
  AintPos := intFimPayload;

  if (intTotal1 = 0) or (intBpr = 0) or (strPayload = '') then
  begin
    Result := Format('^GFA,%d,%d,%d,%s', [intTotal1, intTotal2, intBpr, strPayload]);
    Exit;
  end;

  try
    strPayloadNovo := TCodecGFA.fRedimensionar(strPayload, intTotal1, intBpr,
                                               AfltFatorX, AfltFatorY,
                                               intNovoTotal, intNovaBpr);
    Result := Format('^GFA,%d,%d,%d,%s',
                     [intNovoTotal, intNovoTotal, intNovaBpr, strPayloadNovo]);
  except
    on E: Exception do
    begin
      // Falha ao redimensionar o bitmap ^GFA - retorna o original sobre as
      // coordenadas escaladas (etiqueta imprime "torta"). Erro tratado
      // (fluxo continua com fallback) e verbose (4 parametros + exception)
      // - pMensagemSonora sem rollback de transacao.
      pMensagemSonora('FALHA AO REDIMENSIONAR BITMAP DA ETIQUETA' + #13#10 + #13#10 +
                'Local: [TParserZPL.fEscalaGFA]' + #13#10 +
                Format('Parametros: total=%d bpr=%d fatorX=%.4f fatorY=%.4f',
                       [intTotal1, intBpr, AfltFatorX, AfltFatorY]) + #13#10 + #13#10 +
                E.ClassName + ': ' + E.Message + #13#10 + #13#10 +
                'A etiqueta sera impressa com o bitmap no tamanho original ' +
                '(pode ficar desalinhada com as coordenadas escaladas).');
      Result := Format('^GFA,%d,%d,%d,%s', [intTotal1, intTotal2, intBpr, strPayload]);
    end;
  end;
end;

class function TParserZPL.fRemoverEnvoltorio(const AstrZPL: String): String;
begin
  Result := AstrZPL;
  Result := StringReplace(Result, '^XA', '', [rfReplaceAll]);
  Result := StringReplace(Result, '^XZ', '', [rfReplaceAll]);
end;

class function TParserZPL.fReescalarCoordenadas(const AstrZPL: String;
                                                const AfltFatorX, AfltFatorY: Double;
                                                const AintOffsetX, AintOffsetY: Integer;
                                                const ArecPisos: TConfigPisos): String;
var
  slBuild: TStringBuilder;
  intI, intLen: Integer;
begin
  intLen := Length(AstrZPL);
  slBuild := TStringBuilder.Create;
  try
    intI := 1;
    while intI <= intLen do
    begin
      if (AstrZPL[intI] = '^') and (intI + 2 <= intLen) then
      begin
        if (AstrZPL[intI + 1] = 'F') and (AstrZPL[intI + 2] = 'O') then
        begin
          Inc(intI, 3);
          slBuild.Append(fEscalaFO(AstrZPL, intI, '^FO',
            AfltFatorX, AfltFatorY, AintOffsetX, AintOffsetY));
          Continue;
        end;

        if (AstrZPL[intI + 1] = 'F') and (AstrZPL[intI + 2] = 'T') then
        begin
          Inc(intI, 3);
          slBuild.Append(fEscalaFO(AstrZPL, intI, '^FT',
            AfltFatorX, AfltFatorY, AintOffsetX, AintOffsetY));
          Continue;
        end;

        if (AstrZPL[intI + 1] = 'G') and (AstrZPL[intI + 2] = 'B') then
        begin
          Inc(intI, 3);
          slBuild.Append(fEscalaGB(AstrZPL, intI, AfltFatorX, AfltFatorY));
          Continue;
        end;

        if (AstrZPL[intI + 1] = 'F') and (AstrZPL[intI + 2] = 'B') then
        begin
          Inc(intI, 3);
          slBuild.Append(fEscalaFB(AstrZPL, intI, AfltFatorX, AfltFatorY));
          Continue;
        end;

        if (AstrZPL[intI + 1] = 'A') and (AstrZPL[intI + 2] = '0') then
        begin
          Inc(intI, 3);
          slBuild.Append(fEscalaA0(AstrZPL, intI, AfltFatorY, ArecPisos));
          Continue;
        end;

        if (AstrZPL[intI + 1] = 'B') and (AstrZPL[intI + 2] = 'C') then
        begin
          Inc(intI, 3);
          slBuild.Append(fEscalaBC(AstrZPL, intI, AfltFatorY, ArecPisos));
          Continue;
        end;

        if (AstrZPL[intI + 1] = 'B') and (AstrZPL[intI + 2] = 'Q') then
        begin
          Inc(intI, 3);
          slBuild.Append(fEscalaBQ(AstrZPL, intI, AfltFatorY, ArecPisos));
          Continue;
        end;

        if (intI + 3 <= intLen) and
           (AstrZPL[intI + 1] = 'G') and
           (AstrZPL[intI + 2] = 'F') and
           (AstrZPL[intI + 3] = 'A') then
        begin
          Inc(intI, 4);
          slBuild.Append(fEscalaGFA(AstrZPL, intI, AfltFatorX, AfltFatorY));
          Continue;
        end;
      end;

      slBuild.Append(AstrZPL[intI]);
      Inc(intI);
    end;

    Result := slBuild.ToString;
  finally
    FreeAndNil(slBuild);
  end;
end;

end.
