unit untRcxTransfLancamentosEntreCaixas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  EditFocus, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxImageComboBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid,
  cxCurrencyEdit, Uni, UniClientDataset, cxProgressBar, strUtils;

type
  TfrmRcxTransfLancamentosEntreCaixas = class(TfrmPai)
    pnlCabecalho: TPanel;
    pnlDados: TPanel;
    Label2: TLabel;
    edtDataLancamentos: TcxDateEdit;
    Label1: TLabel;
    edtCodigoCaixa: TEditFocus;
    edtDescricaoCaixa: TEditFocus;
    Label3: TLabel;
    edtCodigoOperador: TEditFocus;
    edtNomeOperador: TEditFocus;
    btnCarregarLancamentos: TBitBtnLocked;
    pnlTotais: TPanel;
    grdLancamentos: TcxGridCitel;
    grdLancamentosDados: TcxGridDBTableViewCitel;
    grdLancamentosNivel: TcxGridLevel;
    Label6: TLabel;
    edtQtdLancamentos: TEditFocus;
    edtValorLancamentos: TEditFocus;
    Label9: TLabel;
    edtQtdSelecionados: TEditFocus;
    edtLancamentosSel: TEditFocus;
    BtnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    grdLancamentosDadosDOCUMENTO: TcxGridDBColumn;
    grdLancamentosDadosRCX_DESCRI: TcxGridDBColumn;
    grdLancamentosDadosRCX_VALDOC: TcxGridDBColumn;
    grdLancamentosDadosRCX_DINREC: TcxGridDBColumn;
    grdLancamentosDadosRCX_CARREC: TcxGridDBColumn;
    grdLancamentosDadosRCX_CHQAVI: TcxGridDBColumn;
    grdLancamentosDadosRCX_CHQPRE: TcxGridDBColumn;
    grdLancamentosDadosRCX_ORDREC: TcxGridDBColumn;
    grdLancamentosDadosRCX_MARDES: TcxGridDBColumn;
    Label4: TLabel;
    Label5: TLabel;
    edtDinheiro: TEditFocus;
    edtDinheiroSel: TEditFocus;
    Label7: TLabel;
    edtCartao: TEditFocus;
    edtCartaoSel: TEditFocus;
    Label8: TLabel;
    edtChequeAVista: TEditFocus;
    edtChequeAVistaSel: TEditFocus;
    Label10: TLabel;
    edtChequePre: TEditFocus;
    edtChequePreSel: TEditFocus;
    Label11: TLabel;
    edtOrdemRecebimento: TEditFocus;
    edtOrdemRecebimentoSel: TEditFocus;
    Label12: TLabel;
    grdLancamentosDadosRCX_SEQCON: TcxGridDBColumn;
    procedure btnCarregarLancamentosClick(Sender: TObject);
    procedure edtCodigoCaixaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure grdLancamentosDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnMarcarTodosClick(Sender: TObject);
    procedure grdLancamentosDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
  private
    cdsLancamentos: TUniClientDataset;

    procedure pCarregaOperador;
    procedure pCarregaCaixa;

    procedure pCriaTemporaria;
    procedure pCriaAggregateFields;
    procedure pExibeTotalLancamentos;
    procedure pLimparDados;

    procedure pSelecionarLancamentos(blnTodosLancamentos: Boolean = False; blnDesmarcar: Boolean = False);

    function fMarcarLancamentos(prgStatus: TcxProgressBar): Boolean;
    function fDesmarcarLancamentos(prgStatus: TcxProgressBar): Boolean;

    function fTransferirLancamentos(prgStatus: TcxProgressBar): Boolean;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    { Protected declarations }
  public
    { Public declarations }

  end;

implementation
Uses untFuncoesSimples, untConsultas, untTypesSistema, untGravando, untRcxSelecionaCaixa;

{$R *.dfm}

{ TfrmRcxTransfLancamentosEntreCaixas }

