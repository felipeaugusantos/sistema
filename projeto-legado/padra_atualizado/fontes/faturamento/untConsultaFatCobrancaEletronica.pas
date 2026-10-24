unit untConsultaFatCobrancaEletronica;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, System.DateUtils,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  EditFocus, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, ComboBoxFocus,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCurrencyEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid,
  Uni, UniClientDataSet, CobrancaEletronica.Lib.Types, untTypesSistema;

type
  TfrmConsultaFatCobrancaEletronica = class(TfrmPai)
    pnlTopo: TPanel;
    lblPeriodo: TLabel;
    Label3: TLabel;
    lblEmpresa: TLabel;
    lblVendedor: TLabel;
    shaVendedor: TShape;
    shaEmpresa: TShape;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    btnCarregarPedidos: TBitBtnLocked;
    edtCodigoVendedor: TEditFocus;
    edtNomeVendedor: TEditFocus;
    grdLancamentos: TcxGridCitel;
    grdLancamentosDados: TcxGridDBTableViewCitel;
    grdLancamentosDadosNUMDOC: TcxGridDBColumn;
    grdLancamentosDadosESPDOC: TcxGridDBColumn;
    grdLancamentosDadosCODEMP: TcxGridDBColumn;
    grdLancamentosDadosDTAENT: TcxGridDBColumn;
    grdLancamentosDadosNOMCLI: TcxGridDBColumn;
    grdLancamentosDadosCELULA: TcxGridDBColumn;
    grdLancamentosDadosEMAIL_: TcxGridDBColumn;
    grdLancamentosDadosVLRCON: TcxGridDBColumn;
    grdLancamentosDadosVENDED: TcxGridDBColumn;
    grdLancamentosNivel: TcxGridLevel;
    grdLancamentosDadosLNKPAG: TcxGridDBColumn;
    grdLancamentosDadosSMSENV: TcxGridDBColumn;
    grdLancamentosDadosWPPENV: TcxGridDBColumn;
    grdLancamentosDadosSTATUS: TcxGridDBColumn;
    btnCopiarLinkPagamento: TBitBtnLocked;
    btnDispararMensagem: TBitBtnLocked;
    pnlHabilitaDisparoMensagem: TPanel;
    btnConfirmaDisparoMensagem: TBitBtnLocked;
    chkDisparaEmail: TCheckBox;
    chkDisparaSms: TCheckBox;
    chkDisparaWhatsapp: TCheckBox;
    btnCancelaDisparoMensagem: TBitBtnLocked;
    grdLancamentosDadosEMLENV: TcxGridDBColumn;
    grbLegenda: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    grdLancamentosDadosTIPREC: TcxGridDBColumn;
    shpLegGerado: TShape;
    shpLegCancelado: TShape;
    shpLegEnviado: TShape;
    shpLegFormaPagamento: TShape;
    shpLegPago: TShape;
    shpLegExpirado: TShape;
    grdLancamentosDadosMSGRET: TcxGridDBColumn;
    grdLancamentosDadosSTATRA: TcxGridDBColumn;
    btnLiberarRegistro: TBitBtnLocked;
    btnCriarNovoLink: TBitBtnLocked;
    shpLegAguardandoLink: TShape;
    shpLegAguardandoLiberacaoComercial: TShape;
    Label8: TLabel;
    Label9: TLabel;
    grdLancamentosDadosCODSTA: TcxGridDBColumn;
    shpLegDadosIncosistentes: TShape;
    Label10: TLabel;
    grdLancamentosDadosLIBCOM: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCarregarPedidosClick(Sender: TObject);
    procedure edtCodigoVendedorExit(Sender: TObject);
    procedure edtCodigoVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnCopiarLinkPagamentoClick(Sender: TObject);
    procedure btnDispararMensagemClick(Sender: TObject);
    procedure btnConfirmaDisparoMensagemClick(Sender: TObject);
    procedure btnCancelaDisparoMensagemClick(Sender: TObject);
    procedure grdLancamentosDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdLancamentosDadosSTATRAGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnLiberarRegistroClick(Sender: TObject);
    procedure btnCriarNovoLinkClick(Sender: TObject);
    procedure grdLancamentosDadosDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdLancamentosDadosKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FDataSetPedidos     : TUniClientDataSet;
    FDataSoucePedidos   : TDataSource;
    qryConEmp           : TUniQuery;
    FprcScroll          : TprcScroll;
    FArrayEmpresa,
    FArrayVendedor      : TConsultasArray;
    FRegistroAtual      : Integer;
    FblnPermiteEmail,
    FblnPermiteSms,
    FblnPermiteWhatsapp : Boolean;

    procedure pCarregaSQL;
    procedure OnAfterScroll(Dataset: TDataset);
    procedure pCarregaEmpresa;
    function fHabilitarDisparoMensagem(const AEmail, ASms, AWhatsapp: Boolean): Boolean;
    procedure pVerificaPermissaoDisparos;

    function fPermiteAcoesBotoes: Boolean;
    procedure pMostrarMensagemRetorno;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
  end;

