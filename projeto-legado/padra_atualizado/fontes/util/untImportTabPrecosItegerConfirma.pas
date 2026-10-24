unit untImportTabPrecosItegerConfirma;

interface

uses
 Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
 System.Classes, Vcl.Graphics, uni, untFuncoesSimples, untSalvaConfiguracaoGrid,
 Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
 frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
 BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
 cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
 cxNavigator, Data.DB, cxDBData, cxGridCustomTableView, cxGridTableView,
 cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
 untZClient, MyClassesUni, frxDBSet, Vcl.ComCtrls, cxContainer, cxProgressBar, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxCheckBox, cxGridDBDataDefinitions,
  cxCurrencyEdit, cxGridBandedTableView, cxGridDBBandedTableView,
  System.StrUtils;

 type
   TTipoCalculoImpCalculo = (tciMargem, tciVenda, tciIndefinido);

   TCalculo = record
     intTabela: integer;
     TipoCalculoImp: TTipoCalculoImpCalculo
   end;


  TfrmImportTabPrecosItegerConfirma = class(TfrmPaiConfirma)
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBTableView;
    cxgItensViewCodIte: TcxGridDBBandedColumn;
    cxgItensViewDesIte: TcxGridDBBandedColumn;
    cxgItensViewCodFab: TcxGridDBBandedColumn;
    cxgItensLevel1: TcxGridLevel;
    frxGen: TfrxUserDataSet;
    frxRelatorio: TfrxDBDataset;
    dtsDados: TDataSource;
    frxRepNaoImp: TfrxReport;
    cxgItensViewDESF01: TcxGridDBBandedColumn;
    cxgItensViewDESF01_NOV: TcxGridDBBandedColumn;
    cxgItensViewDESF02: TcxGridDBBandedColumn;
    cxgItensViewDESF02_NOV: TcxGridDBBandedColumn;
    cxgItensViewDESF03: TcxGridDBBandedColumn;
    cxgItensViewDESF03_NOV: TcxGridDBBandedColumn;
    cxgItensViewDESF04: TcxGridDBBandedColumn;
    cxgItensViewDESF04_NOV: TcxGridDBBandedColumn;
    cxgItensViewDESF05: TcxGridDBBandedColumn;
    cxgItensViewDESF05_NOV: TcxGridDBBandedColumn;
    cxgItensViewDESF06: TcxGridDBBandedColumn;
    cxgItensViewDESF06_NOV: TcxGridDBBandedColumn;
    cxgItensViewICMENT: TcxGridDBBandedColumn;
    cxgItensViewICMENT_NOV: TcxGridDBBandedColumn;
    cxgItensViewIMPFED: TcxGridDBBandedColumn;
    cxgItensViewIMPFED2: TcxGridDBBandedColumn;
    cxgItensViewIPIEnt: TcxGridDBBandedColumn;
    cxgItensViewIpiEnt_NOV: TcxGridDBBandedColumn;
    cxgItensViewFreEnt: TcxGridDBBandedColumn;
    cxgItensViewFreEnt_NOV: TcxGridDBBandedColumn;
    cxgItensViewValFre: TcxGridDBBandedColumn;
    cxgItensViewValFre_NOV: TcxGridDBBandedColumn;
    cxgItensViewACRFIN: TcxGridDBBandedColumn;
    cxgItensViewACRFIN_NOV: TcxGridDBBandedColumn;
    cxgItensViewSUBSTI_NOV: TcxGridDBBandedColumn;
    cxgItensViewDESADB: TcxGridDBBandedColumn;
    cxgItensViewDESADB_NOV: TcxGridDBBandedColumn;
    cxgItensViewICMSAI: TcxGridDBBandedColumn;
    cxgItensViewICMSAI_NOV: TcxGridDBBandedColumn;
    cxgItensViewSUBFED: TcxGridDBBandedColumn;
    cxgItensViewSUBFED_NOV: TcxGridDBBandedColumn;
    cxgItensViewOUTVAL: TcxGridDBBandedColumn;
    cxgItensViewOUTVAL_NOV: TcxGridDBBandedColumn;
    cxgItensViewDESOPE: TcxGridDBBandedColumn;
    cxgItensViewDESOPE_NOV: TcxGridDBBandedColumn;
    cxgItensViewPRECOM: TcxGridDBBandedColumn;
    cxgItensViewPRECOM_NOV: TcxGridDBBandedColumn;
    cxgItensViewPREVE1 : TcxGridDBBandedColumn;
    cxgItensViewPREVE1_NOV : TcxGridDBBandedColumn;
    cxgItensViewPREVE2 : TcxGridDBBandedColumn;
    cxgItensViewPREVE2_NOV : TcxGridDBBandedColumn;
    cxgItensViewPREVE3 : TcxGridDBBandedColumn;
    cxgItensViewPREVE3_NOV : TcxGridDBBandedColumn;
    cxgItensViewPREVE4 : TcxGridDBBandedColumn;
    cxgItensViewPREVE4_NOV : TcxGridDBBandedColumn;
    cxgItensViewPREVE5 : TcxGridDBBandedColumn;
    cxgItensViewPREVE5_NOV : TcxGridDBBandedColumn;
    cxgItensViewPREVE6 : TcxGridDBBandedColumn;
    cxgItensViewPREVE6_NOV : TcxGridDBBandedColumn;
    cxgItensViewPREVE7 : TcxGridDBBandedColumn;
    cxgItensViewPREVE7_NOV : TcxGridDBBandedColumn;
    cxgItensViewMARBR1: TcxGridDBBandedColumn;
    cxgItensViewMARBR1_NOV: TcxGridDBBandedColumn;
    cxgItensViewMARBR2: TcxGridDBBandedColumn;
    cxgItensViewMARBR2_NOV: TcxGridDBBandedColumn;
    cxgItensViewMARBR3: TcxGridDBBandedColumn;
    cxgItensViewMARBR3_NOV: TcxGridDBBandedColumn;
    cxgItensViewMARBR4: TcxGridDBBandedColumn;
    cxgItensViewMARBR4_NOV: TcxGridDBBandedColumn;
    cxgItensViewMARBR5: TcxGridDBBandedColumn;
    cxgItensViewMARBR5_NOV: TcxGridDBBandedColumn;
    cxgItensViewMARBR6: TcxGridDBBandedColumn;
    cxgItensViewMARBR6_NOV: TcxGridDBBandedColumn;
    cxgItensViewMARBR7: TcxGridDBBandedColumn;
    cxgItensViewMARBR7_NOV: TcxGridDBBandedColumn;
    cxgItensViewTCIFCU: TcxGridDBBandedColumn;
    cxgItensViewTCIFCU_NOV: TcxGridDBBandedColumn;
    cxgItensViewTSCUST: TcxGridDBBandedColumn;
    cxgItensViewTSCUST_NOV: TcxGridDBBandedColumn;
    cxgItensViewDEPICO: TcxGridDBBandedColumn;
    cxgItensViewDEPICO_NOV: TcxGridDBBandedColumn;
    cxgItensViewDEICMS: TcxGridDBBandedColumn;
    cxgItensViewDEICMS_NOV: TcxGridDBBandedColumn;
    cxgItensViewFATREG: TcxGridDBBandedColumn;
    cxgItensViewFATREG_NOV: TcxGridDBBandedColumn;
    btnVisProdNaoImp: TBitBtnLocked;
    cxgItensViewMARCADO: TcxGridDBBandedColumn;
    cxgItensViewVariacao1: TcxGridDBBandedColumn;
    cxgItensViewVariacao2: TcxGridDBBandedColumn;
    cxgItensViewVariacao3: TcxGridDBBandedColumn;
    cxgItensViewVariacao4: TcxGridDBBandedColumn;
    cxgItensViewVariacao5: TcxGridDBBandedColumn;
    cxgItensViewVariacao6: TcxGridDBBandedColumn;
    cxgItensViewVariacao7: TcxGridDBBandedColumn;
    Panel1: TPanel;
    Label1: TLabel;
    lblAlerta: TLabel;
    btnMarcar: TBitBtnLocked;
    btnMarcAll: TBitBtnLocked;
    btnDesmAll: TBitBtnLocked;
    cxgItensDBBandedTableView: TcxGridDBBandedTableView;
    cxStyleRepository: TcxStyleRepository;
    styDentro: TcxStyle;
    styFora: TcxStyle;
    styEditavel: TcxStyle;
    grpLegenda: TGroupBox;
    shpVarMaior: TShape;
    lblLegVarMaior: TLabel;
    lblLegVarMenor: TLabel;
    shpVarMenor: TShape;
    Shape1: TShape;
    lblCamposEditaveis: TLabel;
    cxgItensViewMARID1: TcxGridDBBandedColumn;
    cxgItensViewMARID1_NOV: TcxGridDBBandedColumn;
    cxgItensViewMARID2: TcxGridDBBandedColumn;
    cxgItensViewMARID2_NOV: TcxGridDBBandedColumn;
    cxgItensViewMARID3: TcxGridDBBandedColumn;
    cxgItensViewMARID3_NOV: TcxGridDBBandedColumn;
    cxgItensViewMARID4: TcxGridDBBandedColumn;
    cxgItensViewMARID4_NOV: TcxGridDBBandedColumn;
    cxgItensViewMARID5: TcxGridDBBandedColumn;
    cxgItensViewMARID5_NOV: TcxGridDBBandedColumn;
    cxgItensViewMARID6: TcxGridDBBandedColumn;
    cxgItensViewMARID6_NOV: TcxGridDBBandedColumn;
    cxgItensViewMARID7: TcxGridDBBandedColumn;
    cxgItensViewMARID7_NOV: TcxGridDBBandedColumn;
    function  fAlterarTabelas(pgbProgresso: TcxProgressBar): Boolean;
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnVisProdNaoImpClick(Sender: TObject);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure frxGenGetValue(const VarName: string; var Value: Variant);
    procedure FormShow(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
    procedure btnMarcAllClick(Sender: TObject);
    procedure btnDesmAllClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure cxgItensViewVariacao1StylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxgItensDBBandedTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    cdsDadosAlt: TZClient;
    cdsRelatorio: TZClient;
    strMarMkp: String;
    strPcmPro: String;
    dtaDtaAltera: TDate;
    blnPorPreIte: Boolean;
    blnMarcar: Boolean;
    intDecUni: Integer;
    fltImpVar: Double;
    { Private declarations }
    function fConfirmaData: Boolean;
    procedure pMarcaDesmarcaTodos(blnMarca: boolean);
    function  fMarcaDesmarcaTodosAux(prgProgresso: TcxProgressBar): Boolean;
    procedure OnBeforePost(DataSet: TDataSet);
    function fValidaMargem(intTabPreco: Integer; cdsIte: TZClient; fltMarBru: Double): Boolean;
    procedure pProcessarColunas;

    function fDefineCalculo: TCalculo;


    function fProcessar(qryManipulada: TUniQuery): Boolean;
    procedure pMontarGrid;
    function fGetColumn(AStrFieldName: String): TcxGridDBBandedColumn;
  public
    blnPrecoVenda: Boolean;
    intArredondamento : integer;
    strEstEmp : String;
    cdsCampos: TUniClientDataSet;

    function ShowModal(cdsDados: TZClient): integer; reintroduce;
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmImportTabPrecosItegerConfirma: TfrmImportTabPrecosItegerConfirma;

implementation

{$R *.dfm}

uses untGravando, untPreAlt, untAltPrecoDigData, untAltEfetivacaoPrecos,
  untIcmsSTParteVenda;

{ TfrmImportTabPrecosItegerConfirma }

Function TfrmImportTabPrecosItegerConfirma.fConfirmaData: Boolean;
  Var
    strMensagem: String;
Begin
  Result := False;
  If cdsDadosAlt.IsEmpty Then
  Begin
    fMensagem('Aviso', 'Não há dados para serem processados!', ['&O k']);
    exit;
  end;
  pCriarFormularios(TfrmAltPrecoDigData, frmAltPrecoDigData);
  frmAltPrecoDigData.ShowModal;
  Try
    If frmAltPrecoDigData.blnConfirma Then
    Begin
      If (frmAltPrecoDigData.dtaData = VS_Date) Then
        strMensagem := 'Os preços serão agendados para hoje. Confirma?'
      Else
        strMensagem := 'Os preços serão alterados no dia '+ DateToStr(frmAltPrecoDigData.dtaData) + '. Confirma?';
      Result := fMensagem('Confirmação' ,strMensagem, ['&Sim','&Não']) = 1;
    End;

    dtaDtaAltera := frmAltPrecoDigData.dtaData;
    blnPorPreIte := frmAltPrecoDigData.dtaData <> date;
  Finally
    FreeAndNil(frmAltPrecoDigData);
  End;
End;


function TfrmImportTabPrecosItegerConfirma.fDefineCalculo: TCalculo;
begin
  Result.intTabela := -1;
  Result.TipoCalculoImp := tciIndefinido;

  If Not Assigned(cxgItensDBBandedTableView.Controller.FocusedColumn) Then
    Exit;

  If(Pos('ITE_PREVE', TcxGridItemDBDataBinding(cxgItensDBBandedTableView.Controller.FocusedColumn.DataBinding).FieldName) > 0) Then
  Begin
    Result.intTabela := cxgItensDBBandedTableView.Controller.FocusedColumn.tag;
    Result.TipoCalculoImp := tciMargem;
  End
  Else If(Pos('ITE_MARBR', TcxGridItemDBDataBinding(cxgItensDBBandedTableView.Controller.FocusedColumn.DataBinding).FieldName) > 0) Then
  Begin
    Result.intTabela := cxgItensDBBandedTableView.Controller.FocusedColumn.tag;
    Result.TipoCalculoImp := tciVenda;
  End;
end;

function TfrmImportTabPrecosItegerConfirma.fMarcaDesmarcaTodosAux(
  prgProgresso: TcxProgressBar): Boolean;
begin
  cdsDadosAlt.BeforePost := nil;
  prgProgresso.Properties.Max := cdsDadosAlt.RecordCount -1;
  cdsDadosAlt.DisableControls;
  Try
    cdsDadosAlt.First;
    While Not cdsDadosAlt.Eof Do
    Begin
      cdsDadosAlt.Edit;
      cdsDadosAlt.FieldByName('MARCADO').AsInteger := IIf(blnMarcar, 1, 0);
      cdsDadosAlt.Post;
      cdsDadosAlt.Next;
      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;
    Result := True;
  Finally
    cdsDadosAlt.BeforePost := OnBeforePost;
    cdsDadosAlt.EnableControls;
  End;

end;

procedure TfrmImportTabPrecosItegerConfirma.btnConfirmaClick(Sender: TObject);
var strFilter: String;
begin
  cdsDadosAlt.BeforePost := nil;
  Try

    cdsDadosAlt.Filtered := False;
    strFilter := cdsDadosAlt.Filter;
    cdsDadosAlt.Filter := 'IMPORT = 1 AND MARCADO = 1';
    cdsDadosAlt.Filtered := True;

    If cdsDadosAlt.IsEmpty then
    Begin

       fMensagem('Aviso', 'Nenhum item selecionado para alteração!', ['&O k']);

       cdsDadosAlt.Filtered := False;
       cdsDadosAlt.Filter := strFilter;
       cdsDadosAlt.Filtered := True;
       Exit;
    End;


    If fConfirmaData then
    Begin
      Try
        Try
          pCriarFormularios(TfrmGravando, frmGravando);
          frmGravando.fExecutarAcao := fAlterarTabelas;
          frmGravando.lblGravando.Caption := 'Aguarde... Criando agendamento das alterações de preços.';
          frmGravando.ShowModal;
          pCriarFormularios(TfrmAltEfetivacaoPrecos, frmAltEfetivacaoPrecos);
          If frmAltEfetivacaoPrecos.Showmodal = mrOk Then
          Begin
            fMensagem('Aviso', 'Importação concluída com sucesso!', ['&O k']);
            Close;
          end;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[TfrmImportTabPrecosItegerConfirma.pGravaLoteItens]');
          End;
        End;
      Finally
        FreeAndNil(frmGravando);
      End;
    End;
  Finally
    cdsDadosAlt.BeforePost := OnBeforePost;

  End;
end;

procedure TfrmImportTabPrecosItegerConfirma.btnDesmAllClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(False);

end;

procedure TfrmImportTabPrecosItegerConfirma.btnMarcAllClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(True);

end;

procedure TfrmImportTabPrecosItegerConfirma.btnMarcarClick(Sender: TObject);
begin
  inherited;
  cdsDadosAlt.Edit;
  cdsDadosAlt.FieldByName('MARCADO').AsInteger := IIf(cdsDadosAlt.FieldByName('MARCADO').AsInteger = 1, 0, 1);
  cdsDadosAlt.Post;

end;

procedure TfrmImportTabPrecosItegerConfirma.btnVisProdNaoImpClick(Sender: TObject);
begin
  inherited;
  frxRepNaoImp.Script.Variables['NOMREL'] := 'RELATÓRIO DE CRÍTICAS';

  TfrxMemoView(frxRepNaoImp.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');

  frxRepNaoImp.DotMatrixReport           := False;
  frxRepNaoImp.PrintOptions.PrintMode    := pmScale;
  frxRepNaoImp.PrintOptions.PrintOnSheet := 9; //A4

  pPreviewReport(Self.Name, Self.Caption + ' (Relatório de críticas)', frxRepNaoImp);
end;

procedure TfrmImportTabPrecosItegerConfirma.cxgItensDBBandedTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewMARCADO.Index]) = '1' Then
    ACAnvas.Font.Color := clBlue
  Else
    ACAnvas.Font.Color := clBlack;
