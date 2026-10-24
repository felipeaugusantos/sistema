unit Marketplace.EtiquetaDespachoUnificada.CompactadorLayout;

// Realocacao pre-escala baseada em deteccao de whitespace.
//
// Motivacao: quando o fator de compressao vertical (fatorY) e pequeno (~0.5),
// elementos com dimensao fisica minima (QR magnif >= 4 = ~116 dots) nao encolhem
// proporcionalmente. Isso faz o QR "crescer" em relacao ao layout comprimido
// e sobrepor elementos vizinhos (ex: quadro solido "R" no rodape ML).
//
// Estrategia: antes do parser escalar, detectar padroes conhecidos de colisao
// futura e realocar o QR pra dentro de whitespace disponivel acima.
//
// Escopo desta versao (Abordagem 1 — Y-range simples):
//   1. Encontrar ^BQN (QR code) e seu ^FO precedente
//   2. Encontrar ^GB imediatamente seguinte que seja "solido"
//      (thickness >= altura/2 — indica quadrado preenchido)
//   3. Verificar se colidem em X e se colidem em Y pos-escala
//   4. Encontrar maior Y de elementos anteriores ao QR (whitespace upper bound)
//   5. Se houver espaco suficiente, reescrever ^FO do QR pra Y superior
//
// Abordagem X-agnostica intencional: considera qualquer elemento anterior,
// nao so os que sobrepoem X. Mais conservador — perde otimizacoes, mas evita
// realocar QR sobre elemento que estava em X diferente mas altura grande.

interface

uses
  System.SysUtils, System.StrUtils;

type
  TCompactadorLayout = class
  strict private
    class function fLerNumeroApos(const AstrZPL: String; var AintPos: Integer): Integer; static;
    class function fUltimaOcorrenciaFO(const AstrZPL: String; const AintPosLim: Integer): Integer; static;
    class function fLerFO(const AstrZPL: String; const AintPosFO: Integer;
                          out AintX, AintY: Integer): Boolean; static;
    class function fLerGB(const AstrZPL: String; const AintPosGB: Integer;
                          out AintW, AintH, AintT: Integer): Boolean; static;
    class function fMaxYAntes(const AstrZPL: String; const AintPosLim: Integer;
                              const AintFaixaXIni, AintFaixaXFim: Integer): Integer; static;
    class function fReescreverFOY(const AstrZPL: String;
                                  const AintPosFO, AintYNovo: Integer): String; static;
    class function fRemoverSeparadorSobArea(const AstrZPL: String;
                                            const AintXIni, AintXFim,
                                                  AintYIni, AintYFim: Integer): String; static;
  public
    class function fRealocarPorWhitespace(const AstrZPL: String;
                                          const AfltFatorY: Double): String;
  end;

implementation

const
  // Sincronizado com ParserZPL.fEscalaBQ (piso magnif QR = 4)
  PISO_QR_MAGNIF        = 4;
  // QR model 2 version tipica para payload ML (~40 chars, error L)
  QR_MODULOS_ESTIMADO   = 29;
  // Folga vertical minima entre QR e proximo elemento (dots pos-escala)
  FOLGA_MIN_DOTS        = 10;
  // Estimativa conservadora de altura de elemento generico ao computar upper bound
  ALTURA_ELEMENTO_EST   = 40;

class function TCompactadorLayout.fLerNumeroApos(const AstrZPL: String; var AintPos: Integer): Integer;
var strNum: String;
begin
  strNum := '';
  while (AintPos <= Length(AstrZPL)) and CharInSet(AstrZPL[AintPos], ['0'..'9']) do
  begin
    strNum := strNum + AstrZPL[AintPos];
    Inc(AintPos);
  end;
  Result := StrToIntDef(strNum, 0);
end;

class function TCompactadorLayout.fUltimaOcorrenciaFO(const AstrZPL: String;
                                                      const AintPosLim: Integer): Integer;
var intI: Integer;
begin
  Result := 0;
  intI := AintPosLim - 1;
  while intI > 0 do
  begin
    if (AstrZPL[intI] = '^') and (intI + 2 <= Length(AstrZPL)) and
       (AstrZPL[intI+1] = 'F') and (AstrZPL[intI+2] = 'O') then
    begin
      Result := intI;
      Exit;
    end;
    Dec(intI);
  end;
end;

class function TCompactadorLayout.fLerFO(const AstrZPL: String; const AintPosFO: Integer;
                                         out AintX, AintY: Integer): Boolean;
var intPos: Integer;
begin
  Result := False;
  AintX := 0;
  AintY := 0;
  intPos := AintPosFO + 3;  // skip '^FO'
  if intPos > Length(AstrZPL) then Exit;
  AintX := fLerNumeroApos(AstrZPL, intPos);
  if (intPos > Length(AstrZPL)) or (AstrZPL[intPos] <> ',') then Exit;
  Inc(intPos);
  AintY := fLerNumeroApos(AstrZPL, intPos);
  Result := True;
end;

class function TCompactadorLayout.fLerGB(const AstrZPL: String; const AintPosGB: Integer;
                                         out AintW, AintH, AintT: Integer): Boolean;
