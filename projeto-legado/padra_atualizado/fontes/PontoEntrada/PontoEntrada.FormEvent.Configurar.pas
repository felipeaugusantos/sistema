unit PontoEntrada.FormEvent.Configurar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, untPaiSimples,
  PontoEntrada.Script.Interfaces,
  PontoEntrada.Script.Classes,
  PontoEntrada.FormEvent.Classes,
  frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons, BitBtnLockedIncrem,
  Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, cxImageList, cxGraphics, Data.DB,
  Datasnap.DBClient, UniClientDataSet, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGridCitel, cxClasses,
  cxGridLevel, cxGrid, cxGridDBTableView, Vcl.ToolWin, cxImageComboBox,
  cxCheckBox, fs_synmemo, dxGDIPlusClasses;

type
  TfrmConfigurarEventosFormulario = class(TfrmPaiSimples)
    Panel1: TPanel;
    Label1: TLabel;
    lblFormName: TLabel;
    imgTreeIcons: TcxImageList;
    cdsActions: TUniClientDataSet;
    cdsActionsId: TStringField;
    cdsActionsExecuteIndex: TIntegerField;
    cdsActionsDescription: TStringField;
    cdsActionsEdit: TStringField;
    dtsActions: TDataSource;
    imgToolBar: TcxImageList;
    cdsActionsEnabled: TBooleanField;
    pnlActions: TPanel;
    lblEntryPoint: TLabel;
    pnlBotoesActions: TToolBar;
    btnAddAction: TToolButton;
    btnDelAction: TToolButton;
    cxgActions: TcxGridCitel;
    cxgActionsView: TcxGridDBTableViewCitel;
    cxgActionsViewId: TcxGridDBColumn;
    cxgActionsViewExecuteIndex: TcxGridDBColumn;
    cxgActionsViewDescription: TcxGridDBColumn;
    cxgActionsViewEdit: TcxGridDBColumn;
    cxgActionsViewEnabled: TcxGridDBColumn;
    cxgActionsLevel: TcxGridLevel;
    memScript: TfsSyntaxMemo;
    btnMoveUp: TToolButton;
    btnMoveDown: TToolButton;
    tmrFilterTreeView: TTimer;
    pgcEntryPoints: TPageControl;
    tbsEntrySelected: TTabSheet;
    tbsEntryAvailable: TTabSheet;
    Panel2: TPanel;
    CodeTB: TToolBar;
    btnDelEntry: TToolButton;
    trvEntrySelected: TTreeView;
    Panel3: TPanel;
    pnlPesquisar: TPanel;
    Shape1: TShape;
    Image1: TImage;
    edtFilterEntrySelected: TEdit;
    Panel4: TPanel;
    trvEntryAvailable: TTreeView;
    Panel5: TPanel;
    Panel6: TPanel;
    Shape2: TShape;
    Image2: TImage;
    edtFilterEntryAvailable: TEdit;
    Label2: TLabel;
    procedure trvEntrySelectedClick(Sender: TObject);
    procedure cdsActionsAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure cdsActionsBeforePost(DataSet: TDataSet);
    procedure cxgActionsViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgActionsViewEnabledPropertiesChange(Sender: TObject);
    procedure btnDelEntryClick(Sender: TObject);
    procedure btnDelActionClick(Sender: TObject);
    procedure btnAddActionClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure cxgActionsViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnMoveUpClick(Sender: TObject);
    procedure btnMoveDownClick(Sender: TObject);
    procedure edtFilterEntrySelectedChange(Sender: TObject);
    procedure tmrFilterTreeViewTimer(Sender: TObject);
    procedure trvEntryAvailableDblClick(Sender: TObject);
  private
    FSelectedControl: TFormEntryPointControl;
    FSelectedEntry: TFormEntryPoint;
    FSelectedAction: TFormEntryPointAction;
    FEntryPointManager: TFormEntryPointManager;
    procedure FillTreeEntrySelected;
    procedure FillTreeEntryAvailable;
    procedure UpdateSelectedEntryPointActions;
    procedure ExpandTree(Sender: TTreeView);
    procedure FilterTreeView(AFilter: string; Sender: TTreeView);
  public
    class procedure Execute(AManager: TFormEntryPointManager);
  end;

implementation

uses
  untFuncoesSimples, untPai;

{$R *.dfm}

procedure TfrmConfigurarEventosFormulario.ExpandTree(Sender: TTreeView);
var
  I: Integer;
