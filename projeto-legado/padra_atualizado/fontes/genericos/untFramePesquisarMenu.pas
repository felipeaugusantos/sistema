unit untFramePesquisarMenu;

interface

uses
  StrUtils, Math, Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Clipbrd, UITypes, Principal.View.Interfaces,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Data.DB,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.StdCtrls,
  dxGDIPlusClasses, cxGroupBox, Datasnap.DBClient, UniClientDataSet, cxImage,
  Vcl.Menus, AdvMenus, AdvMenuStylers, System.ImageList, Vcl.ImgList,
  untFuncoesSimples, Uni, System.Generics.Collections;

type
  TDBgridCitel = class(DBGridCitel.TDBGridCitel)
    private
      //Removemos as barras de rolagem horizontal e vertical do grid
      procedure WMNCCalcSize(var msg: TMessage); message WM_NCCALCSIZE;
  end;

type
  TMenuFavoritos = class(TInterfacedObject, IInterface)
    private
      FFavoritos: TDicionario;
    public
      constructor Create;
      destructor Destroy; override;

      procedure pCarregarFavoritos;

      procedure pAdicionarFavorito(strMenu, strDescricao: String);
      procedure pRemoverFavorito(strMenu, strDescricao: String);

      property dicFavoritos: TDicionario Read FFavoritos write FFavoritos;
    End;

type
  TfraPesquisarMenu = class(TFrame)
    pnlFiltroPesquisa: TcxGroupBox;
    Image2: TImage;
    edtPesquisar: TEdit;
    pnlGridPesquisa: TcxGroupBox;
    dbgPesquisar: TDBGridCitel;
    pnlImagemGridPesquisa: TPanel;
    imgGridPesquisa: TImage;
    btnFavoritos: TcxImage;
    dtsPesquisar: TDataSource;
    cdsPesquisar: TUniClientDataSet;
    cdsPesquisarnome: TStringField;
    strngfldPesquisarDIRACE: TStringField;
    cdsPesquisardescricao_busca: TStringField;
    btnRecentes: TcxImage;
    popRecentes: TAdvPopupMenu;
    StyleMenu: TAdvMenuFantasyStyler;
    cdsPesquisarfavorito: TStringField;
    imgNaoFavorito: TImage;
    imgFavorito: TImage;
    popFavoritos: TAdvPopupMenu;
    cdsPesquisarsequencial: TAutoIncField;
    popOpcoesGrid: TPopupMenu;
    PermissoesdeAcesso: TMenuItem;
    btnDashboard: TcxImage;
    procedure edtPesquisarClick(Sender: TObject);
    procedure edtPesquisarEnter(Sender: TObject);
    procedure edtPesquisarExit(Sender: TObject);
    procedure edtPesquisarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPesquisarKeyPress(Sender: TObject; var Key: Char);
    procedure edtPesquisarChange(Sender: TObject);
    procedure dbgPesquisarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgPesquisarKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgPesquisarDblClick(Sender: TObject);
    procedure dbgPesquisarDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnRecentesClick(Sender: TObject);
    procedure dbgPesquisarEnter(Sender: TObject);
    procedure dbgPesquisarCellClick(Column: TColumn);
    procedure btnFavoritosClick(Sender: TObject);
    procedure PermissoesdeAcessoClick(Sender: TObject);
  private
    FMenuPesquisar: TAdvMainMenu;
    FMenuFavoritos: TMenuFavoritos;
    intMaxTextLengthGrid: Integer;
    function fGetPalavrasBusca: TStringList;
    function fPesquisarMenu: Boolean;
    { Private declarations }
  public
    { Public declarations }
    procedure pSetaMenu(mnuPesquisar: TAdvMainMenu);
    procedure OnFormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pLimparPesquisa;
    procedure pMontarPesquisa;
    procedure pAjustarPesquisa;
    procedure pGeraPopUpRecentes;
    procedure pGeraPopUpFavoritos;
    function Pesquisar(ATexto: String): IResultadoPesquisaAutcom;
    function RetornaTodos(): IResultadoPesquisaAutcom;
    destructor Destroy; override;
  end;

implementation

uses untMenuSemaforo, untSuportePlugins, untTMenuAutcom, untPermissaoAcesso;

Const
  INFO_PESQUISA = 'Ctrl+L Pesquisar Menus';

