unit untPreOrcamentoEdicao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, cxGraphics, cxControls, cxLookAndFeels, Uni, untFuncoesPedidoSimples,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, untZClient,
  cxGridBandedTableView, cxGridDBBandedTableView, cxCurrencyEdit,
  untPreOrcamento, Vcl.DBCtrls, DBMemoFocus, Vcl.Mask, MaskEditFocus,
  DBEditFocus, cxGridDBDataDefinitions, dxCore, cxVariants, cxCheckBox, untTelaGiroUmaPasta, Datasnap.DBClient,
  cxVGrid, cxInplaceContainer,cxDropDownEdit, cxButtonEdit, cxTextEdit,
  cxCalendar;

type
  TPosicaoRegistro = record
    intRecordIndex,
    intPosition: Integer;
  end;


  TPosicaoRegistroPrt = ^TPosicaoRegistro;

  TMycxGridDBbandedTableView = class(TcxGridDBbandedTableView)
  protected
    function GetDataControllerClass: TcxCustomDataControllerClass; override;
  end;

  TMycxGridDBBandedDataController = class(TcxGridDBDataController)
  Private
    Procedure SetOrdenar(Value: Boolean);
    Function GetOrdenar: Boolean;

  protected

    function CreateDataControllerInfo: TcxCustomDataControllerInfo; override;
  property
    blnOrdenar: Boolean Read GetOrdenar Write SetOrdenar;
  end;

  TMycxCustomDataControllerInfo = class(TcxCustomDataControllerInfo)
  protected
    procedure DoSort; override;
  public
    blnOrdenar: Boolean;
  end;

  TcxGridDBBandedTableView = class (TMycxGridDBBandedTableView);


  TfrmPreOrcamentoEdicao = class(TfrmPaiConfirma)
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxvItens: TcxGridDBBandedTableView;
    cxvItensDESBAN: TcxGridDBBandedColumn;
    cxvItensCODEMP: TcxGridDBBandedColumn;
    cxvItensREFERE: TcxGridDBBandedColumn;
    cxvItensDESITE: TcxGridDBBandedColumn;
    cxvItensSUGEST: TcxGridDBBandedColumn;
    cxvItensVALTOT: TcxGridDBBandedColumn;
    cxvItensQTDITE: TcxGridDBBandedColumn;
    cxvItensVALUNI: TcxGridDBBandedColumn;
    cxvItensVALIPI: TcxGridDBBandedColumn;
    cxvItensVALSUB: TcxGridDBBandedColumn;
    cxvItensPERDES: TcxGridDBBandedColumn;
    cxvItensESTDIS: TcxGridDBBandedColumn;
    cxvItensPEDCOM: TcxGridDBBandedColumn;
    cxvItensMEDMEM: TcxGridDBBandedColumn;
    cxvItensVMES00: TcxGridDBBandedColumn;
    cxvItensVMES01: TcxGridDBBandedColumn;
    cxvItensVMES02: TcxGridDBBandedColumn;
    cxvItensVMES03: TcxGridDBBandedColumn;
    cxvItensVMES04: TcxGridDBBandedColumn;
    cxvItensVMES05: TcxGridDBBandedColumn;
    cxvItensVMES06: TcxGridDBBandedColumn;
    cxvItensVMES07: TcxGridDBBandedColumn;
    cxvItensVMES08: TcxGridDBBandedColumn;
    cxvItensVMES09: TcxGridDBBandedColumn;
    cxvItensVMES10: TcxGridDBBandedColumn;
    cxvItensVMES11: TcxGridDBBandedColumn;
    cxvItensVMES12: TcxGridDBBandedColumn;
    cxvItensESTMIN: TcxGridDBBandedColumn;
    cxvItensESTMAX: TcxGridDBBandedColumn;
    cxvItensDIASUG: TcxGridDBBandedColumn;
    cxvItensIND_PP: TcxGridDBBandedColumn;
    cxvItensINDRUP: TcxGridDBBandedColumn;
    btnTotEmp: TBitBtnLocked;
    cxvItensDIAGIR: TcxGridDBBandedColumn;
    cxvItensMLTCOM: TcxGridDBBandedColumn;
    cxvItensUSAMES: TcxGridDBBandedColumn;
    cxvItensMESGIR: TcxGridDBBandedColumn;
    cxvItensNIVGIR: TcxGridDBBandedColumn;
    btnSatelites: TBitBtnLocked;
    btnSimilares: TBitBtnLocked;
    cxvItensCODITE: TcxGridDBBandedColumn;
    cxvItensDESTRE: TcxGridDBBandedColumn;
    pnlFornecedor: TPanel;
    pnlAplicacao: TPanel;
    splAplicacao: TSplitter;
    pnlProduto: TPanel;
    Label2: TLabel;
    edtDesIte: TEditFocus;
    Label1: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    lblHub: TLabel;
    edtHub: TEditFocus;
    pnlCndPag: TPanel;
    Label21: TLabel;
    Label22: TLabel;
    chkPgAVis: TCheckBox;
    Label5: TLabel;
    cxvItensUNILIQ: TcxGridDBBandedColumn;
    dbeDesAdi: TDBEditFocus;
    dbeConPag: TDBEditFocus;
    dtsGPREOR: TDataSource;
    cxvItensDIAEST: TcxGridDBBandedColumn;
    cxvItensANTIGO: TcxGridDBBandedColumn;
    cxvItensCORBAN: TcxGridDBBandedColumn;
    cxvItensDESMAR: TcxGridDBBandedColumn;
    cxvItensDTAULT: TcxGridDBBandedColumn;
    cxvItensDTAUVE: TcxGridDBBandedColumn;
    btnPedCompGrid: TBitBtnLocked;
    cxvItensPRECUS: TcxGridDBBandedColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxvItensColumn1: TcxGridDBBandedColumn;
    cxvItensColumn2: TcxGridDBBandedColumn;
    cxvItensMARDES: TcxGridDBBandedColumn;
    Panel2: TPanel;
    btnDesmarcaTodos: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnmarcaDesmarca: TBitBtnLocked;
    Panel3: TPanel;
    chkSuspOrdem: TCheckBox;
    chkNextLine: TCheckBox;
    chkFiSemNecCom: TCheckBox;
    Panel4: TPanel;
    Panel1: TPanel;
    pnlTitAplic: TPanel;
    dbeAplica: TDBMemoFocus;
    lblResPad: TLabel;
    Label3: TLabel;
    Shape1: TShape;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblAgrupador: TLabel;
    lblComprador: TLabel;
    lblMarca: TLabel;
    lblFornecedor: TLabel;
    lblDepartemento: TLabel;
    Panel5: TPanel;
    Label10: TLabel;
    edtProdutoDoRodape: TEditFocus;
    tmrAtualizaRodape: TTimer;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    Panel6: TPanel;
    ScrollBox1: TScrollBox;
    pnlContainer: TPanel;
    Splitter1: TSplitter;
    pnlPanelGiro: TPanel;
    pnlContAling: TPanel;
    pnlContainerResumidos: TPanel;
    Panel7: TPanel;
    cxVerticalGrid3: TcxVerticalGrid;
    cxCategoryRow2: TcxCategoryRow;
    cxVerCurvA: TcxEditorRow;
    cxVerCurvB: TcxEditorRow;
    cxVerCurvC: TcxEditorRow;
    cxVerticalGrid2: TcxVerticalGrid;
    cxCategoryRow1: TcxCategoryRow;
    cxVerCurvX: TcxEditorRow;
    cxVerCurvY: TcxEditorRow;
    cxVerCurvZ: TcxEditorRow;
    Panel9: TPanel;
    cxVerticalGrid1: TcxVerticalGrid;
    cxVerticalGrid1CategoryRow1: TcxCategoryRow;
    cxVerTotPed: TcxEditorRow;
    cxVerQtdTotPed: TcxEditorRow;
    cxVerPesTotPed: TcxEditorRow;
    cxVerLitTotPed: TcxEditorRow;
    cxVerMetTotPed: TcxEditorRow;
    cxvItensColumn3: TcxGridDBBandedColumn;
    btnEstoqueLojas: TBitBtnLocked;
    lblDescSobEnc: TLabel;
    lblValDescSobEnc: TLabel;
    lblLinGru: TLabel;
    lblValLinGru: TLabel;
    lblFilEmp: TLabel;
    lblValFilEmp: TLabel;
    cxvItensESTEXCESSO: TcxGridDBBandedColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cxvItensQTDITECustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvItensIND_PPGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxvItensINDRUPGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxvItensQTDITEPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvItensDIAGIRCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvItensVMES07CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvItensVMES04CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvItensVMES01CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvItensVMES00CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnTotEmpClick(Sender: TObject);
    procedure btnSatelitesClick(Sender: TObject);
    procedure btnSimilaresClick(Sender: TObject);
    procedure lblResPadClick(Sender: TObject);
    procedure dbeDesAdiEnter(Sender: TObject);
    procedure dbeDesAdiExit(Sender: TObject);
    procedure chkPgAVisClick(Sender: TObject);
    procedure cxvItensCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvItensPERDESCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvItensPERDESPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnPedCompGridClick(Sender: TObject);
    procedure cxvItensColumnHeaderClick(Sender: TcxGridTableView; AColumn: TcxGridColumn);
    procedure cxvItensDataControllerCompare(ADataController: TcxCustomDataController; ARecordIndex1, ARecordIndex2, AItemIndex: Integer; const V1, V2: Variant; var Compare: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure chkSuspOrdemClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnmarcaDesmarcaClick(Sender: TObject);
    procedure pEscreveTotalizadores;
    procedure cxvItensUNILIQPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxvItensUNILIQCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure chkFiSemNecComClick(Sender: TObject);
    procedure tmrAtualizaRodapeTimer(Sender: TObject);
    procedure cxvItensCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxVerLitTotPedEditPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure btnEstoqueLojasClick(Sender: TObject);
    procedure pMostraEstoqueLojasComGiro;
    procedure cxvItensSUGESTGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);

  private
    { Private declarations }
    fltPerDesAdiOLD: Double;

    blnGerouPedido: Boolean;
    blnAtualizarRodape: Boolean;

    objPreOrcamento: TPreOrcamento;

    frmTelaGiroUmaLoc: TfrmTelaGiroUmaPasta;

    Function fRetornaQtqMes: Integer;

    procedure pAfterScrollOrcamento(dtsDados: TDataSet);


  public
    { Public declarations }
    blnAlterouDados: Boolean;
    blnRestaurar: Boolean;
    lstOrdemResgistros: TList;


    strCodMar,
    strCodDep,
    strCodFor,
    strNomFor,
    strEmpHub,
    strCodIte,
    strCodSim,
    strLinGru,
    strFilEmp: String;

    blnConsEnc: Boolean;

    recOpcGir: TRecOpcoesGiro;

    ticConsulta: TTipoConsulta;
    function fGetPositionByRecordIndex(ARecordIndex: Integer): Integer;
    procedure pSalvaOrdenacao;
    procedure pLiberaOrdenacao;


  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmPreOrcamentoEdicao: TfrmPreOrcamentoEdicao;

