unit untFatDefineTipoAbastecimentoItens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, frxClass,
  frxExportCSVTestabilidade, untFuncFat, untFuncFatTypes, untFatAbastecimentoItens,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient,
  UniClientDataSet, cxDropDownEdit, cxImageComboBox, System.ImageList,
  Vcl.ImgList, cxImageList, cxEditRepositoryItems;

type
  TfrmFatDefineTipoAbastecimentoItens = class(TfrmPaiEdit)
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    dsItens: TDataSource;
    btnConfirmar: TBitBtnLocked;
    Panel1: TPanel;
    chkSelecionarTodos: TCheckBox;
    cxStyle: TcxStyleRepository;
    cxsHeader: TcxStyle;
    cxEditRepository: TcxEditRepository;
    repEm_Est: TcxEditRepositoryImageComboBoxItem;
    imglEm_Est: TImageList;
    btnAlteraOrdem: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgItensViewStylesGetHeaderStyle(Sender: TcxGridTableView;
      AColumn: TcxGridColumn; var AStyle: TcxStyle);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure chkSelecionarTodosClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure cxgItensViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAlteraOrdemClick(Sender: TObject);
    procedure cxgItensViewEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
  private
    { Private declarations }
    objAbastecimento: TAbastecimentoItensPedido;
    blnConfirmou: Boolean;
    procedure pCriarCamposGrid;
    procedure pConfirmar;
  public
    { Public declarations }
    class function fDefinirTipoAbastecimento(objAbastecimento: TAbastecimentoItensPedido): Boolean;
  end;

implementation

uses untFuncoesSimples, untTypesSistema, untSolicitacaoTE, untGravando,
  untFatAlteraOrdemEmpresa;

{$R *.dfm}

procedure TfrmFatDefineTipoAbastecimentoItens.pConfirmar;
begin
  inherited;
  pSetFocus(cxgItens);

  blnConfirmou := objAbastecimento.fValidarTodosItens;

  If blnConfirmou Then
    Self.Close;
end;

procedure TfrmFatDefineTipoAbastecimentoItens.pCriarCamposGrid;
Var
  intCol: Integer;
begin
  cxgItensView.DataController.CreateAllItems();
  cxgItensView.BeginUpdate();

  For intCol := 0 To cxgItensView.ColumnCount -1 Do
    With cxgItensView.Columns[intCol], Options, DataBinding Do
      Editing := Pos(FieldName, 'QTDEST_QTDREQ_QTDTRA_ITESEL_FATPAR_') > 0;

  If objAbastecimento.ExibirProdutoEmEstoque Then
    cxgItensView.GetColumnByFieldName('EM_EST').RepositoryItem := repEm_Est;

  cxgItensView.ApplyBestFit();
  cxgItensView.EndUpdate();
end;

procedure TfrmFatDefineTipoAbastecimentoItens.btnAlteraOrdemClick(
  Sender: TObject);
var
  frmFatAlteraOrdemEmpresa: TfrmFatAlteraOrdemEmpresa;
  strCodEmp: string;
begin
  inherited;

  if not btnAlteraOrdem.Visible then
    Exit;

  if objAbastecimento.stlCodEmp.Count <= 1 then
    Exit;

  pCriarFormularios(TfrmFatAlteraOrdemEmpresa, frmFatAlteraOrdemEmpresa);

  try
    frmFatAlteraOrdemEmpresa.stlCodEmp.Clear;

    for strCodEmp in objAbastecimento.stlCodEmp do
    begin
      frmFatAlteraOrdemEmpresa.stlCodEmp.Add(strCodEmp);
    end;

    if frmFatAlteraOrdemEmpresa.ShowModal = mrOk then
    begin
      objAbastecimento.stlCodEmp.Clear;

      for strCodEmp in frmFatAlteraOrdemEmpresa.stlCodEmp do
      begin
        objAbastecimento.stlCodEmp.Add(strCodEmp);
      end;

      objAbastecimento.pEmpresasAbastecimento(True);

      fMensagem('','Alteração da ordem realizada com sucesso!',['&OK']);
    end;
  finally
    pFreeAndNil(frmFatAlteraOrdemEmpresa);
  end;
