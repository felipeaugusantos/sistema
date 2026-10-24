unit untCtrLiberacaoPedidos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  Uni, UniDataSetProvider, DB, UniClientDataSet, EditFocus, AppEvnts,
  BitBtnLockedIncrem, MemDS, DBAccess, Provider, frxClass, dxCore,
  frxExportCSVTestabilidade, Datasnap.DBClient, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, cxProgressBar,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxGridCitel,
  dxScreenTip, dxCustomHint, cxHint, cxCheckBox, untLiberacao, cxImageComboBox,
  System.ImageList, Vcl.ImgList, untMostraDebCtrChq2;

type
  TInfoPedPagtoAlt = Record
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodCli: String;
  End;

type
  TfrmCtrLiberacaoPedidos = class(TfrmPai)
    pnlRodape: TPanel;
    cdsPedidos: TUniClientDataSet;
    dtsPedidos: TDataSource;
    dspPedidos: TUniDataSetProvider;
    qryPedidos: TUniQuery;
    shpLiberados: TShape;
    Label1: TLabel;
    shpBonifica: TShape;
    lbl1: TLabel;
    btnCtaCorrente: TBitBtnLocked;
    btnResFinanc: TBitBtnLocked;
    btnReimpressao: TBitBtnLocked;
    btnSeleciona: TBitBtnLocked;
    btnCadCli: TBitBtnLocked;
    btnDadFin: TBitBtnLocked;
    shpDigVen: TShape;
    lblDigVen: TLabel;
    shpVlrMin: TShape;
    lblVlrMin: TLabel;
    cxgPedidos: TcxGrid;
    cxgPedidosDados: TcxGridDBTableView;
    cxgPedidosDadosFGO_TIPPED: TcxGridDBColumn;
    cxgPedidosDadosBONIFICA: TcxGridDBColumn;
    cxgPedidosDadosDESTINO: TcxGridDBColumn;
    cxgPedidosDadosFGO_NUMDOC: TcxGridDBColumn;
    cxgPedidosDadosFGO_CODEMP: TcxGridDBColumn;
    cxgPedidosDadosFGO_DTAENT: TcxGridDBColumn;
    cxgPedidosDadosFGO_HORENT: TcxGridDBColumn;
    cxgPedidosDadosFGO_NOMCLI: TcxGridDBColumn;
    cxgPedidosDadosFGO_TIPFRE: TcxGridDBColumn;
    cxgPedidosDadosFGO_TOTFRE: TcxGridDBColumn;
    cxgPedidosDadosDIGITADOR: TcxGridDBColumn;
    cxgPedidosDadosVENDEDOR: TcxGridDBColumn;
    cxgPedidosDadosDESFPG: TcxGridDBColumn;
    cxgPedidosDadosTIPATE: TcxGridDBColumn;
    cxgPedidosDadosFGO_VLRCON: TcxGridDBColumn;
    cxgPedidosDadosFGO_DTALIB: TcxGridDBColumn;
    cxgPedidosDadosFGO_HORLIB: TcxGridDBColumn;
    cxgPedidosDadosFGO_OPELIB: TcxGridDBColumn;
    cxgPedidosDadosFGO_TIPOPE: TcxGridDBColumn;
    cxgPedidosDadosVALFUT: TcxGridDBColumn;
    cxgPedidosDadosVALENT: TcxGridDBColumn;
    cxgPedidosDadosVALRET: TcxGridDBColumn;
    cxgPedidosDadosFGO_LIBERA: TcxGridDBColumn;
    cxgPedidosDadosFGO_LIBCOM: TcxGridDBColumn;
    cxgPedidosNivel: TcxGridLevel;
    btnPadrao: TBitBtnLocked;
    cxgPedidosDadosTRANSPORTADORA: TcxGridDBColumn;
    btnAtualizaPed: TBitBtnLocked;
    cxgPedidosDadosFGO_NUMPOK: TcxGridDBColumn;
    btnOcorrencia: TBitBtnLocked;
    btnLimparOcorrencia: TBitBtnLocked;
    cxgPedidosDadosDESOCO: TcxGridDBColumn;
    cxgPedidosDadosFGO_PREVIS: TcxGridDBColumn;
    cxgPedidosDadosFGO_EMP_CD: TcxGridDBColumn;
    cxgPedidosDadosFGO_CONPAG: TcxGridDBColumn;
    cxgPedidosDadosCLILOJ: TcxGridDBColumn;
    dtsMotivos: TDataSource;
    cdsMotivos: TUniClientDataSet;
    cdsMotivosAUTOINCREM: TStringField;
    cdsMotivosDIRACE: TStringField;
    cdsMotivosMOTIVO: TStringField;
    cdsMotivosNOMVEN: TStringField;
    cdsMotivosVLRCON: TFloatField;
    cdsMotivosCONPAG: TStringField;
    cdsMotivosINFLIB: TMemoField;
    cxgMotivosLevel: TcxGridLevel;
    btnLiberacaoDireta: TBitBtnLocked;
    cxHint: TcxHintStyleController;
    cxgMotivosDados: TcxGridDBTableView;
    cxgMotivosDadosDIRACE: TcxGridDBColumn;
    cxgMotivosDadosMOTIVO: TcxGridDBColumn;
    cxgMotivosDadosNOMVEN: TcxGridDBColumn;
    cxgMotivosDadosVLRCON: TcxGridDBColumn;
    cxgMotivosDadosCONPAG: TcxGridDBColumn;
    cxgMotivosDadosINFLIB: TcxGridDBColumn;
    btnExpandirTodos: TBitBtnLocked;
    btnRetrairTodos: TBitBtnLocked;
    cxgPedidosDadosFGO_STATOS: TcxGridDBColumn;
    cxgPedidosDadosFGO_STATOP: TcxGridDBColumn;
    shpNaoHoje: TShape;
    lblNaoHoje: TLabel;
    cxgPedidosDadosDESCRI: TcxGridDBColumn;
    cxgPedidosDadosFGO_ENTURG: TcxGridDBColumn;
    cxgPedidosDadosDIR_ACE_ENTURG: TcxGridDBColumn;
    cxgPedidosDadosCGCCPF: TcxGridDBColumn;
    Panel1: TPanel;
    cxgPedidosDadosFGO_PEDSIT: TcxGridDBColumn;
    cxgPedidosDadosTOTPRO: TcxGridDBColumn;
    cxgPedidosDadosDESESP: TcxGridDBColumn;
    cxgPedidosDadosDESACE: TcxGridDBColumn;
    cxgPedidosDadosTOTIPI: TcxGridDBColumn;
    cxgPedidosDadosTOTRET: TcxGridDBColumn;
    cxgPedidosDadosVALFCP: TcxGridDBColumn;
    btnCancLib: TBitBtnLocked;
    cxgPedidosDadosFGO_DTENTR: TcxGridDBColumn;
    btnAlterarDataEntregaRetirada: TBitBtnLocked;
    btnMnuVendas: TBitBtnLocked;
    popBotoes: TPopupMenu;
    mnuVenCli: TMenuItem;
    mnuSisAnt: TMenuItem;
    cxgPedidosDadosFANSOB: TcxGridDBColumn;
    imglSitAdt: TImageList;
    cxgPedidosDadosSITADT: TcxGridDBColumn;
    btnDesmembrarPedido: TBitBtnLocked;
    cxgPedidosDadosNUMORI: TcxGridDBColumn;
    cxgPedidosDadosESPORI: TcxGridDBColumn;
    cxgPedidosDadosEMPORI: TcxGridDBColumn;
    cxgPedidosDadosCNDDES: TcxGridDBColumn;
    cxgPedidosDadosDESPAG: TcxGridDBColumn;
    cxgPedidosDadosCODRED: TcxGridDBColumn;
    cxgPedidosDadosCODCAC: TcxGridDBColumn;
    cxgPedidosDadosCORILP: TcxGridDBColumn;
    cxgPedidosDadosPORTADOR: TcxGridDBColumn;
    cxgPedidosDadosPD_EXP: TcxGridDBColumn;
    btnAdiantPed: TBitBtnLocked;
    cxgPedidosDadosSTANEO: TcxGridDBColumn;
    btnConsultaNeocredit: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnResFinancClick(Sender: TObject);
    procedure btnCtaCorrenteClick(Sender: TObject);
    procedure btnReimpressaoClick(Sender: TObject);
    procedure btnSelecionaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCadCliClick(Sender: TObject);
    procedure cdsPedidosAfterScroll(DataSet: TDataSet);
    procedure btnDadFinClick(Sender: TObject);
    procedure cxgPedidosDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgPedidosDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnPadraoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAtualizaPedClick(Sender: TObject);
    procedure btnOcorrenciaClick(Sender: TObject);
    procedure btnLimparOcorrenciaClick(Sender: TObject);
    procedure btnLiberacaoDiretaClick(Sender: TObject);
    procedure cxgMotivosDadosMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure cxgPedidosDadosKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure cdsPedidosAfterOpen(DataSet: TDataSet);
    procedure btnExpandirTodosClick(Sender: TObject);
    procedure btnRetrairTodosClick(Sender: TObject);
    procedure cdsPedidosBeforeRefresh(DataSet: TDataSet);
    procedure cdsPedidosAfterRefresh(DataSet: TDataSet);
    procedure cxgPedidosLayoutChanged(Sender: TcxCustomGrid;
      AGridView: TcxCustomGridView);
    procedure dtsPedidosDataChange(Sender: TObject; Field: TField);
    procedure cxgPedidosDadosMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure btnCancLibClick(Sender: TObject);
    procedure btnAlterarDataEntregaRetiradaClick(Sender: TObject);
    procedure mnuSisAntClick(Sender: TObject);
    procedure mnuVenCliClick(Sender: TObject);
    procedure btnMnuVendasClick(Sender: TObject);
    procedure btnDesmembrarPedidoClick(Sender: TObject);
    procedure cxgMotivosDadosMouseLeave(Sender: TObject);
    procedure btnAdiantPedClick(Sender: TObject);
    procedure cxgPedidosDadosSTANEOGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure btnConsultaNeocreditClick(Sender: TObject);
  private
    { Private declarations }
    blnShowHint,
    blnUtilizaOSVenda: Boolean;
    intLastRec: Integer;
    intConfirmando: integer;
    mmsLayoutDefault: TMemoryStream;
    objLiberacao : TLiberacao;
    recInfoPedPagtoAlt: TInfoPedPagtoAlt;

    procedure pCarregaPedidos;
    procedure pCarregaMotivos;
    procedure pLiberacaoPedido(blnLibDireta: Boolean);
    function fGetChaveLayoutGrid: String;
    function fNroPedido: String;
    function fCondicaoPagamentoSemMascara(strConPag: String): String;
    function fRetStatusOs(strNumDoc, strEspDoc, strCodEmp: String): String;
    function fRetStatusOp(strNumDoc, strEspDoc, strCodEmp: String): String;
    procedure pPosicionarColunaVerdeVermelho;
    procedure pGravaEntUrg;
    function fDocumentoEmLoteSeparacaoRomaneio(strNumDoc, strEspDoc, strCodEmp: string): string;
    function fCancelaLiberacao(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodOpe: string): Boolean;
    function fTravaSaldoItem(strNumDoc, strEspDoc, strCodEmp: string): Boolean;
    function fEmpresaParaFaturamentoUsaWMS(strCodEmp, strEspDoc: String): Boolean;
    function fEhEmissaoDocumentoWMS(strCodEmp, strEspDoc: String): Boolean;
    procedure pAtualizaPedidoAlterouFormaPagamento(pgbStatus: TcxProgressBar = nil);
    procedure pExecutarConsultaNeocredit;
  public
    { Public declarations }
    strCodVen: String;
    strStatus: String;
    strTipLib: String;
    strMotDel: String;
    strDesMot: String;
    strHisCom: String;
  end;

var
  frmCtrLiberacaoPedidos: TfrmCtrLiberacaoPedidos;

implementation

uses  untReimpressao, untResFinanceiro, System.UITypes, StrUtils,
      untfuncoesSimples, untCtrLiberaPedidosConf, untFuncFat, untFuncoesGenerica,
      untCadClientes, untFuncoesAuxiliares, untDigFinanceira, untFinanceira,
      untDigOcorrencia, System.Math, System.RegularExpressions, untFuncoes,
      untFuncoesCRM, untTypesCRM, untAtualizaOcorrenciasCRM, untGravando,
      untConsultas, untFatGor, untAdiantamentoCliente, untFuncFatTelasHelper, untRelFatVendasCliente,
      untFatDigTipoEntregaItens, untSelFatDigTipoEntregaItens, untFatConsVendasAntigas,
      untFatDesmembrarPedido, untConstantes, untConsultarAdiantamentos,
      untFuncFatTypes, Neocredit.Facade, Neocredit.Classe;

{$R *.dfm}

procedure TfrmCtrLiberacaoPedidos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(mmsLayoutDefault);
  fGetFuncoesCxGrid.pSalvarView(cxgPedidosDados, fGetChaveLayoutGrid, cdsPedidos);
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
end;

