{**********************************************}
{* ROTINA PARA CRIAR ORDENS DE PRODUÇÃO A     *}
{* PARTIR DE PEDIDOS DE VENDA                 *}
{* CRIAÇÃO 10/11/2015                         *}
{* AUTOR : GUILHERME BORGES                   *}
{*******************************************GB*}

unit untAgruPedOrdProInd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Mask, MaskEditFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, untZClient, untTypesSistema, Vcl.DBCtrls, cxCheckBox, Vcl.ImgList,
  cxImageComboBox, StrUtils, UniClientDataSet, System.Generics.Collections,
  untOrdProIndustrial, Uni, cxProgressBar, System.ImageList,
  cxButtonEdit, System.Actions, Vcl.ActnList,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxTextEdit,
  cxMaskEdit;

type
  TopcMarcar = (opcMarcar, opcDesmarcar, opcInverter);

  TfrmAgruPedOrdProInd = class(TfrmPai)
    imgLista: TImageList;
    btnMarcar: TBitBtnLocked;
    btnDesmarcar: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    Notebook: TNotebook;
    pnlFiltros: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    mskIniEtr: TMaskEditFocus;
    mskFinEtr: TMaskEditFocus;
    cxgFatDor: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridDBTableViewCODITE: TcxGridDBColumn;
    cxGridDBTableViewDESCRI: TcxGridDBColumn;
    cxGridDBTableViewUNIDAD: TcxGridDBColumn;
    cxGridDBTableViewENTRET: TcxGridDBColumn;
    cxGridDBTableViewQTDITE: TcxGridDBColumn;
    cxGridDBTableViewUNITAR: TcxGridDBColumn;
    cxGridDBTableViewTOTITE: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    Splitter1: TSplitter;
    pnlObserv: TPanel;
    dbtMsgPed: TDBText;
    dbtMsgExp: TDBText;
    lblMsgPed: TLabel;
    lblMsgExp: TLabel;
    pnlTotais: TPanel;
    Label7: TLabel;
    dbtPesoIt: TDBText;
    Label8: TLabel;
    Label9: TLabel;
    dbtQtdSel: TDBText;
    Label10: TLabel;
    dbtPesoMa: TDBText;
    Label11: TLabel;
    cxgFatGor: TcxGrid;
    cxgFatGorDBTableView: TcxGridDBTableView;
    cxgFatGorDBTableViewMARDES: TcxGridDBColumn;
    cxgFatGorDBTableViewNUMDOC: TcxGridDBColumn;
    cxgFatGorDBTableViewCODEMP: TcxGridDBColumn;
    cxgFatGorDBTableViewDTAENT: TcxGridDBColumn;
    cxgFatGorDBTableViewCODCLI: TcxGridDBColumn;
    cxgFatGorDBTableViewNOMCLI: TcxGridDBColumn;
    cxgFatGorDBTableViewCODVEN: TcxGridDBColumn;
    cxgFatGorDBTableViewDESCRI: TcxGridDBColumn;
    cxgFatGorDBTableViewLIBERA: TcxGridDBColumn;
    cxgFatGorDBTableViewDTENTR: TcxGridDBColumn;
    cxgFatGorLevel1: TcxGridLevel;
    pnlItens: TPanel;
    cxgOrdDet: TcxGrid;
    cxgOrdDetDBTableView: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxgPedidos: TcxGrid;
    cxgPedidosDBTableView: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    cxgPedidosDBTableViewNUMDOC: TcxGridDBColumn;
    cxgOrdPro: TcxGrid;
    cxgOrdProDBTableView: TcxGridDBTableView;
    cxGridDBCODITE: TcxGridDBColumn;
    cxGridDBDESITE: TcxGridDBColumn;
    cxGridDBDESCOR: TcxGridDBColumn;
    cxGridDBDTAPRE: TcxGridDBColumn;
    cxGridDBVOLUME: TcxGridDBColumn;
    cxGridDBPESOIT: TcxGridDBColumn;
    cxGridLevel3: TcxGridLevel;
    cxgOrdDetDBTableViewDESITE: TcxGridDBColumn;
    cxgOrdDetDBTableViewSIGUNI: TcxGridDBColumn;
    cxgOrdDetDBTableViewQTDPED: TcxGridDBColumn;
    cxgOrdDetDBTableViewSUGEST: TcxGridDBColumn;
    cxgOrdDetDBTableViewORD_QTDPRO: TcxGridDBColumn;
    cxgOrdProDBTableViewMARCA: TcxGridDBColumn;
    cxgOrdProDBTableViewIMPRIM: TcxGridDBColumn;
    pnlImprimir: TPanel;
    Splitter2: TSplitter;
    btnImpTodos: TBitBtnLocked;
    btnNaoImp: TBitBtnLocked;
    cxgPedidosDBTableViewQTDITE: TcxGridDBColumn;
    Splitter3: TSplitter;
    cxgOrdDetDBTableViewColumn1: TcxGridDBColumn;
    cxgPedidosDBTableViewCODEMP: TcxGridDBColumn;
    cxgOrdProDBTableViewColumn1: TcxGridDBColumn;
    ActionList1: TActionList;
    ConfImpressao: TAction;
    cxgOrdDetDBTableViewESTUTI: TcxGridDBColumn;
    SelLotes: TAction;
    cxgOrdDetDBTableViewESTOQUE_MAXIMO: TcxGridDBColumn;
    cxgOrdDetDBTableViewESTOQUE_MINIMO: TcxGridDBColumn;
    cxgOrdDetDBTableViewESTOQUE_FISICO: TcxGridDBColumn;
    cxgOrdDetDBTableViewESTOQUE_DISPONIVEL: TcxGridDBColumn;
    cxGridDBTableViewSALDOS: TcxGridDBColumn;
    cxGridDBTableViewSALRES: TcxGridDBColumn;
    cxgOrdDetDBTableViewQTDRST: TcxGridDBColumn;
    cxGridDBTableViewCOMPLE: TcxGridDBColumn;
    pnlTipAte: TPanel;
    lblTipAte: TLabel;
    edtCodTpa: TEditFocus;
    edtDesTpa: TEditFocus;
    pnlEmpresa: TPanel;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    btnFiltro: TBitBtnLocked;
    Label12: TLabel;
    pnlRedLoj: TPanel;
    edtRedLoj: TEditFocus;
    edtDesRedLoj: TEditFocus;
    lblRedLoj: TLabel;
    cxgOrdProCOMPLE: TcxGridDBColumn;
    cxgOrdDetCOMPLE: TcxGridDBColumn;
    cxGridDBTableViewISALFIS: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnFiltroClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgFatGorDBTableViewMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure cxgFatGorDBTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridDBTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridDBTableViewMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnMarcarClick(Sender: TObject);
    procedure btnDesmarcarClick(Sender: TObject);
    procedure cxgFatGorDBTableViewDblClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnImpTodosClick(Sender: TObject);
    procedure cxgFatGorDBTableViewDTENTRGetDataText(
      Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
    procedure cxgOrdDetExit(Sender: TObject);
    procedure cxgOrdDetDBTableViewKeyPress(Sender: TObject; var Key: Char);
    procedure cxgOrdDetDBTableViewMouseLeave(Sender: TObject);
    procedure cxgOrdProDBTableViewMARCAPropertiesChange(Sender: TObject);
    procedure cxgOrdProDBTableViewKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ConfImpressaoExecute(Sender: TObject);
    procedure SelLotesExecute(Sender: TObject);
    procedure cxgOrdProDBTableViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure cxgOrdDetDBTableViewORD_QTDPROPropertiesEditValueChanged(
      Sender: TObject);
    procedure edtCodTpaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTpaExit(Sender: TObject);
    procedure edtRedLojExit(Sender: TObject);
    procedure edtRedLojKeyPress(Sender: TObject; var Key: Char);
  Private
    cdsFatGor : TZClient;
    cdsFatDor : TZClient;

    cdsOrdPro : TUniClientDataSet;
    dtsOrdPro : TDataSource;
    lstOrdPro : TObjectDictionary<String, TOrdProIndustrial>;

    cdsOrdPed : TUniClientDataSet;
    dtsOrdPed : TDataSource;

    intCorZeb : Integer;
    intRecGor : Integer;
    intRecDor : Integer;
    intDecQtd : Integer;
    intDecUni : Integer;
    intQtdBai : Integer;
    intQtdGer : Integer;
    intTamCod : Integer;
    arrCodEmp : TConsultasArray;
    arrTpaAte : TConsultasArray;
    arrRedLoj : TConsultasArray;

    blnConCom : Boolean;

    strCodPag : String;
    strCodCor : String;
    strComple : String;

    blnPermitiSelecionaItensSemSaldoParaGeracaOPI: Boolean;
    cdsSubItemSelecionado: TUniClientDataSet;

    //Procedures
    procedure pCarregaFatGor;
    procedure pCdsFatGorAfterScroll(DataSet : TDataset);
    procedure pCdsOrdProAfterScroll(DataSet : TDataset);
    procedure pcdsOrdProBeforePost(DataSet : TDataSet);
    procedure pMarcar(opcMarcarP: TopcMarcar);
    procedure pAtualizaConfirmar;
    procedure pSintetizaOrdensProducao;
    procedure pObjOrdProBeforePost(DataSet : TDataSet);
    procedure pObjOrdProAfterPost(DataSet : TDataSet);
    procedure pObjOrdProAfterScroll(DataSet : TDataSet);
    procedure pCdsOrdProAfterPost(DataSet : TDataSet);
    procedure pReseta(blnResult: Boolean);
    procedure pReplicaDataPrevisao(dtaPrevisao: TDate);
    procedure pGeraOrdemProducaoSemSaldo(blnGeraOrdProdSemSaldo: Boolean; qryTabela  : TUniQuery);
    procedure pDesmarcaCheckItem(dtsValidaEstoque: TDataSource);
    procedure pCarregaFormularioProdSemSaldo(dtsValidaEstoque:TDataSource);

    //Functions
    function fGetSQLFatGor : String;
    function fGetSQLFatDor : String;
    function fCriaCdsOrdPro: TUniClientDataSet;
    function fCriaCdsOrdPed: TUniClientDataSet;
    function fSintetizaOrdensProducaoProgressso(Progress : TCxProgressBar):Boolean;
    function fGravaOrdens: Boolean;
    function fGravaOrdensProgresso(Progress: TcxProgressBar): Boolean;
    function fSetSeqOpi(strAutIncOrdGer, strAutIncFatDor: String; blnApenasBaixar : Boolean; fltQtdRestante: Double): Boolean;
    function fRetQuantJaProduzida(strSeqFat: String): Double;
    procedure pGravaORDFAT(strSeGer, strSeqFDO: String; fltQtd: Double);

    function fMostraOPIQueSeraoGeradaParaProdutosSemSaldo(cdsData: TUniClientDataSet): Boolean;
    function fExisteFormulaAtiva(strCodIte, strCodCor: String): Boolean;
    function fValidarDataPrevisao: Boolean;

  Public
    { Public declarations }
  Protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean) : Boolean; Override;

  end;

implementation

{$R *.dfm}

uses untFuncoesConsulta, untFuncoesSimples, untConsultas, untGravando,
  untOrdProIndustrialImprimeLotes, untFuncoesRel, untFuncoesRel2,
  untOrdProIndustrialProdSemSaldo, untTFatReservaSaldo, untIFatReservaSaldo,
  OrdemProducaoIndustrial.TAgrupamentoPedidoEstoque, untImpOrdProIndustrial,
  untMostraOPIQueSeraoGeradaParaProdutosSemSaldo;

{ TfrmAgruPedOrdProInd }

