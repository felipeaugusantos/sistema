unit untImpEtiLoteDoProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, untZClient,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, EditFocus, Vcl.Mask, MaskEditFocus, System.AnsiStrings, untTypesSistema,
  TypesRel, cxCurrencyEdit, cxSpinEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog, Vcl.Grids,
  Vcl.DBGrids, Datasnap.DBClient, Vcl.CheckLst;

type
  TfrmImpEtiLoteDoProduto = class(TfrmPaiSimples)
    pnlContFiltros: TPanel;
    cxDadostv: TcxGridDBTableView;
    cxDadosLvl: TcxGridLevel;
    cxDados: TcxGrid;
    dtsDados: TDataSource;
    pnlBotoesImp: TPanel;
    btnConfirma: TBitBtnLocked;
    btnSairImp: TBitBtnLocked;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl2: TLabel;
    lbl9: TLabel;
    lblLocFis: TLabel;
    lblLocFin: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    edtRefere: TEditFocus;
    edtCodFor: TEditFocus;
    edtNumLot: TEditFocus;
    edtLocFis: TEditFocus;
    edtNomFor: TEditFocus;
    edtLocFisFin: TEditFocus;
    pnlQtdEti: TPanel;
    lblQtdEtq: TLabel;
    edtQtdEtq: TEditFocus;
    edtLinGruFin: TEditFocus;
    mskLinGruFin: TMaskEditFocus;
    btnConfirmaFiltro: TBitBtnLocked;
    btnLimFil: TBitBtnLocked;
    pnlFiltros: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtRefFin: TEditFocus;
    cxDadosNUMLOT: TcxGridDBColumn;
    cxDadosCODITE: TcxGridDBColumn;
    cxDadosDESITE: TcxGridDBColumn;
    cxDadosLOCFIS: TcxGridDBColumn;
    cxDadosSALDOS: TcxGridDBColumn;
    cxDadosQTDETI: TcxGridDBColumn;
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
    rdgSaldo: TRadioGroup;
    cxDadostvR_U_A_: TcxGridDBColumn;
    cxDadostvPREDIO: TcxGridDBColumn;
    cxDadostvANDAR_: TcxGridDBColumn;
    cxDadostvAPARTA: TcxGridDBColumn;
    pnlDatas: TPanel;
    gpb1: TGroupBox;
    lbl1: TLabel;
    Label1: TLabel;
    lblEmpresa: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    lblTabPre: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    mskHraIni: TMaskEditFocus;
    mskHraFin: TMaskEditFocus;
    clbPreTab: TCheckListBox;
    pnlCampos: TPanel;
    rdgPreAlt: TRadioGroup;
    pnlLegenda: TPanel;
    shpLegenda: TShape;
    Label4: TLabel;
    lblOrdenandoPor: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure btnLimFilClick(Sender: TObject);
    procedure btnConfirmaFiltroClick(Sender: TObject);

    procedure edtCodMarExit(Sender: TObject);
    procedure mskLinGruExit(Sender: TObject);
    procedure mskLinGruFinExit(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);

    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruFinKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumLotKeyPress(Sender: TObject; var Key: Char);

    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure btnSairImpClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxDadostvKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxDadosQTDETIGetPropertiesForEdit(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure cxDadostvCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure edtCodLseExit(Sender: TObject);
    procedure edtCodLseKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
  Protected
    cdsDados: TZClient;
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  private
    arrCodLse,
    arrCodIte,
    arrCodFor,
    arrCodMar: TConsultasArray;
    strCodIte,
    strCodFor,
    strPreTab,
    strCodMar,
    strNumLot,
    strEtiLop: string;
    intOpcaoOrdenacao: Integer;
    FblnEscondeFiltros,
    FblnFilDat,
    FblnFilHor: Boolean;
    tpAltPreEti : TTipoAltPreEti;
    arrCodEmp: TConsultasArray;
    blnEtiEmp: Boolean;

    function  fTemQtdEtiMarcada(blnLimparConsulta: boolean = True): Boolean;
    function  fSQLLoteDoProduto(blnVazio :Boolean = False; strOrdBy: String = ''): String;
    procedure pAtribuirParametros;
    procedure pCarregarListaLoteEQuantidades(var ArrLoteProdutoEtiq: TArrLoteProdutoEtiq);
    procedure SetblnEscondeFiltros(const Value: Boolean);
    procedure pSetaCampos;
    { Private declarations }
  public
    blnNaoImprimirADefinir: Boolean;
    arrNumLot: TConsultasArray;
    property blnEscondeFiltros: Boolean read FblnEscondeFiltros write SetblnEscondeFiltros;

    { Public declarations }
  end;


implementation

uses
 untFuncoesConsulta, untConsultas, untFuncoesSimples,
  untFuncoesRelatorios, untFuncoesEtiquetas, untCfgLocFis;

{$R *.dfm}

procedure TfrmImpEtiLoteDoProduto.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodIte);
  pSetaCodLse(edtCodLse);
