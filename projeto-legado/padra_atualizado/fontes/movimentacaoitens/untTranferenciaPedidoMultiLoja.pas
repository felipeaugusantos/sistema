unit untTranferenciaPedidoMultiLoja;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, EditFocus, untTypesSistema, untFuncoesConsulta,
  untGerenciaTransferenciaPedidoCompraMultiLoja, cxCurrencyEdit,
  Datasnap.DBClient, UniClientDataSet, MemDS, DBAccess, Uni, untPai;

type
  TExceptionValidaCampo = class(Exception)
    class var strExceptionErro: string;

  End ;



  TfrmTranferenciaPedidoMultiLoja = class(TfrmPai)
    Panel1: TPanel;
    Panel2: TPanel;
    cxgDados: TcxGridDBTableView;
    cxlDados: TcxGridLevel;
    cxDados: TcxGrid;
    dtsDados: TDataSource;
    grpPedCom: TGroupBox;
    grpDocEnt: TGroupBox;
    lblDocumento: TLabel;
    lblEspecie: TLabel;
    lblSerie: TLabel;
    lblEmpresa: TLabel;
    lblForNot: TLabel;
    edtDocumento: TEditFocus;
    edtEspecie: TEditFocus;
    edtSerie: TEditFocus;
    edtCodEmpNF: TEditFocus;
    edtDesEmpNF: TEditFocus;
    edtForNot: TEditFocus;
    edtDesForNot: TEditFocus;
    edtNumPed: TEditFocus;
    Label1: TLabel;
    edtPdEspDoc: TEditFocus;
    Label2: TLabel;
    edtCodEmpPD: TEditFocus;
    Label4: TLabel;
    edtDesEmpPD: TEditFocus;
    edtEmpOri: TEditFocus;
    Label5: TLabel;
    edtEmpOriDes: TEditFocus;
    cxgDadosAGRUP: TcxGridDBColumn;
    cxgDadosColumn2: TcxGridDBColumn;
    cxgDadosQTDDES: TcxGridDBColumn;
    cxgDadosQTDTRA: TcxGridDBColumn;
    cxgDadosSALFIS: TcxGridDBColumn;
    cxgDadosSALDIS: TcxGridDBColumn;
    cxgDadosITE_ESTMIN: TcxGridDBColumn;
    cxgDadosITE_ESTMAX: TcxGridDBColumn;
    cxgDadosEMPDES: TcxGridDBColumn;
    cxgDadosITEFRA: TcxGridDBColumn;
    btnCarregar: TSpeedButton;
    btnConfirma: TSpeedButton;
    lblPedidosCompra: TLabel;
    procedure edtCodEmpNFExit(Sender: TObject);
    procedure edtCodEmpPDExit(Sender: TObject);
    procedure edtForNotExit(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure edtEmpOriExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cxgDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgDadosAGRUPGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxgDadosQTDTRAPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxgDadosCustomDrawGroupCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableCellViewInfo;
      var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure edtForNotKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    ObjGerenciaTransferenciaPedidoCompraMultiLoja: TGerenciaTransferenciaPedidoCompraMultiLoja;
    arrEmp: TConsultasArray;
    intDecQtd: Integer;
    intDEQTEM: Integer;
    blnFalhaAoConfimar: Boolean;

    function fRetDocumentoEntrada: TDocumento;
    function fRetMontaPedido: TpedidoCompra;
    procedure pIniciaProcesso;
    procedure pReiniciaProcesso;
    function fValidaCarregamentoPedido: Boolean;
    function fValidaCarregamentoNota: Boolean;



  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pValidaCamposNumeroPedido(Sender: TObject);
    procedure pValidaCamposEmpresaPedido(Sender: TObject);
    procedure pValidaCamposEmpresaOrigem(Sender: TObject);

    procedure pValidaCamposNumeroNota(Sender: TObject);
    procedure pValidaCamposNumeroSerie(Sender: TObject);
    procedure pValidaCamposEmpresaNota(Sender: TObject);
    procedure pValidaCamposFornecedorNota(Sender: TObject);

  public
    { Public declarations }
  end;

var
  frmTranferenciaPedidoMultiLoja: TfrmTranferenciaPedidoMultiLoja;

implementation

uses
  untFuncoesSimples, untConsultas, untPanelCxFornecedor, untPnlDadosFornecedor;

{$R *.dfm}

function TfrmTranferenciaPedidoMultiLoja.fRetMontaPedido: TpedidoCompra;
Begin
  Result.strNumped := edtNumPed.Text;
  Result.strCodEmp := edtCodEmpPD.Text;
  Result.strEmpOri := edtEmpOri.Text;
  Result.strEspPed := 'PD';
End;

function TfrmTranferenciaPedidoMultiLoja.fRetDocumentoEntrada: TDocumento;
Begin
  Result.strNumDoc := edtDocumento.Text;
  Result.strEspDoc := edtEspecie.Text;
  Result.strCodFor := edtForNot.Text;
  Result.strCodEmp := edtCodEmpNF.Text;
  Result.strSerie_ := edtSerie.Text;
End;

procedure TfrmTranferenciaPedidoMultiLoja.btnCarregarClick(Sender: TObject);
  var PedidoCompra: TpedidoCompra;
      Documento: TDocumento;
begin
  inherited;
  If Assigned(cxgDados.DataController.DataSet) Then
    If Not cxgDados.DataController.DataSet.IsEmpty Then
      Exit;

  If Not fVerificaCampos Then
    Exit;

  PedidoCompra := fRetMontaPedido;
  Documento    := fRetDocumentoEntrada;

  If Not fValidaCarregamentoPedido Then
    Exit;

  If Not fValidaCarregamentoNota Then
    Exit;

  pIniciaProcesso;
end;

function TfrmTranferenciaPedidoMultiLoja.fValidaCarregamentoNota: Boolean;
  var PedidoCompra: TpedidoCompra;
      Documento: TDocumento;
begin
  inherited;

  PedidoCompra := fRetMontaPedido;
  Documento    := fRetDocumentoEntrada;

  Result := True;

  If Not TGerenciaTransferenciaPedidoCompraMultiLoja.fValidaDocumentoEntrada(Documento) Then
  begin
    pMensagemOk('O Documento de entrada informado é inválido!');
    Exit(False);
  End;

  If TGerenciaTransferenciaPedidoCompraMultiLoja.fDocumentoDeEntradaJaUtilizado(Documento) Then
  begin
    Exit(False);
  End;
End;

function TfrmTranferenciaPedidoMultiLoja.fValidaCarregamentoPedido: Boolean;
  var PedidoCompra: TpedidoCompra;
      Documento: TDocumento;
begin
  inherited;

  PedidoCompra := fRetMontaPedido;
  Documento    := fRetDocumentoEntrada;

  Result := True;

  If Not TGerenciaTransferenciaPedidoCompraMultiLoja.fValidaPedidoCompra(PedidoCompra) Then
  begin
    pMensagemOk('O Pedido de compra informado é inválido!');
    Exit(False);
  End;



  If Not TGerenciaTransferenciaPedidoCompraMultiLoja.fValidaPedidoCompraLiberado(PedidoCompra) Then
  begin
    edtNumPed.Clear;
    edtEmpOri.Clear;
    pSetFocus(edtNumPed);
    pMensagemOk('O Pedido de compra não esta liberado!');
    Exit(False);
  End;


  If Not TGerenciaTransferenciaPedidoCompraMultiLoja.fValidaPedidoMultiloja(PedidoCompra) Then
  begin
    edtNumPed.Clear;
    edtEmpOri.Clear;
    pSetFocus(edtNumPed);
    pMensagemOk('O Pedido de compra Informado não é Multi-Loja!');
    Exit(False);
  End;


  If Not TGerenciaTransferenciaPedidoCompraMultiLoja.fValidaFornecedorDoPedidoPertenceAoGrupoDaEntrada(Documento, PedidoCompra) Then
  Begin
    edtNumPed.Clear;
    edtEmpOri.Clear;
    pSetFocus(edtNumPed);
    pMensagemOk('O Fornecedor do Pedido de compra não pertence ao Grupo de Empresas do fornecedor do Documento de Entrada!');
    Exit(False);
  End;

End;

procedure TfrmTranferenciaPedidoMultiLoja.pIniciaProcesso;
  var PedidoCompra: TpedidoCompra;
      Documento: TDocumento;
begin
  inherited;
  blnFalhaAoConfimar := False;
  PedidoCompra := fRetMontaPedido;
  Documento    := fRetDocumentoEntrada;
  If Assigned(ObjGerenciaTransferenciaPedidoCompraMultiLoja) Then
    FreeAndNil(ObjGerenciaTransferenciaPedidoCompraMultiLoja);
  ObjGerenciaTransferenciaPedidoCompraMultiLoja := TGerenciaTransferenciaPedidoCompraMultiLoja.Create(dtsDados, Documento, PedidoCompra);
  If ObjGerenciaTransferenciaPedidoCompraMultiLoja.fSemDados then
    pReiniciaProcesso
  Else
  begin
    grpPedCom.Enabled := False;
    grpDocEnt.Enabled := False;
    lblPedidosCompra.Caption := 'Pedidos de Compra: ' + ObjGerenciaTransferenciaPedidoCompraMultiLoja.fGetListaPedidos;
    If lblPedidosCompra.Caption <> 'Pedidos de Compra: ' Then
      lblPedidosCompra.Visible := True;

    cxgDados.ViewData.Expand(True);
  End;
End;

procedure TfrmTranferenciaPedidoMultiLoja.pReiniciaProcesso;
begin
  blnFalhaAoConfimar := False;
  grpPedCom.Enabled := True;
  grpDocEnt.Enabled := True;
  edtNumPed.Text := '';
  edtEmpOri.Text := '';
  edtEmpOriDes.Text := '';
  edtDocumento.Text := '';
  edtSerie.Text := '';
  edtForNot.Text := '';
  edtDesForNot.Text := '';
  lblPedidosCompra.Visible := False;
  If Assigned(dtsDados.DataSet) Then
    dtsDados.DataSet.Close;
  pSetFocus(edtDocumento);

end;

procedure TfrmTranferenciaPedidoMultiLoja.btnConfirmaClick(Sender: TObject);
begin
  If Assigned(ObjGerenciaTransferenciaPedidoCompraMultiLoja) then
    If Not ObjGerenciaTransferenciaPedidoCompraMultiLoja.fConfirma Then
      blnFalhaAoConfimar := True
    Else
      pReiniciaProcesso;
end;

procedure TfrmTranferenciaPedidoMultiLoja.cxgDadosAGRUPGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
  var PosCorte: integer;
begin
  inherited;
  PosCorte := Pos('<TAG_SEPARATOR_AUTCOM>',AText);
  If PosCorte > 0 Then
    AText := Copy(AText, 0, PosCorte -1);
end;

procedure TfrmTranferenciaPedidoMultiLoja.cxgDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  If AViewInfo.Item = cxgDadosQTDTRA Then
  begin
    If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgDadosEMPDES.Index] = VS_StrCodEmp) Then
      ACanvas.Brush.Color := clMoneyGreen
    Else
      ACanvas.Brush.Color := clYellow;
  End;

  ACanvas.Font.Color := clBlack;
