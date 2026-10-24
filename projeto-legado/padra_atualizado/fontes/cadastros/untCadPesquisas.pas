unit untCadPesquisas;

interface

uses
  Windows, Classes, Controls,
  untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Mask, DBCtrls, DBEditFocus, UniDataSetProvider, UniClientDataSet, Uni,
  BitBtnLockedIncrem,
  QColorLabel, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadPesquisas = class(TfrmPaiCad)
    pnlDados: TPanel;
    Panel1: TPanel;
    pnlPerguntas: TPanel;
    cxgPesPerDBTableView1: TcxGridDBTableView;
    cxgPesPerLevel1: TcxGridLevel;
    cxgPesPer: TcxGrid;
    cxgPesPerDBTableView1Column1: TcxGridDBColumn;
    dtsPerRes: TDataSource;
    cdsPesPer: TUniClientDataSet;
    dspPesPer: TUniDataSetProvider;
    dtsTabela: TDataSource;
    cxStyleRepository: TcxStyleRepository;
    cxsWhite: TcxStyle;
    cxsGreen: TcxStyle;
    lbl3: TLabel;
    dbeCodPes: TDBEditFocus;
    lbl2: TLabel;
    dbeDesPes: TDBEditFocus;
    Label67: TLabel;
    ColorLabel4: TColorLabel;
    dbeAtivo: TDBEditFocus;
    lblSitPro: TLabel;
    edtDesPer: TEditFocus;
    edtCodPer: TEditFocus;
    cxgPesPerDBTableView1Column2: TcxGridDBColumn;
    btnMoveCima: TBitBtnLocked;
    btnMoveBaixo: TBitBtnLocked;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgPesPerDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtCodPerKeyPress(Sender: TObject; var Key: Char);
    procedure btnMoveCimaClick(Sender: TObject);
    procedure btnMoveBaixoClick(Sender: TObject);
    procedure cdsPesPerAfterScroll(DataSet: TDataSet);
    procedure cdsPesPerAfterOpen(DataSet: TDataSet);
    procedure cdsPesPerAfterClose(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    qryPesPer: TUniQuery;

    intMaxSeqPes,
    intRecNo: Integer;

    procedure pCarregaPergunta;
    procedure pLimpaEdits;
    procedure pAbrePerguntas(strCodigo: String);
    procedure pSalvaReferencia;
    Procedure pAdicionaPergunta(strCodPer:String);
    procedure pHabilitaBtnMove;
    procedure pRetMaxSeqPes;

    function fInativaPesquisas(strAutIncPes: string): Boolean;
  public
    { Public declarations }
  protected
    { Protected declarations }
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

implementation

{$R *.dfm}

Uses
  SysUtils, untConsultas, Forms, untFuncoesSimples, untTypesSistema;

procedure TfrmCadPesquisas.pInicializaIndices;
Begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('PES_CODEMP');
  stlCamInd.Add('PES_CODPES');
  stlCamInd.Add('PES_DESPES');  

  stlDesInd.Add('Empresa');
  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');  
end;

procedure TfrmCadPesquisas.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pnlPerguntas.Enabled := True;
  pHabilitaCodigo(dbeCodPes, TDBEdit(dbeAtivo), False);
  pHabilitaBtnMove;
end;

procedure TfrmCadPesquisas.pLimpaEdits;
Begin
  edtCodPer.Clear;
  edtDesPer.Clear;
  intRecNo := -1;
End;

procedure TfrmCadPesquisas.pSalvaReferencia;
Begin
  With cdsPesPer Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      Edit;

      If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PESPER', VS_strCodEmp);

      If fEmptyStr(FieldByName('PER_SEQPES').AsString) Then
        FieldByName('PER_SEQPES').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;

      Post;

      Next;
    End;

    EnableControls;
  End;
End;

procedure TfrmCadPesquisas.btnCancelaClick(Sender: TObject);
begin
  inherited;

  cdsPesPer.CancelUpdates;
  If Not qryTabela.IsEmpty Then
  Begin
    pLimpaEdits;
    pAbrePerguntas(qryTabela.FieldByName('AUTOINCREM').AsString);
    pSetFocus(btnAlterar);
  End;
  pnlPerguntas.Enabled := False;
end;

procedure TfrmCadPesquisas.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadPesquisas.btnExcluirClick]');
    End;
  End;

  If (blnExcluiu) Then
  Begin
    fCommit;
    pLimpaEdits;
    pAbrePerguntas(qryTabela.FieldByName('AUTOINCREM').AsString);
  End
  Else
    fRollBack;
