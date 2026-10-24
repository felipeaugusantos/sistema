unit untTransfArmazensProdutoAcabado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel, EditFocus,
  Mask, DBCtrls, DBEditFocus, UniClientDataSet,
  untTransferenciaArmazens, BitBtnLockedIncrem,
  Uni, ComCtrls, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, untLiberacao,
  cxGrid, cxDataControllerConditionalFormattingRulesManagerDialog,
  untCadArmazemOperadores, cxButtonEdit,
  cxDataUtils,
  untFuncoesConsulta, cxCurrencyEdit;

type
  TfrmTransfArmazensProdutoAcabado = class(TfrmPaiConfirma)
    cxgItensView: TcxGridDBTableViewCitel;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGridCitel;
    pnlItem: TPanel;
    Label1: TLabel;
    lblOrigem: TLabel;
    dtsItens: TDataSource;
    cdsItens: TUniClientDataSet;
    cdsItensCODITE: TStringField;
    cdsItensARMORI: TStringField;
    cdsItensARMDES: TStringField;
    cdsItensQTDITE: TFloatField;
    cdsItensSALORI: TFloatField;
    cdsItensSALDES: TFloatField;
    cdsItensMAXORI: TFloatField;
    cdsItensMAXDES: TFloatField;
    cdsItensREPORI: TFloatField;
    cdsItensREPDES: TFloatField;
    cxgItensViewCODITE: TcxGridDBColumn;
    cxgItensViewDESITE: TcxGridDBColumn;
    cxgItensViewARMORI: TcxGridDBColumn;
    cxgItensViewAMZDES: TcxGridDBColumn;
    cxgItensViewTAQtdItem: TcxGridDBColumn;
    cdsItensDESITE: TStringField;
    cdsItensSALDOS: TFloatField;
    btnConfirmar: TBitBtnLocked;
    prgProgresso: TProgressBar;
    cdsItensPRECUS: TFloatField;
    cdsItensTOTCUS: TAggregateField;
    dtsGrid: TDataSource;
    cdsItensLOCORI: TStringField;
    cdsItensLOCDES: TStringField;
    cdsItensDESLFO: TStringField;
    cdsItensDESLFD: TStringField;
    cdsItensCODMAR: TStringField;
    cdsItensDESMAR: TStringField;
    cdsItensSIGUNI: TStringField;
    cdsItensSALORIRES: TFloatField;
    cdsItensSALORIDIS: TFloatField;
    cdsItensSALDESRES: TFloatField;
    cdsItensSALDESDIS: TFloatField;
    cdsItensDESAMZLOCORI: TStringField;
    cdsItensDESAMZLOCDES: TStringField;
    cxgItensViewDESAMZORI: TcxGridDBColumn;
    cdsItensDESAMZORI: TStringField;
    cdsItensDESAMZDES: TStringField;
    cdsItensDESLOCORI: TStringField;
    cdsItensDESLOCDES: TStringField;
    cxgItensViewTAQtdMaxDes: TcxGridDBColumn;
    pnlCabec: TPanel;
    cxGridCitel1: TcxGridCitel;
    cxgArmazensView: TcxGridDBTableViewCitel;
    cxGridLevel1: TcxGridLevel;
    edtDesAmz: TEditFocus;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    cdsItensCODBAR: TStringField;
    cxgItensViewCODBAR: TcxGridDBColumn;
    cxgItensViewSALORI: TcxGridDBColumn;
    cxgItensViewSALORIDIS: TcxGridDBColumn;
    Splitter1: TSplitter;
    dtsGridArmazens: TDataSource;
    cxgArmazensViewDESARM: TcxGridDBColumn;
    cxgArmazensViewSALDOS: TcxGridDBColumn;
    edtCodAmz: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure cxgItensEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnlItemEnter(Sender: TObject);
    procedure pnlItemExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure edtCodAmzKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure cxgItensViewDESAMZDESPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edtCodAmzExit(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure cxgItensViewEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cdsItensAfterScroll(DataSet: TDataSet);
    procedure cxgItensViewTAQtdItemPropertiesEditValueChanged(Sender: TObject);
    procedure cdsItensARMDESValidate(Sender: TField);
  private
    { Private declarations }
    objTransf: TTransferenciaArmazens;
    Function fedtCodIteKeyPressGer(Sender: TObject; var Key: Char): Boolean;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples, untConsultas,untPnlDadosItem, untPanelCxItem, untTypesSistema,
  untCadLoteItens, untPesqAux, untCadLote, untFuncFat, untObservacaoGenerica,
  untIFatEntregaFutura, untTFatEntregaFutura, untTransfArmazensImportacao, untConstantes,
  untIteBar;

{$R *.dfm}

procedure TfrmTransfArmazensProdutoAcabado.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  cdsItens.EmptyDataSet;
  objTransf.strArmOri := edtCodAmz.Text;
  objTransf.strIteAca := edtCodIte.Text;
  objTransf.pCarregarArmazemProdutoAcabado;
  pSetFocus(edtCodIte);
end;

procedure TfrmTransfArmazensProdutoAcabado.btnConfirmaClick(Sender: TObject);
var
  blnGerarReserva,
  blnUsaLote: Boolean;
begin
  blnGerarReserva := True;
  blnUsaLote := False;

  If cdsItens.IsEmpty Then
  Begin
    pMensagemOk('Inclua os itens para transferência!');
    Exit;
  End;


  //  inherited;
  If Not fPergunta('Confirma a transferência entre armazéns?') Then
    Exit;

  Try
    pnlBotoes.Enabled := False;
    pnlCabec.Enabled  := False;
    pnlItem.Enabled   := False;
    objTransf.pSalvaItem;

    (* Se Tiver liberado vai movimentar Saldo e Kardex
     Caso contrario não movimenta Saldo e Kardex *)
    objTransf.blnFilKar := True;
    If fEmptyStr(objTransf.strObservacao) Then
      objTransf.strObservacao :=  fstrInputObservacao('Digite uma observação para esta "TA"');

    Try
      objTransf
        .fValidarArmazemDestino
        .fGeraTransferenciaProdutoAcabado(blnUsaLote, True, blnGerarReserva);

      pGeraLogLiberacao(objTransf.strNumDoc, objTransf.strEspDoc, VS_strCodEmp);

      If fPergunta('Transferência ' + objTransf.strEspDoc + '-' + objTransf.strNumDoc + ' gerada com sucesso! Imprime?') Then
        objTransf.pImprimeTranferencia;

      FreeAndNil(objTransf);
      cdsItens.EmptyDataSet;
      objTransf := TTransferenciaArmazens.Create(Self, cdsItens, dtsItens, prgProgresso);
    Except
      On E: Exception Do
      Begin
        pMensagemOk(e.message);
      End;
    End;
  Finally
    pnlBotoes.Enabled := True;
    pnlCabec.Enabled  := True;
    pnlItem.Enabled   := True;
    SelectFirst;
  End;

end;

procedure TfrmTransfArmazensProdutoAcabado.cdsItensAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  If Assigned(objTransf) Then
  Begin
    objTransf.pCarregarArmazens(cdsItensCODITE.AsString, edtCodAmz.Text);
    dtsGridArmazens.DataSet := objTransf.qryArmazens;
  End;
end;

procedure TfrmTransfArmazensProdutoAcabado.cdsItensARMDESValidate(
  Sender: TField);
begin
  inherited;
  If cdsItens.State = dsEdit Then
  Begin
    If Sender.AsString = edtCodAmz.Text Then
    Begin
      pMensagemOk(edtCodAmz.Text + ' origem deve ser diferente do ' + Sender.AsString + ' destino!');
      Abort;
    End
    Else
    If Not fEmptyStr(Sender.AsString) Then
      objTransf.fCarregaArmazem(false, Sender.AsString);
  End;
end;

procedure TfrmTransfArmazensProdutoAcabado.cxgItensEnter(Sender: TObject);
begin
  inherited;
  If dtsGrid.DataSet.RecordCount <= 0 Then
    Exit;

  With objTransf Do
  Begin
    pCancelaEdicaoItem(opcEditar);
    objTransf.blnSomarQuantidade := False;
  End;

end;

procedure TfrmTransfArmazensProdutoAcabado.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if cdsItens.IsEmpty then
    Exit;
  inherited;

  If (Not Assigned(cdsItens)) Or (Not cdsItens.Active) Then
    Exit;

  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewTAQtdItem.Index] >
      Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewTAQtdMaxDes.Index]) And
     (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewTAQtdMaxDes.Index] > 0) Then
    ACanvas.Font.Color := clRed;
