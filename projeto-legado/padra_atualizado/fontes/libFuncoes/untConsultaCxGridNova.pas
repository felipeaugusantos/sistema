unit untConsultaCxGridNova;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, ExtCtrls, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, StdCtrls, Buttons, ComCtrls, dxCore, untTypesSistema,
  StrUtils, untClassPanelCx, MaskUtils, BitBtnLockedIncrem, Menus, Uni,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, cxContainer,
  untConfiguraConsulta, cxInplaceContainer, cxVGrid, cxCalendar,
  cxTimeEdit, cxCurrencyEdit, cxMaskEdit, cxTextEdit,
  UniClientDataSet, UniDataSetProvider, MemDS, DBAccess, Datasnap.Provider,
  Vcl.ImgList, cxProgressBar, System.ImageList, untFuncoesCXGrid,
  Datasnap.DBClient, Winapi.PsAPI, cxSplitter, cxImage, cxLabel,
  dxLayoutContainer, cxGridViewLayoutContainer, cxGridLayoutView,
  cxGridDBLayoutView, cxGridCustomLayoutView, Vcl.WinXCtrls, Vcl.AppEvnts,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxImageList,
  untConstantes, dxColorEdit, cxImageComboBox, Winapi.ShellAPI;

Type

  EDumpStackTrace = class(Exception);

  TfrmConsultaCxGridNova = class(TForm)
    pnlBotoes: TPanel;
    dtsConsulta: TDataSource;
    pvdConsulta: TUniDataSetProvider;
    qryConsulta: TUniQuery;
    cdsConsulta: TUniClientDataSet;
    prbProgresso: TProgressBar;
    pnlConsulta: TPanel;
    pnlLegenda: TPanel;
    cxsrConsulta: TcxStyleRepository;
    btnSair: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnPadrao: TBitBtnLocked;
    btnCancel: TBitBtnLocked;
    btnLimpar: TBitBtnLocked;
    popSelecao: TPopupMenu;
    LimparSeleo1: TMenuItem;
    SelecionarTodos1: TMenuItem;
    InverterSeleo1: TMenuItem;
    N1: TMenuItem;
    btnConCon: TBitBtnLocked;
    splSepPes: TSplitter;
    pnlPesquisa: TPanel;
    cxgPesquisa: TcxVerticalGrid;
    cxgPesquisaRow1: TcxEditorRow;
    cxgPesquisaRow2: TcxEditorRow;
    cxgPesquisaRow3: TcxEditorRow;
    cxgPesquisaRow4: TcxEditorRow;
    cxgPesquisaRow5: TcxEditorRow;
    cxgPesquisaRow6: TcxEditorRow;
    cxgPesquisaRow7: TcxEditorRow;
    cxgPesquisaRow8: TcxEditorRow;
    cxgPesquisaRow9: TcxEditorRow;
    cxgPesquisaRow10: TcxEditorRow;
    cxgPesquisaRow11: TcxEditorRow;
    cxgPesquisaRow12: TcxEditorRow;
    cxgPesquisaRow13: TcxEditorRow;
    cxgPesquisaRow14: TcxEditorRow;
    cxgPesquisaRow15: TcxEditorRow;
    cxStyleSelecao: TcxStyle;
    cxgPesquisaCategoryRow1: TcxCategoryRow;
    splSepPes2: TSplitter;
    cxStyleEven: TcxStyle;
    pnlPanelSep: TPanel;
    cxStyleSort: TcxStyle;
    ScrollBox1: TScrollBox;
    lblMudaOrdem: TLabel;
    Label2: TLabel;
    lblMulSel: TLabel;
    cxStyleContent: TcxStyle;
    cxStyleHeader: TcxStyle;
    pnlPesquisaTop: TPanel;
    chkConsCo: TCheckBox;
    pnlTopo: TPanel;
    pnlGrid: TPanel;
    cxConsulta: TcxGrid;
    cxConsultaView: TcxGridDBTableView;
    cxConsultaNivel: TcxGridLevel;
    pnlBotGri: TPanel;
    btnCtrEnd: TSpeedButton;
    btnPgDown: TSpeedButton;
    btnCtrHom: TSpeedButton;
    btnPgUp: TSpeedButton;
    pgcRodape: TPageControl;
    lblTab: TLabel;
    cxgPesquisaRow16: TcxEditorRow;
    btnCadastro: TBitBtnLocked;
    pnlFundo: TPanel;
    splBanner: TcxSplitter;
    cxStyleRepository: TcxStyleRepository;
    cxStyle1: TcxStyle;
    pnlBanner: TPanel;
    ApplicationEvents: TApplicationEvents;
    btnLarCol: TBitBtnLocked;
    imglImageList: TImageList;
    lblAtalhoParaLimparPesquisa: TLabel;
    btnConfigSQL: TBitBtnLocked;
    cxStyleAuxiliar: TcxStyle;
    pnlPreFiltro: TPanel;
    qrySubGrid: TUniQuery;
    dtsSubGrid: TDataSource;
    pnlSimilares: TPanel;
    spltGrid: TSplitter;
    cdsSubGrid: TUniClientDataSet;
    pvdSubGrid: TUniDataSetProvider;
    cxSimilares: TcxGrid;
    cxSimilaresView: TcxGridDBTableView;
    cxSimilaresNivel: TcxGridLevel;
    pnlTituloSimilares: TPanel;
    pnlValidacaoPeriodo: TPanel;
    lblObrigatorios: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPadraoClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxConsultaViewKeyPress(Sender: TObject; var Key: Char);
    procedure cxConsultaViewDataControllerSortingChanged(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxConsultaViewDataControllerGroupingChanged(Sender: TObject);
    procedure cxConsultaViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxConsultaViewDblClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxConsultaViewSelectionChanged(Sender: TcxCustomGridTableView);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cxConsultaViewMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LimparSeleo1Click(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure SelecionarTodos1Click(Sender: TObject);
    procedure cxConsultaViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure btnConConClick(Sender: TObject);
    procedure cxgPesquisaEdited(Sender: TObject;
      ARowProperties: TcxCustomEditorRowProperties);
    procedure cxgPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgPesquisaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxConsultaViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnPgUpClick(Sender: TObject);
    procedure btnPgDownClick(Sender: TObject);
    procedure btnCtrEndClick(Sender: TObject);
    procedure btnCtrHomClick(Sender: TObject);
    procedure chkConsCoClick(Sender: TObject);
    procedure cxgPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure cxgPesquisaItemChanged(Sender: TObject; AOldRow: TcxCustomRow;
      AOldCellIndex: Integer);
    procedure btnCadastroClick(Sender: TObject);
   // procedure tmrBannerTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure splComVenCanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure splPromocCanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure splEstrutCanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure splBannerCanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure cxConsultaViewKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgComVenDBLayoutViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgPromocDBLayoutViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgEstrutDBLayoutViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure tmrAtualizaParcialKeyTimer(Sender: TObject);
    procedure btnLarColClick(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure cxConsultaViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure cdsConsultaBeforeRefresh(DataSet: TDataSet);
    procedure cdsConsultaAfterRefresh(DataSet: TDataSet);
    procedure cxConsultaViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxConsultaEnter(Sender: TObject);
    procedure cxgPesquisaEnter(Sender: TObject);
    procedure btnConfigSQLClick(Sender: TObject);
    procedure tmrAtualizarDadosTimer(Sender: TObject);
    procedure ApplicationEventsException(Sender: TObject; E: Exception);
    procedure cxgPesquisaExit(Sender: TObject);
    procedure cxConsultaViewMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure cxSimilaresViewDblClick(Sender: TObject);
    procedure cxSimilaresViewKeyPress(Sender: TObject; var Key: Char);
    procedure cxSimilaresViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxSimilaresViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure dtsSubGridDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    intCalSal,
    intCorFundo,
    intCorFonte: Integer;
    intCorFundoLegenda: Integer;

    blnSomenteComFiltro: Boolean;

    blnAtualizaConfig,
    blnUsouTab: Boolean;
    intLockTab: Integer;

    FSQLHaving: string;

    FTipCon: TTipoConsulta;
    FFilter: String;
    blnFetch: Boolean;

    FPrimeiraVez: Boolean;

    blnValidouFiltros,
    blnInformarPeriodoFinal,
    blnDirAce,
    blnReturn,
    blnApplyB,
    blnLimpandoFiltro: Boolean;
    blnSimilares: Boolean;

    blnPesquisaEnterSelectAll: Boolean;

    blnUsarFocusedRowIndex: Boolean;

    objConfConsulta: TConfiguraConsulta;

    blnMultiSelecao: Boolean;
    stlListSelecao : TStringList;

    sltCamDta  : TStringList;
    sltCamFlt  : TStringList;

    stlSQL   : TStringList;
    stlSQLPadrao: TStringList;
    stlCampos: TStringList;
    stlOrdem : TStringList;
    intLasPac: Integer;
    strLasFil: String;
    strLastOrder: String;

    blnHighlightGrid: Boolean;

    blnIniciandoTela  : Boolean;
    blnFinalizandoTela: Boolean;

    blnAbortar  : Boolean;
    blnLeuTudo  : Boolean;

    strFiltroAplicado: String;

    blnPrimeiraVez: Boolean;

    blnAtualizandoParcialKey: Boolean;
    strCodigoSimiliarSelecionado : String;

   // objComVen: TComVen;
   // objPromoc: TItemPromo;
   // objEstrut: TGerMat;

    procedure SetarSimilarSelecionado;
    procedure pCarregarListaSelecao;
    function tmrAtualizaParcialKey: TNewTimer;
    function tmrAtualizarDados: TNewTimer;

    Procedure pSetaParametros(qryConsulta: TUniQuery);

    procedure pSetarQueryTraceViewerEvents;

    Function fAjustaColunas(pgbProgresso: TcxProgressBar): Boolean;
    Procedure pAjustaColunas;

    Function fRetOrderBy: String;
    Function fRetHaving: String;
    Function fGetNextPacket: Integer;
    Function fResolveConflito(strSQL: String): String;

    Function fCampoToSubConsulta(strSQL: String;
                                 blnComAlias,
                                 blnParentiza: Boolean): String;

    Function fRetDisplayFormat(strCampo: String): String;

    procedure pSetFocusConsulta(blnFirst: Boolean = False);
    procedure pSalvaConfiguracoes(blnSalvaColunasAutomaticamente: Boolean = True);
    procedure pAtualizaPesquisa;
    procedure pFiltrarRegistros;
    procedure pProximoPacote;
    procedure pCtrlEnd(blnProMsg: Boolean);
    procedure pSetaNomeColunas;
    procedure pSetaNomeColunas_similares;
    procedure pSetaMascaras;
    procedure pSetaMascaras_Similares;
    procedure pSetaDisplayGeneric;
    procedure pSetaDisplaySimilares;
    procedure pSelecionar;

    procedure pSetaArrMascaras(arrCampos: TarrCampos; prcDisTxt: TprcDisplayText);
    procedure pSetaArrMascarasSimilares(arrCampos: TarrCampos; prcDisTxt: TprcDisplayText);
    procedure pSetaArrMascarasComposta(arrCampos: TarrCamposDuplo);

    procedure pAlinhaCamposNumericos(cdsGeneric: TUniClientDataSet);
    procedure pCarregaCamposData;
    Procedure pAtualizaDados;
    procedure pProcessaSimilares;

    procedure pAddListaQuery(blnInverter : Boolean = True);
    Procedure pMudaOrdenacao(strNomCol: String);

    Procedure pExibirCheckConsultaContida;

    function fGetChaveConsulta: String;

    Function fRetChaveLista: String;

    function fCheckParent(Sender, Parent: TWinControl): Boolean;
    function fInLista(strChave: String): Boolean;

    procedure pLimparSelecao;

    procedure pTeclaAtalhoLimparFiltrosDePesquisa(Var Key: word);
    procedure pLimparFiltro;

    procedure pCriaColunasGrid;

    Function fAtualiza(pgbProgresso: TcxProgressBar): Boolean;
    procedure pExecpAfterAtualiza(blnEnableDisableGrid: Boolean=False);

    procedure pSetaFetch;

    procedure pMontaColunasGrid;

    procedure pHighlightGrid(ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo);

    procedure pWMMessageLimparFiltro(var Message: TMessage); Message WM_MESSAGELIMPARFILTROCONSULTA;
    procedure pWMMessageAtualizaPesquisa(var Message: TMessage); Message WM_MESSAGEATUALIZAPESQUISA;
    procedure pGravarErro(GravarErro:Boolean; MensagemErro:String; strRelatorio: String='');
    function fRetornaStack: String;
    function fSetVisibleNomeColuna(intIndice: Integer): Boolean;
    procedure pAjustaColunasSimilares;
    procedure pAjustaColunasBetween ;
    function fCriaColunaBetween(const AStrCampo: string):TField ;
    function fRetornaDescricaoBetween(const AStrCampo: string):string ;

    procedure pAplicaFiltro(AstrValue: String);

    Function fAjustaUnion(strFilter: String; intPosWhere: Integer): String;
    procedure pRefreshSimilares;
  protected
    procedure pAtualiza(tpcTipCon: TTipoConsulta; strFilter: String = ''); virtual;
  public
    { Public declarations}
    strNomForm : String;
    strCodBusca: String;
    strTitPesq : String;
    blnConfirma: Boolean;
    blnSimples : Boolean;
    blnRefresh : Boolean;
    arrNomCol  : Array Of String;
    arrCodSel  : Array Of String;

    arrSelec   : TConsultasArray;

    objConsulta: TDefConsulta;

    objFrmPnl   : TPanelCx;
    objPnlBanner: TPanelCx;
    objPnlPreFiltro: TPanelCx;
    pAfterAtualiza: TGenericProcedureWithClientParam;
    pBeforeAtualiza: TGenericProcedureWithClientParamAndVar;

    blnConCon: Boolean;
    fChamaCadastro : TBooleanFunctionWithBooleanParam;

    blnConIte: Boolean;
    strAutoIncremSimilarSelecionado : String;

    Procedure pSetaSql(arrSQL: Array Of String);
    Procedure pSetaCampos(arrCampos: Array Of String);
    Procedure pSetaOrdenacao(arrOrdenacao: Array Of String);
  end;

  procedure pSetCxControlsScrollbarModeClassic(AWinControl: TWinControl);

Const
  TMR_DEFAULT = 500;

var
  frmConsultaCxGridNova: TfrmConsultaCxGridNova;
  VS_frmConsulta: TForm;

implementation

uses
  cxGridDBDataDefinitions,
  System.RegularExpressions,
  untPesquisa, untGravando, System.UITypes, untFuncoesGen;

{$R *.dfm}

Const
  VK_PGUP   = 33;
  VK_PGDOWN = 34;
  VK_ALT    = 18;
  INTPACREC = 50;

procedure HighlightCellText(ACanvas: TCanvas; const ARect: TRect;
  DisplayText, FilterText: string; Alignment: TAlignment; BkColor, fnColor: TColor);
  var
    HlRect : TRect;
    Start : Integer;
    Position : Integer;
    HlText: string;

  function fRemoveAcento(Str:String): String;
    Const
      ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹"¥';
      SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU  ';
    Var
      x : Integer;
  Begin
    For x := 1 to Length(Str) do
      If Pos(Str[x],ComAcento)<>0 Then
        Str[x] := SemAcento[Pos(Str[x],ComAcento)];
    Result := Str;
  end;

  function FindText(subText, Text: String; Start: Integer = 0): Integer;
  begin
    Result := 0;

    Text    := fRemoveAcento(Text);
    subText := fRemoveAcento(subText);

    Text := Copy(Text, start, Length(Text));

    If Pos(subText, Text) > 0 Then
      Result := Start + Pos(subText, Text);
  end;

begin
  Start := 1;
  while True do
  begin
    Position := FindText(AnsiLowerCase(FilterText), AnsiLowerCase(DisplayText), Start) - 1;
    Start := Position + Length(FilterText);

    if Position <= 0 then
      Break;

    case Alignment of
      TAlignment.taLeftJustify:  HlRect.Left := ARect.Left + ACanvas.TextWidth(Copy(DisplayText, 1, Position - 1)) + 1;
      TAlignment.taRightJustify: HlRect.Left := ARect.Right - ACanvas.TextWidth(DisplayText) + ACanvas.TextWidth(Copy(DisplayText, 1, Position - 1)) - 3;
      TAlignment.taCenter:       HlRect.Left := ARect.Left + ((ARect.Right - ARect.Left) div 2) - (ACanvas.TextWidth(DisplayText) div 2) + ACanvas.TextWidth(Copy(DisplayText, 1, Position - 1)) - 1;
    end;

    HlRect.Top := ARect.Top + 2;
    HlRect.Right := HlRect.Left + ACanvas.TextWidth(Copy(DisplayText, Position, Length(FilterText))) + 1;
    HlRect.Bottom := ARect.Bottom - 3;

    if HlRect.Right > ARect.Right then
      HlRect.Right := ARect.Right;

    ACanvas.Brush.Color := BkColor;
    ACanvas.FillRect(HlRect);

    ACanvas.Font.Color := fnColor;
    HlText := Copy(DisplayText, Position, Length(FilterText));
    ACanvas.TextRect(HlRect, HlRect.Left + 1, HlRect.Top, HlText);
  end;
end;


type
  TcxControlHack = class(TcxControl);
  TcxContainerHack = class(TcxContainer);
procedure pSetCxControlsScrollbarModeClassic(AWinControl: TWinControl);
Var
  I: Integer;
begin
  For I := 0 To AWinControl.ControlCount -1 Do
  Begin
    If AWinControl.Controls[I] Is TcxControl Then
      TcxControlHack(AWinControl.Controls[I]).LookAndFeel.ScrollbarMode := sbmClassic;
    If AWinControl.Controls[I] Is TcxContainer Then
      TcxContainerHack(AWinControl.Controls[I]).Style.LookAndFeel.ScrollbarMode := sbmClassic;
    If AWinControl.Controls[I] Is TWinControl Then
      pSetCxControlsScrollbarModeClassic(TWinControl(AWinControl.Controls[I]));
  End;
end;

Procedure TfrmConsultaCxGridNova.pSetaOrdenacao(arrOrdenacao: Array Of String);
  Var
    intIndice: Integer;
Begin
  stlOrdem.Clear;

  For intIndice := Low(arrOrdenacao) To High(arrOrdenacao) Do
    stlOrdem.Add(Trim(arrOrdenacao[intIndice]));

End;

procedure TfrmConsultaCxGridNova.SetarSimilarSelecionado;
begin
  If Not Assigned(objFrmPnl) Then
    Exit;

  If Not objFrmPnl.blnTemPan Then
    Exit;

  If Not Assigned(cdsSubGrid) Then
    Exit;

  If Not cdsSubGrid.Active Then
    Exit;

  If cdsSubGrid.IsEmpty Then
    Exit;

  If Not Assigned(cdsSubGrid.FindField('ITE_CODITE')) Then
    Exit;

  If Not Assigned(cdsSubGrid.FindField('AUTOINCREM')) Then
    Exit;

  strAutoIncremSimilarSelecionado := cdsSubGrid.FieldByName('AUTOINCREM').AsString;
  strCodigoSimiliarSelecionado := cdsSubGrid.FieldByName('ITE_CODITE').AsString;
end;

{*******************************}
{* SELE«√O DE V¡RIOS REGISTROS *}
{****************************RV*}
procedure TfrmConsultaCxGridNova.pSelecionar;
  Var
    intCon: Integer;
    intARowIndex: Integer;
    ARowInfo: TcxRowInfo;
begin

  If (Not fEmptyStr(strCodigoSimiliarSelecionado)) Then
  Begin
    SetLength(arrCodSel, 1);
    arrCodSel[0] := strCodigoSimiliarSelecionado;
  End;

  If Assigned(objFrmPnl) And objFrmPnl.blnTemPan And
     (objFrmPnl.strSimilar <> '') Then
  Begin
    SetLength(arrCodSel, 1);
    arrCodSel[0] := objFrmPnl.strSimilar;
  End

  Else If blnSimples Or (stlListSelecao.Count = 0) Then
  Begin
    SetLength(arrCodSel, 0);
    With cxConsultaView.DataController Do
    Begin
      For intCon := 0 To Pred(GetSelectedCount) do
      Begin
        intARowIndex := GetSelectedRowIndex(intCon);
        ARowInfo     := GetRowInfo(intARowIndex);
        SetLength(arrCodSel, Length(arrCodSel) + 1);
        arrCodSel[Length(arrCodSel) - 1] := VarToStr(Values[ARowInfo.RecordIndex, cxConsultaView.GetColumnByFieldName(strCodBusca).Index]);
      End;
    End;
  End Else
  Begin

    SetLength(arrCodSel, stlListSelecao.Count);

    For intCon := 0 To stlListSelecao.Count - 1 do
    Begin
      arrCodSel[intCon] := stlListSelecao[intCon];
    End;

  End;
end;

Procedure TfrmConsultaCxGridNova.pSetaCampos(arrCampos: Array Of String);
  Var
    intIndice: Integer;
Begin
  stlCampos.Clear;
  For intIndice := Low(arrCampos) To High(arrCampos) Do
    stlCampos.Add(Trim(arrCampos[intIndice]));
End;

Procedure TfrmConsultaCxGridNova.pSetaSql(arrSQL: Array Of String);
  Var
    intIndice: Integer;
    blnTemWhere: Boolean;
    strSQL: String;
Begin
  blnTemWhere := False;
  stlSQL.Clear;
  stlSQLPadrao.Clear;
  For intIndice := Low(arrSQL) To High(arrSQL) Do
  Begin
    If AnsiStartsStr('WHERE', Trim(arrSQL[intIndice])) Then
    Begin
      blnTemWhere := True;

      strSQL := Trim(arrSQL[intIndice]);
      Insert(']', strSQL, 6);
      strSQL := '[' +  strSQL;
      stlSQLPadrao.Add(fSafeSQLValue(strSQL));
    End
    Else
      stlSQLPadrao.Add(fSafeSQLValue(Trim(arrSQL[intIndice])));

    stlSQL.Add(fSafeSQLValue(Trim(arrSQL[intIndice])));
  End;

  If Not blnTemWhere Then
  Begin
    stlSQL.Add('WHERE TRUE');

    stlSQLPadrao.Add('[WHERE] TRUE');
  End;
End;

procedure TfrmConsultaCxGridNova.SelecionarTodos1Click(Sender: TObject);
  Var
    strBookMark : TBookmark;
begin
  Try
    strBookMark := cdsConsulta.Bookmark;
    If cdsConsulta.Active And (Not cdsConsulta.IsEmpty) Then
    Begin
      With cdsConsulta Do
      Begin
        DisableControls;
        First;
        While not Eof do
        Begin
          pAddListaQuery( TMenuItem(Sender).Tag = 0 );
          Next;
        End;
      End;
    End;
  Finally
    cdsConsulta.Bookmark := strBookMark;
    cdsConsulta.EnableControls;
  End;
end;

procedure TfrmConsultaCxGridNova.splBannerCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  Accept := False;
end;

procedure TfrmConsultaCxGridNova.splComVenCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  Accept := False;
end;

procedure TfrmConsultaCxGridNova.splEstrutCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  Accept := False;
end;

procedure TfrmConsultaCxGridNova.splPromocCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  Accept := False;
end;

function TfrmConsultaCxGridNova.tmrAtualizaParcialKey: TNewTimer;
begin
  if not TNewTimer.Has(Self.Name + '.tmrAtualizaParcialKey') then
  begin
    Result := TNewTimer.Get(Self.Name + '.tmrAtualizaParcialKey');
    Result.Timeout  := 3000;
    Result.Interval := 600;
    Result.Enabled  := False;
    Result.OnTimer  := tmrAtualizaParcialKeyTimer;
  end
  else
    Result := TNewTimer.Get(Self.Name + '.tmrAtualizaParcialKey');
end;

procedure TfrmConsultaCxGridNova.tmrAtualizaParcialKeyTimer(Sender: TObject);
begin
  If tmrAtualizaParcialKey.Enabled Then
  Begin
    tmrAtualizaParcialKey.Enabled := False;
    blnAtualizandoParcialKey := True;
    Try
      pAtualizaPesquisa;
      pAtualizaDados;
    Finally
      blnAtualizandoParcialKey := False;
    End;
  End;
end;

function TfrmConsultaCxGridNova.tmrAtualizarDados: TNewTimer;
begin
  if not TNewTimer.Has(Self.Name + '.tmrAtualizarDados') then
  begin
    Result := TNewTimer.Get(Self.Name + '.tmrAtualizarDados');
    Result.Timeout  := 2000;
    Result.Interval := 100;
    Result.Enabled  := False;
    Result.OnTimer  := tmrAtualizarDadosTimer;
  end
  else
    Result := TNewTimer.Get(Self.Name + '.tmrAtualizarDados');
end;

procedure TfrmConsultaCxGridNova.tmrAtualizarDadosTimer(Sender: TObject);
begin
  pProcessaSimilares;
  tmrAtualizarDados.Enabled := False;
end;

procedure TfrmConsultaCxGridNova.ApplicationEventsException(Sender: TObject; E: Exception);
var
  strMensagem: string;
begin
  strMensagem := 'N„o È possÌvel recuperar a imagem do produto' + #13;
  if (Pos('Unsupported image format', E.Message) > 0) then
  begin
    if (cdsConsulta.Active) and (not cdsConsulta.IsEmpty)
       and (Assigned(cdsConsulta.FindField('ITE_CODITE'))) then
      strMensagem := strMensagem +
                     cdsConsulta.FieldByName('ITE_CODITE').AsString +
                     IfThen(Assigned(cdsConsulta.FindField('ITE_DESITE')),
                            ' - ' + cdsConsulta.FieldByName('ITE_DESITE').AsString, '') + #13;

    strMensagem := strMensagem +
                   'Ela pode estar danificada ou n„o ser compatÌvel com as extensıes suportadas.' + #13 +
                   'As extensıes suportadas s„o: *.jpeg, *.jpg, *.png' + #13 +
                   'Verifique se imagem pode ser aberta com duplo clique no Windows Explorer.' + #13 +
                   'Caso o erro persista, procure o departamento de TI.';

    fMensagem('', strMensagem, ['&O k']);
  end;
end;

procedure TfrmConsultaCxGridNova.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin

  // DESABILITANDO MENU POPUP
  Case Msg.Message of
    516: Msg.Message := WM_NULL;
  End;

end;

procedure TfrmConsultaCxGridNova.btnCadastroClick(Sender: TObject);
begin
  If Assigned(fChamaCadastro) Then
    fChamaCadastro(False);
end;

procedure TfrmConsultaCxGridNova.btnCancelClick(Sender: TObject);
begin
  If fMensagem('', 'Deseja cancelar a operaÁ„o?', ['&Sim', '&N„o']) = 1 Then
    blnAbortar := True;
end;

procedure TfrmConsultaCxGridNova.pSalvaConfiguracoes(blnSalvaColunasAutomaticamente: Boolean = True);
  Var
    intRecNo: Integer;
Begin
  If blnAtualizaConfig And cdsConsulta.Active Then
  Begin
    If blnUsarFocusedRowIndex Then
      intRecNo := Succ(cxConsultaView.Controller.FocusedRowIndex)
    Else
      intRecNo := cdsConsulta.RecNo;

    objPesquisa.pSalvaFiltros(cxgPesquisa, intRecNo);

    objPesquisa.pSalvaFiltros(cxgPesquisa, cdsConsulta.RecNo);

    objConfConsulta.fSalvaPesquisa(pnlPesquisa.ClientHeight,
                                   cxConsultaView,
                                   cdsConsulta,
                                   False,
                                   blnSalvaColunasAutomaticamente);
  End;
End;

procedure TfrmConsultaCxGridNova.btnConConClick(Sender: TObject);
var
  blnPermiteAtualiza: Boolean;
begin
  If Not blnDirAce Then
    Exit;

  pSalvaConfiguracoes;

  blnPermiteAtualiza := False;
  If assigned(objFrmPnl) Then
  Begin
    If assigned(objFrmPnl.prcAtualizaAplicacao) Then
      blnPermiteAtualiza := True;
  End;

  If objConfConsulta.fEditaConfiguracoes(blnPermiteAtualiza) Then
  Begin
    pMontaColunasGrid;

    pExibirCheckConsultaContida;
    objConfConsulta.pMudaCorZebra(True);
    objPesquisa.pCarregaFiltros(Nil, fGetChaveConsulta, cxgPesquisa, False);
    If Assigned(objFrmPnl) And objFrmPnl.blnTemPan Then
    Begin
      objFrmPnl.blnExpand := objConfConsulta.recConfigur.blnExpand;
      If assigned(objFrmPnl.prcAtualizaAplicacao) Then
        objFrmPnl.prcAtualizaAplicacao;
    End;
  End;

  If Assigned(cxgPesquisa.FocusedRow) Then
  Begin
    If Assigned(objConsulta) And Not objConsulta.strCampoBuscaPalavraExataPorToken.IsEmpty And
      (objConfConsulta.fNomeRowToNomeCampo(cxgPesquisa.FocusedRow.Name) = objConsulta.strCampoBuscaPalavraExataPorToken) Then
    Begin
      chkConsCo.Enabled := False;
      chkConsCo.Checked := False;
    End
    Else If Assigned(objConsulta) And Not objConsulta.strCampoBuscaPalavraExataPorToken.IsEmpty And
      (objConfConsulta.fNomeRowToNomeCampo(cxgPesquisa.FocusedRow.Name) = objConfConsulta.fAliasCampoFiltro((objConsulta.strCampoBuscaPalavraExataPorToken))) Then
    Begin
      chkConsCo.Enabled := False;
      chkConsCo.Checked := False;
    End
    Else If Assigned(objConsulta) And Not objConsulta.strCampoBuscaComplementarPorToken.IsEmpty And
      (objConfConsulta.fNomeRowToNomeCampo(cxgPesquisa.FocusedRow.Name) = objConsulta.strCampoBuscaComplementarPorToken) Then
    Begin
      chkConsCo.Enabled := False;
      chkConsCo.Checked := False;
    End
    Else If Assigned(objConsulta) And Not objConsulta.strCampoBuscaComplementarPorToken.IsEmpty And
      (objConfConsulta.fNomeRowToNomeCampo(cxgPesquisa.FocusedRow.Name) = objConfConsulta.fAliasCampoFiltro((objConsulta.strCampoBuscaComplementarPorToken))) Then
    Begin
      chkConsCo.Enabled := False;
      chkConsCo.Checked := False;
    End
    Else
    Begin
      chkConsCo.Enabled := True;
      chkConsCo.Checked := objConfConsulta.fConsultaContida(objConfConsulta.fNomeRowToNomeCampo(cxgPesquisa.FocusedRow.Name));
    End;
  End;

  lblObrigatorios.Visible := objConfConsulta.blnTemCampoObrigatorio;

  pSetaFetch;
end;

procedure TfrmConsultaCxGridNova.btnConfigSQLClick(Sender: TObject);
begin
  If Not btnConfigSQL.Visible Then
    Exit;

  If Assigned(objConsulta) And Assigned(objConsulta.funcConfiguraConsulta) Then
  Begin
    objConsulta.strSQLPadrao := fCampoToSubConsulta(AnsiReplaceStr(stlSQLPadrao.Text, 'SQL_NO_CACHE', ' '), True, True);
    objConsulta.stlNomeColunas.Text := stlCampos.Text;

    If objConsulta.funcConfiguraConsulta(objConsulta) Then
      btnSair.Click;
  End;
end;

procedure TfrmConsultaCxGridNova.btnConfirmaClick(Sender: TObject);
begin
  {***************************}
  {* SIMPLES OU NAO TEM QUE  *}
  {* PEGAR SELE«√O DO ARRAY  *}
  {************************NC*}
  If Not btnConfirma.Visible Then
    Exit;

  pSelecionar;
  blnConfirma := True;
  btnSair.Click;
end;

procedure TfrmConsultaCxGridNova.btnCtrEndClick(Sender: TObject);
begin
  pCtrlEnd(True);
end;

procedure TfrmConsultaCxGridNova.btnCtrHomClick(Sender: TObject);
begin
  pSetFocusConsulta;
  Keybd_Event(VK_HOME, 0, 0, 0);
end;

procedure TfrmConsultaCxGridNova.btnLimparClick(Sender: TObject);
  Var
    posMouse : TPoint;
begin
  GetCursorPos(posMouse);
  popSelecao.Popup(posMouse.X + 5, posMouse.Y + 5);
end;

procedure TfrmConsultaCxGridNova.pAjustaColunas;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.pgbStatus.Visible   := False;
    frmGravando.blnDesabilitaMouse  := True;
    frmGravando.lblGravando.Caption := 'Ajustando tamanho das colunas...';
    frmGravando.fExecutarAcao := fAjustaColunas;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmConsultaCxGridNova.pAjustaColunas]');
    End;
  End;

  pFreeAndNil(frmGravando);
End;

function TfrmConsultaCxGridNova.fCriaColunaBetween(const AStrCampo: string):TField ;
var
  LField : TField ;
begin
  Result := Nil ;
  LField := cdsConsulta.FindField(AStrCampo) ;
  if not Assigned(LField) then
  begin
    exit ;
  end;

  if LField.DataType in [ftDate, ftDateTime] then
  begin
    Result := TDateTimeField.Create(cdsConsulta);
  end
  else if LField.DataType in [ftTime] then
  begin
    Result := TTimeField.Create(cdsConsulta);
  end
  else if LField.DataType in [ftFloat, ftCurrency, ftBCD] then
  begin
    Result := TFloatField.Create(cdsConsulta);
  end
  else if LField.DataType in [ftInteger, ftSmallint, ftWord, ftBytes, ftAutoInc] then
  begin
    Result := TIntegerField.Create(cdsConsulta);
  end
  else
  begin
    Result := TStringField.Create(cdsConsulta);
  end;
end;

function TfrmConsultaCxGridNova.fRetornaDescricaoBetween(const AStrCampo: string):string ;
var
  intCnt: integer ;
begin
  result := '' ;
  for intCnt := 0 to cdsConsulta.Fields.Count-1 do
  begin
    if cdsConsulta.Fields.Fields[intCnt].FieldName = AStrCampo then
    begin
      result := Trim(stlCampos.Strings[intCnt]) + ' Final' ;
      stlCampos.Strings[intCnt] := stlCampos.Strings[intCnt] + ' Inicial' ;
    end;
  end;
end;

procedure TfrmConsultaCxGridNova.pAjustaColunasBetween;
var
  intCnt, intCnt2: integer ;
  arrCamposBetween: TarrCampos ;
  intColAutoInc: integer ;
  Field: TField;
begin
  If Assigned(objConsulta) Then
  begin
    arrCamposBetween := objConsulta.arrCamBetween ;
  end
  else
  begin
    arrCamposBetween := Nil;
  end;

  if not Assigned(arrCamposBetween) then
  begin
    exit ;
  end;

  if Length(arrCamposBetween) = 0 then
  begin
    exit ;
  end;

  cdsConsulta.FieldDefs.Update;
  for intCnt := 0 to cdsConsulta.FieldDefs.Count - 1 do
  begin
    if cdsConsulta.FieldDefs[intCnt].Name = 'AUTOINCREM' then
    begin
      for intCnt2 := Low(arrCamposBetween) to High(arrCamposBetween) do
      begin
        Field := fCriaColunaBetween(arrCamposBetween[intCnt2]);
        if Assigned(Field) then
        begin
          Field.FieldName := arrCamposBetween[intCnt2]+'_FIM';
          Field.Calculated := True;
          Field.DataSet := cdsConsulta;
          intColAutoInc := stlCampos.IndexOf(cdsConsulta.FieldDefs[intCnt].Name) ;
          if intColAutoInc <> -1 then
          begin
            stlCampos.Insert(intColAutoInc,fRetornaDescricaoBetween(arrCamposBetween[intCnt2]));
          end
          else
          begin
            stlCampos.Add(fRetornaDescricaoBetween(arrCamposBetween[intCnt2])) ;
          end;
        end;
      end;
      /// adiciona por o ultimo o field do autoincrem
      cdsConsulta.FieldDefs[intCnt].CreateField(cdsConsulta);
    end
    else
    begin
      cdsConsulta.FieldDefs[intCnt].CreateField(cdsConsulta);
    end;
  end;
end;

procedure TfrmConsultaCxGridNova.pAjustaColunasSimilares;
var i: integer;
  cxColuna: TcxGridDBColumn;
  Field: TField;
begin
  cxSimilaresView.BeginUpdate;
  Try
    For i := cxSimilaresView.ColumnCount -1 DownTo   0   Do
      cxSimilaresView.Columns[i].Free;

    For i := 0 To  cxConsultaView.ColumnCount -1 Do
    Begin
      Field := cdsConsulta.FieldByName(cxConsultaView.Columns[i].DataBinding.FieldName);

      cxColuna := TcxGridDBColumn(cxSimilaresView.FindItemByName(Concat('cxSimilaresView', Field.FieldName)));
      cxColuna.Free;
      If Not Assigned(cxColuna) Then
        cxColuna := TcxGridDBColumn(cxSimilaresView.DataController.CreateItemByField(Field));
      cxColuna.Width := cxConsultaView.Columns[i].Width;
      cxColuna.Caption := Field.DisplayLabel;
      cxColuna.Properties := cxConsultaView.Columns[i].Properties;
    End;
    pAlinhaCamposNumericos(cdsSubGrid);
    pSetaDisplaySimilares;
  Finally
    cxSimilaresView.EndUpdate;
  End;
end;

Function TfrmConsultaCxGridNova.fAjustaColunas(pgbProgresso: TcxProgressBar): Boolean;
Begin
  Application.ProcessMessages;
  If Not cdsConsulta.IsEmpty Then
    cxConsultaView.ApplyBestFit;

  frmGravando.lblGravando.Caption := 'Ajustando pesquisa...';
  Application.ProcessMessages;

  objConfConsulta.pAjustaTamanhoDefaultGridPesquisa;

  If Assigned(objConsulta) Then
  Begin
    frmGravando.lblGravando.Caption := 'Ajustando Ìcones...';
    Application.ProcessMessages;
    objConsulta.pConfiguraIcones(cxConsultaView, imglImageList);
    objConsulta.pConfiguraColorEdit(cxConsultaView);
    objConsulta.pConfiguraIconeSobEncomenda(cxConsultaView);
  End;

  Result := True;
End;

procedure TfrmConsultaCxGridNova.btnPadraoClick(Sender: TObject);
begin
  btnPadrao.Enabled := False;

  If cdsConsulta.IsEmpty Then
    pAtualiza(tcpPrimeira, objConfConsulta.fSQLFiltro(FSQLHaving));

  If Assigned(objFrmPnl) And Assigned(objFrmPnl.prcParouNavegacaoGridConsulta) Then
    If Not blnFinalizandoTela Then
    begin
      objFrmPnl.prcParouNavegacaoGridConsulta;
      tmrAtualizarDados.Enabled := True;
    End;

  pAjustaColunas;

  btnPadrao.Enabled := True;
end;

procedure TfrmConsultaCxGridNova.btnPgDownClick(Sender: TObject);
begin
  pSetFocusConsulta;
  Keybd_Event(VK_PGDOWN, 0, 0, 0);
end;

procedure TfrmConsultaCxGridNova.btnPgUpClick(Sender: TObject);
begin
  pSetFocusConsulta;
  Keybd_Event(VK_PGUP, 0, 0, 0);
end;

procedure TfrmConsultaCxGridNova.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConsultaCxGridNova.btnLarColClick(Sender: TObject);
begin

  objConfConsulta.fSalvaPesquisa(pnlPesquisa.ClientHeight,
                                 cxConsultaView,
                                 cdsConsulta,
                                 True);

end;

procedure TfrmConsultaCxGridNova.cdsConsultaAfterRefresh(DataSet: TDataSet);
begin
  pExecpAfterAtualiza(True);
  pRefreshSimilares;
end;

procedure TfrmConsultaCxGridNova.pRefreshSimilares;
begin
  If (Not Assigned(cdsSubGrid)) Then
    Exit;

  If (Not cdsSubGrid.Active) Then
    Exit;

  If (cdsSubGrid.IsEmpty) Then
    Exit;

  cdsSubGrid.Refresh;
end;

procedure TfrmConsultaCxGridNova.cdsConsultaBeforeRefresh(DataSet: TDataSet);
begin
  cdsConsulta.CancelUpdates;
end;

procedure TfrmConsultaCxGridNova.chkConsCoClick(Sender: TObject);
begin
  If Assigned(cxgPesquisa.FocusedRow) Then
    objConfConsulta.pDefineConsultaContida(chkConsCo.Checked, objConfConsulta.fNomeRowToNomeCampo(cxgPesquisa.FocusedRow.Name));
end;

procedure TfrmConsultaCxGridNova.pWMMessageAtualizaPesquisa(
  var Message: TMessage);
begin
  blnReturn := True;//Para forÁar executar a pesquisa
  blnLimpandoFiltro := False;

  Try
    blnSomenteComFiltro := True;

    pAtualizaPesquisa;
    pSetFocus(cxgPesquisa);

  Finally
    blnReturn := False;
    blnSomenteComFiltro := False;
  End;
end;

procedure TfrmConsultaCxGridNova.pWMMessageLimparFiltro(var Message: TMessage);
begin
  pLimparFiltro;
end;

procedure TfrmConsultaCxGridNova.cxConsultaEnter(Sender: TObject);
begin
  PostMessage(Application.Handle, WM_MESSAGENAVEGANDOGRIDCONSULTA, 0, 0);

  If Assigned(objFrmPnl) And Assigned(objFrmPnl.prcParouNavegacaoGridConsulta) Then
    If Not blnFinalizandoTela Then
    begin
      objFrmPnl.prcParouNavegacaoGridConsulta;
      tmrAtualizarDados.Enabled := True;
    End;
end;

procedure TfrmConsultaCxGridNova.cxConsultaViewCellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
var
  strLink: String;
begin
  If Assigned(objFrmPnl) And Assigned(objFrmPnl.prcParouNavegacaoGridConsulta) Then
    If Not blnFinalizandoTela Then
    Begin
      objFrmPnl.prcParouNavegacaoGridConsulta;
      tmrAtualizarDados.Enabled := True;
    End;

  If Not Assigned(objConsulta) Then
    Exit;


  If (objConsulta.LocateFieldLink(TcxGridDbColumn(ACellViewInfo.Item).DataBinding.FieldName)) Then
  Begin
    strLink := ACellViewInfo.Text;
    If Pos('http', strLink) > 0 Then
      untFuncoesGen.pBrowserNavigate(PWChar(strLink));
  End;
end;

procedure TfrmConsultaCxGridNova.cxConsultaViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    styStyle: TcxStyle;
    intLeft: Integer;
    strTexto: String;
    blnUsouLegenda: Boolean;
begin
  If Assigned(objConsulta) Then
  Begin
    If objConsulta.LocateFieldLink(TcxGridDbColumn(AViewInfo.Item).DataBinding.FieldName) Then
    Begin
      ACanvas.Font.Color := clBlue;
      ACanvas.Font.Style := [fsUnderline];
      Exit;
    End;
  End;

  If (AViewInfo.Item.SortOrder <> soNone) Or
     (Assigned(objConsulta) And (objConsulta.fCellBold(cxConsultaView, AViewInfo.GridRecord, AViewInfo.Item, cdsConsulta))) Then
    ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];

  If AViewInfo.Selected Then
  Begin

    blnUsouLegenda := False;

    If Assigned(objConsulta) Then
    Begin

      styStyle := objConsulta.fGetCellStyle(cxConsultaView,  AViewInfo.GridRecord,  AViewInfo.Item, cdsConsulta);

      If Assigned(styStyle) Then
      Begin

        ACanvas.Font.Color := styStyle.TextColor;
        ACanvas.Font.Style := [fsBold];
        blnUsouLegenda := True;

      End
      Else
      Begin

        If intCorFonte <> -1 Then
          ACanvas.Font.Color := intCorFonte;

      End;

    End
    Else
    Begin

      If intCorFonte <> -1 Then
        ACanvas.Font.Color := intCorFonte;

    End;

    If intCorFundo <> -1 Then
      ACanvas.Brush.Color := intCorFundo;

    If blnUsouLegenda Then
    Begin

      If fCalculaContraste(ACanvas.Brush.Color, ACanvas.Font.Color) < 125 Then
      Begin
        If fCalculaContraste(intCorFundoLegenda, ACanvas.Font.Color) > 125 Then
          ACanvas.Brush.Color := intCorFundoLegenda

        Else If fCalculaContraste(clLtGray, ACanvas.Font.Color) > fCalculaContraste(ACanvas.Brush.Color, ACanvas.Font.Color) Then
                If fCalculaContraste($00DDDDDD, ACanvas.Font.Color) > fCalculaContraste(clLtGray, ACanvas.Font.Color) Then
                  ACanvas.Brush.Color := $00DDDDDD
                Else
                  ACanvas.Brush.Color := clLtGray;
      End

    End;

  End; {If AViewInfo.Selected Then}

  If (Not blnSimples) And (Not cdsConsulta.IsEmpty) And
     fInLista(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                                    cxConsultaView.GetColumnByFieldName(strCodBusca).Index])) Then
  Begin

    ACanvas.Brush.Color := clMoneyGreen;

  End;

  If (AViewInfo.Item.PropertiesClass = TdxColorEditProperties) Or
     (AViewInfo.Item.PropertiesClass = TcxImageComboBoxProperties) Then
    Exit;

  If blnHighlightGrid And (Pos(TcxGridItemDBDataBinding(AViewInfo.Item.DataBinding).FieldName, 'VENDIDO_') <= 0) Then
  Begin
    ACanvas.FillRect(AViewInfo.Bounds, ACanvas.Brush.Color);
    strTexto := AViewInfo.Text;
    intLeft := 0;
    Case TcxGridItemDBDataBinding(AViewInfo.Item.DataBinding).Field.Alignment Of
      TAlignment.taLeftJustify:  intLeft := AViewInfo.Bounds.Left + 2;
      TAlignment.taRightJustify: intLeft := AViewInfo.Bounds.Right - ACanvas.TextWidth(strTexto) - 2;
      TAlignment.taCenter:       intLeft := AViewInfo.Bounds.Left + ((AViewInfo.Bounds.Right - AViewInfo.Bounds.Left) div 2) - (ACanvas.TextWidth(strTexto) div 2);
    End;
    ACanvas.TextOut(intLeft, AViewInfo.Bounds.Top + 2, strTexto);

    pHighlightGrid(ACanvas, AViewInfo);
    ADone := True;
  End;
