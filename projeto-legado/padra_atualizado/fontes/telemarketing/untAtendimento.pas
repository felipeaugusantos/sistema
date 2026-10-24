unit untAtendimento;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, untPai, Menus, StdCtrls, Buttons,
  ExtCtrls, EditFocus, Grids, DBGridCitel, DBGrids, DB, UniClientDataSet, UniDataSetProvider,Uni,
  MaskEditFocus, AppEvnts, DBCtrls, DBMemoFocus, MemoFocus, BitBtnLockedIncrem,
  MemDS, DBAccess, Provider, Mask, frxClass, frxExportCSVTestabilidade, untCfgGrid,
  Datasnap.DBClient, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Vcl.ComCtrls,
  untTypesSistema;

type
  TfrmAtendimento = class(TfrmPai)
    Panel1: TPanel;
    lblTitulo: TLabel;
    edtCodVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    qryConsulta: TUniQuery;
    dspConsulta: TUniDataSetProvider;
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;
    Label5: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label6: TLabel;
    mskDtaFin: TMaskEditFocus;
    Splitter: TSplitter;
    Panel4: TPanel;
    lblLegenda: TLabel;
    shpLegenda: TShape;
    btnBaixar: TBitBtnLocked;
    btnRelatorio: TBitBtnLocked;
    btnAcompEntrega: TBitBtnLocked;
    btnVenCli: TBitBtnLocked;
    btnNiverDia: TBitBtnLocked;
    btnResFin: TBitBtnLocked;
    btnInsAten: TBitBtnLocked;
    btnCadCli: TBitBtnLocked;
    btnOrcVen: TBitBtnLocked;
    btnPedVen: TBitBtnLocked;
    popOrcamento: TPopupMenu;
    mnuFatOrcamento: TMenuItem;
    popPedido: TPopupMenu;
    mnuFatPedido: TMenuItem;
    btnInfLigacao: TBitBtnLocked;
    dbgAtendimento: TcxGridCitel;
    dbgAtendimentoDBView: TcxGridDBTableViewCitel;
    cxGridAtendimentoCLI_CODCLI: TcxGridDBColumn;
    cxGridAtendimentoCLI_NOMCLI: TcxGridDBColumn;
    cxGridAtendimentoCLI_FANSOB: TcxGridDBColumn;
    cxGridAtendimentoATI_DESATI: TcxGridDBColumn;
    cxGridAtendimentoCLI_C_G_C_: TcxGridDBColumn;
    cxGridAtendimentoCLI_FONE01: TcxGridDBColumn;
    cxGridAtendimentoAGE_DTAAGE: TcxGridDBColumn;
    cxGridAtendimentoCLI_CONTAT: TcxGridDBColumn;
    cxGridAtendimentoCID_NOMCID: TcxGridDBColumn;
    cxGridAtendimentoCID_ESTADO: TcxGridDBColumn;
    cxGridAtendimentoAGE_DTABAI: TcxGridDBColumn;
    cxGridAtendimentoCLI_EMAIL_: TcxGridDBColumn;
    dbgAtendimentoPrimeiroNivel: TcxGridLevel;
    cxGridAtendimentoORCAME: TcxGridDBColumn;
    pgcObservacoes: TPageControl;
    tbsObsCliente: TTabSheet;
    tbsObsCredito: TTabSheet;
    tbsHistLigacoes: TTabSheet;
    pnlObsCli: TPanel;
    dbmObsCli: TDBMemoFocus;
    Panel2: TPanel;
    pnlObsCre: TPanel;
    dbmObsCre: TDBMemoFocus;
    Panel5: TPanel;
    pnlUltLig: TPanel;
    Panel3: TPanel;
    memHisLig: TMemoFocus;
    Panel6: TPanel;
    pnlConfigColun: TPanel;
    btnCfgGri: TBitBtnLocked;
    cxGridAtendimentoREG_DESREG: TcxGridDBColumn;
    cxGridAtendimentoSUB_DESSUB: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure dbgAgendamentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cdsConsultaAfterInsert(DataSet: TDataSet);
    procedure btnBaixarClick(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
    procedure ApplicationEventsException(Sender: TObject; E: Exception);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure btnAcompEntregaClick(Sender: TObject);
    procedure btnVenCliClick(Sender: TObject);
    procedure btnNiverDiaClick(Sender: TObject);
    procedure btnResFinClick(Sender: TObject);
    procedure btnInsAtenClick(Sender: TObject);
    procedure btnCadCliClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnOrcVenClick(Sender: TObject);
    procedure btnPedVenClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure dbgAtendimentoDBViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure pgcObservacoesChange(Sender: TObject);
    procedure btnCfgGriClick(Sender: TObject);
  private
    { Private declarations }
    qryAuxOpe: TUniQuery;
    regCliCon: TRegistroConsumidor;
    strVenRep: String;
    objCfgGridAtendimento: TCfgGrid;

    function fAbreConsulta(blnWhereFalse: Boolean = False): Boolean;
    procedure pCarregaVendedor;
    procedure pVendRepr;
    procedure pPreencheHisLig;
    procedure pCarregaDadosConsumidor(strAutoIn: String);
    function fExisteCliente(strCodCli: String): Boolean;
    function fInsereAgeTel(strCodCli: string): String;
  public
    { Public declarations }
    strCodVen: String;
    strCodCli: String;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;


implementation

uses Graphics, StrUtils, untFuncoesGenerica, untFuncoesSimples, untPesqAux,
  untBaixaAgenda, untConsultaPedidos, untFuncoesRel,
  untResFinanceiro, untDigCliente,
  untFuncoesRel2, TypesRel, untCadClientes, untPrincipal, untRelFatVendasCliente;

{$R *.dfm}

function TfrmAtendimento.fExisteCliente(strCodCli: String): Boolean;
  Var
    strIndex : String;
    intRecNum : Integer;
begin
  Result := False;

  If fClienteConsumidor(fRetNomCliente(strCodCli)) Then
    Exit;

  strIndex := cdsConsulta.IndexFieldNames;
  intRecNum := cdsConsulta.RecNo;
  cdsConsulta.IndexFieldNames := 'CLI_CODCLI';
  Try
    cdsConsulta.DisableControls;
    If cdsConsulta.FindKey([strCodCli]) Then
    Begin
      Result := True;
      fMensagem('ATENÇÃO!', 'Este cliente já está listado na lista de atendimentos. Não será permitido incluí-lo novamente!', ['&OK']);
    End;
  Finally
    cdsConsulta.IndexFieldNames := strIndex;
    cdsConsulta.RecNo := intRecNum;
    cdsConsulta.EnableControls;
  End;
end;

function TfrmAtendimento.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtCodVendedor) Then
    Begin

      If fEmptyStr(edtCodVendedor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O ' + strVenRep + ' deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaVendedor;
        If qryAuxOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse ' + strVenRep + ' não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = mskDtaIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
      End

      Else If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!','A data inicial deve ser menor que a data final!',['&O K']);
        Result := False;
      End

      Else fAbreConsulta();

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmAtendimento.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodVendedor);
end;

