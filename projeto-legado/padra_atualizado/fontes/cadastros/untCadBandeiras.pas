unit untCadBandeiras;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, DBCtrls, DBEditFocus, untCadBan, DB,
  BitBtnLockedIncrem, Mask, frxClass, frxExportCSVTestabilidade, EditFocus,
  Datasnap.DBClient, UniClientDataSet, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, MemDS, DBAccess, Uni,
  cxRadioGroup;

type
  TfrmCadBandeiras = class(TfrmPaiCad)
    pnlDados: TPanel;
    Label1: TLabel;
    dbeCodBan: TDBEditFocus;
    Label4: TLabel;
    dbeNomBan: TDBEditFocus;
    dtsCadBan: TDataSource;
    edtDesPlaNco: TEditFocus;
    dbePlaNco: TDBEditFocus;
    lblDesPlaCon: TLabel;
    btnPlaNco: TBitBtnLocked;
    gbCnfTef: TGroupBox;
    pnlBotoesTef: TPanel;
    GridTefView: TcxGridDBTableViewCitel;
    GridTefLevel1: TcxGridLevel;
    GridTef: TcxGridCitel;
    dtsCnfTef: TDataSource;
    btnIncluirDadosEmpresa: TBitBtnLocked;
    btnAlterarDadosEmpresa: TBitBtnLocked;
    btnExcluirDadosEmpresa: TBitBtnLocked;
    GridTefViewAUTOINCREM: TcxGridDBColumn;
    GridTefViewBAN_SEQBAN: TcxGridDBColumn;
    GridTefViewBAN_TFTBAN: TcxGridDBColumn;
    GridTefViewBAN_TFBAN2: TcxGridDBColumn;
    GridTefViewBAN_TIPCAR: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbePlaNcoKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPlaNcoClick(Sender: TObject);
    procedure pRedimencionarFormulario ;
    procedure FormShow(Sender: TObject);
    procedure btnIncluirDadosEmpresaClick(Sender: TObject);
    procedure btnAlterarDadosEmpresaClick(Sender: TObject);
    procedure btnExcluirDadosEmpresaClick(Sender: TObject);
  private
    { Private declarations }
    objCadBan: TCadBandeira;
    blnUtiCon : boolean;
    FcdsNCO : TUniClientDataset;
    FcdsCadBnD : TUniClientDataset;
    procedure pCarregaPlanoContabil(const blnBuscaPorChave: Boolean=False);
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pHabilitarCnfTef(AblnHabilitar: Boolean);
    procedure pCarregaDadosCnfTef(const AStrAutoInc: String);
    procedure pChamaTelaCnfTef(const AblnModoInsert: Boolean);
    procedure pGravaDadosCnfTef(const AStrAutoInc: String);
    function fValidaDadosCnfTef(const AStrAutoInc: String): Boolean;
    function fCadastroCartaoParamAutTefCadBan: Boolean ;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
    strCodBanIniciarCadastro: String;
  end;


implementation

{$R *.dfm}

uses SysUtils, untfuncoesSimples, untPai, untConsultas, untTypesSistema,
  Contabilidade.Consultas, Contabilidade.Funcoes, Variants,
  untCadBandeirasCnfTef, untRegrasCadastroCartaoTef;

procedure TfrmCadBandeiras.FormCreate(Sender: TObject);
begin
  objCadBan := TCadBandeira.Create(Self);

  inherited;
  Self.Height := 128 ;
  FcdsNCO := fCriaEstruturaCdsNCO(Nil);
  strNomeTabela := 'CADBAN';
  strNomeCampo  := 'BAN_CODBAN';
  qryTabela     := objCadbAN.qryTabela;
  qryTabela.AfterOpen := pAfterOpen;
  dtsCadBan.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodBan;

  blnUtiCon := fCfgSis('UTICON', varBoolean);

  If (blnUtiCon) and (Assigned(qryTabela.FindField('BAN_PLANCO'))) Then
  Begin
    lblDesPlaCon.Visible := True;
    dbePlaNco.Visible := True;
    edtDesPlaNco.Visible := True;
    dbePlaNco.DataField := 'BAN_PLANCO';
    dbePlaNco.DataSource := dtsCadBan;
    btnPlaNco.Visible := True;
    Self.Height := Self.Height + 25 ;
  end ;

  pRedimencionarFormulario;
