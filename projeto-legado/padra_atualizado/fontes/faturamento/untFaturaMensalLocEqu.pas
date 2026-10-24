unit untFaturaMensalLocEqu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Vcl.ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid,
  Vcl.StdCtrls, Vcl.Mask, MaskEditFocus, EditFocus, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Datasnap.DBClient, UniClientDataSet, DBAccess, Uni,
  cadastro.Model.ContratoLocacaoEquipamentos, MemDS, Datasnap.Provider,
  UniDataSetProvider, faturamento.Classes.FaturamentoLocEqu, untFuncoesLocEqu;

type
  TfrmFaturaMensalLocEqu = class(TfrmPai)
    pnlCabecalho: TPanel;
    lblNumCon: TLabel;
    lblCodCli: TLabel;
    lblMesVigencia: TLabel;
    edtNumCon: TEditFocus;
    edtNomCli: TEditFocus;
    edtCodCli: TEditFocus;
    mskMesVig: TMaskEditFocus;
    pnlDtaRef: TPanel;
    lblDataReferencia: TLabel;
    btnConfirmar: TBitBtnLocked;
    mskDtaReferencia: TMaskEditFocus;
    edtHorReferencia: TMaskEditFocus;
    pnlFiltros: TPanel;
    chkAgruparDuplicatas: TCheckBox;
    chkImpBoleto: TCheckBox;
    pnlContratos: TPanel;
    cxGridContratos: TcxGridCitel;
    cxGridContratosTableView: TcxGridDBTableViewCitel;
    cxGridContratosTableViewEQL_NROCON: TcxGridDBColumn;
    cxGridContratosTableViewEQL_CODCLI: TcxGridDBColumn;
    cxGridContratosTableViewCLI_NOMCLI: TcxGridDBColumn;
    cxGridContratosTableViewDUR_ESTCON: TcxGridDBColumn;
    cxGridContratosTableViewEQL_TOTHOR: TcxGridDBColumn;
    cxGridContratosTableViewEQL_TOTDIA: TcxGridDBColumn;
    cxGridContratosTableViewEQL_TOTCON: TcxGridDBColumn;
    cxGridContratosTableViewFAT_TOTCAL: TcxGridDBColumn;
    cxGridContratosLevel1: TcxGridLevel;
    dtsContratos: TUniDataSource;
    cdsContratos: TUniClientDataSet;
    cdsContratosEQL_NROCON: TStringField;
    cdsContratosEQL_CODCLI: TStringField;
    cdsContratosCLI_NOMCLI: TStringField;
    cdsContratosDUR_ESTCON: TStringField;
    cdsContratosEQL_TOTDIA: TFloatField;
    cdsContratosEQL_TOTHOR: TFloatField;
    cdsContratosEQL_TOTCON: TFloatField;
    cdsContratosEQF_VLJFAT: TFloatField;
    cdsContratosEQF_VLRFAT: TFloatField;
    cxGridContratosTableViewEQF_VLRFAT: TcxGridDBColumn;
    cdsContratosTOT_DIACAL: TFloatField;
    cdsContratosTOT_HRACAL: TFloatField;
    cxGridContratosTableViewTOT_HRACAL: TcxGridDBColumn;
    cxGridContratosTableViewTOT_DIACAL: TcxGridDBColumn;
    cdsContratosVLR_LOCCAL: TFloatField;
    cdsContratosEQL_VLRCOB: TFloatField;
    cdsContratosTOT_VLRCAL: TFloatField;
    cxGridContratosTableViewVLR_LOCCAL: TcxGridDBColumn;
    cxGridContratosTableViewEQL_VLRCOB: TcxGridDBColumn;
    cxGridContratosTableViewTOT_VLRCAL: TcxGridDBColumn;
    blnConfirmarFaturamento: TBitBtnLocked;
    blnExpandirAcessorios: TBitBtnLocked;
    blnRetrairAcessorios: TBitBtnLocked;
    blnMarcarTodos: TBitBtnLocked;
    blnDesmarcarTodos: TBitBtnLocked;
    cdsContratosEQL_MARDES: TStringField;
    cxGridContratosTableViewEQL_MARDES: TcxGridDBColumn;
    cxGridContratosLevel2: TcxGridLevel;
    cxGridItensTableView: TcxGridDBTableViewCitel;
    cxGridContratosLevelAcessorios: TcxGridLevel;
    cxGridAcessoriosTableView: TcxGridDBTableViewCitel;
    cdsContratosEQL_SEQCON: TStringField;
    dtsEqlDet: TDataSource;
    cdsEqlDet: TUniClientDataSet;
    cdsEqlDetEQD_SEQCON: TStringField;
    cdsEqlDetEQL_DSCVEN: TFloatField;
    cdsEqlDetEQL_DSCSGE: TFloatField;
    cdsEqlDetEQL_DSCGER: TFloatField;
    cdsEqlDetEQL_VALLOC: TFloatField;
    cdsEqlDetEQD_VLLOCL: TFloatField;
    cdsEqlDetEQD_TOTLIQ: TFloatField;
    cdsEqlDetEQD_PERDES: TFloatField;
    cdsEqlDetEQL_VLRCAU: TFloatField;
    cdsEqlDetTIPO_CONTRATO: TStringField;
    cdsEqlDetEQD_VLRALT: TStringField;
    cdsEqlDetEQD_VALHOR: TFloatField;
    cdsEqlDetEQD_TOTEQL: TFloatField;
    cdsEqlDetEQD_DESCRI: TStringField;
    cdsEqlDetEQD_SEQEQL: TStringField;
    cdsEqlDetEQD_TIPDUR: TStringField;
    cdsEqlDetEQL_CODIGO: TStringField;
    cdsEqlDetEQD_NSERIE: TStringField;
    cdsEqlDetAUTOINCREM: TStringField;
    cdsEqlDetEQD_VALIPE: TFloatField;
    cdsEqlDetEQD_VALTOT: TFloatField;
    cdsEqlDetEQD_QTDDUR: TFloatField;
    cdsEqlDetEQF_VLJFAT: TFloatField;
    cdsEqlDetEQF_VLAFAT: TFloatField;
    cdsEqlDetEQF_VLRFAT: TFloatField;
    cdsEqlDetEQF_VLRDSC: TFloatField;
    cdsEqlDetEQF_VLRLIQ: TFloatField;
    cdsEqlDetEQF_DTAENC: TDateTimeField;
    cdsEqlDetEQD_MARDES: TStringField;
    cdsEqlDetEQD_DOCENV: TStringField;
    cdsEqlDetEQD_DOCRET: TStringField;
    cdsEqlDetEQD_DTAIPE: TDateTimeField;
    cdsEqlDetEQD_DTACOB: TDateTimeField;
    cdsEqlDetEQD_DTAFCOB: TDateTimeField;
    cdsEqlDetEQD_DTAENC: TDateTimeField;
    cdsEqlDetEQD_UTIFXN: TStringField;
    cxGridItensTableViewEQD_SEQCON: TcxGridDBColumn;
    cxGridItensTableViewTIPO_CONTRATO: TcxGridDBColumn;
    cxGridItensTableViewEQD_DESCRI: TcxGridDBColumn;
    cxGridItensTableViewEQD_SEQEQL: TcxGridDBColumn;
    cxGridItensTableViewEQD_TIPDUR: TcxGridDBColumn;
    cxGridItensTableViewEQD_NSERIE: TcxGridDBColumn;
    cxGridItensTableViewEQD_QTDDUR: TcxGridDBColumn;
    cxGridItensTableViewEQD_DOCENV: TcxGridDBColumn;
    cxGridItensTableViewEQD_DOCRET: TcxGridDBColumn;
    cxGridItensTableViewEQD_DTACOB: TcxGridDBColumn;
    cxGridItensTableViewEQD_DTAFCOB: TcxGridDBColumn;
    cxGridItensTableViewEQD_TOTEQL: TcxGridDBColumn;
    cxGridItensTableViewEQD_VALIPE: TcxGridDBColumn;
    cxGridItensTableViewEQF_VLJFAT: TcxGridDBColumn;
    cxGridItensTableViewEQF_VLRFAT: TcxGridDBColumn;
    cxGridItensTableViewEQF_VLRDSC: TcxGridDBColumn;
    cxGridItensTableViewEQF_VLRLIQ: TcxGridDBColumn;
    cxGridItensTableViewEQF_VLAFAT: TcxGridDBColumn;
    cxGridItensTableViewEQD_DTAENC: TcxGridDBColumn;
    cxGridItensTableViewEQD_VALTOT: TcxGridDBColumn;
    cdsEqlAce: TUniClientDataSet;
    cdsEqlAceCODIGO: TStringField;
    cdsEqlAceDESCRICAO: TStringField;
    cdsEqlAceQUANTIDADE: TFloatField;
    cdsEqlAceEQA_SEQEQU: TStringField;
    cdsEqlAceEQA_SEQACL: TStringField;
    cdsEqlAceEQA_VLRCOB: TFloatField;
    dtsEqlAcl: TDataSource;
    cxGridAcessoriosTableViewCODIGO: TcxGridDBColumn;
    cxGridAcessoriosTableViewDESCRICAO: TcxGridDBColumn;
    cxGridAcessoriosTableViewQUANTIDADE: TcxGridDBColumn;
    cxGridAcessoriosTableViewEQA_SEQEQU: TcxGridDBColumn;
    cxGridAcessoriosTableViewEQA_SEQACL: TcxGridDBColumn;
    cxGridAcessoriosTableViewEQA_VLRCOB: TcxGridDBColumn;
    cdsEqlAceEQD_SEQCON: TStringField;
    cxGridContratosTableViewEQL_SEQCON: TcxGridDBColumn;
    cxGridAcessoriosTableViewEQD_SEQCON: TcxGridDBColumn;
    cxGridContratosTableViewEQL_TAXENT: TcxGridDBColumn;
    cdsContratosEQL_TAXENT: TFloatField;
    cdsContratosEQL_TOTMES: TIntegerField;
    cxGridContratosTableViewEQL_TOMES: TcxGridDBColumn;
    cdsContratosTOT_MESCAL: TFloatField;
    cxGridContratosTableViewTOT_MESCAL: TcxGridDBColumn;
    lblNumPed: TLabel;
    edtNumPed: TEditFocus;
    cdsEqlDetEQD_QTDEQU: TFloatField;
    cxGridItensTableViewEQD_QTDEQU: TcxGridDBColumn;
    cdsEqlAceEQA_QTDTOT: TFloatField;
    cxGridAcessoriosTableViewEQA_QTDTOT: TcxGridDBColumn;
    cxGridAcessoriosTableViewEQA_VLRADC: TcxGridDBColumn;
    cdsEqlAceEQA_VLRADC: TFloatField;
    procedure edtNumConKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure blnMarcarTodosClick(Sender: TObject);
    procedure blnDesmarcarTodosClick(Sender: TObject);
    procedure cxGridContratosTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure blnExpandirAcessoriosClick(Sender: TObject);
    procedure blnRetrairAcessoriosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure blnConfirmarFaturamentoClick(Sender: TObject);
    procedure cxGridContratosTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure edtNumPedKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    ObjContratoFiltro: TContratoLocacaoEquipamentos;
    ObjFaturaMensal: TFaturamentoMensalContrato;
    qryCli,
    qryEntCli: TUniQuery;
    FdataReferencia: TDateTime;
    FBlnUtilizaAcessorios: Boolean;
    FintLocDec: Integer;
    FstrLocDec: String;

    procedure pLimparCampos;
    procedure pCarregarClienteFiltro;
    procedure pCarregarContratos;
    procedure pCarregarEquipamentos(const aFatura: TFaturamentoContrato);
    procedure pCarregarAcessorios(const aItemContrato: TItemContratoLocacaoEquipamentos);
    procedure pCalcularDataReferencia;
    procedure pFormatarCampos;
    procedure pMarcarTodos(const blnMarcar: Boolean);
    procedure pConfirmarFaturamento;
    procedure pLimpaContratosDesmarcados;
    procedure pEmitirFaturas;
    procedure pMarcarContrato(const blnMarcar: Boolean);

    function fCarregarContrato(const strAutInc, strNumeroContrato: String;
      strNumPed: String = ''; blnExibirMsg: Boolean = True): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl;  blnBuscaPorChave: Boolean): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses
  untConsultas, untFuncoesSimples, untTypesSistema, untPesqAux, untTypesLocEqu,
  untDupFatLoqEqlMensal, untGravando;

