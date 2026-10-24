unit untCadAnaliseMov;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass, cxButtonEdit, System.Actions, Vcl.ActnList,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, EditFocus, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, MaskEditFocus, Uni,
  untConsultas, untFuncoesSimples, untTypesSistema, untOrdProIndustrial,
  cxCurrencyEdit, untAnaliseMov, cxDropDownEdit, StrUtils, cxLabel, untLiberacao,
  cxDataControllerConditionalFormattingRulesManagerDialog, untFuncoesRel;

type
  TfrmCadAnaliseMov = class(TfrmPaiCad)
    pnlDados: TPanel;
    pnlInfoOpI: TPanel;
    pnlCampos: TPanel;
    dtsTabela: TDataSource;
    btnImprimir: TBitBtnLocked;
    gpbLibera: TGroupBox;
    Label7: TLabel;
    edtStatus: TEditFocus;
    Label6: TLabel;
    dbeDtaBai: TDBEditFocus;
    dbeHorBai: TDBEditFocus;
    gpbAcompanha: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    edtStaAco: TEditFocus;
    dbeDtaAco: TDBEditFocus;
    dtaHorAco: TDBEditFocus;
    ActionList1: TActionList;
    Action1: TAction;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtDesIte: TEditFocus;
    edtNumOpe: TEditFocus;
    edtDesEti: TEditFocus;
    edtNumLot: TEditFocus;
    edtVolume: TEditFocus;
    cxgAnalises: TcxGrid;
    cxgAnalisesView: TcxGridDBTableView;
    cxgAnalisesCODANA: TcxGridDBColumn;
    cxgAnalisesDESCRI: TcxGridDBColumn;
    cxgAnalisesRESESP: TcxGridDBColumn;
    cxgAnalisesRESULT: TcxGridDBColumn;
    cxgAnalisesSITUACAO: TcxGridDBColumn;
    cxgAnalisesSTATUS: TcxGridDBColumn;
    cxgAnalisesDESTIPANA: TcxGridDBColumn;
    cxgAnalisesOBSERV: TcxGridDBColumn;
    cxgAnalisesTIPANA: TcxGridDBColumn;
    cxgAnalisesTIPRES: TcxGridDBColumn;
    cxgAnalisesLIMMIN: TcxGridDBColumn;
    cxgAnalisesLIMMAX: TcxGridDBColumn;
    cxgAnalisesDESRES: TcxGridDBColumn;
    cxgAnalisesNOMOPE: TcxGridDBColumn;
    cxgAnalisesLevel1: TcxGridLevel;
    gpbCabecalho: TGroupBox;
    dbeCodigo: TDBEditFocus;
    Label1: TLabel;
    Label5: TLabel;
    edtNumOrd: TEditFocus;
    mskDtaCad: TMaskEditFocus;
    LbComponenteB: TLabel;
    edtNumOrdB: TEditFocus;
    mkDtaCadB: TMaskEditFocus;
    pnlMassaVolume: TPanel;
    Label11: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    dbeMassaCompA: TDBEditFocus;
    dbeVolumeCompA: TDBEditFocus;
    dbeVolumeCompB: TDBEditFocus;
    dbeMassaCompB: TDBEditFocus;
	dbeCodemp: TDBEditFocus;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtNumOrdKeyPress(Sender: TObject; var Key: Char);
    procedure cxgAnalisesSITUACAOCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure cxgAnalisesViewInitEdit(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit);
    procedure cxgAnalisesRESESPGetDataText(Sender: TcxCustomGridTableItem;
      ARecordIndex: Integer; var AText: string);
    procedure Action1Execute(Sender: TObject);
    procedure edtNumOrdBKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure cxgAnalisesViewEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
  private
    { Private declarations }
    objOrdPro: TOrdProIndustrial;
    objAnaMov: TAnaliseMov;
    strComponenteA,
    strComponenteB,
    strCodItemComponenteFormulacao: String;

    objLiberacao : TLiberacao;

    procedure pCarreDadosOP(blnLimpar: Boolean = False);

    procedure pHabilitaCamposCabec(blnHabilita: Boolean);

    procedure pHabilitaAnalises(blnHabilita: Boolean);

    Procedure pCarregaDadosAdicionais;

    Procedure pMostraStatus;

    Function fComfirmaAnalise: Boolean;
    Procedure pAlteraAnalise(AItem: TcxCustomGridTableItem);

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;
    procedure pInicializaIndices; override;
  end;

implementation

{$R *.dfm}

Uses
  untCadAnaliseMovFinal;

procedure TfrmCadAnaliseMov.Action1Execute(Sender: TObject);
  Var
    chrKey : Char;
    arrSel : TConsultasArray;
    qryCadOpe: TUniQuery;