procedure TfrmAtendimento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  try
    fGetFuncoesCxGrid.pSalvarView(dbgAtendimentoDBView, Self.Name, cdsConsulta);
  finally
    cdsConsulta.Close;
  end;
end;

function TfrmAtendimento.fAbreConsulta(blnWhereFalse: Boolean = False): Boolean;
Begin
  Try
    With qryConsulta, Sql Do
    Begin
      Close;
      cdsConsulta.Close;
      Clear;

      Add('SELECT                                      ');
      Add('  AGETEL.AUTOINCREM,                        ');
      Add('  CLI_CODCLI,                               ');
      Add('  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", CON_NOMCON, CLI_NOMCLI) AS CLI_NOMCLI, ');
      Add('  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", "",         CLI_FANSOB) AS CLI_FANSOB, ');
      Add('  CADATI.ATI_DESATI, ');
      Add('  IF (LENGTH(CADCLI.CLI_C_G_C_) <= 11, CONCAT("", SUBSTRING(CADCLI.CLI_C_G_C_,1,3),".", ');
      Add('                                                  SUBSTRING(CADCLI.CLI_C_G_C_,4,3),".", ');
      Add('                                                  SUBSTRING(CADCLI.CLI_C_G_C_,7,3),"-", ');
      Add('                                                  SUBSTRING(CADCLI.CLI_C_G_C_,10,2)),   ');
      Add('  IF (LENGTH(CADCLI.CLI_C_G_C_) > 11, CONCAT("", SUBSTRING(CADCLI.CLI_C_G_C_,1,2),".", ');
      Add('                                  		        		SUBSTRING(CADCLI.CLI_C_G_C_,3,3),".", ');
      Add('                              				        		SUBSTRING(CADCLI.CLI_C_G_C_,6,3),"/", ');
      Add('                               						      SUBSTRING(CADCLI.CLI_C_G_C_,9,4),"-", ');
      Add('                               						      SUBSTRING(CADCLI.CLI_C_G_C_,13,2)),CLI_C_G_C_)) AS CLI_C_G_C_, ');
      Add('  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", CON_TELCON, CLI_FONE01) AS CLI_FONE01, ');
      Add('  AGE_DTAAGE,                               ');
      Add('  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", "",         CLI_CONTAT) AS CLI_CONTAT, ');
      Add('  CID_NOMCID,                               ');
      Add('  CID_ESTADO,                               ');
      Add('  IF((CLI_BAIRRO IS NULL) OR (CLI_BAIRRO = "")," ", CLI_BAIRRO) AS CLI_BAIRRO,     ');
      Add('  IF((REG_DESREG IS NULL) OR (REG_DESREG = "")," ", REG_DESREG) AS REG_DESREG,     ');
      Add('  IF((SUB_DESSUB IS NULL) OR (SUB_DESSUB = "")," ", SUB_DESSUB) AS SUB_DESSUB,     ');
      Add('  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", "",         CLI_OBSERV) AS CLI_OBSERV, ');
      Add('  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", "",         CLI_OBSCON) AS CLI_OBSCON, ');
      Add('  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", CON_EMLCON, CLI_EMAIL_) AS CLI_EMAIL_, ');
      Add('  IF( (SELECT COUNT(*) FROM FATGOR WHERE FGO_CODCLI = CLI_CODCLI AND FGO_JAFATU = 0) <= 0, "N", "S") AS ORCAME, ');
      Add('DATE_FORMAT((SELECT                         ');
      Add('   MAX(A.AGE_DTABAI)                        ');
      Add(' FROM                                       ');
      Add('   AGETEL AS A                              ');
      Add(' WHERE                                      ');
      Add('   CLI_CODCLI = A.AGE_CODCLI AND            ');
      Add('   A.AGE_CODEMP = :CODEMP    AND            ');
      Add('   A.AGE_DTABAI IS NOT NULL),               ');
      Add('           "%d/%m/%Y") AS AGE_DTABAI        ');

      Add('FROM                                        ');
      Add('  AGETEL                                    ');
      Add('LEFT JOIN CONAGE ON AGETEL.AUTOINCREM = CON_SEQGER ');
      Add('LEFT JOIN CADCLI ON CLI_CODCLI = AGE_CODCLI ');
      Add('LEFT JOIN CADCID ON IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", CON_CODCID, CLI_CODCID) = CID_CODCID ');
      Add('LEFT JOIN CADATI ON CLI_CODATI = ATI_CODATI ');
      Add('LEFT JOIN CADREG ON CLI_CODREG = REG_CODREG ');
      Add('LEFT JOIN CADSUB ON CLI_CODSUB = SUB_CODSUB ');
      Add('WHERE                                       ');

      if blnWhereFalse then
      begin
        Add(' FALSE                                    ');
      end
      else
      begin
        Add('  AGE_DTABAI IS NULL   AND                ');
        Add('  AGE_CODVEN = :CODVEN AND                ');
        Add('  AGE_CODEMP = :CODEMP AND                ');

        If Not fEmptyStr(strCodCli) Then
          Add('  AGE_CODCLI = :CODCLI AND              ');

        Add('  AGE_DTAAGE BETWEEN :DTAINI AND :DTAFIN  ');
        Add(' ORDER BY CADCLI.CLI_NOMCLI ');

        ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODVEN').AsString := strCodVen;

        If Not fEmptyStr(strCodCli) Then
          ParamByName('CODCLI').AsString := strCodCli;
      end;

      Open;
      cdsConsulta.Open;
      Result := True;
    End;

  Except
    Result := False;
  End;