var intPos: Integer;
begin
  Result := False;
  AintW := 0;
  AintH := 0;
  AintT := 0;
  intPos := AintPosGB + 3;  // skip '^GB'
  AintW := fLerNumeroApos(AstrZPL, intPos);
  if (intPos > Length(AstrZPL)) or (AstrZPL[intPos] <> ',') then Exit;
  Inc(intPos);
  AintH := fLerNumeroApos(AstrZPL, intPos);
  if (intPos > Length(AstrZPL)) or (AstrZPL[intPos] <> ',') then Exit;
  Inc(intPos);
  AintT := fLerNumeroApos(AstrZPL, intPos);
  Result := True;
end;

class function TCompactadorLayout.fMaxYAntes(const AstrZPL: String;
                                             const AintPosLim: Integer;
                                             const AintFaixaXIni, AintFaixaXFim: Integer): Integer;
const
  // Slack de X pra considerar overlap: elementos podem ter texto que se
  // estende alem do ^FO X (ex: ^A0 sem ^FB tem largura ~ font_H * chars).
  // Slack conservador pra nao subestimar largura real.
  LARGURA_ESTIMADA_ELEMENTO = 200;
var
  intI, intPos, intFOX, intFOY: Integer;
  intElemXIni, intElemXFim: Integer;
begin
  // Percorre todas as ocorrencias de ^FO antes de AintPosLim e retorna o
  // maior Y observado (+ estimativa de altura) DENTRE aqueles cujo X
  // sobrepoe a faixa alvo [AintFaixaXIni..AintFaixaXFim].
  //
  // Filtro X e essencial: ZPL nao exige ordem espacial. Ex: receiver zone
  // (X=30) aparece TEXTUALMENTE antes do QR (X=650) mas nao concorre pelo
  // mesmo espaco vertical. Sem filtro X, Y=1150 (complemento) seria
  // considerado limite, quando na verdade nada em X=650 existe.
  Result := 0;
  intI := 1;
  while intI < AintPosLim - 2 do
  begin
    if (AstrZPL[intI] = '^') and
       (AstrZPL[intI+1] = 'F') and (AstrZPL[intI+2] = 'O') then
    begin
      intPos := intI + 3;
      intFOX := fLerNumeroApos(AstrZPL, intPos);
      if (intPos <= Length(AstrZPL)) and (AstrZPL[intPos] = ',') then
      begin
        Inc(intPos);
        intFOY := fLerNumeroApos(AstrZPL, intPos);

        // Bounding box X do elemento (aproximado)
        intElemXIni := intFOX;
        intElemXFim := intFOX + LARGURA_ESTIMADA_ELEMENTO;

        // Overlap com faixa X alvo?
        if (intElemXIni < AintFaixaXFim) and (intElemXFim > AintFaixaXIni) then
        begin
          if (intFOY + ALTURA_ELEMENTO_EST) > Result then
            Result := intFOY + ALTURA_ELEMENTO_EST;
        end;
      end;
      Inc(intI, 3);
    end
    else
      Inc(intI);
  end;
end;

class function TCompactadorLayout.fReescreverFOY(const AstrZPL: String;
                                                  const AintPosFO, AintYNovo: Integer): String;
var
  intPos, intX: Integer;
  intPosFimNumeros: Integer;
  strAntes, strDepois: String;
begin
  Result := AstrZPL;
  intPos := AintPosFO + 3;
  intX := fLerNumeroApos(AstrZPL, intPos);
  if (intPos > Length(AstrZPL)) or (AstrZPL[intPos] <> ',') then Exit;
  Inc(intPos);
  fLerNumeroApos(AstrZPL, intPos); // consome Y antigo
  intPosFimNumeros := intPos;

  strAntes := Copy(AstrZPL, 1, AintPosFO - 1);
  strDepois := Copy(AstrZPL, intPosFimNumeros, Length(AstrZPL) - intPosFimNumeros + 1);
  Result := strAntes + Format('^FO%d,%d', [intX, AintYNovo]) + strDepois;
end;

class function TCompactadorLayout.fRemoverSeparadorSobArea(const AstrZPL: String;
                                                           const AintXIni, AintXFim,
                                                                 AintYIni, AintYFim: Integer): String;
const
  // Heuristica de "linha separadora horizontal":
  //   X inicial pequeno, W grande, H pequeno, T pequeno
  //   (ex: ^FO0,950^GB850,0,2^FS na etiqueta ML — divisor operacional/receiver)
  SEP_X_MAX     = 20;   // FO X inicial pequeno
  SEP_W_MIN     = 500;  // largura grande (atravessa etiqueta)
  SEP_H_MAX     = 5;    // altura pequena (linha, nao box)
  SEP_T_MAX     = 5;    // espessura pequena
var
  intPos, intPosGB, intPosFO, intPosFS: Integer;
  intFOX, intFOY, intGBW, intGBH, intGBT: Integer;
  strAntes, strDepois: String;