end;

procedure TfrmTransfArmazensProdutoAcabado.cxgItensViewDESAMZDESPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
Var
  arrSel : TConsultasArray;
  Key: Char;
  strCodArm: String;
  strCodIte: String;
begin
  inherited;
  Key := '/';
  strCodIte := VarToStrDef(cxgItensView.DataController.GetEditValue(cxgItensViewCODITE.Index, evsValue),'');

  If fPesqLoteFat(Self, nil, fCfgSis('DECUNI'), strCodIte,
                False, False, Nil, Key, arrSel, VS_strCodEmp) Then
  Begin
    strCodArm := arrSel[0].strCodigo;
    Begin
      cdsItens.Edit;
      cdsItensARMDES.AsString := VarToStrDef(strCodArm,'');
      objTransf.fCarregaArmazem(false, strCodArm);
      cdsItens.Post;
    End;
  End;
end;

procedure TfrmTransfArmazensProdutoAcabado.cxgItensViewEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
Var
  strCodIte: String;
  strCodArm: String;
  arrSel : TConsultasArray;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    strCodIte := cdsItensCODITE.AsString;
    If fPesqLoteFat(Self, nil, fCfgSis('DECUNI'), strCodIte,
                  False, False, Nil, Key, arrSel, VS_strCodEmp) Then
    Begin
      strCodArm := arrSel[0].strCodigo;
      Begin
        cdsitens.Edit;
        cdsItensARMDES.AsString := strCodArm;
        objTransf.fCarregaArmazem(false, strCodArm);
        AEdit.PostEditValue;
      End;
    End;
    Key := #0;
  End;
