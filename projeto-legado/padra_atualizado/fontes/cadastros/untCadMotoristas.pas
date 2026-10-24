unit untCadMotoristas;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, DBCtrls, DBEditFocus, AppEvnts, DB, EditFocus, QColorLabel,
  BitBtnLockedIncrem, Mask, frxClass, frxExportCSVTestabilidade, SysUtils, Uni, strUtils,
  Variants, Vcl.CheckLst, ComboBoxFocus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxImage, Vcl.Graphics, untTypesSistema,
  untRomaneioTarefasFusion;

type
  TOpcSelecao = (opcMarcar, opcDesmarcar, opcInverter);

  TfrmCadMotoristas = class(TfrmPaiCad)
    dtsCadMot: TDataSource;
    tbsAcessoEmp: TTabSheet;
    lblInfo: TLabel;
    gpbEmpresaAcesso: TGroupBox;
    lblclbEmpresa: TLabel;
    clbEmpresa: TCheckListBox;
    popOpSele: TPopupMenu;
    MarcarTodos1: TMenuItem;
    DesmarcarTodos1: TMenuItem;
    N1: TMenuItem;
    InverterSeleo1: TMenuItem;
    gpbAppEntrega: TGroupBox;
    pnlAppEntrega: TPanel;
    lblLogin: TLabel;
    lblLatLon: TLabel;
    lblTipMot: TLabel;
    edtLogin: TEditFocus;
    dbeLatLon: TDBEditFocus;
    cmbTipMot: TComboBoxFocus;
    pnlCadPadrao: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    lbl1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    lblPerFre: TLabel;
    dbeNomMot: TDBEditFocus;
    dbeCodMot: TDBEditFocus;
    dbeStatus: TDBEditFocus;
    dbeCpfMot: TDBEditFocus;
    pnlCodBar: TPanel;
    Label4: TLabel;
    dbeCodBar: TDBEditFocus;
    dbePlaVei: TDBEditFocus;
    edtDesVei: TEditFocus;
    dbePerFre: TDBEditFocus;
    lbl2: TColorLabel;
    pnlSenha: TPanel;
    lblSenha: TLabel;
    lblConSenha: TLabel;
    edtSenha: TEditFocus;
    edtConSenha: TEditFocus;
    dbeMonMot: TDBEditFocus;
    lblMonMot: TLabel;
    ColorLabel1: TColorLabel;
    Label6: TLabel;
    dbeGerRom: TDBEditFocus;
    ColorLabel2: TColorLabel;
    imgFotMot: TcxImage;
    pnlLicenca: TPanel;
    Label7: TLabel;
    cmbLicenca: TComboBoxFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbeStatusEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbePlaVeiKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtLoginChange(Sender: TObject);
    procedure lblclbEmpresaClick(Sender: TObject);
    procedure MarcarTodos1Click(Sender: TObject);
    procedure DesmarcarTodos1Click(Sender: TObject);
    procedure InverterSeleo1Click(Sender: TObject);
    procedure dbeMonMotEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmbLicencaClick(Sender: TObject);
  private
    { Private declarations }
    strTipEntSen: String;
    clbSelecionado: TCheckListBox;
    objRomFusTarefas: TRomaneioTarefasFusion;

    procedure pRetSenha;
    procedure pRetDadosAppEntrega;
    procedure pSetaMascara;
    procedure pLimpaCampos;
    procedure pCarregaDados;
    function fValidaCodBarra(strCodBar, strCodMot: String): Boolean;
    Function fRetEmpresasSel(clbEmpresa: TCheckListBox): String;
    procedure pAtualizaLstEmpresa(strNomCam: String; clbEmpresa: TCheckListBox);
    procedure pCarregaLstEmpresa;
    procedure pSetaCheckList(CheckListBox : TCheckListBox);
    procedure pAbrirPoup;
    procedure pExecutarSelecao(Opcao: TOpcSelecao);
    procedure pMarcaDesmarca(Opcao: Boolean);
    procedure pInverteSelecao;

    procedure pPesquisa(strCodMotorista: String = '');
    function fSetaMotoristaInformado(strCodMotorista: String = ''): Boolean;
    function validaLicencaDisponível(strTipoLicenca: String; var licencas: TStringArray): Boolean;
    function validaRomaneiosPendentes(var strRomaneios: String): Boolean;
    function utilizaAppEntrega(): Boolean;
    procedure pCarregaRegistroAntesAlteracao;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strCodMotoristaIniciarCadastro: String;
  end;


