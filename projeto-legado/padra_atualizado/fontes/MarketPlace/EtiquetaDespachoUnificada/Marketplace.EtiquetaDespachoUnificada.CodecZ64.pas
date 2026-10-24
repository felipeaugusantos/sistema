unit Marketplace.EtiquetaDespachoUnificada.CodecZ64;

interface

uses
  System.SysUtils, System.Classes, System.ZLib, System.StrUtils, System.NetEncoding,
  Vcl.Graphics,
  IdCoderMIME;

type
  TCodecZ64 = class
    class function fExtrairBitmap(const AstrZPLTexto: String;
                                  var AbmpBitmap: TBitmap;
                                  var AintBytesPorLinha, AintTotalBytes: Integer): Boolean;
    class procedure pRedimensionar(AbmpBitmap: TBitmap;
                                   const AintLarguraDestino, AintAlturaDestino: Integer);
    class function fEmbutirBitmap(const AbmpBitmap: TBitmap;
                                  const AstrNomeGraphic: String = 'MKT.GRF'): String;
  end;

implementation

const
  // popcount pra nibble (4 bits) - usada em fEmbutirBitmap pra detectar
  // polaridade da paleta VCL via heuristica de densidade > 50%.
  arrPopCount: Array[0..15] Of Byte =
    (0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4);

function fCRC16CCITT(const ABytes: TBytes): Word;
var
  intI, intJ: Integer;
  dwCRC: Cardinal;
begin
  dwCRC := $0000;

  for intI := 0 to High(ABytes) do
  begin
    dwCRC := dwCRC xor (Cardinal(ABytes[intI]) shl 8);

    for intJ := 0 to 7 do
    begin
      if (dwCRC and $8000) <> 0 then
        dwCRC := (dwCRC shl 1) xor $1021
      else
        dwCRC := dwCRC shl 1;

      dwCRC := dwCRC and $FFFF;
    end;
  end;

  Result := Word(dwCRC);
end;

class function TCodecZ64.fExtrairBitmap(const AstrZPLTexto: String;
                                       var AbmpBitmap: TBitmap;
                                       var AintBytesPorLinha, AintTotalBytes: Integer): Boolean;
var
  intPosDGR, intPosZ64: Integer;
  intPosVirgula1, intPosVirgula2, intPosVirgula3: Integer;
  strCabecalho: String;
  intInicioPayload, intFimPayload: Integer;
  strPayload: String;
  strmComprimido, strmDescomprimido: TMemoryStream;
  strmInflate: TZDecompressionStream;
  arrBytesRaw: TBytes;
  intLarguraPixels, intAlturaPixels, intLinha: Integer;
  ptrLinhaBmp: PByte;
begin
  Result := False;
  AintBytesPorLinha := 0;
  AintTotalBytes := 0;

  intPosDGR := Pos('~DGR:', AstrZPLTexto);
  if intPosDGR = 0 then
    Exit;

  intPosZ64 := PosEx(':Z64:', AstrZPLTexto, intPosDGR);
  if intPosZ64 = 0 then
    Exit;

  strCabecalho := Copy(AstrZPLTexto, intPosDGR, intPosZ64 - intPosDGR);

  intPosVirgula1 := Pos(',', strCabecalho);
  if intPosVirgula1 = 0 then
    Exit;
  intPosVirgula2 := PosEx(',', strCabecalho, intPosVirgula1 + 1);
  if intPosVirgula2 = 0 then
    Exit;
  intPosVirgula3 := PosEx(',', strCabecalho, intPosVirgula2 + 1);
  if intPosVirgula3 = 0 then
    Exit;

  AintTotalBytes := StrToIntDef(
    Copy(strCabecalho, intPosVirgula1 + 1, intPosVirgula2 - intPosVirgula1 - 1), 0);
  AintBytesPorLinha := StrToIntDef(
    Copy(strCabecalho, intPosVirgula2 + 1, intPosVirgula3 - intPosVirgula2 - 1), 0);

  if (AintTotalBytes = 0) or (AintBytesPorLinha = 0) then
    Exit;

  intInicioPayload := intPosZ64 + Length(':Z64:');
  intFimPayload := PosEx(':', AstrZPLTexto, intInicioPayload);
  if intFimPayload = 0 then
    Exit;

  strPayload := Copy(AstrZPLTexto, intInicioPayload, intFimPayload - intInicioPayload);
  if strPayload = '' then
    Exit;

  // Try aninhado: se o segundo TMemoryStream.Create falhar (pressao de
  // memoria), o try externo garante liberacao do strmComprimido.
  strmComprimido := TMemoryStream.Create;
  try
    strmDescomprimido := TMemoryStream.Create;
    try
      TIdDecoderMIME.DecodeStream(strPayload, strmComprimido);
      strmComprimido.Position := 0;

      strmInflate := TZDecompressionStream.Create(strmComprimido);
      try
        strmDescomprimido.CopyFrom(strmInflate, 0);
      finally
        FreeAndNil(strmInflate);
      end;

      SetLength(arrBytesRaw, strmDescomprimido.Size);
      if strmDescomprimido.Size > 0 then
      begin
        strmDescomprimido.Position := 0;
        strmDescomprimido.ReadBuffer(arrBytesRaw[0], strmDescomprimido.Size);
      end;
    finally
      FreeAndNil(strmDescomprimido);
    end;
  finally
    FreeAndNil(strmComprimido);
  end;

  intLarguraPixels := AintBytesPorLinha * 8;
  intAlturaPixels := Length(arrBytesRaw) div AintBytesPorLinha;

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

