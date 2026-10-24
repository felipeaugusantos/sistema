unit untTicketBalancaQbit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass, UniClientDataSet,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Mask, MaskEditFocus, System.UITypes,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Uni,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid;

type
  TfrmTicketBalancaQbit = class(TfrmPaiConfirma)
    gpbFiltros: TGroupBox;
    lblDtaFin: TLabel;
    mskDtaFin: TMaskEditFocus;
    edtTicket: TEditFocus;
    lblDtaIni: TLabel;
    mskDtaIni: TMaskEditFocus;
    lblTicket: TLabel;
    btnConsultar: TBitBtnLocked;
    cgxTicketsDBTableViewCitel1: TcxGridDBTableViewCitel;
    cgxTicketsLevel1: TcxGridLevel;
    cgxTickets: TcxGridCitel;
    MARDES: TcxGridDBColumn;
    TCK_TICKET: TcxGridDBColumn;
    TCK_NOMCLI: TcxGridDBColumn;
    TCK_PLACA_: TcxGridDBColumn;
    TCK_PESCAR: TcxGridDBColumn;
    procedure btnConsultarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cgxTicketsDBTableViewCitel1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cgxTicketsDBTableViewCitel1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cgxTicketsDBTableViewCitel1DblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

    function fFiltrosPreenchidos: Boolean;
    procedure pConsultarApi;
    procedure pCriaCds;
    procedure pSelecionaTicket;
    procedure pCarregaTicketsUtilizados;
    function fTicketJahUtilizado(const strCodigo: String): Boolean;
  public
    { Public declarations }

    cdsTckQbt,
    cdsTckUti: TUniClientDataSet;
    dtsTckQbt: TDataSource;
  end;

implementation

{$R *.dfm}

uses untBalancaQbit.Pesagem, untFuncoesSimples, untGravando;

procedure TfrmTicketBalancaQbit.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  cdsTckQbt.DisableControls;
  try
    cdsTckQbt.Filtered := False;
    cdsTckQbt.Filter := 'MARDES = '+QuotedStr('M');
    cdsTckQbt.Filtered := True;

    if cdsTckQbt.IsEmpty then
    begin
      ModalResult := mrNone;
      cdsTckQbt.Filtered := False;
      fMensagem('ATENÇÃO!', 'Selecione um Ticket para continuar!', ['&OK']);
      pSetFocus(cgxTickets);
    end;
  finally
    cdsTckQbt.EnableControls;
  end;
end;

procedure TfrmTicketBalancaQbit.btnConsultarClick(Sender: TObject);
begin
  TfrmGravando.fExecutarModal(pConsultarApi, 'Aguarde...', '');
end;

procedure TfrmTicketBalancaQbit.cgxTicketsDBTableViewCitel1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if not Assigned(cdsTckQbt) then
    Exit;

  if not cdsTckQbt.Active then
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

procedure TfrmTicketBalancaQbit.cgxTicketsDBTableViewCitel1DblClick(
  Sender: TObject);
begin
  inherited;
  pSelecionaTicket;
end;

procedure TfrmTicketBalancaQbit.cgxTicketsDBTableViewCitel1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN,
    VK_SPACE: pSelecionaTicket;
  end;
end;

procedure TfrmTicketBalancaQbit.pConsultarApi;
var
  BalancaQbitPesagem: TBalancaQbitPesagem;
  Pesagem: TPesagens;
begin
  inherited;
  if not fFiltrosPreenchidos then
    Exit;

  if not fEmptyStr(edtTicket.Text) then
    BalancaQbitPesagem := TBalancaQbitPesagem.fConsultarPesagemTicket(edtTicket.Text)
  else
    BalancaQbitPesagem := TBalancaQbitPesagem.fConsultarPesagemPeriodo(StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text));
  try
    if not Assigned(BalancaQbitPesagem) then
      Exit;

    cdsTckQbt.EmptyDataSet;

    for Pesagem in BalancaQbitPesagem.Pesagens do
    begin
      if fTicketJahUtilizado(Pesagem.Codigo) then
        Continue;

      cdsTckQbt.Append;
      cdsTckQbt.FieldByName('MARDES').AsString := 'D';
      cdsTckQbt.FieldByName('TCK_TICKET').AsString := Pesagem.Codigo;
      cdsTckQbt.FieldByName('TCK_NOMCLI').AsString := Pesagem.NomeCliente;
      cdsTckQbt.FieldByName('TCK_PLACA_').AsString := Pesagem.PlacaCavalo;
      cdsTckQbt.FieldByName('TCK_PESCAR').AsFloat :=  Pesagem.PesoLiquido;
      cdsTckQbt.Post;
    end;

  finally
    if Assigned(BalancaQbitPesagem) then
      FreeAndNil(BalancaQbitPesagem);
  end;
