unit untConfigBancoob240;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Mask, DirectoryEditFocus, Buttons,
  ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, AppEvnts, Uni, BitBtnLockedIncrem,
  untTypesSistema, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, StrUtils,
  cxTextEdit, cxMaskEdit, cxButtonEdit, ComboBoxFocus, dxBarBuiltInMenu,
  cxGroupBox, cxPC, dxScreenTip, cxClasses, dxCustomHint, cxHint, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridCustomView, cxGrid, Datasnap.DBClient,
  UniClientDataSet, System.Generics.Collections, 
  untFrameDirectoryEditFocus, untFrameCheckComboBoxOcorrencia,
  untFramePlanoDeContasMaskEdit;

type
  TfrmConfigBancoob240 = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    pnlAtivo: TPanel;
    btnCancelar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    BtnManual: TBitBtnLocked;
    cxPaginas: TcxPageControl;
    tbsGeral: TcxTabSheet;
    pnlAtivo1: TPanel;
    tbsEncBan: TcxTabSheet;
    pnlAtivo2: TPanel;
    grpTarLiq: TcxGroupBox;
    Label54: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    edtDesPorTar: TEditFocus;
    edtPorTar: TEditFocus;
    edtValorTarifa: TEditFocus;
    edtDesForTar: TEditFocus;
    edtForTar: TEditFocus;
    lblProNum: TLabel;
    lblCodCart: TLabel;
    lblCodAgenc: TLabel;
    lblIdentBanco: TLabel;
    Label18: TLabel;
    Label15: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label6: TLabel;
    Label25: TLabel;
    lblMulta: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    lblResp: TLabel;
    Label1: TLabel;
    lbl1: TLabel;
    Label21: TLabel;
    Label24: TLabel;
    edtProxNumArqRem: TEditFocus;
    edtCodCar: TEditFocus;
    edtCodCop: TEditFocus;
    edtCodCed: TEditFocus;
    edtCtaCor: TEditFocus;
    cmbModali: TComboBoxFocus;
    cmbInstrucao1: TComboBoxFocus;
    cmbInstrucao2: TComboBoxFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    cmbProtesto: TComboBoxFocus;
    edtDiasMora: TEditFocus;
    edtPerMul: TEditFocus;
    fraPathRemessa: TfraDirectoryEditFocus;
    fraPathRetorno: TfraDirectoryEditFocus;
    edtResp: TEditFocus;
    edtCodPor: TEditFocus;
    edtInfAdi: TEditFocus;
    edtConCrr: TEditFocus;
    edtSRemBB: TEditFocus;
    Label22: TLabel;
    Label23: TLabel;
    Label20: TLabel;
    edtUsaCrr: TEditFocus;
    edt7Digit: TEditFocus;
    edtCar_BB: TEditFocus;
    ColorLabel4: TColorLabel;
    ColorLabel2: TColorLabel;
    edtDesPor: TEditFocus;
    Label13: TLabel;
    edtProAce: TEditFocus;
    ColorLabel3: TColorLabel;
    edtDiasProt: TEditFocus;
    lblDiasProt: TLabel;
    lblCartSeq: TLabel;
    edtCartSeq: TEditFocus;
    chkCartSeq: TCheckBox;
    cmbEspDoc: TComboBoxFocus;
    Label16: TLabel;
    Label7: TLabel;
    edtDigCop: TEditFocus;
    Label5: TLabel;
    edtDigCed: TEditFocus;
    Label19: TLabel;
    edtDigCta: TEditFocus;
    lblContCorr: TLabel;
    edtNumCon: TEditFocus;
    ColorLabel1: TColorLabel;
    Label26: TLabel;
    edtNumNos: TEditFocus;
    ColorLabel5: TColorLabel;
    HintControler: TcxHintStyleController;
    BtnOcorrencia: TBitBtnLocked;
    Label27: TLabel;
    ColorLabel6: TColorLabel;
    edtEnviarSacador: TEditFocus;
    grpTarAux: TcxGroupBox;
    btnAddOco: TBitBtnLocked;
    btnRemOco: TBitBtnLocked;
    btnEdtOco: TBitBtnLocked;
    grdTarifas: TcxGrid;
    grdTarifasDBTableView1: TcxGridDBTableView;
    grdTarifasDBTableView1CNF_CODOCO: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_DESOCO: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_DSTPDS: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_GERPAG: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_CUSCAR: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_FORNEC: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_PLNCON: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_PORTAD: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_USADIA: TcxGridDBColumn;
    grdTarifasLevel1: TcxGridLevel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    dsCnfOco: TDataSource;
    cdsCnfOco: TUniClientDataSet;
    cdsCnfOcoCNF_CODOCO: TStringField;
    cdsCnfOcoCNF_DESOCO: TStringField;
    cdsCnfOcoCNF_GERPAG: TBooleanField;
    cdsCnfOcoCNF_FORNEC: TStringField;
    cdsCnfOcoCNF_PORTAD: TStringField;
    cdsCnfOcoCNF_PLNCON: TStringField;
    cdsCnfOcoCNF_CUSCAR: TBooleanField;
    cdsCnfOcoCNF_TIPDES: TIntegerField;
    cdsCnfOcoCNF_DSTPDS: TStringField;
    cdsCnfOcoCNF_USADIA: TBooleanField;
    Label32: TLabel;
    cmbLancarTarifa: TComboBoxFocus;
    fraCheckComboBoxOcorrencia: TfraCheckComboBoxOcorrencia;
    Label28: TLabel;
    fraPlanoDeContasBai: TfraPlanoDeContasMskEdit;
    fraPlanoDeContasEnc: TfraPlanoDeContasMskEdit;
    ColorLabel9: TColorLabel;
    edtUtlDesDup: TEditFocus;
    Label29: TLabel;
    cmbTipoDtaCre: TComboBoxFocus;
    Label14: TLabel;
    edtDiasCred: TEditFocus;
    cmbCodigoMulta: TComboBoxFocus;
    tbsComplemento: TcxTabSheet;
    pnlComplemento: TPanel;
    Label45: TLabel;
    edtCodPorRem: TEditFocus;
    edtDescPorRem: TEditFocus;
    Label30: TLabel;
    edtDiasLimRec: TEditFocus;
    lblDupEmpLog: TLabel;
    clDupEmpLog: TColorLabel;
    edtDupEmpLog: TEditFocus;
    lblDesSuj: TLabel;
    clDesSuj: TColorLabel;
    edtConDesSuj: TEditFocus;
    Label2: TLabel;
    edtDiasBaixa: TEditFocus;
    lblPerImpBol: TLabel;
    edtPerImpBol: TEditFocus;
    clbPerImpBol: TColorLabel;
    lblBolNovCon: TLabel;
    chkBolNovCon: TCheckBox;
    procedure btnGravarClick(Sender: TObject);
    procedure pCarregaDados;
    procedure pLimpaCampos;
    procedure FormShow(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnManualClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure chkCartSeqClick(Sender: TObject);
    procedure cmbProtestoChange(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtValorTarifaExit(Sender: TObject);
    procedure edtPorTarKeyPress(Sender: TObject; var Key: Char);
    procedure edtForTarKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumNosEnter(Sender: TObject);
    procedure edtNumNosExit(Sender: TObject);
    procedure edtNumNosMouseEnter(Sender: TObject);
    procedure edtNumNosMouseLeave(Sender: TObject);
    procedure BtnOcorrenciaClick(Sender: TObject);
    procedure BtnOcorrenciaEnter(Sender: TObject);
    procedure BtnOcorrenciaExit(Sender: TObject);
    procedure BtnOcorrenciaMouseEnter(Sender: TObject);
    procedure BtnOcorrenciaMouseLeave(Sender: TObject);
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure grdTarifasDBTableView1DblClick(Sender: TObject);
    procedure btnAddOcoClick(Sender: TObject);
    procedure btnEdtOcoClick(Sender: TObject);
    procedure btnRemOcoClick(Sender: TObject);
    procedure pCarregaOcorrencias;
    procedure fraPlanoDeContasBaiMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasEncMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure cmbCodigoMultaChange(Sender: TObject);
    procedure edtCodPorRemKeyPress(Sender: TObject; var Key: Char);
    procedure cmbInstrucao1Change(Sender: TObject);
    procedure edtConDesSujEnter(Sender: TObject);
    procedure edtConDesSujExit(Sender: TObject);
  private
    { Private declarations }

    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;
    qryCadFor : TUniQuery;

    procedure pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
    procedure DefineDescricaoTipoMulta;
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);

    procedure pShowHint(edtEdit: TEditFocus; strTitulo: String);
    procedure pHideHint;
    procedure pAlteraHintBotao(btnBotao: TBitBtnLocked; strNovoHint: String);
    procedure pShowHintBotao(btnBotao: TBitBtnLocked; strTitulo: String);
    procedure pAtualizaOcorrencia25;
    function RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
    procedure pAlteraHint(edtEdit: TEditFocus; strNovoHint: String);
  public
    { Public declarations }
    blnNaoEditar: Boolean;
    strConfig   : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigBancoob240: TfrmConfigBancoob240;

implementation

uses untfuncoesSimples, untFuncoes,
     untPesqAux, untCfgGenericas_AutBan,
     untConsultas, untMemo, untCadOcoCartei, untCNFOCO_Class, untCNFOCO_Dao;

{$R *.dfm}

procedure TfrmConfigBancoob240.btnEditarClick(Sender: TObject);
begin
  If ((Not fVerificaDireitoAutBan('PERCARBAN')) and (strLoginUsuarioLogado <> '999')) Then
  begin
    fMensagem('ATENÇÃO','Usuário sem permissão!', ['&Ok ']);
    Exit;
  end
  else
  begin
    pnlAtivo1.Enabled := True;
    pnlComplemento.Enabled := pnlAtivo1.Enabled;

    if tbsEncBan.tabVisible then
      pnlAtivo2.Enabled := True;

    btnGravar.Enabled := True;
    btnConfigurar.Enabled := True;
    btnEditar.Visible := False;
    btnCancelar.Visible := true;

    if edtProxNumArqRem.Enabled then
      pSetFocus(edtProxNumArqRem)
    else
      pSetFocus(edtCodCar);

  end;

end;

procedure TfrmConfigBancoob240.btnEdtOcoClick(Sender: TObject);
Var
  intRecNo_: Integer;
begin
  inherited;
  intRecNo_ := 0;

  If Not cdsCnfOco.isEmpty Then
  Begin
    intRecNo_                           := cdsCnfOco.RecNo;
    frmCadOcoCartei                     := TfrmCadOcoCartei.Create(nil);
    frmCadOcoCartei.strCartei           := 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp;
    frmCadOcoCartei.blnEditar           := True;
    frmCadOcoCartei.edtCodOco.Text      := cdsCnfOcoCNF_CODOCO.AsString;
    frmCadOcoCartei.fraPlanoDeContasOco.MskCodCta.Text := Copy(cdsCnfOcoCNF_PLNCON.AsString,1,7);
    frmCadOcoCartei.cmbTipDes.ItemIndex := cdsCnfOcoCNF_TIPDES.AsInteger;

    If cdsCnfOcoCNF_CODOCO.AsString = '02' Then
      frmCadOcoCartei.cmbTipDes.Visible := True;

    If cdsCnfOcoCNF_CODOCO.AsString = '02' Then
      frmCadOcoCartei.lblTipDes.Visible := True;

    Try
      frmCadOcoCartei.ShowModal;
    Finally
      FreeAndNil(frmCadOcoCartei);
    End;
  End
  Else
    pMensagemOk('É necessário possuir um registro selecionado para editar!');

  pCarregaOcorrencias;

  If intRecNo_ > 0 Then
  Begin
    cdsCnfOco.DisableControls;
    cdsCnfOco.RecNo := intRecNo_;
    cdsCnfOco.EnableControls;
  End;
end;

procedure TfrmConfigBancoob240.btnGravarClick(Sender: TObject);
Var
  stlCfgAnt : TStringList;
begin
  inherited;

  stlCfgAnt := Nil;

  If fVerificaCampos Then
  Begin
    Try
      If blnNaoEditar Then
      Begin
        Close;
        ModalResult := mrOk;
        Exit;
      End;

      If (chkCartSeq.Checked) Then
      Begin
        If edtProxNumArqRem.Text <> fRetProxNumAutBan('CONFIG756_240-' + edtCartSeq.Text) Then
        Begin
          If fMensagem('ATENÇÃO','Ao utilizar a sequência do arquivo de remessa de outra carteira, o campo Último Núm. de Seq. Arq. Remessa será sobrescrito pelo da carteira principal. Deseja continuar?',['&SIM', '&NÃO'], 1) = 2 Then
            Exit;
        End;
      End;

      stlCfgAnt := TStringList.Create;
      pCarregaCfg(stlCfgAnt);

      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', IIF(chkCartSeq.Checked, fRetProxNumAutBan('CONFIG756_240p-' + edtCartSeq.Text), edtProxNumArqRem.Text));
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', edtCodCar.Text       );

      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCOPE', edtCodCop.Text       );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCOPE', edtDigCop.Text       );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCEDE', edtCodCed.Text       );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCEDE', edtDigCed.Text       );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCCOR', edtCtaCor.Text       );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCCOR', edtDigCta.Text       );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCONV', edtNumCon.Text       );

      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', LeftStr(cmbInstrucao1.Text,2));
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', LeftStr(cmbInstrucao2.Text,2));
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text  );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text  );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text  );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text  );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text  );

      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text     );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text     );

      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessa.edtDirectory.text  );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetorno.edtDirectory.text  );

      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text       );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DUPEMPLOG', edtDupEmpLog.Text       );

      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text         );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text       );

      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text       );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContasBai.MskCodCta.Text);

      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'MODALID', LeftStr(cmbModali.Text,2));

      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtPerMul.Text       );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text       );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'USACRR_', edtUsaCrr.Text       );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAMORA', edtDiasMora.Text     );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIALIMR', edtDiasLimRec.Text   );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', IIF(chkCartSeq.Checked, 'S', 'N'));
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'UTLDESDUP', edtUtlDesDup.Text   );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', IIF(chkCartSeq.Checked, edtCartSeq.Text, ''));
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODPROT', Copy(cmbProtesto.Text,1, 1));
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPODTACRE', IntToStr(cmbTipoDtaCre.ItemIndex));
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CODIGOMULTA', IntToStr(cmbCodigoMulta.ItemIndex + 1));
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'ESPDOC_', cmbEspDoc.Text);
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', edtPorTar.Text    );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', fraPlanoDeContasEnc.MskCodCta.Text    );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', edtForTar.Text    );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', edtValorTarifa.Text  );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'LANTX02', IIF(cmbLancarTarifa.ItemIndex = 1, '02', '06'));

      If edtUsaCrr.Text = 'S' Then
      Begin
        fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CONVCRR', edtConCrr.Text     );
        fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CRRBB7D', edt7Digit.Text     );
        fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CRRCART', edtCar_BB.Text     );
        fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQRMBB', edtSRemBB.Text     );
      End;

      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMNOSS', edtNumNos.Text       );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVSACA', edtEnviarSacador.Text);
     // fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIXAOCO25', edtBaixarOcorrencia25.Text); //NÃO É MAIS UTILIZADA (Req.151476) - RP
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OCOIGNORA', fraCheckComboBoxOcorrencia.fGetOcorrencias);
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CONSIDESSUJ', edtConDesSuj.Text  );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIASBAI', edtDiasbaixa.Text     );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', edtPerImpBol.Text       );
      fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'BOLNOVCON', IIF(chkBolNovCon.Checked, 'S', 'N'));

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        pBackupCnfBco;
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        pCarregaDados;
        blnMudarFoco := True;
        cxPaginas.ActivePage :=  tbsGeral;
        pnlAtivo1.Enabled := False;
        pnlComplemento.Enabled := pnlAtivo1.Enabled;

        if tbsEncBan.tabVisible then
           pnlAtivo2.Enabled := False;

        btnGravar.Enabled := False;
        btnConfigurar.Enabled := False;
        btnEditar.Visible := True;
        btnCancelar.Visible := False;
        pSetFocus(btnEditar);
      End
      Else
      Begin
        Close;
        ModalResult := mrOk;
      End;

      pGravaLogCarteira(stlCfgAnt);
    Except
      On E:Exception Do
      Begin
        fMensagem('Erro','Ocorreu um erro ao tentar salvar os dados.' + #13 + E.Message,['&O K']);
      End;
    End;

    FreeAndNil(stlCfgAnt);
  End;

end;

procedure TfrmConfigBancoob240.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************JB*}
  pLimpaCampos;
  edtDesPor.Text        := '';
  edtDescPorRem.Text := '';
  fraPlanoDeContasBai.edtDesCta.Text := '';

  edtProxNumArqRem.Text := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'PROXNUM','');
  edtCodCar.Text        := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'CODCART','');

  edtCodCop.Text        := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'CODCOPE','');
  edtDigCop.Text        := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'DIGCOPE','');
  edtCodCed.Text        := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'CODCEDE','');
  edtDigCed.Text        := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'DIGCEDE','');
  edtCtaCor.Text        := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'CODCCOR','');
  edtDigCta.Text        := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'DIGCCOR','');
  edtNumCon.Text        := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'NUMCONV','');
  edtEnviarSacador.Text := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'ENVSACA','S');
  cmbEspDoc.ItemIndex   := cmbEspDoc.Items.IndexOf(fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'ESPDOC_', '02 - DM  Duplicata Mercantil'));

  try
    Case StrToInt(fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU1','')) Of
      0: cmbInstrucao1.ItemIndex := 0;
      1: cmbInstrucao1.ItemIndex := 1;
      2: cmbInstrucao1.ItemIndex := 2;
      4: cmbInstrucao1.ItemIndex := 3;
      5: cmbInstrucao1.ItemIndex := 4;
      9: cmbInstrucao1.ItemIndex := 5;
      10: cmbInstrucao1.ItemIndex := 6;
      11: cmbInstrucao1.ItemIndex := 7;
      19: cmbInstrucao1.ItemIndex := 8;
      20: cmbInstrucao1.ItemIndex := 9;
      23: cmbInstrucao1.ItemIndex := 10;
      31: cmbInstrucao1.ItemIndex := 11;
    End;

  except
     cmbInstrucao1.ItemIndex := -1;
  end;

  Try
    Case StrToInt(fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'CODPROT', '')) Of
      1: cmbProtesto.ItemIndex := 0;
      3: cmbProtesto.ItemIndex := 1;
      8: cmbProtesto.ItemIndex := 2;
      9: cmbProtesto.ItemIndex := 3;
    End;
  except
    cmbProtesto.ItemIndex := -1;
  end;

  Try
    Case StrToInt(fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'TIPODTACRE', '')) Of
      0: cmbTipoDtaCre.ItemIndex := 0;
      1: cmbTipoDtaCre.ItemIndex := 1;
    End;
  except
    cmbTipoDtaCre.ItemIndex := 0;
  end;

  Try
    Case StrToInt(fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'CODIGOMULTA', '')) Of
      1: cmbCodigoMulta.ItemIndex := 0;
      2: cmbCodigoMulta.ItemIndex := 1;
    End;
  except
    cmbCodigoMulta.ItemIndex := -1;
  end;


  if Copy(cmbProtesto.Text, 1, 1) = '3' then
    edtDiasProt.Enabled := False
  else
    edtDiasProt.Enabled := True;

  try
    Case StrToInt(fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU2','')) Of
      0: cmbInstrucao2.ItemIndex  := 0;
      1: cmbInstrucao2.ItemIndex  := 1;
      2: cmbInstrucao2.ItemIndex  := 2;
      4: cmbInstrucao2.ItemIndex  := 3;
      5: cmbInstrucao2.ItemIndex  := 4;
      9: cmbInstrucao2.ItemIndex  := 5;
      10: cmbInstrucao2.ItemIndex := 6;
      11: cmbInstrucao2.ItemIndex := 7;
      19: cmbInstrucao2.ItemIndex := 8;
      20: cmbInstrucao2.ItemIndex := 9;
      23: cmbInstrucao2.ItemIndex := 10;
      31: cmbInstrucao2.ItemIndex := 11;
    End;
  except
    cmbInstrucao2.ItemIndex := -1;
  end;

  If fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'USACRR_','') = 'S' Then
  Begin
    edtConCrr.Enabled := True;
    edt7Digit.Enabled := True;
    edtCar_BB.Enabled := True;
    edtSRemBB.Enabled := True;
  End
  Else
  Begin
    edtConCrr.Enabled := False;
    edt7Digit.Enabled := False;
    edtCar_BB.Enabled := False;
    edtSRemBB.Enabled := False;
  End;


  edtObservacao1.Text   := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV1','');
  edtObservacao2.Text   := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV2','');
  edtObservacao3.Text   := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV3','');
  edtObservacao4.Text   := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV4','');
  edtObservacao5.Text   := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'OBSERV5','');

  edtDiasProt.Text      := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'DIAPROT','');
  edtDiasCred.Text      := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'DIACRED','');

  fraPathRemessa.edtDirectory.text   := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'PATHREM','');
  fraPathRetorno.edtDirectory.text   := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'PATHRET','');

  edtProAce.Text        := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'PROACEI','');
  edtDupEmpLog.Text     :=  fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'DUPEMPLOG','');

  edtResp.Text          := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'RESPONS','');
  edtProAce.Text        := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'PROACEI','');

  edtCodPor.Text        := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'PORBAI_','');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');
  fraPlanoDeContasBai.MskCodCta.Text := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'CTABAI_','');
  edtDiasBaixa.Text     := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'DIASBAI','');

  edtPerImpBol.Text     := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', '');
  If fEmptyStr(edtPerImpBol.Text) Then
    edtPerImpBol.Text := 'S';

  If fEmptyStr(edtDupEmpLog.Text) Then
    edtDupEmpLog.Text := 'N';

  Case StrToIntDef(fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'LANTX02', '06'),0) Of
    06 : cmbLancarTarifa.ItemIndex := 0;
    02 : cmbLancarTarifa.ItemIndex := 1;
  End;

  try
    Case StrToInt(fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'MODALID','')) Of
      1: cmbModali.ItemIndex := 0;
      2: cmbModali.ItemIndex := 1;
      3: cmbModali.ItemIndex := 2;
    End;
  except
    cmbModali.ItemIndex := -1;
  end;

  {************************************************************}
  {* O REQUISITO 151476 SUBSTITUIU A CONFIG 'BAIXAOCO25'.     *}
  {* O PROCEDIMENTO ABAIXO ALIMENTA A NOVA CONFIG (OCOIGNORA) *}
  {* AUTOMATICAMENTE CASO A CONFIG ANTERIOR ESTEJA PREENCHIDA *}
  {* COM 'N'. EM SEGUIDA APAGA A CONFIG OBSOLETA.             *}
  {*********************************************************RP*}
  pAtualizaOcorrencia25;

  edtPerMul.Text        := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'PERMULT','');
  edtInfAdi.Text        := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'INFADIC','');
  edtUsaCrr.Text        := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'USACRR_','');
  edtDiasMora.Text      := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAMORA', '');
  edtDiasLimRec.Text    := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'DIALIMR', '');
  chkCartSeq.Checked    := (fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', '') = 'S');
  chkBolNovCon.Checked  := (fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'BOLNOVCON', '') = 'S');
  edtCartSeq.Text       := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', '');
  edtPorTar.Text        := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', '');
  fraPlanoDeContasEnc.MskCodCta.Text := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', '');
  edtForTar.Text        := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', '');
  edtValorTarifa.Text   := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', '');
 // edtBaixarOcorrencia25.Text := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIXAOCO25', ''); //NÃO É MAIS UTILIZADA (Req.151476) - RP
  fraCheckComboBoxOcorrencia.pSetOcorrencias(fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'OCOIGNORA', ''));

  edtDiasLimRec.enabled := IIf(cmbInstrucao1.ItemIndex = 8, True, False);

  chkCartSeq.OnClick(chkCartSeq);

  If fEmptyStr(edtDiasMora.Text) then
    edtDiasMora.Text := '1';

  If fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'USACRR_','') = 'S' Then
  Begin
    edtConCrr.Text      := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'CONVCRR','');
    edt7Digit.Text      := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'CRRBB7D','');
    edtCar_BB.Text      := fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'CRRCART','');
    edtSRemBB.Text      := fStrZero(fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'SEQRMBB',''), 02);
  End;

  edtNumNos.Text        := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMNOSS', '');

  edtUtlDesDup.Text := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'UTLDESDUP', '');
  If fEmptyStr(edtUtlDesDup.Text) Then
    edtUtlDesDup.Text := 'N';

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);

  If Not fEmptyStr( fraPlanoDeContasBai.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContasBai.MskCodCta.Text, fraPlanoDeContasBai.edtDesCta);

  If Not fEmptyStr( edtPorTar.Text ) Then pCarregaPortador(edtPorTar.Text, edtDesPorTar);
  If Not fEmptyStr( fraPlanoDeContasEnc.MskCodCta.Text ) Then pCarregaCentroCusto(fraPlanoDeContasEnc.MskCodCta.Text, fraPlanoDeContasEnc.edtDesCta);

  If Not fEmptyStr( edtForTar.Text ) Then
  begin
    pPesquisaCadFor(qryCadFor, qryCadFor, edtForTar.Text);
    edtDesForTar.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
  end;

  edtproxNumArqRem.Enabled := fEmptyStr(edtProxNumArqRem.Text);
  pCarregaOcorrencias;

  edtConDesSuj.Text := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1), 'CONSIDESSUJ', '');

  If fEmptyStr(edtConDesSuj.Text) Then
    edtConDesSuj.Text := 'N';

  if (strLoginUsuarioLogado='997') or(strLoginUsuarioLogado='998') or (strLoginUsuarioLogado='999') Then
  begin
    edtProxNumArqRem.Enabled := True;
    pSetFocus(edtProxNumArqRem);
  End;

