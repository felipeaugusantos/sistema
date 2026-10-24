unit untConsultaCxGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, ExtCtrls, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, StdCtrls, Buttons, UniClientDataSet, Uni, UniDataSetProvider, ComCtrls, untFuncoesGen,
  StrUtils, untClassPanelCx, MaskUtils, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, dxCore, MemDS, DBAccess, MySQLUniProvider,
  UniProvider, Provider, System.UITypes;

type
  TfrmConsultaCxGrid = class(TForm)
    pnlBotoes: TPanel;
    dtsConsulta: TDataSource;
    pvdConsulta: TUniDataSetProvider;
    qryConsulta: TUniQuery;
    cdsConsulta: TUniClientDataSet;
    prbProgresso: TProgressBar;
    pnlConsulta: TPanel;
    pgcRodape: TPageControl;
    cxConsulta: TcxGrid;
    cxConsultaView: TcxGridDBTableView;
    cxConsultaNivel: TcxGridLevel;
    pnlLegenda: TPanel;
    tmrFiltro: TTimer;
    Label1: TLabel;
    cxsrConsulta: TcxStyleRepository;
    btnSair: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnPadrao: TBitBtnLocked;
    btnCancel: TBitBtnLocked;
    btnLimpar: TBitBtnLocked;
    MySQLUniProvider1: TMySQLUniProvider;
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
    procedure cxConsultaViewDataControllerFilterBeforeChange(
      Sender: TcxDBDataFilterCriteria; ADataSet: TDataSet;
      const AFilterText: string);
    procedure FormDestroy(Sender: TObject);
    procedure cxConsultaViewDataControllerGroupingChanged(Sender: TObject);
    procedure cxConsultaViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxConsultaViewDblClick(Sender: TObject);
    procedure tmrFiltroTimer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure cxConsultaViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxConsultaViewSelectionChanged(Sender: TcxCustomGridTableView);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure cxConsultaViewMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cxConsultaViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    { Private declarations }
    blnMultiSelecao: Boolean;
    stlListSelecao : TStringList;

    sltCamDta  : TStringList;
    sltCamFlt  : TStringList;

    stlSQL   : TStringList;
    stlCampos: TStringList;
    stlOrdem : TStringList;
    intLasPac: Integer;
    strLasFil: String;

    blnIniciando: Boolean;
    blnAbortar  : Boolean;
    blnLeuTudo  : Boolean;

    blnPrimeiraVez: Boolean;

    Function fRetOrderBy: String;
    Function fGetNextPacket: Integer;
    Function fResolveConflito(strSQL: String): String;
    Function fCampoToSubConsulta(strSQL: String;
                                 blnComAlias: Boolean): String;

    Function fRetDisplayFormat(strCampo: String): String;

    Function fCorrigeCampoData(strFilter: String; Var blnAbortar: Boolean): String;
    Function fCorrigeCampoFloat(strFilter: String): String;
    Function fCorrigeFiltro(strFilter: String; Var blnAbortar: Boolean): String;

    procedure pProximoPacote;
    procedure pCtrlEnd(blnProMsg: Boolean);
    procedure pSetaNomeColunas;
    procedure pSetaMascaras;
    procedure pSelecionar;
    procedure pResetaTemporizador;
    procedure pSetaArrMascaras(arrCampos: TarrCampos; prcDisTxt: TprcDisplayText);
    procedure pAlinhaCamposNumericos;
    procedure pCarregaCamposData;
    Procedure pAtualizaDados;
    function fValidaSelect(strSelect: String; tpcTipCon: TTipoConsulta): Boolean;

    function fGetChaveConsulta: String;

    Function fRetChaveLista: String;
  protected
    procedure pAtualiza(tpcTipCon: TTipoConsulta; strFilter: String = ''); virtual;
  public
    { Public declarations}
    strNomForm : String;
    strCodBusca: String;
    strTitPesq : String;
    blnConfirma: Boolean;
    blnSimples : Boolean;
    arrNomCol  : Array Of String;
    arrCodSel  : Array Of String;

    objConsulta: TDefConsulta;

    objFrmPnl: TPanelCx;
    pAfterAtualiza: TGenericProcedureWithClientParam;

    function fCheckParent(Sender, Parent: TWinControl): Boolean;
    function fInLista(strChave: String): Boolean;

    Procedure pSetaSql(arrSQL: Array Of String);
    Procedure pSetaCampos(arrCampos: Array Of String);
    Procedure pSetaOrdenacao(arrOrdenacao: Array Of String);

    procedure pAddListaQuery;

  end;

