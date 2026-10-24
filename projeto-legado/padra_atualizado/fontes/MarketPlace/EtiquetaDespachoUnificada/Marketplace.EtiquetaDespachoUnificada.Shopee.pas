unit Marketplace.EtiquetaDespachoUnificada.Shopee;

// Processador de etiqueta unificada para Shopee (prefixo SHP_).
//
// A Shopee tem mais de um formato de etiqueta em circulacao e nao avisa quando
// troca. Dois foram vistos ate agora:
//
//   RETRATO   ~DGR:...:Z64:  816x1218   DANFE simplificada embutida no rodape
//   PAISAGEM  ^GFA           1680x1187  folha A5 com a etiqueta do carrier a
//                                       esquerda e uma DANFE simplificada
//                                       completa na coluna da direita
//
// Nos dois casos o problema e o mesmo: a DANFE que a Shopee embute fica
// ilegivel depois da compressao e ainda ocupa espaco, enquanto a nossa DANFE
// nitida sai logo abaixo - redundante. A solucao tambem e a mesma: recortar a
// parte redundante, compactar whitespace vertical e redimensionar via NN
// bit-level, preservando barcodes/QR/texto do marketplace.
//
// A variante e decidida pela CODIFICACAO, nao pela dimensao: e o sinal mais
// barato e nao depende de medida nenhuma. Tenta Z64, depois GFA; se nenhum dos
// dois decodificar, devolve vazio e o orquestrador cai no fluxo original.
//
// O recorte da variante paisagem e por CONTEUDO, nao por constante. A Shopee ja
// mudou o layout uma vez; medida gravada no fonte envelhece na proxima. Cada
// regra de recorte degrada para "nao corta" quando nao encontra o que procura -
// errar para menos deixa a etiqueta feia, errar para mais decepa informacao.
//
// Papel: 4x6" perfurado padrao do cliente, nas duas variantes.
//
// Layout de saida:
//   Y=0..600      Bitmap Shopee recortado e comprimido
//   Y=610         Linha divisoria (centro do gap Y=600..620)
//   Y=620..1200   DANFE simplificada gerada pelo nosso sistema
//   ^LL = 1200 (4x6" @ 8dpmm)
//
// fPrecisaDanfe = True: o orquestrador dispara pGerarBMP no nfeimpressao.

interface

uses
  System.SysUtils,
  Vcl.Graphics,
  Marketplace.EtiquetaDespachoUnificada.IProcessador,
  Marketplace.EtiquetaDespachoUnificada.CodecGFA,
  Marketplace.EtiquetaDespachoUnificada.CodecZ64;

type
  TProcessadorShopee = class(TInterfacedObject, IProcessadorMarketplace)
  strict private
    // Mantem o retangulo superior-esquerdo. A largura e arredondada para baixo
    // no byte, entao nenhum pixel da regiao descartada sobrevive no ultimo byte
    // da linha e o recorte dispensa deslocamento de bits.
    class procedure pRecortar(AbmpBitmap: TBitmap;
                              const AintLargura, AintAltura: Integer); static;

    // Coluna da borda vertical que separa a etiqueta do carrier da DANFE que a
    // Shopee imprime ao lado. Zero quando nao ha borda com esse perfil.
    class function fColunaBordaDanfe(AbmpBitmap: TBitmap): Integer; static;

    // Primeira linha da regua horizontal mais baixa da etiqueta - fronteira do
    // bloco "DANFE SIMPLIFICADO - ETIQUETA". Zero quando nao ha regua.
    class function fLinhaReguaRodape(AbmpBitmap: TBitmap): Integer; static;

    class procedure pRecortarVarianteRetrato(AbmpBitmap: TBitmap); static;
    class procedure pRecortarVariantePaisagem(AbmpBitmap: TBitmap); static;

    // Vazio quando o BMP da DANFE nao esta la - o chamador trata como falha.
    class function fMontarZPL(AbmpMarketplace: TBitmap;
                              const AstrPathBMPDanfe: String): String; static;
  public
    function fProcessar(const AstrZPLOriginal: String;
                        const AstrPathBMPDanfe: String): String;
    function fPrecisaDanfe: Boolean;
  end;

implementation