end;

procedure TfrmImportTabPrecosItegerConfirma.cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  If Pos('Novo', AViewInfo.Item.Caption) > 0 then
    ACanvas.Brush.Color := clMoneyGreen
  Else if Pos('Atual', AViewInfo.Item.Caption) > 0 then
    ACanvas.Brush.Color := clSilver;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewMARCADO.Index]) = '1' Then
    ACAnvas.Font.Color := clBlue
  Else
    ACAnvas.Font.Color := clBlack;

end;

procedure TfrmImportTabPrecosItegerConfirma.cxgItensViewVariacao1StylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
var
  fltVar: Double;
begin
  inherited;

  If fltImpVar = 0 Then
    Exit;

  Try
    fltVar := cxgItensDBBandedTableView.DataController.Values[ARecord.RecordIndex, TcxGridDBBandedColumn(AItem).Index];
  Except
    fltVar := 0;
  End;

  If fltVar = 0 Then
    Exit;

  If Abs(fltVar) > fltImpVar Then
    AStyle := styFora
  Else
    AStyle := styDentro;

end;

destructor TfrmImportTabPrecosItegerConfirma.Destroy;
begin
  FreeAndNil(cdsRelatorio);
  inherited;
end;

function TfrmImportTabPrecosItegerConfirma.fAlterarTabelas(pgbProgresso: TcxProgressBar): Boolean;
var qryUpdate: TUniQuery;
begin
  Result := True;
  cdsDadosAlt.First;
  cdsDadosAlt.DisableControls;
  pgbProgresso.Properties.Max := cdsDadosAlt.RecordCount -1;


  qryUpdate := fCriaQuery;
  Try
    Try
      While not cdsDadosAlt.Eof Do
      Begin
        fStartTransaction;

        if fProcessar(qryUpdate) Then
           fCommit
        else
           fRollback;

        cdsDadosAlt.Next;
        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;
      End;
    Finally
      cdsDadosAlt.EnableControls;
    End;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

