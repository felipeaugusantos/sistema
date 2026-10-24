unit untB2WBaixaRecebiveisMkt;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
     System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
     Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
     Vcl.ComCtrls, Data.DB, System.ImageList, Vcl.ImgList,

     cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
     cxEdit, dxCore, cxDateUtils, EditFocus, cxTextEdit, cxMaskEdit,
     cxDropDownEdit, cxCalendar, dxGDIPlusClasses, cxStyles, cxCustomData,
     cxFilter, cxData, cxDataStorage, cxNavigator,
     cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
     cxCurrencyEdit, cxImageList, cxGridLevel, cxGridCustomTableView,
     cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxClasses,
     cxGridCustomView, cxGrid, cxButtons, cxGroupBox, dxSkinsCore,
     dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
     dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
     dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
     dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
     dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
     dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
     dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
     dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
     dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
     dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
     dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
     dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
     dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
     dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
     dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
     dxSkinXmas2008Blue, cxLabel,
     frxExportCSVTestabilidade, BitBtnLockedIncrem, frxClass,
     Uni, UniClientDataset,

     untB2WTipos, untLibCartoesPai, untB2WItemBaixaMkt,
     untConciliaRecebiveisB2W, untTB2WFuncoes,
     untLibCartoesInterfacesTipos;

type
  TfrmB2WBaixaRecebiveisMkt = class(TfrmPai)
    pnlTop: TPanel;
    lblTitulo: TLabel;
    lblSubTitulo: TLabel;
    imgLogoOperadora: TImage;
    lblDataInicial: TLabel;
    mskDtaIniConcil: TcxDateEdit;
    lblDataFinal: TLabel;
    mskDtaFinConcil: TcxDateEdit;
    pnlRecebimentos: TPanel;
    scbRecebimentos: TScrollBox;
    pnlFooter: TPanel;
    fraLancamentosVendas: TfraB2WItemBaixaMkt;
    fraLancamentosAjustes: TfraB2WItemBaixaMkt;
    fraLancamentosLiquido: TfraB2WItemBaixaMkt;
    grpListaInconsistencias: TcxGroupBox;
    pnlInconsistencias: TPanel;
    lblMensagemInconsistencia: TLabel;
    btnExpandirInconsistencias: TcxButton;
    grdNaoEncontrados: TcxGrid;
    grdNaoEncontradosDados: TcxGridDBBandedTableView;
    grdNaoEncontradosLevel1: TcxGridLevel;
    imgImagensGerais: TcxImageList;
    btnGerarRelatorio: TcxButton;
    btnConfirmarBaixa: TcxButton;
    pnlEmpresa: TPanel;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    pnlTransferencias: TPanel;
    scbTransferencias: TScrollBox;
    btnCarregarLancamentos: TcxButton;
    btnSairBaixa: TcxButton;
    grdNaoEncontradosDadosREL_NUMNSU: TcxGridDBBandedColumn;
    grdNaoEncontradosDadosREL_CODAUT: TcxGridDBBandedColumn;
    grdNaoEncontradosDadosPARCELA: TcxGridDBBandedColumn;
    grdNaoEncontradosDadosREL_DTA_CV: TcxGridDBBandedColumn;
    grdNaoEncontradosDadosREL_DTAVEN: TcxGridDBBandedColumn;
    grdNaoEncontradosDadosREL_VALBRU: TcxGridDBBandedColumn;
    grdNaoEncontradosDadosREL_VALTAX: TcxGridDBBandedColumn;
    grdNaoEncontradosDadosREL_VALFRE: TcxGridDBBandedColumn;
    grdNaoEncontradosDadosREL_VALCUP: TcxGridDBBandedColumn;
    grdNaoEncontradosDadosREL_VALAJU: TcxGridDBBandedColumn;
    grdNaoEncontradosDadosREL_VALLIQ: TcxGridDBBandedColumn;
    lblMensagemInformativa: TLabel;
    btnRelatorioArquivo: TcxButton;
    pnlTotalGeralArquivo: TPanel;
    lblTipoLancamento: TcxLabel;
    lblAjustesDescricao: TcxLabel;
    lblVendasDescricao: TcxLabel;
    lblVendasValor: TcxLabel;
    lblAjustesValor: TcxLabel;
    lmgLogoResumo: TImage;
    lblResultadoPeriodoDescricao: TcxLabel;
    lblResultadoPeriodoValor: TcxLabel;
    lblSifraoAjustes: TcxLabel;
    lblSifraoVendas: TcxLabel;
    lblSifraoResultadoPeriodo: TcxLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnExpandirInconsistenciasClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnCarregarLancamentosClick(Sender: TObject);
    procedure btnSairBaixaClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure fraLancamentosVendasbtnGerarRelatorioClick(Sender: TObject);
    procedure fraLancamentosAjustesbtnGerarRelatorioClick(Sender: TObject);
    procedure btnGerarRelatorioClick(Sender: TObject);
    procedure btnConfirmarBaixaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnRelatorioArquivoClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    FTamanhoInicialInconsistencias: Integer;

    FConciliacaoB2W: TConcilB2W;

    FArrayEmpresas: TConsultasArray;

    FEmpresasPossuemArquivos: String;

    FDatasetInconsistencias: TUniClientDataset;

    FDataSourceGrid: TDatasource;

    FConsultaEmpresa: TUniQuery;

    Const
      InputBoxMsg = WM_USER + 123;

    procedure InputBoxSet(var Msg: TMessage); message InputBoxMsg;

    function RetornaSQLSelecionaEmpresas: String;
    function RetornaSQLEmpresas: String;

    procedure CarregaInformacoesCards(AAutoIncremRelatorio: Integer);

    procedure CarregaRegistrosInconsistencias(APossuiInconsistencias: Boolean);

    procedure LimparDadosDaBaixa;

    procedure ArredondarBordasTotalArquivo;

    procedure MostrarLabelsValores(AMostrar: Boolean);

    function EscPressionado: Boolean;
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

