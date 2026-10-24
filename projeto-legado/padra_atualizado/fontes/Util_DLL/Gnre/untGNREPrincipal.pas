unit untGNREPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  cxButtons, EditFocus, Vcl.Mask, MaskEditFocus, cxControls, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCurrencyEdit, cxImageComboBox, cxContainer, cxTextEdit, cxMemo, cxDBEdit,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, System.ImageList, Vcl.ImgList,
  cxImageList, Datasnap.DBClient, UniClientDataSet, MemDS, DBAccess, Uni,
  Datasnap.Provider, UniDataSetProvider, untTLock, System.StrUtils, System.UITypes,
  dxBarBuiltInMenu, cxPC, cxCalendar, cxTimeEdit, untTypesSistema, untFuncoesRel;

type
  TfrmGNREPrincipal = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnImprimirGuias: TBitBtnLocked;
    pnlHeader: TPanel;
    rdgSituacao: TRadioGroup;
    rdbCFOP: TRadioGroup;
    btnConsultar: TBitBtnLocked;
    GroupBox1: TGroupBox;
    mskDtaIni: TMaskEditFocus;
    lbl3: TLabel;
    mskDtaFin: TMaskEditFocus;
    lbl2: TLabel;
    dbgConsulta: TcxGrid;
    dbgConsultaDBView: TcxGridDBTableView;
    dbgConsultaDBViewGER_DTAENT: TcxGridDBColumn;
    dbgConsultaDBViewGER_NUMDOC: TcxGridDBColumn;
    dbgConsultaDBViewGER_ESPDOC: TcxGridDBColumn;
    dbgConsultaDBViewGER_CODEMP: TcxGridDBColumn;
    dbgConsultaDBViewCLI_CODCLI: TcxGridDBColumn;
    dbgConsultaDBViewCLI_NOMCLI: TcxGridDBColumn;
    dbgConsultaDBViewGER_ESTADO: TcxGridDBColumn;
    dbgConsultaDBViewGER_CLAFIS: TcxGridDBColumn;
    dbgConsultaDBViewGER_VLRCON: TcxGridDBColumn;
    dbgConsultaDBViewGER_TOTRET: TcxGridDBColumn;
    dbgConsultaDBViewVAL_FCP: TcxGridDBColumn;
    dbgConsultaDBViewVAL_DIFAL: TcxGridDBColumn;
    dbgConsultaDBViewAUX_GNEAUT: TcxGridDBColumn;
    dbgConsultaDBViewAUX_GNM_ST: TcxGridDBColumn;
    dbgConsultaDBViewAUX_GNEFCP: TcxGridDBColumn;
    dbgConsultaDBViewAUX_GNMFCP: TcxGridDBColumn;
    dbgConsultaDBViewAUX_GNEDFL: TcxGridDBColumn;
    dbgConsultaDBViewAUX_GNMDFL: TcxGridDBColumn;
    dbgConsultaDBViewSELECIONADO: TcxGridDBColumn;
    dbgConsultaDBViewAUX_SEQGER: TcxGridDBColumn;
    dbgConsultalevel: TcxGridLevel;
    Label4: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    dtsConsulta: TDataSource;
    dspConsulta: TUniDataSetProvider;
    qryConsulta: TUniQuery;
    cdsConsulta: TUniClientDataSet;
    mnuBaixaManual: TPopupMenu;
    GuiaGeradaManualmenteST: TMenuItem;
    DesfazerGeraoManualST: TMenuItem;
    cxImageList: TcxImageList;
    GuiaGeradaManualmenteFCP: TMenuItem;
    DesfazerGeraoManualFCP: TMenuItem;
    GuiaGeradaManualmenteDIFAL: TMenuItem;
    DesfazerGeraoManualDIFAL: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    dbgConsultaDBViewAUX_GNRREJ: TcxGridDBColumn;
    btnCertificadoDigital: TBitBtnLocked;
    btnConfiguracoes: TBitBtnLocked;
    dbgConsultaDBViewFIS_AUTINC: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle5: TcxStyle;
    cxStyle6: TcxStyle;
    cxStyle7: TcxStyle;
    cxStyle8: TcxStyle;
    cxStyle9: TcxStyle;
    cxStyle10: TcxStyle;
    cxStyle11: TcxStyle;
    cxStyle12: TcxStyle;
    cxStyle13: TcxStyle;
    cxStyle14: TcxStyle;
    cxStyle16: TcxStyle;
    cxStyle17: TcxStyle;
    cxStyle18: TcxStyle;
    cxStyle19: TcxStyle;
    cxStyle20: TcxStyle;
    cxStyle21: TcxStyle;
    cxStyle22: TcxStyle;
    cxStyle23: TcxStyle;
    pnlMsgWS: TPanel;
    GroupST: TGroupBox;
    dbmST: TcxDBMemo;
    GroupFCP: TGroupBox;
    dbmFCP: TcxDBMemo;
    GroupDIFAL: TGroupBox;
    dbmDIFAL: TcxDBMemo;
    cxStyle15: TcxStyle;
    cxStyle24: TcxStyle;
    cxStyle25: TcxStyle;
    cxStyle26: TcxStyle;
    cxStyle27: TcxStyle;
    cxStyle28: TcxStyle;
    cxStyle29: TcxStyle;
    cxStyle30: TcxStyle;
    cxStyleSelecao: TcxStyle;
    cxStyle32: TcxStyle;
    cxStyle33: TcxStyle;
    cxStyle34: TcxStyle;
    cxStyle35: TcxStyle;
    cxStyle36: TcxStyle;
    GridTableViewStyleSheetUserFormat3: TcxGridTableViewStyleSheet;
    cxStyle37: TcxStyle;
    cxStyle38: TcxStyle;
    cxStyleZebrado: TcxStyle;
    cxStyle40: TcxStyle;
    cxStyle41: TcxStyle;
    cxStyle42: TcxStyle;
    cxStyle43: TcxStyle;
    cxStyle44: TcxStyle;
    cxStyle45: TcxStyle;
    cxStyle46: TcxStyle;
    cxStyle47: TcxStyle;
    dbgConsultaDBViewVAL_FCP_ST: TcxGridDBColumn;
    dbgConsultaDBViewAUX_DTAGNR: TcxGridDBColumn;
    dbgConsultaDBViewAUX_HORGNR: TcxGridDBColumn;
    dbgConsultaDBViewTABELA: TcxGridDBColumn;
    dbgConsultaDBViewNAT_DESCRI: TcxGridDBColumn;
    grpDocumento: TGroupBox;
    lblNumero: TLabel;
    edtNumDoc: TEditFocus;
    btnExportarExcel: TBitBtnLocked;
    edtNomTransp: TEditFocus;
    edtCodTransp: TEditFocus;
    grpTransportadora: TGroupBox;
    grpSerie: TGroupBox;
    lblSerie: TLabel;
    edtSerie: TEditFocus;
    dbgConsultaDBViewGER_SERIE_: TcxGridDBColumn;
    dbgConsultaDBViewCLI_CIDADE: TcxGridDBColumn;
    grpVendedor: TGroupBox;
    edtNomVen: TEditFocus;
    edtCodVen: TEditFocus;
    dbgConsultaDBViewCLI_ESTADO: TcxGridDBColumn;
    dbgConsultaDBViewAUX_TEM_ST: TcxGridDBColumn;
    dbgConsultaDBViewAUX_TEMFCP: TcxGridDBColumn;
    dbgConsultaDBViewAUX_TEMDFL: TcxGridDBColumn;
    btnGuiaApuracao: TBitBtnLocked;
    btnDisponibilidade: TBitBtnLocked;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnImprimirGuiasClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure GuiaGeradaManualmenteSTClick(Sender: TObject);
    procedure DesfazerGeraoManualSTClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure dbgConsultaDBViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure dbgConsultaDBViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgConsultaDBViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfiguracoesClick(Sender: TObject);
    procedure GuiaGeradaManualmenteFCPClick(Sender: TObject);
    procedure GuiaGeradaManualmenteDIFALClick(Sender: TObject);
    procedure DesfazerGeraoManualFCPClick(Sender: TObject);
    procedure DesfazerGeraoManualDIFALClick(Sender: TObject);
    procedure btnCertificadoDigitalClick(Sender: TObject);
    procedure mnuBaixaManualChange(Sender: TObject; Source: TMenuItem;
      Rebuild: Boolean);
    procedure FormResize(Sender: TObject);
    procedure dtsConsultaDataChange(Sender: TObject; Field: TField);
    procedure btnExportarExcelClick(Sender: TObject);
    procedure edtCodTranspKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTranspExit(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenExit(Sender: TObject);
    procedure btnGuiaApuracaoClick(Sender: TObject);
    procedure btnDisponibilidadeClick(Sender: TObject);
  private
    FFecharTela: Boolean;
    FUsaFazenda: Boolean;
    FSemaforoConfirma: Integer;
    FObjLock: TLock;
    FCertificadoPFX: String;
    FCertificadoPEM: String;
    FCertificadoKEY: String;
    FCertificadoSenha: String;
    FSerialCertificado: String;
    function fGetSql: String;
    function fDocumentosSelecionados: Integer;
    procedure pLimpaFiltros;
    function fCodigoDaReceita(AOpcao: Integer; AUF:String): String;
    function fCodigoDaReceitaDareFcp:String;
    function fBaixaManual(AReceita: Integer; ASeqGer: String; AMarcar: Boolean; AIndexFocado : Integer = -1): Boolean;
    function fValidaConfiguracoes: Boolean;
    function fValidaDocumento(AExibirMensagem:Boolean=True): Boolean;
    procedure pSelecionaDocumento;
    procedure pImprimirGuias;
    procedure pConsultar;
    function fGetSqlSituacao: String;
    function fGetCampoEstadoDaGuia: String;
    function fExisteFinanceiro(ACodigoDaReceita, AChaveDeAcesso: String; AConsulta: Boolean=False): Boolean;
    function fCarregaCertificadoDigital: Boolean;
    function fValidaOpenSSLCertificadoPFX: Boolean;
    function fValidaCapicom: Boolean;
    function fUsaCapicomSemCertificadoPFX: Boolean;
    function fCargaInicial: Boolean;
    function fExisteFinanceiroBaixado(AChaveDeAcesso: String): Boolean;
    function fValidaExisteFinanceiro(AExibirMensagem: Boolean): Boolean;
    function fValidaNFeRioDeJaneiro(AExibirMensagem:Boolean=True):Boolean;
    function fValidaSelecionado(AExibirMensagem: Boolean): Boolean;
    function fValidaArquivosCertificadoDigital(APathOpenSSL:String): Boolean;
    function fValidaExisteFinanceiroBaixado: Boolean;
    function fValidaCertificadoSerial: Boolean;
    procedure pMarcarTodos;
    procedure pDesmarcarTodos;
    procedure pHabilitaImpressao;
    procedure pAjustaGrid;
    function fReceitaUtilizadaNaUF(AUF: String; AOpcao: Integer): Boolean;
    procedure pDesmarcaDocumento;
    procedure pMarcaDocumento;
    procedure pCarregaDocumentosParaImpressao;
    procedure pCarregaDocumentosParaExportacao;
    function fDocumentoSemBaixaManual(AExibirMensagem: Boolean): Boolean;
    function fValidaEstadosSuportados(AExibirMensagem:Boolean):Boolean;
    function fAtualizaDocumentosQueTemGNRE: Boolean;
    procedure pAtualizaDocumentosQueTemGNRE;
    function fExisteTabelaDeRegrasDePreenchimento: Boolean;
    procedure pHabilitaGuiasPorApuracao;
    function fValidaExportacaoAutomaticaDeGuiasPDF: Boolean;
    function fBaixaManualTodosSelecionados(AReceita: Integer; AMarcar: Boolean): Boolean;
    function fSelecionadoMesmaReceita(AReceita, AIndexRecord: Integer) : Boolean;
    function fExisteDocumentoSelecionado : Boolean;
    function fExisteDocumentoSelecionadoPorReceita(AReceita : Integer; ASomenteGeradosManualmente : Boolean = False) : Boolean;
    function fDocumentoSelecionadoComBaixaManual(AReceita, AIndexRecord: Integer): Boolean;
    function fValidaTodasGuiasGeradas(AExibirMensagem: Boolean): Boolean;
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmGNREPrincipal: TfrmGNREPrincipal;

implementation

uses untFuncoesSimples, untGravando, untGNREModulo, untGNREConfirmacao, untGNRERegrasDePreenchimento, untGNREGuiasPorApuracao, untGNREDisponibilidade, untConsultas, untModulo;

const
  UF       = 'AC_AL_AM_AP_BA_CE_DF_ES_GO_MA_MG_MS_MT_PA_PB_PE_PI_PR_RJ_RN_RO_RR_RS_SC_SE_SP_TO_';
  UF_ST    = 'AC_AL_AM_AP_BA_CE_DF_ES_GO_MA_MG_MS_MT_PA_PB_PE_PI_PR_RJ_RN_RO_RR_RS_SC_SE_TO_';
  UF_FCP   = 'AL_AM_BA_CE_DF_ES_GO_MA_MG_MS_MT_PB_PE_PI_RN_RS_SE_TO_';
  UF_DIFAL = 'AC_AL_AM_AP_BA_CE_DF_ES_GO_MA_MG_MS_MT_PA_PB_PE_PI_PR_RJ_RN_RO_RR_RS_SC_SE_TO_';

{$R *.dfm}

function TfrmGNREPrincipal.fReceitaUtilizadaNaUF(AUF: String; AOpcao: Integer): Boolean;
var
  LUFs: String;
Begin
  case AOpcao of
    0: LUFs := UF_ST;
    1: LUFs := UF_FCP;
    2: LUFs := UF_DIFAL;
  end;

  Result := (Pos(AUF, LUFs) > 0);
End;

function TfrmGNREPrincipal.fSelecionadoMesmaReceita(AReceita, AIndexRecord: Integer): Boolean;
var
  intColIndex : Integer;
  blnSelecionado : Boolean;
  blnTemFCPST : Boolean;
begin
  blnSelecionado := VarToStr(dbgConsultaDBView.DataController.Values[AIndexRecord, dbgConsultaDBViewSELECIONADO.Index]) = 'S';
  if not blnSelecionado then
    Exit(False);

  case AReceita of
    0: intColIndex := dbgConsultaDBViewAUX_TEM_ST.Index;
    1: intColIndex := dbgConsultaDBViewAUX_TEMFCP.Index;
    2: intColIndex := dbgConsultaDBViewAUX_TEMDFL.Index;
  else
    Exit(False);
  end;

  if AReceita = 1 then
  begin
    blnTemFCPST := dbgConsultaDBView.DataController.Values[AIndexRecord, dbgConsultaDBViewVAL_FCP_ST.Index] > 0;
    if blnTemFCPST then
      Exit(True);
  end;

  if VarToStr(dbgConsultaDBView.DataController.Values[AIndexRecord, intColIndex]) = 'S' then
    Exit(True);

  Result := False;
end;

function TfrmGNREPrincipal.fValidaCampos(Sender: TWinControl;  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  Try
    If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Begin
      If (Sender = mskDtaIni) Then
      Begin
        mskDtaFin.Enabled := True;

        If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          mskDtaFin.Clear;
          mskDtaFin.Enabled := False;
          Exit;
        End;

      End;

      If (Sender = mskDtaFin) Then
      Begin
        If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&Ok']);
            Result := False;
            Exit;
          End;

          If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&Ok']);
            Result := False;
            Exit;
          End
        End;
      End;

      If (Sender = edtCodTransp) Then
      Begin
        If fEmptyStr(edtCodTransp.Text) Then
        Begin
          edtNomTransp.Clear;
        End
        Else
        Begin
          if Length(edtCodTransp.Text) < edtCodTransp.TamCampo then
            edtCodTransp.Text := fStrZero(edtCodTransp.Text, edtCodTransp.TamCampo);

          edtNomTransp.Text := fRetNomTransportadora(edtCodTransp.Text);
          If fEmptyStr(edtNomTransp.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa transportadora não está cadastrada!', ['&Ok']);
            Result := False;
          End;
        End;
      End;

      If (Sender = edtCodVen) Then
      Begin
        If fEmptyStr(edtCodVen.Text) Then
        Begin
          edtNomVen.Clear;
        End
        Else
        Begin
          If (Length(edtCodVen.Text) < edtCodVen.TamCampo) And fIsNumber(edtCodVen.Text) Then
            edtCodVen.Text := fStrZero(edtCodVen.Text, edtCodVen.TamCampo);

          edtNomVen.Text := fRetNomVendRep(edtCodVen.Text);
          If fEmptyStr(edtNomVen.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End;

  Finally
    If Not Result Then
      pSetFocus(Sender);
  End;

end;

procedure TfrmGNREPrincipal.pLimpaFiltros;
begin
  FObjLock.pDestravarTodos;
  cdsConsulta.Close;
end;

procedure TfrmGNREPrincipal.btnCertificadoDigitalClick(Sender: TObject);
begin
  inherited;
  FSerialCertificado := fGetCertificado;
end;

procedure TfrmGNREPrincipal.btnConfiguracoesClick(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmGNRERegrasDePreenchimento, frmGNRERegrasDePreenchimento);
  Try
    frmGNRERegrasDePreenchimento.FApuracao    := False;
    frmGNRERegrasDePreenchimento.FHomologacao := False;
    frmGNRERegrasDePreenchimento.ShowModal;
  Finally
    pFreeAndNil(frmGNRERegrasDePreenchimento);
  End;
end;

function TfrmGNREPrincipal.fValidaCertificadoSerial:Boolean;
begin
  Result := True;

  If not fCfgSis('CAPCOM', varBoolean) Then
    Exit;

  Result := Assigned(fGetCertificadoSerial(FSerialCertificado));
end;

function TfrmGNREPrincipal.fUsaCapicomSemCertificadoPFX: Boolean;
begin
  Result := False;

  If not fCfgSis('CAPCOM', varBoolean) Then
    Exit;

  If fCfgSis('USAPFX', varBoolean) Then
    Exit;

  Result := True;
end;

function TfrmGNREPrincipal.fValidaCapicom: Boolean;
begin
  Result := False;

  If not fCfgSis('CAPCOM', varBoolean) Then
    Exit;

  If not fEmptyStr(FSerialCertificado) Then
    Exit;

  Result := True;
end;

function TfrmGNREPrincipal.fValidaOpenSSLCertificadoPFX: Boolean;
begin
  Result := False;

  If fCfgSis('CAPCOM', varBoolean) Then
    Exit;

  If not fEmptyStr(FCertificadoPFX) Then
    Exit;

  Result := True;
end;

function TfrmGNREPrincipal.fValidaExisteFinanceiroBaixado:Boolean;
var
  LRecno: Integer;
Begin
  Result := False;

  LRecno := cdsConsulta.recno;
  Try
    cdsConsulta.DisableControls;
    cdsConsulta.First;
    While not cdsConsulta.eof Do
    Begin
      If cdsConsulta.FieldByName('SELECIONADO').AsString = 'S' Then
      Begin
        Result := fExisteFinanceiroBaixado(cdsConsulta.FieldByName('FIS_ACESSO').AsString);
      End;

      If Result Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitido selecionar documento com contas a pagar baixado'+#13+
                              'Documento: ['+cdsConsulta.FieldByName('GER_NUMDOC').AsString+']'+#13+
                              'Cliente: ['+cdsConsulta.FieldByName('GER_CODCLI').AsString+'-'+cdsConsulta.FieldByName('CLI_NOMCLI').AsString+']', ['&Ok']);
        Break;
      End;

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.Recno := LRecno;
    cdsConsulta.EnableControls;
  End;

end;

procedure TfrmGNREPrincipal.btnConfirmaClick(Sender: TObject);
var
  LDocSel: Integer;
begin
  inherited;
  If not cdsConsulta.isEmpty Then
  Begin
    If fValidaCapicom Then
    Begin
      fMensagem('ATENÇÃO!', 'Selecione o Certificado Digital!', ['&Ok']);
      Exit;
    End;

    If not fValidaCertificadoSerial Then
    Begin
      fMensagem('ATENÇÃO!', 'Certificado Digital Inválido.'+#13+
                            'Selecione o Certificado Digital!', ['&Ok']);
      Exit;
    End;

    If fValidaOpenSSLCertificadoPFX Then
    Begin
      fMensagem('ATENÇÃO!', 'Necessário cadastrar o Certificado Digital.'+#13+
                            'Acesse: Cadastro de Empresas [Certificado Digital].', ['&Ok']);
      Exit;
    End;

    If fValidaExisteFinanceiroBaixado Then
      Exit;

    cdsConsulta.DisableControls;
    try
      cdsConsulta.First;
      while not cdsConsulta.Eof do
      begin
        If cdsConsulta.FieldByName('SELECIONADO').AsString = 'S' Then
        begin
          if not fDocumentoSemBaixaManual(False) then
            pDesmarcaDocumento;

          if not fValidaEstadosSuportados(True) then
            Abort;

          if not fValidaNFeRioDeJaneiro(True) then
            Abort;
        end;

        cdsConsulta.Next;
      end;
    finally
      cdsConsulta.EnableControls;
    end;

    If (InterlockedIncrement(FSemaforoConfirma) = 0) Then
    Begin
      Try
        LDocSel := fDocumentosSelecionados;

        If LDocSel > 0 Then
        Begin
          If (fMensagem('', 'Foi selecionado ' + IntToStr(LDocSel) + ' documento(s).' + #13 +
                            'Deseja confirmar a operação ?', ['&Sim', '&Não']) = 1) Then
          Begin
            frmGNREConfirmacao := TfrmGNREConfirmacao.Create(Application);
            Try
              frmGNREConfirmacao.cdsConsulta.Data   := cdsConsulta.Data;
              frmGNREConfirmacao.FCertificadoPFX    := FCertificadoPFX;
              frmGNREConfirmacao.FCertificadoPEM    := FCertificadoPEM;
              frmGNREConfirmacao.FCertificadoKEY    := FCertificadoKEY;
              frmGNREConfirmacao.FCertificadoSenha  := FCertificadoSenha;
              frmGNREConfirmacao.FSerialCertificado := FSerialCertificado;
              frmGNREConfirmacao.FSituacao          := rdgSituacao.ItemIndex;
              frmGNREConfirmacao.ShowModal;

              btnConsultar.OnClick(sender);

            Finally
              pFreeAndNil(frmGNREConfirmacao);
            End;
          End;
        End
        Else
        begin
          pMensagemOk('Nenhum documento foi selecionado!');
          btnConsultar.OnClick(sender);
        end;
      Finally
        InterlockedDecrement(FSemaforoConfirma);
      End;
    End
    Else
      InterlockedDecrement(FSemaforoConfirma);
  End;
end;

function TfrmGNREPrincipal.fGetSqlSituacao: String;
begin
  Case rdgSituacao.ItemIndex of
    0: Begin
         Result := ' AND (IF( AUX_TEM_ST = "S", AUX_TEM_ST = "S" AND ((C.AUX_GNEAUT = "S") OR (C.AUX_GNM_ST = "S")), TRUE ) AND '+
                   '      IF( AUX_TEMFCP = "S", AUX_TEMFCP = "S" AND ((C.AUX_GNEFCP = "S") OR (C.AUX_GNMFCP = "S")), TRUE ) AND '+
                   '      IF( AUX_TEMDFL = "S", AUX_TEMDFL = "S" AND ((C.AUX_GNEDFL = "S") OR (C.AUX_GNMDFL = "S")), TRUE ))    ';
       End;
    1: Begin
         Result := ' AND (IF( AUX_TEM_ST = "S", AUX_TEM_ST = "S" AND ((C.AUX_GNEAUT = "N") AND (C.AUX_GNM_ST = "N")), FALSE ) OR '+
                   '      IF( AUX_TEMFCP = "S", AUX_TEMFCP = "S" AND ((C.AUX_GNEFCP = "N") AND (C.AUX_GNMFCP = "N")), FALSE ) OR '+
                   '      IF( AUX_TEMDFL = "S", AUX_TEMDFL = "S" AND ((C.AUX_GNEDFL = "N") AND (C.AUX_GNMDFL = "N")), FALSE ))   ';
       End;
  End;
end;

function TfrmGNREPrincipal.fGetCampoEstadoDaGuia: String;
begin
  Result := ' H.CID_ESTADO ';

  If not fCfgSis('GNR_UF', varBoolean) Then
    Exit;

  Result := ' IF(IFNULL(AUX_ABF_UF, "") = "", H.CID_ESTADO, AUX_ABF_UF) ';
end;

function TfrmGNREPrincipal.fGetSql: String;
Begin
  Result := '';
  Result := Result + ' SELECT   ';
  Result := Result + '   "N" AS SELECIONADO,     ';
  Result := Result + '   "MOVGER" AS TABELA, ';
  Result := Result + fGetCampoEstadoDaGuia + ' AS GER_ESTADO, ';
  Result := Result + '   AUX_ABF_UF,         ';
  Result := Result + '   GER_DTAENT,         ';
  Result := Result + '   GER_NUMDOC,         ';
  Result := Result + '   CONCAT(GER_NUMDOC, GER_ESPDOC, GER_CODEMP, GER_CODCLI) AS GER_DOCUME, ';
  Result := Result + '   GER_ESPDOC,         ';
  Result := Result + '   GER_CODEMP,         ';
  Result := Result + '   GER_SERIE_,         ';
  Result := Result + '   GER_CODCLI,         ';
  Result := Result + '   GER_CLAFIS,         ';
  Result := Result + '   NAT_DESCRI,         ';
  Result := Result + '   (SELECT CAST(GROUP_CONCAT(DISTINCT DET_CLAFIS) AS CHAR(25)) FROM MOVDET ';
  Result := Result + '    WHERE MOVDET.DET_SEQGER = MOVGER.AUTOINCREM) AS DET_CLAFIS, ';
  Result := Result + '   CLI_NOMCLI,         ';
  Result := Result + '   CLI_NOMCLI AS CLI_RAZSOC, ';
  Result := Result + '   CLI_CGCCPF,         ';
  Result := Result + '   CLI_C_G_C_,         ';
  Result := Result + '   CLI_I_E_S_,         ';
  Result := Result + '   CONCAT(CLI_ENDERE, ", ", IFNULL(CLI_ENDNUM,""), IF(IFNULL(CLI_ENDCOM, "") = "", "", CONCAT("  ", CLI_ENDCOM)),"") AS CLI_ENDERE, ';
  Result := Result + '   CLI_BAIRRO,         ';
  Result := Result + '   CLI_C_E_P_,         ';
  Result := Result + '   CLI_FONE01,         ';
  Result := Result + '   CONCAT(SUBSTRING(GER_DTAENT,6,2),SUBSTRING(GER_DTAENT,1,4))  AS GER_PERIOD, ';
  Result := Result + '   GER_VLRCON,         ';
  Result := Result + '   GER_TOTRET,         ';
  Result := Result + '   EMP_C_G_C_,         ';
  Result := Result + '   EMP_I_E_S_,         ';
  Result := Result + '   EMP_NOMEMP,         ';
  Result := Result + '   EMP_NOMEMP AS EMP_RAZSOC, ';
  Result := Result + '   CONCAT(EMP_ENDERE, ", ", IFNULL(EMP_ENDNUM,""), IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP)),"") AS EMP_ENDERE, ';
  Result := Result + '   EMP_BAIRRO,         ';
  Result := Result + '   EMP_C_E_P_,         ';
  Result := Result + '   EMP_FONE01,         ';
  Result := Result + '   A.CID_NOMCID AS EMP_CIDADE,  ';
  Result := Result + '   A.CID_ESTADO AS EMP_ESTADO,  ';
  Result := Result + '   B.CID_NOMCID AS CLI_CIDADE,  ';
  Result := Result + '   B.CID_ESTADO AS CLI_ESTADO,  ';
  Result := Result + '   "AUXMOV" AS TABAUX,          ';
  Result := Result + '   C.AUX_DTAGNR, ';
  Result := Result + '   C.AUX_HORGNR, ';
  Result := Result + '   C.AUX_GNEAUT, ';
  Result := Result + '   C.AUX_GNEFCP, ';
  Result := Result + '   C.AUX_GNEDFL, ';
  Result := Result + '   C.AUX_GNM_ST, ';
  Result := Result + '   C.AUX_GNMFCP, ';
  Result := Result + '   C.AUX_GNMDFL, ';
  Result := Result + '   C.AUX_SEQGER, ';
  Result := Result + '   C.AUX_GNRREJ, ';
  Result := Result + '   C.AUX_ST_REJ, ';
  Result := Result + '   C.AUX_FCPREJ, ';
  Result := Result + '   C.AUX_DFLREJ, ';
  Result := Result + '   C.AUX_TEM_ST, ';
  Result := Result + '   C.AUX_TEMFCP, ';
  Result := Result + '   C.AUX_TEMDFL, ';
  Result := Result + '   EMP_CODCID, ';
  Result := Result + '   CLI_CODCID, ';

  If FUsaFazenda Then
    Result := Result + '   IF(FAZ_CODCID IS NULL, H.CID_CODCID, FAZ_CODCID) AS MUNICIPIO_DESTINATARIO, '
  Else
    Result := Result + '   H.CID_CODCID AS MUNICIPIO_DESTINATARIO, ';

  Result := Result + '   FIS_ACESSO, ';
  Result := Result + '   F.AUTOINCREM AS FIS_AUTINC, ';

  Result := Result + '   IFNULL((SELECT SUM(ICD_VALFCP) FROM MOVICD ';
  Result := Result + '   INNER JOIN MOVDET ON MOVICD.ICD_SEQGER = MOVDET.AUTOINCREM ';
  Result := Result + '   WHERE MOVDET.DET_VALRET = 0 ';
  Result := Result + '     AND MOVDET.DET_PROEMB <> "S" ';
  Result := Result + '     AND MOVDET.DET_SEQGER = MOVGER.AUTOINCREM),0) AS VAL_FCP, ';

  Result := Result + '   IFNULL((SELECT SUM(DET_VFCPST) FROM MOVTRI ';
  Result := Result + '   INNER JOIN MOVDET ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
  Result := Result + '   WHERE MOVDET.DET_VALRET > 0 ';
  Result := Result + '     AND MOVDET.DET_PROEMB <> "S" ';
  Result := Result + '     AND MOVDET.DET_SEQGER = MOVGER.AUTOINCREM),0) AS VAL_FCP_ST, ';

  Result := Result + '   IFNULL((SELECT SUM(ICD_VALDES) FROM MOVICD ';
  Result := Result + '   INNER JOIN MOVDET ON ICD_SEQGER = MOVDET.AUTOINCREM ';
  Result := Result + '   WHERE MOVDET.DET_PROEMB <> "S" ';
  Result := Result + '     AND MOVDET.DET_SEQGER = MOVGER.AUTOINCREM),0) AS VAL_DIFAL, ';

  Result := Result + '   CONCAT("MOVGER", MOVGER.AUTOINCREM) AS AUTOINCREM  ';
  Result := Result + ' FROM ';
  Result := Result + '   MOVGER ';
  Result := Result + '   INNER JOIN CADCLI ON GER_CODCLI = CLI_CODCLI ';
  Result := Result + '   INNER JOIN CADEMP ON GER_CODEMP = EMP_CODEMP ';
  Result := Result + '   INNER JOIN CADCID A ON EMP_CODCID = A.CID_CODCID ';
  Result := Result + '   INNER JOIN CADCID B ON CLI_CODCID = B.CID_CODCID ';
  Result := Result + '   INNER JOIN AUXMOV C ON MOVGER.AUTOINCREM = C.AUX_SEQGER ';

  If FUsaFazenda Then
    Result := Result + '   LEFT  JOIN CADFAZ ON CADFAZ.FAZ_CODFAZ = C.AUX_CODFAZ ';

  Result := Result + '   LEFT  JOIN NATCFO D ON D.AUTOINCREM = C.AUX_NATCFO ';
  Result := Result + '   INNER JOIN CADFIS F ';
  Result := Result + '        ON MOVGER.GER_NUMDOC = F.FIS_NUMDOC ';
  Result := Result + '       AND MOVGER.GER_ESPDOC = F.FIS_ESPDOC ';
  Result := Result + '       AND MOVGER.GER_CODEMP = F.FIS_CODEMP ';
  Result := Result + '       AND MOVGER.GER_CODCLI = F.FIS_FORCLI ';
  Result := Result + '   LEFT  JOIN ENTCLI G ';
  Result := Result + '        ON G.AUTOINCREM = C.AUX_ENTGER ';
  Result := Result + '       AND G.ETC_CODCLI = CADCLI.CLI_CODCLI ';
  Result := Result + '   LEFT  JOIN CADCID H ';
  Result := Result + '        ON H.CID_CODCID = IF(IFNULL(CLI_REGFIS, "") = "2", ';
  Result := Result + '                             IF((IFNULL(C.AUX_VENPRE, "") = "S") AND (IFNULL(C.AUX_ENTGER, "") = ""), ';
  Result := Result + '                                 IFNULL(GER_CIDCON, CLI_CODCID), IFNULL(G.ETC_CIDENT, GER_CIDCON)), IFNULL(GER_CIDCON, CLI_CODCID)) ';
  Result := Result + ' WHERE GER_TIP_FC = "C" ';
  Result := Result + '   AND LENGTH(FIS_ACESSO) > 0 ';
  Result := Result + '   AND LEFT(GER_CLAFIS,1) >= 5 ';
  Result := Result + '   AND GER_ORIDOC = "V" ';
  Result := Result + '   AND GER_ESPDOC = "NF" ';
  Result := Result + '   AND GER_CODEMP = ' + QuotedStr(VS_strCodEmp);
  Result := Result + '   AND LOCATE('+fGetCampoEstadoDaGuia+' , '+ QuotedStr(UF) +') > 0 ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Result := Result + ' AND GER_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  If Not fEmptyStr(edtNumDoc.Text) Then
    Result := Result + ' AND GER_NUMDOC = ' + QuotedStr(edtNumDoc.Text);

  If Not fEmptyStr(edtCodTransp.Text) Then
    Result := Result + ' AND GER_CODTRA = ' + QuotedStr(edtCodTransp.Text);

  If Not fEmptyStr(edtCodVen.Text) Then
    Result := Result + ' AND GER_CODVEN = ' + QuotedStr(edtCodVen.Text);

  If Not fEmptyStr(edtSerie.Text) Then
    Result := Result + ' AND GER_SERIE_ = ' + QuotedStr(edtSerie.Text);

  If rdbCFOP.ItemIndex = 1 Then
  Begin
    Result := Result + ' AND LOCATE(GER_CLAFIS, '+ QuotedStr(VS_strClaVen) +') > 0 ';
    Result := Result + ' AND LOCATE(GER_CLAFIS, '+ QuotedStr(VS_strClaDev) +') = 0 ';
  End;

  Result := Result + ' AND (SELECT COUNT(EMP_INSSUB) FROM EMPISB ';
  Result := Result + '      WHERE (TRIM(EMPISB.EMP_INSSUB) <> "" OR EMPISB.EMP_CADSIM = "S") ';
  Result := Result + '        AND EMPISB.EMP_CODEMP = MOVGER.GER_CODEMP ';
  Result := Result + '        AND EMPISB.EMP_ESTADO = '+fGetCampoEstadoDaGuia+') = 0 ';

  Result := Result + ' AND ((AUX_TEM_ST = "S") OR (AUX_TEMFCP = "S") OR (AUX_TEMDFL = "S")) ';

  Result := Result +  fGetSqlSituacao;

  Result := Result + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Result, 'MOVGER', 'NOTGER'), 'AUXMOV', 'AUXNOT'), 'MOVDET', 'NOTDET'), 'MOVTRI', 'NOTTRI'), 'MOVICD', 'NOTICD');

  Result := Result + ' ORDER BY  ';
  Result := Result + IIF(rdgSituacao.ItemIndex = 0,' AUX_DTAGNR DESC, AUX_HORGNR DESC, ','');
  Result := Result + '   GER_ESTADO, ';
  Result := Result + '   GER_DTAENT DESC, ';
  Result := Result + '   GER_ESPDOC DESC, ';
  Result := Result + '   GER_NUMDOC DESC  ';
