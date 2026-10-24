unit untRelLimitesAlpe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, QColorLabel, Vcl.Mask,
  MaskEditFocus, untMskC_G_C_, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Uni,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, UniClientDataSet;

type
  TfrmRelLimitesAlpe = class(TfrmPaiConfirma)
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    lblCliente: TLabel;
    gpbDestino: TGroupBox;
    ColorLabel1: TColorLabel;
    edtDestino: TEditFocus;
    mskCgcCli: TMaskEditC_G_C_;
    LabelCgcCpf1: TLabel;
    btnAdicionar: TBitBtnLocked;
    cxgClientesDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxgClientesLevel1: TcxGridLevel;
    cxgClientes: TcxGridCitel;
    CLI_CODCLI: TcxGridDBColumn;
    CLI_NOMCLI: TcxGridDBColumn;
    CLI_C_G_C_: TcxGridDBColumn;
    BitBtnLocked1: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure cxgClientesDBTableViewCitel1EditKeyDown(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
    procedure btnAdicionarClick(Sender: TObject);
    procedure BitBtnLocked1Click(Sender: TObject);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  private
    { Private declarations }
    cdsClientes: TUniClientDataSet;
    dtsClientes: TDataSource;

    procedure pCriaCdsClientes;
    procedure pAtualizaLimites;
    procedure pLimpaCampos;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untAlpePaymentProductsArrangements, untFuncoesSimples, untGravando,
  untConsultas, untTypesSistema;

procedure TfrmRelLimitesAlpe.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaCdsClientes;
  dtsClientes := fCriaDataSource(cdsClientes);
  cxgClientesDBTableViewCitel1.DataController.DataSource := dtsClientes;
end;

procedure TfrmRelLimitesAlpe.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsClientes);
end;

procedure TfrmRelLimitesAlpe.pCriaCdsClientes;
begin
  cdsClientes := TUniClientDataSet.Create(Self);
  cdsClientes.FieldDefs.Add('CLI_CODCLI', ftString, 8);
  cdsClientes.FieldDefs.Add('CLI_NOMCLI', ftString, 60);
  cdsClientes.FieldDefs.Add('CLI_C_G_C_', ftString, 18);
  cdsClientes.CreateDataSet;
end;

procedure TfrmRelLimitesAlpe.pLimpaCampos;
begin
  edtCodCli.Clear;
  edtNomCli.Clear;
  mskCgcCli.Clear;

  pSetFocus(edtCodCli);
end;

procedure TfrmRelLimitesAlpe.btnConfirmaClick(Sender: TObject);
begin
  ModalResult := mrNone;
  blnVerificaCampos := False;

  if not fValidaCampos(edtDestino, True) then
    Exit;

  TfrmGravando.fExecutarModal(pAtualizaLimites, 'Consultando limites', '');

  //chamar o relatório aqui
end;

procedure TfrmRelLimitesAlpe.pAtualizaLimites;
var
  fltLimiteTotal,
  fltLimiteUtilizado,
  fltLimiteDisponivel: Double;

  blnStopSupply: Boolean;

  strMsg: String;

  blnMostrouMsg: Boolean;
begin
  blnMostrouMsg := False;

  if cdsClientes.IsEmpty then
    Exit;

  cdsClientes.First;
  while not cdsClientes.Eof do
  begin
    fltLimiteTotal := 0;
    fltLimiteUtilizado := 0;
    fltLimiteDisponivel := 0;
    blnStopSupply := False;

    if not TControllerPaymentProductsArrangements.fConsultaAlpeLimiteBoleto(cdsClientes.FieldByName('CLI_C_G_C_').AsString,
                                                                            fltLimiteTotal,
                                                                            fltLimiteUtilizado,
                                                                            fltLimiteDisponivel,
                                                                            blnStopSupply,
                                                                            strMsg,
                                                                            False) then
    begin
      if blnStopSupply then
        fMensagem('ATENÇÃO!', 'O cliente'+cdsClientes.FieldByName('CLI_NOMCLI').AsString+
                              ' está com a flag stopSupply habilitada, portanto seus limites poderão estar desatualizados!',['&OK'])
      else if not blnMostrouMsg then
      begin
        blnMostrouMsg := True;
        fMensagem('ATENÇÃO!', 'Ocorreu erro na consulta do limite de alguns clientes, portanto algumas informações poderão estar desatualizadas!',['&OK'])
      end;
    end;

    cdsClientes.Next;
  end;
