unit untEntNFEDigManualEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Mask,
  DBCtrls, DBEditFocus, EditFocus, BitBtnLockedIncrem, untEntNFEDigManual,
  MaskEditFocus, UniClientDataSet,
   Uni, Math, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, untTLock;

type
  TfrmEntNFEDigManualEdit = class(TfrmPaiConfirma)
    pnlItem: TPanel;
    cxgItensTableView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    lblCodIte: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    cxgItensCODITE: TcxGridDBColumn;
    cxgItensDESITE: TcxGridDBColumn;
    cxgItensQTDITE: TcxGridDBColumn;
    cxgItensUNITAR: TcxGridDBColumn;
    cxgItensTOTITE: TcxGridDBColumn;
    dbeCodIte: TDBEditFocus;
    dbeDesIte: TDBEditFocus;
    dbeQtdIte: TDBEditFocus;
    dbeUnitar: TDBEditFocus;
    dbeTotIte: TDBEditFocus;
    dbeBasIpi: TDBEditFocus;
    dbeAlqIpi: TDBEditFocus;
    dbeValIpi: TDBEditFocus;
    dbeBasIcm: TDBEditFocus;
    dbeAlqIcm: TDBEditFocus;
    dbeValIcm: TDBEditFocus;
    dbeBasSub: TDBEditFocus;
    dbeValSub: TDBEditFocus;
    dbeBasPis: TDBEditFocus;
    dbeAlqPis: TDBEditFocus;
    dbeValPis: TDBEditFocus;
    dbeBasCof: TDBEditFocus;
    dbeAlqCof: TDBEditFocus;
    dbeValCof: TDBEditFocus;
    btnAdicionar: TBitBtnLocked;
    dtsGerEle: TDataSource;
    dtsDetEleGrid: TDataSource;
    dtsDetEleEdit: TDataSource;
    Panel2: TPanel;
    pnlNota: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label12: TLabel;
    dbeDtaEmi: TDBEditFocus;
    dbeNumDoc: TDBEditFocus;
    dbeNumSer: TDBEditFocus;
    dbeDesCon: TDBEditFocus;
    dbeDtaAlt: TDBEditFocus;
    dbeCodFor: TDBEditFocus;
    dbeNomFan: TDBEditFocus;
    Panel1: TPanel;
    shpCodIte: TShape;
    Label28: TLabel;
    Label33: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label34: TLabel;
    Label31: TLabel;
    Label35: TLabel;
    Label32: TLabel;
    Label36: TLabel;
    Shape1: TShape;
    Shape3: TShape;
    Shape5: TShape;
    Shape4: TShape;
    Shape2: TShape;
    dbeBasIcmTot: TDBEdit;
    dbeValFre: TDBEdit;
    dbeDesAce: TDBEdit;
    dbeBasSubTot: TDBEdit;
    dbeTotSub: TDBEdit;
    dbeTotIpi: TDBEdit;
    dbeTotNot: TDBEdit;
    dbeTotPro: TDBEdit;
    dbeTotIcm: TDBEdit;
    Label6: TLabel;
    dbeDscIte: TDBEditFocus;
    Label8: TLabel;
    dbeValLiq: TDBEditFocus;
    btnExcluir: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    dbeCodBar: TDBEditFocus;
    cxgItensCODBAR: TcxGridDBColumn;
    Label9: TLabel;
    dbeFreIte: TDBEditFocus;
    Label37: TLabel;
    dbeAceIte: TDBEditFocus;
    dbeCST: TDBEditFocus;
    lblCST: TLabel;
    btnImportaPedidos: TBitBtnLocked;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure pnlItemExit(Sender: TObject);
    procedure cxgItensEnter(Sender: TObject);
    procedure pnlItemEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeCodForKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeBasIcmTotKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbeCodBarKeyPress(Sender: TObject; var Key: Char);
    procedure btnImportaPedidosClick(Sender: TObject);
  private
    { Private declarations }
    strKeyLck: String;
    objLock: TLock;

    Function fRetKeyLck: String;

    procedure pTrataColunas;

    procedure pSetFocusItem;

    procedure pLigaClients;
    Procedure pCalculaTotalItem(blnBuscaPorChave: Boolean);

    function fTotalBruto: Double;
    Function fedtCodIteKeyPressGer(Sender: TObject; var Key: Char): Boolean;

    function fValidaBase(dbeBase, dbeAliquota, dbeValor: TDBEditFocus;
                         strNome: String; blnBuscaPorChave: Boolean; fltDefAli: Double = 0): Boolean;

    function fValidaAliquota(dbeBase, dbeAliquota, dbeValor:TDBEditFocus; strNome: String;
                             blnBuscaPorChave: Boolean): Boolean;

    function fValidaValorNota(dbeBasVal: TDBEdit; strTitulo: String;
                              blnBuscaPorChave: Boolean;
                              dbeValor: TDBEdit = Nil; blnPerZer: Boolean = True): Boolean;

  public
    { Public declarations }
    objNFEDig: TNFEDigManual;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmEntNFEDigManualEdit: TfrmEntNFEDigManualEdit;

