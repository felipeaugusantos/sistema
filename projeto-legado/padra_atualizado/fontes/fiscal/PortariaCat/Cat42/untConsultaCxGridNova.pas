unit untConsultaCxGridNova;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, ExtCtrls, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, StdCtrls, Buttons, ComCtrls, dxCore, untTypesSistema,
  StrUtils, untClassPanelCx, MaskUtils, BitBtnLockedIncrem, Menus, Uni,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, untFuncoes,
  untConfiguraConsulta, cxInplaceContainer, cxVGrid, cxCalendar,
  cxTimeEdit, cxCurrencyEdit, cxMaskEdit, cxTextEdit,
  UniClientDataSet, UniDataSetProvider, MemDS, DBAccess, Datasnap.Provider,
  Vcl.ImgList, cxProgressBar, System.ImageList,
  Datasnap.DBClient, Winapi.PsAPI, cxSplitter, cxImage, cxLabel,
  dxLayoutContainer, cxGridViewLayoutContainer, cxGridLayoutView,
  cxGridDBLayoutView, cxGridCustomLayoutView, Vcl.WinXCtrls, Vcl.AppEvnts,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxImageList;

Const
  WM_MESSAGEATUALIZADADOS = WM_USER + 777;

Type
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
    cxConsultaViewColumn1: TcxGridDBColumn;
    cxConsultaNivel: TcxGridLevel;
    pnlBotGri: TPanel;
    btnCtrEnd: TSpeedButton;
    btnPgDown: TSpeedButton;
    btnCtrHom: TSpeedButton;
    btnPgUp: TSpeedButton;
    pgcRodape: TPageControl;
    cxImageList: TcxImageList;
    lblTab: TLabel;
    cxgPesquisaRow16: TcxEditorRow;
    btnCadastro: TBitBtnLocked;
    pnlFundo: TPanel;
    splBanner: TcxSplitter;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    pnlBanner: TPanel;
    ApplicationEvents: TApplicationEvents;
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
    procedure cxConsultaViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
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
  private
    { Private declarations }
    blnAtualizaConfig,
    blnUsouTab: Boolean;

    FTipCon: TTipoConsulta;
    FFilter: String;
    blnFetch: Boolean;

    blnDirAce,
    blnReturn,
    blnApplyB: Boolean;

    objConfConsulta: TConfiguraConsulta;

    blnMultiSelecao: Boolean;
    stlListSelecao : TStringList;

    sltCamDta  : TStringList;
    sltCamFlt  : TStringList;

    stlSQL   : TStringList;
    stlCampos: TStringList;
    stlOrdem : TStringList;
    intLasPac: Integer;
    strLasFil: String;
    strLastOrder: String;

    blnIniciandoTela  : Boolean;
    blnFinalizandoTela: Boolean;

    blnAbortar  : Boolean;
    blnLeuTudo  : Boolean;

    blnPrimeiraVez: Boolean;

   // objComVen: TComVen;
   // objPromoc: TItemPromo;
   // objEstrut: TGerMat;

    Function fAjustaColunas(pgbProgresso: TcxProgressBar): Boolean;
    Procedure pAjustaColunas;

    Function fRetOrderBy: String;
    Function fGetNextPacket: Integer;
    Function fResolveConflito(strSQL: String): String;
    Function fCampoToSubConsulta(strSQL: String;
                                 blnComAlias: Boolean): String;

    Function fRetDisplayFormat(strCampo: String): String;

    Function fCorrigeCampoFloat(strFilter: String): String;
    Function fCorrigeFiltro(strFilter: String; Var blnAbortar: Boolean): String;

    procedure pSetFocusConsulta(blnFirst: Boolean = False);
    procedure pSalvaConfiguracoes;
    procedure pAtualizaPesquisa(blnProcessMessage: Boolean = True);
    procedure pProximoPacote;
    procedure pCtrlEnd(blnProMsg: Boolean);
    procedure pSetaNomeColunas;
    procedure pSetaMascaras;
    procedure pSelecionar;
    procedure pSetaArrMascaras(arrCampos: TarrCampos; prcDisTxt: TprcDisplayText);
    procedure pAlinhaCamposNumericos;
    procedure pCarregaCamposData;
    Procedure pAtualizaDados(blnUpdate: Boolean = True);
    procedure pAddListaQuery(blnInverter : Boolean = True);
    Procedure pMudaOrdenacao(strNomCol: String);

    Procedure pExibirCheckConsultaContida;

    function fGetChaveConsulta: String;

    Function fRetChaveLista: String;

    function fCheckParent(Sender, Parent: TWinControl): Boolean;
    function fInLista(strChave: String): Boolean;

    procedure pLimparSelecao;

    Function fAtualiza(pgbProgresso: TcxProgressBar): Boolean;
    procedure pExecpAfterAtualiza(blnEnableDisableGrid: Boolean=False);

    procedure pSetaFetch;

    procedure pWMMessageAtualizaDados(var Message: TMessage); Message WM_MESSAGEATUALIZADADOS;
    //procedure pCarregaBanner;
    //procedure pAjustaBanner;
   // procedure pMovimentaComboVenda;
   // procedure pMovimentaPromocao;
   // procedure pMovimentaEstrutura;
   // procedure pMostraDetalhesBanner(tipTipBan: TTipBan);
   // procedure pMostraDetalhesBannerCombo;
   // procedure pMostraDetalhesBannerPromocao;
   // procedure pMostraDetalhesBannerEstrutura;
   // procedure pMostraDetalhes(strCaption: String; stlDetalhes: TStringList; tipTipBan: TTipBan);

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

    objConsulta: TDefConsulta;

    objFrmPnl   : TPanelCx;
    objPnlBanner: TPanelCx;
    pAfterAtualiza: TGenericProcedureWithClientParam;

    blnConCon: Boolean;
    fChamaCadastro : TBooleanFunctionWithBooleanParam;

    Procedure pSetaSql(arrSQL: Array Of String);
    Procedure pSetaCampos(arrCampos: Array Of String);
    Procedure pSetaOrdenacao(arrOrdenacao: Array Of String);
  end;

