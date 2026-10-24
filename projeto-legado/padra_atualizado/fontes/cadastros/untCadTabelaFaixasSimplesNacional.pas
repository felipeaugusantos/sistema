unit untCadTabelaFaixasSimplesNacional;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, Uni,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Data.DB, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, DBComboBoxFocus, ComboBoxFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCitel, cxGrid, Datasnap.DBClient, UniClientDataSet, cxContainer,
  cxTextEdit, cxCurrencyEdit, CurrencyEditFocus, System.Math, MaskEditFocus,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TTipoOperacao = (toIncluir, toAlterar, toCancelar, toRemover, toConfirmar, toNeutro);

  TfrmCadTabelaFaixasSimplesNacional = class(TfrmPaiCad)
    dtsSimPau: TDataSource;
    grbDadosGerais: TGroupBox;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    lblTipo: TLabel;
    cmbTipTab: TComboBoxFocus;
    grbFaixasFaturamento: TGroupBox;
    grdFaixas: TcxGridCitel;
    grdFaixasTableView1: TcxGridDBTableViewCitel;
    grdFaixasLevel1: TcxGridLevel;
    pnlDadosFaixas: TPanel;
    grdFaixasTSN_IDXFXA: TcxGridDBColumn;
    grdFaixasTSN_LIMINF: TcxGridDBColumn;
    grdFaixasTSN_LIMSUP: TcxGridDBColumn;
    grdFaixasTSN_ALIQUO: TcxGridDBColumn;
    grdFaixasTSN_ALIRPJ: TcxGridDBColumn;
    grdFaixasTSN_ALCSLL: TcxGridDBColumn;
    grdFaixasTSN_ALQCOF: TcxGridDBColumn;
    grdFaixasTSN_ALQPIS: TcxGridDBColumn;
    grdFaixasTSN_ALQCPP: TcxGridDBColumn;
    grdFaixasTSN_ALQISS: TcxGridDBColumn;
    dtsFaixas: TDataSource;
    cdsFaixas: TUniClientDataSet;
    lblLimInf: TLabel;
    edtLimInf: TCurrencyEditFocus;
    lblLimSup: TLabel;
    edtLimSup: TCurrencyEditFocus;
    lblAliquo: TLabel;
    edtAliquo: TCurrencyEditFocus;
    edtIrpj: TCurrencyEditFocus;
    lblIrpj: TLabel;
    lblCsll: TLabel;
    edtCsll: TCurrencyEditFocus;
    lblCofins: TLabel;
    edtCofins: TCurrencyEditFocus;
    edtPis: TCurrencyEditFocus;
    lblPis: TLabel;
    lblCpp: TLabel;
    edtCpp: TCurrencyEditFocus;
    lblIcms: TLabel;
    edtIcms: TCurrencyEditFocus;
    btnCalcLimInf: TSpeedButton;
    lblIss: TLabel;
    edtIss: TCurrencyEditFocus;
    edtIpi: TCurrencyEditFocus;
    lblIpi: TLabel;
    grdFaixasTSN_ALQICM: TcxGridDBColumn;
    grdFaixasTSN_ALQIPI: TcxGridDBColumn;
    Label4: TLabel;
    mskIniVig: TMaskEditFocus;
    pnlBotoesFaixas: TPanel;
    btnAdicionar: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    btnRemover: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    lblRelacaoR: TLabel;
    lblLegenda: TLabel;
    lblVlrDescontar: TLabel;
    grdFaixasTSN_VLRDES: TcxGridDBColumn;
    edtVlrDes: TCurrencyEditFocus;
    dbeALIQEF: TDBCheckBox;
    Label3: TLabel;
    edtCBS: TCurrencyEditFocus;
    Label5: TLabel;
    edtIBS: TCurrencyEditFocus;
    Label6: TLabel;
    mskFimVig: TMaskEditFocus;
    grdFaixasTSN_ALQCBS: TcxGridDBColumn;
    grdFaixasTSN_ALQIBS: TcxGridDBColumn;
    dbrdgRegime: TDBRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure cmbTipTabChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCalcLimInfClick(Sender: TObject);
    procedure mskIniVigChange(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure grdFaixasTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure edtLimInfExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mskFimVigChange(Sender: TObject);
  private
    { Private declarations }
    qrySimPau: TUniQuery;
    toOperAtual: TTipoOperacao;

    procedure pLimparTela;
    procedure pAtualizarComponentes(blnEnabled: Boolean);
    procedure pCriarClientDatasetFaixas;
    procedure pCarregarFaixasCadastro(strAutoincrem: String);
    function  fGravarFaixasFaturamento: Boolean;
    function  fAdicionarFaixa: Boolean;
    function  fValidaDadosFaixa: Boolean;
    procedure pVerificarTipoTabela;
    function  fAtualizarPanelFaixas: Boolean;
    procedure pHabilitarBotoesFaixas(operacao: TTipoOperacao);
    procedure pHabilitarCamposFaixas(blnEnabled: Boolean);
    function  fEditarFaixa: Boolean;
    procedure pRemoverFaixa;
    function  fPossuiTabelaIniVig(intTipTab: Integer; dteIniVig: TDateTime): Boolean;

    Const
      SQL_INSERT = 'INSERT INTO TSNFXA ( ' +
                                         ' TSN_SEQTSN, ' +
                                         ' TSN_IDXFXA, ' +
                                         ' TSN_LIMINF, ' +
                                         ' TSN_LIMSUP, ' +
                                         ' TSN_ALIQUO, ' +
                                         ' TSN_ALIRPJ, ' +
                                         ' TSN_ALCSLL, ' +
                                         ' TSN_ALQCOF, ' +
                                         ' TSN_ALQPIS, ' +
                                         ' TSN_ALQCPP, ' +
                                         ' TSN_ALQISS, ' +
                                         ' TSN_ALQIPI, ' +
                                         ' TSN_VLRDES, ' +
                                         ' TSN_ALQICM, ' +
                                         ' TSN_ALQCBS, ' +
                                         ' TSN_ALQIBS, ' +
                                         ' AUTOINCREM  ' +
                                         ') VALUES (   ' +
                                         ' :SEQTSN, ' +
                                         ' :IDXFXA, ' +
                                         ' :LIMINF, ' +
                                         ' :LIMSUP, ' +
                                         ' :ALIQUO, ' +
                                         ' :ALIRPJ, ' +
                                         ' :ALCSLL, ' +
                                         ' :ALQCOF, ' +
                                         ' :ALQPIS, ' +
                                         ' :ALQCPP, ' +
                                         ' :ALQISS, ' +
                                         ' :ALQIPI, ' +
                                         ' :VLRDES, ' +
                                         ' :ALQICM, ' +
                                         ' :ALQCBS, ' +
                                         ' :ALQIBS, ' +
                                         ' :AUTINC  ' +
                                         ')';
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConsultas;

{ TfrmCadTabelaFaixasSimplesNacional }

procedure TfrmCadTabelaFaixasSimplesNacional.btnConfirmarClick(Sender: TObject);
  Var
    blnConfirma: Boolean;
begin
  inherited;

  blnConfirma := False;

  If (toOperAtual = toIncluir) Then
    blnConfirma := fAdicionarFaixa()
  Else If (toOperAtual = toAlterar) Then Begin
    blnConfirma := fEditarFaixa();

    If (blnConfirma) Then
      grdFaixas.Enabled := True;
  End;

  If (blnConfirma) Then
    pHabilitarBotoesFaixas(toConfirmar);
end;

procedure TfrmCadTabelaFaixasSimplesNacional.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  pHabilitarBotoesFaixas(toIncluir);
  pSetFocus(edtLimInf);
end;

procedure TfrmCadTabelaFaixasSimplesNacional.btnAlterarClick(Sender: TObject);
begin
  inherited;

  If (qryTabela.State = dsEdit) Then Begin
    pHabilitaCodigo(dbeCodigo, dbeDescri, False);
    pAtualizarComponentes(True);
    pnlDadosFaixas.Enabled := True;
  End;
end;

procedure TfrmCadTabelaFaixasSimplesNacional.btnCalcLimInfClick(
  Sender: TObject);
begin
  inherited;

  If (cdsFaixas.Active) Then Begin
    If (cdsFaixas.RecordCount > 0) Then Begin
      cdsFaixas.Last();

      edtLimInf.Value := cdsFaixas.FieldByName('TSN_LIMSUP').AsFloat + 0.01;
    End Else Begin
      edtLimInf.Value := 0;
    End;
  End;
end;

procedure TfrmCadTabelaFaixasSimplesNacional.btnCancelaClick(Sender: TObject);
begin
  inherited;

  If (fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
  Begin
    cmbTipTab.ItemIndex := -1;
    mskIniVig.Text := '  /  /    ';
    mskFimVig.Text := '  /  /    ';
  End
  Else If (qryTabela.Active) And (Not qryTabela.IsEmpty) Then
  Begin
    cmbTipTab.ItemIndex := qryTabela.FieldByName('TSN_TIPTAB').AsInteger;
    mskIniVig.Text := qryTabela.FieldByName('TSN_INIVIG').AsString;
    mskFimVig.Text := qryTabela.FieldByName('TSN_FIMVIG').AsString;
  End;
  if btnCancelar.Enabled then
    btnCancelarClick(btnCancelar);


  pCarregarFaixasCadastro(qryTabela.FieldByName('AUTOINCREM').AsString);
  pAtualizarComponentes(False);
  pnlDadosFaixas.Enabled := False;


  pLimparTela();
end;

procedure TfrmCadTabelaFaixasSimplesNacional.btnCancelarClick(Sender: TObject);
begin
  inherited;

  pLimparTela();
  grdFaixas.Enabled := True;
  pHabilitarBotoesFaixas(toCancelar);
end;

procedure TfrmCadTabelaFaixasSimplesNacional.btnEditarClick(Sender: TObject);
begin
  inherited;

  If (fAtualizarPanelFaixas()) Then
    pHabilitarBotoesFaixas(toAlterar);
end;

procedure TfrmCadTabelaFaixasSimplesNacional.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadTabelaFaixasSimplesNacional.btnExcluirClick]');
    End;
  End;

  If (blnExcluiu) Then
  Begin
    fCommit;
    cmbTipTab.ItemIndex := -1;
    If (qryTabela.Active) And (Not qryTabela.IsEmpty) Then
    Begin
      mskIniVig.Text := qryTabela.FieldByName('TSN_INIVIG').AsString;
      mskFimVig.Text := qryTabela.FieldByName('TSN_FIMVIG').AsString;
    End
    Else
    Begin
      mskIniVig.Text := '  /  /    ';
      mskFimVig.Text := '  /  /    ';
    End;
    pCarregarFaixasCadastro('');
    pAtualizarComponentes(False);
    pnlDadosFaixas.Enabled := False;
  End
  Else
    fRollBack;

end;

procedure TfrmCadTabelaFaixasSimplesNacional.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;

    If (blnGravou) Then
    Begin
      fGravarFaixasFaturamento();
      fCommit();
    End
    Else
      fRollBack;

    pAtualizarComponentes(Not blnGravou);

    if btnCancelar.Enabled then
      btnCancelarClick(btnCancelar);
    pnlDadosFaixas.Enabled := False;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadTabelaFaixasSimplesNacional.btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadTabelaFaixasSimplesNacional.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodigo, dbeCodigo, False);

  qryTabela.FieldByName('TSN_CODEMP').AsString := VS_strCodEmp;
  qryTabela.FieldByName('TSN_CODOPE').AsString := strLoginUsuarioLogado;

  cmbTipTab.ItemIndex := -1;
  mskIniVig.Text := '  /  /    ';
  mskFimVig.Text := '  /  /    ';
  qryTabela.FieldByName('TSN_TIPTAB').AsInteger := -1;
  qryTabela.FieldByName('TSN_REGIME').AsString := 'R';

  pAtualizarComponentes(True);
  pnlDadosFaixas.Enabled := True;

  pCarregarFaixasCadastro('');

  pVerificarTipoTabela();

  pSetFocus(dbeDescri);
