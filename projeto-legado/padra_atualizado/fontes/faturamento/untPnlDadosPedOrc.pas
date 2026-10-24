unit untPnlDadosPedOrc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, UniClientDataSet, Uni, StrUtils,
  untTypesSistema, BitBtnLockedIncrem, untExportaCabPedOrc, cxProgressBar,
  untClassPanelCx, untMsgLiberacao, untLiberacao, Winapi.ShellAPI;

type
  TfrmPnlDadosPedOrc = class(TForm)
    Panel2: TFlowPanel;
    btnGerarPDF: TBitBtnLocked;
    btnEnviarEmail: TBitBtnLocked;
    btnBaixaPedido: TBitBtnLocked;
    btnItensPend: TBitBtnLocked;
    btnImpSep: TBitBtnLocked;
    btnGerCab: TBitBtnLocked;
    grpLegenda: TGroupBox;
    Shape1: TShape;
    Label1: TLabel;
    Shape2: TShape;
    Label2: TLabel;
    Shape3: TShape;
    Label3: TLabel;
    btnLibNegada: TBitBtnLocked;
    btnEfetivarOrcamento: TBitBtnLocked;
    btnLegendaStatus: TBitBtnLocked;
    btnGerarXLS: TBitBtnLocked;
    btnLimpSep: TBitBtnLocked;
    btnCobrancaYapay: TBitBtnLocked;
    btnSituacaoItens: TBitBtnLocked;
    btnEnviarWpp: TBitBtnLocked;
    lblTotRegistros: TLabel;
    chkExibirTodosPed: TCheckBox;
    btnProfis: TBitBtnLocked;
    btnPedidosVinculados: TBitBtnLocked;
    procedure btnEnviarEmailClick(Sender: TObject);
    procedure btnBaixaPedidoClick(Sender: TObject);
    procedure btnItensPendClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnImpSepClick(Sender: TObject);
    procedure btnGerCabClick(Sender: TObject);
    procedure btnLibNegadaClick(Sender: TObject);
    procedure btnEfetivarOrcamentoClick(Sender: TObject);
    procedure btnLegendaStatusClick(Sender: TObject);
    procedure btnGerarPDFClick(Sender: TObject);
    procedure btnGerarXLSClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLimpSepClick(Sender: TObject);
    procedure btnCobrancaYapayClick(Sender: TObject);
    procedure pMostraSituacaoItens;
    procedure btnSituacaoItensClick(Sender: TObject);
    procedure btnEnviarWppClick(Sender: TObject);
    procedure chkExibirTodosPedClick(Sender: TObject);
    procedure btnProfisClick(Sender: TObject);
    procedure btnPedidosVinculadosClick(Sender: TObject);
  strict private
    intTamanhoOwnerOriginal: integer;
  private
    { Private declarations }
    strPatCab: String;
    blnShowmessage: boolean;
    strClienteSelecionado: string;
    opcComSemPreco: TImpressaoComSemPrecoOrPd;
    strMensagem: string;
    procedure pDesabilitaColunas;
    procedure pMostraItensPendentes;

    (*removendo hint
    function fValidaQtdRegistroGrid: boolean;
    function fRetListaSelecaoInstrucaoSQL_IN: string; *)
    function fVariosDocumentosSelecionados: boolean;
    function fLocalizaPosicaoListaSelecaoNoCdsConsulta(index: integer): Boolean;
    function fItemLista(index: integer): string;
    procedure pGerarArquivo(strPDF_XLS : String);
    procedure pGerarPDF;
    procedure pGerarXLS;
    function fFormaDePagamentoPermiteUsuarioInativo : Boolean;
    function fSituacaoFinanceiraPedidoOk: Boolean;
    function fLiberacaoImpSeparacao: Boolean;
    function fPedidoJaFaturado: Boolean;
    procedure pEnviaWhatsapp;
    function fLiberouTravaProdutoVinculadoLoteSeparacao(arrPedidos: TStringArray): Boolean;

    function fTemProfissionais(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
    function fTipoDoc(strEspDoc: String): String;

    procedure pVerificaExibirTodosPedidos;
    Function fRetornaItens: TUniQuery;
    function fMSG_SenhaImprimirComPreco: Boolean;
    procedure pDefinirLayoutOrcPed;
    function fListaPedidosVinculados: Boolean;

    procedure pCarregaDadosQRCodePix(out AQrCodePix,
                                         ALinkCitel: String);
    function fExibiBotaoMotivoLibNegada: Boolean;
  public
    { Public declarations }
    cdsConsulta: TUniClientDataSet;
    strEspDoc  : String;
    blnCRM : Boolean;
    blnPermitirExibirTodosOsPedidos: Boolean;
    blnMarcarExibirTodosOsPedidos: Boolean;
    objPanel        : TPanelCX;

    procedure OnBeforeListaSelecaoAdd(strValue: String; Var blnAdd: boolean);
    procedure OnAfterListaSelecaoRemove(strValue: String);

    procedure pIniciouNavegacaoGridConsulta;
    procedure pParouNavegacaoGridConsulta;

    procedure pValidaTemFiltro;

    constructor Create(AOwner: TComponent); reintroduce; virtual;
  end;

  TfrmPnlDadosPedOrcClass = Class Of TfrmPnlDadosPedOrc;

var
  frmPnlDadosPedOrc: TfrmPnlDadosPedOrc;

implementation

uses  untFuncoesSimples, untFatGorEmail, untDigEmailPedOrc,
      untFatEfetivarItensOrcamentoEmPedido, untMostraItensPendentes,
      untGeraPDFPedOrc, untReimpressao, untSituacaoItensPedido,
      untFuncoesEditorFast, untDigEmailPedOrcEditor, untDigOcorrencia,
      untGravando, untFatAltQtdeItensPedido, untFuncoesRel, untFuncoesRel2,
      untFuncoes, untFuncoesCRM, untTypesMargem, untTEnvioEmail, untFuncFat,
      untCadRcxx, untTSituacaoPedidoVenda, untLegenda, VirtualUI_SDK,
      untFuncFatTypes, untDocPDOR_Excel, untProjetos, untRomLge, untImpressaoSeparacao,
      untAdiantamentoClienteGenerico, untValidacoesSistemaDEPS, untFatGor,
      Yapay.Api.Facade, untFatBaixarPedOrcNaoEntregue, untFuncFatImp, untListaProfissionaisPD,
      untValidaSituacaoFinanceiraPedido, untConstantes, untTravaCaixa, untFormGrid;

{$R *.dfm}

{ TfrmPnlDadosPedOrc }

procedure TfrmPnlDadosPedOrc.btnBaixaPedidoClick(Sender: TObject);
var
  intIndex                : Integer;
  BaixarPedOrcNaoEntregue : TBaixarPedOrcNaoEntregue;
  blnExecutou             : Boolean;
  strMSG                  : String;
  blnOperadorTemDireitoDeAcessoParaLimparSep : Boolean;
  arrPedidosNaoPermitidos : TStringArray;
  arrPedidoComLoteSeparacaoRomaneio: TStringArray;
  arrPedidosOndaAgrupamento: TStringArray;
  blnLiberouPedidoComLoteSeparacaoRomaneio: Boolean;
begin

  inherited;

  blnExecutou := False;

  If (Not btnBaixaPedido.Visible) Then
    Exit;

  If (cdsConsulta.IsEmpty) Then
    Exit;

  SetLength(arrPedidoComLoteSeparacaoRomaneio, 0);
  SetLength(arrPedidosOndaAgrupamento, 0);
  blnLiberouPedidoComLoteSeparacaoRomaneio := True;

  BaixarPedOrcNaoEntregue := TBaixarPedOrcNaoEntregue.Create;
  try
    BaixarPedOrcNaoEntregue.blnExecutandoCnsOr := IIF(cdsConsulta.FieldByName('FGO_ESPDOC').AsString = 'OR', True, False);

    If fVariosDocumentosSelecionados Then
    Begin
      For intIndex := 0 To objPanel.stlListaSelecao.Count -1 do
      Begin
        If fLocalizaPosicaoListaSelecaoNoCdsConsulta(intIndex) Then
        Begin
          If (cdsConsulta.FieldByName('FGO_ESPDOC').AsString = 'PD') And (fExisteLoteSeparacaoRomaneioParaPedido(cdsConsulta.FieldByName('AUTOINCREM').AsString)) Then
          Begin
            If Not fVerificaAcessoSistema('BPVLSR') Then
            Begin
              SetLength(arrPedidoComLoteSeparacaoRomaneio, Length(arrPedidoComLoteSeparacaoRomaneio)+1);
              arrPedidoComLoteSeparacaoRomaneio[Length(arrPedidoComLoteSeparacaoRomaneio)-1] := cdsConsulta.FieldByName('AUTOINCREM').AsString;
            End;
          End;
        End;
      End;
    End
    Else
    Begin
      If (cdsConsulta.FieldByName('FGO_ESPDOC').AsString = 'PD') And (fExisteLoteSeparacaoRomaneioParaPedido(cdsConsulta.FieldByName('AUTOINCREM').AsString)) Then
      Begin
        If Not fVerificaAcessoSistema('BPVLSR') Then
        Begin
          SetLength(arrPedidoComLoteSeparacaoRomaneio, Length(arrPedidoComLoteSeparacaoRomaneio)+1);
          arrPedidoComLoteSeparacaoRomaneio[Length(arrPedidoComLoteSeparacaoRomaneio)-1] := cdsConsulta.FieldByName('AUTOINCREM').AsString;
        End;
      End;
    End;

    If (Length(arrPedidoComLoteSeparacaoRomaneio) > 0) Then
    Begin
      blnLiberouPedidoComLoteSeparacaoRomaneio := fLiberouTravaProdutoVinculadoLoteSeparacao(arrPedidoComLoteSeparacaoRomaneio);
    End;

    If fVariosDocumentosSelecionados Then
    Begin
      For intIndex := 0 To objPanel.stlListaSelecao.Count -1 do
      Begin
        If fLocalizaPosicaoListaSelecaoNoCdsConsulta(intIndex) Then
        Begin
          If (cdsConsulta.FieldByName('FGO_ESPDOC').AsString = 'PD') And (fPedidoExpedido(cdsConsulta.FieldByName('AUTOINCREM').AsString)) Then
          Begin
            If Not fVerificaAcessoSistema('CANPDA') Then
            Begin
              SetLength(arrPedidosNaoPermitidos, Length(arrPedidosNaoPermitidos)+1);
              arrPedidosNaoPermitidos[Length(arrPedidosNaoPermitidos)-1] := cdsConsulta.FieldByName('FGO_NUMDOC').AsString;
              Continue;
            End
          End;

          If (cdsConsulta.FieldByName('FGO_ESPDOC').AsString = 'PD') And
             (fExisteLoteSeparacaoRomaneioParaPedido(cdsConsulta.FieldByName('AUTOINCREM').AsString)) And
             (Not blnLiberouPedidoComLoteSeparacaoRomaneio) Then
          Begin
            Continue;
          End;

          If fUsaOndaSeparacaoAgrupamento And
             fFoiSelecionadoPedidoDeRemessaDePedidoComRemessaDeSeparacaoJaGerada(cdsConsulta.FieldByName('AUTOINCREM').AsString) Then
          Begin
            SetLength(arrPedidosOndaAgrupamento, Length(arrPedidosOndaAgrupamento) + 1);
            arrPedidosOndaAgrupamento[Length(arrPedidosOndaAgrupamento) - 1] := cdsConsulta.FieldByName('FGO_NUMDOC').AsString;
            Continue;
          End;

          BaixarPedOrcNaoEntregue.AddDocumento(
            cdsConsulta.FieldByName('FGO_NUMDOC').AsString,
            cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
            cdsConsulta.FieldByName('FGO_CODEMP').AsString
          );
        End;
      End;
    End
    Else
    Begin
      If (cdsConsulta.FieldByName('FGO_ESPDOC').AsString = 'PD') And (fPedidoExpedido(cdsConsulta.FieldByName('AUTOINCREM').AsString)) Then
      Begin
        If Not fVerificaAcessoSistema('CANPDA') Then
        Begin
          fMensagem('Atenção!', 'Pedido expedido, para efetuar a baixa é necessário cancelar a expedição.', ['&Ok']);
          Exit;
        End
      End;

      If fUsaOndaSeparacaoAgrupamento And
         fFoiSelecionadoPedidoDeRemessaDePedidoComRemessaDeSeparacaoJaGerada(cdsConsulta.FieldByName('AUTOINCREM').AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'Pedido pertencente a uma Remessa de Pedido/Separação. Para efetuar a baixa é necessário guardar os itens através da rotina de expedição!', ['&Ok']);
        Exit;
      End;

      If (Not blnLiberouPedidoComLoteSeparacaoRomaneio) Then
      Begin
        Exit;
      End;

      BaixarPedOrcNaoEntregue.AddDocumento(
            cdsConsulta.FieldByName('FGO_NUMDOC').AsString,
            cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
            cdsConsulta.FieldByName('FGO_CODEMP').AsString
          );
    End;

    If (fVariosDocumentosSelecionados) And (Length(arrPedidoComLoteSeparacaoRomaneio) > 0) And (Not blnLiberouPedidoComLoteSeparacaoRomaneio) Then
    Begin
      If (Length(arrPedidoComLoteSeparacaoRomaneio) = objPanel.stlListaSelecao.Count) Then
      Begin
        Exit;
      End;
    End;

    If (Length(arrPedidosNaoPermitidos) > 0) Then
    Begin
      fMensagem('Atenção!', 'Os pedidos a seguir foram expedidos, para efetuar a baixa é '+
                'necessário cancelar a expedição:' + sLineBreak +
                '('+fArrayToString(arrPedidosNaoPermitidos, ', ', True)+').', ['&Ok']);

      If (Length(arrPedidosNaoPermitidos) = objPanel.stlListaSelecao.Count) Then
      Begin
        Exit;
      End;
    End;

    if (Length(arrPedidosOndaAgrupamento) > 0) then
    begin
      fMensagem('Atenção!', 'Os pedidos a seguir pertencem a uma Remessa de Pedido/Separação, para efetuar a baixa é '+
                'necessário guardar os itens através da rotina de expedição:' + sLineBreak +
                '('+fArrayToString(arrPedidosOndaAgrupamento, ', ', True)+').', ['&Ok']);

      if (Length(arrPedidosOndaAgrupamento) = objPanel.stlListaSelecao.Count) then
        Exit;
    end;

    Try
      blnExecutou := BaixarPedOrcNaoEntregue.Executar;
    Except
      On E: EValidaPedidoPossuiItensEmSeparacao Do
      Begin

        blnOperadorTemDireitoDeAcessoParaLimparSep := (fVerificaAcessoSistema('PRODLIMSEP')) And (Not fCfgSis('UTICRM', varBoolean));

        If Not blnOperadorTemDireitoDeAcessoParaLimparSep Then
          fMensagem('ATENÇÃO!', E.Message, ['&Ok'])
        Else
        Begin

          strMSG := E.Message;
          strMSG := IIF(Not strMSG.IsEmpty, strMSG, 'Foi identificado pedido(s) com separação em andamento');

          If (fMensagem('ATENÇÃO', strMSG  +
                        '.' + #13 + #13 + 'Deseja Limpar a Separação e Realizar a Baixa do(s) Pedido(s)?', ['&Sim', '&Não'], 2) = 1) Then
          Begin
            If BaixarPedOrcNaoEntregue.ValidouRestricoesLimparSeparacao Then
            Begin
              BaixarPedOrcNaoEntregue.LimparSeparacao := True;
              BaixarPedOrcNaoEntregue.ReprocessarValidacoes;
              blnExecutou := BaixarPedOrcNaoEntregue.Executar;
            End;
          End;

        End;

      End;
    End;

    if (blnExecutou) then
    begin
      objPanel.stlListaSelecao.Clear;
      strClienteSelecionado := '';

      try
        cdsConsulta.Refresh;
      except
        begin
          cdsConsulta.Close;
          cdsConsulta.Open;
        end;
      end;
    end
    else
    begin
      if (objPanel.stlListaSelecao.Count > 0) then
      begin
        If fMensagem('ATENÇÃO', 'Deseja limpar a seleção dos documentos no grid?', ['&Sim', '&Não'], 2) = 1 Then
        begin
          objPanel.stlListaSelecao.Clear;
          strClienteSelecionado := '';
          cdsConsulta.Refresh;
        end;
      end;
    end;

  finally
    FreeAndNil(BaixarPedOrcNaoEntregue);
  end;

end;

procedure TfrmPnlDadosPedOrc.btnEfetivarOrcamentoClick(Sender: TObject);
  Var
    strStatusSistemaDEPS : String;
    strConPag : String;
    objTravaCaixa : TTravaCaixa;

  function fTemItemEspecialOrcamento: Boolean;
  begin
    Result := fCampoTabela('SUM(LOCATE("ITEM ESPECIAL", ITE_DESITE))',
      'FATDOR INNER JOIN CADITE ON ITE_CODITE = FDO_CODITE',
      ['FDO_SEQGER'], [cdsConsulta.FieldByName('AUTOINCREM').AsString]) > 0;
  end;

  function fRetConPag : String;
  begin
    Result := fCampoTabela('FGO_CONPAG', 'FATGOR', ['FGO_NUMDOC',
                                                    'FGO_ESPDOC',
                                                    'FGO_CODEMP',
                                                    'FGO_CODCLI'],
                                                   [cdsConsulta.FieldByName('FGO_NUMDOC').AsString,
                                                    cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                                                    cdsConsulta.FieldByName('FGO_CODEMP').AsString,
                                                    cdsConsulta.FieldByName('FGO_CODCLI').AsString]);
  end;

begin
  If fVariosDocumentosSelecionados Then
  Begin
    fMensagem('ATENÇÃO!', 'Apenas um documento pode estar selecionado para executar essa operação!', ['&Ok']);
    Exit;
  End;

  If Not btnEfetivarOrcamento.Visible Then
    Exit;

  objTravaCaixa := TTravaCaixa.New('PD');

  Try

    If (objTravaCaixa.blnTravar) Then
      Exit;

    If (objTravaCaixa.fCaixaDoDiaFechadoOuCaixaDoDiaAnteriorAindaNaoFechado) Then
    Begin

      strConPag := fRetConPag;

      If (fStatusCndPag(strConPag) = A_VISTA) Then
        If Not objTravaCaixa.blnApenasEmissaoDePD_OR_AVista Then
        Begin
          fMensagem('ATENÇÃO!', MSG_SOMENTE_A_PRAZO, ['&Ok']);
          Exit;
        End;

      If (fStatusCndPag(strConPag) = A_PRAZO) Then
        If Not objTravaCaixa.blnApenasEmissaoDeDocumentosAPrazo Then
        Begin
          fMensagem('ATENÇÃO!', MSG_SOMENTE_A_VISTA, ['&Ok']);
          Exit;
        End;

    End;

  Finally
    FreeAndNil(objTravaCaixa);
  End;

  If Not fVerificaAcessoSistema('frmFatVendas - PD') Then
  Begin
    fMensagem('', 'Usuário não possui permissão de acesso para o módulo de pedidos!', ['&Ok']);
    Exit;
  End;

  If (Not fPermiteItemEspecial('PD')) And fTemItemEspecialOrcamento Then
  Begin
    fMensagem('', 'Não é permitido item especial em pedidos de venda!', ['&Ok']);
    Exit;
  End;

  If (fRetornaStatusCliente(cdsConsulta.FieldByName('FGO_CODCLI').AsString) <> 'A') And (fCfgSis('PTRASC', varBoolean)) Then
  Begin
    if not fFormaDePagamentoPermiteUsuarioInativo then
    Begin
      fMensagem('', 'O cliente deste documento não está ativo!', ['&Ok']);
      Exit;
    End;
  End;

  if (fCfgSis('USADEP') = 'S') Then
  Begin
    strStatusSistemaDEPS := TValidacoesSistemaDEPS.fRetornaStatusDoOrcamentoNoSistemaDEPS(cdsConsulta.FieldByName('AUTOINCREM').AsString);

    If (Pos(strStatusSistemaDEPS, 'APROVADO_DISPENSA ANÁLISE_') <= 0) Then
    Begin
      fMensagem('ATENÇÃO', 'Não será possível gravar o pedido. Necessária a análise e aprovação de crédito DEPS.' + #13 +
                           'Status do Orçamento: ' + strStatusSistemaDEPS,
                ['&OK']);
      Exit;
    End;
  End;

  Try
    pCriarFormularios(TfrmFatEfetivarItensOrcamentoEmPedido, frmFatEfetivarItensOrcamentoEmPedido);

    frmFatEfetivarItensOrcamentoEmPedido.strNumOrc := cdsConsulta.FieldByName('FGO_NUMDOC').AsString;
    frmFatEfetivarItensOrcamentoEmPedido.strEmpOrc := cdsConsulta.FieldByName('FGO_CODEMP').AsString;

    frmFatEfetivarItensOrcamentoEmPedido.ShowModal;

    If frmFatEfetivarItensOrcamentoEmPedido.blnGravouPedido Then
      cdsConsulta.Refresh;
  Finally
    pFreeAndNil(frmFatEfetivarItensOrcamentoEmPedido);
  End;

end;

procedure TfrmPnlDadosPedOrc.btnEnviarEmailClick(Sender: TObject);
  var
    intIndex: integer;
    objParametrosEnvio: TParametrosEnvio;

  procedure pExecuta;
  Begin
    If (Not btnEnviarEmail.Visible) Then
      Exit;

    pCarregaDadosQRCodePix(objParametrosEnvio.QrCodePix,
                           objParametrosEnvio.LinkCitel);

    TFatVenda.pAtualizacaoCotacaoDolar(cdsConsulta.FieldByName('FGO_NUMDOC').AsString,
                                       cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                                       cdsConsulta.FieldByName('FGO_CODEMP').AsString);

    EnviarEmailPedOrc(Self,
                      strLoginUsuarioLogado,
                      cdsConsulta.FieldByName('AUTOINCREM').AsString,
                      cdsConsulta.FieldByName('FGO_NUMDOC').AsString,
                      cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                      cdsConsulta.FieldByName('FGO_CODEMP').AsString,
                      cdsConsulta.FieldByName('FGO_CODCLI').AsString,
                      objParametrosEnvio);

  End;
begin
  inherited;
  blnShowmessage := True;
  pSetDefaultParametrosEnvio(objParametrosEnvio);
  If fVariosDocumentosSelecionados Then
  Begin
    If Not fVerificaAcessoSistema('PEMAIL', strLoginUsuarioLogado) Then
    Begin
      untFuncoesSimples.fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
      Exit;
    End;

    objParametrosEnvio.blnEnviar := False;
    objParametrosEnvio.blnVariosDocumentos := True;
    For intIndex := 0 To objPanel.stlListaSelecao.Count -1 do
    Begin
      If fLocalizaPosicaoListaSelecaoNoCdsConsulta(intIndex) Then
      Begin
        objParametrosEnvio.blnEnviar := intIndex = (objPanel.stlListaSelecao.Count -1);
        pExecuta;
        objParametrosEnvio.blnShowMessages := False;
        objParametrosEnvio.blnShowDialog   := False;
      End;
    End;
  End
  Else
  Begin
    objParametrosEnvio.blnVariosDocumentos := False;
    pExecuta;
  End;

  SetForegroundWindow(Handle);
end;

procedure TfrmPnlDadosPedOrc.pEnviaWhatsapp;
var
  intIndex: integer;
  blnEnviado: Boolean;

  LQRCodePix,
  LLinkCitel: String;
begin
  if cdsConsulta.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Selecione um documento no grid para fazer o envio para o Whatsapp!', ['&Ok']);
    Exit;
  end;

  if not fEnviaWhatsappParaCliente(cdsConsulta.FieldByName('FGO_CODCLI').AsString, True) then
    Exit;

  if not fGatilhoEmailWhatsappSmsEstaAtivado(notWhatsapp,
                                             cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                                             cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                                             '',
                                             'CR') then
    Exit;

  blnEnviado := False;

  blnShowmessage := True;

  TFatVenda.pAtualizacaoCotacaoDolar(cdsConsulta.FieldByName('FGO_NUMDOC').AsString,
                                     cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                                     cdsConsulta.FieldByName('FGO_CODEMP').AsString);

  pDefinirLayoutOrcPed;

  If fVariosDocumentosSelecionados Then
  Begin
    For intIndex := 0 To objPanel.stlListaSelecao.Count -1 do
    Begin
      If fLocalizaPosicaoListaSelecaoNoCdsConsulta(intIndex) Then
      Begin
        pCarregaDadosQRCodePix(LQRCodePix,
                               LLinkCitel);

        LQRCodePix := RetonaQRCodePixPedido(LQRCodePix,
                                            LLinkCitel,
                                            False);

        blnEnviado := fDisparaWhatsappAutomatico(cdsConsulta.FieldByName('FGO_NUMDOC').AsString,
                                                 cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                                                 cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                                                 '',
                                                 'CR',
                                                 cdsConsulta.FieldByName('FGO_CODEMP').AsString,
                                                 cdsConsulta.FieldByName('FGO_CODCLI').AsString,
                                                 LQRCodePix,
                                                 False,
                                                 '',
                                                 TGeraArquivoAnexoEmailAutomatico.New(cdsConsulta.FieldByName('FGO_NUMDOC').AsString,
                                                                                      cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                                                                                      cdsConsulta.FieldByName('FGO_CODEMP').AsString,
                                                                                      cdsConsulta.FieldByName('FGO_CODCLI').AsString,
                                                                                      False,
                                                                                      '',
                                                                                      '',
                                                                                      '',
                                                                                      arqArquivo,
                                                                                      opcComSemPreco),
                                                 '',
                                                 '',
                                                 '',
                                                 Self.UnitName);
      End;
    End;
  End
  Else
  Begin
    pCarregaDadosQRCodePix(LQRCodePix,
                           LLinkCitel);

    LQRCodePix := RetonaQRCodePixPedido(LQRCodePix,
                                        LLinkCitel,
                                        False);

    blnEnviado := fDisparaWhatsappAutomatico(cdsConsulta.FieldByName('FGO_NUMDOC').AsString,
                                             cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                                             cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                                             '',
                                             'CR',
                                             cdsConsulta.FieldByName('FGO_CODEMP').AsString,
                                             cdsConsulta.FieldByName('FGO_CODCLI').AsString,
                                             LQRCodePix,
                                             False,
                                             '',
                                             TGeraArquivoAnexoEmailAutomatico.New(cdsConsulta.FieldByName('FGO_NUMDOC').AsString,
                                                                                  cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                                                                                  cdsConsulta.FieldByName('FGO_CODEMP').AsString,
                                                                                  cdsConsulta.FieldByName('FGO_CODCLI').AsString,
                                                                                  False,
                                                                                  '',
                                                                                  '',
                                                                                  '',
                                                                                  arqArquivo,
                                                                                  opcComSemPreco),
                                             '',
                                             '',
                                             '',
                                             Self.UnitName);
  End;

  if blnEnviado then
    fMensagem('ATENÇÃO!', 'Whatsapp enviado com sucesso!', ['&Ok'])
  else
    fMensagem('ATENÇÃO!', 'Whatsapp não enviado!', ['&Ok']);

end;

procedure TfrmPnlDadosPedOrc.btnEnviarWppClick(Sender: TObject);
begin
  If Not fVerificaAcessoSistema('PERWPP', strLoginUsuarioLogado) Then
  Begin
    untFuncoesSimples.fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
    Exit;
  End;

  TfrmGravando.fExecutarModal(pEnviaWhatsapp, 'Aguarde, enviando Whatsapp ...', '');
end;

Function TfrmPnlDadosPedOrc.fRetornaItens: TUniQuery;
Begin
  result := fCriaQuery(Self);

  result.sql.Add('SELECT DISTINCT');
  result.sql.Add(' C.ITE_CODITE');
  result.sql.Add(',C.ITE_DESITE');
  result.sql.Add(',MAR_DESMAR');
  result.sql.Add(',FDO_UNIDAD');
  result.sql.Add(',FDO_QTDITE');
  result.sql.Add(',FDO_UNITAR');
  result.sql.Add(',FDO_TOTITE');
  result.sql.Add(',FDO_UNIORI');
  result.sql.Add('FROM FATGOR');
  result.sql.Add('      JOIN FATDOR   ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM');
  result.sql.Add('      JOIN CADITE C ON C.ITE_CODITE = FDO_CODITE');
  result.sql.Add('LEFT  JOIN CADMAR   ON MAR_CODMAR   = C.ITE_CODMAR');
  result.sql.Add('WHERE FGO_NUMDOC = :NUMDOC');
  result.sql.Add('AND   FGO_ESPDOC = :ESPDOC');
  result.sql.Add('AND   FGO_CODEMP = :CODEMP');
  result.ParamByName('NUMDOC').AsString := cdsConsulta.FieldByName('FGO_NUMDOC').AsString;
  result.ParamByName('ESPDOC').AsString := cdsConsulta.FieldByName('FGO_ESPDOC').AsString;
  result.ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('FGO_CODEMP').AsString;

  result.open;

End;

function TfrmPnlDadosPedOrc.fMSG_SenhaImprimirComPreco: Boolean;
var
  qryTabAux: TUniQuery;
  objTabela    : TRegistroMsgLiberaTabela;
  objLinha     : TLinhaMsgLibera;
  objLiberacao : TLiberacao;
  strCodEmi,
  strDesEmi,
  strMarEmi,
  strUndEmi,
  strQtdEmi,
  strUniTar,
  strTotIte,
  strUniOri    : String;
Begin

  objLiberacao := TLiberacao.Create;

  qryTabAux := fRetornaItens;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Senha para imprimir documento com preço');
  objLiberacao.objMsgLibera.pAddSeparador(75);
  objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'                   , cdsConsulta.FieldByName('CLI_NOMCLI').AsString                                                , 24);
  objLiberacao.objMsgLibera.pAddTextoCaption('Número Dcumento'           , cdsConsulta.FieldByName('FGO_NUMDOC').AsString                                                , 24);
  objLiberacao.objMsgLibera.pAddTextoCaption('Valor Total do Documento'  , FormatFloat('#,##0.00', cdsConsulta.FieldByName('FGO_VLRCON').AsFloat)                        , 24);

  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'Código/Descrição' , 24 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'Marca'            , 7  , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'Und.'             , 4  , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'Quantidade'       , 12 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'Pr. Unitário'     , 13 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'Valor Total'      , 14 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'Pr. Tabela'       , 13 , alDireita  , teAutcom);
  objTabela.lstLinhas.Add(objLinha);


  With qryTabAux Do
  Begin
    First;

    While Not Eof Do
    Begin

      strCodEmi := FieldByName('ITE_CODITE').AsString;
      strDesEmi := FieldByName('ITE_DESITE').AsString;
      strMarEmi := FieldByName('MAR_DESMAR').AsString;
      strUndEmi := fRetSiglaUni(FieldByName('FDO_UNIDAD').AsString);
      strQtdEmi := FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), FieldByName('FDO_QTDITE').AsFloat);
      strUniTar := FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), FieldByName('FDO_UNITAR').AsFloat);
      strTotIte := FormatFloat(fMskDigitos(2), FieldByName('FDO_TOTITE').AsFloat);
      strUniOri := FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), FieldByName('FDO_UNIORI').AsFloat);


      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('Código/Descrição' , strCodEmi + '-' + strDesEmi  , 24 , alEsquerda );
      objLinha.pAddColuna('Marca'            , strMarEmi                    , 7  , alEsquerda );
      objLinha.pAddColuna('Und.'             , strUndEmi                    , 4  , alCentro   );
      objLinha.pAddColuna('Quantidade'       , strQtdEmi                    , 12 , alDireita  );
      objLinha.pAddColuna('Pr. Unitário'     , strUniTar                    , 13 , alDireita  );
      objLinha.pAddColuna('Valor Total'      , strTotIte                    , 14 , alDireita  );
      objLinha.pAddColuna('Pr. Tabela'       , strUniOri                    , 13 , alDireita  );
      objTabela.lstLinhas.Add(objLinha);

      Next;
    End;
  End;


  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
  objLiberacao.strDirAce := 'IMPDCP';
  objLiberacao.strMsgSen := 'Senha para imprimir documento com preço';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCliente := cdsConsulta.FieldByName('FGO_CODCLI').AsString + '-' + cdsConsulta.FieldByName('CLI_NOMCLI').AsString;
  objLiberacao.strCpfCnpj := cdsConsulta.FieldByName('CLI_C_G_C_').AsString;

  Result := objLiberacao.fLibera;

  freeAndNil(objLiberacao);

