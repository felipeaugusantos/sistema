unit untOrdProAtualizaPrecos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, untZClient, cxProgressBar,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, strUtils,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Grids, DBGridCitel, DBGrids, Data.DB, Vcl.ImgList,
  System.UITypes, Uni, System.ImageList, untTOrdProAtualizaPrecos,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxCheckBox,  System.Threading,
  Datasnap.DBClient, dxCore, untPreAlt_Trigger, System.Math;

type
  THackDBGrid = class(TDBGridCitel);

  TfrmOrdProAtualizaPrecos = class(TfrmPai)
    imgLista: TImageList;
    tmrInicializa: TTimer;
    shpUpCusto: TShape;
    shpDownCusto: TShape;
    Label1: TLabel;
    Label2: TLabel;
    chkExiCus: TCheckBox;
    btnConfirma: TBitBtnLocked;
    popOpcoes: TPopupMenu;
    Marcartodosalterados1: TMenuItem;
    Marcarapenascomcustomenor1: TMenuItem;
    MarcarapenascomcustoMAIOR1: TMenuItem;
    N1: TMenuItem;
    Desmarcartodos1: TMenuItem;
    BitBtn1: TBitBtnLocked;
    cxgDados: TcxGridDBTableViewCitel;
    cxDadosLvl: TcxGridLevel;
    cxDados: TcxGridCitel;
    cxgDadosMARCA: TcxGridDBColumn;
    cxgDadosCODITE: TcxGridDBColumn;
    cxgDadosDESITE: TcxGridDBColumn;
    cxgDadosREFERE: TcxGridDBColumn;
    cxgDadosPRECUS: TcxGridDBColumn;
    cxgDadosPRECUS_NOV: TcxGridDBColumn;
    cxgDadosCUSLIQ: TcxGridDBColumn;
    cxgDadosPREVE1: TcxGridDBColumn;
    cxgDadosPREVE1_NOV: TcxGridDBColumn;
    cxgDadosMARBR1: TcxGridDBColumn;
    cxgDadosMARBR1_NOV: TcxGridDBColumn;
    cxgDadosPREVE2: TcxGridDBColumn;
    cxgDadosPREVE2_NOV: TcxGridDBColumn;
    cxgDadosMARBR2: TcxGridDBColumn;
    cxgDadosMARBR2_NOV: TcxGridDBColumn;
    cxgDadosPREVE3: TcxGridDBColumn;
    cxgDadosPREVE3_NOV: TcxGridDBColumn;
    cxgDadosMARBR3: TcxGridDBColumn;
    cxgDadosMARBR3_NOV: TcxGridDBColumn;
    cxgDadosPREVE4: TcxGridDBColumn;
    cxgDadosPREVE4_NOV: TcxGridDBColumn;
    cxgDadosMARBR4: TcxGridDBColumn;
    cxgDadosMARBR4_NOV: TcxGridDBColumn;
    cxgDadosPREVE5: TcxGridDBColumn;
    cxgDadosPREVE5_NOV: TcxGridDBColumn;
    cxgDadosMARBR5: TcxGridDBColumn;
    cxgDadosMARBR5_NOV: TcxGridDBColumn;
    cxgDadosPREVE6: TcxGridDBColumn;
    cxgDadosPREVE6_NOV: TcxGridDBColumn;
    cxgDadosMARBR6: TcxGridDBColumn;
    cxgDadosMARBR6_NOV: TcxGridDBColumn;
    cxgDadosPREVE7: TcxGridDBColumn;
    cxgDadosPREVE7_NOV: TcxGridDBColumn;
    cxgDadosMARBR7: TcxGridDBColumn;
    cxgDadosMARBR7_NOV: TcxGridDBColumn;
    cxgComposicao: TcxGridDBTableView;
    cxlComposicao: TcxGridLevel;
    cxComposicao: TcxGrid;
    cxgComposicaoColumn1: TcxGridDBColumn;
    cxgComposicaoColumn2: TcxGridDBColumn;
    cxgComposicaoColumn3: TcxGridDBColumn;
    cxgComposicaoPRECUS: TcxGridDBColumn;
    cxgDadosCODFABRICA: TcxGridDBColumn;
    cxgComposicaoCODFAB: TcxGridDBColumn;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrInicializaTimer(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure Marcartodosalterados1Click(Sender: TObject);
    procedure dbgDadosCellClick(Column: TColumn);
    procedure BitBtn1Click(Sender: TObject);
    procedure dbgComposicaoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgDadosMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure cxgDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxDadosMouseLeave(Sender: TObject);
    procedure cxgDadosFocusedItemChanged(Sender: TcxCustomGridTableView;
      APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
    procedure cxgComposicaoCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormResize(Sender: TObject);
    procedure cxgDadosDataControllerFilterChanged(Sender: TObject);
    procedure cxgDadosColumnHeaderClick(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure cxgDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgDadosCanSelectRecord(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; var AAllow: Boolean);
    procedure cxgDadosCanFocusRecord(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; var AAllow: Boolean);
  private
    intCorZeb : Integer;
    intRecordIndex: Integer;
    Item: TcxCustomGridTableItem;
    Rec: TcxCustomGridRecord;
    intTabelaPreco: Integer;
    gerRect: TRect;
    blnKeyDownUpPressed : Boolean;
    FAtualizaPrecos: TOrdProAtualizaPrecos;
    procedure pExibeComposicao;
    procedure pVisibiidadePreVenMarBru;
    procedure pGerMatAfterScroll(DataSet : TDataSet);
    function fGetIndexTabela(strFieldName: String): Integer;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untGravando, untOrdProAtualizaPrecosFiltros;

{ TfrmOrdProAtualizaPrecos }

procedure TfrmOrdProAtualizaPrecos.BitBtn1Click(Sender: TObject);
begin
  inherited;
  popOpcoes.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TfrmOrdProAtualizaPrecos.btnConfirmaClick(Sender: TObject);
begin
  If Not (btnConfirma.Enabled) Then
    Exit;

  inherited;
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.fExecutarAcao := FAtualizaPrecos.fGravarAlteracoes;
  frmGravando.ShowModal;

  If frmGravando.blnConfirma Then
  Begin
    fMensagem('','Atualização realizada com sucesso!', ['&OK']);
    Self.Close;
  End;

  FreeAndNil(frmGravando);

end;

procedure TfrmOrdProAtualizaPrecos.dbgComposicaoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  With TDBGridCitel(Sender) Do
  Begin
    if (DataSource = Nil) Or (Not DataSource.DataSet.Active) Or (DataSource.DataSet.RecordCount <= 0) Then
      Exit;

    if Odd(DataSource.DataSet.RecNo) Then
    Begin
      Canvas.Brush.Color := intCorZeb;
      Canvas.Font.Color  := clBlack;
    End;

    if (Tag = THackDBGrid(Sender).DataLink.ActiveRecord + 1) then
    begin
      Canvas.Brush.Color := clSilver;
      Canvas.Font.Color := clNavy;
    end;

    Canvas.FillRect(Rect);
    DefaultDrawColumnCell(Rect, DataCol, Column, State);

  End;

end;

procedure TfrmOrdProAtualizaPrecos.dbgDadosCellClick(Column: TColumn);
begin
  inherited;
  if Column.FieldName = 'MARCA' Then
    FAtualizaPrecos.pMarcar( opcInverter );
end;

procedure TfrmOrdProAtualizaPrecos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
    Self.Close;
  blnKeyDownUpPressed := ((Key = VK_DOWN) or (Key = VK_UP));
end;


procedure TfrmOrdProAtualizaPrecos.FormResize(Sender: TObject);
begin
  inherited;
  If cxComposicao.Visible Then
    pExibeComposicao;
end;

procedure TfrmOrdProAtualizaPrecos.cxDadosMouseLeave(Sender: TObject);
begin
  inherited;
  Item := nil;
  Rec := nil;
end;

procedure TfrmOrdProAtualizaPrecos.pExibeComposicao;
Begin
  If intRecordIndex = -1 Then
    Exit;

  If FAtualizaPrecos.cdsGerMat.IsEmpty then
  Begin
    cxComposicao.Visible := False;
    Exit;
  End;

  If not chkExiCus.Checked Then
  Begin
    cxComposicao.Visible := False;
    Exit;
  End;

  If Not Assigned(cxgDados.ViewData.GetRecordByRecordIndex(intRecordIndex)) Then
    Exit;

  If Not Assigned(cxgDados.ViewData.GetRecordByRecordIndex(intRecordIndex).ViewInfo) Then
    Exit;

  gerRect := cxgDados.ViewData.GetRecordByRecordIndex(intRecordIndex).ViewInfo.GetBoundsForItem(cxgDadosPRECUS_NOV);

  If cxgDadosPRECUS_NOV.Focused Then
  Begin
    If Not cxComposicao.Visible Then
      cxComposicao.Visible := True;
    FAtualizaPrecos.cdsDetMat.First;

    cxComposicao.Top :=  gerRect.Bottom;
    If cxComposicao.Top + cxComposicao.Height > Self.Height Then
      cxComposicao.Top := gerRect.Top - cxComposicao.Height;
    cxComposicao.Left := gerRect.Left;

    FAtualizaPrecos.cdsDetMat.Filtered := False;
    FAtualizaPrecos.cdsDetMat.Filter := 'DMT_SEQGER = ' + QuotedStr(FAtualizaPrecos.cdsGerMat.FieldByName('AUTOINCREM').AsString);
    FAtualizaPrecos.cdsDetMat.Filtered := True;
  End
  Else
    cxComposicao.Visible := False;
end;

procedure TfrmOrdProAtualizaPrecos.cxgComposicaoCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If Odd(AViewInfo.RecordViewInfo.Index) Then
     ACanvas.Brush.Color := clMoneyGreen;
end;

procedure TfrmOrdProAtualizaPrecos.cxgDadosCanFocusRecord(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
  inherited;
  intRecordIndex := ARecord.Index;
end;

procedure TfrmOrdProAtualizaPrecos.cxgDadosCanSelectRecord(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
  inherited;
  intRecordIndex := ARecord.Index;
end;

procedure TfrmOrdProAtualizaPrecos.cxgDadosColumnHeaderClick(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
var strFieldIdx, strField: String;
begin
  inherited;
  strFieldIdx := TcxGridDBColumn(AColumn).DataBinding.FieldName;
  strField    := strFieldIdx;

  If (AColumn.SortOrder = soAscending) Or (AColumn.SortOrder = soNone) Then
    strFieldIdx := strFieldIdx + '_ASC'
  Else If AColumn.SortOrder = soDescending Then
    strFieldIdx := strFieldIdx + '_DES'
  Else
    Exit;

  Try
    FAtualizaPrecos.cdsGerMat.IndexDefs.Find(strFieldIdx);
    FAtualizaPrecos.cdsGerMat.IndexName := strFieldIdx;
  Except
    with FAtualizaPrecos.cdsGerMat.IndexDefs.AddIndexDef do
    begin
      Name := strFieldIdx;
      Fields := strField;
      If AColumn.SortOrder = soDescending Then
        Options := [ixDescending];
    end;
    FAtualizaPrecos.cdsGerMat.IndexName := strFieldIdx;
  End;
end;

procedure TfrmOrdProAtualizaPrecos.cxgDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var  intIndex: integer;
     fltCusLiq,
     fltPreCus : Double;
begin
  inherited;
  If Odd(AViewInfo.RecordViewInfo.Index) Then
     ACanvas.Brush.Color := clMoneyGreen;

  If Assigned(Rec) Then
  Begin
    if AViewInfo.RecordViewInfo.Index = Rec.Index then
    begin
      ACanvas.Brush.Color := clSilver;
      ACanvas.Font.Color := clNavy;
    end;
  End;

  If (Assigned(Item)) Then
  Begin
    If intTabelaPreco > 0 Then
    Begin
      intIndex := fGetIndexTabela(TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName);
      if intIndex = intTabelaPreco then
      Begin
        If AViewInfo.RecordViewInfo.GridRecord = Rec Then
           ACanvas.Brush.Color := $004080FF;
      End;
    End;
  End;

  If AViewInfo.Item =  cxgDadosPRECUS_NOV Then
  Begin
    fltCusLiq := 0;
    fltPreCus := 0;
    If Not VarIsNull(cxgDados.DataController.Values[AViewInfo.RecordViewInfo.Index,  cxgDadosCUSLIQ.Index]) Then
      fltCusLiq := SimpleRoundTo(cxgDados.DataController.Values[AViewInfo.RecordViewInfo.Index,  cxgDadosCUSLIQ.Index], -2);

    If Not VarIsNull(cxgDados.DataController.Values[AViewInfo.RecordViewInfo.Index,  cxgDadosPRECUS.Index]) Then
      fltPreCus := SimpleRoundTo(cxgDados.DataController.Values[AViewInfo.RecordViewInfo.Index,  cxgDadosPRECUS.Index], -2);

    Begin
      If fltPreCus <> fltCusLiq Then
      Begin
        ACanvas.Font.Color := clBlack;
        If fltCusLiq > fltPreCus Then
          ACanvas.Brush.Color := shpUpCusto.Brush.Color
        Else
          ACanvas.Brush.Color := shpDownCusto.Brush.Color;
      End;
    End;
  End;
end;

procedure TfrmOrdProAtualizaPrecos.cxgDadosDataControllerFilterChanged(
  Sender: TObject);
begin
  inherited;
  FAtualizaPrecos.cdsGerMat.Filtered := False;
  FAtualizaPrecos.cdsGerMat.Filter := UpperCase(cxgDados.DataController.Filter.FilterText);
  FAtualizaPrecos.cdsGerMat.Filtered := FAtualizaPrecos.cdsGerMat.Filter <> '';
end;

procedure TfrmOrdProAtualizaPrecos.cxgDadosFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  pExibeComposicao;
end;

procedure TfrmOrdProAtualizaPrecos.cxgDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_SPACE) or (Key = VK_RETURN) Then
    FAtualizaPrecos.pMarcar(opcInverter);
end;

procedure TfrmOrdProAtualizaPrecos.cxgDadosMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  Site: TcxGridSite;
  HitTest: TcxCustomGridHitTest;
  strFieldName: string;
begin
  Site := Sender as TcxGridSite;
  HitTest := Site.GridView.ViewInfo.GetHitTest(X, Y);
  if HitTest is TcxGridRecordCellHitTest then
  begin
    Item := TcxGridRecordCellHitTest(HitTest).Item;
    Rec := TcxGridRecordCellHitTest(HitTest).GridRecord;
    strFieldName := TcxGridDBColumn(Item).DataBinding.FieldName;

    If Not ((Pos('PREVE',  strFieldName) > 0) Or
            (Pos('MARBR',  strFieldName) > 0)) Then
    Begin
      intTabelaPreco := 0;
      Item := Nil;
    End
    Else
      intTabelaPreco := fGetIndexTabela(strFieldName);
  end;
end;

procedure TfrmOrdProAtualizaPrecos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Assigned(FAtualizaPrecos) Then
    FreeAndNil(FAtualizaPrecos);
end;

procedure TfrmOrdProAtualizaPrecos.FormCreate(Sender: TObject);
begin
  inherited;
  intRecordIndex := -1;
  blnKeyDownUpPressed := False;
  intCorZeb := fCfgSis('CORZEB', varInteger);
end;

procedure TfrmOrdProAtualizaPrecos.pGerMatAfterScroll(DataSet: TDataSet);
begin
  pExibeComposicao;
end;

procedure TfrmOrdProAtualizaPrecos.tmrInicializaTimer(Sender: TObject);
Var
  LParams: TOrdProAtualizaPrecosParams;
begin
  inherited;
  tmrInicializa.Enabled := False;

  LParams := TfrmOrdProAtualizaPrecosFiltros.fGetOrdProAtualizaPrecosParams();

  If Not Assigned(LParams) Then
  Begin
    Self.Close;
    Exit;
  End;

  FAtualizaPrecos := TOrdProAtualizaPrecos.Create(LParams);

  If Not fChamaTelaGravando(FAtualizaPrecos.fCarregarRegistros, 'Carregando Registros...') Then
  Begin
    Self.Close;
    Exit;
  End;

  pVisibiidadePreVenMarBru;

  cxgDados.DataController.DataSource := FAtualizaPrecos.cdsGerMat.dtsSource;

  cxgComposicao.DataController.DataSource := FAtualizaPrecos.cdsDetMat.dtsSource;
  cxgComposicaoPRECUS.DataBinding.FieldName := FAtualizaPrecos.strPrecoCusto;

  FAtualizaPrecos.cdsGerMat.AfterScroll := pGerMatAfterScroll;

  btnConfirma.Enabled := Not LParams.SomenteExibir;
end;


procedure TfrmOrdProAtualizaPrecos.pVisibiidadePreVenMarBru;
 var intIndex: integer;

  procedure pSetProperiesCampos(strCaption: string; Column: TcxGridDBColumn; visible: Boolean);
  Begin
    Column.Caption := strCaption;
    Column.Visible := visible;
  End;

  function IIfCol(blnCondi: Boolean; ColTrue, ColFalse :TcxGridDBColumn):TcxGridDBColumn;
  Begin
    If blnCondi Then
      Result := ColTrue
    Else
      Result := ColFalse;
  End;

  function fGetCol(ind: integer; blnNovo, blnPreve: Boolean):TcxGridDBColumn;
  Begin
    case ind of
      1: Result := IIfCol(blnNovo, IIfCol(blnPreve, cxgDadosPREVE1_NOV, cxgDadosMARBR1_NOV), IIfCol(blnPreve, cxgDadosPREVE1, cxgDadosMARBR1));
      2: Result := IIfCol(blnNovo, IIfCol(blnPreve, cxgDadosPREVE2_NOV, cxgDadosMARBR2_NOV), IIfCol(blnPreve, cxgDadosPREVE2, cxgDadosMARBR2));
      3: Result := IIfCol(blnNovo, IIfCol(blnPreve, cxgDadosPREVE3_NOV, cxgDadosMARBR3_NOV), IIfCol(blnPreve, cxgDadosPREVE3, cxgDadosMARBR3));
      4: Result := IIfCol(blnNovo, IIfCol(blnPreve, cxgDadosPREVE4_NOV, cxgDadosMARBR4_NOV), IIfCol(blnPreve, cxgDadosPREVE4, cxgDadosMARBR4));
      5: Result := IIfCol(blnNovo, IIfCol(blnPreve, cxgDadosPREVE5_NOV, cxgDadosMARBR5_NOV), IIfCol(blnPreve, cxgDadosPREVE5, cxgDadosMARBR5));
      6: Result := IIfCol(blnNovo, IIfCol(blnPreve, cxgDadosPREVE6_NOV, cxgDadosMARBR6_NOV), IIfCol(blnPreve, cxgDadosPREVE6, cxgDadosMARBR6));
      7: Result := IIfCol(blnNovo, IIfCol(blnPreve, cxgDadosPREVE7_NOV, cxgDadosMARBR7_NOV), IIfCol(blnPreve, cxgDadosPREVE7, cxgDadosMARBR7));
      Else
        Result := nil;
    end;
  End;


Begin
  For intIndex := 1 To Length(FAtualizaPrecos.strTabelasPreco) Do
  Begin

    If FAtualizaPrecos.TipoAtualizacao = opAtualizarPrecoVenda Then
      pSetProperiesCampos('Pr. Venda ' + IntToStr(intIndex) + ' Ant.',
                          fGetCol(intIndex, False, True),
                          FAtualizaPrecos.strTabelasPreco[intIndex] = 'S')
    Else
      fGetCol(intIndex, False, True).Visible := False;

    pSetProperiesCampos('Pr. Venda ' + IntToStr(intIndex) + IIF( FAtualizaPrecos.TipoAtualizacao = opAtualizarPrecoVenda, ' Novo', ''),
                        fGetCol(intIndex, True, True),
                        FAtualizaPrecos.strTabelasPreco[intIndex] = 'S');

    If FAtualizaPrecos.TipoAtualizacao = opAtualizarMargem Then
      pSetProperiesCampos('Margem ' + IntToStr(intIndex) + ' Ant.',
                        fGetCol(intIndex, False, False),
                        FAtualizaPrecos.strTabelasPreco[intIndex] = 'S')
    Else
      fGetCol(intIndex, False, False).Visible := False;

    pSetProperiesCampos('Margem ' + IntToStr(intIndex) + IIF( FAtualizaPrecos.TipoAtualizacao = opAtualizarMargem, ' Novo', ''),
                        fGetCol(intIndex, true, False),
                        FAtualizaPrecos.strTabelasPreco[intIndex] = 'S');
  end;

end;

procedure TfrmOrdProAtualizaPrecos.FormShow(Sender: TObject);
begin
  inherited;
  tmrInicializa.Enabled := True;
end;

procedure TfrmOrdProAtualizaPrecos.Marcartodosalterados1Click(Sender: TObject);
begin
  inherited;
  Try
    FAtualizaPrecos.cdsGerMat.DisableControls;
    FAtualizaPrecos.cdsGerMat.First;

    While Not FAtualizaPrecos.cdsGerMat.Eof Do
    Begin
      Case TMenuItem(Sender).Tag Of
        1: FAtualizaPrecos.pMarcar( opcAlterado );
        2: FAtualizaPrecos.pMarcar( opcMenor );
        3: FAtualizaPrecos.pMarcar( opcMaior );
        4: FAtualizaPrecos.pMarcar( opcDesmarcar );
      End;
      FAtualizaPrecos.cdsGerMat.Next;
    End;

  Finally
    FAtualizaPrecos.cdsGerMat.First;
    FAtualizaPrecos.cdsGerMat.EnableControls;
  End;

end;

function TfrmOrdProAtualizaPrecos.fGetIndexTabela(strFieldName: String): Integer;
const
  cTab1 = 'ITE_PREVE1_ITE_MARBR1_NEW_PREVE1_NEW_MARBR1';
  cTab2 = 'ITE_PREVE2_ITE_MARBR2_NEW_PREVE2_NEW_MARBR2';
  cTab3 = 'ITE_PREVE3_ITE_MARBR3_NEW_PREVE3_NEW_MARBR3';
  cTab4 = 'ITE_PREVE4_ITE_MARBR4_NEW_PREVE4_NEW_MARBR4';
  cTab5 = 'ITE_PREVE5_ITE_MARBR5_NEW_PREVE5_NEW_MARBR5';
  cTab6 = 'ITE_PREVE6_ITE_MARBR6_NEW_PREVE6_NEW_MARBR6';
  cTab7 = 'ITE_PREVE7_ITE_MARBR7_NEW_PREVE7_NEW_MARBR7';
Begin
  If Pos(strFieldName, cTab1) > 0 Then
    Result := 1
  Else If Pos(strFieldName, cTab2) > 0 Then
    Result := 2
  Else If Pos(strFieldName, cTab3) > 0 Then
    Result := 3
  Else If Pos(strFieldName, cTab4) > 0 Then
    Result := 4
  Else If Pos(strFieldName, cTab5) > 0 Then
    Result := 5
  Else If Pos(strFieldName, cTab6) > 0 Then
    Result := 6
  Else If Pos(strFieldName, cTab7) > 0 Then
    Result := 7
  Else
    Result := 0;
End;

end.
