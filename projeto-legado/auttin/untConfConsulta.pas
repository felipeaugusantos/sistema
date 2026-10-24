unit untConfConsulta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxContainer, cxListBox, ExtCtrls,
    Uni, untIConsultaTinta,
  StdCtrls, Buttons, dbcgrids, UniClientDataSet, Mask, DBCtrls, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, MemDS, DBAccess,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmConfConsulta = class(TFrame) 
    dtsPrevia: TDataSource;
    qryPrevia: TUniQuery;
    lstDisponiveis: TListBox;
    grpVisiveis: TGroupBox;
    dbgConsulta: TcxGrid;
    dbgViewConsulta: TcxGridDBTableView;
    dbgLvlConsulta: TcxGridLevel;
    grpDisponiveis: TGroupBox;
    grpIndices: TGroupBox;
    lstIndices: TListBox;
    grpPreviaTexto: TGroupBox;
    btnLimparDescri: TSpeedButton;
    lblPreviaTexto: TLabel;
    procedure dbgViewConsultaColumnSizeChanged(Sender: TcxGridTableView; AColumn: TcxGridColumn);
    procedure dbgViewConsultaColumnPosChanged(Sender: TcxGridTableView; AColumn: TcxGridColumn);
    procedure dbgViewConsultaCustomDrawColumnHeader(Sender: TcxGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean);
    procedure qryPreviaAfterScroll(DataSet: TDataSet);
    procedure dbgViewConsultaDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure dbgViewConsultaDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lstDisponiveisDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure lstDisponiveisDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure dbgViewConsultaColumnHeaderClick(Sender: TcxGridTableView; AColumn: TcxGridColumn);
    procedure dbctrlgrdIndicesDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure lstIndicesDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure lstIndicesDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lstIndicesKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grpPreviaTextoDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure grpPreviaTextoDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure btnLimparDescriClick(Sender: TObject);
  private
    tinta: IConsultaTinta;
    Canvas: TCanvas;
    { Private declarations }
    procedure ConstruirGrid;
    procedure Preview;
    function fGetNomeColuna(strNomeColuna: String; blnCampoAS: Boolean = False): String;
    procedure pAdicionarSelecionado;
    procedure pRemoverColuna(coluna: TcxGridColumn);
    function fAcharColuna(strTitulo: String): TcxGridColumn;
    function fNovaColuna(strNomeCampo, strTitulo: String): TcxGridDBColumn;
    procedure pDeletaDuplicados;
    function fGetCampos(strDesIndices: String): String;
    procedure pConstruirIndices;
    procedure pLimparLabels;
  public
    procedure pSalvarConfs();
    constructor Create(AOwner: TComponent; Parent: TWinControl;
      Canvas: TCanvas; tinta: IConsultaTinta); reintroduce;
    function fContaCaracteres(strTexto: String; char: Char): Integer;
    function fEstaNoIndice(strNovo, strAtual: String): Boolean;
    procedure pRestaurarPadrao;
    { Public declarations }
  end;

implementation

uses
   Types, SysConst, StrUtils;

{$R *.dfm}

{ TfrmConfConsulta }

procedure TfrmConfConsulta.ConstruirGrid;
var
  intCont: Integer;
  blnCampoAS: Boolean;
begin
  qryPrevia.Close;
  qryPrevia.SQL.Text := tinta.fGetSelect(True) + ' LIMIT 10 ';
  qryPrevia.Open;

  With tinta Do
  Begin
    For intCont := 0 to fGetQtdColunasVisiveis - 1 Do
    Begin
      blnCampoAS := ((Length(fGetNomeCampoColunaVisivel(intCont)) > 10) and
                    (Pos(' AS ',fGetNomeCampoColunaVisivel(intCont)) > 0));

      qryPrevia.FieldByName(fGetNomeColuna(fGetNomeCampoColunaVisivel(intCont), blnCampoAS)).DisplayLabel :=
        fGetCaptionColunaVisivel(intCont)
    End;

    For intCont := 0 to fGetQtdColunasVisiveis - 1 do
    Begin
      fNovaColuna(fGetNomeColuna(fGetNomeCampoColunaVisivel(intCont)),
        fGetCaptionColunaVisivel(intCont));
    End;

    For intCont := 0 To fGetQtdColunas - 1 Do
    Begin
      If (Not fGetVisivel(intCont)) And (fGetDisponivel(intCont)) Then
        lstDisponiveis.Items.Add(fGetCaptionColuna(intCont));
    End;
  End;
  dbgViewConsulta.ApplyBestFit();
  
end;

constructor TfrmConfConsulta.Create(AOwner: TComponent; Parent: TWinControl;
  Canvas: TCanvas; tinta: IConsultaTinta);
