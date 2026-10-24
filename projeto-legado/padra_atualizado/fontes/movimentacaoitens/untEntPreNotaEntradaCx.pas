unit untEntPreNotaEntradaCx;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, untSalvaDadosInterface,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxMaskEdit,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, EditFocus, cxGridCitel,
  cxGridBandedTableView, cxGridDBBandedTableView, MaskUtils, untPreNota,
  untFuncoesSimples, untFuncoesGenerica, cxCurrencyEdit, Math, StrUtils,
  cxDataControllerConditionalFormattingRulesManagerDialog, Vcl.DBCtrls,
  DBMemoFocus, untTEditFocusWithTConsultasArray, dxcore;

type
  TfrmEntPreNotaEntradaCx = class(TfrmPai)
    pnlHeader: TPanel;
    Panel1: TPanel;
    lblNotEle: TLabel;
    btnNotEle: TBitBtnLocked;
    edtNotEle: TEditFocus;
    Panel2: TPanel;
    lblTipoDoc: TLabel;
    edtNumPed: TEditFocus;
    edtLisPed: TEditFocus;
    pnlCnvEmb: TPanel;
    rdgTipUni: TRadioGroup;
    pnlConPag: TPanel;
    pnlConGerEle: TPanel;
    lblConPagNot: TLabel;
    Shape3: TShape;
    lblPrazoMedioMaior: TLabel;
    Shape4: TShape;
    lblPrazoMedioMenor: TLabel;
    lblCNPJTransportadoraDivergenteBaseIgual: TLabel;
    lblCNPJTransportadoraDivergente: TLabel;
    Shape5: TShape;
    Shape6: TShape;
    cxgPedidos: TcxGrid;
    cxgPedidosView: TcxGridDBTableView;
    cxgPedidosNUMPED: TcxGridDBColumn;
    cxgPedidosCODEMP: TcxGridDBColumn;
    cxgPedidosCONPAG: TcxGridDBColumn;
    cxgPedidosPRAMED: TcxGridDBColumn;
    cxgPedidosTRAPED: TcxGridDBColumn;
    cxgPedidosLevel1: TcxGridLevel;
    pnlTotais: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    lblFrePed: TLabel;
    lblLegendaCNVEMB: TLabel;
    edtDifFre: TEditFocus;
    edtFreNfe: TEditFocus;
    edtFrePed: TEditFocus;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxvItens: TcxGridDBBandedTableView;
    cxvItensNUMPED: TcxGridDBBandedColumn;
    cxvItensQTDPED: TcxGridDBBandedColumn;
    cxvItensSELPED: TcxGridDBBandedColumn;
    cxvItensQTDNFE: TcxGridDBBandedColumn;
    cxvItensUNIPED: TcxGridDBBandedColumn;
    cxvItensUNINFE: TcxGridDBBandedColumn;
    cxvItensIPIPED: TcxGridDBBandedColumn;
    cxvItensIPINFE: TcxGridDBBandedColumn;
    cxvItensSUBPED: TcxGridDBBandedColumn;
    cxvItensSUBNFE: TcxGridDBBandedColumn;
    cxvItensCODITE: TcxGridDBBandedColumn;
    cxvItensDESITE: TcxGridDBBandedColumn;
    cxvItensCODFAB: TcxGridDBBandedColumn;
    cxvItensREFERE: TcxGridDBBandedColumn;
    cxvItensSIGUNI: TcxGridDBBandedColumn;
    cxvItensQTDRES: TcxGridDBBandedColumn;
    cxvItensNROITE: TcxGridDBBandedColumn;
    cxvItensCODITE2: TcxGridDBBandedColumn;
    cxvItensQTDNFE_UNI: TcxGridDBBandedColumn;
    Splitter1: TSplitter;
    chkOcultarItens: TCheckBox;
    cxvItensPEDNFE: TcxGridDBBandedColumn;
    Label6: TLabel;
    cxvItensRESPED: TcxGridDBBandedColumn;
    btnPedPre: TBitBtnLocked;
    pnlAplicacao: TPanel;
    pnlAplica: TPanel;
    mmoAplica: TDBMemoFocus;
    lblCotDol: TLabel;
    edtCotDol: TEditFocus;
    cxgPedidosDTAPREV: TcxGridDBColumn;
    cxgPedidosDIVPREV: TcxGridDBColumn;
    lblTranspNota: TLabel;
    cxgPedidosTIPFRE: TcxGridDBColumn;
    Shape8: TShape;
    lblCondicaoPagamento: TLabel;
    cxvItensCFABIT: TcxGridDBBandedColumn;
    lblDataNota: TLabel;
    cxvItensIMPULT: TcxGridDBBandedColumn;
    cxvItensDTAULT: TcxGridDBBandedColumn;
    cxvItensFORULT: TcxGridDBBandedColumn;
    cxvItensNOTULT: TcxGridDBBandedColumn;
    btnCriticas: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    Panel3: TPanel;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    lblNFEPed: TLabel;
    shaNFEPed: TShape;
    Shape1: TShape;
    Shape2: TShape;
    Shape7: TShape;
    procedure cxvItensCODITEGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure btnNotEleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNotEleEnter(Sender: TObject);
    procedure btnNotEleExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtNumPedEnter(Sender: TObject);
    procedure edtNumPedKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnCriticasClick(Sender: TObject);
    procedure cxgPedidosPRAMEDCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgPedidosTRAPEDCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgPedidosTRAPEDGetDataText(Sender: TcxCustomGridTableItem;
      ARecordIndex: Integer; var AText: string);
    procedure cxvItensSELPEDCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvItensUNIPEDCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvItensIPIPEDCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvItensSUBPEDCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvItensNUMPEDCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnPedPreClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxgPedidosViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvItensNROITEHeaderClick(Sender: TObject);
    procedure cxgPedidosCONPAGCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvItensCODITE2HeaderClick(Sender: TObject);
  private
    { Private declarations }
    strCondicaoPagamento: String;
    strPrazoMedioMaior: String;
    strPrazoMedioMenor: String;
    strCNPJTransportadoraDivergente: String;
    strCNPJTransportadoraDivergenteBaseIgual: String;
    intDecimaisQuantidade: Integer;

    FPais: TPais;

    objPreNota: TPreNota;
    objSalvaFiltros: TSalvaInterface;

    blnSair: Boolean;
    blnImpEti: Boolean;  //CFG_IMPPNE
    procedure pMostraCndPagNota;

    procedure pCancela(blnPerguntar: Boolean = True; blnOrigemBtnConfirma: Boolean = False);

    procedure pHabilitaCotacao(blnHabilita: Boolean);
    procedure pCarregaNota;
    procedure pImprimirEtiqueta(strIncGer: String);

  public
    strAutoincrem : String;
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

