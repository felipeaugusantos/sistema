unit untSelPedidoAdiantamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  untAdiantamentoCliente, Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls,
  Grids, DBGridCitel, DBGrids, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, EditFocus, System.ImageList, Vcl.ImgList,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  untTypesSistema, cxClasses, cxGridCustomView, cxGrid, cxImageComboBox,
  untTLock, untAdiantamentoClienteGenerico, Shared.Functions.DataSet,
  Data.DB, Datasnap.DBClient, untTPixDao, UniCLientDataset,
  CobrancaEletronica.Lib.Types, CobrancaEletronica.Lib.Facade,
  System.StrUtils;

type
  TfrmSelPedidoAdiantamento = class(TfrmPai)
    dtsPedidos: TDataSource;
    btnConfirma: TBitBtnLocked;
    imglSitAdt: TImageList;
    cxgPedidos: TcxGrid;
    cxgPedidosDados: TcxGridDBTableView;
    cxgPedidosNivel: TcxGridLevel;
    btnAtualizar: TBitBtnLocked;
    btnPadrao: TBitBtnLocked;
    btnConsultarAdiantamentos: TBitBtnLocked;
    btnBolAdi: TBitBtnLocked;
    btnCfgAdt: TBitBtnLocked;
    cxgPedidosDadosCONPAG: TcxGridDBColumn;
    cxgPedidosDadosCND_CNDPAG: TcxGridDBColumn;
    cxgPedidosDadosCND_DESCRI: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxgPedidosDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnPadraoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConsultarAdiantamentosClick(Sender: TObject);
    procedure btnBolAdiClick(Sender: TObject);
    procedure btnCfgAdtClick(Sender: TObject);
  private
    qryPedidos: TUniQuery;
    intRecNo: Integer;
    mmsLayoutDefault: TMemoryStream;

    FCodigoDoCaixa: String;

    procedure pVisibilidadeColunas;
    function fGetChaveLayoutGrid: String;
    procedure pGravarConfiguracoesAdiantamento;
    procedure pCriarColunasGrid;

    function fVerificaPixExpiradoOuNaoGeradoPedido(): Boolean;

    procedure RecebimentoDePedidoComPixGerado;
    function TravarRegistroDoPix(ATravar: Boolean): Boolean;
    procedure pInformaCondicaoPagamento;

    function fVerificaPedidoLinkPagamentoCitel : Boolean;
    function fVerificaPedidoCobrancaEletronica(
      const ATipoCobrancaEletronica: TTipoCobrancaEletronica) : Boolean;
  protected
    { Private declarations }
  public
    { Public declarations }
    blnConfirma: Boolean;
    strCodOpe: String;
    strOrigem: String;
    documentos: TArrDocAdiantamento;
    objLock: TLock;

    property CodigoDoCaixa: String read FCodigoDoCaixa write FCodigoDoCaixa;
  end;

implementation

{$R *.dfm}

uses untConsultas, untFuncoesSimples, untAlpe, untFuncoes, untFuncFat,
  untFatInfBoleto, untCadRec, untBoleto, untFatGor, untConstantesNFe,
  untConfigAdiantamento, untCfgColAdt, untGravando, untTFuncoesPixAutcom,
  untLinkPagamentoCitelUtil, untTiposPix, untClassesComumLinkPagamentoCitel;

procedure TfrmSelPedidoAdiantamento.btnAtualizarClick(Sender: TObject);
begin
  inherited;
  dtsPedidos.DataSet := nil;
  try
    TAdiantamento.fCarregaPedidos(qryPedidos);
    pInformaCondicaoPagamento;
    pVisibilidadeColunas;
  finally
    dtsPedidos.DataSet := qryPedidos;
  end;
end;

procedure TfrmSelPedidoAdiantamento.btnBolAdiClick(Sender: TObject);
var
  frmFatInfBoleto: TfrmFatInfBoleto;
  strConPag: string;
  intQtdDup   : Integer;
  curTotalRes : Currency;
  fltValBol: Double;
  strParcela,
  strPortador: string;
  dtaDtaVen: TDate;
  arrDupCtr: TArrDupCtr;
  strAutIncCTR: string;
  objVenDig: IMyCampoTabela;
  fltValPedido: Double;
  strChave: string;
  strAutIncAlt: string;
  blnPersisteCadRec: Boolean;
  strCodCnd: string;
  arrDuplicata: TarrDuplicata;
