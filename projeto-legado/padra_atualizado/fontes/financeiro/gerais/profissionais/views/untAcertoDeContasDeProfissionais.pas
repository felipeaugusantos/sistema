unit untAcertoDeContasDeProfissionais;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore,
  cxDateUtils, cxCurrencyEdit, CurrencyEditFocus, QColorLabel, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, EditFocus, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Uni, UniClientDataset,
  System.StrUtils, untTAcertoDeContasDeProfissionais, cxButtonEdit,
  cxEditRepositoryItems, untTypesSistema, cxProgressBar, untMostraDebCtrChq2;

type
  TfrmAcertoDeContasDeProfissionais = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    grpDadosDaComissao: TGroupBox;
    lblProfissional: TLabel;
    edtCodigoProfissional: TEditFocus;
    edtNomeProfissional: TEditFocus;
    lblPeriodoFaturamento: TLabel;
    edtDataInicial: TcxDateEdit;
    lblPeriodoFaturamentoA: TLabel;
    edtDataFinal: TcxDateEdit;
    btnCarregar: TBitBtnLocked;
    lblEmpresa: TLabel;
    edtCodigoEmpresa: TEditFocus;
    edtNomeEmpresa: TEditFocus;
    lblProfCartao: TLabel;
    edtProfissionaisCartao: TEditFocus;
    lblProfCartaoValores: TColorLabel;
    grpDadosDoContasAPagar: TGroupBox;
    grpDadosDoContasAReceber: TGroupBox;
    lblComissaoAPagar: TLabel;
    edtComissaoAPagar: TCurrencyEditFocus;
    lblTitulos: TLabel;
    edtTitulos: TEditFocus;
    lblTitulosValores: TColorLabel;
    pnlBotoesBaixa: TPanel;
    FlwPnlBotoesbaixa: TFlowPanel;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    btnSairBaixa: TBitBtnLocked;
    pnlDadosGrid: TPanel;
    grdProfissionais: TcxGridCitel;
    grdProfissionaisDados: TcxGridDBTableViewCitel;
    grdProfissionaisNivel: TcxGridLevel;
    dtsComissoes: TDataSource;
    grdProfissionaisDadosDIV_CODDIV: TcxGridDBColumn;
    grdProfissionaisDadosDIV_NOMDIV: TcxGridDBColumn;
    grdProfissionaisDadosTOTALCOMISSOES: TcxGridDBColumn;
    cxrEstilosCamposGrid: TcxEditRepository;
    btnListaComissoes: TcxEditRepositoryButtonItem;
    grdProfissionaisDadosTOTALCTR: TcxGridDBColumn;
    grdProfissionaisDadosQTDECOMISSOES: TcxGridDBColumn;
    grdProfissionaisDadosQTDECLIENTES: TcxGridDBColumn;
    grdProfissionaisDadosCOMISSAOAPAGAR: TcxGridDBColumn;
    grdProfissionaisDadosSALDOFINAL: TcxGridDBColumn;
    grdProfissionaisDadosMARCADO: TcxGridDBColumn;
    btnTotalCtr: TcxEditRepositoryButtonItem;
    grdProfissionaisDadosDIV_CODFOR: TcxGridDBColumn;
    grdProfissionaisDadosDIV_CODCLI: TcxGridDBColumn;
    btnRecalcularJuros: TBitBtnLocked;
    btnManutencaoDiversos: TBitBtnLocked;
    pnlTotais: TPanel;
    lblTotalComissoes: TLabel;
    lblQtdeProfissionais: TLabel;
    edtQtdProfissionais: TEditFocus;
    edtValorTotal: TEditFocus;
    lblTotalCTR: TLabel;
    edtValorTotalCTR: TEditFocus;
    lblTotalComissaoAPagar: TLabel;
    edtValorTotalComissaoAPagar: TEditFocus;
    pnlLegendas: TPanel;
    grpLegenda: TGroupBox;
    shpMarcados: TShape;
    lblMarcadosTexto: TLabel;
    shpDesmarcados: TShape;
    lblDesmarcadosTexto: TLabel;
    lblMarcadosLetra: TLabel;
    lblDesmarcadosLetra: TLabel;
    shpCadastro: TShape;
    lblCadastroTexto: TLabel;
    lblCadastroLetra: TLabel;
    procedure edtCodigoEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoProfissionalKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCarregarClick(Sender: TObject);
    procedure btnSairBaixaClick(Sender: TObject);
    procedure btnListaComissoesPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnTotalCtrPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure grdProfissionaisDadosCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure grdProfissionaisDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnManutencaoDiversosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnRecalcularJurosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FDatasetComissoes: TUniClientDataset;

    FObjetoAcerto: TAcertoDeContasDeProfissionais;

    FObjetoFiltros: TCamposFiltroTela;

    FArrayEmpresas,
    FArrayDiversos: TConsultasArray;

    FOperadorDireitoBaixa: Boolean;

    FLayoutDefault: TMemoryStream;

    procedure CarregaEmpresa;
    procedure CarregaProfissional;

    procedure CriaTemporaria;

    procedure SelecionarProfissional;

    function MarcarTodos(pgbStatus: TcxProgressBar = Nil): Boolean;
    function DesmarcarTodos(pgbStatus: TcxProgressBar = Nil): Boolean;

    procedure ExibeTotais;

    function ValidacoesConfirmar: Boolean;
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmAcertoDeContasDeProfissionais: TfrmAcertoDeContasDeProfissionais;