end;

procedure TfrmCadTabelaFaixasSimplesNacional.btnPesquisaClick(Sender: TObject);
  var
    chrKey: Char;
    arrCadTSN: TConsultasArray;
begin
  inherited;

  chrKey := '/';

  If fPesqTabelaSimplesNacional(Self, Nil, Nil, qryTabela, chrKey, arrCadTSN) Then Begin

    If (qryTabela.Active) And (Not qryTabela.IsEmpty) Then Begin
      cmbTipTab.ItemIndex := qryTabela.FieldByName('TSN_TIPTAB').AsInteger;

      mskIniVig.Text := qryTabela.FieldByName('TSN_INIVIG').AsString;
      mskFimVig.Text := qryTabela.FieldByName('TSN_FIMVIG').AsString;

      pCarregarFaixasCadastro(qryTabela.FieldByName('AUTOINCREM').AsString);
    End;

    pAtualizarComponentes(False);
    pHabilitarCamposFaixas(False);
    pnlDadosFaixas.Enabled := False;

    pVerificarTipoTabela();

    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadTabelaFaixasSimplesNacional.btnRemoverClick(Sender: TObject);
begin
  inherited;

  If (pnlDadosFaixas.Enabled) And (Not cdsFaixas.IsEmpty) Then Begin
    If (fMensagem('ATENÇÃO!', 'Deseja remover o registro?', ['&Sim','&Não'], 2) = 2) Then
      Exit;

    pRemoverFaixa();

    pLimparTela();
  End;

  pHabilitarBotoesFaixas(toRemover);