End;

procedure TfrmAtendimento.pVendRepr;
begin
  {**********************************}
  { VERIFICA SE PEDE CÓDIGO OU SENHA }
  {*******************************RV*}
  If (fCfgSis('ATESEN') = 'C') Then
  Begin
    edtCodVendedor.PasswordChar := #0;
    edtCodVendedor.MaxLength    := 3;
  End
  Else
  Begin
    edtCodVendedor.PasswordChar := '*';
    edtCodVendedor.MaxLength    := 10;
  End;
  strCodVen := '';
  {**********************************}
  { VENDEDOR OU REPRESENTANTE        }
  {*******************************RV*}
  If (fCfgSis('TELVRP') = '1') Then
  Begin
    strVenRep         := 'Vendedor';
    lblTitulo.Caption := 'Vendedor:';
  End
  Else
  Begin
    strVenRep         := 'Representante';
    lblTitulo.Caption := 'Representante:';
  End;
end;

procedure TfrmAtendimento.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  Case Key Of
    VK_F2    : If Shift = [ssAlt] then
                 btnCadCli.Click;
    VK_F3    : If Shift = [ssAlt] then
                 btnOrcVen.Click;
    VK_F5    : If Shift = [ssAlt] then
                 btnPedVen.Click;
    VK_F6    : btnResFin.Click;
    VK_F7    : btnVenCli.Click;
    VK_F9    : btnRelatorio.Click;
    VK_F10   : btnAcompEntrega.Click;
    VK_F12   : btnNiverDia.Click;
    VK_RETURN: If (Not cdsConsulta.IsEmpty) And
                  (ActiveControl <> edtCodVendedor) And
                  (ActiveControl <> mskDtaIni) And
                  (ActiveControl <> mskDtaFin) Then
                 btnBaixar.Click
               Else
                 inherited;
    VK_ESCAPE: inherited;
    VK_INSERT: btnInsAten.Click;
    Else       inherited;
  End;

