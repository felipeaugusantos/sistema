unit untPnlDadosPedCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, UniClientDataSet, Uni, StrUtils,
  untFuncoesSimples, frxClass, untFuncoesGenerica, MemoFocus, BitBtnLockedIncrem,
  Mask, DBCtrls, DBEditFocus, untGeraExcel, ComCtrls, untZClient, cxProgressBar,
  ComObj, untClassPanelCx, untTLock, untRequisicaoPedidoCompra,
  untTypesSistema, untEditorFastImpressao, untDigEmailPedidoCompra,
  untOpcPdfPedidoCompra, untTLayoutPedidoCompra, untCfgRel, TypesLayoutPedidoCompra;

type
  TGerarXLSBROffice = function  (pgbProgresso: TcxProgressBar): Boolean of object;

  TfrmPnlDadosPedCompra = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    shpRed: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    chkAplPro: TCheckBox;
    btnGerarPDF: TBitBtnLocked;
    btnEnviarEmail: TBitBtnLocked;
    btnBaixaPedido: TBitBtnLocked;
    btnItensPend: TBitBtnLocked;
    btnGerarXLS: TBitBtnLocked;
    pnlDados: TPanel;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DBEditFocus1: TDBEditFocus;
    DBEditFocus2: TDBEditFocus;
    DBEditFocus3: TDBEditFocus;
    DBEditFocus4: TDBEditFocus;
    DBEditFocus5: TDBEditFocus;
    dtsPedidos: TDataSource;
    btnConPedCmp: TBitBtnLocked;
    btnExportacao: TBitBtnLocked;
    Shape1: TShape;
    Label9: TLabel;
    btnNovaDataEntrega: TBitBtnLocked;
    btnLogDataAlterada: TBitBtnLocked;
    btnDesBaixaPed: TBitBtnLocked;
    btnNovaDataFaturamento: TBitBtnLocked;
    btnLogDataFaturamento: TBitBtnLocked;
    shpPreNota: TShape;
    lblPreNota: TLabel;
    dbeObservacoes: TDBMemo;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGerarPDFClick(Sender: TObject);
    procedure btnEnviarEmailClick(Sender: TObject);
    procedure btnBaixaPedidoClick(Sender: TObject);
    procedure btnItensPendClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGerarXLSClick(Sender: TObject);
    procedure btnConPedCmpClick(Sender: TObject);
    procedure btnExportacaoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNovaDataEntregaClick(Sender: TObject);
    procedure btnLogDataAlteradaClick(Sender: TObject);
    procedure btnDesBaixaPedClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnNovaDataFaturamentoClick(Sender: TObject);
    procedure btnLogDataFaturamentoClick(Sender: TObject);
  private
    { Private declarations }
    cdsItensGiro      : TUniClientDataSet;
    FPais: TPais;
    strPedidosNaoLiberados: String;

    blnDarRor: Boolean;


    objLock: TLock;

    opcRequisicao: TOpcRequisicao;
    intMotivoReq: Integer;
    strMotivoReq: String;

    procedure pEnviaEmail(blnEnviaEmail : Boolean = True;
      enuTipoExportacao: TTipoExportacao = teEmail);
    procedure pGravarLogEmail(strEmailDest, strDestinatario: String);
    procedure pBaixaPedidoCompraNaoEntregues;

    Function fTravaPedidos: Boolean;

    function fTestaPdf: Boolean;
    function fGerarXLSBROffice(pgbProgresso: TcxProgressBar): Boolean;
    
    Function fGeraExcel(pgbProgresso: TcxProgressBar): Boolean;

    function fValidaQtdRegistroGrid: boolean;
    function fRetListaSelecaoInstrucaoSQL_IN: string;
    function fSelecionadosPertencemAoMesmoFornecedor: boolean;
    function fVariosDocumentosSelecionados: boolean;
    function fLocalizaPosicaoListaSelecaoNoCdsConsulta(index: integer): Boolean;
    function fAutoincremLista(index: integer): string;
    function fGerarPDF(blnVisualizar: Boolean; AForcePathPDF: String = ''): String;
    procedure pCarregarGiro(strAutoIncrem: String);
    function fTrataObservacoes(intQtdeCar : Integer; strObservacoes : String): String;

  protected
    class function fRetornaSQLCodigoFabricaProduto(const strTipFab: String): String;
    class function fRetornaSQLAplicacaoCodigoFabricaProduto(const strTipFab: String): String;
    class function fGetSqlPesoLitroKilo(blnMltCom: Boolean; tipQtdIte: TTipoQtdItePedido; strCampo: String; strTipUni: String; strNomeCampo: String): String;


  public
    { Public declarations }
    strNumPedidos: string;
    blnExcRes: Boolean;
    FblnShowOnTerminate: Boolean;
    blnAbriArquivoExcelAoFinalizar: Boolean;
    blnShowmessage: Boolean;
//    blnImpPedCompra : Boolean;
    cdsConsulta     : TUniClientDataSet;
    blnPreNota      : Boolean;
    intMinimoDigitos: Integer;
    strEspecie      : String;
    strNomeArquivo  : String;
    strNomeArquivos : String;
    objPanel        : TPanelCX;

    strCondPagBosh: string;
    strPath: String;
    strTipImp,
    strNomeFila: string;

    class procedure pEnviaPedidoEmail(strCodFor, strNumPed, strEspDoc, strCodEmpresa : String);
    class procedure pImprimirPedidoLayout(strCodFor, strNumPed, strEspDoc, strCodEmpresa : String);
    function fRetornaEmpresaDestino(strNumPed, strEspDoc, strCodEmp: String): String;
    Procedure pGeraExcel;

  end;


  TGeraEmail = class
     Class function fGeraEmail(RecOpcaoImpressao: TRecOpcaoImpressao;
                               strNumPed,
                               strEspDoc,
                               strEmpDes: String;
                               strCodEmp: String;
                               blnDarRor: Boolean;
                               out strNomeArquivo: String;
                               blnAplPro: Boolean;
                               fGerarXLSBROffice: TGerarXLSBROffice = nil;
                               strNomImp: String = '';
                               strTipImp: string = '';
                               blnEnvioAutomatico: Boolean = False): String;
  End;

  TfrmPnlDadosPedCompraClass = Class Of TfrmPnlDadosPedCompra;

var
  frmPnlDadosPedCompra: TfrmPnlDadosPedCompra;

implementation

uses untExcel, untQckHTMLPedidoCompra, untmodulo,
  untConstantes, untValorPorExtenso,  untPesqAux,
  untDigOcorrencia, untGravando,
  untTEnvioEmail, untFuncoesPedidoSimples, untPedidoCompraLiberacao,
  untMensagemExplicativa, untTFatReservaSaldo,
  untFuncoesRel, untFuncoesRel2, untTLogAlteracaoDataPedCompra,
  untOpcaoBaixaRequisicao, untDigDesfazerBaixaPedNaoEntregues,
  untTLogAlteracaoDataFatPedCompra;

{$R *.dfm}


Function TfrmPnlDadosPedCompra.fTravaPedidos: Boolean;
  Var
    intContador: Integer;
    strNotas: String;
Begin
  Result := True;

  If fVariosDocumentosSelecionados Then
  Begin

    For intContador := 0 To objPanel.stlListaSelecao.Count -1 Do
    If cdsConsulta.Locate('AUTOINCREM', objPanel.stlListaSelecao[intContador], []) Then
    Begin

      If Not fTravaDestravaPedidoCompra(True,
               cdsConsulta.FieldByName('PCG_NUMPED').AsString,
               cdsConsulta.FieldByName('PCG_ESPDOC').AsString,
               cdsConsulta.FieldByName('PCG_CODEMP').AsString) Then
      Begin
        Result := False;
        Exit;
      End;

      objLock.pAdicionaTrava(fChaveTravaPedido(cdsConsulta.FieldByName('PCG_NUMPED').AsString,
                                               cdsConsulta.FieldByName('PCG_ESPDOC').AsString,
                                               cdsConsulta.FieldByName('PCG_CODEMP').AsString));

      If Not TRequisicaoPedidoCompra.fTravaRequisicoes(cdsConsulta.FieldByName('AUTOINCREM').AsString, objLock) Then
      Begin
        Result := False;
        Exit;
      End;

     If SameText(cdsConsulta.FieldByName('PCG_ESPDOC').AsString, 'PD') And
        fTemPreNotaPedido(cdsConsulta.FieldByName('PCG_NUMPED').AsString,
                          cdsConsulta.FieldByName('PCG_CODEMP').AsString, strNotas) Then
     Begin
       pMensagemOk('O pedido ' + cdsConsulta.FieldByName('PCG_NUMPED').AsString + ' - ' +
                                 cdsConsulta.FieldByName('PCG_CODEMP').AsString +
                   ' já está associado à(s) pré-nota(s) '+ strNotas + ' e' + #13#10 +
                   'somente poderá ser alterado após a entrada de mercadorias (se parcial) ou' + #13#10 +
                   'cancelamento da(s) pré-nota(s).');

       Result := False;
       Exit;
     End;

    End;

  End Else
  Begin

    If SameText(cdsConsulta.FieldByName('PCG_ESPDOC').AsString, 'PD') And
       fTemPreNotaPedido(cdsConsulta.FieldByName('PCG_NUMPED').AsString,
                         cdsConsulta.FieldByName('PCG_CODEMP').AsString, strNotas) Then
    Begin
      pMensagemOk('O pedido ' + cdsConsulta.FieldByName('PCG_NUMPED').AsString + ' - ' +
                                cdsConsulta.FieldByName('PCG_CODEMP').AsString +
                  ' já está associado à(s) pré-nota(s) '+ strNotas + ' e' + #13#10 +
                  'somente poderá ser alterado após a entrada de mercadorias (se parcial) ou' + #13#10 +
                  'cancelamento da(s) pré-nota(s).');

      Result := False;
      Exit;
    End;

    Result := fTravaDestravaPedidoCompra(True,
               cdsConsulta.FieldByName('PCG_NUMPED').AsString,
               cdsConsulta.FieldByName('PCG_ESPDOC').AsString,
               cdsConsulta.FieldByName('PCG_CODEMP').AsString);

    If Result Then
    Begin
      objLock.pAdicionaTrava(fChaveTravaPedido(cdsConsulta.FieldByName('PCG_NUMPED').AsString,
                                               cdsConsulta.FieldByName('PCG_ESPDOC').AsString,
                                               cdsConsulta.FieldByName('PCG_CODEMP').AsString));

      Result := TRequisicaoPedidoCompra.fTravaRequisicoes(cdsConsulta.FieldByName('AUTOINCREM').AsString, objLock);
    End;
  End;

End;

procedure TfrmPnlDadosPedCompra.btnLogDataFaturamentoClick(Sender: TObject);
 var objLogAlteracaoDataFatPedCompra : TLogAlteracaoDataFatPedCompra;
begin
  If cdsConsulta.IsEmpty Then
    Exit;
  objLogAlteracaoDataFatPedCompra := TLogAlteracaoDataFatPedCompra.Create();
  Try
    objLogAlteracaoDataFatPedCompra.pShowHistoricoLog(cdsConsulta.FieldByName('AUTOINCREM').AsString, True);
  Finally
    FreeAndNil(objLogAlteracaoDataFatPedCompra);
  End;
end;


procedure TfrmPnlDadosPedCompra.btnBaixaPedidoClick(Sender: TObject);
begin
  opcRequisicao := opcSemRequisicao;

  If Not Assigned(objLock) Then
    objLock := TLock.Create;

  If fVerificaAcessoSistema('BAXPED') Then
  Begin

    If Not cdsConsulta.IsEmpty Then
    Begin

      If fTravaPedidos And
         fValidaSeDocumentoPodeSerBaixado(cdsConsulta.FieldByName('PCG_NUMPED').AsString,
                                          cdsConsulta.FieldByName('PCG_ESPDOC').AsString,
                                          cdsConsulta.FieldByName('PCG_CODEMP').AsString,
                                          cdsConsulta.FieldByName('AUTOINCREM').AsString,
                                          opcRequisicao,
                                          intMotivoReq,
                                          strMotivoReq,
                                          objPanel.stlListaSelecao) Then
      Begin



        pBaixaPedidoCompraNaoEntregues;

        cdsConsulta.DisableControls;
        cdsConsulta.Refresh;

        objPanel.stlListaSelecao.Clear;
        cdsConsulta.EnableControls;
      End;

      objLock.pDestravarTodos;
    End;

  End
  Else
    fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso!', ['&Ok']);
end;

procedure TfrmPnlDadosPedCompra.btnConPedCmpClick(Sender: TObject);
  Var
    frmPedidoCompraLiberacao: TfrmPedidoCompraLiberacao;
begin
  If (btnConPedCmp.Visible) Then
  Begin
    pCriarFormularios(TfrmPedidoCompraLiberacao, frmPedidoCompraLiberacao);
    Try
      frmPedidoCompraLiberacao.ShowModalConsultaPedidoCompra;
    Finally
      pFreeAndNil(frmPedidoCompraLiberacao);
    End;
  End;
end;

procedure TfrmPnlDadosPedCompra.btnDesBaixaPedClick(Sender: TObject);
begin
  Try
    cdsConsulta.DisableControls;

    If btnDesBaixaPed.Enabled Then
    Begin
      pCriarFormularios(TfrmDigDesfazerBaixaPedNaoEntregues, frmDigDesfazerBaixaPedNaoEntregues);
      frmDigDesfazerBaixaPedNaoEntregues.ShowModal;
    End;

    cdsConsulta.Refresh;
    If assigned(objPanel) Then
      objPanel.stlListaSelecao.Clear;
  Finally
    cdsConsulta.EnableControls;

  End;
end;

procedure TfrmPnlDadosPedCompra.btnEnviarEmailClick(Sender: TObject);
var intIndex: integer;
  procedure pExecuta(blnEnviaEmail: boolean = True);
  Begin
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodFor:= cdsConsulta.FieldByName('PCG_CODFOR').AsString;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNumPed:= cdsConsulta.FieldByName('PCG_NUMPED').AsString;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc:= cdsConsulta.FieldByName('PCG_ESPDOC').AsString;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp:= cdsConsulta.FieldByName('PCG_CODEMP').AsString;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEmpDes:= IIf(fEmptyStr(cdsConsulta.FieldByName('PCGEMPDES').AsString),
                       cdsConsulta.FieldByName('PCG_CODEMP').AsString,
                       cdsConsulta.FieldByName('PCGEMPDES').AsString);
    pEnviaEmail(blnEnviaEmail);
  End;


begin
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEmail := '';
  If Not fValidaQtdRegistroGrid Then
    Exit;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.Origem := opioEmail;
  If Not fSelecionadosPertencemAoMesmoFornecedor Then
    Exit;
  blnShowmessage := True;
  strNomeArquivos := '';
  strNumPedidos := '';
  blnAbriArquivoExcelAoFinalizar := False;

  If fVariosDocumentosSelecionados Then
  Begin
    For intIndex := 0 To objPanel.stlListaSelecao.Count -1 do
    Begin
      If fLocalizaPosicaoListaSelecaoNoCdsConsulta(intIndex) Then
        pExecuta(intIndex = (objPanel.stlListaSelecao.Count -1));
      blnShowmessage := False;
    End;
  End
  Else
    pExecuta;

end;

procedure TfrmPnlDadosPedCompra.btnGerarPDFClick(Sender: TObject);
  Var
    strArqHtml: String;
    strPasta: string;
    intIndex : Integer;

  procedure pExecuta(blnExibirMensagem: boolean = True);
  Begin
    If (Not blnExibirMensagem) And {Vários Pedidos selecionados}
       (cdsConsulta.FieldByName('PCG_ESPDOC').AsString = 'PD') And
       (fCfgSis('LIBPCM', varBoolean)) And
       (Not fCfgSis('LIBIMP', varBoolean)) And
       (Not fPedidoCompraLiberado(cdsConsulta.FieldByName('PCG_NUMPED').AsString,
                                  cdsConsulta.FieldByName('PCG_CODEMP').AsString)) And
       (fVerificaAcessoSistema('EMAILPED')) Then
    Begin
      strPedidosNaoLiberados := cdsConsulta.FieldByName('PCG_NUMPED').AsString + ', ';
      Exit;
    End;

    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNumPed := cdsConsulta.FieldByName('PCG_NUMPED').AsString;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc := cdsConsulta.FieldByName('PCG_ESPDOC').AsString;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp := cdsConsulta.FieldByName('PCG_CODEMP').AsString;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodFor := cdsConsulta.FieldByName('PCG_CODFOR').AsString;

    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnResumoMarca := False;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnResumoReferencia := False;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnResumoGrupo := False;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnResumoUnidade := False;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnResumoAcordoObjetivo := False;

    If (blnExibirMensagem) And (Not fTestaPdf) Then
     Exit;

    If blnShowmessage Then
    Begin
      pCriarFormularios(TfrmDigEmailPedidoCompra, frmDigEmailPedidoCompra);
      TfraOpcPdfPedidoCompra.RecOpcaoImpressao.Origem := opioPdf;
      frmDigEmailPedidoCompra.fraOpcPdfPedidoCompra.pSetAjustaTela(totPdLayout);
      Try
        frmDigEmailPedidoCompra.Caption := 'Geração de Pedido de Compra em PDF';
        frmDigEmailPedidoCompra.fraOpcPdfPedidoCompra.pnlEmail.Visible := False;
        frmDigEmailPedidoCompra.fraOpcPdfPedidoCompra.gbExporta.Visible := False;
        frmDigEmailPedidoCompra.fraOpcPdfPedidoCompra.blnSomentePDF := True;

        If frmDigEmailPedidoCompra.ShowModal = mrOk Then
        Begin
          TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strTipExp:= 'PDF';
        End
        Else
          Exit;
      Finally
        FreeAndNil(frmDigEmailPedidoCompra);
      End;
    End;


    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEmpDes:= cdsConsulta.FieldByName('PCGEMPDES').AsString;

    If Not fEmptyStr(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodLay) Then
    Begin
      strPasta := IIf(cdsConsulta.FieldByName('PCG_ESPDOC').AsString = 'OR' , 'OrcamentoCompra', 'PedidoCompra');
      If Not DirectoryExists(ExtractFilePath(Application.ExeName) + strPasta) Then
        CreateDir(ExtractFilePath(Application.ExeName) + strPasta);

      strArqHtml := fGerarPDF(false, strPasta)
    End
    Else
      strArqHtml := TGeraEmail.fGeraEmail(TfraOpcPdfPedidoCompra.RecOpcaoImpressao,
                                          cdsConsulta.FieldByName('PCG_NUMPED').AsString,
                               cdsConsulta.FieldByName('PCG_ESPDOC').AsString,
                               cdsConsulta.FieldByName('PCGEMPDES').AsString,
                               TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp,
                               blnDarRor,
                               strNomeArquivo,
                               chkAplPro.Checked,
                               fGerarXLSBROffice);

    If Not fEmptyStr(strArqHtml) Then
    Begin
      If blnExibirMensagem Then
        fMensagem('','Arquivo ' + strArqHtml + ' gerado com sucesso!', ['&Ok']);
      pExecArquivo(strArqHtml, Handle);
    End;
  End;

begin
  inherited;
  strPedidosNaoLiberados := '';
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.Origem := opioPdf;

  blnShowmessage := True;

  strArqHtml := '';

  If Not fValidaQtdRegistroGrid Then
    Exit;

  If Not fSelecionadosPertencemAoMesmoFornecedor Then
    Exit;


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
  If Not fEmptyStr(strPedidosNaoLiberados) Then
    fMensagem('Atenção!', 'Os Pedidos de compra não estão liberados, por isso não serão impressos.' + Copy(strPedidosNaoLiberados, 1,(Length(strPedidosNaoLiberados) -2)), ['&OK']);

end;

procedure TfrmPnlDadosPedCompra.btnGerarXLSClick(Sender: TObject);
var  intIndex: Integer;
  procedure pExecuta(blnExibirMensagem: boolean = True);
  Begin
    If (Not blnExibirMensagem) And {Vários Pedidos selecionados}
       (cdsConsulta.FieldByName('PCG_ESPDOC').AsString = 'PD') And
       (fCfgSis('LIBPCM', varBoolean)) And
       (Not fCfgSis('LIBIMP', varBoolean)) And
       (Not fPedidoCompraLiberado(cdsConsulta.FieldByName('PCG_NUMPED').AsString,
                                  cdsConsulta.FieldByName('PCG_CODEMP').AsString)) And
       (fVerificaAcessoSistema('EMAILPED')) Then
    Begin
      strPedidosNaoLiberados := cdsConsulta.FieldByName('PCG_NUMPED').AsString;
      Exit;
    End;

    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNumPed := cdsConsulta.FieldByName('PCG_NUMPED').AsString;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc := cdsConsulta.FieldByName('PCG_ESPDOC').AsString;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp := cdsConsulta.FieldByName('PCG_CODEMP').AsString;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodFor := cdsConsulta.FieldByName('PCG_CODFOR').AsString;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEmpDes := cdsConsulta.FieldByName('PCGEMPDES').AsString;

    If (blnExibirMensagem) And (Not fTestaPdf) Then
      Exit;

    pCarregarGiro(cdsConsulta.FieldByName('AUTOINCREM').AsString);
    pGeraExcel;

  End;
begin
  strPedidosNaoLiberados := '';

  blnShowmessage := True;
  blnAbriArquivoExcelAoFinalizar := True;

  If Not fValidaQtdRegistroGrid Then
    Exit;

  If Not fSelecionadosPertencemAoMesmoFornecedor Then
    Exit;

  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.tipQtdIte := tqpCompleto;
  pCriarFormularios(TfrmDigEmailPedidoCompra, frmDigEmailPedidoCompra);
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.tipQtdIte := tqpCompleto;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.Origem  := opioXls;
  frmDigEmailPedidoCompra.fraOpcPdfPedidoCompra.pSetAjustaTela(totExcel);

  Try
//    frmDigEmailPedidoCompra.pSetaTelaParaGeracao(teExcel);
    frmDigEmailPedidoCompra.Width  := 240;
    frmDigEmailPedidoCompra.Height := 170;

    If Not (frmDigEmailPedidoCompra.ShowModal = mrOk) Then
      Exit;

  Finally
    FreeAndNil(frmDigEmailPedidoCompra);
  End;

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

  If Not fEmptyStr(strPedidosNaoLiberados) Then
    fMensagem('Atenção!', 'Os Pedidos de compra não estão liberados, por isso não serão impressos.' + Copy(strPedidosNaoLiberados, 1,(Length(strPedidosNaoLiberados) -2)), ['&OK']);
end;