End;

procedure TfrmPnlDadosPedOrc.pCarregaDadosQRCodePix(out AQrCodePix,
  ALinkCitel: String);
begin
  AQrCodePix := EmptyStr;
  ALinkCitel := EmptyStr;

  If Not fCfgSis('USAPIX', varBoolean) Then
    Exit;

  If cdsConsulta.FindField('MPX_QRCODE') <> Nil Then
  Begin
    AQrCodePix := cdsConsulta.FieldByName('MPX_QRCODE').AsString;
    ALinkCitel := cdsConsulta.FieldByName('MPX_LNKCIT').AsString;
  End;
end;

procedure TfrmPnlDadosPedOrc.pDefinirLayoutOrcPed;
begin
  If (blnShowmessage) And (fCfgSis('ORCSPR', varBoolean, VS_strCodEmp)) Then
  Begin
    If fCfgSis('ORSPSM', varBoolean, VS_strCodEmp) Then
    Begin
      Case fGetMenu('Opção para geração do PDF',['Com Preço e Com Marca', 'Com Preço e Sem Marca', 'Sem Preço e Com Marca', 'Sem Preço e Sem Marca'], 1) Of
        1:opcComSemPreco := impComPrecoComMarca;
        2:opcComSemPreco := impComPrecoSemMarca;
        3:opcComSemPreco := impSemPrecoComMarca;
        4:opcComSemPreco := impSemPrecoSemMarca;
      End;

      If (opcComSemPreco in [impComPrecoComMarca, impComPrecoGeral, impComPrecoSemMarca]) Then
      Begin
        If (fCfgSis('ORCSPR', varBoolean, VS_strCodEmp)) And (Not fEmptyStr(fCfgSis('SENPRE'))) Then
        Begin
          opcComSemPreco := IIF(fMSG_SenhaImprimirComPreco, opcComSemPreco, impSemPrecoGeral);

          If (fCfgSis('ORSPSM', varBoolean, VS_strCodEmp)) Then
          Begin
            If (opcComSemPreco = impSemPrecoGeral) Then
            Begin
              Case fGetMenu('Opção para geração do PDF (Sem preço pois não houve liberação!)',['Sem Preço e Com Marca', 'Sem Preço e Sem Marca'], 1) Of
                1:opcComSemPreco := impSemPrecoComMarca;
                2:opcComSemPreco := impSemPrecoSemMarca;
              End;
            End;
          End;
        End;
      End;
    End
    Else
    Begin
      If (fGetMenu('Opção para geração do PDF',['Com Preço', 'Sem Preço'], 1) = 1) Then
        opcComSemPreco := impComPrecoGeral
      Else
        opcComSemPreco := impSemPrecoGeral;

      If (opcComSemPreco = impComPrecoGeral) And (Not fEmptyStr(fCfgSis('SENPRE'))) Then
        opcComSemPreco := IIF(fMSG_SenhaImprimirComPreco, impComPrecoGeral, impSemPrecoGeral);
    End;
  End
  else
     opcComSemPreco := impComPrecoGeral;
