unit untGerAutDespesasFinanceiras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCalendar, cxCurrencyEdit, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel,
  cxGrid, ComboBoxFocus, EditFocus, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  Uni, UniClientDataSet, cxProgressBar, StrUtils, untTypesSistema,
  cxGridBandedTableView, cxGridDBBandedTableView, cxButtonEdit,
  cxEditRepositoryItems, untRcxTLiberacaoDeCaixas, cxMemo;

type
  TfrmGerAutDespesasFinanceiras = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label2: TLabel;
    edtDataInicial: TcxDateEdit;
    btnCarregarPagamentos: TBitBtnLocked;
    Label4: TLabel;
    edtDataFinal: TcxDateEdit;
    pnlDados: TPanel;
    grdLancamentos: TcxGridCitel;
    grdLancamentosDados: TcxGridDBTableViewCitel;
    grdLancamentosDadosCTP_DTAPAG: TcxGridDBColumn;
    grdLancamentosDadosFORNECEDOR: TcxGridDBColumn;
    grdLancamentosDadosBCCREDITO: TcxGridDBColumn;
    grdLancamentosDadosCTP_CTABAI: TcxGridDBColumn;
    grdLancamentosDadosCTP_VALPAG: TcxGridDBColumn;
    grdLancamentosNivel: TcxGridLevel;
    grdLancamentosDadosCTA_CSTPIS: TcxGridDBColumn;
    grdLancamentosDadosORIGEMCREDITO: TcxGridDBColumn;
    grdLancamentosDadosCTA_ALQPIS: TcxGridDBColumn;
    grdLancamentosDadosCTA_DESCTA: TcxGridDBColumn;
    grdLancamentosDadosCTA_CSTCOF: TcxGridDBColumn;
    grdLancamentosDadosCTA_ALQCOF: TcxGridDBColumn;
    grdLancamentosDadosCta: TcxGridDBTableViewCitel;
    grdLancamentosDadosCtaMODALIDADE: TcxGridDBColumn;
    grdLancamentosDadosCtaVALOR: TcxGridDBColumn;
    grdLancamentosDadosCtaRCX_CODOPE: TcxGridDBColumn;
    grdLancamentosDadosCtaRCX_SEQCON: TcxGridDBColumn;
    grdLancamentosDadosCtaRCX_STATUS: TcxGridDBColumn;
    grdLancamentosDadosCtaDOCUMENTOS: TcxGridDBColumn;
    grdLancamentosDadosCtaACOES: TcxGridDBColumn;
    grdLancamentosDadosCtaVALORSELECIONADO: TcxGridDBColumn;
    grdLancamentosDadosCtaTRF_OPELIB: TcxGridDBColumn;
    grdLancamentosDadosCtaTRF_DTALIB: TcxGridDBColumn;
    grdLancamentosDadosCtaTRF_MOTIVO: TcxGridDBColumn;
    grdLancamentosDadosCTP_CODEMP: TcxGridDBColumn;
    grdLancamentosDadosCTP_HIST01: TcxGridDBColumn;
    btnGerarDespesasFinanceiras: TBitBtnLocked;
    grdLancamentosDadosVALOR_PIS: TcxGridDBColumn;
    grdLancamentosDadosVALOR_COFINS: TcxGridDBColumn;
    btnDesmarca: TBitBtnLocked;
    btnMarca: TBitBtnLocked;
    grdLancamentosDadosMARDES: TcxGridDBColumn;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnCarregarPagamentosClick(Sender: TObject);
    procedure grdLancamentosDadosFORNECEDORGetCellHint(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
      var AHintText: TCaption; var AIsHintMultiLine: Boolean;
      var AHintTextRect: TRect);
    procedure grdLancamentosDadosCTA_DESCTAGetCellHint(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
      var AHintText: TCaption; var AIsHintMultiLine: Boolean;
      var AHintTextRect: TRect);
    procedure grdLancamentosDadosBCCREDITOGetCellHint(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
      var AHintText: TCaption; var AIsHintMultiLine: Boolean;
      var AHintTextRect: TRect);
    procedure grdLancamentosDadosCTP_HIST01GetCellHint(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
      var AHintText: TCaption; var AIsHintMultiLine: Boolean;
      var AHintTextRect: TRect);
    procedure grdLancamentosDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnGerarDespesasFinanceirasClick(Sender: TObject);
    procedure btnMarcaClick(Sender: TObject);
    procedure btnDesmarcaClick(Sender: TObject);
    procedure grdLancamentosDadosCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FcdsPagamentos: TUniClientDataSet;
    FprcScroll: TprcScroll;
    FCorZebra: Integer;
    intQtdReg: Integer;

    strLinEmp: String;

    procedure pCriaTemporaria;
    function RetornaSQLConsulta: String;
    procedure pLimparDados;
    function RetornaSQLInsertDespesasFinanceiras: String;
    function GravarDespesasFinanceiras(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure ExibirConsulta;
    procedure pMarcaPagamento(blnMarcar: Boolean);
    procedure pSelecionaPagamento;
    function fPagamentosMarcados: Integer;

  public
    { Public declarations }

    arrLinEmp: TConsultasArray;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    { Protected declarations }
  end;

implementation
Uses untGravando, untFuncoesSimples, untConsultas, untPesqAux, untLiberacao, untFuncoesConsulta,
  untFechamentoEstoque, untFechamentoFiscal;

{$R *.dfm}



procedure TfrmGerAutDespesasFinanceiras.btnCarregarPagamentosClick(
  Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  Try
    Self.Hide;
    TfrmGravando.fExecutarModal(pCriaTemporaria, 'Aguarde... Consultando pagamentos pendentes.', '');
  Finally
    Self.Show;
  End;

  If FcdsPagamentos.IsEmpty Then
    fMensagem('AVISO', 'Nenhum pagamento pendente de lançamento de despesas financeiras encontrado.', ['&OK']);
end;

procedure TfrmGerAutDespesasFinanceiras.pMarcaPagamento(blnMarcar: Boolean);
begin
  If Not FcdsPagamentos.Active Then
    Exit;

  FcdsPagamentos.Edit;

  If blnMarcar Then
  Begin
    FcdsPagamentos.FieldByName('MARDES').AsString := 'M';
  End
  Else
  Begin
    FcdsPagamentos.FieldByName('MARDES').AsString := 'D';
  End;

  FcdsPagamentos.Post;
end;

procedure TfrmGerAutDespesasFinanceiras.pSelecionaPagamento;
  Var
    intRecNo: Integer;
begin

  intRecNo := FcdsPagamentos.RecNo;

  If FcdsPagamentos.FieldByName('MARDES').AsString <> 'M' Then
    pMarcaPagamento(True)
  Else
    pMarcaPagamento(False);

  FcdsPagamentos.RecNo := intRecNo;

end;

function TfrmGerAutDespesasFinanceiras.fPagamentosMarcados: Integer;
var
  intRecNo: Integer;
begin
  Result := 0;
  intRecNo := FcdsPagamentos.RecNo;

  Try
    FcdsPagamentos.DisableControls;

    FcdsPagamentos.First;
    While Not FcdsPagamentos.Eof Do
    Begin
      If FcdsPagamentos.FieldByName('MARDES').AsString = 'M' Then
        Inc(Result);
      FcdsPagamentos.Next;
    End;
  Finally
    FcdsPagamentos.RecNo := intRecNo;
    FcdsPagamentos.EnableControls;
  End;
end;

procedure TfrmGerAutDespesasFinanceiras.btnMarcaClick(Sender: TObject);
begin
  If (Not FcdsPagamentos.Active) Or (FcdsPagamentos.IsEmpty) Then
    Exit;

  Try
    FcdsPagamentos.DisableControls;

    FcdsPagamentos.First;
    While Not FcdsPagamentos.Eof Do
    Begin
      pMarcaPagamento(True);
      FcdsPagamentos.Next;
    End;
  Finally
    FcdsPagamentos.EnableControls;
  End;
end;

procedure TfrmGerAutDespesasFinanceiras.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrLinEmp, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmGerAutDespesasFinanceiras.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrLinEmp, False, True) Then
  Begin
    fValidaCampos(edtCodEmpresa, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGerAutDespesasFinanceiras.btnDesmarcaClick(Sender: TObject);
begin
  If (Not FcdsPagamentos.Active) Or (FcdsPagamentos.IsEmpty) Then
    Exit;

  Try
    FcdsPagamentos.DisableControls;

    FcdsPagamentos.First;
    While Not FcdsPagamentos.Eof Do
    Begin
      pMarcaPagamento(False);
      FcdsPagamentos.Next;
    End;
  Finally
    FcdsPagamentos.EnableControls;
  End;
end;

procedure TfrmGerAutDespesasFinanceiras.btnGerarDespesasFinanceirasClick(
  Sender: TObject);
  Var
    LfrmGravando: TfrmGravando;
begin
  inherited;

  Try

    If FcdsPagamentos.IsEmpty Then
    Begin
      fMensagem('AVISO', 'Nenhum pagamento pendente de lançamento de despesas financeiras!', ['&OK']);
      Exit;
    End;

    intQtdReg := fPagamentosMarcados;

    If intQtdReg = 0 Then
    Begin
      fMensagem('AVISO', 'Nenhum pagamento pendente de lançamento de despesas financeiras foi selecionado!', ['&OK']);
      Exit;
    End;

    If Not TFechamentoEstoque.fDataDeEntradaPermitida(edtDataInicial.Date) Then
      Exit;

    If Not TFechamentoFiscal.fDataFiscalPermitida(edtDataInicial.Date) Then
      Exit;

    If fMensagem('AVISO', 'Gerar Despesas Financeiras de todos os registros selecionados ?',['&Sim', '&Não'], 2) = 2 Then
      Exit;

    Try
      pCriarFormularios(TfrmGravando, LfrmGravando);
      LfrmGravando.lblGravando.Caption := 'Aguarde... Gerando Despesas Financeiras.';
      LfrmGravando.pgbStatus.Visible := True;
      LfrmGravando.fExecutarAcao := GravarDespesasFinanceiras;
      LfrmGravando.ShowModal;

      If LfrmGravando.blnConfirma Then
        fMensagem('AVISO', 'Geração realizada com sucesso!', ['&OK']);

    Finally
      pFreeAndNil(LfrmGravando);
    End;

    pLimparDados;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pVerificaEntregasEmpresa]');
      pLimparDados;
    End;
  End;

end;

procedure TfrmGerAutDespesasFinanceiras.ExibirConsulta;
begin
  btnGerarDespesasFinanceiras.Visible := True;
  btnCarregarPagamentos.Visible := False;
  edtCodEmpresa.Enabled := False;
  edtDataInicial.Enabled := False;
  edtDataFinal.Enabled := False;
  Self.BorderIcons := [biSystemMenu,biMaximize];
  Self.WindowState := wsMaximized;
end;

procedure TfrmGerAutDespesasFinanceiras.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Assigned(FcdsPagamentos) Then
    FreeAndNil(FcdsPagamentos);
end;

procedure TfrmGerAutDespesasFinanceiras.FormCreate(Sender: TObject);
begin
  inherited;
  FCorZebra := fCfgSis('CORZEB', varInteger);
  FcdsPagamentos := TUniClientDataset.Create(Self);
  FcdsPagamentos.AggregatesActive := True;
end;

procedure TfrmGerAutDespesasFinanceiras.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
    btnSair.Click
  Else If Key = VK_F10 Then
    btnGerarDespesasFinanceiras.Click;
end;

function TfrmGerAutDespesasFinanceiras.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodEmpresa) Then
    Begin
      pDesmarcaLista(edtCodEmpresa, arrLinEmp)
    End

    Else If (Sender = edtDataInicial) Then
    Begin

      If (fEmptyStr(edtDataInicial.Text)) Or (edtDataInicial.Date = 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtDataFinal) Then
    Begin
      Result := (Not blnBuscaPorChave) Or
                (fValidaCampos(edtDataInicial, blnBuscaPorChave));

      If Result Then
      Begin
        If (fEmptyStr(edtDataFinal.Text)) Or (edtDataFinal.Date = 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A data final deve ser preenchida!', ['&Ok']);
          Result := False;
        End
        Else If StrToDate(edtDataInicial.Text) > StrToDate(edtDataFinal.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A data inicial deve ser menor ou igual que a data final!', ['&Ok']);
          Result := False;
        End;
      End;


    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmGerAutDespesasFinanceiras.GravarDespesasFinanceiras(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    LInsert: TUniQuery;
begin
  Result := True;

  Try
    LInsert := fCriaQuery(Nil);
    Try

      pDisableControls(FcdsPagamentos, FprcScroll);

      FcdsPagamentos.Filtered := False;
      FcdsPagamentos.Filter := grdLancamentosDados.DataController.Filter.FilterText;
      FcdsPagamentos.Filtered := True;

      FcdsPagamentos.First;
      pgbStatus.Properties.Max := intQtdReg;
      pgbStatus.Position := 0;

      fStartTransaction;
      While Not FcdsPagamentos.Eof Do
      Begin
        If FcdsPagamentos.FieldByName('MARDES').AsString = 'M' Then
        Begin
          LInsert.Close;
          LInsert.SQL.Clear;
          LInsert.SQL.Text := RetornaSQLInsertDespesasFinanceiras;

          LInsert.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CADDEF', VS_strCodEmp);
          LInsert.ParamByName('DEF_ALQCOF').AsFloat  := FcdsPagamentos.FieldByName('CTA_ALQCOF').AsFloat;
          LInsert.ParamByName('DEF_ALQPIS').AsFloat  := FcdsPagamentos.FieldByName('CTA_ALQPIS').AsFloat;
          LInsert.ParamByName('DEF_BASCOF').AsFloat  := FcdsPagamentos.FieldByName('CTP_VALPAG').AsFloat;
          LInsert.ParamByName('DEF_BASPIS').AsFloat  := FcdsPagamentos.FieldByName('CTP_VALPAG').AsFloat;
          LInsert.ParamByName('DEF_CBCCRE').AsString := FcdsPagamentos.FieldByName('CTA_CBCCRE').AsString;
          LInsert.ParamByName('DEF_CODCTA').AsString := FcdsPagamentos.FieldByName('PLANOCONTA').AsString;
          LInsert.ParamByName('DEF_CODEMP').AsString := FcdsPagamentos.FieldByName('CTP_CODEMP').AsString;
          LInsert.ParamByName('DEF_CSTCOF').AsString := FcdsPagamentos.FieldByName('CTA_CSTCOF').AsString;
          LInsert.ParamByName('DEF_CSTPIS').AsString := FcdsPagamentos.FieldByName('CTA_CSTPIS').AsString;
          LInsert.ParamByName('DEF_DTAOPE').AsDateTime := FcdsPagamentos.FieldByName('CTP_DTAPAG').AsDateTime;
          LInsert.ParamByName('DEF_OBSDOP').AsString := FcdsPagamentos.FieldByName('CTP_HIST01').AsString;
          LInsert.ParamByName('DEF_TIP_FC').AsString := FcdsPagamentos.FieldByName('TIP_FC').AsString;
          LInsert.ParamByName('DEF_VALCOF').AsFloat  := FcdsPagamentos.FieldByName('VALOR_COFINS').AsFloat;
          LInsert.ParamByName('DEF_VALOPE').AsFloat  := FcdsPagamentos.FieldByName('CTP_VALPAG').AsFloat;
          LInsert.ParamByName('DEF_VALPIS').AsFloat  := FcdsPagamentos.FieldByName('VALOR_PIS').AsFloat;
          LInsert.ParamByName('DEF_CODPAR').AsString := FcdsPagamentos.FieldByName('CTP_CODFOR').AsString;

          LInsert.ParamByName('DEF_NUMDUP').AsString  := FcdsPagamentos.FieldByName('CTP_NUMDUP').AsString;
          LInsert.ParamByName('DEF_PARCEL').AsString  := FcdsPagamentos.FieldByName('CTP_PARCEL').AsString;
          LInsert.ParamByName('DEF_SERIE_').AsString  := FcdsPagamentos.FieldByName('CTP_SERIE_').AsString;
          LInsert.ParamByName('DEF_EMPDUP').AsString  := FcdsPagamentos.FieldByName('CTP_CODEMP').AsString;
          LInsert.ParamByName('DEF_FORDUP').AsString  := FcdsPagamentos.FieldByName('CTP_CODFOR').AsString;
          LInsert.ParamByName('DEF_SEQBAI').AsInteger := FcdsPagamentos.FieldByName('CTP_SEQBAI').AsInteger;
          LInsert.ParamByName('DEF_CODCCA').AsString  := FcdsPagamentos.FieldByName('CTA_PLANCO').AsString;

          LInsert.ParamByName('DEF_INDORI').AsInteger := IIF(FcdsPagamentos.FieldByName('ORIGEMCREDITO').AsString.Equals('MERCADO INTERNO'),0,1);

          LInsert.ExecSQL;

          pStepStatusGravacao(pgbStatus);
        End;
        FcdsPagamentos.Next;
      End;

      fCommit;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LInsert);
    pEnableControls(FcdsPagamentos, FprcScroll);
  End;
end;

procedure TfrmGerAutDespesasFinanceiras.grdLancamentosDadosBCCREDITOGetCellHint(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
  var AHintText: TCaption; var AIsHintMultiLine: Boolean;
  var AHintTextRect: TRect);
begin
  inherited;
  AHintText := VarToStr(ARecord.Values[Sender.Index]);
  AIsHintMultiLine := True;
end;

procedure TfrmGerAutDespesasFinanceiras.grdLancamentosDadosCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pSelecionaPagamento;
end;

procedure TfrmGerAutDespesasFinanceiras.grdLancamentosDadosCTA_DESCTAGetCellHint(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
  var AHintText: TCaption; var AIsHintMultiLine: Boolean;
  var AHintTextRect: TRect);
begin
  inherited;
  AHintText := VarToStr(ARecord.Values[Sender.Index]);
  AIsHintMultiLine := True;
end;

procedure TfrmGerAutDespesasFinanceiras.grdLancamentosDadosCTP_HIST01GetCellHint(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
  var AHintText: TCaption; var AIsHintMultiLine: Boolean;
  var AHintTextRect: TRect);
begin
  inherited;
  AHintText := VarToStr(ARecord.Values[Sender.Index]);
  AIsHintMultiLine := True;
end;

procedure TfrmGerAutDespesasFinanceiras.grdLancamentosDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (Not Assigned(FcdsPagamentos)) Or (Not FcdsPagamentos.Active) Then
    Exit;

  If (Not AViewInfo.GridRecord.Focused) And
     (AViewInfo.GridRecord.Index Mod 2 = 0) Then
  Begin
    ACanvas.Brush.Color := FCorZebra;
  End;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdLancamentosDadosMARDES.Index]) = 'M' Then
  Begin
    If AViewInfo.Selected Then
      ACanvas.Font.Color := clLime
    Else
      ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmGerAutDespesasFinanceiras.grdLancamentosDadosFORNECEDORGetCellHint(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
  var AHintText: TCaption; var AIsHintMultiLine: Boolean;
  var AHintTextRect: TRect);
