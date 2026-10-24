unit XLSColors;

interface

uses
  System.SysUtils, System.Classes, System.Math, Vcl.Graphics,
  System.Generics.Collections, System.UITypes;

type
  TXLSColor = record
    R, G, B: Byte;

    constructor Create(AR, AG, AB: Byte); overload;
    constructor Create(AColor: TColor); overload;
    constructor Create(const HexColor: string); overload;

    function ToHex: string;
    function ToTColor: TColor;
    function ToString: string;

    class function FromTColor(AColor: TColor): TXLSColor; static;
    class function FromHex(const HexColor: string): TXLSColor; static;
    class function FromRGB(R, G, B: Byte): TXLSColor; static;
    class function FromWebColor(const WebColorName: string): TXLSColor; static;

    // Operadores
    class operator Equal(A, B: TXLSColor): Boolean;
    class operator NotEqual(A, B: TXLSColor): Boolean;
    class operator Implicit(AColor: TColor): TXLSColor;
    class operator Implicit(AColor: TXLSColor): TColor;
  end;

  // Arrays de cores
  TXLSColorArray = array of TXLSColor;
  TColorArray = array of TColor;

// Funções de criação de cores
function XLSColor(R, G, B: Byte): TXLSColor; overload;
function XLSColor(AColor: TColor): TXLSColor; overload;
function XLSColor(const HexColor: string): TXLSColor; overload;

// Funções de transformação
function XLSLighten(AColor: TXLSColor; Percent: Integer): TXLSColor; overload;
function XLSLighten(AColor: TColor; Percent: Integer): TColor; overload;

function XLSDarken(AColor: TXLSColor; Percent: Integer): TXLSColor; overload;
function XLSDarken(AColor: TColor; Percent: Integer): TColor; overload;

function XLSAdjustBrightness(AColor: TXLSColor; Delta: Integer): TXLSColor; overload;
function XLSAdjustBrightness(AColor: TColor; Delta: Integer): TColor; overload;

function XLSGradient(Color1, Color2: TXLSColor; Percent: Integer): TXLSColor; overload;
function XLSGradient(Color1, Color2: TColor; Percent: Integer): TColor; overload;

function XLSComplementary(AColor: TXLSColor): TXLSColor; overload;
function XLSComplementary(AColor: TColor): TColor; overload;

function XLSAnalogous(AColor: TXLSColor; Angle: Integer = 30): TXLSColorArray; overload;
function XLSAnalogous(AColor: TColor; Angle: Integer = 30): TColorArray; overload;

function XLSTriad(AColor: TXLSColor): TXLSColorArray; overload;
function XLSTriad(AColor: TColor): TColorArray; overload;

// Funções de utilidade
function XLSGetContrastTextColor(BgColor: TXLSColor): TXLSColor; overload;
function XLSGetContrastTextColor(BgColor: TColor): TColor; overload;

function XLSHasGoodContrast(Color1, Color2: TXLSColor; MinRatio: Double = 4.5): Boolean; overload;
function XLSHasGoodContrast(Color1, Color2: TColor; MinRatio: Double = 4.5): Boolean; overload;

function XLSIsLightColor(AColor: TXLSColor): Boolean; overload;
function XLSIsLightColor(AColor: TColor): Boolean; overload;

// Paletas pré-definidas
function GetExcelThemeColors: TXLSColorArray;
function GetChartColors: TXLSColorArray;
function GetPastelColors: TXLSColorArray;
function GetStatusColors: TXLSColorArray;
function GetMaterialColors: TXLSColorArray;

// Cores nomeadas
function clXLS(const ColorName: string): TXLSColor;

implementation

// Funções auxiliares para manipulação de cores
// Implementação independente de plataforma

function RGBToColor(R, G, B: Byte): TColor;
begin
  Result := TColor((B shl 16) or (G shl 8) or R);
end;

function GetRedValue(Color: TColor): Byte;
begin
  Result := Byte(Color);
end;

function GetGreenValue(Color: TColor): Byte;
begin
  Result := Byte(Color shr 8);
end;

function GetBlueValue(Color: TColor): Byte;
begin
  Result := Byte(Color shr 16);
end;

{ TXLSColor }

constructor TXLSColor.Create(AR, AG, AB: Byte);
begin
  R := AR;
  G := AG;
  B := AB;
end;