Const
  TMR_DEFAULT = 500;

var
  frmConsultaCxGridNova: TfrmConsultaCxGridNova;

implementation

uses untFuncoesCXGrid, untPesquisa, untGravando, System.UITypes, untModulo;

{$R *.dfm}

Const
  VK_PGUP   = 33;
  VK_PGDOWN = 34;
  VK_ALT    = 18;
  INTPACREC = 50;

Procedure TfrmConsultaCxGridNova.pSetaOrdenacao(arrOrdenacao: Array Of String);
  Var
    intIndice: Integer;
Begin
  stlOrdem.Clear;

  For intIndice := Low(arrOrdenacao) To High(arrOrdenacao) Do
    stlOrdem.Add(Trim(arrOrdenacao[intIndice]));

End;
{*******************************}
{* SELEÇÃO DE VÁRIOS REGISTROS *}
{****************************RV*}
procedure TfrmConsultaCxGridNova.pSelecionar;
  Var
    intCon: Integer;
    intARowIndex: Integer;
    ARowInfo: TcxRowInfo;
begin

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
Begin
  blnTemWhere := False;
  stlSQL.Clear;
  For intIndice := Low(arrSQL) To High(arrSQL) Do
  Begin
    If AnsiStartsStr('WHERE', Trim(arrSQL[intIndice])) Then
      blnTemWhere := True;
    stlSQL.Add(Trim(arrSQL[intIndice]));
  End;

  If Not blnTemWhere Then
    stlSQL.Add('WHERE TRUE');
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

{procedure TfrmConsultaCxGridNova.tmrBannerTimer(Sender: TObject);
begin
  If (pnlComVen.Visible) And (pnlBanner.Visible) Then
    pMovimentaComboVenda;

  If (pnlPromoc.Visible) And (pnlBanner.Visible) Then
    pMovimentaPromocao;

  If (pnlEstrut.Visible) And (pnlBanner.Visible) Then
    pMovimentaEstrutura;
end;}

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
  If fMensagem('', 'Deseja cancelar a operação?', ['&Sim', '&Não']) = 1 Then
    blnAbortar := True;
end;

procedure TfrmConsultaCxGridNova.pSalvaConfiguracoes;
Begin
  If blnAtualizaConfig And cdsConsulta.Active Then
  Begin
    objPesquisa.pSalvaFiltros(cxgPesquisa, cdsConsulta.RecNo);

    objConfConsulta.fSalvaPesquisa(pnlPesquisa.ClientHeight,
                                   cxConsultaView,
                                   cdsConsulta);
  End;
End;

procedure TfrmConsultaCxGridNova.btnConConClick(Sender: TObject);
begin
  If Not blnDirAce Then
    Exit;

  pSalvaConfiguracoes;

  If objConfConsulta.fEditaConfiguracoes Then
  Begin
    pExibirCheckConsultaContida;
    objConfConsulta.pMudaCorZebra(True);
    objPesquisa.pCarregaFiltros(Nil, fGetChaveConsulta, cxgPesquisa, False);
  End;

  If Assigned(cxgPesquisa.FocusedRow) Then
    chkConsCo.Checked := objConfConsulta.fConsultaContida(cxgPesquisa.FocusedRow.Name);

  pSetaFetch;
end;

procedure TfrmConsultaCxGridNova.btnConfirmaClick(Sender: TObject);
begin
  {***************************}
  {* SIMPLES OU NAO TEM QUE  *}
  {* PEGAR SELEÇÃO DO ARRAY  *}
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

{procedure TfrmConsultaCxGridNova.pAjustaBanner;
Var
  intPnlVis: Integer;
begin
  intPnlVis := 0;

  If (pnlBanner.Visible) Then
  Begin
    If (pnlComVen.Visible) Then
      Inc(intPnlVis);

    If (pnlPromoc.Visible) Then
      Inc(intPnlVis);

    If (pnlEstrut.Visible) Then
      Inc(intPnlVis);
  End;

  If (intPnlVis > 0) Then
  Begin
    If (pnlComVen.Visible) Then
    Begin
      pnlComVen.Height  := Trunc((Self.Height - pnlBotoes.Height - (30 * intPnlVis)) / intPnlVis);

      If (pnlComVen.Height > pnlFundo.Height - 10) Then
        pnlComVen.Height := pnlFundo.Height - 10;

      splComVen.MinSize := pnlComVen.Height;
    End;

    If (pnlPromoc.Visible) Then
    Begin
      pnlPromoc.Height  := Trunc((Self.Height - pnlBotoes.Height - (30 * intPnlVis)) / intPnlVis);

      If (pnlPromoc.Height > pnlFundo.Height - 10) Then
        pnlPromoc.Height := pnlFundo.Height - 10;

      splPromoc.MinSize := pnlPromoc.Height;
    End;

    If (pnlEstrut.Visible) Then
    Begin
      pnlEstrut.Height  := Trunc((Self.Height - pnlBotoes.Height - (30 * intPnlVis)) / intPnlVis);

      If (pnlEstrut.Height > pnlFundo.Height - 10) Then
        pnlEstrut.Height := pnlFundo.Height - 10;

      splEstrut.MinSize := pnlEstrut.Height;
    End;

    tmrBanner.Enabled := True;
  End;
end;}

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
    frmGravando.lblGravando.Caption := 'Ajustando ícones...';
    Application.ProcessMessages;
    objConsulta.pConfiguraIcones(cxConsultaView, cxImageList);
  End;

  Result := True;
