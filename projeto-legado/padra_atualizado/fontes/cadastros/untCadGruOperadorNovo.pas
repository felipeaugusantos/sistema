unit untCadGruOperadorNovo;

interface

uses
  Windows, Classes, Controls, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, EditFocus, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Mask, DBCtrls, DBEditFocus, UniDataSetProvider, UniClientDataSet, Uni,
  untFuncoesSimples, BitBtnLockedIncrem, cxLookAndFeels, untTypesSistema,
  cxLookAndFeelPainters, cxNavigator, Provider, frxClass, frxExportCSVTestabilidade, Datasnap.DBClient,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadGruOperadorNovo = class(TfrmPaiCad)
    pnlDados: TPanel;
    Panel1: TPanel;
    pnlOperadores: TPanel;
    cxgOpeGpoDBTableView1: TcxGridDBTableView;
    cxgOpeGpoLevel1: TcxGridLevel;
    cxgOpeGpo: TcxGrid;
    cxgOpeGpoDBTableView1Column1: TcxGridDBColumn;
    cxgOpeGpoDBTableView1Column2: TcxGridDBColumn;
    dtsOpeGpo: TDataSource;
    cdsOpeGpo: TUniClientDataSet;
    dspOpeGpo: TUniDataSetProvider;
    dtsTabela: TDataSource;
    cxStyleRepository: TcxStyleRepository;
    cxsWhite: TcxStyle;
    cxsGreen: TcxStyle;
    Label3: TLabel;
    lblDescricao: TLabel;
    dbeCodGpo: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    Label1: TLabel;
    edtDesVendedor: TEditFocus;
    edtCodVendedor: TEditFocus;
    btnExcluirOperador: TBitBtnLocked;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgOpeGpoDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirOperadorClick(Sender: TObject);
  private
    { Private declarations }
    qryOpeGpo: TUniQuery;

    intRecNo: Integer;

    arrVen : TConsultasArray;

    blnVeioGravar: Boolean;
    
    procedure pCarregaOperador;
    procedure pLimpaEdits;
    procedure pAbreOperadores(strCodigo: String);
    procedure pSalvaReferencia;
    Procedure pAdicionaOperador(strCodVen : String);
    Function fProximoCodigo: String; reintroduce;
    function fExisteDireitoAcesso: Boolean;
  public
    { Public declarations }
  protected
    { Protected declarations }
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

implementation

{$R *.dfm}

Uses SysUtils, Forms, untConsultas;

