unit untLogAcompPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, untPai, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, cxContainer, Vcl.ComCtrls, dxCore,
  cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Uni,
  cxProgressBar, cxDataControllerConditionalFormattingRulesManagerDialog,
  System.ImageList, Vcl.ImgList, cxImageList, StrUtils, Vcl.CheckLst,
  Vcl.ExtDlgs, ComboBoxFocus, untTypesSistema, dxBarBuiltInMenu, cxPC;

type
  TcxViewInfoAcess = class(TcxGridTableDataCellViewInfo);
  TcxPainterAccess = class(TcxGridTableDataCellPainter);

  TCamposTabela = record
    strTitulo: string;
    strNome: string;
    blnSelecionado: Boolean;
  end;

  TfrmLogAcompPedidos = class(TfrmPai)
    pnlHeader: TPanel;
    lbl1: TLabel;
    Label1: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    edtNumDoc: TEditFocus;
    cxgDadosLevel1: TcxGridLevel;
    cxgDadosView: TcxGridDBTableViewCitel;
    cxgDados: TcxGridCitel;
    Label2: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    Label3: TLabel;
    edtCodOpe: TEditFocus;
    edtNomOpe: TEditFocus;
    Label4: TLabel;
    mskEmiIni: TcxDateEdit;
    Label5: TLabel;
    mskEmifin: TcxDateEdit;
    mskOcoIni: TcxDateEdit;
    mskOcoFin: TcxDateEdit;
    Label6: TLabel;
    Label7: TLabel;
    btnConsultar: TBitBtnLocked;
    dtsDados: TDataSource;
    btnDetalhes: TBitBtnLocked;
    cxgDadosViewDTALOG: TcxGridDBColumn;
    cxgDadosViewHORLOG: TcxGridDBColumn;
    cxgDadosViewOPELOG: TcxGridDBColumn;
    cxgDadosViewFGO_DTAENT: TcxGridDBColumn;
    cxgDadosViewFGO_NUMDOC: TcxGridDBColumn;
    cxgDadosViewFGO_ESPDOC: TcxGridDBColumn;
    cxgDadosViewFGO_CODEMP: TcxGridDBColumn;
    cxgDadosViewFGO_CODCLI: TcxGridDBColumn;
    cxgDadosViewFGO_TIPFRE: TcxGridDBColumn;
    cxgDadosViewFGO_CODTRA: TcxGridDBColumn;
    cxgDadosViewFGO_TOTFRE: TcxGridDBColumn;
    cxgDadosViewFGO_CODCND: TcxGridDBColumn;
    cxgDadosViewFGO_CONPAG: TcxGridDBColumn;
    cxgDadosViewFGO_CODFPG: TcxGridDBColumn;
    cxgDadosViewFGO_TOTPRO: TcxGridDBColumn;
    cxgDadosViewFGO_DESESP: TcxGridDBColumn;
    cxgDadosViewFGO_TOTSER: TcxGridDBColumn;
    cxgDadosViewFGO_DESACE: TcxGridDBColumn;
    cxgDadosViewFGO_TOTIPI: TcxGridDBColumn;
    cxgDadosViewFGO_TOTRET: TcxGridDBColumn;
    cxgDadosViewFGO_VLRCON: TcxGridDBColumn;
    cxgDadosViewFGO_ENT_CD: TcxGridDBColumn;
    cxgDadosViewFGO_OPRFLJ: TcxGridDBColumn;
    cxgDadosViewFRMLOG: TcxGridDBColumn;
    cxgDadosViewMARCA: TcxGridDBColumn;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmTodos: TBitBtnLocked;
    imgLista: TcxImageList;
    btnSelCol: TBitBtnLocked;
    btnExportar: TBitBtnLocked;
    stfDialog: TSaveTextFileDialog;
    cxgDadosViewFGO_TIPFAT: TcxGridDBColumn;
    cxgDadosViewFGO_NUMFAT: TcxGridDBColumn;
    cxgDadosViewFGO_EMPFAT: TcxGridDBColumn;
    edtEspDoc: TComboBoxFocus;
    cxgDadosViewALTERACOES: TcxGridDBColumn;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    Label8: TLabel;
    cxgDadosViewNOMCLI: TcxGridDBColumn;
    cxgDadosViewSTATUS: TcxGridDBColumn;
    cxgDadosViewFGO_SITUAC: TcxGridDBColumn;
    Label9: TLabel;
    cbxSituacao: TComboBoxFocus;
    cxgDadosViewFGO_CODVEN: TcxGridDBColumn;
    cxgDadosViewNOMPOR: TcxGridDBColumn;
    Label10: TLabel;
    cbxSituacaoPedido: TComboBoxFocus;
    chkPedMultFat: TCheckBox;
    cxgDadosViewWTSMAQ: TcxGridDBColumn;
    cxgDadosViewWTS_IP: TcxGridDBColumn;
    Label11: TLabel;
    edtProdutos: TEditFocus;
    edtDesProduto: TEditFocus;
    gpbRegcomAlteracao: TGroupBox;
    Label12: TLabel;
    chkRegComAlteracao: TCheckBox;
    cmbInfRegAlterado: TComboBox;
    chkExbFatPed: TCheckBox;
    cxgDadosViewTIPATE: TcxGridDBColumn;
    dtsDadosSta: TDataSource;
    cxgDadosStaView: TcxGridDBTableViewCitel;
    cxgDadosStaViewDTAMUD: TcxGridDBColumn;
    cxgDadosStaViewHRAMUD: TcxGridDBColumn;
    cxgDadosStaViewDESCRI: TcxGridDBColumn;
    cxgDadosViewFGOINC: TcxGridDBColumn;
    cxgDadosStaViewSEQFGO: TcxGridDBColumn;
    pcDados: TcxPageControl;
    tbAcompanhamento: TcxTabSheet;
    tbStatus: TcxTabSheet;
    cxgStatus: TcxGridCitel;
    cxgStatusView: TcxGridDBTableViewCitel;
    cxgStatusViewDOCUMENTO: TcxGridDBColumn;
    cxgStatusViewDTAMUD: TcxGridDBColumn;
    cxgStatusViewHRAMUD: TcxGridDBColumn;
    cxgStatusViewDESCRI: TcxGridDBColumn;
    cxgStatusLevel1: TcxGridLevel;
    procedure btnConsultarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure btnDetalhesClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure cxgDadosViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgDadosViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmTodosClick(Sender: TObject);
    procedure cxgDadosViewKeyPress(Sender: TObject; var Key: Char);
    procedure btnSelColClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure cxgDadosViewFGO_SITUACGetDataText(Sender: TcxCustomGridTableItem;
      ARecordIndex: Integer; var AText: string);
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutosExit(Sender: TObject);
    procedure chkPedMultFatClick(Sender: TObject);
    procedure chkRegComAlteracaoClick(Sender: TObject);
    procedure edtNumDocExit(Sender: TObject);
    procedure edtEspDocChange(Sender: TObject);
    procedure pcDadosPageChanging(Sender: TObject; NewPage: TcxTabSheet;
      var AllowChange: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    qryLogGor : TUniQuery;
    qryLogSta : TUniQuery;

    strLinPro  : String;
    arrProduto: TConsultasArray;

    function fCarregaDados(pgbProgresso: TcxProgressBar): Boolean;
    procedure pMarcaDesmarca(strFlag: string = '');
    procedure pVarreSelCol;
    function fPossuiRegSel: Boolean;
    function fPossuiColSel: Boolean;
    procedure pExportaRegistrosCSV(strNomeArquivo: string);
    procedure pDefineAlterações;
    function fRetornaListaRegAntesAlteracao(cdsGen: TDataSet): String;
    procedure pVerificaAplicaFiltroRegComAlteracao;
    procedure pConfiguraQueryStatus();
  public
    { Public declarations }
    arrCamposTabela: array of TCamposTabela;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

implementation

{$R *.dfm}

uses untGravando, untFuncoesSimples, untConsultas, untFuncoesConsulta,
     untLogAcompPedidosSelCol, untFuncoesRel, untFuncoesRel2;

procedure TfrmLogAcompPedidos.btnConsultarClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.pgbStatus.Visible   := False;
    frmGravando.blnDesabilitaMouse  := True;
    frmGravando.lblGravando.Caption := 'Aguarde... Carregando informações.';
    frmGravando.fExecutarAcao := fCarregaDados;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmLogAcompPedidos.btnConsultarClick]');
  End;
  pFreeAndNil(frmGravando);

  If qryLogGor.IsEmpty Then
    pSetFocus(edtNumDoc)
  Else
    pSetFocus(cxgDados);
