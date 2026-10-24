unit PontoEntrada.Script.Editor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, frxRes,
  System.Types, fs_itools, System.Classes, Vcl.Graphics, Dialogs, UITypes,
  frxSynMemo, Math, frxDesgnCtrls, Forms, frxClass, fs_synmemo, Vcl.Controls,
  Vcl.ExtCtrls, fs_ipascal, fs_iinterpreter, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ToolWin, frxEvaluateForm, System.ImageList, Vcl.ImgList, cxImageList,
  cxGraphics, fs_tree, fs_iclassesrtti, frxDesgn, frxWatchForm, fs_XML,
  Vcl.Buttons, PontoEntrada.Script.Classes, Vcl.AppEvnts, frxUtils,
  dxBarBuiltInMenu, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxPC, BitBtnLockedIncrem, untPai, frxExportCSVTestabilidade, Vcl.Menus,
  EditFocus, cxContainer, cxEdit, dxGDIPlusClasses, cxGroupBox, cxButtons;

type
  TfrmScriptEditor = class(TfrmPai)
    fsScriptIcons: TcxImageList;
    frxReport1: TfrxReport;
    edtDescription: TEditFocus;
    pnlCode: TPanel;
    pnlTreeView: TPanel;
    fsTreeIcons: TcxImageList;
    appEvents: TApplicationEvents;
    cxpStructure: TcxPageControl;
    tbsClasses: TcxTabSheet;
    trvClasses: TTreeView;
    tbsVariables: TcxTabSheet;
    trvVariables: TTreeView;
    tbsFunctions: TcxTabSheet;
    trvFunctions: TTreeView;
    pnlBottom: TPanel;
    gpbWatchList: TGroupBox;
    gpbLogs: TGroupBox;
    memLog: TRichEdit;
    ToolBar1: TToolBar;
    btnClearLog: TToolButton;
    gpbEditor: TGroupBox;
    CodeTB: TToolBar;
    btnRunScript: TToolButton;
    btnNextStep: TToolButton;
    btnStopScript: TToolButton;
    btnEvaluate: TToolButton;
    btnBreakPoint: TToolButton;
    Panel3: TPanel;
    Panel4: TPanel;
    pnlPosition: TPanel;
    Panel6: TPanel;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    pnlErrorMsg: TPanel;
    btnConfirma: TBitBtnLocked;
    pnlFundo: TPanel;
    lblPrompt: TLabel;
    Panel2: TPanel;
    pnlPesquisar: TPanel;
    Image1: TImage;
    edtPesquisar: TEdit;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    Shape1: TShape;
    Panel1: TPanel;
    Panel5: TPanel;
    Shape2: TShape;
    Image2: TImage;
    Edit1: TEdit;
    cxButton3: TcxButton;
    cxButton4: TcxButton;
    Panel7: TPanel;
    Panel8: TPanel;
    Shape3: TShape;
    Image3: TImage;
    Edit2: TEdit;
    cxButton5: TcxButton;
    cxButton6: TcxButton;
    tmrFilterTree: TTimer;
    procedure btnRunScriptClick(Sender: TObject);
    procedure btnStopScriptClick(Sender: TObject);
    procedure btnEvaluateClick(Sender: TObject);
    procedure btnBreakPointClick(Sender: TObject);
    procedure btnClearLogClick(Sender: TObject);
    procedure btnExpandTreeClick(Sender: TObject);
    procedure btnCollapseTreeClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure trvFunctionsDblClick(Sender: TObject);
    procedure trvVariablesDblClick(Sender: TObject);
    procedure trvClassesDblClick(Sender: TObject);
    procedure edtPesquisarChange(Sender: TObject);
    procedure tmrFilterTreeTimer(Sender: TObject);
  private
    { Private declarations }
    FFindText: String;
    FScript: TfsPascalScript;
    FCodeWindow: TfrxSyntaxMemo;
    FWatchList: TfrxWatchForm;
    FRunning: Boolean;
    FNextStep: Boolean;
    FStopped: Boolean;
    FFirstTime: Boolean;
    FXML: TfsXMLDocument;
    procedure OnRunLine(Sender: TfsScript; const UnitName, SourcePos: String);
    procedure CreatePascalEditor;
    procedure CreateWatchList;
    procedure FillTreeViews;
    procedure FilterTreeView(AFilter: string; Sender: TTreeView);
    procedure OnChangePosition(Sender: TObject);
    procedure Log(strLog: String; clrCor: TColor = clBlue;
      blnBold: Boolean = False);
    procedure CollapseTree(Sender: TTreeView);
    procedure ExpandTree(Sender: TTreeView);
  public
    { Public declarations }
    property Script: TfsPascalScript read FScript write FScript;
  end;