end;

procedure TfrmConsultaCxGridNova.cxConsultaViewDataControllerGroupingChanged(
  Sender: TObject);
begin
  pCtrlEnd(False);
end;

procedure TfrmConsultaCxGridNova.cxConsultaViewDataControllerSortingChanged(
  Sender: TObject);
begin
  If Assigned(objConfConsulta) then
    objConfConsulta.pPosicionaOrdenacao;

  If (Not blnIniciandoTela) And (Not blnFinalizandoTela) And (Not blnLeuTudo) And (intLasPac <> 0) Then
  Begin
    pAtualiza(tcpOrdemFiltro, objConfConsulta.fSQLFiltro(FSQLHaving));

    If Assigned(objFrmPnl) And Assigned(objFrmPnl.prcParouNavegacaoGridConsulta) Then
      If Not blnFinalizandoTela Then
      begin
        objFrmPnl.prcParouNavegacaoGridConsulta;
        tmrAtualizarDados.Enabled := True;
      End;
  End Else
  Begin
    blnUsarFocusedRowIndex := True;  // ORDENOU SEM PESQUISAR
  End;
end;

procedure TfrmConsultaCxGridNova.cxConsultaViewDblClick(Sender: TObject);
begin
  If ((stlListSelecao.Count = 0) Or ((stlListSelecao.Count = 1) And (stlListSelecao.CommaText = cdsConsulta.FieldByName(strCodBusca).AsString))) And
     (Not cdsConsulta.IsEmpty) Then
    btnConfirma.Click;
