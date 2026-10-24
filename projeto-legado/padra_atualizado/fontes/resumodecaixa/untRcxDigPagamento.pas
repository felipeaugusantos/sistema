{***************************}
{* qryConCta -> CADCTA     *}
{* qryConFor -> CADFOR     *}
{************************JB*}
unit untRcxDigPagamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, Mask,
  MaskEditFocus, EditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, untFrameCentroCustoEditFocus,
  untFramePlanoDeContasMaskEdit;

type
  TfrmRcxDigPagamento = class(TfrmPaiSimples)
    pnlDados: TPanel;
    Label1: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    btnConfirma: TBitBtnLocked;
    fraCentroCusto: TfraCentroCustoEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    lblMotivo: TLabel;
    edtJustificativa: TEditFocus;
    procedure btnSairClick(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    qryConCta: TUniQuery;
    qryConFor: TUniQuery;

    FValidaDespesasEventos: Boolean;

    procedure pCarregaCentroCusto;
    procedure pCarregaEventos;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    blnResCx   : Boolean;
    procedure pCarregaFornecedor;

    property blnValidaDespesasEventos: Boolean read FValidaDespesasEventos write FValidaDespesasEventos;
  end;


implementation

uses untfuncoesSimples, untPesqAux, untPai, untCadCta, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmRcxDigPagamento.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRcxDigPagamento.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRcxDigPagamento.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, edtCodFor.Text);
  With qryConFor Do
  Begin
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
  End;
end;

procedure TfrmRcxDigPagamento.FormActivate(Sender: TObject);
begin
  inherited;
  If edtCodFor.CanFocus Then
    pSetFocus(edtCodFor)
  Else
    pSetFocus(fraPlanoDeContas.MskCodCta);
end;

procedure TfrmRcxDigPagamento.FormCreate(Sender: TObject);
begin
  inherited;
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);

  blnConfirma := False;
  FValidaDespesasEventos:= False;

  edtCodFor.Text := fCfgSis('FORPGR');
  pCarregaFornecedor;

end;

procedure TfrmRcxDigPagamento.FormShow(Sender: TObject);
begin
  inherited;
  height := 157;

  If blnResCx And (fCfgSis('JUSPGT') = 'S') Then
  Begin
     height := 187;
  End;
end;

procedure TfrmRcxDigPagamento.pCarregaCentroCusto;
begin
  If Not fCfgSis('USACTF', varBoolean) Then
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text)
  Else
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text, True, edtCodFor.Text);
    
  With qryConCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmRcxDigPagamento.pCarregaEventos;
begin
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmRcxDigPagamento.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If Not fCfgSis('USACTF', varBoolean) Then
  Begin
    If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
    Begin
      If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
        Self.SelectNext(ActiveControl, True, True);
      pCarregaCentroCusto;
    End;
  End
  Else
  Begin
    If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto, True, True, edtCodFor.Text) Then
    Begin
      If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
        Self.SelectNext(ActiveControl, True, True);
      pCarregaCentroCusto;
    End;
  End;

end;

function TfrmRcxDigPagamento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = fraPlanoDeContas.MskCodCta) Then
  Begin

    If (fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text))) Then
    Begin
      fMensagem('', 'O plano de contas deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.MskCodCta.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Linha / Grupo não é permitido!', ['&O k']);
      Result := False;
    End
    Else
    Begin
      pCarregaCentroCusto;
      If (qryConCta.FieldByName('CTA_CODCTA').IsNull) Then
      Begin
        If Not fCfgSis('USACTF', varBoolean) Then
          fMensagem('', 'Esse plano de contas não está cadastrado!', ['&Ok'])
        Else
          fMensagem('', 'Esse plano de contas não está cadastrado ou não está vinculado ao fornecedor!', ['&Ok']);

        Result := False;
      End
      Else If Not PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text) Then
        Result := False;
    End;

  End

  Else If (Sender = edtCodFor) Then
  Begin

    If (fEmptyStr(edtCodFor.Text)) Then
    Begin
      fMensagem('', 'O fornecedor deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pCarregaFornecedor;
      If (qryConFor.FieldByName('FOR_CODFOR').IsNull) Then
      Begin
        fMensagem('', 'Esse fornecedor não está cadastrado!', ['&Ok']);
        Result := False;
      End
      Else If qryConFor.FieldByName('FOR_STATUS').AsString <> 'A' Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse fornecedor está inativo!', ['&O k']);
        Result := False;
      End;
    End;

  End
  Else If (Sender = fraCentroCusto.edtCodEve) Then
  Begin

    If (fEmptyStr(fraCentroCusto.edtCodEve.Text)) Then
    Begin
      If (fCfgSis('CTPOBE', varBoolean)) Or (FValidaDespesasEventos) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Centro de Custos deve ser preenchido!', ['&O k']);
        Result := False;
      End;
      fraCentroCusto.edtDesEve.Clear;
    End
    Else
    Begin
      pCarregaEventos;
      If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
      Begin
        fMensagem('', 'Esse Centro de Custos não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtJustificativa) Then
  Begin

    If blnResCx And (fCfgSis('JUSPGT') = 'S') Then
    Begin

       If (fEmptyStr(edtJustificativa.Text)) Then
       Begin
          fMensagem('ATENÇÃO!', 'A justificativa deve ser preenchida!', ['&O k']);
          Result := False;
          pSetFocus(edtJustificativa);
       End;

    End;

  End;

end;

procedure TfrmRcxDigPagamento.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

end.