end;

procedure TfrmCadBandeiras.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objCadBan);
  if Assigned(FcdsNCO) then
    FreeAndNil(FcdsNCO) ;
  If Assigned(FcdsCadBnD) Then
    FreeAndNil(FcdsCadBnD);
  inherited;
end;

procedure TfrmCadBandeiras.FormShow(Sender: TObject);
begin
  inherited;
  pHabilitarCnfTef(False);
  If Not fEmptyStr(strCodBanIniciarCadastro) Then
  Begin
    Try
      dbeCodBan.Text := strCodBanIniciarCadastro;
      fValidaCampos(dbeCodBan, True);
    Finally
      strCodBanIniciarCadastro := '';
    End;
  End;
end;

function TfrmCadBandeiras.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    Try

      If (Sender = dbeCodBan) Then
      Begin
        If dbeCodBan.Enabled Then
          objCadBan.strCodBan := dbeCodBan.Text;

        If blnBuscaPorChave Then
        Begin
          If Not fBuscaPorCamposChave Then
          Begin
            pLimparCampos;
          End
          Else
          Begin
            dbeCodBan.Enabled := False;
            If dbeNomBan.Enabled Then
            Begin
              pSetFocus(dbeNomBan);
              blnMudarFoco := False;
            End;
          End;
        End

      End

      Else If (Sender = dbeNomBan) Then
      Begin
        objCadBan.strNomBan := dbeNomBan.Text;
      End

      Else If (Sender = dbePlaNco) Then
      Begin
        if (dbePlaNco.Visible) then
        begin
          pCarregaPlanoContabil(blnBuscaPorChave);
          If (Not fEmptyStr(dbePlaNco.Text)) And (fEmptyStr(edtDesPlaNco.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Plano contábil inexistente!', ['&OK']);
            Result := False;
          End
          Else If (qryTabela.State In [dsInsert, dsEdit]) Then
          begin
            If fEmptyStr(edtDesPlaNco.Text) Then
              dbePlaNco.Field.Value := Null
            Else
              dbePlaNco.Field.AsString := fSemMascaraPlaNco(dbePlaNco.Text);
          End;
        end
        else if (Assigned(dbePlaNco.Field)) then
          dbePlaNco.Field.Value := Null;
      End;

    Except
      On E: Exception Do
      Begin
        fMensagem('',E.Message,['&OK']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmCadBandeiras.fValidaDadosCnfTef(
  const AStrAutoInc: String): Boolean;
var
  LqryVerif: TUniQuery;
  LstrTftBan: String;
begin
  Result := False ;

  if not fCadastroCartaoParamAutTefCadBan then
    Exit(True) ;

  if fEmptyStr(AStrAutoInc) then
    Exit(True) ;

  LqryVerif := fCriaQuery() ;
  try
    LqryVerif.Close ;
    LqryVerif.SQL.Clear ;
    LqryVerif.SQL.Add(' SELECT CADBAN.BAN_CODBAN, CADBAN.BAN_NOMBAN, CADBND.BAN_TFTBAN, CADBND.BAN_TFBAN2 ') ;
    LqryVerif.SQL.Add(' FROM CADBAN INNER JOIN CADBND ON CADBAN.AUTOINCREM = CADBND.BAN_SEQBAN ') ;
    LqryVerif.SQL.Add(' WHERE CADBAN.AUTOINCREM <> :SEQBAN ') ;
    LqryVerif.ParamByName('SEQBAN').AsString := AStrAutoInc ;
    LqryVerif.Open ;

    LstrTftBan := '' ;
    FcdsCadBnD.First ;
    while not FcdsCadBnD.Eof do
    begin
      LstrTftBan := FcdsCadBnD.FieldByName('BAN_TFTBAN').AsString ;
      if (not fEmptyStr(LstrTftBan)) and (LqryVerif.Locate('BAN_TFTBAN', LstrTftBan, [loCaseInsensitive])) then
      begin
        fMensagem('ATENÇÃO!', format('Cód. Bandeira Fiserv-ClisiTef [%s] já associada na bandeira [%s - %s]!', [LstrTftBan, LqryVerif.FieldByName('BAN_CODBAN').AsString, LqryVerif.FieldByName('BAN_NOMBAN').AsString]), ['&OK']);
        Exit ;
      end ;

      LstrTftBan := FcdsCadBnD.FieldByName('BAN_TFBAN2').AsString ;
      if (not fEmptyStr(LstrTftBan)) and (LqryVerif.Locate('BAN_TFBAN2', LstrTftBan, [loCaseInsensitive])) then
      begin
        fMensagem('ATENÇÃO!', format('Cód. Bandeira ConexãoTech-Scope [%s] já associada na bandeira [%s - %s]!', [LstrTftBan, LqryVerif.FieldByName('BAN_CODBAN').AsString, LqryVerif.FieldByName('BAN_NOMBAN').AsString]), ['&OK']);
        Exit ;
      end ;
      FcdsCadBnD.Next ;
    end ;

  finally
    FreeAndNil(LqryVerif) ;
  end ;
  Result := True ;
end;

procedure TfrmCadBandeiras.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BAN_NOMBAN');
  stlCampos.Add('BAN_CODBAN');

  stlCamInd.Add('BAN_NOMBAN');
  stlCamInd.Add('BAN_CODBAN');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadBandeiras.btnAlterarDadosEmpresaClick(Sender: TObject);
begin
  inherited;
  if FcdsCadBnD.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Registro não selecionado!', ['&OK']);
    exit ;
  end ;

  pChamaTelaCnfTef(False) ;
end;

procedure TfrmCadBandeiras.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaPlanoContabil;
  pHabilitarCnfTef(False);
  pCarregaPlanoDeContasPorEmpresa('BANNCO', dbeCodBan.Text, FcdsNCO);
  pCarregaDadosCnfTef(qryTabela.FieldByName('AUTOINCREM').AsString) ;
end;

procedure TfrmCadBandeiras.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadBandeiras.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pCarregaPlanoContabil;
  pCarregaPlanoDeContasPorEmpresa('BANNCO', dbeCodBan.Text, FcdsNCO);
  pCarregaDadosCnfTef(qryTabela.FieldByName('AUTOINCREM').AsString) ;
end;

procedure TfrmCadBandeiras.btnExcluirDadosEmpresaClick(Sender: TObject);
begin
  inherited;
  if FcdsCadBnD.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Registro não selecionado!', ['&OK']);
    exit ;
  end ;

  If (fMensagem('ATENÇÃO', 'Tem certeza que deseja excluir o registro selecionado?', ['&Sim', '&Não'], 1) = 2) Then
    Exit;

  FcdsCadBnD.Delete;

end;

procedure TfrmCadBandeiras.btnGravarClick(Sender: TObject);
var LAltNome: Boolean;
begin

  if not fValidaDadosCnfTef(qryTabela.FieldByName('AUTOINCREM').AsString) then
    Exit ;

  if not fVerificarPlanoDeContasPorEmpresa(dbeCodBan.Text, 'BANNCO', dbePlaNco.Text, FcdsNCO) then
  begin
    exit ;
  end;

  If (Assigned(dbePlanco.Field)) And (fTiraCaracEspeciais(dbePlanco.Field.AsString) = '') Then
    dbePlanco.Field.Clear;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  LAltNome := (qryTabela.FieldByName('BAN_NOMBAN').OldValue <> qryTabela.FieldByName('BAN_NOMBAN').NewValue);

  Try
    inherited;
    pGravaDadosCnfTef(qryTabela.FieldByName('AUTOINCREM').AsString);
    If LAltNome Then
      TRegrasCadastroCartaoTef.fAlteraNomeCartaoDoCadastro('', dbeCodBan.Text);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadBandeiras.btnGravarClick]');
    End;
  End;

  If blnGravou Then
  begin
    pSalvaPlanoDeContasPorEmpresa('BANNCO', dbeCodBan.Text, FcdsNCO) ;
    fCommit ;
  End
  Else
    fRollBack;

  pHabilitarCnfTef(False);

end;

procedure TfrmCadBandeiras.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodBan, dbeNomBan, False)
  Else
    pHabilitaCodigo(dbeCodBan, dbeCodBan, True);

  edtDesPlaNco.Clear;
  pCarregaPlanoDeContasPorEmpresa('BANNCO', dbeCodBan.Text, FcdsNCO);
  pCarregaDadosCnfTef(qryTabela.FieldByName('AUTOINCREM').AsString) ;
end;

procedure TfrmCadBandeiras.btnIncluirDadosEmpresaClick(Sender: TObject);
begin
  inherited;
  pChamaTelaCnfTef(True) ;
end;

procedure TfrmCadBandeiras.btnAlterarClick(Sender: TObject);
begin
  inherited;

  if not qryTabela.IsEmpty then
    pHabilitarCnfTef(True);

  dbeCodBan.Enabled := False;
  pSetFocus(dbeNomBan);

end;

procedure TfrmCadBandeiras.btnPesquisaClick(Sender: TObject);
Var
  chrKey     : Char;
  arrBandeira : TConsultasArray;
begin
  {*****************************************}
  {* NOVA CONSULTA DE BANDEIRAS DE CARTOES *}
  {**************************************DP*}
  chrKey := '/';
  If fPesqCartaoBandeira(Self, Nil, Nil, qryTabela, chrKey, arrBandeira) Then
  begin
    pCarregaPlanoContabil;
    pCarregaPlanoDeContasPorEmpresa('BANNCO', dbeCodBan.Text, FcdsNCO);
    pCarregaDadosCnfTef(qryTabela.FieldByName('AUTOINCREM').AsString) ;
    If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
      pSetFocus(btnAlterar);
  end;
end;

procedure TfrmCadBandeiras.btnPlaNcoClick(Sender: TObject);
begin
  pPlanoDeContasPorEmpresa(dbeCodBan.Text, 'BANNCO', qryTabela.FieldByName('BAN_PLANCO').AsString, qryTabela.State, FcdsNCO, True);
end;

procedure TfrmCadBandeiras.dbePlaNcoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fEntraCons(Key) Then
  Begin
    TStringField(qryTabela.FieldByName('BAN_PLANCO')).EditMask := '';
    If fPesqPlanoContabil(Self, dbePlaNco, Nil, Nil, Key, arrSel) Then
    Begin
      If fValidaCampos(dbePlaNco, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
    TStringField(qryTabela.FieldByName('BAN_PLANCO')).EditMask := fMskCon;
  End;
end;

function TfrmCadBandeiras.fCadastroCartaoParamAutTefCadBan: Boolean;
begin
  Result := OperadorCitelLogado and fCadastroCartaoParamAutTef ;
end;

procedure TfrmCadBandeiras.pCarregaDadosCnfTef(const AStrAutoInc: String);
Var
  LqryConsulta: TUniQuery;
begin
  if not fCadastroCartaoParamAutTefCadBan then
    Exit ;

  If Assigned(FcdsCadBnD) Then
    FreeAndNil(FcdsCadBnD);

  Try
    LqryConsulta := fCriaQuery();
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add('SELECT * FROM CADBND WHERE BAN_SEQBAN = :SEQBAN ORDER BY AUTOINCREM') ;
    LqryConsulta.ParamByName('SEQBAN').AsString := AStrAutoInc ;
    LqryConsulta.Open;
    FcdsCadBnD := fCriaClientDatset(LqryConsulta);
    FcdsCadBnD.Open;

    dtsCnfTef.DataSet  := FcdsCadBnD;
  Finally
    FreeAndNil(LqryConsulta);
  End;
end;

procedure TfrmCadBandeiras.pCarregaPlanoContabil(const blnBuscaPorChave: Boolean=False);
begin
  If (edtDesPlaNco.Visible) Then
  begin
    edtDesPlaNco.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePlaNco.Text)], False);
  end;
