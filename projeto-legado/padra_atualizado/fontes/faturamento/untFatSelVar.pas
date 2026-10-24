unit untFatSelVar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, TypInfo,
  BitBtnLockedIncrem, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, System.Rtti,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, Printers, UniClientDataSet, Uni,
  cxImageComboBox, ImgList, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator,
  frxClass, frxExportCSVTestabilidade, System.ImageList, cxImageList,
  Datasnap.DBClient, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxContainer, cxTreeView, IOUtils, strUtils, dxGDIPlusClasses, cxGroupBox,
  CommCtrl, untFuncoesSimples;

type
  TfrmFatSelVar = class(TfrmPai)
    cxmglstImagens: TcxImageList;
    trvVariables: TTreeView;
    Panel2: TPanel;
    cxGroupBox1: TcxGroupBox;
    Image1: TImage;
    edtPesquisar: TEdit;
    tmrPesquisar: TTimer;
    Panel3: TPanel;
    btnCancelar: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure edtPesquisarChange(Sender: TObject);
    procedure trvVariablesDblClick(Sender: TObject);
    procedure tmrPesquisarTimer(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure trvVariablesChange(Sender: TObject; Node: TTreeNode);
  private
    FObject: TObject;
    FPrefix: String;
    FVarSel: String;
    FCampos: TCamposUso;
    FObjectNode: TTreeNode;
    FBooleanNode: TTreeNode;
    FDatetimeNode: TTreeNode;
    FFloatNode: TTreeNode;
    FIntegerNode: TTreeNode;
    FStringNode: TTreeNode;
  private
    procedure pLoadProperties;
    procedure pAddNodes;
    procedure pCleanNodes;
    procedure pLoadCampos;
    procedure pAddChild(ANode: TTreeNode; AField: String);
  public
    class function SelectProperty(AObject: TObject; APrefix: String; ACampos: TCamposUso): String;
  end;

implementation

{$R *.dfm}

class function TfrmFatSelVar.SelectProperty(AObject: TObject; APrefix: String; ACampos: TCamposUso): String;
var
  LFrm: TfrmFatSelVar;
begin
  pCriarFormularios(TfrmFatSelVar, LFrm);
  try
    LFrm.FObject := AObject;
    LFrm.FPrefix := APrefix;
    Lfrm.FCampos := ACampos;
    LFrm.ShowModal;
    Result := LFrm.FVarSel;
  finally
    pFreeAndNil(LFrm);
  end;
end;

procedure TfrmFatSelVar.tmrPesquisarTimer(Sender: TObject);
begin
  inherited;
  tmrPesquisar.Enabled := False;
  pLoadProperties;
  if not fEmptyStr(edtPesquisar.Text) then
    trvVariables.FullExpand
  else
    trvVariables.FullCollapse;
  trvVariables.Selected := FObjectNode;
end;

procedure TfrmFatSelVar.trvVariablesChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  btnConfirmar.Enabled := Assigned(Node) And (Node.Count = 0) And (Node.Level >= 1);
end;

procedure TfrmFatSelVar.trvVariablesDblClick(Sender: TObject);
begin
  inherited;
  if btnConfirmar.Enabled then
  begin
    FVarSel := trvVariables.Selected.Text;
    Self.Close;
  end;
end;

procedure TfrmFatSelVar.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  if btnConfirmar.Enabled then
  begin
    FVarSel := trvVariables.Selected.Text;
    Self.Close;
  end;
end;

procedure TfrmFatSelVar.btnSairClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfrmFatSelVar.edtPesquisarChange(Sender: TObject);
begin
  inherited;
  tmrPesquisar.Enabled := False;
  tmrPesquisar.Enabled := True;
end;

procedure TfrmFatSelVar.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtPesquisar);
  pLoadProperties;
end;

procedure TfrmFatSelVar.pAddChild(ANode: TTreeNode; AField: String);
var
  LText: String;
  LWords: TArray<String>;
  LChild: TTreeNode;