{$R *.dfm}

procedure TDBgridCitel.WMNCCalcSize(var msg: TMessage);
  Var
    style: Integer;
begin
  //Removemos as barras de rolagem horizontal e vertical do grid
  style := getWindowLong( handle, GWL_STYLE );
  SetWindowLong( handle, GWL_STYLE, style and not WS_HSCROLL and not WS_VSCROLL);
  inherited;
end;

{ TMenuFavoritos }

constructor TMenuFavoritos.Create;
begin
  FFavoritos := TDicionario.Create;
end;

destructor TMenuFavoritos.Destroy;
begin
  FreeAndNil(FFavoritos);
  inherited;
end;

procedure TMenuFavoritos.pAdicionarFavorito(strMenu, strDescricao: String);
begin
  If (FFavoritos.Chaves.Count > 0) And (FFavoritos.Chaves.IndexOf(strDescricao + strMenu) > -1) Then
    Exit;

  FFavoritos.Adicionar(strDescricao + strMenu, strMenu);

  fExecutaSQL(
    ' INSERT INTO MNUFAV ( ' +
    '   AUTOINCREM, ' +
    '   FAV_CODOPE, ' +
    '   FAV_CODEMP, ' +
    '   FAV_NOMMNU, ' +
    '   FAV_DESMNU ' +
    ' ) ' +
    ' VALUES ' +
    '   ( ' +
    '     ' + fRetAutoIncrem('MNUFAV', VS_strCodEmp).QuotedString +  ', ' +
    '     ' + strLoginUsuarioLogado.QuotedString + ', ' +
    '     ' + VS_strCodEmp.QuotedString + ', ' +
    '     ' + strMenu.QuotedString + ', ' +
    '     ' + strDescricao.QuotedString + ' ' +
    '   ) ' );
end;

procedure TMenuFavoritos.pCarregarFavoritos;
var
  qryFav: TUniQuery;
begin
  FFavoritos.Limpar;
  If Assigned(dicMnuFavoritos) Then
    FreeAndNil(dicMnuFavoritos);
  dicMnuFavoritos := TDictionary<string,string>.Create;

  qryFav := nil;

  Try
    Try
      qryFav := fCriaQuery();
      qryFav.SQL.Text :=
        ' SELECT                       '+
        '   M.FAV_DESMNU,              '+
        '   M.FAV_NOMMNU               '+
        ' FROM                         '+
        '   MNUFAV M                   '+
        '     LEFT JOIN RELMEN R ON SUBSTR(M.FAV_NOMMNU,4,6) = R.MEN_CODREL '+
        ' WHERE M.FAV_CODOPE = :CODOPE '+
        '   AND M.FAV_CODEMP = :CODEMP '+
        '   AND (((RIGHT(M.FAV_NOMMNU,3)  = "rel") AND (IFNULL(R.MEN_NOMMEN,"") <> "")) '+
        '    OR   (RIGHT(M.FAV_NOMMNU,3) <> "rel")) '+
        ' ORDER BY                     '+
        '   M.FAV_DESMNU               ';

      qryFav.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      qryFav.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryFav.Open;
      qryFav.First;

      While Not qryFav.Eof Do
      Begin
        FFavoritos.Adicionar(qryFav.FieldByName('FAV_DESMNU').AsString + qryFav.FieldByName('FAV_NOMMNU').AsString,
                             qryFav.FieldByName('FAV_NOMMNU').AsString);

        dicMnuFavoritos.AddOrSetValue(qryFav.FieldByName('FAV_DESMNU').AsString,
                                      qryFav.FieldByName('FAV_NOMMNU').AsString);
        qryFav.Next;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryFav) then
      FreeAndNil(qryFav);
    dicMnuFavoritos.TrimExcess;
  End;
end;

procedure TMenuFavoritos.pRemoverFavorito(strMenu, strDescricao: String);
begin
  If (FFavoritos.Chaves.Count > 0) And (FFavoritos.Chaves.IndexOf(strDescricao + strMenu) = -1) Then
    Exit;

  If (FFavoritos.Chaves.Count > 0) Then
    FFavoritos.Remove(strDescricao + strMenu);

  fExecutaSQL(' DELETE FROM MNUFAV ' +
              ' WHERE FAV_CODOPE = ' + strLoginUsuarioLogado.QuotedString + ' AND ' +
              '       FAV_CODEMP = ' + VS_strCodEmp.QuotedString + ' AND ' +
              '       FAV_DESMNU = ' + strDescricao.QuotedString + ' AND ' +
              '       FAV_NOMMNU = ' + strMenu.QuotedString + ' ');