const
  PAPEL_LARGURA    = 800;
  PAPEL_ALTURA     = 1200;    // 4x6" @ 8dpmm - padrao do cliente
  METADE_ALTURA    = 600;     // Metade superior = metade inferior
  DIVISOR_Y        = 610;     // Centro do gap Y=600..620
  DANFE_OFFSET_Y   = 620;

  // Consolidacao de whitespace: gaps entre blocos viram max N linhas.
  MAX_LINHAS_GAP = 6;

  // --- Variante retrato (~DGR Z64) -----------------------------------------
  // Recorte inferior do bitmap Shopee original antes do resize.
  // Empirico via analise pixel-level (amostra 260717TY1PABDW 816x1218):
  //   Y=1006-1008: linha separadora grossa (812 pixels contiguos)
  //   Y=1014-1200: bloco "DANFE SIMPLIFICADO - ETIQUETA" + chave em texto
  //                + Code128 chave NFe grande - todos redundantes com a
  //                DANFE nitida que sai embaixo na etiqueta unificada.
  // Cortar 212 linhas remove tudo isso limpo, preservando REMETENTE + CEP +
  // Envio previsto (que sao informacoes uteis pro carrier e nao estao na DANFE).
  LINHAS_INFERIORES_A_CORTAR = 212;

  // --- Variante paisagem (^GFA A5) -----------------------------------------
  // Limiares da deteccao por conteudo. Calibrados na amostra 260925044E7E6P
  // (1680x1187), mas com folga deliberada - sao fracoes da dimensao, nao
  // posicoes, entao sobrevivem a mudanca de resolucao da folha.
  //
  // A borda da caixa da DANFE e um traco vertical continuo de 588 px (49% da
  // altura). O traco vertical mais longo da coluna da etiqueta e a caixa preta
  // do codigo de rota, com 129 px (11%). O limiar de 40% fica no meio de uma
  // separacao de 4,5x entre sinal e ruido.
  FRACAO_INICIO_BUSCA_BORDA = 0.40;  // so procura borda depois de 40% da largura
  FRACAO_RUN_VERTICAL_BORDA = 0.40;  // traco continuo >= 40% da altura

  // A regua do rodape ocupa a largura inteira da coluna da etiqueta; o bloco
  // de DANFE abaixo dela nao chega perto disso em nenhuma linha.
  FRACAO_INICIO_BUSCA_REGUA = 0.66;  // so procura regua no terco inferior
  FRACAO_LARGURA_REGUA      = 0.95;  // >= 95% da largura com pixel escuro

// Copia os bytes uteis de cada scanline para um buffer contiguo. O scanline de
// um DIB tem padding de 4 bytes que nao interessa aqui - o resto do codec
// trabalha com (largura + 7) div 8 e a copia mantem a mesma convencao.
procedure pSnapshotBitmap(AbmpBitmap: TBitmap; out AarrBytes: TBytes;
                          out AintBytesPorLinha: Integer);
var
  intLinha: Integer;
begin
  AintBytesPorLinha := (AbmpBitmap.Width + 7) div 8;
  SetLength(AarrBytes, AintBytesPorLinha * AbmpBitmap.Height);

  for intLinha := 0 to AbmpBitmap.Height - 1 do
    Move(AbmpBitmap.ScanLine[intLinha]^,
         AarrBytes[intLinha * AintBytesPorLinha], AintBytesPorLinha);
end;

// Bit setado = pixel escuro. E a convencao que atravessa o pipeline inteiro: o
// ZPL usa 1 = preto e os codecs movem os bytes crus pro scanline sem inverter.
// A polaridade da paleta VCL so entra em jogo na gravacao, dentro de
// TCodecZ64.fEmbutirBitmap.
function fBitEscuro(const AarrBytes: TBytes;
                    const AintBytesPorLinha, AintX, AintY: Integer): Boolean;
begin
  Result := (AarrBytes[AintY * AintBytesPorLinha + (AintX shr 3)]
             and ($80 shr (AintX and 7))) <> 0;
end;

class procedure TProcessadorShopee.pRecortar(AbmpBitmap: TBitmap;
                                             const AintLargura, AintAltura: Integer);
var
  intBytesPorLinhaNovo, intLarguraNova, intAlturaNova, intLinha: Integer;
  arrBytes: TBytes;
