unit untPgtoOnlineESiTefManutencao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Datasnap.DBClient, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid,
  MemDS, DBAccess, Uni, cxButtons, untLiberacao, System.Actions, Vcl.ActnList,
  UniClientDataSet, System.StrUtils, Vcl.Mask, MaskEditFocus, EditFocus,
  cxTextEdit, untPgtOnlineApi, cxCalendar;

type
  TfrmPgtoOnlineESiTefManutencao = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    cxGridCitel1DBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridCitel1Level1: TcxGridLevel;
    cxGridCitel1: TcxGridCitel;
    dsTransacoes: TDataSource;
    cxGridCitel1DBTableViewCitel1URLPGT: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1NUMNIT: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1NUMNSU: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1DTACAD: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1HRACAD: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1DTAPAG: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1HRAPAG: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1VALTRA: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1NUMCCD: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1NUMDOC: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1ESPDOC: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1CODEMP: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1CODCLI: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1NOMCLI: TcxGridDBColumn;
    pnlFundoBotoes: TPanel;
    btnReenviarEmail: TcxButton;
    btnNovoLink: TcxButton;
    cxGridCitel1DBTableViewCitel1DESC_STATUS: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1DESC_TIPTRA: TcxGridDBColumn;
    ActionList1: TActionList;
    acGerarNovoLink: TAction;
    acReenciarEmailSms: TAction;
    cxGridCitel1DBTableViewCitel1QTDPAR: TcxGridDBColumn;
    cdsTransacoes: TUniClientDataSet;
    cdsTransacoesURLPGT: TStringField;
    cdsTransacoesNUMNIT: TStringField;
    cdsTransacoesNUMNSU: TStringField;
    cdsTransacoesDTACAD: TDateField;
    cdsTransacoesHRACAD: TTimeField;
    cdsTransacoesSTATUS: TStringField;
    cdsTransacoesDTAPAG: TDateField;
    cdsTransacoesHRAPAG: TTimeField;
    cdsTransacoesVALTRA: TFloatField;
    cdsTransacoesNUMCCD: TStringField;
    cdsTransacoesNUMDOC: TStringField;
    cdsTransacoesAUTOINCREM_PED: TStringField;
    cdsTransacoesESPDOC: TStringField;
    cdsTransacoesCODEMP: TStringField;
    cdsTransacoesCODCLI: TStringField;
    cdsTransacoesNOMCLI: TStringField;
    cdsTransacoesDESC_STATUS: TStringField;
    cdsTransacoesDESC_TIPTRA: TStringField;
    cdsTransacoesTIPTRA: TStringField;
    cdsTransacoesQTDPAR: TIntegerField;
    cdsTransacoesCODOPE: TStringField;
    cdsTransacoesMERCID: TStringField;
    btnCancelarPgto: TcxButton;
    acCancelarPgto: TAction;
    btnDesvincularLink: TcxButton;
    cdsTransacoesTIPREC: TStringField;
    lbStatusDesvincular: TLabel;
    acDesvincularPedido: TAction;
    pnlFiltros: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lblCodEmp: TLabel;
    Label19: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    btnFiltrar: TBitBtnLocked;
    edtDtaDocIni: TMaskEditFocus;
    edtDtaDocFim: TMaskEditFocus;
    btnCopiarLink: TcxButton;
    acCopiarLink: TAction;
    cxGridCitel1DBTableViewCitel1ORIGEM: TcxGridDBColumn;
    cdsTransacoesORIGEM: TStringField;
    cxGridCitel1DBTableViewCitel1DTAEXP: TcxGridDBColumn;
    cdsTransacoesDTAEXP: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure dsTransacoesDataChange(Sender: TObject; Field: TField);
    procedure btnNovoLinkClick(Sender: TObject);
    procedure btnReenviarEmailClick(Sender: TObject);
    procedure acGerarNovoLinkExecute(Sender: TObject);
    procedure acReenciarEmailSmsExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarPgtoClick(Sender: TObject);
    procedure acCancelarPgtoExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function fDocumentoEspecifico: Boolean ;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDesvincularLinkClick(Sender: TObject);
    procedure pAtualizaStatusPedidoDesvinculado;
    function fEhPedidoDesvinculado: Boolean ;
    procedure acDesvincularPedidoExecute(Sender: TObject);
    function fAtencaoAoDesvincularPedido: Boolean;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnCopiarLinkClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure acCopiarLinkExecute(Sender: TObject);
    procedure pAjustaLabelReenviarEMail ;
    function  fAjustaMensagemReenviaEMail: String ;
    procedure pRetornaDadosFiltroReenvioLink(var AstrNumDoc,
                                                 AstrEspDoc,
                                                 AstrCodEmp,
                                                 AstrCodCli,
                                                 AstrOrigem: String;
                                             var AarrAutInc : TArrayAutoIncAgrupado) ;
  private
    { Private declarations }
    objLiberacao : TLiberacao;
    blnGravaLib: Boolean ;
    FstrNumDoc : String ;
    FstrEspDoc : String ;
    FstrCodEmp : String ;
    FblnConfirmado : Boolean ;
    qryConCli      : TUniQuery;
    qryConEmp      : TUniQuery;
    procedure pCarregaTransacoes;
    procedure pCarregaEmpresa;
    procedure pCarregaCliente;
    function fVerLiberacaoGeraLink: Boolean;
    function fVerLiberacaoCancelarPgto: Boolean;
    function fVerLiberacaoDesvincularPedido: Boolean;
    function fSomenteNumeroInteiro(const AstrValor: String):String ;
    function fValidaDadosCancelarLink: Boolean ;
    function fJaFaturado: Boolean ;
    function fDataInicial: TDate;
    function fDataFinal: TDate;
    function fAlgumaDataFoiPreenchida: Boolean;
    function fRetornaAutoIncsAgr(const AstrOrigem, AstrNumNit, AstrMerCid: String):String ;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    property NumDoc : String read FstrNumDoc write FstrNumDoc;
    property EspDoc : String read FstrEspDoc write FstrEspDoc;
    property CodEmp : String read FstrCodEmp write FstrCodEmp;
    property Confirmado : Boolean read FblnConfirmado ;
  end;

implementation

