unit untManOrdProIndustrial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  Mask, DBCtrls, DBEditFocus, EditFocus, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxCurrencyEdit, untZClient, System.UITypes,
  untOrdProIndustrial, BitBtnLockedIncrem, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade, Uni,
  cxCheckBox, dxGDIPlusClasses, Vcl.Grids, Vcl.DBGrids,
  DBGridCitel, TypesRel, UniClientDataSet, cxButtonEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  OrdemProducaoIndustrial.Funcoes, OrdemProducaoIndustrial.FuncoesJson,
  OrdemProducaoIndustrial.TOrdemProducao,
  OrdemProducaoIndustrial.TMateriaPrima, cxGridCitel, MaskEditFocus, untOrdProIndCorrecoes,untOrdProIndustrialEtq,
  MemoFocus, untFuncoesRel;

type
  TfrmManOrdProIndustrial = class(TfrmPaiCad)
    dtsTabela: TDataSource;
    btnImprimir: TBitBtnLocked;
    pnlDados: TPanel;
    pnlCabec: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    dbeCodIte: TDBEditFocus;
    edtDesIte: TEditFocus;
    dbeCodCor: TDBEditFocus;
    edtDesCor: TEditFocus;
    dbeCodOrd: TDBEditFocus;
    dbeDtaCad: TDBEditFocus;
    dbeDtaPre: TDBEditFocus;
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBTableView;
    cxgItensViewColumn1: TcxGridDBColumn;
    cxgItensViewColumn2: TcxGridDBColumn;
    cxgItensViewColumn3: TcxGridDBColumn;
    cxgItensQTDPRO: TcxGridDBColumn;
    cxgItensLevel1: TcxGridLevel;
    pnlTotais: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    dbeVolume: TDBEditFocus;
    dbePeso: TDBEditFocus;
    pnlBaixa: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    DBEditFocus1: TDBEditFocus;
    DBEditFocus2: TDBEditFocus;
    DBEditFocus3: TDBEditFocus;
    DBEditFocus4: TDBEditFocus;
    DBEditFocus5: TDBEditFocus;
    prgProgresso: TProgressBar;
    tbsFases: TTabSheet;
    cxgCadFas: TcxGrid;
    cxgCadFasView: TcxGridDBTableView;
    cxgCadFasCODFAS: TcxGridDBColumn;
    cxgCadFasDESFAS: TcxGridDBColumn;
    cxgCadFasLevel1: TcxGridLevel;
    cxgCadFasUTILIS: TcxGridDBColumn;
    pnlBotoesFases: TPanel;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    mmoTravaFases: TMemo;
    imgLocFis: TImage;
    lblTitLocFis: TLabel;
    lblLocFis: TLabel;
    btnLoteMP: TBitBtnLocked;
    tbsFormula: TTabSheet;
    dbgOrdMat: TDBGridCitel;
    pnlBottom: TPanel;
    Label10: TLabel;
    DBEditFocus6: TDBEditFocus;
    shpCorrecao: TShape;
    Label11: TLabel;
    dbeTotKil: TDBEditFocus;
    Label12: TLabel;
    Label13: TLabel;
    dbeTotLil: TDBEditFocus;
    dbeCusFor: TDBEditFocus;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    edtCusLit: TEditFocus;
    edtCusKil: TEditFocus;
    Splitter1: TSplitter;
    Panel1: TPanel;
    Label17: TLabel;
    dbgEnvasados: TDBGridCitel;
    cxgItensViewColumn4: TcxGridDBColumn;
    lblDtaVal: TLabel;
    dbeDtaVal: TDBEditFocus;
    btnGirEstoque: TBitBtnLocked;
    cxgItensITE_CODPAG: TcxGridDBColumn;
    cxgItensCOMPOSICAO: TcxGridDBColumn;
    pnlLegenda: TPanel;
    Label19: TLabel;
    cxgItensESTOQUE_MAXIMO: TcxGridDBColumn;
    cxgItensESTOQUE_MINIMO: TcxGridDBColumn;
    cxgItensESTOQUE_FISICO: TcxGridDBColumn;
    cxgItensESTOQUE_DISPONIVEL: TcxGridDBColumn;
    cxgItensCAPMAX: TcxGridDBColumn;
    tbsDescProdProducao: TTabSheet;
    RichDescProcProducao: TRichEdit;
    pnlCapacidadeMaxima: TPanel;
    lblCapacidadeMaxima: TLabel;
    dbeCapacidadeMaxima: TDBEditFocus;
    btnAtualProdAcabado: TBitBtnLocked;
    tbsHistoricoBaixa: TTabSheet;
    memHisBai: TMemoFocus;
    btnEtiquetas: TBitBtnLocked;
    btnFormulas: TBitBtnLocked;
    chbUsaCapacidadeMaxima: TDBCheckBox;

    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodCorKeyPress(Sender: TObject; var Key: Char);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgItensEnter(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure btnLoteMPClick(Sender: TObject);
    procedure dbgOrdMatDrawColumnCell(Sender: TObject; const [Ref] Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure cxgItensCOMPOSICAOPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxgItensViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgItensViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnAtualProdAcabadoClick(Sender: TObject);
    procedure btnEtiquetasClick(Sender: TObject);
    procedure btnFormulasClick(Sender: TObject);
    procedure btnGirEstoqueClick(Sender: TObject);
    procedure chbUsaCapacidadeMaximaClick(Sender: TObject);
  private
    { Private declarations }
    cdsFormul: TZClient;
    objOrdInd: TOrdProIndustrial;

    procedure pHabilitaItens(blnHabilita: Boolean = True);
    procedure pCarregaDadosAdicionais;
    procedure pHabilitaFases(blnHabilita: Boolean);
    procedure pChecaOperacoes;
    function fTemOrdemProducaoEmAberto:Boolean;
    procedure pSetLocFis;
    function fGetSQLFormulaBaixa: String;
    procedure pFiltraProdAcab;
    procedure pAlteraStatusBotoes(blnModoNavegacao: boolean);
    function fValidaFormula: boolean;
    procedure pDesabilitaCod;
    procedure LimpaOBSProcedimentoProducao;
    procedure pQryTabelaAfterOpen(DataSet: TDataSet);
    procedure pCapMaxDataChange(Sender: TField);
    procedure AtualizaCustoDaMateriaPrima(objOrdemProducao : TOrdemProducao);
    procedure pExcluirAnalise(strAutoincrem: String);
    function  fTemAnalises(strAutoincrem: String): Boolean;
    procedure pHabilitaBotaoProdAcabado;
    function fExisteProcessoExtrusao(strSeqGer: String): Boolean;
    procedure pCarregaOrdemDeProducao(var Result : Boolean);
    procedure pLimpaDados;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;


implementation

uses  untFuncoesSimples, untTypesSistema,
      untConsultas, untExibeArvoreOPIndustrial, untManOrdProIndustrialLotesMP,
      untOrdProIndustrialImprimeLotes, untFuncoesRel2, untConstantes, untAdicionaProdutoAcabado,
      untPanelCxFormula, untPnlDadosFormula,
      untPanelCxOPI, untPnlDadosOPI;

{$R *.dfm}

procedure TfrmManOrdProIndustrial.AtualizaCustoDaMateriaPrima(objOrdemProducao : TOrdemProducao);
var
  objMateriaPrima     :TMateriaPrima;
begin
  For objMateriaPrima in objOrdemProducao.objFormula.lstMateriasPrimas Do
  Begin
    If (cdsFormul.Locate('ITESUB', objMateriaPrima.strCodigo, [])) Then
    Begin
      cdsFormul.Edit;
      cdsFormul.FieldByName('TOTCUS').AsFloat:= objMateriaPrima.fRetornaCustoProduzidoKilo(objOrdemProducao.fRetornaPesoProduzidoTotal);
      cdsFormul.Post;
    End;
  End;
end;

procedure TfrmManOrdProIndustrial.btnAlterarClick(Sender: TObject);
begin
  inherited;

  If (qryTabela.State in dsEditModes) Then
  Begin
    pAlteraStatusBotoes(False);

    If dbeDtaPre.CanFocus Then
    Begin
      pDesabilitaCod;
    End;

    pHabilitaItens;

    pnlCabec.Enabled := qryTabela.FieldByName('ORD_DTABAI').IsNull;
    pnlTotais.Enabled := qryTabela.FieldByName('ORD_DTABAI').IsNull;
    cxgItensQTDPRO.Properties.ReadOnly := Not qryTabela.FieldByName('ORD_DTABAI').IsNull;
  End;
end;

procedure TfrmManOrdProIndustrial.btnAtualProdAcabadoClick(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmAdicionaProdutoAcabado, frmAdicionaProdutoAcabado);

  frmAdicionaProdutoAcabado.cxgItensView.DataController.DataSource:=
     objOrdInd.fRetDataSourceProdAcabNaoInclusosOPI(dbeCodIte.Text, dbeCodCor.Text);

  frmAdicionaProdutoAcabado.ShowModal;
  If frmAdicionaProdutoAcabado.ModalResult = MrOK Then
  Begin

    frmAdicionaProdutoAcabado.cxgItensView.DataController.DataSource.DataSet.First;

    while Not(frmAdicionaProdutoAcabado.cxgItensView.DataController.DataSource.DataSet.Eof) do
    Begin

      If frmAdicionaProdutoAcabado.cxgItensView.DataController.DataSource.DataSet.FieldByName('MARDES').AsString = 'M' Then
      Begin
        objOrdInd.pSalvaProdAcabadoNaoIncluso(frmAdicionaProdutoAcabado.cxgItensView.DataController.DataSource.DataSet);
      End;

      frmAdicionaProdutoAcabado.cxgItensView.DataController.DataSource.DataSet.Next;

    End;

  End;

  FreeAndNil(frmAdicionaProdutoAcabado);

end;

procedure TfrmManOrdProIndustrial.pDesabilitaCod;
begin
  blnMudarFoco := False;
  pHabilitaCodigo(dbeCodIte, dbeDtaPre, False);
  pHabilitaCodigo(dbeCodCor, dbeDtaPre, False);
end;

procedure TfrmManOrdProIndustrial.pExcluirAnalise(strAutoincrem: String);
  Var
    qryConsulta : TUniQuery;
begin
  qryConsulta := fCriaQuery(Self);
  Try
    qryConsulta.SQL.Text := 'DELETE FROM ANAGER WHERE GER_SEQOPI = "' + strAutoincrem + '"';
    qryConsulta.ExecSQL;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmManOrdProIndustrial.btnCancelaClick(Sender: TObject);
begin
  inherited;

  objOrdInd.pCancela;
  objOrdInd.fCarregaItens(qryTabela.FieldByName('AUTOINCREM').AsString,
                          qryTabela.FieldByName('ORD_CODITE').AsString,
                          qryTabela.FieldByName('ORD_CODCOR').AsString);
  pCarregaDadosAdicionais;

  dbeCodIte.Color := clWindow;
  dbeCodCor.Color := clWindow;

  pHabilitaItens(False);

  pAlteraStatusBotoes(True);

end;

procedure TfrmManOrdProIndustrial.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  objOrdInd.objFasesOP.pMarcaTodas(False);
end;

procedure TfrmManOrdProIndustrial.btnEtiquetasClick(Sender: TObject);
var
  frmOrdProIndustrialEtq: TfrmOrdProIndustrialEtq;
begin
  inherited;
  if not btnEtiquetas.Enabled then
    exit;

  pCriarFormularios(TfrmOrdProIndustrialEtq, frmOrdProIndustrialEtq);
  Try
    if not qryTabela.IsEmpty then
    begin
      frmOrdProIndustrialEtq.mskNumLot.Text := FormatDateTime('ddmmyy', qryTabela.FieldByName('ORD_DTACAD').AsDateTime) +qryTabela.FieldByName('ORD_CODORD').AsString;
      frmOrdProIndustrialEtq.fBuscaOP;
    end;

    frmOrdProIndustrialEtq.ShowModal;
  Finally
    FreeAndNil(frmOrdProIndustrialEtq);
  End;
end;

procedure TfrmManOrdProIndustrial.btnExcluirClick(Sender: TObject);
  Var
    strOrdPro: String;
    blnExcluiAnalise: Boolean;
    qryCorrecoesReserva: TUniQuery;
begin
  Try
    strLocalErro := PME_MAN_ORD_PRO_INDUSTRIAL;

    if not fVerificaAcessoSistema('EXCOPI') then
    begin
      fMensagem('AVISO', 'Operador sem direito de acesso para excluir ordem de produção!', ['&Ok']);
      exit;
    end;

    If qryTabela.IsEmpty Then
    Begin
      fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
      Exit;
    End;

    If objOrdInd.fExisteNivelInferior(qryTabela.FieldByName('AUTOINCREM').AsString) Then
    Begin
      fMensagem('AVISO', 'Não é possível excluir uma ordem de produção que contenha Ordens Dependentes!', ['&Ok']);
      Exit;
    End;

    If Not qryTabela.FieldByName('ORD_DTABAI').IsNull  Then
    Begin
      pMensagemOk('A Ordem de Produção já está baixada e não pode ser excluida!');
      Exit;
    End;

    blnExcluiAnalise := False;
    If fTemAnalises(qryTabela.FieldByName('AUTOINCREM').AsString) Then
    Begin
      If Not fPergunta('Foi encontrado análise atrelada a esta ordem, deseja excluir?') Then
        Exit
      Else
        blnExcluiAnalise:= True;
    End;



    blnExcluiu := False;

    //fStartTransaction;
    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

    If blnExcluiAnalise Then
      pExcluirAnalise(qryTabela.FieldByName('AUTOINCREM').AsString);
    strOrdPro := qryTabela.FieldByName('AUTOINCREM').AsString;
    objOrdInd.fLiberaVinculoPedidosAgrupados(strOrdPro);

    qryCorrecoesReserva := fCriaQuery;
    Try
      qryCorrecoesReserva.SQL.Add('SELECT FDO_CODITE,  FDO_SEQGER  FROM RESCOR');
      qryCorrecoesReserva.SQL.Add('INNER JOIN FATDOR ON FATDOR.AUTOINCREM = RESCOR.COR_SEQFDO');
      qryCorrecoesReserva.SQL.Add(' WHERE COR_SEQORD = "'+qryTabela.FieldByName('AUTOINCREM').AsString+'"');
      qryCorrecoesReserva.Open;
 
      inherited;

      If blnExcluiu Then
      Begin
        If fCfgSis('CORROP', varString) = 'N' Then
          TOrdProIndCorrecoes.fExluiReservaCorrecao(strOrdPro, qryCorrecoesReserva);
        objOrdInd.pApagaReservaOP(strOrdPro);
        fCommit;
      End Else
      Begin
        fRollBack;
      End;
    Finally
      FreeAndNil(qryCorrecoesReserva);
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmManOrdProIndustrial.btnExcluirClick]');
    End;
  End;

  If qryTabela.Active Then
    qryTabela.Close;

  objOrdInd.fCarregaItens('', '', '');
  pCarregaDadosAdicionais;
  pHabilitaItens(False);
  LimpaOBSProcedimentoProducao;

  strLocalErro := '';

end;

procedure TfrmManOrdProIndustrial.btnFormulasClick(Sender: TObject);
  Var
    arrSel : TConsultasArray;
    chrKey : Char;
    objFrmPnl: TPanelCxFormula;
    blnResult : Boolean;
begin
  if fEmptyStr(dbeCodIte.Text) or fEmptyStr(dbeCodCor.Text) Then
  Begin
    fMensagem('', 'Carregue uma fórmula para visualizar todas as demais fórmulas disponíveis!', ['&OK']);
    Exit;
  End;

  objFrmPnl := TPanelCxFormula.Create(TfrmPnlDadosFormula);
  objFrmPnl.blnHabilitaCadastro := fVerificaAcessoSistema('frmCadEstruturasIndustrial');
  chrKey := '/';
  If fPesqEstruturaIndustrial(Self, nil, nil, chrKey, arrSel, True, 'Consulta de Fórmulas', objFrmPnl, dbeCodIte.Text, dbeCodCor.Text) Then
  Begin
    pCarregaOrdemDeProducao(blnResult);
  End;

end;

function TfrmManOrdProIndustrial.fValidaFormula : boolean;
begin
  Result := True;
  if Not objOrdInd.fTemFormula(dbeCodIte.Text, dbeCodCor.Text) then
  Begin
    pMensagemOk('Não é possível incluir uma ordem de produção, pois não há nenhuma fórmula ativa para o produto ' + dbeCodIte.Text + ' - ' + fRetNomProduto(dbeCodIte.Text));
    result := false;
    Exit;
  End;

  if objOrdInd.fRetornaPesoRealFormula(dbeCodIte.Text, dbeCodCor.Text) <= 0 then
  begin
    pMensagemOk('Não é possível incluir uma ordem de produção, pois o Peso Real não foi definido na fórmula ativa para o produto ' + dbeCodIte.Text + ' - ' + fRetNomProduto(dbeCodIte.Text));
    result := false;
    Exit;
  end;
end;

procedure TfrmManOrdProIndustrial.LimpaOBSProcedimentoProducao;
begin
  RichDescProcProducao.Clear;
end;

procedure TfrmManOrdProIndustrial.btnGirEstoqueClick(Sender: TObject);
begin
  inherited;
  If Assigned(prcExecutaRelatorio) Then
    prcExecutaRelatorio(409, 3685, [3685], ['TIPGIR'], ['12 meses'], Sender, nil);
end;

procedure TfrmManOrdProIndustrial.btnGravarClick(Sender: TObject);
Var
  I: Integer;
  strDesPro: String;
  qryConsExt: TUniQuery;
  blnSalvouDadosOPI: Boolean;
  frmOrdProIndustrialEtq: TfrmOrdProIndustrialEtq;
begin
  If not fValidaPanel(pnlCapacidadeMaxima, False) then
    Exit;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  //se for uma op nova, verifica se existe uma fórmula ativa.
  if fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) and (not fValidaFormula) then
    exit;


  Try
    SetLength(FarrSubOP,0);
    SetLength(FarrQryTabela,0);

    cxgItensView.DataController.Filter.Clear;
    pFiltraProdAcab;

    If Not qryTabela.FieldByName('ORD_DTABAI').IsNull Then
    Begin
      Try
        fStartTransaction;
        If fEmptyStr(memHisBai.Texto) Then
          fExecutaSQL('DELETE FROM ORDHIS WHERE ORD_SEQGER = ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString))
        Else
          fExecutaSQL('REPLACE INTO ORDHIS(AUTOINCREM, ORD_SEQGER, ORD_HISTOR) VALUES(' +
                      QuotedStr(fRetAutoIncrem('ORDHIS', VS_strCodEmp)) + ', ' +
                      QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString) + ', ' +
                      QuotedStr(memHisBai.Texto) + ') ') ;

        fCommit;
        pAlteraStatusBotoes(True);
        Exit;
      Except
        On E : Exception Do
        Begin
          fRollBack;
          pMensagensErro(E.Message, 'TfrmManOrdProIndustrial.btnGravarClick');
        End;
      End;
    End;

    If objOrdInd.State = dsEdit Then
      objOrdInd.Post;

    If Not objOrdInd.objFasesOP.fTemFase Then
    Begin
      pgcDados.ActivePage := tbsFases;
      pMensagemOk('Informe as Fases da Ordem de Produção!');
      Exit;
    End;

    If Not objOrdInd.fVerificaQuantidadeEstoque(qryTabela) Then
      Exit;

    if fUsaRotinaWMS then
    begin
      if objOrdInd.fVerificaExisteItemFormulaSemLote then
        exit;
    end;

    //exibe os custos que serão alterados
    If qryTabela.State = dsEdit then
      objOrdInd.pVerificaCusto;

    strDesPro:= '';

    If RichDescProcProducao.Lines.Count > 0 Then
    Begin
      for I := 0 to RichDescProcProducao.Lines.Count - 1 do
      Begin
        strDesPro:= strDesPro + RichDescProcProducao.Lines[I];
      End;
    End;

    //fStartTransaction;
    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

    If qryTabela.State = dsInsert Then
    Begin
      qryTabela.FieldByName('ORD_HORCAD').AsDateTime := fTime();
      qryTabela.FieldByName('ORD_FORMUL').AsInteger  := fRetFormulAtiva(qryTabela.FieldByName('ORD_CODITE').AsString,
                                                                        qryTabela.FieldByName('ORD_CODCOR').AsString);
      qryTabela.FieldByName('ORD_OBSPRO').AsString:= strDesPro;
    End
    Else
    Begin
      objOrdInd.pDeletaFilhas(qryTabela.FieldByName('AUTOINCREM').AsString);
      qryTabela.FieldByName('ORD_OBSPRO').AsString:= strDesPro;
    End;

    If fCfgSis('EXMOPI', varBoolean) And (qryTabela.State = DsInsert) Then
    Begin
      qryConsExt:= fCriaQuery;
      Try

        qryConsExt.Close;
        qryConsExt.SQL.Clear;
        qryConsExt.SQL.Add(' SELECT GMT_OPEEXT, GMT_OBSEXT, GMT_HREXIN, '+
                           '        GMT_HREXFN, GMT_ROSCA_, GMT_VELPIC  '+
                           ' FROM GEIMAT                                '+
                           '   WHERE GMT_CODEMP = :CODEMP AND           '+
                           '         GMT_CODITE = :CODITE AND           '+
                           '         GMT_CODCOR = :CODCOR AND           '+
                           '         GMT_STATUS = "A"                   ');

        qryConsExt.ParamByName('CODEMP').AsString:= VS_strCodEmp;
        qryConsExt.ParamByName('CODITE').AsString:= qryTabela.FieldByName('ORD_CODITE').AsString;
        qryConsExt.ParamByName('CODCOR').AsString:= qryTabela.FieldByName('ORD_CODCOR').AsString;
        qryConsExt.Open;


        qryTabela.FieldByName('ORD_OPEEXT').AsString   := qryConsExt.FieldByName('GMT_OPEEXT').AsString;
        qryTabela.FieldByName('ORD_OBSEXT').AsString   := qryConsExt.FieldByName('GMT_OBSEXT').AsString;
        qryTabela.FieldByName('ORD_HREXIN').Value      := qryConsExt.FieldByName('GMT_HREXIN').Value;
        qryTabela.FieldByName('ORD_HREXFN').Value      := qryConsExt.FieldByName('GMT_HREXFN').Value;
        qryTabela.FieldByName('ORD_ROSCA_').AsString   := qryConsExt.FieldByName('GMT_ROSCA_').AsString;
        qryTabela.FieldByName('ORD_VELPIC').AsString   := qryConsExt.FieldByName('GMT_VELPIC').AsString;
      Finally
        FreeAndNil(qryConsExt);
      End;

    End;

    inherited;

    If objOrdInd.blnGeraOpSubProdutos Then
      objOrdInd.fVerificaQuantidadeEstoque(qryTabela, True);

    blnSalvouDadosOPI:= objOrdInd.fSalvaItens(qryTabela, True,fCfgSis('CORROP', varString) = 'N');

    blnSalvouDadosOPI:= blnSalvouDadosOPI And objOrdInd.fSalvaOrdMat(qryTabela.FieldByName('AUTOINCREM').AsString);

    If blnGravou And blnSalvouDadosOPI Then
    Begin

      If fCfgSis('EXMOPI', varBoolean) Then
      Begin

        If Not(fExisteProcessoExtrusao(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
        Begin

          If Not(fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString)) And
            (Not fEmptyStr(qryTabela.FieldByName('ORD_CODITE').AsString)) And
            (Not fEmptyStr(qryTabela.FieldByName('ORD_CODCOR').AsString)) Then
          Begin

            objOrdInd.pGravaOrdExt(qryTabela.FieldByName('ORD_CODITE').AsString,
                                   qryTabela.FieldByName('ORD_CODCOR').AsString,
                                   qryTabela.FieldByName('AUTOINCREM').AsString);

          End;

        End

      End;

      fCommit;

      objOrdInd.fCarregaItens(qryTabela.FieldByName('AUTOINCREM').AsString,
                              qryTabela.FieldByName('ORD_CODITE').AsString,
                              qryTabela.FieldByName('ORD_CODCOR').AsString);

      objOrdInd.pAbrirCdsFormula;

      pHabilitaItens(False);
      SetLength(FarrSubOP,0);
      SetLength(FarrQryTabela,0);

      If fAgrLot Then Begin
        Try
          qryTabela.First;
          qryTabela.DisableControls;
          qryTabela.AfterScroll := Nil;

          pCriarFormularios(TfrmOrdProIndustrialImprimeLotes, frmOrdProIndustrialImprimeLotes);

          While Not qryTabela.Eof Do Begin
            objOrdInd.pCarregaProdutosFormula_Composicao(qryTabela.FieldByName('ORD_CODITE').AsString,
                                                         qryTabela.FieldByName('ORD_CODCOR').AsString);
            objOrdInd.pCalculaQuantidadesUsadas;
            objOrdInd.fSelecionaLotesReserva;
            frmOrdProIndustrialImprimeLotes.pAddItens(objOrdInd.arrLotes, qryTabela.FieldByName('ORD_CODITE').AsString);

            qryTabela.Next;
          End;

          frmOrdProIndustrialImprimeLotes.pExibeRelatorio;

        Finally
          qryTabela.First;
          qryTabela.EnableControls;
          FreeAndNil(frmOrdProIndustrialImprimeLotes);
        End;
      End;

      If fCfgSis('TAIOPI', varBoolean) Then
      Begin
        If fPergunta('Deseja imprimir a Ordem de Produção?') Then
          btnImprimir.Click;
      End
      Else
        btnImprimir.Click;


      If fCfgSis('ATEOPI', varBoolean) Then
      Begin
        If fPergunta('Deseja imprimir a Etiqueta?') Then
        Begin
          Try

            pCriarFormularios(TfrmOrdProIndustrialEtq, frmOrdProIndustrialEtq);
            frmOrdProIndustrialEtq.mskNumLot.Text := FormatDateTime('DDMMYY', qryTabela.FieldByName('ORD_DTACAD').AsDateTime) +
                                                     qryTabela.FieldByName('ORD_CODORD').AsString; //180522-006;
            frmOrdProIndustrialEtq.mskNumLotExit(Nil);
            frmOrdProIndustrialEtq.Showmodal;

          Finally
            FreeAndNil(frmOrdProIndustrialEtq);
          End;
        End;
      End;

      pAlteraStatusBotoes(True);
    End
    Else
    Begin
      fRollBack;
      btnCancela.Click;
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmManOrdProIndustrial.btnGravarClick]');
    End;
  End;