end;

procedure TfrmPnlDadosPedOrc.pGerarArquivo(strPDF_XLS : String);
Var
  strArquivo : String;
  strOrdem   : String;
  blnComMar,
  blnLocFis  : Boolean;
  strModo    : String;
  strNomEmp  : String;
  blnCabCD   : Boolean;
  intIndex   : Integer;

  procedure pExecuta(blnExibirMensagem: Boolean = True);
  begin

    // VERIFICA PERMISSÃO PARA GERAR PDF
    If Not fVerificaAcessoSistema('PGEPDF', strLoginUsuarioLogado) Then
    Begin
      If blnExibirMensagem Then
        fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok'])
     Else
        strMensagem := strMensagem + cdsConsulta.FieldByName('FGO_NUMDOC').AsString +  ' Esse usuário não tem direitos para executar essa operação!' + #$A#$D;
      Exit;
    End;

    If (Not cdsConsulta.Active) Or (cdsConsulta.RecordCount <= 0) then
    Begin
      If blnExibirMensagem Then
        fMensagem('ATENÇÃO', 'Nenhum Registro Selecionado!', ['&OK']);
      Exit;
    End;

    strOrdem  := '';
    strNomEmp := 'R';
    blnComMar := True;
    blnLocFis := False;
    strModo   := 'R';
    blnCabCD  := False;

    inherited;

    TFatVenda.pAtualizacaoCotacaoDolar(cdsConsulta.FieldByName('FGO_NUMDOC').AsString,
                                       cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                                       cdsConsulta.FieldByName('FGO_CODEMP').AsString);

    Application.ProcessMessages;
    If Not fLayoutAtivoPdfPedidoOrcamento(cdsConsulta.FieldByName('FGO_NUMDOC').AsString,
                                          cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                                          VS_strCodEmp) and (Not fCfgSis('UTIDEF', varBoolean)) Then
    Begin
      If blnExibirMensagem Then
        fMensagem('ATENÇÃO', 'Não há Layout Disponível para gerar PDF!', ['&O k'])
      Else
        strMensagem := strMensagem + cdsConsulta.FieldByName('FGO_NUMDOC').AsString +  ' Não há Layout Disponível para gerar PDF!' + #$A#$D;
      Exit;
    End
    Else
      pDefinirLayoutOrcPed;

    Try
      pCriarFormularios(TfrmFatGorEmail, frmFatGorEmail);

      Application.ProcessMessages;
      strArquivo := frmFatGorEmail.fGeraEmail(cdsConsulta.FieldByName('FGO_NUMDOC').AsString,
                                              cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                                              opcComSemPreco,
                                              blnComMar,
                                              strPDF_XLS, {P = PDF | E = Excel}
                                              strModo,
                                              strOrdem,
                                              cdsConsulta.FieldByName('FGO_CODEMP').AsString,
                                              blnLocFis,
                                              strNomEmp,
                                              cdsConsulta.FieldByName('FGO_CODCLI').AsString,
                                              blnCabCD);
    Finally
      pDestroiModulo(frmFatGorEmail);
    End;

    If (Not fEmptyStr(strArquivo)) Then
    Begin
