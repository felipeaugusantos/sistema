unit untFatManifestoEletronicoSeguroCarga;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Vcl.ComCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  DBGridCitel, UniClientDataSet, Vcl.Mask, MaskEditFocus, untMskC_G_C_,
  ComboBoxFocus, Uni, Datasnap.DBClient, Vcl.DBCtrls, DBEditFocus;

type
  TfrmFatManifestoEletronicoSeguroCarga = class(TfrmPai)
    pnlSeguroCarga: TPanel;
    pgcSegCar: TPageControl;
    tbsSeguroCarga: TTabSheet;
    tbsSeguroCargaAverbacao: TTabSheet;
    edtNomeSeguradora: TEditFocus;
    Label1: TLabel;
    rdgRespSeg: TRadioGroup;
    dbgSegCar: TDBGridCitel;
    Label2: TLabel;
    Label3: TLabel;
    edtNumApolice: TEditFocus;
    Label4: TLabel;
    btnAddSegCar: TBitBtnLocked;
    dbgAverb: TDBGridCitel;
    edtNumAverb: TEditFocus;
    Label5: TLabel;
    btnAddAverba: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    dtsSegCar: TDataSource;
    dtsSegCarAver: TDataSource;
    Label9: TLabel;
    edtCgcCpf: TEditFocus;
    mskRespCpfCnp: TMaskEditC_G_C_;
    mskCnpSeguradora: TMaskEditC_G_C_;
    tbsProdutoPredominante: TTabSheet;
    cbbTipoCarga: TComboBoxFocus;
    lblTipoCarga: TLabel;
    lblDescProdutoPredominante: TLabel;
    edtDescProdutoPredominante: TEditFocus;
    lblCEAN_GTIN: TLabel;
    edtCEAN_GTIN: TEditFocus;
    lblNCM: TLabel;
    edtNCM: TEditFocus;
    gbLocalizacaoCarregamento: TGroupBox;
    lblCEPCarregamento: TLabel;
    edtLatitudeCarregamento: TEditFocus;
    edtLongitudeCarregamento: TEditFocus;
    lblLatitudeCarregamento: TLabel;
    lblLongitudeCarregamento: TLabel;
    gbLocalizacaoDescarregamento: TGroupBox;
    lblCEPDescarregamento: TLabel;
    lblLatitudeDescarregamento: TLabel;
    lblLongitudeDescarregamento: TLabel;
    edtLatitudeDescarregamento: TEditFocus;
    edtLongitudeDescarregamento: TEditFocus;
    mskCEPDescarregamento: TMaskEditFocus;
    mskCEPCarregamento: TMaskEditFocus;
    tbsInformacoesDoPagamentoDoFrete: TTabSheet;
    lblCamposObrigatorios: TLabel;
    lblTipoCargaObrigatorio: TLabel;
    lblDescProdutoPredominanteObrigatorio: TLabel;
    cdsMDFPAG: TUniClientDataSet;
    cdsMDFCOM: TUniClientDataSet;
    cdsMDFPRA: TUniClientDataSet;
    cdsMDFPAGMDF_NOMRES: TStringField;
    cdsMDFPAGMDF_CPFCNP: TStringField;
    cdsMDFPAGMDF_ESTRAN: TStringField;
    cdsMDFPAGMDF_VALTOT: TCurrencyField;
    cdsMDFPAGMDF_FORPAG: TIntegerField;
    cdsMDFPAGMDF_NUMBAN: TStringField;
    cdsMDFPAGMDF_NUMAGE: TStringField;
    cdsMDFPAGMDF_CNPJPG: TStringField;
    gbMDFPAG: TGroupBox;
    gbResponsavelPagamento: TGroupBox;
    dsMDFPAG: TDataSource;
    lblNomeResponsavelPagamento: TLabel;
    lblIDEstrangeiro: TLabel;
    lblValorContrato: TLabel;
    btnAddInfPag: TBitBtnLocked;
    gbInformacoesBancarias: TGroupBox;
    lblNumeroBanco: TLabel;
    lblNumeroAgencia: TLabel;
    lblCNPJInstituicao: TLabel;
    dbgInformacoesPagamento: TDBGridCitel;
    lblCamposObrigatoriosInfPag: TLabel;
    lblValorTotalContratoObrigatorio: TLabel;
    lblFormaPagamentoObrigatorio: TLabel;
    cdsMDFPAGMDF_SEQPAG: TIntegerField;
    edtNomeResponsavel: TEditFocus;
    edtIDEstrangeiro: TEditFocus;
    edtNumeroBanco: TEditFocus;
    edtNumeroAgencia: TEditFocus;
    mskCNPJInstituicaoPag: TMaskEditC_G_C_;
    lblCNPJ_CPF: TLabel;
    edtCNPJ_CPF: TEditFocus;
    mskCNPJ_CPF: TMaskEditC_G_C_;
    rdgFormaPagamento: TRadioGroup;
    edtValorTotalContrato: TEditFocus;
    cdsMDFPAGTIPO_CNPJ_CPF: TStringField;
    edtSeqMDFPAG: TEditFocus;
    lblSeqMDFPAG: TLabel;
    gbComponentes: TGroupBox;
    cbbTipoComponente: TComboBoxFocus;
    lblTipoComponente: TLabel;
    lblTipoComponenteObrigatorio: TLabel;
    lblValorComponente: TLabel;
    lblValorComponenteObrigatorio: TLabel;
    edtValorComponente: TEditFocus;
    lblDescricaoComponente: TLabel;
    edtDescricaoComponente: TEditFocus;
    btnAddComponente: TBitBtnLocked;
    dbgComponentes: TDBGridCitel;
    lblSeqMDFCOM: TLabel;
    edtSeqMDFCOM: TEditFocus;
    cdsMDFCOMMDF_SEQPAG: TIntegerField;
    cdsMDFCOMMDF_SEQCOM: TIntegerField;
    cdsMDFCOMMDF_TIPCOM: TStringField;
    cdsMDFCOMMDF_VALCOM: TCurrencyField;
    cdsMDFCOMMDF_DESCOM: TStringField;
    dsMDFCOM: TDataSource;
    gbPrazos: TGroupBox;
    lblSeqMDFPRA: TLabel;
    edtSeqMDFPRA: TEditFocus;
    lblValorParcela: TLabel;
    edtValorParcela: TEditFocus;
    lblValorParcelaObrigatorio: TLabel;
    mskDataVencimento: TMaskEditFocus;
    lblDataVencimento: TLabel;
    lblNumeroParcelas: TLabel;
    edtNumeroParcelas: TEditFocus;
    btnAddPrazo: TBitBtnLocked;
    dbgPrazos: TDBGridCitel;
    dsMDFPRA: TDataSource;
    cdsMDFPRAMDF_SEQPAG: TIntegerField;
    cdsMDFPRAMDF_SEQPRA: TIntegerField;
    cdsMDFPRAMDF_NUMPAR: TIntegerField;
    cdsMDFPRAMDF_DTAVEN: TStringField;
    cdsMDFPRAMDF_VALPAR: TCurrencyField;
    cdsMDFPRAccVENCIMENTO: TStringField;
    lblNumeroBancoObrigatorio: TLabel;
    lblOu: TLabel;
    lblOu_: TLabel;
    lblCEP_Carregamento_Ou: TLabel;
    lblCEP_Descarregamento_Ou: TLabel;
    tbsProprietarioVeiculo: TTabSheet;
    lblCNPJ_CPFProprietario: TLabel;
    edtCNPJ_CPFProprietario: TEditFocus;
    mskCNPJ_CPFProprietario: TMaskEditC_G_C_;
    lblRNTRC: TLabel;
    edtRNTRC: TEditFocus;
    lblNomeRazaoSocialProprietario: TLabel;
    edtNomeRazaoSocialProprietario: TEditFocus;
    lblIEProprietario: TLabel;
    lblUFProprietario: TLabel;
    edtUFProprietario: TEditFocus;
    lblTipoProprietario: TLabel;
    cbbTipoProprietario: TComboBoxFocus;
    edtIEProprietario: TEditFocus;
    Label6: TLabel;
    bevelSeparador: TBevel;
    rdgPIX: TRadioGroup;
    mskPIX: TMaskEditC_G_C_;
    edtPixEmail_Chave: TEditFocus;
    cdsMDFPAGMDF_CHAPIX: TStringField;
    cdsMDFPAGMDF_TIPPIX: TIntegerField;
    btnLimpaPix: TBitBtnLocked;
    lblValorAdiantamento: TLabel;
    edtValorAdiantamento: TEditFocus;
    cdsMDFPAGMDF_VALADI: TCurrencyField;
    Label7: TLabel;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAddSegCarClick(Sender: TObject);
    procedure btnAddAverbaClick(Sender: TObject);
    procedure dbgSegCarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgAverbKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtCgcCpfChange(Sender: TObject);
    procedure edtNCMKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddInfPagClick(Sender: TObject);
    procedure edtCNPJ_CPFChange(Sender: TObject);
    procedure btnAddComponenteClick(Sender: TObject);
    procedure btnAddPrazoClick(Sender: TObject);
    procedure cdsMDFPAGAfterScroll(DataSet: TDataSet);
    procedure dbgPrazosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgComponentesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgInformacoesPagamentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgInformacoesPagamentoDblClick(Sender: TObject);
    procedure dbgComponentesDblClick(Sender: TObject);
    procedure dbgPrazosDblClick(Sender: TObject);
    procedure edtCNPJ_CPFProprietarioChange(Sender: TObject);
    procedure rdgPIXClick(Sender: TObject);
    procedure btnLimpaPixClick(Sender: TObject);
    procedure rdgFormaPagamentoClick(Sender: TObject);
  private
    { Private declarations }

    qryCadNcm: TUniQuery;
    intRdgPIX: Integer;

    function fCriaCdsSegCar(cmpSelf: TComponent): TUniClientDataSet;
    function fCriaCdsSegCarAver(cmpSelf: TComponent): TUniClientDataSet;
    function fCriaCdsProPre(cmpSelf: TComponent): TUniClientDataSet;
    function fCriaCdsMdfPro(cmpSelf: TComponent): TUniClientDataSet;

    procedure pReindexarInfPagFre;
    procedure pReindexarPrazos;
    procedure pReindexarComponentes;

    function fAddProdutoPredominante : Boolean;
    procedure pLimparProdutoPredominante;

    function fAddProprietarioVeiculo : Boolean;
    procedure pLimparProprietarioVeiculo;

    procedure pLimparInformacoesPagamentoFrete;
    procedure pLimparComponentes;
    procedure pLimparPrazos;

    function fValidouInformacoesPagamentoFreteObrigatorias : Boolean;

    procedure pAddSegCar;
    procedure pAddSegCarAver;
    procedure pLimparSegCar;
    procedure pLimparSegCarAver;
    procedure pReindexar(cdsDados: TUniClientDataSet);
    function fMaxSeq(cdsDados: TUniClientDataSet): Integer;
    function fNumeroParcelaJaExiste(strSeqMDFPRA: string): Boolean;
    function fDataVencimentoParcelaJaExiste(strSeqMDFPRA: string): Boolean;
  public
    { Public declarations }
    cdsSegCar     : TUniClientDataSet;
    cdsSegCarAver : TUniClientDataSet;
    cdsProPre     : TUniClientDataSet;
    cdsMdfPro     : TUniClientDataSet;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmFatManifestoEletronicoSeguroCarga: TfrmFatManifestoEletronicoSeguroCarga;

