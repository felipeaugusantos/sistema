unit untConfigSafraAPI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  DirectoryEditFocus, EditFocus, QColorLabel, ComCtrls, ShellApi, Uni,
  AppEvnts, MaskEditFocus, cxContainer, cxEdit, cxGroupBox, cxPC,
  cxControls, ComboBoxFocus, BitBtnLockedIncrem, cxPCdxBarPopupMenu, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, dxBarBuiltInMenu, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, dxScreenTip, cxClasses, dxCustomHint, cxHint,
  StrUtils, cxTextEdit, cxMaskEdit, cxButtonEdit, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator,
  Data.DB, cxDBData, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox, Datasnap.DBClient,
  System.Generics.Collections, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  Vcl.DBCtrls, DBEditFocus, DBMemoFocus, MemoFocus,
  untFramePlanoDeContasMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, untFrameGerarPixBoleto, untTBancoSafraAPI,
  untFrameDirectoryEditFocus;

type
  TfrmConfigSafraAPI = class(TfrmPai)
    pnlDados: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    cxPaginas: TcxPageControl;
    tbsGeral: TcxTabSheet;
    HintControler: TcxHintStyleController;
    btnCancelar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    BtnManual: TBitBtnLocked;
    BtnOcorrencia: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    pnlAtivo1: TPanel;
    lblDiasProt: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label25: TLabel;
    edtDiasProt: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtDiasCred: TEditFocus;
    edtPerMul: TEditFocus;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    pnlChaveConexao: TPanel;
    Label8: TLabel;
    Label3: TLabel;
    edtClientID: TEditFocus;
    Label15: TLabel;
    edtProAce: TEditFocus;
    ColorLabel3: TColorLabel;
    cxTabDadosBaixa: TcxTabSheet;
    pnlAtivo2: TPanel;
    gpbSimples: TcxGroupBox;
    Label4: TLabel;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    fraPlanoDeContasBai: TfraPlanoDeContasMskEdit;
    gpbVinculada: TcxGroupBox;
    Label17: TLabel;
    edtDesPorVin: TEditFocus;
    edtCodPorVin: TEditFocus;
    fraPlanoDeContasVin: TfraPlanoDeContasMskEdit;
    tbsEncBan: TcxTabSheet;
    pnlAtivo3: TPanel;
    cxGroupBox1: TcxGroupBox;
    Label26: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    edtDesPorTar: TEditFocus;
    edtPorTar: TEditFocus;
    edtValorTarifa: TEditFocus;
    edtDesForTar: TEditFocus;
    edtForTar: TEditFocus;
    cmbLancarTarifa: TComboBoxFocus;
    fraPlanoDeContasEnc: TfraPlanoDeContasMskEdit;
    grpTarAux: TcxGroupBox;
    btnAddOco: TBitBtnLocked;
    btnRemOco: TBitBtnLocked;
    btnEdtOco: TBitBtnLocked;
    pnlGridTarifas: TPanel;
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
    cdsCnfOcoCNF_MOTOCO: TStringField;
    cdsCnfOcoCNF_USADIA: TBooleanField;
    Label18: TLabel;
    edtDigAgencia: TEditFocus;
    Label19: TLabel;
    edtQtdeDiasDevolucao: TEditFocus;
    cmbTipoDesconto: TComboBoxFocus;
    Label6: TLabel;
    Label21: TLabel;
    cmbAmbiente: TcxComboBox;
    edtPassword: TEditFocus;
    edtCodAgencia: TEditFocus;
    Label23: TLabel;
    edtContaCorr: TEditFocus;
    lblCodAgenc: TLabel;
    Label1: TLabel;
    btnValidaAcesso: TBitBtnLocked;
    fraGerarPixBoleto: TfraGerarPixBoleto;
    Label2: TLabel;
    edtUserName: TEditFocus;
    cxTabDadosSacadorAvalista: TcxTabSheet;
    PnlAtivo4: TPanel;
    pnlSacAva: TPanel;
    Label5: TLabel;
    ColorLabel7: TColorLabel;
    lblPerImpBol: TLabel;
    clbPerImpBol: TColorLabel;
    grpBeneficiario: TGroupBox;
    lblDesCrr: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label7: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    edtDesBen: TEditFocus;
    edtEndBen: TEditFocus;
    edtCompBen: TEditFocus;
    edtBaiBen: TEditFocus;
    edtCidBen: TEditFocus;
    edtEstBen: TEditFocus;
    edtCepBen: TMaskEditFocus;
    edtCgcBen: TMaskEditFocus;
    edtUsaSac: TEditFocus;
    edtPerImpBol: TEditFocus;
    edtCodCar: TEditFocus;
    lblCodCart: TLabel;
    fraPathRetorno: TfraDirectoryEditFocus;
    lblPathArquivosRet: TLabel;
    lblDiasParaBaixa: TLabel;
    edtDiasLimiteRec: TEditFocus;
    procedure pCarregadados;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure lblValidaOcoMouseLeave(Sender: TObject);
    procedure edtDiasCredEnter(Sender: TObject);
    procedure edtDiasCredExit(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtQtdDiasDataLimiteRecEnter(Sender: TObject);
    procedure edtQtdDiasDataLimiteRecExit(Sender: TObject);
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure edtClientIDExit(Sender: TObject);
    procedure edtPerMulExit(Sender: TObject);
    procedure edtClientIDEnter(Sender: TObject);
    procedure edtQtdDiasNegaEnter(Sender: TObject);
    procedure edtQtdDiasNegaExit(Sender: TObject);
    procedure edtDiasProtEnter(Sender: TObject);
    procedure edtDiasProtExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorVinKeyPress(Sender: TObject; var Key: Char);
    procedure cmbContaCaucaoMouseLeave(Sender: TObject);
    procedure cmbContaCaucaoExit(Sender: TObject);
    procedure edtForTarKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasEncMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure edtPorTarKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddOcoClick(Sender: TObject);
    procedure btnEdtOcoClick(Sender: TObject);
    procedure btnRemOcoClick(Sender: TObject);
    procedure edtValorTarifaExit(Sender: TObject);
    procedure btnValidaAcessoClick(Sender: TObject);
    procedure fraGerarPixBoletocmbChavePixPropertiesEditValueChanged(
      Sender: TObject);
    procedure cmbTpCobrancaPropertiesEditValueChanged(Sender: TObject);
    procedure edtContaCorrEnter(Sender: TObject);
    procedure edtContaCorrExit(Sender: TObject);
    procedure edtContaCorrMouseEnter(Sender: TObject);
    procedure edtContaCorrMouseLeave(Sender: TObject);
    procedure fraGerarPixBoletoedtGerarPixChange(Sender: TObject);

  private

    qryCadPor : TUniQuery;
    qryCadEmp : TUniQuery;
    qryCadCta : TUniQuery;
    qryCadFor : TUniQuery;

    LBancoSafraAPI: TBancoSafraAPI;

    FCarteira : String;

    procedure pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pShowHint(edtEdit: TEditFocus; strTitulo: String);
    procedure pHideHint;
    procedure pAlteraHint(edtEdit: TEditFocus; strNovoHint: String);
    procedure pLimpaCampos;
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
    procedure InformaTipoAPP;
    function fRetStrCfg(stlCfg : TStringList) : String;
    function PortadorValido(ACodigo: TEdit; ADescricao: TEdit):Boolean;
    function PlanoDeContaValido(ACodigo: TMaskEdit; ADescricao: TEdit):Boolean;
    function RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
    procedure pCarregaOcorrencias;
    procedure CarregaLancamentoTarifaBancaria;
    procedure CarregaFornecedor;

    { Private declarations }
  public
    { Public declarations }
    blnNaoEditar : Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;

  end;

var
  frmConfigSafraApi: TfrmConfigSafraApi;

implementation

uses  untfuncoesSimples, untPesqAux, untFuncoes,
     untCfgGenericas_AutBan, untConsultas, untCadOcoCartei,
     untCNFOCO_Class, untCNFOCO_Dao;

{$R *.dfm}

{ TfrmPai1 }

procedure TfrmConfigSafraAPI.pCarregadados;
begin
  pLimpaCampos;
  fraGerarPixBoleto.CarregarChavesPix('422');

  FCarteira := 'CONFIG422API-' + (tabCarteira.TabIndex + 1).ToString;

  CarregaLancamentoTarifaBancaria;

  edtCodCar.Text                     := fGetBancoConfig(0, FCarteira, 'CODCART', '');
  edtCodAgencia.Text                 := fGetBancoConfig(0, FCarteira, 'CODAGEN', '');
  edtDigAgencia.Text                 := fGetBancoConfig(0, FCarteira, 'DIGAGEN', '');
  edtContaCorr.Text                  := fGetBancoConfig(0, FCarteira, 'NUMCTAC', '');
  cmbTipoDesconto.ItemIndex          := StrToIntDef(fGetBancoConfig(0, FCarteira, 'TIPO_DESC',     '0'), 0); //TIPO DESCONTO
  edtPassword.Text                   := fGetBancoConfig(0, FCarteira, 'PASSWORD', '');  //PASSWORD;
  edtDiasProt.Text                   := fGetBancoConfig(0, FCarteira, 'DIAPROT', '');   // QTDE DIAS DE PROTESTO
  edtQtdeDiasDevolucao.Text          := fGetBancoConfig(0, FCarteira, 'QTDIASDEV', ''); // QTDE DE DIAS DE DEVOLUÇÃO.
  edtDiasLimiteRec.Text              := fGetBancoConfig(0, FCarteira, 'DIALIMR', '0');  // QTDE DE DIAS limite para recebimento
  edtObservacao1.Text                := fGetBancoConfig(0, FCarteira, 'OBSERV1', '');
  edtObservacao2.Text                := fGetBancoConfig(0, FCarteira, 'OBSERV2', '');
  edtObservacao3.Text                := fGetBancoConfig(0, FCarteira, 'OBSERV3', '');
  edtObservacao4.Text                := fGetBancoConfig(0, FCarteira, 'OBSERV4', '');
  fraPathRetorno.edtDirectory.text   := fGetBancoConfig(0, FCarteira, 'PATHRET','');
  edtCodPor.Text                     := fGetBancoConfig(0, FCarteira, 'PORBAI_', '');
  edtCodPorVin.Text                  := fGetBancoConfig(0, FCarteira, 'PORBAI_VIN', '');
  fraPlanoDeContasBai.MskCodCta.Text := fGetBancoConfig(0, FCarteira, 'CTABAI_', '');
  fraPlanoDeContasVin.MskCodCta.Text := fGetBancoConfig(0, FCarteira, 'CTABAI_VIN', '');
  edtPerMul.Text                     := fGetBancoConfig(0, FCarteira, 'PERMULT', '');
  edtDiasCred.Text                   := fGetBancoConfig(0, FCarteira, 'DIACRED', '');
  edtProAce.Text                     := fGetBancoConfig(0, FCarteira, 'PROACEI', '');

  edtClientId.Clear;
  If (fGetBancoConfig(0, FCarteira, 'CLIENT_ID', '') <> '') Then
      edtClientId.Text := 'Client ID Cadastrado';

  edtUsername.Text      := fGetBancoConfig(0, FCarteira, 'USERNAME', '');
  edtPassword.Text      := fGetBancoConfig(0, FCarteira, 'PASSWORD', '');
  cmbAmbiente.ItemIndex := StrToIntDef(fGetBancoConfig(0, FCarteira, 'TPAMBIENTE', '0'), 0);
  edtPorTar.Text        := fGetBancoConfig(0, FCarteira, 'PORTTAR', '');
  fraPlanoDeContasEnc.MskCodCta.Text := fGetBancoConfig(0, FCarteira, 'CONTTAR', '');
  edtForTar.Text                     := fGetBancoConfig(0, FCarteira, 'FORNTAR', '');
  edtValorTarifa.Text                := fGetBancoConfig(0, FCarteira, 'VALOTAR', '');

  edtPerImpBol.Text := fGetBancoConfig(0, FCarteira, 'PERIMPBOL', '');
  If fEmptyStr(edtPerImpBol.Text) Then
    edtPerImpBol.Text := 'S';

  //Dados Beneficiário
  edtUsaSac.Text  := fGetBancoConfig(0, FCarteira, 'SACAVAL', '');
  edtUsaSac.Text  := IIF(fEmptyStr(edtUsaSac.Text), 'N', edtUsaSac.Text);
  edtDesBen.Text  := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'NOMEBEN', ''), '');
  edtEndBen.Text  := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'ENDEBEN', ''), '');
  edtBaiBen.Text  := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'BAIRBEN', ''), '');
  edtCompBen.Text := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'COMPBEN', ''), '');
  edtCidBen.Text  := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'CIDABEN', ''), '');
  edtEstBen.Text  := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'ESTABEN', ''), '');
  edtCepBen.Text  := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'CEP_BEN', ''), '');
  edtCgcBen.Text  := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'CNPJBEN', ''), '');

  fraGerarPixBoleto.edtGerarPix.Text      := fGetBancoConfig(0, FCarteira, 'GERAPIX', '');
  fraGerarPixBoleto.cmbChavePix.EditValue := fGetBancoConfig(0, FCarteira, 'CHAPIX', '');
  fraGerarPixBoleto.cmbChavePix.Enabled   := False;

  pCarregaPortador(edtCodPor.Text, edtDesPor);
  pCarregaPortador(edtCodPorVin.Text, edtDesPorVin);
  pCarregaPortador(edtPorTar.Text, edtDesPorTar);

  pCarregaCentroCusto(fraPlanoDeContasBai.MskCodCta.Text, fraPlanoDeContasBai.edtDesCta);
  pCarregaCentroCusto(fraPlanoDeContasVin.MskCodCta.Text, fraPlanoDeContasVin.edtDesCta);
  pCarregaCentroCusto(fraPlanoDeContasEnc.MskCodCta.Text, fraPlanoDeContasEnc.edtDesCta);
  CarregaFornecedor;
  //pCarregaOcorrencias;

  InformaTipoAPP;