implementation

{$R *.dfm}

Uses
  StrUtils,
  Math,
  untConstantes,
  untFuncoesSimples,
  untResumoPedido,
  untSalvaConfiguracaoGrid,
  untTFatEntregaFutura,
  untMostraEstoqueGiroEmp,
  untConfirmarGeracaoPedidos,
  untPnlDadosItemPai,
  untTypesSistema;

procedure TfrmPreOrcamentoEdicao.btnmarcaDesmarcaClick(Sender: TObject);
begin
  inherited;
  objPreOrcamento.pMarcaDesmarca();
end;

procedure TfrmPreOrcamentoEdicao.btnConfirmaClick(Sender: TObject);
begin
  // inherited;

  If fVerificaCampos And objPreOrcamento.cdsCabecOrc.fSalva And objPreOrcamento.fSalva('Gravando dados, aguarde...') Then
  Begin
    blnAlterouDados := True;

    pMensagemOk('Informações salvas!');
    objPreOrcamento.fCarregaItens(strCodFor, strEmpHub, strCodIte, strCodSim, strCodMar, strCodDep, ticConsulta, False, blnConsEnc, strLinGru, strFilEmp);
  End;

  If Not(objPreOrcamento.cdsCabecOrc.State In dsEditModes) Then
    objPreOrcamento.cdsCabecOrc.Edit;
end;

procedure TfrmPreOrcamentoEdicao.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  objPreOrcamento.pMarcaDesmarcaTodos(False);

end;

procedure TfrmPreOrcamentoEdicao.btnEstoqueLojasClick(Sender: TObject);
begin
  inherited;
  pMostraEstoqueLojasComGiro;
end;

Procedure TfrmPreOrcamentoEdicao.pMostraEstoqueLojasComGiro;
Var
    strSQL     : String;
    intContador: Integer;
    intQtdMes  : Integer;

    wrdDia, wrdMes, wrdAno: Word;

    qryEmpresa : TUniQuery;
    strEmpresa : String;

    DataSet: TDataSet;

    qryAux: TZClient;
    dtsAux: TDataSource;
