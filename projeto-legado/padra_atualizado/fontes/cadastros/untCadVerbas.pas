unit untCadVerbas;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, QColorLabel, DBCtrls, DBEditFocus,
  untControlePagtoFunc, DB, BitBtnLockedIncrem, Mask, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxCheckBox,
  cxDBEdit, frxClass, frxExportCSVTestabilidade, SysUtils, EditFocus,
  untFramePlanoDeContasDBEditFocus,Uni,System.Variants;

type
  TfrmCadVerbas = class(TfrmPaiCad)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbeCodVer: TDBEditFocus;
    dbeDesVer: TDBEditFocus;
    dbeDebCre: TDBEditFocus;
    ColorLabel1: TColorLabel;
    dtsCadVer: TDataSource;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    dbEdtVerTes: TDBEditFocus;
    chkSalBas: TcxDBCheckBox;
    chkStatus: TDBCheckBox;
    pnlPlanoContas: TPanel;
    fraPlanoDeContas: TfraPlanoDeContasDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure chkSalBasKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodVerExit(Sender: TObject);
    procedure fraPlanoDeContasdbeCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasdbeCodCtaExit(Sender: TObject);
  private
    objCadVer: TCadVer;
    qryConCta: TUniQuery;
    procedure pCarregaCentroCusto;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure CarregarVerba(ACodVer:String);
    procedure pLimpa;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    LCodVer: String;
  end;


implementation

uses untFuncoesSimples, untPai, untConsultas, untTypesSistema,untCadCta, untPesqAux;

{$R *.dfm}

procedure TfrmCadVerbas.FormCreate(Sender: TObject);
begin
  inherited;
  objCadVer := TCadVer.Create(Self);

  inherited;
  strNomeTabela := 'CADVER';
  strNomeCampo  := 'VER_CODVER';
  qryTabela     := objCadVer.qryCadVer;
  qryTabela.AfterOpen   := pAfterOpen;
  qryConCta     := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);

  dtsCadVer.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodVer;
end;

procedure TfrmCadVerbas.fraPlanoDeContasdbeCodCtaExit(Sender: TObject);
begin
  inherited;
  fraPlanoDeContas.dbeCodCtaExit(Sender);

end;

