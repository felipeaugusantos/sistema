unit untCadCaixas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, QColorLabel, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, EditFocus, DB, StrUtils, Uni;

type
  TfrmCadCaixas = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDescricao: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    Label37: TLabel;
    ColorLabel1: TColorLabel;
    dbeStatus: TDBEditFocus;
    Label148: TLabel;
    edtCodEmpresa: TDBEditFocus;
    edtDesEmpresa: TEditFocus;
    dtsCadCax: TDataSource;
    pnlChavePix: TPanel;
    lblChavePix: TLabel;
    edtChavePix: TEditFocus;
    btnVincularChavePix: TBitBtnLocked;
    pnlArmazem: TPanel;
    lblNumLot: TLabel;
    edtNomArm: TEditFocus;
    edtCodArm: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnVincularChavePixClick(Sender: TObject);
    procedure edtCodArmKeyPress(Sender: TObject; var Key: Char);
  private
    procedure pCarregaEmpresa;
    procedure CarregaChavePix;

    procedure pLimparEdits;

    function ExisteLancamentosDeCaixa(ACodigoCaixa,
                                      ACodigoEmpresa: String): Boolean;
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation
Uses
  untFuncoesSimples, untTypesSistema, untConsultas, untRcxTResumoDeCaixa;
{$R *.dfm}

procedure TfrmCadCaixas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescricao, False);

  edtCodEmpresa.Enabled := False;

  btnVincularChavePix.Enabled := pnlChavePix.Visible;
end;

procedure TfrmCadCaixas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pLimparEdits;
  pCarregaEmpresa;
  CarregaChavePix;

  btnVincularChavePix.Enabled := False;
end;

procedure TfrmCadCaixas.btnExcluirClick(Sender: TObject);
begin
  If fEmptyStr(dbeCodigo.Text) Then
    Exit;

  If ExisteLancamentosDeCaixa(dbeCodigo.Text, edtCodEmpresa.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'O registro não pode ser excluído, pois existem lançamentos para o caixa selecionado.', ['&Ok']);
    Exit;
  End;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadCaixas.btnExcluirClick]');
    End;
  End;

  If (blnExcluiu) Then
    fCommit
  Else
    fRollBack;

  pCarregaEmpresa;
  CarregaChavePix;
end;

procedure TfrmCadCaixas.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnUsaProCodigo := False;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadCaixas.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  btnVincularChavePix.Enabled := False;
end;

procedure TfrmCadCaixas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  qryTabela.FieldByName('CAX_STATUS').AsString := 'A';
  pHabilitaCodigo(dbeCodigo, dbeDescricao, True);
  pLimparEdits;

  pSetFocus(dbeCodigo);
end;

procedure TfrmCadCaixas.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrCaixas: TConsultasArray;
begin
  chrKey := '/';
  If fPesqCaixas(Self, Nil, Nil, qryTabela, chrKey, arrCaixas) Then
  Begin
    pCarregaEmpresa;
    CarregaChavePix;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadCaixas.btnVincularChavePixClick(Sender: TObject);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin
  If qryTabela.State <> dsEdit Then
  Begin
    fMensagem('ATENÇÃO', 'Só pode ser vinculada uma chave Pix ao caixa já incluído.' + #13 +
                         'Confirme o cadastro do caixa, clique em altrerar e faça o vínculo da chave Pix.', ['&Ok']);
    Exit;
  End;

  If btnVincularChavePix.Caption = 'Desvincular Chave' Then
  Begin
    qryTabela.FieldByName('CAX_SEQPIX').Value := Null;
    CarregaChavePix;
    Exit;
  End;

  edtCodigo := TEditFocus.Create(Nil);
  edtDescri := TEditFocus.Create(Nil);
  Try
    try
      Key := '/';
      If fPesqChavesPixContas(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao, True, edtCodEmpresa.Text) Then
      Begin
        qryTabela.FieldByName('CAX_SEQPIX').AsString := edtCodigo.Text;
        CarregaChavePix;
      End;
    finally
      FreeAndNil(edtCodigo);
      FreeAndNil(edtDescri);
    end;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;
End;