constructor TXLSColor.Create(AColor: TColor);
begin
  Self := FromTColor(AColor);
end;

constructor TXLSColor.Create(const HexColor: string);
begin
  Self := FromHex(HexColor);
end;

function TXLSColor.ToHex: string;
begin
  Result := Format('#%.2x%.2x%.2x', [R, G, B]);
end;

function TXLSColor.ToTColor: TColor;
begin
  Result := RGBToColor(R, G, B);
end;

function TXLSColor.ToString: string;
begin
  Result := Format('RGB(%d, %d, %d)', [R, G, B]);
end;

class function TXLSColor.FromTColor(AColor: TColor): TXLSColor;
var
  WinColor: LongInt;
begin
  // Converte TColor para RGB
  WinColor := ColorToRGB(AColor);

  // Extrai componentes RGB
  Result.R := GetRedValue(WinColor);
  Result.G := GetGreenValue(WinColor);
  Result.B := GetBlueValue(WinColor);
end;

class function TXLSColor.FromHex(const HexColor: string): TXLSColor;
var
  CleanHex: string;
begin
  CleanHex := Trim(HexColor);

  // Remove o # se existir
  if (CleanHex <> '') and (CleanHex[1] = '#') then
    Delete(CleanHex, 1, 1);

  // Garante que tem 6 caracteres (expande formato abreviado)
  if Length(CleanHex) = 3 then
    CleanHex := CleanHex[1] + CleanHex[1] +
                CleanHex[2] + CleanHex[2] +
                CleanHex[3] + CleanHex[3];

  if Length(CleanHex) = 6 then
  begin
    try
      Result.R := StrToInt('$' + Copy(CleanHex, 1, 2));
      Result.G := StrToInt('$' + Copy(CleanHex, 3, 2));
      Result.B := StrToInt('$' + Copy(CleanHex, 5, 2));
    except
      // Cor padrão se conversão falhar
      Result.R := 0;
      Result.G := 0;
      Result.B := 0;
    end;
  end
  else
  begin
    // Cor padrão se formato inválido
    Result.R := 0;
    Result.G := 0;
    Result.B := 0;
  end;
end;

class function TXLSColor.FromRGB(R, G, B: Byte): TXLSColor;
begin
  Result.R := R;
  Result.G := G;
  Result.B := B;
end;

class function TXLSColor.FromWebColor(const WebColorName: string): TXLSColor;
var
  ColorName: string;