procedure TfrmImportTabPrecosItegerConfirma.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  TSalvaConfiguracaoGrid.pSalvaConfiguracoesGrid(cxgItensDBBandedTableView, Self.Name);
end;

procedure TfrmImportTabPrecosItegerConfirma.FormCreate(Sender: TObject);
begin
  inherited;
  intArredondamento := 2;
  TSalvaConfiguracaoGrid.pCarregaConfiguracoesGrid(cxgItensDBBandedTableView, Self.Name);
end;

procedure TfrmImportTabPrecosItegerConfirma.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsRelatorio);
  inherited;
end;

procedure TfrmImportTabPrecosItegerConfirma.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If key=  VK_SPACE then
    btnMarcar.Click
  Else If key = VK_F2 Then
    btnMarcAll.Click
  Else If key = VK_F3 Then
    btnDesmAll.Click;
end;

procedure TfrmImportTabPrecosItegerConfirma.FormShow(Sender: TObject);
begin
  inherited;
  intDecUni := fCfgSis('DECUNI', varInteger);
  strMarMkp := fCfgSis('MARMKP');
  strPcmPro := fCfgSis('PCMPRO');
  fltImpVar := fCfgSis('IMPVAR', varDouble);

  cdsDadosAlt.BeforePost := OnBeforePost;
  If (fCfgSis('SUFRAM', varBoolean)) And (fCfgSis('FRMCUS', varString) = '4') Then
  Begin
    cxgItensViewTCIFCU.Visible     := True;
    cxgItensViewTCIFCU_NOV.Visible := True;
    cxgItensViewTSCUST.Visible     := True;
    cxgItensViewTSCUST_NOV.Visible := True;
    cxgItensViewDEPICO.Visible     := True;
    cxgItensViewDEPICO_NOV.Visible := True;
    cxgItensViewDEICMS.Visible     := True;
    cxgItensViewDEICMS_NOV.Visible := True;
    cxgItensViewFATREG.Visible     := True;
    cxgItensViewFATREG_NOV.Visible := True;
  End;

  If fCfgSis('MARIDE', varBoolean) Then
  Begin
    cxgItensViewMARID1.Visible      := True;
    cxgItensViewMARID1_NOV.Visible  := True;
    cxgItensViewMARID2.Visible      := True;
    cxgItensViewMARID2_NOV.Visible  := True;
    cxgItensViewMARID3.Visible      := True;
    cxgItensViewMARID3_NOV.Visible  := True;
    cxgItensViewMARID4.Visible      := True;
    cxgItensViewMARID4_NOV.Visible  := True;
    cxgItensViewMARID5.Visible      := True;
    cxgItensViewMARID5_NOV.Visible  := True;
    cxgItensViewMARID6.Visible      := True;
    cxgItensViewMARID6_NOV.Visible  := True;
    cxgItensViewMARID7.Visible      := True;
    cxgItensViewMARID7_NOV.Visible  := True;
  End;

  cxgItensViewValFre.Caption := Concat(fCfgSis('DESVFR'), '(Atual)');
  cxgItensViewValFre_NOV.Caption := Concat(fCfgSis('DESVFR'), '(Novo)');

  cxgItensViewDESADB.Caption := Concat(fCfgSis('DESADI'), '(Atual)');
  cxgItensViewDESADB_NOV.Caption := Concat(fCfgSis('DESADI'), '(Novo)');

  cxgItensViewOUTVAL.Caption := Concat(fCfgSis('DOVCPP'), '(Atual)');
  cxgItensViewOUTVAL_NOV.Caption := Concat(fCfgSis('DOVCPP'), '(Novo)');

  If intArredondamento <> 2 Then
  Begin
    intDecUni :=  intArredondamento;
    TcxCurrencyEditProperties(cxgItensViewPREVE1.Properties).DisplayFormat := fMskDigitos(intArredondamento);
    TcxCurrencyEditProperties(cxgItensViewPREVE1_NOV.Properties).DisplayFormat := fMskDigitos(intArredondamento);
    TcxCurrencyEditProperties(cxgItensViewPREVE2.Properties).DisplayFormat := fMskDigitos(intArredondamento);
    TcxCurrencyEditProperties(cxgItensViewPREVE2_NOV.Properties).DisplayFormat := fMskDigitos(intArredondamento);
    TcxCurrencyEditProperties(cxgItensViewPREVE3.Properties).DisplayFormat := fMskDigitos(intArredondamento);
    TcxCurrencyEditProperties(cxgItensViewPREVE3_NOV.Properties).DisplayFormat := fMskDigitos(intArredondamento);
    TcxCurrencyEditProperties(cxgItensViewPREVE4.Properties).DisplayFormat := fMskDigitos(intArredondamento);
    TcxCurrencyEditProperties(cxgItensViewPREVE4_NOV.Properties).DisplayFormat := fMskDigitos(intArredondamento);
    TcxCurrencyEditProperties(cxgItensViewPREVE5.Properties).DisplayFormat := fMskDigitos(intArredondamento);
    TcxCurrencyEditProperties(cxgItensViewPREVE5_NOV.Properties).DisplayFormat := fMskDigitos(intArredondamento);
    TcxCurrencyEditProperties(cxgItensViewPREVE6.Properties).DisplayFormat := fMskDigitos(intArredondamento);
    TcxCurrencyEditProperties(cxgItensViewPREVE6_NOV.Properties).DisplayFormat := fMskDigitos(intArredondamento);
    TcxCurrencyEditProperties(cxgItensViewPREVE7.Properties).DisplayFormat := fMskDigitos(intArredondamento);
    TcxCurrencyEditProperties(cxgItensViewPREVE7_NOV.Properties).DisplayFormat := fMskDigitos(intArredondamento);
  End;

  If fltImpVar > 0 Then
  Begin
    lblLegVarMenor.Caption := 'Variação <= ' + FloatToStr(fltImpVar) + '%';
    lblLegVarMaior.Caption := 'Variação > ' + FloatToStr(fltImpVar) + '%';
  End
  Else
  Begin
    lblLegVarMenor.Visible := False;
    shpVarMenor.Visible := False;
    lblLegVarMaior.Visible := False;
    shpVarMaior.Visible := False;
  End;

  pProcessarColunas;
