unit untMagazineLuizaBaixaRecebiveisMkt;

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

     untMagazineLuizaTipos, untLibCartoesPai, untMagazineLuizaItemBaixaMkt,
     untConciliaRecebiveisMagazineLuiza, untTMagazineLuizaFuncoes,
     untLibCartoesInterfacesTipos;

type
  TfrmMagazineLuizaBaixaRecebiveisMkt = class(TfrmPai)
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
    fraLancamentosVendas: TfraMagazineLuizaItemBaixaMkt;
    fraLancamentosAjustes: TfraMagazineLuizaItemBaixaMkt;
    fraLancamentosLiquido: TfraMagazineLuizaItemBaixaMkt;
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
    fraLancamentosTransferencias: TfraMagazineLuizaItemBaixaMkt;
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
    lblTransferenciasDescricao: TcxLabel;
    lblVendasDescricao: TcxLabel;
    lblVendasValor: TcxLabel;
    lblAjustesValor: TcxLabel;
    lblTransferenciasValor: TcxLabel;
    lmgLogoResumo: TImage;
    lblResultadoPeriodoDescricao: TcxLabel;
    lblResultadoPeriodoValor: TcxLabel;
    lblSifraoAjustes: TcxLabel;
    lblSifraoVendas: TcxLabel;
    lblSifraoTransferencias: TcxLabel;
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
    procedure fraLancamentosTransferenciasbtnGerarRelatorioClick(
      Sender: TObject);
    procedure btnGerarRelatorioClick(Sender: TObject);
    procedure btnConfirmarBaixaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnRelatorioArquivoClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    FTamanhoInicialInconsistencias: Integer;

    FConciliacaoMagazineLuiza: TConcilaRecebiveisMagazineLuiza;

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

Uses untTMagazineLuizaBaixaRecebiveis;

{$R *.dfm}

procedure TfrmMagazineLuizaBaixaRecebiveisMkt.ArredondarBordasTotalArquivo;
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

procedure TfrmMagazineLuizaBaixaRecebiveisMkt.btnCarregarLancamentosClick(
  Sender: TObject);
  Var
    LCodigoEmpresa: String;