implementation

{$R *.dfm}

uses untFuncoesSimples, untFuncoesGenerica, StrUtils, untTypesSistema,
  untConsultas;

procedure TfrmFatManifestoEletronicoSeguroCarga.btnAddComponenteClick(Sender: TObject);
var
  intSeq : Integer;
begin

  inherited;

  {Registro obrigatório (master-detail}
  If cdsMDFPAG.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'Nenhum registro de "Informações do Pagamento do Frete" foi cadastrado!', ['&Ok']);
    pSetFocus(edtNomeResponsavel);
    Exit;
  End;

  If (cbbTipoComponente.ItemIndex < 0) Then
  Begin
    fMensagem('ATENÇÃO', 'Tipo do componente não foi informado!', ['&Ok']);
    pSetFocus(cbbTipoComponente);
    Exit;
  End;

  If fStrToFloat(edtValorComponente.Text) <= 0 Then
  Begin
    pMensagemOk('Obrigatório informar o valor total do componente!');
    pSetFocus(edtValorComponente);
    Exit;
  End;

  If (Not fEmptyStr(edtDescricaoComponente.Text)) And (Length(edtDescricaoComponente.Text) < 2) Then
  Begin
    pMensagemOk('Descrição deve conter 2 caracteres no mínimo!');
    pSetFocus(edtDescricaoComponente);
    Exit;
  End;

  intSeq := IIF(cdsMDFCOM.IsEmpty, 1, cdsMDFCOM.RecordCount +1);

  Try

    If fEmptyStr(edtSeqMDFCOM.Text) Then
    Begin
      cdsMDFCOM.Append;
      cdsMDFCOMMDF_SEQPAG.AsInteger  := cdsMDFPAGMDF_SEQPAG.AsInteger;
      cdsMDFCOMMDF_SEQCOM.AsInteger  := intSeq;
    End Else
      cdsMDFCOM.Edit;

    cdsMDFCOMMDF_TIPCOM.AsString   := IIF(cbbTipoComponente.ItemIndex = 3, '99', fstrZero(cbbTipoComponente.ItemIndex +1, 2));
    cdsMDFCOMMDF_VALCOM.AsCurrency := fStrToFloat(edtValorComponente.Text);
    cdsMDFCOMMDF_DESCOM.AsString   := edtDescricaoComponente.Text;
    cdsMDFCOM.Post;

  Finally
    pLimparComponentes;
  End;

end;

procedure TfrmFatManifestoEletronicoSeguroCarga.btnAddInfPagClick(Sender: TObject);
var
  intSeq : Integer;
  blnEstrangeiro : Boolean;
  strChavePix: string;
begin
  inherited;

  intSeq := IIF(cdsMDFPAG.IsEmpty, 1, cdsMDFPAG.RecordCount +1);
  blnEstrangeiro := Not fEmptyStr(edtIDEstrangeiro.Text);

  If (Not fVerificaCampos) Then
    Exit;

  If (Not fEmptyStr(edtNomeResponsavel.Text)) And (Length(edtNomeResponsavel.Text) < 2) Then
  Begin
    pMensagemOk('Nome deve conter 2 caracteres no mínimo!');
    pSetFocus(edtNomeResponsavel);
    Exit;
  End;

  If (Not blnEstrangeiro) And fEmptyStr(fTiraCaracEspeciais(mskCNPJ_CPF.Text)) Then
  Begin
    pMensagemOk('Obrigatório preenchimento do CNPJ/CPF (quando não for estrangeiro)!');
    pSetFocus(mskCNPJ_CPF);
    Exit;
  End;

  If (blnEstrangeiro) And (Not fEmptyStr(fTiraCaracEspeciais(mskCNPJ_CPF.Text))) Then
  Begin
    pMensagemOk('Se ID Estrangeiro preenchido favor apagar o CNPJ/CPF!');
    pSetFocus(mskCNPJ_CPF);
    Exit;
  End;

  If (blnEstrangeiro) And (Length(edtIDEstrangeiro.Text) < 5) Then
  Begin
    fMensagem('ATENÇÃO', 'ID Estrangeiro deve conter 5 caracteres no mínimo!', ['&Ok']);
    pSetFocus(edtIDEstrangeiro);
    Exit;
  End;

  If fStrToFloat(edtValorTotalContrato.Text) <= 0 Then
  Begin
    pMensagemOk('Obrigatório informar o valor total do contrato!');
    pSetFocus(edtValorTotalContrato);
    Exit;
  End;

  If (rdgFormaPagamento.ItemIndex < 0) Then
  Begin
    pMensagemOk('Obrigatório informar forma de pagamento!');
    pSetFocus(rdgFormaPagamento);
    Exit;
  End;

  If (rdgFormaPagamento.ItemIndex = 1) and (fStrToFloat(edtValorAdiantamento.Text) < 0) then
  begin
    pMensagemOk('O valor do Adiantamento do Frete não pode ser negativo!');
    pSetFocus(edtValorTotalContrato);
    Exit;
  end;

  If (rdgPIX.ItemIndex >= 0) and (Not fEmptyStr(fTiraCaracEspeciais(mskPIX.Text))) or (not fEmptyStr(edtPixEmail_Chave.Text)) Then
  Begin

    If Not fEmptyStr(edtNumeroBanco.Text) Or
       Not fEmptyStr(edtNumeroAgencia.Text) or
       not fEmptyStr(fTiraCaracEspeciais(mskCNPJInstituicaoPag.Text)) Then
    Begin
      pMensagemOk('Informe somente CNPJ da Instituição ou Banco/Agência ou PIX, nunca mais de uma opção!');
      Exit;
    End;

  {Deve informar Banco+Agência ou CNPJ}
  End 
  Else If Not fEmptyStr(fTiraCaracEspeciais(mskCNPJInstituicaoPag.Text)) Then
  Begin

    If Not fEmptyStr(edtNumeroBanco.Text) Or
       Not fEmptyStr(edtNumeroAgencia.Text) Then
    Begin
      pMensagemOk('Informe somente CNPJ da Instituição ou Banco/Agência ou PIX, nunca mais de uma opção!');
      Exit;
    End;

  End Else
  begin

    If fEmptyStr(edtNumeroBanco.Text) Then
    Begin
      pMensagemOk('Obrigatório informar número do banco!');
      pSetFocus(edtNumeroBanco);
      Exit;
    End;

    If (Length(edtNumeroBanco.Text) < 3) Then
    Begin
      pMensagemOk('Número do banco deve conter 3 caracteres no mínimo!');
      pSetFocus(edtNumeroBanco);
      Exit;
    End;

    If fEmptyStr(edtNumeroAgencia.Text) Then
    Begin
      pMensagemOk('Obrigatório informar número do agência!');
      pSetFocus(edtNumeroAgencia);
      Exit;
    End;

  End;

  strChavePix := '';
  if (rdgPIX.ItemIndex in [0,4]) then
    strChavePix := edtPixEmail_Chave.Text
  else if (rdgPIX.ItemIndex > 0) then
    strChavePix := IIF(rdgPIX.ItemIndex = 3, '+55', '') + fTiraCaracEspeciais(mskPIX.Text);

  If fEmptyStr(edtSeqMDFPAG.Text) Then
  Begin
    cdsMDFPAG.Append;
    cdsMDFPAGMDF_SEQPAG.AsInteger := intSeq;
  End Else
    cdsMDFPAG.Edit;

  cdsMDFPAGMDF_NOMRES.AsString    := edtNomeResponsavel.Text;
  cdsMDFPAGTIPO_CNPJ_CPF.AsString := edtCNPJ_CPF.Text;
  cdsMDFPAGMDF_CPFCNP.AsString    := fTiraCaracEspeciais(mskCNPJ_CPF.Text);
  cdsMDFPAGMDF_ESTRAN.AsString    := edtIDEstrangeiro.Text;
  cdsMDFPAGMDF_VALTOT.AsCurrency  := fStrToFloat(edtValorTotalContrato.Text);
  cdsMDFPAGMDF_FORPAG.AsInteger   := rdgFormaPagamento.ItemIndex;
  cdsMDFPAGMDF_NUMBAN.AsString    := edtNumeroBanco.Text;
  cdsMDFPAGMDF_NUMAGE.AsString    := edtNumeroAgencia.Text;
  cdsMDFPAGMDF_CNPJPG.AsString    := fTiraCaracEspeciais(mskCNPJInstituicaoPag.Text);
  cdsMDFPAGMDF_TIPPIX.AsInteger   := rdgPIX.ItemIndex;
  cdsMDFPAGMDF_CHAPIX.AsString    := strChavePix;
  if (rdgFormaPagamento.ItemIndex <> 1) then
    cdsMDFPAGMDF_VALADI.AsCurrency := 0.0
  else
    cdsMDFPAGMDF_VALADI.AsCurrency  := fStrToFloat(edtValorAdiantamento.Text);
  cdsMDFPAG.Post;

  pLimparInformacoesPagamentoFrete;

