unit untFatTravaProdPreco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Datasnap.DBClient, UniClientDataSet, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid,
  MemDS, DBAccess, Uni;

type
  TfrmFatTravaProdPreco = class(TfrmPaiSimples)
    pnlPrincipal: TPanel;
    cxgProdutosDBTableView: TcxGridDBTableViewCitel;
    cxgProdutosLevel: TcxGridLevel;
    cxgProdutos: TcxGridCitel;
    dtsProdutos: TDataSource;
    cdsProdutos: TUniClientDataSet;
    cdsProdutosCODITE: TStringField;
    cdsProdutosDESITE: TStringField;
    cdsProdutosPREORI: TFloatField;
    cdsProdutosDESCON: TFloatField;
    cdsProdutosPRENOV: TFloatField;
    cdsProdutosPRECUS: TFloatField;
    cdsProdutosMARLIQ: TFloatField;
    cdsProdutosPREPER: TFloatField;
    cdsProdutosPREAUT: TFloatField;
    cxgProdutosCODITE: TcxGridDBColumn;
    cxgProdutosDESITE: TcxGridDBColumn;
    cxgProdutosPREORI: TcxGridDBColumn;
    cxgProdutosDESCON: TcxGridDBColumn;
    cxgProdutosPRENOV: TcxGridDBColumn;
    cxgProdutosPRECUS: TcxGridDBColumn;
    cxgProdutosMARLIQ: TcxGridDBColumn;
    cxgProdutosPREPER: TcxGridDBColumn;
    cxgProdutosPREAUT: TcxGridDBColumn;
    pnlLegenda: TPanel;
    shpLegCampEdit: TShape;
    lblLegCampEdit: TLabel;
    btnConfirma: TBitBtnLocked;
    cdsProdutosAUTINC: TStringField;
    cdsProdutosSEQFDO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgProdutosDBTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    FNumLib: String;
    FApenaVisualizacao: Boolean;
    FConfirmou: Boolean;

    procedure pCriaDataSet;
    procedure pConfirmaNovoPreco;
    procedure pAjustaGrade;
    function fValidaPreçoAutorizado: Boolean;
  public
    { Public declarations }
    procedure pCarregaProdutosTrava;

    property NumLib: String Read FNumLib Write FNumLib;
    property ApenaVisualizacao: Boolean Read FApenaVisualizacao Write FApenaVisualizacao;
    property Confirmou: Boolean Read FConfirmou Write FConfirmou;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatTravaProdPreco.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  if not FApenaVisualizacao then
    pConfirmaNovoPreco;

  FConfirmou := True;

  Close;
end;

procedure TfrmFatTravaProdPreco.cxgProdutosDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If AViewInfo.Item.Options.Editing Then
  Begin
    ACanvas.Brush.Color := shpLegCampEdit.Brush.Color;
    ACanvas.Font.Color  := clBlack;
  End;
end;

procedure TfrmFatTravaProdPreco.FormCreate(Sender: TObject);
begin
  inherited;
  FNumLib := EmptyStr;
  FApenaVisualizacao := False;
  FConfirmou := False;
  pCriaDataSet;
end;

procedure TfrmFatTravaProdPreco.FormShow(Sender: TObject);
begin
  inherited;
  pAjustaGrade;
  pCarregaProdutosTrava;
end;

function TfrmFatTravaProdPreco.fValidaPreçoAutorizado: Boolean;
begin
  Result := False;

  if fEmptyStr(FNumLib) then
    Exit;

  if not Assigned(cdsProdutos) then
    Exit;

  if not cdsProdutos.Active then
    Exit;

  if cdsProdutos.RecordCount <= 0 then
    Exit;

  cdsProdutos.DisableControls;

  try
    cdsProdutos.First;

    while not cdsProdutos.Eof do
    begin
      if cdsProdutosPREAUT.AsFloat <= 0 then
      begin
        cdsProdutos.Edit;
        cdsProdutosPREAUT.AsFloat := cdsProdutosPREPER.AsFloat;
        cdsProdutos.Post;
      end;

      cdsProdutos.Next;
    end;

    cdsProdutos.First;
    Result := True;
  finally
    cdsProdutos.EnableControls;
  end;
end;

procedure TfrmFatTravaProdPreco.pAjustaGrade;
begin
  if not FApenaVisualizacao then
    Exit;

  pnlLegenda.Visible := False;
  cxgProdutosPREORI.Visible := False;
  cxgProdutosDESCON.Visible := False;
  cxgProdutosPRENOV.Visible := False;
  cxgProdutosPRECUS.Visible := False;
  cxgProdutosMARLIQ.Visible := False;
  cxgProdutosPREPER.Visible := False;
  cxgProdutosPREAUT.Options.Editing := False;
end;

procedure TfrmFatTravaProdPreco.pCarregaProdutosTrava;
var
  LQryProdutos: TUniQuery;