implementation

uses
  PontoEntrada.Script.Interfaces, untFuncoesSimples;

{$R *.dfm}

procedure TfrmScriptEditor.btnBreakPointClick(Sender: TObject);
begin
  Log(btnBreakPoint.Hint, clGreen);
  FCodeWindow.ToggleBreakPoint(FCodeWindow.GetPos.Y, '');
end;

procedure TfrmScriptEditor.btnClearLogClick(Sender: TObject);
begin
  memLog.Clear;
end;

procedure TfrmScriptEditor.CollapseTree(Sender: TTreeView);
var
  I: Integer;
begin
  for I := 0 to Sender.Items.Count - 1 do
    Sender.Items[I].Collapse(True);
  Sender.TopItem := Sender.Items[0];
end;

procedure TfrmScriptEditor.ExpandTree(Sender: TTreeView);
var
  I: Integer;
begin
  for I := 0 to Sender.Items.Count - 1 do
    Sender.Items[I].Expand(True);
  Sender.TopItem := Sender.Items[0];
end;

procedure TfrmScriptEditor.btnCollapseTreeClick(Sender: TObject);
begin
  if cxpStructure.ActivePage = tbsClasses then
    CollapseTree(trvClasses);
  if cxpStructure.ActivePage = tbsVariables then
    CollapseTree(trvVariables);
  if cxpStructure.ActivePage = tbsFunctions then
    CollapseTree(trvFunctions);
end;

procedure TfrmScriptEditor.btnConfirmaClick(Sender: TObject);
var
  LErrorPosX: Integer;
  LErrorPosY: Integer;

  function GetWatchList: string;
  var
    LText: String;
  begin
    Result := EmptyStr;
    for LText in FWatchList.Watches do
      Result := Result + LText.Split([':'])[0] + sLineBreak;
    Result := Trim(Result);
  end;

begin
  btnStopScript.Click;
  if fEmptyStr(edtDescription.Text) then
  begin
    pMensagemOk('Informe a descrição do script');
    pSetFocus(edtDescription);
    Exit;
  end;
  Self.Script.Clear;
  Self.Script.Lines.Text := Self.FCodeWindow.Lines.Text;
  Log('Compilando Script', clGreen);
  if Self.Script.Compile then
  begin
    Close;
    ModalResult := mrOk;
    Self.Script.Params.ScriptText(Self.Script.Lines.Text);
    Self.Script.Params.Description(edtDescription.Text);
    Self.Script.Params.WatchList(GetWatchList);
  end
  else
  begin
    Log('Erro ao compilar', clRed);
    LErrorPosX := Self.Script.ErrorPos.Split([':'])[1].ToInteger;
    LErrorPosY := Self.Script.ErrorPos.Split([':'])[0].ToInteger;
    FCodeWindow.SetFocus;
    FCodeWindow.SetPos(LErrorPosX, LErrorPosY);
    pnlErrorMsg.Caption := Self.Script.ErrorMsg + ' na posição ' + pnlPosition.Caption;
    pnlErrorMsg.Visible := True;
    Log(pnlErrorMsg.Caption, clRed, True);
  end;
end;

