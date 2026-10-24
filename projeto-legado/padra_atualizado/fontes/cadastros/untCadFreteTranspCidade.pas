unit untCadFreteTranspCidade;

interface

uses
  Windows, Classes, Controls, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, EditFocus, Mask, DBCtrls, DBEditFocus, Uni, DB, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, QColorLabel, untCadRapidoFreteTranspCidade,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxButtons, System.SysUtils,
  untZClient;

type
  TfrmCadFreteTranspCidade = class(TfrmPaiCad)
    pnlGeral: TPanel;
    dtsFreTra: TDataSource;
    pnlTomador: TPanel;
    Label37: TLabel;
    ColorLabel1: TColorLabel;
    dbeTomado: TDBEditFocus;
    pnlValIse: TPanel;
    lblValIse: TLabel;
    dbeValIse: TDBEditFocus;
    pnlTransp: TPanel;
    Label31: TLabel;
    Label7: TLabel;
    Label20: TLabel;
    dbeCodTra: TDBEditFocus;
    edtNomTra: TEditFocus;
    dbeCodCid: TDBEditFocus;
    edtCidade: TEditFocus;
    edtEstado: TEditFocus;
    pnlCalculoFrete: TPanel;
    gpbCalculoFrete: TGroupBox;
    pnlCalFre1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    lblValorKilo: TLabel;
    dbeMinFre: TDBEditFocus;
    dbePerTot: TDBEditFocus;
    dbeValKil: TDBEditFocus;
    pnlCobVal: TPanel;
    Label10: TLabel;
    dbeCobVal: TDBEditFocus;
    pnlCalFre2: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    dbePd100K: TDBEditFocus;
    dbeMinGri: TDBEditFocus;
    dbePerGri: TDBEditFocus;
    dbeValTas: TDBEditFocus;
    btnCadRapTra: TBitBtnLocked;
    btnCadRapCid: TBitBtnLocked;
    pnlAliquo: TPanel;
    Label11: TLabel;
    dbeAliquo: TDBEditFocus;
    btnImportacao: TBitBtnLocked;
    btnFaixaFatDesc: TBitBtnLocked;
    btnHlpImp: TBitBtnLocked;
    popImportarExcel: TPopupMenu;
    mnuImportCadFreteTranspCidade: TMenuItem;
    mnuImportCadFreteTranspCidadeFaixa: TMenuItem;
    frxHelp: TfrxReport;
    pnlFreReg: TPanel;
    Label26: TLabel;
    dbeFreReg: TDBEditFocus;
    edtNomReg: TEditFocus;
    Label1: TLabel;
    dbeMinNfi: TDBEditFocus;
    btnFaixasPeso: TBitBtnLocked;
    mnuImportCadFreteTranspCidadeFaixasPeso: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCadRapTraClick(Sender: TObject);
    procedure btnCadRapCidClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
    procedure btnImportacaoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnFaixaFatDescClick(Sender: TObject);
    procedure mnuImportCadFreteTranspCidadeClick(Sender: TObject);
    procedure mnuImportCadFreteTranspCidadeFaixaClick(Sender: TObject);
    procedure dbeFreRegKeyPress(Sender: TObject; var Key: Char);
    procedure btnFaixasPesoClick(Sender: TObject);
    procedure mnuImportCadFreteTranspCidadeFaixasPesoClick(Sender: TObject);
  private
    { Private declarations }
    cdsFreFai: TZClient;
    cdsFreFxp: TZClient;

    procedure pAfterOpen(DataSet: TDataSet);
    procedure pLimparCamposCadastro;
    procedure pCarregaCidade;
    procedure pGravaFaixas;
    procedure pGravaFaixasPeso;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

implementation

uses Forms, untConsultas, untFuncoesSimples, untTypesSistema, System.StrUtils,
  untImportCadFreteTranspCidade, untCadFreteTranspCidadeFaixas,
  untImportCadFreteTranspCidadeFaixa, untCadFreteTranspCidadeFaixasPeso,
  untImportCadFreteTranspCidadeFaixasPeso;