//      pSetForegroundWindowsConsulta;

      If VirtualUI.Active Then
        VirtualUI.PreviewPdf(strArquivo)
      Else
        pExecArquivo(strArquivo, Handle);
    End;

  end;

Begin

  If (strPDF_XLS = 'P') And (Not btnGerarPDF.Visible) Then
    Exit;

  If (strPDF_XLS = 'E') And (Not btnGerarXLS.Visible) Then
    Exit;

  blnShowmessage := True;
  strMensagem := '';

  If fVariosDocumentosSelecionados Then
  Begin
    For intIndex := 0 To objPanel.stlListaSelecao.Count -1 do
    Begin
      If fLocalizaPosicaoListaSelecaoNoCdsConsulta(intIndex) Then
        pExecuta(False);
      blnShowmessage := False;
    End;
  End
  Else
    pExecuta;

  If Not fEmptyStr(strMensagem) Then
    fMensagem('Atenção!', strMensagem, ['&OK']);

end;

procedure TfrmPnlDadosPedOrc.pGerarPDF;
begin
  pGerarArquivo('P');
end;

procedure TfrmPnlDadosPedOrc.pGerarXLS;
begin
  pGerarArquivo('E');
end;

procedure TfrmPnlDadosPedOrc.pIniciouNavegacaoGridConsulta;
begin
  pDesabilitaColunas;
end;

procedure TfrmPnlDadosPedOrc.btnGerarPDFClick(Sender: TObject);
begin
  TfrmGravando.fExecutarModalA(pGerarPDF, 'Aguarde... Gerando Arquivo (.PDF)', '');
end;

procedure TfrmPnlDadosPedOrc.btnGerarXLSClick(Sender: TObject);
begin
  TfrmGravando.fExecutarModalA(pGerarXLS, 'Aguarde... Gerando Planilha (.XLS)', '');
end;

procedure TfrmPnlDadosPedOrc.btnGerCabClick(Sender: TObject);
  Var
    ExpCabPedOrc: TExpCabPedOrc;
begin
  If fVariosDocumentosSelecionados Then
  Begin
    fMensagem('ATENÇÃO!', 'Apenas um documento pode estar selecionado para executar essa operação!', ['&Ok']);
    Exit;
  End;
  If (Not btnGerCab.Visible) Then
    Exit;

  ExpCabPedOrc := TExpCabPedOrc.CreateInstance(Self, strPatCab);

  Try
    ExpCabPedOrc.fExportar(cdsConsulta.FieldByName('FGO_NUMDOC').AsString,
                           cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                           cdsConsulta.FieldByName('FGO_CODEMP').AsString,
                           cdsConsulta.FieldByName('FGO_CODCLI').AsString);
  Finally
    FreeAndNil(ExpCabPedOrc);
  End;
end;

procedure TfrmPnlDadosPedOrc.btnImpSepClick(Sender: TObject);
  Var
    objImpSep: TReimpressao;
    blnImpSep: Boolean;
    strOps: String;
begin
  inherited;
  If fVariosDocumentosSelecionados Then
  Begin
    fMensagem('ATENÇÃO!', 'Apenas um documento pode estar selecionado para executar essa operação!', ['&Ok']);
    Exit;
  End;

  If Not btnImpSep.Visible Then
    Exit;

  With cdsConsulta Do
  Begin

    If IsEmpty Then
      Exit;

    If fPedidoJaFaturado Then
    Begin
      fMensagem('ATENÇÃO!', 'O pedido selecionado já foi faturado e por isso não é permitido imprimir sua separação.', ['&Ok']);
      Exit;
    End;

    If Not fCfgSis('SEPVIS', varBoolean) And Not fSituacaoFinanceiraPedidoOk Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido imprimir a separação de pedidos à vista que ainda não foram recebidos (CFG_SEPVIS)', ['&Ok']);
      Exit;
    End;

    If fCfgSis('SEPOPI', varBoolean) Then
    Begin
      strOps := TFatVendaImp.fGetOPs_PD(FieldByName('FGO_NUMDOC').AsString,
                                        FieldByName('FGO_ESPDOC').AsString,
                                        FieldByName('FGO_CODEMP').AsString);

      If Not fEmptyStr(strOps) Then
      Begin
        fMensagem('ATENÇÃO!', 'Este pedido de venda possui item estrutura com ordem de produção. A separação somente '+
                              'poderá ser impressa depois da baixa da ordem de produção. OP(s): '+ strOps +'.', ['&Ok']);
        Exit;
      End;
    End;

    If Not fVerificaAcessoSistema('SEPCPD') Then
    Begin
      If Not fLiberacaoImpSeparacao Then
        Exit;
    End;

    If (fCfgSis('FILCPD', varString)= 'S') And (fUtilizaFilasImpressaoSeparacaoConfiguradas(FieldByName('FGO_ESPDOC').AsString)) Then
    Begin
      fImprimeSeparacaoFaturamento(FieldByName('FGO_NUMDOC').AsString,
                                   FieldByName('FGO_ESPDOC').AsString,
                                   FieldByName('FGO_CODEMP').AsString,
                                   FieldByName('FGO_CODCLI').AsString);
    End
    Else
    Begin
      blnImpSep := (VS_strTipExp = '2') Or (fCfgSis('SEPEXP') = 'E');

      objImpSep := TReimpressao.Create(FieldByName('FGO_NUMDOC').AsString,  //strNumDoc
                                       FieldByName('FGO_ESPDOC').AsString,  //strEspDoc
                                       0,                                   //dtaDtaIni
                                       0,                                   //dtaDtaFin
                                       FieldByName('FGO_CODCLI').AsString,  //strCodCli
                                       FieldByName('FGO_CODEMP').AsString,  //strCodEmp
                                       FieldByName('FGO_CODVEN').AsString,  //strCodVen
                                       VS_strTipExp = '2',                  //blnFaturamento
                                       '',                                  //strTip_Fc
                                       blnImpSep,                           //blnPergSep
                                       False,                               //blnFatVenda
                                       False,                               //blnCancelamento
                                       '',                                  //strEspSel
                                       '',                                  //strSerie
                                       False,                               //blnFiltrarNE
                                       0,                                   //intFilCla
                                       False,                               //blnExiDocsCanc
                                       '');                                 //strOriDoc

      objImpSep.blnExpedicao := True;

      objImpSep.fImprimeSeparacao('', False, False, False, (VS_strTipExp <> '2'), False, opcTodos, True);

      FreeAndNil(objImpSep);
    End;
  End;
