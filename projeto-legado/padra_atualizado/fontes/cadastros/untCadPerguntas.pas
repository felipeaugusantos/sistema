unit untCadPerguntas;

interface

uses
  Windows, Classes, Controls, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Mask, DBCtrls, DBEditFocus, UniDataSetProvider, UniClientDataSet, Uni,
  BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, Provider, frxClass, frxExportCSVTestabilidade, untTypesSistema,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient;

type
  TfrmCadPerguntas = class(TfrmPaiCad)
    pnlDados: TPanel;
    Panel1: TPanel;
    pnlRespostas: TPanel;
    cxgPerResDBTableView1: TcxGridDBTableView;
    cxgPerResLevel1: TcxGridLevel;
    cxgPerRes: TcxGrid;
    cxgPerResDBTableView1Column1: TcxGridDBColumn;
    dtsPerRes: TDataSource;
    cdsPerRes: TUniClientDataSet;
    dspPerRes: TUniDataSetProvider;
    dtsTabela: TDataSource;
    cxStyleRepository: TcxStyleRepository;
    cxsWhite: TcxStyle;
    cxsGreen: TcxStyle;
    lbl3: TLabel;
    dbeCodPer: TDBEditFocus;
    lbl2: TLabel;
    lbl1: TLabel;
    edtDesRes: TEditFocus;
    dbeDesPer: TDBEditFocus;
    Label1: TLabel;
    dbeDtaCad: TDBEditFocus;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgPerResDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    qryPerRes: TUniQuery;

    intRecNo: Integer;

    procedure pCarregaResposta;
    procedure pLimpaEdits;
    procedure pAbreRespostas(strCodigo: String);
    procedure pSalvaReferencia;
    Procedure pAdicionaResposta(strDesRes:String);
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
  SysUtils, Forms, untFuncoesSimples, untConsultas;

procedure TfrmCadPerguntas.pInicializaIndices;
Begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('PER_CODEMP');
  stlCamInd.Add('PER_CODPER');

  stlDesInd.Add('Empresa');
  stlDesInd.Add('Código');
end;

procedure TfrmCadPerguntas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pnlRespostas.Enabled := True;
  pHabilitaCodigo(dbeCodPer, TDBEdit(dbeDesPer), False);
end;

procedure TfrmCadPerguntas.pLimpaEdits;
Begin
  edtDesRes.Clear;
  intRecNo := -1;
End;

procedure TfrmCadPerguntas.pSalvaReferencia;
Begin
  With cdsPerRes Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      Edit;

      If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PERRES', VS_strCodEmp);

      If fEmptyStr(FieldByName('RES_SEQPER').AsString) Then
        FieldByName('RES_SEQPER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;

      Post;

      Next;
    End;

    EnableControls;
  End;

End;

procedure TfrmCadPerguntas.btnCancelaClick(Sender: TObject);
begin
  inherited;

  cdsPerRes.CancelUpdates;
  If Not qryTabela.IsEmpty Then
  Begin
    pLimpaEdits;
    pAbreRespostas(qryTabela.FieldByName('AUTOINCREM').AsString);
    pSetFocus(btnAlterar);
  End;
  pnlRespostas.Enabled := False;
end;

procedure TfrmCadPerguntas.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadPerguntas.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  Begin
    fCommit;
    pLimpaEdits;
    pAbreRespostas('')
  End
  Else
    fRollBack;
end;

procedure TfrmCadPerguntas.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadPerguntas.btnGravarClick]');
    End;
  End;

  If blnGravou Then
  begin
    pSalvaReferencia;
    cdsPerRes.ApplyUpdates(0);
    fCommit;
  End
  Else
    fRollBack;

  pnlRespostas.Enabled := False;
end;

procedure TfrmCadPerguntas.btnIncluirClick(Sender: TObject);
begin
  inherited;

  qryTabela.FieldByName('PER_DTACAD').AsDateTime := fRetDataServidor;

  pHabilitaCodigo(dbeCodPer, TDBEdit(dbeDesPer), False);
  pAbreRespostas('');
  pnlRespostas.Enabled := True;
end;

procedure TfrmCadPerguntas.pAbreRespostas(strCodigo: String);
Begin
  With qryPerRes, SQL Do
  Begin
    cdsPerRes.Close;
    Close;

    Clear;
    Add('SELECT * FROM PERRES');
    Add('WHERE');

    If fEmptyStr(strCodigo) Then
      Add('FALSE')
    Else
      Add('RES_SEQPER = ' + QuotedStr(strCodigo));

    dspPerRes.DataSet := qryPerRes;
    cdsPerRes.SetProvider(dspPerRes);

    Open;

    pSetaClient(qryPerRes);
    pSetaClient(cdsPerRes);

    cdsPerRes.IndexFieldNames := 'RES_DESRES';
    cdsPerRes.Open;
  End;
End;

procedure TfrmCadPerguntas.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
begin
//  inherited;

  chrKey := '?';
  If fPesqPergunta(Self, Nil, Nil, qryTabela, chrKey, arrSel) Then
  Begin
    pLimpaEdits;
    pAbreRespostas(qryTabela.FieldByName('AUTOINCREM').AsString);
    pSetFocus(btnAlterar);
  End
  Else
  Begin
    If cdsPerRes.Active Then
      cdsPerRes.Close;
  End;
end;

procedure TfrmCadPerguntas.pCarregaResposta;
Begin
  If Not pnlRespostas.Enabled Then
    Exit;

  With cdsPerRes Do
  Begin
    If IsEmpty Then
      Exit;

    edtDesRes.Text := FieldByName('RES_DESRES').AsString;
    intRecNo := RecNo;
    pSetFocus(edtDesRes);
  End;
End;

procedure TfrmCadPerguntas.cxgPerResDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: pCarregaResposta;
  End;
end;

procedure TfrmCadPerguntas.FormCreate(Sender: TObject);
begin
  inherited;

  intRecNo := -1;
  
  strNomeTabela := 'CADPER';
  strNomeCampo  := 'PER_CODPER';

  qryTabela := fCriarQuery('SELECT * FROM CADPER WHERE FALSE', Self);

  dtsTabela.DataSet   := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodPer;

  qryPerRes := fCriaQuery(Self);

end;

Procedure TfrmCadPerguntas.pAdicionaResposta(strDesRes:String);
Begin
  with cdsPerRes Do
  Begin
    If (RecNo = intRecNo) Or Locate('RES_DESRES', strDesRes, []) Then
      Edit
    Else
      Insert;

    FieldByName('RES_DESRES').AsString := strDesRes;
    Post;
    pLimpaEdits;
    pSetFocus(edtDesRes);
  End;
End;

function TfrmCadPerguntas.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*************************}
    {* PERGUNTA              *)
    {*************************}
    If (Sender = dbeDesPer) Then
    Begin
      If fEmptyStr(dbeDesPer.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Pergunta deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    {*************************}
    {* RESPOSTA              *)
    {*************************}
    Else If (Sender = edtDesRes) Then
    Begin
      If Not fEmptyStr(edtDesRes.Text) Then
      Begin
        If Result Then
        Begin
          pAdicionaResposta(edtDesRes.Text);
          blnMudarFoco := False;
        End;
      End
      Else
      begin
        If cdsPerRes.IsEmpty Then
        Begin
          pMensagemOk('Informe as opções de resposta!');
          pSetFocus(edtDesRes);
          Result := False;
        End Else
          edtDesRes.Clear;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.

