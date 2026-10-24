unit untDigRecursosProjeto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untPaiCad, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, QColorLabel, MemoFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Uni, UniClientDataSet, UniDataSetProvider,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, EditFocus, MaskEditFocus, DateUtils,
  dxDateTimeWheelPicker, cxCalendar, cxTextEdit;

type
  TfrmDigRecursosProjeto = class(TfrmPaiCad)
    pnlFundo: TPanel;
    pnlLancamento: TPanel;
    pnlDados: TPanel;
    pnlRecurso: TPanel;
    lblCndPag: TLabel;
    edtCodRep: TEditFocus;
    edtNomRep: TEditFocus;
    Label1: TLabel;
    edtDesPrj: TEditFocus;
    Label2: TLabel;
    edtNomCli: TEditFocus;
    Panel1: TPanel;
    pnlDataHora: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    pnlKm: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    pnlQuantidade: TPanel;
    Label7: TLabel;
    pnlGrid: TPanel;
    cxgGridProDet: TcxGrid;
    cxgGridProDetView: TcxGridDBTableView;
    cxgColCodRep: TcxGridDBColumn;
    cxgColDescri: TcxGridDBColumn;
    cxgcxgGridProDet: TcxGridLevel;
    mskDtaIni: TMaskEditFocus;
    mskHorIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    mskHorFin: TMaskEditFocus;
    edtQuant: TEditFocus;
    edtKmIni: TEditFocus;
    edtKmFin: TEditFocus;
    cxgColDtaIni: TcxGridDBColumn;
    cxgColDtaFin: TcxGridDBColumn;
    cxgColKmIni: TcxGridDBColumn;
    cxgColKmFin: TcxGridDBColumn;
    cxgColQuant: TcxGridDBColumn;
    pnlBotoesRecurso: TPanel;
    btnIncCli: TBitBtnLocked;
    btnCancelCli: TBitBtnLocked;
    pnlCampos: TPanel;
    pnlCamposRecurso: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    edtNomOpe: TEditFocus;
    dbeCodPrj: TDBEditFocus;
    dtsTabela: TDataSource;
    dbeCodCli: TDBEditFocus;
    dbeDtaCad: TDBEditFocus;
    dbeCodOpe: TDBEditFocus;
    pnlObs: TPanel;
    Label10: TLabel;
    cxgColQtdHor: TcxGridDBColumn;
    edtObs: TEditFocus;
    cxgColObserv: TcxGridDBColumn;
    dtaIniDia: TMaskEditFocus;
    Label11: TLabel;
    dtaFinDia: TMaskEditFocus;
    Label12: TLabel;
    shpRec: TShape;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtCodRepKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelCliClick(Sender: TObject);
    procedure btnIncCliClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mskDtaIniExit(Sender: TObject);
    procedure cxgGridProDetViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodRepEnter(Sender: TObject);
    procedure dbeCodPrjKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
    procedure cxgGridProDetViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgGridProDetViewKeyPress(Sender: TObject; var Key: Char);
    procedure cxgGridProDetViewKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgGridProDetExit(Sender: TObject);
    procedure dtaFinDiaExit(Sender: TObject);
  private
    { Private declarations }
    strTipCap: String;
    strCodOpe: String;
    strTipRec: String;
    blnValidaCampos: Boolean;
    qryProDet: TUniQuery;
    cdsProDet: TUniClientDataSet;
    dspProDet: TUniDataSetProvider;
    dtsProDet: TDataSource;

    procedure pValidaTipoRecurso;
    procedure pLimparCampos(blnCabecalho: Boolean; blnGrid: Boolean = False);
    procedure pGravaLancamento;
    procedure pCarregaLancamentos(strSeqPrj: String = '');
    procedure pGravaLancamentos;
    function fCriaCdsProDet(AOwner: TComponent): TUniClientDataSet;
    function fNenhumApontamentoInformado: Boolean;
    procedure pCarregaTabela;
    procedure pPreparaEdicaoApontamento;
    procedure pApontamento;
    procedure pQueryAfterOpen(DataSet: TDataSet);
    procedure pQueryBeforePost(DataSet: TDataSet);
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;

implementation

{$R *.dfm}

uses untTypesSistema, untFuncoesSimples, untConsultas, untProjetos;

