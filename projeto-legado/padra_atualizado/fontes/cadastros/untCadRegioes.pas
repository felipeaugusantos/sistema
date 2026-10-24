unit untCadRegioes;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, DBEditFocus, AppEvnts, Uni, DB, BitBtnLockedIncrem, Mask,
  DBCtrls, frxClass, frxExportCSVTestabilidade, MemoFocus, DBMemoFocus, SysUtils,
  Vcl.CheckLst;

type
  TfrmCadRegioes = class(TfrmPaiCad)
    pnlCentral: TPanel;
    dtsCadReg: TDataSource;
    btnHorarios: TBitBtnLocked;
    rdgTaxEnt: TDBRadioGroup;
    grbObservacao: TGroupBox;
    pnlTopo: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    lbl1: TLabel;
    dbeDesReg: TDBEditFocus;
    dbeCodReg: TDBEditFocus;
    dbeValMin: TDBEditFocus;
    gpb1: TGroupBox;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl2: TLabel;
    lbl5: TLabel;
    dbeComInt: TDBEditFocus;
    dbeComExt: TDBEditFocus;
    dbeComDis: TDBEditFocus;
    dbeComOut: TDBEditFocus;
    memObservacao: TDBMemoFocus;
    btnVincularCep: TBitBtnLocked;
    dbeComMot: TDBEditFocus;
    lblComMot: TLabel;
    gpbDiaFatEnt: TGroupBox;
    chkListDiasFat: TCheckListBox;
    chkListDiasEnt: TCheckListBox;
    lblDiaFat: TLabel;
    lblDiaEnt: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnHorariosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rdgTaxEntEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnVincularCepClick(Sender: TObject);
    procedure dtsCadRegStateChange(Sender: TObject);
  private
    { Private declarations }
    qryCadReg: TUniQuery;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pHabilitarBotaoRegiao;

    procedure pPesquisa(strCodRegiao: String = '');
    function fSetaCodRegiaoInformado(strCodRegiao: String = ''): Boolean;
    procedure pCarregaDiasFaturamentoEntrega;
    procedure pGravaDiasFaturamentoEntrega;
    procedure pHabilitaListDiasFaturamentoEntrega;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strCodRegiaoIniciarCadastro : String;
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema, untCadFaiHorRegiao, untPesqAux, untCadVincularCep;

{$R *.dfm}

procedure TfrmCadRegioes.FormCreate(Sender: TObject);
var
  strSQL: String;
begin
  inherited;
  strCodRegiaoIniciarCadastro := '';
  strNomeTabela     := 'CADREG';
  strNomeCampo      := 'REG_CODREG';

  strSQL            := 'SELECT * FROM CADREG';
  qryCadReg         := fCriarQuery(strSQL, Self);
  qryTabela         := qryCadReg;
  dtsCadReg.DataSet := qryTabela;

  qryTabela.AfterOpen := pAfterOpen;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodReg;

  btnHorarios.Visible := fCfgSis('TAXENT', VarBoolean);

  If (fCfgSis('FRETRA') <> '5') Then
  Begin
    grbObservacao.Visible := False;
    memObservacao.Visible := False;
    Self.Height := Self.Height - grbObservacao.Height + 7;
  End;

  rdgTaxEnt.Visible   := fCfgSis('TAXENT', VarBoolean);
  If Not rdgTaxEnt.Visible Then
    Self.Height := Self.Height - rdgTaxEnt.Height;

  dbeComMot.Visible := fCfgSis('REGCMT', varBoolean);
  lblComMot.Visible := dbeComMot.Visible;

  gpbDiaFatEnt.Visible := fCfgSis('DIAFER', varBoolean);
  if not gpbDiaFatEnt.Visible then
    Self.Height := Self.Height - gpbDiaFatEnt.Height;
end;

procedure TfrmCadRegioes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: If ActiveControl Is TRadioButton Then
               Begin
                 Key := 0;
                 SelectNext(ActiveControl, True, True);
               end;
    VK_F3: If btnHorarios.Enabled And btnHorarios.Visible Then
             btnHorarios.Click;
  End;
end;

