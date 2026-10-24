unit untCadCupomDesconto;

interface

uses
  Windows, Controls, Forms, untPaiCad, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  DBEditFocus, AppEvnts, DB, BitBtnLockedIncrem, Mask, DBCtrls, Menus, Classes,
  SysUtils, QColorLabel, frxClass, frxExportCSVTestabilidade, MaskEditFocus,
  EditFocus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  Datasnap.DBClient, UniClientDataSet, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  untConsultas, untTypesSistema,
  MemDS, DBAccess, Uni;

type
  TfrmCadCupomDesconto = class(TfrmPaiCad)
    pnlCentral: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodCup: TDBEditFocus;
    dtsCadCup: TDataSource;
    lbl1: TLabel;
    lbl2: TColorLabel;
    dbeTipPes: TDBEditFocus;
    Label3: TLabel;
    dbeIniVig: TDBEditFocus;
    Label4: TLabel;
    dbeFinVig: TDBEditFocus;
    gpbTipoCupom: TGroupBox;
    rdbValFix: TRadioButton;
    rdbPerDes: TRadioButton;
    rdbValCom: TRadioButton;
    dbeValFix: TDBEditFocus;
    dbePerDes: TDBEditFocus;
    dbeValCom: TDBEditFocus;
    dbeValAcu: TDBEditFocus;
    gpbUtilizacaoCupom: TGroupBox;
    rdbDiaExp: TRadioButton;
    Label5: TLabel;
    dbeMinVen: TDBEditFocus;
    dbeDiaExp: TDBEditFocus;
    Label7: TLabel;
    rdbDtaVal: TRadioButton;
    dbeIniVal: TDBEditFocus;
    Label8: TLabel;
    dbeFinVal: TDBEditFocus;
    rdbVlItFi: TRadioButton;
    rdbVlItPe: TRadioButton;
    dbeVlItPe: TDBEditFocus;
    tbsItensCupom: TTabSheet;
    dbeVlItFi: TDBEditFocus;
    pnlFiltro: TPanel;
    lblItem: TLabel;
    lblGrupoLinha: TLabel;
    lblMarca: TLabel;
    lblFornecedor: TLabel;
    lblDepartamento: TLabel;
    lblDescriIni: TLabel;
    lblDescriFin: TLabel;
    lblRefere: TLabel;
    lblImpLis: TLabel;
    cllImpLis: TColorLabel;
    lblUnidade: TLabel;
    cllProAti: TColorLabel;
    lblProAti: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    edtDepartamento: TEditFocus;
    edtDesDepartamento: TEditFocus;
    edtDescriIni: TEditFocus;
    edtDescriFin: TEditFocus;
    edtRefere: TEditFocus;
    edtImpLis: TEditFocus;
    edtUnidade: TEditFocus;
    edtProAti: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    edtDesUnidade: TEditFocus;
    grdItens: TcxGrid;
    grdItensDBTableView1: TcxGridDBTableView;
    cxGrid1DBTableViewCODITE: TcxGridDBColumn;
    cxGrid1DBTableViewDESITE: TcxGridDBColumn;
    cxGrid1DBTableViewUNIDAD: TcxGridDBColumn;
    cxGrid1DBTableViewMARCA_: TcxGridDBColumn;
    cxGrid1DBTableViewREFERE: TcxGridDBColumn;
    cxGrid1DBTableViewNOMFOR: TcxGridDBColumn;
    cxGrid1DBTableViewCODFOR: TcxGridDBColumn;
    cxGrid1DBTableViewCODMAR: TcxGridDBColumn;
    grdItensLevel1: TcxGridLevel;
    dtsItens: TDataSource;
    cdsItens: TUniClientDataSet;
    cdsItensCODITE: TStringField;
    cdsItensDESITE: TStringField;
    cdsItensUNIDAD: TStringField;
    cdsItensCODMAR: TStringField;
    cdsItensMARCA_: TStringField;
    cdsItensREFERE: TStringField;
    cdsItensCODFOR: TStringField;
    cdsItensNOMFOR: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure rdbValFixClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure rdbDiaExpClick(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtDepartamentoKeyPress(Sender: TObject; var Key: Char);
    procedure edtUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtDepartamentoExit(Sender: TObject);
    procedure edtImpLisExit(Sender: TObject);
    procedure edtProAtiExit(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtUnidadeExit(Sender: TObject);
    procedure grdItensDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    arrItens: TConsultasArray;
    arrGrupos: TConsultasArray;
    arrMarca: TConsultasArray;
    arrFornec: TConsultasArray;
    arrDep: TConsultasArray;
    arrUnidades: TConsultasArray;

    procedure pCarregarTipoCupom;
    procedure pDefinirTipoCupom;
    procedure pHabilitarTipoCupom;
    procedure pCarregarUtilizacaoCupom;
    procedure pHabilitarUtilizacaoCupom;
    procedure pAfterOpen(DataSet: TDataSet);

    procedure pVerificaRadioGroupHabilitado;
    procedure pRetornaItens;
    procedure pWhereItensPrincipal(var qryItens: TUniQuery);
    procedure pWhereItens1(var qryItens: TUniQuery);
    procedure pWhereItens2(var qryItens: TUniQuery);
    procedure pWhereItensDescricao(var qryItens: TUniQuery);
    function fGravaItensCupom(strAutInc: string): Boolean;
    function fInformouItens: Boolean;
    procedure pLimpaFiltro;
    procedure pCarregaItensCupom(strSeqCup: string);
    function fExcluiItensCupom(strAutInc: string): Boolean;
    procedure pExcluiRegistroItens;
    function fGravouItensCupom: Boolean;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadCupomDesconto: TfrmCadCupomDesconto;

implementation

uses untPai, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadCupomDesconto.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'CADCUP';
  strNomeCampo := 'CUP_CODCUP';
  qryTabela := fCriarQuery('SELECT * FROM CADCUP', Self);
  dtsCadCup.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodCup;

  qryTabela.AfterOpen := pAfterOpen;

  pHabilitarTipoCupom();
  pHabilitarUtilizacaoCupom();

  pLimpaFiltro;

  pgcDados.ActivePageIndex := 0;
  tbsItensCupom.TabVisible := False;
  cdsItens.CreateDataSet;
end;

procedure TfrmCadCupomDesconto.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pHabilitarTipoCupom();
  pHabilitarUtilizacaoCupom();
  pLimpaFiltro;
end;

procedure TfrmCadCupomDesconto.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  pRetornaItens;
end;

procedure TfrmCadCupomDesconto.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadCupomDesconto.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pHabilitarTipoCupom();
  pHabilitarUtilizacaoCupom();
  pLimpaFiltro;
  cdsItens.EmptyDataSet;
end;

procedure TfrmCadCupomDesconto.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  if tbsItensCupom.TabVisible then
  begin
    if not fInformouItens then
    begin
      fMensagem('ATENÇÃO!', 'Para utilizar o tipo de cupom '+dbeDescri.Text+','+sLineBreak+
                            ' os itens devem ser informados na aba "Itens do Cupom".', ['&Ok']);
      pgcDados.ActivePageIndex := 1;
      pSetFocus(edtCodIte);
      Exit;
    end;
  end;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  pDefinirTipoCupom;

  Try
    inherited;

    if not fGravouItensCupom then
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadCupomDesconto.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  pHabilitarTipoCupom();
  pHabilitarUtilizacaoCupom();
  pLimpaFiltro;
end;

procedure TfrmCadCupomDesconto.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dbeIniVig.Field.Clear;
  dbeFinVig.Field.Clear;

  dbeIniVal.Field.Clear;
  dbeFinVal.Field.Clear;

  dbeValFix.Field.AsFloat := 0;
  dbePerDes.Field.AsFloat := 0;
  dbeValCom.Field.AsFloat := 0;
  dbeValAcu.Field.AsFloat := 0;
  dbeMinVen.Field.AsFloat := 0;
  dbeVlItPe.Field.AsFloat := 0;
  dbeVlItFi.Field.AsFloat := 0;

  dbeDiaExp.Field.AsInteger := 0;

  dbeTipPes.Field.AsString := 'A';

  rdbValFix.Checked := True;
  rdbDiaExp.Checked := True;

  qryTabela.FieldByName('CUP_TIPCUP').AsString := 'VF';

  pHabilitarTipoCupom();
  pHabilitarUtilizacaoCupom();
  pLimpaFiltro;

  pCarregarTipoCupom();
  pCarregarUtilizacaoCupom();
  cdsItens.EmptyDataSet;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodCup, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodCup, dbeCodCup, True);
end;

procedure TfrmCadCupomDesconto.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrCup: TConsultasArray;
begin
  chrKey := '/';
  If fPesqTipoCupomDesconto(Self, Nil, Nil, qryTabela, chrKey, arrCup) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadCupomDesconto.edtCodIteExit(Sender: TObject);
begin
  inherited;
  If (edtCodIte.Text = '00000')Then
  Begin
    If (edtDesIte.Text = '+1') Then
      Exit;
  End;

  If fEmptyStr(edtCodIte.Text) Then
    edtDesIte.Text := 'TODOS'
  Else
  Begin
    edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
    SetLength(arrItens, 1);
    arrItens[0].strCodigo := edtCodIte.Text;
  End;


  If fEmptyStr(edtDesIte.Text) Then
  Begin
    If (Not fEmptyStr(edtCodIte.Text))  Then
    Begin
      fMensagem('AVISO', 'Código do Produto não encontrado.', ['&O K']);
      edtCodIte.Clear;
      pSetFocus(edtCodIte);
    End;
  End;
end;

procedure TfrmCadCupomDesconto.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, Nil, Key, arrItens, False, nil, 'Consulta de Itens', '1') then
    Begin
      If fValidaCampos(edtCodIte, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCupomDesconto.edtDepartamentoExit(Sender: TObject);
begin
  inherited;
  If (edtDepartamento.Text = '000') Then
  Begin
    If(edtDesDepartamento.Text = '+1') Then
      Exit;
  End;

  If fEmptyStr(edtDepartamento.Text) Then
    edtDesDepartamento.Text := 'TODOS'
  Else
  Begin
    edtDesDepartamento.Text := fRetDescDepartamento(edtDepartamento.Text);
    SetLength(arrDep, 1);
    arrDep[0].strCodigo := edtDepartamento.Text;
  End;


  If fEmptyStr(edtDesDepartamento.Text) Then
  Begin
    If(Not fEmptyStr(edtDepartamento.Text))  Then
    Begin
      fMensagem('AVISO', 'Departamento não encontrado.', ['&O K']);
      edtDepartamento.Clear;
      pSetFocus(edtDepartamento);
    End;
  End;
end;

procedure TfrmCadCupomDesconto.edtDepartamentoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtDepartamento, edtDesDepartamento, Nil, Key, arrDep, False) Then
  Begin
    If fValidaCampos(edtDepartamento, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCupomDesconto.edtFornecedorExit(Sender: TObject);
begin
  inherited;
  If (edtFornecedor.Text = '00000000') Then
  Begin
    If(edtDesFornecedor.Text = '+1') Then
      Exit;
  End;

  If fEmptyStr(edtFornecedor.Text) Then
    edtDesFornecedor.Text := 'TODOS'
  Else
  Begin
    edtDesFornecedor.Text := fRetNomFornecedor(edtFornecedor.Text);
    SetLength(arrFornec, 1);
    arrFornec[0].strCodigo := edtFornecedor.Text;
  End;


  If fEmptyStr(edtDesFornecedor.Text) Then
  Begin
    If(Not fEmptyStr(edtFornecedor.Text))  Then
    Begin
      fMensagem('AVISO', 'Fornecedor não encontrado.', ['&O K']);
      edtFornecedor.Clear;
      pSetFocus(edtFornecedor);
    End;
  End;
end;

procedure TfrmCadCupomDesconto.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCupomDesconto.edtImpLisExit(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtImpLis.Text)) Then
  Begin
    If(edtImpLis.Text <> 'S') Then
    Begin
      If(edtImpLis.Text <> 'N') Then
      Begin
        edtImpLis.Clear;
      End;
    End;
  End;