end;

procedure TfrmTransfArmazensProdutoAcabado.cxgItensViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  if cdsItens.IsEmpty then
    Exit;
  inherited;

  If (Not Assigned(cdsItens)) Or (Not cdsItens.Active) Then
    Exit;

  If (Sender.DataController.Values[AFocusedRecord.RecordIndex, cxgItensViewTAQtdItem.Index] >
      Sender.DataController.Values[AFocusedRecord.RecordIndex, cxgItensViewTAQtdMaxDes.Index]) And
     (Sender.DataController.Values[AFocusedRecord.RecordIndex, cxgItensViewTAQtdMaxDes.Index] > 0) Then
  Begin
    pnlInfo.Font.Color := clRed;
    pnlInfo.Caption := 'Quantidade à transferir maior que a capacidade máxima do armazém de destino';
  End
  Else
  Begin
    pnlInfo.Font.Color := clBlack;
    pnlInfo.Caption := '';
  End;
end;

procedure TfrmTransfArmazensProdutoAcabado.cxgItensViewTAQtdItemPropertiesEditValueChanged(
  Sender: TObject);
Var
  varQtdIte: Variant;
begin
  inherited;
  varQtdIte := VarToStrDef(TcxCustomEdit(Sender).EditingValue,'0');
  If cxgItensView.Controller.EditingItem.Index = cxgItensViewTAQtdItem.Index Then
    If cxgItensViewSALORIDIS.EditValue <  varQtdIte Then
    Begin
      pMensagemOk('Não há saldo suficiente para essa transferência!');
      TcxCustomEdit(Sender).EditValue := 0;
    End;

end;

procedure TfrmTransfArmazensProdutoAcabado.edtCodAmzExit(Sender: TObject);
Var
  arrSelecao: TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodAmz, edtDesAmz, arrSelecao, Nil, fRetNomeArmazem, 'do armazém');
end;

procedure TfrmTransfArmazensProdutoAcabado.edtCodAmzKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel : TConsultasArray;
begin
  inherited;
   If fPesqArmazem(Self, edtCodAmz, edtDesAmz, nil, Key, arrSel) And
     fValidaCampos(edtCodAmz, True) Then
   Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmTransfArmazensProdutoAcabado.edtCodIteExit(Sender: TObject);
Var
  arrSelecao: TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodIte, edtDesIte, arrSelecao, Nil, fRetNomProduto, 'do produto');
end;

procedure TfrmTransfArmazensProdutoAcabado.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  fedtCodIteKeyPressGer(Sender, Key);
end;

procedure TfrmTransfArmazensProdutoAcabado.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If ( Not cdsItens.IsEmpty) And
     ( Not fPergunta('Deseja cancelar a tarefa?')) Then
  Begin
    Action := caNone;
    Exit;
  End;

end;

procedure TfrmTransfArmazensProdutoAcabado.FormCreate(Sender: TObject);
begin
  inherited;

  {Se resolução disponível for inferior ou igual à (1366 x 768), ajusta a tela!}
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.Position := poScreenCenter;

  cdsItens.CreateDataSet;
  objTransf := TTransferenciaArmazens.Create(Self, cdsItens, dtsItens, prgProgresso);
end;

procedure TfrmTransfArmazensProdutoAcabado.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10:
      btnConfirma.Click;
  End;
end;

