unit untRelMenuFavoritos;

interface

uses Windows, System.UITypes, untPai, Vcl.ComCtrls, System.ImageList, Vcl.ImgList,
  Vcl.Controls, cxImageList, cxGraphics, Vcl.StdCtrls, EditFocus, QColorLabel,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, System.Classes, SysUtils, strUtils, Dialogs,
  Uni;

type
  TfrmRelMenuFavoritos = class(TfrmPai)
    pnlCabecalho: TPanel;
    lblRomaneio: TLabel;
    edtDescricaoFavoritos: TEditFocus;
    btnConfirma: TBitBtnLocked;
    Label1: TLabel;
    ColorLabel4: TColorLabel;
    imgIcones: TcxImageList;
    edtHabilitaFavoritos: TEditFocus;
    trvMenuRel: TTreeView;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtHabilitaFavoritosKeyPress(Sender: TObject; var Key: Char);
    procedure trvMenuRelClick(Sender: TObject);
    procedure trvMenuRelKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtHabilitaFavoritosChange(Sender: TObject);

  private
    { Private declarations }
    stlMenRel : TStringList;
    qryRelFav : TUniQuery;

    Const
    cChecked = 1;
    cUnChecked = 2;

    procedure pCarregaFavoritos;
    procedure pCarregaMenu;
    procedure pMontaTreeView(Item: TMenuItem; NoPai: TTreeNode; strKey: String);
    procedure ToggleTreeViewCheckBoxes(Node : TTreeNode; State: Integer);
    procedure ToggleChildren(Node : TTreeNode; State: Integer);
    procedure ToggleParent(Node : TTreeNode; State: Integer);
    procedure pSalvaMenu;

    function fTemFavoritoSelecionado: Boolean;
    function fReturnState(strMenu: String): Integer;
    function fParenTemFilhoChecked(Node : TTreeNode): Boolean;

  public
    { Public declarations }

  end;

implementation

uses untFuncoesSimples, untPrincipal;

{$R *.dfm}

{ TfrmFatBaixaRomaneio }

procedure TfrmRelMenuFavoritos.btnConfirmaClick(Sender: TObject);
begin
  If Not fTemFavoritoSelecionado Then
  Begin
    fMensagem('AVISO', 'Nenhum menu de relatório foi selecionado.', ['&O k']);
    Exit;
  End;

  If fMensagem('AVISO', 'Confirma alterações?', ['&Sim', '&Não']) = 1 Then
  Begin
    fExecutarModal(pSalvaMenu, 'Salvando menu de relatórios favoritos, Aguarde ...', '');
    fMensagem('AVISO', 'Menu de relatórios favoritos configurado com sucesso!', ['&O k']);
    pSetFocus(edtHabilitaFavoritos);
  End;
end;

procedure TfrmRelMenuFavoritos.edtHabilitaFavoritosChange(Sender: TObject);
begin
  inherited;
  edtDescricaoFavoritos.Enabled := edtHabilitaFavoritos.Text <> 'N';
  trvMenuRel.Enabled := edtHabilitaFavoritos.Text <> 'N';
end;

