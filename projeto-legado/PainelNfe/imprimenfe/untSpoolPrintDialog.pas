unit untSpoolPrintDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, frxClass, ImgList, frxCtrls,
  frxPreview, untSpoolImpressao,
  {$IFDEF VER270}

  {$ELSE}
  System.ImageList,
  {$ENDIF}

  {$IFDEF VER300}
  cxImageList,
  {$ENDIF} 
  
  ComboBoxFocus, EditFocus, cxGraphics;

type
  TSpoolPrintDialog = class(TForm)
    OkB: TButton;
    CancelB: TButton;
    Label12: TGroupBox;
    PrintersCB: TComboBoxFocus;
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
    NameL: TLabel;
    ExportToPDF: TCheckBox;
    imgIcones: TcxImageList;
    procedure PrintersCBDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure FormCreate(Sender: TObject);
    procedure PageNumbersRBClick(Sender: TObject);
    procedure PageNumbersEEnter(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ExportToPDFClick(Sender: TObject);
  private
    FArrPontos: TArray<TSpoolImpressaoCitel.TPontoImpressao>;
  public
    FReport: TfrxReport;
  end;

implementation

{$R *.DFM}

uses frxRes;

procedure TSpoolPrintDialog.ExportToPDFClick(Sender: TObject);
var
  LSpooler: TSpoolImpressaoCitel.TPontoImpressao;
begin
  PrintersCB.Items.Clear;
  if ExportToPDF.Checked then
  begin
    for LSpooler in FArrPontos do
      if LSpooler.ExportacaoPDF and LSpooler.ExibirSomenteMaquinaServico then
        PrintersCB.Items.Add(LSpooler.NomeFila);
    if PrintersCB.Items.Count = 0 then
      PrintersCB.Items.Add(TSpoolImpressaoCitel.PontoExportarPDF);
    CopiesE.Text := '1';
    PrintersCB.ItemIndex := 0;
  end
  else
  begin
    for LSpooler in FArrPontos do
      PrintersCB.Items.Add(LSpooler.NomeFila);
    PrintersCB.ItemIndex := PrintersCB.Items.IndexOf(FReport.PrintOptions.Printer);
  end;
  PrintersCB.Enabled := not ExportToPDF.Checked;
  CopiesE.Enabled := not ExportToPDF.Checked;
  if (PrintersCB.ItemIndex = -1) And (PrintersCB.Items.Count > 0) then
    PrintersCB.ItemIndex := 0;
end;

procedure TSpoolPrintDialog.FormCreate(Sender: TObject);
var
  LSpooler: TSpoolImpressaoCitel.TPontoImpressao;
begin
  FArrPontos := TSpoolImpressaoCitel.fGetPontosImpressao;
  for LSpooler in FArrPontos do
    PrintersCB.Items.Add(LSpooler.NomeFila);
  if Screen.PixelsPerInch > 96 then
    PrintersCB.ItemHeight := 19;
end;

procedure TSpoolPrintDialog.FormShow(Sender: TObject);
begin
  PrintersCB.ItemIndex := PrintersCB.Items.IndexOf
    (FReport.PrintOptions.Printer);
  if (PrintersCB.ItemIndex = -1) And (PrintersCB.Items.Count > 0) then
    PrintersCB.ItemIndex := 0;
  UpDown1.Position := FReport.PrintOptions.Copies;
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

procedure TSpoolPrintDialog.PrintersCBDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var
  LSpooler: TSpoolImpressaoCitel.TPontoImpressao;
  LIndex: Integer;
begin
  with PrintersCB.Canvas do
  begin
    LIndex := 0;
    for LSpooler in FArrPontos do
      if LSpooler.NomeFila.Equals(PrintersCB.Items[Index]) and LSpooler.ExportacaoPDF then
        LIndex := 1;
    if TSpoolImpressaoCitel.PontoExportarPDF.Equals(PrintersCB.Items[Index]) then
      LIndex := 1;
    FillRect(ARect);
    imgIcones.Draw(PrintersCB.Canvas, ARect.Left + 2, ARect.Top, LIndex);
    TextOut(ARect.Left + 24, ARect.Top + 1, PrintersCB.Items[Index]);
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