implementation

uses untPai, untFuncoes, untFuncoesSimples, untConsultas, untPesqAux,
  untImagemBase64;

{$R *.dfm}

procedure TfrmCadMotoristas.FormCreate(Sender: TObject);
begin
  inherited;
  strCodMotoristaIniciarCadastro := '';
  strNomeTabela     := 'CADMOT';
  strNomeCampo      := 'MOT_CODMOT';
  qryTabela         := fCriarQuery('SELECT * FROM CADMOT', Self);
  dtsCadMot.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodMot;

  strTipEntSen := IIF((fCfgSis('TIPENT', VarString) = 'S') Or (fCfgSis('TIPEBX', VarString) = 'S') Or (fCfgSis('MATDIS', VarString) = 'S') , 'S', 'C');
  pnlCodBar.Visible := (fCfgSis('TIPENT', VarString) = 'B') Or (fCfgSis('TIPEBX', VarString) = 'B');

  If (strTipEntSen <> 'S') Then
    pnlSenha.Visible    := False;

  if not fCfgSis('PMOTFR', varBoolean) then
  begin
    lblPerFre.Visible := False;
    dbePerFre.Visible := False;
  end;

  Self.Height := 250;
  if not fCfgSis('MATDIS', varBoolean) then
  begin
    imgFotMot.Visible := False;
    Self.Width := 625;
    gpbAppEntrega.Visible := False;
    gpbEmpresaAcesso.Visible := False;
  end
  else
  begin
    pnlSenha.Parent := gpbAppEntrega;
    pnlSenha.TabOrder := 1;
    pnlAppEntrega.Align := alBottom;
    pnlAppEntrega.TabOrder := 2;
    Self.Height := 350;
  end;

  cmbLicenca.OnClick(Self);

  objRomFusTarefas := TRomaneioTarefasFusion.Create(Self);
end;

procedure TfrmCadMotoristas.FormDestroy(Sender: TObject);
begin
  inherited;

  if Assigned(objRomFusTarefas) then
    FreeAndNil(objRomFusTarefas);
end;

procedure TfrmCadMotoristas.FormShow(Sender: TObject);
begin
  inherited;
  pSetaMascara;

  If Not fEmptyStr(strCodMotoristaIniciarCadastro) Then
    Self.pPesquisa(strCodMotoristaIniciarCadastro);

  pCarregaLstEmpresa;
end;

procedure TfrmCadMotoristas.pSetaMascara;
begin
  qryTabela.FieldByName('MOT_CPFMOT').EditMask := '999.999.999-99;0;';
  qryTabela.FieldByName('MOT_PLAVEI').EditMask :=  'aaa-9a99;0;_';
end;

function TfrmCadMotoristas.utilizaAppEntrega: Boolean;
begin
  Result := (edtLogin.Text <> '')
    and (edtSenha.Text <> '')
    and (fRetEmpresasSel(clbEmpresa) <> '');
end;

function TfrmCadMotoristas.validaLicencaDisponível(
  strTipoLicenca: String; var licencas: TStringArray): Boolean;
Var
  qryGen: TUniQuery;
  intMaxLic, intIdx: Integer;