end;

procedure TfrmLogAcompPedidos.btnDesmTodosClick(Sender: TObject);
begin
  inherited;
  if not btnMarcarTodos.Visible then
    Exit;

  pcDados.ActivePage := tbAcompanhamento;

  if (not qryLogGor.Active) or (qryLogGor.IsEmpty) then
  begin
    fMensagem('ATENÇÃO!', 'Não há registros para serem desmarcados!', ['&OK']);
    Exit;
  end
  else
  begin
    with qryLogGor do
    begin
      DisableControls;
      First;
      while not Eof do
      begin
        pMarcaDesmarca('N');
        Next;
      end;
      First;
      EnableControls;
      cxgDadosView.Site.Repaint;
    end;
  end;
end;

procedure TfrmLogAcompPedidos.btnDetalhesClick(Sender: TObject);
begin

  inherited;

  If (Not qryLogGor.Active) Or (qryLogGor.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'Selecione um registro para exibir os detalhes!', ['&OK']);
    Exit;
  End;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(198, 7571, [],
                        ['SEQGOR'],
                        [qryLogGor.FieldByName('AUTOINCREM').AsString],
                        Sender,
                        nil,
                        True);
  End;

end;

function TfrmLogAcompPedidos.fPossuiRegSel: Boolean;
var
  blnResult: Boolean;
  intRecNo: Integer;
begin
  blnResult := False;
  intRecNo := 0;
  with qryLogGor do
  begin
    if Active then
    begin
      If (intRecNo=0) Then
        intRecNo := RecNo;
      try
        DisableControls;
        Filter := 'MARCA=' + QuotedStr('S');
        Filtered := True;
        blnResult := not IsEmpty;
        Filter := '';
        Filtered := False;
      finally
        RecNo := intRecNo;
        EnableControls;
      end;
    end;
  end;

  Result := blnResult;
end;

function TfrmLogAcompPedidos.fPossuiColSel: Boolean;
var
  blnResult: Boolean;
  intArray: Integer;
begin
  blnResult := False;

  for intArray := 0 to Length(arrCamposTabela) - 1 do
    if arrCamposTabela[intArray].blnSelecionado then
      blnResult := True;

  Result := blnResult;
end;