{$R *.dfm}

{ TfrmPai1 }

procedure TfrmFaturaMensalLocEqu.blnConfirmarFaturamentoClick(Sender: TObject);
begin
  inherited;

  pConfirmarFaturamento;
end;

procedure TfrmFaturaMensalLocEqu.blnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;

  pMarcarTodos(False);
end;

procedure TfrmFaturaMensalLocEqu.blnExpandirAcessoriosClick(Sender: TObject);
begin
  inherited;

  If (cxGridContratosTableView.DataController.DataSource.DataSet.Active) Then
    If (Not cxGridContratosTableView.DataController.DataSource.DataSet.IsEmpty) Then
      cxGridContratosTableView.ViewData.Expand(True);

  If (cxGridItensTableView.DataController.DataSource.DataSet.Active) Then
    If (Not cxGridItensTableView.DataController.DataSource.DataSet.IsEmpty) Then
      cxGridItensTableView.ViewData.Expand(True);

  If (cxGridAcessoriosTableView.DataController.DataSource.DataSet.Active) Then
    If (Not cxGridAcessoriosTableView.DataController.DataSource.DataSet.IsEmpty) Then
      cxGridAcessoriosTableView.ViewData.Expand(True);
end;

procedure TfrmFaturaMensalLocEqu.blnMarcarTodosClick(Sender: TObject);
begin
  inherited;

  pMarcarTodos(True);
