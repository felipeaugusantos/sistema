unit untFatRetirarVinculoReq_Transf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, frxClass,
  frxExportCSVTestabilidade, untFuncFat, untFuncFatTypes,
  untFatAbastecimentoItens,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient,
  UniClientDataSet, cxDropDownEdit, cxImageComboBox, System.ImageList,
  Vcl.ImgList, cxImageList, cxGridBandedTableView, cxGridDBBandedTableView,
  cxGridCitel, MemDS, DBAccess, Uni;

type
  TfrmFatRetirarVinculoReq_Transf = class(TfrmPaiEdit)
    cxgItensLevel: TcxGridLevel;
    cxgItens: TcxGrid;
    dsItens: TDataSource;
    cxStyle: TcxStyleRepository;
    cxsHeader: TcxStyle;
    cxgItensView: TcxGridDBBandedTableViewCitel;
    qryItens: TUniQuery;
    qryItensAutoincremento: TStringField;
    qryItensCódigo: TStringField;
    qryItensDescrição: TStringField;
    qryItensUnidade: TStringField;
    qryItensQuantidade: TFloatField;
    qryItensFaturTotal: TStringField;
    qryItensEmpFat: TStringField;
    qryItensSaldoEstoque: TFloatField;
    qryItensRequisição: TStringField;
    qryItensQtdRequisição: TFloatField;
    qryItensPeddeCompra: TStringField;
    qryItensDataEntrega: TDateField;
    qryItensNotadeEntrada: TStringField;
    qryItensQtdTransf: TFloatField;
    qryItensPeddeTransf: TStringField;
    qryItensNotadeTransf: TStringField;
    cxgItensViewAutoincremento: TcxGridDBBandedColumn;
    cxgItensViewCdigo: TcxGridDBBandedColumn;
    cxgItensViewDescrio: TcxGridDBBandedColumn;
    cxgItensViewUnidade: TcxGridDBBandedColumn;
    cxgItensViewQuantidade: TcxGridDBBandedColumn;
    cxgItensViewFaturTotal: TcxGridDBBandedColumn;
    cxgItensViewEmpFat: TcxGridDBBandedColumn;
    cxgItensViewSaldoEstoque: TcxGridDBBandedColumn;
    cxgItensViewRequisio: TcxGridDBBandedColumn;
    cxgItensViewQtdRequisio: TcxGridDBBandedColumn;
    cxgItensViewPeddeCompra: TcxGridDBBandedColumn;
    cxgItensViewDataEntrega: TcxGridDBBandedColumn;
    cxgItensViewNotadeEntrada: TcxGridDBBandedColumn;
    cxgItensViewQtdTransf: TcxGridDBBandedColumn;
    cxgItensViewPeddeTransf: TcxGridDBBandedColumn;
    cxgItensViewNotadeTransf: TcxGridDBBandedColumn;
    Label1: TLabel;
    qryItensSeqRequisição: TStringField;
    qryItensSeqTransf: TStringField;
    qryItensDocumento: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure cxgItensViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure pRemoverVinculoRequisicaoCompra;
    procedure pRemoverVinculoTransferencia;
    procedure pCarregarItens;
  public
    { Public declarations }
    strNumDoc: String;
    strEspDoc: String;
    strEmpDoc: String;
  end;


implementation

uses untFuncoesSimples, untTypesSistema, untSolicitacaoTE, untGravando, untLiberacao,
  untConstantes, untTSituacaoPedidoVenda, untTypesCRM, untAtualizaOcorrenciasCRM;

{$R *.dfm}

procedure TfrmFatRetirarVinculoReq_Transf.cxgItensViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  Var 
    objLiberacao  : TLiberacao;  