end;

procedure TfrmCadBandeiras.pChamaTelaCnfTef(const AblnModoInsert: Boolean);
var
  LFrmCadastro: TfrmCadBandeirasCnfTef ;
  LcdsVerifi: TUniClientDataSet ;
begin

  LcdsVerifi := TUniClientDataSet.Create(nil);
  pCriarFormularios(TfrmCadBandeirasCnfTef, LFrmCadastro);
  try
    pCloneDataSet(LcdsVerifi, FcdsCadBnD) ;

    if AblnModoInsert then
    begin
      FcdsCadBnD.Append ;
      FcdsCadBnD.FieldByName('BAN_TIPCAR').AsString := 'C' ;
    end
    else
      FcdsCadBnD.Edit ;

    LFrmCadastro.dtsCnfTef.DataSet := FcdsCadBnD ;
    LFrmCadastro.CdsVerifica := LcdsVerifi ;

    If FcdsCadBnD.FieldByName('BAN_TIPCAR').AsString = 'C' Then
      LFrmCadastro.dbeTipCar.ItemIndex := 0
    Else If FcdsCadBnD.FieldByName('BAN_TIPCAR').AsString = 'D' Then
      LFrmCadastro.dbeTipCar.ItemIndex := 1;

    LFrmCadastro.ShowModal ;
    if LFrmCadastro.ModalResult = mrOK then
    begin
      FcdsCadBnD.Post ;
    end
    else
      FcdsCadBnD.Cancel ;
    pSetFocus(GridTef);
  finally
    pFreeAndNil(LFrmCadastro);
    FreeAndNil(LcdsVerifi) ;
  end ;