Uses untTB2WBaixaRecebiveis;

{$R *.dfm}

procedure TfrmB2WBaixaRecebiveisMkt.ArredondarBordasTotalArquivo;
  var
    Rgn: HRGN;
begin
  pnlTotalGeralArquivo.HandleNeeded;

  Rgn := CreateRoundRectRgn(
    0,
    0,
    pnlTotalGeralArquivo.Width + 1,
    pnlTotalGeralArquivo.Height + 1,
    15,
    15
  );

  if pnlTotalGeralArquivo.HandleAllocated then
    SetWindowRgn(pnlTotalGeralArquivo.Handle, 0, False);

  SetWindowRgn(pnlTotalGeralArquivo.Handle, Rgn, True);
end;

procedure TfrmB2WBaixaRecebiveisMkt.btnCarregarLancamentosClick(
  Sender: TObject);
  Var
    LCodigoEmpresa: String;
begin
  inherited;
  if edtCodEmp.Visible then
  Begin
    if VS_FuncoesExternas.fIFechamentoFinanceiroJaRealizado(TB2WFuncoes.IIF(not TB2WFuncoes.fEmptyStr(edtCodEmp.Text), edtCodEmp.Text, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                            mskDtaIniConcil.Date,
                                                            Self.Name) then
      Exit;
  End;

  If Not fVerificaCampos Then
    Exit;

  LCodigoEmpresa := edtCodEmp.Text;
  If LCodigoEmpresa.IsEmpty Then
    LCodigoEmpresa := VS_FuncoesExternas.fIRetEmpresaLogada;

  If Not TB2WBaixaRecebiveis.ConfiguracoesB2WValidas(LCodigoEmpresa) Then
  Begin
    TB2WFuncoes.fMensagem('ATENÇÃO', 'Para realizar a conciliação/baixa de recebíveis, todas as configurações ' +
                                              'referentes ao B2W na empresa ' + LCodigoEmpresa + ' devem estar preenchidas.' + #13 +
                                              'No Autcom, acesse Útil->Configuração do Sistema. No grupo CARTÕES, ' +
                                              'preencha todas as configurações que iniciam por "B2W".', ['&OK']);

    Exit;
  End;

  If Assigned(FConciliacaoB2W) Then
    FreeAndNil(FConciliacaoB2W);

  FConciliacaoB2W := TConcilB2W.Create;

  FConciliacaoB2W.DataInicioPeriodo := mskDtaIniConcil.Date;
  FConciliacaoB2W.DataFinalPeriodo := mskDtaFinConcil.Date;
  FConciliacaoB2W.EmpresasPeriodo := FArrayEmpresas;

  TB2WFuncoes.ExecutaAguarde(FConciliacaoB2W.fConciliaCartoes, 'Aguarde... Filtrando registros.');

  CarregaInformacoesCards(FConciliacaoB2W.AutoIncremRelatorio);
end;

procedure TfrmB2WBaixaRecebiveisMkt.btnConfirmarBaixaClick(
  Sender: TObject);
  Var
    LBaixaRecebiveis: TB2WBaixaRecebiveis;
begin
  inherited;
  If TB2WFuncoes.fMensagem('ATENÇÃO', 'Deseja realmente realizar a baixa dos lançamentos do período selecionado?', ['&Sim', '&Não']) = 2 Then
    Exit;

  LBaixaRecebiveis := TB2WBaixaRecebiveis.Create(FConciliacaoB2W.cdsBaiCar);
  Try
    LBaixaRecebiveis.ObjetoConciliacao := FConciliacaoB2W.objConcil;
    LBaixaRecebiveis.RegistrosConciliar := FConciliacaoB2W.ListaRegistrosConciliar;
    LBaixaRecebiveis.DataFinalConciliacao := FConciliacaoB2W.DataFinalPeriodo;

    If TB2WFuncoes.ExecutaAguarde(LBaixaRecebiveis.ConfirmarBaixa, 'Aguarde... Processando e baixando recebíveis.') Then
      LimparDadosDaBaixa;
  Finally
    FreeAndNil(LBaixaRecebiveis);
  End;
end;

procedure TfrmB2WBaixaRecebiveisMkt.btnExpandirInconsistenciasClick(
  Sender: TObject);
begin
  inherited;
  If grpListaInconsistencias.Height = FTamanhoInicialInconsistencias Then
  Begin
    pnlTransferencias.Visible := False;
    pnlRecebimentos.Visible := False;

    grpListaInconsistencias.Align := alClient;

    TcxButton(Sender).OptionsImage.ImageIndex := 1;
    TcxButton(Sender).Caption := '&Ocultar';
  End
  Else
  Begin
    grpListaInconsistencias.Align := alBottom;

    grpListaInconsistencias.Height := FTamanhoInicialInconsistencias;

    pnlRecebimentos.Visible := True;
    pnlTransferencias.Visible := True;

    TcxButton(Sender).OptionsImage.ImageIndex := 0;
    TcxButton(Sender).Caption := '&Exibir';
  End;
end;

procedure TfrmB2WBaixaRecebiveisMkt.btnGerarRelatorioClick(
  Sender: TObject);
begin
  inherited;

  VS_FuncoesExternas.prcIExecutaRelatorio(575,
                        40899,
                        [],
                        ['AUTINC', 'CODEMP'],
                        [FConciliacaoB2W.AutoIncremRelatorio.ToString, '(IN)'+ edtCodEmp.Text],
                        nil,
                        nil,
                        True);
end;

procedure TfrmB2WBaixaRecebiveisMkt.btnRelatorioArquivoClick(
  Sender: TObject);
begin
  inherited;
  mskDtaIniConcil.Date := FConciliacaoB2W.DataInicioPeriodo;
  mskDtaFinConcil.Date := FConciliacaoB2W.DataFinalPeriodo;

  If pnlEmpresa.Visible Then
  Begin
    edtCodEmp.Text := FConciliacaoB2W.RetornaEmpresaFiltrada;
    edtDesEmp.Text := VS_FuncoesExternas.fICampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtCodEmp.Text]);
  End;

  VS_FuncoesExternas.prcIExecutaRelatorio(
                        576,
                        40900,
                        [],
                        ['DTAINI', 'DTAFIN', 'CODEMP', 'AUTINC','NOME_ARQUIVO'],
                        [FormatDateTime('dd/mm/yyyy', FConciliacaoB2W.DataInicioPeriodo),
                            FormatDateTime('dd/mm/yyyy', FConciliacaoB2W.DataFinalPeriodo),
                            '(IN)'+ edtCodEmp.Text,
                            FConciliacaoB2W.AutoIncremRelatorio.ToString,
                            FConciliacaoB2W.NomeArquivosConciliacao],
                        nil,
                        nil,
                        True);