end;

procedure TfrmCadTabelaFaixasSimplesNacional.cmbTipTabChange(Sender: TObject);
begin
  inherited;

  If (qryTabela.Active) And (Not qryTabela.IsEmpty) Then
    qryTabela.FieldByName('TSN_TIPTAB').AsInteger := cmbTipTab.ItemIndex;

  pVerificarTipoTabela();

  edtIss.Enabled := btnConfirmar.Enabled And (cmbTipTab.ItemIndex <> 0) And (cmbTipTab.ItemIndex <> 1);
  edtIpi.Enabled := btnConfirmar.Enabled And ((cmbTipTab.ItemIndex = 1) Or (cmbTipTab.ItemIndex = 4));
end;

procedure TfrmCadTabelaFaixasSimplesNacional.edtLimInfExit(Sender: TObject);
begin
  inherited;

  If (fEmptyStr(TCurrencyEditFocus(Sender).Text)) Then
    TCurrencyEditFocus(Sender).Value := 0;
end;

function TfrmCadTabelaFaixasSimplesNacional.fGravarFaixasFaturamento: Boolean;
  Var
    i: Integer;
    qryTemp: TUniQuery;
    prcScroll: TprcScroll;

  procedure pInicializarQryFaixas; begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := SQL_INSERT;
  end;

  procedure pDeletarRegistros(strSeqFsn: String); begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := 'DELETE FROM TSNFXA WHERE TSN_SEQTSN = :SEQTSN';
    qryTemp.ParamByName('SEQTSN').AsString := strSeqFsn;
    qryTemp.ExecSQL();
  end;
begin
  Result := True;

  Try
    qryTemp := fCriaQuery(Self);
    pDisableControls(cdsFaixas, prcScroll);

    Try
      If (Not cdsFaixas.IsEmpty) Then Begin
        cdsFaixas.First();

        pDeletarRegistros(qryTabela.FieldByName('AUTOINCREM').AsString);

        For i := 0 To cdsFaixas.RecordCount - 1 Do Begin
          pInicializarQryFaixas();

          qryTemp.ParamByName('AUTINC').AsString  := fRetAutoIncrem('TSNFXA', VS_strCodEmp);
          qryTemp.ParamByName('SEQTSN').AsString  := qryTabela.FieldByName('AUTOINCREM').AsString;
          qryTemp.ParamByName('IDXFXA').AsInteger := cdsFaixas.FieldByName('TSN_IDXFXA').AsInteger;
          qryTemp.ParamByName('LIMINF').AsFloat   := cdsFaixas.FieldByName('TSN_LIMINF').AsFloat;
          qryTemp.ParamByName('LIMSUP').AsFloat   := cdsFaixas.FieldByName('TSN_LIMSUP').AsFloat;
          qryTemp.ParamByName('ALIQUO').AsFloat   := cdsFaixas.FieldByName('TSN_ALIQUO').AsFloat;
          qryTemp.ParamByName('ALIRPJ').AsFloat   := cdsFaixas.FieldByName('TSN_ALIRPJ').AsFloat;
          qryTemp.ParamByName('ALCSLL').AsFloat   := cdsFaixas.FieldByName('TSN_ALCSLL').AsFloat;
          qryTemp.ParamByName('ALQCOF').AsFloat   := cdsFaixas.FieldByName('TSN_ALQCOF').AsFloat;
          qryTemp.ParamByName('ALQPIS').AsFloat   := cdsFaixas.FieldByName('TSN_ALQPIS').AsFloat;
          qryTemp.ParamByName('ALQCPP').AsFloat   := cdsFaixas.FieldByName('TSN_ALQCPP').AsFloat;
          qryTemp.ParamByName('ALQISS').AsFloat   := cdsFaixas.FieldByName('TSN_ALQISS').AsFloat;
          qryTemp.ParamByName('ALQIPI').AsFloat   := cdsFaixas.FieldByName('TSN_ALQIPI').AsFloat;
          qryTemp.ParamByName('VLRDES').AsFloat   := cdsFaixas.FieldByName('TSN_VLRDES').AsFloat;
          qryTemp.ParamByName('ALQICM').AsFloat   := cdsFaixas.FieldByName('TSN_ALQICM').AsFloat;
          qryTemp.ParamByName('ALQCBS').AsFloat   := cdsFaixas.FieldByName('TSN_ALQCBS').AsFloat;
          qryTemp.ParamByName('ALQIBS').AsFloat   := cdsFaixas.FieldByName('TSN_ALQIBS').AsFloat;

          qryTemp.ExecSQL();

          cdsFaixas.Next();
        End;
      End;
    Except
      On E: Exception Do Begin
        pMensagensErro(E.Message, '[TfrmCadTabelaFaixasSimplesNacional.fGravarFaixasFaturamento]');
        Result := False;
      End;
    End;
  Finally
    pEnableControls(cdsFaixas, prcScroll);
    FreeAndNil(qryTemp);
  End;