begin
  inherited;
  pZeraDigDuplic(arrDuplicata);

  if not btnBolAdi.Visible then
    Exit;

  if qryPedidos.RecNo <= 0 then
    Exit;

  strAutIncAlt := EmptyStr;

  strChave := 'GERA_BOLETO_PEDIDO_ADIANTAMENTO_' + qryPedidos.FieldByName('FGO_NUMDOC').AsString + '_' + qryPedidos.FieldByName('FGO_ESPDOC').AsString + '_' + qryPedidos.FieldByName('FGO_CODEMP').AsString;

  fltValPedido := qryPedidos.FieldByName('FGO_VLRCON').AsFloat - qryPedidos.FieldByName('VLRADT').AsFloat;

  if fltValPedido <= 0 then
  begin
    fMensagem('ATENÇÃO!', 'Este pedido já foi completamente recebido.', ['&Ok']);
    Exit;
  end;

  if fPedidoTemBoletoAdiantamento(qryPedidos.FieldByName('FGO_NUMDOC').AsString,qryPedidos.FieldByName('FGO_ESPDOC').AsString,qryPedidos.FieldByName('FGO_CODEMP').AsString) then
  begin
    if fEmptyStr(fTrazNosNumDupZero(qryPedidos.FieldByName('FGO_NUMDOC').AsString, 'A', qryPedidos.FieldByName('FGO_ESPDOC').AsString, Copy(qryPedidos.FieldByName('NOMCLI').AsString, 1, 8), qryPedidos.FieldByName('FGO_CODEMP').AsString)) then
    begin
      strAutIncAlt := untcadRec.fRetAutIncCadRecSeqBaiZero(qryPedidos.FieldByName('FGO_NUMDOC').AsString,
                                                           qryPedidos.FieldByName('FGO_ESPDOC').AsString,
                                                           qryPedidos.FieldByName('FGO_CODEMP').AsString,
                                                           Copy(qryPedidos.FieldByName('NOMCLI').AsString, 1, 8),
                                                           'A');
    end
    else
    begin
      fMensagem('ATENÇÃO!', 'Este pedido já tem boleto(s) de adiantamento gerado(s) e por isso, não pode ser gerado um novo boleto.', ['&Ok']);
      Exit;
    end;
  end;

  If (Not fLock_Unlock(strChave, True, False)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Essa operação já está em andamento em outra estação: ' + fGetHostLock(strChave), ['&Ok']);
    Exit;
  End;

  pCriarFormularios(TfrmFatInfBoleto, frmFatInfBoleto);

  try
    try
      strConPag := fCampoTabela('FGO_CONPAG','FATGOR',['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP'],[qryPedidos.FieldByName('FGO_NUMDOC').AsString,qryPedidos.FieldByName('FGO_ESPDOC').AsString,qryPedidos.FieldByName('FGO_CODEMP').AsString],False);
      strCodCnd := fCampoTabela('FGO_CODCND','FATGOR',['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP'],[qryPedidos.FieldByName('FGO_NUMDOC').AsString,qryPedidos.FieldByName('FGO_ESPDOC').AsString,qryPedidos.FieldByName('FGO_CODEMP').AsString],False);
      if fDigDuplicSemTela(arrDuplicata, intQtdDup, curTotalRes, strConPag, 123, fltValPedido, False, False, VS_Date + fCfgSis('DIABAD', VarInteger), False, 0, 'N', True, False, 0.0, Nil, True, False, Nil, 0, qryPedidos.FieldByName('FGO_ESPDOC').AsString, strCodCnd) then
      begin
        frmFatInfBoleto.FValorTotal := fltValPedido;
        frmFatInfBoleto.FValorBoletoOriginal  := arrDuplicata[0].curValor;
        frmFatInfBoleto.edtBolAdt.Text := FloatToStrF(arrDuplicata[0].curValor, ffFixed, 12, 2);
        frmFatInfBoleto.edtValRes.Text := FloatToStrF(fltValPedido - arrDuplicata[0].curValor, ffFixed, 12, 2);
        frmFatInfBoleto.edtDtaVen.Text := DateToStr(VS_Date + fCfgSis('DIABAD', VarInteger));
        frmFatInfBoleto.ShowModal;

        if frmFatInfBoleto.FConfirma then
        begin
          fStartTransaction;

          fltValBol := fStrToFloat(frmFatInfBoleto.edtBolAdt.Text);
          dtaDtaVen := StrToDateDef(frmFatInfBoleto.edtDtaVen.Text, 0);
          strPortador := fCfgSis('PORAVI');

          objVenDig := fCampoTabela(['AUTOINCREM','FGO_CODVEN','FGO_CODDIG'],'FATGOR',['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP'],[qryPedidos.FieldByName('FGO_NUMDOC').AsString,qryPedidos.FieldByName('FGO_ESPDOC').AsString,qryPedidos.FieldByName('FGO_CODEMP').AsString],False);

          if fEmptyStr(strAutIncAlt) then
          begin
            strParcela := TAdiantamentoGenerico.fRetornaUltimaParcelaBoletosAdiantamento(qryPedidos.FieldByName('FGO_NUMDOC').AsString,
                                                                                         qryPedidos.FieldByName('FGO_ESPDOC').AsString,
                                                                                         qryPedidos.FieldByName('FGO_CODEMP').AsString,
                                                                                         Copy(qryPedidos.FieldByName('NOMCLI').AsString, 1, 8));
            If fEmptyStr(strParcela) Then
              strParcela := 'A'
            Else
              strParcela := fIncAlfaNumerico(strParcela);

            blnPersisteCadRec := untCadRec.fGravaCadRec( self.Name,
                                                         'INCLUSÃO',
                                                         qryPedidos.FieldByName('FGO_NUMDOC').AsString,
                                                         strParcela,
                                                         0,
                                                         qryPedidos.FieldByName('FGO_ESPDOC').AsString,
                                                         Copy(qryPedidos.FieldByName('NOMCLI').AsString, 1, 8),
                                                         qryPedidos.FieldByName('FGO_CODEMP').AsString,
                                                         objVenDig.FieldByName('FGO_CODVEN'),
                                                         objVenDig.FieldByName('FGO_CODDIG'),
                                                         strPortador,
                                                         VS_Date,
                                                         dtaDtaVen,
                                                         fltValBol,
                                                         fltValBol,
                                                         0.0,
                                                         '',
                                                         'BOLETO DE ADIANTAMENTO REF. DOC: '
                                                           + qryPedidos.FieldByName('FGO_NUMDOC').AsString + '-' + qryPedidos.FieldByName('FGO_ESPDOC').AsString + '-' + qryPedidos.FieldByName('FGO_CODEMP').AsString,
                                                         '',
                                                         '',
                                                         '',
                                                         '',
                                                         '',
                                                         0,
                                                         0,
                                                         'S',
                                                         '',
                                                         '',
                                                         '',
                                                         '',
                                                         False,
                                                         '',
                                                         0,
                                                         fltValBol);
          end
          else
          begin
            blnPersisteCadRec := untCadRec.fAlteraValorBoleto(strAutIncAlt, fltValBol, dtaDtaVen);
          end;




          If blnPersisteCadRec Then
          Begin
            if fGravaBoletoExtGor(objVenDig.FieldByName('AUTOINCREM'), fltValBol) then
            begin
              strAutIncCTR := fCampoTabela('AUTOINCREM','CADREC',['CTR_NUMDUP','CTR_ESPDOC','CTR_CODEMP','CTR_CODCLI','CTR_PARCEL'],[qryPedidos.FieldByName('FGO_NUMDOC').AsString,qryPedidos.FieldByName('FGO_ESPDOC').AsString,qryPedidos.FieldByName('FGO_CODEMP').AsString,Copy(qryPedidos.FieldByName('NOMCLI').AsString, 1, 8),strParcela],False);


              SetLength(arrDupCtr,1);
              arrDupCtr[0].strNumDup := qryPedidos.FieldByName('FGO_NUMDOC').AsString;
              arrDupCtr[0].strEspDoc := qryPedidos.FieldByName('FGO_ESPDOC').AsString;
              arrDupCtr[0].strCodEmp := qryPedidos.FieldByName('FGO_CODEMP').AsString;
              arrDupCtr[0].strCodCli := Copy(qryPedidos.FieldByName('NOMCLI').AsString, 1, 8);
              arrDupCtr[0].strParcel := IIF(fEmptyStr(strAutIncAlt), strParcela, 'A');
              arrDupCtr[0].strAutoIn := strAutIncCTR;

              fCommit;

              TBoleto.fImprimirBoletos(arrDupCtr,
                                       True,
                                       True,
                                       'Deseja gerar o boleto?',
                                       self.Name,
                                       '',
                                       '',
                                       False);

              btnAtualizar.Click;
            end
            else
              fRollBack;
          End
          Else
            fRollBack;
        end;
      end;
    except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message,'[TfrmSelPedidoAdiantamento.btnBolAdi]');
      End;
    end;
  finally
    pFreeAndNil(frmFatInfBoleto);
    fLock_Unlock(strChave, False, False);
  end;