procedure TfrmLogAcompPedidos.pExportaRegistrosCSV(strNomeArquivo: string);
var
  tflArquivo: TextFile;

  function fConcatenaDados(blnCabecalho: Boolean): string;
  var
    intArray: Integer;
  begin
    Result := '';

    for intArray := 0 to Length(arrCamposTabela) - 1 do
    begin
      if arrCamposTabela[intArray].blnSelecionado then
      begin
        if blnCabecalho then
          Result := Result + IIF(Result <> '', ';', '') + arrCamposTabela[intArray].strTitulo
        else
        begin
          case qryLogGor.FieldByName(arrCamposTabela[intArray].strNome).DataType of
            ftString: Result := Result + IIF(Result <> '', ';', '') + '"' + qryLogGor.FieldByName(arrCamposTabela[intArray].strNome).AsString + '"';
          else
            Result := Result + IIF(Result <> '', ';', '') + qryLogGor.FieldByName(arrCamposTabela[intArray].strNome).AsString;
          end;
        end;
      end;
    end;
  end;

begin
  with qryLogGor do
  begin
    DisableControls;
    First;
    try
      AssignFile(tflArquivo, strNomeArquivo);
      Rewrite(tflArquivo);

      Writeln(tflArquivo, fConcatenaDados(True));

      while not Eof do
      begin
        if qryLogGor.FieldByName('MARCA').AsString = 'S' then
        begin
          Writeln(tflArquivo, fConcatenaDados(False));
        end;
        Next;
      end;
    finally
      CloseFile(tflArquivo);
      First;
      EnableControls;
      fMensagem('', 'Arquivo CSV exportado com sucesso!', ['&OK']);
    end;
  end;
end;

procedure TfrmLogAcompPedidos.btnExportarClick(Sender: TObject);
begin
  inherited;

  if not fPossuiRegSel then
  begin
    fMensagem('ATENÇÃO!', 'Não há registros selecionados para serem exportados!', ['&OK']);
    Exit;
  end;

  if not fPossuiColSel then
  begin
    fMensagem('ATENÇÃO!', 'Não há colunas selecionadas para serem exportadas!', ['&OK']);
    Exit;
  end;

  if stfDialog.Execute then
    if not fEmptyStr(stfDialog.FileName) then
      pExportaRegistrosCSV(stfDialog.FileName);
end;

procedure TfrmLogAcompPedidos.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  if not btnMarcarTodos.Visible then
    Exit;

  pcDados.ActivePage := tbAcompanhamento;

  if (not qryLogGor.Active) or (qryLogGor.IsEmpty) then
  begin
    fMensagem('ATENÇÃO!', 'Não há registros para serem marcados!', ['&OK']);
    Exit;
  end
  else
  begin
    with qryLogGor do
    begin
      DisableControls;
      First;
      while not Eof do
      begin
        pMarcaDesmarca('S');
        Next;
      end;
      First;
      EnableControls;
      cxgDadosView.Site.Repaint;
    end;
  end;
end;

procedure TfrmLogAcompPedidos.pVarreSelCol;
var
  intCont, intArray: Integer;
begin
  intArray := 0;

  for intCont := 0 to cxgDadosView.ColumnCount - 1 do
  begin
    if cxgDadosView.Columns[intCont].Visible then
    begin
      if not AnsiMatchStr(cxgDadosView.Columns[intCont].DataBinding.FieldName, ['', 'MARCA']) then
      begin
        SetLength(arrCamposTabela, intArray + 1);
        arrCamposTabela[intArray].strTitulo      := cxgDadosView.Columns[intCont].Caption;
        arrCamposTabela[intArray].strNome        := cxgDadosView.Columns[intCont].DataBinding.FieldName;
        arrCamposTabela[intArray].blnSelecionado := True;
        Inc(intArray);
      end;
    end;
  end;
end;

procedure TfrmLogAcompPedidos.btnSelColClick(Sender: TObject);
var
  intCont: Integer;
  frmLogAcompPedidosSelCol: TfrmLogAcompPedidosSelCol;
begin
  inherited;
  try
    pCriarFormularios(TfrmLogAcompPedidosSelCol,frmLogAcompPedidosSelCol);
    for intCont := 0 to Length(arrCamposTabela) - 1 do
      frmLogAcompPedidosSelCol.clbCamposTela.Checked[frmLogAcompPedidosSelCol.clbCamposTela.Items.Add(arrCamposTabela[intCont].strTitulo)] := arrCamposTabela[intCont].blnSelecionado;
    frmLogAcompPedidosSelCol.ShowModal;
    for intCont := 0 to frmLogAcompPedidosSelCol.clbCamposTela.Count - 1 do
      arrCamposTabela[intCont].blnSelecionado := frmLogAcompPedidosSelCol.clbCamposTela.Checked[intCont];
  finally
    FreeAndNil(frmLogAcompPedidosSelCol);
  end;
end;

procedure TfrmLogAcompPedidos.pMarcaDesmarca(strFlag: string);
begin
  if not(qryLogGor.State in [dsInsert, dsEdit]) then
    qryLogGor.Edit;
  qryLogGor.FieldByName('MARCA').AsString := IIF(fEmptyStr(strFlag), IIF(qryLogGor.FieldByName('MARCA').AsString = 'S', 'N', 'S'), strFlag);
  qryLogGor.Post;
end;

procedure TfrmLogAcompPedidos.chkPedMultFatClick(Sender: TObject);
begin
  inherited;
  edtProdutos.Enabled := chkPedMultFat.Checked;
  if not edtProdutos.Enabled then
  begin
    if not fEmptyStr(edtProdutos.Text) then
    begin
      edtProdutos.Clear;
      edtProdutosExit(Sender);
    end;
  end;