End;

procedure TfrmGNREPrincipal.pConsultar;
begin
  FObjLock.pDestravarTodos;

  cdsConsulta.Close;

  qryConsulta.Close;
  qryConsulta.SQL.Text := fGetSql;

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin
    qryConsulta.ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
    qryConsulta.ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
  End;

  qryConsulta.Open;

  If Assigned(dspConsulta.DataSet) Then
    pSetaClient(dspConsulta.DataSet);

  cdsConsulta.Open;

  If qryConsulta.isEmpty Then
    pMensagemOk('Nenhum documento foi encontrado com estes filtros!')
  Else
    pSetFocus(dbgConsulta);
end;

procedure TfrmGNREPrincipal.pHabilitaImpressao;
begin
  btnImprimirGuias.Enabled := (rdgSituacao.ItemIndex = 0);
end;

procedure TfrmGNREPrincipal.btnConsultarClick(Sender: TObject);
begin
  inherited;
  pLimpaFiltros;

  pAjustaGrid;

  pHabilitaImpressao;

  If fVerificaCampos Then
  Begin
    TfrmGravando.fExecutarModalA(pConsultar, 'Carregando documentos . . .', '');
  End;
end;

procedure TfrmGNREPrincipal.pDesmarcarTodos;
var
  LIndex   : Integer;
  LAutInc  : String;
  LContador: Integer;