end;

procedure TfraPesquisarMenu.pGeraPopUpFavoritos;
  var
    i           : Integer;
    item        : TComponent;
    strPathMenu,
    strDesMenu,
    strNameMenu : String;
begin
  popFavoritos.Items.Clear;

  FMenuFavoritos.pCarregarFavoritos;

  For strPathMenu In FMenuFavoritos.dicFavoritos.Chaves Do
  Begin
    item := nil;

    strNameMenu := FMenuFavoritos.dicFavoritos[strPathMenu];

    {*****************************************************************************}
    {* A CHAVE DO DICIONARIO E MONTADA COMO FAV_DESMNU + FAV_NOMMNU, ENTAO O     *}
    {* CAMINHO DO MENU E OBTIDO REMOVENDO APENAS O SUFIXO COM O NOME DO ITEM.    *}
    {* NAO USAR ReplaceStr AQUI: NOS MENUS DE TINTAS O NOME DO ITEM E IGUAL AO   *}
    {* CAPTION (EX.: 'Lazzumix'), E O ReplaceStr TAMBEM O REMOVERIA DE DENTRO DO *}
    {* CAMINHO, FAZENDO O fFindMenu NAO LOCALIZAR O ITEM E O FAVORITO NAO        *}
    {* APARECER NA LISTA.                                                        *}
    {*****************************************************************************}
    strDesMenu := Copy(strPathMenu, 1, Length(strPathMenu) - Length(strNameMenu));

    For i := 0 To FMenuPesquisar.Items.Count -1 Do
    Begin
      item := fFindMenu(strNameMenu,
                        FMenuPesquisar.Items[i],
                        False,
                        strDesMenu);

      If Assigned(item) Then
        Break;
    End;

    If Assigned(item) Then
      pGeraPopUp(GetParentForm(Self), item As TMenuItem, popFavoritos.Items, '', True);
  End;

  btnFavoritos.Visible := (FMenuFavoritos.dicFavoritos.Chaves.Count > 0);
end;

procedure TfraPesquisarMenu.pGeraPopUpRecentes;
  var
    i: Integer;
    item: TComponent;
    strMenu: String;
    stlRecentes: TStringList;
begin
  stlRecentes := TMenuAcessos.fGetRecentementeAcessados;

  popRecentes.Items.Clear;

  For strMenu In stlRecentes Do
  Begin
    item := nil;

    For i := 0 To FMenuPesquisar.Items.Count -1 Do
    Begin
      item := fFindMenu(strMenu, FMenuPesquisar.Items[i]);

      If Assigned(item) Then
        Break;
    End;

    If Assigned(item) Then
      pGeraPopUp(GetParentForm(Self), item As TMenuItem, popRecentes.Items, '', True);
  End;

  btnRecentes.Visible := (stlRecentes.Count > 0);

  FreeAndNil(stlRecentes);
end;

procedure TfraPesquisarMenu.pAjustarPesquisa;
begin
  pnlGridPesquisa.Width  := Min(intMaxTextLengthGrid + 50, Self.Width - 20);
  pnlGridPesquisa.Height := Min(240, Self.Height - pnlGridPesquisa.Top - 20);
  dbgPesquisar.Columns[1].Width := dbgPesquisar.Width - dbgPesquisar.Columns[0].Width;
end;

procedure TfraPesquisarMenu.PermissoesdeAcessoClick(Sender: TObject);
Var
  I: Integer;
  LMenuItem: TObject;
begin
  If cdsPesquisar.IsEmpty Then
    Exit;

  For I := 0 To FMenuPesquisar.Items.Count -1 Do
  Begin
    LMenuItem := fFindMenu(cdsPesquisar.FieldByName('nome').AsString, FMenuPesquisar.Items[I]);

    If Assigned(LMenuItem) Then
    Begin
      TfrmPermissaoAcesso.EditarPermissoes(TMenuItem(LMenuItem).Hint);
      Break;
    End;
  End;
