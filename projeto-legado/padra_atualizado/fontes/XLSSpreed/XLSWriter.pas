unit XLSWriter;

interface

uses
  System.Classes, System.SysUtils, System.Variants, System.Generics.Collections,
  Vcl.Graphics, XLSColors, untExcel;

type
  TXLSCellType = (ctString, ctNumber, ctDateTime, ctBoolean, ctFormula);
  TXLSAlignment = (alLeft, alCenter, alRight, alGeneral);
  TXLSVerticalAlignment = (vaTop, vaCenter, vaBottom);
  TXLSBorderStyle = (bsNone, bsThin, bsMedium, bsThick, bsDashed, bsDotted);
  TXLSFillPattern = (fpSolid, fpGray75, fpGray50, fpGray25, fpGray125, fpGray0625);


  TAjustaFormatoNumerico = record
    Coluna: integer;
    Formato: String;
    PosicaoInicial: integer;
    PosicaoFinal: integer;
  End;

  TArrAjustaFormatoNumerico = Array of TAjustaFormatoNumerico;

  TXLSCellStyle = class
  private
    FName: string;
    FFontName: string;
    FFontSize: Integer;
    FFontBold: Boolean;
    FFontItalic: Boolean;
    FFontUnderline: Boolean;
    FFontColor: TXLSColor;
    FBgColor: TXLSColor;
    FAlignment: TXLSAlignment;
    FVerticalAlignment: TXLSVerticalAlignment;
    FNumberFormat: string;
    FProtected: Boolean;
    FBorderLeft: TXLSBorderStyle;
    FBorderTop: TXLSBorderStyle;
    FBorderRight: TXLSBorderStyle;
    FBorderBottom: TXLSBorderStyle;
    FBorderColor: TXLSColor;
    FFillPattern: TXLSFillPattern;
    FWrapText: Boolean;
  public
    constructor Create;

    // Métodos de configuração fluente (Fluent Interface)
    function SetFontName(const Value: string): TXLSCellStyle;
    function SetFontSize(Value: Integer): TXLSCellStyle;
    function SetFontBold(Value: Boolean): TXLSCellStyle;
    function SetFontItalic(Value: Boolean): TXLSCellStyle;
    function SetFontUnderline(Value: Boolean): TXLSCellStyle;
    function SetFontColor(AColor: TXLSColor): TXLSCellStyle;
    function SetBgColor(AColor: TXLSColor): TXLSCellStyle;
    function SetAlignment(AAlign: TXLSAlignment): TXLSCellStyle;
    function SetVerticalAlignment(AAlign: TXLSVerticalAlignment): TXLSCellStyle;
    function SetNumberFormat(const Value: string): TXLSCellStyle;
    function SetProtected(Value: Boolean): TXLSCellStyle;
    function SetBorders(AStyle: TXLSBorderStyle; AColor: TXLSColor): TXLSCellStyle;
    function SetBorderLeft(AStyle: TXLSBorderStyle; AColor: TXLSColor): TXLSCellStyle;
    function SetBorderTop(AStyle: TXLSBorderStyle; AColor: TXLSColor): TXLSCellStyle;
    function SetBorderRight(AStyle: TXLSBorderStyle; AColor: TXLSColor): TXLSCellStyle;
    function SetBorderBottom(AStyle: TXLSBorderStyle; AColor: TXLSColor): TXLSCellStyle;
    function SetFillPattern(APattern: TXLSFillPattern): TXLSCellStyle;
    function SetWrapText(Value: Boolean): TXLSCellStyle;
    function ConverteParaPadraoBR(): string;


    // Propriedades
    property FontName: string read FFontName write FFontName;
    property FontSize: Integer read FFontSize write FFontSize;
    property FontBold: Boolean read FFontBold write FFontBold;
    property FontItalic: Boolean read FFontItalic write FFontItalic;
    property FontUnderline: Boolean read FFontUnderline write FFontUnderline;
    property FontColor: TXLSColor read FFontColor write FFontColor;
    property BgColor: TXLSColor read FBgColor write FBgColor;
    property Alignment: TXLSAlignment read FAlignment write FAlignment;
    property VerticalAlignment: TXLSVerticalAlignment read FVerticalAlignment write FVerticalAlignment;
    property NumberFormat: string read FNumberFormat write FNumberFormat;
    property Protected: Boolean read FProtected write FProtected;
    property WrapText: Boolean read FWrapText write FWrapText;
    property BorderLeft: TXLSBorderStyle read FBorderLeft write FBorderLeft;
    property BorderTop: TXLSBorderStyle read FBorderTop write FBorderTop;
    property BorderRight: TXLSBorderStyle read FBorderRight write FBorderRight;
    property BorderBottom: TXLSBorderStyle read FBorderBottom write FBorderBottom;
    property Name: string read FName write FName;
  end;

  TXLSCell = class
  private
    FValue: Variant;
    FCellType: TXLSCellType;
    FStyle: TXLSCellStyle;
    FMergeAcross: Integer;
    FMergeDown: Integer;
    FFormula: string;
  public
    constructor Create(AValue: Variant; ACellType: TXLSCellType = ctString);
    destructor Destroy; override;

    // Métodos fluentes
    function SetStyle(AStyle: TXLSCellStyle): TXLSCell;
    function SetMergeAcross(Value: Integer): TXLSCell;
    function SetMergeDown(Value: Integer): TXLSCell;
    function SetFormula(const AFormula: string): TXLSCell;

    property Value: Variant read FValue write FValue;
    property CellType: TXLSCellType read FCellType write FCellType;
    property Style: TXLSCellStyle read FStyle write FStyle;
    property MergeAcross: Integer read FMergeAcross write FMergeAcross;
    property MergeDown: Integer read FMergeDown write FMergeDown;
    property Formula: string read FFormula write FFormula;
  end;

  TXLSRow = class
  private
    FCells: TObjectList<TXLSCell>;
    FHeight: Double;
    FAutoHeight: Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    function AddCell(AValue: Variant; ACellType: TXLSCellType = ctString): TXLSCell; overload;
    function AddCell(ACell: TXLSCell): TXLSCell; overload;
    function InsertCell(Index: Integer; AValue: Variant): TXLSCell;
    function CellCount: Integer;
    function GetCell(Index: Integer): TXLSCell;

    function SetHeight(AHeight: Double): TXLSRow;
    function SetAutoHeight(Value: Boolean): TXLSRow;

    property Height: Double read FHeight write FHeight;
    property AutoHeight: Boolean read FAutoHeight write FAutoHeight;
    property Cells[Index: Integer]: TXLSCell read GetCell; default;
  end;

  TXLSWorksheet = class
  private
    FName: string;
    FRows: TObjectList<TXLSRow>;
    FDefaultColumnWidth: Double;
    FColumnWidths: array of Double;
    FProtected: Boolean;
    FPassword: string;
  public
    constructor Create(const AName: string);
    destructor Destroy; override;

    function AddRow: TXLSRow;
    function InsertRow(Index: Integer): TXLSRow;
    function RowCount: Integer;
    function GetRow(Index: Integer): TXLSRow;

    function SetColumnWidth(AColumn: Integer; AWidth: Double): TXLSWorksheet;
    function SetDefaultColumnWidth(AWidth: Double): TXLSWorksheet;
    function SetProtected(Value: Boolean; const APassword: string = ''): TXLSWorksheet;

    function AddDataFromArray(const Data: array of Variant): TXLSWorksheet;
    function AddDataFromStrings(Strings: TStrings): TXLSWorksheet;

    property Name: string read FName write FName;
    property Rows[Index: Integer]: TXLSRow read GetRow; default;
    property Protected: Boolean read FProtected;
  end;

  TXLSWorkbook = class
  private
    FWorksheets: TObjectList<TXLSWorksheet>;
    FAuthor: string;
    FCompany: string;
    FCreated: TDateTime;
    FStyles: TObjectList<TXLSCellStyle>;
    FArrAjustaFormatoNumerico: TArrAjustaFormatoNumerico;

    function GenerateXML: TStrings;
    function EscapeXML(const Text: string): string;
    function VariantToXMLValue(Value: Variant; CellType: TXLSCellType): string;
    function GetBorderStyleName(AStyle: TXLSBorderStyle): string;
    function GetFillPatternName(APattern: TXLSFillPattern): string;
    function GetAlignmentName(AAlign: TXLSAlignment): string;
    function GetVerticalAlignmentName(AAlign: TXLSVerticalAlignment): string;
    function GetNumberFormatCode(const AFormat: string): string;
  public
    constructor Create;
    destructor Destroy; override;

    // Gerenciamento de planilhas
    function AddWorksheet(const AName: string): TXLSWorksheet;
    function GetWorksheet(Index: Integer): TXLSWorksheet; overload;
    function GetWorksheet(const AName: string): TXLSWorksheet; overload;
    function WorksheetCount: Integer;

    // Estilos predefinidos no padrão brasileiro
    function CreateStyle: TXLSCellStyle;
    function GetDefaultStyle: TXLSCellStyle;
    function GetHeaderStyle: TXLSCellStyle;
    function GetCurrencyStyle: TXLSCellStyle;
    function GetPercentStyle: TXLSCellStyle;
    function GetDateStyle: TXLSCellStyle;
    function GetTimeStyle: TXLSCellStyle;
    function GetDateTimeStyle: TXLSCellStyle;
    function GetHyperlinkStyle: TXLSCellStyle;
    function GetTextStyle: TXLSCellStyle;
    function GetNumberStyle(ADecimals: Integer = 2; AUseThousandSeparator: Boolean = True): TXLSCellStyle;

    // Métodos de saída
    procedure SaveToFile(const FileName: string; BloquearCelulas: Boolean = false; protegerEstrutura : Boolean = False; Senha: string = '');
    procedure protegerPlanilha(const FileName: string; Bloquear: Boolean = false; protegerEstrutura : Boolean = False; Senha: string = '');
    procedure SaveToStream(Stream: TStream);
    function SaveToString: string;

    // Métodos auxiliares
    procedure SetAuthor(const AAuthor: string);
    procedure SetCompany(const ACompany: string);
    function MontaAjustaFormatoNumerico(Coluna: integer; Formato: String; PosicaoInicial: integer; PosicaoFinal: integer):  TAjustaFormatoNumerico;
    procedure AddAjustaFormatoNumerico(AjustaFormatoNumerico: TAjustaFormatoNumerico);

    // Exportação rápida
    procedure QuickExport(const FileName: string; Data: array of TArray<Variant>);
    procedure QuickExportBR(const FileName: string; Data: array of TArray<Variant>; AHeaders: array of string);

    property Worksheets[Index: Integer]: TXLSWorksheet read GetWorksheet; default;
    property Author: string read FAuthor write FAuthor;
    property Company: string read FCompany write FCompany;
  end;

