unit untResumoISS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, untTypesSistema, DateUtils,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Uni, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, EditFocus, Vcl.Mask,
  MaskEditFocus, System.ImageList, Vcl.ImgList, cxImageList, cxImageComboBox,
  cxLabel, cxTextEdit, cxCalendar, dxGDIPlusClasses;

type
  TfrmResumoISS = class(TfrmPai)
    pnlFiltros: TPanel;
    cxGridResumoView: TcxGridDBTableViewCitel;
    cxGridResumoLevel1: TcxGridLevel;
    cxGridResumo: TcxGridCitel;
    lblCodEmp: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    edtPerApu: TMaskEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    rdbIndividual: TRadioButton;
    rdbAgrupado: TRadioButton;
    btnPesquisar: TBitBtnLocked;
    cxGridAGRUPADOR: TcxGridDBColumn;
    cxGridCID_NOMCID: TcxGridDBColumn;
    cxGridCID_ESTADO: TcxGridDBColumn;
    cxGridBASISS: TcxGridDBColumn;
    cxGridFIS_ALQISS: TcxGridDBColumn;
    cxGridVALISS: TcxGridDBColumn;
    cxGridCTP_DTAVEN: TcxGridDBColumn;
    cxGridFOR_NOMFOR: TcxGridDBColumn;
    cxGridPOR_NOMPOR: TcxGridDBColumn;
    cxGridEVE_DESEVE: TcxGridDBColumn;
    cxGridCTA_DESCTA: TcxGridDBColumn;
    cxGridCTP_DTABAI: TcxGridDBColumn;
    cxGridCTP_VALPAG: TcxGridDBColumn;
    cxGridSTATUS: TcxGridDBColumn;
    cxGridCTP_CODFOR: TcxGridDBColumn;
    cxGridCTP_CODPOR: TcxGridDBColumn;
    cxGridCTP_CODCTA: TcxGridDBColumn;
    cxImageList: TcxImageList;
    cxGridCTP_CODEVE: TcxGridDBColumn;
    pnlSuperiorDireito: TPanel;
    imgSucesso: TImage;
    lblSucesso: TLabel;
    imgRetificar: TImage;
    lblRetificar: TLabel;
    imgErro: TImage;
    lblErro: TLabel;
    btnGerarCTP: TBitBtnLocked;
    btnVisualizarDocs: TBitBtnLocked;
    pnlInferior: TPanel;
    edtTotalBCISS: TEditFocus;
    edtTotalVALISS: TEditFocus;
    edtTotalVALPAG: TEditFocus;
    lblTotalBCISS: TLabel;
    lblTotalVALISS: TLabel;
    lblTotalVALPAG: TLabel;
    Shape1: TShape;
    Label3: TLabel;
    procedure btnPesquisarClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxGridCTP_CODFORPropertiesEditValueChanged(Sender: TObject);
    procedure cxGridCTP_CODPORPropertiesEditValueChanged(Sender: TObject);
    procedure cxGridCTP_CODCTAPropertiesEditValueChanged(Sender: TObject);
    procedure cxGridCTP_CODFORPropertiesChange(Sender: TObject);
    procedure cxGridCTP_CODPORPropertiesChange(Sender: TObject);
    procedure cxGridCTP_CODCTAPropertiesChange(Sender: TObject);
    procedure cxGridCTP_CODEVEPropertiesEditValueChanged(Sender: TObject);
    procedure cxGridCTP_CODEVEPropertiesChange(Sender: TObject);
    procedure cxGridResumoViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridCTP_DTAVENGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure btnGerarCTPClick(Sender: TObject);
    procedure rdbIndividualClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnVisualizarDocsClick(Sender: TObject);
    procedure cxGridCTP_DTAVENCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridCTP_CODFORCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridCTP_CODPORCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridCTP_CODEVECustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridCTP_CODCTACustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    cdsResumo: TUniClientDataSet;
    dtsResumo: TDataSource;

    arrEmpres: TConsultasArray;

    FstrLckChaace: String;

    procedure pCarregaResumo;
    procedure pConfiguraDts;
    procedure pAjustaDataVencimentoConformeSugestao;
    function fPreparaCdsResumoParaGerarCTP: Boolean;
    procedure pGerarCTPISS;
    procedure pMarcaISSGeradoNaCadFis(const strAutInc: String);
    procedure pGravarPreenchimentosParaSugestaoFutura;
    procedure pTotalizaGeral;
    procedure pDestravaLckAtc;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untFuncoesConsulta, untGravando,
  untCadPag, untDocsResumoISS, untCadCta;

{ TfrmResumoISS }

procedure TfrmResumoISS.cxGridCTP_CODCTACustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if AViewInfo.Item.Options.Editing then
  begin
    ACanvas.Font.Color := clBlack;
    ACanvas.Brush.Color := clYellow;
  end;
end;

procedure TfrmResumoISS.cxGridCTP_CODCTAPropertiesChange(Sender: TObject);
var
  edtCodigo: TCustomEdit;
  edtDescri: TEditFocus;
  arrSel: TConsultasArray;
  Key: Char;
begin
  inherited;

  if fEmptyStr(TcxTextEdit(Sender).Text) then
    Exit;

  Key := TcxTextEdit(Sender).Text[1];

  if not fEntraCons(Key) then
    Exit;

  cdsResumo.FieldByName('CTP_CODCTA').AsString := EmptyStr;

  edtCodigo := TCustomEdit.Create(Self);
  edtDescri := TEditFocus.Create(Self);
  try
    if fPesqCentroCusto(Self, edtCodigo, edtDescri, Nil, Key, arrSel) then
    begin
      cdsResumo.FieldByName('CTA_DESCTA').AsString := edtDescri.Text;
      cdsResumo.FieldByName('CTP_CODCTA').AsString := edtCodigo.Text;
    end;
  finally
    FreeAndNil(edtCodigo);
    FreeAndNil(edtDescri);
  end;