begin
  inherited;
  chrKey := '?';
  qryCadOpe := fCriaQuery;

  If fPesqOperador(Self, nil, nil, qryCadOpe, chrKey, arrSel)Then
  Begin
    objAnaMov.Edit;
    objAnaMov.FieldByName('DET_CODOPE').AsString := qryCadOpe.FieldByName('OPE_CODOPE').AsString;
    objAnaMov.FieldByName('NOMOPE').AsString := qryCadOpe.FieldByName('OPE_CODOPE').AsString + '-' + qryCadOpe.FieldByName('OPE_NOMOPE').AsString;
    objAnaMov.Post;
  End;

  FreeAndNil(qryCadOpe)
end;

procedure TfrmCadAnaliseMov.btnAlterarClick(Sender: TObject);
begin
  If (Not qryTabela.IsEmpty) And
     (Not qryTabela.FieldByName('GER_DTAACO').IsNull) Then
  Begin
    pMensagemOk('Análise já baixada!');
    Exit;
  End;

  btnImprimir.Enabled := False;

  inherited;

  pHabilitaCodigo(dbeCodigo, dbeCodigo, False);
  pHabilitaCamposCabec(False);
  pHabilitaAnalises(True);
  pSetFocus(cxgAnalises);
  cxgAnalisesResult.Focused := True;
end;

procedure TfrmCadAnaliseMov.btnCancelaClick(Sender: TObject);
begin
  inherited;

  pHabilitaCamposCabec(False);
  pCarregaDadosAdicionais;
  pHabilitaAnalises(False);

  btnImprimir.Enabled := True;
end;

procedure TfrmCadAnaliseMov.btnExcluirClick(Sender: TObject);
  Var
    qryAnaDet: TUniQuery;
begin
  Try
    If qryTabela.IsEmpty Then
    Begin
      fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
      Exit;
    End;

    If Not fPergunta('Deseja realmente excluir esse registro?') Then
      Exit;

    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
    blnPerguntarParaExcluir := False;

    inherited;

    qryAnaDet := fCriaQuery(Self);

    qryAnaDet.SQL.Text := 'SELECT * FROM ANADET WHERE DET_SEQGER = :SEQGER';
    qryAnaDet.ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryAnaDet.Open;

    While Not qryAnaDet.Eof Do
    Begin
      fVerificaIntegridade(Self.Name, 'ANADET', qryAnaDet);
      qryAnaDet.Next;
    End;

    FreeAndNil(qryAnaDet);

    If blnExcluiu Then
      fCommit
    Else
      fRollBack;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadAnaliseMov.btnExcluirClick]');
    End;

  End;

  pCarregaDadosAdicionais;
end;

Function TfrmCadAnaliseMov.fComfirmaAnalise: Boolean;
var
 frmCadAnaliseMovFinal: TfrmCadAnaliseMovFinal;
 blnAtualizar,
 blnTemAnaliseReprovada : Boolean;
