unit untFatDigNetPoints;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Menus, Buttons, ExtCtrls, AppEvnts,
  BitBtnLockedIncrem, Mask, MaskEditFocus, untMskC_G_C_, frxClass,
  frxExportCSVTestabilidade, QColorLabel, untNetpointsWS, untNetpoints;

type
  TfrmFatDigNetPoints = class(TfrmPai)
    pnlGeral: TPanel;
    edtNpsS_N: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    mskCpfNps: TMaskEditC_G_C_;
    Label1: TLabel;
    Label5: TLabel;
    mskTelNps: TMaskEditFocus;
    ColorLabel7: TColorLabel;
    Label2: TLabel;
    lblSldNps: TLabel;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    objNpsWs : TNetpointsWS;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    objNetPoints : TNetpoints;
    class function fCpfVendedorOK(strCodVen: String): Boolean;
    function fCpfDoClienteJaCadastradoNoNetPoints(strCpfCli: String): Boolean;
  end;

var
  frmFatDigNetPoints: TfrmFatDigNetPoints;

implementation

uses untFuncoesSimples, untFuncoesGenerica;

{$R *.dfm}

{ TfrmFatDigNetPoints }

function TfrmFatDigNetPoints.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    intQtdNps : Integer;
begin
  Result := True;

  Try
    If (Sender = edtNpsS_N) Then
    Begin
      objNetPoints.strQueNps := edtNpsS_N.Text;

      mskCpfNps.Enabled := (objNetPoints.strQueNps = 'S');
      mskTelNps.Enabled := (objNetPoints.strQueNps = 'S');

      If (objNetPoints.strQueNps = 'N') Then
      Begin
        mskCpfNps.Clear;
        mskTelNps.Clear;
        objNetPoints.strCpfCli := '';
        objNetPoints.strFonCli := '';
        objNetPoints.blnCpfCad := False;
        lblSldNps.Caption := 'Saldo antes desta compra: 0';
      End;
    End

    Else If (Sender = mskCpfNps) And (mskCpfNps.Enabled) Then
    Begin
      objNetPoints.strCpfCli := mskCpfNps.Text;

      Result := fValidaCnpjCpf('2', objNetPoints.strCpfCli, False, False);

      If (Result) Then
      Begin
        objNetPoints.blnCpfCad := objNpsWs.fClienteCadastrado(mskCpfNps.Text, False, intQtdNps);
        lblSldNps.Caption := 'Saldo antes desta compra: ' + IntToStr(intQtdNps);
      End
      Else
      Begin
        objNetPoints.blnCpfCad := False;
        lblSldNps.Caption := 'Saldo antes desta compra: 0';
      End;
    End

    Else If (Sender = mskTelNps) And (mskTelNps.Enabled) And ((Not objNetPoints.blnCpfCad) Or (Not fEmptyStr(mskTelNps.Text))) Then
    Begin
      objNetPoints.strFonCli := mskTelNps.Text;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      fMensagemTratada(E);
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatDigNetPoints.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    If (objNetPoints.strQueNps = 'S') Then
    Begin
      If (Not objNetPoints.blnCpfCad) Then
        objNetPoints.blnCpfCad := objNpsWs.fCadastrarCliente(mskCpfNps.Text, mskTelNps.Text, fCampoTabela('OPE_NUMCPF', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]), 0);
    End;
    Close;
    ModalResult := mrOk;
  End;
end;

function TfrmFatDigNetPoints.fCpfDoClienteJaCadastradoNoNetPoints(
  strCpfCli: String): Boolean;
  Var
    intPontos : Integer;
begin
  Result := objNpsWs.fClienteCadastrado(strCpfCli, False, intPontos);
end;

class function TfrmFatDigNetPoints.fCpfVendedorOK(strCodVen: String): Boolean;
  Var
    strCpfOpe : String;
begin
  Result := True;
  If fEmptyStr(strCodVen) Then
  Begin
    fMensagem('', 'É necessário informar o vendedor antes de acessar a rotina de netpoints!', ['&OK']);
    Result := False;
  End
  Else
  Begin
    strCpfOpe := fCampoTabela('OPE_NUMCPF', 'CADOPE', ['OPE_CODOPE'], [strCodVen]);

    If fEmptyStr(strCpfOpe) Then
    Begin
      fMensagem('',Format('É necessário preencher o CPF do OPERADOR: "%s" no Cadastro de Operadores para utilizar a rotina de Netpoints!', [strCodVen]),['&OK']);
      Result := False;
    End
    Else If (Not fValidaCPF(strCpfOpe)) Then
    Begin
      fMensagem('',Format('O CPF do OPERADOR: "%s" não é um CPF válido, por favor, ajustá-lo no Cadastro de Operadores para utilizar a rotina de Netpoints!', [strCodVen]), ['&OK']);
      Result := False;
    End;
  End;
end;

procedure TfrmFatDigNetPoints.FormActivate(Sender: TObject);
begin
  inherited;
  If (edtNpsS_N.Text = 'S') Then
    pSetFocus(mskCpfNps)
  Else
  Begin
    pSetFocus(edtNpsS_N);
    edtNpsS_N.SelectAll;
  End;
end;

procedure TfrmFatDigNetPoints.FormCreate(Sender: TObject);
begin
  inherited;
  mskCpfNps.EditMask := fRetMascaraC_G_C_(fSetaPais, C_P_F_);
  mskTelNps.EditMask := fRetMascaraFonePais;
  objNpsWs := TNetpointsWS.Create(Self, '');
end;

procedure TfrmFatDigNetPoints.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objNpsWs);
end;

procedure TfrmFatDigNetPoints.FormShow(Sender: TObject);
begin
  inherited;
  mskCpfNps.Text := objNetpoints.strCpfCli;
  mskTelNps.Text := objNetpoints.strFonCli;
  edtNpsS_N.Text := objNetpoints.strQueNps;
  objNetPoints.blnCpfCad := False;
end;

end.