procedure TfrmRcxTransfLancamentosEntreCaixas.btnCarregarLancamentosClick(
  Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  TfrmGravando.fExecutarModal(pCriaTemporaria, 'Aguarde... Consultando lançamentos.', '');

  If cdsLancamentos.IsEmpty Then
    fMensagem('AVISO', 'Nenhum lançamento encontrado.', ['&OK']);
end;

procedure TfrmRcxTransfLancamentosEntreCaixas.btnConfirmarClick(
  Sender: TObject);
  Var
    frmGravando: TfrmGravando;
begin
  inherited;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Aguarde... Transferindo lançamentos.';
    frmGravando.pgbStatus.Visible   := False;
    frmGravando.fExecutarAcao       := fTransferirLancamentos;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

procedure TfrmRcxTransfLancamentosEntreCaixas.btnDesmarcarTodosClick(
  Sender: TObject);
begin
  inherited;
  pSelecionarLancamentos(True, True);
end;

procedure TfrmRcxTransfLancamentosEntreCaixas.BtnMarcarTodosClick(
  Sender: TObject);
begin
  inherited;
  pSelecionarLancamentos(True);
end;

procedure TfrmRcxTransfLancamentosEntreCaixas.edtCodigoCaixaKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrCaixa: TConsultasArray;
begin
  inherited;
  If fPesqCaixas(Self, edtCodigoCaixa, edtDescricaoCaixa, Nil, Key, arrCaixa, True, VS_strCodEmp, True) Then
  Begin
    If fValidaCampos(edtCodigoCaixa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRcxTransfLancamentosEntreCaixas.fDesmarcarLancamentos(
  prgStatus: TcxProgressBar): Boolean;
Var
    strAutoincrem: String;
Begin
  strAutoIncrem := cdsLancamentos.FieldByName('AUTOINCREM').AsString;

  prgStatus.Properties.Max := cdsLancamentos.RecordCount;
  cdsLancamentos.First;
  While Not cdsLancamentos.Eof Do
  Begin
    cdsLancamentos.Edit;

    cdsLancamentos.FieldByName('RCX_MARDES').AsString  := 'D';
    cdsLancamentos.FieldByName('RCX_QTDSEL').AsInteger := 0;
    cdsLancamentos.FieldByName('RCX_DOCSEL').AsFloat   := 0.00;
    cdsLancamentos.FieldByName('RCX_DINSEL').AsFloat   := 0.00;
    cdsLancamentos.FieldByName('RCX_CARSEL').AsFloat   := 0.00;
    cdsLancamentos.FieldByName('RCX_AVISEL').AsFloat   := 0.00;
    cdsLancamentos.FieldByName('RCX_PRESEL').AsFloat   := 0.00;
    cdsLancamentos.FieldByName('RCX_ORDSEL').AsFloat   := 0.00;

    cdsLancamentos.Post;

    cdsLancamentos.Next;

    prgStatus.Position := prgStatus.Position + 1;
  End;

  cdsLancamentos.Filter   := '';
  cdsLancamentos.Filtered := False;

  Result := cdsLancamentos.Locate('AUTOINCREM', strAutoIncrem, []);
end;

function TfrmRcxTransfLancamentosEntreCaixas.fMarcarLancamentos(
  prgStatus: TcxProgressBar): Boolean;
  Var
    strAutoincrem: String;
Begin
  strAutoIncrem := cdsLancamentos.FieldByName('AUTOINCREM').AsString;

  prgStatus.Properties.Max := cdsLancamentos.RecordCount;
  cdsLancamentos.First;
  While Not cdsLancamentos.Eof Do
  Begin
    cdsLancamentos.Edit;

    cdsLancamentos.FieldByName('RCX_MARDES').AsString   := 'M';
    cdsLancamentos.FieldByName('RCX_QTDSEL').AsInteger  := 1;
    cdsLancamentos.FieldByName('RCX_DOCSEL').AsFloat    := fFormataFloat(cdsLancamentos.FieldByName('RCX_VALDOC').AsFloat, 2);
    cdsLancamentos.FieldByName('RCX_DINSEL').AsFloat    := fFormataFloat(cdsLancamentos.FieldByName('RCX_DINREC').AsFloat, 2);
    cdsLancamentos.FieldByName('RCX_CARSEL').AsFloat    := fFormataFloat(cdsLancamentos.FieldByName('RCX_CARREC').AsFloat, 2);
    cdsLancamentos.FieldByName('RCX_AVISEL').AsFloat    := fFormataFloat(cdsLancamentos.FieldByName('RCX_CHQAVI').AsFloat, 2);
    cdsLancamentos.FieldByName('RCX_PRESEL').AsFloat    := fFormataFloat(cdsLancamentos.FieldByName('RCX_CHQPRE').AsFloat, 2);
    cdsLancamentos.FieldByName('RCX_ORDSEL').AsFloat    := fFormataFloat(cdsLancamentos.FieldByName('RCX_ORDREC').AsFloat, 2);
    cdsLancamentos.FieldByName('RCX_GRVSEL').AsDateTime := cdsLancamentos.FieldByName('RCX_DTAGRV').AsDateTime;

    cdsLancamentos.Post;

    cdsLancamentos.Next;

    prgStatus.Position := prgStatus.Position + 1;
  End;

  cdsLancamentos.Filter   := '';
  cdsLancamentos.Filtered := False;

  Result := cdsLancamentos.Locate('AUTOINCREM', strAutoIncrem, []);
end;

procedure TfrmRcxTransfLancamentosEntreCaixas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Assigned(cdsLancamentos) Then
    FreeAndNil(cdsLancamentos);
end;

procedure TfrmRcxTransfLancamentosEntreCaixas.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
    btnSair.Click
  Else If Key = VK_F7 Then
    btnMarcarTodos.Click
  Else If Key = VK_F8 Then
    btnDesmarcarTodos.Click
  Else If Key = VK_F10 Then
    btnConfirmar.Click;
end;

procedure TfrmRcxTransfLancamentosEntreCaixas.FormShow(Sender: TObject);
begin
  inherited;
  cdsLancamentos := TUniClientDataset.Create(Self);
  cdsLancamentos.AggregatesActive := True;
  pCriaAggregateFields;

  pSetFocus(edtCodigoCaixa);
end;

function TfrmRcxTransfLancamentosEntreCaixas.fTransferirLancamentos(prgStatus: TcxProgressBar): Boolean;
  Var
    frmRcxSelecionaCaixa: TfrmRcxSelecionaCaixa;

    strCaixaDestino,
    strLancamentos,
    strCartoes,
    strCheques,
    strValor       : String;
    blnConfirmar   : Boolean;

    prcScroll: TprcScroll;
begin
  inherited;
  If (cdsLancamentos.IsEmpty) Or (fIntAggregate(cdsLancamentos, 'TOT_QTDSEL') <= 0) Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário selecionar registros para utilizar essa função.', ['&OK']);
    Exit(False);
  End;

  pCriarFormularios(TfrmRcxSelecionaCaixa, frmRcxSelecionaCaixa);
  frmRcxSelecionaCaixa.strCaixaOrigem        := cdsLancamentos.FieldByName('RCX_CODCAX').AsString;
  frmRcxSelecionaCaixa.dtaPrimeiroLancamento := fDataAggregate(cdsLancamentos, 'TOT_DTALAN');
  frmRcxSelecionaCaixa.dtaDataDoCaixa        := cdsLancamentos.FieldByName('RCX_DTACAD').AsDateTime;
  frmRcxSelecionaCaixa.ShowModal;

  strCaixaDestino := frmRcxSelecionaCaixa.edtCodigoCaixa.Text;
  blnConfirmar    := frmRcxSelecionaCaixa.ModalResult = mrOK;

  FreeAndNil(frmRcxSelecionaCaixa);

  If (Not blnConfirmar) Or
     (fMensagem('CONFIRMAÇÃO', 'Deseja realmente transferir os lançamentos selecionados?', ['&Sim', '&Não']) = 2) Then
    Exit(False);

  pDisableControls(cdsLancamentos, prcScroll);

  cdsLancamentos.Filter   := 'RCX_MARDES=''M'' ';
  cdsLancamentos.Filtered := True;

  strLancamentos := '';
  strCartoes     := '';
  strCheques     := '';

  cdsLancamentos.First;
  While Not cdsLancamentos.Eof Do
  Begin
    strLancamentos := strLancamentos + '"' + cdsLancamentos.FieldByName('AUTOINCREM').AsString + '",';

    If fFormataFloat(cdsLancamentos.FieldByName('RCX_CARREC').AsFloat, 2) > 0 Then
    Begin
      strValor := '("' + cdsLancamentos.FieldByName('RCX_CODEMP').AsString + '",' +
                         cdsLancamentos.FieldByName('RCX_SEQCON').AsString + ',' +
                  '"'  + cdsLancamentos.FieldByName('RCX_CODCAX').AsString + '",1),';

      If Pos(strValor, strCartoes) <= 0 Then
       strCartoes := strCartoes + strValor;
    End;

    If (fFormataFloat(cdsLancamentos.FieldByName('RCX_CHQAVI').AsFloat, 2) > 0) Or
       (fFormataFloat(cdsLancamentos.FieldByName('RCX_CHQPRE').AsFloat, 2) > 0) Then
    Begin
      strValor := '("' + cdsLancamentos.FieldByName('RCX_CODEMP').AsString + '",' +
                         cdsLancamentos.FieldByName('RCX_SEQCON').AsString + ',' +
                  '"'  + cdsLancamentos.FieldByName('RCX_CODCAX').AsString + '",1),';

      If Pos(strValor, strCheques) <= 0 Then
       strCheques := strCheques + strValor;
    End;

    cdsLancamentos.Next;
  End;

  strLancamentos := LeftStr(strLancamentos, strLancamentos.Length - 1);
  If Not strCartoes.IsEmpty Then
    strCartoes := LeftStr(strCartoes, strCartoes.Length - 1);
  If Not strCheques.IsEmpty Then
    strCheques := LeftStr(strCheques, strCheques.Length - 1);

  Result := True;
  Try
    fStartTransaction;
    fExecutaSQL('UPDATE CADRCXX SET RCX_CODCAX=' + strCaixaDestino.QuotedString +
                ' WHERE AUTOINCREM IN (' + strLancamentos + ')');

    If Not strCartoes.IsEmpty Then
    Begin
      fExecutaSQL('UPDATE MOVCAR SET MCA_CODCAX=' + strCaixaDestino.QuotedString +
                  ' WHERE (MCA_EMPRCX, MCA_SEQCON, MCA_CODCAX, MCA_RESCAI) IN (' + strCartoes + ')');
    End;

    If Not strCheques.IsEmpty Then
    Begin
      fExecutaSQL('UPDATE CADCHQ SET CHQ_CODCAX=' + strCaixaDestino.QuotedString +
                  ' WHERE (CHQ_EMPRCX, CHQ_SEQCON, CHQ_CODCAX, CHQ_RESCAI) IN (' + strCheques + ')');
    End;

    fCommit;

    fMensagem('AVISO', 'Lançamentos transferidos com sucesso.', ['&OK']);

    pLimparDados;
    pEnableControls(cdsLancamentos, prcScroll);
  Except
    On E: Exception Do
    Begin
      fRollback;
      pMensagensErro('Ocorreu um erro ao atualizar o caixa dos lançamentos. ' + #13 +
                     'Erro gerado: ' + E.Message, '[TfrmRcxTransfLancamentosEntreCaixas.fTransferirLancamentos]');
    End;
  End;
end;

function TfrmRcxTransfLancamentosEntreCaixas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodigoOperador) Then
    Begin

      If (fEmptyStr(edtCodigoOperador.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do operador deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaOperador;
        If (fEmptyStr(edtNomeOperador.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse operador não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtCodigoCaixa) Then
    Begin

      If (fEmptyStr(edtCodigoCaixa.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do caixa deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaCaixa;
        If (fEmptyStr(edtDescricaoCaixa.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse caixa não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtDataLancamentos) Then
    Begin

      If (fEmptyStr(edtDataLancamentos.Text)) Or (edtDataLancamentos.Date = 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data de lançamentos deve ser preenchida!', ['&Ok']);
        Result := False;
      End;

    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRcxTransfLancamentosEntreCaixas.grdLancamentosDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strMarDes: String;
begin
  inherited;

  If (Not Assigned(cdsLancamentos)) Or (cdsLancamentos.IsEmpty) Then
    Exit;

  strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdLancamentosDadosRCX_MARDES.Index]);

  ACanvas.Font.Color := clBlack;
  If (strMarDes = 'M') Then
    ACanvas.Font.Color := clBlue;
end;

procedure TfrmRcxTransfLancamentosEntreCaixas.grdLancamentosDadosKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Return Then
    pSelecionarLancamentos(False, cdsLancamentos.FieldByName('RCX_MARDES').AsString = 'M');
end;

procedure TfrmRcxTransfLancamentosEntreCaixas.pCarregaCaixa;
begin
  edtDescricaoCaixa.Clear;
  If Not fEmptyStr(edtCodigoCaixa.Text) Then
    edtDescricaoCaixa.Text := fCampoTabela('CAX_DESCRI',
                                           'CADCAX',
                                           ['CAX_CODCAX', 'CAX_CODEMP'],
                                           [edtCodigoCaixa.Text, VS_strCodEmp]);
end;

procedure TfrmRcxTransfLancamentosEntreCaixas.pCarregaOperador;
begin
  edtNomeOperador.Clear;
  If Not fEmptyStr(edtCodigoOperador.Text) Then
    edtNomeOperador.Text := fRetNomeOperador(edtCodigoOperador.Text);
end;

procedure TfrmRcxTransfLancamentosEntreCaixas.pCriaAggregateFields;
begin

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_VALDOC';
    FieldName     := 'TOT_VALDOC';
    DataSet       := cdsLancamentos;
    Expression    := 'SUM(RCX_VALDOC)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_DINREC';
    FieldName     := 'TOT_DINREC';
    DataSet       := cdsLancamentos;
    Expression    := 'SUM(RCX_DINREC)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_CARREC';
    FieldName     := 'TOT_CARREC';
    DataSet       := cdsLancamentos;
    Expression    := 'SUM(RCX_CARREC)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_CHQAVI';
    FieldName     := 'TOT_CHQAVI';
    DataSet       := cdsLancamentos;
    Expression    := 'SUM(RCX_CHQAVI)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_CHQPRE';
    FieldName     := 'TOT_CHQPRE';
    DataSet       := cdsLancamentos;
    Expression    := 'SUM(RCX_CHQPRE)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_ORDREC';
    FieldName     := 'TOT_ORDREC';
    DataSet       := cdsLancamentos;
    Expression    := 'SUM(RCX_ORDREC)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_DOCSEL';
    FieldName     := 'TOT_DOCSEL';
    DataSet       := cdsLancamentos;
    Expression    := 'SUM(RCX_DOCSEL)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_DINSEL';
    FieldName     := 'TOT_DINSEL';
    DataSet       := cdsLancamentos;
    Expression    := 'SUM(RCX_DINSEL)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_CARSEL';
    FieldName     := 'TOT_CARSEL';
    DataSet       := cdsLancamentos;
    Expression    := 'SUM(RCX_CARSEL)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_AVISEL';
    FieldName     := 'TOT_AVISEL';
    DataSet       := cdsLancamentos;
    Expression    := 'SUM(RCX_AVISEL)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_PRESEL';
    FieldName     := 'TOT_PRESEL';
    DataSet       := cdsLancamentos;
    Expression    := 'SUM(RCX_PRESEL)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_ORDSEL';
    FieldName     := 'TOT_ORDSEL';
    DataSet       := cdsLancamentos;
    Expression    := 'SUM(RCX_ORDSEL)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_QTDREG';
    FieldName     := 'TOT_QTDREG';
    DataSet       := cdsLancamentos;
    Expression    := 'COUNT(DOCUMENTO)';
    Active        := True;
  End;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_QTDSEL';
    FieldName     := 'TOT_QTDSEL';
    DataSet       := cdsLancamentos;
    Expression    := 'SUM(RCX_QTDSEL)';
    Active        := True;
  End;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_DTALAN';
    FieldName     := 'TOT_DTALAN';
    DataSet       := cdsLancamentos;
    Expression    := 'MIN(RCX_GRVSEL)';
    Active        := True;
  End;
end;

procedure TfrmRcxTransfLancamentosEntreCaixas.pCriaTemporaria;
  Var
    qryLancamentos: TUniQuery;
begin
  Try
    qryLancamentos := fCriarQuery('SELECT *,                 ' +
                                  '  CONCAT(RCX_NUMDOC, "-", ' +
                                  '         RCX_PARCEL, "-", ' +
                                  '         RCX_ESPDOC, "-", ' +
                                  '         RCX_CODEMP) AS   ' +
                                  '  DOCUMENTO,              ' +
                                  '  "D" AS RCX_MARDES,      ' +
                                  ' 0    AS RCX_QTDSEL,      ' +
                                  ' 0.00 AS RCX_DINSEL,      ' +
                                  ' 0.00 AS RCX_CARSEL,      ' +
                                  ' 0.00 AS RCX_AVISEL,      ' +
                                  ' 0.00 AS RCX_PRESEL,      ' +
                                  ' 0.00 AS RCX_ORDSEL,      ' +
                                  ' 0.00 AS RCX_DOCSEL,      ' +
                                  ' CAST(NULL AS DATETIME) AS RCX_GRVSEL ' +
                                  'FROM CADRCXX              ' +
                                  'WHERE RCX_DTACAD = ' + FormatDateTime('yyyy-mm-dd', edtDataLancamentos.Date).QuotedString +
                                  '  AND RCX_CODOPE = ' + QuotedStr(edtCodigoOperador.Text) +
                                  '  AND RCX_CODCAX = ' + QuotedStr(edtCodigoCaixa.Text) +
                                  '  AND RCX_LANFEC = "N"    ' +
                                  '  AND RCX_ESPDOC <> "FC"  ' +
                                  'ORDER BY RCX_DTAGRV       ');

    qryLancamentos.Options.SetFieldsReadOnly := False;
    qryLancamentos.Open;

    cdsLancamentos.Close;
    pSetaClient(qryLancamentos);
    pSetaClientDataSet(qryLancamentos, cdsLancamentos);
    cdsLancamentos.AggregatesActive := True;
    cdsLancamentos.Open;

    cdsLancamentos.First;

    grdLancamentosDados.DataController.DataSource := fCriaDataSource(cdsLancamentos);
    grdLancamentosDados.DataController.DataSource.AutoEdit := False;
  Finally
    FreeAndNil(qryLancamentos);

    pExibeTotalLancamentos;
    pSetFocus(grdLancamentos);
  End;
end;

procedure TfrmRcxTransfLancamentosEntreCaixas.pExibeTotalLancamentos;
  Var
    prcScroll: TprcScroll;
begin
  pDisableControls(cdsLancamentos, prcScroll);

  edtQtdLancamentos.Text  := '( ' + IntToStr(cdsLancamentos.RecordCount) + ' )';
  edtQtdSelecionados.Text := '( ' + IntToStr(fIntAggregate(cdsLancamentos, 'TOT_QTDSEL')) + ' )';

  edtValorLancamentos.Text    := FormatFloat('#,##0.00;-#,##0.00', fDoubleAggregate(cdsLancamentos, 'TOT_VALDOC'));
  edtLancamentosSel.Text      := FormatFloat('#,##0.00;-#,##0.00', fDoubleAggregate(cdsLancamentos, 'TOT_DOCSEL'));
  edtDinheiro.Text            := FormatFloat('#,##0.00;-#,##0.00', fDoubleAggregate(cdsLancamentos, 'TOT_DINREC'));
  edtDinheiroSel.Text         := FormatFloat('#,##0.00;-#,##0.00', fDoubleAggregate(cdsLancamentos, 'TOT_DINSEL'));
  edtCartao.Text              := FormatFloat('#,##0.00;-#,##0.00', fDoubleAggregate(cdsLancamentos, 'TOT_CARREC'));
  edtCartaoSel.Text           := FormatFloat('#,##0.00;-#,##0.00', fDoubleAggregate(cdsLancamentos, 'TOT_CARSEL'));
  edtChequeAVista.Text        := FormatFloat('#,##0.00;-#,##0.00', fDoubleAggregate(cdsLancamentos, 'TOT_CHQAVI'));
  edtChequeAVistaSel.Text     := FormatFloat('#,##0.00;-#,##0.00', fDoubleAggregate(cdsLancamentos, 'TOT_AVISEL'));
  edtChequePre.Text           := FormatFloat('#,##0.00;-#,##0.00', fDoubleAggregate(cdsLancamentos, 'TOT_CHQPRE'));
  edtChequePreSel.Text        := FormatFloat('#,##0.00;-#,##0.00', fDoubleAggregate(cdsLancamentos, 'TOT_PRESEL'));
  edtOrdemRecebimento.Text    := FormatFloat('#,##0.00;-#,##0.00', fDoubleAggregate(cdsLancamentos, 'TOT_ORDREC'));
  edtOrdemRecebimentoSel.Text := FormatFloat('#,##0.00;-#,##0.00', fDoubleAggregate(cdsLancamentos, 'TOT_ORDSEL'));

  pEnableControls(cdsLancamentos, prcScroll);
end;

procedure TfrmRcxTransfLancamentosEntreCaixas.pLimparDados;
begin
  cdsLancamentos.Filter   := '';
  cdsLancamentos.Filtered := False;
  cdsLancamentos.EmptyDataSet;

  edtCodigoCaixa.Clear;
  edtDescricaoCaixa.Clear;
  edtCodigoOperador.Clear;
  edtNomeOperador.Clear;
  edtDataLancamentos.Clear;

  edtQtdLancamentos.Clear;
  edtQtdSelecionados.Clear;

  edtValorLancamentos.Clear;
  edtLancamentosSel.Clear;
  edtDinheiro.Clear;
  edtDinheiroSel.Clear;
  edtCartao.Clear;
  edtCartaoSel.Clear;
  edtChequeAVista.Clear;
  edtChequeAVistaSel.Clear;
  edtChequePre.Clear;
  edtChequePreSel.Clear;
  edtOrdemRecebimento.Clear;
  edtOrdemRecebimentoSel.Clear;
end;

procedure TfrmRcxTransfLancamentosEntreCaixas.pSelecionarLancamentos(
  blnTodosLancamentos: Boolean; blnDesmarcar: Boolean);
  Var
    prcScroll  : TprcScroll;
    frmGravando: TfrmGravando;
begin
  If (Not Assigned(cdsLancamentos)) Or (cdsLancamentos.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário carregar registros para utilizar essa função.', ['&OK']);
    Exit;
  End;

  pDisableControls(cdsLancamentos, prcScroll);

  If Not blnTodosLancamentos Then
  Begin
    cdsLancamentos.Filter   := 'RCX_SEQCON=' + cdsLancamentos.FieldByName('RCX_SEQCON').AsString;
    cdsLancamentos.Filtered := True;
  End;

  pCriarFormularios(TfrmGravando, frmGravando);
  If Not blnDesmarcar Then
  Begin
    frmGravando.lblGravando.Caption := 'Aguarde... Marcando lançamentos.';
    frmGravando.fExecutarAcao := fMarcarLancamentos;
  End
  Else
  Begin
    frmGravando.lblGravando.Caption := 'Aguarde... Desmarcando lançamentos.';
    frmGravando.fExecutarAcao := fDesmarcarLancamentos;
  End;

  frmGravando.ShowModal;
  FreeAndNil(frmGravando);

  pExibeTotalLancamentos;

  pEnableControls(cdsLancamentos, prcScroll);

  pSetFocus(grdLancamentos);
end;

end.