function TfrmAgruPedOrdProInd.fGetSQLFatGor: String;
begin
  Result := '';
  Result := Result + ' SELECT FGO_NUMDOC,                               ';
  Result := Result + '        FGO_CODEMP,                               ';
  Result := Result + '        FGO_DTAENT,                               ';
  Result := Result + '        FGO_CODCLI,                               ';
  Result := Result + '        CLI_NOMCLI,                               ';
  Result := Result + '        FGO_CODVEN,                               ';
  Result := Result + '        TPA_DESCRI,                               ';
  Result := Result + '        FGO_DTENTR,                               ';

  Result := Result + '        CONCAT( FGO_MEN001,                                                      ';
  Result := Result + '        IF( IFNULL(FGO_MEN002,"") <> "", CONCAT(" ", FGO_MEN002), "")) AS MSGPED,';

  Result := Result + '        CONCAT(FGO_MENEXP,                                                       ';
  Result := Result + '        IF( IFNULL(FGO_MENEX2,"") <> "", CONCAT(" ", FGO_MENEX2), ""),           ';
  Result := Result + '        IF( IFNULL(FGO_MENEX3,"") <> "", CONCAT(" ", FGO_MENEX3), ""),           ';
  Result := Result + '        IF( IFNULL(FGO_MENEX4,"") <> "", CONCAT(" ", FGO_MENEX4), "")) AS MSGEXP,';

  Result := Result + ' ( SELECT SUM(FDO_QTDITE * ITE_PESOIT)            ';
  Result := Result + '   FROM FATDOR D                                  ';
  Result := Result + '   INNER JOIN EXTDOR ON FDO_SEQFDO = D.AUTOINCREM ';
  Result := Result + '   INNER JOIN CADITE ON ITE_CODITE = FDO_CODITE   ';
  Result := Result + '   WHERE D.FDO_SEQGER = G.AUTOINCREM              ';
  Result := Result + '     AND FDO_SEQOPI IS NULL                       ';
  Result := Result + '     AND FDO_QTDITE > 0                           ';
  Result := Result + '     AND IFNULL(ITE_CODPAG,"") <> "" ) AS PESOIT, ';

  Result := Result + ' ( SELECT SUM(FDO_QTDITE * ITE_PESOIT)            ';
  Result := Result + '   FROM FATDOR D                                  ';
  Result := Result + '   INNER JOIN EXTDOR ON FDO_SEQFDO = D.AUTOINCREM ';
  Result := Result + '   INNER JOIN CADITE ON ITE_CODITE = FDO_CODITE   ';
  Result := Result + '   WHERE D.FDO_SEQGER = G.AUTOINCREM              ';
  Result := Result + '     AND FDO_SEQOPI IS NULL                       ';
  Result := Result + '     AND FDO_QTDITE > 0                           ';
  Result := Result + '     AND IFNULL(ITE_CODPAG,"") <> "" ) AS PESOMA, ';

  Result := Result + '        1 AS MARDES,                              ';
  Result := Result + '      IF(FGO_LIBERA >= 1, "S", "N") AS LIBERA,    ';

  Result := Result + '      G.AUTOINCREM                                ';
  Result := Result + ' FROM FATGOR G                                    ';
  Result := Result + ' INNER JOIN EXTGOR ON FGO_SEQFGO = G.AUTOINCREM   ';
  Result := Result + ' INNER JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI     ';
  Result := Result + ' LEFT  JOIN CADTPA ON TPA_CODIGO = FGO_CODTPA     ';
  Result := Result + ' WHERE FGO_JAFATU = 0                             ';
  Result := Result + '   AND FGO_LIBERA > 0                             ';
  Result := Result + '   AND FGO_ESPDOC = "PD"                          ';
  Result := Result + '   AND FGO_VLRCON > 0                             ';

  If Not fEmptyDate(mskDtaIni.Text) Then
    Result := Result + ' AND FGO_DTAENT BETWEEN :INIPED AND :FINPED     ';

  If Not fEmptyDate(mskIniEtr.Text) Then
    Result := Result + ' AND FGO_DTAENT BETWEEN :INIETR AND :FINETR     ';

  Result := Result + fStrLocateEmpresa(edtCodEmp, arrCodEmp, 'FGO_CODEMP', 'CODEMP');

  If pnlTipAte.Visible Then
    Result := Result + fStrLocate(edtCodTpa, arrTpaAte, 'FGO_CODTPA', 'CODTPA');

  Result := Result + fStrLocate(edtRedLoj, arrRedLoj, 'CLI_CODRED', 'CODRED');

  Result := Result + ' AND ';
  Result := Result + ' ( SELECT COUNT(0)                                ';
  Result := Result + '   FROM FATDOR D                                  ';
  Result := Result + '   INNER JOIN EXTDOR ON FDO_SEQFDO = D.AUTOINCREM ';
  Result := Result + '   INNER JOIN CADITE ON ITE_CODITE = FDO_CODITE   ';
  Result := Result + '   WHERE D.FDO_SEQGER = G.AUTOINCREM              ';
  Result := Result + '     AND FDO_SEQOPI IS NULL                       ';
  Result := Result + '     AND FDO_BAIOPI = "N"                         ';
  Result := Result + '     AND FDO_QTDITE > 0                           ';
  Result := Result + '     AND IFNULL(ITE_CODPAG,"") <> "" ) > 0        ';

  Result := Result + ' ORDER BY FGO_DTENTR, FGO_CODEMP, FGO_NUMDOC      ';

end;

procedure TfrmAgruPedOrdProInd.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If NoteBook.PageIndex = 0 Then
  Begin
    pSintetizaOrdensProducao;
    pCdsOrdProAfterScroll(CdsOrdPro);
    NoteBook.PageIndex := 1;
    pAtualizaConfirmar;
  End
  Else
  If NoteBook.PageIndex = 1 Then
  Begin
    If Not fValidarDataPrevisao Then
      Exit;

    If fGravaOrdens Then
    Begin
      pReseta(True);
    End;
  End;
end;

procedure TfrmAgruPedOrdProInd.pReseta(blnResult : Boolean);
Begin
  cdsOrdPed.EmptyDataSet;
  cdsOrdPro.EmptyDataSet;
  lstOrdPro.Clear;

  cdsFatGor.EmptyDataSet;
  cdsFatDor.EmptyDataSet;

  If blnResult Then
    fMensagem('', 'Operação realizada com sucesso!' + #13 +
                  IntToStr(intQtdGer) + ' ordens de produção foram geradas.' + #13 +
                  IntToStr(intQtdBai) + ' pedidos foram baixados.', ['&OK']);

  NoteBook.PageIndex := 0;
  pSetFocus(mskDtaIni);
End;

procedure TfrmAgruPedOrdProInd.btnDesmarcarClick(Sender: TObject);
begin
  inherited;
  If NoteBook.PageIndex = 0 Then
  Begin
    Try
      cdsFatGor.DisableControls;
      cdsFatGor.First;
      While Not cdsFatGor.Eof Do
      Begin
        pMarcar(opcDesmarcar);
        cdsFatGor.Next;
      End;

    Finally
      cdsFatGor.First;
      cdsFatGor.EnableControls;
    End;
  End
  Else
  Begin
    Try
      cdsOrdPro.DisableControls;
      cdsOrdPro.First;
      While Not cdsOrdPro.Eof Do
      Begin
        pMarcar(opcDesmarcar);
        cdsOrdPro.Next;
      End;

    Finally
      cdsOrdPro.First;
      cdsOrdPro.EnableControls;
    End;
  End;
end;

procedure TfrmAgruPedOrdProInd.btnFiltroClick(Sender: TObject);
begin
  inherited;
  pCarregaFatGor;
end;

procedure TfrmAgruPedOrdProInd.btnImpTodosClick(Sender: TObject);
begin
  inherited;
  Try
    cdsOrdPro.DisableControls;
    cdsOrdPro.First;
    While Not cdsOrdPro.Eof Do
    Begin
      cdsOrdPro.Edit;
      cdsOrdPro.FieldByName('IMPRIM').AsInteger:= TBitBtnLocked(Sender).Tag;
      cdsOrdPro.Post;
      cdsOrdPro.Next;
    End;

  Finally
    cdsOrdPro.First;
    cdsOrdPro.EnableControls;
  End;
end;

procedure TfrmAgruPedOrdProInd.btnMarcarClick(Sender: TObject);
begin
  inherited;
  If Notebook.PageIndex = 0 Then
  Begin
    Try
      cdsFatGor.DisableControls;
      cdsFatGor.First;
      While Not cdsFatGor.Eof Do
      Begin
        pMarcar(opcMarcar);
        cdsFatGor.Next;
      End;

    Finally
      cdsFatGor.First;
      cdsFatGor.EnableControls;
    End;
  End
  Else
  Begin
    Try
      cdsOrdPro.DisableControls;
      cdsOrdPro.First;
      While Not cdsOrdPro.Eof Do
      Begin
        pMarcar(opcMarcar);
        cdsOrdPro.Next;
      End;

    Finally
      cdsOrdPro.First;
      cdsOrdPro.EnableControls;
    End;
  End;

end;

procedure TfrmAgruPedOrdProInd.ConfImpressaoExecute(Sender: TObject);
begin
  inherited;
  With lstOrdPro.Items[cdsOrdPro.FieldByName('CODITE').AsString +
                       cdsOrdPro.FieldByName('CODCOR').AsString +
                       IIF(blnConCom, cdsOrdPro.FieldByName('COMPLE').AsString, '')] Do
  Begin
    pConfiguraImprimessaoOP
  End;
end;

procedure TfrmAgruPedOrdProInd.cxgFatGorDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  ACanvas.Font.Color := clBlack;
  if (AViewInfo.Item = cxgOrdDetDBTableViewORD_QTDPRO) or (AViewInfo.Item = cxGridDBDTAPRE) then
    ACanvas.Brush.Color := $00CCFFFF
  else
  begin
    If (intRecGor = AViewInfo.GridRecord.RecordIndex) then
      ACanvas.Brush.Color := clGray
    Else
    If Odd(AViewInfo.GridRecord.RecordIndex) Then
      ACanvas.Brush.Color := intCorZeb;
  end;
end;

procedure TfrmAgruPedOrdProInd.cxgFatGorDBTableViewDblClick(Sender: TObject);
begin
  inherited;
  pMarcar(opcInverter);
end;

procedure TfrmAgruPedOrdProInd.cxgFatGorDBTableViewDTENTRGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;
  If StrToDateDef(AText,0) <= 0 then
    AText := '';
end;

procedure TfrmAgruPedOrdProInd.pReplicaDataPrevisao(dtaPrevisao: TDate);
Begin
  cxgOrdProDBTableView.DataController.DataSource.DataSet.First;
  while Not cxgOrdProDBTableView.DataController.DataSource.DataSet.Eof do
  Begin
    If cxgOrdProDBTableView.DataController.DataSource.DataSet.FieldByName('MARCA').AsString = '1' Then
    Begin
      cxgOrdProDBTableView.DataController.DataSource.DataSet.Edit;
      cxgOrdProDBTableView.DataController.DataSource.DataSet.FieldByName('DTAPRE').Value:= dtaPrevisao;
      cxgOrdProDBTableView.DataController.DataSource.DataSet.Post;
    End;
    cxgOrdProDBTableView.DataController.DataSource.DataSet.Next;
  End;
  fMensagem('', 'Data de Previsão, replicada com sucesso!', ['&Ok']);

End;


procedure TfrmAgruPedOrdProInd.cxgFatGorDBTableViewMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  Site: TcxGridSite;
  HitTest: TcxCustomGridHitTest;
begin
  Site := Sender as TcxGridSite;
  HitTest := Site.GridView.ViewInfo.GetHitTest(X, Y);
  if HitTest is TcxGridRecordCellHitTest then
  begin
    intRecGor := TcxGridRecordCellHitTest(HitTest).GridRecord.RecordIndex;
    Site.Repaint;
  end;
end;

procedure TfrmAgruPedOrdProInd.cxgOrdDetDBTableViewKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = #13 Then
    cxgOrdDetDBTableView.DataController.DataSource.DataSet.CheckBrowseMode;
end;

procedure TfrmAgruPedOrdProInd.cxgOrdDetDBTableViewMouseLeave(Sender: TObject);
begin
  inherited;
  intRecGor := -2;
  intRecDor := -2;
  TcxGridSite(Sender).Repaint;
end;

procedure TfrmAgruPedOrdProInd.cxgOrdDetDBTableViewORD_QTDPROPropertiesEditValueChanged(
  Sender: TObject);
  Var
    fltQtdPro,
    fltQtdPed: Double;
    fltQtdRestAtual: Double;
begin
  inherited;

  if fEmptyStr(TcxTextEdit(Sender).Text) then
    exit;

  fltQtdRestAtual:= fRetQuantJaProduzida(cdsOrdPed.FieldByName('SEQFDO').AsString);

  If cxgOrdDetDBTableView.DataController.DataSource.DataSet.State in ([DsInsert, DsEdit]) Then
  Begin

    fltQtdPed:= cxgOrdDetDBTableView.DataController.DataSource.DataSet.FieldByName('QTDPED').AsFloat;

    cxgOrdDetDBTableView.DataController.DataSource.DataSet.FieldByName('QTDRST').AsFloat:= fltQtdPed - fltQtdRestAtual;

    fltQtdPro:= fStrToFloat(TcxTextEdit(Sender).Text);

    If cxgOrdDetDBTableView.DataController.DataSource.DataSet.FieldByName('QTDRST').AsFloat > 0 Then
      cxgOrdDetDBTableView.DataController.DataSource.DataSet.FieldByName('QTDRST').AsFloat:=
        cxgOrdDetDBTableView.DataController.DataSource.DataSet.FieldByName('QTDRST').AsFloat - fltQtdPro
    Else
      cxgOrdDetDBTableView.DataController.DataSource.DataSet.FieldByName('QTDRST').AsFloat:= fltQtdPed - fltQtdPro;

    cxgOrdDetDBTableView.DataController.DataSource.DataSet.FieldByName('ORD_QTDPRO').AsFloat:= fStrToFloat(TcxTextEdit(Sender).Text);

    If cxgOrdDetDBTableView.DataController.DataSource.DataSet.FieldByName('QTDRST').AsFloat < 0 Then
    Begin
      pMensagemOk('Campo: Quantidade a Fabricar não corresponde a Quantidade Pendente!');
      cxgOrdDetDBTableView.DataController.DataSource.DataSet.Cancel;
      Exit;
    End
    Else
      If Not(cdsOrdPed.State in ([DsInsert, DsEdit])) Then
      Begin
        cdsOrdPed.Edit;
        cdsOrdPed.FieldByName('QTDPRO').AsFloat:= fStrToFloat(TcxTextEdit(Sender).Text);
        cdsOrdPed.FieldByName('QTDRST').AsFloat:= cxgOrdDetDBTableView.DataController.DataSource.DataSet.FieldByName('QTDRST').AsFloat;
        cdsOrdPed.Post;
      End;

      cxgOrdDetDBTableView.DataController.DataSource.DataSet.Post;
  End;