Begin
  blnAtualizar := qryTabela.FieldByName('GER_DTABAI').IsNull;
  pCriarFormularios(TFrmCadAnaliseMovFinal, frmCadAnaliseMovFinal);

  frmCadAnaliseMovFinal.objAnaMov := objAnaMov;

  blnTemAnaliseReprovada := objAnaMov.fTemAnaliseReprovada(INT_APROVACAO);

  With frmCadAnaliseMovFinal Do
  Begin
    // APROVAÇÃO
    If qryTabela.FieldByName('GER_DTABAI').IsNull Then
    Begin
      chkFinAna.Enabled := objAnaMov.fTemAnaliseComResultado(INT_APROVACAO);

      If Not chkFinAna.Enabled Then
      Begin
        rdbAprovado.Enabled  := False;
        rdbReprovado.Enabled := False;
        rdbCorrecao.Enabled  := False;
        rdbAprCorrecao.Enabled := False;
      End;

      If blnTemAnaliseReprovada Then
      Begin
        rdbAprovado.Enabled := False
      End Else
      Begin
        rdbReprovado.Enabled := False;
        rdbCorrecao.Enabled  := False;
        rdbAprCorrecao.Enabled := False;
      End;
    End
    Else
    Begin
      gpbLiberacao.Enabled := False;

      chkFinAna.Checked := True;

      if ((qryTabela.FieldByName('GER_STATUS').AsInteger = 1) and blnTemAnaliseReprovada) or
         ((qryTabela.FieldByName('GER_STATUS').AsInteger > 1) and (not blnTemAnaliseReprovada)) then
        blnAtualizar := True
      else
        blnAtualizar := False;

      if blnAtualizar then
      begin

        gpbLiberacao.Enabled := blnAtualizar;

        If blnTemAnaliseReprovada Then
        Begin
          rdbAprovado.Enabled := False;
          rdbAprovado.Checked := False;
          rdbAprCorrecao.Enabled := False;
          rdbAprCorrecao.Checked := False;
        End Else
        Begin
          rdbReprovado.Enabled := False;
          rdbCorrecao.Enabled  := False;
          rdbAprCorrecao.Enabled := False;

          rdbReprovado.Checked := False;
          rdbCorrecao.Checked  := False;
          rdbAprCorrecao.Checked  := False;
        End;

      end
      else
      begin
        Case qryTabela.FieldByName('GER_STAACO').AsInteger Of
          0: rdbAprovado.Enabled  := True;
          1: rdbReprovado.Enabled := True;
          2,3: rdbCorrecao.Enabled  := True;
          4: rdbAprCorrecao.Enabled  := True;
        End;
      End;
    End;

    // ACOMPANHAMENTO
    chkFinAco.Enabled := objAnaMov.fTemAnaliseComResultado(INT_ACOMPANHAMENTO);

    If Not chkFinAco.Enabled Then
    Begin
      rdbAcoAprovado.Enabled  := False;
      rdbAcoReprovado.Enabled := False;
      rdbAcoCorrecao.Enabled  := False;
      rdbAcoAprCorrecao.Enabled  := False;
    End;

    If objAnaMov.fTemAnaliseReprovada(INT_ACOMPANHAMENTO) Then
    Begin
      rdbAcoAprovado.Enabled := False
    End Else
    Begin
      rdbAcoReprovado.Enabled := False;
      rdbAcoCorrecao.Enabled  := False;
      rdbAcoAprCorrecao.Enabled  := False;
    End;

    If (Not fCfgSis('PERFSA', varBoolean)) Then
    Begin
      If qryTabela.State = dsEdit Then
        frmCadAnaliseMovFinal.strSeqAna := qryTabela.FieldByName('GER_CODIGO').AsString
      Else
        frmCadAnaliseMovFinal.strSeqAna := fRetSequencial('SEQANA', VS_strCodEmp, 6, True);
    End;
    frmCadAnaliseMovFinal.ShowModal;
    Result := ModalResult = mrOk;

    If Result Then
    Begin
    // APROVAÇÃO
      If qryTabela.FieldByName('GER_DTABAI').IsNull Or blnAtualizar Then
      Begin
        If rdbAprovado.Checked Then
         qryTabela.FieldByName('GER_STATUS').AsInteger := 1

        Else If rdbReprovado.Checked Then
         qryTabela.FieldByName('GER_STATUS').AsInteger := 2

        Else If rdbCorrecao.Checked Then
         qryTabela.FieldByName('GER_STATUS').AsInteger := 3

        Else If rdbAprCorrecao.Checked Then
         qryTabela.FieldByName('GER_STATUS').AsInteger := 4

        Else
          qryTabela.FieldByName('GER_STATUS').Clear;
      End;

    // ACOMPANHAMENTO
      If rdbAcoAprovado.Checked Then
       qryTabela.FieldByName('GER_STAACO').AsInteger := 1

      Else If rdbAcoReprovado.Checked Then
       qryTabela.FieldByName('GER_STAACO').AsInteger := 2

      Else If rdbAcoCorrecao.Checked Then
       qryTabela.FieldByName('GER_STAACO').AsInteger := 3

      Else If rdbAcoAprCorrecao.Checked Then
       qryTabela.FieldByName('GER_STAACO').AsInteger := 4

      Else
        qryTabela.FieldByName('GER_STAACO').Clear;

    End;

  End;
  pFreeAndNil(frmCadAnaliseMovFinal);
End;

procedure TfrmCadAnaliseMov.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If qryTabela.FieldByName('GER_STAACO').IsNull Then
  Begin
    If Not fComfirmaAnalise Then
      Exit;
  End;

  Try
    If (qryTabela.State = dsInsert) Then
      qryTabela.FieldByName('GER_CODIGO').AsString := fRetSequencial('SEQANA', VS_strCodEmp);

    qryTabela.FieldByName('GER_CODEMP').AsString := VS_strCodEmp;

    If (Not qryTabela.FieldByName('GER_STATUS').IsNull) And
       qryTabela.FieldByName('GER_OPEBAI').IsNull Then
    Begin
      qryTabela.FieldByName('GER_OPEBAI').AsString   := strLoginUsuarioLogado;
      qryTabela.FieldByName('GER_DTABAI').AsDateTime := VS_Date;
      qryTabela.FieldByName('GER_HORBAI').AsDateTime := fTime();
    End;

    If (Not qryTabela.FieldByName('GER_STAACO').IsNull) And
       qryTabela.FieldByName('GER_OPEACO').IsNull Then
    Begin
      qryTabela.FieldByName('GER_OPEACO').AsString   := strLoginUsuarioLogado;
      qryTabela.FieldByName('GER_DTAACO').AsDateTime := VS_Date;
      qryTabela.FieldByName('GER_HORACO').AsDateTime := fTime();
    End;

    inherited;

    If blnGravou And objAnaMov.fSalvaRegistros(qryTabela.FieldByName('AUTOINCREM').AsString) Then
      fCommit
    Else
      fRollBack;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadAnaliseMov.btnGravarClick]');
    End;

  End;

  pHabilitaCamposCabec(False);
  pHabilitaAnalises(False);
  pMostraStatus;

  btnImprimir.Enabled := blnGravou;

  If blnGravou And (Not qryTabela.FieldByName('GER_STAACO').IsNull) Then
    btnImprimir.Click;