end;

procedure TfrmSelPedidoAdiantamento.btnCfgAdtClick(Sender: TObject);
var
  frmConfigAdiantamento: TfrmConfigAdiantamento;
begin
  inherited;

  if (btnCfgAdt.Visible) then
  begin
    pCriarFormularios(TfrmConfigAdiantamento, frmConfigAdiantamento);
    try
      frmConfigAdiantamento.frmSelPedidoAdiantamento := Self;
      frmConfigAdiantamento.ShowModal;

      if (frmConfigAdiantamento.blnConfirma) Then
        TFrmGravando.fExecutarModal(pGravarConfiguracoesAdiantamento, 'Aguarde... Gravando Configurações!', '');
    finally
      pFreeAndNil(frmConfigAdiantamento);
    end;
  end;
end;

procedure TfrmSelPedidoAdiantamento.btnConfirmaClick(Sender: TObject);
Var
  strNumPed     : String;
  strEmpPed     : String;
    objPedidoAlpe: TAlpe;
begin
  inherited;

  {Na J_A_MASSA_CONCRETO não pode adiantar valores no pedido!}
  If (fCfgSis('TPNFCR') = J_A_MASSA_CONCRETO) Then
  Begin

    If fEhPedidoDeConcreto(qryPedidos.FieldByName('FGO_NUMDOC').AsString,
                           qryPedidos.FieldByName('FGO_ESPDOC').AsString,
                           qryPedidos.FieldByName('FGO_CODEMP').AsString) Then
    Begin
      pMensagemOk('Atenção!' + #13 +
                  'Não é permitido realizar adiantamento de Pedido de Concreto.' + #13 +
                  'O financeiro desta movimentação será gerado apenas na rotina "Confirmação de Nota Fiscal - Concreto", ao emitir a Nota de Serviço.');
      Exit;
    End;

  End;

  objPedidoAlpe := TAlpe.Create;
  try
    objPedidoAlpe
    .pCarregaPedidoAlpe(
       qryPedidos.FieldByName('FGO_NUMDOC').AsString,
       qryPedidos.FieldByName('FGO_ESPDOC').AsString,
       qryPedidos.FieldByName('FGO_CODEMP').AsString );

    if Pos(objPedidoAlpe.strTipRec, 'ALPE') > 0 then
    begin
      pMensagemOk('Adiantamentos de pedidos ALPE são realizados automaticamente, portanto não será permitido prosseguir com a operação.');
      Exit;
    end;

  finally
    FreeAndNil(objPedidoAlpe);
  end;

  if fVerificaPedidoLinkPagamentoCitel then
  begin
    pMensagemOk('Adiantamentos de pedidos com Link Pagamentos Citel são realizados automaticamente, portanto não será permitido prosseguir com a operação.');
    Exit;
  end;

  if fVerificaPedidoCobrancaEletronica(tcPagarMe) then
  begin
    pMensagemOk('Adiantamentos de pedidos Pagar.me são realizados automaticamente, portanto não será permitido prosseguir com a operação.');
    Exit;
  end;

  strNumPed := qryPedidos.FieldByName('FGO_NUMDOC').AsString;
  strEmpPed := qryPedidos.FieldByName('FGO_CODEMP').AsString;

  If TAdiantamento.fHouveAlteracoesNoPedido(qryPedidos) Then
  Begin
    pMensagemOk('Este pedido sofreu alterações recentemente. '+
      'Os dados serão atualizados antes do mesmo ser selecionado!');
  End;

  dtsPedidos.DataSet := nil;
  try
    TAdiantamento.fCarregaPedidos(qryPedidos);
    pInformaCondicaoPagamento;
    pVisibilidadeColunas;
  finally
    dtsPedidos.DataSet := qryPedidos;
  end;

  If Not qryPedidos.Locate('FGO_NUMDOC;FGO_CODEMP', VarArrayOf([strNumPed, strEmpPed]), []) Then
  Begin
    pMensagemOk('Pedido não foi localizado para realizar o adiantamento!');
    Exit;
  End;

  If SameText(qryPedidos.FieldByName('FGO_TIPOPE').AsString, 'U') Then
  Begin
    pMensagemOk('Não é possível selecionar um pedido com o tipo de operação "Uso/Consumo"');
    Exit;
  End;

  If Not qryPedidos.FieldByName('FGO_TX_PIX').AsString.IsEmpty Then
  Begin
    RecebimentoDePedidoComPixGerado;

    qryPedidos.Locate('FGO_NUMDOC;FGO_CODEMP',
                      VarArrayOf([strNumPed, strEmpPed]), []);

    Exit;
  End;

  If fVerificaPixExpiradoOuNaoGeradoPedido Then
     Exit;

  If (VS_strTipExp = '4') And
     (fCfgSis('BLOPED', varBoolean)) And
     ((fPedidoPossuiItensEntregaImediata(qryPedidos.FieldByName('FGO_NUMDOC').AsString, qryPedidos.FieldByName('FGO_ESPDOC').AsString, qryPedidos.FieldByName('FGO_CODEMP').AsString)) Or
     (fPedidoPossuiItensRetira(qryPedidos.FieldByName('FGO_NUMDOC').AsString, qryPedidos.FieldByName('FGO_ESPDOC').AsString, qryPedidos.FieldByName('FGO_CODEMP').AsString))) And
     (qryPedidos.FieldByName('FGO_ESPDOC').AsString = 'PD')   And
     (Not fPedidoFoiExpedido(qryPedidos.FieldByName('FGO_NUMDOC').AsString,
                             qryPedidos.FieldByName('FGO_CODEMP').AsString,
                             qryPedidos.FieldByName('FGO_CODCLI').AsString,
                             True,
                             False,
                             (VS_strTipExp = '4') And (fCfgSis('LOCRET', varBoolean)) And ( Not fCfgSis('EXRETC', varBoolean)),
                             qryPedidos.FieldByName('FGO_CODEMP').AsString)) Then
  Begin
    fMensagem('ATENÇÃO!', 'O pedido deve ser expedido antes de realizar adiantamento!', ['&O k']);
    Exit;
  End;

  If TAdiantamento.fCarregarDadosPedido(qryPedidos, documentos, strOrigem) And
     TAdiantamento.fSelecionarPedido(documentos, objLock) Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmSelPedidoAdiantamento.btnConsultarAdiantamentosClick(
  Sender: TObject);
