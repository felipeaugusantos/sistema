unit untVinculacaoNotaCompra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, untFuncFat,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Datasnap.DBClient, UniClientDataSet, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxImageComboBox, System.ImageList, Vcl.ImgList, cxImageList, MemDS, DBAccess,
  Uni, untLiberacao, cxCheckBox, cxTextEdit, cxCurrencyEdit;

type
  TfrmVinculacaoNotaCompra = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    btnCopiarChave: TBitBtnLocked;
    pnlRodape: TPanel;
    shpCamObr: TShape;
    lblCamObr: TLabel;
    grdProdutosDBTableView: TcxGridDBTableView;
    grdProdutosLevel1: TcxGridLevel;
    grdProdutos: TcxGrid;
    cdsProdutos: TUniClientDataSet;
    dtsProdutos: TDataSource;
    cdsProdutosAUTINC: TIntegerField;
    cdsProdutosCLAFIS: TStringField;
    cdsProdutosCODITE: TStringField;
    cdsProdutosDESITE: TStringField;
    cdsProdutosCODUNI: TStringField;
    cdsProdutosQTDITE: TFloatField;
    cdsProdutosVLRUNI: TFloatField;
    cdsProdutosVLRTOT: TFloatField;
    grdProdutosCLAFIS: TcxGridDBColumn;
    grdProdutosCODITE: TcxGridDBColumn;
    grdProdutosDESITE: TcxGridDBColumn;
    grdProdutosCODUNI: TcxGridDBColumn;
    grdProdutosQTDITE: TcxGridDBColumn;
    grdProdutosVLRUNI: TcxGridDBColumn;
    grdProdutosVLRTOT: TcxGridDBColumn;
    cdsProdutosSTATUS: TBooleanField;
    cdsProdutosCHACES: TStringField;
    cdsProdutosQTDCOM: TFloatField;
    grdProdutoSTATUS: TcxGridDBColumn;
    grdProdutosCHACES: TcxGridDBColumn;
    imgProduto: TcxImageList;
    cdsProdutosINDICE: TIntegerField;
    grdProdutosNUMDRW: TcxGridDBColumn;
    btnCopiarCFOP: TBitBtnLocked;
    btnCopiarDrawback: TBitBtnLocked;
    cdsProdutosNUMDRW: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnCopiarChaveClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure grdProdutosDBTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure btnCopiarCFOPClick(Sender: TObject);
    procedure btnCopiarDrawbackClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cdsProdutosBeforePost(DataSet: TDataSet);
    procedure cdsProdutosAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    objLiberacao: TLiberacao;
    function fRetornaDadosNotaCompra(strChaveAcesso, strCodIte: string): Boolean;
    function fTodasChavesPreenchidas: Boolean;
    function fValidaClaFis: Boolean;
    procedure pCopiarColuna(strColuna: String);
  public
    { Public declarations }
    objVenda: TFatVenda;
  end;

implementation

uses
  untFuncoesSimples, untConstantes;

{$R *.dfm}

procedure TfrmVinculacaoNotaCompra.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  if (not fValidaClaFis) then
    Exit;

  if (Not fTodasChavesPreenchidas) then
  begin
    objLiberacao.Clear;
    objLiberacao.strDirAce    := 'EXNTCO';
    objLiberacao.strCodOpe    := strLoginUsuarioLogado;
    objLiberacao.objMsgLibera.pAddTexto('Liberar a geração da nota sem uma chave de nota de compra válida para exportação.');

    if not objLiberacao.fLibera then
    begin
      Exit;
    end;
  end;

  Close;
  ModalResult := mrOk;
end;

procedure TfrmVinculacaoNotaCompra.btnCopiarCFOPClick(Sender: TObject);
begin
  inherited;
  pCopiarColuna('CLAFIS');
end;

procedure TfrmVinculacaoNotaCompra.btnCopiarChaveClick(Sender: TObject);
begin
  inherited;
  pCopiarColuna('CHACES');
end;

procedure TfrmVinculacaoNotaCompra.btnCopiarDrawbackClick(Sender: TObject);
begin
  inherited;
  pCopiarColuna('NUMDRW');
end;

procedure TfrmVinculacaoNotaCompra.cdsProdutosAfterPost(DataSet: TDataSet);
begin
  inherited;

  If (Not Self.Active) Then
    Exit;

  btnConfirma.Enabled := fTodasChavesPreenchidas;