class procedure TCodecZ64.pRedimensionar(AbmpBitmap: TBitmap;
                                          const AintLarguraDestino, AintAlturaDestino: Integer);
// Somente redimensiona (sem rotacao) — para bitmap que ja esta na
// orientacao correta (portrait). Faz 1bit -> 24bit -> StretchDraw -> 1bit.
var
  bmpTemp, bmpFinal: TBitmap;
  intLarguraOriginal, intAlturaOriginal: Integer;
begin
  intLarguraOriginal := AbmpBitmap.Width;
  intAlturaOriginal := AbmpBitmap.Height;
  if (intLarguraOriginal = 0) or (intAlturaOriginal = 0) then
    Exit;

  bmpTemp := TBitmap.Create;
  bmpFinal := TBitmap.Create;
  try
    // 1bit -> 24bit para permitir StretchDraw suave
    bmpTemp.PixelFormat := pf24bit;
    bmpTemp.Width := intLarguraOriginal;
    bmpTemp.Height := intAlturaOriginal;
    bmpTemp.Canvas.Draw(0, 0, AbmpBitmap);

    // Redimensiona pro destino
    bmpFinal.PixelFormat := pf24bit;
    bmpFinal.Width := AintLarguraDestino;
    bmpFinal.Height := AintAlturaDestino;
    bmpFinal.Canvas.StretchDraw(Rect(0, 0, AintLarguraDestino, AintAlturaDestino), bmpTemp);

    // Substitui bitmap de entrada, volta pra 1bit
    AbmpBitmap.PixelFormat := pf24bit;
    AbmpBitmap.Width := AintLarguraDestino;
    AbmpBitmap.Height := AintAlturaDestino;
    AbmpBitmap.Canvas.Draw(0, 0, bmpFinal);
    AbmpBitmap.PixelFormat := pf1bit;
    AbmpBitmap.Monochrome := True;
  finally
    FreeAndNil(bmpTemp);
    FreeAndNil(bmpFinal);
  end;
end;

class function TCodecZ64.fEmbutirBitmap(const AbmpBitmap: TBitmap;
                                        const AstrNomeGraphic: String): String;
var
  intBytesPorLinha, intTotalBytes, intLinha, intI: Integer;
  intX, intBytesPorPixel, intOffset, intLum: Integer;
  intByteIdx, intBitIdx: Integer;
  arrBytesRaw: TBytes;
  ptrLinhaBmp: PByte;
  strmDescomprimido, strmComprimido: TMemoryStream;
  strmDeflate: TZCompressionStream;
  arrPayloadBytes: TBytes;
  strBase64: String;
  arrBytesBase64: TBytes;
  wCRC: Word;
  intUns: Integer;
