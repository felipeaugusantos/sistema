unit untConfigBancoDoBrasilAPI;

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
  cxDBLookupComboBox, untFrameGerarPixBoleto;

type
  TfrmConfigBancoDoBrasilAPI = class(TfrmPai)
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
    Label5: TLabel;
    Label6: TLabel;
    lblCodCart: TLabel;
    lblDiasProt: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label25: TLabel;
    edtVarCarteira: TEditFocus;
    edtNumConvenio: TEditFocus;
    edtDiasProt: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    edtDiasCred: TEditFocus;
    edtPerMul: TEditFocus;
    cmbCodCar: TComboBoxFocus;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    edtQtdDiasDataLimiteRec: TEditFocus;
    Label35: TLabel;
    edtQtdDiasNega: TEditFocus;
    lblQtdDiasNega: TLabel;
    cmbOrgNega: TComboBoxFocus;
    lblOrgNega: TLabel;
    pnlChaveConexao: TPanel;
    Label8: TLabel;
    Label3: TLabel;
    mmoChaveBasic: TMemoFocus;
    edtChaveAppDev: TEditFocus;
    Label15: TLabel;
    edtProAce: TEditFocus;
    ColorLabel3: TColorLabel;
    edtDigCtaCor: TEditFocus;
    edtContaCorr: TEditFocus;
    lblContCorr: TLabel;
    edtDigAgencia: TEditFocus;
    edtCodAgencia: TEditFocus;
    lblCodAgenc: TLabel;
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
    cmbTipoCobranca: TcxComboBox;
    lblTipoCobranca: TLabel;
    gbAmbiente: TGroupBox;
    lblTipoAPP: TLabel;
    cmbContaCaucao: TcxComboBox;
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
    fraGerarPixBoleto: TfraGerarPixBoleto;
    Label1: TLabel;
    edtDiasCred12: TEditFocus;
    tsComplementos: TcxTabSheet;
    edtPerImpBol: TEditFocus;
    lblPerImpBol: TLabel;
    clbPerImpBol: TColorLabel;
    pnlComplemento: TPanel;
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
    procedure edtChaveAppDevExit(Sender: TObject);
    procedure edtPerMulExit(Sender: TObject);
    procedure mmoChaveBasicEnter(Sender: TObject);
    procedure edtChaveAppDevEnter(Sender: TObject);
    procedure mmoChaveBasicExit(Sender: TObject);
    procedure edtQtdDiasNegaEnter(Sender: TObject);
    procedure edtQtdDiasNegaExit(Sender: TObject);
    procedure edtDiasProtEnter(Sender: TObject);
    procedure edtDiasProtExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorVinKeyPress(Sender: TObject; var Key: Char);
    procedure cmbContaCaucaoMouseEnter(Sender: TObject);
    procedure cmbContaCaucaoEnter(Sender: TObject);
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
    procedure edtDiasCred12Enter(Sender: TObject);
    procedure edtDiasCred12Exit(Sender: TObject);
    procedure edtDiasCred12MouseEnter(Sender: TObject);
    procedure edtDiasCred12MouseLeave(Sender: TObject);

  private

    qryCadPor : TUniQuery;
    qryCadEmp : TUniQuery;
    qryCadCta : TUniQuery;
    qryCadFor : TUniQuery;

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
    procedure CarregaCodigoDaCarteira;
    procedure CarregaOrgaoNegativador;
    procedure CarregaTipoCobranca;
    procedure CarregaContaCaucao;
    function PortadorValido(ACodigo: TEdit; ADescricao: TEdit):Boolean;
    function PlanoDeContaValido(ACodigo: TMaskEdit; ADescricao: TEdit):Boolean;
    procedure ShowHintComboBox(AComboBox: TcxComboBox; ATitulo: String);
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

implementation

uses  untfuncoesSimples, untPesqAux, untFuncoes,
     untCfgGenericas_AutBan, untConsultas,untTBancoDoBrasilAPI, untCadOcoCartei,
     untCNFOCO_Class, untCNFOCO_Dao;

{$R *.dfm}

{ TfrmPai1 }