implementation
Uses untConsultas, untPesqAux, untFuncoesSimples, untGravando,
     untAcertoDeContasDeProfissionaisLista, untFuncoesAuxiliares,
     untDocumento, untIDocumento, untCadDiversos, untBaixaCtrAnalitica,
     untBaixaProfiss, untCtrRecalculoJuros;
{$R *.dfm}

procedure TfrmAcertoDeContasDeProfissionais.btnCarregarClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  TfrmGravando.fExecutarModal(CriaTemporaria,'Aguarde... Validando Profissionais.','');
end;

procedure TfrmAcertoDeContasDeProfissionais.btnConfirmarClick(Sender: TObject);
  Var
    frmBaixaCtrAnalitica: TfrmBaixaCtrAnalitica;

    frmBaixaProfiss: TfrmBaixaProfiss;
begin
  inherited;

  If Not ValidacoesConfirmar Then
    Exit;

  Try
    FObjetoAcerto.DatasetGrid := fCriaClientDatSet(FDatasetComissoes);
    FObjetoAcerto.FiltrosSelecionados := FObjetoFiltros;

    FObjetoAcerto.DatasetGrid.Filter := 'MARCADO=''S'' AND TOTALCTR>0';
    FObjetoAcerto.DatasetGrid.Filtered := True;

    If Not FObjetoAcerto.DatasetGrid.IsEmpty Then
    Begin
      //Dados baixa receber
      pCriarFormularios(TfrmBaixaCtrAnalitica, frmBaixaCtrAnalitica);
      frmBaixaCtrAnalitica.Caption := 'Dados Baixa Contas a Receber';
      frmBaixaCtrAnalitica.edtHisBai.Text := 'TÍTULO BAIXADO PELA ROTINA DE ACERTO DE CONTAS DE PROFISSIONAIS';
      frmBaixaCtrAnalitica.lblHist2.Visible := False;
      frmBaixaCtrAnalitica.edtHist02.Visible := False;
      frmBaixaCtrAnalitica.ShowModal;

      If Not frmBaixaCtrAnalitica.blnConfirma Then
        Exit;

      FObjetoAcerto.HistoricoCTR := frmBaixaCtrAnalitica.edtHisBai.Text;
      FObjetoAcerto.PortadorCTR := frmBaixaCtrAnalitica.edtPorBai.Text;
      FObjetoAcerto.PlanoDeContasCTR := frmBaixaCtrAnalitica.fraPlanoDeContas.mskCodCta.Text;
    End;

    FObjetoAcerto.DatasetGrid.Filter := 'MARCADO=''S'' AND COMISSAOAPAGAR>0';
    FObjetoAcerto.DatasetGrid.Filtered := True;

    If Not FObjetoAcerto.DatasetGrid.IsEmpty Then
    Begin
      //Dados baixa pagar
      pCriarFormularios(TfrmBaixaProfiss, frmBaixaProfiss);
      frmBaixaProfiss.Caption := 'Dados Baixa Contas a Pagar';
      frmBaixaProfiss.cbxLanCTP.Enabled := False;
      frmBaixaProfiss.Label2.Visible := False;
      frmBaixaProfiss.edtCodFor.Visible := False;
      frmBaixaProfiss.edtNomFor.Visible := False;
      frmBaixaProfiss.edtHisBai.Text := 'TÍTULO GERADO E BAIXADO PELA ROTINA DE ACERTO DE CONTAS DE PROFISSIONAIS';
      frmBaixaProfiss.ShowModal;

      If frmBaixaProfiss.ModalResult <> mrOK Then
        Exit;

      FObjetoAcerto.HistoricoCTP := frmBaixaProfiss.edtHisBai.Text;
      FObjetoAcerto.PortadorCTP := frmBaixaProfiss.edtCodPor.Text;
      FObjetoAcerto.PlanoDeContasCTP := frmBaixaProfiss.fraPlanoDeContas.mskCodCta.Text;
      FObjetoAcerto.CentroDeCustosCTP := frmBaixaProfiss.edtCodEve.Text;
    End;

    FObjetoAcerto.DatasetGrid.Filter := '';
    FObjetoAcerto.DatasetGrid.Filtered := False;

    Try
      pCriarFormularios(TfrmGravando,frmGravando);
      frmGravando.fExecutarAcao := FObjetoAcerto.RealizarBaixaDosRegistros;
      frmGravando.lblGravando.Caption := 'Aguarde... Baixando registros.';
      frmGravando.ShowModal;

      If frmGravando.blnConfirma Then
      Begin
        fMensagem('AVISO', 'Baixa realizada com sucesso.', ['&Ok']);
        btnCarregar.Click;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro('Ocorreu um erro ao baixar os registros.' + #13 +
                       'Erro gerado: ' + E.Message, '[TfrmAcertoDeContasDeProfissionais.btnConfirmarClick]');
      End;
    End;
  Finally
    FreeAndNil(frmGravando);

    If Assigned(frmBaixaCtrAnalitica) Then
      FreeAndNil(frmBaixaCtrAnalitica);

    If Assigned(frmBaixaProfiss) Then
      FreeAndNil(frmBaixaProfiss);
  End;