implementation

{ TXLSCellStyle }

constructor TXLSCellStyle.Create;
begin
  inherited;
  FFontName := 'Calibri';
  FFontSize := 11;
  FFontColor := TXLSColor.FromTColor(clBlack);
  FBgColor := TXLSColor.FromTColor(clWhite);
  FAlignment := alGeneral;
  FVerticalAlignment := vaBottom;
  FNumberFormat := ''; // Padrão brasileiro
  FProtected := False;
  FBorderLeft := bsNone;
  FBorderTop := bsNone;
  FBorderRight := bsNone;
  FBorderBottom := bsNone;
  FBorderColor := TXLSColor.FromTColor(clBlack);
  FFillPattern := fpSolid;
  FWrapText := False;
end;

function TXLSCellStyle.SetFontName(const Value: string): TXLSCellStyle;
begin
  FFontName := Value;
  Result := Self;
end;

function TXLSCellStyle.SetFontSize(Value: Integer): TXLSCellStyle;
begin
  FFontSize := Value;
  Result := Self;
end;

function TXLSCellStyle.SetFontBold(Value: Boolean): TXLSCellStyle;
begin
  FFontBold := Value;
  Result := Self;
end;

function TXLSCellStyle.SetFontItalic(Value: Boolean): TXLSCellStyle;
begin
  FFontItalic := Value;
  Result := Self;