procedure TfrmCadRegioes.FormShow(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(strCodRegiaoIniciarCadastro) Then
    Self.pPesquisa(strCodRegiaoIniciarCadastro);
end;

procedure TfrmCadRegioes.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pHabilitarBotaoRegiao;
  pHabilitaListDiasFaturamentoEntrega;
end;

procedure TfrmCadRegioes.pHabilitaListDiasFaturamentoEntrega;
var
  blnEnabled: Boolean;
begin
  blnEnabled := (Not qryTabela.IsEmpty) And
                ((qryTabela.State = dsEdit) or (qryTabela.State = dsInsert));

  chkListDiasFat.Enabled := blnEnabled;
  chkListDiasEnt.Enabled := blnEnabled;
end;

procedure TfrmCadRegioes.pHabilitarBotaoRegiao;
begin
  inherited;
  btnHorarios.Enabled := (Not qryTabela.IsEmpty) And
                         (qryTabela.State = dsBrowse) And
                         (qryTabela.FieldByName('REG_COBTAX').AsString = 'P');
end;

procedure TfrmCadRegioes.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadRegioes.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pHabilitarBotaoRegiao;
  pHabilitaListDiasFaturamentoEntrega;
end;

procedure TfrmCadRegioes.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    pGravaDiasFaturamentoEntrega;
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadRegioes.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  pHabilitarBotaoRegiao;
  pHabilitaListDiasFaturamentoEntrega;
end;

procedure TfrmCadRegioes.btnHorariosClick(Sender: TObject);
var
  frmCadFaiHorRegiao: TfrmCadFaiHorRegiao;
begin
  inherited;
  Try
    pCriarFormularios(TfrmCadFaiHorRegiao, frmCadFaiHorRegiao);
    frmCadFaiHorRegiao.strCodReg := qryTabela.FieldByName('REG_CODREG').AsString;
    frmCadFaiHorRegiao.ShowModal;
  Finally
    pFreeAndNil(frmCadFaiHorRegiao);
  End;
end;

procedure TfrmCadRegioes.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodReg, dbeDesReg, False)
  Else
    pHabilitaCodigo(dbeCodReg, dbeDesReg, True);

  pHabilitarBotaoRegiao;
  pHabilitaListDiasFaturamentoEntrega;

  dbeComInt.Field.AsFloat  := 0;
  dbeComExt.Field.AsFloat  := 0;
  dbeComOut.Field.AsFloat  := 0;
  dbeComDis.Field.AsFloat  := 0;
  dbeComMot.Field.AsFloat  := 0;
  dbeValMin.Field.AsFloat  := 0;
  rdgTaxEnt.Field.AsString := 'I';
  memObservacao.Field.Clear;
end;

procedure TfrmCadRegioes.btnPesquisaClick(Sender: TObject);
begin
  Self.pPesquisa;
end;

procedure TfrmCadRegioes.btnVincularCepClick(Sender: TObject);
var
  frmCadVincularCep: TfrmCadVincularCep;
begin
  inherited;
  Try
    pCriarFormularios(TfrmCadVincularCep, frmCadVincularCep);
    frmCadVincularCep.strCodRegiao := dbeCodReg.text;
    frmCadVincularCep.ShowModal;
  Finally
    pFreeAndNil(frmCadVincularCep);
  End;
end;

procedure TfrmCadRegioes.dtsCadRegStateChange(Sender: TObject);
begin
  Inherited;

  btnVincularCep.Visible := (dtsCadReg.State in [dsEdit]) And fCfgSis('CEPREG', VarBoolean);
end;
procedure TfrmCadRegioes.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodReg, dbeDesReg, False);
  pHabilitarBotaoRegiao;
  pHabilitaListDiasFaturamentoEntrega;
end;