end;

procedure TfrmCadAnaliseMov.btnImprimirClick(Sender: TObject);
begin
  inherited;

    If qryTabela.IsEmpty Then
      Exit;

    If fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) Then
      Exit;

    If Not fPergunta('Deseja imprimir o Laudo da Análise?') Then
      Exit;

    If Assigned(prcExecutaRelatorio) Then
      prcExecutaRelatorio(182, 7450, [7450],
                          ['SEQGER'],
                          [qryTabela.FieldByName('AUTOINCREM').AsString],
                          Sender, Nil, True);
end;

procedure TfrmCadAnaliseMov.btnIncluirClick(Sender: TObject);
begin
  inherited;

  btnImprimir.Enabled := False;

  pHabilitaCodigo(dbeCodigo, dbeCodigo, False);
  pCarregaDadosAdicionais;
  pHabilitaCamposCabec(True);
  pHabilitaAnalises(True);
  pSetFocus(edtNumOrd);
end;

procedure TfrmCadAnaliseMov.btnPesquisaClick(Sender: TObject);
  Var
    arrAna : TConsultasArray;
    chrKey   : Char;
Begin
  chrKey := '/';
  if fPesqMovAnalises(Self, Nil, qryTabela, chrKey, arrAna) then
  Begin
    pCarregaDadosAdicionais;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadAnaliseMov.cxgAnalisesRESESPGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;

   if cxgAnalisesView.DataController.Values[ARecordIndex, cxgAnalisesTIPRES.Index] = '1' then
     AText :=   FormatFloat('#,##0.0000', fStrToFloat(cxgAnalisesView.DataController.Values[ARecordIndex, cxgAnalisesLIMMIN.Index], 0))
              + ' a '
              + FormatFloat('#,##0.0000', fStrToFloat(cxgAnalisesView.DataController.Values[ARecordIndex, cxgAnalisesLIMMAX.Index], 0))
   else
     AText :=   cxgAnalisesView.DataController.Values[ARecordIndex, cxgAnalisesDESRES.Index];

end;

procedure TfrmCadAnaliseMov.cxgAnalisesSITUACAOCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxgAnalisesSTATUS.Index]) = '1' Then
  Begin
    ACanvas.Font.Color := clGreen
  End

  Else If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxgAnalisesSTATUS.Index]) = '2' Then
  Begin
    ACanvas.Font.Color := clRed;
  End;

end;

procedure TfrmCadAnaliseMov.cxgAnalisesViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  if (AItem = cxgAnalisesSITUACAO) or (AItem = cxgAnalisesRESULT) then
  begin
    pAlteraAnalise(AItem);
    AAllow := not objAnaMov.ReadOnly;
  end;
end;

procedure TfrmCadAnaliseMov.cxgAnalisesViewInitEdit(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit);
var
  i : Integer;
begin
  inherited;
  If AItem = cxgAnalisesSITUACAO then
  begin
    TCxComboBox(AEdit).Properties.Items.Clear;
    For i := 1 to High(ARR_STATUSANA) do
      TCxComboBox(AEdit).Properties.Items.Add(ARR_STATUSANA[i]);

    TCxComboBox(AEdit).Properties.Items.Add('SEM ANÁLISE');
  end;
end;

procedure TfrmCadAnaliseMov.edtNumOrdBKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTabela : TConsultasArray;
begin
  inherited;

  If fPesqOrdProIndustrial(Self, edtNumOrdB, mkDtaCadB, Nil, Key, arrTabela, poiCodigo, False, staTodas, '','',strComponenteA, strComponenteB, strCodItemComponenteFormulacao) Then
  Begin
    If fValidaCampos(edtNumOrdB, True) And
       fValidaCampos(mkDtaCadB, True) Then
    Begin
      pSetFocus(cxgAnalises);
    End;
  End;
end;

procedure TfrmCadAnaliseMov.edtNumOrdKeyPress(Sender: TObject; var Key: Char);
  Var
    arrTabela : TConsultasArray;