end;

procedure TfrmB2WBaixaRecebiveisMkt.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfrmB2WBaixaRecebiveisMkt.CarregaInformacoesCards(
  AAutoIncremRelatorio: Integer);
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT SUM(IF(REL_TIPREG="PAGAMENTO", 1, 0)) AS QTDE_VENDAS, ' +
                          '       SUM(IF(REL_TIPREG="PAGAMENTO", REL_VALLIQ, 0)) AS LIQUIDO_VENDAS, ' +
                          '       SUM(IF(REL_TIPREG="PAGAMENTO" AND REL_CONCIL = 0, 1, 0)) AS QTDE_VENDAS_BAIXAR, ' +

                          '       SUM(IF(REL_TIPREG="AJUSTES", 1, 0)) AS QTDE_AJUSTES, ' +
                          '       SUM(IF(REL_TIPREG="AJUSTES", REL_VALLIQ, 0)) AS LIQUIDO_AJUSTES, ' +
                          '       SUM(IF(REL_TIPREG="AJUSTES" AND REL_CONCIL = 0, 1, 0)) AS QTDE_AJUSTES_BAIXAR, ' +

                          '       SUM(IF(REL_TIPREG="TRANSFERENCIA", 1, 0)) AS QTDE_TRANSFERENCIAS, ' +
                          '       SUM(IF(REL_TIPREG="TRANSFERENCIA", REL_VALLIQ, 0)) AS LIQUIDO_TRANSFERENCIAS, ' +
                          '       SUM(IF(REL_TIPREG="TRANSFERENCIA" AND REL_CONCIL = 0, 1, 0)) AS QTDE_TRANSFERENCIAS_BAIXAR, ' +
                          '       GROUP_CONCAT(DISTINCT REL_PORCRE) AS PORTADOR_TRANSFERENCIA, ' +

                          '       SUM(IF(REL_TIPREG="INCONSISTENCIA", 1, 0)) AS QTDE_INCONSISTENCIAS, ' +
                          '       SUM(IF(REL_TIPREG="INCONSISTENCIA", REL_VALLIQ, 0)) AS LIQUIDO_INCONSISTENCIAS ' +
                          'FROM REL_CONITE ' +
                          'WHERE REL_RELINC=:RELINC';

    LConsulta.ParamByName('RELINC').AsInteger := AAutoIncremRelatorio;
    LConsulta.Open;

    fraLancamentosVendas.lblQuantidadeLancamentos.Caption := LConsulta.FieldByName('QTDE_VENDAS').AsInteger.ToString + ' venda';
    fraLancamentosVendas.lblValorLancamentos.Caption := FormatFloat(',0.00', LConsulta.FieldByName('LIQUIDO_VENDAS').AsFloat);
    If LConsulta.FieldByName('QTDE_VENDAS').AsInteger <> 1 Then
      fraLancamentosVendas.lblQuantidadeLancamentos.Caption := fraLancamentosVendas.lblQuantidadeLancamentos.Caption +'s';
    fraLancamentosVendas.btnGerarRelatorio.Enabled := LConsulta.FieldByName('QTDE_VENDAS').AsInteger > 0;

    fraLancamentosAjustes.lblQuantidadeLancamentos.Caption := LConsulta.FieldByName('QTDE_AJUSTES').AsInteger.ToString + ' ajuste';
    fraLancamentosAjustes.lblValorLancamentos.Caption := FormatFloat(',0.00', LConsulta.FieldByName('LIQUIDO_AJUSTES').AsFloat);
    fraLancamentosAjustes.lblValorLancamentos.Style.TextColor := fraLancamentosVendas.lblValorLancamentos.Style.TextColor;
    If LConsulta.FieldByName('LIQUIDO_AJUSTES').AsFloat < 0 Then
      fraLancamentosAjustes.lblValorLancamentos.Style.TextColor := RGB(255, 99, 71);
    If LConsulta.FieldByName('QTDE_AJUSTES').AsInteger <> 1 Then
      fraLancamentosAjustes.lblQuantidadeLancamentos.Caption := fraLancamentosAjustes.lblQuantidadeLancamentos.Caption +'s';
    fraLancamentosAjustes.btnGerarRelatorio.Enabled := LConsulta.FieldByName('QTDE_AJUSTES').AsInteger > 0;
    fraLancamentosAjustes.lblSifrao.Style.TextColor := fraLancamentosAjustes.lblValorLancamentos.Style.TextColor;

    fraLancamentosLiquido.lblQuantidadeLancamentos.Caption := (LConsulta.FieldByName('QTDE_VENDAS').AsInteger +
                                                               LConsulta.FieldByName('QTDE_AJUSTES').AsInteger).ToString + ' lançamento';
    fraLancamentosLiquido.lblValorLancamentos.Caption := FormatFloat(',0.00', LConsulta.FieldByName('LIQUIDO_VENDAS').AsFloat +
                                                                              LConsulta.FieldByName('LIQUIDO_AJUSTES').AsFloat);
    fraLancamentosLiquido.lblValorLancamentos.Style.TextColor := fraLancamentosVendas.lblValorLancamentos.Style.TextColor;
    If LConsulta.FieldByName('LIQUIDO_VENDAS').AsFloat + LConsulta.FieldByName('LIQUIDO_AJUSTES').AsFloat < 0 Then
      fraLancamentosLiquido.lblValorLancamentos.Style.TextColor := RGB(255, 99, 71);
    If (LConsulta.FieldByName('QTDE_VENDAS').AsInteger + LConsulta.FieldByName('QTDE_AJUSTES').AsInteger) <> 1 Then
      fraLancamentosLiquido.lblQuantidadeLancamentos.Caption := fraLancamentosLiquido.lblQuantidadeLancamentos.Caption + 's';
    fraLancamentosLiquido.lblSifrao.Style.TextColor := fraLancamentosLiquido.lblValorLancamentos.Style.TextColor;


    lblVendasValor.Caption := FormatFloat(',0.00', LConsulta.FieldByName('LIQUIDO_VENDAS').AsFloat);
    lblAjustesValor.Caption := FormatFloat(',0.00', LConsulta.FieldByName('LIQUIDO_AJUSTES').AsFloat);
    lblResultadoPeriodoValor.Caption := FormatFloat(',0.00', LConsulta.FieldByName('LIQUIDO_VENDAS').AsFloat +
                                                             LConsulta.FieldByName('LIQUIDO_AJUSTES').AsFloat -
                                                             Abs(LConsulta.FieldByName('LIQUIDO_TRANSFERENCIAS').AsFloat));

    lblAjustesValor.Style.TextColor := fraLancamentosAjustes.lblValorLancamentos.Style.TextColor;
    lblResultadoPeriodoValor.Style.TextColor := fraLancamentosVendas.lblValorLancamentos.Style.TextColor;

    If LConsulta.FieldByName('LIQUIDO_VENDAS').AsFloat +
       LConsulta.FieldByName('LIQUIDO_AJUSTES').AsFloat -
       Abs(LConsulta.FieldByName('LIQUIDO_TRANSFERENCIAS').AsFloat) < 0 Then
      lblResultadoPeriodoValor.Style.TextColor := RGB(255, 99, 71);



    lblSifraoAjustes.Style.TextColor := lblAjustesValor.Style.TextColor;
    lblSifraoResultadoPeriodo.Style.TextColor := lblResultadoPeriodoValor.Style.TextColor;


    If grpListaInconsistencias.Visible Then
      Self.Height := Self.Height - FTamanhoInicialInconsistencias;

    lblMensagemInformativa.Visible := False;
    grpListaInconsistencias.Visible := LConsulta.FieldByName('QTDE_INCONSISTENCIAS').AsInteger > 0;
    btnConfirmarBaixa.Enabled := LConsulta.FieldByName('QTDE_TRANSFERENCIAS_BAIXAR').AsInteger +
                                 LConsulta.FieldByName('QTDE_VENDAS_BAIXAR').AsInteger +
                                 LConsulta.FieldByName('QTDE_AJUSTES_BAIXAR').AsInteger > 0;
    If btnConfirmarBaixa.Enabled Then
      btnConfirmarBaixa.Enabled := LConsulta.FieldByName('QTDE_INCONSISTENCIAS').AsInteger = 0
    Else
    Begin
      lblMensagemInformativa.Caption := 'Todos os lançamentos desse período já foram baixados.';
      lblMensagemInformativa.Visible := LConsulta.FieldByName('QTDE_INCONSISTENCIAS').AsInteger = 0;
    End;

    If grpListaInconsistencias.Visible Then
      Self.Height := Self.Height + FTamanhoInicialInconsistencias;

    CarregaRegistrosInconsistencias(grpListaInconsistencias.Visible);

    MostrarLabelsValores(True);

    btnRelatorioArquivo.Enabled := True;

    If LConsulta.FieldByName('QTDE_INCONSISTENCIAS').AsInteger +
       LConsulta.FieldByName('QTDE_TRANSFERENCIAS').AsInteger +
       LConsulta.FieldByName('QTDE_VENDAS').AsInteger +
       LConsulta.FieldByName('QTDE_AJUSTES').AsInteger = 0 Then
      LimparDadosDaBaixa;
  Finally
    TB2WFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

