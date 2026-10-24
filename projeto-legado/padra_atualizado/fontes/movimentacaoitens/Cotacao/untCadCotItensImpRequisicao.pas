unit untCadCotItensImpRequisicao;

interface

uses
  Windows, Classes, Controls, Forms, untPai, AppEvnts, Menus, Buttons, BitBtnLockedIncrem,
  ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter , cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxControls, cxGridCustomView, cxGrid, UniClientDataSet, Uni, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, StdCtrls, Datasnap.DBClient,
  frxClass, frxExportCSVTestabilidade, untFuncoesRel, cxProgressBar,
  untRecuperaPedido, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, cxCheckBox,
  cxDataControllerConditionalFormattingRulesManagerDialog, untFuncoesSimples,
  untRequisicaoPedidoCompra , cxCurrencyEdit, System.UITypes, VirtualUI_SDK,
  untTypesSistema, untInfPedido;


type
  TfrmCadCotItensImpRequisicao = class(TfrmPai)
    cxgReq: TcxGrid;
    cxgReqView: TcxGridDBTableView;
    cxgCliCnd: TcxGridLevel;
    btnConfirmar: TBitBtnLocked;
    btnMarDes: TBitBtnLocked;
    btnDesTodos: TBitBtnLocked;
    cxgReqViewAUTOINCREM: TcxGridDBColumn;
    cxgReqViewCODREQ: TcxGridDBColumn;
    cxgReqViewCODFOR: TcxGridDBColumn;
    cxgReqViewDTACAD: TcxGridDBColumn;
    cxgReqViewNOMOPE: TcxGridDBColumn;
    cxgReqViewNOMCLI: TcxGridDBColumn;
    cxgReqViewDESITE: TcxGridDBColumn;
    cxgReqViewREFERE: TcxGridDBColumn;
    cxgReqViewSIGUNI: TcxGridDBColumn;
    cxgReqViewCODFAB: TcxGridDBColumn;
    cxgReqViewQTDORI: TcxGridDBColumn;
    cxgReqViewMARDES: TcxGridDBColumn;
    cxgReqViewPRODUT: TcxGridDBColumn;
    cxgReqViewCODITE: TcxGridDBColumn;
    cxgReqViewDEPITE: TcxGridDBColumn;
    cxgReqViewDOCPDV: TcxGridDBColumn;
    cxgReqViewESPPDV: TcxGridDBColumn;
    cxgReqViewEMPPDV: TcxGridDBColumn;
    pnlObservacoes: TPanel;
    Label1: TLabel;
    dbeObserv: TDBEditFocus;
    cxgReqViewDESMAR: TcxGridDBColumn;
    cxgReqViewMARANT: TcxGridDBColumn;
    btnMarTodos: TBitBtnLocked;
    btnNegar: TBitBtnLocked;
    cxgReqViewNEGADA: TcxGridDBColumn;
    cxgReqViewCODEMP: TcxGridDBColumn;
    btnPedVen: TBitBtnLocked;
    cxgReqViewQTDITE: TcxGridDBColumn;
    btnAssPedCom: TBitBtnLocked;
    cxgReqViewAUTDET: TcxGridDBColumn;
    pnlLegendas: TPanel;
    shpAssOutPed: TShape;
    Label2: TLabel;
    shpAssPed: TShape;
    lblAssPed: TLabel;
    cxgReqViewSALDIS: TcxGridDBColumn;
    cxgReqViewQTDPEN: TcxGridDBColumn;
    cxgReqViewREQPCD: TcxGridDBColumn;
    lblDisponivel: TLabel;
    cxgReqViewOPERES: TcxGridDBColumn;
    cxgReqViewNOMRES: TcxGridDBColumn;
    cxgReqViewNOMLIN: TcxGridDBColumn;
    cxgReqViewNOMGRU: TcxGridDBColumn;
    cxgReqViewQTDDIS_TODAS: TcxGridDBColumn;
    cxgReqViewQTDPEN_TODAS: TcxGridDBColumn;
    cxgReqViewNOTAS: TcxGridDBColumn;
    shpAguaEfet: TShape;
    Label4: TLabel;
    shpAguaEfetOut: TShape;
    Label5: TLabel;
    lblMsgTransferencia: TLabel;
    cxgReqViewSalEnd: TcxGridDBColumn;
    cxgReqViewSTATUS: TcxGridDBColumn;
    btnMostraEstoque: TBitBtnLocked;
    btnGerarPedidoCompra: TBitBtnLocked;
    bntGerarCotacao: TBitBtnLocked;
    cxgReqViewOBSERV: TcxGridDBColumn;
    cxgReqViewNUMOSE: TcxGridDBColumn;
    cxgReqViewPROTOC: TcxGridDBColumn;
    cxgReqViewGarant: TcxGridDBColumn;
    cxgReqViewCOMLIQ: TcxGridDBColumn;
    btnAbrirRequisicao: TBitBtnLocked;
    btnMostrarPedidodVenda: TBitBtnLocked;
    cxgReqViewColumn1: TcxGridDBColumn;
	  cxgReqViewEMPOSE: TcxGridDBColumn;
    btnObsPed: TBitBtnLocked;
    btnAtualizarProdOS: TBitBtnLocked;
    btnAlterarItensEspeciaisReq: TBitBtnLocked;
    cxgReqViewRCD_DTPREV: TcxGridDBColumn;
    cxgReqViewDTA_ENTREGA: TcxGridDBColumn;
    cxgReqViewPCD_NUMPED: TcxGridDBColumn;
    cxgReqViewFORNEC: TcxGridDBColumn;
    cxgReqViewQTDPED: TcxGridDBColumn;
    cxgReqViewPCD_DTAENT: TcxGridDBColumn;
    procedure btnMarDesClick(Sender: TObject);
    procedure btnDesTodosClick(Sender: TObject);
    procedure cxgReqViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgReqViewCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxgReqViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnMarTodosClick(Sender: TObject);
    procedure btnNegarClick(Sender: TObject);
    procedure btnPedVenClick(Sender: TObject);
    procedure btnAssPedComClick(Sender: TObject);
    procedure btnMostraEstoqueClick(Sender: TObject);
    procedure bntGerarCotacaoClick(Sender: TObject);
    procedure btnGerarPedidoCompraClick(Sender: TObject);
    procedure btnAbrirRequisicaoClick(Sender: TObject);
    procedure btnMostrarPedidodVendaClick(Sender: TObject);
    procedure cxgReqViewColumn1GetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
	procedure btnAtualizarProdOSClick(Sender: TObject);
	procedure btnObsPedClick(Sender: TObject);
    procedure btnAlterarItensEspeciaisReqClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    varCDSDisponiveisBkp,
    varCDSDataBkp: OleVariant;

    blnNegar : Boolean;
    blnMarcar: Boolean;


    strItensPesquisados: String;

    Function fMarcaDesmarca: Boolean;

    Function fConfirmaNegativa: Boolean;

    Function fMarcaDesmarcaTodos(cxgProgresso: TcxProgressBar): Boolean;

    procedure pLiberaTravaCancelados;

    Procedure pCarregaConfiguracoesGrid;

    Procedure pSalvaConfiguracoesGrid;

    function fCriarArquivoTemporario(strNomArq: String = ''; strPathTmp: String = ''): String;
    function fGetPathTempOpcoesLocais: String;
    function fArquivoParaString(strNomArq: String): String;
    function fEscreverNoArquivo(strNomArq, strTexto: String): Boolean;
    procedure pGerarPDF;
  private
    const
      DIRACE_ALTERAR_REQ_COMPRA_TROCA_ITEM_ESPECIAL: String = 'ARCTIE';
  public
    FProcIniciaCotacao : TProcIniciaCotacao;
    FProcIniciaPedComp : TProcIniciaPedComp;
    pImprimeDocumento: TImprimeDocumento;
    FecharFormAoConfirmar: Boolean;
    objRequisicao: TRequisicaoPedidoCompra;
  end;