procedure TfrmPnlDadosPedCompra.btnItensPendClick(Sender: TObject);
begin
  If Not fValidaQtdRegistroGrid Then
    Exit;

  If fVariosDocumentosSelecionados Then
  Begin
    fMensagem('Mais de um registro selecionado!', 'Selecione apenas um registro para mostrar itens pendentes!', ['&OK']);
    Exit;
  End;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(421, 20567, [],
                        ['NUMDOC','ESPDOC','CODEMP'],
                        [cdsConsulta.FieldByName('PCG_NUMPED').AsString,
                        cdsConsulta.FieldByName('PCG_ESPDOC').AsString,
                        cdsConsulta.FieldByName('PCG_CODEMP').AsString],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmPnlDadosPedCompra.btnLogDataAlteradaClick(Sender: TObject);
  var objLogAlteracaoDataPedCompra : TLogAlteracaoDataPedCompra;
begin
  If cdsConsulta.IsEmpty Then
    Exit;
  objLogAlteracaoDataPedCompra := TLogAlteracaoDataPedCompra.Create();
  Try
    objLogAlteracaoDataPedCompra.pShowHistoricoLog(cdsConsulta.FieldByName('AUTOINCREM').AsString, True);
  Finally
    FreeAndNil(objLogAlteracaoDataPedCompra);
  End;
end;

procedure TfrmPnlDadosPedCompra.btnNovaDataEntregaClick(Sender: TObject);
  var objLogAlteracaoDataPedCompra : TLogAlteracaoDataPedCompra;
begin
  If cdsConsulta.IsEmpty Then
    Exit;
  objLogAlteracaoDataPedCompra := TLogAlteracaoDataPedCompra.Create();
  objLogAlteracaoDataPedCompra.pSetTituloTela(cdsConsulta.FieldByName('PCG_NUMPED').AsString + ' - ' + cdsConsulta.FieldByName('PCG_CODEMP').AsString,
                                              cdsConsulta.FieldByName('PCG_CODFOR').AsString + ' - ' + cdsConsulta.FieldByName('FOR_NOMFOR').AsString);

  Try
    If objLogAlteracaoDataPedCompra.fPede_e_AlteraData(strLoginUsuarioLogado,
                                                       cdsConsulta.FieldByName('PCG_CODEMP').AsString,
                                                       cdsConsulta.FieldByName('PCG_NUMPED').AsString,
                                                       cdsConsulta.FieldByName('PCG_ESPDOC').AsString,
                                                       cdsConsulta.FieldByName('PCG_NUMCTN').AsInteger,
                                                       cdsConsulta.FieldByName('PCG_NUMCTN').AsInteger,
                                                       cdsConsulta.FieldByName('PCG_DTAENT').AsDateTime,
                                                       cdsConsulta.FieldByName('PCG_DTAFAT').AsDateTime,
                                                       cdsConsulta.FieldByName('AUTOINCREM').AsString) Then
     pMensagemOk('Data alterada com sucesso!');
     cdsConsulta.Refresh;
  Finally
    FreeAndNil(objLogAlteracaoDataPedCompra);
  End;
end;

procedure TfrmPnlDadosPedCompra.btnNovaDataFaturamentoClick(Sender: TObject);
  var objLogAlteracaoDataFatPedCompra : TLogAlteracaoDataFatPedCompra;
begin
  If cdsConsulta.IsEmpty Then
    Exit;
  objLogAlteracaoDataFatPedCompra := TLogAlteracaoDataFatPedCompra.Create();
  objLogAlteracaoDataFatPedCompra.pSetTituloTela(cdsConsulta.FieldByName('PCG_NUMPED').AsString + ' - ' + cdsConsulta.FieldByName('PCG_CODEMP').AsString,
                                              cdsConsulta.FieldByName('PCG_CODFOR').AsString + ' - ' + cdsConsulta.FieldByName('FOR_NOMFOR').AsString);

  Try
    If objLogAlteracaoDataFatPedCompra.fPede_e_AlteraData(strLoginUsuarioLogado,
                                                       cdsConsulta.FieldByName('PCG_CODEMP').AsString,
                                                       cdsConsulta.FieldByName('PCG_NUMPED').AsString,
                                                       cdsConsulta.FieldByName('PCG_ESPDOC').AsString,
                                                       cdsConsulta.FieldByName('PCG_NUMCTN').AsInteger,
                                                       cdsConsulta.FieldByName('PCG_NUMCTN').AsInteger,
                                                       cdsConsulta.FieldByName('PCG_DTAENT').AsDateTime,
                                                       cdsConsulta.FieldByName('PCG_DTAFAT').AsDateTime,
                                                       cdsConsulta.FieldByName('AUTOINCREM').AsString) Then
     pMensagemOk('Data alterada com sucesso!');
     cdsConsulta.Refresh;
  Finally
    FreeAndNil(objLogAlteracaoDataFatPedCompra);
  End;
end;

procedure TfrmPnlDadosPedCompra.btnExportacaoClick(Sender: TObject);
Var
  stlLista: TStringList;
begin
  If Not fSelecionadosPertencemAoMesmoFornecedor Then
    Exit;

  If Assigned(objPanel) And Assigned(objPanel.prcLista) Then
  Begin
    objPanel.FSetFornecedorUnicoExportacao(True);
    If objPanel.stlListaSelecao.Count > 0 Then
    Begin
      objPanel.prcLista(objPanel.stlListaSelecao);
    End Else
    Begin
      stlLista := TStringList.Create;
      stlLista.Add(cdsConsulta.FieldByName('AUTOINCREM').AsString);
      objPanel.prcLista(stlLista);
      FreeAndNil(stlLista);
    End;
  End;
end;

function TfrmPnlDadosPedCompra.fAutoincremLista(index: integer): string;
begin
  Result := '';
  If index < objPanel.stlListaSelecao.Count Then
    Result := objPanel.stlListaSelecao[index]
end;

class function TfrmPnlDadosPedCompra.fGetSqlPesoLitroKilo(blnMltCom: Boolean; tipQtdIte: TTipoQtdItePedido; strCampo, strTipUni,
  strNomeCampo: String): String;
begin
  Result := '';

  Result := Result + '( SELECT SQL_NO_CACHE ';
  Result := Result + '    SUM(IFNULL(' + strCampo + ', 0)) ';
  Result := Result + '  FROM ';
  Result := Result + '    PCMDET ';
  Result := Result + '  JOIN CADITE ON (PCMDET.PCD_CODITE = CADITE.ITE_CODITE ) ';

  If blnMltCom Then
    Result := Result + '  JOIN CADUNI ON (CADITE.ITE_UNICOM = CADUNI.UNI_CODUNI) '
  Else
    Result := Result + '  JOIN CADUNI ON (PCMDET.PCD_CODUNI = CADUNI.UNI_CODUNI) ';

  Result := Result + '  WHERE ';
  Result := Result + '    IFNULL(CADUNI.UNI_KILLIT, "L") = "' + strTipUni + '" AND ';
  Result := Result + '    PCMDET.PCD_NUMCTN = 0 AND ';
  Result := Result + '    PCMDET.PCD_NUMPED = :NUMPED AND ';
  Result := Result + '    PCMDET.PCD_ESPDOC = :ESPDOC AND ';
  Result := Result + '    PCMDET.PCD_CODEMP = :CODEMP ';

  If tipQtdIte = tqpPendente Then
    Result := Result + '  AND ' + strCampo + ' > 0 ';

  Result := Result + ') AS ' + strNomeCampo;
end;

function TfrmPnlDadosPedCompra.fLocalizaPosicaoListaSelecaoNoCdsConsulta(index: integer): boolean;
begin
  Result := cdsConsulta.Locate('AUTOINCREM', fAutoincremLista(index), []);
end;

procedure TfrmPnlDadosPedCompra.FormCreate(Sender: TObject);
begin
  objPanel := Nil;
  FblnShowOnTerminate := False;
  FPais := FSetaPais;
  blnShowmessage  := True;
  strNomeArquivos := '';
//  blnImpPedCompra := False;
  objLock := TLock.Create;

  blnDarRor := fCfgSis('DARROR', varBoolean);
end;

procedure TfrmPnlDadosPedCompra.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objLock);
end;

procedure TfrmPnlDadosPedCompra.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of

    VK_F4:  btnNovaDataEntrega.Click;

    VK_F5:  If ssShift In Shift Then
              btnLogDataAlterada.Click
            Else
              btnExportacao.Click;

    VK_F6:  btnConPedCmp.Click;
    VK_F7:  btnGerarXLS.Click;

    VK_F8:  If ssShift In Shift Then
              btnDesBaixaPed.Click
            Else
              btnGerarPDF.Click;

    VK_F9:  btnEnviarEmail.Click;
    VK_F10: btnBaixaPedido.Click;
    VK_F11: btnItensPend.Click;
    VK_F12: If ssShift In Shift Then
              btnLogDataFaturamento.Click
            Else
              btnNovaDataFaturamento.Click;

  End;

  Case Key Of
    VK_F3,
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

procedure TfrmPnlDadosPedCompra.FormShow(Sender: TObject);
begin
  btnDesBaixaPed.Enabled := fVerificaAcessoSistema('DESBAI');
  blnPreNota := (fCfgSis('USACON', varBoolean)) And (Pos(fCfgSis('CONFME'), '1_3_') > 0);
  shpPreNota.Visible := blnPreNota;
  lblPreNota.Visible := blnPreNota;
end;


function TfrmPnlDadosPedCompra.fRetListaSelecaoInstrucaoSQL_IN: string;
begin
  If objPanel.stlListaSelecao.Count = -1 Then
    Result := ' ';

  Result := fRetStrToSQLIn(objPanel.stlListaSelecao.CommaText, ',')
end;

class function TfrmPnlDadosPedCompra.fRetornaSQLAplicacaoCodigoFabricaProduto(
  const strTipFab: String): String;
begin

  Result := ' CADITE.ITE_CODFAB AS ITE_CODFAB, ';

  Case AnsiIndexStr(UpperCase(strTipFab), ['P', 'F']) Of
      0 : Result := ' CAST(CONCAT(CADITE.ITE_APLICA," / ", CADITE.ITE_CODFAB)AS CHAR(255)) AS ITE_APLFAB, ';
      1 :  Begin
             If fCfgSis('TABPRF', varBoolean) Then
               Result := '  CAST(CONCAT(CADITE.ITE_APLICA," / ", F.ITE_CODFAB)AS CHAR(255)) AS ITE_APLFAB, '
             Else
               Result := '  CAST(CONCAT(CADITE.ITE_APLICA," / ", F.ITE_CODITF)AS CHAR(255)) AS ITE_APLFAB, ';
           End;
  End;
end;

class function TfrmPnlDadosPedCompra.fRetornaSQLCodigoFabricaProduto(const strTipFab: String): String;
begin
  Result := ' CADITE.ITE_CODFAB AS ITE_CODFAB, ';

  Case AnsiIndexStr(UpperCase(strTipFab), ['P', 'F']) Of
      0 : Result := ' CADITE.ITE_CODFAB AS ITE_CODFAB, ';
      1 :  Begin
             If fCfgSis('TABPRF', varBoolean) Then
               Result := '  F.ITE_CODFAB AS ITE_CODFAB, '
             Else
               Result := '  F.ITE_CODITF AS ITE_CODFAB, ';
           End;
  End;
end;

function TfrmPnlDadosPedCompra.fSelecionadosPertencemAoMesmoFornecedor: boolean;
  function fValida: Boolean;
    var qryValida: TUniQuery;
  begin
    Result := True;
    qryValida := fCriaQuery;
    Try

      qryValida.SQL.Add('SELECT COUNT(1) FROM PCMGER');
      qryValida.SQL.Add('WHERE AUTOINCREM IN (' + fRetListaSelecaoInstrucaoSQL_IN + ')');
      qryValida.SQL.Add('GROUP BY PCG_CODFOR');
      qryValida.Open;

      If qryValida.IsEmpty Then
        Exit;

      Result := qryValida.RecordCount = 1
    Finally
     FreeAndNil(qryValida);
    End;

  end;

begin
   Result := True;
   If Not fValidaQtdRegistroGrid Then
     Exit;

  If fVariosDocumentosSelecionados Then
    Result := fValida;

  If Not Result Then
    fMensagem('Aviso', 'Para executar este processo é preciso selecionar documentos que pertencem ao mesmo fornecedor.', ['&OK']);
end;

function TfrmPnlDadosPedCompra.fTestaPdf: Boolean;
begin
  Result := True;

  If (TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc = 'PD') And
     (fCfgSis('LIBPCM', varBoolean)) And
     (Not fCfgSis('LIBIMP', varBoolean)) And
     (Not fPedidoCompraLiberado(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNumPed, VS_strCodEmp)) Then
  Begin
    If fVerificaAcessoSistema('EMAILPED') Then
    Begin
      Result := fPergunta('Esse Pedido ainda não foi liberado (Liberação de Pedidos de Compra). Deseja prosseguir?');
    End Else
    Begin
      fMensagem('ATENÇÃO!', 'Esse Pedido ainda não foi liberado (Liberação de Pedidos de Compra) e o operador não tem direito de acesso para essa tarefa!', ['&Ok']);
      Result := False;
    End;
  End;
end;

function TfrmPnlDadosPedCompra.fValidaQtdRegistroGrid: boolean;
begin
  Result := Not (cdsConsulta.IsEmpty);
  If Not Result Then
    fMensagem('ATENÇÃO!', 'Nenhum Pedido de Compra Selecionado!', ['&Ok']);
end;

function TfrmPnlDadosPedCompra.fVariosDocumentosSelecionados: boolean;
begin
  Result := False;
  If Assigned(objPanel) Then
    Result := objPanel.stlListaSelecao.Count > 1
end;

procedure TfrmPnlDadosPedCompra.pBaixaPedidoCompraNaoEntregues;
  Var
    strMotivo,
    strCodOco,
    strCodEmp,
    strEspDoc: String;
    intContador : Integer;
    blnFalhas: boolean;
begin
  Try
    strMotivo := '';
    pCriarFormularios(TfrmDigOcorrencia, frmDigOcorrencia);

    frmDigOcorrencia.blnInformarHisCom := True;

    frmDigOcorrencia.ShowModal;
    If (frmDigOcorrencia.ModalResult = mrOk) Then
    Begin
      strCodOco := frmDigOcorrencia.strCodOco;
      strMotivo := frmDigOcorrencia.strHisCom;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
  pFreeAndNil(frmDigOcorrencia);

  If fEmptyStr(strCodOco) Then
    Exit;

  strCodEmp := cdsConsulta.FieldByName('PCG_CODEMP').AsString;
  strEspDoc := cdsConsulta.FieldByName('PCG_ESPDOC').AsString;
  blnFalhas := False;

  If fVariosDocumentosSelecionados Then
  Begin
    For intContador := 0 To objPanel.stlListaSelecao.Count -1 Do
    Begin

      If Not fBaixaPedidoNaoEntregue(objPanel.stlListaSelecao.Strings[intContador], strMotivo, strCodOco, True, opcRequisicao,
                                     intMotivoReq, strMotivoReq) Then
        blnFalhas := True;

    End;
    If Not blnFalhas Then
      fMensagem('Informação','Pedidos Baixados com sucesso !',['&OK']);
  End
  Else If fBaixaPedidoNaoEntregue(cdsConsulta.FieldByName('AUTOINCREM').AsString, strMotivo, strCodOco, True, opcRequisicao,
                                  intMotivoReq, strMotivoReq) Then
    fMensagem('Informação','Pedido Baixado com sucesso !',['&OK']);
end;

procedure TfrmPnlDadosPedCompra.pEnviaEmail(blnEnviaEmail : Boolean = True; enuTipoExportacao: TTipoExportacao = teEmail);
  Var
    strArqHtml : String;
    strAssunto : String;
    strContato : String;
    strTexto   : String;
    blnConfirma: Boolean;
    qryGenFor  : TUniQuery;
    intContador: Integer;
    bkmRegAtu  : TBookmark;
    arrArquivos, arrDestinatarios : TStringArray;
begin
  inherited;

  If (Assigned(cdsConsulta)) And (Not fValidaQtdRegistroGrid) Then
    Exit;

  If Not fTestaPdf Then
    Exit;

  qryGenFor := fCriaQuery;

  Try
    If blnShowmessage Then
    Begin
      If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEmail = '' Then
      Begin
        pCriarFormularios(TfrmDigEmailPedidoCompra, frmDigEmailPedidoCompra);
        frmDigEmailPedidoCompra.fraOpcPdfPedidoCompra.pSetAjustaTela(totEmail);

//        frmDigEmailPedidoCompra.pSetaTelaParaGeracao(enuTipoExportacao);
        frmDigEmailPedidoCompra.fraOpcPdfPedidoCompra.blnSomentePDF := enuTipoExportacao In [teLayout, tePDf];
        Try

          {*********************************************}
          {* CARREGA O EMAIL E O CONTATO DO FORNECEDOR *}
          {******************************************JB*}
          pPesquisaCadFor(Nil, qryGenFor, TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodFor);
          If Not fEmptyStr(qryGenFor.FieldByName('FOR_EMAPED').AsString) then
          Begin
            frmDigEmailPedidoCompra.fraOpcPdfPedidoCompra.edtEmail.Text   := qryGenFor.FieldByName('FOR_EMAPED').AsString;
            frmDigEmailPedidoCompra.fraOpcPdfPedidoCompra.edtContato.Text := qryGenFor.FieldByName('FOR_CONTAT').AsString;
          End
          Else
          Begin
            frmDigEmailPedidoCompra.fraOpcPdfPedidoCompra.edtEmail.Text   := TfraOpcPdfPedidoCompra.fRetContatoEmailPedCompra(strContato, TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodFor);
            frmDigEmailPedidoCompra.fraOpcPdfPedidoCompra.edtContato.Text := strContato;
          End;
          blnConfirma := (frmDigEmailPedidoCompra.ShowModal = mrOk);

        Finally
          pFreeAndNil(frmDigEmailPedidoCompra);
        End;
      End
      Else
        blnConfirma := True
    End
      Else
        blnConfirma := True

  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '');
    End;
  End;


  FreeAndNil(qryGenFor);

  If (Not blnConfirma) Then
    Exit;


  If Not fEmptyStr(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodLay) Then
  Begin
    strArqHtml := fGerarPDF(enuTipoExportacao = teLayout);
    strNomeArquivo := strArqHtml;
  End
  Else
    strArqHtml := TGeraEmail.fGeraEmail(TfraOpcPdfPedidoCompra.RecOpcaoImpressao,
                             TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNumPed,
                             TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc,
                             TfraOpcPdfPedidoCompra.RecOpcaoImpressao.StrEmpDes,
                             TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp,
                             blnDarRor,
                             strNomeArquivo,
                             chkAplPro.Checked,
                             fGerarXLSBROffice);

  {************************************************}
  {* FUNÇÃO QUE ABRE O OUTLOOK E ANEXA O  ARQUIVO *}
  {*********************************************LU*}
  If (Not fEmptyStr(strNomeArquivo)) Then
  Begin

    strNumPedidos := strNumPedidos + TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNumPed + ',';
    strNomeArquivos := strNomeArquivos + strNomeArquivo + ';';

    If blnEnviaEmail Then
    Begin

      strTexto := fCfgSis('EMAMSG', varString);
      If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc <> 'PD' Then
        strTexto := fCfgSis('EMAMGO', varString);
      If (Pos('PEDIDO', UpperCase(strTexto)) > 0) And (TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc <> 'PD')  Then
         strTexto := StringReplace(strTexto,'PEDIDO', 'ORÇAMENTO', [rfReplaceAll, rfIgnoreCase]);

      If (Not fVariosDocumentosSelecionados) Then
      Begin
        strAssunto := IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc = 'PD', ' Pedido', ' Orçamento') + ' de Compra Nº ' + strNumPedidos;
      End
      Else If fVariosDocumentosSelecionados Then
      Begin
        strAssunto := IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc = 'PD', ' Pedido(s)', ' Orçamento(s)') + ' de Compra.';
      End;

      If (TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strTipExp = 'PDF') Then
      Begin
        strTexto := strTexto + #13#10 + #13#10;
        strTexto := strTexto + 'Caso não possua o programa Acrobat Reader para visualizar o arquivo anexo, ';
        strTexto := strTexto + 'acesse o link e faça o download: <a href="https://www.adobe.com">www.adobe.com</a>';
      End;
      strAssunto := fRetNomeEmpresa + ' - ' + strAssunto;

      Copy(strNumPedidos, 1,  Length(strNumPedidos) -2);

      pCriarArrayAnexosEDestinatarios(strNomeArquivos, TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEmail, arrDestinatarios, arrArquivos);

      If (TEnvioEmail.EnviarEmail(Self, strLoginUsuarioLogado, strAssunto, arrDestinatarios, [], [], TEnvioEmail.ContruirArrayMensagem(strTexto), arrArquivos)) Then
      Begin
        If fVariosDocumentosSelecionados Then
        Begin
          For intContador := 0 To objPanel.stlListaSelecao.Count -1 Do
            If cdsConsulta.Locate('AUTOINCREM', objPanel.stlListaSelecao[intContador], []) Then
              pGravarLogEmail(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEmail, TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strContato);
        End
        Else
          pGravarLogEmail(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEmail, TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strContato);

        If Assigned(cdsConsulta) Then
        Begin
           bkmRegAtu := cdsConsulta.GetBookmark;
           Try
             cdsConsulta.GotoBookmark(bkmRegAtu);
//             cdsConsulta.Refresh;
           Except
            //
           End;
        End;
      End;

      SetForegroundWindow(Handle);
    End;
  End
  Else If (blnShowMessage) And (TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnGerPDF) Then
    fMensagem('ATENÇÃO!', 'Não foi possível exportar o arquivo PDF !', ['&Ok']);
end;

class procedure TfrmPnlDadosPedCompra.pImprimirPedidoLayout(strCodFor, strNumPed,
  strEspDoc, strCodEmpresa: String);
var
 qryGenFor: TUniQuery;
begin
  qryGenFor   := fCriaQuery();

  pCriarFormularios(TfrmPnlDadosPedCompra, frmPnlDadosPedCompra);
  frmPnlDadosPedCompra.blnShowmessage       := True;


//  frmPnlDadosPedCompra.blnImpPedCompra := True;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNumPed := strNumPed;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc := strEspDoc;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp := strCodEmpresa;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.StrEmpDes := frmPnlDadosPedCompra.fRetornaEmpresaDestino(strNumPed,
                                                                                                    strEspDoc,
                                                                                                    strCodEmpresa);
  If fEmptyStr(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.StrEmpDes) Then
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.StrEmpDes := VS_strCodEmp;
  If Not fEmptyStr(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodFor) then
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodFor := strCodFor
  Else
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodFor := fCampoTabela('PCG_CODFOR', 'PCMGER', ['PCG_NUMPED', 'PCG_ESPDOC', 'PCG_CODEMP'], [strNumPed, strEspDoc, strCodEmpresa]);

  pPesquisaCadFor(Nil, qryGenFor,   TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodFor);
  frmPnlDadosPedCompra.pEnviaEmail(false, teLayout);

 FreeAndNil(qryGenFor);
End;

class procedure TfrmPnlDadosPedCompra.pEnviaPedidoEmail(strCodFor, strNumPed,
  strEspDoc, strCodEmpresa: String);
var
 qryGenFor: TUniQuery;
begin
  qryGenFor   := fCriaQuery();

  pCriarFormularios(TfrmPnlDadosPedCompra, frmPnlDadosPedCompra);
  frmPnlDadosPedCompra.strNomeArquivos      := '';
  frmPnlDadosPedCompra.blnShowmessage       := True;

//  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strTipExp            := 'XLS';

  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.StrEmpDes := frmPnlDadosPedCompra.fRetornaEmpresaDestino(strNumPed,
                                                                                                    strEspDoc,
                                                                                                    strCodEmpresa);

  frmPnlDadosPedCompra.pEnviaEmail;

 FreeAndNil(qryGenFor);
end;

procedure TfrmPnlDadosPedCompra.pGravarLogEmail(strEmailDest,
  strDestinatario: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('UPDATE ');
  qryAux.SQL.Add('  PCMGER ');
  qryAux.SQL.Add('SET ');
  qryAux.SQL.Add('  PCG_DTAMAI = :DTAMAI, ');
  qryAux.SQL.Add('  PCG_HORMAI = :HORMAI, ');
  qryAux.SQL.Add('  PCG_OPEMAI = :OPEMAI, ');
  qryAux.SQL.Add('  PCG_NOMMAI = :NOMMAI, ');
  qryAux.SQL.Add('  PCG_DESMAI = :DESMAI ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  PCG_NUMPED = :NUMPED AND ');
  qryAux.SQL.Add('  PCG_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  PCG_CODEMP = :CODEMP ');

  qryAux.ParamByName('DTAMAI').AsDateTime := VS_Date;
  qryAux.ParamByName('HORMAI').AsDateTime := fTime();
  qryAux.ParamByName('OPEMAI').AsString   := strLoginUsuarioLogado;
  qryAux.ParamByName('NOMMAI').AsString   := strDestinatario;
  qryAux.ParamByName('DESMAI').AsString   := strEmailDest;

  If Assigned(cdsConsulta) Then
  Begin
    qryAux.ParamByName('NUMPED').AsString := cdsConsulta.FieldByName('PCG_NUMPED').AsString;
    qryAux.ParamByName('ESPDOC').AsString := cdsConsulta.FieldByName('PCG_ESPDOC').AsString;
    qryAux.ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('PCG_CODEMP').AsString;
  End
  Else
  Begin
    qryAux.ParamByName('NUMPED').AsString := TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNumPed;
    qryAux.ParamByName('ESPDOC').AsString := TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp;
  End;

  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;


Procedure TfrmPnlDadosPedCompra.pGeraExcel;
  Var
    Result: Boolean;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Gerando planilha...';
    frmGravando.fExecutarAcao := fGeraExcel;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmPnlDadosPedCompra.pGeraExcel]');
    End;
  End;

  pFreeAndNil(frmGravando);

  If Result Then
    fMensagem('','Arquivo ' + strNomeArquivo + ' gerado com sucesso!', ['&Ok']);