end;

function TfrmImportTabPrecosItegerConfirma.fProcessar(qryManipulada: TUniQuery): Boolean;
begin
  Try
     Result := True;
     pIncluiPreIte(qryManipulada, cdsDadosAlt, dtaDtaAltera, 'TfrmImportTabPrecosItegerConfirma', fRetSequencial('PROPRI', VS_strCodEmp))
  Except
    On E:Exception do
    Begin
      pMensagensErro(E.Message,'[TfrmImportTabPrecosItegerConfirma.fProcessar.pIncluiPreIte]');
      Result := False;
    End;
  End;

end;

procedure TfrmImportTabPrecosItegerConfirma.frxGenGetValue(const VarName: string; var Value: Variant);
begin

  If VarName = 'EMP_NOMEMP' Then
    Value := fCampoTabela('EMP_NOMEMP', 'CADEMP INNER JOIN CADCID ON EMP_CODCID = CID_CODCID', ['EMP_CODEMP'], [VS_strCodEmp], False)

  Else If VarName = 'EMP_NOMFAN' Then
    Value := fCampoTabela('EMP_NOMFAN', 'CADEMP INNER JOIN CADCID ON EMP_CODCID = CID_CODCID', ['EMP_CODEMP'], [VS_strCodEmp], False)

  Else If VarName = 'REL_NOMREL' Then
    Value := Self.Name

  Else If VarName = 'EMP_NOMCID' Then
    Value := fCampoTabela('CID_NOMCID', 'CADEMP INNER JOIN CADCID ON EMP_CODCID = CID_CODCID', ['EMP_CODEMP'], [VS_strCodEmp], False);