begin
  ColorName := LowerCase(Trim(WebColorName));

  // Mapeamento de cores web comuns
  if ColorName = 'aliceblue' then Result := FromHex('#F0F8FF')
  else if ColorName = 'antiquewhite' then Result := FromHex('#FAEBD7')
  else if ColorName = 'aqua' then Result := FromHex('#00FFFF')
  else if ColorName = 'aquamarine' then Result := FromHex('#7FFFD4')
  else if ColorName = 'azure' then Result := FromHex('#F0FFFF')
  else if ColorName = 'beige' then Result := FromHex('#F5F5DC')
  else if ColorName = 'bisque' then Result := FromHex('#FFE4C4')
  else if ColorName = 'black' then Result := FromHex('#000000')
  else if ColorName = 'blanchedalmond' then Result := FromHex('#FFEBCD')
  else if ColorName = 'blue' then Result := FromHex('#0000FF')
  else if ColorName = 'blueviolet' then Result := FromHex('#8A2BE2')
  else if ColorName = 'brown' then Result := FromHex('#A52A2A')
  else if ColorName = 'burlywood' then Result := FromHex('#DEB887')
  else if ColorName = 'cadetblue' then Result := FromHex('#5F9EA0')
  else if ColorName = 'chartreuse' then Result := FromHex('#7FFF00')
  else if ColorName = 'chocolate' then Result := FromHex('#D2691E')
  else if ColorName = 'coral' then Result := FromHex('#FF7F50')
  else if ColorName = 'cornflowerblue' then Result := FromHex('#6495ED')
  else if ColorName = 'cornsilk' then Result := FromHex('#FFF8DC')
  else if ColorName = 'crimson' then Result := FromHex('#DC143C')
  else if ColorName = 'cyan' then Result := FromHex('#00FFFF')
  else if ColorName = 'darkblue' then Result := FromHex('#00008B')
  else if ColorName = 'darkcyan' then Result := FromHex('#008B8B')
  else if ColorName = 'darkgoldenrod' then Result := FromHex('#B8860B')
  else if ColorName = 'darkgray' then Result := FromHex('#A9A9A9')
  else if ColorName = 'darkgreen' then Result := FromHex('#006400')
  else if ColorName = 'darkgrey' then Result := FromHex('#A9A9A9')
  else if ColorName = 'darkkhaki' then Result := FromHex('#BDB76B')
  else if ColorName = 'darkmagenta' then Result := FromHex('#8B008B')
  else if ColorName = 'darkolivegreen' then Result := FromHex('#556B2F')
  else if ColorName = 'darkorange' then Result := FromHex('#FF8C00')
  else if ColorName = 'darkorchid' then Result := FromHex('#9932CC')
  else if ColorName = 'darkred' then Result := FromHex('#8B0000')
  else if ColorName = 'darksalmon' then Result := FromHex('#E9967A')
  else if ColorName = 'darkseagreen' then Result := FromHex('#8FBC8F')
  else if ColorName = 'darkslateblue' then Result := FromHex('#483D8B')
  else if ColorName = 'darkslategray' then Result := FromHex('#2F4F4F')
  else if ColorName = 'darkslategrey' then Result := FromHex('#2F4F4F')
  else if ColorName = 'darkturquoise' then Result := FromHex('#00CED1')
  else if ColorName = 'darkviolet' then Result := FromHex('#9400D3')
  else if ColorName = 'deeppink' then Result := FromHex('#FF1493')
  else if ColorName = 'deepskyblue' then Result := FromHex('#00BFFF')
  else if ColorName = 'dimgray' then Result := FromHex('#696969')
  else if ColorName = 'dimgrey' then Result := FromHex('#696969')
  else if ColorName = 'dodgerblue' then Result := FromHex('#1E90FF')
  else if ColorName = 'firebrick' then Result := FromHex('#B22222')
  else if ColorName = 'floralwhite' then Result := FromHex('#FFFAF0')
  else if ColorName = 'forestgreen' then Result := FromHex('#228B22')
  else if ColorName = 'fuchsia' then Result := FromHex('#FF00FF')
  else if ColorName = 'gainsboro' then Result := FromHex('#DCDCDC')
  else if ColorName = 'ghostwhite' then Result := FromHex('#F8F8FF')
  else if ColorName = 'gold' then Result := FromHex('#FFD700')
  else if ColorName = 'goldenrod' then Result := FromHex('#DAA520')
  else if ColorName = 'gray' then Result := FromHex('#808080')
  else if ColorName = 'green' then Result := FromHex('#008000')
  else if ColorName = 'greenyellow' then Result := FromHex('#ADFF2F')
  else if ColorName = 'grey' then Result := FromHex('#808080')
  else if ColorName = 'honeydew' then Result := FromHex('#F0FFF0')
  else if ColorName = 'hotpink' then Result := FromHex('#FF69B4')
  else if ColorName = 'indianred' then Result := FromHex('#CD5C5C')
  else if ColorName = 'indigo' then Result := FromHex('#4B0082')
  else if ColorName = 'ivory' then Result := FromHex('#FFFFF0')
  else if ColorName = 'khaki' then Result := FromHex('#F0E68C')
  else if ColorName = 'lavender' then Result := FromHex('#E6E6FA')
  else if ColorName = 'lavenderblush' then Result := FromHex('#FFF0F5')
  else if ColorName = 'lawngreen' then Result := FromHex('#7CFC00')
  else if ColorName = 'lemonchiffon' then Result := FromHex('#FFFACD')
  else if ColorName = 'lightblue' then Result := FromHex('#ADD8E6')
  else if ColorName = 'lightcoral' then Result := FromHex('#F08080')
  else if ColorName = 'lightcyan' then Result := FromHex('#E0FFFF')
  else if ColorName = 'lightgoldenrodyellow' then Result := FromHex('#FAFAD2')
  else if ColorName = 'lightgray' then Result := FromHex('#D3D3D3')
  else if ColorName = 'lightgreen' then Result := FromHex('#90EE90')
  else if ColorName = 'lightgrey' then Result := FromHex('#D3D3D3')
  else if ColorName = 'lightpink' then Result := FromHex('#FFB6C1')
  else if ColorName = 'lightsalmon' then Result := FromHex('#FFA07A')
  else if ColorName = 'lightseagreen' then Result := FromHex('#20B2AA')
  else if ColorName = 'lightskyblue' then Result := FromHex('#87CEFA')
  else if ColorName = 'lightslategray' then Result := FromHex('#778899')
  else if ColorName = 'lightslategrey' then Result := FromHex('#778899')
  else if ColorName = 'lightsteelblue' then Result := FromHex('#B0C4DE')
  else if ColorName = 'lightyellow' then Result := FromHex('#FFFFE0')
  else if ColorName = 'lime' then Result := FromHex('#00FF00')
  else if ColorName = 'limegreen' then Result := FromHex('#32CD32')
  else if ColorName = 'linen' then Result := FromHex('#FAF0E6')
  else if ColorName = 'magenta' then Result := FromHex('#FF00FF')
  else if ColorName = 'maroon' then Result := FromHex('#800000')
  else if ColorName = 'mediumaquamarine' then Result := FromHex('#66CDAA')
  else if ColorName = 'mediumblue' then Result := FromHex('#0000CD')
  else if ColorName = 'mediumorchid' then Result := FromHex('#BA55D3')
  else if ColorName = 'mediumpurple' then Result := FromHex('#9370DB')
  else if ColorName = 'mediumseagreen' then Result := FromHex('#3CB371')
  else if ColorName = 'mediumslateblue' then Result := FromHex('#7B68EE')
  else if ColorName = 'mediumspringgreen' then Result := FromHex('#00FA9A')
  else if ColorName = 'mediumturquoise' then Result := FromHex('#48D1CC')
  else if ColorName = 'mediumvioletred' then Result := FromHex('#C71585')
  else if ColorName = 'midnightblue' then Result := FromHex('#191970')
  else if ColorName = 'mintcream' then Result := FromHex('#F5FFFA')
  else if ColorName = 'mistyrose' then Result := FromHex('#FFE4E1')
  else if ColorName = 'moccasin' then Result := FromHex('#FFE4B5')
  else if ColorName = 'navajowhite' then Result := FromHex('#FFDEAD')
  else if ColorName = 'navy' then Result := FromHex('#000080')
  else if ColorName = 'oldlace' then Result := FromHex('#FDF5E6')
  else if ColorName = 'olive' then Result := FromHex('#808000')
  else if ColorName = 'olivedrab' then Result := FromHex('#6B8E23')
  else if ColorName = 'orange' then Result := FromHex('#FFA500')
  else if ColorName = 'orangered' then Result := FromHex('#FF4500')
  else if ColorName = 'orchid' then Result := FromHex('#DA70D6')
  else if ColorName = 'palegoldenrod' then Result := FromHex('#EEE8AA')
  else if ColorName = 'palegreen' then Result := FromHex('#98FB98')
  else if ColorName = 'paleturquoise' then Result := FromHex('#AFEEEE')
  else if ColorName = 'palevioletred' then Result := FromHex('#DB7093')
  else if ColorName = 'papayawhip' then Result := FromHex('#FFEFD5')
  else if ColorName = 'peachpuff' then Result := FromHex('#FFDAB9')
  else if ColorName = 'peru' then Result := FromHex('#CD853F')
  else if ColorName = 'pink' then Result := FromHex('#FFC0CB')
  else if ColorName = 'plum' then Result := FromHex('#DDA0DD')
  else if ColorName = 'powderblue' then Result := FromHex('#B0E0E6')
  else if ColorName = 'purple' then Result := FromHex('#800080')
  else if ColorName = 'rebeccapurple' then Result := FromHex('#663399')
  else if ColorName = 'red' then Result := FromHex('#FF0000')
  else if ColorName = 'rosybrown' then Result := FromHex('#BC8F8F')
  else if ColorName = 'royalblue' then Result := FromHex('#4169E1')
  else if ColorName = 'saddlebrown' then Result := FromHex('#8B4513')
  else if ColorName = 'salmon' then Result := FromHex('#FA8072')
  else if ColorName = 'sandybrown' then Result := FromHex('#F4A460')
  else if ColorName = 'seagreen' then Result := FromHex('#2E8B57')
  else if ColorName = 'seashell' then Result := FromHex('#FFF5EE')
  else if ColorName = 'sienna' then Result := FromHex('#A0522D')
  else if ColorName = 'silver' then Result := FromHex('#C0C0C0')
  else if ColorName = 'skyblue' then Result := FromHex('#87CEEB')
  else if ColorName = 'slateblue' then Result := FromHex('#6A5ACD')
  else if ColorName = 'slategray' then Result := FromHex('#708090')
  else if ColorName = 'slategrey' then Result := FromHex('#708090')
  else if ColorName = 'snow' then Result := FromHex('#FFFAFA')
  else if ColorName = 'springgreen' then Result := FromHex('#00FF7F')
  else if ColorName = 'steelblue' then Result := FromHex('#4682B4')
  else if ColorName = 'tan' then Result := FromHex('#D2B48C')
  else if ColorName = 'teal' then Result := FromHex('#008080')
  else if ColorName = 'thistle' then Result := FromHex('#D8BFD8')
  else if ColorName = 'tomato' then Result := FromHex('#FF6347')
  else if ColorName = 'turquoise' then Result := FromHex('#40E0D0')
  else if ColorName = 'violet' then Result := FromHex('#EE82EE')
  else if ColorName = 'wheat' then Result := FromHex('#F5DEB3')
  else if ColorName = 'white' then Result := FromHex('#FFFFFF')
  else if ColorName = 'whitesmoke' then Result := FromHex('#F5F5F5')
  else if ColorName = 'yellow' then Result := FromHex('#FFFF00')
  else if ColorName = 'yellowgreen' then Result := FromHex('#9ACD32')

  // Cores do Excel
  else if ColorName = 'excelblue' then Result := FromRGB(68, 114, 196)
  else if ColorName = 'excelorange' then Result := FromRGB(237, 125, 49)
  else if ColorName = 'excelgreen' then Result := FromRGB(112, 173, 71)
  else if ColorName = 'excelred' then Result := FromRGB(237, 102, 93)
  else if ColorName = 'excelpurple' then Result := FromRGB(112, 48, 160)
  else if ColorName = 'excelcyan' then Result := FromRGB(68, 140, 203)
  else if ColorName = 'excelgray' then Result := FromRGB(165, 165, 165)
  else if ColorName = 'excelyellow' then Result := FromRGB(255, 192, 0)

  // Cores padrão do Delphi
  else if ColorName = 'clblack' then Result := FromTColor(clBlack)
  else if ColorName = 'clwhite' then Result := FromTColor(clWhite)
  else if ColorName = 'clred' then Result := FromTColor(clRed)
  else if ColorName = 'clgreen' then Result := FromTColor(clGreen)
  else if ColorName = 'clblue' then Result := FromTColor(clBlue)
  else if ColorName = 'clyellow' then Result := FromTColor(clYellow)
  else if ColorName = 'clfuchsia' then Result := FromTColor(clFuchsia)
  else if ColorName = 'claqua' then Result := FromTColor(clAqua)
  else if ColorName = 'clgray' then Result := FromTColor(clGray)
  else if ColorName = 'cllime' then Result := FromTColor(clLime)
  else if ColorName = 'clmaroon' then Result := FromTColor(clMaroon)
  else if ColorName = 'clnavy' then Result := FromTColor(clNavy)
  else if ColorName = 'clolive' then Result := FromTColor(clOlive)
  else if ColorName = 'clpurple' then Result := FromTColor(clPurple)
  else if ColorName = 'clsilver' then Result := FromTColor(clSilver)
  else if ColorName = 'clteal' then Result := FromTColor(clTeal)
  else
    // Cor padrão se não encontrada
    Result := FromTColor(clBlack);