end;

procedure TfrmFatManifestoEletronicoSeguroCarga.btnAddPrazoClick(Sender: TObject);
var
  intSeq, intNumPar : Integer;
  dtaVencimento     : TDateTime;
begin

  inherited;

  {Registro obrigatório (master-detail}
  If cdsMDFPAG.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'Nenhum registro de "Informações do Pagamento do Frete" foi cadastrado!', ['&Ok']);
    pSetFocus(edtNomeResponsavel);
    Exit;
  End;

  If (cdsMDFPAGMDF_FORPAG.AsInteger <> 1) Then
  Begin
    fMensagem('ATENÇÃO', 'Forma de pagamento informada deve ser "À Prazo"!', ['&Ok']);
    Exit;
  End;

  if (StrToIntDef(edtNumeroParcelas.Text, -1) <= 0) then
  begin
    pMensagemOk('Obrigatório informar o número da parcela!');
    pSetFocus(edtNumeroParcelas);
    Exit;
  end
  else if fNumeroParcelaJaExiste(edtSeqMDFPRA.Text) then
  begin
    pMensagemOk('Este número da parcela já existe!');
    pSetFocus(edtNumeroParcelas);
    Exit;
  end;

  if fEmptyStr(fTiraCaracEspeciais(mskDataVencimento.Text)) then
  begin
    pMensagemOk('A data da Parcela é obrigatório!');
    pSetFocus(mskDataVencimento);
    Exit;
  end
  else if (StrToDateDef(mskDataVencimento.Text, -1) = -1) then
  begin
    pMensagemOk('A data da Parcela inválida!');
    pSetFocus(mskDataVencimento);
    Exit;
  end
  else if fDataVencimentoParcelaJaExiste(edtSeqMDFPRA.Text) then
  begin
    pMensagemOk('Esta data de parcela já existe!');
    pSetFocus(mskDataVencimento);
    Exit;
  end;

  If fStrToFloat(edtValorParcela.Text) <= 0 Then
  Begin
    pMensagemOk('Obrigatório informar o valor da parcela!');
    pSetFocus(edtValorParcela);
    Exit;
  End;

  intSeq := IIF(cdsMDFPRA.IsEmpty, 1, cdsMDFPRA.RecordCount +1);

  Try

    If fEmptyStr(edtSeqMDFPRA.Text) Then
    Begin
      cdsMDFPRA.Append;
      cdsMDFPRAMDF_SEQPAG.AsInteger  := cdsMDFPAGMDF_SEQPAG.AsInteger;
      cdsMDFPRAMDF_SEQPRA.AsInteger  := intSeq;
    End Else
      cdsMDFPRA.Edit;

    If (Not fEmptyStr(edtNumeroParcelas.Text)) And TryStrToInt(edtNumeroParcelas.Text, intNumPar) Then
      cdsMDFPRAMDF_NUMPAR.AsInteger  := intNumPar;

    If TryStrToDate(mskDataVencimento.Text, dtaVencimento) Then
    Begin
      cdsMDFPRAccVENCIMENTO.AsString := FormatDateTime('DD/MM/YYYY', dtaVencimento);
      cdsMDFPRAMDF_DTAVEN.AsString   := FormatDateTime('DDMMYYYY'  , dtaVencimento);
    End;

    cdsMDFPRAMDF_VALPAR.AsCurrency := fStrToFloat(edtValorParcela.Text);
    cdsMDFPRA.Post;

  Finally
    pLimparPrazos;
  End;

end;

procedure TfrmFatManifestoEletronicoSeguroCarga.btnAddAverbaClick(
  Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtNumAverb.Text) Then
  Begin
    pMensagemOk('Obrigatório Preenchimento do Número da Averbação!');
    pSetFocus(edtNumAverb);
    Exit;
  End;
  pAddSegCarAver;
  pLimparSegCarAver;
  pSetFocus(edtNumAverb);
end;

procedure TfrmFatManifestoEletronicoSeguroCarga.btnAddSegCarClick(
  Sender: TObject);
begin
  inherited;

  If (Not fVerificaCampos) Then
    Exit;

  pAddSegCar;
  pLimparSegCar;
  pSetFocus(mskRespCpfCnp);
end;

procedure TfrmFatManifestoEletronicoSeguroCarga.btnConfirmarClick(Sender: TObject);

  function fValidaLocalDeCarregamento: Boolean;
  begin
    Result := False;

    If fStringPossuiApenasNumeros(mskCEPCarregamento.Text) And (not fStringPossuiApenasNumeros(mskCEPDescarregamento.Text)) Then
      Exit(True);

    If (not fStringPossuiApenasNumeros(mskCEPCarregamento.Text)) And fStringPossuiApenasNumeros(mskCEPDescarregamento.Text) Then
      Exit(True);

    If fStringPossuiApenasNumeros(edtLatitudeCarregamento.Text) And (not fStringPossuiApenasNumeros(edtLatitudeDescarregamento.Text)) Then
      Exit(True);

    If (not fStringPossuiApenasNumeros(edtLatitudeDescarregamento.Text)) And fStringPossuiApenasNumeros(edtLatitudeDescarregamento.Text) Then
      Exit(True);

    If fStringPossuiApenasNumeros(edtLongitudeCarregamento.Text) And (not fStringPossuiApenasNumeros(edtLongitudeDescarregamento.Text)) Then
      Exit(True);

    If (not fStringPossuiApenasNumeros(edtLongitudeCarregamento.Text)) And fStringPossuiApenasNumeros(edtLongitudeDescarregamento.Text) Then
      Exit(True);
  end;

begin

  inherited;

  ModalResult := mrOk;

  {Seguro da Carga}
  If ((cdsSegCar.IsEmpty) And (cdsSegCarAver.IsEmpty)) And
    (fMensagem('', '[Seguro da Carga] - Seguro da Carga não foi Informado, Confirma?', ['&Sim', '&Não'], 2) = 2) Then
  Begin
    pgcSegCar.ActivePage := tbsSeguroCarga;
    pSetFocus(edtCgcCpf);
    ModalResult := mrRetry;
  End

  {Proprietário do Veículo}
  Else If Not fAddProprietarioVeiculo Then
    ModalResult := mrRetry

  {Produto Predominante}
  Else If Not fAddProdutoPredominante Then
  Begin
    pgcSegCar.ActivePage := tbsProdutoPredominante;
    ModalResult := mrRetry;
  End

  {Informações do Pagamento do Frete}
  Else If Not fValidouInformacoesPagamentoFreteObrigatorias Then
  Begin
    pgcSegCar.ActivePage := tbsInformacoesDoPagamentoDoFrete;
    ModalResult := mrRetry;
  End;

  If fValidaLocalDeCarregamento Then
  Begin
    pMensagemOk('Quando o Local de Carregamento é informado.'+#13+
                'Preencha o CEP ou as coordenadas do Descarregamento para continuar.');

    pgcSegCar.ActivePage := tbsProdutoPredominante;
    ModalResult := mrRetry;
  End;

end;

procedure TfrmFatManifestoEletronicoSeguroCarga.btnLimpaPixClick(Sender: TObject);
begin
  inherited;

  rdgPIX.ItemIndex := -1;
  rdgPIXClick(nil);
end;

procedure TfrmFatManifestoEletronicoSeguroCarga.cdsMDFPAGAfterScroll(DataSet: TDataSet);
begin
  inherited;

  If (cdsMDFPAG.IsEmpty) Or fEmptyStr(cdsMDFPAGMDF_SEQPAG.AsString) Then
    Exit;

  {Filtra Componentes}
  cdsMDFCOM.Filtered := False;
  cdsMDFCOM.Filter   := 'MDF_SEQPAG = ' + cdsMDFPAGMDF_SEQPAG.AsString;
  cdsMDFCOM.Filtered := True;

  {Filtra Prazos}
  cdsMDFPRA.Filtered := False;
  cdsMDFPRA.Filter   := 'MDF_SEQPAG = ' + cdsMDFPAGMDF_SEQPAG.AsString;
  cdsMDFPRA.Filtered := True;

