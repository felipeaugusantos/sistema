unit untCadServAtendCliente;

interface

uses
  Windows, Classes, Controls, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, untCadSac, ExtCtrls, DB, QColorLabel, DBCtrls, DBEditFocus, EditFocus,
  Uni,untFuncFat, DBMemoFocus, BitBtnLockedIncrem, Mask, frxClass,
  frxExportCSVTestabilidade, DBComboBoxFocus, ComboBoxFocus;

type
  TfrmCadServAtendCliente = class(TfrmPaiCad)
    dtsCadSac: TDataSource;
    Panel1: TPanel;
    lbl1: TColorLabel;
    lblDtaAtn: TColorLabel;
    lblCliente: TColorLabel;
    lblVendedor: TColorLabel;
    lbProduto: TColorLabel;
    lblQtdIte: TColorLabel;
    lblDescPro: TColorLabel;
    lblDescSol: TColorLabel;
    lblDescRes: TColorLabel;
    dbeCodSac: TDBEditFocus;
    dbeQtdIte: TDBEditFocus;
    dbeCodCli: TDBEditFocus;
    dbeCodVen: TDBEditFocus;
    dbeCodIte: TDBEditFocus;
    dbeCodRes: TDBEditFocus;
    mmoDesPro: TDBMemoFocus;
    mmoDesSol: TDBMemoFocus;
    chkProRes: TDBCheckBox;
    dbeNomCli: TDBEditFocus;
    edtNomVen: TDBEditFocus;
    edtDesIte: TDBEditFocus;
    edtNomRes: TDBEditFocus;
    dbeDtaAtn: TDBEditFocus;
    lblDepVen: TLabel;
    edtDesDep: TEditFocus;
    dbeCodDep: TDBEditFocus;
    ColorLabel1: TColorLabel;
    dbeMotAte: TDBEditFocus;
    edtDesMot: TEditFocus;
    lbNumLot: TColorLabel;
    dbeNumLot: TDBEditFocus;
    btnArquivosDeSac: TBitBtnLocked;
    cmbStatusSac: TDBComboBoxFocus;
    ColorLabel3: TColorLabel;
    ComboBoxFocus1: TComboBoxFocus;
    chkPlanoAcao: TDBCheckBox;
    ColorLabel4: TColorLabel;
    dbeAcao: TDBMemoFocus;
    lblResolvidoEm: TColorLabel;
    dbeResolvidoEm: TDBEditFocus;
    lbLoteProducao: TColorLabel;
    dbeLoteProducao: TDBEditFocus;
    lblDtaSol: TColorLabel;
    dbeDtaSol: TDBEditFocus;
    lblCodTpa: TColorLabel;
    dbeCodTpa: TDBEditFocus;
    edtDesTpa: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure pCodCliKeyPress(var Key: Char);
    procedure dbeCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure pCodVenKeyPress(var Key: Char);
    procedure dbeCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure mmoDesProKeyPress(Sender: TObject; var Key: Char);
    procedure mmoDesSolKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodResKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure chkProResClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbeCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dbeMotAteKeyPress(Sender: TObject; var Key: Char);
    procedure dbeNumLotKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnArquivosDeSacClick(Sender: TObject);
    procedure dtsCadSacStateChange(Sender: TObject);
    procedure chkPlanoAcaoClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbeCodTpaKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    objCadSac : TCadSac;
    procedure pCodResKeyPress(var Key: Char);
    procedure pMotAteKeyPress(var Key: Char);
    procedure pCodIteKeyPress(var Key: Char);

    function fDigInfProd(strCodMot: String): Boolean;

  protected
    procedure pInicializaIndices; Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pAtualizaChaveSEQSACQryAnexos;
  public
    { Public declarations }
    fatVenda : TFatVenda;
    qryAnexos: TUniQuery;
  end;

implementation

uses SysUtils, Forms, Variants, untPai, untFuncoesSimples, untConsultas,
  untTypesSistema, untCadServAtendClienteAnexos;

{$R *.dfm}