end;

procedure TfrmAcertoDeContasDeProfissionais.btnDesmarcarTodosClick(
  Sender: TObject);
begin
  inherited;
  If Not btnDesmarcarTodos.Enabled Then
    Exit;

  If FDatasetComissoes.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'Não existe registros para desmarcar.', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.fExecutarAcao := DesmarcarTodos;
    frmGravando.lblGravando.Caption := 'Aguarde... Desmarcando registros.';
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

procedure TfrmAcertoDeContasDeProfissionais.btnListaComissoesPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pCriarFormularios(TfrmAcertoDeContasDeProfissionaisLista, frmAcertoDeContasDeProfissionaisLista);
  frmAcertoDeContasDeProfissionaisLista.ObjetoFiltros := FObjetoFiltros;
  frmAcertoDeContasDeProfissionaisLista.CodigoProfissional := FDatasetComissoes.FieldByName('DIV_CODDIV').AsString;
  frmAcertoDeContasDeProfissionaisLista.ShowModal;

  FreeAndNil(frmAcertoDeContasDeProfissionaisLista);
end;

procedure TfrmAcertoDeContasDeProfissionais.btnManutencaoDiversosClick(
  Sender: TObject);
  Var
    frmCadDiversos: TfrmCadDiversos;
begin
  inherited;
  If FDatasetComissoes.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'Não existe registro selecionado para utilizar essa função.', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmCadDiversos, frmCadDiversos);
    frmCadDiversos.strCodDiversosIniciarCadastro := FDatasetComissoes.FieldByName('DIV_CODDIV').AsString;
    frmCadDiversos.ShowModal;
  Finally
    FreeAndNil(frmCadDiversos);

    btnCarregar.Click;
  End;
