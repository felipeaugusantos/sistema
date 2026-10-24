 unit untMovimentacaoProgramadaManual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel, EditFocus,
  Mask, DBCtrls, DBEditFocus, UniClientDataSet, untMovimentacaoProgramada,
  untTransferenciaMovimentacaoProgramada, BitBtnLockedIncrem,
  Uni, ComCtrls, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, untCadLote,
  cxGrid, cxDataControllerConditionalFormattingRulesManagerDialog,
  untFuncoesRel, dxBarBuiltInMenu, cxPC, cxContainer, QColorLabel, cxGroupBox,
  untZClient, cxButtonEdit, cxCurrencyEdit, cxCheckBox,untGerenciaPropriedadesComponentes,
  System.StrUtils, CxProgressBar, untGravando;

type
  TfrmMovimentacaoProgramadaManual = class(TfrmPaiConfirma)
    pnlCabec: TPanel;
    lblDigita: TLabel;
    edtSenDig: TEditFocus;
    edtNomDig: TEditFocus;
    pnlItem: TPanel;
    Label1: TLabel;
    lblOrigem: TLabel;
    lblDestino: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbeCodIte: TDBEditFocus;
    dbeDesIte: TDBEditFocus;
    dbeLotOri: TDBEditFocus;
    dbeLocDes: TDBEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    dbeQtdIte: TDBEditFocus;
    dbeDesMar: TDBEditFocus;
    dbeCodMar: TDBEditFocus;
    dbeSigUni: TDBEditFocus;
    cxgItens: TcxGridCitel;
    cxgItensView: TcxGridDBTableViewCitel;
    cxgItensViewColumn1: TcxGridDBColumn;
    cxgItensViewColumn2: TcxGridDBColumn;
    cxgItensViewColumn3: TcxGridDBColumn;
    cxgItensViewColumn4: TcxGridDBColumn;
    cxgItensViewColumn5: TcxGridDBColumn;
    cxgItensViewColumn6: TcxGridDBColumn;
    cxgItensViewColumn7: TcxGridDBColumn;
    cxgItensLevel1: TcxGridLevel;
    btnDigitacaoGlobal: TBitBtnLocked;
    dtsGrid: TDataSource;
    cdsItens: TUniClientDataSet;
    cdsItensCODITE: TStringField;
    cdsItensLOTORI: TStringField;
    cdsItensLOTDES: TStringField;
    cdsItensQTDITE: TFloatField;
    cdsItensSALORI: TFloatField;
    cdsItensSALDES: TFloatField;
    cdsItensMAXORI: TFloatField;
    cdsItensMAXDES: TFloatField;
    cdsItensREPORI: TFloatField;
    cdsItensREPDES: TFloatField;
    cdsItensDESITE: TStringField;
    cdsItensSALDOS: TFloatField;
    cdsItensPRECUS: TFloatField;
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
    dtsItens: TDataSource;
    prgProgresso: TProgressBar;
    btnExcluir: TBitBtnLocked;
    cxgItensViewColumn8: TcxGridDBColumn;
    cdsItensDTAVAL: TDateField;
    grbOrigem: TGroupBox;
    lblSalOri: TLabel;
    lblMaxOri: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    dbeSalOri: TDBEditFocus;
    dbeMaxOri: TDBEditFocus;
    dbeSalOriRes: TDBEditFocus;
    dbeSalOriDis: TDBEditFocus;
    cdsItensAUTINC: TStringField;
    lblOpeDest: TLabel;
    edtCodOpeDest: TDBEditFocus;
    edtNomOpeDest: TDBEditFocus;
    cxgItensViewColumn9: TcxGridDBColumn;
    cxgItensViewColumn10: TcxGridDBColumn;
    cdsItensORIPIC: TStringField;
    cdsItensDESPIC: TStringField;
    btnRelatorio: TBitBtnLocked;
    cxgItensViewMAXDES: TcxGridDBColumn;
    cdsItensQTDDIF: TFloatField;
    cdsItensOPEDES: TStringField;
    cdsItensNOMOPEDES: TStringField;
    cxgItensViewColumnOPEDES: TcxGridDBColumn;
    btnExcluirMovProgramada: TBitBtnLocked;
    pagPageControl: TPageControl;
    tbsManual: TTabSheet;
    tbsAbastecimento: TTabSheet;
    pnlFiltrosAbastPrev: TPanel;
    grpFiltrosAbastPrev: TGroupBox;
    chkConsiderarMvtoAndamento: TCheckBox;
    chkConsidEmbFechada: TCheckBox;
    chkAbastItensCapMax: TCheckBox;
    edtCapMax: TEditFocus;
    grpNivGir: TcxGroupBox;
    lblNivGir: TColorLabel;
    edtGirEst: TEditFocus;
    edtCodOpe: TEditFocus;
    edtNomOpe: TEditFocus;
    btnPesquisar: TBitBtnLocked;
    cxStyleRepository: TcxStyleRepository;
    cxAmarelo: TcxStyle;
    cxDados: TcxGridCitel;
    cxgDados: TcxGridDBTableViewCitel;
    cxgDadosITE_CODITE: TcxGridDBColumn;
    cxgDadosITE_DESITE: TcxGridDBColumn;
    cxgDadosMAR_DESMAR: TcxGridDBColumn;
    cxgDadosUNI_DESUNI: TcxGridDBColumn;
    cxgDetalhe: TcxGridDBTableViewCitel;
    cxgDetalheLOT_LOCFIS: TcxGridDBColumn;
    cxgDetalheLOT_NUMLOT: TcxGridDBColumn;
    cxgDetalheQTD_TRANSF: TcxGridDBColumn;
    cxlDados: TcxGridLevel;
    cxlDetalhe: TcxGridLevel;
    dtsDados: TDataSource;
    dtsDetalhes: TDataSource;
    cxgDadosBAR_EMBALA: TcxGridDBColumn;
    cxgDadosLOC_PONREP: TcxGridDBColumn;
    cxgDadosLOC_CAPACI: TcxGridDBColumn;
    cxgDadosLOC_CODLOC: TcxGridDBColumn;
    cxgDadosMLT_QTDMOV: TcxGridDBColumn;
    cxgDadosLOC_QTDSEP: TcxGridDBColumn;
    cxgDadosITE_SUGUNI: TcxGridDBColumn;
    cxgDadosITE_SUGEMB: TcxGridDBColumn;
    cxgDadosITE_SELECE: TcxGridDBColumn;
    btnLimparFiltrosAbast: TBitBtnLocked;
    FlowPanel1: TFlowPanel;
    btnMarDes: TBitBtnLocked;
    btnMarTodos: TBitBtnLocked;
    btnDesmarTodos: TBitBtnLocked;
    cxgDadosITE_SALDES: TcxGridDBColumn;
    lblOperador: TLabel;
    cxVerde: TcxStyle;
    lblExpandirRecolherEtiquetasID: TLabel;
    cxgDetalheLOT_DTAVAL: TcxGridDBColumn;
    cxgDetalheLOT_DTABAL: TcxGridDBColumn;
    cxgDetalheLOT_DISTAN: TcxGridDBColumn;
    cxgDetalheLOT_SELECE_DETAIL: TcxGridDBColumn;
    cxgDadosITE_SALFIS: TcxGridDBColumn;
    cxgDadosCAPACIDADE_CALCULADA: TcxGridDBColumn;
    gpbOrdemSugest: TGroupBox;
    lbxOrdemSugest: TListBox;
    pnlControleOrdem: TPanel;
    btnUp: TSpeedButton;
    btnDown: TSpeedButton;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbeLotOriKeyPress(Sender: TObject; var Key: Char);
    procedure dbeLocDesKeyPress(Sender: TObject; var Key: Char);
    procedure btnDigitacaoGlobalClick(Sender: TObject);
    procedure dbeLocDesChange(Sender: TObject);
    procedure edtCodOpeDestKeyPress(Sender: TObject; var Key: Char);
    procedure btnRelatorioClick(Sender: TObject);
    procedure cxgItensViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgItensViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensViewColumnOPEDESGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure btnExcluirMovProgramadaClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure btnLimparFiltrosAbastClick(Sender: TObject);
    procedure btnMarDesClick(Sender: TObject);
    procedure btnMarTodosClick(Sender: TObject);
    procedure btnDesmarTodosClick(Sender: TObject);
    procedure lblExpandirRecolherEtiquetasIDClick(Sender: TObject);
    procedure tbsAbastecimentoEnter(Sender: TObject);
    procedure cxgDetalheEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure pagPageControlChange(Sender: TObject);
    procedure edtSenDigExit(Sender: TObject);
    procedure cxgDadosITE_SELECEPropertiesChange(Sender: TObject);
    procedure chkConsiderarMvtoAndamentoClick(Sender: TObject);
    procedure tbsAbastecimentoShow(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
  private
    { Private declarations }
    objCadLote: TCadLot;
    qryConOpe: TUniQuery;
    objTransf: TTransferenciaLote;
    objMovimentacaoProgramada: TMovimentacaoProgramadaManual;
    blnLocDes: Boolean;
    blnAgrupado: Boolean;
    LotesSelecionadosMovPro: TLotesSelecionadosMovPro;
    objGerenciaPropriedadesComponentes: TGerenciaPropriedadesComponentes;

    Function fedtCodIteKeyPressGer(Sender: TObject; var Key: Char): Boolean;
    function fValidarOperador: Boolean;
    Function fValidarOperadorDest: Boolean;
    Function fValidarOperadorAbastPreven: Boolean;

    function fValidarLocalizacaoDestino : Boolean;
    function fValidarLoteOrigem: Boolean;
    function fValidarQuantidade: Boolean;
    function fValidarGiro: Boolean;

    function fValidarOperadorTratado: Boolean;

    procedure pAlteraItem;
    function fValidaCfgLotPic(strLocFis: String): Boolean;
    procedure pCarregaLocalizacaoPicking;
    function fValidarPctCapMax: Boolean;
    procedure pSelecionar(ABlnTodos: Boolean; ABlnMarcar: Boolean = False);
    procedure pMarcarDesmarcarLotes(ABlnTodos: Boolean; AStrChaveMaster, AStrSelecionar: String);
    procedure pProcessaOrdemListaSugestao(ABlnCima: Boolean);
    function fExecutaPesquisa(pgbStatus: TcxProgressBar = Nil): Boolean;
  public
    { Public declarations }
    blnCarregando: Boolean;
    blnSepPedRom: Boolean;
    strCodEmpPedRom: String;
    strCodLotPedRom: String;
    blnLiberouTravaPerRom: Boolean;
    blnOrigemFaturamento: Boolean;
    function fValidarProduto(blnBuscaPorChave: Boolean): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untFuncoesSimples, untConsultas,untPnlDadosItem, untPanelCxItem, untTypesSistema,
  untCadLoteItens, untPesqAux, untFuncFat, untObservacaoGenerica,
  untIFatEntregaFutura, untTFatEntregaFutura, untTransfArmazensImportacao,
  untLiberacao, untExcluirControleColeta;

{$R *.dfm}

{ TfrmPaiConfirma1 }

procedure TfrmMovimentacaoProgramadaManual.btnDesmarTodosClick(Sender: TObject);
begin
  inherited;
  pSelecionar(True, False);
end;

procedure TfrmMovimentacaoProgramadaManual.btnDigitacaoGlobalClick(Sender: TObject);
begin
  inherited;
  objTransf.pCarregarLoteVencimento
end;

procedure TfrmMovimentacaoProgramadaManual.btnDownClick(Sender: TObject);
begin
  inherited;
  pProcessaOrdemListaSugestao(False);
end;

procedure TfrmMovimentacaoProgramadaManual.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  {************************************}
  {*O BOTÃO RECEBE O FOCO PARA O VALOR*}
  {*DO EDTQTD SER ATUALIZADO NO CDS   *}
  {*POIS O CLIENTE USAVA O ATALHO DO  *}
  {*BOTAO CONFIRMAR E O VALOR NÃO ERA *}
  {*ATUALIZADO NO CDS E FICAVA 0(ZERO)*}
  {*********************************GB*}
  pSetFocus(btnAdicionar);
  If fVerificaCampos Then
  Begin
    objTransf.pSalvaItem;
    pSetFocus(dbeCodIte);
    edtCodOpeDest.Clear;
    edtNomOpeDest.Clear;
  End;
end;

procedure TfrmMovimentacaoProgramadaManual.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  objTransf.pCancelaEdicaoItem;
  pSetFocus(dbeCodIte);
end;

procedure TfrmMovimentacaoProgramadaManual.btnConfirmaClick(Sender: TObject);
begin
//  inherited;
  if not fValidarOperadorTratado then
    Exit;

  If pagPageControl.ActivePage = tbsManual Then
  Begin
    If cdsItens.IsEmpty Then
    Begin
      pMensagemOk('Inclua os itens para transferência de localização!');
      Exit;
    End;
    If Not fPergunta('Deseja realmente confirmar a transferência entre as localizações?') Then
      Exit;

    Try
      objTransf.pCancelaEdicaoItem(opcGravar);
      objTransf.fGeraTransferencia(True);

      pMensagemOk('Movimentação programada gerada com sucesso.');
      ModalResult := MrOk;
    Except
      On E: Exception Do
      Begin
        pSetFocus(btnConfirma);
        pMensagemOk(E.Message);
        ModalResult := mrNone;
      End;
    End;
  End
  Else
  Begin
    If Not fPergunta('Deseja realmente confirmar o abastecimento preventivo de picking?') Then
      Exit;

    Try
      objTransf.fGeraTransferenciaAbastecimentoPreventivoPicking(edtCodOpe.Text);

      pMensagemOk('Abastecimento programado com sucesso.');
      ModalResult := MrOk;
    Except
      On E: Exception Do
      Begin
        pSetFocus(btnConfirma);
        pMensagemOk(E.Message);
        ModalResult := mrNone;
      End;
    End;
  End;
end;

procedure TfrmMovimentacaoProgramadaManual.btnExcluirClick(Sender: TObject);
 var
    strCodIte,
    strLotOri,
    strLocDes: string;
begin
  inherited;
  strCodIte  := dbeCodIte.Text;
  strLotOri := dbeLotOri.Text;
  strLocDes := dbeLocDes.Text;
  If (Not cdsItens.IsEmpty) And (fPergunta('Confirma a exclusão do registro?')) Then
  Begin
    cdsItens.Delete;
    objTransf.pDeleteRegistroCopia(strCodIte,  strLotOri, strLocDes);
    objTransf.pCancelaEdicaoItem;
    pSetFocus(dbeCodIte);
  End;
end;

procedure TfrmMovimentacaoProgramadaManual.btnRelatorioClick(Sender: TObject);
begin
  inherited;
  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(336, 1812,
                          [1812],
                          [],
                          [],
                          Sender);
     {prcExecutaRelatorio(336, 701812,
                          [1361, 1371],
                          ['NUMROM', 'EMPROM'],
                          [edtNumRom.Text, VS_strCodEmp],
                          Sender);    }
  End;

end;

procedure TfrmMovimentacaoProgramadaManual.btnUpClick(Sender: TObject);
begin
  inherited;
  pProcessaOrdemListaSugestao(True);
end;

procedure TfrmMovimentacaoProgramadaManual.btnExcluirMovProgramadaClick(
  Sender: TObject);
begin
  inherited;
  If btnExcluirMovProgramada.Visible Then
  pCriarForm(TfrmExcluirControleColeta);

end;

procedure TfrmMovimentacaoProgramadaManual.btnLimparFiltrosAbastClick(
  Sender: TObject);
begin
  inherited;
  chkConsiderarMvtoAndamento.Checked := False;
  chkConsidEmbFechada.Checked := False;
  chkAbastItensCapMax.Checked := False;
  edtGirEst.Text := 'T';
  edtCapMax.Text := '100';
end;

procedure TfrmMovimentacaoProgramadaManual.btnMarDesClick(Sender: TObject);
begin
  inherited;
  pSelecionar(False);
end;

procedure TfrmMovimentacaoProgramadaManual.btnMarTodosClick(Sender: TObject);
begin
  inherited;
  pSelecionar(True, True);
end;

procedure TfrmMovimentacaoProgramadaManual.pSelecionar(ABlnTodos: Boolean; ABlnMarcar: Boolean= False);
var
  cdsDados: TDataSet;
  intRecOld: Integer;
begin
  If Not Assigned(dtsDados.DataSet) Then
    Exit;

  cdsDados := dtsDados.DataSet;
  intRecOld := cdsDados.RecNo;
  Try
    cdsDados.DisableControls;
    If Not ABlnTodos Then
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('ITE_SELECE').AsString := IIF(cdsDados.FieldByName('ITE_SELECE').AsString = 'N', 'S', 'N');
      cdsDados.Post;

      pMarcarDesmarcarLotes(ABlnTodos, cdsDados.FieldByName('CHAVE_MASTER').AsString, cdsDados.FieldByName('ITE_SELECE').AsString);

      Exit;
    End
    Else
    Begin
      cdsDados.First;
      While Not cdsDados.Eof Do
      Begin
        cdsDados.Edit;
        cdsDados.FieldByName('ITE_SELECE').AsString := IIF(ABlnMarcar, 'S', 'N');
        cdsDados.Post;

        cdsDados.Next;
      End;

      pMarcarDesmarcarLotes(ABlnTodos, cdsDados.FieldByName('CHAVE_MASTER').AsString, cdsDados.FieldByName('ITE_SELECE').AsString);
    End;
  Finally
    cdsDados.EnableControls;
    cdsDados.RecNo := intRecOld;
  End;
end;

procedure TfrmMovimentacaoProgramadaManual.pMarcarDesmarcarLotes(ABlnTodos: Boolean; AStrChaveMaster, AStrSelecionar: String);
var
  cdsDetalhes: TDataSet;
begin
  cdsDetalhes := dtsDetalhes.DataSet;
  Try
    cdsDetalhes.DisableControls;
    If ABlnTodos Then
    Begin
      cdsDetalhes.First;
      While Not cdsDetalhes.Eof Do
      Begin
        cdsDetalhes.Edit;
        cdsDetalhes.FieldByName('LOT_SELECE_DETAIL').AsString := AStrSelecionar;
        cdsDetalhes.Post;
        cdsDetalhes.Next;
      End;
    End
    Else
    Begin
      cdsDetalhes.Filter := 'CHAVE_MASTER = ' + QuotedStr(AStrChaveMaster);
      cdsDetalhes.Filtered := True;
      cdsDetalhes.First;
      While Not cdsDetalhes.Eof Do
      Begin
        cdsDetalhes.Edit;
        cdsDetalhes.FieldByName('LOT_SELECE_DETAIL').AsString := AStrSelecionar;
        cdsDetalhes.Post;
        cdsDetalhes.Next;
      End;
    End;
  Finally
    cdsDetalhes.EnableControls;
    cdsDetalhes.Filtered := False;
  End;
end;

procedure TfrmMovimentacaoProgramadaManual.pProcessaOrdemListaSugestao(
  ABlnCima: Boolean);
var
  intIdxAtual: Integer;
  strItemTmp: String;
begin
  intIdxAtual := lbxOrdemSugest.ItemIndex;
  If intIdxAtual = -1 Then
    intIdxAtual := 0;
  Try
    Case ABlnCima Of
      True: If intIdxAtual > 0 Then
             Begin
               strItemTmp := lbxOrdemSugest.Items[intIdxAtual-1];
               lbxOrdemSugest.Items[intIdxAtual-1] := lbxOrdemSugest.Items[intIdxAtual];
               lbxOrdemSugest.Items[intIdxAtual] := strItemTmp;
               intIdxAtual := intIdxAtual - 1;
             End;
      False: If intIdxAtual < lbxOrdemSugest.Items.Count-1 Then
             Begin
               strItemTmp := lbxOrdemSugest.Items[intIdxAtual+1];
               lbxOrdemSugest.Items[intIdxAtual+1] := lbxOrdemSugest.Items[intIdxAtual];
               lbxOrdemSugest.Items[intIdxAtual] := strItemTmp;
               intIdxAtual := intIdxAtual + 1;
             End;
    End;
  Finally
    lbxOrdemSugest.ItemIndex := intIdxAtual;
  End;
end;

procedure TfrmMovimentacaoProgramadaManual.tbsAbastecimentoEnter(
  Sender: TObject);
begin
  inherited;
  pSetFocus(chkConsiderarMvtoAndamento);
end;

procedure TfrmMovimentacaoProgramadaManual.tbsAbastecimentoShow(
  Sender: TObject);
begin
  inherited;
  cxgDadosLOC_QTDSEP.Visible := chkConsiderarMvtoAndamento.Checked;
  cxgDadosMLT_QTDMOV.Visible := chkConsiderarMvtoAndamento.Checked;
  cxgDadosITE_SALDES.Visible := chkConsiderarMvtoAndamento.Checked;
  cxgDadosCAPACIDADE_CALCULADA.Visible := chkConsiderarMvtoAndamento.Checked;
end;

procedure TfrmMovimentacaoProgramadaManual.btnPesquisarClick(Sender: TObject);
var
  LfrmGravando: TFrmGravando;
  intCount: integer;
begin
  inherited;

  intCount := 0;
  try
    pCriarFormularios(TfrmGravando, LfrmGravando);
    try
      LfrmGravando.lblGravando.Caption := 'Carregando produtos';
      LfrmGravando.pgbStatus.Visible := False;
      LfrmGravando.fExecutarAcao := fExecutaPesquisa;
      LfrmGravando.ShowModal;
    finally
      FreeAndNil(LfrmGravando);
    End;

    if Assigned(dtsDados.DataSet) then
      if dtsDados.DataSet.RecordCount > 0 then
        cxgDados.ApplyBestFit;
  finally
    if Assigned(dtsDados.DataSet) then
    begin
      while dtsDados.DataSet.ControlsDisabled do
      begin
        dtsDados.DataSet.EnableControls;
        inc(intCount);

        If intCount > 10 then
        begin
          pMensagemOk('Falha ao habilitar grade para edição, entre em contato com a Citel!');
          break;
        end;
      end;
    end;
  end;
end;

procedure TfrmMovimentacaoProgramadaManual.chkConsiderarMvtoAndamentoClick(
  Sender: TObject);
begin
  inherited;
  cxgDadosLOC_QTDSEP.Visible := chkConsiderarMvtoAndamento.Checked;
  cxgDadosMLT_QTDMOV.Visible := chkConsiderarMvtoAndamento.Checked;
  cxgDadosITE_SALDES.Visible := chkConsiderarMvtoAndamento.Checked;
  cxgDadosCAPACIDADE_CALCULADA.Visible := chkConsiderarMvtoAndamento.Checked;

end;

procedure TfrmMovimentacaoProgramadaManual.cxgDadosITE_SELECEPropertiesChange(
  Sender: TObject);
var
  cdsDados: TDataSet;
begin
  inherited;
  cdsDados := dtsDados.DataSet;
  pMarcarDesmarcarLotes(False, cdsDados.FieldByName('CHAVE_MASTER').AsString, IIF(TcxCheckBox(Sender).Checked , 'S','N'));
end;

procedure TfrmMovimentacaoProgramadaManual.cxgDetalheEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
Var
  arrLotes: TConsultasArray;
  strLoteAtual: string;
  strCodIte: String;
  fltQtdLote: Double;
  qryLote: TUniQuery;
  LoteItemSelecionados: TLoteItemSelecionados;

begin
  inherited;

  If SameText(TcxGridDBColumn(AItem).DataBinding.FIeldName, 'LOT_NUMLOT') And fEntraCons(Key) Then
  Begin
    strCodIte := dtsDados.DataSet.FieldByName('ITE_CODITE').AsString;
    fltQtdLote := dtsDetalhes.DataSet.FieldByName('QTD_TRANSF').AsFloat;
    LoteItemSelecionados := LotesSelecionadosMovPro.ItemLotes[dtsDados.DataSet.FieldByName('CHAVE_MASTER').AsString];
    strLoteAtual :=  dtsDetalhes.DataSet.FieldByName('LOT_NUMLOT').AsString;
    qryLote := fCriaQuery;
    Try
      if fPesqLoteFat(Self, Nil, fCfgSis('DECUNI', varInteger), strCodIte,
                                                                     True,
                                                                     True,
                                                                     qryLote,
                                                                     Char(Key),
                                                                     arrLotes,
                                                                     '',
                                                                     Nil,
                                                                     True,
                                                                     Nil,
                                                                     True,
                                                                     False,
                                                                     False,
                                                                     False,
                                                                     False,
                                                                     Nil,
                                                                     'N',
                                                                     False,
                                                                     False,
                                                                     False,
                                                                     '',
                                                                     0,
                                                                     fltQtdLote,
                                                                     True,
                                                                     LoteItemSelecionados.strLotes) then
      begin
        dtsDetalhes.DataSet.Edit;
        dtsDetalhes.DataSet.FieldByName('LOT_NUMLOT').AsString := qryLote.FieldByName('LOT_NUMLOT').AsString;
        dtsDetalhes.DataSet.FieldByName('LOT_DTAVAL').AsString := qryLote.FieldByName('LOT_DTAVAL').AsString;
        dtsDetalhes.DataSet.FieldByName('LOT_LOCFIS').AsString := qryLote.FieldByName('LOT_LOCFIS').AsString;
        dtsDetalhes.DataSet.Post;

        LoteItemSelecionados.strLotes := StringReplace(LoteItemSelecionados.strLotes, strLoteAtual, qryLote.FieldByName('LOT_NUMLOT').AsString, []);
        LotesSelecionadosMovPro.pAtualizaLote(LoteItemSelecionados);


      end;
    Finally
      FreeAndNil(qryLote);
    End;
  End
  Else
  Begin
    Key := #0;
  End;
end;

procedure TfrmMovimentacaoProgramadaManual.cxgItensViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pAlteraItem;
end;

procedure TfrmMovimentacaoProgramadaManual.cxgItensViewColumnOPEDESGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If AText = '' Then
    Exit;
  AText := AText + '-' + fRetNomVendRep(AText);
end;

procedure TfrmMovimentacaoProgramadaManual.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewColumnOPEDES.Index]) = '') Then
    ACanvas.Font.Color := clGreen;