End;

Function TfrmPnlDadosPedCompra.fGeraExcel(pgbProgresso: TcxProgressBar): Boolean;
begin

//  If (fCfgSis('CNVEMB') <> 'N') and (blnShowmessage) And RecOpcaoImpressao. Then
//    RecOpcaoImpressao.blnMltCmp := fPergunta('Gerar quantidade convertida em múltiplos de compra?');
  {
  blnImpObs := True;
  blnComMar := True;
  blnLocFis := False;
  blnCodFab := True;
  }
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.intOrient := 1;
  Result := fGerarXLSBROffice(pgbProgresso);
end;


function TfrmPnlDadosPedCompra.fGerarXLSBROffice(pgbProgresso: TcxProgressBar): Boolean;
  Const
    NRO_LIN_CAB_EMPRESA = 11;
    NRO_LIN_CABEC       = 8;
    NRO_LIN_SOMA        = 12;
    NRO_LIN_TRANSP      = 7;
    NRO_LIN_ENTRE       = 9;
    NRO_LIN_OBS         = 4;

  Var
    strValue: String;
    blnZonaFranca,
    blnTelaUmaGiro,
    blnEhPedidoCompraMultiLoja: Boolean;

    objExcel     : TExcel;
    strSQL       : String;
    qryPedOrc    : TUniQuery;
    qryItensPdOr : TUniQuery;
    qryEmpPdOr   : TUniQuery;
    qryTranPdOr  : TUniQuery;
    qryTranRedes : TUniQuery;
    qryConsMed   : TUniQuery;
    strExecutavel: String;
    arrDadosPed  : Array Of Array [1..2] Of String;

    intCont      : Integer;
    intQtdCol    : Integer;
    strUltCol    : String;
    strConPag    : String;
    fltSaldoDisp : Double;
    LinAux       : Integer;
    strSQLQtdOri : String;
    strSQLQtdIte : String;
    strSQLUnitar : String;

    intMes       : Integer;
    strAno       : String;
    strMes1      : String;
    strMes2      : String;
    strMes3      : String;
    strMes4      : String;
    strAno1      : String;
    strAno2      : String;
    strAno3      : String;
    strAno4      : String;
    strTipFab    : String;

    strLetraInicialTransRedes: String;
    intColRedespacho : Integer;

    intPriLin    : Integer;
    intColuna    : Integer;
    intColSomas  : Integer;

    {Alinhamento e formato numerico por coluna calculados uma vez e aplicados em lote
     apos o loop de itens. Verificar Nota 2 - Req. 459077}
    arrAlinhaColuna    : Array of TAlinhamentoExcel;
    arrTemAlinhaColuna : Array of Boolean;
    blnTemColunaData   : Boolean;
    {Guarda TODAS as colunas de data encontradas, nao so a ultima - podem existir
     2+ colunas de data simultaneamente (ex: ITE_DTAULT + PCD_DTAENT quando
     fCfgSis('ENTITE') esta ligado). Verificar Nota 5 - Req. 459077}
    arrColsData        : Array of Integer;
    intPriLinhaDados   : Integer;
    intUltLinhaDados   : Integer;

    strDirGravacao : String;

    fltTotIte,
    fltTotQtd,
    fltTotIpi,
    fltTotSub,
    fltTotDar,
    fltTotSubFcp,
    fltTotDes,
    fltTotPis,
    fltTotCbs,
    fltTotIbs,
    fltTotIs,
    fltTotGer : Double;

    stlAplicacao: TStringList;
    curMedia: Currency;

    blnValTPC: Boolean;
    blnSomIte: Boolean;

    procedure pEscrever(linha, coluna: Integer; Valor: Variant);
    Begin
      With objExcel Do
        Escrever(linha, coluna, Valor);

      pgbProgresso.Position := pgbProgresso.Position + 1;
      {pProcessMessages (untGravando) so bombeia a fila de mensagens a cada 500ms,
       ao inves de Application.ProcessMessages puro a cada celula - aqui eram milhares
       de chamadas OLE para o Excel, cada uma seguida de um pump completo de mensagens.
       Verificar Nota 1 - Req. 459077}
      pProcessMessages;
    End;

    procedure pMesclar(CelulaInicial, CelulaFinal: String);
    Begin
      With objExcel Do
        Mesclar(CelulaInicial, CelulaFinal);
      pgbProgresso.Position := pgbProgresso.Position + 1;
      pProcessMessages;
    End;

    {Escreve o valor diretamente na celula (Cells[linha,coluna] := Valor) - usado no
     loop de detalhe de itens do relatorio. O alinhamento e o formato numerico de cada
     coluna NAO sao aplicados aqui - sao calculados uma unica vez e aplicados em lote
     por coluna (fora do loop), reduzindo de (linhas x colunas) para (colunas) chamadas
     de automacao OLE ao Excel. Verificar Nota 2 - Req. 459077}
    procedure pEscreverDireto(coluna: Integer; Valor: Variant);
    Begin
      With objExcel Do
        Escrever(LinhaAtual, coluna, Valor);
      pgbProgresso.Position := pgbProgresso.Position + 1;
      pProcessMessages;
    End;

    function fCampoExisteNaLista(strCampoOuDescricao: String): Boolean;
    var
      I:Integer;
    begin
      Result := False;
      For I := 0 To Pred(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.stlCamposExcel.Count) Do
      Begin
        If (SplitString(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.stlCamposExcel[I], '|')[0] = strCampoOuDescricao) Or (SplitString(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.stlCamposExcel[I], '|')[1] = strCampoOuDescricao) Then
          Exit(True);
      End;
    end;

    Procedure pColuna(intLinha: integer; strDado: String);
    Begin
      If Assigned(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.stlCamposExcel) And (TfraOpcPdfPedidoCompra.RecOpcaoImpressao.stlCamposExcel.Count > 0) And (Not fCampoExisteNaLista(StrDado)) Then
        Exit;

      If intLinha = 1 Then
        SetLength(arrDadosPed, Succ(Length(arrDadosPed)));
      inc(intQtdCol);
      arrDadosPed[Pred(intQtdCol)][intLinha] := strDado;
    End;

    procedure pProcessarListaCamposExcel;
    var
      I: Integer;
    begin
      intQtdCol := 0;
      For I := 0 To Pred(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.stlCamposExcel.Count) Do
        If (SplitString(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.stlCamposExcel[I], '|')[0] <> 'VLTOPC') Then
          pColuna(1, SplitString(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.stlCamposExcel[I], '|')[1]);

      intQtdCol := 0;
      For I := 0 To Pred(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.stlCamposExcel.Count) Do
        If (SplitString(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.stlCamposExcel[I], '|')[0] <> 'VLTOPC') Then
          pColuna(2, SplitString(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.stlCamposExcel[I], '|')[0]);
    end;