var
  frmCadCotItensImpRequisicao: TfrmCadCotItensImpRequisicao;

implementation

uses SysUtils, Variants, Graphics, untJustificaNegativa,
     untGravando, Shlobj, Math, IniFiles, untFatMostraEstoqueEmp,  untFuncoesPedidoSimples;

{$R *.dfm}

procedure TfrmCadCotItensImpRequisicao.btnMarDesClick(Sender: TObject);
begin
  If Not btnMarDes.Visible Then
    Exit;

  fMarcaDesmarca;
end;

procedure TfrmCadCotItensImpRequisicao.btnMarTodosClick(Sender: TObject);
begin
  inherited;

  If Not btnMarTodos.Visible Then
    Exit;

  blnMarcar := True;
  blnNegar  := False;

  TfrmGravando.fExecuta(fMarcaDesmarcaTodos, frmGravando);
end;

procedure TfrmCadCotItensImpRequisicao.btnMostraEstoqueClick(Sender: TObject);
  Var
    frmFatMostraEstoqueEmp : TfrmFatMostraEstoqueEmp;
begin
  If btnMostraEstoque.Visible Then
  Begin
    If Not fVerificaAcessoSistema('CPELOJ', strLoginUsuarioLogado) Then
      fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok'])
    Else
    Begin
      Try
        pCriarFormularios(TfrmFatMostraEstoqueEmp, frmFatMostraEstoqueEmp);

        frmFatMostraEstoqueEmp.blnFaturamento := True;
        frmFatMostraEstoqueEmp.strCodIte      := objRequisicao.cdsRequisicao.FieldByName('CODITE').AsString;
        frmFatMostraEstoqueEmp.strTabPre      := '1';
        frmFatMostraEstoqueEmp.edtItem.Text   := objRequisicao.cdsRequisicao.FieldByName('CODITE').AsString + ' - ' +
                                                 objRequisicao.cdsRequisicao.FieldByName('DESITE').AsString;
        frmFatMostraEstoqueEmp.blnEstrutura   := fItemEstrutura(objRequisicao.cdsRequisicao.FieldByName('CODITE').AsString);
        frmFatMostraEstoqueEmp.showModal;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[pMostraEstoqueLojas]');
      End;

      pFreeAndNil(frmFatMostraEstoqueEmp);
    End;
  End;
end;

Function TfrmCadCotItensImpRequisicao.fMarcaDesmarcaTodos(cxgProgresso: TcxProgressBar): Boolean;
  Var
    intContador: Integer;
    strAutInc: String;