procedure TfrmConfigBancoDoBrasilAPI.pCarregadados;
begin
  pLimpaCampos;

  CarregaCodigoDaCarteira;
  CarregaOrgaoNegativador;
  CarregaTipoCobranca;
  CarregaContaCaucao;
  CarregaLancamentoTarifaBancaria;

  edtCodAgencia.Text           := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtDigAgencia.Text           := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', '');
  edtContaCorr.Text            := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', '');
  edtDigCtaCor.Text            := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', '');

  edtVarCarteira.Text          := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'VARCART', '');
  edtNumConvenio.Text          := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', '');
  edtDiasProt.Text             := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');
  edtQtdDiasNega.Text          := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIANEGA', '');
  edtQtdDiasDataLimiteRec.Text := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIALIMI', '');
  edtObservacao1.Text          := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text          := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text          := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text          := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text          := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');
  edtCodPor.Text               := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  edtCodPorVin.Text            := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_VIN', '');

  fraPlanoDeContasBai.MskCodCta.Text := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  fraPlanoDeContasVin.MskCodCta.Text := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_VIN', '');

  edtPerMul.Text               := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', '');
  edtDiasCred.Text             := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '');
  edtDiasCred12.Text           := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED12', '');
  edtProAce.Text               := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', '');

  fraGerarPixBoleto.edtGerarPix.Text := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'GERAPIX', 'N');
  If fEmptyStr(fraGerarPixBoleto.edtGerarPix.Text) Then
    fraGerarPixBoleto.edtGerarPix.Text := 'N';
  fraGerarPixBoleto.cmbChavePix.EditValue :=  fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'CHAPIX', '');
  fraGerarPixBoleto.cmbChavePix.Enabled := False;

  edtChaveAppDev.Clear;
  If (fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'KEY_USER', '') <> '') Then
    edtChaveAppDev.Text     := 'Chave App cadastrada';

  mmoChaveBasic.Clear;
  If (fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'AUTHORIZATION', '') <> '') Then
    mmoChaveBasic.Text     := 'Autorização Basic cadastrada';


  edtPorTar.Text        := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', '');
  fraPlanoDeContasEnc.MskCodCta.Text := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', '');
  edtForTar.Text        := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', '');
  edtValorTarifa.Text   := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', '');
  edtPerImpBol.Text     := fGetBancoConfig(0,'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', '');

  If fEmptyStr(edtPerImpBol.Text) Then
    edtPerImpBol.Text := 'S';


  pCarregaPortador(edtCodPor.Text, edtDesPor);
  pCarregaPortador(edtCodPorVin.Text, edtDesPorVin);
  pCarregaPortador(edtPorTar.Text, edtDesPorTar);

  pCarregaCentroCusto(fraPlanoDeContasBai.MskCodCta.Text, fraPlanoDeContasBai.edtDesCta);
  pCarregaCentroCusto(fraPlanoDeContasVin.MskCodCta.Text, fraPlanoDeContasVin.edtDesCta);
  pCarregaCentroCusto(fraPlanoDeContasEnc.MskCodCta.Text, fraPlanoDeContasEnc.edtDesCta);
  CarregaFornecedor;
  pCarregaOcorrencias;

  InformaTipoAPP;
end;


procedure TfrmConfigBancoDoBrasilAPI.pCarregaOcorrencias;
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

  pDesmembraCarteira('CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp, strCodBco,
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
procedure TfrmConfigBancoDoBrasilAPI.FormShow(Sender: TObject);
begin
  inherited;
  tbsEncBan.TabVisible := fCfgSis('ENCBAN', varBoolean);
  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);

  fraGerarPixBoleto.CarregarChavesPix('001');

  pCarregaDados;

  pnlAtivo1.Enabled := False;
  pnlAtivo2.Enabled := False;
  pnlAtivo3.Enabled := False;
  pnlComplemento.Enabled := False;

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

procedure TfrmConfigBancoDoBrasilAPI.btnEditarClick(Sender: TObject);
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

    pnlComplemento.Enabled := True;
    btnGravar.Enabled := True;
    btnConfigurar.Enabled := True;
    btnEditar.Visible := False;
    btnCancelar.Visible := true;
    pSetFocus(cmbCodCar);

    If Not fCfgSis('USAPIX', VarBoolean) Then
      fraGerarPixBoleto.edtGerarPix.Text := 'N';

    fraGerarPixBoleto.edtGerarPix.OnChange(fraGerarPixBoleto.edtGerarPix);
  end;
end;


procedure TfrmConfigBancoDoBrasilAPI.btnEdtOcoClick(Sender: TObject);
  Var
    intRecNo_: Integer;
