unit untConfigItauAPI;

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
  cxDBLookupComboBox, cxButtons,cxProgressBar,untGravando,
  untFrameGerarPixBoleto, System.DateUtils, untTiposPix;

type
  TfrmConfigItauAPI = class(TfrmPai)
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
    lblCodCart: TLabel;
    lblDiasProt: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    lblPercentualMulta: TLabel;
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
    Label15: TLabel;
    edtProAce: TEditFocus;
    ColorLabel3: TColorLabel;
    edtDigCtaCor: TEditFocus;
    edtContaCorr: TEditFocus;
    lblContCorr: TLabel;
    edtCodAgencia: TEditFocus;
    lblCodAgenc: TLabel;
    cxTabDadosSacadorAvalista: TcxTabSheet;
    pnlAtivo2: TPanel;
    tbsEncBan: TcxTabSheet;
    pnlAtivo3: TPanel;
    cxGroupBox1: TcxGroupBox;
    Label26: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    edtDesPorTar: TEditFocus;
    edtPorTar: TEditFocus;
    grpDupDescontada: TcxGroupBox;
    lblPorDes: TLabel;
    edtPorDes: TEditFocus;
    edtDesPorDes: TEditFocus;
    lblUtilizarPortadorDescontada: TLabel;
    edtUtilizarPortadorDescontada: TEditFocus;
    lblSimNaoPorDes: TLabel;
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
    lblDiasCreditoPix: TLabel;
    lblDiasCreditoPixSN: TColorLabel;
    edtDiasCreditoParaPix: TEditFocus;
    fraGerarPixBoleto: TfraGerarPixBoleto;
    fraPlanoDeContasBai: TfraPlanoDeContasMskEdit;
    Label4: TLabel;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    pnlSacAva: TPanel;
    Label5: TLabel;
    ColorLabel7: TColorLabel;
    grpBeneficiario: TGroupBox;
    lblDesCrr: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
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
    lbl1: TLabel;
    cmbTipDia: TComboBoxFocus;
    lblIdentBanco: TLabel;
    edtIdentBanc: TEditFocus;
    grpDadosAutorizacao: TGroupBox;
    pnlAuthV2: TPanel;
    lblClientSecret: TLabel;
    lblClientID: TLabel;
    edtClientSecret: TEditFocus;
    edtClientID: TEditFocus;
    pnlAuthV1: TPanel;
    lblArquivoPfx: TLabel;
    lblValidadeCertificado: TLabel;
    Label3: TLabel;
    edtArquivoKey: TEditFocus;
    btnArquivoKey: TcxButton;
    lblArquivoCRT: TLabel;
    edtArquivoCRT: TEditFocus;
    btnArquivoCRT: TcxButton;
    cmbCodigoMulta: TComboBoxFocus;
    btnImportarItau: TBitBtnLocked;
    btnValidarDadosAutorizacao: TBitBtnLocked;
    chkEnviarInstrucaoProtesto: TCheckBox;
    chkEnviarInstrucaoNegativacao: TCheckBox;
    grpContaVinculada: TGroupBox;
    lblAgenciaVinculada: TLabel;
    edtAgenciaVinculada: TEditFocus;
    lblContaCorrenteVinculada: TLabel;
    edtContaCorrenteVinculada: TEditFocus;
    edtDigitoContaVinculada: TEditFocus;
    lblCarteiraVinculada: TLabel;
    cmbCarteiraVinculada: TComboBoxFocus;
    Label1: TLabel;
    edtCodPorVinc: TEditFocus;
    edtDesPorVinc: TEditFocus;
    lblPerImpBol: TLabel;
    edtPerImpBol: TEditFocus;
    clbPerImpBol: TColorLabel;
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
    procedure edtPerMulExit(Sender: TObject);
    procedure edtQtdDiasNegaEnter(Sender: TObject);
    procedure edtQtdDiasNegaExit(Sender: TObject);
    procedure edtDiasProtEnter(Sender: TObject);
    procedure edtDiasProtExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtForTarKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasEncMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure edtPorTarKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorDesKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddOcoClick(Sender: TObject);
    procedure btnEdtOcoClick(Sender: TObject);
    procedure btnRemOcoClick(Sender: TObject);
    procedure edtValorTarifaExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure fraGerarPixBoletocmbChavePixPropertiesEditValueChanged(
      Sender: TObject);
    procedure btnArquivoCRTClick(Sender: TObject);
    procedure btnArquivoKeyClick(Sender: TObject);
    procedure cmbCodigoMultaChange(Sender: TObject);
    procedure cmbCodigoMultaEnter(Sender: TObject);
    procedure cmbCodigoMultaExit(Sender: TObject);
    procedure fraGerarPixBoletoedtGerarPixChange(Sender: TObject);
    procedure btnImportarItauClick(Sender: TObject);
    procedure btnValidarDadosAutorizacaoClick(Sender: TObject);
    procedure BtnOcorrenciaClick(Sender: TObject);
    procedure chkEnviarInstrucaoProtestoMouseEnter(Sender: TObject);
    procedure chkEnviarInstrucaoNegativacaoMouseEnter(Sender: TObject);
    procedure cxPaginasChange(Sender: TObject);
    procedure edtCodPorVincKeyPress(Sender: TObject; var Key: Char);

  private
    qryCadPor : TUniQuery;
    qryCadEmp : TUniQuery;
    qryCadCta : TUniQuery;
    qryCadFor : TUniQuery;

    FCarteira: String;

    procedure Carregadados;

    procedure CarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
    procedure CarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure ShowHint(edtEdit: TEditFocus; strTitulo: String);
    procedure HideHint;
    procedure AlteraHint(edtEdit: TEditFocus; strNovoHint: String);
    procedure LimpaCampos;
    procedure GravaLogCarteira(stlCfgAnt : TStringList);
    procedure CarregaCfg(Var stlCampos: TStringList);
    function RetStrCfg(stlCfg : TStringList) : String;
    procedure CarregaCodigoDaCarteira;
    function PortadorValido(ACodigo: TEdit; ADescricao: TEdit):Boolean;
    function PlanoDeContaValido(ACodigo: TMaskEdit; ADescricao: TEdit):Boolean;
    function RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
    procedure CarregaOcorrencias;
    procedure CarregaLancamentoTarifaBancaria;
    procedure CarregaFornecedor;

    function RetornaDadosCertificadoCRT(pgbStatus: TcxProgressBar): Boolean;
    function RetornaPastaOpenSSL: String;

    procedure MudaCorDaValidadeDoCertificado;

    procedure DefineDescricaoTipoMulta;

    function ValidaDadosAutenticacaoImportadosPix(ADadosChave: TDadosWebHook): Boolean;
    procedure ImportaDadosDeAutenticacaoPix;

    procedure PosicionaBotaoValidarDadosAutorizacao;
    { Private declarations }
  public
    { Public declarations }
    blnNaoEditar : Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;

  end;

implementation

uses  untfuncoesSimples, untPesqAux, untFuncoes,
     untCfgGenericas_AutBan, untConsultas,untTBancoItauAPI, untCadOcoCartei,
     untCNFOCO_Class, untCNFOCO_Dao, untFuncAutban, untSelecionaChavePix,
     untFuncoesBoleto, untMemo;

{$R *.dfm}

{ TfrmPai1 }

