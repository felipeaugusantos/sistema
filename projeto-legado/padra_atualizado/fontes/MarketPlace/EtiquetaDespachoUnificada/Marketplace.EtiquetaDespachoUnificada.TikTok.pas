unit Marketplace.EtiquetaDespachoUnificada.TikTok;

// Processador de etiqueta unificada para TikTok Shop (prefixo TIKTOK_).
//
// TikTok entrega bitmap opaco unico via comando ZPL ^GFA (ASCII hex + RLE
// nativo Zebra). Dimensoes tipicas: 808 x 1127 pixels. Sem comandos ZPL
// nativos (^FO, ^FD, ^BC, ^BQ) - eh literalmente uma imagem monolitica.
// Isso impede remocao seletiva de blocos por comando; so por processamento
// pixel-level.
//
// Papel: 4x6" perfurado padrao do cliente (mesmo do ML e Shopee).
//
// Layout (metade/metade, mesma regra do ML e Shopee):
//   Y=0..600      TikTok comprimido (metade superior)
//   Y=610         Linha divisoria (centro do gap Y=600..620)
//   Y=620..1200   DANFE simplificada (580 dots)
//   ^LL = 1200 (4x6" @ 8dpmm)
//
// Desafio: o bitmap TikTok original (927 rows apos remover o Code128 chave
// NFe do rodape) nao cabe em 600 dots sem compressao vertical de 65% - o
// que quebra logos e areas solidas mesmo com NN bit-level (furos brancos em
// fundo preto e vice-versa devido a amostragem em rows nao-alinhadas).
//
// Solucao: compactar whitespace antes do resize. TCodecGFA.pCompactarWhitespace
// identifica linhas quase-brancas (gaps decorativos entre blocos) e consolida
// em max 6 linhas por sequencia. Preserva 100% do conteudo (nao mexe em
// barcodes, QR, texto, logos) - so apaga gap decorativo.
//
// Resultado tipico: 927 rows -> ~700 rows apos compact -> 600 rows apos NN
// = compressao final ~86% Y (identidade quase perfeita, sem furos).
//
// Fluxo:
//   1. Extrai ^GFA via TCodecGFA.fExtrairBitmap -> TBitmap 1bpp
//   2. Corta 200 linhas inferiores (Code128 chave NFe redundante)
//   3. TCodecGFA.pCompactarWhitespace -> remove gaps decorativos
//   4. TCodecGFA.pRedimensionarBitmapNN -> ~800x600 (NN bit-level suave)
//   5. TCodecZ64.fEmbutirBitmap -> re-emite como ~DGR:MKT.GRF Z64
//   6. DANFE renderizada pelo nfeimpressao (BMP colorido) via fEmbutirBitmap
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
  TProcessadorTikTok = class(TInterfacedObject, IProcessadorMarketplace)
  public
    function fProcessar(const AstrZPLOriginal: String;
                        const AstrPathBMPDanfe: String): String;
    function fPrecisaDanfe: Boolean;
  end;

implementation

const
  PAPEL_LARGURA     = 800;
  PAPEL_ALTURA      = 1200;    // 4x6" @ 8dpmm - padrao do cliente
  METADE_ALTURA     = 600;     // Metade superior = metade inferior = 600 dots
  DIVISOR_Y         = 610;     // Centro do gap Y=600..620
  DANFE_OFFSET_Y    = 620;     // Inicio da metade inferior
  DANFE_ALTURA_MAX  = 580;     // Tamanho do BMP DANFE (fr3 100x72mm)

  // Recorte inferior do bitmap original TikTok antes do resize.
  // O bitmap TikTok tem no rodape um Code128 de 44 digitos com a chave NFe
  // que ja aparece nitida na DANFE simplificada embaixo (redundante).
  // Valor empirico: TikTok tipico 1127px altura, barcode + margem ocupa ~200px.
  LINHAS_INFERIORES_A_CORTAR = 200;

  // Consolidacao de whitespace: sequencias de linhas quase-brancas
  // (gap entre blocos de conteudo) sao truncadas a este limite.
  // Preserva separacao visual mas remove espaco decorativo grande.
  // Empirico: 6 dots de gap ainda deixa visualmente respiravel.
  MAX_LINHAS_GAP = 6;

function TProcessadorTikTok.fProcessar(const AstrZPLOriginal: String;
                                        const AstrPathBMPDanfe: String): String;