end;

procedure TfrmConsultaCxGridNova.cxConsultaViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  PostMessage(Application.Handle, WM_MESSAGENAVEGANDOGRIDCONSULTA, 0, 0);

end;

procedure TfrmConsultaCxGridNova.cxConsultaViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Assigned(objFrmPnl) And objFrmPnl.blnTemPan And  objFrmPnl.blnIgnorarTeclas Then
    Exit;

  If Shift = [] Then
    pTeclaAtalhoLimparFiltrosDePesquisa(Key);

  Case Key Of
    VK_HOME,
    VK_END,
    VK_PRIOR,
    VK_NEXT,
    VK_UP,
    VK_DOWN: If Assigned(objFrmPnl) And Assigned(objFrmPnl.prcIniciouNavegacaoGridConsulta) Then
               objFrmPnl.prcIniciouNavegacaoGridConsulta;
  End;

  Case Key Of
    VK_RETURN,
    VK_CONTROL,
    VK_SHIFT,
    VK_LEFT,
    VK_RIGHT,
    VK_PGUP,
    VK_PGDOWN,
    VK_UP,
    VK_DOWN,
    VK_HOME,
    VK_F3,
    VK_END,
    VK_ALT : ;

    VK_TAB:    If Assigned(objFrmPnl) And objFrmPnl.blnTemPan And
                  Assigned(objFrmPnl.fncTeclaTab) Then
                Key := 0;

    Else      Begin
                blnPesquisaEnterSelectAll := False;

                pSetFocus(cxgPesquisa);

                Keybd_Event(VK_RETURN, 0, 0, 0);

                If (Not blnUsouTab) And
                   ((Not Assigned(cxgPesquisa.FocusedRow)) Or
                    (Not objConfConsulta.fColunaAutoSelecao(objConfConsulta.fNomeRowToNomeCampo(cxgPesquisa.FocusedRow.Name)))) Then
                  Keybd_Event(VK_END, 0, 0, 0);

                Keybd_Event(Key, 0, 0, 0);

                blnUsouTab := False;
              End;
  End;