procedure TfrmCtrLiberacaoPedidos.FormCreate(Sender: TObject);
begin
  inherited;
  cdsMotivos.CreateDataSet;
  blnShowHint := True;

  mmsLayoutDefault  := TMemoryStream.Create;
  lblDigVen.Visible := fCfgSis('USADIG', varBoolean);
  shpDigVen.Visible := fCfgSis('USADIG', varBoolean);

  strMotDel := '';
  strDesMot := '';
  strHisCom := '';

  blnUtilizaOSVenda := fCfgSis('OSPDVN', varBoolean);
  btnAlterarDataEntregaRetirada.Visible := fCfgSis('ENTFAT', varBoolean) and fVerificaAcessoSistema('mnuPermitirAlterarDataEntrega');

  lblNaoHoje.Visible := blnUtilizaOSVenda;
  shpNaoHoje.Visible := blnUtilizaOSVenda;
  objLiberacao := TLiberacao.Create;
  FillChar(recInfoPedPagtoAlt, SizeOf(recInfoPedPagtoAlt), #0);
end;

procedure TfrmCtrLiberacaoPedidos.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  blnShowHint := False;
  cxHint.HideHint;
  intLastRec := -1;

  Try
    If (Shift = [ssCtrl]) then
    Begin
      If (Key = VK_F2) Then
      Begin
        if btnCancLib.Visible then
        begin
          btnCancLib.Click;
        end;
      End;
    End

    Else
    If (Shift = [ssAlt]) then
    Begin
      If (Key = VK_F3) Then
      Begin
        btnMnuVendas.Click;
      End
      Else
      If (Key = VK_F4) Then
      Begin
        btnDesmembrarPedido.Click;
      End
      Else
      If (Key = VK_F5) Then
      Begin
        If btnAdiantPed.Visible Then
          btnAdiantPed.Click;
      End
      Else If (Key = VK_F6) Then
      Begin
        If btnConsultaNeocredit.Visible Then
          btnConsultaNeocredit.Click;
      End;
    End

    Else
    If (Key = VK_F2) Then
    Begin
      btnAtualizaPed.Click;
    End
    Else
    If (Key = VK_F3) Then
    Begin
      btnCadCli.Click;
    End
    Else If (Key = VK_F4) Then
    Begin
      btnOcorrencia.Click;
    End
    Else If (Key = VK_F5) Then
    Begin
      btnLimparOcorrencia.Click;
    End
    Else If (Key = VK_F6) Then
    Begin
      btnCtaCorrente.Click;
    End
    Else If (Key = VK_F7) Then
    Begin
      btnResFinanc.Click;
    End
    Else If (Key = VK_F8) Then
    Begin
      btnDadFin.Click;
    End
    Else If (Key = VK_F9) Then
    Begin
      btnReimpressao.Click;
    End
    Else If (Key = VK_F10) Then
    Begin
      Key := 0;
      btnLiberacaoDireta.Click;
    End
    Else If (Key = VK_F11) Then
    Begin
      btnExpandirTodos.Click;
    End
    Else If (Key = VK_F12) Then
    Begin
      btnRetrairTodos.Click;
    End;
  Finally
    blnShowHint := True;
  End;
end;

procedure TfrmCtrLiberacaoPedidos.FormResize(Sender: TObject);
begin
  inherited;
  cxgMotivosDadosMOTIVO.Width := Floor(Self.Width * 0.8);{ 80% da tela }
end;

procedure TfrmCtrLiberacaoPedidos.btnResFinancClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmResFinanceiro,frmResFinanceiro);
    frmResFinanceiro.strCodCli                                   := cdsPedidos.FieldByName('FGO_CODCLI').AsString;
    frmResFinanceiro.blnPermiteEditarArquivosDeConsultaDeCredito := True;
    frmResFinanceiro.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCtrLiberacaoPedidos.btnResFinancClick]');
    End;
  End;
  pFreeAndNil(frmResFinanceiro);

end;

procedure TfrmCtrLiberacaoPedidos.btnRetrairTodosClick(Sender: TObject);
begin
  inherited;

  If (cxgPedidosDados.DataController.DataSource.DataSet.Active) Then
    If (Not cxgPedidosDados.DataController.DataSource.DataSet.IsEmpty) Then
      cxgPedidosDados.ViewData.Collapse(True);

end;

procedure TfrmCtrLiberacaoPedidos.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  cxHint.HideHint;
  intLastRec := -1;
end;

