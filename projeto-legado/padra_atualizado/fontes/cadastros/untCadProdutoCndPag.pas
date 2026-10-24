unit untCadProdutoCndPag;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Mask, DBCtrls, DBEditFocus, Provider, UniClientDataSet, Uni,
  Math, untFuncoesSimples, MaskEditFocus, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, UniDataSetProvider, untTypesSistema,
  frxClass, frxExportCSVTestabilidade, Datasnap.DBClient,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadProdutosCndPag = class(TfrmPaiCad)
    pnlDados: TPanel;
    pnlDescri: TPanel;
    pnlLinGru: TPanel;
    cxgCruGruDBTableView1: TcxGridDBTableView;
    cxgCruGruLevel1: TcxGridLevel;
    cxgCruGru: TcxGrid;
    dtsCruCnd: TDataSource;
    cdsCruCnd: TUniClientDataSet;
    dtsTabela: TDataSource;
    cxStyleRepository: TcxStyleRepository;
    cxsWhite: TcxStyle;
    cxsGreen: TcxStyle;
    pnlCndPag: TPanel;
    cxgCruCnd: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cdsCruGru: TUniClientDataSet;
    dtsCruGru: TDataSource;
    Label4: TLabel;
    edtDesCnd: TEditFocus;
    Label1: TLabel;
    edtLinDes: TEditFocus;
    btnAddCnd: TBitBtnLocked;
    btnAddLin: TBitBtnLocked;
    cxGridDBTableView1Column1: TcxGridDBColumn;
    cxGridDBTableView1Column2: TcxGridDBColumn;
    cxGridDBTableView1Column3: TcxGridDBColumn;
    Label2: TLabel;
    dbeCodigo: TDBEditFocus;
    Label3: TLabel;
    dbeDescri: TDBEditFocus;
    mskLinGru: TMaskEditFocus;
    cxgCruGruDBTableView1Column1: TcxGridDBColumn;
    cxgCruGruDBTableView1Column2: TcxGridDBColumn;
    edtCodCnd: TEditFocus;
    dspCruGru: TUniDataSetProvider;
    dspCruCnd: TUniDataSetProvider;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgCruGruDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure cxGridDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddLinClick(Sender: TObject);
    procedure btnAddCndClick(Sender: TObject);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryCruGru,
    qryCruCnd: TUniQuery;

    intRecNo: Integer;

    arrCnd: TConsultasArray;

    strCndPag: String;

    procedure pCarregaLinGru;
    procedure pCarregaCndPag;
    procedure pLimpaEdits;
    procedure pAbreGrids(strCodigo: String);
    procedure pSalvaReferencia;
    procedure pCarregaCadCnd;
    procedure pCarregaCadGru;
    procedure pHabilitaPanels(blnHabilita:Boolean);
    Procedure pAddCruCnd(strCodCnd, strDesCnd, strCondPa:String);
    procedure pAddCruGru(strCodGru, strDesGru:String);

    Function fRetCodigo: String;

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
  untConsultas;