end;

procedure TfrmTranferenciaPedidoMultiLoja.cxgDadosCustomDrawGroupCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
var
  lLineRect  : TRect;
  AText: string;
  ATextQtdEntrada: String;
  PosCorte: integer;
begin
  PosCorte := Pos('<TAG_SEPARATOR_AUTCOM>',AViewInfo.Text);
  If PosCorte > 0 Then
    AText := Copy(AText, 0, PosCorte -1);

  PosCorte := Pos('Qtd. Entrada: ',AViewInfo.Text);
  If PosCorte > 0 Then
  begin
    AText := Copy(AViewInfo.Text, 0, PosCorte -1);
    ATextQtdEntrada := Copy(AViewInfo.Text, PosCorte, (Length(AViewInfo.Text) - PosCorte) + 1);
  End;

  ACanvas.FillRect(AViewInfo.Bounds, AViewInfo.Params.Color);
  ACanvas.Font.Style := ACanvas.Font.Style;
  AViewInfo.Params.Font := ACanvas.Font;
  AViewInfo.Params.Font.Color := clBlack;
  ACanvas.DrawTexT(AText, AViewInfo.TextBounds, cxAlignLeft + cxAlignVCenter);
  AViewInfo.Params.Font.Color := clRed;
  AViewInfo.Params.Font.Style := AViewInfo.Params.Font.Style + [fsBold];
  lLineRect := AViewInfo.TextBounds;
  lLineRect.Left := lLineRect.Left + ACanvas.TextWidth(AText + ' - ');
  ACanvas.FillRect(lLineRect, AViewInfo.Params.Color);

  ACanvas.TextOut(lLineRect.Left, lLineRect.Top, ATextQtdEntrada);

  ADone := True;