procedure TfrmCadVerbas.fraPlanoDeContasdbeCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
  strMask        : String;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If Key = '/' Then
  Begin
    strMask := dtsCadVer.DataSet.FieldByName('VER_CODCTA').EditMask;
    dtsCadVer.DataSet.FieldByName('VER_CODCTA').EditMask := '';
    If fPesqCentroCusto(Self, fraPlanoDeContas.dbeCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
    Begin
      If (fValidaCampos(fraPlanoDeContas.dbeCodCta, True)) Then
        Self.SelectNext(ActiveControl, True, True);
      pCarregaCentroCusto;
    End;
    dtsCadVer.DataSet.FieldByName('VER_CODCTA').EditMask := strMask;
  End;
end;

function TfrmCadVerbas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    {*******************************}
    {* VALIDA A DESCRIÇÃO DA VERBA *}
    {****************************PZ*}
    If (Sender = dbeDesVer) Then
    Begin
      If (fEmptyStr(dbeDesVer.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','A Descrição deve ser preenchida!',['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCodVer) Then
    Begin
      If (dbeCodVer.Enabled) And (fEmptyStr(dbeCodVer.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','O código deve ser preenchido!',['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = fraPlanoDeContas.dbeCodCta) And (pnlPlanoContas.Visible) Then
    Begin
      If fEmptyStr(fraPlanoDeContas.dbeCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas deve deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.dbeCodCta.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Linha / Grupo não é permitido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaCentroCusto;
        If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;

      if not Result then
      begin
        fraPlanoDeContas.dbeCodCta.Field.Value := Null;
        fraPlanoDeContas.edtDesCta.Clear;
      end;

    End

    {************************************************}
    {* VALIDA O TIPO DA VERBA.(D)ÉBITO OU (C)RÉDITO *}
    {*********************************************PZ*}
    Else If (Sender = dbeDebCre) Then
    Begin
      If (Pos(dbeDebCre.Text,'D_C_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!','O Tipo deve ser D ou C!',['&O k']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;


procedure TfrmCadVerbas.pAfterOpen(DataSet: TDataSet);
begin
  If DataSet.FindField('VER_CODCTA') <> nil Then
    TStringField(DataSet.FieldByName('VER_CODCTA')).EditMask := '99.99.999;0;_';
end;

procedure TfrmCadVerbas.pCarregaCentroCusto;
begin
  fraPlanoDeContas.edtDesCta.Text := '';
  If not fEmptyStr(fraPlanoDeContas.dbeCodCta.Text) Then
  begin
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.dbeCodCta.Text);
    fraPlanoDeContas.edtDesCta.Text := qryConCta.FieldByName('CTA_DESCTA').AsString;
  end;
end;


procedure TfrmCadVerbas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('VER_CODVER');
  stlCampos.Add('VER_DESVER');
  stlCampos.Add('VER_DEBCRE');
  stlCampos.Add('VER_DEBCRE');
  stlCampos.Add('VER_CODTES');
  stlCampos.Add('VER_CODCTA');
  stlCampos.Add('VER_SALBAS');
  stlCampos.Add('VER_STATUS');

  stlCamInd.Add('VER_DESVER');
  stlCamInd.Add('VER_CODVER');
  stlCamInd.Add('VER_DEBCRE+VER_DESVER');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
  stlDesInd.Add('Crédito_Débito / Descrição');
end;

procedure TfrmCadVerbas.pLimpa;
begin
  dbeCodVer.Clear;
  dbeDesVer.Clear;
  dbeDebCre.Clear;
  dbEdtVerTes.Clear;
end;

procedure TfrmCadVerbas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pLimpa;
  If qryTabela.State = dsInsert Then
    chkSalBas.Enabled := True;
    chkStatus.Enabled := True;
    chkStatus.Checked  := True;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodVer, dbeDesVer, False)
  Else
    pHabilitaCodigo(dbeCodVer, dbeCodVer, True);
end;

procedure TfrmCadVerbas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  If (dbeCodVer.Text = '001') Then
  Begin
    {fMensagem('ATENÇÃO!','Alteração não permitida para essa Verba!',['&O k']);
    Exit;}
    dbeCodVer.Enabled := False;
    dbeDesVer.Enabled := False;
    dbeDebCre.Enabled := False;
    chkSalBas.Enabled := False;
    chkStatus.Enabled := False;
  End;

  dbeCodVer.Enabled := False;

  If qryTabela.State = dsEdit Then
    chkSalBas.Enabled := True;

  If dbeDesVer.Enabled Then
    pSetFocus(dbeDesVer);
end;

procedure TfrmCadVerbas.FormShow(Sender: TObject);
begin
  inherited;
  {******************************************}
  {* IRÁ GRAVAR A VERBA 001 - SALARIO BASE, *}
  {* CASO ELA NÃO ESTEJA CADASTRADA.        *}
  {***************************************PZ*}
  objCadVer.fGravaVerbaSalBase;
  pnlPlanoContas.Visible := (fCfgSis('DESPFU', varBoolean));

  If Not fEmptyStr(LCodVer) Then
    CarregarVerba(LCodVer);
end;

procedure TfrmCadVerbas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  chkSalBas.Enabled := False;
  chkStatus.Enabled := False;
end;

procedure TfrmCadVerbas.btnExcluirClick(Sender: TObject);
begin
  {************************************************}
  {* NÃO PERMITE EXCLUIR A VERBA 001-SALARIO BASE.*}
  {*********************************************PZ*}
  If (dbeCodVer.Text = '001') Then
  Begin
    fMensagem('ATENÇÃO!','Exclusão não permitida para essa Verba!',['&O k']);
    Exit;
  End;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadVerbas.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  chkSalBas.Enabled := False;
end;

procedure TfrmCadVerbas.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadVerbas.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;


  chkSalBas.Enabled := False;
  chkStatus.Enabled := False;
end;

procedure TfrmCadVerbas.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrVerbas: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE VERBAS     *}
  {****************************RV*}
  chrKey := '/';
  If fPesqVerbas(Self, Nil, Nil, qryTabela, chrKey, arrVerbas) Then
    Begin
    chkSalBas.Enabled := False;
    chkStatus.Enabled := False;
    pCarregaCentroCusto;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadVerbas.CarregarVerba(ACodVer: String);
begin

  Try
    dbeCodVer.Text := ACodVer;
    If fBuscaPorCamposChave Then
    Begin
      btnAlterar.Click;
      pSetFocus(fraPlanoDeContas.dbeCodCta);
    End;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TfrmCadVerbas.chkSalBasKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  inherited;
  if Key = #13 Then
     pSetFocus(dbEdtVerTes);
end;


procedure TfrmCadVerbas.dbeCodVerExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(dbeCodVer.Text) Then
    dbeCodVer.Text := fStrZero(dbeCodVer.Text,3);
end;

end.