procedure TfrmScriptEditor.btnEvaluateClick(Sender: TObject);
begin
  Log(btnEvaluate.Hint, clGreen);
  with TfrxEvaluateForm.Create(Self) do
  begin
    Script := Self.Script.objScript;
    if FCodeWindow.SelText <> '' then
      ExpressionE.Text := FCodeWindow.SelText;
    ShowModal;
    Free;
  end;
end;

procedure TfrmScriptEditor.btnExpandTreeClick(Sender: TObject);
begin
  if cxpStructure.ActivePage = tbsClasses then
    ExpandTree(trvClasses);
  if cxpStructure.ActivePage = tbsVariables then
    ExpandTree(trvVariables);
  if cxpStructure.ActivePage = tbsFunctions then
    ExpandTree(trvFunctions);
end;

procedure TfrmScriptEditor.FormCreate(Sender: TObject);
begin
  inherited;
  FormResize(Self);
end;

procedure TfrmScriptEditor.FormDestroy(Sender: TObject);
begin
  inherited;
  FXML.Free;
end;

procedure TfrmScriptEditor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F9:
      btnRunScript.Click;
    VK_F8:
      btnNextStep.Click;
    VK_F5:
      btnBreakPoint.Click;
    VK_F2:
      if Shift = [ssCtrl] then
        btnStopScript.Click;
    VK_F7:
      if Shift = [ssCtrl] then
        btnEvaluate.Click;
    VK_F10:
      btnConfirma.Click;
  end;
end;

procedure TfrmScriptEditor.FormResize(Sender: TObject);
begin
  inherited;
  pnlTreeView.Width := Max(Self.Width div 3, 350);
  pnlBottom.Height := Max(Self.Height div 6, 200);
  gpbWatchList.Width := pnlTreeView.Width - 3;
  pnlBottom.Align := alTop;
  pnlBottom.Align := alBottom;
end;

procedure TfrmScriptEditor.FormShow(Sender: TObject);
begin
  inherited;
  cxpStructure.ActivePage := tbsVariables;
  edtDescription.Text := FScript.Params.Description;
  FXML := TfsXMLDocument.Create;
  CreatePascalEditor;
  CreateWatchList;
  FillTreeViews;
end;

procedure TfrmScriptEditor.btnRunScriptClick(Sender: TObject);
var
  LErrorPosX: Integer;
  LErrorPosY: Integer;
begin
  FNextStep := Sender = btnNextStep;

  if FRunning then
  begin
    Log(btnNextStep.Hint, clGreen);
    FStopped := False;
    Exit;
  end;

  Log(btnRunScript.Hint, clGreen);

  Self.Script.OnRunLine := OnRunLine;

  try
    Self.BorderIcons := Self.BorderIcons - [biSystemMenu];
    Self.Caption := Self.Caption + ' (Executando Script)';
    Self.btnConfirma.Enabled := False;
    FRunning := True;
    FFirstTime := True;
    FWatchList.ScriptRunning := True;

    Self.Script.Clear;
    Self.Script.Lines.Text := Self.FCodeWindow.Lines.Text;

    Log('Compilando Script', clGreen);
    if Self.Script.Compile then
    begin
      Log('Executando Script', clGreen);
      try
        Self.Script.Execute;
      except
        on E: Exception do
        begin
          Log(E.Message, clRed, True);
          pMensagemSonora(E.Message);
          Abort;
        end;
      end;
      Log('Final do Script', clGreen);
    end
    else
    begin
      Log('Erro ao compilar', clRed);
      LErrorPosX := Self.Script.ErrorPos.Split([':'])[1].ToInteger;
      LErrorPosY := Self.Script.ErrorPos.Split([':'])[0].ToInteger;
      FCodeWindow.SetFocus;
      FCodeWindow.SetPos(LErrorPosX, LErrorPosY);
      pnlErrorMsg.Caption := Self.Script.ErrorMsg + ' na posição ' +
        pnlPosition.Caption;
      pnlErrorMsg.Visible := True;
      Log(pnlErrorMsg.Caption, clRed, True);
    end;
  finally
    Self.BorderIcons := Self.BorderIcons + [biSystemMenu];
    Self.btnConfirma.Enabled := True;
    Self.Caption := String(Self.Caption).Replace(' (Executando Script)', '');
    FRunning := False;
    FWatchList.ScriptRunning := False;
    Self.Script.OnRunLine := nil;
    FCodeWindow.ActiveLine := -1;
  end;
  FWatchList.UpdateWatches;
