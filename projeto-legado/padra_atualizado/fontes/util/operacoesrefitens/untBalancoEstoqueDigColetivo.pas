unit untBalancoEstoqueDigColetivo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Mask,
  DBCtrls, DBEditFocus, EditFocus, MaskEditFocus, untFuncoesSimples,
  untZClient, untCadLote, cxCurrencyEdit, untTypesSistema,
  cxGridBandedTableView, cxGridDBBandedTableView, BitBtnLockedIncrem,
  cxProgressBar,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmBalancoEstoqueDigColetivo = class(TfrmPaiEdit)
    pnlFiltro: TPanel;
    Label2: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    Label3: TLabel;
    edtDesIte: TEditFocus;
    Label4: TLabel;
    edtRefere: TEditFocus;
    Label5: TLabel;
    edtCodUni: TEditFocus;
    Label7: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    Label8: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    rdgAtivo: TRadioGroup;
    Label9: TLabel;
    edtCodAbr: TEditFocus;
    edtDesAbr: TEditFocus;
    Label10: TLabel;
    edtClaIPI: TEditFocus;
    Splitter1: TSplitter;
    dtsItens: TDataSource;
    Panel1: TPanel;
    pnlRodape: TPanel;
    Label6: TLabel;
    lblSal_ml: TLabel;
    Label1: TLabel;
    DBEditFocus3: TDBEditFocus;
    pnlItens: TPanel;
    lblDigita: TLabel;
    edtSenDig: TEditFocus;
    edtNomDig: TEditFocus;
    shpMultSel: TShape;
    btnSair2: TBitBtnLocked;
    lblLocFis: TLabel;
    edtLocFis: TEditFocus;
    lblLocFin: TLabel;
    edtLocFin: TEditFocus;
    edtSalAMl: TEditFocus;
    edtSalAtu: TEditFocus;
    pnlWms: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    edtRuaIni: TEditFocus;
    edtPredioIni: TEditFocus;
    edtAndarIni: TEditFocus;
    edtApartamentoIni: TEditFocus;
    edtCodLse: TEditFocus;
    edtDesLse: TEditFocus;
    edtRuaFin: TEditFocus;
    edtPredioFin: TEditFocus;
    edtAndarFin: TEditFocus;
    edtApartamentoFin: TEditFocus;
    btnCadCon: TBitBtnLocked;
    rdgSaldoItem: TRadioGroup;
    rdgSaldoLote: TRadioGroup;
    btnCarregar: TBitBtnLocked;
    lblPrdGru: TLabel;
    edtPrdGru: TEditFocus;
    edtDesPrdPro: TEditFocus;
    lblItemEstrutura: TLabel;
    Panel2: TPanel;
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBBandedTableView;
    cxgItensViewColumn1: TcxGridDBBandedColumn;
    cxgItensViewColumn2: TcxGridDBBandedColumn;
    cxgItensViewColumn3: TcxGridDBBandedColumn;
    cxgItensViewColumn7: TcxGridDBBandedColumn;
    cxgItensViewColumn4: TcxGridDBBandedColumn;
    cxgItensViewColumn5: TcxGridDBBandedColumn;
    cxgItensViewColumn6: TcxGridDBBandedColumn;
    cxgItensDIGCON: TcxGridDBBandedColumn;
    cxgItensDIG_ML: TcxGridDBBandedColumn;
    cxgItensQTDCHA: TcxGridDBBandedColumn;
    cxgItensLOT_CHAPA_: TcxGridDBBandedColumn;
    cxgItensSLDDIS: TcxGridDBBandedColumn;
    cxgItensLevel1: TcxGridLevel;
    pnlOperadorDaContagem: TPanel;
    Label11: TLabel;
    edtCodOpe: TEditFocus;
    edtDesOpe: TEditFocus;
    procedure edtCodAbrKeyPress(Sender: TObject; var Key: Char);
    procedure edtClaIPIKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruExit(Sender: TObject);
    procedure edtCodUniExit(Sender: TObject);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodAbrExit(Sender: TObject);
    procedure edtClaIPIExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgItensEnter(Sender: TObject);
    procedure btnSair2Click(Sender: TObject);
    procedure cxgItensViewEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure edtLocFisKeyPress(Sender: TObject; var Key: Char);
    procedure edtLocFinKeyPress(Sender: TObject; var Key: Char);
    procedure edtLocFisExit(Sender: TObject);
    procedure edtLocFinExit(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure edtCodLseExit(Sender: TObject);
    procedure edtCodLseKeyPress(Sender: TObject; var Key: Char);
    procedure btnCadConClick(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure cxgItensViewCanFocusRecord(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; var AAllow: Boolean);
    procedure edtPrdGruExit(Sender: TObject);
    procedure edtPrdGruKeyPress(Sender: TObject; var Key: Char);
    procedure cxgItensViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    blnAtualizaRodape,
    blnPerguntaInativo,
    blnConAcu,
    blnUsaQtdPendenteEntregaFutura,
    blnCadLoc,
    blnExiOpe: Boolean;

    intQtdAut: Integer;

    strAutIncCONDET,
    strAutIncLogEst,
    strAutIncHISBAL,
    strCodDig: String;

    arrClaIpi: TConsultasArray;
    arrAbrFis: TConsultasArray;
    arrLinGru: TConsultasArray;
    arrFornec: TConsultasArray;
    arrUnidad: TConsultasArray;
    arrMarca : TConsultasArray;
    arrCodLse: TConsultasArray;
    arrGrupoPro: TConsultasArray;

    arrLocFis,
    arrLocFin: TConsultasArray;

    intConEst: Integer;

    strLinGru,
    strFornec,
    strUnidad,
    strMarca,
    strAbrFis,
    strClaIpi,
    strPrdGru: String;

    cdsItens: TZClient;

    objCadLot: TCadLot;

    Function fSQLItens: String;
    Function fSalvaContagemManual(strCodIte: String;
                                  fltSalCon, fltSalMl: Double;
                                  intOrdCon: Integer; blnSavLog: Boolean): Boolean;

    Procedure pAbreConsulta;
    Procedure pAfterScroll(dataSet: TDataSet);
    Procedure pAfterPost(dataSet: TDataSet);
    Procedure pBeforPost(dataSet: TDataSet);
    procedure pLimpaCampos;
    Procedure pZeraContagemColetiva(strCodIte, strCodLot: String);
    procedure pSetaCampos;

    Function fAbreConsulta(cxProgresso: TcxProgressBar): Boolean;
    function fEhEstrutura(AStrCodIte: String): Boolean;


  public
    { Public declarations }

    strOperCfg : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmBalancoEstoqueDigColetivo: TfrmBalancoEstoqueDigColetivo;

implementation

uses untConsultas, untBalancoEstoqueDigManualLista, untGravando,
    untFuncoesConsulta,  untBalancoEstoqueAjuste, untCfgLocFis,
    untIFatEntregaFutura, untTFatEntregaFutura,
    untCadastraContagemEdicao;

{$R *.dfm}

procedure TfrmBalancoEstoqueDigColetivo.btnCarregarClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
    pAbreConsulta;

end;

procedure TfrmBalancoEstoqueDigColetivo.btnCadConClick(Sender: TObject);
begin
  inherited;

  If Not btnCadCon.Visible Then
    Exit;

  blnPerguntaInativo := False;
  blnAtualizaRodape  := False;

  Try
    pCriarFormularios(TfrmCadastraContagemEdicao, frmCadastraContagemEdicao);

    frmCadastraContagemEdicao.objContagem.cdsContagemExterna := cdsItens;

    If Not cdsItens.IsEmpty Then
      frmCadastraContagemEdicao.strLocFis := cdsItens.FieldByName('LOCFIS').AsString;

    frmCadastraContagemEdicao.ShowModal;

    pFreeAndNil(frmCadastraContagemEdicao);

    frmBalancoEstoqueDigManualLista.pAbreConsulta;
  Finally
    blnPerguntaInativo := True;
    blnAtualizaRodape  := True;
  End;

end;

procedure TfrmBalancoEstoqueDigColetivo.btnSair2Click(Sender: TObject);
begin
  inherited;

  Close;
end;

procedure TfrmBalancoEstoqueDigColetivo.cxgItensEnter(Sender: TObject);
begin
  inherited;

  cxgItensDIGCON.Focused := True
end;

procedure TfrmBalancoEstoqueDigColetivo.cxgItensViewCanFocusRecord(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
  inherited;
  If cxgItensQTDCHA.Visible Then
  begin
    cxgItensQTDCHA.Options.Editing := (VarToStr(Sender.DataController.Values[ARecord.RecordIndex, cxgItensLOT_CHAPA_.Index]) = 'S');
    cxgItensDIGCON.Options.Editing := Not cxgItensQTDCHA.Options.Editing;
  End;

end;

procedure TfrmBalancoEstoqueDigColetivo.cxgItensViewEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  inherited;

  If Key = '-' Then
    Key := #0;
end;

procedure TfrmBalancoEstoqueDigColetivo.cxgItensViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;
  If Assigned(AFocusedRecord) Then
    lblItemEstrutura.Visible := fEhEstrutura(VarToStr(Sender.DataController.Values[AFocusedRecord.RecordIndex, cxgItensViewColumn1.Index]));
end;

procedure TfrmBalancoEstoqueDigColetivo.edtClaIPIExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtClaIpi, Nil, arrClaIpi, Nil, nil, 'da Classficação de IPI');
end;

procedure TfrmBalancoEstoqueDigColetivo.edtClaIPIKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqClaIPI(Self, edtClaIPI, nil, Key, arrClaIpi, False) Then
  Begin
    If fValidaCampos(edtClaIPI, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBalancoEstoqueDigColetivo.edtCodAbrExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodAbr,edtDesAbr,arrAbrFis,fRetDesAbfIcm,nil,'da Abreviação Fiscal');
end;

procedure TfrmBalancoEstoqueDigColetivo.edtCodAbrKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqAbrevFiscal(Self, edtCodAbr, edtDesAbr, Nil, Key, arrAbrFis, False) Then
  Begin
    If fValidaCampos(edtCodAbr, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBalancoEstoqueDigColetivo.edtCodForExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodFor,edtNomFor,arrFornec,fRetNomFornecedor,nil,'do Fornecedor');

end;

procedure TfrmBalancoEstoqueDigColetivo.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqFornecedor(conForSimples,
                     Self,
                     edtCodFor,
                     edtNomFor,
                     Nil,
                     Key,
                     arrFornec,
                     False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
  
end;

procedure TfrmBalancoEstoqueDigColetivo.edtCodLseExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodLse, edtDesLse, arrCodLse, nil, fRetLocSep, 'do local de separação');
end;

procedure TfrmBalancoEstoqueDigColetivo.edtCodLseKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqLocSep(Self, edtCodLse, edtDesLse, nil, key, arrCodLse, False) Then
  Begin
    If fValidaCampos(edtCodLSe, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBalancoEstoqueDigColetivo.edtCodMarExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodMar,edtDesMar,arrMarca,fRetNomMarca,nil,'da Marca');
  
end;

procedure TfrmBalancoEstoqueDigColetivo.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqMarcas(Self,
                 edtCodMar,
                 edtDesMar,
                 Nil,
                 Key,
                 arrMarca,
                 False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBalancoEstoqueDigColetivo.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCodOpe: TConsultasArray;
begin
  inherited;

  If fPesqOperador(Self,
                   edtCodOpe,
                   edtDesOpe,
                   Nil,
                   Key,
                   arrCodOpe ) Then
  Begin
    strOperCfg := edtCodOpe.text;
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBalancoEstoqueDigColetivo.edtCodUniExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodUni,Nil,arrUnidad,fRetNomUnidade,nil,'da Unidade');
end;

procedure TfrmBalancoEstoqueDigColetivo.edtCodUniKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqUnidade(Self,
                  edtCodUni,
                  Nil,
                  Nil,
                  Nil,
                  Key,
                  arrUnidad,
                  False) Then
  Begin
    if fvalidaCampos(edtCodUni,False) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBalancoEstoqueDigColetivo.edtLocFinExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtLocFin, Nil, arrLocFin, Nil, Nil, 'da Localização Física Final');
end;

procedure TfrmBalancoEstoqueDigColetivo.edtLocFinKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, edtLocFin, Nil, Nil, Key, arrLocFin) And
     fValidaCampos(edtLocFin, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmBalancoEstoqueDigColetivo.edtLocFisExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtLocFis, Nil, arrLocFis, Nil, Nil, 'da Localização Física Inicial');
