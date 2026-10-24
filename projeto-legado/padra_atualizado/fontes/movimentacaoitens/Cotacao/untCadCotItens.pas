unit untCadCotItens;

interface

uses
  Windows, Classes, Controls, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask, MaskEditFocus, Grids, DBGridCitel, DBGrids,
  Buttons, ExtCtrls, untFuncoesSimples, cxProgressBar, DBCtrls, DBEditFocus,
  MemoFocus, BitBtnLockedIncrem, MemDS, DBAccess, Provider, untTypesSistema,
  frxClass, frxExportCSVTestabilidade, untFuncoesPedidoSimples, untFuncoes,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxCurrencyEdit, untConstantes, DBMemoFocus, Datasnap.DBClient,
  untCdsDigMultLoja;

type
  TfrmCadCotItens = class(TfrmPaiOrdena)
    Label5: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    Label9: TLabel;
    edtQtdIte: TEditFocus;
    dtsIteGir: TDataSource;
    btnIncluir: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnGiroEst: TBitBtnLocked;
    btnImporta: TBitBtnLocked;
    lblReq: TPanel;
    btnPrepTE: TBitBtnLocked;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    btnSemelhantes: TBitBtnLocked;
    btnSimilares: TBitBtnLocked;
    pnlAplicacao: TPanel;
    pnlTitAplic: TPanel;
    dbeAplica: TDBMemoFocus;
    pnlGiro: TPanel;
    splAplicacao: TSplitter;
    lblExiApli: TLabel;
    splGiro: TSplitter;
    procedure FormShow(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGiroEstClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormDestroy(Sender: TObject);
    procedure btnImportaClick(Sender: TObject);
    procedure cdsConsultaAfterPost(DataSet: TDataSet);
    procedure btnPrepTEClick(Sender: TObject);
    procedure btnSemelhantesClick(Sender: TObject);
    procedure cxgGiroMES001CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroMES002CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroMES003CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroMES004CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroMES005CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroMES006CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroMES007CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroMES008CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroMES009CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroMES011CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroMES010CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroMES012CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgGiroVENMESCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnSimilaresClick(Sender: TObject);
    procedure splAplicacaoCanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure lblExiApliClick(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    cdsDigMultLoja: TCdsDigMultLoja;
    blnEdiCot : Boolean;

    qryUltCom,
    qryConIte: TUniQuery;
    cdsItensGiro,
    cdsReq: TUniClientDataSet;
    blnValidaQuantidade: Boolean;

    arrCampos: TarrCamposPedCompra;
    arrCamposAgg: TarrCamposAggPedCompra;

    Function fExcluiItemFornecedores(strCodIte: String): Boolean;
    Function fIncluiItemFornecedores: Boolean;
    Function fSQLUltimaCompra: String;

    procedure pInicializaGiro;
    Procedure pAncoraPainelGiro(blnTestarMultLoja: Boolean = False);
    procedure pHabilitaColunasDiaEst(blnHabilita: Boolean);

    Procedure pIncluiItemGiroSintetizado;
    Procedure pAtualizaDiaSugItem;
    procedure pIncluiFornecedor(strCodFor, strNomFor: String);
    procedure pCentralizaCamposMultLoja;

    procedure pConsultaAfterSemGiro;
    procedure pMudaOrdemItensGiro;

    Procedure pHabilitaDescricao(blnHabilita: Boolean);
    procedure pLimpaItem;
    procedure pExcluiItem(blnSemConfirmacao: Boolean = False);
    procedure pIncluiItem(strCodIte, strDesIte: String; fltQtdIte, fltSaldos, fltSalDis, fltDiaEst, fltDiaSug, fltPreCus: Double; blnSomar: Boolean = False);
    procedure pConsultaAfterScroll(DataSet: TDataSet);
    Function  fDigQuantidadeMultilojaCotacao: Boolean;
    Procedure pCarregaMultLojas;
    procedure pDisplayGiro;
    procedure pPosicionaPanelGiro;

    Procedure pSalvaDadosGiro;
    procedure pDestacaMes(intMes: Integer; ACanvas: TcxCanvas);
    procedure pAtualizaDadosSintetizados;
    procedure pSintetizaItens;

    Function fAtualizaDadosSintetizados(pgbStatus: TcxProgressBar = nil): Boolean;
    function fInsereItensGiro(pgbStatus: TcxProgressBar = nil): Boolean;
    function fGetRequisicoesFormatado(strCodIte: String): String;
    Function fRetSemelhantes(strCodIte: String): String;
    Function fSintetizaItens(pgbStatus: TcxProgressBar = nil): Boolean;

  public
    { Public declarations }
    frmCadCotacao: Pointer;

    blnMljLoj: Boolean;
    recDadGiro: TRecOpcoesGiro;

    cdsItensMultiLojas: TUniClientDataSet;
    dtsItensMultiLojas: TDataSource;

    strSeqGer: String;

    cdsCotGer,
    cdsFornecedores,
    cdsItensFornec: TUniClientDataSet;

    procedure pDesabilitaAlteracao;
    procedure pSetaMultiLojas;
    function fGetRequisicoes(strCodIte: String; blnCodigo: Boolean = False): TStringArray;

  protected
    Procedure pOrdenaClient; Override;
    function fGetSql(blnLike: Boolean): String; Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadCotItens: TfrmCadCotItens;

implementation

uses SysUtils, Variants, Forms, Graphics, untPai, untPesqAux, untModulo,
     untGravando, untConsultas, untCadCotItensImpRequisicao, untFatGor,
     untCadCotacaoGeral, untCadCotAtuPrecos, untCadCotacao,
     untPreparaGeracaoTE, untFatMostraProdSemelhante,
     untFatMostraProdSimilar, untTelaGiroUma, untCadCotComparativo;

{$R *.dfm}

Procedure TfrmCadCotItens.pOrdenaClient;
Begin
  If SameText(lflLastField.strNomCam, 'DESMAR') Then
    cdsConsulta.IndexFieldNames := fGetAliasField(lflLastField.strNomCam) + ';' + fGetAliasField('DESITE')
  Else
    cdsConsulta.IndexFieldNames := fGetAliasField(lflLastField.strNomCam);
End;

function TfrmCadCotItens.fGetRequisicoes(strCodIte: String; blnCodigo: Boolean = False): TStringArray;
  Var
    intPos: Integer;
begin
  intPos := cdsReq.RecNo;
  Try
    cdsReq.Filter := 'CODITE = '+ QuotedStr(strCodIte) + ' AND '
                   + 'MARDES = 1';
    cdsReq.Filtered := True;

    SetLength(Result, cdsReq.RecordCount);

    cdsReq.First;
    While Not cdsReq.Eof Do
    Begin
      If blnCodigo Then
        Result[cdsReq.RecNo-1] := cdsReq.FieldByName('CODREQ').AsString
      Else
        Result[cdsReq.RecNo-1] := cdsReq.FieldByName('AUTOINCREM').AsString;
      cdsReq.Next;
    End;
  Finally
    cdsReq.Filtered := False;
    cdsReq.Filter := '';
    cdsReq.RecNo := intPos;
  End;
end;

function TfrmCadCotItens.fGetRequisicoesFormatado(strCodIte: String): String;
  Var
    strReq: String;
begin
  For strReq In fGetRequisicoes(strCodIte, True) Do
    Result := Result + IIF(fEmptyStr(Result), '', ', ') + strReq + '-' + VS_strCodEmp;
end;

function TfrmCadCotItens.fGetSql(blnLike: Boolean): String;
Begin

  Result := '';
  Result := Result + ' SELECT DISTINCT               ';
  Result := Result + '   COT_CODITE   AS AUTOINCREM, ';
  Result := Result + '   COT_CODITE   AS CODITE,     ';
  Result := Result + '   COT_PJAATU   AS PJAATU,     ';
  Result := Result + '   I.ITE_CODSIM AS CODSIM,   ';
  Result := Result + '   I.ITE_CODFAB AS CODFAB,   ';
  Result := Result + '   I.ITE_APLICA AS APLICA,   ';
  Result := Result + '   I.ITE_CODGRU AS CODGRU,   ';
  Result := Result + '   G.ITE_SALDOS AS SALDOS,   ';
  Result := Result + '   G.ITE_PRECUS AS PRECUS,   ';
  Result := Result + '   0            AS DIAEST,   ';
  Result := Result + '   0            AS DIASUG,   ';

  Result := Result + '   COTITE.AUTOINCREM AS AUTCOT, ';

  If blnEdiCot then
    Result := Result + '   COT_DESITE AS DESITE, '
  Else
    Result := Result + '   IF(LOCATE("ITEM ESPECIAL", ITE_DESITE) > 0, COT_DESITE, ITE_DESITE) AS DESITE, ';

  Result := Result + '   ITE_DESITE AS DESCRI,     ';
  Result := Result + '   COT_QTDITE AS QTDITE,     ';
  Result := Result + '   MAR_DESMAR AS DESMAR,     ';
  Result := Result + '   ITE_REFERE AS REFERE,     ';
  Result := Result + '   ITE_IPIENT AS IPIENT,     ';
  Result := Result + '   ITE_MSGLV1 AS MSGLV1,     ';

  Result := Result + '   CAST((SELECT GROUP_CONCAT(SEM_CODSEM) FROM CADSEM WHERE COT_CODITE = SEM_CODITE) AS CHAR(255)) AS CODSEM, ';

  Result := Result + '   ITE_SUBSTI AS SUBSTI,     ';
  Result := Result + '   UNI_SIGUNI AS SIGUNI,     ';
  Result := Result + '   UNI_CODUNI AS CODUNI,     ';

  Result := Result + '  (SELECT UG.ITE_DTAULT                             FROM ITEGER UG WHERE UG.ITE_CODITE = G.ITE_CODITE ORDER BY UG.ITE_DTAULT DESC, UG.ITE_DHUPES DESC LIMIT 1) AS DTAULT, ';
  Result := Result + '  (SELECT CONCAT(UG.ITE_FORULT, "-", UF.FOR_NOMFOR) FROM ITEGER UG INNER JOIN CADFOR UF ON UF.FOR_CODFOR = UG.ITE_FORULT ';
  Result := Result + '                                                                   WHERE UG.ITE_CODITE = G.ITE_CODITE ORDER BY UG.ITE_DTAULT DESC, UG.ITE_DHUPES DESC LIMIT 1) AS FORULT, ';
  Result := Result + '  (SELECT UG.ITE_PREULT                             FROM ITEGER UG WHERE UG.ITE_CODITE = G.ITE_CODITE ORDER BY UG.ITE_DTAULT DESC, UG.ITE_DHUPES DESC LIMIT 1) AS PREULT  ';

  Result := Result + ' FROM            ';
  Result := Result + '   COTITE ';
  Result := Result + ' INNER JOIN CADITE I ON I.ITE_CODITE = COT_CODITE ';
  Result := Result + ' INNER JOIN ITEGER G ON G.ITE_CODITE = COT_CODITE AND ';
  Result := Result + '                        G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
  Result := Result + ' LEFT  JOIN CADMAR ON ITE_CODMAR = MAR_CODMAR ';
  Result := Result + ' LEFT  JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ';
  Result := Result + ' LEFT  JOIN CADFOR ON ITE_FORULT = FOR_CODFOR ';
  Result := Result + ' WHERE COT_SEQGER = ' + QuotedStr(strSeqGer);
End;

procedure TfrmCadCotItens.pCentralizaCamposMultLoja;
Begin
  With cdsItensMultiLojas Do
  If Active Then
  Begin
    FieldByName('ITE_CODEMP').Alignment := taCenter;
    FieldByName('ITE_FORULT').Alignment := taCenter;
    FieldByName('ITE_DTAULT').Alignment := taCenter;
    FieldByName('ITE_DTAUVE').Alignment := taCenter;

    IndexFieldNames := 'ITE_CODITE';
  End;
End;

procedure TfrmCadCotItens.pSetaMultiLojas;
Begin
  blnMljLoj := (Assigned(cdsCotGer) And (cdsCotGer.FieldByName('COT_MULLOJ').AsString = 'S')) Or
               (Assigned(frmCadCotacaoGeral) And (frmCadCotacaoGeral.dbeMulLoj.Checked));

  If blnMljLoj Then
    recDadGiro.strPedMlj := 'S'
  Else
    recDadGiro.strPedMlj := 'N';

  If blnMljLoj And (Not Assigned(cdsItensMultiLojas)) Then
  Begin
    cdsItensMultiLojas := fCriaDatasetPedido(INT_QTD_MES_MOSTRA_GIRO, arrCampos, arrCamposAgg, Self);

    dtsItensMultiLojas := TDataSource.Create(Self);
    dtsItensMultiLojas.DataSet := cdsItensMultiLojas;

    pCentralizaCamposMultLoja;
  End;

  edtQtdIte.ReadOnly := blnMljLoj;

  pAncoraPainelGiro;
End;

Procedure TfrmCadCotItens.pAncoraPainelGiro(blnTestarMultLoja: Boolean = False);
  Var
    cdsItensGridRodape: TUniClientDataSet;
    blnPosicionaPainel: Boolean;
Begin
  blnPosicionaPainel := Not pnlGiro.Visible;

  If (recDadGiro.blnUsaGiro) Or (blnTestarMultLoja And (recDadGiro.strPedMlj = 'S')) Then
  Begin
    If recDadGiro.strPedMlj = 'S' Then
      cdsItensGridRodape := cdsItensMultiLojas
    Else
      cdsItensGridRodape := cdsItensGiro;

    If Not Assigned(cdsDigMultLoja) Then
    Begin
      pDisplayGiro;

      cdsDigMultLoja := TCdsDigMultLoja.Create(Nil,
                                               cdsItensGridRodape,
                                               cdsItensGiro,
                                               recDadGiro,
                                               pnlGiro,
                                               recDadGiro.blnUsaGiro,
                                               cdsConsultaAfterPost);

      cdsDigMultLoja.pAncora;

    End;

  End;

  If blnPosicionaPainel And pnlGiro.Visible Then
  begin
    pPosicionaPanelGiro;
  End;
End;

procedure TfrmCadCotItens.pPosicionaPanelGiro;
Begin
  splGiro.Visible := pnlGiro.Visible And (recDadGiro.strPedMlj = 'S');
  pnlGiro.Top := pnlTail.Top - 20;
  splGiro.Top := pnlGiro.Top - 2;

  pnlTail.Top   := pnlGiro.Top + pnlGiro.Height;
  pnlBotoes.Top := pnlTail.Top + pnlTail.Height;
End;

procedure TfrmCadCotItens.pCarregaMultLojas;
  Var
    oleItensGiro: OleVariant;
    oleItensMult: OleVariant;
Begin
  With recDadGiro Do
  Begin
     dtaDataBaseGir := Date;
     intMesGir      := cdsCotGer.FieldByName('COT_MESGIR').AsInteger;
     intMesMos      := cdsCotGer.FieldByName('COT_MESMOS').AsInteger;
     strMeses       := cdsCotGer.FieldByName('COT_MESSEL').AsString;
     blnConsMesAtu  := cdsCotGer.FieldByName('COT_MESATU').AsString = 'S';
     strSeqCot      := strSeqGer;

     If intMesMos = 0 Then
       intMesMos := INT_QTD_MES_MOSTRA_GIRO;

     If fEmptyStr(strMeses) Then
       strMeses := fMontaStrMeses(intMesMos);
  End;

  If Assigned(cdsItensMultiLojas) Then
  Begin
    oleItensMult := TfrmCadCotacao(frmCadCotacao).fCarregaCotacaoMultiLojas(recDadGiro, oleItensGiro);

    If (oleItensMult <> Null) then
      cdsItensMultiLojas.Data := oleItensMult;

    pCentralizaCamposMultLoja;

    If (oleItensGiro <> Null) And Assigned(cdsItensGiro) then
    Begin
      cdsItensGiro.Data := oleItensGiro;
      pSalvaDadosGiro;
    End Else If Assigned(cdsItensGiro) then
    Begin
      cdsItensGiro.Data := cdsItensMultiLojas.Data;
      cdsItensGiro.EmptyDataSet;
      pSintetizaItens;
    End;

    pDisplayGiro;

    pAtualizaDadosSintetizados;

    recDadGiro.blnUsaGiro := True;

    pAncoraPainelGiro;

    pHabilitaColunasDiaEst(True);

    pMudaOrdemItensGiro;
  End;
End;

Function TfrmCadCotItens.fAtualizaDadosSintetizados(pgbStatus: TcxProgressBar = nil): Boolean;
Begin
  With cdsConsulta Do
  Begin
    First;
    While Not Eof Do
    Begin

      If cdsItensGiro.Locate('ITE_CODITE', FieldByName('CODITE').AsString, []) Then
      Begin
        Edit;
        FieldByName('SALDOS').AsFloat := cdsItensGiro.FieldByName('ITE_SALDOS').AsFloat;
        FieldByName('DIAEST').AsFloat := cdsItensGiro.FieldByName('ITE_DIAEST').AsFloat;
        FieldByName('DIASUG').AsFloat := cdsItensGiro.FieldByName('ITE_DIASUG').AsFloat;
        Post;
      End;

      Next;
    End;
  End;

  Result := True;

End;

procedure TfrmCadCotItens.pAtualizaDadosSintetizados;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Atualizando dados sintetizados...';
    frmGravando.fExecutarAcao := fAtualizaDadosSintetizados;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, 'pAtualizaDadosSintetizados');
  End;

  pFreeAndNil(frmGravando);
End;

Function TfrmCadCotItens.fSintetizaItens(pgbStatus: TcxProgressBar = nil): Boolean;
Begin
  With cdsConsulta Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      cdsItensMultiLojas.Filter   := 'ITE_CODITE = ' + QuotedStr(FieldByName('CODITE').AsString);
      cdsItensMultiLojas.Filtered := True;

      pIncluiItemGiroSintetizado;
      Next;
    End;
    EnableControls;
  End;

  Result := True;
End;

procedure TfrmCadCotItens.pSintetizaItens;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Sintetizados itens...';
    frmGravando.fExecutarAcao := fSintetizaItens;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, 'pSintetizaItens');
  End;

  pFreeAndNil(frmGravando);