end;

procedure TfrmScriptEditor.OnRunLine(Sender: TfsScript;
  const UnitName, SourcePos: string);
var
  p: TPoint;

  procedure CreateLineMarks;
  var
    i: Integer;
  begin
    for i := 0 to Self.Script.Lines.Count - 1 do
      FCodeWindow.RunLine[i + 1] :=
        Self.Script.objScript.IsExecutableLine(i + 1);
  end;

begin
  p := fsPosToPoint(SourcePos);

  if Self.FFirstTime then
    CreateLineMarks;

  Self.FFirstTime := False;

  FCodeWindow.ActiveLine := p.Y;
  FCodeWindow.SetPos(p.X, p.Y);

  Log('Executando linha: ' + FCodeWindow.Lines[FCodeWindow.ActiveLine - 1].Trim);

  FWatchList.UpdateWatches;

  if not Self.FNextStep then
  begin
    if (FCodeWindow.BreakPoints.Count = 0) then
      Exit;
    if not FCodeWindow.IsBreakPoint(p.Y) then
      Exit;
    Log('Execução parada (breakpoint)', clRed);
  end;

  Log('Aguardando próximo passo');

  Self.FStopped := True;
  while Self.FStopped do
    Application.ProcessMessages;
end;

function fExtractCallMehodSintax(AText: String): String;
const
  Tokens: Array [0 .. 6] of String = ('(', ')', ',', ';', ':', '[', ']');
var
  LArray: TArray<String>;
  LText: String;
  LLast: String;