end;

function TfraPesquisarMenu.Pesquisar(ATexto: String): IResultadoPesquisaAutcom;
Var
  I: Integer;
  LItem: TComponent;
  LNome: String;
  LDescricao: String;
begin
  Result := TResultadoPesquisaAutcom.New();

  pLimparPesquisa;

  edtPesquisar.Text := ATexto;

  fPesquisarMenu;

  cdsPesquisar.First;
  While Not cdsPesquisar.Eof Do
  Begin
    LNome := cdsPesquisar.FieldByName('nome').AsString;
    LDescricao := cdsPesquisar.FieldByName('descricao').AsString;

    LItem := nil;

    For I := 0 To FMenuPesquisar.Items.Count -1 Do
    Begin
      LItem := fFindMenu(LNome, FMenuPesquisar.Items[I]);

      If Assigned(LItem) Then
        Break;
    End;

    If Assigned(LItem) Then
      Result.Items.Add(TItemMenuAutcom.New(TMenuItem(LItem), False).SetCaption(LDescricao));

    cdsPesquisar.Next;
  End;

  pLimparPesquisa;
end;

procedure TfraPesquisarMenu.OnFormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If (Shift = ([ssCtrl])) And ((Key = Ord('l')) Or (Key = Ord('L'))) Then
  Begin
    pSetFocus(edtPesquisar);
  End;

  If (Key = VK_Escape) And (edtPesquisar.Text <> '') And edtPesquisar.Focused Then
  Begin
    Key := 0;
    edtPesquisar.Clear;
  End;

  If (Key = VK_Escape) And dbgPesquisar.Focused Then
  Begin
    Key := 0;
    pSetFocus(edtPesquisar);
  End;
end;

function TfraPesquisarMenu.fPesquisarMenu: Boolean;
  Var
    strFilter: String;
    strPalavra: String;
    stlPalavras: TStringList;
begin
  inherited;
  strFilter := '';

  stlPalavras := fGetPalavrasBusca;

  For strPalavra In stlPalavras Do
  Begin
    If Not fEmptyStr(strFilter) Then
      strFilter := strFilter + ' AND ';

    strFilter := strFilter + 'UPPER(descricao_busca) LIKE UPPER(' +
      QuotedStr('%' + fRemoveAcento(strPalavra) + '%') + ')';
  End;

  If fEmptyStr(strFilter) Then
    strFilter := '1 = 2';

  cdsPesquisar.Filtered := False;
  cdsPesquisar.Filter   := strFilter;
  cdsPesquisar.Filtered := True;

  Result := Not cdsPesquisar.IsEmpty;

  intMaxTextLengthGrid := pnlFiltroPesquisa.Width;

  pnlGridPesquisa.Visible := Result;

  If Result Then
  Begin
    GetParentForm(Self).Repaint;

    pAjustarPesquisa;

    GetParentForm(Self).Repaint;

    cdsPesquisar.First;
  End;

  FreeAndNil(stlPalavras);
end;

function TfraPesquisarMenu.fGetPalavrasBusca: TStringList;
  Var
    strPalavras: String;