end;

procedure TfrmAcertoDeContasDeProfissionais.btnMarcarTodosClick(
  Sender: TObject);
begin
  inherited;
  If Not btnMarcarTodos.Enabled Then
    Exit;

  If FDatasetComissoes.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'Não existe registros para marcar.', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.fExecutarAcao := MarcarTodos;
    frmGravando.lblGravando.Caption := 'Aguarde... Marcando registros.';
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

procedure TfrmAcertoDeContasDeProfissionais.btnRecalcularJurosClick(
  Sender: TObject);
  Var
    LprcScroll: TprcScroll;

    frmCtrRecalculoJuros: TfrmCtrRecalculoJuros;
begin
  inherited;
  If Not btnRecalcularJuros.Enabled Then
    Exit;

  If FDatasetComissoes.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário carregar ao menos um registro!', ['&Ok']);
    Exit;
  End;

  If Not fVerificaAcessoSistema('CTRSJU', strLoginUsuarioLogado) Then
  Begin
    fMensagem('ATENÇÃO!', 'O operador não possui direito de acesso para recalcular os juros!', ['&Ok']);
    Exit;
  End;

  Application.ProcessMessages;
  Screen.Cursor := crHourGlass;

  Try
    pDisableControls(FDatasetComissoes, LprcScroll);

    If FDatasetComissoes.Locate('MARCADO', 'S', []) Then
    Begin
      fMensagem('ATENÇÃO', 'Nenhum registro pode estar marcado para utilizar essa função.', ['&Ok']);
      Exit;
    End;

    pCriarFormularios(TfrmCtrRecalculoJuros, frmCtrRecalculoJuros);
    frmCtrRecalculoJuros.blnPerMulta := True;
    frmCtrRecalculoJuros.ShowModal;

    If Not frmCtrRecalculoJuros.blnConfirma Then
      Exit;

    FObjetoAcerto.PercentualJuros := fStrToFloat(frmCtrRecalculoJuros.edtPerJur.Text);
    FObjetoAcerto.PercentualMulta := fStrToFloat(frmCtrRecalculoJuros.edtPerMul.Text);
    FObjetoAcerto.TodasAsComissoes := frmCtrRecalculoJuros.edtAplJur.Text = 'T';
    FObjetoAcerto.DatasetGrid := FDatasetComissoes;
    FObjetoAcerto.FiltrosSelecionados := FObjetoFiltros;

    TfrmGravando.fExecutarModal(FObjetoAcerto.RecalcularJuros,'Aguarde... Recalculando Juros.','');
  Finally
    pEnableControls(FDatasetComissoes, LprcScroll);

    Screen.Cursor := crDefault;

    pFreeAndNil(frmCtrRecalculoJuros);
  End;
end;

procedure TfrmAcertoDeContasDeProfissionais.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmAcertoDeContasDeProfissionais.btnTotalCtrPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  var
    documento: IDocumento;
begin
  inherited;

  documento := TDocumento.Create;

  TfrmMostraDebCtrChq2.pMostraContaCorrente(FDatasetComissoes.FieldByName('DIV_CODCLI').AsString,
                                            'A',
                                            False,
                                            edtTitulos.Text = 'A',
                                            False,
                                            'A',
                                            documento,
                                            True);
end;

procedure TfrmAcertoDeContasDeProfissionais.CarregaEmpresa;
begin
  edtNomeEmpresa.Text := 'TODAS';

  If Not fEmptyStr(edtCodigoEmpresa.Text) Then
  Begin
    If Length(FArrayEmpresas) > 1 Then
      edtNomeEmpresa.Text := '+1'
    Else
      edtNomeEmpresa.Text := fRetNomeEmpresa(edtCodigoEmpresa.Text);
  End;