end;

procedure TfrmResumoISS.cxGridCTP_CODCTAPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;

  if fEmptyStr(TcxTextEdit(Sender).Text) then
  begin
    cdsResumo.FieldByName('CTA_DESCTA').AsString := EmptyStr;
    cdsResumo.FieldByName('CTP_CODCTA').AsString := EmptyStr;
    Exit;
  end;

  if not fValidaLinhaGrupoCadCta(fStrZero(TcxTextEdit(Sender).Text, 7)) then
  begin
    fMensagem('ATENÇÃO!', 'Linha / Grupo não é permitido!', ['&O k']);
    cdsResumo.FieldByName('CTA_DESCTA').AsString := EmptyStr;
    cdsResumo.FieldByName('CTP_CODCTA').AsString := EmptyStr;
    Exit;
  end;

  cdsResumo.FieldByName('CTP_CODCTA').AsString := fStrZero(TcxTextEdit(Sender).Text, 7);
  cdsResumo.FieldByName('CTA_DESCTA').AsString := fRetDescCentroCusto(cdsResumo.FieldByName('CTP_CODCTA').AsString);
  if fEmptyStr(cdsResumo.FieldByName('CTA_DESCTA').AsString) then
  begin
    fMensagem('Aviso', 'Plano de Contas não encontrado!', ['&O k']);
    cdsResumo.FieldByName('CTP_CODCTA').AsString := EmptyStr;
    cdsResumo.FieldByName('CTA_DESCTA').AsString := EmptyStr;
  end;
end;

procedure TfrmResumoISS.cxGridCTP_CODEVECustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if AViewInfo.Item.Options.Editing then
  begin
    ACanvas.Font.Color := clBlack;
    ACanvas.Brush.Color := clYellow;
  end;
end;

procedure TfrmResumoISS.cxGridCTP_CODEVEPropertiesChange(Sender: TObject);
var
  edtCodigo: TCustomEdit;
  edtDescri: TEditFocus;
  arrSel: TConsultasArray;
  Key: Char;
begin
  inherited;

  if fEmptyStr(TcxTextEdit(Sender).Text) then
    Exit;

  Key := TcxTextEdit(Sender).Text[1];

  if not fEntraCons(Key) then
    Exit;

  cdsResumo.FieldByName('CTP_CODEVE').AsString := EmptyStr;

  edtCodigo := TCustomEdit.Create(Self);
  edtDescri := TEditFocus.Create(Self);
  try
    If fPesqEventos(Self, edtCodigo, edtDescri, Nil, Key, arrSel) Then
    begin
      cdsResumo.FieldByName('EVE_DESEVE').AsString := edtDescri.Text;
      cdsResumo.FieldByName('CTP_CODEVE').AsString := edtCodigo.Text;
    end;
  finally
    FreeAndNil(edtCodigo);
    FreeAndNil(edtDescri);
  end;

end;

procedure TfrmResumoISS.cxGridCTP_CODEVEPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;

  if fEmptyStr(TcxTextEdit(Sender).Text) then
  begin
    cdsResumo.FieldByName('EVE_DESEVE').AsString := EmptyStr;
    cdsResumo.FieldByName('CTP_CODEVE').AsString := EmptyStr;
    Exit;
  end;

  cdsResumo.FieldByName('CTP_CODEVE').AsString := fStrZero(TcxTextEdit(Sender).Text, 5);
  cdsResumo.FieldByName('EVE_DESEVE').AsString := fRetNomEvento(cdsResumo.FieldByName('CTP_CODEVE').AsString);
  if fEmptyStr(cdsResumo.FieldByName('EVE_DESEVE').AsString) then
  begin
    fMensagem('Aviso', 'Evento não encontrado!', ['&O k']);
    cdsResumo.FieldByName('CTP_CODEVE').AsString := EmptyStr;
    cdsResumo.FieldByName('EVE_DESEVE').AsString := EmptyStr;
  end;
end;

procedure TfrmResumoISS.cxGridCTP_CODFORCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if AViewInfo.Item.Options.Editing then
  begin
    ACanvas.Font.Color := clBlack;
    ACanvas.Brush.Color := clYellow;
  end;
end;

procedure TfrmResumoISS.cxGridCTP_CODFORPropertiesChange(Sender: TObject);
var
  edtCodigo: TCustomEdit;
  edtDescri: TCustomEdit;
  arrSel: TConsultasArray;
  Key: Char;
begin
  inherited;

  if fEmptyStr(TcxTextEdit(Sender).Text) then
    Exit;

  Key := TcxTextEdit(Sender).Text[1];

  if not fEntraCons(Key) then
    Exit;

  cdsResumo.FieldByName('CTP_CODFOR').AsString := EmptyStr;

  edtCodigo := TCustomEdit.Create(Self);
  edtDescri := TCustomEdit.Create(Self);
  try
    if fPesqFornecedor(conForSimples, Self, edtCodigo, edtDescri, Nil, Key, arrSel) then
    begin
      cdsResumo.FieldByName('FOR_NOMFOR').AsString := edtDescri.Text;
      cdsResumo.FieldByName('CTP_CODFOR').AsString := edtCodigo.Text;
    end;
  finally
    FreeAndNil(edtCodigo);
    FreeAndNil(edtDescri);
  end;
end;