end;

function TfrmTicketBalancaQbit.fFiltrosPreenchidos: Boolean;
begin
  Result := False;
  try
    if not fEmptyStr(edtTicket.Text) then
      Exit(True);

    if fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) then
      Exit;

    if fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) then
      Exit;

    if not fValidaDataStr(mskDtaIni.Text) then
      Exit;

    if not fValidaDataStr(mskDtaFin.Text) then
      Exit;

    Result := True;
  finally
    if not Result then
      fMensagem('ATENÇÃO!','Preencha o campo Ticket OU os campos Data Inicial e Data Final!',['&OK']);
  end;
end;

procedure TfrmTicketBalancaQbit.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaCds;
end;

procedure TfrmTicketBalancaQbit.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(dtsTckQbt);
  FreeAndNil(cdsTckQbt);
end;

procedure TfrmTicketBalancaQbit.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F10: btnConsultar.Click;
  end;
end;

procedure TfrmTicketBalancaQbit.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaTicketsUtilizados;
end;

function TfrmTicketBalancaQbit.fTicketJahUtilizado(const strCodigo: String): Boolean;
begin
  cdsTckUti.Filtered := False;
  cdsTckUti.Filter := 'TCK_TICKET = '+QuotedStr(strCodigo);
  cdsTckUti.Filtered := True;

  Result := not cdsTckUti.IsEmpty;
end;

procedure TfrmTicketBalancaQbit.pCarregaTicketsUtilizados;
var
  qryTckUti: TUniQuery;
begin
  inherited;
  qryTckUti := fCriaQuery(Self);
  try
    qryTckUti.Close;
    qryTckUti.SQL.Text :=
    ' SELECT '+
    '   MOVTRI.DET_TCKQBT AS TCK_TICKET '+
    ' FROM '+
    '   MOVDET '+
    ' INNER JOIN MOVTRI '+
    '   ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER '+
    ' WHERE '+
    '   MOVDET.DET_CODEMP = :CODEMP '+

    ' UNION '+

    ' SELECT '+
    '   EXTDOR.FDO_TCKQBT AS TCK_TICKET '+
    ' FROM '+
    '   FATDOR '+
    ' INNER JOIN EXTDOR '+
    '   ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO '+
    ' WHERE '+
    '   FATDOR.FDO_CODEMP = :CODEMP ';

    qryTckUti.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTckUti.Open;

    cdsTckUti := fCriaClientDatset(qryTckUti);
  finally
    FreeAndNil(qryTckUti);
  end;
end;

procedure TfrmTicketBalancaQbit.pCriaCds;
begin
  cdsTckQbt := TUniClientDataSet.Create(nil);

  cdsTckQbt.FieldDefs.Add('MARDES'    , ftString, 001);
  cdsTckQbt.FieldDefs.Add('TCK_TICKET', ftString, 020);
  cdsTckQbt.FieldDefs.Add('TCK_NOMCLI', ftString, 100);
  cdsTckQbt.FieldDefs.Add('TCK_PLACA_', ftString, 010);
  cdsTckQbt.FieldDefs.Add('TCK_PESCAR', ftFloat      );

  cdsTckQbt.CreateDataSet;

  dtsTckQbt := fCriaDataSource(cdsTckQbt);
  cgxTicketsDBTableViewCitel1.DataController.DataSource := dtsTckQbt;
end;

procedure TfrmTicketBalancaQbit.pSelecionaTicket;
var
  intRecNo: Integer;
begin
  if not Assigned(cdsTckQbt) then
    Exit;

  if not cdsTckQbt.Active then
    Exit;

  if cdsTckQbt.IsEmpty then
    Exit;

  intRecNo := cdsTckQbt.RecNo;

  cdsTckQbt.DisableControls;
  try
    cdsTckQbt.First;
    while not cdsTckQbt.Eof do
    begin
      cdsTckQbt.Edit;
      cdsTckQbt.FieldByName('MARDES').AsString := IIF(cdsTckQbt.RecNo = intRecNo, 'M', 'D');
      cdsTckQbt.Post;

      cdsTckQbt.Next;
    end;
    cdsTckQbt.RecNo := intRecNo;

    btnConfirma.Click;
  finally
    cdsTckQbt.EnableControls;
  end;
end;

end.