begin
  Try
    cdsConsulta.DisableControls;
    For LContador := 0 to dbgConsultaDBView.DataController.FilteredRecordCount - 1 do
    begin
      LIndex  := dbgConsultaDBView.DataController.FilteredRecordIndex[LContador];
      LAutInc := dbgConsultaDBView.DataController.Values[LIndex, dbgConsultaDBViewFIS_AUTINC.Index];

      if cdsConsulta.Locate('FIS_AUTINC', LAutInc, []) then
      begin
        cdsConsulta.Edit;
        cdsConsulta.FieldByName('SELECIONADO').AsString := 'N';
        cdsConsulta.Post;

        FObjLock.fLock_Unlock('GNRE' + cdsConsulta.FieldByName('GER_NUMDOC').AsString +
                                       cdsConsulta.FieldByName('GER_ESPDOC').AsString +
                                       cdsConsulta.FieldByName('GER_CODEMP').AsString, False, False);
      end;

      If (LContador Mod 20 = 0) Then
        Application.ProcessMessages;
    end;
  Finally
    cdsConsulta.First;
    cdsConsulta.EnableControls
  End;
end;

procedure TfrmGNREPrincipal.btnDesmarcaTodosClick(Sender: TObject);
begin
  If not cdsConsulta.isEmpty Then
  Begin
    TfrmGravando.fExecutarModalA(pDesmarcarTodos, 'Desmarcando documentos . . .', '');
  End;
end;


procedure TfrmGNREPrincipal.pCarregaDocumentosParaExportacao;
var
  qryGnrPri: TUniQuery;
  intRecNo: Integer;
