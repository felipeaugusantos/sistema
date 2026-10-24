unit untFatManifestoEletronicoEventoPagamentoOperacaoTransporte;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Data.DB, Datasnap.DBClient, UniClientDataSet,
  ComboBoxFocus, Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.Mask, MaskEditFocus,
  untMskC_G_C_, Vcl.ComCtrls, MemDS, DBAccess, Uni, System.StrUtils;

type
  TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label7: TLabel;
    edtNumMan: TEditFocus;
    cdsMDFPAG: TUniClientDataSet;
    cdsMDFPAGMDF_NOMRES: TStringField;
    cdsMDFPAGMDF_CPFCNP: TStringField;
    cdsMDFPAGMDF_ESTRAN: TStringField;
    cdsMDFPAGMDF_VALTOT: TCurrencyField;
    cdsMDFPAGMDF_FORPAG: TIntegerField;
    cdsMDFPAGMDF_NUMBAN: TStringField;
    cdsMDFPAGMDF_NUMAGE: TStringField;
    cdsMDFPAGMDF_CNPJPG: TStringField;
    cdsMDFPAGMDF_SEQPAG: TIntegerField;
    cdsMDFPAGTIPO_CNPJ_CPF: TStringField;
    dsMDFPAG: TDataSource;
    cdsMDFCOM: TUniClientDataSet;
    cdsMDFCOMMDF_SEQPAG: TIntegerField;
    cdsMDFCOMMDF_SEQCOM: TIntegerField;
    cdsMDFCOMMDF_TIPCOM: TStringField;
    cdsMDFCOMMDF_VALCOM: TCurrencyField;
    cdsMDFCOMMDF_DESCOM: TStringField;
    dsMDFCOM: TDataSource;
    dsMDFPRA: TDataSource;
    cdsMDFPRA: TUniClientDataSet;
    cdsMDFPRAMDF_SEQPAG: TIntegerField;
    cdsMDFPRAMDF_SEQPRA: TIntegerField;
    cdsMDFPRAMDF_NUMPAR: TIntegerField;
    cdsMDFPRAMDF_DTAVEN: TStringField;
    cdsMDFPRAMDF_VALPAR: TCurrencyField;
    cdsMDFPRAccVENCIMENTO: TStringField;
    pgcEventoPagamentoOperacaoTransporte: TPageControl;
    tbsInformacoesDoPagamentoDoFrete: TTabSheet;
    gbMDFPAG: TGroupBox;
    lblValorContrato: TLabel;
    lblCamposObrigatoriosInfPag: TLabel;
    lblValorTotalContratoObrigatorio: TLabel;
    lblFormaPagamentoObrigatorio: TLabel;
    lblNumeroBancoObrigatorio: TLabel;
    gbResponsavelPagamento: TGroupBox;
    lblNomeResponsavelPagamento: TLabel;
    lblIDEstrangeiro: TLabel;
    lblCNPJ_CPF: TLabel;
    lblSeqMDFPAG: TLabel;
    lblOu: TLabel;
    edtNomeResponsavel: TEditFocus;
    edtIDEstrangeiro: TEditFocus;
    edtCNPJ_CPF: TEditFocus;
    mskCNPJ_CPF: TMaskEditC_G_C_;
    edtSeqMDFPAG: TEditFocus;
    btnAddInfPag: TBitBtnLocked;
    gbInformacoesBancarias: TGroupBox;
    lblNumeroBanco: TLabel;
    lblNumeroAgencia: TLabel;
    lblCNPJInstituicao: TLabel;
    lblOu_: TLabel;
    edtNumeroBanco: TEditFocus;
    edtNumeroAgencia: TEditFocus;
    mskCNPJInstituicaoPag: TMaskEditC_G_C_;
    dbgInformacoesPagamento: TDBGridCitel;
    rdgFormaPagamento: TRadioGroup;
    edtValorTotalContrato: TEditFocus;
    gbComponentes: TGroupBox;
    lblTipoComponente: TLabel;
    lblTipoComponenteObrigatorio: TLabel;
    lblValorComponente: TLabel;
    lblValorComponenteObrigatorio: TLabel;
    lblDescricaoComponente: TLabel;
    lblSeqMDFCOM: TLabel;
    cbbTipoComponente: TComboBoxFocus;
    edtValorComponente: TEditFocus;
    edtDescricaoComponente: TEditFocus;
    btnAddComponente: TBitBtnLocked;
    dbgComponentes: TDBGridCitel;
    edtSeqMDFCOM: TEditFocus;
    gbPrazos: TGroupBox;
    lblSeqMDFPRA: TLabel;
    lblValorParcela: TLabel;
    lblValorParcelaObrigatorio: TLabel;
    lblDataVencimento: TLabel;
    lblNumeroParcelas: TLabel;
    edtSeqMDFPRA: TEditFocus;
    edtValorParcela: TEditFocus;
    mskDataVencimento: TMaskEditFocus;
    edtNumeroParcelas: TEditFocus;
    btnAddPrazo: TBitBtnLocked;
    dbgPrazos: TDBGridCitel;
    btnGravar: TBitBtnLocked;
    tbsPagamentoOperacaoTransporte: TTabSheet;
    Label1: TLabel;
    edtNumeroProtocolo: TEditFocus;
    Label2: TLabel;
    edtQtdViagens: TEditFocus;
    Label3: TLabel;
    edtNumeroViagem: TEditFocus;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    bevelSeparador: TBevel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    cdsMDFPAGMDF_CHAPIX: TStringField;
    rdgPIX: TRadioGroup;
    btnLimpaPix: TBitBtnLocked;
    mskPIX: TMaskEditC_G_C_;
    edtPixEmail_Chave: TEditFocus;
    cdsMDFPAGMDF_TIPPIX: TIntegerField;
    lblValorAdiantamento: TLabel;
    edtValorAdiantamento: TEditFocus;
    cdsMDFPAGMDF_VALADI: TCurrencyField;
    Label11: TLabel;
    Label12: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure cdsMDFPAGAfterScroll(DataSet: TDataSet);
    procedure btnAddInfPagClick(Sender: TObject);
    procedure btnAddComponenteClick(Sender: TObject);
    procedure btnAddPrazoClick(Sender: TObject);
    procedure dbgInformacoesPagamentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgComponentesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgPrazosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgInformacoesPagamentoDblClick(Sender: TObject);
    procedure dbgComponentesDblClick(Sender: TObject);
    procedure dbgPrazosDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCNPJ_CPFChange(Sender: TObject);
    procedure btnLimpaPixClick(Sender: TObject);
    procedure rdgPIXClick(Sender: TObject);
    procedure rdgFormaPagamentoClick(Sender: TObject);
  private
    { Private declarations }

    intRdgPIX: Integer;

    procedure pReindexarInfPagFre;
    procedure pReindexarPrazos;
    procedure pReindexarComponentes;

    procedure pLimparPagamentoOperacaoTransporte;
    procedure pLimparInformacoesPagamentoFrete;
    procedure pLimparComponentes;
    procedure pLimparPrazos;

    procedure pLimparTela;

    function fGetSql : String;
    function fGetSqlNFe: string;
    function fGetSqlCTe: string;
    function fManifestoEncontradoEAprovado(strNumMan : String) : Boolean;
    function fCarregarManifesto(strNumMan : String) : Boolean;

    function fManifestoTAC_Agregado(strNumMan, strCodEmp : String) : Boolean;

    function fDDMMAAAA_To_DDMMAAAA(strData : String) : String;

    function fGravarEventoPagamentoOperacaoTransporte(strNumMan : String) : Boolean;

    function fDeletarInformacoesPagamentoFrete(strNumMan : String) : Boolean;
    function fGravarInformacoesPagamentoFrete(strNumMan : String) : Boolean;

    function fValidouInformacoesPagamentoFreteObrigatorias : Boolean;

    {Validações}
    function fValidaObrigatoriedadeInformacoesBancarias : Boolean;
    function fValidaEstrangeiro : Boolean;
    function fValidaInformacoesPagamento : Boolean;
    procedure pGrava_Envia;
    function fNumeroParcelaJaExiste(strSeqMDFPRA: string): Boolean;
    function fDataVencimentoParcelaJaExiste(strSeqMDFPRA: string): Boolean;
    function fValidaDataVencimentoParcela(strSeqMDFPRA: string): Boolean;
    function fValidaParcela(strSeqMDFPRA: string): Boolean;
    function fValidaDadosPagamento: Boolean;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untFuncoesSimples, untLibNfe, untFuncoesGenerica;

