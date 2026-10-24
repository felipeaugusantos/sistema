unit untNotaFiscalImportMostraDiverg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, untEntNfeXml,
  UniClientDataSet, cxButtonEdit, cxEditRepositoryItems, cxImageComboBox,
  System.ImageList, Vcl.ImgList,
  untTPerfilDespachanteAduaneiro;

type
  TfrmNotaFiscalImportMostraDiverg = class(TfrmPaiConfirma)
    pnlTopo: TPanel;
    cxGridTBV: TcxGridDBTableViewCitel;
    cxGridLevel1: TcxGridLevel;
    cxGrid: TcxGridCitel;
    cxGridTBVVLR_DI: TcxGridDBColumn;
    cxGridTBVVLR_NF: TcxGridDBColumn;
    cxGridTBVDIVERG: TcxGridDBColumn;
    dtsGrid: TDataSource;
    imgCombo: TImageList;
    memMsg: TMemo;
    cxGridTBVDESCRI: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxGridTBVCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridTBVCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
    cdsDiverg: TUniClientDataSet;
    procedure pCriaDataSetDiverg;
    procedure pCarregaDados;
  public
    { Public declarations }
    recTotais: TRecTotais;
    cdsItens_DI: TUniClientDataSet;
    PerfilDespachanteAduaneiro: TPerfilDespachanteAduaneiro;
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples, untNotaFiscalImportValoresDiverg;

procedure TfrmNotaFiscalImportMostraDiverg.cxGridTBVCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var
  frmNotaFiscalImportValoresDiverg: TfrmNotaFiscalImportValoresDiverg;
begin
  inherited;

  if (ACellViewInfo.Item.Index <> cxGridTBVDIVERG.Index) then
    Exit;

  if ACellViewInfo.GridRecord.Values[cxGridTBVDIVERG.Index] = '1' then
  begin
    pCriarFormularios(TfrmNotaFiscalImportValoresDiverg, frmNotaFiscalImportValoresDiverg);

    try
      frmNotaFiscalImportValoresDiverg.intIndex := cdsDiverg.FieldByName('INDEX').AsInteger;
      frmNotaFiscalImportValoresDiverg.cdsItens_DI := cdsItens_DI;
      frmNotaFiscalImportValoresDiverg.pCarregaValores;

      If frmNotaFiscalImportValoresDiverg.fExisteRegistrosDivergentes Then
        frmNotaFiscalImportValoresDiverg.ShowModal
      Else
        fMensagem('ATENÇÃO!', 'Não existe itens divergentes!', ['&Ok']);

    finally
      pFreeAndNil(frmNotaFiscalImportValoresDiverg);
    end;
  end;
end;

procedure TfrmNotaFiscalImportMostraDiverg.cxGridTBVCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridTBVDIVERG.Index] = '1') then
    ACanvas.Font.Color := clRed;
end;

procedure TfrmNotaFiscalImportMostraDiverg.FormCreate(Sender: TObject);
begin
  inherited;

  cdsDiverg := TUniClientDataSet.Create(Self);
  pCriaDataSetDiverg;
end;

procedure TfrmNotaFiscalImportMostraDiverg.FormDestroy(Sender: TObject);
begin
  inherited;

  dtsGrid.Dataset := Nil;
  FreeAndNil(cdsDiverg);
end;

procedure TfrmNotaFiscalImportMostraDiverg.FormShow(Sender: TObject);
begin
  inherited;

  pCarregaDados;
  dtsGrid.Dataset := cdsDiverg;
end;