end;

function TXLSCellStyle.SetFontUnderline(Value: Boolean): TXLSCellStyle;
begin
  FFontUnderline := Value;
  Result := Self;
end;

function TXLSCellStyle.SetFontColor(AColor: TXLSColor): TXLSCellStyle;
begin
  FFontColor := AColor;
  Result := Self;
end;

function TXLSCellStyle.SetBgColor(AColor: TXLSColor): TXLSCellStyle;
begin
  FBgColor := AColor;
  Result := Self;
end;

function TXLSCellStyle.SetAlignment(AAlign: TXLSAlignment): TXLSCellStyle;
begin
  FAlignment := AAlign;
  Result := Self;
end;

function TXLSCellStyle.SetVerticalAlignment(AAlign: TXLSVerticalAlignment): TXLSCellStyle;
begin
  FVerticalAlignment := AAlign;
  Result := Self;
end;

function TXLSCellStyle.SetNumberFormat(const Value: string): TXLSCellStyle;
begin
  FNumberFormat := Value;
  Result := Self;
end;

function TXLSCellStyle.SetProtected(Value: Boolean): TXLSCellStyle;
begin
  FProtected := Value;
  Result := Self;
end;

function TXLSCellStyle.SetBorders(AStyle: TXLSBorderStyle; AColor: TXLSColor): TXLSCellStyle;
begin
  FBorderLeft := AStyle;
  FBorderTop := AStyle;
  FBorderRight := AStyle;
  FBorderBottom := AStyle;
  FBorderColor := AColor;
  Result := Self;
end;

function TXLSCellStyle.SetBorderLeft(AStyle: TXLSBorderStyle; AColor: TXLSColor): TXLSCellStyle;
begin
  FBorderLeft := AStyle;
  FBorderColor := AColor;
  Result := Self;
end;

function TXLSCellStyle.SetBorderTop(AStyle: TXLSBorderStyle; AColor: TXLSColor): TXLSCellStyle;
begin
  FBorderTop := AStyle;
  FBorderColor := AColor;
  Result := Self;
end;

function TXLSCellStyle.SetBorderRight(AStyle: TXLSBorderStyle; AColor: TXLSColor): TXLSCellStyle;
begin
  FBorderRight := AStyle;
  FBorderColor := AColor;
  Result := Self;
end;

function TXLSCellStyle.SetBorderBottom(AStyle: TXLSBorderStyle; AColor: TXLSColor): TXLSCellStyle;
begin
  FBorderBottom := AStyle;
  FBorderColor := AColor;
  Result := Self;
end;

function TXLSCellStyle.SetFillPattern(APattern: TXLSFillPattern): TXLSCellStyle;
begin
  FFillPattern := APattern;
  Result := Self;
end;

function TXLSCellStyle.SetWrapText(Value: Boolean): TXLSCellStyle;
begin
  FWrapText := Value;
  Result := Self;
end;

function TXLSCellStyle.ConverteParaPadraoBR(): string;
var Formato: string;
  i: Integer;
  EmEstruturaEspecial : Boolean;
  UltimaVirgula, UltimoPontoDecimal : integer;
  TemSeparadorDecimal: Boolean;
begin
  Result := FNumberFormat;
  Formato := FNumberFormat;

  if Trim(Formato) = '' then
  begin
    Result := '#.##0,00';
    Exit;
  end;

  // Remover espaços
  Result := StringReplace(Result, ' ', '', [rfReplaceAll]);
  EmEstruturaEspecial := False;
  UltimoPontoDecimal := -1;

  // Converter ponto decimal para vírgula
  // Procura o último ponto que não está dentro de colchetes ou outras estruturas especiais

  for i := 1 to Length(Result) do
  begin
    if Result[i] = '[' then
      EmEstruturaEspecial := True
    else if Result[i] = ']' then
      EmEstruturaEspecial := False
    else if Result[i] = '.' then
    begin
      // Verificar se é um ponto decimal (depois de um dígito ou #)
      if not EmEstruturaEspecial then
      begin
        if (i > 1) and CharInSet(Result[i-1], ['0'..'9', '#']) then
          UltimoPontoDecimal := i;
      end;
    end;
  end;

  if UltimoPontoDecimal > 0 then
    Result[UltimoPontoDecimal] := ',';

  // Converter separador de milhar: vírgula para ponto
  // Só converte vírgulas que não são decimais
  TemSeparadorDecimal := Pos(',', Result) > 0;

  if TemSeparadorDecimal then
  begin
    // Se já tem vírgula decimal, as outras vírgulas são separadores de milhar
    Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
    // Restaura a vírgula decimal (será a última vírgula convertida)
    UltimaVirgula := LastDelimiter(',', Result);
    if UltimaVirgula > 0 then
    begin
      // Encontrar a posição da vírgula decimal (normalmente após zeros)
      for i := Length(Result) downto 1 do
      begin
        if Result[i] = '.' then
        begin
          // Verificar se é provavelmente o separador decimal
          // (tem dígitos ou # depois do ponto)
          if (i < Length(Result)) and CharInSet(Result[i+1], ['0'..'9', '#']) then
          begin
            Result[i] := ',';
            Break;
          end;
        end;
      end;
    end;
  end
  else
  begin
    // Se não tem vírgula decimal, então vírgulas são separadores de milhar
    Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
  end;

  // Ajustar formato para padrão BR comum se necessário
//  Result := AjustaFormatoBR(Result);
end;

{ TXLSCell }

constructor TXLSCell.Create(AValue: Variant; ACellType: TXLSCellType);
begin
  inherited Create;
  FValue := AValue;
  FCellType := ACellType;
  FMergeAcross := 0;
  FMergeDown := 0;
  FFormula := '';
end;