begin

  If (recOpcGir.intMesGir = 0) Then
    intQtdMes := 3
  Else
    intQtdMes := recOpcGir.intMesGir;

  qryEmpresa := fCriaQuery(Self);

  qryAux     := TZClient.Create(Self);
  dtsAux     := qryAux.dtsSource;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  EMP_CODEMP AS CODEMP ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADEMP ';
  strSQL := strSQL + 'ORDER BY EMP_CODEMP ';

  qryEmpresa.Close;
  qryEmpresa.SQL.Clear;
  qryEmpresa.SQL.Add(strSQL);
  qryEmpresa.Open;

  strSQL := '';

  While Not qryEmpresa.Eof Do
  Begin
    strEmpresa := QuotedStr(qryEmpresa.fieldbyname('CODEMP').AsString);

    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  G.ITE_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  E.EMP_NOMEMP AS NOMEMP, ';
    strSQL := strSQL + '  I.ITE_CODITE AS CODIGO, ';
    strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';

    // SALDO FISICO
    strSQL := strSQL + '  (SELECT ';
    strSQL := strSQL + '     IFNULL(SUM(ITEGER.ITE_SALDOS + IF(IFNULL(ITE_CNV_ML, 0) > 0, IFNULL(ITE_SAL_ML, 0) / ITE_CNV_ML, 0)),0) ';
    strSQL := strSQL + '   FROM ';
    strSQL := strSQL + '     ITEGER ';
    strSQL := strSQL + '   WHERE ';
    strSQL := strSQL + '     ITEGER.ITE_CODITE = I.ITE_CODITE AND ';
    strSQL := strSQL + '     ITEGER.ITE_CODEMP = ' + strEmpresa + ') ';

    If fUsaQtdPendenteEntregaFutura Then
      strSQL := strSQL + ' + ' + fGetSQLSomaCamposEntregaFutura('G', True);

    strSQL := strSQL + ' AS SALDOS, ';

    // SALDO DISPONIVEL
    strSQL := strSQL + fSQLSaldoDisponivel('G', True, False, True) + ' AS SALDIS, ';

    //Entrega Futura
    strSQL := strSQL + ' 0.000 AS ENTFUT, ';

    // MEDIA
    DecodeDate(VS_date, wrdAno, wrdMes, wrdDia);
    Dec(wrdMes);
    strSQL := strSQL + '  (( ';
    For intContador := 1 To intQtdMes Do
    Begin
      If (wrdMes = 0) Then
      Begin
        wrdMes := 12;
        Dec(wrdAno);
      End;

      strSQL := strSQL + '  SUM(IFNULL((SELECT GIR_QSAI' + fStrZero(wrdMes, 2) + ' FROM GIRITE WHERE GIR_CODITE = G.ITE_CODITE AND GIR_CODEMP = G.ITE_CODEMP AND GIR_CODEMP = ' + strEmpresa + ' AND GIR_A_N_O_ = ' + fStrZero(wrdAno, 4) + '),0)) + ';

      Dec(wrdMes);
    End;
    strSQL := copy(strSQL,1,length(strSQL)-2);
    strSQL := strSQL + '  ) / ' + IntToStr(intQtdMes) + ') AS MEDIA, ';

    // GIRO
    DecodeDate(VS_date, wrdAno, wrdMes, wrdDia);
    Dec(wrdMes);
    For intContador := 1 To intQtdMes Do
    Begin
      If (wrdMes = 0) Then
      Begin
        wrdMes := 12;
        Dec(wrdAno);
      End;

      strSQL := strSQL + '  SUM(IFNULL((SELECT GIR_QSAI' + fStrZero(wrdMes, 2) + ' FROM GIRITE WHERE GIR_CODITE = G.ITE_CODITE AND GIR_CODEMP = G.ITE_CODEMP AND GIR_CODEMP = ' + strEmpresa + ' AND GIR_A_N_O_ = ' + fStrZero(wrdAno, 4) + '),0)) AS MES' + fStrZero(IntToStr(intContador), 3) + ' , ';

      Dec(wrdMes);
    End;
    strSQL := copy(strSQL,1,length(strSQL)-2);

    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G, ';
    strSQL := strSQL + '  CADEMP E ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = E.EMP_CODEMP AND ';
    strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = ' + strEmpresa + ' ' ;
    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  CODIGO, DESITE ';

    qryEmpresa.Next;

    If Not qryEmpresa.Eof Then
      strSQL := strSQL + '  UNION ALL  ';
  End;

  strSQL := strSQL + ' ORDER BY ';
  strSQL := strSQL + '   CODEMP ';

  DataSet := cxvItens.DataController.DataSet;

  With qryAux Do
  Begin
    Close;
    qryQuery.SQL.Clear;
    qryQuery.SQL.Add(strSQL);
    qryQuery.ParamByName('CODITE').AsString := DataSet.FieldByName('PRE_CODITE').AsString;

    fAbreClient;

    (FieldByName('SALDOS') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('SALDIS') As TFloatField).DisplayFormat := '#,##0.000';
    (FieldByName('MEDIA')  As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENTFUT')  As TFloatField).DisplayFormat := '#,##0.00';

    For intContador := 1 To intQtdMes Do
    Begin
      (FieldByName('MES' + fStrZero(IntToStr(intContador), 3) ) As TFloatField).DisplayFormat := '#,##0.00';
    End;

    While Not Eof Do
    Begin
      Edit;
      FieldByName('ENTFUT').AsFloat := TEntregaFutura.New(
                                         TParamEF.New()
                                           .CodIte(FieldByName('CODIGO').AsString)
                                           .CodEmp(FieldByName('CODEMP').AsString)
                                           .Faturamento(True)
                                         ).Total();
      Post;

      Next;
    End;

    First;

    Try
      pCriarFormularios(TfrmMostraEstoqueGiroEmp, frmMostraEstoqueGiroEmp);
      frmMostraEstoqueGiroEmp.cxvEstoque.DataController.DataSource := dtsAux;
      frmMostraEstoqueGiroEmp.edtItem.Text := DataSet.FieldByName('PRE_CODITE').AsString + ' - ' +
                                              DataSet.FieldByName('PRE_DESITE').AsString;

      {*********************************************}
      {* ALTERANDO O NOME DAS COLUNAS DO GRID      *}
      {******************************************LU*}
      frmMostraEstoqueGiroEmp.cxvEstoqueMES001.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -1));
      frmMostraEstoqueGiroEmp.cxvEstoqueMES002.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -2));
      frmMostraEstoqueGiroEmp.cxvEstoqueMES003.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -3));
      frmMostraEstoqueGiroEmp.lblQtdM04.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -4));
      frmMostraEstoqueGiroEmp.lblQtdM05.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -5));
      frmMostraEstoqueGiroEmp.lblQtdM06.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -6));
      frmMostraEstoqueGiroEmp.lblQtdM07.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -7));
      frmMostraEstoqueGiroEmp.lblQtdM08.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -8));
      frmMostraEstoqueGiroEmp.lblQtdM09.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -9));
      frmMostraEstoqueGiroEmp.lblQtdM10.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -10));
      frmMostraEstoqueGiroEmp.lblQtdM11.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -11));
      frmMostraEstoqueGiroEmp.lblQtdM12.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -12));

      frmMostraEstoqueGiroEmp.pnlGiroMeses.Visible := intQtdMes > 3;

      If intQtdMes = 6 Then
      Begin
        frmMostraEstoqueGiroEmp.lblQtdM04.Visible := True;
        frmMostraEstoqueGiroEmp.lblQtdM05.Visible := True;
        frmMostraEstoqueGiroEmp.lblQtdM06.Visible := True;

        frmMostraEstoqueGiroEmp.dbeQtdM04.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM05.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM06.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM04.DataSource := dtsAux;
        frmMostraEstoqueGiroEmp.dbeQtdM05.DataSource := dtsAux;
        frmMostraEstoqueGiroEmp.dbeQtdM06.DataSource := dtsAux;
      End
      Else If intQtdMes = 12 Then
      Begin
        frmMostraEstoqueGiroEmp.lblQtdM04.Visible := True;
        frmMostraEstoqueGiroEmp.lblQtdM05.Visible := True;
        frmMostraEstoqueGiroEmp.lblQtdM06.Visible := True;
        frmMostraEstoqueGiroEmp.lblQtdM07.Visible := True;
        frmMostraEstoqueGiroEmp.lblQtdM08.Visible := True;
        frmMostraEstoqueGiroEmp.lblQtdM09.Visible := True;
        frmMostraEstoqueGiroEmp.lblQtdM10.Visible := True;
        frmMostraEstoqueGiroEmp.lblQtdM11.Visible := True;
        frmMostraEstoqueGiroEmp.lblQtdM12.Visible := True;

        frmMostraEstoqueGiroEmp.dbeQtdM04.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM05.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM06.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM07.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM08.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM09.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM10.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM11.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM12.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM04.DataSource := dtsAux;
        frmMostraEstoqueGiroEmp.dbeQtdM05.DataSource := dtsAux;
        frmMostraEstoqueGiroEmp.dbeQtdM06.DataSource := dtsAux;
        frmMostraEstoqueGiroEmp.dbeQtdM07.DataSource := dtsAux;
        frmMostraEstoqueGiroEmp.dbeQtdM08.DataSource := dtsAux;
        frmMostraEstoqueGiroEmp.dbeQtdM09.DataSource := dtsAux;
        frmMostraEstoqueGiroEmp.dbeQtdM10.DataSource := dtsAux;
        frmMostraEstoqueGiroEmp.dbeQtdM11.DataSource := dtsAux;
        frmMostraEstoqueGiroEmp.dbeQtdM12.DataSource := dtsAux;
      End;

      frmMostraEstoqueGiroEmp.showModal;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmPedidoDeCompra.pMostraEstoqueLojasComGiro]');
      End;
    End;

    pFreeAndNil(frmMostraEstoqueGiroEmp);
    Close;

  End;

  FreeAndNil(qryAux);
end;

procedure TfrmPreOrcamentoEdicao.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  objPreOrcamento.pMarcaDesmarcaTodos(True);
end;