begin

  qryGnrPri := fCriaQuery;

  qryGnrPri.SQL.Clear;
  qryGnrPri.SQL.Add('DROP TEMPORARY TABLE IF EXISTS TMP_GNRPRI;');
  qryGnrPri.SQL.Add('CREATE TEMPORARY TABLE TMP_GNRPRI(        ');
  qryGnrPri.SQL.Add('  TMP_GNRREJ CHAR(1),       ');
  qryGnrPri.SQL.Add('  TMP_DTAGNR DATE,          ');
  qryGnrPri.SQL.Add('  TMP_HORGNR TIME,          ');
  qryGnrPri.SQL.Add('  TMP_DTAENT DATE,          ');
  qryGnrPri.SQL.Add('  TMP_NUMDOC VARCHAR(12),   ');
  qryGnrPri.SQL.Add('  TMP_ESPDOC CHAR(2),       ');
  qryGnrPri.SQL.Add('  TMP_CODEMP CHAR(3),       ');
  qryGnrPri.SQL.Add('  TMP_CODCLI VARCHAR(8),    ');
  qryGnrPri.SQL.Add('  TMP_NOMCLI VARCHAR(60),   ');
  qryGnrPri.SQL.Add('  TMP_ESTADO CHAR(2),       ');
  qryGnrPri.SQL.Add('  TMP_CLAFIS VARCHAR(4),    ');
  qryGnrPri.SQL.Add('  TMP_DESCRI VARCHAR(50),   ');
  qryGnrPri.SQL.Add('  TMP_VLRCON DECIMAL(12,2), ');
  qryGnrPri.SQL.Add('  TMP_TOTRET DECIMAL(12,2), ');
  qryGnrPri.SQL.Add('  TMP_FCP_ST DECIMAL(12,2), ');
  qryGnrPri.SQL.Add('  TMP_DIFAL_ DECIMAL(15,2), ');
  qryGnrPri.SQL.Add('  TMP_F_C_P_ DECIMAL(15,2), ');
  qryGnrPri.SQL.Add('  TMP_GNEAUT CHAR(1),       ');
  qryGnrPri.SQL.Add('  TMP_GNEFCP CHAR(1),       ');
  qryGnrPri.SQL.Add('  TMP_GNEDFL CHAR(1),       ');
  qryGnrPri.SQL.Add('  TMP_GNM_ST CHAR(1),       ');
  qryGnrPri.SQL.Add('  TMP_GNMFCP CHAR(1),       ');
  qryGnrPri.SQL.Add('  TMP_GNMDFL CHAR(1),       ');
  qryGnrPri.SQL.Add('  TMP_SEQGER VARCHAR(20),   ');
  qryGnrPri.SQL.Add('  TMP_AUTINC VARCHAR(20),   ');
  qryGnrPri.SQL.Add('  TMP_TABELA VARCHAR(6)     ');
  qryGnrPri.SQL.Add(');                          ');
  qryGnrPri.ExecSQL;

  qryGnrPri.SQL.Clear;
  qryGnrPri.SQL.Add('INSERT INTO TMP_GNRPRI(');
  qryGnrPri.SQL.Add('  TMP_GNRREJ, TMP_DTAGNR, TMP_HORGNR, TMP_DTAENT, TMP_NUMDOC, TMP_ESPDOC, TMP_CODEMP, ');
  qryGnrPri.SQL.Add('  TMP_CODCLI, TMP_NOMCLI, TMP_ESTADO, TMP_CLAFIS, TMP_DESCRI, TMP_VLRCON, TMP_TOTRET, ');
  qryGnrPri.SQL.Add('  TMP_FCP_ST, TMP_DIFAL_, TMP_F_C_P_, TMP_GNEAUT, TMP_GNEFCP, TMP_GNEDFL, TMP_GNM_ST, ');
  qryGnrPri.SQL.Add('  TMP_GNMFCP, TMP_GNMDFL, TMP_SEQGER, TMP_AUTINC, TMP_TABELA ');
  qryGnrPri.SQL.Add(')VALUES(');
  qryGnrPri.SQL.Add('  :GNRREJ, :DTAGNR, :HORGNR, :DTAENT, :NUMDOC, :ESPDOC, :CODEMP, ');
  qryGnrPri.SQL.Add('  :CODCLI, :NOMCLI, :ESTADO, :CLAFIS, :DESCRI, :VLRCON, :TOTRET, ');
  qryGnrPri.SQL.Add('  :FCP_ST, :DIFAL_, :F_C_P_, :GNEAUT, :GNEFCP, :GNEDFL, :GNM_ST, ');
  qryGnrPri.SQL.Add('  :GNMFCP, :GNMDFL, :SEQGER, :AUTINC, :TABELA ');
  qryGnrPri.SQL.Add(');');

  intRecno := cdsConsulta.RecNo;
  try
    cdsConsulta.DisableControls;

    cdsConsulta.First;
    while not cdsConsulta.Eof do
    begin
      if cdsConsulta.FieldByName('SELECIONADO').AsString = 'S' then
      Begin

        qryGnrPri.ParamByName('GNRREJ').AsString := cdsConsulta.FieldByName('AUX_GNRREJ').AsString;
        qryGnrPri.ParamByName('DTAGNR').AsDate   := cdsConsulta.FieldByName('AUX_DTAGNR').AsDateTime;
        qryGnrPri.ParamByName('HORGNR').AsTime   := cdsConsulta.FieldByName('AUX_HORGNR').AsDateTime;
        qryGnrPri.ParamByName('DTAENT').AsDate   := cdsConsulta.FieldByName('GER_DTAENT').AsDateTime;
        qryGnrPri.ParamByName('NUMDOC').AsString := cdsConsulta.FieldByName('GER_NUMDOC').AsString;
        qryGnrPri.ParamByName('ESPDOC').AsString := cdsConsulta.FieldByName('GER_ESPDOC').AsString;
        qryGnrPri.ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('GER_CODEMP').AsString;
        qryGnrPri.ParamByName('CODCLI').AsString := cdsConsulta.FieldByName('GER_CODCLI').AsString;
        qryGnrPri.ParamByName('NOMCLI').AsString := cdsConsulta.FieldByName('CLI_NOMCLI').AsString;
        qryGnrPri.ParamByName('ESTADO').AsString := cdsConsulta.FieldByName('GER_ESTADO').AsString;
        qryGnrPri.ParamByName('CLAFIS').AsString := cdsConsulta.FieldByName('DET_CLAFIS').AsString;
        qryGnrPri.ParamByName('DESCRI').AsString := cdsConsulta.FieldByName('NAT_DESCRI').AsString;
        qryGnrPri.ParamByName('VLRCON').AsFloat  := cdsConsulta.FieldByName('GER_VLRCON').AsFloat;
        qryGnrPri.ParamByName('TOTRET').AsFloat  := cdsConsulta.FieldByName('GER_TOTRET').AsFloat;
        qryGnrPri.ParamByName('FCP_ST').AsFloat  := cdsConsulta.FieldByName('VAL_FCP_ST').AsFloat;
        qryGnrPri.ParamByName('DIFAL_').AsFloat  := cdsConsulta.FieldByName('VAL_DIFAL').AsFloat;
        qryGnrPri.ParamByName('F_C_P_').AsFloat  := cdsConsulta.FieldByName('VAL_FCP').AsFloat;
        qryGnrPri.ParamByName('GNEAUT').AsString := cdsConsulta.FieldByName('AUX_GNEAUT').AsString;
        qryGnrPri.ParamByName('GNEFCP').AsString := cdsConsulta.FieldByName('AUX_GNEFCP').AsString;
        qryGnrPri.ParamByName('GNEDFL').AsString := cdsConsulta.FieldByName('AUX_GNEDFL').AsString;
        qryGnrPri.ParamByName('GNM_ST').AsString := cdsConsulta.FieldByName('AUX_GNM_ST').AsString;
        qryGnrPri.ParamByName('GNMFCP').AsString := cdsConsulta.FieldByName('AUX_GNMFCP').AsString;
        qryGnrPri.ParamByName('GNMDFL').AsString := cdsConsulta.FieldByName('AUX_GNMDFL').AsString;
        qryGnrPri.ParamByName('SEQGER').AsString := cdsConsulta.FieldByName('AUX_SEQGER').AsString;
        qryGnrPri.ParamByName('AUTINC').AsString := cdsConsulta.FieldByName('FIS_AUTINC').AsString;
        qryGnrPri.ParamByName('TABELA').AsString := cdsConsulta.FieldByName('TABELA').AsString;

        qryGnrPri.ExecSQL;

      end;
      cdsConsulta.Next;
    end;

  finally
    cdsConsulta.Recno := intRecno;
    cdsConsulta.EnableControls;
  end;

  FreeAndNil(qryGnrPri);

end;

procedure TfrmGNREPrincipal.btnExportarExcelClick(Sender: TObject);
var
  intDocSel: Integer;
begin
  inherited;

  intDocSel := 0;

  if not cdsConsulta.isEmpty then
    intDocSel := fDocumentosSelecionados;

  If intDocSel > 0 Then
  Begin
    If (fMensagem('', 'Foi selecionado ' + IntToStr(intDocSel) + ' documento(s).' + #13 +
                      'Deseja confirmar a exportação ?', ['&Sim', '&Não']) = 1) Then
    Begin
      TfrmGravando.fExecutarModalA(pCarregaDocumentosParaExportacao, 'Carregando documentos para exportação . . .', '');

      if Assigned(prcExecutaRelatorio) then
        prcExecutaRelatorio(351, 16181, [], ['SITUAC'], [IIF(rdgSituacao.ItemIndex = 0, 'Já geradas', 'Não geradas')], Sender, nil, True);

    End;
  End
  Else
    pMensagemOk('Nenhum documento foi selecionado!');

end;

function TfrmGNREPrincipal.fDocumentosSelecionados: Integer;
var
  LRecno: Integer;
Begin
  Result := 0;

  LRecno := cdsConsulta.recno;
  Try
    cdsConsulta.DisableControls;
    cdsConsulta.First;
    While not cdsConsulta.eof Do
    Begin
      If cdsConsulta.FieldByName('SELECIONADO').AsString = 'S' Then
      Begin
        inc(Result);
      End;

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.Recno := LRecno;
    cdsConsulta.EnableControls;
  End;

End;

function TfrmGNREPrincipal.fCodigoDaReceitaDareFcp:String;
begin
  Result := fCfgSis('DARFFC');

  If cdsConsulta.FieldByName('GER_TOTRET').AsFloat > 0 Then
    Result := fCfgSis('DARFST');

  If cdsConsulta.FieldByName('VAL_DIFAL').AsFloat > 0 Then
    Result := fCfgSis('DARFDF');
end;

function TfrmGNREPrincipal.fCodigoDaReceita(AOpcao: Integer; AUF:String):String;
Begin
  If AUF = 'ES' Then
  Begin
    case AOpcao of
      0: Result := fCfgSis('DUA_ST');
      1: Result := fCfgSis('DUAFCP');
      2: Result := fCfgSis('DUADFL');
    end;
  End
  Else If AUF = 'SP' Then
  Begin
    case AOpcao of
      0: Result := fCfgSis('DAREST');
      1: Result := fCodigoDaReceitaDareFcp;
      2: Result := fCfgSis('DAREDF');
    end;
  End
  Else
  Begin
    case AOpcao of
      0: Result := fStrZero( varToStr(fCfgSis('GNREST', varString)), 6);
      1: Result := fStrZero( varToStr(fCfgSis('GNREFC', varString)), 6);
      2: Result := fStrZero( varToStr(fCfgSis('GNREDF', varString)), 6);
    end;
  End;
end;

procedure TfrmGNREPrincipal.pCarregaDocumentosParaImpressao;
var
  LRecno   : Integer;
  LContador: Integer;
begin
  LRecno := cdsConsulta.RecNo;

  Try
    cdsConsulta.DisableControls;
    cdsConsulta.First;
    While not cdsConsulta.eof Do
    Begin
      If cdsConsulta.FieldByName('SELECIONADO').AsString = 'S' Then
      Begin
        For LContador := 0 To 2 Do
        Begin
          GNREModulo.pPreparaBoleto(False, True, fCodigoDaReceita(LContador, cdsConsulta.FieldByName('GER_ESTADO').AsString), cdsConsulta.FieldByName('FIS_ACESSO').AsString, fRetornaTipoReceitaGNRE(LContador));
        End;
      End;

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.RecNo := LRecno;
    cdsConsulta.EnableControls;
  End;
end;

procedure TfrmGNREPrincipal.pImprimirGuias;
var
  LDocSel  : Integer;
Begin

  LDocSel := fDocumentosSelecionados;

  If LDocSel > 0 Then
  Begin
    If (fMensagem('', 'Foi selecionado ' + IntToStr(LDocSel) + ' documento(s).' + #13 +
                      'Deseja confirmar a impressão ?', ['&Sim', '&Não']) = 1) Then
    Begin
      pCriarFormularios(TGNREModulo, GNREModulo);
      Try
        TfrmGravando.fExecutarModalA(pCarregaDocumentosParaImpressao, 'Carregando documentos para impressão . . .', '');

        GNREModulo.pImprimir(Self.Name,fCfgSis('GNRIMP'));

      Finally
        pFreeAndNil(GNREModulo);
      End;
    End;
  End
  Else
    pMensagemOk('Nenhum documento foi selecionado!');

End;

procedure TfrmGNREPrincipal.btnImprimirGuiasClick(Sender: TObject);
begin
  inherited;

  If cdsConsulta.isEmpty Then
    Exit;

  If (InterlockedIncrement(FSemaforoConfirma) = 0) Then
  Begin
    pImprimirGuias;

    InterlockedDecrement(FSemaforoConfirma);
  End
  Else
    InterlockedDecrement(FSemaforoConfirma);

end;

procedure TfrmGNREPrincipal.pMarcarTodos;
var
  LIndex   : Integer;
  LAutInc  : String;
  LContador: Integer;
begin
  Try
    cdsConsulta.DisableControls;
    For LContador := 0 to dbgConsultaDBView.DataController.FilteredRecordCount - 1 do
    begin
      LIndex  := dbgConsultaDBView.DataController.FilteredRecordIndex[LContador];
      LAutInc := dbgConsultaDBView.DataController.Values[LIndex, dbgConsultaDBViewFIS_AUTINC.Index];

      If (not fCfgSis('USADAR', varBoolean)) And (VarToStr(dbgConsultaDBView.DataController.Values[LIndex, dbgConsultaDBViewGER_ESTADO.Index]) = 'SP') Then
        Continue;

      If (not fCfgSis('USADUA', varBoolean)) And (VarToStr(dbgConsultaDBView.DataController.Values[LIndex, dbgConsultaDBViewGER_ESTADO.Index]) = 'ES') Then
        Continue;

      If cdsConsulta.Locate('FIS_AUTINC', LAutInc, []) then
      begin
        If fValidaDocumento(False) Then
        begin
          cdsConsulta.Edit;
          cdsConsulta.FieldByName('SELECIONADO').AsString := 'S';
          cdsConsulta.Post;
        end;
      end;

      If (LContador Mod 20 = 0) Then
        Application.ProcessMessages;
    end;
  Finally
    cdsConsulta.First;
    cdsConsulta.EnableControls;
  End;
end;