uses
  untFuncoesSimples, untLinkPagamentoCitelStatus,
  untLinkPagamentoCitelUtil, untPgtOnlineUtil, untPgtoOnlineESiTefDadosCartao,
  untLinkPagamentoCitelRepositorio, untClassesComumLinkPagamentoCitel,
  untConsultas, untPesqAux, untTypesSistema, ClipBrd;

{$R *.dfm}

{ TfrmPgtoOnlineESiTefManutencao }

procedure TfrmPgtoOnlineESiTefManutencao.acCancelarPgtoExecute(Sender: TObject);
begin
  inherited;
  if btnCancelarPgto.Enabled then
    btnCancelarPgto.Click ;
end;

procedure TfrmPgtoOnlineESiTefManutencao.acCopiarLinkExecute(Sender: TObject);
begin
  inherited;
  if btnCopiarLink.Enabled then
    btnCopiarLink.Click ;
end;

procedure TfrmPgtoOnlineESiTefManutencao.acDesvincularPedidoExecute(
  Sender: TObject);
begin
  inherited;
  if btnDesvincularLink.Enabled then
    btnDesvincularLink.Click ;
end;

procedure TfrmPgtoOnlineESiTefManutencao.acGerarNovoLinkExecute(
  Sender: TObject);
begin
  inherited;
  if btnNovoLink.Enabled then
    btnNovoLinkClick(Sender);
end;

procedure TfrmPgtoOnlineESiTefManutencao.acReenciarEmailSmsExecute(
  Sender: TObject);
begin
  inherited;
  if btnReenviarEmail.Enabled then
    btnReenviarEmailClick(Sender);
end;

procedure TfrmPgtoOnlineESiTefManutencao.btnCancelarPgtoClick(Sender: TObject);
var
  LobjPedidoLinkPagamentoCitel : TLinkPagamentoCitelClass;
  LstrMsgErro : String;
  LstrLock: String ;
  LfrmPgtoOnlineESiTefDadosCartao: TfrmPgtoOnlineESiTefDadosCartao;
  LstrNumCar, LstrVenCar: String ;
begin
  inherited;

  if (not cdsTransacoes.Active) or (cdsTransacoes.IsEmpty) then
    exit;

  if not fValidaDadosCancelarLink then
    Exit ;

  if not fVerLiberacaoCancelarPgto then
    Exit;

  if not TLinkPagamentoCitelClass.fTemSaldoSuficienteAdtCli(cdsTransacoesNUMDOC.AsString,
                                                            cdsTransacoesESPDOC.AsString,
                                                            cdsTransacoesCODEMP.AsString) then
    Exit;

  if blnGravaLib then
  begin
    try
      pGeraLogLiberacao('', '', '');
    finally
      blnGravaLib := False;
    end;
  end;

  if fMensagem('', 'Deseja cancelar o link de pagamento?', ['&Sim', '&Não']) = 2 then
    exit ;

  LstrLock := 'CANCLINK_'+cdsTransacoesNUMNIT.AsString ;

  if not fLock_Unlock(LstrLock, True, False) then
  begin
    fMensagem('ATENÇÃO!', 'A rotina "Cancelar Pagamento"' +
                          ' já está sendo utilizada por outra estação: ' +
                          fGetHostLock(LstrLock), ['&Ok']);
    Exit ;
  end;

  try

    LstrNumCar := '' ;
    LstrVenCar := '' ;
    if fCfgSis('LINKPG') = '2' then
    begin
      pCriarFormularios(TfrmPgtoOnlineESiTefDadosCartao, LfrmPgtoOnlineESiTefDadosCartao);
      Try
        LfrmPgtoOnlineESiTefDadosCartao.ShowModal;
        if not LfrmPgtoOnlineESiTefDadosCartao.Confirma then
          Exit ;

        LstrNumCar := fSomenteNumeroInteiro(LfrmPgtoOnlineESiTefDadosCartao.edtNumCar.Text) ;
        LstrVenCar := fSomenteNumeroInteiro(LfrmPgtoOnlineESiTefDadosCartao.edtVenCar.Text) ;

      Finally
        pFreeAndNil(LfrmPgtoOnlineESiTefDadosCartao);
      End;
    end ;

    Screen.Cursor := crHourGlass ;
    LobjPedidoLinkPagamentoCitel := TLinkPagamentoCitelClass.Create;
    try
      LobjPedidoLinkPagamentoCitel.strNumDoc := cdsTransacoesNUMDOC.AsString;
      LobjPedidoLinkPagamentoCitel.strEspDoc := cdsTransacoesESPDOC.AsString;
      LobjPedidoLinkPagamentoCitel.strCodEmp := cdsTransacoesCODEMP.AsString;
      LobjPedidoLinkPagamentoCitel.strCodCli := cdsTransacoesCODCLI.AsString;
      LobjPedidoLinkPagamentoCitel.strOrigem := cdsTransacoesORIGEM.AsString;
      LobjPedidoLinkPagamentoCitel.strNumNit := cdsTransacoesNUMNIT.AsString;

      if not LobjPedidoLinkPagamentoCitel.fCancelaLinkPagamento(cdsTransacoesNUMNSU.AsString, cdsTransacoesNUMNIT.AsString, cdsTransacoesNUMCCD.AsString, LstrNumCar, LstrVenCar, cdsTransacoesORIGEM.AsString, LstrMsgErro) then
      begin
        fMensagem('ATENÇÃO!', 'Problemas ao efetuar cancelamento: '+#13#10+
                              LstrMsgErro, ['&Ok']);
      end
      else
      begin
        LobjPedidoLinkPagamentoCitel.fExpiraLinkPagamento(cdsTransacoesNUMNIT.AsString) ;

        if (fCfgSis('LINKPG') = '2') and (fMensagem('', 'Deseja imprimir o comprovante de cancelamento?', ['&Sim', '&Não']) = 1) then
          LobjPedidoLinkPagamentoCitel.fImprimiLinkCancelamento(cdsTransacoesNUMNSU.AsString, cdsTransacoesNUMNIT.AsString) ;

        if fDocumentoEspecifico then
        begin
          FblnConfirmado := True ;
          close ;
          Exit ;
        end ;

        pCarregaTransacoes;
        cdsTransacoes.Last;

      end ;
    finally
      Screen.Cursor := crDefault ;
      FreeAndNil(LobjPedidoLinkPagamentoCitel);
    end ;

  finally
    fLock_Unlock(LstrLock, False) ;
  end ;

