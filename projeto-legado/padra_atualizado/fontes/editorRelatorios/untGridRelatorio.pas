unit untGridRelatorio;

interface

uses
  Classes, SysUtils, Variants, untTypesSistema,
  Controls, StdCtrls, StrUtils, Printers, Graphics,
  UniClientDataSet, UniDataSetProvider,
  Uni, DB, untFuncoesSimples,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  untFuncEditorRel, untZClient, Math, Dialogs,
  cxGridDBTableView,
  cxGridCustomTableView,
  cxGraphics,
  cxMaskEdit,
  cxCustomData,
  cxGridTableView,
  cxStyles,
  cxGrid,
  cxFilter,
  cxEdit,
  cxGridCustomView,
  cxGridBandedTableView,
  cxGridDBBandedTableView,
  cxGridDBDataDefinitions,
  cxProgressBar,
  Forms,
  untFuncoesGenerica,
  fs_iinterpreter,
  untGeraFr3,
  untGravando,
  untGridBandedFrm,
  untGridFrm,
  untGridRelatResult,
  untModuloGrid,
  untRotinasGrid,
  BitBtnLockedIncrem,
  untPascalScriptRelatorio;

Const
  MAXREFCAM = 30;

Type
  TArrGridTableItem = Array Of Record
    cxiColuna: TcxCustomGridTableItem;
    strTitulo: String;
    stlCampos: TList;
  End;

  TArrFonteNomCam = Array Of Record
    strNomCam: string;
    strTipCam: string;
    strFntCnd: string;
    strFntCam: string;
    strFntOri: string;
  End;

  TArrFonteValida = Array Of Record
    strExpres: string;
    blnColore: Boolean;
  End;

  TDefFormula = Record
    strColuna,
    strFormula,
    strForExe,
    strFormat: String;

    fscScript: TfsScript;

    stlCampos  : TStringList;
    arrOperacao: Array[0..MAXREFCAM] Of TcxSummaryKind;
  End;

  TArrDefFormula = Array Of TDefFormula;

  TBotaoGrid = Class(TBitBtnLocked)
    private

    public
      strNomCam,
      strMarcado,
      strDesmarcado: String;

      constructor Create(AOwner: TComponent);  Reintroduce;
      destructor Destroy; override;
  End;

  TDadosRelatorio = Class
  Private
    FDados: TUniClientDataSet;

  Public
    constructor Create(ADados: TUniClientDataSet);

    Function FieldByName(FieldName: String): TField;
  End;

  TGridRelatorio = class(TComponent)
    private

      FMarcando,
      FMarcar: Boolean;
      FNomCam,
      FMarcado,
      FDesmarcado: String;

      tmrRefreshDados: TTimer;

      arrCabecalho: TArrCabecalhoGrid;

      FLastBand: TcxGridBand;

      objRotinasGrid: TRotinasGrid;

      FPais: TPais;

      FCoresColunas: TZClient;

      FGrupoCampos: Boolean;

      FGeraFr3: TGeraFR3;
      FcdsCampos: TUniClientDataSet;
      FSource : TDataSource;

      FcxConsulta: TcxGrid;

      FConsultaView: TcxGridDBTableView;
      FConsultaBandedView: TcxGridDBBandedTableView;

      FDataController: TcxGridDBDataController;

      FViewData: TcxGridViewData;

      FQuebras: TArrGridTableItem;
      FFonteNomCam: TArrFonteNomCam;
      FFonteValida: TArrFonteValida;

      FarrFormula: TArrDefFormula;

      FRecNo: Integer;
      FMensagemAposBeforePost: String;
      objScriptBeforePost: TPascalScriptRelatorio;

      Procedure pCopiaCabecalho(arrOrigem: TArrCabecalhoGrid; Var arrDestino: TArrCabecalhoGrid);

      procedure pConsultaViewEditKeyPress(Sender: TcxCustomGridTableView;
          AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);

      Function fSQLCoresColunas: String;

      Procedure pSetFooter(Value: Boolean);
      Procedure pSetGeraFR3(value: TGeraFR3);
      Procedure pLiberaQuebras;
      Procedure pLiberaFonteNomCam;
      Procedure pLiberaFonteValida;
      Procedure pLiberaFormulas;

      Function fGetColumnByFieldName(strNomCam: String): TcxGridDBColumn;
      Function fFocusedColumn: TcxGridDBColumn;
      Function fFocuseRecord: TcxCustomGridRecord;
      Function fPrimeiroTotal(strNomCam: String): Variant;
      Function fTotalGeral(strNomCam: String): Variant;

      Function fScriptValidate: String;
      Function fGetScriptValidate: String;

      Function fMarcaTodosPrg(cxProgesso: TcxProgressbar): Boolean;
      procedure pMarcaTodos(blnMarcar: Boolean; strNomCam, strMarcado, strDesmarcado, strScript: String);
      procedure pMarcarTodosClick(Sender: TObject);
      procedure pDesmarcarTodosClick(Sender: TObject);

      Procedure pCriaBotoesMarcarDesmarcarTodos;

      procedure pConsultaViewValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
      Procedure pMontaColunasGrid;

      Procedure pCriaQuebras;
      Procedure pMontaCabecalhoGrid;

      procedure pMontaLegenda;

      procedure pGetDisplayTextCNPJ(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);

      procedure pGetDisplayTextQuebra(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
      Procedure pLimpaExpressao(fscScript: TfsScript);

      Procedure pAtualizaStatus(strMensagem: String);

      Procedure pInsereFormula(strNomCam, strForTot: String);

      Procedure pMontaTotais;
      Procedure pMontaTotaisParaFormulas;

      procedure pCustomDrawCellColuna(
                  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
                  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);

      procedure pConsultaViewCustomDrawGroupCell(
                  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
                  AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);

      procedure pConsultaViewStylesGetFooterSummaryStyle(
                  AView: TcxGridTableView; ARow: TcxCustomGridRow; AColumn: TcxGridColumn;
                  AFooterGroupLevel: Integer; ASummaryItem: TcxDataSummaryItem;
                  var AStyle: TcxStyle);

      procedure pConsultaViewColumnCustomDrawCell(
                  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
                  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);

      procedure pConsultaViewColumnGetDisplayText(
                  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
                  var AText: string);

      procedure pFilterChanged(Sender: TObject);

      procedure pGroupSummaryGetText(Sender: TcxDataSummaryItem;
                   const [Ref] AValue: Variant; AIsFooter: Boolean; var AText: string);

      Procedure pConfiguraGrid;

      Procedure pCalculaTotaisFormula;

      Function fGetFlowPanel: TFlowPanel;

      Function fMontaGridPrg(prgProgresso: TCxProgressBar): Boolean;
      Function fGetMaxDataGroupIndex: Integer;
      Function fCalculaFormulaDefaultGroup(intIndexFormula, intLinha: Integer): Double;
      Function fCalculaFormulaSummary(intIndexFormula: Integer): Double;
      Function fGetIndexFormula(strNomCam: String): Integer;
      Function fRetNomeValorOpe(strNomCol: String; kinTipOpe: TcxSummaryKind): String;
      Function fExecutaExpressao(fscScript: TfsScript; strExpressao: String; Var blnErro: Boolean): Double;
      Function fTemSoma(strColuna: String; kinTipoSoma: TcxSummaryKind): Boolean;
      Function fCallIIF(Instance: TObject; ClassType: TClass; Const MethodName: String; Var Params: Variant): Variant;
      Function fInicializaScript: TfsScript;
      Function fTemGrupoDeCampos: Boolean;
      Function fTextQuebra(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord): String;
      Function fGetBanda(strNomBan: String;
                         intTipBan: Integer;
                         taAlinhamento: TAlignment = taCenter;
                         cxBandPai: TcxGridBand = Nil;
                         blnVisible: Boolean = False;
                         cxStyle: TCxStyle = Nil): TcxGridBand;

      procedure tmrRefreshDadosTimer(Sender: TObject);

      procedure pInicializaDadodsRodape(Var winCampo: TWinControl;
                                        Var cdsCamposRodape, cdscampos: TZClient;
                                        Var pnlRodapeGrid: TPanel;
                                        Var intTop, intLeft, intMaxTop: Integer);

      procedure pCriaTituloRodape(Var lblTitulo: TLabel; cdsCamposRodape, cdscampos: TZClient; pnlRodapeGrid: TPanel);
      procedure pCriaCampoRodape(Var winCampo: TWinControl; cdsCamposRodape, cdscampos: TZClient; pnlRodapeGrid: TPanel);
      Function fTemCampoAlinhadoPeloConteudo: Boolean;
      procedure pMontaRodapeGridSimples;
      procedure pMontaRodapeGridDetalhado;
      procedure pMontaRodapeGridDetalhadoColunado;
      procedure pMontaRodapeGrid;

      Function fGetStyleCabecalho(caTipo: TTipoCabecalho): TCxStyle;

      Function fCriaBotoesRotina: Boolean;

      Function fGetScriptBeforePost: String;
      procedure pBeforePostDados(dataSet: Tdataset);
      procedure pAfterPostDados(dataSet: Tdataset);

      procedure pNextRecord;

      procedure pConsultaViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    public
      cxsZebra: TcxStyle;

      frmGravando: TfrmGravando;

      blnMontouGrid: Boolean;

      shtTabSheet: TTabSheet;
      frmGridRelatResult: TfrmGridRelatResult;

      strTitulo: String;
      mntMontagemGrid: TMontagemGrid;

      blnAutoDataSet: Boolean;

      dtmModuloGrid: TdtmModuloGrid;

      fraGridFrm: TfraGridFrm;
      fraBandedGridFrm: TfraGridBandedFrm;

      intIndexRelatorio: Integer;

      constructor Create(AOwner: TComponent);  Reintroduce;
      destructor Destroy; override;

      Function fGetFooter: Boolean;

      Function fMontaGrid(winParent: TWinControl; AOwner: TComponent; intPosicao: Integer; arrCabec: TArrCabecalhoGrid;
                          blnProgressoIndividual: Boolean): Boolean;

      Procedure pFocusedGrid;

      Function fGetObjBotoes: TRotinasGrid;

    published

      Property objGeraFr3: TGeraFR3 Read FGeraFr3 Write pSetGeraFR3;

      Property dtsSource: TDataSource Read FSource Write FSource;

      Property blnFooter: Boolean Read fGetFooter Write pSetFooter;

      Property vdbConsultaView: TcxGridDBTableView Read FConsultaView Write FConsultaView;
      Property vbtConsultaBandedView: TcxGridDBBandedTableView Read FConsultaBandedView Write FConsultaBandedView;

      Property cxDataController: TcxGridDBDataController Read FDataController;

      Property cxConsulta: TcxGrid Read FcxConsulta Write FcxConsulta;

      Property arrQuebras: TArrGridTableItem Read FQuebras;

      Property cdsCoresColunas: TZClient Read FCoresColunas;

  end; {TGridRelatorio}

  TarrGridRelatorio = Array of TGridRelatorio;

  TGridRelatorioGeral = class(TComponent)
    private

      FIndexRelatorioExcel: Integer;
      FNomArqExel: String;

      FNroGrid: Integer;

      frmGravando: TfrmGravando;

      FindexRelatorio: Integer;
      FGeraFr3: TGeraFR3;

      Procedure pSetGeraFR3(value: TGeraFR3);

      Procedure pLiberaGrids;

      Function fGetColumnCount: Integer;

      Function fShowGridPrg(cxProgressor: TcxProgressBar): Boolean;

      Function fGeraExcelPrg(prgProgresso: TCxProgressBar): Boolean;

    public

      LfrmGridRelatResult: TfrmGridRelatResult;

      arrGrid: TarrGridRelatorio;
      dtmModuloGrid: TdtmModuloGrid;
      mntMontagemGrid: TMontagemGrid;
      arrCabec: TArrCabecalhoGrid;
      intIndiceRelatorio: Integer;
      strNomeArq: String;

      constructor Create(AOwner: TComponent; intIndexRelatorio: Integer = -1);  Reintroduce;
      destructor Destroy; override;

      Function fTemCampoEditavel(intPosGrid: Integer): Boolean;

      Procedure pCarregaTotais(cxDataController: TcxGridDBDataController);

      Procedure pAjustaDadosGrid(intRelatorio: integer);

      Function fShowGrid: Boolean;

      Function fGeraExcelGrid: Boolean;

      Function fGeraExcel(AIndexRelatorio: Integer; ANomArq: String = ''): Boolean;

      Function fGeraExcelJanela(AIndexRelatorio: Integer = -1; ANomArq: String = ''): Boolean;

      Function fCriaGrid(winParent: TWinControl; AOwner: TComponent): Boolean;

      Procedure pPageControlChange(Sender: TObject);

      Function fcxColumns(intIndex: Integer): TcxGridColumn;

      Function fcxFieldNameColumns(intIndex: Integer): String;

      Function fcxDataController: TcxGridDBDataController;

      Function fcxViewData: TcxGridViewData;

    published

      Property objGeraFr3: TGeraFR3 Read FGeraFr3 Write pSetGeraFR3;

      Property intNroGrid: Integer Read FNroGrid Write FNroGrid;

      Property cxColumnCount: Integer Read fGetColumnCount;
  End;

  TArrGridRelatorioGeral = Array Of TGridRelatorioGeral;

implementation

Uses
  System.UITypes,
  System.Rtti,
  System.NetEncoding,
  Windows,
  DBEditFocus, DBMemoFocus,
  cxCurrencyEdit,
  cxCheckBox,
  cxTextEdit,
  cxCalendar,
  cxLookAndFeels,
  untFuncoesEditorFast,
  untInterfaceRelatorio,
  untRelFrx,
  untLegendasGridRelat,
  untFuncoesRel,
  untRelatorio, untConstantes,
  cxGridExportLink,
  untConsultasGrid,
  untGeraExcelRelatorio;

Const
  LAYOUT_SIMPLES = 1;

  TITULO_ACIMA = 1;
  TITULO_AFRENTE = 2;

  ABAIXO_CONTEUDO = 0;
  ABAIXO_TITULO   = 1;
  DIREITA         = 2;

{TGridRelatorioGeral}
constructor TGridRelatorioGeral.Create(AOwner: TComponent; intIndexRelatorio: Integer = -1);
begin
  inherited Create(AOwner);

  frmGravando := Nil;

  SetLength(arrGrid, 0);

  FindexRelatorio := intIndexRelatorio;

  SetLength(arrCabec, 0);

  intIndiceRelatorio := -1;

  mntMontagemGrid := mntGrid;
end;

destructor TGridRelatorioGeral.Destroy;
begin
  pLiberaGrids;

  inherited;
end;

Function TGridRelatorioGeral.fGetColumnCount: Integer;
Begin
  If Assigned(arrGrid[FNroGrid].vdbConsultaView) Then
    Result := arrGrid[FNroGrid].vdbConsultaView.ColumnCount
  Else
    Result := arrGrid[FNroGrid].vbtConsultaBandedView.ColumnCount;
End;

Function TGridRelatorioGeral.fcxColumns(intIndex: Integer): TcxGridColumn;
Begin
  If Assigned(arrGrid[FNroGrid].vdbConsultaView) Then
    Result := arrGrid[FNroGrid].vdbConsultaView.Columns[intIndex]
  Else
    Result := arrGrid[FNroGrid].vbtConsultaBandedView.Columns[intIndex];
End;

Function TGridRelatorioGeral.fcxDataController: TcxGridDBDataController;
Begin
  If Assigned(arrGrid[FNroGrid].vdbConsultaView) Then
    Result := arrGrid[FNroGrid].vdbConsultaView.DataController
  Else
    Result := arrGrid[FNroGrid].vbtConsultaBandedView.DataController
End;

Function TGridRelatorioGeral.fcxViewData: TcxGridViewData;
Begin
  If Assigned(arrGrid[FNroGrid].vdbConsultaView) Then
    Result := arrGrid[FNroGrid].vdbConsultaView.ViewData
  Else
    Result := arrGrid[FNroGrid].vbtConsultaBandedView.ViewData
End;

Function TGridRelatorioGeral.fcxFieldNameColumns(intIndex: Integer): String;
Begin
  If Assigned(arrGrid[FNroGrid].vdbConsultaView) Then
    Result := arrGrid[FNroGrid].vdbConsultaView.Columns[intIndex].DataBinding.FieldName
  Else
    Result := arrGrid[FNroGrid].vbtConsultaBandedView.Columns[intIndex].DataBinding.FieldName;
End;

Procedure TGridRelatorioGeral.pLiberaGrids;
  Var
    intContador: Integer;
Begin
  For intContador := Low(arrGrid) To High(arrGrid) Do
    If Assigned(arrGrid[intContador]) Then
      FreeAndNil(arrGrid[intContador]);
End;

Procedure TGridRelatorioGeral.pSetGeraFR3(value: TGeraFR3);

    Procedure pSetaArrGrid(intPosGrid, intPosRel: Integer);
      Var objRelatorio: TRelatorio;
    Begin
      arrGrid[intPosGrid] := TGridRelatorio.Create(Nil);
      arrGrid[intPosGrid].dtsSource.DataSet := FGeraFr3.qryDados[intPosRel];

      arrGrid[intPosGrid].dtmModuloGrid := dtmModuloGrid;

      If intPosRel = Low(FGeraFr3.qryDados) Then
      Begin
        arrGrid[intPosGrid].objGeraFr3 := FGeraFr3;
      End Else
      Begin
        objRelatorio := TRelatorio.Create(Nil, True, SameText(FGeraFr3.arrCadRel[0].FieldByName('REL_CONIND').AsString, 'S'),
                                          TInterfaceRelatorio(FGeraFr3.objInterfaceGera).conConexaoRelatorio);

        objRelatorio.pInicializaRelatorio(objRelatorio, FGeraFr3.arrCadRel[intPosRel], Nil, FGeraFr3.objInterfaceGera);
        objRelatorio.objGeraFr3.pCarregaQuebras;

        arrGrid[intPosGrid].objGeraFr3 := objRelatorio.objGeraFr3;
      End;

      arrGrid[intPosGrid].intIndexRelatorio := intPosRel;

      arrGrid[intPosGrid].FcdsCampos.Data := arrGrid[intPosGrid].objGeraFr3.cdsCamposG.Data;
    End;

  Var
    intContador: Integer;
Begin
  FGeraFr3 := Value;

  If FindexRelatorio = -1 Then
  Begin
    SetLength(arrGrid, Length(FGeraFr3.qryDados));

    For intContador := Low(FGeraFr3.qryDados) To High(FGeraFr3.qryDados) Do
      pSetaArrGrid(intContador, intContador);

   End Else
   Begin

     SetLength(arrGrid, 1);
     pSetaArrGrid(0, FindexRelatorio);

   End;
End;

Function TGridRelatorioGeral.fTemCampoEditavel(intPosGrid: Integer): Boolean;
Begin
  Result := arrGrid[intPosGrid].objGeraFr3.cdsCamposG.Locate('CAM_EDITAV', 'S', []);
End;

{TGridRelatorioGeral - Fim}

constructor TGridRelatorio.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  cxsZebra := TcxStyle.Create(Self);

  objScriptBeforePost := Nil;

  FMarcando := False;
  frmGravando := Nil;

  blnMontouGrid := False;

  tmrRefreshDados := Nil;
  shtTabSheet := Nil;
  fraGridFrm := Nil;
  fraBandedGridFrm := Nil;

  FPais      := fSetapais;
  FSource    := TDataSource.Create(Self);
  FcdsCampos := TUniClientDataSet.Create(Self);

  FCoresColunas := TZClient.Create(Self, fSQLCoresColunas);

  FLastBand := Nil;
  SetLength(arrCabecalho, 0);

  SetLength(FQuebras, 0);
  SetLength(FarrFormula, 0);
  SetLength(FFonteNomCam, 0);
  SetLength(FFonteValida, 0);

  objRotinasGrid := TRotinasGrid.Create(Self, tpcGrid);
end;

destructor TGridRelatorio.Destroy;
begin
  pLiberaQuebras;
  pLiberaFormulas;
  pLiberaFonteNomCam;
  pLiberaFonteValida;

  inherited;
end;

Function TGridRelatorio.fGetMaxDataGroupIndex: Integer;
  Var
    intRowIndex: Integer;
Begin
  Result := -1;
  With FDataController Do
  Begin
    intRowIndex := GetRowIndexByRecordIndex(RecordCount - 1, true);

    If intRowIndex <> -1 then
      Result := Groups.DataGroupIndexByRowIndex[intRowIndex];
  End;
End;

Procedure TGridRelatorio.pCopiaCabecalho(arrOrigem: TArrCabecalhoGrid; Var arrDestino: TArrCabecalhoGrid);
  Var
    intContador: Integer;
Begin
  If Length(arrOrigem) > 0 Then
  Begin
    SetLength(arrDestino, Succ(Length(arrOrigem)));

    arrDestino[0] := arrOrigem[0];
    arrDestino[1].strCabecalho := strTitulo;
    arrDestino[1].taAlinhamento := taCenter;
    arrDestino[1].caTipo := caTitulo;

    For intContador := Succ(Low(arrOrigem)) To High(arrOrigem) Do
      arrDestino[Succ(intContador)] := arrOrigem[intContador];
  End;
End;

Function TGridRelatorio.fGetFlowPanel: TFlowPanel;
Begin
  If frmGridRelatResult.pagPaginas.Visible Then
  Begin
    If Assigned(fraBandedGridFrm) Then
    Begin
      fraBandedGridFrm.pnlBotoes.Visible := True;
      fraBandedGridFrm.pnlBotoes.Top := fraBandedGridFrm.ClientHeight;
      Result := fraBandedGridFrm.FlwBotoes;
    End Else
    Begin
      fraGridFrm.pnlBotoes.Visible := True;
      fraGridFrm.pnlBotoes.Top := fraGridFrm.ClientHeight;
      Result := fraGridFrm.FlwBotoes;
    End;
  End

  Else Result := frmGridRelatResult.FlwBotoes
End;

Function TGridRelatorio.fMontaGrid(winParent: TWinControl; AOwner: TComponent; intPosicao: Integer; arrCabec: TArrCabecalhoGrid;
                                   blnProgressoIndividual: Boolean): Boolean;
Begin
  Try
    pCopiaCabecalho(arrCabec, arrCabecalho);

    FGrupoCampos := fTemGrupoDeCampos;

    If FGrupoCampos Or (Length(arrCabec) > 0) Then
    Begin
      fraBandedGridFrm        := TfraGridBandedFrm.Create(AOwner);
      FcxConsulta             := fraBandedGridFrm.cxConsulta;
      fraBandedGridFrm.Name   := 'fraGridFrm' + IntToStr(intPosicao);
      fraBandedGridFrm.parent := winParent;
      fraBandedGridFrm.Show;
      FConsultaBandedView     := fraBandedGridFrm.cxConsultaView;
      FDataController         := FConsultaBandedView.DataController;
      FViewData               := FConsultaBandedView.ViewData;

      FConsultaBandedView.OnEditKeyPress := pConsultaViewEditKeyPress;
      FConsultaBandedView.OnKeyDown := pConsultaViewKeyDown;

      If Assigned(FGeraFr3.objInterfaceGera) And
         Assigned(TInterfaceRelatorio(FGeraFr3.objInterfaceGera).objParametrosRelatorio) And
        (Not TInterfaceRelatorio(FGeraFr3.objInterfaceGera).objParametrosRelatorio.strMensagemRodape.IsEmpty) Then
      Begin
        fraBandedGridFrm.pnlMensagemRodape.Visible := True;
        fraBandedGridFrm.pnlMensagemRodape.Caption := TInterfaceRelatorio(FGeraFr3.objInterfaceGera).objParametrosRelatorio.strMensagemRodape;
      End;

    End Else
    Begin
      fraGridFrm          := TfraGridFrm.Create(AOwner);
      FcxConsulta         := fraGridFrm.cxConsulta;
      fraGridFrm.Name     := 'fraGridFrm' + IntToStr(intPosicao);
      fraGridFrm.parent   := winParent;
      fraGridFrm.Show;
      FConsultaView       := fraGridFrm.cxConsultaView;
      FDataController     := FConsultaView.DataController;
      FViewData           := FConsultaView.ViewData;

      FConsultaView.OnEditKeyPress := pConsultaViewEditKeyPress;
      FConsultaView.OnKeyDown := pConsultaViewKeyDown;

      If Assigned(FGeraFr3.objInterfaceGera) And
         Assigned(TInterfaceRelatorio(FGeraFr3.objInterfaceGera).objParametrosRelatorio) And
        (Not TInterfaceRelatorio(FGeraFr3.objInterfaceGera).objParametrosRelatorio.strMensagemRodape.IsEmpty) Then
      Begin
        fraGridFrm.pnlMensagemRodape.Visible := True;
        fraGridFrm.pnlMensagemRodape.Caption := TInterfaceRelatorio(FGeraFr3.objInterfaceGera).objParametrosRelatorio.strMensagemRodape;
      End;

    End;

    blnMontouGrid := True;

    If blnProgressoIndividual Then
    Begin
      pCriarFormularios(TfrmGravando, frmGravando);
      With frmGravando Do
      Begin
        lblGravando.Caption := 'Gerando grid, aguarde...';
        fExecutarAcao := fMontaGridPrg;
        ShowModal;
        Result := blnConfirma;
      End;
      pFreeAndNil(frmGravando);

    End Else
    Begin
      Result := fMontaGridPrg(frmGravando.pgbStatus);
    End;

  Except
    on E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TGridRelatorio.fMontaGrid');
      Result := False;
    End;
  End;

End;

Function TGridRelatorio.fGetObjBotoes: TRotinasGrid;
Begin
  If intIndexRelatorio = 0 Then
    Result := frmGridRelatResult.objInteface.objRotinasGrid
  Else
    Result := objRotinasGrid;
End;


Function TGridRelatorio.fCriaBotoesRotina: Boolean;
Begin
  If intIndexRelatorio = 0 Then
  Begin
    Result := True;
  End Else
  Begin
    If Assigned(frmGridRelatResult) Then
      objRotinasGrid.objInteface := frmGridRelatResult.objInteface;

    Result := objRotinasGrid.fCarregaRotinasRelatorio(FGeraFr3.arrCadRel[0].FieldByName('AUTOINCREM').AsString);
  End;

  If Not Result Then
    Exit;

  If Not fGetObjBotoes.cdsRotinasRelatorio.Active Then
    Exit;

  If fGetObjBotoes.cdsRotinasRelatorio.RecordCount = 0 Then
    Exit;

  fGetObjBotoes.pCriaBotoes(frmGridRelatResult, fGetFlowPanel, FSource.DataSet, FcxConsulta);
  frmGridRelatResult.intLarguraBotoes := frmGridRelatResult.intLarguraBotoes + fGetObjBotoes.intLarguraBotoes;
End;

Procedure TGridRelatorio.pAtualizaStatus(strMensagem: String);
Begin
  frmGravando.lblGravando.Caption := strMensagem;
  Application.ProcessMessages;
End;

Function TGridRelatorio.fMontaGridPrg(prgProgresso: TCxProgressBar): Boolean;
Begin
  pAtualizaStatus('Criando cabeçalhos...');
  pCriaQuebras;

  pAtualizaStatus('Criando colunas...');
  pMontaColunasGrid;

  pAtualizaStatus('Criando totalizadores...');
  pMontaTotais;
  pMontaTotaisParaFormulas;

  pAtualizaStatus('Configurando grid...');
  pConfiguraGrid;

  FDataController.DataSource := FSource;

  pAtualizaStatus('Calculando fórmulas dos totais...');
  pCalculaTotaisFormula;

  pAtualizaStatus('Criando rodapé...');
  pMontaRodapeGrid;

  pAtualizaStatus('Expandindo grupos...');

  FViewData.Expand(True);

  If mntMontagemGrid <> mntExcel Then
  Begin

    If Assigned(FConsultaView) Then
    With FConsultaView Do
    Begin
      If SameText(FGeraFr3.arrCadRel[0].FieldByName('REL_STRHED').AsString, 'S') Then
        FConsultaBandedView.OptionsView.HeaderAutoHeight := True;

      If mntMontagemGrid = mntGrid Then
      Begin
        pAtualizaStatus('Ajustando tamanho das colunas...');
        ApplyBestFit;
      End;

      NavigatorButtons.First.Click;

      FConsultaView.DataController.Filter.AutoDataSetFilter := blnAutoDataSet;
    End Else
    With FConsultaBandedView Do
    Begin
      If SameText(FGeraFr3.arrCadRel[0].FieldByName('REL_STRHED').AsString, 'S') Then
        FConsultaBandedView.OptionsView.HeaderAutoHeight := True;

      If mntMontagemGrid = mntGrid Then
      Begin
        pAtualizaStatus('Ajustando tamanho das colunas...');
        ApplyBestFit;
      End;

      NavigatorButtons.First.Click;

      FConsultaBandedView.DataController.Filter.AutoDataSetFilter := blnAutoDataSet;
    End;

  End;

  Result := fCriaBotoesRotina;
End;

Procedure TGridRelatorio.pLimpaExpressao(fscScript: TfsScript);
Begin
  fscScript.Clear;
  With fscScript Do
  Begin
    SyntaxType := 'PascalScript';
    AddType('Integer', fvtInt);
    AddType('Boolean', fvtBool);
    AddType('Double' , fvtFloat);
    AddType('Char',    fvtChar);
    AddType('String',  fvtString);
    AddType('Variant', fvtVariant);

    AddMethod('Function IIF2(lTest:Boolean; vExpr1,vExpr2: Variant):Variant', fCallIIF);
  End;
End;

Function TGridRelatorio.fCallIIF(Instance: TObject; ClassType: TClass; Const MethodName: String; Var Params: Variant): Variant;
Begin
  Result := IIF(Params[0], Params[1], Params[2]);
End;

Function TGridRelatorio.fCalculaFormulaDefaultGroup(intIndexFormula, intLinha: Integer): Double;
  Var
    intContador,
    intColuna: Integer;
    fltValor: Double;
    blnAchouSoma,
    blnErro: Boolean;
Begin
  Result := 0;

  If intIndexFormula = -1 Then
    Exit;

  With FarrFormula[intIndexFormula] Do
  Begin
    pLimpaExpressao(fscScript);

    For intContador := 0 To stlCampos.Count - 1 Do
    Begin
      blnAchouSoma := False;

      With FDataController.Summary Do
      For intColuna := 0 To DefaultGroupSummaryItems.Count - 1 Do
      If (DefaultGroupSummaryItems[intColuna].Kind = arrOperacao[intContador]) And
         Assigned(TcxGridDBTableSummaryItem(DefaultGroupSummaryItems[intColuna]).Column) And
         Assigned(TcxGridDBColumn(TcxGridDBTableSummaryItem(DefaultGroupSummaryItems[intColuna]).Column).DataBinding) And
         SameText(TcxGridDBColumn(TcxGridDBTableSummaryItem(DefaultGroupSummaryItems[intColuna]).Column).DataBinding.FieldName, stlCampos[intContador]) Then
      Begin
        If GroupSummaryValues[intLinha, intColuna] <> Null Then
          fltValor := GroupSummaryValues[intLinha, intColuna]
        Else
          fltValor := 0;
        fscScript.AddConst(fRetNomeValorOpe(stlCampos[intContador], arrOperacao[intContador]), 'Double', fltValor);

        blnAchouSoma := True;
        break;
      End;

      If Not blnAchouSoma Then
      Begin
        pMensagemOk('Totalizador para a coluna ' + stlCampos[intContador] + ' não encontrado!');
        Exit;
      End;

    End;

    Result := fExecutaExpressao(fscScript, strForExe, blnErro);
  End;

End;

Function TGridRelatorio.fCalculaFormulaSummary(intIndexFormula: Integer): Double;
  Var
    intContador,
    intColuna: Integer;
    fltValor: Double;
    blnAchouSoma,
    blnErro: Boolean;
Begin
  Result := 0;

  If intIndexFormula = -1 Then
    Exit;

  With FarrFormula[intIndexFormula] Do
  Begin
    pLimpaExpressao(fscScript);

    For intContador := 0 To stlCampos.Count - 1 Do
    Begin
      blnAchouSoma := False;

      With FDataController.Summary Do
      For intColuna := 0 To DefaultGroupSummaryItems.Count - 1 Do
      If (DefaultGroupSummaryItems[intColuna].Kind = arrOperacao[intContador]) And
         Assigned(TcxGridDBTableSummaryItem(DefaultGroupSummaryItems[intColuna]).Column) And
         Assigned(TcxGridDBColumn(TcxGridDBTableSummaryItem(DefaultGroupSummaryItems[intColuna]).Column).DataBinding) And
         SameText(TcxGridDBColumn(TcxGridDBTableSummaryItem(DefaultGroupSummaryItems[intColuna]).Column).DataBinding.FieldName, stlCampos[intContador]) Then
      Begin
        If FooterSummaryValues[intColuna] <> Null Then
          fltValor := FooterSummaryValues[intColuna]
        Else
          fltValor := 0;
        fscScript.AddConst(fRetNomeValorOpe(stlCampos[intContador], arrOperacao[intContador]), 'Double', fltValor);
        blnAchouSoma := True;
        break;
      End;

      If Not blnAchouSoma Then
      Begin
        pMensagemOk('Totalizador para a coluna ' + stlCampos[intContador] + ' não encontrado!');
        Exit;
      End;
    End;

    Result := fExecutaExpressao(fscScript, strForExe, blnErro);
  End;
End;

Function TGridRelatorio.fRetNomeValorOpe(strNomCol: String; kinTipOpe: TcxSummaryKind): String;
Begin
  Case kinTipOpe Of
    skSum    : Result := 'SUM_'   + strNomCol + '_';
    skMin    : Result := 'MIN_'   + strNomCol + '_';
    skMax    : Result := 'MAX_'   + strNomCol + '_';
    skCount  : Result := 'COUNT_' + strNomCol + '_';
    skAverage: Result := 'AVG_'   + strNomCol + '_';
    Else       Result := strNomCol;
  End;
End;

Function TGridRelatorio.fExecutaExpressao(fscScript: TfsScript; strExpressao: String; Var blnErro: Boolean): Double;
  Var
    strErrorPos,
    strExpres,
    strMsgErr: String;
Begin
  blnErro := False;

  strExpressao := AnsiReplaceStr(strExpressao, 'IIF', 'IIF2');
  strExpressao := TInterfaceRelatorio(FGeraFr3.objInterfaceGera).fValidaStrQuebra(strExpressao, '');

  strExpres := Trim(strExpressao);

  With fscScript Do
  Try

    Result := fscScript.Evaluate(strExpressao);

    If Not blnErro And
      (  CharInSet( RightStr(strExpres, 1)[1], [';', '+', '-'] )) Then
    Begin
      ErrorMsg := ' "' + RightStr(strExpres, 1) +'" inesperado';
      blnErro := True;
    End;

    If blnErro Then
    Begin
      strMsgErr := ErrorMsg;

      If SameText(strMsgErr, 'Incompatible types') Then
        strMsgErr := 'Tipos incompatíveis'

      Else If Pos('Undeclared identifier', strMsgErr) > 0 Then
      Begin
        strMsgErr := AnsiReplaceStr(strMsgErr, 'Undeclared identifier:', 'Campo desconhecido: ');
      End

      Else If SameText(strMsgErr, ''';'' expected') Then
        strMsgErr := 'Expressão inválida'

      Else
      Begin
        strMsgErr := AnsiReplaceStr(strMsgErr, 'Expression expected', 'Expressão esperada');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'expected', 'esperado');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'Expected', 'Esperado');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'unexpected', 'inesperado');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'Unexpected', 'Inesperado');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'Identifier', 'Identificador');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'identifier', 'identificador');
      End;

      strErrorPos := ErrorPos;
      If Pos(':', strErrorPos) > 0 Then
        strErrorPos := RightStr(strErrorPos, Length(strErrorPos) - Pos(':', strErrorPos));

      pMensagemOk(strExpressao + #13#10 + strMsgErr + '!' + '  Posição: [' + strErrorPos + ']');

    End;

  Except
    On E: Exception Do
    Begin
      Result := 0;
      pMensagensErro(strExpressao + ' - ' + E.Message, '[TGridRelatorio.fExecutaExpressao]');
    End;
  End;
End;

Function TGridRelatorio.fGetIndexFormula(strNomCam: String): Integer;
  Var
    intContador: Integer;
Begin
  Result := -1;

  For intContador := Low(FarrFormula) To High(FarrFormula) Do
    If SameText(FarrFormula[intContador].strColuna, strNomCam) Then
    Begin
      Result := intContador;
      Exit;
    End;
End;

Function TGridRelatorio.fGetFooter: Boolean;
Begin
  If Assigned(FConsultaView) Then
    Result := FConsultaView.OptionsView.Footer
  Else
    Result := FConsultaBandedView.OptionsView.Footer;
End;

Procedure TGridRelatorio.pSetFooter(Value: Boolean);
Begin
  If Assigned(FConsultaView) Then
    FConsultaView.OptionsView.Footer := Value
  Else
    FConsultaBandedView.OptionsView.Footer := Value;
End;

Procedure TGridRelatorio.pCalculaTotaisFormula;
  Var
    intColuna,
    intMaxLinha,
    intLinha,
    intIndexFormula: Integer;
Begin
  intMaxLinha := fGetMaxDataGroupIndex;

  With FDataController.Summary Do
  Begin
    If Assigned(frmGravando) Then
    Begin
      frmGravando.pgbStatus.Properties.Max := (intMaxLinha + 1) * Length(FarrFormula);
      frmGravando.pgbStatus.Position := 0;
    End;

    For intColuna := 0 To DefaultGroupSummaryItems.Count - 1 Do
    Begin
      If (DefaultGroupSummaryItems[intColuna].Kind = skNone) And
         Assigned(TcxGridDBTableSummaryItem(DefaultGroupSummaryItems[intColuna]).Column) And
         Assigned(TcxGridDBColumn(TcxGridDBTableSummaryItem(DefaultGroupSummaryItems[intColuna]).Column).DataBinding) Then
      Begin

        intIndexFormula := fGetIndexFormula(TcxGridDBColumn(TcxGridDBTableSummaryItem(DefaultGroupSummaryItems[intColuna]).Column).DataBinding.FieldName);

        If intIndexFormula > -1 Then
        Begin
          For intLinha := 0 To intMaxLinha Do
          Begin
            GroupSummaryValues[intLinha, intColuna] := fCalculaFormulaDefaultGroup(intIndexFormula, intLinha);

            If Assigned(frmGravando) Then
            Begin
              frmGravando.pgbStatus.Position := frmGravando.pgbStatus.Position + 1;
              Application.ProcessMessages;
            End;
          End;

          If blnFooter Then
          Begin
            FooterSummaryValues[intColuna] := fCalculaFormulaSummary(intIndexFormula);

            If Assigned(frmGravando) Then
            Begin
              frmGravando.pgbStatus.Position := frmGravando.pgbStatus.Position + 1;
              Application.ProcessMessages;
            End;
          End;
        End;

      End;

    End;

  End;
End;

Procedure TGridRelatorioGeral.pAjustaDadosGrid(intRelatorio: integer);
Begin
  FGeraFr3.qryDados[intRelatorio].Filtered := False;
  FGeraFr3.qryDados[intRelatorio].Filter   := '';
End;

Function TGridRelatorioGeral.fCriaGrid(winParent: TWinControl; AOwner: TComponent): Boolean;
Begin
  pAjustaDadosGrid(0);

  If Assigned(FGeraFr3) And Assigned(FGeraFr3.arrCadRel[0]) Then
    arrGrid[0].blnAutoDataSet := SameText(FGeraFr3.arrCadRel[0].FieldByName('REL_IMPGRI').AsString, 'S');

  arrGrid[0].frmGridRelatResult := LfrmGridRelatResult;
  arrGrid[0].mntMontagemGrid := mntMontagemGrid;

  Result := arrGrid[0].fMontaGrid(winParent, AOwner, FindexRelatorio, arrCabec, True);
End;

Procedure TGridRelatorioGeral.pPageControlChange(Sender: TObject);
Var
  tbsAtual: TTabSheet;
  intCont,
  intRecords: Integer;
  frmForm: TForm;
Begin

  frmForm := nil;
  intRecords := 0;

  tbsAtual := TPageControl(Sender).ActivePage;
  for intCont := 0 to TForm(tbsAtual.Controls[0]).ComponentCount -1 do
  begin
    if TForm(tbsAtual.Controls[0]).Components[intCont] is TcxCustomGridTableView then
    begin
      frmForm := TForm(TForm(tbsAtual.Controls[0]).Owner);
      intRecords := TcxCustomGridTableView(TForm(tbsAtual.Controls[0]).Components[intCont]).DataController.FilteredRecordCount;
      Break;
    end;
  end;

  if Assigned(frmForm) then
  begin
    for intCont := 0 to frmForm.ComponentCount -1 do
    begin
      if frmForm.Components[intCont] is TPanel then
      begin
        if TPanel(frmForm.Components[intCont]).Name = 'pnlInfo' then
        begin
          TPanel(frmForm.Components[intCont]).Caption := 'Registros: ' + IntToStr(intRecords);
          Break;
        end;
      end;
    end;
  end;

End;

Procedure TGridRelatorioGeral.pCarregaTotais(cxDataController: TcxGridDBDataController);
  Var
    intContador: Integer;
Begin
  SetLength(FGeraFr3.ArrTotaisRodape, cxDataController.Summary.DefaultGroupSummaryItems.Count);

  For intContador := 0 To cxDataController.Summary.DefaultGroupSummaryItems.Count - 1 Do
    If cxDataController.Summary.FooterSummaryValues[intContador] <> Null Then
      FGeraFr3.ArrTotaisRodape[intContador] := cxDataController.Summary.FooterSummaryValues[intContador]
    Else
      FGeraFr3.ArrTotaisRodape[intContador] := 0;
End;

Function TGridRelatorioGeral.fShowGrid: Boolean;
Begin
  Result := TfrmGravando.fExecuta(fShowGridPrg, frmGravando, 'Gerando grid, aguarde...');
End;

Function TGridRelatorioGeral.fShowGridPrg(cxProgressor: TcxProgressBar): Boolean;
  Var
    intQtdRel,
    intContador,
    intContRel: Integer;
    TabSheet: TTabSheet;
    strTitulo: String;
    blnCriouProcChange,
    blnAutoDataSet: Boolean;
Begin
  Result := True;

  intQtdRel := 0;
  blnCriouProcChange := False;

  blnAutoDataSet := SameText(FGeraFr3.arrCadRel[0].FieldByName('REL_IMPGRI').AsString, 'S');

  For intContador := Low(FGeraFr3.qryDados) To High(FGeraFr3.qryDados) Do
  If (intContador = intIndiceRelatorio) Or (intIndiceRelatorio = -1) Then
  Begin
    pAjustaDadosGrid(intContador);

    If Not FGeraFr3.qryDados[intContador].IsEmpty Then
    Begin
      Inc(intQtdRel);

      If intQtdRel = 1 Then
        strTitulo := FGeraFr3.fGetNomeRelatorio(FGeraFr3.arrCadRel[intContador]);
    End;
  End;

  pCriarFormularios(TfrmGridRelatResult, LfrmGridRelatResult);

  try
    LfrmGridRelatResult.blnConfirmarSaida := SameText(FGeraFr3.arrCadRel[0].FieldByName('REL_CONSAI').AsString, 'S');

    LfrmGridRelatResult.objInteface := FGeraFr3.objInterfaceGera;

    LfrmGridRelatResult.Caption := strTitulo;

    intContRel := 0;

    For intContador := Low(arrGrid) To High(arrGrid) Do
    If (intContador = intIndiceRelatorio) Or (intIndiceRelatorio = -1) Then
    Begin
      frmGravando.pgbStatus.Position := 0;
      arrGrid[intContador].frmGravando := frmGravando;
      arrGrid[intContador].blnAutoDataSet  := blnAutoDataSet;
      arrGrid[intContador].mntMontagemGrid := mntMontagemGrid;

      If Not arrGrid[intContador].dtsSource.DataSet.IsEmpty Then
      Begin

        If FGeraFr3.arrCadRel[intContador].FieldByName('REL_TEMREF').AsInteger > 0 Then
        Begin
          arrGrid[intContador].tmrRefreshDados := TTimer.Create(Self);
          arrGrid[intContador].tmrRefreshDados.Interval := 1000 * FGeraFr3.arrCadRel[intContador].FieldByName('REL_TEMREF').AsInteger;
          arrGrid[intContador].tmrRefreshDados.OnTimer := arrGrid[intContador].tmrRefreshDadosTimer;
        End;

        If intQtdRel = 1 Then
        Begin
          If Assigned(LfrmGridRelatResult.objInteface) Then
            LfrmGridRelatResult.objInteface.intIndexGrid := intContador;

          arrGrid[intContador].strTitulo := strTitulo;
          arrGrid[intContador].frmGridRelatResult := LfrmGridRelatResult;

          LfrmGridRelatResult.intGridAtivo := intContador;

          LfrmGridRelatResult.pagPaginas.Visible := False;

          Result := arrGrid[intContador].fMontaGrid(LfrmGridRelatResult, LfrmGridRelatResult, intContador, arrCabec, False);

          LfrmGridRelatResult.pnlInfo.Caption := 'Registros: ' + IntToStr(arrGrid[intContador].dtsSource.DataSet.RecordCount);
          LfrmGridRelatResult.pnlInfo.Alignment := taLeftJustify;
        End Else
        Begin

          if not blnCriouProcChange then
          begin
            LfrmGridRelatResult.pagPaginas.OnChange := pPageControlChange;
            LfrmGridRelatResult.pnlInfo.Caption := 'Registros: ' + IntToStr(arrGrid[intContador].dtsSource.DataSet.RecordCount);
            LfrmGridRelatResult.pnlInfo.Alignment := taLeftJustify;
            blnCriouProcChange := True;
          end;

          TabSheet := TTabSheet.Create(LfrmGridRelatResult.pagPaginas);
          arrGrid[intContador].shtTabSheet := TabSheet;

          arrGrid[intContador].strTitulo := FGeraFr3.fGetNomeRelatorio(FGeraFr3.arrCadRel[intContador]);

          TabSheet.Tag := intContador;
          TabSheet.Caption := '&' + IntToStr(Succ(intContRel)) + '- ' + FGeraFr3.fGetNomeRelatorio(FGeraFr3.arrCadRel[intContador]);
          TabSheet.PageControl := LfrmGridRelatResult.pagPaginas;

          if (Pos('/',strTitulo)>0) then
          begin
            LfrmGridRelatResult.Caption := Copy(strTitulo, 1, Pos('/',strTitulo)-1);
            TabSheet.Caption := '&' + IntToStr(Succ(intContRel)) + '- ' + Copy(FGeraFr3.fGetNomeRelatorio(FGeraFr3.arrCadRel[intContador]), Pos('/',strTitulo)+1,length(FGeraFr3.fGetNomeRelatorio(FGeraFr3.arrCadRel[intContador])));
          end;

          arrGrid[intContador].frmGridRelatResult := LfrmGridRelatResult;

          Result := arrGrid[intContador].fMontaGrid(LfrmGridRelatResult.pagPaginas.Pages[Pred(LfrmGridRelatResult.pagPaginas.PageCount)], LfrmGridRelatResult,
                                                                                             intContador, arrCabec, False);
        End;

        If Not Result Then
          Break;

        Inc(intContRel);
      End; {If Not arrGrid[intContador].dtsSource.DataSet.IsEmpty Then}

      arrGrid[intContador].frmGravando := Nil;

    End; {If (intContador = intIndiceRelatorio) Or (intIndiceRelatorio = -1) Then}

    If LfrmGridRelatResult.pagPaginas.Visible Then
      LfrmGridRelatResult.pagPaginas.ActivePageIndex := 0;

    If Result Then
    Begin
      LfrmGridRelatResult.objGridRelatorio := Self;

      For intContador := Low(arrGrid) To High(arrGrid) Do
        If Assigned(arrGrid[intContador].tmrRefreshDados) Then
          arrGrid[intContador].tmrRefreshDados.Enabled := True;

      LfrmGridRelatResult.btnImprimir.Visible := FGeraFr3.arrCadRel[0].FieldByName('REL_IMPGRI').AsString = 'S';

      Case mntMontagemGrid Of
        mntTotais: If (intIndiceRelatorio > -1) And Assigned(arrGrid[intIndiceRelatorio].cxDataController) Then
                     pCarregaTotais(arrGrid[intIndiceRelatorio].cxDataController);

        mntExcelGrid: Result := fGeraExcelGrid;

        mntExcel: Result := fGeraExcel(-1);
      End;

    End;
  finally
   // FreeAndNil(LfrmGridRelatResult);
  end;
End;

Function TGridRelatorioGeral.fGeraExcelGrid: Boolean;
  Var
    intContador: Integer;
Begin
  Try
    For intContador := Low(arrGrid) To High(arrGrid) Do
      ExportGridToExcel(Concat(strNomeArq, IIF(intContador = Low(arrGrid), '', Succ(intContador).ToString)), arrGrid[intContador].cxConsulta);

    Result := True;
  Except
    on E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TGridRelatorioGeral.fGeraExcelGrid');
      Result := False;
    End;
  End;
End;

Function TGridRelatorio.fSQLCoresColunas: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(100)) AS campo, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(100)) AS campo_cor, ';
  strSQL := strSQL + '   CAST(NULL AS UNSIGNED) AS index_coluna ';
  Result := strSQL;
End;

Procedure TGridRelatorio.pLiberaQuebras;
  Var
    intContador: Integer;
Begin
  For intContador := Low(FQuebras) To High(FQuebras) Do
  With FQuebras[intContador] Do
    If Assigned(stlCampos) Then
      FreeAndNil(stlCampos);

  SetLength(FQuebras, 0);
End;

Procedure TGridRelatorio.pLiberaFonteNomCam;
Begin
  SetLength(FFonteNomCam, 0);
End;

Procedure TGridRelatorio.pLiberaFonteValida;
Begin
  SetLength(FFonteValida, 0);
End;

Procedure TGridRelatorio.pLiberaFormulas;
  Var
    intContador: Integer;
Begin
  For intContador := Low(FarrFormula) To High(FarrFormula) Do
  With FarrFormula[intContador] Do
  Begin
    If Assigned(stlCampos) Then
      FreeAndNil(stlCampos);

    If Assigned(fscScript) Then
      FreeAndNil(fscScript);
  End;

  SetLength(FarrFormula, 0);
End;

Procedure TGridRelatorio.pSetGeraFR3(value: TGeraFR3);
Begin
  FGeraFr3 := Value;
End;

procedure TGridRelatorio.pGetDisplayTextQuebra(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := fTextQuebra(Sender, ARecord);
end;

Function TGridRelatorio.fTextQuebra(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord): String;
  Var
    intContador,
    intContaCampos: Integer;
Begin
  Result := '';
  For intContador := Low(FQuebras) To High(FQuebras) Do
  With FQuebras[intContador] Do
  If cxiColuna = Sender Then
  Begin
    If Not fEmptyStr(strTitulo) Then
      Result := strTitulo + ': ';

    For intContaCampos := 0 To stlCampos.Count - 1 Do
    Begin
      (* If fEmptyStr(strTitulo) And (Not fEmptyStr(TcxCustomGridTableItem(stlCampos[intContaCampos]).Caption)) Then
        Result := Result + TcxCustomGridTableItem(stlCampos[intContaCampos]).Caption + ': '; *)

      Result := Result + VarToStr(FDataController.Values[ARecord.RecordIndex, TcxCustomGridTableItem(stlCampos[intContaCampos]).Index]) + ' ';
    End;

    Result := Trim(Result);

    Exit;
  End;
End;

Procedure TGridRelatorio.pCriaQuebras;
  Var
    cxItem,
    cxCampo: TcxCustomGridTableItem;
    intContaQuebras: Integer;
Begin
  intContaQuebras := 0;

  With FGeraFr3, cdsQuebras Do
  Begin
    First;

    While Not Eof Do
    Begin
      cxItem := FDataController.CreateItemByField(FSource.DataSet.FieldByName(FieldByName('CAM_NOMCAM').AsString));
      cxItem.Caption := fDescricaoCampo(FieldByName('CAM_DESCAM').AsString);
      TcxGridDBColumn(cxItem).GroupIndex := intContaQuebras;
      TcxGridDBColumn(cxItem).Visible    := False;

      SetLength(FQuebras, Succ(Length(FQuebras)));
      With FQuebras[High(FQuebras)] Do
      Begin
        cxiColuna := cxItem;

        If SameText(arrCadRel[0].FieldByName('REL_TITQUE').AsString, 'S') Then
          strTitulo := FieldByName('CAM_DESCAM').AsString
        Else
          strTitulo := '';

        stlCampos := TList.Create;
      End;

      Inc(intContaQuebras);

      cdsCamposG.IndexFieldNames := 'CAM_LINQUE;CAM_POSICA';

      cdsCamposG.First;

      While Not cdsCamposG.Eof Do
      With FQuebras[High(FQuebras)] Do
      Begin
        If SameText(cdsCamposG.FieldByName('CAM_LISQUE').AsString, FieldByName('CAM_NOMCAM').AsString) Then
        Begin
          cxCampo := FDataController.CreateItemByField(FSource.DataSet.FieldByName(cdsCamposG.FieldByName('CAM_NOMCAM').AsString));
          cxCampo.Caption := fDescricaoCampo(cdsCamposG.FieldByName('CAM_DESCAM').AsString);
          TcxGridDBColumn(cxCampo).Visible := False;

          stlCampos.Add(cxCampo);
        End;

        cdsCamposG.Next;
      End;

      TcxGridDBColumn(cxItem).OnGetDisplayText := pGetDisplayTextQuebra;

      Next;
    End;

  End;
End;

Procedure TGridRelatorio.pMontaTotais;
  Var
    smkTipoSoma: TcxSummaryKind;
    objSoma: TcxDataSummaryItem;
    strExpressao,
    strFormat: String;
    blnErro: Boolean;
    intNumDec: Integer;
Begin
  With FGeraFr3, cdsCamposG Do
  Begin
    DisableControls;
    IndexFieldNames := 'CAM_LISTAR;CAM_POSICA';

    First;
    While Not Eof Do
    Begin

      // SE VAI LISTAR O CAMPO
      If (Not fEmptyStr(FieldByName('CAM_LISTAR').AsString)) And
         fValidaVisibilidade(cdsCamposG) Then
      Begin

        // SE TEM TOTAL
        If (Not fEmptyStr(FieldByName('CAM_TOTALI').AsString)) Then
        Begin
          blnFooter :=  Not SameText(arrCadRel[0].FieldByName('REL_OMITOT').AsString, 'S');

          If SameText('COUNT', String(ArrTipoTotal[fRetIndiceTotal(FieldByName('CAM_TOTALI').AsString)])) Then
            smkTipoSoma := skCount

          Else If SameText('SUM', String(ArrTipoTotal[fRetIndiceTotal(FieldByName('CAM_TOTALI').AsString)])) Then
            smkTipoSoma := skSum

          Else If SameText('MAX', String(ArrTipoTotal[fRetIndiceTotal(FieldByName('CAM_TOTALI').AsString)])) Then
            smkTipoSoma := skMax

          Else If SameText('MIN', String(ArrTipoTotal[fRetIndiceTotal(FieldByName('CAM_TOTALI').AsString)])) Then
            smkTipoSoma := skMin

          Else If SameText('AVG', String(ArrTipoTotal[fRetIndiceTotal(FieldByName('CAM_TOTALI').AsString)])) Then
            smkTipoSoma := skAverage

          Else
          Begin
            smkTipoSoma := skNone;

            strExpressao := TInterfaceRelatorio(FGeraFr3.objInterfaceGera).fRetornaValorVariavel(FieldByName('CAM_FORTOT').AsString);
            strExpressao := fColocaValoresExpressao(strExpressao, blnErro);

            pInsereFormula(FieldByName('CAM_NOMCAM').AsString, FGeraFr3.fColocaValoresExpressao(strExpressao, blnErro));
          End;

          Case TInterfaceRelatorio.fDescMascaraToTipo(FieldByName('CAM_MASCAR').AsString) Of
            masDecUni : intNumDec := fCfgSis('DECUNI', varInteger);
            masDecQtd : intNumDec := fCfgSis('DECQTD', varInteger);
            masEstDec : intNumDec := fCfgSis('ESTDEC', varInteger);
            masDeqTpc : intNumDec := fCfgSis('DEQTPC', varInteger);
            Else        intNumDec := FieldByName('CAM_NRODEC').AsInteger;
          End;

          strFormat := IfThen(smkTipoSoma = skCount, '',  '#,##0.' + fStrZero('0', intNumDec) +
                         ';-#,##0.' + fStrZero('0', intNumDec));

          objSoma := FDataController.Summary.DefaultGroupSummaryItems.Add(
             FDataController.GetItemByFieldName(FieldByName('CAM_NOMCAM').AsString), spFooter, smkTipoSoma, strFormat);

          If smkTipoSoma = skNone Then
          Begin
            FarrFormula[High(FarrFormula)].strFormat := strFormat;
            objSoma.Tag := High(FarrFormula);
            objSoma.OnGetText := pGroupSummaryGetText;
          End;

          If blnFooter Then
          Begin
            objSoma := FDataController.Summary.FooterSummaryItems.Add(
              FDataController.GetItemByFieldName(FieldByName('CAM_NOMCAM').AsString), spFooter, smkTipoSoma, strFormat);

            If smkTipoSoma = skNone Then
            Begin
              objSoma.Tag := High(FarrFormula);
              objSoma.OnGetText := pGroupSummaryGetText;
            End;

          End;

        End; {If (Not fEmptyStr(FieldByName('CAM_TOTALI').AsString)) Then}

      End;

      Next;

    End;

    cdsCamposG.IndexFieldNames := 'CAM_POSICA';
    EnableControls;
  End;
End;

Function TGridRelatorio.fTemSoma(strColuna: String; kinTipoSoma: TcxSummaryKind): Boolean;
  Var
    intColuna: Integer;
Begin
  Result := False;

  With FDataController.Summary Do
  For intColuna := 0 To DefaultGroupSummaryItems.Count - 1 Do
  Begin
    If (DefaultGroupSummaryItems[intColuna].Kind = kinTipoSoma) And
       Assigned(TcxGridDBTableSummaryItem(DefaultGroupSummaryItems[intColuna]).Column) And
       Assigned(TcxGridDBColumn(TcxGridDBTableSummaryItem(DefaultGroupSummaryItems[intColuna]).Column).DataBinding) And
       SameText(TcxGridDBColumn(TcxGridDBTableSummaryItem(DefaultGroupSummaryItems[intColuna]).Column).DataBinding.FieldName, strColuna) Then
    Begin
      Result := True;
      Exit;
    End;

  End;
End;

Procedure TGridRelatorio.pMontaTotaisParaFormulas;
  Var
    intContador,
    intCampos: Integer;
    cxItem: TcxCustomGridTableItem;
Begin

  For intContador := Low(FarrFormula) To High(FarrFormula) Do
  With  FarrFormula[intContador] Do
  If Assigned(stlCampos) Then
  Begin

    For intCampos := 0 To stlCampos.Count - 1 Do
      If Not fTemSoma(stlCampos[intCampos], arrOperacao[intCampos]) Then
      Begin
        cxItem  := FDataController.CreateItemByField(FSource.DataSet.FieldByName(stlCampos[intCampos]));

        FDataController.Summary.DefaultGroupSummaryItems.Add(cxItem, spFooter, arrOperacao[intCampos], strFormat);

        If blnFooter Then
          FDataController.Summary.FooterSummaryItems.Add(cxItem , spFooter, arrOperacao[intCampos], strFormat);

        cxItem.Visible := False;
      End;

  End;
End;

procedure TGridRelatorio.pGroupSummaryGetText(Sender: TcxDataSummaryItem;
  const [Ref] AValue: Variant; AIsFooter: Boolean; var AText: string);
begin
  If AValue <> Null Then
    AText := FormatFloat(FArrFormula[Sender.Tag].strFormat, AValue);
end;

Function TGridRelatorio.fInicializaScript: TfsScript;
Begin
  Result := TfsScript.Create(Nil);
End;

Procedure TGridRelatorio.pInsereFormula(strNomCam, strForTot: String);
Begin
  SetLength(FarrFormula, Succ(Length(FarrFormula)));

  With FcdsCampos, FarrFormula[High(FarrFormula)] Do
  Begin

    strColuna  := strNomCam;
    strFormula := strForTot;
    strForExe  := strForTot;
    stlCampos  := TStringList.Create;
    fscScript  := fInicializaScript;

    First;
    While Not Eof Do
    Begin

      If Pos('SUM(' + FieldByName('CAM_NOMCAM').AsString + ')', strForExe) > 0 Then
      Begin
        stlCampos.Add(FieldByName('CAM_NOMCAM').AsString);
        arrOperacao[stlCampos.Count -1] := skSum;
        strForExe := AnsiReplaceStr(strForExe, 'SUM(' + FieldByName('CAM_NOMCAM').AsString + ')', fRetNomeValorOpe(FieldByName('CAM_NOMCAM').AsString, skSum));
      End;

      If Pos('COUNT(' + FieldByName('CAM_NOMCAM').AsString + ')', strForExe) > 0 Then
      Begin
        stlCampos.Add(FieldByName('CAM_NOMCAM').AsString);
        arrOperacao[stlCampos.Count -1] := skCount;
        strForExe := AnsiReplaceStr(strForExe, 'COUNT(' + FieldByName('CAM_NOMCAM').AsString + ')', fRetNomeValorOpe(FieldByName('CAM_NOMCAM').AsString, skCount));
      End;

      If Pos('MIN(' + FieldByName('CAM_NOMCAM').AsString + ')', strForExe) > 0 Then
      Begin
        stlCampos.Add(FieldByName('CAM_NOMCAM').AsString);
        arrOperacao[stlCampos.Count -1] := skMin;
        strForExe := AnsiReplaceStr(strForExe, 'MIN(' + FieldByName('CAM_NOMCAM').AsString + ')', fRetNomeValorOpe(FieldByName('CAM_NOMCAM').AsString, skMin));
      End;

      If Pos('MAX(' + FieldByName('CAM_NOMCAM').AsString + ')', strForExe) > 0 Then
      Begin
        stlCampos.Add(FieldByName('CAM_NOMCAM').AsString);
        arrOperacao[stlCampos.Count -1] := skMax;
        strForExe := AnsiReplaceStr(strForExe, 'MAX(' + FieldByName('CAM_NOMCAM').AsString + ')', fRetNomeValorOpe(FieldByName('CAM_NOMCAM').AsString, skMax));
      End;

      If Pos('AVG(' + FieldByName('CAM_NOMCAM').AsString + ')', strForExe) > 0 Then
      Begin
        stlCampos.Add(FieldByName('CAM_NOMCAM').AsString);
        arrOperacao[stlCampos.Count -1] := skMax;
        strForExe := AnsiReplaceStr(strForExe, 'AVG(' + FieldByName('CAM_NOMCAM').AsString + ')', fRetNomeValorOpe(FieldByName('CAM_NOMCAM').AsString, skAverage))
      End;

      Next;
    End;
  End;

End;

procedure TGridRelatorio.pGetDisplayTextCNPJ(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  AText := fFormataCpfCgc(AText, FPais);
end;

Function TGridRelatorio.fGetBanda(strNomBan: String;
                                  intTipBan: Integer;
                                  taAlinhamento: TAlignment = taCenter;
                                  cxBandPai: TcxGridBand = Nil;
                                  blnVisible: Boolean = False;
                                  cxStyle: TCxStyle = Nil): TcxGridBand;
  Var
    intContador: Integer;
Begin
  Result := Nil;

  With FConsultaBandedView Do
  Begin
    For intContador := 0 To Bands.Count - 1 Do
      If SameText(Bands[intContador].Caption, strNomBan) Then
      Begin
        Result := Bands[intContador];
        Break;
      End;

    If Not Assigned(Result) Then
    Begin
      result := Bands.Add;
      Result.Visible := blnVisible;
      result.Caption := strNomBan;

      Case intTipBan Of
        0: result.FixedKind := fkNone;
        1: result.FixedKind := fkLeft;
        2: result.FixedKind := fkRight;
      End;

      result.HeaderAlignmentHorz := taAlinhamento;

      result.Styles.Header :=  cxStyle;

      If Assigned(cxBandPai) Then
        result.Position.BandIndex := cxBandPai.Index;
    End;

  End;
End;

Procedure TGridRelatorio.pMontaCabecalhoGrid;
  Var
    intContador: Integer;
Begin
  FLastBand := Nil;

  For intContador := Low(arrCabecalho) To High(arrCabecalho) Do
    FLastBand := fGetBanda(arrCabecalho[intContador].strCabecalho, 0,
                           arrCabecalho[intContador].taAlinhamento, FLastBand, True,
                           fGetStyleCabecalho(arrCabecalho[intContador].caTipo));
End;

Function TGridRelatorio.fGetStyleCabecalho(caTipo: TTipoCabecalho): TCxStyle;
Begin
  Case caTipo Of
    caEmpresa: Result := dtmModuloGrid.cxsEmpresa;
    caTitulo:  Result := dtmModuloGrid.cxsTitulo;
    caFiltro:  Result := dtmModuloGrid.cxsFiltros;
    Else Result := Nil;
  End
End;

Function TGridRelatorio.fFocusedColumn: TcxGridDBColumn;
Begin
  If Assigned(FConsultaView) Then
    Result := TcxGridDBColumn(FConsultaView.Controller.FocusedColumn)

  Else If Assigned(FConsultaBandedView) Then
    Result := TcxGridDBColumn(FConsultaBandedView.Controller.FocusedColumn)

  Else Result := Nil;
End;

Function TGridRelatorio.fGetColumnByFieldName(strNomCam: String): TcxGridDBColumn;
Begin
  If Assigned(FConsultaView) Then
    Result := TcxGridDBColumn(FConsultaView.GetColumnByFieldName(strNomCam))

  Else If Assigned(FConsultaBandedView) Then
    Result := TcxGridDBColumn(FConsultaBandedView.GetColumnByFieldName(strNomCam))

  Else Result := Nil;
End;

Function TGridRelatorio.fFocuseRecord: TcxCustomGridRecord;
Begin
  If Assigned(FConsultaView) Then
    Result := FConsultaView.Controller.FocusedRecord

  Else If Assigned(FConsultaBandedView) Then
    Result := FConsultaBandedView.Controller.FocusedRecord

  Else Result := Nil;
End;

Function TGridRelatorio.fPrimeiroTotal(strNomCam: String): Variant;
  Var
    intGroupIndex,
    intColuna: Integer;
    cxColumn: TcxGridDBColumn;
Begin
  Result := '';

  cxColumn := fGetColumnByFieldName(strNomCam);

  If Not Assigned(cxColumn) Then
    Exit;

  intGroupIndex := FDataController.Groups.DataGroupIndexByRowIndex[fFocuseRecord.Index];

  For intColuna := 0 To  FDataController.Summary.DefaultGroupSummaryItems.Count - 1 Do
    If TcxGridDBTableSummaryItem(FDataController.Summary.DefaultGroupSummaryItems[intColuna]).Column = cxColumn Then
    Begin
      Result := VarToStr(FDataController.Summary.GroupSummaryValues[intGroupIndex, intColuna]);
      Exit;
    End;
End;

Function TGridRelatorio.fTotalGeral(strNomCam: String): Variant;
  Var
    intIndex: Integer;
    cxColumn: TcxGridDBColumn;
Begin
  Result := Null;

  cxColumn := fGetColumnByFieldName(strNomCam);

  If Not Assigned(cxColumn) Then
    Exit;

  intIndex := FDataController.Summary.FooterSummaryItems.IndexOfItemLink(cxColumn);

  Result := FDataController.Summary.FooterSummaryValues[intIndex];
End;

Function TGridRelatorio.fScriptValidate: String;
Begin
  Result := Trim(AnsiReplaceStr(FGeraFr3.cdsCamposG.FieldByName('CAM_SCRVAL').AsString, '<<csq>>', #13#10));
End;

Function TGridRelatorio.fGetScriptValidate: String;
  Var
    strNomCam: String;
Begin
  Result := '';

  strNomCam := fFocusedColumn.DataBinding.FieldName;

  If FGeraFr3.cdsCamposG.Locate('CAM_NOMCAM', strNomCam, []) Then
    Result :=  fScriptValidate;
End;

procedure TGridRelatorio.pConsultaViewValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  Var
    objScript: TPascalScriptRelatorio;
    strScriptValidate,
    strMarcado,
    strDesMarcado: String;
begin
  strScriptValidate := fGetScriptValidate;

  If fEmptyStr(strScriptValidate) Then
  Begin
    ErrorText := '';
    Error := False;
    Exit;
  End;

  If Assigned(Sender) And (Sender Is TcxCheckBox) Then
  Begin
    If FGeraFr3.cdsCamposG.Locate('CAM_NOMCAM', fFocusedColumn.DataBinding.FieldName, []) Then
    Begin
      strMarcado    := FGeraFr3.cdsCamposG.FieldByName('CAM_VALCHE').AsString;
      strDesMarcado := FGeraFr3.cdsCamposG.FieldByName('CAM_VALUNC').AsString;
    End Else
    Begin
      strMarcado    := 'S';
      strDesMarcado := 'N';
    End;

    If TcxCheckBox(Sender).checked Then
      DisplayValue := strMarcado
    Else
      DisplayValue := strDesMarcado
  End;

  objScript := TPascalScriptRelatorio.Create(Nil, TUniClientDataSet(FSource.DataSet), strScriptValidate, DisplayValue,
                                             fPrimeiroTotal, fTotalGeral, tscValidate);

  If objScript.fResult(True) Then
  Begin
    If Assigned(Sender) And (Sender Is TcxCheckBox) Then
      TcxCheckBox(Sender).checked := objScript.varNewValue = strMarcado;

    DisplayValue := objScript.varNewValue;
  End Else
  Begin
    Error := True;
    ErrorText := '';
    Keybd_Event(VK_ESCAPE, 0, 0, 0);
  End;

  FreeAndNil(objScript);
end;

Function TGridRelatorio.fGetScriptBeforePost: String;
Begin
  Result := AnsiReplaceStr(FGeraFr3.arrCadRel[0].FieldByName('REL_SCRBEF').AsString, '<<csq>>', #13#10);
End;

procedure TGridRelatorio.pBeforePostDados(dataSet: Tdataset);
  Var
    blnCompila: Boolean;
Begin
  If Not fEmptyStr(fGetScriptBeforePost) Then
  Begin
    If Not Assigned(objScriptBeforePost) Then
    Begin
      objScriptBeforePost := TPascalScriptRelatorio.Create(Self, TUniClientDataSet(FSource.DataSet), fGetScriptBeforePost, Null,
                                               Nil, Nil, tscBeforePost);

      blnCompila := True;
    End Else
    Begin
      blnCompila := False;
    End;

    objScriptBeforePost.intRecNo := FRecNo;
    objScriptBeforePost.strMensagemAposMarcarTodos := FMensagemAposBeforePost;
    objScriptBeforePost.fResult(blnCompila);
    FMensagemAposBeforePost := objScriptBeforePost.strMensagemAposMarcarTodos;
    FRecNo := objScriptBeforePost.intRecNo;
  End;
End;

procedure TGridRelatorio.pAfterPostDados(dataSet: Tdataset);
Begin
  TUniClientDataSet(FSource.DataSet).MergeChangeLog;

  If Not FMarcando Then
    pNextRecord;
End;

procedure TGridRelatorio.pNextRecord;
  Var
    intIndex: Integer;
    colFocusedColumn: TcxGridDBColumn;
Begin
  colFocusedColumn := fFocusedColumn;

  If Not Assigned(colFocusedColumn) Then
    Exit;

  If Not fFocusedColumn.Options.Editing Then
    Exit;

  If fFocusedColumn.PropertiesClass = TcxCheckBoxProperties Then
    Exit;

  If Assigned(FConsultaView) Then
  Begin
    Repeat
      intIndex := FConsultaView.Controller.FocusedRowIndex;

      FConsultaView.NavigatorButtons.Next.Click;

      If intIndex = FConsultaView.Controller.FocusedRowIndex Then
        Break;

    Until FConsultaView.Controller.FocusedRow.IsData;
  End

  Else If Assigned(FConsultaBandedView) Then
  Begin
    Repeat
      intIndex := FConsultaBandedView.Controller.FocusedRowIndex;

      FConsultaBandedView.NavigatorButtons.Next.Click;

      If intIndex = FConsultaBandedView.Controller.FocusedRowIndex Then
        Break;

    Until FConsultaBandedView.Controller.FocusedRow.IsData;
  End
End;

procedure TGridRelatorio.pConsultaViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_RETURN: pNextRecord;
  End;
end;

Procedure TGridRelatorio.pFocusedGrid;
Begin
  pSetFocus(FcxConsulta);
End;

procedure TGridRelatorio.pMarcaTodos(blnMarcar: Boolean; strNomCam, strMarcado, strDesmarcado, strScript: String);
  Var
    frmGravando: TfrmGravando;
    intRecNoSave: Integer;
Begin
  Try
    FRecNo := 0;
    FMensagemAposBeforePost := '';
    FMarcando := True;
    FMarcar := blnMarcar;
    FNomCam := strNomCam;
    FMarcado := strMarcado;
    FDesmarcado := strDesmarcado;

    intRecNoSave := TUniClientDataSet(FSource.DataSet).RecNo;

    TfrmGravando.fExecuta(fMarcaTodosPrg, frmGravando, 'Aguarde...');

    If FMarcar And (Not FMensagemAposBeforePost.IsEmpty) Then
    Begin
      If FRecNo > 0 Then
        TUniClientDataSet(FSource.DataSet).RecNo := FRecNo
      Else If intRecNoSave > 0 Then
        TUniClientDataSet(FSource.DataSet).RecNo := intRecNoSave;

      pMensagemOk(FMensagemAposBeforePost);

      FMensagemAposBeforePost := '';
    End;

  Finally
    FMarcando := False;

    pFocusedGrid;
  End;
End;

Function TGridRelatorio.fMarcaTodosPrg(cxProgesso: TcxProgressbar): Boolean;
Begin
  FSource.DataSet.DisableControls;

  cxProgesso.Properties.Max := FSource.DataSet.RecordCount;

  FSource.DataSet.First;

  While Not FSource.DataSet.Eof Do
  Begin
    FSource.DataSet.Edit;

    If FMarcar Then
      FSource.DataSet.FieldByName(FNomCam).AsString := FMarcado
    Else
      FSource.DataSet.FieldByName(FNomCam).AsString := FDesmarcado;

    FSource.DataSet.Post;

    FSource.DataSet.Next;

    cxProgesso.Position := cxProgesso.Position + 1;
    Application.ProcessMessages;
  End;

  FSource.DataSet.EnableControls;

  Result := True;
End;

procedure TGridRelatorio.pMarcarTodosClick(Sender: TObject);
Begin
  If FGeraFr3.cdsCamposG.Locate('CAM_NOMCAM', TBotaoGrid(Sender).strNomCam, []) Then
    pMarcaTodos(True, TBotaoGrid(Sender).strNomCam, TBotaoGrid(Sender).strMarcado, TBotaoGrid(Sender).strDesmarcado, fScriptValidate);
End;

procedure TGridRelatorio.pDesmarcarTodosClick(Sender: TObject);
Begin
  If FGeraFr3.cdsCamposG.Locate('CAM_NOMCAM', TBotaoGrid(Sender).strNomCam, []) Then
    pMarcaTodos(False, TBotaoGrid(Sender).strNomCam, TBotaoGrid(Sender).strMarcado, TBotaoGrid(Sender).strDesmarcado, fScriptValidate);
End;

Procedure TGridRelatorio.pCriaBotoesMarcarDesmarcarTodos;
  Var
    btnBotao: TBotaoGrid;
Begin
  FDataController.Filter.AutoDataSetFilter := True;

  btnBotao := TBotaoGrid.Create(frmGridRelatResult);
  btnBotao.Parent := fGetFlowPanel;// frmGridRelatResult.FlwBotoes;
  btnBotao.Caption := 'Marcar todos';
  btnBotao.Height  := 22;
  btnBotao.Width   := frmGridRelatResult.Canvas.TextWidth(btnBotao.Caption) + 36;
  btnBotao.NumGlyphs := 2;
  btnBotao.Glyph.Assign(frmGridRelatResult.imgMarca.Picture);
  btnBotao.strNomCam := FGeraFr3.cdsCamposG.FieldByName('CAM_NOMCAM').AsString;
  btnBotao.strMarcado := FGeraFr3.cdsCamposG.FieldByName('CAM_VALCHE').AsString;
  btnBotao.strDesmarcado := FGeraFr3.cdsCamposG.FieldByName('CAM_VALUNC').AsString;
  btnBotao.OnClick := pMarcarTodosClick;
  fgetobjBotoes.intLarguraBotoes := fgetobjBotoes.intLarguraBotoes + btnBotao.Width + INT_ESPACAMENTO_BOTAO;

  btnBotao := TBotaoGrid.Create(frmGridRelatResult);
  btnBotao.Parent := fGetFlowPanel;// frmGridRelatResult.FlwBotoes;
  btnBotao.Caption := 'Desmarcar todos';
  btnBotao.Height  := 22;
  btnBotao.Width   := frmGridRelatResult.Canvas.TextWidth(btnBotao.Caption) + 36;
  btnBotao.NumGlyphs := 2;
  btnBotao.Glyph.Assign(frmGridRelatResult.imgDesmarca.Picture);
  btnBotao.strNomCam := FGeraFr3.cdsCamposG.FieldByName('CAM_NOMCAM').AsString;
  btnBotao.strMarcado := FGeraFr3.cdsCamposG.FieldByName('CAM_VALCHE').AsString;
  btnBotao.strDesmarcado := FGeraFr3.cdsCamposG.FieldByName('CAM_VALUNC').AsString;
  btnBotao.OnClick := pDesmarcarTodosClick;
  fgetobjBotoes.intLarguraBotoes := fgetobjBotoes.intLarguraBotoes + btnBotao.Width + INT_ESPACAMENTO_BOTAO;
End;

procedure TGridRelatorio.pConsultaViewEditKeyPress(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
   Var
     strCodigos,
     strDesEdt: String;
     ErrorText: TCaption;
     Error: Boolean;
     DisplayValue: Variant;
begin
  If Not fEntraCons(Key) Then
    Exit;

  Try

    Try

      If FGeraFr3.cdsCamposG.Locate('CAM_NOMCAM', TcxGridDBColumn(AItem).DataBinding.FieldName, []) And
         (Not fEmptyStr(FGeraFr3.cdsCamposG.FieldByName('CAM_PESGRI').AsString)) Then
      Begin
        TInterfaceRelatorio(FGeraFr3.objInterfaceGera).objConsulta.blnConsultaPelaGrid := True;

        TInterfaceRelatorio(FGeraFr3.objInterfaceGera).objConsulta.fRetValorParametroGrid :=
           TInterfaceRelatorio(FGeraFr3.objInterfaceGera).objConsultasGrid.fRetValorParametro;

        TInterfaceRelatorio(FGeraFr3.objInterfaceGera).objConsultasGrid.objInteface := FGeraFr3.objInterfaceGera;

        TInterfaceRelatorio(FGeraFr3.objInterfaceGera).objConsultasGrid.pFiltraConsulta(FGeraFr3.cdsCamposG.FieldByName('CAM_NOMCAM').AsString);

        TInterfaceRelatorio(FGeraFr3.objInterfaceGera).objConsultasGrid.cdsDadosCorrente := dtsSource.DataSet;

        If TInterfaceRelatorio(FGeraFr3.objInterfaceGera).objConsulta.fPesqisaTabela('',
                                       strCodigos,
                                       strDesEdt,
                                       frmGridRelatResult,
                                       Key,
                                       True{blnSimples},
                                       TConsultasGrid.fPesquisaToEnum(FGeraFr3.cdsCamposG.FieldByName('CAM_PESGRI').AsString)) Then
        Begin
          DisplayValue := strCodigos;
          pConsultaViewValidate(Nil, DisplayValue, ErrorText, Error);

          If Not Error Then
          Begin
            strCodigos := VarToStr(DisplayValue);
            AEdit.EditValue := strCodigos;
            AEdit.PostEditValue;
          End;
        End;

      End;

    Except
      On E: Exception Do
      Begin
        pMensagemOk('Consulta da grid: ' + E.Message);
      End;
    End;

  Finally
    TInterfaceRelatorio(FGeraFr3.objInterfaceGera).objConsulta.blnConsultaPelaGrid := False;
  End;

end;

Procedure TGridRelatorio.pMontaColunasGrid;
  Var
    strCampoGuia: String;
    cxItem: TcxCustomGridTableItem;
    intIndex,
    intNumDec: Integer;
    bndSubBanda,
    bndBanda: TcxGridBand;
    intTipBan: Integer;
    f: TFieldType;
    stlLegendas: TStringList;
    blnValidate: Boolean;
    blnMontarCampo,
    blnValidouVisibilidade: Boolean;
Begin
  pMontaCabecalhoGrid;

  FCoresColunas.fLeDados('TGridRelatorio.pMontaColunasGrid');
  FCoresColunas.EmptyDataSet;

  With FGeraFr3.cdsCamposG Do
  Begin
    DisableControls;

    blnValidate := False;

    strCampoGuia := 'CAM_LISTAR';

    IndexFieldNames := strCampoGuia + ';CAM_POSICA';

    First;
    While Not Eof Do
    Begin

      blnValidouVisibilidade := FGeraFr3.fValidaVisibilidade(FGeraFr3.cdsCamposG);

      // VAI CRIAR OS CAMPOS VISÍVEIS E OS NÃO VISÍVEIS QUE NÃO TENHAM EXPRESSÃO DE VALIDAÇÃO, ISTO É, NÃO FORAM EXCLUÍDOS PELA EXPRESSÃO
      // PODEM SER CAMPOS DE COR, FONTE ETC
      blnMontarCampo := blnValidouVisibilidade Or fEmptyStr(FGeraFr3.cdsCamposG.FieldByName('CAM_EXPVIS').AsString);

      If blnMontarCampo Then
      Begin
        cxItem := FDataController.CreateItemByField(FSource.DataSet.FieldByName(FieldByName('CAM_NOMCAM').AsString));
        cxItem.Options.Editing := SameText(FieldByName('CAM_EDITAV').AsString, 'S');

        If cxItem.Options.Editing Then
        Begin
          TUniClientDataSet(FSource.DataSet).BeforePost := pBeforePostDados;
          TUniClientDataSet(FSource.DataSet).AfterPost := pAfterPostDados;

          If Assigned(FConsultaView) Then
          Begin
            FConsultaView.OptionsData.Editing := True;
          End

          Else If Assigned(FConsultaBandedView) Then
          Begin
            FConsultaBandedView.OptionsData.Editing := True;
          End;

        End;

        If (Not fEmptyStr(FieldByName('CAM_DEFFON').AsString)) Then
        Begin
          FCoresColunas.Append;
          FCoresColunas.FieldByName('campo').AsString := FieldByName('CAM_NOMCAM').AsString;
          FCoresColunas.FieldByName('campo_cor').AsString := FieldByName('CAM_DEFFON').AsString;
          FCoresColunas.Post;

          cxItem.OnCustomDrawCell := pCustomDrawCellColuna;
        End;

        f := FSource.DataSet.FieldByName(FieldByName('CAM_NOMCAM').AsString).DataType;

        If f In [ftDate, ftTime, ftDateTime] Then
        Begin
          FSource.DataSet.FieldByName(FieldByName('CAM_NOMCAM').AsString).Alignment := taCenter;
          TcxGridDBColumn(cxItem).HeaderAlignmentHorz := taCenter;
        End;

        If SameText(FGeraFr3.arrCadRel[0].FieldByName('REL_STRHED').AsString, 'S') Then
          TcxGridDBColumn(cxItem).HeaderAlignmentHorz := taCenter;

        If FGrupoCampos Or (mntMontagemGrid = mntExcelGrid) Then
        Begin
          If fEmptyStr(FieldByName('CAM_CODGRU').AsString) And Assigned(FLastBand) Then
            bndBanda := FLastBand
          Else
            bndBanda := fGetBanda(FGeraFr3.fRetNomeGrupo(FieldByName('CAM_CODGRU').AsString, intTipBan), intTipBan);

          If Not fEmptyStr(FieldByName('CAM_LISTAR').AsString) Then
            bndBanda.Visible := True;

          If Not fEmptyStr(FieldByName('CAM_SUBGRU').AsString) Then
          Begin
            bndSubBanda := fGetBanda(FGeraFr3.fRetNomeGrupo(FieldByName('CAM_SUBGRU').AsString, intTipBan), 0);
            bndSubBanda.Position.BandIndex := bndBanda.Index;

            If Not fEmptyStr(FieldByName('CAM_LISTAR').AsString) Then
              bndSubBanda.Visible := True;

            bndBanda:= bndSubBanda;
          End;

          TcxGridDBBandedColumn(cxItem).Position.BandIndex := bndBanda.Index;
        End;

        cxItem.Caption := FGeraFr3.fDescricaoCampo(FieldByName('CAM_DESCAM').AsString);

        TcxGridDBColumn(cxItem).Width := Trunc(fCmColunaToPixel(FieldByName('CAM_LARGUR').AsFloat, False, 'J', False));

        If FieldByName('CAM_MAXFIT').AsString = 'S' Then
          TcxGridDBColumn(cxItem).BestFitMaxWidth := TcxGridDBColumn(cxItem).Width;

        If SameText(FieldByName('CAM_TIPCAM').AsString, 'Número inteiro') Or
           SameText(FieldByName('CAM_TIPCAM').AsString, 'Número decimal') Then
        Begin
          TcxGridDBColumn(cxItem).HeaderAlignmentHorz := taRightJustify;

          TcxGridDBColumn(cxItem).PropertiesClass := TcxCurrencyEditProperties;

          TcxCurrencyEditProperties(TcxGridDBColumn(cxItem).Properties).ImmediatePost := True;

          If Not fEmptyStr(fScriptValidate) Then
          Begin
            TcxCurrencyEditProperties(TcxGridDBColumn(cxItem).Properties).OnValidate := pConsultaViewValidate;
            blnValidate := True;
          End;

          Case TInterfaceRelatorio.fDescMascaraToTipo(FieldByName('CAM_MASCAR').AsString) Of
            masDecUni : intNumDec := fCfgSis('DECUNI', varInteger);
            masDecQtd : intNumDec := fCfgSis('DECQTD', varInteger);
            masEstDec : intNumDec := fCfgSis('ESTDEC', varInteger);
            masDeqTpc : intNumDec := fCfgSis('DEQTPC', varInteger);
            Else        intNumDec := FieldByName('CAM_NRODEC').AsInteger;
          End;

          TcxCurrencyEditProperties(TcxGridDBColumn(cxItem).Properties).DecimalPlaces := intNumDec;
          TcxCurrencyEditProperties(TcxGridDBColumn(cxItem).Properties).DisplayFormat := '#,##0.' + fStrZero('0', intNumDec) +
                         ';-#,##0.' + fStrZero('0', intNumDec);

        End Else
        Begin

          Case TInterfaceRelatorio.fDescMascaraToTipo(FieldByName('CAM_MASCAR').AsString) Of
            masCNPJ         : TcxGridDBColumn(cxItem).OnGetDisplayText := pGetDisplayTextCNPJ;

            masTelefone     : Begin
                                TcxGridDBColumn(cxItem).PropertiesClass := TcxMaskEditProperties;;
                                TcxMaskEditProperties(TcxGridDBColumn(cxItem).Properties).EditMask := AnsiReplaceStr(fRetMascaraFonePais, ';0;_', ';1;_');
                                TcxMaskEditProperties(TcxGridDBColumn(cxItem).Properties).ImmediatePost := True;

                                If Not fEmptyStr(fScriptValidate) Then
                                Begin
                                  TcxMaskEditProperties(TcxGridDBColumn(cxItem).Properties).OnValidate := pConsultaViewValidate;
                                  blnValidate := True;
                                End;
                              End;

            masCEP          : Begin
                                TcxGridDBColumn(cxItem).PropertiesClass := TcxMaskEditProperties;;
                                TcxMaskEditProperties(TcxGridDBColumn(cxItem).Properties).ImmediatePost := True;
                                TcxMaskEditProperties(TcxGridDBColumn(cxItem).Properties).EditMask := '99999-999;1;_';

                                If Not fEmptyStr(fScriptValidate) Then
                                Begin
                                  TcxMaskEditProperties(TcxGridDBColumn(cxItem).Properties).OnValidate := pConsultaViewValidate;
                                  blnValidate := True;
                                End;
                              End;

            masPlacaVeiculo : Begin
                                TcxGridDBColumn(cxItem).PropertiesClass := TcxMaskEditProperties;;
                                TcxMaskEditProperties(TcxGridDBColumn(cxItem).Properties).ImmediatePost := True;
                                TcxMaskEditProperties(TcxGridDBColumn(cxItem).Properties).EditMask := 'lll-9999;1;_';

                                If Not fEmptyStr(fScriptValidate) Then
                                Begin
                                  TcxMaskEditProperties(TcxGridDBColumn(cxItem).Properties).OnValidate := pConsultaViewValidate;
                                  blnValidate := True;
                                End;
                              End;

            masCondPagto    : Begin
                                TcxGridDBColumn(cxItem).PropertiesClass := TcxMaskEditProperties;;
                                TcxMaskEditProperties(TcxGridDBColumn(cxItem).Properties).ImmediatePost := True;
                                TcxMaskEditProperties(TcxGridDBColumn(cxItem).Properties).EditMask := MASK_CONPAG4;

                                If Not fEmptyStr(fScriptValidate) Then
                                Begin
                                  TcxMaskEditProperties(TcxGridDBColumn(cxItem).Properties).OnValidate := pConsultaViewValidate;
                                  blnValidate := True;
                                End;
                              End;
          End;

        End;

        SetLength(FFonteNomCam, Succ(Length(FFonteNomCam)));
        with FFonteNomCam[High(FFonteNomCam)] do
        begin
          strNomCam := FieldByName('CAM_NOMCAM').AsString;
          strTipCam := FieldByName('CAM_TIPCAM').AsString;
          strFntCnd := FieldByName('CAM_FNTCND').AsString;
          strFntCam := FieldByName('CAM_FNTCAM').AsString;
          strFntOri := objGeraFr3.FFontInicialMasterData;
        end;

        if (not fEmptyStr(FieldByName(strCampoGuia).AsString)) and blnValidouVisibilidade then
        begin
          if (not fEmptyStr(FieldByName('CAM_FNTCND').AsString)) and (not fEmptyStr(FieldByName('CAM_FNTCAM').AsString)) then
            cxItem.Tag := 1
          else
            cxItem.Tag := 0;
        end
        else
        begin
          cxItem.Visible := False;
          cxItem.Tag := 0;
        end;

        cxItem.OnGetDisplayText := pConsultaViewColumnGetDisplayText;

        If cxItem.Options.Editing And (Not fEmptyStr(fScriptValidate)) And (Not blnValidate) Then
        Begin

          If SameText(FieldByName('CAM_TIPCAM').AsString, String(ArrDesInterface[facDate])) Then
          Begin
            TcxGridDBColumn(cxItem).PropertiesClass := TcxDateEditProperties;
            TcxDateEditProperties(TcxGridDBColumn(cxItem).Properties).ImmediatePost := True;
            TcxDateEditProperties(TcxGridDBColumn(cxItem).Properties).OnValidate := pConsultaViewValidate;
            TcxGridDBColumn(cxItem).MinWidth := 80;
          End Else

          Begin
            TcxGridDBColumn(cxItem).PropertiesClass := TcxTextEditProperties;
            TcxTextEditProperties(TcxGridDBColumn(cxItem).Properties).ImmediatePost := True;
            TcxTextEditProperties(TcxGridDBColumn(cxItem).Properties).OnValidate := pConsultaViewValidate;
          End;

        End;

        If SameText(FieldByName('CAM_INTERF').AsString, 'S') Then
        Begin
          TcxGridDBColumn(cxItem).PropertiesClass := TcxCheckBoxProperties;
          TcxCheckBoxProperties(TcxGridDBColumn(cxItem).Properties).ImmediatePost := True;
          TcxCheckBoxProperties(TcxGridDBColumn(cxItem).Properties).ValueChecked := FieldByName('CAM_VALCHE').AsString;
          TcxCheckBoxProperties(TcxGridDBColumn(cxItem).Properties).ValueUnchecked := FieldByName('CAM_VALUNC').AsString;

          If Not fEmptyStr(fScriptValidate) Then
            TcxCheckBoxProperties(TcxGridDBColumn(cxItem).Properties).OnValidate := pConsultaViewValidate;

          If SameText(FieldByName('CAM_MARCAR').AsString, 'S') Then
            pCriaBotoesMarcarDesmarcarTodos;
        End;

      End;

      Next;

    End;

  End;

  stlLegendas := TStringList.Create;
  stlLegendas.Sorted := True;

  FCoresColunas.First;
  While Not FCoresColunas.Eof Do
  Begin
    cxItem := FDataController.GetItemByFieldName(FCoresColunas.FieldByName('campo_cor').AsString);

    If Assigned(cxItem) Then
    Begin
      FCoresColunas.Edit;
      FCoresColunas.FieldByName('index_coluna').AsInteger := cxItem.Index;
      FCoresColunas.Post;

      If Not stlLegendas.Find(FCoresColunas.FieldByName('campo_cor').AsString, intIndex) Then
      Begin
        stlLegendas.Add(FCoresColunas.FieldByName('campo_cor').AsString);

        If FGeraFr3.cdsCamposG.Locate('CAM_NOMCAM', FCoresColunas.FieldByName('campo_cor').AsString, []) Then
          pMontaLegenda;
      End;

    End;

    FCoresColunas.Next;
  End;

  FreeAndNil(stlLegendas);
End;

procedure TGridRelatorio.pMontaLegenda;
  Var
    pnlLegendas: TPanel;
    grbLegendaRef,
    grbLegendas: TGroupBox;
    intMaxLef,
    intLeft,
    intTop,
    intLinha,
    intLinhas: Integer;
    objLegendas: TLegendasGridRelat;
    shpShape: TShape;
    lblLegenda: TLabel;
Begin
  objLegendas := TLegendasGridRelat.Create(Self);

  Try
    objLegendas.fCarregaLegendas(FGeraFr3.cdsCamposG.FieldByName('CAM_LEGEND').AsString);

    If objLegendas.IsEmpty Then
      Exit;

    If FGrupoCampos Or (mntMontagemGrid = mntExcelGrid) Then
      pnlLegendas := fraBandedGridFrm.pnlLegendas
    Else
      pnlLegendas := fraGridFrm.pnlLegendas;

    pnlLegendas.Visible := True;

    grbLegendas := TGroupBox.Create(pnlLegendas);
    grbLegendas.Parent := pnlLegendas;

    grbLegendas.Top  := 10;
    grbLegendas.Left := 10;

    If (Not fEmptyStr(FGeraFr3.cdsCamposG.FieldByName('CAM_LEGREF').AsString)) Then
    Begin
      grbLegendaRef := TGroupBox(pnlLegendas.FindComponent('grbLegenda' + FGeraFr3.cdsCamposG.FieldByName('CAM_LEGREF').AsString));

      If Assigned(grbLegendaRef) Then
      Begin

        If FGeraFr3.cdsCamposG.FieldByName('CAM_POSLEG').AsString = 'D' Then
        Begin
          grbLegendas.Top  := grbLegendaRef.Top;
          grbLegendas.Left := grbLegendaRef.Left + grbLegendaRef.Width + 10;
        End Else
        Begin
          grbLegendas.Top  := grbLegendaRef.Top + grbLegendaRef.Height + 10;
          grbLegendas.Left := grbLegendaRef.Left;
        End;

      End;
    End;

    grbLegendas.Height := 20;
    grbLegendas.Name := 'grbLegenda' + FGeraFr3.cdsCamposG.FieldByName('CAM_NOMCAM').AsString;

    lblLegenda := TLabel.Create(pnlLegendas);
    lblLegenda.Parent := grbLegendas;
    lblLegenda.AutoSize := True;

    grbLegendas.Width := 50;
    If grbLegendas.Width < lblLegenda.Width + 20 Then
      grbLegendas.Width := lblLegenda.Width + 20;

    FreeAndNil(lblLegenda);

    intLinhas := Ceil(objLegendas.RecordCount / FGeraFr3.cdsCamposG.FieldByName('CAM_COLLEG').AsInteger);

    intLeft := 5;

    If fEmptyStr(FGeraFr3.cdsCamposG.FieldByName('CAM_TITLEG').AsString) Then
      intTop := 6
    Else
      intTop := 20;

    intMaxLef := 0;
    intLinha := 1;

    objLegendas.First;
    While Not objLegendas.Eof Do
    Begin
      shpShape := TShape.Create(pnlLegendas);
      shpShape.Parent := grbLegendas;
      shpShape.Left := intLeft;
      shpShape.Top := intTop;
      shpShape.Width := 17;
      shpShape.Height := 14;
      shpShape.Brush.Color := objLegendas.FieldByName('cor').AsInteger;

      lblLegenda := TLabel.Create(pnlLegendas);
      lblLegenda.Parent := grbLegendas;
      lblLegenda.Left := shpShape.Left + shpShape.Width + 2;
      lblLegenda.Top := intTop;
      lblLegenda.Caption := objLegendas.FieldByName('legenda').AsString;
      lblLegenda.AutoSize := True;

      If lblLegenda.Left + lblLegenda.Width > intMaxLef Then
        intMaxLef := lblLegenda.Left + lblLegenda.Width;

      inc(intTop, lblLegenda.Height + 2);
      inc(intLinha);

      If intLinha > intLinhas  Then
      Begin
        intLinha := 1;
        intLeft := 20 + intMaxLef;

        If fEmptyStr(FGeraFr3.cdsCamposG.FieldByName('CAM_TITLEG').AsString) Then
          intTop := 6
        Else
          intTop := 20;
      End;

      If grbLegendas.Height < intTop + lblLegenda.Height + 5 Then
        grbLegendas.Height := intTop + lblLegenda.Height + 5;

      If grbLegendas.Width < intMaxLef + 10 Then
        grbLegendas.Width := intMaxLef + 10;

      objLegendas.Next;
    End;

    If pnlLegendas.Height < grbLegendas.Top + grbLegendas.Height + 10 Then
      pnlLegendas.Height := grbLegendas.Top + grbLegendas.Height + 10;

    grbLegendas.Caption := FGeraFr3.cdsCamposG.FieldByName('CAM_TITLEG').AsString;

    // Ajusta posicao Botoes
    fGetFlowPanel;

  Finally
    FreeAndNil(objLegendas);
  End;

End;

procedure TGridRelatorio.pConsultaViewCustomDrawGroupCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If Not AViewInfo.Selected Then
  Begin
    ACanvas.Font.Style := [fsBold];

    Case TcxGridGroupRow(AViewInfo.GridRecord).Level Of
      0: ACanvas.Brush.Color := dtmModuloGrid.cxsQuebra1.Color;
      1: ACanvas.Brush.Color := dtmModuloGrid.cxsQuebra2.Color;
      2: ACanvas.Brush.Color := dtmModuloGrid.cxsQuebra3.Color;
    End;
  End;

end;

procedure TGridRelatorio.pCustomDrawCellColuna(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    intIndexCampoFonte,
    intColor,
    intBrushColor: Integer;
    strFontStyles,
    strNomCam,
    strFontName,
    strDefFonte: String;
begin

  strNomCam := TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName;

  If Not FCoresColunas.locate('campo', strNomCam, []) Then
    Exit;

  If FCoresColunas.FieldByName('index_coluna').IsNull Then
    Exit;

  intIndexCampoFonte := FCoresColunas.FieldByName('index_coluna').AsInteger;

  If intIndexCampoFonte > -1 Then
  Begin
    strDefFonte := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, intIndexCampoFonte]);

    strFontName   := TdtmRelFrx.fRetornaFontName(strDefFonte);
    intColor      := TdtmRelFrx.fRetornaFontColor(strDefFonte);
    strFontStyles := TdtmRelFrx.fRetornaFontStyles(strDefFonte);
    intBrushColor := TdtmRelFrx.fRetornaBrushColor(strDefFonte);

    If Not strFontName.IsEmpty Then
      ACanvas.Font.Name := strFontName;

    If intColor > -1 Then
      ACanvas.Font.color := intColor;

    If intBrushColor > -1 Then
      ACanvas.Brush.Color := intBrushColor;

    If Not strFontStyles.IsEmpty Then
    Begin
      ACanvas.Font.Style := [];

      If Pos('fsBold', strFontStyles) > 0 Then
        ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];

      If Pos('fsItalic', strFontStyles) > 0 Then
        ACanvas.Font.Style := ACanvas.Font.Style + [fsItalic];

      If Pos('fsUnderline', strFontStyles) > 0 Then
        ACanvas.Font.Style := ACanvas.Font.Style + [fsUnderline];

      If Pos('fsStrikeOut', strFontStyles) > 0 Then
        ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
    End;

  End;
end;

procedure TGridRelatorio.pConsultaViewColumnCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);

var
  intContador: Integer;

  function fFormataFntCnd(strFntCnd, strTipCam: string): string;
  var
    intContador: Integer;
    strValor: string;
  begin

    for intContador := Low(FFonteNomCam) To High(FFonteNomCam) do
    begin
      if AnsiMatchStr(FFonteNomCam[intContador].strTipCam, ['Texto', 'Data']) then
        strValor := QuotedStr(VarToStr(AViewInfo.GridRecord.Values[TcxGridDBTableView(Sender).GetColumnByFieldName(FFonteNomCam[intContador].strNomCam).Index]))
      else
        strValor := VarToStr(AViewInfo.GridRecord.Values[TcxGridDBTableView(Sender).GetColumnByFieldName(FFonteNomCam[intContador].strNomCam).Index]);

      if Pos('<<' + strValor + '>>', strFntCnd) <= 0 then
        strFntCnd := AnsiReplaceStr(strFntCnd, FFonteNomCam[intContador].strNomCam, '<<' + strValor + '>>');
    end;

    Result := AnsiReplaceStr(AnsiReplaceStr(strFntCnd, '<<', ''), '>>', '');;
  end;

  function fLocalizaFonteValida(strExpres: string): Boolean;
  var
    intContador: Integer;
    blnColore,
    blnAchouExpressao: Boolean;
  begin
    blnColore := False;
    blnAchouExpressao := False;
    for intContador := Low(FFonteValida) To High(FFonteValida) do
    begin
      if strExpres = FFonteValida[intContador].strExpres then
      begin
        blnAchouExpressao := True;
        blnColore := FFonteValida[intContador].blnColore;
        Break;
      end;
    end;
    if not blnAchouExpressao then
    begin
      blnColore := FGeraFr3.fExecutaExpressao(strExpres);
      SetLength(FFonteValida, Succ(Length(FFonteValida)));
      FFonteValida[High(FFonteValida)].strExpres := strExpres;
      FFonteValida[High(FFonteValida)].blnColore := blnColore;
    end;
    Result := blnColore;
  end;

begin
  inherited;

  if TcxGridDBColumn(AViewInfo.Item).Tag = 1 then
  begin
    for intContador := Low(FFonteNomCam) To High(FFonteNomCam) do
    begin
      if TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName = FFonteNomCam[intContador].strNomCam then
      begin
        if (not fEmptyStr(FFonteNomCam[intContador].strFntOri)) then
        begin
          try
            ACanvas.Font := TInterfaceRelatorio.StrToFont(FFonteNomCam[intContador].strFntOri);
          finally
          end;
        end;

        if (not fEmptyStr(FFonteNomCam[intContador].strFntCnd)) and (not fEmptyStr(FFonteNomCam[intContador].strFntCam)) then
          if fLocalizaFonteValida(fFormataFntCnd(FFonteNomCam[intContador].strFntCnd, FFonteNomCam[intContador].strTipCam)) then
            ACanvas.Font := TInterfaceRelatorio.StrToFont(FFonteNomCam[intContador].strFntCam);
        Break;
      end;
    end;
  end;
end;

procedure TGridRelatorio.pConsultaViewColumnGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;

  if Pos('<<LINEUP>>', AText) > 0 then
    AText := AnsiReplaceStr(AText, '<<LINEUP>>', '');
  if Pos('<<LINEDOWN>>', AText) > 0 then
    AText := AnsiReplaceStr(AText, '<<LINEDOWN>>', '');
  if Pos('<<LINELEFT>>', AText) > 0 then
    AText := AnsiReplaceStr(AText, '<<LINELEFT>>', '');
  if Pos('<<LINERIGHT>>', AText) > 0 then
    AText := AnsiReplaceStr(AText, '<<LINERIGHT>>', '');
end;

procedure TGridRelatorio.pFilterChanged(Sender: TObject);
var
  intCont: Integer;
  frmForm: TForm;
begin
  pCalculaTotaisFormula;

  frmForm := TForm(TForm(FDataController.GridView.Owner).Owner);

  for intCont := 0 to frmForm.ComponentCount -1 do
  begin
    if frmForm.Components[intCont] is TPanel then
    begin
      if TPanel(frmForm.Components[intCont]).Name = 'pnlInfo' then
      begin
        TPanel(frmForm.Components[intCont]).Caption := 'Registros: ' + IntToStr(FDataController.FilteredRecordCount);
        Break;
      end;
    end;
  end;

end;

procedure TGridRelatorio.pConsultaViewStylesGetFooterSummaryStyle(
  AView: TcxGridTableView; ARow: TcxCustomGridRow; AColumn: TcxGridColumn;
  AFooterGroupLevel: Integer; ASummaryItem: TcxDataSummaryItem;
  var AStyle: TcxStyle);
begin
  inherited;

  Case AFooterGroupLevel Of
   -1: AStyle := dtmModuloGrid.cxsFooter;
    0: AStyle := dtmModuloGrid.cxsQuebra1;
    1: AStyle := dtmModuloGrid.cxsQuebra2;
    2: AStyle := dtmModuloGrid.cxsQuebra3;
  End;

end;

// Gupos de Cabeçalho
Function TGridRelatorio.fTemGrupoDeCampos: Boolean;
Begin
  FcdsCampos.Filter   := 'CAM_CODGRU <> ' + QuotedStr('');
  FcdsCampos.Filtered := True;

  Result := Not FcdsCampos.IsEmpty;

  FcdsCampos.Filtered := False;
End;

Procedure TGridRelatorio.pConfiguraGrid;
Begin
  If FGeraFr3.arrCadRel[0].FieldByName('REL_CORZEB').AsInteger <> 0 Then
    cxsZebra.Color := FGeraFr3.arrCadRel[0].FieldByName('REL_CORZEB').AsInteger;

  If cxsZebra.Color = -16777216 Then
    cxsZebra.Color := strToInt(fCfgSis('CORZED'));

  With FcxConsulta Do
  Begin
    Align := alClient;
    LookAndFeel.Kind := lfFlat;
    LookAndFeel.NativeStyle := FALSE;
  End;

  If Assigned(FConsultaView) Then
  With FConsultaView Do
  Begin
    OnCustomDrawGroupCell := pConsultaViewCustomDrawGroupCell;
    OnCustomDrawCell := pConsultaViewColumnCustomDrawCell;
    DataController.Filter.OnChanged := pFilterChanged;
    Styles.OnGetFooterSummaryStyle := pConsultaViewStylesGetFooterSummaryStyle;
    Styles.ContentEven := cxsZebra;
    Styles.Header := dtmModuloGrid.cxsHeader;
  End;

  If Assigned(FConsultaBandedView) Then
  With FConsultaBandedView Do
  Begin
    OnCustomDrawGroupCell := pConsultaViewCustomDrawGroupCell;
    OnCustomDrawCell := pConsultaViewColumnCustomDrawCell;
    DataController.Filter.OnChanged := pFilterChanged;
    Styles.OnGetFooterSummaryStyle := pConsultaViewStylesGetFooterSummaryStyle;
    Styles.ContentEven := cxsZebra;
    Styles.Header := dtmModuloGrid.cxsHeader;
  End;
End;

procedure TGridRelatorio.tmrRefreshDadosTimer(Sender: TObject);
  Var
    strTitulo: String;
begin
  Try
    tmrRefreshDados.Enabled := False;

    If Assigned(shtTabSheet) Then
      strTitulo := shtTabSheet.Caption
    Else
      strTitulo := frmGridRelatResult.Caption;

    If Assigned(shtTabSheet) Then
      shtTabSheet.Caption := 'Atualizando...'
    Else
      frmGridRelatResult.Caption := 'Atualizando...';

    Application.ProcessMessages;

    dtsSource.DataSet.Refresh;

  Except
    If Assigned(shtTabSheet) Then
      shtTabSheet.Caption := 'Erro de atualização...'
    Else
      frmGridRelatResult.Caption := 'Erro de atualização...';

    Application.ProcessMessages;
    Sleep(2000);
  End;

  If Assigned(shtTabSheet) Then
    shtTabSheet.Caption := strTitulo
  Else
    frmGridRelatResult.Caption := strTitulo;

  Application.ProcessMessages;
  tmrRefreshDados.Enabled := True;
end;

Function TGridRelatorio.fTemCampoAlinhadoPeloConteudo: Boolean;
  Var
    cdsCamposRodape: TZClient;
Begin
  Result := False;

  cdsCamposRodape := TInterfaceRelatorio(FGeraFr3.objInterfaceGera).cdsCamposRodape;

  cdsCamposRodape.First;
  While Not cdsCamposRodape.Eof Do
  Begin
    If (Not cdsCamposRodape.FieldByName('CAM_POSREL').IsNull) And
       (cdsCamposRodape.FieldByName('CAM_POSREL').AsInteger = ABAIXO_CONTEUDO) Then
    Begin
      Result := True;
      Exit;
    End;

    cdsCamposRodape.Next;
  End;
End;

procedure TGridRelatorio.pMontaRodapeGrid;
Begin
  If TInterfaceRelatorio(FGeraFr3.objInterfaceGera).cdsCamposRodape.IsEmpty Then
    Exit;

  TInterfaceRelatorio(FGeraFr3.objInterfaceGera).cdsCamposRodape.DisableControls;

  If FGeraFr3.arrCadRel[0].FieldByName('REL_ALIROD').AsInteger = LAYOUT_SIMPLES Then
    pMontaRodapeGridSimples
  Else If (FGeraFr3.arrCadRel[0].FieldByName('REL_LAYROD').AsInteger = TITULO_AFRENTE) And fTemCampoAlinhadoPeloConteudo Then
    pMontaRodapeGridDetalhadoColunado
  Else
    pMontaRodapeGridDetalhado;

  TInterfaceRelatorio(FGeraFr3.objInterfaceGera).cdsCamposRodape.EnableControls;
End;

procedure TGridRelatorio.pCriaTituloRodape(Var lblTitulo: TLabel; cdsCamposRodape, cdscampos: TZClient; pnlRodapeGrid: TPanel);
  Var
    intNumDec: Integer;
Begin
  intNumDec := cdsCampos.FieldByName('CAM_NRODEC').AsInteger;

  Case TInterfaceRelatorio.fDescMascaraToTipo(cdsCampos.FieldByName('CAM_MASCAR').AsString) Of
    masTelefone     : FSource.DataSet.FieldByName(cdsCamposRodape.FieldByName('CAM_NOMCAM').AsString).EditMask := fRetMascaraFonePais;

    masCEP          : FSource.DataSet.FieldByName(cdsCamposRodape.FieldByName('CAM_NOMCAM').AsString).EditMask := '99999-999;0;_';

    masPlacaVeiculo : FSource.DataSet.FieldByName(cdsCamposRodape.FieldByName('CAM_NOMCAM').AsString).EditMask := 'lll-9999;0;_';

    masCondPagto    : FSource.DataSet.FieldByName(cdsCamposRodape.FieldByName('CAM_NOMCAM').AsString).EditMask := MASK_CONPAG;

    masDecUni       : intNumDec := fCfgSis('DECUNI', varInteger);

    masDecQtd       : intNumDec := fCfgSis('DECQTD', varInteger);

    masDeqTpc       : intNumDec := fCfgSis('DEQTPC', varInteger);

    masEstDec       : intNumDec := fCfgSis('ESTDEC', varInteger);
  End;

  If FSource.DataSet.FieldByName(cdsCamposRodape.FieldByName('CAM_NOMCAM').AsString).DataType = ftFloat Then
    TFloatField(FSource.DataSet.FieldByName(cdsCamposRodape.FieldByName('CAM_NOMCAM').AsString)).DisplayFormat := '#,##0.' + fStrZero('0', intNumDec);

  lblTitulo         := TLabel.Create(pnlRodapeGrid);
  lblTitulo.Name    := Concat('lblRodape', intIndexRelatorio.ToString, cdsCamposRodape.FieldByName('CAM_NOMCAM').AsString);
  lblTitulo.Parent  := pnlRodapeGrid;
  lblTitulo.Caption := cdsCamposRodape.FieldByName('CAM_DESCAM').AsString;

  If FGeraFr3.arrCadRel[0].FieldByName('REL_LAYROD').AsInteger = TITULO_AFRENTE Then
    lblTitulo.Caption := lblTitulo.Caption + ':';

  lblTitulo.AutoSize := True;
End;

procedure TGridRelatorio.pCriaCampoRodape(Var winCampo: TWinControl; cdsCamposRodape, cdscampos: TZClient; pnlRodapeGrid: TPanel);
  Var
    dbeEdit: TDBEditFocus;
    dbeMemo: TDBMemoFocus;
Begin
  If FSource.DataSet.FieldByName(cdsCamposRodape.FieldByName('CAM_NOMCAM').AsString).DataType = ftMemo Then
  Begin
    dbeMemo := TDBMemoFocus.Create(pnlRodapeGrid);
    dbeMemo.DataSource := FSource;
    dbeMemo.DataField  := cdsCamposRodape.FieldByName('CAM_NOMCAM').AsString;
    dbeMemo.ReadOnly   := True;
    dbeMemo.ScrollBars := ssBoth;
    winCampo := dbeMemo;
  End Else
  Begin
    dbeEdit := TDBEditFocus.Create(pnlRodapeGrid);
    dbeEdit.DataSource := FSource;
    dbeEdit.DataField  := cdsCamposRodape.FieldByName('CAM_NOMCAM').AsString;
    dbeEdit.ReadOnly   := True;
    winCampo := dbeEdit;
  End;

  winCampo.Name    := Concat('dbeRodape', intIndexRelatorio.ToString, cdsCamposRodape.FieldByName('CAM_NOMCAM').AsString);
  winCampo.Parent := pnlRodapeGrid;
  winCampo.Width := Trunc(fCmColunaToPixel(cdsCamposRodape.FieldByName('CAM_LARGUR').AsFloat, False, 'J', False));

  If Trunc(fCmColunaToPixel(cdsCamposRodape.FieldByName('CAM_ALTURA').AsFloat, True, 'J', False)) > 0 Then
    winCampo.Height := Trunc(fCmColunaToPixel(cdsCamposRodape.FieldByName('CAM_ALTURA').AsFloat, True, 'J', False));
End;

procedure TGridRelatorio.pInicializaDadodsRodape(Var winCampo: TWinControl;
                                                 Var cdsCamposRodape, cdscampos: TZClient;
                                                 Var pnlRodapeGrid: TPanel;
                                                 Var intTop, intLeft, intMaxTop: Integer);
Begin
  winCampo := Nil;

  If FGrupoCampos Or (mntMontagemGrid = mntExcelGrid) Then
    pnlRodapeGrid := fraBandedGridFrm.pnlRodapeGrid
  Else
    pnlRodapeGrid := fraGridFrm.pnlRodapeGrid;

  cdsCamposRodape := TInterfaceRelatorio(FGeraFr3.objInterfaceGera).cdsCamposRodape;

  cdscampos := TInterfaceRelatorio(FGeraFr3.objInterfaceGera).cdsCampos;

  cdsCamposRodape.IndexFieldNames := 'CAM_ORDROD';
  cdsCamposRodape.First;

  If FGeraFr3.arrCadRel[0].FieldByName('REL_LAYROD').AsInteger = TITULO_ACIMA Then
    intTop  := 7
  Else
    intTop  := 12;

  intLeft := 7;

  intMaxTop := 0;
End;

procedure TGridRelatorio.pMontaRodapeGridSimples;
  Var
    pnlRodapeGrid: TPanel;
    intMaxTop,
    intTop,
    intLeft: Integer;
    winCampo: TWinControl;
    cdsCamposRodape,
    cdscampos: TZClient;
    lblTitulo: TLabel;
Begin
  pInicializaDadodsRodape(winCampo, cdsCamposRodape, cdscampos, pnlRodapeGrid, intTop, intLeft, intMaxTop);

  While Not cdsCamposRodape.Eof Do
  Begin
    If cdscampos.Locate('CAM_NOMCAM', cdsCamposRodape.FieldByName('CAM_NOMCAM').AsString, []) Then
    Begin
      pCriaTituloRodape(lblTitulo, cdsCamposRodape, cdscampos, pnlRodapeGrid);

      lblTitulo.top     := intTop;
      lblTitulo.Left    := intLeft;

      pCriaCampoRodape(winCampo, cdsCamposRodape, cdscampos, pnlRodapeGrid);

      If FGeraFr3.arrCadRel[0].FieldByName('REL_LAYROD').AsInteger = TITULO_ACIMA then
      Begin
        winCampo.Top  := lblTitulo.top + lblTitulo.Height;
        winCampo.Left := lblTitulo.left;
      End Else
      Begin
        winCampo.Top  := lblTitulo.top - 5;
        winCampo.Left := lblTitulo.Left + lblTitulo.Width + 2;
      End;

      If frmGridRelatResult.intFinalRodape < winCampo.Left + winCampo.Width Then
        frmGridRelatResult.intFinalRodape := winCampo.Left + winCampo.Width;

      intLeft := winCampo.Left + winCampo.Width + 5;

      If intMaxTop < winCampo.Top + winCampo.Height Then
        intMaxTop := winCampo.Top + winCampo.Height;

      If intMaxTop < lblTitulo.Top + lblTitulo.Height Then
        intMaxTop := lblTitulo.Top + lblTitulo.Height;
    End; {If cdscampos.Locate('CAM_NOMCAM', cdsCamposRodape.FieldByName('CAM_NOMCAM').AsString, []) Then}

    cdsCamposRodape.Next;

    If SameText(cdsCamposRodape.FieldByName('CAM_NOVROD').AsString, 'S') Then
    Begin
      intLeft := 7;

      If FGeraFr3.arrCadRel[0].FieldByName('REL_LAYROD').AsInteger = TITULO_ACIMA Then
        intTop  := intMaxTop + 3
      Else
        intTop  := intMaxTop + 8;
    End;

  End; {While Not cdsCamposRodape.Eof Do}

  pnlRodapeGrid.Visible := True;

  If Assigned(winCampo) Then
    pnlRodapeGrid.Height := winCampo.Top + winCampo.Height + 7;
End;

procedure TGridRelatorio.pMontaRodapeGridDetalhado;
  Var
    pnlRodapeGrid: TPanel;
    intMaxTop,
    intTop,
    intLeft: Integer;
    winCampo,
    lblCampoRef,
    dbeCampoRef: TWinControl;
    cdsCamposRodape,
    cdscampos: TZClient;
    lblTitulo: TLabel;
Begin
  lblCampoRef := Nil;
  dbeCampoRef := Nil;

  pInicializaDadodsRodape(winCampo, cdsCamposRodape, cdscampos, pnlRodapeGrid, intTop, intLeft, intMaxTop);

  While Not cdsCamposRodape.Eof Do
  Begin
    If cdscampos.Locate('CAM_NOMCAM', cdsCamposRodape.FieldByName('CAM_NOMCAM').AsString, []) Then
    Begin
      pCriaTituloRodape(lblTitulo, cdsCamposRodape, cdscampos, pnlRodapeGrid);

      If cdsCamposRodape.RecNo = 1 Then
      Begin
        lblTitulo.top  := intTop;
        lblTitulo.Left := intLeft;
      End Else
      Begin
        lblCampoRef := TWinControl(pnlRodapeGrid.FindComponent(Concat('lblRodape', intIndexRelatorio.ToString, cdsCamposRodape.FieldByName('CAM_REFROD').AsString)));
        dbeCampoRef := TWinControl(pnlRodapeGrid.FindComponent(Concat('dbeRodape', intIndexRelatorio.ToString, cdsCamposRodape.FieldByName('CAM_REFROD').AsString)));

        If Assigned(lblCampoRef) And Assigned(dbeCampoRef) Then
        Begin

          Case cdsCamposRodape.FieldByName('CAM_POSREL').AsInteger Of
            ABAIXO_CONTEUDO: Begin
                               If FGeraFr3.arrCadRel[0].FieldByName('REL_LAYROD').AsInteger = TITULO_AFRENTE Then
                               Begin
                                 lblTitulo.top  := dbeCampoRef.top + dbeCampoRef.Height + 8;
                                 lblTitulo.Left := lblCampoRef.Left;
                               End Else
                               Begin
                                 lblTitulo.top  := dbeCampoRef.top + dbeCampoRef.Height + 3;
                                 lblTitulo.Left := dbeCampoRef.Left;
                               End;
                             End;

            ABAIXO_TITULO: Begin;
                             If FGeraFr3.arrCadRel[0].FieldByName('REL_LAYROD').AsInteger = TITULO_AFRENTE Then
                               lblTitulo.top  := dbeCampoRef.top + dbeCampoRef.Height + 8
                             Else
                                lblTitulo.top  := dbeCampoRef.top + dbeCampoRef.Height + 3;

                             lblTitulo.Left := lblCampoRef.Left;
                           End;

            DIREITA: Begin
                       lblTitulo.top  := lblCampoRef.top;
                       lblTitulo.Left := dbeCampoRef.Left + dbeCampoRef.Width + 5;
                     End;
          End;

        End;
      End;

      pCriaCampoRodape(winCampo, cdsCamposRodape, cdscampos, pnlRodapeGrid);

      If FGeraFr3.arrCadRel[0].FieldByName('REL_LAYROD').AsInteger = TITULO_ACIMA then
      Begin
        winCampo.Top  := lblTitulo.top + lblTitulo.Height;
        winCampo.Left := lblTitulo.left;
      End Else
      Begin
        winCampo.Top  := lblTitulo.top - 5;

        If cdsCamposRodape.RecNo = 1 Then
        Begin
          winCampo.Left := lblTitulo.Left + lblTitulo.Width + 2;
        End

        Else If Assigned(lblCampoRef) And Assigned(dbeCampoRef) Then
          Case cdsCamposRodape.FieldByName('CAM_POSREL').AsInteger Of
            ABAIXO_CONTEUDO: winCampo.Left := dbeCampoRef.Left;

            Else             winCampo.Left := lblTitulo.Left + lblTitulo.Width + 2;
          End;

      End;

      If frmGridRelatResult.intFinalRodape < winCampo.Left + winCampo.Width Then
        frmGridRelatResult.intFinalRodape := winCampo.Left + winCampo.Width;

      If intMaxTop < winCampo.Top + winCampo.Height Then
        intMaxTop := winCampo.Top + winCampo.Height;

      If intMaxTop < lblTitulo.Top + lblTitulo.Height Then
        intMaxTop := lblTitulo.Top + lblTitulo.Height;
    End; {If cdscampos.Locate('CAM_NOMCAM', cdsCamposRodape.FieldByName('CAM_NOMCAM').AsString, []) Then}

    cdsCamposRodape.Next;

  End; {While Not cdsCamposRodape.Eof Do}

  pnlRodapeGrid.Visible := True;

  If Assigned(winCampo) Then
    pnlRodapeGrid.Height := intMaxTop + 7;
End;

procedure TGridRelatorio.pMontaRodapeGridDetalhadoColunado;
  Var
    pnlRodapeGrid: TPanel;
    intMaxTop,
    intMaxWidth,
    intMaxLeft,
    intTop,
    intLeft,
    intRecNo: Integer;
    winCampo,
    lblCampoRef,
    dbeCampoRef: TWinControl;
    cdsCamposRodape,
    cdscampos: TZClient;
    lblTitulo: TLabel;
Begin
  lblCampoRef := Nil;
  dbeCampoRef := Nil;

  pInicializaDadodsRodape(winCampo, cdsCamposRodape, cdscampos, pnlRodapeGrid, intTop, intLeft, intMaxTop);

  intMaxWidth := 0;
  intMaxLeft  := 0;

  While Not cdsCamposRodape.Eof Do
  Begin
    If (cdsCamposRodape.RecNo = 1 ) Or (cdsCamposRodape.FieldByName('CAM_POSREL').AsInteger = DIREITA) Then
    Begin
      intRecNo := cdsCamposRodape.RecNo;
      intMaxLeft  := 0;
      intMaxWidth := 0;

      While (Not cdsCamposRodape.Eof) Do
      Begin
        If frmGridRelatResult.Canvas.TextWidth(cdsCamposRodape.FieldByName('CAM_DESCAM').AsString + ':') > intMaxWidth Then
          intMaxWidth := frmGridRelatResult.Canvas.TextWidth(cdsCamposRodape.FieldByName('CAM_DESCAM').AsString + ':');

        cdsCamposRodape.Next;

        If (cdsCamposRodape.FieldByName('CAM_POSREL').AsInteger = DIREITA) Then
          Break;
      End;

      cdsCamposRodape.RecNo := intRecNo;
    End;

    If cdscampos.Locate('CAM_NOMCAM', cdsCamposRodape.FieldByName('CAM_NOMCAM').AsString, []) Then
    Begin
      pCriaTituloRodape(lblTitulo, cdsCamposRodape, cdscampos, pnlRodapeGrid);

      lblTitulo.Left := intLeft;

      If cdsCamposRodape.RecNo = 1 Then
      Begin
        lblTitulo.top  := intTop;
      End Else
      Begin
        lblCampoRef := TWinControl(pnlRodapeGrid.FindComponent(Concat('lblRodape', intIndexRelatorio.ToString, cdsCamposRodape.FieldByName('CAM_REFROD').AsString)));
        dbeCampoRef := TWinControl(pnlRodapeGrid.FindComponent(Concat('dbeRodape', intIndexRelatorio.ToString, cdsCamposRodape.FieldByName('CAM_REFROD').AsString)));

        If Assigned(lblCampoRef) And Assigned(dbeCampoRef) Then
        Begin

          Case cdsCamposRodape.FieldByName('CAM_POSREL').AsInteger Of
            ABAIXO_CONTEUDO: Begin
                               If FGeraFr3.arrCadRel[0].FieldByName('REL_LAYROD').AsInteger = TITULO_AFRENTE Then
                               Begin
                                 lblTitulo.top  := dbeCampoRef.top + dbeCampoRef.Height + 8;
                                // lblTitulo.Left := lblCampoRef.Left;
                               End Else
                               Begin
                                 lblTitulo.top  := dbeCampoRef.top + dbeCampoRef.Height + 3;
                                // lblTitulo.Left := dbeCampoRef.Left;
                               End;
                             End;

            ABAIXO_TITULO: Begin;
                             If FGeraFr3.arrCadRel[0].FieldByName('REL_LAYROD').AsInteger = TITULO_AFRENTE Then
                               lblTitulo.top  := dbeCampoRef.top + dbeCampoRef.Height + 8
                             Else
                                lblTitulo.top  := dbeCampoRef.top + dbeCampoRef.Height + 3;

                            // lblTitulo.Left := lblCampoRef.Left;
                           End;

            DIREITA: Begin
                       lblTitulo.top  := lblCampoRef.top;
                       lblTitulo.Left := dbeCampoRef.Left + dbeCampoRef.Width + 5;
                     End;
          End;

        End;
      End;

      lblTitulo.AutoSize  := False;
      lblTitulo.Width     := intMaxWidth;
      lblTitulo.Alignment := taRightJustify;

      pCriaCampoRodape(winCampo, cdsCamposRodape, cdscampos, pnlRodapeGrid);

      If FGeraFr3.arrCadRel[0].FieldByName('REL_LAYROD').AsInteger = TITULO_ACIMA then
      Begin
        winCampo.Top  := lblTitulo.top + lblTitulo.Height;
        winCampo.Left := lblTitulo.left;
      End Else
      Begin
        winCampo.Top  := lblTitulo.top - 5;

        If cdsCamposRodape.RecNo = 1 Then
        Begin
          winCampo.Left := lblTitulo.Left + lblTitulo.Width + 2;
        End

        Else If Assigned(lblCampoRef) And Assigned(dbeCampoRef) Then
          Case cdsCamposRodape.FieldByName('CAM_POSREL').AsInteger Of
            ABAIXO_CONTEUDO: winCampo.Left := dbeCampoRef.Left;

            Else             winCampo.Left := lblTitulo.Left + lblTitulo.Width + 2;
          End;

      End;

      If frmGridRelatResult.intFinalRodape < winCampo.Left + winCampo.Width Then
        frmGridRelatResult.intFinalRodape := winCampo.Left + winCampo.Width;

      If winCampo.Left + winCampo.Width > intMaxLeft Then
        intMaxLeft := winCampo.Left + winCampo.Width;

      If intMaxTop < winCampo.Top + winCampo.Height Then
        intMaxTop := winCampo.Top + winCampo.Height;

      If intMaxTop < lblTitulo.Top + lblTitulo.Height Then
        intMaxTop := lblTitulo.Top + lblTitulo.Height;
    End; {If cdscampos.Locate('CAM_NOMCAM', cdsCamposRodape.FieldByName('CAM_NOMCAM').AsString, []) Then}

    cdsCamposRodape.Next;

    If (cdsCamposRodape.FieldByName('CAM_POSREL').AsInteger = DIREITA) Then
      intLeft := intMaxLeft + 3;
  End; {While Not cdsCamposRodape.Eof Do}

  pnlRodapeGrid.Visible := True;

  If Assigned(winCampo) Then
    pnlRodapeGrid.Height := intMaxTop + 7;
End;

Function TGridRelatorioGeral.fGeraExcelJanela(AIndexRelatorio: Integer = -1; ANomArq: String = ''): Boolean;
Begin
  FIndexRelatorioExcel := AIndexRelatorio;
  FNomArqExel := ANomArq;

  Result := TfrmGravando.fExecuta(fGeraExcelPrg, frmGravando);
End;

Function TGridRelatorioGeral.fGeraExcelPrg(prgProgresso: TCxProgressBar): Boolean;
Begin
  Result := fGeraExcel(FIndexRelatorioExcel, FNomArqExel);
End;

Function TGridRelatorioGeral.fGeraExcel(AIndexRelatorio: Integer; ANomArq: String = ''): Boolean;
  Var
    objGeraExcel: TGeraExcelRelatorio;
    intIndexZebra: Integer;
Begin
  Result := False;

  Try
    objGeraExcel := TGeraExcelRelatorio.Create(Self);
    objGeraExcel.objGeraGR3 := objGeraFr3;
    objGeraExcel.grdGridRelatorioGeral := Self;

    If Not ANomArq.IsEmpty Then
      strNomeArq := ANomArq;

    If AIndexRelatorio = -1 Then
      intIndexZebra := 0
    Else
      intIndexZebra := AIndexRelatorio;

    objGeraExcel.strCorZebra := objGeraExcel.fColorToHtml(arrGrid[intIndexZebra].cxsZebra.Color);

    objGeraExcel.strNomeArquivo := strNomeArq;
    objGeraExcel.frmGravando := frmGravando;

    Result := objGeraExcel.fGeraExcel(AIndexRelatorio);

    FreeAndNil(objGeraExcel);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TGridRelatorioGeral.fGeraExcel]');
    End;
  End;

End;

constructor TDadosRelatorio.Create(ADados: TUniClientDataSet);
Begin
  FDados := ADados;
End;

Function TDadosRelatorio.FieldByName(FieldName: String): TField;
Begin
  Result := FDados.FieldByName(FieldName);
End;

constructor TBotaoGrid.Create(AOwner: TComponent);
Begin
  inherited Create(AOwner);

End;

destructor TBotaoGrid.Destroy;
Begin
  inherited;

End;

end.





