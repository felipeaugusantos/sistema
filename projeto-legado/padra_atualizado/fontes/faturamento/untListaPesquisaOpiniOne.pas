unit untListaPesquisaOpiniOne;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass, System.UITypes,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, UniClientDataSet;

type
  TfrmListaPesquisaOpiniOne = class(TfrmPaiConfirma)
    cxgPesquisasTableView1: TcxGridDBTableViewCitel;
    cxgPesquisasLevel1: TcxGridLevel;
    cxgPesquisas: TcxGridCitel;
    MARDES: TcxGridDBColumn;
    CODIGO: TcxGridDBColumn;
    PESQUI: TcxGridDBColumn;
    DTAINI: TcxGridDBColumn;
    DTAFIN: TcxGridDBColumn;
    HASH__: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgPesquisasTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgPesquisasTableView1DblClick(Sender: TObject);
    procedure cxgPesquisasTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    cdsPesquisas: TUniClientDataSet;
    dtsPesquisa: TDataSource;

    procedure pCriaCds;
    procedure pCarregaListaDePesquisas;
    procedure pSeleciona;
  public
    { Public declarations }
    strHash: String;
  end;

implementation

{$R *.dfm}

uses untOpiniOneListagemDePesquisas, untGravando, untFuncoesSimples;

procedure TfrmListaPesquisaOpiniOne.btnConfirmaClick(Sender: TObject);
begin
  cdsPesquisas.Filtered := False;
  cdsPesquisas.Filter := 'MARDES = '+QuotedStr('M');
  cdsPesquisas.Filtered := True;

  strHash := cdsPesquisas.FieldByName('HASH__').AsString;

  inherited;
end;

procedure TfrmListaPesquisaOpiniOne.cxgPesquisasTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if not Assigned(cdsPesquisas) then
    Exit;

  if not cdsPesquisas.Active then
    Exit;

  inherited;

  if VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, MARDES.Index]) = 'M' then
  begin
    if ACanvas.Brush.Color = clHighlight then
      ACanvas.Font.Color := clLime
    else
    begin
      ACanvas.Brush.Color := clSkyBlue;
      ACanvas.Font.Color := clBlue;
    end;
  end;
end;

procedure TfrmListaPesquisaOpiniOne.cxgPesquisasTableView1DblClick(
  Sender: TObject);
begin
  inherited;
  pSeleciona;
end;

procedure TfrmListaPesquisaOpiniOne.cxgPesquisasTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN,
    VK_SPACE: pSeleciona;
  end;
end;

procedure TfrmListaPesquisaOpiniOne.FormCreate(Sender: TObject);
begin
  inherited;
  strHash := EmptyStr;

  pCriaCds;
end;

procedure TfrmListaPesquisaOpiniOne.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsPesquisas);
end;

procedure TfrmListaPesquisaOpiniOne.FormShow(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pCarregaListaDePesquisas, 'Aguarde, Carregando pesquisas...', '');
end;

procedure TfrmListaPesquisaOpiniOne.pCarregaListaDePesquisas;
var
  OpiniOneRetornoListagemDePesquisas: TOpiniOneRetornoListagemDePesquisas;
  Pesquisa: TPesquisasOpniOne;
begin;
  OpiniOneRetornoListagemDePesquisas := TControllerOpiniOneListagemDePesquisas.fListarPesquisasOpiniOne;
  try
    if not Assigned(OpiniOneRetornoListagemDePesquisas) then
      Exit;

    for Pesquisa in OpiniOneRetornoListagemDePesquisas.Pesquisas do
    begin
      cdsPesquisas.Append;
      cdsPesquisas.FieldByName('MARDES').AsString   := 'D';
      cdsPesquisas.FieldByName('CODIGO').AsExtended := Pesquisa.Codigo;
      cdsPesquisas.FieldByName('PESQUI').AsString   := Pesquisa.Titulo;
      cdsPesquisas.FieldByName('DTAINI').AsString   := Pesquisa.DataInicio;
      cdsPesquisas.FieldByName('DTAFIN').AsString   := Pesquisa.DataFim;
      cdsPesquisas.FieldByName('HASH__').AsString   := Pesquisa.Hash;
      cdsPesquisas.Post;
    end;
  finally
    if Assigned(OpiniOneRetornoListagemDePesquisas) then
      FreeAndNil(OpiniOneRetornoListagemDePesquisas);
  end;
end;

procedure TfrmListaPesquisaOpiniOne.pCriaCds;
begin
  cdsPesquisas := TUniClientDataSet.Create(Self);
  cdsPesquisas.FieldDefs.Add('MARDES', ftString, 1);
  cdsPesquisas.FieldDefs.Add('CODIGO', ftExtended);
  cdsPesquisas.FieldDefs.Add('PESQUI', ftString, 140);
  cdsPesquisas.FieldDefs.Add('DTAINI', ftString, 19);
  cdsPesquisas.FieldDefs.Add('DTAFIN', ftString, 19);
  cdsPesquisas.FieldDefs.Add('HASH__', ftString, 140);
  cdsPesquisas.CreateDataSet;

  dtsPesquisa := fCriaDataSource(cdsPesquisas);
  cxgPesquisasTableView1.DataController.DataSource := dtsPesquisa;
end;

procedure TfrmListaPesquisaOpiniOne.pSeleciona;
var
  intRecNoMarcar: Integer;
begin
  if not Assigned(cdsPesquisas) then
    Exit;

  if not cdsPesquisas.Active then
    Exit;

  if cdsPesquisas.IsEmpty then
    Exit;

  intRecNoMarcar := cdsPesquisas.RecNo;

  cdsPesquisas.DisableControls;
  cdsPesquisas.First;
  while not cdsPesquisas.Eof do
  begin
    cdsPesquisas.Edit;

    if cdsPesquisas.RecNo = intRecNoMarcar then
      cdsPesquisas.FieldByName('MARDES').AsString := IIF(cdsPesquisas.FieldByName('MARDES').AsString = 'D', 'M', 'D')
    else
      cdsPesquisas.FieldByName('MARDES').AsString := 'D';

    cdsPesquisas.Post;

    cdsPesquisas.Next;
  end;
  cdsPesquisas.EnableControls;
end;

end.