{$R *.dfm}

procedure TfrmCadFreteTranspCidade.btnAlterarClick(Sender: TObject);
begin
  pLimparCamposCadastro;

  inherited;
  If blnAlterou Then
  Begin
    dbeCodTra.ReadOnly := True;
    dbeCodCid.ReadOnly := True;
    pSetFocus(dbeValIse);
  End;
end;

procedure TfrmCadFreteTranspCidade.btnCadRapCidClick(Sender: TObject);
begin
  inherited;
  If TfrmCadRapidoFreteTranspCidade.fCadRapidoTraCid('C') Then
    fMensagem('ATENÇÃO!', 'Cadastro(s) de frete(s) alterado(s) com sucesso!', ['&Ok']);
end;

procedure TfrmCadFreteTranspCidade.btnCadRapTraClick(Sender: TObject);
begin
  inherited;
  If TfrmCadRapidoFreteTranspCidade.fCadRapidoTraCid('T') Then
    fMensagem('ATENÇÃO!', 'Cadastro(s) de frete(s) alterado(s) com sucesso!', ['&Ok']);
end;

procedure TfrmCadFreteTranspCidade.btnCancelaClick(Sender: TObject);
begin
  inherited;
  dbeCodTra.ReadOnly := False;
  dbeCodCid.ReadOnly := False;

  edtNomTra.Text := fRetNomTransportadora(dbeCodTra.Text);
  pCarregaCidade;
end;

procedure TfrmCadFreteTranspCidade.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFreteTranspCidade.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pLimparCamposCadastro;
end;

procedure TfrmCadFreteTranspCidade.btnFaixaFatDescClick(Sender: TObject);
  Var
    frmCadFreteTranspCidadeFaixas: TfrmCadFreteTranspCidadeFaixas;
begin
  inherited;
  If Not btnFaixaFatDesc.Visible Then
    Exit;

  If qryTabela.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If qryTabela.State = dsBrowse Then
  Begin
    fMensagem('AVISO', 'É necessário que o registro esteja em modo de Inclusão ou Alteração!', ['&Ok']);
    Exit;
  End;

  cdsFreFai.qryQuery.Close;
  cdsFreFai.qryQuery.ParamByName('SEQFRE').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
  cdsFreFai.fAbreClient(True, 'btnFaixaFatDescClick');

  frmCadFreteTranspCidadeFaixas := TfrmCadFreteTranspCidadeFaixas.Create(Self);
  frmCadFreteTranspCidadeFaixas.dtsFaixas.DataSet := cdsFreFai;
  frmCadFreteTranspCidadeFaixas.ShowModal;
  pFreeAndNil(frmCadFreteTranspCidadeFaixas);
end;

procedure TfrmCadFreteTranspCidade.btnFaixasPesoClick(Sender: TObject);
Var
  frmCadFreteTranspCidadeFaixasPeso: TfrmCadFreteTranspCidadeFaixasPeso;
begin
  inherited;
  If Not btnFaixasPeso.Visible Then
    Exit;

  If qryTabela.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If qryTabela.State = dsBrowse Then
  Begin
    fMensagem('AVISO', 'É necessário que o registro esteja em modo de Inclusão ou Alteração!', ['&Ok']);
    Exit;
  End;

  If (Not cdsFreFxp.Active) Or
     (cdsFreFxp.RecordCount = 0) Then
  Begin
    cdsFreFxp.qryQuery.Close;
    cdsFreFxp.qryQuery.ParamByName('SEQFRE').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    cdsFreFxp.fAbreClient(True, 'btnFaixasPeso')
  End;

  frmCadFreteTranspCidadeFaixasPeso := TfrmCadFreteTranspCidadeFaixasPeso.Create(Self);
  frmCadFreteTranspCidadeFaixasPeso.dtsFaixas.DataSet    := cdsFreFxp;
  frmCadFreteTranspCidadeFaixasPeso.dbeValKil.DataSource := dtsFreTra;
  frmCadFreteTranspCidadeFaixasPeso.ShowModal;
  pFreeAndNil(frmCadFreteTranspCidadeFaixasPeso);