procedure TfrmCtrLiberacaoPedidos.pAtualizaPedidoAlterouFormaPagamento(pgbStatus: TcxProgressBar = nil);
begin
  if fEmptyStr(recInfoPedPagtoAlt.strNumDoc) then
    Exit;

  TfrmGravando.fExecutarModal(pCarregaPedidos,'Aguarde, Atualizando documentos ...', '');

  if not cdsPedidos.Locate('FGO_NUMDOC;FGO_ESPDOC;FGO_CODEMP;FGO_CODCLI', VarArrayOf([recInfoPedPagtoAlt.strNumDoc,recInfoPedPagtoAlt.strEspDoc,recInfoPedPagtoAlt.strCodEmp,recInfoPedPagtoAlt.strCodCli]), []) then
    Exit;

  pLiberacaoPedido(False);

  FillChar(recInfoPedPagtoAlt, SizeOf(recInfoPedPagtoAlt), #0);
end;

procedure TfrmCtrLiberacaoPedidos.btnAdiantPedClick(Sender: TObject);
var
  frmConsultarAdiantamentos: TfrmConsultarAdiantamentos;
begin
  inherited;
  pCriarFormularios(TfrmConsultarAdiantamentos, frmConsultarAdiantamentos);
  Try
    frmConsultarAdiantamentos.pApenasConsulta(cdsPedidos.FieldByName('FGO_NUMDOC').AsString,
                                              cdsPedidos.FieldByName('FGO_CODEMP').AsString,
                                              True);
    frmConsultarAdiantamentos.ShowModal;
  Finally
    pFreeAndNil(frmConsultarAdiantamentos);
  End;
end;

procedure TfrmCtrLiberacaoPedidos.btnAlterarDataEntregaRetiradaClick(
  Sender: TObject);
var
  frmSelFatDigTipoEntregaItens: TfrmSelFatDigTipoEntregaItens;
  fatVenda: TFatVenda;
begin
  inherited;
  objLiberacao.Clear;
  objLiberacao.strDirAce    := 'mnuPermitirAlterarDataEntrega';
  objLiberacao.strCodOpe    := strLoginUsuarioLogado;
  objLiberacao.objMsgLibera.pAddTexto('Alterar data de entrega / situação de retira dos produtos na liberação de pedidos');
  objLiberacao.objMsgLibera.pAddTexto('Pedido...: '+cdsPedidos.FieldByName('FGO_NUMDOC').AsString+' - '+cdsPedidos.FieldByName('FGO_ESPDOC').AsString+' - '+cdsPedidos.FieldByName('FGO_CODEMP').AsString+'');
  objLiberacao.objMsgLibera.pAddTexto('Cliente..: '+cdsPedidos.FieldByName('FGO_CODCLI').AsString+' - '+fRetNomCliente(cdsPedidos.FieldByName('FGO_CODCLI').AsString)+'');

  If (Not objLiberacao.fLibera) Then
  Begin
    Exit;
  End;

  Try
    pCriarFormularios(TfrmSelFatDigTipoEntregaItens, frmSelFatDigTipoEntregaItens);
    Try
      frmSelFatDigTipoEntregaItens.strNumDoc := cdsPedidos.FieldByName('FGO_NUMDOC').AsString;
      frmSelFatDigTipoEntregaItens.strEspDoc := cdsPedidos.FieldByName('FGO_ESPDOC').AsString;
      frmSelFatDigTipoEntregaItens.strCodEmp := cdsPedidos.FieldByName('FGO_CODEMP').AsString;

      If (frmSelFatDigTipoEntregaItens.ShowModal = mrOk) And frmSelFatDigTipoEntregaItens.blnSelecao Then
      Begin
        pCriarFormularios(TfrmFatDigTipoEntregaItens, frmFatDigTipoEntregaItens);
        fatVenda := TFatVenda.CreateInstance('VN');
        try
          fatVenda.strCodCli := cdsPedidos.FieldByName('FGO_CODCLI').AsString;
          fatVenda.strCliOri := cdsPedidos.FieldByName('CLI_NOMCLI').AsString;
          fatVenda.strCodFpg := cdsPedidos.FieldByName('FGO_CODFPG').AsString;
          fatVenda.strConPag := fCondicaoPagamentoSemMascara(cdsPedidos.FieldByName('FGO_CONPAG').AsString);
          fatVenda.strObserv := cdsPedidos.FieldByName('CLI_OBSERV').AsString;

          {**************************************************************}
          {* POSICIONA NO PRIMEIRO ITEM SELECIONADO PARA PEGAR O ENTRET *}
          {*REQ.172201************************************************RP*}
          frmSelFatDigTipoEntregaItens.cdsItens.Locate('SELECAO', 'S', []);
          fatVenda.pSetaIndiceDestino(frmSelFatDigTipoEntregaItens.cdsItens.FieldByName('ITE_ENTRET').AsString);

          If fCfgSis('USACND', varBoolean) And fCfgSis('PFLCLI', varBoolean) Then
            fatVenda.strCodCnd := cdsPedidos.FieldByName('FGO_CODCND').AsString;

          frmFatDigTipoEntregaItens.strCodEmpPosAltEmp := '';
          frmFatDigTipoEntregaItens.intAutIncPosAltEmp := -1;
          frmFatDigTipoEntregaItens.fatVenda := fatVenda;
          frmFatDigTipoEntregaItens.arrSelecaoAutoIncrem := frmSelFatDigTipoEntregaItens.arrSelecaoAutoIncrem;
          frmFatDigTipoEntregaItens.strNumDoc := cdsPedidos.FieldByName('FGO_NUMDOC').AsString;
          frmFatDigTipoEntregaItens.strEspDoc := cdsPedidos.FieldByName('FGO_ESPDOC').AsString;
          frmFatDigTipoEntregaItens.strCodEmp := cdsPedidos.FieldByName('FGO_CODEMP').AsString;
          frmFatDigTipoEntregaItens.ShowModal;
          If frmFatDigTipoEntregaItens.blnAlterou Then
          Begin
            pCarregaPedidos;
            cxgPedidosDados.DataController.Refresh;
          End;
        Finally
          FreeAndNil(fatVenda);
          pFreeAndNil(frmFatDigTipoEntregaItens);
        End;
      End;
    Finally
      pFreeAndNil(frmSelFatDigTipoEntregaItens);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

procedure TfrmCtrLiberacaoPedidos.btnAtualizaPedClick(Sender: TObject);
begin
  inherited;
  pCarregaPedidos;
end;

procedure TfrmCtrLiberacaoPedidos.btnCadCliClick(Sender: TObject);
  Var
    LfrmCadClientes: TfrmCadClientes;
begin
  inherited;
  If Not fVerificaAcessoSistema('frmCadClientes') Then
    Exit;

  If Not Assigned(cdsPedidos) Or (Not cdsPedidos.Active) Then
    Exit;

  Try
    Try
      pCriarFormularios(TfrmCadClientes, LfrmCadClientes);
      LfrmCadClientes.strCodClienteIniciarCadastro := cdsPedidos.FieldByName('FGO_CODCLI').AsString;
      LfrmCadClientes.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  Finally
    pFreeAndNil(LfrmCadClientes);
  End;

end;

procedure TfrmCtrLiberacaoPedidos.btnCancLibClick(Sender: TObject);
var
  strNumRom: string;
  strLotRom: string;
begin
  inherited;

  If (cxgPedidosDados.DataController.FocusedRecordIndex = -1) Then
  Begin
    Exit;
  End;

  If (Not fVerificaAcessoSistema('CALIEF', strLoginUsuarioLogado)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
    Exit;
  End;

  strNumRom := EmptyStr;
  strNumRom := fDocumentoEmRomaneio(cdsPedidos.FieldByName('FGO_NUMDOC').AsString,
                                    cdsPedidos.FieldByName('FGO_ESPDOC').AsString);
  If (Not fEmptyStr(strNumRom)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Este pedido já foi inserido no Romaneio '+strNumRom+' e não pode ter sua liberação cancelada.', ['&Ok']);
    Exit;
  End;

  If (fCfgSis('ADINPD', VarBoolean)) And (TAdiantamento.fGetTotaisAdiantamento(cdsPedidos.FieldByName('FGO_NUMDOC').AsString,
                                                                               cdsPedidos.FieldByName('FGO_ESPDOC').AsString,
                                                                               cdsPedidos.FieldByName('FGO_CODEMP').AsString).fltValLan > 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Este pedido já possui adiantamento e não pode ter sua liberação cancelada (CFG_ADINPD).', ['&Ok']);
    Exit;
  End;

  If (fPedidoFoiExpedido(cdsPedidos.FieldByName('FGO_NUMDOC').AsString,
                         cdsPedidos.FieldByName('FGO_CODEMP').AsString,
                         cdsPedidos.FieldByName('FGO_CODCLI').AsString)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Este pedido já foi expedido e não pode ter sua liberação cancelada.', ['&Ok']);
    Exit;
  End;

  strLotRom := EmptyStr;
  strLotRom := fDocumentoEmLoteSeparacaoRomaneio(cdsPedidos.FieldByName('FGO_NUMDOC').AsString,
                                                 cdsPedidos.FieldByName('FGO_ESPDOC').AsString,
                                                 cdsPedidos.FieldByName('FGO_CODEMP').AsString);
  If (Not fEmptyStr(strLotRom)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Este pedido já foi inserido em um lote de separação para Romaneio '+strLotRom+' e não pode ter sua liberação cancelada.', ['&Ok']);
    Exit;
  End;

  If (fPedidoOrcamentoFormulacaoJaBaixada(cdsPedidos.FieldByName('FGO_NUMDOC').AsString,
                                          cdsPedidos.FieldByName('FGO_ESPDOC').AsString,
                                          cdsPedidos.FieldByName('FGO_CODEMP').AsString,
                                          cdsPedidos.FieldByName('FGO_CODCLI').AsString)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Este pedido já teve sua formulação de tinta baixada e não pode ter sua liberação cancelada.', ['&Ok']);
    Exit;
  End;

  objLiberacao.Clear;
  objLiberacao.strDirAce    := 'CALIEF';
  objLiberacao.strCodOpe    := strLoginUsuarioLogado;
  objLiberacao.objMsgLibera.pAddTexto('Permitir cancelar liberação de pedido já efetuada.');
  objLiberacao.objMsgLibera.pAddTexto('Documento...: '+cdsPedidos.FieldByName('FGO_NUMDOC').AsString+' - '+cdsPedidos.FieldByName('FGO_ESPDOC').AsString+' - '+cdsPedidos.FieldByName('FGO_CODEMP').AsString+'');
  objLiberacao.objMsgLibera.pAddTexto('Cliente.....: '+cdsPedidos.FieldByName('FGO_NUMDOC').AsString+' - '+fRetNomCliente(cdsPedidos.FieldByName('FGO_CODCLI').AsString)+'');

  If (Not objLiberacao.fLibera) Then
  Begin
    Exit;
  End;

  If (fCancelaLiberacao(cdsPedidos.FieldByName('FGO_NUMDOC').AsString,
                       cdsPedidos.FieldByName('FGO_ESPDOC').AsString,
                       cdsPedidos.FieldByName('FGO_CODEMP').AsString,
                       cdsPedidos.FieldByName('FGO_CODCLI').AsString,
                       objLiberacao.strOperador)) Then
  Begin
    fMensagem('', 'Cancelamento da liberação efetuado com sucesso!', ['&Ok']);
    pCarregaPedidos;
    cxgPedidosDados.DataController.Refresh;
  End;
end;

procedure TfrmCtrLiberacaoPedidos.btnConsultaNeocreditClick(Sender: TObject);
begin
  inherited;

  If Not TFacadeNeocredit.AnaliseNeocreditAtivada Then
    Exit;

  If fMensagem('AVISO!', 'Realizar análise de limite de crédito na Neocredit?', ['&Sim', '&Não']) = 2 then
    Exit;

  TFrmGravando.fExecutarModalA(pExecutarConsultaNeocredit, 'Aguarde... Analisando Limite de Crédito do cliente na Neocredit!', '');
end;

procedure TfrmCtrLiberacaoPedidos.btnCtaCorrenteClick(Sender: TObject);
begin
  inherited;
  TfrmMostraDebCtrChq2.pMostraContaCorrente(cdsPedidos.FieldByName('FGO_CODCLI').AsString);
end;

procedure TfrmCtrLiberacaoPedidos.btnDadFinClick(Sender: TObject);
  Var
    objFinanceira: TFinanceira;
begin
  inherited;
  If Not btnDadFin.Visible Then
    Exit;

  If cdsPedidos.IsEmpty Then
    Exit;

  objFinanceira := TFinanceira.Create(Self);

  pCriarFormularios(TfrmDigFinanceira, frmDigFinanceira);
  With frmDigFinanceira Do
  Begin
    objFinanceira.pCarregaFinanciamento('FATGOR', cdsPedidos.FieldByName('AUTOINCREM').AsString);
    objFinanceira.pCarregaDados(arrCarFin, cdsSelFin);
    pnlDados.Visible    := False;
    btnConfirma.Visible := False;
    btnExcluir.Visible  := False;
    ShowModal;
  End;
  FreeAndNil(frmDigFinanceira);

  FreeAndNil(objFinanceira);
end;

procedure TfrmCtrLiberacaoPedidos.btnDesmembrarPedidoClick(Sender: TObject);
var
  frmFatDesmembrarPedido: TfrmFatDesmembrarPedido;
begin
  inherited;
  if not fVerificaAcessoSistema('frmFatDesmembrarPedido') then
  begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
    Exit;
  end;

  pCriarFormularios(TfrmFatDesmembrarPedido,frmFatDesmembrarPedido);

  try
    if (cdsPedidos.Active) and (not cdsPedidos.IsEmpty) and (cdsPedidos.RecNo > 0) then
    begin
      frmFatDesmembrarPedido.edtNumDoc.Text := cdsPedidos.FieldByName('FGO_NUMDOC').AsString;
      frmFatDesmembrarPedido.blnLiberacaoPedido := True;
      frmFatDesmembrarPedido.blnPermiteAlterarCndPag := True;
    end;
    frmFatDesmembrarPedido.ShowModal;
  finally
    pFreeAndNil(frmFatDesmembrarPedido);
  end;

  pCarregaPedidos;
  cxgPedidosDados.DataController.Refresh;
end;

procedure TfrmCtrLiberacaoPedidos.btnExpandirTodosClick(Sender: TObject);
begin
  inherited;

  If (cxgPedidosDados.DataController.DataSource.DataSet.Active) Then
    If (Not cxgPedidosDados.DataController.DataSource.DataSet.IsEmpty) Then
      cxgPedidosDados.ViewData.Expand(True);

end;

procedure TfrmCtrLiberacaoPedidos.btnLiberacaoDiretaClick(Sender: TObject);
begin
  inherited;
  If Not TFacadeNeocredit.PermiteLiberarPedidoSemAutorizacaoNeocredit(
                            cdsPedidos.FieldByName('FGO_CODCLI').AsString) Then
    Exit;

  If btnLiberacaoDireta.Visible Then
  Begin
    Try
      cxgPedidos.BeginUpdate;
      pLiberacaoPedido(True);
    Finally
      cxgPedidos.EndUpdate;
    End;
  End;
end;

procedure TfrmCtrLiberacaoPedidos.btnLimparOcorrenciaClick(Sender: TObject);
var
  qryTemp :TUniQuery;
begin
  If (cxgPedidosDados.DataController.FocusedRecordIndex = -1) then
  begin
    fMensagem('ATENÇÃO!', 'Nenhum pedido listado!', ['&Ok']);
    Exit;
  end

  else If ((cdsPedidos.FieldByName('FGO_LIBERA').AsInteger > 0) And (strTipLib = '1')) Or
     ((cdsPedidos.FieldByName('FGO_LIBCOM').AsInteger > 0) And (strTipLib = '2')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é possível editar a ocorrência do pedido '
          +fNroPedido +'.' +#13#10 +'Pedido já foi liberado.', ['&Ok']);
    Exit;
  End

  Else
  begin
    if cdsPedidos.FieldByName('FGO_OCOLIB').IsNull then
      fMensagem('ATENÇÃO!', 'Nenhuma ocorrência encontrada para o pedido ' +fNroPedido +'.', ['&Ok'])

    else if fMensagem('AVISO!', 'Limpar a ocorrência de liberação do pedido '
          +fNroPedido +' ?', ['&Sim', '&Não']) = 1 then
    begin
      Try
        Try
          qryTemp := fCriaQuery(nil);

          fStartTransaction;

          qryTemp.Close;
          qryTemp.SQL.Clear;
          qryTemp.SQL.Text := 'UPDATE EXTGOR SET FGO_OCOLIB = NULL, ' +
                                  ' FGO_HISCOM = NULL WHERE FGO_SEQFGO = :SEQFGO';

          qryTemp.ParamByName('SEQFGO').AsString := cdsPedidos.FieldByName('AUTOINCREM').AsString;
          qryTemp.ExecSQL;
          fCommit;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[TfrmCtrLiberacaoPedidos.btnLimparOcorrenciaClick]');
            fRollBack;
          End;
        End;

      Finally
        begin
          cdsPedidos.Refresh;
          cxgPedidosDados.ApplyBestFit;

          pFreeAndNil(qryTemp);
        end;
      end;
    end;
  end;
end;

procedure TfrmCtrLiberacaoPedidos.btnMnuVendasClick(Sender: TObject);
Var
  x,y : Integer;
begin
  inherited;
  x := Self.Left + btnMnuVendas.Left;
  y := Self.Top + Self.Height - (pnlBotoes.Height + pnlInfo.Height);

  popBotoes.Popup(x,y);
end;

procedure TfrmCtrLiberacaoPedidos.btnOcorrenciaClick(Sender: TObject);
var
  qryTemp :TUniQuery;
begin
  If (cxgPedidosDados.DataController.FocusedRecordIndex = -1) then
  begin
    fMensagem('ATENÇÃO!', 'Nenhum pedido listado!', ['&Ok']);
    Exit;
  end

  else If ((cdsPedidos.FieldByName('FGO_LIBERA').AsInteger > 0) And (strTipLib = '1')) Or
     ((cdsPedidos.FieldByName('FGO_LIBCOM').AsInteger > 0) And (strTipLib = '2')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é possível editar a ocorrência do pedido '
          +fNroPedido +'.' +#13#10 +'Pedido já foi liberado.', ['&Ok']);
    Exit;
  End

  Else
  begin
    Try
      Try
        pCriarFormularios(TfrmDigOcorrencia, frmDigOcorrencia);

        frmDigOcorrencia.blnInformarHisCom := True;

        frmDigOcorrencia.strCodOco := cdsPedidos.FieldByName('FGO_OCOLIB').AsString;
        frmDigOcorrencia.strDesOco := cdsPedidos.FieldByName('OCO_DESOCO').AsString;
        frmDigOcorrencia.edtHisCom.Text := cdsPedidos.FieldByName('FGO_HISCOM').AsString;;

        frmDigOcorrencia.ShowModal;

        If (frmDigOcorrencia.ModalResult = mrOk) Then
        Begin
          strMotDel := frmDigOcorrencia.strCodOco;
          strDesMot := frmDigOcorrencia.strDesOco;
          strHisCom := frmDigOcorrencia.strHisCom;

          qryTemp := fCriaQuery(nil);

          fStartTransaction;

          qryTemp.Close;
          qryTemp.SQL.Clear;
          qryTemp.SQL.Text := 'UPDATE EXTGOR SET FGO_OCOLIB = :OCOLIB, ' +
                                  ' FGO_HISCOM = :HISCOM WHERE FGO_SEQFGO = :SEQFGO';

          If (fEmptyStr(strMotDel)) Then
            qryTemp.ParamByName('OCOLIB').Value := Null
          Else
            qryTemp.ParamByName('OCOLIB').AsString := strMotDel;

          If (fEmptyStr(strHisCom)) Then
            qryTemp.ParamByName('HISCOM').Value := Null
          Else
            qryTemp.ParamByName('HISCOM').AsString := strHisCom;

          qryTemp.ParamByName('SEQFGO').AsString := cdsPedidos.FieldByName('AUTOINCREM').AsString;
          qryTemp.ExecSQL;
          fCommit;
        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmCtrLiberacaoPedidos.btnOcorrenciaClick]');
          fRollBack;
        End;
      End;

    Finally

      cdsPedidos.Refresh;

      Try
        cxgPedidosDados.BeginUpdate();
        cxgPedidosDados.ApplyBestFit;
      Finally
        cxgPedidosDados.EndUpdate();
      End;

      pFreeAndNil(qryTemp);
      pFreeAndNil(frmDigOcorrencia);
    end;
  end;
end;

procedure TfrmCtrLiberacaoPedidos.btnPadraoClick(Sender: TObject);
begin
  inherited;
  btnPadrao.Enabled := False;
  mmsLayoutDefault.Position := 0;
  cxgPedidosDados.RestoreFromStream(mmsLayoutDefault);
  btnPadrao.Enabled := True;
end;

procedure TfrmCtrLiberacaoPedidos.btnReimpressaoClick(Sender: TObject);
begin
  inherited;
  If (cdsPedidos.FieldByName('FGO_LIBERA').AsInteger > 0) And (strTipLib = '1') Or
     (cdsPedidos.FieldByName('FGO_LIBCOM').AsInteger > 0) And (strTipLib = '2') Then
  Begin
    TReimpressao.Create(cdsPedidos.FieldByName('FGO_NUMDOC').AsString,
                        cdsPedidos.FieldByName('FGO_ESPDOC').AsString,
                        0, 0, '',
                        cdsPedidos.FieldByName('FGO_CODEMP').AsString,
                        '', False, '', False, False,
                        False, '', '', False, 0, False, '').pReimprimeDocumento;
  End
  Else
  Begin
    fMensagem('ATENÇÃO!', 'O pedido ' +fNroPedido +' não está liberado!', ['&Ok']);
  End;
end;

procedure TfrmCtrLiberacaoPedidos.btnSelecionaClick(Sender: TObject);
begin
  inherited;
  pLiberacaoPedido(False);
end;

procedure TfrmCtrLiberacaoPedidos.cdsPedidosAfterOpen(DataSet: TDataSet);
var
  intRecNo: Integer;
begin
  inherited;
  Try
    DataSet.DisableControls;
    intRecNo := DataSet.RecNo;

    With DataSet Do
    Begin
      If Not IsEmpty Then
      Begin
        First;

        While Not Eof Do
        Begin
          Edit;
          FieldByName('FGO_CONPAG').AsString := fFormataCondPag(FieldByName('FGO_CONPAG').AsString);
          FieldByName('DESPAG').AsString := FieldByName('FGO_CONPAG').AsString + ' - ' + fRetDesConPag(FieldByName('FGO_CODCND').AsString);

          If blnUtilizaOSVenda Then
          Begin
            FieldByName('FGO_STATOS').AsString := fRetStatusOs(FieldByName('FGO_NUMDOC').AsString,
                                                               FieldByName('FGO_ESPDOC').AsString,
                                                               FieldByName('FGO_CODEMP').AsString);
            FieldByName('FGO_STATOP').AsString := fRetStatusOp(FieldByName('FGO_NUMDOC').AsString,
                                                               FieldByName('FGO_ESPDOC').AsString,
                                                               FieldByName('FGO_CODEMP').AsString);
          End;

          Post;

          Next;
        End;
      End;
    End;

    DataSet.RecNo := intRecNo;
  Finally
    DataSet.EnableControls;
  End;
end;

procedure TfrmCtrLiberacaoPedidos.cdsPedidosAfterRefresh(DataSet: TDataSet);
begin
  inherited;
  cdsPedidosAfterOpen(cdsPedidos);
end;

procedure TfrmCtrLiberacaoPedidos.cdsPedidosAfterScroll(DataSet: TDataSet);
begin
  inherited;
  If Not cdsPedidos.ControlsDisabled Then
  Begin
    btnDadFin.Visible := DataSet.FieldByName('FGO_CODFPG').AsString = '016';
    btnCancLib.Visible := ((cdsPedidos.FieldByName('FGO_LIBERA').AsInteger > 0) And (strTipLib = '1')) Or ((cdsPedidos.FieldByName('FGO_LIBCOM').AsInteger > 0) And (strTipLib = '2'));
  End;
end;

procedure TfrmCtrLiberacaoPedidos.cdsPedidosBeforeRefresh(DataSet: TDataSet);
begin
  inherited;
  cdsPedidos.CancelUpdates;
end;

procedure TfrmCtrLiberacaoPedidos.cxgMotivosDadosMouseLeave(Sender: TObject);
begin
  inherited;
  cxHint.HideHint;
  intLastRec := -1;
end;

procedure TfrmCtrLiberacaoPedidos.cxgMotivosDadosMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  Site: TcxGridSite;
  HitTest: TcxCustomGridHitTest;
begin
  Inherited;

  If Not blnShowHint Then
  Begin
    cxHint.HideHint;
    intLastRec := -1;
    Exit;
  End;

  Site := Sender as TcxGridSite;
  HitTest := Site.GridView.ViewInfo.GetHitTest(X, Y);

  if HitTest is TcxGridRecordCellHitTest then
  begin

    If (TcxGridRecordCellHitTest(HitTest).GridRecord.RecordIndex >= 0) And
       (cxgMotivosDadosMOTIVO.Index = TcxGridRecordCellHitTest(HitTest).Item.Index) And
       (TcxGridRecordCellHitTest(HitTest).GridRecord.RecordIndex <> intLastRec) Then
    Begin
      intLastRec := TcxGridRecordCellHitTest(HitTest).GridRecord.RecordIndex;
      If Not fEmptyStr(VarToStr(Site.GridView.DataController.Values[intLastRec, cxgMotivosDadosINFLIB.Index])) Then
      Begin
        Try
          cxHint.ShowHint(Mouse.CursorPos.X + 3, Mouse.CursorPos.Y + 3,'',
                          ReplaceStr(VarToStr(Site.GridView.DataController.Values[intLastRec, cxgMotivosDadosINFLIB.Index]), '<<csq>>', #13 ));
        Except

        End;
      End
      Else
      Begin
        cxHint.HideHint;
        intLastRec := -1;
      End;
    End;

    If (cxgMotivosDadosMOTIVO.Index <> TcxGridRecordCellHitTest(HitTest).Item.Index) Or
       (TcxGridRecordCellHitTest(HitTest).GridRecord.RecordIndex <> intLastRec) Then
    Begin
      cxHint.HideHint;
      intLastRec := -1;
    End;
  end
  Else
  Begin
    cxHint.HideHint;
    intLastRec := -1;
  End;
end;

procedure TfrmCtrLiberacaoPedidos.cxgPedidosDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);

  function fGetValue(Column: TcxGridDBColumn): Variant;
  begin
    Result := Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, Column.Index];
  end;

begin
  inherited;

  If (Not cdsPedidos.Active) Then
    Exit;

  If (Not AViewInfo.GridRecord.IsData) Or
     (AViewInfo.GridRecord.Index = -1) Then
    Exit;

  If (ACanvas.Brush.Color <> clHighlight) Then
    ACanvas.Brush.Color := cl3DLight;

  If (AViewInfo.Item.SortOrder <> soNone) And
     (Not AViewInfo.Selected) Then
    ACanvas.Brush.Color := clInfoBk;

  If VarToStr(fGetValue(cxgPedidosDadosFGO_TIPOPE)) = 'B' Then
  Begin
    ACanvas.Font.Color := shpBonifica.Brush.Color;
  End;

  If (VarToStr(fGetValue(cxgPedidosDadosFGO_TIPPED)) = 'A') And
     (fStrToFloat(VarToStr(fGetValue(cxgPedidosDadosVALFUT))) > 0.00) And
     (fStrToFloat(VarToStr(fGetValue(cxgPedidosDadosVALFUT))) < fValorMinimoNotaFiscalEntrega(LeftStr(VarToStr(fGetValue(cxgPedidosDadosFGO_NOMCLI)), 8))) Then
  Begin
    ACanvas.Font.Color := shpVlrMin.Brush.Color;
  End;

  If (VarToStr(fGetValue(cxgPedidosDadosFGO_TIPPED)) = 'A') And
     (fStrToFloat(VarToStr(fGetValue(cxgPedidosDadosVALENT))) > 0.00) And
     (fStrToFloat(VarToStr(fGetValue(cxgPedidosDadosVALENT))) < fValorMinimoNotaFiscalEntrega(LeftStr(VarToStr(fGetValue(cxgPedidosDadosFGO_NOMCLI)), 8))) Then
  Begin
    ACanvas.Font.Color := shpVlrMin.Brush.Color;
  End;

  If (VarToStr(fGetValue(cxgPedidosDadosFGO_TIPPED)) = 'A') And
     (fStrToFloat(VarToStr(fGetValue(cxgPedidosDadosVALRET))) > 0.00) And
     (fStrToFloat(VarToStr(fGetValue(cxgPedidosDadosVALRET))) < fValorMinimoNotaFiscalRetira(LeftStr(VarToStr(fGetValue(cxgPedidosDadosFGO_NOMCLI)), 8))) Then
  Begin
    ACanvas.Font.Color := shpVlrMin.Brush.Color;
  End;

  If ((fStrToFloat(VarToStr(fGetValue(cxgPedidosDadosFGO_LIBERA))) > 0) And (strTipLib = '1')) Or
     ((fStrToFloat(VarToStr(fGetValue(cxgPedidosDadosFGO_LIBCOM))) > 0) And (strTipLib = '2')) Then
  Begin
    ACanvas.Font.Color := shpLiberados.Brush.Color;
  End;

  If (AViewInfo.Item.Index In [cxgPedidosDadosDIR_ACE_ENTURG.Index]) Then
  Begin
    If VarToStr(fGetValue(cxgPedidosDadosDIR_ACE_ENTURG)) = 'S' Then
    Begin
      ACanvas.Brush.Color := clGreen;
      ACanvas.Font.Color  := clGreen;
    End
    Else
    Begin
      ACanvas.Brush.Color := clRed;
      ACanvas.Font.Color  := clRed;
    End;
  End;

  If (shpDigVen.Visible) And
     (AViewInfo.Item.Index In [cxgPedidosDadosDIGITADOR.Index, cxgPedidosDadosVENDEDOR.Index]) And
     (VarToStr(fGetValue(cxgPedidosDadosDIGITADOR)) = VarToStr(fGetValue(cxgPedidosDadosVENDEDOR))) Then
  Begin
    ACanvas.Brush.Color := shpDigVen.Brush.Color;
    ACanvas.Font.Color  := clBlack;
  End;

  If (blnUtilizaOSVenda) And (fGetValue(cxgPedidosDadosFGO_PREVIS) <> Null) And
     (VarToDateTime(fGetValue(cxgPedidosDadosFGO_PREVIS)) > VS_Date) Then
    ACanvas.Brush.Color := shpNaoHoje.Brush.Color;

  If (VarToStr(fGetValue(cxgPedidosDadosCODCAC)) <> '') and  (VarToStr(fGetValue(cxgPedidosDadosCORILP)) <> '') and
     (AViewInfo.Item.Index In [cxgPedidosDadosCODCAC.Index]) Then
    ACanvas.Brush.Color := fGetValue(cxgPedidosDadosCORILP);

  If (VarToStr(fGetValue(cxgPedidosDadosCODRED)) <> '') and
     (AViewInfo.Item.Index In [cxgPedidosDadosCODRED.Index]) Then
    ACanvas.Brush.Color := clMagenta;

  If ACanvas.Brush.Color = clHighlight Then
    ACanvas.Font.Color := clWhite;

end;

procedure TfrmCtrLiberacaoPedidos.cxgPedidosDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  blnShowHint := False;
  cxHint.HideHint;
  intLastRec := -1;

  Try
    If (Key = VK_RETURN) Then
      btnSeleciona.Click
    Else If (Key = VK_ESCAPE) Then
      btnSair.Click;
  Finally
    blnShowHint := True;
  End;
end;

procedure TfrmCtrLiberacaoPedidos.cxgPedidosDadosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  cxHint.HideHint;
  intLastRec := -1;
end;

procedure TfrmCtrLiberacaoPedidos.cxgPedidosDadosMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  cxHint.HideHint;
end;

procedure TfrmCtrLiberacaoPedidos.cxgPedidosDadosSTANEOGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  AText := TLibNeocredit.RetornaDescricaoStatus(AText);
end;

procedure TfrmCtrLiberacaoPedidos.cxgPedidosLayoutChanged(Sender: TcxCustomGrid; AGridView: TcxCustomGridView);
begin
  inherited;
  pPosicionarColunaVerdeVermelho;
end;

procedure TfrmCtrLiberacaoPedidos.dtsPedidosDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  If Assigned(Field) And (Field.FieldName = 'FGO_ENTURG') Then
    pGravaEntUrg;

  If MatchStr(cdsPedidos.FieldByName('SITADT').AsString, ['Realizado', 'Parcialmente']) Then
    btnAdiantPed.Visible := True
  Else
    btnAdiantPed.Visible := False;
end;

function TfrmCtrLiberacaoPedidos.fCancelaLiberacao(strNumDoc, strEspDoc,
  strCodEmp, strCodCli, strCodOpe: string): Boolean;
var
  qryCancLib: TUniQuery;
  objOcoCrm : TAtuOcoCrm;
begin
  Result := False;
  fStartTransaction;
  qryCancLib := fCriaQuery;

  try
    try
      qryCancLib.Close;
      qryCancLib.SQL.Clear;
      qryCancLib.SQL.Add('UPDATE FATGOR');
      qryCancLib.SQL.Add('SET');

      if (strTipLib = '1') then
      begin
        qryCancLib.SQL.Add('FGO_OPELIB = NULL, ');
        qryCancLib.SQL.Add('FGO_DIGLIB = NULL, ');
        qryCancLib.SQL.Add('FGO_DTALIB = NULL, ');
        qryCancLib.SQL.Add('FGO_HORLIB = NULL, ');
        qryCancLib.SQL.Add('FGO_OBSL01 = NULL, ');
        qryCancLib.SQL.Add('FGO_OBSL02 = NULL, ');
        qryCancLib.SQL.Add('FGO_LIBERA = 0     ');
      end
      else if (strTipLib = '2') then
      begin
        qryCancLib.SQL.Add('FGO_OPELIC = NULL, ');
        qryCancLib.SQL.Add('FGO_DIGLIC = NULL, ');
        qryCancLib.SQL.Add('FGO_DTALIC = NULL, ');
        qryCancLib.SQL.Add('FGO_HORLIC = NULL, ');
        qryCancLib.SQL.Add('FGO_OBSLC1 = NULL, ');
        qryCancLib.SQL.Add('FGO_OBSLC2 = NULL, ');
        qryCancLib.SQL.Add('FGO_LIBCOM = 0     ');
      end;

      qryCancLib.SQL.Add('WHERE FGO_NUMDOC = :NUMDOC');
      qryCancLib.SQL.Add('  AND FGO_ESPDOC = :ESPDOC');
      qryCancLib.SQL.Add('  AND FGO_CODEMP = :CODEMP');
      qryCancLib.SQL.Add('  AND FGO_CODCLI = :CODCLI');

      qryCancLib.ParamByName('NUMDOC').AsString := strNumDoc;
      qryCancLib.ParamByName('ESPDOC').AsString := strEspDoc;
      qryCancLib.ParamByName('CODEMP').AsString := strCodEmp;
      qryCancLib.ParamByName('CODCLI').AsString := strCodCli;

      qryCancLib.ExecSQL;

      fCommit;

      If (VS_strHabilitarCRM) And (Not fEmptyStr(fCfgSis('VENORC', varString))) And (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
      begin
        objOcoCrm := fAtualizaInformacoesCRM(strNumDoc, strEspDoc, strCodEmp, strCodCli, '', '', strCodOpe, afcPedidoLiberacaoCancelado);
        try
          objOcoCrm.strNomFrm := Self.Name;
          objOcoCrm.pProcessaFatOcorrenciasCRM;
        finally
          FreeAndNil(objOcoCrm);
        end;
      end;

      Result := True;
    except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '');
        fRollBack;
      end;
    end;
  finally
    FreeAndNil(qryCancLib);
  end;
end;

function TfrmCtrLiberacaoPedidos.fCondicaoPagamentoSemMascara(
  strConPag: String): String;
begin
  Result := TRegEx.Replace(strConPag, '([().])', '');
end;

function TfrmCtrLiberacaoPedidos.fDocumentoEmLoteSeparacaoRomaneio(strNumDoc,
  strEspDoc, strCodEmp: string): string;
var
  qryLoteRom: TUniQuery;
begin
  Result := EmptyStr;
  qryLoteRom := fCriaQuery;

  try
    qryLoteRom.Close;
    qryLoteRom.SQL.Clear;
    qryLoteRom.SQL.Add('SELECT CONCAT(RG.RLG_NUMLOT, " - ", RG.RLG_CODEMP) AS NUMROM');
    qryLoteRom.SQL.Add('FROM ROMLGE RG');
    qryLoteRom.SQL.Add('INNER JOIN ROMLDE RD');
    qryLoteRom.SQL.Add('ON(RG.AUTOINCREM = RD.RLD_SEQRLG)');
    qryLoteRom.SQL.Add('INNER JOIN FATGOR FG');
    qryLoteRom.SQL.Add('ON(FG.FGO_NUMDOC = RD.RLD_NUMDOC AND FG.FGO_ESPDOC = RD.RLD_ESPDOC AND FG.FGO_CODEMP = RD.RLD_CODEMP AND FG.FGO_SERIE_ = RD.RLD_SERIE_)');
    qryLoteRom.SQL.Add('WHERE RD.RLD_NUMDOC = :NUMDOC');
    qryLoteRom.SQL.Add('AND RD.RLD_ESPDOC = :ESPDOC');
    qryLoteRom.SQL.Add('AND RD.RLD_CODEMP = :CODEMP');

    qryLoteRom.ParamByName('NUMDOC').AsString := strNumDoc;
    qryLoteRom.ParamByName('ESPDOC').AsString := strEspDoc;
    qryLoteRom.ParamByName('CODEMP').AsString := strCodEmp;

    qryLoteRom.Open;

    if not qryLoteRom.IsEmpty then
    begin
      Result := qryLoteRom.FieldByName('NUMROM').AsString;
    end;
  finally
    FreeAndNil(qryLoteRom);
  end;
end;

function TfrmCtrLiberacaoPedidos.fEhEmissaoDocumentoWMS(strCodEmp,
  strEspDoc: String): Boolean;
begin
  Result := fUsaRotinaWMS(strCodEmp) And
            MatchStr(strEspDoc, ['PD','OR', 'EF', 'OE']);
end;

function TfrmCtrLiberacaoPedidos.fEmpresaParaFaturamentoUsaWMS(strCodEmp,
  strEspDoc: String): Boolean;
begin
  If Not fPermiteInformarEmpresaNoItem(strEspDoc) Then
    Result := fEhEmissaoDocumentoWMS(strCodEmp, strEspDoc)
  Else
    Result := (Not fEmptyStr(strCodEmp)) And fUsaRotinaWMS(strCodEmp);
end;

function TfrmCtrLiberacaoPedidos.fGetChaveLayoutGrid: String;
begin
  Result := Self.Name + '.' + strTipLib + '.' + cxgPedidosDados.Name;
end;

procedure TfrmCtrLiberacaoPedidos.pCarregaMotivos;
  Var
    qryMotivos: TUniQuery;
    stlTravas: TStrings;
    intIdx: Integer;

  function fGetMotivo(strInfBlo: String): String;
  begin
    Result := LeftStr(strInfBlo, Pos(#13#10, strInfBlo) -1);
  end;

begin
  qryMotivos := fCriaQuery;

  Try
    With qryMotivos Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('  FATGOR.AUTOINCREM, ');
      SQL.Add('  LPD_DIRACE AS DIRACE, ');
      SQL.Add('  LPD_INFBLO AS INFBLO, ');
      SQL.Add('  LPD_INFLIB AS INFLIB, ');
      SQL.Add('  LPD_VLRCON AS VLRCON, ');
      SQL.Add('  LPD_CONPAG AS CONPAG, ');
      SQL.Add('  CONCAT(V.OPE_CODOPE, "-", V.OPE_NOMOPE) AS NOMVEN ');
      SQL.Add('FROM ');
      SQL.Add('  LIBPED ');
      SQL.Add('  LEFT JOIN CADOPE V ON V.OPE_CODOPE = LPD_CODVEN  ');
      SQL.Add('  INNER JOIN FATGOR ON LPD_NUMDOC = FGO_NUMDOC AND ');
      SQL.Add('                       LPD_ESPDOC = FGO_ESPDOC AND ');
      SQL.Add('                       LPD_CODEMP = FGO_CODEMP AND ');
      SQL.Add('                       LPD_CODCLI = FGO_CODCLI ');
      SQL.Add('  LEFT JOIN EXTGOR ON FATGOR.AUTOINCREM = FGO_SEQFGO ');
      SQL.Add('WHERE ');
      SQL.Add('  LPD_OPELIB IS NULL AND ');

      If Not fCfgSis('LPDOEM', VarBoolean) Then
        SQL.Add('  FGO_CODEMP = :CODEMP AND ');

      SQL.Add('  FGO_CODVEN LIKE :CODVEN AND ');
      SQL.Add('  FGO_ESPDOC = "PD" AND ');
      SQL.Add('  IFNULL(FGO_DOCEND,  "") = ""  AND ');
      SQL.Add('  IFNULL(FGO_ENVLIB, "S") = "S" AND ');
      SQL.Add('  FGO_JAFATU = FALSE            AND ');
      SQL.Add('  FGO_VLRCON > 0 ');

      If (strStatus = 'N') And (strTipLib = '1') Then
        SQL.Add('  AND IFNULL(FGO_LIBERA, 0) = 0 ')
      Else If (strStatus = 'L') And (strTipLib = '1') Then
        SQL.Add('  AND IFNULL(FGO_LIBERA, 0) > 0 ')
      Else If (strStatus = 'N') And (strTipLib = '2') Then
        SQL.Add('  AND IFNULL(FGO_LIBCOM, 0) = 0 ')
      Else If (strStatus = 'L') And (strTipLib = '2') Then
        SQL.Add('  AND IFNULL(FGO_LIBCOM, 0) > 0 ');

      SQL.Add('ORDER BY ');
      SQL.Add('  LPD_DTACAD, LPD_HORCAD ');

      If Not fCfgSis('LPDOEM', VarBoolean) Then
        ParamByName('CODEMP').AsString := VS_strCodEmp;

      ParamByName('CODVEN').AsString := strCodVen + '%';

      Open;

      cdsMotivos.EmptyDataSet;

      Try
        cdsMotivos.DisableControls;

        While Not Eof Do
        Begin
          cdsMotivos.Append;
          cdsMotivosAUTOINCREM.AsString := FieldByName('AUTOINCREM').AsString;
          cdsMotivosDIRACE.AsString     := FieldByName('DIRACE').AsString;
          cdsMotivosMOTIVO.AsString     := fGetMotivo(FieldByName('INFBLO').AsString);
          cdsMotivosINFLIB.AsString     := FieldByName('INFLIB').AsString;
          cdsMotivosVLRCON.AsFloat      := FieldByName('VLRCON').AsFloat;
          cdsMotivosCONPAG.AsString     := fFormataCondPag(FieldByName('CONPAG').AsString);
          cdsMotivosNOMVEN.AsString     := FieldByName('NOMVEN').AsString;
          cdsMotivos.Post;
          Next;
        End;

      Finally
        cdsMotivos.EnableControls;
      End;
    End;
  Finally
    FreeAndNil(qryMotivos);
  End;
  cdsPedidos.DisableControls;
  cdsMotivos.DisableControls;
  cdsPedidos.First;
  stlTravas := TStringList.Create;

  Try
    While Not cdsPedidos.Eof Do
    Begin
      if (cdsMotivos.locate('AUTOINCREM',cdsPedidos.FieldByName('AUTOINCREM').AsString,[])) then
      begin
        cdsPedidos.Next;
        continue;
      end;

      If (Pos('S', cdsPedidos.FieldByName('FGO_NTRAVA').AsString) > 0) then
      Begin
        stlTravas.Clear;
        ExtractStrings(
          [#13, #10],
          [' '],
          pChar(
            TfrmCtrLiberaPedidosConf.fMotivoDoBloqueio(
              cdsPedidos.FieldByName('FGO_NTRAVA').AsString,
              cdsPedidos.FieldByName('FGO_MOTLIB').AsString)
            ),
          stlTravas);

        For intIdx := 0 To stlTravas.Count - 1 Do
        Begin
          cdsMotivos.Insert;
          cdsMotivosAUTOINCREM.AsString := cdsPedidos.FieldByName('AUTOINCREM').AsString;
          cdsMotivosDIRACE.AsString     := '';
          cdsMotivosMOTIVO.AsString     := stlTravas[intIdx];
          cdsMotivosINFLIB.AsString     := '';
          cdsMotivosVLRCON.AsFloat      := cdsPedidos.FieldByName('FGO_VLRCON').AsFloat;
          cdsMotivosCONPAG.AsString     := cdsPedidos.FieldByName('FGO_CONPAG').AsString;
          cdsMotivosNOMVEN.AsString     := cdsPedidos.FieldByName('VENDEDOR').AsString;
          cdsMotivos.Post;
        End;
      End
      Else If (not fEmptyStr(cdsPedidos.FieldByName('FGO_NUMPOK').AsString)) Then
      begin
        cdsMotivos.Append;
        cdsMotivosAUTOINCREM.AsString := cdsPedidos.FieldByName('AUTOINCREM').AsString;
        cdsMotivosDIRACE.AsString     := '';
        cdsMotivosMOTIVO.AsString     := 'Pedido liberado automaticamente na importação Android e sem nenhum bloqueio';
        cdsMotivosINFLIB.AsString     := 'Pedido liberado automaticamente na importação Android e sem nenhum bloqueio';
        cdsMotivosVLRCON.AsFloat      := cdsPedidos.FieldByName('FGO_VLRCON').AsFloat;
        cdsMotivosCONPAG.AsString     := cdsPedidos.FieldByName('FGO_CONPAG').AsString;
        cdsMotivosNOMVEN.AsString     := cdsPedidos.FieldByName('VENDEDOR').AsString;
        cdsMotivos.Post;
      end;

      cdsPedidos.Next;
    End;
  Finally
    stlTravas.Free;
    cdsPedidos.EnableControls;
    cdsMotivos.EnableControls;
  End;

  cxgMotivosDados.ApplyBestFit;
  cxgPedidosDados.ViewData.Collapse(True);
  cxgPedidosDados.DataController.GotoFirst;
end;

procedure TfrmCtrLiberacaoPedidos.pCarregaPedidos;
  Const
    SQL_VALOR_JA_RECEBIDO_ADIANTAMENTO = ' IFNULL( ' +
      ' (SELECT SUM(IF(ADT_TIPLAN = "C", ADT_VALLAN, -ADT_VALLAN)) ' +
      '    FROM ADTCLI ' +
      '   WHERE ADT_NUMDOC = FGO_NUMDOC ' +
      '     AND ADT_ESPDOC = FGO_ESPDOC ' +
      '     AND ADT_CODEMP = FGO_CODEMP ' +
      '     AND ADT_CODCLI = FGO_CODCLI), 0) ';
begin
  cdsMotivos.EmptyDataSet;

  With qryPedidos Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT                                              ');
    SQL.Add('SUM(ROUND(((FDO_QTDITE - FDO_QTDBAI) * (FDO_UNITAR + (FDO_VALIPI + FDO_TOTFRE + FDO_VALRET + FDO_VALFCP' + fSqlValorReformaFdoRef('FATDOR.AUTOINCREM') + ' - FDO_DESESP) / FDO_QTDITE)),2)) + IFNULL(FGO_DESACE, 0) AS FGO_VLRCON, ');
    SQL.Add('  G.*,                                              ');
    SQL.Add(' CAST(CONCAT(G.FGO_PREVIS, IF(EXTGOR.FGO_HPREVI <> "", " ", ""), COALESCE(EXTGOR.FGO_HPREVI, "") ) AS DATETIME) AS PREVIS_DTAHOR, ');
    SQL.Add('  CONCAT(G.FGO_NUMPOK,IF(G.FGO_NUMPOK <> "" AND G.FGO_PEDSIT <> "",CONCAT(",", G.FGO_PEDSIT),"")) AS PEDIDOSITE, ');
    SQL.Add('  IF(G.FGO_TIPOPE = "B", "S", "N") AS BONIFICA,     ');
    SQL.Add('  GROUP_CONCAT(DISTINCT IF(FDO_ENTFUT = "S", "ENT.FUTURA", IF(FDO_ENTRET = "E", "ENT.IMEDIATA", "RETIRA")) SEPARATOR " / ") AS DESTINO, ');
    SQL.Add('  C.CLI_NOMCLI,                                     ');
    SQL.Add('  C.CLI_OBSERV,                                     ');
    SQL.Add('  CONCAT(FGO_CODCLI, "-", CLI_NOMCLI) AS FGO_NOMCLI,');
    SQL.Add('  IF(CLI_CGCCPF = 1, ''PESSOA JURÍDICA'', ''PESSOA FÍSICA'') AS CGCCPF,');
    SQL.Add('  CONCAT(V.OPE_CODOPE, "-", V.OPE_NOMOPE) AS VENDEDOR,');
    SQL.Add('  CONCAT(D.OPE_CODOPE, "-", D.OPE_NOMOPE) AS DIGITADOR,');
    SQL.Add('  IF(IFNULL(T.TRA_NOMTRA, "") = "", CONCAT(TRAGOR.TRA_CODTRA, "-", TRAGOR.TRA_NOMTRA), CONCAT(G.FGO_CODTRA, "-", T.TRA_NOMTRA)) AS TRANSPORTADORA,');
    SQL.Add('  TPA_DESCRI AS TIPATE,                             ');
    SQL.Add('  FPG_DESCRI,                                       ');
    SQL.Add('  FGO_CODCND,                                       ');
    SQL.Add('  CND_DESCRI,                                       ');
    SQL.Add('  CONCAT(FPG_CODIGO, "-", FPG_DESCRI) AS DESFPG,    ');
    SQL.Add('  FGO_CONPAG,                                       ');
    SQL.Add('  "" AS DESPAG,                                     ');
    SQL.Add('  SUM(IF(FDO_ENTFUT = "S", FDO_TOTITE - FDO_DESESP, 0.00)) AS VALFUT, ');
    SQL.Add('  SUM(IF(FDO_ENTRET = "R", FDO_TOTITE - FDO_DESESP, 0.00)) AS VALRET, ');
    SQL.Add('  SUM(IF(FDO_ENTRET = "E" AND FDO_ENTFUT = "N", FDO_TOTITE - FDO_DESESP, 0.00)) AS VALENT,');
    SQL.Add('  CONCAT(FGO_OCOLIB, "-", OCO_DESOCO, IF(IFNULL(FGO_HISCOM, "") <> "", " | ", ""), IFNULL(FGO_HISCOM, "")) AS DESOCO,');
    SQL.Add('  FGO_OCOLIB,');
    SQL.Add('  FGO_HISCOM,');
    SQL.Add('  OCO_DESOCO,');
    SQL.Add('  FGO_EMP_CD,');
    SQL.Add('  FGO_NTRAVA,');
    SQL.Add('  IF(IFNULL(FGO_CLILOJ, "N") = "N", "Não", "Sim") AS CLILOJ, ');
    SQL.Add('  IF(IFNULL(FGO_PD_EXP, "N") = "N", "Não", "Sim") AS PD_EXP, ');
    SQL.Add(fGetSQLNumCmp('G') + ' AS NUMCMP, ');
    SQL.Add('  "  " FGO_STATOS, ');
    SQL.Add('  "  " FGO_STATOP, ');
    SQL.Add('  CADDEP.DEP_DESCRI, ');

    {Entrega Urgente?}
    SQL.Add('  EXTGOR.FGO_ENTURG, ');

    {Verifica se usuário pode alterar o campo "Entrega Urgente?"}
    If fVerificaAcessoSistema('ENTURG') Then
      SQL.Add('  CAST("S" AS CHAR(1)) AS DIR_ACE_ENTURG, ')
    Else
      SQL.Add('  CAST("N" AS CHAR(1)) AS DIR_ACE_ENTURG, ');

    SQL.Add('  CASE ');
    SQL.Add('    WHEN ' + SQL_VALOR_JA_RECEBIDO_ADIANTAMENTO + ' = 0 THEN "Pendente" ');
    SQL.Add('    WHEN ' + SQL_VALOR_JA_RECEBIDO_ADIANTAMENTO + ' < (FGO_VLRCON - IFNULL(FGO_TOTBRI, 0) - FGO_BOLADT) THEN "Parcialmente" ');
    SQL.Add('    ELSE "Realizado" ');
    SQL.Add('  END AS SITADT, ');

    SQL.Add(' SUM(EXTDOR.FDO_VALFCP) AS VALFCP, ');
    SQL.Add(' C.CLI_FANSOB AS FANSOB, ');

    SQL.Add(' FGO_NUMORI, ');
    SQL.Add(' FGO_ESPORI, ');
    SQL.Add(' FGO_EMPORI,  ');

    SQL.Add(' C.CLI_CODRED, ');
    SQL.Add(' C.CLI_CODCAC, ');
    SQL.Add(' CAC.CAC_CORILP, ');

    SQL.Add(' CONCAT(POR_CODPOR, "-", POR_NOMPOR) AS PORTADOR, ');
    SQL.Add(' AUXGOR.AUX_MEN003, ');
    SQL.Add(' AUXGOR.AUX_MEN004, ');
    SQL.Add(' AUXGOR.AUX_MEN005,  ');

    SQL.Add(' IF(CLI_UIDNEO=FGO_UIDNEO, CLI_STANEO, "") AS STANEO ');
    SQL.Add('FROM                                                ');
    SQL.Add('  FATGOR G                                          ');
    SQL.Add('  JOIN FATDOR ON FDO_SEQGER = G.AUTOINCREM          ');
    SQL.Add('  JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ');
    SQL.Add('  JOIN CADCLI C ON C.CLI_CODCLI = G.FGO_CODCLI      ');
    SQL.Add('  LEFT JOIN EXTGOR ON G.AUTOINCREM = FGO_SEQFGO     ');
    SQL.Add('  LEFT JOIN CADTPA ON TPA_CODIGO = FGO_CODTPA       ');
    SQL.Add('  LEFT JOIN CADFPG ON FPG_CODIGO = FGO_CODFPG       ');
    SQL.Add('  LEFT JOIN CADOPE V ON V.OPE_CODOPE = FGO_CODVEN   ');
    SQL.Add('  LEFT JOIN CADOPE D ON D.OPE_CODOPE = FGO_CODDIG   ');
    SQL.Add('  LEFT JOIN CADTRA T ON T.TRA_CODTRA = FGO_CODTRA   ');
    SQL.Add('  LEFT JOIN AUXGOR   ON (AUXGOR.AUX_SEQGER  = G.AUTOINCREM) ');
    SQL.Add('  LEFT JOIN ENTCLI ECGOR  ON (ECGOR.AUTOINCREM = AUXGOR.AUX_ENTGER) ');
    SQL.Add('  LEFT JOIN CADTRA TRAGOR ON (ECGOR.ETC_CODTRA = TRAGOR.TRA_CODTRA) ');
    SQL.Add('  LEFT JOIN CADOCO OCOGOR ON (EXTGOR.FGO_OCOLIB = OCOGOR.OCO_CODOCO) ');
    SQL.Add('  LEFT JOIN CADDEP ON DEP_CODIGO = V.OPE_CODDEP AND DEP_CODEMP = V.OPE_CODEMP ');
    SQL.Add('  LEFT JOIN CADCND ON CND_CODIGO = FGO_CODCND       ');
    SQL.Add('  LEFT JOIN CADCAC CAC ON CAC.CAC_CODCAC = C.CLI_CODCAC   ');
    SQL.Add('  LEFT JOIN CADPOR PORGOR ON PORGOR.POR_CODPOR = EXTGOR.FGO_CODPOR   ');

    SQL.Add('WHERE                                               ');

    If Not fCfgSis('LPDOEM', VarBoolean) Then
      SQL.Add('  FGO_CODEMP = :CODEMP        AND                 ');

    If (fCfgSis('TPVD12', varInteger) = 1) Then
      SQL.Add('  FGO_CODVEN LIKE :CODVEN     AND                 ');

    SQL.Add('  FGO_ESPDOC = "PD"             AND                 ');
    SQL.Add('  IFNULL(FGO_DOCEND,  "") = ""  AND                 ');
    SQL.Add('  IFNULL(FGO_ENVLIB, "S") = "S" AND                 ');
    SQL.Add('  FGO_JAFATU = FALSE            AND                 ');
    SQL.Add('  FGO_VLRCON > 0                AND                 ');
    SQL.Add('  IFNULL(FGO_NMPDAB,  "") = ""  AND                 ');
    SQL.Add('  IFNULL(EXTGOR.FGO_LOC_PD, "N") <> "S"             ');

    If (strStatus = 'N') And (strTipLib = '1') Then
      SQL.Add('  AND IFNULL(FGO_LIBERA, 0) = 0 ')
    Else If (strStatus = 'L') And (strTipLib = '1') Then
      SQL.Add('  AND IFNULL(FGO_LIBERA, 0) > 0 ')
    Else If (strStatus = 'N') And (strTipLib = '2') Then
      SQL.Add('  AND IFNULL(FGO_LIBCOM, 0) = 0 ')
    Else If (strStatus = 'L') And (strTipLib = '2') Then
      SQL.Add('  AND IFNULL(FGO_LIBCOM, 0) > 0 ');

    SQL.Add('GROUP BY ');
    SQL.Add('  FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP, FGO_CODCLI ');

    If (fCfgSis('TPVD12', varInteger) = 2) Then
      SQL.Add(' HAVING LOCATE(:CODVEN, GROUP_CONCAT(FDO_CODVE2 SEPARATOR "-")) ');

    If Not fCfgSis('LPDOEM', VarBoolean) Then
      ParamByName('CODEMP').AsString := VS_strCodEmp;

    If (fCfgSis('TPVD12', varInteger) = 1) Then
      ParamByName('CODVEN').AsString := strCodVen + '%'
    Else
      ParamByName('CODVEN').AsString := strCodVen;
  End;

  cdsPedidos.Close;
  cdsPedidos.SetProvider(dspPedidos);

  qryPedidos.Open;
  pSetaClient(qryPedidos);
  cdsPedidos.Open;

  cxgPedidosDados.BeginUpdate;
  try
    cxgPedidosDados.ApplyBestFit;
  finally
    cxgPedidosDados.EndUpdate;
  end;

  cxgPedidosDados.ViewData.Collapse(True);
  cxgPedidosDados.DataController.GotoFirst;

  TFloatField(cdsPedidos.FieldByName('FGO_VLRCON')).DisplayFormat := '#,##0.00';
  TFloatField(cdsPedidos.FieldByName('FGO_TOTFRE')).DisplayFormat := '#,##0.00';
  TFloatField(cdsPedidos.FieldByName('FGO_TOTPRO')).DisplayFormat := '#,##0.00';
  TFloatField(cdsPedidos.FieldByName('FGO_DESESP')).DisplayFormat := '#,##0.00';
  TFloatField(cdsPedidos.FieldByName('FGO_DESACE')).DisplayFormat := '#,##0.00';
  TFloatField(cdsPedidos.FieldByName('FGO_TOTIPI')).DisplayFormat := '#,##0.00';
  TFloatField(cdsPedidos.FieldByName('FGO_TOTRET')).DisplayFormat := '#,##0.00';
  TFloatField(cdsPedidos.FieldByName('VALFCP')).DisplayFormat     := '#,##0.00';

  TStringField(cdsPedidos.FieldByName('FGO_TIPPED')).Alignment := taCenter;
  TStringField(cdsPedidos.FieldByName('FGO_CODEMP')).Alignment := taCenter;
  TStringField(cdsPedidos.FieldByName('FGO_TIPFRE')).Alignment := taCenter;
  TStringField(cdsPedidos.FieldByName('BONIFICA'  )).Alignment := taCenter;
  TStringField(cdsPedidos.FieldByName('FGO_OPELIB')).Alignment := taCenter;

  pCarregaMotivos;
end;

procedure TfrmCtrLiberacaoPedidos.pExecutarConsultaNeocredit;
var
  LstlPedidos  : TStringList;
  LPedidos     : TUniClientDataSet;
  LblnApenasUm : Boolean;
  LobjPedido   : TPedidoVenda;

  procedure AddPedido(const ADataSet: TUniClientDataSet);
  begin
    LobjPedido := TPedidoVenda.Create;

    LobjPedido.strNumDoc := ADataSet.FieldByName('FGO_NUMDOC').AsString;
    LobjPedido.strEspDoc := ADataSet.FieldByName('FGO_ESPDOC').AsString;
    LobjPedido.strCodEmp := ADataSet.FieldByName('FGO_CODEMP').AsString;
    LobjPedido.strCodCli := ADataSet.FieldByName('FGO_CODCLI').AsString;

    LstlPedidos.AddObject(
      ADataSet.FieldByName('FGO_NUMDOC').AsString + '-' +
      ADataSet.FieldByName('FGO_ESPDOC').AsString + '-' +
      ADataSet.FieldByName('FGO_CODEMP').AsString,
      LobjPedido);
  end;

  function TravarDestravarPedidos(const blnTravar: Boolean): Boolean;
  var
    LintCont1,
    LintCont2: Integer;
    LstrMensagem: String;
  begin
    Result := True;

    For LintCont1 := 0 To Pred(LstlPedidos.Count) Do
    Begin
      LobjPedido := TPedidoVenda(LstlPedidos.Objects[LintCont1]);

      If Not fLock_Unlock('FATGOR' + LobjPedido.strNumDoc + LobjPedido.strEspDoc +
                          LobjPedido.strCodEmp, blnTravar, False) Then
      Begin
        If blnTravar Then
        Begin
          LstrMensagem := 'Esse Documento está sendo utilizado em Outra Estação por '
                        + fGetHostLock('FATGOR' + LobjPedido.strNumDoc + LobjPedido.strEspDoc +
                                                  LobjPedido.strCodEmp);

          For LintCont2 := 0 To Pred(LintCont1) Do
          Begin
            LobjPedido := TPedidoVenda(LstlPedidos.Objects[LintCont2]);
            fLock_Unlock('FATGOR' + LobjPedido.strNumDoc + LobjPedido.strEspDoc +
                          LobjPedido.strCodEmp, False, False);

          End;

          fMensagem('', LstrMensagem + '!', ['&Ok']);
          Exit(False);
        End;
      End;
    End;
  end;
begin
  inherited;

  If Not TFacadeNeocredit.AnaliseNeocreditAtivada Then
    Exit;

  LstlPedidos  := nil;
  LPedidos     := nil;
  LobjPedido   := nil;

  Try
    LblnApenasUm := True;
    LPedidos := TUniClientDataSet.Create(Nil);
    pCloneDataSet(LPedidos, cdsPedidos);

    LstlPedidos := TStringList.Create;
    LstlPedidos.OwnsObjects := True;

    LPedidos.Filtered := False;
    LPedidos.Filter   := 'FGO_CODCLI = '+QuotedStr(cdsPedidos.FieldByName('FGO_CODCLI').AsString);
    LPedidos.Filtered := True;

    If LPedidos.RecordCount > 1 Then
    Begin
      LblnApenasUm := fMensagem('CONFIRMAÇÃO', 'Existem pedidos do mesmo cliente '
                                             + 'aguardando liberação, deseja realizar a consulta '
                                             + 'considerando todos os pedidos?', ['&Sim', '&Não']) = 2;
    End;

    If LblnApenasUm Then
      AddPedido(cdsPedidos)
    Else
    Begin
      LPedidos.First;
      While Not LPedidos.Eof Do
      Begin
        AddPedido(LPedidos);
        LPedidos.Next;
      End;
    End;

    If Not TravarDestravarPedidos(True) Then
      Exit;

    Try
      If TFacadeNeocredit.ExecutarAnaliseLimiteCredito(LstlPedidos) Then
      Begin
        pCarregaPedidos;
        cxgPedidosDados.DataController.Refresh;
      End;
    Finally
      TravarDestravarPedidos(False);
    End;
  Finally
    FreeAndNil(LPedidos);
    FreeAndNil(LstlPedidos);
  End;
end;

procedure TfrmCtrLiberacaoPedidos.pGravaEntUrg;
var
  qryTemp : TUniQuery;
begin

  inherited;

  qryTemp := fCriaQuery(nil);

  Try

    If fVerificaAcessoSistema('ENTURG') Then
    Begin

      If (cdsPedidos.Modified) Then
      Begin

        qryTemp.Close;
        qryTemp.SQL.Clear;
        qryTemp.SQL.Text := 'UPDATE EXTGOR SET FGO_ENTURG = :ENTURG WHERE FGO_SEQFGO = :SEQFGO';

        qryTemp.ParamByName('SEQFGO').AsString := cdsPedidos.FieldByName('AUTOINCREM').AsString;
        qryTemp.ParamByName('ENTURG').AsString := cdsPedidos.FieldByName('FGO_ENTURG').AsString;
        qryTemp.ExecSQL;

      End;

    End;

  Finally
    FreeAndNil(qryTemp);
  End;

end;

procedure TfrmCtrLiberacaoPedidos.pLiberacaoPedido(blnLibDireta: Boolean);
Var
    fatVenda   : TFatVenda;
    strNumDoc,
    strEspDoc,
    strCodEmp: String;
    stlTrava : TStringList;
    LMensagem : string;
    frmFatDesmembrarPedidoLocal: TfrmFatDesmembrarPedido;

  function fChekouTravaDebitoEmAtraso: Boolean;
    Var
      strNTrava : String;
  begin
    Result := False;

    If cdsPedidos.FindField('FGO_NTRAVA') <> Nil Then
    Begin
      strNTrava := cdsPedidos.FieldByName('FGO_NTRAVA').AsString;

      If Not fEmptyStr(strNTrava) Then
      Begin
        {* POSIÇÃO 5 - LIBERAÇÃO DO CLIENTE COM DÉBITO EM ATRASO "DEATR" *}
        Result := (Length(strNTrava) >= 5) And (strNTrava[5] = 'S');
      End;
    End;
  End;

  function fTravaFatDorMenor(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  var
    qryAux : TUniQuery;
  begin
    Try
      qryAux := fCriaQuery;
      Try
        With qryAux, SQL Do
        Begin
          Add('SELECT   ');
          Add(' FGO_TOTPRO,  ');
          Add('  SUM(FDO_TOTITE) AS FDO_TOTITE   ');
          Add('FROM      ');
          Add(' FATGOR   ');
          Add(' JOIN FATDOR ');
          Add(' ON FATGOR.AUTOINCREM = FDO_SEQGER  ');
          Add(' WHERE ');
          Add(' FGO_CODEMP = :CODEMP AND ');
          Add(' FGO_NUMDOC = :NUMDOC AND ');
          Add(' FGO_ESPDOC = :ESPDOC ');
          Add(' GROUP BY FDO_SEQGER ');

          ParamByName('CODEMP').AsString := strCodEmp;
          ParamByName('NUMDOC').AsString := strNumDoc;
          ParamByName('ESPDOC').AsString := strEspDoc;

          Open;

          Result := FieldByName('FDO_TOTITE').AsFloat < FieldByName('FGO_TOTPRO').AsFloat;
        End;
      Except
        On E: Exception Do
        Begin
          Result := True;
          pMensagensErro(E.Message, '[fTravaFatDorMenor]');
        End;
      End;
    Finally
      FreeAndNil(qryAux);
    End;
  end;

begin
  inherited;

  blnShowHint := False;
  cxHint.HideHint;
  intLastRec := -1;

  Try
    If cxgPedidosDados.DataController.FocusedRecordIndex = -1 Then
      Exit;

    cxgPedidosDados.ViewData.Collapse(True);

    If Not TFacadeNeocredit.PermiteLiberarPedidoSemAutorizacaoNeocredit(
                              cdsPedidos.FieldByName('FGO_CODCLI').AsString) Then
      Exit;

    if (fCfgSis('USAALP', varBoolean)) and
       (cdsPedidos.FieldByName('FGO_CODCND').AsString = fCfgSis('CPGALP', varString)) then
    begin
      fMensagem('ATENÇÃO!', 'Não é permitido liberar pedidos com a condição de pagamento ALPE, '+
                            'esta liberação acontecerá automaticamente!', ['&OK']);
      Exit;
    end;

    If (cdsPedidos.FieldByName('FGO_LIBERA').AsInteger > 0) And (strTipLib = '1') Or
       (cdsPedidos.FieldByName('FGO_LIBCOM').AsInteger > 0) And (strTipLib = '2') Then
    Begin
      fMensagem('ATENÇÃO!', 'O pedido ' +fNroPedido +' já foi liberado!', ['&Ok']);
      Exit;
    End;

    If fTravaFatDorMenor(cdsPedidos.FieldByName('FGO_NUMDOC').AsString,
                         cdsPedidos.FieldByName('FGO_ESPDOC').AsString,
                         cdsPedidos.FieldByName('FGO_CODEMP').AsString) Then
    Begin
      fMensagem('ATENÇÃO!','Ainda não é permitido realizar a liberação deste pedido '+
                           'pois os produtos foram replicados parcialmente. Por favor, '+
                           'aguarde alguns minutos e tente novamente mais tarde.', ['&OK']);
      Exit;
    End;

    If fTemFatDorSemExtDor(cdsPedidos.FieldByName('FGO_NUMDOC').AsString,
                           cdsPedidos.FieldByName('FGO_ESPDOC').AsString,
                           cdsPedidos.FieldByName('FGO_CODEMP').AsString,
                           LMensagem) Then
    Begin
      fMensagem('ATENÇÃO!', LMensagem, ['&OK']);
      Exit;
    End;

    If (blnUtilizaOSVenda) Then
    Begin
      if SameStr(cdsPedidos.FieldByName('FGO_STATOS').AsString, 'BL') Or
         SameStr(cdsPedidos.FieldByName('FGO_STATOP').AsString, 'BL') Then
      Begin
        fMensagem('ATENÇÃO!','Ainda não é permitido realizar a liberação deste pedido '+
                             'pois a ordem de produção e/ou ordem de serviço ainda não se encontra baixada(s).', ['&OK']);
        Exit;
      End;
    End;

    If (blnUtilizaOSVenda) And
       (cdsPedidos.FieldByName('FGO_PREVIS').AsDateTime > VS_Date) And
       (fMensagem('AVISO', 'Esse Pedido está programado para ' + FormatDateTime('DD/MM/YYYY',cdsPedidos.FieldByName('FGO_PREVIS').AsDateTime) +
                           '. Deseja continuar?' , ['&Sim', '&Não']) = 2) Then
      Exit;

    if (Length(cdsPedidos.FieldByName('FGO_NTRAVA').AsString) >= 15) then
    begin
      If (fCfgSis('LIBPSE', varBoolean)) And (cdsPedidos.FieldByName('FGO_NTRAVA').AsString[15] = 'S') And (fTravaSaldoItem(cdsPedidos.FieldByName('FGO_NUMDOC').AsString, cdsPedidos.FieldByName('FGO_ESPDOC').AsString, cdsPedidos.FieldByName('FGO_CODEMP').AsString)) Then
      Begin
        If fMensagem('ATENÇÃO!','Existem itens sem saldo no pedido. Deseja abrir a rotina de desmembramento para geração de corte?',['&Sim', '&Não']) = 1 Then
        begin
          pCriarFormularios(TfrmFatDesmembrarPedido, frmFatDesmembrarPedidoLocal);
          try
            frmFatDesmembrarPedidoLocal.edtNumDoc.Text := cdsPedidos.FieldByName('FGO_NUMDOC').AsString;
            frmFatDesmembrarPedidoLocal.blnLiberacaoPedido := True;
            frmFatDesmembrarPedidoLocal.ShowModal;
            Exit;
          finally
            pFreeAndNil(frmFatDesmembrarPedidoLocal);
          end;
        end;
      End;
    End;

    SetLength(arrLogLib, 0);
    SetLength(arrLogAvi, 0);

    If (Not TfrmCtrLiberaPedidosConf.fVerificarPermissoesAcessoOperadorLiberacao(strTipLib)) Then
    Begin
      fatVenda := TFatVenda.CreateInstance('VN');
      fatVenda.strCodCli := cdsPedidos.FieldByName('FGO_CODCLI').AsString;
      fatVenda.strCliOri := cdsPedidos.FieldByName('CLI_NOMCLI').AsString;
      fatVenda.strCodFpg := cdsPedidos.FieldByName('FGO_CODFPG').AsString;
      fatVenda.strConPag := fCondicaoPagamentoSemMascara(cdsPedidos.FieldByName('FGO_CONPAG').AsString);
      fatVenda.strObserv := cdsPedidos.FieldByName('CLI_OBSERV').AsString;

      If fCfgSis('USACND', varBoolean) And fCfgSis('PFLCLI', varBoolean) Then
        fatVenda.strCodCnd := cdsPedidos.FieldByName('FGO_CODCND').AsString;

      If (Not fChekouTravaDebitoEmAtraso) Or fCfgSis('LBDEAT', VarBoolean) Then //CHEKAR AQUI
      Begin
        If (Not fatVenda.fDebitoCliente(fatVenda.strCodFpg, fatVenda.strConPag, 2, '', True)) Then
        Begin
          FreeAndNil(fatVenda);
          Exit;
        End;
      End;

      strNumDoc := cdsPedidos.FieldByName('FGO_NUMDOC').AsString;
      strEspDoc := cdsPedidos.FieldByName('FGO_ESPDOC').AsString;
      strCodEmp := cdsPedidos.FieldByName('FGO_CODEMP').AsString;

      If Not fLock_Unlock('FATGOR' + strNumDoc + strEspDoc + strCodEmp, True, False) Then
      Begin
        fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' +
                      fGetHostLock('FATGOR' + cdsPedidos.FieldByName('FGO_NUMDOC').AsString +
                                              cdsPedidos.FieldByName('FGO_ESPDOC').AsString +
                                              cdsPedidos.FieldByName('FGO_CODEMP').AsString)  + '!', ['&Ok']);
        FreeAndNil(fatVenda);
        Exit;
      End;

      If (cdsPedidos.FieldByName('FGO_TIPPED').AsString = 'A') Then
      Begin
        If cdsPedidos.FieldByName('VALFUT').AsFloat > 0 Then
        Begin
          SetLength(fatVenda.arrMatItens, Length(fatVenda.arrMatItens) + 1);
          With fatVenda.arrMatItens[Length(fatVenda.arrMatItens) - 1] Do
          Begin
            strCodIte := 'FUT';
            strDesIte := 'ITEM ENTREGA FUTURA';
            strEntRet := 'E';
            strEntFut := 'S';
            fltTotIte := cdsPedidos.FieldByName('VALFUT').AsFloat;
          End;
        End;

        If cdsPedidos.FieldByName('VALENT').AsFloat > 0 Then
        Begin
          SetLength(fatVenda.arrMatItens, Length(fatVenda.arrMatItens) + 1);
          With fatVenda.arrMatItens[Length(fatVenda.arrMatItens) - 1] Do
          Begin
            strCodIte := 'ENT';
            strDesIte := 'ITEM ENTREGA IMEDIATA';
            strEntRet := 'E';
            strEntFut := 'N';
            fltTotIte := cdsPedidos.FieldByName('VALENT').AsFloat;
          End;
        End;

        If cdsPedidos.FieldByName('VALRET').AsFloat > 0 Then
        Begin
          SetLength(fatVenda.arrMatItens, Length(fatVenda.arrMatItens) + 1);
          With fatVenda.arrMatItens[Length(fatVenda.arrMatItens) - 1] Do
          Begin
            strCodIte := 'RET';
            strDesIte := 'ITEM RETIRA';
            strEntRet := 'R';
            strEntFut := 'N';
            fltTotIte := cdsPedidos.FieldByName('VALRET').AsFloat;
          End;
        End;

         If (Length(fatVenda.arrMatItens) > 0) And
            (Not fatVenda.fVerificaValorMinimoEmitirNF) Then
         Begin
           FreeAndNil(fatVenda);
           fLock_Unlock('FATGOR' +
                        cdsPedidos.FieldByName('FGO_NUMDOC').AsString +
                        cdsPedidos.FieldByName('FGO_ESPDOC').AsString +
                        cdsPedidos.FieldByName('FGO_CODEMP').AsString, False, False);
           Exit;
         End;

      End;

      FreeAndNil(fatVenda);
    End;

    If blnLibDireta Then
    Begin
      If TfrmCtrLiberaPedidosConf.fRealizarLiberacaoPedido(cdsPedidos.FieldByName('FGO_NUMDOC').AsString,
                                                           cdsPedidos.FieldByName('FGO_CODEMP').AsString,
                                                           cdsPedidos.FieldByName('FGO_CODCLI').AsString,
                                                           strTipLib,
                                                           cdsPedidos.FieldByName('FGO_TIPOPE').AsString) Then
      Begin
        pCarregaPedidos;
        cxgPedidosDados.DataController.Refresh;
      End;

      fLock_Unlock('FATGOR' + strNumDoc + strEspDoc + strCodEmp, False, False);
      Exit;
    End;

    Try
      recInfoPedPagtoAlt.strNumDoc := cdsPedidos.FieldByName('FGO_NUMDOC').AsString;
      recInfoPedPagtoAlt.strEspDoc := cdsPedidos.FieldByName('FGO_ESPDOC').AsString;
      recInfoPedPagtoAlt.strCodEmp := cdsPedidos.FieldByName('FGO_CODEMP').AsString;
      recInfoPedPagtoAlt.strCodCli := cdsPedidos.FieldByName('FGO_CODCLI').AsString;
      pCriarFormularios(TfrmCtrLiberaPedidosConf, frmCtrLiberaPedidosConf);
      frmCtrLiberaPedidosConf.edtNumDoc.Text  := cdsPedidos.FieldByName('FGO_NUMDOC').AsString;
      frmCtrLiberaPedidosConf.edtCodEmp.Text  := cdsPedidos.FieldByName('FGO_CODEMP').AsString;
      frmCtrLiberaPedidosConf.edtNumSite.Text := cdsPedidos.FieldByName('PEDIDOSITE').AsString;
      frmCtrLiberaPedidosConf.edtDtaEnt.Text  := cdsPedidos.FieldByName('FGO_DTAENT').AsString;
      frmCtrLiberaPedidosConf.edtDtaEntrega.Text := cdsPedidos.FieldByName('FGO_DTENTR').AsString;

      frmCtrLiberaPedidosConf.edtCodCli.Text := cdsPedidos.FieldByName('FGO_CODCLI').AsString;
      frmCtrLiberaPedidosConf.edtNomCli.Text := cdsPedidos.FieldByName('CLI_NOMCLI').AsString;

      frmCtrLiberaPedidosConf.edtCodVen.Text := cdsPedidos.FieldByName('FGO_CODVEN').AsString;
      frmCtrLiberaPedidosConf.edtNomVen.Text := fRetNomVendRep(cdsPedidos.FieldByName('FGO_CODVEN').AsString);

      frmCtrLiberaPedidosConf.mskCndPag.Text := fCondicaoPagamentoSemMascara(cdsPedidos.FieldByName('FGO_CONPAG').AsString);
      frmCtrLiberaPedidosConf.edtCodFpg.Text := cdsPedidos.FieldByName('FGO_CODFPG').AsString;
      frmCtrLiberaPedidosConf.edtDesFpg.Text := cdsPedidos.FieldByName('FPG_DESCRI').AsString;

      frmCtrLiberaPedidosConf.edtCodCnd.Text := cdsPedidos.FieldByName('FGO_CODCND').AsString;
      frmCtrLiberaPedidosConf.edtDesCnd.Text := cdsPedidos.FieldByName('CND_DESCRI').AsString;

      frmCtrLiberaPedidosConf.edtCodTra.Text := cdsPedidos.FieldByName('FGO_CODTRA').AsString;
      frmCtrLiberaPedidosConf.edtNomTra.Text := fRetNomTransportadora(cdsPedidos.FieldByName('FGO_CODTRA').AsString);

      frmCtrLiberaPedidosConf.edtMens01.Text := cdsPedidos.FieldByName('FGO_MEN001').AsString;
      frmCtrLiberaPedidosConf.edtMens02.Text := cdsPedidos.FieldByName('FGO_MEN002').AsString;
      frmCtrLiberaPedidosConf.edtMens03.Text := cdsPedidos.FieldByName('AUX_MEN003').AsString;
      frmCtrLiberaPedidosConf.edtMens04.Text := cdsPedidos.FieldByName('AUX_MEN004').AsString;
      frmCtrLiberaPedidosConf.edtMens05.Text := cdsPedidos.FieldByName('AUX_MEN005').AsString;

      frmCtrLiberaPedidosConf.edtMenExp.Text := cdsPedidos.FieldByName('FGO_MENEXP').AsString;
      frmCtrLiberaPedidosConf.edtMenEx2.Text := cdsPedidos.FieldByName('FGO_MENEX2').AsString;
      frmCtrLiberaPedidosConf.edtMenEx3.Text := cdsPedidos.FieldByName('FGO_MENEX3').AsString;
      frmCtrLiberaPedidosConf.edtMenEx4.Text := cdsPedidos.FieldByName('FGO_MENEX4').AsString;

      frmCtrLiberaPedidosConf.strPedLib      := cdsPedidos.FieldByName('FGO_LIBERA').AsString;
      frmCtrLiberaPedidosConf.strTipLib      := strTipLib;
      frmCtrLiberaPedidosConf.strTipOpe      := cdsPedidos.FieldByName('FGO_TIPOPE').AsString;
      frmCtrLiberaPedidosConf.strAutIncPedido:= cdsPedidos.FieldByName('AUTOINCREM').AsString;

      frmCtrLiberaPedidosConf.blnLibPed :=
        (cdsMotivos.locate('AUTOINCREM',cdsPedidos.FieldByName('AUTOINCREM').AsString,[])) and
         (fEmptyStr(cdsMotivosINFLIB.AsString));

      try
        stlTrava := TStringList.Create;
        cdsMotivos.disableControls;
        cdsMotivos.filter := 'AUTOINCREM = '+cdsPedidos.FieldByName('AUTOINCREM').AsString;
        cdsMotivos.filtered := true;
        cdsMotivos.first;
        while not cdsMotivos.eof do
        begin
           if not fEmptyStr(cdsMotivosMOTIVO.AsString) then
             stlTrava.Add(cdsMotivosMOTIVO.AsString);
           cdsMotivos.next;
        end;
        frmCtrLiberaPedidosConf.stlTrava := stlTrava;
        frmCtrLiberaPedidosConf.btnAdiantPed.Visible := Self.btnAdiantPed.Visible;
        frmCtrLiberaPedidosConf.ShowModal;

        if frmCtrLiberaPedidosConf.blnAlterouMensagem then
          pCarregaPedidos;
      finally
        cdsMotivos.filter := '';
        cdsMotivos.filtered := false;
        cdsMotivos.EnableControls;
        pFreeAndNil(stlTrava);
      end;

      fLock_Unlock('FATGOR' + strNumDoc + strEspDoc + strCodEmp, False, False);

      If (frmCtrLiberaPedidosConf.blnConfirma) Then
      Begin
        pCarregaPedidos;
        cxgPedidosDados.DataController.Refresh;
      End;
      Except
    On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmCtrLiberacaoPedidos.btnSelecionaClick]');
      End;
    End;

    if frmCtrLiberaPedidosConf.blnAlterouFormaPagamento then
    begin
      pAtualizaPedidoAlterouFormaPagamento;
    end;

    pFreeAndNil(frmCtrLiberaPedidosConf);
    FillChar(recInfoPedPagtoAlt, SizeOf(recInfoPedPagtoAlt), #0);
  Finally
    blnShowHint := True;
  End
end;

procedure TfrmCtrLiberacaoPedidos.pPosicionarColunaVerdeVermelho;
var
  i, posicao : Integer;
  visivel    : Boolean;
begin

  posicao := 0;
  visivel := False;

  If Not cdsPedidos.Active Then
    Exit;

  For i := 0 To cxgPedidosDados.ColumnCount -1 Do
  Begin
    If cxgPedidosDados.Columns[i].DataBinding.FieldName = 'FGO_ENTURG' Then
    Begin

      cxgPedidosDados.Columns[i].Options.Editing := fVerificaAcessoSistema('ENTURG');

      visivel := cxgPedidosDados.Columns[i].Visible;
      posicao := cxgPedidosDados.Columns[i].Index;
    End;
  End;

  For i := 0 To cxgPedidosDados.ColumnCount -1 Do
  Begin
    If cxgPedidosDados.Columns[i].DataBinding.FieldName = 'DIR_ACE_ENTURG' Then
    Begin
      cxgPedidosDados.Columns[i].Visible := visivel;
      cxgPedidosDados.Columns[i].Index   := posicao +1;
    End;
  End;

end;

procedure TfrmCtrLiberacaoPedidos.FormShow(Sender: TObject);
  Var
    strCap: String;
    intRecNo: Integer;
    blnTipAte: Boolean;
begin
  inherited;
  blnTipAte := fCfgSis('TIPATE', varBoolean) And fCfgSis('PEDTPA', varBoolean);

  {*************************}
  {* CAPTION DO FORMULÁRIO *}
  {**********************RV*}
  If (strTipLib = '1') And fCfgSis('LPPDBL', varBoolean) Then
    strCap := 'Liberação de Pedidos - Financeiro'
  Else If (strTipLib = '1') And Not fCfgSis('LPPDBL', varBoolean) Then
    strCap := 'Liberação de Pedidos'
  Else If (strTipLib = '2') Then
    strCap := 'Liberação de Pedidos - Comercial';

  frmCtrLiberacaoPedidos.Caption := strCap;

  pCarregaPedidos;
  cxgPedidosDadosTIPATE.Visible := blnTipAte;

  btnConsultaNeocredit.Visible  := TFacadeNeocredit.AnaliseNeocreditAtivada;
  cxgPedidosDadosSTANEO.Visible := btnConsultaNeocredit.Visible;

  cxgPedidosDados.BeginUpdate;
  try
    cxgPedidosDados.ApplyBestFit;
  finally
    cxgPedidosDados.EndUpdate;
  end;
  cxgPedidosDados.ViewData.Collapse(True);
  cxgPedidosDados.DataController.GotoFirst;

  cxgPedidosDados.StoreToStream(mmsLayoutDefault);

  If fGetFuncoesCxGrid.fCarregarView(cxgPedidosDados, fGetChaveLayoutGrid, cdsPedidos, intRecNo) Then
    cxgPedidosDadosTIPATE.Visible := blnTipAte;

  pPosicionarColunaVerdeVermelho;

  cxgPedidosDadosFGO_STATOS.Visible := blnUtilizaOSVenda;
  cxgPedidosDadosFGO_STATOP.Visible := blnUtilizaOSVenda;
  cxgPedidosDadosFGO_CONPAG.Visible := False;

  If (fCfgSis('ENT_CD') = 'S') Then
  Begin
    cxgPedidosDadosFGO_CODEMP.Caption := 'Emp.Origem';
    cxgPedidosDadosFGO_EMP_CD.Visible := True;
  End
  Else
  Begin
    cxgPedidosDadosFGO_CODEMP.Caption := 'Empresa';
    cxgPedidosDadosFGO_EMP_CD.Visible := False;
  End;

  cxgPedidosDadosCNDDES.Visible := fCfgSis('USACND', varBoolean);

  cxgPedidosDadosCLILOJ.Visible := fCfgSis('CLILOJ', varBoolean);

  cxgPedidosDadosPD_EXP.Visible := fCfgSis('PD_EXP', varBoolean);

  cxgPedidosDadosPORTADOR.Visible := fCfgSis('PORPED', VarBoolean);

  mnuSisAnt.Visible := fCfgSis('SISANT', varBoolean);

  intConfirmando := -1;

  pSetFocus(cxgPedidos);
end;

function TfrmCtrLiberacaoPedidos.fNroPedido :String;
begin
  Result := cdsPedidos.FieldByName('FGO_NUMDOC').AsString +'-'
              +cdsPedidos.FieldByName('FGO_ESPDOC').AsString +'-'
              +cdsPedidos.FieldByName('FGO_CODEMP').AsString;
end;

function TfrmCtrLiberacaoPedidos.fRetStatusOs(strNumDoc, strEspDoc,
  strCodEmp: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ORD_BAIXAD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ORDSER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ORD_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  ORD_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  ORD_CODEMP = :CODEMP ';

  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    If (IsEmpty) Then
      Result := 'NT'
    Else
    Begin

      Result := 'OK';

      While (Not Eof) Do
      Begin
        If (FieldByName('ORD_BAIXAD').AsString = 'N') Then
        Begin
          Result := 'BL';
          Break;
        End;

        Next;
      End;

    End;

    Close;
  End;

  FreeAndNil(qryGen);
end;

function TfrmCtrLiberacaoPedidos.fTravaSaldoItem(strNumDoc, strEspDoc,
  strCodEmp: string): Boolean;
var
  qrySaldo: TUniQuery;
  fltSaldoAnt,
  fltSaldoAtu: Double;
  strNumLot: string;
begin
  Result := False;
  fltSaldoAtu := 0;

  qrySaldo := fCriaQuery;

  try
    qrySaldo.Close;
    qrySaldo.SQL.Clear;
    qrySaldo.SQL.Add('SELECT FDO_CODITE, FDO_NUMLOT');
    qrySaldo.SQL.Add('FROM FATDOR');
    qrySaldo.SQL.Add('WHERE FDO_NUMDOC = :NUMDOC');
    qrySaldo.SQL.Add('AND FDO_ESPDOC = :ESPDOC');
    qrySaldo.SQL.Add('AND FDO_CODEMP = :CODEMP');

    qrySaldo.ParamByName('NUMDOC').AsString := strNumDoc;
    qrySaldo.ParamByName('ESPDOC').AsString := strEspDoc;
    qrySaldo.ParamByName('CODEMP').AsString := strCodEmp;

    qrySaldo.Open;

    if qrySaldo.IsEmpty then
      Exit;

    if qrySaldo.RecordCount = 1 then
      Exit;

    while not qrySaldo.Eof do
    begin
      strNumLot := IIF(fEhEmissaoDocumentoWMS(strCodEmp, strEspDoc) Or
                       fEmpresaParaFaturamentoUsaWMS(strCodEmp, strEspDoc),
                       IIF(qrySaldo.FieldByName('FDO_NUMLOT').AsString = 'A DEFINIR', '',
                           qrySaldo.FieldByName('FDO_NUMLOT').AsString),
                       qrySaldo.FieldByName('FDO_NUMLOT').AsString);

      if qrySaldo.RecNo = 1 then
      begin
        fltSaldoAtu := fRetornaSaldoDisponivel(qrySaldo.FieldByName('FDO_CODITE').AsString,
                                               False,
                                               True,
                                               strNumLot,
                                               True,
                                               strCodEmp);
      end
      else
      begin
        fltSaldoAnt := fltSaldoAtu;
        fltSaldoAtu := fRetornaSaldoDisponivel(qrySaldo.FieldByName('FDO_CODITE').AsString,
                                               False,
                                               True,
                                               strNumLot,
                                               True,
                                               strCodEmp);

        if (((fltSaldoAnt > 0) and (fltSaldoAtu <= 0)) or
           ((fltSaldoAnt <= 0) and (fltSaldoAtu > 0))) then
        begin
          Result := True;
          Exit;
        end;

      end;
      qrySaldo.Next;
    end;
  finally
    FreeAndNil(qrySaldo);
  end;
end;

procedure TfrmCtrLiberacaoPedidos.mnuSisAntClick(Sender: TObject);
var
  frmFatConsVendasAntigas: TfrmFatConsVendasAntigas;
  Key: Char;
begin
  inherited;
  if (cdsPedidos.Active) and (cdsPedidos.RecordCount > 0) then
  begin
    If Not fVerificaAcessoSistema('VDSIAN') Then
    Begin
      fMensagem('', 'Operador não tem direito de acesso em Vendas do Sistema Anterior!', ['&O k']);
      Exit;
    End;

    try
      pCriarFormularios(TfrmFatConsVendasAntigas, frmFatConsVendasAntigas);
      frmFatConsVendasAntigas.edtCodCliente.Enabled := False;
      frmFatConsVendasAntigas.edtCodCliente.Text := cdsPedidos.FieldByName('FGO_CODCLI').AsString;
      frmFatConsVendasAntigas.edtCodClienteKeyPress(frmFatConsVendasAntigas.edtCodCliente, Key);
      frmFatConsVendasAntigas.ShowModal;
    finally
      pFreeAndNil(frmFatConsVendasAntigas);
    end;
  end;
end;

procedure TfrmCtrLiberacaoPedidos.mnuVenCliClick(Sender: TObject);
var
  frmRelFatVendasClienteLocal: TfrmRelFatVendasCliente;
begin
  inherited;
  if (cdsPedidos.Active) and (cdsPedidos.RecordCount > 0) then
  begin
    If Not fVerificaAcessoSistema('VENCLF') Then
    Begin
      fMensagem('', 'Operador não tem direito de acesso em Vendas por Clientes!', ['&OK']);
      Exit;
    End;

    Try
      pCriarFormularios(TfrmRelFatVendasCliente,frmRelFatVendasClienteLocal);
      frmRelFatVendasClienteLocal.blnFaturamento := True;
      frmRelFatVendasClienteLocal.blnSenha := False;
      frmRelFatVendasClienteLocal.blnVeioDoTelemarketing := False;
      frmRelFatVendasClienteLocal.blnVeioDoTablet := False;
      frmRelFatVendasClienteLocal.edtCodCliente.Text := cdsPedidos.FieldByName('FGO_CODCLI').AsString;
      frmRelFatVendasClienteLocal.edtDesCliente.Text := cdsPedidos.FieldByName('CLI_NOMCLI').AsString;
      frmRelFatVendasClienteLocal.blnSomenteVendas := True;
      frmRelFatVendasClienteLocal.blnVeioTelaVendas := True;
      frmRelFatVendasClienteLocal.blnMosCom := True;
      frmRelFatVendasClienteLocal.blnCliCons := fClienteConsumidor(cdsPedidos.FieldByName('CLI_NOMCLI').AsString, False, True);
      frmRelFatVendasClienteLocal.blnDireitoTodasEmpresas := fVerificaAcessoSistema('mnuVendaClienteTodasEmpresas');
      frmRelFatVendasClienteLocal.ShowModal;
    Finally
      pFreeAndNil(frmRelFatVendasClienteLocal);
    End;
  end;
end;

function TfrmCtrLiberacaoPedidos.fRetStatusOp(strNumDoc, strEspDoc,
  strCodEmp: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  IF(PRO_DTABAI IS NULL, "N", "S") AS PRO_BAIXAD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVPRO ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PRO_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  PRO_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  PRO_CODEMP = :CODEMP ';

  qryGen := fCriaQuery;
  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    If (IsEmpty) Then
      Result := 'NT'
    Else
    Begin

      Result := 'OK';

      While (Not Eof) Do
      Begin
        If (FieldByName('PRO_BAIXAD').AsString = 'N') Then
        Begin
          Result := 'BL';
          Break;
        End;

        Next;
      End;

    End;

    Close;
  End;

  FreeAndNil(qryGen);
end;

end.
