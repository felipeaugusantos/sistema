unit Marketplace.EtiquetaDespachoUnificada.CodecGFA;

// Codec ZPL GFA (ASCII hex + RLE Zebra).
//
// GFA layout: ^GFA,<totalBytes>,<totalBytes>,<bytesPerRow>,<data>
// Data e sequencia de nibbles hex (0-9, A-F) com compressao RLE:
//   G-Y      = contagem 1..19 (G=1, H=2, ... Y=19)
//   g-z      = contagem 20..400 em passos de 20 (g=20, h=40, ... z=400)
//              Letras podem combinar: hM = 40 + 7 = 47 repeticoes
//   ,        = fim de linha, preenche resto com 0
//   !        = fim de linha, preenche resto com 1 (F)
//   :        = repete linha anterior
//
// Detalhe critico: linhas que se preenchem completamente pelos hex chars
// (sem ,/!/: explicito) AUTO-TERMINAM. O decoder detecta isso ao final de
// EmitirNibble e reseta os contadores. Sem esse tratamento, um ':' que vem
// apos linha auto-terminada copia lixo - bug silencioso em etiquetas com
// muitas linhas cheias seguidas de repeat (ex: TikTok Shop, ~617 repeats).
//
// Estrategia de resize: nearest-neighbor bit-level (sem TBitmap intermediario).
// Preserva contraste sem risco de dithering — apropriado para imagens 1bpp
// (logotipos, icones ML). Encoder emite hex puro (sem RLE) para simplicidade;
// Zebra aceita, arquivo apenas fica maior — irrelevante para etiqueta.

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics;

type
  TCodecGFA = class
  strict private
    class function fEhHex(const AchCaractere: Char): Boolean; static;
    class function fValorHex(const AchCaractere: Char): Byte; static;
    class function fDecodificarRLE(const AstrPayload: String;
                                   const AintBytesPorLinha, AintTotalBytes: Integer): TBytes; static;
    class function fRedimensionarBits(const AarrBytesOrigem: TBytes;
                                      const AintLarguraOrig, AintAlturaOrig,
                                            AintLarguraNova, AintAlturaNova: Integer): TBytes; static;
    class function fCodificarHex(const AarrBytes: TBytes): String; static;
  public
    // Localiza o primeiro ^GFA no ZPL, decodifica RLE e monta um TBitmap 1bpp.
    // Retorna False se nao houver ^GFA valido. Analogo a TCodecZ64.fExtrairBitmap.
    class function fExtrairBitmap(const AstrZPLTexto: String;
                                  var AbmpBitmap: TBitmap;
                                  var AintBytesPorLinha, AintTotalBytes: Integer): Boolean; static;

    // Redimensiona o payload de um ^GFA por fatores X/Y.
    // Retorna novo payload hex puro + parametros de saida (novo total, nova bpr).
    class function fRedimensionar(const AstrPayload: String;
                                  const AintTotalBytes, AintBytesPorLinha: Integer;
                                  const AfltFatorX, AfltFatorY: Double;
                                  out AintNovoTotal, AintNovaBytesPorLinha: Integer): String;

    // Redimensiona TBitmap 1bpp usando nearest-neighbor bit-level.
    // Diferente de TCodecZ64.pRedimensionar (que usa StretchDraw bilinear e
    // destroi barcodes/QR em compressao agressiva), aqui cada pixel destino
    // recebe o bit do pixel origem mais proximo. Preserva boundaries de
    // modulos (Code128, QR, Data Matrix). Uso ideal quando fator de escala eh
    // fracionario e o bitmap contem elementos micro-graficos escaneaveis.
    class procedure pRedimensionarBitmapNN(AbmpBitmap: TBitmap;
                                           const AintLarguraDestino,
                                                 AintAlturaDestino: Integer); static;

    // Compacta sequencias contiguas de linhas whitespace no bitmap 1bpp,
    // consolidando cada sequencia em no maximo AintMaxLinhasGap linhas.
    // Preserva 100% das linhas de conteudo - so remove espaco decorativo.
    //
    // Objetivo: reduzir a altura util antes do resize NN, tornando a
    // compressao final mais suave. Ex: bitmap 927x808 com ~230 linhas de
    // gaps -> compact -> 697x808 -> NN pra 600 = 86% Y (identidade quase
    // perfeita) ao inves de 927 -> 600 = 65% Y (destruicao de logos/texto).
    //
    // Whitespace = linha com menos de 1% dos bytes tendo pixel escuro.
    // AintMaxLinhasGap sugerido: 6 (mantem separacao visual entre blocos).
    class procedure pCompactarWhitespace(AbmpBitmap: TBitmap;
                                         const AintMaxLinhasGap: Integer); static;
  end;