end;

procedure TfrmMovimentacaoProgramadaManual.cxgItensViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = VK_RETURN then
    pAlteraItem;
end;

procedure TfrmMovimentacaoProgramadaManual.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  fedtCodIteKeyPressGer(Sender, Key);
end;

procedure TfrmMovimentacaoProgramadaManual.dbeLocDesChange(Sender: TObject);
begin
  inherited;
  blnLocDes := false;
end;

procedure TfrmMovimentacaoProgramadaManual.dbeLocDesKeyPress(Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;
 If fPesqLocFisica(Self, TEdit(Sender), Nil, Nil, Key, arrSel, True, False, False, False, True, dbeCodIte.Text) And
     fValidaCampos(TEdit(Sender), True) Then
     Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmMovimentacaoProgramadaManual.dbeLotOriKeyPress(Sender: TObject; var Key: Char);
var strPicking: string;
begin
  inherited;
  strPicking := 'N';
  If not blnOrigemFaturamento Then
    strPicking := '';

  If objCadLote.fedtNumLotKeyPress(dbeCodIte.Text, Sender, Key, TEditFocus(Sender), Self,
     False, False, Nil, Nil, '', False, False, True, False, Nil, strPicking, False, False, False, '', 0, '', '', false, True) Then
  Begin
    If fValidaCampos(TEdit(Sender), True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmMovimentacaoProgramadaManual.edtCodOpeDestKeyPress(
  Sender: TObject; var Key: Char);
 var
    arrSel: TConsultasArray;
begin
  If (Key = ',') or (Key = '+') Then
  Begin
    Key := #0;
    Exit;
  End;

  Try
    if fPesqOperador(Self, edtCodOpeDest, Nil, qryConOpe, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodOpeDest, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  Except
    On E: Exception Do
    Begin
      fMensagem('', 'Erro na busca rápida: ' + E.Message, ['&O k']);
    End;
  End;
end;

procedure TfrmMovimentacaoProgramadaManual.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
var
    arrSel: TConsultasArray;
begin
  If (Key = ',') or (Key = '+') Then
  Begin
    Key := #0;
    Exit;
  End;

  Try
    if fPesqOperador(Self, edtCodOpe, Nil, qryConOpe, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodOpe, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  Except
    On E: Exception Do
    Begin
      fMensagem('', 'Erro na busca rápida: ' + E.Message, ['&O k']);
    End;
  End;
end;

procedure TfrmMovimentacaoProgramadaManual.edtSenDigExit(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeCodIte);
end;

function TfrmMovimentacaoProgramadaManual.fedtCodIteKeyPressGer(Sender: TObject;
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
                     0)
        Then
        Begin
          If fValidaCampos(dbeCodIte) Then
            SelectNext(ActiveControl, True, True);

        End;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmTransfLote.fedtCodIteKeyPressGer]');
        End;
      End;
    Finally
      FreeAndNil(objfrmPnl);
      FreeAndNil(qryConCit);
    End;
  End;
  Result := True;
end;

function TfrmMovimentacaoProgramadaManual.fExecutaPesquisa(
  pgbStatus: TcxProgressBar): Boolean;
var
  recFiltros: TRecFiltrosAbastecimentoPreventivoPicking;
  LotesSelecionados: TLoteItemSelecionados;
begin
  Result := True;

  try
    blnAgrupado := True;

    recFiltros.blnConsiderarMovimentacoesEmAndamento := chkConsiderarMvtoAndamento.Checked;
    recFiltros.blnConsiderarEmbalagemFechada := chkConsidEmbFechada.Checked;
    recFiltros.blnAbastecerItensPctg := chkAbastItensCapMax.Checked;
    recFiltros.strNivGir := edtGirEst.Text;
    recFiltros.strCodOpe := edtCodOpe.Text;
    recFiltros.strCodEmp := VS_StrCodEmp;
    recFiltros.fltPctCapMax := StrToFloatDef(edtCapMax.Text, 100);
    recFiltros.strOrdemLote := objTransf.fGetOrdenacaoLotes(lbxOrdemSugest.Items);

    If objTransf.fPesquisar(recFiltros) Then
    Begin
      dtsDados.DataSet := objTransf.fGetcdsAbastPrevMaster;
      dtsDetalhes.DataSet := objTransf.fGetcdsAbastPrevDetail;
      dtsDados.DataSet.DisableControls;
      try
        LotesSelecionados.strCodIte_chave := dtsDetalhes.DataSet.FieldByName('CHAVE_MASTER').AsString;
        LotesSelecionados.strLotes := '';
        LotesSelecionadosMovPro.Reincia;
        while not dtsDados.DataSet.Eof do
        Begin
          LotesSelecionados.strCodIte_chave := dtsDados.DataSet.FieldByName('CHAVE_MASTER').AsString;
          LotesSelecionados.strLotes := dtsDados.DataSet.FieldByName('LOTES_AMARRADOS').AsString;
          LotesSelecionadosMovPro.pAdd(LotesSelecionados);
          dtsDados.DataSet.Next;
          LotesSelecionados.strCodIte_chave := '';
          LotesSelecionados.strLotes := '';
        End;
      Finally
        dtsDados.DataSet.First;
        dtsDetalhes.DataSet.First;
      End;
    End;

    Application.ProcessMessages;
  except
    on e: Exception do
    begin
      Result := False;
      pMensagensErro(e.message, '[TfrmMovimentacaoProgramadaManual.fExecutaPesquisa]');
    end;
  end;
end;

procedure TfrmMovimentacaoProgramadaManual.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtSenDig);
end;

procedure TfrmMovimentacaoProgramadaManual.FormClose(Sender: TObject; var Action: TCloseAction);
var
  objLiberacao : TLiberacao;
begin
  inherited;
  If ( Not cdsItens.IsEmpty) And
    (Not fPergunta('Deseja cancelar a tarefa?')) Then
  Begin
    Action := caNone;
    Exit;
  End;

  if (ModalResult <> MrOk) and blnSepPedRom and (not(fVerificaAcessoSistema('mnuPermAbortarMovProg'))) then
  begin
    objLiberacao := TLiberacao.Create;
    try
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Permitir abortar a geração de movimentação programada para realização de transferência de');
      objLiberacao.objMsgLibera.pAddTexto('estoque entre localizações na impressão da separação da Expedição.');
      objLiberacao.objMsgLibera.pAddQuebra();
      objLiberacao.objMsgLibera.pAddTexto('Empresa: ' + strCodEmpPedRom + ' - ' + fRetNomeEmpresa(strCodEmpPedRom));
      objLiberacao.objMsgLibera.pAddTexto('Lote de Separação: ' + strCodLotPedRom);

      objLiberacao.strDirAce := 'mnuPermAbortarMovProg';
      objLiberacao.strMsgSen := 'Liberação da geração de movimentação programada na impressão da separação da Expedição.';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;

      blnLiberouTravaPerRom := objLiberacao.fLibera;
      if not blnLiberouTravaPerRom then
        Action := caNone;
    finally
      FreeAndNil(objLiberacao);
    end;
  end;
end;

procedure TfrmMovimentacaoProgramadaManual.FormCreate(Sender: TObject);
begin
  inherited;
  blnOrigemFaturamento := False;
  blnVerificaCampos := false;
  cdsItens.CreateDataSet;
  objTransf := TTransferenciaLote.Create(Self, cdsItens, dtsItens, prgProgresso);
  objCadLote := TCadLot.Create(Self);
  objMovimentacaoProgramada := TMovimentacaoProgramadaManual.Create('');
  blnCarregando := False;
  blnSepPedRom := False;
  blnLiberouTravaPerRom := False;
  btnExcluirMovProgramada.Visible := fVerificaAcessoSistema('EXCMOVPRG');
  LotesSelecionadosMovPro := TLotesSelecionadosMovPro.Create;
  pagPageControl.ActivePage := tbsManual;
  objGerenciaPropriedadesComponentes := TGerenciaPropriedadesComponentes.Create(Self, Self.Name, strLoginUsuarioLogado);
  objGerenciaPropriedadesComponentes.pAddComponente(lbxOrdemSugest);
  objGerenciaPropriedadesComponentes.pCarregar(False);
end;

procedure TfrmMovimentacaoProgramadaManual.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(LotesSelecionadosMovPro);
  FreeAndNil(objMovimentacaoProgramada);
  FreeAndNil(objTransf);
  FreeAndNil(objCadLote);
  objGerenciaPropriedadesComponentes.pSalvar;
  FreeAndNil(objGerenciaPropriedadesComponentes);
end;

procedure TfrmMovimentacaoProgramadaManual.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If pnlBotoes.Enabled Then
  Begin
    Case Key Of
      VK_F10:
        Begin
          Key := 0;
          btnConfirma.Click;
        End;
      VK_F5:
        Begin
          Key := 0;
          btnDigitacaoGlobal.Click;
        End;
      VK_F7: btnExcluirMovProgramada.Click;

      VK_DELETE:
        If fCheckParent(ActiveControl, cxgItens) Then
          btnExcluir.Click;

      VK_RETURN:
        If fCheckParent(ActiveControl, cxgItens) And dbeCodIte.CanFocus then
          pSetFocus(dbeCodIte);
    End;

    If pagPageControl.ActivePage = tbsAbastecimento Then
    Begin
      Case Key Of
        VK_SPACE:
          btnMarDes.Click;
        VK_F2:
          btnMarTodos.Click;
        VK_F3:
          btnDesmarTodos.Click;
      End;
    End;
  End;
end;

procedure TfrmMovimentacaoProgramadaManual.FormShow(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;
end;

function TfrmMovimentacaoProgramadaManual.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  Try
    If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Begin
      If (Sender = edtSenDig) Then
        result := fValidarOperador
      Else If Sender = edtCodOpeDest Then
        result := fValidarOperadorDest
      Else If Sender = edtCodOpe Then
        result := fValidarOperadorAbastPreven
      Else If Sender = dbeCodIte Then
        result := fValidarProduto(blnBuscaPorChave)
      Else If Sender = dbeLotOri Then
        Result := fValidarLoteOrigem
      Else If Sender = dbeLocDes Then
        Result := fValidarLocalizacaoDestino
      Else If Sender = dbeQtdIte Then
        Result := fValidarQuantidade
      Else If Sender = edtGirEst Then
        Result := fValidarGiro
      Else If Sender = edtCapMax Then
        Result := fValidarPctCapMax;
    End;
  Except
    On E: Exception Do
    Begin
      Result := false;
      pSetFocus(Sender);
      pMensagemOk(e.Message);
    End;
  End;
end;

function TfrmMovimentacaoProgramadaManual.fValidarPctCapMax: Boolean;
begin
  If Not chkAbastItensCapMax.Checked Then
    Exit(True);

  Result := (StrToFloat(edtCapMax.Text) > 0 ) And (StrToFloat(edtCapMax.Text) < 100 );
  If Not Result Then
    raise Exception.Create('O campo % da capacidade máxima deve estar entre 0% e 100%');
end;

function TfrmMovimentacaoProgramadaManual.fValidarGiro: Boolean;
begin
  Result := Pos(edtGirEst.Text, 'ABCT') > 0;
  If Not Result Then
    raise Exception.Create('O campo nível de giro deve ser A,B,C ou T!');
end;

function TfrmMovimentacaoProgramadaManual.fValidaCfgLotPic(
  strLocFis: String): Boolean;
var
  qrySelect: TUniQuery;
  strSql: String;
begin
  Result := True;

  if not fCfgSis('LOTPIC', varBoolean) then
    Exit;

  strSql := '';
  strSql := strSql + 'SELECT LOC_CODLOC ';
  strSql := strSql + '  FROM CADLOC L ';
  strSql := strSql + '  LEFT JOIN CADLOT ON LOT_LOCFIS = L.LOC_CODLOC AND LOT_CODEMP = L.LOC_CODEMP ';
  strSql := strSql + ' WHERE L.LOC_CODEMP = :CODEMP ';
//  strSql := strSql + '   AND LOT_CODITE = :CODITE ';
  strSql := strSql + '   AND LOC_CODLOC = :CODLOC ';
//  strSql := strSql + '   AND LOC_PICKIN = "S" ';
  strSql := strSql + '   AND LOC_ATIVO_ = "S" ';

  qrySelect := fCriaQuery;
  try
    qrySelect.SQL.Text := strSQL;
    qrySelect.ParamByName('CODEMP').AsString := VS_strCodEmp;
//    qrySelect.ParamByName('CODITE').AsString := dbeCodIte.Text;
    qrySelect.ParamByName('CODLOC').AsString := strLocFis;
    qrySelect.Open;

    Result := not qrySelect.IsEmpty;
  finally
    FreeAndNil(qrySelect);
  end;
end;

function TfrmMovimentacaoProgramadaManual.fValidarOperador: Boolean;
begin
  if blnCarregando then
    Exit(True);

  if (fEmptyStr(edtSenDig.Text))  then
    raise Exception.Create('ATENÇÃO! O digitador deve ser preenchido!');

  objTransf.strCodOpe := fRetCodVendedor(edtSenDig.Text);
  edtNomDig.Text := fRetNomVendRep(objTransf.strCodOpe);

  if (fEmptyStr(edtNomDig.Text)) then
    raise Exception.Create('ATENÇÃO! Senha inválida!');

  pnlitem.Enabled := Not fEmptyStr(edtNomDig.Text);
  pnlFiltrosAbastPrev.Enabled := Not fEmptyStr(edtNomDig.Text);
  Result := true;
end;

function TfrmMovimentacaoProgramadaManual.fValidarOperadorDest: Boolean;
var
  strNomOpe: String;
begin
  If fEmptyStr(edtCodOpeDest.Text) Then
    Exit(True);

  strNomOpe := fRetNomVendRep(edtCodOpeDest.Text);

  if (fEmptyStr(strNomOpe))  then
    raise Exception.Create('ATENÇÃO! O operador de destino informado não existe!');

  edtCodOpeDest.Field.Value := edtCodOpeDest.Text;
  edtNomOpeDest.Field.Value := strNomOpe;

  Result := True;
end;

function TfrmMovimentacaoProgramadaManual.fValidarOperadorAbastPreven: Boolean;
var
  strNomOpe: String;
begin
  If pagPageControl.ActivePage = tbsManual Then
    Exit(True);

  if fEmptyStr(edtCodOpe.Text) then
    Exit(True);

  strNomOpe := fRetNomVendRep(edtCodOpe.Text);
  edtNomOpe.Text := strNomOpe;

  Result := Not (fEmptyStr(strNomOpe));
  if Not Result then
  begin
    pMensagemOk('ATENÇÃO! O operador informado não existe!');
    pSetFocus(edtCodOpe);
  end;

end;

function TfrmMovimentacaoProgramadaManual.fValidarOperadorTratado: Boolean;
begin
  try
    If pagPageControl.ActivePage = tbsManual Then
      Result := fValidarOperador
    Else
      Result := fValidarOperadorAbastPreven
  except
    on E: Exception do
    begin
      Result := False;
      pMensagemOk(E.Message);
    end;
  end;

  if (not Result) and (pagPageControl.ActivePage = tbsManual) then
    pSetFocus(edtSenDig);
end;

function TfrmMovimentacaoProgramadaManual.fValidarProduto(blnBuscaPorChave: Boolean): Boolean;
Var
  blnBuscaCodBar: Boolean;
  qryBusca: TUniQuery;
  blnLocalizado: Boolean;
Begin
  blnLocalizado := false;
  If fEmptyStr(dbeCodIte.Text) Then
    raise Exception.Create('"ATENÇÃO! O produto deve ser preenchido!');

  If blnBuscaPorChave Then
  Begin
    blnBuscaCodBar := (Length(Trim(dbeCodIte.Text)) > 5);
    If Not blnBuscaCodBar  Then
      dbeCodIte.Text := fStrZero(dbeCodIte.Text, 5);

    qryBusca := fCriaQuery(Self);
    Try
      pPesquisaCadSem(qryBusca, qryBusca, dbeCodIte.Text, '', blnBuscaCodBar);
      blnLocalizado := qryBusca.IsEmpty;
      If not (dbeCodIte.DataSource.DataSet.State in dsEditModes) Then
        dbeCodIte.DataSource.DataSet.Edit;
      dbeCodIte.Text := qryBusca.FieldByName('ITE_CODITE').AsString;
      dbeDesIte.Field.Value := fRetNomProduto(dbeCodIte.Text);
      dbeCodMar.Field.Value := fRetMarcaItem(dbeCodIte.Text);
      dbeDesMar.Field.Value := fRetNomMarcaItem(dbeCodIte.Text);
      dbeSigUni.Field.Value := fRetSiglaUnidadePorCodIte(dbeCodIte.Text);

      if fCfgSis('LOTPIC', varBoolean) then
        pCarregaLocalizacaoPicking();
    Finally
      FreeAndNil(qryBusca);
    End;
  End;

  if blnLocalizado then
    raise Exception.Create('"ATENÇÃO! Produto não localizado!');

  If objTransf.ObjMovLot.fTemMovimentoProgramadoEmAberto(dbeCodIte.Text) Then
  Begin
    If fMensagem('Atenção!', 'Este item possui uma movimentação programada em aberto. Deseja criar uma nova movimentação programada?', ['&Sim', '&Não'], 2) = 2 Then
      raise Exception.Create('A movimentação programada não será gerada.');
  End;

  Result := true;
End;

function TfrmMovimentacaoProgramadaManual.fValidarLoteOrigem: Boolean;
Begin
  If Not fNumLotAtivo(dbeCodIte.Text, dbeLotOri.Text, VS_strCodEmp) Then
    raise Exception.Create('Não é permitido movimentação de estoque para lotes inativos');

  If fVerificaLoteTransitorio(dbeCodIte.Text, dbeLotOri.Text, VS_strCodEmp) Then
    raise Exception.Create('Não é permitida a seleção de Lotes Transitórios!');

  Result := objTransf.fCarregarLote(dbeLotOri.Text);

  If (UpperCase(dbeLocDes.Text) = 'A DEFINIR') Then
    raise Exception.Create('Não é permitido transferir lote "A Definir"!');

  If (Result) Then
    If (dbeSalOriDis.Field.AsCurrency <= 0) Then
      raise Exception.Create('Atenção!' + #13 + 'No lote de origem é permitido informar somente lotes que tenham saldo.');

  If Result and (blnOrigemFaturamento) Then
    If (dbeLotOri.Field.DataSet.FieldByName('ORIPIC').AsString = 'S') then
      raise Exception.Create('Atenção!' + #13 + 'No lote de origem é permitido informar somente lotes Buffer!');

  If (Result) Then
    If TCadLot.fBloqueiaTranfSaldoLote(dbeLotOri.Text, '', dbeCodIte.Text, VS_strCodEmp, False) Then
      raise Exception.Create('Atenção!' + #13 + 'Lote de origem não pode ser movimentado ' +
                             ' pois está relacionado às Configurações [CFG_LCTASE]/[CFG_LCTALC]' +
                             ' e/ou Locais de Armazenamento do Coletor (Tabela [CADLAR])!');
End;

function TfrmMovimentacaoProgramadaManual.fValidarLocalizacaoDestino: Boolean;
begin
  Result := Not fEmptyStr(dbeLocDes.Text);

  If Not Result then
    raise Exception.Create('A localização de destino não foi informada!')
  Else
  If fEmptyStr(fRetNomLocFisica(dbeLocDes.Text)) Then
    raise Exception.Create('Localização Física não encontrada!')
  Else
  If Not fValidaCfgLotPic(dbeLocDes.Text) Then
    raise Exception.Create('O produto pode ter apenas um lote por localização PICKING! Verifique a localização de destino informada!')
  Else
  If TCadLot.fBloqueiaTranfSaldoLote('', dbeLocDes.Text, '', VS_strCodEmp, False) Then
    raise Exception.Create('Atenção!' + #13 + 'Lote de destino não pode ser movimentado ' +
                             ' pois está relacionado às Configurações [CFG_LCTASE]/[CFG_LCTALC]' +
                             ' e/ou Locais de Armazenamento do Coletor (Tabela [CADLAR])!')
  Else
  If (cdsItens.Locate('CODITE;LOTORI;LOCDES', VarArrayOf([dbeCodIte.Text, dbeLotOri.Text, dbeLocDes.Text]), [])) Then
  Begin
    Result := true;
    objTransf.pCancelaEdicaoItem(opcEditar);
    objTransf.pEditaItem;
  End
  else
  if (Not blnLocDes) Then
  Begin
    If (objTransf.fValidarLocalizacaoDestino(dbeCodIte.Text,dbeLocDes.Text)) then
    Begin
      blnLocDes := true;
      Result := true;
    End
    Else
      Result := False;
  End;
end;

function TfrmMovimentacaoProgramadaManual.fValidarQuantidade: Boolean;
Begin
  If fStrToFloat(dbeQtdIte.Text) <= 0 Then
    raise Exception.Create('A quantidade transferida deve ser maior que zero!');

  If fStrToFloat(dbeQtdIte.Text) > fStrToFloat(dbeSalOriDis.Text) Then
    raise Exception.Create('A quantidade transferida deve ser menor ou igual ao saldo disponível!');

  If (dbeQtdIte.DataSource.DataSet.FieldByName('MAXDES').AsFloat > 0) And
     (fStrToFloat(dbeQtdIte.Text) > (dbeQtdIte.DataSource.DataSet.FieldByName('MAXDES').AsFloat + dbeQtdIte.DataSource.DataSet.FieldByName('QTDDIF').AsFloat)) Then
    raise Exception.Create('A quantidade a transferir é maior que a quantidade máxima da localização do destino. ' +
                           'Realize o ajuste no cadastro "Mapeamento de localização física" e depois tente novamente.');

  Result := True;
End;

procedure TfrmMovimentacaoProgramadaManual.lblExpandirRecolherEtiquetasIDClick(
  Sender: TObject);
begin
  inherited;
  cxgDados.BeginUpdate;
  Try
    Case blnAgrupado Of
      True: Begin
              cxgDados.ViewData.Expand(True);
              blnAgrupado := False;
            End;
     False: Begin
              cxgDados.ViewData.Collapse(True);
              blnAgrupado := True;
            End;
    End;
  Finally
    cxgDados.EndUpdate;
  End;
end;

procedure TfrmMovimentacaoProgramadaManual.pagPageControlChange(
  Sender: TObject);
begin
  inherited;
  btnDigitacaoGlobal.Visible := pagPageControl.ActivePage = tbsManual;
  btnRelatorio.Visible := btnDigitacaoGlobal.Visible;
  btnExcluir.Visible := btnDigitacaoGlobal.Visible;
  btnExcluirMovProgramada.Visible := btnDigitacaoGlobal.Visible;
end;

procedure TfrmMovimentacaoProgramadaManual.pAlteraItem;
begin
  if not fValidarOperadorTratado then
    Exit;

  objTransf.pCancelaEdicaoItem(opcEditar);
  objTransf.pEditaItem;
end;

procedure TfrmMovimentacaoProgramadaManual.pCarregaLocalizacaoPicking;
var
  qrySelect: TUniQuery;
  strSql: String;
begin
  strSql := '';
  strSql := strSql + 'SELECT LOC_CODLOC ';
  strSql := strSql + '  FROM CADLOC L ';
  strSql := strSql + '  LEFT JOIN CADLOT ON LOT_LOCFIS = L.LOC_CODLOC AND LOT_CODEMP = L.LOC_CODEMP ';
  strSql := strSql + ' WHERE L.LOC_CODEMP = :CODEMP ';
  strSql := strSql + '   AND LOT_CODITE = :CODITE ';
  strSql := strSql + '   AND LOC_PICKIN = "S" ';
  strSql := strSql + '   AND LOC_ATIVO_ = "S" ';

  qrySelect := fCriaQuery;
  try
    qrySelect.SQL.Text := strSQL;
    qrySelect.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qrySelect.ParamByName('CODITE').AsString := dbeCodIte.Text;
    qrySelect.Open;

    if qrySelect.RecordCount = 1 then
      dbeLocDes.Field.AsString := qrySelect.FieldByName('LOC_CODLOC').AsString;
  finally
    FreeAndNil(qrySelect);
  end;
end;

end.
