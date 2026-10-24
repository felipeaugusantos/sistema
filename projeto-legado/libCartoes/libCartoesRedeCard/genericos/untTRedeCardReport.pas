unit untTRedeCardReport;

interface

Uses System.Classes, Vcl.Dialogs, Vcl.AppEvnts, WinApi.Windows, System.SysUtils,
     Winapi.ShellAPI, WinAPI.Messages,

     frxClass, frxExportPDF, frxPreview,

     untLibCartoesInterfacesTipos;

type
  TReport = class(TInterfacedObject, IReport)
  private
    FReport: TfrxReport;
    FAppEvents: TApplicationEvents;
  private
    procedure OnMessage(var Msg: tagMSG; var Handled: Boolean);
  public
    class function New(AReport: TfrxReport): IReport;
    procedure PrepareReport;
    procedure ShowReport;
    procedure Print;
    procedure SaveToFile(AFile: String);
    procedure ExportarParaPDF(ATitle: String);
    function Printer: String;
    function Copies: String;
    function Collate: String;
    function PageNumbers: String;
    function PrintMode: String;
    function PrintOnSheet: String;
    function PrintPages: String;
    function PagesCount: Integer;
    function GetPrintBClick: TPrintBClick;
    procedure SetPrintBClick(AProc: TPrintBClick);
    procedure SetOnPreview(AProc: TOnPreview);
  public
    constructor Create;
    destructor Destroy; override;
  end;

  function KeyIsDown(const Key: Integer): Boolean;

implementation

{ TReport }

function TReport.Collate: String;
begin
  Result := BoolToStr(FReport.PrintOptions.Collate);
end;

function TReport.Copies: String;
begin
  Result := IntToStr(FReport.PrintOptions.Copies);
end;

constructor TReport.Create;
begin
  inherited Create;
  FAppEvents := TApplicationEvents.Create(nil);
  FAppEvents.OnMessage := Self.OnMessage;
end;

destructor TReport.Destroy;
begin
  FreeAndNil(FAppEvents);
  inherited;
end;

procedure TReport.ExportarParaPDF(ATitle: String);
  Var
    LSavArq: TSaveDialog;
    LExpPDF: TfrxPDFExport;
Begin
  LSavArq := TSaveDialog.Create(nil);
  try
    LSavArq.Filter     := 'Arquivos PDF|*.pdf';
    LSavArq.DefaultExt := 'pdf';

    LSavArq.FileName := ATitle + '.pdf';

    if not LSavArq.Execute then
      Exit;

    LExpPDF := TfrxPDFExport.Create(nil);
    try
      LExpPDF.PageNumbers := FReport.PrintOptions.PageNumbers;
      LExpPDF.ShowDialog  := False;
      LExpPDF.DefaultPath := ExtractFilePath(LSavArq.FileName);

      LExpPDF.FileName := LSavArq.FileName;
      if assigned(FReport.PreviewForm) then
        TfrxPreviewForm(FReport.PreviewForm).Preview.Export(LExpPDF)
      else
        FReport.Export(LExpPDF);
    finally
      FreeAndNil(LExpPDF);
    end;

    ShellExecute(0, nil, PChar(LSavArq.FileName), nil, nil, SW_SHOWNORMAL);
  finally
    FreeAndNil(LSavArq);
  end;
end;

function TReport.GetPrintBClick: TPrintBClick;
begin
  Result := TfrxPreviewForm(FReport.PreviewForm).PrintB.OnClick;
end;

class function TReport.New(AReport: TfrxReport): IReport;
  var
    LReport: TReport;
begin
  LReport := TReport.Create;
  LReport.FReport := AReport;
  Result := LReport;
end;

procedure TReport.OnMessage(var Msg: tagMSG; var Handled: Boolean);
begin
  if Not Assigned(FReport) Then
    Exit;

  If Not Assigned(FReport.Preview) then
    Exit;

  if Msg.hwnd = FReport.Preview.Handle then
  begin
    if (Msg.message = WM_KEYFIRST) and
      ((Msg.wParam = Ord('p')) or (Msg.wParam = Ord('P'))) then
    begin
      if KeyIsDown(VK_CONTROL) then
      begin
        Msg.message := 0;
        TfrxPreviewForm(FReport.PreviewForm).PrintB.Click;
      end;
    end;
  end;
end;

function TReport.PageNumbers: String;
begin
  Result := FReport.PrintOptions.PageNumbers;
end;

function TReport.PagesCount: Integer;
begin
  Result := FReport.PreviewPages.Count;
end;

procedure TReport.PrepareReport;
begin
  FReport.PrepareReport;
end;

procedure TReport.Print;
begin
  FReport.Print;
end;

function TReport.Printer: String;
begin
  Result := FReport.PrintOptions.Printer;
end;

function TReport.PrintMode: String;
begin
  Result := IntToStr(Ord(FReport.PrintOptions.PrintMode));
end;

function TReport.PrintOnSheet: String;
begin
  Result := IntToStr(FReport.PrintOptions.PrintOnSheet);
end;

function TReport.PrintPages: String;
begin
  Result := IntToStr(Ord(FReport.PrintOptions.PrintPages));
end;

procedure TReport.SaveToFile(AFile: String);
begin
  FReport.PreviewPages.SaveToFile(AFile);
end;

procedure TReport.SetOnPreview(AProc: TOnPreview);
begin

end;

procedure TReport.SetPrintBClick(AProc: TPrintBClick);
begin
  TfrxPreviewForm(FReport.PreviewForm).PrintB.OnClick := AProc;
end;

procedure TReport.ShowReport;
begin
  FReport.PreviewOptions.Buttons := [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator];
  FReport.ShowReport;
end;

function KeyIsDown(const Key: Integer): Boolean;
begin
  Result := GetKeyState(Key) and 128 > 0;
end;

end.