end;

procedure TfrmCadTabelaFaixasSimplesNacional.FormCreate(Sender: TObject);
  Var
    strSQL: String;
begin
  inherited;

  blnUsaProCodigo   := True;

  strNomeTabela     := 'CADTSN';
  strNomeCampo      := 'TSN_CODIGO';

  strSQL            := 'SELECT * FROM CADTSN';
  qrySimPau         := fCriarQuery(strSQL, Self);
  qryTabela         := qrySimPau;
  dtsSimPau.DataSet := qryTabela;
  toOperAtual       := toNeutro;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadTabelaFaixasSimplesNacional.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_ESCAPE) Then btnSair.Click();
end;

procedure TfrmCadTabelaFaixasSimplesNacional.FormShow(Sender: TObject);
begin
  inherited;

  pAtualizarComponentes(False);
  pHabilitarCamposFaixas(False);
  pCriarClientDatasetFaixas();
  pVerificarTipoTabela();
  pHabilitarBotoesFaixas(toNeutro);

  pnlDadosFaixas.Enabled := False;
end;

function TfrmCadTabelaFaixasSimplesNacional.fPossuiTabelaIniVig(
  intTipTab: Integer; dteIniVig: TDateTime): Boolean;
  Var
    qryTemp: TUniQuery;
begin
  Try
    qryTemp := fCriaQuery(nil);

    Try
      qryTemp.Close();
      qryTemp.SQL.Clear();
      qryTemp.SQL.Text := 'SELECT AUTOINCREM FROM CADTSN WHERE TSN_INIVIG = :INIVIG AND TSN_TIPTAB = :TIPTAB AND AUTOINCREM <> :AUTINC';
      qryTemp.ParamByName('INIVIG').AsDateTime := dteIniVig;
      qryTemp.ParamByName('TIPTAB').AsInteger  := intTipTab;
      qryTemp.ParamByName('AUTINC').AsString   := qryTabela.FieldByName('AUTOINCREM').AsString;
      qryTemp.Open();

      Result := (Not qryTemp.IsEmpty);
    Except
      On E: Exception Do Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmCadTabelaFaixasSimplesNacional.fPossuiTabelaIniVig]');
      End;
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function TfrmCadTabelaFaixasSimplesNacional.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then Begin

    If (Sender = dbeDescri) Then Begin
      If (fEmptyStr(dbeDescri.Text)) Then Begin
        fMensagem('ATENÇÃO!', 'O campo Descrição deve ser informado!', ['&OK']);
        Result := False;
      End Else If (Length(dbeDescri.Text) > 60) Then Begin
        fMensagem('ATENÇÃO!', 'O campo Descrição deve possuir no máximo 60 caracteres!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = cmbTipTab) Then Begin
      If (cmbTipTab.ItemIndex = -1) Then Begin
        fMensagem('ATENÇÃO!', 'O campo Tipo deve ser informado!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = mskIniVig) Then Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskIniVig.Text))) Then Begin
        fMensagem('ATENÇÃO!', 'O campo Ini. Vigência deve ser informado!', ['&OK']);
        Result := False;
      End;

      If (Result) Then Begin
        If ( fPossuiTabelaIniVig(cmbTipTab.ItemIndex, StrToDate(mskIniVig.Text)) ) Then Begin
          fMensagem('ATENÇÃO!', 'Já existe uma tabela com a data de início de vigência informada!', ['&OK']);
          Result := False;
        End
      End;
    End
    Else If (Sender = mskFimVig) Then Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskFimVig.Text))) Then Begin
        fMensagem('ATENÇÃO!', 'O campo Fim. Vigência deve ser informado!', ['&OK']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadTabelaFaixasSimplesNacional.fValidaDadosFaixa: Boolean;

  function fSomarAliquotas: Boolean;
    Var
      fltSoma: Double;
  begin
    fltSoma   := RoundTo(edtIrpj.Value + edtCsll.Value + edtCpp.Value  + edtCofins.Value +
                         edtPis.Value  + edtIss.Value  + edtIcms.Value + edtIpi.Value, -2);

    Result := (fltSoma = 0);
  end;

  function fAliquotasNegativas: Boolean; begin
    Result := (edtIrpj.Value < 0)   Or (edtCsll.Value < 0) Or (edtCpp.Value < 0) Or
              (edtCofins.Value < 0) Or (edtPis.Value < 0)  Or (edtIss.Value < 0) Or
              (edtIcms.Value < 0)   Or (edtIpi.Value < 0);
  end;

begin
  Result := True;

  If (edtLimInf.Value < 0) Then Begin
    //LIMIT INFERIOR TEM QUE SER MAIOR QUE ZERO
    fMensagem('ATENÇÃO!', 'O campo Limite Inferior deve ser maior ou igual a zero!', ['&OK']);
    pSetFocus(edtLimInf);
    Result := False;
  End

  Else If (edtLimSup.Value < 0) Then Begin
    //LIMITE SUPERIOR TEM QUE SER MAIOR QUE ZERO
    fMensagem('ATENÇÃO!', 'O campo Limite Superior deve ser maior ou igual a zero!', ['&OK']);
    pSetFocus(edtLimSup);
    Result := False;
  End

  Else If (Not (edtLimInf.Value < edtLimSup.Value)) Then Begin
    //LIMITE INFERIOR TEM QUE SER MENOR QUE O LIMITE SUPERIOR
    fMensagem('ATENÇÃO!', 'O campo Limite Inferior deve ser menor que o campo Limite Superior!', ['&OK']);
    pSetFocus(edtLimInf);
    Result := False;
  End

  Else If (fSomarAliquotas()) And (cmbTipTab.ItemIndex <> 4) Then Begin
    //SOMA DAS ALÍQUOTAS ADICIONAIS, SE MAIOR QUE ZERO,
    //DEVE SER IGUAL A ALÍQUOTA PRINCIPAL DO SIMPLES
    fMensagem('ATENÇÃO!', 'A soma das Alíquotas de IRPJ, CSLL, COFINS, PIS, CPP, ICMS, ISS e IPI deve ser diferente de zero!', ['&OK']);
    pSetFocus(edtLimInf);
    Result := False;
  End

  Else If (cmbTipTab.ItemIndex >= 2) And (cmbTipTab.ItemIndex <> 4) Then Begin
    //SE TABELA DE SERVIÇO, NÃO PODE TER ICMS E IPI

    If (edtIcms.Value <> 0) Then Begin
      fMensagem('ATENÇÃO!', 'Tabela do tipo Serviço não deve possuir alíquota de ICMS diferente de zero!', ['&OK']);
      pSetFocus(edtIcms);
      Result := False;
    End Else If (edtIpi.Value <> 0) Then Begin
      fMensagem('ATENÇÃO!', 'Tabela do tipo Serviço não deve possuir alíquota de IPI diferente de zero!', ['&OK']);
      pSetFocus(edtIpi);
      Result := False;
    End;
  End

  Else If (edtVlrDes.Value < 0) Then Begin
    fMensagem('ATENÇÃO!', 'O campo Vr à Descontar deve ser maior ou igual a zero!', ['&OK']);
    pSetFocus(edtVlrDes);
    Result := False;
  End;
end;

procedure TfrmCadTabelaFaixasSimplesNacional.grdFaixasTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  btnEditar.Click();
end;

procedure TfrmCadTabelaFaixasSimplesNacional.mskFimVigChange(Sender: TObject);
begin
  inherited;
  If (qryTabela.Active) And (Not qryTabela.IsEmpty) And (qryTabela.State <> dsBrowse) Then Begin
    If (Not fEmptyStr(fTiraCaracEspeciais(mskFimVig.Text))) Then
      qryTabela.FieldByName('TSN_FIMVIG').AsDateTime := StrToDate(mskFimVig.Text)
    Else
      qryTabela.FieldByName('TSN_FIMVIG').Value := null;
  End;
end;

procedure TfrmCadTabelaFaixasSimplesNacional.mskIniVigChange(Sender: TObject);
begin
  inherited;

  If (qryTabela.Active) And (Not qryTabela.IsEmpty) And (qryTabela.State <> dsBrowse) Then Begin
    If (Not fEmptyStr(fTiraCaracEspeciais(mskIniVig.Text))) Then
      qryTabela.FieldByName('TSN_INIVIG').AsDateTime := StrToDate(mskIniVig.Text)
    Else
      qryTabela.FieldByName('TSN_INIVIG').Value := null;
  End;
end;

function TfrmCadTabelaFaixasSimplesNacional.fAdicionarFaixa: Boolean;
  Var
    intIdxFxa: Integer;
begin
  Result := False;

  Try
    If (fValidaDadosFaixa()) Then Begin
      If (cdsFaixas.RecNo <= 0) Then
        intIdxFxa := 1
      Else
        intIdxFxa := cdsFaixas.RecNo + 1;

      cdsFaixas.Append();
      cdsFaixas.FieldByName('AUTOINCREM').AsString  := '';
      cdsFaixas.FieldByName('TSN_SEQTSN').AsString  := '';
      cdsFaixas.FieldByName('TSN_LIMINF').AsFloat   := edtLimInf.Value;
      cdsFaixas.FieldByName('TSN_LIMSUP').AsFloat   := edtLimSup.Value;
      cdsFaixas.FieldByName('TSN_ALIQUO').AsFloat   := edtAliquo.Value;
      cdsFaixas.FieldByName('TSN_ALIRPJ').AsFloat   := edtIrpj.Value;
      cdsFaixas.FieldByName('TSN_ALCSLL').AsFloat   := edtCsll.Value;
      cdsFaixas.FieldByName('TSN_ALQCOF').AsFloat   := edtCofins.Value;
      cdsFaixas.FieldByName('TSN_ALQPIS').AsFloat   := edtPis.Value;
      cdsFaixas.FieldByName('TSN_ALQICM').AsFloat   := edtIcms.Value;
      cdsFaixas.FieldByName('TSN_ALQIPI').AsFloat   := edtIpi.Value;
      cdsFaixas.FieldByName('TSN_VLRDES').AsFloat   := edtVlrDes.Value;
      cdsFaixas.FieldByName('TSN_ALQCPP').AsFloat   := edtCpp.Value;
      cdsFaixas.FieldByName('TSN_ALQISS').AsFloat   := edtIss.Value;
      cdsFaixas.FieldByName('TSN_IDXFXA').AsInteger := intIdxFxa;
      cdsFaixas.FieldByName('TSN_ALQCBS').AsFloat   := edtCBS.Value;
      cdsFaixas.FieldByName('TSN_ALQIBS').AsFloat   := edtIBS.Value;

      cdsFaixas.Post();

      Result := True;

      pLimparTela();
      pSetFocus(edtLimInf);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCadTabelaFaixasSimplesNacional.fAdicionarFaixa]');
  End;