procedure TfrmConfigItauAPI.Carregadados;
begin
  fraGerarPixBoleto.CarregarChavesPix('341');
  FCarteira := 'CONFIG341API-' + (tabCarteira.TabIndex + 1).ToString;
  LimpaCampos;

  CarregaCodigoDaCarteira;
  CarregaLancamentoTarifaBancaria;

  edtCodAgencia.Text           := fGetBancoConfig(0, FCarteira, 'CODAGEN', '');
  edtIdentBanc.Text            := fGetBancoConfig(0, FCarteira, 'IDENTBC', '');
  edtContaCorr.Text            := fGetBancoConfig(0, FCarteira, 'NUMCTAC', '');
  edtDigCtaCor.Text            := fGetBancoConfig(0, FCarteira, 'DIGCTAC', '');

  edtDiasProt.Text             := fGetBancoConfig(0, FCarteira, 'DIAPROT', '');
  edtQtdDiasNega.Text          := fGetBancoConfig(0, FCarteira, 'DIANEGA', '');
  edtQtdDiasDataLimiteRec.Text := fGetBancoConfig(0, FCarteira, 'DIALIMI', '');
  edtObservacao1.Text          := fGetBancoConfig(0, FCarteira, 'OBSERV1', '');
  edtObservacao2.Text          := fGetBancoConfig(0, FCarteira, 'OBSERV2', '');
  edtObservacao3.Text          := fGetBancoConfig(0, FCarteira, 'OBSERV3', '');
  edtObservacao4.Text          := fGetBancoConfig(0, FCarteira, 'OBSERV4', '');
  edtObservacao5.Text          := fGetBancoConfig(0, FCarteira, 'OBSERV5', '');
  edtCodPor.Text               := fGetBancoConfig(0, FCarteira, 'PORBAI_', '');

  fraGerarPixBoleto.edtGerarPix.Text := fGetBancoConfig(0, FCarteira, 'GERAPIX', '');
  fraGerarPixBoleto.cmbChavePix.EditValue := fGetBancoConfig(0, FCarteira, 'CHAPIX', '');
  fraGerarPixBoleto.cmbChavePix.Enabled := False;

  fraPlanoDeContasBai.MskCodCta.Text := fGetBancoConfig(0, FCarteira, 'CTABAI_', '');
  
  edtPerMul.Text               := fGetBancoConfig(0, FCarteira, 'PERMULT', '');
  edtDiasCred.Text             := fGetBancoConfig(0, FCarteira, 'DIACRED', '');
  edtProAce.Text               := fGetBancoConfig(0, FCarteira, 'PROACEI', '');
  edtDiasCreditoParaPix.Text   := fGetBancoConfig(0, FCarteira, 'DIACREDPIX', 'N');
  edtDiasCreditoParaPix.Text   := IIF(fEmptyStr(edtDiasCreditoParaPix.Text), 'N', edtDiasCreditoParaPix.Text);

  edtPorTar.Text        := fGetBancoConfig(0, FCarteira, 'PORTTAR', '');
  fraPlanoDeContasEnc.MskCodCta.Text := fGetBancoConfig(0, FCarteira, 'CONTTAR', '');
  edtForTar.Text        := fGetBancoConfig(0, FCarteira, 'FORNTAR', '');
  edtValorTarifa.Text   := fGetBancoConfig(0, FCarteira, 'VALOTAR', '');
  edtPorDes.Text        := fGetBancoConfig(0, FCarteira, 'PORTDES', '');
  edtUtilizarPortadorDescontada.Text := fGetBancoConfig(0, FCarteira, 'PORDESPORBAI', 'N');
  edtUtilizarPortadorDescontada.Text := IIF(fEmptyStr(edtUtilizarPortadorDescontada.Text), 'N', edtUtilizarPortadorDescontada.Text);

  //Dados Beneficiário
  edtUsaSac.Text        := fGetBancoConfig(0, FCarteira, 'SACAVAL', '');
  edtUsaSac.Text        := IIF(fEmptyStr(edtUsaSac.Text), 'N', edtUsaSac.Text);
  edtDesBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'NOMEBEN', ''), '');
  edtEndBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'ENDEBEN', ''), '');
  edtBaiBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'BAIRBEN', ''), '');
  edtCompBen.Text       := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'COMPBEN', ''), '');
  edtCidBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'CIDABEN', ''), '');
  edtEstBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'ESTABEN', ''), '');
  edtCepBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'CEP_BEN', ''), '');
  edtCgcBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, FCarteira, 'CNPJBEN', ''), '');

  chkEnviarInstrucaoProtesto.Checked := Not fGetBancoConfig(0, FCarteira, 'ENVPROTE', 'S').Equals('N');
  chkEnviarInstrucaoNegativacao.Checked := Not fGetBancoConfig(0, FCarteira, 'ENVNEGAT', 'S').Equals('N');

  edtAgenciaVinculada.Text := fGetBancoConfig(0, FCarteira, 'CODAGENVINC', '');
  edtContaCorrenteVinculada.Text := fGetBancoConfig(0, FCarteira, 'NUMCTACVINC', '');
  edtDigitoContaVinculada.Text := fGetBancoConfig(0, FCarteira, 'DIGCTACVINC', '');
  edtCodPorVinc.Text           := fGetBancoConfig(0, FCarteira, 'PORBAIVINC', '');

  If fEmptyStr(edtAgenciaVinculada.Text) Then
    cmbCarteiraVinculada.ItemIndex := -1;

  cmbTipDia.ItemIndex    := -1;
  If Not fEmptyStr(fGetBancoConfig(0, FCarteira, 'TIPDIA', '1')) Then
    cmbTipDia.ItemIndex    := StrToInt(fGetBancoConfig(0, FCarteira ,'TIPDIA', '1'))-1;

  edtPerImpBol.Text := fGetBancoConfig(0, FCarteira, 'PERIMPBOL', '');
  If fEmptyStr(edtPerImpBol.Text) Then
    edtPerImpBol.Text := 'S';

  edtArquivoCRT.Clear;
  If fGetBancoConfig(0, FCarteira, 'AUTHCRT', '') <> '' Then
    edtArquivoCRT.Text := 'certificado cadastrado';

  edtArquivoKEY.Clear;
  If fGetBancoConfig(0, FCarteira, 'AUTHKEY', '') <> '' Then
    edtArquivoKEY.Text := 'certificado cadastrado';

  edtClientID.Clear;
  If fGetBancoConfig(0, FCarteira, 'CLIENT_ID', '') <> '' Then
    edtClientID.Text := 'Client ID cadastrado';

  edtClientSecret.Clear;
  If fGetBancoConfig(0, FCarteira, 'CLIENT_SECRET', '') <> '' Then
    edtClientSecret.Text := 'Client Secret cadastrado';

  Try
    Case StrToIntDef(fGetBancoConfig(0, FCarteira,'CODIGOMULTA', ''), 0) Of
      1: cmbCodigoMulta.ItemIndex := 1;
      2: cmbCodigoMulta.ItemIndex := 2;
      Else cmbCodigoMulta.ItemIndex := 0;
    End;
  except
    cmbCodigoMulta.ItemIndex := 0;
  end;

  lblValidadeCertificado.Caption := fGetBancoConfig(0, FCarteira, 'VALCERT', '');
  MudaCorDaValidadeDoCertificado;

  fValidaCampos(edtUsaSac);

  CarregaPortador(edtCodPor.Text, edtDesPor);
  CarregaPortador(edtPorTar.Text, edtDesPorTar);
  CarregaPortador(edtPorDes.Text, edtDesPorDes);
  CarregaPortador(edtCodPorVinc.Text, edtDesPorVinc);

  CarregaOcorrencias;

  CarregaCentroCusto(fraPlanoDeContasBai.MskCodCta.Text, fraPlanoDeContasBai.edtDesCta);
  CarregaCentroCusto(fraPlanoDeContasEnc.MskCodCta.Text, fraPlanoDeContasEnc.edtDesCta);
  CarregaFornecedor;

  fraGerarPixBoleto.edtGerarPix.OnChange(fraGerarPixBoleto.edtGerarPix);
end;


procedure TfrmConfigItauAPI.CarregaOcorrencias;
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
  Try
    If cdsCnfOco.Active Then
      cdsCnfOco.EmptyDataSet
    Else
      cdsCnfOco.CreateDataSet;

    pDesmembraCarteira(FCarteira + '-' + VS_strCodEmp, strCodBco,
                       strTipLay, strNumPos, strEspeci, strCodEmp, intCartei);

    objCnfDao := TCnfOcoDao.Create(strCodBco, strTipLay, strNumPos,
                                   strEspeci, strCodEmp, intCartei);

    lstCnfOco := Nil;
    Try
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
              4: cdsCnfOcoCNF_DSTPDS.AsString := 'JUROS OPERAÇÃO';
            End;
            Post;
          End;
        End;
      End;
    Finally
      FreeAndNil(lstCnfOco);
      FreeAndNil(objCnfDao);
    End;

    cdsCnfOco.First;
  Finally
    cdsCnfOco.EnableControls;
  End;
end;
procedure TfrmConfigItauAPI.FormShow(Sender: TObject);
begin
  inherited;
  tbsEncBan.TabVisible := fCfgSis('ENCBAN', varBoolean);
  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  CarregaDados;

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

procedure TfrmConfigItauAPI.btnEditarClick(Sender: TObject);
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

    pSetFocus(cmbCodCar);
  end;
end;


