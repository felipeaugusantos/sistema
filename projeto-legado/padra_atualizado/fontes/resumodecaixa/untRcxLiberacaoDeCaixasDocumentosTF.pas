unit untRcxLiberacaoDeCaixasDocumentosTF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCurrencyEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid,
  Uni, UniClientDataset, cxCalendar, EditFocus, cxProgressBar;

Type
  TTipoRegistro = (tprCartoes, tprChequesAVista, tprChequesPre);

type
  TfrmRcxLiberacaoDeCaixasDocumentosTF = class(TfrmPai)
    btnEditarDocumento: TBitBtnLocked;
    pnlFundo: TPanel;
    grdLancamentos: TcxGridCitel;
    grdLancamentosDadosCartoes: TcxGridDBTableViewCitel;
    grdLancamentosDadosCartoesDOCUMENTO: TcxGridDBColumn;
    grdLancamentosDadosCartoesPARCELAS: TcxGridDBColumn;
    grdLancamentosDadosCartoesCAR_DESCAR: TcxGridDBColumn;
    grdLancamentosDadosCartoesVALOR: TcxGridDBColumn;
    grdLancamentosNivelCartoes: TcxGridLevel;
    grdLancamentosNivelCheques: TcxGridLevel;
    grdLancamentosDadosCheques: TcxGridDBTableViewCitel;
    grdLancamentosDadosCartoesMCA_CODCLI: TcxGridDBColumn;
    grdLancamentosDadosCartoesCLI_NOMCLI: TcxGridDBColumn;
    grdLancamentosDadosCartoesMCA_DTACAD: TcxGridDBColumn;
    grdLancamentosDadosCartoesMCA_DTAVEN: TcxGridDBColumn;
    grdLancamentosDadosCartoesMCA_NUMCCD: TcxGridDBColumn;
    grdLancamentosDadosCartoesMCA_NUMNSU: TcxGridDBColumn;
    grdLancamentosDadosCartoesMCA_DOCUME: TcxGridDBColumn;
    grdLancamentosDadosChequesCHQ_CODBCO: TcxGridDBColumn;
    grdLancamentosDadosChequesCHQ_NUMAGE: TcxGridDBColumn;
    grdLancamentosDadosChequesCHQ_CONCOR: TcxGridDBColumn;
    grdLancamentosDadosChequesCHQ_NUMCHQ: TcxGridDBColumn;
    grdLancamentosDadosChequesCHQ_CODCLI: TcxGridDBColumn;
    grdLancamentosDadosChequesCHQ_NOMEMI: TcxGridDBColumn;
    grdLancamentosDadosChequesCHQ_VALCHQ: TcxGridDBColumn;
    grdLancamentosDadosChequesCHQ_DTACAD: TcxGridDBColumn;
    grdLancamentosDadosChequesCHQ_DTAVEN: TcxGridDBColumn;
    pnlTail: TPanel;
    lblValorTotal: TLabel;
    lblTotalSelecionados: TLabel;
    edtTotalSelecionados: TEditFocus;
    edtValorTotal: TEditFocus;
    grdLancamentosDadosCartoesVALORSELECIONADO: TcxGridDBColumn;
    grdLancamentosDadosCartoesSELECIONADO: TcxGridDBColumn;
    grdLancamentosDadosChequesVALORSELECIONADO: TcxGridDBColumn;
    grdLancamentosDadosChequesSELECIONADO: TcxGridDBColumn;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    dtsLancamentos: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEditarDocumentoClick(Sender: TObject);
    procedure grdLancamentosDadosCartoesCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure grdLancamentosDadosChequesCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure grdLancamentosDadosCartoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FDatasetRegistros: TUniClientDataset;

    FTipoDoRegistro: TTipoRegistro;

    FCodigoCaixa,
    FSequencialControle,
    FOperador,
    FCodigoEmpresa: String;

    FValorSelecionado: Double;

    function RetornaSQLCartoes: String;
    function RetornaSQLCheques(ATipoCheque: TTipoRegistro): String;

    procedure CriaTemporaria;

    procedure SelecionarRegistro(ASelecionar: Boolean = True);

    function MarcarTodos(prgStatus: TcxProgressBar): Boolean;
    function DesmarcarTodos(prgStatus: TcxProgressBar): Boolean;

    procedure ExibeTotal(AZerado: Boolean = False);

    function RetornaTextoTipoRegistro(ATipoRegistro: TTipoRegistro): String;
    { Private declarations }
  public
    property TipoDoRegistro: TTipoRegistro read FTipoDoRegistro write FTipoDoRegistro;

    property CodigoCaixa: String read FCodigoCaixa write FCodigoCaixa;
    property SequencialControle: String read FSequencialControle write FSequencialControle;
    property Operador: String read FOperador write FOperador;
    property CodigoEmpresa: String read FCodigoEmpresa write FCodigoEmpresa;

    property ValorSelecionado: Double read FValorSelecionado;
    { Public declarations }
  end;