procedure TfrmCadServAtendCliente.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadServAtendCliente.FormCreate(Sender: TObject);
begin
  objCadSac := TCadSac.Create(Self);

 inherited;

  strNomeTabela := 'CADSAC';
  strNomeCampo  := 'SAC_CODSAC';
  qryTabela     := objCadSac.qryTabela;
  dtsCadSac.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodSac;

  lblDescRes.Visible := False;
  dbeCodRes.Visible := False;
  edtNomRes.Visible := False;

  lbNumLot.Visible  := False;
  dbeNumLot.Visible := False;

  lbLoteProducao.Visible := (fCfgSis('ORDPRO', varBoolean) or fCfgSis('UTIIND', varBoolean));
  dbeLoteProducao.Visible := lbLoteProducao.Visible;
  qryAnexos := fCriaQuery();
  qryAnexos.CachedUpdates := True;
  qryAnexos.SQL.Add('SELECT * FROM ARQSAC WHERE SAC_SEQSAC = :SEQSAC ORDER BY SAC_DTAANX, SAC_HRAANX');
end;

procedure TfrmCadServAtendCliente.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(qryAnexos) then
  begin
    qryAnexos.Close;
    FreeAndNil(qryAnexos);
  end;
end;

procedure TfrmCadServAtendCliente.FormShow(Sender: TObject);
Var
  strDireitos: String;
begin
  inherited;
  pSetaCodIte( dbeCodIte );

  If fValidarDirEspecificos(strDireitos, strLoginUsuarioLogado, 'frmSacAtedimento') Then
  Begin
    btnIncluir.Visible := Pos('I', strDireitos) > 0;
    btnAlterar.Visible := Pos('A', strDireitos) > 0;
    btnExcluir.Visible := Pos('E', strDireitos) > 0;
  End;

end;

procedure TfrmCadServAtendCliente.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('AUTOINCREM');
  stlCampos.Add('SAC_CODEMP');
  stlCampos.Add('SAC_CODSAC');
  stlCampos.Add('SAC_DTAATN');
  stlCampos.Add('SAC_CODCLI');
  stlCampos.Add('SAC_CODVEN');
  stlCampos.Add('SAC_CODITE');
  stlCampos.Add('SAC_QTDITE');
  stlCampos.Add('SAC_DESPRB');
  stlCampos.Add('SAC_DESSOL');
  stlCampos.Add('SAC_RSLPRO');
  stlCampos.Add('SAC_CODREP');

  stlCamInd.Add('SAC_CODSAC');
  stlDesInd.Add('Código');

end;

procedure TfrmCadServAtendCliente.btnAlterarClick(Sender: TObject);
begin
  inherited;
  mmoDesPro.Enabled := fVerificaAcessoSistema('SACDPO');
  mmoDesSol.Enabled := fVerificaAcessoSistema('SACDRE');
  chkPlanoAcaoClick(nil);

  dbeNumLot.Visible := ((not fEmptyStr(dbeNumLot.Text)) or (fExisteLote(dbeCodIte.Text)));
end;

procedure TfrmCadServAtendCliente.btnArquivosDeSacClick(Sender: TObject);
var
  LfrmAnexos: TfrmCadServAtendClienteAnexos;
begin
  inherited;

  pCriarFormularios(TfrmCadServAtendClienteAnexos, LfrmAnexos);
  try
    qryAnexos.Close;
    qryAnexos.ParamByName('SEQSAC').AsString :=  qryTabela.FieldByName('AUTOINCREM').AsString;
    qryAnexos.Open;
    LfrmAnexos.strSeqSac := qryTabela.FieldByName('AUTOINCREM').AsString;
    LfrmAnexos.qryAnexos := qryAnexos;
    LfrmAnexos.ShowModal;
  finally
    pFreeAndNil(LfrmAnexos);
  end;
end;

procedure TfrmCadServAtendCliente.btnCancelaClick(Sender: TObject);
begin
  inherited;
  dbeNumLot.Visible := ((not fEmptyStr(dbeNumLot.Text)) or (fExisteLote(dbeCodIte.Text)));
end;