begin

  SetLength(arrDadosPed, 0);

  Result := False;
  fltTotIte := 0;
  fltTotQtd := 0;
  fltTotIpi := 0;
  fltTotSub := 0;
  fltTotDar := 0;
  fltTotSubFcp := 0;
  fltTotDes := 0;
  fltTotPis := 0;
  fltTotCbs := 0;
  fltTotIbs := 0;
  fltTotIs  := 0;

  blnValTPC := fCampoExisteNaLista('VLTOPC');
  blnSomIte := fCampoExisteNaLista('TOTITE');

  blnZonaFranca := fEhEstadoRegraZonaFranca(fCadEmp('ESTADO'));
  blnTelaUmaGiro := fCfgSis('TELUMA', varBoolean);

  If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.tipQtdIte = tqpPendente Then
    strSQLQtdOri := ' (PCMDET.PCD_QTDITE - PCMDET.PCD_QTDBAI) '
  Else
    strSQLQtdOri := ' (PCMDET.PCD_QTDITE) ';

  If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnMltCmp Then
  Begin
    strSQLQtdIte := ' ( ' + strSQLQtdOri + ' / IF(IFNULL(CADITE.ITE_MLTCOM, 0) > 0, CADITE.ITE_MLTCOM, 1)) ';
    strSQLUnitar := ' (PCMDET.PCD_UNITAR * IF(IFNULL(CADITE.ITE_MLTCOM, 0) > 0, CADITE.ITE_MLTCOM, 1)) ';
  End Else
  Begin
    strSQLQtdIte := strSQLQtdOri;
    strSQLUnitar := ' PCMDET.PCD_UNITAR '   ;
  End;

  Try

    blnEhPedidoCompraMultiLoja := fEhPedidoCompraMultiLoja(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNumPed,
                                                           TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc,
                                                           IIF(fEmptyStr(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp),
                                                               VS_strCodEmp,
                                                               TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp));

    stlAplicacao := TStringList.Create;

    qryPedOrc    := fCriaQuery;
    qryItensPdOr := fCriaQuery;
    qryEmpPdOr   := fCriaQuery;
    qryTranPdOr  := fCriaQuery;
    qryTranRedes := fCriaQuery;
    qryConsMed   := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT      ';
    strSQL := strSQL + '  PCMGER.*, ';
    strSQL := strSQL + '  CADFOR.*, ';
    strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, " - ", CADCID.CID_ESTADO) AS FOR_NOMCID, ';
    strSQL := strSQL + '  IF(PCG_CODCMP IS NULL, PCG_COMPRA, OPE_NOMOPE) AS COMPRA, ';
    strSQL := strSQL + '  OPE_E_MAIL, ';
    strSQL := strSQL + '  OPE_FONE01, ';
    strSQL := strSQL + '  OPE_RAMAL1, ';
    strSQL := strSQL + '  OPE_NEXTEL  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  PCMGER ';
    strSQL := strSQL + '       JOIN CADFOR ON (PCMGER.PCG_CODFOR = CADFOR.FOR_CODFOR) ';
    strSQL := strSQL + '  LEFT JOIN CADCID ON (CADFOR.FOR_CODCID = CADCID.CID_CODCID) ';
    strSQL := strSQL + '  LEFT JOIN CADOPE ON OPE_CODOPE = PCG_CODCMP ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  PCMGER.PCG_NUMCTN = 0       AND ';
    strSQL := strSQL + '  PCMGER.PCG_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCMGER.PCG_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  PCMGER.PCG_CODEMP = :CODEMP ';

    With qryPedOrc Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMPED').AsString := TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNumPed;
      ParamByName('ESPDOC').AsString := TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc;
      If fEmptyStr(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp) Then
        ParamByName('CODEMP').AsString := VS_strCodEmp
      Else
        ParamByName('CODEMP').AsString := TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp;
      Open;
      TFloatField(FieldByName('PCG_TOTITE')).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('PCG_TOTGER')).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('PCG_TOTIPI')).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('PCG_TOTSUB')).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('PCG_TOTDAR')).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('PCG_SUBFCP')).DisplayFormat := '#,##0.00';
      strTipFab := FieldByName('PCG_TIPFAB').AsString;
    End;
    {**************************************}
    {* CARREGANDO OS ITENS DO PEDIDO      *}
    {***********************************LU*}
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  PCMDET.*, ';
    strSQL := strSQL + '  CONCAT(PCG_OBS001, " " , PCG_OBS002, " ", PCG_OBS003, " " , PCG_OBS004 , " " ,PCG_OBS005)AS OBSERV, ';
    strSQL := strSQL + '  '  + strSQLQtdIte + ' AS QTDITE, ';
    strSQL := strSQL + '  '  + strSQLUnitar + ' AS UNITAR, ';
    strSQL := strSQL + '  PCD_UNILIQ AS UNILIQ, ';

    If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.tipQtdIte = tqpPendente Then
    Begin
      strSQL := strSQL + '  PCMDET.PCD_TOTITE - PCMDET.PCD_TOTBAI AS TOTITE, ';
      strSQL := strSQL + '  PCMDET.PCD_TOTIPI - PCMDET.PCD_IPIBAI AS TOTIPI, ';
      strSQL := strSQL + '  PCMDET.PCD_TOTSUB - PCMDET.PCD_SUBBAI AS TOTSUB, ';
      strSQL := strSQL + '  IFNULL(IFNULL(PCMDET.PCD_VALCBS, 0) * ' + strSQLQtdOri + ' / PCMDET.PCD_QTDITE, 0) AS TOTCBS, ';
      strSQL := strSQL + '  IFNULL(IFNULL(PCMDET.PCD_VALIBS, 0) * ' + strSQLQtdOri + ' / PCMDET.PCD_QTDITE, 0) AS TOTIBS, ';
      strSQL := strSQL + '  IFNULL(IFNULL(PCMDET.PCD_VAL_IS, 0) * ' + strSQLQtdOri + ' / PCMDET.PCD_QTDITE, 0) AS TOT_IS, ';

      If blnDarRor Then
        strSQL := strSQL + '  PCMDET.PCD_TOTDAR - IFNULL(PCMDET.PCD_DARBAI, 0) AS TOTDAR, '
      Else
        strSQL := strSQL + '  0.00 AS TOTDAR, ';

      strSQL := strSQL + '  PCMDET.PCD_SUBFCP - PCMDET.PCD_FCPBAI AS SUBFCP, ';

      If fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')) Then
      Begin
        strSQL := strSQL + '  (PCMDET.PCD_VALICM / PCMDET.PCD_QTDITE) * ' + strSQLQtdIte + ' AS ICMDES, ';
        strSQL := strSQL + '  (PCMDET.PCD_DESPIS / PCMDET.PCD_QTDITE) * ' + strSQLQtdIte + ' AS DESPIS, ';
      End Else
      Begin
        strSQL := strSQL + '  0.00 AS ICMDES, ';
        strSQL := strSQL + '  0.00 AS DESPIS, ';
      End;

    End
    Else
    Begin
      strSQL := strSQL + '  PCMDET.PCD_TOTITE AS TOTITE, ';
      strSQL := strSQL + '  PCMDET.PCD_TOTIPI AS TOTIPI, ';
      strSQL := strSQL + '  PCMDET.PCD_TOTSUB AS TOTSUB, ';
      strSQL := strSQL + '  IFNULL(PCMDET.PCD_VALCBS, 0) AS TOTCBS, ';
      strSQL := strSQL + '  IFNULL(PCMDET.PCD_VALIBS, 0) AS TOTIBS, ';
      strSQL := strSQL + '  IFNULL(PCMDET.PCD_VAL_IS, 0) AS TOT_IS, ';

      If blnDarRor Then
        strSQL := strSQL + '  PCMDET.PCD_TOTDAR AS TOTDAR, '
      Else
        strSQL := strSQL + '  0.00 AS TOTDAR, ';

      strSQL := strSQL + '  PCMDET.PCD_SUBFCP AS SUBFCP, ';

      If fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')) Then
      Begin
        strSQL := strSQL + '  PCMDET.PCD_VALICM AS ICMDES, ';
        strSQL := strSQL + '  PCMDET.PCD_DESPIS AS DESPIS, ';
      End Else
      Begin
        strSQL := strSQL + '  0.00 AS ICMDES, ';
        strSQL := strSQL + '  0.00 AS DESPIS, ';
      End;

    End;

    If Not fEmptyStr(strTipFab) Then
    Begin
      strSQL := strSQL + fRetornaSQLCodigoFabricaProduto(strTipFab);
    End
    Else If fCfgSis('CODFIT', varBoolean) Then
    Begin
      strSQL := strSQL +'  CADITE.ITE_CODFAB AS ITE_CODFAB, ';
    End
    Else
    Begin
      If fCfgSis('TABPRF', varBoolean) Then
        strSQL := strSQL + '  IF(IFNULL(F.ITE_CODFAB,"") = "", CADITE.ITE_CODFAB, F.ITE_CODFAB) AS ITE_CODFAB, '
      Else
        strSQL := strSQL + '  IF(IFNULL(F.ITE_CODITF,"") = "", CADITE.ITE_CODFAB, F.ITE_CODITF) AS ITE_CODFAB, ';
    End;

    strSQL := strSQL + '  CADITE.*, ';

    If Not fEmptyStr(strTipFab) Then
    Begin
      strSQL := strSQL + fRetornaSQLAplicacaoCodigoFabricaProduto(strTipFab);
    End
    Else If fCfgSis('CODFIT', varBoolean) Then
    Begin
      strSQL := strSQL + '  CAST(CONCAT(CADITE.ITE_APLICA," / ", CADITE.ITE_CODFAB)AS CHAR(255)) AS ITE_APLFAB, ';
    End
    Else
    Begin
      If fCfgSis('TABPRF', varBoolean) Then
        strSQL := strSQL + '  CAST(CONCAT(CADITE.ITE_APLICA," / ", IF(IFNULL(F.ITE_CODFAB,"") = "", CADITE.ITE_CODFAB, F.ITE_CODFAB) ) AS CHAR(255)) AS ITE_APLFAB, '
      Else
        strSQL := strSQL + '  CAST(CONCAT(CADITE.ITE_APLICA," / ", IF(IFNULL(F.ITE_CODITF,"") = "", CADITE.ITE_CODFAB, F.ITE_CODITF) ) AS CHAR(255)) AS ITE_APLFAB, ';
    End;

    If blnEhPedidoCompraMultiLoja Then
    Begin
      If blnTelaUmaGiro Then
      Begin
        strSQL := strSQL +'( SELECT ';
        strSQL := strSQL + '  ITE_DTAULT ';
        strSQL := strSQL + ' FROM ITEGER ';
        strSQL := strSQL + ' WHERE ITE_CODITE = PCD_CODITE AND ITE_DTAULT IS NOT NULL';
        strSQL := strSQL + ' ORDER BY ITE_DTAULT DESC LIMIT 1 ) AS ITE_DTAULT, ';
      End
      Else
        strSQL := strSQL + '  ITEGER.ITE_DTAULT, ';
    End
    Else
      strSQL := strSQL + '  ITEGER.ITE_DTAULT, ';
    strSQL := strSQL + '  ITEGER.ITE_SALDOS, ';
    strSQL := strSQL + '  CADMAR.MAR_DESMAR, ';
    strSQL := strSQL + '  CADUNI.UNI_SIGUNI, ';
    strSQL := strSQL + '  ITEGER.ITE_LOCFIS, ';
    strSQL := strSQL + '  CADITE.ITE_CODBAR, ';
    strSQL := strSQL + '  CADITE.ITE_REFERE, ';
    strSQL := strSQL + '  NULL AS VLTOPC,    ';

    strSQL := strSQL + '  " - " AS VAZIO, ';
    strSQL := strSQL + '  IF(PCMGER.PCG_TIPFRE="1","CIF","FOB") AS PCG_TIPFRE, ';
    strSQL := strSQL + '  IF(FOR_SIMPAU = "S", IF(FOR_MATREV = "I", ABF_IVA_ST_ENT_PSI, ABF_IVA_ST_ENT_PES),  IF(FOR_CGCCPF = "2" OR FOR_I_E_S_ = "", ABF_IVA_ST_ENT_PEF, ABF_IVA_ST_ENT_PEJ)) AS ABF_IVA_ST, ';
    strSQL := strSQL + '  0   AS ITE_CONMED, ';
    strSQL := strSQL + ' (' + strSQLQtdOri + ' * CADUNI.UNI_PESLIT / :LITGAL) AS LITROS, ';
    strSQL := strSQL + ' (' + strSQLQtdOri + ' * CADITE.ITE_PESOIT) AS PESOIT ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PCMDET ';
    strSQL := strSQL + '  JOIN PCMGER ON (PCMDET.PCD_NUMPED = PCMGER.PCG_NUMPED  ';
    strSQL := strSQL + '              AND PCMDET.PCD_ESPDOC = PCMGER.PCG_ESPDOC  ';
    strSQL := strSQL + '              AND PCMDET.PCD_CODEMP = PCMGER.PCG_CODEMP  ';
    strSQL := strSQL + '              AND PCMDET.PCD_NUMCTN = PCMGER.PCG_NUMCTN) ';
    strSQL := strSQL + '  JOIN CADITE ON (PCMDET.PCD_CODITE = CADITE.ITE_CODITE) ';
    strSQL := strSQL + '  JOIN CADFOR ON (PCMDET.PCD_CODFOR = CADFOR.FOR_CODFOR) ';
    strSQL := strSQL + '  JOIN ITEGER ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE AND    ';
    strSQL := strSQL + '                 ITEGER.ITE_CODEMP = :EMPPED                  ';
    strSQL := strSQL + '  LEFT JOIN CADCID ON (CADFOR.FOR_CODCID = CADCID.CID_CODCID) ';

    If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnMltCmp Then
      strSQL := strSQL + '  LEFT JOIN CADUNI ON (CADITE.ITE_UNICOM = CADUNI.UNI_CODUNI) '
    Else
      strSQL := strSQL + '  LEFT JOIN CADUNI ON (PCMDET.PCD_CODUNI = CADUNI.UNI_CODUNI) ';

    strSQL := strSQL + '  LEFT JOIN CADMAR ON (CADITE.ITE_CODMAR = CADMAR.MAR_CODMAR) ';
    strSQL := strSQL + '  LEFT JOIN ABFICM ON (CADITE.ITE_CODABF = ABFICM.ABF_CODABF  ';
    strSQL := strSQL + '                   AND CADCID.CID_ESTADO = ABFICM.ABF_ESTADO) ';

    strSQL := strSQL + '  LEFT JOIN ITEFOR F ON F.ITE_CODITE = PCMDET.PCD_CODITE ';
    strSQL := strSQL + '                    AND F.ITE_CODFOR = PCMDET.PCD_CODFOR ';

    If fCfgSis('TABPRF', varBoolean) Then
    Begin
      strSQL := strSQL + '                  AND (SELECT COUNT(*) FROM TABPRE     ';
      strSQL := strSQL + '                       WHERE F.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S") > 0 ';
      End Else
      Begin
        strSQL := strSQL + '                  AND F.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF     ';
        strSQL := strSQL + '                       WHERE FF.ITE_CODITE = PCMDET.PCD_CODITE AND ';
        strSQL := strSQL + '                             FF.ITE_CODFOR = PCMDET.PCD_CODFOR)   ';
    End;

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCMDET.PCD_NUMCTN = 0 AND ';
    strSQL := strSQL + '  PCMDET.PCD_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCMDET.PCD_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  PCMDET.PCD_CODEMP = :CODEMP ';

    If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.tipQtdIte = tqpPendente Then
      strSQL := strSQL + '  AND ' + strSQLQtdOri + ' > 0 ';

    strSQL := strSQL + 'ORDER BY ';

    case TfraOpcPdfPedidoCompra.RecOpcaoImpressao.chrOrdDig of
        'D': strSQL := strSQL + '  PCMDET.AUTOINCREM ';
        'A': strSQL := strSQL + '  PCMDET.PCD_DESITE ';
        'F': Begin
               If fCfgSis('TABPRF', varBoolean) Then
                 strSQL := strSQL + '  IF(IFNULL(F.ITE_CODFAB,"") = "", CADITE.ITE_CODFAB, F.ITE_CODFAB) '
               Else
                 strSQL := strSQL + '  IF(IFNULL(F.ITE_CODITF,"") = "", CADITE.ITE_CODFAB, F.ITE_CODITF) ';
             End;
       Else  strSQL := strSQL + '  PCMDET.PCD_DESITE ';
    End;


    With qryItensPdOr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMPED').AsString := TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNumPed;
      ParamByName('ESPDOC').AsString := TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc;

      If fEmptyStr(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp) Then
        ParamByName('CODEMP').AsString := VS_strCodEmp
      Else
        ParamByName('CODEMP').AsString := TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp;

      If fEmptyStr(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEmpDes) Then
        ParamByName('EMPPED').AsString := VS_strCodEmp
      Else
        ParamByName('EMPPED').AsString := TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEmpDes;

      If Params.FindParam('LITGAL') <> Nil Then
      Begin
        If SameText(fCfgSis('LITGAL'), 'L') Then
          ParamByName('LITGAL').AsFloat := 1
        Else
          ParamByName('LITGAL').AsFloat := FLT_LITRO_GALAO;
      End;
      Open;
      TFloatField(FieldByName('PCD_QTDITE')).DisplayFormat := '#,##0.000';
      TFloatField(FieldByName('PCD_UNITAR')).DisplayFormat := '#,##0.000';
      TFloatField(FieldByName('PCD_TOTITE')).DisplayFormat := '#,##0.000';
      TFloatField(FieldByName('PCD_PERIPI')).DisplayFormat := '#,##0.0000';
      TFloatField(FieldByName('PCD_TOTIPI')).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('PCD_PERSUB')).DisplayFormat := '#,##0.0000';
      TFloatField(FieldByName('PCD_TOTSUB')).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('PCD_TOTDAR')).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('PCD_SUBFCP')).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('PCD_VALICM')).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('PCD_DESPIS')).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('ABF_IVA_ST')).DisplayFormat := '#,##0.0000';
    End;

    {**************************************}
    {* CARREGANDO OS DADOS DA EMPRESA     *}
    {***********************************LU*}
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CADEMP.EMP_CODEMP, ';
    strSQL := strSQL + '  CADEMP.EMP_NOMEMP,';
    strSQL := strSQL + '  CONCAT(CADEMP.EMP_ENDERE, ", ", IFNULL(CADEMP.EMP_ENDNUM,""),IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP))) AS EMP_ENDERE, ';
    strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, " - ", CADCID.CID_ESTADO) AS EMP_NOMCID,';
    strSQL := strSQL + '  IF(IFNULL(CADEMP.EMP_EMAILC, "") = "",  CADEMP.EMP_EMAIL_, CADEMP.EMP_EMAILC) AS EMP_EMAILC,';
    strSQL := strSQL + '  CADEMP.EMP_FONE01,';
    strSQL := strSQL + '  CADEMP.EMP_F_A_X_,';
    strSQL := strSQL + '  CADEMP.EMP_C_G_C_,';
    strSQL := strSQL + '  CADEMP.EMP_I_E_S_ ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + '  LEFT JOIN CADCID ON (CADEMP.EMP_CODCID = CADCID.CID_CODCID) ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CADEMP.EMP_CODEMP = :CODEMP ';

    With qryEmpPdOr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      If Not fEmptyStr(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEmpDes) Then
        ParamByName('CODEMP').AsString := TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEmpDes
      Else
      Begin
        If fEmptyStr(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp) Then
          ParamByName('CODEMP').AsString := VS_strCodEmp
        Else
          ParamByName('CODEMP').AsString := TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp;
      End;
      If fEmptyStr(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEmpDes) Then
         TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEmpDes := ParamByName('CODEMP').AsString;

      Open;
    End;


    {**********************************************}
    {* CARREGANDO OS DADOS DA TRANSPORTADORA      *}
    {*******************************************LU*}
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CADTRA.*, ';
    strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, " - ", CADCID.CID_ESTADO) AS TRA_NOMCID ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADTRA ';
    strSQL := strSQL + '  LEFT JOIN CADCID ON (CADTRA.TRA_CODCID = CADCID.CID_CODCID) ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CADTRA.TRA_CODTRA = :CODTRA ';

    With qryTranPdOr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODTRA').AsString := qryPedOrc.FieldByName('PCG_CODTRA').AsString;
      Open;
    End;

    {***************************************************}
    {* CARREGANDO OS DADOS DA TRANSPORTADORA REDESPACHO*}
    {***************************************************}
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CADTRA.*, ';
    strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, " - ", CADCID.CID_ESTADO) AS TRA_NOMCID ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADTRA ';
    strSQL := strSQL + '  LEFT JOIN CADCID ON (CADTRA.TRA_CODCID = CADCID.CID_CODCID) ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CADTRA.TRA_CODTRA = :CODTRA ';

    With qryTranRedes Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODTRA').AsString := qryPedOrc.FieldByName('PCG_CODTRR').AsString;
      Open;
    End;

    {************************************************}
    {* CARREGANDO OS DADOS DO CONSUMO MEDIO DO ITEM *}
    {*********************************************IV*}

    intMes := StrToInt(LeftStr(FormatDateTime('mm/yyyy', VS_Date),2));
    strAno := RightStr(FormatDateTime('mm/yyyy', VS_Date),4);

    If intMes <= 3 Then
    Begin
      strMes4 := fStrZero(IntToStr(intMes),2);
      strAno4 := strAno;
      Inc(intMes,-1);

      If intMes <> 0 Then
      Begin
        strMes3 := fStrZero(IntToStr(intMes),2);
        strAno3 := strAno;
        Inc(intMes,-1);
      End
      Else
      Begin
        strMes3 := '12';
        strAno3 := IntToStr(StrToInt(strAno) -1);
        strAno  := strAno3;
        intMes  := 11;
      End;

      If intMes <> 0 Then
      Begin
        strMes2 := fStrZero(IntToStr(intMes),2);
        strAno2 := strAno;
        Inc(intMes,-1);
      End
      Else
      Begin
        strMes2 := '12';
        strAno2 := IntToStr(StrToInt(strAno) -1);
        strAno  := strAno2;
        intMes  := 11;
      End;

      If intMes <> 0 Then
      Begin
        strMes1 := fStrZero(IntToStr(intMes),2);
        strAno1 := strAno;
      End
      Else
      Begin
        strMes1 := '12';
        strAno1 := IntToStr(StrToInt(strAno) -1);
        strAno  := strAno1;
      End;

    End
    Else
    Begin
      strMes4 := fStrZero(IntToStr(intMes),2);
      strAno4 := strAno;
      Inc(intMes, -1);

      strMes3 := fStrZero(IntToStr(intMes),2);
      strAno3 := strAno;
      Inc(intMes, -1);

      strMes2 := fStrZero(IntToStr(intMes),2);
      strAno2 := strAno;
      Inc(intMes, -1);

      strMes1 := fStrZero(IntToStr(intMes),2);
      strAno1 := strAno;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  (SUM(IFNULL((SELECT SQL_NO_CACHE GIR_QSAI' + strMes1 + ' FROM GIRITE WHERE GIR_CODITE = G.ITE_CODITE ';
    strSQL := strSQL + '       AND GIR_CODEMP = G.ITE_CODEMP AND GIR_A_N_O_ = ' + QuotedStr(strAno1) + ' ), 0 )) +             ';
    strSQL := strSQL + '   SUM(IFNULL((SELECT SQL_NO_CACHE GIR_QSAI' + strMes2 + ' FROM GIRITE WHERE GIR_CODITE = G.ITE_CODITE ';
    strSQL := strSQL + '       AND GIR_CODEMP = G.ITE_CODEMP AND GIR_A_N_O_ = ' + QuotedStr(strAno2) + ' ), 0 )) +             ';
    strSQL := strSQL + '   SUM(IFNULL((SELECT SQL_NO_CACHE GIR_QSAI' + strMes3 + ' FROM GIRITE WHERE GIR_CODITE = G.ITE_CODITE ';
    strSQL := strSQL + '       AND GIR_CODEMP = G.ITE_CODEMP AND GIR_A_N_O_ = ' + QuotedStr(strAno3) + ' ), 0 )))/3 AS MEDIA   ';
    strSQL := strSQL + '  FROM        ';
    strSQL := strSQL + '    CADITE I, ';
    strSQL := strSQL + '    ITEGER G, ';
    strSQL := strSQL + '    PCMDET D  ';
    strSQL := strSQL + ' WHERE I.ITE_CODITE = G.ITE_CODITE  ';
    strSQL := strSQL + '   AND I.ITE_CODITE = D.PCD_CODITE  ';
    strSQL := strSQL + '   AND D.PCD_NUMPED = :NUMDOC       ';
    strSQL := strSQL + '   AND D.PCD_CODITE = :CODITE       ';
    strSQL := strSQL + ' GROUP BY I.ITE_CODITE              ';

    With qryConsMed Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := qryPedOrc.FieldByName('PCG_NUMPED').AsString;
    End;

    {*******************************************}
    {* PEGA O ENDEREÇO CORRENTE DO EXECUTÁVEL  *}
    {****************************************LU*}
    strExecutavel := ExtractFilePath(Application.ExeName);

    If (TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc  = 'PD') Then
    Begin
      {*******************************************}
      {* SE NÃO EXISTIR O DIRETÓRIO ELE CRIA     *}
      {****************************************LU*}
      If Not DirectoryExists(strExecutavel + 'PedidoCompra') Then
      Begin
        CreateDir(strExecutavel + 'PedidoCompra');
      End;
      strDirGravacao := strExecutavel + 'PedidoCompra';
    End
    Else
    Begin
      If Not DirectoryExists(strExecutavel + 'OrcamentoCompra') Then
      Begin
        CreateDir(strExecutavel + 'OrcamentoCompra');
      End;
      strDirGravacao := strExecutavel + 'OrcamentoCompra';
    End;

    {*******************************************}
    {* O ARQUIVO SERÁ GERADO COM ESSE NOME     *}
    {****************************************LU*}
    strNomeArquivo := strDirGravacao + '\' +
                      IIF(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc  = 'PD', 'PD_', 'OR_')  +
                      TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNumPed+ '.xls';

    If (Assigned(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.stlCamposExcel)) And
       (TfraOpcPdfPedidoCompra.RecOpcaoImpressao.stlCamposExcel.Count > 0) Then
    Begin
      pProcessarListaCamposExcel;
    End
    Else
    Begin

      blnValTPC := True;
      blnSomIte := True;

      intQtdCol := 0;
      pColuna(1, 'CÓDIGO');
      pColuna(1, 'DESCRIÇÃO');
      If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnComMar Then
        pColuna(1, 'MARCA');
      If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnCodFab Then
        pColuna(1, 'CÓD. FÁBRICA');
      If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnLocFis Then
        pColuna(1, 'LOC. FISICA');

      If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnCodbar Then
        pColuna(1, 'CÓD. BARRAS');

      If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImpRef Then
        pColuna(1, 'REFERÊNCIA');

      pColuna(1, 'UNID.');
      pColuna(1, 'QTDE.');
      If Not TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre Then
      Begin
        pColuna(1, 'PREÇO UNIT.');
        pColuna(1, '% DESCONTO 1');
        pColuna(1, '% DESCONTO 2');
        pColuna(1, '% DESCONTO 3');
        pColuna(1, '% DESCONTO 4');
        pColuna(1, '% DESCONTO 5');
        pColuna(1, '% DESCONTO 6');
        pColuna(1, 'UNIT. LÍQUIDO');
        pColuna(1, 'PREÇO TOTAL');
        pColuna(1, '% IPI');
        pColuna(1, 'VR. IPI');
      End;
      pColuna(1, 'ULT. COMPRA');
      pColuna(1, 'CONS. MÉDIO');
      pColuna(1, 'SALDO DISP.');
      pColuna(1, 'FRETE');
      If Not TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre Then
      Begin
        pColuna(1, 'ICMS ST');
        pColuna(1, 'ICMS ST FCP');

        If blnDarRor Then
          pColuna(1, 'VALOR DARE');

      end;

      If blnZonaFranca Then
      Begin
        pColuna(1, 'DESCONTO PIS/COFINS');
        pColuna(1, 'ICMS DESONERADO');
      End;

      If Not TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre Then
        pColuna(1, 'IVA');

      If fCfgSis('ENTITE', VarBoolean) Then
        pColuna(1, 'DATA ENTREGA');

      If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImpObs Then
        pColuna(1, 'OBSERVAÇÃO');

      intQtdCol := 0;
      pColuna(2, 'PCD_CODITE');
      pColuna(2, 'PCD_DESITE');
      If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnComMar Then
        pColuna(2, 'MAR_DESMAR');

      If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnCodFab Then
        pColuna(2, 'ITE_CODFAB');

      If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnLocFis Then
        pColuna(2, 'ITE_LOCFIS');

      If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnCodbar Then
        pColuna(2, 'ITE_CODBAR');

      If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImpRef Then
        pColuna(2, 'ITE_REFERE');

      pColuna(2, 'UNI_SIGUNI');
      pColuna(2, 'QTDITE');
      If Not TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre Then
      Begin
        pColuna(2, 'UNITAR');
        pColuna(2, 'PCD_DESUNI');
        pColuna(2, 'PCD_DESUN2');
        pColuna(2, 'PCD_DESUN3');
        pColuna(2, 'PCD_DESUN4');
        pColuna(2, 'PCD_DESUN5');
        pColuna(2, 'PCD_DESUN6');
        pColuna(2, 'UNILIQ');
        pColuna(2, 'TOTITE');
        pColuna(2, 'PCD_PERIPI');
        pColuna(2, 'TOTIPI');
      End;
      pColuna(2, 'ITE_DTAULT');
      pColuna(2, 'ITE_CONMED');
      pColuna(2, 'ITE_SALDOS');
      pColuna(2, 'PCG_TIPFRE');

      If Not TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre Then
      begin
        pColuna(2, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, 'VAZIO','TOTSUB'));
        pColuna(2, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, 'VAZIO','SUBFCP'));

        If blnDarRor Then
          pColuna(2, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, 'VAZIO','TOTDAR'));
      end;

      If blnZonaFranca Then
      Begin
        pColuna(2, 'DESPIS');
        pColuna(2, 'ICMDES');
      End;

      If Not TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre Then
        pColuna(2, 'ABF_IVA_ST');

      If fCfgSis('ENTITE', VarBoolean) Then
        pColuna(2, 'PCD_DTAENT');

      If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImpObs Then
        pColuna(2, 'OBSERV');

      If blnExcRes Then
      Begin
        SetLength(arrDadosPed, 0);
        intQtdCol := 0;
        If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnCodFab Then
          pColuna(1, 'CÓD. FÁBRICA');
        pColuna(1, 'DESCRIÇÃO');
        If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnComMar Then
          pColuna(1, 'MARCA');
        pColuna(1, 'UNID.');
        pColuna(1, 'QTDE.');
        pColuna(1, 'PREÇO UNIT.');
        pColuna(1, '% DESCONTO 1');
        pColuna(1, 'PREÇO TOTAL');
        pColuna(1, 'FRETE');
        If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImpObs Then
          pColuna(1, 'OBSERVAÇÃO');

        intQtdCol := 0;
        If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnCodFab Then
          pColuna(2, 'ITE_CODFAB');
        pColuna(2, 'PCD_DESITE');
        If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnComMar Then
          pColuna(2, 'MAR_DESMAR');
        pColuna(2, 'UNI_SIGUNI');
        pColuna(2, 'QTDITE');
        pColuna(2, 'UNITAR');
        pColuna(2, 'PCD_DESUNI');
        pColuna(2, 'TOTITE');
        pColuna(2, 'PCG_TIPFRE');
        pColuna(2, 'OBSERV');
      End;
    End;

    pgbProgresso.Position := 0;
    pgbProgresso.Properties.Max := qryItensPdOr.RecordCount * intQtdCol + intQtdCol + 59 {59 - Quantidade de Escrever fora do loop}
                                + NRO_LIN_CAB_EMPRESA // Mesclar
                                + 2 * NRO_LIN_CABEC
                                + 2 * NRO_LIN_SOMA
                                + 2 * NRO_LIN_TRANSP
                                + NRO_LIN_OBS;

    {blnOtimizarAutomacao liga suspensao de ScreenUpdating/Calculation no Excel via OLE -
     seguro aqui pois este fluxo so escreve planilha nova, nunca le formula de arquivo
     existente. Verificar Nota 1 - Req. 459077}
    objExcel := TExcel.fCriarExcel(Self, True);
    If Not objExcel.CriarArquivo(strNomeArquivo) Then
    begin
      FreeAndNil(objExcel);
      Exit;
    End;

    {objExcel controla uma instancia real do Microsoft Excel (EXCEL.EXE) via OLE -
     este bloco fica em Try/Finally para garantir que o processo seja encerrado
     (FecharArquivo) e o objeto liberado mesmo se uma excecao interromper a
     geracao no meio do caminho - sem isso, uma excecao no meio da escrita da
     planilha pulava direto para o Except mais externo sem nunca chamar
     FecharArquivo, deixando um processo EXCEL.EXE orfao (e, com
     blnOtimizarAutomacao da Nota 1, preso em Calculation=Manual/
     ScreenUpdating=False). Verificar Nota 4 - Req. 459077}
    Try
    With objExcel Do
    Begin

      LinhaAtual := 1;
      strUltCol  := fGetLetraAlfa(intQtdCol);

//      PintarTudo(Branco);

      DefinirFonte(CourierNew, 10);

      {**************************************************}
      {* COLOCA EM NEGRITO E ALINHA AO CENTRO DA CELULA *}
      {***********************************************LU*}
      For intCont := 1 To NRO_LIN_CAB_EMPRESA Do
      Begin
        Negrito('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), True);
        Alinhamento('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), Centro);
        pMesclar('A' + IntToStr(intCont), strUltCol + IntToStr(intCont));
      End;

      CorFundo('A8', strUltCol + '8', Cinza);
      Bordas('A2',  strUltCol + '7',  True,True,True,True);
      Bordas('A8',  strUltCol + '8',  True,True,True,True);
      Bordas('A9',  strUltCol + '10', True,True,True,True);
      Bordas('A11', strUltCol + '20', True,True,True,True);

      For intCont := 12 To 12 + NRO_LIN_CABEC Do
      Begin
        Negrito('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), True);
        If Not Assigned(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.stlCamposExcel) Then
        Begin
          pMesclar('A' + IntToStr(intCont), 'G' + IntToStr(intCont));
          pMesclar('H' + IntToStr(intCont), strUltCol + IntToStr(intCont));
          Alinhamento('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), Esquerda);
        End
        Else
        Begin
          pMesclar('A' + IntToStr(intCont), 'B' + IntToStr(intCont));
          pMesclar('C' + IntToStr(intCont), 'F' + IntToStr(intCont));
          Alinhamento('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), Esquerda);
        End;
      End;

      With qryEmpPdOr Do
      Begin
        pEscrever(ProximaLinha,01, FieldByName('EMP_NOMEMP').AsString);
        DefinirFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), CourierNew, 14);

        pEscrever(ProximaLinha,01, FieldByName('EMP_ENDERE').AsString);
        pEscrever(ProximaLinha,01, FieldByName('EMP_NOMCID').AsString);
        pEscrever(ProximaLinha,01, 'CNPJ: ' + fFormataCpfCgc(FieldByName('EMP_C_G_C_').AsString, FPais) +
                             ' | IE: ' + FieldByName('EMP_I_E_S_').AsString);
        pEscrever(ProximaLinha,01, FieldByName('EMP_EMAILC').AsString);
        pEscrever(ProximaLinha,01, 'Fone: ' + FieldByName('EMP_FONE01').AsString +
                             ' | Fax: ' + FieldByName('EMP_F_A_X_').AsString);
      End;

      ProximaLinha;
      pEscrever(ProximaLinha,01, 'DEPARTAMENTO DE COMPRAS');

      pEscrever(ProximaLinha,01, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc = 'PD',
                                     'PEDIDO DE COMPRA',
                                     'ORÇAMENTO'));

      DefinirFonte('A' + IntToStr(LinhaAtual-1), strUltCol + IntToStr(LinhaAtual), CourierNew, 14);


      With qryPedOrc Do
      Begin
        ProximaLinha;

        If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc = 'PD' Then
          pEscrever(ProximaLinha, 01, 'Pedido Nro. ' + TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNumPed)
        Else
          pEscrever(ProximaLinha, 01, 'Orçamento Nro. ' + TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNumPed);
        pEscrever(ProximaLinha, 01, 'Nome:   ' + FieldByName('FOR_NOMFOR').AsString);
        DefinirFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), CourierNew, 14);
        pEscrever(ProximaLinha, 01, 'Endereço:  ' + FieldByName('FOR_ENDERE').AsString);
        pEscrever(LinhaAtual,03, 'Bairro:    ' + FieldByName('FOR_BAIRRO').AsString);
        pEscrever(ProximaLinha, 01, 'Município: ' + FieldByName('FOR_NOMCID').AsString);
        pEscrever(LinhaAtual,03, 'C.E.P.:    ' + fFormataCEP(FieldByName('FOR_C_E_P_').AsString));
        pEscrever(ProximaLinha, 01, 'CNPJ:      ' + fFormataCpfCgc(FieldByName('FOR_C_G_C_').AsString, FPais));
        pEscrever(LinhaAtual,03, 'I.E.:      ' + FieldByName('FOR_I_E_S_').AsString);
        pEscrever(ProximaLinha, 01, 'Fone:      ' + fFormataFone(FieldByName('FOR_FONE01').AsString));
        pEscrever(LinhaAtual,03, 'Atenção:   ' + FieldByName('PCG_ATENCA').AsString);
        pEscrever(ProximaLinha, 01, 'Fax:       ' + FieldByName('FOR_F_A_X_').AsString);
        pEscrever(LinhaAtual,03, 'Entrega:   ' + FieldByName('PCG_DTAENT').AsString);
        pEscrever(LinhaAtual,03, 'Data faturamento:   ' + FieldByName('PCG_DTAFAT').AsString);


        strConPag := (fFormataCondPag(qryPedOrc.FieldByName('PCG_CONPAG').AsString));
        strConPag := Copy(strConPag, 5, Length(strConPag)) + ' D.D.L.';
        pEscrever(ProximaLinha, 01, 'Cond.Pgto: ' + strConPag + IIF(FieldByName('PCG_PAGVIS').AsString = 'S', '     PGTO A VISTA', ''));

        pEscrever(LinhaAtual,03, 'Contato:   ' + FieldByName('FOR_CONTAT').AsString);
        ProximaLinha;
      End;

      With qryItensPdOr Do
      Begin

        ProximaLinha;

        For intCont := 1 To intQtdCol Do
        Begin
          pEscrever(LinhaAtual, intCont, arrDadosPed[Pred(intCont), 01]);
          Negrito(LinhaAtual, intCont, True);

          If FieldByName(arrDadosPed[Pred(intCont), 02]).DataType = ftFloat Then
            Alinhamento(LinhaAtual,intCont, Direita)
          Else
            Alinhamento(LinhaAtual,intCont, Esquerda);

        End;

        CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Preto);
        CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
        Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

        {O alinhamento e o formato numerico de cada coluna dependem do tipo do campo
         (fixo), nao do registro atual - calculados uma unica vez aqui e aplicados em
         lote por coluna (cobrindo toda a faixa de linhas de dados) depois do loop de
         itens, em vez de celula a celula a cada linha. Reduz de (linhas x colunas)
         para (colunas) chamadas de automacao OLE ao Excel.
         O VALOR de cada celula continua sendo escrito individualmente (pEscreverDireto,
         nao em lote via array) - a escrita em lote (VarArrayCreate/VarArrayLock +
         Range.Value := array) foi implementada e chegou a medir tempo bem menor, mas o
         array nunca populava o Excel de fato mesmo com o conteudo correto do lado do
         Delphi; foi abandonada apos 5 tentativas de correcao sem sucesso. Nao reintroduzir
         sem antes reler o historico. Verificar Nota 2 - Req. 459077}
        SetLength(arrAlinhaColuna, intQtdCol + 1);
        SetLength(arrTemAlinhaColuna, intQtdCol + 1);
        blnTemColunaData := False;
        SetLength(arrColsData, 0);
        For intCont := 1 To intQtdCol Do
        Begin
          arrTemAlinhaColuna[intCont] := True;
          If arrDadosPed[Pred(intCont), 02] = 'ITE_CONMED' Then
          Begin
            arrTemAlinhaColuna[intCont] := False; {mantem comportamento original: essa coluna nunca teve Alinhamento explicito}
            {Com chkAplPro.Checked cada registro pode inserir linhas extras via ProximaLinha,
             quebrando a faixa fixa LinhaAtual+1..LinhaAtual+RecordCount. Verificar Nota 3 -
             Req. 459077}
            If Not chkAplPro.Checked Then
              FormatoNumerico(fGetLetraAlfa(intCont) + IntToStr(LinhaAtual + 1),
                              fGetLetraAlfa(intCont) + IntToStr(LinhaAtual + RecordCount), '#,##0.00');
          End
          Else If arrDadosPed[Pred(intCont), 02] = 'ITE_SALDOS' Then
          Begin
            arrAlinhaColuna[intCont] := Direita;
            {Verificar Nota 3 - Req. 459077 (chkAplPro.Checked quebra a faixa fixa)}
            If Not chkAplPro.Checked Then
              FormatoNumerico(fGetLetraAlfa(intCont) + IntToStr(LinhaAtual + 1),
                              fGetLetraAlfa(intCont) + IntToStr(LinhaAtual + RecordCount), '#,##0.000');
          End
          Else If FieldByName(arrDadosPed[Pred(intCont), 02]).DataType = ftFloat Then
          Begin
            arrAlinhaColuna[intCont] := Direita;
            {IVA fica de fora - o codigo original forcava texto (aspas + 4 casas) para nao
             deixar o Excel arredondar/reformatar; manter como string preserva o
             comportamento visual exato desse caso especifico.}
            {Verificar Nota 3 - Req. 459077 (chkAplPro.Checked quebra a faixa fixa)}
            If (arrDadosPed[Pred(intCont), 01] <> 'IVA') And (Not chkAplPro.Checked) Then
              FormatoNumerico(fGetLetraAlfa(intCont) + IntToStr(LinhaAtual + 1),
                              fGetLetraAlfa(intCont) + IntToStr(LinhaAtual + RecordCount), '#,##0.00');
          End
          Else If FieldByName(arrDadosPed[Pred(intCont), 02]).DataType In [ftDate, ftDateTime] Then
          Begin
            arrAlinhaColuna[intCont] := Esquerda;
            blnTemColunaData := True;
            {Acumula no array em vez de sobrescrever intColData - ver declaracao
             da variavel. Verificar Nota 5 - Req. 459077}
            SetLength(arrColsData, Length(arrColsData) + 1);
            arrColsData[High(arrColsData)] := intCont;
          End
          Else
            arrAlinhaColuna[intCont] := Esquerda;
        End;

        intPriLinhaDados := LinhaAtual + 1;
        intUltLinhaDados := intPriLinhaDados + RecordCount - 1;

        {Marca a coluna de data como texto ANTES de escrever os valores - precisa ser
         antes, senao o Excel converte a string 'DD/MM/AAAA' de volta para numero de
         data serial ao receber o valor com o formato de celula ainda em "Geral". So valido
         em faixa fixa quando chkAplPro.Checked = False - Verificar Nota 3 - Req. 459077.}
        {Aplica o guard de formato texto para CADA coluna de data (nao so a ultima) -
         Verificar Nota 5 - Req. 459077}
        If blnTemColunaData And (Not chkAplPro.Checked) Then
          For intCont := 0 To High(arrColsData) Do
            FormatoNumerico(fGetLetraAlfa(arrColsData[intCont]) + IntToStr(intPriLinhaDados),
                            fGetLetraAlfa(arrColsData[intCont]) + IntToStr(intUltLinhaDados), '@');

        First;

        While Not Eof Do
        Begin

          ProximaLinha;

          For intCont := 1 To intQtdCol Do
          Begin

            If arrDadosPed[Pred(intCont), 02] =  'ITE_CONMED' Then
            Begin
              curMedia := 0;
              If (Assigned(cdsItensGiro)) And
                 (cdsItensGiro.Active)   And
                 (cdsItensGiro.Locate('ITE_CODITE',FieldByName(arrDadosPed[00, 02]).AsString,[])) Then
                curMedia :=  cdsItensGiro.FieldByName('ITE_MEDIA_').AsCurrency;
              pEscreverDireto(intCont, FormatFloat('#,##0.00', curMedia));
            End
            Else If arrDadosPed[Pred(intCont), 02] =  'ITE_SALDOS' Then
            Begin
              fltSaldoDisp := FieldByName(arrDadosPed[Pred(intCont), 02]).AsFloat -
                              TSaldoReservado.New(
                                TReservaParametros.New()
                                  .EmpresaItem(VS_strCodEmp)
                                  .CodigoItem(FieldByName(arrDadosPed[00, 02]).AsString)
                                  .CodEmpresa(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.StrEmpDes)
                                ).fGetQuantidade();
              pEscreverDireto(intCont, FormatFloat('#,##0.000', fltSaldoDisp));
              {chkAplPro.Checked quebra a faixa fixa do lote de alinhamento - aplicar por
               linha aqui replica o comportamento original (pre-otimizacao). Verificar
               Nota 3 - Req. 459077}
              If chkAplPro.Checked Then
                Alinhamento(LinhaAtual, intCont, Direita);
            End

            Else If FieldByName(arrDadosPed[Pred(intCont), 02]).DataType = ftFloat Then
            Begin
              If arrDadosPed[Pred(intCont), 01] = 'IVA' Then
                pEscreverDireto(intCont, '''' + FormatFloat('#,##0.0000', FieldByName(arrDadosPed[Pred(intCont), 02]).AsFloat))
              Else pEscreverDireto(intCont, FormatFloat('#,##0.00', FieldByName(arrDadosPed[Pred(intCont), 02]).AsFloat));
              {Verificar Nota 3 - Req. 459077}
              If chkAplPro.Checked Then
                Alinhamento(LinhaAtual, intCont, Direita);
            End

            Else If FieldByName(arrDadosPed[Pred(intCont), 02]).DataType In [ftDate, ftDateTime] Then
            Begin
              {Verificar Nota 3 - Req. 459077 - com chkAplPro.Checked o formato de texto precisa
               ser aplicado nesta linha especifica antes de escrever, pois a linha muda a cada
               registro (nao e mais uma faixa fixa conhecida antes do loop)}
              If chkAplPro.Checked Then
                FormatoNumerico(LinhaAtual, intCont, '@');
              pEscreverDireto(intCont, FormatDateTime('DD/MM/YYYY', FieldByName(arrDadosPed[Pred(intCont), 02]).AsDateTime));
              If chkAplPro.Checked Then
                Alinhamento(LinhaAtual, intCont, Esquerda);
            End

            Else If arrDadosPed[Pred(intCont), 02] = 'ITE_REFERE' Then
            Begin
              If Not fEmptyStr(FieldByName(arrDadosPed[Pred(intCont), 02]).AsString) Then
                pEscreverDireto(intCont, '''' + FieldByName(arrDadosPed[Pred(intCont), 02]).AsString)
              Else
                pEscreverDireto(intCont, '  ');
              {Verificar Nota 3 - Req. 459077}
              If chkAplPro.Checked Then
                Alinhamento(LinhaAtual, intCont, Esquerda);
            End

            Else
            Begin
              strValue := FieldByName(arrDadosPed[Pred(intCont), 02]).AsString;
              If fEmptyStr(FieldByName(arrDadosPed[Pred(intCont), 02]).AsString) Then
                strValue := '';

              pEscreverDireto(intCont, IIf(strValue <> '', '''' , '')+ strValue);
              {Verificar Nota 3 - Req. 459077}
              If chkAplPro.Checked Then
                Alinhamento(LinhaAtual, intCont, Esquerda);
            End;

          End;

          Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

          If RecNo Mod 2 = 0 Then
            CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Cinza);

          {*************************************}
          {* IMPRESSÃO DA APLICAÇÃO DO PRODUTO *}
          {*************************************}
          If (chkAplPro.Checked) Then
          Begin
            stlAplicacao.Text := AnsiReplaceStr(FieldByName('ITE_APLFAB').AsString, STRING_QUEBRA, #13#10);

            Mesclar('A' + IntToStr(LinhaAtual + 1), strUltCol + IntToStr(LinhaAtual + 1));
            pEscrever(ProximaLinha,  01, 'Aplicação / Cód. Fábrica: ');
            Negrito('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True);
            Bordas ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual),True,True,True,False);

            intPriLin := LinhaAtual;

            For intCont := 1 To stlAplicacao.Count Do
            Begin
              Mesclar('A' + IntToStr(LinhaAtual + 1), strUltCol + IntToStr(LinhaAtual + 1));
              pEscrever(ProximaLinha, 01, stlAplicacao.Strings[intCont-1]);
              Bordas ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual),True,True,False,False);
            End;

            If RecNo Mod 2 = 0 Then
              CorFundo('A' + IntToStr(intPriLin), strUltCol + IntToStr(LinhaAtual), Cinza);

            Bordas ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual),True,True,False,True);
          End;

          Next;
        End;

        {Aplica o alinhamento por coluna em lote (uma faixa cobrindo todas as linhas de
         dado), calculado uma unica vez antes do loop - reduz de (linhas x colunas) para
         (colunas) chamadas OLE. So valido quando chkAplPro.Checked = False (cada registro
         ocupa exatamente 1 linha); com chkAplPro.Checked o alinhamento ja foi aplicado
         linha a linha dentro do loop acima. Verificar Nota 2 e Nota 3 - Req. 459077}
        If Not chkAplPro.Checked Then
          For intCont := 1 To intQtdCol Do
            If arrTemAlinhaColuna[intCont] Then
              Alinhamento(fGetLetraAlfa(intCont) + IntToStr(intPriLinhaDados),
                          fGetLetraAlfa(intCont) + IntToStr(intUltLinhaDados),
                          arrAlinhaColuna[intCont]);

      End;

      With qryPedOrc Do
      Begin
        ProximaLinha;
        LinAux := LinhaAtual;

        For intCont := LinAux To LinAux + NRO_LIN_SOMA Do
        Begin
          { //pMesclar('K' + IntToStr(intCont), 'L' + IntToStr(intCont));
          //pMesclar('M' + IntToStr(intCont), 'O' + IntToStr(intCont));
          Negrito('K' + IntToStr(intCont), 'O' + IntToStr(intCont), True); }
          Alinhamento(fGetLetraAlfa(intQtdCol-4)+ IntToStr(intCont), strUltCol + IntToStr(intCont), Direita);
          Alinhamento(fGetLetraAlfa(intQtdCol-2) + IntToStr(intCont), strUltCol + IntToStr(intCont), Direita);

          If intQtdCol > 12 Then
          Begin
            pMesclar('K' + IntToStr(intCont), 'L' + IntToStr(intCont));
            pMesclar(fGetLetraAlfa(intQtdCol-2) + IntToStr(intCont), fGetLetraAlfa(intQtdCol) + IntToStr(intCont));
            Negrito('K' + IntToStr(intCont), fGetLetraAlfa(intQtdCol-1) + IntToStr(intCont), True);
            Alinhamento('K' + IntToStr(intCont), 'L' + IntToStr(intCont), Direita);
            Alinhamento(fGetLetraAlfa(intQtdCol-2) + IntToStr(intCont), fGetLetraAlfa(intQtdCol-1) + IntToStr(intCont), Esquerda);
          End;
        End;

        qryItensPdOr.First;
        While Not qryItensPdOr.Eof Do
        Begin
			    fltTotIte := fltTotIte + qryItensPdOr.FieldByName('TOTITE').AsFloat;
          fltTotQtd := fltTotQtd + qryItensPdOr.FieldByName('PCD_QTDITE').AsFloat;
			    fltTotIpi := fltTotIpi + qryItensPdOr.FieldByName('TOTIPI').AsFloat;
			    fltTotSub := fltTotSub + qryItensPdOr.FieldByName('TOTSUB').AsFloat;
			    fltTotDar := fltTotDar + qryItensPdOr.FieldByName('TOTDAR').AsFloat;
			    fltTotSubFcp := fltTotSubFcp + qryItensPdOr.FieldByName('SUBFCP').AsFloat;
			    fltTotDes := fltTotDes + qryItensPdOr.FieldByName('ICMDES').AsFloat;
			    fltTotPis := fltTotPis + qryItensPdOr.FieldByName('DESPIS').AsFloat;
          fltTotCbs := fltTotCbs + qryItensPdOr.FieldByName('TOTCBS').AsFloat;
          fltTotIbs := fltTotIbs + qryItensPdOr.FieldByName('TOTIBS').AsFloat;
          fltTotIs  := fltTotIs  + qryItensPdOr.FieldByName('TOT_IS').AsFloat;
			    qryItensPdOr.Next;
        End;

        fltTotGer := fltTotIte + fltTotIpi + fltTotSub + fltTotSubFcp - fltTotDes - fltTotPis;

        If fSomarNovosImpostosDaReformaAoValorContabil Then
          fltTotGer := fltTotGer + fltTotCbs + fltTotIbs + fltTotIs;

        intColSomas := intQtdCol - 2;

        If blnExcRes Then
        Begin
          For intCont := LinAux To LinAux + NRO_LIN_SOMA Do
          Begin
            pMesclar('A' + IntToStr(intCont), 'B' + IntToStr(intCont));
            pMesclar('C' + IntToStr(intCont), 'D' + IntToStr(intCont));
            pMesclar('F' + IntToStr(intCont), 'H' + IntToStr(intCont));
            pMesclar('I' + IntToStr(intCont), 'J' + IntToStr(intCont));
            Negrito('A' + IntToStr(intCont), 'J' + IntToStr(intCont), True);
            Alinhamento('A' + IntToStr(intCont), 'B' + IntToStr(intCont), Esquerda);
            Alinhamento('C' + IntToStr(intCont), 'D' + IntToStr(intCont), Direita);
            Alinhamento('F' + IntToStr(intCont), 'H' + IntToStr(intCont), Esquerda);
            Alinhamento('I' + IntToStr(intCont), 'J' + IntToStr(intCont), Direita);
          End;

          If (blnSomIte) Then //MF: 321197 - 01/03/24
          Begin
            pEscrever(ProximaLinha,  1, 'Soma dos Itens: ');
            pEscrever(LinhaAtual, 3, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotIte)));
          End;

          pEscrever(LinhaAtual,  6, 'Quantidades dos Itens');
          pEscrever(LinhaAtual, 9, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('00',  qryItensPdOr.RecNo)));

          If (blnValTPC) Then //MF: 321197 - 01/03/24
          Begin
            pEscrever(ProximaLinha,  1, 'Soma do I.P.I.: ');
            pEscrever(LinhaAtual, 3, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotIPI)));

            pEscrever(LinhaAtual,  6, 'Quantidade Peças: ');
            pEscrever(LinhaAtual, 9, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotQtd)));

            pEscrever(ProximaLinha,  1, 'Valor da Susbt: ');
            pEscrever(LinhaAtual, 3, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotSUB)));

            pEscrever(ProximaLinha,  1, 'Valor da Susbt FCP: ');
            pEscrever(LinhaAtual, 3, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotSUBFcp)));

            If blnZonaFranca Then
            Begin
              pEscrever(ProximaLinha,  1, 'Desconto PIS/COFINS: ');
              pEscrever(LinhaAtual, 3, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotPis)));

              pEscrever(ProximaLinha,  1, 'ICMS Desonerado: ');
              pEscrever(LinhaAtual, 3, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotDes)));
            End;

            pEscrever(ProximaLinha,  1, 'Valor do Frete: ');
            pEscrever(LinhaAtual, 3, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', FieldByName('PCG_VALFRE').AsFloat)));

            If fSomarNovosImpostosDaReformaAoValorContabil Then
            Begin
              pEscrever(ProximaLinha,  1, 'Valor CBS: ');
              pEscrever(LinhaAtual, 3, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotCbs)));

              pEscrever(ProximaLinha,  1, 'Valor IBS: ');
              pEscrever(LinhaAtual, 3, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotIbs)));

              pEscrever(ProximaLinha,  1, 'Valor IS: ');
              pEscrever(LinhaAtual, 3, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotIs)));
            End;

            pEscrever(ProximaLinha,  1, 'Total do Pedido: ');
            pEscrever(LinhaAtual, 3, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotGER +
                                                              FieldByName('PCG_VALFRE').AsFloat +
                                                              FieldByName('PCG_DESACE').AsFloat )));
            If blnDarRor Then
            Begin
              pEscrever(ProximaLinha,  1, 'Valor da DARE: ');
              pEscrever(LinhaAtual, 3, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotDar)));
            End;
          End;
        End
        Else
        Begin
          If (blnSomIte) Then //MF: 321197 - 01/03/24
          Begin
            pEscrever(ProximaLinha,  intColSomas-2, 'Soma dos Itens: ');
            pEscrever(LinhaAtual, intColSomas , IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotIte)));
          End;

          pEscrever(ProximaLinha,  intColSomas-2, 'Soma das Quantidades: ');
          pEscrever(LinhaAtual, intColSomas , IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotQtd)));

          If (blnValTPC) Then //MF: 321197 - 01/03/24
          Begin
            pEscrever(ProximaLinha,  intColSomas-2, 'Soma do I.P.I.: ');
            pEscrever(LinhaAtual, intColSomas , IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotIPI)));

            pEscrever(ProximaLinha,  intColSomas-2, 'Valor da Susbt: ');
            pEscrever(LinhaAtual, intColSomas , IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotSUB)));

            pEscrever(ProximaLinha,  intColSomas-2, 'Valor da Susbt FCP: ');
            pEscrever(LinhaAtual, intColSomas , IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotSUBFcp)));

            If blnZonaFranca Then
            Begin
              pEscrever(ProximaLinha,  intColSomas-2, 'Desconto PIS/COFINS: ');
              pEscrever(LinhaAtual, intColSomas , IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotPis)));

              pEscrever(ProximaLinha,  intColSomas-2, 'ICMS Desonerado: ');
              pEscrever(LinhaAtual, intColSomas , IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotDes)));
            End;

            pEscrever(ProximaLinha,  intColSomas-2, 'Valor do Frete: ');
            pEscrever(LinhaAtual, intColSomas , IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', FieldByName('PCG_VALFRE').AsFloat)));

            If fSomarNovosImpostosDaReformaAoValorContabil Then
            Begin
              pEscrever(ProximaLinha,  intColSomas-2, 'Valor CBS: ');
              pEscrever(LinhaAtual, intColSomas , IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotCbs)));

              pEscrever(ProximaLinha,  intColSomas-2, 'Valor IBS: ');
              pEscrever(LinhaAtual, intColSomas , IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotIbs)));

              pEscrever(ProximaLinha,  intColSomas-2, 'Valor IS: ');
              pEscrever(LinhaAtual, intColSomas , IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotIs)));
            End;

            pEscrever(ProximaLinha,  intColSomas-2, 'Total do Pedido: ');
            pEscrever(LinhaAtual, intColSomas , IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotGER +
                                                              FieldByName('PCG_VALFRE').AsFloat +
                                                              FieldByName('PCG_DESACE').AsFloat )));
            If blnDarRor Then
            Begin
              pEscrever(ProximaLinha,  intColSomas-2, 'Valor da DARE: ');
              pEscrever(LinhaAtual, intColSomas , IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre, '-', FormatFloat('##,#0.00', fltTotDar)));
            End;
          End;
        End;
        ProximaLinha;
        Bordas('A' + IntToStr(LinAux), strUltCol + IntToStr(LinhaAtual), True, True, True, True);
      End;

      With qryTranPdOr Do
      Begin
        ProximaLinha;
        LinAux := LinhaAtual;

        If intQtdCol <= 6 Then
        Begin
          For intCont := LinAux To LinAux + NRO_LIN_TRANSP Do
          Begin
            pMesclar('A' + IntToStr(intCont), 'A' + IntToStr(intCont));
            pMesclar('D' + IntToStr(intCont), 'D' + IntToStr(intCont));
            Alinhamento('A' + IntToStr(intCont), 'O' + IntToStr(intCont), Esquerda);
          End;

          pEscrever(ProximaLinha,  01, 'TRANSPORTADORA');
          DefinirFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), CourierNew, 14);
          pEscrever(ProximaLinha, 01,              FieldByName('TRA_NOMTRA').AsString);
          pEscrever(ProximaLinha, 01, 'Endereço:  ' +              FieldByName('TRA_ENDERE').AsString);
          pEscrever(ProximaLinha, 01, 'Bairro:    ' +             FieldByName('TRA_BAIRRO').AsString +
                                      '  C.E.P.:  ' + fFormataCEP(FieldByName('TRA_C_E_P_').AsString ));
          pEscrever(ProximaLinha, 01, 'Município: ' +              FieldByName('TRA_NOMCID').AsString);
          pEscrever(ProximaLinha, 01, 'Fone/Fax:  ' + fFormataFone(FieldByName('TRA_FONE01').AsString) +
                                       '  /  '      + fFormataFone(FieldByName('TRA_F_A_X_').AsString));
          pEscrever(ProximaLinha, 01, '');
          pEscrever(ProximaLinha,   01, 'TRANSPORTADOR REDESPACHO');
          DefinirFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), CourierNew, 14);
          pEscrever(ProximaLinha,   01, qryTranRedes.FieldByName('TRA_NOMTRA').AsString);
          pEscrever(ProximaLinha,   01, 'Endereço:  ' + qryTranRedes.FieldByName('TRA_ENDERE').AsString);
          pEscrever(ProximaLinha,   01, 'Bairro:    ' +             qryTranRedes.FieldByName('TRA_BAIRRO').AsString +
                                      '  C.E.P.:  ' + fFormataCEP(qryTranRedes.FieldByName('TRA_C_E_P_').AsString));
          pEscrever(ProximaLinha,   01, 'Município: ' + qryTranRedes.FieldByName('TRA_NOMCID').AsString);
          pEscrever(ProximaLinha,   01, 'Fone/Fax:  ' + fFormataFone(qryTranRedes.FieldByName('TRA_FONE01').AsString) +
                                       '  /  '      + fFormataFone(qryTranRedes.FieldByName('TRA_F_A_X_').AsString));

          ProximaLinha;
          Negrito('A' + IntToStr(LinAux+1), strUltCol + IntToStr(LinAux+2), True);
          Negrito('A' + IntToStr(LinAux+8), strUltCol + IntToStr(LinAux+8), True);
          Bordas('A' + IntToStr(LinAux), strUltCol + IntToStr(LinhaAtual), True, True, True, True);
        End
        Else
        Begin
          For intCont := LinAux To LinAux + NRO_LIN_ENTRE Do
          Begin
            pMesclar('A' + IntToStr(intCont), 'C' + IntToStr(intCont));
            Alinhamento('A' + IntToStr(intCont), 'C' + IntToStr(intCont), Esquerda);
          End;

          pEscrever(ProximaLinha,  01, 'TRANSPORTADORA');
          DefinirFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), CourierNew, 14);
          pEscrever(LinhaAtual,    04, 'TRANSPORTADOR REDESPACHO');
          DefinirFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), CourierNew, 14);

          pEscrever(ProximaLinha, 01,              FieldByName('TRA_NOMTRA').AsString);
          pEscrever(LinhaAtual,   04, qryTranRedes.FieldByName('TRA_NOMTRA').AsString);

          pEscrever(ProximaLinha, 01, 'Endereço:  ' +              FieldByName('TRA_ENDERE').AsString);
          pEscrever(LinhaAtual,   04, 'Endereço:  ' + qryTranRedes.FieldByName('TRA_ENDERE').AsString);

          pEscrever(ProximaLinha, 01, 'Bairro:    ' +             FieldByName('TRA_BAIRRO').AsString +
                                      '  C.E.P.:  ' + fFormataCEP(FieldByName('TRA_C_E_P_').AsString ));
          pEscrever(LinhaAtual,   04, 'Bairro:    ' +             qryTranRedes.FieldByName('TRA_BAIRRO').AsString +
                                      '  C.E.P.:  ' + fFormataCEP(qryTranRedes.FieldByName('TRA_C_E_P_').AsString));

          pEscrever(ProximaLinha, 01, 'Município: ' +              FieldByName('TRA_NOMCID').AsString);
          pEscrever(LinhaAtual,   04, 'Município: ' + qryTranRedes.FieldByName('TRA_NOMCID').AsString);

          pEscrever(ProximaLinha, 01, 'Fone/Fax:  ' + fFormataFone(FieldByName('TRA_FONE01').AsString) +
                                       '  /  '      + fFormataFone(FieldByName('TRA_F_A_X_').AsString));
          pEscrever(LinhaAtual,   04, 'Fone/Fax:  ' + fFormataFone(qryTranRedes.FieldByName('TRA_FONE01').AsString) +
                                       '  /  '      + fFormataFone(qryTranRedes.FieldByName('TRA_F_A_X_').AsString));

          ProximaLinha;
          Negrito('A' + IntToStr(LinAux+1), 'O' + IntToStr(LinAux+2), True);
          Bordas('A' + IntToStr(LinAux), strUltCol + IntToStr(LinhaAtual), True, True, True, True);
        End;
      End;

      With qryPedOrc Do
      Begin
        ProximaLinha;
        LinAux := LinhaAtual;

        For intCont := LinAux To LinAux + NRO_LIN_ENTRE Do
        Begin
          pMesclar('A' + IntToStr(intCont), strUltCol + IntToStr(intCont));
          Alinhamento('A' + IntToStr(intCont), 'C' + IntToStr(intCont), Esquerda);
        End;

        pEscrever(ProximaLinha,  01, 'LOCAL DE ENTREGA');
        DefinirFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), CourierNew, 14);
        Negrito('A' + IntToStr(LinAux+1), strUltCol + IntToStr(LinAux+1), True);
        pEscrever(ProximaLinha,  01, 'A/C:       ' + FieldByName('PCG_NOMENT').AsString);
        pEscrever(ProximaLinha,  01, 'Endereço:  ' + FieldByName('PCG_ENDENT').AsString);
        pEscrever(ProximaLinha,  01, 'Município: ' + FieldByName('PCG_CIDENT').AsString);
        Bordas('A' + IntToStr(LinAux), strUltCol + IntToStr(LinhaAtual), True, True, True, True);

        ProximaLinha;

        pEscrever(ProximaLinha, 01, 'COMPRADOR: ' + FieldByName('COMPRA').AsString);

        If Not fEmptyStr(fieldbyname('OPE_E_MAIL').AsString) Then
          pEscrever(ProximaLinha,  01, 'EMAIL: ' + fieldbyname('OPE_E_MAIL').AsString);

        If Not fEmptyStr(fieldbyname('OPE_FONE01').AsString) Then
        Begin
          If fEmptyStr(fieldbyname('OPE_RAMAL1').AsString) Then
            pEscrever(ProximaLinha,  01, 'TELEFONE: ' + fFormataFone(fieldbyname('OPE_FONE01').AsString))
          Else
            pEscrever(ProximaLinha,  01, 'TELEFONE: ' + fFormataFone(fieldbyname('OPE_FONE01').AsString) +
                               ' RAMAL: ' + fieldbyname('OPE_RAMAL1').AsString);
        End;

        If Not fEmptyStr(fieldbyname('OPE_NEXTEL').AsString) Then
          pEscrever(ProximaLinha,  01, 'ID-NEXTEL: ' + fieldbyname('OPE_NEXTEL').AsString);

                Bordas('A' + IntToStr(LinAux), strUltCol + IntToStr(LinhaAtual), True, True, True, True);
        ProximaLinha;
        LinAux := LinhaAtual;

        pMesclar('A' + IntToStr(LinhaAtual+1), 'C' + IntToStr(LinhaAtual+1));
        pEscrever(ProximaLinha, 01, 'OBSERVAÇÕES');
        DefinirFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), CourierNew, 14);

        pMesclar('A' + IntToStr(LinhaAtual+1), 'C' + IntToStr(LinhaAtual+1));

        pEscrever(ProximaLinha, 02,IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc = 'PD',
                                      'FAVOR CONFIRMAR O RECEBIMENTO DO PEDIDO - MENCIONAR O NÚMERO DO PEDIDO NA NOTA FISCAL.',
                                      'FAVOR CONFIRMAR O RECEBIMENTO DO ORÇAMENTO - MENCIONAR O NÚMERO DO ORÇAMENTO NA NOTA FISCAL.'));

        For intCont := LinhaAtual + 1 To LinhaAtual + 1 + NRO_LIN_OBS Do
        Begin
          pMesclar('B' + IntToStr(intCont), strUltCol + IntToStr(intCont));
          Alinhamento('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), Esquerda);
        End;

        pEscrever(ProximaLinha, 02, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc = 'OR', FieldByName('PCG_OBS001').AsString, FieldByName('PCG_OBSPD1').AsString));
        pEscrever(ProximaLinha, 02, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc = 'OR', FieldByName('PCG_OBS002').AsString, FieldByName('PCG_OBSPD2').AsString));
        pEscrever(ProximaLinha, 02, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc = 'OR', FieldByName('PCG_OBS003').AsString, FieldByName('PCG_OBSPD3').AsString));
        pEscrever(ProximaLinha, 02, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc = 'OR', FieldByName('PCG_OBS004').AsString, FieldByName('PCG_OBSPD4').AsString));
        pEscrever(ProximaLinha, 02, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc = 'OR', FieldByName('PCG_OBS005').AsString, FieldByName('PCG_OBSPD5').AsString));
        pEscrever(ProximaLinha, 02, IIf(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc = 'OR', FieldByName('PCG_OBS006').AsString, FieldByName('PCG_OBSPD6').AsString));
        ProximaLinha;

        Negrito('A' + IntToStr(LinAux+1), strUltCol + IntToStr(LinAux+2), True);

        Bordas('A' + IntToStr(LinAux), strUltCol + IntToStr(LinhaAtual), True, True, True, True);
      End;

      pMesclar('A' + IntToStr(LinhaAtual + 1), strUltCol + IntToStr(LinhaAtual + 1));
      pEscrever(ProximaLinha, 01, 'Desenvolvido por Citel Software');
      Alinhamento('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Direita);
      Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True, True, True, True);

      OrientacaoPagina(Paisagem);

      AutoAjuste;

      SalvarArquivo(True);
      objExcel.FblnShowOnTerminate := blnAbriArquivoExcelAoFinalizar;
    End;
    Finally
      {Fechar (FecharArquivo/Quit) e liberar aqui, mesmo em caso de excecao, evita
       deixar um processo EXCEL.EXE orfao. Verificar Nota 4 - Req. 459077}
      If Assigned(objExcel) Then
      Begin
        Try
          objExcel.FecharArquivo;
        Except
          {Ignorado propositalmente: o objetivo aqui e so garantir que o processo
           Excel nao fique orfao; um erro ao fechar (por exemplo, se o automation
           object ja estiver em estado invalido por causa do erro original) nao
           deve mascarar/substituir a excecao original que esta sendo propagada.}
        End;
        FreeAndNil(objExcel);
      End;
    End;

    FreeAndNil(cdsItensGiro);
    FreeAndNil(qryConsMed);
    FreeAndNil(qryTranPdOr);
    FreeAndNil(qryTranRedes);
    FreeAndNil(qryItensPdOr);
    FreeAndNil(qryEmpPdOr);
    FreeAndNil(qryPedOrc);
    FreeAndNil(stlAplicacao);

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TfrmPnlDadosPedCompra.fGerarExcel');
    End;
  End;
end;

function TfrmPnlDadosPedCompra.fRetornaEmpresaDestino(strNumPed, strEspDoc, strCodEmp: String): String;
Var
  strSQL: String;
  qryGen: TUniQuery;
begin
  Try

    qryGen := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  PCG_EMPDES ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PCMGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCG_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCG_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  PCG_CODEMP = :CODEMP ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMPED').AsString := strNumPed;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;
      Result := Fieldbyname('PCG_EMPDES').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;

function TfrmPnlDadosPedCompra.fGerarPDF(blnVisualizar: Boolean; AForcePathPDF: String = ''): String;
var strDtaVen: String;
    strDtaFat,
    strCndPag: String;
    dtaDtaAux: TDate;
    arrDuplicata: TarrDuplicata;
    intQtdPar: Integer;
    curVTotal: Currency;
    intContador: Integer;
    qryCons: TUniQuery;

Begin
  strDtaVen := '';
  If (TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodLay <> '') And
     (TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImpDtaVen) Then
  Begin
    qryCons := fCriaQuery;
    Try
      qryCons.SQL.Add('SELECT PCG_DTAFAT, PCG_CONPAG ');
      qryCons.SQL.Add('  FROM PCMGER ');
      qryCons.SQL.Add(' WHERE PCG_NUMPED = "'+TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNumPed+'"');
      qryCons.SQL.Add('   AND PCG_CODEMP = "'+TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp+'"');
      qryCons.SQL.Add('   AND PCG_ESPDOC = "'+TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc+'"');
      qryCons.SQL.Add('   AND PCG_NUMCTN = 0');
      qryCons.Open;
      strDtaFat := qryCons.FieldByName('PCG_DTAFAT').AsString;
      strCndPag := qryCons.FieldByName('PCG_CONPAG').AsString;
    Finally
      FreeAndNil(qryCons)
    End;

    If strDtaFat <> '' Then
    Begin
      pZeraDigDuplic(arrDuplicata);
      If VS_Date > StrToDate(strDtaFat) Then
        dtaDtaAux := VS_Date
      Else
        dtaDtaAux := StrToDate(strDtaFat);

      fDigDuplicSemTela(arrDuplicata,
                        intQtdPar,
                        curVTotal,
                        strCndPag,
                        0,
                        0,
                        False,
                        False,
                        dtaDtaAux,
                        False);

      For intContador := 0 To Length(arrDuplicata)-1 Do
      Begin
        If Not fEmptyStr(arrDuplicata[intContador].dtaDtaVen) Then
        Begin
          If (intContador = 0) Then
            strDtaVen := arrDuplicata[intContador].dtaDtaVen
          Else
            strDtaVen := strDtaVen + ' / '+ arrDuplicata[intContador].dtaDtaVen;
        End;
      End;
    End;
  End;

  Result := TImpressaoPedidoLayout.fNovo
           .fCodFor(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodFor)
           .fCodEmp(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp)
           .fNumPed(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNumPed)
           .fEspDoc(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc)
           .fVisPDF(False)
           .fDataDeVencimento(strDtaVen)
           .fQtdPen(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.tipQtdIte = tqpPendente)
           .fZonaFranca(fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')))
           .fMltCom(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnMltCmp)
           .fCodLay(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodLay)
           .fVaiGerarAquivoPDF(True)
           .fGerarPDF(AForcePathPDF)
           .fCaminhoPDF
End;

procedure TfrmPnlDadosPedCompra.pCarregarGiro(strAutoIncrem: String);
Var
  recDadGiro: TRecOpcoesGiro;
  oleItensMultiLojas: OleVariant;
Begin
  cdsItensGiro  := TUniClientDataSet.Create(Nil);
  Try
    FillChar(recDadGiro, SizeOf(recDadGiro), 0);
    recDadGiro.strPedMlj := 'S';
    recDadGiro.opcChamada := chaPedido;
    recDadGiro.strNomFrm := 'frmDigGiroEstoque';
    recDadGiro.cdsEmpSel := Null;
    recDadGiro.strValKey := strAutoIncrem;
    If Assigned (funProdutosGiro) Then
      cdsItensGiro.Data  := funProdutosGiro(recDadGiro, oleItensMultiLojas, true, false, false);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmPnlDadosPedCompra.pCarregarGiro]');
    End;
  End;
End;

function TfrmPnlDadosPedCompra.fTrataObservacoes(intQtdeCar : Integer; strObservacoes : String): String;
var
  strTextoUnico, strLinha: string;
  i, intRem: Integer;
begin
  Result := '';

  if intQtdeCar < 2 then
  begin
    Result := strObservacoes;
    Exit;
  end;

  strTextoUnico := StringReplace(strObservacoes, #13#10, ' | ', [rfReplaceAll]);
  strTextoUnico := StringReplace(strTextoUnico, #13, ' | ', [rfReplaceAll]);
  strTextoUnico := StringReplace(strTextoUnico, #10, ' | ', [rfReplaceAll]);

  i := 1;
  while i <= Length(strTextoUnico) do
  begin
    intRem := Length(strTextoUnico) - i + 1;

    if intRem >= intQtdeCar then
    begin
      strLinha := Copy(strTextoUnico, i, intQtdeCar - 1) + '-';
      if Length(strLinha) > intQtdeCar then
        strLinha := Copy(strLinha, 1, intQtdeCar);

      Result := Result + strLinha + sLineBreak;

      Inc(i, intQtdeCar - 1);
    end
    else
    begin
      strLinha := Copy(strTextoUnico, i, intRem);
      Result := Result + strLinha;

      Break;
    end;
  end;
end;


// Pedido sem preco: valor e aliquota de CBS / IBS / IS do item, bases e totais do rodape deixariam deduzir o preco.
// Os objetos so existem nos relatorios Reforma (frxPaginaReforma / frxPaginaPaisagemReforma)
procedure pOcultaReformaSemPreco(frxRelatorio: TfrxReport);
Const
  ARR_MEMOS_REFORMA: Array[0..14] Of String = ('rllAlqCbs', 'rllValCbs', 'rllAlqIbs', 'rllValIbs', 'rllAlqIs', 'rllValIs',
                                                'mmoBasCbs', 'mmoTotAlqCbs', 'mmoTotValCbs',
                                                'mmoBasIbs', 'mmoTotAlqIbs', 'mmoTotValIbs',
                                                'mmoBasIs', 'mmoTotAlqIs', 'mmoTotValIs');
Var
  intIndice: Integer;
  objMemo: TfrxMemoView;
Begin
  For intIndice := Low(ARR_MEMOS_REFORMA) To High(ARR_MEMOS_REFORMA) Do
  Begin
    If Not (frxRelatorio.FindObject(ARR_MEMOS_REFORMA[intIndice]) Is TfrxMemoView) Then
      Continue;

    objMemo := TfrxMemoView(frxRelatorio.FindObject(ARR_MEMOS_REFORMA[intIndice]));
    objMemo.Memo.Clear;
    objMemo.Memo.Add('-');
    objMemo.DisplayFormat.Kind := fkText;
  End;
End;

class function TGeraEmail.fGeraEmail(RecOpcaoImpressao: TRecOpcaoImpressao;
                                    strNumPed,
                                    strEspDoc,
                                    strEmpDes: String;
                                    strCodEmp: String;
                                    blnDarRor: Boolean;
                                    out strNomeArquivo: String;
                                    blnAplPro: Boolean;
                                    fGerarXLSBROffice: TGerarXLSBROffice = nil;
                                    strNomImp: String = '';
                                    strTipImp: string = '';
                                    blnEnvioAutomatico: Boolean = False): String;
  Var
    strSQL         : String;
    strExecutavel  : String;
    strDirImagem   : String;
    strSQLQtdOri   : String;
    strSQLQtdIte   : String;
    strSQLUnitar   : String;
    strDirGravacao : String;
    strPagVis      : String;
    mmoCompra      : TfrxMemoView;
    blnBrOffice    : Boolean;
    strTipFab      : String;
    strDesPro      : String;
    frxRelPed: TfrxReport;
    frmPnlDadosPedCompra: TfrmPnlDadosPedCompra;
    pgbProgresso: TcxProgressBar;
    intQtdCaracteres : Integer;

begin
  strDesPro := '';
  blnBrOffice := False;
  If RecOpcaoImpressao.tipQtdIte = tqpPendente Then
    strSQLQtdOri := ' (PCMDET.PCD_QTDITE - PCMDET.PCD_QTDBAI) '
  Else
    strSQLQtdOri := ' (PCMDET.PCD_QTDITE) ';

  If RecOpcaoImpressao.blnMltCmp Then
  Begin
    strSQLQtdIte := ' ( ' + strSQLQtdOri + ' / IF(IFNULL(CADITE.ITE_MLTCOM, 0) > 0, CADITE.ITE_MLTCOM, 1)) ';
    strSQLUnitar := ' (PCMDET.PCD_UNITAR * IF(IFNULL(CADITE.ITE_MLTCOM, 0) > 0, CADITE.ITE_MLTCOM, 1)) ';
  End Else
  Begin
    strSQLQtdIte := strSQLQtdOri;
    strSQLUnitar := ' PCMDET.PCD_UNITAR '   ;
  End;

  Try
    pCriarFormularios(TfrmQckHTMLPedidoCompra, frmQckHTMLPedidoCompra);
    Try
      frmQckHTMLPedidoCompra.qryRelatorio.Connection   := frmModulo.GetCurrentConnection;
      frmQckHTMLPedidoCompra.qryPedido.Connection      := frmModulo.GetCurrentConnection;
      frmQckHTMLPedidoCompra.qryEmpresa.Connection     := frmModulo.GetCurrentConnection;
      frmQckHTMLPedidoCompra.qryTransp.Connection      := frmModulo.GetCurrentConnection;
      frmQckHTMLPedidoCompra.qryTranspRedes.Connection := frmModulo.GetCurrentConnection;

      {Verifica se tem Excel instalado caso contrario gera o excel pelo BROffice e anexa ao email}
      If RecOpcaoImpressao.strTipExp = 'XLS' Then
      Begin
        //Requisito 91839 pede que seja igual o envio de email quando xls e a exportação de xls.
        blnBrOffice := True;
      End;
      If Not blnBrOffice Then
      Begin
        With frmQckHTMLPedidoCompra Do
        Begin
          {**********************************************}
          {* CARREGANDO OS DADOS DO TOPO DO PEDIDO      *}
          {*******************************************LU*}
          strSQL := '';
          strSQL := strSQL + 'SELECT ';
          strSQL := strSQL + '  PCMGER.*, ';
          strSQL := strSQL + '  CADFOR.*, ';
          strSQL := strSQL + '  CONCAT(FOR_ENDERE, CAST(IF(IFNULL(FOR_ENDNUM, "") <> "", FOR_ENDNUM, "") AS CHAR)) AS ENDERE, ';
          strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, " - ", CADCID.CID_ESTADO) AS FOR_NOMCID, ';
          strSQL := strSQL + '  IF(PCG_CODCMP IS NULL, PCG_COMPRA, OPE_NOMOPE) AS COMPRA, ';
          strSQL := strSQL + '  OPE_E_MAIL, ';
          strSQL := strSQL + '  OPE_FONE01, ';
          strSQL := strSQL + '  OPE_RAMAL1, ';
          strSQL := strSQL + '  OPE_NEXTEL  ';
          strSQL := strSQL + 'FROM ';
          strSQL := strSQL + '  PCMGER ';
          strSQL := strSQL + '  JOIN CADFOR ON (PCMGER.PCG_CODFOR = CADFOR.FOR_CODFOR) ';
          strSQL := strSQL + '  LEFT JOIN CADCID ON (CADFOR.FOR_CODCID = CADCID.CID_CODCID)';
          strSQL := strSQL + '  LEFT JOIN CADOPE ON OPE_CODOPE = PCG_CODCMP ';
          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '  PCMGER.PCG_NUMCTN = 0 AND ';
          strSQL := strSQL + '  PCMGER.PCG_NUMPED = :NUMPED AND ';
          strSQL := strSQL + '  PCMGER.PCG_ESPDOC = :ESPDOC AND ';
          strSQL := strSQL + '  PCMGER.PCG_CODEMP = :CODEMP ';

          With qryPedido Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('NUMPED').AsString := strNumPed;
            ParamByName('ESPDOC').AsString := strEspDoc;
            If fEmptyStr(strCodEmp) Then
              ParamByName('CODEMP').AsString := VS_strCodEmp
            Else
              ParamByName('CODEMP').AsString := strCodEmp;
            Open;

            TFloatField(FieldByName('PCG_TOTITE')).DisplayFormat := '#,##0.00';
            TFloatField(FieldByName('PCG_TOTGER')).DisplayFormat := '#,##0.00';
            TFloatField(FieldByName('PCG_TOTIPI')).DisplayFormat := '#,##0.00';
            TFloatField(FieldByName('PCG_TOTSUB')).DisplayFormat := '#,##0.00';
            TFloatField(FieldByName('PCG_TOTDAR')).DisplayFormat := '#,##0.00';
            TFloatField(FieldByName('PCG_SUBFCP')).DisplayFormat := '#,##0.00';
            strTipFab := FieldByName('PCG_TIPFAB').AsString;
            strPagVis := FieldByName('PCG_PAGVIS').AsString;
          End;
          {**************************************}
          {* CARREGANDO OS ITENS DO PEDIDO      *}
          {***********************************LU*}
          strSQL := '';
          strSQL := strSQL + 'SELECT ';
          strSQL := strSQL + '  PCMDET.*, ';

          If Not fEmptyStr(strTipFab) Then
          Begin
            strSQL := strSQL + TfrmPnlDadosPedCompra.fRetornaSQLCodigoFabricaProduto(strTipFab);
          End
          Else If fCfgSis('CODFIT', varBoolean) Then
          Begin
            strSQL := strSQL +'  CADITE.ITE_CODFAB AS ITE_CODFAB, ';
          End
          Else
          Begin
            If fCfgSis('TABPRF', varBoolean) Then
              strSQL := strSQL + '  IF(IFNULL(F.ITE_CODFAB,"") = "", CADITE.ITE_CODFAB, F.ITE_CODFAB) AS ITE_CODFAB, '
            Else
              strSQL := strSQL + '  IF(IFNULL(F.ITE_CODITF,"") = "", CADITE.ITE_CODFAB, F.ITE_CODITF) AS ITE_CODFAB, ';
          End;

          If Not fEmptyStr(strTipFab) Then
          Begin
            strSQL := strSQL + TfrmPnlDadosPedCompra.fRetornaSQLAplicacaoCodigoFabricaProduto(strTipFab);
          End
          Else If fCfgSis('CODFIT', varBoolean) Then
          Begin
            strSQL := strSQL + '  CAST(CONCAT(CADITE.ITE_APLICA," / ", CADITE.ITE_CODFAB)AS CHAR(255)) AS ITE_APLFAB, ';
          End
          Else
          Begin
            If fCfgSis('TABPRF', varBoolean) Then
              strSQL := strSQL + '  CAST(CONCAT(CADITE.ITE_APLICA," / ", IF(IFNULL(F.ITE_CODFAB,"") = "", CADITE.ITE_CODFAB, F.ITE_CODFAB) )AS CHAR(255)) AS ITE_APLFAB, '
            Else
              strSQL := strSQL + '  CAST(CONCAT(CADITE.ITE_APLICA," / ", IF(IFNULL(F.ITE_CODITF,"") = "", CADITE.ITE_CODFAB, F.ITE_CODITF) )AS CHAR(255)) AS ITE_APLFAB, ';
          End;

          strSQL := strSQL + '  CADITE.*, ';

          strSQL := strSQL + '  CADMAR.MAR_DESMAR, ';
          strSQL := strSQL + '  CADUNI.UNI_SIGUNI, ';
          strSQL := strSQL + '  M.UNI_SIGUNI AS SIGEMB, ';
          strSQL := strSQL + '  (' + strSQLQtdOri + ' * CADUNI.UNI_PESLIT / :LITGAL) AS LITROS, ';

          {******************************************************}
          {* SOMATÓRIA DOS PESOS EM KILO E LITROS SEPARADAMENTE *}
          {****************************************************FC}
          strSQL := strSQL + TfrmPnlDadosPedCompra.fGetSqlPesoLitroKilo(RecOpcaoImpressao.blnMltCmp, RecOpcaoImpressao.tipQtdIte, '(' + strSQLQtdOri + ' * CADUNI.UNI_PESLIT / :LITGAL)', 'L', 'TOTLIT') + ', ';
          strSQL := strSQL + TfrmPnlDadosPedCompra.fGetSqlPesoLitroKilo(RecOpcaoImpressao.blnMltCmp, RecOpcaoImpressao.tipQtdIte, '(' + strSQLQtdOri + ' * CADUNI.UNI_PESLIT / :LITGAL)', 'K', 'TOTKIL') + ', ';

          strSQL := strSQL + '  '  + strSQLQtdIte + ' AS QTDITE, ';
          strSQL := strSQL + '  '  + strSQLUnitar + ' AS UNITAR, ';
          strSQL := strSQL + 'PCD_UNILIQ AS UNILIQ, ';

          If RecOpcaoImpressao.tipQtdIte = tqpPendente Then
          Begin
            strSQL := strSQL + '  PCMDET.PCD_TOTITE - PCMDET.PCD_TOTBAI AS TOTITE, ';
            strSQL := strSQL + '  PCMDET.PCD_TOTIPI - PCMDET.PCD_IPIBAI AS TOTIPI, ';
            strSQL := strSQL + '  PCMDET.PCD_TOTSUB - PCMDET.PCD_SUBBAI AS TOTSUB, ';

            If blnDarRor Then
              strSQL := strSQL + '  PCMDET.PCD_TOTDAR - IFNULL(PCMDET.PCD_DARBAI, 0) AS TOTDAR, '
            Else
              strSQL := strSQL + '  0.00 AS TOTDAR, ';

            strSQL := strSQL + '  PCMDET.PCD_SUBFCP - PCMDET.PCD_FCPBAI AS SUBFCP, ';

            If fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')) Then
            Begin
              strSQL := strSQL + '  (PCMDET.PCD_VALICM / PCMDET.PCD_QTDITE) * ' + strSQLQtdOri + ' AS ICMDES, ';
              strSQL := strSQL + '  (PCMDET.PCD_DESPIS / PCMDET.PCD_QTDITE) * ' + strSQLQtdOri + ' AS DESPIS, ';
            End Else
            Begin
              strSQL := strSQL + '  0.00 AS ICMDES, ';
              strSQL := strSQL + '  0.00 AS DESPIS, ';
            End;

            strSQL := strSQL + '  IFNULL(ROUND(((PCD_VALCBS * 100 / NULLIF(PCD_ALQCBS, 0)) / PCMDET.PCD_QTDITE), 4), 0) * ' + strSQLQtdOri + ' AS BASCBS, ';
            strSQL := strSQL + '  IFNULL(ROUND(((PCD_VALIBS * 100 / NULLIF(PCD_ALQIBS, 0)) / PCMDET.PCD_QTDITE), 4), 0) * ' + strSQLQtdOri + ' AS BASIBS, ';
            strSQL := strSQL + '  IFNULL(ROUND(((PCD_VAL_IS * 100 / NULLIF(PCD_ALQ_IS, 0)) / PCMDET.PCD_QTDITE), 4), 0) * ' + strSQLQtdOri + ' AS BAS_IS, ';

            strSQL := strSQL + '  ROUND(IFNULL(PCD_VALCBS, 0) / PCMDET.PCD_QTDITE, 4) * ' + strSQLQtdOri + ' AS VALCBS, ';
            strSQL := strSQL + '  ROUND(IFNULL(PCD_VALIBS, 0) / PCMDET.PCD_QTDITE, 4) * ' + strSQLQtdOri + ' AS VALIBS, ';
            strSQL := strSQL + '  ROUND(IFNULL(PCD_VAL_IS, 0) / PCMDET.PCD_QTDITE, 4) * ' + strSQLQtdOri + ' AS VAL_IS, ';

          End
          Else
          Begin
            strSQL := strSQL + '  PCMDET.PCD_TOTITE AS TOTITE, ';
            strSQL := strSQL + '  PCMDET.PCD_TOTIPI AS TOTIPI, ';
            strSQL := strSQL + '  PCMDET.PCD_TOTSUB AS TOTSUB, ';

            If blnDarRor Then
              strSQL := strSQL + '  PCMDET.PCD_TOTDAR AS TOTDAR, '
            Else
              strSQL := strSQL + '  0.00 AS TOTDAR, ';

            strSQL := strSQL + '  PCMDET.PCD_SUBFCP AS SUBFCP, ';

            If fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')) Then
            Begin
              strSQL := strSQL + '  PCMDET.PCD_VALICM AS ICMDES, ';
              strSQL := strSQL + '  PCMDET.PCD_DESPIS AS DESPIS, ';
            End Else
            Begin
              strSQL := strSQL + '  0.00 AS ICMDES, ';
              strSQL := strSQL + '  0.00 AS DESPIS, ';
            End;
            strSQL := strSQL + '  IFNULL(ROUND(PCD_VALCBS * 100 / NULLIF(PCD_ALQCBS, 0), 4), 0) AS BASCBS, ';
            strSQL := strSQL + '  IFNULL(ROUND(PCD_VALIBS * 100 / NULLIF(PCD_ALQIBS, 0), 4), 0) AS BASIBS, ';
            strSQL := strSQL + '  IFNULL(ROUND(PCD_VAL_IS * 100 / NULLIF(PCD_ALQ_IS, 0), 4), 0) AS BAS_IS, ';
            strSQL := strSQL + '  IFNULL(PCD_VALCBS, 0) AS VALCBS, ';
            strSQL := strSQL + '  IFNULL(PCD_VALIBS, 0) AS VALIBS, ';
            strSQL := strSQL + '  IFNULL(PCD_VAL_IS, 0) AS VAL_IS, ';

          End;


          strSQL := strSQL + '  (' + strSQLQtdOri + ' * CADITE.ITE_PESOIT) AS PESOIT, ';
          strSQL := strSQL + ' ITEGER.ITE_LOCFIS AS LOCFIS, ';
          strSQL := strSQL + ' ITEGER.ITE_LOCSUP AS LOCSUP  ';

          strSQL := strSQL + 'FROM ';
          strSQL := strSQL + '  PCMDET ';
          strSQL := strSQL + '  JOIN CADITE ON (PCMDET.PCD_CODITE = CADITE.ITE_CODITE ) ';
          strSQL := strSQL + '  JOIN ITEGER ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE AND ';
          strSQL := strSQL + '                 ITEGER.ITE_CODEMP = :EMPPED               ';

          If RecOpcaoImpressao.blnMltCmp Then
            strSQL := strSQL + '  LEFT JOIN CADUNI ON (CADITE.ITE_UNICOM = CADUNI.UNI_CODUNI) '
          Else
            strSQL := strSQL + '  LEFT JOIN CADUNI ON (PCMDET.PCD_CODUNI = CADUNI.UNI_CODUNI) ';

          strSQL := strSQL + '  LEFT JOIN CADUNI M ON CADITE.ITE_UNICOM = M.UNI_CODUNI ';

          strSQL := strSQL + '  LEFT JOIN CADMAR ON (CADITE.ITE_CODMAR = CADMAR.MAR_CODMAR) ';

          strSQL := strSQL + '  LEFT JOIN ITEFOR F ON F.ITE_CODITE = PCMDET.PCD_CODITE ';
          strSQL := strSQL + '                    AND F.ITE_CODFOR = PCMDET.PCD_CODFOR ';

          If fCfgSis('TABPRF', varBoolean) Then
          Begin
            strSQL := strSQL + '                  AND (SELECT COUNT(*) FROM TABPRE     ';
            strSQL := strSQL + '                       WHERE F.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S") > 0 ';
          End Else
          Begin
            strSQL := strSQL + '                  AND F.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF     ';
            strSQL := strSQL + '                       WHERE FF.ITE_CODITE = PCMDET.PCD_CODITE AND ';
            strSQL := strSQL + '                             FF.ITE_CODFOR = PCMDET.PCD_CODFOR)   ';
          End;

          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '  PCMDET.PCD_NUMCTN = 0 AND ';
          strSQL := strSQL + '  PCMDET.PCD_NUMPED = :NUMPED AND ';
          strSQL := strSQL + '  PCMDET.PCD_ESPDOC = :ESPDOC AND ';
          strSQL := strSQL + '  PCMDET.PCD_CODEMP = :CODEMP ';

          If RecOpcaoImpressao.tipQtdIte = tqpPendente Then
            strSQL := strSQL + '  AND ' + strSQLQtdOri + ' > 0 ';

          strSQL := strSQL + 'ORDER BY ';

          case RecOpcaoImpressao.chrOrdDig of
            'D': strSQL := strSQL + '  PCMDET.AUTOINCREM ';
            'A': strSQL := strSQL + '  PCMDET.PCD_DESITE ';
            'F':Begin
                  If fCfgSis('TABPRF', varBoolean) Then
                    strSQL := strSQL + '  IF(IFNULL(F.ITE_CODFAB,"") = "", CADITE.ITE_CODFAB, F.ITE_CODFAB) '
                  Else
                    strSQL := strSQL + '  IF(IFNULL(F.ITE_CODITF,"") = "", CADITE.ITE_CODFAB, F.ITE_CODITF) ';
                End;
           Else  strSQL := strSQL + '  PCMDET.PCD_DESITE ';
          End;

          With frmQckHTMLPedidoCompra.qryRelatorio Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);

            If Params.FindParam('LITGAL') <> Nil Then
            Begin
              If SameText(fCfgSis('LITGAL'), 'L') Then
                ParamByName('LITGAL').AsFloat := 1
              Else
                ParamByName('LITGAL').AsFloat := FLT_LITRO_GALAO;
            End;

            ParamByName('NUMPED').AsString := strNumPed;
            ParamByName('ESPDOC').AsString := strEspDoc;

            If fEmptyStr(strCodEmp) Then
              ParamByName('CODEMP').AsString := VS_strCodEmp
            Else
              ParamByName('CODEMP').AsString := strCodEmp;

            If fEmptyStr(strEmpDes) Then
              ParamByName('EMPPED').AsString := VS_strCodEmp
            Else
              ParamByName('EMPPED').AsString := strEmpDes;

            Open;

            TFloatField(FieldByName('PCD_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DEQTPC', varInteger));
            TFloatField(FieldByName('UNITAR')).DisplayFormat := '#,###0.000';
            TFloatField(FieldByName('UNILIQ')).DisplayFormat := '#,###0.000';
            TFloatField(FieldByName('PCD_TOTITE')).DisplayFormat := '#,###0.000';
            TFloatField(FieldByName('PCD_PERIPI')).DisplayFormat := '#,####0.0000';
            TFloatField(FieldByName('PCD_TOTIPI')).DisplayFormat := '#,##0.00';
            TFloatField(FieldByName('PCD_PERSUB')).DisplayFormat := '#,####0.0000';
            TFloatField(FieldByName('PCD_TOTSUB')).DisplayFormat := '#,##0.00';
            TFloatField(FieldByName('PCD_TOTDAR')).DisplayFormat := '#,##0.00';
            TFloatField(FieldByName('PCD_SUBFCP')).DisplayFormat := '#,##0.00';
            TFloatField(FieldByName('TOTKIL')).DisplayFormat := '#,##0.00';
            TFloatField(FieldByName('TOTLIT')).DisplayFormat := '#,##0.00';
          End;
          {**************************************}
          {* CARREGANDO OS DADOS DA EMPRESA     *}
          {***********************************LU*}
          strSQL := '';
          strSQL := strSQL + 'SELECT ';
          strSQL := strSQL + '  CADEMP.EMP_CODEMP, ';
          strSQL := strSQL + '  CADEMP.EMP_NOMEMP,';
          strSQL := strSQL + '  CONCAT(CADEMP.EMP_ENDERE, ", ", IFNULL(CADEMP.EMP_ENDNUM,""),IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP))) AS EMP_ENDERE, ';
          strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, " - ", CADCID.CID_ESTADO) AS EMP_NOMCID,';
          strSQL := strSQL + '  CADEMP.EMP_BAIRRO,';
          strSQL := strSQL + '  CADEMP.EMP_C_E_P_,';
          strSQL := strSQL + '  IF(IFNULL(CADEMP.EMP_EMAILC, "") = "",  CADEMP.EMP_EMAIL_, CADEMP.EMP_EMAILC) AS EMP_EMAILC,';
          strSQL := strSQL + '  CADEMP.EMP_FONE01,';
          strSQL := strSQL + '  CADEMP.EMP_F_A_X_,';
          strSQL := strSQL + '  CADEMP.EMP_C_G_C_,';
          strSQL := strSQL + '  CADEMP.EMP_I_E_S_ ';
          strSQL := strSQL + 'FROM ';
          strSQL := strSQL + '  CADEMP ';
          strSQL := strSQL + '  LEFT JOIN CADCID ON (CADEMP.EMP_CODCID = CADCID.CID_CODCID) ';
          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '  CADEMP.EMP_CODEMP = :CODEMP ';

          With qryEmpresa Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            If Not fEmptyStr(strEmpDes) Then
              ParamByName('CODEMP').AsString := strEmpDes
            Else
            Begin
              If fEmptyStr(strCodEmp) Then
                ParamByName('CODEMP').AsString := VS_strCodEmp
              Else
                ParamByName('CODEMP').AsString := strCodEmp;
            End;
            Open;
          End;
          {**********************************************}
          {* CARREGANDO OS DADOS DA TRANSPORTADORA      *}
          {*******************************************LU*}
          strSQL := '';
          strSQL := strSQL + 'SELECT ';
          strSQL := strSQL + '  CADTRA.*, ';
          strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, " - ", CADCID.CID_ESTADO) AS TRA_NOMCID ';
          strSQL := strSQL + 'FROM ';
          strSQL := strSQL + '  CADTRA ';
          strSQL := strSQL + '  LEFT JOIN CADCID ON (CADTRA.TRA_CODCID = CADCID.CID_CODCID) ';
          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '  CADTRA.TRA_CODTRA = :CODTRA ';

          With qryTransp Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('CODTRA').AsString := qryPedido.FieldByName('PCG_CODTRA').AsString;
            Open;
          End;

          {***************************************************}
          {* CARREGANDO OS DADOS DA TRANSPORTADORA REDESPACHO*}
          {***************************************************}
          strSQL := '';
          strSQL := strSQL + 'SELECT ';
          strSQL := strSQL + '  CADTRA.*, ';
          strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, " - ", CADCID.CID_ESTADO) AS TRA_NOMCID ';
          strSQL := strSQL + 'FROM ';
          strSQL := strSQL + '  CADTRA ';
          strSQL := strSQL + '  LEFT JOIN CADCID ON (CADTRA.TRA_CODCID = CADCID.CID_CODCID) ';
          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '  CADTRA.TRA_CODTRA = :CODTRA ';

          With qryTranspRedes Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('CODTRA').AsString := qryPedido.FieldByName('PCG_CODTRR').AsString;
            Open;
          End;

          {******************************************************************}
          {* SE NÃO EXISTIR O ARQUIVO - LOGO - ELE NÃO CARREGA NO RELATÓRIO *}
          {***************************************************************LU*}
          strDirImagem := '';
          If FileExists(fCfgSis('PATLOG')) Then
            strDirImagem := fCfgSis('PATLOG')
          Else
            strDirImagem := '';

        End;
      End;

      {*******************************************}
      {* PEGA O ENDEREÇO CORRENTE DO EXECUTÁVEL  *}
      {****************************************LU*}
      strExecutavel := ExtractFilePath(Application.ExeName);

      If (strEspDoc = 'PD') Then
      Begin
        {*******************************************}
        {* SE NÃO EXISTIR O DIRETÓRIO ELE CRIA     *}
        {****************************************LU*}
        If Not DirectoryExists(strExecutavel + 'PedidoCompra') Then
        Begin
          CreateDir(strExecutavel + 'PedidoCompra');
        End;
        strDirGravacao := strExecutavel + 'PedidoCompra';
      End
      Else
      Begin
        If Not DirectoryExists(strExecutavel + 'OrcamentoCompra') Then
        Begin
          CreateDir(strExecutavel + 'OrcamentoCompra');
        End;
        strDirGravacao := strExecutavel + 'OrcamentoCompra';
      End;

      {*******************************************}
      {* O ARQUIVO SERÁ GERADO COM ESSE NOME     *}
      {****************************************LU*}
      If (strEspDoc = 'PD') Then
        strNomeArquivo := '\PD_' + String(strNumPed) + IIf(blnEnvioAutomatico, '_AUT', '') + IIf(RecOpcaoImpressao.strTipExp = 'PDF', '.pdf', '.xls')
      Else
        strNomeArquivo := '\OR_' + String(strNumPed) + IIf(blnEnvioAutomatico, '_AUT', '') + IIf(RecOpcaoImpressao.strTipExp = 'PDF', '.pdf', '.xls');

      {**************************}
      {* EXPORTA O ARQUIVO PDF  *}
      {***********************LU*}
      if blnBrOffice Then
      Begin
        If Not Assigned(fGerarXLSBROffice) Then
        Begin
          pCriarFormularios(TfrmPnlDadosPedCompra, frmPnlDadosPedCompra);
          fGerarXLSBROffice := frmPnlDadosPedCompra
            .fGerarXLSBROffice;
        End;
        If blnEnvioAutomatico Then
        begin
          pgbProgresso := TcxProgressBar.Create(nil);
          try
            fGerarXLSBROffice(pgbProgresso);
          finally
            FreeAndNIl(pgbProgresso)
          end;
        End
        Else
        begin
          pCriarFormularios(TfrmGravando, frmGravando);
          Try
            frmGravando.lblGravando.Caption := 'Gerando planilha...';
            frmGravando.fExecutarAcao := fGerarXLSBROffice;
            frmGravando.ShowModal;
          Finally
            FreeAndNil(frmGravando);
            FreeAndNil(frmPnlDadosPedCompra);
          End;
        End;
      End
      Else
      Begin
        With frmQckHTMLPedidoCompra Do
        Begin
          If fSomarNovosImpostosDaReformaAoValorContabil Then
          begin
            If RecOpcaoImpressao.intOrient = 0 Then
            Begin
              frxRelPed := frxPaginaReforma;
              intQtdCaracteres := 155;
            End
            Else
            Begin
              frxRelPed := frxPaginaPaisagemReforma;
              intQtdCaracteres := 210;
            End;

          end
          Else
          begin
            If RecOpcaoImpressao.intOrient = 0 Then
            Begin
              frxRelPed := frxPagina;
              intQtdCaracteres := 155;
            End
            Else
            Begin
              frxRelPed := frxPaginaPaisagem;
              intQtdCaracteres := 210;
            End;
          end;

          If (blnAplPro) Then
            TfrxChild(frxRelPed.FindObject('ChildAplicacao')).Visible := True
          Else
            TfrxChild(frxRelPed.FindObject('ChildAplicacao')).Visible := False;

          TfrxPictureView(frxRelPed.FindObject('rllQtdIte')).Visible    := RecOpcaoImpressao.tipQtdIte <> tqpNaoExibir;
          TfrxPictureView(frxRelPed.FindObject('rllTitQtdIte')).Visible := RecOpcaoImpressao.tipQtdIte <> tqpNaoExibir;

          frxRelPed.Script.Variables['MSGPCM'] := fCfgSis('MSGPCM');
          frxRelPed.Script.Variables['MSGPC2'] := fCfgSis('MSGPC2');

          frxRelPed.Script.Variables['blnImpObs'] := RecOpcaoImpressao.blnImpObs;

          If fEmptyStr(strDirImagem) Or (Not FileExists(strDirImagem)) Then
          Begin
            If Assigned(frxRelPed.FindObject('rllImagem')) Then
              TfrxPictureView(frxRelPed.FindObject('rllImagem')).Clear;
          End
          Else
          Begin

            If Assigned(frxRelPed.FindObject('rllImagem')) Then
            Try
              TfrxPictureView(frxRelPed.FindObject('rllImagem')).Picture.LoadFromFile(strDirImagem);

              TfrxPictureView(frxRelPed.FindObject('rllImagem')).HightQuality := True;
              TfrxPictureView(frxRelPed.FindObject('rllImagem')).Transparent := False;
              TfrxPictureView(frxRelPed.FindObject('rllImagem')).Restrictions := [rfDontModify];

            Except
              On E: EAbort Do raise;
              On E: Exception Do
              Begin
                If Not blnEnvioAutomatico Then
                  pMensagemOk('Não foi possível carregar a imagem configurada em CFG_PATLOG (' + strDirImagem
                     + '), verifique se você tem acesso a essa pasta e se o arquivo está correto.');

                TfrxPictureView(frxRelPed.FindObject('rllImagem')).Clear;
              End;
            End;
          End;

          TfrxMemoView(frxRelPed.FindObject('rllData')).Memo.Clear;
          TfrxMemoView(frxRelPed.FindObject('rllData')).Memo.Add(fRetDataExtenso(qryPedido.fieldbyname('PCG_DTAPED').AsDateTime,True));

          mmoCompra := TfrxMemoView(frxRelPed.FindObject('mmoCompra'));

          mmoCompra.Memo.Clear;
          mmoCompra.Memo.Add('COMPRADOR: ' + qryPedido.fieldbyname('COMPRA').AsString);

          If Not fEmptyStr(qryPedido.fieldbyname('OPE_E_MAIL').AsString) Then
            mmoCompra.Memo.Add('EMAIL: ' + qryPedido.fieldbyname('OPE_E_MAIL').AsString);

          If Not fEmptyStr(qryPedido.fieldbyname('OPE_FONE01').AsString) Then
          Begin
            If fEmptyStr(qryPedido.fieldbyname('OPE_RAMAL1').AsString) Then
              mmoCompra.Memo.Add('TELEFONE: ' + fFormataFone(qryPedido.fieldbyname('OPE_FONE01').AsString))
            Else
              mmoCompra.Memo.Add('TELEFONE: ' + fFormataFone(qryPedido.fieldbyname('OPE_FONE01').AsString) +
                                 ' RAMAL: ' + qryPedido.fieldbyname('OPE_RAMAL1').AsString);
          End;

          If Not fEmptyStr(qryPedido.fieldbyname('OPE_NEXTEL').AsString) Then
            mmoCompra.Memo.Add('ID-NEXTEL: ' + qryPedido.fieldbyname('OPE_NEXTEL').AsString);

          If (strEspDoc = 'PD') Then
          Begin
            TfrxMemoView(frxRelPed.FindObject('rllObservacao')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllObservacao')).Memo.Add('FAVOR CONFIRMAR O RECEBIMENTO DO PEDIDO - MENCIONAR O NÚMERO DO PEDIDO NA NOTA FISCAL.');

            TfrxMemoView(frxRelPed.FindObject('rllObservacoes')).Memo.Clear;
            if RecOpcaoImpressao.blnImpObs then
              TfrxMemoView(frxRelPed.FindObject('rllObservacoes')).Memo.Add(frmPnlDadosPedCompra.fTrataObservacoes(intQtdCaracteres, qryPedido.fieldbyname('PCG_OBSPD1').AsString +
                                                                                                                    qryPedido.fieldbyname('PCG_OBSPD2').AsString +
                                                                                                                    qryPedido.fieldbyname('PCG_OBSPD3').AsString +
                                                                                                                    qryPedido.fieldbyname('PCG_OBSPD4').AsString +
                                                                                                                    qryPedido.fieldbyname('PCG_OBSPD5').AsString +
                                                                                                                    qryPedido.fieldbyname('PCG_OBSPD6').AsString ));

            TfrxMemoView(frxRelPed.FindObject('rllPedOrc')).Memo.Clear;
            If fEmptyStr(qryPedido.fieldbyname('PCG_ORCORI').AsString) Then
              TfrxMemoView(frxRelPed.FindObject('rllPedOrc')).Memo.Add('Pedido de Compra Nº: ' + strNumPed)
            Else
              TfrxMemoView(frxRelPed.FindObject('rllPedOrc')).Memo.Add('Pedido de Compra Nº: ' +
                           strNumPed + fPadL('Ref. Orçamento de Compra Nº: ', 109, ' ') +
                           Copy(qryPedido.fieldbyname('PCG_ORCORI').AsString, 1, 6) + '-' + Copy(qryPedido.fieldbyname('PCG_ORCORI').AsString, 9, 3));

            TfrxMemoView(frxRelPed.FindObject('rllTituloPedOrc')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllTituloPedOrc')).Memo.Add(IIF(qryPedido.fieldbyname('PCG_PEDBON').AsString = 'S', 'Bonificação', 'Pedido de Compra'));

            TfrxBand(frxRelPed.FindObject('Transportadora')).visible := True;
          End
          Else
          Begin
            TfrxMemoView(frxRelPed.FindObject('rllObservacao')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllObservacao')).Memo.Add('FAVOR CONFIRMAR O RECEBIMENTO DO ORÇAMENTO - MENCIONAR O NÚMERO DO ORÇAMENTO NA NOTA FISCAL.');

            TfrxMemoView(frxRelPed.FindObject('rllObservacoes')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllObservacoes')).Memo.Add(frmPnlDadosPedCompra.fTrataObservacoes(intQtdCaracteres, qryPedido.fieldbyname('PCG_OBS001').AsString +
                                                                                                                  qryPedido.fieldbyname('PCG_OBS002').AsString +
                                                                                                                  qryPedido.fieldbyname('PCG_OBS003').AsString +
                                                                                                                  qryPedido.fieldbyname('PCG_OBS004').AsString +
                                                                                                                  qryPedido.fieldbyname('PCG_OBS005').AsString +
                                                                                                                  qryPedido.fieldbyname('PCG_OBS006').AsString ));

            TfrxMemoView(frxRelPed.FindObject('rllPedOrc')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllPedOrc')).Memo.Add('Orçamento Nº: ' + strNumPed);

            TfrxMemoView(frxRelPed.FindObject('rllTituloPedOrc')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllTituloPedOrc')).Memo.Add(IIF(qryPedido.fieldbyname('PCG_PEDBON').AsString = 'S', 'Bonificação', 'Orçamento'));

            TfrxBand(frxRelPed.FindObject('Transportadora')).visible := True;
          End;

          If RecOpcaoImpressao.blnSemPre Then
          Begin

            TfrxMemoView(frxRelPed.FindObject('rllPrecoUnit')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllPrecoUnit')).Memo.Add('-');
            TfrxMemoView(frxRelPed.FindObject('rllPrecoUnit')).DisplayFormat.Kind := fkText;

            TfrxMemoView(frxRelPed.FindObject('rllUniLiq')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllUniLiq')).Memo.Add('-');
            TfrxMemoView(frxRelPed.FindObject('rllUniLiq')).DisplayFormat.Kind := fkText;

            TfrxMemoView(frxRelPed.FindObject('rllPrecoTot')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllPrecoTot')).Memo.Add('-');
            TfrxMemoView(frxRelPed.FindObject('rllPrecoTot')).DisplayFormat.Kind := fkText;

            TfrxMemoView(frxRelPed.FindObject('rllDesUni')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllDesUni')).Memo.Add('-');
            TfrxMemoView(frxRelPed.FindObject('rllDesUni')).DisplayFormat.Kind := fkText;

            TfrxMemoView(frxRelPed.FindObject('rllIpi')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllIpi')).Memo.Add('-');
            TfrxMemoView(frxRelPed.FindObject('rllIpi')).DisplayFormat.Kind := fkText;

            TfrxMemoView(frxRelPed.FindObject('rllVlIpi')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllVlIpi')).Memo.Add('-');
            TfrxMemoView(frxRelPed.FindObject('rllVlIpi')).DisplayFormat.Kind := fkText;

            TfrxMemoView(frxRelPed.FindObject('rllTotalItens')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllTotalItens')).Memo.Add('-');
            TfrxMemoView(frxRelPed.FindObject('rllTotalItens')).DisplayFormat.Kind := fkText;

            TfrxMemoView(frxRelPed.FindObject('rllTotalIpi')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllTotalIpi')).Memo.Add('-');
            TfrxMemoView(frxRelPed.FindObject('rllTotalIpi')).DisplayFormat.Kind := fkText;

            TfrxMemoView(frxRelPed.FindObject('rllTotalSub')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllTotalSub')).Memo.Add('-');
            TfrxMemoView(frxRelPed.FindObject('rllTotalSub')).DisplayFormat.Kind := fkText;

            TfrxMemoView(frxRelPed.FindObject('rllTotalSubFCP')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllTotalSubFCP')).Memo.Add('-');
            TfrxMemoView(frxRelPed.FindObject('rllTotalSubFCP')).DisplayFormat.Kind := fkText;

            TfrxMemoView(frxRelPed.FindObject('mmoIcmDes')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('mmoIcmDes')).Memo.Add('-');
            TfrxMemoView(frxRelPed.FindObject('mmoIcmDes')).DisplayFormat.Kind := fkText;

            TfrxMemoView(frxRelPed.FindObject('mmoDesPis')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('mmoDesPis')).Memo.Add('-');
            TfrxMemoView(frxRelPed.FindObject('mmoDesPis')).DisplayFormat.Kind := fkText;

            TfrxMemoView(frxRelPed.FindObject('rllTotalGeral')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllTotalGeral')).Memo.Add('-');
            TfrxMemoView(frxRelPed.FindObject('rllTotalGeral')).DisplayFormat.Kind := fkText;

            TfrxMemoView(frxRelPed.FindObject('rllAlqSub')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllAlqSub')).Memo.Add('-');
            TfrxMemoView(frxRelPed.FindObject('rllAlqSub')).DisplayFormat.Kind := fkText;

            TfrxMemoView(frxRelPed.FindObject('rllValSub')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllValSub')).Memo.Add('-');
            TfrxMemoView(frxRelPed.FindObject('rllValSub')).DisplayFormat.Kind := fkText;

            pOcultaReformaSemPreco(frxRelPed);
          End
          Else
          Begin
            TfrxMemoView(frxRelPed.FindObject('rllPrecoUnit')).DisplayFormat.FormatStr := '%2.' + fCfgSis('DECUNI', varString) + 'f';
            TfrxMemoView(frxRelPed.FindObject('rllPrecoUnit')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllPrecoUnit')).Memo.Add('[frxRelatorio."UNITAR"]');

            TfrxMemoView(frxRelPed.FindObject('rllUniLiq')).DisplayFormat.FormatStr := '%2.' + fCfgSis('DECUNI', varString) + 'f';
            TfrxMemoView(frxRelPed.FindObject('rllUniLiq')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllUniLiq')).Memo.Add('[frxRelatorio."UNILIQ"]');

            TfrxMemoView(frxRelPed.FindObject('rllDesUni')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllDesUni')).Memo.Add(
              '[(1 - (1 - <frxRelatorio."PCD_DESUNI"> / 100) ' +
              '    * (1 - <frxRelatorio."PCD_DESUN2"> / 100) ' +
              '    * (1 - <frxRelatorio."PCD_DESUN3"> / 100) ' +
              '    * (1 - <frxRelatorio."PCD_DESUN4"> / 100) ' +
              '    * (1 - <frxRelatorio."PCD_DESUN5"> / 100) ' +
              '    * (1 - <frxRelatorio."PCD_DESUN6"> / 100)) * 100 ' +
              ']');

            TfrxMemoView(frxRelPed.FindObject('rllPrecoTot')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllPrecoTot')).Memo.Add('[frxRelatorio."TOTITE"]');

            TfrxMemoView(frxRelPed.FindObject('rllIpi')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllIpi')).Memo.Add('[frxRelatorio."PCD_PERIPI"]');

            TfrxMemoView(frxRelPed.FindObject('rllVlIpi')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllVlIpi')).Memo.Add('[frxRelatorio."TOTIPI"]');

            TfrxMemoView(frxRelPed.FindObject('rllTotalItens')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllTotalItens')).Memo.Add('[SUM(<frxRelatorio."TOTITE">)]');

            TfrxMemoView(frxRelPed.FindObject('rllTotalIpi')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllTotalIpi')).Memo.Add('[SUM(<frxRelatorio."TOTIPI">)]');

            TfrxMemoView(frxRelPed.FindObject('rllTotalSub')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllTotalSub')).Memo.Add('[SUM(<frxRelatorio."TOTSUB">)]');

            TfrxMemoView(frxRelPed.FindObject('rllTotalSubFCP')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllTotalSubFCP')).Memo.Add('[SUM(<frxRelatorio."SUBFCP">)]');

            TfrxMemoView(frxRelPed.FindObject('mmoIcmDes')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('mmoIcmDes')).Memo.Add('[SUM(<frxRelatorio."ICMDES">)]');

            TfrxMemoView(frxRelPed.FindObject('mmoDesPis')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('mmoDesPis')).Memo.Add('[SUM(<frxRelatorio."DESPIS">)]');

            TfrxMemoView(frxRelPed.FindObject('rllTotalGeral')).Memo.Clear;
            TfrxMemoView(frxRelPed.FindObject('rllTotalGeral')).Memo.Add('[SUM(<frxRelatorio."TOTITE"> + <frxRelatorio."TOTIPI"> + ' +
              IfThen(fSomarNovosImpostosDaReformaAoValorContabil, '<frxRelatorio."VALCBS"> + <frxRelatorio."VALIBS"> + <frxRelatorio."VAL_IS"> + ', '') +
              '<frxRelatorio."TOTSUB"> + <frxRelatorio."SUBFCP"> - <frxRelatorio."ICMDES"> - <frxRelatorio."DESPIS">, Detalhes, 2) + ' +
              '<frxPedido."PCG_VALFRE"> + <frxPedido."PCG_DESACE">]');
          End;

          TfrxLineView(frxRelPed.FindObject('linMarca')).Visible      := RecOpcaoImpressao.blnComMar;
          TfrxMemoView(frxRelPed.FindObject('mmoDesMar')).Visible     := RecOpcaoImpressao.blnComMar;
          TfrxMemoView(frxRelPed.FindObject('mmoMarca')).Visible      := RecOpcaoImpressao.blnComMar;

          TfrxLineView(frxRelPed.FindObject('linCodFab')).Visible     := RecOpcaoImpressao.blnCodFab;
          TfrxMemoView(frxRelPed.FindObject('mmoCodFab')).Visible     := RecOpcaoImpressao.blnCodFab;
          TfrxMemoView(frxRelPed.FindObject('mmoCodFabrica')).Visible := RecOpcaoImpressao.blnCodFab;


          TfrxLineView(frxRelPed.FindObject('linLocFis')).Visible     := RecOpcaoImpressao.blnLocFis;
          TfrxMemoView(frxRelPed.FindObject('mmoLocFis')).Visible     := RecOpcaoImpressao.blnLocFis;
          TfrxMemoView(frxRelPed.FindObject('mmoLocFisDes')).Visible  := RecOpcaoImpressao.blnLocFis;

          TfrxLineView(frxRelPed.FindObject('linLocSup')).Visible     := RecOpcaoImpressao.blnLocFis;
          TfrxMemoView(frxRelPed.FindObject('mmoLocSup')).Visible     := RecOpcaoImpressao.blnLocFis;
          TfrxMemoView(frxRelPed.FindObject('mmoLocSupDes')).Visible  := RecOpcaoImpressao.blnLocFis;

          TfrxLineView(frxRelPed.FindObject('linCodBar')).Visible     := RecOpcaoImpressao.blnCodBar;
          TfrxMemoView(frxRelPed.FindObject('mmoCodBar')).Visible     := RecOpcaoImpressao.blnCodBar;
          TfrxMemoView(frxRelPed.FindObject('mmoCodBarras')).Visible  := RecOpcaoImpressao.blnCodBar;

          TfrxLineView(frxRelPed.FindObject('linReferencia')).Visible      := RecOpcaoImpressao.blnImpRef;
          TfrxMemoView(frxRelPed.FindObject('mmoReferencia')).Visible      := RecOpcaoImpressao.blnImpRef;
          TfrxMemoView(frxRelPed.FindObject('mmoReferenciaDados')).Visible := RecOpcaoImpressao.blnImpRef;

          {Se localização física não estiver marcada e referencia estiver marcado eu alinho
          a direita a informação da referencia}
          If (Not(RecOpcaoImpressao.blnLocFis)) And (RecOpcaoImpressao.blnImpRef)  Then
          Begin
            TfrxLineView(frxRelPed.FindObject('linReferencia')).Left      := 660;
            TfrxMemoView(frxRelPed.FindObject('mmoReferencia')).Left      := 661;
            TfrxMemoView(frxRelPed.FindObject('mmoReferenciaDados')).Left := 661;
          End;

          If fCfgSis('ENTITE', VarBoolean) Then
          Begin

            If (Not RecOpcaoImpressao.blnLocFis) And (Not RecOpcaoImpressao.blnCodBar) Then
              TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Width := 700;

          End Else
          Begin
           {* Se estivar desmarcado localização fisica  e Codigo de Barras Que Pertencem a primeira linha
            e desmarcado  marca ou codigo de fabrica as informações caberão em uma unica linha
            então coloca o titulo em 1 unica linha *}
            If ((Not RecOpcaoImpressao.blnLocFis) And (Not RecOpcaoImpressao.blnCodBar) And (Not(RecOpcaoImpressao.blnImpRef))) And ((Not RecOpcaoImpressao.blnComMar) or (Not RecOpcaoImpressao.blnCodFab))  Then
            Begin
              TfrxMemoView(frxRelPed.FindObject('mmoUnid')).Top      := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
              TfrxMemoView(frxRelPed.FindObject('mmoMarca')).Top     := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
              TfrxMemoView(frxRelPed.FindObject('mmoCodFab')).Top    := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
              TfrxMemoView(frxRelPed.FindObject('rllTitQtdIte')).Top := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
              TfrxMemoView(frxRelPed.FindObject('mmoPreUni')).Top    := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
              TfrxMemoView(frxRelPed.FindObject('mmoPreTot')).Top    := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
              TfrxMemoView(frxRelPed.FindObject('mmoPerIpi')).Top    := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
              TfrxMemoView(frxRelPed.FindObject('mmoPreIpi')).Top    := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
              TfrxMemoView(frxRelPed.FindObject('mmoPerDesc')).Top   := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
              TfrxMemoView(frxRelPed.FindObject('mmoVlrLiq')).Top    := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
              TfrxMemoView(frxRelPed.FindObject('mmoPerSub')).Top    := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;

              If frxRelPed.FindObject('mmoValSub') <> Nil Then
                TfrxMemoView(frxRelPed.FindObject('mmoValSub')).Top    := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;

              TfrxMemoView(frxRelPed.FindObject('linUnid')).Top      := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
              TfrxMemoView(frxRelPed.FindObject('linMarca')).Top     := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
              TfrxMemoView(frxRelPed.FindObject('linCodFab')).Top    := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
              TfrxMemoView(frxRelPed.FindObject('linQtdIte')).Top    := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
              TfrxMemoView(frxRelPed.FindObject('linPreUni')).Top    := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
              TfrxMemoView(frxRelPed.FindObject('linPreTot')).Top    := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
              TfrxMemoView(frxRelPed.FindObject('linPerIpi')).Top    := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
              TfrxMemoView(frxRelPed.FindObject('linPreIpi')).Top    := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
              TfrxMemoView(frxRelPed.FindObject('linPerDesc')).Top   := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
              TfrxMemoView(frxRelPed.FindObject('linVlrLiq')).Top    := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;

              If frxRelPed.FindObject('linPerSub') <> Nil Then
                TfrxMemoView(frxRelPed.FindObject('linPerSub')).Top    := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;

              If frxRelPed.FindObject('linValSub') <> Nil Then
                TfrxMemoView(frxRelPed.FindObject('linValSub')).Top    := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;

              If RecOpcaoImpressao.intOrient = 1 Then
              Begin
                TfrxMemoView(frxRelPed.FindObject('mmoCodBar')).Top  := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
                TfrxMemoView(frxRelPed.FindObject('linCodBar')).Top  := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;

                TfrxMemoView(frxRelPed.FindObject('mmoUnidEmb')).Top := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
                TfrxMemoView(frxRelPed.FindObject('linUnidEmb')).Top := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;

                TfrxMemoView(frxRelPed.FindObject('mmoQtdEmb')).Top  := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
                TfrxMemoView(frxRelPed.FindObject('linQtdEmb')).Top  := TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Top;
              End;

              TfrxShapeView(frxRelPed.FindObject('sDados')).Visible := False;

              TfrxBand(frxRelPed.FindObject('TopoMateriais')).Height := TfrxShapeView(frxRelPed.FindObject('sTitulo')).Height +
                                                                          TfrxShapeView(frxRelPed.FindObject('sDuplicata')).Height;
            End;

            //Se todos os checkboxes estiverem desmarcado então escreve tudo em uma linha
            If (Not RecOpcaoImpressao.blnComMar) And (Not RecOpcaoImpressao.blnCodFab) And (Not RecOpcaoImpressao.blnLocFis) And (Not RecOpcaoImpressao.blnCodBar) And (Not RecOpcaoImpressao.blnImpRef) Then
            Begin
              TfrxMemoView(frxRelPed.FindObject('mmoDesMar')).Top     := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
              TfrxMemoView(frxRelPed.FindObject('mmoCodFabrica')).Top := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
              TfrxMemoView(frxRelPed.FindObject('mmoUnidade')).Top    := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
              TfrxMemoView(frxRelPed.FindObject('rllQtdIte')).Top     := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
              TfrxMemoView(frxRelPed.FindObject('rllPrecoUnit')).Top  := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
              TfrxMemoView(frxRelPed.FindObject('rllDesUni')).Top     := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
              TfrxMemoView(frxRelPed.FindObject('rllUnilIQ')).Top     := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
              TfrxMemoView(frxRelPed.FindObject('rllPrecotot')).Top   := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
              TfrxMemoView(frxRelPed.FindObject('rllIpi')).Top        := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
              TfrxMemoView(frxRelPed.FindObject('rllVlIpi')).Top      := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
              TfrxMemoView(frxRelPed.FindObject('rllAlqSub')).Top     := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
              TfrxMemoView(frxRelPed.FindObject('rllValSub')).Top     := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;

              if RecOpcaoImpressao.intOrient = 1 Then
              Begin
                TfrxMemoView(frxRelPed.FindObject('mmoCodBarras')).Top       := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
                TfrxMemoView(frxRelPed.FindObject('mmoUnidEmbDes')).Top      := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
                TfrxMemoView(frxRelPed.FindObject('mmoQtdEmbDes')).Top       := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
                TfrxMemoView(frxRelPed.FindObject('mmoReferenciaDados')).Top := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
              End;

              TfrxMasterData(frxRelPed.FindObject('Detalhes')).Height := 10;
              TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Width   := 210;

            End
            // Se apenas marca estiver marcado
            Else If (RecOpcaoImpressao.blnComMar) And (Not RecOpcaoImpressao.blnCodFab) And ( (Not RecOpcaoImpressao.blnLocFis) And (Not RecOpcaoImpressao.blnCodBar) And (Not RecOpcaoImpressao.blnImpRef) ) Then
            Begin
              TfrxLineView(frxRelPed.FindObject('linMarca')).Left  := TfrxLineView(frxRelPed.FindObject('mmoCodFabrica')).Left;
              TfrxMemoView(frxRelPed.FindObject('mmoDesMar')).Left := TfrxLineView(frxRelPed.FindObject('mmoCodFabrica')).Left;
              TfrxMemoView(frxRelPed.FindObject('mmoMarca')).Left  := TfrxLineView(frxRelPed.FindObject('mmoCodFabrica')).Left;
              TfrxMemoView(frxRelPed.FindObject('mmoDesMar')).Width := TfrxMemoView(frxRelPed.FindObject('mmoDesMar')).Width + 35;

              TfrxMasterData(frxRelPed.FindObject('Detalhes')).Height := 10;
              TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Width   := 100;
              TfrxMemoView(frxRelPed.FindObject('mmoDesMar')).Top     := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
              TfrxMemoView(frxRelPed.FindObject('mmoUnidade')).Top    := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
              TfrxMemoView(frxRelPed.FindObject('rllQtdIte')).Top     := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
              TfrxMemoView(frxRelPed.FindObject('rllPrecoUnit')).Top  := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
              TfrxMemoView(frxRelPed.FindObject('rllDesUni')).Top     := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
              TfrxMemoView(frxRelPed.FindObject('rllUnilIQ')).Top     := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
              TfrxMemoView(frxRelPed.FindObject('rllPrecotot')).Top   := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
              TfrxMemoView(frxRelPed.FindObject('rllIpi')).Top        := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
              TfrxMemoView(frxRelPed.FindObject('rllVlIpi')).Top      := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
              TfrxMemoView(frxRelPed.FindObject('rllAlqSub')).Top     := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;
              TfrxMemoView(frxRelPed.FindObject('rllValSub')).Top     := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Top;

            End
            {   Se Estiver marcado código de barras porem sem localização fisica
            ocupar o espaço com o código de barras e expandir o tamanho da descrição }
            Else If (RecOpcaoImpressao.blnCodBar) And (Not RecOpcaoImpressao.blnLocFis) And (RecOpcaoImpressao.intOrient = 0) Then
            Begin
              TfrxLineView(frxRelPed.FindObject('linCodBar')).Left    := TfrxLineView(frxRelPed.FindObject('linLocFis')).Left;
              TfrxMemoView(frxRelPed.FindObject('mmoCodBar')).Left    := TfrxMemoView(frxRelPed.FindObject('mmoLocFis')).Left;
              TfrxMemoView(frxRelPed.FindObject('mmoCodBarras')).Left := TfrxMemoView(frxRelPed.FindObject('mmoLocFisDes')).Left;
              TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Width := TfrxMemoView(frxRelPed.FindObject('mmoDescri')).Width +
                                                                      TfrxMemoView(frxRelPed.FindObject('mmoCodBar')).Width;
            End;

          End;

          TfrxMemoView(frxRelPed.FindObject('rllPgtVis')).Visible := (strPagVis = 'S');
          frxRelPed.PrepareReport(True);

          If RecOpcaoImpressao.strTipExp = 'PDF' Then
          Begin
            frxExportaPDF.FileName    := strDirGravacao + strNomeArquivo;
            frxExportaPDF.DefaultPath := strDirGravacao;
            frxExportaPDF.ShowDialog  := False;
            strDesPro := 'Pedido de Compra ' + Format(' (%s-%s-%s) ',[strNumPed, strEspDoc, IIF(fEmptyStr(strEmpDes), strCodEmp, strEmpDes)]);
            If strNomImp <> '' Then
            Begin
              frxRelPed.PrintOptions.Printer    := IIF(fEmptyStr(strNomImp),TCfgRel.fGetImpressoraSelecionada, strNomImp);
              {frxRelPed.PrintOptions.ShowDialog := fEmptyStr(strNomImp);}
              frxRelPed.PreviewOptions.Buttons  := [pbPrint, pbZoom,pbFind,pbOutline,pbPageSetup,pbNavigator];
              frxRelPed.SelectPrinter;
              If RecOpcaoImpressao.ShowReport Then
                pPreviewReport(Self.ClassName, strDesPro, frxRelPed)
              Else
                frxRelPed.Export(frxExportaPDF);
            End
            Else
              frxRelPed.Export(frxExportaPDF);
          End
          Else
          Begin
            frxExportaXLS.FileName    := strDirGravacao + strNomeArquivo;
            frxExportaXLS.DefaultPath := strDirGravacao;
            frxExportaXLS.ShowDialog  := False;
            frxRelPed.Export(frxExportaXLS);
          End;
        End;
      End;

      {**************************}
      {* GERA O ANEXO NO EMAIL  *}
      {***********************LU*}
      If blnBrOffice Then
         Result := strNomeArquivo
      Else
         Result := strDirGravacao + strNomeArquivo;

      strNomeArquivo := Result;

      frmQckHTMLPedidoCompra.qryRelatorio.Close;
      frmQckHTMLPedidoCompra.qryPedido.Close;
      frmQckHTMLPedidoCompra.qryEmpresa.Close;
      frmQckHTMLPedidoCompra.qryTransp.Close;
      frmQckHTMLPedidoCompra.qryTranspRedes.Close;

    Except
      On E: Exception Do
      Begin
        Result := '';
        ShowMessage(E.Message);
        pMensagensErro(E.Message, '');
      End;
    End;
  Finally
    pFreeAndNil(frmQckHTMLPedidoCompra);
  End;
end;

End.