Const
  TMR_DEFAULT = 500;

var
  frmConsultaCxGrid: TfrmConsultaCxGrid;

implementation

uses untFuncoesCXGrid;

{$R *.dfm}

Const
  VK_PGDOWN = 34;
  INTPACREC = 50;

Procedure TfrmConsultaCxGrid.pSetaOrdenacao(arrOrdenacao: Array Of String);
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
procedure TfrmConsultaCxGrid.pSelecionar;
  Var
    intCon: Integer;
    intARowIndex: Integer;
    ARowInfo: TcxRowInfo;
begin
  If blnSimples Or (stlListSelecao.Count = 0) Then
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

Procedure TfrmConsultaCxGrid.pSetaCampos(arrCampos: Array Of String);
  Var
    intIndice: Integer;
Begin
  stlCampos.Clear;
  For intIndice := Low(arrCampos) To High(arrCampos) Do
    stlCampos.Add(Trim(arrCampos[intIndice]));
End;

Procedure TfrmConsultaCxGrid.pSetaSql(arrSQL: Array Of String);
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

function TfrmConsultaCxGrid.fValidaSelect(strSelect: String; tpcTipCon: TTipoConsulta): Boolean;
var
  qrySel: TUniQuery;
begin
  Result := True;

  If tpcTipCon = tpcVazio Then
  Begin
    Try
      Try
        qrySel := fCriaQuery(Nil);
        With qrySel Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSelect);
          Open;
        End;
      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '');
        End;
      End;
    Finally
      FreeAndNil(qrySel);
    End;
  End;
end;

procedure TfrmConsultaCxGrid.tmrFiltroTimer(Sender: TObject);
   Var
     strFiltro: String;
begin
  If AnsiEndsText(QuotedStr('%') + ')', strLasFil) Or
     AnsiEndsText('=' + QuotedStr('-') + ')', strLasFil) Then
  Begin
    Exit;
  End;

  BlockInput(LongBool(1));
  Try
    strFiltro := cxConsultaView.Controller.FocusedColumn.DataBinding.FilterFieldName;

    tmrFiltro.Enabled := False;

    If (GetKeyState(VK_SHIFT) And 128) <= 0 Then
    Begin
      pAtualiza(tcpOrdemFiltro, strLasFil);
      TFuncoesCXGrid.pFocoNoFiltro(cxConsultaView, stlOrdem, strFiltro);
    End;
      
  Finally
    BlockInput(LongBool(0));
  End;
end;

procedure TfrmConsultaCxGrid.btnCancelClick(Sender: TObject);
begin
  If fMensagem('', 'Deseja cancelar a operação?', ['&Sim', '&Não']) = 1 Then
    blnAbortar := True;
end;

procedure TfrmConsultaCxGrid.btnConfirmaClick(Sender: TObject);
begin
  {***************************}
  {* SIMPLES OU NAO TEM QUE  *}
  {* PEGAR SELEÇÃO DO ARRAY  *}
  {************************NC*}
  pSelecionar;
  blnConfirma := True;
  btnSair.Click;
end;

procedure TfrmConsultaCxGrid.btnLimparClick(Sender: TObject);
begin

  If Assigned(stlListSelecao) Then
  Begin
    stlListSelecao.Clear;
    cxConsultaView.DataController.Refresh;
  End;  

end;

procedure TfrmConsultaCxGrid.btnPadraoClick(Sender: TObject);
begin
  btnPadrao.Enabled := False;
  TFuncoesCXGrid.pCarregarEstado(cxConsultaView, 'Software\Citel');
  TFuncoesCXGrid.pFocoNoFiltro(cxConsultaView, stlOrdem, '', False);
  btnPadrao.Enabled := True;
end;

procedure TfrmConsultaCxGrid.btnSairClick(Sender: TObject);
begin
  blnIniciando := True;
  Close;
end;

procedure TfrmConsultaCxGrid.cxConsultaViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  pAtualizaDados;
end;

procedure TfrmConsultaCxGrid.cxConsultaViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin

  If (Not blnSimples) And (Not cdsConsulta.IsEmpty) And
     fInLista(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                                    cxConsultaView.GetColumnByFieldName(strCodBusca).Index])) Then
  Begin

    ACanvas.Brush.Color := clMoneyGreen;

  End;

 { If (AViewInfo.Item.SortOrder <> soNone) And
     (Not AViewInfo.Selected) Then
    ACanvas.Brush.Color := clInfoBk;  }

  If (AViewInfo.Item.SortOrder <> soNone) Then
    ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];
