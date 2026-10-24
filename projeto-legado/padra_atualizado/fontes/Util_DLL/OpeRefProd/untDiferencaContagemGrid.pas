unit untDiferencaContagemGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxGridBandedTableView,
  cxGridDBBandedTableView, untHistoricoBalanco, cxCurrencyEdit, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus;

type
  TfrmDiferencaContagemGrid = class(TfrmPai)
    cxgProdutosLevel1: TcxGridLevel;
    cxgProdutos: TcxGrid;
    cxvProdutos: TcxGridDBBandedTableView;
    cxvProdutosColumn1: TcxGridDBBandedColumn;
    cxvProdutosColumn2: TcxGridDBBandedColumn;
    cxvProdutosColumn3: TcxGridDBBandedColumn;
    cxvProdutoSALCON: TcxGridDBBandedColumn;
    cxvProdutosColumn5: TcxGridDBBandedColumn;
    cxvProdutosColumn6: TcxGridDBBandedColumn;
    cxvProdutosColumn7: TcxGridDBBandedColumn;
    cxvProdutosGMLCON: TcxGridDBBandedColumn;
    cxvProdutosDIFML: TcxGridDBBandedColumn;
    cxvProdutosSAL_ML: TcxGridDBBandedColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxsZebra: TcxStyle;
    Panel1: TPanel;
    grbContagem: TGroupBox;
    Label2: TLabel;
    dbeDtaCon: TDBEditFocus;
    Label3: TLabel;
    dbeHorCon: TDBEditFocus;
    Label4: TLabel;
    dbeCodOpe: TDBEditFocus;
    dbeNomOpe: TDBEditFocus;
    dtsProdutos: TDataSource;
    pnlLegenda: TPanel;
    shpAltera: TShape;
    Label1: TLabel;
    cxvProdutosRESGAR: TcxGridDBBandedColumn;
    cxvProdutosESTMAN: TcxGridDBBandedColumn;
    cxvProdutosBEACSS: TcxGridDBBandedColumn;

    procedure cxvProdutoSALCONCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormShow(Sender: TObject);
    procedure cxvProdutosFocusedItemChanged(Sender: TcxCustomGridTableView;
      APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
    procedure cxvProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    objHistorico: THistoricoBalanco;
  end;

var
  frmDiferencaContagemGrid: TfrmDiferencaContagemGrid;

implementation

{$R *.dfm}

Uses
  StrUtils,
  UITypes,
  untFuncoesSimples, untBalancoEstoqueManutencao;

procedure TfrmDiferencaContagemGrid.cxvProdutoSALCONCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  ACanvas.Brush.Color := shpAltera.Brush.Color;

  If AViewInfo.Selected Then
    ACanvas.Font.Color := clBlue;
end;

procedure TfrmDiferencaContagemGrid.cxvProdutosFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;

  If StartsStr('CONTA', TcxGridDBColumn(AFocusedItem).DataBinding.FieldName) Or
     StartsStr('CONML', TcxGridDBColumn(AFocusedItem).DataBinding.FieldName) Then
  Begin

    If objHistorico.cdsMapa.FindField('DTACO' + RightStr(TcxGridDBColumn(AFocusedItem).DataBinding.FieldName, 1)) <> Nil Then
    Begin
      grbContagem.Caption := 'Detalhe da Contagem ' + RightStr(TcxGridDBColumn(AFocusedItem).DataBinding.FieldName, 1);

      dtsProdutos.DataSet := objHistorico.cdsMapa;
      dbeDtaCon.DataField := 'DTACO' + RightStr(TcxGridDBColumn(AFocusedItem).DataBinding.FieldName, 1);
      dbeHorCon.DataField := 'HORCO' + RightStr(TcxGridDBColumn(AFocusedItem).DataBinding.FieldName, 1);
      dbeCodOpe.DataField := 'CODOP' + RightStr(TcxGridDBColumn(AFocusedItem).DataBinding.FieldName, 1);
      dbeNomOpe.DataField := 'OPERA' + RightStr(TcxGridDBColumn(AFocusedItem).DataBinding.FieldName, 1);
      grbContagem.Enabled := True;
    End;

  End Else
  Begin
    grbContagem.Caption := 'Detalhe da Contagem';
    dtsProdutos.DataSet := Nil;
    grbContagem.Enabled := False;
  End;

end;

procedure TfrmDiferencaContagemGrid.cxvProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: If objHistorico.cdsMapa.State = dsEdit Then
                 objHistorico.cdsMapa.Cancel
               Else
                 Self.Close;
  End;
end;

procedure TfrmDiferencaContagemGrid.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If objHistorico.cdsMapa.State = dsEdit Then
                 objHistorico.cdsMapa.Post;

  If Not fpergunta('Deseja abandonar a tarefa') Then
    Action := caNone;
end;

procedure TfrmDiferencaContagemGrid.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If fCheckParent(ActiveControl, cxgProdutos) Then
               Begin

                 If cxvProdutosGMLCON.Focused Then
                 Begin
                   cxvProdutos.NavigatorButtons.Next.Click;
                   cxvProdutoSALCON.Focused := True;
                 End

                 Else If cxvProdutoSALCON.Focused Then
                 Begin

                   If cxvProdutosGMLCON.Visible Then
                     cxvProdutosGMLCON.Focused := True
                   Else
                     cxvProdutos.NavigatorButtons.Next.Click;

                 End;

               End;
  End;
end;

procedure TfrmDiferencaContagemGrid.FormShow(Sender: TObject);
  Var
    intContador: Integer;
    cxItem: TcxCustomGridTableItem;
begin
  inherited;

  For intContador := 1 To objHistorico.intMaxContagem Do
  Begin
    cxItem := frmDiferencaContagemGrid.cxvProdutos.DataController.CreateItemByField(
      objHistorico.cdsMapa.FieldByName('CONTA' +  intContador.ToString));

    TcxGridDBBandedColumn(cxItem).Position.BandIndex := 1;
    TcxGridDBColumn(cxItem).HeaderAlignmentHorz := taCenter;
    TcxGridDBColumn(cxItem).Options.Editing := False;
    TcxGridDBColumn(cxItem).Caption := 'Cotagem ' + intContador.ToString;
    TcxGridDBColumn(cxItem).Width := 85;

    TcxGridDBColumn(cxItem).PropertiesClass := TcxCurrencyEditProperties;
    TcxCurrencyEditProperties(TcxGridDBColumn(cxItem).Properties).DecimalPlaces := 3;
    TcxCurrencyEditProperties(TcxGridDBColumn(cxItem).Properties).DisplayFormat := ',0.000;-,0.000';

    If objHistorico.blnUsaTmq Then
    Begin
      cxItem := frmDiferencaContagemGrid.cxvProdutos.DataController.CreateItemByField(
         objHistorico.cdsMapa.FieldByName('CONML' +  intContador.ToString));

      TcxGridDBBandedColumn(cxItem).Position.BandIndex := 1;
      TcxGridDBColumn(cxItem).HeaderAlignmentHorz := taCenter;
      TcxGridDBColumn(cxItem).Options.Editing := False;
      TcxGridDBColumn(cxItem).Caption := 'Cotagem ML/GR ' + intContador.ToString;

      TcxGridDBColumn(cxItem).PropertiesClass := TcxCurrencyEditProperties;
      TcxCurrencyEditProperties(TcxGridDBColumn(cxItem).Properties).DecimalPlaces := 3;
      TcxCurrencyEditProperties(TcxGridDBColumn(cxItem).Properties).DisplayFormat := ',0.000;-,0.000';
      TcxGridDBColumn(cxItem).Width := 85;
    End;

  End;

  cxvProdutosSAL_ML.Visible := objHistorico.blnUsaTmq;
  cxvProdutosGMLCON.Visible := objHistorico.blnUsaTmq;
  cxvProdutosDIFML.Visible  := objHistorico.blnUsaTmq;

  cxvProdutosRESGAR.Visible := fCfgSis('ESTAJU', varInteger) = 2;
  cxvProdutosESTMAN.Visible := fCfgSis('ESTMAN', varInteger) = 2;
  cxvProdutosBEACSS.Visible := TGerenciaBalancoEstoqueManutencao.fhabilitadoBEACCS;

  cxvProdutos.DataController.DataSource := objHistorico.cdsMapa.dtsSource;
end;

end.