end;

class operator TXLSColor.Equal(A, B: TXLSColor): Boolean;
begin
  Result := (A.R = B.R) and (A.G = B.G) and (A.B = B.B);
end;

class operator TXLSColor.NotEqual(A, B: TXLSColor): Boolean;
begin
  Result := not (A = B);
end;

class operator TXLSColor.Implicit(AColor: TColor): TXLSColor;
begin
  Result := FromTColor(AColor);
end;

class operator TXLSColor.Implicit(AColor: TXLSColor): TColor;
begin
  Result := AColor.ToTColor;
end;

{ Funções públicas }

function XLSColor(R, G, B: Byte): TXLSColor;
begin
  Result := TXLSColor.Create(R, G, B);
end;

function XLSColor(AColor: TColor): TXLSColor;
begin
  Result := TXLSColor.Create(AColor);
end;

function XLSColor(const HexColor: string): TXLSColor;
begin
  Result := TXLSColor.Create(HexColor);
end;

function XLSLighten(AColor: TXLSColor; Percent: Integer): TXLSColor;
begin
  Percent := EnsureRange(Percent, 0, 100);
  Result.R := EnsureRange(AColor.R + Round((255 - AColor.R) * Percent / 100), 0, 255);
  Result.G := EnsureRange(AColor.G + Round((255 - AColor.G) * Percent / 100), 0, 255);
  Result.B := EnsureRange(AColor.B + Round((255 - AColor.B) * Percent / 100), 0, 255);