end;

procedure TfrmFatManifestoEletronicoSeguroCarga.dbgAverbKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) Then
  Begin
    If cdsSegCarAver.Active And (cdsSegCarAver.RecordCount > 0) And
       (fMensagem('', 'Deseja Remover o Seguro Averbação Selecionado?', ['&Sim', '&Não'], 2) = 1) Then
    Begin
      cdsSegCarAver.Delete;
      pReindexar(cdsSegCarAver);
    End;
  End;
end;

procedure TfrmFatManifestoEletronicoSeguroCarga.dbgComponentesDblClick(Sender: TObject);
begin

  inherited;

  If (cdsMDFCOM.IsEmpty) Then
    Exit;

  pLimparComponentes;

  edtSeqMDFCOM.Text           := cdsMDFPAGMDF_SEQPAG.AsString;
  cbbTipoComponente.ItemIndex := IIF(cdsMDFCOMMDF_TIPCOM.AsString = '99', 3, cdsMDFCOMMDF_TIPCOM.AsInteger -1);
  edtValorComponente.Text     := cdsMDFCOMMDF_VALCOM.AsString;
  edtDescricaoComponente.Text := cdsMDFCOMMDF_DESCOM.AsString;

end;

procedure TfrmFatManifestoEletronicoSeguroCarga.dbgComponentesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  inherited;

  If (Key = VK_DELETE) Then
  Begin
    If cdsMDFCOM.Active And (cdsMDFCOM.RecordCount > 0) And
       (fMensagem('', 'Deseja remover o componente selecionado?', ['&Sim', '&Não'], 2) = 1) Then
    Begin
      cdsMDFCOM.Delete;
      pReindexarComponentes;
    End;
  End;

end;

procedure TfrmFatManifestoEletronicoSeguroCarga.dbgInformacoesPagamentoDblClick(Sender: TObject);
begin

  inherited;

  If cdsMDFPAG.IsEmpty Then
    Exit;

  pLimparInformacoesPagamentoFrete;

  edtSeqMDFPAG.Text           := cdsMDFPAGMDF_SEQPAG.AsString;
  edtNomeResponsavel.Text     := cdsMDFPAGMDF_NOMRES.AsString;
  edtCNPJ_CPF.Text            := cdsMDFPAGTIPO_CNPJ_CPF.AsString;
  mskCNPJ_CPF.Text            := cdsMDFPAGMDF_CPFCNP.AsString;
  edtIDEstrangeiro.Text       := cdsMDFPAGMDF_ESTRAN.AsString;
  edtValorTotalContrato.Text  := cdsMDFPAGMDF_VALTOT.AsString;
  rdgFormaPagamento.ItemIndex := cdsMDFPAGMDF_FORPAG.AsInteger;
  edtNumeroBanco.Text         := cdsMDFPAGMDF_NUMBAN.AsString;
  edtNumeroAgencia.Text       := cdsMDFPAGMDF_NUMAGE.AsString;
  mskCNPJInstituicaoPag.Text  := cdsMDFPAGMDF_CNPJPG.AsString;
  rdgPIX.ItemIndex            := cdsMDFPAGMDF_TIPPIX.AsInteger;
  if (cdsMDFPAGMDF_TIPPIX.AsInteger in [0,4]) then
    edtPixEmail_Chave.Text  := cdsMDFPAGMDF_CHAPIX.AsString
  else if (cdsMDFPAGMDF_TIPPIX.AsInteger > 0) and (cdsMDFPAGMDF_TIPPIX.AsInteger < 3) then
    mskPIX.Text  := cdsMDFPAGMDF_CHAPIX.AsString
  else if (cdsMDFPAGMDF_TIPPIX.AsInteger = 3) then
    mskPIX.Text  := AnsiReplaceStr(cdsMDFPAGMDF_CHAPIX.AsString, '+55', '');

  edtValorAdiantamento.Text := cdsMDFPAGMDF_VALADI.AsString;
end;

procedure TfrmFatManifestoEletronicoSeguroCarga.dbgInformacoesPagamentoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  inherited;

  If (Key = VK_DELETE) Then
  Begin

    If (Not cdsMDFCOM.IsEmpty) Or (Not cdsMDFPRA.IsEmpty) Then
    Begin
      fMensagem('ATENÇÃO', 'Apague todos os "Componentes" e "Prazos" vinculados a este registro antes de deletar o mesmo!', ['&Ok']);
      Exit;
    End;

    If cdsMDFPAG.Active And (cdsMDFPAG.RecordCount > 0) And
       (fMensagem('', 'Deseja remover a "Informação de Pagamento do Frete" selecionado?', ['&Sim', '&Não'], 2) = 1) Then
    Begin
      cdsMDFPAG.Delete;
      pReindexarInfPagFre;
    End;

  End
  Else
  If (Key = VK_RETURN) Then
    dbgInformacoesPagamentoDblClick(Self);

end;

procedure TfrmFatManifestoEletronicoSeguroCarga.dbgPrazosDblClick(Sender: TObject);
begin

  inherited;

  If cdsMDFPRA.IsEmpty Then
    Exit;

  pLimparPrazos;

  edtSeqMDFPRA.Text      := cdsMDFPAGMDF_SEQPAG.AsString;
  edtNumeroParcelas.Text := cdsMDFPRAMDF_NUMPAR.AsString;
  mskDataVencimento.Text := cdsMDFPRAccVENCIMENTO.AsString;
  edtValorParcela.Text   := cdsMDFPRAMDF_VALPAR.AsString;

end;

procedure TfrmFatManifestoEletronicoSeguroCarga.dbgPrazosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  inherited;

  If (Key = VK_DELETE) Then
  Begin
    If (cdsMDFPRA.Active) And (cdsMDFPRA.RecordCount > 0) And
       (fMensagem('', 'Deseja remover o prazo selecionado?', ['&Sim', '&Não'], 2) = 1) Then
    Begin
      cdsMDFPRA.Delete;
      pReindexarPrazos;
    End;
  End;

end;

procedure TfrmFatManifestoEletronicoSeguroCarga.dbgSegCarKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) Then
  Begin
    If cdsSegCar.Active And (cdsSegCar.RecordCount > 0) And
       (fMensagem('', 'Deseja Remover o Seguro Selecionado?', ['&Sim', '&Não'], 2) = 1) Then
    Begin
      cdsSegCar.Delete;
      pReindexar(cdsSegCar);
    End;
  End;
end;