procedure TfrmConfigItauAPI.btnEdtOcoClick(Sender: TObject);
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

  CarregaOcorrencias;

  If intRecNo_ > 0 Then
  Begin
    cdsCnfOco.DisableControls;
    cdsCnfOco.RecNo := intRecNo_;
    cdsCnfOco.EnableControls;

  End;
end;

procedure TfrmConfigItauAPI.btnGravarClick(Sender: TObject);
  Var
    LCfgAnt : TStringList;
begin
  inherited;
  If fVerificaCampos Then
  Begin

    Try
      LCfgAnt := TStringList.Create;
      CarregaCfg(LCfgAnt);

      fGetBancoConfig(1, FCarteira, 'CODAGEN', edtCodAgencia.Text);
      fGetBancoConfig(1, FCarteira, 'IDENTBC', edtIdentBanc.Text    );
      fGetBancoConfig(1, FCarteira, 'NUMCTAC', edtContaCorr.Text);
      fGetBancoConfig(1, FCarteira, 'DIGCTAC', edtDigCtaCor.Text);


      fGetBancoConfig(1, FCarteira, 'RESPONS', 'E');
      fGetBancoConfig(1, FCarteira, 'NUMCART', cmbCodCar.Text);
      fGetBancoConfig(1, FCarteira, 'DIAPROT', edtDiasProt.Text);
      fGetBancoConfig(1, FCarteira, 'DIANEGA', edtQtdDiasNega.Text);
      fGetBancoConfig(1, FCarteira, 'OBSERV1', edtObservacao1.Text);
      fGetBancoConfig(1, FCarteira, 'OBSERV2', edtObservacao2.Text);
      fGetBancoConfig(1, FCarteira, 'OBSERV3', edtObservacao3.Text);
      fGetBancoConfig(1, FCarteira, 'OBSERV4', edtObservacao4.Text);
      fGetBancoConfig(1, FCarteira, 'OBSERV5', edtObservacao5.Text);
      fGetBancoConfig(1, FCarteira, 'PORBAI_', edtCodPor.Text);

      fGetBancoConfig(1, FCarteira, 'CTABAI_', fraPlanoDeContasBai.mskCodCta.Text);

      fGetBancoConfig(1, FCarteira, 'PERMULT', edtPerMul.Text);
      fGetBancoConfig(1, FCarteira, 'DIACRED', edtDiasCred.Text);
      fGetBancoConfig(1, FCarteira, 'DIALIMI', edtQtdDiasDataLimiteRec.Text);
      fGetBancoConfig(1, FCarteira, 'PROACEI', edtProAce.Text       );
      fGetBancoConfig(1, FCarteira, 'DIACREDPIX', edtDiasCreditoParaPix.Text);
      fGetBancoConfig(1, FCarteira, 'PERIMPBOL', edtPerImpBol.Text);

      fGetBancoConfig(1, FCarteira, 'GERAPIX', fraGerarPixBoleto.edtGerarPix.Text);
      fGetBancoConfig(1, FCarteira, 'CHAPIX', IIF(fraGerarPixBoleto.edtGerarPix.Text = 'N', '', fraGerarPixBoleto.cmbChavePix.EditValue));

      fGetBancoConfig(1, FCarteira, 'PORTTAR', edtPorTar.Text    );
      fGetBancoConfig(1, FCarteira, 'CONTTAR', fraPlanoDeContasEnc.MskCodCta.Text);
      fGetBancoConfig(1, FCarteira, 'FORNTAR', edtForTar.Text    );
      fGetBancoConfig(1, FCarteira, 'VALOTAR', edtValorTarifa.Text  );
      fGetBancoConfig(1, FCarteira, 'LANTX02', IIF(cmbLancarTarifa.ItemIndex = 1, '02', '06'));
      fGetBancoConfig(1, FCarteira, 'PORTDES', edtPorDes.Text);
      fGetBancoConfig(1, FCarteira, 'PORDESPORBAI', edtUtilizarPortadorDescontada.Text);

      fGetBancoConfig(1, FCarteira, 'CODIGOMULTA', IntToStr(cmbCodigoMulta.ItemIndex));

      fGetBancoConfig(1, FCarteira, 'ENVPROTE', IIF(chkEnviarInstrucaoProtesto.Checked, 'S', 'N'));
      fGetBancoConfig(1, FCarteira, 'ENVNEGAT', IIF(chkEnviarInstrucaoNegativacao.Checked, 'S', 'N'));

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

      fGetBancoConfig(1, FCarteira, 'CODAGENVINC', edtAgenciaVinculada.Text);
      fGetBancoConfig(1, FCarteira, 'NUMCTACVINC', edtContaCorrenteVinculada.Text);
      fGetBancoConfig(1, FCarteira, 'DIGCTACVINC', edtDigitoContaVinculada.Text);
      fGetBancoConfig(1, FCarteira, 'NUMCARTVINC', cmbCarteiraVinculada.Text);
      fGetBancoConfig(1, FCarteira, 'PORBAIVINC',  edtCodPorVinc.Text);

      fGetBancoConfig(1, FCarteira, 'TIPDIA' , IntToStr(cmbTipDia.ItemIndex + 1));

      If Not MatchStr(edtArquivoCRT.Text, ['', 'certificado cadastrado']) Then
      Begin
        fGetBancoConfig(1, FCarteira, 'AUTHCRT', RetornaArquivoBase64(edtArquivoCRT.Text));

        fGetBancoConfig(1, FCarteira, 'VALCERT', lblValidadeCertificado.Caption);
      End;

      If Not MatchStr(edtArquivoKEY.Text, ['', 'certificado cadastrado']) Then
        fGetBancoConfig(1, FCarteira, 'AUTHKEY', RetornaArquivoBase64(edtArquivoKEY.Text));

      If Not MatchStr(edtClientID.Text, ['', 'Client ID cadastrado']) Then
        fGetBancoConfig(1, FCarteira, 'CLIENT_ID', edtClientID.Text);

      If Not MatchStr(edtClientSecret.Text, ['', 'Client Secret cadastrado']) Then
        fGetBancoConfig(1, FCarteira, 'CLIENT_SECRET',edtClientSecret.Text);

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        pSetFocus(cmbCodCar);
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

      GravaLogCarteira(LCfgAnt);
      CarregaDados;

    Except
      On E:Exception Do
      Begin
        fMensagem('Erro','Ocorreu um erro ao tentar salvar os dados.' + #13 + E.Message,['&O K']);
      End;
    End;

    FreeAndNil(LCfgAnt);
  End;
end;


procedure TfrmConfigItauAPI.btnImportarItauClick(Sender: TObject);
begin
  inherited;
  If fGetBancoConfig(0, FCarteira, 'GERAPIX', '').IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'Para utilizar essa função, é necessário confirmar a inclusão da carteira.' + #13 +
                         'Após a carteira já estiver cadastrada, clique em "Alterar" e utilize a função.', ['&Ok']);

    Exit;
  End;

  TfrmGravando.fExecutarModal(ImportaDadosDeAutenticacaoPix, 'Aguarde... Importando dados de autenticação Pix.', '');
end;

procedure TfrmConfigItauAPI.btnRemOcoClick(Sender: TObject);
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
          CarregaOcorrencias;
          pMensagemOk('Registro removido com sucesso!');
        End;
        objCnfOco.Free;
      End;
      objCnfDao.Free;
    End;
  End;
end;


procedure TfrmConfigItauAPI.btnValidarDadosAutorizacaoClick(Sender: TObject);
  Var
    LBancoItauAPI: TBancoItauAPI;
begin
  inherited;

  LBancoItauAPI := TBancoItauAPI.Create(FCarteira + '-' + VS_strCodEmp);

  Try
    TfrmGravando.fExecutarModal(LBancoItauAPI.ValidarDadosAutorizacao,
                                'Aguarde... Validando dados de autorização.', '');
  Finally
    FreeAndNil(LBancoItauAPI);
  End;
end;