Begin
  qryGen := fCriaQuery;
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT * FROM APPLIC');
    qryGen.Open;

    intMaxLic := 0;
    if strTipoLicenca = 'C' then
      intMaxLic := qryGen.FieldByName('APL_CONCAR').AsInteger;
    if strTipoLicenca = 'M' then
      intMaxLic := qryGen.FieldByName('APL_CONMOT').AsInteger;

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT MOT_NOMMOT');
    qryGen.SQL.Add('FROM CADMOT');
    qryGen.SQL.Add('WHERE MOT_TIPLIC = ' + QuotedStr(strTipoLicenca));
    qryGen.SQL.Add('AND MOT_CODMOT <> ' + QuotedStr(qryTabela.FieldByName('MOT_CODMOT').AsString));
    qryGen.Open;

    if qryGen.RecordCount < intMaxLic then
    begin
      Result := true;
      Exit;
    end;

    SetLength(licencas, qryGen.RecordCount);
    qryGen.First;
    intIdx := 0;
    while not qryGen.Eof do
    begin
      licencas[intIdx] := fPadR(IntToStr(intIdx + 1), 10) + qryGen.FieldByName('MOT_NOMMOT').AsString;
      qryGen.Next;
      inc(intIdx);
    end;

    Result := false;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmCadMotoristas.validaRomaneiosPendentes(
  var strRomaneios: String): Boolean;
Var
  qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT');
    qryGen.SQL.Add('  GER_NUMROM, ');
    qryGen.SQL.Add('  GER_EMPROM  ');
    qryGen.SQL.Add('FROM ROMGERX  ');
    qryGen.SQL.Add('WHERE GER_CODMOT = ' + QuotedStr(qryTabela.FieldByName('MOT_CODMOT').AsString));
    qryGen.SQL.Add('  AND GER_STATUS = "A"           ');
    qryGen.SQL.Add('  AND GER_LIBAPP = "S"           ');
    qryGen.SQL.Add('  AND GER_CEPENT IS NOT NULL     ');
    qryGen.SQL.Add('  AND COALESCE(GER_ENTREG, 0) = 0');
    qryGen.SQL.Add('GROUP BY GER_NUMROM,');
    qryGen.SQL.Add('  GER_EMPROM        ');
    qryGen.Open;

    if qryGen.IsEmpty then
    begin
      Result := true;
      Exit;
    end;

    qryGen.First;
    strRomaneios := '';
    while not qryGen.Eof do
    begin
      if strRomaneios <> '' then
        strRomaneios := strRomaneios + ' / ';
      strRomaneios := strRomaneios + qryGen.FieldByName('GER_NUMROM').AsString + '-' + qryGen.FieldByName('GER_EMPROM').AsString;
      qryGen.Next;
    end;

    Result := false;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadMotoristas.pCarregaLstEmpresa;
Var
  qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT CONCAT(EMP_CODEMP," - ", EMP_NOMEMP) AS EMPNOM FROM CADEMP');
    qryGen.Open;

    clbEmpresa.Items.Clear;
    qryGen.First;
    While Not qryGen.Eof Do
    Begin
      clbEmpresa.Items.Add(qryGen.FieldByName('EMPNOM').AsString);
      qryGen.Next;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;

procedure TfrmCadMotoristas.pCarregaRegistroAntesAlteracao;
begin
  objRomFusTarefas.pClearDataSets;
  objRomFusTarefas.pLogAdd('CADMOT', ['MOT_CODMOT'], 'MOT_CODMOT = ' + QuotedStr(qryTabela.FieldByName('MOT_CODMOT').AsString));
end;

Function TfrmCadMotoristas.fRetEmpresasSel(clbEmpresa: TCheckListBox): String;
  Var
    intContador : Integer;
Begin
  Result := '';
  For intContador := 0 To clbEmpresa.Items.Count -1 Do
  Begin
    If clbEmpresa.Checked[intContador] Then
      Result := Result + LeftStr(clbEmpresa.Items[intContador],3) + '_';
  End;
End;

procedure TfrmCadMotoristas.pAtualizaLstEmpresa(strNomCam: String; clbEmpresa: TCheckListBox);
  Var
    intContador: Integer;
    intFocus   : Integer;

    strEmpSel: String;
begin
  {******************************************}
  {* SELECIONA A EMPRESA CADASTRADA NO ITEM *}
  {***************************************LU*}
  intFocus := -1;
  strEmpSel := qryTabela.fieldbyname(strNomCam).AsString;

  For intContador := 0 To clbEmpresa.Items.Count -1 Do
  Begin
    If (Pos(LeftStr(clbEmpresa.Items[intContador],3), strEmpSel) > 0) Then
    Begin
      If intFocus = -1 Then
        intFocus := intContador;
      clbEmpresa.Checked[intContador] := True;
    End
    Else
      clbEmpresa.Checked[intContador] := False;
  End;
  clbEmpresa.ItemIndex := intFocus;