procedure TfrmNotaFiscalImportMostraDiverg.pCarregaDados;
begin
  cdsDiverg.Append;
  cdsDiverg.FieldByname('INDEX').AsInteger := 0;
  cdsDiverg.FieldByname('DESCRI').AsString := 'Vr. Mercadorias';
  If Assigned(PerfilDespachanteAduaneiro) then
  begin
    cdsDiverg.FieldByname('VLR_DI').AsFloat  := recTotais.fltTotIte_DI - IIF(tcvcII in PerfilDespachanteAduaneiro.ComposicaoValorContabil, recTotais.fltII_DI, 0);
    cdsDiverg.FieldByname('VLR_NF').AsFloat  := recTotais.fltTotIte_NF - IIF(tcvcII in PerfilDespachanteAduaneiro.ComposicaoValorContabil, recTotais.fltII_NF, 0);
  end;
  cdsDiverg.FieldByname('DIVERG').AsInteger := IIF(fFormataFloat(recTotais.fltTotIte_DI, 2) <>
    fFormataFloat(recTotais.fltTotIte_NF, 2), 1, 0);
  cdsDiverg.Post;

  cdsDiverg.Append;
  cdsDiverg.FieldByname('INDEX').AsInteger := 1;
  cdsDiverg.FieldByname('DESCRI').AsString := 'Vr. Imposto de Importação';
  cdsDiverg.FieldByname('VLR_DI').AsFloat  := recTotais.fltII_DI;
  cdsDiverg.FieldByname('VLR_NF').AsFloat  := recTotais.fltII_NF;
  cdsDiverg.FieldByname('DIVERG').AsInteger := IIF(fFormataFloat(recTotais.fltII_DI, 2) <>
    fFormataFloat(recTotais.fltII_NF, 2), 1, 0);
  cdsDiverg.Post;

  cdsDiverg.Append;
  cdsDiverg.FieldByname('INDEX').AsInteger := 2;
  cdsDiverg.FieldByname('DESCRI').AsString := 'Vr. IPI';
  cdsDiverg.FieldByname('VLR_DI').AsFloat  := recTotais.fltIPI_DI;
  cdsDiverg.FieldByname('VLR_NF').AsFloat  := recTotais.fltIPI_NF;
  cdsDiverg.FieldByname('DIVERG').AsInteger := IIF(fFormataFloat(recTotais.fltIPI_DI, 2) <>
    fFormataFloat(recTotais.fltIPI_NF, 2), 1, 0);
  cdsDiverg.Post;

  cdsDiverg.Append;
  cdsDiverg.FieldByname('INDEX').AsInteger := 3;
  cdsDiverg.FieldByname('DESCRI').AsString := 'Vr. PIS';
  cdsDiverg.FieldByname('VLR_DI').AsFloat  := recTotais.fltPIS_DI;
  cdsDiverg.FieldByname('VLR_NF').AsFloat  := recTotais.fltPIS_NF;
  cdsDiverg.FieldByname('DIVERG').AsInteger := IIF(fFormataFloat(recTotais.fltPIS_DI, 2) <>
    fFormataFloat(recTotais.fltPIS_NF, 2), 1, 0);
  cdsDiverg.Post;

  cdsDiverg.Append;
  cdsDiverg.FieldByname('INDEX').AsInteger := 4;
  cdsDiverg.FieldByname('DESCRI').AsString := 'Vr. COFINS';
  cdsDiverg.FieldByname('VLR_DI').AsFloat  := recTotais.fltCOFINS_DI;
  cdsDiverg.FieldByname('VLR_NF').AsFloat  := recTotais.fltCOFINS_NF;
  cdsDiverg.FieldByname('DIVERG').AsInteger := IIF(fFormataFloat(recTotais.fltCOFINS_DI, 2) <>
    fFormataFloat(recTotais.fltCOFINS_NF, 2), 1, 0);
  cdsDiverg.Post;

  cdsDiverg.Append;
  cdsDiverg.FieldByname('INDEX').AsInteger := 5;
  cdsDiverg.FieldByname('DESCRI').AsString := 'Taxa Siscomex';
  cdsDiverg.FieldByname('VLR_DI').AsFloat  := recTotais.fltSiscom_DI;
  cdsDiverg.FieldByname('VLR_NF').AsFloat  := recTotais.fltSiscom_NF;
  cdsDiverg.FieldByname('DIVERG').AsInteger := 0;
  cdsDiverg.Post;

  cdsDiverg.Append;
  cdsDiverg.FieldByname('INDEX').AsInteger := 6;
  cdsDiverg.FieldByname('DESCRI').AsString := 'Taxa AFRMM';
  cdsDiverg.FieldByname('VLR_DI').AsFloat  := recTotais.fltAFRMM_DI;
  cdsDiverg.FieldByname('VLR_NF').AsFloat  := recTotais.fltAFRMM_NF;
  cdsDiverg.FieldByname('DIVERG').AsInteger := IIF(fFormataFloat(recTotais.fltAFRMM_DI, 2) <>
    fFormataFloat(recTotais.fltAFRMM_NF, 2), 1, 0);
  cdsDiverg.Post;

  cdsDiverg.Append;
  cdsDiverg.FieldByname('INDEX').AsInteger := 7;
  cdsDiverg.FieldByname('DESCRI').AsString := 'Vr.ICMS Incorporado';
  cdsDiverg.FieldByname('VLR_DI').AsFloat  := recTotais.fltICMS_DI;
  cdsDiverg.FieldByname('VLR_NF').AsFloat  := recTotais.fltICMS_NF;
  cdsDiverg.FieldByname('DIVERG').AsInteger := IIF(fFormataFloat(recTotais.fltICMS_DI, 2) <>
    fFormataFloat(recTotais.fltICMS_NF, 2), 1, 0);
  cdsDiverg.Post;
end;

procedure TfrmNotaFiscalImportMostraDiverg.pCriaDataSetDiverg;
begin
  cdsDiverg.FieldDefs.Add('INDEX', ftInteger);
  cdsDiverg.FieldDefs.Add('DESCRI', ftString, 30);
  cdsDiverg.FieldDefs.Add('VLR_DI', ftFloat);
  cdsDiverg.FieldDefs.Add('VLR_NF', ftFloat);
  cdsDiverg.FieldDefs.Add('DIVERG', ftInteger);
  cdsDiverg.CreateDataSet;

  (cdsDiverg.FieldByName('VLR_DI') As TFloatField).DisplayFormat := fMskDigitos(2);
  (cdsDiverg.FieldByName('VLR_DI') As TFloatField).EditFormat    := fMskDigitos(2);

  (cdsDiverg.FieldByName('VLR_NF') As TFloatField).DisplayFormat := fMskDigitos(2);
  (cdsDiverg.FieldByName('VLR_NF') As TFloatField).EditFormat    := fMskDigitos(2);
end;

end.