procedure TfrmPreOrcamentoEdicao.btnPedCompGridClick(Sender: TObject);
begin
  inherited;

  TFrmPnlDadosItemPai.pExibePedidosDeCompraGrid(objPreOrcamento.FieldByName('PRE_CODITE').AsString,
    objPreOrcamento.FieldByName('PRE_DESITE').AsString, True);
end;

procedure TfrmPreOrcamentoEdicao.btnSatelitesClick(Sender: TObject);
var
  frmPreOrcamentoSatelites: TfrmPreOrcamentoEdicao;
  blnRestaurar: Boolean;
begin
  inherited;

  If objPreOrcamento.IsEmpty Then
    Exit;

  Try
    Repeat
      pCriarFormularios(TfrmPreOrcamentoEdicao, frmPreOrcamentoSatelites);

      frmPreOrcamentoSatelites.Caption := 'Detalhe dos Satélites';

      If objPreOrcamento.blnGlobal Then
        frmPreOrcamentoSatelites.Caption := frmPreOrcamentoSatelites.Caption + ' - Valores por empresa';

      frmPreOrcamentoSatelites.WindowState := wsNormal;
      frmPreOrcamentoSatelites.ticConsulta := ticSatelites;
      frmPreOrcamentoSatelites.edtHub.Text := objPreOrcamento.FieldByName('PRE_SIGEMP').AsString;

      frmPreOrcamentoSatelites.edtDesIte.Text := objPreOrcamento.FieldByName('PRE_CODITE').AsString + ' - ' +
        objPreOrcamento.FieldByName('PRE_DESITE').AsString;

      frmPreOrcamentoSatelites.strEmpHub := objPreOrcamento.FieldByName('PRE_EMPHUB').AsString;
      frmPreOrcamentoSatelites.strCodIte := objPreOrcamento.FieldByName('PRE_CODITE').AsString;
      frmPreOrcamentoSatelites.strCodFor := strCodFor;
      frmPreOrcamentoSatelites.strNomFor := strNomFor;

      frmPreOrcamentoSatelites.ShowModal;

      blnRestaurar := frmPreOrcamentoSatelites.blnRestaurar;

      pFreeAndNil(frmPreOrcamentoSatelites);

    Until Not blnRestaurar;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmPreOrcamentoEdicao.btnSatelitesClick]');
    End;
  End;
end;

procedure TfrmPreOrcamentoEdicao.btnSimilaresClick(Sender: TObject);
var
  frmPreOrcamentoSimilares: TfrmPreOrcamentoEdicao;
  blnRestaurar: Boolean;
begin
  inherited;

  If objPreOrcamento.IsEmpty Then
    Exit;

  Try
    Repeat
      pCriarFormularios(TfrmPreOrcamentoEdicao, frmPreOrcamentoSimilares);

      frmPreOrcamentoSimilares.Caption := 'Produtos Similares';
      frmPreOrcamentoSimilares.WindowState := wsNormal;
      frmPreOrcamentoSimilares.ticConsulta := ticSimilares;

      frmPreOrcamentoSimilares.edtDesIte.Text := objPreOrcamento.FieldByName('PRE_REFERE').AsString + ' - ' +
        objPreOrcamento.FieldByName('PRE_DESITE').AsString;

      frmPreOrcamentoSimilares.strCodSim := objPreOrcamento.FieldByName('PRE_CODSIM').AsString;

      frmPreOrcamentoSimilares.ShowModal;

      blnRestaurar := frmPreOrcamentoSimilares.blnRestaurar;

      pFreeAndNil(frmPreOrcamentoSimilares);

    Until Not blnRestaurar;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmPreOrcamentoEdicao.btnSimilaresClick]');
    End;
  End;
end;

procedure TfrmPreOrcamentoEdicao.btnTotEmpClick(Sender: TObject);
var strProdutos: String;
    bmkItem: TBookmark;

begin
  inherited;

  If objPreOrcamento.IsEmpty Then
    Exit;

  If Not fVerificaCampos Then
    Exit;

  objPreOrcamento.cdsCabecOrc.fSalva;

  If objPreOrcamento.fSalva('Gravando dados, aguarde...') Then
    blnAlterouDados := True;


  If objPreOrcamento.fQtdItensMarcados = 0 Then
  Begin
    pMensagemOk('É preciso marcar ao menos um item para gerar o Pedido de Compra!');
    Exit;
  End;

  strProdutos := '';

  cxvItens.DataController.DataSet.DisableControls;
  bmkItem := cxvItens.DataController.DataSet.GetBookmark;

  While Not cxvItens.DataController.DataSet.Eof Do
  Begin
    If cxvItens.DataController.DataSet.FieldByName('MARDES').AsInteger > 0 Then
      strProdutos := strProdutos + IIF(strProdutos = '', '', ',') + QuotedStr(cxvItens.DataController.DataSet.FieldByName('PRE_CODITE').AsString);

    cxvItens.DataController.DataSet.Next;
  end;

  cxvItens.DataController.DataSet.GotoBookmark(bmkItem);
  cxvItens.DataController.DataSet.FreeBookmark(bmkItem);
  cxvItens.DataController.DataSet.EnableControls;

  If TfrmConfirmarGeracaoPedidos.fPedeConfirmacaoGeracaoPedido(strProdutos) Then
  Begin

    Try
      pCriarFormularios(TfrmResumoPedido, frmResumoPedido);
      frmResumoPedido.strCodFor := edtCodFor.Text;
      frmResumoPedido.blnGerarPedido := True;
      frmResumoPedido.strConPag := dbeConPag.Field.AsString;

      frmResumoPedido.ShowModal;

      blnGerouPedido := frmResumoPedido.blnGerouPedido;

      pFreeAndNil(frmResumoPedido);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmPreOrcamentoEdicao.btnTotEmpClick]');
      End;
    End;
  End;

  If blnGerouPedido Then
    Close;
end;

procedure TfrmPreOrcamentoEdicao.chkFiSemNecComClick(Sender: TObject);
begin
  inherited;
  objPreOrcamento.pFiltrarComSugestao(chkFiSemNecCom.Checked);
end;

procedure TfrmPreOrcamentoEdicao.chkPgAVisClick(Sender: TObject);
begin
  inherited;

  If chkPgAVis.Checked Then
  Begin
    If (objPreOrcamento.intCarPag = 0) Then
      dbeConPag.Field.Value := '01000'
    Else
      dbeConPag.Field.Value := '01' + fStrZero(objPreOrcamento.intCarPag, 3);

    dbeConPag.Enabled := False;
  End
  Else
    dbeConPag.Enabled := True;
end;

procedure TfrmPreOrcamentoEdicao.chkSuspOrdemClick(Sender: TObject);
begin
  inherited;
  If chkSuspOrdem.Checked Then
    pSalvaOrdenacao;

  TMycxGridDBBandedDataController(cxvItens.DataController).blnOrdenar := Not chkSuspOrdem.Checked;

  cxvItens.DataController.Refresh;

  If Not chkSuspOrdem.Checked Then
    pSalvaOrdenacao;

end;

procedure TfrmPreOrcamentoEdicao.cxvItensCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Var
  intCor: Integer;
  const cMaracado = '1';



begin
  inherited;

  intCor := StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensCORBAN.Index]), 0);

  If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensMARDES.Index]) = cMaracado) And
     (Not ((AViewInfo.Item = cxvItensQTDITE) Or
          (AViewInfo.Item = cxvItensDIAGIR) Or
          (AViewInfo.Item = cxvItensVMES07) Or
          (AViewInfo.Item = cxvItensVMES04) Or
    (AViewInfo.Item = cxvItensVMES01) Or
    (AViewInfo.Item = cxvItensVMES00))) Then
    ACanvas.Brush.Color := clAqua;

   if (AViewInfo.Selected) and Sender.Site.Focused then
   begin
     ACanvas.Brush.Color := clHighlight;
   End;

   If intCor > 0 Then
     ACanvas.Font.Color := intCor;

