unit untFatItensSerie;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Datasnap.DBClient,
  UniClientDataSet, untFuncoesSimples, untFatMultiSerie, untFuncFat;

type
  TfrmFatItensSerie = class(TfrmPai)
    cdsSeries: TUniClientDataSet;
    cdsSeriesNUMSER: TStringField;
    dtsSeries: TDataSource;
    cxgNumeroSerie: TcxGridCitel;
    cxgNumeroSerieTV: TcxGridDBTableViewCitel;
    cxgNumeroSerieLevel: TcxGridLevel;
    btnConfirmar: TBitBtnLocked;
    btnNumeroSerie: TBitBtnLocked;
    cdsSeriesCODITE: TStringField;
    cdsSeriesDESITE: TStringField;
    cdsSeriesCODUNI: TStringField;
    cdsSeriesCODFAB: TStringField;
    cdsSeriesQUANT: TFloatField;
    cxgNumeroSerieTVCODITE: TcxGridDBColumn;
    cxgNumeroSerieTVDESITE: TcxGridDBColumn;
    cxgNumeroSerieTVCODUNI: TcxGridDBColumn;
    cxgNumeroSerieTVCODFAB: TcxGridDBColumn;
    cxgNumeroSerieTVQUANT: TcxGridDBColumn;
    cxgNumeroSerieTVNUMSER: TcxGridDBColumn;
    cdsSeriesAUTOINCREM: TStringField;
    cdsSeriesCODEMP: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnNumeroSerieClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    fatVenda : TFatVenda;
  end;

var
  frmFatItensSerie: TfrmFatItensSerie;

implementation

{$R *.dfm}

procedure TfrmFatItensSerie.btnNumeroSerieClick(Sender: TObject);
  var
    frmFatMultiSerie: TfrmFatMultiSerie;
    strSeries: String;
begin
  inherited;

  pCriarFormularios(TfrmFatMultiSerie, frmFatMultiSerie);
  strSeries := '';
  Try
    fatVenda.objFatSerieItem.pApagaSeries;

    fatVenda.objFatSerieItem.AutoincItem := cdsSeriesAUTOINCREM.AsString;
    fatVenda.objFatSerieItem.pFiltraDataSet;
    If fatVenda.objFatSerieItem.cdsFatSeries.IsEmpty Then
      fatVenda.objFatSerieItem.pCarregaSeriesItem(cdsSeriesCODITE.AsString, cdsSeriesCODEMP.AsString);


    frmFatMultiSerie.pAlimentaCdsSeries(fatVenda.objFatSerieItem.cdsFatSeries);
    frmFatMultiSerie.fltQtdItemPed := cdsSeriesQUANT.AsFloat;

    frmFatMultiSerie.ShowModal;

    If frmFatMultiSerie.ModalResult <> mrOk Then
      Exit;

    frmFatMultiSerie.cdsSeries.First;
    fatVenda.objFatSerieItem.pDeletaSerieDoItem;

    While Not frmFatMultiSerie.cdsSeries.Eof Do
    Begin
      If (frmFatMultiSerie.cdsSeriesQTDSER.AsFloat > 0) Then
      Begin
        fatVenda.objFatSerieItem.pInsereSerie(frmFatMultiSerie.cdsSeriesNUMSER.AsString,
                                              frmFatMultiSerie.cdsSeriesQTDSER.AsFloat);

        fatVenda.objFatSerieItem.pInsereSerieParaGravacao(frmFatMultiSerie.cdsSeriesNUMSER.AsString,
                                                          frmFatMultiSerie.cdsSeriesQTDSER.AsFloat);

        If fEmptyStr(strSeries) Then
          strSeries := frmFatMultiSerie.cdsSeriesNUMSER.AsString
        Else
          strSeries := strSeries + ',' + frmFatMultiSerie.cdsSeriesNUMSER.AsString;
      End;
      frmFatMultiSerie.cdsSeries.Next;
    End;

    cdsSeries.Edit;
    cdsSeriesNUMSER.AsString := strSeries;
    cdsSeries.Post;

    If cdsVenda.Locate(IIF(Length(cdsSeriesAUTOINCREM.AsString)=20,'ITE_SEQDET', 'AUTOINCREM'), cdsSeriesAUTOINCREM.AsString, []) Then
    Begin
      cdsVenda.Edit;
      cdsVenda.FieldByName('ITE_TEMNSE').AsString := 'S';
      cdsVenda.Post;
    End;

  Finally
    pFreeAndNil(frmFatMultiSerie);
  End;
end;

procedure TfrmFatItensSerie.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  cdsSeries.DisableControls;
  cdsSeries.First;
  While Not cdsSeries.Eof Do
  Begin
    If (cdsSeriesNUMSER.AsString.IsEmpty) Then
    Begin
     pMensagemOk('Existem itens sem a informação do número de série!');
     Exit;
    End;

    cdsSeries.Next;
  End;

  ModalResult := mrOk;
end;

procedure TfrmFatItensSerie.FormCreate(Sender: TObject);
begin
  inherited;
  cdsSeriesQUANT.DisplayFormat := fMskDigitos( fCfgSis('DECQTD', varInteger) );
end;

procedure TfrmFatItensSerie.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F11) Then
    btnNumeroSerie.Click

  Else If (Key = VK_F10) Then
    btnConfirmar.Click;
end;

end.