end;

procedure TfrmPnlDadosPedOrc.btnItensPendClick(Sender: TObject);
begin
  If fVariosDocumentosSelecionados Then
  Begin
    fMensagem('ATENÇÃO!', 'Apenas um documento pode estar selecionado para executar essa operação!', ['&Ok']);
    Exit;
  End;

  If (Not btnItensPend.Enabled) Or (Not btnItensPend.Visible) Then
    Exit;

  If (cdsConsulta.IsEmpty) Then
    Exit;

  If (cdsConsulta.FieldByName('FGO_ESPDOC').AsString = 'OR') Then
  Begin

    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(109, 5839, [],
                          ['NUMDOC','ESPDOC','CODEMP'],
                          [cdsConsulta.FieldByName('FGO_NUMDOC').AsString,
                          cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                          cdsConsulta.FieldByName('FGO_CODEMP').AsString],
                          Sender,
                          nil,
                          True);
    End;

  End
  else
  begin

    pMostraItensPendentes;

  end;

end;

procedure TfrmPnlDadosPedOrc.btnLegendaStatusClick(Sender: TObject);
begin
  If Not btnLegendaStatus.Visible Then
    Exit;

  pShowLegenda(nil, TSituacaoPedidoVenda.fRetornaLegenda);
end;

procedure TfrmPnlDadosPedOrc.btnLibNegadaClick(Sender: TObject);
begin

  If fVariosDocumentosSelecionados Then
  Begin
    fMensagem('ATENÇÃO!', 'Apenas um documento pode estar selecionado para executar essa operação!', ['&Ok']);
    Exit;
  End;

  If Not btnLibNegada.Visible Then
    Exit;

  If (cdsConsulta.IsEmpty) Then
    Exit;

  With cdsConsulta Do
  Begin

    If (Not Active) Or (IsEmpty) Then
    Begin
      Exit;
    End;

    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(71, 5206, [],
                          ['NUMDOC','CODEMP'],
                          [FieldByName('FGO_NUMDOC').AsString,
                          FieldByName('FGO_CODEMP').AsString],
                          Sender,
                          nil,
                          True);
    End;

  End;

end;

procedure TfrmPnlDadosPedOrc.btnLimpSepClick(Sender: TObject);
begin

  Try

    If Not btnLimpSep.Visible Then
      Exit;

    If fUsaOndaSeparacaoAgrupamento And
       fFoiSelecionadoPedidoDeRemessaDePedidoComRemessaDeSeparacaoJaGerada(cdsConsulta.FieldByName('AUTOINCREM').AsString) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é possível limpar a separação de um pedido pertencente a Remessa de Pedido/Separação!', ['&Ok']);
      Exit;
    End;

    If fLimpaExpedicaoPedido(cdsConsulta.FieldByName('AUTOINCREM').AsString) Then
      pMensagemOk('Operação realizada com sucesso.');

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.message, 'TfrmPnlDadosPedOrc.btnLimpSepClick');
    End;
  End;

end;

procedure TfrmPnlDadosPedOrc.btnPedidosVinculadosClick(Sender: TObject);
begin
  If Not btnPedidosVinculados.Visible Then
    Exit;

  If cdsConsulta.RecordCount <= 0  Then
    Exit;

  If cdsConsulta.RecNo <= 0 Then
    Exit;

  If Not fListaPedidosVinculados Then
    pMensagemOk('O ' + fTipoDoc(cdsConsulta.FieldByName('FGO_ESPDOC').AsString) + ' ' + cdsConsulta.FieldByName('FGO_NUMDOC').AsString + ' não possui pedidos vinculados!');
end;

procedure TfrmPnlDadosPedOrc.btnProfisClick(Sender: TObject);
begin
  If Not btnProfis.Visible Then
    Exit;

  If cdsConsulta.RecordCount <= 0  Then
    Exit;

  If cdsConsulta.RecNo <= 0 Then
    Exit;

  If Not fTemProfissionais(cdsConsulta.FieldByName('FGO_NUMDOC').AsString,
                           cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                           cdsConsulta.FieldByName('FGO_CODEMP').AsString,
                           cdsConsulta.FieldByName('FGO_CODCLI').AsString) Then
  Begin
    pMensagemOk('O ' + fTipoDoc(cdsConsulta.FieldByName('FGO_ESPDOC').AsString) + ' ' + cdsConsulta.FieldByName('FGO_NUMDOC').AsString + ' não tem profissionais cadastrados');
  End;
end;

procedure TfrmPnlDadosPedOrc.btnSituacaoItensClick(Sender: TObject);
begin
  TFrmGravando.fExecutarModalA( pMostraSituacaoItens, 'Aguarde... Buscando situações dos itens !', '');
end;

procedure TfrmPnlDadosPedOrc.chkExibirTodosPedClick(Sender: TObject);
begin
  pVerificaExibirTodosPedidos;
end;

constructor TfrmPnlDadosPedOrc.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  blnCRM := False;
  blnPermitirExibirTodosOsPedidos := False;
  strClienteSelecionado := '';
  intTamanhoOwnerOriginal := 0;
  blnMarcarExibirTodosOsPedidos := False;
end;

procedure TfrmPnlDadosPedOrc.FormCreate(Sender: TObject);
begin
  btnGerarXLS.Visible := TDocPDOR_Excel.fUtilizaLayOutExcel;
end;

procedure TfrmPnlDadosPedOrc.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_F1 : If (Shift = [ssAlt]) Then btnLegendaStatus.Click;
    VK_F2 : If (Shift = [ssAlt]) Then btnLimpSep.Click;
    VK_F4 : btnEfetivarOrcamento.Click;
    VK_F5 : Begin
              If (Shift = [ssAlt]) Then
                btnPedidosVinculados.Click
              Else
                btnLibNegada.Click;
            End;
    VK_F6 : begin
              if (Shift = [ssAlt]) then
                btnProfis.Click
              else
                btnGerCab.Click;
            end;
    VK_F7 : btnImpSep.Click;
    VK_F8 : btnGerarPDF.Click;
    VK_F9 : If (Shift = [ssAlt]) Then btnEnviarWpp.Click Else btnEnviarEmail.Click;
    VK_F10: btnBaixaPedido.Click;
    VK_F11:
    begin
      If (Shift = [ssAlt]) then
        btnSituacaoItens.Click
      else
        btnItensPend.Click;
    end;
    VK_F12:
    begin
      If (Shift = [ssAlt]) then
        btnCobrancaYapay.Click
      else
        btnGerarXLS.Click;
    end;
  End;

  Case Key Of
    VK_F4,
    VK_F5,
    VK_F6,
    VK_F7,
    VK_F8,
    VK_F9,
    VK_F10,
    VK_F11,
    VK_F12: Key := 0;
  End;

end;

procedure TfrmPnlDadosPedOrc.FormShow(Sender: TObject);
begin
  strPatCab := ExtractFilePath(Application.ExeName) + 'MODELO_CABECALHO.docx';
  pDesabilitaColunas;

  grpLegenda.Visible := SameText(strEspDoc, 'PD');

  btnImpSep.Visible := fCfgSis('SEPCPD', varBoolean)     And
                       Not fCfgSis('UTIWMS', varBoolean) And
                       Not fCfgSis('ROMLOT', varBoolean) And
                       Not fCfgSis('AUTCEN', varBoolean) And
                       Not fCfgSis('LIBPED', varBoolean) And
                       Not ((fCfgSis('MOVDAV') = '2') And fCfgSis('PAFECF', varBoolean));

  btnEnviarWpp.Visible := fCfgSis('UTIWPP', varBoolean);

  chkExibirTodosPed.Visible := blnPermitirExibirTodosOsPedidos;
  chkExibirTodosPed.Checked := False;

  If (chkExibirTodosPed.Visible) Then
   chkExibirTodosPed.Checked := blnMarcarExibirTodosOsPedidos;
end;

function TfrmPnlDadosPedOrc.fExibiBotaoMotivoLibNegada : Boolean;
begin
  Result := (cdsConsulta.FieldByName('FGO_FINLIB').AsString = 'LIBERACAO NEGADA') Or
            ((cdsConsulta.FindField('FGO_COMLIB') <> Nil) And
             (cdsConsulta.FieldByName('FGO_COMLIB').AsString = 'BLOQUEADO PELO DEP. COMERCIAL'));
end;

procedure TfrmPnlDadosPedOrc.pDesabilitaColunas;
var
  intNovoTamanho: integer;