end;

procedure TfrmCadPesquisas.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadPesquisas.btnGravarClick]');
    End;
  End;

  Try
    pSalvaReferencia;

    If blnGravou Then
    Begin
      If dbeAtivo.Text = 'S' Then
        fInativaPesquisas(qryTabela.FieldByName('AUTOINCREM').AsString);

      cdsPesPer.ApplyUpdates(0);
      fCommit;
    End
    Else
      fRollBack;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message,'[untCadPesquisas.btnGravarClick]');
    End;
  End;

  pHabilitaBtnMove;
  pnlPerguntas.Enabled := False;
end;

procedure TfrmCadPesquisas.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodPes, TDBEdit(dbeAtivo), False);
  pAbrePerguntas('');
  pnlPerguntas.Enabled := True;
end;

procedure TfrmCadPesquisas.btnMoveBaixoClick(Sender: TObject);
var
  intSeqAtu,
  intSeqPrx: Integer;
begin
  intSeqPrx := 0;

  Try
    cdsPesPer.DisableControls;

    intSeqAtu :=cdsPesPer.FieldByName('PER_SEQUEN').AsInteger;
    cdsPesPer.Next;
    intSeqPrx :=cdsPesPer.FieldByName('PER_SEQUEN').AsInteger;

    cdsPesPer.Locate('PER_SEQUEN',intSeqAtu,[]);
    cdsPesPer.Edit;
    cdsPesPer.FieldByName('PER_SEQUEN').AsInteger:=intSeqPrx;
    cdsPesPer.Post;

    cdsPesPer.Locate('PER_SEQUEN',intSeqPrx,[]);
    cdsPesPer.Edit;
    cdsPesPer.FieldByName('PER_SEQUEN').AsInteger:=intSeqAtu;
    cdsPesPer.Post;

    cdsPesPer.EnableControls;
  Finally
    cdsPesPer.Locate('PER_SEQUEN',intSeqPrx,[]);
  End;
end;

procedure TfrmCadPesquisas.btnMoveCimaClick(Sender: TObject);
var
  intSeqAtu,
  intSeqPrx: Integer;
begin
  intSeqPrx := 0;

  Try
    cdsPesPer.DisableControls;

    intSeqAtu :=cdsPesPer.FieldByName('PER_SEQUEN').AsInteger;
    cdsPesPer.Prior;
    intSeqPrx :=cdsPesPer.FieldByName('PER_SEQUEN').AsInteger;

    cdsPesPer.Locate('PER_SEQUEN',intSeqAtu,[]);
    cdsPesPer.Edit;
    cdsPesPer.FieldByName('PER_SEQUEN').AsInteger:=intSeqPrx;
    cdsPesPer.Post;

    cdsPesPer.Locate('PER_SEQUEN',intSeqPrx,[]);
    cdsPesPer.Edit;
    cdsPesPer.FieldByName('PER_SEQUEN').AsInteger:=intSeqAtu;
    cdsPesPer.Post;

    cdsPesPer.EnableControls;
  Finally
    cdsPesPer.Locate('PER_SEQUEN',intSeqPrx,[]);
  End;
end;