end;

procedure TfrmAtendimento.FormResize(Sender: TObject);
begin
  inherited;
  btnSair.Left := btnNiverDia.Left + btnNiverDia.Width;
end;

procedure TfrmAtendimento.FormCreate(Sender: TObject);
begin
  inherited;
  objCfgGridAtendimento := TCfgGrid.Create(Self, dbgAtendimentoDBView, 'Atendimentos', [], '', False, False);

  pVendRepr;
  strCodCli := '';
end;

procedure TfrmAtendimento.dbgAtendimentoDBViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridATendimentoORCAME.Index] = 'S') Then
    ACanvas.Font.Color := clBlue;

  If (AViewInfo.GridRecord.Selected) Then
  Begin
    If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridATendimentoORCAME.Index] = 'S') Then
      ACanvas.Font.Color := clLime
    Else
      ACanvas.Font.Color := clWhite;
    ACanvas.Brush.Color := clNavy;
  End;

end;

procedure TfrmAtendimento.dbgAgendamentoKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key = VK_Escape Then
  Begin
    inherited;
    If cdsConsulta.Active Then
    Begin
      pSetFocus(edtCodVendedor);
      Exit;
    End;
    Close;
  End;

end;

procedure TfrmAtendimento.btnPedVenClick(Sender: TObject);
begin
  inherited;
  If fVerificaAcessoSistema('frmFatVendas - PD', strLoginUsuarioLogado) Then
  Begin
    popPedido.Items[0].Hint := 'frmFatVendas - PD';
    frmPrincipal.mnuFatTrocaMercClick(popPedido.Items[0]);
  End
  Else
    fMensagem('Informação !','Usuário sem direito de acesso para fazer um Pedido !',['&Ok'])
end;

procedure TfrmAtendimento.FormShow(Sender: TObject);
var
  intRecNo : Integer;
begin
  inherited;
  qryAuxOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  If (Not fVerificaAcessoSistema('OBSCRD', strLoginUsuarioLogado)) Then
  Begin
    tbsObsCredito.TabVisible := False;
    tbsHistLigacoes.Caption := '2-Histórico de Ligações';
  End
  Else
  Begin
    tbsObsCredito.TabVisible := True;
    tbsHistLigacoes.Caption := '3-Histórico de Ligações';
  End;

  pgcObservacoes.ActivePageIndex := 0;

  try
    fAbreConsulta(True);

    if cdsConsulta.Fields.Count <> 0 then
    begin
      intRecNo := cdsConsulta.RecNo;
      fGetFuncoesCxGrid.fCarregarView(dbgAtendimentoDBView, Self.Name, cdsConsulta, intRecNo);
    end;
  except on E: Exception do
  end;
end;

procedure TfrmAtendimento.pCarregaDadosConsumidor(strAutoIn: String);
  Var
    qryCadCli: TUniQuery;
Begin
  qryCadCli := fCriaQuery(Self);
  With regCliCon, qryCadCli Do
  Begin
    Close;
    SQL.Add('SELECT                ');
    SQL.Add(' *                    ');
    SQL.Add('FROM                  ');
    SQL.Add(' CONAGE               ');
    SQL.Add('WHERE                 ');
    SQL.Add(' CON_SEQGER = :SEQGER ');
    ParamByName('SEQGER').AsString := strAutoIn;
    Open;

    strCliEnd := FieldByName('CON_ENDCON').AsString;  // - Endereco
    strCliBai := FieldByName('CON_BAICON').AsString;  // - Bairro
    strCliCep := FieldByName('CON_CEPCON').AsString;  // - Cep
    strCodCid := FieldByName('CON_CODCID').AsString;  // - Cód. Cidade
    strCliTel := FieldByName('CON_TELCON').AsString;  // - Telefone
    strCliCid := fRetNomCidade(strCodCid);            // - Cidade
    strCliEst := fRetNomCidade(strCodCid, 1);         // - Estado

    strCliNom := FieldByName('CON_NOMCON').AsString;  // - Nome
    strCliCgc := FieldByName('CON_CGCCON').AsString;  // - CNPJ
    strCliIes := FieldByName('CON_IESCON').AsString;  // - Ins.Estadual
    strCli_Rg := FieldByName('CON_RG_CON').AsString;  // - RG
    intCgcCpf := FieldByName('CON_CGCCPF').AsInteger;
    strCliEml := FieldByName('CON_EMLCON').AsString;  // - E-mail
    strCodReg := FieldByName('CON_CODREG').AsString;  // - Código da Região

  End;
  FreeAndNil(qryCadCli);