begin
  for I := 0 to Sender.Items.Count - 1 do
    Sender.Items[I].Expand(True);
  if Sender.Items.Count = 0 then
    Exit;
  Sender.Select(Sender.Items[0]);
  while Sender.Selected.Count > 0 do
    Sender.Select(Sender.Selected.Item[0]);
end;

class procedure TfrmConfigurarEventosFormulario.Execute
  (AManager: TFormEntryPointManager);
var
  frmConfigurarEventosFormulario: TfrmConfigurarEventosFormulario;
begin
  pCriarFormularios(TfrmConfigurarEventosFormulario,
    frmConfigurarEventosFormulario);
  try
    frmConfigurarEventosFormulario.FEntryPointManager := AManager;
    frmConfigurarEventosFormulario.ShowModal;
  finally
    pFreeAndNil(frmConfigurarEventosFormulario);
  end;
end;

{ TfrmConfigurarEventosFormulario }

procedure TfrmConfigurarEventosFormulario.btnAddActionClick(Sender: TObject);
begin
  inherited;
  if FEntryPointManager.AddActionScript(FSelectedControl, FSelectedEntry.Event)
  then
    UpdateSelectedEntryPointActions;
end;

procedure TfrmConfigurarEventosFormulario.btnDelActionClick(Sender: TObject);
begin
  inherited;
  if not Assigned(FSelectedAction) then
    Exit;

  if not fPergunta('Confirma excluir a ação selecionada?') then
    Exit;

  fExecutarModal(
    procedure
    begin
      if not FEntryPointManager.DeleteActionScript(FSelectedEntry,
        FSelectedAction) then
        Exit;
      cdsActions.Delete;
      cdsActions.First;
      while Not cdsActions.Eof do
      begin
        FEntryPointManager.UpdateExecuteIndex(FSelectedAction,
          cdsActions.RecNo);
        cdsActions.Edit;
        cdsActionsExecuteIndex.AsInteger := cdsActions.RecNo;
        cdsActions.Post;
        cdsActions.Next;
      end;
      cdsActions.First;
    end, 'Excluindo a ação selecionada. Aguarde ...', '');
end;

procedure TfrmConfigurarEventosFormulario.btnDelEntryClick(Sender: TObject);
begin
  inherited;
  if not Assigned(FSelectedEntry) then
    Exit;
  if FSelectedEntry.Actions.Count > 0 then
  begin
    pMensagemOk
      ('Favor excluir as ações antes de excluir este ponto de entrada!');
    Exit;
  end;
  FSelectedControl.EntryPoints.Remove(FSelectedEntry.Event);
  FreeAndNil(FSelectedEntry);
  if FSelectedControl.EntryPoints.Count = 0 then
  begin
    FEntryPointManager.SelectedControls.Remove(FSelectedControl.ControlName);
    FreeAndNil(FSelectedControl);
  end;
  FillTreeEntrySelected;
  UpdateSelectedEntryPointActions;
end;

procedure TfrmConfigurarEventosFormulario.cdsActionsAfterScroll
  (DataSet: TDataSet);
begin
  inherited;
  btnDelAction.Enabled := False;
  memScript.Lines.Clear;
  FSelectedAction := nil;
  if FSelectedControl = nil then
    Exit;
  if FSelectedEntry = nil then
    Exit;
  if not FSelectedEntry.Actions.ContainsKey(cdsActionsId.AsString) then
    Exit;
  FSelectedAction := FSelectedEntry.Actions[cdsActionsId.AsString];
  memScript.Lines.Text := FSelectedAction.Script;
  btnDelAction.Enabled := True;
end;

procedure TfrmConfigurarEventosFormulario.cdsActionsBeforePost
  (DataSet: TDataSet);
begin
  inherited;
  if cdsActions.ControlsDisabled then
    Exit;
  if not Assigned(FSelectedAction) then
    Exit;
  if cdsActionsEnabled.AsBoolean then
    FEntryPointManager.EnableAction(FSelectedAction)
  else
    FEntryPointManager.DisableAction(FSelectedAction);
  cdsActionsEnabled.AsBoolean := FSelectedAction.Enabled;
end;