var
  frmConsultaFatCobrancaEletronica: TfrmConsultaFatCobrancaEletronica;

implementation

uses
  untFuncoesSimples, untGravando, untPesqAux, untFuncoesConsulta, untConsultas,
  Vcl.Clipbrd, untDisparaEmailAut, untDisparaSMSAut, System.StrUtils, System.UITypes,
  CobrancaEletronica.lib.Facade, untObservacao;

{$R *.dfm}

{ TfrmConsultaFatCobrancaEletronica }

procedure TfrmConsultaFatCobrancaEletronica.btnCancelaDisparoMensagemClick(
  Sender: TObject);
begin
  inherited;

  pEnableControls(FDataSetPedidos, FprcScroll);
  pnlHabilitaDisparoMensagem.Visible := False;
  grdLancamentos.Enabled             := True;
end;

procedure TfrmConsultaFatCobrancaEletronica.btnCarregarPedidosClick(
  Sender: TObject);
begin
  inherited;

  If Not fValidaCampos(edtCodEmp, True) Then
    Exit;

  pnlHabilitaDisparoMensagem.Visible := False;
  TfrmGravando.fExecutarModal(pCarregaSQL, 'Aguarde... Filtrando registros.', '');

  pSetFocus(grdLancamentos);
end;

procedure TfrmConsultaFatCobrancaEletronica.btnConfirmaDisparoMensagemClick(
  Sender: TObject);
begin
  inherited;

  Try
    If fHabilitarDisparoMensagem(chkDisparaEmail.Checked,
                                 chkDisparaSms.Checked,
                                 chkDisparaWhatsapp.Checked) Then
    Begin
      btnCarregarPedidos.Click;

      If FRegistroAtual <= Pred(FDatasetPedidos.RecordCount) Then
        FDatasetPedidos.Recno := FRegistroAtual
      Else
        FDatasetPedidos.Last;
    End;
  Finally
    pEnableControls(FDataSetPedidos, FprcScroll);
    pnlHabilitaDisparoMensagem.Visible := False;
    grdLancamentos.Enabled             := True;
  End;
end;

procedure TfrmConsultaFatCobrancaEletronica.btnCopiarLinkPagamentoClick(
  Sender: TObject);
begin
  inherited;

  If FDatasetPedidos.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário selecionar algum documento para utilizar essa função.', ['&Ok']);
    Exit;
  End;

  If (Not fPermiteAcoesBotoes) Then
    Exit;

  Clipboard.AsText := FDatasetPedidos.FieldByName('LNKPAG').AsString;

  fMensagem('AVISO', 'Link de Pagamento copiado para a área de transferência', ['&Ok']);
end;

procedure TfrmConsultaFatCobrancaEletronica.btnCriarNovoLinkClick(
  Sender: TObject);
begin
  inherited;
  If Not btnCriarNovoLink.Visible Then
    Exit;

  If FDatasetPedidos.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário selecionar algum documento para utilizar essa função.', ['&Ok']);
    Exit;
  End;

  If Not (MatchStr(FDatasetPedidos.FieldByName('TIPREC').AsString, [API_PAGARME_COM_TRANSACAO,
                                                                    API_PAGARME_EXPIRADO])) Then
  Begin
    fMensagem('ATENÇÃO', 'Não é permitida essa operação para o status dessa cobrança eletrônica.', ['&Ok']);

    Exit;
  End;

  If (fMensagem('Confirmação', 'Esta operação cancelará o link de pagamento ativo e gerará um novo. '
                             + 'Deseja continuar?', ['Sim','Não']) = 1) Then
  Begin
    TFacadeCobrancaEletronica.pCriarNovoLinkPagamento(FDataSetPedidos.FieldByName('NUMDOC').AsString,
                                                      FDataSetPedidos.FieldByName('ESPDOC').AsString,
                                                      FDataSetPedidos.FieldByName('CODEMP').AsString,
                                                      tcPagarMe);
    btnCarregarPedidos.Click;
  End;
end;

procedure TfrmConsultaFatCobrancaEletronica.btnDispararMensagemClick(
  Sender: TObject);
begin
  inherited;

  If FDatasetPedidos.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário selecionar algum documento para utilizar essa função.', ['&Ok']);
    Exit;
  End;

  If (Not fPermiteAcoesBotoes) Then
    Exit;

  chkDisparaEmail.Checked    := False;
  chkDisparaSms.Checked      := False;
  chkDisparaWhatsapp.Checked := False;

  FRegistroAtual := FDatasetPedidos.Recno;

  pnlHabilitaDisparoMensagem.Visible := True;
  pDisableControls(FDataSetPedidos, FprcScroll);
  grdLancamentos.Enabled := False;