end;

function TfrmManOrdProIndustrial.fExisteProcessoExtrusao(strSeqGer: String): Boolean;
Var
  qryConsulta: TUniQuery;
Begin
  qryConsulta:= fCriaQuery;
  Try
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT * FROM ORDEXT WHERE EXT_SEQGER = :SEQGER');
    qryConsulta.ParamByName('SEQGER').AsString:= strSeqGer;
    qryConsulta.Open;

    result:= Not(qryConsulta.IsEmpty);

  Finally
    FreeAndNil(qryConsulta);
  End;
End;


procedure TfrmManOrdProIndustrial.btnImprimirClick(Sender: TObject);
  Var
    objOrdImp: TOrdProIndustrial;
    stlImprime : TStringList;
    intIndex : Integer;
begin
  inherited;
  stlImprime := TfrmExibeArvoreOP.fSelectOpImpressao(qryTabela.FieldByName('ORD_CODORD').AsString, qryTabela.FieldByName('ORD_DTACAD').AsDateTime );

  If (not Assigned(stlImprime)) or (stlImprime.Count < 1) Then
    Exit;

  objOrdImp :=  TOrdProIndustrial.Create(Self);

  For intIndex := 0 to stlImprime.Count -1 do
    objOrdImp.pImprimessaoOP(stlImprime[intIndex]);

  FreeAndNil(objOrdImp);