end;

function XLSLighten(AColor: TColor; Percent: Integer): TColor;
begin
  Result := XLSLighten(XLSColor(AColor), Percent).ToTColor;
end;

function XLSDarken(AColor: TXLSColor; Percent: Integer): TXLSColor;
begin
  Percent := EnsureRange(Percent, 0, 100);
  Result.R := EnsureRange(AColor.R - Round(AColor.R * Percent / 100), 0, 255);
  Result.G := EnsureRange(AColor.G - Round(AColor.G * Percent / 100), 0, 255);
  Result.B := EnsureRange(AColor.B - Round(AColor.B * Percent / 100), 0, 255);
end;

function XLSDarken(AColor: TColor; Percent: Integer): TColor;
begin
  Result := XLSDarken(XLSColor(AColor), Percent).ToTColor;
end;

function XLSAdjustBrightness(AColor: TXLSColor; Delta: Integer): TXLSColor;
begin
  Result.R := EnsureRange(AColor.R + Delta, 0, 255);
  Result.G := EnsureRange(AColor.G + Delta, 0, 255);
  Result.B := EnsureRange(AColor.B + Delta, 0, 255);
end;

function XLSAdjustBrightness(AColor: TColor; Delta: Integer): TColor;
begin
  Result := XLSAdjustBrightness(XLSColor(AColor), Delta).ToTColor;
