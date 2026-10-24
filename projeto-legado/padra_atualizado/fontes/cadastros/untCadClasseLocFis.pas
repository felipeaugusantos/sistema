unit untCadClasseLocFis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, Uni, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, untZClient, EditFocus, cxProgressBar,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadClasseLocFis = class(TfrmPaiCad)
    Label2: TLabel;
    dbeSigla: TDBEditFocus;
    dbeCodEmp: TDBEditFocus;
    Bevel1: TBevel;
    cxgClaLocLevel: TcxGridLevel;
    cxgClaLocTableView: TcxGridDBTableViewCitel;
    cxgClaLoc: TcxGridCitel;
    dtsTabela: TDataSource;
    cxgClaLocTableViewLocalizacao: TcxGridDBColumn;
    cxgClaLocTableViewDescricao: TcxGridDBColumn;
    cxgClaLocTableViewAltura: TcxGridDBColumn;
    cxgClaLocTableViewLargura: TcxGridDBColumn;
    cxgClaLocTableViewProfundidade: TcxGridDBColumn;
    cxgClaLocTableViewCapacidade: TcxGridDBColumn;
    cxgClaLocTableViewPeso: TcxGridDBColumn;
    cxgClaLocTableViewPicking: TcxGridDBColumn;
    edtLocFis: TEditFocus;
    edtDescri: TEditFocus;
    Label5: TLabel;
    btnAdicionar: TBitBtnLocked;
    Label1: TLabel;
    btnInclusaoEmMasa: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure cxgClaLocTableViewPickingGetDataText(
      Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
    procedure edtLocFisKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure cxgClaLocTableViewKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnInclusaoEmMasaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    blnMsgDuplicado : Boolean;
    cdsClaLoc : TZClient;
    procedure pCarregaLocalizacaoFisica;
    function fSQLClaLoc: String;
    procedure pCdsClaLocOnNewRecord(DataSet: TDataSet);
    function InclusaoEmMasaProgress(cxProgress: TcxProgressBar): Boolean;
  public
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pOnStateChange;override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConsultas, untCadLocFisSelecao,
  untGravando, untHelperCitel;

procedure TfrmCadClasseLocFis.btnAdicionarClick(Sender: TObject);
  Var
    qryCadLoc : TUniQuery;
begin
  inherited;
  If (cdsClaLoc.Locate('CLL_CODLOC', edtLocFis.Text, [])) Then
  Begin
    If blnMsgDuplicado Then
      fMensagem('', 'Essa Localização Física já está na Classe Atual!', ['&Ok']);

    edtLocFis.Clear;
    edtDescri.Clear;
    pSetFocus(edtLocFis);
    Exit;
  End;

  If fValidaCampos(edtLocFis, True) Then
  Begin
    Try
      qryCadLoc := fCriaQuery;
      With qryCadLoc, SQL Do
      Begin
        Close;
        Clear;
        Add(' SELECT LOC_DESCRI AS DESCRI, ');
        Add('        LOC_ALTURA AS ALTURA, ');
        Add('        LOC_LARGUR AS LARGUR, ');
        Add('        LOC_PROFUN AS PROFUN, ');
        Add('        LOC_CAPACI AS CAPACI, ');
        Add('        LOC_PESMAX AS PESMAX, ');
        Add('        LOC_PICKIN AS PICKIN  ');
        Add(' FROM CADLOC                  ');
        Add(' WHERE LOC_CODEMP = :CODEMP   ');
        Add('   AND LOC_CODLOC = :CODLOC   ');

        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODLOC').AsString := edtLocFis.Text;

        Open;
      End;

      cdsClaLoc.Append;
      cdsClaLoc.FieldByName('CLL_CODLOC').AsString := edtLocFis.Text;
      cdsClaLoc.FieldByName('DESCRI').AsString := qryCadLoc.FieldByName('DESCRI').AsString;
      cdsClaLoc.FieldByName('ALTURA').AsFloat  := qryCadLoc.FieldByName('ALTURA').AsFloat;
      cdsClaLoc.FieldByName('LARGUR').AsFloat  := qryCadLoc.FieldByName('LARGUR').AsFloat;
      cdsClaLoc.FieldByName('PROFUN').AsFloat  := qryCadLoc.FieldByName('PROFUN').AsFloat;
      cdsClaLoc.FieldByName('CAPACI').AsFloat  := qryCadLoc.FieldByName('CAPACI').AsFloat;
      cdsClaLoc.FieldByName('PESMAX').AsFloat  := qryCadLoc.FieldByName('PESMAX').AsFloat;
      cdsClaLoc.FieldByName('PICKIN').AsString := qryCadLoc.FieldByName('PICKIN').AsString;
      cdsClaLoc.Post;

      edtLocFis.Clear;
      edtDescri.Clear;
      pSetFocus(edtLocFis);
    Finally
      FreeAndNil(qryCadLoc);
    End;
  End;
end;

procedure TfrmCadClasseLocFis.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeSigla);
end;