{$R *.dfm}

{ TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte }

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.btnAddComponenteClick(Sender: TObject);
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

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.btnAddInfPagClick(Sender: TObject);
var
  intSeq : Integer;
  strChavePix: string;
begin
  inherited;

  If (Not fVerificaCampos) Then
    Exit;

  {Informar ID Estrangeiro ou CPF/CNPJ}
  If Not fValidaEstrangeiro Then
    Exit;

  If not fValidaDadosPagamento Then
    Exit;

  {Deve informar Banco+Agência ou CNPJ}
  If Not fValidaObrigatoriedadeInformacoesBancarias Then
    Exit;

  strChavePix := '';
  if (rdgPIX.ItemIndex in [0,4]) then
    strChavePix := edtPixEmail_Chave.Text
  else if (rdgPIX.ItemIndex > 0) then
    strChavePix := IIF(rdgPIX.ItemIndex = 3, '+55', '') + fTiraCaracEspeciais(mskPIX.Text);

  cdsMDFPAG.Edit;
  If fEmptyStr(edtSeqMDFPAG.Text) Then
  Begin
    intSeq := IIF(cdsMDFPAG.IsEmpty, 1, cdsMDFPAG.RecordCount +1);
    cdsMDFPAG.Append;
    cdsMDFPAGMDF_SEQPAG.AsInteger := intSeq;
  End;

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

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.btnAddPrazoClick(Sender: TObject);
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

  if not fValidaParcela(edtSeqMDFPRA.Text) then
    Exit;

  if not fValidaDataVencimentoParcela(edtSeqMDFPRA.Text) then
    Exit;

  If fStrToFloat(edtValorParcela.Text) <= 0 Then
  Begin
    pMensagemOk('Obrigatório informar o valor da parcela!');
    pSetFocus(edtValorParcela);
    Exit;
  End;

  Try

    cdsMDFPRA.Edit;
    If fEmptyStr(edtSeqMDFPRA.Text) Then
    Begin
      intSeq := IIF(cdsMDFPRA.IsEmpty, 1, cdsMDFPRA.RecordCount +1);
      cdsMDFPRA.Append;
      cdsMDFPRAMDF_SEQPAG.AsInteger  := cdsMDFPAGMDF_SEQPAG.AsInteger;
      cdsMDFPRAMDF_SEQPRA.AsInteger  := intSeq;
    End;

    If TryStrToInt(edtNumeroParcelas.Text, intNumPar) Then
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

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.btnGravarClick(Sender: TObject);
begin

  inherited;

  If fEmptyStr(edtNumMan.Text) Then
    Exit;

  If Not pgcEventoPagamentoOperacaoTransporte.Enabled Then
    Exit;

  If fEmptyStr(edtQtdViagens.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'É obrigatório informar o campo "Quantidade de Viagens"!', ['&Ok']);
    pgcEventoPagamentoOperacaoTransporte.ActivePage := tbsPagamentoOperacaoTransporte;
    pSetFocus(edtQtdViagens);
    Exit;
  End;

  If fEmptyStr(edtNumeroViagem.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'É obrigatório informar o campo "Número de Viagem"!', ['&Ok']);
    pgcEventoPagamentoOperacaoTransporte.ActivePage := tbsPagamentoOperacaoTransporte;
    pSetFocus(edtNumeroViagem);
    Exit;
  End;

  If Not fValidaInformacoesPagamento Then
    Exit;

  {Atualiza/Regrava dados!}
  fStartTransaction;

  Try

    pGrava_Envia;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.btnGravarClick]');
    End;
  End;

end;

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.btnLimpaPixClick(
  Sender: TObject);
begin
  inherited;

  rdgPIX.ItemIndex := -1;
  rdgPIXClick(nil);
end;

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.cdsMDFPAGAfterScroll(DataSet: TDataSet);
begin

  inherited;

  If (cdsMDFPAG.IsEmpty) Then
    Exit;

  If fEmptyStr(cdsMDFPAGMDF_SEQPAG.AsString) Then
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

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.dbgComponentesDblClick(Sender: TObject);
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

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.dbgComponentesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  inherited;

  If (Key = VK_DELETE) Then
  Begin
    If cdsMDFCOM.Active Then
      If (cdsMDFCOM.RecordCount > 0) Then
       If (fMensagem('', 'Deseja remover o componente selecionado?', ['&Sim', '&Não'], 2) = 1) Then
         Begin
           cdsMDFCOM.Delete;
           pReindexarComponentes;
         End;
  End;