destructor TXLSCell.Destroy;
begin
  // Não liberamos o estilo pois pode ser compartilhado
  inherited;
end;

function TXLSCell.SetStyle(AStyle: TXLSCellStyle): TXLSCell;
begin
  FStyle := AStyle;
  Result := Self;
end;

function TXLSCell.SetMergeAcross(Value: Integer): TXLSCell;
begin
  FMergeAcross := Value;
  Result := Self;
end;

function TXLSCell.SetMergeDown(Value: Integer): TXLSCell;
begin
  FMergeDown := Value;
  Result := Self;
end;

function TXLSCell.SetFormula(const AFormula: string): TXLSCell;
begin
  FFormula := AFormula;
  FCellType := ctFormula;
  Result := Self;
end;

{ TXLSRow }

constructor TXLSRow.Create;
begin
  inherited;
  FCells := TObjectList<TXLSCell>.Create(True);
  FHeight := 15;
  FAutoHeight := True;
end;

destructor TXLSRow.Destroy;
begin
  FCells.Free;
  inherited;
end;

function TXLSRow.AddCell(AValue: Variant; ACellType: TXLSCellType): TXLSCell;
begin
  Result := TXLSCell.Create(AValue, ACellType);
  FCells.Add(Result);
end;

function TXLSRow.AddCell(ACell: TXLSCell): TXLSCell;
begin
  FCells.Add(ACell);
  Result := ACell;
end;

function TXLSRow.InsertCell(Index: Integer; AValue: Variant): TXLSCell;
begin
  Result := TXLSCell.Create(AValue);
  FCells.Insert(Index, Result);
end;

function TXLSRow.CellCount: Integer;
begin
  Result := FCells.Count;
end;

function TXLSRow.GetCell(Index: Integer): TXLSCell;
begin
  if (Index >= 0) and (Index < FCells.Count) then
    Result := FCells[Index]
  else
    Result := nil;
end;

function TXLSRow.SetHeight(AHeight: Double): TXLSRow;
begin
  FHeight := AHeight;
  Result := Self;
end;

function TXLSRow.SetAutoHeight(Value: Boolean): TXLSRow;
begin
  FAutoHeight := Value;
  Result := Self;
end;

{ TXLSWorksheet }

constructor TXLSWorksheet.Create(const AName: string);
begin
  inherited Create;
  FName := AName;
  FRows := TObjectList<TXLSRow>.Create(True);
  FDefaultColumnWidth := 70;
  SetLength(FColumnWidths, 0);
  FProtected := False;
  FPassword := '';
end;

destructor TXLSWorksheet.Destroy;
begin
  FRows.Free;
  inherited;
end;

function TXLSWorksheet.AddRow: TXLSRow;
begin
  Result := TXLSRow.Create;
  FRows.Add(Result);
end;

function TXLSWorksheet.InsertRow(Index: Integer): TXLSRow;
begin
  Result := TXLSRow.Create;
  FRows.Insert(Index, Result);
end;

function TXLSWorksheet.RowCount: Integer;
begin
  Result := FRows.Count;
end;

function TXLSWorksheet.GetRow(Index: Integer): TXLSRow;
begin
  if (Index >= 0) and (Index < FRows.Count) then
    Result := FRows[Index]
  else
    Result := nil;
end;

function TXLSWorksheet.SetColumnWidth(AColumn: Integer; AWidth: Double): TXLSWorksheet;
begin
  if AColumn >= Length(FColumnWidths) then
    SetLength(FColumnWidths, AColumn + 1);

  FColumnWidths[AColumn] := AWidth;
  Result := Self;
end;

function TXLSWorksheet.SetDefaultColumnWidth(AWidth: Double): TXLSWorksheet;
begin
  FDefaultColumnWidth := AWidth;
  Result := Self;
end;

function TXLSWorksheet.SetProtected(Value: Boolean; const APassword: string): TXLSWorksheet;
begin
  FProtected := Value;
  FPassword := APassword;
  Result := Self;
end;

function TXLSWorksheet.AddDataFromArray(const Data: array of Variant): TXLSWorksheet;
var
  Row: TXLSRow;
  I: Integer;
  Value: Variant;
  S: string;
  DblValue: Double;
  Code: Integer;
  HasComma, HasDot: Boolean;
begin
  Row := AddRow;
  for I := Low(Data) to High(Data) do
  begin
    Value := Data[I];
    // Se for um número com formato brasileiro, converte para o formato Excel
    if VarIsStr(Value) then
    begin
      S := VarToStr(Value);
      HasComma := Pos(',', S) > 0;
      HasDot := Pos('.', S) > 0;

      // Se tem vírgula mas não tem ponto, provavelmente é número brasileiro
      if HasComma and not HasDot then
      begin
        // Tenta converter strings com vírgula decimal para número
        // Primeiro remove pontos (separadores de milhar)
        S := StringReplace(S, '.', '', [rfReplaceAll]);
        // Converte vírgula para ponto
        S := StringReplace(S, ',', '.', [rfReplaceAll]);

        Val(S, DblValue, Code);
        if Code = 0 then // Conversão bem sucedida
        begin
          Value := DblValue;
        end;
      end;
    end;
    Row.AddCell(Value);
  end;
  Result := Self;
end;

function TXLSWorksheet.AddDataFromStrings(Strings: TStrings): TXLSWorksheet;
var
  I: Integer;
  Row: TXLSRow;
begin
  for I := 0 to Strings.Count - 1 do
  begin
    Row := AddRow;
    Row.AddCell(Strings[I]);
  end;
  Result := Self;
end;

{ TXLSWorkbook }

constructor TXLSWorkbook.Create;
begin
  inherited;
  FWorksheets := TObjectList<TXLSWorksheet>.Create(True);
  FStyles := TObjectList<TXLSCellStyle>.Create(True);
  FAuthor := '';
  FCompany := '';
  FCreated := Now;

  // Cria estilo padrão brasileiro
  GetDefaultStyle;
end;

destructor TXLSWorkbook.Destroy;
begin
  FStyles.Free;
  FWorksheets.Free;
  inherited;