end;

function XLSGradient(Color1, Color2: TXLSColor; Percent: Integer): TXLSColor;
begin
  Percent := EnsureRange(Percent, 0, 100);
  Result.R := Color1.R + Round((Color2.R - Color1.R) * Percent / 100);
  Result.G := Color1.G + Round((Color2.G - Color1.G) * Percent / 100);
  Result.B := Color1.B + Round((Color2.B - Color1.B) * Percent / 100);
end;

function XLSGradient(Color1, Color2: TColor; Percent: Integer): TColor;
begin
  Result := XLSGradient(XLSColor(Color1), XLSColor(Color2), Percent).ToTColor;
end;

function XLSComplementary(AColor: TXLSColor): TXLSColor;
begin
  Result.R := 255 - AColor.R;
  Result.G := 255 - AColor.G;
  Result.B := 255 - AColor.B;
end;

function XLSComplementary(AColor: TColor): TColor;
begin
  Result := XLSComplementary(XLSColor(AColor)).ToTColor;
end;

// Funções auxiliares HSL
procedure RGBtoHSL(R, G, B: Byte; out H, S, L: Single);
var
  Rf, Gf, Bf: Single;
  Max, Min, Delta: Single;
begin
  Rf := R / 255;
  Gf := G / 255;
  Bf := B / 255;

  Max := MaxValue([Rf, Gf, Bf]);
  Min := MinValue([Rf, Gf, Bf]);

  L := (Max + Min) / 2;

  if Max = Min then
  begin
    H := 0;
    S := 0;
  end
  else
  begin
    Delta := Max - Min;

    if L > 0.5 then
      S := Delta / (2 - Max - Min)
    else
      S := Delta / (Max + Min);

    if Max = Rf then
    begin
      H := (Gf - Bf) / Delta;
      if Gf < Bf then
        H := H + 6;
    end
    else if Max = Gf then
      H := 2 + (Bf - Rf) / Delta
    else
      H := 4 + (Rf - Gf) / Delta;

    H := H * 60;
  end;
end;

procedure HSLtoRGB(H, S, L: Single; out R, G, B: Byte);
var
  C, X, M: Single;
  Rf, Gf, Bf: Single;
  Hf: Single;