procedure TfrmCadGruOperadorNovo.pInicializaIndices;
Begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('GPO_CODGPO');
  stlCamInd.Add('GPO_DESCRI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadGruOperadorNovo.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pnlOperadores.Enabled := True;
  cxgOpeGpo.Enabled := True;
  pHabilitaCodigo(dbeCodGpo, dbeDescri, False);
end;

procedure TfrmCadGruOperadorNovo.pLimpaEdits;
Begin
  edtCodVendedor.Clear;
  edtDesVendedor.Clear;

  intRecNo := -1;
End;

procedure TfrmCadGruOperadorNovo.pSalvaReferencia;
Begin
  With cdsOpeGpo Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      Edit;

      If fEmptyStr(FieldByName('GPO_CODGPO').AsString) Then
        FieldByName('GPO_CODGPO').AsString := qryTabela.FieldByName('GPO_CODGPO').AsString;

      Post;

      Next;
    End;

    EnableControls;
  End;

End;

procedure TfrmCadGruOperadorNovo.btnCancelaClick(Sender: TObject);
begin
  inherited;

  cdsOpeGpo.CancelUpdates;

  pLimpaEdits;
  pAbreOperadores(dbeCodGpo.Text);

  pnlOperadores.Enabled := False;
  cxgOpeGpo.Enabled     := False;
end;

procedure TfrmCadGruOperadorNovo.btnExcluirClick(Sender: TObject);
begin
  If cdsOpeGpo.Active Then
  Begin
    If fExisteDireitoAcesso Then
    Begin
      fMensagem('ATENÇÃO', 'Este grupo possui direitos de acesso vinculados a ele, remova todos ' +
                           'os direitos de acesso antes de realizar a exclusão.', ['&O K']);
      Exit;
    End;

    If cdsOpeGpo.RecordCount > 0 Then
    Begin
      fMensagem('ATENÇÃO', 'Este grupo possui operadores vinculados a ele, remova todos os operadores antes de realizar a exclusão.', ['&O K']);
      Exit;
    End;
  End;

  If (qryTabela.State <> dsBrowse) And (qryTabela.State <> dsInactive) Then
    qryTabela.Cancel;
    
  If blnVeioGravar Then
    blnPerguntarParaExcluir := False
  Else
    blnPerguntarParaExcluir := True;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadGruOperadorNovo.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pLimpaEdits;
  pAbreOperadores('');

  If (qryTabela.State <> dsInactive) Then
    pSetButton(qryTabela, btnIncluir, btnGravar, btnExcluir, btnCancela, btnAlterar, btnPesquisa, btnSair);
end;

procedure TfrmCadGruOperadorNovo.btnExcluirOperadorClick(Sender: TObject);
begin
  inherited;

  If (edtCodVendedor.Enabled) And (cdsOpeGpo.Active) And (Not cdsOpeGpo.IsEmpty) Then
    cdsOpeGpo.Delete;
end;

procedure TfrmCadGruOperadorNovo.btnGravarClick(Sender: TObject);
begin
  If Not fValidacoesBotaoGravarPai Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  If cdsOpeGpo.IsEmpty Then
  Begin
    If fEmptyStr(qryTabela.FieldByName('GPO_CODGPO').AsString) Then
    Begin
      pMensagemOk('Nenhum operador vinculado a este grupo!');
      pSetFocus(edtCodVendedor);
    End
    Else
    If fMensagem('', 'Nenhum operador vinculado a este grupo. Deseja excluir o grupo?', ['&Sim', '&Não']) = 2 Then
    Begin
      pMensagemOk('Informe os Operadores!');
      pSetFocus(edtCodVendedor);
    End
    Else
    Begin
      blnVeioGravar := True;
      btnExcluir.Click;
      blnVeioGravar := False;
    End;
  End
  Else
  Begin
    qryTabela.FieldByName('GPO_DTACAD').AsDateTime := VS_Date;

    Try
      inherited;

      pSalvaReferencia;

      If blnGravou Then
      Begin
        cdsOpeGpo.ApplyUpdates(0);
        fCommit;
      End
      Else
        fRollBack;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[btnGravarClick]');
      End;
    End;

    pnlOperadores.Enabled := False;
    cxgOpeGpo.Enabled     := False;
  End;

end;

procedure TfrmCadGruOperadorNovo.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodGpo, dbeDescri, False);

  dbeCodGpo.Text := fProximoCodigo;

  pAbreOperadores('');

  pnlOperadores.Enabled := True;
  cxgOpeGpo.Enabled     := True;
end;

procedure TfrmCadGruOperadorNovo.pAbreOperadores(strCodigo: String);
Begin
  With qryOpeGpo, SQL Do
  Begin
    cdsOpeGpo.Close;
    Close;

    Clear;
    Add('SELECT ');
    Add('  OPEGPO.*, ');
    Add(' (SELECT OPE_NOMOPE FROM CADOPE WHERE CADOPE.OPE_CODOPE = OPEGPO.OPE_CODOPE) AS OPE_NOMOPE ');
    Add('FROM ');
    Add('  OPEGPO ');
    Add('WHERE ');

    If fEmptyStr(strCodigo) Then
      Add('FALSE')
    Else
      Add('GPO_CODGPO = ' + QuotedStr(strCodigo));

    dspOpeGpo.DataSet := qryOpeGpo;
    cdsOpeGpo.SetProvider(dspOpeGpo);

    Open;

    pSetaClient(qryOpeGpo);
    pSetaClient(cdsOpeGpo);

    cdsOpeGpo.IndexFieldNames := 'OPE_CODOPE';
    cdsOpeGpo.Open;
  End;
End;

procedure TfrmCadGruOperadorNovo.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
begin
//  inherited;

  chrKey := '?';
  If fPesqGrupoOperador(Self, Nil, Nil, qryTabela, chrKey, arrSel) Then
  Begin
    pLimpaEdits;
    pAbreOperadores(qryTabela.FieldByName('GPO_CODGPO').AsString);

    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadGruOperadorNovo.pCarregaOperador;