begin
  intLarguraNova := AintLargura;
  if intLarguraNova > AbmpBitmap.Width then
    intLarguraNova := AbmpBitmap.Width;

  intAlturaNova := AintAltura;
  if intAlturaNova > AbmpBitmap.Height then
    intAlturaNova := AbmpBitmap.Height;

  if (intLarguraNova <= 0) or (intAlturaNova <= 0) then
    Exit;

  intBytesPorLinhaNovo := intLarguraNova div 8;
  if intBytesPorLinhaNovo < 1 then
    Exit;
  intLarguraNova := intBytesPorLinhaNovo * 8;

  if (intLarguraNova = AbmpBitmap.Width) and (intAlturaNova = AbmpBitmap.Height) then
    Exit;

  SetLength(arrBytes, intBytesPorLinhaNovo * intAlturaNova);
  for intLinha := 0 to intAlturaNova - 1 do
    Move(AbmpBitmap.ScanLine[intLinha]^,
         arrBytes[intLinha * intBytesPorLinhaNovo], intBytesPorLinhaNovo);

  AbmpBitmap.PixelFormat := pf1bit;
  AbmpBitmap.Monochrome  := True;
  AbmpBitmap.Width       := intLarguraNova;
  AbmpBitmap.Height      := intAlturaNova;

  for intLinha := 0 to intAlturaNova - 1 do
    Move(arrBytes[intLinha * intBytesPorLinhaNovo],
         AbmpBitmap.ScanLine[intLinha]^, intBytesPorLinhaNovo);
end;

class function TProcessadorShopee.fColunaBordaDanfe(AbmpBitmap: TBitmap): Integer;
var
  arrBytes: TBytes;
  intBytesPorLinha, intLargura, intAltura: Integer;
  intX, intY, intRun, intRunMaximo, intXInicial, intRunMinimo: Integer;
begin
  Result := 0;

  intLargura := AbmpBitmap.Width;
  intAltura  := AbmpBitmap.Height;
  if (intLargura = 0) or (intAltura = 0) then
    Exit;

  intRunMinimo := Trunc(intAltura * FRACAO_RUN_VERTICAL_BORDA);
  if intRunMinimo < 1 then
    Exit;

  pSnapshotBitmap(AbmpBitmap, arrBytes, intBytesPorLinha);

  intXInicial := Trunc(intLargura * FRACAO_INICIO_BUSCA_BORDA);

  for intX := intXInicial to intLargura - 1 do
  begin
    intRun := 0;
    intRunMaximo := 0;

    for intY := 0 to intAltura - 1 do
      if fBitEscuro(arrBytes, intBytesPorLinha, intX, intY) then
      begin
        Inc(intRun);
        if intRun > intRunMaximo then
          intRunMaximo := intRun;
      end
      else
        intRun := 0;

    if intRunMaximo >= intRunMinimo then
      Exit(intX);
  end;
end;

class function TProcessadorShopee.fLinhaReguaRodape(AbmpBitmap: TBitmap): Integer;
var
  arrBytes: TBytes;
  intBytesPorLinha, intLargura, intAltura: Integer;
  intY, intYMinimo, intEscurosMinimo: Integer;

  function fEhRegua(const AintLinha: Integer): Boolean;
  var
    intX, intEscuros: Integer;
  begin
    intEscuros := 0;
    for intX := 0 to intLargura - 1 do
      if fBitEscuro(arrBytes, intBytesPorLinha, intX, AintLinha) then
        Inc(intEscuros);
    Result := intEscuros >= intEscurosMinimo;
  end;

begin
  Result := 0;

  intLargura := AbmpBitmap.Width;
  intAltura  := AbmpBitmap.Height;
  if (intLargura = 0) or (intAltura = 0) then
    Exit;

  pSnapshotBitmap(AbmpBitmap, arrBytes, intBytesPorLinha);

  intYMinimo       := Trunc(intAltura * FRACAO_INICIO_BUSCA_REGUA);
  intEscurosMinimo := Trunc(intLargura * FRACAO_LARGURA_REGUA);

  intY := intAltura - 1;
  while (intY >= intYMinimo) and (not fEhRegua(intY)) do
    Dec(intY);

  if intY < intYMinimo then
    Exit;

  // Sobe ate o topo do grupo: a regua tem varias linhas de espessura e o corte
  // tem de cair acima de todas elas, senao sobra um risco preto no rodape.
  while (intY > 0) and fEhRegua(intY - 1) do
    Dec(intY);

  Result := intY;
end;

class procedure TProcessadorShopee.pRecortarVarianteRetrato(AbmpBitmap: TBitmap);
begin
  // Largura intocada. O Z64 sempre devolve largura multipla de 8 (e
  // bytesPerRow * 8), entao o arredondamento de pRecortar nao tira nada.
  if AbmpBitmap.Height > LINHAS_INFERIORES_A_CORTAR then
    pRecortar(AbmpBitmap, AbmpBitmap.Width,
              AbmpBitmap.Height - LINHAS_INFERIORES_A_CORTAR);
end;

class procedure TProcessadorShopee.pRecortarVariantePaisagem(AbmpBitmap: TBitmap);
var
  intColunaBorda, intLinhaRegua: Integer;