Begin
  If blnMarcar Then
    frmGravando.lblGravando.Caption := 'Marcando itens, aguarde...'
  Else
    frmGravando.lblGravando.Caption := 'Desmarcando itens, aguarde...';

  cxgProgresso.Properties.Max := cxgReqView.ViewData.RecordCount;

  objRequisicao.cdsRequisicao.IndexFieldNames := 'AUTOINCREM';

  For intContador := 0 To cxgReqView.ViewData.RecordCount - 1 Do
  Begin

    If cxgReqView.ViewData.Records[intContador].IsData Then
    Begin
      strAutInc := cxgReqView.ViewData.Records[intContador].Values[cxgReqViewAUTOINCREM.Index];

      If objRequisicao.cdsRequisicao.FindKey([strAutInc]) And
         (objRequisicao.cdsRequisicao.FieldByName('MARDES').AsInteger <> IIF(blnMarcar, 1, 0)) And
         ((Not blnMarcar) Or (fLock_Unlock(objRequisicao.fRetChaveSelecao(objRequisicao.cdsRequisicao.FieldByName('AUTOINCREM').AsString), True, False))) Then
      Begin

        If objRequisicao.fPodeMarcarDesmarcarRequisicao(False, True) Then
        Begin
          objRequisicao.cdsRequisicao.Edit;

          If blnMarcar Then
          Begin
            objRequisicao.cdsRequisicao.FieldByName('MARDES').AsInteger := 1
          End Else
          Begin

            objRequisicao.cdsRequisicao.FieldByName('MARDES').AsInteger := 0;

            If blnNegar And
               fEmptyStr(objRequisicao.cdsRequisicao.FieldByName('DOCPDV').AsString) Then
              objRequisicao.cdsRequisicao.FieldByName('NEGADA').AsInteger := 1;

            If (objRequisicao.cdsRequisicao.FieldByName('NEGADA').AsInteger <> 1) Then
              fLock_Unlock(objRequisicao.fRetChaveSelecao(objRequisicao.cdsRequisicao.FieldByName('AUTOINCREM').AsString), False, False);
          End;

          objRequisicao.cdsRequisicao.Post;
        End;

      End;
    End;

    cxgProgresso.Position := cxgProgresso.Position + 1;
    Application.ProcessMessages;
  End;

  Result := True;
End;

Function TfrmCadCotItensImpRequisicao.fConfirmaNegativa: Boolean;
var
  fltSalDis: Double;
  frmJustificaNegativa: TfrmJustificaNegativa;
Begin
  With objRequisicao.cdsRequisicao Do
  Begin

    pCriarFormularios(TfrmJustificaNegativa, frmJustificaNegativa);

    frmJustificaNegativa.rdgMotNeg.ItemIndex := FieldByName('MOTNEG').AsInteger;
    frmJustificaNegativa.mmoJUSTIF.Text := FieldByName('JUSTIF').AsString;

    Result := frmJustificaNegativa.ShowModal = mrOk;

    If Result And (frmJustificaNegativa.rdgMotNeg.ItemIndex = 1) Then
    Begin
      fltSalDis := fRetornaSaldoDisponivel(FieldByName('CODITE').AsString,
                                           False,
                                           True,
                                           '',
                                           True,
                                           FieldByName('EMPITE').AsString) - FieldByName('SALEND').AsFloat;
      If fFormataFloat(fltSalDis, 3) <
         fFormataFloat(FieldByName('QTDITE').AsFloat, 3) Then
      Begin
        pMensagemOk('Não há saldo disponível em estoque na empresa de faturamento: ' +
          FieldByName('EMPITE').AsString + ' para negar a requisição ' +
          'com o motivo "Produto já possui saldo em estoque"!');
        Result := False;
      End;
    End;


    If Result Then
    Begin
      Edit;
      FieldByName('MOTNEG').AsInteger := frmJustificaNegativa.rdgMotNeg.ItemIndex;
      FieldByName('JUSTIF').AsString  := frmJustificaNegativa.mmoJUSTIF.Text;
      Post;
    End;

    pFreeAndNil(frmJustificaNegativa);
  End;
End;

procedure TfrmCadCotItensImpRequisicao.btnNegarClick(Sender: TObject);
  Var
    intRecNo: Integer;
begin
  inherited;

  If Not btnNegar.Visible Then
    Exit;

  With objRequisicao.cdsRequisicao Do
  Begin

    If IsEmpty Then
      Exit;

    intRecNo := objRequisicao.cdsRequisicao.RecNo;

    Try

      If Not objRequisicao.fPodeMarcarDesmarcarRequisicao(True, False) Then
        Exit;

      If FieldByName('NEGADA').AsInteger = 0 Then
      Begin

        If (objRequisicao.tpoOperacao <> tpoPainel) And (FieldByName('MARDES').AsInteger = 1) Then
        Begin
          pMensagemOk('Essa requisição está marcada para compra!');
          Exit;
        End;

        If not ((objRequisicao.tpoOperacao = tpoPainel) And (FieldByName('MARDES').AsInteger = 1) and fCfgSis('VPRPCC', varBoolean)) Then
        If FieldByName('MARANT').AsInteger = 1 Then
        Begin

          pMensagemOk('Para negar essa requisição é necessário, primeiramente, confirmar o' + #13#10 +
                      'desvínculo com o pedido de compra através do botão [F10] e ' + #13#10 +
                      'posteriomente negar a requisição!');
          Exit;
        End;

        If ((objRequisicao.tpoOperacao = tpoPainel) And (FieldByName('MARDES').AsInteger = 1) and fCfgSis('VPRPCC', varBoolean)) Then
        Begin
          pMensagemOk('Esta requisição não pode ser negada, pois tem pedido vinculado a ela!');
          Exit;
        End;

        If fConfirmaNegativa Then
        Begin

          If fLock_Unlock(objRequisicao.fRetChaveSelecao(FieldByName('AUTOINCREM').AsString), True, False) Then
          Begin
            Edit;
            FieldByName('NEGADA').AsInteger := 1;
            Post;
          End Else
          Begin
            pMensagemOk('Esta requisição está sendo utilizado por outra estação: ' + fGetHostLock(objRequisicao.fRetChaveSelecao(FieldByName('AUTOINCREM').AsString)));
            Exit;
          End;

        End;

      End Else
      Begin
        Edit;
        FieldByName('NEGADA').AsInteger := 0;
        FieldByName('MOTNEG').AsInteger := 0;
        FieldByName('JUSTIF').AsString  := '';
        Post;

        fLock_Unlock(objRequisicao.fRetChaveSelecao(FieldByName('AUTOINCREM').AsString), False, False);
      End;

    Finally

      pSetFocus(cxgReq);
      objRequisicao.cdsRequisicao.RecNo := intRecNo;

    End;

  End;
end;