end;

procedure TfrmAgruPedOrdProInd.cxgOrdDetExit(Sender: TObject);
begin
  inherited;
  cxgOrdDetDBTableView.DataController.DataSource.DataSet.CheckBrowseMode;
end;

procedure TfrmAgruPedOrdProInd.cxgOrdProDBTableViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (cxgOrdProDBTableView.DataController.DataSource.DataSet.State in [dsInsert, DsEdit]) Then
  Begin
    If Key = VK_Return Then
    Begin
      If cxgOrdProDBTableView.Controller.FocusedColumn = cxGridDBDTAPRE Then
      Begin
          cxgOrdProDBTableView.DataController.DataSource.DataSet.Post;
          If (Not (cxgOrdProDBTableView.DataController.DataSource.DataSet.FieldByName('DTAPRE').IsNull)) Then
          Begin
            If fMensagem('', 'Deseja replicar a data para os outros produtos selecionados?', ['&Sim', '&Não'], 1) = 1 Then
            Begin
              pReplicaDataPrevisao(cxgOrdProDBTableView.DataController.DataSource.DataSet.FieldByName('DTAPRE').AsDateTime);
            End Else Exit;
          End;
      End;
    End
  End;
end;

procedure TfrmAgruPedOrdProInd.cxgOrdProDBTableViewKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Return Then
  Begin
    pMarcar(opcInverter);
  End
  Else
  If Key = VK_SPACE Then
  Begin
    cdsOrdPro.Edit;
    cdsOrdPro.FieldByName('IMPRIM').AsInteger:= 0;
    cdsOrdPro.Post;
  End;
end;

procedure TfrmAgruPedOrdProInd.cxgOrdProDBTableViewMARCAPropertiesChange(
  Sender: TObject);
begin
  inherited;
  cdsOrdPro.CheckBrowseMode;
end;

procedure TfrmAgruPedOrdProInd.cxGridDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Font.Color := clBlack;
  If (intRecDor = AViewInfo.GridRecord.RecordIndex) then
    ACanvas.Brush.Color := clGray
  Else
  If Odd(AViewInfo.GridRecord.RecordIndex) Then
    ACanvas.Brush.Color := intCorZeb;
end;

procedure TfrmAgruPedOrdProInd.cxGridDBTableViewMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  Site: TcxGridSite;
  HitTest: TcxCustomGridHitTest;
begin
  Site := Sender as TcxGridSite;
  HitTest := Site.GridView.ViewInfo.GetHitTest(X, Y);
  if HitTest is TcxGridRecordCellHitTest then
  begin
    intRecDor := TcxGridRecordCellHitTest(HitTest).GridRecord.RecordIndex;
    Site.Repaint;
  end;
end;

procedure TfrmAgruPedOrdProInd.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtDesEmp, arrCodEmp, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmAgruPedOrdProInd.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key , arrCodEmp, False) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAgruPedOrdProInd.edtCodTpaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodTpa, edtDesTpa, arrTpaAte, fRetNomTipoAtend, Nil, 'do Tipo de Atendimento');
end;

procedure TfrmAgruPedOrdProInd.edtCodTpaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {****************************************}
  {* NOVA CONSULTA DE TIPO DE ATENDIMENTO *}
  {*************************************MM*}
  If fPesqTipoAtendimento(Self, edtCodTpa, edtDesTpa, Nil, Key, arrTpaAte) Then
  Begin
    if fValidaCampos(edtCodTpa, True) then
      SelectNext(GetParentForm(self).ActiveControl, True, True);
  End;
end;

procedure TfrmAgruPedOrdProInd.edtRedLojExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtRedLoj,edtDesRedLoj,arrRedLoj,nil,fRetNomeRedeLoja,'da rede', 5);
end;

