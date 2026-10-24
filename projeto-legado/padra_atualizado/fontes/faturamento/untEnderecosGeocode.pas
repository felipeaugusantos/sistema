unit untEnderecosGeocode;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, LabeledEditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, untGoogleGeocoding, System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, UniClientDataSet,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, EditFocus;

type
  TfrmEnderecosGeocode = class(TfrmPaiConfirma)
    gpbEnderecos: TGroupBox;
    gpbCoordenadas: TGroupBox;
    pnlEndereco: TPanel;
    cxgEnderecosDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxgEnderecosLevel1: TcxGridLevel;
    cxgEnderecos: TcxGridCitel;
    cxgEnderecosENDERECO: TcxGridDBColumn;
    cxgEnderecosLATITUDE: TcxGridDBColumn;
    cxgEnderecosLONGITUDE: TcxGridDBColumn;
    cxgEnderecosMARDES: TcxGridDBColumn;
    Panel1: TPanel;
    Panel2: TPanel;
    edtLatitude: TEditFocus;
    edtLongitude: TEditFocus;
    lblLatitude: TLabel;
    lblLongitude: TLabel;
    rdgSelecionar: TRadioButton;
    rdgDefinir: TRadioButton;
    procedure cxgEnderecosDBTableViewCitel1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgEnderecosDBTableViewCitel1DblClick(Sender: TObject);
    procedure cxgEnderecosDBTableViewCitel1KeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rdgSelecionarClick(Sender: TObject);
    procedure rdgDefinirClick(Sender: TObject);
  private
    { Private declarations }
    dtsEnderecos: TDataSource;

    procedure pSeleciona;
  public
    { Public declarations }
    cdsEnderecos: TUniClientDataSet;
    GoogleGeocoding: TGoogleGeocoding;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untGoogleReverseGeocode, untGeocode;

procedure TfrmEnderecosGeocode.btnConfirmaClick(Sender: TObject);
var
  EnderecoCoordenadas: IEnderecosGeocode;
begin
  inherited;
  if rdgSelecionar.Checked then
  begin
    cdsEnderecos.Filtered := False;
    cdsEnderecos.Filter := 'MARDES = '+QuotedStr('M');
    cdsEnderecos.Filtered := True;

    if cdsEnderecos.IsEmpty then
    begin
      fMensagem('','Selecione ao menos um endereço!', ['&Ok']);
      ModalResult := mrNone;
    end;
  end
  else
  begin
    if (fEmptyStr(edtLatitude.Text)) or (fEmptyStr(edtLongitude.Text)) then
    begin
      fMensagem('','Preencha os campos Latitude e Longitude corretamente!', ['&Ok']);
      ModalResult := mrNone;
    end
    else
    begin
      EnderecoCoordenadas := TGoogleReverseGeocode.fProcessaReverseGeocode(edtLatitude.Text, edtLongitude.Text);
      if not Assigned(EnderecoCoordenadas) then
      begin
        fMensagem('','As coordenadas informadas não foram encontradas, por favor revise-as!', ['&Ok']);
        ModalResult := mrNone;
      end;
    end;
  end;
end;

procedure TfrmEnderecosGeocode.cxgEnderecosDBTableViewCitel1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if not Assigned(cdsEnderecos) then
    Exit;

  if not cdsEnderecos.Active then
    Exit;

  if VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgEnderecosMARDES.Index]) = 'M' then
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

procedure TfrmEnderecosGeocode.cxgEnderecosDBTableViewCitel1DblClick(
  Sender: TObject);
begin
  inherited;
  pSeleciona;
end;

procedure TfrmEnderecosGeocode.cxgEnderecosDBTableViewCitel1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN,
    VK_SPACE: pSeleciona;
  end;
end;

procedure TfrmEnderecosGeocode.FormCreate(Sender: TObject);
begin
  inherited;
  cdsEnderecos := TUniClientDataSet.Create(nil);
  cdsEnderecos.FieldDefs.Add('MARDES'   , ftString, 001);
  cdsEnderecos.FieldDefs.Add('ENDERECO' , ftString, 250);
  cdsEnderecos.FieldDefs.Add('LATITUDE' , ftExtended);
  cdsEnderecos.FieldDefs.Add('LONGITUDE', ftExtended);
  cdsEnderecos.CreateDataSet;

  dtsEnderecos := TDataSource.Create(cdsEnderecos);
  dtsEnderecos.DataSet := cdsEnderecos;

  cxgEnderecosDBTableViewCitel1.DataController.DataSource := dtsEnderecos;
end;

procedure TfrmEnderecosGeocode.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(dtsEnderecos);
  FreeAndNil(cdsEnderecos);
end;

procedure TfrmEnderecosGeocode.FormShow(Sender: TObject);
var
  Results: untGoogleGeocoding.TResultsClass;
begin
  inherited;

  for Results in GoogleGeocoding.Results do
  begin
    if not Assigned(Results.geometry.location) then
      Continue;

    if (Results.geometry.location.lat = 0) and (Results.geometry.location.lng = 0) then
      Continue;

    cdsEnderecos.Append;
    cdsEnderecos.FieldByName('MARDES').AsString := 'D';
    cdsEnderecos.FieldByName('ENDERECO').AsString := Results.formatted_address;
    cdsEnderecos.FieldByName('LATITUDE').AsExtended := Results.geometry.location.lat;
    cdsEnderecos.FieldByName('LONGITUDE').AsExtended := Results.geometry.location.lng;
    cdsEnderecos.Post;
  end;

end;

procedure TfrmEnderecosGeocode.pSeleciona;
var
  intRecNo: Integer;
begin
  if not Assigned(cdsEnderecos) then
    Exit;

  if not cdsEnderecos.Active then
    Exit;

  if cdsEnderecos.IsEmpty then
    Exit;

  intRecNo := cdsEnderecos.RecNo;

  cdsEnderecos.DisableControls;

  cdsEnderecos.First;
  while not cdsEnderecos.Eof do
  begin
    cdsEnderecos.Edit;
    cdsEnderecos.FieldByName('MARDES').AsString := 'D';
    cdsEnderecos.Post;

    cdsEnderecos.Next;
  end;

  cdsEnderecos.RecNo := intRecNo;

  cdsEnderecos.Edit;
  cdsEnderecos.FieldByName('MARDES').AsString := 'M';
  cdsEnderecos.Post;

  cdsEnderecos.EnableControls;
end;

procedure TfrmEnderecosGeocode.rdgDefinirClick(Sender: TObject);
begin
  inherited;
  gpbCoordenadas.Enabled := rdgDefinir.Checked;
  gpbEnderecos.Enabled := not rdgDefinir.Checked;
end;

procedure TfrmEnderecosGeocode.rdgSelecionarClick(Sender: TObject);
begin
  inherited;
  gpbEnderecos.Enabled := rdgSelecionar.Checked;
  gpbCoordenadas.Enabled := not rdgSelecionar.Checked;
end;

end.