implementation

uses untConsultas, untPnlDadosItem, untPanelCxItem, untFuncoesSimples,
  untTypesSistema, untImportaPedidoXmlTela;

{$R *.dfm}

procedure TfrmEntNFEDigManualEdit.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  With objNFEDig Do
  Begin
    pSalvaItem;

    pSetFocusItem;
  End;
end;

procedure TfrmEntNFEDigManualEdit.btnCancelaItemClick(Sender: TObject);
begin
  inherited;

  With objNFEDig Do
  Begin
    pCancelaEdicaoItem;

    pSetFocusItem;
  End;

end;

procedure TfrmEntNFEDigManualEdit.btnExcluirClick(Sender: TObject);
begin
  inherited;

  objNFEDig.pExcluiItem;
  objNFEDig.pCancelaEdicaoItem;
end;

procedure TfrmEntNFEDigManualEdit.btnImportaPedidosClick(Sender: TObject);
begin
  inherited;

  If (Not objNFEDig.zclDetEle.IsEmpty) Then
  Begin
    If Not fPergunta('Ao importar um pedido os itens já incluidos nessa nota serão apagados. Deseja continuar?') Then
      Exit;
  End;

  Try
    pCriarFormularios(TfrmImportaPedidoXmlTela, frmImportaPedidoXmlTela);

    frmImportaPedidoXmlTela.objNFEDig := objNFEDig;

    If frmImportaPedidoXmlTela.ShowModal = mrOk Then
    Begin
      If (objNFEDig.zclGerEle.State In dsEditModes) And
         (Not objNFEDig.cdsPedImp.IsEmpty) Then
      Begin
        objNFEDig.zclGerEle.FieldByName('GER_ESPNOT').AsString := 'PD';

        objNFEDig.zclGerEle.FieldByName('GER_CODFOR').AsString := objNFEDig.cdsPedImp.FieldByName('CODFOR').AsString;
        dbeNomFan.Field.AsString := fRetNomFanFor(dbeCodFor.Text);
        If dbeNomFan.Field.AsString.IsEmpty Then
          dbeNomFan.Field.AsString := fRetNomFornecedor(dbeCodFor.Text);

        objNFEDig.zclGerEle.FieldByName('C03_XNOME').AsString := fRetNomFornecedor(dbeCodFor.Text);

        objNFEDig.zclGerEle.FieldByName('W07_VPROD').AsFloat := objNFEDig.zclDetEle.fRetSoma('SUM_TOTPRO');
        objNFEDig.zclGerEle.FieldByName('W16_VNF').AsFloat   := objNFEDig.zclDetEle.fRetSoma('SUM_TOTPRO');

        If objNFEDig.zclGerEle.FieldByName('B09_DEMI').IsNull Then
          objNFEDig.zclGerEle.FieldByName('B09_DEMI').AsDateTime := VS_Date;

      End;

    End;

    pFreeAndNil(frmImportaPedidoXmlTela);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmEntNFEDigManualEdit.btnImportaPedidosClick]');
    End;
  End;