uses untMensagemExplicativa, untTipoFreteAtc, untConstantes, untEntEtiquetas;

procedure TfrmEntPreNotaEntradaCx.pMostraCndPagNota;
Begin
  With objPreNota.recNotEle Do
  Begin
    lblConPagNot.Caption := 'Condição de Pagamento da Nota Eletrônica: ' + FormatMaskText(MASK_CONPAG5, strConPag);

    If (strTipFre = '2') Then
      lblConPagNot.Caption := lblConPagNot.Caption + ' Transportadora NF: ' + fFormataCpfCgc(strCnpjTr, FPais);

    lblTranspNota.Visible := False;
    If Not fEmptyStr(objPreNota.recNotEle.strCnpjTr) Then
    Begin
      lblTranspNota.Visible := True;
      lblTranspNota.Caption := Format(lblTranspNota.Caption, [objPreNota.recNotEle.strCodTra + ' - ' + objPreNota.recNotEle.strNomTra,
                                      fDescricaoFrete(objPreNota.fTraduzFrete(objPreNota.recNotEle.strModFre))]);
    End;

    lblDataNota.Caption := 'Data de Emissão da Nota Eletrônica: ' + DateToStr(objPreNota.recNotEle.dtaDtaDoc);
  End;
End;

procedure TfrmEntPreNotaEntradaCx.btnConfirmaClick(Sender: TObject);
  Var
    strAutInc: String;
