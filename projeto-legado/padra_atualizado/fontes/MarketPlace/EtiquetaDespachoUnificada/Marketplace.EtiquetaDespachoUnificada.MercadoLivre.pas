unit Marketplace.EtiquetaDespachoUnificada.MercadoLivre;

// Processador de etiqueta unificada para Mercado Livre (prefixo MLB_).
//
// Fluxo:
//   1. Remover envoltorio ^XA/^XZ
//   2. Realocar QR via whitespace detection (evita colisao com quadro "R")
//   3. Escalonar coordenadas + elementos com pisos ML-especificos
//   4. Gerar DANFE simplificada e posicionar na metade inferior
//   5. Montar ZPL final
//
// Layout (papel 4x6" @ 8dpmm = 800x1200):
//   Y=0..600   Mercado Livre (comprimido 812x1211 -> fatorY=0.495)
//   Y=620..1200 DANFE simplificada (580 dots)
//
// Pisos de legibilidade ML:
//   Fonte normal: 14 dots
//   Fonte ^FR (reverse — usado no "Despachar" e no quadro "R"): 18 dots
//   ^BC (Code128 shipment): 80 dots
//   ^BQ magnif (QR receiver): 4

interface

uses
  System.SysUtils,
  Vcl.Graphics,
  Marketplace.EtiquetaDespachoUnificada.IProcessador,
  Marketplace.EtiquetaDespachoUnificada.ParserZPL,
  Marketplace.EtiquetaDespachoUnificada.CompactadorLayout,
  Marketplace.EtiquetaDespachoUnificada.CodecZ64;

type
  TProcessadorMercadoLivre = class(TInterfacedObject, IProcessadorMarketplace)
  public
    function fProcessar(const AstrZPLOriginal: String;
                        const AstrPathBMPDanfe: String): String;
    function fPrecisaDanfe: Boolean;
  end;

implementation

const
  PAPEL_LARGURA         = 800;
  PAPEL_ALTURA          = 1200;
  ML_LARGURA_ORIGINAL   = 812;
  ML_ALTURA_ORIGINAL    = 1211;
  ML_ALTURA_MAX         = 600;
  DANFE_OFFSET_Y        = 620;
  DANFE_ALTURA_MAX      = 580;

function fCriarPisosML: TConfigPisos;
begin
  Result.intPisoFont         := 14;
  Result.intPisoFontReverse  := 18;
  Result.intPisoBarcode      := 80;
  Result.intPisoQRMagnif     := 4;
end;

function TProcessadorMercadoLivre.fProcessar(const AstrZPLOriginal: String;
                                              const AstrPathBMPDanfe: String): String;
var
  strLimpo, strCompactado, strEscalado, strDanfeEmbed: String;
  fltFatorX, fltFatorY: Double;
  recPisos: TConfigPisos;
  bmpDanfe: TBitmap;
begin
  Result := '';

  strLimpo := TParserZPL.fRemoverEnvoltorio(AstrZPLOriginal);

  fltFatorX := PAPEL_LARGURA / ML_LARGURA_ORIGINAL;
  fltFatorY := ML_ALTURA_MAX / ML_ALTURA_ORIGINAL;

  strCompactado := TCompactadorLayout.fRealocarPorWhitespace(strLimpo, fltFatorY);

  recPisos := fCriarPisosML;

  strEscalado := TParserZPL.fReescalarCoordenadas(
    strCompactado, fltFatorX, fltFatorY, 0, 0, recPisos);

  // Le BMP colorido renderizado pelo nfeimpressao e passa direto pro encoder.
  // TCodecZ64.fEmbutirBitmap detecta pf24bit/pf32bit e faz threshold interno via
  // ScanLine RGB - evita a conversao intermediaria pf1bit (que tinha problema
  // de paleta VCL nao-deterministica).
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
    Exit; // Fallback silencioso -- orquestrador retorna path original

  Result := '^XA' + #13#10 +
            '^CI28' + #13#10 +
            Format('^PW%d', [PAPEL_LARGURA]) + #13#10 +
            Format('^LL%d', [PAPEL_ALTURA]) + #13#10 +
            strEscalado + #13#10 +
            // Linha divisoria visual entre marketplace e DANFE (Y=610,
            // centro do gap Y=600..620). Puramente estetica.
            '^FO20,610^GB760,0,2^FS' + #13#10 +
            strDanfeEmbed + #13#10 +
            '^XZ';
end;

function TProcessadorMercadoLivre.fPrecisaDanfe: Boolean;
begin
  Result := True;
end;

function fCriarProcessadorML: IProcessadorMarketplace;
begin
  Result := TProcessadorMercadoLivre.Create;
end;

initialization
  TRegistroProcessadores.pRegistrar('MLB_', fCriarProcessadorML);

end.