end;

procedure TXLSWorkbook.AddAjustaFormatoNumerico(
  AjustaFormatoNumerico: TAjustaFormatoNumerico);
begin
  SetLength(FArrAjustaFormatoNumerico, succ(high(FArrAjustaFormatoNumerico)) +1);
  FArrAjustaFormatoNumerico[high(FArrAjustaFormatoNumerico)] := AjustaFormatoNumerico;
end;

function TXLSWorkbook.AddWorksheet(const AName: string): TXLSWorksheet;
var
  WSName: string;
  Count: Integer;
begin
  WSName := AName;
  if WSName = '' then
    WSName := 'Planilha' + IntToStr(FWorksheets.Count + 1);

  // Garante nome único
  Count := 1;
  while GetWorksheet(WSName) <> nil do
  begin
    Inc(Count);
    WSName := AName + ' (' + IntToStr(Count) + ')';
  end;

  Result := TXLSWorksheet.Create(WSName);
  FWorksheets.Add(Result);
end;

function TXLSWorkbook.GetWorksheet(Index: Integer): TXLSWorksheet;
begin
  if (Index >= 0) and (Index < FWorksheets.Count) then
    Result := FWorksheets[Index]
  else
    Result := nil;
end;

function TXLSWorkbook.GetWorksheet(const AName: string): TXLSWorksheet;
var
  I: Integer;
begin
  for I := 0 to FWorksheets.Count - 1 do
  begin
    if SameText(FWorksheets[I].Name, AName) then
      Exit(FWorksheets[I]);
  end;
  Result := nil;
end;

function TXLSWorkbook.MontaAjustaFormatoNumerico(Coluna: integer;
  Formato: String; PosicaoInicial,
  PosicaoFinal: integer): TAjustaFormatoNumerico;
begin
  Result.Coluna := Coluna;
  Result.Formato := Formato;
  Result.PosicaoFinal := PosicaoFinal;
  Result.PosicaoInicial := PosicaoInicial;
end;

procedure TXLSWorkbook.protegerPlanilha(const FileName: string; Bloquear: Boolean = false; protegerEstrutura : Boolean = False; Senha: string = '');
var FExcel: TExcel;
begin
  FExcel := TExcel.fCriarExcel(nil);
  FExcel.blnShowOnTerminate := False;
  FExcel.AbrirArquivo(FileName);
  {If High(FArrAjustaFormatoNumerico) > -1 then
    For i := 0 To  High(FArrAjustaFormatoNumerico) do
    begin
      FExcel.FormatoNumericoRange(FArrAjustaFormatoNumerico[i].Coluna,
                                  FArrAjustaFormatoNumerico[i].Formato,
                                  FArrAjustaFormatoNumerico[i].PosicaoInicial,
                                  FArrAjustaFormatoNumerico[i].PosicaoFinal);
    end;}

  if Bloquear then
    FExcel.ProtegerPlanilha(Senha);
  If protegerEstrutura Then
  Begin
    //protege a planilha com senha
    FExcel.ProtegerEstrutura(Senha);
  End;

  FExcel.SalvarArquivo(True, True, Senha);
  FExcel.FecharArquivo;
end;

function TXLSWorkbook.WorksheetCount: Integer;
begin
  Result := FWorksheets.Count;
end;

function TXLSWorkbook.CreateStyle: TXLSCellStyle;
var id: integer;
begin
  Result := TXLSCellStyle.Create;
  id := FStyles.Count + 1;
  Result.Name := 'stl' + id.ToString;
  FStyles.Add(Result);
end;

function TXLSWorkbook.GetDefaultStyle: TXLSCellStyle;
begin
  if FStyles.Count = 0 then
  begin
    Result := CreateStyle;
    Result.SetFontName('Calibri')
          .SetFontSize(11)
          .SetFontColor(TXLSColor.FromTColor(clBlack))
          .SetBgColor(TXLSColor.FromTColor(clWhite))
          .SetNumberFormat('Geral') // Padrão brasileiro
          .SetProtected(True);
  end
  else
    Result := FStyles[0];
end;

function TXLSWorkbook.GetHeaderStyle: TXLSCellStyle;
begin
  Result := CreateStyle;
  Result.SetFontName('Calibri')
        .SetFontSize(12)
        .SetFontBold(True)
        .SetFontColor(TXLSColor.FromTColor(clWhite))
        .SetBgColor(TXLSColor.FromWebColor('darkblue'))
        .SetAlignment(alCenter)
        .SetVerticalAlignment(vaCenter)
        .SetBorders(bsThin, TXLSColor.FromTColor(clWhite));
end;

function TXLSWorkbook.GetCurrencyStyle: TXLSCellStyle;
begin
  Result := CreateStyle;
  // Formato brasileiro para moeda: R$ 1.234,56 com negativo em vermelho
  Result.SetNumberFormat('"R$" #.##0,00;[Vermelho]"R$" -#.##0,00')
        .SetAlignment(alRight);
end;

function TXLSWorkbook.GetPercentStyle: TXLSCellStyle;
begin
  Result := CreateStyle;
  // Formato brasileiro para percentual: 12,34% com negativo em vermelho
  Result.SetNumberFormat('0,00%;[Vermelho]-0,00%')
        .SetAlignment(alRight);
end;

function TXLSWorkbook.GetDateStyle: TXLSCellStyle;
begin
  Result := CreateStyle;
  // Formato brasileiro para data: DD/MM/AAAA
  Result.SetNumberFormat('dd/mm/aaaa')
        .SetAlignment(alCenter);
end;

function TXLSWorkbook.GetTimeStyle: TXLSCellStyle;
begin
  Result := CreateStyle;
  Result.SetNumberFormat('hh:mm:ss')
        .SetAlignment(alCenter);
end;

function TXLSWorkbook.GetDateTimeStyle: TXLSCellStyle;
begin
  Result := CreateStyle;
  Result.SetNumberFormat('dd/mm/aaaa hh:mm:ss')
        .SetAlignment(alCenter);