end;

procedure TfrmConsultaCxGridNova.cxConsultaViewKeyPress(Sender: TObject; var Key: Char);
begin
  Case Key Of
    #13:    If (Not cdsConsulta.IsEmpty) Then
              btnConfirma.Click;
  End;
end;

procedure TfrmConsultaCxGridNova.cxConsultaViewKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_HOME,
    VK_END,
    VK_PRIOR,
    VK_NEXT,
    VK_UP,
    VK_DOWN:
      If fCheckParent(activeControl, cxConsulta) Then
      Begin
        PostMessage(Application.Handle, WM_MESSAGENAVEGANDOGRIDCONSULTA, 0, 0);
        If Assigned(objFrmPnl) And Assigned(objFrmPnl.prcParouNavegacaoGridConsulta) Then
          If Not blnFinalizandoTela Then
          begin
            objFrmPnl.prcParouNavegacaoGridConsulta;
            tmrAtualizarDados.Enabled := True;
          End;

      End;
  End;
end;

procedure TfrmConsultaCxGridNova.cxConsultaViewMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  AGridSite: TcxGridSite;
  AGridView: TcxGridTableView;
  AHitTest: TcxCustomGridHitTest;
begin
  If Not Assigned(objConsulta) Then
    Exit;

  AGridSite := Sender as TcxGridSite;
  Try
    AGridView := AGridSite.GridView as TcxGridTableView;
    AHitTest := AGridView.GetHitTest(X, Y);

    if (AHitTest is TcxGridRecordCellHitTest) and
       (objConsulta.LocateFieldLink(TcxGridDbColumn((AHitTest as TcxGridRecordCellHitTest).Item).DataBinding.FieldName)) Then
       AGridSite.Cursor := crHandPoint
    else
       AGridSite.Cursor := crDefault;
  Except
    AGridSite.Cursor := crDefault;
  End;
end;

procedure TfrmConsultaCxGridNova.cxConsultaViewMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  If (Not blnSimples) And (ssCtrl In Shift) Then
  Begin
    pAddListaQuery;
    cxConsultaView.DataController.Refresh;
  End;

end;

procedure TfrmConsultaCxGridNova.cxConsultaViewSelectionChanged(
  Sender: TcxCustomGridTableView);
begin
  pAtualizaDados;
end;

procedure TfrmConsultaCxGridNova.cxConsultaViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  var styStyleCfg: TcxStyle;
begin
  If Assigned(objConsulta) Then
  Begin

    styStyleCfg := objConsulta.fGetCellStyle(cxConsultaView, ARecord, AItem, cdsConsulta);

    If Assigned(styStyleCfg) Then
    Begin
       AStyle := cxStyleAuxiliar;

       AStyle.TextColor := styStyleCfg.TextColor;

       If fsBold In styStyleCfg.Font.Style Then
         AStyle.Font.Style := AStyle.Font.Style + [fsBold];

       If fsItalic In styStyleCfg.Font.Style Then
         AStyle.Font.Style := AStyle.Font.Style + [fsItalic];

       If fsUnderline In styStyleCfg.Font.Style Then
         AStyle.Font.Style := AStyle.Font.Style + [fsUnderline];
    End;

  End;
end;

procedure TfrmConsultaCxGridNova.pAtualizaPesquisa;
  Var
    strFiltro     : String;
    strNewFilter  : String;
Begin
  strFiltro := objConfConsulta.fSQLFiltro(FSQLHaving);

  if Assigned(objConsulta) Then
  Begin
    If Assigned(objConsulta.arrFilSN_ ) Then
    Begin
      strNewFilter := StringReplace(strFiltro, objConsulta.arrFilSN_[0].strAlias_, objConsulta.arrFilSN_[0].strCamFil, [rfReplaceAll]);
      strNewFilter := StringReplace(strNewFilter,' = "N√O"'  , ' <=0  ', [rfReplaceAll]);
      strNewFilter := StringReplace(strNewFilter,' = "SIM"'  , ' > 0  ', [rfReplaceAll]);

      strFiltro := strNewFilter;
    end;
  End;

  If objConfConsulta.blnTemAoMenosUmFiltroPreenchido Or (Not blnSomenteComFiltro) Then
  Begin
    pAtualiza(tcpOrdemFiltro, strFiltro);

    If Assigned(objFrmPnl) And Assigned(objFrmPnl.prcParouNavegacaoGridConsulta) Then
      If Not blnFinalizandoTela Then
      Begin
        objFrmPnl.prcParouNavegacaoGridConsulta;
        tmrAtualizarDados.Enabled := True;
      End;

    pFiltrarRegistros;
  End;
End;

procedure TfrmConsultaCxGridNova.pFiltrarRegistros;
  Var
    strFiltroCds: String;
Begin
  Try
    cxConsultaView.DataController.DataSet.DisableControls;

    strFiltroCds := objConfConsulta.fFiltroDataSet;

    if (not fEmptyStr(strFiltroAplicado)) then
    begin
      if fEmptyStr(strFiltroCds) then
        strFiltroCds := strFiltroAplicado
      else
        strFiltroCds := strFiltroCds + ' AND ' + strFiltroAplicado;
    end;

    cxConsultaView.DataController.DataSet.Filtered := False;

    If Not fEmptyStr(strFiltroCds) Then
    Begin
      If cxConsultaView.DataController.DataSet.Filter <> strFiltroCds Then
        cxConsultaView.DataController.DataSet.Filter := strFiltroCds;

      cdsConsulta.PacketRecords := 500;

      While (intLasPac <> 0) Do
      Begin
        intLasPac := fGetNextPacket;
        If blnAbortar Then
          Break;
      End;

      cdsConsulta.PacketRecords := INTPACREC;

      If Assigned(pAfterAtualiza) Then
        pExecpAfterAtualiza(False);

      cxConsultaView.DataController.DataSet.Filtered := True;
    End
    Else If Assigned(pAfterAtualiza) Then
      pExecpAfterAtualiza(False);

  Finally
    cxConsultaView.DataController.DataSet.EnableControls;
    cxConsultaView.DataController.GoToFirst;
  End;

End;

procedure TfrmConsultaCxGridNova.pHighlightGrid(ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo);
  var
    intFiltro: Integer;
    strCampo, strValor: String;
    stlValores: TStringList;

  function IIF(blnCondicao: Boolean; corTrue, corFalse: TColor): TColor;
  Begin
    if blnCondicao Then
      Result := corTrue
    Else
      Result := corFalse;
  End;

  function fMesmoFullText(strCampo1, strCampo2: String): Boolean;
  Begin
    if Assigned(objConfConsulta) And Assigned(objConfConsulta.cdsFullText) Then
    Begin
      With objConfConsulta.cdsFullText Do
      Begin
        Result := False;

        First;
        While Not Eof Do
        Begin
          If (FieldByName('SELECI').AsString = 'S') And
             (Pos(strCampo1, FieldByName('NOMCAM').AsString) > 0) And
             (Pos(strCampo2, FieldByName('NOMCAM').AsString) > 0) Then
          Begin
            Result := True;
            Break;
          End;

          Next;
        End;
      End;
    End
    Else
      Result := False;
  End;

begin
  strCampo := TcxGridItemDBDataBinding(AViewInfo.Item.DataBinding).FieldName;
  stlValores := TStringList.Create;
  Try
    For intFiltro := 1 To cxgPesquisa.Rows.Count - 1 Do
    Begin
      If SameText(objConfConsulta.fNomeRowToNomeCampo(cxgPesquisa.Rows[intFiltro].Name), strCampo) Or
        fMesmoFullText(objConfConsulta.fNomeRowToNomeCampo(cxgPesquisa.Rows[intFiltro].Name), strCampo)       Then
      Begin
        If Assigned(objConfConsulta) And
           objConfConsulta.fConsultaContida(objConfConsulta.fNomeRowToNomeCampo(cxgPesquisa.Rows[intFiltro].Name)) And
           (Pos(',', TcxEditorRow(cxgPesquisa.Rows[intFiltro]).Properties.DisplayTexts[0]) = 0) Then
          stlValores.CommaText := ReplaceStr(TcxEditorRow(cxgPesquisa.Rows[intFiltro]).Properties.DisplayTexts[0], ' ', ',')
        Else If (Not objConfConsulta.fConsultaContida(objConfConsulta.fNomeRowToNomeCampo(cxgPesquisa.Rows[intFiltro].Name))) And
                (Pos('%', TcxEditorRow(cxgPesquisa.Rows[intFiltro]).Properties.DisplayTexts[0]) > 0) Then
          stlValores.CommaText := ReplaceStr(TcxEditorRow(cxgPesquisa.Rows[intFiltro]).Properties.DisplayTexts[0], '%', ',')
        Else If (Not objConfConsulta.fConsultaContida(objConfConsulta.fNomeRowToNomeCampo(cxgPesquisa.Rows[intFiltro].Name))) And
                (Pos('*', TcxEditorRow(cxgPesquisa.Rows[intFiltro]).Properties.DisplayTexts[0]) > 0) Then
          stlValores.CommaText := ReplaceStr(TcxEditorRow(cxgPesquisa.Rows[intFiltro]).Properties.DisplayTexts[0], '*', ',')
        Else
          stlValores.Text := TcxEditorRow(cxgPesquisa.Rows[intFiltro]).Properties.DisplayTexts[0];

        For strValor in stlValores Do
          HighlightCellText(ACanvas.Canvas,
                            AViewInfo.Bounds,
                            AViewInfo.Text,
                            strValor,
                            TcxGridItemDBDataBinding(AViewInfo.Item.DataBinding).Field.Alignment,
                            IIF(AViewInfo.Selected, $0B86B8, clYellow),
                            IIF(AViewInfo.Selected, clWhite, clBlack));
        If strCampo = 'ITEAPLICA' Then
        Begin
          If Assigned(objFrmPnl) Then
            objFrmPnl.strFiltroEspecifico:= strValor;
        End;
      End;
    End;
  Finally
    FreeAndNil(stlValores);
  End;
end;

procedure TfrmConsultaCxGridNova.pSetarQueryTraceViewerEvents;
Var
  I: Integer;
begin
  If Assigned(untFuncoesGen.VS_objTraceViewer) Then
    For I := 0 To Self.ComponentCount -1 Do
      If Self.Components[I] Is TUniQuery Then
        untFuncoesGen.VS_objTraceViewer.SetQueryEvents(TUniQuery(Self.Components[I]));
end;


procedure TfrmConsultaCxGridNova.cxgComVenDBLayoutViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  //pMostraDetalhesBanner(banCombo);
end;

procedure TfrmConsultaCxGridNova.cxgEstrutDBLayoutViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  //pMostraDetalhesBanner(banEstrutura);
end;

procedure TfrmConsultaCxGridNova.cxgPesquisaEdited(Sender: TObject;
  ARowProperties: TcxCustomEditorRowProperties);
begin
  If Not blnReturn Then
    Exit;

  If (Not Assigned(objConfConsulta)) Or objConfConsulta.recConfigur.blnComKey Then
  Begin
    pAtualizaPesquisa;
    Exit;
  End;

  //Partial key
  tmrAtualizaParcialKey.Enabled := False;
  tmrAtualizaParcialKey.Enabled := True;
end;

procedure TfrmConsultaCxGridNova.cxgPesquisaEnter(Sender: TObject);
begin
  if blnPesquisaEnterSelectAll then
  begin
    cxgPesquisa.ShowEdit;
    if ActiveControl is TcxCustomInnerTextEdit then
      TcxCustomInnerTextEdit(ActiveControl).SelectAll;
  end;
  blnPesquisaEnterSelectAll := True;
end;

procedure TfrmConsultaCxGridNova.cxgPesquisaExit(Sender: TObject);
begin
  cxgPesquisa.CancelEdit;
end;

procedure TfrmConsultaCxGridNova.cxgPesquisaItemChanged(Sender: TObject;
  AOldRow: TcxCustomRow; AOldCellIndex: Integer);
begin
  If Assigned(cxgPesquisa.FocusedRow) Then
  Begin
    If Assigned(objConsulta) And Not objConsulta.strCampoBuscaPalavraExataPorToken.IsEmpty And
      (objConfConsulta.fNomeRowToNomeCampo(cxgPesquisa.FocusedRow.Name) = objConsulta.strCampoBuscaPalavraExataPorToken) Then
    Begin
      chkConsCo.Enabled := False;
      chkConsCo.Checked := False;
    End
    Else If Assigned(objConsulta) And Not objConsulta.strCampoBuscaPalavraExataPorToken.IsEmpty And
      (objConfConsulta.fNomeRowToNomeCampo(cxgPesquisa.FocusedRow.Name) = objConfConsulta.fAliasCampoFiltro((objConsulta.strCampoBuscaPalavraExataPorToken))) Then
    Begin
      chkConsCo.Enabled := False;
      chkConsCo.Checked := False;
    End
    Else If Assigned(objConsulta) And Not objConsulta.strCampoBuscaComplementarPorToken.IsEmpty And
      (objConfConsulta.fNomeRowToNomeCampo(cxgPesquisa.FocusedRow.Name) = objConsulta.strCampoBuscaComplementarPorToken) Then
    Begin
      chkConsCo.Enabled := False;
      chkConsCo.Checked := False;
    End
    Else If Assigned(objConsulta) And Not objConsulta.strCampoBuscaComplementarPorToken.IsEmpty And
      (objConfConsulta.fNomeRowToNomeCampo(cxgPesquisa.FocusedRow.Name) = objConfConsulta.fAliasCampoFiltro((objConsulta.strCampoBuscaComplementarPorToken))) Then
    Begin
      chkConsCo.Enabled := False;
      chkConsCo.Checked := False;
    End
    Else
    Begin
      chkConsCo.Enabled := True;
      chkConsCo.Checked := objConfConsulta.fConsultaContida(objConfConsulta.fNomeRowToNomeCampo(cxgPesquisa.FocusedRow.Name));
    End;
  End;
end;

Procedure TfrmConsultaCxGridNova.pMudaOrdenacao(strNomCol: String);
Begin
  If cxConsultaView.GetColumnByFieldName(strNomCol) <> Nil then
  Begin
    cxConsultaView.DataController.ClearSorting(True);
    cxConsultaView.GetColumnByFieldName(strNomCol).SortOrder := soAscending;
  End;
End;

procedure TfrmConsultaCxGridNova.cxgPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If Assigned(objFrmPnl) And objFrmPnl.blnTemPan And  objFrmPnl.blnIgnorarTeclas Then
    Exit;

  Case Key Of
    VK_RETURN: If objConfConsulta.recConfigur.blnComKey And
                  cdsConsulta.IsEmpty And
                 (Not objConfConsulta.blnValidateComErro) Then
               Begin
                 Keybd_Event(VK_END, 0, 0, 0);

                 If cxgPesquisa.IsEditing Then
                   Keybd_Event(VK_RETURN, 0, 0, 0);
               End;

    VK_TAB:    If Assigned(objFrmPnl) And objFrmPnl.blnTemPan And
                  Assigned(objFrmPnl.fncTeclaTab) Then
                 Key := 0;
  End;
end;

procedure TfrmConsultaCxGridNova.cxgPesquisaKeyPress(Sender: TObject;
  var Key: Char);
Var blnCampoPermiteAsterisco: Boolean;
begin
  blnCampoPermiteAsterisco := False;
  If Assigned(cxgPesquisa.FocusedRow) Then
    If Assigned(objConsulta) Then
      If SameText(objConfConsulta.fNomeRowToNomeCampo(cxgPesquisa.FocusedRow.Name), 'ITE_DESITE') Then
        blnCampoPermiteAsterisco := True;

  If (Key = '%') or ((Key = '*') And (Not blnCampoPermiteAsterisco)) Then
  Begin
    If objConfConsulta.recConfigur.blnConsCo And chkConsCo.Checked Then
      Key := #0;

    If objConfConsulta.fEhFiltroTravado Then
      Key := #0;
  End;
end;