end;

function TfrmImportTabPrecosItegerConfirma.fValidaMargem(intTabPreco: Integer; cdsIte: TZClient; fltMarBru: Double): Boolean;
begin
  Result := cdsIte.FieldByName('ITE_IMPFED_NOV').AsFloat +
            cdsIte.FieldByName('ITE_DESOPE_NOV').AsFloat +
            cdsIte.FieldByName('ITE_ICMSAI_NOV').AsFloat +
            IIF(fCfgSis('PCMPRO') = '2', cdsIte.FieldByName('ITE_COMTB' + intToStr(intTabPreco)).AsFloat, 0) +
            IIF(Pos(fCfgSis('MARMKP'), '1_5_') > 0, fltMarBru, 0) <= 100;
end;

procedure TfrmImportTabPrecosItegerConfirma.OnBeforePost(DataSet: TDataSet);
var calculo: TCalculo;
    strFieldPreve,
    strFieldMarbr,
    strField, strFieldVariacao: String;

    fltPreCus,
    fltOutVal,
    fltIcmSai,
    fltDesOpe,
    fltImpFed,
    fltPreComLiq,
    fltVariacao_Percentual,
    fltValorMargemAnterior,
    fltValorVendaAnterior,

    fltIcmsST: Double;


    strCodSit: String;
    blnCalcSt : Boolean;
    strMensagem: String;