begin
  Result := '';
  AText := AText.Replace('function ','');
  AText := AText.Replace('procedure ','');
  for LText in Tokens do
    AText := AText.Replace(LText, #13 + LText + #13);
  LArray := AText.Split([#13]);
  for LText in LArray do
  begin
    if not LLast.Trim.Equals(':') then
      if not LText.Trim.Equals(':') then
        if LText.Trim.Equals(';') then
          Result := Result + ', '
        else
          Result := Result + LText;
    LLast := LText;
  end;
end;

procedure TfrmScriptEditor.tmrFilterTreeTimer(Sender: TObject);
var
  LTreeView: TTreeView;
begin
  inherited;
  tmrFilterTree.Enabled := False;

  if cxpStructure.ActivePage = tbsClasses then
    LTreeView := trvClasses
  else if cxpStructure.ActivePage = tbsVariables then
    LTreeView := trvVariables
  else if cxpStructure.ActivePage = tbsFunctions then
    LTreeView := trvFunctions
  else
    Exit;

  LTreeView.Items.BeginUpdate;
  try
    FillTreeViews;
    FilterTreeView(FFindText, LTreeView);
  finally
    LTreeView.Items.EndUpdate;
  end;
end;

procedure TfrmScriptEditor.trvClassesDblClick(Sender: TObject);
var
  LClass: String;
  LMethod: String;
begin
  if trvClasses.Selected = nil then
    Exit;

  if trvClasses.Selected.Parent = nil then
    Exit;

  if trvClasses.Selected.Count > 0 then
    Exit;

  LClass := trvClasses.Selected.Text;

  LClass := trvClasses.Selected.Parent.Text;
  LMethod := trvClasses.Selected.Text;

  if LMethod.StartsWith('constructor ') then
    LMethod := LClass + '.' + LMethod.Replace('constructor ', '')
  else if LMethod.StartsWith('property ') then
    LMethod := '.' + LMethod.Replace('property ', '').Split([':'])[0]
  else if LMethod.StartsWith('destructor ') then
    LMethod := '.' + LMethod.Replace('destructor ', '')
  else if LMethod.StartsWith('procedure ') then
    LMethod := '.' + fExtractCallMehodSintax(LMethod)
  else if LMethod.StartsWith('function ') then
    LMethod := '.' + fExtractCallMehodSintax(LMethod);

  FCodeWindow.SelText := LMethod;
  FCodeWindow.SetFocus;
end;

procedure TfrmScriptEditor.trvFunctionsDblClick(Sender: TObject);
begin
  inherited;
  if trvFunctions.Selected = nil then
    Exit;

  if trvFunctions.Selected.Parent = nil then
    Exit;

  if trvFunctions.Selected.Count > 0 then
    Exit;

  FCodeWindow.SelText := trvFunctions.Selected.Text;
  FCodeWindow.SetFocus;
end;

procedure TfrmScriptEditor.trvVariablesDblClick(Sender: TObject);
var
  LVar: String;
  LAux: String;
begin
  if trvVariables.Selected = nil then
    Exit;

  if trvVariables.Selected.Parent = nil then
    Exit;

  if trvVariables.Selected.Count > 0 then
    Exit;

  LVar := trvVariables.Selected.Text;

  if LVar.StartsWith('var ') then
    LVar := LVar.Replace('var ', '').Split([':'])[0]
  else
  begin
    LVar := trvVariables.Selected.Parent.Text;
    LVar := LVar.Replace('var ', '').Split([':'])[0];
    LAux := trvVariables.Selected.Text;
    if LAux.StartsWith('property ') then
      LAux := LAux.Replace('property ', '').Split([':'])[0]
    else if LAux.StartsWith('constructor ') then
      LAux := LAux.Replace('constructor ', '')
    else if LAux.StartsWith('destructor ') then
      LAux := LAux.Replace('destructor ', '')
    else if LAux.StartsWith('procedure ') then
      LAux := fExtractCallMehodSintax(LAux)
    else if LAux.StartsWith('function ') then
      LAux := fExtractCallMehodSintax(LAux);
    LVar := LVar + '.' + LAux;
  end;

  FCodeWindow.SelText := LVar;
  FCodeWindow.SetFocus;
end;

procedure TfrmScriptEditor.btnSairClick(Sender: TObject);
begin
  btnStopScript.Click;
  Close;
end;

procedure TfrmScriptEditor.btnStopScriptClick(Sender: TObject);
begin
  Log(btnStopScript.Hint, clGreen);
  Self.Script.OnRunLine := nil;
  Self.Script.Terminate;
  Self.FStopped := False;
end;

procedure TfrmScriptEditor.OnChangePosition(Sender: TObject);
begin
  pnlPosition.Caption := Format('%d: %d', [FCodeWindow.GetPos.Y,
    FCodeWindow.GetPos.X]);
  pnlErrorMsg.Visible := False;
end;

procedure TfrmScriptEditor.CreatePascalEditor;
begin
  FCodeWindow := TfrxSyntaxMemo.Create(Self);
  FCodeWindow.Parent := gpbEditor;
  FCodeWindow.Align := alClient;
  FCodeWindow.AlignWithMargins := True;
  FCodeWindow.BorderStyle := bsSingle;
  FCodeWindow.Color := clWindow;
  FCodeWindow.OnChangePos := Self.OnChangePosition;
  // FCodeWindow.OnCodeCompletion := Self.OnCodeCompletion;
  FCodeWindow.Syntax := 'PascalScript';
  if Self.Script.Params.ScriptText.IsEmpty then
    FCodeWindow.Lines.Text := 'begin' + sLineBreak + sLineBreak + 'end.'
  else
    FCodeWindow.Lines.Text := Self.Script.Params.ScriptText;
  FCodeWindow.OnKeyDown := Self.FormKeyDown;
end;

procedure TfrmScriptEditor.CreateWatchList;
var
  LText: String;
  LSL: TStringList;
begin
  FWatchList := TfrxWatchForm.Create(Self);
  FWatchList.Script := Self.Script.objScript;
  FWatchList.ManualDock(gpbWatchList);
  FWatchList.Align := alClient;
  FWatchList.AlignWithMargins := True;
  FWatchList.Visible := True;
  FWatchList.Color := Self.Color;
  LSL := TStringList.Create;
  try
    LSL.Text := Self.Script.Params.WatchList;
    for LText in LSL do
    begin
      FWatchList.Watches.AddObject(LText.Split([':'])[0], TObject(1));
      FWatchList.UpdateWatches;
    end;
  finally
    LSL.Free;
  end;
end;

procedure TfrmScriptEditor.edtPesquisarChange(Sender: TObject);
begin
  inherited;
  FFindText := TEdit(Sender).Text;
  tmrFilterTree.Enabled := False;
  tmrFilterTree.Enabled := True;
end;

procedure TfrmScriptEditor.FillTreeViews;

  function FindNode(ATree: TTreeView; AValue: String; AVisible: Boolean)
    : TTreeNode;
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

  procedure SetImageIndex(Node: TTreeNode; Index: Integer);
  begin
    Node.ImageIndex := Index;
    Node.SelectedIndex := Index;
  end;

  function AddClassChild(Root: TTreeNode; AText: String; AImageIndex: Integer)
    : TTreeNode;
  begin
    Result := trvClasses.Items.AddChild(Root, AText);
    SetImageIndex(Result, AImageIndex);
  end;

  function AddObjectChild(Root: TTreeNode; AText: String; AImageIndex: Integer)
    : TTreeNode;
  begin
    Result := trvVariables.Items.AddChild(Root, AText);
    SetImageIndex(Result, AImageIndex);
  end;

  function AddVariableChild(Root: TTreeNode; AText: String;
    AImageIndex: Integer): TTreeNode;
  begin
    Result := trvVariables.Items.AddChild(Root, AText);
    SetImageIndex(Result, AImageIndex);
  end;

  function GetCategoryByName(s: String): String;
  begin
    if s = 'ctConv' then
      Result := 'Conversão'
    else if s = 'ctFormat' then
      Result := 'Formatação'
    else if s = 'ctDate' then
      Result := 'Data/Hora'
    else if s = 'ctString' then
      Result := 'Texto'
    else if s = 'ctMath' then
      Result := 'Matemática'
    else if s = 'ctOther' then
      Result := 'Outras'
    else
      Result := s;
  end;

  procedure AddClass(Root: TTreeNode; AClassInfo: IfsClassInfo);
  var
    LProp: String;
    LMethod: String;
  begin
    Root := AddClassChild(Root, AClassInfo.ClassName, 1);
    for LMethod in AClassInfo.Methods do
      AddClassChild(Root, LMethod, 2);
    for LProp in AClassInfo.Properties do
      AddClassChild(Root, LProp, 3);
  end;

  procedure AddObject(Root: TTreeNode; AInfo: IfsObjectInfo);
  var
    LValue: String;
    LInfo: IfsClassInfo;
  begin
    Root := AddObjectChild(Root, Concat('var ', AInfo.Name, ': ',
      AInfo.ObjectRef.ClassName), IfThen(AInfo.ObjectRef is TfsForm, 6, 1));
    if not Script.Params.Classes.TryGetValue(AInfo.ObjectRef.ClassName, LInfo)
    then
      Exit;
    for LValue in LInfo.Properties do
      AddObjectChild(Root, LValue, 3);
    for LValue in LInfo.Methods do
      if not LValue.Contains('constructor') then
        if not LValue.Contains('destructor') then
          AddObjectChild(Root, LValue, 2);
  end;

  procedure AddFunctions(xi: TfsXMLItem; Root: TTreeNode);
  var
    i: Integer;
    Node: TTreeNode;
    s: String;
  begin
    s := xi.Prop['text'];
    if xi.Count = 0 then
      s := Copy(s, Pos(' ', s) + 1, 255)
    else { function }
      s := GetCategoryByName(s); { category }
    if s = 'ctAggregate' then
      Exit;
    Node := trvFunctions.Items.AddChild(Root, s);
    if xi.Count = 0 then
      Node.Data := xi;
    if Root = nil then
      Node.Text := xi.Name;
    if Root = nil then
      SetImageIndex(Node, 0)
    else if xi.Count = 0 then
      SetImageIndex(Node, 4)
    else
      SetImageIndex(Node, 0);
    for i := 0 to xi.Count - 1 do
      AddFunctions(xi[i], Node);
  end;

var
  Root: TTreeNode;
  LClassInfo: IfsClassInfo;
  LVarInfo: IfsVariableInfo;
  LObjInfo: IfsObjectInfo;

begin
  FXML.Root.Clear;
  GenerateXMLContents(Self.Script.objScript, FXML.Root);

  trvClasses.Items.Clear;
  trvVariables.Items.Clear;
  trvFunctions.Items.Clear;

  if Script.Params.Classes.Count > 0 then
  begin
    // add class root
    Root := AddClassChild(nil, 'Classes', 0);
    // add class categories
    for LClassInfo In Script.Params.Classes.Values do
      if FindNode(trvClasses, LClassInfo.Category, True) = nil then
        AddClassChild(Root, LClassInfo.Category, 0);
    // add classes (methods and properties)
    for LClassInfo In Script.Params.Classes.Values do
      AddClass(FindNode(trvClasses, LClassInfo.Category, True), LClassInfo);
  end;

  if Script.Params.Variables.Count + Script.Params.Objects.Count > 0 then
  begin
    // add variables root
    Root := AddVariableChild(nil, 'Variáveis', 0);
    // add variables categories
    for LVarInfo In Script.Params.Variables.Values do
      if FindNode(trvVariables, LVarInfo.Category, True) = nil then
        AddVariableChild(Root, LVarInfo.Category, 0);
    // add variables
    for LVarInfo In Script.Params.Variables.Values do
      AddVariableChild(FindNode(trvVariables, LVarInfo.Category, True),
        Concat('var ' + LVarInfo.Name, ': ', LVarInfo.Typ), 5);
    // add objects categories
    for LObjInfo In Script.Params.Objects.Values do
      if FindNode(trvVariables, LObjInfo.Category, True) = nil then
        AddObjectChild(Root, LObjInfo.Category, 0);
    // add objects (methods and properties)
    for LObjInfo In Script.Params.Objects.Values do
      AddObject(FindNode(trvVariables, LObjInfo.Category, True), LObjInfo);
  end;

  FXML.Root.Clear;
  GenerateXMLContents(fsGlobalUnit, FXML.Root);

  if FXML.Root.FindItem('Functions').Count > 0 then
    AddFunctions(FXML.Root.FindItem('Functions'), nil);

  ExpandTree(trvClasses);
  ExpandTree(trvVariables);
  ExpandTree(trvFunctions);

  trvClasses.SortType := TSortType.stText;
  trvVariables.SortType := TSortType.stText;
  trvFunctions.SortType := TSortType.stText;
end;

procedure TfrmScriptEditor.FilterTreeView(AFilter: string; Sender: TTreeView);

  procedure FilterNodes(AFilter: String; ANode: TTreeNode);
  var
    LNode: TTreeNode;
    LNodes: TArray<TTreeNode>;
    LIndex: Integer;
    LText: String;
    LWord: String;
    LShow: Boolean;
  begin
    if ANode.Count = 0 then
    begin
      LText := '';
      LNode := ANode;
      while Assigned(LNode) do
      begin
        LText := LNode.Text + ' ' + LText;
        LNode := LNode.Parent;
      end;
      LShow := True;
      for LWord in AFilter.Split([' ']) do
        if not LText.ToUpper.Contains(LWord.ToUpper) then
          LShow := False;
      if not LShow then
        ANode.Delete;
      Exit;
    end;

    SetLength(LNodes, ANode.Count);
    for LIndex := 0 to ANode.Count -1 do
      LNodes[LIndex] := ANode.Item[LIndex];

    for LNode in LNodes do
      FilterNodes(AFilter, LNode);
  end;

Var
  LNode: TTreeNode;
  LLevel: Integer;
begin
  for LLevel := 1 to 3 do
    for LNode in Sender.Items do
      FilterNodes(AFilter, LNode);
end;

{ procedure TfrmScriptEditor.OnCodeCompletion(const Name: String; List: TStrings);
  var
  obj: TPersistent;
  xd: TfsXMLDocument;
  i, j: Integer;
  sl, members: TStringList;
  s: String;
  clName: String;
  clVar: TfsClassVariable;
  clMethod: TfsCustomHelper;
  cl: TClass;
  l: TList;
  begin
  members := TStringList.Create;
  frxSetCommaText(Name, members, '.');
  if members.Count = 0 then
  begin
  List.Clear;
  for i := 0 to FScript.objScript.Count - 1 do
  List.AddObject(FScript.objScript.Items[i].Name + ' : ' + FScript.objScript.Items[i].ClassName, nil);

  members.Free;
  Exit;
  end;

  for i := 0 to members.Count - 1 do
  members[i] := Trim(members[i]);

  //  if CompareText('Report', members[0]) = 0 then
  //    obj := Report
  //  else if CompareText('Engine', members[0]) = 0 then
  //    obj := Report.Engine
  //  else if CompareText('Outline', members[0]) = 0 then
  //    obj := Report.PreviewPages.Outline
  //  else
  //    obj := Report.FindObject(members[0]);
  obj := nil;

  clName := '';
  if obj <> nil then
  clName := obj.ClassName;

  i := 1;
  while (clName <> '') and (i < members.Count) do
  begin
  clVar := FScript.objScript.FindClass(clName);
  clName := '';
  if clVar <> nil then
  begin
  clMethod := clVar.Find(members[i]);
  if clMethod <> nil then
  clName := clMethod.TypeName;
  Inc(i);
  end;
  end;

  // memleak
  members.Free;

  if clName <> '' then
  begin
  clVar := FScript.objScript.FindClass(clName);
  if clVar <> nil then
  begin
  cl := FScript.objScript.FindClass(clName).ClassRef;

  xd := TfsXMLDocument.Create;
  GenerateMembers(Self.Script.objScript, cl, xd.Root);
  sl := TStringList.Create;
  sl.Sorted := True;
  sl.Duplicates := dupIgnore;
  for i := 0 to xd.Root.Count - 1 do
  begin
  s := xd.Root[i].Prop['text'];
  j := 0;
  if Pos('property', s) = 1 then
  begin
  Delete(s, 1, 9);
  j := 1;
  end;
  if Pos('index property', s) = 1 then
  begin
  Delete(s, 1, 15);
  j := 1;
  end;
  if Pos('procedure', s) = 1 then
  begin
  Delete(s, 1, 10);
  j := 2;
  end;
  if Pos('function', s) = 1 then
  begin
  Delete(s, 1, 9);
  j := 3;
  end;

  sl.AddObject(s, TObject(j));
  end;
  List.Assign(sl);
  sl.Free;
  xd.Free;
  end;
  end;
  end; }

Procedure TfrmScriptEditor.Log(strLog: String; clrCor: TColor = clBlue;
  blnBold: Boolean = False);
Begin
  memLog.SelAttributes.Color := clrCor;
  If blnBold Then
    memLog.SelAttributes.Style := [fsBold]
  Else
    memLog.SelAttributes.Style := [];
  memLog.Lines.Add(strLog);
  SendMessage(memLog.Handle, WM_VSCROLL, SB_PAGEDOWN, 0);
  memLog.Refresh;
  memLog.ScrollBy(0, -7);
End;

end.