begin
  // Ordem importa. A regua do rodape tem a largura da coluna da etiqueta, nao
  // a da folha inteira: medida antes do recorte lateral ela fica em 49% da
  // largura, nao alcanca o limiar de 95% e passaria despercebida.
  intColunaBorda := fColunaBordaDanfe(AbmpBitmap);
  if intColunaBorda > 0 then
    pRecortar(AbmpBitmap, intColunaBorda, AbmpBitmap.Height);

  intLinhaRegua := fLinhaReguaRodape(AbmpBitmap);
  if intLinhaRegua > 0 then
    pRecortar(AbmpBitmap, AbmpBitmap.Width, intLinhaRegua);
end;

class function TProcessadorShopee.fMontarZPL(AbmpMarketplace: TBitmap;
                                             const AstrPathBMPDanfe: String): String;
var
  bmpDanfe: TBitmap;
  strBitmapEmbutido, strDanfeEmbed: String;
begin
  Result := '';

  if not FileExists(AstrPathBMPDanfe) then
    Exit;

  strBitmapEmbutido := TCodecZ64.fEmbutirBitmap(AbmpMarketplace, 'MKT.GRF') + #13#10 +
                       '^FO0,0^XGR:MKT.GRF,1,1^FS';

  // Le BMP colorido renderizado pelo nfeimpressao e passa direto pro encoder.
  // TCodecZ64.fEmbutirBitmap detecta pf24bit/pf32bit e faz threshold interno via
  // ScanLine RGB - evita a conversao intermediaria pf1bit (paleta VCL nao-deterministica).
  bmpDanfe := TBitmap.Create;
  try
    bmpDanfe.LoadFromFile(AstrPathBMPDanfe);
    strDanfeEmbed := TCodecZ64.fEmbutirBitmap(bmpDanfe, 'DANFE.GRF') + #13#10 +
                     Format('^FO0,%d^XGR:DANFE.GRF,1,1^FS', [DANFE_OFFSET_Y]);
  finally
    FreeAndNil(bmpDanfe);
  end;

  if strDanfeEmbed = '' then
    Exit;

  Result := '^XA' + #13#10 +
            '^CI28' + #13#10 +
            Format('^PW%d', [PAPEL_LARGURA]) + #13#10 +
            Format('^LL%d', [PAPEL_ALTURA]) + #13#10 +
            strBitmapEmbutido + #13#10 +
            // Linha divisoria visual entre marketplace e DANFE (centro do gap).
            Format('^FO20,%d^GB760,0,2^FS', [DIVISOR_Y]) + #13#10 +
            strDanfeEmbed + #13#10 +
            '^XZ';
end;

function TProcessadorShopee.fProcessar(const AstrZPLOriginal: String;
                                        const AstrPathBMPDanfe: String): String;
var
  bmpShopee: TBitmap;
  intBpl, intTb: Integer;
begin
  Result := '';

  bmpShopee := TBitmap.Create;
  try
    // Os dois extratores saem antes de tocar no bitmap quando nao reconhecem o
    // formato, entao a segunda tentativa recebe o objeto intacto.
    if TCodecZ64.fExtrairBitmap(AstrZPLOriginal, bmpShopee, intBpl, intTb) then
      pRecortarVarianteRetrato(bmpShopee)

    else if TCodecGFA.fExtrairBitmap(AstrZPLOriginal, bmpShopee, intBpl, intTb) then
    begin
      // O recorte lateral so faz sentido na folha A5 em que a Shopee imprime
      // etiqueta e DANFE lado a lado. ^GFA em retrato e um terceiro layout que
      // ainda nao vimos - segue sem recorte, que e o comportamento seguro.
      if bmpShopee.Width > bmpShopee.Height then
        pRecortarVariantePaisagem(bmpShopee);
    end

    else
      Exit;

    TCodecGFA.pCompactarWhitespace(bmpShopee, MAX_LINHAS_GAP);

    // Resize NN bit-level: preserva modulos de barcode/QR mesmo com fator
    // fracionario. Substitui o antigo StretchDraw bilinear do CodecZ64 que
    // distorcia barcodes verticais e QR em compressoes agressivas.
    TCodecGFA.pRedimensionarBitmapNN(bmpShopee, PAPEL_LARGURA, METADE_ALTURA);

    Result := fMontarZPL(bmpShopee, AstrPathBMPDanfe);
  finally
    FreeAndNil(bmpShopee);
  end;
end;

function TProcessadorShopee.fPrecisaDanfe: Boolean;
begin
  Result := True;
end;

function fCriarProcessadorShopee: IProcessadorMarketplace;
begin
  Result := TProcessadorShopee.Create;
end;

initialization
  TRegistroProcessadores.pRegistrar('SHP_', fCriarProcessadorShopee);

end.