end;

procedure TfrmManOrdProIndustrial.pAlteraStatusBotoes(blnModoNavegacao : boolean);
begin
  btnIncluir.Enabled  := blnModoNavegacao;
  btnGravar.Enabled   := not blnModoNavegacao;
  btnCancela.Enabled  := not blnModoNavegacao;
  btnAlterar.Enabled  := blnModoNavegacao;
  btnExcluir.Enabled  := blnModoNavegacao;
  btnPesquisa.Enabled := blnModoNavegacao;
  btnImprimir.Enabled := blnModoNavegacao;
  btnEtiquetas.Enabled := blnModoNavegacao;
  btnFormulas.Enabled  := not blnModoNavegacao;

  if (not blnModoNavegacao) Then
    memHisBai.ReadOnly := (not fVerificaAcessoSistema('HISBAI', strLoginUsuarioLogado))
  Else
    memHisBai.ReadOnly := True;

  btnAtualProdAcabado.Enabled  := not blnModoNavegacao;

  if blnModoNavegacao then
    pSetFocus(btnIncluir)
  else
    pSetFocus(btnPesquisa);
end;

procedure TfrmManOrdProIndustrial.btnIncluirClick(Sender: TObject);
begin
  inherited;
  LimpaOBSProcedimentoProducao;
  pAlteraStatusBotoes(False);

  pHabilitaCodigo(dbeCodIte, dbeCodIte, True);

  qryTabela.FieldByName('ORD_DTACAD').AsDateTime := VS_Date;
  qryTabela.FieldByName('ORD_QTDPAR').AsInteger  := 1;
  qryTabela.FieldByName('ORD_CODOPE').AsString   := strLoginUsuarioLogado;
  qryTabela.FieldByName('ORD_UQDMAX').AsString   := fCfgSis('PCAMAX', varString);

  objOrdInd.fCarregaItens(qryTabela.FieldByName('AUTOINCREM').AsString,
                          qryTabela.FieldByName('ORD_CODITE').AsString,
                          qryTabela.FieldByName('ORD_CODCOR').AsString);

  pCarregaDadosAdicionais;

  pHabilitaItens;

  objOrdInd.statusOPI := stInserindoOPI;
