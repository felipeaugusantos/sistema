{***************************}
{* qryConPor -> CADPOR     *}
{* qryConCta -> CADCTA     *}
{************************JB*}
unit untBaixaCtrAnalitica;

interface

uses
  Classes, Controls, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  Mask, MaskEditFocus, EditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, untFramePlanoDeContasMaskEdit, Vcl.Forms,
  SysUtils,untTValidaCorrespondenteContabil;

type
  TfrmBaixaCtrAnalitica = class(TfrmPaiSimples)
    edtPorBai: TEditFocus;
    pnlConfirma: TPanel;
    edtCodPorBai: TEditFocus;
    pnlFundo: TPanel;
    lblPorBa1: TLabel;
    Label2: TLabel;
    edtHisBai: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    lblHist2: TLabel;
    edtHist02: TEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    procedure FormCreate(Sender: TObject);
    procedure edtPorBaiKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    qryConPor: TUniQuery;
    qryConCta: TUniQuery;
    FValidaCorrespondenteContabil: TValidaCorrespondenteContabil;

    procedure pCarregaPortador;
    procedure pCarregaCentroCusto;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strPorBai: String;
    strHisBai: String;
    strHist02: String;
    strCtaBai: String;

    intDCrRecPor1: Integer;

    blnBaiUtl  : Boolean;
    blnConfirma: Boolean;
    blnVemCtr: Boolean;
    FTotRecZero: Boolean;
    FBaixaTotal: Boolean;
  end;


implementation

uses untFuncoesSimples, untPesqAux, untCadCta, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmBaixaCtrAnalitica }

procedure TfrmBaixaCtrAnalitica.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto, True, False, '', False, False, blnVemCtr) Then
  Begin
    If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
    pCarregaCentroCusto;
  End;

end;

function TfrmBaixaCtrAnalitica.fValidaCampos(Sender: TWinControl;
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
          fMensagem('ATENÇÃO!', 'O Portador da Baixa deve ser preenchido!', ['&O k']);
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

          Else If (Not fPortadorPermiteBaixa(edtPorBai.Text)) Then
          Begin
            fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
            Result := False;
          End

          Else If Not FValidaCorrespondenteContabil.PortadorPossuiCorrespondenteContabil(edtPorBai.Text,VS_strCodEmp) Then
          Begin
            Result := False;
          End

          Else If Not fEmpresaTemAcessoPortador(edtPorBai.Text, VS_strCodEmp) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End

          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(qryConPor.FieldByName('POR_CODPOR').AsString, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos para este portador!', ['&O k']);
              Result := False;
            End
          End;

          If (FTotRecZero) And (Not fPermiteCreditoDebitoPortador(edtPorBai.Text)) And (FBaixaTotal) Then
          Begin
            fMensagem('ATENÇÃO!', 'Não é permitido utilizar o portador para baixa com utilização de credito zerada', ['&Ok']);
            Result := False;
          End;
        End;

      End;

      If Not Result Then
        pSetFocus(Sender);

    End;

    {*****************************************}
    {* VALIDA O CENTRO DE CUSTO              *}
    {**************************************MV*}
    If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas da Baixa deve ser preenchida!', ['&O k']);
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
        else if (blnVemCtr) and (qryConCta.FieldByName('CTA_PERREC').AsString <> 'S') then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não é permitido na baixa contas a receber!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.MskCodCta.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Plano de Contas não permitido!', ['&O k']);
          Result := False;
        End
        Else If Not FValidaCorrespondenteContabil.PlanoDeContasPossuiCorrespondenteContabil(fraPlanoDeContas.MskCodCta.Text,VS_strCodEmp) Then
        Begin
          Result := False;
        End
        Else If Not PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text) Then
          Result := False;
{        Else
        Begin
          blnConfirma := True;
          strPorBai   := edtPorBai.Text;
          strCtaBai   := mskCtaBai.Text;
          Close;
        End;}
      End;


    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
    
end;

procedure TfrmBaixaCtrAnalitica.pCarregaCentroCusto;
begin
  pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text);
  With qryConCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmBaixaCtrAnalitica.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, edtPorBai.Text);
  With qryConPor Do
  Begin
    edtCodPorBai.Text := FieldByName('POR_NOMPOR').AsString;
    intDCrRecPor1 := FieldByName('POR_DCRREC').AsInteger;
    blnBaiUtl     := FieldByName('POR_BAIUTL').AsString = 'S';
  End;
end;

procedure TfrmBaixaCtrAnalitica.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(FValidaCorrespondenteContabil);
end;

procedure TfrmBaixaCtrAnalitica.FormCreate(Sender: TObject);
begin
  inherited;
  qryConPor := fCriaQuery(Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  blnConfirma := False;
  FValidaCorrespondenteContabil :=  TValidaCorrespondenteContabil.Create;
  FTotRecZero := False;
  FBaixaTotal := False;
end;

{******************************************************************}
{* PROCEDURE ALTERADO PARA CHAMADA DA NOVA CONSULTA DE PORTADORES *}
{***************************************************************JU*}
procedure TfrmBaixaCtrAnalitica.edtPorBaiKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  if fPesqPortador(conSimples,
                   Self,
                   edtPorBai,
                   edtCodPorBai,
                   nil,
                   Key,
                   arrSel)  then
  Begin
    If (fValidaCampos(edtPorBai)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

  pCarregaPortador;
end;

procedure TfrmBaixaCtrAnalitica.FormShow(Sender: TObject);
begin
  inherited;
  SelectFirst;
end;

{******************************************************************}
{* PROCEDURE ALTERADO PARA CHAMADA DA NOVA CONSULTA DE PORTADORES *}
{***************************************************************JU*}
procedure TfrmBaixaCtrAnalitica.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmBaixaCtrAnalitica.btnConfirmaDadosClick(Sender: TObject);
  Var
    strCfg_PORPGR: String;
    strCfg_CTAGCP: String;
begin
  inherited;
  strCfg_PORPGR := fCfgSis('PORPGR');
  strCfg_CTAGCP := fCfgSis('CTAGCP');

  If (Not fEmptyStr(strCfg_PORPGR)) Or (Not fEmptyStr(strCfg_CTAGCP)) Then
  Begin

    If (Not fEmptyStr(strCfg_PORPGR)) Then
    Begin

      If ((Not fEmptyStr(edtPorBai.Text)) And (edtPorBai.Text = strCfg_PORPGR)) Then
      Begin
        pMensagemOk('Portador ' + strCfg_PORPGR + ' não permitido, pois está configurado para baixa de Contas a Pagar no resumo de caixa.');

        If ((Not fEmptyStr(edtPorBai.Text)) And (edtPorBai.Text = strCfg_PORPGR)) Then
          pSetFocus(edtPorBai);

        Exit;
      End;

    End;

    If (Not fEmptyStr(strCfg_CTAGCP)) Then
    Begin

      If (Not fEmptyStr(fraPlanoDeContas.MskCodCta.Text)) And (fraPlanoDeContas.MskCodCta.Text = strCfg_CTAGCP) Then
      Begin
        pMensagemOk('Plano de Contas ' + strCfg_CTAGCP + ' não permitido, pois está configurado para baixa de Contas a Pagar no resumo de caixa.');
        pSetFocus(fraPlanoDeContas.MskCodCta);
        Exit;
      End;

    End;
  End;

  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    strPorBai   := edtPorBai.Text;
    strHisBai   := edtHisBai.Text;
    strHist02   := edtHist02.Text;
    strCtaBai   := fraPlanoDeContas.MskCodCta.Text;
    Close;
  End;
end;

end.