procedure TfrmCadPesquisas.pAbrePerguntas(strCodigo: String);
Begin
  With qryPesPer, SQL Do
  Begin
    cdsPesPer.Close;
    Close;

    Clear;
    Add(' SELECT PP.*, CP.PER_DESPER ');
    Add(' FROM CADPER CP ');
    Add(' JOIN PESPER PP ON CP.PER_CODPER = PP.PER_CODPER');
    Add(' WHERE ');

    If fEmptyStr(strCodigo) Then
      Add('FALSE')
    Else
      Add('PP.PER_SEQPES = ' + QuotedStr(strCodigo));

    dspPesPer.DataSet := qryPesPer;
    cdsPesPer.SetProvider(dspPesPer);

    Open;

    pSetaClient(qryPesPer);
    pSetaClient(cdsPesPer);

    cdsPesPer.IndexFieldNames := 'PER_SEQUEN';
    cdsPesPer.Open;

    pRetMaxSeqPes;

    pHabilitaBtnMove;
  End;
End;

procedure TfrmCadPesquisas.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
begin
//  inherited;

  chrKey := '?';
  If fPesqPesquisa(Self, Nil, Nil, qryTabela, chrKey, arrSel) Then
  Begin
    pLimpaEdits;
    pAbrePerguntas(qryTabela.FieldByName('AUTOINCREM').AsString);
    pSetFocus(btnAlterar);
  End
  Else
  Begin
    If cdsPesPer.Active and qryTabela.IsEmpty Then
      cdsPesPer.Close;
  End;
end;

procedure TfrmCadPesquisas.pCarregaPergunta;
Begin
  If Not pnlPerguntas.Enabled Then
    Exit;

  With cdsPesPer Do
  Begin
    If IsEmpty Then
      Exit;

    edtCodPer.Text := FieldByName('PER_CODPER').AsString;
    edtDesPer.Text := fRetNomGeral('PER_DESPER','PER_CODPER','CADPER',FieldByName('PER_CODPER').AsInteger);
    intRecNo := RecNo;
    pSetFocus(edtDesPer);
  End;
End;

procedure TfrmCadPesquisas.pHabilitaBtnMove;
begin
  btnMoveCima.Enabled:=False;
  btnMoveBaixo.Enabled:=False;

  If (not cdsPesPer.IsEmpty) and (btnGravar.Enabled) Then
  Begin
    If (cdsPesPer.RecNo>1) and (cdsPesPer.RecNo<cdsPesPer.RecordCount) Then
    Begin
      btnMoveCima.Enabled:=True;
      btnMoveBaixo.Enabled:=True;
    End
    Else
      If (cdsPesPer.RecNo = 1) Then
        btnMoveBaixo.Enabled:=True
      Else
        btnMoveCima.Enabled:=True;
  End;

  cxgPesPer.Enabled := btnGravar.Enabled;

end;

procedure TfrmCadPesquisas.cdsPesPerAfterClose(DataSet: TDataSet);
begin
  inherited;
  pHabilitaBtnMove;
end;

procedure TfrmCadPesquisas.cdsPesPerAfterOpen(DataSet: TDataSet);
begin
  inherited;
  pHabilitaBtnMove;
end;

procedure TfrmCadPesquisas.cdsPesPerAfterScroll(DataSet: TDataSet);
begin
  inherited;
  pHabilitaBtnMove;
end;

procedure TfrmCadPesquisas.cxgPesPerDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: pCarregaPergunta;
  End;
end;

procedure TfrmCadPesquisas.edtCodPerKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If fPesqPergunta(Self,edtCodPer,edtDesPer,Nil,Key,arrSel) And
     fValidaCampos(edtCodPer, True) Then
    pSetFocus(edtCodPer);
end;

function TfrmCadPesquisas.fInativaPesquisas(strAutIncPes: string): Boolean;
  Var
    strSQL   : String;
    qryGenGer: TUniQuery;
