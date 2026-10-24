unit untRcxFecCaixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Menus, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  untRcxTResumoDeCaixa;

type
  TfrmRcxFecCaixa = class(TfrmPaiSimples)
    pnlCentral: TPanel;
    Label1: TLabel;
    edtSenRes: TEditFocus;
    lblSaldoFechamento: TLabel;
    edtSalFec: TEditFocus;
    btnConfirma: TBitBtnLocked;
    pnlLacre: TPanel;
    Label2: TLabel;
    edtNumeroLacre: TEditFocus;
    lblFundoDeCaixa: TLabel;
    edtFundoDeCaixa: TEditFocus;
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    FTransferenciaCega,
    blnSemLacreLiberado: Boolean;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    fltSalFec: Double;
    dteDtaFechamento: TDateTime;
    blnConfirma,
    Divergencia: Boolean;

    strCodigoCaixa: String;
    objResumoDeCaixa: TResumoDeCaixa;
  end;

implementation

uses  untfuncoesSimples, untPai, untLiberacao;

{$R *.dfm}

procedure TfrmRcxFecCaixa.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRcxFecCaixa.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtSenRes);
end;

procedure TfrmRcxFecCaixa.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  Divergencia := False;

  FTransferenciaCega := fCfgSis('TRFCEG', varBoolean);
end;

procedure TfrmRcxFecCaixa.FormShow(Sender: TObject);
begin
  inherited;
  If (FTransferenciaCega) Then
  Begin
    lblSaldoFechamento.Visible := False;
    edtSalFec.Visible := False;

    If (objResumoDeCaixa.strTipoFechamento = 'C') Then
    Begin
      lblFundoDeCaixa.Visible := Divergencia;
      edtFundoDeCaixa.Visible := Divergencia;

      lblFundoDeCaixa.Top := lblSaldoFechamento.Top;
      edtFundoDeCaixa.Top := edtSalFec.Top;
    End;
  End;

  pnlLacre.Visible := False;
  If (objResumoDeCaixa.strTipoFechamento = 'C') Then
  Begin
    pnlLacre.Visible := fCfgSis('RCXLAC', varBoolean);

    If (not FTransferenciaCega) Then
      edtFundoDeCaixa.Text := FormatFloat(',0.00', objResumoDeCaixa.fRetornaFundoDeCaixaInformadoNaTransferencia(strCodigoCaixa,
                                                                                                                 dteDtaFechamento));
  End;

  If Not pnlLacre.Visible Then
    Self.Height := 142;
end;

function TfrmRcxFecCaixa.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    objLiberacao: TLiberacao;
begin

  Result := True;

  If (Sender = edtSenRes) Then
  Begin

    If (edtSenRes.Text <> fCfgSis('SENRES')) Then
    Begin
      fMensagem('', 'Senha incorreta!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      edtSalFec.Text := FloatToStrF(fltSalFec, ffFixed, 12, 2);
    End;

  End
  Else If (Sender = edtNumeroLacre) And (pnlLacre.Visible) Then
  Begin
    Result := (Not fEmptyStr(edtNumeroLacre.Text)) Or
              (blnSemLacreLiberado);
    If Not Result Then
    Begin
      objLiberacao := TLiberacao.Create;
      objLiberacao.objMsgLibera.pAddTexto('Permitir realizar o fechamento de caixa sem informar o número do lacre.');

      objLiberacao.strDirAce := 'LIBRCXSEMLAC';
      objLiberacao.strMsgSen := 'Permitir realizar o fechamento de caixa sem informar o número do lacre.';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;

      Result := objLiberacao.fLibera;

      FreeAndNil(objLiberacao);

      blnSemLacreLiberado := Result;

      If Not Result Then
        fMensagem('ATENÇÃO', 'Usuário sem permissão para fechar o caixa sem informar o número do lacre.', ['&Ok']);
    End;
  End
  Else If (Sender = edtFundoDeCaixa) And (edtFundoDeCaixa.Visible) Then
  Begin
    If fEmptyStr(edtFundoDeCaixa.Text) Then
      Result := fMensagem('ATENÇÃO', 'O fundo de caixa deve ser preenchido!', ['OK']) = 3
    Else If fStrToFloat(edtFundoDeCaixa.Text) < 0.00 Then
      Result := fMensagem('ATENÇÃO', 'O fundo de caixa não pode ser menor que zero!', ['OK']) = 3;
  End;


  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmRcxFecCaixa.btnConfirmaClick(Sender: TObject);
var
  fltValFecConf: Double;
begin
  inherited;

  fltValFecConf := fFormataFloat(objResumoDeCaixa.fRetornaSaldoCaixa(strCodigoCaixa, dteDtaFechamento, VS_strCodEmp), 2);

  If (fVerificaCampos) Then
  Begin
    if fFormataFloat(fltValFecConf, 2) <> fFormataFloat(fltSalFec, 2) then
    begin
      fMensagem('ATENÇÃO', 'Foi efetuado lançamento no caixa durante o fechamento. '+ #13 +'Tente novamente!', ['&Ok']);

      blnConfirma := False;
      Close;
      Exit;
    end;

    blnConfirma := True;
    Close;
  End;

end;

end.

