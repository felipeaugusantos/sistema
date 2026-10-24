unit untConfigSicrediAPI;

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
  cxDBLookupComboBox, untFrameGerarPixBoleto, untTBancoSicrediAPI,
  untFrameNegativacaoUF;

type
  TfrmConfigSicrediAPI = class(TfrmPai)
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
    Label13: TLabel;
    Label14: TLabel;
    Label25: TLabel;
    edtDiasProt: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    edtDiasCred: TEditFocus;
    edtPerMul: TEditFocus;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    edtQtdDiasDataLimiteRec: TEditFocus;
    Label35: TLabel;
    edtQtdDiasNega: TEditFocus;
    pnlChaveConexao: TPanel;
    Label8: TLabel;
    Label3: TLabel;
    edtChaveAppDev: TEditFocus;
    Label15: TLabel;
    edtProAce: TEditFocus;
    ColorLabel3: TColorLabel;
    cxTabDadosBaixa: TcxTabSheet;
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
    Label7: TLabel;
    cmbTpDocto: TcxComboBox;
    Label16: TLabel;
    cmbTpCobranca: TcxComboBox;
    Label18: TLabel;
    edtPosto: TEditFocus;
    Label19: TLabel;
    edtQtdeDiasValidade: TEditFocus;
    cmbTipoDesconto: TComboBoxFocus;
    cmbTipoJuros: TComboBoxFocus;
    Label5: TLabel;
    Label6: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    cmbAmbiente: TcxComboBox;
    edtPassword: TEditFocus;
    edtCodAgencia: TEditFocus;
    Label23: TLabel;
    edtContaCorr: TEditFocus;
    lblCodAgenc: TLabel;
    Label1: TLabel;
    btnValidaAcesso: TBitBtnLocked;
    fraGerarPixBoletoSicredi: TfraGerarPixBoleto;
    Label2: TLabel;
    edtConsiderarDiasCreditoPix: TEditFocus;
    ColorLabel1: TColorLabel;
    lblBaixarBoletosArquivo: TLabel;
    lblBaixarBoletosArquivoSN: TColorLabel;
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
    lblImportarEmpresas: TLabel;
    lblImportarEmpresasSN: TColorLabel;
    edtImportarEmpresas: TEditFocus;
    edtBaixarBoletosArquivo: TEditFocus;
    tsComplementos: TcxTabSheet;
    pnlComplemento: TPanel;
    lblPerImpBol: TLabel;
    clbPerImpBol: TColorLabel;
    edtPerImpBol: TEditFocus;
    lblImpOtimizada: TLabel;
    edtImpOtimizada: TEditFocus;
    clImpOtimizada: TColorLabel;
    frmNegativacaoUF: TfrmNegativacaoUF;
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
    procedure edtChaveAppDevEnter(Sender: TObject);
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
    procedure fraGerarPixBoletoSicredicmbChavePixPropertiesEditValueChanged(
      Sender: TObject);
    procedure cmbTpCobrancaPropertiesEditValueChanged(Sender: TObject);
    procedure edtContaCorrEnter(Sender: TObject);
    procedure edtContaCorrExit(Sender: TObject);
    procedure edtContaCorrMouseEnter(Sender: TObject);
    procedure edtContaCorrMouseLeave(Sender: TObject);
    procedure edtImportarEmpresasEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtImportarEmpresasChange(Sender: TObject);

  private

    qryCadPor : TUniQuery;
    qryCadEmp : TUniQuery;
    qryCadCta : TUniQuery;
    qryCadFor : TUniQuery;

    cdsCnfOco: TUniClientDataset;

    LBancoSicrediAPI: TBancoSicrediAPI;

    FCarteira: String;

    procedure pCarregadados;
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
    procedure CarregaTipoDocumento;

    { Private declarations }
  public
    { Public declarations }
    blnNaoEditar : Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;

  end;

implementation

uses  untfuncoesSimples, untPesqAux, untFuncoes,
     untCfgGenericas_AutBan, untConsultas, untCadOcoCartei,
     untCNFOCO_Class, untCNFOCO_Dao, untFuncAutban;

{$R *.dfm}

{ TfrmPai1 }