begin
  inherited Create(AOwner);
  Self.tinta := tinta;
  Self.Parent := Parent;
  Self.Canvas := Canvas;
  ConstruirGrid;
  pConstruirIndices;
  qryPrevia.AfterScroll := qryPreviaAfterScroll;

  btnLimparDescri.Align := alRight;
  btnLimparDescri.Width := Canvas.TextWidth(btnLimparDescri.Caption) + 10;

  Preview;

  dbgConsulta.Enabled := not(QryPrevia.IsEmpty);

end;

procedure TfrmConfConsulta.Preview;
  Var
    intCont: Integer;
    blnCampoAS: Boolean;
begin
  pLimparLabels;
  grpPreviaTexto.Caption := 'Descrição da Tinta ( ';

  For intCont := 0 To tinta.fGetQtdCamposDescricao - 1 Do
  Begin
    blnCampoAS := ((Length(tinta.fGetCampoDescricao(intCont)) > 10) and
                  (Pos(' AS ',tinta.fGetCampoDescricao(intCont)) > 0));
    With lblPreviaTexto Do
    Begin
      Caption := Caption + ' ' +
        qryPrevia.FieldByName(fGetNomeColuna(tinta.fGetCampoDescricao(intCont),blnCampoAS)).AsString;
    End;

    grpPreviaTexto.Caption := grpPreviaTexto.Caption +
      tinta.fGetDesCampoDescricao(intCont) + '/';
  End;

  lblPreviaTexto.Caption := Trim(lblPreviaTexto.Caption);
  grpPreviaTexto.Caption := Copy(grpPreviaTexto.Caption, 1, Length(grpPreviaTexto.Caption) - 1);
  grpPreviaTexto.Caption := grpPreviaTexto.Caption + ')';
end;