end;

procedure TfrmVinculacaoNotaCompra.cdsProdutosBeforePost(DataSet: TDataSet);
  Var
    intIdx: Integer;
begin
  inherited;

  If (Not Self.Active) Then
    Exit;

  cdsProdutosSTATUS.Clear;
  If (Not fEmptyStr(cdsProdutos.FieldByName('CHACES').AsString)) Then
    cdsProdutos.FieldByName('STATUS').AsBoolean := fRetornaDadosNotaCompra(cdsProdutos.FieldByName('CHACES').AsString, cdsProdutos.FieldByName('CODITE').AsString);

  If (objVenda.strNotImp <> 'S') Then
  Begin
    If (Not fEmptyStr(cdsProdutos.FieldByName('NUMDRW').AsString)) Then
    Begin
      cdsProdutos.FieldByName('CLAFIS').AsString := CLAFIS_DRAWBACK;
    End
    Else If (cdsProdutos.FieldByName('CLAFIS').AsString = CLAFIS_DRAWBACK) Then
    Begin
      For intIdx := 0 To Length(objVenda.arrMatItens) -1 Do
      Begin
        If (objVenda.arrMatItens[intIdx].intAutInc = cdsProdutos.FieldByName('AUTINC').AsInteger) Then
        Begin
          objVenda.arrMatItens[intIdx].strNumDrw := '';
          objVenda.pDefineClassificacaoItem(objVenda.arrMatItens[intIdx], objVenda.fAtendeRegrasDifal(False, objVenda.arrMatItens[intIdx].strEmpIte));

          cdsProdutos.FieldByName('CLAFIS').AsString := objVenda.arrMatItens[intIdx].strClaFis;

          Break;
        End;
      End;
    End;
  End;
end;

procedure TfrmVinculacaoNotaCompra.FormCreate(Sender: TObject);
begin
  inherited;
  cdsProdutos.CreateDataSet;
  btnConfirma.Enabled := False;
  objLiberacao := TLiberacao.create;
end;

procedure TfrmVinculacaoNotaCompra.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objLiberacao);
end;

procedure TfrmVinculacaoNotaCompra.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case key of
    VK_F10: if btnConfirma.Enabled then
            begin
              btnConfirma.Click;
            end;
    VK_F2: btnCopiarChave.Click;
    VK_F3:if btnCopiarCFOP.Enabled then
           begin
             btnCopiarCFOP.Click;
           end;
    VK_F4: btnCopiarDrawback.Click;
  end;
end;

procedure TfrmVinculacaoNotaCompra.FormShow(Sender: TObject);
begin
  inherited;

  btnConfirma.Enabled := fTodasChavesPreenchidas;

  pSetFocus(grdProdutos);
  btnCopiarCFOP.Enabled := (objVenda.strNotImp = 'S');
  grdProdutosDBTableView.GetColumnByFieldName('NUMDRW').Focused := True;
  grdProdutosDBTableView.GetColumnByFieldName('CLAFIS').Options.Editing := btnCopiarCFOP.Enabled;
end;

function TfrmVinculacaoNotaCompra.fRetornaDadosNotaCompra(strChaveAcesso, strCodIte: string): Boolean;
var
  qryNotaCompra: TUniQuery;
begin
  Result := False;
  qryNotaCompra := fCriaQuery;
  try
    qryNotaCompra.Close;
    qryNotaCompra.SQL.Clear;
    qryNotaCompra.SQL.Add('SELECT DET_NUMDOC');
    qryNotaCompra.SQL.Add('FROM MOVDET');
    qryNotaCompra.SQL.Add('LEFT JOIN CADFIS ON FIS_NUMDOC = DET_NUMDOC AND');
    qryNotaCompra.SQL.Add('                    FIS_ESPDOC = DET_ESPDOC AND');
    qryNotaCompra.SQL.Add('                    FIS_CODEMP = DET_CODEMP AND');
    qryNotaCompra.SQL.Add('                    FIS_FORCLI = DET_CODFOR AND');
    qryNotaCompra.SQL.Add('                    FIS_SERIE_ = DET_SERIE_ AND');
    qryNotaCompra.SQL.Add('                    FIS_TIP_FC = DET_TIP_FC');
    qryNotaCompra.SQL.Add('WHERE FIS_ACESSO = :CHAVE');
    qryNotaCompra.SQL.Add('AND DET_CODITE = :CODITE');

    qryNotaCompra.ParamByName('CHAVE').AsString := strChaveAcesso;
    qryNotaCompra.ParamByName('CODITE').AsString := strCodIte;

    qryNotaCompra.Open;

    if not qryNotaCompra.IsEmpty then
    begin
      Result := True;
    end;
  finally
    FreeAndNil(qryNotaCompra);
  end;