End;


procedure TfrmCadCotItens.splAplicacaoCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  inherited;

  Accept := pnlAplicacao.Height > 1;
end;

procedure TfrmCadCotItens.FormShow(Sender: TObject);
begin
  inherited;

  pSetaMultiLojas;

  pCriarFormularios(TfrmCadCotItensImpRequisicao, frmCadCotItensImpRequisicao);
  frmCadCotItensImpRequisicao.pCarregaRequisicoes(strSeqGer);
  cdsReq.Data := frmCadCotItensImpRequisicao.cdsReq.Data;

  blnTemSelecao       := FALSE;
  blnSempreRelerBanco := FALSE;
  pLimpaEventoEdits;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  fAbreConsulta(TRUE);

  pInicializaGiro;

  If blnMljLoj Then
    pCarregaMultLojas;

  TFloatField(cdsConsulta.FieldByName('PREULT')).DisplayFormat := '#,##0.00';

  btnSemelhantes.Visible := fCfgSis('UTISEM', varBoolean);
end;

procedure TfrmCadCotItens.pInicializaGiro;
Begin
  If Assigned(cdsCotGer) Then
  With recDadGiro Do
  Begin
    intMesGir     := cdsCotGer.FieldByName('COT_MESGIR').AsInteger;
    intMesMos     := cdsCotGer.FieldByName('COT_MESMOS').AsInteger;
    strMeses      := cdsCotGer.FieldByName('COT_MESSEL').AsString;
    blnConsMesAtu := cdsCotGer.FieldByName('COT_MESATU').AsString = 'S';

    If intMesMos = 0 Then
      intMesMos := INT_QTD_MES_MOSTRA_GIRO;

    If fEmptyStr(strMeses) Then
      strMeses := fMontaStrMeses(intMesMos);
  End;