procedure TfrmCadClasseLocFis.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaLocalizacaoFisica;
end;

procedure TfrmCadClasseLocFis.btnExcluirClick(Sender: TObject);
begin
  If qryTabela.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  Try
    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

    cdsClaLoc.First;
    While not cdsClaLoc.Eof Do
      cdsClaLoc.Delete;

    If cdsClaLoc.fSalva Then
      inherited;

    if blnExcluiu then
      fCommit
    else
      fRollBack;

    pCarregaLocalizacaoFisica;
  Except
    On E : Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, 'TfrmCadClasseLocFis.btnExcluirClick');
    End;
  End;
end;

procedure TfrmCadClasseLocFis.btnGravarClick(Sender: TObject);
begin

  If Not fValidacoesBotaoGravarPai Then
    Exit;

  Try
    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
    inherited;
    If blnGravou And cdsClaLoc.fSalva Then
      fCommit
    Else
      fRollBack;
  Except
    On E : Exception Do
    Begin
      fRollBack;
      pMensagensErro(e.Message, 'TfrmCadClasseLocFis.btnGravarClick');
    End;
  End;

end;

procedure TfrmCadClasseLocFis.btnIncluirClick(Sender: TObject);
begin
  inherited;
  qryTabela.FieldByName('CLA_CODEMP').AsString := VS_strCodEmp;
  qryTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CLASSE', VS_strCodEmp);
  pSetFocus(dbeSigla);
  pCarregaLocalizacaoFisica;
end;

procedure TfrmCadClasseLocFis.btnInclusaoEmMasaClick(Sender: TObject);
begin
  inherited;
  Try
    blnMsgDuplicado := False;
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := InclusaoEmMasaProgress;
    frmGravando.lblGravando.Caption := 'Incluindo, Aguarde...';
    frmGravando.ShowModal;
  Finally
    blnMsgDuplicado := True;
    FreeAndNil(frmGravando);
  End;
end;

function TfrmCadClasseLocFis.InclusaoEmMasaProgress(cxProgress : TcxProgressBar):Boolean;
  Var
    arrLocFis : TArrLotSel;
    intIndex  : Integer;

begin
  inherited;
  Try
    Result := True;
    arrLocFis := TfrmCadLocFisSelecao.fSelecaoCadArrLotSel(tcCodigo);

    cdsClaLoc.DisableControls;
    Try

      cxProgress.Properties.Max := High(arrLocFis);
      For intIndex := Low(arrLocFis) To High(arrLocFis) Do
      Begin

        cdsClaLoc.Insert;
        cdsClaLoc.FieldByName('CLL_CODLOC').AsString := arrLocFis[intIndex].strCODLOC;
        cdsClaLoc.FieldByName('DESCRI').AsString     := arrLocFis[intIndex].strDESCRI;
        cdsClaLoc.FieldByName('ALTURA').AsFloat      := arrLocFis[intIndex].fltALTURA;
        cdsClaLoc.FieldByName('LARGUR').AsFloat      := arrLocFis[intIndex].fltLARGUR;
        cdsClaLoc.FieldByName('PROFUN').AsFloat      := arrLocFis[intIndex].fltPROFUN;
        cdsClaLoc.FieldByName('CAPACI').AsFloat      := arrLocFis[intIndex].fltCAPACI;
        cdsClaLoc.FieldByName('PESMAX').AsFloat      := arrLocFis[intIndex].fltPESMAX;
        cdsClaLoc.FieldByName('PICKIN').AsString     := arrLocFis[intIndex].strPICKIN;
        cdsClaLoc.Post;

        cxProgress.Position := intIndex;
        If (intIndex mod 100) = 0 then
          Application.ProcessMessages;
      End;
    Finally
      cdsClaLoc.EnableControls;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TfrmCadClasseLocFis.InclusaoEmMasaProgress');
    End;
  End;
end;

procedure TfrmCadClasseLocFis.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
begin
  inherited;
  chrKey := '/';
  If fPesqClasseLocFis(Self, nil, qryTabela, chrKey, arrSel) Then
  Begin
    pCarregaLocalizacaoFisica;
  End;
end;

procedure TfrmCadClasseLocFis.cxgClaLocTableViewKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Delete) And (Shift = []) And (qryTabela.State in dsEditModes) And (cdsClaLoc.Active) And (cdsClaLoc.RecordCount > 0) And
     (fMensagem('', 'Deseja Excluir essa Localização Física?', ['&Sim', '&Não'], 2) = 1) Then
  Begin
    Key := 0;
    cdsClaLoc.Delete;
  End;
end;