procedure TfrmAgruPedOrdProInd.edtRedLojKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {**********************************}
  {* NOVA CONSULTA DE REDE DE LOJAS *}
  {*******************************RV*}
  If fPesqRedeLojas(Self, edtRedLoj, edtDesRedLoj, Nil, Key, arrRedLoj, False) Then
  Begin
    If fValidaCampos(edtRedLoj, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmAgruPedOrdProInd.fGetSQLFatDor: String;
var
  objAgrupamentoPedidoEstoque: TAgrupamentoPedidoEstoque;
begin
  objAgrupamentoPedidoEstoque:= TAgrupamentoPedidoEstoque.Create;
  Try
    objAgrupamentoPedidoEstoque.strCodigoEmpresa:= VS_strCodEmp;
    Result:= objAgrupamentoPedidoEstoque.fGetSQLFatDor;
  Finally
    FreeAndNil(objAgrupamentoPedidoEstoque);
  End;

end;

procedure TfrmAgruPedOrdProInd.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Notebook.PageIndex = 1 Then
  Begin
    If fMensagem('','Deseja cancelar a geração ?', ['&Sim', '&Não'], 2) = 1 Then
      pReseta(False);

    Action := caNone;
  End;
end;

procedure TfrmAgruPedOrdProInd.FormCreate(Sender: TObject);
begin
  inherited;
  intTamCod := fTamCodIte;

  cdsFatGor := TZClient.Create(Self);
  cdsFatDor := TZClient.Create(Self, fGetSQLFatDor);

  blnConCom := fCfgSis('CONCOM', varBoolean);

  cxGridDBTableViewCOMPLE.Visible := blnConCom;
  cxgOrdProCOMPLE.Visible := cxGridDBTableViewCOMPLE.Visible;
  cxgOrdDetCOMPLE.Visible := cxGridDBTableViewCOMPLE.Visible;

  cdsFatGor.AfterScroll := pCdsFatGorAfterScroll;

  {REQ 174884 Se resolução disponível for inferior ou igual à (1366 x 768), ajusta a posição da tela!}
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.Position := poScreenCenter;

  cdsOrdPed := fCriaCdsOrdPed;
  dtsOrdPed := TDataSource.Create(Self);
  dtsOrdPed.DataSet := cdsOrdPed;
  cxgPedidosDBTableView.DataController.DataSource := dtsOrdPed;

  cdsOrdPro := fCriaCdsOrdPro;
  dtsOrdPro := TDataSource.Create(Self);
  dtsOrdPro.DataSet := cdsOrdPro;
  cxgOrdProDBTableView.DataController.DataSource := dtsOrdPro;

  lstOrdPro := TObjectDictionary<String, TOrdProIndustrial>.Create;

  blnPermitiSelecionaItensSemSaldoParaGeracaOPI:= fCfgSis('SEPASD', varBoolean);

  intCorZeb := fCfgSis('CORZEB', varInteger);
  intDecQtd := fCfgSis('DECQTD', varInteger);
  intDecUni := fCfgSis('DECUNI', varInteger);
  intRecGor := -2;
  intRecDor := -2;

end;

procedure TfrmAgruPedOrdProInd.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(dtsOrdPed);
  FreeAndNil(dtsOrdPro);
  FreeAndNil(cdsFatGor);
  FreeAndNil(cdsFatDor);
  FreeAndNil(cdsOrdPro);
  FreeAndNil(cdsOrdPed);
  lstOrdPro.Clear;
  FreeAndNil(lstOrdPro);

  If cdsSubItemSelecionado <> Nil Then
    FreeAndNil(cdsSubItemSelecionado);
end;

procedure TfrmAgruPedOrdProInd.FormShow(Sender: TObject);
begin
  inherited;
  Notebook.PageIndex := 0;
  pSetFocus(mskDtaIni);
  Self.WindowState := wsMaximized;

  If ((Not fCfgSis('TIPATE', varBoolean)) Or (Not fCfgSis('PEDTPA', varBoolean))) Then
    pnlTipAte.Visible := False;

  If Not pnlTipAte.Visible Then
    pnlFiltros.Height := pnlFiltros.Height - pnlTipAte.Height;
end;

function TfrmAgruPedOrdProInd.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin

    if (Sender = mskDtaIni) or (Sender = mskDtaFin) Then
    Begin
      mskDtaFin.Enabled := Not fEmptyDate(mskDtaIni.Text);
      If Not mskDtaFin.Enabled Then
        mskDtaFin.Clear
      Else
      Begin
        If (Sender = mskDtaFin) And (StrToDateDef(mskDtaFin.Text, 0) < StrToDateDef(mskDtaIni.Text, 0)) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO', 'A data final do pedido deve ser maior ou igual a data inicial!', ['&OK']);
        End;

        If Result Then
          TMaskEditFocus(Sender).Text := DateToStr(StrToDateDef(TMaskEditFocus(Sender).Text, 0));

      End;

    End

    Else If (Sender = mskIniEtr) or (Sender = mskFinEtr) Then
    Begin
      mskFinEtr.Enabled := Not fEmptyDate(mskIniEtr.Text);
      If Not mskFinEtr.Enabled Then
        mskFinEtr.Clear
      Else
      Begin
        If (Sender = mskFinEtr) And (StrToDateDef(mskFinEtr.Text, 0) < StrToDateDef(mskIniEtr.Text, 0)) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO', 'A data final do pedido deve ser maior ou igual a data inicial!', ['&OK']);
        End;

        If Result Then
          TMaskEditFocus(Sender).Text := DateToStr(StrToDateDef(TMaskEditFocus(Sender).Text, 0));
      End;
    End

    Else If (Sender = edtCodTpa) And pnlTipAte.Visible Then
    Begin
      edtDesTpa.Text := fRetNomTipoAtend(edtCodTpa.Text);

      If Not fEmptyStr(fTiraCaracEspeciais(edtCodTpa.Text)) Then
      Begin
        If fEmptyStr(edtDesTpa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este Tipo de Atendimento não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtCodEmp) Then
    Begin
      pDesMarcaLista(edtCodemp, arrCodEmp);
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmAgruPedOrdProInd.pCarregaFatGor;
  Var
    strCodEmp : String;
    strCodTpa : String;
    strRedLoj : String;
begin
  cdsFatGor.qryQuery.Close;
  cdsFatGor.qryQuery.SQL.Clear;
  cdsFatGor.qryQuery.SQL.Add(fGetSQLFatGor);

  pSetaParam(edtCodEmp.Text, arrCodEmp, strCodEmp, 'CODEMP', cdsFatGor.qryQuery);

  If pnlTipAte.Visible Then
    pSetaParam(edtCodTpa.Text, arrTpaAte, strCodTpa, 'CODTPA', cdsFatGor.qryQuery);

  pSetaParam(edtRedLoj.Text, arrRedLoj, strRedLoj, 'CODRED', cdsFatGor.qryQuery);

  pSetaParamPeriodo(mskDtaIni, mskDtaFin, cdsFatGor.qryQuery, 'INIPED', 'FINPED');
  pSetaParamPeriodo(mskIniEtr, mskFinEtr, cdsFatGor.qryQuery, 'INIETR', 'FINETR');

  If not cdsFatGor.Active Then
  Begin
    pCriaAggregate(cdsFatGor, 'PESOIT', 'aggPESOIT');
    pCriaAggregate(cdsFatGor, 'PESOMA', 'aggPESOMA');
    pCriaAggregate(cdsFatGor, 'MARDES', 'aggQTDMAR', '0');
  End;

  cdsFatGor.fAbreClient(True, 'TfrmAgruPedOrdProInd.pCarregaFatGor');

  If cdsFatGor.IsEmpty Then
    fMensagem('','Nenhum pedido encontrado!', ['&OK']);

  TDateField( cdsFatGor.FieldByName('FGO_DTAENT')).DisplayFormat := 'dd/mm/yyyy';
  TDateField( cdsFatGor.FieldByName('FGO_DTENTR')).DisplayFormat := 'dd/mm/yyyy';

  cxgFatGorDBTableView.DataController.DataSource := cdsFatGor.dtsSource;

  dbtMsgPed.DataSource := cdsFatGor.dtsSource;
  dbtMsgExp.DataSource := cdsFatGor.dtsSource;
  dbtPesoMa.DataSource := cdsFatGor.dtsSource;
  dbtQtdSel.DataSource := cdsFatGor.dtsSource;
  dbtPesoIt.DataSource := cdsFatGor.dtsSource;

  pAtualizaConfirmar;

end;

procedure TfrmAgruPedOrdProInd.pCdsFatGorAfterScroll(DataSet: TDataset);
begin
  If not cdsFatGor.Active Then
    Exit;

  cdsFatDor.qryQuery.ParamByName('AUTINC').AsString := cdsFatGor.FieldByName('AUTOINCREM').AsString;
  cdsFatDor.fAbreClient(True, 'TfrmAgruPedOrdProInd.pCdsFatGorAfterScroll');

  While not cdsFatDor.Eof Do
  Begin
    cdsFatDor.Edit;
    cdsFatDor.FieldByName('ITE_SALDOS').AsFloat := fRetornaSaldoDisponivel(cdsFatDor.FieldByName('FDO_CODITE').AsString,
                                                                           false,
                                                                           true,
                                                                           '',
                                                                           false,
                                                                           VS_StrCodEmp);


    cdsFatDor.FieldByName('ITE_SALDIS').AsFloat := fRetornaSaldoDisponivel(cdsFatDor.FieldByName('FDO_CODITE').AsString,
                                                                           false,
                                                                           true,
                                                                           '',
                                                                           True,
                                                                           VS_StrCodEmp,
                                                                           '',
                                                                           True,
                                                                           False,
                                                                           True);

    cdsFatDor.FieldByName('ITE_SALFIS').AsFloat := fRetornaSaldoFisico(cdsFatDor.FieldByName('FDO_CODITE').AsString,
                                                                       False,
                                                                       '',
                                                                       VS_StrCodEmp);

    cdsFatDor.FieldByName('ITE_SALRES').AsFloat := TSaldoReservado.New(
                       TReservaParametros.New()
                         .EmpresaItem(VS_StrCodEmp)
                         .CodigoItem(cdsFatDor.FieldByName('FDO_CODITE').AsString)
                         .CodEmpresa(VS_StrCodEmp)
                         .DesconsideraPedidosCorte(False)
                         .DesconsideraPedidosEnderecamento(True)
                         .ConverterML(False)
                         .TipoReserva(trsPedidoVenda)
                         .NumeroLote('')
                       ).fGetQuantidade();


    cdsFatDor.Post;

    cdsFatDor.Next;
  End;

  TFloatField( cdsFatDor.FieldByName('FDO_QTDITE') ).DisplayFormat := fMskDigitos( intDecQtd );
  TFloatField( cdsFatDor.FieldByName('FDO_UNITAR') ).DisplayFormat := fMskDigitos( intDecUni );
  TFloatField( cdsFatDor.FieldByName('FDO_TOTITE') ).DisplayFormat := fMskDigitos( intDecUni );
  TFloatField( cdsFatDor.FieldByName('ITE_SALDIS') ).DisplayFormat := fMskDigitos(3);
  TFloatField( cdsFatDor.FieldByName('ITE_SALFIS') ).DisplayFormat := fMskDigitos(3);
  TFloatField( cdsFatDor.FieldByName('ITE_SALRES') ).DisplayFormat := fMskDigitos(3);

  cxGridDBTableView.DataController.DataSource := cdsFatDor.dtsSource;
end;

procedure TfrmAgruPedOrdProInd.pCdsOrdProAfterScroll(DataSet: TDataset);
begin
  If (lstOrdPro.Count > 0) And
     lstOrdPro.ContainsKey(DataSet.FieldByName('CODITE').AsString +
                           DataSet.FieldByName('CODCOR').AsString +
                           IIF(blnConCom, DataSet.FieldByName('COMPLE').AsString, '')) Then

  Begin
    With lstOrdPro.Items[ DataSet.FieldByName('CODITE').AsString +
                          DataSet.FieldByName('CODCOR').AsString +
                          IIF(blnConCom, DataSet.FieldByName('COMPLE').AsString, '')] Do
    Begin
      Filter   := 'QTDPED > 0';
      Filtered := True;
      cxgOrdDetDBTableView.DataController.DataSource := dtsSource;

      cxgOrdDetDBTableViewESTUTI.Visible :=  fAgrLot And (RecordCount = 1) And
                                             (DataSet.FieldByName('CODITE').AsString = FieldByName('ORD_CODITE').AsString);
    End;

  End;

end;

procedure TfrmAgruPedOrdProInd.pcdsOrdProBeforePost(DataSet: TDataSet);
begin
  If (cdsOrdPro.FieldByName('VOLUME').AsFloat <= 0) And
     (cdsOrdPro.FieldByName('PESOIT').AsFloat <= 0) Then
    cdsOrdPro.FieldByName('IMPRIM').AsString := '0';

  If cdsOrdPro.FieldByName('MARCA').AsString = '0' Then
    cdsOrdPro.FieldByName('IMPRIM').AsString := '0';
end;

procedure TfrmAgruPedOrdProInd.pMarcar( opcMarcarP : TopcMarcar );
Begin
  If NoteBook.PageIndex = 0 Then
  Begin
    If not cdsFatGor.Active Then
      Exit;

    cdsFatGor.AfterScroll := Nil;

    Case opcMarcarP of
      opcMarcar    : Begin
                       cdsFatGor.Edit;
                       cdsFatGor.FieldByName('MARDES').AsString := '1';
                       cdsFatGor.FieldByName('PESOMA').AsFloat  := cdsFatGor.FieldByName('PESOIT').AsFloat;
                       cdsFatGor.Post;
                     End;

      opcDesmarcar : Begin
                       cdsFatGor.Edit;
                       cdsFatGor.FieldByName('PESOMA').AsString := '0';
                       cdsFatGor.FieldByName('MARDES').AsString := '0';
                       cdsFatGor.Post;
                     End;

      opcInverter  : Begin
                       If cdsFatGor.FieldByName('MARDES').AsString = '1' Then
                         pMarcar(opcDesmarcar)
                       Else
                         pMarcar(opcMarcar);
                     End;
    End;

    cdsFatGor.AfterScroll := pCdsFatGorAfterScroll;

  End
  Else
  Begin

    If not cdsOrdPro.Active Then
      Exit;

    Case opcMarcarP of
      opcMarcar    : Begin
                       Try
                         cdsOrdPro.DisableControls;
                         cdsOrdPro.Edit;
                         cdsOrdPro.FieldByName('MARCA').AsString := '1';
                         cdsOrdPro.Post;
                       Finally
                         cdsOrdPro.EnableControls;
                       End;
                     End;

      opcDesmarcar : Begin
                       Try
                         cdsOrdPro.DisableControls;
                         cdsOrdPro.Edit;
                         cdsOrdPro.FieldByName('MARCA').AsString := '0';
                         cdsOrdPro.Post;
                       Finally
                         cdsOrdPro.EnableControls;
                       End;
                     End;

      opcInverter  : Begin
                       If cdsOrdPro.FieldByName('MARCA').AsString = '1' Then
                         pMarcar(opcDesmarcar)
                       Else
                         pMarcar(opcMarcar);
                     End;
    End;

  End;

  pAtualizaConfirmar;

End;

procedure TfrmAgruPedOrdProInd.pObjOrdProBeforePost(DataSet: TDataSet);
begin
  strCodPag := DataSet.FieldByName('ITE_CODPAG').AsString;
  strCodCor := DataSet.FieldByName('ITE_CODCOR').AsString;
  strComple := DataSet.FieldByName('COMPLE').AsString;
end;

procedure TfrmAgruPedOrdProInd.pObjOrdProAfterPost(DataSet : TDataSet);
begin
  If blnConCom Then
  Begin
    If cdsOrdPro.Locate('CODITE;CODCOR;COMPLE', VarArrayOf( [strCodPag, strCodCor, strComple]), [] ) Then
    Begin
      cdsOrdPro.Edit;
      cdsOrdPro.FieldByName('VOLUME').AsFloat := fDoubleAggregate( TUniClientDataSet(DataSet), 'VOLUME');
      cdsOrdPro.FieldByName('PESOIT').AsFloat := fDoubleAggregate( TUniClientDataSet(DataSet), 'PESO');

      If (cdsOrdPro.FieldByName('VOLUME').AsFloat = 0) And
         (cdsOrdPro.FieldByName('PESOIT').AsFloat = 0) Then
         cdsOrdPro.FieldByName('MARCA').AsInteger := 0
      Else
      If cdsOrdPro.FieldByName('MARCA').AsInteger = 0 Then
      Begin
         cdsOrdPro.FieldByName('MARCA').AsInteger  := 1;
         cdsOrdPro.FieldByName('IMPRIM').AsInteger := 1;
      End;

      cdsOrdPro.Post;
    End
  End
  Else
  If cdsOrdPro.Locate('CODITE;CODCOR', VarArrayOf( [strCodPag, strCodCor]), [] ) Then
  Begin
    cdsOrdPro.Edit;
    cdsOrdPro.FieldByName('VOLUME').AsFloat := fDoubleAggregate( TUniClientDataSet(DataSet), 'VOLUME');
    cdsOrdPro.FieldByName('PESOIT').AsFloat := fDoubleAggregate( TUniClientDataSet(DataSet), 'PESO');

    If (cdsOrdPro.FieldByName('VOLUME').AsFloat = 0) And
       (cdsOrdPro.FieldByName('PESOIT').AsFloat = 0) Then
       cdsOrdPro.FieldByName('MARCA').AsInteger := 0
    Else
    If cdsOrdPro.FieldByName('MARCA').AsInteger = 0 Then
    Begin
       cdsOrdPro.FieldByName('MARCA').AsInteger  := 1;
       cdsOrdPro.FieldByName('IMPRIM').AsInteger := 1;
    End;

    cdsOrdPro.Post;
  End;

end;

procedure TfrmAgruPedOrdProInd.pObjOrdProAfterScroll(DataSet: TDataSet);
begin
  If Not cdsOrdPed.Active Then
    Exit;

  cdsOrdPed.Filter := 'CODITE = ' + QuotedStr( DataSet.FieldByName('ORD_CODITE').AsString );
  cdsOrdPed.Filtered := True;

end;

procedure TfrmAgruPedOrdProInd.pAtualizaConfirmar;
Begin
  If NoteBook.PageIndex = 0 Then
    btnConfirma.Enabled := (fDoubleAggregate(cdsFatGor, 'aggQTDMAR') > 0)
  Else
    btnConfirma.Enabled := (fDoubleAggregate(cdsOrdPro, 'aggMARCA') > 0);
End;

procedure TfrmAgruPedOrdProInd.pSintetizaOrdensProducao;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fSintetizaOrdensProducaoProgressso;
    frmGravando.lblGravando.Caption := 'Sintetizando ordens de produção...';
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
end;


procedure TfrmAgruPedOrdProInd.SelLotesExecute(Sender: TObject);
begin
  inherited;
  With lstOrdPro.Items[cdsOrdPro.FieldByName('CODITE').AsString +
                       cdsOrdPro.FieldByName('CODCOR').AsString +
                       IIF(blnConCom, cdsOrdPro.FieldByName('COMPLE').AsString, '')] Do
  Begin
    pSelecionaLotes;
  End;
end;

function TfrmAgruPedOrdProInd.fSintetizaOrdensProducaoProgressso(Progress: TCxProgressBar): Boolean;
  Var
    objOrdPro: TOrdProIndustrial;
Begin
  cdsOrdPed.EmptyDataSet;
  cdsOrdPro.EmptyDataSet;
  lstOrdPro.Clear;

  Try
    cdsFatGor.DisableControls;
    cdsFatDor.DisableControls;
    cdsOrdPro.AfterScroll := Nil;

    Progress.Properties.Max := cdsFatGor.RecordCount;
    Progress.Position       := 0;

    cdsFatGor.First;
    While Not cdsFatGor.Eof Do
    Begin
      If cdsFatGor.FieldByName('MARDES').AsInteger = 1 Then
      Begin
        cdsFatDor.First;
        While Not cdsFatDor.Eof Do
        Begin
          If blnConCom Then
          Begin
            If Not cdsOrdPro.Locate('CODITE;CODCOR;COMPLE', VarArrayOf([cdsFatDor.FieldByName('ITE_CODPAG').AsString,
                                                                        cdsFatDor.FieldByName('ITE_CODCOR').AsString,
                                                                        cdsFatDor.FieldByName('FDO_COMPLE').AsString]), [] ) Then
            Begin
              objOrdPro := TOrdProIndustrial.Create(Self);
              objOrdPro.pSetUpdateMode(upWhereKeyOnly);
              objOrdPro.blnAgrupamentoPedido := True;

              objOrdPro.BeforePost  := pObjOrdProBeforePost;
              objOrdPro.AfterPost   := pObjOrdProAfterPost;
              objOrdPro.AfterScroll := pObjOrdProAfterScroll;

              lstOrdPro.Add(cdsFatDor.FieldByName('ITE_CODPAG').AsString +
                            cdsFatDor.FieldByName('ITE_CODCOR').AsString +
                            cdsFatDor.FieldByName('FDO_COMPLE').AsString, objOrdPro);

              objOrdPro.fCarregaItens('', cdsFatDor.FieldByName('ITE_CODPAG').AsString,
                                          cdsFatDor.FieldByName('ITE_CODCOR').AsString);
              objOrdPro.qryQuery.FieldByName('AUTOINCREM').ProviderFlags := objOrdPro.qryQuery.FieldByName('AUTOINCREM').ProviderFlags + [pfInKey];
              cdsOrdPro.Insert;
              cdsOrdPro.FieldByName('CODITE').AsString  := cdsFatDor.FieldByName('ITE_CODPAG').AsString;
              cdsOrdPro.FieldByName('DESITE').AsString  := fRetNomProduto(cdsFatDor.FieldByName('ITE_CODPAG').AsString);
              cdsOrdPro.FieldByName('CODCOR').AsString  := cdsFatDor.FieldByName('ITE_CODCOR').AsString;
              cdsOrdPro.FieldByName('DESCOR').AsString  := fRetNomCor(cdsFatDor.FieldByName('ITE_CODCOR').AsString);

              if fCfgSis('PREMOP', varString) = '2' then
                cdsOrdPro.FieldByName('DTAPRE').AsDateTime:= VS_Date;

              cdsOrdPro.FieldByName('VOLUME').AsFloat   := 0.00;
              cdsOrdPro.FieldByName('PESOIT').AsFloat   := 0.00;
              cdsOrdPro.FieldByName('MARCA').AsInteger  := 1;
              cdsOrdPro.FieldByName('IMPRIM').AsInteger := 1;
              cdsOrdPro.FieldByName('COMPLE').AsString  := cdsFatDor.FieldByName('FDO_COMPLE').AsString;
              cdsOrdPro.Post;

              With lstOrdPro.Items[cdsFatDor.FieldByName('ITE_CODPAG').AsString +
                                   cdsFatDor.FieldByName('ITE_CODCOR').AsString +
                                   cdsFatDor.FieldByName('FDO_COMPLE').AsString] Do
              Begin
                Filtered := False;
                If Locate('ORD_CODITE', cdsFatDor.FieldByName('FDO_CODITE').AsString, [] ) Then
                Begin
                  Edit;
                  FieldByName('COMPLE').AsString := cdsFatDor.FieldByName('FDO_COMPLE').AsString;
                  Post;
                End;
              End;

            End;

            With lstOrdPro.Items[cdsFatDor.FieldByName('ITE_CODPAG').AsString +
                                 cdsFatDor.FieldByName('ITE_CODCOR').AsString +
                                 cdsFatDor.FieldByName('FDO_COMPLE').AsString] Do
            Begin
              Filtered := False;
              If Locate('ORD_CODITE;COMPLE', VarArrayOf([cdsFatDor.FieldByName('FDO_CODITE').AsString,
                                                         cdsFatDor.FieldByName('FDO_COMPLE').AsString]), []) Then
              Begin
                Edit;
                FieldByName('QTDPED').AsFloat := FieldByName('QTDPED').AsFloat + cdsFatDor.FieldByName('FDO_QTDITE').AsFloat;
                FieldByName('SALDOS').AsFloat := cdsFatDor.FieldByName('ITE_SALDOS').AsFloat;

                If FieldByName('QTDPED').AsFloat > FieldByName('SALDOS').AsFloat Then
                  FieldByName('SUGEST').AsFloat := FieldByName('QTDPED').AsFloat - FieldByName('SALDOS').AsFloat
                Else
                  FieldByName('SUGEST').AsFloat := 0.000;

                FieldByName('ORD_QTDPRO').AsFloat := FieldByName('SUGEST').AsFloat;

                If fRetQuantJaProduzida(cdsFatDor.FieldByName('FDO_SEQFDO').AsString) > 0 Then
                  FieldByName('QTDRST').AsFloat:= FieldByName('QTDPED').AsFloat - fRetQuantJaProduzida(cdsFatDor.FieldByName('FDO_SEQFDO').AsString)
                Else
                  FieldByName('QTDRST').AsFloat:= 0.00;

                FieldByName('COMPLE').AsString  := cdsFatDor.FieldByName('FDO_COMPLE').AsString;

                Post;

                cdsOrdPed.Insert;
                cdsOrdPed.FieldByName('CODITE').AsString := cdsFatDor.FieldByName('FDO_CODITE').AsString;
                cdsOrdPed.FieldByName('NUMDOC').AsString := cdsFatGor.FieldByName('FGO_NUMDOC').AsString;
                cdsOrdPed.FieldByName('CODEMP').AsString := cdsFatGor.FieldByName('FGO_CODEMP').AsString;
                cdsOrdPed.FieldByName('QTDITE').AsFloat  := cdsFatDor.FieldByName('FDO_QTDITE').AsFloat;
                cdsOrdPed.FieldByName('SEQFDO').AsString := cdsFatDor.FieldByName('FDO_SEQFDO').AsString;
                cdsOrdPed.FieldByName('CODPAG').AsString := cdsFatDor.FieldByName('ITE_CODPAG').AsString;
                cdsOrdPed.FieldByName('CODCOR').AsString := cdsFatDor.FieldByName('ITE_CODCOR').AsString;
                cdsOrdPed.FieldByName('COMPLE').AsString := cdsFatDor.FieldByName('FDO_COMPLE').AsString;
                cdsOrdPed.Post;

              End;
            End;
          End
          Else
          Begin
            If Not cdsOrdPro.Locate('CODITE;CODCOR', VarArrayOf([cdsFatDor.FieldByName('ITE_CODPAG').AsString,
                                                                 cdsFatDor.FieldByName('ITE_CODCOR').AsString]), [] ) Then
            Begin
              objOrdPro := TOrdProIndustrial.Create(Self);
              objOrdPro.pSetUpdateMode(upWhereKeyOnly);
              objOrdPro.blnAgrupamentoPedido := True;

              objOrdPro.BeforePost  := pObjOrdProBeforePost;
              objOrdPro.AfterPost   := pObjOrdProAfterPost;
              objOrdPro.AfterScroll := pObjOrdProAfterScroll;

              lstOrdPro.Add(cdsFatDor.FieldByName('ITE_CODPAG').AsString +
                            cdsFatDor.FieldByName('ITE_CODCOR').AsString, objOrdPro);

              objOrdPro.fCarregaItens('', cdsFatDor.FieldByName('ITE_CODPAG').AsString,
                                          cdsFatDor.FieldByName('ITE_CODCOR').AsString);

              objOrdPro.qryQuery.FieldByName('AUTOINCREM').ProviderFlags := objOrdPro.qryQuery.FieldByName('AUTOINCREM').ProviderFlags + [pfInKey];

              cdsOrdPro.Insert;
              cdsOrdPro.FieldByName('CODITE').AsString  := cdsFatDor.FieldByName('ITE_CODPAG').AsString;
              cdsOrdPro.FieldByName('DESITE').AsString  := fRetNomProduto(cdsFatDor.FieldByName('ITE_CODPAG').AsString);
              cdsOrdPro.FieldByName('CODCOR').AsString  := cdsFatDor.FieldByName('ITE_CODCOR').AsString;
              cdsOrdPro.FieldByName('DESCOR').AsString  := fRetNomCor(cdsFatDor.FieldByName('ITE_CODCOR').AsString);

              if fCfgSis('PREMOP', varString) = '2' then
                cdsOrdPro.FieldByName('DTAPRE').AsDateTime:= VS_Date;

              cdsOrdPro.FieldByName('VOLUME').AsFloat   := 0.00;
              cdsOrdPro.FieldByName('PESOIT').AsFloat   := 0.00;
              cdsOrdPro.FieldByName('MARCA').AsInteger  := 1;
              cdsOrdPro.FieldByName('IMPRIM').AsInteger := 1;
              cdsOrdPro.FieldByName('COMPLE').AsString  := cdsFatDor.FieldByName('FDO_COMPLE').AsString;
              cdsOrdPro.Post;

            End;

            With lstOrdPro.Items[cdsFatDor.FieldByName('ITE_CODPAG').AsString +
                                 cdsFatDor.FieldByName('ITE_CODCOR').AsString] Do
            Begin
              Filtered := False;
              If Locate('ORD_CODITE', cdsFatDor.FieldByName('FDO_CODITE').AsString, [] ) Then
              Begin
                Edit;
                FieldByName('QTDPED').AsFloat := FieldByName('QTDPED').AsFloat + cdsFatDor.FieldByName('FDO_QTDITE').AsFloat;
                FieldByName('SALDOS').AsFloat := cdsFatDor.FieldByName('ITE_SALDOS').AsFloat;

                If FieldByName('QTDPED').AsFloat > FieldByName('SALDOS').AsFloat Then
                  FieldByName('SUGEST').AsFloat := FieldByName('QTDPED').AsFloat - FieldByName('SALDOS').AsFloat
                Else
                  FieldByName('SUGEST').AsFloat := 0.000;

                FieldByName('ORD_QTDPRO').AsFloat := FieldByName('SUGEST').AsFloat;

                If fRetQuantJaProduzida(cdsFatDor.FieldByName('FDO_SEQFDO').AsString) > 0 Then
                  FieldByName('QTDRST').AsFloat:= FieldByName('QTDPED').AsFloat - fRetQuantJaProduzida(cdsFatDor.FieldByName('FDO_SEQFDO').AsString)
                Else
                  FieldByName('QTDRST').AsFloat:= 0.00;

                Post;

                cdsOrdPed.Insert;
                cdsOrdPed.FieldByName('CODITE').AsString := cdsFatDor.FieldByName('FDO_CODITE').AsString;
                cdsOrdPed.FieldByName('NUMDOC').AsString := cdsFatGor.FieldByName('FGO_NUMDOC').AsString;
                cdsOrdPed.FieldByName('CODEMP').AsString := cdsFatGor.FieldByName('FGO_CODEMP').AsString;
                cdsOrdPed.FieldByName('QTDITE').AsFloat  := cdsFatDor.FieldByName('FDO_QTDITE').AsFloat;
                cdsOrdPed.FieldByName('SEQFDO').AsString := cdsFatDor.FieldByName('FDO_SEQFDO').AsString;
                cdsOrdPed.FieldByName('CODPAG').AsString := cdsFatDor.FieldByName('ITE_CODPAG').AsString;
                cdsOrdPed.FieldByName('CODCOR').AsString := cdsFatDor.FieldByName('ITE_CODCOR').AsString;
                cdsOrdPed.FieldByName('COMPLE').AsString := cdsFatDor.FieldByName('FDO_COMPLE').AsString;
                cdsOrdPed.Post;

              End;

            End;
          End;
          cdsFatDor.Next;
        End;
      End;
      cdsFatGor.Next;
      Progress.Position := Progress.Position + 1;
    End;

    Result := True;

  Finally
    cdsFatGor.First;
    cdsFatGor.EnableControls;
    cdsFatDor.EnableControls;
    cdsOrdPro.First;
    cdsOrdPro.AfterScroll := pCdsOrdProAfterScroll;
    cdsOrdPro.BeforePost  := pcdsOrdProBeforePost;
  End;


End;

function TfrmAgruPedOrdProInd.fCriaCdsOrdPed: TUniClientDataSet;
Begin
  Result := TUniClientDataSet.Create(Self);

  With Result Do
  Begin
    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CODITE';
      DataType := ftString;
      Size     := intTamCod;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'NUMDOC';
      DataType := ftString;
      Size     := 12;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CODEMP';
      DataType := ftString;
      Size     := 3;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'QTDITE';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'SEQFDO';
      DataType := ftString;
      Size     := 20;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CODPAG';
      DataType := ftString;
      Size     := intTamCod;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CODCOR';
      DataType := ftString;
      Size     := 4;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'QTDPRO';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'QTDRST';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'COMPLE';
      DataType := ftString;
      Size     := 60;
      Required := False;
    End;

    CreateDataSet;
    LogChanges := False;
    Open;

    TFloatField( FieldByName('QTDITE') ).DisplayFormat := fMskDigitos( intDecQtd );

  End;

End;

function TfrmAgruPedOrdProInd.fCriaCdsOrdPro: TUniClientDataSet;
Begin
  Result := TUniClientDataSet.Create(Self);

  With Result Do
  Begin
    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CODITE';
      DataType := ftString;
      Size     := intTamCod;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'DESITE';
      DataType := ftString;
      Size     := 70;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CODCOR';
      DataType := ftString;
      Size     := 4;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'DESCOR';
      DataType := ftString;
      Size     := 60;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'DTAPRE';
      DataType := ftDateTime;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'VOLUME';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'PESOIT';
      DataType := ftFloat;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'MARCA';
      DataType := ftInteger;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'IMPRIM';
      DataType := ftByte;
      Required := False;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name     := 'COMPLE';
      DataType := ftString;
      Size     := 60;
      Required := False;
    End;

    AggregatesActive := True;

    pCriaAggregate(Result, 'MARCA', 'aggMARCA', '0');

    CreateDataSet;
    LogChanges := False;
    Open;

    TFloatField( FieldByName('VOLUME') ).DisplayFormat := '#,##0.000';
    TFloatField( FieldByName('PESOIT') ).DisplayFormat := '#,##0.000';

    AfterPost := pCdsOrdProAfterPost;
  End;

End;

procedure TfrmAgruPedOrdProInd.pCdsOrdProAfterPost(DataSet : TDataSet);
Begin
  pAtualizaConfirmar;
End;

function TfrmAgruPedOrdProInd.fGravaOrdens: Boolean;
  Var
    frmGrava : TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGrava);
    frmGrava.fExecutarAcao := fGravaOrdensProgresso;
    frmGrava.lblGravando.Caption := 'Gravando ordens de produção...';
    frmGrava.ShowModal;
    Result := frmGrava.blnConfirma;
  Finally
    FreeAndNil(frmGrava);
  End;