end;

procedure TfrmCadCupomDesconto.edtMarcaExit(Sender: TObject);
begin
  inherited;
  If (edtMarca.Text = '000000') Then
  Begin
    If(edtDesMarca.Text = '+1') Then
      Exit;
  End;

  If fEmptyStr(edtMarca.Text) Then
    edtDesMarca.Text := 'TODOS'
  Else
  Begin
    edtDesMarca.Text := fRetNomMarca(edtMarca.Text);
    SetLength(arrMarca, 1);
    arrMarca[0].strCodigo := edtMarca.Text;
  End;


  If fEmptyStr(edtDesMarca.Text) Then
  Begin
    If(Not fEmptyStr(edtMarca.Text))  Then
    Begin
      fMensagem('AVISO', 'Marca não encontrada.', ['&O K']);
      edtMarca.Clear;
      pSetFocus(edtMarca);
    End;
  End;
end;

procedure TfrmCadCupomDesconto.edtMarcaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCupomDesconto.edtProAtiExit(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtProAti.Text)) Then
  Begin
    If(edtProAti.Text <> 'S') Then
    Begin
      If(edtProAti.Text <> 'N') Then
      Begin
        edtProAti.Clear;
      End;
    End;
  End;
end;

procedure TfrmCadCupomDesconto.edtUnidadeExit(Sender: TObject);
begin
  inherited;
  If (edtUnidade.Text = '000') Then
  Begin
    If(edtDesUnidade.Text = '+1') Then
      Exit;
  End;

  If fEmptyStr(edtUnidade.Text) Then
    edtDesUnidade.Text := 'TODOS'
  Else
  Begin
    edtDesUnidade.Text := fRetNomUnidade(edtUnidade.Text);
    SetLength(arrUnidades, 1);
    arrUnidades[0].strCodigo := edtUnidade.Text;
  End;


  If fEmptyStr(edtDesUnidade.Text) Then
  Begin
    If(Not fEmptyStr(edtUnidade.Text))  Then
    Begin
      fMensagem('AVISO', 'unidade não encontrada.', ['&O K']);
      edtUnidade.Clear;
      pSetFocus(edtUnidade);
    End;
  End;