End;

procedure TfrmCadCotItens.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryIteCon: TUniQuery;
    arrSel : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    qryIteCon := fCriaQuery;

    If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, qryIteCon, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
    Begin
      If (fValidaCampos(edtCodIte, True)) Then
        blnMudarFoco := True;

    End;
    FreeAndNil(qryIteCon);
  End;

end;

Procedure TfrmCadCotItens.pHabilitaDescricao(blnHabilita: Boolean);
Begin
  if blnEdiCot Then
    Exit;

  edtDesIte.TabStop := blnHabilita;
  edtDesIte.ReadOnly := Not edtDesIte.TabStop;
End;

Function TfrmCadCotItens.fDigQuantidadeMultilojaCotacao: Boolean;
Begin
  pAncoraPainelGiro(True);

  Result := cdsDigMultLoja.fDigQuantidadeMultiloja(edtQtdIte,
                                                   edtCodIte.Text,
                                                   edtDesIte.Text,
                                                   '');
  If Result Then
  Begin
    If Assigned(cdsItensGiro) And cdsItensGiro.Active Then
    Begin
      If cdsItensGiro.Locate('ITE_CODITE', edtCodIte.Text, []) Then
        pAtualizaDiaSugItem
      Else
        pIncluiItemGiroSintetizado;
    End;
  End;

End;

Procedure TfrmCadCotItens.pAtualizaDiaSugItem;
Begin
  cdsItensGiro.Edit;
  cdsItensGiro.FieldbyName('ITE_DIASUG').AsFloat := cdsDigMultLoja.intDiaSug;
  cdsItensGiro.Post;
End;