end;

function TXLSWorkbook.GetHyperlinkStyle: TXLSCellStyle;
begin
  Result := CreateStyle;
  Result.SetFontColor(TXLSColor.FromTColor(clBlue))
        .SetFontUnderline(True);
end;

function TXLSWorkbook.GetTextStyle: TXLSCellStyle;
begin
  Result := CreateStyle;
  Result.SetNumberFormat('@') // @ é o código para texto no Excel
        .SetAlignment(alLeft);
end;

function TXLSWorkbook.GetNumberStyle(ADecimals: Integer = 2; AUseThousandSeparator: Boolean = True): TXLSCellStyle;
var
  FormatStr: string;
begin
  Result := CreateStyle;

  if AUseThousandSeparator then
    FormatStr := '#.##0'
  else
    FormatStr := '0';

  if ADecimals > 0 then
    FormatStr := FormatStr + ',' + StringOfChar('0', ADecimals);

  // Adiciona formato para números negativos em vermelho
  Result.SetNumberFormat(FormatStr + ';[Vermelho]-' + FormatStr)
        .SetAlignment(alRight);
end;

function TXLSWorkbook.GetNumberFormatCode(const AFormat: string): string;
begin
  // Converte códigos de formato brasileiros para formato Excel XML
  Result := AFormat;

  // Substitui termos em português por equivalentes em inglês para o XML
  Result := StringReplace(Result, '[Vermelho]', '[Red]', [rfReplaceAll]);
  Result := StringReplace(Result, 'Geral', 'General', [rfReplaceAll]);

  // A vírgula como separador decimal já é aceita pelo Excel
  // O ponto como separador de milhar também é aceito
end;

