{***********************}
{* qryCadBco -> CADBCO *}
{********************RV*}
unit untCadBancos;

interface

uses
  Classes, Controls, Forms, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls,
  DBCtrls, DBEditFocus, Menus, AppEvnts, DB, Uni, BitBtnLockedIncrem, Mask,
  frxClass, frxExportCSVTestabilidade, dxScreenTip, cxClasses, dxCustomHint,
  cxHint, System.SysUtils, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  cxButtons, Vcl.FileCtrl, untDBECgcCpf, untLabelCgc;

type
  TfrmCadBancos = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodBco: TDBEditFocus;
    dbeNomBco: TDBEditFocus;
    Label2: TLabel;
    dbeProNum: TDBEditFocus;
    Label3: TLabel;
    pnlFundo: TPanel;
    dtsCadBco: TDataSource;
    lblProNu7: TLabel;
    dbeProNu7: TDBEditFocus;
    HintControler: TcxHintStyleController;
    Label4: TLabel;
    dbePathExt: TDBEditFocus;
    btnLocal: TBitBtnLocked;
    LabelCgc1: TLabelCgc;
    dbeNumCgc: TDBEditCgcCpf;
    
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure dbeProNumEnter(Sender: TObject);
    procedure dbeProNu7Enter(Sender: TObject);
    procedure dbeProNu7Exit(Sender: TObject);
    procedure dbeProNumExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnLocalClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
    qryCadBco: TUniQuery;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pAfterScrool(Dataset: TDataset);
    procedure pShowHint(edtEdit: TDBEditFocus; strTitulo: String);
    procedure pHideHint;
    procedure pAlteraHint(edtEdit: TDBEditFocus; blnSegundo: Boolean = False);
    function fTeveAlteracao: Boolean;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untFuncoesGenerica, untPai, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadBancos.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'CADBCO';
  strNomeCampo  := 'BCO_CODBCO';

  qryCadBco             := fCriaQuery(Self);
  qryTabela             := qryCadBco;
  dtsCadBco.DataSet     := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodBco;

  qryTabela.AfterOpen   := pAfterOpen;
  qryTabela.AfterScroll := pAfterScrool;

  lblProNu7.Visible := False;
  dbeProNu7.Visible := False;
  Self.Height := dbeCodBco.Height + dbeNomBco.Height + dbeNumCgc.Height + dbePathExt.Height + dbeProNum.Height + pnlBotoes.Height + pnlStatus.Height + 50;
end;

function TfrmCadBancos.fTeveAlteracao: Boolean;
  Var
    strSQL : String;
    qryBco : TUniQuery;
begin
  qryBco := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   BCO_PRONUM, ';
  strSQL := strSQL + '   BCO_PRONU7  ';
  strSQL := strSQL + ' FROM          ';
  strSQL := strSQL + '   CADBCO      ';
  strSQL := strSQL + ' WHERE         ';
  strSQL := strSQL + '   BCO_CODBCO = :CODBCO ';

  With qryBco Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBCO').AsString := dbeCodBco.Text;
    Open;
  End;

  Result := dbeProNum.Text <> qryBco.FieldByName('BCO_PRONUM').AsString;

  If dbeProNu7.Visible Then
    Result := Result Or (dbeProNu7.Text <> qryBco.FieldByName('BCO_PRONU7').AsString);

  FreeAndNil(qryBco);

end;

