unit untCadContatosEmail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, EditFocus, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, Data.DB, Uni;

type
  TfrmCadContatosEmail = class(TfrmPaiCad)
    grbDadosContato: TGroupBox;
    pgcEmail: TPageControl;
    tbsEmail: TTabSheet;
    Panel1: TPanel;
    lsbEmail: TListBox;
    lblEmail: TLabel;
    edtEmail: TEditFocus;
    btnAdicionar: TSpeedButton;
    btnRemover: TSpeedButton;
    lblNomCon: TLabel;
    dbeNomCon: TDBEditFocus;
    dtsConOpe: TDataSource;
    dbeAutInc: TDBEditFocus;
    grbTelefones: TGroupBox;
    lblTelRes: TLabel;
    lblTelCom: TLabel;
    lblCelula: TLabel;
    dbeTelRes: TDBEditFocus;
    dbeTelCom: TDBEditFocus;
    dbeCelula: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lsbEmailDblClick(Sender: TObject);
    procedure dbeCelulaExit(Sender: TObject);
  private
    { Private declarations }
    procedure pListarEmailsContato;
    procedure pGravarEmailsContato;
    procedure pExcluirEmailsContato;
    procedure pHabilitarBotoesEmail(blnHabilitar: Boolean);
    function  fEmailJaCadastrado(strEmail: String): Boolean;
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema, untFuncoesGenerica;

procedure TfrmCadContatosEmail.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  If (fEmptyStr(edtEmail.Text)) Then Begin
    fMensagem('ALERTA!', 'Informe um endereço de e-Mail para inclusão!', ['&OK']);
    pSetFocus(edtEmail);
  End Else If (Not fEmptyStr(edtEmail.Text)) And (fValidaCampos(edtEmail, True)) Then Begin
    If (lsbEmail.Items.IndexOf(edtEmail.Text) = -1) Then Begin
      If (Not fEmailJaCadastrado(edtEmail.Text)) Then Begin
        lsbEmail.Items.Add(edtEmail.Text);
        edtEmail.Text := '';
      End Else Begin
        fMensagem('ALERTA!', 'Endereço de e-Mail informado já está cadastrado para este operador!', ['&OK']);
      End;
    End Else Begin
      fMensagem('ALERTA!', 'Endereço de e-Mail informado já está cadastrado para este contato!', ['&OK']);
    End;

    pSetFocus(edtEmail);
  End;
end;

procedure TfrmCadContatosEmail.btnAlterarClick(Sender: TObject);
begin
  inherited;

  If (blnAlterou) Then Begin
    pHabilitaCodigo(dbeAutInc, dbeNomCon, False);
    pHabilitarBotoesEmail(True);
  End;
end;

procedure TfrmCadContatosEmail.btnCancelaClick(Sender: TObject);
begin
  inherited;

  edtEmail.Text := '';
  pListarEmailsContato();
  pHabilitarBotoesEmail(False);
end;

procedure TfrmCadContatosEmail.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadContatosEmail.btnExcluirClick]');
    End;
  End;

  If (blnExcluiu) Then Begin
    fCommit;
    pHabilitarBotoesEmail(False);
    lsbEmail.Clear()
  End
  Else
    fRollBack;
end;

procedure TfrmCadContatosEmail.btnGravarClick(Sender: TObject);
begin
  Try
    If (Not fValidacoesBotaoGravarPai()) Then Exit;

    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

    inherited;

    If (blnGravou) Then Begin
      pGravarEmailsContato();

      fCommit();

      pHabilitarBotoesEmail(False);
    End
    Else
      fRollBack();
  Except
    On E: Exception Do Begin
      pMensagensErro(E.Message, 'TfrmCadContatosEmail.btnGravarClick');
      fRollBack();
    End;
  End;
end;

procedure TfrmCadContatosEmail.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If (qryTabela.Active) And (qryTabela.State = dsInsert) Then
    qryTabela.FieldByName('CON_CODOPE').AsString := strLoginUsuarioLogado;

  pHabilitaCodigo(dbeAutInc, dbeNomCon, (Not blnUsaProCodigo));
  pHabilitarBotoesEmail(True);
  lsbEmail.Clear();
end;