procedure TfrmResumoISS.cxGridCTP_CODFORPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;

  if fEmptyStr(TcxTextEdit(Sender).Text) then
  begin
    cdsResumo.FieldByName('FOR_NOMFOR').AsString := EmptyStr;
    cdsResumo.FieldByName('CTP_CODFOR').AsString := EmptyStr;
    Exit;
  end;

  cdsResumo.FieldByName('CTP_CODFOR').AsString := fStrZero(TcxTextEdit(Sender).Text, 8);
  cdsResumo.FieldByName('FOR_NOMFOR').AsString := fRetNomFornecedor(cdsResumo.FieldByName('CTP_CODFOR').AsString);
  if fEmptyStr(cdsResumo.FieldByName('FOR_NOMFOR').AsString) then
  begin
    fMensagem('Aviso', 'Fornecedor não encontrado!', ['&O k']);
    cdsResumo.FieldByName('CTP_CODFOR').AsString := EmptyStr;
    cdsResumo.FieldByName('FOR_NOMFOR').AsString := EmptyStr;
    Exit;
  end;

  if not fFornecedorAtivo(fStrZero(TcxTextEdit(Sender).Text, 8)) then
  begin
    fMensagem('ATENÇÃO!', 'Esse fornecedor está inativo!!', ['&O k']);
    cdsResumo.FieldByName('CTP_CODFOR').AsString := EmptyStr;
    cdsResumo.FieldByName('FOR_NOMFOR').AsString := EmptyStr;
  end;
end;

procedure TfrmResumoISS.cxGridCTP_CODPORCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if AViewInfo.Item.Options.Editing then
  begin
    ACanvas.Font.Color := clBlack;
    ACanvas.Brush.Color := clYellow;
  end;
end;

procedure TfrmResumoISS.cxGridCTP_CODPORPropertiesChange(Sender: TObject);
var
  edtCodigo: TCustomEdit;
  edtDescri: TEditFocus;
  arrSel: TConsultasArray;
  Key: Char;
begin
  inherited;

  if fEmptyStr(TcxTextEdit(Sender).Text) then
    Exit;

  Key := TcxTextEdit(Sender).Text[1];

  if not fEntraCons(Key) then
    Exit;

  cdsResumo.FieldByName('CTP_CODPOR').AsString := EmptyStr;

  edtCodigo := TCustomEdit.Create(Self);
  edtDescri := TEditFocus.Create(Self);
  try
    if fPesqPortador(conSimples, Self, edtCodigo, edtDescri, Nil, Key, arrSel) then
    begin
      cdsResumo.FieldByName('POR_NOMPOR').AsString := edtDescri.Text;
      cdsResumo.FieldByName('CTP_CODPOR').AsString := edtCodigo.Text;
    end;
  finally
    FreeAndNil(edtCodigo);
    FreeAndNil(edtDescri);
  end;
end;

procedure TfrmResumoISS.cxGridCTP_CODPORPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;

  if fEmptyStr(TcxTextEdit(Sender).Text) then
  begin
    cdsResumo.FieldByName('POR_NOMPOR').AsString := EmptyStr;
    cdsResumo.FieldByName('CTP_CODPOR').AsString := EmptyStr;
    Exit;
  end;

  cdsResumo.FieldByName('CTP_CODPOR').AsString := fStrZero(TcxTextEdit(Sender).Text, 5);
  cdsResumo.FieldByName('POR_NOMPOR').AsString := fRetNomPortador(cdsResumo.FieldByName('CTP_CODPOR').AsString);
  if fEmptyStr(cdsResumo.FieldByName('POR_NOMPOR').AsString) then
  begin
    fMensagem('Aviso', 'Portador não encontrado!', ['&O k']);
    cdsResumo.FieldByName('CTP_CODPOR').AsString := EmptyStr;
    cdsResumo.FieldByName('POR_NOMPOR').AsString := EmptyStr;
  end;
end;

procedure TfrmResumoISS.cxGridCTP_DTAVENCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if AViewInfo.Item.Options.Editing then
  begin
    ACanvas.Font.Color := clBlack;
    ACanvas.Brush.Color := clYellow;
  end;
end;

procedure TfrmResumoISS.cxGridCTP_DTAVENGetProperties(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
var
  DefaultProperties: TcxTextEditProperties;
begin
  inherited;

  if ARecord = nil then Exit;

  if (Pos(VarToStr(ARecord.Values[cxGridSTATUS.Index]), 'CTPG_CTPP_') > 0) or
     (VarToStr(ARecord.Values[cxGridSTATUS.Index]) = '') then
  begin
    DefaultProperties := TcxTextEditProperties.Create(Self);
    DefaultProperties.ReadOnly := True;
    AProperties := DefaultProperties;
  end;
end;

procedure TfrmResumoISS.cxGridResumoViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if not Assigned(cdsResumo) then
    Exit;

  if not cdsResumo.Active then
    Exit;

  if VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridSTATUS.Index]) = '' then
  begin
    ACanvas.Brush.Color := clBtnFace;
    ACanvas.Font.Style := [fsBold];
    ACanvas.Font.Color := clBlack;
  end;
end;

procedure TfrmResumoISS.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmpres, fRetNomeEmpresa, nil, 'da Empresa');
end;

procedure TfrmResumoISS.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpres, False) Then
    Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmResumoISS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  pDestravaLckAtc;
end;

procedure TfrmResumoISS.FormCreate(Sender: TObject);
begin
  inherited;
  FstrLckChaace := EmptyStr;
end;

procedure TfrmResumoISS.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(dtsResumo) then
    FreeAndNil(dtsResumo);

  if Assigned(cdsResumo) then
    FreeAndNil(cdsResumo);
end;