begin
  inherited;
  TAdiantamento.pConsultarAdiantamentos(strCodOpe);
end;

procedure TfrmSelPedidoAdiantamento.btnPadraoClick(Sender: TObject);
begin
  inherited;
  btnPadrao.Enabled := False;
  mmsLayoutDefault.Position := 0;
  cxgPedidosDados.RestoreFromStream(mmsLayoutDefault);
  btnPadrao.Enabled := True;
end;

procedure TfrmSelPedidoAdiantamento.cxgPedidosDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
    btnSair.Click;

  If (Key = VK_F5) Then
    btnAtualizar.Click;

  If (Key = VK_F6) Then
    btnConsultarAdiantamentos.Click;

  If (Key = VK_F7) Then
    btnBolAdi.Click;

  If (Key = VK_RETURN) Then
    btnConfirma.Click;
end;

procedure TfrmSelPedidoAdiantamento.pCriarColunasGrid;
var
  cxColumn: TcxGridDBColumn;
begin
  if (fCfgSis('CONEQU') = 'S') then
  begin
    cxColumn := cxgPedidosDados.CreateColumn;
    cxColumn.DataBinding.FieldName := 'EQU_NUMOSE';
    cxColumn.Caption := 'Número da OS';
    cxColumn.Visible := False;
    cxColumn.Name := 'NUMOSE';
    cxColumn.HeaderAlignmentHorz := taLeftJustify;
    cxColumn.Width := 80;

    if (fCfgSis('PROSER') = 'S') then
    begin
      cxColumn := cxgPedidosDados.CreateColumn;
      cxColumn.DataBinding.FieldName := 'EQU_PROTOC';
      cxColumn.Caption := 'Protocolo da OS';
      cxColumn.Visible := False;
      cxColumn.Name := 'OSPROT';
      cxColumn.HeaderAlignmentHorz := taLeftJustify;
      cxColumn.Width := 80;
    end;
  end;