implementation

uses
  System.StrUtils;

class function TCodecGFA.fEhHex(const AchCaractere: Char): Boolean;
begin
  Result := ((AchCaractere >= '0') and (AchCaractere <= '9')) or
            ((AchCaractere >= 'A') and (AchCaractere <= 'F')) or
            ((AchCaractere >= 'a') and (AchCaractere <= 'f'));
end;

class function TCodecGFA.fValorHex(const AchCaractere: Char): Byte;
begin
  if (AchCaractere >= '0') and (AchCaractere <= '9') then
    Result := Ord(AchCaractere) - Ord('0')
  else if (AchCaractere >= 'A') and (AchCaractere <= 'F') then
    Result := Ord(AchCaractere) - Ord('A') + 10
  else if (AchCaractere >= 'a') and (AchCaractere <= 'f') then
    Result := Ord(AchCaractere) - Ord('a') + 10
  else
    Result := 0;
end;

class function TCodecGFA.fDecodificarRLE(const AstrPayload: String;
                                         const AintBytesPorLinha, AintTotalBytes: Integer): TBytes;
var
  intI, intLen, intPending, intRepeticoes: Integer;
  chAtual: Char;
  intNibblesPorLinha, intNibbleAtual: Integer;
  bytAcumulador: Byte;
  blnAltaNibble: Boolean;
  arrLinhaAnterior: TBytes;
  intPosLinha, intPosSaida: Integer;

  procedure EmitirNibble(const AbytNibble: Byte);
  begin
    if blnAltaNibble then
    begin
      bytAcumulador := (AbytNibble and $0F) shl 4;
      blnAltaNibble := False;
    end
    else
    begin
      bytAcumulador := bytAcumulador or (AbytNibble and $0F);
      if intPosSaida < AintTotalBytes then
      begin
        Result[intPosSaida] := bytAcumulador;
        if intPosLinha < AintBytesPorLinha then
        begin
          arrLinhaAnterior[intPosLinha] := bytAcumulador;
          Inc(intPosLinha);
        end;
        Inc(intPosSaida);
      end;
      bytAcumulador := 0;
      blnAltaNibble := True;
    end;
    Inc(intNibbleAtual);
  end;

  // Auto-terminate: linha completou pelos hex chars sem ,/!/: explicito.
  // arrLinhaAnterior ja foi preenchida durante os emits desta linha - so
  // resetar os contadores para a proxima. Chamado APENAS pelo loop principal
  // apos emissao de hex chars. NAO chamar dentro de PreencherRestoLinhaCom
  // (resetar intNibbleAtual no meio do while dele geraria loop infinito).
  procedure VerificarAutoTerminate;
  begin
    if intNibbleAtual >= intNibblesPorLinha then
    begin
      intNibbleAtual := 0;
      intPosLinha := 0;
      blnAltaNibble := True;
      bytAcumulador := 0;
    end;
  end;

  procedure PreencherRestoLinhaCom(const AbytNibbleFill: Byte);
  begin
    while intNibbleAtual < intNibblesPorLinha do
      EmitirNibble(AbytNibbleFill);
    intNibbleAtual := 0;
    intPosLinha := 0;
    blnAltaNibble := True;
    bytAcumulador := 0;
  end;

  procedure RepetirLinhaAnterior;
  var intK: Integer;
  begin
    // Consolida qualquer nibble alto pendente antes de duplicar linha
    if not blnAltaNibble then
    begin
      // Nibble alto solto — completa com zero e emite
      EmitirNibble(0);
    end;
    for intK := 0 to AintBytesPorLinha - 1 do
    begin
      if intPosSaida < AintTotalBytes then
      begin
        Result[intPosSaida] := arrLinhaAnterior[intK];
        Inc(intPosSaida);
      end;
    end;
    intNibbleAtual := 0;
    intPosLinha := 0;
    blnAltaNibble := True;
    bytAcumulador := 0;
  end;