procedure TfrmResumoISS.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F9: btnGerarCTP.Click;
    VK_F2: btnVisualizarDocs.Click;
  end;
end;

function TfrmResumoISS.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If Sender = edtPerApu Then
    Begin
      if edtPerApu.Text = '  /    ' then
      begin
        fMensagem('ATENÇÃO', 'Informe o período de apuração', ['&Ok']);
        Result := False;
      end
      else if (StrToInt(Copy(edtPerApu.Text, 0, 2)) < 1) or (StrToInt(Copy(edtPerApu.Text, 0, 2)) > 12) then
      begin
        fMensagem('ATENÇÃO', 'Período de apuração inválido', ['&Ok']);
        Result := False;
      end
      else if (Length(Trim(edtPerApu.Text)) < 5) or (Length(Trim(edtPerApu.Text)) = 6) then
      begin
        fMensagem('ATENÇÃO', 'Período de apuração inválido!', ['&Ok']);
        Result := False;
      end
      else if Length(Trim(edtPerApu.Text)) = 5 then
      begin
        edtPerApu.Text := Copy(edtPerApu.Text, 1, 3) + Copy(FormatDateTime('yyyy', Date), 1, 2) + Copy(edtPerApu.Text, 4, 2);
        Result := fValidaCampos(edtPerApu, False);
      end;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmResumoISS.fPreparaCdsResumoParaGerarCTP: Boolean;
begin
  Result := False;
  try
    cdsResumo.Filtered := False;
    cdsResumo.Filter := ' STATUS = '+QuotedStr('CTPNG')+
                        ' AND (CTP_DTAVEN IS NULL '+
                        ' OR   CTP_CODFOR = '+QuotedStr('')+
                        ' OR   CTP_CODPOR = '+QuotedStr('')+
                        ' OR   CTP_CODEVE = '+QuotedStr('')+
                        ' OR   CTP_CODCTA = '+QuotedStr('')+')';
    cdsResumo.Filtered := True;

    Result := cdsResumo.IsEmpty;

    if Result then
    begin
      cdsResumo.Filtered := False;
      cdsResumo.Filter := ' STATUS = '+QuotedStr('CTPNG');
      cdsResumo.Filtered := True;

      Result := not cdsResumo.IsEmpty;
      if not Result then
      begin
        fMensagem('Aviso', 'Não existem Contas a Pagar a serem geradas!', ['&O k']);
        Exit;
      end;

      Result := fPergunta('Será gerado Contas a Pagar do ISS para todas as Prefeituras ainda não geradas.'+sLineBreak+
                          'Confirma a operação?');
    end
    else
      fMensagem('Aviso', 'Para geração do Contas a Pagar do ISS para os registros de status CTP NÃO GERADO, '+
                         'é necessário preencher os campos Vencimento/Fornecedor/Portador/Evento/Plano de Contas!', ['&O k']);

  finally
    if not Result then
      cdsResumo.Filtered := False;
  end;
end;

procedure TfrmResumoISS.btnPesquisarClick(Sender: TObject);
begin
  inherited;

  if not fVerificaCampos then
    Exit;

  if FstrLckChaace <> 'RESUMOISS_'+fTiraCaracEspeciais(edtPerApu.Text) then
  begin
    FstrLckChaace := 'RESUMOISS_'+fTiraCaracEspeciais(edtPerApu.Text);
    If (Not fLock_Unlock(FstrLckChaace, True, False)) Then
    Begin
      FstrLckChaace := EmptyStr;
      fMensagem('', 'O período informado está sendo utilizado por outra estação!', ['&Ok']);
      Exit;
    End;
  end;

  TfrmGravando.fExecutarModal(pCarregaResumo, 'Carregando dados...', '');
end;

procedure TfrmResumoISS.btnVisualizarDocsClick(Sender: TObject);
var
  frmDocsResumoISS: TfrmDocsResumoISS;
begin
  inherited;
  if not Assigned(cdsResumo) then
    Exit;

  if cdsResumo.IsEmpty then
    Exit;

  if fEmptyStr(cdsResumo.FieldByName('AUTINC_AGRUPADO_CADFIS').AsString) then
  begin
    fMensagem('Aviso', 'Selecione uma cidade para visualizar os documentos!', ['&O k']);
    Exit;
  end;

  pCriarFormularios(TfrmDocsResumoISS, frmDocsResumoISS);
  Try
    frmDocsResumoISS.strAutIncDocs := cdsResumo.FieldByName('AUTINC_AGRUPADO_CADFIS').AsString;
    frmDocsResumoISS.lblInfoEmpRaiz.Caption := cdsResumo.FieldByName('AGRUPADOR').AsString;
    frmDocsResumoISS.lblInfoCidade.Caption := cdsResumo.FieldByName('CID_NOMCID').AsString + '-' + cdsResumo.FieldByName('CID_ESTADO').AsString;
    frmDocsResumoISS.ShowModal;
  Finally
    pFreeAndNil(frmDocsResumoISS);
  End
end;

procedure TfrmResumoISS.pCarregaResumo;
var
  qryResumo: TUniQuery;
  LstrAgrupamento: String;
  LstrOrderBy: String;
  LstrCodEmp: String;
  intCount: Integer;