begin
  If (Not Self.Showing) Then
    Exit;

  lblTotRegistros.Visible := fCfgSis('NRPDOR', varBoolean) and
                             (Pos(cdsConsulta.FieldByName('FGO_ESPDOC').AsString,'PD_OR_') > 0);

  lblTotRegistros.Caption := 'Total de Registros: 0';
  lblTotRegistros.Refresh;


  If (Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty) Then
  Begin
    btnEfetivarOrcamento.Visible := False;
    btnBaixaPedido.Visible := False;
    btnItensPend.Visible := False;
    btnLimpSep.Visible := False;
    btnGerCab.Visible := False;
    btnLibNegada.Visible := False;
    btnCobrancaYapay.Visible := False;
    btnSituacaoItens.Visible := False;
    Exit;
  End;

  if (lblTotRegistros.Visible) then
  begin
    lblTotRegistros.Caption := 'Total de Registros: '+ IntToStr(cdsConsulta.RecordCount);
    lblTotRegistros.Refresh;
  end;

  btnSituacaoItens.Visible := fCfgSis('EXISTA',varBoolean);

  btnCobrancaYapay.Visible :=
    (fCfgSis('YAPHAB',varBoolean)) and
    (TYapayFacade.fPedidoPossuiCobrancaAtiva(cdsConsulta.FieldByName('AUTOINCREM').AsString));

  if (btnCobrancaYapay.Visible) or (btnSituacaoItens.Visible) then
  begin
    if intTamanhoOwnerOriginal = 0 then
      intTamanhoOwnerOriginal := self.parent.parent.height;

    intNovoTamanho := intTamanhoOwnerOriginal + btnCobrancaYapay.Height;
    if self.parent.parent.height <> intNovoTamanho then
      self.parent.parent.height := intNovoTamanho;
  end
  else if intTamanhoOwnerOriginal <> 0 then
    self.parent.parent.height := intTamanhoOwnerOriginal;

  cdsConsulta.FieldByName('CLI_EMAIL_').Visible := False;

  If (cdsConsulta.FindField('FGO_ULTPED') <> Nil) And
     (cdsConsulta.FieldByName('FGO_ULTPED').AsString = '1') Then
  Begin
    cdsConsulta.FieldByName('FGO_NUMDOC').Visible := False;
    cdsConsulta.FieldByName('FGO_NOMCON').Visible := False;
    cdsConsulta.FieldByName('CLI_NOMCLI').Visible := False;
    cdsConsulta.FieldByName('FGO_CODVEN').Visible := False;
    cdsConsulta.FieldByName('FGO_DTAENT').Visible := False;
    cdsConsulta.FieldByName('TRA_NOMTRA').Visible := False;
    cdsConsulta.FieldByName('CID_NOMCID').Visible := False;
    cdsConsulta.FieldByName('FGO_PEDSIT').Visible := False;
  End;

  {******************************}
  {* VERIFICA SE O CAMPO EXISTE *}
  {***************************DP*}
  If (cdsConsulta.FindField('FGO_LIBERA') <> Nil) Then
    If (cdsConsulta.FieldByName('FGO_ESPDOC').AsString <> 'PD') Then
      cdsConsulta.FieldByName('FGO_LIBERA').Visible := False;

  If (cdsConsulta.FieldByName('FGO_ESPDOC').AsString = 'OR') Then
    btnBaixaPedido.Caption := '[F10] Baixar Orçamentos que não serão faturados';

  btnEfetivarOrcamento.Visible := (cdsConsulta.FieldByName('FGO_ESPDOC').AsString = 'OR') And
                                  (cdsConsulta.FieldByName('FGO_CODEMP').AsString = VS_strCodEmp) And
                                  (fCfgSis('USAFPG', varBoolean)) And
                                  (fCfgSis('USAPDV', varBoolean));

  btnBaixaPedido.Visible := Pos(cdsConsulta.FieldByName('FGO_ESPDOC').AsString,'PD_OR_') > 0;
  btnItensPend.Visible := AnsiMatchStr(cdsConsulta.FieldByName('FGO_ESPDOC').AsString, ['PD', 'OR']);
  If (cdsConsulta.FieldByName('FGO_ESPDOC').AsString = 'OR') Then
    btnItensPend.Caption := '[F11] Itens do Documento';

  btnLimpSep.Visible   := (cdsConsulta.FieldByName('FGO_ESPDOC').AsString = 'PD') And
                          (fVerificaAcessoSistema('PRODLIMSEP')) And
                          ( Not fCfgSis('UTICRM', varBoolean) );
  btnGerCab.Visible := (Pos(cdsConsulta.FieldByName('FGO_ESPDOC').AsString,'PD_OR_') > 0) And
                       (fCfgSis('CABWOR') = 'S') And
                       (FileExists(strPatCab));
  If (cdsConsulta.FieldByName('FGO_ESPDOC').AsString = 'PD') Then
    btnLibNegada.Visible := fExibiBotaoMotivoLibNegada
  Else
    btnLibNegada.Visible := False;

  btnLegendaStatus.Visible := (cdsConsulta.FieldByName('FGO_ESPDOC').AsString = 'PD') And
                              (fCfgSis('EXISTA', varBoolean));

  btnProfis.Visible := (Pos(cdsConsulta.FieldByName('FGO_ESPDOC').AsString,'PD_OR_') > 0) And
                       (Pos(fCfgSis('NROPRO'),'2_3_') > 0);

  btnPedidosVinculados.Visible := (Pos(cdsConsulta.FieldByName('FGO_ESPDOC').AsString,'PD_') > 0);
end;

procedure TfrmPnlDadosPedOrc.pMostraSituacaoItens;
var
  frmSituacaoItensPedidoLocal: TfrmSituacaoItensPedido;
begin
  inherited;
  try
    pCriarFormularios(TfrmSituacaoItensPedido, frmSituacaoItensPedidoLocal);
    frmSituacaoItensPedidoLocal.strNumDoc := cdsConsulta.FieldByName('FGO_NUMDOC').AsString;
    frmSituacaoItensPedidoLocal.strEspDoc := cdsConsulta.FieldByName('FGO_ESPDOC').AsString;
    frmSituacaoItensPedidoLocal.strCodEmp := cdsConsulta.FieldByName('FGO_CODEMP').AsString;
    frmSituacaoItensPedidoLocal.ShowModal;
  finally
    pFreeAndNil(frmSituacaoItensPedidoLocal);
  end;
end;

procedure TfrmPnlDadosPedOrc.pParouNavegacaoGridConsulta;
begin
  If (Not Self.Showing) Then
    Exit;

  pDesabilitaColunas;
end;

procedure TfrmPnlDadosPedOrc.pValidaTemFiltro;
begin
  if chkExibirTodosPed.Visible then
    pVerificaExibirTodosPedidos;
end;