begin
  inherited;
  strAutInc := objPreNota.recNotEle.strAutInc;
  objPreNota
    .fApagarMotivos
    .fAdicionarMotivos(strCondicaoPagamento)
    .fAdicionarMotivos(strPrazoMedioMaior)
    .fAdicionarMotivos(strPrazoMedioMenor)
    .fAdicionarMotivos(strCNPJTransportadoraDivergente)
    .fAdicionarMotivos(strCNPJTransportadoraDivergenteBaseIgual);

  If objPreNota.fConfirma Then
  begin
    pCancela(False, True);

    If blnImpEti Then
    begin
      pImprimirEtiqueta(strAutInc);
    end;
  end;


end;

procedure TfrmEntPreNotaEntradaCx.pCancela(blnPerguntar: Boolean = True; blnOrigemBtnConfirma: Boolean = False);
Begin
  If (fEmptyStr(edtNotEle.Text) Or (objPreNota.IsEmpty) Or (not fEmptyStr(strAutoincrem))) Then
  Begin
    edtNotEle.Clear;
    objPreNota.pClose(True);
    Close;
  End

  Else If (Not blnPerguntar) Or
          (fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não']) = 1) Then
  Begin

    edtNumPed.Enabled := True;
    btnNotEle.Enabled := True;
    rdgTipUni.Enabled := True;
    chkOcultarItens.Enabled := True;
    pSetFocus(btnNotEle);

    edtNotEle.Clear;
    //rdgTipUni.ItemIndex := 0;
    edtNumPed.Clear;
    edtLisPed.Clear;
    edtNumPed.Enabled := False;
    edtFrePed.Clear;
    edtFreNfe.Clear;
    edtDifFre.Clear;
    edtFrePed.Color := edtFrePed.NormalColor;
    edtFreNfe.Color := edtFrePed.NormalColor;
    edtDifFre.Color := edtFrePed.NormalColor;

    objPreNota.pClose(True);
    If Not blnOrigemBtnConfirma Then
    Begin
      blnSair := True;
      Close;
    End

  End
  Else
    blnSair := False;
End;

procedure TfrmEntPreNotaEntradaCx.btnCriticasClick(Sender: TObject);
begin
  inherited;

  objPreNota.pMostraCriticas;
end;

procedure TfrmEntPreNotaEntradaCx.btnNotEleClick(Sender: TObject);
begin
  inherited;

  If objPreNota.fSelecionaNFE Then
  Begin
    pCarregaNota();
  End
  Else
  Begin
    edtNumPed.Enabled := False;
    edtNotEle.Clear;
    //rdgTipUni.ItemIndex := 0;

    edtFreNfe.Clear;
  End;

  strCondicaoPagamento := '';
  strPrazoMedioMaior:= '';
  strPrazoMedioMenor:= '';
  strCNPJTransportadoraDivergente:= '';
  strCNPJTransportadoraDivergenteBaseIgual:= '';

  pMostraCndPagNota;
end;

procedure TfrmEntPreNotaEntradaCx.pCarregaNota;
  var
    stlListaItens: TStringList;
begin
  inherited;
  stlListaItens := TStringList.Create;

  If Assigned(frmMensagemExplicativa)  then
    FreeAndNil(frmMensagemExplicativa);

  pCriarFormularios(TfrmMensagemExplicativa , frmMensagemExplicativa);
  Try
    If fExisteItemInativoNotaEntrada(objPreNota.recNotEle.strAutInc, stlListaItens) Then
    Begin
      frmMensagemExplicativa.Caption := 'Itens Inativos.';
      frmMensagemExplicativa.mmoInstru.Lines.Text := stlListaItens.Text;
      frmMensagemExplicativa.ShowModal;
      objPreNota.pClose(True);
      Close;
      Exit;
    End;

  Finally
    FreeAndNil(stlListaItens);
    //FreeAndNil(frmMensagemExplicativa);
  End;

  edtNotEle.Text := objPreNota.recNotEle.strNotas;

  edtFreNfe.Text := FormatFloat('#,##0.00', objPreNota.recNotEle.fltValFre);

  If objPreNota.blnPedidosPreDefinidos Then
  Begin
    edtNumPed.Clear;
    edtLisPed.Visible := True;
    edtLisPed.Text    := objPreNota.stlPedidos.CommaText;

    cxvItens.Bands[1].Width := 210;
    cxvItensPEDNFE.Visible := True;

    shaNFEPed.Visible := True;
    lblNFEPed.Visible := True;

    If objPreNota.blnPedidosPreDefinidos Then
      rdgTipUni.ItemIndex := fMensagem('', 'XML enviado em?', ['Unidade de &Compra', 'Unidade de &Venda'],
        1, False, 1, 200, False, 0, False, False, True) -1;

    If fValidaCampos(edtNumPed) Then ;
   //   edtNumPed.Enabled := objPreNota.blnTemItemSemPedido
   // Else
    edtNumPed.Enabled := True;
  End Else
  Begin
    cxvItens.Bands[1].Width := 105;
    cxvItensPEDNFE.Visible := False;

    shaNFEPed.Visible := False;
    lblNFEPed.Visible := False;

    SelectNext(ActiveControl, True, True);

    edtNumPed.Enabled := True;
  End;


  If edtNumPed.Enabled Then
    pSetfocus(edtNumPed);

  pMostraCndPagNota;
end;


procedure TfrmEntPreNotaEntradaCx.btnNotEleEnter(Sender: TObject);
begin
  inherited;

  If assigned(objPreNota) Then
    objPreNota.pClose(True);

  edtNotEle.Clear;
  //rdgTipUni.ItemIndex := 0;
  edtNumPed.Enabled := False;
end;

procedure TfrmEntPreNotaEntradaCx.btnNotEleExit(Sender: TObject);
begin
  inherited;

  If btnSair.Focused Then
    Exit;

  If Not fEmptyStr(objPreNota.recNotEle.strNumDoc) Then
    pSetFocus(edtNumPed);

end;

procedure TfrmEntPreNotaEntradaCx.btnPedPreClick(Sender: TObject);
begin
  inherited;

  objPreNota.pConsultaItensPreNota;
end;

procedure TfrmEntPreNotaEntradaCx.btnSairClick(Sender: TObject);
begin

  blnSair := True;
  pCancela;

end;

procedure TfrmEntPreNotaEntradaCx.cxgPedidosCONPAGCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strConPag: string;
begin
  inherited;
  strConPag := (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgPedidosCONPAG.Index]));

  If (strConPag <> objPreNota.recNotEle.strConPag) Then
  Begin
    strCondicaoPagamento := lblCondicaoPagamento.Caption;
    ACanvas.Brush.Color := clRed;

    If AViewInfo.Selected Then
      ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmEntPreNotaEntradaCx.cxgPedidosPRAMEDCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    fltPraNot: Double;