function TfrmCadRegioes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = dbeCodReg) Then
  Begin
    If (fEmptyStr(dbeCodReg.Text)) And (dbeCodReg.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código da Região deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (blnBuscaPorChave) Then
    Begin
      If Not fBuscaPorCamposChave Then
        pLimparCampos;
    End;
  End

  Else If (Sender = dbeDesReg) Then
  Begin
    If fEmptyStr(dbeDesReg.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Descrição da Região deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeComInt) Then
  Begin
    If Not fEmptyStr(dbeComInt.Text) Then
    Begin
      If Not fValidaEscala(dbeComInt.Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Comissão de vendedor Interno deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End
    Else
      dbeComInt.Field.AsFloat := 0;
  End

  Else If (Sender = dbeComExt) Then
  Begin
    If Not fEmptyStr(dbeComExt.Text) Then
    Begin
      If Not fValidaEscala(dbeComExt.Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Comissão de vendedor Externo deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End
    Else
      dbeComExt.Field.AsFloat := 0;
  End

  Else If (Sender = dbeComOut) Then
  Begin
    If Not fEmptyStr(dbeComOut.Text) Then
    Begin
      If Not fValidaEscala(dbeComOut.Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Comissão de Outros deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End
    Else
      dbeComOut.Field.AsFloat := 0;
  End

  Else If (Sender = dbeComMot) And (dbeComMot.Visible) Then
  Begin
    If Not fEmptyStr(dbeComMot.Text) Then
    Begin
      If Not fValidaEscala(dbeComMot.Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Comissão do Motorista deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End
    Else
      dbeComMot.Field.AsFloat := 0;
  End

  {*******************************}
  {* VALOR MINIMO DE FATURAMENTO *}
  {****************************RV*}
  Else If (Sender = dbeValMin) Then
  Begin
    If Not fEmptyStr(dbeValMin.Text) Then
    Begin
      If (fStrToFloat(dbeValMin.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor mínimo de Faturamento deve ser maior ou igual a 0!', ['&Ok']);
        Result := False;
      End;
    End
    Else
      dbeValMin.Field.AsFloat := 0;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadRegioes.pAfterOpen(DataSet: TDataSet);
begin
  TFloatField(qryTabela.FieldByName('REG_COMINT')).DisplayFormat := ',0.00';
  TFloatField(qryTabela.FieldByName('REG_COMEXT')).DisplayFormat := ',0.00';
  TFloatField(qryTabela.FieldByName('REG_COMDIS')).DisplayFormat := ',0.00';
  TFloatField(qryTabela.FieldByName('REG_COMOUT')).DisplayFormat := ',0.00';
  TFloatField(qryTabela.FieldByName('REG_COMMOT')).DisplayFormat := ',0.00';
  TFloatField(qryTabela.FieldByName('REG_MINFAT')).DisplayFormat := ',0.00';

  TFloatField(qryTabela.FieldByName('REG_COMINT')).EditFormat    := ',0.00';
  TFloatField(qryTabela.FieldByName('REG_COMEXT')).EditFormat    := ',0.00';
  TFloatField(qryTabela.FieldByName('REG_COMDIS')).EditFormat    := ',0.00';
  TFloatField(qryTabela.FieldByName('REG_COMOUT')).EditFormat    := ',0.00';
  TFloatField(qryTabela.FieldByName('REG_COMMOT')).EditFormat    := ',0.00';
  TFloatField(qryTabela.FieldByName('REG_MINFAT')).EditFormat    := ',0.00';
end;

procedure TfrmCadRegioes.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('REG_CODREG');
  stlCampos.Add('REG_DESREG');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('REG_DESREG');
  stlCamInd.Add('REG_CODREG');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadRegioes.pPesquisa(strCodRegiao: String = '');
  var
    chrKey: Char;
    arrRegiao : TConsultasArray;
begin
  chrKey := '/';
  If fSetaCodRegiaoInformado(strCodRegiao) or
     fPesqRegiao(Self, Nil, Nil, qryTabela, chrKey, arrRegiao) Then
    pSetFocus(btnAlterar);

  pHabilitarBotaoRegiao;
  pHabilitaListDiasFaturamentoEntrega;
  pCarregaDiasFaturamentoEntrega;
end;

procedure TfrmCadRegioes.pCarregaDiasFaturamentoEntrega;
Var
  intDiaFix: Integer;
  strDiaFix: String;
begin
  if not gpbDiaFatEnt.Visible then
    Exit;

  strDiaFix := fPadR(qryTabela.FieldByName('REG_DIAFAT').AsString, chkListDiasFat.Items.Count, 'N');
  For intDiaFix := 0 To chkListDiasFat.Items.Count -1 Do
    chkListDiasFat.Checked[intDiaFix] := (strDiaFix[Succ(intDiaFix)] = 'S');

  strDiaFix := fPadR(qryTabela.FieldByName('REG_DIAENT').AsString, chkListDiasEnt.Items.Count, 'N');
  For intDiaFix := 0 To chkListDiasEnt.Items.Count -1 Do
    chkListDiasEnt.Checked[intDiaFix] := (strDiaFix[Succ(intDiaFix)] = 'S');
end;

procedure TfrmCadRegioes.pGravaDiasFaturamentoEntrega;
Var
  intDiaFix: Integer;
  strDiaFix: String;
begin
  if not gpbDiaFatEnt.Visible then
    Exit;

  strDiaFix := EmptyStr;
  For intDiaFix := 0 To chkListDiasFat.Items.Count -1 Do
    strDiaFix := strDiaFix + IIF(chkListDiasFat.Checked[intDiaFix], 'S', 'N');
  qryTabela.FieldByName('REG_DIAFAT').AsString := strDiaFix;

  strDiaFix := EmptyStr;
  For intDiaFix := 0 To chkListDiasEnt.Items.Count -1 Do
    strDiaFix := strDiaFix + IIF(chkListDiasEnt.Checked[intDiaFix], 'S', 'N');
  qryTabela.FieldByName('REG_DIAENT').AsString := strDiaFix;
end;

function TfrmCadRegioes.fSetaCodRegiaoInformado(strCodRegiao: String = ''): Boolean;
begin
  Result := False;
  If Not fEmptyStr(strCodRegiao) Then
  Begin
    pPesquisaCadReg(qryTabela, qryTabela, strCodRegiao);
    Result := True;
  End;
end;

procedure TfrmCadRegioes.rdgTaxEntEnter(Sender: TObject);
begin
  inherited;
  If rdgTaxEnt.ItemIndex = -1 Then rdgTaxEnt.ItemIndex := 0;
  pSetFocus(TWinControl(rdgTaxEnt.Controls[rdgTaxEnt.ItemIndex]));
end;

end.