procedure TfrmPnlDadosPedOrc.pVerificaExibirTodosPedidos;
begin
  if (not Assigned(objPanel.FAplicaFiltro)) then
    Exit;

  if chkExibirTodosPed.Checked then
    objPanel.FAplicaFiltro('')
  else
    objPanel.FAplicaFiltro('(NUMOSE IS NULL OR NUMOSE = '''')');
end;

(*function TfrmPnlDadosPedOrc.fValidaQtdRegistroGrid: boolean;
Begin
  Result := Not (cdsConsulta.IsEmpty);
  If Not Result Then
    fMensagem('ATENÇÃO!', 'Nenhum Pedido de Compra Selecionado!', ['&Ok']);
End;

function TfrmPnlDadosPedOrc.fRetListaSelecaoInstrucaoSQL_IN: string;
Begin
  If objPanel.stlListaSelecao.Count = -1 Then
    Result := ' ';

  Result := fRetStrToSQLIn(objPanel.stlListaSelecao.CommaText, ',')
End;*)

function TfrmPnlDadosPedOrc.fVariosDocumentosSelecionados: boolean;
Begin
  Result := objPanel.stlListaSelecao.Count > 1
End;

function TfrmPnlDadosPedOrc.fLiberacaoImpSeparacao: Boolean;
  Var
    objLiberacao: TLiberacao;
begin
  objLiberacao := TLiberacao.Create;
  objLiberacao.objMsgLibera.pAddTexto('Atenção! Operador não possui direito de acesso liberado para imprimir a separação na consulta de pedidos.');
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddTexto('Documento: '+ cdsConsulta.FieldByName('FGO_NUMDOC').AsString +'-'+
    cdsConsulta.FieldByName('FGO_ESPDOC').AsString +'-'+ cdsConsulta.FieldByName('FGO_CODEMP').AsString);
  objLiberacao.objMsgLibera.pAddTexto('Cliente:   '+ cdsConsulta.FieldByName('FGO_CODCLI').AsString +'-'+
    cdsConsulta.FieldByName('CLI_NOMCLI').AsString);

  objLiberacao.strDirAce := 'SEPCPD';
  objLiberacao.strMsgSen := 'Impressão de Separação.';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;
  objLiberacao.blnUsarSenhaFixa := False;
  objLiberacao.blnSempreVariavelUsuario := True;

  Result := objLiberacao.fLibera;

  FreeAndNil(objLiberacao);
end;

function TfrmPnlDadosPedOrc.fLiberouTravaProdutoVinculadoLoteSeparacao(
  arrPedidos: TStringArray): Boolean;
var
  objLiberacao: TLiberacao;
  intIndice: integer;
  strAutInc: String;
  qryPedidos: TUniQuery;
begin
  Result := True;

  if Length(arrPedidos) <= 0 then
    Exit;

  objLiberacao := TLiberacao.Create;
  qryPedidos := fCriaQuery;

  try
    strAutInc := EmptyStr;

    for intIndice := 0 to Length(arrPedidos) - 1 do
    begin
      pIncrementaListaStr(arrPedidos[intIndice], strAutInc, True);
    end;

    if fEmptyStr(strAutInc) then
      Exit;

    qryPedidos.Close;
    qryPedidos.SQL.Clear;
    qryPedidos.SQL.Add('SELECT F.FGO_NUMDOC, F.FGO_ESPDOC, F.FGO_CODEMP, F.FGO_CODCLI, C.CLI_NOMCLI, G.RLG_DESLOT');
    qryPedidos.SQL.Add('FROM FATGOR F');
    qryPedidos.SQL.Add('INNER JOIN CADCLI C');
    qryPedidos.SQL.Add('ON(F.FGO_CODCLI = C.CLI_CODCLI)');
    qryPedidos.SQL.Add('INNER JOIN ROMLDE D');
    qryPedidos.SQL.Add('ON(F.FGO_NUMDOC = D.RLD_NUMDOC AND F.FGO_ESPDOC = D.RLD_ESPDOC AND F.FGO_CODEMP = D.RLD_CODEMP)');
    qryPedidos.SQL.Add('INNER JOIN ROMLGE G');
    qryPedidos.SQL.Add('ON(D.RLD_SEQRLG = G.AUTOINCREM)');
    qryPedidos.SQL.Add('WHERE F.AUTOINCREM IN('+strAutInc+')');
    qryPedidos.Open;

    if qryPedidos.IsEmpty then
      Exit;
    objLiberacao.objMsgLibera.pAddSeparador(100);
    objLiberacao.objMsgLibera.pAddTexto('LIBERAÇÃO DE PEDIDO DE VENDA VINCLUADO A UM LOTE DE SEPARAÇÃO DE ROMANEIO');
    objLiberacao.objMsgLibera.pAddSeparador(100);

    if qryPedidos.RecordCount = 1 then
      objLiberacao.objMsgLibera.pAddTexto('Este pedido de venda está vinculado a um lote de separação para romaneio.')
    else
      objLiberacao.objMsgLibera.pAddTexto('Estes pedidos de venda estão vinculados a um lote de separação para romaneio.');

    objLiberacao.objMsgLibera.pAddQuebra;

    while not qryPedidos.Eof do
    begin
      objLiberacao.objMsgLibera.pAddTexto('PEDIDO  : ' + qryPedidos.FieldByName('FGO_NUMDOC').AsString + '-' + qryPedidos.FieldByName('FGO_ESPDOC').AsString + '-' + qryPedidos.FieldByName('FGO_CODEMP').AsString);
      objLiberacao.objMsgLibera.pAddTexto('CLIENTE : ' + qryPedidos.FieldByName('FGO_CODCLI').AsString + ' - ' + qryPedidos.FieldByName('CLI_NOMCLI').AsString);
      objLiberacao.objMsgLibera.pAddTexto('LOTE    : ' + qryPedidos.FieldByName('RLG_DESLOT').AsString);
      objLiberacao.objMsgLibera.pAddSeparador(100);
      qryPedidos.Next;
    end;

    objLiberacao.strDirAce := 'BPVLSR';
    objLiberacao.strMsgSen := 'Senha liberar baixar pedidos vinculados a um lote de separação para romaneio';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  finally
    FreeAndNil(objLiberacao);
    FreeAndNil(qryPedidos);
  end;
end;

function TfrmPnlDadosPedOrc.fListaPedidosVinculados: Boolean;
  Var
    strSQLPedVinc: String;
    qryPedVinc: TUniQuery;
    qryExtGor: TUniQuery;
begin
  Result := False;

  strSQLPedVinc := ' SELECT';
  strSQLPedVinc := strSQLPedVinc + '   FGO_DTAENT AS DTAENT, CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_CODEMP) AS NUMDOC,';
  strSQLPedVinc := strSQLPedVinc + '   SUM( IF( COALESCE(FDO_QTDBAI, 0) = 0, FDO_TOTITE - FDO_DESESP, ROUND(((FDO_TOTITE - FDO_DESESP) / FDO_QTDITE) * (FDO_QTDITE - FDO_QTDBAI), 2 ) ) ) AS VALDOC, ';
  strSQLPedVinc := strSQLPedVinc + '   FGO_VLRCON AS VLRCON, ';
  strSQLPedVinc := strSQLPedVinc + '   CAST( GROUP_CONCAT(DISTINCT IF(FD.FDO_ENTFUT = "S", "ENT.FUTURA", IF(ED.FDO_ENTRET = "R", "RETIRA", "ENT.IMEDIATA"))  SEPARATOR "/") AS CHAR(50)) AS ENTRET, ';
  strSQLPedVinc := strSQLPedVinc + '   CAST( GROUP_CONCAT(DISTINCT FDO_EMPITE SEPARATOR "/") AS CHAR(50)) AS EMPITE, ';
  strSQLPedVinc := strSQLPedVinc + '   FGO_DTAFAT AS DTAFAT,';
  strSQLPedVinc := strSQLPedVinc + '   CONCAT(FGO_NUMFAT, "-", FGO_TIPFAT, "-", FGO_EMPFAT) AS NUMFAT';
  strSQLPedVinc := strSQLPedVinc + ' FROM FATGOR FG';
  strSQLPedVinc := strSQLPedVinc + ' INNER JOIN EXTGOR EG ON EG.FGO_SEQFGO = FG.AUTOINCREM';
  strSQLPedVinc := strSQLPedVinc + ' INNER JOIN FATDOR FD ON FG.AUTOINCREM = FD.FDO_SEQGER';
  strSQLPedVinc := strSQLPedVinc + '  LEFT JOIN EXTDOR ED ON FD.AUTOINCREM = ED.FDO_SEQFDO ';
  strSQLPedVinc := strSQLPedVinc + ' WHERE EG.FGO_SEQDMP = :SEQDMP';
  strSQLPedVinc := strSQLPedVinc + ' GROUP BY';
  strSQLPedVinc := strSQLPedVinc + '   FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP, FGO_CODCLI ';

  strSQLPedVinc := strSQLPedVinc + ' UNION ALL';

  strSQLPedVinc := strSQLPedVinc + ' SELECT';
  strSQLPedVinc := strSQLPedVinc + '   GER_DTAENT AS DTAENT, CONCAT(GER_NUMDOC, "-", GER_ESPDOC, "-", GER_CODEMP) AS NUMDOC,';
  strSQLPedVinc := strSQLPedVinc + '   GER_VLRCON AS VALDOC, GER_VLRCON AS VLRCON, ';
  strSQLPedVinc := strSQLPedVinc + '   IF(GER_ENTFUT = "S", "ENT.FUTURA", IF(GER_ENTFAT = "S", "ENT.IMEDIATA", "RETIRA")) AS ENTRET, ';
  strSQLPedVinc := strSQLPedVinc + '   CAST( GROUP_CONCAT(DISTINCT DET_CODEMP SEPARATOR "/") AS CHAR(50)) AS EMPITE, ';
  strSQLPedVinc := strSQLPedVinc + '   GER_DTAFAT AS DTAFAT,';
  strSQLPedVinc := strSQLPedVinc + '   CONCAT(GER_NUMFAT, "-", GER_TIPFAT, "-", GER_EMPFAT) AS NUMFAT';
  strSQLPedVinc := strSQLPedVinc + ' FROM MOVGER MG';
  strSQLPedVinc := strSQLPedVinc + ' INNER JOIN AUXMOV AM ON AM.AUX_SEQGER = MG.AUTOINCREM';
  strSQLPedVinc := strSQLPedVinc + ' INNER JOIN MOVDET MD ON MD.DET_SEQGER = MG.AUTOINCREM';
  strSQLPedVinc := strSQLPedVinc + ' WHERE AM.AUX_SEQDMP = :SEQDMP';
  strSQLPedVinc := strSQLPedVinc + ' GROUP BY';
  strSQLPedVinc := strSQLPedVinc + '   GER_NUMDOC, GER_ESPDOC, GER_CODEMP, GER_CODCLI ';

  qryPedVinc := fCriaQuery;
  qryExtGor  := fCriaQuery;
  Try
    qryExtGor.Close;
    qryExtGor.SQL.Clear;
    qryExtGor.SQL.Add('SELECT EG.FGO_SEQDMP FROM EXTGOR EG INNER JOIN FATGOR FG ON EG.FGO_SEQFGO = FG.AUTOINCREM ');
    qryExtGor.SQL.Add('WHERE FG.FGO_NUMDOC = :NUMDOC AND FG.FGO_ESPDOC = :ESPDOC AND FG.FGO_CODEMP = :CODEMP');
    qryExtGor.ParamByName('NUMDOC').AsString := cdsConsulta.FieldByName('FGO_NUMDOC').AsString;
    qryExtGor.ParamByName('ESPDOC').AsString := cdsConsulta.FieldByName('FGO_ESPDOC').AsString;
    qryExtGor.ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('FGO_CODEMP').AsString;
    qryExtGor.Open;

    If fEmptyStr(qryExtGor.FieldByName('FGO_SEQDMP').AsString) Then
      Exit;

    qryPedVinc.Close;
    qryPedVinc.SQL.Clear;
    qryPedVinc.SQL.Add(strSQLPedVinc);
    qryPedVinc.ParamByName('SEQDMP').AsString := qryExtGor.FieldByName('FGO_SEQDMP').AsString;
    qryPedVinc.Open;

    If qryPedVinc.IsEmpty Then
      Exit;

    pCriarFormularios(TfrmGrid, frmGrid);
    Try
      frmGrid.Width := 920;
      frmGrid.DataSet := qryPedVinc;
      frmGrid.dsrInfo.DataSet.FieldByName('NUMDOC').DisplayWidth := 20;
      frmGrid.dsrInfo.DataSet.FieldByName('DTAENT').DisplayWidth := 15;
      frmGrid.dsrInfo.DataSet.FieldByName('VALDOC').DisplayWidth := 15;
      frmGrid.dsrInfo.DataSet.FieldByName('VLRCON').DisplayWidth := 15;
      frmGrid.dsrInfo.DataSet.FieldByName('ENTRET').DisplayWidth := 20;
      frmGrid.dsrInfo.DataSet.FieldByName('EMPITE').DisplayWidth := 20;
      frmGrid.dsrInfo.DataSet.FieldByName('DTAFAT').DisplayWidth := 15;
      frmGrid.dsrInfo.DataSet.FieldByName('NUMFAT').DisplayWidth := 25;
      frmGrid.dsrInfo.DataSet.FieldByName('NUMDOC').DisplayLabel := 'Documento';
      frmGrid.dsrInfo.DataSet.FieldByName('DTAENT').DisplayLabel := 'Data Emissão';
      frmGrid.dsrInfo.DataSet.FieldByName('VALDOC').DisplayLabel := 'Valor';
      frmGrid.dsrInfo.DataSet.FieldByName('VLRCON').DisplayLabel := 'Valor Contábil';
      frmGrid.dsrInfo.DataSet.FieldByName('ENTRET').DisplayLabel := 'Destino';
      frmGrid.dsrInfo.DataSet.FieldByName('EMPITE').DisplayLabel := 'Empresa Destino';
      frmGrid.dsrInfo.DataSet.FieldByName('DTAFAT').DisplayLabel := 'Data Faturamento';
      frmGrid.dsrInfo.DataSet.FieldByName('NUMFAT').DisplayLabel := 'Documento Faturado';
      TFloatField(frmGrid.dsrInfo.DataSet.FieldByName('VALDOC')).DisplayFormat := fMskDigitos(2);
      TFloatField(frmGrid.dsrInfo.DataSet.FieldByName('VLRCON')).DisplayFormat := fMskDigitos(2);
      frmGrid.Caption := 'Pedidos Vinculados';
      frmGrid.ShowModal;

      Result := True;
    Finally
      pFreeAndNil(frmGrid);
    End;
  Finally
    FreeAndNil(qryPedVinc);
    FreeAndNil(qryExtGor);
  End;
end;

function TfrmPnlDadosPedOrc.fPedidoJaFaturado: Boolean;
begin
  Result := fCampoTabela('FGO_JAFATU', 'FATGOR', ['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP'],
                         [cdsConsulta.FieldByName('FGO_NUMDOC').AsString,
                          cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                          cdsConsulta.FieldByName('FGO_CODEMP').AsString], True) = 1;
end;

function TfrmPnlDadosPedOrc.fSituacaoFinanceiraPedidoOk: Boolean;
  Var
    strPenFin: String;
begin
  Result := fValidaSituacaoFinanceiraPedido(cdsConsulta.FieldByName('FGO_NUMDOC').AsString,
                                            cdsConsulta.FieldByName('FGO_ESPDOC').AsString,
                                            cdsConsulta.FieldByName('FGO_CODEMP').AsString,
                                            strPenFin);
end;

function TfrmPnlDadosPedOrc.fTemProfissionais(strNumDoc, strEspDoc, strCodEmp,
  strCodCli: String): Boolean;
var
  frmListaProfissionaisPD: TfrmListaProfissionaisPD;
  qryProfissional: TUniQuery;
begin
  qryProfissional := fCriaQuery;

  try
    Result := False;

    qryProfissional.Close;
    qryProfissional.SQL.Clear;

    If (fCfgSis('NROPRO') = '2') Then
    Begin
      qryProfissional.SQL.Add('SELECT D.DIV_CODDIV, D.DIV_NOMDIV');
      qryProfissional.SQL.Add('FROM CADDIV D');
      qryProfissional.SQL.Add('INNER JOIN FATDOR F');
      qryProfissional.SQL.Add('ON(D.DIV_CODDIV = F.FDO_CODDIV)');
      qryProfissional.SQL.Add('WHERE F.FDO_NUMDOC = :NUMDOC');
      qryProfissional.SQL.Add('AND F.FDO_ESPDOC = :ESPDOC');
      qryProfissional.SQL.Add('AND F.FDO_CODEMP = :CODEMP');
      qryProfissional.SQL.Add('AND F.FDO_CODCLI = :CODCLI');
      qryProfissional.SQL.Add('GROUP BY  D.DIV_CODDIV, D.DIV_NOMDIV');
    End
    Else If (fCfgSis('NROPRO') = '3') Then
    Begin
      qryProfissional.SQL.Add('SELECT ');
      qryProfissional.SQL.Add('  DISTINCT D.DIV_CODDIV, C.DIV_NOMDIV ');
      qryProfissional.SQL.Add('FROM ');
      qryProfissional.SQL.Add('  DIVFAT D INNER JOIN FATGOR G ON D.DIV_SEQGER = G.AUTOINCREM ');
      qryProfissional.SQL.Add('           INNER JOIN CADDIV C ON D.DIV_CODDIV = C.DIV_CODDIV ');
      qryProfissional.SQL.Add('WHERE ');
      qryProfissional.SQL.Add('  G.FGO_NUMDOC = :NUMDOC AND ');
      qryProfissional.SQL.Add('  G.FGO_ESPDOC = :ESPDOC AND ');
      qryProfissional.SQL.Add('  G.FGO_CODEMP = :CODEMP AND ');
      qryProfissional.SQL.Add('  G.FGO_CODCLI = :CODCLI     ');
      qryProfissional.SQL.Add('ORDER BY ');
      qryProfissional.SQL.Add('  C.DIV_NOMDIV ');
    End;

    qryProfissional.ParamByName('NUMDOC').AsString := strNumDoc;
    qryProfissional.ParamByName('ESPDOC').AsString := strEspDoc;
    qryProfissional.ParamByName('CODEMP').AsString := strCodEmp;
    qryProfissional.ParamByName('CODCLI').AsString := strCodCli;

    qryProfissional.Open;

    if qryProfissional.IsEmpty then
      Exit;

    pCriarFormularios(TfrmListaProfissionaisPD, frmListaProfissionaisPD);

    try
      frmListaProfissionaisPD.Caption := 'Profissionais cadastrados no ' + fTipoDoc(strEspDoc) + ' ' + strNumDoc;

      while not qryProfissional.Eof do
      begin
        frmListaProfissionaisPD.cdsProfi.Append;
        frmListaProfissionaisPD.cdsProfiCODIGO.AsString := qryProfissional.FieldByName('DIV_CODDIV').AsString;
        frmListaProfissionaisPD.cdsProfiPROFIS.AsString := qryProfissional.FieldByName('DIV_NOMDIV').AsString;
        frmListaProfissionaisPD.cdsProfi.Post;
        qryProfissional.Next;
      end;

      frmListaProfissionaisPD.cdsProfi.First;
      frmListaProfissionaisPD.ShowModal;
      Result := True;
    finally
      pFreeAndNil(frmListaProfissionaisPD);
    end;
  finally
    FreeAndNil(qryProfissional);
  end;
end;

function TfrmPnlDadosPedOrc.fTipoDoc(strEspDoc: String): String;
begin
  Result := IIF(strEspDoc = 'PD', 'Pedido', 'Orçamento');
end;

function TfrmPnlDadosPedOrc.fLocalizaPosicaoListaSelecaoNoCdsConsulta(index: integer): Boolean;
Begin
  Result := cdsConsulta.Locate('AUTOINCREM', fItemLista(index), []);
End;

function TfrmPnlDadosPedOrc.fFormaDePagamentoPermiteUsuarioInativo: Boolean;
  var
    LstrFormaPagamento : String;
begin
  LstrFormaPagamento := fCampoTabela('FGO_CODFPG', 'FATGOR', ['AUTOINCREM'], [cdsConsulta.FieldByName('AUTOINCREM').AsString]);

  Result := (fCfgSis('INVNDC', varBoolean)) and ((LstrFormaPagamento = '001') or (LstrFormaPagamento = '007'));
end;

function TfrmPnlDadosPedOrc.fItemLista(index: integer): string;
Begin
  Result := '';
  If index < objPanel.stlListaSelecao.Count Then
    Result := objPanel.stlListaSelecao[index]
End;


procedure TfrmPnlDadosPedOrc.OnAfterListaSelecaoRemove(strValue: String);
begin
  if objPanel.stlListaSelecao.Count = 0 then
    strClienteSelecionado := '';
end;

procedure TfrmPnlDadosPedOrc.OnBeforeListaSelecaoAdd(strValue: String; var blnAdd: boolean);
begin
  If fEmptyStr(strClienteSelecionado) Then
    strClienteSelecionado := cdsConsulta.FieldByName('FGO_CODCLI').AsString
  Else If Not SameText(strClienteSelecionado, cdsConsulta.FieldByName('FGO_CODCLI').AsString) Then
  Begin
    blnAdd := False;
    fMensagem('Aviso', 'Para executar este processo é preciso selecionar documentos que pertencem do mesmo cliente.', ['&OK']);
  End;
end;

procedure TfrmPnlDadosPedOrc.btnCobrancaYapayClick(Sender: TObject);
var
  strLinkPagamento: string;
begin
  If fVariosDocumentosSelecionados Then
  Begin
    fMensagem('ATENÇÃO!', 'Apenas um documento pode estar selecionado para executar essa operação!', ['&Ok']);
    Exit;
  End;

  If (Not btnCobrancaYapay.Visible) Then
    Exit;

  If (cdsConsulta.IsEmpty) Then
    Exit;

  If TYapayFacade.fPedidoPossuiCobrancaAtiva(cdsConsulta.FieldByName('AUTOINCREM').AsString) Then
  begin
    strLinkPagamento := TYapayFacade.fLinkPagamento(cdsConsulta.fieldbyname('AUTOINCREM').AsString);

    if not fEmptyStr(strLinkPagamento) then
      pBrowserNavigate(PChar(strLinkPagamento))
    else
      fMensagem('ATENÇÃO!', 'O envio da cobrança ao cliente ainda não foi realizado. '+
                            'Este processo é automático, com ciclo a cada 1 minuto. Tente novamente mais tarde!', ['&Ok']);

  end;

end;

procedure TfrmPnlDadosPedOrc.pMostraItensPendentes;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);

  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  FDO_CODITE AS PCD_CODITE, ');
  qryAux.SQL.Add('  FDO_DESCRI AS PCD_DESITE, ');
  qryAux.SQL.Add('  UNI_SIGUNI AS UNI_SIGUNI, ');
  qryAux.SQL.Add('  CAST("" AS CHAR(1)) AS DOCENT, ');
  qryAux.SQL.Add('  FORMAT(FDO_QTDITE, ' + fCfgSis('DEQTPC') + ')  AS PCD_QTDITE, ');
  qryAux.SQL.Add('  FORMAT(FDO_QTDBAI, ' + fCfgSis('DEQTPC') + ')  AS PCD_QTDBAI, ');
  qryAux.SQL.Add('  FORMAT(IF(FDO_QTDBAI > FDO_QTDITE, 0, FDO_QTDITE - FDO_QTDBAI), 2) AS PCD_QTDRES, ');

  qryAux.SQL.Add('  FDO_QTDBAI  AS PCD_QTDBAI_NO_FORMAT, ');
  qryAux.SQL.Add('  IF(FDO_QTDBAI > FDO_QTDITE, 0, FDO_QTDITE - FDO_QTDBAI) AS PCD_QTDRES_NO_FORMAT, ');

  qryAux.SQL.Add('  CONCAT(FDO_CODMAR,"-", MAR_DESMAR) AS MAR_DESMAR,  ');
  If fCfgSis('TABPRF', VarBoolean) Then
    qryAux.SQL.Add(' IF(F.ITE_CODITE IS NULL, C.ITE_CODFAB, F.ITE_CODFAB) AS ITE_CODFAB ')
  Else
    qryAux.SQL.Add(' CAST(IFNULL((SELECT GROUP_CONCAT(DISTINCT F.ITE_CODITF ORDER BY F.ITE_CODITF SEPARATOR ", ") FROM ITEFOR F WHERE F.ITE_CODITE = C.ITE_CODITE AND F.ITE_CODFOR = C.ITE_CODFOR AND IFNULL(F.ITE_CODITF, "") <> ""), C.ITE_CODFAB) AS CHAR(50)) AS ITE_CODFAB ');

  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  FATDOR ');
  qryAux.SQL.Add('  JOIN CADITE C ON C.ITE_CODITE = FDO_CODITE ');
  qryAux.SQL.Add('  JOIN CADUNI ON UNI_CODUNI = C.ITE_CODUNI ');
  qryAux.SQL.Add('  LEFT JOIN CADMAR ON MAR_CODMAR = FDO_CODMAR ');

  If fCfgSis('TABPRF', VarBoolean) Then
  Begin
    qryAux.SQL.Add('  LEFT JOIN ITEFOR F ON F.ITE_CODITE = C.ITE_CODITE AND ');
    qryAux.SQL.Add('                        F.ITE_CODFOR = C.ITE_CODFOR AND ');
    qryAux.SQL.Add('                        (SELECT COUNT(*) FROM TABPRE      ');
    qryAux.SQL.Add('                         WHERE F.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S") > 0 ');
  End;

  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  FDO_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  FDO_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  FDO_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  IF(FDO_QTDBAI > FDO_QTDITE, 0, FDO_QTDITE - FDO_QTDBAI) > 0 ');
  qryAux.SQL.Add('ORDER BY ');
  qryAux.SQL.Add('  FDO_DESCRI ');

  qryAux.ParamByName('NUMDOC').AsString := cdsConsulta.FieldByName('FGO_NUMDOC').AsString;
  qryAux.ParamByName('ESPDOC').AsString := cdsConsulta.FieldByName('FGO_ESPDOC').AsString;
  qryAux.ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('FGO_CODEMP').AsString;

  qryAux.Open;

  Try
    pCriarFormularios(TfrmMostraItensPendentes, frmMostraItensPendentes);
    frmMostraItensPendentes.dtsPedido.DataSet := qryAux;
    frmMostraItensPendentes.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[]');
  End;

  pFreeAndNil(frmMostraItensPendentes);
  qryAux.Close;
  FreeAndNil(qryAux);
end;

end.