begin
  SetLength(Result, AintTotalBytes);
  SetLength(arrLinhaAnterior, AintBytesPorLinha);
  FillChar(arrLinhaAnterior[0], AintBytesPorLinha, 0);

  intLen := Length(AstrPayload);
  intNibblesPorLinha := AintBytesPorLinha * 2;
  intNibbleAtual := 0;
  intPosLinha := 0;
  intPosSaida := 0;
  intPending := 0;
  bytAcumulador := 0;
  blnAltaNibble := True;

  intI := 1;
  while intI <= intLen do
  begin
    chAtual := AstrPayload[intI];

    // Whitespace/quebras — ignorar
    if (chAtual = #13) or (chAtual = #10) or (chAtual = ' ') or (chAtual = #9) then
    begin
      Inc(intI);
      Continue;
    end;

    // ',' fim de linha, preenche resto com zero
    if chAtual = ',' then
    begin
      PreencherRestoLinhaCom(0);
      intPending := 0;
      Inc(intI);
      Continue;
    end;

    // '!' fim de linha, preenche resto com 1 (F)
    if chAtual = '!' then
    begin
      PreencherRestoLinhaCom($F);
      intPending := 0;
      Inc(intI);
      Continue;
    end;

    // ':' repete linha anterior
    if chAtual = ':' then
    begin
      RepetirLinhaAnterior;
      intPending := 0;
      Inc(intI);
      Continue;
    end;

    // Uppercase G-Y = contagem 1-19
    if (chAtual >= 'G') and (chAtual <= 'Y') then
    begin
      Inc(intPending, Ord(chAtual) - Ord('G') + 1);
      Inc(intI);
      Continue;
    end;

    // Lowercase g-z = contagem 20, 40, ... 400
    if (chAtual >= 'g') and (chAtual <= 'z') then
    begin
      Inc(intPending, (Ord(chAtual) - Ord('g') + 1) * 20);
      Inc(intI);
      Continue;
    end;

    // Hex literal (com contagem pendente ou 1)
    if fEhHex(chAtual) then
    begin
      if intPending = 0 then
        intRepeticoes := 1
      else
        intRepeticoes := intPending;

      while intRepeticoes > 0 do
      begin
        EmitirNibble(fValorHex(chAtual));
        VerificarAutoTerminate;
        Dec(intRepeticoes);
      end;
      intPending := 0;
      Inc(intI);
      Continue;
    end;

    // Caractere desconhecido — pular
    Inc(intI);
  end;
end;

class function TCodecGFA.fRedimensionarBits(const AarrBytesOrigem: TBytes;
                                            const AintLarguraOrig, AintAlturaOrig,
                                                  AintLarguraNova, AintAlturaNova: Integer): TBytes;
var
  intBprOrig, intBprNova: Integer;
  intX, intY, intSrcX, intSrcY: Integer;
  intSrcByteIdx, intSrcBitIdx: Integer;
  intDstByteIdx, intDstBitIdx: Integer;
  bytBitValor: Byte;
begin
  intBprOrig := (AintLarguraOrig + 7) div 8;
  intBprNova := (AintLarguraNova + 7) div 8;

  SetLength(Result, intBprNova * AintAlturaNova);
  // SetLength em TBytes zera bytes novos, entao nao precisa FillChar

  for intY := 0 to AintAlturaNova - 1 do
  begin
    // Nearest neighbor Y
    intSrcY := (intY * AintAlturaOrig) div AintAlturaNova;
    for intX := 0 to AintLarguraNova - 1 do
    begin
      // Nearest neighbor X
      intSrcX := (intX * AintLarguraOrig) div AintLarguraNova;

      // Le bit da imagem original (MSB = pixel esquerdo)
      intSrcByteIdx := intSrcY * intBprOrig + (intSrcX div 8);
      intSrcBitIdx := 7 - (intSrcX mod 8);
      if intSrcByteIdx < Length(AarrBytesOrigem) then
        bytBitValor := (AarrBytesOrigem[intSrcByteIdx] shr intSrcBitIdx) and 1
      else
        bytBitValor := 0;

      // Se bit setado, seta no destino
      if bytBitValor = 1 then
      begin
        intDstByteIdx := intY * intBprNova + (intX div 8);
        intDstBitIdx := 7 - (intX mod 8);
        Result[intDstByteIdx] := Result[intDstByteIdx] or (1 shl intDstBitIdx);
      end;
    end;
  end;
end;

class function TCodecGFA.fCodificarHex(const AarrBytes: TBytes): String;
const
  HEX_CHARS: array[0..15] of Char =
    ('0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F');
var
  intI: Integer;
  sbHex: TStringBuilder;
begin
  sbHex := TStringBuilder.Create(Length(AarrBytes) * 2);
  try
    for intI := 0 to Length(AarrBytes) - 1 do
    begin
      sbHex.Append(HEX_CHARS[(AarrBytes[intI] shr 4) and $F]);
      sbHex.Append(HEX_CHARS[AarrBytes[intI] and $F]);
    end;
    Result := sbHex.ToString;
  finally
    FreeAndNil(sbHex);
  end;
end;

class function TCodecGFA.fExtrairBitmap(const AstrZPLTexto: String;
                                        var AbmpBitmap: TBitmap;
                                        var AintBytesPorLinha, AintTotalBytes: Integer): Boolean;
var
  intPosGFA, intPosVirg1, intPosVirg2, intPosVirg3, intPosVirg4, intPosFS: Integer;
  strPayload: String;
  arrBytesRaw: TBytes;
  intLarguraPixels, intAlturaPixels, intLinha: Integer;
  ptrLinhaBmp: PByte;
begin
  Result := False;
  AintBytesPorLinha := 0;
  AintTotalBytes := 0;

  intPosGFA := Pos('^GFA,', AstrZPLTexto);
  if intPosGFA = 0 then
    Exit;

  // ^GFA,<compressedSize>,<totalBytes>,<bytesPerRow>,<data>^FS
  // A primeira virgula esta logo apos '^GFA' (posicao intPosGFA + 4).
  // compressedSize (entre virg1 e virg2) eh referencial - o RLE conhece o
  // total esperado via AintTotalBytes, entao ignoramos esse valor.
  intPosVirg1 := intPosGFA + 4;
  intPosVirg2 := PosEx(',', AstrZPLTexto, intPosVirg1 + 1);
  if intPosVirg2 = 0 then Exit;
  intPosVirg3 := PosEx(',', AstrZPLTexto, intPosVirg2 + 1);
  if intPosVirg3 = 0 then Exit;
  intPosVirg4 := PosEx(',', AstrZPLTexto, intPosVirg3 + 1);
  if intPosVirg4 = 0 then Exit;

  AintTotalBytes := StrToIntDef(
    Copy(AstrZPLTexto, intPosVirg2 + 1, intPosVirg3 - intPosVirg2 - 1), 0);
  AintBytesPorLinha := StrToIntDef(
    Copy(AstrZPLTexto, intPosVirg3 + 1, intPosVirg4 - intPosVirg3 - 1), 0);

  if (AintTotalBytes = 0) or (AintBytesPorLinha = 0) then
    Exit;

  intPosFS := PosEx('^FS', AstrZPLTexto, intPosVirg4 + 1);
  if intPosFS = 0 then
    Exit;

  strPayload := Copy(AstrZPLTexto, intPosVirg4 + 1, intPosFS - intPosVirg4 - 1);
  if strPayload = '' then
    Exit;

  arrBytesRaw := fDecodificarRLE(strPayload, AintBytesPorLinha, AintTotalBytes);

  intLarguraPixels := AintBytesPorLinha * 8;
  intAlturaPixels := AintTotalBytes div AintBytesPorLinha;

  if (intLarguraPixels = 0) or (intAlturaPixels = 0) then
    Exit;

  AbmpBitmap.PixelFormat := pf1bit;
  AbmpBitmap.Monochrome := True;
  AbmpBitmap.Width := intLarguraPixels;
  AbmpBitmap.Height := intAlturaPixels;

  for intLinha := 0 to intAlturaPixels - 1 do
  begin
    ptrLinhaBmp := AbmpBitmap.ScanLine[intLinha];
    Move(arrBytesRaw[intLinha * AintBytesPorLinha], ptrLinhaBmp^, AintBytesPorLinha);
  end;

  Result := True;
end;

class function TCodecGFA.fRedimensionar(const AstrPayload: String;
                                        const AintTotalBytes, AintBytesPorLinha: Integer;
                                        const AfltFatorX, AfltFatorY: Double;
                                        out AintNovoTotal, AintNovaBytesPorLinha: Integer): String;
var
  intLarguraOrig, intAlturaOrig, intLarguraNova, intAlturaNova: Integer;
  arrBytesDecoded, arrBytesRedim: TBytes;
begin
  intLarguraOrig := AintBytesPorLinha * 8;
  intAlturaOrig := AintTotalBytes div AintBytesPorLinha;
  intLarguraNova := Round(intLarguraOrig * AfltFatorX);
  intAlturaNova := Round(intAlturaOrig * AfltFatorY);

  // Piso — evita imagens degeneradas
  if intLarguraNova < 8 then intLarguraNova := 8;
  if intAlturaNova < 8 then intAlturaNova := 8;

  arrBytesDecoded := fDecodificarRLE(AstrPayload, AintBytesPorLinha, AintTotalBytes);
  arrBytesRedim := fRedimensionarBits(arrBytesDecoded,
                                      intLarguraOrig, intAlturaOrig,
                                      intLarguraNova, intAlturaNova);

  AintNovaBytesPorLinha := (intLarguraNova + 7) div 8;
  AintNovoTotal := Length(arrBytesRedim);
  Result := fCodificarHex(arrBytesRedim);
end;

class procedure TCodecGFA.pRedimensionarBitmapNN(AbmpBitmap: TBitmap;
                                                 const AintLarguraDestino,
                                                       AintAlturaDestino: Integer);
var
  intBprOrig, intBprNova, intLinha: Integer;
  intLarguraOrig, intAlturaOrig: Integer;
  arrBytesOrig, arrBytesNova: TBytes;
  ptrLinhaBmp: PByte;
begin
  // Fail-fast: (Width+7) div 8 assume 1bpp. Se receber pf24/pf32bit, o
  // Move sobre ScanLine copia bytes RGB como se fossem 1bpp e corrompe
  // o bitmap silenciosamente. Melhor levantar excecao aqui.
  if AbmpBitmap.PixelFormat <> pf1bit then
    raise Exception.Create('TCodecGFA.pRedimensionarBitmapNN: TBitmap deve estar em pf1bit');

  intLarguraOrig := AbmpBitmap.Width;
  intAlturaOrig  := AbmpBitmap.Height;
  if (intLarguraOrig = 0) or (intAlturaOrig = 0) then Exit;
  if (AintLarguraDestino <= 0) or (AintAlturaDestino <= 0) then Exit;

  intBprOrig := (intLarguraOrig + 7) div 8;
  intBprNova := (AintLarguraDestino + 7) div 8;

  // Snapshot dos scanlines originais em array contiguo
  SetLength(arrBytesOrig, intBprOrig * intAlturaOrig);
  for intLinha := 0 to intAlturaOrig - 1 do
    Move(AbmpBitmap.ScanLine[intLinha]^,
         arrBytesOrig[intLinha * intBprOrig], intBprOrig);

  // Nearest-neighbor bit-level preserva modulos de barcode/QR
  arrBytesNova := fRedimensionarBits(arrBytesOrig,
                                     intLarguraOrig, intAlturaOrig,
                                     AintLarguraDestino, AintAlturaDestino);

  // Reallocate o TBitmap com novas dimensoes e escreve os bytes de volta
  AbmpBitmap.PixelFormat := pf1bit;
  AbmpBitmap.Monochrome := True;
  AbmpBitmap.Width  := AintLarguraDestino;
  AbmpBitmap.Height := AintAlturaDestino;

  for intLinha := 0 to AintAlturaDestino - 1 do
  begin
    ptrLinhaBmp := AbmpBitmap.ScanLine[intLinha];
    Move(arrBytesNova[intLinha * intBprNova], ptrLinhaBmp^, intBprNova);
  end;
end;

class procedure TCodecGFA.pCompactarWhitespace(AbmpBitmap: TBitmap;
                                               const AintMaxLinhasGap: Integer);
var
  intBpr, intAltura, intY, intI, intBytesEscuros: Integer;
  intGapCount, intNovaAltura, intLinhaDest, intLimiarBytes: Integer;
  arrBytesOrig, arrBytesNova: TBytes;
  arrManter: TArray<Boolean>;
  ptrLinha: PByte;
  blnEhBranco: Boolean;
begin
  // Fail-fast: (Width+7) div 8 assume 1bpp. Ver comentario em
  // pRedimensionarBitmapNN.
  if AbmpBitmap.PixelFormat <> pf1bit then
    raise Exception.Create('TCodecGFA.pCompactarWhitespace: TBitmap deve estar em pf1bit');

  intAltura := AbmpBitmap.Height;
  if (intAltura = 0) or (AintMaxLinhasGap < 0) then Exit;

  intBpr := (AbmpBitmap.Width + 7) div 8;

  // Snapshot dos scanlines em array contiguo
  SetLength(arrBytesOrig, intBpr * intAltura);
  for intY := 0 to intAltura - 1 do
    Move(AbmpBitmap.ScanLine[intY]^,
         arrBytesOrig[intY * intBpr], intBpr);

  // Limiar de bytes com pixel escuro para considerar linha "whitespace".
  // <1% dos bytes com pelo menos 1 bit setado.
  intLimiarBytes := intBpr div 100;
  if intLimiarBytes < 1 then intLimiarBytes := 1;

  // Marca linhas a manter usando gap counting
  SetLength(arrManter, intAltura);
  intGapCount := 0;
  for intY := 0 to intAltura - 1 do
  begin
    intBytesEscuros := 0;
    ptrLinha := @arrBytesOrig[intY * intBpr];
    for intI := 0 to intBpr - 1 do
      if PByte(NativeInt(ptrLinha) + intI)^ <> 0 then
        Inc(intBytesEscuros);

    blnEhBranco := intBytesEscuros < intLimiarBytes;

    if blnEhBranco then
    begin
      Inc(intGapCount);
      arrManter[intY] := intGapCount <= AintMaxLinhasGap;
    end
    else
    begin
      intGapCount := 0;
      arrManter[intY] := True;
    end;
  end;

  intNovaAltura := 0;
  for intY := 0 to intAltura - 1 do
    if arrManter[intY] then Inc(intNovaAltura);

  if intNovaAltura = intAltura then Exit; // Nada compactou

  // Compila destino
  SetLength(arrBytesNova, intBpr * intNovaAltura);
  intLinhaDest := 0;
  for intY := 0 to intAltura - 1 do
    if arrManter[intY] then
    begin
      Move(arrBytesOrig[intY * intBpr],
           arrBytesNova[intLinhaDest * intBpr], intBpr);
      Inc(intLinhaDest);
    end;

  AbmpBitmap.PixelFormat := pf1bit;
  AbmpBitmap.Monochrome := True;
  AbmpBitmap.Height := intNovaAltura;

  for intY := 0 to intNovaAltura - 1 do
    Move(arrBytesNova[intY * intBpr],
         AbmpBitmap.ScanLine[intY]^, intBpr);
end;

end.
