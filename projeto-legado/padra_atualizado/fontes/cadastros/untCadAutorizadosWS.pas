unit untCadAutorizadosWS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass, ClipBrd,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, QColorLabel, Data.DB, Uni, DBMemoFocus;

type
  TfrmCadAutorizadosWebService = class(TfrmPaiCad)
    pnlFundo: TPanel;
    lblDescricao: TLabel;
    lblCodigo: TLabel;
    dbeDescricao: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    mmoChave: TDBMemoFocus;
    lblChave: TLabel;
    lblSenha: TLabel;
    dbeSenha: TDBEditFocus;
    dtsCadAut: TDataSource;
    lblSiglaNumPok: TLabel;
    dbeSiglaNumPok: TDBEditFocus;
    lblLogin: TLabel;
    dbeLogin: TDBEditFocus;
    lblTipoAuth: TLabel;
    drbTipoAuth: TDBRadioGroup;
    lblTipoIntegracaoWS: TLabel;
    dbeTipoIntegracaoWS: TDBEditFocus;
    btnGerar: TSpeedButton;
    btnCopiar: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeTipoIntegracaoWSKeyPress(Sender: TObject; var Key: Char);
    procedure drbTipoAuthChange(Sender: TObject);
    procedure btnCopiarClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure dtsCadAutStateChange(Sender: TObject);
    procedure dbeTipoIntegracaoWSExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function fExisteAutorizado(strCampo: String; strValor: String): Boolean;
    { Private declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadAutorizadosWebService: TfrmCadAutorizadosWebService;

implementation

uses
  citelSSL,
  untGravando,
  untFuncoes,
  untFuncoesSimples,
  untConsultas,
  untTypesSistema;

{$R *.dfm}

procedure TfrmCadAutorizadosWebService.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescricao, False);
  drbTipoAuthChange(Sender);
  pSetFocus(dbeDescricao);
end;

procedure TfrmCadAutorizadosWebService.btnCopiarClick(Sender: TObject);
begin
  inherited;
  Clipboard.AsText := mmoChave.Text;
end;

procedure TfrmCadAutorizadosWebService.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAutorizadosWS.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadAutorizadosWebService.btnGerarClick(Sender: TObject);
  Var
    strChavePrivada, strChavePublica : String;
    intOpcao : Integer;
    svdArquivo : TSaveDialog;
begin
  inherited;

  If (qryTabela.State in [dsInsert, dsEdit]) Then
  Begin
    btnGerar.Caption := 'Gerando...';
    Application.ProcessMessages;
    Try
      geraChaves(strChavePrivada, strChavePublica);
      If fEmptyStr(strChavePrivada) Or fEmptyStr(strChavePublica) Then
      Begin
        pMensagemOk('Ocorreu um erro na geração das chaves, tente novamente!');
        Exit;
      End;

      mmoChave.Text := strChavePublica;

      intOpcao := fMensagem('', 'Chave gerada com sucesso!' + sLineBreak +
                                'O que deseja fazer com a Chave Privada:', ['Copiar', 'Salvar Txt', 'Ignorar']);
      Case intOpcao Of
        1: Clipboard.AsText := strChavePrivada;
        2:
          Begin
            svdArquivo := TSaveDialog.Create(Self);
            Try
              svdArquivo.Filter := 'Arquivos Txt (*.txt)|*.txt';
              svdArquivo.DefaultExt := 'txt';
              svdArquivo.FileName := 'ChavePrivada.txt';

              If svdArquivo.Execute Then
              Begin
                If (fSalvarTextoEmArquivo(strChavePrivada, svdArquivo.FileName, True)) Then
                  pMensagemOk('Arquivo salvo em: ' + svdArquivo.FileName)
                Else
                  pMensagemOk('Ocorreu um erro ao salva o arquivo em: ' + svdArquivo.FileName);
              End;
            Finally
              FreeAndNil(svdArquivo);
            End;
          End;
      End;
    Finally
      btnGerar.Caption := 'Gerar';
    End;
  End;
end;

procedure TfrmCadAutorizadosWebService.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  Try
    Try
      If (qryTabela.State = dsInsert) Then
        qryTabela.FieldByName('INT_CODAUT').AsString := fAtualizaProcod('CONECTA_INTEGRACOES', 'INT_CODAUT');

      inherited;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[untCadAutorizadosWebService.btnGravarClick]');
      End;
    End;
  Finally
    If blnGravou Then
      fCommit
    Else
      fRollBack;
  End;
end;

procedure TfrmCadAutorizadosWebService.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescricao, False);
  qryTabela.FieldByName('INT_USATRB').AsString := 'N';
  qryTabela.FieldByName('INT_INTATI').AsString := 'S';
  qryTabela.FieldByName('INT_TPAUTH').AsString := 'T';
  qryTabela.FieldByName('INT_SIGPED').AsString := '';
  drbTipoAuthChange(Sender);
  pSetFocus(dbeDescricao);
end;

procedure TfrmCadAutorizadosWebService.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
begin
  chrKey := '/';
  If fPesqAutorizadosWS(Self, Nil, Nil, qryTabela, chrKey, arrSel) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadAutorizadosWebService.dbeTipoIntegracaoWSExit(Sender: TObject);
