unit untWordOfc;

interface

uses Classes, Dialogs, ComObj, Variants, WordXP, untWord, SysUtils, Vcl.Forms;

type
  TWordOfc = Class(TWord)
  private
    varTables: Array of Variant;
    varRange: Variant;
    FNomArq: String;
  protected

  public
    procedure pGoToPageHeader; Override;
    procedure pGoToMainDocument; Override;
    procedure pGoToPageFooter; Override;
    procedure pInsereImagem(strPath: String); overload; Override;
    procedure pInsereImagem(strPath: String; strSearcStringImagem: String); overload; Override;
    procedure pReplace(strOri, strDes: String); Override;
    procedure pCriaTabela(strChave: String; intQtdLin, intQtdCol: Integer); Override;
    procedure pCelulaNegrito(intLinha, intColuna: Integer); Override;
    procedure pOtimizaTamanho(intLinha, intColuna, intTamanho : Integer); Override;
    procedure pCelulaEscreve(intLinha, intColuna: Integer; strTexto: String); Override;
    procedure pCelulaAlignRight(intLinha, intColuna: Integer); Override;
    procedure pSalvar; Override;
    procedure pSetarImpressora(strPrinter: String); Override;
    procedure pPrint; Override;
    procedure pFechar; Override;
    procedure pSaveAsHtml;Override;
    function AbrirArquivo(Nome_Arquivo: String): Boolean; Override;
    procedure SaveAsPDF(const ATargetFileURL: string);Override;
    procedure pCelulaAlignCenter(intLinha, intColuna: Integer); Override;
  end;

implementation

{ TWordOfc }

function TWordOfc.AbrirArquivo(Nome_Arquivo: String): Boolean;
begin

  Result := False;
  If FileExists(Nome_Arquivo) Then
  Begin
    FWord := CreateOleObject('Word.Application');
    FWord.Visible := False;

    Documento := FWord.Documents;
    Documento := Documento.Open(Nome_Arquivo);
    Texto     := FWord.Selection;
    varRange  := Texto.Range;

    FNomArq := Nome_Arquivo;
    Result  := True;
  End;

end;

procedure TWordOfc.SaveAsPDF(const ATargetFileURL: string);
const
  wdExportFormatPDF = 17;
begin
  Documento.ExportAsFixedFormat(ATargetFileURL, wdExportFormatPDF);
end;


procedure TWordOfc.pCelulaAlignRight(intLinha, intColuna: Integer);
var
  i: Integer;
begin
  inherited;
  For i := Low(varTables) To High(varTables) Do
    varTables[i].Cell(intLinha, intColuna).Range.ParagraphFormat.Alignment := 2;
end;

procedure TWordOfc.pCelulaAlignCenter(intLinha, intColuna: Integer);
var
  i: Integer;
begin
  inherited;
  For i := Low(varTables) To High(varTables) Do
    varTables[i].Cell(intLinha, intColuna).Range.ParagraphFormat.Alignment := 1;
end;

procedure TWordOfc.pCelulaEscreve(intLinha, intColuna: Integer; strTexto: String);
var
  i: Integer;
  cellRange: Variant;
begin
  inherited;

  for i := Low(varTables) to High(varTables) do
  begin
    if not VarIsEmpty(varTables[i]) then
    begin
      cellRange := varTables[i].Cell(intLinha, intColuna).Range;
      cellRange.SetRange(cellRange.Start, cellRange.End - 1);
      cellRange.Font.Size := 7;
      cellRange.InsertAfter(strTexto);
      cellRange.Application.ScreenRefresh;
      Sleep(50);
      Application.ProcessMessages;
    end;
  end;
end;


procedure TWordOfc.pCelulaNegrito(intLinha, intColuna: Integer);
var
  i: Integer;
begin
  inherited;
  For i := Low(varTables) To High(varTables) Do
    varTables[i].Cell(intLinha, intColuna).Range.Font.Bold := 1;
end;

procedure TWordOfc.pOtimizaTamanho(intLinha, intColuna, intTamanho : Integer);
var
  i: Integer;
begin
  //***************************************************************//
  // O parâmetro intLinha não é usado aqui, somente no OpenOffice. //
  // Aqui usa o intTamanho para definir o tamanho da coluna.       //
  //***************************************************************//
  inherited;
  For i := Low(varTables) To High(varTables) Do
    varTables[i].Columns.Item(intColuna).Width:=intTamanho;

end;

procedure TWordOfc.pCriaTabela(strChave: String; intQtdLin, intQtdCol: Integer);
begin
  inherited;

  blnTabelaCriada := False;
  If Not (Trim(strChave) = '') Then
  Begin
    SetLength(varTables, 0);
    While varRange.Find.Execute(strChave) Do
    Begin
      varRange.Select;
      SetLength(varTables, Length(varTables) + 1);
      varTables[High(varTables)] := FWord.ActiveDocument.Tables.Add(Range := Texto.Range, NumRows := intQtdLin, NumColumns := intQtdCol);
      blnTabelaCriada := True;
    End;
  End;
end;

procedure TWordOfc.pSaveAsHtml;
begin
  Documento.saveAs( ChangeFileExt(FNomArq, '.html') , wdFormatHTML,   AddToRecentFiles := False);
end;

procedure TWordOfc.pFechar;
begin
  inherited;
  FWord.Quit;
end;

procedure TWordOfc.pGoToMainDocument;
begin
  inherited;
  FWord.ActiveWindow.ActivePane.View.SeekView := wdSeekMainDocument;
  varRange := Texto.Range;
end;

procedure TWordOfc.pGoToPageFooter;
begin
  inherited;
  FWord.ActiveWindow.ActivePane.View.SeekView := wdSeekCurrentPageFooter;
  varRange := Texto.Range;
end;

procedure TWordOfc.pGoToPageHeader;
begin
  inherited;
  FWord.ActiveWindow.ActivePane.View.SeekView := wdSeekCurrentPageHeader;
  varRange := Texto.Range;
end;

procedure TWordOfc.pInsereImagem(strPath: String; strSearcStringImagem: String);
  Var
    varLogo: Variant;
begin
  inherited;

  If FileExists(strPath) Then
  Begin
    If varRange.Find.Execute(strSearcStringImagem) Then
    Begin
      varRange.Select;

      varLogo := FWord.Selection.InlineShapes.AddPicture(strPath);
      varLogo.Width  := 136.05;
      varLogo.Height :=  70.85;

      {*************************************}
      {* SUBSTITUI OS TEXTOS DO CABEÇALHO  *}
      {**********************************RV*}
      varRange.Find.Execute(strSearcStringImagem, '2', EmptyParam, EmptyParam, EmptyParam,
                            EmptyParam, EmptyParam, EmptyParam, EmptyParam,
                            '', '2', EmptyParam, EmptyParam, EmptyParam, EmptyParam);
    End;
  End;
end;

procedure TWordOfc.pInsereImagem(strPath: String);
begin
  pInsereImagem(strPath, '{{IMAGEM}}');
end;

procedure TWordOfc.pPrint;
begin
  inherited;
  Documento.PrintOut(False);
end;

procedure TWordOfc.pReplace(strOri, strDes: String);
begin
  inherited;
  varRange.Find.Execute(strOri, '2', EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
                        strDes, '2', EmptyParam, EmptyParam, EmptyParam, EmptyParam);
end;

procedure TWordOfc.pSalvar;
begin
  inherited;
  Documento.SaveAs;
end;

procedure TWordOfc.pSetarImpressora(strPrinter: String);
begin
  inherited;
  Documento.Application.ActivePrinter := strPrinter;
end;

end.