end;

procedure TfrmAtendimento.pCarregaVendedor;
begin
  pPesquisaCadOpe(qryAuxOpe, qryAuxOpe, edtCodVendedor.Text, IIF(fCfgSis('ATESEN') = 'S', True, False));
  With qryAuxOpe Do
  Begin
    edtDesVendedor.Text := FieldByName('OPE_NOMOPE').AsString;
    strCodVen           := FieldByName('OPE_CODOPE').AsString;
  End;
end;

procedure TfrmAtendimento.pgcObservacoesChange(Sender: TObject);
begin
  inherited;

  If (memHisLig.CanFocus) Then
  Begin
    memHisLig.Clear;
    pPreencheHisLig;
  End;

end;

procedure TfrmAtendimento.btnOrcVenClick(Sender: TObject);
  Var
    LrecReabrirForm : TReabrirForm;
    LstrOpcDoc,
    LstrCodCli : String;
begin
  inherited;
  If fVerificaAcessoSistema('frmFatVendas - OR', strLoginUsuarioLogado) Then
  Begin
    FillChar(LrecReabrirForm, SizeOf(LrecReabrirForm), #0);
    LstrOpcDoc := 'OR';
    LstrCodCli := EmptyStr;

    If (Not cdsConsulta.IsEmpty) Then
      LstrCodCli := cdsConsulta.FieldByName('CLI_CODCLI').AsString;

    frmPrincipal.pMenuFaturamentoClick(mnuFatOrcamento, LrecReabrirForm, LstrOpcDoc, LstrCodCli, True);
  End
  Else
    fMensagem('Informação !','Usuário sem direito de acesso para fazer um Orçamento !',['&Ok'])
end;

procedure TfrmAtendimento.cdsConsultaAfterInsert(DataSet: TDataSet);
begin
  inherited;
  DataSet.Cancel;
end;

procedure TfrmAtendimento.btnBaixarClick(Sender: TObject);
begin
  inherited;
  If cdsConsulta.IsEmpty Then
    Exit;

  pCarregaDadosConsumidor(cdsConsulta.FieldByName('AUTOINCREM').AsString);
  Try
    pCriarFormularios(TfrmBaixaAgenda, frmBaixaAgenda);

    frmBaixaAgenda.frmAtendimento := Self;

    frmBaixaAgenda.regConsum.strCliNom := regCliCon.strCliNom;  // - Nome
    frmBaixaAgenda.regConsum.strCliEnd := regCliCon.strCliEnd;  // - Endereco
    frmBaixaAgenda.regConsum.strCliBai := regCliCon.strCliBai;  // - Bairro
    frmBaixaAgenda.regConsum.strCliCep := regCliCon.strCliCep;  // - Cep
    frmBaixaAgenda.regConsum.strCodCid := regCliCon.strCodCid;  // - Cod. Cidade
    frmBaixaAgenda.regConsum.strCliCid := regCliCon.strCliCid;  // - Cidade
    frmBaixaAgenda.regConsum.strCliEst := regCliCon.strCliEst;  // - Estado
    frmBaixaAgenda.regConsum.strCliTel := regCliCon.strCliTel;  // - Telefone
    frmBaixaAgenda.regConsum.strCliCgc := regCliCon.strCliCgc;  // - CNPJ
    frmBaixaAgenda.regConsum.intCgcCpf := regCliCon.intCgcCpf;  // - CGC/CPF
    frmBaixaAgenda.regConsum.strCliIes := regCliCon.strCliIes;  // - Ins.Estadual
    frmBaixaAgenda.regConsum.strCli_Rg := regCliCon.strCli_Rg;  // - Rg
    frmBaixaAgenda.regConsum.strCliEml := regCliCon.strCliEml;  // - E-mail
    frmBaixaAgenda.regConsum.strCodReg := regCliCon.strCodReg;  // - Código da Região

    frmBaixaAgenda.blnHisAte := (TBitBtnLocked(Sender).Tag = 1);

    If frmBaixaAgenda.ShowModal = mrOk Then
      fAbreConsulta();

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmAtendimento.btnBaixarClick]');
    End;
  End;
  pFreeAndNil(frmBaixaAgenda);
end;

procedure TfrmAtendimento.btnCadCliClick(Sender: TObject);
var
  strCodCli: string;