begin
  calculo := fDefineCalculo;
  If calculo.intTabela > -1 then
  Begin
    case calculo.TipoCalculoImp Of
      tciMargem : strField := 'ITE_MARBR' + intToStr(calculo.intTabela)+ '_NOV';
      tciVenda  : strField := 'ITE_PREVE' + intToStr(calculo.intTabela)+ '_NOV';
    end;

    strFieldPreve := 'ITE_PREVE' + intToStr(calculo.intTabela);
    strFieldMarbr := 'ITE_MARBR' + intToStr(calculo.intTabela);

    fltValorMargemAnterior := cdsDadosAlt.FieldByName('ITE_MARBR'+intToStr(calculo.intTabela)+'_NOV').OldValue;
    fltValorVendaAnterior  := cdsDadosAlt.FieldByName('ITE_PREVE'+intToStr(calculo.intTabela)+'_NOV').OldValue;

    strFieldVariacao :=  'VARIACAO_' + intToStr(calculo.intTabela);


    fltPreCus := IIf(cdsDadosAlt.FieldByName('ITE_PRECUS_NOV').IsNull, cdsDadosAlt.FieldByName('ITE_PRECUS').AsFloat, cdsDadosAlt.FieldByName('ITE_PRECUS_NOV').AsFloat);

    fltOutVal := IIf(cdsDadosAlt.FieldByName('ITE_OUTVAL_NOV').IsNull, cdsDadosAlt.FieldByName('ITE_OUTVAL').AsFloat, cdsDadosAlt.FieldByName('ITE_OUTVAL_NOV').AsFloat);
    fltIcmSai := IIf(cdsDadosAlt.FieldByName('ITE_ICMSAI_NOV').IsNull, cdsDadosAlt.FieldByName('ITE_ICMSAI').AsFloat, cdsDadosAlt.FieldByName('ITE_ICMSAI_NOV').AsFloat);
    fltDesOpe := IIf(cdsDadosAlt.FieldByName('ITE_DESOPE_NOV').IsNull, cdsDadosAlt.FieldByName('ITE_DESOPE').AsFloat, cdsDadosAlt.FieldByName('ITE_DESOPE_NOV').AsFloat);
    fltImpFed := IIf(cdsDadosAlt.FieldByName('ITE_IMPFED_NOV').IsNull, cdsDadosAlt.FieldByName('ITE_IMPFED').AsFloat, cdsDadosAlt.FieldByName('ITE_IMPFED_NOV').AsFloat);

    fltPreComLiq := fCalculaPrecoCompraLiq(IIf(cdsDadosAlt.FieldByName('ITE_PRECOM_NOV').IsNull, cdsDadosAlt.FieldByName('ITE_PRECOM').AsFloat, cdsDadosAlt.FieldByName('ITE_PRECOM_NOV').AsFloat),
                                           IIf(cdsDadosAlt.FieldByName('ITE_DESF01_NOV').IsNull, cdsDadosAlt.FieldByName('ITE_DESF01').AsFloat, cdsDadosAlt.FieldByName('ITE_DESF01_NOV').AsFloat),
                                           IIf(cdsDadosAlt.FieldByName('ITE_DESF02_NOV').IsNull, cdsDadosAlt.FieldByName('ITE_DESF02').AsFloat, cdsDadosAlt.FieldByName('ITE_DESF02_NOV').AsFloat),
                                           IIf(cdsDadosAlt.FieldByName('ITE_DESF03_NOV').IsNull, cdsDadosAlt.FieldByName('ITE_DESF03').AsFloat, cdsDadosAlt.FieldByName('ITE_DESF03_NOV').AsFloat),
                                           IIf(cdsDadosAlt.FieldByName('ITE_DESF04_NOV').IsNull, cdsDadosAlt.FieldByName('ITE_DESF04').AsFloat, cdsDadosAlt.FieldByName('ITE_DESF04_NOV').AsFloat),
                                           IIf(cdsDadosAlt.FieldByName('ITE_DESF05_NOV').IsNull, cdsDadosAlt.FieldByName('ITE_DESF05').AsFloat, cdsDadosAlt.FieldByName('ITE_DESF05_NOV').AsFloat),
                                           IIf(cdsDadosAlt.FieldByName('ITE_DESF06_NOV').IsNull, cdsDadosAlt.FieldByName('ITE_DESF06').AsFloat, cdsDadosAlt.FieldByName('ITE_DESF06_NOV').AsFloat),
                                           intDecUni,
                                           (cdsDadosAlt.FieldByName('ITE_PREDOL').AsString = 'S'));

    strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [cdsDadosAlt.FieldByName('CODABF').AsString, strEstEmp]);


    fltIcmsST := fGetIcmsSTParteVenda(cdsDadosAlt.FieldByName('CODABF').AsString,
                                      '_SAI_CCO',
                                      strCodSit,
                                      strEstEmp,
                                      fltPreComLiq,
                                      IIf(cdsDadosAlt.FieldByName('ITE_IPIENT_NOV').IsNull, cdsDadosAlt.FieldByName('ITE_IPIENT').AsFloat, cdsDadosAlt.FieldByName('ITE_IPIENT_NOV').AsFloat),
                                      fltIcmSai,
                                      strEstEmp,
                                      blnCalcSt);

    cdsDadosAlt.FieldByname(strField).AsFloat := fCalculaPrecoVenda(IIf(calculo.TipoCalculoImp = tciVenda, 1, 2),
                                                                    fltPreCus  + fltOutVal,
                                                                    cdsDadosAlt.FieldByName(strFieldPreve + '_NOV').AsFloat,
                                                                    cdsDadosAlt.FieldByName(strFieldMarbr + '_NOV').AsFloat,
                                                                    fltIcmSai,
                                                                    fltImpFed,
                                                                    fltDesOpe,
                                                                    cdsDadosAlt.FieldByName('ITE_COMTB' +  intToStr(calculo.intTabela)).AsFloat,
                                                                    strMarMkp,
                                                                    strPcmPro,
                                                                    intDecUni,
                                                                    fltIcmsST,
                                                                    blnCalcSt);




    If Not fValidaMargem(calculo.intTabela, cdsDadosAlt,  cdsDadosAlt.FieldByName(strFieldMarbr + '_NOV').AsFloat) Then
    Begin
      strMensagem  := 'TABELA DE PREÇOS ' + IntToStr(calculo.intTabela) + ': A SOMA DO "ICMS SAÍDA" + "IMPOSTOS FEDERAIS" + "DESPESAS OPERACIONAIS" ' +
                                                    IIF(Pos(fCfgSis('MARMKP'), '1_5_') > 0, ' + "MARGEM BRUTA" ', '') +
                                                    IIF(fCfgSis('PCMPRO') = '2', '+ "COMISSÃO" ', '') +
                                                    ' NÃO PODEM SER SUPERIOR A 100%.  PORCENTAGEM "MARGEM BRUTA": ' +
                                                    FormatFloat('#,###0.00', cdsDadosAlt.FieldByName(strFieldMarbr + '_NOV').AsFloat) +
                                                    IIF(fCfgSis('PCMPRO') = '2', '  PORCENTAGEM "COMISSÃO": ' + FormatFloat('#,###0.00', cdsDadosAlt.FieldByName('ITE_COMTB' +  IntToStr(calculo.intTabela)+ '_NOV').AsFloat), '');
      pMensagemOk(strMensagem);
      cdsDadosAlt.FieldByName('ITE_MARBR'+intToStr(calculo.intTabela)+'_NOV').AsFloat := fltValorMargemAnterior;
      cdsDadosAlt.FieldByName('ITE_PREVE'+intToStr(calculo.intTabela)+'_NOV').AsFloat := fltValorVendaAnterior;



    end;
    fltVariacao_Percentual := (cdsDadosAlt.FieldByname(strFieldPreve+'_NOV').AsFloat/cdsDadosAlt.FieldByName(strFieldPreve).AsFloat - 1) * 100;
    cdsDadosAlt.FieldByname(strFieldVariacao).AsFloat := fltVariacao_Percentual;

  End;