end;

procedure TfrmFaturaMensalLocEqu.blnRetrairAcessoriosClick(Sender: TObject);
begin
  inherited;

  If (cxGridContratosTableView.DataController.DataSource.DataSet.Active) Then
    If (Not cxGridContratosTableView.DataController.DataSource.DataSet.IsEmpty) Then
      cxGridContratosTableView.ViewData.Collapse(True);

  If (cxGridItensTableView.DataController.DataSource.DataSet.Active) Then
    If (Not cxGridItensTableView.DataController.DataSource.DataSet.IsEmpty) Then
      cxGridItensTableView.ViewData.Collapse(True);

  If (cxGridAcessoriosTableView.DataController.DataSource.DataSet.Active) Then
    If (Not cxGridAcessoriosTableView.DataController.DataSource.DataSet.IsEmpty) Then
      cxGridAcessoriosTableView.ViewData.Collapse(True);
end;

procedure TfrmFaturaMensalLocEqu.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  TfrmGravando.fExecutarModal(pCarregarContratos, 'Aguarde carregando contratos....', 'FaturaMensalLocEqu');
end;


procedure TfrmFaturaMensalLocEqu.cxGridContratosTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If AViewInfo.GridRecord.Values[cxGridContratosTableViewEQL_MARDES.Index] = 'M' Then
    ACanvas.Font.Color := clBlue;
end;

procedure TfrmFaturaMensalLocEqu.cxGridContratosTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key of
    VK_RETURN : pMarcarContrato(cdsContratos.FieldByName('EQL_MARDES').AsString = 'D');
  End;

end;