var
  frmRcxLiberacaoDeCaixasDocumentosTF: TfrmRcxLiberacaoDeCaixasDocumentosTF;

implementation
Uses untFuncoesSimples, untGravando, untCadMovCartoesParcelas, untCadCheques,
     untTypesSistema, untConstantes;
{$R *.dfm}

procedure TfrmRcxLiberacaoDeCaixasDocumentosTF.btnConfirmarClick(
  Sender: TObject);
begin
  inherited;
  If FTipoDoRegistro = tprCartoes Then
    FValorSelecionado := grdLancamentosDadosCartoes.DataController.Summary.FooterSummaryValues[1]
  Else
    FValorSelecionado := grdLancamentosDadosCheques.DataController.Summary.FooterSummaryValues[1];

  Close;
end;

procedure TfrmRcxLiberacaoDeCaixasDocumentosTF.btnDesmarcarTodosClick(
  Sender: TObject);
   Var
    LGravando: TfrmGravando;
begin
  inherited;
  Try
    pCriarFormularios(TfrmGravando, LGravando);
    LGravando.fExecutarAcao := DesmarcarTodos;
    LGravando.lblGravando.Caption := 'Aguarde... Desmarcando registros.';
    LGravando.ShowModal;
  Finally
    FreeAndNil(LGravando);

    ExibeTotal;
  End;
end;

procedure TfrmRcxLiberacaoDeCaixasDocumentosTF.btnEditarDocumentoClick(
  Sender: TObject);
  Var
    LCadMovCartoesParcelas: TfrmCadMovCartoesParcelas;

begin
  inherited;
  Try
    If FTipoDoRegistro = tprCartoes Then
    Begin
      If (Not fVerificaAcessoSistema('CARALTTODAS', strLoginUsuarioLogado)) then
      Begin
        pMensagemOK('Usuário sem direito de acesso para utilizar a função.');
        Exit;
      End;

      pCriarFormularios(TfrmCadMovCartoesParcelas, LCadMovCartoesParcelas);
      LCadMovCartoesParcelas.Rotina := 'LIBERAÇÃO TRANSFERÊNCIAS';
      LCadMovCartoesParcelas.pCarregaParcelas(FDatasetRegistros.FieldByName('MCA_NUMDUP').AsString,
                                              FDatasetRegistros.FieldByName('MCA_CODCLI').AsString,
                                              FDatasetRegistros.FieldByName('MCA_CODEMP').AsString,
                                              FDatasetRegistros.FieldByName('MCA_DTACAD').AsDateTime);

      If LCadMovCartoesParcelas.blnAltPar Then
        LCadMovCartoesParcelas.ShowModal
      Else
        LCadMovCartoesParcelas.Close;

      FreeAndNil(LCadMovCartoesParcelas);
    End
    Else
    Begin
      pCriarFormularios(TfrmCadCheques, frmCadCheques);
      frmCadCheques.strAutIncCadChq := FDatasetRegistros.FieldByName('AUTOINCREM').AsString;
      frmCadCheques.Rotina := 'LIBERAÇÃO TRANSFERÊNCIAS';
      frmCadCheques.ShowModal;

      FreeAndNil(frmCadCheques);
    End;
  Finally
    TfrmGravando.fExecutarModal(CriaTemporaria, 'Aguarde... Carregando registros.', '');

    If Assigned(FDatasetRegistros) And FDatasetRegistros.IsEmpty Then
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
  End;
end;

procedure TfrmRcxLiberacaoDeCaixasDocumentosTF.btnMarcarTodosClick(
  Sender: TObject);
  Var
    LGravando: TfrmGravando;
begin
  inherited;
  Try
    pCriarFormularios(TfrmGravando, LGravando);
    LGravando.fExecutarAcao := MarcarTodos;
    LGravando.lblGravando.Caption := 'Aguarde... Marcando registros.';
    LGravando.ShowModal;
  Finally
    FreeAndNil(LGravando);

    ExibeTotal;
  End;
end;

procedure TfrmRcxLiberacaoDeCaixasDocumentosTF.CriaTemporaria;
  Var
    LConsulta: TUniQuery;