end;

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.dbgInformacoesPagamentoDblClick(Sender: TObject);
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

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.dbgInformacoesPagamentoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  inherited;

  If (Key = VK_DELETE) Then
  Begin

    If (Not cdsMDFCOM.IsEmpty) Then
    Begin
      fMensagem('ATENÇÃO', 'Apague todos os "Componentes" e "Prazos" vinculados a este registro antes de deletar o mesmo!', ['&Ok']);
      Exit;
    End;

    If (Not cdsMDFPRA.IsEmpty) Then
    Begin
      fMensagem('ATENÇÃO', 'Apague todos os "Componentes" e "Prazos" vinculados a este registro antes de deletar o mesmo!', ['&Ok']);
      Exit;
    End;

    If cdsMDFPAG.Active Then
      If (cdsMDFPAG.RecordCount > 0) Then
        If (fMensagem('', 'Deseja remover a "Informação de Pagamento do Frete" selecionado?', ['&Sim', '&Não'], 2) = 1) Then
          Begin
            cdsMDFPAG.Delete;
            pReindexarInfPagFre;
          End;

  End
  Else
  If (Key = VK_RETURN) Then
    dbgInformacoesPagamentoDblClick(Self);

end;

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.dbgPrazosDblClick(Sender: TObject);
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

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.dbgPrazosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  inherited;

  If (Key = VK_DELETE) Then
  Begin

    If (cdsMDFPRA.Active) Then
      If (cdsMDFPRA.RecordCount > 0) Then
        If (fMensagem('', 'Deseja remover o prazo selecionado?', ['&Sim', '&Não'], 2) = 1) Then
          Begin
            cdsMDFPRA.Delete;
            pReindexarPrazos;
          End;
  End;

end;

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.edtCNPJ_CPFChange(Sender: TObject);
begin
  inherited;
  mskCNPJ_CPF.EditMask := fRetMascaraC_G_C_(fSetaPais, IIF(edtCNPJ_CPF.Text = '1', C_G_C_, C_P_F_));
end;

function TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.fGetSql : String;
begin
  if (fTipoDocManifesto(edtNumMan.Text) = 'CTe') then
    Result := fGetSqlCTe
  else
    Result := fGetSqlNFe;
end;

function TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.fGetSqlCTe: string;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  FIS_DTAMAN AS DTAMAN, ';
  Result := Result + '  CONCAT_WS("-", FIS_NUMDOC, FIS_ESPDOC, FIS_CODEMP) AS NUMDOC, ';
  Result := Result + '  IF(IFNULL(GER_NOMCON,"") <> "", GER_CGCCON, CLI_C_G_C_) AS CNPJDE, ';
  Result := Result + '  IF(IFNULL(GER_NOMCON,"") <> "", GER_NOMCON, CLI_NOMCLI) AS NOMDES, ';
  Result := Result + '  GER_VLRCON AS VLRCON, ';
  Result := Result + '  CADFIS.AUTOINCREM AS AUTOINCREM ';
  Result := Result + 'FROM ';
  Result := Result + '  CADFIS ';
  Result := Result + '  JOIN MOVCTE ON FIS_NUMDOC = CONCAT("000", CTE_NUMCTE) ';
  Result := Result + '             AND FIS_CODEMP =  CTE_CODEMP ';
  Result := Result + '  LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI AND FIS_TIP_FC = "C" ';
  Result := Result + '  JOIN MOVGER ON CTE_SEQGER = MOVGER.AUTOINCREM ';
  Result := Result + 'WHERE ';
  Result := Result + '  IFNULL(FIS_ACEMAN, "") <> "" AND ';
  Result := Result + '  FIS_ENCERR IS NULL AND ';
  Result := Result + '  FIS_ESPDOC = "CT" AND ';
  Result := Result + '  FIS_ENTSAI = "S" AND ';
  Result := Result + '  FIS_EMPMAN = :CODEMP AND ';
  Result := Result + '  FIS_NUMMAN = :NUMMAN ';

  Result := Result + 'UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(Result, 'MOVGER', 'NOTGER'), 'MOVCTE', 'NOTCTE');
end;

function TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.fGetSqlNFe: string;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  FIS_DTAMAN AS DTAMAN, ';
  Result := Result + '  CONCAT_WS("-", FIS_NUMDOC, FIS_ESPDOC, FIS_CODEMP) AS NUMDOC, ';
  Result := Result + '  IF(IFNULL(GER_NOMCON,"") <> "", GER_CGCCON, IFNULL(CLI_C_G_C_, FOR_C_G_C_)) AS CNPJDE, ';
  Result := Result + '  IF(IFNULL(GER_NOMCON,"") <> "", GER_NOMCON, IFNULL(CLI_NOMCLI, FOR_NOMFOR)) AS NOMDES, ';
  Result := Result + '  GER_VLRCON AS VLRCON, ';
  Result := Result + '  CADFIS.AUTOINCREM AS AUTOINCREM ';
  Result := Result + 'FROM ';
  Result := Result + '  CADFIS ';
  Result := Result + '  LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI AND FIS_TIP_FC = "C" ';
  Result := Result + '  LEFT JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI AND FIS_TIP_FC = "F" ';
  Result := Result + '  JOIN MOVGER ON GER_NUMDOC = FIS_NUMDOC AND ';
  Result := Result + '                 GER_ESPDOC = FIS_ESPDOC AND ';
  Result := Result + '                 GER_CODEMP = FIS_CODEMP AND ';
  Result := Result + '                 GER_TIP_FC = FIS_TIP_FC AND ';
  Result := Result + '                 IFNULL(GER_CODCLI, FOR_CODFOR) = FIS_FORCLI AND ';
  Result := Result + '                 IFNULL(GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  Result := Result + 'WHERE ';
  Result := Result + '  IFNULL(FIS_ACEMAN, "") <> "" AND ';
  Result := Result + '  FIS_ENCERR IS NULL AND ';
  Result := Result + '  FIS_ESPDOC IN ("NF", "EL") AND ';
  Result := Result + '  FIS_CLFSC1 > "5000" AND ';
  Result := Result + '  FIS_ORIDOC = "V" AND ';
  Result := Result + '  FIS_EMPMAN = :CODEMP AND ';
  Result := Result + '  FIS_NUMMAN = :NUMMAN ';

  Result := Result + 'UNION ALL ' + AnsiReplaceStr(Result, 'MOVGER', 'NOTGER');