procedure TfrmConfigItauAPI.CarregaCodigoDaCarteira;
begin
  Try
    Case StrToInt(fGetBancoConfig(0, FCarteira, 'NUMCART', '')) Of
      109: cmbCodCar.ItemIndex := 0;
      110: cmbCodCar.ItemIndex := 1;
      111: cmbCodCar.ItemIndex := 2;
      115: cmbCodCar.ItemIndex := 3;
      118: cmbCodCar.ItemIndex := 4;
      148: cmbCodCar.ItemIndex := 5;
      153: cmbCodCar.ItemIndex := 6;
      175: cmbCodCar.ItemIndex := 7;
      180: cmbCodCar.ItemIndex := 8;
      198: cmbCodCar.ItemIndex := 9;
    End;
  Except
    cmbCodCar.ItemIndex := -1;
  End;

  Try
    Case StrToInt(fGetBancoConfig(0, FCarteira, 'NUMCARTVINC', '')) Of
      109: cmbCarteiraVinculada.ItemIndex := 0;
      110: cmbCarteiraVinculada.ItemIndex := 1;
      111: cmbCarteiraVinculada.ItemIndex := 2;
      115: cmbCarteiraVinculada.ItemIndex := 3;
      118: cmbCarteiraVinculada.ItemIndex := 4;
      148: cmbCarteiraVinculada.ItemIndex := 5;
      153: cmbCarteiraVinculada.ItemIndex := 6;
      175: cmbCarteiraVinculada.ItemIndex := 7;
      180: cmbCarteiraVinculada.ItemIndex := 8;
      198: cmbCarteiraVinculada.ItemIndex := 9;
    End;
  Except
    cmbCarteiraVinculada.ItemIndex := -1;
  End;
end;

procedure TfrmConfigItauAPI.CarregaFornecedor;
begin
  edtDesForTar.Clear;
  If Not fEmptyStr( edtForTar.Text ) Then
  begin
    pPesquisaCadFor(qryCadFor, qryCadFor, edtForTar.Text);
    edtDesForTar.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
  end;
end;

procedure TfrmConfigItauAPI.CarregaLancamentoTarifaBancaria;
begin
  Case StrToIntDef(fGetBancoConfig(0, FCarteira, 'LANTX02', '06'),-1) Of
    06 : cmbLancarTarifa.ItemIndex := 0;
    02 : cmbLancarTarifa.ItemIndex := 1;
  End;
end;

procedure TfrmConfigItauAPI.chkEnviarInstrucaoNegativacaoMouseEnter(
  Sender: TObject);
begin
  inherited;
  chkEnviarInstrucaoNegativacao.Hint := 'Quando o campo estiver selecionado: ' + #13#10 +
                                        ' -Com o valor igual a "0" no campo "Dias para Negativação", irá enviar a ' + #13#10 +
                                        '  instrução para "Não Negativar".' + #13#10 +
                                        ' -Com o valor maior que "0" no campo "Dias para Negativação", irá enviar a ' + #13#10 +
                                        '  instrução para "Negativar".' + #13#10 + #13#10 +
                                        'Quando o campo "NÃO" estiver selecionado: ' + #13#10 +
                                        ' -Não enviará ao banco qualquer instrução de negativação.' + #13#10 +
                                        ' *Em carteiras do banco Itaú que não possuem o serviço de negativação ativo, ' + #13#10 +
                                        '  essa opção deve ser desmarcada.';


  HintControler.ShowHint(chkEnviarInstrucaoNegativacao.ClientOrigin.X,
                         chkEnviarInstrucaoNegativacao.ClientOrigin.Y,
                         'Enviar Instrução de Negativação',
                         chkEnviarInstrucaoNegativacao.Hint);
end;

procedure TfrmConfigItauAPI.chkEnviarInstrucaoProtestoMouseEnter(
  Sender: TObject);
begin
  inherited;
  chkEnviarInstrucaoProtesto.Hint := 'Quando o campo estiver selecionado: ' + #13#10 +
                                     ' -Com o valor igual a "0" no campo "Dias para Protesto", irá enviar a ' + #13#10 +
                                     '  instrução para "Não Protestar".' + #13#10 +
                                     ' -Com o valor maior que "0" no campo "Dias para Protesto", irá enviar a ' + #13#10 +
                                     '  instrução para "Protestar".' + #13#10 + #13#10 +
                                     'Quando o campo "NÃO" estiver selecionado: ' + #13#10 +
                                     ' -Não enviará ao banco qualquer instrução de protesto.' + #13#10 +
                                     ' *Em carteiras do banco Itaú que não possuem o serviço de protesto ativo, ' + #13#10 +
                                     '  essa opção deve ser desmarcada.';


  HintControler.ShowHint(chkEnviarInstrucaoProtesto.ClientOrigin.X,
                         chkEnviarInstrucaoProtesto.ClientOrigin.Y,
                         'Enviar Instrução de Protesto',
                         chkEnviarInstrucaoProtesto.Hint);
end;

procedure TfrmConfigItauAPI.cmbCodigoMultaChange(Sender: TObject);
begin
  inherited;
  DefineDescricaoTipoMulta;
end;

procedure TfrmConfigItauAPI.cmbCodigoMultaEnter(Sender: TObject);
begin
  inherited;
  cmbCodigoMulta.Hint := 'Quando o campo estiver selecionado: ' + #13#10 +
                         '-"Padrão": o valor da multa e da mora serão calculados sobre o valor do boleto.' + #13#10 +
                         '-"Valor Fixo": a multa será o valor do campo Valor Fixo da Multa e o valor da ' + #13#10 +
                         '               mora será calculado sobre o valor do boleto.'+ #13#10 +
                         '-"Percentual de Multa": o valor da multa e da mora do boleto serão impressos ' + #13#10 +
                         '                        com os percentuais cadastrados.';


  HintControler.ShowHint(cmbCodigoMulta.ClientOrigin.X,
                         cmbCodigoMulta.ClientOrigin.Y,
                         'Tipo de impressão da Multa',
                         cmbCodigoMulta.Hint);
end;

procedure TfrmConfigItauAPI.cmbCodigoMultaExit(Sender: TObject);
begin
  inherited;
  HideHint;
end;

procedure TfrmConfigItauAPI.cxPaginasChange(Sender: TObject);
begin
  inherited;
  btnValidarDadosAutorizacao.Visible := cxPaginas.ActivePageIndex = 0;
end;

procedure TfrmConfigItauAPI.DefineDescricaoTipoMulta;
begin
  lblPercentualMulta.Caption := 'Percentual de Multa:';
  If cmbCodigoMulta.ItemIndex = 1 Then
   lblPercentualMulta.Caption := 'Valor fixo de Multa:';
end;

function TfrmConfigItauAPI.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  var
    strMensagemConfig: String;
