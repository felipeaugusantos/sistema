{***********************}
{* qryCadCid -> CADCID *}
{********************RV*}
unit untCadCidades;

interface

uses
  Controls, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls, Mask, DBCtrls,
  DBEditFocus, Menus, AppEvnts, Uni, DB, BitBtnLockedIncrem, Classes, frxClass,
  frxExportCSVTestabilidade, Windows, dxScreenTip, cxClasses, dxCustomHint, cxProgressBar,
  System.Types, EditFocus, QColorLabel, DBComboBoxFocus, Winapi.Messages, untGravando;

type
  TfrmCadCidades = class(TfrmPaiCad)
    pnlFundo: TPanel;
    dtsCadCid: TDataSource;
    btnFeriados: TBitBtnLocked;
    pnlTopo: TPanel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    pnlCodCor: TPanel;
    lblCodCor: TLabel;
    dbeCodCor: TDBEditFocus;
    edtNomCid: TEditFocus;
    pnlAllClient: TPanel;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblCodPai: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lblRedISS: TLabel;
    clbRedISS: TLabel;
    dbeEstado: TDBEditFocus;
    dbeNomCid: TDBEditFocus;
    dbeNumCep: TDBEditFocus;
    dbeValEnt: TDBEditFocus;
    dbeCodIbge: TDBEditFocus;
    dbeCodPai: TDBEditFocus;
    dbeAlqIss: TDBEditFocus;
    gpbSIAM: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    dbeMunSIA: TDBEditFocus;
    DBEditFocus1: TDBEditFocus;
    dbeRedISS: TDBEditFocus;
    rdgTaxEnt: TDBRadioGroup;
    gpbSigepWeb: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    dbeVrMSeg: TDBEditFocus;
    dbePerSeg: TDBEditFocus;
    lblQtdDia: TLabel;
    dbeQtdDia: TDBEditFocus;
    btnReducaoBCISS: TBitBtnLocked;
    grbPisCof: TGroupBox;
    lblLimJud: TLabel;
    ColorLabel29: TColorLabel;
    dbeLimJud: TDBEditFocus;
    lblSitP_C: TLabel;
    cbbSitP_C: TDBComboBoxFocus;
    Label11: TLabel;
    dbeIbsMna: TDBEditFocus;
    Label12: TLabel;
    Label13: TLabel;
    dbeIbsMnr: TDBEditFocus;
    Label14: TLabel;
    dbeIbsMnd: TDBEditFocus;
    Label15: TLabel;
    Label16: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeCodCorKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodIbgeKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeCodPaiKeyPress(Sender: TObject; var Key: Char);
    procedure dbeEstadoExit(Sender: TObject);
    procedure btnFeriadosClick(Sender: TObject);
    procedure dtsCadCidDataChange(Sender: TObject; Field: TField);
    procedure FormActivate(Sender: TObject);
    procedure rdgTaxEntEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnReducaoBCISSClick(Sender: TObject);
    procedure dbeLimJudChange(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    qryCadCid: TUniQuery;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pCarregaTributacao;
    procedure pAtualizaTributacao;
    function fAtualizaSituacaoPisCofinsCliente(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pExibeMensagemTexto(const strTexto: String);
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fValidaCodIbge(strUf, strCodIbge: String): Boolean;
    procedure fAtualizaProximoCodigoCidade;
    procedure pGerarReducaoBCISSNovaCidade;
  public
    { Public declarations }
    strOperacao: String;
  end;


implementation

uses SysUtils, Forms, untPai, untFuncoesSimples, untCadCid, untTypesSistema,
     untConsultas, untCadFeriadoCid, untConstantes, untModulo, untCadReducaoBCISS,
     StrUtils, untObservacao;

{$R *.dfm}

procedure TfrmCadCidades.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadCidades.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADCID';
  strNomeCampo      := 'CID_CODCID';

  qryCadCid         := fCriaQuery(Self);
  qryTabela         := qryCadCid;
  dtsCadCid.DataSet := qryTabela;

  qryCadCid.AfterOpen := pAfterOpen;

  if fCfgSis('CIDQTD', varBoolean) then
  begin
    lblQtdDia.Visible := True;
    dbeQtdDia.Visible := True;
  end
  else
  begin
    lblQtdDia.Visible := False;
    dbeQtdDia.Visible := False;
  end;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

end;

procedure TfrmCadCidades.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: If ActiveControl Is TRadioButton Then
               Begin
                 Key := 0;
                 SelectNext(ActiveControl, True, True);
               end;
  End;
end;

procedure TfrmCadCidades.pAfterOpen(DataSet: TDataSet);
begin
  TFloatField(DataSet.FieldByName('CID_VALENT')).DisplayFormat := '#,#0.00';
  TFloatField(DataSet.FieldByName('CID_ALQISS')).DisplayFormat := fDisplayFormatUsandoCampo('CADCID','CID_ALQISS');
  TFloatField(DataSet.FieldByName('CID_REDISS')).DisplayFormat := '#,#0.00';
  TFloatField(DataSet.FieldByName('CID_VRMSEG')).DisplayFormat := '#,#0.00';
  TFloatField(DataSet.FieldByName('CID_PERSEG')).DisplayFormat := '#,#0.00';
  TFloatField(DataSet.FieldByName('CID_IBSMNA')).DisplayFormat := '#,#0.00';
  TFloatField(DataSet.FieldByName('CID_IBSMNR')).DisplayFormat := '#,#0.00';
  TFloatField(DataSet.FieldByName('CID_IBSMND')).DisplayFormat := '#,#0.00';
end;

procedure TfrmCadCidades.pAtualizaTributacao;
begin
  Case AnsiIndexStr(UpperCase(qryTabela.FieldByName('CID_SITP_C').Text), ['T', 'I','S', 'D', 'Z']) of
    0 : cbbSitP_C.ItemIndex := Integer(sitPisCofinsTributado);
    1 : cbbSitP_C.ItemIndex := Integer(sitPisCofinsIsento);
    2 : cbbSitP_C.ItemIndex := Integer(sitPisCofinsSuspenso);
    3 : cbbSitP_C.ItemIndex := Integer(sitPisCofinsDiferido);
    4 : cbbSitP_C.ItemIndex := Integer(sitPisCofinsTributadoAliquotaZero);
  end;
end;

procedure TfrmCadCidades.pCarregaTributacao;
var
  i: integer;
begin
  cbbSitP_C.Items.Clear;
  For i := 0 To Length(arr_SITUACAOTRIBUTARIAPISCOFINS)-1 do
    cbbSitP_C.Items.Add(arr_SITUACAOTRIBUTARIAPISCOFINS[i][0]+'  - '+arr_SITUACAOTRIBUTARIAPISCOFINS[i][1]);
end;

procedure TfrmCadCidades.pExibeMensagemTexto(const strTexto: String);
var
  frmObservacao: TfrmObservacao;
begin
  If fEmptyStr(strTexto) Then
    Exit;

  pCriarFormularios(TfrmObservacao, frmObservacao);
  Try
    Try
      frmObservacao.lblMensagem.caption := 'ATENÇÃO';
      frmObservacao.memObs.Texto := strTexto;
      frmObservacao.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[pExibeMensagemTexto]');
      End;
    End;
  Finally
    pFreeAndNil(frmObservacao);
  End;
end;

procedure TfrmCadCidades.pGerarReducaoBCISSNovaCidade;
  Var
    qryEmp, qryIns: TUniQuery;
begin

  Try

    qryEmp := fCriaQuery;

    qryEmp.SQL.Add('SELECT EMP_CODEMP ');
    qryEmp.SQL.Add('  FROM CADEMP ');
    qryEmp.SQL.Add(' ORDER BY EMP_CODEMP ');
    qryEmp.Open;
    qryEmp.First;

    While Not qryEmp.Eof do
    Begin

      qryIns := fCriaQuery;

      Try
        qryIns.SQL.Add('INSERT INTO CADRBC ( AUTOINCREM, CID_CODCID, CID_CODEMP, CID_REDISS, CID_SEQCID ) ');
        qryIns.SQL.Add('VALUES (:AUTOINCREM, :CODCID, :CODEMP, :REDISS, :SEQCID) ');
        qryIns.ParamByName('AUTOINCREM').asString := fRetAutoIncrem('CADRBC', VS_strCodEmp);
        qryIns.ParamByName('CODCID').asString := dbeCodigo.Text;
        qryIns.ParamByName('CODEMP').asString := qryEmp.FieldByName('EMP_CODEMP').asString;
        qryIns.ParamByName('REDISS').asFloat := 0;
        qryIns.ParamByName('SEQCID').asString := qryTabela.FieldByName('AUTOINCREM').asString;
        qryIns.ExecSQL;
      Finally
        FreeAndNil(qryIns);
      End;

      qryEmp.Next;

    End;

  Finally
    FreeAndNil(qryEmp);
  End;

end;

procedure TfrmCadCidades.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CID_CODCID');
  stlCampos.Add('CID_NOMCID');
  stlCampos.Add('CID_ESTADO');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CID_NOMCID');
  stlCamInd.Add('CID_CODCID');
  stlDesInd.Add('Nome da Cidade');
  stlDesInd.Add('Código');
end;

procedure TfrmCadCidades.rdgTaxEntEnter(Sender: TObject);
begin
  inherited;
  If rdgTaxEnt.ItemIndex = -1 Then rdgTaxEnt.ItemIndex := 0;
  pSetFocus(TWinControl(rdgTaxEnt.Controls[rdgTaxEnt.ItemIndex]));
end;

procedure TfrmCadCidades.btnCancelaClick(Sender: TObject);
begin
  inherited;
  edtNomCid.Text := fRetNomeCidadeCorreios(qryTabela.FieldByName('CID_CODCOR').AsInteger);
  btnReducaoBCISS.Enabled := False;
  pAtualizaTributacao;
end;

procedure TfrmCadCidades.btnExcluirClick(Sender: TObject);
begin
  Try
    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, 'TfrmCadCidades.btnExcluirClick');
      Exit;
    End;
  End;
  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadCidades.btnFeriadosClick(Sender: TObject);
var
  frmCadFeriadoCid: TfrmCadFeriadoCid;
begin
  inherited;
  pCriarFormularios(TfrmCadFeriadoCid, frmCadFeriadoCid);
  frmCadFeriadoCid.pSetaCidade(qryTabela.FieldByName('CID_CODCID').AsString);
  frmCadFeriadoCid.ShowModal;
  pFreeAndNil(frmCadFeriadoCid);
end;

procedure TfrmCadCidades.btnGravarClick(Sender: TObject);
var
  frmAguarde: TfrmGravando;
  blnAtualizaSituacaoPisCofinsCliente: Boolean;
begin
  if not fValidacoesBotaoGravarPai then
  begin
    Exit;
  end;


  If (dbeLimJud.Text = 'S') And (cbbSitP_C.Visible) And (cbbSitP_C.ItemIndex < 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Campo "' + lblSitP_C.Caption + '" deve ser preenchido!', ['&OK']);
    Exit;
  End;
  If (qryTabela.FieldByName('CID_ESTADO').AsString = 'EX') And
     (qryTabela.FieldByName('CID_COIBGE').AsString = '') Then
    qryTabela.FieldByName('CID_COIBGE').AsString := '9999999';


  { Caso o valor do campo estava (N)ão e permaneceu o mesmo então não deve atualizar o cadastro de clientes. }
  blnAtualizaSituacaoPisCofinsCliente := False;
  { Se estava (S)im precisa alterar os clientes removendo a suspensão de cobrança voltando o
    valor do campo no cadastro de clientes para o valor default "T" (Tributado). }
  If (VarToString(dbeLimJud.Field.OldValue).Equals('S') And VarToString(dbeLimJud.Field.Value).Equals('N')) Then
    blnAtualizaSituacaoPisCofinsCliente := True;
  { Se o valor atual for (S)im precisa atualizar todos os clientes com a situação PIS/COFINS informada. }
  If ((dbeLimJud.Text = 'S') and (cbbSitP_C.Visible) and (cbbSitP_C.ItemIndex > -1)) Then
    blnAtualizaSituacaoPisCofinsCliente := True;

  If blnAtualizaSituacaoPisCofinsCliente Then
  Begin
    If dbeLimJud.Text = 'S' Then
      If Not fPergunta('A situação de PIS/COFINS será atualizada para "' + Trim(arr_SITUACAOTRIBUTARIAPISCOFINS[cbbSitP_C.ItemIndex][1]) +
        '" nos clientes desta cidade. Confirma esta atualização?') Then
          Exit;

    If dbeLimJud.Text <> 'S' Then
      If Not fPergunta('A situação de PIS/COFINS será atualizada para "Tributado"' +
        ' nos clientes desta cidade. Confirma esta atualização?') Then
          Exit;
  End;

  Try
    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, 'TfrmCadCidades.btnGravarClick');
      Exit;
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  If (blnUsaProCodigo) And
     (Not (fCfgSis('EMPGER', varBoolean))) Then
    fAtualizaProximoCodigoCidade;

  If (strOperacao = 'I') and (blnGravou) Then
    pGerarReducaoBCISSNovaCidade;

  btnReducaoBCISS.Enabled := False;
  pAtualizaTributacao;

  If blnAtualizaSituacaoPisCofinsCliente Then
  begin
    try
      try
        pCriarFormularios(TfrmGravando, frmAguarde);
        frmAguarde.fExecutarAcao := fAtualizaSituacaoPisCofinsCliente;
        frmAguarde.lblGravando.Font.Size := 16;
        frmAguarde.ShowModal;
      except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '');
        End;
      End;
    finally
      pFreeAndNil(frmAguarde);
    end;
  end;