end;

procedure TfrmAcertoDeContasDeProfissionais.CarregaProfissional;
begin
  edtNomeProfissional.Text := 'TODOS';

  If Not fEmptyStr(edtCodigoProfissional.Text) Then
  Begin
    If Length(FArrayDiversos) > 1 Then
      edtNomeProfissional.Text := '+1'
    Else
      edtNomeProfissional.Text := fRetNomProfissional(edtCodigoProfissional.Text);
  End;
end;

procedure TfrmAcertoDeContasDeProfissionais.CriaTemporaria;
begin
  FObjetoFiltros.CodigoEmpresa := IIF(Not fEmptyStr(edtCodigoEmpresa.Text),
                                      '"' + edtCodigoEmpresa.Text + '"',
                                      '');
  If edtNomeEmpresa.Text = '+1' Then
    FObjetoFiltros.CodigoEmpresa := fRetArrToSQLIn(FArrayEmpresas, edtCodigoEmpresa.Text);

  FObjetoFiltros.CodigoProfissional := IIF(Not fEmptyStr(edtCodigoProfissional.Text),
                                           '"' + edtCodigoProfissional.Text + '"',
                                           '');
  If edtNomeProfissional.Text = '+1' Then
    FObjetoFiltros.CodigoProfissional := fRetArrToSQLIn(FArrayDiversos, edtCodigoProfissional.Text);

  FObjetoFiltros.ProfissionaisComCartao := edtProfissionaisCartao.Text;

  FObjetoFiltros.DataInicial := edtDataInicial.Date;
  FObjetoFiltros.DataFinal := edtDataFinal.Date;

  FObjetoFiltros.ComissaoAPagar := edtComissaoAPagar.Value;

  FObjetoFiltros.Titulos := edtTitulos.Text;

  FDatasetComissoes := FObjetoAcerto.RetornaDadosFiltradosComissoes(FObjetoFiltros);
  dtsComissoes.Dataset := FDatasetComissoes;
  dtsComissoes.AutoEdit := True;

  ExibeTotais;
end;

function TfrmAcertoDeContasDeProfissionais.DesmarcarTodos(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    LprcScroll: TprcScroll;
begin
  Result := True;

  pDisableControls(FDatasetComissoes, LprcScroll);

  Try
    pgbStatus.Properties.Max := FDatasetComissoes.RecordCount;
    pgbStatus.Position := 0;

    FDatasetComissoes.First;
    While Not FDatasetComissoes.Eof Do
    Begin
      pStepStatusGravacao(pgbStatus);

      FDatasetComissoes.Edit;
      FDatasetComissoes.FieldByName('MARCADO').AsString := 'N';
      FDatasetComissoes.FieldByName('QTDMARCADO').AsInteger := 0;
      FDatasetComissoes.FieldByName('COMISSAOMARCADO').AsFloat := 0.00;
      FDatasetComissoes.FieldByName('CTRMARCADO').AsFloat := 0.00;
      FDatasetComissoes.FieldByName('PAGARCARCADO').AsFloat := 0.00;
      FDatasetComissoes.Post;

      FDatasetComissoes.Next;

    End;
    FDatasetComissoes.First;
  Finally
    pEnableControls(FDatasetComissoes, LprcScroll);
  End;
end;

procedure TfrmAcertoDeContasDeProfissionais.edtCodigoEmpresaKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodigoEmpresa, edtNomeEmpresa, Nil, Key, FArrayEmpresas, False, True) Then
  Begin
    If fValidaCampos(edtCodigoEmpresa) Then
      SelectNext((ActiveControl), True, True);
  End;
end;

procedure TfrmAcertoDeContasDeProfissionais.edtCodigoProfissionalKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  {*****************************}
  {* NOVA CONSULTA DE DIVERSOS *}
  {**************************DP*}
  If fPesqDiversos(Self, edtCodigoProfissional, edtNomeProfissional, Nil, Key, FArrayDiversos, False) Then
  Begin
    If fValidaCampos(edtCodigoProfissional, True) Then
      SelectNext((ActiveControl), True, True);
  End;
