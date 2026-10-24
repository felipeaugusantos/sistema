unit Contabilidade.View.LancamentosContabeis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls,
  cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, untGeraExcel, untExcel;

type
  TfrmLancamentosContabeis = class(TfrmPaiContabilidade)
    Grid: TcxGridCitel;
    GridTab: TcxGridDBTableViewCitel;
    GridTabAUTOINCREM: TcxGridDBColumn;
    GridTabCON_EMPLAN: TcxGridDBColumn;
    GridTabCON_DTALAN: TcxGridDBColumn;
    GridTabCON_VALLAN: TcxGridDBColumn;
    GridTabCON_TIPLAN: TcxGridDBColumn;
    GridTabCON_DESVAL: TcxGridDBColumn;
    GridTabCON_CONDEB: TcxGridDBColumn;
    GridTabCON_DESDEB: TcxGridDBColumn;
    GridTabCON_CONCRE: TcxGridDBColumn;
    GridTabCON_DESCRE: TcxGridDBColumn;
    GridTabCON_HISTOR: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    srcLancamentosContabeis: TDataSource;
    btnExportar: TBitBtnLocked;
    procedure btnExportarClick(Sender: TObject);
  private
    FdsLancamentosContabeis: TDataset;
    procedure OnGeraExcel(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
  public
    procedure pApontarDataset(var ADataset: TDataset);
  end;

  procedure pMostraLancamentosContabeis(var ADataset: TDataset; const AstrCaption: string = '');

implementation

{$R *.dfm}

uses
  untFuncoesSimples;

procedure pMostraLancamentosContabeis(var ADataset: TDataset; const AstrCaption: string = '');
var
  LfrmLancamentosContabeis: TfrmLancamentosContabeis;
begin
  if not Assigned(ADataset) then
    raise Exception.Create('Dataset não instanciado [pMostraLancamentosContabeis]');

  if not ADataset.Active then
    raise Exception.Create('Dataset não está ativo [pMostraLancamentosContabeis]');

  LfrmLancamentosContabeis := nil;
  try
    pCriarFormularios(TfrmLancamentosContabeis, LfrmLancamentosContabeis);
    if not AstrCaption.IsEmpty then
      LfrmLancamentosContabeis.Caption := AstrCaption;
    LfrmLancamentosContabeis.pApontarDataset(ADataset);
    LfrmLancamentosContabeis.ShowModal;
  finally
    if Assigned(LfrmLancamentosContabeis) then
      FreeAndNil(LfrmLancamentosContabeis);
  end;
end;

{ TfrmLancamentosContabeis }

procedure TfrmLancamentosContabeis.btnExportarClick(Sender: TObject);
begin
  inherited;

  if (not Assigned(FdsLancamentosContabeis)) or FdsLancamentosContabeis.IsEmpty then
    Exit;

  if TGeraExcel.fGerarRelatorio(GridTab, Self.Caption, OnGeraExcel) then
    fMensagem('','Arquivo Salvo com Sucesso!', ['&OK']);
end;

procedure TfrmLancamentosContabeis.OnGeraExcel(Excel: TExcel; Dados: TDataSet;
  Campos: TCampos; CorFundo: TCorExcel);
begin
  //
end;

procedure TfrmLancamentosContabeis.pApontarDataset(var ADataset: TDataset);
var
  LintCount: Integer;
  LCol: TcxGridDBColumn;
begin
  FdsLancamentosContabeis := ADataset;
  srcLancamentosContabeis.DataSet := FdsLancamentosContabeis;

  //oculta as colunas do grid que não existem no dataset, exceto autoincrem
  for LintCount := 0 to GridTab.ColumnCount - 1 do
  begin
    LCol := GridTab.Columns[LintCount];

    if LCol.DataBinding.FieldName.ToUpper = 'AUTOINCREM' then
    begin
      LCol.Visible := False;
      Continue;
    end;

    LCol.Visible := (LCol.DataBinding.FieldName = '') or (ADataset.FindField(LCol.DataBinding.FieldName) <> nil);
  end;

end;

end.