function TfrmCadBancos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CÓDIGO DO BANCO              *}
    {**************************************MV*}
    If (Sender = dbeCodBco) Then
    Begin
      If (fEmptyStr(dbeCodBco.Text)) And (dbeCodBco.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Banco deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;

    End

    {*****************************************}
    {* VALIDA O NOME DO BANCO                *}
    {**************************************MV*}
    Else If (Sender = dbeNomBco) Then
    Begin
      If fEmptyStr(dbeNomBco.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Nome do Banco deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O PROXIMO NÚMERO               *}
    {**************************************MV*}
    Else If (Sender = dbeProNum) Then
    Begin
      pHideHint;

      If fEmptyStr(dbeProNum.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Próximo Nosso Número deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (dbeProNum.Text) <= '0' Then
      Begin
        fMensagem('ATENÇÃO!', 'O Próximo Número deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;

      If Result Then
      Begin
        If dbeCodBco.Text = '748' Then
        Begin
          If Length(dbeProNum.Text) <> 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'O Próximo Nosso Número deve ter 5 caracteres!', ['&Ok']);
            Result := False;
          End;
        End
        Else If Pos(dbeCodBco.Text, '070_') > 0 Then
        Begin
          If Length(dbeProNum.Text) <> 6 Then
          Begin
            fMensagem('ATENÇÃO!', 'O Próximo Nosso Número deve ter 6 caracteres!', ['&Ok']);
            Result := False;
          End;
        End
        Else If Pos(dbeCodBco.Text, '756_033_004_089_') > 0 Then
        Begin
          If Length(dbeProNum.Text) <> 7 Then
          Begin
            fMensagem('ATENÇÃO!', 'O Próximo Nosso Número deve ter 7 caracteres!', ['&Ok']);
            Result := False;
          End;
        End
        Else If Pos(dbeCodBco.Text, '021_041_341_422_633_090_995_136_981_964_') > 0 Then
        Begin
          If Length(dbeProNum.Text) <> 8 Then
          Begin
            fMensagem('ATENÇÃO!', 'O Próximo Nosso Número deve ter 8 caracteres!', ['&Ok']);
            Result := False;
          End;
        End
        Else If dbeCodBco.Text = '085' Then
        Begin
          If Length(dbeProNum.Text) <> 9 Then
          Begin
            fMensagem('ATENÇÃO!', 'O Próximo Nosso Número deve ter 9 caracteres!', ['&Ok']);
            Result := False;
          End
        End
        Else If Pos(dbeCodBco.Text, '237_741_003_993_992_994_996_997_998_991_989_983_990_970_979_906_978_') > 0 Then
        Begin
          If Length(dbeProNum.Text) <> 11 Then
          Begin
            fMensagem('ATENÇÃO!', 'O Próximo Nosso Número deve ter 11 caracteres!', ['&Ok']);
            Result := False;
          End
        End
        Else If dbeCodBco.Text = '637' Then
        Begin
          If Length(dbeProNum.Text) <> 12 Then
          Begin
            fMensagem('ATENÇÃO!', 'O Próximo Nosso Número deve ter 12 caracteres!', ['&Ok']);
            Result := False;
          End
        End
        Else If Length(dbeProNum.Text) <> 10 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Próximo Nosso Número deve ter 10 caracteres!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeProNu7) And
            (dbeProNu7.Visible)  Then
    Begin
      pHideHint;

      If fEmptyStr(dbeProNu7.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O 2º Próximo Nosso Número deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (dbeProNu7.Text) <= '0' Then
      Begin
        fMensagem('ATENÇÃO!', 'O 2º Próximo Número deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;

      If Result Then
      Begin
        If dbeCodBco.Text = '748' Then
        Begin
          If Length(dbeProNu7.Text) <> 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'O 2º Próximo Nosso Número deve ter 5 caracteres!', ['&Ok']);
            Result := False;
          End;
        End
        Else If Pos(dbeCodBco.Text, '756_033_') > 0 Then
        Begin
          If Length(dbeProNu7.Text) <> 7 Then
          Begin
            fMensagem('ATENÇÃO!', 'O 2º Próximo Nosso Número deve ter 7 caracteres!', ['&Ok']);
            Result := False;
          End;
        End
        Else If Pos(dbeCodBco.Text, '021_041_341_422_633_090_995_136_981_964_') > 0 Then
        Begin
          If Length(dbeProNu7.Text) <> 8 Then
          Begin
            fMensagem('ATENÇÃO!', 'O 2º Próximo Nosso Número deve ter 8 caracteres!', ['&Ok']);
            Result := False;
          End;
        End
        Else If dbeCodBco.Text = '085' Then
        Begin
          If Length(dbeProNu7.Text) <> 9 Then
          Begin
            fMensagem('ATENÇÃO!', 'O 2º Próximo Nosso Número deve ter 9 caracteres!', ['&Ok']);
            Result := False;
          End
        End
        Else If Pos(dbeCodBco.Text, '237_741_003_993_992_994_996_997_998_991_989_983_990_970_979_906_978_') > 0 Then
        Begin
          If Length(dbeProNu7.Text) <> 11 Then
          Begin
            fMensagem('ATENÇÃO!', 'O 2º Próximo Nosso Número deve ter 11 caracteres!', ['&Ok']);
            Result := False;
          End
        End
        Else If Length(dbeProNu7.Text) <> 10 Then
        Begin
          fMensagem('ATENÇÃO!', 'O 2º Próximo Nosso Número deve ter 10 caracteres!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = dbeNumCgc) Then
    Begin
      If Not fEmptyStr(dbeNumCgc.Text) Then
      Begin
        If Not fTestaCgc(dbeNumCgc.Text) Then
        Begin
          fMensagem('ATENÇÃO', dbeNumCgc.Text + ' não é um número de CNPJ válido!', ['&Ok']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadBancos.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BCO_CODBCO');
  stlCampos.Add('BCO_NOMBCO');
  stlCampos.Add('BCO_C_G_C_');
  stlCampos.Add('BCO_PATEXT');
  stlCampos.Add('BCO_PRONUM');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('BCO_CODBCO');
  stlCamInd.Add('BCO_NOMBCO');

  stlDesInd.Add('Código');
  stlDesInd.Add('Nome');
end;

procedure TfrmCadBancos.pShowHint(edtEdit: TDBEditFocus; strTitulo: String);
begin
  HintControler.ShowHint(Self.Left + edtEdit.Left + edtEdit.Width,
  Self.Top + 27 + edtEdit.Top, strTitulo, edtEdit.Hint);
end;

procedure TfrmCadBancos.btnCancelaClick(Sender: TObject);
begin
  inherited;
  btnLocal.Enabled := False;
end;

procedure TfrmCadBancos.btnExcluirClick(Sender: TObject);
begin
  If Not qryTabela.IsEmpty Then
    pGravaLogBan(dbeCodBco.Text, dbeNomBco.Text, dbeProNum.Text, dbeProNu7.Text, False,True);

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadBancos.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  btnLocal.Enabled := False;
end;

procedure TfrmCadBancos.btnGravarClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If fValidacoesBotaoGravarPai Then
  Begin
    If fTeveAlteracao  Then
    Begin
      Try
        If qryTabela.State = dsEdit Then
        Begin
          pGravaLogBan(dbeCodBco.Text, dbeNomBco.Text, dbeProNum.Text, dbeProNu7.Text, False);
          inherited;
        End
        Else
        Begin
          inherited;
          pGravaLogBan(dbeCodBco.Text, dbeNomBco.Text, dbeProNum.Text, dbeProNu7.Text, True);
        End;
      Except
        On E: Exception Do
        Begin
          fRollBack;
          pMensagensErro(E.Message, '[untCadBancos.btnGravarClick]');
        End;
      End;
    End
    Else
      inherited;
  End;


  If blnGravou Then
    fCommit
  Else
    fRollBack;

  btnLocal.Enabled := False;
end;

procedure TfrmCadBancos.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodBco, dbeNomBco, False)
  Else
    pHabilitaCodigo(dbeCodBco, dbeCodBco, True);

  btnLocal.Enabled := True;
end;

procedure TfrmCadBancos.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrBancos: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE BANCOS     *}
  {****************************RV*}
  chrKey := '/';
  If fPesqBanco(Self, dbeCodBco, Nil, qryTabela, chrKey, arrBancos) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadBancos.btnSairClick(Sender: TObject);
begin
  inherited;
  btnLocal.Enabled := False;
end;

procedure TfrmCadBancos.btnLocalClick(Sender: TObject);
var
 strLocalDir: String;
begin
  inherited;
  SelectDirectory('', strLocalDir , strLocalDir, [sdNewUI, sdShowEdit], nil);
  qryTabela.FieldByName('BCO_PATEXT').AsString :=  strLocalDir;
end;

procedure TfrmCadBancos.dbeProNu7Enter(Sender: TObject);
begin
  inherited;
  pAlteraHint(dbeProNu7, True);
  pShowHint(dbeProNu7, 'Nosso Número Banco: ' + dbeCodBco.Text + '-' + dbeNomBco.Text);
end;

procedure TfrmCadBancos.dbeProNu7Exit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmCadBancos.dbeProNumEnter(Sender: TObject);
begin
  inherited;
  pAlteraHint(dbeProNum);
  pShowHint(dbeProNum, 'Nosso Número Banco: ' + dbeCodBco.Text + '-' + dbeNomBco.Text);
end;

procedure TfrmCadBancos.dbeProNumExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmCadBancos.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodBco, dbeNomBco, False);
  btnLocal.Enabled := True;
end;

procedure TfrmCadBancos.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

procedure TfrmCadBancos.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If Active Then
    Begin

      If FindField('BCO_C_G_C_') <> nil Then
        TStringField(FieldByName('BCO_C_G_C_')).EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_);
    End;
  End;