end;

procedure TfrmAcertoDeContasDeProfissionais.ExibeTotais;
begin
  edtQtdProfissionais.Text := VarToStr(grdProfissionaisDados.DataController.Summary.FooterSummaryValues[0]);
  edtValorTotal.Text := FormatFloat(',0.00;-0.00', fStrToFloat(VarToStr(grdProfissionaisDados.DataController.Summary.FooterSummaryValues[1])));
  edtValorTotalCTR.Text := FormatFloat(',0.00;-0.00', fStrToFloat(VarToStr(grdProfissionaisDados.DataController.Summary.FooterSummaryValues[2])));
  edtValorTotalComissaoAPagar.Text := FormatFloat(',0.00;-0.00', fStrToFloat(VarToStr(grdProfissionaisDados.DataController.Summary.FooterSummaryValues[3])));
end;

procedure TfrmAcertoDeContasDeProfissionais.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(FLayoutDefault);
  fGetFuncoesCxGrid.pSalvarView(grdProfissionaisDados, Self.Name + '.' + grdProfissionaisDados.Name, FDatasetComissoes);

  FreeAndNil(FDatasetComissoes);
  FreeAndNil(FObjetoAcerto);
end;

procedure TfrmAcertoDeContasDeProfissionais.FormCreate(Sender: TObject);
begin
  inherited;

  FObjetoAcerto := TAcertoDeContasDeProfissionais.Create;

  FDatasetComissoes := FObjetoAcerto.RetornaDadosFiltradosComissoes(FObjetoFiltros, True);
  dtsComissoes.Dataset := FDatasetComissoes;

  FOperadorDireitoBaixa := fVerificaAcessoSistema('BAIXAACERTOCONTASPROF', strLoginUsuarioLogado);

  FLayoutDefault := TMemoryStream.Create;
end;

procedure TfrmAcertoDeContasDeProfissionais.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F7: btnMarcarTodos.Click;
    VK_F8: btnDesmarcarTodos.Click;
    VK_F10: btnConfirmar.Click;
    VK_F11: btnRecalcularJuros.Click;
    VK_F12: btnManutencaoDiversos.Click;
  End;
end;

procedure TfrmAcertoDeContasDeProfissionais.FormShow(Sender: TObject);
  Var
    LRegistro: Integer;
begin
  inherited;

  ExibeTotais;

  pSetFocus(edtCodigoEmpresa);

  btnRecalcularJuros.Enabled := fVerificaAcessoSistema('CTRSJU', strLoginUsuarioLogado);

  btnMarcarTodos.Enabled := FOperadorDireitoBaixa;
  btnDesmarcarTodos.Enabled := FOperadorDireitoBaixa;
  btnConfirmar.Enabled := FOperadorDireitoBaixa;

  grdProfissionaisDados.StoreToStream(FLayoutDefault);
  fGetFuncoesCxGrid.fCarregarView((grdProfissionaisDados as TcxGridDBTableView), Self.Name + '.' + grdProfissionaisDados.Name, FDatasetComissoes, LRegistro);
end;