begin
  cdsProdutos.EmptyDataSet;

  if fEmptyStr(FNumLib) then
    Exit;

  LQryProdutos := fCriaQuery;
  cdsProdutos.DisableControls;

  try
    LQryProdutos.Close;
    LQryProdutos.SQL.Clear;
    LQryProdutos.SQL.Add('SELECT DET_CODITE, DET_DESITE, DET_PREORI, DET_DESCON, DET_PRENOV, DET_SEQFDO, ');
    LQryProdutos.SQL.Add('       DET_PRECUS, DET_MARLIQ, DET_PREPER, DET_PREAUT, TPMDET.AUTOINCREM');
    LQryProdutos.SQL.Add('FROM TPMDET');
    LQryProdutos.SQL.Add('INNER JOIN TPMGER');
    LQryProdutos.SQL.Add('ON(TPMDET.DET_SEQGER = TPMGER.AUTOINCREM)');
    LQryProdutos.SQL.Add('WHERE GER_NUMLIB = :NUMLIB');
    LQryProdutos.ParamByName('NUMLIB').AsString := FNumLib;
    LQryProdutos.Open;

    if LQryProdutos.IsEmpty then
      Exit;

    while not LQryProdutos.Eof do
    begin
      cdsProdutos.Append;
      cdsProdutosCODITE.AsString := LQryProdutos.FieldByName('DET_CODITE').AsString;
      cdsProdutosDESITE.AsString := LQryProdutos.FieldByName('DET_DESITE').AsString;
      cdsProdutosPREORI.AsFloat := LQryProdutos.FieldByName('DET_PREORI').AsFloat;
      cdsProdutosDESCON.AsFloat := LQryProdutos.FieldByName('DET_DESCON').AsFloat;
      cdsProdutosPRENOV.AsFloat := LQryProdutos.FieldByName('DET_PRENOV').AsFloat;
      cdsProdutosPRECUS.AsFloat := LQryProdutos.FieldByName('DET_PRECUS').AsFloat;
      cdsProdutosMARLIQ.AsFloat := LQryProdutos.FieldByName('DET_MARLIQ').AsFloat;
      cdsProdutosPREPER.AsFloat := LQryProdutos.FieldByName('DET_PREPER').AsFloat;
      cdsProdutosPREAUT.AsFloat := LQryProdutos.FieldByName('DET_PREAUT').AsFloat;
      cdsProdutosAUTINC.AsString := LQryProdutos.FieldByName('AUTOINCREM').AsString;
      cdsProdutosSEQFDO.AsString := LQryProdutos.FieldByName('DET_SEQFDO').AsString;
      cdsProdutos.Post;

      LQryProdutos.Next;
    end;

    cdsProdutos.First;
  finally
    FreeAndNil(LQryProdutos);
    cdsProdutos.EnableControls;
  end;
end;

procedure TfrmFatTravaProdPreco.pConfirmaNovoPreco;
var
  LQryConfirma: TUniQuery;
begin
  if fEmptyStr(FNumLib) then
    Exit;

  if not Assigned(cdsProdutos) then
    Exit;

  if not cdsProdutos.Active then
    Exit;

  if cdsProdutos.RecordCount <= 0 then
    Exit;

  if not fValidaPreçoAutorizado then
    Exit;

  LQryConfirma := fCriaQuery;
  cdsProdutos.DisableControls;

  try
    try
      LQryConfirma.Close;
      LQryConfirma.SQL.Clear;
      LQryConfirma.SQL.Add('UPDATE TPMGER');
      LQryConfirma.SQL.Add('SET GER_OPELIB = :OPELIB,');
      LQryConfirma.SQL.Add('    GER_DTALIB = :DTALIB,');
      LQryConfirma.SQL.Add('    GER_HORLIB = :HORLIB,');
      LQryConfirma.SQL.Add('    GER_RESPON = "S" ');
      LQryConfirma.SQL.Add('WHERE GER_NUMLIB = :NUMLIB');

      LQryConfirma.ParamByName('OPELIB').AsString := strLoginUsuarioLogado;
      LQryConfirma.ParamByName('DTALIB').AsDate := fRetDataServidor;
      LQryConfirma.ParamByName('HORLIB').AsTime := fRetHoraServidor;
      LQryConfirma.ParamByName('NUMLIB').AsString := FNumLib;

      LQryConfirma.ExecSQL;

      LQryConfirma.Close;
      LQryConfirma.SQL.Clear;
      LQryConfirma.SQL.Add('UPDATE TPMDET');
      LQryConfirma.SQL.Add('SET DET_PREAUT = :PREAUT,');
      LQryConfirma.SQL.Add('    DET_PROALT = :PROALT ');
      LQryConfirma.SQL.Add('WHERE AUTOINCREM = :AUTINC');

      cdsProdutos.First;

      while not cdsProdutos.Eof do
      begin
        LQryConfirma.Close;
        LQryConfirma.ParamByName('PREAUT').AsFloat := cdsProdutosPREAUT.AsFloat;
        LQryConfirma.ParamByName('PROALT').AsString := IIF(cdsProdutosPREPER.AsFloat = cdsProdutosPREAUT.AsFloat, 'N', 'S');
        LQryConfirma.ParamByName('AUTINC').AsString := cdsProdutosAUTINC.AsString;
        LQryConfirma.ExecSQL;

        cdsProdutos.Next;
      end;
    except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TfrmFatTravaProdPreco.pConfirmaNovoPreco');
      End;
    end
  finally
    FreeAndNil(LQryConfirma);
    cdsProdutos.EnableControls;
  end;
end;

procedure TfrmFatTravaProdPreco.pCriaDataSet;
begin
  cdsProdutos.CreateDataSet;

  (cdsProdutos.FieldByName('PREORI') As TFloatField).DisplayFormat := '#,##0.00';
  (cdsProdutos.FieldByName('DESCON') As TFloatField).DisplayFormat := '#,##0.00 %';
  (cdsProdutos.FieldByName('PRENOV') As TFloatField).DisplayFormat := '#,##0.00';
  (cdsProdutos.FieldByName('PRECUS') As TFloatField).DisplayFormat := '#,##0.00';
  (cdsProdutos.FieldByName('MARLIQ') As TFloatField).DisplayFormat := '#,##0.00';
  (cdsProdutos.FieldByName('PREPER') As TFloatField).DisplayFormat := '#,##0.00';
  (cdsProdutos.FieldByName('PREAUT') As TFloatField).DisplayFormat := '#,##0.00';
end;

end.