end;

procedure TfrmTranferenciaPedidoMultiLoja.cxgDadosQTDTRAPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If DisplayValue = '' Then
    DisplayValue := 0;
  If cxgDados.DataController.DataSet.FieldByName('UNI_ITEFRA').AsString = 'N' Then
    If Frac(DisplayValue) > 0 Then
    Begin
      pMensagemOk('A unidade de medida vinculada ao item não permite fracionamento!');
      DisplayValue := Trunc(DisplayValue);
    End;
  If cxgDados.DataController.DataSet.FieldByName('PCD_EMPDES').AsString <> VS_StrCodEmp Then
  Begin
    If DisplayValue > cxgDados.DataController.DataSet.FieldByName('QTDDES').AsFloat Then
    begin
      pMensagemOk('A quantidade não pode ser maior do que a quantidade do pedido!');
      DisplayValue := cxgDados.DataController.DataSet.FieldByName('QTDTRA').AsFloat;
    End;
  End;

end;

procedure TfrmTranferenciaPedidoMultiLoja.edtCodEmpNFExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodEmpNF, edtDesEmpNF, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmTranferenciaPedidoMultiLoja.edtCodEmpPDExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodEmpPD, edtDesEmpPD, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmTranferenciaPedidoMultiLoja.edtEmpOriExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtEmpOri, edtEmpOriDes, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
  If edtEmpOriDes.Text <> '' Then
    btnCarregar.Click;