procedure TfrmGNREPrincipal.btnMarcarTodosClick(Sender: TObject);
begin
  If not cdsConsulta.isEmpty Then
  Begin
    TfrmGravando.fExecutarModalA(pMarcarTodos, 'Marcando documentos . . .', '');
  End;
end;

function TfrmGNREPrincipal.fExisteDocumentoSelecionado: Boolean;
var
  intContador : Integer;
  intIndex : Integer;
begin
  if dbgConsultaDBView.DataController.FilteredRecordCount <= 0 then
    Exit(False);

  Result := False;
  For intContador := 0 to dbgConsultaDBView.DataController.FilteredRecordCount - 1 do
  begin
    intIndex  := dbgConsultaDBView.DataController.FilteredRecordIndex[intContador];
    Result := VarToStr(dbgConsultaDBView.DataController.Values[intIndex, dbgConsultaDBViewSELECIONADO.Index]) = 'S';

    if Result then
      Break;

    If (intContador Mod 20 = 0) Then
      Application.ProcessMessages;
  end;
end;

function TfrmGNREPrincipal.fExisteDocumentoSelecionadoPorReceita(AReceita : Integer; ASomenteGeradosManualmente : Boolean = False) : Boolean;
var
  intContador : Integer;
  intIndex : Integer;
begin
  if dbgConsultaDBView.DataController.FilteredRecordCount <= 0 then
    Exit(False);

  Result := False;
  For intContador := 0 to dbgConsultaDBView.DataController.FilteredRecordCount - 1 do
  begin
    intIndex  := dbgConsultaDBView.DataController.FilteredRecordIndex[intContador];
    if ASomenteGeradosManualmente then
      Result := fDocumentoSelecionadoComBaixaManual(AReceita, intIndex)
    else
      Result := fSelecionadoMesmaReceita(AReceita, intIndex);

    if Result then
      Break;

    If (intContador Mod 20 = 0) Then
      Application.ProcessMessages;
  end;
end;

function TfrmGNREPrincipal.fExisteFinanceiro(ACodigoDaReceita, AChaveDeAcesso: String; AConsulta: Boolean=False): Boolean;
var
  LQryAux: TUniQuery;
begin
  Result := True;

  If not AConsulta Then
    Exit;

  Try
    LQryAux := fCriaQuery;

    LQryAux.Close;
    LQryAux.SQL.Clear;
    LQryAux.SQL.Add('SELECT AUTOINCREM, CTP_VALPAG FROM CADPAG');
    LQryAux.SQL.Add('WHERE CTP_GNRACE = :ACESSO ');
    LQryAux.SQL.Add('  AND CTP_CODREC = :CODREC ');

    LQryAux.ParamByName('ACESSO').AsString := AChaveDeAcesso;
    LQryAux.ParamByName('CODREC').AsString := ACodigoDaReceita;
    LQryAux.Open;

    Result := not LQryAux.IsEmpty;
  Finally
    FreeAndNil(LQryAux);
  End;

end;

function TfrmGNREPrincipal.fExisteFinanceiroBaixado(AChaveDeAcesso: String): Boolean;
var
  LQryAux: TUniQuery;
begin

  Try
    LQryAux := fCriaQuery;

    LQryAux.Close;
    LQryAux.SQL.Clear;
    LQryAux.SQL.Add('SELECT AUTOINCREM, CTP_VALPAG FROM CADPAG');
    LQryAux.SQL.Add('WHERE CTP_VALPAG > 0 ');
    LQryAux.SQL.Add('  AND CTP_GNRACE = :ACESSO ');

    LQryAux.ParamByName('ACESSO').AsString := AChaveDeAcesso;
    LQryAux.Open;

    Result := not LQryAux.IsEmpty;
  Finally
    FreeAndNil(LQryAux);
  End;

end;

function TfrmGNREPrincipal.fValidaExisteFinanceiro(AExibirMensagem:Boolean):Boolean;
var
  LContador: Integer;
  LContinua: Boolean;
begin
  Result := True;

  If rdgSituacao.ItemIndex = 1 Then
    Exit;

  If not (cdsConsulta.FieldByName('SELECIONADO').AsString = 'N') Then
    Exit;

  LContinua := True;

  For LContador := 0 To 2 Do
  Begin
    Case LContador Of
      0: Begin
           If cdsConsulta.FieldByName('AUX_GNEAUT').AsString = 'S' Then
             LContinua := fExisteFinanceiro(fCodigoDaReceita(LContador, cdsConsulta.FieldByName('GER_ESTADO').AsString), cdsConsulta.FieldByName('FIS_ACESSO').AsString, fReceitaUtilizadaNaUF(cdsConsulta.FieldByName('GER_ESTADO').AsString, LContador));
         End;
      1: Begin
           If cdsConsulta.FieldByName('AUX_GNEFCP').AsString = 'S' Then
             LContinua := fExisteFinanceiro(fCodigoDaReceita(LContador, cdsConsulta.FieldByName('GER_ESTADO').AsString), cdsConsulta.FieldByName('FIS_ACESSO').AsString, fReceitaUtilizadaNaUF(cdsConsulta.FieldByName('GER_ESTADO').AsString, LContador));
         End;
      2: Begin
           If cdsConsulta.FieldByName('AUX_GNEDFL').AsString = 'S' Then
             LContinua := fExisteFinanceiro(fCodigoDaReceita(LContador, cdsConsulta.FieldByName('GER_ESTADO').AsString), cdsConsulta.FieldByName('FIS_ACESSO').AsString, fReceitaUtilizadaNaUF(cdsConsulta.FieldByName('GER_ESTADO').AsString, LContador));
         End
    Else
      LContinua := False;
    End;

    If not LContinua Then
    Begin
      If AExibirMensagem Then
        fMensagem('ATENÇÃO!', 'Não foi possível localizar o contas a pagar: '+#13+
                              'Receita: ['+fCodigoDaReceita(LContador, cdsConsulta.FieldByName('GER_ESTADO').AsString)+'] Documento: ['+cdsConsulta.FieldByName('GER_NUMDOC').AsString+']'+#13+
                              'Cliente: ['+cdsConsulta.FieldByName('GER_CODCLI').AsString+'-'+cdsConsulta.FieldByName('CLI_NOMCLI').AsString+']', ['&Ok']);
      Break;
    End;
  End;

  Result := LContinua;
end;

function TfrmGNREPrincipal.fValidaSelecionado(AExibirMensagem:Boolean):Boolean;
begin
  Result := True;

  If (cdsConsulta.FieldByName('SELECIONADO').AsString = 'S') Then
  Begin
    FObjLock.fLock_Unlock('GNRE' + cdsConsulta.fieldByName('GER_NUMDOC').AsString +
                                   cdsConsulta.fieldByName('GER_ESPDOC').AsString +
                                   cdsConsulta.fieldByName('GER_CODEMP').AsString, False, False);
  End
  Else
  Begin
    If Not FObjLock.fLock_Unlock('GNRE' + cdsConsulta.fieldByName('GER_NUMDOC').AsString +
                                          cdsConsulta.fieldByName('GER_ESPDOC').AsString +
                                          cdsConsulta.fieldByName('GER_CODEMP').AsString, True, False) Then
    Begin
      If AExibirMensagem Then
        fMensagem('', 'Esse Documento está sendo utilizado em outra estação por ' +
                      fGetHostLock('GNRE' + cdsConsulta.fieldByName('GER_NUMDOC').AsString  +
                                            cdsConsulta.fieldByName('GER_ESPDOC').AsString  +
                                            cdsConsulta.fieldByName('GER_CODEMP').AsString) + '!', ['&Ok']);
      Result := False;
    End;
  End;
end;

function TfrmGNREPrincipal.fValidaTodasGuiasGeradas(AExibirMensagem: Boolean): Boolean;
begin
  Result := True;

  if cdsConsulta.FieldByName('AUX_TEMFCP').AsString = 'S' then
  begin
    if cdsConsulta.FieldByName('AUX_GNMFCP').AsString <> 'S' then
    begin
      Result := False;
      Exit;
    end;
  end;

  if cdsConsulta.FieldByName('AUX_TEMDFL').AsString = 'S' then
  begin
    if cdsConsulta.FieldByName('AUX_GNMDFL').AsString <> 'S' then
    begin
      Result := False;
      Exit;
    end;
  end;

  if cdsConsulta.FieldByName('AUX_TEM_ST').AsString = 'S' then
  begin
    if cdsConsulta.FieldByName('AUX_GNM_ST').AsString <> 'S' then
    begin
      Result := False;
      Exit;
    end;
  end;

  If Result then
  begin
    if AExibirMensagem Then
      fMensagem('', 'Não é possível selecionar documentos com guias geradas manualmente.', ['&Ok']);
  end;

end;

function TfrmGNREPrincipal.fValidaNFeRioDeJaneiro(AExibirMensagem:Boolean=True):Boolean;
var
  LIcms: String;
  LFecp: String;
  LErro: String;

begin
  Result := True;

  If not (cdsConsulta.FieldByName('GER_ESTADO').AsString = 'RJ') Then
    Exit;

  If (cdsConsulta.FieldByName('GER_TOTRET').AsFloat + cdsConsulta.FieldByName('VAL_FCP_ST').AsFloat) > 0 Then
  Begin
    If (cdsConsulta.FieldByName('GER_TOTRET').AsFloat = 0) Or (cdsConsulta.FieldByName('VAL_FCP_ST').AsFloat = 0) Then
    Begin
      LIcms := FormatFloat(fMskDigitos(2), cdsConsulta.FieldByName('GER_TOTRET').AsFloat);
      LFecp := FormatFloat(fMskDigitos(2), cdsConsulta.FieldByName('VAL_FCP_ST').AsFloat);
      LErro := 'Impostos obrigatórios, Vlr.ST R$ ' + LIcms + '  e  Vlr.FCP-ST R$ ' + LFecp;
      Result := False;
    End;
  End

  Else

  If (cdsConsulta.FieldByName('VAL_DIFAL').AsFloat + cdsConsulta.FieldByName('VAL_FCP').AsFloat) > 0 Then
  Begin
    If (cdsConsulta.FieldByName('VAL_DIFAL').AsFloat = 0) Or (cdsConsulta.FieldByName('VAL_FCP').AsFloat = 0) Then
    Begin
      LIcms := FormatFloat(fMskDigitos(2), cdsConsulta.FieldByName('VAL_DIFAL').AsFloat);
      LFecp := FormatFloat(fMskDigitos(2), cdsConsulta.FieldByName('VAL_FCP').AsFloat);
      LErro := 'Impostos obrigatórios, Vlr.DIFAL R$ ' + LIcms + '  e  Vlr.FCP R$ ' + LFecp;
      Result := False;
    End;
  End;

  If Result Then
    Exit;

  If AExibirMensagem Then
    fMensagem('', 'Nota fiscal inválida para geração da guia GNRE RJ' + #13 + LErro, ['&Ok']);

end;

function TfrmGNREPrincipal.fValidaDocumento(AExibirMensagem:Boolean=True):Boolean;
begin
  Result := False;

  If fValidaTodasGuiasGeradas(AExibirMensagem) then
    Exit;

  If not fValidaExisteFinanceiro(AExibirMensagem) Then
    Exit;

  If not fValidaSelecionado(AExibirMensagem) Then
    Exit;

  Result := True;
end;

procedure TfrmGNREPrincipal.pSelecionaDocumento;
begin
  cdsConsulta.Edit;

  If cdsConsulta.FieldByName('SELECIONADO').AsString = 'N' Then
    cdsConsulta.FieldByName('SELECIONADO').AsString := 'S'
  Else
    cdsConsulta.FieldByName('SELECIONADO').AsString := 'N';

  cdsConsulta.Post;
end;

procedure TfrmGNREPrincipal.dbgConsultaDBViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If not cdsConsulta.isEmpty Then
  Begin
    If fValidaDocumento Then
      pSelecionaDocumento;
  End;
end;

procedure TfrmGNREPrincipal.dbgConsultaDBViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If not cdsConsulta.ControlsDisabled Then
  Begin
    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgConsultaDBViewSELECIONADO.Index]) = 'S' Then
    Begin
      If ACanvas.Brush.Color = clHighlight Then
        ACanvas.Font.Color := clLime
      Else
      begin
        ACanvas.Brush.Color := clHotLight;
        ACanvas.Font.Color  := clYellow;
      end;
    End
    Else If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgConsultaDBViewAUX_GNRREJ.Index]) = 'S' Then
    Begin
      ACanvas.Brush.Color := clRed;
      ACanvas.Font.Color  := clWhite;
    End;
  End;
end;

procedure TfrmGNREPrincipal.dbgConsultaDBViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_RETURN) Then
  Begin
    If not cdsConsulta.isEmpty Then
    Begin
      If fValidaDocumento Then
        pSelecionaDocumento;
    End;
  End;

  If (Shift=[ssShift]) and (Key = VK_DOWN) Then
  Begin
    If not cdsConsulta.isEmpty Then
    Begin
      If fValidaDocumento Then
        pMarcaDocumento;
    End;
  End;

  If (Shift=[ssShift]) and (Key = VK_UP) Then
  Begin
    If not cdsConsulta.isEmpty Then
    Begin
      pDesmarcaDocumento;

      FObjLock.fLock_Unlock('GNRE' + cdsConsulta.FieldByName('GER_NUMDOC').AsString +
                                     cdsConsulta.FieldByName('GER_ESPDOC').AsString +
                                     cdsConsulta.FieldByName('GER_CODEMP').AsString, False, False);
    End;
  End;

end;

procedure TfrmGNREPrincipal.pMarcaDocumento;
begin
  cdsConsulta.Edit;
  cdsConsulta.FieldByName('SELECIONADO').AsString := 'S';
  cdsConsulta.Post;