end;

procedure TfrmManOrdProIndustrial.btnLoteMPClick(Sender: TObject);
begin
  inherited;

  if ( not qryTabela.Active) Or (qryTabela.IsEmpty) Then
  Begin
    fMensagem('','Nenhum registro selecionado!', ['&OK'] );
    Exit;
  End;

  if ( qryTabela.State in dsEditModes)Then
  Begin
    fMensagem('','Grave o registro para efetuar a manutenção dos lotes!', ['&OK'] );
    Exit;
  End;

  TfrmManOrdProIndustrialLotesMP.pManutencaoLotesMP(qryTabela.FieldByName('AUTOINCREM').AsString);

end;

procedure TfrmManOrdProIndustrial.pHabilitaFases(blnHabilita: Boolean);
Begin
  cxgCadFas.Enabled        := blnHabilita;
  btnDesmarcaTodos.Enabled := blnHabilita;
  btnMarcaTodos.Enabled    := blnHabilita;

  pChecaOperacoes;
End;

procedure TfrmManOrdProIndustrial.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;

  objOrdInd.objFasesOP.pMarcaTodas(True);
end;

procedure TfrmManOrdProIndustrial.btnPesquisaClick(Sender: TObject);
  Var
    arrTabela : TConsultasArray;
    chrKey   : Char;
    objFrmPnl: TPanelCxOPI;