end;

procedure TfrmSelPedidoAdiantamento.pGravarConfiguracoesAdiantamento;
begin
  TCfgColAdt.pCarregarDadosSalvos(cxgPedidosDados);
end;

procedure TfrmSelPedidoAdiantamento.pInformaCondicaoPagamento;
var
  intRecNo: integer;
begin
  if qryPedidos.IsEmpty then
    Exit;

  intRecNo := qryPedidos.RecNo;
  qryPedidos.DisableControls;

  try
    qryPedidos.First;

    while not qryPedidos.Eof do
    begin
      qryPedidos.Edit;
      qryPedidos.FieldByName('CONPAG').AsString := fFormataCondPag(qryPedidos.FieldByName('CND_CNDPAG').AsString) + ' - ' + qryPedidos.FieldByName('CND_DESCRI').AsString;
      qryPedidos.Post;
      qryPedidos.Next;
    end;
  finally
    qryPedidos.RecNo := intRecNo;
    qryPedidos.EnableControls;
  end;
end;

procedure TfrmSelPedidoAdiantamento.pVisibilidadeColunas;
  Var
    I: Integer;
    intRecNo : Integer;
    colBrinde: TcxGridDBColumn;
    colBoleto: TcxGridDBColumn;
    colEmpDes: TcxGridDBColumn;