end;

procedure TfrmGNREPrincipal.pDesmarcaDocumento;
begin
  cdsConsulta.Edit;
  cdsConsulta.FieldByName('SELECIONADO').AsString := 'N';
  cdsConsulta.Post;
end;

function TfrmGNREPrincipal.fBaixaManual(AReceita: Integer; ASeqGer: String; AMarcar:Boolean; AIndexFocado : Integer = -1): Boolean;
Var
  LQryUpdate: TUniQuery;
  LCampo: String;
  LColInd: Integer;
  LTabela: String;
  LGuiaRioDeJaneiro : Boolean;
  LCampoAtualizaRJ : String;
Begin
  LQryUpdate := fCriaQuery;
  LColInd := 0;
  if AIndexFocado < 0 then
    AIndexFocado := dbgConsultaDBView.DataController.FocusedRecordIndex;

  LTabela := VarToStr(dbgConsultaDBView.DataController.Values[AIndexFocado, dbgConsultaDBViewTABELA.Index]);
  LTabela := IIF(LTabela = 'MOVGER','AUXMOV','AUXNOT');
  LCampoAtualizaRJ := EmptyStr;

  LGuiaRioDeJaneiro := VarToStr(dbgConsultaDBView.DataController.Values[AIndexFocado, dbgConsultaDBViewGER_ESTADO.Index]) = 'RJ';

  if (LGuiaRioDeJaneiro and (AReceita in [0,2])) Then
    LCampoAtualizaRJ := 'AUX_GNMFCP = ' + QuotedStr(IIF(AMarcar,'S','N'));

  case AReceita of
    0: LCampo := 'AUX_GNM_ST = ' + QuotedStr(IIF(AMarcar,'S','N'));
    1: LCampo := 'AUX_GNMFCP = ' + QuotedStr(IIF(AMarcar,'S','N'));
    2: LCampo := 'AUX_GNMDFL = ' + QuotedStr(IIF(AMarcar,'S','N'));
  end;

  Try
    LQryUpdate.Close;
    LQryUpdate.SQL.Clear;
    LQryUpdate.SQL.Add('UPDATE '+LTabela+' SET ' + LCampo);
    if (LGuiaRioDeJaneiro and (AReceita in [0,2])) then
      LQryUpdate.SQL.Add(', ' + LCampoAtualizaRJ);
    LQryUpdate.SQL.Add('WHERE AUX_SEQGER = :SEQGER ');
    LQryUpdate.ParamByName('SEQGER').AsString := ASeqGer;

    LQryUpdate.ExecSQL;
    Result := True;
  Finally
    FreeAndNil(LQryUpdate);
  End;

  If Result Then
  Begin
    case AReceita of
      0: LColInd := dbgConsultaDBViewAUX_GNM_ST.Index;
      1: LColInd := dbgConsultaDBViewAUX_GNMFCP.Index;
      2: LColInd := dbgConsultaDBViewAUX_GNMDFL.Index;
    end;

    dbgConsultaDBView.DataController.SetValue(AIndexFocado, LColInd, IIF(AMarcar,'S','N'));
    if (LGuiaRioDeJaneiro and (AReceita in [0,2])) then
      dbgConsultaDBView.DataController.SetValue(AIndexFocado, dbgConsultaDBViewAUX_GNMFCP.Index, IIF(AMarcar,'S','N'));
  End;

End;

function TfrmGNREPrincipal.fBaixaManualTodosSelecionados(AReceita: Integer; AMarcar: Boolean): Boolean;
var
  strAuxSeqGer : String;
  intContador : Integer;
  intIndex : Integer;
begin
  if dbgConsultaDBView.DataController.FilteredRecordCount <= 0 then
    Exit(False);

  try
    if (not (AMarcar) and (rdgSituacao.ItemIndex = 0)) then
    begin
      fBaixaManual(AReceita, VarToStr(dbgConsultaDBView.DataController.Values[dbgConsultaDBView.DataController.FocusedRecordIndex, dbgConsultaDBViewAUX_SEQGER.Index]), False);
      Exit(True);
    end;

    Result := False;
    For intContador := 0 to dbgConsultaDBView.DataController.FilteredRecordCount - 1 do
    begin
      intIndex  := dbgConsultaDBView.DataController.FilteredRecordIndex[intContador];
      strAuxSeqGer := VarToStr(dbgConsultaDBView.DataController.Values[intIndex, dbgConsultaDBViewAUX_SEQGER.Index]);

      if fSelecionadoMesmaReceita(AReceita, intIndex) then
        Result := fBaixaManual(AReceita, strAuxSeqGer, AMarcar, intIndex);

      If (intContador Mod 20 = 0) Then
        Application.ProcessMessages;
    end;
  finally
    if AMarcar then
      btnConsultar.Click;
  end;
end;

procedure TfrmGNREPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  FreeAndNil(FObjLock);
end;

function TfrmGNREPrincipal.fValidaConfiguracoes : Boolean;
var
  LMensagem: String;
Begin
  Result := True;

  Try
    If fEmptyStr(fCfgSis('GNREST')) Then
    Begin
      fMensagem('ATENÇÃO!', 'A configuração do sistema: CFG_GNREST está inválida.', ['&Ok']);
      Result := False;
    End
    Else If fEmptyStr(fCfgSis('GNREDF')) Then
    Begin
      fMensagem('ATENÇÃO!', 'A configuração do sistema: CFG_GNREDF está inválida.', ['&Ok']);
      Result := False;
    End
    Else If fEmptyStr(fCfgSis('GNREFC')) Then
    Begin
      fMensagem('ATENÇÃO!', 'A configuração do sistema: CFG_GNREFC está inválida.', ['&Ok']);
      Result := False;
    End
    Else If fEmptyStr(fCfgSis('CTAPST')) Then
    Begin
      fMensagem('ATENÇÃO!', 'A configuração do sistema: CFG_CTAPST está inválida.', ['&Ok']);
      Result := False;
    End
    Else If fEmptyStr(fCfgSis('CTAPDF')) Then
    Begin
      fMensagem('ATENÇÃO!', 'A configuração do sistema: CFG_CTAPDF está inválida.', ['&Ok']);
      Result := False;
    End
    Else If fEmptyStr(fCfgSis('CTAPFC')) Then
    Begin
      fMensagem('ATENÇÃO!', 'A configuração do sistema: CFG_CTAPFC está inválida.', ['&Ok']);
      Result := False;
    End;

    If fCfgSis('CTPOBE', varBoolean) Then
    Begin
      If fEmptyStr(fCfgSis('GPGEVE')) Then
      Begin
        fMensagem('ATENÇÃO!', 'A configuração do sistema: CFG_GPGEVE está inválida.', ['&Ok']);
        Result := False;
      End;
    End;

    If fCfgSis('USADAR', varBoolean) Then
    Begin
      LMensagem := '';

      If fEmptyStr(fCfgSis('DARKEY')) Then
        LMensagem := LMensagem + '- CFG_DARKEY' + sLineBreak;

      If fEmptyStr(fCfgSis('DAREST')) Then
        LMensagem := LMensagem + '- CFG_DAREST' + sLineBreak;

      If fEmptyStr(fCfgSis('DAREDF')) Then
        LMensagem := LMensagem + '- CFG_DAREDF' + sLineBreak;

      If fEmptyStr(fCfgSis('DARFDF')) Then
        LMensagem := LMensagem + '- CFG_DARFDF' + sLineBreak;

      If fEmptyStr(fCfgSis('DARFFC')) Then
        LMensagem := LMensagem + '- CFG_DARFFC' + sLineBreak;

      If fEmptyStr(fCfgSis('DARFST')) Then
        LMensagem := LMensagem + '- CFG_DARFST' + sLineBreak;

      If fEmptyStr(fCfgSis('DARSST')) Then
        LMensagem := LMensagem + '- CFG_DARSST' + sLineBreak;

      If fEmptyStr(fCfgSis('DARSDF')) Then
        LMensagem := LMensagem + '- CFG_DARSDF' + sLineBreak;

      If fEmptyStr(fCfgSis('DASFFC')) Then
        LMensagem := LMensagem + '- CFG_DASFFC' + sLineBreak;

      If fEmptyStr(fCfgSis('DASFST')) Then
        LMensagem := LMensagem + '- CFG_DASFST' + sLineBreak;

      If fEmptyStr(fCfgSis('DASFDF')) Then
        LMensagem := LMensagem + '- CFG_DASFDF' + sLineBreak;

      If LMensagem <> '' Then
      Begin
        fMensagem('ATENÇÃO!', 'As seguintes configurações do sistema estão inválidas:' + sLineBreak + LMensagem, ['&Ok']);
        Result := False;
      End;
    End;

    If fCfgSis('USADUA', varBoolean) Then
    Begin
      LMensagem := '';

      If fEmptyStr(fCfgSis('DUA_ST')) Then
        LMensagem := LMensagem + '- CFG_DUA_ST' + sLineBreak;

      If fEmptyStr(fCfgSis('DUADFL')) Then
        LMensagem := LMensagem + '- CFG_DUADFL' + sLineBreak;

      If fEmptyStr(fCfgSis('DUAFCP')) Then
        LMensagem := LMensagem + '- CFG_DUAFCP' + sLineBreak;

      If LMensagem <> '' Then
      Begin
        fMensagem('ATENÇÃO!', 'As seguintes configurações do sistema estão inválidas:' + sLineBreak + LMensagem, ['&Ok']);
        Result := False;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmGNREPrincipal.fValidaConfiguracoes]');
    End;
  End;

End;

function TfrmGNREPrincipal.fAtualizaDocumentosQueTemGNRE: Boolean;
begin
  Result := True;

  If not fCfgSis('GNRUPD', varBoolean) Then
    Exit;

  Try
    TfrmGravando.fExecutarModalA(pAtualizaDocumentosQueTemGNRE, 'Marcando documentos que precisam gerar guias . . .', '');
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmGNREPrincipal.fAtualizaDocumentosQueTemGNRE]');
    End;
  End;
end;