end;

procedure TfrmAgruPedOrdProInd.pGeraOrdemProducaoSemSaldo(blnGeraOrdProdSemSaldo: Boolean; qryTabela: TUniQuery);
begin
  If blnGeraOrdProdSemSaldo Then
  Begin
    With lstOrdPro.Items[cdsOrdPro.FieldByName('CODITE').AsString +
                         cdsOrdPro.FieldByName('CODCOR').AsString +
                         IIF(blnConCom, cdsOrdPro.FieldByName('COMPLE').AsString, '')] Do
    Begin
      fVerificaQuantidadeEstoque(qryTabela, True, False, cdsSubItemSelecionado);
    End;
  End;

end;

procedure TfrmAgruPedOrdProInd.pDesmarcaCheckItem(dtsValidaEstoque: TDataSource);
Begin
  If dtsValidaEstoque.DataSet.Active Then
  Begin

    dtsValidaEstoque.DataSet.FindFirst;

    while Not(dtsValidaEstoque.DataSet.eof) do
    Begin
      dtsValidaEstoque.DataSet.Edit;
      dtsValidaEstoque.DataSet.FieldByName('MARDES').Value:= 'D';
      dtsValidaEstoque.DataSet.Post;
      dtsValidaEstoque.DataSet.Next;
    End;

  End;