end;

procedure TfrmEntNFEDigManualEdit.cxgItensEnter(Sender: TObject);
begin
  inherited;

  With objNFEDig Do
  Begin
    pCancelaEdicaoItem(opcEditar);
  End;

end;

procedure TfrmEntNFEDigManualEdit.dbeBasIcmTotKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN : If (ActiveControl Is TDBEdit) And fValidaCampos(Sender As TWinControl, True) And
                    blnMudarFoco Then
                  SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmEntNFEDigManualEdit.dbeCodBarKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
    qryCadMco: TUniQuery;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    qryCadMco := fCriaQuery;

    If fPesqMaterialConsumo(Self,
                            Nil,
                            dbeDesIte,
                            qryCadMco,
                            Key,
                            arrSel,
                            True,
                            dbeCodFor.Text) Then
    Begin

      If qryCadMco.RecordCount > 0 Then
      Begin
        dbeCodBar.Text := qryCadMco.FieldByName('MCO_CODBAR').AsString;
        dtsDetEleEdit.DataSet.FieldByName('DET_CODMCO').AsString := qryCadMco.FieldByName('MCO_CODMCO').AsString;
      End;

      If fValidaCampos(dbeCodBar, True) Then
        SelectNext(ActiveControl, True, True);

    End;

    FreeAndNil(qryCadMco);
  End;
end;