Begin
  Try
    LConsulta := fCriaQuery;

    Case FTipoDoRegistro Of
      tprCartoes: LConsulta.SQL.Text := RetornaSQLCartoes;
      tprChequesAVista: LConsulta.SQL.Text := RetornaSQLCheques(tprChequesAVista);
      tprChequesPre: LConsulta.SQL.Text := RetornaSQLCheques(tprChequesPre);
    End;

    LConsulta.Open;

    dtsLancamentos.DataSet := Nil;
    If Assigned(FDatasetRegistros) Then
      FreeAndNil(FDatasetRegistros);

    FDatasetRegistros := fCriaClientDatSet(LConsulta);
    FDatasetRegistros.First;

    grdLancamentosDadosCartoes.DataController.DataSource := Nil;
    grdLancamentosDadosCheques.DataController.DataSource := Nil;

    dtsLancamentos.DataSet := FDatasetRegistros;

    grdLancamentosNivelCartoes.Visible := FTipoDoRegistro = tprCartoes;
    grdLancamentosNivelCheques.Visible := FTipoDoRegistro In [tprChequesAVista, tprChequesPre];

    If FTipoDoRegistro = tprCartoes Then
      grdLancamentosDadosCartoes.DataController.DataSource := dtsLancamentos
    Else
      grdLancamentosDadosCheques.DataController.DataSource := dtsLancamentos;

    If FDatasetRegistros.IsEmpty Then
      fMensagem('ATENÇÃO', 'Não foi encontrado nenhum registro da transferência com sequencial ' + FSequencialControle + ' ' +
                           'do tipo "' + RetornaTextoTipoRegistro(FTipoDoRegistro) + '" ' +
                           'para o operador ' + fRetNomeOperador(FOperador) + '.' + #13 +
                           'Entre em contato com a Citel!', ['&Ok']);
  Finally
    If Assigned(LConsulta) Then
      FreeAndNil(LConsulta);

    If Assigned(FDatasetRegistros) Then
      ExibeTotal(FDatasetRegistros.IsEmpty);
  End;
end;

function TfrmRcxLiberacaoDeCaixasDocumentosTF.DesmarcarTodos(
  prgStatus: TcxProgressBar): Boolean;
  Var
    LprcScroll: TprcScroll;
begin
  pDisableControls(FDatasetRegistros, LprcScroll);

  Try
    prgStatus.Properties.Max := FDatasetRegistros.RecordCount;

    FDatasetRegistros.First;
    While Not FDatasetRegistros.Eof Do
    Begin
      SelecionarRegistro(False);

      pStepStatusGravacao(prgStatus);

      FDatasetRegistros.Next;
    End;
  Finally
    FDatasetRegistros.First;

    pEnableControls(FDatasetRegistros, LprcScroll);

    Result := True;
  End;
end;

procedure TfrmRcxLiberacaoDeCaixasDocumentosTF.ExibeTotal(AZerado: Boolean = False);
begin
  edtTotalSelecionados.Text := '0,00';
  edtValorTotal.Text := '0,00';

  If AZerado Then
    Exit;

  If FTipoDoRegistro = tprCartoes Then
  Begin
    edtValorTotal.Text := FormatFloat(',0.00', grdLancamentosDadosCartoes.DataController.Summary.FooterSummaryValues[0]);
    edtTotalSelecionados.Text := FormatFloat(',0.00', grdLancamentosDadosCartoes.DataController.Summary.FooterSummaryValues[1]);
  End
  Else
  Begin
    edtValorTotal.Text := FormatFloat(',0.00', grdLancamentosDadosCheques.DataController.Summary.FooterSummaryValues[0]);
    edtTotalSelecionados.Text := FormatFloat(',0.00', grdLancamentosDadosCheques.DataController.Summary.FooterSummaryValues[1]);
  End;
end;

procedure TfrmRcxLiberacaoDeCaixasDocumentosTF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  dtsLancamentos.DataSet := Nil;
  If Assigned(FDatasetRegistros) Then
    FreeAndNil(FDatasetRegistros);
end;

procedure TfrmRcxLiberacaoDeCaixasDocumentosTF.FormCreate(Sender: TObject);
begin
  inherited;
  grdLancamentosNivelCartoes.Visible := False;
  grdLancamentosNivelCheques.Visible := False;

  FValorSelecionado := 0;
end;

procedure TfrmRcxLiberacaoDeCaixasDocumentosTF.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F2: btnEditarDocumento.Click;
    VK_F7: btnMarcarTodos.Click;
    VK_F8: btnDesmarcarTodos.Click;
    VK_F10: btnConfirmar.Click;
  End;