End;

procedure TfrmAgruPedOrdProInd.pCarregaFormularioProdSemSaldo(dtsValidaEstoque:TDataSource);
Begin
  pCriarFormularios(TfrmOrdProIndustrialProdSemSaldo, frmOrdProIndustrialProdSemSaldo);
  frmOrdProIndustrialProdSemSaldo.blnGeraOpSubProdutos := fCfgSis('GOPSPR', varBoolean);
  frmOrdProIndustrialProdSemSaldo.cxgItensView.DataController.DataSource := dtsValidaEstoque;
  pDesmarcaCheckItem(dtsValidaEstoque);

  frmOrdProIndustrialProdSemSaldo.cxgItensView.OptionsData.Editing    := blnPermitiSelecionaItensSemSaldoParaGeracaOPI;
  frmOrdProIndustrialProdSemSaldo.cxgItensViewColumn1.Options.Editing := False;
  frmOrdProIndustrialProdSemSaldo.cxgItensViewColumn2.Options.Editing := False;
  frmOrdProIndustrialProdSemSaldo.cxgItensViewColumn3.Options.Editing := False;
  frmOrdProIndustrialProdSemSaldo.cxgItensViewColumn4.Options.Editing := False;
  frmOrdProIndustrialProdSemSaldo.cxgItensViewColumn5.Options.Editing := blnPermitiSelecionaItensSemSaldoParaGeracaOPI;
  frmOrdProIndustrialProdSemSaldo.cxgItensViewColumn6.Options.Editing := False;
  frmOrdProIndustrialProdSemSaldo.cxgItensViewColumn7.Options.Editing := False;
  frmOrdProIndustrialProdSemSaldo.cxgItensViewColumn8.Options.Editing := False;
  frmOrdProIndustrialProdSemSaldo.cxgItensViewColumn9.Options.Editing := blnPermitiSelecionaItensSemSaldoParaGeracaOPI;
  frmOrdProIndustrialProdSemSaldo.cxgItensViewColumn9.Visible         := blnPermitiSelecionaItensSemSaldoParaGeracaOPI;
  frmOrdProIndustrialProdSemSaldo.btnGerOpe.Visible                   := blnPermitiSelecionaItensSemSaldoParaGeracaOPI;

  If Not fCfgSis('GEQTOP', varBoolean) Then
    frmOrdProIndustrialProdSemSaldo.ShowModal;

End;

function TfrmAgruPedOrdProInd.fGravaOrdensProgresso(Progress : TcxProgressBar) : Boolean;
  Var
    qryTabela  : TUniQuery;
    stlImprime : TStringList;
    objOrdImp  : TOrdProIndustrial;
    intCont    : Integer;
    blnImpEti  : Boolean;
    strLoteOp  : String;
    strSenLib  : String;
    blnApenasBaixar : Boolean;
    cdsValidaEstoque : TUniClientDataSet;
    dtsValidaEstoque : TDataSource;
    blnGeraOrdProdSemSaldo: Boolean;
    objordProGravar: TOrdProIndustrial;