procedure TfrmConfigSicrediAPI.pCarregadados;
begin

  frmNegativacaoUF.CarregarPorCarteira(
    'CONFIG748API-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp,
    '748',
    VS_strCodEmp
  );
  
  pLimpaCampos;

  FCarteira := 'CONFIG748API-' + IntToStr(tabCarteira.TabIndex + 1);

  fraGerarPixBoletoSicredi.CarregarChavesPix('748');

  CarregaLancamentoTarifaBancaria;
  CarregaTipoDocumento;

  edtCodAgencia.Text           := fGetBancoConfig(0, FCarteira, 'CODAGEN', '');
  edtContaCorr.Text            := fGetBancoConfig(0, FCarteira, 'NUMCTAC', '');
  edtPosto.Text                := fGetBancoConfig(0, FCarteira, 'POSTO'  , '');                  //POSTO;
  cmbtpDocto.ItemIndex         := StrToInt(fGetBancoConfig(0, FCarteira, 'TIPO_DOCTO',    '0')); //TIPO DE DOCUMENTO
  cmbtpCobranca.ItemIndex      := StrToInt(fGetBancoConfig(0, FCarteira, 'TIPO_COBRANCA', '0')); //TIPO DE BOLETO -> 0 - NORMAL; 1 - HIBRIDO;
  cmbTipoDesconto.ItemIndex    := StrToInt(fGetBancoConfig(0, FCarteira, 'TIPO_DESC',     '0')); //TIPO DESCONTO
  cmbTipoJuros.ItemIndex       := StrToInt(fGetBancoConfig(0, FCarteira, 'TIPO_JUROS',    '0')); //TIPO JUROS
  edtPassword.Text             := fGetBancoConfig(0, FCarteira, 'PASSWORD', '');                 //PASSWORD;

  edtDiasProt.Text             := fGetBancoConfig(0, FCarteira, 'DIAPROT', '');
  edtQtdDiasNega.Text          := fGetBancoConfig(0, FCarteira, 'DIANEGA', '');
  edtQtdeDiasValidade.Text     := fGetBancoConfig(0, FCarteira, 'QTDIASVAL', '');  // QTDE DE DIAS QUE O QR CODE É VALIDO APOS O VENCIMENTO
  edtQtdDiasDataLimiteRec.Text := fGetBancoConfig(0, FCarteira, 'DIALIMI', '');
  edtObservacao1.Text          := fGetBancoConfig(0, FCarteira, 'OBSERV1', '');
  edtObservacao2.Text          := fGetBancoConfig(0, FCarteira, 'OBSERV2', '');
  edtObservacao3.Text          := fGetBancoConfig(0, FCarteira, 'OBSERV3', '');
  edtObservacao4.Text          := fGetBancoConfig(0, FCarteira, 'OBSERV4', '');
  edtObservacao5.Text          := fGetBancoConfig(0, FCarteira, 'OBSERV5', '');
  edtCodPor.Text               := fGetBancoConfig(0, FCarteira, 'PORBAI_', '');
  edtCodPorVin.Text            := fGetBancoConfig(0, FCarteira, 'PORBAI_VIN', '');
  edtImportarEmpresas.Text     := fGetBancoConfig(0, FCarteira, 'IMPORTEMP', 'N');
  edtImpOtimizada.Text     := fGetBancoConfig(0, FCarteira, 'IMPOTIMIZADA', 'N');
  edtBaixarBoletosArquivo.Text := fGetBancoConfig(0, FCarteira, 'BAIBOLARQ', 'N');

  If edtImportarEmpresas.Text = EmptyStr Then
    edtImportarEmpresas.Text   := 'N';

  If edtImpOtimizada.Text = EmptyStr Then
    edtImpOtimizada.Text   := 'N';

  If edtBaixarBoletosArquivo.Text = EmptyStr Then
    edtBaixarBoletosArquivo.Text   := 'N';

  fraPlanoDeContasBai.MskCodCta.Text := fGetBancoConfig(0, FCarteira, 'CTABAI_', '');
  fraPlanoDeContasVin.MskCodCta.Text := fGetBancoConfig(0, FCarteira, 'CTABAI_VIN', '');

  edtPerMul.Text               := fGetBancoConfig(0, FCarteira, 'PERMULT', '');
  edtDiasCred.Text             := fGetBancoConfig(0, FCarteira, 'DIACRED', '');
  edtProAce.Text               := fGetBancoConfig(0, FCarteira, 'PROACEI', '');

  edtConsiderarDiasCreditoPix.Text := fGetBancoConfig(0, FCarteira, 'CDIACREPIX', 'S');

  If edtConsiderarDiasCreditoPix.Text = EmptyStr Then
    edtConsiderarDiasCreditoPix.Text   := 'S';

  edtChaveAppDev.Clear;
  If (fGetBancoConfig(0, FCarteira, 'KEY_USER', '') <> '') Then
    edtChaveAppDev.Text     := 'Chave App cadastrada';

  cmbAmbiente.ItemIndex := StrToInt(fGetBancoConfig(0, FCarteira, 'TPAMBIENTE', '0'));

  edtPorTar.Text        := fGetBancoConfig(0, FCarteira, 'PORTTAR', '');
  fraPlanoDeContasEnc.MskCodCta.Text := fGetBancoConfig(0, FCarteira, 'CONTTAR', '');
  edtForTar.Text        := fGetBancoConfig(0, FCarteira, 'FORNTAR', '');
  edtValorTarifa.Text   := fGetBancoConfig(0, FCarteira, 'VALOTAR', '');
  edtPerImpBol.Text     := fGetBancoConfig(0, FCarteira, 'PERIMPBOL', '');

  If fEmptyStr(edtPerImpBol.Text) Then
    edtPerImpBol.Text := 'S';

  fraGerarPixBoletoSicredi.edtGerarPix.Text := IIF(cmbTpCobranca.ItemIndex > 0, 'S', 'N');
  fraGerarPixBoletoSicredi.cmbChavePix.EditValue := fGetBancoConfig(0, FCarteira, 'CHAPIX', '');
  fraGerarPixBoletoSicredi.cmbChavePix.Enabled := False;

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

procedure TfrmConfigSicrediAPI.CarregaTipoDocumento;
  Var
    LOpcao : String;