procedure TfrmCadCotItensImpRequisicao.btnPedVenClick(Sender: TObject);
begin
  inherited;

  If Assigned(pImprimeDocumento) Then
  With objRequisicao.cdsRequisicao Do
  pImprimeDocumento(FieldByName('DOCPDV').AsString, FieldByName('ESPPDV').AsString, FieldByName('EMPPDV').AsString);
end;

procedure TfrmCadCotItensImpRequisicao.btnAbrirRequisicaoClick(Sender: TObject);
begin
  inherited;
  If not btnAbrirRequisicao.Visible Then
   Exit;

  If objRequisicao.cdsRequisicao.IsEmpty  Then
    pMensagemOk('Nenhuma requisição encontrada!')
  Else If (objRequisicao.tpoOperacao = tpoPedidoCompra) And (objRequisicao.cdsRequisicao.FieldByName('MARDES').AsInteger = 1) Then
  Begin
    fMensagem('ATENÇÃO', 'Desmarque a requisição '+objRequisicao.cdsRequisicao.FieldByName('CODREQ').AsString+' antes de editar.', ['&Ok']);
  End
  Else
  If assigned(prcExibeRequisicaoCompra) Then
    prcExibeRequisicaoCompra(objRequisicao.cdsRequisicao.FieldByName('CODREQ').AsString,
        objRequisicao.cdsRequisicao.FieldByName('CODEMP').AsString);
  objRequisicao.fCarregaRequisicoes('', objRequisicao.recOpcGir);
end;

procedure TfrmCadCotItensImpRequisicao.btnAlterarItensEspeciaisReqClick(
  Sender: TObject);
var
  strCodReq,
  strCodEmp: String;
  blnConfirmadoAlteracaoRequisicaoCompra: Boolean;
begin
  inherited;
  strCodReq := cxgReqView.DataController.DataSet.FieldByName('CODREQ').AsString;
  strCodEmp := cxgReqView.DataController.DataSet.FieldByName('CODEMP').AsString;

  if Assigned(procChamaAtualizaProdReqSemOS) then
  begin
    procChamaAtualizaProdReqSemOS(strCodReq, strCodEmp, blnConfirmadoAlteracaoRequisicaoCompra);
    if blnConfirmadoAlteracaoRequisicaoCompra then
      objRequisicao.fCarregaRequisicoes('', objRequisicao.recOpcGir);

  end;
end;

procedure TfrmCadCotItensImpRequisicao.btnMostrarPedidodVendaClick(Sender: TObject);
Var
  blnFatPedido,
  blnReimpressaoDocs2: Boolean;
begin
  inherited;
  blnFatPedido := fVerificaAcessoSistema('frmFatVendas - PD');
  blnReimpressaoDocs2 := fVerificaAcessoSistema('frmReimpressaoDocs2');
  if blnFatPedido Or
     blnReimpressaoDocs2 then
    TfrmGravando.fExecutarModalA(pGerarPDF, 'Aguarde... Gerando Arquivo (.PDF)', '')
  else
    fMensagem('ATENÇÃO', 'Operador sem acesso à rotina de Pedido ou Reimpressão de Documentos.', ['&Ok']);
end;

procedure TfrmCadCotItensImpRequisicao.btnObsPedClick(Sender: TObject);
Var
    frmInfPedido: TfrmInfPedido;
begin
  inherited;
  Try

    With objRequisicao.cdsRequisicao Do
      Begin

      If IsEmpty Then
      Begin
        pMensagemOk('Selecione um pedido!');
        Exit;
      End;

      if FieldByName('DOCPDV').AsString = '' Then
      Begin
        pMensagemOk('Essa requisição não esta associada a nenhum pedido de venda!');
        Exit;
      End;

      If Not fVerificaAcessoSistema('frmFatVendas - ' + FieldByName('ESPPDV').AsString) Then
      Begin
        If FieldByName('ESPPDV').AsString = 'PD' Then
          fMensagem('', 'Usuário não possui permissão de acesso para o módulo de pedido de vendas!', ['&Ok'])
        Else
          fMensagem('', 'Usuário não possui permissão de acesso para o módulo de orçamentos!', ['&Ok']);
        Exit;
      End;

      pCriarFormularios(TfrmInfPedido, frmInfPedido);

      frmInfPedido.strNumDoc := FieldByName('DOCPDV').AsString;
      frmInfPedido.strEspDoc := FieldByName('ESPPDV').AsString;
      frmInfPedido.strCodEmp := FieldByName('CODEMP').AsString;
      frmInfPedido.strCodCli := FieldByName('CODCLI').AsString;

    End;

    frmInfPedido.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
  pFreeAndNil(frmInfPedido);
  pSetFocus(cxgReq);
end;

procedure TfrmCadCotItensImpRequisicao.bntGerarCotacaoClick(Sender: TObject);
begin
  inherited;
  If Not bntGerarCotacao.Visible Then
    Exit;
  If Assigned(FProcIniciaCotacao) Then
  Begin
    FProcIniciaCotacao;
    objRequisicao.fCarregaRequisicoes('', objRequisicao.recOpcGir);
  End;
end;

procedure TfrmCadCotItensImpRequisicao.btnAssPedComClick(Sender: TObject);
   Var
     intRecNo: Integer;