begin
  inherited;
  If Key = VK_DELETE Then
  Begin
    If untFuncoesSimples.fRetornaSaldoDisponivel(qryItens.FieldByName('Código')
      .AsString, False, True, '', True, qryItens.FieldByName('Emp. Fat.')
      .AsString, strNumDoc) < qryItens.FieldByName('Quantidade').AsFloat Then
    Begin
      objLiberacao := TLiberacao.Create;
      try
        objLiberacao.objMsgLibera.pAddTexto('Produto não possui saldo disponível suficiente para remover o vínculo com compra e/ou pedido de transferência!');
        objLiberacao.objMsgLibera.pAddTexto('Pedido: '+qryItens.FieldByName('Documento').AsString);
        objLiberacao.objMsgLibera.pAddTexto('Item: '+qryItens.FieldByName('Descrição').AsString);
        objLiberacao.objMsgLibera.pAddSeparador;

        objLiberacao.strDirAce := 'RMVPRE';
        objLiberacao.strMsgSen := 'Retirar Vínculo com Requisição de Compra e/ou Solicitação de Transferência';
        objLiberacao.blnMosMen := True;
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.strCodDig := strLoginUsuarioLogado;
        objLiberacao.pInformaNumDocEspDocCodEmp(
                            Copy(qryItens.FieldByName('Documento').AsString,01,12),
                            Copy(qryItens.FieldByName('Documento').AsString,14,02),
                            Copy(qryItens.FieldByName('Documento').AsString,17,03));

        If Not objLiberacao.fLibera Then
          Exit
      finally
        FreeAndNil(objLiberacao);
      end;
    End;

    If (Not qryItens.FieldByName('Ped. de Compra').AsString.IsEmpty) Or
      (Not qryItens.FieldByName('Ped. de Transf.').AsString.IsEmpty) Then
    Begin
      pMensagemOk('Existem requisições de compra vinculadas à pedido de ' +
        'compra e/ou pedido de transferência. Estas operações não são ' +
        'desfeitas automaticamente. Caso seja necessário, devem ser feitas ' +
        'manualmente.');
    End;

    pRemoverVinculoRequisicaoCompra;
    pRemoverVinculoTransferencia;
    pCarregarItens;
  End;
end;

procedure TfrmFatRetirarVinculoReq_Transf.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(cxgItens);
end;

procedure TfrmFatRetirarVinculoReq_Transf.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  TUpdateStatus.New(TParamStatus.New().NumDoc(strNumDoc).EspDoc(strEspDoc)
    .CodEmp(strEmpDoc)).pExecute();
end;

procedure TfrmFatRetirarVinculoReq_Transf.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaConexao(qryItens);
end;

procedure TfrmFatRetirarVinculoReq_Transf.FormResize(Sender: TObject);
begin
  inherited;
  cxgItensView.ApplyBestFit();
end;

procedure TfrmFatRetirarVinculoReq_Transf.FormShow(Sender: TObject);
begin
  inherited;
  pCarregarItens;
end;

procedure TfrmFatRetirarVinculoReq_Transf.pCarregarItens;
Var
  intRecNo: Integer;
begin
  intRecNo := 1;

  If qryItens.Active Then
    intRecNo := qryItens.RecNo;

  qryItens.Close;
  qryItens.ParamByName('NUMDOC').AsString := strNumDoc;
  qryItens.ParamByName('ESPDOC').AsString := strEspDoc;
  qryItens.ParamByName('EMPDOC').AsString := strEmpDoc;
  qryItens.Open;

  TFloatField(qryItens.FieldByName('Quantidade')).DisplayFormat :=
    fMskDigitos(fCfgSis('DECQTD', varInteger));

  TFloatField(qryItens.FieldByName('Qtd. Transf.')).DisplayFormat :=
    fMskDigitos(fCfgSis('DECQTD', varInteger));

  TFloatField(qryItens.FieldByName('Qtd. Requisição')).DisplayFormat :=
    fMskDigitos(fCfgSis('DECQTD', varInteger));

  cxgItensView.ApplyBestFit();

  If qryItens.IsEmpty Then
  Begin
    pMensagemOk('Não há produtos que possuem vínculo com Requisição de ' +
      'Compra e/ou Solicitação de Transferência!');
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
    Exit;
  End;

  If qryItens.RecordCount > intRecNo Then
    qryItens.RecNo := intRecNo
  Else
    qryItens.Last;