end;

procedure TfrmCadFreteTranspCidade.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  Try
    inherited;

    If blnGravou Then
    Begin
      pGravaFaixas;

      If fCfgSis('FREFXP', varBoolean) Then
        pGravaFaixasPeso;

      fCommit
    End
    Else
      fRollBack;

    dbeCodTra.ReadOnly := False;
    dbeCodCid.ReadOnly := False;

  Except
    On E: Exception Do
    Begin
      fRollback;
      pMensagensErro(E.Message, '[TfrmCadFreteTranspCidade.btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadFreteTranspCidade.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmCadFreteTranspCidade.btnImportacaoClick(Sender: TObject);
var
  pt : TPoint;
begin
  inherited;
  pt.x := Self.Left + pnlBotoes.Left + TButton(Sender).Left + 1;
  pt.y := Self.Top + Self.Height - (TButton(Sender).Top + TButton(Sender).Height + 55);
  popImportarExcel.popup( pt.x, pt.y );
end;

procedure TfrmCadFreteTranspCidade.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeCodTra);
  pLimparCamposCadastro;
end;

procedure TfrmCadFreteTranspCidade.pLimparCamposCadastro;
begin
  edtNomTra.Clear;
  edtCidade.Clear;
  edtEstado.Clear;

  If cdsFreFxp.Active Then
    cdsFreFxp.EmptyDataSet;
end;

procedure TfrmCadFreteTranspCidade.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
begin
  inherited;
  chrKey := '/';
  If fPesqFreteTransportadora(Self, dbeCodTra, dbeCodCid, qryTabela, chrKey) Then
  Begin
    edtNomTra.Text := fRetNomTransportadora(dbeCodTra.Text);
    edtNomReg.Text := fRetNomFreteRegiao(dbeFreReg.Text);
    pCarregaCidade;
  End;
end;