end;

procedure TfrmRcxLiberacaoDeCaixasDocumentosTF.FormShow(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(CriaTemporaria, 'Aguarde... Carregando registros.', '');

  pSetFocus(grdLancamentos);

  If Assigned(FDatasetRegistros) And FDatasetRegistros.IsEmpty Then
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmRcxLiberacaoDeCaixasDocumentosTF.grdLancamentosDadosCartoesCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    LSelecionado: String;
begin
  inherited;
  If FDatasetRegistros.IsEmpty Then
    Exit;

  If Not grdLancamentosNivelCartoes.Visible Then
    Exit;

  LSelecionado := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdLancamentosDadosCartoesSELECIONADO.Index]);

  ACanvas.Font.Color := clBlack;
  If (LSelecionado = 'S') Then
    ACanvas.Font.Color := clBlue;
end;

procedure TfrmRcxLiberacaoDeCaixasDocumentosTF.grdLancamentosDadosCartoesKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
  Begin
    SelecionarRegistro(FDatasetRegistros.FieldByName('SELECIONADO').AsString = 'N');

    ExibeTotal;
  End;
end;

procedure TfrmRcxLiberacaoDeCaixasDocumentosTF.grdLancamentosDadosChequesCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    LSelecionado: String;
begin
  inherited;
  If FDatasetRegistros.IsEmpty Then
    Exit;

  If Not grdLancamentosNivelCheques.Visible Then
    Exit;

  LSelecionado := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdLancamentosDadosChequesSELECIONADO.Index]);

  ACanvas.Font.Color := clBlack;
  If (LSelecionado = 'S') Then
    ACanvas.Font.Color := clBlue;
end;

function TfrmRcxLiberacaoDeCaixasDocumentosTF.MarcarTodos(
  prgStatus: TcxProgressBar): Boolean;
  Var
    LprcScroll: TprcScroll;
begin
  pDisableControls(FDatasetRegistros, LprcScroll);

  Try
    prgStatus.Properties.Max := FDatasetRegistros.RecordCount;

    FDatasetRegistros.First;
    While Not FDatasetRegistros.Eof Do
    Begin
      SelecionarRegistro(True);

      pStepStatusGravacao(prgStatus);

      FDatasetRegistros.Next;
    End;
  Finally
    FDatasetRegistros.First;

    pEnableControls(FDatasetRegistros, LprcScroll);

    Result := True;
  End;
end;

function TfrmRcxLiberacaoDeCaixasDocumentosTF.RetornaSQLCartoes: String;
begin
  Result := 'SELECT M.AUTOINCREM, ' +
            '  M.MCA_NUMDUP, ' +
            '  COUNT(M.AUTOINCREM) AS PARCELAS, ' +
            '  M.MCA_CODCLI, ' +
            '  SUM(M.MCA_VALSTA) AS VALOR, ' +
            '  0.00 AS VALORSELECIONADO, ' +
            '  M.MCA_DTACAD, ' +
            '  M.MCA_DTAVEN, ' +
            '  M.MCA_CODCAR, ' +
            '  M.MCA_NUMCCD, ' +
            '  M.MCA_NUMNSU, ' +
            '  M.MCA_DOCUME, ' +
            '  M.MCA_CODEMP, ' +
            '  C.CAR_DESCAR, ' +
            '  "N" AS SELECIONADO, ' +
            '  CLI.CLI_NOMCLI, ' +
            '  ( ' +
            '    SELECT ' +
            '      RCX_CODOPE ' +
            '    FROM ' +
            '      CADRCXX ' +
            '    WHERE ' +
            '      RCX_SEQCON = M.MCA_SEQCON AND ' +
            '      RCX_CODEMP = M.MCA_EMPRCX AND ' +
            '      RCX_CARREC <> 0 AND ' +
            '      RCX_CODCAX = "' + FCodigoCaixa + '" AND ' +
            '      RCX_CODOPE = "' + FOperador + '" ' +
            '    ORDER BY RCX_DTACAD DESC LIMIT 1 ' +
            '  ) AS RCX_CODOPE, ' +
            '  ( ' +
            '    SELECT ' +
            '      COUNT(*) ' +
            '    FROM ' +
            '      CADRCXX ' +
            '    WHERE ' +
            '      RCX_SEQCON = M.MCA_SEQCON AND ' +
            '      RCX_CODEMP = M.MCA_EMPRCX AND ' +
            '      RCX_CARREC <> 0 AND ' +
            '      RCX_CODCAX = "' + FCodigoCaixa + '" AND ' +
            '      RCX_CODOPE = "' + FOperador + '" ' +
            '  ) AS VALRCX ' +
            'FROM ' +
            '  MOVCAR M ' +
            '  JOIN CADCAR C ON C.CAR_CODCAR=M.MCA_CODCAR ' +
            '  JOIN CADCLI CLI ON CLI.CLI_CODCLI=M.MCA_CODCLI ' +
            'WHERE ' +
            '  M.MCA_SEQTRF = ' + FSequencialControle + ' AND ' +
            '  M.MCA_EMPRCX = "' + FCodigoEmpresa + '" AND ' +
            '  M.MCA_RESCAI = 1 AND ' +
            '  M.MCA_CODCAX = "' + FCodigoCaixa + '" ' +
            ' GROUP BY ' +
            '   MCA_SEQCON, MCA_NUMDUP, MCA_CODCLI, MCA_CODEMP ' +
            'HAVING  ' +
            '  VALRCX > 0 ' +
            ' AND RCX_CODOPE = "' + FOperador + '"' +
            ' ORDER BY MCA_DTACAD, MCA_CODCLI ';