procedure TfrmCadContatosEmail.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrTemp: TConsultasArray;
begin
  inherited;

  chrKey := '/';

  If fPesqContatosOperador(Self, Nil, Nil, qryTabela, chrKey, arrTemp) Then Begin
    pListarEmailsContato();
    pHabilitarBotoesEmail(False);
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadContatosEmail.btnRemoverClick(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(edtEmail.Text)) And (fValidaCampos(edtEmail, True)) Then Begin
    If (lsbEmail.Items.IndexOf(edtEmail.Text) >= 0) Then Begin
      If (fMensagem('ATENÇÃO!', 'Confirma exclusão do endereço de e-Mail informado?', ['&Sim', '&Não']) = 1) Then Begin
        lsbEmail.Items.Delete(lsbEmail.Items.IndexOf(edtEmail.Text));
        edtEmail.Text := '';
      End;
    End Else Begin
      fMensagem('ALERTA!', 'Endereço de e-Mail informado já está cadastrado para este contato!', ['&OK']);
    End;

    pSetFocus(edtEmail);
  End Else If (lsbEmail.ItemIndex >= 0) Then Begin
    If (fMensagem('ATENÇÃO!', 'Confirma exclusão do endereço de e-Mail selecionado?', ['&Sim', '&Não']) = 1) Then Begin
      lsbEmail.Items.Delete(lsbEmail.ItemIndex);
    End;
  End Else Begin
    fMensagem('ALERTA!', 'Nenhum endereço de e-Mail foi selecionado ou informado para exclusão!', ['&OK']);
  End;
end;

procedure TfrmCadContatosEmail.dbeCelulaExit(Sender: TObject);
begin
  inherited;

  pSetFocus(edtEmail);
end;

function TfrmCadContatosEmail.fEmailJaCadastrado(strEmail: String): Boolean;
  Var
    qryTemp: TUniQuery;
begin
  Result := False;

  Try
    qryTemp := fCriaQuery();

    Try
      qryTemp.Close();
      qryTemp.SQL.Clear();
      qryTemp.SQL.Text := 'SELECT COUNT(AUTOINCREM) AS QTDE FROM CONOPE INNER JOIN EMACON ON AUTOINCREM = EMA_SEQCON WHERE CON_CODOPE = :CODOPE AND EMA_EMAIL_ = :EMAIL_';
      qryTemp.ParamByName('EMAIL_').AsString := strEmail;
      qryTemp.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      qryTemp.Open();

      Result := (qryTemp.FieldByName('QTDE').AsInteger > 0);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, 'TfrmCadContatosEmail.btnGravarClick');
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

procedure TfrmCadContatosEmail.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela     := 'CONOPE';
  strNomeCampo      := 'AUTOINCREM';
  qryTabela         := fCriarQuery('SELECT * FROM CONOPE', Self);
  dtsConOpe.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeAutInc;
end;

procedure TfrmCadContatosEmail.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Assigned(Self.ActiveControl)) And
    ( ((Self.ActiveControl) = edtEmail) Or ((Self.ActiveControl) = lsbEmail) ) Then Begin
    If (Key = VK_INSERT) Or (Key = VK_ADD) Or (Key = VK_RETURN) Then Begin
      btnAdicionar.Click();
      Key := 0;
    End;

    If (Key = VK_DELETE) Or (Key = VK_SUBTRACT) Then Begin
      btnRemover.Click();
      Key := 0;
    End;
  End;

  inherited;

  If (Key = VK_ESCAPE) Then btnSair.Click();
end;

procedure TfrmCadContatosEmail.FormShow(Sender: TObject);
begin
  inherited;

  pHabilitarBotoesEmail(False);

  pSetFocus(btnIncluir);
end;