begin
  if S = 0 then
  begin
    Rf := L;
    Gf := L;
    Bf := L;
  end
  else
  begin
    if L < 0.5 then
      C := 2 * L * S
    else
      C := (2 - 2 * L) * S;

    Hf := H / 60;
    while Hf >= 6 do
      Hf := Hf - 6;
    while Hf < 0 do
      Hf := Hf + 6;

    X := C * (1 - Abs(Frac(Hf / 2) * 2 - 1));

    if Hf < 1 then
    begin
      Rf := C;
      Gf := X;
      Bf := 0;
    end
    else if Hf < 2 then
    begin
      Rf := X;
      Gf := C;
      Bf := 0;
    end
    else if Hf < 3 then
    begin
      Rf := 0;
      Gf := C;
      Bf := X;
    end
    else if Hf < 4 then
    begin
      Rf := 0;
      Gf := X;
      Bf := C;
    end
    else if Hf < 5 then
    begin
      Rf := X;
      Gf := 0;
      Bf := C;
    end
    else
    begin
      Rf := C;
      Gf := 0;
      Bf := X;
    end;

    M := L - C / 2;
    Rf := Rf + M;
    Gf := Gf + M;
    Bf := Bf + M;
  end;

  R := EnsureRange(Round(Rf * 255), 0, 255);
  G := EnsureRange(Round(Gf * 255), 0, 255);
  B := EnsureRange(Round(Bf * 255), 0, 255);
end;

function XLSAnalogous(AColor: TXLSColor; Angle: Integer = 30): TXLSColorArray;
var
  H, S, L: Single;
  A1, A2: Single;
begin
  SetLength(Result, 2);

  // Converte para HSL
  RGBtoHSL(AColor.R, AColor.G, AColor.B, H, S, L);

  // Calcula cores análogas
  A1 := H + Angle;
  while A1 >= 360 do
    A1 := A1 - 360;

  A2 := H - Angle;
  while A2 < 0 do
    A2 := A2 + 360;

  // Converte de volta para RGB
  HSLtoRGB(A1, S, L, Result[0].R, Result[0].G, Result[0].B);
  HSLtoRGB(A2, S, L, Result[1].R, Result[1].G, Result[1].B);
end;

function XLSAnalogous(AColor: TColor; Angle: Integer = 30): TColorArray;
var
  Colors: TXLSColorArray;
begin
  Colors := XLSAnalogous(XLSColor(AColor), Angle);
  SetLength(Result, Length(Colors));
  Result[0] := Colors[0].ToTColor;
  Result[1] := Colors[1].ToTColor;
end;

function XLSTriad(AColor: TXLSColor): TXLSColorArray;
var
  H, S, L: Single;
  H1, H2: Single;
begin
  SetLength(Result, 3);

  // Converte para HSL
  RGBtoHSL(AColor.R, AColor.G, AColor.B, H, S, L);

  // Triade: 120 graus de diferença
  H1 := H + 120;
  while H1 >= 360 do
    H1 := H1 - 360;

  H2 := H + 240;
  while H2 >= 360 do
    H2 := H2 - 360;

  HSLtoRGB(H, S, L, Result[0].R, Result[0].G, Result[0].B);
  HSLtoRGB(H1, S, L, Result[1].R, Result[1].G, Result[1].B);
  HSLtoRGB(H2, S, L, Result[2].R, Result[2].G, Result[2].B);
end;

function XLSTriad(AColor: TColor): TColorArray;
var
  Colors: TXLSColorArray;
begin
  Colors := XLSTriad(XLSColor(AColor));
  SetLength(Result, Length(Colors));
  Result[0] := Colors[0].ToTColor;
  Result[1] := Colors[1].ToTColor;
  Result[2] := Colors[2].ToTColor;
end;

function XLSGetContrastTextColor(BgColor: TXLSColor): TXLSColor;
var
  Luminance: Double;
begin
  // Fórmula de luminância relativa (W3C)
  Luminance := (0.299 * BgColor.R + 0.587 * BgColor.G + 0.114 * BgColor.B) / 255;

  if Luminance > 0.5 then
    Result := XLSColor(clBlack)
  else
    Result := XLSColor(clWhite);
end;

function XLSGetContrastTextColor(BgColor: TColor): TColor;
begin
  Result := XLSGetContrastTextColor(XLSColor(BgColor)).ToTColor;
end;

function XLSHasGoodContrast(Color1, Color2: TXLSColor; MinRatio: Double = 4.5): Boolean;
var
  L1, L2: Double;
  Ratio: Double;