begin
  Result := AstrZPL;
  intPos := 1;
  while intPos <= Length(Result) do
  begin
    intPosGB := PosEx('^GB', Result, intPos);
    if intPosGB = 0 then Break;

    intPosFO := fUltimaOcorrenciaFO(Result, intPosGB);
    if (intPosFO = 0) or not fLerFO(Result, intPosFO, intFOX, intFOY) or
       not fLerGB(Result, intPosGB, intGBW, intGBH, intGBT) then
    begin
      intPos := intPosGB + 3;
      Continue;
    end;

    // Match perfil de linha separadora?
    if (intFOX <= SEP_X_MAX) and (intGBW >= SEP_W_MIN) and
       (intGBH <= SEP_H_MAX) and (intGBT <= SEP_T_MAX) then
    begin
      // Cruza faixa X e Y da area protegida?
      if (intFOX < AintXFim) and (intFOX + intGBW > AintXIni) and
         (intFOY >= AintYIni) and (intFOY <= AintYFim) then
      begin
        intPosFS := PosEx('^FS', Result, intPosGB);
        if intPosFS = 0 then
        begin
          intPos := intPosGB + 3;
          Continue;
        end;
        // Remove trecho ^FO..^GB..^FS inteiro
        strAntes := Copy(Result, 1, intPosFO - 1);
        strDepois := Copy(Result, intPosFS + 3, Length(Result));
        Result := strAntes + strDepois;
        intPos := intPosFO;
        Continue;
      end;
    end;

    intPos := intPosGB + 3;
  end;
end;

class function TCompactadorLayout.fRealocarPorWhitespace(const AstrZPL: String;
                                                         const AfltFatorY: Double): String;
var
  intPosBQ, intPosGB, intPosFOQR, intPosFOGB: Integer;
  intQRX, intQRY, intGBFOX, intGBFOY, intGBW, intGBH, intGBT: Integer;
  intQRAltura, intQRScaledY, intQRScaledEnd, intGBScaledY: Integer;
  intMaxYAcima, intYNovo: Integer;
begin
  Result := AstrZPL;

  // 1. Localiza QR
  intPosBQ := Pos('^BQN', AstrZPL);
  if intPosBQ = 0 then Exit;

  intPosFOQR := fUltimaOcorrenciaFO(AstrZPL, intPosBQ);
  if intPosFOQR = 0 then Exit;
  if not fLerFO(AstrZPL, intPosFOQR, intQRX, intQRY) then Exit;

  // 2. Localiza proximo GB
  intPosGB := PosEx('^GB', AstrZPL, intPosBQ);
  if intPosGB = 0 then Exit;
  if not fLerGB(AstrZPL, intPosGB, intGBW, intGBH, intGBT) then Exit;

  // GB solido? (thickness >= metade da altura)
  if (intGBH = 0) or (intGBT * 2 < intGBH) then Exit;

  intPosFOGB := fUltimaOcorrenciaFO(AstrZPL, intPosGB);
  if intPosFOGB = 0 then Exit;
  if not fLerFO(AstrZPL, intPosFOGB, intGBFOX, intGBFOY) then Exit;

  // 3. Overlap em X? (bounding box do QR: X..X+altura=largura pra QR quadrado)
  intQRAltura := QR_MODULOS_ESTIMADO * PISO_QR_MAGNIF;
  if (intGBFOX >= intQRX + intQRAltura) or
     (intGBFOX + intGBW <= intQRX) then
    Exit;  // GB fora da faixa X do QR

  // 4. Colisao pos-escala em Y?
  intQRScaledY := Round(intQRY * AfltFatorY);
  intQRScaledEnd := intQRScaledY + intQRAltura;
  intGBScaledY := Round(intGBFOY * AfltFatorY);
  if intQRScaledEnd + FOLGA_MIN_DOTS <= intGBScaledY then
    Exit;  // ja tem folga

  // 5. Whitespace acima disponivel — filtrado pela faixa X do QR
  intMaxYAcima := fMaxYAntes(AstrZPL, intPosFOQR,
                             intQRX, intQRX + intQRAltura);

  // 6. Y novo (original) tal que QR pos-escala termine antes do GB
  intYNovo := Round((intGBScaledY - intQRAltura - FOLGA_MIN_DOTS) / AfltFatorY);
  if intYNovo <= 0 then Exit;
  if intYNovo >= intQRY then Exit;         // seria mover pra baixo, nao ajuda
  if intYNovo <= intMaxYAcima then Exit;   // sem whitespace suficiente

  // 7. Reescreve o FO do QR
  Result := fReescreverFOY(AstrZPL, intPosFOQR, intYNovo);

  // 8. Remove linha separadora horizontal que atravesse a nova area do QR.
  // QR "footprint" em coord original = altura_pos_escala / fatorY.
  // Ex: 116 dots pos-escala com fatorY=0.495 = 234 dots em original.
  Result := fRemoverSeparadorSobArea(Result,
                                     intQRX, intQRX + intQRAltura,
                                     intYNovo,
                                     intYNovo + Round(intQRAltura / AfltFatorY));
end;

end.