end;

procedure TfrmPgtoOnlineESiTefManutencao.btnCopiarLinkClick(Sender: TObject);
begin
  inherited;

  if (not cdsTransacoes.Active) or (cdsTransacoes.IsEmpty) then
    exit;

  ClipBoard.AsText := cdsTransacoesURLPGT.AsString;
  fMensagem('', 'Link copiado para a área de transferência.', ['&O k']);
end;

procedure TfrmPgtoOnlineESiTefManutencao.btnDesvincularLinkClick(
  Sender: TObject);
var
  LobjPedidoLinkPagamentoCitel : TLinkPagamentoCitelClass;
  LstrMsgErro : String;
  LstrLock: String ;
  LstrNumNit: String ;
begin
  inherited;

  if (not cdsTransacoes.Active) or (cdsTransacoes.IsEmpty) then
    exit;

  if not fAtencaoAoDesvincularPedido then
    exit ;

  if not fVerLiberacaoDesvincularPedido then
    Exit;

  if blnGravaLib then
  begin
    try
      pGeraLogLiberacao('', '', '');
    finally
      blnGravaLib := False;
    end;
  end;

  if fMensagem('', 'Deseja desvincular o link de pagamento do documento?', ['&Sim', '&Não']) = 2 then
    exit ;

  LstrLock := 'DESVINCLINK_'+cdsTransacoesNUMNIT.AsString ;

  if not fLock_Unlock(LstrLock, True, False) then
  begin
    fMensagem('ATENÇÃO!', 'A rotina "Desvincular Documento"' +
                          ' já está sendo utilizada por outra estação: ' +
                          fGetHostLock(LstrLock), ['&Ok']);
    Exit ;
  end;

  try

    Screen.Cursor := crHourGlass ;
    LobjPedidoLinkPagamentoCitel := TLinkPagamentoCitelClass.Create;
    try
      LobjPedidoLinkPagamentoCitel.strNumDoc := cdsTransacoesNUMDOC.AsString;
      LobjPedidoLinkPagamentoCitel.strEspDoc := cdsTransacoesESPDOC.AsString;
      LobjPedidoLinkPagamentoCitel.strCodEmp := cdsTransacoesCODEMP.AsString;
      LobjPedidoLinkPagamentoCitel.strCodCli := cdsTransacoesCODCLI.AsString;
      LobjPedidoLinkPagamentoCitel.strOrigem := cdsTransacoesORIGEM.AsString;
      LobjPedidoLinkPagamentoCitel.strNumNit := cdsTransacoesNUMNIT.AsString;
      LstrNumNit := cdsTransacoesNUMNIT.AsString ;

      if not LobjPedidoLinkPagamentoCitel.fDesvinculaLinkPagamentoPedido then
      begin
        fMensagem('ATENÇÃO!', 'Problemas ao desvincular documento: '+#13#10+
                              LstrMsgErro, ['&Ok']);
        exit ;
      end ;
      LobjPedidoLinkPagamentoCitel.fExpiraLinkPagamento(LstrNumNit) ;

      pCarregaTransacoes;
      cdsTransacoes.Locate('NUMDOC;ESPDOC;CODEMP;CODCLI', VarArrayOf([LobjPedidoLinkPagamentoCitel.strNumDoc,LobjPedidoLinkPagamentoCitel.strEspDoc,LobjPedidoLinkPagamentoCitel.strCodEmp,LobjPedidoLinkPagamentoCitel.strCodCli]), [loCaseInsensitive]) ;
    finally
      Screen.Cursor := crDefault ;
      FreeAndNil(LobjPedidoLinkPagamentoCitel);
    end ;

  finally
    fLock_Unlock(LstrLock, False) ;
  end ;

end;

procedure TfrmPgtoOnlineESiTefManutencao.btnFiltrarClick(Sender: TObject);
begin
  inherited;
  pCarregaTransacoes;
end;

procedure TfrmPgtoOnlineESiTefManutencao.btnNovoLinkClick(Sender: TObject);
  const
    tpParcLoja = 4;
  var
    objPedidoLinkPagamentoCitel : TLinkPagamentoCitelClass;
    blnGerou : Boolean;
    strNewNit : String;
    LstrRetornoMsgErro : String;