function TfrmAcertoDeContasDeProfissionais.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodigoEmpresa) Then
    Begin
      CarregaEmpresa;

      If Not fEmptyStr(edtCodigoEmpresa.Text) Then
      Begin
        If Not MatchStr(edtNomeEmpresa.Text, ['TODAS', '+1']) Then
        Begin
          If fEmptyStr(edtNomeEmpresa.Text) Then
          Begin
            fMensagem('ATENÇÃO','O código da empresa não está cadastrado!',['&OK']);
            Result := False;
          End
          Else If Pos(edtCodigoEmpresa.Text, strEmpAcessoUsuarioLogado) = 0 Then
          Begin
            fMensagem('ATENÇÃO','O operador não possui acesso a empresa selecionada!',['&OK']);
            Result := False;
          End;
        End;
      End;

    End
    Else If (Sender = edtCodigoProfissional) Then
    Begin
      CarregaProfissional;

      If Not MatchStr(edtNomeProfissional.Text, ['TODOS', '+1']) Then
      Begin
        If fEmptyStr(edtNomeProfissional.Text) Then
        Begin
          fMensagem('ATENÇÃO','Profissional não encontrado!',['&OK']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtDataFinal) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(edtDataFinal.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'A Data Final do período deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If StrToDateDef(edtDataFinal.Text, 0) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'A Data Final do período informada é inválida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If fEmptyStr(fTiraCaracEspeciais(edtDataInicial.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'A Data Inicial do período deve ser preenchida!', ['&Ok']);
          Result := False;
          Sender := edtDataInicial;
        End
        Else
        Begin
          If StrToDate(edtDataInicial.Text) > StrToDate(edtDataFinal.Text) Then
          Begin
            fMensagem('ATENÇÃO','A Data Inicial deve ser menor que a Data Final do período!',['&OK']);
            Result := False;
            Sender := edtDataInicial;
          End;
        End;
      End;
    End

    Else If (Sender = edtDataInicial) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(edtDataInicial.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'A Data Inicial do período deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If StrToDateDef(edtDataInicial.Text, 0) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'A Data Inicial do período informada é inválida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtProfissionaisCartao) Then
    Begin
      If Not MatchStr(edtProfissionaisCartao.Text, ['S', 'N', 'T']) Then
      Begin
        fMensagem('ATENÇÃO', 'O campo Profissionais com Cartão deve ser preenchido com "S", "N" ou "T"!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtComissaoAPagar) Then
    Begin
      If edtComissaoAPagar.Value < 0 Then
      Begin
        fMensagem('ATENÇÃO', 'O campo "Exibir Apenas Comissão cqye tenha "Contas a Pagar" Acima De" deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtTitulos) Then
    Begin
      If Not MatchStr(edtTitulos.Text, ['V', 'A', 'T']) Then
      Begin
        fMensagem('ATENÇÃO', 'O campo Títulos deve ser preenchido com "V", "A" ou "T"!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmAcertoDeContasDeProfissionais.grdProfissionaisDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    LMarcado,
    LFornecedor,
    LCliente: String;
begin
  inherited;

  If Not FDatasetComissoes.Active Then
    Exit;

  If FDatasetComissoes.IsEmpty Then
    Exit;

  LMarcado := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdProfissionaisDadosMARCADO.Index]);
  LFornecedor := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdProfissionaisDadosDIV_CODFOR.Index]);
  LCliente := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdProfissionaisDadosDIV_CODCLI.Index]);

  If LMarcado = 'S' Then
    ACanvas.Font.Color := clBlue
  Else If Concat(LFornecedor, LCliente).Length < 16 Then
    ACanvas.Font.Color := clRed;
end;

procedure TfrmAcertoDeContasDeProfissionais.grdProfissionaisDadosKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Return Then
    SelecionarProfissional;
end;