begin
  inherited;
  If fPesqOrdProIndustrial(Self, edtNumOrd, mskDtaCad, Nil, Key, arrTabela, poiCodigo, False, staTodas) Then
  Begin
    If fValidaCampos(edtNumOrd, True) And
       fValidaCampos(mskDtaCad, True) Then
    Begin
      pSetFocus(cxgAnalises);
    End;
  End;
end;

procedure TfrmCadAnaliseMov.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'ANAGER';
  strNomeCampo      := 'GER_CODIGO';
  qryTabela         := fCriaQuery(Self);
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodigo;
  arrCamposChave[1] := dbeCodemp;

  objOrdPro := TOrdProIndustrial.Create(Self);
  objAnaMov := TAnaliseMov.Create(Self);
  objAnaMov.qryAnaGer := qryTabela;

  cxgAnalisesView.DataController.DataSource := objAnaMov.dtsSource;
  cxgAnalisesNOMOPE.Visible := fCfgSis('OPEANA', varBoolean);

  pHabilitaAnalises(False);
  pHabilitaCamposCabec(False);

  LbComponenteB.Visible       := fCfgSis('ULTCMP', varBoolean);
  edtNumOrdB.Visible          := fCfgSis('ULTCMP', varBoolean);
  mkDtaCadB.Visible           := fCfgSis('ULTCMP', varBoolean);
  pnlMassaVolume.Visible      := fCfgSis('ULTCMP', varBoolean);

  If Not(pnlMassaVolume.Visible) Then
  Begin
    gpbLibera.top:= 48;
    gpbAcompanha.top:= 111;
  End;

  strCodItemComponenteFormulacao:= '';
  strComponenteA              := '';
  strComponenteB              := '';

  objLiberacao  := TLiberacao.Create;
end;

procedure TfrmCadAnaliseMov.FormDestroy(Sender: TObject);
begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  inherited;
end;

procedure TfrmCadAnaliseMov.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If fCheckParent(ActiveControl, cxgAnalises) Then
               Begin
                 If Not (cxgAnalisesResult.Focused or cxgAnalisesSITUACAO.Focused) Then
                    cxgAnalisesResult.Focused := True

                 Else If (objAnaMov.State = dsEdit) And (cxgAnalisesResult.Focused or cxgAnalisesSITUACAO.Focused)Then
                 Begin
                   if TTipoResultadoAnalise(StrToIntDef(objAnaMov.FieldByName('ANA_TIPRES').AsString, 1)) = traDescricaoAberta then
                     if cxgAnalisesResult.Focused then
                     begin
                       cxgAnalisesSITUACAO.Focused := True;
                       Exit;
                     end
                     else
                       cxgAnalisesResult.Focused := True;

                   cxgAnalisesView.NavigatorButtons.Next.Click;

                   If (objAnaMov.State = dsEdit) Then
                   Begin
                     objAnaMov.Post;
                     pSetFocus(btnGravar);
                   End;
                 End;
               End;
  End;

end;

procedure TfrmCadAnaliseMov.FormShow(Sender: TObject);
begin
  inherited;

  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

end;

procedure TfrmCadAnaliseMov.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
end;


procedure TfrmCadAnaliseMov.pAlteraAnalise(AItem: TcxCustomGridTableItem);
begin
  if not objAnaMov.ReadOnly then
    Exit;
  if (AItem <> cxgAnalisesSITUACAO) and (AItem <> cxgAnalisesRESULT) then
    Exit;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Alteração de análise');
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddTextoCaption('Análise'                          , dbeCodigo.Field.AsString);
  objLiberacao.objMsgLibera.pAddTextoCaption('Ordem de produção industrial'     , edtNumOrd.Text + '-' + mskDtaCad.Text);
  objLiberacao.strDirAce := 'ALTANA';
  objLiberacao.strMsgSen := 'Permitir alterar análise já finalizada';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  objAnaMov.ReadOnly := Not objLiberacao.fLibera;
end;

