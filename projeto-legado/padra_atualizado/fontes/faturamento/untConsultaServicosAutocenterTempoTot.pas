unit untConsultaServicosAutocenterTempoTot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, Grids, DBGridCitel, DBGrids,
  Uni, UniClientDataSet, DB, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxTextEdit,
  cxClasses, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridCustomView, cxGridCitel, cxGrid, frxClass,
  System.UITypes;

type
  TfrmConsultaServicosAutocenterTempoTot = class(TfrmPai)
    pnlFundo: TPanel;
    dtsServ: TDataSource;
    cxgTipSerTableView: TcxGridDBTableViewCitel;
    cxgTipSerLevel: TcxGridLevel;
    cxgTipSer: TcxGridCitel;
    cxgTipSerTableViewTIPSER: TcxGridDBColumn;
    cxgTipSerTableViewQTDSER: TcxGridDBColumn;
    cxgTipSerTableViewTMPSER: TcxGridDBColumn;
    cxgTipSerTableViewTOTSER: TcxGridDBColumn;
    cxgTipSerTableViewDESSER: TcxGridDBColumn;
    cxStyleRepo: TcxStyleRepository;
    cxStyleBold: TcxStyle;
    btnExpand: TBitBtnLocked;
    btnCollapse: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExpandClick(Sender: TObject);
    procedure btnCollapseClick(Sender: TObject);
    procedure FooterItemGetText(Sender: TcxDataSummaryItem;
      const AValue: Variant; AIsFooter: Boolean; var AText: string);
    procedure cxgTipSerTableViewCustomDrawPartBackground(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxCustomGridCellViewInfo; var ADone: Boolean);
  private
    qryTipSer: TUniQuery;
    cdsTipoServ: TUniClientDataSet;
  public
    strStatusFinalizamServico: String;
    cdsServicos: TUniClientDataSet;
  end;

var
  frmConsultaServicosAutocenterTempoTot: TfrmConsultaServicosAutocenterTempoTot;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmConsultaServicosAutocenterTempoTot.btnCollapseClick(
  Sender: TObject);
begin
  inherited;
  cxgTipSerTableView.ViewData.Collapse(True);
end;

procedure TfrmConsultaServicosAutocenterTempoTot.btnExpandClick(
  Sender: TObject);
begin
  inherited;
  cxgTipSerTableView.ViewData.Expand(True);
end;

procedure TfrmConsultaServicosAutocenterTempoTot.cxgTipSerTableViewCustomDrawPartBackground(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxCustomGridCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If AViewInfo Is TcxGridFooterViewInfo Then
  Begin
    ACanvas.FillRect(AViewInfo.Bounds, ACanvas.Brush.Color);
    ACanvas.DrawText('TOTAL', AViewInfo.Bounds, TAlignment.taCenter, TcxAlignmentVert.vaCenter, False, False);
    ADone := True;
  End;
end;

procedure TfrmConsultaServicosAutocenterTempoTot.FooterItemGetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: string);
begin
  inherited;
  If AValue <> Null Then
    AText := FormatDateTime('hh:nn', AValue);
end;

procedure TfrmConsultaServicosAutocenterTempoTot.FormCreate(Sender: TObject);
begin
  inherited;
  cdsTipoServ := TUniClientDataSet.Create(Nil);
  cdsServicos := TUniClientDataSet.Create(Nil);

  cdsTipoServ.FieldDefs.Add('TIPSER', ftString, 100);
  cdsTipoServ.FieldDefs.Add('DESSER', ftString, 100);
  cdsTipoServ.FieldDefs.Add('CODSER', ftString, 5);
  cdsTipoServ.FieldDefs.Add('QTDSER', ftFloat);
  cdsTipoServ.FieldDefs.Add('TMPSER', ftTime);
  cdsTipoServ.FieldDefs.Add('TOTSER', ftTime);
  cdsTipoServ.CreateDataSet;

  TTimeField(cdsTipoServ.FieldByName('TMPSER')).DisplayFormat := 'hh:mm';
  TTimeField(cdsTipoServ.FieldByName('TOTSER')).DisplayFormat := 'hh:mm';

  qryTipSer := fCriaQuery;
  qryTipSer.SQL.Text := 'SELECT * FROM TIPSER';
  qryTipSer.Open;

  dtsServ.Dataset := cdsTipoServ;
end;

procedure TfrmConsultaServicosAutocenterTempoTot.FormDestroy(Sender: TObject);
Begin
  cdsServicos.Free;
  cdsTipoServ.Free;
  qryTipSer.Free;
  inherited;
end;

procedure TfrmConsultaServicosAutocenterTempoTot.FormShow(Sender: TObject);
begin
  inherited;
  cxgTipSerTableView.BeginUpdate;
  cdsServicos.First;

  While Not cdsServicos.Eof Do
  Begin
    If Pos(cdsServicos.FieldByName('STASER').AsString, strStatusFinalizamServico) > 0 Then
    Begin
      cdsServicos.Next;
      Continue;
    End;

    If cdsTipoServ.Locate('TIPSER;CODSER', VarArrayOf([cdsServicos.FieldByName('TIPSER').AsString,
                                                       cdsServicos.FieldByName('CODSER').AsString]), []) Then
      cdsTipoServ.Edit
    Else
      cdsTipoServ.Append;

    cdsTipoServ.FieldByName('TIPSER').AsString := cdsServicos.FieldByName('TIPSER').AsString;
    cdsTipoServ.FieldByName('CODSER').AsString := cdsServicos.FieldByName('CODSER').AsString;
    cdsTipoServ.FieldByName('DESSER').AsString := cdsServicos.FieldByName('DESSER').AsString;
    cdsTipoServ.FieldByName('TMPSER').AsFloat := cdsServicos.FieldByName('TMPSER').AsFloat;

    cdsTipoServ.FieldByName('QTDSER').AsFloat := cdsTipoServ.FieldByName('QTDSER').AsFloat + cdsServicos.FieldByName('QTDSER').AsFloat;
    cdsTipoServ.FieldByName('TOTSER').AsFloat := cdsTipoServ.FieldByName('QTDSER').AsFloat * cdsServicos.FieldByName('TMPSER').AsFloat;
    cdsTipoServ.Post;
    
    cdsServicos.Next;
  End;

  // Atualiza descrição do tipo de serviço
  cdsTipoServ.First;
  While Not cdsTipoServ.Eof Do
  Begin
    qryTipSer.Locate('TPS_CODIGO', cdsTipoServ.FieldByName('TIPSER').AsString, []);

    cdsTipoServ.Edit;
    cdsTipoServ.FieldByName('TIPSER').AsString := qryTipSer.FieldByName('TPS_DESCRI').AsString;
    cdsTipoServ.Post;

    cdsTipoServ.Next;
  End;

  cxgTipSerTableView.EndUpdate;
  btnExpand.Click;
end;

end.