end;

procedure TfrmImportTabPrecosItegerConfirma.pMarcaDesmarcaTodos(
  blnMarca: boolean);
  var frmMarca: TfrmGravando;

begin
  blnMarcar := blnMarca;
  pCriarFormularios(TfrmGravando, frmMarca);
  Try
    frmMarca.lblGravando.Caption := 'Gerando informações para o giro de estoque...';
    frmMarca.fExecutarAcao := fMarcaDesmarcaTodosAux;
    frmMarca.Showmodal;
  Finally
    pFreeAndNil(frmMarca);
  End;
end;

procedure TfrmImportTabPrecosItegerConfirma.pMontarGrid;
  var
    i: integer;
    blnVisible: Boolean;
begin

  For i := 1 To 7 Do
  Begin
    blnVisible := VS_strTabPrc[i] = 'S';

    Case i of
     1: Begin
          cxgItensViewPREVE1.Visible := blnVisible;
          cxgItensViewPREVE1_NOV.Visible := blnVisible;
          cxgItensViewMARBR1.Visible := blnVisible;
          cxgItensViewMARBR1_NOV.Visible := blnVisible;
          cxgItensViewVariacao1.Visible := blnVisible;
          cxgItensViewMARID1.Visible := blnVisible;
          cxgItensViewMARID1_NOV.Visible := blnVisible;
        End;
     2: Begin
          cxgItensViewPREVE2.Visible := blnVisible;
          cxgItensViewPREVE2_NOV.Visible := blnVisible;
          cxgItensViewMARBR2.Visible := blnVisible;
          cxgItensViewMARBR2_NOV.Visible := blnVisible;
          cxgItensViewVariacao2.Visible := blnVisible;
          cxgItensViewMARID2.Visible := blnVisible;
          cxgItensViewMARID2_NOV.Visible := blnVisible;
        End;
     3: Begin
          cxgItensViewPREVE3.Visible := blnVisible;
          cxgItensViewPREVE3_NOV.Visible := blnVisible;
          cxgItensViewMARBR3.Visible := blnVisible;
          cxgItensViewMARBR3_NOV.Visible := blnVisible;
          cxgItensViewVariacao3.Visible := blnVisible;
          cxgItensViewMARID3.Visible := blnVisible;
          cxgItensViewMARID3_NOV.Visible := blnVisible;
        End;
     4: Begin
          cxgItensViewPREVE4.Visible := blnVisible;
          cxgItensViewPREVE4_NOV.Visible := blnVisible;
          cxgItensViewMARBR4.Visible := blnVisible;
          cxgItensViewMARBR4_NOV.Visible := blnVisible;
          cxgItensViewVariacao4.Visible := blnVisible;
          cxgItensViewMARID4.Visible := blnVisible;
          cxgItensViewMARID4_NOV.Visible := blnVisible;
        End;
     5: Begin
          cxgItensViewPREVE5 .Visible := blnVisible;
          cxgItensViewPREVE5_NOV.Visible := blnVisible;
          cxgItensViewMARBR5.Visible := blnVisible;
          cxgItensViewMARBR5_NOV.Visible := blnVisible;
          cxgItensViewVariacao5.Visible := blnVisible;
          cxgItensViewMARID5.Visible := blnVisible;
          cxgItensViewMARID5_NOV.Visible := blnVisible;
        End;
     6: Begin
          cxgItensViewPREVE6.Visible := blnVisible;
          cxgItensViewPREVE6_NOV.Visible := blnVisible;
          cxgItensViewMARBR6.Visible := blnVisible;
          cxgItensViewMARBR6_NOV.Visible := blnVisible;
          cxgItensViewVariacao6.Visible := blnVisible;
          cxgItensViewMARID6.Visible := blnVisible;
          cxgItensViewMARID6_NOV.Visible := blnVisible;
        End;
     7: Begin
          cxgItensViewPREVE7.Visible := blnVisible;
          cxgItensViewPREVE7_NOV.Visible := blnVisible;
          cxgItensViewMARBR7.Visible := blnVisible;
          cxgItensViewMARBR7_NOV.Visible := blnVisible;
          cxgItensViewVariacao7.Visible := blnVisible;
          cxgItensViewMARID7.Visible := blnVisible;
          cxgItensViewMARID7_NOV.Visible := blnVisible;
        End;
    End;
  End;
{
  if (cxgItensViewMARBR1_NOV.Visible and cxgItensViewPREVE1_NOV.Visible) Then
  begin
    cxgItensViewMARBR1_NOV.Visible := Not blnPrecoVenda;
    cxgItensViewPREVE1_NOV.Visible := blnPrecoVenda;
  End;

  if (cxgItensViewMARBR2_NOV.Visible and cxgItensViewPREVE2_NOV.Visible) Then
  begin
    cxgItensViewMARBR2_NOV.Visible := Not blnPrecoVenda;
    cxgItensViewPREVE2_NOV.Visible := blnPrecoVenda;
  End;

  if (cxgItensViewMARBR3_NOV.Visible and cxgItensViewPREVE3_NOV.Visible) Then
  begin
    cxgItensViewMARBR3_NOV.Visible := Not blnPrecoVenda;
    cxgItensViewPREVE3_NOV.Visible := blnPrecoVenda;
  End;

  if (cxgItensViewMARBR4_NOV.Visible and cxgItensViewPREVE4_NOV.Visible) Then
  begin
    cxgItensViewMARBR4_NOV.Visible := Not blnPrecoVenda;
    cxgItensViewPREVE4_NOV.Visible := blnPrecoVenda;
  End;

  if (cxgItensViewMARBR5_NOV.Visible and cxgItensViewPREVE5_NOV.Visible) Then
  begin
    cxgItensViewMARBR5_NOV.Visible := Not blnPrecoVenda;
    cxgItensViewPREVE5_NOV.Visible := blnPrecoVenda;
  End;

  if (cxgItensViewMARBR6_NOV.Visible and cxgItensViewPREVE6_NOV.Visible) Then
  begin
    cxgItensViewMARBR6_NOV.Visible := Not blnPrecoVenda;
    cxgItensViewPREVE6_NOV.Visible := blnPrecoVenda;
  End;

  if (cxgItensViewMARBR7_NOV.Visible and cxgItensViewPREVE7_NOV.Visible) Then
  begin
    cxgItensViewMARBR7_NOV.Visible := Not blnPrecoVenda;
    cxgItensViewPREVE7_NOV.Visible := blnPrecoVenda;
  End;
}
end;