end;

function TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.fGravarEventoPagamentoOperacaoTransporte(strNumMan : String) : Boolean;
Var
  intNumPro,
  intQtdVia,
  intNumVia : Integer;
  qryMDFEVE : TUniQuery;
begin

  If fEmptyStr(strNumMan) Then
    Exit(False);

  Try

    qryMDFEVE := fCriaQuery(Self);

    Try

      qryMDFEVE.Close;
      qryMDFEVE.SQL.Clear;
      qryMDFEVE.SQL.Text := 'SELECT * FROM MDFEVE WHERE MDF_NUMMAN = :NUMMAN AND MDF_EMPMAN = :EMPMAN';
      qryMDFEVE.ParamByName('NUMMAN').AsString := strNumMan;
      qryMDFEVE.ParamByName('EMPMAN').AsString := VS_strCodEmp;
      qryMDFEVE.Open;

      If Not qryMDFEVE.IsEmpty Then
        qryMDFEVE.Edit
      Else
      Begin
        qryMDFEVE.Append;
        qryMDFEVE.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('MDFEVE', VS_strCodEmp);
        qryMDFEVE.FieldByName('MDF_NUMMAN').AsString  := strNumMan;
        qryMDFEVE.FieldByName('MDF_EMPMAN').AsString  := VS_strCodEmp;
      End;

      If TryStrToInt(edtNumeroProtocolo.Text, intNumPro) Then
        qryMDFEVE.FieldByName('MDF_NUMPRO').AsInteger := intNumPro;

      If TryStrToInt(edtQtdViagens.Text, intQtdVia) Then
        qryMDFEVE.FieldByName('MDF_QTDVIA').AsInteger := intQtdVia;

      If TryStrToInt(edtNumeroViagem.Text, intNumVia) Then
        qryMDFEVE.FieldByName('MDF_NUMVIA').AsInteger := intNumVia;

      qryMDFEVE.Post;

      Result := True;

    Finally
      FreeAndNil(qryMDFEVE);
    End;

  Except
    Result := False;
  End;

end;

function TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.fGravarInformacoesPagamentoFrete(strNumMan: String): Boolean;
Var
  qryMdfPAG : TUniQuery;
  qryMdfCOM : TUniQuery;
  qryMdfPRA : TUniQuery;
begin

  If fEmptyStr(strNumMan) Then
    Exit(False);

  qryMdfPAG := fCriaQuery(Self);
  qryMdfCOM := fCriaQuery(Self);
  qryMdfPRA := fCriaQuery(Self);

  qryMdfPAG.Close;
  qryMdfPAG.SQL.Clear;
  qryMdfPAG.SQL.Text := 'SELECT * FROM MDFPAG WHERE FALSE';
  qryMdfPAG.Open;

  qryMdfCOM.Close;
  qryMdfCOM.SQL.Clear;
  qryMdfCOM.SQL.Text := 'SELECT * FROM MDFCOM WHERE FALSE';
  qryMdfCOM.Open;

  qryMdfPRA.Close;
  qryMdfPRA.SQL.Clear;
  qryMdfPRA.SQL.Text := 'SELECT * FROM MDFPRA WHERE FALSE';
  qryMdfPRA.Open;

  Try

    cdsMDFPAG.First;

    While Not cdsMDFPAG.Eof Do
    Begin

      qryMdfPAG.Append;
      qryMdfPAG.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('MDFPAG', VS_strCodEmp);
      qryMdfPAG.FieldByName('MDF_NUMMAN').AsString   := strNumMan;
      qryMdfPAG.FieldByName('MDF_EMPMAN').AsString   := VS_strCodEmp;
      qryMdfPAG.FieldByName('MDF_SEQPAG').AsInteger  := cdsMDFPAG.FieldByName('MDF_SEQPAG').AsInteger;
      qryMdfPAG.FieldByName('MDF_NOMRES').AsString   := cdsMDFPAG.FieldByName('MDF_NOMRES').AsString;
      qryMdfPAG.FieldByName('MDF_CPFCNP').AsString   := cdsMDFPAG.FieldByName('MDF_CPFCNP').AsString;
      qryMdfPAG.FieldByName('MDF_ESTRAN').AsString   := cdsMDFPAG.FieldByName('MDF_ESTRAN').AsString;
      qryMdfPAG.FieldByName('MDF_VALTOT').AsCurrency := cdsMDFPAG.FieldByName('MDF_VALTOT').AsCurrency;
      qryMdfPAG.FieldByName('MDF_FORPAG').AsInteger  := cdsMDFPAG.FieldByName('MDF_FORPAG').AsInteger;
      qryMdfPAG.FieldByName('MDF_NUMBAN').AsString   := cdsMDFPAG.FieldByName('MDF_NUMBAN').AsString;
      qryMdfPAG.FieldByName('MDF_NUMAGE').AsString   := cdsMDFPAG.FieldByName('MDF_NUMAGE').AsString;
      qryMdfPAG.FieldByName('MDF_CNPJPG').AsString   := cdsMDFPAG.FieldByName('MDF_CNPJPG').AsString;
      qryMdfPAG.FieldByName('MDF_TIPPIX').AsString   := cdsMDFPAG.FieldByName('MDF_TIPPIX').AsString;
      qryMdfPAG.FieldByName('MDF_CHAPIX').AsString   := cdsMDFPAG.FieldByName('MDF_CHAPIX').AsString;
      qryMdfPAG.FieldByName('MDF_VALADI').AsCurrency := cdsMDFPAG.FieldByName('MDF_VALADI').AsCurrency;
      qryMdfPAG.Post;

      {Componentes}
      If Not cdsMDFCOM.IsEmpty Then
      Begin

        cdsMDFCOM.First;
        While Not cdsMDFCOM.Eof Do
        Begin

          qryMdfCOM.Append;
          qryMdfCOM.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('MDFCOM', VS_strCodEmp);
          qryMdfCOM.FieldByName('MDF_NUMMAN').AsString   := strNumMan;
          qryMdfCOM.FieldByName('MDF_EMPMAN').AsString   := VS_strCodEmp;
          qryMdfCOM.FieldByName('MDF_SEQPAG').AsInteger  := cdsMDFCOM.FieldByName('MDF_SEQPAG').AsInteger;
          qryMdfCOM.FieldByName('MDF_SEQCOM').AsInteger  := cdsMDFCOM.FieldByName('MDF_SEQCOM').AsInteger;
          qryMdfCOM.FieldByName('MDF_TIPCOM').AsString   := cdsMDFCOM.FieldByName('MDF_TIPCOM').AsString;
          qryMdfCOM.FieldByName('MDF_VALCOM').AsCurrency := cdsMDFCOM.FieldByName('MDF_VALCOM').AsCurrency;
          qryMdfCOM.FieldByName('MDF_DESCOM').AsString   := cdsMDFCOM.FieldByName('MDF_DESCOM').AsString;
          qryMdfCOM.Post;

          cdsMDFCOM.Next;

        End;

      End;

      {Prazos}
      If Not cdsMDFPRA.IsEmpty Then
      Begin

        cdsMDFPRA.First;
        While Not cdsMDFPRA.Eof Do
        Begin

          qryMdfPRA.Append;
          qryMdfPRA.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('MDFPRA', VS_strCodEmp);
          qryMdfPRA.FieldByName('MDF_NUMMAN').AsString   := strNumMan;
          qryMdfPRA.FieldByName('MDF_EMPMAN').AsString   := VS_strCodEmp;
          qryMdfPRA.FieldByName('MDF_SEQPAG').AsInteger  := cdsMDFPRA.FieldByName('MDF_SEQPAG').AsInteger;
          qryMdfPRA.FieldByName('MDF_SEQPRA').AsInteger  := cdsMDFPRA.FieldByName('MDF_SEQPRA').AsInteger;
          qryMdfPRA.FieldByName('MDF_NUMPAR').AsInteger  := cdsMDFPRA.FieldByName('MDF_NUMPAR').AsInteger;
          qryMdfPRA.FieldByName('MDF_DTAVEN').AsString   := cdsMDFPRA.FieldByName('MDF_DTAVEN').AsString;
          qryMdfPRA.FieldByName('MDF_VALPAR').AsCurrency := cdsMDFPRA.FieldByName('MDF_VALPAR').AsCurrency;
          qryMdfPRA.Post;

          cdsMDFPRA.Next;

        End;

      End;

      cdsMDFPAG.Next;

    End;

  Finally
    FreeAndNil(qryMdfPAG);
    FreeAndNil(qryMdfCOM);
    FreeAndNil(qryMdfPRA);
  End;

  Result := True;

