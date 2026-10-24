unit untCadArmazem;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, ComCtrls, StdCtrls,
  ExtCtrls, DBEditFocus, DB, Uni, untCadLote, BitBtnLockedIncrem, Mask, DBCtrls,
  Menus, Buttons, frxClass, frxExportCSVTestabilidade, EditFocus, SysUtils;

type
  TfrmCadArmazem = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodAmz: TDBEditFocus;
    dtsCadAMZ: TDataSource;
    pnlReplicacao: TPanel;
    grbReplicacao: TGroupBox;
    chkPriPro: TDBCheckBox;
    chkArmPrC: TDBCheckBox;
    chkGarPri: TDBCheckBox;
    chkArmPri: TDBCheckBox;
    chkPriTin: TDBCheckBox;
    chkReplicar: TDBCheckBox;
    chkPriInd: TDBCheckBox;
    chkArmOPV: TDBCheckBox;
    Label3: TLabel;
    dbeCodEmp: TDBEditFocus;
    dbeCodResp: TDBEditFocus;
    lblResp: TLabel;
    edtNomResp: TEditFocus;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure chkReplicarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCodRespKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    objCadLot: TCadLot;

    procedure pAjustarComponentesReplicacao(blnChecked: Boolean);
    procedure pCarregaResponsavel;
    function fValidaReplicacao: Boolean;
    function fGetCaptionFlagMarcada: String;

  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadArmazem.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodAmz, dbeDescri, False);
  pAjustarComponentesReplicacao((qryTabela.FieldByName('AMZ_REPAMZ').AsString = 'S'));
end;

procedure TfrmCadArmazem.btnCancelaClick(Sender: TObject);
begin
  inherited;
  edtNomResp.Clear;
  pAjustarComponentesReplicacao((qryTabela.FieldByName('AMZ_REPAMZ').AsString = 'S'));
end;

procedure TfrmCadArmazem.btnExcluirClick(Sender: TObject);
  Var
    strLocFis: String;
begin
  If objCadLot.fTemLocFisicaComArmazem(dbeCodAmz.Text, strLocFis) Then
    pMensagemOk('Armazém não pode ser excluido, pois existem Localizações Fisica '+
    'cadastradas com esse armazém!' + '(' + strLocFis + ')')
  Else
  Begin
    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

    Try
      inherited;
    Except
      fRollBack;
    End;

    If blnExcluiu Then
      fCommit
    Else
      fRollBack;
  End;
end;

procedure TfrmCadArmazem.btnGravarClick(Sender: TObject);
begin
  If blnUsaProCodigo = False Then
  Begin
    If (Length(dbeCodAmz.Text) < 3) Then
    Begin
      fMensagem('ATENÇÃO!', 'O código do armazém deve ser preenchido com 3 caracteres!', ['&Ok']);
      pSetFocus(dbeCodAmz);
      Exit;
    End;
  End;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  If Not fValidaReplicacao then
    Exit;


  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    fRollBack;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadArmazem.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodAmz, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodAmz, dbeCodAmz, True);

  qryTabela.FieldByName('AMZ_CODEMP').AsString := VS_strCodEmp;
  qryTabela.FieldByName('AMZ_REPAMZ').AsString := 'N';
  qryTabela.FieldByName('AMZ_PRIPRO').AsString := 'N';
  qryTabela.FieldByName('AMZ_PRIIND').AsString := 'N';
  qryTabela.FieldByName('AMZ_ARMPRC').AsString := 'N';
  qryTabela.FieldByName('AMZ_GARPRI').AsString := 'N';
  qryTabela.FieldByName('AMZ_ARMPRI').AsString := 'N';
  qryTabela.FieldByName('AMZ_PRITIN').AsString := 'N';

  edtNomResp.Clear;

  pAjustarComponentesReplicacao(False);
end;

procedure TfrmCadArmazem.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrAmz: TConsultasArray;
begin
  chrKey := '/';
  If fPesqArmazem(Self, Nil, Nil, qryTabela, chrKey, arrAmz) Then
  Begin
    pCarregaResponsavel;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadArmazem.chkReplicarClick(Sender: TObject);