procedure TfrmFaturaMensalLocEqu.edtCodCliKeyPress(Sender: TObject; var Key: Char);
Var
  arrClientes: TConsultasArray;
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFaturaMensalLocEqu.edtNumConKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  If fPesqContratoLocEquip(Self, edtNumCon, Nil, Nil, Key, arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFaturaMensalLocEqu.edtNumPedKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  If fPesqContratoLocEquip(Self, edtNumCon, nil, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtNumPed, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

function TfrmFaturaMensalLocEqu.fCarregarContrato(const strAutInc, strNumeroContrato: String;
      strNumPed: String = ''; blnExibirMsg: Boolean = True): Boolean;
begin

  pLimparCampos;
  ObjContratoFiltro.fCarregarContrato(strAutInc, strNumeroContrato, True, strNumPed);
  ObjFaturaMensal.pLimpar;

  If Not fValidaTravasContrato(ObjContratoFiltro.AutInc) Then
  Begin
    Result := False;
    Exit;
  End;

  ObjFaturaMensal.fAddContrato(ObjContratoFiltro);

  If fEmptyStr(ObjContratoFiltro.NroContrato) Then
  Begin
    If blnExibirMsg Then
      fMensagem('ATENÇÃO', 'Contrato não encontrado!', ['&Ok']);
    Result := False;
    Exit;
  End;

  If ObjContratoFiltro.Status = 'O' Then
  Begin
    fMensagem('ATENÇÃO', 'Contrato não está ativo! Favor realizar a ativação do contrato antes da inspeção.', ['&Ok']);
    Result := False;
    Exit;
  End;

  If ObjContratoFiltro.Status = 'F' Then
  Begin
    fMensagem('ATENÇÃO', 'Contrato já faturado.', ['&Ok']);
    Result := False;
    Exit;
  End;

  If ObjContratoFiltro.Status = 'E' Then
  Begin
    fMensagem('ATENÇÃO', 'Contrato encerrado.', ['&Ok']);
    Result := False;
    Exit;
  End;

  If Not ObjFaturaMensal.objValidaCtr.fValidarItensEnviados Then
  Begin
    fMensagem('ATENÇÃO', 'Existem equipamentos neste contrato que ainda não foram enviados para o cliente!', ['&Ok']);
    Result := False;
    Exit;
  End;

  If Not ObjFaturaMensal.objValidaCtr.fValidarCondicaoPagamentoInformada Then
  Begin
    fMensagem('ATENÇÃO','A configuração [CFG_CPGCTR] está ativada, porém o Contrato ' + ObjContratoFiltro.NroContrato + ' não possui Condição de Pagamento. ' +
                        'Utilize a Rotina de Faturamento individual em "Principal > Faturamento > Locação de Equipamentos > Faturamento"', ['&Ok']);
    Result := False;
    Exit;
  End;

  If Not(ObjContratoFiltro.fVerificaPedAdtGerado) Then
  Begin
    fMensagem('ATENÇÃO', 'Contrato não possui pedido de adiantamento e não pode ser faturado!', ['&Ok']);
    Result := False;
    Exit;
  End;

  edtNumPed.Text := Copy(ObjContratoFiltro.NumDocPedAdiantamento, 0, 12);
  edtNumCon.Text := Copy(ObjContratoFiltro.NroContrato, 0, 12);

  ObjFaturaMensal.fRemoveContrato(ObjContratoFiltro.AutInc);

  Result := True;
end;

procedure TfrmFaturaMensalLocEqu.FormCreate(Sender: TObject);
begin
  inherited;

  ObjContratoFiltro := TContratoLocacaoEquipamentos.Create;
  ObjFaturaMensal := TFaturamentoMensalContrato.Create;
  qryCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  qryEntCli := fCriarQuery('SELECT ENTCLI.AUTOINCREM, CONCAT(ETC_ENDENT, " - ", ETC_BAIENT, " - ", CID_NOMCID, " - ", CID_ESTADO) AS ETC_ENDENT FROM ENTCLI INNER JOIN CADCID ON CID_CODCID = ETC_CIDENT WHERE ETC_CODCLI = :CODCLI AND ETC_SITUAC = "A"', Self);
  pLimparCampos;

  cdsContratos.CreateDataSet;
  cdsEqlDet.CreateDataSet;
  cdsEqlAce.CreateDataSet;

  FBlnUtilizaAcessorios := fCfgSis('UTIACE', VarBoolean);
  blnExpandirAcessorios.Visible := FBlnUtilizaAcessorios;
  blnRetrairAcessorios.Visible := FBlnUtilizaAcessorios;
  cxGridContratosLevelAcessorios.Visible := FBlnUtilizaAcessorios;

  If Not (fCfgSis('CTRMES', VarBoolean)) Then
  Begin
    cxGridContratosTableViewEQL_TOMES.Visible := False;
    cxGridContratosTableViewTOT_MESCAL.Visible := False;
  End;

  If fCfgSis('PDRCTR', VarBoolean) Then
  Begin
    edtNumPed.Visible := True;
  End
  Else
  Begin
    edtNumPed.Visible := False;
    lblNumPed.Visible := False;
    edtNumCon.Left := edtNumPed.left;
    lblNumCon.Left := edtNumCon.Left -  lblNumCon.Width ;
  End;

  FintLocDec := fCfgSis('LOCDEC', VarInteger);
  FstrLocDec := '#,##0.' + fStrZero('0', FintLocDec);

  pFormatarCampos;

  Self.WindowState := wsMaximized;
end;

procedure TfrmFaturaMensalLocEqu.FormDestroy(Sender: TObject);
begin
  inherited;


  ObjFaturaMensal.pDestravar;

  FreeAndNil(ObjContratoFiltro);
  FreeAndNil(ObjFaturaMensal);
  FreeAndNil(qryEntCli);
  FreeAndNil(qryCli);
end;

procedure TfrmFaturaMensalLocEqu.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key of
    VK_F5  : blnExpandirAcessorios.Click;
    VK_F6  : blnRetrairAcessorios.Click;
    VK_F7  : blnMarcarTodos.Click;
    VK_F8  : blnDesmarcarTodos.Click;
    VK_F10 : Begin
               If Not blnConfirmarFaturamento.Enabled Then
                 Exit;

               If (Shift = []) Then
                 blnConfirmarFaturamento.Click;
             End;
  End;
end;

procedure TfrmFaturaMensalLocEqu.FormShow(Sender: TObject);
begin
  inherited;

  If fCfgSis('PDRCTR', VarBoolean) Then
    pSetFocus(edtNumPed)
  Else
    pSetFocus(edtNumCon);
end;

function TfrmFaturaMensalLocEqu.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then Begin

    If (Sender = edtNumCon) Then
    Begin
      If Not fEmptyStr(edtNumCon.Text) Then
        Result := fCarregarContrato('', edtNumCon.Text);
    End

    Else If (Sender = edtNumPed)  Then
    Begin
      If Not fEmptyStr(edtNumPed.Text) Then
      Begin
        fCarregarContrato('', '', edtNumPed.Text, False);
        If (fEmptyStr(edtNumCon.Text)) And (Not fEmptyStr(edtNumPed.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Pedido informado não é da rotina de Locação de Equipamentos.', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodCli) Then
    Begin
      pCarregarClienteFiltro;
      If Not fEmptyStr(edtCodCli.Text) Then
      Begin
        If qryCli.FieldByName('CLI_STATUS').AsString <> 'A' Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente está inativo!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = mskMesVig) Then
    Begin
      If Not fEmptyDate(mskMesVig.Text) Then
      Begin
        Try
          strToDate('01/' + mskMesVig.Text);
        Except
          fMensagem('', 'Mês / Ano inválido !', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = mskDtaReferencia) Then
    Begin
      If fEmptyDate(mskDtaReferencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe a data de referência!', ['&O k']);
        Result := False;
      End
      Else Begin
        pCalcularDataReferencia;
        If FdataReferencia <= 0 Then
          Result := False;
      End;
    End

    Else If (Sender = edtHorReferencia) Then
    Begin
      If fEmptyTime(edtHorReferencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe a hora de referência!', ['&O k']);
        Result := False;
      End
      Else Begin
        pCalcularDataReferencia;
        If FdataReferencia <= 0 Then
          Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmFaturaMensalLocEqu.pCalcularDataReferencia;
begin
  FdataReferencia := 0;

  If fEmptyDate(mskDtaReferencia.Text) Then
    Exit;

  If fEmptyDate(edtHorReferencia.Text) Then
    Exit;

  FdataReferencia := StrToDateTime(mskDtaReferencia.Text + edtHorReferencia.Text);
end;

procedure TfrmFaturaMensalLocEqu.pCarregarAcessorios(
  const aItemContrato: TItemContratoLocacaoEquipamentos);
var
  intCnt: integer;
begin
  If Not FBlnUtilizaAcessorios Then
    Exit;

  cdsEqlAce.DisableControls;
  Try
    Try
      For intCnt := 0 to aItemContrato.Acessorios.Count-1 Do
      Begin
        cdsEqlAce.Insert;
        cdsEqlAce.FieldByName('EQD_SEQCON').AsString := aItemContrato.Contrato.AutInc;
        cdsEqlAce.FieldByName('EQA_SEQEQU').AsString := aItemContrato.Acessorios[intCnt].CodEquipamento;
        cdsEqlAce.FieldByName('EQA_SEQACL').AsString := aItemContrato.Acessorios[intCnt].Acessorio.AutInc;
        cdsEqlAce.FieldByName('CODIGO').AsString     := aItemContrato.Acessorios[intCnt].Acessorio.Codigo;
        cdsEqlAce.FieldByName('DESCRICAO').AsString  := aItemContrato.Acessorios[intCnt].Acessorio.Descricao;
        cdsEqlAce.FieldByName('QUANTIDADE').AsFloat  := aItemContrato.Acessorios[intCnt].Quantidade;
        cdsEqlAce.FieldByName('EQA_VLRCOB').AsFloat  := aItemContrato.Acessorios[intCnt].ValorCobranca;
        cdsEqlAce.FieldByName('EQA_QTDTOT').AsFloat  := aItemContrato.Acessorios[intCnt].Quantidade * aItemContrato.Quantidade;
        cdsEqlAce.FieldByName('EQA_VLRADC').AsFloat  := aItemContrato.Acessorios[intCnt].Quantidade * aItemContrato.Acessorios[intCnt].ValorAdicional;

        cdsEqlAce.Post;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmFaturaMensalLocEqu.pCarregarAcessorios]');
      End;
    End;
  Finally
    cdsEqlAce.EnableControls;
  End;
end;

procedure TfrmFaturaMensalLocEqu.pCarregarClienteFiltro;
begin
  pPesquisaCadCli(qryCli, qryCli, edtCodCli.Text);

  If Not fEmptyStr(edtCodCli.Text) Then
    edtNomCli.Text := qryCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtNomCli.Text := 'TODOS';
end;

procedure TfrmFaturaMensalLocEqu.pCarregarContratos;
var
  intCnt: Integer;
  fltValorLocacao: Double;
begin
  pCalcularDataReferencia;

  If fEmptyStr(edtNumCon.Text) And
     fEmptyStr(edtCodCli.Text) And
     fEmptyDate(mskMesVig.Text) And
     (FdataReferencia <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhum filtro foi aplicado, verifique para prosseguir!', ['&O k']);
    Exit;
  End;

  If (FdataReferencia <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe a data de referência para prosseguir!', ['&O k']);
    Exit;
  End;

  If cdsContratos.Active Then
    cdsContratos.EmptyDataSet;

  If cdsEqlDet.Active Then
    cdsEqlDet.EmptyDataSet;

  If cdsEqlAce.Active Then
    cdsEqlAce.EmptyDataSet;

  ObjFaturaMensal.pLimpar;
  If ObjFaturaMensal.fCarregarContratos(edtNumCon.Text, edtCodCli.Text, mskMesVig.Text, FdataReferencia) Then
  Begin
    For intCnt := 0 to ObjFaturaMensal.ListaFatura.Count-1 Do
    Begin
      cdsContratos.Insert;
      cdsContratos.FieldByName('EQL_MARDES').AsString := 'D';
      cdsContratos.FieldByName('EQL_SEQCON').AsString := ObjFaturaMensal.ListaFatura[intCnt].Contrato.AutInc;
      cdsContratos.FieldByName('EQL_NROCON').AsString := ObjFaturaMensal.ListaFatura[intCnt].Contrato.NroContrato;
      cdsContratos.FieldByName('EQL_CODCLI').AsString := ObjFaturaMensal.ListaFatura[intCnt].Contrato.CodCliente;
      cdsContratos.FieldByName('CLI_NOMCLI').AsString := ObjFaturaMensal.ListaFatura[intCnt].Contrato.CodCliente + ' - ' + ObjFaturaMensal.ListaFatura[intCnt].Contrato.NomCliente;
      cdsContratos.FieldByName('DUR_ESTCON').AsString := 'Início: ' + FormatDateTime('dd/mm/yyyy hh:mm', ObjFaturaMensal.ListaFatura[intCnt].Contrato.DataInicialEstimada )  +
                                                         '  Término: ' + FormatDateTime('dd/mm/yyyy hh:mm', ObjFaturaMensal.ListaFatura[intCnt].Contrato.DataFinalEstimada) ;
      cdsContratos.FieldByName('EQL_TOTDIA').AsFloat := ObjFaturaMensal.ListaFatura[intCnt].Contrato.TotalDiasEstimado;
      cdsContratos.FieldByName('EQL_TOTHOR').AsFloat := ObjFaturaMensal.ListaFatura[intCnt].Contrato.TotalHorasEstimadas;
      cdsContratos.FieldByName('EQL_TOTCON').AsFloat := ObjFaturaMensal.ListaFatura[intCnt].Contrato.TotalContrato;
      cdsContratos.FieldByName('EQF_VLJFAT').AsFloat := ObjFaturaMensal.ListaFatura[intCnt].ValorTotalJaFaturado;
      cdsContratos.FieldByName('EQF_VLRFAT').AsFloat := (cdsContratos.FieldByName('EQL_VLRCOB').AsFloat + cdsContratos.FieldByName('EQL_TOTCON').AsFloat) - cdsContratos.FieldByName('EQF_VLJFAT').AsFloat;
      cdsContratos.FieldByName('TOT_DIACAL').AsFloat := ObjFaturaMensal.ListaFatura[intCnt].TotalDiaCal;
      cdsContratos.FieldByName('TOT_HRACAL').AsFloat := ObjFaturaMensal.ListaFatura[intCnt].TotalHorCal;
      fltValorLocacao :=  ObjFaturaMensal.ListaFatura[intCnt].ValorTotalFaturar
                        - ObjFaturaMensal.ListaFatura[intCnt].ValorTotalCobrancaInspecao
                        - IIF(ObjFaturaMensal.ListaFatura[intCnt].objValidaCtr.fContratoPossuiValorFaturado, 0, ObjFaturaMensal.ListaFatura[intCnt].Contrato.ValorTaxaEntrega);
      cdsContratos.FieldByName('VLR_LOCCAL').AsFloat := IIF(fltValorLocacao > 0, fltValorLocacao, 0);
      cdsContratos.FieldByName('EQL_VLRCOB').AsFloat := ObjFaturaMensal.ListaFatura[intCnt].ValorTotalCobrancaInspecao;
      cdsContratos.FieldByName('TOT_VLRCAL').AsFloat := cdsContratos.FieldByName('EQL_VLRCOB').AsFloat
                                                        + cdsContratos.FieldByName('VLR_LOCCAL').AsFloat
                                                        + IIF(ObjFaturaMensal.ListaFatura[intCnt].objValidaCtr.fContratoPossuiValorFaturado, 0, ObjFaturaMensal.ListaFatura[intCnt].Contrato.ValorTaxaEntrega);
      cdsContratos.FieldByName('EQL_TAXENT').AsFloat := IIF(ObjFaturaMensal.ListaFatura[intCnt].objValidaCtr.fContratoPossuiValorFaturado, 0, ObjFaturaMensal.ListaFatura[intCnt].Contrato.ValorTaxaEntrega);
      cdsContratos.FieldByName('EQL_TOTMES').AsInteger := ObjFaturaMensal.ListaFatura[intCnt].Contrato.TotalMesesEstimados;
      cdsContratos.FieldByName('TOT_MESCAL').AsFloat   := ObjFaturaMensal.ListaFatura[intCnt].TotalMesCal;

      pCarregarEquipamentos(ObjFaturaMensal.ListaFatura[intCnt]);

      cdsContratos.Post;
    End;
  End;

  If ObjFaturaMensal.ListaFatura.Count <= 0 Then
    fMensagem('ATENÇÃO!', 'Não há Contratos para faturar!', ['&O k']);
end;

procedure TfrmFaturaMensalLocEqu.pCarregarEquipamentos(const aFatura: TFaturamentoContrato);
var
  intCnt: Integer;
begin
  cdsEqlDet.DisableControls;
  Try
    Try
      For intCnt := 0 to aFatura.ListaItens.Count -1 Do
      Begin
        If aFatura.ListaItens[intCnt].DataEncerramento > 0 Then
          Continue;

        cdsEqlDet.Insert;
        cdsEqlDet.FieldByName('EQD_MARDES').AsString   := 'D';
        cdsEqlDet.FieldByName('EQD_SEQCON').AsString   := aFatura.ListaItens[intCnt].itemContrato.Contrato.AutInc;
        cdsEqlDet.FieldByName('EQD_SEQEQL').AsString   := aFatura.ListaItens[intCnt].itemContrato.Equipamento.Codigo;
        cdsEqlDet.FieldByName('EQD_DESCRI').AsString   := aFatura.ListaItens[intCnt].itemContrato.Equipamento.Descricao;
        cdsEqlDet.FieldByName('EQD_NSERIE').AsString   := aFatura.ListaItens[intCnt].itemContrato.Equipamento.NumSerie;
        cdsEqlDet.FieldByName('TIPO_CONTRATO').AsString:= aFatura.ListaItens[intCnt].itemContrato.StrTipoCalculoLocacao;
        cdsEqlDet.FieldByName('EQD_TIPDUR').AsString   := arrTpCalculoVlLocacao[aFatura.ListaItens[intCnt].itemContrato.TipoCalculoLocacao];
        cdsEqlDet.FieldByName('EQD_TOTEQL').AsFloat    := aFatura.ListaItens[intCnt].ValorLocacaoOriginal;
        cdsEqlDet.FieldByName('EQD_PERDES').AsFloat    := aFatura.ListaItens[intCnt].itemContrato.PercentualDesconto;
        cdsEqlDet.FieldByName('EQD_VLLOCL').AsFloat    := aFatura.ListaItens[intCnt].itemContrato.ValorLocacaoLiquido;
        cdsEqlDet.FieldByName('EQD_TOTLIQ').AsFloat    := aFatura.ListaItens[intCnt].itemContrato.ValorTotalLiquido;
        cdsEqlDet.FieldByName('EQL_VLRCAU').AsFloat    := aFatura.ListaItens[intCnt].itemContrato.Equipamento.ValorCaucao;
        cdsEqlDet.FieldByName('EQD_VLRALT').AsString   := IIF(aFatura.ListaItens[intCnt].itemContrato.blnValorLocacaoAlteradoManualmente, 'S', 'N');
        cdsEqlDet.FieldByName('EQD_DOCENV').AsString   := aFatura.ListaItens[intCnt].itemContrato.strDocEnv;
        cdsEqlDet.FieldByName('EQD_DOCRET').AsString   := aFatura.ListaItens[intCnt].itemContrato.strDocRet;
        cdsEqlDet.FieldByName('EQD_QTDDUR').AsFloat    := aFatura.ListaItens[intCnt].DuracaoLocacao;
        cdsEqlDet.FieldByName('EQF_VLRDSC').AsFloat    := aFatura.ListaItens[intCnt].itemContrato.PercentualDesconto;
        cdsEqlDet.FieldByName('EQF_VLAFAT').AsFloat    := aFatura.ListaItens[intCnt].ValorAFaturar;
        cdsEqlDet.FieldByName('EQF_VLJFAT').AsFloat    := aFatura.ListaItens[intCnt].ValorJaFaturado;
        cdsEqlDet.FieldByName('EQF_VLRFAT').AsFloat    := aFatura.ListaItens[intCnt].ValorRestanteAFaturar;
        cdsEqlDet.FieldByName('EQF_VLRLIQ').AsFloat    := aFatura.ListaItens[intCnt].ValorLiquidoRestante;
        If aFatura.ListaItens[intCnt].DataEncerramento > 0 Then
          cdsEqlDet.FieldByName('EQD_DTAENC').AsDateTime := aFatura.ListaItens[intCnt].DataEncerramento;
        cdsEqlDet.FieldByName('EQD_VALIPE').AsFloat    := aFatura.ListaItens[intCnt].itemContrato.ValorCobranca;
        If aFatura.ListaItens[intCnt].DataEncerramento > 0 Then
          cdsEqlDet.FieldByName('EQD_VALTOT').AsFloat    := aFatura.ListaItens[intCnt].ValorTotal + aFatura.ListaItens[intCnt].itemContrato.ValorCobranca
        Else
          cdsEqlDet.FieldByName('EQD_VALTOT').AsFloat    := aFatura.ListaItens[intCnt].ValorTotal;
        cdsEqlDet.FieldByName('EQD_DTAIPE').AsDateTime := aFatura.ListaItens[intCnt].itemContrato.DataInspecaoEntrada;
        cdsEqlDet.FieldByName('EQD_UTIFXN').AsString   := aFatura.ListaItens[intCnt].itemContrato.strUtiFaixaNegociacao;
        cdsEqlDet.FieldByName('EQD_DTACOB').AsDateTime := aFatura.ListaItens[intCnt].itemContrato.DataInicialCobranca;
        cdsEqlDet.FieldByName('EQD_DTAFCOB').AsDateTime:= aFatura.ListaItens[intCnt].itemContrato.DataFinalCobranca;
        cdsEqlDet.FieldByName('EQD_QTDEQU').AsFloat    := aFatura.ListaItens[intCnt].itemContrato.Quantidade;

        cdsEqlDet.Post;

        pCarregarAcessorios(aFatura.ListaItens[intCnt].itemContrato);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmFaturaMensalLocEqu.pCarregarEquipamentos]');
      End;
    End;
  Finally
    cdsEqlAce.EnableControls;
    cdsEqlDet.EnableControls;
  End;
end;

procedure TfrmFaturaMensalLocEqu.pLimpaContratosDesmarcados;
var
  intRecNo: Integer;
begin
  cdsContratos.DisableControls;
  intRecNo := cdsContratos.RecNo;
  Try
    cdsContratos.First;
    While Not cdsContratos.Eof Do
    Begin
      If cdsContratos.FieldByName('EQL_MARDES').AsString = 'D' Then
        ObjFaturaMensal.fRemoveContrato(cdsContratos.FieldByName('EQL_SEQCON').AsString);

      cdsContratos.Next;
    End;
  Finally
    cdsContratos.RecNo := intRecNo;
    cdsContratos.EnableControls;
  End;
end;

procedure TfrmFaturaMensalLocEqu.pConfirmarFaturamento;
Begin
  pLimpaContratosDesmarcados;

  If ObjFaturaMensal.ListaFatura.Count <= 0 Then
  Begin
    fMensagem('ATENÇÃO', 'Nenhum contrato selecionado.', ['&Ok']);
    Exit;
  End;

  If ((chkAgruparDuplicatas.Checked) and (ObjFaturaMensal.ListaFatura.Count = 1)) Then
  Begin
    fMensagem('ATENÇÃO', 'Foi selecionada operação de agrupamento de duplicatas com apenas um contrato selecionado. Verifique a seleção ou desmarque a operação para agrupamento.', ['&Ok']);
    Exit;
  End;

  If Not ObjFaturaMensal.fValidaPodeEmitirFaturas Then
  Begin
    If Not fEmptyStr(ObjFaturaMensal.MensagemRetorno) Then
      fMensagem('ATENÇÃO', ObjFaturaMensal.MensagemRetorno, ['&Ok']) ;

    Exit;
  End;

  pEmitirFaturas;

End;

procedure TfrmFaturaMensalLocEqu.pEmitirFaturas;
Var
  frmDupFatLocEqlMensal: TfrmDupFatLocEqlMensal;
begin
  pCriarFormularios(TfrmDupFatLocEqlMensal, frmDupFatLocEqlMensal);
  Try
    If ObjFaturaMensal.fEmitirFaturas(chkImpBoleto.Checked, chkAgruparDuplicatas.Checked) Then
    Begin
      fMensagem('ATENÇÃO', 'Processo finalizado com sucesso.', ['&Ok']) ;
      frmDupFatLocEqlMensal.ObjFaturaMensal := ObjFaturaMensal;
      frmDupFatLocEqlMensal.ShowModal;
      pLimparCampos;
    End
    Else
    Begin
      If Not fEmptyStr(ObjFaturaMensal.MensagemRetorno) Then
        fMensagem('ATENÇÃO', ObjFaturaMensal.MensagemRetorno, ['&Ok']) ;
    End;
  Finally
    pFreeAndNil(frmDupFatLocEqlMensal);
  End;
end;

procedure TfrmFaturaMensalLocEqu.pFormatarCampos;
begin
  TFloatField(cdsContratos.FieldByName('EQL_TOTHOR')).DisplayFormat := '#,##0.00';
  TFloatField(cdsContratos.FieldByName('EQF_VLJFAT')).DisplayFormat := '#,##0.00';
  TFloatField(cdsContratos.FieldByName('EQL_TOTCON')).DisplayFormat := '#,##0.00';
  TFloatField(cdsContratos.FieldByName('EQF_VLJFAT')).DisplayFormat := '#,##0.00';
  TFloatField(cdsContratos.FieldByName('EQF_VLRFAT')).DisplayFormat := '#,##0.00';
  TFloatField(cdsContratos.FieldByName('TOT_DIACAL')).DisplayFormat := '#,##0.00';
  TFloatField(cdsContratos.FieldByName('TOT_HRACAL')).DisplayFormat := '#,##0.00';
  TFloatField(cdsContratos.FieldByName('VLR_LOCCAL')).DisplayFormat := FstrLocDec;
  TFloatField(cdsContratos.FieldByName('EQL_VLRCOB')).DisplayFormat := '#,##0.00';
  TFloatField(cdsContratos.FieldByName('TOT_VLRCAL')).DisplayFormat := '#,##0.00';
  TFloatField(cdsContratos.FieldByName('EQL_TOTDIA')).DisplayFormat := '#,##0.00';
  TFloatField(cdsContratos.FieldByName('EQL_TAXENT')).DisplayFormat := '#,##0.00';

  TFloatField(cdsEqlDet.FieldByName('EQD_VALHOR')).DisplayFormat := FstrLocDec;
  TFloatField(cdsEqlDet.FieldByName('EQD_TOTEQL')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQD_PERDES')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQD_VLLOCL')).DisplayFormat := FstrLocDec;
  TFloatField(cdsEqlDet.FieldByName('EQD_TOTLIQ')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQL_VLRCAU')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQD_QTDDUR')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQF_VLRDSC')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQF_VLAFAT')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQF_VLJFAT')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQF_VLRFAT')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQF_VLRLIQ')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQD_VALIPE')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQD_VALTOT')).DisplayFormat := '#,##0.00';

  TFloatField(cdsEqlAce.FieldByName('EQA_VLRCOB')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlAce.FieldByName('EQA_VLRADC')).DisplayFormat := '#,##0.00';
end;

procedure TfrmFaturaMensalLocEqu.pLimparCampos;
begin
  mskDtaReferencia.Text := FormatDateTime('dd/mm/yyyy', fNow);
  edtHorReferencia.Text := FormatDateTime('hh:mm', fNow);

  ObjContratoFiltro.pLimpar;
  ObjFaturaMensal.pLimpar;

  If cdsContratos.Active Then
    cdsContratos.EmptyDataSet;

  If cdsEqlDet.Active Then
    cdsEqlDet.EmptyDataSet;

  If cdsEqlAce.Active Then
    cdsEqlAce.EmptyDataSet;
end;

procedure TfrmFaturaMensalLocEqu.pMarcarContrato(const blnMarcar: Boolean);
begin
  Try
    cdsContratos.Edit;
    cdsContratos.FieldByName('EQL_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
    cdsContratos.Post;

    If blnMarcar Then
      ObjFaturaMensal.fAddContrato(cdsContratos.FieldByName('EQL_SEQCON').AsString)
    Else
      ObjFaturaMensal.fRemoveContrato(cdsContratos.FieldByName('EQL_SEQCON').AsString);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmFaturaMensalLocEqu.pMarcarContrato]');
    End;
  End;
end;

procedure TfrmFaturaMensalLocEqu.pMarcarTodos(const blnMarcar: Boolean);
var
  intRecNo: Integer;
begin
  cdsContratos.DisableControls;
  intRecNo := cdsContratos.RecNo;
  Try
    Try
      cdsContratos.First;
      While Not cdsContratos.Eof Do
      Begin
        cdsContratos.Edit;
        cdsContratos.FieldByName('EQL_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
        cdsContratos.Post;

        pMarcarContrato(blnMarcar);

        cdsContratos.Next;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmFaturaMensalLocEqu.pMarcarTodos]');
      End;
    End;
  Finally
    cdsContratos.RecNo := intRecNo;
    cdsContratos.EnableControls;
  End;
end;

end.