end;

procedure TfrmConsultaFatCobrancaEletronica.btnLiberarRegistroClick(
  Sender: TObject);
begin
  inherited;
  If Not btnLiberarRegistro.Visible Then
    Exit;

  If FDatasetPedidos.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário selecionar algum documento para utilizar essa função.', ['&Ok']);
    Exit;
  End;

  If Not (MatchStr(FDatasetPedidos.FieldByName('TIPREC').AsString, [API_PAGARME,
                                                                    API_PAGARME_ENVIADA,
                                                                    API_PAGARME_COM_TRANSACAO,
                                                                    API_PAGARME_EXPIRADO])) Then
  Begin
    fMensagem('ATENÇÃO', 'Não é permitida essa operação para o status dessa cobrança eletrônica.', ['&Ok']);

    Exit;
  End;

  If (fMensagem('Confirmação', 'Esta operação desvinculará o pedido da cobrança eletrônica. '
                             + 'Deseja continuar?', ['Sim','Não']) = 1) Then
  Begin
    TFacadeCobrancaEletronica.pCancelaLinkPagamento(FDataSetPedidos.FieldByName('NUMDOC').AsString,
                                                    FDataSetPedidos.FieldByName('ESPDOC').AsString,
                                                    FDataSetPedidos.FieldByName('CODEMP').AsString,
                                                    tcPagarMe);
    btnCarregarPedidos.Click;
  End;
end;

procedure TfrmConsultaFatCobrancaEletronica.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtDesEmp, FArrayEmpresa, fRetNomeEmpresa, Nil, 'da Empresa');
end;

procedure TfrmConsultaFatCobrancaEletronica.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, FArrayEmpresa, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaFatCobrancaEletronica.edtCodigoVendedorExit(
  Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodigoVendedor,
                    edtNomeVendedor,
                    FArrayVendedor,
                    fRetNomVendRep,
                    nil,
                    'do Vendedor',
                    3,
                    False,
                    'Código',
                    False,
                    True);
end;

procedure TfrmConsultaFatCobrancaEletronica.edtCodigoVendedorKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodigoVendedor, edtNomeVendedor, nil, Key, FArrayVendedor, False) Then
  Begin
    If fValidaCampos(edtCodigoVendedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaFatCobrancaEletronica.FormCreate(Sender: TObject);
begin
  inherited;
  FDataSetPedidos := TUniClientDataset.Create(Self);
  TDicionarioCobrancaEletronica.GetInstance;
end;

procedure TfrmConsultaFatCobrancaEletronica.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryConEmp);
  FreeAndNil(FDataSoucePedidos);
  FreeAndNil(FDataSetPedidos);

  inherited;
end;

procedure TfrmConsultaFatCobrancaEletronica.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key = VK_F4 Then
  Begin
    Key := 0;
    btnCopiarLinkPagamento.Click;
  End
  Else
  If Key = VK_F5 Then
  Begin
    Key := 0;
    btnLiberarRegistro.Click;
  End
  Else
  If Key = VK_F6 Then
  Begin
    Key := 0;
    btnCriarNovoLink.Click;
  End
  Else
  If Key = VK_F12 Then
  Begin
    Key := 0;
    btnDispararMensagem.Click;
  End
  Else
    inherited;
end;

procedure TfrmConsultaFatCobrancaEletronica.FormShow(Sender: TObject);
begin
  inherited;
  btnLiberarRegistro.Enabled := fVerificaAcessoSistema('LIBERAREGISTROCOBELT');
  btnLiberarRegistro.Visible := btnLiberarRegistro.Enabled;

  btnCriarNovoLink.Enabled := fVerificaAcessoSistema('CRIANOVOLINKCOBELT');
  btnCriarNovoLink.Visible := btnCriarNovoLink.Enabled;

  pnlHabilitaDisparoMensagem.Visible := False;
  pVerificaPermissaoDisparos;

  edtCodEmp.Text := VS_strCodEmp;
  edtCodEmp.OnExit(edtCodEmp);

  mskDtaIni.Date := IncDay(VS_Date, -1);
  mskDtaFin.Date := VS_Date;

  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  TfrmGravando.fExecutarModal(pCarregaSQL, 'Aguarde... Filtrando registros.', '');

  pSetFocus(mskDtaIni);
end;