end;

function TfrmCadMotoristas.fValidaCodBarra(strCodBar, strCodMot: String): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  Try

    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  *    ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADMOT ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  MOT_CODBAR =  :CODBAR AND ';
    strSQL := strSQL + '  MOT_CODMOT <> :CODMOT     ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBAR').AsString := strCodBar;
      ParamByName('CODMOT').AsString := strCodMot;
      Open;

      Result := IsEmpty;

      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;

procedure TfrmCadMotoristas.pExecutarSelecao(Opcao: TOpcSelecao);
begin
  case Opcao of
    opcMarcar:    pMarcaDesmarca(True);
    opcDesmarcar: pMarcaDesmarca(False);
    opcInverter:  pInverteSelecao;
  End;
end;

procedure TfrmCadMotoristas.pMarcaDesmarca(Opcao: Boolean);
var
  intCount: Integer;
begin
  If Assigned(clbSelecionado) Then
  Begin
    for intCount := 0 to clbSelecionado.Items.Count - 1 do
      clbSelecionado.Checked [intCount] := Opcao;
  End;
end;

procedure TfrmCadMotoristas.pInverteSelecao;
var
  intCount: Integer;
begin
  If Assigned(clbSelecionado) Then
  Begin
    For intCount := 0 to clbSelecionado.Items.Count - 1 Do
    Begin
      If clbSelecionado.Checked [intCount] = True then
        clbSelecionado.Checked [intCount] := False
      Else
        clbSelecionado.Checked [intCount] := True;
    End;
  End;
end;

procedure TfrmCadMotoristas.InverterSeleo1Click(Sender: TObject);
begin
  inherited;
  pExecutarSelecao(opcInverter);
end;

procedure TfrmCadMotoristas.lblclbEmpresaClick(Sender: TObject);
begin
  inherited;
  pSetaCheckList(clbEmpresa);
  pAbrirPoup;
end;

procedure TfrmCadMotoristas.MarcarTodos1Click(Sender: TObject);
begin
  inherited;
  pExecutarSelecao(opcMarcar);
end;

procedure TfrmCadMotoristas.pSetaCheckList(CheckListBox : TCheckListBox);
begin
  clbSelecionado := CheckListBox;
end;

procedure TfrmCadMotoristas.pAbrirPoup;
begin
  popOpSele.Popup(Mouse.CursorPos.X + 2, Mouse.CursorPos.Y + 2);
end;

procedure TfrmCadMotoristas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmCadMotoristas.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadMotoristas.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;


  If (blnExcluiu) Then
  Begin
    pLimpaCampos;
    pCarregaDados;
  End;

end;

procedure TfrmCadMotoristas.btnGravarClick(Sender: TObject);
Var
  blnCodBar: Boolean;