begin
  inherited;
  AHintText := VarToStr(ARecord.Values[Sender.Index]);
  AIsHintMultiLine := True;
end;

procedure TfrmGerAutDespesasFinanceiras.pCriaTemporaria;
  Var
    qryPagamentos: TUniQuery;
begin
  Try
    qryPagamentos := fCriaQuery;
    qryPagamentos.Close;
    qryPagamentos.SQL.Clear;
    qryPagamentos.SQL.Text := RetornaSQLConsulta;
    qryPagamentos.ParamByName('DTAINI').AsDateTime := edtDataInicial.Date;
    qryPagamentos.ParamByName('DTAFIN').AsDateTime := edtDataFinal.Date;
    pSetaParam(edtCodEmpresa.Text, arrLinEmp, strLinEmp, 'CODEMP', qryPagamentos);
    qryPagamentos.Open;

    FcdsPagamentos.Close;
    pDisableControls(FcdsPagamentos, FprcScroll);
    pSetaClient(qryPagamentos);
    pSetaClientDataSet(qryPagamentos, FcdsPagamentos);
    FcdsPagamentos.Open;

    pEnableControls(FcdsPagamentos, FprcScroll);

    FcdsPagamentos.First;
    grdLancamentosDados.DataController.DataSource := fCriaDataSource(FcdsPagamentos);

    If Not FcdsPagamentos.IsEmpty Then
      ExibirConsulta;
  Finally
    FreeAndNil(qryPagamentos);
    pSetFocus(grdLancamentos);
  End;