procedure TfrmCadAnaliseMov.pCarreDadosOP(blnLimpar: Boolean = False);
Begin
  If blnLimpar Then
  Begin
    edtDesIte.Clear;
    edtNumOpe.Clear;
    edtDesEti.Clear;
    edtNumLot.Clear;
    edtVolume.Clear;
    edtNumOrd.Clear;
    mskDtaCad.Clear;
    edtNumOrdB.Clear;
    mkDtaCadB.Clear;

    If objOrdPro.cdsCabIpr.Active Then
      objOrdPro.cdsCabIpr.EmptyDataSet;

    If objOrdPro.cdsCabIpB.Active Then
      objOrdPro.cdsCabIpB.EmptyDataSet;

  End Else
  With objOrdPro Do
  Begin
    edtDesIte.Text := cdsCabIpr.FieldByName('DESITE').AsString;
    edtNumOpe.Text := cdsCabIpr.FieldByName('NUMOPE').AsString;
    edtDesEti.Text := cdsCabIpr.FieldByName('DESETI').AsString;
    edtNumLot.Text := cdsCabIpr.FieldByName('NUMLOT').AsString;
    edtVolume.Text := FormatFloat('#,##0.000', fRetSoma('VOLUME'));

    edtNumOrd.Text := cdsCabIpr.FieldByName('CODORD').AsString;
    mskDtaCad.Text := FormatDateTime('DD/MM/YYY', cdsCabIpr.FieldByName('DTACAD').AsDateTime);

    If qryTabela.FieldByName('GER_SEQOPB').AsString <> '' Then
    Begin
      objOrdPro.fCarregaCabecalhoOProdutoB(qryTabela.FieldByName('GER_SEQOPB').AsString);
      edtNumOrdB.Text:= objOrdPro.cdsCabIpB.FieldByName('CODORD').AsString;
      mkDtaCadB.Text := FormatDateTime('DD/MM/YYY', objOrdPro.cdsCabIpB.FieldByName('DTACAD').AsDateTime);
    End;
  End;
End;

procedure TfrmCadAnaliseMov.pHabilitaCamposCabec(blnHabilita: Boolean);
Begin
  edtNumOrd.TabStop  := blnHabilita;
  edtNumOrd.ReadOnly := Not blnHabilita;

  If blnHabilita Then
    edtNumOrd.Enabled  := True;

  mskDtaCad.TabStop  := blnHabilita;
  mskDtaCad.ReadOnly := Not blnHabilita;

  mskDtaCad.Enabled  := blnHabilita;

  edtNumOrdB.TabStop  := blnHabilita;
  edtNumOrdB.ReadOnly := Not blnHabilita;

  If blnHabilita Then
    edtNumOrdB.Enabled  := True;

  mkDtaCadB.TabStop  := blnHabilita;
  mkDtaCadB.ReadOnly := Not blnHabilita;

  mkDtaCadB.Enabled  := blnHabilita;

End;

