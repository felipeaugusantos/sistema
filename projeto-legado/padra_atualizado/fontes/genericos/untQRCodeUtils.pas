unit untQRCodeUtils;

interface

uses
  Graphics;

  function fGerarQRCode(strTexto: String): TBitmap;

implementation

uses
  frxDelphiZXingQRCode;

function fGerarQRCode(strTexto: String): TBitmap;
var
  QRCode: TDelphiZXingQRCode;
  Row, Column: Integer;
  color: TColor;

  PixelRow: Integer;
  PixelColumn: Integer;
Const
  SCALE = 3;
begin
  Result := TBitmap.Create;
  QRCode := TDelphiZXingQRCode.Create;
  try
    QRCode.Data := strTexto;
    QRCode.Encoding := qrAuto;
    QRCode.QuietZone := 0;
    Result.SetSize(QRCode.Rows*SCALE, QRCode.Columns*SCALE);

    for Row := 0 to QRCode.Rows - 1 do
    begin
      for Column := 0 to QRCode.Columns - 1 do
      begin
        if (QRCode.IsBlack[Row, Column]) then
          color := clBlack
        Else
          color := clWhite;

        For PixelColumn := 0 To SCALE-1 Do
        Begin
          For PixelRow := 0 To SCALE-1 Do
          Begin
            Result.Canvas.Pixels[Column*SCALE+PixelColumn, Row*SCALE+PixelRow] := color;
          End;
        End;

      end;
    end;
  finally
    QRCode.Free;
  end;

end;

end.
