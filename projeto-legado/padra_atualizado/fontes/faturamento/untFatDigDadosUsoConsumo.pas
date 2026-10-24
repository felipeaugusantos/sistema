unit untFatDigDadosUsoConsumo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Mask, MaskEditFocus, Uni, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, untFramePlanoDeContasMaskEdit, untTValidaCorrespondenteContabil;

type
  TfrmFatDigDadosUsoConsumo = class(TfrmPai)
    pnlGeral: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    pnlForncedor: TPanel;
    Label1: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    pnlEvento: TPanel;
    lblEvento: TLabel;
    edtCodEve: TEditFocus;
    edtDesEve: TEditFocus;
    Panel1: TPanel;
    Label2: TLabel;
    edtHistor: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryConCta: TUniQuery;
    FValidaCorrespondenteContabil: TValidaCorrespondenteContabil;
    procedure pCarregaCentroCusto;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }

  end;

var
  frmFatDigDadosUsoConsumo: TfrmFatDigDadosUsoConsumo;

implementation

uses untFuncoesSimples, untPesqAux, untConsultas, untTypesSistema,
  untConstantes;

{$R *.dfm}

procedure TfrmFatDigDadosUsoConsumo.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    ModalResult := mrOk;
  End;
end;

procedure TfrmFatDigDadosUsoConsumo.edtCodEveKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEvento: TConsultasArray;
begin
  inherited;
  if fPesqEventos(Self, edtCodEve, edtDesEve, nil, Key, arrEvento) then
  begin
    if fValidaCampos(edtCodEve, True) then
      SelectNext(ActiveControl, True, True);
  end;

end;

procedure TfrmFatDigDadosUsoConsumo.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
Begin
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fEntraCons(Key) Then
  Begin
    If fPesqFornecedor(conForCompleta, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
    Begin
      If fValidaCampos(edtCodFor, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmFatDigDadosUsoConsumo.FormCreate(Sender: TObject);
begin
  inherited;
  qryConCta := fCriaQuery(Self);
  
  edtCodFor.Text := fCadEmp('FORFIL');
  edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);

  edtHistor.Text := CNS_MSG_USOCONSUMO;

  If Not fCfgSis('USACTF', varBoolean) Then
  Begin
    fraPlanoDeContas.MskCodCta.Text := fCfgSis('PCCPUC', varString);
    fraPlanoDeContas.edtDesCta.Text := fRetNomeConta(fraPlanoDeContas.mskCodCta.Text);
  End;

  FValidaCorrespondenteContabil:= TValidaCorrespondenteContabil.Create;
end;

procedure TfrmFatDigDadosUsoConsumo.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FValidaCorrespondenteContabil);
end;

procedure TfrmFatDigDadosUsoConsumo.FormShow(Sender: TObject);
begin
  inherited;
  pnlEvento.Visible := fCfgSis('EVUSCS', varBoolean);
  pSetFocus(fraPlanoDeContas.MskCodCta);
end;

procedure TfrmFatDigDadosUsoConsumo.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrCentroCusto : TConsultasArray;
begin
  inherited;
  If Not fCfgSis('USACTF', varBoolean) Then
  Begin
    If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, qryConCta, Key, arrCentroCusto) Then
    Begin
      fraPlanoDeContas.MskCodCta.Text := qryConCta.FieldByName('CTA_CODCTA').AsString;
      If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End
  Else
  Begin
    If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, qryConCta, Key, arrCentroCusto, True, True, edtCodFor.Text) Then
    Begin
      fraPlanoDeContas.MskCodCta.Text := qryConCta.FieldByName('CTA_CODCTA').AsString;
      If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;

end;

function TfrmFatDigDadosUsoConsumo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtCodFor) Then
  Begin
    If fEmptyStr(edtCodFor.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário informar o fornecedor!', ['&O k']);
      Result := False;
    End
    Else
    Begin
      edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);
      If fEmptyStr(edtNomFor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Este fornecedor não está cadastrado!', ['&O k']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = fraPlanoDeContas.MskCodCta) Then
  Begin

    If Not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
    Begin
      pCarregaCentroCusto;
      If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
      Begin
        If Not fCfgSis('USACTF', varBoolean) Then
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k'])
        Else
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&O k']);

        Result := False;
      End
      Else If Not PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text) Then
        Result := False
      Else If Not FValidaCorrespondenteContabil.PlanoDeContasPossuiCorrespondenteContabil(fraPlanoDeContas.MskCodCta.Text, VS_strCodEmp) Then
        Result := False;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser preenchido!', ['&O k']);
      Result := False;
    End;

  End

  Else If (Sender = edtCodEve) and (pnlEvento.Visible) Then
  Begin
    If Not fEmptyStr(edtCodEve.Text) Then
    Begin
      edtDesEve.Text := fRetNomEvento(edtCodEve.Text);
      If fEmptyStr(edtDesEve.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Evento não está cadastrado!', ['&O k']);
        Result := False;
      End;
    End
    Else
    If fCfgSis('CTPOBE', varBoolean) Then
    Begin
      fMensagem('ATENÇÃO!', 'O evento deve ser preenchido!', ['&O k']);
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatDigDadosUsoConsumo.pCarregaCentroCusto;
begin
  If Not fCfgSis('USACTF', varBoolean) Then
    pPesquisaCadCta(Nil, qryConCta, fraPlanoDeContas.MskCodCta.Text)
  Else
    pPesquisaCadCta(Nil, qryConCta, fraPlanoDeContas.MskCodCta.Text, True, edtCodFor.Text);
    
  With qryConCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

end.