end;

procedure TfrmImpEtiLoteDoProduto.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsDados);

end;

procedure TfrmImpEtiLoteDoProduto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
    btnSairImp.Click
  Else If (Key  = VK_F4) and (pnlContFiltros.Visible) Then
    btnLimFil.Click
  Else If (Key = VK_F5) And (pnlContFiltros.Visible) Then
    btnConfirmaFiltro.Click
  Else If Key = VK_F10 Then
    btnConfirma.Click;
end;

procedure TfrmImpEtiLoteDoProduto.FormShow(Sender: TObject);
begin
  inherited;
  strEtiLop := fCfgSis('ETILOP', varString);
  lblLocFis.Visible := not fUsaRotinaWMS();
  edtLocFis.Visible := not fUsaRotinaWMS();
  lblLocFin.Visible := not fUsaRotinaWMS();
  edtLocFisFin.Visible := not fUsaRotinaWMS();
  pnlWms.Visible    := fUsaRotinaWMS();
  cxDadostvR_U_A_.Visible := fUsaRotinaWMS();
  cxDadostvPREDIO.Visible := fUsaRotinaWMS();
  cxDadostvANDAR_.Visible := fUsaRotinaWMS();
  cxDadostvAPARTA.Visible := fUsaRotinaWMS();
  intOpcaoOrdenacao:= 0;
  blnEtiEmp := fCfgSis('ETIEMP', varBoolean);

  If (fUsaRotinaWMS()) Then
  Begin
    pnlFiltros.Height := pnlFiltros.Height - edtLocFis.Height - 1;
    pSetaCampos;
  End;

  strPreTab := 'NNNNNNN';

  cdsDados := TZClient.Create(Nil, fSQLLoteDoProduto(True));

  pAtribuirParametros;
  cdsDados.fAbreClient(True, 'FormCreate');
  dtsDados.DataSet := cdsDados;

  If PnlContFiltros.Visible Then
    pSetFocus(mskLinGru)
  Else
  Begin
    pSetFocus(cxDados);
    btnConfirmaFiltro.Click;
  End
end;

procedure TfrmImpEtiLoteDoProduto.btnLimFilClick(Sender: TObject);
var
  I: Integer;
begin
  inherited;
  mskLinGru.Clear;
  edtDesGru.Clear;
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtCodMar.Clear;
  edtDesMar.Clear;
  edtRefere.Clear;
  edtCodFor.Clear;
  edtNumLot.Clear;
  edtLocFis.Clear;
  edtNomFor.Clear;
  edtLocFisFin.Clear;
  edtQtdEtq.Clear;
  edtLinGruFin.Clear;
  mskLinGruFin.Clear;
  edtCodLse.Clear;
  edtDesLse.Clear;
  edtRuaIni.Clear;
  edtRuaFin.Clear;
  edtAndarIni.Clear;
  edtAndarFin.Clear;
  edtPredioIni.Clear;
  edtPredioFin.Clear;
  edtApartamentoIni.Clear;
  edtApartamentoFin.Clear;
  intOpcaoOrdenacao:= 0;
  mskDtaIni.Clear;
  mskDtaFin.Clear;
  mskHraIni.Clear;
  mskHraFin.Clear;
  edtCodEmpresa.Clear;

  For I := 0 To clbPreTab.Items.Count - 1 Do
    clbPreTab.Checked[I] := False;

end;

procedure TfrmImpEtiLoteDoProduto.btnSairImpClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmImpEtiLoteDoProduto.cxDadosQTDETIGetPropertiesForEdit(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  If Not blnNaoImprimirADefinir Then
    Exit;
  cxDadosQTDETI.Options.Editing := Not (cdsDados.FieldByName('NUMLOT').AsString = 'A DEFINIR');
  inherited;

end;

procedure TfrmImpEtiLoteDoProduto.cxDadostvCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (Sender.DataController.Values
               [AViewInfo.GridRecord.RecordIndex, cxDadosQTDETI.Index]) > 0 Then
  Begin
    ACanvas.Brush.Color := clMoneyGreen;
    ACanvas.Font.Color  := clBlack;
  End

{    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVendaViewITESEL.Index]) = 'S' Then
    Begin
      If AViewInfo.Selected Then
      Begin
        ACanvas.Brush.Color := clHighlight;
        ACanvas.Font.Color  := clLime;
      End
      Else
        ACanvas.Brush.Color := clMoneyGreen;
    End;}

end;

procedure TfrmImpEtiLoteDoProduto.cxDadostvKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = 13 Then
     cxDadosQTDETI.FocusWithSelection;
end;

procedure TfrmImpEtiLoteDoProduto.btnConfirmaClick(Sender: TObject);
var
  prmDllEtq: TParamDllEtiquetas;
  ArrNomEti: TStringArray;
  intOpcao : Integer;
  strLayout: String;