begin

  Try
    LOpcao := LeftSTr(fGetBancoConfig(0, FCarteira, 'TIPO_DOCTO', ''),2);

    If LOpcao = 'A' Then
       cmbTpDocto.ItemIndex := 0
    Else If LOpcao = 'B' Then
       cmbTpDocto.ItemIndex := 1
    Else If LOpcao = 'C' Then
       cmbTpDocto.ItemIndex := 2
    Else If LOpcao = 'D' Then
       cmbTpDocto.ItemIndex := 3
    Else If LOpcao = 'E' Then
       cmbTpDocto.ItemIndex := 4
    Else If LOpcao = 'G' Then
       cmbTpDocto.ItemIndex := 5
    Else If LOpcao = 'H' Then
       cmbTpDocto.ItemIndex := 6
    Else If LOpcao = 'I' Then
       cmbTpDocto.ItemIndex := 7
    Else If LOpcao = 'J' Then
       cmbTpDocto.ItemIndex := 8
    Else If LOpcao = 'K' Then
       cmbTpDocto.ItemIndex := 9
    Else If LOpcao = 'O' Then
       cmbTpDocto.ItemIndex := 10
    Else If LOpcao = 'P' Then
       cmbTpDocto.ItemIndex := 11;

  Except
    cmbTpDocto.ItemIndex := -1;
  End;

end;

procedure TfrmConfigSicrediAPI.pCarregaOcorrencias;
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
  cdsCnfOco.Open;
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
      cdsCnfOco.FieldByName('CNF_CODOCO').AsString := objCnfOco.strCodOco;
      cdsCnfOco.FieldByName('CNF_DESOCO').AsString := objCnfOco.strDesOco;
      cdsCnfOco.FieldByName('CNF_MOTOCO').AsString := objCnfOco.strMotOco;
      cdsCnfOco.FieldByName('CNF_GERPAG').Value    := objCnfOco.blnGerpag;
      cdsCnfOco.FieldByName('CNF_CUSCAR').Value    := objCnfOco.blnCusCar;
      cdsCnfOco.FieldByName('CNF_USADIA').Value    := objCnfOco.blnUsaDia;
      cdsCnfOco.FieldByName('CNF_FORNEC').AsString := objCnfOco.strCodFor + ' - ' + fRetNomFornecedor(objCnfOco.strCodFor);
      cdsCnfOco.FieldByName('CNF_PORTAD').AsString := objCnfOco.strCodPor + ' - ' + fRetNomPortador(objCnfOco.strCodPor);
      cdsCnfOco.FieldByName('CNF_PLNCON').AsString := objCnfOco.strCodCta + ' - ' + fRetDescCentroCusto(objCnfOco.strCodCta);
      cdsCnfOco.FieldByName('CNF_TIPDES').AsInteger:= objCnfOco.IntTipDes;
      Case objCnfOco.IntTipDes of
        0: cdsCnfOco.FieldByName('CNF_DSTPDS').AsString := '';
        1: cdsCnfOco.FieldByName('CNF_DSTPDS').AsString := 'TARIFA IOF DESCONTO';
        2: cdsCnfOco.FieldByName('CNF_DSTPDS').AsString := 'TARIFA BOLETO DESC';
        3: cdsCnfOco.FieldByName('CNF_DSTPDS').AsString := 'TARIFA DESCONTADA';
      End;
      cdsCnfOco.Post;
    End;
  End;

  lstCnfOco.Free;
  objCnfDao.Free;

  cdsCnfOco.First;
  cdsCnfOco.EnableControls;
end;
procedure TfrmConfigSicrediAPI.FormShow(Sender: TObject);
begin
  inherited;
  tbsEncBan.TabVisible := fCfgSis('ENCBAN', varBoolean);
  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);

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

  frmNegativacaoUF.Editavel := False;
end;

procedure TfrmConfigSicrediAPI.btnEditarClick(Sender: TObject);
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

    fraGerarPixBoletoSicredi.edtGerarPix.OnChange(fraGerarPixBoletoSicredi.edtGerarPix);

    //pSetFocus(cmbCodCar);
    pSetFocus(edtCodAgencia);

    frmNegativacaoUF.Editavel := True;

  end;
end;


procedure TfrmConfigSicrediAPI.btnEdtOcoClick(Sender: TObject);
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
    frmCadOcoCartei.edtCodOco.Text      := cdsCnfOco.FieldByName('CNF_CODOCO').AsString;
    frmCadOcoCartei.edtMotOco.Text      := cdsCnfOco.FieldByName('CNF_MOTOCO').AsString;
    frmCadOcoCartei.fraPlanoDeContasOco.MskCodCta.Text := Copy(cdsCnfOco.FieldByName('CNF_PLNCON').AsString,1,7);
    frmCadOcoCartei.cmbTipDes.ItemIndex := cdsCnfOco.FieldByName('CNF_TIPDES').AsInteger;
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

procedure TfrmConfigSicrediAPI.btnGravarClick(Sender: TObject);
Var
  stlCfgAnt : TStringList;