begin
  inherited;

  If Not btnAssPedCom.Visible Then
    Exit;

  If objRequisicao.cdsRequisicao.IsEmpty Then
    Exit;

  If Not objRequisicao.fPodeMarcarDesmarcarRequisicao(True, False) Then
    Exit;

  If (objRequisicao.cdsRequisicao.FieldByName('MARDES').AsInteger = 0) And (Not fMarcaDesmarca) Then
    Exit;

  If (objRequisicao.tpoOperacao = tpoPainel) And fCfgSis('VPRPCC', varBoolean) Then
    if (objRequisicao.cdsRequisicao.FieldByName('RCD_SEQPCD').AsString <> '') Then
  Begin
    pMensagemOk('Esta requisição já está vinculada ao pedido ' + objRequisicao.cdsRequisicao.FieldByName('PCD_NUMPED').AsString);
    Exit;
  End;

  intRecNo := objRequisicao.cdsRequisicao.RecNo;

  objRequisicao.pMostraPedidosDisponiveis;

  pSetFocus(cxgReq);

  objRequisicao.cdsRequisicao.RecNo := intRecNo;
end;

procedure TfrmCadCotItensImpRequisicao.btnAtualizarProdOSClick(Sender: TObject);
var
  strCodReq,
  strCodEmp: String;
  blnConfirmadoAlteracaoRequisicaoCompra : Boolean;
begin
  inherited;

  strCodReq := cxgReqView.DataController.DataSet.FieldByName('CODREQ').AsString;
  strCodEmp := cxgReqView.DataController.DataSet.FieldByName('CODEMP').AsString;

  if Assigned(procChamaAtualizaProdReqOrdemServico) then
  begin
    procChamaAtualizaProdReqOrdemServico(strCodReq, strCodEmp, blnConfirmadoAlteracaoRequisicaoCompra);
    if blnConfirmadoAlteracaoRequisicaoCompra then
      objRequisicao.fCarregaRequisicoes('', objRequisicao.recOpcGir);
  end;


end;

procedure TfrmCadCotItensImpRequisicao.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  if not Self.FecharFormAoConfirmar then
  begin
    cxgReqView.DataController.DataSource := nil;
    objRequisicao.Confirmar;
    objRequisicao.RecarregarRequisicoes;
    cxgReqView.DataController.DataSource := objRequisicao.cdsRequisicao.dtsSource;
  end;
end;

procedure TfrmCadCotItensImpRequisicao.btnDesTodosClick(Sender: TObject);
  Var blnCancelar: Boolean;
begin
  If Not btnDesTodos.Visible Then
    Exit;

  blnNegar := objRequisicao.fConfirmaNegarRequisicoesSemPedidoVenda(blnCancelar);

  If blnCancelar Then
    Exit;

  blnMarcar := False;
  TfrmGravando.fExecuta(fMarcaDesmarcaTodos, frmGravando);

  blnNegar  := False;
end;

procedure TfrmCadCotItensImpRequisicao.btnGerarPedidoCompraClick(
  Sender: TObject);
begin
  inherited;
   If Not btnGerarPedidoCompra.Visible Then
    Exit;
 If Assigned(FProcIniciaPedComp) Then
  begin
    FProcIniciaPedComp;
    objRequisicao.fCarregaRequisicoes('', objRequisicao.recOpcGir);
  End;
end;

Procedure TfrmCadCotItensImpRequisicao.cxgReqViewCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  fMarcaDesmarca;
end;

procedure TfrmCadCotItensImpRequisicao.cxgReqViewColumn1GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If AText = '0,00' THen
   AText := EmptyStr;
end;

procedure TfrmCadCotItensImpRequisicao.cxgReqViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin

  // REQUISICOES COM PEDIDOS COM NOTAS DE ENTRADA ESPERANDO EFETIVACAO
  If Not fEmptyStr(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgReqViewNOTAS.Index])) Then
  Begin

    If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgReqViewMARDES.Index] = 1 Then
      ACanvas.Brush.Color := shpAguaEfet.Brush.Color
    Else
      ACanvas.Brush.Color := shpAguaEfetOut.Brush.Color;

    ACanvas.Font.Color := clBlack;
  End

  Else If Not fEmptyStr(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgReqViewAUTDET.Index])) Then
  Begin

    If AViewInfo.Selected Then
      ACanvas.Brush.Color := $008080FF
    Else
      ACanvas.Brush.Color := shpAssOutPed.Brush.Color;

    ACanvas.Font.Color := clBlack;

  End

  Else If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgReqViewMARDES.Index] = 1 Then
  Begin

    If AViewInfo.Selected Then
      ACanvas.Brush.Color := $00FF6464
    Else
      ACanvas.Brush.Color := shpAssPed.Brush.Color;

    ACanvas.Font.Color := clWhite;

  End
  Else
  Begin

    If AViewInfo.Selected Then
      ACanvas.Brush.Color := $00FFD2D2
    Else
      ACanvas.Brush.Color := clWhite;

    ACanvas.Font.Color := clBlack;

  End;
end;

procedure TfrmCadCotItensImpRequisicao.cxgReqViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN Then
    fMarcaDesmarca;
end;

function TfrmCadCotItensImpRequisicao.fArquivoParaString(strNomArq: String): String;
  Var
    stlArq: TStringList;
begin
  Try
    stlArq := TStringList.Create;
    stlArq.LoadFromFile(strNomArq);
    Result := stlArq.Text;
  Except
    Result := '';
  End;

  FreeAndNil(stlArq);
end;

Procedure TfrmCadCotItensImpRequisicao.pSalvaConfiguracoesGrid;
  Var
    qryCfgPdc: TUniQuery;
    strArqTemp: String;
Begin
  strArqTemp := fCriarArquivoTemporario('', fGetPathTempOpcoesLocais);
    cxgReqView.StoreToIniFile(strArqTemp, True, [gsoUseFilter, gsoUseSummary]);

  qryCfgPdc := fCriaQuery;

  With qryCfgPdc, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT * FROM CFGREQ');
    Add('WHERE CFG_CODOPE = :CODOPE');
    ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

    Open;

    If IsEmpty Then
    Begin
      qryCfgPdc.Insert;
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CFGREQ', VS_strCodEmp);
    End Else
    Begin
      Edit;
    End;

    FieldByName('CFG_CFGGRI').AsString := fArquivoParaString(strArqTemp);
    FieldByName('CFG_CODOPE').AsString := strLoginUsuarioLogado;

    Post;

    DeleteFile(PChar(strArqTemp));

  End;

  FreeAndNil(qryCfgPdc);