Begin
  intQtdBai := 0;
  intQtdGer := 0;
  blnImpEti := False;
  stlImprime:= TStringList.Create;
  blnGeraOrdProdSemSaldo:= True;
  Result := True;
  Try

    qryTabela := fCriarQuery(' SELECT * FROM ORDGER WHERE FALSE ', Self);

    Progress.Properties.Max := cdsOrdPro.RecordCount;

    cdsOrdPro.First;
    cdsOrdPro.DisableControls;
    cdsOrdPed.DisableControls;
    cdsOrdPro.AfterScroll := Nil;

    cdsOrdPro.First;
    strLoteOp := '';
    If fAgrLot Then
    Begin
      Try
        pCriarFormularios(TfrmOrdProIndustrialImprimeLotes, frmOrdProIndustrialImprimeLotes);

        While Not cdsOrdPro.Eof Do
        Begin
          If (cdsOrdPro.FieldByName('MARCA').AsInteger = 1) Then
          Begin
            With lstOrdPro.Items[cdsOrdPro.FieldByName('CODITE').AsString +
                                 cdsOrdPro.FieldByName('CODCOR').AsString +
                                 IIF(blnConCom, cdsOrdPro.FieldByName('COMPLE').AsString, '')] Do
            Begin
              pCarregaProdutosFormula_Composicao(cdsOrdPro.FieldByName('CODITE').AsString,
                                                 cdsOrdPro.FieldByName('CODCOR').AsString);

              pCalculaQuantidadesUsadas;

              fSelecionaLotesReserva;
              frmOrdProIndustrialImprimeLotes.pAddItens(arrLotes, cdsOrdPro.FieldByName('CODITE').AsString);
            End;
          End;

          cdsOrdPro.Next;
        End;

        frmOrdProIndustrialImprimeLotes.pExibeRelatorio;

      Finally
        cdsOrdPro.First;
        FreeAndNil(frmOrdProIndustrialImprimeLotes);
      End;
    End;

    //Validação do saldo das quantidade utilizadas.
    If Pos( fCfgSis('SLD_OI', varString), 'AT') > 0 Then
    Begin
      Try

        While Not cdsOrdPro.Eof Do
        Begin
          If (cdsOrdPro.FieldByName('MARCA').AsInteger = 1) Then
          Begin
            objordProGravar := lstOrdPro.Items[cdsOrdPro.FieldByName('CODITE').AsString +
                                 cdsOrdPro.FieldByName('CODCOR').AsString +
                                 IIF(blnConCom, cdsOrdPro.FieldByName('COMPLE').AsString, '')];
            With objordProGravar Do
            Begin
              pCarregaProdutosFormula_Composicao(cdsOrdPro.FieldByName('CODITE').AsString,
                                                 cdsOrdPro.FieldByName('CODCOR').AsString);

              pCalculaQuantidadesUsadas;

              If not Assigned(cdsValidaEstoque) Then
              Begin
                cdsValidaEstoque := fCriaClientDatset(cdsProForProp, True);
                For intCont := 0 To cdsValidaEstoque.Fields.Count -1 Do
                Begin
                  If (cdsValidaEstoque.Fields[intCont] is TFloatField) Then
                    TFloatField(cdsValidaEstoque.Fields[intCont]).DisplayFormat := fMskDigitos(3);
                End;
              End;

              cdsProForProp.First;
              While (Not cdsProForProp.Eof) Do
              Begin
                If cdsProForProp.FieldByName('SEMSAL').AsString = 'S' Then
                Begin
                  if not cdsValidaEstoque.Locate('ITESUB', cdsProForProp.FieldByName('ITESUB').AsString, []) Then
                  Begin
                    cdsValidaEstoque.Insert;

                    For intCont := 0 To cdsProForProp.Fields.Count -1 Do
                      cdsValidaEstoque.Fields[intCont].Value := cdsProForProp.Fields[intCont].Value;
                  End
                  Else
                  Begin
                    cdsValidaEstoque.Edit;
                    cdsValidaEstoque.FieldByName('QTDTOT').AsFloat := cdsValidaEstoque.FieldByName('QTDTOT').AsFloat +
                                                                      cdsProForProp.FieldByName('QTDTOT').AsFloat;
                  End;

                  If (fCfgSis('SEPASD', varBoolean) Or fCfgSis('GEQTOP', varBoolean) ) And fCfgSis('GOPSPR', varBoolean) Then
                  Begin
                    If fEmptyStr(cdsValidaEstoque.FieldByName('PROACA').AsString) Or
                      cdsValidaEstoque.FieldByName('PROACA').IsNull Then
                    Begin
                      If fProdutoIntermediario(cdsProForProp.FieldByName('ITESUB').AsString) Then
                        cdsValidaEstoque.FieldByName('PROACA').AsString:= 'S';
                    End;
                  End;

                  cdsValidaEstoque.Post;
                End;

                cdsProForProp.Next;
              End;
            End;
          End;

          cdsOrdPro.Next;
        End;

        If (cdsValidaEstoque.RecordCount > 0) Then
        Begin
          dtsValidaEstoque := fCriaDataSource(cdsValidaEstoque);

          pCarregaFormularioProdSemSaldo(dtsValidaEstoque);

          {Permite selecionar e digitar a quantidade a ser produzida}
          If (fCfgSis('SEPASD', varBoolean) Or fCfgSis('GEQTOP', varBoolean)) And fCfgSis('GOPSPR', varBoolean) Then
          Begin
            blnGeraOrdProdSemSaldo:= frmOrdProIndustrialProdSemSaldo.blnConfirma = True;
            If cdsValidaEstoque.Locate('MARDES', 'M', []) Or (fCfgSis('GEQTOP', varBoolean)) Then
            Begin
              If blnGeraOrdProdSemSaldo Then
              Begin
                If not Assigned(cdsSubItemSelecionado) Then
                Begin
                  cdsSubItemSelecionado := fCriaClientDatset(cdsValidaEstoque, True);
                  For intCont := 0 To cdsSubItemSelecionado.Fields.Count -1 Do
                  Begin
                    If (cdsSubItemSelecionado.Fields[intCont] is TFloatField) Then
                      TFloatField(cdsSubItemSelecionado.Fields[intCont]).DisplayFormat := fMskDigitos(3);
                  End;
                End;

                cdsValidaEstoque.First;
                While (Not cdsValidaEstoque.Eof) Do
                Begin
                  If (cdsValidaEstoque.FieldByName('MARDES').AsString = 'M') Or (fCfgSis('GEQTOP', varBoolean)) Then
                  Begin
                    if not cdsSubItemSelecionado.Locate('ITESUB', cdsValidaEstoque.FieldByName('ITESUB').AsString, []) Then
                    Begin
                      cdsSubItemSelecionado.Insert;

                      For intCont := 0 To cdsValidaEstoque.Fields.Count -1 Do
                        cdsSubItemSelecionado.Fields[intCont].Value := cdsValidaEstoque.Fields[intCont].Value;
                    End
                    Else
                    Begin
                      cdsSubItemSelecionado.Edit;
                      cdsSubItemSelecionado.FieldByName('QTDTOT').AsFloat := cdsSubItemSelecionado.FieldByName('QTDTOT').AsFloat +
                                                                        cdsValidaEstoque.FieldByName('QTDTOT').AsFloat;
                    End;

                    cdsSubItemSelecionado.Post;
                  End;
                  cdsValidaEstoque.Next;
                End;
              End;
            End;
          End
          Else
          If fCfgSis('GOPSPR', varBoolean) Then
          Begin
            blnGeraOrdProdSemSaldo:= frmOrdProIndustrialProdSemSaldo.blnConfirma = True;
            If blnGeraOrdProdSemSaldo Then
            Begin
              If not Assigned(cdsSubItemSelecionado) Then
              Begin
                cdsSubItemSelecionado := fCriaClientDatset(cdsValidaEstoque, True);
                For intCont := 0 To cdsSubItemSelecionado.Fields.Count -1 Do
                Begin
                  If (cdsSubItemSelecionado.Fields[intCont] is TFloatField) Then
                    TFloatField(cdsSubItemSelecionado.Fields[intCont]).DisplayFormat := fMskDigitos(3);
                End;
              End;

              cdsValidaEstoque.First;
              While (Not cdsValidaEstoque.Eof) Do
              Begin

                if not cdsSubItemSelecionado.Locate('ITESUB', cdsValidaEstoque.FieldByName('ITESUB').AsString, []) Then
                Begin
                  cdsSubItemSelecionado.Insert;

                  For intCont := 0 To cdsValidaEstoque.Fields.Count -1 Do
                    cdsSubItemSelecionado.Fields[intCont].Value := cdsValidaEstoque.Fields[intCont].Value;
                End
                Else
                Begin
                  cdsSubItemSelecionado.Edit;
                  cdsSubItemSelecionado.FieldByName('QTDTOT').AsFloat := cdsSubItemSelecionado.FieldByName('QTDTOT').AsFloat +
                                                                    cdsValidaEstoque.FieldByName('QTDTOT').AsFloat;
                End;

                cdsSubItemSelecionado.FieldByName('MARDES').AsString:= 'M';
                cdsSubItemSelecionado.Post;

                cdsValidaEstoque.Next;
              End;
            End;

          End;

          FreeAndNil(frmOrdProIndustrialProdSemSaldo);


          If fCfgSis('SLD_OI') = 'T' Then
          Begin
            if not fVerificaAcessoSistema('SEN_OI', strLoginUsuarioLogado) Then
            Begin

              If ffrmSenha(strSenLib, 'Senha Produtos sem saldo') Then
              Begin
                Result := fVerificaAcessoSistema('SEN_OI',fRetCodVendedor(strSenLib));
                If Not Result Then
                Begin
                  pMensagemOk('A Senha não confere!');
                  Exit;
                End;

              End
              Else
                Exit;

            End;
          End;

          If fCfgSis('GOPSPR', varBoolean) And fCfgSis('GEQTOP', varBoolean) And Result Then
          Begin
            Result:= fMostraOPIQueSeraoGeradaParaProdutosSemSaldo(cdsValidaEstoque);
            If (Not(Result)) Then
              Exit;

          End;


        End;

      Finally
        cdsOrdPro.First;
        If Assigned(cdsValidaEstoque) Then
          FreeAndNil(cdsValidaEstoque);
      End;
    End;

    If fCfgSis('GOPSPR', varBoolean) Then
    Begin
      If Not(blnGeraOrdProdSemSaldo) Then
        Exit;
    End;


    If fMensagem('', 'Deseja continuar com a Gravação da Ordem de Produção?', ['&Sim', '&Não'], 2)= 2 Then
      Exit;

    Try
      fStartTransaction;
      While Not cdsOrdPro.Eof Do
      Begin
        If not blnImpEti Then
          blnImpEti := (cdsOrdPro.FieldByName('IMPRIM').AsInteger = 1);

        If (cdsOrdPro.FieldByName('MARCA').AsInteger = 1) Then
        Begin
          objordProGravar := lstOrdPro.Items[cdsOrdPro.FieldByName('CODITE').AsString +
                               cdsOrdPro.FieldByName('CODCOR').AsString +
                               IIF(blnConCom, cdsOrdPro.FieldByName('COMPLE').AsString, '')];
          With objOrdProGravar Do
          Begin
            blnApenasBaixar := (cdsOrdPro.FieldByName('VOLUME').AsFloat = 0) And
                               (cdsOrdPro.FieldByName('PESOIT').AsFloat = 0);

            If not blnApenasBaixar Then
            Begin
              Inc(intQtdGer);
              If fEmptyStr(strLoteOp) Then
                strLoteOp := fAtualizaProCod('LOTEOP', 'ORD_LOTEOP', 'ORDGER');

              Filtered := False;

              BeforePost  := Nil;
              AfterPost   := Nil;
              AfterScroll := Nil;

              qryTabela.Close;
              qryTabela.Open;
              qryTabela.Insert;

              qryTabela.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('ORDGER', VS_strCodEmp);
              qryTabela.FieldByName('ORD_CODEMP').AsString   := VS_strCodEmp;
              qryTabela.FieldByName('ORD_CODITE').AsString   := cdsOrdPro.FieldByName('CODITE').AsString;
              qryTabela.FieldByName('ORD_CODCOR').AsString   := cdsOrdPro.FieldByName('CODCOR').AsString;
              qryTabela.FieldByName('ORD_DTACAD').AsDateTime := VS_Date;
              qryTabela.FieldByName('ORD_DTAPRE').AsDateTime := cdsOrdPro.FieldByName('DTAPRE').AsDateTime;
              qryTabela.FieldByName('ORD_HORCAD').AsDateTime := fTime();
              qryTabela.FieldByName('ORD_LOTEOP').AsString   := strLoteOp;
              qryTabela.FieldByName('ORD_QTDPAR').AsInteger  := 1;
              qryTabela.FieldByName('ORD_CODOPE').AsString   := strLoginUsuarioLogado;
              qryTabela.FieldByName('ORD_FORMUL').AsInteger  := fRetFormulAtiva(cdsOrdPro.FieldByName('CODITE').AsString,
                                                                                cdsOrdPro.FieldByName('CODCOR').AsString);
              qryTabela.FieldByName('ORD_PESREA').AsFloat    := TOrdProIndustrial.fRetornaPesoRealFormula(cdsOrdPro.FieldByName('CODITE').AsString,
                                                                                                          cdsOrdPro.FieldByName('CODCOR').AsString);
              qryTabela.Post;

              recImpres.strAutImp := qryTabela.FieldByName('AUTOINCREM').AsString ;

              If (cdsOrdPro.FieldByName('IMPRIM').AsInteger = 1) Then
                stlImprime.Add(qryTabela.FieldByName('AUTOINCREM').AsString);

              pCarregaProdutosFormula_Composicao(qryTabela.FieldByName('ORD_CODITE').AsString,
                                                 qryTabela.FieldByName('ORD_CODCOR').AsString);

              pCalculaQuantidadesUsadas;
              Result := fSalvaOrdMat(qryTabela.FieldByName('AUTOINCREM').AsString);

              If fCfgSis('GOPSPR', varBoolean) Then
                pGeraOrdemProducaoSemSaldo(blnGeraOrdProdSemSaldo, qryTabela);

              Result := Result And fSalvaItens(qryTabela);

              If Result Then
              Begin
              cdsOrdPed.Filtered := False;
              cdsOrdPed.Filter   := 'CODPAG = ' + QuotedStr(cdsOrdPro.FieldByName('CODITE').AsString) +
                                    ' AND CODCOR = ' + QuotedStr(cdsOrdPro.FieldByName('CODCOR').AsString) +
                                    IIF(blnConCom, ' AND COMPLE = ' + QuotedStr(cdsOrdPro.FieldByName('COMPLE').AsString), '');

              cdsOrdPed.Filtered := True;
              While Not cdsOrdPed.Eof Do
              Begin
                pGravaORDFAT(qryTabela.FieldByName('AUTOINCREM').AsString, cdsOrdPed.FieldByName('SEQFDO').AsString, cdsOrdPed.FieldByName('QTDPRO').AsFloat);

                  Result := fSetSeqOpi(qryTabela.FieldByName('AUTOINCREM').AsString, cdsOrdPed.FieldByName('SEQFDO').AsString, blnApenasBaixar, cdsOrdPed.FieldByName('QTDRST').AsFloat);

                  If Not Result Then
                    cdsOrdPed.Last;

                  cdsOrdPed.Next;
                End;

              End;

            End
            Else
            Begin
              Inc(intQtdBai);
              Result := True;
            End;

            BeforePost  := pObjOrdProBeforePost;
            AfterPost   := pObjOrdProAfterPost;
            AfterScroll := pObjOrdProAfterScroll;

          End;
        End;

        If Not Result Then
          cdsOrdPro.Last;

        cdsOrdPro.Next;
        Progress.Position := Progress.Position + 1;
      End;

    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmAgruPedOrdProInd.fGravaOrdensProgresso');
      End;
    End;

  Finally
    cdsOrdPro.AfterScroll := pCdsOrdProAfterScroll;
    cdsOrdPro.EnableControls;
    cdsOrdPed.EnableControls;
    FreeAndNil(qryTabela);
    If cdsSubItemSelecionado <> Nil Then
      FreeAndNil(cdsSubItemSelecionado);

    If Result Then
      fCommit
    Else
      fRollBack;

  End;

  If Not Result Then
    Exit;

  If blnImpEti Then
    blnImpEti := (fMensagem('ATENÇÃO', 'Deseja imprimir etiquetas?', ['&Sim', '&Não']) = 1);

  cdsOrdPro.First;
  While Not cdsOrdPro.Eof Do
  Begin
    If (cdsOrdPro.FieldByName('IMPRIM').AsInteger = 1) And (cdsOrdPro.FieldByName('MARCA').AsInteger = 1) Then
    Begin
      With lstOrdPro.Items[cdsOrdPro.FieldByName('CODITE').AsString +
                           cdsOrdPro.FieldByName('CODCOR').AsString +
                           IIF(blnConCom, cdsOrdPro.FieldByName('COMPLE').AsString, '')] Do
      Begin

          Try
            objOrdImp :=  TOrdProIndustrial.Create(Nil);
            objOrdImp.blnAgrupamentoPedido := True;

            If (blnEditorRelatorios) Then
            Begin
              objOrdImp.blnEditorRelatorios := blnEditorRelatorios;
              objOrdImp.strEdtRelTabelaCadVal := strEdtRelTabelaCadVal;
              objOrdImp.blnEdtImpPorTabelaTmp := blnEdtImpPorTabelaTmp;
              objOrdImp.recImpres.strAutImp := recImpres.strAutImp;

            End
            Else If fCfgSis('ATIOPI', varBoolean) Then
            Begin
              pCriarFormularios(TfrmImpOrdProIndustrial, frmImpOrdProIndustrial);
              frmImpOrdProIndustrial.objOrdPro      := objOrdImp;
              frmImpOrdProIndustrial.blnSoConfigurar:= True;
            frmImpOrdProIndustrial.ShowModal;
            if frmImpOrdProIndustrial.ModalResult = mrOK Then
            Begin
              objOrdImp.recImpres.strAutImp := recImpres.strAutImp;
              objOrdImp.recImpres.blnFormul := frmImpOrdProIndustrial.chkFormul.Checked;
              objOrdImp.recImpres.blnCorrec := frmImpOrdProIndustrial.chkCorrec.Checked;
              objOrdImp.recImpres.blnConQua := frmImpOrdProIndustrial.chkConQua.Checked;
              objOrdImp.recImpres.blnTemPro := frmImpOrdProIndustrial.chkTemPro.Checked;
              objOrdImp.recImpres.blnEnvase := frmImpOrdProIndustrial.chkEnvase.Checked;
              objOrdImp.recImpres.blnFasDis := frmImpOrdProIndustrial.chkFasDis.Checked;
              objOrdImp.recImpres.blnExtrus := frmImpOrdProIndustrial.chkExtrusao.Checked;
              objOrdImp.recImpres.intQtdFas := StrToIntDef(frmImpOrdProIndustrial.edtQtdFas.Text, 0);
              objOrdImp.recImpres.strObserv := frmImpOrdProIndustrial.mmoObservacao.Texto;
              objOrdImp.recImpres.intQtdPar := StrToIntDef(frmImpOrdProIndustrial.edtQtdPar.Text,0);
            End;
            FreeAndNil(frmImpOrdProIndustrial);
          End
          Else
          Begin
            objOrdImp.recImpres.blnFormul := recImpres.blnFormul;
            objOrdImp.recImpres.blnCorrec := recImpres.blnCorrec;
            objOrdImp.recImpres.blnConQua := recImpres.blnConQua;
            objOrdImp.recImpres.blnTemPro := recImpres.blnTemPro;
            objOrdImp.recImpres.blnEnvase := recImpres.blnEnvase;
            objOrdImp.recImpres.blnFasDis := recImpres.blnFasDis;
            objOrdImp.recImpres.intQtdFas := recImpres.intQtdFas;
            objOrdImp.recImpres.strAutImp := recImpres.strAutImp;
            objOrdImp.recImpres.strObserv := recImpres.strObserv;
            objOrdImp.recImpres.intQtdPar := recImpres.intQtdPar;
          End;

          objOrdImp.pImprimeOP;
          If blnImpEti Then
            objOrdImp.pImprimeEtiqueta(FieldByName('ORD_CODITE').AsString);

        Finally
          FreeAndNil(objOrdImp);
        End;

      End;
    End;
    cdsOrdPro.Next;
  End;