begin
  LstrAgrupamento := IIF(rdbIndividual.Checked, ' CONCAT(EMP_CODEMP, " - ", EMP_NOMEMP) ', ' SUBSTRING(EMP_C_G_C_, 1, 8) ') + ' AS AGRUPADOR, ';
  LstrOrderBy := IIF(rdbIndividual.Checked, ' EMP_CODEMP ', ' SUBSTRING(EMP_C_G_C_, 1, 8) ');
  cxGridAGRUPADOR.Caption := IIF(rdbIndividual.Checked, 'Empresa', 'CNPJ Raiz');

  LstrCodEmp := EmptyStr;
  for intCount := 0 to High(arrEmpres) do
    LstrCodEmp := LstrCodEmp + IIF(not fEmptyStr(LstrCodEmp), ',', '') + QuotedStr(arrEmpres[intCount].strCodigo);

  qryResumo := fCriaQuery(Self);
  try
    qryResumo.Close;
    qryResumo.SQL.Text :=
    ' SELECT '+
    '   AGRUPADOR,  '+
    '   EMP_CODEMP, '+
    '   EMP_C_G_C_, '+
    '   EMP_CODCID, '+
    '   CID_NOMCID, '+
    '   CID_ESTADO, '+
    '   COALESCE(BASISS, 0) AS BASISS, '+
    '   COALESCE(FIS_ALQISS, 0) AS FIS_ALQISS, '+
    '   FIS_SQDISS, '+
    '   COALESCE(VALISS, 0) AS VALISS, '+
    '   CAST(CTP_DTAVEN AS DATE) AS CTP_DTAVEN, '+
    '   CTP_CODFOR, '+
    '   FOR_NOMFOR, '+
    '   CTP_CODPOR, '+
    '   POR_NOMPOR, '+
    '   CTP_CODEVE, '+
    '   EVE_DESEVE, '+
    '   CTP_CODCTA, '+
    '   CTA_DESCTA, '+
    '   CTP_DTABAI, '+
    '   COALESCE(CTP_VALPAG, 0) AS CTP_VALPAG, '+
    '   STATUS, '+
    '   AUTINC_AGRUPADO_CADFIS, '+
    '   RES_DTAVEN, '+
    '   ORDEM '+
    ' FROM ( '+
    '   SELECT '+
          LstrAgrupamento+
    '     EMP_CODEMP, '+
    '     EMP_C_G_C_, '+
    '     EMP_CODCID, '+
    '     CID_NOMCID, '+
    '     CID_ESTADO, '+
    '     SUM(FIS_BASISS) AS BASISS, '+
    '     FIS_ALQISS, '+
    '     FIS_SQDISS, '+
    '     SUM(FIS_VALISS) AS VALISS, '+
    '     CTP_DTAVEN, '+
    '     COALESCE(CTP_CODFOR, RES_CODFOR) AS CTP_CODFOR, '+
    '     COALESCE(FOR_NOMFOR, RES_NOMFOR) AS FOR_NOMFOR, '+
    '     COALESCE(CTP_CODPOR, RES_CODPOR) AS CTP_CODPOR, '+
    '     COALESCE(POR_NOMPOR, RES_NOMPOR) AS POR_NOMPOR, '+
    '     COALESCE(CTP_CODEVE, RES_CODEVE) AS CTP_CODEVE, '+
    '     COALESCE(EVE_DESEVE, RES_DESEVE) AS EVE_DESEVE, '+
    '     COALESCE(CTP_CODCTA, RES_CODCTA) AS CTP_CODCTA, '+
    '     COALESCE(CTA_DESCTA, RES_DESCTA) AS CTA_DESCTA, '+
    '     CTP_DTABAI, '+
    '     CTP_VALPAG, '+
    '     IF( '+
    '       IFNULL(CADPAG.AUTOINCREM, "") = "", '+
    '       "CTPNG", '+
    '       IF(CTP_DTABAI IS NULL, "CTPG", "CTPP") '+
    '     ) AS STATUS, '+
    '     GROUP_CONCAT(CONCAT(''"'',CADFIS.AUTOINCREM, ''"'')) AS AUTINC_AGRUPADO_CADFIS, '+
    '     RES_DTAVEN, '+
    '     1 AS ORDEM '+
    '   FROM '+
    '     CADEMP '+
    '     INNER JOIN CADFIS '+
    '       ON EMP_CODEMP = FIS_CODEMP '+
    '     INNER JOIN CADCID '+
    '       ON CID_CODCID = EMP_CODCID '+
    '     LEFT JOIN CADPAG '+
    '       ON FIS_SQDISS = CADPAG.AUTOINCREM '+
    '     LEFT JOIN CADFOR '+
    '       ON CTP_CODFOR = FOR_CODFOR '+
    '     LEFT JOIN CADPOR '+
    '       ON CTP_CODPOR = POR_CODPOR '+
    '     LEFT JOIN CADEVE '+
    '       ON CTP_CODEVE = EVE_CODEVE '+
    '     LEFT JOIN CADCTA '+
    '       ON CTP_CODCTA = CTA_CODCTA '+
    '     LEFT JOIN RESISS '+
    '       ON  EMP_CODCID = RES_CODCID '+
    '       AND '+IIF(rdbIndividual.Checked, ' EMP_CODEMP = ', ' SUBSTRING(EMP_C_G_C_, 1, 8) = ')+' RES_IDESUJ '+
    '   WHERE FIS_ESPDOC = "NS" '+
    '     AND FIS_CLFSC1 IN ("5933", "6933") '+
    '     AND FIS_TIP_FC = "C" '+
    '     AND FIS_ORIDOC = "V" '+
    IIF(not fEmptyStr(LstrCodEmp),
        ' AND EMP_CODEMP IN ('+LstrCodEmp+') ',
        '')+
    '     AND LOCATE("CANCEL", FIS_HISTOR) <= 0 '+
    '     AND FIS_VALISS > 0 '+
    '     AND DATE_FORMAT(FIS_DTAENT, "%Y%m") = DATE_FORMAT(:PERAPU, "%Y%m") '+
    '   GROUP BY AGRUPADOR, '+
    '     CID_NOMCID, '+
    '     CID_ESTADO, '+
    '     FIS_ALQISS, '+
    '     FIS_SQDISS  '+

    '   UNION '+

    '   SELECT '+
          LstrAgrupamento+
    '     EMP_CODEMP, '+
    '     EMP_C_G_C_, '+
    '     "" AS EMP_CODCID, '+
    '     "Total" AS CID_NOMCID, '+
    '     "" AS CID_ESTADO, '+
    '     SUM(FIS_BASISS) AS BASISS, '+
    '     0.00 AS FIS_ALQISS, '+
    '     "" AS FIS_SQDISS, '+
    '     SUM(FIS_VALISS) AS VALISS, '+
    '     "" AS CTP_DTAVEN, '+
    '     "" AS CTP_CODFOR, '+
    '     "" AS FOR_NOMFOR, '+
    '     "" AS CTP_CODPOR, '+
    '     "" AS POR_NOMPOR, '+
    '     "" AS CTP_CODEVE, '+
    '     "" AS EVE_DESEVE, '+
    '     "" AS CTP_CODCTA, '+
    '     "" AS CTA_DESCTA, '+
    '     "" AS CTP_DTABAI, '+
    '     SUM(CTP_VALPAG) AS CTP_VALPAG, '+
    '     "" AS STATUS, '+
    '     "" AS AUTINC_AGRUPADO_CADFIS, '+
    '     "" AS RES_DTAVEN, '+
    '     2 AS ORDEM '+
    '   FROM '+
    '     CADEMP '+
    '     INNER JOIN CADFIS '+
    '       ON EMP_CODEMP = FIS_CODEMP '+
    '     LEFT JOIN CADPAG '+
    '       ON FIS_SQDISS = CADPAG.AUTOINCREM '+
    '   WHERE FIS_ESPDOC = "NS" '+
    '     AND FIS_CLFSC1 IN ("5933", "6933") '+
    '     AND FIS_TIP_FC = "C" '+
    '     AND FIS_ORIDOC = "V" '+
    IIF(not fEmptyStr(LstrCodEmp),
        ' AND EMP_CODEMP IN ('+LstrCodEmp+') ',
        '')+
    '     AND LOCATE("CANCEL", FIS_HISTOR) <= 0 '+
    '     AND FIS_VALISS > 0 '+
    '     AND DATE_FORMAT(FIS_DTAENT, "%Y%m") = DATE_FORMAT(:PERAPU, "%Y%m") '+
    '   GROUP BY AGRUPADOR) RESUMO '+

    ' ORDER BY '+
    '   ORDEM, '+
    LstrOrderBy+', '+
    '   CID_NOMCID, '+
    '   FIS_SQDISS ';

    qryResumo.ParamByName('PERAPU').AsString := FormatDateTime('yyyy-mm-dd', StrToDate('01/'+edtPerApu.Text));
    qryResumo.Open;

    if Assigned(dtsResumo) then
      FreeAndNil(dtsResumo);

    if Assigned(cdsResumo) then
      FreeAndNil(cdsResumo);

    cdsResumo := fCriaClientDatset(qryResumo);
    dtsResumo := fCriaDataSource(cdsResumo);
    pTotalizaGeral;
    pConfiguraDts;
    pAjustaDataVencimentoConformeSugestao;

    cxGridResumoView.ViewData.Expand(True);
  finally
    FreeAndNil(qryResumo);
  end;