begin
  inherited;

  fltPraNot := fCalcMediaPagto(objPreNota.recNotEle.strConPag);

  If RoundTo(fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                      cxgPedidosPRAMED.Index])), -2) > RoundTo(fltPraNot, -2)  Then
  Begin
    strPrazoMedioMaior := lblPrazoMedioMaior.Caption;
    ACanvas.Brush.Color := clRed;

    If AViewInfo.Selected Then
      ACanvas.Font.Color := clBlue;
  End

  Else If RoundTo(fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                   cxgPedidosPRAMED.Index])), -2) < RoundTo(fltPraNot, -2)  Then
  Begin
    strPrazoMedioMenor := lblPrazoMedioMenor.Caption;
    ACanvas.Brush.Color := clYellow;

    If AViewInfo.Selected Then
      ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmEntPreNotaEntradaCx.cxgPedidosTRAPEDCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  var
    strCnpjTraPed: string;
begin
  inherited;
  //Quando o tipo frete for Destinatario (FOB) E CNPJ Transportadora diferente
  strCnpjTraPed := (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                      cxgPedidosTRAPED.Index]));

  If (objPreNota.recNotEle.strTipFre = '2') And (strCnpjTraPed <> objPreNota.recNotEle.strCnpjTr) Then
  Begin
    If LeftStr(strCnpjTraPed, 8) <> LeftStr(objPreNota.recNotEle.strCnpjTr, 8) Then
    Begin
      strCNPJTransportadoraDivergente := lblCNPJTransportadoraDivergente.Caption;
      ACanvas.Brush.Color := clRed
    End
    Else
    Begin
      strCNPJTransportadoraDivergenteBaseIgual := lblCNPJTransportadoraDivergenteBaseIgual.Caption;
      ACanvas.Brush.Color := clyellow;
    End;

    If AViewInfo.Selected Then
      ACanvas.Font.Color := clBlue;
  End;