procedure TfrmConfConsulta.dbgViewConsultaColumnSizeChanged(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  Preview;
end;

procedure TfrmConfConsulta.dbgViewConsultaColumnPosChanged(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  Preview;
  tinta.fSetPos(TcxGridDBColumn(AColumn).DataBinding.FieldName, AColumn.Index);
end;

procedure TfrmConfConsulta.dbgViewConsultaCustomDrawColumnHeader(
  Sender: TcxGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
//  Preview;
end;

procedure TfrmConfConsulta.qryPreviaAfterScroll(DataSet: TDataSet);
begin
  Preview;
end;

function TfrmConfConsulta.fGetNomeColuna(strNomeColuna: String; blnCampoAS: Boolean = False): String;
  Var
    intPos: Integer;
begin
  if not blnCampoAS then
    Result := strNomeColuna
  else
    Result := RightStr(strNomeColuna,13);

  If Pos('AS', Result) > 0 Then
    Result := RightStr(strNomeColuna, 10);

  intPos := Pos('.', Result);
  If intPos > 0 Then
  Begin
    Result := Copy(Result, intPos + 1, Length(Result));
  End;
end;

procedure TfrmConfConsulta.dbgViewConsultaDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source Is TListBox);
end;

procedure TfrmConfConsulta.dbgViewConsultaDragDrop(Sender, Source: TObject;
  X, Y: Integer);
begin
  pAdicionarSelecionado;
end;

procedure TfrmConfConsulta.pAdicionarSelecionado;
  Var
    strSelecionado: String;
    coluna: TcxGridDBColumn;
    intCont: Integer;
begin

  For intCont := 0 To lstDisponiveis.Count - 1 Do
  Begin
    If lstDisponiveis.Selected[intCont] Then
    Begin
      strSelecionado := lstDisponiveis.Items.Strings[intCont];

      coluna := TcxGridDBColumn(fAcharColuna(strSelecionado));

      If coluna <> nil Then
      Begin
        coluna.Visible := True;
        coluna.Index := dbgViewConsulta.ColumnCount - 1;
        tinta.fSetVisivel(tinta.fGetNomeCampoColuna(strSelecionado), True);
        Continue;
      End;

      fNovaColuna(fGetNomeColuna(tinta.fGetNomeCampoColuna(strSelecionado)),
        strSelecionado);

      tinta.fSetVisivel(tinta.fGetNomeCampoColuna(strSelecionado), True);
    End;
  End;

  lstDisponiveis.DeleteSelected;
  Preview;
end;

procedure TfrmConfConsulta.lstDisponiveisDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source is TDragControlObject;
end;

procedure TfrmConfConsulta.lstDisponiveisDragDrop(Sender, Source: TObject;
  X, Y: Integer);
begin
  pRemoverColuna(dbgViewConsulta.Controller.FocusedColumn);
end;

procedure TfrmConfConsulta.pRemoverColuna(coluna: TcxGridColumn);
begin
  coluna.Visible := False;

  If lstDisponiveis.Items.IndexOf(coluna.Caption) < 0 Then
    lstDisponiveis.Items.Add(coluna.Caption);
    
  tinta.fSetVisivel(tinta.fGetNomeCampoColuna(coluna.Caption), False);
  Preview;
end;

function TfrmConfConsulta.fAcharColuna(strTitulo: String): TcxGridColumn;
  Var
    intCont: Integer;
begin
  Result := nil;

  For intCont := 0 To dbgViewConsulta.ColumnCount - 1 Do
  Begin
    If dbgViewConsulta.Columns[intCont].Caption = strTitulo Then
      Result := dbgViewConsulta.Columns[intCont];
  End;
end;

function TfrmConfConsulta.fNovaColuna(strNomeCampo,
  strTitulo: String): TcxGridDBColumn;
begin
  Result := dbgViewConsulta.CreateColumn;
  with Result do
  begin
    DataBinding.FieldName := strNomeCampo;
    Caption := strTitulo;
    Editing := False;
    Options.FilteringFilteredItemsList := False;
    Options.FilteringMRUItemsList := False;
    Options.FilteringPopup := False;
    Options.FilteringPopupMultiSelect := False;
    Options.Sorting := False;
  end;

  dbgViewConsulta.ApplyBestFit();
end;

procedure TfrmConfConsulta.dbgViewConsultaColumnHeaderClick(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  dbgViewConsulta.Controller.SelectCells(AColumn, AColumn, 0, qryPrevia.RecordCount-1);
end;

procedure TfrmConfConsulta.pSalvarConfs;
  Var
    intCont: Integer;
begin
  With tinta, dbgViewConsulta Do
  Begin
    For intCont := 0 To VisibleColumnCount - 1 Do
    Begin
      fSetPos(Columns[intCont].DataBinding.FieldName, intCont);
    End;
  End;

  With tinta Do
  Begin
    pSetQtdIndices(lstIndices.Count);

    For intCont := 0 To lstIndices.Count - 1 Do
    Begin
      pSetDesCamposIndice(intCont, lstIndices.Items[intCont]);
      pSetCamposIndice(intCont, fGetCampos(lstIndices.Items[intCont]));
    End;
  End;
  
  tinta.pSalvarConfs;
end;

procedure TfrmConfConsulta.dbctrlgrdIndicesDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source is TDragControlObject
end;

procedure TfrmConfConsulta.lstIndicesDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
    Var
    lstDestino: TListBox;
begin
  Accept := (Source is TDragControlObject) Or ((Source is TListBox) And (Source <> Sender));

  If Accept Then
  Begin
    lstDestino := TListBox(Sender);
    lstDestino.ItemIndex := lstDestino.ItemAtPos(Point(X, Y), True);
  End;
end;

procedure TfrmConfConsulta.lstIndicesDragDrop(Sender, Source: TObject; X,
  Y: Integer);
  Var
    colOrigem: TcxGridColumn;
    lstDestino: TListBox;
    intIndexDestino: Integer;
    strSelecionado: string;
begin

  lstDestino := TListBox(Sender);
  intIndexDestino := lstDestino.ItemAtPos(Point(X, Y), True);

  If (Source is TDragControlObject) Then
  Begin
    colOrigem := dbgViewConsulta.Controller.FocusedColumn;
    strSelecionado := colOrigem.Caption;
  End
  Else If ((Source is TListBox) And (Source <> Sender)) Then
  Begin
    strSelecionado := TListBox(Source).Items[TListBox(Source).ItemIndex];
  End;

  If intIndexDestino >= 0 then
  Begin
    If (Not fEstaNoIndice(strSelecionado, lstDestino.Items.Strings[intIndexDestino]))
      and (fContaCaracteres(lstDestino.Items.Strings[intIndexDestino], '/') < 2) Then
    Begin
      lstDestino.Items.Strings[intIndexDestino] :=
        lstDestino.Items.Strings[intIndexDestino] + '/' + strSelecionado;
    End;
  End
  Else
  Begin
    lstDestino.Items.Add(strSelecionado);
  End;

  pDeletaDuplicados;
end;

function TfrmConfConsulta.fContaCaracteres(strTexto: String;
  char: Char): Integer;
  Var
    intCont: Integer;
begin
  Result := 0;
  
  For intCont := 0 To Length(strTexto) - 1 Do
  Begin
    If strTexto[intCont] = char then
      Result := Result + 1;
  End;
end;

function TfrmConfConsulta.fEstaNoIndice(strNovo,
  strAtual: String): Boolean;
  Var
    arrIndice: Array Of String;
    intCont: Integer;
begin
  { SE NAO ESTIVER, JA SAI FORA }
  If Pos(strNovo, strAtual) <= 0 Then
  Begin
    Result := False;
  End
  Else
  {CASO TENHA, VERIFICAR SE É APENAS UMA PARTE}
  Begin
    If strNovo = strAtual Then
    Begin
      Result := True;
      Exit;
    End;

    SetLength(arrIndice, fContaCaracteres(strAtual, '/') + 1);
    strAtual := strAtual + '/';
    For intCont := 0 To Length(arrIndice) - 1 Do
    Begin
      arrIndice[intCont] := Copy(strAtual, 1, Pos('/', strAtual) - 1);
      strAtual := Copy(strAtual, Pos('/', strAtual) + 1, Length(strAtual));
      If strNovo = arrIndice[intCont] Then
      Begin
        Result := True;
        Exit;
      End;
    End;

    Result := False;
  End;
end;

procedure TfrmConfConsulta.pDeletaDuplicados;

  function Duplicados: Boolean;
    Var
      i, j: Integer;
  Begin
    For i := 0 To lstIndices.Count - 1 Do
    Begin
      For j := i + 1 To lstIndices.Count - 1 Do
      Begin
        If lstIndices.Items.Strings[i] = lstIndices.Items.Strings[j] Then
        Begin
          lstIndices.Items.Delete(i);
          Result := True;
          Exit;
        End;
      End;
    End;
    Result := False;
  End;
begin
  While Duplicados Do;
end;

function TfrmConfConsulta.fGetCampos(strDesIndices: String): String;
begin
  strDesIndices := strDesIndices + '/';
  Result := '';

  While Pos('/', strDesIndices) > 0 Do
  Begin
     Result := Result + '+' + tinta.fGetNomeCampoColuna(Copy(strDesIndices, 1, Pos('/', strDesIndices) - 1));
     strDesIndices := Copy(strDesIndices, Pos('/', strDesIndices) + 1, Length(strDesIndices));
  End;

  Result := Copy(Result, 2, Length(Result));
end;

procedure TfrmConfConsulta.lstIndicesKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_DELETE Then
  Begin
    lstIndices.DeleteSelected;
    lstIndices.ItemIndex := 0;
  End;
end;

procedure TfrmConfConsulta.pConstruirIndices;
begin
  lstIndices.Items.Text := tinta.fGetTodosDesCamposIndices;
end;

procedure TfrmConfConsulta.pRestaurarPadrao;
  Var
    intCont: Integer;
    strSelecionado: String;
    coluna: TcxGridDBColumn;

begin

  While dbgViewConsulta.VisibleColumnCount > 0 Do
  Begin
    pRemoverColuna(dbgViewConsulta.VisibleColumns[0]);
  End;

  tinta.pRestaurarPadrao;

  For intCont := 0 To tinta.fGetQtdColunasVisiveis - 1 Do
  Begin
    strSelecionado := tinta.fGetCaptionColunaVisivel(intCont);
    coluna := TcxGridDBColumn(fAcharColuna(strSelecionado));

    If coluna <> nil Then
    Begin
      coluna.Visible := True;
      coluna.Index := dbgViewConsulta.ColumnCount - 1;
    End
    Else
    Begin
      fNovaColuna(fGetNomeColuna(tinta.fGetNomeCampoColuna(strSelecionado)),
          strSelecionado);
    End;

    lstDisponiveis.ItemIndex := lstDisponiveis.Items.IndexOf(strSelecionado);
    lstDisponiveis.Selected[lstDisponiveis.ItemIndex] := True;
    lstDisponiveis.DeleteSelected;

  End;

  pConstruirIndices;
  Preview;
end;

procedure TfrmConfConsulta.pLimparLabels;
begin
  lblPreviaTexto.Caption := '';
end;

procedure TfrmConfConsulta.grpPreviaTextoDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source is TDragControlObject) Or (Source is TListBox);
end;

procedure TfrmConfConsulta.grpPreviaTextoDragDrop(Sender, Source: TObject;
  X, Y: Integer);
  Var
    colOrigem: TcxGridColumn;
    grpPrevia: TGroupBox;
    strSelecionado: string;
begin
  grpPrevia := TGroupBox(Sender);

  If (Source is TDragControlObject) Then
  Begin
    colOrigem := dbgViewConsulta.Controller.FocusedColumn;
    strSelecionado := colOrigem.Caption;
  End
  Else If ((Source is TListBox) And (Source <> Sender)) Then
  Begin
    strSelecionado := TListBox(Source).Items[TListBox(Source).ItemIndex];
  End;

  grpPrevia.Caption := AnsiReplaceStr(grpPrevia.Caption, ')', '/' + strSelecionado + ')');
  grpPrevia.Caption := AnsiReplaceStr(grpPrevia.Caption, '(/', '(');
  tinta.pAdicionarCampoDescricao(tinta.fGetNomeCampoColuna(strSelecionado));
  Preview;
end;

procedure TfrmConfConsulta.btnLimparDescriClick(Sender: TObject);
begin
  tinta.pLimparDescricao;
  grpPreviaTexto.Caption := 'Descrição da Tinta ()';
  pLimparLabels;
end;

end.