End;

procedure TfrmConsultaCxGridNova.btnPadraoClick(Sender: TObject);
begin
  btnPadrao.Enabled := False;

  If cdsConsulta.IsEmpty Then
    pAtualiza(tcpPrimeira, objConfConsulta.fSQLFiltro);

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

procedure TfrmConsultaCxGridNova.chkConsCoClick(Sender: TObject);
begin
  If Assigned(cxgPesquisa.FocusedRow) Then
    objConfConsulta.pDefineConsultaContida(chkConsCo.Checked, cxgPesquisa.FocusedRow.Name);
end;

procedure TfrmConsultaCxGridNova.pWMMessageAtualizaDados(var Message: TMessage);
begin
  pAtualizaDados;
end;

procedure TfrmConsultaCxGridNova.cxConsultaViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  PostMessage(Handle, WM_MESSAGEATUALIZADADOS, 0, 0);
end;

procedure TfrmConsultaCxGridNova.cxConsultaViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    styStyle: TcxStyle;
begin

  If (Not blnSimples) And (Not cdsConsulta.IsEmpty) And
     fInLista(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                                    cxConsultaView.GetColumnByFieldName(strCodBusca).Index])) Then
  Begin

    ACanvas.Brush.Color := clMoneyGreen;

  End;

(*
  If (AViewInfo.Item.SortOrder <> soNone) And
     (Not AViewInfo.Selected) Then
    ACanvas.Brush.Color := clInfoBk;
*)

  If (AViewInfo.Item.SortOrder <> soNone) Or
     (Assigned(objConsulta) And (objConsulta.fCellBold(cxConsultaView, AViewInfo.GridRecord, AViewInfo.Item, cdsConsulta))) Then
    ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];

  If AViewInfo.Selected And Assigned(objConsulta) And (Not fCheckParent(ActiveControl, cxConsulta)) Then
  Begin
    styStyle := objConsulta.fGetCellStyle(cxConsultaView,  AViewInfo.GridRecord,  AViewInfo.Item, cdsConsulta);
    If Assigned(styStyle) Then
      ACanvas.Font.Color := styStyle.TextColor;
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
    pAtualiza(tcpOrdemFiltro, objConfConsulta.fSQLFiltro);
  End;
end;

procedure TfrmConsultaCxGridNova.cxConsultaViewDblClick(Sender: TObject);
begin
  If ((stlListSelecao.Count = 0) Or ((stlListSelecao.Count = 1) And (stlListSelecao.CommaText = cdsConsulta.FieldByName(strCodBusca).AsString))) And
     (Not cdsConsulta.IsEmpty) Then
    btnConfirma.Click;
end;

procedure TfrmConsultaCxGridNova.cxConsultaViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
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
                pSetFocus(cxgPesquisa);

                Keybd_Event(VK_RETURN, 0, 0, 0);

                If (Not blnUsouTab) And
                   ((Not Assigned(cxgPesquisa.FocusedRow)) Or
                    (Not objConfConsulta.fColunaAutoSelecao(cxgPesquisa.FocusedRow.Name))) Then
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
begin
  If Assigned(objConsulta) Then
    AStyle := objConsulta.fGetCellStyle(cxConsultaView, ARecord, AItem, cdsConsulta);
end;

procedure TfrmConsultaCxGridNova.pAtualizaPesquisa(blnProcessMessage: Boolean = True);
  Var
    strFiltro: String;
    blnAbortar: Boolean;
Begin
  strFiltro := objConfConsulta.fSQLFiltro;

  pAtualiza(tcpOrdemFiltro, strFiltro);

  If Pos('MATCH', strFiltro) > 0 Then
  Begin
    If cxConsultaView.DataController.DataSet.Filtered Then
      cxConsultaView.DataController.DataSet.Filtered := False;
  End Else
  Begin
    cxConsultaView.DataController.DataSet.Filter := fCorrigeFiltro(strFiltro, blnAbortar);
    If cxConsultaView.DataController.DataSet.Filtered <> Not fEmptyStr(strFiltro) Then
      cxConsultaView.DataController.DataSet.Filtered := Not fEmptyStr(strFiltro);
  End;
End;

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

  pAtualizaPesquisa;
end;

procedure TfrmConsultaCxGridNova.cxgPesquisaItemChanged(Sender: TObject;
  AOldRow: TcxCustomRow; AOldCellIndex: Integer);
begin

  If Assigned(cxgPesquisa.FocusedRow) Then
    chkConsCo.Checked := objConfConsulta.fConsultaContida(cxgPesquisa.FocusedRow.Name);
end;