end;

procedure TfrmEntPreNotaEntradaCx.cxgPedidosTRAPEDGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;
  Atext := fFormataCpfCgc(AText, FPais);
end;

procedure TfrmEntPreNotaEntradaCx.cxgPedidosViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If AViewInfo.Item.Index = cxgPedidosTIPFRE.Index Then
  begin
    If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  cxgPedidosTIPFRE.Index]) <>
        fDescricaoFrete(objPreNota.fTraduzFrete(objPreNota.recNotEle.strModFre))) Then
    begin
       ACanvas.Brush.Color := clRed;
    End;
  End;
end;

procedure TfrmEntPreNotaEntradaCx.cxvItensCODITE2HeaderClick(Sender: TObject);
begin
  inherited;
  If (cxvItensCODITE.DataBinding.FieldName <> 'ORD_CODITE') Then
    cxvItensCODITE.DataBinding.FieldName := 'ORD_CODITE';
  If cxvItensCODITE.SortOrder = soDescending Then
    cxvItensCODITE.SortOrder := soAscending
  Else
    cxvItensCODITE.SortOrder := soDescending;
end;

procedure TfrmEntPreNotaEntradaCx.cxvItensCODITEGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
var
  PosIni: integer;
  PosFim: integer;

  conteudo: String;

begin
  inherited;

  With objPreNota Do
  If Assigned(objPreNota) And (Not objPreNota.IsEmpty) Then
  Begin
    AText := VarToStr(Sender.DataBinding.DataController.Values[ARecord.RecordIndex, cxvItensCODITE.Index]) + '-' +
             VarToStr(Sender.DataBinding.DataController.Values[ARecord.RecordIndex, cxvItensDESITE.Index]);
    conteudo := '';
    PosIni := Pos('<',AText);
    PosFim := Pos('!>',AText);
    If PosFim > 0 Then
    Begin
      Inc(PosFim, 2);
      conteudo := Copy(AText, PosIni, (PosFim - PosIni));
    End;

    If conteudo <> '' Then
      AText := StringReplace(AText, conteudo,'', []);
  End


end;

procedure TfrmEntPreNotaEntradaCx.cxvItensIPIPEDCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    blnTemQtd,
    blnInconsistencia: Boolean;
begin
  inherited;

  If Not Assigned(objPreNota) Then
    Exit;

  blnTemQtd := (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensQTDPED.Index])) > 0) And
               (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensQTDNFE.Index])) > 0);

  blnInconsistencia := blnTemQtd And
                       (Abs(RoundTo(fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensIPIPED.Index])), -4) -
                            RoundTo(fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensIPINFE.Index])), -4)) > objPreNota.fltOciVlr);

  If blnInconsistencia Then
  Begin
    ACanvas.Brush.Color := clRed;
    ACanvas.Font.Color  := clWhite;
  End;

end;

