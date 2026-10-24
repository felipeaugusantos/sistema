unit untEntEditaItensNfe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxCurrencyEdit, UniClientDataSet, Vcl.Grids, Vcl.DBGrids,
  Datasnap.DBClient, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmEntEditaItensNfe = class(TfrmPaiConfirma)
    cxViewPai: TcxGridDBTableView;
    cxLvlPai: TcxGridLevel;
    cxGrid1: TcxGrid;
    dtsPai: TDataSource;
    dtsFilho: TDataSource;
    cxViewFilho: TcxGridDBTableView;
    cxViewPaiTOTPRO: TcxGridDBColumn;
    cxViewPaiDIV_TOTPRO: TcxGridDBColumn;
    cxViewPaiBASICM: TcxGridDBColumn;
    cxViewPaiDIV_BASICM: TcxGridDBColumn;
    cxViewPaiVALICM: TcxGridDBColumn;
    cxViewPaiDIV_VALICM: TcxGridDBColumn;
    cxViewPaiBAS_ST: TcxGridDBColumn;
    cxViewPaiDIV_BAS_ST: TcxGridDBColumn;
    cxViewPaiVAL_ST: TcxGridDBColumn;
    cxViewPaiDIV_VAL_ST: TcxGridDBColumn;
    cxViewPaiBASIPI: TcxGridDBColumn;
    cxViewPaiDIV_BASIPI: TcxGridDBColumn;
    cxViewPaiVALIPI: TcxGridDBColumn;
    cxViewPaiDIV_VALIPI: TcxGridDBColumn;
    cxViewPaiVALFRE: TcxGridDBColumn;
    cxViewPaiDIV_VALFRE: TcxGridDBColumn;
    cxViewPaiVICMSDESON: TcxGridDBColumn;
    cxViewPaiVDESC: TcxGridDBColumn;
    cxViewPaiDIV_VDESC: TcxGridDBColumn;
    cxViewPaiVOUTRO: TcxGridDBColumn;
    cxViewPaiDIV_VOUTRO: TcxGridDBColumn;
    cxViewPaiVSEG: TcxGridDBColumn;
    cxViewPaiDIV_VSEG: TcxGridDBColumn;
    cxViewPaiTEM_DIVERGENCIA: TcxGridDBColumn;
    cxViewFilhoCHAVE_: TcxGridDBColumn;
    cxViewFilhoCODITE: TcxGridDBColumn;
    cxViewFilhoDESITE: TcxGridDBColumn;
    cxViewFilhoTOTPRO: TcxGridDBColumn;
    cxViewFilhoBASICM: TcxGridDBColumn;
    cxViewFilhoVALICM: TcxGridDBColumn;
    cxViewFilhoBAS_ST: TcxGridDBColumn;
    cxViewFilhoVAL_ST: TcxGridDBColumn;
    cxViewFilhoBASIPI: TcxGridDBColumn;
    cxViewFilhoVALIPI: TcxGridDBColumn;
    cxViewFilhoVALFRE: TcxGridDBColumn;
    cxViewFilhoVICMSDESON: TcxGridDBColumn;
    cxViewFilhoVDESC: TcxGridDBColumn;
    cxViewFilhoVOUTRO: TcxGridDBColumn;
    cxViewFilhoVSEG: TcxGridDBColumn;
    cxLvlFilho: TcxGridLevel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxViewFilhoStylesGetFooterSummaryStyle(AView: TcxGridTableView;
      ARow: TcxCustomGridRow; AColumn: TcxGridColumn;
      AFooterGroupLevel: Integer; ASummaryItem: TcxDataSummaryItem;
      var AStyle: TcxStyle);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxViewPaiVALICMCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxViewPaiVALIPICustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxViewPaiTOTPROCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxViewPaiBASICMCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxViewPaiBAS_STCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxViewPaiVAL_STCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxViewPaiBASIPICustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxViewPaiVALFRECustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxViewPaiVICMSDESONCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxViewPaiVDESCCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);

  protected
    FCdsPaiBackup,
    FCdsFilhoBackup,
    FCdsPai: TUniClientDataSet;

  private
    function fGetValorNota(strChave, strField: string; blnLocate: Boolean = True): Double;
    function fValoresIguais(vr1, vr2: Double): boolean;
    function fVerificaInconsistencia(strColunas : String) : Boolean;
    var stlColunas : TStringList;
    { Private declarations }
  public
    class function fShowModal(cdsPai, cdsFilho: TUniClientDataSet; blnHabilitaVICMSDESON: boolean): integer;
    procedure pnlBotoesClick(Sender: TObject);
    { Public declarations }
  end;