begin
  inherited;
  strCodCli := '';

  If fVerificaAcessoSistema('frmCadClientes', strLoginUsuarioLogado) Then
  Begin
    Try
      pCriarFormularios(TfrmCadClientes, frmCadClientes);

      if (cdsConsulta.Active) and (cdsConsulta.FieldByName('CLI_CODCLI') <> nil) then
      begin
        strCodCli := cdsConsulta.FieldByName('CLI_CODCLI').AsString;

        if not fEmptyStr(strCodCli) then
          frmCadClientes.strCodClienteIniciarCadastro := strCodCli;
      end;

      frmCadClientes.ShowModal;

    Finally
      pFreeAndNil(frmCadClientes);
    End;
  End
  Else
    fMensagem('','Sem permissão para Cadastro de Clientes!',['&Ok']);

end;

procedure TfrmAtendimento.btnCfgGriClick(Sender: TObject);
begin
  inherited;
  objCfgGridAtendimento.pConfiguraColunas;
end;

procedure TfrmAtendimento.btnRelatorioClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaAcessoSistema('frmRelTelListaAtendimento') Then
  Begin
    fMensagem('', 'Esse operador não tem direito de exibir esse relatorio.', ['&Ok']);
    Exit;
  End;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(68, 5170, [5172,5173],
                        ['DTAINI','DTAFIN','CODVEN','CODEMP','CODCLI'],
                        [mskDtaIni.Text,
                        mskDtaFin.Text,
                        strCodVen,
                        VS_STRCODEMP,
                        strCodCli],
                        Sender,
                        ['CODVEN'],
                        False);
  End;

end;

procedure TfrmAtendimento.btnResFinClick(Sender: TObject);
begin
  inherited;
  If Not cdsConsulta.IsEmpty Then
  Begin
    Try
      pCriarFormularios(TfrmResFinanceiro,frmResFinanceiro);
      frmResFinanceiro.strCodCli := cdsConsulta.FieldByName('CLI_CODCLI').AsString;
      frmResFinanceiro.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
    pFreeAndNil(frmResFinanceiro);
  End;
end;

procedure TfrmAtendimento.ApplicationEventsException(Sender: TObject;
  E: Exception);
begin
  inherited;

  If Pos(Uppercase('is not a valid date'),Uppercase(E.Message)) > 0 Then
    fMensagem('', 'Data inválida.', ['&O k']);

end;

procedure TfrmAtendimento.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;

  If (memHisLig.CanFocus) Then
  Begin
    memHisLig.Clear;
    pPreencheHisLig;
  End;

end;

procedure TfrmAtendimento.btnAcompEntregaClick(Sender: TObject);
  Var
    frmConsultaPedidos : TfrmConsultaPedidos;
begin
  inherited;
  Try
    pCriarFormularios(TfrmConsultaPedidos, frmConsultaPedidos);

    If Not cdsConsulta.IsEmpty Then
    Begin
      frmConsultaPedidos.edtCodCli.Text := cdsConsulta.FieldByName('CLI_CODCLI').AsString;
      frmConsultaPedidos.edtNomCli.Text := cdsConsulta.FieldByName('CLI_NOMCLI').AsString;
    End;

    frmConsultaPedidos.ShowModal;
  Finally
    FreeAndNil(frmConsultaPedidos);
  End;
end;

procedure TfrmAtendimento.btnVenCliClick(Sender: TObject);
begin
  inherited;

  If Not cdsConsulta.IsEmpty Then
  Begin
    Try
      pCriarFormularios(TfrmRelFatVendasCliente,frmRelFatVendasCliente);
      frmRelFatVendasCliente.blnFaturamento         := true;
      frmRelFatVendasCliente.blnSenha               := False;
      frmRelFatVendasCliente.blnVeioDoTelemarketing := true;
      frmRelFatVendasCliente.blnVeioDoTablet        := false;
      frmRelFatVendasCliente.edtCodCliente.Text     := cdsConsulta.FieldByName('CLI_CODCLI').AsString;
      frmRelFatVendasCliente.edtDesCliente.Text     := cdsConsulta.FieldByName('CLI_NOMCLI').AsString;
      frmRelFatVendasCliente.blnSomenteVendas       := true;
      frmRelFatVendasCliente.blnVeioTelaVendas      := false;

      If Not fClienteConsumidor(cdsConsulta.FieldByName('CLI_NOMCLI').AsString, False, True) Then
      Begin
        frmRelFatVendasCliente.blnCliCons := False;
      End
      Else
      Begin
        frmRelFatVendasCliente.blnCliCons := True;
      End;

      frmRelFatVendasCliente.ShowModal;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[btnVenCliClick]');
      End;
    End;

    pFreeAndNil(frmRelFatVendasCliente);
  End;
end;

function TfrmAtendimento.fInsereAgeTel(strCodCli: string):String;
  Var
    qryInsert : TUniQuery;
    strAutoIn : String;