procedure TfrmCadFreteTranspCidade.dbeCodCidKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, dbeCodCid, edtCidade, edtEstado, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(dbeCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFreteTranspCidade.dbeCodTraKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTransp: TConsultasArray;
begin
  inherited;
  {************************************}
  {* NOVA CONSULTA DE TRANSPORTADORAS *}
  {*********************************RV*}
  If fPesqTransportadora(conTraSimples, Self, dbeCodTra, edtNomTra, Nil, Key, arrTransp) Then
  Begin
    If fValidaCampos(dbeCodTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFreteTranspCidade.dbeFreRegKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFreteRegiao(Self, dbeFreReg, edtNomReg, Nil, Key) Then
    If fValidaCampos(dbeFreReg, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadFreteTranspCidade.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela := fCriaQuery(Self);
  strNomeTabela := 'FRETRA';
  dtsFreTra.DataSet := qryTabela;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodTra;
  arrCamposChave[1] := dbeCodCid;

  strNomeCampo := 'AUTOINCREM';
  blnUsaProCodigo := False;
  qryTabela.AfterOpen := pAfterOpen;

  cdsFreFai := TZClient.Create(Self, 'SELECT * FROM FREFAI WHERE FAI_SEQFRE = :SEQFRE');
  cdsFreFai.IndexFieldNames := 'FAI_FATINI';

  cdsFreFxp := TZClient.Create(Self, 'SELECT * FROM FREFXP WHERE FAI_SEQFRE = :SEQFRE');
  cdsFreFxp.IndexFieldNames := 'FAI_PESINI';

  {*REQ.159829**********RP*}
  pnlValIse.Visible       := fCfgSis('ISETRC') = '1';
  btnFaixaFatDesc.Visible := Not pnlValIse.Visible;

  mnuImportCadFreteTranspCidadeFaixa.Visible := Not pnlValIse.Visible;

  if not fCfgSis('UTICTE', varBoolean) then
  begin
    pnlTomador.Visible := False;
    pnlCobVal.Visible  := False;
    pnlAliquo.Visible  := False;

    gpbCalculoFrete.Height := gpbCalculoFrete.Height - pnlCobVal.Height;
    Self.Height := Self.Height - pnlTomador.Height - pnlCobVal.Height - pnlAliquo.Height;
  end;

  if not fCfgSis('FREREG', varBoolean) then
  begin
    pnlFreReg.Visible := False;

    Self.Height := Self.Height - pnlFreReg.Height;
  end;

  If fCfgSis('FREFXP', varBoolean) Then
  Begin
    lblValorKilo.Visible := False;
    dbeValKil.Visible    := False;
    btnFaixasPeso.Left   := dbeValKil.Left;
    pnlCobVal.Visible    := False;
  End
  Else
  Begin
    btnFaixasPeso.Enabled := False;
    btnFaixasPeso.Visible := False;

    mnuImportCadFreteTranspCidadeFaixasPeso.Visible := False;
  End;
end;

procedure TfrmCadFreteTranspCidade.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F2: btnFaixaFatDesc.Click;
  End;
end;

function TfrmCadFreteTranspCidade.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = dbeCodTra) Then
  Begin
    If fEmptyStr(dbeCodTra.Text) Then
    Begin
      Result := False;
      edtNomTra.Clear;
    End
    Else
    Begin
      edtNomTra.Text := fRetNomTransportadora(dbeCodTra.Text);
      If fEmptyStr(edtNomTra.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa transportadora não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End;
  End
  Else If (Sender = dbeCodCid) Then
  Begin
    If fEmptyStr(dbeCodCid.Text) Then
    Begin
      Result := False;
      edtCidade.Clear;
      edtEstado.Clear;
    End
    Else
    Begin
      pCarregaCidade;
      If (fEmptyStr(edtCidade.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;

        edtNomTra.Text := fRetNomTransportadora(dbeCodTra.Text);
        pCarregaCidade;

      End;
    End;
  End
  Else If (Sender = dbeValIse) Or
          (Sender = dbeMinFre) Or
          (Sender = dbePerTot) Or
          (Sender = dbeValKil) Or
          (Sender = dbePd100K) Or
          (Sender = dbePerGri) Or
          (Sender = dbeMinGri) Or
          (Sender = dbeValTas) Or
          ((Sender = dbeAliquo) And (pnlAliquo.Visible)) Or
          ((Sender = dbeCobVal) And (pnlCobVal.Visible)) Then
  Begin
    If fEmptyStr((Sender As TCustomEdit).Text) Then
    Begin
      (Sender As TCustomEdit).Text := '0,00';
    End
    Else If fStrToFloat((Sender As TCustomEdit).Text) < 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Todos os valores devem ser maior ou igual a Zero.', ['&Ok']);
      Result := False;
    End;
  End
  Else If (Sender = dbeTomado) and (pnlTomador.Visible) Then
  Begin
    If fEmptyStr(dbeTomado.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Frete por Conta do deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (not AnsiMatchStr(dbeTomado.Text, ['E', 'D'])) Then
      Result := False;
  End
  Else If (Sender = dbeFreReg) and pnlFreReg.Visible Then
  Begin
    If fEmptyStr(dbeFreReg.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Frete Região deve ser preenchido!', ['&Ok']);
      Result := False;
      dbeFreReg.Clear;
      edtNomReg.Clear;
    End
    Else
    Begin
      edtNomReg.Text := fRetNomFreteRegiao(dbeFreReg.Text);
      If (fEmptyStr(edtNomReg.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Frete Região não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadFreteTranspCidade.mnuImportCadFreteTranspCidadeClick(
  Sender: TObject);
begin
  inherited;
  pCriarFormularios(TFrmImportCadFreteTranspCidade, FrmImportCadFreteTranspCidade);
  FrmImportCadFreteTranspCidade.ShowModal;
  pFreeAndNil(FrmImportCadFreteTranspCidade);
end;

procedure TfrmCadFreteTranspCidade.mnuImportCadFreteTranspCidadeFaixaClick(
  Sender: TObject);
begin
  inherited;
  if Not mnuImportCadFreteTranspCidadeFaixa.Visible then
    Exit;

  pCriarForm(TFrmImportCadFreteTranspCidadeFaixa);
end;

procedure TfrmCadFreteTranspCidade.mnuImportCadFreteTranspCidadeFaixasPesoClick(
  Sender: TObject);
begin
  inherited;
  if Not mnuImportCadFreteTranspCidadeFaixasPeso.Visible then
    Exit;

  pCriarForm(TFrmImportCadFreteTranspCidadeFaixasPeso);
end;

procedure TfrmCadFreteTranspCidade.pCarregaCidade;
begin
  edtCidade.Text := fRetNomCidade(dbeCodCid.Text);
  edtEstado.Text := fRetNomCidade(dbeCodCid.Text, 1);
end;

procedure TfrmCadFreteTranspCidade.pGravaFaixas;
begin
  If Not cdsFreFai.Active Then
    Exit;

  cdsFreFai.DisableControls;
  Try
    cdsFreFai.First;
    While Not cdsFreFai.Eof Do
    Begin
      cdsFreFai.Edit;
      If fEmptyStr(cdsFreFai.FieldByName('AUTOINCREM').AsString) Then
        cdsFreFai.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FREFAI', VS_strCodEmp);
      If fEmptyStr(cdsFreFai.FieldByName('FAI_SEQFRE').AsString) Then
        cdsFreFai.FieldByName('FAI_SEQFRE').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      cdsFreFai.Post;

      cdsFreFai.Next;
    End;

    If cdsFreFai.ChangeCount > 0 Then
      cdsFreFai.ApplyUpdates(0);
  Finally
    cdsFreFai.EnableControls;
  End;
end;

procedure TfrmCadFreteTranspCidade.pGravaFaixasPeso;
begin
  If Not cdsFreFxp.Active Then
    Exit;

  cdsFreFxp.DisableControls;
  Try
    cdsFreFxp.First;
    While Not cdsFreFxp.Eof Do
    Begin
      If fEmptyStr(cdsFreFxp.FieldByName('AUTOINCREM').AsString) Then
      Begin
        cdsFreFxp.Edit;
        cdsFreFxp.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FREFXP', VS_strCodEmp);
        cdsFreFxp.FieldByName('FAI_SEQFRE').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
        cdsFreFxp.Post;
      End;

      cdsFreFxp.Next;
    End;

    If cdsFreFxp.ChangeCount > 0 Then
      cdsFreFxp.ApplyUpdates(0);
  Finally
    cdsFreFxp.EnableControls;
  End;
end;

procedure TfrmCadFreteTranspCidade.pAfterOpen(DataSet: TDataSet);
begin
  TFloatField(DataSet.FieldByName('FRE_VALISE')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('FRE_MINFRE')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('FRE_PERTOT')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('FRE_VALKIL')).DisplayFormat := '#,##0.0000';
  TFloatField(DataSet.FieldByName('FRE_PD100K')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('FRE_PERGRI')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('FRE_MINGRI')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('FRE_VALTAS')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('FRE_COBVAL')).DisplayFormat := '#,##0.000';
  TFloatField(DataSet.FieldByName('FRE_ALIQUO')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('FRE_MINNFI')).DisplayFormat := '#,##0.00';
end;

procedure TfrmCadFreteTranspCidade.pInicializaIndices;
begin
  inherited;
  //
end;

end.