function TfrmCadContatosEmail.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = dbeNomCon) Then Begin
    If (fEmptyStr(dbeNomCon.Text))Then Begin
      fMensagem('ATENÇÃO!', 'O Nome do Contato deve ser informado!', ['&OK']);
      Result := False;
    End;
  End Else

  If (Sender = dbeTelRes) Or (Sender = dbeTelCom) Or (Sender = dbeCelula) Then Begin
    If (Not fEmptyStr(TDBEditFocus(Sender).Text)) And
       (Not fValidaTelefone(TDBEditFocus(Sender).Text)) Then Begin
      fMensagem('ATENÇÃO!', 'Informe o número de telefone/celular corretamente!', ['&OK']);
      Result := False;
    End Else
      TDBEditFocus(Sender).Text := fAcertaMaskTel(TDBEditFocus(Sender).Text);
  End Else

  If (Sender = edtEmail) Then Begin
    If (Not fEmptyStr(edtEmail.Text)) And (Not fEnderecoEmailValido(edtEmail.Text)) Then Begin
      fMensagem('ATENÇÃO!', 'Endereço de e-Mail informado é inválido!', ['&OK']);
      Result := False;
    End;
  End Else

  If (Sender = lsbEmail) Then Begin
    If (lsbEmail.Items.Count = 0) Then Begin
      fMensagem('ATENÇÃO!', 'Ao menos 1 endereço de e-Mail deve ser informado para o contato!', ['&OK']);
      Sender := edtEmail;
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadContatosEmail.lsbEmailDblClick(Sender: TObject);
begin
  inherited;

  If (lsbEmail.ItemIndex >= 0) Then Begin
    edtEmail.Text := lsbEmail.Items[lsbEmail.ItemIndex];
    lsbEmail.Items.Delete(lsbEmail.ItemIndex);
    pSetFocus(edtEmail);
  End;
end;

procedure TfrmCadContatosEmail.pExcluirEmailsContato;
  Var
    qryTemp: TUniQuery;
begin
  Try
    qryTemp := fCriaQuery(Self);

    Try
      qryTemp.Close();
      qryTemp.SQL.Clear();
      qryTemp.SQL.Add('DELETE FROM EMACON WHERE EMA_SEQCON = :SEQCON');
      qryTemp.ParamByName('SEQCON').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      qryTemp.ExecSQL();
    Except
      On E: Exception Do
        pMensagensErro(E.Message, 'TfrmCadContatosEmail.pExcluirEmailsContato');
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
End;

procedure TfrmCadContatosEmail.pGravarEmailsContato;
  Var
    i: Integer;
    qryTemp: TUniQuery;
begin
  Try
    qryTemp := fCriaQuery(Self);

    Try
      pExcluirEmailsContato();

      For i := 0 To lsbEmail.Items.Count - 1 Do Begin
        qryTemp.Close();
        qryTemp.SQL.Clear();
        qryTemp.SQL.Add('INSERT INTO EMACON (EMA_SEQCON, EMA_EMAIL_) VALUES (:SEQCON, :EMAIL_)');
        qryTemp.ParamByName('SEQCON').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
        qryTemp.ParamByName('EMAIL_').AsString := Trim(lsbEmail.Items[i]);
        qryTemp.ExecSQL();
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, 'TfrmCadContatosEmail.pGravarEmailsContato');
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

procedure TfrmCadContatosEmail.pHabilitarBotoesEmail(blnHabilitar: Boolean);
begin
  btnRemover.Enabled   := blnHabilitar;
  btnAdicionar.Enabled := blnHabilitar;
  lsbEmail.Enabled     := blnHabilitar;
end;

procedure TfrmCadContatosEmail.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('AUTOINCREM');
  stlCampos.Add('CON_NOMCON');
  stlCampos.Add('CON_TELRES');
  stlCampos.Add('CON_TELCOM');
  stlCampos.Add('CON_CELULA');

  stlCamInd.Add('CON_NOMCON');
  stlCamInd.Add('AUTOINCREM');

  stlDesInd.Add('Nome Contato');
  stlDesInd.Add('AUTOINCREM');
end;

procedure TfrmCadContatosEmail.pListarEmailsContato;
  Var
    qryTemp: TUniQuery;
begin
  Try
    qryTemp := fCriaQuery(Self);
    lsbEmail.Clear();

    Try
      qryTemp.Close();
      qryTemp.SQL.Clear();
      qryTemp.SQL.Add('SELECT EMA_EMAIL_ FROM EMACON WHERE EMA_SEQCON = :SEQCON');
      qryTemp.ParamByName('SEQCON').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      qryTemp.Open();
      qryTemp.First();

      While (Not qryTemp.Eof) Do Begin
        lsbEmail.Items.Add(qryTemp.FieldByName('EMA_EMAIL_').AsString);

        qryTemp.Next();
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, 'TfrmCadContatosEmail.pListarEmailsContato');
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

end.