begin
  // Calcula luminância relativa (sRGB)
  L1 := (0.2126 * Color1.R + 0.7152 * Color1.G + 0.0722 * Color1.B) / 255;
  L2 := (0.2126 * Color2.R + 0.7152 * Color2.G + 0.0722 * Color2.B) / 255;

  // Calcula razão de contraste
  if L1 > L2 then
    Ratio := (L1 + 0.05) / (L2 + 0.05)
  else
    Ratio := (L2 + 0.05) / (L1 + 0.05);

  // Compara com mínimo desejado (AA level = 4.5:1, AAA = 7:1)
  Result := Ratio >= MinRatio;
end;

function XLSHasGoodContrast(Color1, Color2: TColor; MinRatio: Double = 4.5): Boolean;
begin
  Result := XLSHasGoodContrast(XLSColor(Color1), XLSColor(Color2), MinRatio);
end;

function XLSIsLightColor(AColor: TXLSColor): Boolean;
var
  Luminance: Double;
begin
  Luminance := (0.299 * AColor.R + 0.587 * AColor.G + 0.114 * AColor.B) / 255;
  Result := Luminance > 0.5;
end;

function XLSIsLightColor(AColor: TColor): Boolean;
begin
  Result := XLSIsLightColor(XLSColor(AColor));
end;

function GetExcelThemeColors: TXLSColorArray;
begin
  SetLength(Result, 8);
  Result[0] := XLSColor('#4472C4');  // Excel Blue
  Result[1] := XLSColor('#ED7D31');  // Excel Orange
  Result[2] := XLSColor('#A5A5A5');  // Excel Gray
  Result[3] := XLSColor('#FFC000');  // Excel Yellow
  Result[4] := XLSColor('#70AD47');  // Excel Green
  Result[5] := XLSColor('#7030A0');  // Excel Purple
  Result[6] := XLSColor('#448CCB');  // Excel Cyan
  Result[7] := XLSColor('#ED665D');  // Excel Pink
end;

function GetChartColors: TXLSColorArray;
begin
  SetLength(Result, 10);
  Result[0] := XLSColor('#4472C4');
  Result[1] := XLSColor('#ED7D31');
  Result[2] := XLSColor('#A5A5A5');
  Result[3] := XLSColor('#FFC000');
  Result[4] := XLSColor('#70AD47');
  Result[5] := XLSColor('#7030A0');
  Result[6] := XLSColor('#448CCB');
  Result[7] := XLSColor('#ED665D');
  Result[8] := XLSColor('#5B9BD5');
  Result[9] := XLSColor('#FFD966');
end;

function GetPastelColors: TXLSColorArray;
begin
  SetLength(Result, 8);
  Result[0] := XLSColor('#B4C6E7');  // Pastel Blue
  Result[1] := XLSColor('#F8CBAD');  // Pastel Orange
  Result[2] := XLSColor('#C6E0B4');  // Pastel Green
  Result[3] := XLSColor('#FFE699');  // Pastel Yellow
  Result[4] := XLSColor('#D9D9D9');  // Pastel Gray
  Result[5] := XLSColor('#E2EFDA');  // Pastel Light Green
  Result[6] := XLSColor('#FFF2CC');  // Pastel Light Yellow
  Result[7] := XLSColor('#F2F2F2');  // Pastel Light Gray
end;

function GetStatusColors: TXLSColorArray;
begin
  SetLength(Result, 4);
  Result[0] := XLSColor('#4CAF50');  // Success Green
  Result[1] := XLSColor('#FFEB3B');  // Warning Yellow
  Result[2] := XLSColor('#F44336');  // Error Red
  Result[3] := XLSColor('#2196F3');  // Info Blue
end;

function GetMaterialColors: TXLSColorArray;
begin
  SetLength(Result, 8);
  Result[0] := XLSColor('#F44336');  // Red
  Result[1] := XLSColor('#E91E63');  // Pink
  Result[2] := XLSColor('#9C27B0');  // Purple
  Result[3] := XLSColor('#673AB7');  // Deep Purple
  Result[4] := XLSColor('#3F51B5');  // Indigo
  Result[5] := XLSColor('#2196F3');  // Blue
  Result[6] := XLSColor('#00BCD4');  // Cyan
  Result[7] := XLSColor('#009688');  // Teal
end;

function clXLS(const ColorName: string): TXLSColor;
begin
  Result := TXLSColor.FromWebColor(ColorName);
end;

end.
