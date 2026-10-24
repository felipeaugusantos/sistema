unit untPromocoesAutResumo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ComCtrls, System.ImageList, Vcl.ImgList, cxImageList,
  cxGraphics, MemoFocus, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxImage, dxGDIPlusClasses;

type
  TNodeData = class
  private
    FblnInfo: Boolean;
    FstrMensagem: String;
  public
    property strMensagem: String read FstrMensagem write FstrMensagem;
    property blnInfo: Boolean read FblnInfo write FblnInfo;
  end;

  TfrmPromocoesAutResumo = class(TfrmPai)
    trvMenu: TTreeView;
    cxImgLst: TcxImageList;
    memObs: TMemoFocus;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    cxImage1: TcxImage;
    cxImage2: TcxImage;
    procedure trvMenuChange(Sender: TObject; Node: TTreeNode);
  private
    { Private declarations }
  public
    { Public declarations }
    function fAddItem(strMensagem: String; NoPai: TTreeNode; blnOk: Boolean = True; blnInfo: Boolean = False): TTreeNode;
    procedure pSetError(Node: TTreeNode);
  end;

implementation

{$R *.dfm}

{ ******************************************* }
{ * MONTA A TREEVIEW COM AS OPÇÕES DO MENU  * }
{ ****************************************DV* }
function TfrmPromocoesAutResumo.fAddItem(strMensagem: String; NoPai: TTreeNode; blnOk: Boolean = True; blnInfo: Boolean = False): TTreeNode;
var
  idxImage: Integer;
  NodeData: TNodeData;
  strMsg: String;
begin
  strMsg := strMensagem.Replace(sLineBreak, ' ', [rfReplaceAll]);

  Result := trvMenu.Items.AddChild(NoPai, strMsg);

  if blnInfo then
    idxImage := -1
  else
  begin
    if blnOk then
      idxImage := 0
    else
      idxImage := 1;
  end;

  Result.ImageIndex         := idxImage;
  Result.SelectedIndex      := idxImage;
  Result.StateIndex         := idxImage;
  Result.ExpandedImageIndex := idxImage;

  NodeData := TNodeData.Create;
  NodeData.strMensagem := strMensagem;
  NodeData.blnInfo := blnInfo;

  Result.Data := NodeData;
end;

procedure TfrmPromocoesAutResumo.pSetError(Node: TTreeNode);
begin
  Node.ImageIndex         := 1;
  Node.SelectedIndex      := 1;
  Node.StateIndex         := 1;
  Node.ExpandedImageIndex := 1;
end;

procedure TfrmPromocoesAutResumo.trvMenuChange(
  Sender: TObject; Node: TTreeNode);
var
  NodeData: TNodeData;
begin
  inherited;
  NodeData := TNodeData(Node.Data);
  if not Assigned(NodeData) then
    Exit;

  if NodeData.blnInfo then
    memObs.Lines.Text := NodeData.strMensagem
  else
    memObs.Lines.Text := '';
end;

end.