begin
  inherited;
  chrKey := '/';

  objfrmPnl := TPanelCxOPI.New();
  Try
    If fPesqOrdProIndustrial(Self, Nil, Nil, qryTabela, chrKey, arrTabela, poiCodigo, True, staTodas, '', '', '', '', '', False, objFrmPnl) Then
    Begin
      objOrdInd.fCarregaItens(qryTabela.FieldByName('AUTOINCREM').AsString,
                              qryTabela.FieldByName('ORD_CODITE').AsString,
                              qryTabela.FieldByName('ORD_CODCOR').AsString);

      pCarregaDadosAdicionais;

      pSetFocus(btnAlterar);
    End;
  Finally
    FreeAndNil(objfrmPnl);
  End;
end;

procedure TfrmManOrdProIndustrial.cxgItensCOMPOSICAOPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  If not qryTabela.FieldByName('ORD_DTABAI').IsNull then
  begin
    pMensagemOk('Não é possível alterar a composição de uma ordem de produção baixada');
    exit;
  end;

  objOrdInd.pTrocaComposicaoBaixa;
end;

procedure TfrmManOrdProIndustrial.cxgItensEnter(Sender: TObject);
begin
  inherited;

  If cxgItens.Enabled Then
    cxgItensQTDPRO.Focused := True;
end;

procedure TfrmManOrdProIndustrial.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if AViewInfo.Item = cxgItensQTDPRO then
  begin
    ACanvas.Brush.Color := $00CCFFFF;
    ACanvas.Font.Color  := clWindowText;
  end;
end;

procedure TfrmManOrdProIndustrial.cxgItensViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  cxgItensViewKeyDown(Sender, Key, Shift);
end;

procedure TfrmManOrdProIndustrial.cxgItensViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F1: cxgItensCOMPOSICAOPropertiesButtonClick(cxgItensCOMPOSICAO, 0);
  end;
end;

procedure TfrmManOrdProIndustrial.pHabilitaItens(blnHabilita: Boolean = True);
Begin
  cxgItens.Enabled := blnHabilita;
  pHabilitaFases(blnHabilita);
End;

procedure TfrmManOrdProIndustrial.dbeCodCorKeyPress(Sender: TObject;
  var Key: Char);
   Var
     arrCor: TConsultasArray;
begin
  inherited;

  If fPesqCores(Self, dbeCodCor, edtDesCor, Nil, Key, arrCor, True, dbeCodIte.Text) Then
  Begin
    fValidaCampos(dbeCodCor, True);
  End;

end;

procedure TfrmManOrdProIndustrial.dbeCodIteKeyPress(Sender: TObject;
  var Key: Char);
   Var
     arrProduto: TConsultasArray;