end;

procedure TfrmLogAcompPedidos.chkRegComAlteracaoClick(Sender: TObject);
begin
  inherited;
  If chkRegComAlteracao.checked Then
     cmbinfRegAlterado.enabled := True
  Else
  Begin
     cmbinfRegAlterado.enabled := False;
     cmbinfRegAlterado.ItemIndex := -1;
  End;
end;

procedure TfrmLogAcompPedidos.cxgDadosViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  APainter: TcxPainterAccess;
  LAlteracoes: Variant;
begin
  LAlteracoes := AViewInfo.GridRecord.Values[cxgDadosViewAlteracoes.Index];
  If (VarToStr(LAlteracoes) <> '') And
     (Pos(TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName, LAlteracoes) > 0) then
  Begin
    If AViewInfo.Selected Then
      ACanvas.Brush.Color := $4433CC
    Else
      ACanvas.Brush.Color := $8070FF;
  end;

  If VarToStr(AViewInfo.GridRecord.Values[cxgDadosViewFGO_SITUAC.Index]) = 'E' Then
    ACanvas.Font.Color := clRed;

  if not (AViewInfo.EditViewInfo is TcxCustomTextEditViewInfo) then
    Exit;

  if AViewInfo.Item.Index <> cxgDadosViewMARCA.Index then
    Exit;

  APainter := TcxPainterAccess(TcxViewInfoAcess(AViewInfo).GetPainterClass.Create(ACanvas, AViewInfo));
  with APainter do
  begin
    try
      with TcxCustomTextEditViewInfo(AViewInfo.EditViewInfo).TextRect do
        Left := Left + imgLista.Width + 1;

      DrawContent;
      DrawBorders;

      if VarToStr(AViewInfo.GridRecord.Values[cxgDadosViewMARCA.Index]) = 'S' then
      begin
        with AViewInfo.ClientBounds do
          imgLista.Draw(ACanvas.Canvas, Left + 1, Top + 1, 1);
      end
      else
      begin
        with AViewInfo.ClientBounds do
          imgLista.Draw(ACanvas.Canvas, Left + 1, Top + 1, 0);
      end;
    finally
      Free;
    end;
  end;
  ADone := True;
end;

procedure TfrmLogAcompPedidos.cxgDadosViewFGO_SITUACGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;
  If AText <> '' Then
    Case AText[1] Of
      'I': AText := 'Inclusão';
      'A': AText := 'Alteração';
      'E': AText := 'Exclusão';
    End;
end;

procedure TfrmLogAcompPedidos.cxgDadosViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F2: btnDetalhes.Click;
  End;
end;

procedure TfrmLogAcompPedidos.cxgDadosViewKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    pMarcaDesmarca;
    cxgDadosView.Site.Repaint;
  end;
end;

procedure TfrmLogAcompPedidos.edtCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLogAcompPedidos.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp, True, True) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLogAcompPedidos.edtCodOpeKeyPress(Sender: TObject; var Key: Char);
  Var
    arrOperador: TConsultasArray;
begin
  inherited;
  If fPesqOperador(Self, edtCodOpe, edtNomOpe, Nil, Key, arrOperador) Then
  Begin
    If fValidaCampos(edtCodOpe, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLogAcompPedidos.edtEspDocChange(Sender: TObject);
begin
  inherited;
  chkExbFatPed.Enabled := edtEspDoc.ItemIndex <> 1;
end;

procedure TfrmLogAcompPedidos.edtNumDocExit(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtNumDoc.Text)) And (length(edtNumDoc.Text) < 12) Then
     edtNumDoc.Text := fStrZero(edtNumDoc.Text, 12);
  If Not fEmptyStr(edtNumDoc.Text) Then
  Begin
     mskOcoIni.Clear;
     mskOcoFin.Clear;
     mskEmiIni.Clear;
     mskEmiFin.Clear;
  End;
end;

procedure TfrmLogAcompPedidos.edtProdutosExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtProdutos,edtDesProduto,arrProduto,nil,fRetNomProduto,'do Produto');
end;