procedure TfrmEntPreNotaEntradaCx.cxvItensNROITEHeaderClick(Sender: TObject);
begin
  inherited;
  If cxvItensCODITE.DataBinding.FieldName <> 'ORD_NROITE' Then
    cxvItensCODITE.DataBinding.FieldName := 'ORD_NROITE';
  If cxvItensCODITE.SortOrder = soDescending Then
    cxvItensCODITE.SortOrder := soAscending
  Else
    cxvItensCODITE.SortOrder := soDescending;
end;

procedure TfrmEntPreNotaEntradaCx.cxvItensNUMPEDCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    blnTemQtd,
    blnInconsistencia: Boolean;
begin
  inherited;

  If Not Assigned(objPreNota) Then
    Exit;

  If Not objPreNota.blnPedidosPreDefinidos Then
    Exit;

  blnTemQtd := (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensQTDPED.Index])) > 0) And
               (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensQTDNFE.Index])) > 0);

  blnInconsistencia := blnTemQtd And
                       (LeftStr(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensNUMPED.Index]), 12) <>
                        VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensPEDNFE.Index]));

  If blnInconsistencia Then
  Begin
    ACanvas.Brush.Color := clSkyBlue;
    ACanvas.Font.Color  := clBlack;
  End;

end;

procedure TfrmEntPreNotaEntradaCx.cxvItensUNIPEDCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    blnTemQtd,
    blnInconsistencia: Boolean;
begin
  inherited;

  If Not Assigned(objPreNota) Then
    Exit;

  blnTemQtd := (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensQTDPED.Index])) > 0) And
               (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensQTDNFE.Index])) > 0);

  blnInconsistencia := blnTemQtd And
                       (Abs(RoundTo(fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensUNIPED.Index])), -4) -
                            RoundTo(fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensUNINFE.Index])), -4)) > objPreNota.fltOciVlr);

  If blnInconsistencia Then
  Begin
    ACanvas.Brush.Color := clRed;
    ACanvas.Font.Color  := clWhite;
  End;

end;

procedure TfrmEntPreNotaEntradaCx.cxvItensSELPEDCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    blnInconsistencia: Boolean;
begin
  inherited;

  If Not Assigned(objPreNota) Then
    Exit;

  blnInconsistencia := fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensQTDRES.Index])) > objPreNota.fltOciQtd;

  If blnInconsistencia Then
  Begin
    ACanvas.Brush.Color := clYellow;
    ACanvas.Font.Color  := clBlack;
  End

  Else If fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensQTDNFE.Index])) = 0 Then
  Begin
    ACanvas.Brush.Color := clAqua;
    ACanvas.Font.Color  := clBlack;
  End;

end;

procedure TfrmEntPreNotaEntradaCx.cxvItensSUBPEDCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    blnTemQtd,
    blnInconsistencia: Boolean;
begin
  inherited;

  If Not Assigned(objPreNota) Then
    Exit;

  blnTemQtd := (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensQTDPED.Index])) > 0) And
               (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensQTDNFE.Index])) > 0);

  blnInconsistencia := blnTemQtd And
                       (Abs(RoundTo(fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensSUBPED.Index])), -4) -
                            RoundTo(fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensSUBNFE.Index])), -4)) > objPreNota.fltOciVlr);

  If blnInconsistencia Then
  Begin
    ACanvas.Brush.Color := clRed;
    ACanvas.Font.Color  := clWhite;
  End;

end;

procedure TfrmEntPreNotaEntradaCx.edtNumPedEnter(Sender: TObject);
begin
  inherited;

  If assigned(objPreNota) Then
  Begin
    If Not objPreNota.blnPedidosPreDefinidos Then
      objPreNota.pClose(False);
  End;

  edtNumPed.Clear;
end;

procedure TfrmEntPreNotaEntradaCx.edtNumPedKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fEntraCons(Key) And objPreNota.fSelecionaPedidos Then
  Begin
    edtNumPed.Clear;
    edtLisPed.Visible := True;
    edtLisPed.Text    := objPreNota.stlPedidos.CommaText;

    fValidaCampos(edtNumPed);
  End;