end;

procedure TfrmCadCidades.btnIncluirClick(Sender: TObject);
begin
  inherited;

  strOperacao := 'I';

  edtNomCid.Clear;

  If blnUsaProCodigo Then
  Begin
    If dbeCodCor.Visible Then
      pHabilitaCodigo(dbeCodigo, dbeCodCor, False)
    Else
      pHabilitaCodigo(dbeCodigo, dbeNomCid, False);
  End
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  rdgTaxEnt.Field.AsString := 'I';

  qryTabela.FieldByName('CID_QTDDIA').AsInteger := 0;
  qryTabela.FieldByName('CID_LIMJUD').AsString := 'N';
  qryTabela.FieldByName('CID_ORIGEM').AsString := 'CAD.CIDADES';

  cbbSitP_C.ItemIndex := -1;

  If dbeCodigo.Enabled Then
    pSetFocus(dbeCodigo)
  Else
  If dbeCodCor.Visible Then
    pSetFocus(dbeCodCor)
  Else
    pSetFocus(dbeNomCid);

  pAtualizaTributacao;

  btnReducaoBCISS.Enabled := False;

end;

procedure TfrmCadCidades.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrCidade: TConsultasArray;
begin
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  chrKey := '/';
  If fPesqCidade(Self, Nil, Nil, Nil, qryTabela, chrKey, arrCidade) Then
  begin
    If Not fEmptyStr(qryTabela.FieldByName('CID_CODCOR').AsString) Then
      edtNomCid.Text := fRetNomeCidadeCorreios(qryTabela.FieldByName('CID_CODCOR').AsInteger)
    Else
      edtNomCid.Clear;
    pSetFocus(btnAlterar);
  end;
  pAtualizaTributacao;