end;

procedure TfrmFatRetirarVinculoReq_Transf.pRemoverVinculoRequisicaoCompra;
Var
  strSeqRcd: String;
  blnRemoverSomentePreparacaoRQ: Boolean;
  LInfAdc: String;
begin
  If qryItens.FieldByName('Seq. Requisição').AsString.IsEmpty Then
    Exit;

  If Not fPergunta
    ('Confirma remover o vínculo com requisição de compra do produto ' +
    qryItens.FieldByName('Código').AsString + ' ?') Then
    Exit;

  strSeqRcd := fCampoTabela('PRQ_SEQRCD', 'PREPRQ', ['AUTOINCREM'],
    [qryItens.FieldByName('Seq. Requisição').AsString]);

  Try
    fStartTransaction;

    blnRemoverSomentePreparacaoRQ :=
      fCampoTabela('COALESCE(RCD_SEQCOT, RCD_SEQPCD)', 'MOVRCD', ['AUTOINCREM'],
      [strSeqRcd]) <> '';

    untFuncFat.pRemoveRequisicoes(qryItens.FieldByName('Seq. Requisição')
      .AsString.QuotedString, blnRemoverSomentePreparacaoRQ, Self.Name);

    If blnRemoverSomentePreparacaoRQ Then
      If Not fExecutaSQL
        ('UPDATE MOVRCD SET RCD_DOCPDV = NULL, RCD_EMPPDV = NULL, ' +
        'RCD_ESPPDV = NULL ' + 'WHERE AUTOINCREM = ' +
        strSeqRcd.QuotedString) Then
        Raise Exception.Create
          ('Não foi possível remover o vínculo com a requisição de compra!');

    ReprocessarItem(qryItens.FieldByName('Código').AsString,'');

    If VS_strHabilitarCRM Then
    Begin
      LInfAdc := Concat(qryItens.FieldByName('Código').AsString, '-',
                        qryItens.FieldByName('Descrição').AsString);

      TUpdateOccurrenceCRM.New()
        .InfAdc(LInfAdc)
        .NumDoc(strNumDoc)
        .EspDoc(strEspDoc)
        .CodEmp(strEmpDoc)
        .AcaFat(afcItemDesvinculadoReqCompra)
        .strNomFrm(Self.Name)
        .pRun();
    End;

    fCommit();
  Except
    On E: ExceptionAutCom Do
    Begin
      fRollBack();
      pMensagemOk(E.Message);
    End;

    On E: Exception Do
    Begin
      fRollBack();
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmFatRetirarVinculoReq_Transf.pRemoverVinculoTransferencia;
var
  LInfAdc: String;
begin
  If qryItens.FieldByName('Seq. Transf.').AsString.IsEmpty Then
    Exit;

  If Not fPergunta
    ('Confirma remover o vínculo com solicitação de transferência do produto ' +
    qryItens.FieldByName('Código').AsString + ' ?') Then
    Exit;

  Try
    fStartTransaction;

    untFuncFat.pRemoveVinculoTransferencias(qryItens.FieldByName('Seq. Transf.')
      .AsString.QuotedString, Self.Name);

    ReprocessarItem(qryItens.FieldByName('Código').AsString, '');

    If VS_strHabilitarCRM Then
    Begin
      LInfAdc := Concat(qryItens.FieldByName('Código').AsString, '-',
                        qryItens.FieldByName('Descrição').AsString);

      TUpdateOccurrenceCRM.New()
        .InfAdc(LInfAdc)
        .NumDoc(strNumDoc)
        .EspDoc(strEspDoc)
        .CodEmp(strEmpDoc)
        .AcaFat(afcItemDesvinculadoPDTransf)
        .strNomFrm(Self.Name)
        .pRun();
    End;

    fCommit();
  Except
    On E: ExceptionAutCom Do
    Begin
      fRollBack();
      pMensagemOk(E.Message);
    End;

    On E: Exception Do
    Begin
      fRollBack();
      pMensagensErro(E.Message, '');
    End;
  End;
end;

end.
