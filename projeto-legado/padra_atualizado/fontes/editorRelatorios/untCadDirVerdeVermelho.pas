unit untCadDirVerdeVermelho;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, untFuncoesSimples, untTypesSistema;

type
  TfrmCadDirVerdeVermelho = class(TfrmPaiCad)
    pnlDados: TPanel;
    dtsCadDir: TDataSource;
    Label2: TLabel;
    Label1: TLabel;
    dbeDesDir: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    btnDirAce: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnDirAceClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strVerVer: String;

  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

{$R *.dfm}

Uses
  untConsultas, untFuncoesConsulta, untInterfaceRelatorio, untDirAcesso;

procedure TfrmCadDirVerdeVermelho.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDesDir, False);

end;

procedure TfrmCadDirVerdeVermelho.btnDirAceClick(Sender: TObject);
  Var
    frmDirAcesso: TfrmDirAcesso;
begin
  inherited;

  With qryTabela Do
  Begin

    If State In dsEditModes Then
    Begin
      pMensagemOk('Salve o registro para poder informar os Direitos de Acesso!');
      Exit;
    End;

    If IsEmpty Or fEmptyStr(FieldByName('DIR_NOMDIR').AsString) Then
    Begin
      pMensagemOk('Salve o registro para poder informar os Direitos de Acesso!');
      Exit;
    End;

    If Not fVerificaAcessoSistema('SIVDVM') Then
    Begin
      pMensagemOk('Operador sem permissão para alterar os Direitos de Acesso!');
      Exit;
    End;

    Try

      pCriarFormularios(TfrmDirAcesso, frmDirAcesso);

      frmDirAcesso.edtPesquisar.Text := ' ... Sistema Verde e Vermelho ... ' + FieldByName('DIR_NOMDIR').AsString;
      frmDirAcesso.blnPesquisar := True;

      frmDirAcesso.ShowModal;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TfrmCadDirVerdeVermelho.btnDirAceClick');
      End;
    End;

    pFreeAndNil(frmDirAcesso)
  End;
end;

procedure TfrmCadDirVerdeVermelho.btnExcluirClick(Sender: TObject);
  Var
    strCodDir: String;
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  With qryTabela Do
  If TInterfaceRelatorio.fPodeExcluirDireito(FieldByName('DIR_CODDIR').AsString) Then
  Begin
    strCodDir := FieldByName('DIR_CODDIR').AsString;

    Try
      inherited;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCadDirVerdeVermelho.btnExcluirClick]');
      End;
    End;

    If blnExcluiu Then
      fCommit
    Else
      fRollBack;

    TInterfaceRelatorio.pExcluiItemMenu(strCodDir);
  End;

end;

procedure TfrmCadDirVerdeVermelho.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadDirVerdeVermelho.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  If blnGravou Then
  With qryTabela Do
  TInterfaceRelatorio.fInsereDireitoNoMenu(FieldByName('DIR_CODDIR').AsString, FieldByName('DIR_NOMDIR').AsString);

end;

procedure TfrmCadDirVerdeVermelho.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDesDir, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

end;

procedure TfrmCadDirVerdeVermelho.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrDirAce: TConsultasArray;
begin
  inherited;

  chrKey := '/';
  If fPesqDireitosVerdeVermelho(Self, Nil, Nil, qryTabela, chrKey, arrDirAce) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadDirVerdeVermelho.FormCreate(Sender: TObject);
begin
  inherited;

  strVerVer     := '';
  strNomeTabela := 'CADDIR';
  strNomeCampo  := 'DIR_CODDIR';

  qryTabela := fCriaQuery(Self);

  dtsCadDir.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadDirVerdeVermelho.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(stlCampos);
  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);
end;

procedure TfrmCadDirVerdeVermelho.FormShow(Sender: TObject);
begin
  inherited;

  If btnIncluir.Enabled Then
    pSetFocus(btnIncluir);

  If Not fEmptyStr(strVerVer) Then
  Begin
    qryTabela.SQL.Text := 'SELECT * FROM CADDIR WHERE DIR_NOMDIR = :NOMDIR';
    qryTabela.ParamByName('NOMDIR').AsString := strVerVer;
    qryTabela.Open;
  End;
end;

procedure TfrmCadDirVerdeVermelho.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
end;

function TfrmCadDirVerdeVermelho.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    strCodDir: String;
Begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDesDir) Then
    Begin
      If fEmptyStr(dbeDesDir.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Direito de Acesso deve ser preenchida!', ['&Ok']);
        Result := False;
      End

      Else
      Begin
        strCodDir := fCampoTabela('DIR_CODDIR', 'CADDIR', ['DIR_NOMDIR'], [dbeDesDir.Text]);

        If (Not fEmptyStr(strCodDir)) And (strCodDir <> qryTabela.FieldByName('DIR_CODDIR').AsString) Then
        Begin
          fMensagem('ATENÇÃO!', 'Já existe um Direito de Acesso com esse nome!', ['&Ok']);
          Result := False;
        End;
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
End;

end.