end;

procedure TfrmCadBancos.pAfterScrool(Dataset: TDataset);
Begin

  If Not qryTabela.Active Then
  Begin
    lblProNu7.Visible := False;
    dbeProNu7.Visible := False;
    Self.Height := dbeCodBco.Height + dbeNomBco.Height + dbeNumCgc.Height + dbePathExt.Height + dbeProNum.Height + pnlBotoes.Height + pnlStatus.Height + 50;
    Exit;
  End;

  If (qryTabela.FieldByName('BCO_CODBCO').AsString = '001') And (fCfgSis('NOSNUM', varString) = '2') Then
  Begin
    lblProNu7.Visible := True;
    dbeProNu7.Visible := True;
    Self.Height := dbeCodBco.Height + dbeNomBco.Height + dbeNumCgc.Height + dbePathExt.Height + dbeProNum.Height + dbeProNu7.Height + pnlBotoes.Height + pnlStatus.Height + 50;
  End
  Else If (qryTabela.FieldByName('BCO_CODBCO').AsString = '104') Or
          (qryTabela.FieldByName('BCO_CODBCO').AsString = '041') Or
          (qryTabela.FieldByName('BCO_CODBCO').AsString = '756') Or
          (qryTabela.FieldByName('BCO_CODBCO').AsString = '246') Or
          (qryTabela.FieldByName('BCO_CODBCO').AsString = '906') Then
  Begin
    lblProNu7.Visible := True;
    dbeProNu7.Visible := True;
    Self.Height := dbeCodBco.Height + dbeNomBco.Height + dbeNumCgc.Height + dbePathExt.Height + dbeProNum.Height + dbeProNu7.Height + pnlBotoes.Height + pnlStatus.Height + 40;
  End
  Else
  Begin
    lblProNu7.Visible := False;
    dbeProNu7.Visible := False;
    Self.Height := dbeCodBco.Height + dbeNomBco.Height + dbeNumCgc.Height + dbePathExt.Height + dbeProNum.Height + pnlBotoes.Height + pnlStatus.Height + 50;
  End;

