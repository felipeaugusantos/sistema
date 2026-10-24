unit Faturamento.View.DadosCTe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, EditFocus, ComboBoxFocus, System.StrUtils, Faturamento.Classes.TDadosCTe,
  untFuncoesSimples, System.Math, Vcl.Mask, MaskEditFocus, untTypesSistema, untConsultas, untFuncFat, untLiberacao,
  untFramePlanoDeContasMaskEdit, QColorLabel;

type
  TfrmFatDadosCTe = class(TfrmPaiSimples)
    pnlDadosCTe: TPanel;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlDados: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblValorFrete: TLabel;
    edtCFOP: TEditFocus;
    edtNaturezaOp: TEditFocus;
    edtSerie: TEditFocus;
    cmbTomadorServ: TComboBoxFocus;
    cmbPapelTomador: TComboBoxFocus;
    edtValorFrete: TEditFocus;
    pnlIcms: TPanel;
    gpbICMS: TGroupBox;
    Label10: TLabel;
    lblPercRedBC: TLabel;
    lblValorBC: TLabel;
    lblAliquota: TLabel;
    lblValorImposto: TLabel;
    lblValorCredito: TLabel;
    btnCalcImposto: TSpeedButton;
    cmbCodigoClassTrib: TComboBoxFocus;
    edtPercReducaoBC: TEditFocus;
    edtValorBC: TEditFocus;
    edtAliquota: TEditFocus;
    edtValorImposto: TEditFocus;
    edtValorCredito: TEditFocus;
    gpbPartilha: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    btnCalcImpostoPart: TSpeedButton;
    edtValorBaseCalculoIcmsUfDestino: TEditFocus;
    edtAliquotaIcmsInternaUfDestino: TEditFocus;
    edtAliquotaIcmsInterestadual: TEditFocus;
    edtValorIcmsPartilhaTermino: TEditFocus;
    edtValorIcmsPartilhaInicio: TEditFocus;
    edtAliquotaFcp: TEditFocus;
    edtValorFcpDestino: TEditFocus;
    pnlDados2: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edtProdutoPredom: TEditFocus;
    edtDescricaoServ: TEditFocus;
    edtQtdeCargas: TEditFocus;
    edtRNTRC: TEditFocus;
    pnlFinanceiro: TPanel;
    gpbFinanceiro: TGroupBox;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    mskConPagPagar: TMaskEditFocus;
    mskConPagReceber: TMaskEditFocus;
    fraPlanoDeContasPga: TfraPlanoDeContasMskEdit;
    fraPlanoDeContasRec: TfraPlanoDeContasMskEdit;
    pnlImpBol: TPanel;
    Label12: TLabel;
    ColorLabel3: TColorLabel;
    edtImpBol: TEditFocus;
    procedure cmbCodigoClassTribChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnCalcImpostoClick(Sender: TObject);
    procedure edtValorBCExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure btnCalcImpostoPartClick(Sender: TObject);
    procedure cmbPapelTomadorChange(Sender: TObject);
    procedure edtAliquotaIcmsInterestadualExit(Sender: TObject);
    procedure cmbTomadorServChange(Sender: TObject);
    procedure fraPlanoDeContasPgaMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasRecMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
  private
    objDadosCTe: TDadosCTe;
    blnConfirma: Boolean;
    strTipoAbfCliente: string;
    blnOrgaoPublico: Boolean;
    objLiberacao : TLiberacao;
    blnAlterando: Boolean;
    procedure FormShowInternal;
    function fValidaCondPagamento(var mskCndPag: TMaskEditFocus; blnBuscaPorChave: Boolean): Boolean;
    procedure pAlimentaPercReducaoBC;
    procedure pAlimentaValorBC;
    procedure pAlimentaAliquota;
    procedure pAlimentaValorImposto;
    procedure pAlimentaValorCredito;
    procedure pAlimentaQtdeCargas;
    procedure pRetornaCamposHabilitados;
    function fCarregaValorFrete: Boolean;
    function fRetornaPapelTomador: string;
    function fPapelTomadorLiberado: Boolean;
    function fEhCCOouCNC: Boolean;
    function fEhNCOouCTA: Boolean;

    procedure pRecalculaTamanhoTela;

  public
    class function Exibir(fatVenda: TFatVenda; strCodTra: String = ''; fltVolume: Double = 0): Boolean;
    class function Alterar(strTabela, strNumCte, strCodEmp: String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

uses
  untConstantes;

class function TfrmFatDadosCTe.Alterar(strTabela, strNumCte,
  strCodEmp: String): Boolean;
var
  frmFatDadosCTe: TfrmFatDadosCTe;
begin
  pCriarFormularios(TfrmFatDadosCTe, frmFatDadosCTe);
  frmFatDadosCTe.objDadosCTe := TDadosCTe.Create;
  try
    frmFatDadosCTe.objDadosCTe.pCarregaDados(strTabela, strNumCte, strCodEmp);

    frmFatDadosCTe.blnAlterando := True;

    frmFatDadosCTe.ShowModal;
    Result := frmFatDadosCTe.blnConfirma;

    if Result then
      Result := frmFatDadosCTe.objDadosCTe.fGravaDadosCte(strTabela);
  finally
    FreeAndNil(frmFatDadosCTe.objDadosCTe);
    pFreeAndNil(frmFatDadosCTe);
  end;
end;

procedure TfrmFatDadosCTe.btnCalcImpostoClick(Sender: TObject);
var
  fltValorBC: Double;
  fltAliquota: Double;
begin
  inherited;

  fltValorBC := IIF(edtValorBC.Enabled, fStrToFloat(edtValorBC.Text), 0);
  if (fltValorBC <= 0) then
    Exit;

  fltAliquota := IIF(edtAliquota.Enabled, fStrToFloat(edtAliquota.Text), 0);
  if (fltAliquota <= 0) then
    Exit;

  if not edtValorImposto.Enabled then
    Exit;

  edtValorImposto.Text := FloatToStrF(RoundTo(fltValorBC * fltAliquota / 100, -2), ffFixed, 12, 2);
end;

procedure TfrmFatDadosCTe.btnCalcImpostoPartClick(Sender: TObject);
var
  fltValorBCIcmsUfDest: Double;
  fltAliquotaInterna: Double;
  fltAliquotaInterestadual: Double;
  fltAliquotaCalculo: Double;
begin
  inherited;

  if not gpbPartilha.Visible then
    Exit;

  fltValorBCIcmsUfDest := fStrToFloat(edtValorBaseCalculoIcmsUfDestino.Text);
  if (fltValorBCIcmsUfDest <= 0) then
    Exit;

  fltAliquotaInterna := fStrToFloat(edtAliquotaIcmsInternaUfDestino.Text);
  if (fltAliquotaInterna <= 0) then
    Exit;

  fltAliquotaInterestadual := fStrToFloat(edtAliquotaIcmsInterestadual.Text);
  if (fltAliquotaInterestadual <= 0) then
    Exit;

  fltAliquotaCalculo := fltAliquotaInterna - fltAliquotaInterestadual;
  if (fltAliquotaCalculo > 0) then
    edtValorIcmsPartilhaTermino.Text := FloatToStrF(RoundTo(fltValorBCIcmsUfDest * fltAliquotaCalculo / 100, -2), ffFixed, 12, 2);
end;

procedure TfrmFatDadosCTe.btnCancelaDadosClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmFatDadosCTe.btnConfirmaDadosClick(Sender: TObject);
begin
  if (fStrToFloat(edtValorFrete.Text, 0) <= 0) then
  begin
    fMensagem('ATENÇÃO!', 'Valor do Frete zerado, verifique o cadastro de "Frete por Transportadora / Cidade"!', ['&O k']);
    Exit;
  end;

  if not fVerificaCampos then
    Exit;

  if objDadosCTe = nil then
  begin
    fMensagem('ERRO!', 'Objeto de Dados do CT-e não instanciado!' + #13 + 'Entre em contato com a Citel.', ['&O k']);
    Exit;
  end;

  objDadosCTe.strCFOP := edtCFOP.Text;
  objDadosCTe.strNaturezaOp := edtNaturezaOp.Text;
  objDadosCTe.strSerie := edtSerie.Text;
  objDadosCTe.strTomadorServico := cmbTomadorServ.Text;
  objDadosCTe.strPapelTomadorServico := cmbPapelTomador.Text;
  objDadosCTe.strClassificacaoTributaria := cmbCodigoClassTrib.Text;
  objDadosCTe.fltValorFrete := fStrToFloat(edtValorFrete.Text);

  pRetornaCamposHabilitados;

  objDadosCTe.strProdutoPredominante := edtProdutoPredom.Text;
  objDadosCTe.strDescricaoServico := edtDescricaoServ.Text;
  objDadosCTe.fltQtdeCargas := fStrToFloat(edtQtdeCargas.Text);
  objDadosCTe.strRNTRC := edtRNTRC.Text;
  objDadosCTe.strPortador := edtCodPor.Text;
  objDadosCTe.strPlanConPagar := fraPlanoDeContasPga.MskCodCta.Text;
  objDadosCTe.strCndPagPagar := mskConPagPagar.Text;
  objDadosCTe.strPlanConReceber := fraPlanoDeContasRec.MskCodCta.Text;
  objDadosCTe.strCndPagReceber := mskConPagReceber.Text;

  if objDadosCTe.objPartilha.blnGrava then
  begin
    objDadosCTe.objPartilha.fltValorBaseCalculoIcmsUfDestino := fStrToFloat(edtValorBaseCalculoIcmsUfDestino.Text);
    objDadosCTe.objPartilha.fltAliquotaIcmsInternaUfDestino  := fStrToFloat(edtAliquotaIcmsInternaUfDestino.Text);
    objDadosCTe.objPartilha.fltAliquotaIcmsInterestadual     := fStrToFloat(edtAliquotaIcmsInterestadual.Text);
    objDadosCTe.objPartilha.fltValorIcmsPartilhaTermino      := fStrToFloat(edtValorIcmsPartilhaTermino.Text);
    objDadosCTe.objPartilha.fltValorIcmsPartilhaInicio       := fStrToFloat(edtValorIcmsPartilhaInicio.Text);
    objDadosCTe.objPartilha.fltAliquotaFcp                   := fStrToFloat(edtAliquotaFcp.Text);
    objDadosCTe.objPartilha.fltValorFcpDestino               := fStrToFloat(edtValorFcpDestino.Text);
  end;

  objDadosCTe.blnImpBoleto := edtImpBol.Text = 'S';

  blnConfirma := True;
  Close;
end;

procedure TfrmFatDadosCTe.cmbCodigoClassTribChange(Sender: TObject);
var
  strCodST: string;
begin
  strCodST := LeftStr(cmbCodigoClassTrib.Text, 2);

  edtPercReducaoBC.Enabled := (Pos(strCodST, '20_90_') > 0);
  edtValorBC.Enabled := (Pos(strCodST, '00_20_60_90_') > 0);
  edtAliquota.Enabled := (Pos(strCodST, '00_20_60_90_') > 0);
  edtValorImposto.Enabled := (Pos(strCodST, '00_20_60_90_') > 0);
  edtValorCredito.Enabled := (strCodST = '60') and (cmbCodigoClassTrib.Text = '90 - ICMS outros');

  lblValorBC. Caption := 'Valor da BC do ICMS:';
  lblValorImposto.Caption := 'Valor do ICMS:';

  if strCodST = '1 ' then
    lblValorImposto.Caption := 'Valor Total Aprox. Impostos:';

  if strCodST = '60' then
  begin
    lblValorBC. Caption := 'Valor da BC do ICMS ST retido:';
    lblValorImposto.Caption := 'Valor do ICMS ST retido:';
  end;

  if cmbCodigoClassTrib.Text = '90 - ICMS devido a UF de origem de prestação, quando diferente da UF' then
    lblValorImposto.Caption := 'Valor do ICMS devido outra UF:';

  btnCalcImposto.Enabled := (edtValorBC.Enabled) and (edtAliquota.Enabled) and (edtValorImposto.Enabled);
end;

procedure TfrmFatDadosCTe.cmbPapelTomadorChange(Sender: TObject);
begin
  inherited;
  gpbPartilha.Visible := (cmbPapelTomador.Text = '9 - Não Contribuinte') and (not objDadosCTe.blnDentroEstado);

  if gpbPartilha.Visible then
    pnlIcms.Height := 224
  else
    pnlIcms.Height := 165;

  pRecalculaTamanhoTela;
  fValidaCampos(cmbPapelTomador);
end;

procedure TfrmFatDadosCTe.cmbTomadorServChange(Sender: TObject);
begin
  inherited;
  fValidaCampos(cmbTomadorServ);
end;

procedure TfrmFatDadosCTe.edtAliquotaIcmsInterestadualExit(Sender: TObject);
begin
  inherited;
  btnCalcImpostoPartClick(nil);
end;

procedure TfrmFatDadosCTe.edtCodPorKeyPress(Sender: TObject; var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor, edtNomPor, nil, Key, arrSel) Then
  Begin
    if fValidaCampos(edtCodPor) then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDadosCTe.edtValorBCExit(Sender: TObject);
begin
  inherited;
  btnCalcImpostoClick(nil);
end;

class function TfrmFatDadosCTe.Exibir(fatVenda: TFatVenda; strCodTra: String = ''; fltVolume: Double = 0): Boolean;
var
  frmFatDadosCTe: TfrmFatDadosCTe;
  LstrCodTra: String;
  LfltVolume: Double;
begin
  if (fatVenda.strOpcDoc = 'DV') then
  begin
    fatVenda.objDadosCte.blnGrava := False;
    Exit(True);
  End;

  if (fatVenda.blnVendaPresencial) then
  begin
    fatVenda.objDadosCte.blnGrava := False;
    Exit(True);
  end;

  LstrCodTra := IIF(fEmptyStr(strCodTra), fatVenda.strCodTra, strCodTra);
  LfltVolume := IIF(fltVolume = 0, fatVenda.intQtdTra, fltVolume);

  If fCfgSis('FRETRA') = FRETRA_POR_TRANSPORTADORA_CIDADE Then
    fatVenda.objDadosCte.pPopulaObjetoTraCid(LstrCodTra, IIF(fEmptyStr(fatVenda.enderecoEntrega.strCodCid), fatVenda.strCodCid, fatVenda.enderecoEntrega.strCodCid))
  Else If fCfgSis('FRETRA') = FRETRA_POR_TRANSPORTADORA_REGIAO Then
    fatVenda.objDadosCte.pPopulaObjetoTraReg(LstrCodTra, IIF(fEmptyStr(fatVenda.enderecoEntrega.strCodReg), fatVenda.strCodReg, fatVenda.enderecoEntrega.strCodReg));

  fatVenda.objDadosCte.pPopulaObjeto(LstrCodTra, fatVenda.intCgcCpf, fatVenda.fFaturamentoDentroDoEstado);

  fatVenda.objDadosCTe.fltValorFrete := fatVenda.fCalculaSugestaoFreteTransportadora(LstrCodTra, False, (fCfgSis('FRETRA') = FRETRA_POR_TRANSPORTADORA_REGIAO));
  if (not fEmptyStr(LstrCodTra)) and (fFormataFloat(fatVenda.objDadosCTe.fltValorFrete, 2) = 0) and (fCfgSis('VLFCTE', varString) = 'S') then
    fatVenda.objDadosCTe.fltValorFrete := fCampoTabela('TRA_VALFRE', 'CADTRA', ['TRA_CODTRA'] , [LstrCodTra]);

  fatVenda.objDadosCTe.strEmpCli := VS_strCodEmp;
  fatVenda.objDadosCte.fltQtdeCargas := LfltVolume;

  fatVenda.objDadosCte.objPartilha.pAlimentarPadraoAliquotas(fatVenda.cdsAbfIcm.FieldByName('ABF_ALQIED' + fatVenda.GetTipAbf).AsFloat,
                                                             fatVenda.objDadosCte.blnDentroEstado, fatVenda.fTrocaUFEndEntrega);

  pCriarFormularios(TfrmFatDadosCTe, frmFatDadosCTe);
  try
    frmFatDadosCTe.objDadosCTe := fatVenda.objDadosCTe;

    frmFatDadosCTe.blnOrgaoPublico := (fCampoTabela('CLI_ORGPUB', 'CADCLI', ['CLI_CODCLI'] , [fatVenda.strCodCli]) = 'S');
    if not frmFatDadosCTe.blnOrgaoPublico then
      frmFatDadosCTe.strTipoAbfCliente := fGetTipoAbfCliente(fatVenda.strCodCli);

    if fCfgSis('EXICTE', varBoolean) then
    begin
      frmFatDadosCTe.ShowModal;
      Result := frmFatDadosCTe.blnConfirma;
    end
    else
    begin
      frmFatDadosCTe.FormShowInternal;
      frmFatDadosCTe.btnConfirmaDados.Click;
      Result := frmFatDadosCTe.blnConfirma;
      if not Result then
      begin
        frmFatDadosCTe.ShowModal;
        Result := frmFatDadosCTe.blnConfirma;
      end;
    end;

    fatVenda.objDadosCte.blnGrava := Result;
  finally
    pFreeAndNil(frmFatDadosCTe);
  end;
end;

function TfrmFatDadosCTe.fCarregaValorFrete: Boolean;
begin
  Result := False;

  if objDadosCTe.fltValorBC <> 0 then
    Exit;

  if objDadosCTe.fltValorFrete = 0 then
    Exit;

  Result := True;
end;

function TfrmFatDadosCTe.fEhCCOouCNC: Boolean;
begin
  Result := (strTipoAbfCliente = '_SAI_CCO');

  if not Result then
    Result := (strTipoAbfCliente = '_SAI_CNC');
end;

function TfrmFatDadosCTe.fEhNCOouCTA: Boolean;
begin
  Result := (strTipoAbfCliente = '_SAI_NCO');

  if not Result then
   Result := (strTipoAbfCliente = '_SAI_CTA');
end;

procedure TfrmFatDadosCTe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not blnConfirma then
  begin
    if fMensagem('ATENÇÃO!', 'Tem certeza que deseja cancelar a digitação dos Dados da CT-e?', ['&Sim', '&Não']) = 2 then
      Action := caNone;
  end;

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  inherited;

end;

procedure TfrmFatDadosCTe.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  edtQtdeCargas.Text := '1.0000';
  strTipoAbfCliente := '';
  blnAlterando := False;
end;

procedure TfrmFatDadosCTe.FormShow(Sender: TObject);
begin
  inherited;
  FormShowInternal;
end;

procedure TfrmFatDadosCTe.FormShowInternal;
begin
  edtCFOP.Text                 := objDadosCTe.strCFOP;
  edtNaturezaOp.Text           := objDadosCte.strNaturezaOp;
  edtSerie.Text                := objDadosCte.strSerie;
  cmbTomadorServ.ItemIndex     := cmbTomadorServ.Items.IndexOf(objDadosCTe.strTomadorServico);

  if (fEmptyStr(objDadosCTe.strPapelTomadorServico)) then
    objDadosCTe.strPapelTomadorServico := fRetornaPapelTomador;

  cmbPapelTomador.ItemIndex          := cmbPapelTomador.Items.IndexOf(objDadosCTe.strPapelTomadorServico);
  cmbCodigoClassTrib.ItemIndex       := cmbCodigoClassTrib.Items.IndexOf(objDadosCTe.strClassificacaoTributaria);
  edtRNTRC.Text                      := objDadosCTe.strRNTRC;
  edtCodPor.Text                     := objDadosCTe.strPortador;
  edtNomPor.Text                     := fRetNomPortador(edtCodPor.Text);
  fraPlanoDeContasPga.MskCodCta.Text := objDadosCTe.strPlanConPagar;
  fraPlanoDeContasPga.edtDesCta.Text := fRetNomeConta(fraPlanoDeContasPga.MskCodCta.Text);
  mskConPagPagar.Text                := objDadosCTe.strCndPagPagar;
  fraPlanoDeContasRec.MskCodCta.Text := objDadosCTe.strPlanConReceber;
  fraPlanoDeContasRec.edtDesCta.Text := fRetNomeConta(fraPlanoDeContasRec.MskCodCta.Text);
  mskConPagReceber.Text              := objDadosCTe.strCndPagReceber;
  edtValorFrete.Text                 := FloatToStrF(objDadosCTe.fltValorFrete, ffFixed, 12, 2);

  cmbCodigoClassTribChange(nil);

  pAlimentaAliquota;
  pAlimentaPercReducaoBC;
  pAlimentaValorBC;
  pAlimentaValorImposto;
  pAlimentaValorCredito;

  if fCarregaValorFrete then
  begin
    btnCalcImposto.Click;
  end;

  edtProdutoPredom.Text        := objDadosCTe.strProdutoPredominante;
  edtDescricaoServ.Text        := objDadosCte.strDescricaoServico;

  pAlimentaQtdeCargas;

  edtValorBaseCalculoIcmsUfDestino.Text := FloatToStrF(objDadosCTe.objPartilha.fltValorBaseCalculoIcmsUfDestino, ffFixed, 11, 2);
  edtAliquotaIcmsInternaUfDestino.Text  := FloatToStrF(objDadosCTe.objPartilha.fltAliquotaIcmsInternaUfDestino, ffFixed, 11, 2);
  edtAliquotaIcmsInterestadual.Text     := FloatToStrF(objDadosCTe.objPartilha.fltAliquotaIcmsInterestadual, ffFixed, 11, 2);
  edtValorIcmsPartilhaTermino.Text      := FloatToStrF(objDadosCTe.objPartilha.fltValorIcmsPartilhaTermino, ffFixed, 11, 2);
  edtValorIcmsPartilhaInicio.Text       := FloatToStrF(objDadosCTe.objPartilha.fltValorIcmsPartilhaInicio, ffFixed, 11, 2);
  edtAliquotaFcp.Text                   := FloatToStrF(objDadosCTe.objPartilha.fltAliquotaFcp, ffFixed, 11, 2);
  edtValorFcpDestino.Text               := FloatToStrF(objDadosCTe.objPartilha.fltValorFcpDestino, ffFixed, 11, 2);

  if not fCfgSis('BOLCTE', varBoolean) then
  begin
    pnlImpBol.Visible := False;
    pRecalculaTamanhoTela;
  end;

  cmbTomadorServChange(nil);
  cmbPapelTomadorChange(nil);

  pSetFocus(edtNaturezaOp);
end;

procedure TfrmFatDadosCTe.pAlimentaAliquota;
begin
  if edtAliquota.Enabled then
    edtAliquota.Text        := FloatToStrF(objDadosCTe.fltAliquota, ffFixed, 12, 2)
  else
    edtAliquota.Text        := '0,00';
end;

procedure TfrmFatDadosCTe.pAlimentaPercReducaoBC;
begin
  if edtPercReducaoBC.Enabled then
    edtPercReducaoBC.Text := FloatToStrF(objDadosCTe.fltPercentualReducaoBC, ffFixed, 12, 2)
  else
    edtPercReducaoBC.Text := '0,00';
end;

procedure TfrmFatDadosCTe.pAlimentaQtdeCargas;
begin
  if objDadosCTe.fltQtdeCargas > 0 then
    edtQtdeCargas.Text           := FloatToStrF(objDadosCTe.fltQtdeCargas, ffFixed, 11, 4)
  else
    edtQtdeCargas.Text        := '1,0000';
end;

procedure TfrmFatDadosCTe.pAlimentaValorBC;
begin
  if edtValorBC.Enabled then
    edtValorBC.Text        := FloatToStrF(objDadosCTe.fltValorBC, ffFixed, 12, 2)
  else
    edtValorBC.Text        := '0,00';

  if fCarregaValorFrete then
  begin
    edtValorBC.Text := FloatToStrF(objDadosCTe.fltValorFrete, ffFixed, 12, 2);
    btnCalcImposto.Click;
  end;
end;

procedure TfrmFatDadosCTe.pAlimentaValorCredito;
begin
  if edtValorCredito.Enabled then
    edtValorCredito.Text        := FloatToStrF(objDadosCTe.fltValorCredito, ffFixed, 12, 2)
  else
    edtValorCredito.Text        := '0,00';
end;

procedure TfrmFatDadosCTe.pAlimentaValorImposto;
begin
  if edtValorImposto.Enabled then
    edtValorImposto.Text        := FloatToStrF(objDadosCTe.fltValorImposto, ffFixed, 12, 2)
  else
    edtValorImposto.Text        := '0,00';
end;

procedure TfrmFatDadosCTe.pRecalculaTamanhoTela;
const
  MARGEM = 5;
begin
  Self.Height := pnlDados.Height + MARGEM +
                 pnlDados2.Height + MARGEM +
                 pnlFinanceiro.Height + MARGEM +
                 pnlIcms.Height + MARGEM +
                 pnlConfirma.Height + pnlStatus.Height + 10;
end;

procedure TfrmFatDadosCTe.pRetornaCamposHabilitados;
begin
  if edtPercReducaoBC.Enabled then
    objDadosCTe.fltPercentualReducaoBC := StrToFloat(edtPercReducaoBC.Text);

  if edtValorBC.Enabled then
    objDadosCTe.fltValorBC := fStrToFloat(edtValorBC.Text);

  if edtAliquota.Enabled then
    objDadosCTe.fltAliquota := fStrToFloat(edtAliquota.Text);

  if edtValorImposto.Enabled then
    objDadosCTe.fltValorImposto := fStrToFloat(edtValorImposto.Text);

  if edtValorCredito.Enabled then
    objDadosCTe.fltValorCredito := fStrToFloat(edtValorCredito.Text);
end;

function TfrmFatDadosCTe.fPapelTomadorLiberado: Boolean;
begin
  Result := objDadosCTe.blnPapelTomadorLiberado;

  if Result then
    Result := (cmbPapelTomador.Text = objDadosCTe.strPapelTomadorLiberado);
end;

procedure TfrmFatDadosCTe.fraPlanoDeContasPgaMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If Not fCfgSis('USACTF', varBoolean) Then
  Begin
    If fPesqCentroCusto(Self, fraPlanoDeContasPga.MskCodCta, fraPlanoDeContasPga.edtDesCta, Nil, Key, arrCentroCusto) Then
    begin
      if fValidaCampos(fraPlanoDeContasPga.MskCodCta) then
        SelectNext(ActiveControl, True, True);
    end;
  End
end;

procedure TfrmFatDadosCTe.fraPlanoDeContasRecMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If Not fCfgSis('USACTF', varBoolean) Then
  Begin
    If fPesqCentroCusto(Self, fraPlanoDeContasRec.MskCodCta, fraPlanoDeContasRec.edtDesCta, Nil, Key, arrCentroCusto) Then
    begin
      if fValidaCampos(fraPlanoDeContasRec.MskCodCta) then
        SelectNext(ActiveControl, True, True);
    end;
  End
end;

function TfrmFatDadosCTe.fRetornaPapelTomador: string;
begin
  Result := '';
  if (cmbTomadorServ.Text = '0 - Remetente') then
    Result := '1 - Contribuinte ICMS'
  else if (cmbTomadorServ.Text = '3 - Destinatário') then
  begin
    if (blnOrgaoPublico) then
      Result := '2 - Contribuinte isento de inscrição'
    else if fEhCCOouCNC then
      Result := '1 - Contribuinte ICMS'
    else if fEhNCOouCTA then
      Result := '9 - Não Contribuinte';
  end;
end;

function TfrmFatDadosCTe.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (inherited fValidaCampos(Sender, blnBuscaPorChave)) then
  begin
    if (not fEmptyStr(edtCFOP.Text)) and (not fEmptyStr(cmbTomadorServ.Text)) and (not blnAlterando) then
    begin
      if (objDadosCTe.blnDentroEstado) then
        edtCFOP.Text := '5' + RightStr(edtCFOP.Text, 3)
      else
        edtCFOP.Text := '6' + RightStr(edtCFOP.Text, 3);
    end;

    if (Sender = edtCFOP) then
    begin
      if (fEmptyStr(edtCFOP.Text)) then
      begin
        fMensagem('ATENÇÃO!', 'O CFOP deve ser preenchido!', ['&O k']);
        Result := False;
      end
      else if (Length(edtCFOP.Text) <> 4) then
      begin
        fMensagem('ATENÇÃO!', 'Preencha corretamento o CFOP!', ['&O k']);
        Result := False;
      end;
    end

    else if (Sender = edtNaturezaOp) then
    begin
      if (fEmptyStr(edtNaturezaOp.Text)) then
      begin
        fMensagem('ATENÇÃO!', 'A Natureza da Operação deve ser preenchida!', ['&O k']);
        Result := False;
      end;
    end

    else if (Sender = edtSerie) then
    begin
      if (StrToIntDef(edtSerie.Text, -1) < 0) then
      begin
        fMensagem('ATENÇÃO!', 'A Série da CT-e deve ser preenchida!', ['&O k']);
        Result := False;
      end;
    end

    else if (Sender = cmbTomadorServ) then
    begin
      if (cmbTomadorServ.ItemIndex < 0) then
      begin
        fMensagem('ATENÇÃO!', 'O Tomador de Serviço deve ser preenchido!', ['&O k']);
        Result := False;
      end
      else
      begin
        if (not fPapelTomadorLiberado) then
        begin
          cmbPapelTomador.ItemIndex    := cmbPapelTomador.Items.IndexOf(fRetornaPapelTomador);
          cmbPapelTomadorChange(nil);
        end;

        if pnlImpBol.Visible then
        begin
          edtImpBol.Enabled := cmbTomadorServ.Text = '3 - Destinatário';
          if not edtImpBol.Enabled then
            edtImpBol.Text := 'N';
        end;
      end;
    end

    else if (Sender = cmbPapelTomador) then
    begin
      if (cmbPapelTomador.ItemIndex < 0) then
      begin
        fMensagem('ATENÇÃO!', 'O Papel do Tomador do Serviço deve ser preenchido!', ['&O k']);
        Result := False;
      end
      else
      begin
        if (cmbPapelTomador.Text <> fRetornaPapelTomador) and (not fPapelTomadorLiberado) then
        begin
          If Not Assigned(objLiberacao) Then
            objLiberacao := TLiberacao.Create;

          objLiberacao.Clear;
          objLiberacao.strDirAce    := 'TOMSRV';
          objLiberacao.strSenLib    := fCfgSis('SENTOM');
          objLiberacao.strMsgSen    := 'Alteração da sugestão do Papel do Tomador de Serviço - CTe';
          objLiberacao.strCodOpe    := strLoginUsuarioLogado;
          objLiberacao.objMsgLibera.pAddTexto('Alteração da sugestão do Papel do Tomador de Serviço');
          objLiberacao.objMsgLibera.pAddTexto('                    Tomador do Serviço: ' + cmbTomadorServ.Text);
          objLiberacao.objMsgLibera.pAddTexto('Papel do Tomador de Serviço - Sugerido: ' + fRetornaPapelTomador);
          objLiberacao.objMsgLibera.pAddTexto('Papel do Tomador de Serviço - Atual...: ' + cmbPapelTomador.Text);

          If not objLiberacao.fLibera then
          begin
            cmbPapelTomador.ItemIndex    := cmbPapelTomador.Items.IndexOf(fRetornaPapelTomador);
            cmbPapelTomadorChange(nil);
          end
          else
          begin
            objDadosCTe.blnPapelTomadorLiberado := True;
            objDadosCTe.strPapelTomadorLiberado := cmbPapelTomador.Text;
          end;
        end;
      end;
    end

    else if (Sender = edtValorFrete) then
    begin
      if (fStrToFloat(edtValorFrete.Text, 0) <= 0) then
      begin
        fMensagem('ATENÇÃO!', 'O ' + lblValorFrete.Caption + ' deve ser preenchido!', ['&O k']);
        Result := False;
      end;
    end

    else if (Sender = cmbCodigoClassTrib) then
    begin
      if (cmbCodigoClassTrib.ItemIndex < 0) then
      begin
        fMensagem('ATENÇÃO!', 'O Código da Situação Tributária deve ser preenchido!', ['&O k']);
        Result := False;
      end;
    end

    else if (Sender = edtPercReducaoBC) and (edtPercReducaoBC.Enabled) then
    begin
      if (fStrToFloat(edtPercReducaoBC.Text, 0) <= 0) then
      begin
        fMensagem('ATENÇÃO!', 'O ' + lblPercRedBC.Caption + ' deve ser preenchido!', ['&O k']);
        Result := False;
      end;
    end

    else if (Sender = edtValorBC) and (edtValorBC.Enabled) then
    begin
      if (fStrToFloat(edtValorBC.Text, 0) <= 0) then
      begin
        fMensagem('ATENÇÃO!', 'O ' + lblValorBC.Caption + ' deve ser preenchido!', ['&O k']);
        Result := False;
      end
      else if (fStrToFloat(edtValorBC.Text, 0) <> fStrToFloat(edtValorFrete.Text)) then
      begin
        fMensagem('ATENÇÃO!', 'O ' + lblValorBC.Caption + ' não pode ser diferente do valor do Frete!', ['&O k']);
        Result := False;
      end;
    end

    else if (Sender = edtAliquota) and (edtAliquota.Enabled) then
    begin
      if (fStrToFloat(edtAliquota.Text, 0) <= 0) then
      begin
        fMensagem('ATENÇÃO!', 'A ' + lblAliquota.Caption + ' deve ser preenchida!', ['&O k']);
        Result := False;
      end;
    end

    else if (Sender = edtValorImposto) and (edtValorImposto.Enabled) then
    begin
      if (fStrToFloat(edtValorImposto.Text, 0) <= 0) then
      begin
        fMensagem('ATENÇÃO!', 'O ' + lblValorImposto.Caption + ' deve ser preenchido!', ['&O k']);
        Result := False;
      end;
    end

    else if (Sender = edtValorCredito) and (edtValorCredito.Enabled) then
    begin
      if (fStrToFloat(edtValorCredito.Text, 0) <= 0) then
      begin
        fMensagem('ATENÇÃO!', 'O ' + lblValorCredito.Caption + ' deve ser preenchido!', ['&O k']);
        Result := False;
      end;
    end

    else if (gpbPartilha.Visible) and (Sender = edtValorBaseCalculoIcmsUfDestino) then
    begin
      if (fStrToFloat(edtValorBaseCalculoIcmsUfDestino.Text, 0) <= 0) then
      begin
        fMensagem('ATENÇÃO!', 'O Valor Base Calc. ICMS UF Destino deve ser preenchido!', ['&O k']);
        Result := False;
      end
      else if (edtValorBC.Enabled) and (fStrToFloat(edtValorBaseCalculoIcmsUfDestino.Text, 0) <> fStrToFloat(edtValorBC.Text, 0)) then
      begin
        fMensagem('ATENÇÃO!', 'O Valor Base Calc. ICMS UF Destino tem que ser igual'+#13+
                              'ao Valor Base Calc. ICMS UF Destino deve ser preenchido!', ['&O k']);
        Result := False;
      end;
    end

    else if (gpbPartilha.Visible) and (Sender = edtAliquotaIcmsInternaUfDestino) then
    begin
      if (fStrToFloat(edtAliquotaIcmsInternaUfDestino.Text, 0) <= 0) then
      begin
        fMensagem('ATENÇÃO!', 'A Aliq. ICMS Interna UF Destino deve ser preenchida!', ['&O k']);
        Result := False;
      end;
    end

    else if (gpbPartilha.Visible) and (Sender = edtAliquotaIcmsInterestadual) then
    begin
      if (fStrToFloat(edtAliquotaIcmsInterestadual.Text, 0) <= 0) then
      begin
        fMensagem('ATENÇÃO!', 'A Aliq. ICMS Interestadual deve ser preenchida!', ['&O k']);
        Result := False;
      end;
    end

    else if (gpbPartilha.Visible) and (Sender = edtValorIcmsPartilhaTermino) then
    begin
      if (fStrToFloat(edtValorIcmsPartilhaTermino.Text, 0) <= 0) then
      begin
        fMensagem('ATENÇÃO!', 'O Valor ICMS Partilha Término deve ser preenchido!', ['&O k']);
        Result := False;
      end;
    end

    else if (Sender = edtProdutoPredom) then
    begin
      if (fEmptyStr(edtProdutoPredom.Text)) then
      begin
        fMensagem('ATENÇÃO!', 'O Produto Predominante deve ser preenchido!', ['&O k']);
        Result := False;
      end;
    end

    else if (Sender = edtDescricaoServ) then
    begin
      if (fEmptyStr(edtDescricaoServ.Text)) then
      begin
        fMensagem('ATENÇÃO!', 'A Descrição do Serviço deve ser preenchida!', ['&O k']);
        Result := False;
      end;
    end

    else if (Sender = edtQtdeCargas) then
    begin
      if (fStrToFloat(edtQtdeCargas.Text, 0) <= 0) then
      begin
        fMensagem('ATENÇÃO!', 'A Quantidade de Cargas deve ser preenchida deve ser preenchido!', ['&O k']);
        Result := False;
      end;
    end

    else if (Sender = edtRNTRC) then
    begin
      if (fEmptyStr(edtRNTRC.Text)) then
      begin
        fMensagem('ATENÇÃO!', 'O Registro Nacional de Transportadores Rodoviários de Carga deve ser preenchido!', ['&O k']);
        Result := False;
      end
      else
      if (Length(edtRNTRC.Text) < 8) then
      begin
        fMensagem('ATENÇÃO!', 'Preencha corretamente o Registro Nacional de Transportadores Rodoviários de Carga!', ['&O k']);
        Result := False;
      end;
    end

    else if (Sender = edtCodPor) then
    begin
      if fEmptyStr(edtCodPor.Text) Then
      begin
        fMensagem('ATENÇÃO!','O código do portador deve ser informado !',['&O K']);
        Result := False;
      end
      else
      begin
        edtNomPor.Text := fRetNomPortador(edtCodPor.Text);
        if fEmptyStr(edtNomPor.Text) then
        begin
          fMensagem('ATENÇÃO!','Código do Portador incorreto !',['&O K']);
          Result := False;
        end
        else if not fEmpresaTemAcessoPortador(edtCodPor.Text, objDadosCTe.strCodEmp) then
        begin
          fMensagem('ATENÇÃO!', 'Empresa Transportadora sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        end;
      end;
    end

    Else If (Sender = fraPlanoDeContasPga.MskCodCta) Then
    Begin
      If fEmptyStr(fraPlanoDeContasPga.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O código do Plano de Contas a Pagar deve ser informado !',['&O K']);
        Result := False;
      End
      Else
      Begin
        fraPlanoDeContasPga.edtDesCta.Text := fRetNomeConta(fraPlanoDeContasPga.MskCodCta.Text);

        If Not PlanoDeContasAtivo(fraPlanoDeContasPga.MskCodCta.Text) Then
          Result := False
        Else If fEmptyStr(fraPlanoDeContasPga.edtDesCta.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Código do Plano de Contas a Pagar incorreto !',['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = fraPlanoDeContasRec.MskCodCta) Then
    Begin
      If fEmptyStr(fraPlanoDeContasRec.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O código do Plano de Contas a Receber deve ser informado !',['&O K']);
        Result := False;
      End
      Else
      Begin
        fraPlanoDeContasRec.edtDesCta.Text := fRetNomeConta(fraPlanoDeContasRec.MskCodCta.Text);

        If Not PlanoDeContasAtivo(fraPlanoDeContasRec.MskCodCta.Text) Then
          Result := False
        Else If fEmptyStr(fraPlanoDeContasRec.edtDesCta.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Código do Plano de Contas a Receber incorreto !',['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = mskConPagPagar) Then
    Begin
      Result := fValidaCondPagamento(mskConPagPagar, blnBuscaPorChave);
    End

    Else If (Sender = mskConPagReceber) Then
    Begin
      Result := fValidaCondPagamento(mskConPagReceber, blnBuscaPorChave);
    End

    Else If (Sender = edtImpBol) And (pnlImpBol.Visible) Then
    Begin
      If Pos(edtImpBol.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','Informar S ou N para Imprimir Boleto!',['&OK']);
        Result := False;
      End
      Else If (edtImpBol.Text = 'S') and (fStatusCndPag(mskConPagReceber.Text) = A_VISTA) Then
      begin
        fMensagem('ATENÇÃO!','Não é possível Imprimir Boleto para a condição à vista!',['&OK']);
        Result := False;
      end;
    End;

  end;

  objDadosCTe.objPartilha.blnGrava := gpbPartilha.Visible;

  if (not Result) then
    pSetFocus(Sender);

end;

function TfrmFatDadosCTe.fValidaCondPagamento(var mskCndPag: TMaskEditFocus; blnBuscaPorChave: Boolean): Boolean;
var
 strConPag: String;
begin
  Result := True;

  If fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
    Result := False;
  End

  Else If fEmptyStr(Copy(mskCndPag.Text, 1, 2)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Condição de pagamento inválida!', ['&O k']);
    Result := False;
  End
  Else If StrToInt(Copy(mskCndPag.Text, 1, 2)) > 24 Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido mais que 24 parcelas!', ['&O k']);
    Result := False;
  End
  Else If Not fValidaCndPag(mskCndPag.Text, strConPag, VS_Date) Then
  Begin
    fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
    Result := False;
  End Else
  Begin
    mskCndPag.Text := strConPag;

    If fEmptyStr(strConPag) Then
      Result := False;

  End;
end;

end.