begin
  inherited;
  if edtCodEmp.Visible then
  Begin
    if VS_FuncoesExternas.fIFechamentoFinanceiroJaRealizado(TMagazineLuizaFuncoes.IIF(not TMagazineLuizaFuncoes.fEmptyStr(edtCodEmp.Text), edtCodEmp.Text, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                            mskDtaIniConcil.Date,
                                                            Self.Name) then
      Exit;
  End;

  If Not fVerificaCampos Then
    Exit;

  LCodigoEmpresa := edtCodEmp.Text;
  If LCodigoEmpresa.IsEmpty Then
    LCodigoEmpresa := VS_FuncoesExternas.fIRetEmpresaLogada;

  If Not TMagazineLuizaBaixaRecebiveis.ConfiguracoesMagazineLuizaValidas(LCodigoEmpresa) Then
  Begin
    TMagazineLuizaFuncoes.fMensagem('ATENÇÃO', 'Para realizar a conciliação/baixa de recebíveis, todas as configurações ' +
                                              'referentes ao Magazine Luiza na empresa ' + LCodigoEmpresa + ' devem estar preenchidas.' + #13 +
                                              'No Autcom, acesse Útil->Configuração do Sistema. No grupo CARTÕES, ' +
                                              'preencha todas as configurações que iniciam por "Magazine Luiza".', ['&OK']);

    Exit;
  End;

  If Assigned(FConciliacaoMagazineLuiza) Then
    FreeAndNil(FConciliacaoMagazineLuiza);

  FConciliacaoMagazineLuiza := TConcilaRecebiveisMagazineLuiza.Create;

  FConciliacaoMagazineLuiza.DataInicioPeriodo := mskDtaIniConcil.Date;
  FConciliacaoMagazineLuiza.DataFinalPeriodo := mskDtaFinConcil.Date;
  FConciliacaoMagazineLuiza.EmpresasPeriodo := FArrayEmpresas;

  TMagazineLuizaFuncoes.ExecutaAguarde(FConciliacaoMagazineLuiza.fConciliaCartoes, 'Aguarde... Filtrando registros.');

  CarregaInformacoesCards(FConciliacaoMagazineLuiza.AutoIncremRelatorio);
end;

procedure TfrmMagazineLuizaBaixaRecebiveisMkt.btnConfirmarBaixaClick(
  Sender: TObject);
  Var
    LBaixaRecebiveis: TMagazineLuizaBaixaRecebiveis;
begin
  inherited;
  If TMagazineLuizaFuncoes.fMensagem('ATENÇÃO', 'Deseja realmente realizar a baixa dos lançamentos do período selecionado?', ['&Sim', '&Não']) = 2 Then
    Exit;

  LBaixaRecebiveis := TMagazineLuizaBaixaRecebiveis.Create(FConciliacaoMagazineLuiza.cdsBaiCar);
  Try
    LBaixaRecebiveis.ObjetoConciliacao := FConciliacaoMagazineLuiza.objConcil;
    LBaixaRecebiveis.RegistrosConciliar := FConciliacaoMagazineLuiza.ListaRegistrosConciliar;
    LBaixaRecebiveis.DataFinalConciliacao := FConciliacaoMagazineLuiza.DataFinalPeriodo;
    LBaixaRecebiveis.DatasetMovcarParcelados := FConciliacaoMagazineLuiza.DatasetMovcarParceladas;
    LBaixaRecebiveis.ListaParcelasCadastrar := FConciliacaoMagazineLuiza.ListaParcelasCadastrar;

    If TMagazineLuizaFuncoes.ExecutaAguarde(LBaixaRecebiveis.ConfirmarBaixa, 'Aguarde... Processando e baixando recebíveis.') Then
      LimparDadosDaBaixa;
  Finally
    FreeAndNil(LBaixaRecebiveis);
  End;
end;

procedure TfrmMagazineLuizaBaixaRecebiveisMkt.btnExpandirInconsistenciasClick(
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

procedure TfrmMagazineLuizaBaixaRecebiveisMkt.btnGerarRelatorioClick(
  Sender: TObject);
begin
  inherited;
  VS_FuncoesExternas.prcIExecutaRelatorio(550,
                                          38418,
                                          [],
                                          ['AUTINC',
                                           'CODEMP'],
                                          [FConciliacaoMagazineLuiza.AutoIncremRelatorio.ToString,
                                           '(IN)'+ edtCodEmp.Text],
                                          Nil,
                                          Nil,
                                          True);
end;

procedure TfrmMagazineLuizaBaixaRecebiveisMkt.btnRelatorioArquivoClick(
  Sender: TObject);
begin
  inherited;
  mskDtaIniConcil.Date := FConciliacaoMagazineLuiza.DataInicioPeriodo;
  mskDtaFinConcil.Date := FConciliacaoMagazineLuiza.DataFinalPeriodo;

  If pnlEmpresa.Visible Then
  Begin
    edtCodEmp.Text := FConciliacaoMagazineLuiza.RetornaEmpresaFiltrada;
    edtDesEmp.Text := VS_FuncoesExternas.fICampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtCodEmp.Text]);
  End;

  VS_FuncoesExternas.prcIExecutaRelatorio(551,
                                          38419,
                                          [],
                                          ['DTAINI',
                                           'DTAFIN',
                                           'CODEMP',
                                           'AUTINC',
                                           'NOME_ARQUIVO'],
                                          [FormatDateTime('dd/mm/yyyy', FConciliacaoMagazineLuiza.DataInicioPeriodo),
                                           FormatDateTime('dd/mm/yyyy', FConciliacaoMagazineLuiza.DataFinalPeriodo),
                                           '(IN)'+ edtCodEmp.Text,
                                           FConciliacaoMagazineLuiza.AutoIncremRelatorio.ToString,
                                           FConciliacaoMagazineLuiza.NomeArquivosConciliacao],
                                          Nil,
                                          Nil,
                                          True);
end;