begin
  Result := EmptyStr;
  qryInsert := fCriaQuery(Self);
  Try
    With qryInsert, SQL Do
    Begin
      Close;
      Clear;

      Add('INSERT INTO AGETEL                                                                               ');
      Add('(AUTOINCREM, AGE_CODEMP, AGE_CODVEN, AGE_CODCLI, AGE_DTAAGE, AGE_DTABAI, AGE_HORBAI, AGE_OBSERV) ');
      Add('VALUES                                                                                           ');
      Add('(:AUTOIN, :CODEMP, :CODVEN, :CODCLI, :DTAAGE, NULL, NULL, NULL)                                  ');

      strAutoIn := fRetAutoIncrem('AGETEL', VS_strCodEmp);

      ParamByName('AUTOIN').AsString := strAutoIn;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODVEN').AsString := strCodVen;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('DTAAGE').AsDate   := VS_Date;

      ExecSQL;
    End;

    Result := strAutoIn;
  Finally
    FreeAndNil(qryInsert);
  End;
end;

procedure TfrmAtendimento.btnInsAtenClick(Sender: TObject);
  Var
    qryInsert: TUniQuery;
    strAutoIn: String;
    frmDigCliente: TfrmDigCliente;
    IntCont: Integer;
begin
  inherited;
  If Not cdsConsulta.Active Or fEmptyStr(strCodVen) Then
    Exit;

  Try
    pCriarFormularios(TfrmDigCliente, frmDigCliente);
    frmDigCliente.blnTravaInativo := False;
    frmDigCliente.strOpcDoc := 'AT';

    frmDigCliente.edtCodCli.Text := strCodCli;
    frmDigCliente.edtNomCli.Text := fRetNomCliente(strCodCli);

    If frmDigCliente.ShowModal = mrOk Then
    Begin
      If (Length(frmDigCliente.arrClientes) > 1) Then
      Begin
        For IntCont := 0 To Pred(Length(frmDigCliente.arrClientes)) Do
        Begin
          If Not fExisteCliente(frmDigCliente.arrClientes[IntCont].strCodigo) Then
          Begin
            fInsereAgeTel(frmDigCliente.arrClientes[IntCont].strCodigo);
          End;
        End;
      End
      Else
      Begin
        If Not fExisteCliente(frmDigCliente.edtCodCli.Text) Then
        Begin
          With regCliCon Do
          Begin
            strCliNom := frmDigCliente.regConsum.strCliNom; // - Nome
            strCliEnd := frmDigCliente.regConsum.strCliEnd; // - Endereco
            strCliBai := frmDigCliente.regConsum.strCliBai; // - Bairro
            strCliCep := frmDigCliente.regConsum.strCliCep; // - Cep
            strCodCid := frmDigCliente.regConsum.strCodCid; // - Cód. Cidade
            strCliCid := frmDigCliente.regConsum.strCliCid; // - Cidade
            strCliEst := frmDigCliente.regConsum.strCliEst; // - Estado
            strCliTel := frmDigCliente.regConsum.strCliTel; // - Telefone
            strCliCgc := frmDigCliente.regConsum.strCliCgc; // - CNPJ
            strCli_Rg := frmDigCliente.regConsum.strCli_Rg; // - RG
            strCliIes := frmDigCliente.regConsum.strCliIes; // - Ins.Estadual
            strCliEml := frmDigCliente.regConsum.strCliEml; // - E-mail
            intCgcCpf := frmDigCliente.regConsum.intCgcCpf;
            strCodReg := frmDigCliente.regConsum.strCodReg; // - Código da Região
          End;

          qryInsert := fCriaQuery(Self);

          With qryInsert, SQL Do
          Begin
            strAutoIn := fInsereAgeTel(frmDigCliente.edtCodCli.Text);

            {*****************************}
            {* GRAVA DADOS DO CONSUMIDOR *}
            {**************************RV*}
            If (regCliCon.strCliNom <> '') Then
            Begin
              Close;
              Clear;

              Add('INSERT INTO CONAGE                                                       ');
              Add('(AUTOINCREM, CON_CODEMP, CON_NOMCON, CON_ENDCON, CON_BAICON, CON_CEPCON, CON_RG_CON, ');
              Add(' CON_CODCID, CON_TELCON, CON_CGCCPF, CON_CGCCON, CON_IESCON, CON_EMLCON, CON_SEQGER, CON_CODREG) ');
              Add('VALUES                                                                   ');
              Add('(:AUTOIN, :CODEMP, :NOMCON, :ENDCON, :BAICON, :CEPCON, :RG_CON,          ');
              Add(' :CODCID, :TELCON, :CGCCPF, :CGCCON, :IESCON, :EMLCON, :SEQGER, :CODREG) ');

              ParamByName('AUTOIN').AsString  := fRetAutoIncrem('CONAGE', VS_strCodEmp);
              ParamByName('SEQGER').AsString  := strAutoIn;
              ParamByName('CODEMP').AsString  := VS_strCodEmp;
              ParamByName('NOMCON').AsString  := regCliCon.strCliNom;
              ParamByName('ENDCON').AsString  := regCliCon.strCliEnd;
              ParamByName('BAICON').AsString  := regCliCon.strCliBai;
              ParamByName('CEPCON').AsString  := regCliCon.strCliCep;
              ParamByName('RG_CON').AsString  := regCliCon.strCli_Rg;
              ParamByName('CODCID').AsString  := regCliCon.strCodCid;
              ParamByName('TELCON').AsString  := regCliCon.strCliTel;
              ParamByName('CGCCPF').AsInteger := regCliCon.intCgcCpf;
              ParamByName('CGCCON').AsString  := regCliCon.strCliCgc;
              ParamByName('IESCON').AsString  := regCliCon.strCliIes;
              ParamByName('EMLCON').AsString  := regCliCon.strCliEml;
              ParamByName('CODREG').AsString  := regCliCon.strCodReg;

              ExecSQL;
            End;
          End;

          FreeAndNil(qryInsert);
        End;
      End;

      fAbreConsulta();
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;

  pFreeAndNil(frmDigCliente);