procedure TfrmCadCaixas.CarregaChavePix;
begin
  btnVincularChavePix.Caption := 'Vincular Chave';
  edtChavePix.Clear;

  If qryTabela.FieldByName('CAX_SEQPIX').AsString.IsEmpty Then
    Exit;

  edtChavePix.Text := fRetDadosPix(qryTabela.FieldByName('CAX_SEQPIX').AsString);
  If Not fEmptyStr(edtChavePix.Text) Then
    btnVincularChavePix.Caption := 'Desvincular Chave';
end;

procedure TfrmCadCaixas.edtCodArmKeyPress(Sender: TObject; var Key: Char);
  Var
    arrArm : TConsultasArray;
begin
  inherited;

  If fPesqArmazem(Self, edtCodArm, edtNomArm, nil, Key, arrArm, True, '', edtCodEmpresa.Text) Then
  Begin
    If fValidaCampos(edtCodArm, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCaixas.edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, True, True) Then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadCaixas.ExisteLancamentosDeCaixa(ACodigoCaixa,
  ACodigoEmpresa: String): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT * FROM CADRCXX ' +
                          'WHERE RCX_CODEMP="' + ACodigoEmpresa + '" ' +
                          '  AND RCX_CODCAX="' + ACodigoCaixa + '" ' +
                          'LIMIT 1 ';
    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmCadCaixas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If Assigned(qryTabela) Then
    FreeAndNil(qryTabela);
end;

procedure TfrmCadCaixas.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADCAX';
  strNomeCampo      := 'CAX_CODCAX';
  qryTabela         := fCriarQuery('SELECT * FROM CADCAX WHERE FALSE', Self);
  dtsCadCax.DataSet := qryTabela;

  qryTabela.Open;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodigo;
  arrCamposChave[1] := edtCodEmpresa;

  blnUsaProCodigo := False;
end;

procedure TfrmCadCaixas.FormShow(Sender: TObject);
begin
  inherited;
 If Not fCfgSis('USAPIX', varBoolean) Then
 Begin
   pnlChavePix.Visible := False;
   Self.Height := (Self.Height - pnlChavePix.Height) + 3;
 End;

 pnlArmazem.Visible := fCfgSis('VINAF3', varBoolean);
end;

function TfrmCadCaixas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeDescricao) Then
    Begin
      If fEmptyStr(dbeDescricao.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do caixa deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeStatus) Then
    Begin
      If Not MatchStr(dbeStatus.Text, ['A', 'I']) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Situação do caixa deve ser preenchida com "A" ou "I"!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodEmpresa) Then
    Begin

      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        pCarregaEmpresa;
        If (fEmptyStr(edtDesEmpresa.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('', 'Usuário sem permissão de acesso a essa Empresa!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'A Empresa do caixa deve ser preenchida!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = dbeCodigo) Then
    Begin

      If Not fEmptyStr(dbeCodigo.Text) Then
      Begin
        If dbeCodigo.Enabled Then
        Begin
          If fCampoTabela('CAX_CODCAX', 'CADCAX', ['CAX_CODCAX', 'CAX_CODEMP'], [dbeCodigo.Text, edtCodEmpresa.Text]) = dbeCodigo.Text Then
          Begin
            fMensagem('ATENÇÃO', 'Esse caixa já está cadastrado para a empresa selecionada!', ['&Ok']);
            Result := False;
          End;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'O código do caixa deve ser preenchido!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodArm) And (pnlArmazem.Visible) Then
    Begin
      If Not fEmptyStr(edtCodArm.Text) Then
      Begin
        edtNomArm.Text := fRetNomeArmazemPorEmpresa(edtCodArm.Text, edtCodEmpresa.Text);
        If (fEmptyStr(edtNomArm.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Armazém não cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'O código do armazém deve ser informado!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadCaixas.pCarregaEmpresa;
begin
  edtDesEmpresa.Text := fCampoTabela('EMP_NOMEMP',
                                     'CADEMP',
                                     ['EMP_CODEMP'],
                                     [edtCodEmpresa.Text],
                                     False);
end;

procedure TfrmCadCaixas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CAX_CODCAX');
  stlCampos.Add('CAX_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CAX_DESCRI');
  stlCamInd.Add('CAX_CODCAX');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código Caixa');
end;

procedure TfrmCadCaixas.pLimparEdits;
begin
  edtDesEmpresa.Clear;
  edtNomArm.Clear;
end;

end.