function TfrmCadAnaliseMov.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  var
    qryConsulta    : TUniQuery;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Código do Análise das Amostras deve ser preenchido!', ['&Ok']);
      End
      Else If blnBuscaPorChave Then
      Begin

      End;
    End

    Else If (Sender = edtNumOrd) Then
    Begin

      If fEmptyStrEspeciais(edtNumOrd.Text) Then
      Begin
        pMensagemOk('Informe o Número da Ordem de Produção!');
        Result := False;
      End

    End

    Else If (Sender = mskDtaCad) Then
    Begin

      If fEmptyDate(mskDtaCad.Text) Then
      Begin
        pMensagemOk('Informe a Data de Cadastro da Ordem de Produção!');
        Result := False;
      End

      Else If Not objOrdPro.fCarregaCabecalhoOP(edtNumOrd.Text, strToDateDef(mskDtaCad.Text, 0)) Then
      Begin
        pMensagemOk('Ordem de produção não encontrada!');
        Result := False;
      End Else
      Begin
        If qryTabela.State = dsInsert Then
        begin
          Result := objAnaMov.fPermiteNovaAnalise(objOrdPro.cdsCabIpr.FieldByName('AUTINC').AsString);
          if not Result then
            exit;

          qryTabela.FieldByName('GER_SEQOPI').AsString := objOrdPro.cdsCabIpr.FieldByName('AUTINC').AsString;

          If objAnaMov.fProdutoEhComponenteA(qryTabela.FieldByName('GER_SEQOPI').AsString) Then
          Begin
              If fEmptyStr(qryTabela.FieldByName('GER_VOLUMA').AsString) Or (qryTabela.FieldByName('GER_VOLUMA').IsNull) Then
            qryTabela.FieldByName('GER_VOLUMA').AsString := objOrdPro.cdsCabIpr.FieldByName('RELACAO_CATALISE').AsString
          End
          Else
          Begin
            If fEmptyStr(qryTabela.FieldByName('GER_VOLUMB').AsString) Or (qryTabela.FieldByName('GER_VOLUMB').IsNull) Then
              qryTabela.FieldByName('GER_VOLUMB').AsString := objOrdPro.cdsCabIpr.FieldByName('RELACAO_CATALISE').AsString;
          End;

        end;

        pCarreDadosOP;
        If blnBuscaPorChave Then
        begin
          pCarregaDadosAdicionais;

          if objAnaMov.isEmpty then
          begin
            fMensagem('','Não existem análises vinculadas à formula do produto!',['&Ok']);
            Result := False;
            btnCancela.Click;
            pSetFocus(btnIncluir);
            blnMudarFoco := False;
          end;

          If fCfgSis('ULTCMP', varBoolean) Then
          Begin
            strComponenteA:= '';
            strComponenteB:= '';

            qryConsulta     := fCriaQuery(Self);
            Try
              qryConsulta.Close;
              qryConsulta.SQL.Clear;
              qryConsulta.SQL.Add('SELECT * FROM ORDGER ');
              qryConsulta.SQL.Add('   INNER JOIN CADITE ON ORD_CODITE = ITE_CODITE ');
              qryConsulta.SQL.Add('                  WHERE ORD_CODORD = :CODORD');
              qryConsulta.SQL.Add('                    AND ORD_DTACAD = :DTACAD');
              qryConsulta.SQL.Add('                    AND ORD_CODEMP = :CODEMP');

              qryConsulta.ParamByName('CODEMP').AsString  := VS_strCodEmp;
              qryConsulta.ParamByName('CODORD').AsString  := edtNumOrd.Text;
              qryConsulta.ParamByName('DTACAD').AsDateTime:= StrToDate(mskDtaCad.Text);
              qryConsulta.Open;

              If (qryConsulta.IsEmpty) Then
              Begin
                Result := False;
                pMensagemOk('Ordem de Produção não encontrada!');
              End;
              strComponenteA := '';
              strComponenteB := '';
              If qryConsulta.FieldByName('ITE_COMPNA').AsString = 'S' Then
              Begin
                strCodItemComponenteFormulacao:= qryConsulta.FieldByName('ITE_CODITB').AsString;
                strComponenteA                := qryConsulta.FieldByName('ITE_COMPNA').AsString;
              End
              Else
              If qryConsulta.FieldByName('ITE_COMPNB').AsString = 'S' Then
              Begin
                strCodItemComponenteFormulacao:= qryConsulta.FieldByName('ITE_CODITE').AsString;
                strComponenteB                := qryConsulta.FieldByName('ITE_COMPNB').AsString;
              End;

            Finally
              FreeAndNil(qryConsulta);
            End;
          End;

        end;
      End;

    End

    Else If fCfgSis('ULTCMP', varBoolean) Then
    Begin

      If (Sender = mkDtaCadB) Then
      Begin
        If Not(fEmptyDate(mkDtaCadB.Text)) Then
        Begin
          qryConsulta:= fCriaQuery(Self);
          Try
            qryConsulta.Close;
            qryConsulta.SQL.Clear;
            qryConsulta.SQL.Add('SELECT * FROM ORDGER ');
            qryConsulta.SQL.Add('   INNER JOIN CADITE ON ORD_CODITE = ITE_CODITE ');
            qryConsulta.SQL.Add('                  WHERE ORD_CODORD = :CODORD');
            qryConsulta.SQL.Add('                    AND ORD_DTACAD = :DTACAD');
            qryConsulta.SQL.Add('                    AND ORD_CODEMP = :CODEMP');

            qryConsulta.ParamByName('CODEMP').AsString  := VS_strCodEmp;
            qryConsulta.ParamByName('CODORD').AsString  := edtNumOrdB.Text;
            qryConsulta.ParamByName('DTACAD').AsDateTime:= StrToDate(mkDtaCadB.Text);

            If strComponenteA = 'S' Then
            Begin
              qryConsulta.SQL.Add('  AND ITE_COMPNB = "S" ');
              qryConsulta.SQL.Add('  AND ITE_CODITE = "'+strCodItemComponenteFormulacao+'" ');
            End;

            If strComponenteB = 'S' Then
            Begin
              qryConsulta.SQL.Add('  AND ITE_COMPNA = "S" ');
              qryConsulta.SQL.Add('  AND ITE_CODITB = "'+strCodItemComponenteFormulacao+'" ');
            End;

            qryConsulta.Open;

            If (qryConsulta.IsEmpty) Then
            Begin
              Result := False;
              pMensagemOk('Ordem de produção do componente B não encontrada!');
            End;

          Finally
            FreeAndNil(qryConsulta);
          End;

          If Result Then
          Begin
            If Not objOrdPro.fCarregaCabecalhoOProdutoB(edtNumOrdB.Text, strToDateDef(mkDtaCadB.Text, 0)) Then
            Begin
              pMensagemOk('Ordem de produção do componente B não encontrada!');
              Result := False;
            End Else

            Begin
              If qryTabela.State = dsInsert Then
              begin
                Result := objAnaMov.fPermiteNovaAnalise(objOrdPro.cdsCabIpB.FieldByName('AUTINC').AsString);
                if not Result then
                  exit;

                qryTabela.FieldByName('GER_SEQOPB').AsString := objOrdPro.cdsCabIpB.FieldByName('AUTINC').AsString;

                If fEmptyStr(qryTabela.FieldByName('GER_VOLUMB').AsString) Or (qryTabela.FieldByName('GER_VOLUMB').IsNull) Then
                  qryTabela.FieldByName('GER_VOLUMB').AsString := objOrdPro.cdsCabIpr.FieldByName('RELACAO_CATALISE').AsString;

              end;

              pCarreDadosOP;
              If blnBuscaPorChave Then
              begin
                pCarregaDadosAdicionais;

                if objAnaMov.isEmpty then
                begin
                  fMensagem('','Não existem análises vinculadas à formula do produto!',['&Ok']);
                  Result := False;
                  btnCancela.Click;
                  pSetFocus(btnIncluir);
                  blnMudarFoco := False;
                end;

              end;
            End;
          End;
        End
        Else
        Begin