{ TfrmDigRecursosProjeto }

procedure TfrmDigRecursosProjeto.btnAlterarClick(Sender: TObject);
begin
  inherited;

  cxgGridProDet.Enabled := True;
  pnlCampos.Enabled := True;
  pnlGrid.Enabled   := True;
  blnValidaCampos   := True;
  dbeCodOpe.Enabled := False;
  dbeDtaCad.Enabled := False;
  pLimparCampos(False);
  pSetFocus(edtCodRep);
end;

procedure TfrmDigRecursosProjeto.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pLimparCampos(False);
  cxgGridProDet.Enabled := False;
end;

procedure TfrmDigRecursosProjeto.btnCancelCliClick(Sender: TObject);
begin
  inherited;
  pLimparCampos(False);
  pSetFocus(edtCodRep);
  cxgGridProDet.Enabled := True;
end;

procedure TfrmDigRecursosProjeto.btnExcluirClick(Sender: TObject);
var
  strCodPrj: String;
begin
  strCodPrj := dbeCodPrj.Text;
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmDigRecursosProjeto.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  Begin
    fCommit;
    If Not fEmptyStr(strCodPrj) Then
      TProjeto.pRecalculaRecursos(strCodPrj);
    pLimparCampos(True, True)
  End
  Else
  Begin
    cxgGridProDet.Enabled := False;
    fRollBack;
  End;
end;

procedure TfrmDigRecursosProjeto.btnGravarClick(Sender: TObject);
begin
  blnValidaCampos := False;
  If Not fValidacoesBotaoGravarPai Then
  Begin
    blnValidaCampos := True;
    Exit;
  End
  Else
    blnValidaCampos := True;

  If fNenhumApontamentoInformado Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhum apontamento foi informado!', ['&Ok']);
    Exit;
  End;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  Try
    inherited;

    If blnGravou Then
    Begin
      pGravaLancamentos;
      fCommit;
    End
    Else
      fRollBack;

    TProjeto.pRecalculaRecursos(dbeCodPrj.Text);

    cxgGridProDet.Enabled := False;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmDigRecursosProjeto.btnGravarClick]');
      fRollBack;
    End;
  End;
end;

procedure TfrmDigRecursosProjeto.btnIncCliClick(Sender: TObject);
begin
  blnValidaCampos := True;
  If Not fVerificaCampos Then
    Exit;

  pGravaLancamento;
  cxgGridProDet.Enabled := True;

  If Not fEmptyStr(cdsProDet.FieldByName('AUTOINCREM').AsString) Then
    pSetFocus(cxgGridProDet);
end;

procedure TfrmDigRecursosProjeto.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pLimparCampos(True, True);

  dbeCodOpe.Text := strLoginUsuarioLogado;
  dbeDtaCad.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
  edtNomOpe.Text := fRetNomVendRep(dbeCodOpe.Text);
  pSetFocus(dbeCodPrj);
  dbeCodOpe.Enabled := False;
  dbeDtaCad.Enabled := False;
  cxgGridProDet.Enabled := True;
end;

procedure TfrmDigRecursosProjeto.btnPesquisaClick(Sender: TObject);
  Var
    arrDig : TConsultasArray;
    chrKey : Char;
begin
  chrKey := '/';
  If fPesqDigRecursoProjeto(Self, Nil, Nil, qryTabela, chrKey, arrDig) Then
  Begin
    pCarregaTabela;
    cxgGridProDet.Enabled := False;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmDigRecursosProjeto.cxgGridProDetExit(Sender: TObject);
begin
  inherited;
  If cxgGridProDet.Enabled Then
    pLimparCampos(False);
end;

procedure TfrmDigRecursosProjeto.cxgGridProDetViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If cxgGridProDet.Enabled Then
    pApontamento;
end;

procedure TfrmDigRecursosProjeto.cxgGridProDetViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_DELETE) Then
  Begin
    If cdsProDet.Active And (cdsProDet.RecordCount > 0) And
       (fMensagem('', 'Deseja Remover o apontamento selecionado?', ['&Sim', '&Não'], 2) = 2) Then
      Key := 0;
  End
  Else
  If (Key = VK_Return) Then
    pPreparaEdicaoApontamento
  Else
  If (Key = VK_ESCAPE) Then
    btnSairClick(Sender);