procedure TfrmLogAcompPedidos.edtProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, nil, Key, arrProduto, False, nil, 'Consulta de Itens', '1') Then
  Begin
    If fValidaCampos(edtProdutos, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmLogAcompPedidos.fCarregaDados(
  pgbProgresso: TcxProgressBar): Boolean;
var
  blnCarregaFatPed: Boolean;
begin
  pcDados.ActivePage := tbAcompanhamento;

  blnCarregaFatPed := (chkExbFatPed.Checked) and (edtEspDoc.ItemIndex <> 1);

  With qryLogGor Do
  Begin
    qryLogSta.Close;
    Close;
    SQL.Clear;
    if not chkPedMultFat.Checked then
      SQL.Add(' SELECT ')
    else
      SQL.Add(' SELECT DISTINCT ');
    SQL.Add('   "N" AS MARCA, L.*, ');
    if not chkPedMultFat.Checked then
    begin
      SQL.Add('   IF(L.FGO_ESPDOC = "OR", ' + IfThen(blnCarregaFatPed, 'V', 'G') + '.FGO_NUMFAT, G.FGO_NUMFAT) AS FGO_NUMFAT, ');
      SQL.Add('   IF(L.FGO_ESPDOC = "OR", ' + IfThen(blnCarregaFatPed, 'V', 'G') + '.FGO_TIPFAT, G.FGO_TIPFAT) AS FGO_TIPFAT, ');
      SQL.Add('   IF(L.FGO_ESPDOC = "OR", ' + IfThen(blnCarregaFatPed, 'V', 'G') + '.FGO_EMPFAT, G.FGO_EMPFAT) AS FGO_EMPFAT, ');
    end
    else
    begin
      SQL.Add('   IFNULL(IFNULL(FD.FDO_NUMDOC, MD.DET_NUMDOC), IF(L.FGO_ESPDOC = "OR", ' + IfThen(blnCarregaFatPed, 'V', 'G') + '.FGO_NUMFAT, G.FGO_NUMFAT)) AS FGO_NUMFAT, ');
      SQL.Add('   IFNULL(IFNULL(FD.FDO_ESPDOC, MD.DET_ESPDOC), IF(L.FGO_ESPDOC = "OR", ' + IfThen(blnCarregaFatPed, 'V', 'G') + '.FGO_TIPFAT, G.FGO_TIPFAT)) AS FGO_TIPFAT, ');
      SQL.Add('   IFNULL(IFNULL(FD.FDO_CODEMP, MD.DET_CODEMP), IF(L.FGO_ESPDOC = "OR", ' + IfThen(blnCarregaFatPed, 'V', 'G') + '.FGO_EMPFAT, G.FGO_EMPFAT)) AS FGO_EMPFAT, ');
    end;
    SQL.Add('   C.CLI_NOMCLI AS NOMCLI, CONCAT(L.FGO_CODPOR,"-",P.POR_NOMPOR) AS NOMPOR, L.FGO_CODVEN, ');
    SQL.Add('   IF(L.FGO_ESPDOC = "OR", IFNULL(' + IfThen(blnCarregaFatPed, 'U', 'S') + '.STA_DESCRI, ""), IFNULL(S.STA_DESCRI, "")) AS STATUS, ');
    SQL.Add('   "" AS ALTERACOES, ');
    SQL.Add('   L.WTSMAQ,     ');
    SQL.Add('   L.WTS_IP,     ');
    SQL.Add('   CONCAT(E.FGO_CODTPA," - ",N.TPA_DESCRI) AS TIPATE,  ');
    SQL.Add('  "0000" AS CONTADOR, '); //Implementado para sempre gravar o contador, para que possa pegar o anterior qdo usar o filtro do combobox;
    SQL.Add('  "0000" AS CONT_ANTERIOR, '); //Implementado para gravar o nmero referente ao registro anterior;
    SQL.Add('  G.AUTOINCREM FGOINC ');
    SQL.Add(' FROM LOGGOR L   ');
    SQL.Add('   LEFT JOIN FATGOR G ON L.FGO_NUMDOC = G.FGO_NUMDOC ');
    SQL.Add('                     AND L.FGO_ESPDOC = G.FGO_ESPDOC ');
    SQL.Add('                     AND L.FGO_CODEMP = G.FGO_CODEMP ');
    SQL.Add('   LEFT JOIN EXTGOR E ON G.AUTOINCREM = E.FGO_SEQFGO ');
    SQL.Add('   LEFT JOIN FGOSTA S ON E.FGO_STATUS = S.STA_CODIGO ');
    if blnCarregaFatPed then
    begin
      SQL.Add('   LEFT JOIN FATGOR V ON G.FGO_NUMFAT = V.FGO_NUMDOC ');
      SQL.Add('                     AND G.FGO_TIPFAT = V.FGO_ESPDOC ');
      SQL.Add('                     AND G.FGO_EMPFAT = V.FGO_CODEMP ');
      SQL.Add('                     AND G.FGO_CODCLI = V.FGO_CODCLI ');
      SQL.Add('                     AND L.FGO_ESPDOC = "OR"         ');
      SQL.Add('   LEFT JOIN EXTGOR T ON V.AUTOINCREM = T.FGO_SEQFGO ');
      SQL.Add('   LEFT JOIN FGOSTA U ON T.FGO_STATUS = U.STA_CODIGO ');
    end;
    if chkPedMultFat.Checked then
    begin
      SQL.Add('   LEFT JOIN FATDOR D ON IF(L.FGO_ESPDOC = "OR", ' + IfThen(blnCarregaFatPed, 'V', 'G') + '.AUTOINCREM, G.AUTOINCREM) = D.FDO_SEQGER ');
      SQL.Add('   LEFT JOIN FATDOR FD ON D.FDO_NUMFAT = FD.FDO_NUMDOC ');
      SQL.Add('                      AND D.FDO_TIPFAT = FD.FDO_ESPDOC ');
      SQL.Add('                      AND D.FDO_EMPFAT = FD.FDO_CODEMP ');
      SQL.Add('                      AND D.FDO_CODCLI = FD.FDO_CODCLI ');
      SQL.Add('                      AND D.FDO_CODITE = FD.FDO_CODITE ');
      SQL.Add('                      AND D.FDO_SEQIND = FD.FDO_SEQIND ');
      SQL.Add('   LEFT JOIN MOVDET MD ON D.FDO_NUMDOC = MD.DET_NUM_PD ');
      SQL.Add('                      AND D.FDO_ESPDOC = MD.DET_ESP_PD ');
      SQL.Add('                      AND D.FDO_CODEMP = MD.DET_EMP_PD ');
      SQL.Add('                      AND D.FDO_CODCLI = MD.DET_CODCLI ');
      SQL.Add('                      AND D.FDO_CODITE = MD.DET_CODITE ');
      SQL.Add('                      AND D.FDO_SEQIND = MD.DET_IND_PD ');
    end;
    SQL.Add('   LEFT JOIN CADCLI C ON L.FGO_CODCLI = C.CLI_CODCLI ');
    SQL.Add('   LEFT JOIN CADPOR P ON L.FGO_CODPOR = P.POR_CODPOR ');
    SQL.Add('   LEFT JOIN CADTPA N ON E.FGO_CODTPA = N.TPA_CODIGO ');
    SQL.Add('  WHERE TRUE ');

    If Not fEmptyStr(edtNumDoc.Text) Then
    Begin
      SQL.Add(' AND L.FGO_NUMDOC = :NUMDOC ');
      ParamByName('NUMDOC').AsString := edtNumDoc.Text;
    End;

    If (edtEspDoc.ItemIndex > 0) Then
    Begin
      SQL.Add(' AND L.FGO_ESPDOC = :ESPDOC ');
      ParamByName('ESPDOC').AsString := edtEspDoc.Items[edtEspDoc.ItemIndex];
    End
    Else
      SQL.Add(' AND L.FGO_ESPDOC IN ("PD", "OR") ');

    If Not fEmptyStr(edtCodEmp.Text) Then
    Begin
      SQL.Add(' AND L.FGO_CODEMP = :CODEMP ');
      ParamByName('CODEMP').AsString := edtCodEmp.Text;
    End;

    If Not fEmptyStr(edtCodCli.Text) Then
    Begin
      SQL.Add(' AND L.FGO_CODCLI = :CODCLI ');
      ParamByName('CODCLI').AsString := edtCodCli.Text;
    End;

    If Not fEmptyStr(edtCodOpe.Text) Then
    Begin
      SQL.Add(' AND L.OPELOG = :OPELOG ');
      ParamByName('OPELOG').AsString := edtCodOpe.Text;
    End;

    If chkPedMultFat.Checked Then
      SQL.Add(fStrLocate(edtProdutos, arrProduto, 'D.FDO_CODITE', 'CODITE'));

    If (Not fEmptyStr(fTiraCaracEspeciais(mskOcoIni.Text))) And
       (Not fEmptyStr(fTiraCaracEspeciais(mskOcoFin.Text))) Then
    Begin
      SQL.Add(' AND L.DTALOG BETWEEN :OCOINI AND :OCOFIN ');
      ParamByName('OCOINI').AsDateTime := StrToDate(mskOcoIni.Text);
      ParamByName('OCOFIN').AsDateTime := StrToDate(mskOcoFin.Text);
    End;

    If (Not fEmptyStr(fTiraCaracEspeciais(mskEmiIni.Text))) And
       (Not fEmptyStr(fTiraCaracEspeciais(mskEmiFin.Text))) Then
    Begin
      SQL.Add(' AND L.FGO_DTAENT BETWEEN :EMIINI AND :EMIFIN ');
      ParamByName('EMIINI').AsDateTime := StrToDate(mskEmiIni.Text);
      ParamByName('EMIFIN').AsDateTime := StrToDate(mskEmiFin.Text);
    End;

    If (cbxSituacao.ItemIndex > 0) Then
    Begin
      SQL.Add(' AND L.FGO_SITUAC = :SITUAC ');
      ParamByName('SITUAC').AsString := cbxSituacao.Items[cbxSituacao.ItemIndex][1];
    End;

    Case cbxSituacaoPedido.ItemIndex of
      1 : SQL.Add(' AND G.FGO_JAFATU = 0 ');
      2 : SQL.Add(' AND G.FGO_JAFATU = 1 AND IFNULL(G.FGO_MOTBAI,"") = "" ');
      3 : SQL.Add(' AND G.FGO_JAFATU = 1 AND IFNULL(G.FGO_MOTBAI,"") <> "" ');
    End;

    SQL.Add(' ORDER BY L.FGO_NUMDOC, L.FGO_ESPDOC, L.FGO_CODEMP, L.DTALOG, L.HORLOG ');

    If chkPedMultFat.Checked Then
      pSetaParam(edtProdutos.Text, arrProduto, strLinPro, 'CODITE', qryLogGor);

    Filter := '';

    Open;
    qryLogSta.Open;

    TFloatField(FieldByName('FGO_TOTPRO')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FGO_DESESP')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FGO_TOTSER')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FGO_TOTIPI')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FGO_TOTRET')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FGO_VLRCON')).DisplayFormat := '#,##0.00';

    TStringField(FieldByName('MARCA')).ReadOnly := False;
    TStringField(FieldByName('ALTERACOES')).ReadOnly := False;
    TStringField(FieldByName('CONTADOR')).ReadOnly := False;
    TStringField(FieldByName('CONT_ANTERIOR')).ReadOnly := False;
    pDefineAlterações;
    qryLogGor.IndexFieldNames := 'DTALOG;HORLOG;FGO_CODEMP;FGO_ESPDOC;FGO_NUMDOC';
  End;
  Result := True;