end;

procedure TfrmTranferenciaPedidoMultiLoja.edtForNotExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtForNot.Text) Then
    edtDesForNot.Clear
  Else
  Begin
    edtDesForNot.Text := fRetNomFornecedor(edtForNot.Text);

    If fEmptyStr(edtDesForNot.Text) Then
    Begin
      fMensagem('AVISO','Código do Fornecedor não encontrado.', ['&O K']);
      edtForNot.Clear;
      pSetFocus(edtForNot);
    End;

    If TGerenciaTransferenciaPedidoCompraMultiLoja.fDocumentoExiste(fRetDocumentoEntrada) then
    begin
      If Not TGerenciaTransferenciaPedidoCompraMultiLoja.fTemQueInformarOPedido(fRetDocumentoEntrada) then
      begin
        grpPedCom.Enabled := False;
        edtNumPed.Text := '';
        edtEmpOri.Text := '';
        btnCarregar.Click;
      End
      Else
        grpPedCom.Enabled := True;
    End
    Else
      fMensagem('AVISO', 'Não foi encontrado o Documento de Entrada.', ['&O K']);

  End;
End;

procedure TfrmTranferenciaPedidoMultiLoja.edtForNotKeyPress(Sender: TObject; var Key: Char);
var arrFornec: TConsultasArray;
    objPnlLegenda: TPanelCxFornecedor;
begin
  inherited;

  If fEntraCons(Key) Then
  begin
    Try
      objPnlLegenda := TPanelCxFornecedor.Create(TfrmPnlDadosFornecedor);

      If fPesqFornecedor(conForSimples, Self, edtForNot, edtDesForNot, qryTabela, Key,
                         arrFornec, True, objPnlLegenda) Then
        SelectNext(ActiveControl, True, True);
    Finally
      FreeAndNIl(objPnlLegenda);
    End;
  End;

end;