procedure TfrmRelMenuFavoritos.edtHabilitaFavoritosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Not (CharInSet(Key,['n','N','s','S',#8])) then
    Key:= #0;
end;

procedure TfrmRelMenuFavoritos.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtHabilitaFavoritos);
end;

procedure TfrmRelMenuFavoritos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(stlMenRel);
  FreeAndNil(qryRelFav);
end;

procedure TfrmRelMenuFavoritos.FormCreate(Sender: TObject);
begin
  inherited;
  stlMenRel := TStringList.Create;
end;

procedure TfrmRelMenuFavoritos.FormShow(Sender: TObject);
begin
  inherited;

  fExecutarModal(pCarregaMenu, 'Carregando menu de relatórios, Aguarde ...', '');
end;

procedure TfrmRelMenuFavoritos.pCarregaFavoritos;
begin
  If Not Assigned(qryRelFav) Then
    qryRelFav := fCriaQuery(nil);

  qryRelFav.SQL.Clear;
  qryRelFav.SQL.Add('SELECT * FROM RELFAV');
  qryRelFav.SQL.Add('ORDER BY AUTOINCREM ');
  qryRelFav.Open;

  If Not qryRelFav.IsEmpty Then
  Begin
    edtHabilitaFavoritos.Text  := qryRelFav.FieldByName('FAV_HABILI').AsString;
    edtDescricaoFavoritos.Text := qryRelFav.FieldByName('FAV_DESMEN').AsString;
  End
  Else
  Begin
    edtHabilitaFavoritos.Text  := 'N';
    edtDescricaoFavoritos.Text := 'Relatórios Favoritos';
  End;

  edtHabilitaFavoritosChange(edtHabilitaFavoritos);
end;

procedure TfrmRelMenuFavoritos.pCarregaMenu;
Var
  Item: TMenuItem;
  intIndice: Integer;
begin
  pCarregaFavoritos;

  trvMenuRel.Items.BeginUpdate;
  Try
    For intIndice := 0 To frmPrincipal.mnuRelatorio.Count-1 Do
    Begin
      Item := frmPrincipal.mnuRelatorio.Items[intIndice];
      pMontaTreeView(Item, nil, '');
    End;
  Finally
    trvMenuRel.Items.EndUpdate;
  End;
end;

procedure TfrmRelMenuFavoritos.pMontaTreeView(Item: TMenuItem; NoPai: TTreeNode;
  strKey: String);
Var
  intIndice: Integer;
  NoFilho: TTreeNode;
begin
  If (Item.Caption = 'Criar Novo Relatório') Then
    Exit;

  If (Item.Name = 'mnuRelatoriosFavoritos') Then
    Exit;

  If (Item.Parent.Name = 'mnuRelatoriosFavoritos') Then
    Exit;

  If Item.Caption <> '-' Then
    If Item.Hint = '' Then
      Item.Hint := Item.Name;

  If (Item.Count > 0) Then
  Begin
    If (Item.Caption <> '-') and (Item.Tag <> 7654321) Then
    Begin
      NoPai := trvMenuRel.Items.AddChild(NoPai, AnsiReplaceStr(Item.Caption, '&', ''));
      NoPai.StateIndex := fReturnState(Item.Name);
      stlMenRel.AddObject(Item.Hint, Item);
    End;

    For intIndice := 0 To Item.Count - 1 Do
      pMontaTreeView(Item.Items[intIndice], NoPai, strKey);
  End
  Else
  Begin
    If (Item.Caption <> '-') and (Item.Tag <> 7654321) Then
    Begin
      NoFilho := trvMenuRel.Items.AddChild(NoPai, AnsiReplaceStr(Item.Caption, '&', ''));
      NoFilho.StateIndex := fReturnState(Item.Name);
      stlMenRel.AddObject(Item.Hint, Item);
    End;
  End;
end;

procedure TfrmRelMenuFavoritos.pSalvaMenu;
Var
  qryRel : TUniQuery;
  strSQL : String;
  i : Integer;
begin
  qryRel := fCriaQuery(nil);

  qryRel.SQL.Clear;
  qryRel.SQL.Add('DELETE FROM RELFAV ');
  qryRel.ExecSQL;

  strSQL := '';
  strSQL := strSQL + 'INSERT INTO     ';
  strSQL := strSQL + '  RELFAV (      ';
  strSQL := strSQL + '    AUTOINCREM, ';
  strSQL := strSQL + '    FAV_HABILI, ';
  strSQL := strSQL + '    FAV_DESMEN, ';
  strSQL := strSQL + '    FAV_NOMREL) ';
  strSQL := strSQL + '  VALUES (      ';
  strSQL := strSQL + '    :AUTINC,    ';
  strSQL := strSQL + '    :HABILI,    ';
  strSQL := strSQL + '    :DESMEN,    ';
  strSQL := strSQL + '    :NOMREL)    ';

  Try
    For i := 0 to trvMenuRel.Items.Count-1 Do
    Begin
      If (trvMenuRel.Items[i].StateIndex = 1) Then
      Begin
        qryRel.SQL.Clear;
        qryRel.SQL.Add(strSQL);
        qryRel.ParamByName('AUTINC').AsString := fRetAutoIncrem('RELFAV', VS_strCodEmp);
        qryRel.ParamByName('HABILI').AsString := edtHabilitaFavoritos.Text;
        qryRel.ParamByName('DESMEN').AsString := edtDescricaoFavoritos.Text;
        qryRel.ParamByName('NOMREL').AsString := TMenuItem(stlMenRel.Objects[i]).Name;
        qryRel.ExecSQL;
      End;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[ pSalvaMenu ]');
  End;

  FreeAndNil(qryRel);
end;

function TfrmRelMenuFavoritos.fParenTemFilhoChecked(Node : TTreeNode): Boolean;
var
  tmp : TTreeNode;
begin
  Result := False;;
  tmp    := Node.getFirstChild;

  while Assigned(tmp) do
  begin
    If (tmp.StateIndex = cChecked) Then
    Begin
      Result := True;
      Exit;
    End;

    tmp := tmp.getNextSibling;
  end;
end;

function TfrmRelMenuFavoritos.fReturnState(strMenu: String): Integer;
begin
  If qryRelFav.Locate('FAV_NOMREL', strMenu, []) Then
    Result := 1
  Else
    Result := 2;
end;

function TfrmRelMenuFavoritos.fTemFavoritoSelecionado: Boolean;
Var
  i: Integer;
begin
  Result := False;
  For i := 0 to trvMenuRel.Items.Count-1 Do
    If (trvMenuRel.Items[i].StateIndex = 1) Then
    Begin
      Result := True;
      Break;
    End;
end;

procedure TfrmRelMenuFavoritos.ToggleChildren(Node : TTreeNode; State: Integer);
var
  tmp : TTreeNode;
begin
  If (Node.HasChildren) Then
  Begin
    tmp := Node.getFirstChild;

    while Assigned(tmp) do
    begin
      tmp.StateIndex := State;

      tmp := tmp.getNextSibling;

      If Assigned(tmp) then
        If tmp.HasChildren then
          ToggleTreeViewCheckBoxes(tmp, State);
    end;
  End;
end;

procedure TfrmRelMenuFavoritos.ToggleParent(Node : TTreeNode; State: Integer);
var
  tmp : TTreeNode;
begin
  If Assigned(Node.Parent) Then
  Begin
    tmp := Node.Parent;

    If (State = cChecked) Then
      tmp.StateIndex := State

    Else If Not fParenTemFilhoChecked(tmp) Then
      tmp.StateIndex := State;

    ToggleParent(tmp, State);
  End;
end;

procedure TfrmRelMenuFavoritos.ToggleTreeViewCheckBoxes(Node : TTreeNode; State: Integer);
begin
  if Assigned(Node) then
  begin
    Node.StateIndex := State;

    ToggleChildren(Node, State);
    ToggleParent(Node, State);
  end;
end;

procedure TfrmRelMenuFavoritos.trvMenuRelClick(Sender: TObject);
var
 P : TPoint;
begin
  GetCursorPos(P);
  P := trvMenuRel.ScreenToClient(P);

  If (htOnStateIcon in trvMenuRel.GetHitTestInfoAt(P.X,P.Y)) Then
  Begin
    Case trvMenuRel.Selected.StateIndex Of
      cChecked   : ToggleTreeViewCheckBoxes(trvMenuRel.Selected, cUnChecked);
      cUnChecked : ToggleTreeViewCheckBoxes(trvMenuRel.Selected, cChecked);
    End;
  End;
end;

procedure TfrmRelMenuFavoritos.trvMenuRelKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_SPACE:
    Begin
      if (Key = VK_SPACE) and Assigned(trvMenuRel.Selected) then
      Begin
        Case trvMenuRel.Selected.StateIndex Of
          cChecked   : ToggleTreeViewCheckBoxes(trvMenuRel.Selected, cUnChecked);
          cUnChecked : ToggleTreeViewCheckBoxes(trvMenuRel.Selected, cChecked);
        End;
      End;
    End;

    VK_RETURN: pSetFocus(btnConfirma);
    VK_F10  : btnConfirma.Click;
  End;
end;

end.