end;

procedure TfrmConfigBancoob240.pLimpaCampos;
var
  i: Integer;
begin
  for i := Self.ComponentCount -1 downto 0 do
  begin
    if (Self.Components[i] is TEditFocus) then
      (Self.Components[i] as TEditFocus).text := '';

    if (Self.Components[i] is TfraDirectoryEditFocus) then
      (Self.Components[i] as TfraDirectoryEditFocus).edtDirectory.text := '';

    if (Self.Components[i] is TCheckBox) then
      (Self.Components[i] as TCheckBox).Checked := False;

    if (Self.Components[i] is TComboBoxFocus) then
      (Self.Components[i] as TComboBoxFocus).ItemIndex := -1;
  end;
end;

procedure TfrmConfigBancoob240.pShowHint(edtEdit: TEditFocus;
  strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;

procedure TfrmConfigBancoob240.FormShow(Sender: TObject);
begin
  inherited;
  fraCheckComboBoxOcorrencia.strCodBco    := '756';
  fraCheckComboBoxOcorrencia.strCnab      := '240';
  fraCheckComboBoxOcorrencia.strCodIgnora := ['06'];
  fraCheckComboBoxOcorrencia.pCarregaOcorrencias;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  pCarregaDados;
  If fEmptyStr(edtProxNumArqRem.Text) Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(edtCodCar);

  pSetFocus(btnEditar);

  pnlAtivo1.Enabled := False;
  pnlComplemento.Enabled := pnlAtivo1.Enabled;
  pnlAtivo2.Enabled := False;

  if blnNaoEditar then
  begin
     btnConfigurar.Enabled := False;
     btnConfigurar.Visible := False;
     btnGravar.Enabled     := True;
     btnEditar.Visible     := False;
     pSetFocus(btnGravar);
  end;
  DefineDescricaoTipoMulta;
end;

procedure TfrmConfigBancoob240.fraPlanoDeContasBaiMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContasBai.MskCodCta, fraPlanoDeContasBai.edtDesCta, Nil, Key, arrCentroCusto) Then
    if fValidaCampos(fraPlanoDeContasBai.MskCodCta) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfigBancoob240.fraPlanoDeContasEncMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
  Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************KP*}
  If fPesqCentroCusto(Self, fraPlanoDeContasEnc.MskCodCta, fraPlanoDeContasEnc.edtDesCta, Nil, Key, arrCentroCusto) Then
  begin
    if fValidaCampos(fraPlanoDeContasEnc.MskCodCta)  then
      SelectNext(ActiveControl, True, True);
  end;