procedure TfrmConsultaCxGridNova.cxgPesquisaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Shift = [] Then
    pTeclaAtalhoLimparFiltrosDePesquisa(Key);

  Case Key Of
    VK_RETURN: If (Not cxConsulta.Focused) And (Not cdsConsulta.IsEmpty)
                  And (Not blnInformarPeriodoFinal) Then
                 pSetFocus(cxConsulta);

    VK_CONTROL,
    VK_SHIFT,
    VK_LEFT,
    VK_RIGHT,
    VK_PGUP,
    VK_PGDOWN,
    VK_HOME,
    VK_F3,
    VK_END,
    VK_ALT : ;


    VK_UP,
    VK_DOWN:   Begin
                 cxgPesquisa.ShowEdit;
                 if ActiveControl is TcxCustomInnerTextEdit then
                   TcxCustomInnerTextEdit(ActiveControl).SelectAll;
               End;

    VK_TAB:    If Assigned(objFrmPnl) And objFrmPnl.blnTemPan And
                  Assigned(objFrmPnl.fncTeclaTab) Then
                 Key := 0;

    Else       If (Not objConfConsulta.recConfigur.blnComKey) And
                  objConfConsulta.fPesquisaNaDigitacao And
                  cxgPesquisa.IsEditing And
                  (Not (ssShift In Shift)) Then
               Begin
                 Keybd_Event(VK_RETURN, 0, 0, 0);

                 Keybd_Event(VK_END, 0, 0, 0);
                 Keybd_Event(VK_RETURN, 0, 0, 0);
                 Keybd_Event(VK_END, 0, 0, 0);
               End;
  End;

end;

procedure TfrmConsultaCxGridNova.FormActivate(Sender: TObject);
begin
  If Assigned(objPnlBanner) And Not pnlBanner.Visible Then
  Begin
    pnlBanner.Visible := True;
    splBanner.Visible := True;
    objPnlBanner.intAltTel := pnlBanner.Height;
    objPnlBanner.pCriaForm(Self, pnlBanner, cdsConsulta, btnConfirma, cdsSubGrid);
  End;
  If Assigned(objPnlPreFiltro) And Not pnlPreFiltro.Visible Then
  Begin
    pnlPreFiltro.Visible := True;
    objPnlPreFiltro.pCriaForm(Self, pnlPreFiltro, cdsConsulta, btnConfirma, cdsSubGrid);
    Self.Perform(WM_SIZE, SIZE_MAXIMIZED, 0);
    If pnlPreFiltro.Width + cxgPesquisa.Width > Self.Width Then
      cxgPesquisa.Width := cxgPesquisa.Width - pnlPreFiltro.Width;
  End;

  If FPrimeiraVez And Assigned(Sender) Then
  Begin
    If Assigned(untFuncoesGen.VS_objTraceViewer) And untFuncoesGen.VS_objTraceViewer.Visible Then
    Begin
      untFuncoesGen.VS_objTraceViewer.Show;
      SetForegroundWindow(Self.Handle);
    End;
  End;

  FPrimeiraVez := False;
end;

procedure TfrmConsultaCxGridNova.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If blnAtualizaConfig Then
  Begin
    blnFinalizandoTela := True;

    If cdsConsulta.Active  Then
    Begin
      objPesquisa.pSalvaFiltros(cxgPesquisa, cdsConsulta.RecNo);

      If blnDirAce Or (Not objConfConsulta.blnLeuConf) Then
        pSalvaConfiguracoes(fCfgSis('SAVGRD', varBoolean));
    End;
  End;
end;

procedure TfrmConsultaCxGridNova.FormCreate(Sender: TObject);
begin
  strAutoIncremSimilarSelecionado := EmptyStr;
  strCodigoSimiliarSelecionado := EmptyStr;
  arrSelec := [];
  FPrimeiraVez := True;

  blnSomenteComFiltro := False;

  blnValidouFiltros := False;
  blnInformarPeriodoFinal := False;

  blnPesquisaEnterSelectAll := True;

  pSetarQueryTraceViewerEvents;

  pSetCxControlsScrollbarModeClassic(Self);

  blnUsarFocusedRowIndex := False;
  blnHighlightGrid := fCfgSis('CORCON', varBoolean);

  intCalSal    := -1;

  intCorFundo := fCfgSis('CORFUN', VarInteger);
  intCorFonte := fCfgSis('CORFON', VarInteger);
  intCorFundoLegenda := fCfgSis('CORFSL', VarInteger);

  If (Not fCfgSis('SAVGRD', varBoolean)) Then
  Begin
    {************************************************************************}
    {* Se n„o salva colunas automaticamente (SAVGRG) o bot„o btnLarCol fica *}
    {* encarregado de salvar tambÈm a posiÁ„o das colunas, alÈm da largura. *}
    {*********************************************************************VA*}
    btnLarCol.Width := 180;
    btnLarCol.Caption :=  'Salva Largura/PosiÁ„o Colunas';
  End;

  intLockTab := -1;
  blnUsouTab := False;
  blnAtualizaConfig := False;

  pAfterAtualiza  := Nil;
  pBeforeAtualiza := Nil;
  objConfConsulta := Nil;

  blnApplyB := True;
  blnReturn := False;
  blnLimpandoFiltro := False;

  blnPrimeiraVez := True;
  blnLeuTudo  := False;
  blnConfirma := False;

  blnAtualizandoParcialKey := False;

  stlSQL      := TStringList.Create;
  stlSQLPadrao := TStringList.Create;
  stlCampos   := TStringList.Create;
  stlOrdem    := TStringList.Create;

  sltCamDta   := TStringList.Create;
  sltCamFlt   := TStringList.Create;

  qryConsulta.Connection    := Database;
  qrySubGrid.Connection    := Database;

  strLasFil    := '';
  strLastOrder := '';

  blnConCon    := True;

  strFiltroAplicado := '';
end;

procedure TfrmConsultaCxGridNova.FormDestroy(Sender: TObject);
begin
  TNewTimer.Del(Self.Name + '.tmrAtualizarDados');
  TNewTimer.Del(Self.Name + '.tmrAtualizaParcialKey');
  FreeAndNil(stlSQL);
  FreeAndNil(stlCampos);
  FreeAndNil(stlSQLPadrao);
  FreeAndNil(stlOrdem);
  FreeAndNil(sltCamDta);
  FreeAndNil(sltCamFlt);

  If Assigned(stlListSelecao) Then
    FreeAndNil(stlListSelecao);
end;

Function TfrmConsultaCxGridNova.fRetChaveLista: String;
Begin
  Result := cdsConsulta.Fieldbyname(strCodBusca).AsString;
End;

function TfrmConsultaCxGridNova.fInLista(strChave: String): Boolean;
begin
  If Assigned(stlListselecao) Then
    Result := (stlListselecao.IndexOf(strChave) > -1)
  Else
    Result := False;
end;

procedure TfrmConsultaCxGridNova.pAddListaQuery(blnInverter : Boolean = True);
  Var
    strAuto  : String;
    intIndex : integer;
    blnAdd   : boolean;
begin {AddListaQuery}
  If cdsConsulta.Active And (Not cdsConsulta.IsEmpty) Then
  Begin
    strAuto  := fRetChaveLista;

    intIndex := stlListSelecao.IndexOf(strAuto);

    If intIndex > -1 then
    Begin
      if blnInverter then
      Begin
        stlListSelecao.Delete(intIndex);
        If Assigned(objFrmPnl) And Assigned(objFrmPnl.FOnAfterListaSelecaoRemove) Then
          objFrmPnl.FOnAfterListaSelecaoRemove(strAuto);
      End;
    End
    Else
    Begin
      blnAdd := True;
      If Assigned(objFrmPnl) And Assigned(objFrmPnl.FOnBeforeListaSelecaoAdd) Then
        objFrmPnl.FOnBeforeListaSelecaoAdd(strAuto, blnAdd);
      If blnAdd Then
        stlListSelecao.Add(strAuto);
    End;
  End;
end; {AddListaQuery}

Function TfrmConsultaCxGridNova.fGetNextPacket: Integer;
Begin
  If (blnLeuTudo) Or (Not blnFetch) or (not cdsConsulta.Active) Then
    Result := 0
  Else
  Begin
    Result := cdsConsulta.GetNextPacket;

    blnLeuTudo := (Result < cdsConsulta.PacketRecords) {And fEmptyStr(strLasFil)};
  End;
End;

procedure TfrmConsultaCxGridNova.pProximoPacote;
Begin
  If cdsConsulta.Active And
     (cdsConsulta.RecNo + INTPACREC > cdsConsulta.RecordCount) And
     (Not blnLeuTudo) Then
  Begin
    intLasPac := fGetNextPacket;

    If intLasPac > 0 Then
    Begin
      pAtualizaDados;

      pExecpAfterAtualiza(True);
    End;
  End;
End;

procedure TfrmConsultaCxGridNova.pCtrlEnd(blnProMsg: Boolean);
Begin

  If blnFetch Then
  Begin

    If Not cdsConsulta.Active Then
      Exit;

    blnAbortar := False;
    btnCancel.Visible := True;
    btnCancel.Refresh;
  //  prbProgresso.Visible := True;
  //  prbProgresso.Position := cdsConsulta.RecordCount;

    If blnProMsg Then
      Application.ProcessMessages;

    cdsConsulta.PacketRecords := 500;
    While (intLasPac <> 0) Do
    Begin
      intLasPac := fGetNextPacket;
  //    prbProgresso.StepBy(intLasPac);

      If blnProMsg Then
        Application.ProcessMessages;

      If blnAbortar Then
        Break;
    End;
    btnCancel.Visible := False;
  //  prbProgresso.Visible := False;
    cdsConsulta.PacketRecords := INTPACREC;

    If blnProMsg Then
    Begin
      cdsConsulta.Last;
      pExecpAfterAtualiza(True);
      Abort;
    End
    Else
      pExecpAfterAtualiza(True);

  End;
End;

procedure TfrmConsultaCxGridNova.pExecpAfterAtualiza(
  blnEnableDisableGrid: Boolean);
 //Var timeAux: TTime;
begin
  If (Not cdsConsulta.IsEmpty) And Assigned(pAfterAtualiza) Then
  Begin
    If blnEnableDisableGrid Then
       cdsConsulta.DisableControls;

    pAfterAtualiza(cdsConsulta);

    If blnEnableDisableGrid Then
       cdsConsulta.EnableControls;
  End;
end;

procedure TfrmConsultaCxGridNova.pExibirCheckConsultaContida;
begin
  chkConsCo.Visible := objConfConsulta.blnConsCoCfg;
  pnlPesquisaTop.Visible := chkConsCo.Visible;
end;

procedure TfrmConsultaCxGridNova.pLimparSelecao;
begin
  If Assigned(stlListSelecao) Then
  Begin
    stlListSelecao.Clear;
    cxConsultaView.DataController.Refresh;
  End;
end;

procedure TfrmConsultaCxGridNova.pSetFocusConsulta(blnFirst: Boolean = False);
  Var
    intRecNo: Integer;
Begin
  If Not fCheckParent(ActiveControl, cxConsulta) Then
  Begin
    If Not blnFirst Then
      intRecNo := cdsConsulta.RecNo
    Else
      intRecNo := -1;

    pSetFocus(cxConsulta);

    If (Not cdsConsulta.IsEmpty) Then
    Begin
      If (intRecNo <> -1) And (intRecNo <= cdsConsulta.RecordCount) Then
        cdsConsulta.RecNo := intRecNo
      Else
        cxConsultaView.NavigatorButtons.First.Click;
    End;

  End;
End;

procedure TfrmConsultaCxGridNova.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If blnInformarPeriodoFinal And (Key = VK_TAB) Then
    Exit;

  If Assigned(objFrmPnl) And objFrmPnl.blnTemPan And  objFrmPnl.blnIgnorarTeclas Then
    Exit;

  If Shift = [] Then
    pTeclaAtalhoLimparFiltrosDePesquisa(Key);

  blnInformarPeriodoFinal := False;

  Case Key Of
     VK_RETURN: If Assigned(cxgPesquisa.FocusedRow) And
                   EndsText('_1', cxgPesquisa.FocusedRow.Name) And
                   (Not objConfConsulta.blnValidateComErro) And
                   blnValidouFiltros Then
                Begin
                  blnInformarPeriodoFinal := True;
                  Key := 0;
                  Keybd_Event(VK_TAB, 0, 0, 0);
                  blnReturn := False;
                  blnLimpandoFiltro := False;
                End

                Else If (Not blnLimpandoFiltro) Then
                Begin
                  blnReturn  := True;
                End;

     VK_TAB:    If Assigned(objFrmPnl) And
                   objFrmPnl.blnTemPan And
                   Assigned(objFrmPnl.fncTeclaTab) Then
                Begin
                  Key := 0;
                  pSetFocusConsulta;
                  Exit;
                End;

     Else
     Begin
        blnReturn := False;
        If blnLimpandoFiltro Then
        Begin
          blnLimpandoFiltro := False;
          blnReturn := True
        End;       
     End
  End;

  Case Key Of
    VK_F3    : objConfConsulta.pProximaOrdenacao;
    VK_ESCAPE: Begin
                 btnSair.Click;
                 Key := 0;
               End;
    VK_PGDOWN,
    VK_DOWN:   pProximoPacote;
    VK_END :   If ssCtrl In Shift Then
                 pCtrlEnd(True);

    66     :   If ssAlt In Shift then
               Begin
                 If fCheckParent(ActiveControl, cxgPesquisa) Then
                   pSetFocusConsulta
                 Else
                   pSetFocus(cxgPesquisa);

                 Key := 0;
               End;

    Else       If Assigned(objFrmPnl) And objFrmPnl.blnTemPan Then
                 objFrmPnl.pKeyDown(Key, Shift);

  End;

  If (Not blnSimples) And ((Key In [VK_UP,VK_DOWN]) And (ssShift In Shift)) Then
  Begin
    If fCheckParent((ActiveControl), cxConsulta) Then
      pAddListaQuery;
  End;
end;

function TfrmConsultaCxGridNova.fCheckParent(Sender, Parent: TWinControl): Boolean;
begin
  If Sender = Nil Then
    Result := False
  Else If Sender = Parent Then
    Result := True
  Else If Sender.Parent = nil Then
    Result := False
  Else If Sender.Parent = Parent Then
    Result := True
  Else
    Result := fCheckParent(Sender.Parent, Parent);
end;

procedure TfrmConsultaCxGridNova.FormKeyPress(Sender: TObject; var Key: Char);
begin

  If cxConsultaView.Focused And
     Assigned(cxConsultaView.Controller.FocusedColumn) And
     Assigned(cxConsultaView.Controller.FocusedColumn.DataBinding) And
     Assigned(cdsConsulta.FieldByName(cxConsultaView.Controller.FocusedColumn.DataBinding.FilterFieldName)) And
     (cdsConsulta.FieldByName(cxConsultaView.Controller.FocusedColumn.DataBinding.FilterFieldName).DataType in [ftFloat, ftCurrency, ftBCD] ) And
     ( CharInSet(Key, ['e','E'])) Then
    Key := #0;


end;

procedure TfrmConsultaCxGridNova.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (cxSimilaresView.IsControlFocused) Then
    Exit;

  Case Key Of
    VK_HOME,
    VK_END,
    VK_PGDOWN,
    VK_DOWN,
    VK_PRIOR,
    VK_UP: pAtualizaDados;
  End;

end;

procedure TfrmConsultaCxGridNova.FormPaint(Sender: TObject);
begin
  If blnPrimeiraVez Then
  Begin
    blnPrimeiraVez := False;
  End;
end;

procedure TfrmConsultaCxGridNova.FormResize(Sender: TObject);
begin
  If Assigned(objPnlBanner) And Assigned(objPnlBanner.prcAtualizar) Then
  Begin
    objPnlBanner.intAltTel := pnlBanner.Height;
    objPnlBanner.prcAtualizar;
  End;
  If Assigned(objPnlPreFiltro) And Assigned(objPnlPreFiltro.prcAtualizar) Then
  Begin
    objPnlPreFiltro.intAltTel := pnlPesquisa.Height;
    objPnlPreFiltro.prcAtualizar;
  End;
  PostMessage(Application.Handle, WM_MESSAGECONSULTAFORMRESIZE, 0, 0);
end;

function TfrmConsultaCxGridNova.fGetChaveConsulta: String;
  Var
    intPonto: Integer;
begin
  intPonto := Pos('.', strTitPesq);

  If intPonto > 0 Then
    strTitPesq := LeftStr(strTitPesq, intPonto);

  Result := StringReplace(strTitPesq, ' ', '', [rfReplaceAll]);
end;

procedure TfrmConsultaCxGridNova.pSetaFetch;
Begin
  blnFetch := objConfConsulta.recConfigur.blnFetch_;

  If blnFetch Then
  begin
    cdsConsulta.FetchOnDemand := False;
    cdsConsulta.PacketRecords := INTPACREC;
  End Else
  Begin
    cdsConsulta.FetchOnDemand := True;
    cdsConsulta.PacketRecords := -1;
  End;
End;