end;

function TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.fManifestoEncontradoEAprovado(strNumMan: String): Boolean;
Var
  qryAux : TUniQuery;
begin

  If fEmptyStr(strNumMan) Then
    Exit(False);

  qryAux := fCriaQuery(Self);

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(fGetSql);
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.ParamByName('NUMMAN').AsString := strNumMan;
    qryAux.Open;

    Result := Not qryAux.IsEmpty;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.fManifestoTAC_Agregado(strNumMan, strCodEmp: String): Boolean;
Var
  qryAux : TUniQuery;
Const
  strSQL = 'SELECT * FROM MDFPRO WHERE MDF_NUMMAN = :NUMMAN AND MDF_EMPMAN = :EMPMAN AND MDF_TIPPRO = 0';
begin

  If fEmptyStr(strNumMan) Then
    Exit(False);

  If fEmptyStr(strCodEmp) then
    Exit(False);

  qryAux := fCriaQuery;

  Try

    qryAux.Close;
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('NUMMAN').AsString := strNumMan;
    qryAux.ParamByName('EMPMAN').AsString := strCodEmp;
    qryAux.Open;

    Result := Not qryAux.IsEmpty;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.fNumeroParcelaJaExiste(strSeqMDFPRA: string): Boolean;
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

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  inherited;

  {Se informações carregadas...}
  If (pgcEventoPagamentoOperacaoTransporte.Enabled) Then
  Begin

    If fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não'], 2) = 1 Then
      pLimparTela;

    Action := caNone;

  End;

end;

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.FormCreate(Sender: TObject);
begin

  inherited;

  cdsMDFPAG.CreateDataSet;
  cdsMDFPAG.EmptyDataSet;

  cdsMDFCOM.CreateDataSet;
  cdsMDFCOM.EmptyDataSet;

  cdsMDFPRA.CreateDataSet;
  cdsMDFPRA.EmptyDataSet;

  pgcEventoPagamentoOperacaoTransporte.ActivePageIndex := 0;

  intRdgPIX := -1;
end;

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  inherited;

  If Key = VK_F10 Then
    btnGravar.Click
  Else
    inherited;

end;

function TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin

    If (Sender = edtNumMan) And (Not pgcEventoPagamentoOperacaoTransporte.Enabled) Then
    Begin

      If fEmptyStr(edtNumMan.Text) Then
      Begin
        pMensagemOk('O número do manifesto deve ser preenchido.');
        Result := False;
      End
      Else
      Begin

        If (fManifestoEncontradoEAprovado(edtNumMan.Text)) Then
        Begin

          Screen.Cursor := crHourGlass;

          Try

            If fCarregarManifesto(edtNumMan.Text) Then
            Begin
              pnlCabecalho.Enabled := False;
              pgcEventoPagamentoOperacaoTransporte.Enabled  := True;
              pgcEventoPagamentoOperacaoTransporte.TabIndex := 0;
              If edtNumeroProtocolo.Visible Then
                pSetFocus(edtNumeroProtocolo)
              Else
              Begin
                blnMudarFoco := False;
                pSetFocus(edtQtdViagens);
              End;
            End;

          Finally
            Screen.Cursor := crDefault;
          End;

        End Else
        Begin
          pMensagemOk('Não há manifesto eletrônico com este número!' + #13 + 'Ainda não foi autorizado ou já está encerrado.');
          pSetFocus(edtNumMan);
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtCNPJ_CPF) Then
    Begin
      If Not ('_1_2_'.Contains(edtCNPJ_CPF.Text)) Then
        Result := False;
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
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.fValidaDadosPagamento: Boolean;
begin
  Result := False;
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
  Result := True;