{procedure TfrmConsultaCxGridNova.pMostraDetalhes(strCaption: String; stlDetalhes: TStringList; tipTipBan: TTipBan);
Var
  intContador: Integer;
begin
  Try
    pCriarFormularios(TfrmObsBanner, frmObsBanner);

    If (tipTipBan = banEstrutura) Then
    Begin
      frmObsBanner.Height := 600;
      frmObsBanner.Width  := 766;
    End
    Else
    Begin
      frmObsBanner.Height := 290;
      frmObsBanner.Width  := 550;
    End;

    frmObsBanner.Caption := strCaption;

    For intContador := 0 To stlDetalhes.Count - 1 Do
      frmObsBanner.mmoObserv.Lines.Add(stlDetalhes[intContador]);

    frmObsBanner.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmConsultaCxGridNova.pMostraDetalhe]');
  End;

  pFreeAndNil(frmObsBanner);
end;

procedure TfrmConsultaCxGridNova.pMostraDetalhesBanner(tipTipBan: TTipBan);
begin
  If (tipTipBan = banCombo) Then
    pMostraDetalhesBannerCombo
  Else If (tipTipBan = banPromocao) Then
    pMostraDetalhesBannerPromocao
  Else If (tipTipBan = banEstrutura) Then
    pMostraDetalhesBannerEstrutura;
end;

procedure TfrmConsultaCxGridNova.pMostraDetalhesBannerCombo;
Var
  stlDetalhes: TStringList;
  strEmpres  : String;
  blnPriReg  : Boolean;
begin

  Try
    stlDetalhes := TStringList.Create;
    stlDetalhes.Add(fPadR('', 72, '-'));
    stlDetalhes.Add('INFORMAÇÕES DETALHADAS DO COMBO DE VENDA');
    stlDetalhes.Add(fPadR('', 72, '-'));
    stlDetalhes.Add('Combo          : ' + dtsComVen.DataSet.FieldByName('DESCOM').AsString);
    stlDetalhes.Add('Tabela de Preço: ' + dtsComVen.DataSet.FieldByName('TABPRE').AsString);
    stlDetalhes.Add('Vigência       : ' + dtsComVen.DataSet.FieldByName('VIGENC').AsString);

    strEmpres := Trim(dtsComVen.DataSet.FieldByName('EMPRES').AsString);

    blnPriReg := True;

    If (Length(strEmpres) <= 52) Then
      stlDetalhes.Add('Empresas       : ' + strEmpres)
    Else
    Begin
      While (Length(strEmpres) > 0) Do
      Begin
        If (blnPriReg) Then
        Begin
          stlDetalhes.Add('Empresas       : ' + Copy(strEmpres, 1, 51));
          blnPriReg := False;
        End
        Else
          stlDetalhes.Add('                 ' + Copy(strEmpres, 1, 51));

        delete(strEmpres, 1, 53);
        strEmpres := Trim(strEmpres);
      End;
    End;

    stlDetalhes.Add(fPadR('', 72, '-'));

    pMostraDetalhes('PRODUTO: ' + dtsComVen.DataSet.FieldByName('CODITE').AsString + '-' + dtsComVen.DataSet.FieldByName('DESITE').AsString, stlDetalhes, banCombo);
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmConsultaCxGridNova.pMostraDetalhesBannerCombo]');
  End;

  FreeAndNil(stlDetalhes);
end;

procedure TfrmConsultaCxGridNova.pMostraDetalhesBannerEstrutura;
Var
  stlDetalhes: TStringList;
  intDecQtd: Integer;
begin

  Try

    intDecQtd := fCfgSis('DECQTD', VarInteger);

    objEstrut.pCarregaProdutosDaEstrutura(dtsEstrut.DataSet.FieldByName('AUTINC').AsString);

    stlDetalhes := TStringList.Create;
    stlDetalhes.Add('+-----------------------------------------------------------------------------------------------------+');
    stlDetalhes.Add('| PRODUTO ESTRUTURA: ' + fPadR(dtsEstrut.DataSet.FieldByName('CODITE').AsString + '-' + dtsEstrut.DataSet.FieldByName('DESITE').AsString, 81) + '|' );
    stlDetalhes.Add('+--------+------------------------------------------------------------------------+------+------------+');
    stlDetalhes.Add('| CÓDIGO | DESCRIÇÃO                                                              | UN   | QUANTIDADE |');
    stlDetalhes.Add('+--------+------------------------------------------------------------------------+------+------------+');

    With objEstrut.getQryIteEst Do
    Begin
      First;

      While Not Eof Do
      Begin
        stlDetalhes.Add('| ' + FieldByName('CODITE').AsString + '  | ' + fPadR(FieldByName('DESITE').AsString, 70) + ' | ' + fPadR(FieldByName('SIGUNI').AsString, 04) + ' | ' + fPadL(FormatFloat(fMskDigitos(intDecQtd), FieldByName('QTDITE').AsFloat), 10) + ' |');
        stlDetalhes.Add('+--------+------------------------------------------------------------------------+------+------------+');
        Next;
      End;
    End;

    pMostraDetalhes('Detalhes da Estrutura', stlDetalhes, banEstrutura);
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmConsultaCxGridNova.pMostraDetalhesBannerEstrutura]');
  End;

  FreeAndNil(stlDetalhes);

end;

procedure TfrmConsultaCxGridNova.pMostraDetalhesBannerPromocao;
Var
  stlDetalhes: TStringList;
  strEmpres: String;
  blnPriReg: Boolean;