end;

procedure TfrmPreOrcamentoEdicao.cxvItensDIAGIRCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If fRetornaQtqMes <> -1 Then
    ACanvas.Brush.Color := clLtGray;

end;

procedure TfrmPreOrcamentoEdicao.cxvItensINDRUPGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;

  If Atext = '1' Then
    Atext := 'Sim'
  Else
    Atext := 'Não';

end;

procedure TfrmPreOrcamentoEdicao.cxvItensIND_PPGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;

  If Atext = '1' Then
    Atext := 'Sim'
  Else
    Atext := 'Não';

end;

procedure TfrmPreOrcamentoEdicao.cxvItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key = VK_F5 Then
    btnMarcaTodos.Click;

  If Key = VK_F6 Then
    btnDesmarcaTodos.Click;

  If Key = VK_SPACE Then
    btnmarcaDesmarca.Click;


end;

procedure TfrmPreOrcamentoEdicao.cxvItensPERDESCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  ACanvas.Brush.Color := clMoneyGreen;
  ACanvas.Font.Color := clBlue;
end;

procedure TfrmPreOrcamentoEdicao.cxvItensPERDESPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  If (fStrToFloat(DisplayValue) < 0) Or (fStrToFloat(DisplayValue) > 99.00) Then
  Begin
    pMensagemOk('O Desconto deve estar entre 0 e 99 %!');
    Error := True;
    ErrorText := '';
  End

end;

procedure TfrmPreOrcamentoEdicao.cxvItensQTDITECustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  ACanvas.Brush.Color := clMoneyGreen;
  ACanvas.Font.Color := clBlue;
end;

procedure TfrmPreOrcamentoEdicao.cxvItensQTDITEPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
Var
  fltMltCom: Double;
  strMltCom: String;
begin
  inherited;

  strMltCom := VarToStr(cxvItens.DataController.Values[cxvItens.DataController.FocusedRecordIndex, cxvItensMLTCOM.Index]);

  fltMltCom := fStrToFloat(strMltCom);

  If fltMltCom <= 0 Then
    fltMltCom := 1;

  If (fStrToFloat(DisplayValue) < 0) Then
  Begin
    pMensagemOk('A quantidade deve ser maior ou igual a zero!');
    Error := True;
    ErrorText := '';
  End

  Else If (fStrToFloat(DisplayValue) > 0) And
    (Frac(RoundTo(fStrToFloat(DisplayValue) / fltMltCom, -4)) <> 0) Then
  Begin
    pMensagemOk('Quantidade permitida somente em múltiplos de compra (' + FormatFloat('#0.00', fltMltCom)  + ')!');
    Error := True;
    ErrorText := '';
  End;
end;

procedure TfrmPreOrcamentoEdicao.cxvItensSUGESTGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If Pos('-', AText) > 0 Then
    AText := FormatFloat('#0.00',0);
end;

procedure TfrmPreOrcamentoEdicao.cxvItensUNILIQCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
  inherited;
  ACanvas.Brush.Color := clMoneyGreen;
  ACanvas.Font.Color := clBlue;

end;

procedure TfrmPreOrcamentoEdicao.cxvItensUNILIQPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var DataSet : TDataSet;
begin
  inherited;

  DataSet := cxvItens.DataController.DataSet;

  If DisplayValue = '' Then
    DisplayValue := 0;

  Dataset.FieldByName('PRE_UNILIQ').AsFloat := DisplayValue;
  DataSet.FieldByName('PRE_VALUNI').AsFloat  := (DataSet.FieldByName('PRE_UNILIQ').AsFloat * 100) / (100-DataSet.FieldByName('PRE_PERDES').AsFloat);

end;

procedure TfrmPreOrcamentoEdicao.cxvItensVMES00CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  ACanvas.Brush.Color := clLtGray;

end;

procedure TfrmPreOrcamentoEdicao.cxvItensVMES01CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If fRetornaQtqMes < 3 Then
    ACanvas.Brush.Color := clLtGray;

end;

procedure TfrmPreOrcamentoEdicao.cxvItensVMES04CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If fRetornaQtqMes < 6 Then
    ACanvas.Brush.Color := clLtGray;

end;

procedure TfrmPreOrcamentoEdicao.cxvItensVMES07CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If fRetornaQtqMes < 12 Then
    ACanvas.Brush.Color := clMedGray;

end;

procedure TfrmPreOrcamentoEdicao.dbeDesAdiEnter(Sender: TObject);
begin
  inherited;

  fltPerDesAdiOLD := fStrToFloat(dbeDesAdi.Text);
end;

procedure TfrmPreOrcamentoEdicao.dbeDesAdiExit(Sender: TObject);
Var
  fltPerDesAdiNEW: Double;
begin
  inherited;
  fltPerDesAdiNEW := fStrToFloat(dbeDesAdi.Text);

  If (fltPerDesAdiOLD <> fltPerDesAdiNEW) Then
    objPreOrcamento.pRecalculaDescontoItens(fltPerDesAdiNEW);
end;

Function TfrmPreOrcamentoEdicao.fRetornaQtqMes: Integer;
Begin
  Result := -1;

  If cxvItens.DataController.Values[cxvItens.DataController.FocusedRecordIndex, cxvItensUSAMES.Index] = 'S' Then
    Result := cxvItens.DataController.Values[cxvItens.DataController.FocusedRecordIndex, cxvItensMESGIR.Index];
End;

procedure TfrmPreOrcamentoEdicao.lblResPadClick(Sender: TObject);
begin
  inherited;

  Try
    If fPergunta(IIF(ticConsulta = ticCompra, 'As alterações serão salvas, a', 'A') + ' tela será fechada e reaberta, deseja prosseguir?') Then
    Begin

      If (ticConsulta = ticCompra) Then
      Begin
        If Not (fVerificaCampos And objPreOrcamento.cdsCabecOrc.fSalva And objPreOrcamento.fSalva('Gravando dados, aguarde...')) Then
          Exit;

        blnAlterouDados := True;
      End;

      TSalvaConfiguracaoGrid.pApagaConfiguracoes('frmPreOrcamentoEdicao' + TPreOrcamento.fDescricaoTipoPasta(ticConsulta));

      blnRestaurar := True;
      Close;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmPreOrcamentoEdicao.lblResPadClick]');
    End;
  End

end;

procedure TfrmPreOrcamentoEdicao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin


  End Else If (Not blnGerouPedido) And (ticConsulta = ticCompra) And (Not blnRestaurar) Then
  Begin

    If Not fPergunta('Deseja abandonar a tarefa?') Then
      Action := caNone;

  End;

  If Not blnRestaurar Then
    TSalvaConfiguracaoGrid.pSalvaConfiguracoesGrid(cxvItens, 'frmPreOrcamentoEdicao' + TPreOrcamento.fDescricaoTipoPasta(ticConsulta));
end;

procedure TfrmPreOrcamentoEdicao.FormCreate(Sender: TObject);
Var
  strDisplay: String;
  intRows, intRows2, intRows3, intContador, intDecTpc: Integer;