procedure TfrmTranferenciaPedidoMultiLoja.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  If blnFalhaAoConfimar Then
  Begin
    CanClose := False;
    blnFalhaAoConfimar := False;
    Exit;
  End;

  If Not grpPedCom.Enabled Then
    If fPergunta('Reiniciar Processo?') then
    begin
      CanClose := False;
      pReiniciaProcesso;
    End;
  blnFalhaAoConfimar := False;
end;

procedure TfrmTranferenciaPedidoMultiLoja.FormCreate(Sender: TObject);
begin
  inherited;
  intDecQtd := fCfgSis('DECQTD', varInteger);
  intDEQTEM :=  fCfgSis('DEQTEM', varInteger);
  edtCodEmpNF.Text := VS_StrCodEmp;
  edtCodEmpPD.Text := VS_StrCodEmp;
  fValidaCampos(edtCodEmpNF);
  pValidaCamposEmpresaPedido(edtCodEmpPD);


  TcxCurrencyEditProperties(cxgDadosSALFIS.Properties).DecimalPlaces := intDecQtd;
  TcxCurrencyEditProperties(cxgDadosSALFIS.Properties).DisplayFormat := fMskDigitos(intDecQtd);

  TcxCurrencyEditProperties(cxgDadosSALDIS.Properties).DecimalPlaces := intDecQtd;
  TcxCurrencyEditProperties(cxgDadosSALDIS.Properties).DisplayFormat := fMskDigitos(intDecQtd);

  TcxCurrencyEditProperties(cxgDadosQTDTRA.Properties).DecimalPlaces := intDEQTEM;
  TcxCurrencyEditProperties(cxgDadosQTDTRA.Properties).DisplayFormat := fMskDigitos(intDEQTEM);

end;

procedure TfrmTranferenciaPedidoMultiLoja.FormDestroy(Sender: TObject);
begin
  If Assigned(ObjGerenciaTransferenciaPedidoCompraMultiLoja) Then
    FreeAndNil(ObjGerenciaTransferenciaPedidoCompraMultiLoja);
  inherited;

end;

procedure TfrmTranferenciaPedidoMultiLoja.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If key = VK_f10 Then
    btnConfirma.Click;

end;

procedure TfrmTranferenciaPedidoMultiLoja.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtDocumento);
end;

function TfrmTranferenciaPedidoMultiLoja.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  Try
    If grpPedCom.Enabled Then
    begin
      pValidaCamposNumeroPedido(Sender);
      pValidaCamposEmpresaPedido(Sender);
      pValidaCamposEmpresaOrigem(Sender);
    End;

    pValidaCamposNumeroNota(Sender);
    pValidaCamposEmpresaNota(Sender);
    pValidaCamposNumeroSerie(Sender);
    pValidaCamposFornecedorNota(Sender);
  Except
    on e: TExceptionValidaCampo do
    begin
      pMensagemOk(e.message);
      pSetFocus(Sender);
      Result := False;
    End;
  End
end;

procedure TfrmTranferenciaPedidoMultiLoja.pValidaCamposEmpresaPedido(Sender: TObject);
begin
  TExceptionValidaCampo.strExceptionErro := '';
  If (Sender <> edtCodEmpPD) Then
    Exit;


  Try
    If edtCodEmpPD.Text = '' Then
    begin
      TExceptionValidaCampo.strExceptionErro := 'O Código da Empresa deve ser preenchido!';
      Exit;
    End;
    edtDesEmpPD.Text := fRetNomeEmpresaSelec(edtCodEmpPD.Text);

    If fEmptyStr(edtDesEmpPD.Text) Then
    Begin
      TExceptionValidaCampo.strExceptionErro := 'Código da empresa não encontrado!';
    End
  Finally
    If TExceptionValidaCampo.strExceptionErro <> '' Then
      raise TExceptionValidaCampo.Create(TExceptionValidaCampo.strExceptionErro);
  End;
end;

procedure TfrmTranferenciaPedidoMultiLoja.pValidaCamposFornecedorNota(
  Sender: TObject);