begin
  intRecNo := qryPedidos.RecNo;
  qryPedidos.DisableControls;

  Try
    colBrinde := cxgPedidosDados.GetColumnByFieldName('FGO_TOTBRI');
    colBoleto := cxgPedidosDados.GetColumnByFieldName('FGO_BOLADT');
    colEmpDes := cxgPedidosDados.GetColumnByFieldName('EMPDES');

    colBrinde.Visible := False;
    colBoleto.Visible := False;
    colEmpDes.Visible := False;

    qryPedidos.First;

    While Not qryPedidos.Eof Do
    Begin

      If (qryPedidos.FieldByName('FGO_TOTBRI').AsFloat > 0) Then
      Begin
        colBrinde.Visible := True;
      End;

      If (qryPedidos.FieldByName('FGO_BOLADT').AsFloat > 0) Then
      Begin
        colBoleto.Visible := True;
      End;

      If (qryPedidos.FieldByName('EMPDES').AsString <>
          qryPedidos.FieldByName('FGO_CODEMP').AsString) Then
      Begin
        colEmpDes.Visible := True;
      End;

      qryPedidos.Next;
    End;

    For I := 0 To cxgPedidosDados.ColumnCount -1 Do
      If cxgPedidosDados.Columns[I].Visible Then
        If qryPedidos.FindField(cxgPedidosDados.Columns[I].DataBinding.FieldName) = nil Then
          cxgPedidosDados.Columns[I].Visible := False;
  Finally
    qryPedidos.RecNo := intRecNo;
    qryPedidos.EnableControls;
  End;
end;

function TfrmSelPedidoAdiantamento.TravarRegistroDoPix(ATravar: Boolean): Boolean;
begin
  If Not Assigned(qryPedidos) Then
    Exit(True);

  If qryPedidos.IsEmpty Then
    Exit(True);

  If qryPedidos.FieldByName('FGO_TX_PIX').AsString.IsEmpty Then
    Exit(True);

  Result := fLock_Unlock('CONSULTA_RECEBIMENTO_PIX_' + qryPedidos.FieldByName('FGO_TX_PIX').AsString,
                         ATravar,
                         False,
                         False,
                         '',
                         False);
end;

procedure TfrmSelPedidoAdiantamento.RecebimentoDePedidoComPixGerado;
  Var
    LNumeroPedido,
    LEmpresaPedido,
    LListaDePedidos,
    LChavePedido: String;

    LRegistroPix: TUniClientDataSet;