var
  frmEntEditaItensNfe: TfrmEntEditaItensNfe;

implementation

{$R *.dfm}

uses untFuncoesSimples;

{ TfrmEntEditaItensNfe }


procedure TfrmEntEditaItensNfe.pnlBotoesClick(Sender: TObject);
begin
  inherited;

end;

procedure TfrmEntEditaItensNfe.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  //Verifica valores e ve se tem divergencias ainda.
end;

procedure TfrmEntEditaItensNfe.cxViewFilhoStylesGetFooterSummaryStyle(
  AView: TcxGridTableView; ARow: TcxCustomGridRow; AColumn: TcxGridColumn;
  AFooterGroupLevel: Integer; ASummaryItem: TcxDataSummaryItem;
  var AStyle: TcxStyle);
  procedure pPintaDeVermelho(indexFooter: integer; Column : TcxGridDBColumn; FieldName: string);
   var v1: string;
  begin
    v1 := varToStr(AView.DataController.Summary.FooterSummaryValues[indexFooter]);
    If v1 = '' Then
      v1 := '0';

    If Not fValoresIguais(fStrToFloat(v1),
                          fGetValorNota(varToStr(AView.DataController.Values[0, cxViewFilhoCHAVE_.Index]),FieldName)) Then
    Begin
      AStyle := cxStyle1;

      if stlColunas.indexOf(FieldName) < 0 Then
        stlColunas.Add(FieldName);
    End
    Else
    Begin
      if stlColunas.indexOf(FieldName) >= 0 Then
        stlColunas.Delete(stlColunas.indexOf(FieldName));
    End;
  End;
begin
  inherited;
  Try
    If AColumn.index = cxViewFilhoTOTPRO.index Then
      pPintaDeVermelho(0, cxViewFilhoTOTPRO, 'TOTPRO');
    If AColumn.index = cxViewFilhoBASICM.index Then
      pPintaDeVermelho(1, cxViewFilhoBASICM, 'BASICM');
    If AColumn.index = cxViewFilhoVALICM.index Then
      pPintaDeVermelho(2, cxViewFilhoVALICM, 'VALICM');
    If AColumn.index = cxViewFilhoBAS_ST.index Then
      pPintaDeVermelho(3, cxViewFilhoBAS_ST, 'BAS_ST');
    If AColumn.index = cxViewFilhoVAL_ST.index Then
      pPintaDeVermelho(4, cxViewFilhoVAL_ST, 'VAL_ST');
    If AColumn.index = cxViewFilhoBASIPI.index Then
      pPintaDeVermelho(5, cxViewFilhoBASIPI, 'BASIPI');
    If AColumn.index = cxViewFilhoVALIPI.index Then
      pPintaDeVermelho(6, cxViewFilhoVALIPI, 'VALIPI');
    If AColumn.index = cxViewFilhoVALFRE.index Then
      pPintaDeVermelho(7, cxViewFilhoVALFRE, 'VALFRE');
    If AColumn.index = cxViewFilhoVICMSDESON.index Then
      pPintaDeVermelho(8, cxViewFilhoVICMSDESON, 'VICMSDESON');
    If AColumn.index = cxViewFilhoVDESC.index Then
      pPintaDeVermelho(9, cxViewFilhoVDESC, 'VDESC');
    If AColumn.index = cxViewFilhoVOUTRO.index Then
      pPintaDeVermelho(10, cxViewFilhoVOUTRO, 'VOUTRO');
    If AColumn.index = cxViewFilhoVSEG.index Then
      pPintaDeVermelho(11, cxViewFilhoVSEG, 'VSEG');
  Finally
  End;
end;

procedure TfrmEntEditaItensNfe.cxViewPaiBASICMCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
   if fVerificaInconsistencia('BASICM') Then
     ACanvas.Brush.Color := cxStyle1.Color;
end;

procedure TfrmEntEditaItensNfe.cxViewPaiBASIPICustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
   if fVerificaInconsistencia('BASIPI') Then
     ACanvas.Brush.Color := cxStyle1.Color;
end;

procedure TfrmEntEditaItensNfe.cxViewPaiBAS_STCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
   if fVerificaInconsistencia('BAS_ST') Then
     ACanvas.Brush.Color := cxStyle1.Color
end;

procedure TfrmEntEditaItensNfe.cxViewPaiTOTPROCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
   if fVerificaInconsistencia('TOTPRO') Then
     ACanvas.Brush.Color := cxStyle1.Color;
end;

procedure TfrmEntEditaItensNfe.cxViewPaiVALFRECustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
   if fVerificaInconsistencia('VALFRE') Then
     ACanvas.Brush.Color := cxStyle1.Color;