Procedure TfrmCadCotItens.pIncluiItemGiroSintetizado;
Begin
  If Assigned(cdsItensGiro) And cdsItensGiro.Active Then
  With cdsItensMultiLojas Do
  Begin
    cdsItensGiro.Insert;

    DisableControls;
    First;

    cdsItensGiro.FieldByName('ITE_CODITE').AsString := FieldByName('ITE_CODITE').AsString;
    cdsItensGiro.FieldByName('ITE_DESITE').AsString := FieldByName('ITE_DESITE').AsString;
    cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat  := 0;
    cdsItensGiro.FieldByName('ITE_SALDOS').AsFloat  := 0;
    cdsItensGiro.FieldByName('ITE_SALDIS').AsFloat  := 0;
    cdsItensGiro.FieldByName('ITE_QTDITE').AsFloat  := 0;

    While Not Eof Do
    Begin
      cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat := cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat + FieldByName('ITE_MEDIA_').AsFloat;
      cdsItensGiro.FieldByName('ITE_SALDOS').AsFloat := cdsItensGiro.FieldByName('ITE_SALDOS').AsFloat + FieldByName('ITE_SALDOS').AsFloat;
      cdsItensGiro.FieldByName('ITE_SALDIS').AsFloat := cdsItensGiro.FieldByName('ITE_SALDIS').AsFloat + FieldByName('ITE_SALDIS').AsFloat;
      cdsItensGiro.FieldByName('ITE_QTDITE').AsFloat := cdsItensGiro.FieldByName('ITE_QTDITE').AsFloat + FieldByName('ITE_QTDITE').AsFloat;

      Next;
    End;

    If cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat > 0 Then
    Begin
      cdsItensGiro.FieldByName('ITE_DIAEST').AsInteger := Trunc(cdsItensGiro.FieldByName('ITE_SALDIS').AsFloat /
                                                           (cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat / 30));

      cdsItensGiro.FieldByName('ITE_DIASUG').AsInteger := Trunc((cdsItensGiro.FieldByName('ITE_SALDIS').AsFloat +
                                                                 cdsItensGiro.FieldByName('ITE_QTDITE').AsFloat) /
                                                           (cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat / 30))
    End Else
    Begin
      cdsItensGiro.FieldByName('ITE_DIAEST').Clear;
      cdsItensGiro.FieldByName('ITE_DIASUG').Clear;
    End;

    cdsItensGiro.Post;

    Edit;

    EnableControls;
  End;
End;