procedure TfrmConfigurarEventosFormulario.cxgActionsViewCellClick
  (Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  if (ACellViewInfo.Item.Index = cxgActionsViewEdit.Index) and
    Assigned(FSelectedAction) then
  begin
    if FEntryPointManager.EditActionScript(FSelectedAction) then
    begin
      if cdsActions.State <> dsEdit then
        cdsActions.Edit;
      cdsActionsDescription.AsString := FSelectedAction.Description;
      cdsActions.Post;
    end;
    Abort;
  end;
end;

procedure TfrmConfigurarEventosFormulario.cxgActionsViewCellDblClick
  (Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  if (ACellViewInfo.Item.Index < cxgActionsViewEdit.Index) and
    Assigned(FSelectedAction) then
  begin
    if FEntryPointManager.EditActionScript(FSelectedAction) then
    begin
      if cdsActions.State <> dsEdit then
        cdsActions.Edit;
      cdsActionsDescription.AsString := FSelectedAction.Description;
      cdsActions.Post;
    end;
    Abort;
  end;
end;

procedure TfrmConfigurarEventosFormulario.cxgActionsViewEnabledPropertiesChange
  (Sender: TObject);
begin
  inherited;
  if cdsActions.State = dsEdit then
    cdsActions.Post;
end;

procedure TfrmConfigurarEventosFormulario.edtFilterEntrySelectedChange
  (Sender: TObject);
begin
  inherited;
  tmrFilterTreeView.Enabled := False;
  tmrFilterTreeView.Enabled := True;
end;

procedure TfrmConfigurarEventosFormulario.FillTreeEntryAvailable;
var
  LRoot: TTreeNode;
  LMainRoot: TTreeNode;
  LFormRoot: TTreeNode;
  LObjectRoot: TTreeNode;
  LEditRoot: TTreeNode;
  LButtonRoot: TTreeNode;
  LEventRoot: TTreeNode;
  LNode: TTreeNode;
  LControl: TFormEntryPointControl;
  LEntry: TFormEntryPoint;
begin
  trvEntryAvailable.Items.Clear;

  LEditRoot := nil;
  LButtonRoot := nil;

  LMainRoot := trvEntryAvailable.Items.AddChild(nil, 'Pontos de Entrada');
  LMainRoot.ImageIndex := 0;
  LMainRoot.SelectedIndex := 0;

  LFormRoot := trvEntryAvailable.Items.AddChild(LMainRoot,
    Self.FEntryPointManager.FormName);
  LFormRoot.ImageIndex := 1;
  LFormRoot.SelectedIndex := 1;

  LEventRoot := trvEntryAvailable.Items.AddChild(LFormRoot, 'Eventos');
  LEventRoot.ImageIndex := 0;
  LEventRoot.SelectedIndex := 0;

  LObjectRoot := trvEntryAvailable.Items.AddChild(LFormRoot, 'Objetos');
  LObjectRoot.ImageIndex := 0;
  LObjectRoot.SelectedIndex := 0;

  for LControl in Self.FEntryPointManager.AvailableControls.Values do
  begin
    if LControl.ControlType.Equals('TEdit') Then
    begin
      if LEditRoot = nil then
      begin
        LEditRoot := trvEntryAvailable.Items.AddChild(LObjectRoot, 'Texto');
        LEditRoot.ImageIndex := 0;
        LEditRoot.SelectedIndex := 0;
      end;

      LRoot := trvEntryAvailable.Items.AddChild(LEditRoot,
        LControl.ControlName);
      LRoot.ImageIndex := 2;
      LRoot.SelectedIndex := 2;
    end
    else if LControl.ControlType.Equals('TButton') Then
    begin
      if LButtonRoot = nil then
      begin
        LButtonRoot := trvEntryAvailable.Items.AddChild(LObjectRoot, 'Botões');
        LButtonRoot.ImageIndex := 0;
        LButtonRoot.SelectedIndex := 0;
      end;

      LRoot := trvEntryAvailable.Items.AddChild(LButtonRoot,
        LControl.ControlName);
      LRoot.ImageIndex := 3;
      LRoot.SelectedIndex := 3;
    end
    else
    begin
      LRoot := LEventRoot;
    end;

    for LEntry in LControl.EntryPoints.Values do
    begin
      LNode := trvEntryAvailable.Items.AddChild(LRoot, LEntry.Event);
      LNode.ImageIndex := 4;
      LNode.SelectedIndex := 4;
    end;
  end;

  if LEventRoot.Count = 0 then
    LEventRoot.Delete;

  if LObjectRoot.Count = 0 then
    LObjectRoot.Delete;

  trvEntryAvailable.SortType := TSortType.stText;

  ExpandTree(trvEntryAvailable);
end;

procedure TfrmConfigurarEventosFormulario.FillTreeEntrySelected;
var
  LRoot: TTreeNode;
  LMainRoot: TTreeNode;
  LFormRoot: TTreeNode;
  LObjectRoot: TTreeNode;
  LEditRoot: TTreeNode;
  LButtonRoot: TTreeNode;
  LEventRoot: TTreeNode;
  LNode: TTreeNode;
  LControl: TFormEntryPointControl;
  LEntry: TFormEntryPoint;
begin
  trvEntrySelected.Items.Clear;

  LEditRoot := nil;
  LButtonRoot := nil;

  LMainRoot := trvEntrySelected.Items.AddChild(nil, 'Pontos de Entrada');
  LMainRoot.ImageIndex := 0;
  LMainRoot.SelectedIndex := 0;

  LFormRoot := trvEntrySelected.Items.AddChild(LMainRoot,
    Self.FEntryPointManager.FormName);
  LFormRoot.ImageIndex := 1;
  LFormRoot.SelectedIndex := 1;

  LEventRoot := trvEntrySelected.Items.AddChild(LFormRoot, 'Eventos');
  LEventRoot.ImageIndex := 0;
  LEventRoot.SelectedIndex := 0;

  LObjectRoot := trvEntrySelected.Items.AddChild(LFormRoot, 'Objetos');
  LObjectRoot.ImageIndex := 0;
  LObjectRoot.SelectedIndex := 0;

  for LControl in Self.FEntryPointManager.SelectedControls.Values do
  begin
    if LControl.ControlType.Equals('TEdit') Then
    begin
      if LEditRoot = nil then
      begin
        LEditRoot := trvEntrySelected.Items.AddChild(LObjectRoot, 'Texto');
        LEditRoot.ImageIndex := 0;
        LEditRoot.SelectedIndex := 0;
      end;

      LRoot := trvEntrySelected.Items.AddChild(LEditRoot, LControl.ControlName);
      LRoot.ImageIndex := 2;
      LRoot.SelectedIndex := 2;
    end
    else if LControl.ControlType.Equals('TButton') Then
    begin
      if LButtonRoot = nil then
      begin
        LButtonRoot := trvEntrySelected.Items.AddChild(LObjectRoot, 'Botões');
        LButtonRoot.ImageIndex := 0;
        LButtonRoot.SelectedIndex := 0;
      end;

      LRoot := trvEntrySelected.Items.AddChild(LButtonRoot,
        LControl.ControlName);
      LRoot.ImageIndex := 3;
      LRoot.SelectedIndex := 3;
    end
    else
    begin
      LRoot := LEventRoot;
    end;

    for LEntry in LControl.EntryPoints.Values do
    begin
      LNode := trvEntrySelected.Items.AddChild(LRoot, LEntry.Event);
      LNode.ImageIndex := 4;
      LNode.SelectedIndex := 4;
    end;
  end;

  if LEventRoot.Count = 0 then
    LEventRoot.Delete;

  if LObjectRoot.Count = 0 then
    LObjectRoot.Delete;

  trvEntrySelected.SortType := TSortType.stText;

  ExpandTree(trvEntrySelected);
end;

procedure TfrmConfigurarEventosFormulario.FilterTreeView(AFilter: string;
Sender: TTreeView);

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
    for LIndex := 0 to ANode.Count - 1 do
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

procedure TfrmConfigurarEventosFormulario.FormResize(Sender: TObject);
begin
  inherited;
  memScript.Height := pnlActions.Height div 2;
end;

procedure TfrmConfigurarEventosFormulario.FormShow(Sender: TObject);
begin
  inherited;
  lblFormName.Caption := FEntryPointManager.FormInstance.ClassName + ' (';

  if FEntryPointManager.FormInstance is TfrmPai then
    lblFormName.Caption := lblFormName.Caption +
      TfrmPai(FEntryPointManager.FormInstance).OriginalCaption
  else
    lblFormName.Caption := lblFormName.Caption +
      FEntryPointManager.FormInstance.Caption;

  lblFormName.Caption := lblFormName.Caption + ')';

  pgcEntryPoints.ActivePage := tbsEntrySelected;

  FillTreeEntrySelected;
  FillTreeEntryAvailable;

  UpdateSelectedEntryPointActions;

  FormResize(Sender);
end;

procedure TfrmConfigurarEventosFormulario.btnMoveDownClick(Sender: TObject);
var
  LCurrAction: TFormEntryPointAction;
  LSuccAction: TFormEntryPointAction;
  LCurrExecIndex: Integer;
  LSuccExecIndex: Integer;
begin
  inherited;
  if not Assigned(FSelectedAction) then
    Exit;

  if cdsActions.IsEmpty then
    Exit;

  if cdsActions.RecNo = cdsActions.RecordCount then
    Exit;

  if cdsActions.RecordCount = 1 then
    Exit;

  LCurrAction := FSelectedAction;
  cdsActions.Next;
  LSuccAction := FSelectedAction;

  LCurrExecIndex := LCurrAction.ExecuteIndex;
  LSuccExecIndex := LSuccAction.ExecuteIndex;

  if not FEntryPointManager.UpdateExecuteIndex(LCurrAction, LSuccExecIndex) then
    Exit;

  if not FEntryPointManager.UpdateExecuteIndex(LSuccAction, LCurrExecIndex) then
    Exit;

  cdsActions.DisableControls;
  try
    cdsActions.Locate('Id', LSuccAction.Id, []);
    cdsActions.Edit;
    cdsActionsExecuteIndex.AsInteger := LSuccAction.ExecuteIndex;
    cdsActions.Post;

    cdsActions.Locate('Id', LCurrAction.Id, []);
    cdsActions.Edit;
    cdsActionsExecuteIndex.AsInteger := LCurrAction.ExecuteIndex;
    cdsActions.Post;
  finally
    cdsActions.EnableControls;
  end;
end;

procedure TfrmConfigurarEventosFormulario.btnMoveUpClick(Sender: TObject);
var
  LCurrAction: TFormEntryPointAction;
  LPredAction: TFormEntryPointAction;
  LCurrExecIndex: Integer;
  LPredExecIndex: Integer;
begin
  inherited;
  if not Assigned(FSelectedAction) then
    Exit;

  if cdsActions.IsEmpty then
    Exit;

  if cdsActions.RecNo = 1 then
    Exit;

  if cdsActions.RecordCount = 1 then
    Exit;

  LCurrAction := FSelectedAction;
  cdsActions.Prior;
  LPredAction := FSelectedAction;

  LCurrExecIndex := LCurrAction.ExecuteIndex;
  LPredExecIndex := LPredAction.ExecuteIndex;

  if not FEntryPointManager.UpdateExecuteIndex(LCurrAction, LPredExecIndex) then
    Exit;

  if not FEntryPointManager.UpdateExecuteIndex(LPredAction, LCurrExecIndex) then
    Exit;

  cdsActions.DisableControls;
  try
    cdsActions.Locate('Id', LPredAction.Id, []);
    cdsActions.Edit;
    cdsActionsExecuteIndex.AsInteger := LPredAction.ExecuteIndex;
    cdsActions.Post;

    cdsActions.Locate('Id', LCurrAction.Id, []);
    cdsActions.Edit;
    cdsActionsExecuteIndex.AsInteger := LCurrAction.ExecuteIndex;
    cdsActions.Post;
  finally
    cdsActions.EnableControls;
  end;
end;

procedure TfrmConfigurarEventosFormulario.tmrFilterTreeViewTimer
  (Sender: TObject);
begin
  inherited;
  tmrFilterTreeView.Enabled := False;
  if pgcEntryPoints.ActivePage = tbsEntrySelected then
  begin
    trvEntrySelected.Items.BeginUpdate;
    try
      FillTreeEntrySelected;
      FilterTreeView(edtFilterEntrySelected.Text, trvEntrySelected);
    finally
      trvEntrySelected.Items.EndUpdate;
    end;
  end
  else
  begin
    trvEntryAvailable.Items.BeginUpdate;
    try
      FillTreeEntryAvailable;
      FilterTreeView(edtFilterEntryAvailable.Text, trvEntryAvailable);
    finally
      trvEntryAvailable.Items.EndUpdate;
    end;
  end
end;

procedure TfrmConfigurarEventosFormulario.trvEntryAvailableDblClick
  (Sender: TObject);

  function GetNodeByText(ANode: TTreeNode; AValue: String): TTreeNode; overload;
  var
    LIndex: Integer;
  begin
    Result := nil;

    if not Assigned(ANode) then
      Exit;

    if UpperCase(ANode.Text) = UpperCase(AValue) then
      Exit(ANode);

    for LIndex := 0 to ANode.Count -1 do
    begin
      Result := GetNodeByText(ANode.Item[LIndex], AValue);
      if Result <> nil then
        Break;
    end;
  end;

  function GetNodeByText(ATree: TTreeView; AValue: String): TTreeNode; overload;
  var
    LNode: TTreeNode;
  begin
    Result := nil;
    for LNode in ATree.Items do
    begin
      Result := GetNodeByText(LNode, AValue);
      if Result <> nil then
        break;
    end;
  end;

var
  LControl: String;
  LEvent: String;
  LType: String;

begin
  inherited;
  if not Assigned(trvEntryAvailable.Selected) then
    Exit;

  if trvEntryAvailable.Selected.Count > 0 then
    Exit;

  LControl := trvEntryAvailable.Selected.Parent.Text;
  if LControl.Equals('Eventos') then
    LControl := trvEntryAvailable.Selected.Parent.Parent.Text;
  LEvent := trvEntryAvailable.Selected.Text;
  LType := FEntryPointManager.AvailableControls[LControl].ControlType;

  if not FEntryPointManager.SelectedControls.ContainsKey(LControl) then
    FEntryPointManager.SelectedControls.Add(LControl,
      TFormEntryPointControl.Create(LControl, LType));

  if not FEntryPointManager.SelectedControls[LControl].EntryPoints.ContainsKey
    (LEvent) then
    FEntryPointManager.SelectedControls[LControl].EntryPoints.Add(LEvent,
      TFormEntryPoint.Create(FEntryPointManager, LEvent));

  Self.FillTreeEntrySelected;

  pgcEntryPoints.ActivePage := tbsEntrySelected;

  GetNodeByText(trvEntrySelected, LControl).Selected := True;
  GetNodeByText(trvEntrySelected.Selected, LEvent).Selected := True;

  UpdateSelectedEntryPointActions;
end;

procedure TfrmConfigurarEventosFormulario.trvEntrySelectedClick
  (Sender: TObject);
begin
  inherited;
  UpdateSelectedEntryPointActions;
end;

procedure TfrmConfigurarEventosFormulario.UpdateSelectedEntryPointActions;
var
  LAction: TFormEntryPointAction;
  LControl: String;
  LEvent: String;
begin
  btnDelEntry.Enabled := False;
  btnDelAction.Enabled := False;
  btnAddAction.Enabled := False;

  FSelectedControl := nil;
  FSelectedEntry := nil;
  FSelectedAction := nil;

  lblEntryPoint.Caption := EmptyStr;

  if not cdsActions.Active then
  begin
    cdsActions.CreateDataSet;
    cdsActions.IndexFieldNames := 'ExecuteIndex';
  end;

  cdsActions.DisableControls;
  try
    cdsActions.EmptyDataSet;
  finally
    cdsActions.EnableControls;
  end;

  memScript.Lines.Clear;

  if trvEntrySelected.Selected = nil then
    Exit;

  while trvEntrySelected.Selected.Count > 0 do
    trvEntrySelected.Select(trvEntrySelected.Selected.Item[0]);

  if trvEntrySelected.Selected = nil then
    Exit;

  if trvEntrySelected.Selected.Parent = nil then
    Exit;

  if trvEntrySelected.Selected.Count > 0 then
    Exit;

  LControl := trvEntrySelected.Selected.Parent.Text;

  if LControl = 'Eventos' Then
    LControl := trvEntrySelected.Selected.Parent.Parent.Text;

  LEvent := trvEntrySelected.Selected.Text;
  lblEntryPoint.Caption := LControl + '.' + LEvent;

  if not Self.FEntryPointManager.SelectedControls.ContainsKey(LControl) then
    Exit;

  FSelectedControl := Self.FEntryPointManager.SelectedControls[LControl];

  if not FSelectedControl.EntryPoints.ContainsKey(LEvent) then
    Exit;

  FSelectedEntry := FSelectedControl.EntryPoints[LEvent];

  cdsActions.DisableControls;
  try
    for LAction in FSelectedEntry.Actions.Values do
    begin
      cdsActions.Append;
      cdsActionsId.AsString := LAction.Id;
      cdsActionsExecuteIndex.AsInteger := LAction.ExecuteIndex;
      cdsActionsDescription.AsString := LAction.Description;
      cdsActionsEnabled.AsBoolean := LAction.Enabled;
      cdsActions.Post;
    end;
  finally
    cdsActions.EnableControls;
  end;

  cxgActionsView.ViewData.DataController.GotoFirst;

  btnAddAction.Enabled := True;
  btnDelEntry.Enabled := True;
end;

end.