procedure TfrmFatManifestoEletronicoSeguroCarga.edtNCMKeyPress(Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;
  If fPesqNCM(Self.Name, qryCadNcm, Key, arrSel) Then
  Begin
    edtNCM.Text := qryCadNcm.FieldByName('NCM_CODNCM').AsString;
    If fValidaCampos(edtNCM) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatManifestoEletronicoSeguroCarga.edtCgcCpfChange(
  Sender: TObject);
begin
  inherited;
  mskRespCpfCnp.EditMask := fRetMascaraC_G_C_(fSetaPais, IIF(edtCgcCpf.Text = '1', C_G_C_, C_P_F_));
end;

procedure TfrmFatManifestoEletronicoSeguroCarga.edtCNPJ_CPFChange(
  Sender: TObject);
begin
  inherited;
  mskCNPJ_CPF.EditMask := fRetMascaraC_G_C_(fSetaPais, IIF(edtCNPJ_CPF.Text = '1', C_G_C_, C_P_F_));
end;

procedure TfrmFatManifestoEletronicoSeguroCarga.edtCNPJ_CPFProprietarioChange(Sender: TObject);
begin
  inherited;
  mskCNPJ_CPFProprietario.EditMask := fRetMascaraC_G_C_(fSetaPais, IIF(edtCNPJ_CPFProprietario.Text = '1', C_G_C_, C_P_F_));
end;

function TfrmFatManifestoEletronicoSeguroCarga.fCriaCdsMdfPro(cmpSelf: TComponent): TUniClientDataSet;
begin

  Result := TUniClientDataSet.Create(cmpSelf);

  With Result, FieldDefs Do
  Begin

    With AddFieldDef Do
    Begin
      Name := 'MDF_CPFCNP';
      DataType := ftString;
      Size := 14;
    End;

    With AddFieldDef Do
    Begin
      Name := 'MDF_RNTRC_';
      DataType := ftString;
      Size := 8;
    End;

    With AddFieldDef Do
    Begin
      Name := 'MDF_NOMRAZ';
      DataType := ftString;
      Size := 60;
    End;

    With AddFieldDef Do
    Begin
      Name := 'MDF_INSEST';
      DataType := ftString;
      Size := 14;
    End;

    With AddFieldDef Do
    Begin
      Name := 'MDF_UF_PRO';
      DataType := ftString;
      Size := 2;
    End;

    With AddFieldDef Do
    Begin
      Name := 'MDF_TIPPRO';
      DataType := ftInteger;
    End;

    CreateDataSet;
    Open;
    LogChanges := False;

  End;

end;

function TfrmFatManifestoEletronicoSeguroCarga.fCriaCdsProPre(cmpSelf: TComponent): TUniClientDataSet;
begin

  Result := TUniClientDataSet.Create(cmpSelf);

  With Result, FieldDefs Do
  Begin

    With AddFieldDef Do
    Begin
      Name := 'MDF_TIPCAR';
      DataType := ftString;
      Size := 2;
    End;
    With AddFieldDef Do
    Begin
      Name := 'MDF_DESPRO';
      DataType := ftString;
      Size := 120;
    End;
    With AddFieldDef Do
    Begin
      Name := 'MDF_C_GTIN';
      DataType := ftString;
      Size := 14;
    End;
    With AddFieldDef Do
    Begin
      Name := 'MDF_CODNCM';
      DataType := ftString;
      Size := 8;
    End;

    With AddFieldDef Do
    Begin
      Name := 'MDF_CEPCAR';
      DataType := ftString;
      Size := 8;
    End;
    With AddFieldDef Do
    Begin
      Name := 'MDF_LATCAR';
      DataType := ftString;
      Size := 20;
    End;
    With AddFieldDef Do
    Begin
      Name := 'MDF_LONCAR';
      DataType := ftString;
      Size := 20;
    End;

    With AddFieldDef Do
    Begin
      Name := 'MDF_CEPDES';
      DataType := ftString;
      Size := 8;
    End;
    With AddFieldDef Do
    Begin
      Name := 'MDF_LATDES';
      DataType := ftString;
      Size := 20;
    End;
    With AddFieldDef Do
    Begin
      Name := 'MDF_LONDES';
      DataType := ftString;
      Size := 20;
    End;

    CreateDataSet;
    Open;
    LogChanges := False;
  End;

end;

function TfrmFatManifestoEletronicoSeguroCarga.fCriaCdsSegCar(cmpSelf: TComponent): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(cmpSelf);
  With Result, FieldDefs Do
  Begin
    With AddFieldDef Do
    Begin
      Name := 'MDF_SEQUEN';
      DataType := ftInteger;
      Required := False;
    End;
    With AddFieldDef Do
    Begin
      Name := 'MDF_RESSEG';
      DataType := ftInteger;
      Required := False;
    End;
    With AddFieldDef Do
    Begin
      Name := 'MDF_RESCPF';
      DataType := ftString;
      Size := 18;
      Required := False;
    End;
    With AddFieldDef Do
    Begin
      Name := 'MDF_NOMSEG';
      DataType := ftString;
      Size := 30;
      Required := False;
    End;
    With AddFieldDef Do
    Begin
      Name := 'MDF_SEGCNP';
      DataType := ftString;
      Size := 18;
      Required := False;
    End;
    With AddFieldDef Do
    Begin
      Name := 'MDF_NUMAPO';
      DataType := ftString;
      Size := 20;
      Required := False;
    End;
    IndexFieldNames := 'MDF_SEQUEN';
    CreateDataSet;
    Open;
    LogChanges := False;
  End;
end;

function TfrmFatManifestoEletronicoSeguroCarga.fCriaCdsSegCarAver(cmpSelf: TComponent): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(cmpSelf);
  With Result, FieldDefs Do
  Begin
    With AddFieldDef Do
    Begin
      Name := 'MDF_SEQUEN';
      DataType := ftInteger;
      Required := False;
    End;
    With AddFieldDef Do
    Begin
      Name := 'MDF_NUMAVE';
      DataType := ftString;
      Required := False;
      Size := 40;
    End;
    IndexFieldNames := 'MDF_SEQUEN';
    CreateDataSet;
    Open;
    LogChanges := False;
  End;
end;

function TfrmFatManifestoEletronicoSeguroCarga.fDataVencimentoParcelaJaExiste(strSeqMDFPRA: string): Boolean;
var
  intRecNo: Integer;
begin
  Result := False;
  cdsMDFPRA.DisableControls;
  try
    if (fEmptyStr(strSeqMDFPRA)) then
    begin
      if (cdsMDFPRA.Locate('ccVENCIMENTO', mskDataVencimento.Text, [])) then
        Exit(True);
    end
    else
    begin
      intRecNo := cdsMDFPRA.RecNo;
      while not cdsMDFPRA.Eof do
      begin
        if (cdsMDFPRAccVENCIMENTO.AsString = mskDataVencimento.Text) and (cdsMDFPRAMDF_SEQPRA.AsString <> edtSeqMDFPRA.Text) then
        begin
          cdsMDFPRA.RecNo := intRecNo;
          Exit(True);
        end;
        cdsMDFPRA.Next;
      end;
    end;
  finally
    cdsMDFPRA.EnableControls;
  end;
end;

function TfrmFatManifestoEletronicoSeguroCarga.fMaxSeq(
  cdsDados: TUniClientDataSet): Integer;
  Var
    intRecNo : Integer;
begin
  If (cdsDados.IsEmpty) Then
  Begin
    Result := 0;
    Exit;
  End;

  intRecNo := cdsDados.RecNo;
  cdsDados.DisableControls;
  Try
    cdsDados.Last;
    Result := cdsDados.FieldByName('MDF_SEQUEN').AsInteger;
  Finally
    cdsDados.RecNo := intRecNo;
    cdsDados.EnableControls;
  End;
end;

function TfrmFatManifestoEletronicoSeguroCarga.fNumeroParcelaJaExiste(strSeqMDFPRA: string): Boolean;
var
  intRecNo: Integer;
begin
  Result := False;
  cdsMDFPRA.DisableControls;
  try
    if (fEmptyStr(strSeqMDFPRA)) then
    begin
      if (cdsMDFPRA.Locate('MDF_NUMPAR', StrToIntDef(edtNumeroParcelas.Text, -1), [])) then
        Exit(True);
    end
    else
    begin
      intRecNo := cdsMDFPRA.RecNo;
      while not cdsMDFPRA.Eof do
      begin
        if (cdsMDFPRAMDF_NUMPAR.AsString = edtNumeroParcelas.Text) and (cdsMDFPRAMDF_SEQPRA.AsString <> edtSeqMDFPRA.Text) then
        begin
          cdsMDFPRA.RecNo := intRecNo;
          Exit(True);
        end;
        cdsMDFPRA.Next;
      end;
    end;
  finally
    cdsMDFPRA.EnableControls;
  end;
end;

procedure TfrmFatManifestoEletronicoSeguroCarga.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCgcCpf);
end;

procedure TfrmFatManifestoEletronicoSeguroCarga.FormCreate(Sender: TObject);
begin
  inherited;
  pgcSegCar.ActivePageIndex := 0;
  cdsSegCar := fCriaCdsSegCar(Self);
  cdsSegCarAver := fCriaCdsSegCarAver(Self);

  qryCadNcm := fCriaQuery(Self);

  dtsSegCar.DataSet := cdsSegCar;
  dtsSegCarAver.DataSet := cdsSegCarAver;

  cdsProPre := fCriaCdsProPre(Self);
  cdsProPre.EmptyDataSet;
  pLimparProdutoPredominante;

  cdsMdfPro := fCriaCdsMdfPro(Self);
  cdsMdfPro.EmptyDataSet;
  pLimparProprietarioVeiculo;

  cdsMDFPAG.CreateDataSet;
  cdsMDFPAG.EmptyDataSet;

  cdsMDFCOM.CreateDataSet;
  cdsMDFCOM.EmptyDataSet;

  cdsMDFPRA.CreateDataSet;
  cdsMDFPRA.EmptyDataSet;

  intRdgPIX := -1;
end;

procedure TfrmFatManifestoEletronicoSeguroCarga.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsSegCar);
  FreeAndNil(cdsSegCarAver);
  FreeAndNil(cdsProPre);
end;