begin

  blnCodBar := False;

  Try

    If Not fValidaCampos(dbeLatLon) Then
      Exit;

    If (pnlCodBar.Visible) Then
    Begin
      If fEmptyStr(dbeCodBar.Text) Then
        blnCodBar := True;
    End;

    If (fEmptyStr(fTiraCaracEspeciaisParenteses(dbePlaVei.Text))) Then
      qryTabela.FieldByName('MOT_PLAVEI').Value := Null;

    If (Not fValidacoesBotaoGravarPai) Then
      Exit;

    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

    inherited;

    If (strTipEntSen = 'S') And blnGravou Then
    Begin
      qryTabela.Edit;
      qryTabela.FieldByName('MOT_SENMOT').AsString := fCrypt(edtSenha.Text);
      qryTabela.Post;
    End;

    If ((blnGravou) And (blnCodBar)) Then
    Begin
      qryTabela.Edit;
      qryTabela.FieldByName('MOT_CODBAR').AsString := fGeraCodBarraEAN13(RightStr('1900' +  VS_strCodEmp + qryTabela.FieldByName('MOT_CODMOT').AsString, 12));
      qryTabela.Post;
    End;

    If ((blnGravou) And (gpbAppEntrega.Visible)) Then
    Begin
      qryTabela.Edit;
      qryTabela.FieldByName('MOT_USUMOT').AsString := edtLogin.Text;
      qryTabela.FieldByName('MOT_EMPAPP').AsString := fRetEmpresasSel(clbEmpresa);
      qryTabela.FieldByName('MOT_TIPMOT').AsString := IIF(cmbTipMot.ItemIndex = 0, 'P', 'T');
      qryTabela.FieldByName('MOT_TIPLIC').AsString := IIF(cmbLicenca.ItemIndex = 0, '', IIF(cmbLicenca.ItemIndex = 1, 'C', 'M'));
      qryTabela.Post;
    End;

    If blnGravou Then
    begin
      fCommit;

      if Assigned(objRomFusTarefas) then
      begin
        objRomFusTarefas.pProcessarTarefas;
        pCarregaRegistroAntesAlteracao;
      end;
    end
    Else
      fRollBack;

    if blnGravou then
    begin
      clbEmpresa.Enabled := False;
      lblclbEmpresa.Enabled := False;
      pAtualizaLstEmpresa('MOT_EMPAPP', clbEmpresa);
    end;

    blnGravou := False;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadMotoristas.btnGravarClick]');
    End;
  End;

end;

procedure TfrmCadMotoristas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pLimpaCampos;
  dbeStatus.Field.AsString := 'A';
  dbeMonMot.Field.AsString := 'S';
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodMot, dbeStatus, False)
  Else
    pHabilitaCodigo(dbeCodMot, dbeCodMot, True);

  clbEmpresa.Enabled := True;
  lblclbEmpresa.Enabled := True;
  pCarregaLstEmpresa;

  cmbLicenca.OnClick(Self);
end;

procedure TfrmCadMotoristas.btnPesquisaClick(Sender: TObject);
begin
  Self.pPesquisa;
end;

procedure TfrmCadMotoristas.cmbLicencaClick(Sender: TObject);
begin
  inherited;

  if not fCfgSis('MATDIS', varBoolean) then
    Exit;

  if (cmbLicenca.ItemIndex = 0) or (cmbLicenca.ItemIndex = -1) then
  begin
    pnlSenha.Visible := False;
    pnlAppEntrega.Visible := False;
  end
  else
  begin
    pnlSenha.Visible := True;
    pnlAppEntrega.Visible := True;
  end;
end;

procedure TfrmCadMotoristas.dbeMonMotEnter(Sender: TObject);
begin
  inherited;
    if dbeMonMot.DataSource.DataSet.State in [dsInsert, dsEdit] then
    If fEmptyStr(dbeMonMot.Text) Then
      dbeMonMot.Field.AsString := 'S';
end;