procedure TfrmEntNFEDigManualEdit.dbeCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, dbeCodFor, dbeNomFan, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(dbeCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEntNFEDigManualEdit.dbeCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  fedtCodIteKeyPressGer(Sender, Key);
  
end;

procedure TfrmEntNFEDigManualEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  objNFEDig.pCancelaEdicaoItem(opcGravar);

  if (ModalResult <> mrOk) And
     ( (dtsDetEleGrid.DataSet.RecordCount > 0 ) or
       (not fEmptyDate(dbeDtaEmi.Text)) or
       (not fEmptyStr(dbeNumDoc.Text)) or
       (not fEmptyStr(dbeNumSer.Text)) or
       (not fEmptyStr(dbeCodFor.Text)) ) Then
  Begin
    If (cxgItens.IsFocused) And (dtsDetEleGrid.DataSet.RecordCount > 0 ) Then
    Begin
      btnCancelaItemClick(nil);
      Action := caNone;
      Exit;
    End
    Else
    If fMensagem('', 'Deseja cancelar a inclusão/edição dos dados?', ['&Sim', '&Não'], 2) = 2 Then
    Begin
      btnCancelaItemClick(nil);
      Action := caNone;
      Exit;
    End;

  End;

  inherited;

  If ModalResult = mrOk Then
  Begin

    If (Not fVerificaCampos) Or
       (Not objNFEDig.fValidaTotaisNota(fStrToFloat(dbeBasIcmTot.Text),
                                        fStrToFloat(dbeTotIcm.Text),
                                        fStrToFloat(dbeBasSubTot.Text),
                                        fStrToFloat(dbeTotSub.Text),
                                        fStrToFloat(dbeTotIpi.Text),
                                        fStrToFloat(dbeTotPro.Text))) Or
       (Not objNFEDig.fValidaDocumentoUnico(dbeNumDoc.Text,
                                            dbeNumSer.Text,
                                            dbeCodFor.Text)) Then
    Begin
      Action := caNone;
      Exit;
    End;

    objNFEDig.pRecalculaDescontoItens(fStrToFloat(dbeDesCon.Text),
                                      fStrToFloat(dbeValFre.Text),
                                      fStrToFloat(dbeDesAce.Text),
                                      dbeTotPro.Field.AsFloat);
  End;

end;

procedure TfrmEntNFEDigManualEdit.FormCreate(Sender: TObject);
begin
  inherited;
  objLock := TLock.Create;
  strKeyLck := '';
end;

procedure TfrmEntNFEDigManualEdit.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(objLock);
end;

procedure TfrmEntNFEDigManualEdit.pSetFocusItem;
Begin
  If dbeCodBar.Visible Then
    pSetFocus(dbeCodBar)
  Else
    pSetFocus(dbeCodIte);
End;

procedure TfrmEntNFEDigManualEdit.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F9    : btnImportaPedidos.Click;

    VK_F10   : btnConfirma.Click;

    VK_DELETE: If fCheckParent(ActiveControl, cxgItens) Then
                 btnExcluir.Click;

    VK_RETURN: If fCheckParent(ActiveControl, cxgItens) Then
                 pSetFocusItem;
  End;

end;

procedure TfrmEntNFEDigManualEdit.FormShow(Sender: TObject);
begin
  inherited;

  pSetaCodIte( dbeCodIte );

  pLigaClients;

  pSetFocus(dbeDtaEmi);
end;

procedure TfrmEntNFEDigManualEdit.pLigaClients;
Begin
  With objNFEDig do
  Begin
    dtsGerEle.DataSet     := zclGerEle;
    dtsDetEleGrid.DataSet := zclDetEle;
    dtsDetEleEdit.DataSet := zclDetIns;
    dtsEdits              := dtsDetEleEdit;

    pTrataColunas;
  End;
End;

procedure TfrmEntNFEDigManualEdit.pTrataColunas;
Begin
  With objNFEDig do
  Begin
    cxgItensCODITE.Visible := strMatRev <> 'M';
    cxgItensCODBAR.Visible := strMatRev  = 'M';

    If strMatRev = 'M' Then
    Begin
      dbeDesIte.ReadOnly    := False;
      dbeDesIte.TabStop     := True;
      dbeDesIte.Color       := clWhite;

      dbeCodBar.Left        := dbeCodIte.Left;
      dbeCodBar.Visible     := True;
      dbeCodIte.Visible     := False;

      lblCodIte.Caption     := 'Código de Barras:';
      dbeDesIte.Left        := dbeCodBar.Left + dbeCodBar.Width + 2;
    End Else
    Begin
      dbeDesIte.ReadOnly    := True;
      dbeDesIte.TabStop     := False;
      dbeDesIte.Color       := $00FFDFB8;

      dbeCodBar.Visible     := False;
      dbeCodIte.Visible     := True;
      lblCodIte.Caption     := 'Código do Item:';
      dbeDesIte.Left        := dbeCodIte.Left + dbeCodIte.Width + 2;
    End;

  End;

End;

procedure TfrmEntNFEDigManualEdit.pnlItemEnter(Sender: TObject);
begin
  inherited;

  objNFEDig.pEditaItem;

end;

procedure TfrmEntNFEDigManualEdit.pnlItemExit(Sender: TObject);
begin
  inherited;

  objNFEDig.pCancelaEdicaoItem;
end;

Function TfrmEntNFEDigManualEdit.fedtCodIteKeyPressGer(Sender: TObject;
  var Key: Char): Boolean;
  Var
    arrSel: TConsultasArray;
    objfrmPnl: TPanelCxItem;
    qryConCit: TUniQuery;
begin
  If (fEntraCons(Key))         And
     (Not dbeCodIte.ReadOnly)  Then
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
                     dbeCodIte,
                     dbeDesIte,
                     qryConCit,
                     Key,
                     arrSel,
                     True,
                     objfrmPnl,
                     'Consulta de Itens',
                     objFrmPnl.recParametros.strTabPre,
                     '',
                     0,
                     false,
                     false,
                     0) Then
        Begin

          If fValidaCampos(dbeCodIte) Then
            SelectNext(ActiveControl, True, True);

        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmEntNFEDigManualEdit.fedtCodIteKeyPressGer]');
        End;
      End;


    Finally
      FreeAndNil(objfrmPnl);
      FreeAndNil(qryConCit);
    End;

  End;

  Result := True;

end;