end;

procedure TfrmEntEditaItensNfe.cxViewPaiVALICMCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
   if fVerificaInconsistencia('VALICM') Then
     ACanvas.Brush.Color := cxStyle1.Color;
end;


procedure TfrmEntEditaItensNfe.cxViewPaiVALIPICustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
   if fVerificaInconsistencia('VALIPI') Then
     ACanvas.Brush.Color := cxStyle1.Color;
end;

procedure TfrmEntEditaItensNfe.cxViewPaiVAL_STCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
   if fVerificaInconsistencia('VAL_ST') Then
     ACanvas.Brush.Color := cxStyle1.Color;
end;

procedure TfrmEntEditaItensNfe.cxViewPaiVDESCCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
   if fVerificaInconsistencia('VICMSDESON') Then
     ACanvas.Brush.Color := cxStyle1.Color;
end;

procedure TfrmEntEditaItensNfe.cxViewPaiVICMSDESONCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
   if fVerificaInconsistencia('VDESC') Then
     ACanvas.Brush.Color := cxStyle1.Color;
end;

function TfrmEntEditaItensNfe.fGetValorNota(strChave, strField: string; blnLocate: Boolean = True): Double;
begin
  FCdsPaiBackup.First;
  Result := 0;
  If blnLocate Then
  begin
    If FCdsPaiBackup.Locate('CHAVE_', strChave, []) Then
       Result := FCdsPaiBackup.FieldByName(strField).AsFloat;
  End
  Else
    Result := FCdsPaiBackup.FieldByName(strField).AsFloat;
end;

procedure TfrmEntEditaItensNfe.FormCreate(Sender: TObject);
begin
  inherited;
  FCdsPai := TUniClientDataSet.Create(nil);
  FCdsPaiBackup := TUniClientDataSet.Create(nil);
  FCdsFilhoBackup := TUniClientDataSet.Create(nil);
  stlColunas := TStringList.Create;
end;

procedure TfrmEntEditaItensNfe.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(stlColunas);
  FreeAndNil(FCdsPai);
  FreeAndNil(FCdsFilhoBackup);
  FreeAndNil(FCdsFilhoBackup);
end;

class function TfrmEntEditaItensNfe.fShowModal(cdsPai, cdsFilho: TUniClientDataSet; blnHabilitaVICMSDESON: boolean): integer;
begin
  pCriarFormularios(TfrmEntEditaItensNfe, frmEntEditaItensNfe);
  Try
    frmEntEditaItensNfe.dtsPai.DataSet := cdsPai;
    frmEntEditaItensNfe.dtsFilho.DataSet := cdsFilho;
    frmEntEditaItensNfe.FCdsPaiBackup.Data := cdsPai.Data;
    frmEntEditaItensNfe.FCdsFilhoBackup.Data := cdsFilho.Data;
    frmEntEditaItensNfe.cxViewPaiVICMSDESON.Visible := blnHabilitaVICMSDESON;
    frmEntEditaItensNfe.cxViewFilhoVICMSDESON.Visible := blnHabilitaVICMSDESON;

    //Expande e recolhe o grid, assim é possível ler o somatório do filho
    frmEntEditaItensNfe.cxViewPai.ViewData.Expand(True);
    TcxGridViewData(frmEntEditaItensNfe.cxViewPai.ViewData).Collapse(False);

    Result := frmEntEditaItensNfe.ShowModal;
    If Not Result = mrOk Then
    Begin
      cdsFilho.Data := frmEntEditaItensNfe.FCdsFilhoBackup.Data;
      cdsPai.Data   := frmEntEditaItensNfe.FCdsPaiBackup.Data;
    End
    Else
    Begin
      cdsPai.First;
      While not cdsPai.Eof Do
      Begin
        cdsPai.Edit;
        cdsPai.FieldByName('ALTERADO').AsInteger := 1;
        cdsPai.Post;
        cdsPai.Next;
      End;
    End;
  Finally
    FreeAndNil(frmEntEditaItensNfe);
  End;

end;

function TfrmEntEditaItensNfe.fValoresIguais(vr1, vr2: Double): boolean;
begin
  Result := fFormataFloat(vr1, 2) = fFormataFloat(vr2, 2);
end;

function TfrmEntEditaItensNfe.fVerificaInconsistencia(strColunas : String) : Boolean;
var i : integer;
Begin
  Result := False;

  for i := 0 to stlColunas.Count -1 Do
  Begin
    if pos(strColunas, stlColunas[i]) > 0 Then
    Begin
      Result := True;
      Exit
    End;
  End;
End;


end.