begin
  TExceptionValidaCampo.strExceptionErro := '';
  If Sender <> edtForNot then
    Exit;
  Try
    If edtForNot.Text = '' Then
    begin
      TExceptionValidaCampo.strExceptionErro := 'O Código do Fornecedor deve ser preenchido!';
      Exit;
    End;
    edtDesForNot.Text := fRetNomFornecedor(edtForNot.Text);

    If fEmptyStr(edtDesForNot.Text) Then
    Begin
      TExceptionValidaCampo.strExceptionErro := 'Código do Fornecedor não encontrado!';
    End
  Finally
    If TExceptionValidaCampo.strExceptionErro <> '' Then
      raise TExceptionValidaCampo.Create(TExceptionValidaCampo.strExceptionErro);
  End;
end;

procedure TfrmTranferenciaPedidoMultiLoja.pValidaCamposNumeroNota(
  Sender: TObject);
begin
  TExceptionValidaCampo.strExceptionErro := '';
  If (Sender <> edtDocumento) Then
    Exit;

  Try
    If fEmptyStr(edtDocumento.Text) Then
    Begin
      TExceptionValidaCampo.strExceptionErro := 'O Número do Documento de Entrada deve ser digitado!';
    End
  Finally
    If TExceptionValidaCampo.strExceptionErro <> '' Then
      raise TExceptionValidaCampo.Create(TExceptionValidaCampo.strExceptionErro);
  End;
end;

procedure TfrmTranferenciaPedidoMultiLoja.pValidaCamposNumeroPedido(
  Sender: TObject);
begin
  TExceptionValidaCampo.strExceptionErro := '';
  If (Sender <> edtNumPed) Then
    Exit;

  Try
    If fEmptyStr(edtNumPed.Text) Then
    Begin
      TExceptionValidaCampo.strExceptionErro := 'O Número do Pedido de Compra deve ser digitado!';
    End
  Finally
    If TExceptionValidaCampo.strExceptionErro <> '' Then
      raise TExceptionValidaCampo.Create(TExceptionValidaCampo.strExceptionErro);
  End;
end;

procedure TfrmTranferenciaPedidoMultiLoja.pValidaCamposNumeroSerie(
  Sender: TObject);
begin
  TExceptionValidaCampo.strExceptionErro := '';
  If (Sender <> edtSerie) Then
    Exit;

  Try
    If fEmptyStr(edtSerie.Text) Then
    Begin
      TExceptionValidaCampo.strExceptionErro := 'A Série deve ser digitado!';
    End
  Finally
    If TExceptionValidaCampo.strExceptionErro <> '' Then
      raise TExceptionValidaCampo.Create(TExceptionValidaCampo.strExceptionErro);
  End;

end;

procedure TfrmTranferenciaPedidoMultiLoja.pValidaCamposEmpresaNota(Sender: TObject);
begin
  TExceptionValidaCampo.strExceptionErro := '';

  If (Sender <> edtCodEmpNF) Then
    Exit;
  Try
    If edtCodEmpNF.Text = '' Then
    begin
      TExceptionValidaCampo.strExceptionErro := 'O Código da Empresa deve ser preenchido!';
      Exit;
    End;
    edtDesEmpNF.Text := fRetNomeEmpresaSelec(edtCodEmpNF.Text);

    If fEmptyStr(edtDesEmpNF.Text) Then
    Begin
      TExceptionValidaCampo.strExceptionErro := 'Código da empresa não encontrado!';
    End
  Finally
    If TExceptionValidaCampo.strExceptionErro <> '' Then
      raise TExceptionValidaCampo.Create(TExceptionValidaCampo.strExceptionErro);
  End;
end;


procedure TfrmTranferenciaPedidoMultiLoja.pValidaCamposEmpresaOrigem(
  Sender: TObject);
begin
  TExceptionValidaCampo.strExceptionErro := '';
  If (Sender <> edtEmpOri) Then
    Exit;

  If fEmptyStr(edtEmpOri.Text) Then
    Exit;

  Try
    edtEmpOriDes.Text := fRetNomeEmpresaSelec(edtEmpOri.Text);

    If fEmptyStr(edtEmpOriDes.Text) Then
    Begin
      TExceptionValidaCampo.strExceptionErro := 'Código da empresa não encontrado!';
    End
  Finally
    If TExceptionValidaCampo.strExceptionErro <> '' Then
      raise TExceptionValidaCampo.Create(TExceptionValidaCampo.strExceptionErro);
  End;

end;

end.