function TfrmAcertoDeContasDeProfissionais.MarcarTodos(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    LProfissionaisCadastroIncompleto: Boolean;

    LprcScroll: TprcScroll;
begin
  Result := True;

  LProfissionaisCadastroIncompleto := False;

  pDisableControls(FDatasetComissoes, LprcScroll);

  Try
    pgbStatus.Properties.Max := FDatasetComissoes.RecordCount;
    pgbStatus.Position := 0;

    FDatasetComissoes.First;
    While Not FDatasetComissoes.Eof Do
    Begin
      pStepStatusGravacao(pgbStatus);

      If Concat(FDatasetComissoes.FieldByName('DIV_CODCLI').AsString,
                FDatasetComissoes.FieldByName('DIV_CODFOR').AsString).Length < 16 Then
      Begin
        LProfissionaisCadastroIncompleto := True;
        FDatasetComissoes.Next;
        Continue;
      End;

      FDatasetComissoes.Edit;
      FDatasetComissoes.FieldByName('MARCADO').AsString := 'S';
      FDatasetComissoes.FieldByName('QTDMARCADO').AsInteger := 1;
      FDatasetComissoes.FieldByName('COMISSAOMARCADO').AsFloat := FDatasetComissoes.FieldByName('TOTALCOMISSOES').AsFloat;
      FDatasetComissoes.FieldByName('CTRMARCADO').AsFloat := FDatasetComissoes.FieldByName('TOTALCTR').AsFloat;
      FDatasetComissoes.FieldByName('PAGARCARCADO').AsFloat := FDatasetComissoes.FieldByName('COMISSAOAPAGAR').AsFloat;
      FDatasetComissoes.Post;

      FDatasetComissoes.Next;

    End;
    FDatasetComissoes.First;

    If LProfissionaisCadastroIncompleto Then
      fMensagem('ATENÇÃO', 'Alguns registros não foram selecionados pois possuem '  +
                           'profissionais com o cadastro incompleto.', ['&Ok']);
  Finally
    pEnableControls(FDatasetComissoes, LprcScroll);
  End;
end;

procedure TfrmAcertoDeContasDeProfissionais.SelecionarProfissional;
begin
  If FDatasetComissoes.IsEmpty Then
    Exit;

  If Not FOperadorDireitoBaixa Then
    Exit;

  If Concat(FDatasetComissoes.FieldByName('DIV_CODCLI').AsString,
            FDatasetComissoes.FieldByName('DIV_CODFOR').AsString).Length < 16 Then
  Begin
    fMensagem('ATENÇÃO', 'O cadastro do Profissional deve possuir o Cliente e o Fornecedor vinculados.' + #13 +
                         'Abra o cadastro do profissionais e complete os campos.', ['&Ok']);
    Exit;
  End;

  FDatasetComissoes.Edit;
  FDatasetComissoes.FieldByName('QTDMARCADO').AsInteger := 0;
  FDatasetComissoes.FieldByName('COMISSAOMARCADO').AsFloat := 0.00;
  FDatasetComissoes.FieldByName('CTRMARCADO').AsFloat := 0.00;
  FDatasetComissoes.FieldByName('PAGARCARCADO').AsFloat := 0.00;

  If FDatasetComissoes.FieldByName('MARCADO').AsString = 'S' Then
    FDatasetComissoes.FieldByName('MARCADO').AsString := 'N'
  Else
  Begin
    FDatasetComissoes.FieldByName('MARCADO').AsString := 'S';
    FDatasetComissoes.FieldByName('QTDMARCADO').AsInteger := 1;
    FDatasetComissoes.FieldByName('COMISSAOMARCADO').AsFloat := FDatasetComissoes.FieldByName('TOTALCOMISSOES').AsFloat;
    FDatasetComissoes.FieldByName('CTRMARCADO').AsFloat := FDatasetComissoes.FieldByName('TOTALCTR').AsFloat;
    FDatasetComissoes.FieldByName('PAGARCARCADO').AsFloat := FDatasetComissoes.FieldByName('COMISSAOAPAGAR').AsFloat;
  End;
  FDatasetComissoes.Post;

  ExibeTotais;
end;

function TfrmAcertoDeContasDeProfissionais.ValidacoesConfirmar: Boolean;
begin
  Result := True;

  If Not btnConfirmar.Enabled Then
    Exit(False);

  If FDatasetComissoes.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário carregar ao menos um registro!', ['&Ok']);
    Exit(False);
  End;

  If Not FDatasetComissoes.Locate('MARCADO', 'S', []) Then
  Begin
    fMensagem('ATENÇÃO', 'Deve marcar os registros que serão baixados antes de continuar.', ['&Ok']);
    Exit(False);
  End;

  If fMensagem('ATENÇÃO', 'Deseja realmente baixar os registros selecionados?', ['&Sim', '&Não']) = 2 Then
    Exit(False);
end;

end.
