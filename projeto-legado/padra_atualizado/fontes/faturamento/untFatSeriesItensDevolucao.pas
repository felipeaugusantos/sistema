unit untFatSeriesItensDevolucao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Datasnap.DBClient,
  UniClientDataSet, cxTextEdit, untFuncoesSimples;

type
  TfrmFatSeriesItensDevolucao = class(TfrmPaiSimples)
    btnConfirma: TBitBtnLocked;
    pnlFundo: TPanel;
    cxgSeriesDBTableViewCitel: TcxGridDBTableViewCitel;
    cxgSeriesLevel: TcxGridLevel;
    cxgSeries: TcxGridCitel;
    cdsSeries: TUniClientDataSet;
    cdsSeriesAUTINC: TStringField;
    cdsSeriesCODITE: TStringField;
    cdsSeriesDESITE: TStringField;
    cdsSeriesQTDITE: TFloatField;
    cdsSeriesNUMSER: TStringField;
    dtsSeries: TDataSource;
    cxgSeriesCODITE: TcxGridDBColumn;
    cxgSeriesDESITE: TcxGridDBColumn;
    cxgSeriesQTDITE: TcxGridDBColumn;
    cxgSeriesNUMSER: TcxGridDBColumn;
    pnlLegenda: TPanel;
    shpLegEdit: TShape;
    lblLegEdit: TLabel;
    lblInformacaoSerie: TLabel;
    cdsSeriesEMPDOC: TStringField;
    cdsSeriesEMPITE: TStringField;
    cdsSeriesTABDEV: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure cxgSeriesDBTableViewCitelCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    function fValidaNumerosSerie: Boolean;
  public
    FArrItensNumeroSerieDevolucao: TArrayItensNumeroSerieDevolucao;
    FAjusteEstoque: Boolean;
    { Public declarations }
  end;

implementation

uses System.UITypes;

{$R *.dfm}


procedure TfrmFatSeriesItensDevolucao.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  if fValidaNumerosSerie then
    ModalResult := mrOk;
end;

procedure TfrmFatSeriesItensDevolucao.cxgSeriesDBTableViewCitelCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;                         

  if AViewInfo.Item.Options.Editing then
  begin
    ACanvas.Brush.Color := shpLegEdit.Brush.Color;
    ACanvas.Font.Color  := clBlack;
  end;
end;

procedure TfrmFatSeriesItensDevolucao.FormCreate(Sender: TObject);
begin
  inherited;
  cdsSeries.CreateDataSet;
  TFloatField(cdsSeries.FieldByName('QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  FAjusteEstoque := False;
end;

function TfrmFatSeriesItensDevolucao.fValidaNumerosSerie: Boolean;
var
  LNumerosSerieItem: TArray<String>;
  LContador: Integer;
  LAutIncNumeroSerie: String;
  LListaNumerosSerie: TStringList;
begin
  Result := False;

  cdsSeries.DisableControls;
  LListaNumerosSerie := TStringList.Create;
  FillChar(FArrItensNumeroSerieDevolucao, SizeOf(FArrItensNumeroSerieDevolucao), #0);

  try
    cdsSeries.First;

    while not cdsSeries.Eof do
    begin
      LNumerosSerieItem := cdsSeriesNUMSER.AsString.Split([';']);

      if Length(LNumerosSerieItem) <> cdsSeriesQTDITE.AsFloat then
      begin
        fMensagem('ATENÇÃO!', 'A quantidade de números de série informado está divergente da quantidade à ser devolvida para o produto '+cdsSeriesCODITE.AsString+' .', ['&Ok']);
        Exit;
      end;

      for LContador := 0 to Length(LNumerosSerieItem) - 1 do
      begin
        if LListaNumerosSerie.IndexOf(LNumerosSerieItem[LContador]) > - 1 then
        begin  
          fMensagem('ATENÇÃO!', 'Número de série '+LNumerosSerieItem[LContador]+' já informado para o produto '+cdsSeriesCODITE.AsString+' .', ['&Ok']);
          Exit;
        end;

        if FAjusteEstoque then
        begin
          if fCampoTabela('COUNT(*)','PROSER',['SER_NUMSER'],[LNumerosSerieItem[LContador]]) > 0 then
          begin
            fMensagem('ATENÇÃO!', 'Número de série '+LNumerosSerieItem[LContador]+' já cadastrado na PROSER.', ['&Ok']);
            Exit;
          end;
        end
        else
        begin
          LAutIncNumeroSerie := fCampoTabela('AUTOINCREM','DETSER',['SER_SEQGER', 'SER_NUMSER'],[cdsSeriesAUTINC.AsString, LNumerosSerieItem[LContador]]);

          if fEmptyStr(LAutIncNumeroSerie) then
          begin
            LAutIncNumeroSerie := fCampoTabela('AUTOINCREM','DETSER',['SER_SEQNOT', 'SER_NUMSER'],[cdsSeriesAUTINC.AsString, LNumerosSerieItem[LContador]]);

            if fEmptyStr(LAutIncNumeroSerie) then
            begin
              fMensagem('ATENÇÃO!', 'Número de série '+LNumerosSerieItem[LContador]+' não encontrado no documento ou não pertence ao produto '+cdsSeriesCODITE.AsString+' .', ['&Ok']);
              Exit;
            end;
          end;
        end;

        SetLength(FArrItensNumeroSerieDevolucao, Length(FArrItensNumeroSerieDevolucao)+1);
        FArrItensNumeroSerieDevolucao[Length(FArrItensNumeroSerieDevolucao)-1].strNumeroSerie := LNumerosSerieItem[LContador];
        FArrItensNumeroSerieDevolucao[Length(FArrItensNumeroSerieDevolucao)-1].strAutIncDet := cdsSeriesAUTINC.AsString;
        FArrItensNumeroSerieDevolucao[Length(FArrItensNumeroSerieDevolucao)-1].strCodIte := cdsSeriesCODITE.AsString;
        FArrItensNumeroSerieDevolucao[Length(FArrItensNumeroSerieDevolucao)-1].strEmpIte := cdsSeriesEMPITE.AsString;
        FArrItensNumeroSerieDevolucao[Length(FArrItensNumeroSerieDevolucao)-1].strEmpDoc := cdsSeriesEMPDOC.AsString;
        FArrItensNumeroSerieDevolucao[Length(FArrItensNumeroSerieDevolucao)-1].strAutIncSer := IIF(FAjusteEstoque, EmptyStr, LAutIncNumeroSerie);
        FArrItensNumeroSerieDevolucao[Length(FArrItensNumeroSerieDevolucao)-1].strTabDev := cdsSeriesTABDEV.AsString;
        LListaNumerosSerie.Add(LNumerosSerieItem[LContador]);
      end;   
    
      cdsSeries.Next;
    end;

    Result := True;
  finally
    cdsSeries.EnableControls;
    FreeAndNil(LListaNumerosSerie);
  end;
end;

end.