procedure TfrmMagazineLuizaBaixaRecebiveisMkt.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfrmMagazineLuizaBaixaRecebiveisMkt.CarregaInformacoesCards(
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

    fraLancamentosTransferencias.lblPeriodo.Caption := 'Portador Crédito: ' + LConsulta.FieldByName('PORTADOR_TRANSFERENCIA').AsString;
    If LConsulta.FieldByName('PORTADOR_TRANSFERENCIA').AsString.Length = 5 Then
      fraLancamentosTransferencias.lblPeriodo.Caption := fraLancamentosTransferencias.lblPeriodo.Caption + '-' +
                                                         VS_FuncoesExternas.fICampoTabela('POR_NOMPOR', 'CADPOR', ['POR_CODPOR'], [LConsulta.FieldByName('PORTADOR_TRANSFERENCIA').AsString]);
    fraLancamentosTransferencias.lblQuantidadeLancamentos.Caption := LConsulta.FieldByName('QTDE_TRANSFERENCIAS').AsInteger.ToString + ' transferência';
    fraLancamentosTransferencias.lblValorLancamentos.Caption := FormatFloat(',0.00', Abs(LConsulta.FieldByName('LIQUIDO_TRANSFERENCIAS').AsFloat));
    fraLancamentosTransferencias.CarregaLogoLancamento(tlmTransferencias, VS_FuncoesExternas.fICampoTabela('POR_CODBCO', 'CADPOR', ['POR_CODPOR'], [LConsulta.FieldByName('PORTADOR_TRANSFERENCIA').AsString]));
    If LConsulta.FieldByName('QTDE_TRANSFERENCIAS').AsInteger <> 1 Then
      fraLancamentosTransferencias.lblQuantidadeLancamentos.Caption := fraLancamentosTransferencias.lblQuantidadeLancamentos.Caption + 's';
    fraLancamentosTransferencias.btnGerarRelatorio.Enabled := LConsulta.FieldByName('QTDE_TRANSFERENCIAS').AsInteger > 0;
    If LConsulta.FieldByName('PORTADOR_TRANSFERENCIA').AsString.IsEmpty Then
      fraLancamentosTransferencias.lblPeriodo.Caption := EmptyStr;

    lblVendasValor.Caption := FormatFloat(',0.00', LConsulta.FieldByName('LIQUIDO_VENDAS').AsFloat);
    lblAjustesValor.Caption := FormatFloat(',0.00', LConsulta.FieldByName('LIQUIDO_AJUSTES').AsFloat);
    lblTransferenciasValor.Caption := FormatFloat(',0.00', LConsulta.FieldByName('LIQUIDO_TRANSFERENCIAS').AsFloat);
    lblResultadoPeriodoValor.Caption := FormatFloat(',0.00', LConsulta.FieldByName('LIQUIDO_VENDAS').AsFloat +
                                                             LConsulta.FieldByName('LIQUIDO_AJUSTES').AsFloat -
                                                             Abs(LConsulta.FieldByName('LIQUIDO_TRANSFERENCIAS').AsFloat));

    lblAjustesValor.Style.TextColor := fraLancamentosAjustes.lblValorLancamentos.Style.TextColor;
    lblResultadoPeriodoValor.Style.TextColor := fraLancamentosVendas.lblValorLancamentos.Style.TextColor;
    lblTransferenciasValor.Style.TextColor := fraLancamentosVendas.lblValorLancamentos.Style.TextColor;
    If LConsulta.FieldByName('LIQUIDO_VENDAS').AsFloat +
       LConsulta.FieldByName('LIQUIDO_AJUSTES').AsFloat -
       Abs(LConsulta.FieldByName('LIQUIDO_TRANSFERENCIAS').AsFloat) < 0 Then
      lblResultadoPeriodoValor.Style.TextColor := RGB(255, 99, 71);
    If LConsulta.FieldByName('LIQUIDO_TRANSFERENCIAS').AsFloat < 0 Then
      lblTransferenciasValor.Style.TextColor := RGB(255, 99, 71);

    lblSifraoAjustes.Style.TextColor := lblAjustesValor.Style.TextColor;
    lblSifraoResultadoPeriodo.Style.TextColor := lblResultadoPeriodoValor.Style.TextColor;
    lblSifraoTransferencias.Style.TextColor := lblTransferenciasValor.Style.TextColor;

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
    TMagazineLuizaFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

procedure TfrmMagazineLuizaBaixaRecebiveisMkt.CarregaRegistrosInconsistencias(
  APossuiInconsistencias: Boolean);
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    If Not APossuiInconsistencias Then
    Begin
      LConsulta := TMagazineLuizaFuncoes.fCriarQuery('SELECT * FROM REL_CONITE WHERE FALSE', True);
      FDatasetInconsistencias := TMagazineLuizaFuncoes.CriarClientDataSet(LConsulta);

      Exit;
    End;

    LConsulta.SQL.Text := 'SELECT *, ' +
                          '       CONCAT(REL_PARCEL, "/", REL_TOTPAR) AS PARCELA ' +
                          'FROM REL_CONITE ' +
                          'WHERE REL_RELINC=:AUTINC ' +
                          '  AND REL_TIPREG="INCONSISTENCIA" ' +
                          'ORDER BY REL_DTAVEN, REL_DTA_CV';

    LConsulta.ParamByName('AUTINC').AsInteger := FConciliacaoMagazineLuiza.AutoIncremRelatorio;
    LConsulta.Open;

    FDatasetInconsistencias := TMagazineLuizaFuncoes.CriarClientDataSet(LConsulta);
    FDatasetInconsistencias.First;
  Finally
    TMagazineLuizaFuncoes.FreeAndNilDatasets(LConsulta);

    FDataSourceGrid.Dataset := FDatasetInconsistencias;
  End;
end;

procedure TfrmMagazineLuizaBaixaRecebiveisMkt.edtCodEmpKeyPress(Sender: TObject;
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

function TfrmMagazineLuizaBaixaRecebiveisMkt.EscPressionado: Boolean;
begin
  Result := True;

  If Assigned(FConciliacaoMagazineLuiza) Then
  Begin
    If FConciliacaoMagazineLuiza.AutoIncremRelatorio > 0 Then
    Begin
      Result := False;

      blnFecharComEscape := False;

      If TMagazineLuizaFuncoes.fMensagem('ATENÇÃO', 'Deseja cancelar a baixa de recebíveis carregada?', ['&Sim', '&Não']) = 2 Then
        Exit;

      LimparDadosDaBaixa;
    End;
  End;

  blnFecharComEscape := True;
end;

procedure TfrmMagazineLuizaBaixaRecebiveisMkt.FormClose(Sender: TObject;
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

  If Assigned(FConciliacaoMagazineLuiza) Then
    FreeAndNil(FConciliacaoMagazineLuiza);

  TMagazineLuizaFuncoes.FreeAndNilDatasets(FDatasetInconsistencias);
  TMagazineLuizaFuncoes.FreeAndNilDatasets(FConsultaEmpresa);
end;

procedure TfrmMagazineLuizaBaixaRecebiveisMkt.FormCreate(Sender: TObject);
begin
  inherited;
  FTamanhoInicialInconsistencias := grpListaInconsistencias.Height;

  FConciliacaoMagazineLuiza := TConcilaRecebiveisMagazineLuiza.Create;

  lblMensagemInconsistencia.Font.Color := RGB(255, 99, 71);
  fraLancamentosAjustes.lblValorLancamentos.Style.Font.Color := RGB(255, 99, 71);

  fraLancamentosVendas.ArredondarBordas;
  fraLancamentosVendas.CarregaLogoLancamento(tlmVendas);
  fraLancamentosAjustes.ArredondarBordas;
  fraLancamentosAjustes.CarregaLogoLancamento(tlmAjustes);
  fraLancamentosLiquido.ArredondarBordas;
  fraLancamentosLiquido.CarregaLogoLancamento(tlmLiquido);
  fraLancamentosTransferencias.ArredondarBordas;
  fraLancamentosTransferencias.CarregaLogoLancamento(tlmTransferencias);

  pnlEmpresa.Visible := True;

  FConsultaEmpresa := TMagazineLuizaFuncoes.fCriarQuery('SELECT * FROM CADEMP WHERE FALSE');

  FDataSourceGrid := TDataSource.Create(Nil);
  FDataSourceGrid.AutoEdit := False;
  grdNaoEncontradosDados.DataController.DataSource := FDataSourceGrid;
end;

procedure TfrmMagazineLuizaBaixaRecebiveisMkt.FormDeactivate(Sender: TObject);
begin
  inherited;
  Self.BringToFront;
end;

procedure TfrmMagazineLuizaBaixaRecebiveisMkt.FormKeyDown(Sender: TObject;
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

procedure TfrmMagazineLuizaBaixaRecebiveisMkt.FormShow(Sender: TObject);
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
  edtDesEmp.Text := TMagazineLuizaFuncoes.RetornaNomeEmpresa(VS_FuncoesExternas.fIRetEmpresaLogada);

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
    TMagazineLuizaFuncoes.FreeAndNilDatasets(LConsultaEmpresas);
  End;
end;

procedure TfrmMagazineLuizaBaixaRecebiveisMkt.fraLancamentosAjustesbtnGerarRelatorioClick(
  Sender: TObject);
begin
  inherited;
  VS_FuncoesExternas.prcIExecutaRelatorio(548,
                                          38416,
                                          [],
                                          ['AUTINC',
                                           'CODEMP'],
                                          [FConciliacaoMagazineLuiza.AutoIncremRelatorio.ToString,
                                           '(IN)'+ edtCodEmp.Text],
                                          Nil,
                                          Nil,
                                          True);
end;

procedure TfrmMagazineLuizaBaixaRecebiveisMkt.fraLancamentosTransferenciasbtnGerarRelatorioClick(
  Sender: TObject);
begin
  inherited;
  VS_FuncoesExternas.prcIExecutaRelatorio(549,
                                          38417,
                                          [],
                                          ['AUTINC',
                                           'CODEMP'],
                                          [FConciliacaoMagazineLuiza.AutoIncremRelatorio.ToString,
                                           '(IN)'+ edtCodEmp.Text],
                                          Nil,
                                          Nil,
                                          True);
end;

procedure TfrmMagazineLuizaBaixaRecebiveisMkt.fraLancamentosVendasbtnGerarRelatorioClick(
  Sender: TObject);
begin
  inherited;
  VS_FuncoesExternas.prcIExecutaRelatorio(547,
                                          38414,
                                          [],
                                          ['AUTINC',
                                           'CODEMP'],
                                          [FConciliacaoMagazineLuiza.AutoIncremRelatorio.ToString,
                                           '(IN)'+ edtCodEmp.Text],
                                          Nil,
                                          Nil,
                                          True);
end;

function TfrmMagazineLuizaBaixaRecebiveisMkt.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = mskDtaIniConcil) Then
    Begin

      If (TMagazineLuizaFuncoes.fEmptyStr(TMagazineLuizaFuncoes.fTiraCaracEspeciais(mskDtaIniConcil.Text))) Then
      Begin
        TMagazineLuizaFuncoes.fMensagem('ATENÇÃO!', 'A Data inicial deve ser preenchida!', ['&Ok']);
        Result := False;
      End;

    End
    Else If (Sender = mskDtaFinConcil) Then
    Begin

      If TMagazineLuizaFuncoes.fEmptyStr(TMagazineLuizaFuncoes.fTiraCaracEspeciais(mskDtaFinConcil.Text)) Then
      Begin
        TMagazineLuizaFuncoes.fMensagem('ATENÇÃO!', 'A Data final deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If (Not TMagazineLuizaFuncoes.fEmptyStr(TMagazineLuizaFuncoes.fTiraCaracEspeciais(mskDtaFinConcil.Text))) And
              (    TMagazineLuizaFuncoes.fEmptyStr(TMagazineLuizaFuncoes.fTiraCaracEspeciais(mskDtaIniConcil.Text))) Then
      Begin
        TMagazineLuizaFuncoes.fMensagem('ATENÇÃO!', 'Caso informe um período digite primeiramente a data inicial!', ['&Ok']);
        Result := False;
      End
      Else If (Not TMagazineLuizaFuncoes.fEmptyStr(TMagazineLuizaFuncoes.fTiraCaracEspeciais(mskDtaFinConcil.Text))) And
              (Not TMagazineLuizaFuncoes.fEmptyStr(TMagazineLuizaFuncoes.fTiraCaracEspeciais(mskDtaIniConcil.Text))) Then
      Begin
        If (Not TMagazineLuizaFuncoes.fValidaPeriodo(mskDtaIniConcil.Text, mskDtaFinConcil.Text)) Then
        Begin
          TMagazineLuizaFuncoes.fMensagem('ATENÇÃO!', 'A data final deve ser maior ou igual a data inicial!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtCodEmp) And (pnlEmpresa.Visible)  Then
    Begin
      If TMagazineLuizaFuncoes.fEmptyStr(edtCodEmp.Text) Then
      Begin
        TMagazineLuizaFuncoes.fMensagem('ATENÇÃO', 'A empresa não foi selecionada!', ['&Ok']);

        Result := False;
      End
      Else
      Begin
        VS_FuncoesExternas.pIPesquisaCadEmp(Nil, FConsultaEmpresa, edtCodEmp.Text);
        edtDesEmp.Text := FConsultaEmpresa.FieldByName('EMP_NOMEMP').AsString;

        If Pos(edtCodEmp.Text, FEmpresasPossuemArquivos) <= 0 Then
        Begin
          TMagazineLuizaFuncoes.fMensagem('ATENÇÃO', 'Empresa sem arquivo(s) vinculado(s)!', ['&Ok']);

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

procedure TfrmMagazineLuizaBaixaRecebiveisMkt.InputBoxSet(var Msg: TMessage);
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

procedure TfrmMagazineLuizaBaixaRecebiveisMkt.LimparDadosDaBaixa;
begin
  mskDtaIniConcil.Date := VS_FuncoesExternas.fIGetVS_Date;
  mskDtaFinConcil.Date := VS_FuncoesExternas.fIGetVS_Date;

  edtCodEmp.Clear;
  edtDesEmp.Clear;

  fraLancamentosVendas.lblValorLancamentos.Caption := '0,00';
  fraLancamentosAjustes.lblValorLancamentos.Caption := '0,00';
  fraLancamentosLiquido.lblValorLancamentos.Caption := '0,00';
  fraLancamentosTransferencias.lblValorLancamentos.Caption := '0,00';

  fraLancamentosVendas.lblQuantidadeLancamentos.Caption := '0 vendas';
  fraLancamentosAjustes.lblQuantidadeLancamentos.Caption := '0 ajustes';
  fraLancamentosLiquido.lblQuantidadeLancamentos.Caption := '0 lançamentos';
  fraLancamentosTransferencias.lblQuantidadeLancamentos.Caption := '0 transferencias';
  fraLancamentosTransferencias.lblLancamentosPendentes.Caption := EmptyStr;
  fraLancamentosTransferencias.lblPeriodo.Caption := EmptyStr;
  fraLancamentosTransferencias.CarregaLogoLancamento(tlmTransferencias, '0');

  fraLancamentosAjustes.lblValorLancamentos.Style.TextColor := fraLancamentosVendas.lblValorLancamentos.Style.TextColor;
  fraLancamentosLiquido.lblValorLancamentos.Style.TextColor := fraLancamentosVendas.lblValorLancamentos.Style.TextColor;
  fraLancamentosAjustes.lblSifrao.Style.TextColor := fraLancamentosVendas.lblValorLancamentos.Style.TextColor;
  fraLancamentosLiquido.lblSifrao.Style.TextColor := fraLancamentosVendas.lblValorLancamentos.Style.TextColor;

  If Assigned(FConciliacaoMagazineLuiza) Then
    FreeAndNil(FConciliacaoMagazineLuiza);

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
    edtDesEmp.Text := TMagazineLuizaFuncoes.RetornaNomeEmpresa(edtCodEmp.Text);
  End;

  lblVendasValor.Caption := '0,00';
  lblAjustesValor.Caption := '0,00';
  lblResultadoPeriodoValor.Caption := '0,00';
  lblTransferenciasValor.Caption := '0,00';
  lblVendasValor.Style.TextColor := fraLancamentosVendas.lblValorLancamentos.Style.TextColor;
  lblAjustesValor.Style.TextColor := fraLancamentosVendas.lblValorLancamentos.Style.TextColor;
  lblResultadoPeriodoValor.Style.TextColor := fraLancamentosVendas.lblValorLancamentos.Style.TextColor;
  lblTransferenciasValor.Style.TextColor := fraLancamentosVendas.lblValorLancamentos.Style.TextColor;

  lblSifraoAjustes.Style.TextColor := lblAjustesValor.Style.TextColor;
  lblSifraoTransferencias.Style.TextColor := lblTransferenciasValor.Style.TextColor;
  lblSifraoResultadoPeriodo.Style.TextColor := lblResultadoPeriodoValor.Style.TextColor;

  lblMensagemInformativa.Visible := False;

  btnConfirmarBaixa.Enabled := False;
  btnRelatorioArquivo.Enabled := False;

  fraLancamentosVendas.btnGerarRelatorio.Enabled := False;
  fraLancamentosAjustes.btnGerarRelatorio.Enabled := False;
  fraLancamentosTransferencias.btnGerarRelatorio.Enabled := False;

  MostrarLabelsValores(False);

  TMagazineLuizaFuncoes.pSetFocus(mskDtaIniConcil);
end;

procedure TfrmMagazineLuizaBaixaRecebiveisMkt.MostrarLabelsValores(
  AMostrar: Boolean);
begin
  fraLancamentosVendas.lblQuantidadeLancamentos.Visible := AMostrar;
  fraLancamentosAjustes.lblQuantidadeLancamentos.Visible := AMostrar;
  fraLancamentosLiquido.lblQuantidadeLancamentos.Visible := AMostrar;
  fraLancamentosTransferencias.lblQuantidadeLancamentos.Visible := AMostrar;

  fraLancamentosAjustes.lblValorLancamentos.Visible := AMostrar;
  fraLancamentosLiquido.lblValorLancamentos.Visible := AMostrar;
  fraLancamentosTransferencias.lblValorLancamentos.Visible := AMostrar;
  fraLancamentosVendas.lblValorLancamentos.Visible := AMostrar;
  fraLancamentosAjustes.lblSifrao.Visible := AMostrar;
  fraLancamentosLiquido.lblSifrao.Visible := AMostrar;
  fraLancamentosTransferencias.lblSifrao.Visible := AMostrar;
  fraLancamentosVendas.lblSifrao.Visible := AMostrar;

  lblVendasDescricao.Visible := AMostrar;
  lblAjustesDescricao.Visible := AMostrar;
  lblResultadoPeriodoDescricao.Visible := AMostrar;
  lblTransferenciasDescricao.Visible := AMostrar;

  lblVendasValor.Visible := AMostrar;
  lblAjustesValor.Visible := AMostrar;
  lblResultadoPeriodoValor.Visible := AMostrar;
  lblTransferenciasValor.Visible := AMostrar;

  lblSifraoVendas.Visible := AMostrar;
  lblSifraoAjustes.Visible := AMostrar;
  lblSifraoTransferencias.Visible := AMostrar;
  lblSifraoResultadoPeriodo.Visible := AMostrar;
end;

function TfrmMagazineLuizaBaixaRecebiveisMkt.RetornaSQLEmpresas: String;
begin
  Result := 'EMP_CODEMP IN (SELECT '+
            '  DISTINCT CAR_CODEST  '+
            'FROM                   '+
            '  ESTCAR WHERE CAR_NOMOPE = "MAGAZINE LUIZA")';
end;

function TfrmMagazineLuizaBaixaRecebiveisMkt.RetornaSQLSelecionaEmpresas: String;
begin
  Result := ' SELECT                             '+
            '  DISTINCT CAR_CODEST AS SIS_CODEMP '+
            'FROM                                '+
            '  ESTCAR WHERE CAR_NOMOPE = "MAGAZINE LUIZA" ';
end;

end.