end;

procedure TfrmConsultaCxGrid.cxConsultaViewDataControllerFilterBeforeChange(
  Sender: TcxDBDataFilterCriteria; ADataSet: TDataSet;
  const AFilterText: string);
begin
  If (Not blnLeuTudo) And (Not blnIniciando) And
     (Not SameText(strLasFil, AFilterText)) Then
  Begin
    pResetaTemporizador;
  End;

  Try
    If AnsiEndsText(' = ' + QuotedStr('-') + ')', AFilterText) Then
      Exit;

    ADataSet.Filter   := AFilterText;
    ADataSet.Filtered := Not fEmptyStr(ADataSet.Filter);
    strLasFil := AFilterText;
  Except
    ADataSet.Filtered := False;
  End;

end;

procedure TfrmConsultaCxGrid.pResetaTemporizador;
begin
  tmrFiltro.Enabled := False;
  tmrFiltro.Enabled := True;
end;

procedure TfrmConsultaCxGrid.cxConsultaViewDataControllerGroupingChanged(
  Sender: TObject);
begin
  pCtrlEnd(False);
end;

procedure TfrmConsultaCxGrid.cxConsultaViewDataControllerSortingChanged(
  Sender: TObject);
begin
  If (Not blnIniciando) And (Not blnLeuTudo) And (intLasPac <> 0) Then
    pAtualiza(tcpOrdemFiltro, strLasFil);
end;

procedure TfrmConsultaCxGrid.cxConsultaViewDblClick(Sender: TObject);
begin
  If blnSimples And (Not cdsConsulta.IsEmpty) Then
    btnConfirma.Click;
end;