end;

procedure TfrmLogAcompPedidos.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumDoc);
end;

procedure TfrmLogAcompPedidos.FormCreate(Sender: TObject);
begin
  inherited;
  pcDados.ActivePage := tbAcompanhamento;
end;

procedure TfrmLogAcompPedidos.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryLogGor);
  FreeAndNil(qryLogSta);
end;

procedure TfrmLogAcompPedidos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_F7: btnMarcarTodos.Click;
    VK_F8: btnDesmTodos.Click;
    VK_F10: btnConsultar.Click;
    VK_ESCAPE:
    Begin
      If Assigned(qryLogGor) Then
      Begin
        If Not qryLogGor.Active Then
          Close
        Else
        Begin
          qryLogSta.Close;
          qryLogGor.Close;

          pcDados.ActivePage := tbAcompanhamento;
        End;
      End
      Else
        Close;
    End;
    Else
      inherited;
  End;
end;

procedure TfrmLogAcompPedidos.FormShow(Sender: TObject);
begin
  inherited;
  qryLogGor := fCriaQuery(Self);
  dtsDados.DataSet := qryLogGor;

  qryLogSta := fCriaQuery(Self);
  dtsDadosSta.DataSet := qryLogSta;

  pConfiguraQueryStatus;

  mskOcoIni.Text := DateToStr(VS_Date);
  mskOcoFin.Text := DateToStr(VS_Date);
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa;
  cxgDadosViewSTATUS.Visible := fCfgSis('EXISTA', varBoolean);
  cxgDadosViewNOMPOR.Visible := fCfgSis('PORPED', VarBoolean);
  pVarreSelCol;
  cmbinfRegAlterado.enabled := False;
  chkExbFatPed.Enabled := edtEspDoc.ItemIndex <> 1;