procedure TfrmTransfArmazensProdutoAcabado.FormShow(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;
end;

function TfrmTransfArmazensProdutoAcabado.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = edtCodIte Then
    Begin
      If fEmptyStr(edtDesIte.Text) Then
      Begin
        pMensagemOk('Produto não encontrado!');
        Result := False;
      End;
    End

    Else If Sender = edtCodAmz Then
    Begin
      If fCfgSis('CTRAMZ', varBoolean) Then
      Begin
        If Not TfrmCadArmazemOperadores.fOperadorComAcesso(edtCodAmz.Text) Then
        Begin
          pMensagemOk('Esse operador não possui acesso ao armazém ' + QuotedStr(edtCodAmz.Text) + ' nessa empresa, favor verificar o cadastro de controle de armazém por operadores');
          Result := False;
        End;
      End
      Else if fEmptyStr(edtCodAmz.Text) then
      Begin
        pMensagemOk('O armazém não foi informado!');
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmTransfArmazensProdutoAcabado.pnlItemEnter(Sender: TObject);
begin
  inherited;
  objTransf
    .pEditaItem;
end;

procedure TfrmTransfArmazensProdutoAcabado.pnlItemExit(Sender: TObject);
begin
  inherited;
  objTransf
    .pCancelaEdicaoItem;
end;

Function TfrmTransfArmazensProdutoAcabado.fedtCodIteKeyPressGer(Sender: TObject;
  var Key: Char): Boolean;
  Var
    arrSel: TConsultasArray;
    objfrmPnl: TPanelCxItem;
    qryConCit: TUniQuery;
begin
  If (fEntraCons(Key)) Then
  Begin
    Try
      qryConCit := fCriaQuery(Self);
      objfrmPnl := TPanelCxItem.New();

      Try
        objFrmPnl.strNomForm := Self.Name;
        objFrmPnl.recParametros.strCodCli  := '';
        objFrmPnl.strCodVen  := '';
        objFrmPnl.strCodDig  := '';
        objFrmPnl.intPraMedio:= 0;
        objFrmPnl.recParametros.strTabPre  := '1';

        If fPesqItem(conIteCompleta,
                     Self,
                     edtCodIte,
                     edtDesIte,
                     qryConCit,
                     Key,
                     arrSel,
                     True,
                     objfrmPnl,
                     '',
                     objFrmPnl.recParametros.strTabPre,
                     '',
                     0,
                     false,
                     false,
                     0,
                   cdrCodIte,//opcCodIte: TCodigoRetornoItem = cdrCodIte;
                   '',//strAplica: String = '';
                   False,//blnPedCom: Boolean = False;   {* Se é pedido de compra                        *}
                   '',//strCodCli: String = '';
                   '',//strCodVen: String = '';
                   TRue,//blnMostrarPrecos: Boolean = True;
                   False,//blnTablet: Boolean = False;
                   True,//blnConsiderarExiLis: Boolean = True;
                   '',//strCodCmp: String = ''; // Codigo do Comprador
                   False,//blnDepMatPriIndustrial: Boolean = False;
                   False,//blnDepProAcaIndustrial: Boolean = False;
                   False,//blnDepProEmbIndustrial: Boolean = False;
                   False,//blnDepProGraIndustrial: Boolean = False;
                   False,//blnVeioF11: Boolean = False;
                   False,//blnSomenteAgrotoxico: Boolean = False;
                   False,//blnMostrarItensDeServico: Boolean = False;
                   False,//blnExibeColunaSaldoCD: Boolean = False;
                   '',//strEmp_CD: String = '';
                   -1, //fltDescFidelidade: Double = -1;
                   True,//blnFaturamento: Boolean = False;
                   '',//strCodFab: String = '';
                   True,//blnMostraSaldo: Boolean = True;
                   '',//strFiltros: string = '';
                   '',//strCodEmp: String = '';
                   '',///strEmpSaldoMatrizCD: String = '';
                   '',///strDescri: String = '';
                   '',//strCodBar: String = '';
                   '',//strProdutoLocalizar: String = '';
                   True, // blnConfirma: Boolean = True;
                   False, //blnConEquEnt: Boolean = False;
                   False, //blnSomenteEstrutura: Boolean = False;
                   Nil, // objPnlBanner: TPanelCx = Nil;
                   Nil, // objPnlPreFiltro: TPanelCx = Nil;
                   '', // strCodCnd: String = '';
                   '', // strNumOrc: String = '';
                   '', // strEspOrc: String = '';
                   '', // strCodAbf: String = '';
                   '', // strComponenteA: String = '';
                   '',// strComponenteB: String = '';
                   '', //strOpcDoc : String = '';
                   'S',   //strExiAca: String = '';
                   False, //blnSomenteProdutosLocEqu: Boolean = False;
                   False, //blnSomenteAcessorioLocEqu: Boolean = False;
                   False, //blnImpLis: Boolean = True;
                   False, //blnRecVndBsTrc: Boolean = False;
                   False, //blnUsaSer: Boolean = False;
                   '',//strItensEntradaMercadoriaDev: String = '';
                   edtCodAmz.Text
                     ) Then
        Begin
          If fValidaCampos(edtCodIte) Then
            SelectNext(ActiveControl, True, True);
        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmTransfArmazensProdutoAcabado.fedtCodIteKeyPressGer]');
        End;
      End;


    Finally
      FreeAndNil(objfrmPnl);
      FreeAndNil(qryConCit);
    End;

  End;

  Result := True;

end;


end.