End;

procedure TfrmCadBancos.pAlteraHint(edtEdit: TDBEditFocus; blnSegundo: Boolean = False);
  Var
    strNovoHint: String;
begin

  strNovoHint := 'O ' + IIF(blnSegundo, '2º ', '') + 'Próximo Nosso Número deve ter ';

  If dbeCodBco.Text = '748' Then
    strNovoHint := strNovoHint + '5 caracteres!'
  Else If Pos(dbeCodBco.Text, '756_033_004_089') > 0 Then
    strNovoHint := strNovoHint + '7 caracteres!'
  Else If Pos(dbeCodBco.Text, '070_') > 0 Then
    strNovoHint := strNovoHint + '6 caracteres!'
  Else If Pos(dbeCodBco.Text, '021_041_341_422_633_090_995_136_981_') > 0 Then
    strNovoHint := strNovoHint + '8 caracteres!'
  Else If dbeCodBco.Text = '085' Then
    strNovoHint := strNovoHint + '9 caracteres!'
  Else If Pos(dbeCodBco.Text, '237_741_003_993_992_994_996_997_998_991_989_983_990_970_979_906_978_') > 0 Then
    strNovoHint := strNovoHint + '11 caracteres!'
  Else If dbeCodBco.Text = '104' Then
    strNovoHint := strNovoHint + '10 caracteres!' + #13+#10 +
                   'Para as carteiras SICOB as duas primeiras posições'  + #13+#10 +
                   'devem ser 80, 81 ou 82.'
  Else If Pos(dbeCodBco.Text, '637') > 0 Then
    strNovoHint := strNovoHint + '12 caracteres!'
  Else
    strNovoHint := strNovoHint + '10 caracteres!';

  edtEdit.Hint := strNovoHint;

end;

procedure TfrmCadBancos.pHideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmCadBancos.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadBancos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  qryTabela.AfterScroll := Nil;
end;

end.