function TfrmConsultaFatCobrancaEletronica.fPermiteAcoesBotoes: Boolean;
begin
  If fEmptyStr(FDatasetPedidos.FieldByName('LNKPAG').AsString) Then
  Begin
    fMensagem('ATENÇÃO', 'O pedido não possui link de pagamento. Verifique '
                        +'se houve algum erro na comunicação com a API.', ['&Ok']);
    Exit(False);
  End;

  If MatchStr(FDataSetPedidos.FieldByName('TIPREC').AsString,
              [API_PAGARME_CANCELADA, API_PAGARME_BAIXA_PEDIDO_NAO_ENTREGUE]) Then
  Begin
    fMensagem('ATENÇÃO', 'Documento cancelado na API de cobrança!', ['&Ok']);
    Exit(False);
  End;

  If FDataSetPedidos.FieldByName('TIPREC').AsString = API_PAGARME_COM_TRANSACAO Then
  Begin
    fMensagem('ATENÇÃO', 'Documento não está disponível, pois já possui '+
                         'forma de pagamento definida!', ['&Ok']);
    Exit(False);
  End;

  If FDataSetPedidos.FieldByName('TIPREC').AsString = API_PAGARME_COM_PAGAMENTO Then
  Begin
    fMensagem('ATENÇÃO', 'Documento não está disponível, pois já possui '+
                         'pagamento efetuado!', ['&Ok']);
    Exit(False);
  End;

  If FDataSetPedidos.FieldByName('TIPREC').AsString = API_PAGARME_EXPIRADO Then
  Begin
    fMensagem('ATENÇÃO', 'Documento não está disponível, o link de pagamento '+
                         'está expirado!', ['&Ok']);
    Exit(False);
  End;

  Result := True;
end;