begin
  inherited;

  If fPesqItem(conIteSimples,
               Self,
               dbeCodIte,
               edtDesIte,
               nil,
               Key,
               arrProduto,
               True,
               nil,
               'Consulta de Itens',
               '1',
               '',
               0,
               False,
               False,
               0,
               cdrCodIte,
               '',
               False,
               '',
               '',
               True,
               False,
               False,
               '',
               False,
               False,
               False,
               True) {Departamento produto granel cadestruturaindustrial} Then
  Begin
    If fValidaCampos(dbeCodIte, True) then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmManOrdProIndustrial.dbgOrdMatDrawColumnCell(Sender: TObject;
  const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If cdsFormul.FieldByName('TIPOMP').AsString = 'COR' Then
  Begin
    TDBGridCitel(Sender).Canvas.Brush.Color := shpCorrecao.Brush.Color;
    TDBGridCitel(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;

end;

procedure TfrmManOrdProindustrial.pSetLocFis;
Begin
  If qryTabela.Active Then
  Begin
    imgLocFis.Visible    := Not fEmptyStr(qryTabela.FieldByName('ORD_LOCORP').AsString);
    lblTitLocFis.Visible := Not fEmptyStr(qryTabela.FieldByName('ORD_LOCORP').AsString);
    lblLocFis.Visible    := Not fEmptyStr(qryTabela.FieldByName('ORD_LOCORP').AsString);
  End
  Else
  Begin
    imgLocFis.Visible    := False;
    lblTitLocFis.Visible := False;
    lblLocFis.Visible    := False;
  End;

  If lblLocFis.Visible Then
  Begin
    lblLocFis.Caption := qryTabela.FieldByName('ORD_LOCORP').AsString + ' - ' +
                         fRetNomeLocFisAmostraProducao(qryTabela.FieldByName('ORD_LOCORP').AsString);

   pnlBaixa.Height := 75;
  End
  Else
   pnlBaixa.Height := 40;
End;

procedure TfrmManOrdProIndustrial.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela     := 'ORDGER';
  strNomeCampo      := 'ORD_CODORD';
  qryTabela         := fCriaQuery(Self);
  qryTabela.AfterOpen := pQryTabelaAfterOpen;
  dtsTabela.DataSet   := qryTabela;


  SetLength(arrCamposChave, 2 );
  arrCamposChave[0] := dbeCodOrd;
  arrCamposChave[1] := dbeDtaCad;

  objOrdInd := TOrdProIndustrial.Create(Self, dbeVolume, dbePeso);
  objOrdInd.chbUsaCapacidadeMaxima := Self.chbUsaCapacidadeMaxima;

  cxgItensView.DataController.DataSource := objOrdInd.dtsSource;

  dbgEnvasados.DataSource := objOrdInd.dtsSource;

  if not objOrdInd.blnUsaCapacidadeMaxima then
  begin
    pnlCapacidadeMaxima.Visible := False;
    cxgItensCAPMAX.Visible  := False;
  end;

  pHabilitaItens(False);
  pAlteraStatusBotoes(True);

  pgcDados.ActivePage := tbsGeral;

  cdsFormul := TZClient.Create(Self, fGetSQLFormulaBaixa);
  dbgOrdMat.DataSource := cdsFormul.dtsSource;
  dbeCusFor.DataSource := cdsFormul.dtsSource;
  cdsFormul.pCriaSoma('TOTCUS', 'SUM_TOTCUS');

  cxgCadFasView.DataController.DataSource := objOrdInd.objFasesOP.dtsSource;

  pHabilitaFases(False);

  lblDtaVal.Visible := fCfgSis('VALIND', varBoolean);
  dbeDtaVAl.Visible := lblDtaVal.Visible;

  objOrdInd.cdsFormulas := cdsFormul;
end;

procedure TfrmManOrdProIndustrial.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If fCheckParent(ActiveControl, cxgItens) And
                  (objOrdInd.State = dsEdit) And cxgItensQTDPRO.Focused Then
                 Begin
                   cxgItensView.NavigatorButtons.Next.Click;
                   If (objOrdInd.State = dsEdit) Then
                   Begin
                     objOrdInd.Post;
                    pSetFocus(btnGravar);
                   End;
                 End;
    VK_F3 : If btnEtiquetas.Enabled Then
              btnEtiquetas.Click;
    VK_F4 : If btnFormulas.Enabled Then
              btnFormulas.Click;
  End;

end;

procedure TfrmManOrdProIndustrial.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  Case Key Of
    '-': Key := #0;
  End;

end;

procedure TfrmManOrdProIndustrial.FormShow(Sender: TObject);
begin
  inherited;

  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  btnLoteMP.Visible     := (fCfgSis('MDORIN', varInteger) =  3);
  btnGirEstoque.Visible := (fCfgSis('METGIR', varInteger) <> 2);

  pSetaCodIte( dbeCodIte );

end;

function TfrmManOrdProIndustrial.fTemAnalises(strAutoincrem: String): Boolean;
  Var
    qryConsulta : TUniQuery;
begin
  qryConsulta := fCriaQuery(Self);
  Try
    qryConsulta.SQL.Text := 'SELECT COUNT(1) AS QTD FROM ANAGER WHERE GER_SEQOPI = "' + strAutoincrem + '"';
    qryConsulta.Open;
    Result := qryConsulta.FieldByname('QTD').AsInteger > 0;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TfrmManOrdProIndustrial.fTemOrdemProducaoEmAberto: Boolean;
  Var
    qryConsulta : TUniQuery;
begin
  qryConsulta := fCriaQuery(Self);
  With qryConsulta, SQL Do
  Begin
    Add(' SELECT *                   ');
    Add(' FROM ORDGER                ');
    Add(' WHERE ORD_CODITE = :CODITE ');
    Add('   AND ORD_CODCOR = :CODCOR ');
    Add('   AND ORD_CODEMP = :CODEMP ');
    Add('   AND ORD_DTABAI IS NULL   ');

    ParamByName('CODITE').AsString := dbeCodIte.Text;
    ParamByName('CODCOR').AsString := dbeCodCor.Text;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    Result := not isEmpty;

  End;

end;

procedure TfrmManOrdProIndustrial.pFiltraProdAcab;
begin
  cxgItensView.DataController.Filter.BeginUpdate;
  try
    cxgItensView.DataController.Filter.RemoveItemByItemLink(cxgItensView.DataController.GetItemByFieldName('ITE_CODPAG'));
    if not fEmptyStr(dbeCodIte.Text) then
      cxgItensView.DataController.Filter.Root.AddItem(cxgItensITE_CODPAG,  foEqual, dbeCodIte.Text, dbeCodIte.Text);
  finally
    cxgItensView.DataController.Filter.EndUpdate;
  end;
  cxgItensView.DataController.Filter.Active := True;
end;

function TfrmManOrdProIndustrial.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    intOpcao  : Integer;
    arrTabela : TConsultasArray;
    chrKey    : Char;
    strCodIte : String;
    strCodCor : String;
begin
  Result    := True;

  If Not pnlCabec.Enabled Then
    Exit;
    
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodIte) Then
    Begin

      If qryTabela.State = dsInsert Then
      Begin

        If fEmptyStr(dbeCodIte.Text) Then
        Begin
          Result := False;
          pMensagemOk('Informe o Código do Produto!');
        End

        Else If (fCampoTabela('ITE_CODDEP', 'CADITE', ['ITE_CODITE'], [dbeCodIte.Text]) <>
                 fRetTipoDepartamento((fCampoTabela('ITE_CODDEP', 'CADITE', ['ITE_CODITE'], [dbeCodIte.Text])), 'PROGRA')) Then
        Begin
          Result := False;
          pMensagemOk('Esse produto não é A Granel!');
        End

        Else If Not(IsItemAtivo(dbeCodIte.Text)) Then
        Begin
          Result := False;
          pMensagemOk('Não é permitido inserir um item a granel inativo!');
        End

        Else
        Begin

          edtDesIte.Text := fRetNomProduto(dbeCodIte.Text);
          If fEmptyStr(edtDesIte.Text) Then
          Begin
            Result := False;
            pMensagemOk('Produto não encontrado!');
          End

          Else begin
            pFiltraProdAcab;

            If blnBuscaPorChave Then
              objOrdInd.pCarregaTipoProducao(dbeCodIte.Text);
          end;

        End;

      End;

    End

    Else If (Sender = dbeCodCor) Then
    Begin

      If fEmptyStr(dbeCodCor.Text) Then
      Begin
        Result := False;
        pMensagemOk('Informe o Código do Cor!');
      End Else
      Begin
        edtDesCor.Text := fRetNomCor(dbeCodCor.Text);

        If fEmptyStr(edtDesCor.Text) Then
        Begin
          Result := False;
          pMensagemOk('Cor não encontrada!');
        End

        Else If blnBuscaPorChave And (qryTabela.State = dsInsert) And
                objOrdInd.IsEmpty And fValidaCampos(dbeCodIte, True) Then
        Begin

          If fTemOrdemProducaoEmAberto Then
          Begin
            intOpcao := fMensagem('','Existe Ordem de Producao em aberto para este produto. Informe a opção desejada:',
                                     ['Carregar O.P.', 'Nova O. P.', 'Cancelar'],1);

            Case intOpcao of
              1: Begin
                   strCodIte := dbeCodIte.Text;
                   strCodCor := dbeCodCor.Text;

                   btnCancelaClick(btnCancela);

                   chrKey := '/';
                   If fPesqOrdProIndustrial(Self, Nil, Nil, qryTabela, chrKey, arrTabela, poiCodigo, True, staAbertas,
                                            strCodIte,
                                            strCodCor) Then
                   Begin
                     objOrdInd.fCarregaItens(qryTabela.FieldByName('AUTOINCREM').AsString,
                                                       qryTabela.FieldByName('ORD_CODITE').AsString,
                                                       qryTabela.FieldByName('ORD_CODCOR').AsString);

                       pCarregaDadosAdicionais;

                       pSetFocus(btnAlterar);

                   End;

                   Exit;
                 End;

              2: Begin
                   if not fValidaformula then
                   begin
                     Result := False;
                     Exit;
                   end
                   else if fCfgSis('PREMOP', varString) = '2' then
                     qryTabela.FieldByName('ORD_DTAPRE').AsDateTime := VS_Date;

                   pDesabilitaCod;
                 end;

              3: Begin
                   pLimpaDados;
                   Result := False;
                   Exit;
                 End;
            End;
          End;
           pCarregaOrdemDeProducao(Result);

        End;

      End;

    End

    Else If (Sender = dbeDtaPre) Then
    Begin

      If fEmptyDate(dbeDtaPre.Text) Then
      Begin
        Result := False;
        pMensagemOk('Informe a Data de Previsão da OP!');
      End

      Else If StrToDateDef(dbeDtaPre.Text, 0) <  dbeDtaCad.Field.Value Then
      Begin
        Result := False;
        pMensagemOk('A Data de Previsão deve ser maior ou igual a Data de Cadastro!');
      End

      Else
        If blnBuscaPorChave Then
          qryTabela.FieldByName('ORD_DTAVAL').AsDateTime := IncMonth(StrToDateDef(dbeDtaPre.Text, 0), fCampoTabela('ITE_PRAVAL', 'CADITE', ['ITE_CODITE'], [dbeCodIte.Text]));

    End

    Else If (Sender = dbeDtaVal) and dbeDtaVAl.Visible Then
    Begin
      If not fEmptyDate(dbeDtaVal.Text) Then
      Begin
        If StrToDateDef(dbeDtaVal.Text, 0) < VS_Date Then
        Begin
          pMensagemOk('Data de Validade Menor que a Data Atual!');
          Result := False;
        End;
      end;
    End

    Else If (Sender = dbeDtaVal) Then
    Begin
      If not fEmptyDate(dbeDtaVal.Text) Then
      Begin
        If StrToDateDef(dbeDtaVal.Text, 0) < VS_Date Then
        Begin
          pMensagemOk('Data de Validade Menor que a Data Atual!');
          Result := False;
        End;
      end;
    End

    Else If ((Sender = dbeCapacidadeMaxima) or (Sender = chbUsaCapacidadeMaxima)) and (pnlCapacidadeMaxima.Visible) And Assigned(dbePeso.DataSource) Then
    Begin
      if chbUsaCapacidadeMaxima.Checked Then
      Begin
        If Assigned(dbeCapacidadeMaxima.Field) Then
        Begin
          If dbeCapacidadeMaxima.Field.AsFloat > 0 Then
            Result := dbeCapacidadeMaxima.Field.AsFloat >= fDoubleAggregate(TUniClientDataSet(dbePeso.DataSource.DataSet),dbePeso.Field.FieldName);
        End;
        If Not Result Then
        Begin
          fMensagem('', 'A capacidade máxima não pode ser menor que o total de quilos a ser envasado!', ['&OK']);
          Sender := dbeCapacidadeMaxima;
        End;
      End;
    End;

  End;

  If Not Result Then
  begin
    if blnMudarFoco then
    begin
      blnMudarFoco := False;
      pSetFocus(Sender);
    end;
  end;
end;

procedure TfrmManOrdProIndustrial.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
end;

procedure TfrmManOrdProIndustrial.pLimpaDados;
begin
  dbeCodIte.Enabled := True;
  dbeCodCor.Enabled := True;
  dbeCodIte.Clear;
  dbeCodIte.Field.Clear;
  dbeCodCor.Clear;
  dbeCodCor.Field.Clear;
  edtDesIte.Clear;
  edtDesCor.Clear;
  dbeCodIte.Color := clWindow;
  dbeCodCor.Color := clWindow;
  objOrdInd.Close;
  blnMudarFoco := False;

  pSetFocus(dbeCodIte);
end;

procedure TfrmManOrdProIndustrial.pCarregaDadosAdicionais;
var
  objOrdemProducao : TOrdemProducao;
  fltCustoKilo     : double;
  fltCustoLitro    : double;
  fltCustoTotal    : double;
Begin
  edtDesIte.Text           := fRetNomProduto(dbeCodIte.Text);
  edtDesCor.Text           := fRetNomCor(dbeCodCor.Text);
  cxgItensView.DataController.Filter.Clear;
  pFiltraProdAcab;

  If qryTabela.Active Then
  Begin
    pnlBaixa.Visible := Not qryTabela.FieldByName('ORD_DTABAI').IsNull;
    RichDescProcProducao.Text:= qryTabela.FieldByName('ORD_OBSPRO').AsString;
    TDateField(qryTabela.FieldByName('ORD_DTAPRE')).EditMask := '99/99/9999;1;_';
    TDateField(qryTabela.FieldByName('ORD_DTAVAL')).EditMask := '99/99/9999;1;_';
    TDateField(qryTabela.FieldByName('ORD_HORINI')).DisplayFormat := 'HH:NN';
    TDateField(qryTabela.FieldByName('ORD_HORFIN')).DisplayFormat := 'HH:NN';
    TFloatField(qryTabela.FieldByName('ORD_PESREA')).DisplayFormat := fMskDigitos(2);
    TFloatField(qryTabela.FieldByName('ORD_TOTLIT')).DisplayFormat := fMskDigitos(2);
    TFloatField(qryTabela.FieldByName('ORD_TOTKIL')).DisplayFormat := fMskDigitos(2);
    TFloatField(qryTabela.FieldByName('ORD_CAPMAX')).DisplayFormat := fMskDigitos(2);

    pHabilitaBotaoProdAcabado;

  End;


  cxgItensView.NavigatorButtons.First.Click;

  pChecaOperacoes;
  pSetLocFis;

  tbsFormula.TabVisible := (qryTabela.Active) And (not qryTabela.IsEmpty);
  If tbsFormula.TabVisible Then
  Begin
    objOrdInd.strAutIncFormula := qryTabela.FieldByName('AUTOINCREM').AsString;

    If qryTabela.FieldByName('ORD_DTABAI').AsDateTime = 0 Then
      objOrdInd.statusOPI := stOPIAberta
    Else
      objOrdInd.statusOPI := stOPIBaixada;

    objOrdInd.pAbrirCdsFormula;

    edtCusLit.Text := '0,0000';
    edtCusKil.Text := '0,0000';

    If Not fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) Then
    Begin
      objOrdemProducao := fGetTOrdemProducaoFromOPJSON(qryTabela.FieldByName('AUTOINCREM').AsString);
      AtualizaCustoDaMateriaPrima(objOrdemProducao);


      fltCustoKilo := objOrdemProducao.fRetornaCustoKilo;
      fltCustoLitro:= objOrdemProducao.fRetornaCustoLitro;
      fltCustoTotal:= objOrdemProducao.fRetornaCustoTotalProducao;

      If (fltCustoLitro > 0) And (dbeTotLil.Field.AsFloat > 0) Then
      Begin
        edtCusLit.Text := FormatFloat('#,##0.0000', fltCustoLitro);
      End;

      If (fltCustoKilo > 0) And (dbeTotKil.Field.AsFloat > 0) Then
      Begin
        edtCusKil.Text := FormatFloat('#,##0.0000', fltCustoKilo);
      End;

      dbeCusFor.Text:= FormatFloat('#,##0.0000', fltCustoTotal);
    End;

    tbsHistoricoBaixa.TabVisible := (qryTabela.Active) And (not qryTabela.IsEmpty) And (qryTabela.FieldByName('ORD_DTABAI').AsDateTime > 0);
    If (tbsHistoricoBaixa.TabVisible) Then
      memHisBai.Texto := fCampoTabela('ORD_HISTOR', 'ORDHIS', ['ORD_SEQGER'], [qryTabela.FieldByName('AUTOINCREM').AsString] );
    memHisBai.ReadOnly := True;

    FreeAndNil(objOrdemProducao);
  End;
