{***************************}
{* qryConPor -> CADPOR     *}
{* qryConCta -> CADCTA     *}
{************************JB*}
unit untPorCredMovBan;

interface

uses
  Controls, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni, Mask,
  MaskEditFocus, EditFocus, Menus, AppEvnts, BitBtnLockedIncrem, Classes,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxGroupBox, cxRadioGroup,
  untFramePlanoDeContasMaskEdit, Vcl.Forms;

type
  TfrmPorCredMovBan = class(TfrmPaiSimples)
    edtPorBai: TEditFocus;
    pnlConfirma: TPanel;
    edtCodPorBai: TEditFocus;
    pnlFundo: TPanel;
    lblPorBa1: TLabel;
    Label5: TLabel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    rdgTipocheque: TRadioGroup;
    Panel1: TPanel;
    Panel2: TPanel;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    procedure FormCreate(Sender: TObject);
    procedure edtPorBaiKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtPorBaiChange(Sender: TObject);
    procedure rdgTipoChequeClick(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasMskCodCtaExit(Sender: TObject);
  private
    { Private declarations }
    strCfg_PORPGR: String;
    strCfg_CTAGCP: String;
    qryConCta: TUniQuery;
    qryConPor: TUniQuery;

    FTipoLancamento: String;

    procedure pCarregaPortador;
    procedure pCarregaCentroCusto;
    procedure pPreparaForm;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strPorBai, strPorDeb, strCtaBai, strCtaDeb, strNomPorBai: String;
    blnConfirma: Boolean;
    blnRepase  : Boolean;
    blnChecaPortador: Boolean;
    blnTransferencia: Boolean;
    dtaDtValPor : TDate;
    blnVeioManutencaoReceber : Boolean;

    property TipoLancamento: String read FTipoLancamento write FTipoLancamento;
  end;

implementation

uses SysUtils, untfuncoesSimples, untPesqAux, untCadCta, untConsultas,
  untTypesSistema;

{$R *.dfm}

{ TfrmBaixaAnalitica }

procedure TfrmPorCredMovBan.fraPlanoDeContasMskCodCtaExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtPorBai.Text)) Then
  Begin
    fraPlanoDeContas.MskCodCta.Clear;
    fraPlanoDeContas.edtDesCta.Clear;
  End;
  fraPlanoDeContas.MskCodCtaExit(Sender);
end;

procedure TfrmPorCredMovBan.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
  Begin
    If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
    pCarregaCentroCusto;
  End;

end;

function TfrmPorCredMovBan.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O PORTADOR                     *}
    {**************************************MV*}
    If (Sender = edtPorBai) Then
    Begin
      If (edtPorBai.Visible) And (edtPorBai.Enabled) Then
      Begin
        If fEmptyStr(edtPorBai.Text) Then
        Begin

          If Not blnRepase Then
          Begin
            fMensagem('ATENÇÃO!', 'O Portador para ' + FTipoLancamento + ' do movimento bancário deve ser preenchido!', ['&O k']);
            Result := False;
          End;

          edtCodPorBai.Clear;
          fraPlanoDeContas.MskCodCta.Enabled := False;
        End
        Else
        If (Not fEmptyStr(strCfg_PORPGR)) And (edtPorBai.Text = strCfg_PORPGR) Then
        Begin
          pMensagemOk('Portador ' + strCfg_PORPGR + ' não permitido, pois está configurado para baixa de Contas a Pagar no resumo de caixa.');
          Result := False;
        End
        Else
        Begin
          pCarregaPortador;
          If qryConPor.FieldByName('POR_CODPOR').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
            Result := False;
          End

          Else If Not fEmpresaTemAcessoPortador(edtPorBai.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End

          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtPorBai.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos para este portador!', ['&Ok']);
              Result := False;
            End;
          End;

        End;

      End;

      If Not Result Then
        pSetFocus(Sender);

    End;

    {*****************************************}
    {* VALIDA O CENTRO DE CUSTO              *}
    {**************************************MV*}
    If (Sender = fraPlanoDeContas.MskCodCta) And (fraPlanoDeContas.MskCodCta.Visible) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text)) Then
      Begin

        If (Not fEmptyStr(edtPorBai.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Plano de Contas para ' + FTipoLancamento + ' do movimento bancário deve ser preenchido!', ['&O k']);
          Result := False;
        End;

      End
      Else
      If (Not fEmptyStr(strCfg_CTAGCP)) And (fraPlanoDeContas.MskCodCta.Text = strCfg_CTAGCP) Then
      Begin
        pMensagemOk('Plano de Contas ' + strCfg_CTAGCP + ' não permitido, pois está configurado para baixa de Contas a Pagar no resumo de caixa.');
        Result := False;
      End
      Else
      Begin
        pCarregaCentroCusto;
        If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.MskCodCta.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Linha / Grupo não permitido!', ['&O k']);
          Result := False;
        End
        Else If Not PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text) Then
          Result := False
      End;


    End

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmPorCredMovBan.pCarregaCentroCusto;
begin
  pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text);
  With qryConCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmPorCredMovBan.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, edtPorBai.Text);
  With qryConPor Do
  Begin
    edtCodPorBai.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;


procedure TfrmPorCredMovBan.pPreparaForm;
begin
  Panel1.Visible := False;
  Self.Height := 185;
end;

procedure TfrmPorCredMovBan.rdgTipoChequeClick(Sender: TObject);
begin
  case rdgTipoCheque.ItemIndex of
    0: begin
         edtPorBai.Text := fCfgSis('PORCHV');
         fraPlanoDeContas.MskCodCta.Text := fCfgSis('CTTRCV');
       end;
    1: begin
         edtPorBai.Text := fCfgSis('PORCHP');
         fraPlanoDeContas.MskCodCta.Text := fCfgSis('CTTRCP');
       end;
  end;

  pCarregaPortador;
  pCarregaCentroCusto;

end;

procedure TfrmPorCredMovBan.FormCreate(Sender: TObject);
begin
  inherited;
  dtaDtValPor := 0;
  blnChecaPortador := False;
  blnTransferencia := False;

  qryConPor := fCriaQuery(Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  blnRepase   := False;

  FTipoLancamento := 'crédito';
end;

procedure TfrmPorCredMovBan.edtPorBaiKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqPortador(conSimples, Self, edtPorBai, edtCodPorBai, nil, Key, arrSel) Then
  Begin
    If (fValidaCampos(edtporBai)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
  pCarregaPortador;

end;

procedure TfrmPorCredMovBan.FormShow(Sender: TObject);
begin
  inherited;
  SelectFirst;
  edtPorBai.Enabled := true;
  fraPlanoDeContas.MskCodCta.Enabled := true;
  if not fEmptyStr(edtPorBai.Text) then
    pCarregaPortador;
  if not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) then
    pCarregaCentroCusto;
  pSetFocus(edtPorBai);

  strCfg_PORPGR := fCfgSis('PORPGR');
  strCfg_CTAGCP := fCfgSis('CTAGCP');

  Label5.Caption := FTipoLancamento.ToUpper;
  If blnVeioManutencaoReceber Then
    pPreparaForm;
end;

procedure TfrmPorCredMovBan.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmPorCredMovBan.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    Close;
  End;

end;

procedure TfrmPorCredMovBan.edtPorBaiChange(Sender: TObject);
begin
  inherited;
  fraPlanoDeContas.MskCodCta.Enabled := True;
end;

end.