end;

procedure TfrmConfigSafraAPI.pCarregaOcorrencias;
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

  pDesmembraCarteira(FCarteira + '-' + VS_strCodEmp, strCodBco,
                     strTipLay, strNumPos, strEspeci, strCodEmp, intCartei);

  objCnfDao := TCnfOcoDao.Create(strCodBco, strTipLay, strNumPos,
                                 strEspeci, strCodEmp, intCartei);

  lstCnfOco := objCnfDao.fBuscaTodas;

  If lstCnfOco.Count > 0 Then
  Begin
    For objCnfOco in lstCnfOco Do
    Begin
      cdsCnfOco.Append;
      cdsCnfOcoCNF_CODOCO.AsString := objCnfOco.strCodOco;
      cdsCnfOcoCNF_DESOCO.AsString := objCnfOco.strDesOco;
      cdsCnfOcoCNF_MOTOCO.AsString := objCnfOco.strMotOco;
      cdsCnfOcoCNF_GERPAG.Value    := objCnfOco.blnGerpag;
      cdsCnfOcoCNF_CUSCAR.Value    := objCnfOco.blnCusCar;
      cdsCnfOcoCNF_USADIA.Value    := objCnfOco.blnUsaDia;
      cdsCnfOcoCNF_FORNEC.AsString := objCnfOco.strCodFor + ' - ' + fRetNomFornecedor(objCnfOco.strCodFor);
      cdsCnfOcoCNF_PORTAD.AsString := objCnfOco.strCodPor + ' - ' + fRetNomPortador(objCnfOco.strCodPor);
      cdsCnfOcoCNF_PLNCON.AsString := objCnfOco.strCodCta + ' - ' + fRetDescCentroCusto(objCnfOco.strCodCta);
      cdsCnfOcoCNF_TIPDES.AsInteger:= objCnfOco.IntTipDes;
      Case objCnfOco.IntTipDes of
        0: cdsCnfOcoCNF_DSTPDS.AsString := '';
        1: cdsCnfOcoCNF_DSTPDS.AsString := 'TARIFA IOF DESCONTO';
        2: cdsCnfOcoCNF_DSTPDS.AsString := 'TARIFA BOLETO DESC';
        3: cdsCnfOcoCNF_DSTPDS.AsString := 'TARIFA DESCONTADA';
      End;
      cdsCnfOco.Post;
    End;
  End;

  lstCnfOco.Free;
  objCnfDao.Free;

  cdsCnfOco.First;
  cdsCnfOco.EnableControls;