end;

procedure TfrmCadCidades.btnReducaoBCISSClick(Sender: TObject);
  Var
    qryGen: TUniQuery;
    frmCadReducaoBCISS: TfrmCadReducaoBCISS;
begin

  If qryTabela.isEmpty Then
    Exit;

  Try

    qryGen := fCriaQuery;

    qryGen.SQL.Add(' SELECT ');
    qryGen.SQL.Add('   CADRBC.CID_CODEMP, ');
    qryGen.SQL.Add('      (SELECT CADEMP.EMP_NOMEMP ');
    qryGen.SQL.Add('         FROM CADEMP ');
    qryGen.SQL.Add('        WHERE CADEMP.EMP_CODEMP = CADRBC.CID_CODEMP) AS CID_DESEMP, ');
    qryGen.SQL.Add('   CADRBC.CID_REDISS ');
    qryGen.SQL.Add('   FROM CADRBC ');
    qryGen.SQL.Add('   WHERE CADRBC.CID_CODCID = :CODCID ');
    qryGen.SQL.Add('   ORDER BY CADRBC.CID_CODEMP ');

    qryGen.ParamByName('CODCID').AsString := dbeCodigo.Text;
    qryGen.Open;


    if qryGen.isEmpty Then
      pMensagemOk('É necessário concluir a inclusão da nova cidade para realizar esse cadastro.')
    Else
    Begin

      pCriarFormularios(TfrmCadReducaoBCISS, frmCadReducaoBCISS);
      frmCadReducaoBCISS.cdsReducaoBCISS.CreateDataSet;
      While Not qryGen.Eof do
      Begin
        frmCadReducaoBCISS.cdsReducaoBCISS.Insert;
        frmCadReducaoBCISS.cdsReducaoBCISSCID_CODEMP.asString := qryGen.FieldByName('CID_CODEMP').asString;
        frmCadReducaoBCISS.cdsReducaoBCISSCID_DESEMP.asString := qryGen.FieldByName('CID_DESEMP').asString;
        frmCadReducaoBCISS.cdsReducaoBCISSCID_REDISS.AsFloat  := qryGen.FieldByName('CID_REDISS').asFloat;
        frmCadReducaoBCISS.cdsReducaoBCISSCID_CODCID.AsString := dbeCodigo.Text;
        frmCadReducaoBCISS.cdsReducaoBCISS.Post;
        qryGen.Next;
      End;
      frmCadReducaoBCISS.cdsReducaoBCISS.First;
      frmCadReducaoBCISS.ShowModal;

    End;

  Finally
    FreeAndNil(qryGen);
    FreeAndNil(frmCadReducaoBCISS);
    SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadCidades.btnAlterarClick(Sender: TObject);