procedure TfrmGNREPrincipal.pAtualizaDocumentosQueTemGNRE;
var LSqlAux: String;
begin

  LSqlAux := '';
  LSqlAux := LSqlAux + 'UPDATE CADPAG, CADFIS SET CTP_GNRACE = FIS_ACESSO ';
  LSqlAux := LSqlAux + 'WHERE FIS_TIP_FC = "C" ';
  LSqlAux := LSqlAux + '  AND FIS_NUMDOC = CTP_NUMDOC ';
  LSqlAux := LSqlAux + '  AND FIS_CODEMP = CTP_CODEMP ';
  LSqlAux := LSqlAux + '  AND FIS_DTADOC >= '+QuotedStr(FormatDateTime('yyyy-mm-dd', VS_Date - 60));
  LSqlAux := LSqlAux + '  AND CTP_DTACAD >= '+QuotedStr(FormatDateTime('yyyy-mm-dd', VS_Date - 60));
  LSqlAux := LSqlAux + '  AND CTP_HIST01 LIKE "%GNRE%" ';
  LSqlAux := LSqlAux + '  AND CTP_GNRACE IS NULL ';

  fExecutaSQL(LSqlAux);

  fExecutaSQL('UPDATE MOVGER, AUXMOV SET AUX_TEM_ST = "S" WHERE AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM AND AUX_GNEAUT = "S" AND MOVGER.GER_DTAENT >= '+QuotedStr(FormatDateTime('yyyy-mm-dd', VS_Date - 60)));

  fExecutaSQL('UPDATE MOVGER, AUXMOV SET AUX_TEMFCP = "S" WHERE AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM AND AUX_GNEFCP = "S" AND MOVGER.GER_DTAENT >= '+QuotedStr(FormatDateTime('yyyy-mm-dd', VS_Date - 60)));

  fExecutaSQL('UPDATE MOVGER, AUXMOV SET AUX_TEMDFL = "S" WHERE AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM AND AUX_GNEDFL = "S" AND MOVGER.GER_DTAENT >= '+QuotedStr(FormatDateTime('yyyy-mm-dd', VS_Date - 60)));

  LSqlAux := '';
  LSqlAux := LSqlAux + 'UPDATE MOVGER, AUXMOV SET AUX_TEM_ST = "S" ';
  LSqlAux := LSqlAux + 'WHERE AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM ';
  LSqlAux := LSqlAux + '  AND IFNULL(AUXMOV.AUX_TEM_ST,"") <> "S" ';
  LSqlAux := LSqlAux + '  AND MOVGER.GER_ESPDOC = "NF" ';
  LSqlAux := LSqlAux + '  AND MOVGER.GER_TIP_FC = "C" ';
  LSqlAux := LSqlAux + '  AND MOVGER.GER_DTAENT >= '+QuotedStr(FormatDateTime('yyyy-mm-dd', VS_Date - 60));
  LSqlAux := LSqlAux + '  AND MOVGER.GER_TOTRET > 0 ';

  fExecutaSQL(LSqlAux);

  LSqlAux := '';
  LSqlAux := LSqlAux + 'UPDATE MOVGER, MOVDET, AUXMOV, MOVICD SET AUX_TEMFCP = "S" ';
  LSqlAux := LSqlAux + 'WHERE MOVGER.AUTOINCREM = MOVDET.DET_SEQGER ';
  LSqlAux := LSqlAux + '  AND AUX_SEQGER = MOVGER.AUTOINCREM ';
  LSqlAux := LSqlAux + '  AND ICD_SEQGER = MOVDET.AUTOINCREM ';
  LSqlAux := LSqlAux + '  AND IFNULL(AUX_TEMFCP, "") <> "S" ';
  LSqlAux := LSqlAux + '  AND DET_DTAENT >= '+QuotedStr(FormatDateTime('yyyy-mm-dd', VS_Date - 60));
  LSqlAux := LSqlAux + '  AND DET_TIP_FC = "C" ';
  LSqlAux := LSqlAux + '  AND DET_ORIDOC = "V" ';
  LSqlAux := LSqlAux + '  AND DET_ESPDOC = "NF" ';
  LSqlAux := LSqlAux + '  AND DET_PROEMB <> "S" ';
  LSqlAux := LSqlAux + '  AND ICD_VALFCP > 0 ';

  fExecutaSQL(LSqlAux);

  LSqlAux := '';
  LSqlAux := LSqlAux + 'UPDATE MOVGER, MOVDET, AUXMOV, MOVICD SET AUX_TEMDFL = "S" ';
  LSqlAux := LSqlAux + 'WHERE MOVGER.AUTOINCREM = MOVDET.DET_SEQGER ';
  LSqlAux := LSqlAux + '  AND AUX_SEQGER = MOVGER.AUTOINCREM ';
  LSqlAux := LSqlAux + '  AND ICD_SEQGER = MOVDET.AUTOINCREM ';
  LSqlAux := LSqlAux + '  AND IFNULL(AUX_TEMDFL, "") <> "S" ';
  LSqlAux := LSqlAux + '  AND DET_DTAENT >= '+QuotedStr(FormatDateTime('yyyy-mm-dd', VS_Date - 60));
  LSqlAux := LSqlAux + '  AND DET_TIP_FC = "C" ';
  LSqlAux := LSqlAux + '  AND DET_ORIDOC = "V" ';
  LSqlAux := LSqlAux + '  AND DET_ESPDOC = "NF" ';
  LSqlAux := LSqlAux + '  AND DET_PROEMB <> "S" ';
  LSqlAux := LSqlAux + '  AND ICD_VALDES > 0 ';

  fExecutaSQL(LSqlAux);

  fExecutaSQL('UPDATE NOTGER, AUXNOT SET AUX_TEM_ST = "S" WHERE AUXNOT.AUX_SEQGER = NOTGER.AUTOINCREM AND AUX_GNEAUT = "S" AND NOTGER.GER_DTAENT >= '+QuotedStr(FormatDateTime('yyyy-mm-dd', VS_Date - 60)));

  fExecutaSQL('UPDATE NOTGER, AUXNOT SET AUX_TEMFCP = "S" WHERE AUXNOT.AUX_SEQGER = NOTGER.AUTOINCREM AND AUX_GNEFCP = "S" AND NOTGER.GER_DTAENT >= '+QuotedStr(FormatDateTime('yyyy-mm-dd', VS_Date - 60)));

  fExecutaSQL('UPDATE NOTGER, AUXNOT SET AUX_TEMDFL = "S" WHERE AUXNOT.AUX_SEQGER = NOTGER.AUTOINCREM AND AUX_GNEDFL = "S" AND NOTGER.GER_DTAENT >= '+QuotedStr(FormatDateTime('yyyy-mm-dd', VS_Date - 60)));

  LSqlAux := '';
  LSqlAux := LSqlAux + 'UPDATE NOTGER, AUXNOT SET AUX_TEM_ST = "S" ';
  LSqlAux := LSqlAux + 'WHERE AUXNOT.AUX_SEQGER = NOTGER.AUTOINCREM ';
  LSqlAux := LSqlAux + '  AND IFNULL(AUXNOT.AUX_TEM_ST,"") <> "S" ';
  LSqlAux := LSqlAux + '  AND NOTGER.GER_ESPDOC = "NF" ';
  LSqlAux := LSqlAux + '  AND NOTGER.GER_TIP_FC = "C" ';
  LSqlAux := LSqlAux + '  AND NOTGER.GER_DTAENT >= '+QuotedStr(FormatDateTime('yyyy-mm-dd', VS_Date - 60));
  LSqlAux := LSqlAux + '  AND NOTGER.GER_TOTRET > 0 ';

  fExecutaSQL(LSqlAux);

  LSqlAux := '';
  LSqlAux := LSqlAux + 'UPDATE NOTGER, NOTDET, AUXNOT, NOTICD SET AUX_TEMFCP = "S" ';
  LSqlAux := LSqlAux + 'WHERE NOTGER.AUTOINCREM = NOTDET.DET_SEQGER ';
  LSqlAux := LSqlAux + '  AND AUX_SEQGER = NOTGER.AUTOINCREM ';
  LSqlAux := LSqlAux + '  AND ICD_SEQGER = NOTDET.AUTOINCREM ';
  LSqlAux := LSqlAux + '  AND IFNULL(AUX_TEMFCP, "") <> "S" ';
  LSqlAux := LSqlAux + '  AND DET_DTAENT >= '+QuotedStr(FormatDateTime('yyyy-mm-dd', VS_Date - 60));
  LSqlAux := LSqlAux + '  AND DET_TIP_FC = "C" ';
  LSqlAux := LSqlAux + '  AND DET_ORIDOC = "V" ';
  LSqlAux := LSqlAux + '  AND DET_ESPDOC = "NF" ';
  LSqlAux := LSqlAux + '  AND DET_PROEMB <> "S" ';
  LSqlAux := LSqlAux + '  AND ICD_VALFCP > 0 ';

  fExecutaSQL(LSqlAux);

  LSqlAux := '';
  LSqlAux := LSqlAux + 'UPDATE NOTGER, NOTDET, AUXNOT, NOTICD SET AUX_TEMDFL = "S" ';
  LSqlAux := LSqlAux + 'WHERE NOTGER.AUTOINCREM = NOTDET.DET_SEQGER ';
  LSqlAux := LSqlAux + '  AND AUX_SEQGER = NOTGER.AUTOINCREM ';
  LSqlAux := LSqlAux + '  AND ICD_SEQGER = NOTDET.AUTOINCREM ';
  LSqlAux := LSqlAux + '  AND IFNULL(AUX_TEMDFL, "") <> "S" ';
  LSqlAux := LSqlAux + '  AND DET_DTAENT >= '+QuotedStr(FormatDateTime('yyyy-mm-dd', VS_Date - 60));
  LSqlAux := LSqlAux + '  AND DET_TIP_FC = "C" ';
  LSqlAux := LSqlAux + '  AND DET_ORIDOC = "V" ';
  LSqlAux := LSqlAux + '  AND DET_ESPDOC = "NF" ';
  LSqlAux := LSqlAux + '  AND DET_PROEMB <> "S" ';
  LSqlAux := LSqlAux + '  AND ICD_VALDES > 0 ';

  fExecutaSQL(LSqlAux);

end;

function TfrmGNREPrincipal.fValidaArquivosCertificadoDigital(APathOpenSSL:String): Boolean;
begin
  Result := True;

  If not DirectoryExists(APathOpenSSL) Then
  begin
    fMensagem('ATENÇÃO!', 'Não foi possível encontrar o diretório '+#13+
                          '['+APathOpenSSL+']', ['&Ok'], 1, False, 1, 0, False, 0, False, False, False, 0, 650);
    Result := False;
    Exit;
  end;

  If not FileExists(APathOpenSSL+'openssl.exe') Then
  begin
    fMensagem('ATENÇÃO!', 'Arquivo "openssl.exe" inexistente na pasta '+#13+
                          '['+APathOpenSSL+']', ['&Ok'], 1, False, 1, 0, False, 0, False, False, False, 0, 650);
    Result := False;
    Exit;
  end;

  If not FileExists(APathOpenSSL+'libeay32.dll') Then
  begin
    fMensagem('ATENÇÃO!', 'Arquivo "libeay32.dll" inexistente na pasta '+#13+
                          '['+APathOpenSSL+']', ['&Ok'], 1, False, 1, 0, False, 0, False, False, False, 0, 650);
    Result := False;
    Exit;
  end;

  If not FileExists(APathOpenSSL+'ssleay32.dll') Then
  begin
    fMensagem('ATENÇÃO!', 'Arquivo "ssleay32.dll" inexistente na pasta '+#13+
                          '['+APathOpenSSL+']', ['&Ok'], 1, False, 1, 0, False, 0, False, False, False, 0, 650);
    Result := False;
    Exit;
  end;

end;

function TfrmGNREPrincipal.fCarregaCertificadoDigital: Boolean;
var
  LQryCertificado: TUniQuery;
  LPathOpenSSL: String;
  LArquivoPFX : String;
  LArquivoPEM : String;
  LArquivoKEY : String;
  LSenha      : String;
  LValidade   : TDate;
begin
  Result := True;

  LPathOpenSSL := ExtractFilePath(Application.ExeName)+'OpenSSL\';
  btnCertificadoDigital.Visible := fUsaCapicomSemCertificadoPFX;
  FSerialCertificado := fCfgSis('CERDIG');

  If btnCertificadoDigital.Visible Then
    Exit;

  If fCfgSis('CAPCOM', varBoolean) Then
    Exit;

  If not fValidaArquivosCertificadoDigital(LPathOpenSSL) Then
  Begin
    Result := False;
    Exit;
  End;

  Try
    LQryCertificado := fCriaQuery;

    LQryCertificado.SQL.Add('SELECT * FROM CADCER ');
    LQryCertificado.SQL.Add('WHERE CER_CODEMP = :CODEMP');
    LQryCertificado.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQryCertificado.Open;

    Result := not LQryCertificado.isEmpty;

    If not Result Then
    Begin
      fMensagem('ATENÇÃO!', 'Necessário cadastrar o Certificado Digital.'+#13+
                            'Acesse: Cadastro de Empresas [Certificado Digital].', ['&Ok']);
    End;

    If Result Then
    Begin
      LArquivoPFX  := LPathOpenSSL+'cer1_'+VS_strCodEmp;
      LArquivoPEM  := LPathOpenSSL+'cer2_'+VS_strCodEmp;
      LArquivoKEY  := LPathOpenSSL+'cer3_'+VS_strCodEmp;

      DeleteFile(LArquivoPFX);
      DeleteFile(LArquivoPEM);
      DeleteFile(LArquivoKEY);

      Sleep(300);

      TBlobField(LQryCertificado.FieldByName('CER_ARQPFX')).SaveToFile(LArquivoPFX);
      TBlobField(LQryCertificado.FieldByName('CER_ARQPEM')).SaveToFile(LArquivoPEM);
      TBlobField(LQryCertificado.FieldByName('CER_ARQKEY')).SaveToFile(LArquivoKEY);
      LSenha    := fDecriptar(LQryCertificado.FieldByName('CER_SENHA_').AsString);
      LValidade := LQryCertificado.FieldByName('CER_DTAVAL').AsDateTime;

      Result := (LValidade > Date);

      If not Result Then
      Begin
        fMensagem('ATENÇÃO!', 'Certificado Digital com validade expirada.'+#13+
                              'Validade: '+DateToStr(LValidade), ['&Ok']);
      End;
    End;

    If Result Then
    Begin
      FCertificadoPFX  := LArquivoPFX;
      FCertificadoPEM  := LArquivoPEM;
      FCertificadoKEY  := LArquivoKEY;
      FCertificadoSenha:= LSenha;
    End;

  Finally
    FreeAndNil(LQryCertificado);
  End;
end;

function TfrmGNREPrincipal.fExisteTabelaDeRegrasDePreenchimento: Boolean;
var
  LQryAux: TUniQuery;
begin
  Try
    LQryAux := fCriaQuery;

    LQryAux.SQL.Add('SELECT * FROM CFGGNR ');
    LQryAux.Open;

    Result := not LQryAux.isEmpty;

    If not Result Then
    Begin
      fMensagem('ATENÇÃO!', 'A Tabela CFGGNR que contém as regras de preenchimento está vazia.'+#13+
                            'É necessário rodar o script do requisito "171303" para continuar.', ['&Ok']);
    End;

  Finally
    FreeAndNil(LQryAux);
  End;
end;

function TfrmGNREPrincipal.fValidaExportacaoAutomaticaDeGuiasPDF: Boolean;
begin
  Result := True;

  If not fCfgSis('GNRPDF', varBoolean) Then
    Exit;

  If DirectoryExists(fCfgSis('GNRPAT', varString)) Then
    Exit;

  Result := False;

  fMensagem('ATENÇÃO!', 'O Path para exportação das guias GNRE em PDF está inválido !'+#13+
                        'Verifique as configurações "CFG_GNRPDF" e "CFG_GNRPAT".', ['&Ok']);
end;

function TfrmGNREPrincipal.fCargaInicial: Boolean;
begin
  Result := False;

  If not fValidaConfiguracoes Then
    Exit;

  If not fExisteTabelaDeRegrasDePreenchimento Then
    Exit;

  If not fCarregaCertificadoDigital Then
    Exit;

  If not fAtualizaDocumentosQueTemGNRE Then
    Exit;

  If not fValidaExportacaoAutomaticaDeGuiasPDF Then
    Exit;

  Result := True;
end;

procedure TfrmGNREPrincipal.FormCreate(Sender: TObject);
var
  intCorZeb: Integer;
  intCorFun: Integer;
  intCorFon: Integer;
begin
  inherited;
  edtNumDoc.TamCampo  := fTamDocCadRec;
  edtNumDoc.MaxLength := fTamDocCadRec;

  intCorZeb := strToIntDef(fCfgSis('CORZEB'), clMoneyGreen);
  intCorFun := strToIntDef(fCfgSis('CORFUN'), clMoneyGreen);
  intCorFon := strToIntDef(fCfgSis('CORFON'), clBlack);

  cxStyleZebrado.Color     := IIF(intCorZeb = -1, clMoneyGreen, intCorZeb);
  cxStyleSelecao.Color     := IIF(intCorFun = -1, clMoneyGreen, intCorFun);
  cxStyleSelecao.TextColor := IIF(intCorFon = -1, clBlack, intCorFon);

  untFuncoesSimples.dicConfiguracoes.Clear;
  FSemaforoConfirma := -1;
  FFecharTela := not fCargaInicial;
  FObjLock    := TLock.Create;
  FUsaFazenda := fCfgSis('CADFAZ', varBoolean);

  pAtuVarGlobaisSimples;
  pIniciaDllFuncoes(frmModulo.GetCurrentConnection, strLoginUsuarioLogado, VS_strCodEmp, DebugHook, TCfgSis.Create(), VS_objTraceViewer,
                    VS_Date, VS_ComputerNetName, VS_UserFromWindows, VS_IPAddressAsString, VS_MacAddress);