End;

procedure TfrmManOrdProIndustrial.pCarregaOrdemDeProducao(var Result: Boolean);
begin
  //se for uma op nova, verifica se existe uma fórmula ativa.
  if fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) then
  begin
    if (not fValidaFormula) then
    begin
      Result := False;
      exit;
    end
    else if objOrdInd.blnUsaCapacidadeMaxima then
      qryTabela.FieldByName('ORD_CAPMAX').AsFloat := objOrdInd.fRetCapacidadeMaximaFormula(dbeCodIte.Text, dbeCodCor.Text);
  end;

  Result := objOrdInd.fCarregaItens(qryTabela.FieldByName('AUTOINCREM').AsString,
                                    dbeCodIte.Text,
                                    dbeCodCor.Text);

  qryTabela.FieldByName('ORD_PESREA').AsFloat := objOrdInd.fltPesoReal;

  If (Not Result) Or objOrdInd.IsEmpty Then
  Begin
    pMensagemOk('Nenhum produto acabado encontrado!');
    Result := False;
  End
  else if not objOrdInd.fValidaUnidadesItens then
  begin
    Result := false;
    pLimpaDados;
  end
  Else begin
    if fCfgSis('PREMOP', varString) = '2' then
      qryTabela.FieldByName('ORD_DTAPRE').AsDateTime := VS_Date;

    pDesabilitaCod;
    cxgItensView.NavigatorButtons.First.Click;
  end;

  objOrdInd.strCodIteFormula := dbeCodIte.Text;
  objOrdInd.strCodCorFormula := dbeCodCor.Text;
  objOrdInd.pAbrirCdsFormula;