end;

function TfrmRcxLiberacaoDeCaixasDocumentosTF.RetornaSQLCheques(
  ATipoCheque: TTipoRegistro): String;
begin
  Result := 'SELECT ' +
            '  C.AUTOINCREM, ' +
            '  C.CHQ_CODBCO, ' +
            '  C.CHQ_NUMAGE, ' +
            '  C.CHQ_CONCOR, ' +
            '  C.CHQ_NUMCHQ, ' +
            '  C.CHQ_CODCLI, ' +
            '  C.CHQ_NOMEMI, ' +
            '  C.CHQ_VALCHQ, ' +
            '  0.00 AS VALORSELECIONADO, ' +
            '  C.CHQ_DTACAD, ' +
            '  C.CHQ_DTAVEN, ' +
            '  R.RCX_CODOPE, ' +
            '  "N" AS SELECIONADO ' +
            'FROM ' +
            '  CADCHQ C ' +
            '  JOIN CADRCXX R ' +
            '    ON R.RCX_SEQCON = C.CHQ_SEQCON ' +
            '    AND R.RCX_CODEMP = C.CHQ_EMPRCX ' +
            '    AND R.RCX_CODCAX = C.CHQ_CODCAX ' +
            'WHERE ' +
            '  C.CHQ_SEQTRF = ' + FSequencialControle + ' AND ' +
            '  C.CHQ_EMPRCX = "' + FCodigoEmpresa + '" AND ' +
            '  C.CHQ_RESCAI = 1 AND ' +
            IIF(ATipoCheque = tprChequesAVista,
                '  C.CHQ_DTACAD = C.CHQ_DTAVEN AND ',
                '  C.CHQ_DTACAD <> C.CHQ_DTAVEN AND ') +
            '  C.CHQ_CODCAX = "' + FCodigoCaixa + '" AND ' +
            '  R.RCX_CODOPE = "' + FOperador + '" ' +
            ' GROUP BY ' +
            '   RCX_SEQCON, CHQ_NUMAGE, CHQ_CONCOR, CHQ_NUMCHQ, CHQ_CODCLI ' +
            ' ORDER BY CHQ_DTACAD, CHQ_CODCLI ';
end;

function TfrmRcxLiberacaoDeCaixasDocumentosTF.RetornaTextoTipoRegistro(
  ATipoRegistro: TTipoRegistro): String;
begin
  Result := 'cartão';

  If ATipoRegistro = tprChequesAVista Then
    Exit('cheque à vista')
  Else If ATipoRegistro = tprChequesPre Then
    Exit('cheque pré')
end;

procedure TfrmRcxLiberacaoDeCaixasDocumentosTF.SelecionarRegistro(ASelecionar: Boolean = True);
begin
  FDatasetRegistros.Edit;
  FDatasetRegistros.FieldByName('SELECIONADO').AsString := 'N';
  FDatasetRegistros.FieldByName('VALORSELECIONADO').Value := 0.00;

  If ASelecionar Then
  Begin
    FDatasetRegistros.FieldByName('SELECIONADO').AsString := 'S';

    If FTipoDoRegistro = tprCartoes Then
      FDatasetRegistros.FieldByName('VALORSELECIONADO').Value := FDatasetRegistros.FieldByName('VALOR').Value
    Else
      FDatasetRegistros.FieldByName('VALORSELECIONADO').Value := FDatasetRegistros.FieldByName('CHQ_VALCHQ').Value;
  End;

  FDatasetRegistros.Post;
end;

end.