begin
  LNumeroPedido := qryPedidos.FieldByName('FGO_NUMDOC').AsString;
  LEmpresaPedido := qryPedidos.FieldByName('FGO_CODEMP').AsString;

  If MatchStr(TPixDao.RetornaStatusSePedidoPossuirPix(qryPedidos.FieldByName('FGO_EMPPIX').AsString,
                                                      qryPedidos.FieldByName('FGO_TX_PIX').AsString), STATUS_PIX_PAGO) Then
  Begin
    pMensagemOk('O pagamento do pedido já foi realizado através de uma cobrança Pix.');

    qryPedidos.Locate('FGO_NUMDOC;FGO_CODEMP',
                      VarArrayOf([LNumeroPedido,
                                  LEmpresaPedido]), []);

    Exit;
  End;

  If qryPedidos.FieldByName('FGO_EMPPIX').AsString <> VS_strCodEmp Then
  Begin
    fMensagem('ATENÇÃO', 'Esse pedido possui um Pix vinculado da empresa ' + qryPedidos.FieldByName('FGO_EMPPIX').AsString + '.' + #13 +
                         'Portanto deve ser realizado o adiantamento na empresa vinculada ao Pix.', ['&Ok']);

    qryPedidos.Locate('FGO_NUMDOC;FGO_CODEMP',
                      VarArrayOf([LNumeroPedido,
                                  LEmpresaPedido]), []);

    Exit;
  End;

  If fMensagem('ATENÇÃO', 'Esse pedido foi gerado para pagamento por Pix e ainda está em aberto. ' +
                          'O adiantamento só poderá ser realizado através do pagamento do Pix.' + #13 +
                          'Deseja realizar a leitura do QRCode para o pagamento do Pix?',
                          ['&Sim', '&Não'], 1) = 1 Then
  Begin
    If TPixDao.PixGeradoEmPedidosDesmembrados(qryPedidos.FieldByName('FGO_EMPPIX').AsString,
                                              qryPedidos.FieldByName('FGO_TX_PIX').AsString,
                                              LListaDePedidos) Then
    Begin
      If fMensagem('ATENÇÃO!', 'Esse pedido foi desmembrado e o Pix está vinculado aos pedidos: ' +
                                LListaDePedidos + #13 +
                                'Deseja realizar o adiantamento de todos os pedidos listados?', ['&Sim', '&Não']) = 2 Then
      Begin
        pMensagemOk('Para realizar o adiantamento por Pix em pedidos desmembrados, deve ser realizado o adiantamento de todos os pedidos vinculados.');

        qryPedidos.Locate('FGO_NUMDOC;FGO_CODEMP',
                          VarArrayOf([LNumeroPedido,
                                      LEmpresaPedido]), []);

        Exit;
      End;
    End;

    LChavePedido := 'FATGOR' + qryPedidos.FieldByName('FGO_NUMDOC').AsString +
                               qryPedidos.FieldByName('FGO_ESPDOC').AsString +
                               qryPedidos.FieldByName('FGO_CODEMP').AsString;

    If Not fLock_Unlock(LChavePedido, True, False) Then
    Begin
      fMensagem('ATENÇÃO', 'O pedido sendo utilizado em Outra Estação por ' +
                           fGetHostLock(LChavePedido)  + '!', ['&Ok']);
      Exit;
    End;

    If Not TravarRegistroDoPix(True) Then
    Begin
      fMensagem('ATENÇÃO', 'O Pix desse pedido está sendo utilizado em Outra Estação por ' +
                           fGetHostLock('CONSULTA_RECEBIMENTO_PIX_' + qryPedidos.FieldByName('FGO_TX_PIX').AsString)  + '!', ['&Ok']);
      Exit;
    End;

    intRecNo := qryPedidos.RecNo;

    LRegistroPix := TPixDao.RetornaDadosDoPix(qryPedidos.FieldByName('FGO_TX_PIX').AsString,
                                              qryPedidos.FieldByName('FGO_EMPPIX').AsString);

    TFuncoesPixAutcom.PagarPixViaPorQRCode(LRegistroPix,
                                           Self.Name,
                                           False,
                                           strOrigem,
                                           LChavePedido,
                                           FCodigoDoCaixa);

    FreeAndNil(LRegistroPix);

    TravarRegistroDoPix(False);

    dtsPedidos.DataSet := nil;
    try
      TAdiantamento.fCarregaPedidos(qryPedidos);
      fGetFuncoesCxGrid.fCarregarView(cxgPedidosDados, fGetChaveLayoutGrid, qryPedidos, intRecNo);
      pInformaCondicaoPagamento;
      pVisibilidadeColunas;
    finally
      dtsPedidos.DataSet := qryPedidos;
    end;

    qryPedidos.Locate('FGO_NUMDOC;FGO_CODEMP',
                      VarArrayOf([LNumeroPedido,
                                  LEmpresaPedido]), []);

    Exit;
  End;

  pMensagemOk('Para realizar o adiantamento, deve ser alterada a condição de pagamento do pedido ou realizar o pagamento do Pix.');
end;

procedure TfrmSelPedidoAdiantamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(mmsLayoutDefault);
  fGetFuncoesCxGrid.pSalvarView(cxgPedidosDados, fGetChaveLayoutGrid, qryPedidos);
end;

procedure TfrmSelPedidoAdiantamento.FormCreate(Sender: TObject);
begin
  inherited;
  qryPedidos := fCriaQuery;
  
  if (fCfgSis('YAPHAB',varBoolean)) then
  begin
    qryPedidos.FilterSQL :=
      'NOT EXISTS(SELECT 1 ' + sLineBreak +
      '             FROM YAPCOB ' + sLineBreak +
      '            WHERE YAPCOB.YCO_RESATV = ' + QuotedStr('S') + sLineBreak +
      '              AND YAPCOB.FGO_SEQGER = FATGOR.AUTOINCREM)';
  end;
  
  dtsPedidos.DataSet := qryPedidos;
  mmsLayoutDefault := TMemoryStream.Create;
  blnConfirma := False;
  strOrigem := 'RCX';
  SelectFirst;
  btnBolAdi.Visible := fCfgSis('BOLADI', varBoolean);
  btnCfgAdt.Visible := fVerificaAcessoSistema('EXBCAD');

  pCriarColunasGrid;