procedure TfrmConsultaCxGridNova.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  If Not Assigned(ActiveControl) Then
    Exit;

  If (Msg.CharCode <> VK_TAB) Then
    Exit;

  {Caso ALT pressionado}
  If fKeyIsDown(VK_MENU) Then
    Exit;

  If fKeyIsDown(VK_SHIFT) Then
    Exit;

  If fKeyIsDown(VK_CONTROL) Then
    Exit;

  If cdsConsulta.IsEmpty Then
    Exit;

  If Assigned(objFrmPnl) And objFrmPnl.blnTemPan And Assigned(objFrmPnl.fncTeclaTab) Then
  Begin
    Msg.CharCode := 0;
    Try
      If InterlockedIncrement(intLockTab) = 0 Then
      Begin
        If fCheckParent(ActiveControl, cxConsulta) Then
        Begin
          objFrmPnl.fncTeclaTab(cdsConsulta, pgcRodape, fGetGridRowScreenPosition(cxConsulta, cxConsultaView));
          PostMessage(Handle, WM_MESSAGELIMPARFILTROCONSULTA, 0, 0);
        End;
        PostMessage(Application.Handle, WM_MESSAGEPRESSIONOUTABCONSULTA, 0, 0);
      End;
    Finally
      InterlockedDecrement(intLockTab);
    End;
    blnUsouTab := True;
  End;
end;

procedure TfrmConsultaCxGridNova.pMontaColunasGrid;
Begin
  pSetaNomeColunas;
  pCriaColunasGrid;
  pCarregaCamposData;
  pSetaMascaras;
  If blnSimilares Then
  Begin
    pSetaNomeColunas_Similares;

    pSetaMascaras_Similares;
  End;
End;

procedure TfrmConsultaCxGridNova.FormShow(Sender: TObject);
  Var
    arrSimNaoP : TStringArrayArray;
    intIndex   : Integer;
    intRecCount: Integer;
    arrSubConsulta: TArrRecSubConsulta;

  procedure pLocalizarRegistro(strNomCam, strValCam: String);
  begin
    Repeat
      If fEmptyStr(strNomCam) Then
        Break;

      If cdsConsulta.Locate(strNomCam, strValCam, []) Then
        Break;

      intRecCount := cdsConsulta.RecordCount;

      cdsConsulta.Last;
      pProximoPacote;

      If intRecCount = cdsConsulta.RecordCount Then
        Break;

    Until blnLeuTudo;
  End;

begin

  //S” APARECE O BOT√O DE CADASTRO QUANDO A PESQUISA FOR FORA DO CADASTRO
  if MatchText(strNomForm, ['frmCadFornecedores', 'frmCadClientes', 'frmCadProspectos']) then
    btnCadastro.Visible := False
  else
    btnCadastro.Visible := Assigned(fChamaCadastro) And fChamaCadastro(True);

  Self.BorderIcons := [biSystemMenu,biMaximize];

  lblAtalhoParaLimparPesquisa.Visible := Assigned(objConsulta) And
    objConsulta.recTeclaAtalhoParaLimparPesquisa.blnUsaTeclaAtalho;

  If lblAtalhoParaLimparPesquisa.Visible Then
    lblAtalhoParaLimparPesquisa.Caption :=
      objConsulta.recTeclaAtalhoParaLimparPesquisa.strTexto;

  If Assigned(objConsulta) Then
  Begin
    SetLength(arrSimNaoP, Length(objConsulta.arrSimNao));
    For intIndex := 0 To High(objConsulta.arrSimNao) Do
      arrSimNaoP[intIndex] := objConsulta.arrSimNao[intIndex];
  End;

  try
    blnDirAce := fVerificaAcessoSistema('frmConsultaCxGridNovaConfig');
  except
    blnDirAce := False;
  end;

  btnConCon.Visible := blnDirAce And blnConCon;
  btnLarCol.Visible := blnDirAce And blnConCon;

  If blnDirAce Then
  Begin
    lblMudaOrdem.Font.Color := clGreen;
  End Else
  Begin
    lblMudaOrdem.Font.Color := clRed;
  End;

  blnIniciandoTela   := True;
  blnFinalizandoTela := False;

  If (Not Assigned(objFrmPnl))  Then
      blnSimilares := False
  Else If (Assigned(objConsulta)) And (Assigned(objFrmPnl)) And (Not objFrmPnl.blnTemPan) Then
    blnSimilares := False
  Else If Assigned(objConsulta) Then
    blnSimilares := objConsulta.blnSimilares
  Else
    blnSimilares := False;

  spltGrid.Visible := blnSimilares;
  cxSimilares.Visible := blnSimilares;
  If blnSimilares Then
    pnlSimilares.Height := 143
  Else
    pnlSimilares.Visible := False;

  pAtualiza(tpcVazio);

  If Not (Assigned(objFrmPnl) And objFrmPnl.blnTemPan) Then
    pgcRodape.Visible := False;

  If Assigned(objConsulta) Then
  begin
    arrSubConsulta := objConsulta.arrSubCon ;
  end
  Else
  begin
    arrSubConsulta := Nil;
  end;

  objConfConsulta := TConfiguraConsulta.Create(Self,
                                               fGetChaveConsulta,
                                               stlSQL.Text,
                                               stlOrdem,
                                               cdsConsulta,
                                               cxgPesquisa,
                                               cxConsultaView,
                                               cxStyleEven,
                                               splSepPes,
                                               cxConsulta,
                                               arrSimNaoP,
                                               pAtualizaPesquisa,
                                               arrSubConsulta,
                                               objConsulta,
                                               stlCampos,
                                               pnlValidacaoPeriodo);
  cxConsultaView.BeginUpdate;
  Try
    pMontaColunasGrid;
   Finally
    cxConsultaView.EndUpdate;
  End;

  pSetaFetch;

  pExibirCheckConsultaContida;

  objConfConsulta.pMontaPesquisa;

  lblObrigatorios.Visible := objConfConsulta.blnTemCampoObrigatorio;

  If Assigned(objConsulta) Then
  Begin
    objPesquisa.pCarregaFiltros(objConsulta.arrFiltro, fGetChaveConsulta, cxgPesquisa, True);
    objPesquisa.fCarregaFiltrosParametros(objConsulta.arrFiltro, cxgPesquisa);
  End Else
  Begin
    objPesquisa.pCarregaFiltros(Nil, fGetChaveConsulta, cxgPesquisa, False);
  End;
  stlListSelecao := TStringList.Create;

  pCarregarListaSelecao;

  If Assigned(objFrmPnl) And objFrmPnl.blnTemPan Then
  Begin
    objFrmPnl.FobjConfConsulta := objConfConsulta;
    objFrmPnl.pCriaForm(Self, pgcRodape, cdsConsulta, btnConfirma, cdsSubGrid);
    objFrmPnl.stlListaSelecao := stlListSelecao;
    objFrmPnl.FAplicaFiltro := pAplicaFiltro;

    if Assigned(objFrmPnl.prcValidaTemFiltro) then
      objFrmPnl.prcValidaTemFiltro;

    If Assigned(objFrmPnl.fncTeclaTab) Then
      lblTab.Visible := True;

    objFrmPnl.blnExpand := objConfConsulta.recConfigur.blnExpand;

    If assigned(objFrmPnl.prcAtualizaAplicacao) Then
      objFrmPnl.prcAtualizaAplicacao;

    pSetaDisplayGeneric;
    pSetaDisplaySimilares;
  End;

  strLastOrder := fRetOrderBy;

  If objConfConsulta.recConfigur.blnFilBra And objConfConsulta.recConfigur.blnComKey Then
    If (Not Assigned(objConsulta)) Or (Length(objConsulta.arrFiltro) = 0) Then
      objPesquisa.pLimparFiltros(cxgPesquisa);

  If (Not cdsConsulta.Active) Or cdsConsulta.IsEmpty And
     ((Not fEmptyStr(objConfConsulta.fSQLFiltro(FSQLHaving))) Or (Not objConfConsulta.recConfigur.blnComKey)) Then
  Begin
    If objConfConsulta.recConfigur.blnFilObr Then
    Begin
      If (Not fEmptyStr(objConfConsulta.fSQLFiltro(FSQLHaving))) Then
        pAtualiza(tcpPrimeira, objConfConsulta.fSQLFiltro(FSQLHaving));
    End
    Else
      pAtualiza(tcpPrimeira, objConfConsulta.fSQLFiltro(FSQLHaving));
  End;

  cxConsultaView.OptionsView.GroupByBox           := False;
  cxConsultaView.FilterBox.Visible                := fvNever;
  cxConsultaView.OptionsCustomize.ColumnFiltering := False;

  If Not objConfConsulta.blnRestaurouColunas Then
  Begin
    objConfConsulta.pRestauraColunas(cxConsultaView);
    If blnSimilares Then
      pAjustaColunasSimilares;
  End;

  If (Not objConfConsulta.blnLoadView) And (Not cdsConsulta.IsEmpty) Then
    cxConsultaView.ApplyBestFit;

  blnMultiSelecao   := Not blnSimples;
  btnLimpar.Visible := blnMultiSelecao;

  lblMulSel.Visible := Not blnSimples;

  Try
    If (objPesquisa.intRecNo > 0) Then
    Begin
      If (objPesquisa.intRecNo > INTPACREC) And (cdsConsulta.RecordCount < objPesquisa.intRecNo) Then
      Begin
        cdsConsulta.PacketRecords := objPesquisa.intRecNo + INTPACREC;

        cdsConsulta.GetNextPacket;

        cdsConsulta.PacketRecords := INTPACREC;
      End;

      If (cdsConsulta.RecordCount >= objPesquisa.intRecNo) Then
        cdsConsulta.RecNo := objPesquisa.intRecNo;
    End;

  Except

  End;

  objConfConsulta.pFocoNaPesquisa;

  If Not objConfConsulta.recConfigur.blnComKey Then
    pSetFocus(cxConsulta);

  If Assigned(objConsulta) And (Length(objConsulta.arrFiltro) > 0) And (Not cdsConsulta.IsEmpty) Then
  Begin
    pLocalizarRegistro(objConsulta.recLocalizar.strNomCam, objConsulta.recLocalizar.strValCam);
    pSetFocus(cxConsulta);
  End;

  If (cxConsultaView.SortedItemCount = 0) And (stlOrdem.Count > 0) Then
    pMudaOrdenacao(stlOrdem[0]);

  blnIniciandoTela := False;

  pAtualizaDados;

  try
    btnConfigSQL.Visible := Assigned(objConsulta) And Assigned(objConsulta.funcConfiguraConsulta) And
      fVerificaAcessoSistema('frmConsultaCxGridNovaConfigSQL');
  except
     btnConfigSQL.Visible := False;
  end;

 { if blnConIte Then
    pAtualiza(tcpPrimeira);      }
end;

Procedure TfrmConsultaCxGridNova.pAtualizaDados;
Begin
  Try
    If blnFinalizandoTela Then
      Exit;

    If Assigned(objFrmPnl) And Assigned(objFrmPnl.prcParouNavegacaoGridConsulta) Then
    Begin
      objFrmPnl.prcParouNavegacaoGridConsulta;
      tmrAtualizarDados.Enabled := True;
    End;

    {**********************************************************************}
    {* CONTORNA BUG DO PAGECONTROL QUE N√O RESPONDE AO VISIBLE FALSE/TRUE *}
    {********************************************************************VA}
    If (pgcRodape.PageCount > 0) And (pgcRodape.TabIndex >= 0) Then
    Begin
      pgcRodape.Pages[pgcRodape.TabIndex].UpdateControlState;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmConsultaCxGridNova.pAtualizaDados');
    End;
  End;
End;

procedure TfrmConsultaCxGridNova.pProcessaSimilares;
begin
  If Not blnSimilares Then
    Exit;
  If cxSimilares.Focused Then
    Exit;

  If (cxConsultaView.DataController.DataSet.FieldByName('ITE_CODITE').AsString <> '') And
     (cxConsultaView.DataController.DataSet.FieldByName('ITE_CODSIM').AsString <> '') Then
  Begin
    cdsSubGrid.Close;
    qrySubGrid.ParamByName('CODITE').AsString := cxConsultaView.DataController.DataSet.FieldByName('ITE_CODITE').AsString;
    qrySubGrid.ParamByName('CODSIM').AsString := cxConsultaView.DataController.DataSet.FieldByName('ITE_CODSIM').AsString;
    qrySubGrid.ParamByName('CONSULTA').AsBoolean := True;
    cdsSubGrid.Open;
    pAjustaColunasSimilares;

  End
  Else
  Begin
    If cdsSubGrid.IsEmpty Then
      Exit;
    cdsSubGrid.Close;
    qrySubGrid.ParamByName('CODITE').AsString := cxConsultaView.DataController.DataSet.FieldByName('ITE_CODITE').AsString;
    qrySubGrid.ParamByName('CODSIM').AsString := cxConsultaView.DataController.DataSet.FieldByName('ITE_CODSIM').AsString;
    qrySubGrid.ParamByName('CONSULTA').AsBoolean := False;
    cdsSubGrid.Open;
    pAjustaColunasSimilares;
  End;

End;

Function TfrmConsultaCxGridNova.fRetHaving: String;
Begin
  Result := ' ';
  If Not FSQLHaving.IsEmpty Then
    Result := ' HAVING ' + FSQLHaving;
End;

Function TfrmConsultaCxGridNova.fRetOrderBy: String;
  Var
    intIndice: Integer;
    blnTemOrd: Boolean;
    strCampo: String;
Begin
  Result := '';
  blnTemOrd := False;

  With cxConsultaView Do
  Begin

    If SortedItemCount > 0 Then
    Begin

      Result := ' ORDER BY ';

      objConfConsulta.cdsColunas.IndexFieldNames := 'DESCAM';

      For intIndice := 0 To SortedItemCount - 1 Do
        If SortedItems[intIndice].SortOrder <> soNone Then
        Begin

          strCampo := TcxGridItemDBDataBinding(SortedItems[intIndice].DataBinding).FieldName;

          If Not fEmptyStr(SortedItems[intIndice].Caption) Then
          Begin
            blnTemOrd := True;
            Result := Result + ' ' + strCampo;

            If SortedItems[intIndice].SortOrder = soDescending Then
              Result := Result + ' DESC ';

            If intIndice <> SortedItemCount - 1 Then
              Result := Result + ',';
          End;

        End;

      If Assigned(cdsConsulta.FindField('AUTOINCREM')) Then
      Begin
        If blnTemOrd Then
          Result := Result + ', ';

        Result := Result + ' AUTOINCREM';
      End;
    End;

  End;
End;

procedure TfrmConsultaCxGridNova.LimparSeleo1Click(Sender: TObject);
begin
  pLimparSelecao;
end;


procedure TfrmConsultaCxGridNova.pSetaNomeColunas_similares;
  Var
    intIndice: Integer;
Begin

  For intIndice := 0 To cdsSubGrid.FieldCount - 1 Do
  Begin

    If Assigned(objConsulta) And objConsulta.blnSQLConsultaConfigurado Then
    Begin

      If Assigned(objConsulta.dtsColunasUsuario) Then
      Begin

        If objConsulta.dtsColunasUsuario.Locate('CAM_ALIAS_', cdsSubGrid.Fields[intIndice].FieldName, []) Then
        Begin
          cdsSubGrid.Fields[intIndice].DisplayLabel := objConsulta.dtsColunasUsuario.FieldByName('CAM_TITULO').AsString;

          cdsSubGrid.Fields[intIndice].Visible      := objConsulta.dtsColunasUsuario.FieldByName('CAM_EXIBIR').AsString = 'S';

          If cdsSubGrid.Fields[intIndice].Visible And
             (Not objConsulta.dtsColunasUsuario.FieldByName('CAM_CALMSK').AsString.IsEmpty) And
             Assigned(objConsulta.stlCamposComplementares) Then
            objConsulta.stlCamposComplementares.Add(objConsulta.dtsColunasUsuario.FieldByName('CAM_CALMSK').AsString);

          If (Not cdsSubGrid.Fields[intIndice].Visible) And
             (Not objConsulta.dtsColunasUsuario.FieldByName('CAM_ESTILO').AsString.IsEmpty) And
             Assigned(objConsulta.stlCamposComplementares) Then
            objConsulta.stlCamposComplementares.Add(cdsSubGrid.Fields[intIndice].FieldName);

        End Else
        Begin
          If intIndice < stlCampos.Count Then
            cdsSubGrid.Fields[intIndice].DisplayLabel := stlCampos[intIndice];

          cdsSubGrid.Fields[intIndice].Visible := fSetVisibleNomeColuna(intIndice);
        End;

      End Else
      Begin
        If intIndice < stlCampos.Count Then
          cdsSubGrid.Fields[intIndice].DisplayLabel := stlCampos[intIndice];

        cdsSubGrid.Fields[intIndice].Visible := fSetVisibleNomeColuna(intIndice);
      End;

    End Else
    Begin
      If (intIndice <= stlCampos.Count - 1) Then
      Begin
        cdsSubGrid.Fields[intIndice].DisplayLabel := stlCampos[intIndice];

        If Assigned(objConsulta) Then
          cdsSubGrid.Fields[intIndice].Visible := fSetVisibleNomeColuna(intIndice);

      End Else
      Begin
        cdsSubGrid.Fields[intIndice].Visible := False;
      End;
    End;

  End;

