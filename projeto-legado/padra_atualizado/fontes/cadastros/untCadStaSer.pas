unit untCadStaSer;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, StdCtrls, DBCtrls, DBEditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls,  DB, Uni,
  BitBtnLockedIncrem, Mask, frxClass, frxExportCSVTestabilidade, SysUtils;

type
  TfrmCadStaSer = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    chkFinali: TDBCheckBox;
    chkSelFat: TDBCheckBox;
    chkNotCli: TDBCheckBox;
    pnlNotCli: TPanel;
    lblMsgCli: TLabel;
    mmoMsgCli: TDBMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure chkNotCliClick(Sender: TObject);
  private
    qryStaSer: TUniQuery;
    dtsDados: TDataSource;

    procedure pAjustaMsgCli;
    { Private declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses untPai, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadStaSer.FormCreate(Sender: TObject);
  Var
    intCont: Integer;
begin
  inherited;

  strNomeTabela := 'STASER';
  strNomeCampo  := 'STS_CODIGO';
  qryStaSer      := fCriarQuery('SELECT * FROM STASER', Self);

  qryStaSer.FieldByName('STS_CODIGO').DisplayLabel := 'Código';
  qryStaSer.FieldbyName('STS_DESCRI').DisplayLabel := 'Descrição';
  qryStaSer.FieldByName('AUTOINCREM').Visible := False;

  dtsDados  := fCriaDataSource(qryStaSer);
  qryTabela := qryStaSer;

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
      (Components[intCont] as TDBEdit).DataSource := dtsDados
    Else If (Components[intCont] is TDBCheckBox) Then
      (Components[intCont] as TDBCheckBox).DataSource := dtsDados
    Else If (Components[intCont] is TDBMemo) Then
      (Components[intCont] as TDBMemo).DataSource := dtsDados;
  End;

  chkFinali.DataSource := dtsDados;
  chkSelFat.DataSource := dtsDados;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;


function TfrmCadStaSer.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

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

    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadStaSer.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('STS_CODIGO');
  stlCampos.Add('STS_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('STS_DESCRI');
  stlCamInd.Add('STS_CODIGO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadStaSer.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  chkNotCli.Checked := False;
  pAjustaMsgCli;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadStaSer.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadStaSer.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadStaSer.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadStaSer.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadStaSer.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  qryTabela.FieldByName('STS_FINALI').AsString := 'N';
  qryTabela.FieldByName('STS_SELFAT').AsString := 'S';  

  chkNotCli.Checked := False;
  pAjustaMsgCli;
end;

procedure TfrmCadStaSer.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrCor: TConsultasArray;
begin
  chrKey := '/';
  If fPesqStatusServico(Self, Nil, Nil, qryTabela, chrKey, arrCor) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadStaSer.chkNotCliClick(Sender: TObject);
begin
  inherited;
  pAjustaMsgCli;
end;

procedure TfrmCadStaSer.pAjustaMsgCli;
begin
  if chkNotCli.Checked then
  begin
    Self.Height := 296;
    pnlNotCli.Visible := True;
  end
  else
  begin
    mmoMsgCli.Clear;
    pnlNotCli.Visible := False;
    Self.Height := 183;
  end;
end;

procedure TfrmCadStaSer.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

end.