begin
  inherited;

  if (not cdsTransacoes.Active) or (cdsTransacoes.IsEmpty) then
    exit;

  if not fVerLiberacaoGeraLink then
    Exit;

  if fMensagem('', 'Deseja gerar um novo link para pagamento online?', ['&Sim', '&Não']) = 1 then
  begin
    objPedidoLinkPagamentoCitel := TLinkPagamentoCitelClass.Create;
    try
      objPedidoLinkPagamentoCitel.strNumDoc := cdsTransacoesNUMDOC.AsString;
      objPedidoLinkPagamentoCitel.strEspDoc := cdsTransacoesESPDOC.AsString;
      objPedidoLinkPagamentoCitel.strCodEmp := cdsTransacoesCODEMP.AsString;
      objPedidoLinkPagamentoCitel.strCodCli := cdsTransacoesCODCLI.AsString;
      objPedidoLinkPagamentoCitel.strOrigem := cdsTransacoesORIGEM.AsString;
      objPedidoLinkPagamentoCitel.strAutIncs := fRetornaAutoIncsAgr(cdsTransacoesORIGEM.AsString, cdsTransacoesNUMNIT.AsString, cdsTransacoesMERCID.AsString);
      objPedidoLinkPagamentoCitel.fExpiraLinkPagamento(cdsTransacoesNUMNIT.AsString) ;
      blnGerou := objPedidoLinkPagamentoCitel.fGeraNovoLinkPagamento(cdsTransacoesNUMNIT.AsString,
                                                        cdsTransacoesMERCID.AsString,
                                                        cdsTransacoesCODEMP.AsString,
                                                        cdsTransacoesCODOPE.AsString,
                                                        cdsTransacoesTIPTRA.AsString,
                                                        cdsTransacoesQTDPAR.AsInteger,
                                                        tpParcLoja,
                                                        cdsTransacoesVALTRA.AsFloat,
                                                        strNewNit,
                                                        LstrRetornoMsgErro);

      if not blnGerou then
      begin
        fMensagem('ATENÇÃO!', LstrRetornoMsgErro, ['&Ok']);
        Exit;
      end;

      pCarregaTransacoes;

      cdsTransacoes.Filter := ' NUMNIT = '''+strNewNit+''' ';
      cdsTransacoes.Filtered := True;

      btnReenviarEmailClick(Sender);

      cdsTransacoes.Filter := '';
      cdsTransacoes.Filtered := False;

      cdsTransacoes.Last;
    finally
      FreeAndNil(objPedidoLinkPagamentoCitel);
    end;
  end;
end;

procedure TfrmPgtoOnlineESiTefManutencao.btnReenviarEmailClick(Sender: TObject);
var
  LstrRetornoMsg : String ;
  LstrNumDoc, LstrEspDoc, LstrCodEmp, LstrCodCli, LstrOrigem: String ;
  LarrAutInc: TArrayAutoIncAgrupado ;
begin
  inherited;

  if (not cdsTransacoes.Active) or (cdsTransacoes.IsEmpty) then
    exit;

  if fMensagem('', fAjustaMensagemReenviaEMail, ['&Sim', '&Não']) = 1 then
  begin
    LstrRetornoMsg := '' ;

    pRetornaDadosFiltroReenvioLink(LstrNumDoc,
                                   LstrEspDoc,
                                   LstrCodEmp,
                                   LstrCodCli,
                                   LstrOrigem,
                                   LarrAutInc) ;

    fNotificaCliente(cdsTransacoesURLPGT.AsString,
                     LstrRetornoMsg,
                     LstrNumDoc,
                     LstrEspDoc,
                     LstrCodEmp,
                     LstrCodCli,
                     '',
                     '',
                     LstrOrigem,
                     LarrAutInc) ;

    if not fEmptyStr(LstrRetornoMsg) then
      fMensagem('ATENÇÃO!', LstrRetornoMsg, ['&Ok']) ;
  end;
end;

function TfrmPgtoOnlineESiTefManutencao.fAjustaMensagemReenviaEMail: String;
begin
  Result := ifThen(fCfgSis('UTIWPP', varBoolean), 'Deseja reenviar o Email/WhatsApp?', 'Deseja reenviar o email?') ;
end;

procedure TfrmPgtoOnlineESiTefManutencao.dsTransacoesDataChange(Sender: TObject;
  Field: TField);
var
  LblnPedidoVinculado: boolean ;
begin
  inherited;
  if cdsTransacoes.RecordCount > 0 then
  begin
    LblnPedidoVinculado := not fEhPedidoDesvinculado ;
    btnNovoLink.Enabled := TPgtOnlineStatus.fHabilitaNovoLink(cdsTransacoesSTATUS.AsString) and (LblnPedidoVinculado) ;
    btnCancelarPgto.Enabled := TPgtOnlineStatus.fHabilitaCancelamento(cdsTransacoesSTATUS.AsString) and (LblnPedidoVinculado);
    btnReenviarEmail.Enabled := (btnNovoLink.Enabled or (MatchStr(cdsTransacoesSTATUS.AsString, [stTransacaoRecente, stTransacaoRecenteEmailNaoEnviado]))) and (LblnPedidoVinculado);
    pAtualizaStatusPedidoDesvinculado ;
    btnDesvincularLink.Enabled := TPgtOnlineStatus.fHabilitaDesvincularPedido(cdsTransacoesSTATUS.AsString) and LblnPedidoVinculado ;
    btnCopiarLink.Enabled := True;
  end
  else
  begin
    btnNovoLink.Enabled := False;
    btnCancelarPgto.Enabled := False;
    btnReenviarEmail.Enabled := False;
    btnDesvincularLink.Enabled := False;
    btnCopiarLink.Enabled := False;
  end;
end;

function TfrmPgtoOnlineESiTefManutencao.fAtencaoAoDesvincularPedido: Boolean;
begin
  Result := True ;
  if TPgtOnlineStatus.fAtencaoDesvincularPedido(cdsTransacoesSTATUS.AsString) then
  begin
    If (cdsTransacoesSTATUS.AsString = stTransacaoRecenteEmailNaoEnviado) Then
      Result := fMensagem('', 'O link de pagamento não será cancelado, deseja continuar mesmo assim?', ['&Sim', '&Não']) = 1
    Else
      Result := fMensagem('', 'O link de pagamento enviado no e-mail não será cancelado. deseja continuar mesmo assim?', ['&Sim', '&Não']) = 1 ;
  end ;
end;

procedure TfrmPgtoOnlineESiTefManutencao.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrSel) Then
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
end;
procedure TfrmPgtoOnlineESiTefManutencao.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmPgtoOnlineESiTefManutencao.fAlgumaDataFoiPreenchida: Boolean;
begin
  Result := (not fEmptyStr(fTiraCaracEspeciais(edtDtaDocIni.Text))) or (not fEmptyStr(fTiraCaracEspeciais(edtDtaDocFim.Text)));
end;

function TfrmPgtoOnlineESiTefManutencao.fDataFinal: TDate;
begin
  if fEmptyStr(fTiraCaracEspeciais(edtDtaDocFim.Text)) then
    Result := StrToDate('01/01/3000')
  else
    Result := StrToDate(edtDtaDocFim.Text);
end;

function TfrmPgtoOnlineESiTefManutencao.fDataInicial: TDate;
begin
  if fEmptyStr(fTiraCaracEspeciais(edtDtaDocIni.Text)) then
    Result := StrToDate('01/01/2000')
  else
    Result := StrToDate(edtDtaDocIni.Text);
end;

function TfrmPgtoOnlineESiTefManutencao.fDocumentoEspecifico: Boolean;
begin
  Result := False ;
  if fEmptyStr(FstrNumDoc) then
    Exit ;
  if fEmptyStr(FstrEspDoc) then
    Exit ;
  if fEmptyStr(FstrCodEmp) then
    Exit ;
  Result := True ;
end;

function TfrmPgtoOnlineESiTefManutencao.fEhPedidoDesvinculado: Boolean;
begin
  if cdsTransacoes.IsEmpty then
    Exit(False) ;

  result := fEmptyStr(cdsTransacoesTIPREC.AsString) ;
end;

function TfrmPgtoOnlineESiTefManutencao.fJaFaturado: Boolean;
var
  LqryConsulta: TUniQuery ;
begin
  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add(' SELECT AUTOINCREM ') ;
    LqryConsulta.SQL.Add(' FROM FATGOR ') ;
    LqryConsulta.SQL.Add(' WHERE FGO_NUMDOC = :NUMDOC ') ;
    LqryConsulta.SQL.Add('       AND FGO_CODEMP = :CODEMP ') ;
    LqryConsulta.SQL.Add('       AND FGO_ESPDOC = :ESPDOC ') ;
    LqryConsulta.SQL.Add('       AND FGO_CODCLI = :CODCLI ') ;
    LqryConsulta.SQL.Add('       AND FGO_JAFATU = 1 ') ;
    LqryConsulta.ParamByName('NUMDOC').AsString := cdsTransacoesNUMDOC.AsString ;
    LqryConsulta.ParamByName('CODEMP').AsString := cdsTransacoesCODEMP.AsString ;
    LqryConsulta.ParamByName('ESPDOC').AsString := cdsTransacoesESPDOC.AsString ;
    LqryConsulta.ParamByName('CODCLI').AsString := cdsTransacoesCODCLI.AsString ;
    LqryConsulta.Open ;
    Result := not LqryConsulta.IsEmpty ;
  finally
    FreeAndNil(LqryConsulta) ;
  end ;
end;

procedure TfrmPgtoOnlineESiTefManutencao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(objLiberacao);
  FreeAndNil(qryConCli);
  FreeAndNil(qryConEmp);
end;

procedure TfrmPgtoOnlineESiTefManutencao.FormCreate(Sender: TObject);
begin
  inherited;
  fAjustaDataSistema ;
  FstrNumDoc := '' ;
  FstrEspDoc := '' ;
  FstrCodEmp := '' ;
  FblnConfirmado := False ;

  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);

  objLiberacao := TLiberacao.Create;
  pAjustaLabelReenviarEMail ;

  lbStatusDesvincular.Caption := '';

  cdsTransacoes.CreateDataSet;
end;

function TfrmPgtoOnlineESiTefManutencao.fRetornaAutoIncsAgr(const AstrOrigem, AstrNumNit, AstrMerCid: String): String;
var
  LqryDocs: TUniQuery ;
begin
  Result := '' ;
  if AstrOrigem = 'AGR' then
  begin
    LqryDocs := fCriaQuery() ;
    try
      LqryDocs.Close ;
      LqryDocs.SQL.Clear ;
      LqryDocs.SQL.Add('SELECT DOC_NUMDOC FROM SITDOC WHERE DOC_NUMNIT = :NUMNIT AND DOC_MERCID = :MERCID ') ;
      LqryDocs.ParamByName('NUMNIT').AsString := AstrNumNit ;
      LqryDocs.ParamByName('MERCID').AsString := AstrMerCid ;
      LqryDocs.Open ;
      LqryDocs.First ;
      while not LqryDocs.Eof do
      begin
        Result := Result + IfThen(fEmptyStr(Result), LqryDocs.FieldByName('DOC_NUMDOC').AsString, ';' + LqryDocs.FieldByName('DOC_NUMDOC').AsString) ;
        LqryDocs.Next ;
      end ;
    finally
      FreeAndNil(LqryDocs) ;
    end ;
  end ;
end;

procedure TfrmPgtoOnlineESiTefManutencao.pAjustaLabelReenviarEMail;
begin
  btnReenviarEmail.Caption := ifThen(fCfgSis('UTIWPP', varBoolean), 'F2 - Reenviar Email/WhatsApp', 'F2 - Reenviar Email') ;
end;

procedure TfrmPgtoOnlineESiTefManutencao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    pEscapePressed;
  End;
end;

procedure TfrmPgtoOnlineESiTefManutencao.FormShow(Sender: TObject);
begin
  inherited;

  if fDocumentoEspecifico then
  begin
    edtNumDoc.Text := FstrNumDoc;
    edtEspDoc.Text := FstrEspDoc;
    edtCodEmp.Text := FstrCodEmp;
    pnlFiltros.Visible := False;

    pCarregaTransacoes ;
  end
  else
  begin
    edtDtaDocIni.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
    edtDtaDocFim.Text := FormatDateTime('dd/mm/yyyy', VS_Date);

    edtCodEmp.Text := VS_strCodEmp;
    pCarregaEmpresa;
  end;
end;

function TfrmPgtoOnlineESiTefManutencao.fSomenteNumeroInteiro(
  const AstrValor: String): String;
var
  LchrDigito: Char ;
  LstrRetorno: String ;
begin
  LstrRetorno := '' ;
  for LchrDigito in AstrValor do
  begin
    if CharInSet(LchrDigito, ['0'..'9']) then
      LstrRetorno := LstrRetorno + LchrDigito ;
  end ;
  Result := LstrRetorno ;
end;

function TfrmPgtoOnlineESiTefManutencao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtEspDoc) Then
    Begin
      If Not fEmptyStr(edtEspDoc.Text) Then
      Begin
        If (Pos(edtEspDoc.Text, 'PD_AG_') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A espécie deve ser PD ou AG!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodCli) Then
    Begin
      If not fEmptyStr(edtCodCli.Text) Then
      Begin
        pCarregaCliente;
        If qryConCli.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If not fEmptyStr(edtCodEmp.Text) Then
      Begin
        pCarregaEmpresa;
        If qryConEmp.FieldByName('EMP_CODEMP').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtDtaDocIni) or (Sender = edtDtaDocFim) Then
    Begin
      If fAlgumaDataFoiPreenchida Then
      Begin
        If fDataInicial > fDatafinal Then
        Begin
          fMensagem('ATENÇÃO!', 'A data inicial deve ser menor que a data final!', ['&O k']);
          Result := False;
        End
      End
    End

  End;

end;

function TfrmPgtoOnlineESiTefManutencao.fValidaDadosCancelarLink: Boolean;
var
  LstrChavePrivada, LstrChavePublica: String ;
begin
  Result := False ;

  if fCfgSis('LINKPG') = '2' then
  begin
    LstrChavePrivada := TLinkPagamentoCitelRepositorio.fGetChavePrivada ;
    LstrChavePublica := TLinkPagamentoCitelRepositorio.fGetChavePublica ;

    if fEmptyStr(LstrChavePrivada) then
    begin
      fMensagem('ATENÇÃO!', 'Chave privada não cadastrada!'+#13#10+'Verifique em  > Útil > Manutenção Par Chaves Link Pagamento E-Sitef ', ['&Ok']);
      exit ;
    end ;

    if fEmptyStr(LstrChavePublica) then
    begin
      fMensagem('ATENÇÃO!', 'Chave publica não cadastrada!'+#13#10+'Verifique em  > Útil > Manutenção Par Chaves Link Pagamento E-Sitef ', ['&Ok']);
      exit ;
    end ;

    if not FileExists(ExtractFilePath(Application.ExeName) + 'libJWT.dll') then
    begin
      fMensagem('ATENÇÃO!', 'Arquivo libJWT.dll precisa estar no diretório do Autcom', ['&Ok']);
      exit ;
    end ;

  end ;

  if fJaFaturado then
  begin
    fMensagem('ATENÇÃO!', 'Documento faturado, fazer o cancelamento antes de prosseguir!', ['&Ok']);
    exit ;
  end ;

  Result := True ;
end;

function TfrmPgtoOnlineESiTefManutencao.fVerLiberacaoCancelarPgto: Boolean;
begin
  Result := True;
  blnGravaLib := False;

  If Not fVerificaAcessoSistema('PGTONESITCANCTRA', strLoginUsuarioLogado) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Permitir cancelar Link de Pagamento Online');
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente', cdsTransacoesNOMCLI.AsString                                                        , 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Documento', cdsTransacoesNUMDOC.AsString + ' ' + cdsTransacoesESPDOC.AsString                 , 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor', FloatToStrF(cdsTransacoesVALTRA.AsFloat,ffNumber,12,2)                                , 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Empresa', cdsTransacoesCODEMP.AsString + ' - ' + fRetNomeEmpresa(cdsTransacoesCODEMP.AsString), 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Status', cdsTransacoesDESC_STATUS.AsString                                                    , 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Código da Transação(NIT)', cdsTransacoesNUMNIT.AsString                                       , 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Nsu', cdsTransacoesNUMNSU.AsString                                                            , 25);


    objLiberacao.strDirAce := 'PGTONESITCANCTRA';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strMsgSen := 'Permitir cancelar Link de Pagamento Online';

    If (Not objLiberacao.fLibera) Then
    begin
      fMensagem('ATENÇÃO!','Não é permitido cancelar pagamento do link!', ['&O K']);
      Result := False;
    end
    else
      blnGravaLib := True;
  End;
end;

function TfrmPgtoOnlineESiTefManutencao.fVerLiberacaoDesvincularPedido: Boolean;
begin
  Result := True;
  blnGravaLib := False;

  If Not fVerificaAcessoSistema('DESVINESITGERLINK', strLoginUsuarioLogado) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Permitir Desvincular Link Para Pagamento Online do Pedido!');
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTextoCaption('Documento', cdsTransacoesNUMDOC.AsString                      , 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Código da Transação(NIT)', cdsTransacoesNUMNIT.AsString       , 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor', FloatToStrF(cdsTransacoesVALTRA.AsFloat,ffNumber,12,2), 25);

    objLiberacao.strDirAce := 'DESVINESITGERLINK';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strMsgSen := 'Permitir Desvincular Link Para Pagamento Online do Pedido!';

    If (Not objLiberacao.fLibera) Then
    begin
      fMensagem('ATENÇÃO!','Não é permitido desvincular link para pagamento online do pedido!', ['&O K']);
      Result := False;
    end
    else
      blnGravaLib := True;
  End;
end;

function TfrmPgtoOnlineESiTefManutencao.fVerLiberacaoGeraLink: Boolean;
begin
  Result := True;

  If Not fVerificaAcessoSistema('PGTONESITGERLINK', strLoginUsuarioLogado) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Permitir Gerar Novo Link Para Pagamento Online!');
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTextoCaption('Documento', cdsTransacoesNUMDOC.AsString                      , 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Código da Transação(NIT)', cdsTransacoesNUMNIT.AsString       , 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Código de Autorização', cdsTransacoesNUMCCD.AsString          , 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Nsu', cdsTransacoesNUMNSU.AsString                            , 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor', FloatToStrF(cdsTransacoesVALTRA.AsFloat,ffNumber,12,2), 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Link de Pagamento Antigo', cdsTransacoesURLPGT.AsString       , 25);

    objLiberacao.strDirAce := 'PGTONESITGERLINK';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strMsgSen := 'Permitir Gerar Novo Link Para Pagamento Online!';
    objLiberacao.pInformaNumDocEspDocCodEmp(cdsTransacoesNUMDOC.AsString, EmptyStr, EmptyStr);

    If (Not objLiberacao.fLibera) Then
    begin
      fMensagem('ATENÇÃO!','Não é permitido gerar novo link!', ['&O K']);
      Result := False;
    end;
  End;

end;

procedure TfrmPgtoOnlineESiTefManutencao.pAtualizaStatusPedidoDesvinculado;
var
  LblnDesvinculado: Boolean ;
begin
  LblnDesvinculado := fEhPedidoDesvinculado ;

  lbStatusDesvincular.Caption := 'Documento Desvinculado' ;
  lbStatusDesvincular.Visible := LblnDesvinculado ;

end;

procedure TfrmPgtoOnlineESiTefManutencao.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  edtNomCli.Text := qryConCli.FieldbyName('CLI_NOMCLI').AsString;
end;

procedure TfrmPgtoOnlineESiTefManutencao.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  edtNomEmp.Text := qryConEmp.FieldByName('EMP_NOMEMP').AsString;
end;

procedure TfrmPgtoOnlineESiTefManutencao.pCarregaTransacoes;
  var
    qryAux : TUniQuery;
begin
  qryAux := fCriaQuery;
  cdsTransacoes.DisableControls ;
  try
    qryAux.Close;
    qryAux.SQL.Add(' SELECT * FROM ( ');

    qryAux.SQL.Add('( SELECT ');
    qryAux.SQL.Add('  S.*, ');
    qryAux.SQL.Add('  FG.FGO_NUMDOC, ');
    qryAux.SQL.Add('  FG.FGO_ESPDOC, ');
    qryAux.SQL.Add('  C.CLI_CODCLI, ');
    qryAux.SQL.Add('  C.CLI_NOMCLI, ');
    qryAux.SQL.Add('  CASE ');
    qryAux.SQL.Add('    S.SIT_TIPTRA ');
    qryAux.SQL.Add('    WHEN "C" ');
    qryAux.SQL.Add('    THEN "CREDITO" ');
    qryAux.SQL.Add('    WHEN "D" ');
    qryAux.SQL.Add('    THEN "DEBITO" ');
    qryAux.SQL.Add('  END AS TIPTRA, ');
    qryAux.SQL.Add('  EG.FGO_TIPREC, ');
    qryAux.SQL.Add('  CAST("PD" AS CHAR(3)) AS ORIGEM ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  SITCOB S ');
    qryAux.SQL.Add('  INNER JOIN EXTGOR EG ');
    qryAux.SQL.Add('    ON ( ');
    qryAux.SQL.Add('      EG.FGO_SITNIT = S.SIT_NUMNIT ');
    qryAux.SQL.Add('      AND EG.FGO_SITMID = S.SIT_MERCID ');
    qryAux.SQL.Add('    ) ');
    qryAux.SQL.Add('  INNER JOIN FATGOR FG ');
    qryAux.SQL.Add('    ON (FG.AUTOINCREM = EG.FGO_SEQFGO) ');
    qryAux.SQL.Add('  INNER JOIN CADCLI C ');
    qryAux.SQL.Add('    ON (C.CLI_CODCLI = FG.FGO_CODCLI)');
    qryAux.SQL.Add(' WHERE ' + IfThen(TLinkPagamentoCitelCfg.fLinkPagamentoCitelLigado, 'TRUE', 'FALSE') );

    if not fEmptyStr(edtNumDoc.Text) then
      qryAux.SQL.Add(' AND FG.FGO_NUMDOC = :NUMDOC ');

    if not fEmptyStr(edtEspDoc.Text) then
      qryAux.SQL.Add(' AND FG.FGO_ESPDOC = :ESPDOC ');

    if not fEmptyStr(edtCodEmp.Text) then
      qryAux.SQL.Add(' AND FG.FGO_CODEMP = :CODEMP ');

    if not fEmptyStr(edtCodCli.Text) then
      qryAux.SQL.Add(' AND FG.FGO_CODCLI = :CODCLI ');

    if fAlgumaDataFoiPreenchida then
      qryAux.SQL.Add(' AND FG.FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN ');

    qryAux.SQL.Add(' )');

    qryAux.SQL.Add('  UNION ALL  ');

    qryAux.SQL.Add(' ( SELECT DISTINCT ');
    qryAux.SQL.Add('   S.*, ');
    qryAux.SQL.Add('   CTR.CTR_NUMDUP AS FGO_NUMDOC, ');
    qryAux.SQL.Add('   CTR.CTR_ESPDOC AS FGO_ESPDOC, ');
    qryAux.SQL.Add('   C.CLI_CODCLI, ');
    qryAux.SQL.Add('   C.CLI_NOMCLI, ');
    qryAux.SQL.Add('   CASE ');
    qryAux.SQL.Add('     S.SIT_TIPTRA ');
    qryAux.SQL.Add('     WHEN "C" ');
    qryAux.SQL.Add('     THEN "CREDITO" ');
    qryAux.SQL.Add('     WHEN "D" ');
    qryAux.SQL.Add('     THEN "DEBITO" ');
    qryAux.SQL.Add('   END AS TIPTRA, ');
    qryAux.SQL.Add('   SD.DOC_TIPREC AS FGO_TIPREC, ');
    qryAux.SQL.Add('   SD.DOC_TIPLAN AS ORIGEM ');
    qryAux.SQL.Add(' FROM ');
    qryAux.SQL.Add('   SITCOB S ');
    qryAux.SQL.Add('   INNER JOIN SITDOC SD ');
    qryAux.SQL.Add('     ON SD.DOC_NUMNIT = S.SIT_NUMNIT ');
    qryAux.SQL.Add('        AND SD.DOC_MERCID = S.SIT_MERCID ');
    qryAux.SQL.Add('   INNER JOIN CADREC CTR ');
    qryAux.SQL.Add('     ON (CTR.AUTOINCREM = SD.DOC_NUMDOC) ');
    qryAux.SQL.Add('   INNER JOIN CADCLI C ');
    qryAux.SQL.Add('     ON (C.CLI_CODCLI = CTR.CTR_CODCLI) ');
    qryAux.SQL.Add(' WHERE ' + IfThen(TLinkPagamentoCitelCfg.fLinkPagamentoCitelLigado, 'TRUE', 'FALSE') );

    if not fEmptyStr(edtNumDoc.Text) then
      qryAux.SQL.Add(' AND CTR.CTR_NUMDUP = :NUMDOC ');

    if not fEmptyStr(edtEspDoc.Text) then
      qryAux.SQL.Add(' AND CTR.CTR_ESPDOC = :ESPDOC ');

    if not fEmptyStr(edtCodEmp.Text) then
      qryAux.SQL.Add(' AND CTR.CTR_CODEMP = :CODEMP ');

    if not fEmptyStr(edtCodCli.Text) then
      qryAux.SQL.Add(' AND CTR.CTR_CODCLI = :CODCLI ');

    if fAlgumaDataFoiPreenchida then
      qryAux.SQL.Add(' AND CTR.CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN ');

    qryAux.SQL.Add(' ) ');

    qryAux.SQL.Add(' ) AS SEL ');
    qryAux.SQL.Add('   ORDER BY SIT_DTACAD, SIT_HRACAD  ');

    if Assigned(qryAux.FindParam('NUMDOC')) then
      qryAux.ParamByName('NUMDOC').AsString := edtNumDoc.Text ;

    if Assigned(qryAux.FindParam('ESPDOC')) then
      qryAux.ParamByName('ESPDOC').AsString := edtEspDoc.Text ;

    if Assigned(qryAux.FindParam('CODEMP')) then
      qryAux.ParamByName('CODEMP').AsString := edtCodEmp.Text ;

    if Assigned(qryAux.FindParam('CODCLI')) then
      qryAux.ParamByName('CODCLI').AsString := edtCodCli.Text ;

    if Assigned(qryAux.FindParam('DTAINI')) then
      qryAux.ParamByName('DTAINI').AsDate := fDataInicial;

    if Assigned(qryAux.FindParam('DTAFIN')) then
      qryAux.ParamByName('DTAFIN').AsDate := fDataFinal;

    qryAux.Open;

    cdsTransacoes.EmptyDataSet;

    qryAux.First;
    while not qryAux.Eof do
    begin
      cdsTransacoes.Append;
      cdsTransacoesURLPGT.AsString := qryAux.FieldByName('SIT_URLPGT').AsString;
      cdsTransacoesNUMNIT.AsString := qryAux.FieldByName('SIT_NUMNIT').AsString;
      cdsTransacoesNUMNSU.AsString := qryAux.FieldByName('SIT_NUMNSU').AsString;
      cdsTransacoesDTACAD.AsDateTime := qryAux.FieldByName('SIT_DTACAD').AsDateTime;
      cdsTransacoesHRACAD.AsDateTime := qryAux.FieldByName('SIT_HRACAD').AsDateTime;
      cdsTransacoesTIPTRA.AsString := qryAux.FieldByName('SIT_TIPTRA').AsString;
      cdsTransacoesDESC_TIPTRA.AsString := qryAux.FieldByName('TIPTRA').AsString;
      if not fEmptyStr(qryAux.FieldByName('SIT_DTAPAG').AsString) then
        cdsTransacoesDTAPAG.AsDateTime := qryAux.FieldByName('SIT_DTAPAG').AsDateTime;
      if not fEmptyStr(qryAux.FieldByName('SIT_HRAPAG').AsString) then
        cdsTransacoesHRAPAG.AsDateTime := qryAux.FieldByName('SIT_HRAPAG').AsDateTime;
      cdsTransacoesVALTRA.AsFloat := qryAux.FieldByName('SIT_VALTRA').AsFloat;
      cdsTransacoesNUMCCD.AsString := qryAux.FieldByName('SIT_NUMCCD').AsString;
      cdsTransacoesDESC_STATUS.AsString := TPgtOnlineStatus.fTraduzStatusTransacao(
                                           qryAux.FieldByName('SIT_STATUS').AsString);
      cdsTransacoesSTATUS.AsString := qryAux.FieldByName('SIT_STATUS').AsString;
      cdsTransacoesNUMDOC.AsString := qryAux.FieldByName('FGO_NUMDOC').AsString;
      cdsTransacoesESPDOC.AsString := qryAux.FieldByName('FGO_ESPDOC').AsString;
      cdsTransacoesCODEMP.AsString := qryAux.FieldByName('SIT_CODEMP').AsString;
      cdsTransacoesCODCLI.AsString := qryAux.FieldByName('CLI_CODCLI').AsString;
      cdsTransacoesNOMCLI.AsString := qryAux.FieldByName('CLI_NOMCLI').AsString;
      cdsTransacoesQTDPAR.AsInteger := qryAux.FieldByName('SIT_QTDPAR').AsInteger;
      cdsTransacoesCODOPE.AsString := qryAux.FieldByName('SIT_CODOPE').AsString;
      cdsTransacoesMERCID.AsString := qryAux.FieldByName('SIT_MERCID').AsString;
      cdsTransacoesTIPREC.AsString := qryAux.FieldByName('FGO_TIPREC').AsString;
      cdsTransacoesORIGEM.AsString := qryAux.FieldByName('ORIGEM').AsString;
      if not fEmptyStr(qryAux.FieldByName('SIT_DTAEXP').AsString) then
        cdsTransacoesDTAEXP.AsDateTime := qryAux.FieldByName('SIT_DTAEXP').AsDateTime;
      cdsTransacoes.Post;

      qryAux.Next;
    end;
  finally
    cdsTransacoes.EnableControls ;
    FreeAndNil(qryAux);
  end;
end;

procedure TfrmPgtoOnlineESiTefManutencao.pRetornaDadosFiltroReenvioLink(
  var AstrNumDoc, AstrEspDoc, AstrCodEmp, AstrCodCli, AstrOrigem: String;
  var AarrAutInc: TArrayAutoIncAgrupado);
var
  LqrySitDoc: TUniQuery ;
begin
  AstrNumDoc := '' ;
  AstrEspDoc := '' ;
  AstrCodEmp := '' ;
  AstrCodCli := '' ;
  AstrOrigem := cdsTransacoesORIGEM.AsString ;
  SetLength(AarrAutInc, 0) ;

  if AstrOrigem = 'PD' then
  begin
    AstrNumDoc := cdsTransacoesNUMDOC.AsString ;
    AstrEspDoc := cdsTransacoesESPDOC.AsString ;
    AstrCodEmp := cdsTransacoesCODEMP.AsString ;
    AstrCodCli := cdsTransacoesCODCLI.AsString ;
  end
  else if AstrOrigem = 'AGR' then
  begin
    LqrySitDoc := fCriaQuery() ;
    try
      LqrySitDoc.Close ;
      LqrySitDoc.SQL.Clear ;
      LqrySitDoc.SQL.Add(' SELECT SITDOC.DOC_NUMDOC, CADREC.CTR_CODCLI ') ;
      LqrySitDoc.SQL.Add(' FROM SITDOC INNER JOIN CADREC ON CADREC.AUTOINCREM = SITDOC.DOC_NUMDOC') ;
      LqrySitDoc.SQL.Add(' WHERE SITDOC.DOC_NUMNIT = :NUMNIT ') ;
      LqrySitDoc.SQL.Add('       AND SITDOC.DOC_MERCID = :MERCID ') ;
      LqrySitDoc.ParamByName('NUMNIT').AsString := cdsTransacoesNUMNIT.AsString ;
      LqrySitDoc.ParamByName('MERCID').AsString := cdsTransacoesMERCID.AsString ;
      LqrySitDoc.Open ;
      LqrySitDoc.First ;
      while not LqrySitDoc.Eof do
      begin
        SetLength(AarrAutInc, Length(AarrAutInc)+1) ;
        AarrAutInc[High(AarrAutInc)] := LqrySitDoc.FieldByName('DOC_NUMDOC').AsString ;
        AstrCodCli := LqrySitDoc.FieldByName('CTR_CODCLI').AsString ;
        LqrySitDoc.Next ;
      end ;
    finally
      FreeAndNil(LqrySitDoc) ;
    end ;
  end ;

end;

end.