begin

  Try
    stlDetalhes := TStringList.Create;
    stlDetalhes.Add(fPadR('', 72, '-'));
    stlDetalhes.Add('INFORMAÇÕES DETALHADAS DA PROMOÇÃO');
    stlDetalhes.Add(fPadR('', 72, '-'));
    stlDetalhes.Add('Promoção       : ' + dtsPromoc.DataSet.FieldByName('DESPRO').AsString);
    stlDetalhes.Add('Tabela de Preço: ' + dtsPromoc.DataSet.FieldByName('TABPRE').AsString);
    stlDetalhes.Add('Vigência       : ' + dtsPromoc.DataSet.FieldByName('VIGENC').AsString);

    strEmpres := Trim(dtsPromoc.DataSet.FieldByName('EMPRES').AsString);

    blnPriReg := True;

    If (Length(strEmpres) <= 52) Then
      stlDetalhes.Add('Empresas       : ' + strEmpres)
    Else
    Begin
      While (Length(strEmpres) > 0) Do
      Begin
        If (blnPriReg) Then
        Begin
          stlDetalhes.Add('Empresas       : ' + Copy(strEmpres, 1, 51));
          blnPriReg := False;
        End
        Else
          stlDetalhes.Add('                 ' + Copy(strEmpres, 1, 51));

        delete(strEmpres, 1, 53);
        strEmpres := Trim(strEmpres);
      End;
    End;

    stlDetalhes.Add(fPadR('', 72, '-'));

    pMostraDetalhes('PRODUTO: ' + dtsPromoc.DataSet.FieldByName('CODITE').AsString + '-' + dtsPromoc.DataSet.FieldByName('DESITE').AsString, stlDetalhes, banPromocao);
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmConsultaCxGridNova.pMostraDetalhesBannerPromocao]');
  End;

  FreeAndNil(stlDetalhes);

end;

procedure TfrmConsultaCxGridNova.pMovimentaComboVenda;
begin
  If (Not Assigned(dtsComVen.DataSet)) Then
    Exit;

  If (Not chkAniCom.Checked) Then
    Exit;

  With dtsComVen.DataSet Do
  Begin
    If (RecordCount > 0) Then
    Begin
      If Eof Then
        First
      Else
        Next;
    End;
  End;
end;

procedure TfrmConsultaCxGridNova.pMovimentaEstrutura;
begin
  If (Not Assigned(dtsEstrut.DataSet)) Then
    Exit;

  If (Not chkAniEst.Checked) Then
    Exit;

  With dtsEstrut.DataSet Do
  Begin
    If (RecordCount > 0) Then
    Begin
      If Eof Then
        First
      Else
        Next;
    End;
  End;
end;

procedure TfrmConsultaCxGridNova.pMovimentaPromocao;
begin
  If (Not Assigned(dtsPromoc.DataSet)) Then
    Exit;

  If (Not chkAniPro.Checked) Then
    Exit;

  With dtsPromoc.DataSet Do
  Begin
    If (RecordCount > 0) Then
    Begin
      If Eof Then
        First
      Else
        Next;
    End;
  End;
end;}

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

  Case Key Of
    VK_RETURN: Begin
                 If objConfConsulta.recConfigur.blnComKey And cdsConsulta.IsEmpty Then
                 Begin
                   Keybd_Event(VK_END, 0, 0, 0);

                   If cxgPesquisa.IsEditing Then
                     Keybd_Event(VK_RETURN, 0, 0, 0);
                 End;
               End;

    VK_TAB:    If Assigned(objFrmPnl) And objFrmPnl.blnTemPan And
                  Assigned(objFrmPnl.fncTeclaTab) Then
                 Key := 0;
  End;
end;

procedure TfrmConsultaCxGridNova.cxgPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  If (Key = '%') And objConfConsulta.recConfigur.blnConsCo Then
    Key := #0;
end;

procedure TfrmConsultaCxGridNova.cxgPesquisaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_RETURN: If (Not cxConsulta.Focused) And (Not cdsConsulta.IsEmpty) Then
                 pSetFocus(cxConsulta);

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
  If Assigned(objPnlBanner) Then
  Begin
    pnlBanner.Visible := True;
    splBanner.Visible := True;
    objPnlBanner.intAltTel := pnlBanner.Height;
    objPnlBanner.pCriaForm(Self, pnlBanner, cdsConsulta, btnConfirma);
  End;
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
        pSalvaConfiguracoes;
    End;
  End;
end;

procedure TfrmConsultaCxGridNova.FormCreate(Sender: TObject);
begin
  blnUsouTab := False;
  blnAtualizaConfig := False;

  pAfterAtualiza  := Nil;
  objConfConsulta := Nil;

  blnApplyB := True;
  blnReturn := False;

  blnPrimeiraVez := True;
  blnLeuTudo  := False;
  blnConfirma := False;

  stlSQL      := TStringList.Create;
  stlCampos   := TStringList.Create;
  stlOrdem    := TStringList.Create;

  sltCamDta   := TStringList.Create;
  sltCamFlt   := TStringList.Create;

  qryConsulta.Connection    := frmModulo.Database;

  strLasFil    := '';
  strLastOrder := '';

  blnConCon    := True;
end;

procedure TfrmConsultaCxGridNova.FormDestroy(Sender: TObject);
begin
  FreeAndNil(stlSQL);
  FreeAndNil(stlCampos);
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
begin {AddListaQuery}
  If cdsConsulta.Active And (Not cdsConsulta.IsEmpty) Then
  Begin
    strAuto  := fRetChaveLista;

    intIndex := stlListSelecao.IndexOf(strAuto);

    If intIndex > -1 then
    Begin
      if blnInverter then
        stlListSelecao.Delete(intIndex);
    End
    Else
    Begin
      stlListSelecao.Add(strAuto);
    End;
  End;
end; {AddListaQuery}