End;

procedure TfrmCadCotItensImpRequisicao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin
    objRequisicao.Confirmar;

  End Else
  Begin

    If objRequisicao.blnAlterouDados Then
    Begin

      If Not fPergunta('Foram alterados os pedidos que atenderão as requisições. Deseja realmente cancelar?') Then
      Begin
        Action := caNone;
        Exit;
      End;

    End;

    pLiberaTravaCancelados;

    objRequisicao.cdsRequisicao.Data := varCDSDataBkp;
    objRequisicao.cdsPedidosDisponiveis.Data := varCDSDisponiveisBkp;
    objRequisicao.stlItensJaPesquisados.Text := strItensPesquisados;

    objRequisicao.pFormataDisponiveis;
    objRequisicao.pFormataCdsRequisicao;

  End;

  pSalvaConfiguracoesGrid;
end;

procedure TfrmCadCotItensImpRequisicao.pLiberaTravaCancelados;
Begin
  With objRequisicao.cdsRequisicao do
  Try

    Filter   := 'MARDES = 1 AND MARANT = 0';
    Filtered := True;

    First;

    While Not Eof Do
    Begin
      fLock_Unlock(objRequisicao.fRetChaveSelecao(FieldByName('AUTOINCREM').AsString), False, False);

      Next;
    End;

  Finally

    Filtered := False;

  End;

End;

procedure TfrmCadCotItensImpRequisicao.FormCreate(Sender: TObject);
begin
  inherited;
  blnNegar := False;
  pImprimeDocumento := Nil;
  btnAlterarItensEspeciaisReq.Visible := fVerificaAcessoSistema(DIRACE_ALTERAR_REQ_COMPRA_TROCA_ITEM_ESPECIAL, strLoginUsuarioLogado);
  FecharFormAoConfirmar := True;
end;

procedure TfrmCadCotItensImpRequisicao.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F12: btnMostrarPedidodVenda.Click;
    VK_F11: btnAbrirRequisicao.Click;
    VK_F10: Begin
              btnConfirmar.Click;
              Key := 0;
            End;

    VK_F5: If ssAlt In Shift Then
             btnAssPedCom.Click
           Else
             btnPedVen.Click;

    VK_F6: If ssAlt In Shift Then
             btnAtualizarProdOS.Click
           Else
             btnMarDes.Click;

    VK_F7: if ssAlt in Shift then
           begin
            if btnAlterarItensEspeciaisReq.Visible then
              btnAlterarItensEspeciaisReq.Click;
           end
           else
            btnDesTodos.Click;

    VK_F8: if ssAlt In Shift Then
              btnObsPed.Click
           Else
              btnMarTodos.Click;

    VK_F9: btnNegar.Click;

    VK_F4: btnMostraEstoque.Click;

    VK_F3: btnGerarPedidoCompra.Click;

    VK_F2: bntGerarCotacao.Click;

    VK_ESCAPE: Begin
                 btnSair.Click;
                 Key := 0;
               End;
  End;
end;

function TfrmCadCotItensImpRequisicao.fCriarArquivoTemporario(strNomArq: String = ''; strPathTmp: String = ''): String;
Var
  Caminho  : PChar;
  Arquivo  : file;
  strDirVal: String;

  function GetSpecialFolderPath(Folder: Integer; CanCreate: Boolean): String;
    Var
      FilePath: array [0..255] of Char;
  Begin
    SHGetSpecialFolderPath(0, @FilePath[0], FOLDER, CanCreate);
    Result := FilePath;
  End;

begin
  Result := '';

  Try
    If fEmptyStr(strPathTmp) Then
    Begin
      strDirVal := GetSpecialFolderPath(CSIDL_APPDATA, False) + '\Autcom\';

      If Not DirectoryExists(strDirVal) Then
        CreateDir(strDirVal);

      Caminho := PChar(strDirVal);
    End
    Else
      Caminho := PChar(strPathTmp);

    If fEmptyStr(strNomArq) Then
    Begin
      Result := Caminho + IntToStr(RandomRange(0, 99999));

      While FileExists(Result) Do
      Begin
        Result := Caminho + IntToStr(RandomRange(0, 99999));
      End;
    End
    Else
    Begin
      Result := Caminho + strNomArq;
    End;

    AssignFile(Arquivo, Result);
    Rewrite(Arquivo);

  Finally
    CloseFile(Arquivo);
  End;
end;

function TfrmCadCotItensImpRequisicao.fGetPathTempOpcoesLocais: String;
  Var
    Buffer: Array[0..254] Of Char;
    strPatIni: String;
    iniArqIni : TIniFile;
begin
  Result := '';
  GetWindowsDirectory(Buffer, 255);
  strPatIni := StrPas(Buffer) + '\OPCOES_LOCAIS.INI';

  If FileExists(strPatIni) Then
  Begin
    iniArqIni := TIniFile.Create(strPatIni);
    Try
      Result := iniArqIni.ReadString('ARQUIVOS_TEMPORARIOS', 'PATH' , Result)
    Finally
      iniArqIni.Free;
    End;
  End;
end;

function TfrmCadCotItensImpRequisicao.fEscreverNoArquivo(strNomArq, strTexto: String): Boolean;
Var
  Arquivo: TextFile;
begin
  Result := True;

  Try

    If Not FileExists(strNomArq) Then
    Begin
      Result := False;
    End
    Else
    Begin
      AssignFile(Arquivo, strNomArq);
      Rewrite(Arquivo);
      Write(Arquivo, strTexto);
    End;

  Finally
    CloseFile(Arquivo);
  End;