var
  bmpTikTok, bmpDanfe: TBitmap;
  intBpl, intTb: Integer;
  intBpr, intAlturaCortada, intLinha: Integer;
  arrBytesTopo: TBytes;
  strBitmapEmbutido, strDanfeEmbed: String;
begin
  Result := '';
  bmpTikTok := TBitmap.Create;
  try
    if not TCodecGFA.fExtrairBitmap(AstrZPLOriginal, bmpTikTok, intBpl, intTb) then
      Exit;

    // Corte inferior: remove o Code128 chave NFe (redundante com DANFE embaixo).
    if bmpTikTok.Height > LINHAS_INFERIORES_A_CORTAR then
    begin
      intBpr := (bmpTikTok.Width + 7) div 8;
      intAlturaCortada := bmpTikTok.Height - LINHAS_INFERIORES_A_CORTAR;

      SetLength(arrBytesTopo, intBpr * intAlturaCortada);
      for intLinha := 0 to intAlturaCortada - 1 do
        Move(bmpTikTok.ScanLine[intLinha]^, arrBytesTopo[intLinha * intBpr], intBpr);

      bmpTikTok.Height := intAlturaCortada;

      for intLinha := 0 to intAlturaCortada - 1 do
        Move(arrBytesTopo[intLinha * intBpr], bmpTikTok.ScanLine[intLinha]^, intBpr);
    end;

    // Compacta whitespace vertical: gaps decorativos entre blocos viram
    // MAX_LINHAS_GAP linhas por sequencia. Reduz altura util sem tocar em
    // conteudo (barcodes, QR, texto, logos ficam intactos).
    TCodecGFA.pCompactarWhitespace(bmpTikTok, MAX_LINHAS_GAP);

    // Resize NN bit-level: apos compactar whitespace, a compressao final
    // fica suave (~86% Y ao inves de 65% do bitmap bruto). NN preserva
    // modulos de barcode/QR - critico com fatores fracionarios.
    TCodecGFA.pRedimensionarBitmapNN(bmpTikTok, PAPEL_LARGURA, METADE_ALTURA);

    strBitmapEmbutido := TCodecZ64.fEmbutirBitmap(bmpTikTok, 'MKT.GRF') + #13#10 +
                        '^FO0,0^XGR:MKT.GRF,1,1^FS';

    // Le BMP colorido renderizado pelo nfeimpressao e passa direto pro encoder.
    // TCodecZ64.fEmbutirBitmap detecta pf24bit/pf32bit e faz threshold interno via
    // ScanLine RGB - evita a conversao intermediaria pf1bit (paleta VCL nao-deterministica).
    strDanfeEmbed := '';
    If FileExists(AstrPathBMPDanfe) Then
    Begin
      bmpDanfe := TBitmap.Create;
      Try
        bmpDanfe.LoadFromFile(AstrPathBMPDanfe);
        strDanfeEmbed := TCodecZ64.fEmbutirBitmap(bmpDanfe, 'DANFE.GRF') + #13#10 +
                         Format('^FO0,%d^XGR:DANFE.GRF,1,1^FS', [DANFE_OFFSET_Y]);
      Finally
        FreeAndNil(bmpDanfe);
      End;
    End;

    If strDanfeEmbed = '' Then
      Exit; // Fallback silencioso

    Result := '^XA' + #13#10 +
              '^CI28' + #13#10 +
              Format('^PW%d', [PAPEL_LARGURA]) + #13#10 +
              Format('^LL%d', [PAPEL_ALTURA]) + #13#10 +
              strBitmapEmbutido + #13#10 +
              // Linha divisoria visual entre marketplace e DANFE (centro do gap).
              Format('^FO20,%d^GB760,0,2^FS', [DIVISOR_Y]) + #13#10 +
              strDanfeEmbed + #13#10 +
              '^XZ';
  finally
    FreeAndNil(bmpTikTok);
  end;
end;

function TProcessadorTikTok.fPrecisaDanfe: Boolean;
begin
  Result := True;
end;

function fCriarProcessadorTikTok: IProcessadorMarketplace;
begin
  Result := TProcessadorTikTok.Create;
end;

initialization
  TRegistroProcessadores.pRegistrar('TIKTOK_', fCriarProcessadorTikTok);

end.