End;


procedure TfrmConsultaCxGridNova.pSetaNomeColunas;
  Var
    intIndice: Integer;
Begin

  For intIndice := 0 To cdsConsulta.FieldCount - 1 Do
  Begin

    If Assigned(objConsulta) And objConsulta.blnSQLConsultaConfigurado Then
    Begin

      If Assigned(objConsulta.dtsColunasUsuario) Then
      Begin

        If objConsulta.dtsColunasUsuario.Locate('CAM_ALIAS_', cdsConsulta.Fields[intIndice].FieldName, []) Then
        Begin
          cdsConsulta.Fields[intIndice].DisplayLabel := objConsulta.dtsColunasUsuario.FieldByName('CAM_TITULO').AsString;

          cdsConsulta.Fields[intIndice].Visible      := objConsulta.dtsColunasUsuario.FieldByName('CAM_EXIBIR').AsString = 'S';

          If cdsConsulta.Fields[intIndice].Visible And
             (Not objConsulta.dtsColunasUsuario.FieldByName('CAM_CALMSK').AsString.IsEmpty) And
             Assigned(objConsulta.stlCamposComplementares) Then
            objConsulta.stlCamposComplementares.Add(objConsulta.dtsColunasUsuario.FieldByName('CAM_CALMSK').AsString);

          If (Not cdsConsulta.Fields[intIndice].Visible) And
             (Not objConsulta.dtsColunasUsuario.FieldByName('CAM_ESTILO').AsString.IsEmpty) And
             Assigned(objConsulta.stlCamposComplementares) Then
            objConsulta.stlCamposComplementares.Add(cdsConsulta.Fields[intIndice].FieldName);

        End Else
        Begin
          If intIndice < stlCampos.Count Then
            cdsConsulta.Fields[intIndice].DisplayLabel := stlCampos[intIndice];

          cdsConsulta.Fields[intIndice].Visible := fSetVisibleNomeColuna(intIndice);
        End;

      End Else
      Begin
        If intIndice < stlCampos.Count Then
          cdsConsulta.Fields[intIndice].DisplayLabel := stlCampos[intIndice];

        cdsConsulta.Fields[intIndice].Visible := fSetVisibleNomeColuna(intIndice);
      End;

    End Else
    Begin
      If (intIndice <= stlCampos.Count - 1) Then
      Begin
        cdsConsulta.Fields[intIndice].DisplayLabel := stlCampos[intIndice];

        If Assigned(objConsulta) Then
          cdsConsulta.Fields[intIndice].Visible := fSetVisibleNomeColuna(intIndice);

      End Else
      Begin
        cdsConsulta.Fields[intIndice].Visible := False;
      End;
    End;

  End;

End;

Function TfrmConsultaCxGridNova.fSetVisibleNomeColuna(intIndice: Integer): Boolean;
Begin

  If (cdsConsulta.Fields[intIndice].FieldName = 'PEDPAR') Then
  Begin
    Result := True;
    Exit;
  End;

  If (cdsConsulta.Fields[intIndice].FieldName = 'TIPO_DOC_TMP') Then
  Begin
    Result := True;
    Exit;
  End;

  Result := (Trim(objConfConsulta.strCamposExibir).IsEmpty And (Not SameText(cdsConsulta.Fields[intIndice].FieldName, 'AUTOINCREM'))) Or
            (Pos(cdsConsulta.Fields[intIndice].FieldName, objConfConsulta.strCamposExibir) > 0);

End;

Function TfrmConsultaCxGridNova.fCampoToSubConsulta(strSQL: String;
  blnComAlias, blnParentiza: Boolean): String;
  Var
    intIndice: Integer;
    strLocal: String;
Begin
  Result := strSQL;

  If Assigned(objConsulta) And Assigned(objConsulta.arrSubCon) Then
  With objConsulta Do
  Begin
    For intIndice := Low(arrSubCon) To High(arrSubCon) Do
      With arrSubCon[intIndice] Do
      Begin
        strLocal := strSubSql;

        If blnParentiza Then
          strLocal := Concat('(', strLocal, ')');

        If SameText(strAlias_, 'ITE_APLICA') Then
          Result := StringReplace(Result, STR_APLICACAO_PADRAO, 'SALVA_APLICAO_PADRAO', [rfReplaceAll]);

        If blnComAlias Then
         // Result := StringReplace(Result, strAlias_, strLocal + ' AS ' + strAlias_, [rfReplaceAll])
          Result := TRegEx.Replace(Result, '(?<!\.)\b' + strAlias_ + '\b', strLocal + ' AS ' + strAlias_)

        Else
          // Result := StringReplace(Result, strAlias_, strLocal, [rfReplaceAll]);
          Result := TRegEx.Replace(Result, '(?<!\.)\b' + strAlias_ + '\b', strLocal);

        If SameText(strAlias_, 'ITE_APLICA') Then
          Result := StringReplace(Result, 'SALVA_APLICAO_PADRAO', STR_APLICACAO_PADRAO, [rfReplaceAll]);

      End;
  End

End;

Function TfrmConsultaCxGridNova.fResolveConflito(strSQL: String): String;
  Var
    intIndice: Integer;
Begin
  Result := strSQL;

  If Assigned(objConsulta) Then
  With objConsulta Do
  Begin
    For intIndice := Low(arrConfli) To High(arrConfli) Do
      With arrConfli[intIndice] Do
      begin
        Result := StringReplace(Result, arrConfli[intIndice].strNomCam, arrConfli[intIndice].strCamNov, [rfReplaceAll]);
        If Pos('.' + arrConfli[intIndice].strCamNov, Result)> 0 Then
          Result := StringReplace(Result, '.' + arrConfli[intIndice].strCamNov, '.' + arrConfli[intIndice].strNomCam, [rfReplaceAll]);
      End;
  End

End;

procedure TfrmConsultaCxGridNova.pCarregaCamposData;
  Var
    intIndice: Integer;
Begin
  sltCamDta.Clear;
  sltCamFlt.Clear;

  With cdsConsulta Do
  For intIndice := 0 To Fields.Count - 1 Do
    If Fields[intIndice].DataType In [ftDate, ftDateTime] Then
      sltCamDta.Add(Fields[intIndice].FieldName)

    Else If Fields[intIndice].DataType In [ftFloat] Then
      sltCamFlt.Add(Fields[intIndice].FieldName)
End;

procedure TfrmConsultaCxGridNova.pCarregarListaSelecao;
  Var
    intCnt : Integer;
begin
  For intCnt := Low(arrSelec) To High(arrSelec) Do
    stlListSelecao.Add(arrSelec[intCnt].strCodigo)
end;

Procedure TfrmConsultaCxGridNova.pAtualiza(tpcTipCon: TTipoConsulta; strFilter: String = '');
  Var
    LfrmGravando: TfrmGravando;
Begin

  Try
    FTipCon := tpcTipCon;
    FFilter := strFilter;

    blnValidouFiltros := True;

    If Assigned(objConfConsulta) And (tpcTipCon <> tpcVazio) Then
    Begin
      blnValidouFiltros := objConfConsulta.fValidaFiltros;

      If blnValidouFiltros Then
      Begin
        pnlValidacaoPeriodo.Visible := False;
        pnlValidacaoPeriodo.Caption := '';
      End Else
      Begin
        pnlValidacaoPeriodo.Visible := Not objConfConsulta.strErroValidacao.IsEmpty;
        pnlValidacaoPeriodo.Caption := objConfConsulta.strErroValidacao;
        Exit;
      End;

    End;

    If Assigned(objConfConsulta) And (Not objConfConsulta.recConfigur.blnComKey) Then
    Begin
      fAtualiza(Nil);
    End Else
    Begin
      if (strNomForm = 'frmPrincipal') Or (tpcTipCon = tpcVazio) Then
      begin
        fAtualiza(Nil);
        If Not cdsConsulta.IsEmpty Then
          Application.ProcessMessages;
      end
      else
      begin
        pCriarFormularios(TfrmGravando, LfrmGravando);
        Try
          LfrmGravando.pgbStatus.Visible   := False;
          LfrmGravando.blnDesabilitaMouse  := True;
          LfrmGravando.lblGravando.Caption := 'Aguarde, Carregando dados ...';
          LfrmGravando.fExecutarAcao := fAtualiza;
          LfrmGravando.ShowModal;
        Finally
          pFreeAndNil(LfrmGravando);
        End;
      end;

      pSetFocusConsulta(True);

      pAtualizaDados;

      If (Not (tpcTipCon = tcpOrdemFiltro)) And Assigned(objConfConsulta) And Assigned(pAfterAtualiza) Then
        pAtualizaPesquisa();
    End;

    Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmConsultaCxGridNova.pAtualiza]');
    End;
  End;

  If Assigned(objConfConsulta) then
  Begin
    objConfConsulta.pRestauraColunas(cxConsultaView);
    If blnSimilares Then
      pAjustaColunasSimilares;
  End;
End;

procedure TfrmConsultaCxGridNova.pCriaColunasGrid;
  Var
    intIndex,
    intIndice: Integer;
    cxColuna: TcxGridDBColumn;
    filCampo: TField;
Begin
  For intIndice := 0 To cdsConsulta.FieldCount - 1 Do
  Begin
    cxColuna := TcxGridDBColumn(cxConsultaView.FindItemByName(Concat('cxConsultaView', cdsConsulta.Fields[intIndice].FieldName)));

    If Not Assigned(cxColuna) Then
    Begin

      If cdsConsulta.Fields[intIndice].Visible Then
        cxColuna := TcxGridDBColumn(cxConsultaView.DataController.CreateItemByField(cdsConsulta.Fields[intIndice]))

      Else If (Assigned(objConsulta) And
               Assigned(objConsulta.stlCamposComplementares) And
               objConsulta.stlCamposComplementares.Find(cdsConsulta.Fields[intIndice].FieldName, intIndex)) Or
               SameText(strCodBusca, cdsConsulta.Fields[intIndice].FieldName) Or
               SameText('AUTOINCREM', cdsConsulta.Fields[intIndice].FieldName) Then
      Begin
        cxColuna := TcxGridDBColumn(cxConsultaView.DataController.CreateItemByField(cdsConsulta.Fields[intIndice]));
        cxColuna.Visible := False;
      End;

    End;

    If Assigned(cxColuna) Then
      cxColuna.DataBinding.FieldName := cdsConsulta.Fields[intIndice].FieldName;
  End;

  intIndice := 0;
  While (cxConsultaView.ColumnCount > 0) And (intIndice < cxConsultaView.ColumnCount) Do
  Begin
    filCampo := cdsConsulta.FindField(cxConsultaView.Columns[intIndice].DataBinding.FieldName);

    If ((cxConsultaView.Columns[intIndice].DataBinding.FieldName.IsEmpty) Or
        (Not Assigned(filCampo)) Or
        ((Not filCampo.Visible) And (Not (Assigned(objConsulta) And Assigned(objConsulta.stlCamposComplementares) And
                                         objConsulta.stlCamposComplementares.Find(filCampo.FieldName, intIndex))))) And
        (Not SameText(strCodBusca, cxConsultaView.Columns[intIndice].DataBinding.FieldName)) And
        (Not SameText('AUTOINCREM', cxConsultaView.Columns[intIndice].DataBinding.FieldName)) Then
      cxConsultaView.Columns[intIndice].Free
    Else
      Inc(intIndice);
  End;

  If Assigned(objConsulta) Then
  Begin
    objConsulta.pConfiguraIcones(cxConsultaView, imglImageList);
    objConsulta.pConfiguraColorEdit(cxConsultaView);
    objConsulta.pConfiguraIconeSobEncomenda(cxConsultaView);
  End;

End;

Procedure TfrmConsultaCxGridNova.pSetaParametros(qryConsulta: TUniQuery);
Begin
  If Assigned(qryConsulta.Params.FindParam('VSSTRCODEMP')) Then
    qryConsulta.ParamByName('VSSTRCODEMP').AsString := VS_strCodEmp;

  If Assigned(qryConsulta.Params.FindParam('VSINTCALSAL')) Then
  Begin
    If intCalSal = -1 Then
      intCalSal := fCfgSis('CALSAL', VarInteger);

    qryConsulta.ParamByName('VSINTCALSAL').AsInteger := intCalSal;
  End;

  If Assigned(objFrmPnl) Then
  Begin
    If Assigned(qryConsulta.Params.FindParam('VSINTTABPRE_VEN')) Then
      qryConsulta.ParamByName('VSINTTABPRE_VEN').AsInteger := StrToIntDef(objFrmPnl.recParametros.strTabPre, 0);

    If Assigned(qryConsulta.Params.FindParam('VSSTRCODCLI')) Then
      qryConsulta.ParamByName('VSSTRCODCLI').AsString := objFrmPnl.recParametros.strCodCli;

    If Assigned(qryConsulta.Params.FindParam('VSSTRCODCND')) Then
      qryConsulta.ParamByName('VSSTRCODCND').AsString := objFrmPnl.recParametros.strCodCnd;
  End;

End;

Function TfrmConsultaCxGridNova.fAjustaUnion(strFilter: String; intPosWhere: Integer): String;
  Var
    intContador: Integer;
Begin
  Result := strFilter;

  If Not Assigned(objConsulta) Then
    Exit;

  If Not Assigned(objConsulta.arrTroWhe) Then
    Exit;

  For intContador := Low(objConsulta.arrTroWhe) To High(objConsulta.arrTroWhe) Do
    If intPosWhere = objConsulta.arrTroWhe[intContador].intPosWhere Then
      Result := AnsiReplaceStr(Result, objConsulta.arrTroWhe[intContador].strCampoOriginal, objConsulta.arrTroWhe[intContador].strCampoFinal);
End;