Begin
  If Not pnlOperadores.Enabled Then
    Exit;

  With cdsOpeGpo Do
  Begin
    If IsEmpty Then
      Exit;

    edtCodVendedor.Text := FieldByName('OPE_CODOPE').AsString;
    edtDesVendedor.Text := fRetNomVendRep(FieldByName('OPE_CODOPE').AsString);

    intRecNo := RecNo;

    pSetFocus(edtCodVendedor);
  End;
End;

procedure TfrmCadGruOperadorNovo.cxgOpeGpoDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: pCarregaOperador;
  End;
end;

procedure TfrmCadGruOperadorNovo.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodVendedor, edtDesVendedor, Nil, Key, arrVen, False) Then
  Begin
    If fValidaCampos(edtCodVendedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadGruOperadorNovo.FormCreate(Sender: TObject);
begin
  inherited;

  intRecNo := -1;
  
  strNomeTabela := 'CADGPO';
  strNomeCampo  := 'AUTOINCREM';

  qryTabela := fCriarQuery('SELECT * FROM CADGPO WHERE FALSE', Self);

  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodGpo;

  qryOpeGpo := fCriaQuery(Self);

  blnVeioGravar := False;
end;

Procedure TfrmCadGruOperadorNovo.pAdicionaOperador(strCodVen : String);
Begin
  with cdsOpeGpo Do
  Begin
    If (RecNo = intRecNo) Or Locate('OPE_CODOPE', strCodVen, []) Then
      Edit
    Else
      Insert;

    FieldByName('OPE_CODOPE').AsString := strCodVen;
    FieldByName('OPE_NOMOPE').AsString := edtDesVendedor.Text;

    Post;

    pLimpaEdits;

    pSetFocus(edtCodVendedor);
  End;
End;

function TfrmCadGruOperadorNovo.fProximoCodigo: String;
  Var
    qryAux : TUniQuery;    
begin
  qryAux := fCriaQuery(Nil);

  With qryAux Do
  Begin
    SQL.Clear;
    SQL.Add('SELECT (MAX(GPO_CODGPO)+1) AS CODIGO ');
    SQL.Add('FROM   CADGPO ');
    Open;
    
    Result := FieldByName('CODIGO').AsString;
  End;

  FreeAndNil(qryAux);
end;

function TfrmCadGruOperadorNovo.fExisteDireitoAcesso: Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  Result := False;

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  DIRGPO ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GPO_CODGPO = :CODGPO ';

  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODGPO').AsString := dbeCodGpo.Text;
      Open;
      
      If Not IsEmpty Then
        Result := FieldByName('QTD').AsInteger > 0;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[fExisteDireitoAcesso]');
  End;

  FreeAndNil(qryGen);
End;

function TfrmCadGruOperadorNovo.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    intContador: Integer;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*************}
    {* DESCRIÇÃO *)
    {*************}
    If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('','Informe a Descrição do Grupo.', ['&OK']);
        Result := False;
      End;
    End

    {************}
    {* VENDEDOR *)
    {************}
    Else If (Sender = edtCodVendedor) Then
    Begin
      If Not fEmptyStr(edtCodVendedor.Text) Or (Length(arrVen) > 0) Then
      Begin
        If (Length(arrVen) = 0) Then
        Begin
          edtDesVendedor.Text := fRetNomVendRep(edtCodVendedor.Text);

          If fEmptyStr(edtDesVendedor.Text) Then
          Begin
            Result := False;
            fMensagem('','Vendedor não encontrado.', ['&OK']);
          End
          Else
          Begin
            pAdicionaOperador(edtCodVendedor.Text);
          End;
        End
        Else
        Begin
          For intContador := Low(arrVen) To High(arrVen) Do
          Begin
            edtDesVendedor.Text := fRetNomVendRep(arrVen[intContador].strCodigo);
            pAdicionaOperador(arrVen[intContador].strCodigo);
          End;
        End;

        SetLength(arrVen, 0);
        blnMudarFoco := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.