end;

procedure TfrmBalancoEstoqueDigColetivo.edtLocFisKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, edtLocFis, Nil, Nil, Key, arrLocFis) And
     fValidaCampos(edtLocFis, True) Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmBalancoEstoqueDigColetivo.edtPrdGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtPrdGru, edtDesPrdPro, arrGrupoPro, fRetNomeGrupoProduto, nil, 'do Grupo de Produtos', edtPrdGru.MaxLength);
end;

procedure TfrmBalancoEstoqueDigColetivo.edtPrdGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoProduto(Self, edtPrdGru, edtDesPrdPro, Nil, Key, arrGrupoPro, False) Then
  Begin
    If fValidaCampos(edtPrdGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBalancoEstoqueDigColetivo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  pFreeAndNil(frmBalancoEstoqueDigManualLista);
  
end;

procedure TfrmBalancoEstoqueDigColetivo.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodLse(edtCodLse);
  edtCodAbr.MaxLength :=  IIf(fCfgSis('USASAN') = 'S', 7, 3);
  blnPerguntaInativo := True;
  blnAtualizaRodape  := True;

  blnFecharComEscape := False;

  blnConAcu := fCfgSis('CONACU', varBoolean);

  blnUsaQtdPendenteEntregaFutura := fUsaQtdPendenteEntregaFutura;

  strOperCfg      := strLoginUsuarioLogado;
  blnExiOpe := fCfgSis('EXIOPE', varBoolean);
  pnlOperadorDaContagem.Visible := blnExiOpe;
  If blnExiOpe Then
  Begin
    edtCodOpe.text  := strLoginUsuarioLogado;
    edtDesOpe.Text  := fRetNomVendRep(strLoginUsuarioLogado);
  End;

  cdsItens := TZClient.Create(Self);

  cxgItensView.DataController.DataSource := cdsItens.dtsSource;
  dtsItens.DataSet := cdsItens;

  objCadLot := TCadLot.Create(Self);

  If (fCfgSis('MARMOR', VarBoolean)) And (fCfgSis('CTRLCH') = '2') Then
     cxgItensQTDCHA.Visible := True;

  pCriarFormularios(TfrmBalancoEstoqueDigManualLista, frmBalancoEstoqueDigManualLista);
  frmBalancoEstoqueDigManualLista.pZeraContagemColetiva := pZeraContagemColetiva;
  frmBalancoEstoqueDigManualLista.blnFecharComEscape := False;
  frmBalancoEstoqueDigManualLista.objCadLot := objCadLot;
  frmBalancoEstoqueDigManualLista.Dock(pnlItens, pnlItens.BoundsRect);
  frmBalancoEstoqueDigManualLista.Show;

  btnCadCon.Visible := fUsaRotinaWMS;
end;

procedure TfrmBalancoEstoqueDigColetivo.pLimpaCampos;
Begin
  mskLinGru.Clear;
  edtDesGru.Clear;
  edtDesIte.Clear;
  edtRefere.Clear;
  edtCodUni.Clear;
  edtCodMar.Clear;
  edtDesMar.Clear;
  edtCodFor.Clear;
  edtNomFor.Clear;
  edtCodAbr.Clear;
  edtDesAbr.Clear;
  edtClaIPI.Clear;
  edtCodOpe.Clear;
  edtDesOpe.Clear;

  rdgAtivo.ItemIndex := 0;

  cdsItens.Close;
End;

procedure TfrmBalancoEstoqueDigColetivo.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_ESCAPE : If Not edtSenDig.Focused Then
                Begin
                  pSetFocus(edtSenDig);
                  pLimpaCampos;
                  Abort;
                  Exit;
                End

                Else Close;
  End;

  inherited;

  Case Key Of
    VK_F9: btnCadCon.Click;

    VK_RETURN: If fCheckParent(ActiveControl, cxgItens) And
                  (cdsItens.State = dsEdit) then
               Begin

                 If cxgItensDIG_ML.Focused Then
                 Begin
                   cxgItensView.NavigatorButtons.Next.Click;
                   cxgItensDIGCON.Focused := True;
                 End

                 Else If cxgItensDIGCON.Focused Then
                 Begin

                   If (cdsItens.FieldByName('CNV_ML').AsFloat > 0) And
                      fEmptyStr(cdsItens.FieldByName('NUMLOT').AsString) Then
                     cxgItensDIG_ML.Focused := True
                   Else
                   Begin
                     cxgItensView.NavigatorButtons.Next.Click;
                     cxgItensDIGCON.Focused := True
                   End;

                 End;

               End;
  End;

end;

procedure TfrmBalancoEstoqueDigColetivo.FormResize(Sender: TObject);
begin
  inherited;
  cxgItensView.Bands[0].Width := Trunc(Self.Width / 2)+25;
  If frmBalancoEstoqueDigManualLista <> nil then
    frmBalancoEstoqueDigManualLista.dbgconsulta.Columns[1].Width  := Trunc(Self.Width / 4)-50;
end;

procedure TfrmBalancoEstoqueDigColetivo.FormShow(Sender: TObject);
  Var
    strCodAmz: String;
    intNumAmz: Integer;
begin
  inherited;

  blnPassarRadioButtonComEnter := False;

  intConEst     := fCfgSis('CONEST');
  blnCadLoc     := fCfgSis('CADLOC', varBoolean);

  cxgItensView.Bands[1].Visible := (intConEst = 1) And fCfgSis('CONACU', varBoolean);

  pSetFocus(edtSenDig);

  If (fCfgSis('CTLEST') = '2') And TCadLot.fTemContagemArmazem(strCodAmz, intNumAmz) Then
    If intNumAmz > 1 Then
      Caption := Caption + ' - Armazéns ' + strCodAmz
    Else
      Caption := Caption + ' - Armazém ' + strCodAmz + '-' + fRetNomeArmazem(strCodAmz);


  lblLocFis.Visible := not fUsaRotinaWMS();
  edtLocFis.Visible := not fUsaRotinaWMS();
  lblLocFin.Visible := not fUsaRotinaWMS();
  edtLocFin.Visible := not fUsaRotinaWMS();
  pnlWms.Visible    := fUsaRotinaWMS();
  If (fUsaRotinaWMS()) Then
  Begin
    pnlFiltro.Height := pnlFiltro.Height - edtLocFis.Height - 1;
    pSetaCampos;
  End
  Else
    pnlFiltro.Height := pnlFiltro.Height - pnlWms.Height + 1;
end;

procedure TfrmBalancoEstoqueDigColetivo.mskLinGruExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(mskLinGru, edtDesGru, arrLinGru, fRetNomeLinhaGrupo, Nil, 'da linha/grupo',6);
end;

procedure TfrmBalancoEstoqueDigColetivo.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self,
                mskLinGru,
                edtDesGru,
                Nil,
                Key,
                arrLinGru,
                False) Then
  Begin
    If fValidaCampos(mskLinGru, True) then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmBalancoEstoqueDigColetivo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result    := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtSenDig) Then
    Begin

      If fEmptyStr(edtSenDig.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O digitador deve ser preenchido!', ['&O k']);
        Result := False;
      End Else
      Begin
        edtNomDig.Text := fRetNomVendRep(fRetCodVendedor(edtSenDig.Text));

        If fEmptyStr(edtNomDig.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Senha inválida!', ['&O k']);
          Result := False;
        End

        Else strCodDig := fRetCodVendedor(edtSenDig.Text);

      End;
    End

    Else If (Sender = edtCodOpe) Then
    begin
      If Not fEmptyStr(edtCodOpe.Text) Then
      begin
        edtDesOpe.Text := fRetNomVendRep(edtCodOpe.Text);
        If fEmptyStr(edtDesOpe.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Operador não encotrando!', ['&O k']);
          Result := False;
        End
        Else
          strOperCfg := edtCodOpe.Text;
      end;
    End

    Else If (Sender = mskLinGru) Then
    Begin
      pDesmarcaLista(mskLinGru, arrLinGru, '', 6)
    End

    Else If (Sender = edtDesIte) Then
    Begin

    End

    Else If (Sender = edtRefere) Then
    Begin

    End

    Else If (Sender = edtCodUni) Then
    Begin
      pDesmarcaLista(edtCodUni, arrUnidad);
    End

    Else If (Sender = edtCodMar) Then
    Begin
      pDesmarcaLista(edtCodMar, arrMarca);
    End

    Else If (Sender = edtPrdGru) Then
    Begin
      pDesmarcaLista(edtPrdGru, arrGrupoPro);
    End

    Else If (Sender = edtCodFor) Then
    Begin
      pDesmarcaLista(edtCodFor, arrFornec);
    End

    Else If (Sender = edtCodAbr) Then
    Begin
      pDesmarcaLista(edtCodAbr, arrAbrFis);
    End

    Else If (Sender = edtClaIPI) Then
    Begin
      pDesmarcaLista(edtClaIPI, arrClaIPI);
    End

    Else If (Sender = edtLocFis) Then
    Begin

      edtLocFin.Enabled := Not fEmptyStr(edtLocFis.Text);
      If Not edtLocFin.Enabled Then
        edtLocFin.Clear;

    End

    Else
    If (Sender = edtCodLse) Then
    Begin
      pDesmarcaLista(edtCodLse, arrCodLse);
    End

    Else
    If (Sender = edtRuaIni) Then
    Begin
      edtRuaFin.Enabled := not fEmptyStr(edtRuaIni.Text);
      If Not edtRuaFin.Enabled Then
        edtRuaFin.Clear;
    End

    Else
    If (Sender = edtPredioIni) Then
    Begin
      edtPredioFin.Enabled := not fEmptyStr(edtPredioIni.Text);
      If Not edtPredioFin.Enabled Then
        edtPredioFin.Clear;
    End

    Else
    If (Sender = edtAndarIni) Then
    Begin
      edtAndarFin.Enabled := not fEmptyStr(edtAndarIni.Text);
      If Not edtAndarFin.Enabled Then
        edtAndarFin.Clear;
    End

    Else
    If (Sender = edtApartamentoIni) Then
    Begin
      edtApartamentoFin.Enabled := not fEmptyStr(edtApartamentoIni.Text);
      If Not edtApartamentoFin.Enabled Then
        edtApartamentoFin.Clear;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

Procedure TfrmBalancoEstoqueDigColetivo.pAfterScroll(dataSet: TDataSet);
Begin
  If DataSet.ControlsDisabled Then
    Exit;

  lblSal_ml.Visible              := (DataSet.FieldByName('CNV_ML').AsFloat > 0);
  edtSalAMl.Visible              := lblSal_ml.Visible;
  cxgItensDIG_ML.Options.Editing := lblSal_ml.Visible;

  If blnUsaQtdPendenteEntregaFutura Then
  Begin
    edtSalAtu.Text := FormatFloat(fMskDigitos(3), cdsItens.FieldByName('SALDOS').AsFloat  +
                                                TEntregaFutura.New(
                                                  TParamEF.New()
                                                    .CodIte(cdsItens.FieldByName('CODITE').AsString)
                                                    .CodEmp(VS_strCodEmp)
                                                    .Lote(cdsItens.FieldByName('NUMLOT').AsString)
                                                    .TipoTE(tteTodas)
                                                  ).Total());
    edtSalAMl.Text := FormatFloat(fMskDigitos(3), cdsItens.FieldByName('SAL_ML').AsFloat  +
                                               TEntregaFutura.New(
                                                  TParamEF.New()
                                                    .CodIte(cdsItens.FieldByName('CODITE').AsString)
                                                    .CodEmp(VS_strCodEmp)
                                                    .Lote(cdsItens.FieldByName('NUMLOT').AsString)
                                                    .TipoTE(tteTodas)
                                                    .ConverteML(True)
                                                  ).Total());
  End
  Else
  Begin
    edtSalAtu.Text := FormatFloat(fMskDigitos(3), cdsItens.FieldByName('SALDOS').AsFloat );
    edtSalAMl.Text := FormatFloat(fMskDigitos(3), cdsItens.FieldByName('SAL_ML').AsFloat);
  End;

End;

Procedure TfrmBalancoEstoqueDigColetivo.pAbreConsulta;
  Var
    frmGravando: TfrmGravando;
Begin
  TfrmGravando.fExecuta(fAbreConsulta, frmGravando, 'Carregando produtos, aguarde...');
End;

Function TfrmBalancoEstoqueDigColetivo.fAbreConsulta(cxProgresso: TcxProgressBar): Boolean;
  Var
    strCodLse : String;
Begin
  cdsItens.AfterScroll := Nil;
  cdsItens.BeforePost  := Nil;
  cdsItens.AfterPost   := Nil;

  With cdsItens, qryQuery Do
  Begin
    SQL.Text := fSQLItens;

    If Not fEmptyStr(edtDesIte.Text) Then
      ParamByName('DESITE').AsString := edtDesIte.Text + '%';

    If Not fEmptyStr(edtRefere.Text) Then
      ParamByName('REFERE').AsString := edtRefere.Text + '%';

    ParamByName('CODEMP').AsString := VS_strCodEmp;

    pSetaParam(mskLinGru.Text, arrLinGru,   strLinGru, 'CODGRU', qryQuery);
    pSetaParam(edtCodMar.Text, arrMarca,    strMarca,  'CODMAR', qryQuery);
    pSetaParam(edtCodFor.Text, arrFornec,   strFornec, 'CODFOR', qryQuery);
    pSetaParam(edtCodUni.Text, arrUnidad,   strUnidad, 'CODUNI', qryQuery);
    pSetaParam(edtCodAbr.Text, arrAbrFis,   strAbrFis, 'CODABF', qryQuery);
    pSetaParam(edtPrdGru.Text, arrGrupoPro, strPrdGru, 'PRDGRU', qryQuery);

    If Length(arrClaIPI) > 0 Then
      pSetaParam(edtClaIPI.Text, arrClaIpi, strClaIpi, 'CLAIPI', qryQuery)

    Else If Not fEmptyStr(edtClaIPI.Text) Then
      ParamByName('CLAIPI').AsString := edtClaIPI.Text + '%';

    If fUsaRotinaWMS Then
    Begin
      pSetaParam(edtCodLse.Text, arrCodLse, strCodLse, 'CODLSE', cdsItens.qryQuery);

      If FindParam('RUAINI') <> Nil Then
        ParamByName('RUAINI').AsString := edtRuaIni.Text;

      If FindParam('RUAFIN') <> Nil Then
        ParamByName('RUAFIN').AsString := edtRuaFin.Text;

      If FindParam('PREINI') <> Nil Then
        ParamByName('PREINI').AsString := edtPredioIni.Text;

      If FindParam('PREFIN') <> Nil Then
        ParamByName('PREFIN').AsString := edtPredioFin.Text;

      If FindParam('ANDINI') <> Nil Then
        ParamByName('ANDINI').AsString := edtAndarIni.Text;

      If FindParam('ANDFIN') <> Nil Then
        ParamByName('ANDFIN').AsString := edtAndarFin.Text;

      If FindParam('APTINI') <> Nil Then
        ParamByName('APTINI').AsString := edtApartamentoIni.Text;

      If FindParam('APTFIN') <> Nil Then
        ParamByName('APTFIN').AsString := edtApartamentoFin.Text;

    End
    Else
    Begin
      If Not fEmptyStr(edtLocFis.Text) Then
      Begin

        If (Not fEmptyStr(edtLocFin.Text)) Then
        Begin
          ParamByName('LOCFIS').AsString := edtLocFis.Text;
          ParamByName('LOCFIN').AsString := edtLocFin.Text;

          If Length(edtLocFis.Text) > Length(edtLocFin.Text) Then
            ParamByName('MALOC').AsString := edtLocFis.Text
          Else
            ParamByName('MALOC').AsString := edtLocFin.Text;
        End
        Else
          ParamByName('LOCFIS').AsString := edtLocFis.Text + '%';

      End;
    End;

    Result := fAbreClient(True, 'TfrmBalancoEstoqueDigColetivo.pAbreConsulta');

    pFormataDecimal('SALDOS', 3);
    pFormataDecimal('SAL_ML', 3);
    pFormataDecimal('SALCON', 3);
    pFormataDecimal('GMLCON', 3);
    pFormataDecimal('DIGCON', 3);
    pFormataDecimal('DIG_ML', 3);
    pFormataDecimal('SALRES', 3);
  End;

  cdsItens.AfterScroll := pAfterScroll;
  cdsItens.BeforePost  := pBeforPost;
  cdsItens.AfterPost   := pAfterPost;

  strAutIncLogEst := fRetAutoIncrem('LOGEST', VS_strCodEmp, cdsItens.RecordCount);
  strAutIncCONDET := fRetAutoIncrem('CONDET', VS_strCodEmp, cdsItens.RecordCount);
  strAutIncHISBAL := fRetAutoIncrem('HISBAL', VS_strCodEmp, cdsItens.RecordCount);

  intQtdAut := cdsItens.RecordCount;

  pAfterScroll(cdsItens);
End;

Function TfrmBalancoEstoqueDigColetivo.fSQLItens: String;
  Var
    strArmazens,

    strSQL: String;
Begin
  strArmazens := TCadLot.fRetLotesContagemAberta;

  strSQL := ' /* untBalancoEstoqueDigColetivo.fSQLItens */';

  strSQL := strSQL + fSQLCamposDigColetivo;

  strSQL := strSQL + ' WHERE TRUE ';

  Case rdgAtivo.ItemIndex Of
    0: strSQL := strSQL + ' AND IFNULL(ITE_ITEATI, "N") = "S" ';
    1: strSQL := strSQL + ' AND IFNULL(ITE_ITEATI, "N") = "N" ';
  End;

  Case rdgSaldoItem.ItemIndex Of
    0: strSQL := strSQL + ' AND ITE_SALDOS > 0 ';
    1: strSQL := strSQL + ' AND ITE_SALDOS < 0 ';
    2: strSQL := strSQL + ' AND ITE_SALDOS = 0 ';
  End;

  Case rdgSaldoLote.ItemIndex Of
    0: strSQL := strSQL + ' AND ((LOT_NUMLOT IS NULL) OR (LOT_SALDOS > 0)) ';
    1: strSQL := strSQL + ' AND ((LOT_NUMLOT IS NULL) OR (LOT_SALDOS < 0)) ';
    2: strSQL := strSQL + ' AND ((LOT_NUMLOT IS NULL) OR (LOT_SALDOS = 0)) ';
  End;

  If Not fEmptyStr(edtDesIte.Text) Then
    strSQL := strSQL + ' AND ITE_DESITE LIKE :DESITE ';

  If Not fEmptyStr(edtRefere.Text) Then
    strSQL := strSQL + ' AND ITE_REFERE LIKE :REFERE ';

  If Not fEmptyStr(strArmazens) Then
    strSQL := strSQL + ' AND ((LOT_CODITE IS NULL) OR (LOT_NUMLOT IN (' + strArmazens + '))) ';

  strSQL := strSQL + fStrLocateLinGru(mskLinGru, arrLinGru, 'ITE_CODGRU', 'CODGRU');
  strSQL := strSQL + fStrLocate(edtCodMar, arrMarca,    'ITE_CODMAR', 'CODMAR');
  strSQL := strSQL + fStrLocate(edtCodFor, arrFornec,   'ITE_CODFOR', 'CODFOR');
  strSQL := strSQL + fStrLocate(edtCodUni, arrUnidad,   'ITE_CODUNI', 'CODUNI');
  strSQL := strSQL + fStrLocate(edtPrdGru, arrGrupoPro, 'ITE_PRDGRU', 'PRDGRU');

  If fCfgSIs('TIPABF') = '1' Then
    strSQL := strSQL + fStrLocate(edtCodAbr, arrAbrFis, 'C.ITE_CODABF', 'CODABF')
  Else
    strSQL := strSQL + fStrLocate(edtCodAbr, arrAbrFis, 'I.ITE_CODABF', 'CODABF');

  If Length(arrClaIPI) > 0 Then
    strSQL := strSQL + fStrLocate(edtClaIPI, arrClaIPI, 'C.ITE_CLAIPI', 'CLAIPI')

  Else If Not fEmptyStr(edtClaIPI.Text) Then
    strSQL := strSQL + ' AND ITE_CLAIPI LIKE :CLAIPI ';

  If fUsaRotinaWMS Then
  Begin
    strSQL := strSQL + fStrLocate(edtCodLse, arrCodLse, 'LOC_CODLSE', 'CODLSE');

    If not fEmptyStr(edtRuaIni.Text) Then
    Begin
      If not fEmptyStr(edtRuaFin.Text) Then
      Begin
        strSQL := strSQL + ' AND LOC_R_U_A_ BETWEEN :RUAINI AND :RUAFIN '
      End
      Else
        strSQL := strSQL + ' AND LOC_R_U_A_ = :RUAINI ';
    End;

    If not fEmptyStr(edtPredioIni.Text) Then
    Begin
      If not fEmptyStr(edtPredioFin.Text) Then
      Begin
        strSQL := strSQL + ' AND LOC_PREDIO BETWEEN :PREINI AND :PREFIN '
      End
      Else
        strSQL := strSQL + ' AND LOC_PREDIO = :PREINI ';
    End;

    If not fEmptyStr(edtAndarIni.Text) Then
    Begin
      If not fEmptyStr(edtAndarFin.Text) Then
      Begin
        strSQL := strSQL + ' AND LOC_ANDAR_ BETWEEN :ANDINI AND :ANDFIN '
      End
      Else
        strSQL := strSQL + ' AND LOC_ANDAR_ = :ANDINI ';
    End;

    If not fEmptyStr(edtApartamentoIni.Text) Then
    Begin
      If not fEmptyStr(edtApartamentoFin.Text) Then
      Begin
        strSQL := strSQL + ' AND LOC_APARTA BETWEEN :APTINI AND :APTFIN '
      End
      Else
        strSQL := strSQL + ' AND LOC_APARTA = :APTINI ';
    End;

  End
  Else
  Begin
    If Not fEmptyStr(edtLocFis.Text) Then
    Begin
      If (Not fEmptyStr(edtLocFin.Text)) Then
        strSQL := strSQL + '  AND LEFT(IF(LOT_NUMLOT IS NULL, ITE_LOCFIS, LOT_LOCFIS), LENGTH(:MALOC)) BETWEEN :LOCFIS AND :LOCFIN '
      Else
        strSQL := strSQL + '  AND IF(LOT_NUMLOT IS NULL, ITE_LOCFIS, LOT_LOCFIS) LIKE :LOCFIS ';
    End;
  End;

  strSQL := strSQL + ' AND (LOT_CODITE IS NULL OR LOT_STATUS = "S") ';
  strSQL := strSQL + ' AND ((LOT_NUMLOT IS NULL) OR (LOT_NUMLOT <> "A DEFINIR")) ';

  strSQL := strSQL + ' ORDER BY ';

  strSQL := strSQL + '   DESITE ';

  Result := strSQL;
End;

Procedure TfrmBalancoEstoqueDigColetivo.pBeforPost(dataSet: TDataSet);
Begin
  Try
    With DataSet Do
    Begin

      If blnPerguntaInativo And
         ((FieldByName('ITEATI').AsString = 'N') And
         (fMensagem('', 'Esse item está inativo, deseja ativá-lo?', ['&Sim', '&Não']) = 2)) Then
      Begin
        Cancel;
        Abort;
        Exit;
      End;


      If FieldByName('LOT_QTDCHA').AsInteger > 0 then
        DataSet.FieldByName('DIGCON').AsFloat  := FieldByName('LOT_QTDCHA').AsInteger
                                          * DataSet.FieldByName('LOT_MEDL_A').AsFloat
                                          * DataSet.FieldByName('LOT_MEDL_L').AsFloat;
      FieldByName('AUX_ML').AsFloat := FieldByName('DIG_ML').AsFloat;
      FieldByName('GMLCON').AsFloat := FieldByName('GMLCON').AsFloat +
                                       FieldByName('DIG_ML').AsFloat;
      If blnConAcu Then
        FieldByName('DIG_ML').Clear;


      FieldByName('AUXCON').AsFloat := FieldByName('DIGCON').AsFloat;
      FieldByName('SALCON').AsFloat := FieldByName('SALCON').AsFloat +
                                         FieldByName('DIGCON').AsFloat;
      If blnConAcu Then
      FieldByName('DIGCON').Clear;
      FieldByName('LOT_QTDCHA').Clear;

    End;

    inherited;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmBalancoEstoqueDigColetivo.pBeforPost]');
    End;
  End;
End;

Function TfrmBalancoEstoqueDigColetivo.fSalvaContagemManual(strCodIte: String;
  fltSalCon, fltSalMl: Double; intOrdCon: Integer; blnSavLog: Boolean): Boolean;
begin

  Result := fSalvaContagem(strCodIte, fltSalCon, fltSalMl, intOrdCon, blnSavLog, False, blnConAcu,
                           intConEst, strCodDig, '', Self, '', '', strOperCfg);

  frmBalancoEstoqueDigManualLista.pAtualiza(strCodIte, '', blnAtualizaRodape);
end;

Procedure TfrmBalancoEstoqueDigColetivo.pAfterPost(dataSet: TDataSet);
Begin
  Try

  With DataSet Do
  Begin

    If fEmptyStr(FieldByName('NUMLOT').AsString) Then
    Begin
      fSalvaContagemManual(FieldByName('CODITE').AsString,
                           FieldByName('AUXCON').AsFloat,
                           FieldByName('AUX_ML').AsFloat,
                           objCadLot.fRetOrdemItem,
                           True);
    End Else
    Begin

      If intQtdAut = 0 Then
      Begin
        If cdsItens.RecordCount < 20 Then
        Begin
          strAutIncLogEst := fRetAutoIncrem('LOGEST', VS_strCodEmp, cdsItens.RecordCount);
          strAutIncCONDET := fRetAutoIncrem('CONDET', VS_strCodEmp, cdsItens.RecordCount);
          strAutIncHISBAL := fRetAutoIncrem('HISBAL', VS_strCodEmp, cdsItens.RecordCount);


          intQtdAut := cdsItens.RecordCount;
        End Else
        Begin
          strAutIncLogEst := fRetAutoIncrem('LOGEST', VS_strCodEmp, 20);
          strAutIncCONDET := fRetAutoIncrem('CONDET', VS_strCodEmp, 20);
          strAutIncHISBAL := fRetAutoIncrem('HISBAL', VS_strCodEmp, 20);

          intQtdAut := 20;
        End;
      End;

      If objCadLot.fSalvaContagemLote(FieldByName('AUTLOT').AsString,
                                      FieldByName('CODITE').AsString,
                                      FieldByName('NUMLOT').AsString,
                                      strCodDig,
                                      strAutIncHISBAL,
                                      FieldByName('AUXCON').AsFloat,
                                      FieldByName('AUX_ML').AsFloat,
                                      objCadLot.fRetOrdemItem,
                                      strAutIncCONDET,
                                      strOperCfg) Then
      Begin
        frmBalancoEstoqueDigManualLista.pAtualiza(FieldByName('CODITE').AsString,
                                                  FieldByName('AUTLOT').AsString,
                                                  blnAtualizaRodape);

        fGravaLogContEst(strCodDig,
                         FieldByName('CODITE').AsString,
                         FieldByName('NUMLOT').AsString,
                         FieldByName('AUXCON').AsFloat, 0,
                         strAutIncLogEst);

        strAutIncLogEst := fNextAutoIncrem(strAutIncLogEst);
        strAutIncCONDET := fNextAutoIncrem(strAutIncCONDET);
        strAutIncHISBAL := fNextAutoIncrem(strAutIncHISBAL);

        Dec(intQtdAut);
      End;

    End;

  End;

  pSetFocus(cxgItens);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmBalancoEstoqueDigColetivo.pAfterPost]');
    End;
  End;
End;

Procedure TfrmBalancoEstoqueDigColetivo.pZeraContagemColetiva(strCodIte, strCodLot: String);
  Var
    strIteAnt,
    strLotAnt: String;
Begin

  With cdsItens Do
  Try
    If IsEmpty Then
      Exit;

    DisableControls;
    AfterPost  := Nil;
    BeforePost := Nil;

    strIteAnt := FieldByName('CODITE').AsString;
    strLotAnt := FieldByName('NUMLOT').AsString;

    Filter   := 'CODITE = ' + QuotedStr(strCodIte);
    Filtered := True;
    First;

    While Not Eof Do
    Begin
      Edit;
      FieldByName('DIGCON').Clear;
      FieldByName('DIG_ML').Clear;

      FieldByName('AUXCON').AsFloat := 0;
      FieldByName('AUX_ML').AsFloat := 0;

      FieldByName('SALCON').Clear;
      FieldByName('GMLCON').Clear;
      Post;

      Next;
    End;

    AfterPost  := pAfterPost;
    BeforePost := pBeforPost;

    Locate('CODITE;NUMLOT', VarArrayOf([strIteAnt, strLotAnt]), []);

    EnableControls;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmBalancoEstoqueDigColetivo.pZeraContagemColetiva]');
    End;
  End;

  With cdsItens Do
  Begin
    AfterPost  := pAfterPost;
    BeforePost := pBeforPost;
    Filter := '';
    Filtered := False;
    EnableControls;
  End;

