unit untCadUnidades;

interface

uses
  Classes, Controls, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls,
  DBCtrls, DBEditFocus, Menus, QColorLabel, AppEvnts, Uni, DB, BitBtnLockedIncrem,
  Mask, frxClass, frxExportCSVTestabilidade, EditFocus, SysUtils;

type
  TfrmCadUnidades = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeDesUni: TDBEditFocus;
    dbePesLit: TDBEditFocus;
    Label3: TLabel;
    pnlFundo: TPanel;
    Label4: TLabel;
    dbeIteFra: TDBEditFocus;
    ColorLabel1: TColorLabel;
    Label5: TLabel;
    dbeSigUni: TDBEditFocus;
    dtsCadUni: TDataSource;
    chkMetFat: TDBCheckBox;
    lblDesRed: TLabel;
    dbeDesRed: TDBEditFocus;
    lblDesEti: TLabel;
    dbeDesEti: TDBEditFocus;
    Label6: TLabel;
    dbeKilLit: TDBEditFocus;
    ColorLabel2: TColorLabel;
    chkPeApBe: TDBCheckBox;
    pnlUniMedGS1: TPanel;
    lblUniGs1: TLabel;
    dbeCodUniGs1: TDBEditFocus;
    edtDesUniGs1: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dbeCodUniGs1KeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure pDescricaoResumidaUnidadeVisiveis;
  protected
    qryCadUni: TUniQuery;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

implementation

uses Forms, untPai, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadUnidades.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadUnidades.FormCreate(Sender: TObject);
  var
    strSQL: String;
begin
  inherited;
  strNomeTabela     := 'CADUNI';
  strNomeCampo      := 'UNI_CODUNI';

  strSQL            := 'SELECT * FROM CADUNI';
  qryCadUni         := fCriarQuery(strSQL, Self);
  qryTabela         := qryCadUni;
  dtsCadUni.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  If (Not fCfgSis('VENMAD', varBoolean)) And
     (Not fCfgSis('VENVID', varBoolean)) And
     (Not fCfgSis('VENMTL', varBoolean)) Then
  Begin
    chkMetFat.Visible := False;
    chkPeApBe.Visible := False;
    Self.ClientHeight := Self.ClientHeight - chkMetFat.Height;
  End;

  pDescricaoResumidaUnidadeVisiveis;
end;

procedure TfrmCadUnidades.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadUnidades.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadUnidades.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadUnidades.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadUnidades.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
  chkMetFat.Checked := False;
  chkPeApBe.Checked := False;
end;

procedure TfrmCadUnidades.btnPesquisaClick(Sender: TObject);
var
  chrKey: Char;
  arrUnidades: TConsultasArray;
begin
//  inherited;

  {*****************************}
  {* NOVA CONSULTA DE UNIDADES *}
  {**************************AC*}
  chrKey := '/';
  if fPesqUnidade(Self, Nil, Nil, Nil, qryTabela, chrKey, arrUnidades) then
  begin
    pSetFocus(btnAlterar);
  end;

end;

procedure TfrmCadUnidades.dbeCodUniGs1KeyPress(Sender: TObject; var Key: Char);
Var
  arrUniGs1 : TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE UNIDADES GS1 *}
  {******************************AC*}
  If fPesqUnidadesGS1(Self, dbeCodUniGs1, edtDesUniGs1, Nil, Key, arrUniGs1) Then
  Begin
    If fValidaCampos(dbeCodUniGs1, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadUnidades.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDesUni, False);
end;

function TfrmCadUnidades.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CODIGO DA UNIDADE            *}
    {**************************************MV*}
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Unidade deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (Length(dbeCodigo.Text) = 1) Or (Length(dbeCodigo.Text) = 3) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Unidade deve conter exatamente 2 ou 4 caracteres!', ['&Ok']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    {*****************************************}
    {* VALIDA A DESCRIÇÃO DA UNIDADE         *}
    {**************************************MV*}
    Else If (Sender = dbeDesUni) Then
    Begin
      If fEmptyStr(dbeDesUni.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição da Unidade deve ser preenchida!', ['&Ok']);
        Result := False;
      End
    End

    {**********************************}
    {* VALIDA O FRACIONAMENTO         *}
    {*******************************MV*}
    Else If (Sender = dbeIteFra) Then
    Begin
      If Pos(dbeIteFra.Text,'S_N_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Item Frac. deve ser S ou N!', ['&Ok']);
        Result := False;
      End
    End

    {*************************************}
    {* VALIDA A SIGLA DA UNIDADE         *}
    {**********************************CI*}
    Else If (Sender = dbeSigUni) Then
    Begin
      If fEmptyStr(dbeSigUni.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Sigla da Unidade deve ser preenchida!', ['&Ok']);
        Result := False;
      End
    End

    {*************************************}
    {* VALIDA KILO/LITRO                 *}
    {**********************************AC*}
    Else If (Sender = dbeKilLit) Then
    Begin
      If (Pos('K',dbeKilLit.Text) <= 0) And (Pos('L',dbeKilLit.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo Kilo/Litro deve ser preenchido com K ou L!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCodUniGS1) And pnlUniMedGs1.Visible Then
    Begin
      If fEmptyStr(dbeCodUniGS1.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Unidade de medida GS1 deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtDesUniGs1.Text := fRetNomUnidadeGS1(dbeCodUniGS1.Text);
        If fEmptyStr(edtDesUniGs1.Text)  Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Unidade de medida GS1 não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadUnidades.pDescricaoResumidaUnidadeVisiveis;
begin
  // utiliza modulo industrial
  dbeDesRed.Visible := fCfgSis('UTIIND', varBoolean);
  lblDesRed.Visible := dbeDesRed.Visible;
  dbeDesEti.Visible := dbeDesRed.Visible;
  lblDesEti.Visible := dbeDesRed.Visible;
  if not dbeDesRed.Visible then
    Self.ClientHeight := Self.ClientHeight - (dbeDesRed.Height + dbeDesEti.Height)
  else
    Self.ClientHeight := 199;
end;

procedure TfrmCadUnidades.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('UNI_CODUNI');
  stlCampos.Add('UNI_DESUNI');
  stlCampos.Add('UNI_PESLIT');
  stlCampos.Add('UNI_ITEFRA');
  stlCampos.Add('UNI_SIGUNI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('UNI_DESUNI');
  stlCamInd.Add('UNI_CODUNI');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadUnidades.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  pnlUniMedGS1.Visible := fCfgSis('GS1CNP', varBoolean);

  If (pnlUniMedGS1.Visible) Then
    Self.ClientHeight := Self.ClientHeight + pnlUniMedGS1.Height;
end;

end.

