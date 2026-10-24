unit untConfigExpedicaoItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, untCfgColExpItensCaixa, untCfgSugExp,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, Vcl.Grids, Vcl.DBGrids, DBGridCitel, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGridCitel, cxGrid, Vcl.ComCtrls, Datasnap.DBClient,
  UniClientDataSet, untFatExpedicaoItens,Uni, Vcl.Samples.Spin, System.StrUtils,
  untConstantes;

type
  TfrmConfigExpedicaoItens = class(TfrmPai)
    pnlCfgExp: TPanel;
    Panel1: TPanel;
    pgcCfgExp: TPageControl;
    tbsColunas: TTabSheet;
    pnlGrdCol: TPanel;
    cxgItensEstrutura: TcxGridCitel;
    cxgItensEstruturaTableView1: TcxGridDBTableViewCitel;
    cxgItensEstruturaTableView1EXIBIR: TcxGridDBColumn;
    cxgItensEstruturaTableView1COLCAP: TcxGridDBColumn;
    cxgItensEstruturaTableView1ORDCAM: TcxGridDBColumn;
    cxgItensEstruturaTableView1COLNAM: TcxGridDBColumn;
    cxgItensEstruturaLevel1: TcxGridLevel;
    pnlCfgCol: TPanel;
    btnUpItens: TSpeedButton;
    btnDownItens: TSpeedButton;
    btnUpCaixa: TSpeedButton;
    btnMarcaTodosItens: TBitBtnLocked;
    btnDesmarcaTodosItens: TBitBtnLocked;
    pnlGrdExp: TPanel;
    dbgItensEstrutura: TDBGridCitel;
    btnDownCaixa: TSpeedButton;
    cxgMontagemCaixa: TcxGridCitel;
    cxgMontagemCaixaTableViewCitel1: TcxGridDBTableViewCitel;
    cxgMontagemCaixaTableViewCitel1EXIBIR: TcxGridDBColumn;
    cxgMontagemCaixaTableViewCitel1COLCAP: TcxGridDBColumn;
    cxgMontagemCaixaTableViewCitel1ORDCAM: TcxGridDBColumn;
    cxgMontagemCaixaTableViewCitel1COLNAM: TcxGridDBColumn;
    cxgMontagemCaixaLevel1: TcxGridLevel;
    btnMarcaTodosCaixa: TBitBtnLocked;
    btnDesmarcaTodosCaixa: TBitBtnLocked;
    dbgMontagemCaixa: TDBGridCitel;
    btnGravar: TBitBtnLocked;
    btnPadroes: TBitBtnLocked;
    pnlTitulos: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    cdsItens: TUniClientDataSet;
    cdsCaixa: TUniClientDataSet;
    dtsItens: TDataSource;
    dtsCaixa: TDataSource;
    dtsItensCol: TDataSource;
    dtsCaixaCol: TDataSource;
    cdsItensEXIBIR: TStringField;
    cdsItensCOLCAP: TStringField;
    cdsItensCOLNAM: TStringField;
    cdsItensORDCAM: TIntegerField;
    cdsItensCOLTAM: TIntegerField;
    cdsCaixaEXIBIR: TStringField;
    cdsCaixaCOLCAP: TStringField;
    cdsCaixaCOLNAM: TStringField;
    cdsCaixaORDCAM: TIntegerField;
    cdsCaixaCOLTAM: TIntegerField;
    btnRightItens: TSpeedButton;
    btnLeftItens: TSpeedButton;
    cxgColOrdItens: TcxGridCitel;
    cxgColOrdItensTableView1: TcxGridDBTableViewCitel;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cxgColOrdCaixa: TcxGridCitel;
    cxgColOrdCaixaTableView1: TcxGridDBTableViewCitel;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxgColOrdCaixaLevel1: TcxGridLevel;
    btnRightCaixa: TSpeedButton;
    btnLeftCaixa: TSpeedButton;
    cdsColOrdItens: TUniClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    IntegerField1: TIntegerField;
    StringField3: TStringField;
    dtsColOrdItens: TDataSource;
    cdsColOrdCaixa: TUniClientDataSet;
    StringField4: TStringField;
    StringField5: TStringField;
    IntegerField2: TIntegerField;
    StringField6: TStringField;
    dtsColOrdCaixa: TDataSource;
    btnUpOrdItens: TSpeedButton;
    btnDownOrdItens: TSpeedButton;
    btnDownOrdCaixa: TSpeedButton;
    btnUpOrdCaixa: TSpeedButton;
    Panel2: TPanel;
    pnlAreaVis: TPanel;
    grbTamanhoFonte: TGroupBox;
    speTamanhoFonte: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnMarcaTodosItensClick(Sender: TObject);
    procedure btnMarcaTodosCaixaClick(Sender: TObject);
    procedure btnDesmarcaTodosItensClick(Sender: TObject);
    procedure btnDesmarcaTodosCaixaClick(Sender: TObject);
    procedure btnUpItensClick(Sender: TObject);
    procedure btnUpCaixaClick(Sender: TObject);
    procedure btnDownItensClick(Sender: TObject);
    procedure btnDownCaixaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure cxgItensEstruturaTableView1EXIBIRPropertiesEditValueChanged(
      Sender: TObject);
    procedure cxgMontagemCaixaTableViewCitel1EXIBIRPropertiesEditValueChanged(
      Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnPadroesClick(Sender: TObject);
    procedure dbgItensEstruturaDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dbgMontagemCaixaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgItensEstruturaColumnMoved(Sender: TObject; FromIndex,
      ToIndex: Integer);
    procedure dbgMontagemCaixaColumnMoved(Sender: TObject; FromIndex,
      ToIndex: Integer);
    procedure btnRightItensClick(Sender: TObject);
    procedure btnRightCaixaClick(Sender: TObject);
    procedure btnLeftItensClick(Sender: TObject);
    procedure btnLeftCaixaClick(Sender: TObject);
    procedure btnUpOrdItensClick(Sender: TObject);
    procedure btnUpOrdCaixaClick(Sender: TObject);
    procedure btnDownOrdItensClick(Sender: TObject);
    procedure btnDownOrdCaixaClick(Sender: TObject);
    procedure cdsColOrdItensAfterPost(DataSet: TDataSet);
    procedure cdsColOrdCaixaAfterPost(DataSet: TDataSet);
    procedure cxGridDBColumn3PropertiesEditValueChanged(Sender: TObject);
    procedure cxGridDBColumn6PropertiesEditValueChanged(Sender: TObject);
    procedure speTamanhoFonteChange(Sender: TObject);
  private
    { Private declarations }
    blnFecharForm : Boolean;
    blnFinalizouFormShow : Boolean;
    blnColOrdItens: Boolean;
    blnColOrdCaixa: Boolean;
    procedure pCarregaOrdExpItens;
    procedure pCarregaOrdExpCaixa;
    procedure pIniciarDadosItens;
    procedure pIniciarDadosCaixa;
    procedure pAdicionarColunaExibicaoEOrdemItem(recColExp: TrecColExpItensCaixa);
    procedure pAdicionarColunaExibicaoEOrdemCaixa(recColExp: TrecColExpItensCaixa);
    procedure pAdicionarColunaPreVisualizacaoItem(intIndex: Integer; recColExp: TrecColExpItensCaixa);
    procedure pAdicionarColunaPreVisualizacaoCaixa(intIndex: Integer; recColExp: TrecColExpItensCaixa);
    procedure pAjustaColunasDeExibicaoItem;
    procedure pAjustaColunasDeExibicaoCaixa;
    procedure pMarcarColunasExibicaoItem(blnMarcar: Boolean);
    procedure pMarcarColunasExibicaoCaixa(blnMarcar: Boolean);
    procedure pVisibilidadeColunaItem;
    procedure pVisibilidadeColunaCaixa;
    procedure pAlteraOrdemColunaItem(blnSobe: Boolean);
    procedure pAlteraOrdemColunaCaixa(blnSobe: Boolean);
    procedure pIndexarColunasVisiveisItem;
    procedure pIndexarColunasVisiveisCaixa;
    procedure pOrdenaColunasItem;
    procedure pOrdenaColunasCaixa;
    procedure pAlteraOrdemRegistrosItem(blnSobe: Boolean);
    procedure pAlteraOrdemRegistrosCaixa(blnSobe: Boolean);
    function  fColunaPodeSerConfiguravel(const strCaptionColuna: String ): Boolean;
  public
    { Public declarations }
    blnConfirma : Boolean;
    frmFatExpedicaoItens : TfrmFatExpedicaoItens;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmConfigExpedicaoItens.btnDesmarcaTodosCaixaClick(Sender: TObject);
begin
  inherited;
  pMarcarColunasExibicaoCaixa(False);
  pAjustaColunasDeExibicaoCaixa;
end;

procedure TfrmConfigExpedicaoItens.btnDesmarcaTodosItensClick(Sender: TObject);
begin
  inherited;
  pMarcarColunasExibicaoItem(False);
  pAjustaColunasDeExibicaoItem;
end;

procedure TfrmConfigExpedicaoItens.btnDownCaixaClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemColunaCaixa(False);
  pIndexarColunasVisiveisCaixa;
end;

procedure TfrmConfigExpedicaoItens.btnDownItensClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemColunaItem(False);
  pIndexarColunasVisiveisItem;
end;

procedure TfrmConfigExpedicaoItens.btnDownOrdCaixaClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemRegistrosCaixa(False);
  pOrdenaColunasCaixa;
end;

procedure TfrmConfigExpedicaoItens.btnDownOrdItensClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemRegistrosItem(False);
  pOrdenaColunasItem;
end;

procedure TfrmConfigExpedicaoItens.btnGravarClick(Sender: TObject);
  Var
    arrCol : TArrayOfColExpItensCaixa;
    arrColCaixa: TArrayOfColExpItensCaixa;
begin
  inherited;
  TCfgColExpItensCaixa.pSalvarEstado(dbgItensEstrutura, arrCol);
  TCfgColExpItensCaixa.pGravarDadosNoBancoItens(arrCol, cdsColOrdItens);

  TCfgColExpItensCaixa.pSalvarEstadoCaixa(dbgMontagemCaixa, arrColCaixa);
  TCfgColExpItensCaixa.pGravarDadosNoBancoCaixa(arrColCaixa, cdsColOrdCaixa);

  TCfgSugExp.pGravarSugestoesNoBanco('speTamanhoFonte', IntToStr(speTamanhoFonte.Value));

  blnConfirma := True;
end;

procedure TfrmConfigExpedicaoItens.btnLeftItensClick(Sender: TObject);
begin
  inherited;
  if not cdsColOrdItens.IsEmpty then
  begin
    cdsColOrdItens.Delete;
    pOrdenaColunasItem;
  end;
end;

procedure TfrmConfigExpedicaoItens.btnMarcaTodosCaixaClick(Sender: TObject);
begin
  inherited;
  pMarcarColunasExibicaoCaixa(True);
  pAjustaColunasDeExibicaoCaixa;
end;

procedure TfrmConfigExpedicaoItens.btnMarcaTodosItensClick(Sender: TObject);
begin
  inherited;
  pMarcarColunasExibicaoItem(True);
  pAjustaColunasDeExibicaoItem;
end;

procedure TfrmConfigExpedicaoItens.btnPadroesClick(Sender: TObject);
begin
  inherited;
  TCfgColExpItensCaixa.pSetarPadrao(dbgItensEstrutura);
  TCfgColExpItensCaixa.pSetarPadraoCaixa(dbgMontagemCaixa);

  TCfgSugExp.pGravarSugestoesNoBanco('speTamanhoFonte', '8');
  speTamanhoFonte.Value := 8;

  pAjustaColunasDeExibicaoItem;
  pAjustaColunasDeExibicaoCaixa;
end;

procedure TfrmConfigExpedicaoItens.btnRightItensClick(Sender: TObject);
var intOrd: Integer;
begin
  inherited;
  intOrd := cdsColOrdItens.RecordCount;
  if not cdsColOrdItens.locate('ORDNAM', cdsItens.FieldByName('COLNAM').AsString, []) then
  Begin
    Inc(intOrd);
    cdsColOrdItens.Insert;
    cdsColOrdItens.FieldByName('ORDNAM').AsString  := cdsItens.FieldByName('COLNAM').AsString ;
    cdsColOrdItens.FieldByName('ORDCAP').AsString  := cdsItens.FieldByName('COLCAP').AsString ;
    cdsColOrdItens.FieldByName('ORDCAM').AsInteger := intOrd;
    cdsColOrdItens.FieldByName('ORDDSC').AsString  := 'N' ;
    cdsColOrdItens.Post;

    pOrdenaColunasItem;
  End;

end;

procedure TfrmConfigExpedicaoItens.btnUpCaixaClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemColunaCaixa(True);
  pIndexarColunasVisiveisCaixa;
end;

procedure TfrmConfigExpedicaoItens.btnUpItensClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemColunaItem(True);
  pIndexarColunasVisiveisItem;
end;

procedure TfrmConfigExpedicaoItens.btnUpOrdCaixaClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemRegistrosCaixa(True);
  pOrdenaColunasCaixa;
end;

procedure TfrmConfigExpedicaoItens.btnUpOrdItensClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemRegistrosItem(True);
  pOrdenaColunasItem;
end;

procedure TfrmConfigExpedicaoItens.cdsColOrdCaixaAfterPost(DataSet: TDataSet);
begin
  inherited;
  if blnColOrdCaixa then
  begin
    pOrdenaColunasCaixa;
    blnColOrdCaixa := False;
  end;
end;

procedure TfrmConfigExpedicaoItens.cdsColOrdItensAfterPost(DataSet: TDataSet);
begin
  inherited;
  if blnColOrdItens then
  begin
    pOrdenaColunasItem;
    blnColOrdItens := False;
  end;
end;

procedure TfrmConfigExpedicaoItens.cxgItensEstruturaTableView1EXIBIRPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  pVisibilidadeColunaItem;
end;

procedure TfrmConfigExpedicaoItens.cxgMontagemCaixaTableViewCitel1EXIBIRPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  pVisibilidadeColunaCaixa;
end;

procedure TfrmConfigExpedicaoItens.cxGridDBColumn3PropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  if cdsColOrdItens.State = dsEdit then
  begin
    blnColOrdItens := True;
    cdsColOrdItens.Post;
  end;
end;

procedure TfrmConfigExpedicaoItens.cxGridDBColumn6PropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  if cdsColOrdCaixa.State = dsEdit then
  begin
    blnColOrdCaixa := True;
    cdsColOrdCaixa.Post;
  end;
end;

procedure TfrmConfigExpedicaoItens.dbgItensEstruturaColumnMoved(Sender: TObject;
  FromIndex, ToIndex: Integer);
begin
  inherited;
  pAjustaColunasDeExibicaoItem;
end;

procedure TfrmConfigExpedicaoItens.dbgItensEstruturaDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
   if not blnFinalizouFormShow then
   begin
     Exit;
   end;

end;

procedure TfrmConfigExpedicaoItens.dbgMontagemCaixaColumnMoved(Sender: TObject;
  FromIndex, ToIndex: Integer);
begin
  inherited;
  pAjustaColunasDeExibicaoCaixa;
end;

procedure TfrmConfigExpedicaoItens.dbgMontagemCaixaDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if not blnFinalizouFormShow then
  begin
    Exit;
  end;
end;

function TfrmConfigExpedicaoItens.fColunaPodeSerConfiguravel(
  const strCaptionColuna: String): Boolean;
begin
  Result := True;

  If (UpperCase(strCaptionColuna) = 'DESTINO') And
     (Not (MatchStr(VS_strTipExp, [TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO,
                                   TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO]))) Then
    Exit(False);
end;

procedure TfrmConfigExpedicaoItens.FormCreate(Sender: TObject);
begin
  inherited;
  frmFatExpedicaoItens := Nil;
  blnFinalizouFormShow := False;
  blnFecharForm := False;
  blnConfirma := False;

  cdsItens.CreateDataSet;
  cdsItens.IndexFieldNames := 'ORDCAM';

  cdsCaixa.CreateDataSet;
  cdsCaixa.IndexFieldNames := 'ORDCAM';

  cdsColOrdItens.CreateDataSet;
  cdsColOrdItens.IndexFieldNames := 'ORDCAM';

  cdsColOrdCaixa.CreateDataSet;
  cdsColOrdCaixa.IndexFieldNames := 'ORDCAM';

  pCarregaOrdExpItens;
  pCarregaOrdExpCaixa;

  speTamanhoFonte.Value := TCfgSugExp.fCarregaTAmanhoFonte('speTamanhoFonte');
  if dbgItensEstrutura.Font.Size <= 0 then
  begin
    speTamanhoFonte.Value := 8;
  end;
end;

procedure TfrmConfigExpedicaoItens.FormPaint(Sender: TObject);
begin
  inherited;
  if blnFecharForm then
  begin
    Close;
  end;
end;

procedure TfrmConfigExpedicaoItens.FormShow(Sender: TObject);
begin
  inherited;
  If (Not Assigned(frmFatExpedicaoItens)) Then
  Begin
    fMensagem('ATENÇÃO!', 'A configuração da expedição deve ser chamada sempre através da tela de expedição - Itens!', ['&OK']);
    blnFecharForm := True;
  End
  Else
  Begin
    WindowState := wsMaximized;
    dtsItensCol.DataSet := frmFatExpedicaoItens.dbgItens.DataSource.DataSet;
    dtsCaixaCol.DataSet := frmFatExpedicaoItens.dbgEtiCaixa.DataSource.DataSet;
    pIniciarDadosItens;
    pIniciarDadosCaixa;
    blnFinalizouFormShow := True;
  End;
end;

procedure TfrmConfigExpedicaoItens.pAdicionarColunaExibicaoEOrdemCaixa(
  recColExp: TrecColExpItensCaixa);
begin
  cdsCaixa.Append;
  cdsCaixa.FieldByName('EXIBIR').AsString := IIF(recColExp.blnVisible, 'S', 'N');
  cdsCaixa.FieldByName('ORDCAM').AsInteger := recColExp.intIndex + 1;
  cdsCaixa.FieldByName('COLCAP').AsString := recColExp.strCaption;
  cdsCaixa.FieldByName('COLNAM').AsString := recColExp.strFieldName;
  cdsCaixa.Post;
  cdsCaixa.First;
end;

procedure TfrmConfigExpedicaoItens.pAdicionarColunaExibicaoEOrdemItem(
  recColExp: TrecColExpItensCaixa);
begin

  If (Not fColunaPodeSerConfiguravel(recColExp.strCaption)) Then
    Exit;

  cdsItens.Append;
  cdsItens.FieldByName('EXIBIR').AsString := IIF(recColExp.blnVisible, 'S', 'N');
  cdsItens.FieldByName('ORDCAM').AsInteger := recColExp.intIndex + 1;
  cdsItens.FieldByName('COLCAP').AsString := recColExp.strCaption;
  cdsItens.FieldByName('COLNAM').AsString := recColExp.strFieldName;
  cdsItens.Post;
  cdsItens.First;
end;

procedure TfrmConfigExpedicaoItens.pAdicionarColunaPreVisualizacaoCaixa(
  intIndex: Integer; recColExp: TrecColExpItensCaixa);
begin
  dbgMontagemCaixa.Columns.Add;
  dbgMontagemCaixa.Columns[intIndex].FieldName     := recColExp.strFieldName;
  dbgMontagemCaixa.Columns[intIndex].Title.Caption := recColExp.strCaption;
  dbgMontagemCaixa.Columns[intIndex].Alignment     := recColExp.Alignment;
  dbgMontagemCaixa.Columns[intIndex].Width         := recColExp.intWidth;
  dbgMontagemCaixa.Columns[intIndex].Visible       := recColExp.blnVisible;
end;

procedure TfrmConfigExpedicaoItens.pAdicionarColunaPreVisualizacaoItem(
  intIndex: Integer; recColExp: TrecColExpItensCaixa);
begin
  dbgItensEstrutura.Columns.Add;
  dbgItensEstrutura.Columns[intIndex].FieldName     := recColExp.strFieldName;
  dbgItensEstrutura.Columns[intIndex].Title.Caption := recColExp.strCaption;
  dbgItensEstrutura.Columns[intIndex].Alignment     := recColExp.Alignment;
  dbgItensEstrutura.Columns[intIndex].Width         := recColExp.intWidth;
  dbgItensEstrutura.Columns[intIndex].Visible       := recColExp.blnVisible;
end;

procedure TfrmConfigExpedicaoItens.pAjustaColunasDeExibicaoCaixa;
  Var
    intCnt : Integer;
    intRecNo : Integer;
begin
  intRecNo := cdsCaixa.RecNo;
  cdsCaixa.DisableControls;
  Try
    For intCnt := 0 To dbgMontagemCaixa.Columns.Count-1 Do
    begin
      If cdsCaixa.Locate('COLNAM', dbgMontagemCaixa.Columns[intCnt].FieldName, []) Then
      begin
        cdsCaixa.Edit;
        cdsCaixa.FieldByName('ORDCAM').AsInteger := intCnt + 1;
        cdsCaixa.FieldByName('EXIBIR').AsString := IIF(dbgMontagemCaixa.Columns[intCnt].Visible, 'S', 'N');
        cdsCaixa.Post;
      end;
    end;
  Finally
    cdsCaixa.RecNo := intRecNo;
    cdsCaixa.EnableControls;
  End;
end;

procedure TfrmConfigExpedicaoItens.pAjustaColunasDeExibicaoItem;
  Var
    intCnt : Integer;
    intRecNo : Integer;
begin
  intRecNo := cdsItens.RecNo;
  cdsItens.DisableControls;
  Try
    For intCnt := 0 To dbgItensEstrutura.Columns.Count-1 Do
    begin
      If cdsItens.Locate('COLNAM', dbgItensEstrutura.Columns[intCnt].FieldName, []) Then
      begin
        cdsItens.Edit;
        cdsItens.FieldByName('ORDCAM').AsInteger := intCnt + 1;
        cdsItens.FieldByName('EXIBIR').AsString := IIF(dbgItensEstrutura.Columns[intCnt].Visible, 'S', 'N');
        cdsItens.Post;
      end;
    end;
  Finally
    cdsItens.RecNo := intRecNo;
    cdsItens.EnableControls;
  End;
end;

procedure TfrmConfigExpedicaoItens.pAlteraOrdemColunaCaixa(blnSobe: Boolean);
  Var
    strCodAtu: String;
Begin
  If cdsCaixa.RecordCount < 2 then
    Exit;

  If (cdsCaixa.FieldByName('ORDCAM').AsInteger = 1) And blnSobe then
    Exit;

  If (cdsCaixa.FieldByName('ORDCAM').AsInteger = cdsCaixa.RecordCount) And (Not blnSobe) then
    Exit;

  cdsCaixa.DisableControls;
  Try
    strCodAtu := cdsCaixa.FieldByName('COLNAM').AsString;

    If blnSobe Then
    Begin
      cdsCaixa.Prior;
      cdsCaixa.Edit;
      cdsCaixa.FieldByName('ORDCAM').AsInteger := Succ(cdsCaixa.FieldByName('ORDCAM').AsInteger);
      cdsCaixa.Post;

      If cdsCaixa.Locate('COLNAM', strCodAtu, []) Then
      Begin
        cdsCaixa.Edit;
        cdsCaixa.FieldByName('ORDCAM').AsInteger := Pred(cdsCaixa.FieldByName('ORDCAM').AsInteger);
        cdsCaixa.Post;
      End;
    End
    Else
    Begin
      cdsCaixa.Next;
      cdsCaixa.Edit;
      cdsCaixa.FieldByName('ORDCAM').AsInteger := Pred(cdsCaixa.FieldByName('ORDCAM').AsInteger);
      cdsCaixa.Post;

      If cdsCaixa.Locate('COLNAM', strCodAtu, []) Then
      Begin
        cdsCaixa.Edit;
        cdsCaixa.FieldByName('ORDCAM').AsInteger := Succ(cdsCaixa.FieldByName('ORDCAM').AsInteger);
        cdsCaixa.Post;
      End;
    End;
  Finally
    cdsCaixa.EnableControls;
  End;
end;

procedure TfrmConfigExpedicaoItens.pAlteraOrdemColunaItem(blnSobe: Boolean);
  Var
    strCodAtu: String;
Begin
  If cdsItens.RecordCount < 2 then
    Exit;

  If (cdsItens.FieldByName('ORDCAM').AsInteger = 1) And blnSobe then
    Exit;

  If (cdsItens.FieldByName('ORDCAM').AsInteger = cdsItens.RecordCount) And (Not blnSobe) then
    Exit;

  cdsItens.DisableControls;
  Try
    strCodAtu := cdsItens.FieldByName('COLNAM').AsString;

    If blnSobe Then
    Begin
      cdsItens.Prior;
      cdsItens.Edit;
      cdsItens.FieldByName('ORDCAM').AsInteger := Succ(cdsItens.FieldByName('ORDCAM').AsInteger);
      cdsItens.Post;

      If cdsItens.Locate('COLNAM', strCodAtu, []) Then
      Begin
        cdsItens.Edit;
        cdsItens.FieldByName('ORDCAM').AsInteger := Pred(cdsItens.FieldByName('ORDCAM').AsInteger);
        cdsItens.Post;
      End;
    End
    Else
    Begin
      cdsItens.Next;
      cdsItens.Edit;
      cdsItens.FieldByName('ORDCAM').AsInteger := Pred(cdsItens.FieldByName('ORDCAM').AsInteger);
      cdsItens.Post;

      If cdsItens.Locate('COLNAM', strCodAtu, []) Then
      Begin
        cdsItens.Edit;
        cdsItens.FieldByName('ORDCAM').AsInteger := Succ(cdsItens.FieldByName('ORDCAM').AsInteger);
        cdsItens.Post;
      End;
    End;
  Finally
    cdsItens.EnableControls;
  End;
end;

procedure TfrmConfigExpedicaoItens.pAlteraOrdemRegistrosCaixa(blnSobe: Boolean);
  Var
    strCodAtu: String;
Begin
  If cdsColOrdCaixa.RecordCount < 2 then
    Exit;

  If (cdsColOrdCaixa.FieldByName('ORDCAM').AsInteger = 1) And blnSobe then
    Exit;

  If (cdsColOrdCaixa.FieldByName('ORDCAM').AsInteger = cdsCaixa.RecordCount) And (Not blnSobe) then
    Exit;

  cdsColOrdCaixa.DisableControls;
  Try
    strCodAtu := cdsColOrdCaixa.FieldByName('ORDNAM').AsString;

    If blnSobe Then
    Begin
      cdsColOrdCaixa.Prior;
      cdsColOrdCaixa.Edit;
      cdsColOrdCaixa.FieldByName('ORDCAM').AsInteger := Succ(cdsColOrdCaixa.FieldByName('ORDCAM').AsInteger);
      cdsColOrdCaixa.Post;

      If cdsColOrdCaixa.Locate('ORDNAM', strCodAtu, []) Then
      Begin
        cdsColOrdCaixa.Edit;
        cdsColOrdCaixa.FieldByName('ORDCAM').AsInteger := Pred(cdsColOrdCaixa.FieldByName('ORDCAM').AsInteger);
        cdsColOrdCaixa.Post;
      End;
    End
    Else
    Begin
      cdsColOrdCaixa.Next;
      cdsColOrdCaixa.Edit;
      cdsColOrdCaixa.FieldByName('ORDCAM').AsInteger := Pred(cdsColOrdCaixa.FieldByName('ORDCAM').AsInteger);
      cdsColOrdCaixa.Post;

      If cdsColOrdCaixa.Locate('ORDNAM', strCodAtu, []) Then
      Begin
        cdsColOrdCaixa.Edit;
        cdsColOrdCaixa.FieldByName('ORDCAM').AsInteger := Succ(cdsColOrdCaixa.FieldByName('ORDCAM').AsInteger);
        cdsColOrdCaixa.Post;
      End;
    End;
  Finally
    cdsColOrdCaixa.EnableControls;
  End;
end;

procedure TfrmConfigExpedicaoItens.pAlteraOrdemRegistrosItem(blnSobe: Boolean);
  Var
    strCodAtu: String;
Begin
  If cdsColOrdItens.RecordCount < 2 then
    Exit;

  If (cdsColOrdItens.FieldByName('ORDCAM').AsInteger = 1) And blnSobe then
    Exit;

  If (cdsColOrdItens.FieldByName('ORDCAM').AsInteger = cdsItens.RecordCount) And (Not blnSobe) then
    Exit;

  cdsColOrdItens.DisableControls;
  Try
    strCodAtu := cdsColOrdItens.FieldByName('ORDNAM').AsString;

    If blnSobe Then
    Begin
      cdsColOrdItens.Prior;
      cdsColOrdItens.Edit;
      cdsColOrdItens.FieldByName('ORDCAM').AsInteger := Succ(cdsColOrdItens.FieldByName('ORDCAM').AsInteger);
      cdsColOrdItens.Post;

      If cdsColOrdItens.Locate('ORDNAM', strCodAtu, []) Then
      Begin
        cdsColOrdItens.Edit;
        cdsColOrdItens.FieldByName('ORDCAM').AsInteger := Pred(cdsColOrdItens.FieldByName('ORDCAM').AsInteger);
        cdsColOrdItens.Post;
      End;
    End
    Else
    Begin
      cdsColOrdItens.Next;
      cdsColOrdItens.Edit;
      cdsColOrdItens.FieldByName('ORDCAM').AsInteger := Pred(cdsColOrdItens.FieldByName('ORDCAM').AsInteger);
      cdsColOrdItens.Post;

      If cdsColOrdItens.Locate('ORDNAM', strCodAtu, []) Then
      Begin
        cdsColOrdItens.Edit;
        cdsColOrdItens.FieldByName('ORDCAM').AsInteger := Succ(cdsColOrdItens.FieldByName('ORDCAM').AsInteger);
        cdsColOrdItens.Post;
      End;
    End;
  Finally
    cdsColOrdItens.EnableControls;
  End;
end;

procedure TfrmConfigExpedicaoItens.pCarregaOrdExpCaixa;
var qryTmp : TUniQuery;
Begin
  Try
    qryTmp := fCriaQuery;
    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM OREXCA          ');
      SQL.Add(' WHERE XCA_TIPEXP = :TIPEXP   ');
      SQL.Add('   AND XCA_CODEMP = :CODEMP   ');
      SQL.Add(' ORDER BY XCA_ORDCAM ');
      ParamByName('TIPEXP').AsString := VS_strTipExp;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      While not eof do
      Begin
        cdsColOrdCaixa.Insert;
        cdsColOrdCaixa.FieldByName('ORDNAM').AsString  := FieldByName('XCA_ORDNAM').AsString ;
        cdsColOrdCaixa.FieldByName('ORDCAP').AsString  := FieldByName('XCA_ORDCAP').AsString ;
        cdsColOrdCaixa.FieldByName('ORDCAM').AsInteger := FieldByName('XCA_ORDCAM').AsInteger ;
        cdsColOrdCaixa.FieldByName('ORDDSC').AsString  := FieldByName('XCA_ORDDSC').AsString ;
        cdsColOrdCaixa.Post;

        Next;
      End;
    End;
  Finally
    FreeAndNil(qryTmp);
  End;

end;

procedure TfrmConfigExpedicaoItens.pCarregaOrdExpItens;
var qryTmp : TUniQuery;
Begin
  Try
    qryTmp := fCriaQuery;
    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM OREXIT          ');
      SQL.Add(' WHERE XIT_TIPEXP = :TIPEXP   ');
      SQL.Add('   AND XIT_CODEMP = :CODEMP   ');
      SQL.Add(' ORDER BY XIT_ORDCAM ');
      ParamByName('TIPEXP').AsString := VS_strTipExp;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      While not eof do
      Begin
        cdsColOrdItens.Insert;
        cdsColOrdItens.FieldByName('ORDNAM').AsString  := FieldByName('XIT_ORDNAM').AsString ;
        cdsColOrdItens.FieldByName('ORDCAP').AsString  := FieldByName('XIT_ORDCAP').AsString ;
        cdsColOrdItens.FieldByName('ORDCAM').AsInteger := FieldByName('XIT_ORDCAM').AsInteger ;
        cdsColOrdItens.FieldByName('ORDDSC').AsString  := FieldByName('XIT_ORDDSC').AsString ;
        cdsColOrdItens.Post;

        Next;
      End;
    End;
  Finally
    FreeAndNil(qryTmp);
  End;

end;

procedure TfrmConfigExpedicaoItens.pIndexarColunasVisiveisCaixa;
  Var
    Column : TColumn;
    intRecNo : Integer;
begin
  cdsCaixa.DisableControls;
  intRecNo := cdsCaixa.RecNo;
  Try
    cdsCaixa.First;
    While Not cdsCaixa.Eof Do
    Begin
      Column := fFindColumnByName(dbgMontagemCaixa, cdsCaixa.FieldByName('COLNAM').AsString);

      If (Column <> Nil) Then
        Column.Index := cdsCaixa.FieldByName('ORDCAM').AsInteger - 1;

      cdsCaixa.Next;
    End;
    cdsCaixa.First;
  Finally
    cdsCaixa.RecNo := intRecNo;
    cdsCaixa.EnableControls;
  End;
end;

procedure TfrmConfigExpedicaoItens.pIndexarColunasVisiveisItem;
  Var
    Column : TColumn;
    intRecNo : Integer;
begin
  cdsItens.DisableControls;
  intRecNo := cdsItens.RecNo;
  Try
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      Column := fFindColumnByName(dbgItensEstrutura, cdsItens.FieldByName('COLNAM').AsString);

      If (Column <> Nil) Then
        Column.Index := cdsItens.FieldByName('ORDCAM').AsInteger - 1;

      cdsItens.Next;
    End;
    cdsItens.First;
  Finally
    cdsItens.RecNo := intRecNo;
    cdsItens.EnableControls;
  End;
end;

procedure TfrmConfigExpedicaoItens.pIniciarDadosCaixa;
  Var
    intCnt : Integer;
    recColExpCaixa : TrecColExpItensCaixa;
begin
  dtsCaixaCol.DataSet.DisableControls;
  Try
    For intCnt := Low(TCfgColExpItensCaixa.arrColsOriCaixa) To High(TCfgColExpItensCaixa.arrColsOriCaixa) Do
    Begin
      recColExpCaixa := TCfgColExpItensCaixa.arrColsOriCaixa[intCnt];
      pAdicionarColunaExibicaoEOrdemCaixa(recColExpCaixa);
      pAdicionarColunaPreVisualizacaoCaixa(intCnt, recColExpCaixa);
    End;

    TCfgColExpItensCaixa.pSetarUltimosDadosCarregadosCaixa(dbgMontagemCaixa);

    pAjustaColunasDeExibicaoCaixa;

    cdsCaixa.First;

  Finally
    dtsCaixaCol.DataSet.EnableControls;
  End;
end;

procedure TfrmConfigExpedicaoItens.pIniciarDadosItens;
  Var
    intCnt : Integer;
    recColExpItens : TrecColExpItensCaixa;
begin
  dtsItensCol.DataSet.DisableControls;
  Try
    For intCnt := Low(TCfgColExpItensCaixa.arrColsOri) To High(TCfgColExpItensCaixa.arrColsOri) Do
    Begin
      recColExpItens := TCfgColExpItensCaixa.arrColsOri[intCnt];
      pAdicionarColunaExibicaoEOrdemItem(recColExpItens);
      pAdicionarColunaPreVisualizacaoItem(intCnt, recColExpItens);
    End;

    TCfgColExpItensCaixa.pSetarUltimosDadosCarregados(dbgItensEstrutura);

    pAjustaColunasDeExibicaoItem;

    If (fCfgSis('CTLEST') = '2') Then
      fFindColumnByName(dbgItensEstrutura,'ARMAZE').Title.Caption := 'Armazém'
    Else
      fFindColumnByName(dbgItensEstrutura,'ARMAZE').Title .Caption:= 'Lote';

    cdsItens.First;

  Finally
    dtsItensCol.DataSet.EnableControls;
  End;
end;

procedure TfrmConfigExpedicaoItens.pMarcarColunasExibicaoCaixa(
  blnMarcar: Boolean);
  Var
    intRecNo : Integer;
begin
  With cdsCaixa Do
  Begin
    DisableControls;
    intRecNo := RecNo;
    Try
      First;

      While Not Eof do
      Begin
        Edit;

        If blnMarcar Then
          FieldByName('EXIBIR').AsString :=  'S'
        Else
          FieldByName('EXIBIR').AsString :=  'N';

        Post;

        pVisibilidadeColunaCaixa;

        Next;
      End;

      First;
    Finally
      RecNo := intRecNo;
      EnableControls;
    End;
  End;
end;

procedure TfrmConfigExpedicaoItens.pMarcarColunasExibicaoItem(
  blnMarcar: Boolean);
  Var
    intRecNo : Integer;
begin
  With cdsItens Do
  Begin
    DisableControls;
    intRecNo := RecNo;
    Try
      First;

      While Not Eof do
      Begin
        Edit;

        If blnMarcar Then
          FieldByName('EXIBIR').AsString :=  'S'
        Else
          FieldByName('EXIBIR').AsString :=  'N';

        Post;

        pVisibilidadeColunaItem;

        Next;
      End;

      First;
    Finally
      RecNo := intRecNo;
      EnableControls;
    End;
  End;
end;

procedure TfrmConfigExpedicaoItens.pOrdenaColunasCaixa;
var cdsOrd, cdsBkp: TUniClientDataSet;
    strFields: String;
    strDescFields: String;
    strBookMark : TBookMark;
begin
  Try
    cdsOrd := TUniClientDataSet( frmFatExpedicaoItens.dbgEtiCaixa.DataSource.DataSet );

    cdsBkp := TUniClientDataSet.Create(Self);
    cdsBkp.Data := cdsOrd.data;

    cdsOrd.IndexDefs.Clear;
    cdsOrd.IndexName := '';
    cdsOrd.StoreDefs := False;
    cdsOrd.IndexFieldNames := '';

    if not cdsColOrdCaixa.isEmpty then
    Begin
      With cdsColOrdCaixa do
      Begin
        strBookMark := GetBookMark;
        DisableControls;
        first;
        While not eof do
        Begin
          if FieldByName('ORDDSC').AsString = 'S' then
          Begin
            if fEmptyStr(strDescFields) then
              strDescFields := FieldByName('ORDNAM').AsString
            else
              strDescFields := strFields + ';' + FieldByName('ORDNAM').AsString ;
          End;

          if fEmptyStr(strFields) then
            strFields := FieldByName('ORDNAM').AsString
          else
            strFields := strFields + ';' + FieldByName('ORDNAM').AsString ;

          Next;
        End;
        EnableControls;
        BookMark := strBookMark;
      End;

      cdsOrd.Active := false;
      With cdsOrd.IndexDefs.AddIndexDef Do
      Begin
        Name   := 'IDX_001';
        Fields := strFields;
        DescFields := strDescFields;
      End;
      cdsOrd.IndexName := 'IDX_001';

      cdsOrd.CreateDataSet;
      cdsOrd.Data := cdsBkp.Data;
    End;

  Finally
    FreeAndNil(cdsBkp);
  End;
end;

procedure TfrmConfigExpedicaoItens.pOrdenaColunasItem;
var cdsOrd, cdsBkp: TUniClientDataSet;
    strFields: String;
    strDescFields: String;
    strBookMark : TBookMark;
begin
  Try
    cdsOrd := TUniClientDataSet( frmFatExpedicaoItens.dbgItens.DataSource.DataSet );

    cdsBkp := TUniClientDataSet.Create(Self);
    cdsBkp.Data := cdsOrd.data;

    cdsOrd.IndexDefs.Clear;
    cdsOrd.IndexName := '';
    cdsOrd.StoreDefs := False;
    cdsOrd.IndexFieldNames := '';

    if not cdsColOrdItens.isEmpty then
    Begin
      With cdsColOrdItens do
      Begin
        strBookMark := GetBookMark;
        DisableControls;
        first;
        While not eof do
        Begin
          if FieldByName('ORDDSC').AsString = 'S' then
          Begin
            if fEmptyStr(strDescFields) then
              strDescFields := FieldByName('ORDNAM').AsString
            else
              strDescFields := strFields + ';' + FieldByName('ORDNAM').AsString ;
          End;

          if fEmptyStr(strFields) then
            strFields := FieldByName('ORDNAM').AsString
          else
            strFields := strFields + ';' + FieldByName('ORDNAM').AsString ;

          Next;
        End;
        EnableControls;
        BookMark := strBookMark;
      End;

      cdsOrd.Active := false;
      With cdsOrd.IndexDefs.AddIndexDef Do
      Begin
        Name   := 'IDX_001';
        Fields := strFields;
        DescFields := strDescFields;
      End;
      cdsOrd.IndexName := 'IDX_001';

      cdsOrd.CreateDataSet;
      cdsOrd.Data := cdsBkp.Data;
    End;

  Finally
    FreeAndNil(cdsBkp);
  End;
end;

procedure TfrmConfigExpedicaoItens.pVisibilidadeColunaCaixa;
  Var
    Column : TColumn;
begin
  inherited;
  If (Not fEmptyStr(cdsCaixa.FieldByName('COLNAM').AsString)) Then
  Begin
    Column := fFindColumnByName(dbgMontagemCaixa, cdsCaixa.FieldByName('COLNAM').AsString);

    If (Column <> Nil) Then
      Column.Visible := (cdsCaixa.FieldByName('EXIBIR').AsString = 'S');
  End;
end;

procedure TfrmConfigExpedicaoItens.pVisibilidadeColunaItem;
  Var
    Column : TColumn;
begin
  inherited;
  If (Not fEmptyStr(cdsItens.FieldByName('COLNAM').AsString)) Then
  Begin
    Column := fFindColumnByName(dbgItensEstrutura, cdsItens.FieldByName('COLNAM').AsString);

    If (Column <> Nil) Then
      Column.Visible := (cdsItens.FieldByName('EXIBIR').AsString = 'S');
  End;
end;

procedure TfrmConfigExpedicaoItens.speTamanhoFonteChange(Sender: TObject);
begin
  inherited;
  if speTamanhoFonte.Value <= 0 then
  begin
    speTamanhoFonte.Value := 1;
  end;

  cxgItensEstrutura.Font.Size := speTamanhoFonte.Value;
  cxgColOrdItens.Font.Size    := speTamanhoFonte.Value;
  cxgMontagemCaixa.Font.Size  := speTamanhoFonte.Value;
  cxgColOrdCaixa.Font.Size    := speTamanhoFonte.Value;
  dbgItensEstrutura.Font.Size := speTamanhoFonte.Value;
  dbgMontagemCaixa.Font.Size  := speTamanhoFonte.Value;
end;

procedure TfrmConfigExpedicaoItens.btnRightCaixaClick(Sender: TObject);
var intOrd: Integer;
begin
  inherited;
  intOrd := cdsColOrdCaixa.RecordCount;
  if not cdsColOrdCaixa.locate('ORDNAM', cdsCaixa.FieldByName('COLNAM').AsString, []) then
  Begin
    Inc(intOrd);
    cdsColOrdCaixa.Insert;
    cdsColOrdCaixa.FieldByName('ORDNAM').AsString  := cdsCaixa.FieldByName('COLNAM').AsString ;
    cdsColOrdCaixa.FieldByName('ORDCAP').AsString  := cdsCaixa.FieldByName('COLCAP').AsString ;
    cdsColOrdCaixa.FieldByName('ORDCAM').AsInteger := intOrd;
    cdsColOrdCaixa.FieldByName('ORDDSC').AsString  := 'N' ;
    cdsColOrdCaixa.Post;

    pOrdenaColunasCaixa;
  End;

end;

procedure TfrmConfigExpedicaoItens.btnLeftCaixaClick(Sender: TObject);
begin
  inherited;
  if not cdsColOrdCaixa.IsEmpty then
  begin
    cdsColOrdCaixa.Delete;
    pOrdenaColunasCaixa;
  end;
end;

end.