end;

procedure TfrmCadTabelaFaixasSimplesNacional.pAtualizarComponentes(blnEnabled: Boolean);
begin
  cmbTipTab.Enabled := blnEnabled;
  mskIniVig.Enabled := blnEnabled;
  mskFimVig.Enabled := blnEnabled;
end;

function TfrmCadTabelaFaixasSimplesNacional.fAtualizarPanelFaixas: Boolean;
begin
  Result := False;

  If (pnlDadosFaixas.Enabled) And (Not cdsFaixas.IsEmpty) Then Begin
    If (fMensagem('ATENÇÃO!', 'Deseja editar o registro?', ['&Sim','&Não'], 2) = 2) Then
      Exit;

    edtLimInf.Value := cdsFaixas.FieldByName('TSN_LIMINF').AsFloat;
    edtLimSup.Value := cdsFaixas.FieldByName('TSN_LIMSUP').AsFloat;
    edtAliquo.Value := cdsFaixas.FieldByName('TSN_ALIQUO').AsFloat;
    edtIrpj.Value   := cdsFaixas.FieldByName('TSN_ALIRPJ').AsFloat;
    edtCsll.Value   := cdsFaixas.FieldByName('TSN_ALCSLL').AsFloat;
    edtCofins.Value := cdsFaixas.FieldByName('TSN_ALQCOF').AsFloat;
    edtPis.Value    := cdsFaixas.FieldByName('TSN_ALQPIS').AsFloat;
    edtIcms.Value   := cdsFaixas.FieldByName('TSN_ALQICM').AsFloat;
    edtIpi.Value    := cdsFaixas.FieldByName('TSN_ALQIPI').AsFloat;
    edtVlrDes.Value := cdsFaixas.FieldByName('TSN_VLRDES').AsFloat;
    edtCpp.Value    := cdsFaixas.FieldByName('TSN_ALQCPP').AsFloat;
    edtIss.Value    := cdsFaixas.FieldByName('TSN_ALQISS').AsFloat;
    edtCBS.Value    := cdsFaixas.FieldByName('TSN_ALQCBS').AsFloat;
    edtIBS.Value    := cdsFaixas.FieldByName('TSN_ALQIBS').AsFloat;

    grdFaixas.Enabled := False;

    pSetFocus(edtLimInf);

    Result := True;
  End;