function TfrmCadCotItens.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    fltSaldos,
    fltPreCus,
    fltSalDis,
    fltDiaEst,
    fltDiaSug: Double;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodIte) Then
    Begin
      If fEmptyStr(edtCodIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o código do item!', ['&O k']);
        Result := False;
      End Else
      Begin
        pPesquisaCadIte(Nil, qryConIte, edtCodIte.Text, '', False, FALSE, True, False);

        If qryConIte.FieldByName('ITE_CODITE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'O item '+ edtCodIte.Text + ' não está cadastrado!', ['&O k']);
          Result := False;
        End

        Else If (qryConIte.FieldByName('ITE_ITEATI').AsString <> 'S') Then
        Begin
          fMensagem('ATENÇÃO!', 'Item inativo!', ['&O k']);
          Result := False;
        End

        Else If (qryConIte.FieldByName('ITE_ATICOM').AsString <> 'S') Then
        Begin
          fMensagem('ATENÇÃO!', 'Item não está ativo para compras, verifique o cadastro!', ['&O k']);
          Result := False;
        End

        Else
        Begin

          If blnBuscaPorChave Then
          Begin
            edtDesIte.Text := qryConIte.FieldByName('ITE_DESITE').AsString;

            If cdsConsulta.Locate('CODITE',edtCodIte.Text,[]) Then
            Begin
              edtQtdIte.Text := FormatFloat('#0.00', cdsConsulta.FieldByName('QTDITE').AsFloat);
              edtDesIte.Text := cdsConsulta.FieldByName('DESITE').AsString;
            End;

            blnMudarFoco := FALSE;

            pHabilitaDescricao(Pos('ITEM ESPECIAL', qryConIte.FieldByName('ITE_DESITE').AsString) > 0);

            If edtDesIte.ReadOnly Then
              pSetFocus(edtQtdIte)
            Else
              pSetFocus(edtDesIte);

          End;

        End;
      End;

    End

    Else If (Sender = edtDesIte) Then
    Begin

      If fEmptyStr(edtDesIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe a descrição do item!', ['&O k']);
        Result := False;
      End

      Else If blnBuscaPorChave Then
      Begin
        blnMudarFoco := FALSE;
        pSetFocus(edtQtdIte);
      End;

    End

    Else If (Sender = edtQtdIte) And blnValidaQuantidade Then
    Begin

      If blnMljLoj And blnBuscaPorChave Then
      Begin
        Result := fValidaCampos(edtCodIte, True) And fDigQuantidadeMultilojaCotacao;
      End;

      If Result  Then
      Begin
        If fEmptyStr(edtQtdIte.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A quantidade deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If (fStrToFloat(edtQtdIte.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A quantidade deve ser maior ou igual a zero!', ['&O k']);
          Result := False;
        End Else
        Begin
          If blnBuscaPorChave Then
          Begin
            If blnMljLoj Then
            Begin

              If Assigned(cdsItensGiro) And cdsItensGiro.Active And
                 (cdsItensGiro.FieldByName('ITE_CODITE').AsString = edtCodIte.Text)Then
              Begin

                fltPreCus := cdsItensGiro.FieldByName('ITE_PRECUS').AsFloat;
                fltSaldos := cdsItensGiro.FieldByName('ITE_SALDOS').AsFloat;
                fltSalDis := cdsItensGiro.FieldByName('ITE_SALDIS').AsFloat;
                fltDiaEst := cdsItensGiro.FieldByName('ITE_DIAEST').AsFloat;
                fltDiaSug := cdsItensGiro.FieldByName('ITE_DIASUG').AsFloat;

              End Else
              Begin
                fltPreCus := fCampoTabela('ITE_PRECUS', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [edtCodIte.Text, VS_strCodEmp]);
                fltSaldos := fRetSaldosEmpresa(edtCodIte.Text, VS_strCodEmp);
                fltSalDis := fRetSaldosEmpresa(edtCodIte.Text, VS_strCodEmp);
                fltDiaEst := 0;
                fltDiaSug := 0;
              End;

            End Else
            Begin
              fltPreCus := fCampoTabela('ITE_PRECUS', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [edtCodIte.Text, VS_strCodEmp]);
              fltSaldos := fRetSaldosEmpresa(edtCodIte.Text, VS_strCodEmp);
              fltSalDis := fltSaldos;
              fltDiaEst := 0;
              fltDiaSug := 0;
            End;

            cdsConsulta.AfterScroll := Nil;
            pIncluiItem(edtCodIte.Text, edtDesIte.Text, fStrToFloat(edtQtdIte.Text), fltSaldos, fltSalDis, fltDiaEst, fltDiaSug, fltPreCus);
            cdsConsulta.AfterScroll := pConsultaAfterScroll;

          End;
        End;
      End

      Else pLimpaItem;

    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadCotItens.lblExiApliClick(Sender: TObject);
begin
  inherited;

  If pnlAplicacao.Visible Then
  Begin
    splAplicacao.Visible := False;
    pnlAplicacao.Visible := False;
    lblExiApli.Caption  := 'Exibir Aplicação do Produto';
  End
  Else
  Begin
    pnlAplicacao.Visible := True;
    splAplicacao.Visible := True;
    splAplicacao.Top     := pnlAplicacao.Top;
    lblExiApli.Caption   := 'Ocultar Aplicação do Produto';
  End;

  splGiro.Top := pnlGiro.Top;
end;

procedure TfrmCadCotItens.pLimpaItem;
Begin
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtQtdIte.Text := '0,00';
  edtCodIte.ReadOnly := False;
  pSetFocus(edtCodIte);
  blnMudarFoco := FALSE;
  pHabilitaDescricao(False);
End;

procedure TfrmCadCotItens.pIncluiFornecedor(strCodFor, strNomFor: String);
begin
  If cdsFornecedores.Locate('CODFOR', strCodFor, []) Then Exit;

  cdsFornecedores.Tag := 1;
  cdsFornecedores.DisableControls;
  cdsFornecedores.Append;
  cdsFornecedores.FieldByName('AUTOINCREM').AsString := strCodFor;
  cdsFornecedores.FieldByName('CODFOR').AsString     := strCodFor;
  cdsFornecedores.FieldByName('NOMFOR').AsString     := strNomFor;
  cdsFornecedores.FieldByName('UTILIZ').AsString     := 'S';
  cdsFornecedores.Post;
  cdsFornecedores.EnableControls;
  cdsFornecedores.Tag := 0;
end;

Function TfrmCadCotItens.fRetSemelhantes(strCodIte: String): String;
  Var
    qryCadSem: TUniQuery;
Begin
  qryCadSem := fCriaQuery;
  With qryCadSem Do
  Begin
    SQL.Text := 'SELECT GROUP_CONCAT(SEM_CODSEM) AS CODSEM FROM CADSEM WHERE SEM_CODITE = :CODITE';
    ParamByName('CODITE').AsString := strCodIte;
    Open;
    Result := FieldByName('CODSEM').AsString;
  End;
  FreeAndNil(qryCadSem);
End;

procedure TfrmCadCotItens.pIncluiItem(strCodIte, strDesIte: String; fltQtdIte, fltSaldos, fltSalDis, fltDiaEst, fltDiaSug, fltPreCus: Double; blnSomar: Boolean = False);
  Var
    blnEditando: Boolean;
Begin
  Try
    blnEditando := False;

    pLimpaPesquisa;
    edtCodIte.Text := strCodIte;
    edtDesIte.Text := strDesIte;
    edtQtdIte.Text := FloatToStr(fltQtdIte);

    If fVerificaCampos Then
    With cdsConsulta Do
    Begin
      DisableControls;
      cdsConsulta.Tag := 1;

      If Locate('CODITE', strCodIte,[]) Then
      Begin
        Edit;
        blnEditando := True;
      End Else
      Begin
        blnEditando := False;
        Insert;
      End;

      FieldByName('AUTOINCREM').AsString := strCodIte;
      FieldByName('CODITE').AsString     := strCodIte;
      FieldByName('CODSIM').AsString     := qryConIte.FieldbyName('ITE_CODSIM').AsString;
      FieldByName('SALDOS').AsFloat      := fltSaldos;
      FieldByName('DIAEST').AsFloat      := fltDiaEst;
      FieldByName('DIASUG').AsFloat      := fltDiaSug;
      FieldByName('PRECUS').AsFloat      := fltPrecus;
      FieldByName('APLICA').AsString     := qryConIte.FieldbyName('ITE_APLICA').AsString;
      FieldByName('CODFAB').AsString     := qryConIte.FieldbyName('ITE_CODFAB').AsString;
      FieldByName('CODGRU').AsString     := qryConIte.FieldbyName('ITE_CODGRU').AsString;
      FieldByName('REFERE').AsString     := qryConIte.FieldbyName('ITE_REFERE').AsString;
      FieldByName('SIGUNI').AsString     := fRetSiglaUnidade(qryConIte.FieldbyName('ITE_CODUNI').AsString);
      FieldByName('CODUNI').AsString     := qryConIte.FieldbyName('ITE_CODUNI').AsString;
      FieldByName('DESMAR').AsString     := fRetNomMarca(qryConIte.FieldbyName('ITE_CODMAR').AsString);
      FieldByName('MSGLV1').AsString     := qryConIte.FieldbyName('ITE_MSGLV1').AsString;
      FieldByName('DESITE').AsString     := strDesIte;
      FieldByName('QTDITE').AsFloat      := IIF(blnSomar, FieldByName('QTDITE').AsFloat, 0) + fltQtdIte;
      FieldByName('CODSEM').AsString     := fRetSemelhantes(strCodIte);

     // If blnMljLoj Then
    //  Begin
        qryUltCom.Close;
        qryUltCom.ParamByName('CODITE').AsString := strCodIte;
        qryUltCom.Open;

        FieldByName('DTAULT').Value      := qryUltCom.FieldbyName('ITE_DTAULT').Value;
        FieldByName('FORULT').Value      := qryUltCom.FieldbyName('ITE_FORULT').AsString + '-' + fRetNomFornecedor(qryUltCom.FieldbyName('ITE_FORULT').AsString);
        FieldByName('PREULT').Value      := qryUltCom.FieldbyName('ITE_PREULT').Value;
    (*  End Else
      Begin
        FieldByName('DTAULT').Value      := qryConIte.FieldbyName('ITE_DTAULT').Value;
        FieldByName('FORULT').Value      := qryConIte.FieldbyName('ITE_FORULT').AsString + '-' + fRetNomFornecedor(qryConIte.FieldbyName('ITE_FORULT').AsString);
        FieldByName('PREULT').Value      := qryConIte.FieldbyName('ITE_PREULT').Value;
      End; *)

      If fIncluiItemFornecedores Then
        Post
      Else
        Cancel;

      EnableControls;


      cdsConsulta.Tag := 0;
    End;

    pLimpaItem;

    If blnEditando Then
      pSetFocus(dbgConsulta);

  Except
    On E: Exception Do
    Begin
      cdsConsulta.EnableControls;
      cdsConsulta.Tag := 0;
      pMensagensErro(E.Message, '[TfrmCadCotItens.pIncluiItem]');
    End;
  End;

End;

Function TfrmCadCotItens.fIncluiItemFornecedores: Boolean;
  Var
    blnFilter: Boolean;
    strFilter: String;
Begin
  Try

    cdsConsulta.DisableControls;
    cdsItensFornec.DisableControls;
    cdsFornecedores.DisableControls;

    cdsItensFornec.Tag := 1;

    blnFilter := cdsItensFornec.Filtered;
    strFilter := cdsItensFornec.Filter;

    cdsItensFornec.Filtered := False;

    cdsFornecedores.First;
    While Not cdsFornecedores.Eof Do
    Begin

      If cdsItensFornec.Locate('CODFOR;CODITE',
           VarArrayOf([cdsFornecedores.FieldByName('CODFOR').AsString,
                       cdsConsulta.FieldByName('CODITE').AsString]),[]) Then
      Begin
        cdsItensFornec.Edit;
      End Else
      Begin
        cdsItensFornec.Insert;
        cdsItensFornec.FieldByName('CODFOR').AsString     := cdsFornecedores.FieldByName('CODFOR').AsString;
        cdsItensFornec.FieldByName('NOMFOR').AsString     := cdsFornecedores.FieldByName('NOMFOR').AsString;
        cdsItensFornec.FieldByName('AUTOINCREM').AsString := cdsConsulta.FieldByName('CODITE').AsString;
        cdsItensFornec.FieldByName('CODITE').AsString     := cdsConsulta.FieldByName('CODITE').AsString;
        cdsItensFornec.FieldByName('CODFAB').AsString     := cdsConsulta.FieldByName('CODFAB').AsString;
        cdsItensFornec.FieldByName('CODSIM').AsString     := cdsConsulta.FieldByName('CODSIM').AsString;
        cdsItensFornec.FieldByName('CODSEM').AsString     := cdsConsulta.FieldByName('CODSEM').AsString;
        cdsItensFornec.FieldByName('CODGRU').AsString     := cdsConsulta.FieldByName('CODGRU').AsString;
        cdsItensFornec.FieldByName('REFERE').AsString     := cdsConsulta.FieldByName('REFERE').AsString;
        cdsItensFornec.FieldByName('SIGUNI').AsString     := cdsConsulta.FieldByName('SIGUNI').AsString;
        cdsItensFornec.FieldByName('DESMAR').AsString     := cdsConsulta.FieldByName('DESMAR').AsString;
        cdsItensFornec.FieldByName('CODUNI').AsString     := cdsConsulta.FieldByName('CODUNI').AsString;
        cdsItensFornec.FieldByName('IPIENT').AsFloat      := cdsConsulta.FieldByName('IPIENT').AsFloat;
        cdsItensFornec.FieldByName('SUBSTI').AsFloat      := cdsConsulta.FieldByName('SUBSTI').AsFloat;
        cdsItensFornec.FieldByName('PRECUS').AsFloat      := cdsConsulta.FieldByName('PRECUS').AsFloat;
        cdsItensFornec.FieldByName('VALUNI').AsFloat      := 0;
        cdsItensFornec.FieldByName('PREESC').AsInteger    := 0;
        cdsItensFornec.FieldByName('DTAULT').Value        := cdsConsulta.FieldByName('DTAULT').Value;
        cdsItensFornec.FieldByName('FORULT').Value        := cdsConsulta.FieldByName('FORULT').Value;
        cdsItensFornec.FieldByName('PREULT').Value        := cdsConsulta.FieldByName('PREULT').Value;
      End;

      cdsItensFornec.FieldByName('DESITE').AsString := cdsConsulta.FieldByName('DESITE').AsString;
      cdsItensFornec.FieldByName('QTDITE').AsFloat  := cdsConsulta.FieldByName('QTDITE').AsFloat;

      cdsItensFornec.FieldByName('VALTOT').AsFloat :=
        cdsConsulta.FieldByName('QTDITE').AsFloat * cdsItensFornec.FieldByName('VALUNI').AsFloat +
        cdsConsulta.FieldByName('QTDITE').AsFloat * cdsItensFornec.FieldByName('VALUNI').AsFloat * cdsItensFornec.FieldByName('IPIENT').AsFloat / 100 +
        cdsConsulta.FieldByName('QTDITE').AsFloat * cdsItensFornec.FieldByName('VALUNI').AsFloat * cdsItensFornec.FieldByName('SUBSTI').AsFloat / 100;

      cdsItensFornec.Post;

      cdsFornecedores.Next;
    End;

    cdsItensFornec.Tag := 0;

    cdsItensFornec.Filter   := strFilter;
    cdsItensFornec.Filtered := blnFilter;


    cdsFornecedores.EnableControls;
    cdsConsulta.EnableControls;
    cdsItensFornec.EnableControls;

    Result := TRUE;

  Except
    On E: Exception Do
    Begin
      Result := FALSE;
      cdsItensFornec.Tag := 0;
      cdsConsulta.EnableControls;
      cdsItensFornec.EnableControls;
      cdsFornecedores.EnableControls;
      pMensagensErro(E.Message, '[fIncluiItemFornecedores]');
    End;
  End;


End;


Function TfrmCadCotItens.fExcluiItemFornecedores(strCodIte: String): Boolean;
Begin

  Try
  
    With cdsItensFornec Do
    Begin
      DisableControls;
      Filtered := FALSE;
      While Locate('CODITE', strCodIte, []) Do
        Delete;
      Filtered := TRUE;
      EnableControls;
    End;

    Result := TRUE;

  Except
    On E: Exception Do
    Begin
      cdsItensFornec.EnableControls;
      Result := FALSE;
      pMensagensErro(E.Message, '[fExcluiItemFornecedores]');
    End;
  End;

End;

procedure TfrmCadCotItens.pExcluiItem(blnSemConfirmacao: Boolean = False);
Begin
  Try

    With cdsConsulta Do
    Begin
      If IsEmpty Then
        Exit;

      If blnSemConfirmacao Or
        (fMensagem('', 'Confirma a exclusão do item ' + FieldbyName('CODITE').AsString +
                       '-' + FieldbyName('DESITE').AsString + '?', ['&Sim', '&Não']) = 1) Then
      Begin
        If fExcluiItemFornecedores(FieldbyName('CODITE').AsString) Then
        Begin
          pZeraMultiLojas(FieldbyName('CODITE').AsString, cdsItensMultiLojas);
          Delete;
        End;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pExcluiItem]');
    End;
  End;

End;

procedure TfrmCadCotItens.btnImportaClick(Sender: TObject);
begin
  If frmCadCotItensImpRequisicao.ShowModal = mrOk Then
  Begin
    While Not cdsConsulta.IsEmpty Do
      pExcluiItem(True);

    While Not cdsFornecedores.IsEmpty Do
      cdsFornecedores.Delete;

    cdsReq.Data := frmCadCotItensImpRequisicao.cdsReq.Data;

    cdsReq.First;
    While Not cdsReq.Eof Do
    Begin
      If cdsReq.FieldByName('MARDES').AsInteger > 0 Then
        pIncluiFornecedor(cdsReq.FieldByName('CODFOR').AsString, cdsReq.FieldByName('NOMFOR').AsString);

      cdsReq.Next;
    End;

    cdsReq.First;
    While Not cdsReq.Eof Do
    Begin
      If cdsReq.FieldByName('MARDES').AsInteger > 0 Then
        pIncluiItem(cdsReq.FieldByName('CODITE').AsString,
                    cdsReq.FieldByName('DESITE').AsString,
                    cdsReq.FieldByName('QTDITE').AsFloat,
                    fRetSaldosEmpresa(cdsReq.FieldByName('CODITE').AsString, VS_strCodEmp),
                    fRetSaldosEmpresa(cdsReq.FieldByName('CODITE').AsString, VS_strCodEmp),
                    0,
                    0,
                    fCampoTabela('ITE_PRECUS', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [cdsReq.FieldByName('CODITE').AsString, VS_strCodEmp]),
                    True);

      cdsReq.Next;
    End;

    pSetFocus(edtCodIte);
  End;
end;

procedure TfrmCadCotItens.btnIncluirClick(Sender: TObject);
begin
  pIncluiItem(edtCodIte.Text, edtDesIte.Text, fStrToFloat(edtQtdIte.Text), fRetSaldosEmpresa(edtCodIte.Text, VS_strCodEmp),
                                                                           fRetSaldosEmpresa(edtCodIte.Text, VS_strCodEmp),
                                                                           0, 0,
                                                                           fCampoTabela('ITE_PRECUS', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [edtCodIte.Text, VS_strCodEmp]));
end;

procedure TfrmCadCotItens.btnPrepTEClick(Sender: TObject);
  Var
    objPreparaGer: TPreparaGeracaoTE;
    strCodIte: String;
begin
  inherited;

  If Not fVerificaAcessoSistema('frmPreparaGerTE') Then
  Begin
    pMensagemOk('Usuário sem permissão para o módulo "Movimentação de Itens - ' +
                'Preparador para Geração de Transferência de Estoque"!');
    Exit;
  End;

  If cdsConsulta.IsEmpty Then
    strCodIte := ''
  Else
    strCodIte := cdsConsulta.FieldByName('CODITE').AsString;

  objPreparaGer := TPreparaGeracaoTE.Create;
  objPreparaGer.pInformaPreparacao(strCodIte);

  FreeAndNil(objPreparaGer);
end;

procedure TfrmCadCotItens.btnSemelhantesClick(Sender: TObject);
begin
  inherited;

  If Not cdsConsulta.IsEmpty Then
    pMostraSemelhante(cdsConsulta.FieldByName('CODITE').AsString);

end;

procedure TfrmCadCotItens.cdsConsultaAfterPost(DataSet: TDataSet);
begin
  inherited;

  If Assigned(frmCadCotacaoGeral) And (frmCadCotacaoGeral.cdsCotacao.State = dsInsert) then
  Begin
    frmCadCotacaoGeral.dbeMulLoj.ReadOnly := Not cdsConsulta.IsEmpty;
  End;

  pConsultaAfterScroll(cdsConsulta);
end;

procedure TfrmCadCotItens.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;

  pConsultaAfterSemGiro;

end;

procedure TfrmCadCotItens.pConsultaAfterSemGiro;
  Var
    strReq: String;
begin
  lblReq.Visible := False;
  lblReq.Caption := '';

  If Not (cdsConsulta.State In dsEditModes) Then
  Begin
    strReq := fGetRequisicoesFormatado(cdsConsulta.FieldByName('CODITE').AsString);
    If Not fEmptyStr(strReq) Then
    Begin
      lblReq.Caption := 'Requisições: '+ strReq;
      lblReq.Visible := True;
    End;
  End;

  btnSimilares.Visible := Not fEmptyStr(cdsConsulta.FieldByName('CODSIM').AsString);
end;

procedure TfrmCadCotItens.pDestacaMes(intMes: Integer; ACanvas: TcxCanvas);
Begin
  If (intMes <= recDadGiro.intMesGir) Then
    ACanvas.Font.Color := clRed;
End;

procedure TfrmCadCotItens.cxgGiroMES001CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(12, ACanvas);
end;

procedure TfrmCadCotItens.cxgGiroMES002CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(11, ACanvas);
end;

procedure TfrmCadCotItens.cxgGiroMES003CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(10, ACanvas);
end;

procedure TfrmCadCotItens.cxgGiroMES004CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(9, ACanvas);
end;

procedure TfrmCadCotItens.cxgGiroMES005CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(8, ACanvas);
end;

procedure TfrmCadCotItens.cxgGiroMES006CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(7, ACanvas);
end;

procedure TfrmCadCotItens.cxgGiroMES007CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(6, ACanvas);
end;

procedure TfrmCadCotItens.cxgGiroMES008CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(5, ACanvas);
end;

procedure TfrmCadCotItens.cxgGiroMES009CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(4, ACanvas);
end;

procedure TfrmCadCotItens.cxgGiroMES010CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(3, ACanvas);
end;

procedure TfrmCadCotItens.cxgGiroMES011CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(2, ACanvas);
end;

procedure TfrmCadCotItens.cxgGiroMES012CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(1, ACanvas);
end;

procedure TfrmCadCotItens.cxgGiroVENMESCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If recDadGiro.blnConsMesAtu Then
    ACanvas.Font.Color := clRed;
end;

procedure TfrmCadCotItens.pConsultaAfterScroll(DataSet: TDataSet);
  Var
    blnRodape: Boolean;
Begin
  pConsultaAfterSemGiro;

  If Not cdsItensGiro.IsEmpty Then
  Begin
    blnRodape := cdsItensGiro.Locate('ITE_CODITE', cdsConsulta.FieldByName('CODITE').AsString, []);

    If (blnRodape <> pnlGiro.Visible) Then
    Begin
      pnlGiro.Visible := blnRodape;

      pPosicionaPanelGiro;
    End;
  End;

  If recDadGiro.strPedMlj = 'S' Then
  Begin
    If Assigned(cdsItensMultiLojas) Then
    Begin
      cdsItensMultiLojas.Filter   := 'ITE_CODITE = ' + QuotedStr(cdsConsulta.FieldByName('CODITE').AsString);
      cdsItensMultiLojas.Filtered := True;
    End;
  End;

  If Assigned(frmTelaGiroUma) Then
    frmTelaGiroUma.pAtualizaDadosUmaLoja;

End;

procedure TfrmCadCotItens.pHabilitaColunasDiaEst(blnHabilita: Boolean);
Begin
  dbgConsulta.Columns[12].Visible := blnHabilita;
  dbgConsulta.Columns[13].Visible := blnHabilita;
End;

procedure TfrmCadCotItens.pMudaOrdemItensGiro;
Begin
  Case recDadGiro.intOrdem Of
    0: Begin
         With lflLastField Do
         Begin
           intIndCol := 3; // DESITE
           ftyTipCam := dbgConsulta.Columns.Items[intIndCol].Field.DataType;
           strNomCam := dbgConsulta.Columns.Items[intIndCol].Field.FieldName;
           strNomCol := dbgConsulta.Columns.Items[intIndCol].Title.Caption;
         End;

         pOrdenaClient;
       End;
    1: Begin
         With lflLastField Do
         Begin
           intIndCol := 9; // DESMAR
           ftyTipCam := dbgConsulta.Columns.Items[intIndCol].Field.DataType;
           strNomCam := dbgConsulta.Columns.Items[intIndCol].Field.FieldName;
           strNomCol := dbgConsulta.Columns.Items[intIndCol].Title.Caption;
         End;

         pOrdenaClient;
       End;
  End;

  frmCadCotComparativo.cdsConsulta.IndexFieldNames := cdsConsulta.IndexFieldNames;

  cdsConsulta.First;
End;

procedure TfrmCadCotItens.btnGiroEstClick(Sender: TObject);
begin
  inherited;

  If Not (btnGiroEst.Visible) Then
    Exit;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fInsereItensGiro;
    frmGravando.ShowModal;

    If frmGravando.blnConfirma Then
    Begin
      pAncoraPainelGiro;

      pMudaOrdemItensGiro;

      pHabilitaColunasDiaEst(True);
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, 'TfrmCadCotItens.btnGiroEstClick');
  End;

  pFreeAndNil(frmGravando);
end;

Procedure TfrmCadCotItens.pSalvaDadosGiro;
  Var
    blnPost: Boolean;
Begin
  If Not (cdsCotGer.State In [dsEdit, dsInsert]) Then
  Begin
    cdsCotGer.Edit;
    blnPost := True;
  End Else
  Begin
    blnPost := False;
  End;

  cdsCotGer.FieldByName('COT_MESGIR').AsInteger := recDadGiro.intMesGir;
  cdsCotGer.FieldByName('COT_MESMOS').AsInteger := recDadGiro.intMesMos;
  cdsCotGer.FieldByName('COT_MESSEL').AsString  := recDadGiro.strMeses;
  cdsCotGer.FieldByName('COT_MESATU').AsString  := IIF(recDadGiro.blnConsMesAtu, 'S', 'N');

  If blnPost then
    cdsCotGer.Post;
End;

function TfrmCadCotItens.fInsereItensGiro(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    oleItensMultiLojas: OleVariant;
    cdsItensGiroAux: TUniClientDataSet;
    intMesGir: Integer;
begin
  Result := True;

  cdsConsulta.AfterScroll := Nil;
  blnValidaQuantidade := False;

  If TfrmCadCotacao(frmCadCotacao).hwdDllPedido > 0 Then
  Begin
    If Assigned(pgbStatus) Then
      TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := 'Aguarde, calculando giro...';

    recDadGiro.blnUsaGiro := True;

    While Not cdsConsulta.IsEmpty Do
      pExcluiItem(True);

    cdsItensGiroAux := TUniClientDataSet.Create(Self);
    intMesGir := recDadGiro.intMesGir;

    cdsItensGiroAux.Data := TfrmCadCotacao(frmCadCotacao).fRetornaProdutosGiroCotacao(recDadGiro, oleItensMultiLojas);

    If cdsItensGiroAux.Data <> Null then
    Begin
      cdsItensGiro.Data := cdsItensGiroAux.Data;

      If Assigned(cdsItensMultiLojas) Then
      Begin
        If cdsItensMultiLojas.Active then
          cdsItensMultiLojas.EmptyDataSet;

        cdsItensMultiLojas.Data := oleItensMultiLojas;
        pCentralizaCamposMultLoja;
      End;

      If cdsItensGiro.Data <> null Then
      Begin

        pSalvaDadosGiro;

        If Assigned(pgbStatus) Then
        Begin
          pgbStatus.Properties.Max := cdsItensGiro.RecordCount;
          TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := 'Aguarde, inserindo produtos...';
        End;

        cdsItensGiro.First;

        while Not cdsItensGiro.Eof Do
        Begin
          edtCodIte.Text := cdsItensGiro.FieldByName('ITE_CODITE').AsString;
          If fValidaCampos(edtCodIte, True) Then
          Begin
            edtQtdIte.Text := cdsItensGiro.FieldByName('ITE_QTDITE').AsString;
            pIncluiItem(edtCodIte.Text, edtDesIte.Text, fStrToFloat(edtQtdIte.Text),
                        cdsItensGiro.FieldByName('ITE_SALDOS').AsFloat,
                        cdsItensGiro.FieldByName('ITE_SALDIS').AsFloat,
                        cdsItensGiro.FieldByName('ITE_DIAEST').AsFloat,
                        cdsItensGiro.FieldByName('ITE_DIASUG').AsFloat,
                        cdsItensGiro.FieldByName('ITE_PRECUS').AsFloat);
          End;
          cdsItensGiro.Next;

          If Assigned(pgbStatus) Then
            pgbStatus.Position := cdsItensGiro.RecNo;

          Application.ProcessMessages;
        end;

      End;
    End Else
    Begin
      recDadGiro.intMesGir := intMesGir;
    End;

    FreeAndNil(cdsItensGiroAux);

    If cdsConsulta.IsEmpty Then
    Begin
      fMensagem('','Nenhum produto foi inserido com os filtros informados!', ['&Ok'])
    End

    Else pDisplayGiro;
  End;

  blnValidaQuantidade := True;
end;

procedure TfrmCadCotItens.pDisplayGiro;
Begin
  With RecDadGiro do
  If Assigned(cdsItensGiro) And cdsItensGiro.Active Then
  Begin
    pMascaraCamposGiro(cdsItensGiro, intMesMos);
  End;

  cdsConsulta.AfterScroll := pConsultaAfterScroll;
  cdsConsulta.First;
End;

procedure TfrmCadCotItens.btnSimilaresClick(Sender: TObject);
  Var
    strAutIncSim,
    strCodFab,
    strCodIte: String;
    blnEnterSim: Boolean;
begin
  inherited;

  If Not TfrmFatMostraProdSimilar.fMostraSimilar(cdsConsulta.FieldByName('CODSIM').AsString,
                                                 cdsConsulta.FieldByName('CODITE').AsString,
                                                 cdsConsulta.FieldByName('DESITE').AsString ,
                                                 '1',
                                                 blnEnterSim,
                                                 strAutIncSim,
                                                 strCodFab,
                                                 strCodIte,
                                                 True,
                                                 False,
                                                 False,
                                                 True) Then
    fMensagem('', 'Não há itens similares!', ['&O k']);

  If (blnEnterSim) Then
  Begin
    edtCodIte.Text := strCodIte;

    If fValidaCampos(edtCodIte, True) Then
      pSetFocus(edtQtdIte);

  End;
end;

procedure TfrmCadCotItens.btnExcluirClick(Sender: TObject);
begin
  inherited;

  pExcluiItem;

  pSetFocus(dbgConsulta);
end;

Function TfrmCadCotItens.fSQLUltimaCompra: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   ITE_DTAULT, ';
  strSQL := strSQL + '   ITE_FORULT, ';
  strSQL := strSQL + '   ITE_PREULT  ';
  strSQL := strSQL + ' FROM ITEGER   ';
  strSQL := strSQL + ' WHERE ITE_CODITE = :CODITE ';
  strSQL := strSQL + ' ORDER BY ITE_DTAULT DESC, ITE_DHUPES DESC LIMIT 1';

  Result := strSQL;
End;

procedure TfrmCadCotItens.FormCreate(Sender: TObject);
begin
  inherited;

  qryConIte           := fCriaQuery(Self);
  qryUltCom           := fCriaQuery(Self);
  qryUltCom.SQL.Text  := fSQLUltimaCompra;

  cdsItensGiro        := TUniClientDataSet.Create(Self);
  cdsReq              := TUniClientDataSet.Create(Nil);
  dtsIteGir.DataSet   := cdsItensGiro;
  blnValidaQuantidade := True;
  cdsItensMultiLojas  := Nil;
  cdsDigMultLoja      := Nil;

  FillChar(recDadGiro, SizeOf(recDadGiro), #0);
  recDadGiro.intMesGir := 3;
  recDadGiro.intMesMos := INT_QTD_MES_MOSTRA_GIRO;
  recDadGiro.strMeses  := fMontaStrMeses(recDadGiro.intMesMos);

  blnEdiCot := fCfgSis('EDICOT', varBoolean);
  if blnEdiCot Then
  Begin
    edtDesIte.TabStop     := True;
    edtDesIte.Enabled     := True;
    edtDesIte.ReadOnly    := False;
    edtDesIte.Color       := edtCodIte.Color;
    edtDesIte.NormalColor := edtCodIte.NormalColor;
  End;

  blnFecharComEscape      := False;
end;

procedure TfrmCadCotItens.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsReq);
  pFreeAndNil(frmCadCotItensImpRequisicao);

  If Assigned(cdsDigMultLoja) Then
    pFreeAndNil(cdsDigMultLoja);

  inherited;
end;

procedure TfrmCadCotItens.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
   VK_F3: Key := 0;
   VK_F5: Key := 0;
   VK_F6: Begin
            btnGiroEst.Click;
            Key := 0;
          End;
   VK_F7: Begin
            btnImporta.Click;
            Key := 0;
          End;

   VK_F8: Begin
            btnPrepTE.Click;
            Key := 0;
          End;

   VK_F9: Begin
            btnSemelhantes.Click;
            Key := 0;
          End;

   VK_F11: Begin
             btnSimilares.Click;
             Key := 0;
           End;
  End;
end;

procedure TfrmCadCotItens.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  If Not cdsConsulta.Active Then
    Exit;

  If Pos(Column.FieldName, 'DTAULT_FORULT_PREULT') > 0 Then
  Begin
    dbgConsulta.Canvas.Brush.Color := 13434828;
    dbgConsulta.Canvas.Font.Color  := clBlack;
    dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;

  inherited;
end;

procedure TfrmCadCotItens.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  case Key Of
    VK_RETURN : With cdsConsulta Do
                Begin

                  If Not IsEmpty then
                  Begin
                    edtCodIte.Text := FieldByName('CODITE').AsString;
                    edtDesIte.Text := FieldByName('DESITE').AsString;
                    edtQtdIte.Text := FormatFloat('#0.00', FieldByName('QTDITE').AsFloat);

                    pHabilitaDescricao(Pos('ITEM ESPECIAL', FieldByName('DESCRI').AsString) > 0);

                    edtCodIte.ReadOnly := blnMljLoj;

                    If blnMljLoj Then
                      fValidaCampos(edtQtdIte, True)
                    Else
                      pSetFocus(edtCodIte);

                  End Else
                  Begin
                    edtCodIte.ReadOnly := False;
                    pSetFocus(edtCodIte);
                  End;

                End;

    VK_ESCAPE: Begin
                 If Shift = [ssCtrl] Then
                   Key := 0;
               End;
  End;

end;

procedure TfrmCadCotItens.pDesabilitaAlteracao;
Begin
  pnlTail.Visible    := FALSE;
  btnIncluir.Visible := FALSE;
  btnExcluir.Visible := FALSE;
  btnGiroEst.Visible := FALSE;
end;

end.