begin
  inherited;

  pAjustarComponentesReplicacao(chkReplicar.Checked);

  If (Not chkReplicar.Checked) And (dtsCadAMZ.State In [dsInsert, dsEdit]) Then Begin
    chkPriPro.Checked := False;
    chkPriInd.Checked := False;
    chkArmPrC.Checked := False;
    chkGarPri.Checked := False;
    chkArmPri.Checked := False;
    chkArmOPV.Checked := False;
    chkPriTin.Checked := False;
  End;
end;

procedure TfrmCadArmazem.edtCodRespKeyPress(Sender: TObject; var Key: Char);
Var
  arrOpe: TConsultasArray;
begin
  inherited;
    
    if fPesqOperador(Self, dbeCodResp, edtNomResp, nil, Key, arrOpe) then
    Begin
      If fValidaCampos(dbeCodResp, False) Then
        SelectNext(ActiveControl, True, True);
    End;
end;

procedure TfrmCadArmazem.pCarregaResponsavel;
Begin
  edtNomResp.Text := fRetNomeOperador(dbeCodResp.Text);

  If (Not fEmptyStr(dbeCodResp.Text) And fEmptyStr(edtNomResp.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Código do operador responsável não localizado!', ['&Ok']);
    dbeCodResp.Clear;
  End;
End;

procedure TfrmCadArmazem.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela         := 'CADAMZ';
  strNomeCampo          := 'AMZ_CODAMZ';

  qryTabela             := fCriaQuery(Self);
  dtsCadAMZ.DataSet     := qryTabela;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0]     := dbeCodAmz;
  arrCamposChave[1]     := dbeCodEmp;

  objCadLot := TCadLot.Create(Self);
end;

procedure TfrmCadArmazem.FormShow(Sender: TObject);
begin
  inherited;

  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  pnlReplicacao.Visible := (fCfgSis('REPLOT', varBoolean)) And (fCfgSis('CTLEST', varString) = '2');

  dbeCodResp.Visible    := fCfgSis('AMZRES', varBoolean);
  edtNomResp.Visible    := dbeCodResp.Visible;
  lblResp.Visible       := dbeCodResp.Visible;

  If (Not pnlReplicacao.Visible) Then
    Self. Height := Self.Height - (pnlReplicacao.Height-5)
  Else
    pAjustarComponentesReplicacao(False);
end;

procedure TfrmCadArmazem.pAjustarComponentesReplicacao(blnChecked: Boolean);
begin
  chkPriPro.Enabled := (blnChecked) And (dtsCadAMZ.State In [dsInsert, dsEdit]);
  chkPriInd.Enabled := (blnChecked) And (dtsCadAMZ.State In [dsInsert, dsEdit]);
  chkArmPrC.Enabled := (blnChecked) And (dtsCadAMZ.State In [dsInsert, dsEdit]);
  chkGarPri.Enabled := (blnChecked) And (dtsCadAMZ.State In [dsInsert, dsEdit]);
  chkArmPri.Enabled := (blnChecked) And (dtsCadAMZ.State In [dsInsert, dsEdit]);
  chkArmOPV.Enabled := (blnChecked) And (dtsCadAMZ.State In [dsInsert, dsEdit]);
  chkPriTin.Enabled := (blnChecked) And (dtsCadAMZ.State In [dsInsert, dsEdit]);

  chkPriPro.Visible := (Not fCfgSis('UTIIND', varBoolean));
  chkPriInd.Visible := (fCfgSis('UTIIND', varBoolean));
  chkArmPri.Visible := (Not fUsaRotinaWMS());
  chkArmOPV.Visible := (Not fUsaRotinaWMS());
  chkPriTin.Visible := (fUsaRotinaWMS());
end;

procedure TfrmCadArmazem.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('AMZ_CODAMZ');
  stlCampos.Add('AMZ_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('AMZ_DESCRI');
  stlCamInd.Add('AMZ_CODAMZ');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

function TfrmCadArmazem.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    intChecked: Integer;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodAMZ) Then
    Begin
      If (fEmptyStr(dbeCodAMZ.Text)) And (dbeCodAMZ.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do armazém deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos
        Else
          pCarregaResponsavel;
      End;
    End

    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição do armazém deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCodResp) Then
    Begin
      If (dbeCodResp.Visible) And (Not fEmptyStr(dbeCodResp.Text)) Then
      Begin
        pCarregaResponsavel;
        If fEmptyStr(edtNomResp.Text) Then
          Result := False;
      End;
    End

    Else If (
              (Sender = chkReplicar) Or
              (Sender = chkPriPro) Or
              (Sender = chkArmPrC) Or
              (Sender = chkGarPri) Or
              (Sender = chkArmPri) Or
              (Sender = chkArmOPV) Or
              (Sender = chkPriInd) Or
              (Sender = chkPriTin)
            ) And (chkReplicar.Checked) Then Begin

      intChecked := 0;

      If (chkPriPro.Checked) Then
        intChecked := intChecked + 1;

      If (chkArmPrC.Checked) Then
        intChecked := intChecked + 1;

      If (chkGarPri.Checked) Then
        intChecked := intChecked + 1;

      If (chkArmPri.Checked) Then
        intChecked := intChecked + 1;

      If (chkArmOPV.Checked) Then
        intChecked := intChecked + 1;

      If (chkPriTin.Checked) Then
        intChecked := intChecked + 1;

      If (chkPriInd.Checked) Then
        intChecked := intChecked + 1;

      If (intChecked = 0) Then Begin
        fMensagem('ATENÇÃO!', 'Ao menos um tipo de Armazém deve ser selecionado para a replicação!', ['&OK']);
        Result := False;
      End Else If (intChecked > 1) Then Begin
        fMensagem('ATENÇÃO!', 'Somente um tipo de Armazém deve ser selecionado para a replicação!', ['&OK']);
        Result := False;
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;


function TfrmCadArmazem.fGetCaptionFlagMarcada: String;
begin
  Result := '';
  If chkPriPro.Checked Then
    Exit(chkPriPro.Caption)
  Else If chkArmPrC.Checked Then
    Exit(chkArmPrC.Caption)
  Else If chkGarPri.Checked Then
    Exit(chkGarPri.Caption)
  Else If chkArmPri.Checked Then
    Exit(chkArmPri.Caption)
  Else If chkPriTin.Checked Then
    Exit(chkPriTin.Caption)
  Else If chkPriInd.Checked Then
    Exit(chkPriInd.Caption)

End;

function TfrmCadArmazem.fValidaReplicacao: Boolean;
var qry: TUniQuery;
  strAmazens, strField: String ;

begin
  If Not chkReplicar.Checked Then
    Exit(True);


  strField :='';

  If chkPriPro.Checked Then
    strField := 'AMZ_PRIPRO';
  If chkArmPrC.Checked Then
    strField := 'AMZ_ARMPRC';
  If chkGarPri.Checked Then
    strField := 'AMZ_GARPRI';
  If chkArmPri.Checked Then
    strField := 'AMZ_ARMPRI';
  If chkPriTin.Checked Then
    strField := 'AMZ_PRITIN';
  If chkPriInd.Checked Then
    strField := 'AMZ_PRIIND';

  If strField = '' Then
    Exit(True);

  qry := fCriaQuery;
  try
    qry.SQL.Add('SELECT ' + strField + ', AMZ_CODAMZ');
    qry.SQL.Add('  FROM CADAMZ');
    qry.SQL.Add('WHERE AMZ_REPAMZ = "S"');
    qry.SQL.Add('  AND AMZ_CODEMP = "'+VS_strCodEmp+'"');
    qry.SQL.Add('  AND ' + strField + ' = "S"');

    qry.Open;

    If qry.IsEmpty Then
      Exit(True);


    Result := False;
    strAmazens := '';
    while not qry.Eof Do
    Begin
      strAmazens := strAmazens + IIf(strAmazens <> '', ',', '') + qry.FieldByName('AMZ_CODAMZ').AsString;
      qry.Next;
    End;

    pMensagemOk('Existe(m) outro(s) Armazen(s) com esta configuração('+fGetCaptionFlagMarcada+'). Armazens: [' + strAmazens + ']');

  Finally
    FreeAndNil(qry);
  End;
end;

end.