end;

procedure TfrmGerAutDespesasFinanceiras.pLimparDados;
begin
  FcdsPagamentos.Filter   := '';
  FcdsPagamentos.Filtered := False;
  FcdsPagamentos.EmptyDataSet;
  edtCodEmpresa.Clear;
  edtDataInicial.Clear;
  edtDataFinal.Clear;
end;


function TfrmGerAutDespesasFinanceiras.RetornaSQLConsulta: String;
begin

  Result := 'SELECT                                                                         '+
            '  CADPAG.CTP_DTAPAG AS CTP_DTAPAG,                                             '+
            '  CADPAG.CTP_CODEMP AS CTP_CODEMP,                                             '+
            '  CONCAT(CADPAG.CTP_CODFOR,"-",FOR_NOMFOR) AS FORNECEDOR,                      '+
            '  CADPAG.CTP_CODFOR AS CTP_CODFOR,                                             '+
            '  CADFOR.FOR_NOMFOR AS FOR_NOMFOR,                                             '+
            '  INSERT(INSERT(CADPAG.CTP_CTABAI, 3, 0, "."), 6, 0, ".") AS CTP_CTABAI,       '+
            '  CADPAG.CTP_CTABAI AS PLANOCONTA,                                             '+
            '  CADCTA.CTA_DESCTA AS CTA_DESCTA,                                             '+
            '  CADCTA.CTA_CBCCRE AS CTA_CBCCRE,                                             '+
            '  IF(IFNULL(CADCTA.CTA_PLANCO,"") = "", CTANCO.NCO_CODCON, CADCTA.CTA_PLANCO) AS CTA_PLANCO, '+
            '  CADPAG.CTP_VALPAG AS CTP_VALPAG,                                             '+
            '  CONCAT(CTA_CBCCRE,"-",FIN_DESCRI) AS BCCREDITO,                              '+
            '  IF(CID_ESTADO = "EX","IMPORTAÇÃO", "MERCADO INTERNO") AS ORIGEMCREDITO,      '+
            '  CADCTA.CTA_CSTPIS AS CTA_CSTPIS,                                             '+
            '  CADCTA.CTA_ALQPIS AS CTA_ALQPIS,                                             '+
            '  ROUND(((CADPAG.CTP_VALPAG/100) * CADCTA.CTA_ALQPIS),2) AS VALOR_PIS,         '+
            '  CADCTA.CTA_CSTCOF AS CTA_CSTCOF,                                             '+
            '  CADCTA.CTA_ALQCOF AS CTA_ALQCOF,                                             '+
            '  ROUND(((CADPAG.CTP_VALPAG/100) * CADCTA.CTA_ALQCOF),2) AS VALOR_COFINS,      '+
            '  CADPAG.CTP_HIST01 AS CTP_HIST01,                                             '+
            '  "F" AS TIP_FC,                                                               '+
            '  CADPAG.CTP_NUMDUP AS CTP_NUMDUP,                                             '+
            '  CADPAG.CTP_PARCEL AS CTP_PARCEL,                                             '+
            '  CADPAG.CTP_SERIE_ AS CTP_SERIE_,                                             '+
            '  CADPAG.CTP_SEQBAI AS CTP_SEQBAI,                                             '+
            '  "M" AS MARDES                                                                '+
            'FROM                                                                           '+
            '  CADPAG                                                                       '+
            '  JOIN CADCTA                                                                  '+
            '    ON CTA_CODCTA = CTP_CTABAI                                                 '+
            '  LEFT JOIN CADFOR                                                             '+
            '    ON FOR_CODFOR = CTP_CODFOR                                                 '+
            '  LEFT JOIN CBCFIN                                                             '+
            '    ON FIN_CODIGO = CTA_CBCCRE                                                 '+
            '  LEFT JOIN CADCID                                                             '+
            '    ON CID_CODCID = FOR_CODCID                                                 '+
            '  LEFT JOIN CADDEF                                                             '+
            '     ON CADDEF.DEF_NUMDUP = CADPAG.CTP_NUMDUP                                  '+
            '    AND CADDEF.DEF_PARCEL = CADPAG.CTP_PARCEL                                  '+
            '    AND CADDEF.DEF_SERIE_ = CADPAG.CTP_SERIE_                                  '+
            '    AND CADDEF.DEF_EMPDUP = CADPAG.CTP_CODEMP                                  '+
            '    AND CADDEF.DEF_FORDUP = CADPAG.CTP_CODFOR                                  '+
            '    AND CADDEF.DEF_SEQBAI = CADPAG.CTP_SEQBAI                                  '+
            '  LEFT JOIN CTANCO ON CADCTA.CTA_CODCTA = CTANCO.NCO_CODCTA                    '+
            '                  AND CADPAG.CTP_EMPBAI = CTANCO.NCO_CODEMP                    '+
            'WHERE CTP_DTAPAG BETWEEN :DTAINI                                               '+
            '  AND :DTAFIN                                                                  '+
            '  AND CTA_USADFI = "S"                                                         '+
            '  AND DEF_CBCCRE IS NULL                                                       '+
            Result + fStrLocate(edtCodEmpresa, arrLinEmp, 'CTP_CODEMP', 'CODEMP')            +

            ' UNION ALL                                                                     '+

            'SELECT                                                                         '+
            '  CTP_DTAPAG AS CTP_DTAPAG,                                                    '+
            '  CTP_CODEMP AS CTP_CODEMP,                                                    '+
            '  CONCAT(CTP_CODFOR,"-",FOR_NOMFOR) AS FORNECEDOR,                             '+
            '  CTP_CODFOR AS CTP_CODFOR,                                                    '+
            '  CADFOR.FOR_NOMFOR AS FOR_NOMFOR,                                             '+
            '  INSERT(INSERT(CTP_CTABAI, 3, 0, "."), 6, 0, ".") AS CTP_CTABAI,              '+
            '  CTP_CTABAI AS PLANOCONTA,                                                    '+
            '  CADCTA.CTA_DESCTA AS CTA_DESCTA,                                             '+
            '  "001" AS CTA_CBCCRE,                                                         '+
            '  IFNULL(CAST(SPDPLA.SPD_VALCFG AS CHAR(20)), "CONTA CONTABIL DESCONTOS OBTIDOS") AS CTA_PLANCO, '+
            '  CTP_VALDES AS CTP_VALPAG,                                                    '+
            '  CONCAT(CTA_CBCCRE,"-",FIN_DESCRI) AS BCCREDITO,                              '+
            '  IF(CID_ESTADO = "EX","IMPORTAÇÃO", "MERCADO INTERNO") AS ORIGEMCREDITO,      '+
            '  IFNULL(CAST(CSTPIS.SPD_VALCFG AS CHAR(02)), "01") AS CTA_CSTPIS,             '+
            '  IFNULL(CAST(REPLACE(ALQPIS.SPD_VALCFG, ",", ".") AS DECIMAL(14,2)), 0.65) AS CTA_ALQPIS,        '+
            '  ROUND(CTP_VALDES * IFNULL(CAST(REPLACE(ALQPIS.SPD_VALCFG, ",", ".") AS DECIMAL(14,2)), 0.65)/100,2) AS VALOR_PIS, '+
            '  IFNULL(CAST(CSTCOF.SPD_VALCFG AS CHAR(02)), "01") AS CTA_CSTCOF,             '+
            '  IFNULL(CAST(REPLACE(ALQCOF.SPD_VALCFG, ",", ".") AS DECIMAL(14,2)), 3.00) AS CTA_ALQCOF,        '+
            '  ROUND(CTP_VALDES * IFNULL(CAST(REPLACE(ALQCOF.SPD_VALCFG, ",", ".") AS DECIMAL(14,2)), 3.00)/100,2) AS VALOR_COFINS, '+
            '  "DESCONTOS OBTIDOS" AS CTP_HIST01,                                           '+
            '  "F" AS TIP_FC,                                                               '+
            '  CTP_NUMDUP AS CTP_NUMDUP,                                                    '+
            '  CTP_PARCEL AS CTP_PARCEL,                                                    '+
            '  CTP_SERIE_ AS CTP_SERIE_,                                                    '+
            '  CTP_SEQBAI AS CTP_SEQBAI,                                                    '+
            '  "M" AS MARDES                                                                '+
            'FROM                                                                           '+
            '  CADPAG                                                                       '+
            '  LEFT JOIN CADCTA ON CTA_CODCTA = CTP_CTABAI                                  '+
            '  LEFT JOIN CADFOR ON CTP_CODFOR = FOR_CODFOR                                  '+
            '  LEFT JOIN CBCFIN ON FIN_CODIGO = CTA_CBCCRE                                  '+
            '  LEFT JOIN CADCID ON CID_CODCID = FOR_CODCID                                  '+
            '  LEFT JOIN CFGSPD SPDPLA ON SPDPLA.SPD_CODCFG = "PLANCO_DESCONTOS_OBTIDOS"    '+
            '                         AND SPDPLA.SPD_CODEMP = CADPAG.CTP_EMPBAI             '+
            '  LEFT JOIN CFGSPD CSTPIS ON CSTPIS.SPD_CODCFG = "CSTPIS_DESCONTOS_OBTIDOS"    '+
            '                         AND CSTPIS.SPD_CODEMP = CADPAG.CTP_EMPBAI             '+
            '  LEFT JOIN CFGSPD ALQPIS ON ALQPIS.SPD_CODCFG = "ALQPIS_DESCONTOS_OBTIDOS"    '+
            '                         AND ALQPIS.SPD_CODEMP = CADPAG.CTP_EMPBAI             '+
            '  LEFT JOIN CFGSPD CSTCOF ON CSTCOF.SPD_CODCFG = "CSTCOF_DESCONTOS_OBTIDOS"    '+
            '                         AND CSTCOF.SPD_CODEMP = CADPAG.CTP_EMPBAI             '+
            '  LEFT JOIN CFGSPD ALQCOF ON ALQCOF.SPD_CODCFG = "ALQCOF_DESCONTOS_OBTIDOS"    '+
            '                         AND ALQCOF.SPD_CODEMP = CADPAG.CTP_EMPBAI             '+
            'WHERE CTP_VALDES > 0                                                           '+
            '  AND CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN                                   '+
            Result + fStrLocate(edtCodEmpresa, arrLinEmp, 'CTP_CODEMP', 'CODEMP')            +

            ' UNION ALL                                                                     '+

            'SELECT                                                                         '+
            '  CTR_DTAREC AS CTP_DTAPAG,                                                    '+
            '  CTR_CODEMP AS CTP_CODEMP,                                                    '+
            '  CONCAT(CTR_CODCLI,"-",CLI_NOMCLI) AS FORNECEDOR,                             '+
            '  CTR_CODCLI AS CTP_CODFOR,                                                    '+
            '  CADCLI.CLI_NOMCLI AS FOR_NOMFOR,                                             '+
            '  INSERT(INSERT(CTR_CTABAI, 3, 0, "."), 6, 0, ".") AS CTP_CTABAI,              '+
            '  CTR_CTABAI AS PLANOCONTA,                                                    '+
            '  CADCTA.CTA_DESCTA AS CTA_DESCTA,                                             '+
            '  "001" AS CTA_CBCCRE,                                                         '+
            '  IFNULL(CAST(SPDPLA.SPD_VALCFG AS CHAR(20)), "CONTA CONTABIL JUROS RECEBIDOS") AS CTA_PLANCO,   '+
            '  CTR_VALJUR AS CTP_VALPAG,                                                    '+
            '  CONCAT(CTA_CBCCRE,"-",FIN_DESCRI) AS BCCREDITO,                              '+
            '  IF(CID_ESTADO = "EX","IMPORTAÇÃO", "MERCADO INTERNO") AS ORIGEMCREDITO,      '+
            '  IFNULL(CAST(CSTPIS.SPD_VALCFG AS CHAR(02)), "01") AS CTA_CSTPIS,             '+
            '  IFNULL(CAST(REPLACE(ALQPIS.SPD_VALCFG, ",", ".") AS DECIMAL(14,2)), 0.65) AS CTA_ALQPIS,        '+
            '  ROUND(CTR_VALJUR * IFNULL(CAST(REPLACE(ALQPIS.SPD_VALCFG, ",", ".") AS DECIMAL(14,2)), 0.65)/100,2) AS VALOR_PIS, '+
            '  IFNULL(CAST(CSTCOF.SPD_VALCFG AS CHAR(02)), "01") AS CTA_CSTCOF,             '+
            '  IFNULL(CAST(REPLACE(ALQCOF.SPD_VALCFG, ",", ".") AS DECIMAL(14,2)), 3.00) AS CTA_ALQCOF,        '+
            '  ROUND(CTR_VALJUR * IFNULL(CAST(REPLACE(ALQCOF.SPD_VALCFG, ",", ".") AS DECIMAL(14,2)), 3.00)/100,2) AS VALOR_COFINS, '+
            '  "JUROS RECEBIDOS" AS CTP_HIST01,                                             '+
            '  "C" AS TIP_FC,                                                               '+
            '  CTR_NUMDUP AS CTP_NUMDUP,                                                    '+
            '  CTR_PARCEL AS CTP_PARCEL,                                                    '+
            '  "" AS CTP_SERIE_,                                                            '+
            '  CTR_SEQBAI AS CTP_SEQBAI,                                                    '+
            '  "M" AS MARDES                                                                '+
            ' FROM                                                                          '+
            '  CADREC                                                                       '+
            '  LEFT JOIN CADCTA ON CTA_CODCTA = CTR_CTABAI                                  '+
            '  LEFT JOIN CADCLI ON CTR_CODCLI = CLI_CODCLI                                  '+
            '  LEFT JOIN CBCFIN ON FIN_CODIGO = CTA_CBCCRE                                  '+
            '  LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID                                  '+
            '  LEFT JOIN CFGSPD SPDPLA ON SPDPLA.SPD_CODCFG = "PLANCO_JUROS_RECEBIDOS"      '+
            '                         AND SPDPLA.SPD_CODEMP = CADREC.CTR_EMPBAI             '+
            '  LEFT JOIN CFGSPD CSTPIS ON CSTPIS.SPD_CODCFG = "CSTPIS_JUROS_RECEBIDOS"      '+
            '                         AND CSTPIS.SPD_CODEMP = CADREC.CTR_EMPBAI             '+
            '  LEFT JOIN CFGSPD ALQPIS ON ALQPIS.SPD_CODCFG = "ALQPIS_JUROS_RECEBIDOS"      '+
            '                         AND ALQPIS.SPD_CODEMP = CADREC.CTR_EMPBAI             '+
            '  LEFT JOIN CFGSPD CSTCOF ON CSTCOF.SPD_CODCFG = "CSTCOF_JUROS_RECEBIDOS"      '+
            '                         AND CSTCOF.SPD_CODEMP = CADREC.CTR_EMPBAI             '+
            '  LEFT JOIN CFGSPD ALQCOF ON ALQCOF.SPD_CODCFG = "ALQCOF_JUROS_RECEBIDOS"      '+
            '                         AND ALQCOF.SPD_CODEMP = CADREC.CTR_EMPBAI             '+
            'WHERE CTR_VALJUR > 0                                                           '+
            '  AND CTR_ESPDOC IN ("IF", "NF")                                               '+
            '  AND CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN                                   '+
            Result + fStrLocate(edtCodEmpresa, arrLinEmp, 'CTR_CODEMP', 'CODEMP')            +

            ' ORDER BY CTP_DTAPAG, CTP_CODEMP, FOR_NOMFOR                                   ';