begin
  inherited;

  strOperacao := 'A';

  If (dbeCodCor.Visible) Then
    pHabilitaCodigo(dbeCodigo, dbeCodCor, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeNomCid, False);

  If dbeCodigo.Enabled Then
    pSetFocus(dbeCodigo)
  Else
  If dbeCodCor.Visible Then
    pSetFocus(dbeCodCor)
  Else
    pSetFocus(dbeNomCid);

  pAtualizaTributacao;

  btnReducaoBCISS.Enabled := True;

end;

function TfrmCadCidades.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    strNomCid: String;
    strEstado: String;
    strNumCep: String;
    strCidCad: String;
    strMsgIBGE: string;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) And blnBuscaPorChave Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da cidade deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeNomCid) Then
    Begin
      If fEmptyStr(dbeNomCid.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A Descrição da Cidade deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeEstado) Then
    Begin
      If fEmptyStr(dbeEstado.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Campo Estado deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (Not fValidaEstado(dbeEstado.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'O Campo Estado não é valido!', ['&Ok']);
        Result := False;
      End;
    End


    Else If (Sender = dbeCodIbge) Then
    Begin
      If fCfgSis('NFEUSA', varBoolean) Then
      Begin
        strMsgIBGE := 'Caso a cidade que está sendo cadastrada seja distrito ou município de outra cidade e não contenha código IBGE.'+#10#13+'Favor informar o código IBGE da cidade ao qual este município pertença.';
        If (fEmptyStr(dbeCodIbge.Text)) Then
        Begin
          fMensagem('','A empresa é emitente de nota fiscal eletronica, o código do IBGE deve ser preenchido!'+#10#13+strMsgIBGE,['&OK']);
          Result := False;
        End
        Else If Length(dbeCodIbge.Text) <> 7 Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O código ibge deve ter 7 digitos', ['OK']) = -1;
        End
        Else If (Not fvalidaCodIbge(dbeEstado.Text, dbeCodIbge.Text)) And (dbeEstado.Text <> 'EX') Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O código ibge informado não é válido'+#10#13+strMsgIBGE, ['OK']) = -1;
        End
        Else If (Not fVerificaCodIBGE(dbeCodIbge.Text)) And (dbeEstado.Text <> 'EX') Then
        Begin
          fMensagem('ATENÇÃO', 'O Código IBGE do Município não é válido!'+#10#13+strMsgIBGE, ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeCodPai) Then
    Begin

      If (fEmptyStr(dbeCodPai.Text)) Then
        Result := fMensagem('','O código do país deve ser preenchido!',['&OK']) = -1

      Else If Length(dbeCodPai.Text) <> 4 Then
        Result := fMensagem('', 'O código do país deve ter 4 digitos', ['OK']) = -1

      Else If fEmptyStr(fRetNomePais(dbeCodPai.Text)) Then
        Result := fMensagem('', 'O código do país informado não é válido', ['OK']) = -1;

    End

    Else If (Sender = dbeNumCep) Then
    Begin
      If fEmptyStr(dbeNumCep.Text) And blnBuscaPorChave Then
      Begin
        fMensagem('ATENÇÃO', 'O Campo CEP deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCodCor) And (dbeCodCor.Visible) And (Not SameText(dbeEstado.Text, 'EX')) Then
    Begin
      If Result And (not fEmptyStr(dbeCodCor.Text)) Then
      Begin
        If (Not fCadCepDadosCidade(dbeCodCor.Text, strNomCid, strEstado, strNumCep)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Código não encontrado.', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          edtNomCid.Text := strNomCid;
          strCidCad := fRetCidadesCadastradasComCodCorreios(StrToIntDef(dbeCodCor.Text, 0), dbeCodigo.Text);
          If not fEmptyStr(strCidCad) Then
          Begin
            Result := False;

            pExibeMensagemTexto('O Código dos Correios não pode repetir entre as cidades e o Código Informado já esta Sendo Utilizado, Confira o Cadastro da Cidade Abaixo:' + #13 + #13 + strCidCad);

          End

          Else
          If qryTabela.State = dsInsert Then
          Begin
            dbeNomCid.Field.AsString := strNomCid;
            dbeEstado.Field.AsString := strEstado;
            If not fEmptyStr(strNumCep) Then
              dbeNumCep.Field.AsString := strNumCep;
          End;


        End;
      End
      Else If (fEmptyStr(dbeCodCor.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'Código dos correios não informado!', ['&OK']);
        Result := False;
        edtNomCid.Clear;
      End
      Else
        edtNomCid.Clear;
    End

    Else If (Sender = dbeValEnt) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(dbeValEnt.Text) Then
        dbeValEnt.Field.AsFloat := 0
      Else If fStrToFloat(dbeValEnt.Text) < 0 Then
      Begin
        fMensagem('','O valor da entrega deve ser maior que Zero !',['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeAlqIss) And blnBuscaPorChave Then
    Begin

      If (fEmptyStr(dbeAlqIss.Text)) Then
        dbeAlqIss.Field.AsFloat := 0.0;

      If (fStrToFloat(dbeAlqIss.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A alíquota de ISS deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;

      dbeRedIss.Enabled := (fStrToFloat(dbeAlqIss.Text) > 0.0);

      If (Not dbeRedIss.Enabled) And (qryTabela.State in DsEditModes) Then
        dbeRedIss.Field.AsFloat := 0.0;
    End

    {Else If (Sender = dbeRedIss) And (dbeRedIss.Enabled) And (dbeRedIss.Visible) Then
    Begin

      If (fEmptyStr(dbeRedIss.Text)) And (qryTabela.State in DsEditModes) Then
        dbeRedIss.Field.AsFloat := 0.0;

      If (fStrToFloat(dbeRedIss.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de Redução da Base de ISS deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End
      Else If (fStrToFloat(dbeRedIss.Text) > 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de Redução da Base de ISS não deve ser maior que 100!', ['&Ok']);
        Result := False;
      End;

    End}

    Else
    If (Sender = dbeVrMSeg) Then
    Begin
      Result := fStrToFloat(TDBEditFocus(Sender).Text) >= 0;
      If not Result Then
        fMensagem('', 'Informe um valor maior ou igual a zero!', ['&OK']);
    End

    Else If (Sender = dbeQtdDia) Then
    Begin
      if dbeQtdDia.visible then
      begin
        Result := (StrToIntDef(dbeQtdDia.Text, -1) >= 0);
        If not Result Then
          fMensagem('', 'A quantidade de dias para entrega deve ser maior ou igual a zero!', ['&OK']);
      end;
    End

    Else
    If (Sender = dbePerSeg) Then
    Begin
      Result := (fStrToFloat(TDBEditFocus(Sender).Text) >= 0) And (fStrToFloat(TDBEditFocus(Sender).Text) <= 100);
      If not Result Then
        fMensagem('', 'Informe um valor entre zero (0) e cem (100)!', ['&OK']);

    End

    Else If (Sender = dbeLimJud) Then
    Begin
      If (fEmptyStr(dbeLimJud.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo "' + lblLimJud.Caption + '" deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else If (Pos(dbeLimJud.Text,'S_N_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo "' + lblLimJud.Caption + '" deve ser (S)im ou (N)ão!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = cbbSitP_C) And cbbSitP_C.Visible Then
    Begin
      If (fEmptyStr(cbbSitP_C.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo "' + lblSitP_C.Caption + '" deve ser preenchido!', ['&OK']);
        Result := False;
      End
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadCidades.FormShow(Sender: TObject);
begin
  inherited;

  If (Not fCfgSis('USACEP', varBoolean)) Then
  Begin
    pnlCodCor.Visible := False;
    lblCodCor.Visible := False;
    dbeCodCor.Visible := False;
  End;

  If (fCfgSis('USIGEP', varString) = 'N') Then
  Begin
    gpbSigepWeb.Visible := False;
    Self.Height := Self.Height - gpbSigepWeb.Height;
  End;

  //Preston
  If Not (fCfgSis('USACCR', VarBoolean) And (fCfgSis('TPNFCR') = PRESTCON)) Then
  Begin
    gpbSIAM.Visible := False;
    Self.Height := Self.Height - gpbSIAM.Height;
  End;

  rdgTaxEnt.Visible := fCfgSis('TAXENT', VarBoolean);

  If Not rdgTaxEnt.Visible Then
    Self.Height := Self.Height - rdgTaxEnt.Height;

  btnReducaoBCISS.Enabled := False;

  pCarregaTributacao;
  pAtualizaTributacao;
end;

procedure TfrmCadCidades.dbeCodCorKeyPress(Sender: TObject; var Key: Char);
  Var
    qryCidade: TUniQuery;
    arrSel : TConsultasArray;
begin
  inherited;

  If Key = '-' Then
    Key := #0;

  qryCidade := fCriaQuery(nil);
  If fPesqCidadeCorr(Self, dbeCodCor, qryCidade, Key, arrSel) Then
  Begin
    If fValidaCampos(dbeCodCor, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;

  FreeAndNil(qryCidade);

end;

procedure TfrmCadCidades.dbeCodIbgeKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryGen: TUniQuery;
    arrSel: TConsultasArray;

begin
  inherited;

  qryGen := fCriaQuery(Self);

  If fPesqMuncIBGE(Self, dbeCodIbge, qryGen, Key, arrSel) Then
  Begin
    If fValidaCampos(dbeCodIbge, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;

  FreeAndNil(qryGen);

end;

procedure TfrmCadCidades.dbeCodPaiKeyPress(Sender: TObject; var Key: Char);
  Var
    qryGen: TUniQuery;
    arrSel: TConsultasArray;

begin
  inherited;
  qryGen := fCriaQuery(Self);

  If fPesqPaises(Self, dbeCodPai, qryGen, Key, arrSel) Then
  Begin
    If fValidaCampos(dbeCodPai, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;

  FreeAndNil(qryGen);

end;

procedure TfrmCadCidades.dbeEstadoExit(Sender: TObject);
begin
  inherited;

  If dbeEstado.Text = 'EX' Then
  Begin
    dbeCodPai.Enabled  := True;
    dbeCodIbge.Enabled := False;
    dbeCodIbge.Text    := '9999999';
    dbeCodPai.Clear;
  End
  Else
  Begin
    dbeCodPai.Enabled  := False;
    dbeCodIbge.Enabled := True;
    dbeCodIbge.Clear;
    dbeCodPai.Text := '1058'; //Código do Brasil

    pSetFocus(dbeCodIbge);
  End;

end;

procedure TfrmCadCidades.dbeLimJudChange(Sender: TObject);
begin
  inherited;
  lblSitP_C.Visible := dbeLimJud.Text = 'S';
  cbbSitP_C.Visible := lblSitP_C.Visible;
end;

procedure TfrmCadCidades.dtsCadCidDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  btnFeriados.Enabled := (dtsCadCid.State = dsBrowse) And (Not fEmptyStr(qryTabela.FieldByName('CID_CODCID').AsString));
end;

function TfrmCadCidades.fValidaCodIbge(strUf, strCodIbge: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;

  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   COUNT(DISTINCT IBG_CODMUN)    QTD ');
  qryGen.SQL.Add(' FROM IBG_CADIBG ');
  qryGen.SQL.Add(' WHERE IBG_CODMUN = :CODMUN ');
  qryGen.SQL.Add('     AND IBG_UF = :UF; ');

  qryGen.ParamByName('CODMUN').AsString := strCodIbge;
  qryGen.ParamByName('UF').AsString := strUf;
  qryGen.Open;

  Result := qryGen.FieldByName('QTD').AsInteger > 0;
  FreeAndNil(qryGen);
end;

procedure TfrmCadCidades.fAtualizaProximoCodigoCidade;
  Var
    qryGen: TUniQuery;
begin

  Try
    qryGen := fCriaQuery;
    qryGen.SQL.Add(' SELECT (MAX(CID_CODCID)+1) AS CODCID FROM CADCID WHERE CID_CODCID <> '+QuotedStr('99999'));
    qryGen.SQL.Add(' AND CID_CODCID <> ' + QuotedStr(qryTabela.FieldByName('CID_CODCID').AsString));
    qryGen.Open;
    qryTabela.Edit;
    qryTabela.FieldByName('CID_CODCID').asString := FormatFloat('00000', qryGen.FieldByName('CODCID').asInteger);
    qryTabela.Post;
  Finally
    FreeAndNil(qryGen);
  End;

end;

function TfrmCadCidades.fAtualizaSituacaoPisCofinsCliente(
  pgbStatus: TcxProgressBar): Boolean;
var
  qryAtualiza: TUniQuery;
begin
  qryAtualiza := fCriaQuery;

  try
    try
      pInformacao('Aguarde... Atualizando Cadastro de Clientes com o tipo de suspensão de cobrança de PIS/COFINS.', pgbStatus);

      qryAtualiza.Close;
      qryAtualiza.SQL.Clear;
      qryAtualiza.SQL.Add('UPDATE CADCLI');
      qryAtualiza.SQL.Add('SET CLI_SITP_C = :PISCOF');
      qryAtualiza.SQL.Add('WHERE CLI_CODCID = :CODCID');

      if (dbeLimJud.Text = 'S') and (cbbSitP_C.Visible) and (cbbSitP_C.ItemIndex > -1) then
        qryAtualiza.ParamByName('PISCOF').AsString := Copy(cbbSitP_C.Text, 1, 1)
      else
        qryAtualiza.ParamByName('PISCOF').AsString := 'T';

      qryAtualiza.ParamByName('CODCID').AsString := dbeCodigo.Text;

      qryAtualiza.ExecSQL;

      Result := True;
    except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fAtualizaSituacaoPisCofinsCliente]');
      End;
    end;
  finally
    FreeAndNil(qryAtualiza);
  end;
end;

end.