begin
  inherited;
  lstOrdemResgistros := TList.Create;
  TMycxGridDBBandedDataController(cxvItens.DataController).blnOrdenar := True;

  blnAtualizarRodape := False;

  blnRestaurar := False;

  blnGerouPedido := False;
  blnAlterouDados := False;
  ticConsulta := ticCompra;
  strEmpHub := '';
  strCodIte := '';

  blnConsEnc := False;

  objPreOrcamento := TPreOrcamento.Create(Self);

  objPreOrcamento.pEscreveTotalizadores := pEscreveTotalizadores;

  cxvItens.DataController.DataSource := objPreOrcamento.dtsSource;

  dbeAplica.DataSource := objPreOrcamento.dtsSource;

  intDecTpc := fCfgSis('DEQTPC', varInteger);

  strDisplay := '#,##0.' + fStrZero('0', intDecTpc) + ';-0.' + fStrZero('0', intDecTpc);
  TcxCurrencyEditProperties(cxvItensQTDITE.Properties).DecimalPlaces := intDecTpc;
  TcxCurrencyEditProperties(cxvItensQTDITE.Properties).DisplayFormat := strDisplay;

  pCriarFormularios(TfrmTelaGiroUmaPasta, frmTelaGiroUmaLoc);

  With frmTelaGiroUmaLoc Do
  Begin
    frmTelaGiroUmaLoc.Align := alClient;
    parent := pnlPanelGiro;

    cxgItensSALEXT.Visible := fCfgSis('ESTEXT', varBoolean);
    cxgItensSALBAS.Visible := False;
    cxgItensSALGAR.Visible := False;
    cxgItensSALEND.Visible := False;
    cxgItensSALRES.Visible := False;

    cxgItensMEDIXX.Visible := True;
    cxgItensMEDAJU.Visible := False;
    cxgItensPESOIT.Visible := False;
    cxgItensBranco.Visible := False;

    cxgItensORDPRO.Visible := False;
    cxgItensFUTPRE.Visible := False;
    cxgItensFUTFAL.Visible := False;
    cxgItensFUTAGU.Visible := False;

    cxgItensMADTSA.Visible := False;
    cxgItensMAQTSA.Visible := False;
    cxgItensPMED_V.Visible := False;

    lblSalbas.Visible := False;



    intRows := 0;
    For intContador := 0 To cxvSugest.Rows.Count - 1 Do
      If cxvSugest.Rows[intContador].Visible Then
        intRows := intRows + 1;

    intRows2 := 0;
    For intContador := 0 To cxvSaldos.Rows.Count - 1 Do
      If cxvSaldos.Rows[intContador].Visible Then
        intRows2 := intRows2 + 1;

    intRows3 := 0;
    For intContador := 0 To cxVerticalGrid4.Rows.Count - 1 Do
      If cxVerticalGrid4.Rows[intContador].Visible Then
        intRows3 := intRows3 + 1;

    For intContador := 0 To cxVerticalGrid5.Rows.Count - 1 Do
      If cxVerticalGrid5.Rows[intContador].Visible Then
        intRows3 := intRows3 + 1;
    For intContador := 0 To cxVerticalGrid8.Rows.Count - 1 Do
      If cxVerticalGrid8.Rows[intContador].Visible Then
        intRows3 := intRows3 + 1;


    If intRows2 > intRows Then
      intRows := intRows2;

    If intRows3 > intRows Then
      intRows := intRows3;

    If intRows < 8 Then
      intRows := 8;


    pnlLegenda.Visible := False;

      ClientHeight := IIF(pnlLegenda.Visible, pnlLegenda.Height, 0) + 17 * intRows + 1 * intRows + 2;

    pnlPanelGiro.ClientHeight := ClientHeight;
    pnlPanelGiro.Visible := True;
    Dock(pnlPanelGiro, pnlPanelGiro.BoundsRect);

    Show;
  End;

end;

procedure TfrmPreOrcamentoEdicao.FormDestroy(Sender: TObject);
begin
  pLiberaOrdenacao;
  FreeAndNil(lstOrdemResgistros);
  inherited;

end;

procedure TfrmPreOrcamentoEdicao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F7 : btnSimilares.Click;
    VK_F8 : btnSatelites.Click;
    VK_F9 : btnTotEmp.Click;
    VK_F10: btnConfirma.Click;
    VK_F11 : btnEstoqueLojas.Click;
    VK_F12: btnPedCompGrid.Click;

    VK_RETURN: If fCheckParent(ActiveControl, cxgItens) Then
      Begin

        If chkNextLine.Checked Then
        Begin
          If cxvItens.DataController.IsEOF Then
            pSetFocus(btnConfirma)
          Else
          Begin
            cxvItens.NavigatorButtons.Next.Click;
            If cxvItensQTDITE.Focused Then
              cxvItensQTDITE.Focused := True
            Else If cxvItensPERDES.Focused Then
              cxvItensPERDES.Focused := True
            Else If cxvItensUNILIQ.Focused Then
              cxvItensUNILIQ.Focused := True;
          End;

        End
        Else
        Begin

          If cxvItensQTDITE.Focused Then
            cxvItensPERDES.Focused := True

          Else If cxvItensPERDES.Focused Then
            cxvItensUNILIQ.Focused := True

          Else If cxvItensUNILIQ.Focused Then
          Begin
            If cxvItens.DataController.IsEOF Then
            Begin
              pSetFocus(btnConfirma)
                     End Else
            Begin
              cxvItens.NavigatorButtons.Next.Click;
              cxvItensQTDITE.Focused := True;
            End;

          End;
        End;
      End;
  End;

end;

procedure TfrmPreOrcamentoEdicao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If Key = '-' Then
    Key := #0;

end;

procedure TfrmPreOrcamentoEdicao.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If blnAtualizarRodape Then
  Begin
    tmrAtualizaRodape.Enabled := True;
    blnAtualizarRodape := False;
  End;

end;

procedure TfrmPreOrcamentoEdicao.pAfterScrollOrcamento(dtsDados: TDataSet);
Begin
  If dtsDados.ControlsDisabled Then
    Exit;

  blnAtualizarRodape := True;
End;

procedure TfrmPreOrcamentoEdicao.pEscreveTotalizadores;
begin

  cxVerTotPed.Properties.Value := FormatFloat('###,###,##0.0000', objPreOrcamento.TotalizadoresMarcado.fltTotalPedidoSelecionado);
  cxVerQtdTotPed.Properties.Value := FormatFloat('###,###,##0.0000', objPreOrcamento.TotalizadoresMarcado.fltTotalQtdSel);
  cxVerPesTotPed.Properties.Value := FormatFloat('###,###,##0.0000', objPreOrcamento.TotalizadoresMarcado.fltTotalKilSel);
  cxVerLitTotPed.Properties.Value := FormatFloat('###,###,##0.0000', objPreOrcamento.TotalizadoresMarcado.fltTotalLitSel);
  cxVerMetTotPed.Properties.Value := FormatFloat('###,###,##0.0000', objPreOrcamento.TotalizadoresMarcado.fltTotalMetSel);

  If objPreOrcamento.TotalizadoresMarcado.qtdItensSelec > 0 Then
  Begin
    cxVerCurvA.Properties.Value := FormatFloat('###,###,##0.0000', objPreOrcamento.TotalizadoresMarcado.qtdNivelGiroA * 100 / objPreOrcamento.TotalizadoresMarcado.qtdItensSelec);
    cxVerCurvB.Properties.Value := FormatFloat('###,###,##0.0000', objPreOrcamento.TotalizadoresMarcado.qtdNivelGiroC * 100 / objPreOrcamento.TotalizadoresMarcado.qtdItensSelec);
    cxVerCurvC.Properties.Value := FormatFloat('###,###,##0.0000', objPreOrcamento.TotalizadoresMarcado.qtdNivelGiroB * 100 / objPreOrcamento.TotalizadoresMarcado.qtdItensSelec);
    cxVerCurvX.Properties.Value := FormatFloat('###,###,##0.0000', objPreOrcamento.TotalizadoresMarcado.qtdCriticidaX * 100 / objPreOrcamento.TotalizadoresMarcado.qtdItensSelec);
    cxVerCurvY.Properties.Value := FormatFloat('###,###,##0.0000', objPreOrcamento.TotalizadoresMarcado.qtdCriticidaY * 100 / objPreOrcamento.TotalizadoresMarcado.qtdItensSelec);
    cxVerCurvZ.Properties.Value := FormatFloat('###,###,##0.0000', objPreOrcamento.TotalizadoresMarcado.qtdCriticidaZ * 100 / objPreOrcamento.TotalizadoresMarcado.qtdItensSelec);
  End
  Else
  Begin
    cxVerCurvA.Properties.Value := '0,0000';
    cxVerCurvB.Properties.Value := '0,0000';
    cxVerCurvC.Properties.Value := '0,0000';
    cxVerCurvX.Properties.Value := '0,0000';
    cxVerCurvY.Properties.Value := '0,0000';
    cxVerCurvZ.Properties.Value := '0,0000';
  End;
