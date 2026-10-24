unit untCfgCadProvedorOAuth2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus;

type
  TfrmCfgCadProvedorOauth2 = class(TfrmPai)
    pnlFundo: TPanel;
    lblServidorSMTPTexto: TLabel;
    lblServidorIMAPTexto: TLabel;
    lblServidorSMTP: TLabel;
    lblServidorIMAP: TLabel;
    chkUtilizarOAuth2: TCheckBox;
    grpConfiguracoesOAuth2: TGroupBox;
    lblClientID: TLabel;
    edtClientID: TEditFocus;
    lblClientSecret: TLabel;
    lblTenantID: TLabel;
    edtClientSecret: TEditFocus;
    edtTenantID: TEditFocus;
    btnValidarDadosOAuth2: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnAjuda: TBitBtnLocked;
    procedure chkUtilizarOAuth2Click(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnValidarDadosOAuth2Click(Sender: TObject);
    procedure edtClientIDChange(Sender: TObject);
  private
    FProvedor: Integer;

    FDadosValidos: Boolean;

    function ValidaDadosDigitados: Boolean;
    { Private declarations }
  public
    property Provedor: Integer read FProvedor write FProvedor;
    { Public declarations }
  end;

implementation
Uses untFuncoesSimples, untTEnvioEmailAutenticacaoOAuth2;
{$R *.dfm}

procedure TfrmCfgCadProvedorOauth2.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If Not ValidaDadosDigitados Then
    Exit;

  Self.Close;

  ModalResult := mrOK;
end;

procedure TfrmCfgCadProvedorOauth2.btnValidarDadosOAuth2Click(Sender: TObject);
  Var
    LAutenticacao: TEnvioEmailAutenticacaoOAuth2;
begin
  If Not btnConfirma.Focused Then
  Begin
    If fMensagem('CONFIRMAÇÃO', 'Tem certeza que deseja validar os dados de autorização?', ['&Sim', '&Não']) = 2 Then
      Exit;
  End;

  inherited;
  Try
    FDadosValidos := False;

    LAutenticacao := TEnvioEmailAutenticacaoOAuth2.Create(EmptyStr,
                                                          FProvedor,
                                                          edtClientId.Text,
                                                          edtClientSecret.Text,
                                                          edtTEnantId.Text);

    If LAutenticacao.GetToken(True).IsEmpty Then
    Begin
      fMensagem('ATENÇÃO', 'Dados de autorização não estão corretos. Verifique!', ['&Ok']);
      Exit;
    End;

    fMensagem('ATENÇÃO', 'Dados de autorização validados com sucesso.', ['&Ok']);

    FDadosValidos := True;
  Except
    On E: Exception Do
      fMensagem('ATENÇÃO', 'Erro ao autorizar os dados: ' + E.Message, ['&Ok']);
  End;

  FreeAndNil(LAutenticacao);
end;

procedure TfrmCfgCadProvedorOauth2.chkUtilizarOAuth2Click(Sender: TObject);
begin
  inherited;
  grpConfiguracoesOAuth2.Enabled := chkUtilizarOAuth2.Checked;
end;

procedure TfrmCfgCadProvedorOauth2.edtClientIDChange(Sender: TObject);
begin
  inherited;
  FDadosValidos := False;
end;

procedure TfrmCfgCadProvedorOauth2.FormCreate(Sender: TObject);
begin
  inherited;
   FDadosValidos := True;
end;

function TfrmCfgCadProvedorOauth2.ValidaDadosDigitados: Boolean;
begin
  If Not chkUtilizarOAuth2.Checked Then
    Exit(True);

  Result := Not fEmptyStr(edtClientId.Text);

  If Result Then
    Result := Not fEmptyStr(edtClientSecret.Text);

  //Validação para Microsoft (avaliar necessidade em outros provedores)
  If Result Then
    Result := Not fEmptyStr(edtTenantId.Text);

  If Result Then
  Begin
    If Not FDadosValidos Then
    Begin
      fMensagem('ATENÇÃO', 'Como os dados da tela foram alterados, o sistema validará os dados de autenticação OAutn2.', ['&Ok']);

      btnValidarDadosOAuth2.Click;
    End;
  End;

  If Result Then
    Result := FDadosValidos;

  If Not Result Then
    fMensagem('ATENÇÃO', 'É necessário digitar todos os dados e realizar a validação dos dados de autenticação para confirmar.', ['&Ok']);
end;

end.