begin
  inherited;
  If (qryTabela.State in [dsInsert, dsEdit]) And (fEmptyStr(dbeSiglaNumPok.Text)) Then
    qryTabela.FieldByName('INT_SIGPED').AsString := fCampoTabela('SIS_SIGPED', 'CONECTA_SISEXT', ['SIS_CODSIS'], [dbeTipoIntegracaoWS.Text]);
end;

procedure TfrmCadAutorizadosWebService.dbeTipoIntegracaoWSKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
    qryConTip : TUniQuery;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    qryConTip := fCriaQuery(Self);
    Try
      if fPesqTipoIntegracaoWS(Self, dbeTipoIntegracaoWS, Nil, qryConTip, Key, arrSel, True) then
      Begin
        If (fValidaCampos(dbeTipoIntegracaoWS, True)) Then
          SelectNext(ActiveControl, True, True);
      End;
    Finally
      FreeAndNil(qryConTip);
    End;
  End;
end;

procedure TfrmCadAutorizadosWebService.drbTipoAuthChange(Sender: TObject);
begin
  inherited;
  If (qryTabela.State in [dsInsert, dsEdit]) Then
  Begin
    mmoChave.Enabled := drbTipoAuth.ItemIndex = 1;
    dbeLogin.Enabled := drbTipoAuth.ItemIndex = 0;
    dbeSenha.Enabled := drbTipoAuth.ItemIndex = 0;

    btnGerar.Enabled  := mmoChave.Enabled;
    btnCopiar.Enabled := mmoChave.Enabled;
  End;
end;

procedure TfrmCadAutorizadosWebService.dtsCadAutStateChange(Sender: TObject);
begin
  inherited;
  If (qryTabela.State = dsBrowse) Then
  Begin
    btnGerar.Enabled  := False;
    btnCopiar.Enabled := False;
  End;
end;

procedure TfrmCadAutorizadosWebService.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CONECTA_INTEGRACOES';
  strNomeCampo      := 'INT_CODAUT';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  blnUsaProCodigo := True;
end;

procedure TfrmCadAutorizadosWebService.FormShow(Sender: TObject);
begin
  qryTabela := fCriarQuery('SELECT * FROM CONECTA_INTEGRACOES WHERE FALSE', Self);
  inherited;

  dtsCadAut.DataSet := qryTabela;
  qryTabela.Open;
end;

function TfrmCadAutorizadosWebService.fExisteAutorizado(strCampo: String; strValor: String) : Boolean;
  Var
    qryAux : TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  Try
    qryAux.SQL.Add(' SELECT * ');
    qryAux.SQL.Add(' FROM CONECTA_INTEGRACOES ');
    qryAux.SQL.Add(' WHERE ' +strCampo+ ' = :PARAME ');
    qryAux.SQL.Add('   AND INT_CODAUT <> :CODAUT ');
    qryAux.ParamByName('PARAME').AsString := strValor;
    qryAux.ParamByName('CODAUT').AsString := dbeCodigo.Text;
    qryAux.Open;

    Result := Not qryAux.IsEmpty;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmCadAutorizadosWebService.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = dbeDescricao Then
    Begin
      dbeDescricao.Text := Trim(dbeDescricao.Text);
      If fEmptyStr(dbeDescricao.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Campo "Descrição" deve ser preenchido!', ['&Ok']);
      End
      Else If (fExisteAutorizado('INT_DESCRI', dbeDescricao.Text)) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Já existe outro autorizado com essa descrição', ['&Ok']);
      End;
    End
    Else If Sender = dbeTipoIntegracaoWS Then
    Begin
      If fEmptyStr(dbeTipoIntegracaoWS.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Campo "Tipo de Integração WebService" deve ser preenchido!', ['&Ok']);
      End
      Else
      If fEmptyStr(fRetTipoIntegracaoWS(dbeTipoIntegracaoWS.Text, True)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Tipo de Integração WebService não encontrado ou Inativo!', ['&Ok']);
        Result := False;
      End
    End
    Else If Sender = dbeSiglaNumPok Then
    Begin
      If fEmptyStr(dbeSiglaNumPok.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Campo "Sigla NUMPOK" deve ser preenchido!', ['&Ok']);
      End;
    End
    Else If Sender = mmoChave Then
    Begin
      If (drbTipoAuth.ItemIndex = 1) And (fEmptyStr(mmoChave.Text)) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Campo "Chave Pública" deve ser preenchido!', ['&Ok']);
      End;
    End
    Else If Sender = dbeLogin Then
    Begin
      If (drbTipoAuth.ItemIndex = 0) Then
      Begin
        dbeLogin.Text := Trim(dbeLogin.Text);
        If (fEmptyStr(dbeLogin.Text)) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!', 'O Campo "Login" deve ser preenchido!', ['&Ok']);
        End
        Else If (fExisteAutorizado('INT_LOGIN_', dbeLogin.Text)) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!', 'Já existe outro autorizado com esse login', ['&Ok']);
        End;
      End;
    End
    Else If Sender = dbeSenha Then
    Begin
      If (drbTipoAuth.ItemIndex = 0) And (fEmptyStr(dbeSenha.Text)) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Campo "Senha" deve ser preenchido!', ['&Ok']);
      End;
    End
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadAutorizadosWebService.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('INT_DESCRI');
  stlCampos.Add('INT_CODAUT');

  stlCamInd.Add('INT_DESCRI');
  stlCamInd.Add('INT_CODAUT');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

end.