begin
  inherited;
  If Not fTemQtdEtiMarcada Then
  Begin
    pMensagemOK('Será preciso selecionar ao menos uma etiqueta para ser impressa.');
    Exit;
  End;
  prmDllEtq := TParamDllEtiquetas.Create;
  prmDllEtq.strCodEmp := ShortString(String(VS_strCodEmp));

  If fEmptyStr(strEtiLop) Then
  Begin
    SetLength(ArrNomEti, 0);
    pAddDados(ArrNomEti, 'Laser');
    pAddDados(ArrNomEti, 'Argox');
    intOpcao := fGetMenu('Escolha o Modelo:', ArrNomEti, 1, True);
    Case intOpcao Of
      1: prmDllEtq.tpeTipEtq := tpeLoteProduto;
      2: prmDllEtq.tpeTipEtq := tpeLoteProdutoArgox;
    Else
      Exit;
    End;
  End
  Else
    prmDllEtq.tpeTipEtq := IIf(strEtiLop = 'L', tpeLoteProduto, tpeLoteProdutoArgox);

  If blnEtiEmp Then
  Begin
    strLayout := IIf(strEtiLop = 'L',
                     VarToStrDef(fCampoTabela('LAY_RELFR3', 'LAYETI', ['LAY_TIPLAY','LAY_CODEMP', 'LAY_PADRAO'], ['94', VS_strCodEmp, 'S']), ''),
                     VarToStrDef(fCampoTabela('LAY_RELFR3', 'LAYETI', ['LAY_TIPLAY','LAY_CODEMP', 'LAY_PADRAO'], ['96', VS_strCodEmp, 'S']), ''));
  End
  Else
  Begin
    strLayout := IIf(strEtiLop = 'L',
                     VarToStrDef(fCampoTabela('LAY_RELFR3', 'LAYETI', ['LAY_TIPLAY', 'LAY_PADRAO'], ['94', 'S']), ''),
                     VarToStrDef(fCampoTabela('LAY_RELFR3', 'LAYETI', ['LAY_TIPLAY', 'LAY_PADRAO'], ['96', 'S']), ''));
  End;

  if fEmptyStr(strLayout) then
  begin
    pMensagemOk('Não existe layout configurado para essa etiqueta ( CFG_ETILOP = '+QuotedStr(strEtiLop)+' )');
  end
  else
  begin
    prmDllEtq.strNomFrm := 'frmImpEtiLoteDoProduto';
    pCarregarListaLoteEQuantidades(prmDllEtq.ArrLoteProdutoEtiq);
    fImprimeEtiqueta(prmDllEtq, 'fImprimeEtiquetasLoteProduto');
    pMensagemOk('Impressão Concluída.');
  end;

  FreeAndNil(prmDllEtq);
  edtQtdEtq.Text := '0';
  btnConfirmaFiltroClick(Sender);

end;

procedure TfrmImpEtiLoteDoProduto.btnConfirmaFiltroClick(Sender: TObject);
var
  strOrdBy: String;
begin
  strOrdBy:= '';
  If fEmptyStr(edtQtdEtq.Text) Then
  Begin
    pMensagemOk('A Quantidade de Etiquetas deve ser preenchido!');
    Exit;
  End;

  If fVerificaCampos Then
  begin

    If intOpcaoOrdenacao = 0 Then
      intOpcaoOrdenacao:= fMensagem('ATENÇÃO!', 'Selecione a ordem da impressão:', ['&Desc. Produto', '&Loc. Fisica', '&Ordem Sel. Grid'], 1);

    If intOpcaoOrdenacao > 0 Then
    Begin
      Case intOpcaoOrdenacao Of
        1:
          Begin
            strOrdBy:= ' ORDER BY CADITE.ITE_DESITE ASC';
            lblOrdenandoPor.Caption := 'Ordenando por descrição';
          End;
        2:
          Begin
            strOrdBy:= ' ORDER BY CADLOT.LOT_LOCFIS ASC';
            lblOrdenandoPor.Caption := 'Ordenando por loc. fís.';
          End;
        3:
          Begin
            strOrdBy:= '';
            lblOrdenandoPor.Caption := '';
          End;

      End;

    End;

    cdsDados.qryQuery.SQL.Text := fSQLLoteDoProduto(False, strOrdBy);
    pAtribuirParametros;

    cdsDados.fAbreClient(True, 'btnConfirmaFiltroClick', False, True);
    cxDadostv.ApplyBestFit;
  end;
end;

function TfrmImpEtiLoteDoProduto.fTemQtdEtiMarcada(blnLimparConsulta: boolean = True): Boolean;
begin
  cdsDados.DisableControls;
  Try
    cdsDados.Filtered := False;
    cdsDados.Filter   := 'QTDETI >= 1';
    cdsDados.Filtered  := True;
    Result := cdsDados.RecordCount > 0;
  Finally
    If blnLimparConsulta Then
      cdsDados.Filtered := False;
    cdsDados.EnableControls;
  End;
end;