end;

Procedure TfrmCadCotItensImpRequisicao.pCarregaConfiguracoesGrid;
  Var
    qryCfgPdc: TUniQuery;
    strArqTemp: String;
Begin
  qryCfgPdc := fCriaQuery;

  With qryCfgPdc, SQL Do
  Begin
    Clear;
    Add('SELECT * FROM CFGREQ');
    Add('WHERE CFG_CODOPE = :CODOPE');

    ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

    Open;

    If Not IsEmpty Then
    Begin
      strArqTemp := fCriarArquivoTemporario('', fGetPathTempOpcoesLocais);

      If fEscreverNoArquivo(strArqTemp, FieldByName('CFG_CFGGRI').AsString) Then
      Begin
        cxgReqView.RestoreFromIniFile(strArqTemp);
        DeleteFile(PChar(strArqTemp));
      End;

    End;

  End;

  FreeAndNil(qryCfgPdc);
End;

procedure TfrmCadCotItensImpRequisicao.FormShow(Sender: TObject);
begin
  inherited;

  varCDSDataBkp        := objRequisicao.cdsRequisicao.Data;

  varCDSDisponiveisBkp := objRequisicao.cdsPedidosDisponiveis.Data;

  strItensPesquisados := objRequisicao.stlItensJaPesquisados.Text;

  objRequisicao.blnAlterouDados := False;

  cxgReqView.DataController.DataSource := objRequisicao.cdsRequisicao.dtsSource;
  dbeObserv.DataSource:= cxgReqView.DataController.DataSource;

  cxgReqView.NavigatorButtons.First.Click;

  btnPedVen.Visible := Assigned(pImprimeDocumento);

  lblMsgTransferencia.Visible := Not fEmptyStr(objRequisicao.strDocOri);
  lblMsgTransferencia.Caption := 'O pedido de compra ' + objRequisicao.FstrNumPed + ' provém de uma transferência e não pode ser associado a requisições.';

  btnMarDes.Enabled    := ((Not fEmptyStr(objRequisicao.strCodCmp)) And (fEmptyStr(objRequisicao.strDocOri) Or SameText(objRequisicao.strDocOri, objRequisicao.FstrNumPed + objRequisicao.FStrEspdoc + objRequisicao.FStrCodEmp))) And (objRequisicao.tpoOperacao <> tpoPainel);
  btnDesTodos.Enabled  := ((Not fEmptyStr(objRequisicao.strCodCmp)) And (fEmptyStr(objRequisicao.strDocOri) Or SameText(objRequisicao.strDocOri, objRequisicao.FstrNumPed + objRequisicao.FStrEspdoc + objRequisicao.FStrCodEmp))) And (objRequisicao.tpoOperacao <> tpoPainel);
  btnMarTodos.Enabled  := ((Not fEmptyStr(objRequisicao.strCodCmp)) And (fEmptyStr(objRequisicao.strDocOri) Or SameText(objRequisicao.strDocOri, objRequisicao.FstrNumPed + objRequisicao.FStrEspdoc + objRequisicao.FStrCodEmp))) And (objRequisicao.tpoOperacao <> tpoPainel);
  btnNegar.Enabled     := (Not fEmptyStr(objRequisicao.strCodCmp))  Or (objRequisicao.tpoOperacao = tpoPainel);
  btnAssPedCom.Enabled := (Not fEmptyStr(objRequisicao.strCodCmp)) Or (objRequisicao.tpoOperacao = tpoPainel);

  btnMarDes.Visible    := (objRequisicao.tpoOperacao <> tpoPainel);
  btnDesTodos.Visible  := (objRequisicao.tpoOperacao <> tpoPainel);
  btnMarTodos.Visible  := (objRequisicao.tpoOperacao <> tpoPainel);

  cxgReqViewSALDIS.Visible := (objRequisicao.tpoOperacao = tpoPedidoCompra) Or (objRequisicao.tpoOperacao = tpoPainel);
  cxgReqViewQTDPEN.Visible := (objRequisicao.tpoOperacao = tpoPedidoCompra) Or (objRequisicao.tpoOperacao = tpoPainel);
  cxgReqViewREQPCD.Visible := (objRequisicao.tpoOperacao = tpoPedidoCompra) Or (objRequisicao.tpoOperacao = tpoPainel);
  cxgReqViewQTDPEN_TODAS.Visible := (objRequisicao.tpoOperacao = tpoPedidoCompra) Or (objRequisicao.tpoOperacao = tpoPainel);
  cxgReqViewQTDDIS_TODAS.Visible := (objRequisicao.tpoOperacao = tpoPedidoCompra) Or (objRequisicao.tpoOperacao = tpoPainel);

  btnMostraEstoque.Visible:= objRequisicao.tpoOperacao = tpoPainel;

  If objRequisicao.tpoOperacao = tpoPainel Then
    pnlBotoes.Height := 50
  Else
    pnlBotoes.Height := 27;

  btnGerarPedidoCompra.Visible:= objRequisicao.tpoOperacao = tpoPainel;
  bntGerarCotacao.Visible:= objRequisicao.tpoOperacao = tpoPainel;

  pnlLegendas.Visible:= objRequisicao.tpoOperacao <> tpoPainel;

  lblDisponivel.Visible := cxgReqViewSALDIS.Visible;

  cxgReqViewNUMOSE.Visible := fCfgSis('CONEQU', varBoolean) and fCfgSis('SLRCON', varBoolean);
  cxgReqViewEMPOSE.Visible := cxgReqViewNUMOSE.Visible;
  cxgReqViewPROTOC.Visible := cxgReqViewNUMOSE.Visible;
  cxgReqViewGarant.Visible := cxgReqViewNUMOSE.Visible;
  btnAtualizarProdOS.Visible := fCfgSis('CONEQU', varBoolean) and (fVerificaAcessoSistema('frmConEquipAtualizaProdutosReqCompra'));

  pCarregaConfiguracoesGrid;

  cxgReqViewRCD_DTPREV.Visible := fCfgSis('PRVEST', varBoolean);

  cxgReqViewSTATUS.Visible := fCfgSis('EXISTA', varBoolean) And (objRequisicao.tpoOperacao = tpoPainel);

  If (objRequisicao.tpoOperacao = tpoPainel) And fCfgSis('VPRPCC', varBoolean) Then
  Begin
    cxgReqViewPCD_NUMPED.Visible := True;
    cxgReqViewFORNEC.Visible := True;
    cxgReqViewQTDPED.Visible := True;
    cxgReqViewPCD_DTAENT.Visible := True;
  End
  Else
  Begin
    cxgReqViewPCD_NUMPED.Visible := False;
    cxgReqViewFORNEC.Visible := False;
    cxgReqViewQTDPED.Visible := False;
    cxgReqViewPCD_DTAENT.Visible := False;
  End;



  If Not fEmptyStr(objRequisicao.strCodCmp) Then
  Begin
    cxgReqView.DataController.Filter.BeginUpdate;

    Try
      cxgReqView.DataController.Filter.Root.Clear;

      cxgReqView.DataController.Filter.Root.AddItem(cxgReqViewOPERES, foEqual, objRequisicao.strCodCmp, objRequisicao.strCodCmp);

     Finally
       cxgReqView.DataController.Filter.EndUpdate;
       cxgReqView.DataController.Filter.Active := fCfgSis('RQFCMP', varBoolean);
     End;
  End;

  if FecharFormAoConfirmar then
    btnConfirmar.ModalResult := mrOk
  else
    btnConfirmar.ModalResult := mrNone;