begin
  inherited;
  intRecNo_ := 0;
  If Not cdsCnfOco.isEmpty Then
  Begin
    intRecNo_ := cdsCnfOco.RecNo;
    frmCadOcoCartei                     := TfrmCadOcoCartei.Create(nil);
    frmCadOcoCartei.strCartei           := 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp;
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

procedure TfrmConfigBancoDoBrasilAPI.btnGravarClick(Sender: TObject);
Var
  stlCfgAnt : TStringList;
begin
  inherited;
  If fVerificaCampos Then
  Begin

    Try
      stlCfgAnt := TStringList.Create;
      pCarregaCfg(stlCfgAnt);

      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', edtDigAgencia.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', edtDigCtaCor.Text);


      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', 'E');
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', cmbCodCar.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPO_COBRANCA', cmbTipoCobranca.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTA_CAUCAO', cmbContaCaucao.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMORGAO', LeftStr(cmbOrgNega.Text,2));
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'VARCART', edtVarCarteira.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', edtNumConvenio.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIANEGA', edtQtdDiasNega.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_VIN', edtCodPorVin.Text);

      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContasBai.mskCodCta.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_VIN', fraPlanoDeContasVin.mskCodCta.Text);

      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtPerMul.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED12', edtDiasCred12.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIALIMI', edtQtdDiasDataLimiteRec.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text       );

      If Not MatchStr(edtChaveAppDev.Text, ['', 'Chave App cadastrada']) Then
        fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'KEY_USER', edtChaveAppDev.Text);

      If Not MatchStr(mmoChaveBasic.Text, ['', 'Autorização Basic cadastrada']) Then
        fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'AUTHORIZATION', mmoChaveBasic.Text);

      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', edtPorTar.Text    );
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', fraPlanoDeContasEnc.MskCodCta.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', edtForTar.Text    );
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', edtValorTarifa.Text  );
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'LANTX02', IIF(cmbLancarTarifa.ItemIndex = 1, '02', '06'));
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'GERAPIX', fraGerarPixBoleto.edtGerarPix.Text);
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'CHAPIX', IIF(fraGerarPixBoleto.edtGerarPix.Text = 'N', '', fraGerarPixBoleto.cmbChavePix.EditValue));
      fGetBancoConfig(1, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', edtPerImpBol.Text);

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        pSetFocus(cmbCodCar);
        cxPaginas.ActivePage :=  tbsGeral;
        pnlAtivo1.Enabled := False;
        pnlAtivo2.Enabled := False;

        if tbsEncBan.tabVisible then
          pnlAtivo3.Enabled := False;

        pnlComplemento.Enabled := False;
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


procedure TfrmConfigBancoDoBrasilAPI.btnRemOcoClick(Sender: TObject);
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
      pDesmembraCarteira('CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp,
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


procedure TfrmConfigBancoDoBrasilAPI.CarregaCodigoDaCarteira;
begin
  Try
    Case StrToInt(fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', '')) Of
      11: cmbCodCar.ItemIndex := 0;
      12: cmbCodCar.ItemIndex := 1;
      16: cmbCodCar.ItemIndex := 2;
      17: cmbCodCar.ItemIndex := 3;
      18: cmbCodCar.ItemIndex := 4;
      31: cmbCodCar.ItemIndex := 5;
      51: cmbCodCar.ItemIndex := 6;
    End;
  Except
    cmbCodCar.ItemIndex := -1;
  End;
end;

procedure TfrmConfigBancoDoBrasilAPI.CarregaContaCaucao;
  Var
    LOpcao : Integer;
begin
  Try
    LOpcao := StrToInt(LeftSTr(fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTA_CAUCAO', ''),1));

    Case LOpcao Of
      1: cmbContaCaucao.ItemIndex := 0;
      2: cmbContaCaucao.ItemIndex := 1;
      4: cmbContaCaucao.ItemIndex := 2;
      5: cmbContaCaucao.ItemIndex := 3;
      6: cmbContaCaucao.ItemIndex := 4;
      7: cmbContaCaucao.ItemIndex := 5;
      8: cmbContaCaucao.ItemIndex := 6;
    End;

  Except
    cmbContaCaucao.ItemIndex := -1;
  End;
end;

procedure TfrmConfigBancoDoBrasilAPI.CarregaFornecedor;
begin
  edtDesForTar.Clear;
  If Not fEmptyStr( edtForTar.Text ) Then
  begin
    pPesquisaCadFor(qryCadFor, qryCadFor, edtForTar.Text);
    edtDesForTar.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
  end;
end;

procedure TfrmConfigBancoDoBrasilAPI.CarregaLancamentoTarifaBancaria;
begin
  Case StrToIntDef(fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'LANTX02', '06'),-1) Of
    06 : cmbLancarTarifa.ItemIndex := 0;
    02 : cmbLancarTarifa.ItemIndex := 1;
  End;
end;

procedure TfrmConfigBancoDoBrasilAPI.CarregaOrgaoNegativador;
begin
  Try
    Case StrToInt(fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMORGAO', '')) Of
      10: cmbOrgNega.ItemIndex := 0;
      11: cmbOrgNega.ItemIndex := 1;
    End;
  Except
    cmbOrgNega.ItemIndex := -1;
  End;
end;

procedure TfrmConfigBancoDoBrasilAPI.CarregaTipoCobranca;
begin
  Try
    Case StrToInt(LeftStr(fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPO_COBRANCA', ''),1)) Of
      1: cmbTipoCobranca.ItemIndex := 0;
      4: cmbTipoCobranca.ItemIndex := 1;
    End;
  Except
    cmbTipoCobranca.ItemIndex := 0;
  End;
end;

procedure TfrmConfigBancoDoBrasilAPI.cmbContaCaucaoEnter(Sender: TObject);
begin
  inherited;
  ShowHintComboBox(cmbContaCaucao,'');
end;

procedure TfrmConfigBancoDoBrasilAPI.cmbContaCaucaoExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoDoBrasilAPI.cmbContaCaucaoMouseEnter(Sender: TObject);
begin
  inherited;
  ShowHintComboBox(cmbContaCaucao,'');
end;

procedure TfrmConfigBancoDoBrasilAPI.cmbContaCaucaoMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

function TfrmConfigBancoDoBrasilAPI.fValidaCampos(Sender: TWinControl;
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

    Else If (Sender = cmbContaCaucao) Then
    Begin
      If (cmbTipoCobranca.ItemIndex = 1) Then
      Begin

        If fEmptyStr(cmbContaCaucao.Text) Then
        Begin
          fMensagem('ATENÇÃO!','O campo Conta Caução deve ser informado!'+strMensagemConfig,['&OK']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = cmbCodCar) Then
    Begin
      If cmbCodCar.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Código da Carteira deve ser informado!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = cmbOrgNega) Then
    Begin
      If (cmbOrgNega.ItemIndex = -1) And Not fEmptyStr(edtQtdDiasNega.Text)  Then
      Begin
        If (StrToInt(edtQtdDiasNega.Text) > 0) Then
        Begin
          fMensagem('ATENÇÃO!','O campo Orgão Negativador deve ser informado!'+strMensagemConfig,['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtVarCarteira) Then
    Begin
      If fEmptyStr(edtVarCarteira.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Variação da Carteira deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtNumConvenio) Then
    Begin
      If fEmptyStr(edtNumConvenio.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Número do Convênio deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End
      Else If Length(edtNumConvenio.Text) <> edtNumConvenio.MaxLength Then
      Begin
        fMensagem('ATENÇÃO!','O campo Número do Convênio deve ter 7 caracteres!'+strMensagemConfig, ['&OK']);
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

    Else If (Sender = edtChaveAppDev) And (pnlChaveConexao.Visible) Then
    Begin
      If fEmptyStr(edtChaveAppDev.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Chave APP deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End
    End

    Else If (Sender = edtContaCorr) Then
    Begin
      If fEmptyStr(edtContaCorr.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Número da Conta Corrente deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End
      Else If edtContaCorr.Text <> fRetSomenteNumeros(edtContaCorr.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Número da Conta Corrente deve possuir apenas números!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If Sender = edtDigCtaCor Then
    Begin
      If fEmptyStr(edtDigCtaCor.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O Campo Dígito da Conta Corrente deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodAgencia) Then
    Begin
      If fEmptyStr(edtCodAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Código da Agencia deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End
    End

    Else If Sender = edtDigAgencia Then
    Begin
      If fEmptyStr(edtDigAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O Campo Dígito da Agência deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = mmoChaveBasic) And (pnlChaveConexao.Visible) Then
    Begin
      If fEmptyStr(mmoChaveBasic.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Autorização Basic deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End
    End

    Else If Sender = edtProAce Then
    Begin
      If Pos(edtProAce.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Imprime Protocolo de Aceite deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = fraGerarPixBoleto.edtGerarPix Then
    Begin
      If Not MatchStr(fraGerarPixBoleto.edtGerarPix.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO','O campo Gerar boletos Pix QRCode deve ser preenchido com S ou N!' + strMensagemConfig, ['&OK']);
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

    Else If Sender = edtPerImpBol Then
    Begin
      If Not MatchStr(edtPerImpBol.Text, ['S', 'N']) Then
      Begin
        fMensagem('','O campo Permitir impressão de boletos deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
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

procedure TfrmConfigBancoDoBrasilAPI.InformaTipoAPP;
  Var
    KeyUser : String;
begin
  If edtChaveAppDev.Text = 'Chave App cadastrada' Then
    KeyUser := fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'KEY_USER', '')
  Else
   KeyUser := edtChaveAppDev.Text;

  If Not fEmptyStr(KeyUser) Then
    lblTipoAPP.Caption := 'Produção';

  If (LeftStr(KeyUser,2) = 'd2') Then
    lblTipoAPP.Caption := 'Homologação';
end;

procedure TfrmConfigBancoDoBrasilAPI.lblValidaOcoMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoDoBrasilAPI.mmoChaveBasicEnter(Sender: TObject);
begin
  inherited;
  If mmoChaveBasic.Text = 'Autorização Basic cadastrada' Then
    mmoChaveBasic.Clear;
end;

procedure TfrmConfigBancoDoBrasilAPI.mmoChaveBasicExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(mmoChaveBasic.Text) Then
    Exit;

  If (fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'AUTHORIZATION', '') <> '') Then
    mmoChaveBasic.Text     := 'Autorização Basic cadastrada';
end;

procedure TfrmConfigBancoDoBrasilAPI.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregadados;
  cxPaginas.ActivePage := tbsGeral;
end;

procedure TfrmConfigBancoDoBrasilAPI.tabCarteiraChanging(Sender: TObject;
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


procedure TfrmConfigBancoDoBrasilAPI.edtChaveAppDevEnter(Sender: TObject);
begin
  inherited;
  If edtChaveAppDev.Text = 'Chave App cadastrada' Then
    edtChaveAppDev.Clear;
end;

procedure TfrmConfigBancoDoBrasilAPI.edtChaveAppDevExit(Sender: TObject);
begin
  inherited;

  If  fEmptyStr(edtChaveAppDev.Text) And
      (fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'KEY_USER', '') <> '') Then
    edtChaveAppDev.Text     := 'Chave App cadastrada';

  InformaTipoAPP;
end;

procedure TfrmConfigBancoDoBrasilAPI.edtCodPorKeyPress(Sender: TObject;
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

procedure TfrmConfigBancoDoBrasilAPI.edtCodPorVinKeyPress(Sender: TObject;
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


procedure TfrmConfigBancoDoBrasilAPI.edtDiasCred12Enter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtDiasCred12, 'Informar quantidade de dias para ocorrência tipo 12 ' + #13+#10 +
                             'do intervalo entre a efetuação ' + #13+#10 +
                             'do pagamento e o crédito na ' + #13+#10 +
                             'conta corrente.');

  pShowHint(edtDiasCred12, 'Quantidade de dias para crédito (ocorrência 12):');

end;

procedure TfrmConfigBancoDoBrasilAPI.edtDiasCred12Exit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoDoBrasilAPI.edtDiasCred12MouseEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtDiasCred12, 'Informar quantidade de dias para ocorrência tipo 12 ' + #13+#10 +
                             'do intervalo entre a efetuação ' + #13+#10 +
                             'do pagamento e o crédito na ' + #13+#10 +
                             'conta corrente.');

  pShowHint(edtDiasCred12, 'Quantidade de dias para crédito (ocorrência 12):');

end;

procedure TfrmConfigBancoDoBrasilAPI.edtDiasCred12MouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoDoBrasilAPI.edtDiasCredEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtDiasCred, 'Informar quantidade de dias ' + #13+#10 +
                           'do intervalo entre a efetuação ' + #13+#10 +
                           'do pagamento e o crédito na ' + #13+#10 +
                           'conta corrente.');

  pShowHint(edtDiasCred, 'Dias para Crédito');
end;

procedure TfrmConfigBancoDoBrasilAPI.edtDiasCredExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;


procedure TfrmConfigBancoDoBrasilAPI.edtDiasProtEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtDiasProt, 'Quantidade de dias após a data de vencimento ' + #13+#10 +
                           'do boleto para iniciar o processo de cobrança ' + #13+#10 +
                           'através de protesto.' + #13+#10 +
                           '(3 a 5 dias ÚTEIS ou 6 a 29, 35, 40 ou 45 dias CORRIDOS)');


  pShowHint(edtDiasProt, 'Dias para Protesto');
end;

procedure TfrmConfigBancoDoBrasilAPI.edtDiasProtExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoDoBrasilAPI.edtForTarKeyPress(Sender: TObject;
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

procedure TfrmConfigBancoDoBrasilAPI.edtPerMulExit(Sender: TObject);
begin
  inherited;
   If Not fEmptyStr(edtPerMul.Text) Then
    edtPerMul.Text := FormatFloat('#,##0.00', StrToFloat(edtPerMul.Text));
end;

procedure TfrmConfigBancoDoBrasilAPI.edtPorTarKeyPress(Sender: TObject;
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

procedure TfrmConfigBancoDoBrasilAPI.edtQtdDiasDataLimiteRecEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtQtdDiasDataLimiteRec, 'Informar quantidade de dias ' + #13+#10 +
                                       'para Data Limnite de recebimento, ' + #13+#10 +
                                       'usando como base a data de ' + #13+#10 +
                                       'vencimento do título.');

  pShowHint(edtQtdDiasDataLimiteRec, 'Dias para Data Limite de Recibimento');
end;

procedure TfrmConfigBancoDoBrasilAPI.edtQtdDiasDataLimiteRecExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoDoBrasilAPI.edtQtdDiasNegaEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtQtdDiasNega, 'Quantidade de dias corridos depois do vencimento ' + #13+#10 +
                              'do boleto para a negativação automática, através do ' + #13+#10 +
                              'órgão negativador selecionado. ');

  pShowHint(edtQtdDiasNega, 'Dias para Negativação');
end;

procedure TfrmConfigBancoDoBrasilAPI.edtQtdDiasNegaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoDoBrasilAPI.edtValorTarifaExit(Sender: TObject);
begin
  inherited;
  try
    if not fEmptyStr(edtValorTarifa.Text) then
       edtValorTarifa.Text := FormatFloat('###,##0.00', fStrToFloat(edtValorTarifa.Text));
  except
   //
  end
end;

procedure TfrmConfigBancoDoBrasilAPI.pAlteraHint(edtEdit: TEditFocus;
  strNovoHint: String);
begin
  edtEdit.Hint := strNovoHint;
end;

procedure TfrmConfigBancoDoBrasilAPI.pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
begin
  If Not fEmptyStr(strCtaBai) Then
  Begin
    pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
    edtLabel.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
  End
  Else
    edtLabel.Clear;
end;

procedure TfrmConfigBancoDoBrasilAPI.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  edtLabel.Clear;
  If Not fEmptyStr(strCodPor) Then
  Begin
    pPesquisaCadPor(Nil, qryCadPor, strCodPor);
    edtLabel.Text := qryCadPor.FieldByName('POR_NOMPOR').AsString;
  End
end;

procedure TfrmConfigBancoDoBrasilAPI.pHideHint;
begin
  HintControler.HideHint;
end;

function TfrmConfigBancoDoBrasilAPI.PlanoDeContaValido(ACodigo: TMaskEdit;
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

procedure TfrmConfigBancoDoBrasilAPI.pLimpaCampos;
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


function TfrmConfigBancoDoBrasilAPI.PortadorValido(ACodigo: TEdit; ADescricao: TEdit): Boolean;
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

procedure TfrmConfigBancoDoBrasilAPI.pShowHint(edtEdit: TEditFocus; strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;

function TfrmConfigBancoDoBrasilAPI.RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
begin
  While Not Sender.ClassName.Equals('TcxTabSheet') Do
  Begin
    Sender := Sender.Parent;
  End;
  Result := TcxTabSheet(Sender);
end;

procedure TfrmConfigBancoDoBrasilAPI.ShowHintComboBox(AComboBox: TcxComboBox;
  ATitulo: String);
begin
  HintControler.ShowHint(AComboBox.ClientOrigin.X,AComboBox.ClientOrigin.Y, ATitulo, AComboBox.Hint);
end;

procedure TfrmConfigBancoDoBrasilAPI.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  qryCadEmp := fCriaQuery(Self);
  qryCadFor := fCriaQuery(Self);
  pCarKeyAutBan;
  cxPaginas.Properties.ActivePage := tbsGeral;
  pnlChaveConexao.Enabled := fVerificaAcessoSistema('ALTCHAVEAUTAPIBB');

  fraGerarPixBoleto.Visible := fCfgSis('USAPIX', varBoolean);
end;

procedure TfrmConfigBancoDoBrasilAPI.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigBancoDoBrasilAPI.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigBancoDoBrasilAPI.btnAddOcoClick(Sender: TObject);
begin
  inherited;
  frmCadOcoCartei := TfrmCadOcoCartei.Create(nil);
  frmCadOcoCartei.strCartei :=  'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp;
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

procedure TfrmConfigBancoDoBrasilAPI.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&S i m', '&N ã o'], 2) = 1 then
  begin
    cxPaginas.ActivePage :=  tbsGeral;
    btnCancelar.Visible  := False;

    if tbsEncBan.tabVisible then
      pnlAtivo3.Enabled := False;

    btnEditar.Visible   := True;
    pnlAtivo1.Enabled   := False;
    pnlAtivo2.Enabled   := False;
    pnlComplemento.Enabled   := False;

    btnEditar.Visible   := True;
    btnGravar.Enabled   := False;
    btnConfigurar.Enabled := False;
    pCarregaDados;
    pSetFocus(btnEditar);
  end;
end;

procedure TfrmConfigBancoDoBrasilAPI.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pHideHint;

    pCriarFormularios(TfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '001';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigBancoDoBrasilAPI.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Código Carteira           :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', ''));
  stlCampos.Add('Variação Carteira         :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'VARCART', ''));
  stlCampos.Add('Número Convênio           :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCONV', ''));
  stlCampos.Add('Observação 1              :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2              :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3              :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4              :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Observação 5              :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  stlCampos.Add('Dias p/ protesto          :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  stlCampos.Add('Dias p/ crédito           :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Percentual Multa          :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', ''));
  stlCampos.Add('Dias para Negativação     :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIANEGA', ''));
  stlCampos.Add('Orgão Negativador         :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMORGAO', ''));
  stlCampos.Add('Protocolo Aceite          :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  stlCampos.Add('Código Agência            :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Dígito Agência            :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', ''));
  stlCampos.Add('Num. C. Corrente          :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Díg. C. Corrente          :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', ''));

  stlCampos.Add('Chave APP                 :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'KEY_USER', ''));
  stlCampos.Add('Autorização Basic         :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'AUTHORIZATION', ''));
  stlCampos.Add('Tipo de Cobrança          :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPO_COBRANCA', ''));
  stlCampos.Add('Conta Caução              :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTA_CAUCAO', ''));

  stlCampos.Add('Portador Cob. Simples     :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Pla. Contas Cob. Simples  :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Portador Cob. Vinculada   :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_VIN', ''));
  stlCampos.Add('Pla. Contas Cob. Vinculada:' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_VIN', ''));
  stlCampos.Add('Dias corridos para recebimento após o vencimento:' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIALIMI', ''));

  stlCampos.Add('Enc.Ban. Vr Tarifa:' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', ''));
  stlCampos.Add('Enc.Ban. Portador :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', ''));
  stlCampos.Add('Enc.Ban. Pl Conta :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', ''));
  stlCampos.Add('Enc.Ban. Fornec.  :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', ''));
  stlCampos.Add('Lançar Tarifa Ban.:' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'LANTX02', ''));

  stlCampos.Add('Quantidade de dias para crédito (ocorrência 12):' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED12', ''));
  stlCampos.Add('Permitir impressão de boletos? :' + fGetBancoConfig(0, 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1), 'PERIMPBOL', ''));

end;

procedure TfrmConfigBancoDoBrasilAPI.fraPlanoDeContasEncMskCodCtaKeyPress(
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

function TfrmConfigBancoDoBrasilAPI.fRetStrCfg(stlCfg : TStringList) : String;
Var
  intCont : Integer;
begin
  Result := '';

  For intCont := 0 To stlCfg.Count - 1 Do
    Result := Result + stlCfg.Strings[intCont] + #13+#10;
end;

procedure TfrmConfigBancoDoBrasilAPI.pGravaLogCarteira(stlCfgAnt : TStringList);
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
    pGravaLogAtb('001', 'BANCO DO BRASIL [Online]', 'CONFIG001API-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;


end.
