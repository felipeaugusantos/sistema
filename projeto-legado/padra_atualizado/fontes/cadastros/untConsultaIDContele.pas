unit untConsultaIdContele;

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
  TInfoConsultar = (apiPortifolios, apiCategories);

  TfrmConsultaIDContele = class(TfrmPaiConfirma)
    cxgPesquisasTableView1: TcxGridDBTableViewCitel;
    cxgPesquisasLevel1: TcxGridLevel;
    cxgPesquisas: TcxGridCitel;
    MARDES: TcxGridDBColumn;
    DESCRI: TcxGridDBColumn;
    IDCONT: TcxGridDBColumn;
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
    cdsContele: TUniClientDataSet;
    dtsContele: TDataSource;

    procedure pCriaCds;
    procedure pCarregaDados;
    procedure pSeleciona;
    procedure pConsultarCategories;
    procedure pConsultarPortifolios;
  public
    { Public declarations }
    InfoConsultar: TInfoConsultar;
    strInfoRetornar: String;
  end;

implementation

{$R *.dfm}

uses untOpiniOneListagemDePesquisas, untGravando, untFuncoesSimples,
  untConteleCategoriesGet, untContelePortifoliosGet;

procedure TfrmConsultaIDContele.btnConfirmaClick(Sender: TObject);
begin
  cdsContele.Filtered := False;
  cdsContele.Filter := 'MARDES = '+QuotedStr('M');
  cdsContele.Filtered := True;

  strInfoRetornar := cdsContele.FieldByName('ID').AsString;

  inherited;
end;

procedure TfrmConsultaIDContele.cxgPesquisasTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if not Assigned(cdsContele) then
    Exit;

  if not cdsContele.Active then
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

procedure TfrmConsultaIDContele.cxgPesquisasTableView1DblClick(
  Sender: TObject);
begin
  inherited;
  pSeleciona;
end;

procedure TfrmConsultaIDContele.cxgPesquisasTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN,
    VK_SPACE: pSeleciona;
  end;
end;

procedure TfrmConsultaIDContele.FormCreate(Sender: TObject);
begin
  inherited;
  strInfoRetornar := EmptyStr;

  pCriaCds;
end;

procedure TfrmConsultaIDContele.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsContele);
end;

procedure TfrmConsultaIDContele.FormShow(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pCarregaDados, 'Aguarde, Carregando dados...', '');
end;

procedure TfrmConsultaIDContele.pCarregaDados;
begin;
  if InfoConsultar = apiPortifolios then
    pConsultarPortifolios
  else if InfoConsultar = apiCategories then
    pConsultarCategories;
end;

procedure TfrmConsultaIDContele.pConsultarPortifolios;
var
  Portifolios: TPortifolios;
  Portifolio: TPortifoliosClass;
begin
  Portifolios := TControlerContelePortifoliosGet.fPortifoliosGet;
  try
    if not Assigned(Portifolios) then
      Exit;

    for Portifolio in Portifolios.portifolios do
    begin
      cdsContele.Append;
      cdsContele.FieldByName('MARDES').AsString := 'D';
      cdsContele.FieldByName('DESCRICAO').AsString := Portifolio.name;
      cdsContele.FieldByName('ID').AsString := Portifolio.id;
      cdsContele.Post;
    end;
  finally
    if Assigned(Portifolios) then
      FreeAndNil(Portifolios);
  end;
end;

procedure TfrmConsultaIDContele.pConsultarCategories;
var
  Categories: TCategories;
  Categorie: TCategoriesClass;
begin
  Categories := TControlerConteleCategoriesGet.fCategoriesGet;
  try
    if not Assigned(Categories) then
      Exit;

    for Categorie in Categories.categories do
    begin
      cdsContele.Append;
      cdsContele.FieldByName('MARDES').AsString := 'D';
      cdsContele.FieldByName('DESCRICAO').AsString := Categorie.name;
      cdsContele.FieldByName('ID').AsString := Categorie.id;
      cdsContele.Post;
    end;
  finally
    if Assigned(Categories) then
      FreeAndNil(Categories);
  end;
end;

procedure TfrmConsultaIDContele.pCriaCds;
begin
  cdsContele := TUniClientDataSet.Create(Self);
  cdsContele.FieldDefs.Add('MARDES', ftString, 1);
  cdsContele.FieldDefs.Add('DESCRICAO', ftString, 140);
  cdsContele.FieldDefs.Add('ID', ftString, 140);
  cdsContele.CreateDataSet;

  dtsContele := fCriaDataSource(cdsContele);
  cxgPesquisasTableView1.DataController.DataSource := dtsContele;
end;

procedure TfrmConsultaIDContele.pSeleciona;
var
  intRecNoMarcar: Integer;
begin
  if not Assigned(cdsContele) then
    Exit;

  if not cdsContele.Active then
    Exit;

  if cdsContele.IsEmpty then
    Exit;

  intRecNoMarcar := cdsContele.RecNo;

  cdsContele.DisableControls;
  cdsContele.First;
  while not cdsContele.Eof do
  begin
    cdsContele.Edit;

    if cdsContele.RecNo = intRecNoMarcar then
      cdsContele.FieldByName('MARDES').AsString := IIF(cdsContele.FieldByName('MARDES').AsString = 'D', 'M', 'D')
    else
      cdsContele.FieldByName('MARDES').AsString := 'D';

    cdsContele.Post;

    cdsContele.Next;
  end;

  cdsContele.RecNo := intRecNoMarcar;

  cdsContele.EnableControls;
end;

end.