function TfrmImpEtiLoteDoProduto.fSQLLoteDoProduto(blnVazio :Boolean = False; strOrdBy: String = ''): String;
var
  i,PosIni: Integer;
begin
  Result := Result + 'SELECT  ';
  Result := Result + '       CADITE.ITE_CODITE AS CODITE, ';
  Result := Result + '       CADITE.ITE_DESITE AS DESITE, ';
  Result := Result + '       CADLOT.LOT_NUMLOT AS NUMLOT, ';
  Result := Result + '       CADLOT.LOT_LOCFIS AS LOCFIS, ';
  Result := Result + '       CADLOT.LOT_SALDOS AS SALDOS, ';
  Result := Result + '       CADLOT.AUTOINCREM AS AUTINC, ';
  Result := Result + '       LOC_R_U_A_ AS R_U_A_, ';
  Result := Result + '       LOC_PREDIO AS PREDIO, ';
  Result := Result + '       LOC_ANDAR_ AS ANDAR_, ';
  Result := Result + '       LOC_APARTA AS APARTA, ';
  Result := Result + '       LOC_CODLOC AS BARLOC, ';


  If fEmptyStr(edtQtdEtq.Text) Then
    Result := Result + '     0 AS QTDETI '
  Else
    Result := Result + '      ' + edtQtdEtq.Text + ' AS QTDETI ';
  Result := Result + '  FROM CADLOT ';
  Result := Result + '  LEFT JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS AND LOC_CODEMP = LOT_CODEMP ';
  Result := Result + '  LEFT JOIN CADITE ON CADITE.ITE_CODITE = CADLOT.LOT_CODITE ';
  Result := Result + '  LEFT JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE AND ITEGER.ITE_CODEMP = CADLOT.LOT_CODEMP ';
  Result := Result + '  LEFT JOIN CADFOR ON CADITE.ITE_CODFOR = FOR_CODFOR ';

  If FblnFilDat Then
  Begin
    Result := Result + ' LEFT JOIN  (SELECT MAX(PREALT.ALT_DTAALT) AS ULTALT,               ';
    Result := Result + '                    MAX(PREALT.ALT_HORALT) AS HORALT,               ';
    Result := Result + '                                           PREALT.*                 ';
    Result := Result + '              FROM PREALT                                           ';
    Result := Result + '              WHERE PREALT.ALT_DTAALT BETWEEN :DTAINI AND :DTAFIN   ';
    Result := Result + '                AND PREALT.ALT_DTAALT IS NOT NULL                   ';
    If FblnFilHor Then
      Result := Result + '  AND (ADDTIME(ALT_DTAALT, ALT_HORALT) BETWEEN CONCAT(:DTAINI, " ", :HRAINI) AND CONCAT(:DTAFIN, " ", :HRAFIN, ":59"))';
    Result := Result +' GROUP BY PREALT.ALT_CODITE, PREALT.ALT_CODEMP ) TMPALT ON  ';
    Result := Result +'      TMPALT.ALT_CODITE = CADLOT.LOT_CODITE AND TMPALT.ALT_CODEMP = LOT_CODEMP';
  End;

  if blnVazio Then
    Result := Result + ' WHERE FALSE '
  Else
    Result := Result + ' WHERE CADLOT.LOT_CODEMP = :CODEMP ';

  {Filtro de Linha Grupo  Grupo}
  If Not fEmptyStr(mskLinGru.Text) Then
  Begin
    If RightStr(AnsiString(mskLinGru.Text), 2) = '000' Then
    Begin
      If Not fEmptyStr(mskLinGruFin.Text) Then
      Begin
        If RightStr(AnsiString(mskLinGruFin.Text),3) = '000' Then
          Result := Result + '  AND LEFT(CADITE.ITE_CODGRU,3) BETWEEN LEFT(:CODGRU,3) AND LEFT(:CODGRU2,3) '
        Else
          Result := Result + '  AND CADITE.ITE_CODGRU BETWEEN CONCAT(LEFT(:CODGRU,3),"000") AND :CODGRU2 ';
      End
      Else
        Result := Result + '  AND LEFT(CADITE.ITE_CODGRU,3) = LEFT(:CODGRU,3) ';
    End
    Else
    Begin
      If Not fEmptyStr(mskLinGruFin.Text) Then
      Begin
        If RightStr(AnsiString(mskLinGruFin.Text), 3) = '000' Then
          Result := Result + '  AND CADITE.ITE_CODGRU BETWEEN :CODGRU AND CONCAT(LEFT(:CODGRU2,3),"099") '
        Else
          Result := Result + '  AND CADITE.ITE_CODGRU BETWEEN :CODGRU AND :CODGRU2 ';
      End
      Else
        Result := Result + '  AND CADITE.ITE_CODGRU = :CODGRU ';
    End;
  End;

  If FblnFilDat Then
  Begin
    Case rdgPreAlt.ItemIndex Of
      0: tpAltPreEti := tpPrecoCusto;
      1: tpAltPreEti := tpPrecoVenda;
      2: tpAltPreEti := tpTodos;
    End;

    If tpAltPreEti = tpPrecoCusto Then
      Result := Result + ' AND ALT_CUSANT <> ALT_CUSATU '
    Else If (tpAltPreEti = tpPrecoVenda) Or (tpAltPreEti = tpTodos) Then
    Begin
      PosIni := Pos('S', strPreTab);
      For i := PosIni To 7 do
      Begin
        If (strPreTab[i] = 'S') then
        Begin
          If i <> PosIni Then
            Result := Result +  ' OR '
          Else
            Result := Result +  ' AND ( ';

          Result := Result + '          (ALT_VE' + IntToStr(i) + 'ANT <> ALT_VE' + IntToStr(i) + 'ATU)';
        End;
      End;
      If (tpAltPreEti = tpTodos) Then
        Result := Result + ' OR (ALT_CUSANT <> ALT_CUSATU) ';

      Result := Result + ' ) ';
    End;
  End;

  { PRODUTO }
  If Not fEmptyStr(edtCodIte.Text) Then
    Result := Result + fStrLocate(edtCodIte, arrCodIte, 'CADITE.ITE_CODITE', 'CODITE');

  { MARCA }
  If Not fEmptyStr(edtCodMar.Text) Then
    Result := Result + fStrLocate(edtCodMar, arrCodMar, 'CADITE.ITE_CODMAR', 'CODMAR');

  { REFERERNCIA }
  If Not fEmptyStr(edtRefere.Text) Then
    If (Not fEmptyStr(edtRefFin.Text)) Then
      Result := Result + ' AND LEFT(CADITE.ITE_REFERE, LENGTH(:MAIOR)) BETWEEN :REFERE AND :REFFIN '
    Else
      Result := Result + '  AND CADITE.ITE_REFERE LIKE :REFERE ';

  { FORNECEDOR }
  If Not fEmptyStr(edtCodFor.Text) Then
    Result := Result + fStrLocate(edtCodFor, arrCodFor, 'FOR_CODFOR', 'CODFOR');

  { LOTE }

  If Not fEmptyStr(edtNumLot.Text) Then
    Result := Result + fStrLocate(edtNumLot, arrNumLot, 'CADLOT.LOT_NUMLOT', 'NUMLOT');

  { LOCALIZACAO FISICA }
  If fUsaRotinaWMS Then
  Begin
    Result := Result + fStrLocate(edtCodLse, arrCodLse, 'LOC_CODLSE', 'CODLSE');

    If not fEmptyStr(edtRuaIni.Text) Then
    Begin
      If not fEmptyStr(edtRuaFin.Text) Then
      Begin
        Result := Result + ' AND LOC_R_U_A_ BETWEEN :RUAINI AND :RUAFIN '
      End
      Else
        Result := Result + ' AND LOC_R_U_A_ = :RUAINI ';
    End;

    If not fEmptyStr(edtPredioIni.Text) Then
    Begin
      If not fEmptyStr(edtPredioFin.Text) Then
      Begin
        Result := Result + ' AND LOC_PREDIO BETWEEN :PREINI AND :PREFIN '
      End
      Else
        Result := Result + ' AND LOC_PREDIO = :PREINI ';
    End;

    If not fEmptyStr(edtAndarIni.Text) Then
    Begin
      If not fEmptyStr(edtAndarFin.Text) Then
      Begin
        Result := Result + ' AND LOC_ANDAR_ BETWEEN :ANDINI AND :ANDFIN '
      End
      Else
        Result := Result + ' AND LOC_ANDAR_ = :ANDINI ';
    End;

    If not fEmptyStr(edtApartamentoIni.Text) Then
    Begin
      If not fEmptyStr(edtApartamentoFin.Text) Then
      Begin
        Result := Result + ' AND LOC_APARTA BETWEEN :APTINI AND :APTFIN '
      End
      Else
        Result := Result + ' AND LOC_APARTA = :APTINI ';
    End;

  End
  Else
  Begin
    If Not fEmptyStr(edtLocFis.Text) Then
    Begin
      If (Not fEmptyStr(edtLocFis.Text)) Then
        Result := Result + ' AND LEFT(CADLOT.LOT_LOCFIS, LENGTH(:MAIORLOC)) BETWEEN :LOCFIS AND :LOCFIN '
      Else
        Result := Result + '  AND CADLOT.LOT_LOCFIS LIKE :LOCFIS ';
    End;
  End;

  Case rdgSaldo.ItemIndex Of
    1 : Result := Result + ' AND LOT_SALDOS > 0 ';
    2 : Result := Result + ' AND LOT_SALDOS < 0 ';
  End;

  If Not(fEmptyStr(strOrdBy)) then
    Result := Result + strOrdBy;