procedure TfrmCadServAtendCliente.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadServAtendCliente.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;
procedure TfrmCadServAtendCliente.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  if fEmptyStr(qryTabela.FieldByName('SAC_CODITE').AsString) Then
    qryTabela.FieldByName('SAC_CODITE').Clear;

  If (Not dbeCodRes.Visible) Then
  Begin
    dbeCodRes.Field.Value := Null;
    qryTabela.FieldByName('SAC_NOMREP').AsString := '';
  End;

  if (not dbeAcao.Enabled) then
    qryTabela.FieldByName('SAC_TXTPLA').Value := Null;

  if (not dbeResolvidoEm.Visible) then
    qryTabela.FieldByName('SAC_RESOLV').Value := Null;

  Try
    inherited;
    pAtualizaChaveSEQSACQryAnexos;
  Except
    On E: Exception Do
    Begin
      qryAnexos.RestoreUpdates;
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadServAtendCliente.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadServAtendCliente.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodSac, dbeCodSac, False)
  Else
    pHabilitaCodigo(dbeCodSac, dbeCodSac, True);

  pSetFocus(Self.dbeDtaAtn);
  pLimparCampos;
  edtDesDep.Clear;
  mmoDesPro.Clear;
  mmoDesSol.Clear;
  qryTabela.FieldByName('SAC_RSLPRO').AsString := 'N';
  qryTabela.FieldByName('SAC_DTAATN').AsDateTime := VS_Date;
  qryTabela.FieldByName('SAC_STATUS').AsString := 'Procede';
  qryTabela.FieldByName('SAC_PLACAO').AsString := 'N';

  dbeNumLot.Visible := False;
end;

procedure TfrmCadServAtendCliente.mmoDesProKeyPress(Sender: TObject;
  var Key: Char);
  Var
    strKey : String;
begin
  inherited;

  strKey := Key;
  strKey := AnsiUpperCase(strKey);
  Key    := strKey[1];

end;

procedure TfrmCadServAtendCliente.mmoDesSolKeyPress(Sender: TObject;
  var Key: Char);
  Var
    strKey : String;
begin
  inherited;

  strKey := Key;
  strKey := AnsiUpperCase(strKey);
  Key    := strKey[1];

end;

procedure TfrmCadServAtendCliente.dbeCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    pCodCliKeyPress(Key);
  End;

end;