end;


Function TfrmCadCotItensImpRequisicao.fMarcaDesmarca: Boolean;
begin
  Result := True;
  With objRequisicao.cdsRequisicao Do
  Begin
    If IsEmpty Then
      Exit;

    If (objRequisicao.tpoOperacao = tpoPainel) Then
      Exit;

    If fEmptyStr(objRequisicao.strCodCmp) Then
      Exit;

    If Not objRequisicao.fPodeMarcarDesmarcarRequisicao(True, True) Then
      Exit;

    If (FieldByName('MARDES').AsInteger = 0) Then
    Begin

      If Not fLock_Unlock(objRequisicao.fRetChaveSelecao(objRequisicao.cdsRequisicao.FieldByName('AUTOINCREM').AsString), True, False) Then
      Begin
        pMensagemOk('Esta requisição está sendo utilizado por outra estação: ' + fGetHostLock(objRequisicao.fRetChaveSelecao(objRequisicao.cdsRequisicao.FieldByName('AUTOINCREM').AsString)));
        Result := False;
        Exit;
      End;

    End;

    Edit;

    If (FieldByName('MARDES').AsInteger = 1) And fEmptyStr(FieldByName('EMPPDV').AsString) And (btnNegar.Enabled) And
       fPergunta('Esta requisição não está mais vinculada a nenhum pedido de venda.' + #13#10 +
                 'Deseja negá-la imediatamente?' + #13#10 +
                 'Se ( SIM ), o Sistema irá baixá-la.' + #13#10 +
                 'Se ( NÃO ), o Sistema irá deixá-la disponível para ser incluída no próximo pedido de compra.') Then
      FieldByName('NEGADA').AsInteger := 1;

    If FieldByName('MARDES').AsInteger = 0 Then
      FieldByName('MARDES').AsInteger := 1
    Else
    Begin
      FieldByName('MARDES').AsInteger := 0;

      objRequisicao.pAdicionarItemDesmarcado;

      //If FieldByName('NEGADA').AsInteger <> 1 Then
        fLock_Unlock(objRequisicao.fRetChaveSelecao(objRequisicao.cdsRequisicao.FieldByName('AUTOINCREM').AsString), False, False);
    End;

    Post;
  End;

  cxgReqView.DataController.Refresh;
end;



procedure TfrmCadCotItensImpRequisicao.pGerarPDF;
Var
  strArquivo : String;
  strOrdem   : String;
  blnComMar,
  blnLocFis  : Boolean;
  strModo    : String;
  strNomEmp  : String;
  blnCabCD   : Boolean;
Begin

  Try
    strOrdem  := '1';
    strNomEmp := 'R';
    blnComMar := True;
    blnLocFis := False;
    strModo   := 'R';
    blnCabCD  := False;

    If fEmptyStr(objRequisicao.cdsRequisicao.FieldByName('DOCPDV').AsString) Then
      raise Exception.Create('Esta requisição não está vinculada a nenhum pedido de venda.');

    Application.ProcessMessages;
    strArquivo := funGerarEmail(objRequisicao.cdsRequisicao.FieldByName('DOCPDV').AsString,
                                objRequisicao.cdsRequisicao.FieldByName('ESPPDV').AsString,
                                impComPrecoGeral,
                                blnComMar,
                                'P', {P = PDF | E = Excel}
                                strModo,
                                strOrdem,
                                objRequisicao.cdsRequisicao.FieldByName('EMPPDV').AsString,
                                blnLocFis,
                                strNomEmp,
                                objRequisicao.cdsRequisicao.FieldByName('CODCLI').AsString,
                                blnCabCD);


    If (Not fEmptyStr(strArquivo)) Then
    Begin
      If VirtualUI.Active Then
        VirtualUI.PreviewPdf(strArquivo)
      Else
        pExecArquivo(strArquivo, Handle);
    End;
  Except
    On E:Exception Do
      fMensagem('Atenção!', e.message, ['&OK']);
  End;

end;


end.
