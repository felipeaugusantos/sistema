unit untNumeroSerieSaidaAjuste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Datasnap.DBClient,
  UniClientDataSet, untFatSeriesItem;

type
  TfrmNumeroSerieSaidaAjuste = class(TfrmPaiConfirma)
    cxgNumeroSerieDBTableViewCitel: TcxGridDBTableViewCitel;
    cxgNumeroSerieLevel: TcxGridLevel;
    cxgNumeroSerie: TcxGridCitel;
    btnNumeroSerie: TBitBtnLocked;
    cdsNumeroSerie: TUniClientDataSet;
    cdsNumeroSerieCODIGO: TStringField;
    cdsNumeroSerieDESCRI: TStringField;
    cdsNumeroSerieQTDITE: TFloatField;
    cdsNumeroSerieNUMSER: TStringField;
    dtsNumeroSerie: TDataSource;
    cxgNumeroSerieDBTableViewCitelColumn1: TcxGridDBColumn;
    cxgNumeroSerieDBTableViewCitelColumn2: TcxGridDBColumn;
    cxgNumeroSerieDBTableViewCitelColumn3: TcxGridDBColumn;
    cxgNumeroSerieDBTableViewCitelColumn4: TcxGridDBColumn;
    cdsNumeroSerieEMPITE: TStringField;
    cdsNumeroSerieAUTINC: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNumeroSerieClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FFatSerieItem: TFatSerieItem;
    function fValidaNumeroSerie: Boolean;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses untFatMultiSerie, untFuncoesSimples, untTNumeroSerie;


procedure TfrmNumeroSerieSaidaAjuste.btnConfirmaClick(Sender: TObject);
var
  LNumerosSerieItem: TArray<String>;
  LContador: Integer;
begin
  ModalResult := mrNone;

  if not fValidaNumeroSerie then
    Exit;

  cdsNumeroSerie.First;

  while not cdsNumeroSerie.Eof do
  begin
    LNumerosSerieItem := cdsNumeroSerieNUMSER.AsString.Split([';']);

    for LContador := 0 to length(LNumerosSerieItem) - 1 do
    begin
      if not TNumeroSerie.fAjustaEstoqueSaida(LNumerosSerieItem[LContador], cdsNumeroSerieCODIGO.AsString, cdsNumeroSerieEMPITE.AsString, cdsNumeroSerieAUTINC.AsString) then
      Begin
        Exit;
      End;
    end;

    cdsNumeroSerie.Next;
  end;

  ModalResult := mrOk;
end;

procedure TfrmNumeroSerieSaidaAjuste.btnNumeroSerieClick(Sender: TObject);
var
  LFatMultiSerie: TfrmFatMultiSerie;
  LSeries: String;
begin
  inherited;

  if cdsNumeroSerie.RecNo <= 0 then
    Exit;

  pCriarFormularios(TfrmFatMultiSerie, LFatMultiSerie);

  try
    LSeries := EmptyStr;

    FFatSerieItem.ChamouPeloAjusteEstoque := True;
    FFatSerieItem.AutoincItem := cdsNumeroSerieAUTINC.AsString;
    FFatSerieItem.pCarregaSeriesItem(cdsNumeroSerieCODIGO.AsString, cdsNumeroSerieEMPITE.AsString);

    FFatSerieItem.AutoincItem := cdsNumeroSerieAUTINC.AsString;
    FFatSerieItem.pFiltraDataSet;
    LFatMultiSerie.fltQtdItemPed := cdsNumeroSerieQTDITE.AsFloat;
    LFatMultiSerie.pAlimentaCdsSeries(FFatSerieItem.cdsFatSeries);
    LFatMultiSerie.ShowModal;

    If LFatMultiSerie.ModalResult <> mrOk Then
      Exit;

    LFatMultiSerie.cdsSeries.First;
    FFatSerieItem.pDeletaSerieDoItem;

    While Not LFatMultiSerie.cdsSeries.Eof Do
    Begin
      If (LFatMultiSerie.cdsSeriesQTDSER.AsFloat > 0) Then
      Begin
        FFatSerieItem.pInsereSerie(LFatMultiSerie.cdsSeriesNUMSER.AsString,
                                              LFatMultiSerie.cdsSeriesQTDSER.AsFloat);

        FFatSerieItem.pInsereSerieParaGravacao(LFatMultiSerie.cdsSeriesNUMSER.AsString,
                                                          LFatMultiSerie.cdsSeriesQTDSER.AsFloat);

        If fEmptyStr(LSeries) Then
          LSeries := LFatMultiSerie.cdsSeriesNUMSER.AsString
        Else
          LSeries := LSeries + ';' + LFatMultiSerie.cdsSeriesNUMSER.AsString;
      End;
      LFatMultiSerie.cdsSeries.Next;
    End;

    cdsNumeroSerie.Edit;
    cdsNumeroSerieNUMSER.AsString := LSeries;
    cdsNumeroSerie.Post;
  finally
    pFreeAndNil(LFatMultiSerie);
  end;
end;

procedure TfrmNumeroSerieSaidaAjuste.FormCreate(Sender: TObject);
begin
  inherited;

  cdsNumeroSerieCODIGO.Size := fTamCodIte;
  cdsNumeroSerie.CreateDataSet;
  FFatSerieItem := TFatSerieItem.Create(Self);

end;

procedure TfrmNumeroSerieSaidaAjuste.FormDestroy(Sender: TObject);
begin
  If Assigned(FFatSerieItem) Then
    FreeAndNil(FFatSerieItem);

  inherited;
end;

procedure TfrmNumeroSerieSaidaAjuste.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F11) Then
    btnNumeroSerie.Click;
end;

function TfrmNumeroSerieSaidaAjuste.fValidaNumeroSerie: Boolean;
var
  LNumerosSerieItem: TArray<String>;
begin
  Result := True;

  cdsNumeroSerie.First;

  while not cdsNumeroSerie.Eof do
  begin
    LNumerosSerieItem := cdsNumeroSerieNUMSER.AsString.Split([';']);

    if Length(LNumerosSerieItem) <> cdsNumeroSerieQTDITE.AsFloat then
    begin
      fMensagem('ATENÇÃO!', 'A quantidade de números de série informado está divergente da quantidade à ser devolvida para o produto '+cdsNumeroSerieCODIGO.AsString+' .', ['&Ok']);
      Result := False;
      Exit;
    end;

    cdsNumeroSerie.Next;
  end;
end;

end.