procedure TfrmB2WBaixaRecebiveisMkt.CarregaRegistrosInconsistencias(
  APossuiInconsistencias: Boolean);
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    If Not APossuiInconsistencias Then
    Begin
      LConsulta := TB2WFuncoes.fCriarQuery('SELECT * FROM REL_CONITE WHERE FALSE', True);
      TB2WFuncoes.FreeAndNilDatasets(FDatasetInconsistencias);
      FDatasetInconsistencias := TB2WFuncoes.CriarClientDataSet(LConsulta);

      Exit;
    End;

    LConsulta.SQL.Text := 'SELECT *, ' +
                          '       CONCAT(REL_PARCEL, "/", REL_TOTPAR) AS PARCELA ' +
                          'FROM REL_CONITE ' +
                          'WHERE REL_RELINC=:AUTINC ' +
                          '  AND REL_TIPREG="INCONSISTENCIA" ' +
                          'ORDER BY REL_DTAVEN, REL_DTA_CV';

    LConsulta.ParamByName('AUTINC').AsInteger := FConciliacaoB2W.AutoIncremRelatorio;
    LConsulta.Open;

    TB2WFuncoes.FreeAndNilDatasets(FDatasetInconsistencias);
    FDatasetInconsistencias := TB2WFuncoes.CriarClientDataSet(LConsulta);
    FDatasetInconsistencias.First;
  Finally
    TB2WFuncoes.FreeAndNilDatasets(LConsulta);

    FDataSourceGrid.Dataset := FDatasetInconsistencias;
  End;