begin
  LText := edtPesquisar.Text;

  while LText.Contains('  ') do
    LText := LText.Replace('  ', ' ');

  LWords := LText.Split([' ']);

  for LText in LWords do
    if not LText.IsEmpty and not AField.ToLower.Contains(LText.ToLower) then
      Exit;

  LChild := trvVariables.Items.AddChild(ANode, AField);
  LChild.ImageIndex := 6;
  LChild.SelectedIndex := 6;
end;

procedure TfrmFatSelVar.pAddNodes;
begin
  trvVariables.Perform(TVM_SETITEMHEIGHT, 20, 0);
  trvVariables.Items.Clear;

  FObjectNode := trvVariables.Items.Add(nil, FObject.ClassName);
  FBooleanNode := trvVariables.Items.AddChild(FObjectNode, 'Boolean');
  FDatetimeNode := trvVariables.Items.AddChild(FObjectNode, 'Datetime');
  FFloatNode := trvVariables.Items.AddChild(FObjectNode, 'Float');
  FIntegerNode := trvVariables.Items.AddChild(FObjectNode, 'Integer');
  FStringNode := trvVariables.Items.AddChild(FObjectNode, 'String');

  FObjectNode.ImageIndex := 0;
  FBooleanNode.ImageIndex := 1;
  FDatetimeNode.ImageIndex := 2;
  FFloatNode.ImageIndex := 3;
  FIntegerNode.ImageIndex := 4;
  FStringNode.ImageIndex := 5;

  FObjectNode.SelectedIndex := 0;
  FBooleanNode.SelectedIndex := 1;
  FDatetimeNode.SelectedIndex := 2;
  FFloatNode.SelectedIndex := 3;
  FIntegerNode.SelectedIndex := 4;
  FStringNode.SelectedIndex := 5;
end;

procedure TfrmFatSelVar.pCleanNodes;
begin
  if FBooleanNode.Count = 0 then
    FBooleanNode.Delete;

  if FDatetimeNode.Count = 0 then
    FDatetimeNode.Delete;

  if FFloatNode.Count = 0 then
    FFloatNode.Delete;

  if FIntegerNode.Count = 0 then
    FIntegerNode.Delete;

  if FStringNode.Count = 0 then
    FStringNode.Delete;

  if FObjectNode.Count = 0 then
    FObjectNode.Delete;
end;

procedure TfrmFatSelVar.pLoadCampos;
var
  LKey: String;
  LNode: TTreeNode;
begin
  if not assigned(FCampos) then
    exit;

  LNode := trvVariables.Items.Add(nil, FCampos.ClassName);

  LNode.ImageIndex := 0;
  LNode.SelectedIndex := 0;

  for LKey in FCampos.GetKeys do
    pAddChild(LNode, LKey);

  if LNode.Count = 0 then
    LNode.Delete;
end;

procedure TfrmFatSelVar.pLoadProperties;
var
  LCtx: TRttiContext;
  LType: TRttiType;
  LProp: TRttiProperty;
begin
  pAddNodes;
  LCtx := TRttiContext.Create;
  try
    LType := LCtx.GetType(FObject.ClassInfo);
    for LProp in LType.GetProperties do
    begin
      if not FPrefix.IsEmpty And not FPrefix.ToUpper.Contains
        (LeftStr(LProp.Name, 3).ToUpper) then
        Continue;

      if LProp.PropertyType.TypeKind in [tkString, tkUString, tkWString,
        tkLString] then
        pAddChild(FStringNode, LProp.Name);

      if LProp.PropertyType.TypeKind in [tkInteger] then
        pAddChild(FIntegerNode, LProp.Name);

      if LProp.PropertyType.TypeKind in [tkFloat] then
        if LProp.PropertyType.Name.Contains('TDate') then
          pAddChild(FDatetimeNode, LProp.Name)
        else
          pAddChild(FFloatNode, LProp.Name);

      if LProp.PropertyType.TypeKind in [tkEnumeration] then
        if 'false_true'.Contains(LProp.GetValue(FObject).ToString.ToLower) Then
          pAddChild(FBooleanNode, LProp.Name);
    end;
  finally
    LCtx.Free;
  end;
  pLoadCampos;
  pCleanNodes;
end;

end.