begin
  inherited;
  If fVerificaCampos Then
  Begin

    Try

      If Not frmNegativacaoUF.Salvar Then
        Exit;

      stlCfgAnt := TStringList.Create;
      Try
        pCarregaCfg(stlCfgAnt);

        fGetBancoConfig(1, FCarteira, 'CODAGEN', edtCodAgencia.Text);  //cooperativa
        fGetBancoConfig(1, FCarteira, 'NUMCTAC', edtContaCorr.Text);   //beneficiario
        fGetBancoConfig(1, FCarteira, 'IDENTBC', edtContaCorr.Text);   //beneficiario
        fGetBancoConfig(1, FCarteira, 'POSTO', edtPosto.Text);
        fGetBancoConfig(1, FCarteira, 'TIPO_DOCTO', IntToStr(cmbTpDocto.ItemIndex));       // DUP. MERCANTIL; DUP.RURAL; NOTA PROMISSORIA, ETC.;
        fGetBancoConfig(1, FCarteira, 'TIPO_COBRANCA', IntToStr(cmbTpCobranca.ItemIndex)); // NORMAL; HIBRIDO;

        fGetBancoConfig(1, FCarteira, 'TIPO_DESC', IntToStr(cmbTipoDesconto.ItemIndex));   // TIPO DESCONTO
        fGetBancoConfig(1, FCarteira, 'TIPO_JUROS', IntToStr(cmbTipoJuros.ItemIndex));     // TIPO JUROS
        fGetBancoConfig(1, FCarteira, 'PASSWORD', edtPassword.Text);

        fGetBancoConfig(1, FCarteira, 'RESPONS', 'E');

        fGetBancoConfig(1, FCarteira, 'DIAPROT', edtDiasProt.Text);
        fGetBancoConfig(1, FCarteira, 'DIANEGA', edtQtdDiasNega.Text);
        fGetBancoConfig(1, FCarteira, 'QTDIASVAL', edtQtdeDiasValidade.Text);
        fGetBancoConfig(1, FCarteira, 'OBSERV1', edtObservacao1.Text);
        fGetBancoConfig(1, FCarteira, 'OBSERV2', edtObservacao2.Text);
        fGetBancoConfig(1, FCarteira, 'OBSERV3', edtObservacao3.Text);
        fGetBancoConfig(1, FCarteira, 'OBSERV4', edtObservacao4.Text);
        fGetBancoConfig(1, FCarteira, 'OBSERV5', edtObservacao5.Text);
        fGetBancoConfig(1, FCarteira, 'PORBAI_', edtCodPor.Text);
        fGetBancoConfig(1, FCarteira, 'PORBAI_VIN', edtCodPorVin.Text);
        fGetBancoConfig(1, FCarteira, 'IMPORTEMP', edtImportarEmpresas.Text);
        fGetBancoConfig(1, FCarteira, 'IMPOTIMIZADA', edtImpOtimizada.Text);

        If edtImportarEmpresas.Text = 'S' Then
          fGetBancoConfig(1, FCarteira, 'BAIBOLARQ', edtBaixarBoletosArquivo.Text)
        Else
          fGetBancoConfig(1, FCarteira, 'BAIBOLARQ', 'N');

        fGetBancoConfig(1, FCarteira, 'CTABAI_', fraPlanoDeContasBai.mskCodCta.Text);
        fGetBancoConfig(1, FCarteira, 'CTABAI_VIN', fraPlanoDeContasVin.mskCodCta.Text);

        fGetBancoConfig(1, FCarteira, 'PERMULT', edtPerMul.Text);
        fGetBancoConfig(1, FCarteira, 'DIACRED', edtDiasCred.Text);
        fGetBancoConfig(1, FCarteira, 'DIALIMI', edtQtdDiasDataLimiteRec.Text);
        fGetBancoConfig(1, FCarteira, 'PROACEI', edtProAce.Text       );

        fGetBancoConfig(1, FCarteira, 'TPAMBIENTE', Inttostr(cmbAmbiente.ItemIndex));

        If Not MatchStr(edtChaveAppDev.Text, ['', 'Chave App cadastrada']) Then
          fGetBancoConfig(1, FCarteira, 'KEY_USER', edtChaveAppDev.Text);

        fGetBancoConfig(1, FCarteira, 'PORTTAR', edtPorTar.Text    );
        fGetBancoConfig(1, FCarteira, 'CONTTAR', fraPlanoDeContasEnc.MskCodCta.Text);
        fGetBancoConfig(1, FCarteira, 'FORNTAR', edtForTar.Text    );
        fGetBancoConfig(1, FCarteira, 'VALOTAR', edtValorTarifa.Text  );
        fGetBancoConfig(1, FCarteira, 'LANTX02', IIF(cmbLancarTarifa.ItemIndex = 1, '02', '06'));

        fGetBancoConfig(1, FCarteira, 'CHAPIX', IIF(cmbTpCobranca.ItemIndex <= 0, '', fraGerarPixBoletoSicredi.cmbChavePix.EditValue));
        fGetBancoConfig(1, FCarteira, 'PERIMPBOL', edtPerImpBol.Text);

        fGetBancoConfig(1, FCarteira, 'CDIACREPIX', edtConsiderarDiasCreditoPix.Text);

        If Not (btnGravar.Caption = '&OK') Then
        Begin
          fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
          pSetFocus(edtCodAgencia);
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
      Finally
        If Assigned(stlCfgAnt) Then
          FreeAndNil(stlCfgAnt);
      End;

    Except
      On E:Exception Do
      Begin
        fMensagem('Erro','Ocorreu um erro ao tentar salvar os dados.' + #13 + E.Message,['&O K']);
      End;
    End;

  End;
end;


procedure TfrmConfigSicrediAPI.btnRemOcoClick(Sender: TObject);
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

      objCnfOco := objCnfDao.fBuscaPorOcorrencia(cdsCnfOco.FieldByName('CNF_CODOCO').AsString,
                                                 cdsCnfOco.FieldByName('CNF_MOTOCO').AsString,
                                                 Copy(cdsCnfOco.FieldByName('CNF_PLNCON').AsString,1,7),
                                                 cdsCnfOco.FieldByName('CNF_TIPDES').AsInteger);
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

procedure TfrmConfigSicrediAPI.CarregaFornecedor;
begin
  edtDesForTar.Clear;
  If Not fEmptyStr( edtForTar.Text ) Then
  begin
    pPesquisaCadFor(qryCadFor, qryCadFor, edtForTar.Text);
    edtDesForTar.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
  end;
end;

procedure TfrmConfigSicrediAPI.CarregaLancamentoTarifaBancaria;
begin
  Case StrToIntDef(fGetBancoConfig(0, FCarteira, 'LANTX02', '06'),-1) Of
    06 : cmbLancarTarifa.ItemIndex := 0;
    02 : cmbLancarTarifa.ItemIndex := 1;
  End;
end;

procedure TfrmConfigSicrediAPI.cmbContaCaucaoExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSicrediAPI.cmbContaCaucaoMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSicrediAPI.cmbTpCobrancaPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  fraGerarPixBoletoSicredi.edtGerarPix.Text := IIF(cmbTpCobranca.ItemIndex <= 0, 'N', 'S');
end;

function TfrmConfigSicrediAPI.fValidaCampos(Sender: TWinControl;
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
        if Length(edtContaCorr.Text) <> 5 then
        begin
          fMensagem('ATENÇÃO','O campo Conta Corrente deve ter 5 caracteres. Caso tenha 0 (zero) favor informar!' + strMensagemConfig,['&OK']);
          Result := False;
        end;
      end;
    End

    Else If (Sender = edtPosto) Then
    Begin
      If fEmptyStr(edtPosto.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Posto da agência deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End
      Else If Length(edtPosto.Text) <> edtPosto.MaxLength Then
      Begin
        fMensagem('ATENÇÃO!','O campo posto deve ter 2 caracteres!'+strMensagemConfig, ['&OK']);
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

    Else If (Sender = edtChaveAppDev) Then
    Begin
      If fEmptyStr(edtChaveAppDev.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Chave APP deve ser preenchido!'+strMensagemConfig, ['&OK']);
        Result := False;
      End
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

    Else If (Sender = edtDiasProt) Then
    Begin
      If Not fEmptyStr(edtDiasProt.Text) And (StrToIntDef(edtDiasProt.Text, 0) <> 0)  Then
      Begin
        // Verifica se o campo Dias Negativação está preenchido e é diferente de zero
        If (Not fEmptyStr(edtQtdDiasNega.Text)) And (StrToIntDef(edtQtdDiasNega.Text, 0) <> 0) Then
        Begin
          fMensagem('ATENÇÃO',
            'O Sicredi não permite o envio simultâneo de protesto e negativação.' + strMensagemConfig,
            ['&OK']);
          Result := False;
        End

        // Verifica se o campo Dias Negativação MS está preenchido e é diferente de zero
        Else If frmNegativacaoUF.ExisteNegativacaoConfigurada Then
        Begin
          fMensagem('ATENÇÃO',
            'O Sicredi não permite o envio simultâneo de protesto e negativação.' + strMensagemConfig,
            ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtConsiderarDiasCreditoPix) And (edtConsiderarDiasCreditoPix.Enabled) Then
    Begin
      If Not MatchStr(edtConsiderarDiasCreditoPix.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO','O campo Considerar dias crédito pix deve ser preenchido com S ou N!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If Sender = edtImportarEmpresas Then
    Begin
      If Not MatchStr(edtImportarEmpresas.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO','O campo Importar boletos de outras carteiras deve ser preenchido com S ou N!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End


    Else If Sender = edtImpOtimizada Then
    Begin
      If Not MatchStr(edtImpOtimizada.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO','O campo utilizar importação de boletos otimizada deve ser preenchido com S ou N!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtBaixarBoletosArquivo) And (edtBaixarBoletosArquivo.Enabled) Then
    Begin
      If Not MatchStr(edtBaixarBoletosArquivo.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO','O campo Baixar boletos gerados por arquivo remessa deve ser preenchido com S ou N!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If Sender = fraGerarPixBoletoSicredi.cmbChavePix Then
    Begin
      If cmbTpCobranca.ItemIndex > 0 Then
      Begin
        If VarToString(fraGerarPixBoletoSicredi.cmbChavePix.EditValue).IsEmpty Then
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

procedure TfrmConfigSicrediAPI.InformaTipoAPP;
  Var
    KeyUser : String;
begin
  If edtChaveAppDev.Text = 'Chave App cadastrada' Then
    KeyUser := fGetBancoConfig(0, FCarteira, 'KEY_USER', '')
  Else
   KeyUser := edtChaveAppDev.Text;

end;

procedure TfrmConfigSicrediAPI.lblValidaOcoMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSicrediAPI.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregadados;
  cxPaginas.ActivePage := tbsGeral;
end;

procedure TfrmConfigSicrediAPI.tabCarteiraChanging(Sender: TObject;
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


procedure TfrmConfigSicrediAPI.edtChaveAppDevEnter(Sender: TObject);
begin
  inherited;
  If edtChaveAppDev.Text = 'Chave App cadastrada' Then
    edtChaveAppDev.Clear;
end;

procedure TfrmConfigSicrediAPI.edtChaveAppDevExit(Sender: TObject);
begin
  inherited;

  If  fEmptyStr(edtChaveAppDev.Text) And
      (fGetBancoConfig(0, FCarteira, 'KEY_USER', '') <> '') Then
    edtChaveAppDev.Text     := 'Chave App cadastrada';

  InformaTipoAPP;
end;

procedure TfrmConfigSicrediAPI.edtCodPorKeyPress(Sender: TObject;
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

procedure TfrmConfigSicrediAPI.edtCodPorVinKeyPress(Sender: TObject;
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


procedure TfrmConfigSicrediAPI.edtContaCorrEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtDiasCred, 'Informar o código do beneficiário.');

  pShowHint(edtContaCorr, 'Conta corrente');
end;

procedure TfrmConfigSicrediAPI.edtContaCorrExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSicrediAPI.edtContaCorrMouseEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtDiasCred, 'Informar o código do beneficiário.');

  pShowHint(edtContaCorr, 'Conta corrente');
end;

procedure TfrmConfigSicrediAPI.edtContaCorrMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSicrediAPI.edtDiasCredEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtDiasCred, 'Informar quantidade de dias ' + #13+#10 +
                           'do intervalo entre a efetuação ' + #13+#10 +
                           'do pagamento e o crédito na ' + #13+#10 +
                           'conta corrente.');

  pShowHint(edtDiasCred, 'Dias para Crédito');
end;

procedure TfrmConfigSicrediAPI.edtDiasCredExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;


procedure TfrmConfigSicrediAPI.edtDiasProtEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtDiasProt, 'Quantidade de dias após a data de vencimento ' + #13+#10 +
                           'do boleto para iniciar o processo de cobrança ' + #13+#10 +
                           'através de protesto.');


  pShowHint(edtDiasProt, 'Dias para Protesto');
end;

procedure TfrmConfigSicrediAPI.edtDiasProtExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSicrediAPI.edtForTarKeyPress(Sender: TObject;
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

procedure TfrmConfigSicrediAPI.edtImportarEmpresasChange(Sender: TObject);
begin
  inherited;
  edtBaixarBoletosArquivo.Enabled := edtImportarEmpresas.Text = 'S';
  lblBaixarBoletosArquivo.Enabled := edtImportarEmpresas.Text = 'S';
  lblBaixarBoletosArquivoSN.Enabled := edtImportarEmpresas.Text = 'S';
end;

procedure TfrmConfigSicrediAPI.edtImportarEmpresasEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtImportarEmpresas, 'Quando essa configuração estiver "S", ao importar ' + #13+#10 +
                                   'os boletos do Sicredi API, o sistema irá importar ' + #13+#10 +
                                   'os boletos de todas as carteiras API de todas as lojas. ' + #13+#10 +
                                   'ATENÇÃO: Isso pode gerar lentidão no processo de importação.');

  pShowHint(edtImportarEmpresas, 'Importar boletos de outras carteiras');
end;

procedure TfrmConfigSicrediAPI.edtPerMulExit(Sender: TObject);
begin
  inherited;
   If Not fEmptyStr(edtPerMul.Text) Then
    edtPerMul.Text := FormatFloat('#,##0.00', StrToFloat(edtPerMul.Text));
end;

procedure TfrmConfigSicrediAPI.edtPorTarKeyPress(Sender: TObject;
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

procedure TfrmConfigSicrediAPI.edtQtdDiasDataLimiteRecEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtQtdDiasDataLimiteRec, 'Informar quantidade de dias ' + #13+#10 +
                                       'para Data Limnite de recebimento, ' + #13+#10 +
                                       'usando como base a data de ' + #13+#10 +
                                       'vencimento do título.');

  pShowHint(edtQtdDiasDataLimiteRec, 'Dias para Data Limite de Recibimento');
end;

procedure TfrmConfigSicrediAPI.edtQtdDiasDataLimiteRecExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSicrediAPI.edtQtdDiasNegaEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(edtQtdDiasNega, 'Quantidade de dias corridos depois do vencimento ' + #13+#10 +
                              'do boleto para a negativação automática, através do ' + #13+#10 +
                              'órgão negativador selecionado. ');

  pShowHint(edtQtdDiasNega, 'Dias para Negativação');
end;

procedure TfrmConfigSicrediAPI.edtQtdDiasNegaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSicrediAPI.edtValorTarifaExit(Sender: TObject);
begin
  inherited;
  try
    if not fEmptyStr(edtValorTarifa.Text) then
       edtValorTarifa.Text := FormatFloat('###,##0.00', fStrToFloat(edtValorTarifa.Text));
  except
   //
  end
end;

procedure TfrmConfigSicrediAPI.pAlteraHint(edtEdit: TEditFocus;
  strNovoHint: String);
begin
  edtEdit.Hint := strNovoHint;
end;

procedure TfrmConfigSicrediAPI.pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
begin
  If Not fEmptyStr(strCtaBai) Then
  Begin
    pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
    edtLabel.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
  End
  Else
    edtLabel.Clear;
end;

procedure TfrmConfigSicrediAPI.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  edtLabel.Clear;
  If Not fEmptyStr(strCodPor) Then
  Begin
    pPesquisaCadPor(Nil, qryCadPor, strCodPor);
    edtLabel.Text := qryCadPor.FieldByName('POR_NOMPOR').AsString;
  End
end;

procedure TfrmConfigSicrediAPI.pHideHint;
begin
  HintControler.HideHint;
end;

function TfrmConfigSicrediAPI.PlanoDeContaValido(ACodigo: TMaskEdit;
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

procedure TfrmConfigSicrediAPI.pLimpaCampos;
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


function TfrmConfigSicrediAPI.PortadorValido(ACodigo: TEdit; ADescricao: TEdit): Boolean;
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

procedure TfrmConfigSicrediAPI.pShowHint(edtEdit: TEditFocus; strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;

function TfrmConfigSicrediAPI.RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
begin
  While Not Sender.ClassName.Equals('TcxTabSheet') Do
  Begin
    Sender := Sender.Parent;
  End;
  Result := TcxTabSheet(Sender);
end;

procedure TfrmConfigSicrediAPI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  cdsCnfOco.Close;
  FreeAndNil(cdsCnfOco);
end;

procedure TfrmConfigSicrediAPI.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  qryCadEmp := fCriaQuery(Self);
  qryCadFor := fCriaQuery(Self);

  cdsCnfOco := untFuncAutban.CriaDatasetCnfOco;
  dsCnfOco.DataSet := cdsCnfOco;

  fraGerarPixBoletoSicredi.CarregarChavesPix('748');

  pCarKeyAutBan;
  cxPaginas.Properties.ActivePage := tbsGeral;
  pnlChaveConexao.Enabled := fVerificaAcessoSistema('ALTCHAVEAUTAPIBB');
end;

procedure TfrmConfigSicrediAPI.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmConfigSicrediAPI.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigSicrediAPI.btnValidaAcessoClick(Sender: TObject);
 Var
     LCarteira   : String;
     strChaveApp,
     strMsgValidacao : String;
begin
  inherited;

  If Not fValidaCampos(edtContaCorr, True) Then
     exit;

  If Not fValidaCampos(edtcodAgencia, True) Then
     exit;

  If Not fValidaCampos(edtChaveAppDev, True) Then
     exit;

  If Not fValidaCampos(edtPassword, True) Then
     exit;

  Try
    LCarteira := FCarteira + '-' + VS_strCodEmp;

    LBancoSicrediApi  := TBancoSicrediAPI.Create(LCarteira);

    strChaveApp := fGetBancoConfig(0, FCarteira, 'KEY_USER', '');

    strMsgValidacao := LBancoSicrediApi.Valida_Configuracao_Token( IIF( (edtChaveAppDev.Text = 'Chave App cadastrada'), strChaveApp, edtChaveAppDev.Text),
                                                                   edtContaCorr.Text,
                                                                   edtcodAgencia.Text,
                                                                   edtPassword.Text,
                                                                   cmbAmbiente.ItemIndex,
                                                                   LCarteira);
    fMensagem('',strMsgValidacao,['&O K'])

  Finally
    If Assigned(LBancoSicrediAPI) Then
       FreeAndNil(LBancoSicrediAPI);
  End;

end;

procedure TfrmConfigSicrediAPI.btnAddOcoClick(Sender: TObject);
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

procedure TfrmConfigSicrediAPI.btnCancelarClick(Sender: TObject);
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
    pnlComplemento.Enabled   := False;
    btnEditar.Visible   := True;
    btnGravar.Enabled   := False;
    btnConfigurar.Enabled := False;
    frmNegativacaoUF.Editavel := False;
    pCarregaDados;
    pSetFocus(btnEditar);
  end;
end;

procedure TfrmConfigSicrediAPI.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pHideHint;

    pCriarFormularios(TfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '748';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigSicrediAPI.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;

  stlCampos.Add('Posto                     :' + fGetBancoConfig(0, FCarteira, 'POSTO', ''));
  stlCampos.Add('Código Agência            :' + fGetBancoConfig(0, FCarteira, 'CODAGEN', ''));
  stlCampos.Add('Conta Corrente            :' + fGetBancoConfig(0, FCarteira, 'NUMCTAC', ''));
  stlCampos.Add('Tipo Docto.               :' + fGetBancoConfig(0, FCarteira, 'TIPO_DOCTO', ''));
  stlCampos.Add('Tipo Cobrança             :' + fGetBancoConfig(0, FCarteira, 'TIPO_COBRANCA', ''));
  stlCampos.Add('Tipo Desconto             :' + fGetBancoConfig(0, FCarteira, 'TIPO_DESC', ''));
  stlCampos.Add('Tipo Juros                :' + fGetBancoConfig(0, FCarteira, 'TIPO_JUROS', ''));
  stlCampos.Add('Password                  :' + fGetBancoConfig(0, FCarteira, 'PASSWORD', ''));
  stlCampos.Add('Observação 1              :' + fGetBancoConfig(0, FCarteira, 'OBSERV1', ''));
  stlCampos.Add('Observação 2              :' + fGetBancoConfig(0, FCarteira, 'OBSERV2', ''));
  stlCampos.Add('Observação 3              :' + fGetBancoConfig(0, FCarteira, 'OBSERV3', ''));
  stlCampos.Add('Observação 4              :' + fGetBancoConfig(0, FCarteira, 'OBSERV4', ''));
  stlCampos.Add('Observação 5              :' + fGetBancoConfig(0, FCarteira, 'OBSERV5', ''));
  stlCampos.Add('Dias p/ protesto          :' + fGetBancoConfig(0, FCarteira, 'DIAPROT', ''));
  stlCampos.Add('Dias p/ crédito           :' + fGetBancoConfig(0, FCarteira, 'DIACRED', ''));
  stlCampos.Add('Percentual Multa          :' + fGetBancoConfig(0, FCarteira, 'PERMULT', ''));
  stlCampos.Add('Dias para Negativação     :' + fGetBancoConfig(0, FCarteira, 'DIANEGA', ''));
  stlCampos.Add('Dias para Negativação(UF: Mato Grosso do Sul):' + fGetBancoConfig(0, FCarteira, 'DIANEGAMS', ''));
  stlCampos.Add('Dias para Negativação(UF: São Paulo):' + fGetBancoConfig(0, FCarteira, 'DIANEGASP', ''));
  stlCampos.Add('Protocolo Aceite          :' + fGetBancoConfig(0, FCarteira, 'PROACEI', ''));
  stlCampos.Add('Key User                  :' + fGetBancoConfig(0, FCarteira, 'KEY_USER', ''));
  stlCampos.Add('Tipo de Cobrança          :' + fGetBancoConfig(0, FCarteira, 'TIPO_COBRANCA', ''));
  stlCampos.Add('Importar Boletos Outras Empresas:' + fGetBancoConfig(0, FCarteira, 'IMPORTEMP', ''));
  stlCampos.Add('Utilizar importação de boletos otimizada:' + fGetBancoConfig(0, FCarteira, 'IMPOTIMIZADA', ''));
  stlCampos.Add('Baixar Boletos gerados por arquivo remessa:' + fGetBancoConfig(0, FCarteira, 'BAIBOLARQ', ''));
  stlCampos.Add('Considerar dias para crédito quando recebimento em pix :' + fGetBancoConfig(0, FCarteira, 'CDIACREPIX', ''));

  stlCampos.Add('Portador Cob. Simples     :' + fGetBancoConfig(0, FCarteira, 'PORBAI_', ''));
  stlCampos.Add('Pla. Contas Cob. Simples  :' + fGetBancoConfig(0, FCarteira, 'CTABAI_', ''));
  stlCampos.Add('Portador Cob. Vinculada   :' + fGetBancoConfig(0, FCarteira, 'PORBAI_VIN', ''));
  stlCampos.Add('Pla. Contas Cob. Vinculada:' + fGetBancoConfig(0, FCarteira, 'CTABAI_VIN', ''));
  stlCampos.Add('Dias corridos para recebimento após o vencimento:' + fGetBancoConfig(0, FCarteira, 'DIALIMI', ''));

  stlCampos.Add('Enc.Ban. Vr Tarifa:' + fGetBancoConfig(0, FCarteira, 'VALOTAR', ''));
  stlCampos.Add('Enc.Ban. Portador :' + fGetBancoConfig(0, FCarteira, 'PORTTAR', ''));
  stlCampos.Add('Enc.Ban. Pl Conta :' + fGetBancoConfig(0, FCarteira, 'CONTTAR', ''));
  stlCampos.Add('Enc.Ban. Fornec.  :' + fGetBancoConfig(0, FCarteira, 'FORNTAR', ''));
  stlCampos.Add('Lançar Tarifa Ban.:' + fGetBancoConfig(0, FCarteira, 'LANTX02', ''));
  stlCampos.Add('Permitir impressão de boletos? :' + fGetBancoConfig(0, FCarteira, 'PERIMPBOL', ''));
end;

procedure TfrmConfigSicrediAPI.fraGerarPixBoletoSicredicmbChavePixPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  If Not btnGravar.Enabled Then
    Exit;

  If blnNaoEditar Then
    Exit;

  if edtCodpor.Text <> fraGerarPixBoletoSicredi.cmbChavePix.Properties.DataController.DataSet.FieldByName('POR_CODPOR').AsString then
  Begin
    If fMensagem('ATENÇÃO', 'Deseja carregar o Portador da chave Pix selecionada como portador da baixa?', ['&Sim', '&Não']) = 2 Then
      Exit;
  End;

  edtCodPor.Text := fraGerarPixBoletoSicredi.cmbChavePix.Properties.DataController.DataSet.FieldByName('POR_CODPOR').AsString;
  CarregaPortador(edtCodPor.Text);
end;

procedure TfrmConfigSicrediAPI.fraPlanoDeContasEncMskCodCtaKeyPress(
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

function TfrmConfigSicrediAPI.fRetStrCfg(stlCfg : TStringList) : String;
Var
  intCont : Integer;
begin
  Result := '';

  For intCont := 0 To stlCfg.Count - 1 Do
    Result := Result + stlCfg.Strings[intCont] + #13+#10;
end;

procedure TfrmConfigSicrediAPI.pGravaLogCarteira(stlCfgAnt : TStringList);
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
    pGravaLogAtb('748', 'BANCO SICREDI [Online]', FCarteira + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

end.