Function TfrmConsultaCxGridNova.fAtualiza(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strSqlAux,
    strOrder: String;
    intPosWhere,
    intIndice: Integer;

    //timeAux: TTime;

begin
  Try
    Result := True;

    strSqlAux := '';
    qrySubGrid.SQL.Clear;

    intPosWhere := 0;

    For intIndice := 0 To stlSQL.Count - 1 Do
    Begin
      strSqlAux := strSqlAux + ' ' + fCampoToSubConsulta(stlSQL[intIndice], True, False);

      If (intIndice = 0) And (blnSimilares) Then
      Begin
        qrySubGrid.SQL.Add(fCampoToSubConsulta(stlSQL[intIndice], True, False));
        qrySubGrid.SQL.Add('  WHERE I.ITE_CODITE <> :CODITE ');
        qrySubGrid.SQL.Add('    AND I.ITE_CODSIM = :CODSIM ');
        qrySubGrid.SQL.Add('    AND :CONSULTA ');
        qrySubGrid.SQL.Add('    AND G.ITE_IMPLIS = "S" ');
        qrySubGrid.ParamByName('CODITE').AsString := '';
        qrySubGrid.ParamByName('CODSIM').AsString := '';
        qrySubGrid.ParamByName('CONSULTA').AsBoolean := False;

        cdsSubGrid.Close;
        cdsSubGrid.Open;
        pSetaClient(cdsSubGrid);

      End;

      If AnsiStartsStr('WHERE', Trim(stlSQL[intIndice])) Then
      Begin
        Inc(intPosWhere);

        Case FTipCon Of
          tpcVazio: strSqlAux := strSqlAux + ' AND FALSE ';
        End;

        If Not fEmptyStr(FFilter) Then
        Begin
          FFilter := fResolveConflito(FFilter);

          strSqlAux := strSqlAux + ' AND ' + fAjustaUnion(FFilter, intPosWhere) + ' ';
        End;

        If Assigned(objPnlPreFiltro) And Not fEmptyStr(objPnlPreFiltro.fGetSQLPreFiltro) Then
          strSqlAux := strSqlAux + ' AND ' + objPnlPreFiltro.fGetSQLPreFiltro + ' ';
      End;
    End;

    if Assigned(objConsulta) then
    begin
      if not Assigned(pBeforeAtualiza) then
      begin
        pBeforeAtualiza := objConsulta.BeforeAtualiza ;
      end;
    end;

    If Assigned(pBeforeAtualiza) Then
      pBeforeAtualiza(strSqlAux, FFilter, Nil);

    strOrder  := fRetOrderBy;

    If (FTipCon = tcpOrdemFiltro) And
       (strLasFil = FFilter) And
       (strLastOrder = strOrder) And
       (Not blnReturn) And
       (Not blnAtualizandoParcialKey) Then
      Exit;

    blnReturn := False;    

    If (FTipCon <> tpcVazio) Then
    Begin
      strLasFil :=  FFilter;
    End;

    strLastOrder := strOrder;

    Screen.Cursor := crSQLWait;

    {***********************************************************************}
    {* QUANDO ESTAVA SENDO ORDENANDO PELA COLUNA QUE VAI TER PROCESSAMENTO *}
    {* pAfterAtualiza, ESTAVA SE PERDENDO E N√O CALCULANDO TODOS OS ITENS  *}
    {63054****************************************************************LE}
    If (Assigned(pAfterAtualiza)) And (Pos(strCodBusca,strSqlAux) > 0)Then
      cdsConsulta.IndexFieldNames := strCodBusca;

    cdsConsulta.DisableControls;

    strSqlAux := '/* ' + fGetChaveConsulta + ' */ ' + strSqlAux + fRetHaving + fRetOrderBy;

    With qryConsulta Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSqlAux);

      If Assigned(objConsulta) Then
        objConsulta.pParametriza(qryConsulta);

      Options.SetFieldsReadOnly := False;
    End;

    pSetaParametros(qryConsulta);

    blnLeuTudo  := False;

    If (Not cdsConsulta.Active)   Or
       (Assigned(pAfterAtualiza)) Or
       (Assigned(objFrmPnl) And objFrmPnl.blnTemPan And Assigned(objFrmPnl.fncTeclaTab)) Then
    Begin
      cdsConsulta.Close;
      pAjustaColunasBetween;
      cdsConsulta.Open;
      pSetaClient(cdsConsulta);
    End
    Else
    Begin
      cdsConsulta.CancelUpdates;
      if blnRefresh And (Not cdsConsulta.IsEmpty) Then
      Begin
        Try
          cdsConsulta.Close;
          cdsConsulta.Open;
        Except
          On e: Exception Do
          Begin
            Try
              cdsConsulta.Close;
              cdsConsulta.Open;
            Except
              On e: Exception Do
              Begin
                pMensagensErro(e.Message, 'TfrmConsultaCxGridNova.fAtualiza');
                pGravarErro(True, e.message + ' TfrmConsultaCxGridNova.fAtualiza', fRetornaStack);
              End;
            End;
          End;
        End;
      End Else
      Begin
        cdsConsulta.Close;
        cdsConsulta.Open;
      End;
    End;

    blnUsarFocusedRowIndex := False;

    pTrimAppMemorySize;

    If Assigned(cdsConsulta.FindField('AUTOINCREM')) Then
      cdsConsulta.FieldByName('AUTOINCREM').Visible := False;

    If FTipCon <> tpcVazio Then
    Begin
      pSetaNomeColunas;
      If blnSimilares Then
        pAjustaColunasSimilares;
    End;

    pSetaMascaras;

    pAlinhaCamposNumericos(cdsConsulta);
    pAlinhaCamposNumericos(cdsSubGrid);

    intLasPac  := -1;
    If (FTipCon <> tpcVazio) Then
      intLasPac := fGetNextPacket;

    pExecpAfterAtualiza;

    cdsConsulta.IndexFieldNames := '';
    cdsConsulta.EnableControls;

    If blnApplyB And Assigned(objConfConsulta) And (Not objConfConsulta.blnLeuConf) And (Not cdsConsulta.IsEmpty) Then
    Begin
      blnApplyB := False;
      cxConsultaView.ApplyBestFit;
    End;

    Screen.Cursor := crDefault;

    blnAtualizaConfig := True;

  Except
    On E: Exception Do
    Begin
      blnAtualizaConfig := False;
      Close;

      Raise;
    End;
  End;

end;

procedure TfrmConsultaCxGridNova.pSetaArrMascaras(arrCampos: TarrCampos; prcDisTxt: TprcDisplayText);
  Var
    intIndice: Integer;
Begin
  For intIndice := Low(arrCampos) To High(arrCampos) Do
  Begin
    If cxConsultaView.GetColumnByFieldName(arrCampos[intIndice]) <> Nil Then
      cxConsultaView.GetColumnByFieldName(arrCampos[intIndice]).OnGetDisplayText := prcDisTxt;
  End;
End;

procedure TfrmConsultaCxGridNova.pSetaArrMascarasSimilares(arrCampos: TarrCampos; prcDisTxt: TprcDisplayText);
  Var
    intIndice: Integer;
Begin
  For intIndice := Low(arrCampos) To High(arrCampos) Do
  Begin
    If cxSimilaresView.GetColumnByFieldName(arrCampos[intIndice]) <> Nil Then
      cxSimilaresView.GetColumnByFieldName(arrCampos[intIndice]).OnGetDisplayText := prcDisTxt;
  End;
End;

procedure TfrmConsultaCxGridNova.pSetaArrMascarasComposta(arrCampos: TarrCamposDuplo);
  Var
    intIndice: Integer;
Begin
  For intIndice := Low(arrCampos) To High(arrCampos) Do
  Begin
    If (cxConsultaView.GetColumnByFieldName(arrCampos[intIndice].strCamMsk) <> Nil) And
       (cxConsultaView.GetColumnByFieldName(arrCampos[intIndice].strCamCalc) <> Nil) Then
    Begin
      cxConsultaView.GetColumnByFieldName(arrCampos[intIndice].strCamMsk).OnGetDisplayText := arrCampos[intIndice].prcDisTex;

      cxConsultaView.GetColumnByFieldName(arrCampos[intIndice].strCamMsk).Tag :=
         cxConsultaView.GetColumnByFieldName(arrCampos[intIndice].strCamCalc).Index;
    End;
  End;
End;

procedure TfrmConsultaCxGridNova.pSetaMascaras;
  Var
    intIndice: Integer;
Begin
  If Assigned(objConsulta) Then
  With objConsulta Do
  Begin

    For intIndice := Low(arrIdxCam) To High(arrIdxCam) Do
      If cxConsultaView.GetColumnByFieldName(arrIdxCam[intIndice].strCodCam) <> Nil Then
        arrIdxCam[intIndice].intIndice := cxConsultaView.GetColumnByFieldName(arrIdxCam[intIndice].strCodCam).Index;

    For intIndice := Low(arrRecMas) To High(arrRecMas) Do
      With arrRecMas[intIndice] Do
      Begin
        If cxConsultaView.GetColumnByFieldName(strCodCam) <> Nil Then
          cxConsultaView.GetColumnByFieldName(strCodCam).OnGetDisplayText := prcDisTex;
      End;

    pSetaArrMascarasComposta(arrMskDup);

    pSetaArrMascaras(arrMskCep, pDisplayCep);
    pSetaArrMascaras(arrMskFon, pDisplayFone);
    pSetaArrMascaras(arrMskCnp, pDisplayCnpj);
  End;
End;

procedure TfrmConsultaCxGridNova.pSetaDisplaySimilares;
Begin
  If Not Assigned(objFrmPnl) Then
    Exit;

  If Not Assigned(objFrmPnl.FOnDislplayTextGeneric) Then
    Exit;

  If Not Assigned(objConsulta) Then
    Exit;

  pSetaArrMascarasSimilares(objConsulta.arrDisplayGeneric, objFrmPnl.FOnDislplayTextGeneric);
End;

procedure TfrmConsultaCxGridNova.pSetaDisplayGeneric;
Begin
  If Assigned(objFrmPnl) And Assigned(objFrmPnl.FOnDislplayTextGeneric) Then
  begin
    If Assigned(objConsulta) Then
    With objConsulta Do
    Begin
      If Assigned(objFrmPnl) And Assigned(objFrmPnl.FOnDislplayTextGeneric) Then
        pSetaArrMascaras(arrDisplayGeneric, objFrmPnl.FOnDislplayTextGeneric);
    End;
  End;
End;

procedure TfrmConsultaCxGridNova.pSetaMascaras_Similares;
  Var
    intIndice: Integer;
Begin
  If Assigned(objConsulta) Then
  With objConsulta Do
  Begin

    For intIndice := Low(arrIdxCam) To High(arrIdxCam) Do
      If cxSimilaresView.GetColumnByFieldName(arrIdxCam[intIndice].strCodCam) <> Nil Then
        arrIdxCam[intIndice].intIndice := cxSimilaresView.GetColumnByFieldName(arrIdxCam[intIndice].strCodCam).Index;

    For intIndice := Low(arrRecMas) To High(arrRecMas) Do
      With arrRecMas[intIndice] Do
      Begin
        If cxSimilaresView.GetColumnByFieldName(strCodCam) <> Nil Then
          cxSimilaresView.GetColumnByFieldName(strCodCam).OnGetDisplayText := prcDisTex;
      End;
  End;
End;

Function TfrmConsultaCxGridNova.fRetDisplayFormat(strCampo: String): String;
  Var
    intIndice: Integer;
Begin
  If Assigned(objConsulta) Then
  With objConsulta Do
  Begin

    For intIndice := Low(arrForDec) To High(arrForDec) Do
    With arrForDec[intIndice] Do
    If SameText(strNomCam, strCampo) Then
    Begin
      Result := '#,##0.' + fStrZero('0', intQtdDec);
      Exit;
    End;

  End;

  Result := '#,##0.00'
End;

procedure TfrmConsultaCxGridNova.pLimparFiltro;
var
  intContador : Integer;
begin
  If fEmptyStr(objFrmPnl.strLimpaFiltro) Then
    Exit;

  For intContador := 1 To cxgPesquisa.Rows.Count - 1 Do
  Begin
    If objConfConsulta.fNomeRowToNomeCampo(cxgPesquisa.Rows[intContador].Name) = objFrmPnl.strLimpaFiltro Then
    Begin
      If Not fEmptyStr(VarToStr(TcxEditorRow(cxgPesquisa.Rows[intContador]).Properties.Value)) Then
      Begin
        pSetFocus(cxgPesquisa);
        TcxEditorRow(cxgPesquisa.Rows[intContador]).Properties.Value := Null;
        cxgPesquisa.FocusedRow := cxgPesquisa.Rows[intContador];
        cxgPesquisa.ShowEdit;
      End;
    End;
  End;
end;

procedure TfrmConsultaCxGridNova.pTeclaAtalhoLimparFiltrosDePesquisa(Var Key: word);
begin
  If Assigned(objConsulta) And
     objConsulta.recTeclaAtalhoParaLimparPesquisa.blnUsaTeclaAtalho And
    (objConsulta.recTeclaAtalhoParaLimparPesquisa.Key = Key) Then
  Begin
    Key := 0;
    blnLimpandoFiltro := True;
    pSetFocus(cxConsulta);
    objPesquisa.pLimparFiltros(cxgPesquisa);
    cdsConsulta.EmptyDataSet;
    pExecpAfterAtualiza;
    pSetFocus(cxgPesquisa);
    Keybd_Event(VK_RETURN, 0, 0, 0);
  End;
end;

procedure TfrmConsultaCxGridNova.pAlinhaCamposNumericos(cdsGeneric: TUniClientDataSet);
  Var
    intIndice: Integer;
Begin
  Try
    With cdsGeneric Do
    For intIndice := 0 To FieldCount - 1 Do
      With Fields[intIndice] Do
      If DataType In [ftInteger, ftWord, ftFloat, ftSmallint, ftCurrency] Then
      Begin
        Alignment := taRightJustify;

        If (DataType In [ftFloat, ftCurrency]) And
           fEmptyStr(TFloatField(Fields[intIndice]).DisplayFormat) Then
          TFloatField(Fields[intIndice]).DisplayFormat := fRetDisplayFormat(FieldName);
      End;
  Except

  End;
End;

procedure TfrmConsultaCxGridNova.pAplicaFiltro(AstrValue: String);
begin
  strFiltroAplicado := AstrValue;
  pFiltrarRegistros;
end;

procedure TfrmConsultaCxGridNova.cxgPromocDBLayoutViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  //pMostraDetalhesBanner(banPromocao);
end;


procedure TfrmConsultaCxGridNova.cxSimilaresViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  If (Not Assigned(objFrmPnl)) Then
    Exit;
  If (Not Assigned(objFrmPnl.prcAtualizaInformacaoSubConsulta)) Then
    Exit;
  objFrmPnl.prcAtualizaInformacaoSubConsulta;
end;

procedure TfrmConsultaCxGridNova.cxSimilaresViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    blnUsouLegenda : Boolean;
    styStyle: TcxStyle;
begin
  blnUsouLegenda := False;

  If Assigned(objConsulta) And (Assigned(cdsSubGrid)) Then
  Begin
    styStyle := objConsulta.fGetCellStyle(cxSimilaresView, AViewInfo.GridRecord, AViewInfo.Item, cdsSubGrid);
    If Assigned(styStyle) Then
    Begin
      ACanvas.Font.Color := styStyle.TextColor;
      ACanvas.Font.Style := [fsBold];
      blnUsouLegenda := True;
    End
    Else
    Begin
      If intCorFonte <> -1 Then
        ACanvas.Font.Color := intCorFonte;
    End;
  End
  Else
  Begin
    If intCorFonte <> -1 Then
      ACanvas.Font.Color := intCorFonte;
  End;

  If intCorFundo <> -1 Then
    ACanvas.Brush.Color := intCorFundo;

  If blnUsouLegenda Then
  Begin
    If fCalculaContraste(ACanvas.Brush.Color, ACanvas.Font.Color) < 125 Then
    Begin
      If fCalculaContraste(clCream, ACanvas.Font.Color) > 125 Then
        ACanvas.Brush.Color := clCream
      Else
      Begin
        If fCalculaContraste(clLtGray, ACanvas.Font.Color) > fCalculaContraste(ACanvas.Brush.Color, ACanvas.Font.Color) Then
        Begin
          If fCalculaContraste($00DDDDDD, ACanvas.Font.Color) > fCalculaContraste(clLtGray, ACanvas.Font.Color) Then
            ACanvas.Brush.Color := $00DDDDDD
          Else
            ACanvas.Brush.Color := clLtGray;
        End;
      End;
    End
  End;
end;

procedure TfrmConsultaCxGridNova.cxSimilaresViewDblClick(Sender: TObject);
begin
  SetarSimilarSelecionado;
  cxConsultaViewDblClick(Sender);
end;

procedure TfrmConsultaCxGridNova.cxSimilaresViewKeyPress(Sender: TObject;
  var Key: Char);
begin
  SetarSimilarSelecionado;
  cxConsultaViewKeyPress(Sender, Key);
end;

procedure TfrmConsultaCxGridNova.dtsSubGridDataChange(Sender: TObject;
  Field: TField);
begin
  If (Not cxSimilaresView.IsControlFocused) Then
    Exit;
  If (Not Assigned(objFrmPnl)) Then
    Exit;
  If (Not Assigned(objFrmPnl.prcAtualizaInformacaoSubConsulta)) Then
    Exit;
  objFrmPnl.prcAtualizaInformacaoSubConsulta;
end;

procedure TfrmConsultaCxGridNova.pGravarErro(GravarErro:Boolean; MensagemErro:String; strRelatorio: String='');
  Var
    qryLogErr: TUniQuery;
begin
  If GravarErro Then
  Begin
//    If fStartTransaction Then
//    Begin

      qryLogErr := fCriaQuery(Nil);
      qryLogErr.SQL.Add('SELECT * FROM LOGERR WHERE FALSE');

      Try
        With qryLogErr Do
        Begin
          Open;
          Insert;
          FieldByName('LOG_CODEMP').AsString   := VS_strCodEmp;
          FieldByName('LOG_LOGOPE').AsString   := strUsuarioLogado;
          FieldByName('LOG_DTAERR').AsDateTime := VS_Date;
          FieldByName('LOG_HORERR').AsDateTime := fTime();
          FieldByName('LOG_DESCRI').AsString   := MensagemErro;
          If Not fEmptyStr(strRelatorio) Then
            FieldByName('LOG_RELERR').AsString   := strRelatorio;
          Post;
  //        fCommit;
          Close;
        End;
      Finally
        FreeAndNil(qryLogErr);
      End;
    //End;
  End;
end;

function TfrmConsultaCxGridNova.fRetornaStack: String;
begin
{$IFDEF LINUX}
  Result := EmptyStr;
{$ELSE}
  Try
    Raise EDumpStackTrace.Create(EDumpStackTrace.ClassName);
  Except
    On E: Exception Do
      Result := E.StackTrace;
  End;
{$ENDIF}
end;

initialization
//  dxInitialize;

finalization
//  dxFinalize;

end.