end;

procedure TfrmB2WBaixaRecebiveisMkt.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If VS_FuncoesExternas.fIPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, FArrayEmpresas, False, False, '', False, '',
     RetornaSQLEmpresas) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmB2WBaixaRecebiveisMkt.EscPressionado: Boolean;
begin
  Result := True;

  If Assigned(FConciliacaoB2W) Then
  Begin
    If FConciliacaoB2W.AutoIncremRelatorio > 0 Then
    Begin
      Result := False;

      blnFecharComEscape := False;

      If TB2WFuncoes.fMensagem('ATENÇÃO', 'Deseja cancelar a baixa de recebíveis carregada?', ['&Sim', '&Não']) = 2 Then
        Exit;

      LimparDadosDaBaixa;
    End;
  End;

  blnFecharComEscape := True;
end;

procedure TfrmB2WBaixaRecebiveisMkt.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If Not blnFecharComEscape Then
  Begin
    Action := caNone;
    blnFecharComEscape := True;

    Exit;
  End;

  LimparDadosDaBaixa;

  inherited;
  If Assigned(FDataSourceGrid) Then
    FreeAndNil(FDataSourceGrid);

  If Assigned(FConciliacaoB2W) Then
    FreeAndNil(FConciliacaoB2W);

  TB2WFuncoes.FreeAndNilDatasets(FDatasetInconsistencias);
  TB2WFuncoes.FreeAndNilDatasets(FConsultaEmpresa);