procedure TfrmCadClasseLocFis.cxgClaLocTableViewPickingGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;
  If (AText = 'S') Then
    AText := 'Sim'
  Else If (AText = 'N') Then
    AText := 'Não';
end;

procedure TfrmCadClasseLocFis.edtLocFisKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqLocFisica(Self, edtLocFis, edtDescri, Nil, Key, arrSel) Then
    fValidaCampos(edtLocFis, True);
end;

procedure TfrmCadClasseLocFis.FormCreate(Sender: TObject);
begin
  inherited;
  blnVerificaProCod := False;
  blnMsgDuplicado   := True;
  strNomeTabela     := 'CLASSE';
  strNomeCampo      := 'CLA_SIGLA_';
  qryTabela         := fCriarQuery(' SELECT * FROM CLASSE WHERE FALSE ', Self);
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeSigla;
  arrCamposChave[1] := dbeCodEmp;

  cdsClaLoc := TZClient.Create(Self, fSQLClaLoc);
  cxgClaLocTableView.DataController.DataSource := cdsClaLoc.dtsSource;
  cdsClaLoc.OnNewRecord := pCdsClaLocOnNewRecord;

end;

procedure TfrmCadClasseLocFis.pCdsClaLocOnNewRecord(DataSet : TDataSet);
Begin
  DataSet.FieldByName('CLL_CODEMP').AsString := VS_strCodEmp;
  DataSet.FieldByName('CLL_SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
  DataSet.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CLALOC', VS_strCodEmp);
End;


function TfrmCadClasseLocFis.fSQLClaLoc : String;
Begin
  Result := '';
  Result := Result + ' SELECT A.AUTOINCREM,         ';
  Result := Result + '        A.CLL_SEQGER,         ';
  Result := Result + '        A.CLL_CODLOC,         ';
  Result := Result + '        A.CLL_CODEMP,         ';
  Result := Result + '        LOC_DESCRI AS DESCRI, ';
  Result := Result + '        LOC_ALTURA AS ALTURA, ';
  Result := Result + '        LOC_LARGUR AS LARGUR, ';
  Result := Result + '        LOC_PROFUN AS PROFUN, ';
  Result := Result + '        LOC_CAPACI AS CAPACI, ';
  Result := Result + '        LOC_PESMAX AS PESMAX, ';
  Result := Result + '        LOC_PICKIN AS PICKIN  ';
  Result := Result + ' FROM CLALOC A                ';
  Result := Result + ' INNER JOIN CADLOC B ON B.LOC_CODLOC = A.CLL_CODLOC AND B.LOC_CODEMP = A.CLL_CODEMP ';
  Result := Result + ' WHERE CLL_SEQGER = :SEQGER                         ';
End;

procedure TfrmCadClasseLocFis.FormDestroy(Sender: TObject);
begin
  FreeAndNil(stlCampos);
  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);
  inherited;
end;

procedure TfrmCadClasseLocFis.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

function TfrmCadClasseLocFis.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, True);
  If Result Then
  Begin
    If (Sender = dbeSigla) Then
    Begin
      If fEmptyStr(dbeSigla.Text) Then
      Begin
        Result := fMensagem('', 'A Sigla deve ser preenchida!', ['&Ok']) = -1;
      End

      Else
      If (qryTabela.State = dsInsert) And blnBuscaPorChave Then
      Begin
        If fBuscaPorCamposChave Then
        Begin
          pCarregaLocalizacaoFisica;
        End;
      End;

    End

    Else
    If( Sender = edtLocFis ) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtLocFis.Text) Then
      Begin
        Result := fMensagem('', 'Informe a Localização Física!', ['&Ok']) = -1;
      End
      Else
      Begin
        edtDescri.Text := fRetNomLocFisica(edtLocFis.Text);
        If fEmptyStr(edtDescri.Text) Then
        Begin
          Result := fMensagem('', 'Localização Física Não Encontrada!', ['&Ok']) = -1;
        End;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadClasseLocFis.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
end;

procedure TfrmCadClasseLocFis.pOnStateChange;
begin
  inherited;
  btnAdicionar.Enabled := btnGravar.Enabled;
  btnInclusaoEmMasa.Enabled := btnGravar.Enabled;
end;

procedure TfrmCadClasseLocFis.pCarregaLocalizacaoFisica;
Begin
  With cdsClaLoc.qryQuery Do
  Begin
    ParamByName('SEQGER').AsString := qryTabela.FieldByNAme('AUTOINCREM').AsString;
  End;

  With cdsClaLoc Do
  Begin
    fAbreClient(True, 'TfrmCadClasseLocFis.pCarregaLocalizacaoFisica');
    pSetaClient(cdsClaLoc);

    TFloatField(FieldByName('ALTURA')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('LARGUR')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('PROFUN')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('CAPACI')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('PESMAX')).DisplayFormat := '#,##0.00';
  End;

End;

end.