begin
  strMensagemConfig := '';
  if blnNaoEditar then
     strMensagemConfig := #13 + 'Por favor acesse a tela de configuração do banco selecionado ' + #13  + ' e corrija as informações necessárias!';

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin


    If (Sender = edtCodPor) Then
      Result := PortadorValido(edtCodPor,edtDesPor)

    Else If (Sender = fraPlanoDeContasBai.MskCodCta) Then
      Result := PlanoDeContaValido(fraPlanoDeContasBai.MskCodCta,fraPlanoDeContasBai.edtDesCta)

    Else If (Sender = cmbCodCar) Then
    Begin
      If cmbCodCar.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Código da Carteira deve ser informado!'+strMensagemConfig,['&OK']);
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
      End
      Else If Length(edtContaCorr.Text) <> 5 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Número da Conta Corrente deve conter 5 números!'+strMensagemConfig, ['&OK']);
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

      If Result Then
        edtIdentBanc.Text := RightStr(edtContaCorr.Text + edtDigCtaCor.Text, 6);
    End

    Else If (Sender = edtCodAgencia) Then
    Begin
      If fEmptyStr(edtCodAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Código da Agencia deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End
      Else If Length(edtCodAgencia.Text) <> 4 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Código da Agencia deve conter 4 números!'+strMensagemConfig, ['&OK']);
        Result := False;
      End
    End

    Else If (Sender = edtDiasProt) Then
    Begin
      If fEmptyStr(edtDiasProt.Text) Then
      begin
        fMensagem('ATENÇÃO','O campo dias para protesto deve ser maior ou igual a 0!'+strMensagemConfig,['&OK']);
        Result := False;
      end
      Else If StrToInt(edtDiasProt.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO','O campo dias para protesto deve ser maior ou igual a 0!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else If Not chkEnviarInstrucaoProtesto.Checked Then
      Begin
        If StrToInt(edtDiasProt.Text) <> 0 Then
        Begin
          fMensagem('ATENÇÃO','O campo dias para protesto deve ser igual a 0 quando a opção Enviar Instrução estiver desmarcada!'+strMensagemConfig,['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtQtdDiasNega) Then
    Begin
      If fEmptyStr(edtQtdDiasNega.Text) Then
      begin
        fMensagem('ATENÇÃO','O campo dias para negativação deve ser maior ou igual a 0!'+strMensagemConfig,['&OK']);
        Result := False;
      end
      Else If StrToInt(edtQtdDiasNega.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO','O campo dias para negativação deve ser maior ou igual a 0!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else If Not chkEnviarInstrucaoNegativacao.Checked Then
      Begin
        If StrToInt(edtQtdDiasNega.Text) <> 0 Then
        Begin
          fMensagem('ATENÇÃO','O campo dias para negativação deve ser igual a 0 quando a opção Enviar Instrução estiver desmarcada!'+strMensagemConfig,['&OK']);
          Result := False;
        End;
      End;
    End

    Else If Sender = edtPerImpBol Then
    Begin
      If Not MatchStr(edtPerImpBol.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO','O campo Permitir impressão de boletos deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
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

    Else If Sender = edtDiasCreditoParaPix Then
    Begin
      If Pos(edtDiasCreditoParaPix.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Utilizar dias para Crédito em recebimentos por Pix deve ser preenchido com (S/N)!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else If fraGerarPixBoleto.edtGerarPix.Text = 'N' Then
      Begin
        If edtDiasCreditoParaPix.Text = 'S' Then
        Begin
          fMensagem('','O campo Utilizar dias para Crédito em recebimentos por Pix não pode preenchido com "S" quando não utiliza Pix!'+strMensagemConfig,['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtAgenciaVinculada) Then
    Begin
      If fEmptyStr(edtAgenciaVinculada.Text) Then
      Begin
        edtContaCorrenteVinculada.Clear;
        edtDigitoContaVinculada.Clear;
        cmbCarteiraVinculada.ItemIndex := -1;

        Exit(True);
      End;

      If Length(edtAgenciaVinculada.Text) <> 4 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Agência vinculada deve conter 4 números!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtContaCorrenteVinculada) Then
    Begin
      If fEmptyStr(edtAgenciaVinculada.Text) Then
        Exit(True);

      If Length(edtContaCorrenteVinculada.Text) <> 5 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Conta Corrente vinculada deve conter 5 números!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtDigitoContaVinculada) Then
    Begin
      If fEmptyStr(edtAgenciaVinculada.Text) Then
        Exit(True);

      If Length(edtDigitoContaVinculada.Text) <> 1 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Dígito Conta Corrente vinculada deve conter 1 número!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = cmbCarteiraVinculada) Then
    Begin
      If fEmptyStr(edtAgenciaVinculada.Text) Then
        Exit(True);

      If cmbCarteiraVinculada.ItemIndex < 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Cód. Carteira vinculada deve ser selecionada!'+strMensagemConfig, ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodPorVinc) Then
    Begin
      If fEmptyStr(edtCodPorVinc.Text) Then
        Exit(True);

      If (Sender = edtCodPorVinc) Then
          Result := PortadorValido(edtCodPorVinc,edtDesPorVinc)

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
        CarregaPortador(edtPorTar.Text, edtDesPorTar);

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

    Else If (tbsEncBan.TabVisible = True) and (Sender = edtPorDes) Then
    Begin
      If fEmptyStr(edtPorDes.Text) Then
        edtDesPorDes.Clear
      Else
      Begin
        CarregaPortador(edtPorDes.Text, edtDesPorDes);

        If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!'+strMensagemConfig, ['&Ok']);
          cxPaginas.ActivePage := tbsEncBan;
          Result := False;
        End
        Else If Not fEmpresaTemAcessoPortador(edtPorDes.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtPorDes.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig, ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (tbsEncBan.TabVisible = True) and (Sender = edtUtilizarPortadorDescontada) Then
    Begin
      If Pos(edtUtilizarPortadorDescontada.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Utilizar Portador de Dupl. Descontadas no Portador de Baixa deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

      If (edtUtilizarPortadorDescontada.Text = 'S') And
         fEmptyStr(edtPorDes.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O campo Portador de Duplicatas Descontadas deve ser informado!'+strMensagemConfig, ['&Ok']);
        edtPorDes.Clear;
        Result := False;
      end;
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
        CarregaCentroCusto(fraPlanoDeContasEnc.MskCodCta.Text, fraPlanoDeContasEnc.edtDesCta);
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

    Else If (Sender = cmbTipDia) Then
    Begin
      If cmbTipDia.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO','O tipo de dias para protesto deve ser selecionado!'+strMensagemConfig,['&OK']);
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

    // DADOS BENEFICIARIO
    Else If Sender = edtUsaSac Then
    Begin

      If Not MatchStr(edtUsaSac.Text, ['S', 'N']) Then
      Begin
        fMensagem('','O campo Enviar Sacador/Avalista deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      End
      Else If (edtUsaSac.Text = 'N') Then
      Begin
        edtCompBen.Clear;
        edtDesBen.Clear;
        edtEndBen.Clear;
        edtBaiBen.Clear;
        edtCidBen.Clear;
        edtEstBen.Clear;
        edtCepBen.Clear;
        edtCgcBen.Clear;
      End;


      grpBeneficiario.Enabled := edtUsaSac.Text = 'S';
    End

    Else If Sender = edtDesBen Then
    Begin
      If (fEmptyStr(edtDesBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Sacador/Avalista deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtEndBen Then
    Begin
      If (fEmptyStr(edtEndBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Endereço do Sacador/Avalista deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtBaiBen Then
    Begin
      If (fEmptyStr(edtBaiBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Bairro do Sacador/Avalista deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtCidBen Then
    Begin
      If (fEmptyStr(edtCidBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Cidade do Sacador/Avalista deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtEstBen Then
    Begin
      If (fEmptyStr(edtEstBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Estado do Sacador/Avalista deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End

    Else If Sender = edtCepBen Then
    Begin
      If (edtUsaSac.Text = 'S') Then
      Begin
        If (fEmptyStr(fRetSomenteNumeros(edtCepBen.Text))) Then
        Begin
          fMensagem('ATENÇÃO','O campo CEP do Sacador/Avalista deve ser preenchido!' ,['&O K']);
          Result := False;
        End
        Else If Length(fRetSomenteNumeros(edtCepBen.Text)) < 8 Then
        Begin
          fMensagem('ATENÇÃO','O campo CEP do Sacador/Avalista deve ser preenchido com 8 números!' ,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If Sender = edtCgcBen Then
    Begin
      If (edtUsaSac.Text = 'S') Then
      Begin
        If (fEmptyStr(fTiraCaracEspeciaisPonto(edtCgcBen.Text))) Then
        Begin
          fMensagem('ATENÇÃO','O campo CNPJ do Sacador/Avalista deve ser preenchido!' ,['&O K']);
          Result := False;
        End
        Else If (Length(fTiraCaracEspeciaisPonto(edtCgcBen.Text)) < 14) Or (Not fValidaCnpjCpf(edtCgcBen.Text)) Then
        Begin
          fMensagem('ATENÇÃO','O campo CNPJ do Sacador/Avalista deve conter um número válido!' ,['&O K']);
          Result := False;
        End;
      End;
    End;
    // END DADOS BENEFICIARIO
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

procedure TfrmConfigItauAPI.lblValidaOcoMouseLeave(Sender: TObject);
begin
  inherited;
  HideHint;
end;

procedure TfrmConfigItauAPI.MudaCorDaValidadeDoCertificado;
  Var
    LValidade: TDateTime;
begin
  lblValidadeCertificado.Font.Color := clBlack;

  If fEmptyStr(lblValidadeCertificado.Caption) Then
    Exit;

  LValidade := StrToDate(lblValidadeCertificado.Caption);
  If LValidade <= VS_Date Then
    lblValidadeCertificado.Font.Color := clRed
  Else If DaysBetween(LValidade, VS_Date) <= 30 Then
    lblValidadeCertificado.Font.Color := clGreen;
end;

procedure TfrmConfigItauAPI.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  Carregadados;
  cxPaginas.ActivePage := tbsGeral;
end;

procedure TfrmConfigItauAPI.tabCarteiraChanging(Sender: TObject;
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

function TfrmConfigItauAPI.ValidaDadosAutenticacaoImportadosPix(
  ADadosChave: TDadosWebHook): Boolean;
begin
  Result := True;

  Try
    If ADadosChave.ClientId.Trim.IsEmpty Then
      Exit(False);

    If ADadosChave.ClientSecret.Trim.IsEmpty Then
      Exit(False);

    If ADadosChave.CertificadoCrt.Trim.IsEmpty Then
      Exit(False);

    If ADadosChave.CertificadoKey.Trim.IsEmpty Then
      Exit(False);
  Finally
    If Not Result Then
      fMensagem('ATENÇÃO', 'Dados da chave Pix selecionada não possui os dados necessários. Verifique!', ['&Ok']);
  End;
end;

procedure TfrmConfigItauAPI.edtCodPorKeyPress(Sender: TObject;
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

procedure TfrmConfigItauAPI.edtCodPorVincKeyPress(Sender: TObject;
  var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPorVinc, edtDesPorVinc, nil, Key, arrSel) then
  Begin
    If fValidaCampos(edtCodPorVinc, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConfigItauAPI.edtDiasCredEnter(Sender: TObject);
begin
  inherited;
  AlteraHint(edtDiasCred, 'Informar quantidade de dias ' + #13+#10 +
                           'do intervalo entre a efetuação ' + #13+#10 +
                           'do pagamento e o crédito na ' + #13+#10 +
                           'conta corrente.');

  ShowHint(edtDiasCred, 'Dias para Crédito');
end;

procedure TfrmConfigItauAPI.edtDiasCredExit(Sender: TObject);
begin
  inherited;
  HideHint;
end;


procedure TfrmConfigItauAPI.edtDiasProtEnter(Sender: TObject);
begin
  inherited;
  AlteraHint(edtDiasProt, 'Quantidade de dias após a data de vencimento ' + #13+#10 +
                           'do boleto para iniciar o processo de cobrança ' + #13+#10 +
                           'através de protesto.' + #13+#10 +
                           '(3 a 5 dias ÚTEIS ou 6 a 29, 35, 40 ou 45 dias CORRIDOS)');


  ShowHint(edtDiasProt, 'Dias para Protesto');
end;

procedure TfrmConfigItauAPI.edtDiasProtExit(Sender: TObject);
begin
  inherited;
  HideHint;
end;

procedure TfrmConfigItauAPI.edtForTarKeyPress(Sender: TObject;
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

procedure TfrmConfigItauAPI.edtPerMulExit(Sender: TObject);
begin
  inherited;
   If Not fEmptyStr(edtPerMul.Text) Then
    edtPerMul.Text := FormatFloat('#,##0.00', StrToFloat(edtPerMul.Text));
end;

procedure TfrmConfigItauAPI.edtPorTarKeyPress(Sender: TObject;
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

procedure TfrmConfigItauAPI.edtPorDesKeyPress(Sender: TObject;
  var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtPorDes, edtDesPorDes, nil, Key, arrSel) then
  Begin
    If fValidaCampos(edtPorDes, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConfigItauAPI.edtQtdDiasDataLimiteRecEnter(Sender: TObject);
begin
  inherited;
  AlteraHint(edtQtdDiasDataLimiteRec, 'Informar quantidade de dias ' + #13+#10 +
                                       'para Data Limnite de recebimento, ' + #13+#10 +
                                       'usando como base a data de ' + #13+#10 +
                                       'vencimento do título.');

  ShowHint(edtQtdDiasDataLimiteRec, 'Dias para Data Limite de Recibimento');
end;

procedure TfrmConfigItauAPI.edtQtdDiasDataLimiteRecExit(Sender: TObject);
begin
  inherited;
  HideHint;
end;

procedure TfrmConfigItauAPI.edtQtdDiasNegaEnter(Sender: TObject);
begin
  inherited;
  AlteraHint(edtQtdDiasNega, 'Quantidade de dias corridos depois do vencimento ' + #13+#10 +
                              'do boleto para a negativação automática, através do ' + #13+#10 +
                              'órgão negativador selecionado. ');

  ShowHint(edtQtdDiasNega, 'Dias para Negativação');
end;

procedure TfrmConfigItauAPI.edtQtdDiasNegaExit(Sender: TObject);
begin
  inherited;
  HideHint;
end;

procedure TfrmConfigItauAPI.edtValorTarifaExit(Sender: TObject);
begin
  inherited;
  try
    if not fEmptyStr(edtValorTarifa.Text) then
       edtValorTarifa.Text := FormatFloat('###,##0.00', fStrToFloat(edtValorTarifa.Text));
  except
   //
  end
end;

procedure TfrmConfigItauAPI.AlteraHint(edtEdit: TEditFocus;
  strNovoHint: String);
begin
  edtEdit.Hint := strNovoHint;
end;

procedure TfrmConfigItauAPI.CarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
begin
  If Not fEmptyStr(strCtaBai) Then
  Begin
    pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
    edtLabel.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
  End
  Else
    edtLabel.Clear;
end;

procedure TfrmConfigItauAPI.CarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  edtLabel.Clear;
  If Not fEmptyStr(strCodPor) Then
  Begin
    pPesquisaCadPor(Nil, qryCadPor, strCodPor);
    edtLabel.Text := qryCadPor.FieldByName('POR_NOMPOR').AsString;
  End
end;

procedure TfrmConfigItauAPI.HideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmConfigItauAPI.ImportaDadosDeAutenticacaoPix;
  Var
    LAutoIncremChavePix,
    LChavePix,
    LEmpresaChavePix: String;

    LDadosChave: TDadosWebhook;

    LSelecionaChavePix: TfrmSelecionaChavePix;

    LDatasetChavePix: TUniClientDataSet;
begin
  If fraGerarPixBoleto.edtGerarPix.Text = 'S' Then
    Exit;

  Try
    pCriarFormularios(TfrmSelecionaChavePix, LSelecionaChavePix);

    Try
      LSelecionaChavePix.CodigoBanco := '341';
      LSelecionaChavePix.ShowModal;

      If LSelecionaChavePix.ModalResult <> mrOK Then
        Exit;

      LAutoIncremChavePix := LSelecionaChavePix.AutoIncremChavePix;
      LChavePix := LSelecionaChavePix.ChavePix;
      LEmpresaChavePix := LSelecionaChavePix.EmpresaChavePix;

      LDadosChave := TFuncoesPixBoleto.ImportarDadosAutenticacao(IIF(LAutoIncremChavePix.IsEmpty, FCarteira + '-' + VS_strCodEmp, LAutoIncremChavePix),
                                                                 LSelecionaChavePix.ChavePix,
                                                                 LSelecionaChavePix.EmpresaChavePix);
    Finally
      FreeAndNil(LSelecionaChavePix);
    End;

    If Not MatchStr(LDadosChave.Status, ['EMITIDO', 'ALTERADO']) Then
    Begin
      If LAutoIncremChavePix.IsEmpty Then
      Begin
        fMensagem('ATENÇÃO', 'A chave Pix digitada não foi liberada para a utilização da API.' + #13 +
                             'É necessário entrar no portal do Itaú e realizar a liberação da chave Pix, ' +
                             'para a utilização no AUTCOM.', ['&Ok']);

        FreeAndNil(LDadosChave);
        Exit;
      End;

      If fMensagem('ATENÇÃO', 'A chave Pix selecionada não foi liberada através do portal do Itaú.' + #13 +
                              'Deseja importar os dados de autorização do Cadastro de Contas Bancárias do Autcom?',
                              ['&Sim', '&Não']) = 2 Then
      Begin
        FreeAndNil(LDadosChave);
        Exit;
      End;

      LDatasetChavePix := TFuncoesPixBoleto.RetornaDatasetDadosChavePix(LAutoIncremChavePix);

      LDadosChave.ClientID := LDatasetChavePix.FieldByName('CCA_CLI_ID').AsString;
      LDadosChave.ClientSecret := LDatasetChavePix.FieldByName('CCA_CLISEC').AsString;
      LDadosChave.CertificadoCrt := LDatasetChavePix.FieldByName('CCA_ARQCRT').AsString;
      LDadosChave.CertificadoKey := LDatasetChavePix.FieldByName('CCA_ARQKEY').AsString;
      LDadosChave.ValidadeCertificado := LDatasetChavePix.FieldByName('CCA_VALCER').AsDateTime;

      LDatasetChavePix.Close;
      FreeAndNil(LDatasetChavePix);
    End;

    If Not ValidaDadosAutenticacaoImportadosPix(LDadosChave) Then
      Exit;

    fGetBancoConfig(1, FCarteira, 'AUTHCRT', LDadosChave.CertificadoCrt);
    edtArquivoCRT.Text := 'certificado cadastrado';

    fGetBancoConfig(1, FCarteira, 'VALCERT', FormatDateTime('dd/mm/yyyy', LDadosChave.ValidadeCertificado));
    lblValidadeCertificado.Caption := FormatDateTime('dd/mm/yyyy', LDadosChave.ValidadeCertificado);

    fGetBancoConfig(1, FCarteira, 'AUTHKEY', LDadosChave.CertificadoKey);
    edtArquivoKEY.Text := 'certificado cadastrado';

    fGetBancoConfig(1, FCarteira, 'CLIENT_ID', LDadosChave.ClientID);
    edtClientID.Text := 'Client ID cadastrado';

    fGetBancoConfig(1, FCarteira, 'CLIENT_SECRET', LDadosChave.ClientSecret);
    edtClientSecret.Text := 'Client Secret cadastrado';

    fMensagem('AVISO', 'Importação dos dados de autenticação Pix foi realizada com sucesso', ['&Ok']);

    FreeAndNil(LDadosChave);
  Except
    On E: Exception Do
    Begin
      fRollback;

      fMensagem('ERRO', E.Message, ['&Ok']);
    End;
  End;
end;

function TfrmConfigItauAPI.PlanoDeContaValido(ACodigo: TMaskEdit;
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
    CarregaCentroCusto(ACodigo.Text, ADescricao);
    If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!'+strMensagemConfig, ['&Ok']);
      Result := False;
    End;
  End;
end;

procedure TfrmConfigItauAPI.LimpaCampos;
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


function TfrmConfigItauAPI.PortadorValido(ACodigo: TEdit; ADescricao: TEdit): Boolean;
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
    CarregaPortador(ACodigo.Text, ADescricao);

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
      fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&Ok']);
      Result := False;
    End;
  End;
end;

procedure TfrmConfigItauAPI.BtnOcorrenciaClick(Sender: TObject);
  Var
    LDetalhe: String;
begin
  inherited;
  HideHint;

  LDetalhe := #13#10 +
              '02 - Atualiza nosso número caso não tenha gravado;' + #13#10 +
              '06 - Baixa duplicata (inclusive paga por Pix);' + #13#10 +
              '23 - Lança histórico de protesto (carteira que importa por situação);' + #13#10 +
              '32 - Baixa por ter sido protestado.' + #13#10 +
              #13#10 +
              'Encargos Bancários (com a configuração ENCBAN ativa). Os valores vêm da ' +
              'francesinha do Itaú, consultada na importação:' + #13#10 +
              '06 - Tarifa de cobrança: lançada no contas a pagar e na movimentação bancária ' +
              'conforme os dados da aba Encargos Bancários;' + #13#10 +
              '02 - Entrada de duplicata descontada: lança o crédito do desconto e a tarifa, o IOF, ' +
              'os juros da operação e a tarifa de contratação, conforme as ocorrências cadastradas no grid;' + #13#10 +
              '06 - Liquidação de duplicata descontada: baixa a duplicata no portador da descontada, ' +
              'sem novo crédito; se paga com atraso, lança os juros;' + #13#10 +
              '48 - Duplicata descontada devolvida para cobrança simples: estorna o desconto e, se o banco ' +
              'debitar mais que o valor do título, lança a diferença como encargo, conforme as ocorrências ' +
              'cadastradas no grid.' + #13#10 +
              #13#10 +
              'As demais ocorrências são gravadas na rotina ' +
              'de retorno e mostradas no relatório apenas em ' +
              'caráter informativo.' + #13#10 +
              #13#10 +
              'Pressione Esc para voltar à tela de configurações.';

  TfrmMemo.pShowMessage('Banco 341 - Itaú [Online] - Detalhamento de Ocorrências.' + #13#10 +
                        LDetalhe);
end;

procedure TfrmConfigItauAPI.PosicionaBotaoValidarDadosAutorizacao;
begin
  btnValidarDadosAutorizacao.Left := 289;
  btnValidarDadosAutorizacao.Top := 525;

  If fraGerarPixBoleto.edtGerarPix.Text = 'S' Then
  Begin
     btnValidarDadosAutorizacao.Left := 140;
     btnValidarDadosAutorizacao.Top := 448;
  End;
end;

procedure TfrmConfigItauAPI.ShowHint(edtEdit: TEditFocus; strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;

function TfrmConfigItauAPI.RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
begin
  While Not Sender.ClassName.Equals('TcxTabSheet') Do
  Begin
    Sender := Sender.Parent;
  End;
  Result := TcxTabSheet(Sender);
end;

function TfrmConfigItauAPI.RetornaDadosCertificadoCRT(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    LOpenSSL,
    LComando,
    LArqPem,
    LPastaOpenSSL: String;

    LDataCertificado: TDateTime;
begin
  Result := True;

  LPastaOpenSSL := RetornaPastaOpenSSL;

  If LPastaOpenSSL.IsEmpty Then
    Exit(False);

  LOpenSSL := LPastaOpenSSL + 'openssl.exe';

  LArqPem  := LPastaOpenSSL + strLoginUsuarioLogado + fGetConnectionID + 'cert.pem';

  pgbStatus.Position := 0;
  pgbStatus.Properties.Max := 2;

  LComando := ' /C ' + LOpenSSL + ' x509 -in "' + edtArquivoCRT.Text + '" ';
  LComando := LComando + ' -noout -enddate > "' + LArqPem + '"';

  DeleteFile(LArqPem);
  Sleep(200);

  If FileExists(LArqPem) Then
  Begin
    fMensagem('ATENÇÃO', 'Apague o arquivo ' + LArqPem + ' para que possa ser gerado um novo.' , ['&Ok'], 0);
    Exit(False);
  End;

  pgbStatus.Position := 1;

  ExecutaComandoWindows('', 'cmd.exe', PWideChar(LComando), '', SW_HIDE, True);
  Sleep(400);

  LDataCertificado := RetornaDataValidadeArquivoPEM(LArqPem);
  If LDataCertificado = 0 Then
  Begin
    fMensagem('ATENÇÃO', 'Não foi possível retornar a validade do certificado selecionado. ' + #13 +
                         'Verifique se é um arquivo válido de certificado.', ['&Ok']);

    Result := False;
  End
  Else
    lblValidadeCertificado.Caption := FormatDateTime('dd/mm/yyyy', LDataCertificado);

  pgbStatus.Position := 2;
  MudaCorDaValidadeDoCertificado;

  DeleteFile(LArqPem);
end;

function TfrmConfigItauAPI.RetornaPastaOpenSSL: String;
  Var
    LOpenSSL: String;
begin
  Result := ExtractFilePath(Application.ExeName) + 'openssl\';

  LOpenSSL := Result + 'openssl.exe';

  If FileExists(LOpenSSL) Then
    Exit;

  Result := ExtractFilePath(Application.ExeName).Replace('\autban', EmptyStr)
                                                .Replace('\Autban', EmptyStr)
                                                .Replace('\AUTBAN', EmptyStr) + 'openssl32\';

  LOpenSSL := Result + 'openssl.exe';

  If FileExists(LOpenSSL) Then
    Exit;

  Result := ExtractFilePath(Application.ExeName).Replace('\autban', EmptyStr)
                                                .Replace('\Autban', EmptyStr)
                                                .Replace('\AUTBAN', EmptyStr) + 'openssl\';
  LOpenSSL := Result + 'openssl.exe';

  If (Not FileExists(LOpenSSL)) Then
  Begin
    fMensagem('ATENÇÃO', 'Não foi possível obter a validade do certificado selecionado, pois o aplicativo openssl não está na pasta do Autcom.' + #13 +
                         'Entre em contato com a Citel!', ['&Ok'], 0);
    Exit('');
  End;
end;

procedure TfrmConfigItauAPI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(qryCadPor);
  FreeAndNil(qryCadEmp);
  FreeAndNil(qryCadFor);
end;

procedure TfrmConfigItauAPI.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  qryCadEmp := fCriaQuery(Self);
  qryCadFor := fCriaQuery(Self);

  fraGerarPixBoleto.CarregarChavesPix('341');

  pCarKeyAutBan;
  cxPaginas.Properties.ActivePage := tbsGeral;
end;

procedure TfrmConfigItauAPI.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigItauAPI.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  HideHint;
end;

procedure TfrmConfigItauAPI.btnAddOcoClick(Sender: TObject);
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
  CarregaOcorrencias;
end;

procedure TfrmConfigItauAPI.btnArquivoCRTClick(Sender: TObject);
  Var
    LCaixaDialogo: TOpenDialog;

    LGravando: TfrmGravando;
begin
  LCaixaDialogo := TOpenDialog.Create(nil);
  try
    LCaixaDialogo.Title := 'Selecione o arquivo CRT';

    LCaixaDialogo.Options := [ofPathMustExist];

    LCaixaDialogo.Filter := 'Certificado CRT|*.crt';

    If LCaixaDialogo.Execute Then
    Begin
      edtArquivoCRT.Text := LCaixaDialogo.FileName;

      pCriarFormularios(TfrmGravando, LGravando);
      LGravando.lblGravando.Caption := 'Aguarde... Carregando Arquivo CRT.';
      LGravando.fExecutarAcao := RetornaDadosCertificadoCRT;
      LGravando.ShowModal;
      FreeAndNil(LGravando);
    End;
  finally
    LCaixaDialogo.Free;
  end;
end;

procedure TfrmConfigItauAPI.btnArquivoKeyClick(Sender: TObject);
  Var
    LCaixaDialogo: TOpenDialog;
begin
  LCaixaDialogo := TOpenDialog.Create(nil);
  try
    LCaixaDialogo.Title := 'Selecione o arquivo KEY';

    LCaixaDialogo.Options := [ofPathMustExist];

    LCaixaDialogo.Filter := 'Certificado KEY|*.key';

    If LCaixaDialogo.Execute Then
      edtArquivoKey.Text := LCaixaDialogo.FileName;
  finally
    LCaixaDialogo.Free;
  end;
end;

procedure TfrmConfigItauAPI.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&Sim', '&Não'], 2) = 1 then
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
    CarregaDados;
    pSetFocus(btnEditar);
  end;
end;

procedure TfrmConfigItauAPI.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    HideHint;

    pCriarFormularios(TfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '341';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigItauAPI.CarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Código Carteira           :' + fGetBancoConfig(0, FCarteira, 'NUMCART', ''));
  stlCampos.Add('Observação 1              :' + fGetBancoConfig(0, FCarteira, 'OBSERV1', ''));
  stlCampos.Add('Observação 2              :' + fGetBancoConfig(0, FCarteira, 'OBSERV2', ''));
  stlCampos.Add('Observação 3              :' + fGetBancoConfig(0, FCarteira, 'OBSERV3', ''));
  stlCampos.Add('Observação 4              :' + fGetBancoConfig(0, FCarteira, 'OBSERV4', ''));
  stlCampos.Add('Observação 5              :' + fGetBancoConfig(0, FCarteira, 'OBSERV5', ''));
  stlCampos.Add('Dias p/ protesto          :' + fGetBancoConfig(0, FCarteira, 'DIAPROT', ''));
  stlCampos.Add('Dias p/ crédito           :' + fGetBancoConfig(0, FCarteira, 'DIACRED', ''));
  stlCampos.Add('Percentual Multa          :' + fGetBancoConfig(0, FCarteira, 'PERMULT', ''));
  stlCampos.Add('Dias para Negativação     :' + fGetBancoConfig(0, FCarteira, 'DIANEGA', ''));
  stlCampos.Add('Protocolo Aceite          :' + fGetBancoConfig(0, FCarteira, 'PROACEI', ''));
  stlCampos.Add('Simulação                 :' + fGetBancoConfig(0, FCarteira, 'SIMULACAO', ''));
  stlCampos.Add('Homologação               :' + fGetBancoConfig(0, FCarteira, 'HOMOLOGACAO', ''));

  stlCampos.Add('Código Agência            :' + fGetBancoConfig(0, FCarteira, 'CODAGEN', ''));
  stlCampos.Add('Operador Bankline         :' + fGetBancoConfig(0, FCarteira, 'OPE_BANKLINE', ''));
  stlCampos.Add('Num. C. Corrente          :' + fGetBancoConfig(0, FCarteira, 'NUMCTAC', ''));
  stlCampos.Add('Díg. C. Corrente          :' + fGetBancoConfig(0, FCarteira, 'DIGCTAC', ''));

  stlCampos.Add('Portador Cob. Simples     :' + fGetBancoConfig(0, FCarteira, 'PORBAI_', ''));
  stlCampos.Add('Pla. Contas Cob. Simples  :' + fGetBancoConfig(0, FCarteira, 'CTABAI_', ''));
  stlCampos.Add('Portador Cob. Vinculada   :' + fGetBancoConfig(0, FCarteira, 'PORBAI_VIN', ''));
  stlCampos.Add('Pla. Contas Cob. Vinculada:' + fGetBancoConfig(0, FCarteira, 'CTABAI_VIN', ''));
  stlCampos.Add('Dias corridos para recebimento após o vencimento:' + fGetBancoConfig(0, FCarteira, 'DIALIMI', ''));

  stlCampos.Add('Enc.Ban. Vr Tarifa:' + fGetBancoConfig(0, FCarteira, 'VALOTAR', ''));
  stlCampos.Add('Enc.Ban. Portador :' + fGetBancoConfig(0, FCarteira, 'PORTTAR', ''));
  stlCampos.Add('Enc.Ban. Pl Conta :' + fGetBancoConfig(0, FCarteira, 'CONTTAR', ''));
  stlCampos.Add('Portador Descontadas:' + fGetBancoConfig(0, FCarteira, 'PORTDES', ''));
  stlCampos.Add('Utilizar Portador de Dupl. Descontada no Portador de Baixa:' + fGetBancoConfig(0, FCarteira, 'PORDESPORBAI', ''));

  stlCampos.Add('Gera Pix QRCode :' + fGetBancoConfig(0, FCarteira, 'GERAPIX', ''));
  stlCampos.Add('Chave Pix       :' + fGetBancoConfig(0, FCarteira, 'CHAPIX', ''));
  stlCampos.Add('Certificado CRT :' + fGetBancoConfig(0, FCarteira, 'AUTHCRT', ''));
  stlCampos.Add('Certificado KEY :' + fGetBancoConfig(0, FCarteira, 'AUTHKEY', ''));
  stlCampos.Add('Validade Certific.:' + fGetBancoConfig(0, FCarteira, 'VALCERT', ''));
  stlCampos.Add('Client ID         :' + fGetBancoConfig(0, FCarteira, 'CLIENT_ID', ''));
  stlCampos.Add('Client Secret     :' + fGetBancoConfig(0, FCarteira, 'CLIENT_SECRET', ''));

  stlCampos.Add('Código Carteira Vinculada :' + fGetBancoConfig(0, FCarteira, 'NUMCARTVINC', ''));
  stlCampos.Add('Código Agência Vinculada  :' + fGetBancoConfig(0, FCarteira, 'CODAGENVINC', ''));
  stlCampos.Add('Num. C. Corrente Vinculada:' + fGetBancoConfig(0, FCarteira, 'NUMCTACVINC', ''));
  stlCampos.Add('Díg. C. Corrente Vinculada:' + fGetBancoConfig(0, FCarteira, 'DIGCTACVINC', ''));
  stlCampos.Add('Portador da Conta Vinculada:' + fGetBancoConfig(0, FCarteira, 'PORBAIVINC', ''));
end;

procedure TfrmConfigItauAPI.fraGerarPixBoletocmbChavePixPropertiesEditValueChanged(
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
  CarregaPortador(edtCodPor.Text, edtDesPor);
End;

procedure TfrmConfigItauAPI.fraGerarPixBoletoedtGerarPixChange(Sender: TObject);
begin
  inherited;
  fraGerarPixBoleto.edtGerarPixChange(Sender);

  grpDadosAutorizacao.Visible := fraGerarPixBoleto.edtGerarPix.Text = 'N';

  PosicionaBotaoValidarDadosAutorizacao;
end;

procedure TfrmConfigItauAPI.fraPlanoDeContasEncMskCodCtaKeyPress(
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

function TfrmConfigItauAPI.RetStrCfg(stlCfg : TStringList) : String;
Var
  intCont : Integer;
begin
  Result := '';

  For intCont := 0 To stlCfg.Count - 1 Do
    Result := Result + stlCfg.Strings[intCont] + #13+#10;
end;

procedure TfrmConfigItauAPI.GravaLogCarteira(stlCfgAnt : TStringList);
Var
  stlCfgAtu: TStringList;
  strCmpAlt: String;
  intCont,
  intIndice: Integer;
begin
  stlCfgAtu := TStringList.Create;
  CarregaCfg(stlCfgAtu);
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
    pGravaLogAtb('341', 'ITAÚ [Online]', FCarteira + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, RetStrCfg(stlCfgAnt), RetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;


end.