procedure TfrmCadServAtendCliente.dbeCodDepKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrDepart: TConsultasArray;
begin
  inherited;
  If fPesqDepartamento(Self, dbeCodDep, edtDesDep, Nil, Key, arrDepart, False) Then
  Begin
    If fValidaCampos(dbeCodDep, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadServAtendCliente.dbeCodVenKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    pCodVenKeyPress(Key);
  End;

end;

procedure TfrmCadServAtendCliente.dbeMotAteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pMotAteKeyPress(Key);
end;

procedure TfrmCadServAtendCliente.dbeNumLotKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqLoteItens(Self, dbeNumLot, dbeCodIte, fCfgSis('DECUNI'), Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(dbeNumLot, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadServAtendCliente.dtsCadSacStateChange(Sender: TObject);
begin
  inherited;
  btnArquivosDeSac.Enabled := (dtsCadSac.DataSet.Active) and (not dtsCadSac.DataSet.IsEmpty) and (dtsCadSac.State in [dsInsert, dsEdit]);
end;

function TfrmCadServAtendCliente.fDigInfProd(strCodMot: String): Boolean;
  Var
    strSQL : String;
    qryGen : TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOTATE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  MOT_CODMOT = :CODMOT ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODMOT').AsString := strCodMot;
      Open;

      Result := (qryGen.FieldByName('MOT_DIGINF').AsString = 'S');

      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadServAtendCliente.dbeCodResKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    pCodResKeyPress(Key);
  End;
end;

procedure TfrmCadServAtendCliente.dbeCodTpaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryTpa: TUniQuery;
    arrSel : TConsultasArray;
begin
  inherited;

  qryTpa := fCriaQuery(Self);
  Try
    If fPesqTipoAtendimento(Self, dbeCodTpa, edtDesTpa, qryTpa, Key, arrSel) Then
    Begin
      If fValidaCampos(dbeCodTpa, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryTpa);
  End;
end;

procedure TfrmCadServAtendCliente.dbeCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    pCodIteKeyPress(Key);
  End;
end;


procedure TfrmCadServAtendCliente.pAtualizaChaveSEQSACQryAnexos;
begin
  If (Not qryAnexos.IsEmpty) Then
  Begin
    qryAnexos.First;

    While (Not qryAnexos.Eof) Do
    Begin

      If (fEmptyStr(qryAnexos.FieldByName('SAC_SEQSAC').AsString)) Then
      Begin
        qryAnexos.Edit;
        qryAnexos.FieldByName('SAC_SEQSAC').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
        qryAnexos.Post;
      End;

      qryAnexos.Next;
    End;
    qryAnexos.ApplyUpdates();
  End;
end;

procedure TfrmCadServAtendCliente.pCodCliKeyPress(var Key: Char);
  Var
    qryConCli: TUniQuery;
    arrSel : TConsultasArray;
begin

  If fEntraCons(Key) And (Not dbeCodCli.ReadOnly) Then
  Begin
    Try
      qryConCli := fCriaQuery(Self);

      if fPesqCliente(conCliSimples, Self, dbeCodCli, nil, qryConCli, Key, arrSel) then
      Begin
        If (fValidaCampos(dbeCodCli, True)) and (blnMudarFoco) Then
          pSetFocus(Self.dbeCodVen);
      End;

      FreeAndNil(qryConCli);

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[pCodCliKeyPress]');
    End;
  End;
End;

procedure TfrmCadServAtendCliente.pCodVenKeyPress(var Key: Char);
  Var
    qryConVen: TUniQuery;
    arrSel : TConsultasArray;
begin
  qryConVen := fCriaQuery(Self);

  If fEntraCons(Key) Then
  Begin
    if fPesqOperador(Self, dbeCodVen, nil, qryConVen, Key, arrSel)  then
    Begin

      If fValidaCampos(dbeCodVen) Then
        pSetFocus(Self.dbeMotAte);
    End;
  End;
  qryConVen.Close;
  FreeAndNil(qryConVen);
end;

procedure TfrmCadServAtendCliente.pMotAteKeyPress(var Key: Char);
  Var
    qryConMot: TUniQuery;
    arrSel : TConsultasArray;
begin

  If fEntraCons(Key) Then
  Begin
    qryConMot := fCriaQuery(Self);

    if fPesqMotivosAtend(Self, nil, nil, qryConMot, Key, arrSel)  then
    Begin

      dbeMotAte.Field.Value := qryConMot.FieldByName('MOT_CODMOT').AsString;
      If fValidaCampos(Self.dbeMotAte) Then
      Begin

        If Self.dbeCodIte.Enabled Then pSetFocus(Self.dbeCodIte)
        Else pSetFocus(Self.dbeCodDep);

      End;

    End;

    qryConMot.Close;
    FreeAndNil(qryConMot);
  End;

End;

procedure TfrmCadServAtendCliente.pCodResKeyPress(var Key: Char);
  Var
    qryConVen: TUniQuery;
    arrSel : TConsultasArray;
begin
  qryConVen := fCriaQuery(Self);

  If fEntraCons(Key) Then
  Begin
    if fPesqOperador(Self, dbeCodRes, nil, qryConVen, Key, arrSel) then
    Begin
      If fValidaCampos(dbeCodRes) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
  qryConVen.Close;
  FreeAndNil(qryConVen);
end;

procedure TfrmCadServAtendCliente.btnPesquisaClick(Sender: TObject);
  Var
     arrSel : TConsultasArray;
     chrKey : Char;
begin
  chrKey := '/';
  If fPesqServAtCli(Self, qryTabela, chrKey, arrSel) Then
  Begin

    If (Not fEmptyStr(dbeMotAte.Text)) Then
      edtDesMot.Text := fRetDesMotivoAtend(dbeMotAte.Text);

    If (Not fEmptyStr(dbeCodVen.Text)) Then
      edtDesDep.Text := fRetDescDepartamento(dbeCodDep.Text);

    If (Not fEmptyStr(dbeCodTpa.Text)) Then
      edtDesTpa.Text := fRetNomTipoAtend(dbeCodTpa.Text);

    If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
      pSetFocus(btnAlterar);

    dbeNumLot.Visible := ((not fEmptyStr(dbeNumLot.Text)) or (fExisteLote(dbeCodIte.Text)));
  End;
end;

procedure TfrmCadServAtendCliente.pCodIteKeyPress(var Key: Char);
  Var
    qryConCit: TUniQuery;
    arrSel : TConsultasArray;
Begin
  qryConCit := fCriaQuery(Self);

  {*******************************************}
  {* FILTRO DE PARCIAL/COMPLETE KEY          *}
  {***14/04/2008***************************MV*}

  Try
    if fPesqItem(conIteSimples, Self, dbeCodIte, nil, qryConCit, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
    Begin
       edtDesIte.Text := qryConCit.FieldByName('ITE_DESITE').AsString;

       dbeNumLot.Visible := fExisteLote(dbeCodIte.Text);
       lbNumLot.Visible  := dbeNumLot.Visible;
       if (not dbeNumLot.Visible) then
         dbeNumLot.Clear;

       pSetFocus(Self.dbeNumLot);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCadProdutos.btnPesquisaClick]');
    End;
  End;

  FreeAndNil(qryConCit);
end;

function TfrmCadServAtendCliente.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    {********************************}
    {* VALIDA A DATA DO SAC         *}
    {*****************************PE*}
    If (Sender = dbeDtaAtn) Then
    Begin
      If(fEmptyStr(fTiraCaracEspeciais(dbeDtaAtn.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data do SAC  deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    {**********************************}
    {* VALIDA O CÓDIGO DO CLIENTE     *}
    {*******************************PE*}
    Else If (Sender = dbeCodCli) Then
    Begin
      If (fEmptyStr(dbeCodCli.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do cliente deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        dbeNomCli.Field.Value := fRetNomCliente(dbeCodCli.Text);

        If (fEmptyStr(dbeNomCli.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','Esse cliente não está cadastrado!',['&O k']);
          Result := False;
        End;
      End;
    End

    {*******************************}
    {* VALIDA O CÓDIGO DO VENDEDOR *}
    {****************************PE*}
    Else If (Sender = dbeCodVen) Then
    Begin
      If (fEmptyStr(dbeCodVen.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Vendedor deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtNomVen.Text := fRetNomeOperador(dbeCodVen.Text);

        If (fEmptyStr(edtNomVen.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','Esse vendedor não está cadastrado!',['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeMotAte) Then
    Begin
      If (fEmptyStr(dbeMotAte.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Motivo de Atendimento deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtDesMot.Text := fRetDesMotivoAtend(dbeMotAte.Text);

        If (fEmptyStr(edtDesMot.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','Esse Motivo de Atendimento não está cadastrado!',['&O k']);
          Result := False;
        End
        Else
        Begin

          If fDigInfProd(dbeMotAte.Text) Then
          Begin
            dbeCodIte.Enabled := True;
            dbeQtdIte.Enabled := True;
            dbeNumLot.Visible := fExisteLote(dbeCodIte.Text);
            lbNumLot.Visible  := dbeNumLot.Visible;
            If not dbeNumLot.Visible Then
              dbeNumLot.Clear;

          End
          Else
          Begin
            dbeCodIte.Enabled := False;
            dbeQtdIte.Enabled := False;
            dbeNumLot.Visible := False;
            lbNumLot.Visible  := False;

            dbeCodIte.Clear;
            dbeQtdIte.Clear;
            dbeNumLot.Clear;

            dbeCodIte.Field.Clear;
            dbeQtdIte.Field.Clear;
            dbeNumLot.Field.Clear;

          End;

        End;

      End;
    End

    {******************************}
    {* VALIDA O CÓDIGO DO PRODUTO *}
    {***************************PE*}
    Else If (Sender = dbeCodIte) Then
    Begin

      If fDigInfProd(dbeMotAte.Text) Then
      Begin
        If (fEmptyStr(dbeCodIte.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Código do Produto deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          edtDesIte.Text := fRetNomProduto(dbeCodIte.Text);

          If (fEmptyStr(edtDesIte.Text)) Then
          Begin
            fMensagem('ATENÇÃO!','Esse produto não está cadastrado!',['&O k']);
            Result := False;
          End;

          dbeNumLot.Visible := fExisteLote(dbeCodIte.Text);
          lbNumLot.Visible  := dbeNumLot.Visible;
          If Not dbeNumLot.Visible then
            dbeNumLot.Clear;

        End;
      End;

    End

    Else If (Sender = dbeCodTpa) Then
    Begin
      If (Not fEmptyStr(dbeCodTpa.Text)) Then
      Begin
        edtDesTpa.Text := fRetNomTipoAtend(dbeCodTpa.Text);

        If (fEmptyStr(edtDesTpa.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','Tipo de atendimento não está cadastrado!',['&O k']);
          Result := False;
        End;
      End
      Else
      If (qryTabela.State in dsEditModes) Then
        qryTabela.FieldByName('SAC_CODTPA').Clear;
    End

    Else
    If Sender = dbeNumLot Then
    Begin
      If fDigInfProd(dbeMotAte.Text) Then
      Begin
        if fExisteLote(dbeCodIte.Text) Then
        Begin
          If fEmptyStr(dbeNumLot.Text) Then
          Begin
            Result := False;
            fMensagem('', 'O lote do produto deve ser preenchido!', ['&OK']);
          End
          Else if Not fExisteLote(dbeNumLot.Text, dbeCodIte.Text, VS_strCodEmp) Then
          Begin
            Result := False;
            fMensagem('', 'O lote do produto informado não é válido!', ['&OK']);
          End;
        End;
      End;
    End

    Else If (Sender = dbeQtdIte) Then
    Begin

      If fDigInfProd(dbeMotAte.Text) Then
      Begin

        If (fEmptyStr(dbeQtdIte.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A quantidade do Produto deve ser preenchido!', ['&Ok']);
          Result := False;
        End;

      End;
    End

    {***********************************}
    {* VALIDA O CÓDIGO DO DEPARTAMENTO *}
    {********************************RV*}
    Else If (Sender = dbeCodDep) Then
    Begin
      If (Not fEmptyStr(dbeCodDep.Text)) Then
      Begin
        edtDesDep.Text := fRetDescDepartamento(dbeCodDep.Text);

        If (fEmptyStr(edtDesDep.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','Esse Departamento não está cadastrado!',['&O k']);
          Result := False;
        End;
      End;
    End

    {**********************************}
    {* VALIDA A DESCRIÇÃO DO PROBLEMA *}
    {*******************************PE*}
    Else If (Sender = mmoDesPro) Then
    Begin
      If (fEmptyStr(mmoDesPro.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Problema deve ser preenchida !', ['&Ok']);
        Result := False;
      End;
    End

    {********************************}
    {* VALIDA A SOLUÇÃO DO PROBLEMA *}
    {*****************************PE*}
    Else If (Sender = mmoDesSol) Then
    Begin
      If (fEmptyStr(mmoDesPro.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','A Descrição da Solução do Problema deve ser preenchida mesmo que ainda não tenha Solução !',['&O k']);
        Result := False;
      End;
    End

    {*******************************}
    {* VALIDA O CÓDIGO DO OPERADOR *}
    {****************************PE*}
    Else If (Sender = dbeCodRes) And (chkProRes.Checked = True) Then
    Begin
      If (fEmptyStr(dbeCodRes.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do responsável deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtNomRes.Text := fRetNomeOperador(dbeCodRes.Text);

        If (fEmptyStr(edtNomRes.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','Esse responsável não está cadastrado!',['&O k']);
          Result := False;
        End;
      End;
    End

    else if (Sender = cmbStatusSac) then
    begin
      if (cmbStatusSac.ItemIndex = -1) then
      begin
        fMensagem('ATENÇÃO!','O Status do SAC é obrigatório!',['&O k']);
        Result := False;
      end;
    end

    else if (Sender = dbeAcao) and (dbeAcao.Enabled) then
    begin
      if fEmptyStr(dbeAcao.Text) then
      begin
        fMensagem('ATENÇÃO!','O Status do SAC é obrigatório!',['&O k']);
        Result := False;
      end;
    end

    else if (Sender = dbeResolvidoEm) and (dbeResolvidoEm.Visible) then
    begin
      if(fEmptyStr(fTiraCaracEspeciais(dbeResolvidoEm.Text))) then
      begin
        fMensagem('ATENÇÃO!', 'A Data da Resolução do SAC deve ser preenchida!', ['&Ok']);
        Result := False;
      end
      else if (not fValidaDataStr(dbeResolvidoEm.Text)) then
      begin
        fMensagem('ATENÇÃO!', 'Data da Resolução do SAC inválida!', ['&Ok']);
        Result := False;
      end;
    end;

  End;

  If Not Result Then
    pSetFocus(Sender);

End;

procedure TfrmCadServAtendCliente.chkPlanoAcaoClick(Sender: TObject);
begin
  inherited;
  dbeAcao.Enabled := chkPlanoAcao.Checked;
end;

procedure TfrmCadServAtendCliente.chkProResClick(Sender: TObject);
begin
  inherited;
  lblDescRes.Visible     := chkProRes.Checked;
  dbeCodRes.Visible      := chkProRes.Checked;
  edtNomRes.Visible      := chkProRes.Checked;
  lblResolvidoEm.Visible := chkProRes.Checked;
  dbeResolvidoEm.Visible := chkProRes.Checked;

  If (dbeResolvidoEm.Visible) And
     (qryTabela.FieldByName('SAC_RESOLV').AsDateTime <= 0) And
     (dtsCadSac.State in [dsInsert, dsEdit]) Then
    qryTabela.FieldByName('SAC_RESOLV').AsDateTime := VS_Date;
end;

end.