end;

procedure TfrmB2WBaixaRecebiveisMkt.FormCreate(Sender: TObject);
begin
  inherited;
  FTamanhoInicialInconsistencias := grpListaInconsistencias.Height;

  FConciliacaoB2W := TConcilB2W.Create;

  lblMensagemInconsistencia.Font.Color := RGB(255, 99, 71);
  fraLancamentosAjustes.lblValorLancamentos.Style.Font.Color := RGB(255, 99, 71);

  fraLancamentosVendas.ArredondarBordas;
  fraLancamentosVendas.CarregaLogoLancamento(tlmVendas);
  fraLancamentosAjustes.ArredondarBordas;
  fraLancamentosAjustes.CarregaLogoLancamento(tlmAjustes);
  fraLancamentosLiquido.ArredondarBordas;
  fraLancamentosLiquido.CarregaLogoLancamento(tlmLiquido);

  FConsultaEmpresa := TB2WFuncoes.fCriarQuery('SELECT * FROM CADEMP WHERE FALSE');

  FDataSourceGrid := TDataSource.Create(Nil);
  FDataSourceGrid.AutoEdit := False;
  grdNaoEncontradosDados.DataController.DataSource := FDataSourceGrid;
end;

procedure TfrmB2WBaixaRecebiveisMkt.FormDeactivate(Sender: TObject);
begin
  inherited;
  Self.BringToFront;
end;

procedure TfrmB2WBaixaRecebiveisMkt.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE:
    Begin
      If EscPressionado Then
        Self.Close;
    End;
  End;
end;

procedure TfrmB2WBaixaRecebiveisMkt.FormShow(Sender: TObject);
  Var
    LConsultaEmpresas: TUniQuery;
begin
  inherited;
  Self.Height := Self.Height - FTamanhoInicialInconsistencias + 5;

  mskDtaIniConcil.Date := VS_FuncoesExternas.fIGetVS_Date;
  mskDtaFinConcil.Date := VS_FuncoesExternas.fIGetVS_Date;

  btnCarregarLancamentos.Top := mskDtaFinConcil.Top;

  pnlEmpresa.Visible := True;
  edtCodEmp.Text := VS_FuncoesExternas.fIRetEmpresaLogada;
  edtDesEmp.Text := TB2WFuncoes.RetornaNomeEmpresa(VS_FuncoesExternas.fIRetEmpresaLogada);

  btnCarregarLancamentos.Top := pnlEmpresa.Top - 1;

  ArredondarBordasTotalArquivo;

  MostrarLabelsValores(False);

  LConsultaEmpresas := Nil;
  Try
    LConsultaEmpresas := VS_FuncoesExternas.fICriaQuery;
    LConsultaEmpresas.SQL.Text := RetornaSQLSelecionaEmpresas;
    LConsultaEmpresas.Open;

    FEmpresasPossuemArquivos := '';
    While Not LConsultaEmpresas.Eof Do
    Begin
      FEmpresasPossuemArquivos := FEmpresasPossuemArquivos +
                                  LConsultaEmpresas.FieldByName('SIS_CODEMP').AsString + '_';
      LConsultaEmpresas.Next;
    End;
  Finally
    TB2WFuncoes.FreeAndNilDatasets(LConsultaEmpresas);
  End;
end;

procedure TfrmB2WBaixaRecebiveisMkt.fraLancamentosAjustesbtnGerarRelatorioClick(
  Sender: TObject);
begin
  inherited;

  VS_FuncoesExternas.prcIExecutaRelatorio(
                                          574,
                                          40898,
                                          [],
                                          ['AUTINC','CODEMP'],
                                          [FConciliacaoB2W.AutoIncremRelatorio.ToString, '(IN)'+ edtCodEmp.Text],
                                          nil,
                                          nil,
                                          True);

end;