end;

procedure TfrmCadBandeiras.pGravaDadosCnfTef(const AStrAutoInc: String);
var
  LqryExec: TUniQuery;
begin
  if not fCadastroCartaoParamAutTefCadBan then
    Exit ;

  if fEmptyStr(AStrAutoInc) then
    Exit ;

  LqryExec := fCriaQuery() ;
  try
    LqryExec.Close ;
    LqryExec.SQL.Clear ;
    LqryExec.SQL.Add('DELETE FROM CADBND WHERE BAN_SEQBAN = :SEQBAN') ;
    LqryExec.ParamByName('SEQBAN').AsString := AStrAutoInc ;
    LqryExec.ExecSQL ;

    LqryExec.Close ;
    LqryExec.SQL.Clear ;
    LqryExec.SQL.Add(' INSERT INTO CADBND (AUTOINCREM, BAN_TFTBAN, BAN_TFBAN2, BAN_TIPCAR, BAN_SEQBAN) ') ;
    LqryExec.SQL.Add(' VALUES (:AUTOINCREM, :TFTBAN, :TFBAN2, :TIPCAR, :SEQBAN); ') ;

    FcdsCadBnD.First ;
    while not FcdsCadBnD.Eof do
    begin
      LqryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CADBND', VS_strCodEmp) ;
      LqryExec.ParamByName('TFTBAN').AsString := FcdsCadBnD.FieldByName('BAN_TFTBAN').AsString ;
      LqryExec.ParamByName('TFBAN2').AsString := FcdsCadBnD.FieldByName('BAN_TFBAN2').AsString ;
      LqryExec.ParamByName('TIPCAR').AsString := FcdsCadBnD.FieldByName('BAN_TIPCAR').AsString ;
      LqryExec.ParamByName('SEQBAN').AsString := AStrAutoInc ;
      LqryExec.ExecSQL ;
      FcdsCadBnD.Next ;
    end ;

  finally
    FreeAndNil(LqryExec) ;
  end ;
end;

procedure TfrmCadBandeiras.pHabilitarCnfTef(AblnHabilitar: Boolean);
begin
  btnIncluirDadosEmpresa.Enabled := AblnHabilitar;
  btnAlterarDadosEmpresa.Enabled := AblnHabilitar;
  btnExcluirDadosEmpresa.Enabled := AblnHabilitar;
end;

procedure TfrmCadBandeiras.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If FindField('BAN_PLANCO') <> Nil Then
      TStringField(FieldByName('BAN_PLANCO')).EditMask := fMskCon;
  End;
end;

procedure TfrmCadBandeiras.pRedimencionarFormulario;
var
  LblnAtivado: Boolean ;
begin
  LblnAtivado := fCadastroCartaoParamAutTefCadBan ;

  if not LblnAtivado then
    Exit ;

  gbCnfTef.Visible := LblnAtivado ;

  //contabilidade ativada
  if not dbePlaNco.Visible then
    gbCnfTef.Top := lblDesPlaCon.Top ;

  Self.Height := Self.Height + gbCnfTef.Height + 10 ;
end;

end.