end;

procedure TfrmCadTabelaFaixasSimplesNacional.pCarregarFaixasCadastro(
  strAutoincrem: String);
  Var
    i: Integer;
    qryTemp: TUniQuery;

  procedure pBuscarFaixas; begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := 'SELECT * FROM TSNFXA WHERE TSN_SEQTSN = :AUTINC ORDER BY TSN_IDXFXA';
    qryTemp.ParamByName('AUTINC').AsString := strAutoincrem;
    qryTemp.Open();
    qryTemp.First();
  end;
begin
  Try
    qryTemp := fCriaQuery(Self);

    Try
      cdsFaixas.EmptyDataSet;

      If (Not fEmptyStr(strAutoincrem)) Then Begin
        pBuscarFaixas();

        If (Not qryTemp.IsEmpty) Then Begin
          For i := 0 To qryTemp.RecordCount - 1 Do Begin
            cdsFaixas.Append();

            cdsFaixas.FieldByName('AUTOINCREM').AsString  := qryTemp.FieldByName('AUTOINCREM').AsString;
            cdsFaixas.FieldByName('TSN_SEQTSN').AsString  := qryTemp.FieldByName('TSN_SEQTSN').AsString;
            cdsFaixas.FieldByName('TSN_IDXFXA').AsInteger := qryTemp.FieldByName('TSN_IDXFXA').AsInteger;
            cdsFaixas.FieldByName('TSN_LIMINF').AsFloat   := qryTemp.FieldByName('TSN_LIMINF').AsFloat;
            cdsFaixas.FieldByName('TSN_LIMSUP').AsFloat   := qryTemp.FieldByName('TSN_LIMSUP').AsFloat;
            cdsFaixas.FieldByName('TSN_ALIQUO').AsFloat   := qryTemp.FieldByName('TSN_ALIQUO').AsFloat;
            cdsFaixas.FieldByName('TSN_ALIRPJ').AsFloat   := qryTemp.FieldByName('TSN_ALIRPJ').AsFloat;
            cdsFaixas.FieldByName('TSN_ALCSLL').AsFloat   := qryTemp.FieldByName('TSN_ALCSLL').AsFloat;
            cdsFaixas.FieldByName('TSN_ALQCOF').AsFloat   := qryTemp.FieldByName('TSN_ALQCOF').AsFloat;
            cdsFaixas.FieldByName('TSN_ALQPIS').AsFloat   := qryTemp.FieldByName('TSN_ALQPIS').AsFloat;
            cdsFaixas.FieldByName('TSN_ALQCPP').AsFloat   := qryTemp.FieldByName('TSN_ALQCPP').AsFloat;
            cdsFaixas.FieldByName('TSN_ALQISS').AsFloat   := qryTemp.FieldByName('TSN_ALQISS').AsFloat;
            cdsFaixas.FieldByName('TSN_ALQICM').AsFloat   := qryTemp.FieldByName('TSN_ALQICM').AsFloat;
            cdsFaixas.FieldByName('TSN_ALQCBS').AsFloat   := qryTemp.FieldByName('TSN_ALQCBS').AsFloat;
            cdsFaixas.FieldByName('TSN_ALQIBS').AsFloat   := qryTemp.FieldByName('TSN_ALQIBS').AsFloat;
            cdsFaixas.FieldByName('TSN_ALQIPI').AsFloat   := qryTemp.FieldByName('TSN_ALQIPI').AsFloat;
            cdsFaixas.FieldByName('TSN_VLRDES').AsFloat   := qryTemp.FieldByName('TSN_VLRDES').AsFloat;
            cdsFaixas.Post();

            qryTemp.Next();
          End;
        End;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmCadTabelaFaixasSimplesNacional.pCarregarFaixasCadastro]');
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