function TfrmConsultaFatCobrancaEletronica.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = mskDtaFin) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (StrToDateDef(mskDtaFin.Text, 0) <= 0) Then
      Begin
        fMensagem('ATENÇÃO', 'A Data Final do período informada é inválida!', ['&Ok']);
        Result := False;
      End
      Else
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('ATENÇÃO', 'O campo Data Final do período deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'O campo Data Inicial do período deve ser preenchido!', ['&Ok']);
          Result := False;
          Sender := mskDtaIni;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('ATENÇÃO','A Data Inicial do período deve ser menor que a Data Final do período!',['&Ok']);
              Result := False;
              Sender := mskDtaIni;
            End;
          End;
        End;
      End;
    End

    Else If (Sender = mskDtaIni) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (StrToDateDef(mskDtaIni.Text, 0) <= 0) Then
      Begin
        fMensagem('ATENÇÃO', 'A Data Inicial do período informada é inválida!', ['&Ok']);
        Result := False;
        Sender := mskDtaIni;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        edtDesEmp.Clear;
      End
      Else
      Begin
        If Not SameText(edtCodEmp.Text, '000') Then
        Begin
          SetLength(FArrayEmpresa, 0);

          pCarregaEmpresa;
          If fEmptyStr(edtDesEmp.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
            Result := False;
          End
          Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = edtCodigoVendedor) Then
    Begin
      If (fEmptyStr(edtCodigoVendedor.Text)) Then
        edtNomeVendedor.Clear
      Else
      If Not SameText(edtCodigoVendedor.Text, '000') Then
      Begin
        SetLength(FArrayVendedor, 0);

        edtNomeVendedor.Text := fRetNomVendRep(edtCodigoVendedor.Text);
        If fEmptyStr(edtNomeVendedor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Vendedor não está cadastrado!', ['&Ok']);
          Result := False;
        End
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmConsultaFatCobrancaEletronica.grdLancamentosDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (Not FDataSetPedidos.Active) Or
     (FDataSetPedidos.RecordCount = 0) Then
   Exit;

  If (Copy(VarToStrDef(AViewInfo.GridRecord.Values[grdLancamentosDadosCODSTA.Index],''),1,1) <> '2') And
     (Not fEmptyStr(VarToStrDef(AViewInfo.GridRecord.Values[grdLancamentosDadosCODSTA.Index],''))) Then
    ACanvas.Font.Color := shpLegDadosIncosistentes.Brush.Color
  Else If (VarToStrDef(AViewInfo.GridRecord.Values[grdLancamentosDadosTIPREC.Index],'') = API_PAGARME_CANCELADA) Or
          (VarToStrDef(AViewInfo.GridRecord.Values[grdLancamentosDadosTIPREC.Index],'') = API_PAGARME_BAIXA_PEDIDO_NAO_ENTREGUE) Then
    ACanvas.Font.Color := shpLegCancelado.Brush.Color
  Else If (VarToStrDef(AViewInfo.GridRecord.Values[grdLancamentosDadosTIPREC.Index],'') = API_PAGARME_COM_PAGAMENTO) Then
    ACanvas.Font.Color := shpLegPago.Brush.Color
  Else If (VarToStrDef(AViewInfo.GridRecord.Values[grdLancamentosDadosTIPREC.Index],'') = API_PAGARME_COM_TRANSACAO) Then
    ACanvas.Font.Color := shpLegFormaPagamento.Brush.Color
  Else If (VarToStrDef(AViewInfo.GridRecord.Values[grdLancamentosDadosTIPREC.Index],'') = API_PAGARME_EXPIRADO) Then
    ACanvas.Font.Color := shpLegExpirado.Brush.Color
  Else If (VarToStrDef(AViewInfo.GridRecord.Values[grdLancamentosDadosTIPREC.Index],'') = API_PAGARME_ENVIADA) Then
    ACanvas.Font.Color := shpLegEnviado.Brush.Color
  Else If (Not fEmptyStr(VarToStrDef(AViewInfo.GridRecord.Values[grdLancamentosDadosLNKPAG.Index],''))) And
          (VarToStrDef(AViewInfo.GridRecord.Values[grdLancamentosDadosTIPREC.Index],'') = API_PAGARME) Then
    ACanvas.Font.Color := shpLegGerado.Brush.Color
  Else If (VarToStrDef(AViewInfo.GridRecord.Values[grdLancamentosDadosTIPREC.Index],'') = API_PAGARME) Or
          (VarToStrDef(AViewInfo.GridRecord.Values[grdLancamentosDadosTIPREC.Index],'') = API_PAGARME_CANCELA_LINK_CRIA_NOVO) Then
  Begin
    If (StrToIntDef(VarToStrDef(AViewInfo.GridRecord.Values[grdLancamentosDadosLIBCOM.Index],'0'),0) = 0) Then
      ACanvas.Font.Color := shpLegAguardandoLiberacaoComercial.Brush.Color
    Else
      ACanvas.Font.Color := shpLegAguardandoLink.Brush.Color;
  End;
end;

procedure TfrmConsultaFatCobrancaEletronica.grdLancamentosDadosDblClick(
  Sender: TObject);
begin
  inherited;
  pMostrarMensagemRetorno;
end;

procedure TfrmConsultaFatCobrancaEletronica.grdLancamentosDadosKeyPress(
  Sender: TObject; var Key: Char);
begin
  If Key = chr(VK_RETURN) Then
  Begin
    Key := #0;
    pMostrarMensagemRetorno;
  End
  Else
    inherited;
end;

procedure TfrmConsultaFatCobrancaEletronica.grdLancamentosDadosSTATRAGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
var
  LStatus: String;
begin
  inherited;

  AText := EmptyStr;

  If Not (ARecord.Values[grdLancamentosDadosSTATRA.Index] = Null) Then
  Begin
    TDicionarioCobrancaEletronica.GetInstance.StatusCobranca
      .TryGetValue(ARecord.Values[grdLancamentosDadosSTATRA.Index], LStatus);

    If Not fEmptyStr(LStatus) Then
      AText := LStatus.ToUpper;
  End;
end;

procedure TfrmConsultaFatCobrancaEletronica.OnAfterScroll(Dataset: TDataset);
begin
//
end;

procedure TfrmConsultaFatCobrancaEletronica.pCarregaEmpresa;
begin
  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
    pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  End
  Else
    edtDesEmp.Clear;
end;

procedure TfrmConsultaFatCobrancaEletronica.pCarregaSQL;
var
  LQuery         : TUniQuery;
  LEmpresaPedido,
  LVendedor,
  LPeriodo       : String;
begin

  LQuery := fCriaQuery;
  Try
    LEmpresaPedido := EmptyStr;
    If Not fEmptyStr(edtCodEmp.Text) Then
      LEmpresaPedido := '   AND G.FGO_CODEMP IN (' + fRetArrToSQLIn(FArrayEmpresa, edtCodEmp.Text) + ') '
    Else If Not fEmptyStr(strEmpAcessoUsuarioLogado) Then
      LEmpresaPedido := '   AND G.FGO_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';

    LVendedor := EmptyStr;
    If Not fEmptyStr(edtCodigoVendedor.Text) Then
      LVendedor := '   AND G.FGO_CODVEN IN (' + fRetArrToSQLIn(FArrayVendedor, edtCodigoVendedor.Text) + ') ';

    LPeriodo := EmptyStr;
    If Not fEmptyStr(mskDtaIni.Text) Then
      LPeriodo := '   AND G.FGO_DTAENT BETWEEN "' + FormatDateTime('yyyy/mm/dd', mskDtaIni.Date) + '" '
                + '                        AND "' + FormatDateTime('yyyy/mm/dd', mskDtaFin.Date) + '" ';

    LQuery.SQL.Text := 'SELECT '
                     + '       G.AUTOINCREM AS AUTINC '
                     + '     , B.AUTOINCREM AS CBEINC '
                     + '     , G.FGO_NUMDOC AS NUMDOC '
                     + '     , G.FGO_ESPDOC AS ESPDOC '
                     + '     , G.FGO_CODEMP AS CODEMP '
                     + '     , G.FGO_CODCLI AS CODCLI '
                     + '     , C.CLI_NOMCLI AS NOMCLI '
                     + '     , B.CBE_LNKPAG AS LNKPAG '
                     + '     , C.CLI_EMAIL_ AS EMAIL_ '
                     + '     , G.FGO_DTAENT AS DTAENT '
                     + '     , G.FGO_VLRCON AS VLRCON '
                     + '     , C.CLI_CELULA AS CELULA '
                     + '     , B.CBE_EMLENV AS EMLENV '
                     + '     , B.CBE_SMSENV AS SMSENV '
                     + '     , B.CBE_WPPENV AS WPPENV '
                     + '     , X.FGO_TIPREC AS TIPREC '
                     + '     , B.CBE_APICOB AS APICOB '
                     + '     , G.FGO_CODVEN AS CODVEN '
                     + '     , O.OPE_NOMOPE AS VENDED '
                     + '     , (CASE '
                     + '          WHEN X.FGO_TIPREC = "' + API_PAGARME               + '" THEN "COBRANÇA ELETRÔNICA GERADA" '
                     + '          WHEN X.FGO_TIPREC IN ("' + API_PAGARME_BAIXA_PEDIDO_NAO_ENTREGUE + '", '
                     + '                                "' + API_PAGARME_CANCELADA   + '") THEN "COBRANÇA ELETRÔNICA CANCELADA" '
                     + '          WHEN X.FGO_TIPREC = "' + API_PAGARME_ENVIADA       + '" THEN "LINK DE PAGAMENTO ENVIADO" '
                     + '          WHEN X.FGO_TIPREC = "' + API_PAGARME_COM_TRANSACAO + '" THEN "DOCUMENTO COM FORMA DE PAGAMENTO DEFINIDA" '
                     + '          WHEN X.FGO_TIPREC = "' + API_PAGARME_COM_PAGAMENTO + '" THEN "DOCUMENTO COM PAGAMENTO EFETUADO" '
                     + '          WHEN X.FGO_TIPREC = "' + API_PAGARME_EXPIRADO      + '" THEN "DOCUMENTO COM LINK DE PAGAMENTO EXPIRADO" '
                     + '        END)        AS STATUS '
                     + '     , B.CBE_STATRA AS STATRA '
                     + '     , B.CBE_MSGRET AS MSGRET '
                     + '     , L.LOG_STATUS AS CODSTA '
                     + '     , L.LOG_RESULT AS RESULT '
                     + '     , G.FGO_LIBCOM AS LIBCOM '
                     + '  FROM FATGOR G '
                     + ' INNER JOIN CADCLI C ON C.CLI_CODCLI = G.FGO_CODCLI '
                     + ' INNER JOIN EXTGOR X ON X.FGO_SEQFGO = G.AUTOINCREM '
                     + ' INNER JOIN CADOPE O ON O.OPE_CODOPE = G.FGO_CODVEN '
                     + '  LEFT JOIN COBELT B ON B.CBE_NUMDOC = G.FGO_NUMDOC '
                     + '                    AND B.CBE_ESPDOC = G.FGO_ESPDOC '
                     + '                    AND B.CBE_CODEMP = G.FGO_CODEMP '
                     + '  LEFT JOIN LOGAPI L ON L.LOG_SEQFGO = G.AUTOINCREM '
                     + '                    AND L.LOG_LOGAPI = "'+API_PAGARME+'" '
                     + '                    AND L.AUTOINCREM = (SELECT MAX(A.AUTOINCREM) FROM LOGAPI A '
                     + '                                         WHERE A.LOG_SEQFGO = L.LOG_SEQFGO '
                     + '                                           AND A.LOG_LOGAPI = "'+API_PAGARME+'") '
                     + ' WHERE G.FGO_ESPDOC = "PD" '
                     + '   AND X.FGO_TIPREC LIKE "'+API_PAGARME+'%" '
                     + '   AND X.FGO_TIPREC <> "'+API_PAGARME_CANCELA_LINK_REMOVE_COBELT+'" '
                     + LEmpresaPedido
                     + LVendedor
                     + LPeriodo
                     + ' UNION '
                     + 'SELECT '
                     + '       G.AUTOINCREM AS AUTINC '
                     + '     , B.AUTOINCREM AS CBEINC '
                     + '     , G.FGO_NUMDOC AS NUMDOC '
                     + '     , G.FGO_ESPDOC AS ESPDOC '
                     + '     , G.FGO_CODEMP AS CODEMP '
                     + '     , G.FGO_CODCLI AS CODCLI '
                     + '     , C.CLI_NOMCLI AS NOMCLI '
                     + '     , B.CBE_LNKPAG AS LNKPAG '
                     + '     , C.CLI_EMAIL_ AS EMAIL_ '
                     + '     , G.FGO_DTAENT AS DTAENT '
                     + '     , G.FGO_VLRCON AS VLRCON '
                     + '     , C.CLI_CELULA AS CELULA '
                     + '     , B.CBE_EMLENV AS EMLENV '
                     + '     , B.CBE_SMSENV AS SMSENV '
                     + '     , B.CBE_WPPENV AS WPPENV '
                     + '     , "PMEC"       AS TIPREC '
                     + '     , B.CBE_APICOB AS APICOB '
                     + '     , G.FGO_CODVEN AS CODVEN '
                     + '     , O.OPE_NOMOPE AS VENDED '
                     + '     , "COBRANÇA ELETRÔNICA CANCELADA" AS STATUS '
                     + '     , B.CBE_STATRA AS STATRA '
                     + '     , B.CBE_MSGRET AS MSGRET '
                     + '     , "" AS CODSTA '
                     + '     , "" AS RESULT '
                     + '     , G.FGO_LIBCOM AS LIBCOM '
                     + '  FROM DEL_FATGOR G '
                     + ' INNER JOIN DEL_EXTGOR X ON X.FGO_SEQFGO = G.AUTOINCREM '
                     + ' INNER JOIN CADCLI     C ON C.CLI_CODCLI = G.FGO_CODCLI '
                     + ' INNER JOIN CADOPE     O ON O.OPE_CODOPE = G.FGO_CODVEN '
                     + ' INNER JOIN COBELT     B ON B.CBE_NUMDOC = G.FGO_NUMDOC '
                     + '                        AND B.CBE_ESPDOC = G.FGO_ESPDOC '
                     + '                        AND B.CBE_CODEMP = G.FGO_CODEMP '
                     + ' WHERE G.FGO_ESPDOC = "PD" '
                     + '   AND X.FGO_TIPREC LIKE "'+API_PAGARME+'%" '
                     + '   AND X.FGO_TIPREC <> "'+API_PAGARME_CANCELA_LINK_REMOVE_COBELT+'" '
                     + LEmpresaPedido
                     + LVendedor
                     + LPeriodo
                     + ' UNION '
                     + 'SELECT '
                     + '       G.AUTOINCREM AS AUTINC '
                     + '     , B.AUTOINCREM AS CBEINC '
                     + '     , G.FGO_NUMDOC AS NUMDOC '
                     + '     , G.FGO_ESPDOC AS ESPDOC '
                     + '     , G.FGO_CODEMP AS CODEMP '
                     + '     , G.FGO_CODCLI AS CODCLI '
                     + '     , C.CLI_NOMCLI AS NOMCLI '
                     + '     , B.CBE_LNKPAG AS LNKPAG '
                     + '     , C.CLI_EMAIL_ AS EMAIL_ '
                     + '     , G.FGO_DTAENT AS DTAENT '
                     + '     , G.FGO_VLRCON AS VLRCON '
                     + '     , C.CLI_CELULA AS CELULA '
                     + '     , B.CBE_EMLENV AS EMLENV '
                     + '     , B.CBE_SMSENV AS SMSENV '
                     + '     , B.CBE_WPPENV AS WPPENV '
                     + '     , "PMEC"       AS TIPREC '
                     + '     , B.CBE_APICOB AS APICOB '
                     + '     , G.FGO_CODVEN AS CODVEN '
                     + '     , O.OPE_NOMOPE AS VENDED '
                     + '     , "COBRANÇA ELETRÔNICA CANCELADA" AS STATUS '
                     + '     , B.CBE_STATRA AS STATRA '
                     + '     , B.CBE_MSGRET AS MSGRET '
                     + '     , "" AS CODSTA '
                     + '     , "" AS RESULT '
                     + '     , G.FGO_LIBCOM AS LIBCOM '
                     + '  FROM DEL_FATGOR G '
                     + ' INNER JOIN DEL_EXTGOR X ON X.FGO_SEQFGO = G.AUTOINCREM '
                     + ' INNER JOIN CADCLI     C ON C.CLI_CODCLI = G.FGO_CODCLI '
                     + ' INNER JOIN CADOPE     O ON O.OPE_CODOPE = G.FGO_CODVEN '
                     + ' INNER JOIN DEL_COBELT B ON B.CBE_NUMDOC = G.FGO_NUMDOC '
                     + '                        AND B.CBE_ESPDOC = G.FGO_ESPDOC '
                     + '                        AND B.CBE_CODEMP = G.FGO_CODEMP '
                     + ' WHERE G.FGO_ESPDOC = "PD" '
                     + '   AND X.FGO_TIPREC LIKE "'+API_PAGARME+'%" '
                     + LEmpresaPedido
                     + LVendedor
                     + LPeriodo
                     + ' ORDER BY '
                     + '       DTAENT DESC '
                     + '     , NUMDOC ';

    LQuery.Open;

    FDataSetPedidos.Close;
    pDisableControls(FDataSetPedidos, FprcScroll);
    pSetaClient(LQuery);
    pSetaClientDataSet(LQuery, FDataSetPedidos);
    FDataSetPedidos.Open;

    FDataSoucePedidos := fCriaDataSource(FDataSetPedidos);
    grdLancamentosDados.DataController.DataSource := FDataSoucePedidos;

    pEnableControls(FDataSetPedidos, FprcScroll);
    FDataSetPedidos.AfterScroll := OnAfterScroll;

    FDataSetPedidos.First;

  Finally
    FreeAndNil(LQuery);
  End;
end;

procedure TfrmConsultaFatCobrancaEletronica.pMostrarMensagemRetorno;
var
  frmObservacao: TfrmObservacao;
begin
  If (Not Assigned(FDataSetPedidos)) Or
     (FDataSetPedidos.RecordCount = 0) Then
    Exit;

  If fEmptyStr(FDataSetPedidos.FieldByName('RESULT').AsString) Then
    Exit;

  If (Copy(FDataSetPedidos.FieldByName('CODSTA').AsString,1,1) = '2') Then
    Exit;

  Try
    frmObservacao := nil;
    Try
      pCriarFormularios(TfrmObservacao, frmObservacao);

      frmObservacao.lblMensagem.caption := 'ATENÇÃO';
      frmObservacao.memObs.Texto := FDataSetPedidos.FieldByName('RESULT').AsString;
      frmObservacao.ShowModal;
    Finally
      pFreeAndNil(frmObservacao);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pMostrarMensagemRetorno]');
    End;
  End;
end;

procedure TfrmConsultaFatCobrancaEletronica.pVerificaPermissaoDisparos;
var
  LEmailAutomatico: TEmaAut;
  LSMSAutomatico: TSMSAut;
begin
  inherited;
  LEmailAutomatico := TEmaAut.Create(Nil);
  LSMSAutomatico   := TSMSAut.Create(Nil);

  Try
    LEmailAutomatico.FCodigo := '001';
    LEmailAutomatico.FCodGru := '039';
    LEmailAutomatico.FOpcDoc := 'CB';
    FblnPermiteEmail         := LEmailAutomatico.fTemEmailAtivo;

    LSMSAutomatico.FCodigo := '001';
    LSMSAutomatico.FCodGru := '039';
    LSMSAutomatico.FOpcDoc := 'CB';
    FblnPermiteSMS         := LSMSAutomatico.fTemModeloAtivo;

    LSMSAutomatico.FWhatsApp := True;
    FblnPermiteWhatsapp      := (LSMSAutomatico.fTemModeloAtivo) And
                                (fCfgSis('UTIWPP', varBoolean));

    chkDisparaEmail.Visible    := FblnPermiteEmail;
    chkDisparaSms.Visible      := FblnPermiteSms;
    chkDisparaWhatsapp.Visible := FblnPermiteWhatsapp;
  Finally
    FreeAndNil(LEmailAutomatico);
    FreeAndNil(LSMSAutomatico);
  End;
end;

function TfrmConsultaFatCobrancaEletronica.fHabilitarDisparoMensagem(
  const AEmail, ASms, AWhatsapp: Boolean): Boolean;
var
  LCamposUpdate : String;
  LQuery        : TUniQuery;

  procedure pAtualizaCampo(const AAtualizar: Boolean; const ACampo: String);
  begin
    If AAtualizar Then
    Begin
      If (Not fEmptyStr(LCamposUpdate)) Then
        LCamposUpdate := LCamposUpdate
                       + ', ';

      LCamposUpdate := LCamposUpdate
                     + ACampo + ' = "N" ';
    End;
  end;
begin
  If (Not AEmail) And
     (Not ASms) And
     (Not AWhatsapp) Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhum tipo de mensagem foi selecionada para disparo!', ['&Ok']);
    Exit(False);
  End;

  LQuery := fCriaQuery;
  Try
    LCamposUpdate := EmptyStr;

    If FblnPermiteEmail Then
      pAtualizaCampo(AEmail,'CBE_EMLENV');

    If FblnPermiteSms Then
      pAtualizaCampo(ASms,'CBE_SMSENV');

    If FblnPermiteWhatsapp Then
      pAtualizaCampo(AWhatsapp,'CBE_WPPENV');

    If (fEmptyStr(LCamposUpdate)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não existe(m) mensagem(ns) configurada(s) para disparo(s)!', ['&Ok']);
      Exit(False);
    End;

    LQuery.SQL.Text := 'UPDATE COBELT '
                     + '   SET '+LCamposUpdate
                     + ' WHERE AUTOINCREM = :AUTINC ';

    LQuery.ParamByName('AUTINC').AsString := FDataSetPedidos.FieldByName('CBEINC').AsString;
    LQuery.ExecSQL;

    Result := True;
  Finally
    FreeAndNil(LQuery);
  End;
end;

end.