end;

function TfrmVinculacaoNotaCompra.fValidaClaFis: Boolean;
var
  cdsDados: TUniClientDataSet;
begin
  Result := True;

  cdsDados := TUniClientDataSet.Create(Nil);
  try
    pCloneDataSet(cdsDados, cdsProdutos);
    cdsDados.First;

    while not cdsDados.Eof do
    begin
      if fEmptyStr(cdsDados.FieldByName('CLAFIS').AsString) then
      begin
        fMensagem('ATENÇÃO!', 'Há registros com a Classificação Fiscal em branco!', ['&Ok']);
        Result := False;
        Break;
      end;

      if (objVenda.strNotImp <> 'S') then
      begin
        if (not objVenda.blnVendaPresencial) and (cdsDados.FieldByName('CLAFIS').AsInteger <= 7000) then
        begin
          fMensagem('ATENÇÃO!', 'A Classificação Fiscal dos itens deve ser maior que 7000!', ['&Ok']);
          Result := False;
          Break;
        end;

        if (cdsDados.FieldByName('CLAFIS').AsString = '7127') and (fEmptyStr(cdsDados.FieldByName('NUMDRW').AsString)) then
        begin
          fMensagem('ATENÇÃO!', 'Não é permitido nº de DrawBack em branco para a classificação 7127!', ['&Ok']);
          Result := False;
          Break;
        end;
      end;

      cdsDados.Next;
    end;
  finally
    FreeAndNil(cdsDados);
  end;
end;

function TfrmVinculacaoNotaCompra.fTodasChavesPreenchidas: Boolean;
var
  cdsDados: TUniClientDataSet;
begin
  Result := True;

  cdsDados := TUniClientDataSet.Create(Nil);
  try
    pCloneDataSet(cdsDados, cdsProdutos);
    cdsDados.First;
    while not cdsDados.Eof do
    begin
      if fEmptyStr(cdsDados.FieldByName('CHACES').AsString) and (Pos(cdsDados.FieldByName('CLAFIS').AsString, fCfgSis('CLASET', varString)) > 0) then
      begin
        Result := False;
        Break;
      end;
      cdsDados.Next;
    end;
  Finally
    FreeAndNil(cdsDados)
  End;
end;

procedure TfrmVinculacaoNotaCompra.grdProdutosDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if AViewInfo.Item.Options.Editing then
  begin
    ACanvas.Brush.Color := $0080FFFF;
    ACanvas.Font.Color  := clBlack;
  end;
end;

procedure TfrmVinculacaoNotaCompra.pCopiarColuna(strColuna: String);
var
  strValor: string;
  intPosicao: integer;
begin
  if (not cdsProdutos.Active) then
    Exit;

  if (cdsProdutos.RecordCount = 0) then
    Exit;

  if (cdsProdutos.RecNo < 1) then
    Exit;

  strValor := cdsProdutos.FieldByName(strColuna).AsString;

  if fEmptyStr(strValor) then
    Exit;

  cdsProdutos.DisableControls;
  intPosicao := cdsProdutos.RecNo;
  cdsProdutos.First;
  try
    while not cdsProdutos.Eof do
    begin
      if (strColuna = 'CLAFIS') and (not fEmptyStr(cdsProdutos.FieldByName('NUMDRW').AsString)) then
      begin
        cdsProdutos.Next;
        Continue;
      end;

      cdsProdutos.Edit;
      cdsProdutos.FieldByName(strColuna).AsString := strValor;

      if (strColuna = 'NUMDRW') and (not fEmptyStr(strValor)) then
        cdsProdutos.FieldByName('CLAFIS').AsString := CLAFIS_DRAWBACK;

      cdsProdutos.Next;
    end;
  finally
    cdsProdutos.RecNo := intPosicao;
    cdsProdutos.EnableControls;
  end;
end;

end.