procedure TfrmCadTabelaFaixasSimplesNacional.pCriarClientDatasetFaixas;
begin
  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_SEQTSN';
    DataType := ftString;
    Size     := 20;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'AUTOINCREM';
    DataType := ftString;
    Size     := 20;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_IDXFXA';
    DataType := ftInteger;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_LIMINF';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_LIMSUP';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALIQUO';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALIRPJ';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALCSLL';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQCOF';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQPIS';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQCPP';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQISS';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQICM';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQIPI';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_VLRDES';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQCBS';
    DataType := ftFloat;
  End;

  With cdsFaixas.FieldDefs.AddFieldDef Do Begin
    Name     := 'TSN_ALQIBS';
    DataType := ftFloat;
  End;

  cdsFaixas.CreateDataSet;

  TFloatField(cdsFaixas.FieldByName('TSN_LIMINF')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_LIMSUP')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALIQUO')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALIRPJ')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALCSLL')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALQCOF')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALQPIS')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALQCPP')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALQISS')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALQICM')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALQIPI')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_VLRDES')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALQCBS')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsFaixas.FieldByName('TSN_ALQIBS')).DisplayFormat := fMskDigitos(2);
end;

function TfrmCadTabelaFaixasSimplesNacional.fEditarFaixa: Boolean;
begin
  Result := False;

  Try
    If (fValidaDadosFaixa()) Then Begin
      cdsFaixas.Edit();
      cdsFaixas.FieldByName('TSN_LIMINF').AsFloat   := edtLimInf.Value;
      cdsFaixas.FieldByName('TSN_LIMSUP').AsFloat   := edtLimSup.Value;
      cdsFaixas.FieldByName('TSN_ALIQUO').AsFloat   := edtAliquo.Value;
      cdsFaixas.FieldByName('TSN_ALIRPJ').AsFloat   := edtIrpj.Value;
      cdsFaixas.FieldByName('TSN_ALCSLL').AsFloat   := edtCsll.Value;
      cdsFaixas.FieldByName('TSN_ALQCOF').AsFloat   := edtCofins.Value;
      cdsFaixas.FieldByName('TSN_ALQPIS').AsFloat   := edtPis.Value;
      cdsFaixas.FieldByName('TSN_ALQICM').AsFloat   := edtIcms.Value;
      cdsFaixas.FieldByName('TSN_ALQIPI').AsFloat   := edtIpi.Value;
      cdsFaixas.FieldByName('TSN_VLRDES').AsFloat   := edtVlrDes.Value;
      cdsFaixas.FieldByName('TSN_ALQCPP').AsFloat   := edtCpp.Value;
      cdsFaixas.FieldByName('TSN_ALQISS').AsFloat   := edtIss.Value;
      cdsFaixas.FieldByName('TSN_ALQCBS').AsFloat   := edtCBS.Value;
      cdsFaixas.FieldByName('TSN_ALQIBS').AsFloat   := edtIBS.Value;

      cdsFaixas.Post();

      Result := True;

      pLimparTela();
      pSetFocus(edtLimInf);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCadTabelaFaixasSimplesNacional.fEditarFaixa]');
  End;
end;

procedure TfrmCadTabelaFaixasSimplesNacional.pHabilitarBotoesFaixas(
  operacao: TTipoOperacao);
begin
  //toIncluir, toAlterar, toCancelar, toRemover, toConfirmar, toNeutro
  btnAdicionar.Enabled := (operacao in [toCancelar, toRemover, toConfirmar, toNeutro]);
  btnConfirmar.Enabled := (operacao in [toIncluir, toAlterar]);
  btnEditar.Enabled    := (operacao in [toCancelar, toRemover, toConfirmar, toNeutro]);
  btnCancelar.Enabled  := (operacao in [toIncluir, toAlterar]);
  btnRemover.Enabled   := (operacao in [toCancelar, toRemover, toConfirmar, toNeutro]);

  toOperAtual := operacao;

  pHabilitarCamposFaixas(operacao in [toIncluir, toAlterar]);

  pnlDadosFaixas.Enabled := True;
end;

procedure TfrmCadTabelaFaixasSimplesNacional.pHabilitarCamposFaixas(
  blnEnabled: Boolean);
begin
  edtLimInf.Enabled := blnEnabled;
  edtLimSup.Enabled := blnEnabled;
  edtAliquo.Enabled := blnEnabled;
  edtIrpj.Enabled   := blnEnabled;
  edtCsll.Enabled   := blnEnabled;
  edtPis.Enabled    := blnEnabled;
  edtCofins.Enabled := blnEnabled;
  edtCpp.Enabled    := blnEnabled;
  edtIBS.Enabled    := blnEnabled;
  edtCBS.Enabled    := blnEnabled;
  edtIss.Enabled    := blnEnabled And (cmbTipTab.ItemIndex <> 0) And (cmbTipTab.ItemIndex <> 1);
  edtIcms.Enabled   := blnEnabled;
  edtIpi.Enabled    := blnEnabled And ((cmbTipTab.ItemIndex = 1) Or (cmbTipTab.ItemIndex = 4));
  edtVlrDes.Enabled := blnEnabled;
  btnCalcLimInf.Enabled  := blnEnabled;