begin
  Try

    qryGenGer := fCriaQuery(Self);

    Try

      strSQL := '';
      strSQL := strSQL + 'UPDATE CADPES ';
      strSQL := strSQL + 'SET   PES_ATIVO_ = "N" ';
      strSQL := strSQL + 'WHERE AUTOINCREM <> '+QuotedStr(strAutIncPes);

      With qryGenGer Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;
      End;

      Result := True;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[fInativaPesquisas]');
        Result := False;
      End;
    End;

  Finally
    FreeAndNil(qryGenGer);
  End;

end;

procedure TfrmCadPesquisas.FormCreate(Sender: TObject);
begin
  inherited;

  intRecNo := -1;
  
  strNomeTabela := 'CADPES';
  strNomeCampo  := 'PES_CODPES';

  qryTabela := fCriarQuery('SELECT * FROM CADPES WHERE FALSE', Self);

  dtsTabela.DataSet   := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodPes;

  qryPesPer := fCriaQuery(Self);

end;

procedure TfrmCadPesquisas.FormShow(Sender: TObject);
begin
  inherited;
  pHabilitaBtnMove;
  pSetFocus(btnIncluir);
end;

Procedure TfrmCadPesquisas.pAdicionaPergunta(strCodPer:String);
Begin
  with cdsPesPer Do
  Begin
    If (RecNo = intRecNo) Or Locate('PER_CODPER', strCodPer, []) Then
    Begin
      Edit
    End
    Else
    Begin
      Insert;

      Inc(intMaxSeqPes);
      FieldByName('PER_SEQUEN').AsInteger:=intMaxSeqPes;
    End;

    FieldByName('PER_CODPER').AsString := strCodPer;
    FieldByName('PER_DESPER').AsString := edtDesPer.Text;
    Post;
    pLimpaEdits;
    pSetFocus(edtCodPer);
  End;
End;

procedure TfrmCadPesquisas.pRetMaxSeqPes;
begin
  intMaxSeqPes:=0;
  Try
    cdsPesPer.DisableControls;
    cdsPesPer.First;

    While not cdsPesPer.Eof Do
    Begin
      If cdsPesPer.FieldByName('PER_SEQUEN').AsInteger > intMaxSeqPes Then
        intMaxSeqPes:=cdsPesPer.FieldByName('PER_SEQUEN').AsInteger;

      cdsPesPer.Next;
    End;
  Finally
    cdsPesPer.First;
    cdsPesPer.EnableControls;
  End;
end;

function TfrmCadPesquisas.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*************************}
    {* PESQUISA              *)
    {*************************}
    If (Sender = dbeDesPes) Then
    Begin

      If fEmptyStr(dbeDesPes.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição da Pesquisa deve ser preenchida!', ['&Ok']);
        Result := False;
      End;

    End

    {*************************}
    {* ATIVO?                *)
    {*************************}
    Else If (Sender = dbeAtivo) Then
    Begin

      If fEmptyStr(dbeAtivo.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Ativo deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If Not fValidoSimNao(dbeAtivo.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo Ativo deve ser preenchido com S ou N!', ['&Ok']);        
          Result := False;
        End;
      End;

    End

    {*************************}
    {* PERGUNTA              *)
    {*************************}
    Else If (Sender = edtCodPer) Then
    Begin

      If fEmptyStr(edtCodPer.Text) Then
      Begin
        edtDesPer.Clear;
        edtCodPer.Clear;
      End Else
      Begin
        edtDesPer.Text := fRetNomGeral('PER_DESPER','PER_CODPER','CADPER',fStrToFloat(edtCodPer.Text));
        If fEmptyStr(edtDesPer.Text) Then
        Begin
          pMensagemOk('Pergunta não econtrada!');
          Result := False;
        End;
      End;

      If Not fEmptyStr(edtDesPer.Text) Then
      Begin
        If Result Then
        Begin
          pAdicionaPergunta(edtCodPer.Text);
          blnMudarFoco := False;
        End;
      End
      Else
      Begin
        If cdsPesPer.IsEmpty Then
        Begin
          pMensagemOk('Informe as perguntas!');
          pSetFocus(edtDesPer);
          Result := False;
        End
        Else
          edtDesPer.Clear;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.