end;

procedure TfrmLogAcompPedidos.pcDadosPageChanging(Sender: TObject;
  NewPage: TcxTabSheet; var AllowChange: Boolean);
begin
  inherited;
  If (NewPage = tbStatus) And (Not qryLogSta.Active) Then
  Begin
    fMensagem('ATENÇÃO!', 'Selecione um documento para visualizar as alterações de status', ['&OK']);
    AllowChange := False;
  End;
end;

procedure TfrmLogAcompPedidos.pConfiguraQueryStatus();
var
  strSQL: String;
begin
  qryLogSta.MasterSource := dtsDados;
  qryLogSta.MasterFields := 'FGOINC';

  strSQL := '';
  strSQL := strSQL + '  SELECT                                                               ';
  strSQL := strSQL + '    CONCAT(G.FGO_NUMDOC,"-",G.FGO_ESPDOC,"-",G.FGO_CODEMP) DOCUMENTO,  ';
  strSQL := strSQL + '    A.STA_DTAMUD,                                                      ';
  strSQL := strSQL + '    A.STA_HRAMUD,                                                      ';
  strSQL := strSQL + '    F.STA_DESCRI                                                       ';
  strSQL := strSQL + '  FROM                                                                 ';
  strSQL := strSQL + '    FATGOR G                                                           ';
  strSQL := strSQL + '    LEFT JOIN ALTSTA A                                                 ';
  strSQL := strSQL + '      ON G.AUTOINCREM = A.STA_SEQFGO                                   ';
  strSQL := strSQL + '    LEFT JOIN FGOSTA F                                                 ';
  strSQL := strSQL + '      ON A.STA_CODIGO = F.STA_CODIGO                                   ';
  strSQL := strSQL + '  WHERE                                                                ';
  strSQL := strSQL + '    G.AUTOINCREM =:FGOINC                                              ';
  strSQL := strSQL + '  ORDER BY                                                             ';
  strSQL := strSQL + '    A.STA_DTAMUD,                                                      ';
  strSQL := strSQL + '    A.STA_HRAMUD                                                       ';

  qryLogSta.SQL.Add(strSQL);
end;

function TfrmLogAcompPedidos.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = edtNumDoc) Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        mskEmiIni.Enabled := True;
      End
      Else
      Begin
        mskEmiIni.Enabled := False;
        mskEmiFin.Enabled := False;
        mskEmiIni.Clear;
        mskEmiFin.Clear;
      End;
    End
    Else If (Sender = mskOcoIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskOcoIni.Text)) Then
      Begin
        mskOcoFin.Enabled := False;
        mskOcoFin.Clear;
      End
      Else
        mskOcoFin.Enabled := True;
    End
    Else If (Sender = mskOcoFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskOcoIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskOcoFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A ocorrência final deve ser preenchida!', ['&OK']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskOcoIni.Text, mskOcoFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A ocorrência final deve ser maior ou igual a ocorrência inicial!', ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = mskEmiIni) And (mskEmiIni.Enabled) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskEmiIni.Text)) Then
      Begin
        mskEmiFin.Enabled := False;
        mskEmiFin.Clear;
      End
      Else
        mskEmiFin.Enabled := True;
    End
    Else If (Sender = mskEmiFin) And (mskEmiFin.Enabled) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskEmiIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskEmiFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A emissão final deve ser preenchida!', ['&OK']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskEmiIni.Text, mskEmiFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A emissão final deve ser maior ou igual a emissão inicial!', ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodCli) Then
    Begin
      If fEmptyStr(edtCodCli.Text) Then
        edtNomCli.Text := 'TODOS'
      Else
      Begin
        edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          Result := False;
          pMensagemOk('Cliente não encontrado!');
        End;
      End;
    End
    Else If (Sender = edtCodOpe) Then
    Begin
      If fEmptyStr(edtCodOpe.Text) Then
        edtNomOpe.Text := 'TODOS'
      Else
      Begin
        edtNomOpe.Text := fRetNomVendRep(edtCodOpe.Text);
        If fEmptyStr(edtNomOpe.Text) Then
        Begin
          Result := False;
          pMensagemOk('Operador não encontrado!');
        End;
      End;
    End
    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
        edtNomEmp.Text := 'TODAS'
      Else
      Begin
        edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          Result := False;
          pMensagemOk('Empresa não encontrada!');
        End
        Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&OK']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtProdutos) Then
    Begin
      pDesmarcaLista(edtProdutos,arrProduto);
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmLogAcompPedidos.pDefineAlterações;
var
  arrRef: Array of String;
  strRegAtual: String;
  strCamposDif: String;
  intIndex: Integer;
  icont : Integer;