end;

procedure TfrmEntPreNotaEntradaCx.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If Assigned(objPreNota) Then
    objPreNota.pClose(True);

  objSalvaFiltros.fAtualizaDados;
  objSalvaFiltros.fSalvaDados('', 'frmEntPreNotaEntradaCx', strLoginUsuarioLogado, False, ['rdgTipUni','chkOcultarItens']);
  FreeAndNil(objSalvaFiltros);

  If Assigned(frmMensagemExplicativa)  then
    FreeAndNil(frmMensagemExplicativa);

end;

procedure TfrmEntPreNotaEntradaCx.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;

  If (Not blnSair) and (fEmptyStr(strAutoincrem))  Then
  Begin
    CanClose := False;
    btnSair.Click;
  End;

end;

procedure TfrmEntPreNotaEntradaCx.pHabilitaCotacao(blnHabilita: Boolean);
Begin
  lblCotDol.Enabled := blnHabilita;
  edtCotDol.Enabled := blnHabilita;

  If Not blnHabilita Then
    edtCotDol.Clear;
End;

procedure TfrmEntPreNotaEntradaCx.pImprimirEtiqueta(strIncGer: String);
begin

  TfrmEntEtiquetas.pImpEtiPreNota(strIncGer, True);

end;

procedure TfrmEntPreNotaEntradaCx.FormCreate(Sender: TObject);
begin
  inherited;
  blnImpEti := fCfgSis('IMPPNE', varBoolean);
  FPais   := fSetaPais;
  blnSair := False;
  strAutoincrem := '';

  lblCotDol.Visible  := fCfgSis('COTDOR', varBoolean);
  edtCotDol.Visible  := lblCotDol.Visible;
  edtCotDol.ReadOnly := True;
  edtCotDol.TabStop  := False;
  pHabilitaCotacao(False);

  objPreNota := TPreNota.Create(Self);
  objSalvaFiltros := TSalvaInterface.Create(Self);

  intDecimaisQuantidade := fCfgSis('DEQTEM', varInteger);

  TcxCurrencyEditProperties(cxvItensQTDNFE.Properties).DecimalPlaces := intDecimaisQuantidade;
  TcxCurrencyEditProperties(cxvItensUNIPED.Properties).DecimalPlaces := objPreNota.intDecUni;
  TcxCurrencyEditProperties(cxvItensUNINFE.Properties).DecimalPlaces := objPreNota.intDecUni;

  cxgPedidosView.DataController.DataSource := objPreNota.cdsPedidos.dtsSource;
  cxvItens.DataController.DataSource       := objPreNota.dtsSource;

  If fCfgSis('EXIAPL', varBoolean) Then
  Begin
    pnlAplicacao.Visible := True;
    mmoAplica.DataSource := objPreNota.dtsSource;
  End;

  TcxCurrencyEditProperties(cxvItensSELPED.Properties).DisplayFormat :=  '0.' + FormatFloat(StringOfChar('0', fCfgSis('DEQTPC')), 0) + ';-0.' + FormatFloat(StringOfChar('0', fCfgSis('DEQTPC')), 0);
  TcxCurrencyEditProperties(cxvItensQTDNFE.Properties).DisplayFormat :=  TcxCurrencyEditProperties(cxvItensSELPED.Properties).DisplayFormat;
  TcxCurrencyEditProperties(cxvItensRESPED.Properties).DisplayFormat :=  TcxCurrencyEditProperties(cxvItensSELPED.Properties).DisplayFormat;
end;

procedure TfrmEntPreNotaEntradaCx.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  Case Key Of
    VK_F8:  btnPedPre.Click;
    VK_F9:  btnCriticas.Click;
    VK_F10: Begin
              Key := 0;
              btnConfirma.Click;
            End;

    VK_ESCAPE: pCancela(True, True);

    Else   inherited;
  End;