begin
  Result := '';
  if (AbmpBitmap.Width = 0) or (AbmpBitmap.Height = 0) then
    Exit;

  intBytesPorLinha := (AbmpBitmap.Width + 7) div 8;
  intTotalBytes := intBytesPorLinha * AbmpBitmap.Height;
  SetLength(arrBytesRaw, intTotalBytes);

  if (AbmpBitmap.PixelFormat = pf24bit) or (AbmpBitmap.PixelFormat = pf32bit) then
  begin
    // Caminho robusto para bitmap colorido: threshold via ScanLine RGB direto.
    // ScanLine retorna bytes crus em BGR (pf24bit) ou BGRA (pf32bit) —
    // interpretacao deterministica sem depender de paleta VCL.
    if AbmpBitmap.PixelFormat = pf24bit then
      intBytesPorPixel := 3
    else
      intBytesPorPixel := 4;

    for intLinha := 0 to AbmpBitmap.Height - 1 do
    begin
      ptrLinhaBmp := AbmpBitmap.ScanLine[intLinha];
      for intX := 0 to AbmpBitmap.Width - 1 do
      begin
        intOffset := intX * intBytesPorPixel;
        // ITU-R BT.601 luminance: 0.299*R + 0.587*G + 0.114*B
        // DIB storage order: [B, G, R, (A)]
        intLum := (PByte(NativeInt(ptrLinhaBmp) + intOffset + 2)^ * 299
                +  PByte(NativeInt(ptrLinhaBmp) + intOffset + 1)^ * 587
                +  PByte(NativeInt(ptrLinhaBmp) + intOffset    )^ * 114) div 1000;

        if intLum < 128 then
        begin
          intByteIdx := intLinha * intBytesPorLinha + (intX div 8);
          intBitIdx  := 7 - (intX mod 8);
          arrBytesRaw[intByteIdx] := arrBytesRaw[intByteIdx] or (1 shl intBitIdx);
        end;
      end;
    end;
  end
  else
  begin
    // Caminho legado para bitmap ja 1bpp (Shopee original extraido do Z64).
    // Copia bytes crus do ScanLine e detecta polaridade da paleta VCL via
    // heuristica de densidade > 50% (bitmaps de etiquetas tem fundo majoritariamente
    // branco - se maioria dos bits=1, esta invertido pra convencao ZPL).
    // Ver [[delphi-vcl-1bpp-palette-nondeterministic]].
    for intLinha := 0 to AbmpBitmap.Height - 1 do
    begin
      ptrLinhaBmp := AbmpBitmap.ScanLine[intLinha];
      Move(ptrLinhaBmp^, arrBytesRaw[intLinha * intBytesPorLinha], intBytesPorLinha);
    end;

    intUns := 0;
    for intI := 0 to High(arrBytesRaw) do
      intUns := intUns + arrPopCount[arrBytesRaw[intI] shr 4] + arrPopCount[arrBytesRaw[intI] and $0F];

    if intUns > (Length(arrBytesRaw) * 8) div 2 then
    begin
      for intI := 0 to High(arrBytesRaw) do
        arrBytesRaw[intI] := not arrBytesRaw[intI];
    end;
  end;

  // 2. Zlib deflate
  strmDescomprimido := TMemoryStream.Create;
  strmComprimido := TMemoryStream.Create;
  try
    strmDescomprimido.WriteBuffer(arrBytesRaw[0], intTotalBytes);
    strmDescomprimido.Position := 0;

    strmDeflate := TZCompressionStream.Create(strmComprimido);
    try
      strmDeflate.CopyFrom(strmDescomprimido, 0);
    finally
      FreeAndNil(strmDeflate);
    end;

    SetLength(arrPayloadBytes, strmComprimido.Size);
    if strmComprimido.Size > 0 then
    begin
      strmComprimido.Position := 0;
      strmComprimido.ReadBuffer(arrPayloadBytes[0], strmComprimido.Size);
    end;
  finally
    FreeAndNil(strmDescomprimido);
    FreeAndNil(strmComprimido);
  end;

  // 3. Base64 encode via TNetEncoding (RTL nativo, aceita TBytes direto)
  strBase64 := TNetEncoding.Base64.EncodeBytesToString(arrPayloadBytes);

  // 4. Remove quebras de linha que o MIME encoder pode inserir a cada 76 chars.
  // ZPL Z64 exige o payload em linha unica.
  strBase64 := StringReplace(strBase64, #13#10, '', [rfReplaceAll]);
  strBase64 := StringReplace(strBase64, #10, '', [rfReplaceAll]);
  strBase64 := StringReplace(strBase64, #13, '', [rfReplaceAll]);

  // 5. CRC-16-CCITT sobre o base64 (nao sobre os bytes raw ou comprimidos)
  SetLength(arrBytesBase64, Length(strBase64));
  for intI := 1 to Length(strBase64) do
    arrBytesBase64[intI - 1] := Byte(Ord(strBase64[intI]));
  wCRC := fCRC16CCITT(arrBytesBase64);

  // 6. Montar comando ~DGR completo
  Result := Format('~DGR:%s,%d,%d,:Z64:%s:%.4x',
                   [AstrNomeGraphic, intTotalBytes, intBytesPorLinha, strBase64, wCRC]);
end;

end.