end;

procedure TfrmSelPedidoAdiantamento.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryPedidos);
  inherited;
end;

procedure TfrmSelPedidoAdiantamento.FormShow(Sender: TObject);
begin
  inherited;
  dtsPedidos.DataSet := nil;
  try
    TAdiantamento.fCarregaPedidos(qryPedidos);
    cxgPedidosDados.StoreToStream(mmsLayoutDefault);
    fGetFuncoesCxGrid.fCarregarView(cxgPedidosDados, fGetChaveLayoutGrid, qryPedidos, intRecNo);
    pInformaCondicaoPagamento;
    pVisibilidadeColunas;
  finally
    dtsPedidos.DataSet := qryPedidos;
  end;
  TCfgColAdt.pIniciar(cxgPedidos, cxgPedidosDados);
end;

function TfrmSelPedidoAdiantamento.fVerificaPedidoCobrancaEletronica(
  const ATipoCobrancaEletronica: TTipoCobrancaEletronica): Boolean;
begin
  Result := TFacadeCobrancaEletronica
              .fExisteCobrancaEletronica(
                 qryPedidos.FieldByName('FGO_NUMDOC').AsString,
                 qryPedidos.FieldByName('FGO_ESPDOC').AsString,
                 qryPedidos.FieldByName('FGO_CODEMP').AsString,
                 tcPagarMe);
end;

function TfrmSelPedidoAdiantamento.fVerificaPedidoLinkPagamentoCitel: Boolean;
  var
    objPedidoLinkPagamentoCitel : TLinkPagamentoCitelClass;
begin
  Result := False;

  objPedidoLinkPagamentoCitel := TLinkPagamentoCitelClass.Create;
  try

    objPedidoLinkPagamentoCitel
    .pCarregaPedidoLinkPagamentoCitel(
       qryPedidos.FieldByName('FGO_NUMDOC').AsString,
       qryPedidos.FieldByName('FGO_ESPDOC').AsString,
       qryPedidos.FieldByName('FGO_CODEMP').AsString );

    if TLinkPagamentoCitelFornecedores.fEhLinkPagamentoCitel(objPedidoLinkPagamentoCitel.strTipRec) then
      Result := True;

  finally
    FreeAndNil(objPedidoLinkPagamentoCitel);
  end;
end;

function TfrmSelPedidoAdiantamento.fVerificaPixExpiradoOuNaoGeradoPedido: Boolean;
var
  LAutoIncremChavePix: String;
begin
  Result := False;

  If (fCfgSis('USAPIX', varBoolean)) And
     (fCampoTabela('CND_RECPIX', 'CADCND', ['CND_CODIGO'], [qryPedidos.FieldByName('FGO_CODCND').AsString]) = 'S') Then
  Begin
    if fCfgSis('PIXSCP', varBoolean) then
    begin
      LAutoIncremChavePix := fCfgSis('CHAPIX');
      if TPixDao.ChavePixUtilizaTefScope(LAutoIncremChavePix) = 'S' then
      begin
        fMensagem('ATENÇÃO',
                'Este pedido foi gerado com a condição de pagamento PIX/QRCode,' + #13 +
                'mas a configuração CFG_CHAPIX está ativa (Pix via TEF Scope),' + #13 +
                'que aceita somente Pix presencial.' + #13 + #13 +
                'O adiantamento deve ser realizado pelo caixa.',
                ['&Ok']);
        Exit(True);
      end;
    end;
    fMensagem('ATENÇÃO', 'O pedido foi feito anteriormente com a condição de pagamento PIX/QRCode, ' + #13 +
                         'mas expirou devido ao prazo de 24 horas. ' + #13 +
                         'Caso queira gerar novamente o QRCode, deverá acessar o pedido e alterar para a condição de PIX!', ['&Ok']);
    Result := True;
  End;
end;

function TfrmSelPedidoAdiantamento.fGetChaveLayoutGrid: String;
begin
  Result := Self.Name + '.' + cxgPedidosDados.Name;
end;

end.