Function TfrmConsultaCxGridNova.fGetNextPacket: Integer;
Begin
  If blnLeuTudo Or (Not blnFetch) Then
    Result := 0
  Else
  Begin
    Result := cdsConsulta.GetNextPacket;

    blnLeuTudo := (Result < cdsConsulta.PacketRecords) And
                  fEmptyStr(strLasFil);
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
      pAtualizaDados;

    pExecpAfterAtualiza(True);
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
  Case Key Of
     VK_RETURN: blnReturn := True;

     VK_TAB:    If Assigned(objFrmPnl) And objFrmPnl.blnTemPan And
                  Assigned(objFrmPnl.fncTeclaTab) Then
                Begin
                  objFrmPnl.fncTeclaTab(cdsConsulta, pgcRodape);
                  Key := 0;

                  pSetFocusConsulta;

                  blnUsouTab := True;
                  Exit;
                End;

     Else       blnReturn := False;
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

                 If cxgPesquisa.Focused Then
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
  Result := False;

  If Sender = Nil Then
    Exit;

  If Sender.Parent = nil Then
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

  Case Key Of
    VK_HOME,
    VK_END,
    VK_PGDOWN,
    VK_DOWN,
    VK_PRIOR,
    VK_UP    : pAtualizaDados;
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
  If Assigned(objPnlBanner) And Assigned(objPnlBanner.prcAtualizaDados) Then
  Begin
    objPnlBanner.intAltTel := pnlBanner.Height;
    objPnlBanner.prcAtualizaDados;
  End;
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

procedure TfrmConsultaCxGridNova.FormShow(Sender: TObject);
  Var
    arrSimNaoP : TStringArrayArray;
    intIndex   : Integer;
    arrSubConsulta: TArrRecSubConsulta;

  procedure pLocalizarRegistro(strNomCam, strValCam: String);
  begin
    Repeat
      If fEmptyStr(strNomCam) Then Break;
      If cdsConsulta.Locate(strNomCam, strValCam, []) Then Break;
      cdsConsulta.Last;
      pProximoPacote;
    Until blnLeuTudo;
  End;

begin
  btnCadastro.Visible := Assigned(fChamaCadastro) And fChamaCadastro(True);

  If Assigned(objConsulta) Then
  Begin
    SetLength(arrSimNaoP, Length(objConsulta.arrSimNao));
    For intIndex := 0 To High(objConsulta.arrSimNao) Do
      arrSimNaoP[intIndex] := objConsulta.arrSimNao[intIndex];
  End;

  btnConCon.Visible := blnDirAce And blnConCon;

  If blnDirAce Then
  Begin
    lblMudaOrdem.Font.Color := clGreen;
  End Else
  Begin
    lblMudaOrdem.Font.Color := clRed;
  End;

  blnIniciandoTela   := True;
  blnFinalizandoTela := False;

  pAtualiza(tpcVazio);

  If Not (Assigned(objFrmPnl) And objFrmPnl.blnTemPan) Then
    pgcRodape.Visible := False;

  If Assigned(objConsulta) Then
    arrSubConsulta := objConsulta.arrSubCon
  Else
    arrSubConsulta := Nil;

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
                                               arrSubConsulta);

  pSetaFetch;

  pExibirCheckConsultaContida;

  objConfConsulta.pMontaPesquisa;

  If Assigned(objConsulta) Then
  Begin
    objPesquisa.pCarregaFiltros(objConsulta.arrFiltro, fGetChaveConsulta, cxgPesquisa, True);
    objPesquisa.fCarregaFiltrosParametros(objConsulta.arrFiltro, cxgPesquisa);
  End Else
  Begin
    objPesquisa.pCarregaFiltros(Nil, fGetChaveConsulta, cxgPesquisa, False);
  End;

  If Assigned(objFrmPnl) And objFrmPnl.blnTemPan Then
  Begin
    objFrmPnl.pCriaForm(Self, pgcRodape, cdsConsulta, btnConfirma);

    If Assigned(objFrmPnl.fncTeclaTab) Then
      lblTab.Visible := True;
  End;

  strLastOrder := fRetOrderBy;

  If (Not cdsConsulta.Active) Or cdsConsulta.IsEmpty And
     ((Not fEmptyStr(objConfConsulta.fSQLFiltro)) Or (Not objConfConsulta.recConfigur.blnComKey)) Then
  Begin
    pAtualiza(tcpPrimeira, objConfConsulta.fSQLFiltro);
  End;

  cxConsultaView.OptionsView.GroupByBox           := False;
  cxConsultaView.FilterBox.Visible                := fvNever;
  cxConsultaView.OptionsCustomize.ColumnFiltering := False;

  If (Not objConfConsulta.blnLoadView) And (Not cdsConsulta.IsEmpty) Then
    cxConsultaView.ApplyBestFit;

  stlListSelecao := TStringList.Create;

  blnMultiSelecao   := Not blnSimples;
  btnLimpar.Visible := blnMultiSelecao;

  lblMulSel.Visible := Not blnSimples;

  Try
    If (cdsConsulta.RecordCount >= objPesquisa.intRecNo) And
       (objPesquisa.intRecNo > 0)                        Then
        cdsConsulta.RecNo := objPesquisa.intRecNo;

  Except

  End;

  pAtualizaDados;

  objConfConsulta.pFocoNaPesquisa;

  If Not objConfConsulta.recConfigur.blnComKey Then
    pSetFocus(cxConsulta);

  If Assigned(objConsulta) And (Length(objConsulta.arrFiltro) > 0) And (Not cdsConsulta.IsEmpty) Then
  Begin
    pLocalizarRegistro(objConsulta.recLocalizar.strNomCam, objConsulta.recLocalizar.strValCam);
    pAtualizaDados;
    pSetFocus(cxConsulta);
  End;

  If (cxConsultaView.SortedItemCount = 0) And (stlOrdem.Count > 0) Then
    pMudaOrdenacao(stlOrdem[0]);

  blnIniciandoTela := False;
  pSetaNomeColunas;