begin
  Result := TStringList.Create;

  strPalavras := Trim(edtPesquisar.Text);

  While Pos('  ', strPalavras) > 0 Do
    strPalavras := AnsiReplaceStr(strPalavras, '  ', ' ');

  Result.Text := AnsiReplaceStr(strPalavras, ' ', #13#10);
end;

procedure TfraPesquisarMenu.pMontarPesquisa;
  Var
    intIndex: Integer;

  procedure pProcessaMenu(item: TMenuItem);
    Var
      intIndex    : Integer;
      strMenuPath : String;
  begin
    If Not item.Visible Then
      Exit;

    If item.Caption = '-' Then
      Exit;

    If item.Count = 0 Then
    Begin
      strMenuPath := fGetMenuPath(item);

      cdsPesquisar.Append;
      cdsPesquisar.FieldByName('nome').AsString            := item.Name;
      cdsPesquisar.FieldByName('descricao').AsString       := strMenuPath;
      cdsPesquisar.FieldByName('descricao_busca').AsString := fRemoveAcento(strMenuPath);
      cdsPesquisar.FieldByName('favorito').AsString        := IIF(FMenuFavoritos.dicFavoritos.Chaves.IndexOf(strMenuPath + item.Name) = -1, 'N', 'S');
      cdsPesquisar.Post;
    End
    Else
      For intIndex := 0 To item.Count -1 Do
        pProcessaMenu(item.Items[intIndex]);
  end;

begin
  If Not Assigned(FMenuFavoritos) Then
    FMenuFavoritos := TMenuFavoritos.Create;

  FMenuFavoritos.pCarregarFavoritos;

  If cdsPesquisar.Active Then
    cdsPesquisar.EmptyDataSet
  Else
    cdsPesquisar.CreateDataSet;

  For intIndex := 0 To FMenuPesquisar.Items.Count -1 Do
    pProcessaMenu(FMenuPesquisar.Items[intIndex]);

  cdsPesquisar.First;

  fPesquisarMenu;
end;

procedure TfraPesquisarMenu.pSetaMenu(mnuPesquisar: TAdvMainMenu);
begin
  FMenuPesquisar := mnuPesquisar;
end;

function TfraPesquisarMenu.RetornaTodos: IResultadoPesquisaAutcom;
Var
  I: Integer;
  LItem: TComponent;
  LNome,
  LDescricao: String;
begin
  Result := TResultadoPesquisaAutcom.New();

  cdsPesquisar.Filtered := False;
  cdsPesquisar.First;
  While Not cdsPesquisar.Eof Do
  Begin
    LNome      := cdsPesquisar.FieldByName('nome').AsString;
    LDescricao := cdsPesquisar.FieldByName('descricao').AsString;

    LItem := nil;

    For I := 0 To FMenuPesquisar.Items.Count -1 Do
    Begin
      LItem := fFindMenu(LNome, FMenuPesquisar.Items[I]);

      If Assigned(LItem) Then
        Break;
    End;

    If Assigned(LItem) Then
      Result.Items.Add(TItemMenuAutcom.New(TMenuItem(LItem), False).SetCaption(LDescricao));

    cdsPesquisar.Next;
  End;
end;

procedure TfraPesquisarMenu.pLimparPesquisa;
begin
  edtPesquisar.Text       := INFO_PESQUISA;
  edtPesquisar.Font.Color := clGray;
  pnlGridPesquisa.Visible := False;
end;

procedure TfraPesquisarMenu.btnFavoritosClick(Sender: TObject);
  Var
    Posicao: TPoint;
begin
  GetCursorPos(Posicao);
  popFavoritos.Popup(Posicao.X + 40, Posicao.Y);
  Windows.setFocus(0);
end;

procedure TfraPesquisarMenu.btnRecentesClick(Sender: TObject);
  Var
    Posicao: TPoint;
begin
  GetCursorPos(Posicao);
  popRecentes.Popup(Posicao.X + 40, Posicao.Y);
  Windows.setFocus(0);
end;

procedure TfraPesquisarMenu.dbgPesquisarCellClick(Column: TColumn);
begin
  If Column.FieldName = 'favorito' Then
    With cdsPesquisar Do
    Begin
      Edit;

      If FieldByName('favorito').AsString = 'S' Then
      Begin
        FieldByName('favorito').AsString := 'N';
        FMenuFavoritos.pRemoverFavorito(FieldByName('nome').AsString,
                                        FieldByName('descricao').AsString);
      End
      Else
      Begin
        FieldByName('favorito').AsString := 'S';
        FMenuFavoritos.pAdicionarFavorito(FieldByName('nome').AsString,
                                          FieldByName('descricao').AsString);
      End;

      Post;

      pGeraPopUpFavoritos;
    End;

  cdsPesquisar.FieldByName('descricao').FocusControl;
end;

procedure TfraPesquisarMenu.dbgPesquisarDblClick(Sender: TObject);
  Var
    i: Integer;
    item: TComponent;
    strMenu: String;
begin
  If cdsPesquisar.Active And Not cdsPesquisar.IsEmpty Then
  Begin
    strMenu := cdsPesquisar.FieldByName('nome').AsString;

    pLimparPesquisa;

    item := nil;

    For i := 0 To FMenuPesquisar.Items.Count -1 Do
    Begin
      item := fFindMenu(strMenu, FMenuPesquisar.Items[i]);

      If Assigned(item) Then
        Break;
    End;

    If Assigned(item) Then
    Begin
      TMenuItem(item).Click;
      pGeraPopUpRecentes;
    End;
  End;
end;

procedure TfraPesquisarMenu.dbgPesquisarDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
  Var
    strPalavra: String;
    stlPalavras: TStringList;
begin
  With TDBGridCitel(Sender) Do
  Begin
    if (DataSource = Nil) Or (DataSource.DataSet = nil) Or
       (Not DataSource.DataSet.Active) Or (DataSource.DataSet.RecordCount <= 0) Then
      Exit;

    If Canvas.Brush.Color = clHighlight Then
    Begin
      Canvas.Brush.Color := $00F9FFBF;
      Canvas.Font.Color  := clNavy;
      Canvas.FillRect(Rect);
      DefaultDrawColumnCell(Rect, DataCol, Column, State);
    End;

    If Column.FieldName = 'favorito' Then
    Begin
      Canvas.FillRect(Rect);

      If Column.Field.AsString = 'S' Then
        Canvas.Draw(Rect.Left + (Column.Width div 2 - imgFavorito.Picture.Bitmap.Width div 2),
                    Rect.Top + 1, imgFavorito.Picture.Bitmap)
      Else
        Canvas.Draw(Rect.Left + (Column.Width div 2 - imgNaoFavorito.Picture.Bitmap.Width div 2),
                    Rect.Top + 1, imgNaoFavorito.Picture.Bitmap);
    End;

    If Column.FieldName = 'descricao' Then
    Begin
      stlPalavras := fGetPalavrasBusca;

      For strPalavra In stlPalavras Do
        HighlightCellText(TDBGridCitel(Sender), Rect, Column, strPalavra, State, clYellow, clYellow, clNavy);

      intMaxTextLengthGrid := Max(intMaxTextLengthGrid, Canvas.TextWidth(Column.Field.AsString));

      FreeAndNil(stlPalavras);
    End;

  End;
end;

procedure TfraPesquisarMenu.dbgPesquisarEnter(Sender: TObject);
begin
  cdsPesquisar.FieldByName('descricao').FocusControl;
end;

procedure TfraPesquisarMenu.dbgPesquisarKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (ssCtrl In Shift) And (Key In [Ord('c'), Ord('C')]) Then
    Clipboard.AsText := cdsPesquisar.FieldByName('descricao').AsString;

  Case Key Of
    VK_RETURN: dbgPesquisarDblClick(nil);
    VK_UP: If cdsPesquisar.RecNo <= 1 Then pSetFocus(edtPesquisar);
  End;
end;

procedure TfraPesquisarMenu.dbgPesquisarKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_UP, VK_DOWN: pAjustarPesquisa;
  end;
end;

destructor TfraPesquisarMenu.Destroy;
begin
  If Assigned(FMenuFavoritos) Then
    FreeAndNil(FMenuFavoritos);
  inherited;
end;

procedure TfraPesquisarMenu.edtPesquisarChange(Sender: TObject);
begin
  fPesquisarMenu;
end;

procedure TfraPesquisarMenu.edtPesquisarClick(Sender: TObject);
begin
  edtPesquisarEnter(nil);
end;

procedure TfraPesquisarMenu.edtPesquisarEnter(Sender: TObject);
begin
  If edtPesquisar.Text = INFO_PESQUISA Then
  Begin
    edtPesquisar.Clear;
    edtPesquisar.Font.Color := clWindowText;
  End;
end;

procedure TfraPesquisarMenu.edtPesquisarExit(Sender: TObject);
begin
  If fEmptyStr(edtPesquisar.Text) Then
    pLimparPesquisa;
end;

procedure TfraPesquisarMenu.edtPesquisarKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  edtPesquisarEnter(nil);
  If (cdsPesquisar.Active And Not cdsPesquisar.IsEmpty) And
     (Key In [VK_DOWN, VK_UP, VK_RETURN]) Then
  Begin
    Case Key Of
      VK_DOWN, VK_RETURN: pSetFocus(dbgPesquisar);
    End;
  End;
end;

procedure TfraPesquisarMenu.edtPesquisarKeyPress(Sender: TObject; var Key: Char);
begin
  edtPesquisarEnter(nil);
end;

end.