const
  CAMPOS_IGNORADOS: Array[0..9] Of String = ('AUTOINCREM', 'MARCA', 'DTALOG', 'HORLOG', 'FRMLOG', 'OPELOG', 'ALTERACOES', 'FGO_SITUAC', 'STA_DTAMUD', 'STA_HRAMUD');
  CAMPOS_IGNORADOS_MULTFAT: Array[0..12] Of String = ('AUTOINCREM', 'MARCA', 'DTALOG', 'HORLOG', 'FRMLOG', 'OPELOG', 'ALTERACOES', 'FGO_SITUAC', 'STA_DTAMUD', 'STA_HRAMUD', 'FGO_NUMFAT', 'FGO_TIPFAT', 'FGO_EMPFAT');
begin
  qryLogGor.DisableControls;
  cxgDadosView.BeginUpdate;
  try
    SetLength(arrRef, qryLogGor.Fields.Count);

    With qryLogGor Do
    Begin
      First;
      strRegAtual := '';
      icont := 0;
      While not Eof Do
      Begin

        icont := icont + 1;

        Edit;
        FieldByName('CONTADOR').AsString := inttostr(icont);
        Post;

        If (strRegAtual <> FieldByName('FGO_NUMDOC').AsString + '|' +
                           FieldByName('FGO_ESPDOC').AsString + '|' +
                           FieldByName('FGO_CODEMP').AsString
        ) Then
        Begin
          strRegAtual := FieldByName('FGO_NUMDOC').AsString + '|' +
            FieldByName('FGO_ESPDOC').AsString + '|' +
            FieldByName('FGO_CODEMP').AsString;

          for intIndex := 0 to Fields.Count - 1 do
            arrRef[intIndex] := Fields[intIndex].AsString;
        End
        Else
        Begin
          strCamposDif := '/';
          for intIndex := 0 to Fields.Count - 1 do
          begin
            if not chkPedMultFat.Checked then
            begin
              if AnsiMatchStr(Fields[intIndex].FieldName, CAMPOS_IGNORADOS) then
                Continue;
            end
            else
            begin
              if AnsiMatchStr(Fields[intIndex].FieldName, CAMPOS_IGNORADOS_MULTFAT) then
                Continue;
            end;

            If (arrRef[intIndex] <> Fields[intIndex].AsString) Then
              strCamposDif := strCamposDif + Fields[intIndex].FieldName + '/';
          end;

          Edit;
          FieldByName('ALTERACOES').AsString := strCamposDif;
          FieldByName('CONT_ANTERIOR').AsString := inttostr(iCont-1);
          Post;

          for intIndex := 0 to Fields.Count - 1 do
            arrRef[intIndex] := Fields[intIndex].AsString;
        End;
        Next;
      End;

      pVerificaAplicaFiltroRegComAlteracao();

    End;
  finally
    qryLogGor.First;
    qryLogGor.EnableControls;
    cxgDadosView.EndUpdate;
  end;
end;

Procedure TfrmLogAcompPedidos.pVerificaAplicaFiltroRegComAlteracao();
 Var
     cmpfiltro : String;
     strListAnteriores : String;
Begin

    If (chkRegComAlteracao.Checked) and (cmbInfRegAlterado.ItemIndex <> -1) Then
    Begin

      cmpfiltro := '';

      Case cmbInfRegAlterado.ItemIndex Of
        0: cmpfiltro := 'FGO_DTAENT';
        1: cmpfiltro := 'FGO_CODCND';
        2: cmpfiltro := 'FGO_CODFPG';
        3: cmpfiltro := 'FGO_CODPOR';
        4: cmpfiltro := 'FGO_CODCLI';
      End;

      //FILTER PARA PEGAR APENAS AS ALTERACOES CONFORME O COMBO SELECIONADO.
      qryLogGor.Filtered  := False;
      qryLogGor.Filter := ' (ALTERACOES LIKE ''%' + cmpfiltro + '%'') ';
      qryLogGor.Filtered := True;

      strListAnteriores := fRetornaListaRegAntesAlteracao(qryLogGor);

      If Not FEmptyStr(strListAnteriores) Then
      Begin
         // FILTER PARA TRAZER OS ALTERADOS E O REGISTRO ANTERIOR;
         qryLogGor.Filtered  := False;
         qryLogGor.Filter := ' (ALTERACOES LIKE ''%' + cmpfiltro + '%'') '+
                               ' OR (CONTADOR IN (' + strListAnteriores + ') ) ';
         qryLogGor.Filtered := True;
      End;

    End;

End;

Function TfrmLogAcompPedidos.fRetornaListaRegAntesAlteracao(cdsGen:TDataSet): String;
Var
    res : String;
Begin

  res := '';

  cdsGen.First;
  While (Not cdsGen.Eof) Do
  Begin
    res := res + IIf( fEmptyStr(res), Quotedstr(trim(cdsGen.FieldByName('CONT_ANTERIOR').AsString)),
                                      ',' + QuotedStr(trim(cdsGen.FieldByName('CONT_ANTERIOR').AsString)) );

    cdsGen.Next;
  End;

  Result := Res;

End;

end.