end;

procedure TfrmCadCupomDesconto.edtUnidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fPesqUnidade(Self, edtUnidade, edtDesUnidade, Nil, Nil, Key, arrUnidades, False) then
  begin
    If fValidaCampos(edtUnidade, True) Then
      SelectNext(ActiveControl, True, True);
  end;
end;

function TfrmCadCupomDesconto.fExcluiItensCupom(strAutInc: string): Boolean;
var
  qryItens: TUniQuery;
begin
  qryItens := fCriaQuery;

  try
    Result := False;

    qryItens.Close;
    qryItens.SQL.Clear;
    qryItens.SQL.Add('DELETE FROM ITECUP');
    qryItens.SQL.Add('WHERE CUP_SEQCUP = :SEQCUP');

    qryItens.ParamByName('SEQCUP').AsString := strAutInc;

    qryItens.ExecSQL;

    Result := True;
  finally
    FreeAndNil(qryItens);
  end;
end;

function TfrmCadCupomDesconto.fGravaItensCupom(strAutInc: string): Boolean;
var
  qryGravaItens: TUniQuery;
begin
  qryGravaItens := fCriaQuery;
  cdsItens.DisableControls;
  cdsItens.First;

  try
    Result := False;

    if not fExcluiItensCupom(strAutInc) then
      Exit;

    qryGravaItens.Close;
    qryGravaItens.SQL.Clear;
    qryGravaItens.SQL.Add('INSERT INTO ITECUP(AUTOINCREM, CUP_SEQCUP, CUP_CODEMP, CUP_CODITE, CUP_UNIDAD, CUP_CODMAR, CUP_REFERE, CUP_CODFOR)');
    qryGravaItens.SQL.Add('VALUES(:AUTINC, :SEQCUP, :CODEMP, :CODITE, :UNIDAD, :CODMAR, :REFERE, :CODFOR)');

    while not cdsItens.Eof do
    begin
      qryGravaItens.Close;
      qryGravaItens.ParamByName('AUTINC').AsString := fRetAutoIncrem('ITECUP', VS_strCodEmp);
      qryGravaItens.ParamByName('SEQCUP').AsString := strAutInc;
      qryGravaItens.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGravaItens.ParamByName('CODITE').AsString := cdsItensCODITE.AsString;
      qryGravaItens.ParamByName('UNIDAD').AsString := cdsItensUNIDAD.AsString;
      qryGravaItens.ParamByName('CODMAR').AsString := cdsItensMARCA_.AsString;
      qryGravaItens.ParamByName('REFERE').AsString := cdsItensREFERE.AsString;
      qryGravaItens.ParamByName('CODFOR').AsString := cdsItensCODFOR.AsString;
      qryGravaItens.ExecSQL;

      cdsItens.Next;
    end;

    Result := True;
  finally
    FreeAndNil(qryGravaItens);
    cdsItens.First;
    cdsItens.EnableControls;
  end;