end;

procedure TfrmPreOrcamentoEdicao.FormShow(Sender: TObject);
Var
  intContador: Integer;
begin
  inherited;

  edtCodFor.Text := strCodFor;
  edtNomFor.Text := strNomFor;

  For intContador := 0 To objPreOrcamento.stlMeses.Count - 1 Do
    cxvItens.GetColumnByFieldName('PRE_VMES' + RightStr('0' + IntToStr(intContador), 2)).Caption := objPreOrcamento.stlMeses[intContador];


  If Not (objPreOrcamento.fCarregaItens(strCodFor, strEmpHub, strCodIte, strCodSim, strCodMar, strCodDep, ticConsulta, True, blnConsEnc, strLinGru, strFilEmp)) Then
  Begin
    pMensagemOk('Falha ao carregar dados!' + #13#10 + 'Cód. fornecedor: ' + strCodFor);
    Exit;
  End;

  dtsGPREOR.DataSet := objPreOrcamento.cdsCabecOrc;

  cxvItensVMES04.Visible := True;
  cxvItensVMES05.Visible := True;
  cxvItensVMES06.Visible := True;
  cxvItensVMES07.Visible := True;
  cxvItensVMES08.Visible := True;
  cxvItensVMES09.Visible := True;
  cxvItensVMES10.Visible := True;
  cxvItensVMES11.Visible := True;
  cxvItensVMES12.Visible := True;

  If objPreOrcamento.intMeses < 12 Then
  Begin
    cxvItensVMES07.Visible := False;
    cxvItensVMES08.Visible := False;
    cxvItensVMES09.Visible := False;
    cxvItensVMES10.Visible := False;
    cxvItensVMES11.Visible := False;
    cxvItensVMES12.Visible := False;

    cxvItens.Bands[3].Width := cxvItens.Bands[3].Width - 6 * 76;
  End;

  If objPreOrcamento.intMeses < 6 Then
  Begin
    cxvItens.Bands[3].Width := cxvItens.Bands[3].Width - 3 * 76;

    cxvItensVMES04.Visible := False;
    cxvItensVMES05.Visible := False;
    cxvItensVMES06.Visible := False;
  End;

  TSalvaConfiguracaoGrid.pCarregaConfiguracoesGrid(cxvItens, 'frmPreOrcamentoEdicao' + TPreOrcamento.fDescricaoTipoPasta(ticConsulta));

  cxvItensDIAGIR.Visible := objPreOrcamento.blnUsaDia;

  lblHub.Visible := ticConsulta = ticSatelites;
  edtHub.Visible := ticConsulta = ticSatelites;
  cxvItens.Bands[2].Visible := ticConsulta = ticCompra;

  If ticConsulta = ticCompra Then
    cxvItensQTDITE.Focused := True;

  If objPreOrcamento.blnGlobal And (ticConsulta <> ticCompra) Then
  Begin
    cxvItensSUGEST.Visible := False;
    cxvItens.Bands[1].Caption := '';
  End;

  If ticConsulta <> ticCompra Then
  Begin
    cxvItensSUGEST.DataBinding.FieldName := 'PRE_NECCOM';

    btnSatelites.Visible := False;
    btnSimilares.Visible := False;
    btnTotEmp.Visible := False;
    btnConfirma.Visible := False;

    pnlProduto.Visible := True;

    pnlCndPag.Visible := False;
  End;

  cxvItensREFERE.Visible := ticConsulta <> ticSatelites;
  cxvItensDESITE.Visible := ticConsulta <> ticSatelites;
  cxvItensCODITE.Visible := ticConsulta <> ticSatelites;
  cxvItensDESMAR.Visible := ticConsulta = ticSimilares;

  If (ticConsulta = ticCompra) And
     (cxvItens.DataController.Summary.FooterSummaryItems.Count > 6) Then
  For intContador := 21 downTo 6 Do
    If Assigned(cxvItens.DataController.Summary.FooterSummaryItems[intContador]) Then
      cxvItens.DataController.Summary.FooterSummaryItems[intContador].Free;

  If ticConsulta = ticSatelites Then
  Begin
    cxvItens.Bands[0].Caption := 'Empresas';
  End;

  If ticConsulta = ticCompra Then
    objPreOrcamento.cdsCabecOrc.Edit;

  pnlFornecedor.Visible := ticConsulta <> ticSimilares;

  If (objPreOrcamento.intCarPag = 0) Then
    chkPgAVis.Checked := Trim(dbeConPag.Text) = '01000'
  Else
    chkPgAVis.Checked := Trim(dbeConPag.Text) = '01' + fStrZero(objPreOrcamento.intCarPag, 3);

  chkPgAVisClick(Nil);

  objPreOrcamento.AfterScroll := pAfterScrollOrcamento;
  cxvItens.NavigatorButtons.Last.Click;


  cxvItens.NavigatorButtons.First.Click;

  pSetFocus(chkPgAVis);

  lstOrdemResgistros.Clear;
  pSalvaOrdenacao;

  chkFiSemNecCom.Checked := True;

  With frmTelaGiroUmaLoc Do
  Begin

    cxgItensVENMES.Properties.Caption := cxvItensVMES00.Caption;
    cxgItensQ_V_01.Properties.Caption := cxvItensVMES01.Caption;
    cxgItensQ_V_02.Properties.Caption := cxvItensVMES02.Caption;
    cxgItensQ_V_03.Properties.Caption := cxvItensVMES03.Caption;
    cxgItensQ_V_04.Properties.Caption := cxvItensVMES04.Caption;
    cxgItensQ_V_05.Properties.Caption := cxvItensVMES05.Caption;
    cxgItensQ_V_06.Properties.Caption := cxvItensVMES06.Caption;
    cxgItensQ_V_07.Properties.Caption := cxvItensVMES07.Caption;
    cxgItensQ_V_08.Properties.Caption := cxvItensVMES08.Caption;
    cxgItensQ_V_09.Properties.Caption := cxvItensVMES09.Caption;
    cxgItensQ_V_10.Properties.Caption := cxvItensVMES10.Caption;
    cxgItensQ_V_11.Properties.Caption := cxvItensVMES11.Caption;
    cxgItensQ_V_12.Properties.Caption := cxvItensVMES12.Caption;

    cxgItensSALDIS.Properties.Caption := cxvItensESTDIS.Caption;

    cxgItensVENMES.Visible := cxvItensVMES00.Visible;
    cxgItensQ_V_01.Visible := cxvItensVMES01.Visible;
    cxgItensQ_V_02.Visible := cxvItensVMES02.Visible;
    cxgItensQ_V_03.Visible := cxvItensVMES03.Visible;
    cxgItensQ_V_04.Visible := cxvItensVMES04.Visible;
    cxgItensQ_V_05.Visible := cxvItensVMES05.Visible;
    cxgItensQ_V_06.Visible := cxvItensVMES06.Visible;
    cxgItensQ_V_07.Visible := cxvItensVMES07.Visible;
    cxgItensQ_V_08.Visible := cxvItensVMES08.Visible;
    cxgItensQ_V_09.Visible := cxvItensVMES09.Visible;
    cxgItensQ_V_10.Visible := cxvItensVMES10.Visible;
    cxgItensQ_V_11.Visible := cxvItensVMES11.Visible;
    cxgItensQ_V_12.Visible := cxvItensVMES12.Visible;

    If Not cxgItensQ_V_07.Visible Then
    Begin
      cxvGridGiro2.Visible := False;
      pnlPanelGiro.Width :=  frmTelaGiroUmaLoc.Width - cxvGridGiro2.Width + 10;
    End;
  End;

  If (Not cxvItens.DataController.DataSet.isEmpty) Then
    cxvItens.DataController.GotoFirst;
  tmrAtualizaRodape.Enabled := True;

  ScrollBox1.HorzScrollBar.Position := 0;
end;

function TfrmPreOrcamentoEdicao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Var
  strConPag: String;
begin
  blnMudarFoco := True;

  Result := True;

  If (Sender = dbeDesAdi) Then
  Begin

    If pnlCndPag.Visible Then
    Begin

      If fEmptyStr(dbeDesAdi.Text) Then
      Begin
        dbeDesAdi.Text := '0,00';
      End
      Else If (fStrToFloat(dbeDesAdi.Text) < 0.0) Or (fStrToFloat(dbeDesAdi.Text) > 100.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Desconto Adicional deve ser entre 0 e 100!', ['&O k']);
        Result := False;
      End;

    End;

  End

  Else If (Sender = dbeConPag) Then
  Begin

    If pnlCndPag.Visible Then
    Begin

      If fEmptyDate(dbeConPag.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If fEmptyStr(Copy(dbeConPag.Text, 1, 2)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Condição de pagamento inválida!', ['&O k']);
        Result := False;
      End
      Else If StrToInt(Copy(dbeConPag.Text, 1, 2)) > 24 Then
      Begin
        fMensagem('', 'Não é permitido mais que 24 parcelas!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaCndPag(dbeConPag.Text, strConPag, VS_Date) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
        Result := False;
      End Else
      Begin

        If objPreOrcamento.cdsCabecOrc.State In dsEditModes Then
          dbeConPag.Field.Value := strConPag;

        If fEmptyStr(strConPag) Then
          Result := False;

      End;

      If Not chkPgAVis.Checked And (fStatusCndPag(fTiraCaracEspeciais(dbeConPag.Text)) = A_VISTA) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é permitida!', ['&O k']);
        Result := False;
      End;

    End;

  End;

  If (Not Result) Then
  Begin
    pSetFocus(Sender)
  End;
end;

function TMycxGridDBBandedTableView.GetDataControllerClass: TcxCustomDataControllerClass;
begin
  Result := TMycxGridDBBandedDataController;
end;

function TMycxGridDBBandedDataController.CreateDataControllerInfo: TcxCustomDataControllerInfo;
begin
  Result := TMycxCustomDataControllerInfo.Create(Self);
end;

function TMycxGridDBBandedDataController.GetOrdenar: Boolean;
begin
  Result := TMycxCustomDataControllerInfo(DataControllerInfo).blnOrdenar;
end;

Procedure TMycxGridDBBandedDataController.SetOrdenar(Value: Boolean);
Begin
  If Value <> TMycxCustomDataControllerInfo(DataControllerInfo).blnOrdenar Then
  Begin
    TMycxCustomDataControllerInfo(DataControllerInfo).blnOrdenar := Value;

    If Value Then
      TMycxCustomDataControllerInfo(DataControllerInfo).DoSort;

  End;
End;

function TfrmPreOrcamentoEdicao.fGetPositionByRecordIndex(ARecordIndex: Integer): Integer;
Var
  intContador: Integer;
begin
  Result := -1;

  For intContador := 0 To lstOrdemResgistros.Count - 1 Do
    If TPosicaoRegistroPrt(lstOrdemResgistros[intContador])^.intRecordIndex = ARecordIndex Then
    Begin
      Result := TPosicaoRegistroPrt(lstOrdemResgistros[intContador])^.intPosition;
      Break;
    End;
end;

procedure TfrmPreOrcamentoEdicao.pLiberaOrdenacao;
Var
  intContador: Integer;
Begin
  For intContador := 0 To lstOrdemResgistros.Count - 1 Do
    Dispose(TPosicaoRegistroPrt(lstOrdemResgistros[intContador]));

  lstOrdemResgistros.Clear;
End;

procedure TfrmPreOrcamentoEdicao.pSalvaOrdenacao;
Var
    intRecNo,
    intContador: Integer;
  ptrRegistro: TPosicaoRegistroPrt;
begin
  pLiberaOrdenacao;
  If not assigned(cxvItens.DataController.DataSource) Then
    Exit;

  If cxvItens.DataController.DataSource.DataSet.IsEmpty Then
    Exit;

  intRecNo := cxvItens.DataController.DataSource.DataSet.RecNo;

  With cxvItens.DataController do
    For intContador := 0 To RecordCount - 1 Do
    begin
      New(ptrRegistro);
      ptrRegistro^.intRecordIndex := intContador;
      ptrRegistro^.intPosition := GetRowIndexByRecordIndex(intContador, False);
      lstOrdemResgistros.Add(ptrRegistro);
    end;

  cxvItens.DataController.DataSource.DataSet.RecNo := intRecNo;
end;

procedure TfrmPreOrcamentoEdicao.tmrAtualizaRodapeTimer(Sender: TObject);
begin
  inherited;
  tmrAtualizaRodape.Enabled := False;

  If ticConsulta <> ticSimilares Then
    btnSimilares.Enabled := objPreOrcamento.FieldByName('PRE_CODSIM').AsString <> '';

  frmTelaGiroUmaLoc.pAtualizaDadosUmaLojaPastaCompra(objPreOrcamento);

  edtProdutoDoRodape.Text := Concat(objPreOrcamento.FieldByName('PRE_CODITE').AsString, ' - ', objPreOrcamento.FieldByName('PRE_DESITE').AsString);
end;

procedure TfrmPreOrcamentoEdicao.cxVerLitTotPedEditPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  objPreOrcamento.pMostraResumoUnidades
end;

procedure TfrmPreOrcamentoEdicao.cxvItensCellClick
  (Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  tmrAtualizaRodape.Enabled := True;
end;

procedure TfrmPreOrcamentoEdicao.cxvItensColumnHeaderClick(Sender: TcxGridTableView;
  AColumn: TcxGridColumn);
begin
  chkSuspOrdem.Checked := False;

  inherited;

  pSalvaOrdenacao;

  // PEGA A ORDENAÇÃO E GUARDA PARA USA NO DoSort;
end;

procedure TfrmPreOrcamentoEdicao.cxvItensDataControllerCompare(
  ADataController: TcxCustomDataController; ARecordIndex1, ARecordIndex2,
  AItemIndex: Integer; const V1, V2: Variant; var Compare: Integer);
var
  intPosition1, intPosition2: Integer;
begin

  Try
    // If chkSuspOrdem.Checked then
    If chkSuspOrdem.Checked then
    Begin

      intPosition1 := fGetPositionByRecordIndex(ARecordIndex1);
      intPosition2 := fGetPositionByRecordIndex(ARecordIndex2);

      If cxvItens.SortedItems[0].SortOrder = soAscending Then
        Compare := VarCompare(intPosition1, intPosition2)
      Else
        Compare := VarCompare(intPosition2, intPosition1);

    End Else
    Begin

      Compare := VarCompare(V1, V2);

    End;
  Except
    on E: Exception do
    Begin
      fMensagem('', E.message, ['&Ok']);
    End;
  End;

end;

{ TMycxCustomDataControllerInfo }

procedure TMycxCustomDataControllerInfo.DoSort;
begin
  inherited;

end;

end.

