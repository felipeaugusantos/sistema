unit untCadPos;

interface

uses
  Classes, Controls, Forms, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls,
  Mask, DBCtrls, DBEditFocus, Menus, AppEvnts, Uni, DB, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, EditFocus, SysUtils;

type
  TfrmCadPos = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodPos: TDBEditFocus;
    Label2: TLabel;
    dbeDesPos: TDBEditFocus;
    pnlFundo: TPanel;
    dtsTabela: TDataSource;
    Label3: TLabel;
    dbeSerPos: TDBEditFocus;
    Label4: TLabel;
    dbeEstabe: TDBEditFocus;
    Label5: TLabel;
    dbeCodAdq: TDBEditFocus;
    edtNomAdq: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dbeCodAdqKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;


implementation

uses untFuncoesSimples, untPai, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadPos }

function TfrmCadPos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeCodPos) Then
    Begin
      If (fEmptyStr(dbeCodPos.Text)) And (dbeCodPos.Enabled) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Código do POS deve ser preenchido!', ['&Ok']);
      End
      {*****************************************}
      {* VERIFICA SE EXISTE O CODIGO INFORMADO *}
      {* CASO EXISTA TRAZ PARA EDICAO          *}
      {**************************************WI*}
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDesPos) Then
    Begin
      If fEmptyStr(dbeDesPos.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A Descrição do POS deve ser preenchido!', ['&Ok']);
      End;
    End

    Else If (Sender = dbeSerPos) Then
    Begin
      If fEmptyStr(dbeSerPos.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Número Serial do POS deve ser preenchido!', ['&Ok']);
      End;
    End

    Else If (Sender = dbeEstabe) Then
    Begin
      If fEmptyStr(dbeEstabe.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Estabelecimento deve ser preenchido!', ['&Ok']);
      End
      Else If (Length(fRetSomenteNumeros(dbeEstabe.Text))) <> (Length(dbeEstabe.Text)) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Estabelecimento deve conter apenas números!', ['&Ok']);
      End;
    End

    Else If (Sender = dbeCodAdq) Then
    Begin
      If fEmptyStr(dbeCodAdq.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Adquirente deve ser preenchido!', ['&OK']);
      End
      Else
      Begin
        edtNomAdq.Text := fCampoTabela('ADQ_NOMADQ', 'CADADQ', ['ADQ_CODADQ'], [dbeCodAdq.Text]);

        If fEmptyStr(edtNomAdq.Text) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!', 'O Adquirente informado não foi encontrado!', ['&OK']);
        End;
      End;
    End
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadPos.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('POS_CODPOS');
  stlCampos.Add('POS_DESPOS');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('POS_DESPOS');
  stlCamInd.Add('POS_CODPOS');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadPos.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadPos.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADPOS';
  strNomeCampo      := 'POS_CODPOS';
  qryTabela         := fCriaQuery(Self);
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1 );
  arrCamposChave[0] := dbeCodPos;
end;

procedure TfrmCadPos.btnCancelaClick(Sender: TObject);
begin
  inherited;
  if dbeCodAdq.Text = '' then
    edtNomAdq.Clear;
end;

procedure TfrmCadPos.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadPos.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  if dbeCodAdq.Text = '' then
    edtNomAdq.Clear;
end;

procedure TfrmCadPos.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadPos.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadPos.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodPos, dbeDesPos, False)
  Else
    pHabilitaCodigo(dbeCodPos, dbeCodPos, True);
  edtNomAdq.Enabled := False;
  edtNomAdq.Clear;
end;

procedure TfrmCadPos.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodPos, dbeDesPos, False);
  edtNomAdq.Enabled := False;
end;

procedure TfrmCadPos.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
  edtNomAdq.Enabled := False;
  edtNomAdq.Clear;
end;

procedure TfrmCadPos.btnPesquisaClick(Sender: TObject);
  Var
    arrPos : TConsultasArray;
    chrKey : Char;
begin
  chrKey := '/';
  If fPesqPos(Self, Nil, Nil, qryTabela, chrKey, arrPos) Then
  Begin
    edtNomAdq.Text := fCampoTabela('ADQ_NOMADQ', 'CADADQ', ['ADQ_CODADQ'], [dbeCodAdq.Text]);
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadPos.dbeCodAdqKeyPress(Sender: TObject; var Key: Char);
  Var
    arrAdq : TConsultasArray;
begin
  If fPesqAdquirente(Self, dbeCodAdq, edtNomAdq, Nil, Key, arrAdq) Then
  Begin
    If fValidaCampos(dbeCodAdq, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.