end;

procedure TfrmDigRecursosProjeto.cxgGridProDetViewKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If cxgGridProDet.Enabled Then
    pApontamento;
end;

procedure TfrmDigRecursosProjeto.cxgGridProDetViewKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If cxgGridProDet.Enabled Then
    pApontamento;
end;

procedure TfrmDigRecursosProjeto.dbeCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, dbeCodCli, edtNomCli, Nil, Key, arrClientes,
                  True,
                  Nil,
                  False,
                  '',
                  '',
                  True,
                  '',
                  dbeCodPrj.Text) Then
  Begin
    If fValidaCampos(dbeCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigRecursosProjeto.dbeCodPrjKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrPrj : TConsultasArray;
begin
  If fPesqProjetos(Self, dbeCodPrj, edtDesPrj, nil, Key, arrPrj) Then
  Begin
    If fValidaCampos(dbeCodPrj, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigRecursosProjeto.dtaFinDiaExit(Sender: TObject);
  Var
    intQtdDias : Integer;
begin
  inherited;
  If Not fEmptyStr(fTiraCaracEspeciais(dtaFinDia.Text)) And Not fEmptyStr(fTiraCaracEspeciais(dtaIniDia.Text)) Then
  Begin
    intQtdDias :=DaysBetween(StrToDate(dtaIniDia.Text),StrToDate(dtaFinDia.Text));
    edtQuant.Text := IntToStr(intQtdDias + 1);
  End;
end;

procedure TfrmDigRecursosProjeto.edtCodRepEnter(Sender: TObject);
begin
  inherited;
  blnValidaCampos := True;
end;

procedure TfrmDigRecursosProjeto.edtCodRepKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrRec : TConsultasArray;
begin
  If fPesqRecursoProjeto(Self, edtCodRep, edtNomRep, nil, Key, arrRec) Then
  Begin
    If fValidaCampos(edtCodRep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigRecursosProjeto.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmDigRecursosProjeto.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela       := 'PROGER';
  strNomeCampo        := 'AUTOINCREM';
  qryTabela           := fCriaQuery(Self);
  qryTabela.AfterOpen   := pQueryAfterOpen;
  qryTabela.AfterCancel := pQueryAfterOpen;
  qryTabela.BeforePost  := pQueryBeforePost;
  dtsTabela.DataSet     := qryTabela;

  qryProDet := fCriaQuery(Self);
  cdsProDet := fCriaCdsProDet(Self);
  dspProDet := TUniDataSetProvider.Create(Self);
  dtsProDet := fCriaDataSource(cdsProDet);
  dspProDet.DataSet := qryProDet;
  blnUsaVerificaCamposPai := False;

  cxgGridProDetView.DataController.DataSource := dtsProDet;
end;

procedure TfrmDigRecursosProjeto.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(qryProDet);
  FreeAndNil(cdsProDet);
  FreeAndNil(dspProDet);
end;

procedure TfrmDigRecursosProjeto.FormShow(Sender: TObject);
begin
  inherited;
  pnlCampos.Height := 80;
  pValidaTipoRecurso;
  If fVerificaAcessoSistema('PERRECOPERADOR', strLoginUsuarioLogado) Then
    shpRec.Brush.Color  := clGreen
  Else
    shpRec.Brush.Color  := clRed;
end;

procedure TfrmDigRecursosProjeto.pGravaLancamento;
var
  dtaDataIni,
  dtaDataFin: TDateTime;
  intValor : Integer; // Valor sem a parte fracionada
  fltValorFra: Double;// Valor da parte fracionada

begin
  If Not cdsProDet.Active Then
    pCarregaLancamentos;

  With cdsProDet Do
  Begin
    If (Not cxgGridProDet.Enabled)  Then
      Edit
    Else
      Append;

    FieldByName('DET_CODREP').AsString := edtCodRep.Text;
    FieldByName('DET_NOMREP').AsString := edtNomRep.Text;
    FieldByName('DET_QUANTI').AsInteger := 0;

    If Not (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
    Begin
      FieldByName('DET_DTAINI').AsDateTime := StrToDateTimeDef(mskDtaIni.Text + ' ' + mskHorIni.Text + ':00', 0);
      FieldByName('DET_DTAFIN').AsDateTime := StrToDateTimeDef(mskDtaFin.Text + ' ' + mskHorFin.Text + ':00', 0);
      dtaDataIni := FieldByName('DET_DTAINI').AsDateTime;
      dtaDataFin := FieldByName('DET_DTAFIN').AsDateTime;
      FieldByName('DET_QTDHOR').AsString  := FloatToStr(MinutesBetween(dtaDataFin,dtaDataIni)/60);
      If Not fEmptyStr(cdsProDet.FieldByName('DET_QTDHOR').AsString)  Then
      Begin
        intValor := Trunc(StrToFloat(cdsProDet.FieldByName('DET_QTDHOR').AsString));
        fltValorFra := (StrToFloat(cdsProDet.FieldByName('DET_QTDHOR').AsString) - intValor);
        FieldByName('DET_QTDHOR').AsString :=  fStrZero(IntToStr(intValor),2) + ':' + fStrZero(FloatToStr(Round(fltValorFra * 60)),2);
      End;
    End
    Else
    Begin
      If Not (fEmptyStr(fTiraCaracEspeciais(dtaIniDia.Text))) Then
      Begin
        FieldByName('DET_DTAINI').AsDateTime := StrToDateTimeDef(dtaIniDia.Text, 0);
        FieldByName('DET_DTAFIN').AsDateTime := StrToDateTimeDef(dtaFinDia.Text, 0);
        FieldByName('DET_QUANTI').AsInteger := DaysBetween(FieldByName('DET_DTAINI').AsDateTime,FieldByName('DET_DTAFIN').AsDateTime) + 1;
      End
      Else
      Begin
        FieldByName('DET_DTAINI').Value := Null;
        FieldByName('DET_DTAFIN').Value := Null;
      End;
    End;

    If StrToIntDef(fTiraCaracEspeciais(edtKmIni.Text,False,False,True), 0) > 0 Then
    Begin
      FieldByName('DET_KMTINI').AsInteger := StrToIntDef(fTiraCaracEspeciais(edtKmIni.Text,False,False,True), 0);
      FieldByName('DET_KMTFIN').AsInteger := StrToIntDef(fTiraCaracEspeciais(edtKmFin.Text,False,False,True), 0);
      FieldByName('DET_QUANTI').AsInteger := FieldByName('DET_KMTFIN').AsInteger - FieldByName('DET_KMTINI').AsInteger;
    End
    Else
    Begin
      FieldByName('DET_KMTINI').Value := Null;
      FieldByName('DET_KMTFIN').Value := Null;
    End;

    If Not fEmptyStr(Trim(edtObs.Text)) Then
      FieldByName('DET_OBSERV').AsString := edtObs.Text
    Else
      FieldByName('DET_OBSERV').AsString := '';


    Post;

    pLimparCampos(False);

    pSetFocus(edtCodRep);
  End;
end;

procedure TfrmDigRecursosProjeto.pGravaLancamentos;
begin

  If Not cdsProDet.Active Then
    Exit;

  With cdsProDet Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      Edit;

      FieldByName('DET_SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PRODET', VS_strCodEmp);

      Post;
      Next;
    End;

    ApplyUpdates(0);

    EnableControls;
  End;
end;

function TfrmDigRecursosProjeto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    dtaDataIni,
    dtaDataFin: TDateTime;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin

    If Sender = dbeCodPrj Then
    Begin
      If fEmptyStr(dbeCodPrj.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do projeto deve ser preenchido!', ['&Ok']);
        Result :=False;
      End
      Else
      Begin
        edtDesPrj.Text := fCampoTabela('PRJ_DESPRJ', 'CADPRJ', ['PRJ_CODPRJ'], [dbeCodPrj.Text], False);

        If fEmptyStr(edtDesPrj.Text) Then
        Begin
          fMensagem('', 'Projeto não encontrado !', ['&Ok']);
          Result := False;
          edtDesPrj.Clear;
        End
        Else
        If fCampoTabela('PRJ_SITUAC', 'CADPRJ', ['PRJ_CODPRJ'], [dbeCodPrj.Text], False) = 'I' Then
        Begin
          fMensagem('ATENÇÃO!', 'O projeto informado foi Inativado. Verifique!', ['&Ok']);
          Result :=False;
        End
        Else
        If blnBuscaPorChave And TProjeto.fUnicoClienteProjeto(dbeCodPrj.Text, dbeCodCli) Then
        Begin
          qryTabela.FieldByName('GER_CODCLI').AsString := dbeCodCli.Text;
          fValidaCampos(dbeCodCli, True);
        End;
      End;
    End
    Else
    If Sender = dbeCodCli Then
    Begin
      If fEmptyStr(dbeCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do cliente deve ser preenchido!', ['&Ok']);
        Result :=False;
      End
      Else
      Begin
        edtNomCli.Text := fRetNomCliente(dbeCodCli.Text);
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('', 'Cliente não encontrado !', ['&Ok']);
          Result := False;
          edtNomCli.Clear;
        End
        Else
        If Not TProjeto.fClienteNoProjeto(dbeCodPrj.Text, dbeCodCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O cliente informado não faz parte do projeto!', ['&Ok']);
          Result :=False;
        End;
      End;
    End
    Else
    If (Sender = edtCodRep) And blnValidaCampos Then
    Begin
      If fEmptyStr(edtCodRep.Text) Then
      Begin
        strTipCap := '';
        fMensagem('ATENÇÃO!', 'O código do recurso deve ser preenchido!', ['&Ok']);
        Result :=False;
      End
      Else
      Begin
        edtNomRep.Text := fCampoTabela('REP_NOMREP', 'CADREP', ['REP_CODREP'], [edtCodRep.Text], False);

        If fEmptyStr(edtNomRep.Text) Then
        Begin
          strTipCap := '';
          fMensagem('', 'Recurso não encontrado !', ['&Ok']);
          Result := False;
          edtNomRep.Clear;
        End
        Else If (fCampoTabela('REP_SITUAC', 'CADREP', ['REP_CODREP'], [edtCodRep.Text], False) = 'I') And
             Not (cdsProDet.State in [dsEdit]) And cxgGridProDet.Enabled Then
        Begin
          strTipCap := '';
          fMensagem('ATENÇÃO', 'Recurso Inativo !', ['&Ok']);
          Result := False;
          edtNomRep.Clear;
        End
        Else
        Begin
          strTipCap := fCampoTabela('REP_TIPCAP', 'CADREP', ['REP_CODREP'], [edtCodRep.Text], False);
          strCodOpe := fCampoTabela('REP_CODOPE', 'CADREP', ['REP_CODREP'], [edtCodRep.Text], False);
          strTipRec := fCampoTabela('REP_TIPREP', 'CADREP', ['REP_CODREP'], [edtCodRep.Text], False);

          If (strTipRec = 'C') And (Not fVerificaAcessoSistema('PERRECOPERADOR', strLoginUsuarioLogado)) And (strCodOpe <> strLoginUsuarioLogado) Then
          Begin
            strTipCap := '';
            fMensagem('ATENÇÃO!', 'Você só poderá utilizar recursos do operador '+strLoginUsuarioLogado+' !!', ['&Ok']);
            Result :=False;
          End
          Else
            pValidaTipoRecurso;
        End;
      End;
    End
    Else
    If (Sender = mskDtaIni) And (strTipCap = 'H') And blnValidaCampos Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      If Not (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And
        (StrToDate(mskDtaFin.Text) < StrToDate(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial não pode ser maior que a data final!', ['&Ok']);
        Result := False;
      End;
    End

    Else
    If (Sender = dtaIniDia) And (strTipCap = 'D') And blnValidaCampos Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(dtaIniDia.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      If Not (fEmptyStr(fTiraCaracEspeciais(dtaFinDia.Text))) And
        (StrToDate(dtaFinDia.Text) < StrToDate(dtaIniDia.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial não pode ser maior que a data final!', ['&Ok']);
        Result := False;
      End;
    End

    Else
    If (Sender = mskHorIni) And (strTipCap = 'H') And blnValidaCampos Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskHorIni.Text, True, True, True, True)) Or
         (Length(fTiraCaracEspeciais(mskHorIni.Text, True, True, True, True)) < 4) Or
         (StrToTimeDef(mskHorIni.Text, -1) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Defina a hora inicial corretamente!', ['&Ok']);
        Result := False;
      End
      Else
      If (Not fEmptyStr(fTiraCaracEspeciais(mskHorFin.Text, True, True, True, True))) And
         (StrToDate(mskDtaFin.Text) = StrToDate(mskDtaIni.Text)) And
         (StrToTimeDef(mskHorFin.Text, -1) <= StrToTimeDef(mskHorIni.Text, -1)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A hora inicial deve ser menor que a hora final!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    If (Sender = mskDtaFin) And (strTipCap = 'H') And blnValidaCampos Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      If StrToDate(mskDtaFin.Text) < StrToDate(mskDtaIni.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final não pode ser menor que a data inicial!', ['&Ok']);
        Result := False;
      End;
    End

    Else
    If (Sender = dtaFinDia) And (strTipCap = 'D') And blnValidaCampos Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(dtaFinDia.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      If StrToDate(dtaFinDia.Text) < StrToDate(dtaIniDia.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final não pode ser menor que a data inicial!', ['&Ok']);
        Result := False;
      End;
    End

    Else
    If (Sender = mskHorFin) And (strTipCap = 'H') And blnValidaCampos Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskHorFin.Text, True, True, True, True)) Or
         (Length(fTiraCaracEspeciais(mskHorFin.Text, True, True, True, True)) < 4) Or
         (StrToTimeDef(mskHorFin.Text, -1) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Defina a hora final corretamente!', ['&Ok']);
        Result := False;
      End
      Else
      If (StrToDate(mskDtaFin.Text) = StrToDate(mskDtaIni.Text)) And
         (StrToTimeDef(mskHorFin.Text, -1) <= StrToTimeDef(mskHorIni.Text, -1)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A hora final deve ser maior que a hora inicial!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        dtaDataIni:= StrToDateTimeDef(mskDtaIni.Text + ' ' + mskHorIni.Text + ':00', 0);
        dtaDataFin := StrToDateTimeDef(mskDtaFin.Text + ' ' + mskHorFin.Text + ':00', 0);
        If (Trunc(MinutesBetween(dtaDataFin,dtaDataIni)/60) > 99) Then
        Begin
          fMensagem('ATENÇÃO!', 'A quantidade maxima permitido é de 99:59 horas !', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else
    If (Sender = edtKmIni) And (strTipCap = 'K') And blnValidaCampos Then
    Begin
      If StrToIntDef(fTiraCaracEspeciais(edtKmIni.Text,False,False,True), 0) = 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Defina o Km Inicial corretamente!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    If (Sender = edtKmFin) And (strTipCap = 'K') And blnValidaCampos Then
    Begin
      If StrToIntDef(fTiraCaracEspeciais(edtKmFin.Text,False,False,True), 0) = 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Defina o Km Final corretamente!', ['&Ok']);
        Result := False;
      End
      Else
      If (StrToInt(fTiraCaracEspeciais(edtKmFin.Text,False,False,True)) <=
          StrToInt(fTiraCaracEspeciais(edtKmIni.Text,False,False,True))) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Km Final deve ser maior que o Km Inicial!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    If (Sender = edtQuant) And (strTipCap = 'D') And blnValidaCampos Then
    Begin
      If StrToIntDef(edtQuant.Text, 0) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Defina a quantidade de dias corretamente!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmDigRecursosProjeto.mskDtaIniExit(Sender: TObject);
begin
  inherited;
  If (Not (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)))) And
     fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
    mskDtaFin.Text := mskDtaIni.Text;
end;

procedure TfrmDigRecursosProjeto.pInicializaIndices;
begin
  inherited;

end;

procedure TfrmDigRecursosProjeto.pLimparCampos(blnCabecalho: Boolean; blnGrid: Boolean = False);
begin
  If blnCabecalho Then
  Begin
    edtDesPrj.Clear;
    edtNomCli.Clear;
    edtNomOpe.Clear;
  End;

  If blnGrid Then
  Begin
   If cdsProDet.Active Then
     cdsProDet.EmptyDataSet;
  End;

  edtCodRep.Clear;
  edtNomRep.Clear;
  edtKmIni.Clear;
  edtObs.Clear;
  edtKmFin.Clear;
  edtQuant.Clear;
  mskDtaIni.Clear;
  mskDtaFin.Clear;
  mskHorIni.Clear;
  mskHorFin.Clear;
  dtaIniDia.Clear;
  dtaFinDia.Clear;
end;

procedure TfrmDigRecursosProjeto.pValidaTipoRecurso;
begin

  If fEmptyStr(strTipCap) Then
    strTipCap := 'H';

  If strTipCap = 'H' Then
  Begin
    pnlDataHora.Visible   := True;
    pnlDataHora.Enabled   := True;
    pnlKm.Visible         := False;
    pnlKm.Enabled         := False;
    pnlQuantidade.Visible := False;
    pnlQuantidade.Enabled := False;

    edtKmIni.Clear;
    edtKmFin.Clear;
    edtQuant.Clear;
    dtaIniDia.Clear;
    dtaFinDia.Clear;
  End
  Else
  If strTipCap = 'K' Then
  Begin
    pnlDataHora.Visible   := False;
    pnlDataHora.Enabled   := False;
    pnlKm.Visible         := True;
    pnlKm.Enabled         := True;
    pnlQuantidade.Visible := False;
    pnlQuantidade.Enabled := False;

    mskDtaIni.Clear;
    mskDtaFin.Clear;
    mskHorIni.Clear;
    mskHorFin.Clear;
    edtQuant.Clear;
    dtaIniDia.Clear;
    dtaFinDia.Clear;
  End
  Else
  If strTipCap = 'D' Then
  Begin
    pnlDataHora.Visible   := False;
    pnlDataHora.Enabled   := False;
    pnlKm.Visible         := False;
    pnlKm.Enabled         := False;
    pnlQuantidade.Visible := True;
    pnlQuantidade.Enabled := True;

    mskDtaIni.Clear;
    mskDtaFin.Clear;
    mskHorIni.Clear;
    mskHorFin.Clear;
    edtKmIni.Clear;
    edtKmFin.Clear;
  End;
end;

function TfrmDigRecursosProjeto.fCriaCdsProDet(AOwner: TComponent): TUniClientDataSet;
Begin
  Result := TUniClientDataSet.Create(AOwner);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'AUTOINCREM';
    DataType:= ftString;
    Size:= 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'DET_SEQGER';
    DataType:= ftString;
    Size:= 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'DET_CODREP';
    DataType:= ftString;
    Size:= 6;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'DET_NOMREP';
    DataType:= ftString;
    Size:= 60;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'DET_DTAINI';
    DataType:= ftDateTime;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'DET_DTAFIN';
    DataType:= ftDateTime;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'DET_KMTINI';
    DataType:= ftInteger;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'DET_KMTFIN';
    DataType:= ftInteger;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'DET_QUANTI';
    DataType:= ftInteger;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'DET_OBSERV';
    DataType:= ftString;
    Size:= 50;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'DET_QTDHOR';
    DataType:= ftString;
    Size:= 5;
  End;

end;

function TfrmDigRecursosProjeto.fNenhumApontamentoInformado: Boolean;
begin
  If cdsProDet.Active Then
    Result := cdsProDet.RecordCount = 0
  Else
    Result := True;
end;

procedure TfrmDigRecursosProjeto.pCarregaTabela;
begin

  If Not fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) Then
  Begin
    With qryTabela Do
    Begin
      edtDesPrj.Text := fCampoTabela('PRJ_DESPRJ', 'CADPRJ', ['PRJ_CODPRJ'], [dbeCodPrj.Text], False);
      edtNomCli.Text := fRetNomCliente(dbeCodCli.Text);
      edtNomOpe.Text := fRetNomVendRep(dbeCodOpe.Text);

      pCarregaLancamentos(qryTabela.FieldByName('AUTOINCREM').AsString);
    End;
  End
  Else
  Begin
    edtDesPrj.Clear;
    edtNomCli.Clear;
    edtNomOpe.Clear;
  End;
end;

procedure TfrmDigRecursosProjeto.pPreparaEdicaoApontamento;
begin
  With cdsProDet Do
  Begin
    edtCodRep.Text := FieldByName('DET_CODREP').AsString;
    edtObs.text :=  FieldByName('DET_OBSERV').AsString;
    cxgGridProDet.Enabled := False;
    If Not fValidaCampos(edtCodRep, False) Then
    Begin
      cxgGridProDet.Enabled := True;
      edtCodRep.Clear;
      edtObs.Clear;
      Exit;
    End;
    If (FieldByName('DET_DTAINI').Value <> Null) And (FieldByName('DET_QTDHOR').AsString <> '') Then
    Begin
      mskDtaIni.Text := FormatDateTime('dd/mm/yyyy', FieldByName('DET_DTAINI').AsDateTime);
      mskHorIni.Text := FormatDateTime('hh:mm', FieldByName('DET_DTAINI').AsDateTime);
      mskDtaFin.Text := FormatDateTime('dd/mm/yyyy', FieldByName('DET_DTAFIN').AsDateTime);
      mskHorFin.Text := FormatDateTime('hh:mm', FieldByName('DET_DTAFIN').AsDateTime);
    End
    Else
    If FieldByName('DET_KMTINI').Value <> Null Then
    Begin
      edtKmIni.Text := IntToStr(FieldByName('DET_KMTINI').AsInteger);
      edtKmFin.Text := IntToStr(FieldByName('DET_KMTFIN').AsInteger);
    End
    Else
    Begin
      dtaIniDia.Text := FormatDateTime('dd/mm/yyyy', FieldByName('DET_DTAINI').AsDateTime);
      dtaFinDia.Text := FormatDateTime('dd/mm/yyyy', FieldByName('DET_DTAFIN').AsDateTime);
      edtQuant.Text := IntToStr(FieldByName('DET_QUANTI').AsInteger);
    End;
  End;
  pSetFocus(edtCodRep);
  With cdsProDet Do
  Begin
    If (Not cxgGridProDet.Enabled)  Then
      Edit;
  End;
end;

procedure TfrmDigRecursosProjeto.pQueryAfterOpen(DataSet: TDataSet);
begin
  pCarregaTabela;
end;

procedure TfrmDigRecursosProjeto.pQueryBeforePost(DataSet: TDataSet);
begin
  qryTabela.FieldByName('GER_CODOPE').AsString   := strLoginUsuarioLogado;
  qryTabela.FieldByName('GER_DTACAD').AsDateTime := VS_Date;
end;

procedure TfrmDigRecursosProjeto.pApontamento;
begin
  With cdsProDet Do
  Begin
    edtCodRep.Text := FieldByName('DET_CODREP').AsString;
    edtObs.text :=  FieldByName('DET_OBSERV').AsString;
    strTipCap := fCampoTabela('REP_TIPCAP', 'CADREP', ['REP_CODREP'], [edtCodRep.Text], False);
    pValidaTipoRecurso;
    If (FieldByName('DET_DTAINI').Value <> Null) And (FieldByName('DET_QTDHOR').AsString <> '') Then
    Begin
      mskDtaIni.Text := FormatDateTime('dd/mm/yyyy', FieldByName('DET_DTAINI').AsDateTime);
      mskHorIni.Text := FormatDateTime('hh:mm', FieldByName('DET_DTAINI').AsDateTime);
      mskDtaFin.Text := FormatDateTime('dd/mm/yyyy', FieldByName('DET_DTAFIN').AsDateTime);
      mskHorFin.Text := FormatDateTime('hh:mm', FieldByName('DET_DTAFIN').AsDateTime);
    End
    Else
    If FieldByName('DET_KMTINI').Value <> Null Then
    Begin
      edtKmIni.Text := IntToStr(FieldByName('DET_KMTINI').AsInteger);
      edtKmFin.Text := IntToStr(FieldByName('DET_KMTFIN').AsInteger);
    End
    Else
    Begin
      dtaIniDia.Text := FormatDateTime('dd/mm/yyyy', FieldByName('DET_DTAINI').AsDateTime);
      dtaFinDia.Text := FormatDateTime('dd/mm/yyyy', FieldByName('DET_DTAFIN').AsDateTime);
      edtQuant.Text := IntToStr(FieldByName('DET_QUANTI').AsInteger);
    End;
  End;
end;

procedure TfrmDigRecursosProjeto.pCarregaLancamentos(strSeqPrj: String = '');
Begin
  TProjeto.pCarregaApontamentos(strSeqPrj, qryProDet);
  With qryProDet, SQL Do
  Begin

    cdsProDet.Close;
    cdsProDet.SetProvider(dspProDet);

    Open;
    pSetaClient(qryProDet);
    cdsProDet.Open;
  End;
End;

end.