end;

procedure TfrmResumoISS.pConfiguraDts;
begin
  TFloatField(cdsResumo.FieldByName('BASISS')).DisplayFormat := '#,##0.00';
  TFloatField(cdsResumo.FieldByName('FIS_ALQISS')).DisplayFormat := '#,##0.00';
  TFloatField(cdsResumo.FieldByName('VALISS')).DisplayFormat := '#,##0.00';
  TFloatField(cdsResumo.FieldByName('BASISS')).DisplayFormat := '#,##0.00';
  TFloatField(cdsResumo.FieldByName('CTP_VALPAG')).DisplayFormat := '#,##0.00';

  pSetaClient(cdsResumo);
  cxGridResumoView.DataController.DataSource := dtsResumo;
end;

procedure TfrmResumoISS.pDestravaLckAtc;
begin
  if not fEmptyStr(FstrLckChaace) then
  begin
    pDestravaLockForcado(FstrLckChaace, 0);
    FstrLckChaace := EmptyStr;
  end;
end;

procedure TfrmResumoISS.btnGerarCTPClick(Sender: TObject);
begin
  inherited;

  if not Assigned(cdsResumo) then
    Exit;

  if cdsResumo.IsEmpty then
    Exit;

  cdsResumo.DisableControls;
  try
    if not fPreparaCdsResumoParaGerarCTP then
      Exit;

    TfrmGravando.fExecutarModal(pGerarCTPISS, 'Gerando Contas a Pagar...', '');

    cdsResumo.Filtered := False;

    TfrmGravando.fExecutarModal(pCarregaResumo, 'Carregando dados...', '');
  finally
    cdsResumo.EnableControls;
  end;
end;

procedure TfrmResumoISS.pGerarCTPISS;
var
  strAutInc: String;
  strHist: String;