end;

Procedure TfrmConsultaCxGridNova.pAtualizaDados(blnUpdate: Boolean = True);
Begin
  Try

   If blnFinalizandoTela Then
     Exit;

   If Assigned(objFrmPnl) And Assigned(objFrmPnl.prcAtualizaDados) Then
     objFrmPnl.prcAtualizaDados(blnUpdate);

    {**********************************************************************}
    {* CONTORNA BUG DO PAGECONTROL QUE NÃO RESPONDE AO VISIBLE FALSE/TRUE *}
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

Function TfrmConsultaCxGridNova.fRetOrderBy: String;
  Var
    intIndice: Integer;
    blnTemOrd: Boolean;
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

          If Not fEmptyStr(SortedItems[intIndice].Caption) Then
          Begin
            blnTemOrd := True;
            Result := Result + ' ' + objConfConsulta.fDescricaoToNomeCampo(SortedItems[intIndice].Caption);

            If SortedItems[intIndice].SortOrder = soDescending Then
              Result := Result + ' DESC ';

            If intIndice <> SortedItemCount - 1 Then
              Result := Result + ',';
          End;

        End;

      If blnTemOrd Then
        Result := Result + ', ';

      Result := Result + ' AUTOINCREM';
    End;

  End;
End;

procedure TfrmConsultaCxGridNova.LimparSeleo1Click(Sender: TObject);
begin
  pLimparSelecao;
end;

procedure TfrmConsultaCxGridNova.pSetaNomeColunas;
  Var
    intIndice: Integer;
Begin
  For intIndice := 0 To cdsConsulta.FieldCount - 1 Do
  Begin
    If (intIndice <= stlCampos.Count - 1) Then
    Begin
      cdsConsulta.Fields[intIndice].DisplayLabel := stlCampos[intIndice];
    End Else
      cdsConsulta.Fields[intIndice].Visible := False;
  End;

  For intIndice := 0 To cxConsultaView.ColumnCount - 1 Do
  Begin
    If cdsConsulta.FindField(cxConsultaView.Columns[intIndice].DataBinding.FieldName) = Nil Then
      cxConsultaView.Columns[intIndice].Visible := False
//    Else If SameText(cxConsultaView.Columns[intIndice].DataBinding.FieldName, 'VENDIDO') Then
//      cxConsultaView.Columns[intIndice].MinWidth := 35
//    Else
//      cxConsultaView.Columns[intIndice].MinWidth := Length(cxConsultaView.Columns[intIndice].Caption) * 8;
  End;

  If Assigned(objConsulta) Then
    objConsulta.pConfiguraIcones(cxConsultaView, cxImageList);
End;

Function TfrmConsultaCxGridNova.fCampoToSubConsulta(strSQL: String;
  blnComAlias: Boolean): String;
  Var
    intIndice: Integer;
Begin
  Result := strSQL;

  If Assigned(objConsulta) Then
  With objConsulta Do
  Begin
    For intIndice := Low(arrSubCon) To High(arrSubCon) Do
      With arrSubCon[intIndice] Do
      If blnComAlias Then
        Result := StringReplace(Result, strAlias_, strSubSql + ' AS ' + strAlias_, [rfReplaceAll])
      Else
        Result := StringReplace(Result, strAlias_, strSubSql, [rfReplaceAll]);
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
        Result := StringReplace(Result, strNomCam, strCamNov, [rfReplaceAll]);
  End

End;

{procedure TfrmConsultaCxGridNova.pCarregaBanner;
begin

  If (Not blnBanner) Then
    Exit;

  If (MidStr(fCfgSis('BANVEN', VarString), 1,1) = '1') Then
  Begin
    pnlBanner.Visible := True;
    splBanner.Visible := True;
    pnlComVen.Visible := True;
    splComVen.Visible := True;

    If (Not Assigned(objComVen)) Then
      objComVen := TComVen.Create(Self);

    objComVen.setCodEmp(VS_strCodEmp);
    objComVen.pCarregaProdutosParaBanner(strTabPre);
    dtsComVen.DataSet := objComVen.getcdsBanner;
  End;

  If (MidStr(fCfgSis('BANVEN', VarString), 2,1) = '1') Then
  Begin
    pnlBanner.Visible := True;
    splBanner.Visible := True;
    pnlPromoc.Visible := True;
    splPromoc.Visible := True;

    If (Not Assigned(objPromoc)) Then
      objPromoc := TItemPromo.Create;

    objPromoc.pCarregaProdutosParaBanner;
    dtsPromoc.DataSet := objPromoc.getcdsBanner;
  End;

  If (MidStr(fCfgSis('BANVEN', VarString), 3,1) = '1') Then
  Begin
    pnlBanner.Visible := True;
    splBanner.Visible := True;
    pnlEstrut.Visible := True;
    splEstrut.Visible := True;

    If (Not Assigned(objEstrut)) Then
      objEstrut := TGerMat.Create(Self);

    objEstrut.pCarregaProdutosParaBanner(strTabPre);
    dtsEstrut.DataSet := objEstrut.getcdsBanner;
  End;

  pAjustaBanner;

end;}

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