procedure TfrmCadProdutosCndPag.pInicializaIndices;
Begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('CRU_CODIGO');
  stlCamInd.Add('CRU_DESCRI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadProdutosCndPag.btnAddCndClick(Sender: TObject);
begin
  inherited;
  If fValidaCampos(edtCodCnd) Then
  begin
    If Not fEmptyStr(edtCodCnd.Text) Then
      pAddCruCnd(edtCodCnd.Text, edtDesCnd.Text, strCndPag)
    Else
      pSetFocus(btnGravar);
  End;
end;

procedure TfrmCadProdutosCndPag.btnAddLinClick(Sender: TObject);
begin
  inherited;
  If fValidaCampos(mskLinGru) Then
  begin
    If Not fEmptyStr(fTiraCaracEspeciais(mskLinGru.Text)) Then
      pAddCruGru(fTiraCaracEspeciais(mskLinGru.Text), edtLinDes.Text)
    Else
      pSetFocus(edtCodCnd);
  End;
end;

procedure TfrmCadProdutosCndPag.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pHabilitaPanels(True);  
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

procedure TfrmCadProdutosCndPag.pLimpaEdits;
Begin
  {If fEmptyStr(fTiraCaracEspeciais(mskLinGru.Text)) Then
    edtLinDes.Clear
  Else
    pCarregaLinGru;

  If fEmptyStr(edtCodCnd.Text) Then
    edtDesCnd.Clear
  Else
    pCarregaCadCnd;}

  mskLinGru.Clear;
  edtLinDes.Clear;
  edtCodCnd.Clear;
  edtDesCnd.Clear;
  dbeCodigo.Clear;
  dbeDescri.Clear;

  strCndPag := EmptyStr;  

  intRecNo := -1;
End;

procedure TfrmCadProdutosCndPag.pSalvaReferencia;
Begin
  With cdsCruGru Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      Edit;
      If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CRUGRU', VS_strCodEmp);
      If fEmptyStr(FieldByName('GRU_SEQCRU').AsString) Then
        FieldByName('GRU_SEQCRU').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      Post;
      Next;
    End;
    EnableControls;
  End;

  With cdsCruCnd Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      Edit;
      If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CRUCND', VS_strCodEmp);
      If fEmptyStr(FieldByName('CND_SEQCRU').AsString) Then
        FieldByName('CND_SEQCRU').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      Post;
      Next;
    End;
    EnableControls;
  End;
End;

procedure TfrmCadProdutosCndPag.btnCancelaClick(Sender: TObject);
begin
  inherited;

  cdsCruGru.CancelUpdates;
  cdsCruCnd.CancelUpdates;  

  pLimpaEdits;
  pAbreGrids(dbeCodigo.Text);
  pHabilitaPanels(False);
end;

procedure TfrmCadProdutosCndPag.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadProdutosCndPag.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pLimpaEdits;
  pAbreGrids('');
end;

procedure TfrmCadProdutosCndPag.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  If cdsCruGru.IsEmpty Then
  Begin
    pMensagemOk('Informa pelo menos uma Linha/Grupo!');
    pSetFocus(mskLinGru);
  End

  Else If cdsCruCnd.IsEmpty Then
  Begin
    pMensagemOk('Informa pelo menos uma Condição de Pagamento!');
    pSetFocus(edtCodCnd);
  End

  Else
  Begin
    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

    Try
      inherited;
      pSalvaReferencia;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[untCadProdutosCndPag.btnGravarClick]');
      End;
    End;

    If blnGravou Then
    Begin
      cdsCruGru.ApplyUpdates(0);
      cdsCruCnd.ApplyUpdates(0);
      fCommit
    End
    Else
      fRollBack;

    pHabilitaPanels(False);
  End;
end;

procedure TfrmCadProdutosCndPag.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pLimpaEdits;

  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
  dbeCodigo.Text := fRetCodigo;

  pAbreGrids('');
  pHabilitaPanels(True);
end;

procedure TfrmCadProdutosCndPag.pAbreGrids(strCodigo: String);
Begin
  With qryCruGru, SQL Do
  Begin
    cdsCruGru.Close;
    Close;

    Clear;
    Add('SELECT ');
    Add('  CRUGRU.*, ');
    Add(' (SELECT GRU_DESGRU FROM CADGRU WHERE CADGRU.GRU_CODGRU = CRUGRU.GRU_CODGRU) AS GRU_DESGRU ');    
    Add('FROM ');
    Add('  CRUGRU ');
    Add('WHERE ');

    If fEmptyStr(strCodigo) Then
      Add('FALSE ')
    Else
      Add('GRU_SEQCRU = ' + QuotedStr(strCodigo));

    dspCruGru.DataSet := qryCruGru;
    cdsCruGru.SetProvider(dspCruGru);

    Open;

    pSetaClient(qryCruGru);
    pSetaClient(cdsCruGru);

    cdsCruGru.IndexFieldNames := 'GRU_DESGRU';
    cdsCruGru.Open;
  End;

  With qryCruCnd, SQL Do
  Begin
    cdsCruCnd.Close;
    Close;

    Clear;
    Add('SELECT ');
    Add('  CRUCND.*, ');
    Add(' (SELECT CND_DESCRI FROM CADCND WHERE CADCND.CND_CODIGO = CRUCND.CND_CODCND) AS CND_DESCRI, ');
    Add(' (SELECT CND_CNDPAG FROM CADCND WHERE CADCND.CND_CODIGO = CRUCND.CND_CODCND) AS CND_CNDPAG  ');    
    Add('FROM ');
    Add('  CRUCND ');
    Add('WHERE ');

    If fEmptyStr(strCodigo) Then
      Add('FALSE')
    Else
      Add('CND_SEQCRU = ' + QuotedStr(strCodigo));

    dspCruCnd.DataSet := qryCruCnd;
    cdsCruCnd.SetProvider(dspCruCnd);

    Open;

    pSetaClient(qryCruCnd);
    pSetaClient(cdsCruCnd);

    cdsCruCnd.IndexFieldNames := 'CND_DESCRI';
    cdsCruCnd.Open;
  End;    
End;

procedure TfrmCadProdutosCndPag.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
begin
  chrKey := '/';
  If fPesqLinGruXCndPag(Self, Nil, Nil, qryTabela, chrKey) Then
  Begin
    If Not qryTabela.IsEmpty Then
    Begin
      pAbreGrids(qryTabela.FieldByName('AUTOINCREM').AsString);
      pSetFocus(btnAlterar);
    End;
  End;
end;

procedure TfrmCadProdutosCndPag.pCarregaCadCnd;
  Var
    qryConCnd: TUniQuery;
begin
  qryConCnd := fCriaQuery(Nil);
  
  With qryConCnd Do
  Begin
    SQL.Clear;
    SQL.Add('SELECT * FROM CADCND ');
    SQL.Add('WHERE CND_CODIGO = :CODCND');
    ParamByName('CODCND').AsString := edtCodCnd.Text;
    Open;
    edtDesCnd.Text := FieldByName('CND_DESCRI').AsString;
    strCndPag      := fFormataCondPag(FieldByName('CND_CNDPAG').AsString);
  End;

  FreeAndNil(qryConCnd);
end;

procedure TfrmCadProdutosCndPag.pCarregaCndPag;
begin
  If Not pnlCndPag.Enabled Then
    Exit;

  With cdsCruCnd Do
  Begin
    If IsEmpty Then
      Exit;

    edtCodCnd.Text := FieldByName('CND_CODCND').AsString;
    intRecNo := RecNo;
    pSetFocus(edtCodCnd);
  End;
end;

procedure TfrmCadProdutosCndPag.pCarregaLinGru;
begin
  If Not pnlLinGru.Enabled Then
    Exit;

  With cdsCruGru Do
  Begin
    If IsEmpty Then
      Exit;

    mskLinGru.Text := FieldByName('GRU_CODGRU').AsString;
    intRecNo := RecNo;
    pSetFocus(mskLinGru);
  End;
end;

procedure TfrmCadProdutosCndPag.pCarregaCadGru;
begin

  edtLinDes.Text := '';

  If fEmptyStr(fTiraCaracEspeciais(mskLinGru.Text)) Then
    Exit;

  edtLinDes.Text := fCampoTabela('GRU_DESGRU', 'CADGRU', ['GRU_CODGRU'], [fTiraCaracEspeciais(mskLinGru.Text)], False);

end;

procedure TfrmCadProdutosCndPag.pHabilitaPanels(blnHabilita: Boolean);
begin
  pnlLinGru.Enabled := blnHabilita;
  pnlCndPag.Enabled := blnHabilita;
end;

procedure TfrmCadProdutosCndPag.cxgCruGruDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: pCarregaLinGru;
  End;
end;

procedure TfrmCadProdutosCndPag.cxGridDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: pCarregaCndPag;
  End;
end;

procedure TfrmCadProdutosCndPag.edtCodCndKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqCondicoesPgto(Self, edtCodCnd, Nil, Nil, Key, arrCnd, True, False, IIF(fCfgSis('PFLCLI', varBoolean), conCndPerfil, conSimples)) Then
    Begin
      If fValidaCampos(edtCodCnd, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadProdutosCndPag.FormCreate(Sender: TObject);
begin
  inherited;

  intRecNo := -1;

  strNomeTabela := 'CRUITC';
  strNomeCampo  := 'AUTOINCREM';

  qryTabela := fCriarQuery('SELECT * FROM CRUITC WHERE FALSE', Self);

  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  qryCruGru := fCriaQuery(Self);
  qryCruCnd := fCriaQuery(Self);  
end;

procedure TfrmCadProdutosCndPag.pAddCruCnd(strCodCnd, strDesCnd, strCondPa: String);
begin
  with cdsCruCnd Do
  Begin
    If (RecNo = intRecNo) Or Locate('CND_CODCND', strCodCnd, []) Then
      Edit
    Else
      Insert;

    FieldByName('CND_CODCND').AsString := strCodCnd;
    FieldByName('CND_DESCRI').AsString := strDesCnd;
    FieldByName('CND_CNDPAG').AsString := strCondPa;
    Post;

    edtCodCnd.Text := EmptyStr;
    edtDesCnd.Text := EmptyStr;
    strCndPag      := EmptyStr;

    pSetFocus(edtCodCnd);
  End;
end;

procedure TfrmCadProdutosCndPag.pAddCruGru(strCodGru, strDesGru: String);
begin
  with cdsCruGru Do
  Begin
    If (RecNo = intRecNo) Or Locate('GRU_CODGRU', strCodGru, []) Then
      Edit
    Else
      Insert;

    FieldByName('GRU_CODGRU').AsString := strCodGru;
    FieldByName('GRU_DESGRU').AsString := strDesGru;
    Post;

    mskLinGru.Text := EmptyStr;
    edtLinDes.Text := EmptyStr;    

    pSetFocus(mskLinGru);
  End;
end;

function TfrmCadProdutosCndPag.fRetCodigo: String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);

  With qryAux Do
  Begin
    SQL.Clear;
    SQL.Add('SELECT (IFNULL(MAX(CRU_CODIGO),0) + 1) AS CODCRU FROM CRUITC');
    Open;
    Result := FormatFloat('000000',FieldByName('CODCRU').AsInteger);
  End;

  FreeAndNil(qryAux);
end;

function TfrmCadProdutosCndPag.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    {********************************}
    {* VALIDA LINHA/GRUPO           *}
    {*****************************MM*}
    If (Sender = mskLinGru) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskLinGru.Text)) Then
      Begin
        pCarregaCadGru;

        If fEmptyStr(edtLinDes.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Linha / Grupo não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End;
    End

    {********************************}
    {* VALIDA DESCRIÇÃO             *}
    {*****************************MM*}
    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informa a descrição!', ['&O k']);
        Result := False;
      End;
    End

    {********************************}
    {* VALIDA CONDIÇÃO DE PAGAMENTO *}
    {*****************************MM*}
    Else If (Sender = edtCodCnd) Then
    Begin
      If Not fEmptyStr(edtCodCnd.Text) Then
      Begin
        pCarregaCadCnd;
        If fEmptyStr(edtDesCnd.Text) Then
        Begin
          fMensagem('', 'Condição de pagamento não encontrada!', ['&O k']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadProdutosCndPag.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrGrupos: TConsultasArray;
begin
  inherited;
  {********************************}
  {* NOVA CONSULTA DE LINHA/GRUPO *}
  {*****************************RV*}
  If fPesqGrupo(Self, mskLinGru, edtLinDes, Nil, Key, arrGrupos) Then
  Begin
    If fValidaCampos(mskLinGru) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.