//          qryTabela.Edit;
          qryTabela.FieldByName('GER_SEQOPB').Value  := null;
//          qryTabela.Post;

          If objOrdPro.cdsCabIpB.Active Then
            objOrdPro.cdsCabIpB.EmptyDataSet;

          
        End;
      End
    End;
  End;

  If (Not Result) and blnMudarFoco  Then
    pSetFocus(Sender);
end;

Procedure TfrmCadAnaliseMov.pMostraStatus;
Begin
  edtStatus.Clear;

  If Not qryTabela.FieldByName('GER_STATUS').IsNull Then
    Case qryTabela.FieldByName('GER_STATUS').AsInteger Of
      1: edtStatus.Text := 'APROVADO';
      2: edtStatus.Text := 'REPROVADO';
      3: edtStatus.Text := 'APROVADO COM CORREÇÃO';
      4: edtStatus.Text := 'APROVADO PARA CORREÇÃO';
    End;

  edtStaAco.Clear;

  If Not qryTabela.FieldByName('GER_STAACO').IsNull Then
    Case qryTabela.FieldByName('GER_STAACO').AsInteger Of
      1: edtStaAco.Text := 'APROVADO';
      2: edtStaAco.Text := 'REPROVADO';
      3: edtStaAco.Text := 'APROVADO COM CORREÇÃO';
      4: edtStaAco.Text := 'APROVADO PARA CORREÇÃO';
    End;
End;

Procedure TfrmCadAnaliseMov.pCarregaDadosAdicionais;
  Var
    strSeqOpi,
    strAutCabIpr,
    strAutInc: String;
    blnLiberado,
    blnInserindoAnalise,
    blnBaixado: Boolean;
Begin
  blnInserindoAnalise := qryTabela.State = dsInsert;
  If blnInserindoAnalise Then
  Begin
    If (Assigned(objOrdPro)) And (Assigned(objOrdPro.cdsCabIpr)) Then
    Begin
      If Assigned(objOrdPro.cdsCabIpr.FindField('AUTINC')) Then
        strAutCabIpr := objOrdPro.cdsCabIpr.FindField('AUTINC').AsString;
    End;
  End;
  pCarreDadosOP(True);

  strSeqOpi   := '';
  strAutInc   := '';
  blnBaixado  := False;
  blnLiberado := False;

  If qryTabela.Active Then
  Begin
    strSeqOpi   := qryTabela.FieldByName('GER_SEQOPI').AsString;
    If blnInserindoAnalise And fEmptyStr(strSeqOpi) Then
      StrSeqOpi := strAutCabIpr
    Else
    Begin
    If (objOrdPro.cdsCabIpr.FindField('AUTINC') <> Nil) And (Not fEmptyStr(objOrdPro.cdsCabIpr.FieldByName('AUTINC').AsString)) Then
      StrSeqOpi := objOrdPro.cdsCabIpr.FieldByName('AUTINC').AsString;
    End;

    strAutInc   := qryTabela.FieldByName('AUTOINCREM').AsString;
    blnLiberado := Not qryTabela.FieldByName('GER_DTABAI').IsNull;
    blnBaixado  := Not qryTabela.FieldByName('GER_DTAACO').IsNull;

    pMostraStatus;
  End;

  objAnaMov.fCarregaRegistros(strAutInc, strSeqOpi, blnLiberado, blnBaixado, qryTabela.FieldByName('GER_SEQOPB').AsString, (qryTabela.State = dsInsert));

  If (Not fEmptyStr(strSeqOpi)) And objOrdPro.fCarregaCabecalhoOP(strSeqOpi) Then
    pCarreDadosOP;

End;

procedure TfrmCadAnaliseMov.pHabilitaAnalises(blnHabilita: Boolean);
Begin
  cxgAnalisesView.OptionsData.Editing := blnHabilita;
  pnlMassaVolume.Enabled:= blnHabilita;

End;

end.