function TfrmEntNFEDigManualEdit.fValidaBase(dbeBase, dbeAliquota, dbeValor:TDBEditFocus;
          strNome: String; blnBuscaPorChave: Boolean; fltDefAli: Double = 0): Boolean;
  Var
    fltBase: Double;
Begin
  Result  := True;

  fltBase := fStrToFloat(dbeBase.Text);

  If fltBase < 0 Then
  Begin
    pMensagemOk('A base de ' + strNome + ' deve ser maior ou igual a zero!');
    Result := False;
  End

  Else If Assigned(dbeAliquota) Then
  Begin

    If (fltDefAli > 0) And (fltBase > 0) Then
    Begin
      dbeAliquota.Field.AsFloat := fltDefAli;
    End Else
    Begin
      dbeAliquota.Enabled := fltBase > 0;
      If (Not dbeAliquota.Enabled) Or fEmptyStr(dbeAliquota.Text) Then
        dbeAliquota.Field.AsFloat := 0;
    End;

    dbeValor.Field.AsFloat := RoundTo(fltBase * (dbeAliquota.Field.AsFloat / 100), -2);

    pCalculaTotalItem(blnBuscaPorChave);
  End;

End;

function TfrmEntNFEDigManualEdit.fValidaAliquota(dbeBase, dbeAliquota, dbeValor:TDBEditFocus;
  strNome: String; blnBuscaPorChave: Boolean): Boolean;
  Var
    fltAliquota: Double;
Begin
  Result  := True;

  fltAliquota := fStrToFloat(dbeAliquota.Text);

  If fltAliquota < 0 Then
  Begin
    pMensagemOk('A alíquota de ' + strNome + ' deve ser maior ou igual a zero!');
    Result := False;
  End

  Else
  Begin
    If fEmptyStr(dbeBase.Text) Then
      dbeBase.Field.AsFloat := 0;

    dbeValor.Field.AsFloat := RoundTo(fStrToFloat(dbeBase.Text) * (fltAliquota / 100), -2);

    pCalculaTotalItem(blnBuscaPorChave);
  End;

End;

Procedure TfrmEntNFEDigManualEdit.pCalculaTotalItem(blnBuscaPorChave: Boolean);
  Var
    fltValLiq: Double;
Begin
  If fEmptyStr(dbeUnitar.Text) Then
    dbeUnitar.Field.AsFloat := 0;

  If fEmptyStr(dbeQtdIte.Text) Then
    dbeQtdIte.Field.AsFloat := 0;

  dbeTotIte.Field.AsFloat := RoundTo(fStrToFloat(dbeUnitar.Text) * fStrToFloat(dbeQtdIte.Text),  -2);

  dbeDscIte.Field.AsFloat := objNFEDig.fDescontoItem(dbeTotIte.Field.AsFloat,
                                                     fStrToFloat(dbeDesCon.Text),
                                                     fStrToFloat(dbeTotPro.Text));

  dbeFreIte.Field.AsFloat := objNFEDig.fFreteItem(dbeTotIte.Field.AsFloat,
                                                  fStrToFloat(dbeValFre.Text),
                                                  fStrToFloat(dbeTotPro.Text));

  dbeAceIte.Field.AsFloat := objNFEDig.fDespesasAcessoriasItem(dbeTotIte.Field.AsFloat,
                                                               fStrToFloat(dbeDesAce.Text),
                                                               fStrToFloat(dbeTotPro.Text));

  fltValLiq := objNFEDig.fValorLiquidoItem(dbeTotIte.Field.AsFloat,
                                           dbeDscIte.Field.AsFloat,
                                           dbeFreIte.Field.AsFloat,
                                           dbeAceIte.Field.AsFloat,
                                           dbeValIpi.Field.AsFloat,
                                           dbeValSub.Field.AsFloat);

  If blnBuscaPorChave Then
  Begin
    If dbeBasPis.Field.IsNull Then
      dbeBasPis.Field.AsFloat := fltValLiq;

    If dbeBasCof.Field.IsNull Then
      dbeBasCof.Field.AsFloat := fltValLiq;

    fValidaBase(dbeBasPis, dbeAlqPis, dbeValPis, 'PIS',    False, objNFEDig.fltAliPis);
    fValidaBase(dbeBasCof, dbeAlqCof, dbeValCof, 'COFINS', False, objNFEDig.fltAliCof);
  End;