End;

function TfrmImpEtiLoteDoProduto.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
var
  intCnt: Integer;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtCodFor) Then
      pDesmarcaLista(edtCodFor, arrCodFor)

    Else If (Sender = edtCodMar) Then
      pDesmarcaLista(edtCodMar, arrCodMar)

    Else If (Sender = mskLinGru) Then
      mskLinGruFin.Enabled := Not fEmptyStr(mskLinGru.Text)

    Else If (Sender = edtCodIte) Then
      pDesmarcaLista(edtCodIte, arrCodIte)
    Else If (Sender = edtNumLot) Then
    Begin
      pDesmarcaLista(edtNumLot, arrNumLot);
      If (edtNumLot.Text <> '+1') And (not (fEmptyStr(edtNumLot.Text))) Then
      Begin
        If fEmptyStr(fRetNumLoteConsulta(edtNumLot.Text)) Then
        Begin
          Result := False;
          pMensagemOk('Numero do Lote Inválido!');
          edtNumLot.Text := '';
        End;
      End;
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

    {*****************************************}
    {* VALIDA A DATA INICIAL E FINAL         *}
    {**************************************IV*}
    Else If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin
      edtCodEmpresa.Enabled := True;
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        mskDtaFin.Clear;
        mskDtaFin.Enabled := False;
        mskHraFin.Clear;
        mskHraFin.Enabled := False;
        edtCodEmpresa.Enabled := False;
        edtCodEmpresa.Clear;
        edtDesEmpresa.Clear;
      End
      Else
      Begin
        mskDtaFin.Enabled := True;
        mskHraFin.Enabled := True;
        If (Sender = mskDtaFin) Then
        Begin
        FblnFilDat := Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text));
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
            edtCodEmpresa.Enabled := False;
            edtCodEmpresa.Clear;
            edtDesEmpresa.Clear;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A Data Inicial deve ser menor que a Data Final!',['&O K']);
              Result := False;
              edtCodEmpresa.Enabled := False;
              edtCodEmpresa.Clear;
              edtDesEmpresa.Clear;
            End;
          End;
        End;
      End;
    End

    Else If (Sender = mskHraIni) And (Not fEmptyTime(mskHraIni.Text)) Then
    Begin
      FblnFilHor := Not fEmptyStr(fTiraCaracEspeciais(mskHraIni.Text));
      If (StrToTimeDef(mskHraIni.Text, -1) = -1) Then
      Begin
        fMensagem('ATENÇÃO!', 'A hora inicial informada é inválida!', ['&O k']);
        Result := False;
      End
      Else If (Not fEmptyTime(mskHraFin.Text)) And
         ((mskDtaIni.Text) = (mskDtaFin.Text)) And
         (StrToTime(mskHraIni.Text) >= StrToTime(mskHraFin.Text)) Then
      Begin
        fMensagem('','A Hora Inicial deve ser menor que a Hora Final!',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = mskHraFin) Then
    Begin
      If (fEmptyTime(mskHraFin.Text)) And (Not fEmptyTime(mskHraIni.Text)) Then
        fMensagem('ATENÇÃO!', 'A hora final deve ser preenchida!', ['&O k'])
      Else If (StrToTimeDef(mskHraFin.Text, -1) = -1) And (Not fEmptyTime(mskHraFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A hora final informada é inválida!', ['&O k']);
        Result := False;
      End
      Else If (Not (fEmptyTime(mskHraFin.Text))) And
           ((mskDtaIni.Text) = (mskDtaFin.Text)) And
           (StrToTime(mskHraIni.Text) >= StrToTime(mskHraFin.Text)) Then
      Begin
        fMensagem('','A Hora Inicial deve ser menor que a Hora Final!',['&O K']);
        Result := False;
      End;
    End

    {*****************************************}
    {* TABELA DE PREÇOS                      *}
    {**************************************IV*}
    else if (sender = clbPreTab) then
    begin

      if (not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
      begin
        strPreTab := 'NNNNNNN';
        for intCnt := 0 to clbPreTab.Count-1 do
        begin
          if clbPreTab.Checked[intCnt] then
          begin
            strPretab := Copy(strPretab,1, StrToInt(clbPreTab.Items[intCnt])-1)+
                         'S'+
                         Copy(strPretab, StrToInt(clbPreTab.Items[intCnt]), length(strPreTab)-StrToInt(clbPreTab.Items[intCnt]));
          end;
        end;

        if pos('S', strPreTab) = 0 then
        begin
          fMensagem('ATENÇÃO!', 'O campo Tabela de Preços deve haver pelo menos UMA selecionada!', ['&OK']);
          Result := False;
          pSetFocus(Sender);
        end;
      end;

    end

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

 End;

procedure TfrmImpEtiLoteDoProduto.pAtribuirParametros;
  Var
    strCodLse : String;
    intTabPre: Integer;
begin

   strPreTab := 'NNNNNNN';
   for intTabPre := 0 to clbPreTab.Count-1 do
   begin
     if clbPreTab.Checked[intTabPre] then
     begin
       strPretab := Copy(strPretab,1, StrToInt(clbPreTab.Items[intTabPre])-1)+
                         'S'+
                         Copy(strPretab, StrToInt(clbPreTab.Items[intTabPre]), length(strPreTab)-StrToInt(clbPreTab.Items[intTabPre]));
     end;
   end;



   If FblnFilDat Then
    Begin
      cdsDados.qryQuery.ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      cdsDados.qryQuery.ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskHraIni.Text,True,True,True,True)) Then
      cdsDados.qryQuery.ParamByname('HRAINI').AsString := mskHraIni.Text;

    If Not fEmptyStr(fTiraCaracEspeciais(mskHraFin.Text,True,True,True,True)) Then
      cdsDados.qryQuery.ParamByname('HRAFIN').AsString := mskHraFin.Text;

  If cdsDados.qryQuery.FindParam('CODEMP') <> Nil Then
    cdsDados.qryQuery.ParamByName('CODEMP').AsString := VS_strCodemp;

  If Not fEmptyStr(mskLinGru.Text) Then
    cdsDados.qryQuery.ParamByName('CODGRU').AsString := mskLinGru.Text;
  If Not fEmptyStr(mskLinGruFin.Text) Then
    cdsDados.qryQuery.ParamByName('CODGRU2').AsString := mskLinGruFin.Text;

  pSetaParam(edtNumLot.Text, arrNumLot    , strnumLot, 'NUMLOT', cdsDados.qryQuery);

  pSetaParam(edtCodIte.Text, arrCodIte    , strCodIte, 'CODITE', cdsDados.qryQuery);

  pSetaParam(edtCodMar.Text, arrCodMar    , strCodMar, 'CODMAR', cdsDados.qryQuery);

  { REFERENCIA }
  If Not fEmptyStr(edtRefere.Text) Then
  Begin
    If (Not fEmptyStr(edtRefFin.Text)) Then
    Begin
      cdsDados.qryQuery.ParamByName('REFERE').AsString := edtRefere.Text;
      cdsDados.qryQuery.ParamByName('REFFIN').AsString := edtRefFin.Text;
      If Length(edtRefere.Text) > Length(edtRefFin.Text) Then
        cdsDados.qryQuery.ParamByName('MAIOR').AsString := edtRefere.Text
      Else
        cdsDados.qryQuery.ParamByName('MAIOR').AsString := edtRefFin.Text;
    End
    Else
      cdsDados.qryQuery.ParamByName('REFERE').AsString := edtRefere.Text + '%';
  End;

  pSetaParam(edtCodFor.Text, arrCodFor, strCodFor , 'CODFOR', cdsDados.qryQuery);

  { LOCALIZACAO FISICA }
  If fUsaRotinaWMS Then
  Begin
    pSetaParam(edtCodLse.Text, arrCodLse, strCodLse, 'CODLSE', cdsDados.qryQuery);

    If cdsDados.qryQuery.FindParam('RUAINI') <> Nil Then
      cdsDados.qryQuery.ParamByName('RUAINI').AsString := edtRuaIni.Text;

    If cdsDados.qryQuery.FindParam('RUAFIN') <> Nil Then
      cdsDados.qryQuery.ParamByName('RUAFIN').AsString := edtRuaFin.Text;

    If cdsDados.qryQuery.FindParam('PREINI') <> Nil Then
      cdsDados.qryQuery.ParamByName('PREINI').AsString := edtPredioIni.Text;

    If cdsDados.qryQuery.FindParam('PREFIN') <> Nil Then
      cdsDados.qryQuery.ParamByName('PREFIN').AsString := edtPredioFin.Text;

    If cdsDados.qryQuery.FindParam('ANDINI') <> Nil Then
      cdsDados.qryQuery.ParamByName('ANDINI').AsString := edtAndarIni.Text;

    If cdsDados.qryQuery.FindParam('ANDFIN') <> Nil Then
      cdsDados.qryQuery.ParamByName('ANDFIN').AsString := edtAndarFin.Text;

    If cdsDados.qryQuery.FindParam('APTINI') <> Nil Then
      cdsDados.qryQuery.ParamByName('APTINI').AsString := edtApartamentoIni.Text;

    If cdsDados.qryQuery.FindParam('APTFIN') <> Nil Then
      cdsDados.qryQuery.ParamByName('APTFIN').AsString := edtApartamentoFin.Text;

  End
  Else
  Begin
    If Not fEmptyStr(edtLocFis.Text) Then
    Begin
      If (Not fEmptyStr(edtLocFisFin.Text)) Then
      Begin
        cdsDados.qryQuery.ParamByName('LOCFIS').AsString := edtLocFis.Text;
        cdsDados.qryQuery.ParamByName('LOCFIN').AsString := edtLocFisFin.Text;
        If Length(edtLocFis.Text) > Length(edtLocFisFin.Text) Then
          cdsDados.qryQuery.ParamByName('MAIORLOC').AsString := edtLocFis.Text
        Else
          cdsDados.qryQuery.ParamByName('MAIORLOC').AsString := edtLocFisFin.Text;
      End
      Else
        cdsDados.qryQuery.ParamByName('LOCFIS').AsString := edtLocFis.Text + '%';
    End;
  End;
end;

procedure TfrmImpEtiLoteDoProduto.pCarregarListaLoteEQuantidades(var ArrLoteProdutoEtiq: TArrLoteProdutoEtiq);
Var
  I: Integer;
begin
  cdsDados.DisableControls;
  Try
    If Not fTemQtdEtiMarcada(False) Then
      Exit;

    SetLength(ArrLoteProdutoEtiq, cdsDados.RecordCount);

    cdsDados.Last;
    for I := 0 to cdsDados.RecordCount - 1 do
    Begin
      ArrLoteProdutoEtiq[I].intQtdEti := cdsDados.FieldByName('QTDETI').AsInteger;
      ArrLoteProdutoEtiq[I].strAutInc := ShortString(cdsDados.FieldByName('AUTINC').AsString);
      cdsDados.Prior;
    End;


  Finally
    cdsDados.First;
    cdsDados.Filtered := False;
    cdsDados.EnableControls;
  End;
end;


procedure TfrmImpEtiLoteDoProduto.SetblnEscondeFiltros(const Value: Boolean);
begin
  FBlnEscondeFiltros := Value;
  pnlContFiltros.Visible := Not Value;
end;

procedure TfrmImpEtiLoteDoProduto.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar, edtDesMar, arrCodMar, fRetNomMarca, nil, 'da Marca');
end;

