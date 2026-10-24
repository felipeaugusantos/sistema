unit untDigMotivoReprovacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Uni, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmDigMotivoReprovacao = class(TfrmPai)
    pnlGeral: TPanel;
    lblMotivo: TLabel;
    edtCodMre: TEditFocus;
    edtDesMre: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    pnlDigitador: TPanel;
    lblDigita: TLabel;
    edtSenDig: TEditFocus;
    edtNomDig: TEditFocus;
    edtRepPor: TEditFocus;
    lblRepPor: TLabel;
    procedure edtCodMreKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    qryConOpe: TUniQuery;
    procedure pCarregaDigitador;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnFluPro: Boolean;
    strCodOpe,
    strSenDig: String;
  end;

implementation

uses untFuncoesSimples, untFuncIns, untFuncIns2, untPesqAux, untConsultas,
  untTypesSistema;

{$R *.dfm}

procedure TfrmDigMotivoReprovacao.edtCodMreKeyPress(Sender: TObject; var Key: Char);
  Var
    arrMotivo: TConsultasArray;
begin
  inherited;
  If fPesqMotReprovacao(Self, edtCodMre, edtDesMre, Nil, Key, arrMotivo) Then
  Begin
    If fValidaCampos(edtCodMre, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigMotivoReprovacao.FormActivate(Sender: TObject);
begin
  inherited;

  if (pnlDigitador.Visible) then
    pSetFocus(edtSenDig)
  else
    pSetFocus(edtCodMre);
end;

procedure TfrmDigMotivoReprovacao.FormCreate(Sender: TObject);
begin
  inherited;
  blnFluPro := False;
  strCodOpe := '';
  strSenDig := '';

  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
end;

procedure TfrmDigMotivoReprovacao.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryConOpe);
end;

procedure TfrmDigMotivoReprovacao.FormShow(Sender: TObject);
begin
  inherited;

  if (not blnFluPro) or (not fCfgSis('USADIG', varBoolean)) then
  begin
    Self.Height := Self.Height - pnlDigitador.Height;
    pnlDigitador.Visible := False;
  end;
end;

function TfrmDigMotivoReprovacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  {*****************}
  {* VALIDA MOTIVO *}
  {*****************}
  If Sender = edtCodMre Then
  Begin
    If fEmptyStr(edtCodMre.Text) Then
    Begin
      fMensagem('', 'O motivo deve ser preenchido!' , ['&Ok']);
      Result := False;
    End
    Else
    Begin
      edtDesMre.Text := fRetDescMotivoReprovacao(edtCodMre.Text);
      If fEmptyStr(edtDesMre.Text) Then
      Begin
        fMensagem('AVISO', 'Motivo de reprovação não encontrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End
  else if (Sender = edtSenDig) and (pnlDigitador.Visible) then
  begin
    if fEmptyStr(edtSenDig.Text) then
    begin
      fMensagem('ATENÇÃO!', 'O digitador deve ser preenchido!', ['&Ok']);
      Result := False;
    end
    else
    begin
      pCarregaDigitador;

      if qryConOpe.FieldByName('OPE_CODOPE').IsNull then
      begin
        fMensagem('ATENÇÃO!', 'Esse digitador não está cadastrado!', ['&Ok']);
        Result := False;
      end
      else If qryConOpe.FieldByName('OPE_STATUS').AsString <> 'A' then
      begin
        fMensagem('ATENÇÃO!', 'Digitador está inativo!', ['&Ok']);
        Result := False;
      end;
    end;
  end;
end;

procedure TfrmDigMotivoReprovacao.pCarregaDigitador;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtSenDig.Text, True);
  edtNomDig.Text := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
  strCodOpe := qryConOpe.FieldByName('OPE_CODOPE').AsString;
end;

procedure TfrmDigMotivoReprovacao.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    strSenDig := edtSenDig.Text;
    ModalResult := mrOk;
  End;
end;

end.