End;

function TfrmEntNFEDigManualEdit.fTotalBruto: Double;
Begin
  Result := fStrToFloat(dbeTotPro.Text) + fStrToFloat(dbeTotSub.Text) +
            fStrToFloat(dbeTotIpi.Text) + fStrToFloat(dbeDesAce.Text) +
            fStrToFloat(dbeValFre.Text);
End;

function TfrmEntNFEDigManualEdit.fValidaValorNota(dbeBasVal: TDBEdit; strTitulo: String;
                           blnBuscaPorChave: Boolean;
                           dbeValor: TDBEdit = Nil; blnPerZer: Boolean = True): Boolean;
  Var
    fltValor: Double;
Begin
  If fEmptyStr(dbeBasVal.Text) Then
    dbeBasVal.Field.AsFloat := 0; 

  fltValor := fStrToFloat(dbeBasVal.Text);

  If (Not blnPerZer) And (fltValor <= 0) Then
  Begin
    Result := False;
    pMensagemOk(strTitulo + ' deve ser maior que zero!');
  End

  Else If (fltValor < 0) Then
  Begin
    Result := False;
    pMensagemOk(strTitulo + ' deve ser maior ou igual a zero!')
  End Else

  Begin
    Result := True;

    If Assigned(dbeValor) Then
    Begin
      dbeValor.Enabled := fltValor > 0;
      If Not dbeValor.Enabled Then
        dbeValor.Field.AsFloat := 0;
    End;

    If fTotalBruto - fStrToFloat(dbeDesCon.Text) > 0 Then
      dbeTotNot.Field.AsFloat := fTotalBruto - fStrToFloat(dbeDesCon.Text)
    Else
      dbeTotNot.Field.AsFloat := 0;

  (*  If blnBuscaPorChave Then
      objNFEDig.pRecalculaDescontoItens(fStrToFloat(dbeDesCon.Text),
                                        fStrToFloat(dbeValFre.Text),
                                        fStrToFloat(dbeDesAce.Text),
                                        dbeTotPro.Field.AsFloat); *)

  End;
End;