procedure TfrmConsultaCxGrid.cxConsultaViewKeyPress(Sender: TObject; var Key: Char);
begin
  If (Key = #13) And (Not cdsConsulta.IsEmpty) Then
    btnConfirma.Click;
end;

procedure TfrmConsultaCxGrid.cxConsultaViewMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  If (Not blnSimples) And (ssCtrl In Shift) Then
  Begin
    pAddListaQuery;
    cxConsultaView.DataController.Refresh;
  End;
    
end;

procedure TfrmConsultaCxGrid.cxConsultaViewSelectionChanged(
  Sender: TcxCustomGridTableView);
begin
  pAtualizaDados;
end;

procedure TfrmConsultaCxGrid.cxConsultaViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  If Assigned(objConsulta) Then
    AStyle := objConsulta.fGetCellStyle(cxConsultaView, ARecord, AItem, cdsConsulta);
end;

procedure TfrmConsultaCxGrid.FormActivate(Sender: TObject);
begin
  pSetFocus(cxConsulta);
end;

procedure TfrmConsultaCxGrid.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TFuncoesCXGrid.pSalvarView(cxConsultaView, fGetChaveConsulta, cdsConsulta);
end;

procedure TfrmConsultaCxGrid.FormCreate(Sender: TObject);
begin
  pAfterAtualiza  := Nil;

  Try
    tmrFiltro.Interval := fCfgSis('TMRFIL', varInteger);
  Except
    tmrFiltro.Interval := TMR_DEFAULT;
  End;

  blnPrimeiraVez := True;
  blnLeuTudo  := False;
  blnConfirma := False;

  stlSQL      := TStringList.Create;
  stlCampos   := TStringList.Create;
  stlOrdem    := TStringList.Create;

  sltCamDta   := TStringList.Create;
  sltCamFlt   := TStringList.Create;

  qryConsulta.Connection    := Database;
  cdsConsulta.PacketRecords := INTPACREC;

  strLasFil := '';
end;

procedure TfrmConsultaCxGrid.FormDestroy(Sender: TObject);
begin
  FreeAndNil(stlSQL);
  FreeAndNil(stlCampos);
  FreeAndNil(stlOrdem);
  FreeAndNil(sltCamDta);
  FreeAndNil(sltCamFlt);

  If Assigned(stlListSelecao) Then
    FreeAndNil(stlListSelecao);
end;

Function TfrmConsultaCxGrid.fRetChaveLista: String;
Begin
  Result := cdsConsulta.Fieldbyname(strCodBusca).AsString;
End;

function TfrmConsultaCxGrid.fInLista(strChave: String): Boolean;
begin
  If stlListselecao <> Nil Then
    Result := (stlListselecao.IndexOf(strChave) > -1)
  Else
    Result := False;   
end;

procedure TfrmConsultaCxGrid.pAddListaQuery;
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
      stlListSelecao.Delete(intIndex);
    End
    Else
    Begin
      stlListSelecao.Add(strAuto);
    End;
  End;
end; {AddListaQuery}

Function TfrmConsultaCxGrid.fGetNextPacket: Integer;
Begin
  If blnLeuTudo Then
    Result := 0
  Else
  Begin
    Result := cdsConsulta.GetNextPacket;

    blnLeuTudo := (Result < cdsConsulta.PacketRecords) And
                  fEmptyStr(strLasFil);
  End;
End;

procedure TfrmConsultaCxGrid.pProximoPacote;
Begin
  If cdsConsulta.Active And
     (cdsConsulta.RecNo + INTPACREC > cdsConsulta.RecordCount) And
     (Not blnLeuTudo) Then
  Begin
    intLasPac := fGetNextPacket;

    If intLasPac > 0 Then
      pAtualizaDados;
  End;
End;

procedure TfrmConsultaCxGrid.pCtrlEnd(blnProMsg: Boolean);
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
    Abort;
  End;
End;

function TfrmConsultaCxGrid.fCheckParent(Sender, Parent: TWinControl): Boolean;
begin
  If Sender.Parent = nil Then
    Result := False
  Else If Sender.Parent = Parent Then
    Result := True
  Else
    Result := fCheckParent(Sender.Parent, Parent);
end;

procedure TfrmConsultaCxGrid.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  Case Key Of
    VK_F3    : TFuncoesCXGrid.pProximoFiltro(cxConsultaView);
    VK_ESCAPE: btnSair.Click;
    VK_PGDOWN,
    VK_DOWN:   pProximoPacote;
    VK_END :   If ssCtrl In Shift Then
                 pCtrlEnd(True);
    Else       If Assigned(objFrmPnl) And objFrmPnl.blnTemPan Then
                 objFrmPnl.pKeyDown(Key, Shift);
  End;

  If (Not blnSimples) And ((Key In [VK_UP,VK_DOWN]) And (ssShift In Shift)) Then
  Begin
    If fCheckParent(ActiveControl, cxConsulta) Then
      pAddListaQuery;
  End;

end;

procedure TfrmConsultaCxGrid.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If cxConsultaView.Focused And
     Assigned(cxConsultaView.Controller.FocusedColumn) And
     Assigned(cxConsultaView.Controller.FocusedColumn.DataBinding) And
     Assigned(cdsConsulta.FieldByName(cxConsultaView.Controller.FocusedColumn.DataBinding.FilterFieldName)) And
     (cdsConsulta.FieldByName(cxConsultaView.Controller.FocusedColumn.DataBinding.FilterFieldName).DataType in [ftFloat, ftCurrency, ftBCD] ) And
     (CharInSet(Key, ['e','E'])) Then
    Key := #0;
end;

procedure TfrmConsultaCxGrid.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  Case Key Of
    VK_PGDOWN,
    VK_DOWN,
    VK_PRIOR,
    VK_UP    : pAtualizaDados;
  End;

end;

procedure TfrmConsultaCxGrid.FormPaint(Sender: TObject);
begin
  If blnPrimeiraVez Then
  Begin
    blnPrimeiraVez := False;
    Keybd_Event(VK_F2, 0, 0, 0);
  End;
end;

function TfrmConsultaCxGrid.fGetChaveConsulta: String;
begin
  Result := strNomForm + '.' + StringReplace(strTitPesq, ' ', '', [rfReplaceAll]) + '.cxConsultaViewDados';
end;


procedure TfrmConsultaCxGrid.FormShow(Sender: TObject);
  Var
    blnLoadView: Boolean;
    intRecNo: Integer;
begin
  blnIniciando := True;

  pAtualiza(tpcVazio);

  TFuncoesCXGrid.pSalvarEstado(cxConsultaView, 'Software\Citel');
  blnLoadView := TFuncoesCXGrid.fCarregarView(cxConsultaView, fGetChaveConsulta, cdsConsulta, intRecNo);

  If (Not cdsConsulta.Active) Or cdsConsulta.IsEmpty Then
    pAtualiza(tcpPrimeira, strLasFil);

  TFuncoesCXGrid.pFocoNoFiltro(cxConsultaView, stlOrdem, '', False);

  blnIniciando := False;

  If Not blnLoadView Then
    cxConsultaView.ApplyBestFit;

  If Assigned(objFrmPnl) And objFrmPnl.blnTemPan Then
  Begin
    objFrmPnl.pCriaForm(Self, pgcRodape, cdsConsulta);
  End
  Else
    pgcRodape.Visible := False;

  blnMultiSelecao   := Not blnSimples;
  btnLimpar.Visible := blnMultiSelecao;

  If Not blnSimples Then
  Begin
  //  cxConsultaView.OptionsSelection.MultiSelect := True;
    pnlLegenda.Visible := True;

    stlListSelecao := TStringList.Create;
  End Else
  Begin
    stlListSelecao := Nil;
  End;

  Try
    If (intRecNo > 0) And (intRecNo <= cdsConsulta.RecordCount) Then
      cdsConsulta.RecNo := intRecNo;
  Except

  End;

  pAtualizaDados;

end;

Procedure TfrmConsultaCxGrid.pAtualizaDados;
Begin
  Try
    If Assigned(objFrmPnl) And Assigned(objFrmPnl.prcAtualizaDados) Then
      objFrmPnl.prcAtualizaDados;

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
      pMensagensErro(E.Message, 'TfrmConsultaCxGrid.pAtualizaDados');
    End;
  End;
End;

Function TfrmConsultaCxGrid.fRetOrderBy: String;
  Var
    intIndice: Integer;
Begin
  Result := '';

  With cxConsultaView Do
  Begin

    If SortedItemCount > 0 Then
    Begin
      Result := ' ORDER BY ';

      For intIndice := 0 To SortedItemCount - 1 Do
        If SortedItems[intIndice].SortOrder <> soNone Then
        Begin
          Result := Result + ' ' + SortedItems[intIndice].Caption;

          If SortedItems[intIndice].SortOrder = soDescending Then
            Result := Result + ' DESC ';

          If intIndice <> SortedItemCount - 1 Then
            Result := Result + ',';
        End;

      Result := Result + ', AUTOINCREM';
    End;

  End;
End;

procedure TfrmConsultaCxGrid.pSetaNomeColunas;
  Var
    intIndice: Integer;
Begin
  For intIndice := 0 To cdsConsulta.FieldCount - 1 Do
  Begin
    If (intIndice <= stlCampos.Count - 1) Then
      cdsConsulta.Fields[intIndice].DisplayLabel := stlCampos[intIndice]
    Else
      cdsConsulta.Fields[intIndice].Visible := False;
  End;

  For intIndice := 0 To cxConsultaView.ColumnCount - 1 Do
    If cdsConsulta.FindField(cxConsultaView.Columns[intIndice].DataBinding.FieldName) = Nil Then
      cxConsultaView.Columns[intIndice].Visible := False;
End;

Function TfrmConsultaCxGrid.fCampoToSubConsulta(strSQL: String;
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

Function TfrmConsultaCxGrid.fResolveConflito(strSQL: String): String;
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

procedure TfrmConsultaCxGrid.pCarregaCamposData;
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

Function TfrmConsultaCxGrid.fCorrigeCampoData(strFilter: String; Var blnAbortar: Boolean): String;
  Var
    intIndice,
    intPosCam,
    intPosQte: Integer;
    strValDta1,
    strValDta2: String;
Begin
  blnAbortar := False;

  Result := strFilter;

  For intIndice := 0 To sltCamDta.Count - 1 Do
  Begin

    intPosCam := Pos(sltCamDta[intIndice], Result);

    If intPosCam > 0 Then
    Begin
      intPosCam := intPosCam + Length(sltCamDta[intIndice]) +  4;

      strValDta1 := Copy(Result, intPosCam, 10);

      intPosQte := Pos('''', strValDta1);

      If intPosQte > 0 Then
        strValDta1 := LeftStr(strValDta1, Pred(intPosQte));

      strValDta2 := FormatDateTime('YYYY-MM-DD', StrToDateDef(strValDta1, 0) );

      (********************************************************************)
      (* QUEBRA GALHO. A PESQUISA POR DATA NAO ESTAVA FUNCIONANDO.        *)
      (* QUANDO ESTA DIGITANDO A DATA E UMA NOVA CONSULTA É CHAMADA       *)
      (* A GRID TRANSFORMA A STRING DIGITADA EM DATA E APOS A CONSULTA    *)
      (* JOGA NOVAMENTE NO CAMPO DE FILTRO DA DATA, COMO A DATA AINDA NAO *)
      (* ESTA COMPLETA O USUARIO NAO CONSEGUE ACABAR DE DIGITAR A DATA    *)
      (*****************************************************************LA*)

      If strValDta2 < '1901-01-01' Then
        blnAbortar := True;

      Result := AnsiReplaceStr(Result, strValDta1, strValDta2)

    End;

  End;

End;

Function TfrmConsultaCxGrid.fCorrigeCampoFloat(strFilter: String): String;
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
          ',' : Result[intPosCam] := '.';
          '''': inc(intQtdQuote);
        End;

        inc(intPosCam);
      End;

    End;

  End;

End;

Function TfrmConsultaCxGrid.fCorrigeFiltro(strFilter: String; Var blnAbortar: Boolean): String;
Begin
  Result := fCorrigeCampoData(strFilter, blnAbortar);
  Result := fCorrigeCampoFloat(Result);
End;

procedure TfrmConsultaCxGrid.pAtualiza(tpcTipCon: TTipoConsulta; strFilter: String = '');
  Var
    strSqlAux: String;
    intIndice: Integer;
    blnAbortar: Boolean;
begin
  Try
   If Not fEmptyStr(strFilter) Then
   Begin
     strFilter := fCorrigeFiltro(strFilter, blnAbortar);

     If blnAbortar Then
       Exit;
   End;

    strSqlAux := '';

    Screen.Cursor := crSQLWait;

    qryConsulta.DisableControls;
    cdsConsulta.DisableControls;

    cdsConsulta.Close;

    If (tpcTipCon <> tpcVazio) Then
      strLasFil := strFilter;

    For intIndice := 0 To stlSQL.Count - 1 Do
    Begin
      strSqlAux := strSqlAux + ' ' + fCampoToSubConsulta(stlSQL[intIndice], True);

      If AnsiStartsStr('WHERE', Trim(stlSQL[intIndice])) Then
      Begin
        Case tpcTipCon Of
          tpcVazio: strSqlAux := strSqlAux + ' AND FALSE ';
        End;

        If Not fEmptyStr(strFilter) Then
        Begin
          strFilter := fResolveConflito(strFilter);

          strSqlAux := strSqlAux + ' AND ' + fCampoToSubConsulta(strFilter, False) + ' ';
        End;
      End;
    End;

    strSqlAux := strSqlAux + fRetOrderBy;

    If fValidaSelect(strSqlAux, tpcTipCon) Then
    Begin
      With qryConsulta Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSqlAux);
        Open;
      End;

      pSetaClient(qryConsulta);
      cdsConsulta.Open;
      cdsConsulta.FieldByName('AUTOINCREM').Visible := False;

      pSetaNomeColunas;

      pSetaMascaras;

      pAlinhaCamposNumericos;

      Case tpcTipCon Of
        tpcVazio: Begin
                    cxConsultaView.DataController.CreateAllItems;
                    pCarregaCamposData;
                  End;
      End;

      intLasPac  := -1;

      If (tpcTipCon <> tpcVazio) Then
        intLasPac := fGetNextPacket;

      qryConsulta.EnableControls;
      cdsConsulta.EnableControls;

      pAtualizaDados;

      Screen.Cursor := crDefault;
    End
    Else
      Screen.Cursor := crDefault;

    If Assigned(pAfterAtualiza) Then
      pAfterAtualiza(cdsConsulta);

  Except
    On E: Exception Do
      Raise;
  End;
end;

procedure TfrmConsultaCxGrid.pSetaArrMascaras(arrCampos: TarrCampos; prcDisTxt: TprcDisplayText);
  Var
    intIndice: Integer;
Begin
  For intIndice := Low(arrCampos) To High(arrCampos) Do
  Begin
    If cxConsultaView.GetColumnByFieldName(arrCampos[intIndice]) <> Nil Then
      cxConsultaView.GetColumnByFieldName(arrCampos[intIndice]).OnGetDisplayText := prcDisTxt;
  End;
End;

procedure TfrmConsultaCxGrid.pSetaMascaras;
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

Function TfrmConsultaCxGrid.fRetDisplayFormat(strCampo: String): String;
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

procedure TfrmConsultaCxGrid.pAlinhaCamposNumericos;
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

end.