end;

function TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.fValidaDataVencimentoParcela(strSeqMDFPRA: string): Boolean;
begin
  Result := False;
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
  Result := True;
end;

function TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.fValidaEstrangeiro: Boolean;
Var
  blnEstrangeiro : Boolean;
begin

  Result := True;

  blnEstrangeiro := Not fEmptyStr(edtIDEstrangeiro.Text);

  If (blnEstrangeiro) Then
  Begin

    If (Not fEmptyStr(fTiraCaracEspeciais(mskCNPJ_CPF.Text))) Then
    Begin
      pMensagemOk('Se ID Estrangeiro preenchido favor apagar o CNPJ/CPF!');
      pSetFocus(mskCNPJ_CPF);
      Exit(False);
    End;

    If (Length(edtIDEstrangeiro.Text) < 5) Then
    Begin
      fMensagem('ATENÇÃO', 'ID Estrangeiro deve conter 5 caracteres no mínimo!', ['&Ok']);
      pSetFocus(edtIDEstrangeiro);
      Exit(False);
    End;

  End Else
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskCNPJ_CPF.Text)) Then
    Begin
      pMensagemOk('Obrigatório preenchimento do CNPJ/CPF (quando não for estrangeiro)!');
      pSetFocus(mskCNPJ_CPF);
      Exit(False);
    End;

  End;

end;

function TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.fValidaInformacoesPagamento: Boolean;
begin

  Result := True;

  If cdsMDFPAG.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É obrigatório informar os dados da aba "Informações do Pagamento do Frete"!', ['&Ok']);
    pgcEventoPagamentoOperacaoTransporte.ActivePage := tbsInformacoesDoPagamentoDoFrete;
    Exit(False);
  End
  Else If Not fValidouInformacoesPagamentoFreteObrigatorias Then
  Begin
    pgcEventoPagamentoOperacaoTransporte.ActivePage := tbsInformacoesDoPagamentoDoFrete;
    Exit(False);
  End;

end;

function TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.fValidaObrigatoriedadeInformacoesBancarias: Boolean;
begin

  Result := True;

  If (rdgPIX.ItemIndex >= 0) and (Not fEmptyStr(fTiraCaracEspeciais(mskPIX.Text))) or (not fEmptyStr(edtPixEmail_Chave.Text)) Then
  Begin

    If Not fEmptyStr(edtNumeroBanco.Text) Or
       Not fEmptyStr(edtNumeroAgencia.Text) or
       not fEmptyStr(fTiraCaracEspeciais(mskCNPJInstituicaoPag.Text)) Then
    Begin
      pMensagemOk('Informe somente CNPJ da Instituição ou Banco/Agência ou PIX, nunca mais de uma opção!');
      Exit;
    End;

  End 
  Else If Not fEmptyStr(fTiraCaracEspeciais(mskCNPJInstituicaoPag.Text)) Then
  Begin

    If Not fEmptyStr(edtNumeroBanco.Text) Then
    Begin
      pMensagemOk('Informe somente CNPJ da Instituição ou Banco/Agência ou PIX, nunca mais de uma opção!');
      Exit(False);
    End;

    If Not fEmptyStr(edtNumeroAgencia.Text) Then
    Begin
      pMensagemOk('Informe somente CNPJ da Instituição ou Banco/Agência ou PIX, nunca mais de uma opção!');
      Exit(False);
    End;

  End Else
  begin

    If fEmptyStr(edtNumeroBanco.Text) Then
    Begin
      pMensagemOk('Obrigatório informar número do banco!');
      pSetFocus(edtNumeroBanco);
      Exit(False);
    End;

    If fEmptyStr(edtNumeroAgencia.Text) Then
    Begin
      pMensagemOk('Obrigatório informar número do agência!');
      pSetFocus(edtNumeroAgencia);
      Exit(False);
    End;

  End;

end;

function TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.fValidaParcela(strSeqMDFPRA: string): Boolean;
begin
  Result := False;
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
  Result := True;
end;

function TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.fValidouInformacoesPagamentoFreteObrigatorias: Boolean;
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

function TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.fCarregarManifesto(strNumMan : String) : Boolean;
Var
  qryMDFPAG,
  qryMDFCOM,
  qryMDFPRA,
  qryMDFEVE : TUniQuery;

Const
  strSQLMDFEVE = 'SELECT ' +
                 '  *    ' +
                 'FROM   ' +
                 '  MDFEVE ' +
                 'WHERE    ' +
                 '  MDF_NUMMAN = :NUMMAN AND ' +
                 '  MDF_EMPMAN = :EMPMAN     ';

  strSQLMDFPAG = 'SELECT ' +
                 '  *    ' +
                 'FROM   ' +
                 '  MDFPAG ' +
                 'WHERE    ' +
                 '  MDF_NUMMAN = :NUMMAN AND ' +
                 '  MDF_EMPMAN = :EMPMAN     ' +
                 'ORDER BY                   ' +
                 '  MDF_SEQPAG';

  strSQLMDFCOM = 'SELECT ' +
                 '  *    ' +
                 'FROM   ' +
                 '  MDFCOM ' +
                 'WHERE    ' +
                 '  MDF_NUMMAN = :NUMMAN AND ' +
                 '  MDF_EMPMAN = :EMPMAN AND ' +
                 '  MDF_SEQPAG = :SEQPAG     ' +
                 'ORDER BY                   ' +
                 '  MDF_SEQCOM';

  strSQLMDFPRA = 'SELECT ' +
                 '  *    ' +
                 'FROM   ' +
                 '  MDFPRA ' +
                 'WHERE    ' +
                 '  MDF_NUMMAN = :NUMMAN AND ' +
                 '  MDF_EMPMAN = :EMPMAN AND ' +
                 '  MDF_SEQPAG = :SEQPAG     ' +
                 'ORDER BY                   ' +
                 '  MDF_SEQPRA, MDF_NUMPAR';