end;

procedure TfrmGNREPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
         VK_F2 : If btnExportarExcel.Enabled Then btnExportarExcel.Click;
         VK_F6 : If btnMarcarTodos.Enabled Then btnMarcarTodos.Click;
         VK_F7 : If btnDesmarcaTodos.Enabled Then btnDesmarcaTodos.Click;
         VK_F8 : If btnImprimirGuias.Enabled Then btnImprimirGuias.Click;
         VK_F9 : If btnGuiaApuracao.Visible Then btnGuiaApuracao.Click;
        VK_F10 : If btnConfirma.Enabled Then
                 Begin
                   Key := 0;
                   btnConfirma.Click;
                 End;
     VK_ESCAPE : If btnSair.Enabled Then btnSair.Click;
  End;
end;

procedure TfrmGNREPrincipal.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_RETURN then
  Begin
    If (ActiveControl Is TRadioGroup) Or (ActiveControl Is TGroupBox) Then
      keybd_event(Vk_Tab,0, 0, 0);
  End;
end;

procedure TfrmGNREPrincipal.pHabilitaGuiasPorApuracao;
var
  LQryAux: TUniQuery;
begin

  Try
    LQryAux := fCriaQuery;

    LQryAux.Close;
    LQryAux.SQL.Clear;
    LQryAux.SQL.Add('SELECT COUNT(*) AS QTDE FROM EMPISB ');
    LQryAux.SQL.Add('WHERE LENGTH(EMPISB.EMP_INSSUB) > 0 ');
    LQryAux.SQL.Add('  AND EMPISB.EMP_CODEMP = :CODEMP ');
    LQryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQryAux.Open;

    btnGuiaApuracao.Visible := (LQryAux.FieldByName('QTDE').AsInteger > 0);

  Finally
    FreeAndNil(LQryAux);
  End;
end;

procedure TfrmGNREPrincipal.FormShow(Sender: TObject);
begin
  inherited;

  If not FFecharTela Then
  Begin
    rdbCFOP.ItemIndex := 1;
    btnConfiguracoes.Visible := fVerificaAcessoSistema('CFGGNR');
    pLimpaFiltros;
    pHabilitaImpressao;
    pHabilitaGuiasPorApuracao;
    WindowState := wsMaximized;
    mskDtaIni.Text := DateToStr(VS_Date - 60);
    mskDtaFin.Text := DateToStr(VS_Date);
    pSetFocus(mskDtaIni);
  End;
end;

procedure TfrmGNREPrincipal.mnuBaixaManualChange(Sender: TObject;
  Source: TMenuItem; Rebuild: Boolean);
var
  blnExisteSelecionado : Boolean;
begin
  inherited;
  blnExisteSelecionado := fExisteDocumentoSelecionado;

  GuiaGeradaManualmenteST.Visible := (rdgSituacao.ItemIndex = 1) And blnExisteSelecionado;
  GuiaGeradaManualmenteFCP.Visible := (rdgSituacao.ItemIndex = 1) And blnExisteSelecionado;
  GuiaGeradaManualmenteDIFAL.Visible := (rdgSituacao.ItemIndex = 1) And blnExisteSelecionado;

  if rdgSituacao.ItemIndex = 0 then
  begin
    DesfazerGeraoManualST.Visible := ((VarToStr(dbgConsultaDBView.DataController.Values[dbgConsultaDBView.DataController.FocusedRecordIndex, dbgConsultaDBViewAUX_TEM_ST.Index]) = 'S') Or
                                      (StrToFloatDef( VarToStr(dbgConsultaDBView.DataController.Values[dbgConsultaDBView.DataController.FocusedRecordIndex, dbgConsultaDBViewGER_TOTRET.Index]),0 ) > 0)) And
                                      (VarToStr(dbgConsultaDBView.DataController.Values[dbgConsultaDBView.DataController.FocusedRecordIndex, dbgConsultaDBViewAUX_GNM_ST.Index]) = 'S');

    DesfazerGeraoManualFCP.Visible := ((VarToStr(dbgConsultaDBView.DataController.Values[dbgConsultaDBView.DataController.FocusedRecordIndex, dbgConsultaDBViewAUX_TEMFCP.Index]) = 'S') Or
                                       ((StrToFloatDef( VarToStr(dbgConsultaDBView.DataController.Values[dbgConsultaDBView.DataController.FocusedRecordIndex, dbgConsultaDBViewVAL_FCP.Index]),0 ) +
                                         StrToFloatDef( VarToStr(dbgConsultaDBView.DataController.Values[dbgConsultaDBView.DataController.FocusedRecordIndex, dbgConsultaDBViewVAL_FCP_ST.Index]),0 )) > 0)) And
                                       (VarToStr(dbgConsultaDBView.DataController.Values[dbgConsultaDBView.DataController.FocusedRecordIndex, dbgConsultaDBViewAUX_GNMFCP.Index]) = 'S');

    DesfazerGeraoManualDIFAL.Visible := ((VarToStr(dbgConsultaDBView.DataController.Values[dbgConsultaDBView.DataController.FocusedRecordIndex, dbgConsultaDBViewAUX_TEMDFL.Index]) = 'S') Or
                                         (StrToFloatDef( VarToStr(dbgConsultaDBView.DataController.Values[dbgConsultaDBView.DataController.FocusedRecordIndex, dbgConsultaDBViewVAL_DIFAL.Index]),0 ) > 0)) And
                                         (VarToStr(dbgConsultaDBView.DataController.Values[dbgConsultaDBView.DataController.FocusedRecordIndex, dbgConsultaDBViewAUX_GNMDFL.Index]) = 'S');
  end
  else
  begin
    DesfazerGeraoManualST.Visible := fExisteDocumentoSelecionadoPorReceita(0, True);
    DesfazerGeraoManualFCP.Visible := fExisteDocumentoSelecionadoPorReceita(1, True);
    DesfazerGeraoManualDIFAL.Visible := fExisteDocumentoSelecionadoPorReceita(2, True);
  end;

end;

procedure TfrmGNREPrincipal.GuiaGeradaManualmenteSTClick(Sender: TObject);
begin
  inherited;
  fBaixaManualTodosSelecionados(0, True);
end;

procedure TfrmGNREPrincipal.DesfazerGeraoManualSTClick(Sender: TObject);
begin
  inherited;
  fBaixaManualTodosSelecionados(0, False);
end;

procedure TfrmGNREPrincipal.GuiaGeradaManualmenteFCPClick(Sender: TObject);
begin
  inherited;
  fBaixaManualTodosSelecionados(1, True);
end;

procedure TfrmGNREPrincipal.DesfazerGeraoManualFCPClick(Sender: TObject);
begin
  inherited;
  fBaixaManualTodosSelecionados(1, False);
end;

procedure TfrmGNREPrincipal.GuiaGeradaManualmenteDIFALClick(Sender: TObject);
begin
  inherited;
  fBaixaManualTodosSelecionados(2, True);
end;

procedure TfrmGNREPrincipal.DesfazerGeraoManualDIFALClick(Sender: TObject);
begin
  inherited;
  fBaixaManualTodosSelecionados(2, False);
end;

function TfrmGNREPrincipal.fDocumentoSelecionadoComBaixaManual(AReceita,
  AIndexRecord: Integer): Boolean;
var
  intColIndex : Integer;
  blnSelecionado : Boolean;
begin
  blnSelecionado := VarToStr(dbgConsultaDBView.DataController.Values[AIndexRecord, dbgConsultaDBViewSELECIONADO.Index]) = 'S';
  if not blnSelecionado then
    Exit(False);

  case AReceita of
    0: intColIndex := dbgConsultaDBViewAUX_GNM_ST.Index;
    1: intColIndex := dbgConsultaDBViewAUX_GNMFCP.Index;
    2: intColIndex := dbgConsultaDBViewAUX_GNMDFL.Index;
  else
    Exit(False);
  end;

  if VarToStr(dbgConsultaDBView.DataController.Values[AIndexRecord, intColIndex]) = 'S' then
    Exit(True);

  Result := False;
end;

function TfrmGNREPrincipal.fDocumentoSemBaixaManual(AExibirMensagem:Boolean):Boolean;
begin
  Result := False;

  Try

    If cdsConsulta.FieldByName('AUX_GNM_ST').AsString = 'S' Then
      Exit;

    If cdsConsulta.FieldByName('AUX_GNMFCP').AsString = 'S' Then
      Exit;

    If cdsConsulta.FieldByName('AUX_GNMDFL').AsString = 'S' Then
      Exit;

    Result := True;

  Finally
    If not Result And AExibirMensagem Then
      fMensagem('', 'Não é permitido selecionar documento com baixa manual.', ['&Ok']);
  End;

end;

function TfrmGNREPrincipal.fValidaEstadosSuportados(AExibirMensagem:Boolean):Boolean;
begin

  Result := True;

  Try
    If (not fCfgSis('USADAR', varBoolean)) And (cdsConsulta.FieldByName('GER_ESTADO').AsString = 'SP') Then
      Result := False;

    If (not fCfgSis('USADUA', varBoolean)) And (cdsConsulta.FieldByName('GER_ESTADO').AsString = 'ES') Then
      Result := False;

  Finally
    If not Result And AExibirMensagem Then
      fMensagem('', 'Não é possível gerar guias de recolhimento para o documento selecionado.'+#13+
                    'Utilize o site da secretária da fazenda da UF selecionada "'+cdsConsulta.FieldByName('GER_ESTADO').AsString+'".', ['&Ok']);
  End;

end;

procedure TfrmGNREPrincipal.pAjustaGrid;
begin
  dbgConsultaDBViewAUX_DTAGNR.Visible := (rdgSituacao.ItemIndex = 0);
  dbgConsultaDBViewAUX_HORGNR.Visible := (rdgSituacao.ItemIndex = 0);
end;

procedure TfrmGNREPrincipal.dtsConsultaDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  If cdsConsulta.IsEmpty Then
    Exit;

  If (rdgSituacao.ItemIndex = 1) Then
    Exit;

  btnImprimirGuias.Enabled := fDocumentoSemBaixaManual(False);
end;

procedure TfrmGNREPrincipal.edtCodTranspExit(Sender: TObject);
begin
  inherited;
  If not fValidaCampos(edtCodTransp) Then
    pSetFocus(edtCodTransp);
end;

procedure TfrmGNREPrincipal.edtCodTranspKeyPress(Sender: TObject;
  var Key: Char);
var
  arrTransp: TConsultasArray;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    If fPesqTransportadora(contraSimples, Self, edtCodTransp, edtNomTransp, Nil, Key, arrTransp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGNREPrincipal.edtCodVenExit(Sender: TObject);
begin
  inherited;
  If not fValidaCampos(edtCodVen) Then
    pSetFocus(edtCodVen);
end;

procedure TfrmGNREPrincipal.edtCodVenKeyPress(Sender: TObject; var Key: Char);
var
  arrVen: TConsultasArray;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    If fPesqOperador(Self, edtCodVen, edtNomVen, Nil, Key, arrVen) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGNREPrincipal.FormPaint(Sender: TObject);
begin
  inherited;

  If FFecharTela Then
    Close;
end;

procedure TfrmGNREPrincipal.FormResize(Sender: TObject);
begin
  inherited;

  Self.Left := (Screen.Width  - Self.Width)  div 2;
  Self.Top  := (Screen.Height - Self.Height) div 2;

  GroupST.Width    := Trunc(Self.Width / 3);
  GroupFCP.Width   := Trunc(Self.Width / 3);
  GroupDIFAL.Width := Trunc(Self.Width / 3);

  dbgConsultaDBView.OptionsView.ColumnAutoWidth := (Self.Width > 1536);

end;

procedure TfrmGNREPrincipal.btnGuiaApuracaoClick(Sender: TObject);
begin
  inherited;
  If fEmptyStr(fCfgSis('GNRAUF')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe as UFs para geração de guias GNRE por apuração.'+#13+
                          'Use a configuração [CFG_GNRAUF]!', ['&Ok']);
    Exit;
  End;

  pCriarFormularios(TfrmGNREGuiasPorApuracao, frmGNREGuiasPorApuracao);
  Try
    frmGNREGuiasPorApuracao.FCertificadoPFX    := FCertificadoPFX;
    frmGNREGuiasPorApuracao.FCertificadoPEM    := FCertificadoPEM;
    frmGNREGuiasPorApuracao.FCertificadoKEY    := FCertificadoKEY;
    frmGNREGuiasPorApuracao.FCertificadoSenha  := FCertificadoSenha;
    frmGNREGuiasPorApuracao.FSerialCertificado := FSerialCertificado;

    frmGNREGuiasPorApuracao.ShowModal;
  Finally
    pFreeAndNil(frmGNREGuiasPorApuracao);
  End;
end;

procedure TfrmGNREPrincipal.btnDisponibilidadeClick(Sender: TObject);
var
  LUrl: String;
begin
  inherited;
  LUrl := fCfgSis('GNRDIS');

  If fEmptyStr(LUrl) Then
    Exit;

  pConsultaDisponibilidade(LUrl);
end;

end.