function TXLSWorkbook.EscapeXML(const Text: string): string;
begin
  Result := Text;
  Result := StringReplace(Result, '&', '&amp;', [rfReplaceAll]);
  Result := StringReplace(Result, '<', '&lt;', [rfReplaceAll]);
  Result := StringReplace(Result, '>', '&gt;', [rfReplaceAll]);
  Result := StringReplace(Result, '"', '&quot;', [rfReplaceAll]);
  Result := StringReplace(Result, '''', '&apos;', [rfReplaceAll]);
end;

function TXLSWorkbook.VariantToXMLValue(Value: Variant; CellType: TXLSCellType): string;
var
  S: string;
begin
  if VarIsNull(Value) or VarIsEmpty(Value) then
    Exit('');

  case CellType of
    ctString:
      Result := EscapeXML(VarToStr(Value));

    ctNumber:
      begin
        // Para o XML do Excel, precisamos usar ponto decimal nos valores
        // mesmo que a exibição seja com vírgula
        if VarIsFloat(Value) then
        begin
          // Converte número para string com ponto decimal (padrão internacional)
          Result := FloatToStr(Value, TFormatSettings.Invariant);
        end
        else if VarIsNumeric(Value) then
        begin
          // Para outros tipos numéricos
          S := VarToStr(Value);
          Result := S;
        end
        else
        begin
          Result := EscapeXML(VarToStr(Value));
        end;
      end;

    ctDateTime:
      // Excel espera formato ISO para datas no XML
      Result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', VarToDateTime(Value));

    ctBoolean:
      begin
        // Correção para versões mais antigas do Delphi
        try
          if VarType(Value) = varBoolean then
          begin
            if Value = True then
              Result := 'TRUE'
            else
              Result := 'FALSE';
          end
          else
          begin
            S := VarToStr(Value);
            if SameText(S, 'true') or SameText(S, '1') or SameText(S, 'sim') or SameText(S, 'yes') then
              Result := 'TRUE'
            else
              Result := 'FALSE';
          end;
        except
          Result := 'FALSE';
        end;
      end;

    ctFormula:
      Result := EscapeXML(VarToStr(Value));

    else
      Result := EscapeXML(VarToStr(Value));
  end;
end;

function TXLSWorkbook.GetBorderStyleName(AStyle: TXLSBorderStyle): string;
begin
  case AStyle of
    bsNone: Result := 'None';
    bsThin: Result := 'Continuous';
    bsMedium: Result := 'Continuous';
    bsThick: Result := 'Continuous';
    bsDashed: Result := 'Dash';
    bsDotted: Result := 'Dot';
    else Result := 'None';
  end;
end;

function TXLSWorkbook.GetFillPatternName(APattern: TXLSFillPattern): string;
begin
  case APattern of
    fpSolid: Result := 'Solid';
    fpGray75: Result := 'Gray75';
    fpGray50: Result := 'Gray50';
    fpGray25: Result := 'Gray25';
    fpGray125: Result := 'Gray125';
    fpGray0625: Result := 'Gray0625';
    else Result := 'Solid';
  end;
end;

function TXLSWorkbook.GetAlignmentName(AAlign: TXLSAlignment): string;
begin
  case AAlign of
    alLeft: Result := 'Left';
    alCenter: Result := 'Center';
    alRight: Result := 'Right';
    else Result := 'General';
  end;
end;

function TXLSWorkbook.GetVerticalAlignmentName(AAlign: TXLSVerticalAlignment): string;
begin
  case AAlign of
    vaTop: Result := 'Top';
    vaCenter: Result := 'Center';
    else Result := 'Bottom';
  end;
end;

function TXLSWorkbook.GenerateXML: TStrings;
var
  XML: TStringList;
  I, J, K: Integer;
  WS: TXLSWorksheet;
  Row: TXLSRow;
  Cell: TXLSCell;
  S: string;
  CellAttributes: string;
  FormatCode: string;
begin
  XML := TStringList.Create;
  try
    XML.DefaultEncoding := TEncoding.UTF8;

    // Cabeçalho XML
    XML.Add('<?xml version="1.0" encoding="UTF-8"?>');
    XML.Add('<?mso-application progid="Excel.Sheet"?>');
    XML.Add('<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"');
    XML.Add('          xmlns:o="urn:schemas-microsoft-com:office:office"');
    XML.Add('          xmlns:x="urn:schemas-microsoft-com:office:excel"');
    XML.Add('          xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"');
    XML.Add('          xmlns:html="http://www.w3.org/TR/REC-html40">');

    // Document Properties
    if (FAuthor <> '') or (FCompany <> '') then
    begin
      XML.Add('<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">');
      if FAuthor <> '' then
        XML.Add('  <Author>' + EscapeXML(FAuthor) + '</Author>');
      if FCompany <> '' then
        XML.Add('  <Company>' + EscapeXML(FCompany) + '</Company>');
      XML.Add('  <Created>' + FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', FCreated) + '</Created>');
      XML.Add('</DocumentProperties>');
    end;

    // Estilos
    XML.Add('<Styles>');

    // Estilo padrão (Geral)
    XML.Add('  <Style ss:ID="Default" ss:Name="Normal">');
    XML.Add('    <Alignment ss:Vertical="Bottom"/>');
    XML.Add('    <Borders/>');
    XML.Add('    <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>');
    XML.Add('    <Interior/>');
    XML.Add('    <NumberFormat/>');
    XML.Add('    <Protection ss:Protected="1"/>');
    XML.Add('  </Style>');

    // Outros estilos
    for I := 0 to FStyles.Count - 1 do
    begin
      XML.Add('  <Style ss:ID="' + FStyles[I].Name + '">');

      // Fonte
      S := '    <Font ss:FontName="' + EscapeXML(FStyles[I].FontName) + '"';
      S := S + ' ss:Size="' + IntToStr(FStyles[I].FontSize) + '"';
      S := S + ' ss:Color="' + FStyles[I].FontColor.ToHex + '"';
      if FStyles[I].FontBold then S := S + ' ss:Bold="1"';
      if FStyles[I].FontItalic then S := S + ' ss:Italic="1"';
      if FStyles[I].FontUnderline then S := S + ' ss:Underline="Single"';
      S := S + '/>';
      XML.Add(S);

      // Alinhamento
      if (FStyles[I].Alignment <> alGeneral) or (FStyles[I].VerticalAlignment <> vaBottom) or FStyles[I].WrapText then
      begin
        S := '    <Alignment';
        if FStyles[I].Alignment <> alGeneral then
          S := S + ' ss:Horizontal="' + GetAlignmentName(FStyles[I].Alignment) + '"';
        if FStyles[I].VerticalAlignment <> vaBottom then
          S := S + ' ss:Vertical="' + GetVerticalAlignmentName(FStyles[I].VerticalAlignment) + '"';
        if FStyles[I].WrapText then
          S := S + ' ss:WrapText="1"';
        S := S + '/>';
        XML.Add(S);
      end;


      // Bordas
      if (FStyles[I].BorderLeft <> bsNone) or (FStyles[I].BorderTop <> bsNone) or
         (FStyles[I].BorderRight <> bsNone) or (FStyles[I].BorderBottom <> bsNone) then
      begin
        XML.Add('    <Borders>');
        if FStyles[I].BorderLeft <> bsNone then
          XML.Add('      <Border ss:Position="Left" ss:LineStyle="' +
                  GetBorderStyleName(FStyles[I].BorderLeft) +
                  '" ss:Weight="1" ss:Color="' + FStyles[I].FBorderColor.ToHex + '"/>');
        if FStyles[I].BorderTop <> bsNone then
          XML.Add('      <Border ss:Position="Top" ss:LineStyle="' +
                  GetBorderStyleName(FStyles[I].BorderTop) +
                  '" ss:Weight="1" ss:Color="' + FStyles[I].FBorderColor.ToHex + '"/>');
        if FStyles[I].BorderRight <> bsNone then
          XML.Add('      <Border ss:Position="Right" ss:LineStyle="' +
                  GetBorderStyleName(FStyles[I].BorderRight) +
                  '" ss:Weight="1" ss:Color="' + FStyles[I].FBorderColor.ToHex + '"/>');
        if FStyles[I].BorderBottom <> bsNone then
          XML.Add('      <Border ss:Position="Bottom" ss:LineStyle="' +
                  GetBorderStyleName(FStyles[I].BorderBottom) +
                  '" ss:Weight="1" ss:Color="' + FStyles[I].FBorderColor.ToHex + '"/>');
        XML.Add('    </Borders>');
      end;

      // Fundo
      if (FStyles[I].BgColor.R <> 255) or (FStyles[I].BgColor.G <> 255) or (FStyles[I].BgColor.B <> 255) or
         (FStyles[I].FFillPattern <> fpSolid) then
      begin
        XML.Add('    <Interior ss:Color="' + FStyles[I].BgColor.ToHex +
                '" ss:Pattern="' + GetFillPatternName(FStyles[I].FFillPattern) + '"/>');
      end;

      // Formato de número
      if FStyles[I].NumberFormat <> '' then
      begin
        FormatCode := GetNumberFormatCode(FStyles[I].NumberFormat);
//        XML.Add('    <NumberFormat ss:Format="[$-416]' + EscapeXML(FormatCode) + '"/>');
        XML.Add('    <NumberFormat ss:Format="' + EscapeXML(FormatCode) + '"/>');
      end;

      // Proteção
      if FStyles[I].Protected then
        XML.Add('    <Protection ss:Protected="1"/>')
      else
        XML.Add('    <Protection ss:Protected="0"/>');

      XML.Add('  </Style>');
    end;

    XML.Add('</Styles>');

    // Planilhas
    for I := 0 to FWorksheets.Count - 1 do
    begin
      WS := FWorksheets[I];
      If WS.&Protected then
        XML.Add('<Worksheet ss:Name="' + EscapeXML(WS.Name) + '"  ss:Protected="1">')
      Else
        XML.Add('<Worksheet ss:Name="' + EscapeXML(WS.Name) + '">');
      XML.Add('<Table>');

      // Definir larguras das colunas
      for J := 0 to Length(WS.FColumnWidths) - 1 do
      begin
        if WS.FColumnWidths[J] > 0 then
          XML.Add('  <Column ss:Index="' + IntToStr(J + 1) + '" ss:Width="' +
                  FloatToStr(WS.FColumnWidths[J], TFormatSettings.Invariant) + '"/>');
      end;

      // Linhas e células
      for J := 0 to WS.RowCount - 1 do
      begin
        Row := WS.Rows[J];

        // Abrir linha
        if Row.Height <> 15 then
          XML.Add('  <Row ss:Height="' + FloatToStr(Row.Height, TFormatSettings.Invariant) + '">')
        else
          XML.Add('  <Row>');

        // Células
        for K := 0 to Row.CellCount - 1 do
        begin
          Cell := Row.Cells[K];

          // Atributos da célula
          CellAttributes := '';

          // Estilo
          if Cell.Style <> nil then
          begin
            CellAttributes := CellAttributes + ' ss:StyleID="'+ Cell.Style.Name + '"';
          end;

          // Merge
          if Cell.MergeAcross > 0 then
            CellAttributes := CellAttributes + ' ss:MergeAcross="' + IntToStr(Cell.MergeAcross) + '"';
          if Cell.MergeDown > 0 then
            CellAttributes := CellAttributes + ' ss:MergeDown="' + IntToStr(Cell.MergeDown) + '"';

          // Tipo da célula
          S := '';
          case Cell.CellType of
            ctString: S := 'String';
            ctNumber: S := 'Number';
            ctDateTime: S := 'DateTime';
            ctBoolean: S := 'Boolean';
            ctFormula: S := 'String'; // Excel trata fórmulas como string no XML
          end;

          // Valor da célula
          if Cell.CellType = ctFormula then
          begin
            XML.Add('    <Cell' + CellAttributes + '>');
            XML.Add('      <Data ss:Type="' + S + '">' + EscapeXML(Cell.Formula) + '</Data>');
            XML.Add('    </Cell>');
          end
          else if not VarIsNull(Cell.Value) and not VarIsEmpty(Cell.Value) then
          begin
            XML.Add('    <Cell' + CellAttributes + '>');
            XML.Add('      <Data ss:Type="' + S + '">' +
                    VariantToXMLValue(Cell.Value, Cell.CellType) + '</Data>');
            XML.Add('    </Cell>');
          end
          else
          begin
            // Célula vazia
            XML.Add('    <Cell' + CellAttributes + '/>');
          end;
        end;

        // Fechar linha
        XML.Add('  </Row>');
      end;

      XML.Add('</Table>');

      // Opções da planilha (proteção)
      if WS.Protected then
      begin
        XML.Add('<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">');
        XML.Add('  <ProtectContents>True</ProtectContents>');
        XML.Add('  <ProtectObjects>True</ProtectObjects>');
        XML.Add('  <ProtectScenarios>True</ProtectScenarios>');
        if WS.FPassword <> '' then
          XML.Add('  <Password>' + EscapeXML(WS.FPassword) + '</Password>');
        XML.Add('</WorksheetOptions>');
      end;

      XML.Add('</Worksheet>');
    end;

    XML.Add('</Workbook>');

    Result := XML;
  except
    XML.Free;
    raise;
  end;
end;

procedure TXLSWorkbook.SaveToFile(const FileName: string; BloquearCelulas: Boolean = false; protegerEstrutura : Boolean = False; Senha: string = '');
var
  XML: TStrings;
begin
  XML := GenerateXML;
  try
    XML.SaveToFile(FileName);
    If protegerEstrutura or BloquearCelulas then
      protegerPlanilha(FileName, BloquearCelulas, protegerEstrutura, Senha);
  finally
    XML.Free;
  end;
end;

procedure TXLSWorkbook.SaveToStream(Stream: TStream);
var
  XML: TStrings;
begin
  XML := GenerateXML;
  try
    XML.SaveToStream(Stream);
  finally
    XML.Free;
  end;
end;

function TXLSWorkbook.SaveToString: string;
var
  XML: TStrings;
begin
  XML := GenerateXML;
  try
    Result := XML.Text;
  finally
    XML.Free;
  end;
end;

procedure TXLSWorkbook.SetAuthor(const AAuthor: string);
begin
  FAuthor := AAuthor;
end;

procedure TXLSWorkbook.SetCompany(const ACompany: string);
begin
  FCompany := ACompany;
end;

procedure TXLSWorkbook.QuickExport(const FileName: string; Data: array of TArray<Variant>);
var
  WS: TXLSWorksheet;
  I, J: Integer;
  Row: TXLSRow;
begin
  WS := AddWorksheet('Dados');

  for I := 0 to High(Data) do
  begin
    Row := WS.AddRow;
    for J := 0 to High(Data[I]) do
      Row.AddCell(Data[I][J]);
  end;

  SaveToFile(FileName);
end;

procedure TXLSWorkbook.QuickExportBR(const FileName: string; Data: array of TArray<Variant>;
  AHeaders: array of string);
var
  WS: TXLSWorksheet;
  I, J: Integer;
  Row: TXLSRow;
  HeaderStyle, DataStyle: TXLSCellStyle;
begin
  WS := AddWorksheet('Dados');

  // Cria estilos brasileiros
  HeaderStyle := GetHeaderStyle;
  DataStyle := GetNumberStyle(2, True); // 2 casas decimais com separador de milhar

  // Adiciona cabeçalhos se fornecidos
  if Length(AHeaders) > 0 then
  begin
    Row := WS.AddRow;
    for J := 0 to High(AHeaders) do
      Row.AddCell(AHeaders[J]).SetStyle(HeaderStyle);
  end;

  // Adiciona dados
  for I := 0 to High(Data) do
  begin
    Row := WS.AddRow;
    for J := 0 to High(Data[I]) do
    begin
      Row.AddCell(Data[I][J]).SetStyle(DataStyle);
    end;
  end;

  // Ajusta larguras das colunas automaticamente
  for I := 0 to High(Data[0]) do
    WS.SetColumnWidth(I, 120); // Largura padrão

  SaveToFile(FileName);
end;

end.