end;

procedure TfrmFatDefineTipoAbastecimentoItens.btnConfirmarClick(
  Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModalA(pConfirmar, 'Aguarde ...', '');
end;

procedure TfrmFatDefineTipoAbastecimentoItens.chkSelecionarTodosClick(
  Sender: TObject);
begin
  inherited;
  objAbastecimento.pSelecionarTodos(chkSelecionarTodos.Checked);
end;

procedure TfrmFatDefineTipoAbastecimentoItens.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If Not Assigned(dsItens.DataSet) Then
    Exit;

  If Not (AViewInfo.Item Is TcxGridDBColumn) Then
    Exit;

  If AViewInfo.GridRecord.Focused Then
    Exit;

  If (TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName = 'QTDEST') Or
     (TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName = 'QTDREQ') Or
     (TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName = 'QTDTRA') Then
  Begin
    ACanvas.Brush.Color := clYellow;
    ACanvas.Font.Color  := clBlack;
    ACanvas.Font.Style  := [fsBold];
  End;

  If Pos('EST_EMP_', TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName) > 0 Then
  Begin
    ACanvas.Brush.Color := clMoneyGreen;
    ACanvas.Font.Color  := clBlack;
  End;
end;

procedure TfrmFatDefineTipoAbastecimentoItens.cxgItensViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
var
  intLinha,
  intColuna: Integer;
begin
  inherited;

  if (Pos(TcxGridDBColumn(AItem).DataBinding.FieldName, 'QTDEST_QTDREQ_QTDTRA_') <= 0) then
    Exit;

  intLinha := TcxCustomGridTableView(Sender).Controller.FocusedRecordIndex;
  intColuna := cxgItensView.GetColumnByFieldName('LOTTOT').Index;

  AAllow := TcxCustomGridTableView(Sender).DataController.Values[intLinha, intColuna] = False;
end;

procedure TfrmFatDefineTipoAbastecimentoItens.cxgItensViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Return Then
    If dsItens.DataSet.State = dsEdit Then
      dsItens.DataSet.Post;
end;

procedure TfrmFatDefineTipoAbastecimentoItens.cxgItensViewStylesGetHeaderStyle(
  Sender: TcxGridTableView; AColumn: TcxGridColumn; var AStyle: TcxStyle);
begin
  inherited;
  AStyle := cxsHeader;
end;

class function TfrmFatDefineTipoAbastecimentoItens.fDefinirTipoAbastecimento(
  objAbastecimento: TAbastecimentoItensPedido): Boolean;
  Var
    frmFatDefineTipoAbastecimentoItens: TfrmFatDefineTipoAbastecimentoItens;
begin
  Try
    pCriarFormularios(TfrmFatDefineTipoAbastecimentoItens, frmFatDefineTipoAbastecimentoItens);
    frmFatDefineTipoAbastecimentoItens.objAbastecimento := objAbastecimento;
    frmFatDefineTipoAbastecimentoItens.ShowModal;
    Result := frmFatDefineTipoAbastecimentoItens.blnConfirmou;
  Finally
    pFreeAndNil(frmFatDefineTipoAbastecimentoItens);
  End;
end;

procedure TfrmFatDefineTipoAbastecimentoItens.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(cxgItens);
end;

procedure TfrmFatDefineTipoAbastecimentoItens.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirmou := False;
end;

procedure TfrmFatDefineTipoAbastecimentoItens.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10: Begin
              Key := 0;
              btnConfirmar.Click;
            End;
    VK_F9: btnAlteraOrdem.Click;
  End;
end;

procedure TfrmFatDefineTipoAbastecimentoItens.FormResize(Sender: TObject);
begin
  inherited;
  cxgItensView.BeginUpdate();
  cxgItensView.ApplyBestFit();
  cxgItensView.EndUpdate();
end;

procedure TfrmFatDefineTipoAbastecimentoItens.FormShow(Sender: TObject);
begin
  inherited;
  btnAlteraOrdem.Visible := fCfgSis('SEQABA', varBoolean);
  dsItens.DataSet := objAbastecimento.cdsItens;
  pCriarCamposGrid;
end;

end.