end;

procedure TfrmEntPreNotaEntradaCx.FormShow(Sender: TObject);
begin
  inherited;

  If fCfgSis('CNVEMB') = 'N' Then
  Begin
    pnlCnvEmb.Visible        := False;
    pnlHeader.Height         := pnlHeader.Height - pnlCnvEmb.Height;

    pSetFocus(chkOcultarItens);
  End

  Else pSetFocus(TWinControl(rdgTipUni.Controls[0]));

  objSalvaFiltros.fCarregaDados('', Self, 'frmEntPreNotaEntradaCx', strLoginUsuarioLogado, True, True);
  objSalvaFiltros.fAtualizaDados;

  if not fEmptyStr(strAutoincrem) then
  begin
    If fCfgSis('CNVEMB') = 'N' Then
      pSetfocus(btnNotEle);
    if objPreNota.fCarregaNFE(strAutoincrem) then
    begin
      pCarregaNota();
      btnNotEle.Enabled := False;
      btnPedPre.Enabled := False;
    end;
  end;

end;

function TfrmEntPreNotaEntradaCx.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    Key: Char;
    blnMaisDeUm: Boolean;
    intTipUni: Integer;
 begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumPed) Then
    Begin

      If fEmptyStr(objPreNota.recNotEle.strAutInc) Then
      Begin
        fMensagem('ATENÇÃO!', 'Selecione a Nota Fiscal Eletrônica!', ['&O k']);
        blnMudarFoco  := False;
        pSetfocus(btnNotEle);
        Result := FALSE;
        Exit;
      End;

      blnMaisDeUm := False;
      intTipUni := rdgTipUni.ItemIndex;
      Result := objPreNota.fValidaPedido(edtNumPed.Text,
                                         pnlCnvEmb.Visible And (rdgTipUni.ItemIndex = 0),
                                         Not chkOcultarItens.Checked,
                                         True {blnTestarEmpDestino},
                                         blnMaisDeUm);

      If Not Result Then
      Begin
        blnMudarFoco  := False;
        edtNumPed.Clear;
        pSetfocus(btnNotEle);
        Result := False;
        Exit;
      End;

      rdgTipUni.ItemIndex := intTipUni;
      edtCotDol.Text := FormatFloat(fMskDigitos(4), objPreNota.fltCotMoe);

      pHabilitaCotacao(objPreNota.blnPedidosEmDolar);

      cxvItens.ViewData.Expand(True);
      cxvItens.NavigatorButtons.First.Click;

      If Result Then
      Begin

        If objPreNota.blnLimparLista Then
        Begin
          edtLisPed.Visible := False;
          edtLisPed.Clear;
        End;

        With objPreNota.cdsPedidos Do
        If IsEmpty Then
          pnlConPag.ClientHeight := pnlConGerEle.Height + 50
        Else
          pnlConPag.ClientHeight := pnlConGerEle.Height + 70;

        edtFrePed.Text := FormatFloat('#,##0.00',  objPreNota.fltFrePed);
        edtDifFre.Text := FormatFloat('#,##0.00', (objPreNota.fltFrePed - objPreNota.recNotEle.fltValFre));

        If (edtFrePed.Text <> edtFreNfe.Text) Then
        Begin
          edtFrePed.Color      := clRed;
          edtFrePed.Font.Color := clWhite;
          edtFreNfe.Color      := clRed;
          edtFreNfe.Font.Color := clWhite;
          edtDifFre.Color      := clRed;
          edtDifFre.Font.Color := clWhite;
        End;

        edtNumPed.Enabled := False;
        btnNotEle.Enabled := False;
        rdgTipUni.Enabled := False;
        chkOcultarItens.Enabled := False;
        pSetFocus(cxgItens);

      End Else
      Begin
        edtNumPed.Clear;
        edtLisPed.Clear;

        If blnMaisDeUm Then
        Begin
          Key := '?';
          edtNumPedKeyPress(Nil, Key);
          Exit;
        End;

      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