procedure TfrmImpEtiLoteDoProduto.mskLinGruExit(Sender: TObject);
begin
  If fEmptyStr(mskLinGru.Text) Then
    edtDesGru.Text := 'TODOS'
  Else
  Begin
    edtDesGru.Text := fRetNomeLinhaGrupo(mskLinGru.Text);
    If fEmptyStr(edtDesGru.Text) Then
    Begin
      fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
      mskLinGru.Clear;
      pSetFocus(mskLinGru);
    End;
  End;
end;

procedure TfrmImpEtiLoteDoProduto.mskLinGruFinExit(Sender: TObject);
begin
  If fEmptyStr(mskLinGruFin.Text) Then
    edtlinGruFin.Text := 'TODOS'
  Else
  Begin
    edtlinGruFin.Text := fRetNomeLinhaGrupo(mskLinGruFin.Text);
    If fEmptyStr(edtlinGruFin.Text) Then
    Begin
      fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
      mskLinGruFin.Clear;
      pSetFocus(mskLinGruFin);
    End;
  End;
end;

procedure TfrmImpEtiLoteDoProduto.edtCodIteExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodIte,edtDesIte, arrCodIte, nil, fRetNomProduto, 'do Produto');
end;

procedure TfrmImpEtiLoteDoProduto.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrCodEmp, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmImpEtiLoteDoProduto.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrCodEmp, False) Then
  Begin
    fValidaCampos(edtCodEmpresa, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmImpEtiLoteDoProduto.edtCodForExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrCodFor, fRetNomFornecedor, nil, 'do Fornecedor');