begin
  cdsResumo.First;
  try
    while not cdsResumo.Eof do
    begin
      if cdsResumo.FieldByName('VALISS').AsFloat = 0.00 then
      begin
        cdsResumo.Next;
        Continue;
      end;

      strAutInc := fRetAutoIncrem('CADPAG', IIF(rdbIndividual.Checked, cdsResumo.FieldByName('EMP_CODEMP').AsString, VS_strCodEmp));

      strHist := 'Ref. Apuração ISS ' + edtPerApu.Text + sLineBreak +
                 'Emp: ' + IIF(rdbIndividual.Checked, cdsResumo.FieldByName('EMP_CODEMP').AsString, VS_strCodEmp) + sLineBreak +
                 'Cidade: ' + cdsResumo.FieldByName('CID_NOMCID').AsString + '-' + cdsResumo.FieldByName('CID_ESTADO').AsString;

      fStartTransaction;

      fGravaCadPag('frmResumoISS',                                                                                                  // Nome Form LOGCTP
                   'GERAÇÃO RESUMO ISS',                                                                                            // Descrição LOGCTP
                   cdsResumo.FieldByName('CTP_CODFOR').AsString,                                                                    // Fornecedor
                   fRetSequencialCadPag(1, IIF(rdbIndividual.Checked, cdsResumo.FieldByName('EMP_CODEMP').AsString, VS_strCodEmp)), // Número da duplicata
                   'A',                                                                                                             // Parcela
                   IIF(rdbIndividual.Checked, cdsResumo.FieldByName('EMP_CODEMP').AsString, VS_strCodEmp),                          // Empresa
                   cdsResumo.FieldByName('CTP_CODCTA').AsString,                                                                    // Plano de contas
                   'ISS',                                                                                                           // Serie do Documento
                   0,                                                                                                               // Sequencial de Baixa
                   fNow,                                                                                                            // Data do lançamento
                   StrToDate(cdsResumo.FieldByName('CTP_DTAVEN').AsString),                                                         // Data de Vencimento
                   cdsResumo.FieldByName('VALISS').AsFloat,                                                                         // Valor da Duplicata
                   cdsResumo.FieldByName('VALISS').AsFloat,                                                                         // Valor Original
                   'N',                                                                                                             // Previsão?
                   'N',                                                                                                             // Veio Boleto
                   'N',                                                                                                             // Deposito
                   strHist,                                                                                                         // Histórico 1
                   '',                                                                                                              // Histórico 2
                   '',                                                                                                              // Histórico da Baixa
                   '',                                                                                                              // Portador da Baixa
                   '',                                                                                                              // Centro de Custo da Baixa
                   '',                                                                                                              // Documento da Baixa
                   '',                                                                                                              // Operador da Baixa
                   0,                                                                                                               // Data do Pagamento
                   0,                                                                                                               // Valor Pago
                   0,                                                                                                               // Valor de Juros
                   0,                                                                                                               // Valor Desconto
                   '',                                                                                                              // Empresa
                   cdsResumo.FieldByName('CTP_CODEVE').AsString,                                                                    // Codigo do Evento
                   'N',                                                                                                             // Usa Cheque
                   cdsResumo.FieldByName('CTP_CODPOR').AsString,                                                                    // Codigo do Portador
                   '',                                                                                                              // Número do documento
                   0,
                   0,
                   0,
                   False,
                   0,
                   '2',                                                                                                             //Tipo Documento
                   0,
                   'N',                                                                                                             //Veio NF
                   '',
                   '',
                   '',
                   strAutInc,                                                                                                       //Autoincrem
                   '',
                   '',
                   '',
                   '',
                   'N',
                   edtPerApu.Text,
                   '',
                   '',
                   '',
                   '',
                   0,
                   0,
                   0,
                   0,
                   '',
                   0,
                   0,
                   '',
                   '',
                   '',
                   '',
                   '',
                   '0',
                   '',
                   '',
                   '',
                   '',
                   'N');

      pMarcaISSGeradoNaCadFis(strAutInc);

      fCommit;

      cdsResumo.Next;
    end;

    pGravarPreenchimentosParaSugestaoFutura;
  except
    on E: Exception do
    begin
      if fInTransaction then
        fRollBack;

      pMensagensErro(E.Message, '[frmResumoISS.pGerarCTPISS]');
    end;
  end;
end;

procedure TfrmResumoISS.pMarcaISSGeradoNaCadFis(const strAutInc: String);
var
  qryCadFis: TUniQuery;
begin
  qryCadFis := fCriaQuery(Self);
  try
    qryCadFis.Close;
    qryCadFis.SQL.Text :=
    ' UPDATE '+
    '   CADFIS '+
    ' SET '+
    '   FIS_SQDISS = :SQDISS '+
    ' WHERE '+
    '   AUTOINCREM IN ('+cdsResumo.FieldByName('AUTINC_AGRUPADO_CADFIS').AsString+') ';

    qryCadFis.ParamByName('SQDISS').AsString := strAutInc;
    qryCadFis.ExecSQL;
  finally
    FreeAndNil(qryCadFis);
  end;
end;

procedure TfrmResumoISS.pTotalizaGeral;
var
  curTotalBC: Currency;
  curTotalVALISS: Currency;
  curTotalVALPAG: Currency;
begin
  curTotalBC := 0;
  curTotalVALISS := 0;
  curTotalVALPAG := 0;

  cdsResumo.DisableControls;
  try
    cdsResumo.First;
    while not cdsResumo.Eof do
    begin
      if fEmptyStr(cdsResumo.FieldByName('STATUS').AsString) then
      begin
        cdsResumo.Next;
        Continue;
      end;

      curTotalBC := curTotalBC + cdsResumo.FieldByName('BASISS').AsCurrency;
      curTotalVALISS := curTotalVALISS + cdsResumo.FieldByName('VALISS').AsCurrency;
      curTotalVALPAG := curTotalVALPAG + cdsResumo.FieldByName('CTP_VALPAG').AsCurrency;
      cdsResumo.Next;
    end;

    edtTotalBCISS.Text := Format('%m', [curTotalBC]);
    edtTotalVALISS.Text := Format('%m', [curTotalVALISS]);
    edtTotalVALPAG.Text := Format('%m', [curTotalVALPAG]);
  finally
    cdsResumo.First;
    cdsResumo.EnableControls;
  end;