procedure TfrmB2WBaixaRecebiveisMkt.fraLancamentosVendasbtnGerarRelatorioClick(
  Sender: TObject);
begin
  inherited;
    VS_FuncoesExternas.prcIExecutaRelatorio(573,
                                           40896,
                                           [],
                                           ['AUTINC','CODEMP'],
                                           [FConciliacaoB2W.AutoIncremRelatorio.ToString, '(IN)'+ edtCodEmp.Text],
                                           nil,
                                           nil,
                                           True);

end;

function TfrmB2WBaixaRecebiveisMkt.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = mskDtaIniConcil) Then
    Begin

      If (TB2WFuncoes.fEmptyStr(TB2WFuncoes.fTiraCaracEspeciais(mskDtaIniConcil.Text))) Then
      Begin
        TB2WFuncoes.fMensagem('ATENÇÃO!', 'A Data inicial deve ser preenchida!', ['&Ok']);
        Result := False;
      End;

    End
    Else If (Sender = mskDtaFinConcil) Then
    Begin

      If TB2WFuncoes.fEmptyStr(TB2WFuncoes.fTiraCaracEspeciais(mskDtaFinConcil.Text)) Then
      Begin
        TB2WFuncoes.fMensagem('ATENÇÃO!', 'A Data final deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If (Not TB2WFuncoes.fEmptyStr(TB2WFuncoes.fTiraCaracEspeciais(mskDtaFinConcil.Text))) And
              (    TB2WFuncoes.fEmptyStr(TB2WFuncoes.fTiraCaracEspeciais(mskDtaIniConcil.Text))) Then
      Begin
        TB2WFuncoes.fMensagem('ATENÇÃO!', 'Caso informe um período digite primeiramente a data inicial!', ['&Ok']);
        Result := False;
      End
      Else If (Not TB2WFuncoes.fEmptyStr(TB2WFuncoes.fTiraCaracEspeciais(mskDtaFinConcil.Text))) And
              (Not TB2WFuncoes.fEmptyStr(TB2WFuncoes.fTiraCaracEspeciais(mskDtaIniConcil.Text))) Then
      Begin
        If (Not TB2WFuncoes.fValidaPeriodo(mskDtaIniConcil.Text, mskDtaFinConcil.Text)) Then
        Begin
          TB2WFuncoes.fMensagem('ATENÇÃO!', 'A data final deve ser maior ou igual a data inicial!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtCodEmp) And (pnlEmpresa.Visible)  Then
    Begin
      If TB2WFuncoes.fEmptyStr(edtCodEmp.Text) Then
      Begin
        TB2WFuncoes.fMensagem('ATENÇÃO', 'A empresa não foi selecionada!', ['&Ok']);

        Result := False;
      End
      Else
      Begin
        VS_FuncoesExternas.pIPesquisaCadEmp(Nil, FConsultaEmpresa, edtCodEmp.Text);
        edtDesEmp.Text := FConsultaEmpresa.FieldByName('EMP_NOMEMP').AsString;

        If Pos(edtCodEmp.Text, FEmpresasPossuemArquivos) <= 0 Then
        Begin
          TB2WFuncoes.fMensagem('ATENÇÃO', 'Empresa sem arquivo(s) vinculado(s)!', ['&Ok']);

          Result := False;
        End;

        SetLength(FArrayEmpresas, 0);

        If Result Then
        Begin
          SetLength(FArrayEmpresas, 1);
          FArrayEmpresas[0].strCodigo := edtCodEmp.Text;
        End;
      End;

    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmB2WBaixaRecebiveisMkt.InputBoxSet(var Msg: TMessage);
  Var
   LContador: integer;
begin
  for LContador := 0 to Screen.Forms[0].ComponentCount-1 do
  begin
    if Screen.Forms[0].Components[LContador] is TEdit then
    begin
      TEdit(Screen.Forms[0].Components[LContador]).PasswordChar := '*';
      TEdit(Screen.Forms[0].Components[LContador]).Clear;
    end;
  end;
end;

procedure TfrmB2WBaixaRecebiveisMkt.LimparDadosDaBaixa;
begin
  mskDtaIniConcil.Date := VS_FuncoesExternas.fIGetVS_Date;
  mskDtaFinConcil.Date := VS_FuncoesExternas.fIGetVS_Date;

  edtCodEmp.Clear;
  edtDesEmp.Clear;

  fraLancamentosVendas.lblValorLancamentos.Caption := '0,00';
  fraLancamentosAjustes.lblValorLancamentos.Caption := '0,00';
  fraLancamentosLiquido.lblValorLancamentos.Caption := '0,00';

  fraLancamentosVendas.lblQuantidadeLancamentos.Caption := '0 vendas';
  fraLancamentosAjustes.lblQuantidadeLancamentos.Caption := '0 ajustes';
  fraLancamentosLiquido.lblQuantidadeLancamentos.Caption := '0 lançamentos';

  fraLancamentosAjustes.lblValorLancamentos.Style.TextColor := fraLancamentosVendas.lblValorLancamentos.Style.TextColor;
  fraLancamentosLiquido.lblValorLancamentos.Style.TextColor := fraLancamentosVendas.lblValorLancamentos.Style.TextColor;
  fraLancamentosAjustes.lblSifrao.Style.TextColor := fraLancamentosVendas.lblValorLancamentos.Style.TextColor;
  fraLancamentosLiquido.lblSifrao.Style.TextColor := fraLancamentosVendas.lblValorLancamentos.Style.TextColor;

  If Assigned(FConciliacaoB2W) Then
    FreeAndNil(FConciliacaoB2W);

  If Assigned(grdNaoEncontradosDados.DataController.DataSet) Then
    grdNaoEncontradosDados.DataController.DataSet.Close;

  If grpListaInconsistencias.Visible Then
  Begin
    If btnExpandirInconsistencias.Caption = '&Ocultar' Then
      btnExpandirInconsistencias.Click;

    grpListaInconsistencias.Visible := False;
    Self.Height := Self.Height - grpListaInconsistencias.Height;
  End;

  If pnlEmpresa.Visible Then
  Begin
    edtCodEmp.Text := VS_FuncoesExternas.fIRetEmpresaLogada;
    edtDesEmp.Text := TB2WFuncoes.RetornaNomeEmpresa(edtCodEmp.Text);
  End;

  lblVendasValor.Caption := '0,00';
  lblAjustesValor.Caption := '0,00';
  lblResultadoPeriodoValor.Caption := '0,00';
  lblVendasValor.Style.TextColor := fraLancamentosVendas.lblValorLancamentos.Style.TextColor;
  lblAjustesValor.Style.TextColor := fraLancamentosVendas.lblValorLancamentos.Style.TextColor;
  lblResultadoPeriodoValor.Style.TextColor := fraLancamentosVendas.lblValorLancamentos.Style.TextColor;

  lblSifraoAjustes.Style.TextColor := lblAjustesValor.Style.TextColor;
  lblSifraoResultadoPeriodo.Style.TextColor := lblResultadoPeriodoValor.Style.TextColor;

  lblMensagemInformativa.Visible := False;

  btnConfirmarBaixa.Enabled := False;
  btnRelatorioArquivo.Enabled := False;

  fraLancamentosVendas.btnGerarRelatorio.Enabled := False;
  fraLancamentosAjustes.btnGerarRelatorio.Enabled := False;

  MostrarLabelsValores(False);

  TB2WFuncoes.pSetFocus(mskDtaIniConcil);
end;

procedure TfrmB2WBaixaRecebiveisMkt.MostrarLabelsValores(
  AMostrar: Boolean);
begin
  fraLancamentosVendas.lblQuantidadeLancamentos.Visible := AMostrar;
  fraLancamentosAjustes.lblQuantidadeLancamentos.Visible := AMostrar;
  fraLancamentosLiquido.lblQuantidadeLancamentos.Visible := AMostrar;

  fraLancamentosAjustes.lblValorLancamentos.Visible := AMostrar;
  fraLancamentosLiquido.lblValorLancamentos.Visible := AMostrar;

  fraLancamentosVendas.lblValorLancamentos.Visible := AMostrar;
  fraLancamentosAjustes.lblSifrao.Visible := AMostrar;
  fraLancamentosLiquido.lblSifrao.Visible := AMostrar;
  fraLancamentosVendas.lblSifrao.Visible := AMostrar;

  lblVendasDescricao.Visible := AMostrar;
  lblAjustesDescricao.Visible := AMostrar;
  lblResultadoPeriodoDescricao.Visible := AMostrar;

  lblVendasValor.Visible := AMostrar;
  lblAjustesValor.Visible := AMostrar;
  lblResultadoPeriodoValor.Visible := AMostrar;

  lblSifraoVendas.Visible := AMostrar;
  lblSifraoAjustes.Visible := AMostrar;
  lblSifraoResultadoPeriodo.Visible := AMostrar;
end;



function TfrmB2WBaixaRecebiveisMkt.RetornaSQLEmpresas: String;
begin
  Result := 'EMP_CODEMP IN (SELECT '+
            '  DISTINCT CAR_CODEST  '+
            'FROM                   '+
            '  ESTCAR WHERE CAR_NOMOPE = "B2W")';
end;

function TfrmB2WBaixaRecebiveisMkt.RetornaSQLSelecionaEmpresas: String;
begin
  Result := ' SELECT                             '+
            '  DISTINCT CAR_CODEST AS SIS_CODEMP '+
            'FROM                                '+
            '  ESTCAR WHERE CAR_NOMOPE = "B2W" ';
end;

end.