{
  Try
    objOrdImp :=  TOrdProIndustrial.Create(Nil);

    For intIndex := 0 to stlImprime.Count -1 do
    Begin
      With objOrdImp Do
      Begin
        recImpres.blnFormul := True;
        recImpres.blnCorrec := True;
        recImpres.blnConQua := True;
        recImpres.blnTemPro := True;
        recImpres.blnEnvase := True;
        recImpres.blnFasDis := False;
        recImpres.intQtdFas := 1;
        recImpres.strAutImp := stlImprime[intIndex];

        pImprimeOP;
        If blnImpEti Then
          pImprimeEtiqueta;
      End;

    End;

  Finally
    FreeAndNil(objOrdImp);
    FreeAndNil(stlImprime);
  End;}

  If not fEmptyStr(strLoteOp) Then
  Begin

    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(233, 7964, [],
                          ['LOTEOP'],
                          [strLoteOp],
                          nil,
                          nil,
                          True);
    End;

  End;

End;

function TfrmAgruPedOrdProInd.fSetSeqOpi(strAutIncOrdGer,strAutIncFatDor : String; blnApenasBaixar : Boolean; fltQtdRestante: Double):Boolean;
  Var
    qryUpdate : TUniQuery;

Begin
  Try
    Result := True;

    qryUpdate := fCriaQuery(Self);
    With qryUpdate, SQL Do
    Begin
      Close;
      Clear;

      If blnApenasBaixar Then
      Begin

        If fltQtdRestante > 0 Then
          Exit;

        Add(' UPDATE EXTDOR SET FDO_BAIOPI = "S" WHERE FDO_SEQFDO = :SEQFDO ');

        Try
          ParamByName('SEQFDO').AsString := strAutIncFatDor;
          ExecSQL;
        Except
          On E : Exception Do
          Begin
            Result := False;
            pMensagensErro(e.Message, 'TfrmAgruPedOrdProInd.fSetSeqOpi');
          End;
        End;
      End
      Else
      Begin

        If fltQtdRestante > 0 Then
          Exit;

        Add(' UPDATE EXTDOR SET FDO_SEQOPI = :SEQOPI, FDO_BAIOPI = "S" WHERE FDO_SEQFDO = :SEQFDO ');

        Try
          ParamByName('SEQOPI').AsString := strAutIncOrdGer;
          ParamByName('SEQFDO').AsString := strAutIncFatDor;
          ExecSQL;
        Except
          On E : Exception Do
          Begin
            Result := False;
            pMensagensErro(e.Message, 'TfrmAgruPedOrdProInd.fSetSeqOpi');
          End;
        End;
      End;
    End;
  Finally
    FreeAndNil(qryUpdate);
  End;

End;

function TfrmAgruPedOrdProInd.fRetQuantJaProduzida(strSeqFat: String): Double;
  Var
    qryCons : TUniQuery;
Begin

  qryCons := fCriaQuery(Self);
  Try
    qryCons.Close;
    qryCons.SQL.Clear;
    qryCons.SQL.Add('SELECT IFNULL(SUM(FTO_QTDITE), 0) AS FTO_QTDITE FROM ORDFAT '+
                        ' WHERE FTO_SEQFAT = :SEQFAT AND '+
                        '       FTO_CODEMP = :CODEMP     ');

    qryCons.ParamByName('SEQFAT').AsString:= strSeqFat;
    qryCons.ParamByName('CODEMP').AsString:= VS_strCodEmp;
    qryCons.Open;

    result:= qryCons.FieldByName('FTO_QTDITE').AsFloat;

  Finally
    FreeAndNil(qryCons);
  End;

End;

procedure TfrmAgruPedOrdProInd.pGravaORDFAT(strSeGer, strSeqFDO: String; fltQtd: Double);
  CONST
    SQL_INSERT = ' INSERT INTO ORDFAT(        '+
                 '      AUTOINCREM,           '+
                 '      FTO_SEQGER,           '+
                 '      FTO_SEQFAT,           '+
                 '      FTO_QTDITE,           '+
                 '      FTO_CODEMP) VALUES (  '+
                 '      :AUTINC,              '+
                 '      :SEQGER,              '+
                 '      :SEQFAT,              '+
                 '      :QTDITE,              '+
                 '      :CODEMP)              ';

  Var
    qryExec : TUniQuery;

Begin

  qryExec := fCriaQuery(Self);
  Try

    Begin
      qryExec.Close;
      qryExec.SQL.Clear;
      qryExec.SQL.Add(SQL_INSERT);
      qryExec.ParamByName('SEQGER').AsString:= strSeGer;
      qryExec.ParamByName('SEQFAT').AsString:= strSeqFDO;
      qryExec.ParamByName('QTDITE').AsFloat := fltQtd;
      qryExec.ParamByName('CODEMP').AsString:= VS_strCodEmp;
      qryExec.ParamByName('AUTINC').AsString:= fRetAutoIncrem('ORDFAT', VS_strCodEmp);
      qryExec.ExecSQL;
    End;

  Finally
    FreeAndNil(qryExec);
  End;

End;

function TfrmAgruPedOrdProInd.fMostraOPIQueSeraoGeradaParaProdutosSemSaldo(cdsData: TUniClientDataSet): Boolean;
Var
  cdsGerOpi: TZClient;
  dtsGerOpi: TDataSource;
Begin
  cdsGerOpi:= TZClient.Create(Nil);
  dtsGerOpi:= fCriaDataSource(cdsGerOpi);
  cdsGerOpi.FieldDefs.Add('CODITE', ftString, 7);
  cdsGerOpi.FieldDefs.Add('CODCOR', ftString, 4);
  cdsGerOpi.FieldDefs.Add('NOMITE', ftString, 120);
  cdsGerOpi.FieldDefs.Add('NOMCOR', ftString, 30);
  cdsGerOpi.FieldDefs.Add('SALDOS', ftFloat);
  cdsGerOpi.FieldDefs.Add('QTDTOTACUMULADO', ftFloat);
  cdsGerOpi.FieldDefs.Add('QTDTOT', ftFloat);
  cdsGerOpi.FieldDefs.Add('DETALHE', ftString, 7);
  cdsGerOpi.CreateDataSet;
  cdsGerOpi.Open;

  TFloatField( cdsGerOpi.FieldByName('QTDTOTACUMULADO') ).DisplayFormat := fMskDigitos( intDecQtd );
  TFloatField( cdsGerOpi.FieldByName('QTDTOT') ).DisplayFormat := fMskDigitos( intDecQtd );

  cdsGerOpi.IndexFieldNames:= 'CODITE;CODCOR';

  Try

    cdsData.First;
    While Not(cdsData.Eof) Do
    Begin

      If fProdutoIntermediario(cdsData.FieldByName('ITESUB').AsString) Then
      Begin
        If fExisteFormulaAtiva(cdsData.FieldByName('ITESUB').AsString, cdsData.FieldByName('CODCOR').AsString) Then
        Begin

          cdsGerOpi.Insert;
          cdsGerOpi.FieldByName('CODITE').AsString:= cdsData.FieldByName('ITESUB').AsString;
          cdsGerOpi.FieldByName('CODCOR').AsString:= cdsData.FieldByName('CODCOR').AsString;
          cdsGerOpi.FieldByName('NOMITE').AsString:= fRetNomProduto(cdsData.FieldByName('ITESUB').AsString);
          cdsGerOpi.FieldByName('NOMCOR').AsString:= fRetNomCor(cdsData.FieldByName('CODCOR').AsString);
          cdsGerOpi.FieldByName('SALDOS').AsFloat:= cdsData.FieldByName('SALDOS').AsFloat;
          cdsGerOpi.FieldByName('QTDTOTACUMULADO').AsFloat:= (cdsData.FieldByName('QTDTOTACUMULADO').AsFloat - cdsData.FieldByName('SALDOS').AsFloat);
          cdsGerOpi.FieldByName('QTDTOT').AsFloat:= (cdsData.FieldByName('QTDTOT').AsFloat - cdsData.FieldByName('SALDOS').AsFloat);
          cdsGerOpi.FieldByName('DETALHE').AsString:= '';
          cdsGerOpi.Post;
        End;
      End;

      cdsData.Next;
    End;

    If Not(cdsGerOpi.IsEmpty) Then
    Begin

      pCriarFormularios(TfrmMostraOPIQueSeraoGeradaParaProdutosSemSaldo, frmMostraOPIQueSeraoGeradaParaProdutosSemSaldo);
      frmMostraOPIQueSeraoGeradaParaProdutosSemSaldo.cxgItensView.DataController.DataSource:= dtsGerOpi;
      frmMostraOPIQueSeraoGeradaParaProdutosSemSaldo.DataSet:= cdsGerOpi;
      frmMostraOPIQueSeraoGeradaParaProdutosSemSaldo.ShowModal;

      result:= frmMostraOPIQueSeraoGeradaParaProdutosSemSaldo.ModalResult = MrOk;

      If result Then
      Begin
        cdsSubItemSelecionado.EmptyDataSet;
        cdsGerOpi.First;
        while not cdsGerOpi.eof do
        Begin
          cdsSubItemSelecionado.Insert;
          cdsSubItemSelecionado.FieldByName('ITESUB').AsString:= cdsGerOpi.FieldByName('CODITE').AsString;
          cdsSubItemSelecionado.FieldByName('CODCOR').AsString:= cdsGerOpi.FieldByName('CODCOR').AsString;
          cdsSubItemSelecionado.FieldByName('SALDOS').AsFloat:= cdsGerOpi.FieldByName('SALDOS').AsFloat;
          cdsSubItemSelecionado.FieldByName('QTDTOTACUMULADO').AsFloat := cdsGerOpi.FieldByName('QTDTOTACUMULADO').AsFloat;
          cdsSubItemSelecionado.FieldByName('QTDTOT').AsFloat:= cdsGerOpi.FieldByName('QTDTOT').AsFloat;
          cdsSubItemSelecionado.FieldByName('MARDES').AsString:= 'M';
          cdsSubItemSelecionado.Post;
          cdsGerOpi.Next;
        End;
      End;

      FreeAndNil(frmMostraOPIQueSeraoGeradaParaProdutosSemSaldo);

    End
    Else
      result:= True;

  Finally
    FreeAndNil(cdsGerOpi);

  End;

End;

function TfrmAgruPedOrdProInd.fExisteFormulaAtiva(strCodIte, strCodCor: String): Boolean;
Var
  qryBusca: TUniQuery;
Begin
  qryBusca:= fCriaQuery(Nil);
  Try
    qryBusca.Close;
    qryBusca.SQL.Clear;
    qryBusca.SQL.Add(' SELECT AUTOINCREM FROM GEIMAT    '+
                     '   WHERE GMT_CODEMP = :CODEMP AND '+
                     '         GMT_CODITE = :CODITE AND '+
                     '         GMT_CODCOR = :CODCOR AND '+
                     '         GMT_STATUS = "A"');
    qryBusca.ParamByName('CODEMP').AsString:= VS_strCodEmp;
    qryBusca.ParamByName('CODITE').AsString:= strCodIte;
    qryBusca.ParamByName('CODCOR').AsString:= strCodCor;
    qryBusca.Open;

    result:= Not(qryBusca.IsEmpty);

  Finally
    FreeAndNil(qryBusca);
  End;

End;

function TfrmAgruPedOrdProInd.fValidarDataPrevisao: Boolean;
begin
  Result := True;
  cdsOrdPro.First;
  While Not cdsOrdPro.Eof Do
  Begin
    If fEmptyStr(cdsOrdPro.FieldByName('DTAPRE').AsString) Then
    begin
      fMensagem('ATENÇÃO', 'Necessário preencher a data de previsão!', ['&OK']);
      Exit(False);
    end;

    cdsOrdPro.Next;
  End;
end;

end.