end;

function TfrmManOrdProIndustrial.fGetSQLFormulaBaixa : String;
Begin
  Result := '';
  Result := Result + ' SELECT ODM_ITESUB AS ITESUB,                            ';
  Result := Result + '        ODM_DESCRI AS DESCRI,                            ';
  Result := Result + '        IF(ODM_TIPOMP = "FOR", ODM_QTDITE, 0) AS QTDFOR, ';
  Result := Result + '        DET_QTDITE * IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) AS QTDITE, ';
  Result := Result + '        DET_TOTCUS / DET_QTDITE AS UNITAR,               ';
  Result := Result + '        DET_TOTCUS * IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) AS TOTCUS, ';
  Result := Result + '        ODM_TIPOMP AS TIPOMP,                            ';
  Result := Result + '        CASE ODM_TIPOMP                                  ';
  Result := Result + '          WHEN "FOR" THEN 0                              ';
  Result := Result + '          WHEN "COR" THEN 1                              ';
  Result := Result + '          ELSE 10                                        ';
  Result := Result + '        END AS ORD                                       ';
  Result := Result + ' FROM ORDMAT M                                           ';
  Result := Result + ' INNER JOIN MOVDET D ON D.AUTOINCREM = ODM_SEQDET        ';
  Result := Result + ' WHERE ODM_SEQGER = :AUTINC                              ';
  Result := Result + '   AND ODM_TIPOMP <> "COM"                               ';
  Result := Result + ' ORDER BY ORD                                            ';
End;

procedure TfrmManOrdProIndustrial.pChecaOperacoes;
Begin
   mmoTravaFases.Visible := qryTabela.Active And objOrdInd.objMonitor.fTemOperacaoIniciada(qryTabela.FieldByName('AUTOINCREM').AsString);
   tbsFases.Enabled := btnMarcaTodos.Enabled And (Not mmoTravaFases.Visible);
End;

procedure TfrmManOrdProIndustrial.pgcDadosChange(Sender: TObject);
begin
  inherited;

  If pgcDados.ActivePage = tbsFases Then
    pChecaOperacoes;
end;

procedure TfrmManOrdProIndustrial.pCapMaxDataChange(Sender: TField);
begin
  objOrdInd.fltCapacidadeMaxima := Sender.AsFloat;
end;

procedure TfrmManOrdProIndustrial.pQryTabelaAfterOpen(DataSet: TDataSet);
begin
  if objOrdInd.blnUsaCapacidadeMaxima then
    DataSet.FieldByName('ORD_CAPMAX').onChange := pCapMaxDataChange;
end;

procedure TfrmManOrdProIndustrial.pHabilitaBotaoProdAcabado;
begin
  If Not(fEmptyStr(dbeCodIte.Text)) And Not(fEmptyStr(dbeCodCor.Text)) Then
    btnAtualProdAcabado.Visible:= objOrdInd.fRetStatusOpi(dbeCodOrd.Text,
                                                          dbeDtaCad.Text);
end;

procedure TfrmManOrdProIndustrial.chbUsaCapacidadeMaximaClick(Sender: TObject);
begin
  inherited;
  fValidaCampos(chbUsaCapacidadeMaxima, True);
end;

end.