End;

procedure TfrmBalancoEstoqueDigColetivo.pSetaCampos;
  Var
    objCampo     : TCfgLocFis;
    objCfgLocFis : TCamposCfgLocFis;
Begin
  objCfgLocFis := TCamposCfgLocFis.Create;
  Try

    For objCampo in objCfgLocFis Do
    Begin

      If objCampo.strNomCam = 'LOC_CODLSE' Then
        Continue;

      With objCampo Do
      Begin
        If strNomCam = 'LOC_R_U_A_' Then
        Begin
          pSetaConfiguracoes(edtRuaIni);
          pSetaConfiguracoes(edtRuaFin);
        End

        Else
        If strNomCam = 'LOC_PREDIO' Then
        Begin
          pSetaConfiguracoes(edtPredioIni);
          pSetaConfiguracoes(edtPredioFin);
        End

        Else
        If strNomCam = 'LOC_ANDAR_' Then
        Begin
          pSetaConfiguracoes(edtAndarIni);
          pSetaConfiguracoes(edtAndarFin);
        End

        Else
        If strNomCam = 'LOC_APARTA' Then
        Begin
          pSetaConfiguracoes(edtApartamentoIni);
          pSetaConfiguracoes(edtApartamentoFin);
        End;
      End;
    End;
  Finally
    FreeAndNil(objCfgLocFis);
  End;

End;

function TfrmBalancoEstoqueDigColetivo.fEhEstrutura(AStrCodIte: String): Boolean;
begin
  Result := Not fEmptyStr(fCampoTabela('AUTOINCREM','GERMAT', ['GMT_CODITE'], [AStrCodIte]));
end;

end.