end;

procedure TfrmConfigSafraAPI.FormShow(Sender: TObject);
begin
  inherited;
  tbsEncBan.TabVisible := fCfgSis('ENCBAN', varBoolean);
  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);

  pCarregaDados;

  pnlAtivo1.Enabled := False;
  pnlAtivo2.Enabled := False;
  pnlAtivo3.Enabled := False;
  pSetFocus(btnEditar);


  if blnNaoEditar then
  begin
    btnConfigurar.Enabled := False;
    btnConfigurar.Visible := False;
    btnGravar.Enabled     := True;
    btnEditar.Visible     := False;
    pSetFocus(btnGravar);
  end;

end;

procedure TfrmConfigSafraAPI.btnEditarClick(Sender: TObject);
begin
  If ((Not fVerificaDireitoAutBan('PERCARBAN')) and (strLoginUsuarioLogado <> '999')) Then
  begin
    fMensagem('ATENÇÃO','Usuário sem permissão!', ['&Ok ']);
    Exit;
  end
  else
  begin
    pnlAtivo1.Enabled := True;
    pnlAtivo2.Enabled := True;

    if tbsEncBan.tabVisible then
      pnlAtivo3.Enabled := True;

    btnGravar.Enabled := True;
    btnConfigurar.Enabled := True;
    btnEditar.Visible := False;
    btnCancelar.Visible := true;

    fraGerarPixBoleto.edtGerarPix.OnChange(fraGerarPixBoleto.edtGerarPix);

    //pSetFocus(cmbCodCar);
    pSetFocus(edtCodAgencia);

  end;
end;


procedure TfrmConfigSafraAPI.btnEdtOcoClick(Sender: TObject);
  Var
    intRecNo_: Integer;