end;

procedure TfrmCadTabelaFaixasSimplesNacional.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('TSN_CODIGO');
  stlCampos.Add('TSN_DESCRI');
  stlCampos.Add('TSN_TIPTAB');
  stlCampos.Add('TSN_CODEMP');
  stlCampos.Add('TSN_CODOPE');
  stlCampos.Add('TSN_INIVIG');
  stlCampos.Add('AUTOINCREM');
  stlCampos.Add('TSN_REGIME');
  stlCampos.Add('TSN_FIMVIG');

  stlCamInd.Add('TSN_DESCRI');
  stlCamInd.Add('TSN_CODIGO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadTabelaFaixasSimplesNacional.pLimparTela;
begin
  edtLimInf.Value := 0;
  edtLimSup.Value := 0;
  edtAliquo.Value := 0;
  edtIrpj.Value   := 0;
  edtCsll.Value   := 0;
  edtCpp.Value    := 0;
  edtCofins.Value := 0;
  edtPis.Value    := 0;
  edtIss.Value    := 0;
  edtIcms.Value   := 0;
  edtIpi.Value    := 0;
  edtVlrDes.Value := 0;
  edtIBS.Value    := 0;
  edtCBS.Value    := 0;
end;

procedure TfrmCadTabelaFaixasSimplesNacional.pRemoverFaixa;
  Var
    strAutInc: String;
begin
  Try
    If (Not cdsFaixas.IsEmpty) Then Begin
      strAutInc := cdsFaixas.FieldByName('AUTOINCREM').AsString;

      cdsFaixas.Next();

      While (Not cdsFaixas.Eof) Do Begin
        cdsFaixas.Edit();
        cdsFaixas.FieldByName('TSN_IDXFXA').AsInteger := cdsFaixas.FieldByName('TSN_IDXFXA').AsInteger - 1;
        cdsFaixas.Next();
      End;

      cdsFaixas.First();

      While (Not cdsFaixas.Eof) Do Begin
        If (strAutInc = cdsFaixas.FieldByName('AUTOINCREM').AsString) Then Begin
          cdsFaixas.Delete();
          Break;
        End;

        cdsFaixas.Next();
      End;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCadTabelaFaixasSimplesNacional.fEditarFaixa]');
  End;
end;

procedure TfrmCadTabelaFaixasSimplesNacional.pVerificarTipoTabela;
begin
  If (cmbTipTab.ItemIndex = 4) Then Begin
    lblIrpj.Caption   := '(r) < 0,10';
    lblCsll.Caption   := '0,10 <= (r) < 0,15';
    lblCpp.Caption    := '0,15 <= (r) < 0,20';
    lblCofins.Caption := '0,20 <= (r) < 0,25';
    lblPis.Caption    := '0,25 <= (r) < 0,30';
    lblIss.Caption    := '0,30 <= (r) < 0,35';
    lblIcms.Caption   := '0,35 <= (r) < 0,40';
    lblIpi.Caption    := '(r) >= 0,40';

    grdFaixasTSN_ALIRPJ.Caption := '(r) < 0,10';
    grdFaixasTSN_ALCSLL.Caption := '0,10 <= (r) < 0,15';
    grdFaixasTSN_ALQCOF.Caption := '0,15 <= (r) < 0,20';
    grdFaixasTSN_ALQPIS.Caption := '0,20 <= (r) < 0,25';
    grdFaixasTSN_ALQCPP.Caption := '0,25 <= (r) < 0,30';
    grdFaixasTSN_ALQISS.Caption := '0,30 <= (r) < 0,35';
    grdFaixasTSN_ALQICM.Caption := '0,35 <= (r) < 0,40';
    grdFaixasTSN_ALQIPI.Caption := '(r) <= 0,40';
    grdFaixasTSN_ALIQUO.Visible := False;

    lblRelacaoR.Visible := True;
    lblLegenda.Visible  := True;
  End Else Begin
    lblLimInf.Caption := 'Lim. Inferior';
    lblLimSup.Caption := 'Lim. Superior';
    lblAliquo.Caption := 'Alíq. Simples Nacional:';
    lblIrpj.Caption   := 'Alíquota IRPJ';
    lblCsll.Caption   := 'Alíquota CSLL';
    lblCpp.Caption    := 'Alíquota CPP';
    lblCofins.Caption := 'Alíquota COFINS';
    lblPis.Caption    := 'Alíquota PIS';
    lblIss.Caption    := 'Alíquota ISS';
    lblIcms.Caption   := 'Alíquota ICMS';
    lblIpi.Caption    := 'Alíquota IPI';

    grdFaixasTSN_LIMINF.Caption := 'Lim. Inferior (R$)';
    grdFaixasTSN_LIMSUP.Caption := 'Lim. Superior (R$)';
    grdFaixasTSN_ALIQUO.Caption := '% Alíquota';
    grdFaixasTSN_ALIRPJ.Caption := '% IRPJ';
    grdFaixasTSN_ALCSLL.Caption := '% CSLL';
    grdFaixasTSN_ALQCOF.Caption := '% COFINS';
    grdFaixasTSN_ALQPIS.Caption := '% PIS';
    grdFaixasTSN_ALQCPP.Caption := '% CPP';
    grdFaixasTSN_ALQISS.Caption := '% ISS';
    grdFaixasTSN_ALQICM.Caption := '% ICMS';
    grdFaixasTSN_ALQIPI.Caption := '% IPI';
    grdFaixasTSN_ALIQUO.Visible := True;

    lblRelacaoR.Visible := False;
    lblLegenda.Visible  := False;
  End;

  grdFaixasTableView1.ApplyBestFit();
end;

end.