function TfrmEntNFEDigManualEdit.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strDesIte,
    strCodMco: String;
    fltUnitar: Double;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeDtaEmi) Then
    Begin

      If fEmptyDate(dbeDtaEmi.Text) Then
      Begin
        pMensagemOk('Informe a data de emissão!');
        Result := False;
      End

      Else If StrToDateDef(dbeDtaEmi.Text, 0) > VS_Date Then
      Begin
        pMensagemOk('A data de emissão deve ser menor ou igual a data atual!');
        Result := False;
      End;

    End

    Else If (Sender = dbeDesCon) Then
    Begin
      Result := fValidaValorNota(dbeDesCon, 'O Valor do desconto', blnBuscaPorChave);
    End

    Else If (Sender = dbeBasIcmTot) Then
    Begin
      Result := fValidaValorNota(dbeBasIcmTot, 'A Base de ICMS', blnBuscaPorChave, dbeTotIcm);
    End

    Else If (Sender = dbeTotIcm) Then
    Begin
      Result := fValidaValorNota(dbeTotIcm, 'O Total de ICMS', blnBuscaPorChave);
    End

    Else If (Sender = dbeBasSubTot) Then
    Begin
      Result := fValidaValorNota(dbeBasSubTot, 'A Base de ICMS Substituição', blnBuscaPorChave, dbeTotSub);
    End

    Else If (Sender = dbeTotSub) Then
    Begin
      Result := fValidaValorNota(dbeTotSub, 'O Total de ICMS Substituição', blnBuscaPorChave);
    End

    Else If (Sender = dbeTotPro) Then
    Begin
      Result := fValidaValorNota(dbeTotPro, 'O Total dos Produtos', blnBuscaPorChave, Nil, False);
    End

    Else If (Sender = dbeValFre) Then
    Begin
      Result := fValidaValorNota(dbeValFre, 'O valor do frete', blnBuscaPorChave);
    End

    Else If (Sender = dbeDesAce) Then
    Begin
      Result := fValidaValorNota(dbeDesAce, 'O valor de outras despesas', blnBuscaPorChave);
    End

    Else If (Sender = dbeTotIPI) Then
    Begin
      Result := fValidaValorNota(dbeTotIPI, 'O Total de IPI', blnBuscaPorChave);

      If Result And (fStrToFloat(dbeDesCon.Text) >= fTotalBruto) Then
      Begin
        Result := False;
        blnMudarFoco := False;
        pMensagemOk('O desconto deve ser menor que o valor da nota!');

        If dbeDesCon.CanFocus Then
        Begin
          pSetFocus(dbeDesCon);
          Exit;
        End;
      End;
    End

    Else If (Sender = dbeNumDoc) Then
    Begin

      If fEmptyStr(dbeNumDoc.Text) Then
      Begin
        pMensagemOk('Informe o número do documento!');
        Result := False;
      End
      Else
        dbeNumDoc.Text := fStrZero(dbeNumDoc.Text, fTamNumDoc);

    End

    Else If (Sender = dbeCodFor) Then
    Begin

      If fEmptyStr(dbeCodFor.Text) Then
      Begin
        pMensagemOk('Informe o código do fornecedor!');
        Result := False;
      End Else
      Begin

        dbeNomFan.Field.AsString := fRetNomFanFor(dbeCodFor.Text);
        If dbeNomFan.Field.AsString.IsEmpty Then
          dbeNomFan.Field.AsString := fRetNomFornecedor(dbeCodFor.Text);

        objNFEDig.zclGerEle.FieldByName('C03_XNOME').AsString := fRetNomFornecedor(dbeCodFor.Text);

        If fEmptyStr(dbeNomFan.Text) Then
        Begin
          pMensagemOk('Fornecedor não econtrado!');
          Result := False;
        End

        Else If (Not SameText(strKeyLck, fRetKeyLck)) Then
        Begin
          objLock.pDestravarTodos;
          strKeyLck := fRetKeyLck;

          If Not objLock.fLock_Unlock(strKeyLck, True, False) Then
          Begin
            fMensagem('ATENÇÃO!', 'Um documento com os mesmos dados está sendo digitado em outra estação: ' + fGetHostLock(strKeyLck + '%'), ['&Ok']);
            Result := False;
          End
        End;

      End;

      If Result Then
      Begin
        objNFEDig.strCodFor := dbeCodFor.Text;

        pTrataColunas;
      End;
    End

    Else If dtsDetEleEdit.DataSet.State In [dsEdit, dsInsert] Then
    Begin

      If (Sender = dbeCodIte) Then
      Begin

        If dbeCodIte.Visible Then
      Begin
        If blnBuscaPorChave and fEmptyStr(dbeCodIte.Text) and (cxgItensTableView.DataController.DataSet.RecordCount > 0) Then
        begin
          blnMudarFoco := False;
          pSetFocus(cxgItens);
        end
        else If fEmptyStr(dbeCodIte.Text) Then
        Begin
            pMensagemOk('Informe o código do item!');
            Result := False;
          End Else
          Begin
            dbeDesIte.Text := fRetNomProduto(dbeCodIte.Text);

            dtsDetEleEdit.DataSet.FieldByName('I04_XPROD').AsString := dbeDesIte.Text;

            If fEmptyStr(dbeDesIte.Text) Then
            Begin
              pMensagemOk('Item não econtrado!');
              Result := False;
            End;

          End;

        End;

      End

      Else If (Sender = dbeCodBar) Then
      Begin

        If dbeCodBar.Visible Then
        Begin

          If Not fEmptyStr(dbeCodBar.Text) Then
          Begin

            strDesIte := fRetNomeMaterialConsumo(dbeCodFor.Text, dbeCodBar.Text, strCodMco, fltUnitar);

            If fEmptyStr(dbeDesIte.Text) Then
               dbeDesIte.Text := strDesIte;

            If Not fEmptyStr(strCodMco) Then
            Begin
              dtsDetEleEdit.DataSet.FieldByName('DET_CODMCO').AsString := strCodMco;

              If blnBuscaPorChave And (fStrToFloat(dbeUnitar.Text) = 0) Then
                dtsDetEleEdit.DataSet.FieldByName('I10A_VUNCOM').AsFloat := fltUnitar;

            End Else
              dtsDetEleEdit.DataSet.FieldByName('DET_CODMCO').Clear;

            dtsDetEleEdit.DataSet.FieldByName('I04_XPROD').AsString := dbeDesIte.Text;
          End;

        End;

      End

      Else If (Sender = dbeDesIte) Then
      Begin

        If fEmptyStr(dbeDesIte.Text) And (Not dbeDesIte.ReadOnly) Then
        Begin
          pMensagemOk('Informe a descrição do item!');
          Result := False;
        End;

      End

      Else If (Sender = dbeQtdIte) Then
      Begin

        If fStrToFloat(dbeQtdIte.Text) <= 0 Then
        Begin
          pMensagemOk('A quantidade deve ser maior que zero!');
          Result := False;
        End

        Else pCalculaTotalItem(blnBuscaPorChave);

      End

      Else If (Sender = dbeUnitar) Then
      Begin

        If fStrToFloat(dbeUnitar.Text) <= 0 Then
        Begin
          pMensagemOk('O valor unitário deve ser maior que zero!');
          Result := False;
        End

        Else pCalculaTotalItem(blnBuscaPorChave);

      End

      Else If (Sender = dbeBasIpi) Then
      Begin
        Result := fValidaBase(dbeBasIpi, dbeAlqIpi, dbeValIpi, 'IPI', blnBuscaPorChave);
      End

      Else If (Sender = dbeAlqIpi) Then
      Begin
        Result := fValidaAliquota(dbeBasIpi, dbeAlqIpi, dbeValIpi, 'IPI', blnBuscaPorChave);
      End

      Else If (Sender = dbeBasIcm) Then
      Begin
        Result := fValidaBase(dbeBasIcm, dbeAlqIcm, dbeValIcm, 'ICMS', blnBuscaPorChave);
      End

      Else If (Sender = dbeAlqIcm) Then
      Begin
        Result := fValidaAliquota(dbeBasIcm, dbeAlqIcm, dbeValIcm, 'ICMS', blnBuscaPorChave);
      End

      Else If (Sender = dbeBasSub) Then
      Begin
        Result := fValidaBase(dbeBasSub, Nil, Nil, 'Substituição', blnBuscaPorChave);
      End

      Else If (Sender = dbeValSub) Then
      Begin

        If fStrToFloat(dbeValSub.Text) < 0 Then
        Begin
          pMensagemOk('O Valor do ICMS Substituição deve ser maior ou igual a zero!');
          Result := False;
        End;

      End

      Else If (Sender = dbeBasPis) Then
      Begin
        Result := fValidaBase(dbeBasPis, dbeAlqPis, dbeValPis, 'PIS', False, objNFEDig.fltAliPis);
      End

      Else If (Sender = dbeBasCof) Then
      Begin
        Result := fValidaBase(dbeBasCof, dbeAlqCof, dbeValCof, 'COFINS', False, objNFEDig.fltAliCof);
      End

      Else If (Sender = dbeCST) Then
      Begin
        If fEmptyStr(dbeCST.Text) Then
        Begin
          pMensagemOk('Informe o Código Fiscal (CST)!');
          Result := False;
        End;
      End;

    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

Function TfrmEntNFEDigManualEdit.fRetKeyLck: String;
Begin
  Result := 'ENTRADA_MERC_' + dbeNumDoc.Text + 'NF' + dbeCodFor.Text + VS_strCodEmp + dbeNumSer.Text;
End;

end.