end;

procedure TfrmImpEtiLoteDoProduto.edtCodForKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrCodFor, False) Then
    If fValidaCampos(edtCodFor, True) Then
      Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmImpEtiLoteDoProduto.mskLinGruKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  If fPesqGrupo(Self, mskLinGru, edtDesGru, nil, Key, arrSel) Then
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmImpEtiLoteDoProduto.mskLinGruFinKeyPress(Sender: TObject; var Key: Char);
  var arrSel : TConsultasArray;
begin
  If Not fEmptyStr(mskLinGru.Text) Then
  Begin
    If fPesqGrupo(Self, mskLinGruFin, edtlinGruFin, nil, Key, arrSel) Then
      If fValidaCampos(mskLinGruFin, True) Then
        SelectNext(ActiveControl, True, True);
  End
  Else
    Key := #0;
end;

procedure TfrmImpEtiLoteDoProduto.edtCodIteKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrCodIte, False, nil, 'Consulta de Itens', '1') Then
  Begin
    fvalidaCampos(edtCodIte,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmImpEtiLoteDoProduto.edtCodLseExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodLse, edtDesLse, arrCodLse, nil, fRetLocSep, 'do local de separação');
end;

procedure TfrmImpEtiLoteDoProduto.edtCodLseKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqLocSep(Self, edtCodLse, edtDesLse, nil, key, arrCodLse, False) Then
  Begin
    If fValidaCampos(edtCodLSe, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmImpEtiLoteDoProduto.edtCodMarKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrCodMar, False) Then
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmImpEtiLoteDoProduto.edtNumLotKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqLoteItens(Self, edtNumLot, Nil, 0, Nil, Key, arrNumLot, False) Then
    If fValidaCampos(edtNumLot, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmImpEtiLoteDoProduto.pSetaCampos;
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

end.