begin
  inherited;
  intRecNo_ := 0;
  If Not cdsCnfOco.isEmpty Then
  Begin
    intRecNo_ := cdsCnfOco.RecNo;
    frmCadOcoCartei                     := TfrmCadOcoCartei.Create(nil);
    frmCadOcoCartei.strCartei           := FCarteira + '-' + VS_strCodEmp;
    frmCadOcoCartei.blnEditar           := True;
    frmCadOcoCartei.edtCodOco.Text      := cdsCnfOcoCNF_CODOCO.AsString;
    frmCadOcoCartei.edtMotOco.Text      := cdsCnfOcoCNF_MOTOCO.AsString;
    frmCadOcoCartei.fraPlanoDeContasOco.MskCodCta.Text := Copy(cdsCnfOcoCNF_PLNCON.AsString,1,7);
    frmCadOcoCartei.cmbTipDes.ItemIndex := cdsCnfOcoCNF_TIPDES.AsInteger;
    frmCadOcoCartei.cmbTipDes.Visible   := True;
    frmCadOcoCartei.lblTipDes.Visible   := True;
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

procedure TfrmConfigSafraAPI.btnGravarClick(Sender: TObject);
Var
  stlCfgAnt : TStringList;
begin
  inherited;
  If fVerificaCampos Then
  Begin

    Try
      stlCfgAnt := TStringList.Create;
      pCarregaCfg(stlCfgAnt);

      fGetBancoConfig(1, FCarteira, 'CODCART', edtCodCar.Text);
      fGetBancoConfig(1, FCarteira, 'CODAGEN', edtCodAgencia.Text);  //Codigo Agencia
      fGetBancoConfig(1, FCarteira, 'DIGAGEN', edtdigAgencia.Text);  //Digito da agencia
      fGetBancoConfig(1, FCarteira, 'NUMCTAC', edtContaCorr.Text);   //Num. Conta Corrente
      fGetBancoConfig(1, FCarteira, 'TIPO_DESC', IntToStr(cmbTipoDesconto.ItemIndex));
      fGetBancoConfig(1, FCarteira, 'PASSWORD', edtPassword.Text);
      fGetBancoConfig(1, FCarteira, 'RESPONS', 'E');
      fGetBancoConfig(1, FCarteira, 'DIAPROT', edtDiasProt.Text);
      fGetBancoConfig(1, FCarteira, 'QTDIASDEV', edtQtdeDiasDevolucao.Text);
      fGetBancoConfig(1, FCarteira, 'OBSERV1', edtObservacao1.Text);
      fGetBancoConfig(1, FCarteira, 'OBSERV2', edtObservacao2.Text);
      fGetBancoConfig(1, FCarteira, 'OBSERV3', edtObservacao3.Text);
      fGetBancoConfig(1, FCarteira, 'OBSERV4', edtObservacao4.Text);
      fGetBancoConfig(1, FCarteira, 'PATHRET', fraPathRetorno.edtDirectory.text);
      fGetBancoConfig(1, FCarteira, 'PORBAI_', edtCodPor.Text);
      fGetBancoConfig(1, FCarteira, 'PORBAI_VIN', edtCodPorVin.Text);
      fGetBancoConfig(1, FCarteira, 'CTABAI_', fraPlanoDeContasBai.mskCodCta.Text);
      fGetBancoConfig(1, FCarteira, 'CTABAI_VIN', fraPlanoDeContasVin.mskCodCta.Text);
      fGetBancoConfig(1, FCarteira, 'PERMULT', edtPerMul.Text);
      fGetBancoConfig(1, FCarteira, 'DIACRED', edtDiasCred.Text);
      fGetBancoConfig(1, FCarteira, 'PROACEI', edtProAce.Text       );
      fGetBancoConfig(1, FCarteira, 'TPAMBIENTE', Inttostr(cmbAmbiente.ItemIndex));

      If Not MatchStr(edtClientID.Text, ['', 'Client ID Cadastrado']) Then
         fGetBancoConfig(1, FCarteira, 'CLIENT_ID', edtClientID.Text);

      fGetBancoConfig(1, FCarteira, 'USERNAME', edtUsername.Text);
      fGetBancoConfig(1, FCarteira, 'PASSWORD', edtPassword.Text);

      fGetBancoConfig(1, FCarteira, 'PORTTAR', edtPorTar.Text    );
      fGetBancoConfig(1, FCarteira, 'CONTTAR', fraPlanoDeContasEnc.MskCodCta.Text);
      fGetBancoConfig(1, FCarteira, 'FORNTAR', edtForTar.Text    );
      fGetBancoConfig(1, FCarteira, 'VALOTAR', edtValorTarifa.Text  );
      fGetBancoConfig(1, FCarteira, 'LANTX02', IIF(cmbLancarTarifa.ItemIndex = 1, '02', '06'));

      fGetBancoConfig(1, FCarteira, 'PERIMPBOL', edtPerImpBol.Text);

      // dados beneficiario
      fGetBancoConfig(1, FCarteira, 'SACAVAL', edtUsaSac.Text        );
      fGetBancoConfig(1, FCarteira, 'NOMEBEN', edtDesBen.Text        );
      fGetBancoConfig(1, FCarteira, 'ENDEBEN', edtEndBen.Text        );
      fGetBancoConfig(1, FCarteira, 'BAIRBEN', edtBaiBen.Text        );
      fGetBancoConfig(1, FCarteira, 'COMPBEN', edtCompBen.Text       );
      fGetBancoConfig(1, FCarteira, 'CIDABEN', edtCidBen.Text        );
      fGetBancoConfig(1, FCarteira, 'ESTABEN', edtEstBen.Text        );
      fGetBancoConfig(1, FCarteira, 'CEP_BEN', edtCepBen.Text        );
      fGetBancoConfig(1, FCarteira, 'CNPJBEN', edtCgCBen.Text        );

      fGetBancoConfig(1, FCarteira, 'GERAPIX', fraGerarPixBoleto.edtGerarPix.Text);
      fGetBancoConfig(1, FCarteira, 'CHAPIX', IIF(fraGerarPixBoleto.edtGerarPix.Text = 'N', '', fraGerarPixBoleto.cmbChavePix.EditValue));
      fGetBancoConfig(1, FCarteira, 'DIALIMR', edtDiasLimiteRec.Text     );

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        pSetFocus(edtCodAgencia);
        cxPaginas.ActivePage :=  tbsGeral;
        pnlAtivo1.Enabled := False;
        pnlAtivo2.Enabled := False;

        if tbsEncBan.tabVisible then
          pnlAtivo3.Enabled := False;

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
      pCarregaDados;

    Except
      On E:Exception Do
      Begin
        fMensagem('Erro','Ocorreu um erro ao tentar salvar os dados.' + #13 + E.Message,['&O K']);
      End;
    End;

    FreeAndNil(stlCfgAnt);
  End;
end;


procedure TfrmConfigSafraAPI.btnRemOcoClick(Sender: TObject);
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
      pDesmembraCarteira(FCarteira + '-' + VS_strCodEmp,
                         strCodBco, strTipLay, strNumPos, strEspeci, strCodEmp, intCartei);

      objCnfDao := TCnfOcoDao.Create(strCodBco, strTipLay, strNumPos,
                                     strEspeci, strCodEmp, intCartei);

      objCnfOco := objCnfDao.fBuscaPorOcorrencia(cdsCnfOcoCNF_CODOCO.AsString,
                                                 cdsCnfOcoCNF_MOTOCO.AsString,
                                                 Copy(cdsCnfOcoCNF_PLNCON.AsString,1,7),
                                                 cdsCnfOcoCNF_TIPDES.AsInteger);
      If Assigned(objCnfOco) Then
      Begin
        If objCnfDao.fRemoverOcorrencia(objCnfOco.strCodOco,
                                        objCnfOco.strMotOco,
                                        objCnfOco.strCodCta,
                                        objCnfOco.intTipDes) Then
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

procedure TfrmConfigSafraAPI.CarregaFornecedor;
begin
  edtDesForTar.Clear;
  If Not fEmptyStr( edtForTar.Text ) Then
  begin
    pPesquisaCadFor(qryCadFor, qryCadFor, edtForTar.Text);
    edtDesForTar.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
  end;
end;

procedure TfrmConfigSafraAPI.CarregaLancamentoTarifaBancaria;
begin
  Case StrToIntDef(fGetBancoConfig(0, FCarteira, 'LANTX02', '06'),-1) Of
    06 : cmbLancarTarifa.ItemIndex := 0;
    02 : cmbLancarTarifa.ItemIndex := 1;
  End;
end;

procedure TfrmConfigSafraAPI.cmbContaCaucaoExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSafraAPI.cmbContaCaucaoMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSafraAPI.cmbTpCobrancaPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  //fraGerarPixBoleto.edtGerarPix.Text := IIF(cmbTpCobranca.ItemIndex <= 0, 'N', 'S');
end;

function TfrmConfigSafraAPI.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  strMensagemConfig: String;
begin

  if blnNaoEditar then
     strMensagemConfig := #13 + 'Por favor acesse a tela de configuração do banco selecionado ' + #13  + ' e corrija as informações necessárias!'
  else
     strMensagemConfig := '';

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodPor) And gpbSimples.Enabled Then
      Result := PortadorValido(edtCodPor,edtDesPor)

    Else If (Sender = edtCodPorVin) And gpbVinculada.Enabled Then
      Result := PortadorValido(edtCodPorVin,edtDesPorVin)

    Else If (Sender = fraPlanoDeContasBai.MskCodCta) Then
      Result := PlanoDeContaValido(fraPlanoDeContasBai.MskCodCta,fraPlanoDeContasBai.edtDesCta)

    Else If (Sender = fraPlanoDeContasVin.MskCodCta) Then
      Result := PlanoDeContaValido(fraPlanoDeContasVin.MskCodCta,fraPlanoDeContasVin.edtDesCta)

    Else If (Sender = edtCodAgencia) Then
    Begin
      If fEmptyStr(edtCodAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Código da Agência deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End
      Else
      Begin
        If Length(edtCodAgencia.Text) <> 4 Then
        Begin
          fMensagem('ATENÇÃO','O campo agência deve ter 4 caracteres. Caso tenha 0 (zero) favor informar!' + strMensagemConfig,['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtContaCorr) Then
    Begin
      If fEmptyStr(edtContaCorr.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Conta Corrente deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      else
      begin
        if Length(edtContaCorr.Text) <> 9 then
        begin
          fMensagem('ATENÇÃO','O campo Conta Corrente deve ter 9 caracteres. Caso tenha 0 (zero) favor informar!' + strMensagemConfig,['&OK']);
          Result := False;
        end;
      end;
    End

    Else If (Sender = edtDigAgencia) Then
    Begin
      If fEmptyStr(edtDigAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Digito da agência deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtPerMul) Then
    Begin
      If Not fValidaEscala(edtPerMul.Text, 0, 100) Then
      begin
        fMensagem('ATENÇÃO','O campo percentual de multa deve estar entre 0 e 100!'+strMensagemConfig,['&OK']);
        Result := False;
      end;
    End

    Else If (Sender = edtClientId) Then
    Begin
      If fEmptyStr(edtClientId.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Client ID deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End
    End

    Else If (Sender = edtUserName) Then
    Begin
      If fEmptyStr(edtUsername.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo password deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtPassword) Then
    Begin
      If fEmptyStr(edtPassword.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo password deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtProAce Then
    Begin
      If Pos(edtProAce.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Imprime Protocolo de Aceite deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (tbsEncBan.TabVisible = True) and (Sender = edtPorTar) Then
    Begin
      If fEmptyStr(TEditFocus(Sender).Text) Then
      begin
        If (Sender = edtPorTar) Then edtDesPorTar.Clear;
        if (not fEmptyStr(edtValorTarifa.Text)) and (fStrToFloat(edtValorTarifa.Text)>0) then
        Begin
          fMensagem('', 'O portador para baixa da tarifa deve ser preenchido!'+strMensagemConfig, ['&Ok']);

          cxPaginas.ActivePage := tbsEncBan;
          Result := False;
        End
      end
      Else
      Begin
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
            If Not fEmptyStr(edtPorTar.Text) Then
            Begin
              fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig, ['&Ok']);
              Result := False;
            End
          End;

        End;
      End;
    End

    Else If (tbsEncBan.TabVisible = True) and  (Sender = edtForTar)  Then
    Begin
      If fEmptyStr(edtForTar.Text) Then
      begin
        edtDesForTar.Clear;
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

    Else If (tbsEncBan.TabVisible = True) and  (Sender = fraPlanoDeContasEnc.MskCodCta)  Then
    Begin
      If fEmptyStr(fraPlanoDeContasEnc.MskCodCta.Text) Then
      begin
        fraPlanoDeContasEnc.edtDesCta.Clear;
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
        Begin
          Result := PlanoDeContasAtivo(fraPlanoDeContasEnc.MskCodCta.Text,True);
          fraPlanoDeContasEnc.edtDesCta.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
        End;

      End;
    End

    Else If Sender = fraGerarPixBoleto.edtGerarPix Then
    Begin
      If Not MatchStr(fraGerarPixBoleto.edtGerarPix.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO','O campo Gerar boletos Pix QRCode deve ser preenchido com S ou N!' +strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If Sender = fraGerarPixBoleto.cmbChavePix Then
    Begin
      If fraGerarPixBoleto.edtGerarPix.Text = 'S' Then
      Begin
        If VarToString(fraGerarPixBoleto.cmbChavePix.EditValue).IsEmpty Then
        Begin
          fMensagem('ATENÇÃO','O campo Chave Pix da Conta deve ser preenchido!' + strMensagemConfig, ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If Sender = edtDiasLimiteRec Then
    Begin

      If (edtDiasLimiteRec.Text = '') Then
      Begin
        fMensagem('','O campo quantidade de dias limite para recebimento deve ser preenchido!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End;

  End;

  If Not Result Then
  begin
    if not blnNaoEditar then
    begin
      cxPaginas.ActivePage := RetornaAbaDoComponete(Sender);
      pSetFocus(Sender);
    end;
  end;

end;

procedure TfrmConfigSafraAPI.InformaTipoAPP;
  Var
    KeyUser : String;
begin
  If edtClientId.Text = 'Chave App cadastrada' Then
     KeyUser := fGetBancoConfig(0, FCarteira, 'CLIENT_ID', '')
  Else
     KeyUser := edtClientId.Text;
end;

procedure TfrmConfigSafraAPI.lblValidaOcoMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSafraAPI.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregadados;
  cxPaginas.ActivePage := tbsGeral;
end;

procedure TfrmConfigSafraAPI.tabCarteiraChanging(Sender: TObject;
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


procedure TfrmConfigSafraAPI.edtClientIDEnter(Sender: TObject);
begin
  inherited;
  If edtClientID.Text = 'Client Id cadastrado' Then
     edtClientID.Clear;
end;

procedure TfrmConfigSafraAPI.edtClientIDExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtClientID.Text) And (fGetBancoConfig(0, FCarteira, 'CLIENT_ID', '') <> '') Then
     edtClientID.Text := 'Client Id cadastrado';

  InformaTipoAPP;
end;

procedure TfrmConfigSafraAPI.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, nil, Key, arrSel) then
  Begin
    If fValidaCampos(edtCodPor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConfigSafraAPI.edtCodPorVinKeyPress(Sender: TObject;
  var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPorVin, edtDesPorVin, nil, Key, arrSel) then
  Begin
    If fValidaCampos(edtCodPorVin, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;


procedure TfrmConfigSafraAPI.edtContaCorrEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtDiasCred, 'Informar o código do beneficiário.');

  pShowHint(edtContaCorr, 'Conta corrente');
end;

procedure TfrmConfigSafraAPI.edtContaCorrExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSafraAPI.edtContaCorrMouseEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtDiasCred, 'Informar o código do beneficiário.');

  pShowHint(edtContaCorr, 'Conta corrente');
end;

procedure TfrmConfigSafraAPI.edtContaCorrMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSafraAPI.edtDiasCredEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtDiasCred, 'Informar quantidade de dias ' + #13+#10 +
                           'do intervalo entre a efetuação ' + #13+#10 +
                           'do pagamento e o crédito na ' + #13+#10 +
                           'conta corrente.');

  pShowHint(edtDiasCred, 'Dias para Crédito');
end;

procedure TfrmConfigSafraAPI.edtDiasCredExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;


procedure TfrmConfigSafraAPI.edtDiasProtEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtDiasProt, 'Quantidade de dias após a data de vencimento ' + #13+#10 +
                           'do boleto para iniciar o processo de cobrança ' + #13+#10 +
                           'através de protesto.' + #13+#10 +
                           '(3 a 5 dias ÚTEIS ou 6 a 29, 35, 40 ou 45 dias CORRIDOS)');


  pShowHint(edtDiasProt, 'Dias para Protesto');
end;

procedure TfrmConfigSafraAPI.edtDiasProtExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSafraAPI.edtForTarKeyPress(Sender: TObject;
  var Key: Char);
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

procedure TfrmConfigSafraAPI.edtPerMulExit(Sender: TObject);
begin
  inherited;
   If Not fEmptyStr(edtPerMul.Text) Then
    edtPerMul.Text := FormatFloat('#,##0.00', StrToFloat(edtPerMul.Text));
end;

procedure TfrmConfigSafraAPI.edtPorTarKeyPress(Sender: TObject;
  var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtPorTar, edtDesPorTar, nil, Key, arrSel) then
  Begin
    If fValidaCampos(edtPorTar, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConfigSafraAPI.edtQtdDiasDataLimiteRecEnter(Sender: TObject);
begin
  inherited;
{  pAlteraHint(edtQtdDiasDataLimiteRec, 'Informar quantidade de dias ' + #13+#10 +
                                       'para Data Limnite de recebimento, ' + #13+#10 +
                                       'usando como base a data de ' + #13+#10 +
                                       'vencimento do título.');

  pShowHint(edtQtdDiasDataLimiteRec, 'Dias para Data Limite de Recibimento');}
end;

procedure TfrmConfigSafraAPI.edtQtdDiasDataLimiteRecExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSafraAPI.edtQtdDiasNegaEnter(Sender: TObject);
begin
  inherited;
{  pAlteraHint(edtQtdDiasNega, 'Quantidade de dias corridos depois do vencimento ' + #13+#10 +
                              'do boleto para a negativação automática, através do ' + #13+#10 +
                              'órgão negativador selecionado. ');

  pShowHint(edtQtdDiasNega, 'Dias para Negativação');}
end;

procedure TfrmConfigSafraAPI.edtQtdDiasNegaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSafraAPI.edtValorTarifaExit(Sender: TObject);
begin
  inherited;
  try
    if not fEmptyStr(edtValorTarifa.Text) then
       edtValorTarifa.Text := FormatFloat('###,##0.00', fStrToFloat(edtValorTarifa.Text));
  except
   //
  end
end;

procedure TfrmConfigSafraAPI.pAlteraHint(edtEdit: TEditFocus;
  strNovoHint: String);
begin
  edtEdit.Hint := strNovoHint;
end;

procedure TfrmConfigSafraAPI.pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
begin
  If Not fEmptyStr(strCtaBai) Then
  Begin
    pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
    edtLabel.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
  End
  Else
    edtLabel.Clear;
end;

procedure TfrmConfigSafraAPI.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  edtLabel.Clear;
  If Not fEmptyStr(strCodPor) Then
  Begin
    pPesquisaCadPor(Nil, qryCadPor, strCodPor);
    edtLabel.Text := qryCadPor.FieldByName('POR_NOMPOR').AsString;
  End
end;

procedure TfrmConfigSafraAPI.pHideHint;
begin
  HintControler.HideHint;
end;

function TfrmConfigSafraAPI.PlanoDeContaValido(ACodigo: TMaskEdit;
  ADescricao: TEdit): Boolean;
  var
    strMensagemConfig: String;
begin
  if blnNaoEditar then
     strMensagemConfig := #13 + 'Por favor acesse a tela de configuração do banco selecionado ' + #13  + ' e corrija as informações necessárias!';

  Result := True;
  If fEmptyStr(ACodigo.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!'+strMensagemConfig, ['&Ok']);
    ADescricao.Clear;
    Result := False;
  End
  Else
  Begin
    pCarregaCentroCusto(ACodigo.Text, ADescricao);
    If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!'+strMensagemConfig, ['&Ok']);
      Result := False;
    End;
  End;
end;

procedure TfrmConfigSafraAPI.pLimpaCampos;
var
  i: Integer;
begin
  for i := Self.ComponentCount -1 downto 0 do
  begin
    if (Self.Components[i] is TEditFocus) then
      (Self.Components[i] as TEditFocus).text := '';

    if (Self.Components[i] is TMaskEditFocus) then
      (Self.Components[i] as TMaskEditFocus).text := '  /  /    ';

    if (Self.Components[i] is TCheckBox) then
      (Self.Components[i] as TCheckBox).Checked := False;

    if (Self.Components[i] is TComboBoxFocus) then
      (Self.Components[i] as TComboBoxFocus).ItemIndex := -1;
  end;

end;


function TfrmConfigSafraAPI.PortadorValido(ACodigo: TEdit; ADescricao: TEdit): Boolean;
  var
    strMensagemConfig: String;
begin
  Result := True;

  if blnNaoEditar then
     strMensagemConfig := #13 + 'Por favor acesse a tela de configuração do banco selecionado ' + #13  + ' e corrija as informações necessárias!';

  If fEmptyStr(ACodigo.Text) Then
  Begin
    fMensagem('ATENCÃO', 'O código do portador deve ser informado!'+strMensagemConfig, ['&Ok']);
    Result := False;
  End
  Else
  Begin
    pCarregaPortador(ACodigo.Text, ADescricao);

    If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
    Begin
      fMensagem('', 'Esse portador não está cadastrado!'+strMensagemConfig, ['&Ok']);
      Result := False;
    End
    {*REQ*145940**********RP*}
    Else If Not fEmpresaTemAcessoPortador(ACodigo.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
      Result := False;
    End
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      If (Pos(ACodigo.Text, strPortadoresOperador) <= 0) Then
      Begin
        If Not fEmptyStr(ACodigo.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End
      End;

    End
    Else If (Not fPortadorPermiteBaixa(ACodigo.Text)) Then
    Begin
      fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
      Result := False;
    End;
  End;
end;

procedure TfrmConfigSafraAPI.pShowHint(edtEdit: TEditFocus; strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;

function TfrmConfigSafraAPI.RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
begin
  While Not Sender.ClassName.Equals('TcxTabSheet') Do
  Begin
    Sender := Sender.Parent;
  End;
  Result := TcxTabSheet(Sender);
end;

procedure TfrmConfigSafraAPI.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  qryCadEmp := fCriaQuery(Self);
  qryCadFor := fCriaQuery(Self);

  fraGerarPixBoleto.CarregarChavesPix('422');

  pCarKeyAutBan;
  cxPaginas.Properties.ActivePage := tbsGeral;
  pnlChaveConexao.Enabled := fVerificaAcessoSistema('ALTCHAVEAUTAPIBB');
end;

procedure TfrmConfigSafraAPI.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigSafraAPI.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSafraAPI.btnValidaAcessoClick(Sender: TObject);
 Var
     LCarteira   : String;
     strClientID,
     strMsgValidacao : String;
begin
  inherited;

  If Not fValidaCampos(edtContaCorr, True) Then
     exit;

  If Not fValidaCampos(edtcodAgencia, True) Then
     exit;

  If Not fValidaCampos(edtClientID, True) Then
     exit;

  If Not fValidaCampos(edtUsername, True) Then
     exit;

  If Not fValidaCampos(edtPassword, True) Then
     exit;

  Try
    LCarteira := FCarteira + '-' + VS_strCodEmp;

    LBancoSafraApi  := TBancoSafraAPI.Create(LCarteira);

    strClientID := fGetBancoConfig(0, FCarteira, 'CLIENT_ID', '');

    strMsgValidacao := LBancoSafraApi.Valida_Configuracao_Token( IIF( (edtClientID.Text = 'Client ID Cadastrado'), strClientID, edtClientId.Text),
                                                                   edtUserName.Text,
                                                                   edtPassword.Text,
                                                                   cmbAmbiente.ItemIndex,
                                                                   LCarteira);
    fMensagem('',strMsgValidacao,['&O K'])

  Finally
    If Assigned(LBancoSafraAPI) Then
       FreeAndNil(LBancoSafraAPI);
  End;

end;

procedure TfrmConfigSafraAPI.btnAddOcoClick(Sender: TObject);
begin
  inherited;
  frmCadOcoCartei := TfrmCadOcoCartei.Create(nil);
  frmCadOcoCartei.strCartei :=  FCarteira + '-' + VS_strCodEmp;
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

procedure TfrmConfigSafraAPI.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&S i m', '&N ã o'], 2) = 1 then
  begin
    cxPaginas.ActivePage :=  tbsGeral;
    btnCancelar.Visible := False;
    if tbsEncBan.tabVisible then
      pnlAtivo3.Enabled:= False;
    btnEditar.Visible   := True;
    pnlAtivo1.Enabled := False;
    pnlAtivo2.Enabled := False;
    btnEditar.Visible   := True;
    btnGravar.Enabled   := False;
    btnConfigurar.Enabled := False;
    pCarregaDados;
    pSetFocus(btnEditar);
  end;
end;

procedure TfrmConfigSafraAPI.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pHideHint;

    pCriarFormularios(TfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '422';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigSafraAPI.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;

  stlCampos.Add('Código Carteira           :' + fGetBancoConfig(0, FCarteira, 'CODCART', ''));
  stlCampos.Add('Código Agência            :' + fGetBancoConfig(0, FCarteira, 'CODAGEN', ''));
  stlCampos.Add('Digito Agência            :' + fGetBancoConfig(0, FCarteira, 'DIGAGEN', ''));
  stlCampos.Add('Conta Corrente            :' + fGetBancoConfig(0, FCarteira, 'NUMCTAC', ''));
  stlCampos.Add('Tipo Desconto             :' + fGetBancoConfig(0, FCarteira, 'TIPO_DESC', ''));
  stlCampos.Add('Observação 1              :' + fGetBancoConfig(0, FCarteira, 'OBSERV1', ''));
  stlCampos.Add('Observação 2              :' + fGetBancoConfig(0, FCarteira, 'OBSERV2', ''));
  stlCampos.Add('Observação 3              :' + fGetBancoConfig(0, FCarteira, 'OBSERV3', ''));
  stlCampos.Add('Observação 4              :' + fGetBancoConfig(0, FCarteira, 'OBSERV4', ''));
  stlCampos.Add('Observação 5              :' + fGetBancoConfig(0, FCarteira, 'OBSERV5', ''));
  stlCampos.Add('Path de Arquivo Retorno   :' + fGetBancoConfig(0, FCarteira, 'PATHRET', ''));
  stlCampos.Add('Dias p/ protesto          :' + fGetBancoConfig(0, FCarteira, 'DIAPROT', ''));
  stlCampos.Add('Dias para Devolução       :' + fGetBancoConfig(0, FCarteira, 'DIANEGA', ''));
  stlCampos.Add('Dias p/ crédito           :' + fGetBancoConfig(0, FCarteira, 'DIACRED', ''));
  stlCampos.Add('Percentual Multa          :' + fGetBancoConfig(0, FCarteira, 'PERMULT', ''));
  stlCampos.Add('Protocolo Aceite          :' + fGetBancoConfig(0, FCarteira, 'PROACEI', ''));
  stlCampos.Add('Tipo Desconto             :' + fGetBancoConfig(0, FCarteira, 'TIPO_DESC', ''));
  stlCampos.Add('Responsavel Emissão       :' + fGetBancoConfig(0, FCarteira, 'RESPONS', ''));
  stlCampos.Add('Permite impressão de boleto :' + fGetBancoConfig(0, FCarteira, 'PERIMPBOL', ''));
  stlCampos.Add('Tipo de Ambiente          :' + fGetBancoConfig(0, FCarteira, 'TPAMBIENTE', ''));
  stlCampos.Add('Client ID                 :' + fGetBancoConfig(0, FCarteira, 'CLIENT_ID', ''));
  stlCampos.Add('UserName                  :' + fGetBancoConfig(0, FCarteira, 'USERNAME', ''));
  stlCampos.Add('Password                  :' + fGetBancoConfig(0, FCarteira, 'PASSWORD', ''));
  stlCampos.Add('Portador Cob. Simples     :' + fGetBancoConfig(0, FCarteira, 'PORBAI_', ''));
  stlCampos.Add('Pla. Contas Cob. Simples  :' + fGetBancoConfig(0, FCarteira, 'CTABAI_', ''));
  stlCampos.Add('Portador Cob. Vinculada   :' + fGetBancoConfig(0, FCarteira, 'PORBAI_VIN', ''));
  stlCampos.Add('Pla. Contas Cob. Vinculada:' + fGetBancoConfig(0, FCarteira, 'CTABAI_VIN', ''));

  stlCampos.Add('Enc.Ban. Vr Tarifa:' + fGetBancoConfig(0, FCarteira, 'VALOTAR', ''));
  stlCampos.Add('Enc.Ban. Portador :' + fGetBancoConfig(0, FCarteira, 'PORTTAR', ''));
  stlCampos.Add('Enc.Ban. Pl Conta :' + fGetBancoConfig(0, FCarteira, 'CONTTAR', ''));
  stlCampos.Add('Enc.Ban. Fornec.  :' + fGetBancoConfig(0, FCarteira, 'FORNTAR', ''));
  stlCampos.Add('Lançar Tarifa Ban.:' + fGetBancoConfig(0, FCarteira, 'LANTX02', ''));

end;

procedure TfrmConfigSafraAPI.fraGerarPixBoletocmbChavePixPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  If Not btnGravar.Enabled Then
    Exit;

  If blnNaoEditar Then
    Exit;

  if edtCodpor.Text <> fraGerarPixBoleto.cmbChavePix.Properties.DataController.DataSet.FieldByName('POR_CODPOR').AsString then
  Begin
    If fMensagem('ATENÇÃO', 'Deseja carregar o Portador da chave Pix selecionada como portador da baixa?', ['&Sim', '&Não']) = 2 Then
      Exit;
  End;

  edtCodPor.Text := fraGerarPixBoleto.cmbChavePix.Properties.DataController.DataSet.FieldByName('POR_CODPOR').AsString;
  CarregaPortador(edtCodPor.Text);
end;

procedure TfrmConfigSafraAPI.fraGerarPixBoletoedtGerarPixChange(
  Sender: TObject);
begin
  inherited;
  fraGerarPixBoleto.edtGerarPixChange(Sender);

end;

procedure TfrmConfigSafraAPI.fraPlanoDeContasEncMskCodCtaKeyPress(
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

function TfrmConfigSafraAPI.fRetStrCfg(stlCfg : TStringList) : String;
Var
  intCont : Integer;
begin
  Result := '';

  For intCont := 0 To stlCfg.Count - 1 Do
    Result := Result + stlCfg.Strings[intCont] + #13+#10;
end;

procedure TfrmConfigSafraAPI.pGravaLogCarteira(stlCfgAnt : TStringList);
Var
  stlCfgAtu: TStringList;
  strCmpAlt: String;
  intCont,
  intIndice: Integer;
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
    pGravaLogAtb('422', 'BANCO SAFRA [Online]', FCarteira + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

end.