begin

  Result := True;

  Try

    If Not fEmptyStr(strNumMan) then
    Begin

      {Aviso!}
      If Not fManifestoTAC_Agregado(strNumMan, VS_strCodEmp) Then
        fMensagem('ATENÇÃO', 'O evento será rejeitado!' + #13 + 'Caso o tipo de proprietário do MDF-e não seja "TAC Agregado".', ['&Ok']);

      cdsMDFPAG.EmptyDataSet;
      cdsMDFCOM.EmptyDataSet;
      cdsMDFPRA.EmptyDataSet;

      qryMDFPAG := fCriaQuery(Nil);
      qryMDFCOM := fCriaQuery(Nil);
      qryMDFPRA := fCriaQuery(Nil);
      qryMDFEVE := fCriaQuery(Nil);

      Try

        {Evento}
        qryMDFEVE.Close;
        qryMDFEVE.SQL.Clear;
        qryMDFEVE.SQL.Add(strSQLMDFEVE);
        qryMDFEVE.ParamByName('NUMMAN').AsString := strNumMan;
        qryMDFEVE.ParamByName('EMPMAN').AsString := VS_strCodEmp;
        qryMDFEVE.Open;

        If Not qryMDFEVE.IsEmpty Then
        Begin
          edtNumeroProtocolo.Text := IIF(Not qryMDFEVE.FieldByName('MDF_NUMPRO').IsNull, qryMDFEVE.FieldByName('MDF_NUMPRO').AsString, '');
          edtQtdViagens.Text      := fStrZero(qryMDFEVE.FieldByName('MDF_QTDVIA').AsString, 5);
          edtNumeroViagem.Text    := fStrZero(qryMDFEVE.FieldByName('MDF_NUMVIA').AsString, 5);
        End;

        {Informações do Pagamento do Frete}
        qryMDFPAG.Close;
        qryMDFPAG.SQL.Clear;
        qryMDFPAG.SQL.Add(strSQLMDFPAG);
        qryMDFPAG.ParamByName('NUMMAN').AsString := strNumMan;
        qryMDFPAG.ParamByName('EMPMAN').AsString := VS_strCodEmp;
        qryMDFPAG.Open;

        qryMDFPAG.First;
        While Not qryMDFPAG.Eof Do
        Begin

          cdsMDFPAG.Append;
          cdsMDFPAGMDF_SEQPAG.AsInteger   := qryMDFPAG.FieldByName('MDF_SEQPAG').AsInteger;
          cdsMDFPAGMDF_NOMRES.AsString    := qryMDFPAG.FieldByName('MDF_NOMRES').AsString;
          cdsMDFPAGTIPO_CNPJ_CPF.AsString := IIF(Length(qryMDFPAG.FieldByName('MDF_CPFCNP').AsString) > 11, '1', '2');
          cdsMDFPAGMDF_CPFCNP.AsString    := qryMDFPAG.FieldByName('MDF_CPFCNP').AsString;
          cdsMDFPAGMDF_ESTRAN.AsString    := qryMDFPAG.FieldByName('MDF_ESTRAN').AsString;
          cdsMDFPAGMDF_VALTOT.AsFloat     := qryMDFPAG.FieldByName('MDF_VALTOT').AsFloat;
          cdsMDFPAGMDF_FORPAG.AsInteger   := qryMDFPAG.FieldByName('MDF_FORPAG').AsInteger;
          cdsMDFPAGMDF_NUMBAN.AsString    := qryMDFPAG.FieldByName('MDF_NUMBAN').AsString;
          cdsMDFPAGMDF_NUMAGE.AsString    := qryMDFPAG.FieldByName('MDF_NUMAGE').AsString;
          cdsMDFPAGMDF_CNPJPG.AsString    := qryMDFPAG.FieldByName('MDF_CNPJPG').AsString;
          cdsMDFPAGMDF_TIPPIX.AsInteger   := qryMDFPAG.FieldByName('MDF_TIPPIX').AsInteger;
          cdsMDFPAGMDF_CHAPIX.AsString    := qryMDFPAG.FieldByName('MDF_CHAPIX').AsString;
          cdsMDFPAGMDF_VALADI.AsFloat     := qryMDFPAG.FieldByName('MDF_VALADI').AsFloat;
          cdsMDFPAG.Post;

          {Componentes}
          qryMDFCOM.Close;
          qryMDFCOM.SQL.Clear;
          qryMDFCOM.SQL.Add(strSQLMDFCOM);
          qryMDFCOM.ParamByName('NUMMAN').AsString := strNumMan;
          qryMDFCOM.ParamByName('EMPMAN').AsString := VS_strCodEmp;
          qryMDFCOM.ParamByName('SEQPAG').AsString := qryMDFPAG.FieldByName('MDF_SEQPAG').AsString;
          qryMDFCOM.Open;

          qryMDFCOM.First;
          While Not qryMDFCOM.Eof Do
          Begin
            cdsMDFCOM.Append;
            cdsMDFCOMMDF_SEQPAG.AsInteger  := qryMDFCOM.FieldByName('MDF_SEQPAG').AsInteger;
            cdsMDFCOMMDF_SEQCOM.AsInteger  := qryMDFCOM.FieldByName('MDF_SEQCOM').AsInteger;
            cdsMDFCOMMDF_TIPCOM.AsString   := qryMDFCOM.FieldByName('MDF_TIPCOM').AsString;
            cdsMDFCOMMDF_VALCOM.AsCurrency := qryMDFCOM.FieldByName('MDF_VALCOM').AsFloat;
            cdsMDFCOMMDF_DESCOM.AsString   := qryMDFCOM.FieldByName('MDF_DESCOM').AsString;
            cdsMDFCOM.Post;
            qryMDFCOM.Next;
          End;

          {Prazos}
          qryMDFPRA.Close;
          qryMDFPRA.SQL.Clear;
          qryMDFPRA.SQL.Add(strSQLMDFPRA);
          qryMDFPRA.ParamByName('NUMMAN').AsString := strNumMan;
          qryMDFPRA.ParamByName('EMPMAN').AsString := VS_strCodEmp;
          qryMDFPRA.ParamByName('SEQPAG').AsString := qryMDFPAG.FieldByName('MDF_SEQPAG').AsString;
          qryMDFPRA.Open;

          qryMDFPRA.First;
          While Not qryMDFPRA.Eof Do
          Begin
            cdsMDFPRA.Append;
            cdsMDFPRAMDF_SEQPAG.AsInteger  := qryMDFPRA.FieldByName('MDF_SEQPAG').AsInteger;
            cdsMDFPRAMDF_SEQPRA.AsInteger  := qryMDFPRA.FieldByName('MDF_SEQPRA').AsInteger;
            cdsMDFPRAMDF_NUMPAR.AsInteger  := qryMDFPRA.FieldByName('MDF_NUMPAR').AsInteger;

            {DDMMAAAA}
            cdsMDFPRAMDF_DTAVEN.AsString   := qryMDFPRA.FieldByName('MDF_DTAVEN').AsString;

            {DD/MM/AAAA}
            cdsMDFPRAccVENCIMENTO.AsString := fDDMMAAAA_To_DDMMAAAA(qryMDFPRA.FieldByName('MDF_DTAVEN').AsString);

            cdsMDFPRAMDF_VALPAR.AsCurrency := qryMDFPRA.FieldByName('MDF_VALPAR').AsFloat;
            cdsMDFPRA.Post;
            qryMDFPRA.Next;
          End;

          {Próximo}
          qryMDFPAG.Next;

        End;

      Finally
        FreeAndNil(qryMDFPAG);
        FreeAndNil(qryMDFCOM);
        FreeAndNil(qryMDFPRA);
        FreeAndNil(qryMDFEVE);
      End;

    End;

  Except
    Result := False;
  End;

end;

function TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.fDataVencimentoParcelaJaExiste(strSeqMDFPRA: string): Boolean;
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

function TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.fDDMMAAAA_To_DDMMAAAA(strData: String): String;
Var
  strDia, strMes, strAno : String;
begin

  strDia := '';
  strMes := '';
  strAno := '';

  {DDMMAAAA}
  If Not fEmptyStr(strData) Then
  Begin
    strDia := Copy(strData, 0, 2);
    strMes := Copy(strData, 3, 2);
    strAno := Copy(strData, 5, 4);
  End;

  Result := strDia + '/' + strMes + '/' + strAno;

end;

function TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.fDeletarInformacoesPagamentoFrete(strNumMan: String): Boolean;
Var
  qryMdfPAG : TUniQuery;
  qryMdfCOM : TUniQuery;
  qryMdfPRA : TUniQuery;
begin

  If fEmptyStr(strNumMan) Then
    Exit(False);

  qryMdfPAG := fCriaQuery(Self);
  qryMdfCOM := fCriaQuery(Self);
  qryMdfPRA := fCriaQuery(Self);

  Try

    qryMdfPAG.Close;
    qryMdfPAG.SQL.Clear;
    qryMdfPAG.SQL.Text := 'DELETE FROM MDFPAG WHERE MDF_NUMMAN = :NUMMAN AND MDF_EMPMAN = :EMPMAN';
    qryMdfPAG.ParamByName('NUMMAN').AsString := strNumMan;
    qryMdfPAG.ParamByName('EMPMAN').AsString := VS_strCodEmp;
    qryMdfPAG.ExecSQL;

    qryMdfCOM.Close;
    qryMdfCOM.SQL.Clear;
    qryMdfCOM.SQL.Text := 'DELETE FROM MDFCOM WHERE MDF_NUMMAN = :NUMMAN AND MDF_EMPMAN = :EMPMAN';
    qryMdfCOM.ParamByName('NUMMAN').AsString := strNumMan;
    qryMdfCOM.ParamByName('EMPMAN').AsString := VS_strCodEmp;
    qryMdfCOM.ExecSQL;

    qryMdfPRA.Close;
    qryMdfPRA.SQL.Clear;
    qryMdfPRA.SQL.Text := 'DELETE FROM MDFPRA WHERE MDF_NUMMAN = :NUMMAN AND MDF_EMPMAN = :EMPMAN';
    qryMdfPRA.ParamByName('NUMMAN').AsString := strNumMan;
    qryMdfPRA.ParamByName('EMPMAN').AsString := VS_strCodEmp;
    qryMdfPRA.ExecSQL;

    Result := True;

  Finally
    qryMdfPAG.Free;
    qryMdfCOM.Free;
    qryMdfPRA.Free;
  End;

end;

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.pGrava_Envia;
begin

  Try

    If fGravarEventoPagamentoOperacaoTransporte(edtNumMan.Text) Then
    Begin

      If fDeletarInformacoesPagamentoFrete(edtNumMan.Text) Then
        If fGravarInformacoesPagamentoFrete(edtNumMan.Text) Then
          fCommit;

      {Enviar}
      If fEnviarManifestoEventoPagamento(edtNumMan.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Evento enviado com sucesso!', ['&Ok']);
        pLimparTela;
      End;

    End;

  Except
    On E: Exception Do
      Raise;
  End;

end;

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.pLimparComponentes;
begin

  edtSeqMDFCOM.Clear;
  cbbTipoComponente.ItemIndex := -1;
  edtValorComponente.Clear;
  edtDescricaoComponente.Clear;

  pSetFocus(cbbTipoComponente);

end;

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.pLimparInformacoesPagamentoFrete;
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

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.pLimparPagamentoOperacaoTransporte;
begin
  edtNumeroProtocolo.Clear;
  edtQtdViagens.Clear;
  edtNumeroViagem.Clear;
end;

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.pLimparPrazos;
begin

  edtSeqMDFPRA.Clear;
  edtNumeroParcelas.Clear;
  mskDataVencimento.Clear;
  edtValorParcela.Clear;

  pSetFocus(edtNumeroParcelas);

end;

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.pLimparTela;
begin

  {Limpa clients}
  cdsMDFPAG.EmptyDataSet;
  cdsMDFCOM.EmptyDataSet;
  cdsMDFPRA.EmptyDataSet;

  {Limpa campos em tela}
  pLimparPagamentoOperacaoTransporte;
  pLimparInformacoesPagamentoFrete;
  pLimparComponentes;
  pLimparPrazos;

  {Posiciona TAB e foco}
  pgcEventoPagamentoOperacaoTransporte.Enabled  := False;
  pgcEventoPagamentoOperacaoTransporte.TabIndex := 0;

  pnlCabecalho.Enabled := True;

  edtNumMan.Clear;
  pSetFocus(edtNumMan);

end;

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.pReindexarComponentes;
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

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.pReindexarInfPagFre;
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

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.pReindexarPrazos;
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

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.rdgFormaPagamentoClick(
  Sender: TObject);
begin
  inherited;
  edtValorAdiantamento.Enabled := (rdgFormaPagamento.ItemIndex = 1);
end;

procedure TfrmFatManifestoEletronicoEventoPagamentoOperacaoTransporte.rdgPIXClick(
  Sender: TObject);
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
