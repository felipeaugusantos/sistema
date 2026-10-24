unit untSpoolPrintDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, frxClass, ImgList, frxCtrls,
  frxPreview, untSpoolImpressao, untTypesSistema,
  System.ImageList, ComboBoxFocus, EditFocus, cxImageList, cxGraphics, dximctrl,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxGDIPlusClasses, cxGroupBox, cxTreeView;

type
  TSpoolPrintDialog = class(TForm)
    OkB: TButton;
    CancelB: TButton;
    PrintersP: TGroupBox;
    Label1: TGroupBox;
    DescrL: TLabel;
    AllRB: TRadioButton;
    CurPageRB: TRadioButton;
    PageNumbersRB: TRadioButton;
    PageNumbersE: TEditFocus;
    Label2: TGroupBox;
    CopiesL: TLabel;
    CopiesE: TEditFocus;
    UpDown1: TUpDown;
    imgIcones: TcxImageList;
    ExportToPDF: TCheckBox;
    GrayedScale: TCheckBox;
    Panel2: TPanel;
    cxGroupBox1: TcxGroupBox;
    Image1: TImage;
    FilterE: TEdit;
    PrintersCB: TcxTreeView;
    FilterT: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure PageNumbersRBClick(Sender: TObject);
    procedure PageNumbersEEnter(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ExportToPDFClick(Sender: TObject);
    procedure FilterEKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FilterEChange(Sender: TObject);
    procedure FilterTTimer(Sender: TObject);
  private
    FArrPontos: TArray<TPontoImpressao>;
  private
    procedure AddPrinter(AText: string; AImageIndex: Integer);
    function GetImageIndex(LSpooler: TPontoImpressao): Integer;
  public
    FReport: TfrxReport;
  end;

implementation

{$R *.DFM}

uses frxRes;

function FindNode(ATree: TcxTreeView; AValue: String; AVisible: Boolean): TTreeNode;
var
  Node: TTreeNode;
begin
  Result := nil;
  if ATree.Items.Count = 0 then
    Exit;
  Node := ATree.Items[0];
  while Node <> nil do
  begin
    if UpperCase(Node.Text) = UpperCase(AValue) then
    begin
      Result := Node;
      if AVisible then
        Result.MakeVisible;
      Break;
    end;
    Node := Node.GetNext;
  end;
end;

procedure TSpoolPrintDialog.AddPrinter(AText: string; AImageIndex: Integer);
begin
  with PrintersCB.Items.AddChild(nil, AText) do
  begin
    ImageIndex := AImageIndex;
    StateIndex :=  AImageIndex;
    SelectedIndex := AImageIndex;
    ExpandedImageIndex :=  AImageIndex;
  end;
end;

procedure TSpoolPrintDialog.FilterEChange(Sender: TObject);
begin
  FilterT.Enabled := False;
  FilterT.Enabled := True;
end;

procedure TSpoolPrintDialog.FilterEKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_DOWN, VK_RETURN: ActiveControl := (PrintersCB);
  End;
end;

procedure TSpoolPrintDialog.FilterTTimer(Sender: TObject);
var
  LWords: TArray<string>;
  LText: string;
  LAccept: Boolean;
  LSpooler: TPontoImpressao;
begin
  PrintersCB.Items.BeginUpdate;
  PrintersCB.Items.Clear;
  FilterT.Enabled := False;
  LText := Trim(FilterE.Text);
  while LText.Contains('  ') do
    LText  := LText.Replace('  ', ' ');
  LWords := LText.Split([' ']);
  for LSpooler in FArrPontos do
  begin
    LAccept := True;
    for LText in LWords do
      if not LSpooler.NomeFila.ToUpper.Contains(LText.ToUpper) then
        LAccept := False;
    if LAccept then
      AddPrinter(LSpooler.NomeFila, GetImageIndex(LSpooler));
  end;
  PrintersCB.Selected := PrintersCB.Items.GetFirstNode;
  PrintersCB.Items.EndUpdate;
end;

procedure TSpoolPrintDialog.ExportToPDFClick(Sender: TObject);
var
  LSpooler: TPontoImpressao;
begin
  FilterE.Clear;
  FilterT.Enabled := False;
  PrintersCB.Items.BeginUpdate;
  PrintersCB.Items.Clear;
  if ExportToPDF.Checked then
  begin
    for LSpooler in FArrPontos do
      if LSpooler.ExportacaoPDF and LSpooler.ExibirSomenteMaquinaServico then
        if LSpooler.ExportacaoPDF then
          AddPrinter(LSpooler.NomeFila, GetImageIndex(LSpooler));
    if PrintersCB.Items.Count = 0 then
      AddPrinter(TSpoolImpressaoCitel.PontoExportarPDF, 1);
    GrayedScale.Checked := False;
    CopiesE.Text := '1';
    PrintersCB.Selected := PrintersCB.Items.GetFirstNode;
  end
  else
  begin
    for LSpooler in FArrPontos do
      AddPrinter(LSpooler.NomeFila, GetImageIndex(LSpooler));
    PrintersCB.Selected := FindNode(PrintersCB, FReport.PrintOptions.Printer, False);
  end;
  FilterE.Enabled := not ExportToPDF.Checked;
  PrintersCB.Enabled := not ExportToPDF.Checked;
  GrayedScale.Enabled := not ExportToPDF.Checked;
  CopiesE.Enabled := not ExportToPDF.Checked;
  if (PrintersCB.Selected = nil) And (PrintersCB.Items.Count > 0) then
    PrintersCB.Selected := PrintersCB.Items.GetFirstNode;
  PrintersCB.Items.EndUpdate;
end;

procedure TSpoolPrintDialog.FormCreate(Sender: TObject);
var
  LSpooler: TPontoImpressao;
begin
  FArrPontos := TSpoolImpressaoCitel.fGetPontosImpressao;
  PrintersCB.Items.BeginUpdate;
  PrintersCB.Items.Clear;
  for LSpooler in FArrPontos do
    AddPrinter(LSpooler.NomeFila, GetImageIndex(LSpooler));
  if Screen.PixelsPerInch > 96 then
    PrintersCB.ItemHeight := 19;
  PrintersCB.Items.EndUpdate;
end;

procedure TSpoolPrintDialog.FormShow(Sender: TObject);
begin
  PrintersCB.Selected := FindNode(PrintersCB, FReport.PrintOptions.Printer, False);
  if (PrintersCB.Selected = nil) And (PrintersCB.Items.Count > 0) then
    PrintersCB.Selected := PrintersCB.Items.GetFirstNode;
  UpDown1.Position := FReport.PrintOptions.Copies;
end;

function TSpoolPrintDialog.GetImageIndex(LSpooler: TPontoImpressao): Integer;
begin
  if LSpooler.ExportacaoPDF then
    Exit(1);
  if LSpooler.ImprimirParaArquivo then
    Exit(2);
  Result := 0;
end;

procedure TSpoolPrintDialog.FormHide(Sender: TObject);
begin
  if ModalResult = mrOk then
  begin
    if CopiesE.Text <> '' then
      FReport.PrintOptions.Copies := StrToInt(CopiesE.Text)
    else
      FReport.PrintOptions.Copies := 1;

    if AllRB.Checked then
      FReport.PrintOptions.PageNumbers := ''
    else if CurPageRB.Checked then
      FReport.PrintOptions.PageNumbers := TfrxPreviewForm(FReport.PreviewForm)
        .PageE.Text
    else
      FReport.PrintOptions.PageNumbers := PageNumbersE.Text;
  end;
end;

procedure TSpoolPrintDialog.PageNumbersEEnter(Sender: TObject);
begin
  PageNumbersRB.Checked := True;
end;

procedure TSpoolPrintDialog.PageNumbersRBClick(Sender: TObject);
begin
  if Visible then
    PageNumbersE.SetFocus;
end;

end.