end;

procedure TfrmRelLimitesAlpe.BitBtnLocked1Click(Sender: TObject);
var
  qryCadCli: TUniQuery;
begin
  inherited;

  qryCadCli := fCriaQuery(Self);
  try
    qryCadCli.Close;
    qryCadCli.SQL.Text :=
      ' SELECT '+
      '   CLI_CODCLI, '+
      '   CLI_NOMCLI, '+
      '   CLI_C_G_C_  '+
      ' FROM '+
      '   CADCLI '+
      ' WHERE '+
      '   CLI_UTIALP = "S" ';

    qryCadCli.Open;

    if not qryCadCli.IsEmpty then
    begin
      cdsClientes.EmptyDataSet;

      while not qryCadCli.Eof do
      begin
        cdsClientes.Append;
        cdsClientes.FieldByName('CLI_CODCLI').AsString := qryCadCli.FieldByName('CLI_CODCLI').AsString;
        cdsClientes.FieldByName('CLI_NOMCLI').AsString := qryCadCli.FieldByName('CLI_NOMCLI').AsString;
        cdsClientes.FieldByName('CLI_C_G_C_').AsString := qryCadCli.FieldByName('CLI_C_G_C_').AsString;
        cdsClientes.Post;

        qryCadCli.Next;
      end;
    end;

  finally
    FreeAndNil(qryCadCli);
  end;
end;

procedure TfrmRelLimitesAlpe.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  if not fValidaCampos(edtCodCli, True) then
    Exit;

  cdsClientes.Append;
  cdsClientes.FieldByName('CLI_CODCLI').AsString := edtCodCli.Text;
  cdsClientes.FieldByName('CLI_NOMCLI').AsString := edtNomCli.Text;
  cdsClientes.FieldByName('CLI_C_G_C_').AsString := mskCgcCli.Text;
  cdsClientes.Post;

  pLimpaCampos;
end;

procedure TfrmRelLimitesAlpe.cxgClientesDBTableViewCitel1EditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_DELETE) and (not cdsClientes.IsEmpty) then
    cdsClientes.Delete;
end;

procedure TfrmRelLimitesAlpe.edtCodCliKeyPress(Sender: TObject; var Key: Char);
var
  arrClientes: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, nil, Key, arrClientes) Then
  Begin
    fValidaCampos(edtCodCli, True);
    SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelLimitesAlpe.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  try
    if (Sender = edtCodCli) then
    begin
      if fEmptyStr(edtCodCli.Text) then
      begin
        fMensagem('ATENÇÃO!', 'Informe o cliente!',['&OK']);
        Exit(False);
      end
      else
        edtNomCli.Text := fRetNomCliente(edtCodCli.Text);

      if fEmptyStr(edtNomCli.Text) then
      begin
        fMensagem('ATENÇÃO!', 'Cliente não encontrado!',['&OK']);
        Exit(False);
      end
      else
        mskCgcCli.Text := fRetCgcCpf(edtCodCli.Text);
    end

    else if Sender = edtDestino then
    begin
      if Pos(edtDestino.Text, 'V_I_P_C_') = 0 then
      begin
        fMensagem('ATENÇÃO!', 'Destino inválido!',['&OK']);
        Exit(False);
      end;
    end;

  finally
    if not Result then
      psetFocus(Sender);
  end;
end;

end.
