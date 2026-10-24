{***************************}
{* qryConOpe -> CADOPE     *}
{************************RV*}

unit untSenhaOperador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Uni,  DB, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmSenhaOperador = class(TfrmPai)
    pnlDados: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lblEmpresa: TLabel;
    edtLogin: TEditFocus;
    edtSenha: TEditFocus;
    edtNomOpe: TEditFocus;
    edtSenhaNova: TEditFocus;
    Label3: TLabel;
    edtConfSenha: TEditFocus;
    btnGravar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    blnGravou: Boolean;
    qryConOpe: TUniQuery;
    qryConSen: TUniQuery;
    { Private declarations }
    procedure pCarregaOperador;
    procedure pConfirma;
    procedure pLimparCampos;
    function  fVerificaSenha: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnSenhaAlteradaSucesso: Boolean;
    blnAbriuPelaTelaLogin: Boolean;
  end;

implementation

uses untFuncoesSimples, untFuncoes, untValidaCaracteres, untConstantes;

{$R *.dfm}

{ TfrmSenhaOperador }

procedure TfrmSenhaOperador.btnGravarClick(Sender: TObject);
begin
  inherited;
  pConfirma;
  If blnGravou Then
  Begin
    fMensagem('', 'Senha alterada com sucesso!', ['&Ok']);

    If blnAbriuPelaTelaLogin Then
    Begin
      blnSenhaAlteradaSucesso := blnGravou;

      If fExpirarOuLiberarSenha(edtLogin.Text, ssTrocaSenha) Then
        ModalResult := mrOk;
    End;

    pLimparCampos;
    pSetFocus(edtLogin);
  End;
end;

procedure TfrmSenhaOperador.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(qryConOpe);
  FreeAndNil(qryConSen);
  inherited;
end;

procedure TfrmSenhaOperador.FormCreate(Sender: TObject);
begin
  inherited;
  qryConOpe := fCriaQuery(Self);
  qryConSen := fCriaQuery(Self);
end;

procedure TfrmSenhaOperador.FormShow(Sender: TObject);
begin
  inherited;
  pSetfocus(edtLogin);
end;

function TfrmSenhaOperador.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  var
    strFalha: string;
begin
  Result := True;
  If (Sender = edtLogin) Then
  Begin
    If fEmptyStr(edtLogin.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código do Operador não pode ser vazio!', ['&Ok']);
      Result := False;
    End
    Else
      pCarregaOperador;
  End

  Else If (Sender = edtSenha) Then
  Begin
    If fEmptyStr(edtSenha.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo Senha é de preenchimento obrigatório!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      Result := fVerificaSenha;
    End;
  End

  Else If (Sender = edtSenhaNova) Then
  Begin
    If fCfgSis('SENSEG', varBoolean) Then
    If (Not TValidaCaracteres.fValida([tcvLetra, tcvNumero, tcvSimbolo], edtSenhaNova.Text, strFalha)) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', strFalha, ['&Ok']);
    end;

    If fEmptyStr(edtSenhaNova.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo Nova Senha é de preenchimento obrigatório!', ['&Ok']);
      Result := False;
    End
    Else If Not fSenhaPermitida(edtSenhaNova.Text) Then
    Begin
      pMensagemOk('Caracteres aceitos na senha: ' + STR_CHAR_SENHA);
      Result := False;
    End
    Else If (fCrypt(edtSenhaNova.Text) = qryConOpe.FieldByName('OPE_SENOPE').AsString) Then
    Begin
      fMensagem('ATENÇÃO!', 'Nova Senha igual a Senha atual! Verifique.', ['&Ok']);
      Result := False;
    End
    Else If (fCrypt(edtSenhaNova.Text) <> qryConOpe.FieldByName('OPE_SENOPE').AsString) And
            (fVerificaSenhaVend(edtSenhaNova.Text))                                     Then
    Begin
      fMensagem('ATENÇÃO!', 'Senha inválida ou fora dos padrões exigidos. Verifique.', ['&Ok']);
      Result := False;
    End
    Else If (Length(edtSenhaNova.Text) < fCfgSis('QTMICR', varInteger)) Then
    Begin
      pMensagemOk('A senha deve possuir no mínimo '+IntToStr(fCfgSis('QTMICR', varInteger))+' caracteres');
      Result := False;
    End
    Else If (fContaCaracterRepetido(edtSenhaNova.Text, fCfgSis('QTRTCR', varInteger))) Then
    Begin
      pMensagemOk('Não é permitido repetir o mesmo caracter mais de '+IntToStr(fCfgSis('QTRTCR', varInteger))+' vezes');
      Result := False;
    End;
  End

  Else If (Sender = edtConfSenha) Then
  Begin
    If (edtConfSenha.Text <> edtSenhaNova.Text) Then
    Begin
      fMensagem('ATENÇÃO', 'A confirmação da Nova Senha é diferente da Senha! Verifique.', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmSenhaOperador.fVerificaSenha: Boolean;
  Var
    strSQL: String;
begin
  Result := True;

  {* CARACTERE FORA DE STR_CHAR_SENHA E CRIPTOGRAFADO PELO fCrypt COMO 'A' *}
  If Not fSenhaPermitida(edtSenha.Text) Then
  Begin
    fMensagem('', 'Senha incorreta! Verifique.', ['&O k']);
    Result := False;
    Exit;
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  OPE_STATUS ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADOPE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  OPE_CODOPE = :LOGOPE AND ';
  strSQL := strSQL + '  BINARY OPE_SENOPE = :SENOPE ';

  With qryConSen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('LOGOPE').AsString := edtLogin.Text;
    ParamByName('SENOPE').AsString := fCrypt(edtSenha.Text);
    Open;

    If IsEmpty Then
    Begin
      fMensagem('', 'Senha incorreta! Verifique.', ['&O k']);
      Result := False;
    End;
  End;
end;

procedure TfrmSenhaOperador.pCarregaOperador;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADOPE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  OPE_CODOPE = :LOGOPE ';

  With qryConOpe Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('LOGOPE').AsString := edtLogin.Text;
    Open;

    edtNomOpe.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmSenhaOperador.pConfirma;
begin
  Try
    blnGravou := False;

    pnlInfo.Caption := 'Gravando registro! Aguarde....';

    If (Not fVerificaCampos) Then
    Begin
      pnlInfo.Caption := '';
      Exit;
    End;

    qryConOpe.Edit;
    qryConOpe.FieldByName('OPE_SENOPE').AsString := fCrypt(edtSenhaNova.Text);
    qryConOpe.Post;

    pnlInfo.Caption := '';
    blnGravou := True;
  Except
    On E: EUniError Do
    Begin
      pMensagensErro(IntToStr(E.ErrorCode) + ': ' + E.Message, '[ Gravar registro ]');
      blnGravou := False;
    End;

    On E: Exception Do
    Begin
      blnGravou := False;
      pnlInfo.Caption := '';
      pMensagensErro(E.Message, 'Gravar Registro');
    End;
  End;

end;

procedure TfrmSenhaOperador.pLimparCampos;
begin
  edtLogin.Clear;
  edtSenha.Clear;
  edtNomOpe.Clear;
  edtSenhaNova.Clear;
  edtConfSenha.Clear;
end;

end.