end;

function TfrmCadCupomDesconto.fGravouItensCupom: Boolean;
begin
  Result := True;

  if tbsItensCupom.TabVisible then
  begin
    if fInformouItens then
    begin
      if not fGravaItensCupom(qryTabela.FieldByName('AUTOINCREM').AsString) then
      begin
        fMensagem('ATENÇÃO!', 'Não foi possível gravar os itens do cupom!', ['&Ok']);
        Result := False;
      end;
    end;
  end;
end;

function TfrmCadCupomDesconto.fInformouItens: Boolean;
begin
  Result := True;

  if rdbVlItPe.Checked then
  begin
    Result := cdsItens.RecordCount > 0;
    Exit;
  end;

  if rdbVlItFi.Checked then
  begin
    Result := cdsItens.RecordCount > 0;
    Exit;
  end;
end;

procedure TfrmCadCupomDesconto.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodCup, dbeDescri, False);
  pHabilitarTipoCupom();
  pHabilitarUtilizacaoCupom();
  pCarregarTipoCupom();
  pCarregarUtilizacaoCupom();
  pLimpaFiltro;
  pCarregaItensCupom(qryTabela.FieldByName('AUTOINCREM').AsString);
end;

function TfrmCadCupomDesconto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dbeCodCup) Then
  Begin

    If (fEmptyStr(dbeCodCup.Text)) And (dbeCodCup.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O Código do cupom de desconto deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (blnBuscaPorChave) Then
    Begin
      If Not fBuscaPorCamposChave Then
        pLimparCampos;
    End;

  End
  Else If (Sender = dbeDescri) Then
  Begin

    If fEmptyStr(dbeDescri.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'A descrição do cupom de desconto deve ser preenchida!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeTipPes) Then
  Begin

    If fEmptyStr(dbeTipPes.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O campo Tipo de Cliente deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If ((dbeTipPes.Text <> 'F') and (dbeTipPes.Text <> 'J') and
      (dbeTipPes.Text <> 'A')) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O campo Tipo de Cliente deve ser preenchido com "F", "J" ou "A"!',
        ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeIniVig) Then
  Begin

    If fEmptyStr(dbeIniVig.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O campo de início da vigência deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If StrToDateDef(dbeIniVig.Text, 0) = 0 Then
    Begin
      fMensagem('ATENÇÃO!',
        'Informe uma data válida para o início da vigência!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeFinVig) Then
  Begin

    If fEmptyStr(dbeFinVig.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O campo de final da vigência deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If StrToDateDef(dbeFinVig.Text, 0) = 0 Then
    Begin
      fMensagem('ATENÇÃO!',
        'Informe uma data válida para o final da vigência!', ['&Ok']);
      Result := False;
    End
    Else If StrToDateDef(dbeFinVig.Text, 0) <
      StrToDateDef(dbeIniVig.Text, 0) Then
    Begin
      fMensagem('ATENÇÃO!',
        'A data final da vigência não pode ser menor que a data inicial!',
        ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeValFix) And dbeValFix.Enabled Then
  Begin

    If fEmptyStr(dbeValFix.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe o valor fixo do desconto!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbeValFix.Text) <= 0 Then
    Begin
      fMensagem('ATENÇÃO!',
        'O valor fixo do desconto deve ser maior que zero!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbePerDes) And dbePerDes.Enabled Then
  Begin

    If fEmptyStr(dbePerDes.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'Informe o percentual do desconto sobre o valor da compra!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbePerDes.Text) <= 0 Then
    Begin
      fMensagem('ATENÇÃO!',
        'O percentual do desconto deve ser maior que zero!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeValCom) And dbeValCom.Enabled Then
  Begin

    If fEmptyStr(dbeValCom.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe o valor em compras!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbeValCom.Text) <= 0 Then
    Begin
      fMensagem('ATENÇÃO!',
        'O valor em compras deve ser maior que zero!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeValAcu) And dbeValAcu.Enabled Then
  Begin

    If fEmptyStr(dbeValAcu.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe o valor para acumular no cupom!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbeValAcu.Text) <= 0 Then
    Begin
      fMensagem('ATENÇÃO!',
        'O valor para acumular no cupom deve ser maior que zero!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeVlItPe) And dbeVlItPe.Enabled Then
  Begin
    If fEmptyStr(dbeVlItPe.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe o percentual sobre o valor dos itens!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbeVlItPe.Text) <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O precentual sobre o valor dos itens deve ser maior que zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeVlItFi) And dbeVlItFi.Enabled Then
  Begin
    If fEmptyStr(dbeVlItFi.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe o valor fixo dos itens!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbeVlItFi.Text) <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor fixo dos itens deve ser maior que zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeMinVen) Then
  Begin

    If fEmptyStr(dbeMinVen.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'Informe o valor mínimo para permitir utilizar este cupom em vendas!',
        ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbeMinVen.Text) < 0 Then
    Begin
      fMensagem('ATENÇÃO!',
        'O valor mínimo para permitir utilizar este cupom em vendas deve ser maior ou igual à zero!',
        ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeDiaExp) And dbeDiaExp.Enabled Then
  Begin

    If fEmptyStr(dbeDiaExp.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'A quantidade de dias para expirar o cupom deve ser informado!', ['&Ok']
        );
      Result := False;
    End
    Else If fStrToFloat(dbeDiaExp.Text) < 0 Then
    Begin
      fMensagem('ATENÇÃO!',
        'A quantidade de dias para expirar o cupom deve ser maior ou igual à zero!',
        ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeIniVal) And dbeIniVal.Enabled Then
  Begin

    If fEmptyStr(dbeIniVal.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O campo de início de utilização do cupom deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If StrToDateDef(dbeIniVal.Text, 0) = 0 Then
    Begin
      fMensagem('ATENÇÃO!',
        'Informe uma data válida para o início de utilização do cupom!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeFinVal) And dbeFinVal.Enabled Then
  Begin

    If fEmptyStr(dbeFinVal.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O campo de final de utilização do cupom deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If StrToDateDef(dbeFinVal.Text, 0) = 0 Then
    Begin
      fMensagem('ATENÇÃO!',
        'Informe uma data válida para o término de utilização do cupom!', ['&Ok']);
      Result := False;
    End
    Else If StrToDateDef(dbeFinVal.Text, 0) <
      StrToDateDef(dbeIniVal.Text, 0) Then
    Begin
      fMensagem('ATENÇÃO!',
        'A data final de utilização do cupom não pode ser menor que a data inicial!',
        ['&Ok']);
      Result := False;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadCupomDesconto.grdItensDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case key of
    VK_DELETE: pExcluiRegistroItens;
  end;
end;

procedure TfrmCadCupomDesconto.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  If (mskLinhaGrupo.Text = '000000') Then
  Begin
    If(edtDesGrupo.Text = '+1') Then
      Exit;
  End;

  If fEmptyStr(mskLinhaGrupo.Text) Then
    edtDesGrupo.Text := 'TODOS'
  Else
  Begin
    edtDesGrupo.Text := fRetNomeLinhaGrupo(mskLinhaGrupo.Text);
    SetLength(arrGrupos, 1);
    arrGrupos[0].strCodigo := mskLinhaGrupo.Text;
  End;


  If fEmptyStr(edtDesGrupo.Text) Then
  Begin
    If(Not fEmptyStr(mskLinhaGrupo.Text))  Then
    Begin
      fMensagem('AVISO', 'Linha/Grupo não encontrado.', ['&O K']);
      mskLinhaGrupo.Clear;
      pSetFocus(mskLinhaGrupo);
    End;
  End;
end;

procedure TfrmCadCupomDesconto.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, Nil, Key, arrGrupos, False) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCupomDesconto.pAfterOpen(DataSet: TDataSet);
Var
  intIndex: Integer;
begin
  For intIndex := 0 To DataSet.Fields.Count - 1 Do
  Begin
    Case DataSet.Fields[intIndex].DataType Of
      ftFloat, ftCurrency, ftBCD:
        TFloatField(DataSet.Fields[intIndex]).DisplayFormat := '#,##0.00';
      ftDate:
        TDateField(DataSet.Fields[intIndex]).EditMask := '99/99/9999';
    End;
  End;
end;

procedure TfrmCadCupomDesconto.pCarregaItensCupom(strSeqCup: string);
var
  qryItens: TUniQuery;
begin
  qryItens := fCriaQuery;

  try
    qryItens.Close;
    qryItens.SQL.Clear;
    qryItens.SQL.Add('SELECT * FROM ITECUP');
    qryItens.SQL.Add('WHERE CUP_SEQCUP = :SEQCUP');
    qryItens.ParamByName('SEQCUP').AsString := strSeqCup;
    qryItens.Open;

    cdsItens.EmptyDataSet;

    if qryItens.IsEmpty then
      Exit;

    cdsItens.DisableControls;

    try
      while not qryItens.Eof do
      begin
        cdsItens.Append;
        cdsItensCODITE.AsString := qryItens.FieldByName('CUP_CODITE').AsString;
        cdsItensDESITE.AsString := fRetNomProduto(qryItens.FieldByName('CUP_CODITE').AsString);
        cdsItensUNIDAD.AsString := qryItens.FieldByName('CUP_UNIDAD').AsString;
        cdsItensCODMAR.AsString := qryItens.FieldByName('CUP_CODMAR').AsString;
        cdsItensMARCA_.AsString := fRetNomMarca(qryItens.FieldByName('CUP_CODMAR').AsString);
        cdsItensREFERE.AsString := qryItens.FieldByName('CUP_REFERE').AsString;
        cdsItensCODFOR.AsString := qryItens.FieldByName('CUP_CODFOR').AsString;
        cdsItensNOMFOR.AsString := qryItens.FieldByName('CUP_CODFOR').AsString + '-' +fRetNomFornecedor(qryItens.FieldByName('CUP_CODFOR').AsString);
        cdsItens.Post;

        qryItens.Next;
      end;

      cdsItens.First;
    finally
      cdsItens.EnableControls;
    end;
  finally
    FreeAndNil(qryItens);
  end;
end;

procedure TfrmCadCupomDesconto.pCarregarTipoCupom;
begin
  rdbValFix.Checked := qryTabela.FieldByName('CUP_TIPCUP').AsString = 'VF';
  rdbPerDes.Checked := qryTabela.FieldByName('CUP_TIPCUP').AsString = 'PD';
  rdbValCom.Checked := qryTabela.FieldByName('CUP_TIPCUP').AsString = 'VC';
  rdbVlItPe.Checked := qryTabela.FieldByName('CUP_TIPCUP').AsString = 'PI';
  rdbVlItFi.Checked := qryTabela.FieldByName('CUP_TIPCUP').AsString = 'VI';
  rdbValFixClick(nil);
end;

procedure TfrmCadCupomDesconto.pCarregarUtilizacaoCupom;
begin
  rdbDiaExp.Checked := qryTabela.FieldByName('CUP_INIVAL').IsNull;
  rdbDtaVal.Checked := Not qryTabela.FieldByName('CUP_INIVAL').IsNull;
  rdbDiaExpClick(nil);
end;

procedure TfrmCadCupomDesconto.pDefinirTipoCupom;
begin
  If rdbValFix.Checked Then
    qryTabela.FieldByName('CUP_TIPCUP').AsString := 'VF';

  If rdbPerDes.Checked Then
    qryTabela.FieldByName('CUP_TIPCUP').AsString := 'PD';

  If rdbValCom.Checked Then
    qryTabela.FieldByName('CUP_TIPCUP').AsString := 'VC';

  If rdbVlItPe.Checked Then
    qryTabela.FieldByName('CUP_TIPCUP').AsString := 'PI';

  If rdbVlItFi.Checked Then
    qryTabela.FieldByName('CUP_TIPCUP').AsString := 'VI';
end;

procedure TfrmCadCupomDesconto.pExcluiRegistroItens;
begin
  if cdsItens.Active then
  begin
    if cdsItens.RecordCount > 0 then
    begin
      if cdsItens.RecNo > 0 then
      begin
        if fMensagem('ATENÇÃO', 'Deseja excluir o item?', ['&Sim','&Não'], 2) = 1 then
        begin
          cdsItens.Delete;
        end;
      end;
    end;
  end;
end;

procedure TfrmCadCupomDesconto.pHabilitarTipoCupom;
begin
  rdbValFix.Enabled := qryTabela.State In [dsEdit, dsInsert];
  rdbPerDes.Enabled := qryTabela.State In [dsEdit, dsInsert];
  rdbValCom.Enabled := qryTabela.State In [dsEdit, dsInsert];
  rdbVlItPe.Enabled := qryTabela.State In [dsEdit, dsInsert];
  rdbVlItFi.Enabled := qryTabela.State In [dsEdit, dsInsert];
  grdItens.Enabled  := qryTabela.State In [dsEdit, dsInsert];
end;

procedure TfrmCadCupomDesconto.pHabilitarUtilizacaoCupom;
begin
  rdbDiaExp.Enabled := qryTabela.State In [dsEdit, dsInsert];
  rdbDtaVal.Enabled := qryTabela.State In [dsEdit, dsInsert];
end;

procedure TfrmCadCupomDesconto.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CUP_CODCUP');
  stlCampos.Add('CUP_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CUP_DESCRI');
  stlCamInd.Add('CUP_CODCUP');

  stlDesInd.Add('Nome');
  stlDesInd.Add('Código');

end;

procedure TfrmCadCupomDesconto.pLimpaFiltro;
begin
  edtCodIte.Clear;
  edtDesIte.Clear;
  mskLinhaGrupo.Clear;
  edtDesGrupo.Clear;
  edtFornecedor.Clear;
  edtDesFornecedor.Clear;
  edtDepartamento.Clear;
  edtDesDepartamento.Clear;
  edtDescriIni.Clear;
  edtDescriFin.Clear;
  edtRefere.Clear;
  edtImpLis.Clear;
  edtUnidade.Clear;
  edtDesUnidade.Clear;
  edtProAti.Clear;
end;

procedure TfrmCadCupomDesconto.pRetornaItens;
var
  qryItens: TUniQuery;
  cdsItemBKP: TUniClientDataSet;
begin
  qryItens := fCriaQuery;
  cdsItemBKP := TUniClientDataSet.Create(nil);

  try
    pCloneDataSet(cdsItemBKP, cdsItens);

    qryItens.Close;
    qryItens.SQL.Clear;
    qryItens.SQL.Add('SELECT I.ITE_CODITE, I.ITE_DESITE, I.ITE_CODUNI, I.ITE_CODMAR,');
    qryItens.SQL.Add('       I.ITE_REFERE, I.ITE_CODFOR, F.FOR_NOMFOR, M.MAR_DESMAR');
    qryItens.SQL.Add('FROM CADITE I');
    qryItens.SQL.Add('INNER JOIN ITEGER G');
    qryItens.SQL.Add('ON(I.ITE_CODITE = G.ITE_CODITE AND G.ITE_CODEMP = '+QuotedStr(VS_strCodEmp)+')');
    qryItens.SQL.Add('LEFT JOIN CADFOR F');
    qryItens.SQL.Add('ON(I.ITE_CODFOR = F.FOR_CODFOR)');
    qryItens.SQL.Add('LEFT JOIN CADMAR M');
    qryItens.SQL.Add('ON(I.ITE_CODMAR = M.MAR_CODMAR)');
    qryItens.SQL.Add('WHERE 1=1');

    pWhereItensPrincipal(qryItens);

    qryItens.Open;

    SetLength(arrItens, 0);
    SetLength(arrGrupos, 0);
    SetLength(arrMarca, 0);
    SetLength(arrFornec, 0);
    SetLength(arrDep, 0);
    SetLength(arrUnidades, 0);

    if qryItens.IsEmpty then
    begin
      fMensagem('AVISO', 'Nenhum registro encontrado nos filtros informado.', ['&OK']);
    end
    else
    begin
      cdsItens.DisableControls;

      try
        if cdsItens.RecordCount > 0 then
        begin
          if fMensagem('ATENÇÃO', 'Deseja refazer a lista de itens ou acrescentar?', ['&Refazer','&Acrescentar'],2) = 1 then
          begin
            cdsItens.EmptyDataSet;
          end;
        end;

        while not qryItens.Eof do
        begin
          if not cdsItemBKP.Locate('CODITE', qryItens.FieldByName('ITE_CODITE').AsString, []) then
          begin
            cdsItens.Append;
            cdsItensCODITE.AsString := qryItens.FieldByName('ITE_CODITE').AsString;
            cdsItensDESITE.AsString := qryItens.FieldByName('ITE_DESITE').AsString;
            cdsItensUNIDAD.AsString := qryItens.FieldByName('ITE_CODUNI').AsString;
            cdsItensCODMAR.AsString := qryItens.FieldByName('ITE_CODMAR').AsString;
            cdsItensMARCA_.AsString := qryItens.FieldByName('MAR_DESMAR').AsString;
            cdsItensREFERE.AsString := qryItens.FieldByName('ITE_REFERE').AsString;
            cdsItensCODFOR.AsString := qryItens.FieldByName('ITE_CODFOR').AsString;
            cdsItensNOMFOR.AsString := qryItens.FieldByName('ITE_CODFOR').AsString + '-' +qryItens.FieldByName('FOR_NOMFOR').AsString;
            cdsItens.Post;
          end;

          qryItens.Next;
        end;

        cdsItens.First;
      finally
        cdsItens.EnableControls;
      end;
    end;
  finally
    FreeAndNil(qryItens);
    FreeAndNil(cdsItemBKP);
  end;
end;

procedure TfrmCadCupomDesconto.pVerificaRadioGroupHabilitado;
begin
  If Not dbeValFix.Enabled Then
    dbeValFix.Field.AsFloat := 0;

  If Not dbePerDes.Enabled Then
    dbePerDes.Field.AsFloat := 0;

  If Not dbeValCom.Enabled Then
    dbeValCom.Field.AsFloat := 0;

  If Not dbeValAcu.Enabled Then
    dbeValAcu.Field.AsFloat := 0;

  If Not dbeVlItPe.Enabled Then
    dbeVlItPe.Field.AsFloat := 0;

  If Not dbeVlItFi.Enabled Then
    dbeVlItFi.Field.AsFloat := 0;
end;

procedure TfrmCadCupomDesconto.pWhereItens1(var qryItens: TUniQuery);
var
  strResult: string;
  intIndice: integer;
begin
  strResult := EmptyStr;
  for intIndice := Low(arrFornec) to High(arrFornec) do
  begin
    pIncrementaListaStr(arrFornec[intIndice].strCodigo, strResult, True);
  end;

  if not fEmptyStr(strResult) then
  begin
    qryItens.SQL.Add('AND I.ITE_CODFOR IN('+strResult+')');
  end;

  strResult := EmptyStr;
  for intIndice := Low(arrDep) to High(arrDep) do
  begin
    pIncrementaListaStr(arrDep[intIndice].strCodigo, strResult, True);
  end;

  if not fEmptyStr(strResult) then
  begin
    qryItens.SQL.Add('AND I.ITE_CODDEP IN('+strResult+')');
  end;

  strResult := EmptyStr;
  for intIndice := Low(arrUnidades) to High(arrUnidades) do
  begin
    pIncrementaListaStr(arrUnidades[intIndice].strCodigo, strResult, True);
  end;

  if not fEmptyStr(strResult) then
  begin
    qryItens.SQL.Add('AND I.ITE_CODUNI IN('+strResult+')');
  end;

  pWhereItens2(qryItens);
end;

procedure TfrmCadCupomDesconto.pWhereItens2(var qryItens: TUniQuery);
begin
  if not fEmptyStr(edtRefere.Text) then
  begin
    qryItens.SQL.Add('AND I.ITE_REFERE = '+QuotedStr(edtRefere.Text)+'');
  end;

  if not fEmptyStr(edtImpLis.Text) then
  begin
    qryItens.SQL.Add('AND G.ITE_IMPLIS = '+QuotedStr(edtImpLis.Text)+'');
  end;

  if not fEmptyStr(edtProAti.Text) then
  begin
    qryItens.SQL.Add('AND I.ITE_ITEATI = '+QuotedStr(edtProAti.Text)+'');
  end;

  pWhereItensDescricao(qryItens);
end;

procedure TfrmCadCupomDesconto.pWhereItensDescricao(var qryItens: TUniQuery);
begin
  if not fEmptyStr(edtDescriIni.Text) then
  begin
    if fEmptyStr(edtDescriFin.Text) then
    begin
      qryItens.SQL.Add('AND I.ITE_DESITE = :DESINI');
      qryItens.ParamByName('DESINI').AsString := edtDescriIni.Text + '%';
      Exit;
    end;
  end;

  if fEmptyStr(edtDescriIni.Text) then
  begin
    if not fEmptyStr(edtDescriFin.Text) then
    begin
      qryItens.SQL.Add('AND I.ITE_DESITE = :DESFIN');
      qryItens.ParamByName('DESFIN').AsString := '%' + edtDescriFin.Text;
      Exit;
    end;
  end;

  if not fEmptyStr(edtDescriIni.Text) then
  begin
    if not fEmptyStr(edtDescriFin.Text) then
    begin
      qryItens.SQL.Add('AND LEFT(ITE_DESITE, LENGTH(:MAIOR)) BETWEEN :DESINI AND :DESFIN');
      qryItens.ParamByName('MAIOR').AsString := edtDescriIni.Text;
      qryItens.ParamByName('DESINI').AsString := edtDescriIni.Text;
      qryItens.ParamByName('DESFIN').AsString := edtDescriFin.Text;
      Exit;
    end;
  end;
end;

procedure TfrmCadCupomDesconto.pWhereItensPrincipal(var qryItens: TUniQuery);
var
  strResult: string;
  intIndice: integer;
begin
  strResult := EmptyStr;
  for intIndice := Low(arrItens) to High(arrItens) do
  begin
    pIncrementaListaStr(arrItens[intIndice].strCodigo, strResult, True);
  end;

  if not fEmptyStr(strResult) then
  begin
    qryItens.SQL.Add('AND I.ITE_CODITE IN('+strResult+')');
  end;

  strResult := EmptyStr;
  for intIndice := Low(arrGrupos) to High(arrGrupos) do
  begin
    pIncrementaListaStr(arrGrupos[intIndice].strCodigo, strResult, True);
  end;

  if not fEmptyStr(strResult) then
  begin
    qryItens.SQL.Add('AND I.ITE_CODGRU IN('+strResult+')');
  end;

  strResult := EmptyStr;
  for intIndice := Low(arrMarca) to High(arrMarca) do
  begin
    pIncrementaListaStr(arrMarca[intIndice].strCodigo, strResult, True);
  end;

  if not fEmptyStr(strResult) then
  begin
    qryItens.SQL.Add('AND I.ITE_CODMAR IN('+strResult+')');
  end;

  pWhereItens1(qryItens);
end;

procedure TfrmCadCupomDesconto.rdbDiaExpClick(Sender: TObject);
begin
  inherited;
  If Not (qryTabela.State In [dsEdit, dsInsert]) Then
    Exit;

  dbeDiaExp.Enabled := rdbDiaExp.Checked;
  dbeIniVal.Enabled := rdbDtaVal.Checked;
  dbeFinVal.Enabled := rdbDtaVal.Checked;

  If Not dbeDiaExp.Enabled Then
    dbeDiaExp.Field.AsFloat := 0;

  If Not dbeIniVal.Enabled Then
    dbeIniVal.Field.Clear;

  If Not dbeFinVal.Enabled Then
    dbeFinVal.Field.Clear;
end;

procedure TfrmCadCupomDesconto.rdbValFixClick(Sender: TObject);
begin
  inherited;
  If Not (qryTabela.State In [dsEdit, dsInsert]) Then
    Exit;

  dbeValFix.Enabled := rdbValFix.Checked;
  dbePerDes.Enabled := rdbPerDes.Checked;
  dbeValCom.Enabled := rdbValCom.Checked;
  dbeValAcu.Enabled := rdbValCom.Checked;
  dbeVlItPe.Enabled := rdbVlItPe.Checked;
  dbeVlItFi.Enabled := rdbVlItFi.Checked;

  tbsItensCupom.TabVisible := ((rdbVlItPe.Checked) Or (rdbVlItFi.Checked));

  pVerificaRadioGroupHabilitado;
end;

end.