end;

function TfrmGerAutDespesasFinanceiras.RetornaSQLInsertDespesasFinanceiras: String;
begin
  Result := 'INSERT INTO CADDEF (      '+
            '  AUTOINCREM,             '+
            '  DEF_ALQCOF,             '+
            '  DEF_ALQPIS,             '+
            '  DEF_BASCOF,             '+
            '  DEF_BASPIS,             '+
            '  DEF_CBCCRE,             '+
            '  DEF_CODCTA,             '+
            '  DEF_CODEMP,             '+
            '  DEF_CSTCOF,             '+
            '  DEF_CSTPIS,             '+
            '  DEF_DTAOPE,             '+
            '  DEF_INDORI,             '+
            '  DEF_OBSDOP,             '+
            '  DEF_TIP_FC,             '+
            '  DEF_VALCOF,             '+
            '  DEF_VALOPE,             '+
            '  DEF_VALPIS,             '+
            '  DEF_CODPAR,             '+
            '  DEF_NUMDUP,             '+
            '  DEF_PARCEL,             '+
            '  DEF_SERIE_,             '+
            '  DEF_EMPDUP,             '+
            '  DEF_FORDUP,             '+
            '  DEF_SEQBAI,             '+
            '  DEF_CODCCA              '+
            ')                         '+
            'VALUES                    '+
            '  (                       '+
            '    :AUTOINCREM,          '+
            '    :DEF_ALQCOF,          '+
            '    :DEF_ALQPIS,          '+
            '    :DEF_BASCOF,          '+
            '    :DEF_BASPIS,          '+
            '    :DEF_CBCCRE,          '+
            '    :DEF_CODCTA,          '+
            '    :DEF_CODEMP,          '+
            '    :DEF_CSTCOF,          '+
            '    :DEF_CSTPIS,          '+
            '    :DEF_DTAOPE,          '+
            '    :DEF_INDORI,          '+
            '    :DEF_OBSDOP,          '+
            '    :DEF_TIP_FC,          '+
            '    :DEF_VALCOF,          '+
            '    :DEF_VALOPE,          '+
            '    :DEF_VALPIS,          '+
            '    :DEF_CODPAR,          '+
            '    :DEF_NUMDUP,          '+
            '    :DEF_PARCEL,          '+
            '    :DEF_SERIE_,          '+
            '    :DEF_EMPDUP,          '+
            '    :DEF_FORDUP,          '+
            '    :DEF_SEQBAI,          '+
            '    :DEF_CODCCA           '+
            '  )                       ';
end;

end.