procedure TfrmCadMotoristas.dbePlaVeiKeyPress(Sender: TObject; var Key: Char);
Var
  arrVeic: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE VEÍCULOS   *}
  {****************************RV*}
  If fPesqVeiculos(Self, dbePlaVei, edtDesVei, Nil, Key, arrVeic, True, True,  ' VEI_STATUS = "A" ') Then
  Begin
    If fValidaCampos(dbePlaVei, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMotoristas.dbeStatusEnter(Sender: TObject);
begin
  inherited;
  if dbeStatus.DataSource.DataSet.State in [dsInsert, dsEdit] then
    If fEmptyStr(dbeStatus.Text) Then
      dbeStatus.Field.AsString := 'A';
end;

procedure TfrmCadMotoristas.DesmarcarTodos1Click(Sender: TObject);
begin
  inherited;
  pExecutarSelecao(opcDesmarcar);
end;

procedure TfrmCadMotoristas.edtLoginChange(Sender: TObject);
begin
  inherited;
  edtLogin.Text := fTiraCaracEspeciais(edtLogin.Text, True, True, True, True, True, True);
end;

procedure TfrmCadMotoristas.btnAlterarClick(Sender: TObject);
  Var
    strSenha: String;
begin
  {**********************************************************}
  {* VERIFICA SE O USUARIO TEM PERMISSAO PARA ALTERAR SENHA *}
  {*******************************************************RV*}
  If (strTipEntSen = 'S') Then
  Begin
    If Not fVerificaAcessoSistema('ALTSEN', strLoginUsuarioLogado) Then
    Begin
      If (Not qryTabela.IsEmpty) And
         (fMensagem('AVISO!', 'Deseja alterar a senha?', ['&Sim', '&Não']) = 1) Then
      Begin
        If ffrmSenha(strSenha) Then
        Begin
          If (strSenha = fDecrypt(qryTabela.FieldByName('MOT_SENMOT').AsString)) Then
          Begin
            edtSenha.Enabled    := True;
            edtConSenha.Enabled := True;
            inherited;
            pHabilitaCodigo(dbeCodMot, dbeStatus, False);
            clbEmpresa.Enabled := True;
            lblclbEmpresa.Enabled := True;
          End
          Else
          Begin
            edtSenha.Enabled    := False;
            edtConSenha.Enabled := False;
            Exit;
          End;
        End;
      End
      Else
      Begin
        inherited;
        dbeCodMot.Enabled := False;
        pHabilitaCodigo(dbeCodMot, dbeStatus, False);
        edtSenha.Enabled    := False;
        edtConSenha.Enabled := False;
        clbEmpresa.Enabled  := True;
        lblclbEmpresa.Enabled := True;
      End;
    End
    Else
    Begin
      edtSenha.Enabled    := True;
      edtConSenha.Enabled := True;
      inherited;
      pHabilitaCodigo(dbeCodMot, dbeStatus, False);
      clbEmpresa.Enabled := True;
      lblclbEmpresa.Enabled := True;
    End;
  End
  Else
  Begin
    inherited;
    pHabilitaCodigo(dbeCodMot, dbeStatus, False);
    clbEmpresa.Enabled := True;
    lblclbEmpresa.Enabled := True;
  End;
end;

function TfrmCadMotoristas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  arrLicencas: TStringArray;
  strRomaneios: String;
begin

  Result := True;

  If (Sender = dbeCodMot) Then
  Begin
    If (not fEmptyStr(dbeCodMot.Text)) And (dbeCodMot.Enabled) Then
    Begin
      dbeCodMot.Text := fStrZero(dbeCodMot.Text, 5);
    End;

    If (fEmptyStr(dbeCodMot.Text)) And (dbeCodMot.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código do Motorista deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (blnBuscaPorChave) Then
    Begin
      If Not fBuscaPorCamposChave Then
        pLimparCampos
      Else
      Begin
        edtSenha.Text       := fDecrypt(qryTabela.FieldByName('MOT_SENMOT').AsString);
        edtConSenha.Text    := edtSenha.Text;
        edtSenha.Enabled    := False;
        edtConSenha.Enabled := False;
      End;
    End;
  End

  Else If (Sender = dbePlaVei) Then
  Begin

    If fVeiculoInativo(dbePlaVei.Text) Then
    Begin
      edtDesVei.Text := '';
      fMensagem('','Este veículo está inativo.',['&O k']);
      Result := False;
    End
    Else
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(dbePlaVei.Text)) Then
      Begin
        edtDesVei.Text := fRetornaDescricaoVeic(dbePlaVei.Text);
        If fEmptyStr(edtDesVei.Text) Then
        Begin
          Result := False;
          fMensagem('','Nenhum veículo cadastrado com esta placa!',['&Ok']);
          Exit;
        End;
      End
      Else
        edtDesVei.Clear;
    End;
  End

  Else If (Sender = dbeCpfMot) Then
  Begin
    If Not fEmptyStr(dbeCpfMot.Text) Then
    Begin
      If Not fValidaCPF(dbeCpfMot.Text) Then
      Begin
        pMensagemOk('CPF inválido.');
        Result := False;
      End;
    End;
  End

  {**************************************}
  {* VALIDA A SITUAÇÃO DO MOTORISTA     *}
  {***********************************MM*}
  Else If (Sender = dbeStatus) Then
  Begin
    If Pos(dbeStatus.Text,'AI') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'A Situação do Motorista deve ser (A)tivo ou (I)nativo!', ['&O k']);
      Result := False;
    End
  End

  Else If (Sender = dbeNomMot) Then
  Begin
    If fEmptyStr(dbeNomMot.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Nome do Motorista deve ser preenchido!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtSenha) And ((Not fCfgSis('MATDIS', varBoolean)) Or (cmbLicenca.ItemIndex <> 0)) Then
  Begin
    If (strTipEntSen = 'S') Then
    Begin
      If fEmptyStr(edtSenha.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo senha é de preenchimento obrigatório!', ['&Ok']);
        Result := False;
      End
      Else If Length(edtSenha.Text) < 6 then
      Begin
        fMensagem('ATENÇÃO!', 'A senha deve conter no mínimo 6 dígitos!', ['&Ok']);
        Result := False;
      end
      Else If (edtSenha.Enabled)                                                      And
              (fCrypt(edtSenha.Text) <> qryTabela.FieldByName('MOT_SENMOT').AsString) And
              (fVerificaSenhaMotorista(edtSenha.Text))                                Then
      Begin
        fMensagem('ATENÇÃO!', 'Senha inválida ou fora dos padrões exigidos. Verifique.', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtConSenha) Then
  Begin
    If (strTipEntSen = 'S') Then
    Begin
      If (edtConSenha.Text <> edtSenha.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A confirmação da senha é diferente da Senha! Verifique...', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtLogin) And (gpbAppEntrega.Visible) And (cmbLicenca.ItemIndex <> 0) Then
  Begin
    If fEmptyStr(edtLogin.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo Login App Entrega é de preenchimento obrigatório!', ['&OK']);
      Result := False;
    End
    Else If (edtLogin.Text <> qryTabela.FieldByName('MOT_USUMOT').AsString) And
            (fVerificaUsuarioMotorista(edtLogin.Text))                                Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse Usuário já Existe! Verifique.', ['&Ok']);
      Result := False;
    End;

  End

  Else If (pnlCodBar.Visible) And (Sender = dbeCodBar) Then
  Begin
    If (Not fEmptyStr(dbeCodBar.Text)) And
       (Not fValidaCodBarra(dbeCodBar.Text, dbeCodMot.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Código de Barras duplicado!', ['&OK']);
      Result := False;
    End
  End

  Else If (Sender = dbeMonMot) And (gpbAppEntrega.Visible) And (cmbLicenca.ItemIndex <> 0) Then
  Begin
    If Pos(dbeMonMot.Text,'SN') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Monitorar motorista em tempo real deve ser S ou N!', ['&O k']);
      Result := False;
    End
  End

  Else If (Sender = cmbLicenca) And (gpbAppEntrega.Visible) Then
  Begin
    If (cmbLicenca.ItemIndex = 0) and (not validaRomaneiosPendentes(strRomaneios)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Este motorista possui romaneio pendente de entrega.' + #13#10 +
       'Não é possível remover a licença.' + #13#10 +
       'Para remover o motorista do Romaneio, basta carregá-lo na Manutenção do Romaneio e trocar o motorista.' + #13#10#13#10 +
       'ROMANEIOS PENDENTES: ( ' + strRomaneios + ' )', ['&O k'], 1, False, 1, 0, False, 0, False, False, False, 0, 650);
      Result := False;
    End
    Else If (cmbLicenca.ItemIndex > 0) and (not utilizaAppEntrega()) Then
    Begin
      fMensagem('ATENÇÃO!', 'Para informar o tipo de licença para o motorista, os seguintes campos devem estar preenchidos.' + #13#10 +
        '"Login App entrega", "Senha" e "Acesso Empresas App Entrega"', ['&O k']);
      Result := False;
    End
    Else If (cmbLicenca.ItemIndex > 0) and (not validaLicencaDisponível(IIF(cmbLicenca.ItemIndex = 1, 'C', 'M'), arrLicencas)) Then
    Begin
      fMensagemTabela('ATENÇÃO!', 'Licença   Motorista', arrLicencas,
        'O número máximo de licenças já foi utilizado.' + #13#10 +
        'Número de licenças para ' + IIF(cmbLicenca.ItemIndex = 1, 'Carros', 'Motos') + ': ' + IntToStr(Length(arrLicencas)), ['&O k']);
      Result := False;
    End
  End

  Else If (Sender = dbeLatLon) And (gpbAppEntrega.Visible) And (cmbLicenca.ItemIndex <> 0) Then
  Begin
    If Not fEmptyStr(dbeLatLon.Text) Then
    Begin
      If Not fValidarLatitudeLongitude(dbeLatLon.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe uma coordenada válida para o campo "Lat, Long do endereço do motorista:"!', ['&O k']);
        Result := False;
      End
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadMotoristas.pCarregaDados;
var
  picImagem : TPicture;
begin
  fValidaCampos(dbePlaVei);
  fValidaCampos(dbeLatLon);

  If (strTipEntSen = 'S') Then
    pRetSenha;

  If gpbAppEntrega.Visible Then
  Begin
    pRetDadosAppEntrega;
    pAtualizaLstEmpresa('MOT_EMPAPP', clbEmpresa);
    clbEmpresa.Enabled := False;
    lblclbEmpresa.Enabled := False;

    if not fEmptyStr(qryTabela.FieldByName('MOT_FOTMOT').AsString) then
    begin
      picImagem := imgFotMot.Picture;
      pImagemFromBase64(qryTabela.FieldByName('MOT_FOTMOT').AsString, picImagem);
    end;
  End;

  cmbLicenca.OnClick(Self);
end;

procedure TfrmCadMotoristas.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('MOT_CODMOT');
  stlCampos.Add('MOT_NOMMOT');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('MOT_NOMMOT');
  stlCamInd.Add('MOT_CODMOT');
  stlDesInd.Add('Nome');
  stlDesInd.Add('Código');

end;

procedure TfrmCadMotoristas.pLimpaCampos;
begin

  edtSenha.Clear;
  edtConSenha.Clear;
  edtConSenha.Clear;
  edtDesVei.Clear;
  imgFotMot.Clear;

  if dbePerFre.Field.DataSet.State in [dsEdit, dsInsert] then
  begin
    dbePerFre.Field.Value := 0;
  end;

  cmbTipMot.ItemIndex := 0;
  cmbLicenca.ItemIndex := 0;
end;

procedure TfrmCadMotoristas.pPesquisa(strCodMotorista: String = '');
Var
  chrKey: Char;
  arrMot: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE MOTORISTAS *}
  {****************************RV*}
  chrKey := '/';
  If fSetaMotoristaInformado(strCodMotorista) Or
     fPesqMotorista(Self, Nil, Nil, qryTabela, chrKey, arrMot) Then
  Begin
    pSetaMascara;
    pSetFocus(btnAlterar);
    pCarregaDados;
    pCarregaRegistroAntesAlteracao;
  End;
end;

function TfrmCadMotoristas.fSetaMotoristaInformado(strCodMotorista: String = ''): Boolean;
begin
  Result := False;
  If Not fEmptyStr(strCodMotorista) Then
  Begin
    pPesquisaCadMot(qryTabela, qryTabela, strCodMotorista);
    Result := True;
  End;
end;

procedure TfrmCadMotoristas.pRetSenha;
begin
  edtSenha.Text    := fDecrypt(qryTabela.FieldByName('MOT_SENMOT').AsString);
  edtConSenha.Text := fDecrypt(qryTabela.FieldByName('MOT_SENMOT').AsString);
end;

procedure TfrmCadMotoristas.pRetDadosAppEntrega;
begin
  edtLogin.Text := qryTabela.FieldByName('MOT_USUMOT').AsString;
  cmbTipMot.ItemIndex := IIF(qryTabela.FieldByName('MOT_TIPMOT').AsString = 'P', 0, 1);
  cmbLicenca.ItemIndex := IIF(qryTabela.FieldByName('MOT_TIPLIC').AsString = '', 0, IIF(qryTabela.FieldByName('MOT_TIPLIC').AsString = 'C', 1, 2));
end;

end.