Function TfrmConsultaCxGridNova.fCorrigeCampoFloat(strFilter: String): String;
  Var
    intIndice,
    intPosCam,
    intQtdQuote: Integer;
Begin

  Result := strFilter;

  For intIndice := 0 To sltCamFlt.Count - 1 Do
  Begin

    intPosCam := Pos(sltCamFlt[intIndice], Result);

    If intPosCam > 0 Then
    Begin

      intQtdQuote := 0;

      While intQtdQuote < 2 Do
      Begin
        Case Result[intPosCam] Of
          '.' : Result[intPosCam] := ',';
          '''': inc(intQtdQuote);
        End;

        inc(intPosCam);
      End;

    End;

  End;

End;

Function TfrmConsultaCxGridNova.fCorrigeFiltro(strFilter: String; Var blnAbortar: Boolean): String;
Begin
  Result := fCorrigeCampoFloat(Result);
End;

Procedure TfrmConsultaCxGridNova.pAtualiza(tpcTipCon: TTipoConsulta; strFilter: String = '');
Begin
  Try
    FTipCon := tpcTipCon;
    FFilter := strFilter;

    If Assigned(objConfConsulta) And (Not objConfConsulta.recConfigur.blnComKey) Then
    Begin
      fAtualiza(Nil)
    End Else
    Begin

      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.pgbStatus.Visible   := False;
      frmGravando.blnDesabilitaMouse  := True;
      frmGravando.lblGravando.Caption := 'Carregando dados...';
      frmGravando.fExecutarAcao := fAtualiza;
      frmGravando.ShowModal;

      pFreeAndNil(frmGravando);

      pSetFocusConsulta(True);
    End;

    Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmConsultaCxGridNova.pAtualiza]');
    End;
  End;

  pAtualizaDados(False);
End;

Function TfrmConsultaCxGridNova.fAtualiza(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strSqlAux,
    strOrder: String;
    intIndice: Integer;

    //timeAux: TTime;
begin
  Try
    Result := True;

    strSqlAux := '';

    For intIndice := 0 To stlSQL.Count - 1 Do
    Begin
      strSqlAux := strSqlAux + ' ' + fCampoToSubConsulta(stlSQL[intIndice], True);

      If AnsiStartsStr('WHERE', Trim(stlSQL[intIndice])) Then
      Begin
        Case FTipCon Of
          tpcVazio: strSqlAux := strSqlAux + ' AND FALSE ';
        End;

        If Not fEmptyStr(FFilter) Then
        Begin
          FFilter := fResolveConflito(FFilter);

          strSqlAux := strSqlAux + ' AND ' + fCampoToSubConsulta(FFilter, False) + ' ';
        End;
      End;
    End;

    strOrder := fRetOrderBy;

    If (FTipCon = tcpOrdemFiltro) And
       (strLasFil = FFilter) And
       (strLastOrder = strOrder) And
       (Not blnReturn) Then
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
    {* pAfterAtualiza, ESTAVA SE PERDENDO E NÃO CALCULANDO TODOS OS ITENS  *}
    {63054****************************************************************LE}
    If (Assigned(pAfterAtualiza)) And (Pos(strCodBusca,strSqlAux) > 0)Then
      cdsConsulta.IndexFieldNames := strCodBusca;

    cdsConsulta.DisableControls;

    strSqlAux := strSqlAux + fRetOrderBy;

    With qryConsulta Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSqlAux);

      If Assigned(objConsulta) Then
        objConsulta.pParametriza(qryConsulta);

      Options.SetFieldsReadOnly := False;
    End;

    blnLeuTudo  := False;

    If (Not cdsConsulta.Active)   Or
       (Assigned(pAfterAtualiza)) Or
       (Assigned(objFrmPnl) And objFrmPnl.blnTemPan And Assigned(objFrmPnl.fncTeclaTab)) Then
    Begin
      cdsConsulta.Close;
      cdsConsulta.Open;
      pSetaClient(cdsConsulta);
    End
    Else
    Begin
      cdsConsulta.CancelUpdates;
      if blnRefresh And (Not cdsConsulta.IsEmpty) Then
      Begin
        Try
          cdsConsulta.Refresh;
        Except
          cdsConsulta.Close;
          cdsConsulta.Open;
        End;
      End Else
      Begin
        cdsConsulta.Close;
        cdsConsulta.Open;
      End;
    End;

    pTrimAppMemorySize;

    cdsConsulta.FieldByName('AUTOINCREM').Visible := False;

    pSetaNomeColunas;

    pSetaMascaras;

    pAlinhaCamposNumericos;

    Case FTipCon Of
      tpcVazio: Begin
                  cxConsultaView.DataController.CreateAllItems;
                  pCarregaCamposData;
                End;
    End;

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

    pSetaArrMascaras(arrMskCep, pDisplayCep);
    pSetaArrMascaras(arrMskFon, pDisplayFone);
    pSetaArrMascaras(arrMskCnp, pDisplayCnpj);
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

procedure TfrmConsultaCxGridNova.pAlinhaCamposNumericos;
  Var
    intIndice: Integer;
Begin
  Try
    With cdsConsulta Do
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

procedure TfrmConsultaCxGridNova.cxgPromocDBLayoutViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  //pMostraDetalhesBanner(banPromocao);
end;

initialization
//  dxInitialize;

finalization
//  dxFinalize;

end.