function TfrmFatManifestoEletronicoSeguroCarga.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtCgcCpf) Then
  Begin
    If Not ('_1_2_'.Contains(edtCgcCpf.Text)) Then
      Result := False;
  End

  Else If (Sender = mskRespCpfCnp) Then
  Begin
    If (rdgRespSeg.ItemIndex = 1) And (fEmptyStr(mskRespCpfCnp.Text)) Then
    Begin
      pMensagemOk('Obrigatório Preenchimento do CPF/CNPJ do responsável pelo seguro!');
      Result := False;
    End
    Else If fEmptyStr(mskRespCpfCnp.Text) Then
      mskRespCpfCnp.Clear
    Else
      Result := fValidaCnpjCpf(edtCgcCpf.Text, mskRespCpfCnp.Text, False, False);
  End

  Else If (Sender = edtCNPJ_CPF) Then
  Begin
    If Not ('_1_2_'.Contains(edtCNPJ_CPF.Text)) Then
      Result := False;
  End

  Else If (Sender = edtCNPJ_CPFProprietario) Then
  Begin
    If Not ('_1_2_'.Contains(edtCNPJ_CPFProprietario.Text)) Then
      Result := False;
  End

  Else If (Sender = edtUFProprietario) And (Not fEmptyStr(edtUFProprietario.Text)) Then
  Begin

    If Not fValidaEstado(edtUFProprietario.Text) Then
    Begin
      fMensagem('ATENÇÃO!', '[Proprietário do Veículo] Estado inválido!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = mskCNPJ_CPF) Then
  Begin
    If Not fEmptyStr(mskCNPJ_CPF.Text) Then
    Begin
      If Not fValidaCnpjCpf(edtCNPJ_CPF.Text, mskCNPJ_CPF.Text, False, False) Then
      Begin
        pMensagemOk('CPF/CNPJ (Responsável do pagamento) informado inválido!');
        Result := False;
      End;
    End;
  End

  Else If (Sender = mskCNPJInstituicaoPag) Then
  Begin
    If Not fEmptyStr(mskCNPJInstituicaoPag.Text) Then
    Begin
      If Not fValidaCnpjCpf('1', mskCNPJInstituicaoPag.Text, False, False) Then
      Begin
        pMensagemOk('CNPJ (Informações bancárias) informado inválido!');
        Result := False;
      End;
    End;
  End

  Else If (rdgPIX.ItemIndex = 0) and (Sender = edtPixEmail_Chave) Then
  Begin
    If fEmptyStr(edtPixEmail_Chave.Text) Then
    Begin
      pMensagemOk('E-mail (PIX) informado não pode estar em branco!');
      Result := False;
    End
    else if (not fEnderecoEmailValido(edtPixEmail_Chave.Text)) then
    begin
      pMensagemOk('E-mail (PIX) informado inválido!');
      Result := False;
    end;
  End

  Else If (rdgPIX.ItemIndex = 1) and (Sender = mskPIX) Then
  Begin
    If Not fEmptyStr(mskPIX.Text) Then
    Begin
      If Not fValidaCnpjCpf('2', mskPIX.Text, False, False) Then
      Begin
        pMensagemOk('CPF (PIX) informado inválido!');
        Result := False;
      End;
    End;
  End

  Else If (rdgPIX.ItemIndex = 2) and (Sender = mskPIX) Then
  Begin
    If Not fEmptyStr(mskPIX.Text) Then
    Begin
      If Not fValidaCnpjCpf('1', mskPIX.Text, False, False) Then
      Begin
        pMensagemOk('CNPJ (PIX) informado inválido!');
        Result := False;
      End;
    End;
  End

  Else If (rdgPIX.ItemIndex = 3) and (Sender = mskPIX) Then
  Begin
    If fEmptyStr(mskPIX.Text) Then
    Begin
      pMensagemOk('Celular (PIX) informado não pode estar em branco!');
      Result := False;
    End
    else if (Length(Trim(mskPIX.Text)) <> 11) then
    begin
      pMensagemOk('Celular (PIX) informado inválido!');
      Result := False;
    end;
  End

  Else If (rdgPIX.ItemIndex = 4) and (Sender = edtPixEmail_Chave) Then
  Begin
    If fEmptyStr(edtPixEmail_Chave.Text) Then
    Begin
      pMensagemOk('Chave Aleatória (PIX) informada não pode estar em branco!');
      Result := False;
    End;
  End

  Else If (Sender = edtNomeSeguradora) Then
  Begin
    If (rdgRespSeg.ItemIndex = 1) And (fEmptyStr(edtNomeSeguradora.Text)) Then
    Begin
      pMensagemOk('Obrigatório Preenchimento do Nome da Seguradora!');
      Result := False;
    End;
  End

  Else If (Sender = edtNumApolice) Then
  Begin
    If (rdgRespSeg.ItemIndex = 1) And (fEmptyStr(edtNumApolice.Text)) Then
    Begin
      pMensagemOk('Obrigatório Preenchimento do Número da Apólice!');
      Result := False;
    End;
  End

  Else If (Sender = mskCnpSeguradora) Then
  Begin
    If (rdgRespSeg.ItemIndex = 1) And (fEmptyStr(mskCnpSeguradora.Text)) Then
    Begin
      pMensagemOk('Obrigatório Preenchimento do CNPJ da Seguradora!');
      Result := False;
    End
    Else If (fEmptyStr(mskCnpSeguradora.Text)) Then
      mskCnpSeguradora.Clear
    Else If Not fTestaCgc(mskCnpSeguradora.Text) Then
    Begin
      fMensagem('ATENÇÃO', 'CNPJ da Seguradora não é válido!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtNCM) Then
  Begin
    If (Not fEmptyStr(edtNCM.Text)) And fEmptyStr(fRetDescricaoNcm(edtNCM.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não foi encontrado cadastro de NCM com o Código informado. ' +
        'Verifique o "Cadastro de Nomenclatura Comum do Mercosul (NCM)"!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = mskCEPCarregamento) And Not fEmptyStr(fTiraCaracEspeciais(mskCEPCarregamento.Text)) Then
  Begin

    If Length(Trim(fTiraCaracEspeciais(mskCEPCarregamento.Text))) < 8 Then
    Begin
      fMensagem('ATENÇÃO!', 'O CEP de carregamento deve conter 8 dígitos.', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = mskCEPDescarregamento) And Not fEmptyStr(fTiraCaracEspeciais(mskCEPDescarregamento.Text)) Then
  Begin

    If Length(Trim(fTiraCaracEspeciais(mskCEPDescarregamento.Text))) < 8 Then
    Begin
      fMensagem('ATENÇÃO!', 'O CEP de descarregamento deve conter 8 dígitos.', ['&Ok']);
      Result := False;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmFatManifestoEletronicoSeguroCarga.fValidouInformacoesPagamentoFreteObrigatorias: Boolean;
var
  fltVlrComponentes: Double;
begin

  Result := True;

  cdsMDFPAG.DisableControls;
  cdsMDFCOM.DisableControls;
  cdsMDFPRA.DisableControls;

  Try

    cdsMDFPAG.First;
    While Not cdsMDFPAG.Eof Do
    Begin

      {Componentes}
      If (cdsMDFCOM.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO', 'É necessário informar os componentes para todos os registros de "Informação de Pagamento"!', ['&Ok']);
        Exit(False);
      End
      Else
      Begin
        If Not fEmptyStr(cdsMdfPro.FieldByName('MDF_NOMRAZ').AsString) Then
        Begin
          fltVlrComponentes := 0;
          cdsMDFCOM.First;
          While Not cdsMDFCOM.Eof Do
          Begin
            fltVlrComponentes := fltVlrComponentes + cdsMDFCOMMDF_VALCOM.AsFloat;
            cdsMDFCOM.Next;
          End;

          If fFormataFloat(fltVlrComponentes, 2) <> fFormataFloat(cdsMDFPAGMDF_VALTOT.AsFloat, 2) Then
          Begin
            fMensagem('ATENÇÃO', 'O somatório dos componentes deve ser igual ao valor do contrato!', ['&Ok']);
            Exit(False);
          End;
        End;
      End;

      {Prazos}
      If (cdsMDFPAGMDF_FORPAG.AsInteger = 1) Then
      Begin
        If (cdsMDFPRA.IsEmpty) Then
        Begin
          fMensagem('ATENÇÃO', 'É necessário informar o prazo para todos os registros de "Informação de Pagamento"!' + #13 +
                               'Quando forma de pagamento informada for "À Prazo"!', ['&Ok']);
          Exit(False);
        End;
      End;

      cdsMDFPAG.Next;

    End;

  Finally
    cdsMDFPAG.EnableControls;
    cdsMDFCOM.EnableControls;
    cdsMDFPRA.EnableControls;
  End;

end;

function TfrmFatManifestoEletronicoSeguroCarga.fAddProdutoPredominante : Boolean;
Var
  blnInformouAlgumCampo : Boolean;
begin

  Result := True;

  blnInformouAlgumCampo := Not fEmptyStr(cbbTipoCarga.Text)               Or
                           Not fEmptyStr(edtDescProdutoPredominante.Text) Or
                           Not fEmptyStr(edtCEAN_GTIN.Text)               Or
                           Not fEmptyStr(edtNCM.Text)                     Or
                           Not fEmptyStr(fTiraCaracEspeciais(mskCEPCarregamento.Text))    Or
                           Not fEmptyStr(edtLatitudeCarregamento.Text)    Or
                           Not fEmptyStr(edtLongitudeCarregamento.Text)   Or
                           Not fEmptyStr(fTiraCaracEspeciais(mskCEPDescarregamento.Text)) Or
                           Not fEmptyStr(edtLatitudeDescarregamento.Text) Or
                           Not fEmptyStr(edtLongitudeDescarregamento.Text);

  {CFG_OBGPRO - Obrigar informar aba [Produto Predominante] na geração do MDF-e?}
  If fCfgSis('OBGPRO', varBoolean) Or (blnInformouAlgumCampo) Then
  Begin

    If (cbbTipoCarga.ItemIndex < 0) Then
    Begin
      fMensagem('ATENÇÃO', '[Produto Predominante] - Tipo de Carga não foi informado!', ['&Ok']);
      pgcSegCar.ActivePage := tbsProdutoPredominante;
      pSetFocus(cbbTipoCarga);
      Exit(False);
    End;

    If fEmptyStr(edtDescProdutoPredominante.Text) Then
    Begin
      fMensagem('ATENÇÃO', '[Produto Predominante] - Descrição do Produto Predominante não foi informado!', ['&Ok']);
      pgcSegCar.ActivePage := tbsProdutoPredominante;
      pSetFocus(edtDescProdutoPredominante);
      Exit(False);
    End;

    If (Length(edtDescProdutoPredominante.Text) < 2) Then
    Begin
      fMensagem('ATENÇÃO', '[Produto Predominante] - Descrição do Produto deve conter 2 caracteres no mínimo!', ['&Ok']);
      pgcSegCar.ActivePage := tbsProdutoPredominante;
      pSetFocus(edtDescProdutoPredominante);
      Exit(False);
    End;

  End;

  If (Not fEmptyStr(edtNCM.Text) And (Length(edtNCM.Text) < 8)) Then
  Begin
    fMensagem('ATENÇÃO', '[Produto Predominante] - NCM deve conter 8 caracteres!', ['&Ok']);
    pgcSegCar.ActivePage := tbsProdutoPredominante;
    pSetFocus(edtNCM);
    Exit(False);
  End;

  If (Not fEmptyStr(fTiraCaracEspeciais(mskCEPCarregamento.Text))) And
     (Not fEmptyStr(edtLatitudeCarregamento.Text) Or Not fEmptyStr(edtLongitudeCarregamento.Text)) Then
  Begin
    fMensagem('ATENÇÃO', '[Produto Predominante] - Informe somente CEP ou coordenadas de latitude/longitude!', ['&Ok']);
    pgcSegCar.ActivePage := tbsProdutoPredominante;
    pSetFocus(mskCEPCarregamento);
    Exit(False);
  End;

  If (Not fEmptyStr(edtLatitudeCarregamento.Text)  And fEmptyStr(edtLongitudeCarregamento.Text)) Or
     (Not fEmptyStr(edtLongitudeCarregamento.Text) And fEmptyStr(edtLatitudeCarregamento.Text)) Then
  Begin
    fMensagem('ATENÇÃO', '[Produto Predominante] - Informe sempre as duas coordenadas latitude e longitude!', ['&Ok']);
    pgcSegCar.ActivePage := tbsProdutoPredominante;
    Exit(False);
  End;

  If (Not fEmptyStr(fTiraCaracEspeciais(mskCEPDescarregamento.Text))) And
     (Not fEmptyStr(edtLatitudeDescarregamento.Text) Or Not fEmptyStr(edtLongitudeDescarregamento.Text)) Then
  Begin
    fMensagem('ATENÇÃO', '[Produto Predominante] - Informe somente CEP ou coordenadas de latitude/longitude!', ['&Ok']);
    pgcSegCar.ActivePage := tbsProdutoPredominante;
    pSetFocus(mskCEPDescarregamento);
    Exit(False);
  End;

  If (Not fEmptyStr(edtLatitudeDescarregamento.Text)  And fEmptyStr(edtLongitudeDescarregamento.Text)) Or
     (Not fEmptyStr(edtLongitudeDescarregamento.Text) And fEmptyStr(edtLatitudeDescarregamento.Text)) Then
  Begin
    fMensagem('ATENÇÃO', '[Produto Predominante] - Informe sempre as duas coordenadas latitude e longitude!', ['&Ok']);
    pgcSegCar.ActivePage := tbsProdutoPredominante;
    Exit(False);
  End;

  {Este client armazena somente 1 registro}
  If Not cdsProPre.IsEmpty Then
    cdsProPre.EmptyDataSet;

  cdsProPre.Append;
  cdsProPre.FieldByName('MDF_TIPCAR').AsString  := fstrZero(cbbTipoCarga.ItemIndex +1, 2);
  cdsProPre.FieldByName('MDF_DESPRO').AsString  := edtDescProdutoPredominante.Text;
  cdsProPre.FieldByName('MDF_C_GTIN').AsString  := edtCEAN_GTIN.Text;
  cdsProPre.FieldByName('MDF_CODNCM').AsString  := edtNCM.Text;

  cdsProPre.FieldByName('MDF_CEPCAR').AsString  := fTiraCaracEspeciais(mskCEPCarregamento.Text);
  cdsProPre.FieldByName('MDF_LATCAR').AsString  := edtLatitudeCarregamento.Text;
  cdsProPre.FieldByName('MDF_LONCAR').AsString  := edtLongitudeCarregamento.Text;

  cdsProPre.FieldByName('MDF_CEPDES').AsString  := fTiraCaracEspeciais(mskCEPDescarregamento.Text);
  cdsProPre.FieldByName('MDF_LATDES').AsString  := edtLatitudeDescarregamento.Text;
  cdsProPre.FieldByName('MDF_LONDES').AsString  := edtLongitudeDescarregamento.Text;
  cdsProPre.Post;

end;

function TfrmFatManifestoEletronicoSeguroCarga.fAddProprietarioVeiculo: Boolean;
Var
  blnInformouAlgumCampo,
  blnInformou : Boolean;
begin

  Result := True;

  {Se informou algum campo nessa aba, é obrigatório informar todos os demais.}
  blnInformouAlgumCampo := Not fEmptyStr(fTiraCaracEspeciais(mskCNPJ_CPFProprietario.Text)) Or
                           Not fEmptyStr(edtRNTRC.Text)                         Or
                           Not fEmptyStr(edtNomeRazaoSocialProprietario.Text)   Or
                           Not fEmptyStr(edtIEProprietario.Text)                Or
                           Not fEmptyStr(edtUFProprietario.Text)                Or
                           Not fEmptyStr(cbbTipoProprietario.Text);

  If blnInformouAlgumCampo And fEmptyStr(fTiraCaracEspeciais(mskCNPJ_CPFProprietario.Text)) Then
  Begin
    fMensagem('ATENÇÃO', '[Proprietário do Veículo] - CNPJ/CPF não foi informado!', ['&Ok']);
    pgcSegCar.ActivePage := tbsProprietarioVeiculo;
    pSetFocus(mskCNPJ_CPFProprietario);
    Exit(False);
  End;

  If blnInformouAlgumCampo And fEmptyStr(edtRNTRC.Text) Then
  Begin
    fMensagem('ATENÇÃO', '[Proprietário do Veículo] - RNTRC não foi informado!', ['&Ok']);
    pgcSegCar.ActivePage := tbsProprietarioVeiculo;
    pSetFocus(edtRNTRC);
    Exit(False);
  End;

  If blnInformouAlgumCampo And (Length(edtRNTRC.Text) < 8) Then
  Begin
    fMensagem('ATENÇÃO', '[Proprietário do Veículo] - RNTRC deve conter 8 caracteres no mínimo!', ['&Ok']);
    pgcSegCar.ActivePage := tbsProprietarioVeiculo;
    pSetFocus(edtRNTRC);
    Exit(False);
  End;

  If blnInformouAlgumCampo And fEmptyStr(edtNomeRazaoSocialProprietario.Text) Then
  Begin
    fMensagem('ATENÇÃO', '[Proprietário do Veículo] - Nome ou Razão Social não foi informado!', ['&Ok']);
    pgcSegCar.ActivePage := tbsProprietarioVeiculo;
    pSetFocus(edtNomeRazaoSocialProprietario);
    Exit(False);
  End;

  If blnInformouAlgumCampo And (Length(edtNomeRazaoSocialProprietario.Text) < 2) Then
  Begin
    fMensagem('ATENÇÃO', '[Proprietário do Veículo] - Nome ou Razão Social deve conter 2 caracteres no mínimo!', ['&Ok']);
    pgcSegCar.ActivePage := tbsProprietarioVeiculo;
    pSetFocus(edtNomeRazaoSocialProprietario);
    Exit(False);
  End;

  If blnInformouAlgumCampo And fEmptyStr(edtIEProprietario.Text) Then
  Begin
    fMensagem('ATENÇÃO', '[Proprietário do Veículo] - Inscrição Estadual não foi informado!', ['&Ok']);
    pgcSegCar.ActivePage := tbsProprietarioVeiculo;
    pSetFocus(edtIEProprietario);
    Exit(False);
  End;

  If blnInformouAlgumCampo And fEmptyStr(edtUFProprietario.Text) Then
  Begin
    fMensagem('ATENÇÃO', '[Proprietário do Veículo] - UF não foi informado!', ['&Ok']);
    pgcSegCar.ActivePage := tbsProprietarioVeiculo;
    pSetFocus(edtUFProprietario);
    Exit(False);
  End;

  If blnInformouAlgumCampo And fEmptyStr(cbbTipoProprietario.Text) Then
  Begin
    fMensagem('ATENÇÃO', '[Proprietário do Veículo] - Tipo de Proprietário não foi informado!', ['&Ok']);
    pgcSegCar.ActivePage := tbsProprietarioVeiculo;
    pSetFocus(cbbTipoProprietario);
    Exit(False);
  End;

  If blnInformouAlgumCampo Then
  Begin
    blnInformou := True;
    If fEmptyStr(mskCEPCarregamento.Text) Then
      blnInformou := IIF( (fEmptyStr(edtLatitudeCarregamento.Text) Or fEmptyStr(edtLongitudeCarregamento.Text)), False, True )
    Else
    If (fEmptyStr(mskCEPDescarregamento.Text)) Then
      blnInformou := IIF( (fEmptyStr(edtLatitudeDescarregamento.Text) Or fEmptyStr(edtLongitudeDescarregamento.Text)), False, True );

    If Not blnInformou Then
    Begin
      fMensagem('ATENÇÃO', '[Produto Predominante] - Preencha o grupo Localização de Carregamento e '+
                           ' Localização de Descarregamento!', ['&Ok']);
      pgcSegCar.ActivePage := tbsProdutoPredominante;
      pSetFocus(mskCEPCarregamento);
      Exit(False);
    End;
  End;

  {Este client armazena somente 1 registro}
  If Not cdsMdfPro.IsEmpty Then
    cdsMdfPro.EmptyDataSet;

  If (blnInformouAlgumCampo) Then
  Begin
    cdsMdfPro.Append;
    cdsMdfPro.FieldByName('MDF_CPFCNP').AsString  := fTiraCaracEspeciais(mskCNPJ_CPFProprietario.Text);
    cdsMdfPro.FieldByName('MDF_RNTRC_').AsString  := edtRNTRC.Text;
    cdsMdfPro.FieldByName('MDF_NOMRAZ').AsString  := edtNomeRazaoSocialProprietario.Text;
    cdsMdfPro.FieldByName('MDF_INSEST').AsString  := edtIEProprietario.Text;
    cdsMdfPro.FieldByName('MDF_UF_PRO').AsString  := edtUFProprietario.Text;
    cdsMdfPro.FieldByName('MDF_TIPPRO').AsInteger := cbbTipoProprietario.ItemIndex;
    cdsMdfPro.Post;
  End;

end;

procedure TfrmFatManifestoEletronicoSeguroCarga.pAddSegCar;
  Var
    intSeq : Integer;
begin
  intSeq := fMaxSeq(cdsSegCar);

  cdsSegCar.Append;
  cdsSegCar.FieldByName('MDF_SEQUEN').AsInteger := intSeq + 1;
  cdsSegCar.FieldByName('MDF_RESSEG').AsInteger := IIF(rdgRespSeg.ItemIndex = 0, 1, 2);
  cdsSegCar.FieldByName('MDF_RESCPF').AsString := mskRespCpfCnp.Text;
  cdsSegCar.FieldByName('MDF_NOMSEG').AsString := edtNomeSeguradora.Text;
  cdsSegCar.FieldByName('MDF_SEGCNP').AsString := mskCnpSeguradora.Text;
  cdsSegCar.FieldByName('MDF_NUMAPO').AsString := edtNumApolice.Text;
  cdsSegCar.Post;
end;

procedure TfrmFatManifestoEletronicoSeguroCarga.pAddSegCarAver;
  Var
    intSeq : Integer;
begin
  intSeq := fMaxSeq(cdsSegCarAver);

  cdsSegCarAver.Append;
  cdsSegCarAver.FieldByName('MDF_SEQUEN').AsInteger := intSeq + 1;
  cdsSegCarAver.FieldByName('MDF_NUMAVE').AsString := edtNumAverb.Text;
  cdsSegCarAver.Post;
end;

procedure TfrmFatManifestoEletronicoSeguroCarga.pLimparProprietarioVeiculo;
begin
  edtCNPJ_CPFProprietario.Text := '2';
  mskCNPJ_CPFProprietario.Clear;
  edtRNTRC.Clear;
  edtNomeRazaoSocialProprietario.Clear;
  edtIEProprietario.Clear;
  edtUFProprietario.Clear;
  cbbTipoProprietario.ItemIndex := -1;
end;

procedure TfrmFatManifestoEletronicoSeguroCarga.pLimparComponentes;
begin

  edtSeqMDFCOM.Clear;
  cbbTipoComponente.ItemIndex := -1;
  edtValorComponente.Clear;
  edtDescricaoComponente.Clear;

  pSetFocus(cbbTipoComponente);

end;

procedure TfrmFatManifestoEletronicoSeguroCarga.pLimparInformacoesPagamentoFrete;
begin

  edtSeqMDFPAG.Clear;
  edtNomeResponsavel.Clear;
  edtCNPJ_CPF.Text := '2';
  mskCNPJ_CPF.Clear;
  edtIDEstrangeiro.Clear;
  edtValorTotalContrato.Clear;
  rdgFormaPagamento.ItemIndex := -1;
  edtNumeroBanco.Clear;
  edtNumeroAgencia.Clear;
  mskCNPJInstituicaoPag.Clear;
  btnLimpaPixClick(nil);
  edtValorAdiantamento.Clear;

  pSetFocus(edtNomeResponsavel);

end;

procedure TfrmFatManifestoEletronicoSeguroCarga.pLimparPrazos;
begin

  edtSeqMDFPRA.Clear;
  edtNumeroParcelas.Clear;
  mskDataVencimento.Clear;
  edtValorParcela.Clear;

  pSetFocus(edtNumeroParcelas);

end;

procedure TfrmFatManifestoEletronicoSeguroCarga.pLimparProdutoPredominante;
begin
  cbbTipoCarga.ItemIndex := -1;
  edtDescProdutoPredominante.Clear;
  edtCEAN_GTIN.Clear;
  edtNCM.Clear;
  mskCEPCarregamento.Clear;
  edtLatitudeCarregamento.Clear;
  edtLongitudeCarregamento.Clear;
  mskCEPDescarregamento.Clear;
  edtLatitudeDescarregamento.Clear;
  edtLongitudeDescarregamento.Clear;
end;

procedure TfrmFatManifestoEletronicoSeguroCarga.pLimparSegCar;
begin
  mskRespCpfCnp.Clear;
  edtNomeSeguradora.Text := '';
  mskCnpSeguradora.Clear;
  edtNumApolice.Text := '';
end;

procedure TfrmFatManifestoEletronicoSeguroCarga.pLimparSegCarAver;
begin
  edtNumAverb.Text := '';
end;

procedure TfrmFatManifestoEletronicoSeguroCarga.pReindexar(
  cdsDados: TUniClientDataSet);
  Var
    intRecNo : Integer;
    intCnt   : Integer;
begin
  If (cdsDados.IsEmpty) Then
    Exit;

  intRecNo := cdsDados.RecNo;
  cdsDados.DisableControls;
  Try
    intCnt := 0;

    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      intCnt := intCnt + 1;

      cdsDados.Edit;
      cdsDados.FieldByName('MDF_SEQUEN').AsInteger := intCnt;
      cdsDados.Post;

      cdsDados.Next;
    End;
  Finally
    cdsDados.RecNo := intRecNo;
    cdsDados.EnableControls;
  End;
end;

procedure TfrmFatManifestoEletronicoSeguroCarga.pReindexarComponentes;
var
  intSeq : Integer;
begin

  If cdsMDFCOM.IsEmpty Then
    Exit;

  cdsMDFCOM.DisableControls;

  Try

    intSeq := 1;
    cdsMDFCOM.First;
    While Not cdsMDFCOM.Eof Do
    Begin

      cdsMDFCOM.Edit;
      cdsMDFCOMMDF_SEQCOM.AsInteger := intSeq;
      cdsMDFCOM.Post;

      intSeq := intSeq +1;
      cdsMDFCOM.Next;

    End;

  Finally
    cdsMDFCOM.EnableControls;
  End;

end;

procedure TfrmFatManifestoEletronicoSeguroCarga.pReindexarInfPagFre;
var
  intSeq : Integer;
begin

  If cdsMDFPAG.IsEmpty Then
    Exit;

  cdsMDFPAG.DisableControls;

  Try

    intSeq := 1;
    cdsMDFPAG.First;
    While Not cdsMDFPAG.Eof Do
    Begin

      {Prazos}
      cdsMDFPRA.First;
      While Not cdsMDFPRA.Eof Do
      Begin
        cdsMDFPRA.Edit;
        cdsMDFPRAMDF_SEQPAG.AsInteger := intSeq;
        cdsMDFPRA.Post;
        cdsMDFPRA.Next;
      End;

      {Componentes}
      cdsMDFCOM.First;
      While Not cdsMDFCOM.Eof Do
      Begin
        cdsMDFCOM.Edit;
        cdsMDFCOMMDF_SEQPAG.AsInteger := intSeq;
        cdsMDFCOM.Post;
        cdsMDFCOM.Next;
      End;

      cdsMDFPAG.Edit;
      cdsMDFPAGMDF_SEQPAG.AsInteger := intSeq;
      cdsMDFPAG.Post;

      intSeq := intSeq +1;
      cdsMDFPAG.Next;

    End;

  Finally
    cdsMDFPAG.EnableControls;
  End;

end;

procedure TfrmFatManifestoEletronicoSeguroCarga.pReindexarPrazos;
var
  intSeq : Integer;
begin

  If cdsMDFPRA.IsEmpty Then
    Exit;

  cdsMDFPRA.DisableControls;

  Try

    intSeq := 1;
    cdsMDFPRA.First;
    While Not cdsMDFPRA.Eof Do
    Begin

      cdsMDFPRA.Edit;
      cdsMDFPRAMDF_SEQPRA.AsInteger := intSeq;
      cdsMDFPRA.Post;

      intSeq := intSeq +1;
      cdsMDFPRA.Next;

    End;

  Finally
    cdsMDFPRA.EnableControls;
  End;

end;

procedure TfrmFatManifestoEletronicoSeguroCarga.rdgFormaPagamentoClick(
  Sender: TObject);
begin
  inherited;
  edtValorAdiantamento.Enabled := (rdgFormaPagamento.ItemIndex = 1);
end;

procedure TfrmFatManifestoEletronicoSeguroCarga.rdgPIXClick(Sender: TObject);
begin
  inherited;
  if (rdgPIX.ItemIndex <> intRdgPIX) then
  begin
    intRdgPIX := rdgPIX.ItemIndex;
    mskPIX.Clear;
    edtPixEmail_Chave.Clear;
  end;

  mskPIX.Visible := (rdgPIX.ItemIndex > 0) and (rdgPIX.ItemIndex < 4);
  edtPixEmail_Chave.Visible := (rdgPIX.ItemIndex in [0,4]);
  case rdgPIX.ItemIndex of
    1: mskPIX.EditMask := '999.999.999-99;0;';
    2: mskPIX.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_);
    3: mskPIX.EditMask := '!\(99\)99999-9999;0;';
  end;
end;

end.