procedure TfrmImportTabPrecosItegerConfirma.pProcessarColunas;
var
  cxcColuna: TcxGridDBBandedColumn;
begin
  If Not Assigned(cdsCampos) Then
    Exit;

  cdsCampos.Filter := 'MARDES = ' + QuotedStr('N');
  cdsCampos.Filtered := True;
  cdsCampos.First;
  While Not cdsCampos.Eof Do
  Begin
    cxcColuna := fGetColumn(cdsCampos.FieldByName('FIELD').AsString + '_NOV');
    If Assigned(cxcColuna) Then
      cxcColuna.Visible := False;

    cdsCampos.Next;
  End;

  cdsCampos.Filtered := False;

end;

function TfrmImportTabPrecosItegerConfirma.fGetColumn(AStrFieldName: String): TcxGridDBBandedColumn;
var
  I: Integer;
begin
  For I := 0 To Pred(cxgItensDBBandedTableView.ColumnCount) Do
  Begin
    If cxgItensDBBandedTableView.Columns[I].DataBinding.FieldName = AStrFieldName Then
      Exit(cxgItensDBBandedTableView.Columns[I]);
  End;
  Result := Nil;
end;

function TfrmImportTabPrecosItegerConfirma.ShowModal(cdsDados: TZClient): integer;
begin
  {****************************************************************************}
  {* 1 = Ocorreu tudo certo durante a Importação                               }
  {* 2 = A calculo para a tabela de preço excedeu 100% do valor do produto     }
  {* 0 = Não foi possivel localizar o produto informado no excel               }
  {****************************************************************************}

  cdsDadosAlt := cdsDados;
  cdsRelatorio := TZClient.Create(Self, '');
  cdsDadosAlt.Filter := 'IMPORT = 1';
  cdsDadosAlt.Filtered := True;
  cdsDadosAlt.Open;

  cdsRelatorio.Data := cdsDados.Data;
  cdsRelatorio.Filter := 'IMPORT <> 1 ';
  cdsRelatorio.Filtered := True;
  cdsRelatorio.Open;
  dtsDados.DataSet := cdsDadosAlt;
  frxRelatorio.DataSet := cdsRelatorio;
  btnVisProdNaoImp.Enabled := cdsRelatorio.RecordCount > 0;
  btnConfirma.Enabled := cdsDadosAlt.RecordCount > 0;
  pnlInfo.Caption := 'Itens Processados com sucesso: ' + IntToStr(cdsDadosAlt.RecordCount);
  pnlInfo.Caption := pnlInfo.Caption + '    Itens Processados com Falha: '   + IntToStr(cdsRelatorio.RecordCount);
  pMontarGrid;
  Result := inherited ShowModal;
end;

end.