end;

function TfrmConfigBancoob240.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
var
  strMensagemConfig: String;
Begin

  Result := True;

   if blnNaoEditar then
     strMensagemConfig := #13 + 'Por favor acesse a tela de configuração do banco selecionado ' + #13  + ' e corrija as informações necessárias!'
  else
     strMensagemConfig := '';

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = edtProxNumArqRem Then
    Begin

      If fEmptyStr(edtProxNumArqRem.Text) Then
      Begin
        fMensagem('', 'O Último Núm. Arq. Remessa deve conter um valor!'+strMensagemConfig,['&O K']);
        Result := False;
      End

      Else If StrToInt(edtProxNumArqRem.Text) < 0 Then
      Begin
       fMensagem('', 'O Último Núm. Arq. Remessa deve ser maior ou igual a zero!'+strMensagemConfig,['&O K']);
       Result := False;
      End;

    End

    Else If (Sender = cmbInstrucao1) Then
    Begin

      If cmbInstrucao1.ItemIndex = -1 Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+strMensagemConfig,['&OK']);
        Result := False;
      End

    End

    Else If (Sender = cmbInstrucao2) Then
    Begin

      If cmbInstrucao2.ItemIndex = -1 Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+strMensagemConfig,['&OK']);
        Result := False;
      End

    End

    Else If Sender = edtResp Then
    Begin

      If (edtResp.Text <> 'B') And (edtResp.Text <> 'E') Then
      Begin
        fMensagem('','O campo Resp. por emissão de boletos deve ser B ou E!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If Sender = edtProAce Then
    Begin
      If Pos(edtProAce.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Imprime Protocolo de Aceite deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtDupEmpLog Then
    Begin
      If Pos(edtDupEmpLog.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Na importação do retorno considerar apenas duplicatas da empresa logada? deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtEnviarSacador Then
    Begin
      If Pos(edtEnviarSacador.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Enviar Sacador/Avalista na Rem. deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      End;
    End

    Else If Sender = fraPathRemessa Then
    Begin

      If fEmptyStr(fraPathRemessa.edtDirectory.text) Then
      Begin
        fMensagem('','Preencha o campo Path de remessa!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtDiasProt Then
    Begin

      If ((Pos(Copy(cmbProtesto.Text, 1, 1), '1_') > 0) and ((edtDiasProt.Text = '') or (StrToInt(edtDiasProt.Text) = 0))) Then
      Begin
        fMensagem('','Para o código de protesto informado é obrigatório informar ' + #13 + ' os dias para protesto! '+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If ((Sender = edtDiasLimRec) And (edtDiasLimRec.enabled)) Then
    Begin

      If ((edtDiasLimRec.Text = '') or (StrToInt(edtDiasLimRec.Text) = 0)) Then
      Begin
        fMensagem('','Para a instrução 1 escolhida é necessário informar a quantidade de dias limite para recebimento! '+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If Sender = edtDiasBaixa Then
    Begin

      If ( ((Pos(Copy(cmbInstrucao1.Text, 1, 2), '02_') > 0) or (Pos(Copy(cmbInstrucao2.Text, 1, 2), '02_') > 0)) and ((edtDiasBaixa.Text = '') or (StrToInt(edtDiasBaixa.Text) = 0))) Then
      Begin
        fMensagem('','Para a instrução selecionada é obrigatório informar ' + #13 + ' a quantidade de dias para a baixa!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If Sender = fraPathRetorno Then
    Begin

      If fEmptyStr(fraPathRetorno.edtDirectory.text) Then
      Begin
        fMensagem('','Preencha o campo Path de retorno!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtUtlDesDup Then
    Begin
      If Pos(edtUtlDesDup.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Utl. Desconto de Duplicatas? deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtConDesSuj Then
    Begin
      If Pos(edtConDesSuj.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Considerar Desconto Sugerido na baixa? deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtPerImpBol Then
    Begin
      If Pos(edtPerImpBol.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Permitir impressão de boletos deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodPorRem) Then
    Begin
        If (edtCodPorRem.Text <> EmptyStr) Then
        Begin
          pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);
          If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!'+strMensagemConfig, ['&Ok']);
            Result := False;
          End
          {*REQ*145940**********RP*}
          Else If Not fEmpresaTemAcessoPortador(edtCodPorRem.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End
          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtCodPorRem.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig, ['&Ok']);
              Result := False;
            End;
          End
          Else If (Not fPortadorPermiteBaixa(edtCodPorRem.Text)) Then
          Begin
            fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
            Result := False;
          End;
        End
        Else
          edtDescPorRem.Clear;
    End


    Else If (Sender = edtCodPor) Then
    Begin

      If fEmptyStr(edtCodPor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O portador deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        edtDesPor.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaPortador(edtCodPor.Text, edtDesPor);
        If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este operador!'+strMensagemConfig, ['&Ok']);
            Result := False;
          End;
        End
        Else If (Not fPortadorPermiteBaixa(edtCodPor.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (tbsEncBan.TabVisible = True) and (Sender = edtPorTar) Then
    Begin
      If fEmptyStr(TEditFocus(Sender).Text) Then
      begin
        if (not fEmptyStr(edtValorTarifa.Text)) and (fStrToFloat(edtValorTarifa.Text)>0) then
        Begin
          fMensagem('', 'O portador para baixa da tarifa deve ser preenchido!'+strMensagemConfig, ['&Ok']);

          If (Sender = edtPorTar) Then edtDesPorTar.Clear;

          cxPaginas.ActivePage := tbsEncBan;
          Result := False;
        End;
      end
      else
      begin
        pCarregaPortador(edtPorTar.Text, edtDesPorTar);

        If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('', 'Esse portador não está cadastrado!'+strMensagemConfig, ['&Ok']);
          cxPaginas.ActivePage := tbsEncBan;
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtPorTar.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin

          If (Pos(edtPorTar.Text, strPortadoresOperador) <= 0) Then
          Begin
            If Not fEmptyStr(edtDesPorTar.Text) Then
            Begin
              fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig, ['&Ok']);
              Result := False;
            End
          End;

        End;
      end;
    End

    Else If (tbsEncBan.TabVisible = True) and  (Sender = fraPlanoDeContasEnc.MskCodCta)  Then
    Begin
      If fEmptyStr(fraPlanoDeContasEnc.MskCodCta.Text) Then
      begin
        if (not fEmptyStr(edtValorTarifa.Text)) and (fStrToFloat(edtValorTarifa.Text)>0) then
        Begin
          fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!'+strMensagemConfig, ['&Ok']);
          fraPlanoDeContasEnc.edtDesCta.Clear;
          Result := False;
        End
      end
      Else
      Begin
        pCarregaCentroCusto(fraPlanoDeContasEnc.MskCodCta.Text, fraPlanoDeContasEnc.edtDesCta);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End
        else
        begin
          Result := PlanoDeContasAtivo(fraPlanoDeContasEnc.MskCodCta.Text,True);
          fraPlanoDeContasEnc.edtDesCta.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
        End;

      end;

    End

    Else If (tbsEncBan.TabVisible = True) and  (Sender = edtForTar)  Then
    Begin
      If fEmptyStr(edtForTar.Text) Then
      begin
        if (not fEmptyStr(edtValorTarifa.Text)) and (fStrToFloat(edtValorTarifa.Text)>0) then
        Begin
          fMensagem('ATENÇÃO','O Código do fornecedor para baixa da tarifa bancária deve ser preenchido!'+strMensagemConfig,['&OK']);
          Result := False;
        End;
      end
      else
      begin
        pPesquisaCadFor(qryCadFor, qryCadFor, edtForTar.Text);

        If qryCadFor.FieldByName('FOR_CODFOR').IsNull Then
        Begin
          fMensagem('', 'Esse fornecedor não está cadastrado!'+strMensagemConfig, ['&Ok']);
          cxPaginas.ActivePage := tbsEncBan;
          Result := False;
        End
        else
          edtDesForTar.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
      end;
    End

    Else If (Sender = fraPlanoDeContasBai.MskCodCta) Then
    Begin

      If fEmptyStr(fraPlanoDeContasBai.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!'+strMensagemConfig, ['&Ok']);
        fraPlanoDeContasBai.edtDesCta.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaCentroCusto(fraPlanoDeContasBai.MskCodCta.Text, fraPlanoDeContasBai.edtDesCta);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End
        Else
          Result := PlanoDeContasAtivo(fraPlanoDeContasBai.MskCodCta.Text,True);
      End;

    End

    Else If Sender = edtDiasProt Then
    Begin

      If ((Pos(Copy(cmbProtesto.Text, 1, 1), '1_') > 0) and ((edtDiasProt.Text = '') or (StrToInt(edtDiasProt.Text) = 0))) Then
      Begin
        fMensagem('','Para o código de protesto informado é obrigatório informar ' + #13 + ' os dias para protesto! ', ['&O K']);
        Result := False;
      End;

    End

    Else If Sender = cmbProtesto Then
    Begin

      If fEmptyStr(cmbProtesto.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O Campo Código p/ protesto deve ser Preenchido!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtUsaCrr) Then
    Begin
      If Not fEmptyStr(edtUsaCrr.Text) Then
      Begin
        If edtUsaCrr.Text = 'S' Then
        Begin
          edtConCrr.Enabled := True;
          edt7Digit.Enabled := True;
          edtCar_BB.Enabled := True;
          edtSRemBB.Enabled := True;
        End
        Else If edtUsaCrr.Text = 'N' Then
        Begin
          edtConCrr.Enabled := False;
          edt7Digit.Enabled := False;
          edtCar_BB.Enabled := False;
          edtSRemBB.Enabled := False;
        End
        Else
        Begin
          fMensagem('ATENÇÃO!', 'O campo Usa correspondente (Banco do Brasil) deve ser S ou N!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        edtUsaCrr.Text    := 'N';
        edtConCrr.Enabled := False;
      End;
    End

    Else If (Sender = edt7Digit) And
            (edt7Digit.Enabled)  Then
    Begin
      If fEmptyStr(edt7Digit.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo 7 Dígitos (BB) deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End
      Else If Pos(edt7Digit.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo 7 Díditos (BB) deve ser S ou N!'+strMensagemConfig,['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCar_BB) And
            (edtCar_BB.Enabled)  Then
    Begin
      If fEmptyStr(edtCar_BB.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Carteira (Correspondente BB) deve ser preenchido!'+strMensagemConfig,['&Ok']);
        Result := False;
      End
      Else If (StrToIntDef(edtCar_BB.Text, 0) <= 0) Or
              (StrToIntDef(edtCar_BB.Text, 0) >  5) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Carteira (Correspondente BB) deve ser entre 1 e 5!'+strMensagemConfig,['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodCar) Then
    Begin
      If fEmptyStr(edtCodCar.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Código da Carteira deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodCop) Then
    Begin
      If fEmptyStr(edtCodCop.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Código da Cooperativa deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End
      Else
      If Length(edtCodCop.Text) <> edtCodCop.MaxLength Then
      Begin
        fMensagem('ATENÇÃO','O campo Código da Cooperativa deve 4 caracteres!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigCop) Then
    Begin
      If fEmptyStr(edtDigCop.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Dígito da Cooperativa deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End
    End

    Else If (Sender = edtCodCed) Then
    Begin
      If fEmptyStr(edtCodCed.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Código do Cedente deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End
      Else
      If Length(edtCodCed.Text) <> edtCodCed.MaxLength Then
      Begin
        fMensagem('ATENÇÃO','O campo Código do Cedente deve ter 7 caracteres!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigCed) Then
    Begin
      If fEmptyStr(edtDigCed.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Dígito do Cedente deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCtaCor) Then
    Begin
      If fEmptyStr(edtCtaCor.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Conta Corrente deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigCta) Then
    Begin
      If fEmptyStr(edtDigCta.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Dígito da Conta Corrente deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = cmbModali) Then
    Begin
      If cmbModali.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO','O Campo Modalidade deve ser informado!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtNumCon) Then
    Begin
      If Not(fEmptyStr(edtNumCon.Text)) And
        (Length(edtNumCon.Text) <> edtNumCon.MaxLength) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Número do Convênio deve ter 6 caracteres!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtConCrr) And
            (edtConCrr.Enabled)  Then
    Begin
      If fEmptyStr(edtConCrr.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Convênio (Correspondente BB) deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End
      Else If Length(edtConCrr.Text) <> edtConCrr.MaxLength Then
      Begin
        fMensagem('ATENÇÃO','O campo Convênio (Correspondente BB) deve ter 10 caracteres!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtSRemBB) And
            (edtSRemBB.Enabled)  Then
    Begin
      If fEmptyStr(edtSRemBB.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Sequencia da Remessa (Correspondente BB) deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = chkCartSeq) Then
    Begin
      If (chkCartSeq.Checked) Then
      Begin
        If fVerificaCartPrimariaAutBan('CONFIG756_240p-', tabCarteira.TabIndex + 1) Then
        Begin
          fMensagem('ATENÇÃO','Não pode ser utilizada sequência de Arquivo de Remessa de outra carteira, pois essa está cadastrada no campo Carteira Seq. de outra(s) carteira(s).' ,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCartSeq) Then
    Begin
      If (chkCartSeq.Checked) Then
      Begin
        If fEmptyStr(edtCartSeq.Text) Then
        Begin
          fMensagem('ATENÇÃO','O campo Carteira Seq. deve ser preenchido!' ,['&O K']);
          Result := False;
        End
        Else
        Begin
          If (Pos(edtCartSeq.Text, '1_2_3_4_5_') <= 0) Then
          Begin
            fMensagem('ATENÇÃO','O campo Carteira Seq. deve ter valor entre 1 e 5!' ,['&O K']);
            Result := False;
          End
          Else
          If edtCartSeq.Text = IntToStr(tabCarteira.TabIndex + 1) Then
          Begin
            fMensagem('ATENÇÃO','O campo Carteira Seq. não pode ser igual a carteira selecionada!' ,['&O K']);
            Result := False;
          End
          Else
          If fEmptyStr(fGetBancoConfig(0, 'CONFIG756_240p-' + edtCartSeq.Text, 'PROXNUM', '')) Then
          Begin
            fMensagem('ATENÇÃO','Não pode ser usada essa carteira no campo Carteira Seq., pois essa não possui Último Núm. Seq. Remessa cadastrado!' ,['&O K']);
            Result := False;
          End
          Else
          If fVerificaCartFilhaAutBan('CONFIG756_240p-' + edtCartSeq.Text) Then
          Begin
            fMensagem('ATENÇÃO','Não pode ser usada essa carteira no campo Carteira Seq., pois essa já possui uma Carteira Seq. cadastrada!' ,['&O K']);
            Result := False;
          End;
        End;
      End;
    End;

  End;

  If Not Result Then
  begin
    cxPaginas.ActivePage := RetornaAbaDoComponete(Sender);
    if not blnNaoEditar then
    begin
      pSetFocus(Sender);
    end;
  end;

End;

procedure TfrmConfigBancoob240.grdTarifasDBTableView1DblClick(Sender: TObject);
begin
  inherited;
  If Not cdsCnfOco.isEmpty Then
    btnEdtOco.Click;
end;

procedure TfrmConfigBancoob240.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
  cxPaginas.ActivePage := tbsGeral;
end;

procedure TfrmConfigBancoob240.tabCarteiraChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if btnCancelar.Visible then
  begin
    btnCancelar.Click;
    if btnCancelar.Visible then
      AllowChange := False;
  end;

  inherited;

end;

procedure TfrmConfigBancoob240.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, nil, Key, arrSel) then
    Begin
      if fValidaCampos(edtCodPor) then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigBancoob240.edtCodPorRemKeyPress(Sender: TObject;
  var Key: Char);
var
 ArrSel: TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtCodPorRem, edtDescPorRem, nil, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodPorRem, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigBancoob240.edtConDesSujEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtConDesSuj, 'Quando a diferença no valor recebido ' + #13+#10 +
                            'for exatamento o valor de desconto sugerido ' + #13+#10 +
                            'cadastrado no título a diferença será abatida '+ #13+#10+
                            'como desconto. ' );

  pShowHint(edtConDesSuj, 'Desconto Sugerido');
end;

procedure TfrmConfigBancoob240.edtConDesSujExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoob240.edtForTarKeyPress(Sender: TObject; var Key: Char);
Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************KP*}
  If fPesqFornecedor(conForCompleta, Self, edtForTar, edtDesForTar, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtForTar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConfigBancoob240.edtNumNosEnter(Sender: TObject);
begin
  inherited;

  edtNumNos.Hint := '';
  pShowHint(edtNumNos, 'Índice do nosso número');

end;

procedure TfrmConfigBancoob240.edtNumNosExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoob240.edtNumNosMouseEnter(Sender: TObject);
begin
  inherited;
  edtNumNosEnter(Sender);
end;

procedure TfrmConfigBancoob240.edtNumNosMouseLeave(Sender: TObject);
begin
  inherited;
  edtNumNosExit(Sender);
end;

procedure TfrmConfigBancoob240.edtPorTarKeyPress(Sender: TObject; var Key: Char);
Var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtPorTar, edtDesPorTar, nil, Key, arrSel) then
    Begin
      if fValidaCampos(edtPorTar) then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigBancoob240.edtValorTarifaExit(Sender: TObject);
begin
  inherited;
  try
    if not fEmptyStr(edtValorTarifa.Text) then
       edtValorTarifa.Text := FormatFloat('###,##0.00', fStrToFloat(edtValorTarifa.Text));
  except

  end
end;

procedure TfrmConfigBancoob240.pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    edtLabel.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmConfigBancoob240.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtLabel.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmConfigBancoob240.FormActivate(Sender: TObject);
begin
  inherited;
  If fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1),'USACRR_','') = 'S' Then
  Begin
    edtConCrr.Enabled := True;
    edt7Digit.Enabled := True;
    edtCar_BB.Enabled := True;
    edtSRemBB.Enabled := True;
  End
  Else
  Begin
    edtConCrr.Enabled := False;
    edt7Digit.Enabled := False;
    edtCar_BB.Enabled := False;
    edtSRemBB.Enabled := False;
  End;

  pSetFocus(edtProxNumArqRem);
end;

procedure TfrmConfigBancoob240.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  qryCadFor := fCriaQuery(Self);
  pCarKeyAutBan;
  cxPaginas.Properties.ActivePage := tbsGeral;

  If fCfgSis('ENCBAN', varBoolean) Then
    tbsEncBan.TabVisible := True
  else
    tbsEncBan.TabVisible := False;

end;

procedure TfrmConfigBancoob240.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_Escape) then
  begin
    if btnCancelar.Visible then
    begin
      btnCancelar.Click;
      if btnCancelar.Visible then
        SysUtils.Abort;
    end;
  end;

  inherited;

end;

procedure TfrmConfigBancoob240.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoob240.btnAddOcoClick(Sender: TObject);
begin
  inherited;
  frmCadOcoCartei := TfrmCadOcoCartei.Create(nil);
  frmCadOcoCartei.strCartei :=  'CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp;
  frmCadOcoCartei.cmbTipDes.Visible := True;
  frmCadOcoCartei.cmbTipDes.Enabled := True;
  frmCadOcoCartei.lblTipDes.Visible := True;

  Try
    frmCadOcoCartei.ShowModal;
  Finally
    FreeAndNil(frmCadOcoCartei);
  End;

  pCarregaOcorrencias;
end;

procedure TfrmConfigBancoob240.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&S i m', '&N ã o'], 2) = 1 then
  begin
    cxPaginas.ActivePage :=  tbsGeral;
    btnCancelar.Visible := False;
    btnEditar.Visible   := True;
    pnlAtivo1.Enabled := False;
    pnlComplemento.Enabled := pnlAtivo1.Enabled;

    if tbsEncBan.tabVisible then
      pnlAtivo2.Enabled:= False;

    btnEditar.Visible   := True;
    btnGravar.Enabled   := False;
    btnConfigurar.Enabled := False;
    pCarregaDados;
    pSetFocus(btnEditar);
  end;

end;

procedure TfrmConfigBancoob240.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try

    pCriarFormularios(TfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '756';

    If (fCfgSis('CAROCO', varBoolean)) then
        frmCfgGenericas_AutBan.strCartei  := IntToStr(tabCarteira.TabIndex + 1);

    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigBancoob240.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\756400p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\756400p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigBancoob240.BtnOcorrenciaClick(Sender: TObject);
  Var
    strDetalhe : String;
begin
  inherited;
  pHideHint;

  strDetalhe := #13#10 +
                '06, 09 - Baixa duplicata; ' + #13#10 +
                '02 - Atualiza nosso número caso não tenha gravado; ' + #13#10 +
                '19 - Confirmação de instrução de protesto; ' + #13#10 +
                '23 - Lança histórico de protesto. ' + #13#10 +
                '25 - Protestado e baixado (Baixa por ter sido protestado). *Somente será realizado a baixa automática caso configurado com "S" a configuração "Baixar Automaticamente Ocorrência 25". ' + #13#10 +
                #13#10 +
                'As ocorrências listadas também fazem a atualização do código ' +
                'do Evento e do Portador das duplicatas, no caso dessas  ' +
                'ocorrências possuírem Evento/Portador vinculadas.' + #13#10 +
                #13#10 +
                'As Demais ocorrências são gravadas na rotina ' +
                'de retorno e mostradas no relatório apenas em ' +
                'caráter informativo.'+ #13#10 +
                #13#10 +
                'Pressione Esc para voltar à tela de configurações.';

  TfrmMemo.pShowMessage('Bancoob 756 [240p] - Banco Cooperativo do Brasil - Detalhamento de Ocorrências (posições 16 - 17 segmento U arquivo retorno).' + #13#10 +
                        strDetalhe);
end;

procedure TfrmConfigBancoob240.BtnOcorrenciaEnter(Sender: TObject);
begin
  inherited;
  pAlteraHintBotao(btnOcorrencia, 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                                  'que são tratados pelas rotinas do sistema.');
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigBancoob240.BtnOcorrenciaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoob240.BtnOcorrenciaMouseEnter(Sender: TObject);
begin
  inherited;
  pAlteraHintBotao(btnOcorrencia, 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                                  'que são tratados pelas rotinas do sistema.');
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigBancoob240.BtnOcorrenciaMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoob240.chkCartSeqClick(Sender: TObject);
begin
  inherited;
  If Not fValidaCampos(chkCartSeq) Then
    TCheckBox(Sender).Checked := False;

  lblCartSeq.Enabled := TCheckBox(Sender).Checked;
  edtCartSeq.Enabled := TCheckBox(Sender).Checked;
end;

procedure TfrmConfigBancoob240.cmbCodigoMultaChange(Sender: TObject);
begin
  inherited;
  DefineDescricaoTipoMulta;
end;

procedure TfrmConfigBancoob240.cmbInstrucao1Change(Sender: TObject);
begin
  inherited;
  If cmbInstrucao1.itemIndex = 8 Then
  Begin
     edtDiasLimrec.enabled := True
  End
  Else
  Begin
     edtDiasLimrec.enabled := False;
     edtDiasLimrec.Clear;
  End;
end;

procedure TfrmConfigBancoob240.cmbProtestoChange(Sender: TObject);
begin
  inherited;
  if Copy(cmbProtesto.Text, 1, 1) = '3' then
  Begin
    edtDiasProt.Enabled := False;
    edtDiasProt.Text    := '0';
  End
  else
    edtDiasProt.Enabled := True;
end;

procedure TfrmConfigBancoob240.DefineDescricaoTipoMulta;
begin
  lblMulta.Caption := 'Percentual de Multa:';
  If cmbCodigoMulta.ItemIndex = 0 Then
   lblMulta.Caption := 'Valor fixo de Multa:';
end;

procedure TfrmConfigBancoob240.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. Remessa      : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Util Outra Cart.  : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', ''));
  stlCampos.Add('Carteira Seq.     : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', ''));
  stlCampos.Add('Código Carteira   : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', ''));
  stlCampos.Add('Espécie Título    : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ESPDOC_', ''));
  stlCampos.Add('Código Cooperativa: ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCOPE', ''));
  stlCampos.Add('Dígito Cooperativa: ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCOPE', ''));
  stlCampos.Add('Código Cedente    : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCEDE', ''));
  stlCampos.Add('Dígito Cedente    : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCEDE', ''));
  stlCampos.Add('Conta Corrente    : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCCOR', ''));
  stlCampos.Add('Dig Cta Corrente  : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCCOR', ''));
  stlCampos.Add('Modalidade        : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'MODALID', ''));
  stlCampos.Add('Número Convênio   : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCONV', ''));
  stlCampos.Add('Cód. Instrução 1  : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''));
  stlCampos.Add('Cód. Instrução 2  : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', ''));
  stlCampos.Add('Observação 1      : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2      : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3      : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4      : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Observação 5      : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  stlCampos.Add('Código Protesto   : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODPROT', ''));
  stlCampos.Add('Dias p/ Protesto  : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  stlCampos.Add('Dias para mora    : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAMORA', ''));
  stlCampos.Add('Dias p/ crédito   : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Percentual Multa  : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', ''));
  stlCampos.Add('Arquivo Remessa   : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo Retorno   : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Resp. Emissão Bol : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));
  stlCampos.Add('Protocolo Aceite  : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  stlCampos.Add('Na importação do retorno considerar apenas duplicatas da empresa logada?:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DUPEMPLOG', ''));
  stlCampos.Add('Portador de Baixa : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Portador da remessa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  stlCampos.Add('Conta Baixa       : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Info Adicional    : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', ''));
  stlCampos.Add('Usa Corresp. BB   : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'USACRR_', ''));
  stlCampos.Add('Conv Corresp BB   : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CONVCRR', ''));
  stlCampos.Add('7 dígitos BB      : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CRRBB7D', ''));
  stlCampos.Add('Seq Rem Corresp BB: ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SEQRMBB', ''));
  stlCampos.Add('Cartei Corresp BB : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CRRCART', ''));
  stlCampos.Add('Nro Dupl. Agrup.  : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'MANDMSG', ''));
  stlCampos.Add('Nosso número      : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMNOSS', ''));
  stlCampos.Add('Enviar Sacador/Avalista na Remessa  : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENVSACA', ''));
  stlCampos.Add('Lançar Tarifa Bancária              : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'LANTX02', ''));
  stlCampos.Add('Utl. Desconto de Duplicatas?:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'UTLDESDUP', ''));
 // stlCampos.Add('Baixar Automaticamente Ocorrência 25: ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'BAIXAOCO25', '')); //NÃO É MAIS UTILIZADA (Req.151476) - RP
  stlCampos.Add('Ocorrências a ignorar na baixa autom: ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OCOIGNORA', ''));
  stlCampos.Add('Enc.Ban. Vr Tarifa: ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', ''));
  stlCampos.Add('Enc.Ban. Portador : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', ''));
  stlCampos.Add('Enc.Ban. Pl Conta : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', ''));
  stlCampos.Add('Enc.Ban. Fornec.  : ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', ''));
  stlCampos.Add('Tipo Dias para Crédito ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPODTACRE', ''));
  stlCampos.Add('Codigo da Multa: ' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODIGOMULTA', ''));
  stlCampos.Add('Considerar Desconto Sugerido na baixa?:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CONSIDESSUJ', ''));
  stlCampos.Add('Permitir impressão de boletos? :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', ''));
  stlCampos.Add('Boleto no Layout do Novo Contrato? :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'BOLNOVCON', ''));
end;

procedure TfrmConfigBancoob240.pGravaLogCarteira(stlCfgAnt : TStringList);
Var
  stlCfgAtu: TStringList;
  strCmpAlt: String;
  intCont,
  intIndice: Integer;

  function fRetStrCfg(stlCfg : TStringList) : String;
  Var
    intCont : Integer;
  begin
    Result := '';

    For intCont := 0 To stlCfg.Count - 1 Do
      Result := Result + stlCfg.Strings[intCont] + #13+#10;
  end;

begin
  stlCfgAtu := TStringList.Create;
  pCarregaCfg(stlCfgAtu);
  strCmpAlt := '';

  For intCont := 0 To stlCfgAtu.Count - 1 Do
  Begin
    If stlCfgAnt.Strings[intCont] <> stlCfgAtu.Strings[intCont] Then
    Begin
      intIndice := Pos(':', stlCfgAnt.Strings[intCont]);

      If Not fEmptyStr(strCmpAlt) Then
        strCmpAlt := strCmpAlt + #13+#10;

      strCmpAlt := strCmpAlt + Copy(stlCfgAnt.Strings[intCont], 1, intIndice) +
                  ' Valor Anterior - ' + Copy(stlCfgAnt.Strings[intCont], intIndice + 1, Length(stlCfgAnt.Strings[intCont]) - intIndice) +
                  ' Valor Atual - ' + Copy(stlCfgAtu.Strings[intCont], intIndice + 1, Length(stlCfgAtu.Strings[intCont]) - intIndice);
    End;
  End;

  If Not fEmptyStr(strCmpAlt) Then
    pGravaLogAtb('756', 'BANCOOB 240p', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

procedure TfrmConfigBancoob240.pHideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmConfigBancoob240.pAlteraHintBotao(btnBotao: TBitBtnLocked;
  strNovoHint: String);
begin
  btnBotao.Hint := strNovoHint;
end;

{***********************************************}
{* A CONFIG 'BAIXAOCO25' NÃO É MAIS UTILIZADA. *}
{* FOI SUBSTITUÍDA PELA CONFIG 'OCOIGNORA'     *}
{* QUE PERMITE INFORMAR VÁRIOS CÓDIGOS.        *}
{*REQ*151476*********************************RP*}
procedure TfrmConfigBancoob240.pAtualizaOcorrencia25;
  Var
    strCfg25, strCfgOco: String;
    qryDelete: TUniQuery;
begin
  If strConfig = '' Then
    strConfig := 'CONFIG756_240p-';

  strCfg25 := fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'BAIXAOCO25', '');

  If Not fEmptyStr(strCfg25) Then
  Begin
    If strCfg25 = 'N' Then
    Begin
      strCfgOco := fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OCOIGNORA', '');

      If Pos('25', strCfgOco) = 0 Then
        fGetBancoConfig(1, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OCOIGNORA', '25;' + strCfgOco);
    End;

    qryDelete := fCriaQuery(Self);
    qryDelete.SQL.Add('DELETE FROM CFGBAN');
    qryDelete.SQL.Add('WHERE SIS_CODEMP = :CODEMP');
    qryDelete.SQL.Add('  AND SIS_CODBAN = :CODBAN');
    qryDelete.SQL.Add('  AND SIS_CARTEI = :CARTEI');
    qryDelete.SQL.Add('  AND SIS_NUMPOS = :NUMPOS');
    qryDelete.SQL.Add('  AND SIS_CODCFG = :CODCFG');

    qryDelete.ParamByName('CODEMP').AsString  := VS_strCodEmp;
    qryDelete.ParamByName('CODBAN').AsString  := '756';
    qryDelete.ParamByName('CARTEI').AsInteger := tabCarteira.TabIndex + 1;
    qryDelete.ParamByName('NUMPOS').AsString  := '240p';
    qryDelete.ParamByName('CODCFG').AsString  := 'BAIXAOCO25';
    qryDelete.ExecSQL;
    qryDelete.Free;
  End;
end;

procedure TfrmConfigBancoob240.pShowHintBotao(btnBotao: TBitBtnLocked;
  strTitulo: String);
begin
  HintControler.ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, strTitulo, btnBotao.Hint);
end;

function TfrmConfigBancoob240.RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
begin
  While Not Sender.ClassName.Equals('TcxTabSheet') Do
  Begin
    Sender := Sender.Parent;
  End;
  Result := TcxTabSheet(Sender);
end;

procedure TfrmConfigBancoob240.btnRemOcoClick(Sender: TObject);
Var
  objCnfOco: TCnfOco;
  objCnfDao: TCnfOcoDao;
  strCodBco: String;
  strTipLay: String;
  strNumPos: String;
  strEspeci: String;
  strCodEmp: String;
  intCartei: Integer;
begin
  inherited;
  If Not cdsCnfOco.isEmpty Then
  Begin
    if fMensagem('Aviso', 'Confirma remoção da ocorrência selecionada?', ['&S i m', '&N ã o']) = 1 then
    Begin
      pDesmembraCarteira(strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp,
                         strCodBco, strTipLay, strNumPos, strEspeci, strCodEmp, intCartei);

      objCnfDao := TCnfOcoDao.Create(strCodBco, strTipLay, strNumPos,
                                     strEspeci, strCodEmp, intCartei);

      objCnfOco := objCnfDao.fBuscaPorOcorrencia(cdsCnfOcoCNF_CODOCO.AsString,'',Copy(cdsCnfOcoCNF_PLNCON.AsString,1,7),cdsCnfOcoCNF_TIPDES.AsInteger);
      If Assigned(objCnfOco) Then
      Begin
        If objCnfDao.fRemoverOcorrencia(objCnfOco.strCodOco,'',objCnfOco.strCodCta,objCnfOco.intTipDes) Then
        Begin
          pCarregaOcorrencias;
          pMensagemOk('Registro removido com sucesso!');
        End;
        objCnfOco.Free;
      End;
      objCnfDao.Free;
    End;
  End;
end;

procedure TfrmConfigBancoob240.pCarregaOcorrencias;
var
  lstCnfOco: TObjectList<TCnfOco>;
  objCnfOco: TCnfOco;
  objCnfDao: TCnfOcoDao;
  strCodBco: String;
  strTipLay: String;
  strNumPos: String;
  strEspeci: String;
  strCodEmp: String;
  intCartei: Integer;
begin
  cdsCnfOco.DisableControls;
  cdsCnfOco.EmptyDataSet;
  cdsCnfOco.Close;
  cdsCnfOco.Open;

  pDesmembraCarteira('CONFIG756_240p-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp,
                     strCodBco, strTipLay, strNumPos, strEspeci, strCodEmp, intCartei);

  objCnfDao := TCnfOcoDao.Create(strCodBco, strTipLay, strNumPos,
                                 strEspeci, strCodEmp, intCartei);

  lstCnfOco := objCnfDao.fBuscaTodas;

  If lstCnfOco.Count > 0 Then
  Begin
    For objCnfOco in lstCnfOco Do
    Begin
      With cdsCnfOco Do
      Begin
        Append;
        cdsCnfOcoCNF_CODOCO.AsString := objCnfOco.strCodOco;
        cdsCnfOcoCNF_DESOCO.AsString := objCnfOco.strDesOco;
        cdsCnfOcoCNF_GERPAG.Value    := objCnfOco.blnGerpag;
        cdsCnfOcoCNF_CUSCAR.Value    := objCnfOco.blnCusCar;
        cdsCnfOcoCNF_UsaDia.Value    := objCnfOco.blnUsaDia;
        cdsCnfOcoCNF_FORNEC.AsString := objCnfOco.strCodFor + ' - ' + fRetNomFornecedor(objCnfOco.strCodFor);
        cdsCnfOcoCNF_PORTAD.AsString := objCnfOco.strCodPor + ' - ' + fRetNomPortador(objCnfOco.strCodPor);
        cdsCnfOcoCNF_PLNCON.AsString := objCnfOco.strCodCta + ' - ' + fRetDescCentroCusto(objCnfOco.strCodCta);
        cdsCnfOcoCNF_TIPDES.AsInteger:= objCnfOco.IntTipDes;
        Case objCnfOco.IntTipDes of
          0: cdsCnfOcoCNF_DSTPDS.AsString := '';
          1: cdsCnfOcoCNF_DSTPDS.AsString := 'TARIFA IOF DESCONTO';
          2: cdsCnfOcoCNF_DSTPDS.AsString := 'TARIFA BOLETO DESC';
          3: cdsCnfOcoCNF_DSTPDS.AsString := 'TARIFA DESCONTADA';
          4: cdsCnfOcoCNF_DSTPDS.AsString := 'JUROS OPERAÇÃO';
        End;
        Post;
      End;
    End;
  End;

  lstCnfOco.Free;
  objCnfDao.Free;

  cdsCnfOco.First;
  cdsCnfOco.EnableControls;
end;

procedure TfrmConfigBancoob240.pAlteraHint(edtEdit: TEditFocus;
  strNovoHint: String);
begin
  edtEdit.Hint := strNovoHint;
end;

end.