end;

procedure TfrmAtendimento.pPreencheHisLig;
  Var
    qryAux: TUniQuery;
    strLines: TStringList;
begin

  If Not(cdsConsulta.Active) Then
    Exit;

  pCarregaDadosConsumidor(cdsConsulta.FieldByName('AUTOINCREM').AsString);

  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  AGE_DTABAI AS DTABAI, ');
  qryAux.SQL.Add('  AGE_HORBAI AS HORBAI, ');
  qryAux.SQL.Add('  CONCAT(AGE_CODVEN, "-", OPE_NOMOPE) AS CODVEN, ');
  qryAux.SQL.Add('  AGE_OBSERV AS OBSERV, ');
  qryAux.SQL.Add('  CON_CGCCON ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  AGETEL ');
  qryAux.SQL.Add('  JOIN CADOPE ON OPE_CODOPE = AGE_CODVEN ');
  qryAux.SQL.Add('  LEFT JOIN  CONAGE ON AGETEL.AUTOINCREM = CONAGE.CON_SEQGER ');
  qryAux.SQL.Add('WHERE ');

  If Not fEmptyStr(regCliCon.strCliCgc) Then
  Begin
    qryAux.SQL.Add('  CON_CGCCON = :CGC   AND ');
    qryAux.ParamByName('CGC').AsString :=  regCliCon.strCliCgc;
  End
  Else
  Begin
    qryAux.SQL.Add('  AGE_CODCLI = :CODCLI AND ');
    qryAux.ParamByName('CODCLI').AsString := cdsConsulta.FieldByName('CLI_CODCLI').asString;
  End;

  qryAux.SQL.Add('  AGE_DTABAI IS NOT NULL ');
  qryAux.SQL.Add('ORDER BY ');
  qryAux.SQL.Add('  AGE_DTABAI DESC, AGE_HORBAI DESC ');

  qryAux.Open;

  strLines := TStringList.Create;
  strLines.Clear;

  While (Not qryAux.Eof) Do
  Begin

    strLines.Add('DATA: ' + qryAux.FieldByName('DTABAI').AsString + ' - ' +
                        'HORA: ' + qryAux.FieldByName('HORBAI').AsString);
    If (strVenRep = 'Vendedor') Then
      strLines.Add('VENDEDOR: ' + qryAux.FieldByName('CODVEN').AsString)
    Else
      strLines.Add('REPRESENTANTE: ' + qryAux.FieldByName('CODVEN').AsString);
    strLines.Add('OBSERVAÇÕES DA BAIXA:');
    strLines.Add( ReplaceStr( qryAux.FieldByName('OBSERV').AsString, '<<csq>>', #13#10) );

    If (qryAux.RecNo < qryAux.RecordCount) Then
    Begin
      strLines.Add('');
      strLines.Add('=================================================================');
      strLines.Add('');
    End;

    qryAux.Next;
  End;

  memHisLig.Text := strLines.Text;
  memHisLig.SelStart := 0;
  memHisLig.SelLength := 0;

  FreeAndNil(qryAux);
  FreeAndNil(strLines);
end;

procedure TfrmAtendimento.btnNiverDiaClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(strCodVen) Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(72, 5216, [],
                        ['CODVEN'],
                        [strCodVen],
                        Sender,
                        ['CODVEN'],
                        False);
  End;

end;

end.