end;

procedure TfrmResumoISS.pGravarPreenchimentosParaSugestaoFutura;
const
  SQL_SELECT_RESISS =
    ' SELECT '+
    '   AUTOINCREM '+
    ' FROM '+
    '   RESISS '+
    ' WHERE '+
    '   RES_IDESUJ = :IDESUJ AND '+
    '   RES_CODCID = :CODCID ';

  SQL_INSERT_RESISS =
    ' INSERT INTO RESISS '+
    '   (AUTOINCREM, '+
    '    RES_CODFOR, '+
    '    RES_NOMFOR, '+
    '    RES_CODPOR, '+
    '    RES_NOMPOR, '+
    '    RES_CODEVE, '+
    '    RES_DESEVE, '+
    '    RES_CODCTA, '+
    '    RES_DESCTA, '+
    '    RES_DTAVEN, '+
    '    RES_IDESUJ, '+
    '    RES_CODCID) '+
    ' VALUES '+
    '   (:AUTINC, '+
    '    :CODFOR, '+
    '    :NOMFOR, '+
    '    :CODPOR, '+
    '    :NOMPOR, '+
    '    :CODEVE, '+
    '    :DESEVE, '+
    '    :CODCTA, '+
    '    :DESCTA, '+
    '    :DTAVEN, '+
    '    :IDESUJ, '+
    '    :CODCID) ';

var
  qryResIss: TUniQuery;
begin
  qryResIss := fCriaQuery;
  try
    cdsResumo.First;
    while not cdsResumo.Eof do
    begin
      qryResIss.Close;
      qryResIss.SQL.Text := SQL_SELECT_RESISS;
      qryResIss.ParamByName('IDESUJ').AsString := IIF(rdbIndividual.Checked,
                                                      cdsResumo.FieldByName('EMP_CODEMP').AsString,
                                                      Copy(cdsResumo.FieldByName('EMP_C_G_C_').AsString,1,8));
      qryResIss.ParamByName('CODCID').AsString := cdsResumo.FieldByName('EMP_CODCID').AsString;
      qryResIss.Open;

      if qryResIss.IsEmpty then
      begin
        qryResIss.Close;
        qryResIss.SQL.Text := SQL_INSERT_RESISS;
        qryResIss.ParamByName('AUTINC').AsString := fRetautoIncrem('RESISS', VS_strCodEmp);
        qryResIss.ParamByName('CODFOR').AsString := cdsResumo.FieldByName('CTP_CODFOR').AsString;
        qryResIss.ParamByName('NOMFOR').AsString := cdsResumo.FieldByName('FOR_NOMFOR').AsString;
        qryResIss.ParamByName('CODPOR').AsString := cdsResumo.FieldByName('CTP_CODPOR').AsString;
        qryResIss.ParamByName('NOMPOR').AsString := cdsResumo.FieldByName('POR_NOMPOR').AsString;
        qryResIss.ParamByName('CODEVE').AsString := cdsResumo.FieldByName('CTP_CODEVE').AsString;
        qryResIss.ParamByName('DESEVE').AsString := cdsResumo.FieldByName('EVE_DESEVE').AsString;
        qryResIss.ParamByName('CODCTA').AsString := cdsResumo.FieldByName('CTP_CODCTA').AsString;
        qryResIss.ParamByName('DESCTA').AsString := cdsResumo.FieldByName('CTA_DESCTA').AsString;
        qryResIss.ParamByName('DTAVEN').AsString := Copy(cdsResumo.FieldByName('CTP_DTAVEN').AsString,1,2);
        qryResIss.ParamByName('IDESUJ').AsString :=  IIF(rdbIndividual.Checked,
                                                         cdsResumo.FieldByName('EMP_CODEMP').AsString,
                                                         Copy(cdsResumo.FieldByName('EMP_C_G_C_').AsString,1,8));
        qryResIss.ParamByName('CODCID').AsString := cdsResumo.FieldByName('EMP_CODCID').AsString;
        qryResIss.ExecSQL;
      end;

      cdsResumo.Next;
    end;
  finally
    FreeAndNil(qryResIss);
  end;
end;

procedure TfrmResumoISS.pAjustaDataVencimentoConformeSugestao;
begin
  cdsResumo.DisableControls;
  try
    cdsResumo.First;
    while not cdsResumo.Eof do
    begin
      if (fEmptyStr(cdsResumo.FieldByName('RES_DTAVEN').AsString)) or
         (not fEmptyStr(cdsResumo.FieldByName('CTP_DTAVEN').AsString)) or
         (fEmptyStr(cdsResumo.FieldByName('STATUS').AsString)) then
      begin
        cdsResumo.Next;
        Continue;
      end;

      cdsResumo.Edit;
      cdsResumo.FieldByName('CTP_DTAVEN').AsDateTime := fAjustaDataConformeDiaSugestaoRetroagindoParaDiaUtilSeNecessario(edtPerApu.Text,
                                                                                                                         cdsResumo.FieldByName('RES_DTAVEN').AsInteger,
                                                                                                                         1,
                                                                                                                         cdsResumo.FieldByName('EMP_CODCID').AsString);
      cdsResumo.Post;

      cdsResumo.Next;
    end;
  finally
    cdsResumo.EnableControls;
  end;
end;

procedure TfrmResumoISS.rdbIndividualClick(Sender: TObject);
begin
  inherited;

  if Assigned(cdsResumo) then
    cdsResumo.EmptyDataSet;

  pDestravaLckAtc;
end;

end.
