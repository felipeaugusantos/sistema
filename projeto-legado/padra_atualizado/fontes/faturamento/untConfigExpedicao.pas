unit untConfigExpedicao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxCheckBox,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, Datasnap.DBClient,
  UniClientDataSet, Vcl.Grids, Vcl.DBGrids, DBGridCitel, cxGridCitel,
  Vcl.ComCtrls, Uni, untCfgColExp, Vcl.Samples.Gauges, untFatExpedicao,
  ComboBoxFocus, cxImageComboBox, cxContainer, cxProgressBar,
  cxDataControllerConditionalFormattingRulesManagerDialog, Vcl.Samples.Spin,
  untFatExpedicaoBusca, untCorGrid, dxColorEdit, cxColorComboBox, cxButtonEdit,
  cxVGrid, cxInplaceContainer, cxExtEditRepositoryItems, cxSpinEdit,
  cxEditRepositoryItems, untConfigOcultaInfo, untTypesSistema;

 type
  TfrmConfigExpedicao = class(TfrmPai)
    pnlCfgExp: TPanel;
    cdsColExi: TUniClientDataSet;
    cdsColExiCOLCAP: TStringField;
    cdsColExiCOLNAM: TStringField;
    dtsCfgCol: TDataSource;
    cdsColExiEXIBIR: TStringField;
    pnlGrdCol: TPanel;
    pnlGrdExp: TPanel;
    cxgColunasLevel1: TcxGridLevel;
    cxgColunasTableView1: TcxGridDBTableViewCitel;
    cxgColunas: TcxGridCitel;
    cxgColunasTableView1EXIBIR: TcxGridDBColumn;
    cxgColunasTableView1ORDCAM: TcxGridDBColumn;
    cxgColunasTableView1COLCAP: TcxGridDBColumn;
    cxgColunasTableView1COLNAM: TcxGridDBColumn;
    pnlCfgCol: TPanel;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnUp: TSpeedButton;
    btnDown: TSpeedButton;
    cdsColExiORDCAM: TIntegerField;
    btnGravar: TBitBtnLocked;
    dbgVisExp: TDBGridCitel;
    dtsVisExp: TDataSource;
    pgcCfgExp: TPageControl;
    tbsColunas: TTabSheet;
    tbsSugestao: TTabSheet;
    cdsColExiCOLTAM: TIntegerField;
    pnlAreaVis: TPanel;
    gagAreGrid: TGauge;
    Label1: TLabel;
    cxgColunasOrdenacao: TcxGridCitel;
    cxgColunasOrdenacaoTableView1: TcxGridDBTableViewCitel;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    pnlCentral: TPanel;
    btnRight: TSpeedButton;
    btnLeft: TSpeedButton;
    btnUpOrd: TSpeedButton;
    btnDownOrd: TSpeedButton;
    btnPadroes: TBitBtnLocked;
    cdsColOrd: TUniClientDataSet;
    IntegerField1: TIntegerField;
    dtsColOrd: TDataSource;
    StringField3: TStringField;
    cxGridDBColumn3: TcxGridDBColumn;
    StringField1: TStringField;
    StringField2: TStringField;
    grbTamanhoFonte: TGroupBox;
    speTamanhoFonteConfigExpedicao: TSpinEdit;
    tsCampoParaFoco: TTabSheet;
    tsCores: TTabSheet;
    cxVerticalGrid1: TcxVerticalGrid;
    ccbSepNaoImp: TcxEditorRow;
    crCorFonte: TcxCategoryRow;
    crCorFundo: TcxCategoryRow;
    ccbOrdProPendente: TcxEditorRow;
    ccbOrdPro: TcxEditorRow;
    cxEditRepository1: TcxEditRepository;
    ccbCores: TcxEditRepositoryColorComboBox;
    ccbAltSepImp: TcxEditorRow;
    ccbDocPosFonte: TcxEditorRow;
    ccbDocSelPos: TcxEditorRow;
    ccbUrgente: TcxEditorRow;
    ccbTotExp: TcxEditorRow;
    ccbSepReimp: TcxEditorRow;
    ccbLibSep: TcxEditorRow;
    ccbGarantia: TcxEditorRow;
    ccbIteExp: TcxEditorRow;
    ccbSepImp: TcxEditorRow;
    ccbDocDev: TcxEditorRow;
    ccbDocSel: TcxEditorRow;
    ccbDocPosFundo: TcxEditorRow;
    ccbVenEmp: TcxEditorRow;
    ccbVenOutEmp: TcxEditorRow;
    crSequenciaCor: TcxCategoryRow;
    ccbSeqSepNaoImp: TcxEditorRow;
    ccbSeqSepImp: TcxEditorRow;
    ccbSeqAltSepImp: TcxEditorRow;
    ccbSeqDocDev: TcxEditorRow;
    ccbSeqSepReimp: TcxEditorRow;
    ccbSeqLibSep: TcxEditorRow;
    ccbSeqIteExp: TcxEditorRow;
    ccbSeqTotExp: TcxEditorRow;
    ccbSequencia: TcxEditRepositorySpinItem;
    tsOcultaInformacoes: TTabSheet;
    chkOcultPed: TCheckBox;
    chkOcultInf: TCheckBox;
    tsFiltroVendedor: TTabSheet;
    Label2: TLabel;
    chkOcultFer: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure cxgColunasTableView1EXIBIRPropertiesEditValueChanged(
      Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnPadroesClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgVisExpDrawColumnCell(Sender: TObject; const [Ref] Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgVisExpColumnMoved(Sender: TObject; FromIndex,
      ToIndex: Integer);
    procedure btnRightClick(Sender: TObject);
    procedure btnLeftClick(Sender: TObject);
    procedure btnUpOrdClick(Sender: TObject);
    procedure btnDownOrdClick(Sender: TObject);
    procedure cdsColOrdAfterPost(DataSet: TDataSet);
    procedure cxGridDBColumn3PropertiesEditValueChanged(Sender: TObject);
    procedure speTamanhoFonteConfigExpedicaoChange(Sender: TObject);
    procedure tsFiltroVendedorShow(Sender: TObject);
  private
    { Private declarations }
    blnColOrd,
    blnFecharForm : Boolean;
    frmFatExp : TfrmFatExpedicao;
    blnFinalizouFormShow : Boolean;
    FfrmFatExpedicaoBusca : TfrmFatExpedicaoBusca;
    FfrmFatExpedicaoBuscaFiltroVendedor : TfrmFatExpedicaoBusca;
    FCorGrid: TCorGrid;
    objConfigOcultInfo: TOcultInfo;

    procedure pIniciarDados;
    procedure pAdicionarColunaPreVisualizacao(intIndex: Integer; recColExp: TrecColExp);
    procedure pAdicionarColunaExibicaoEOrdem(recColExp: TrecColExp);
    procedure pMarcarColunasExibicao(blnMarcar: Boolean);
    procedure pAlteraOrdemColuna(blnSobe: Boolean);
    procedure pIndexarColunasVisiveis;
    procedure pVisibilidadeColuna;
    function fGetWidthGrid: Integer;
    procedure pAjustaColunasDeExibicao;
    procedure pOrdenaColunas;
    procedure pAlteraOrdemRegistros(blnSobe: Boolean);
    procedure pCarregaOrdExp;
    procedure pPrepararFormularioParaSugestaoDoFoco;
    procedure pPrepararFormularioParaFiltrarVendedor;
    procedure pCarregaCoresGrid;
    procedure pGravaCoresGrid;
    procedure pRestaurarCoresGrid;
    procedure pGravaConfigOcultaInfo;
    procedure pRestauraConfigOcultaInfo;
    function fVerificaSequencia():Boolean;
    function fRetornaMultiplosCodigos(arrValores: TConsultasArray): String;

  public
    { Public declarations }
    blnConfirma : Boolean;
    frmFatExpedicao : TfrmFatExpedicao;
    arrVendedor : TConsultasArray;
    arrDepVen : TConsultasArray;

  end;

var
  frmConfigExpedicao: TfrmConfigExpedicao;

implementation

{$R *.dfm}

uses untFuncoesSimples, untCfgSugExp;

procedure TfrmConfigExpedicao.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarColunasExibicao(False);
  pAjustaColunasDeExibicao;
end;

procedure TfrmConfigExpedicao.btnDownClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemColuna(False);
  pIndexarColunasVisiveis;
end;

procedure TfrmConfigExpedicao.btnGravarClick(Sender: TObject);
  Var
    arrCol : TArrayOfColExp;
    strMultVendedores: String;
    strMultiDepartamentos: String;
begin
  if (not fVerificaSequencia()) then
  begin
    ModalResult := mrNone;
    Exit;
  end;

  inherited;

  strMultVendedores := fRetornaMultiplosCodigos(FfrmFatExpedicaoBuscaFiltroVendedor.arrVendedor);
  strMultiDepartamentos := fRetornaMultiplosCodigos(FfrmFatExpedicaoBuscaFiltroVendedor.arrDepVen);

  TCfgSugExp.pGravarSugestoesNoBanco('TfrmFatExpedicaoBusca',FfrmFatExpedicaoBusca.NomeUltimoComponenteSelecionado);
  TCfgSugExp.pGravarSugestoesNoBanco('edtCodVen', IIF(fEmptyStr(strMultVendedores),FfrmFatExpedicaoBuscaFiltroVendedor.edtCodVen.Text,strMultVendedores), True);
  TCfgSugExp.pGravarSugestoesNoBanco('edtCodDep', IIF(fEmptyStr(strMultiDepartamentos),FfrmFatExpedicaoBuscaFiltroVendedor.edtCodDep.Text, strMultiDepartamentos), True);

  TCfgColExp.pSalvarEstado(dbgVisExp, arrCol);
  TCfgColExp.pGravarDadosNoBanco(arrCol, cdsColOrd);
  TCfgSugExp.pGravaChaveEValorSugestao(frmFatExp.pnlFiltros);
  TCfgSugExp.pGravarSugestoesNoBanco('speTamanhoFonteConfigExpedicao', IntToStr(speTamanhoFonteConfigExpedicao.Value));
  pGravaCoresGrid;
  pGravaConfigOcultaInfo;
  blnConfirma := True;
end;

procedure TfrmConfigExpedicao.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarColunasExibicao(True);
  pAjustaColunasDeExibicao;
end;

procedure TfrmConfigExpedicao.btnPadroesClick(Sender: TObject);
begin
  inherited;
  TCfgColExp.pSetarPadrao(dbgVisExp);
  pAjustaColunasDeExibicao;
  TCfgSugExp.pGravarSugestoesNoBanco('speTamanhoFonteConfigExpedicao', '8');
  speTamanhoFonteConfigExpedicao.Value := 8;
  pRestaurarCoresGrid;
  pRestauraConfigOcultaInfo;
end;



procedure TfrmConfigExpedicao.pCarregaCoresGrid;
begin
  if not Assigned(FCorGrid) then
    FCorGrid := TCorGrid.Create('frmFatExpedicao', 'dbgPedidos')
  else
    FCorGrid.Atualizar;

  ccbSepNaoImp.Properties.Value := FCorGrid.CarregarCorToStr('SepNaoImp');
  ccbSepImp.Properties.Value := FCorGrid.CarregarCorToStr('SepImp');
  ccbAltSepImp.Properties.Value := FCorGrid.CarregarCorToStr('AltSepImp');
  ccbDocDev.Properties.Value := FCorGrid.CarregarCorToStr('DocDev');
  ccbSepReimp.Properties.Value := FCorGrid.CarregarCorToStr('SepReimp');
  ccbLibSep.Properties.Value := FCorGrid.CarregarCorToStr('LibSep');
  ccbIteExp.Properties.Value := FCorGrid.CarregarCorToStr('IteExp');
  ccbTotExp.Properties.Value := FCorGrid.CarregarCorToStr('TotExp');
  ccbUrgente.Properties.Value := FCorGrid.CarregarCorToStr('Urgente');
  ccbOrdPro.Properties.Value := FCorGrid.CarregarCorToStr('OrdPro');
  ccbOrdProPendente.Properties.Value := FCorGrid.CarregarCorToStr('OrdProPendente');
  ccbDocPosFonte.Properties.Value := FCorGrid.CarregarCorToStr('DocPosFonte');
  ccbDocSelPos.Properties.Value := FCorGrid.CarregarCorToStr('DocSelPos');
  ccbGarantia.Properties.Value := FCorGrid.CarregarCorToStr('Garantia');
  ccbDocSel.Properties.Value := FCorGrid.CarregarCorToStr('DocSel');
  ccbDocPosFundo.Properties.Value := FCorGrid.CarregarCorToStr('DocPosFundo');
  ccbVenEmp.Properties.Value := FCorGrid.CarregarCorToStr('VenEmp');
  ccbVenOutEmp.Properties.Value := FCorGrid.CarregarCorToStr('VenOutEmp');

  ccbSeqSepNaoImp.Properties.Value      := FCorGrid.CarregarSeqCor('SepNaoImp',      '1');
  ccbSeqSepImp.Properties.Value         := FCorGrid.CarregarSeqCor('SepImp',         '2');
  ccbSeqAltSepImp.Properties.Value      := FCorGrid.CarregarSeqCor('AltSepImp',      '3');
  ccbSeqDocDev.Properties.Value         := FCorGrid.CarregarSeqCor('DocDev',         '4');
  ccbSeqSepReimp.Properties.Value       := FCorGrid.CarregarSeqCor('SepReimp',       '5');
  ccbSeqLibSep.Properties.Value         := FCorGrid.CarregarSeqCor('LibSep',         '6');
  ccbSeqIteExp.Properties.Value         := FCorGrid.CarregarSeqCor('IteExp',         '7');
  ccbSeqTotExp.Properties.Value         := FCorGrid.CarregarSeqCor('TotExp',         '8');
end;

procedure TfrmConfigExpedicao.pCarregaOrdExp;
var qryTmp : TUniQuery;
Begin
  Try
    qryTmp := fCriaQuery;
    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM ORDEXP          ');
      SQL.Add(' WHERE EXP_TIPEXP = :TIPEXP   ');
      SQL.Add('   AND EXP_CODEMP = :CODEMP   ');
      SQL.Add(' ORDER BY EXP_ORDCAM ');
      ParamByName('TIPEXP').AsString := VS_strTipExp;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      While not eof do
      Begin
        cdsColOrd.Insert;
        cdsColOrd.FieldByName('ORDNAM').AsString  := FieldByName('EXP_ORDNAM').AsString ;
        cdsColOrd.FieldByName('ORDCAP').AsString  := FieldByName('EXP_ORDCAP').AsString ;
        cdsColOrd.FieldByName('ORDCAM').AsInteger := FieldByName('EXP_ORDCAM').AsInteger ;
        cdsColOrd.FieldByName('ORDDSC').AsString  := FieldByName('EXP_ORDDSC').AsString ;
        cdsColOrd.Post;

        Next;
      End;
    End;
  Finally
    FreeAndNil(qryTmp);
  End;

end;

procedure TfrmConfigExpedicao.pGravaConfigOcultaInfo;
begin
  objConfigOcultInfo.OcultPnlInf := chkOcultInf.Checked;
  objConfigOcultInfo.OcultStaPed := chkOcultPed.Checked;
  objConfigOcultInfo.OcultFerMun := chkOcultFer.Checked;
  objConfigOcultInfo.pAtualizaConfiguracao;
end;

procedure TfrmConfigExpedicao.pGravaCoresGrid;
begin
  FCorGrid.AlterarCorStr('SepNaoImp', ccbSepNaoImp.Properties.Value);
  FCorGrid.AlterarCorStr('SepImp', ccbSepImp.Properties.Value);
  FCorGrid.AlterarCorStr('AltSepImp', ccbAltSepImp.Properties.Value);
  FCorGrid.AlterarCorStr('DocDev', ccbDocDev.Properties.Value);
  FCorGrid.AlterarCorStr('SepReimp', ccbSepReimp.Properties.Value);
  FCorGrid.AlterarCorStr('LibSep', ccbLibSep.Properties.Value);
  FCorGrid.AlterarCorStr('IteExp', ccbIteExp.Properties.Value);
  FCorGrid.AlterarCorStr('TotExp', ccbTotExp.Properties.Value);
  FCorGrid.AlterarCorStr('Urgente', ccbUrgente.Properties.Value);
  FCorGrid.AlterarCorStr('OrdPro', ccbOrdPro.Properties.Value);
  FCorGrid.AlterarCorStr('OrdProPendente', ccbOrdProPendente.Properties.Value);
  FCorGrid.AlterarCorStr('DocPosFonte', ccbDocPosFonte.Properties.Value);
  FCorGrid.AlterarCorStr('DocSelPos', ccbDocSelPos.Properties.Value);
  FCorGrid.AlterarCorStr('Garantia', ccbGarantia.Properties.Value);
  FCorGrid.AlterarCorStr('DocSel', ccbDocSel.Properties.Value);
  FCorGrid.AlterarCorStr('DocPosFundo', ccbDocPosFundo.Properties.Value);
  FCorGrid.AlterarCorStr('VenEmp', ccbVenEmp.Properties.Value);
  FCorGrid.AlterarCorStr('VenOutEmp', ccbVenOutEmp.Properties.Value);

  FCorGrid.AlterarSeqCor('SepNaoImp',      ccbSeqSepNaoImp.Properties.Value);
  FCorGrid.AlterarSeqCor('SepImp',         ccbSeqSepImp.Properties.Value);
  FCorGrid.AlterarSeqCor('AltSepImp',      ccbSeqAltSepImp.Properties.Value);
  FCorGrid.AlterarSeqCor('DocDev',         ccbSeqDocDev.Properties.Value);
  FCorGrid.AlterarSeqCor('SepReimp',       ccbSeqSepReimp.Properties.Value);
  FCorGrid.AlterarSeqCor('LibSep',         ccbSeqLibSep.Properties.Value);
  FCorGrid.AlterarSeqCor('IteExp',         ccbSeqIteExp.Properties.Value);
  FCorGrid.AlterarSeqCor('TotExp',         ccbSeqTotExp.Properties.Value);
end;

procedure TfrmConfigExpedicao.btnRightClick(Sender: TObject);
var intOrd: Integer;
begin
  inherited;
  intOrd := cdsColOrd.RecordCount;
  if not cdsColOrd.locate('ORDNAM', cdsColExi.FieldByName('COLNAM').AsString, []) then
  Begin
    Inc(intOrd);
    cdsColOrd.Insert;
    cdsColOrd.FieldByName('ORDNAM').AsString  := cdsColExi.FieldByName('COLNAM').AsString ;
    cdsColOrd.FieldByName('ORDCAP').AsString  := cdsColExi.FieldByName('COLCAP').AsString ;
    cdsColOrd.FieldByName('ORDCAM').AsInteger := intOrd;
    cdsColOrd.FieldByName('ORDDSC').AsString  := 'N' ;
    cdsColOrd.Post;

    pOrdenaColunas;
  End;

end;

procedure TfrmConfigExpedicao.pAlteraOrdemRegistros(blnSobe: Boolean);
  Var
    strCodAtu: String;
Begin
  If cdsColOrd.RecordCount < 2 then
    Exit;

  If (cdsColOrd.FieldByName('ORDCAM').AsInteger = 1) And blnSobe then
    Exit;

  If (cdsColOrd.FieldByName('ORDCAM').AsInteger = cdsColExi.RecordCount) And (Not blnSobe) then
    Exit;

  cdsColOrd.DisableControls;
  Try
    strCodAtu := cdsColOrd.FieldByName('ORDNAM').AsString;

    If blnSobe Then
    Begin
      cdsColOrd.Prior;
      cdsColOrd.Edit;
      cdsColOrd.FieldByName('ORDCAM').AsInteger := Succ(cdsColOrd.FieldByName('ORDCAM').AsInteger);
      cdsColOrd.Post;

      If cdsColOrd.Locate('ORDNAM', strCodAtu, []) Then
      Begin
        cdsColOrd.Edit;
        cdsColOrd.FieldByName('ORDCAM').AsInteger := Pred(cdsColOrd.FieldByName('ORDCAM').AsInteger);
        cdsColOrd.Post;
      End;
    End
    Else
    Begin
      cdsColOrd.Next;
      cdsColOrd.Edit;
      cdsColOrd.FieldByName('ORDCAM').AsInteger := Pred(cdsColOrd.FieldByName('ORDCAM').AsInteger);
      cdsColOrd.Post;

      If cdsColOrd.Locate('ORDNAM', strCodAtu, []) Then
      Begin
        cdsColOrd.Edit;
        cdsColOrd.FieldByName('ORDCAM').AsInteger := Succ(cdsColOrd.FieldByName('ORDCAM').AsInteger);
        cdsColOrd.Post;
      End;
    End;
  Finally
    cdsColOrd.EnableControls;
  End;
end;

procedure TfrmConfigExpedicao.btnUpOrdClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemRegistros(True);
  pOrdenaColunas;
end;

procedure TfrmConfigExpedicao.btnDownOrdClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemRegistros(False);
  pOrdenaColunas;
end;

procedure TfrmConfigExpedicao.btnLeftClick(Sender: TObject);
begin
  inherited;
  if not cdsColOrd.isEmpty then
  Begin
    cdsColOrd.Delete;
    pOrdenaColunas;
  End;
end;

procedure TfrmConfigExpedicao.pOrdenaColunas;
var cdsOrd, cdsBkp: TUniClientDataSet;
    strFields: String;
    strDescFields: String;
    strBookMark : TBookMark;
begin
  Try
    cdsOrd := TUniClientDataSet( frmFatExpedicao.dbgPedidos.DataSource.DataSet );

    cdsBkp := TUniClientDataSet.Create(Self);
    cdsBkp.Data := cdsOrd.data;

    cdsOrd.IndexDefs.Clear;
    cdsOrd.IndexName := '';
    cdsOrd.StoreDefs := False;
    cdsOrd.IndexFieldNames := '';

    if not cdsColOrd.isEmpty then
    Begin
      With cdsColOrd do
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

procedure TfrmConfigExpedicao.pPrepararFormularioParaFiltrarVendedor;
var
  stlComponentes: TStrings;
begin
  pCriarFormularios(TfrmFatExpedicaoBusca, FfrmFatExpedicaoBuscaFiltroVendedor);

  FfrmFatExpedicaoBuscaFiltroVendedor.UsarTelaParaDefinirFiltroVendedor  := True;

  FfrmFatExpedicaoBuscaFiltroVendedor.WindowState       := wsNormal;
  FfrmFatExpedicaoBuscaFiltroVendedor.Position          := poDefaultPosOnly;
  FfrmFatExpedicaoBuscaFiltroVendedor.Parent            := tsFiltroVendedor;
  FfrmFatExpedicaoBuscaFiltroVendedor.Width             := tsFiltroVendedor.Width;
  FfrmFatExpedicaoBuscaFiltroVendedor.Height            := tsFiltroVendedor.Height;
  FfrmFatExpedicaoBuscaFiltroVendedor.align             := AlClient;
  FfrmFatExpedicaoBuscaFiltroVendedor.pnlBotoes.Visible := False;
  FfrmFatExpedicaoBuscaFiltroVendedor.Color             := clBtnFace;
  FfrmFatExpedicaoBuscaFiltroVendedor.pnlLoteSep.Color  := clBtnFace;
  FfrmFatExpedicaoBuscaFiltroVendedor.pnlLocFis.Color   := clBtnFace;
  FfrmFatExpedicaoBuscaFiltroVendedor.BorderStyle       := bsNone;
  FfrmFatExpedicaoBuscaFiltroVendedor.pnlStatus.Visible := False;
  FfrmFatExpedicaoBuscaFiltroVendedor.arrVendedor       := arrVendedor;
  FfrmFatExpedicaoBuscaFiltroVendedor.arrDepVen         := arrDepVen;

  stlComponentes := TStringList.Create;
  Try
    stlComponentes.Add(FfrmFatExpedicaoBuscaFiltroVendedor.edtCodVen.Name);
    stlComponentes.Add(FfrmFatExpedicaoBuscaFiltroVendedor.edtCodDep.Name);

    TCfgSugExp.pRemoverEventoControls(FfrmFatExpedicaoBuscaFiltroVendedor.pnlGeral,
      stlComponentes);
    TCfgSugExp.pRemoverEventoControls(FfrmFatExpedicaoBuscaFiltroVendedor.pnlLoteSep,
      stlComponentes);

    stlComponentes.Add(FfrmFatExpedicaoBuscaFiltroVendedor.lblVendedor.Name);
    stlComponentes.Add(FfrmFatExpedicaoBuscaFiltroVendedor.lblDeptoVendedor.Name);
    stlComponentes.Add(FfrmFatExpedicaoBuscaFiltroVendedor.edtNomVen.Name);
    stlComponentes.Add(FfrmFatExpedicaoBuscaFiltroVendedor.edtNomDep.Name);

    TCfgSugExp.pDesabilitaTodosComponentesExcetoArrayControl(
      FfrmFatExpedicaoBuscaFiltroVendedor, stlComponentes, True);
  Finally
    FreeAndNil(stlComponentes);
  End;

  FfrmFatExpedicaoBuscaFiltroVendedor.Show;
end;

procedure TfrmConfigExpedicao.pPrepararFormularioParaSugestaoDoFoco;
begin
  pCriarFormularios(TfrmFatExpedicaoBusca, FfrmFatExpedicaoBusca);

  FfrmFatExpedicaoBusca.UsarTelaParaDefinirFoco  := True;

  FfrmFatExpedicaoBusca.WindowState       := wsNormal;
  FfrmFatExpedicaoBusca.Position          := poDefaultPosOnly;
  FfrmFatExpedicaoBusca.Parent            := tsCampoParaFoco;
  FfrmFatExpedicaoBusca.Width             := tsCampoParaFoco.Width;
  FfrmFatExpedicaoBusca.Height            := tsCampoParaFoco.Height;
  FfrmFatExpedicaoBusca.align             := AlClient;
  FfrmFatExpedicaoBusca.pnlBotoes.Visible := False;
  FfrmFatExpedicaoBusca.Color             := clBtnFace;
  FfrmFatExpedicaoBusca.pnlLoteSep.Color  := clBtnFace;
  FfrmFatExpedicaoBusca.pnlLocFis.Color   := clBtnFace;
  FfrmFatExpedicaoBusca.BorderStyle       := bsNone;

  TCfgSugExp.pRemoverEventoControls(FfrmFatExpedicaoBusca.pnlGeral);
  TCfgSugExp.pRemoverEventoControls(FfrmFatExpedicaoBusca.pnlLoteSep);

  TCfgSugExp.pDefinirDescricaoDefaultNosFiltros(FfrmFatExpedicaoBusca.pnlGeral);
  TCfgSugExp.pDefinirDescricaoDefaultNosFiltros(FfrmFatExpedicaoBusca.pnlLoteSep);

  FfrmFatExpedicaoBusca.Show;
end;

procedure TfrmConfigExpedicao.pRestauraConfigOcultaInfo;
begin
  chkOcultPed.Checked := False;
  chkOcultInf.Checked := False;
  chkOcultFer.Checked := False;
  objConfigOcultInfo.pRestauraPadrao;
  objConfigOcultInfo.pCarregaConfiguracao;
end;

procedure TfrmConfigExpedicao.pRestaurarCoresGrid;
begin
  fExecutaSQL(
    ' replace into GRDCOR (GRD_FORMUL, GRD_GRID__, GRD_IDENTI, GRD_COR___) values' +
    ' ("frmFatExpedicao","dbgPedidos","SepNaoImp", "clBlack"),' +
    ' ("frmFatExpedicao","dbgPedidos","SepImp", "clBlue"),' +
    ' ("frmFatExpedicao","dbgPedidos","AltSepImp", "clRed"),' +
    ' ("frmFatExpedicao","dbgPedidos","DocDev", "$000080FF"),' +
    ' ("frmFatExpedicao","dbgPedidos","SepReimp", "clGreen"),' +
    ' ("frmFatExpedicao","dbgPedidos","LibSep", "clGray"),' +
    ' ("frmFatExpedicao","dbgPedidos","IteExp", "clPurple"),' +
    ' ("frmFatExpedicao","dbgPedidos","TotExp", "$00FF8000"),' +
    ' ("frmFatExpedicao","dbgPedidos","Garantia", "$00FF8000"),' +
    ' ("frmFatExpedicao","dbgPedidos","DocSel", "clAqua"),' +
    ' ("frmFatExpedicao","dbgPedidos","Urgente", "clRed"),' +
    ' ("frmFatExpedicao","dbgPedidos","OrdPro", "clBlue"),' +
    ' ("frmFatExpedicao","dbgPedidos","OrdProPendente", "clRed"),' +
    ' ("frmFatExpedicao","dbgPedidos","VenEmp", "clLime"),' +
    ' ("frmFatExpedicao","dbgPedidos","VenOutEmp", "clYellow")');

  pCarregaCoresGrid;
end;

procedure TfrmConfigExpedicao.btnUpClick(Sender: TObject);
begin
  inherited;
  pAlteraOrdemColuna(True);
  pIndexarColunasVisiveis;
end;

procedure TfrmConfigExpedicao.cdsColOrdAfterPost(DataSet: TDataSet);
begin
  inherited;
  if blnColOrd then
  Begin
    pOrdenaColunas;
    blnColOrd := False;
  End;
end;

procedure TfrmConfigExpedicao.cxgColunasTableView1EXIBIRPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  pVisibilidadeColuna;
end;

procedure TfrmConfigExpedicao.cxGridDBColumn3PropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  if cdsColOrd.State = dsEdit then
  begin
    blnColOrd := True;
    cdsColOrd.Post;
  End;
end;

procedure TfrmConfigExpedicao.dbgVisExpColumnMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
begin
  inherited;
  pAjustaColunasDeExibicao;
end;

procedure TfrmConfigExpedicao.dbgVisExpDrawColumnCell(Sender: TObject;
  const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  If Not blnFinalizouFormShow Then
    Exit;

  gagAreGrid.Progress := fGetWidthGrid;
  frmFatExpedicao.pDrawColumnCell(dbgVisExp, Column, Rect);
end;

function TfrmConfigExpedicao.fGetWidthGrid: Integer;
  Var
    intCnt : Integer;
begin
  Result := 0;
  For intCnt := 0 To dbgVisExp.Columns.Count-1 Do
  Begin
    If (dbgVisExp.Columns[intCnt].Visible) Then
      Result := Result + dbgVisExp.Columns[intCnt].Width;
  End;
end;

procedure TfrmConfigExpedicao.FormCreate(Sender: TObject);
begin
  inherited;
  blnColOrd := False;
  blnFinalizouFormShow := False;
  blnFecharForm := False;
  blnConfirma := False;
  cdsColExi.CreateDataSet;
  cdsColExi.IndexFieldNames := 'ORDCAM';

  cdsColOrd.CreateDataSet;
  cdsColOrd.IndexFieldNames := 'ORDCAM';

  pCriarFormularios(TfrmFatExpedicao, frmFatExp);
  frmFatExp.pnlFiltros.Parent := tbsSugestao;
  frmFatExp.lblExibirFiltroStatusPedidos.Visible := False;
  TCfgSugExp.pRemoverEventoControls(frmFatExp.pnlFiltros);
  pCarregaOrdExp;

  objConfigOcultInfo := TOcultInfo.Create;
  chkOcultPed.Visible := fCfgSis('EXISTA', varBoolean);

  speTamanhoFonteConfigExpedicao.Value := TCfgSugExp.fCarregaTAmanhoFonte('speTamanhoFonteConfigExpedicao');
  if cxgColunas.Font.Size <= 0 then
  begin
    speTamanhoFonteConfigExpedicao.Value := 8;
  end;

  pPrepararFormularioParaSugestaoDoFoco;
  WindowState := wsMaximized;

  crSequenciaCor.Visible := fCfgSis('EXOCOR', varBoolean);
end;

procedure TfrmConfigExpedicao.FormDestroy(Sender: TObject);
begin
  pFreeAndNil(frmFatExp);
  FreeAndNil(objConfigOcultInfo);

  if Assigned(FCorGrid) then
    FreeAndNil(FCorGrid);
  inherited;
end;

procedure TfrmConfigExpedicao.FormPaint(Sender: TObject);
begin
  inherited;
  If blnFecharForm Then
    Close;
end;

procedure TfrmConfigExpedicao.FormShow(Sender: TObject);
begin
  inherited;
  frmFatExp.grbLocSep.Visible := frmFatExpedicao.grbLocSep.Visible;
  frmFatExp.grbLocRet.Visible := frmFatExpedicao.grbLocRet.Visible;

  objConfigOcultInfo.pCarregaConfiguracao;
  chkOcultInf.Checked := objConfigOcultInfo.OcultPnlInf;
  chkOcultPed.Checked := objConfigOcultInfo.OcultStaPed;
  chkOcultFer.Checked := objConfigOcultInfo.OcultFerMun;

  If (Not Assigned(frmFatExpedicao)) Then
  Begin
    fMensagem('ATENÇÃO!', 'A configuração da expedição deve ser chamada sempre através da tela de expedição!', ['&OK']);
    blnFecharForm := True;
  End
  Else
  Begin
    If fVerificaAcessoSistema('EXBCEX') Then
      pgcCfgExp.ActivePageIndex := 0
    Else
      pgcCfgExp.ActivePageIndex := 2;

    dtsVisExp.DataSet := frmFatExpedicao.dbgPedidos.DataSource.DataSet;
    pIniciarDados;
    blnFinalizouFormShow := True;
  End;
end;

function TfrmConfigExpedicao.fRetornaMultiplosCodigos(arrValores: TConsultasArray): String;
var
  intContador: Integer;
  strCodigos: String;
begin
  Result := EmptyStr;

  if not Assigned(FfrmFatExpedicaoBuscaFiltroVendedor) then
    Exit;

  if length(arrValores) < 2 then
    Exit;

  strCodigos := EmptyStr;

  for intContador := 0 to length(arrValores) - 1 do
  begin
    if not fEmptyStr(strCodigos) then
      strCodigos := strCodigos + ';';

    strCodigos := strCodigos + arrValores[intContador].strCodigo;
  end;

  if not fEmptyStr(strCodigos) then
    Result := Concat('[',strCodigos, ']');
end;

function TfrmConfigExpedicao.fVerificaSequencia: Boolean;
  Var
    stlSequencia : TStringList;
    intCnt1, intCnt2, intCount : Integer;
begin
  Result := True;
  stlSequencia := TStringList.Create;
  try
    stlSequencia.Add(ccbSeqSepNaoImp.Properties.Value);
    stlSequencia.Add(ccbSeqSepImp.Properties.Value);
    stlSequencia.Add(ccbSeqAltSepImp.Properties.Value);
    stlSequencia.Add(ccbSeqDocDev.Properties.Value);
    stlSequencia.Add(ccbSeqSepReimp.Properties.Value);
    stlSequencia.Add(ccbSeqLibSep.Properties.Value);
    stlSequencia.Add(ccbSeqIteExp.Properties.Value);
    stlSequencia.Add(ccbSeqTotExp.Properties.Value);

    for intCnt1 := 0 to stlSequencia.Count-1 do
    begin
      intCount := 0;

      if (StrToIntDef(stlSequencia[intCnt1], 0) > 8) or (StrToIntDef(stlSequencia[intCnt1], 0) < 1) then
      begin
        fMensagem('ATENÇÃO!', 'Verifique a sequência da cor!' + #10+#13 + 'O valor da sequência deve ser entre 1 e 8!', ['&OK']);
        Result := False;
        Exit;
      end;

      for intCnt2 := 0 to stlSequencia.Count-1 do
      begin
        if (stlSequencia[intCnt1] = stlSequencia[intCnt2]) then
          intCount := intCount + 1;
      end;

      if (intCount > 1) then
      begin
        fMensagem('ATENÇÃO!', 'Verifique a sequência da cor!' + #10+#13 + 'Há dois itens com o mesmo valor de sequência!', ['&OK']);
        Result := False;
        Exit;
      end;
    end;
  finally
    FreeAndNil(stlSequencia);
  end;
end;

procedure TfrmConfigExpedicao.pIniciarDados;
  Var
    intCnt : Integer;
    recColExp : TrecColExp;
begin
  pPrepararFormularioParaFiltrarVendedor;

  dtsVisExp.DataSet.DisableControls;
  Try
    For intCnt := Low(TCfgColExp.arrColsOri) To High(TCfgColExp.arrColsOri) Do
    Begin
      recColExp := TCfgColExp.arrColsOri[intCnt];
      pAdicionarColunaExibicaoEOrdem(recColExp);
      pAdicionarColunaPreVisualizacao(intCnt, recColExp);
    End;

    TCfgColExp.pSetarUltimosDadosCarregados(dbgVisExp);

    pAjustaColunasDeExibicao;

    cdsColExi.First;
    gagAreGrid.MaxValue := TCfgColExp.intMaxWidthGrid;

    TCfgSugExp.pCarregarSugestoes(frmFatExp.pnlFiltros);

    pCarregaCoresGrid;
  Finally
    dtsVisExp.DataSet.EnableControls;
  End;
end;

procedure TfrmConfigExpedicao.pVisibilidadeColuna;
  Var
    Column : TColumn;
begin
  inherited;
  If (Not fEmptyStr(cdsColExi.FieldByName('COLNAM').AsString)) Then
  Begin
    Column := fFindColumnByName(dbgVisExp, cdsColExi.FieldByName('COLNAM').AsString);

    If (Column <> Nil) Then
      Column.Visible := (cdsColExi.FieldByName('EXIBIR').AsString = 'S');
  End;
end;

procedure TfrmConfigExpedicao.speTamanhoFonteConfigExpedicaoChange(
  Sender: TObject);
begin
  inherited;
  if speTamanhoFonteConfigExpedicao.Value <= 0 then
  begin
    speTamanhoFonteConfigExpedicao.Value := 1;
  end;

  cxgColunas.Font.Size := speTamanhoFonteConfigExpedicao.Value;
  cxgColunasOrdenacao.Font.Size    := speTamanhoFonteConfigExpedicao.Value;
  dbgVisExp.Font.Size  := speTamanhoFonteConfigExpedicao.Value;
end;

procedure TfrmConfigExpedicao.tsFiltroVendedorShow(Sender: TObject);
begin
  inherited;
  If Assigned(FfrmFatExpedicaoBuscaFiltroVendedor) Then
    pSetFocus(FfrmFatExpedicaoBuscaFiltroVendedor.edtCodVen);
end;

procedure TfrmConfigExpedicao.pAdicionarColunaExibicaoEOrdem(recColExp: TrecColExp);
begin
  cdsColExi.Append;
  cdsColExi.FieldByName('EXIBIR').AsString := IIF(recColExp.blnVisible, 'S', 'N');
  cdsColExi.FieldByName('ORDCAM').AsInteger := recColExp.intIndex + 1;
  cdsColExi.FieldByName('COLCAP').AsString := recColExp.strCaption;
  cdsColExi.FieldByName('COLNAM').AsString := recColExp.strFieldName;
  cdsColExi.Post;
  cdsColExi.First;
end;

procedure TfrmConfigExpedicao.pAdicionarColunaPreVisualizacao(intIndex: Integer; recColExp: TrecColExp);
begin
  dbgVisExp.Columns.Add;
  dbgVisExp.Columns[intIndex].FieldName     := recColExp.strFieldName;
  dbgVisExp.Columns[intIndex].Title.Caption := recColExp.strCaption;
  dbgVisExp.Columns[intIndex].Alignment     := recColExp.Alignment;
  dbgVisExp.Columns[intIndex].Width         := recColExp.intWidth;
  dbgVisExp.Columns[intIndex].Visible       := recColExp.blnVisible;
end;

procedure TfrmConfigExpedicao.pAlteraOrdemColuna(blnSobe: Boolean);
  Var
    strCodAtu: String;
Begin
  If cdsColExi.RecordCount < 2 then
    Exit;

  If (cdsColExi.FieldByName('ORDCAM').AsInteger = 1) And blnSobe then
    Exit;

  If (cdsColExi.FieldByName('ORDCAM').AsInteger = cdsColExi.RecordCount) And (Not blnSobe) then
    Exit;

  cdsColExi.DisableControls;
  Try
    strCodAtu := cdsColExi.FieldByName('COLNAM').AsString;

    If blnSobe Then
    Begin
      cdsColExi.Prior;
      cdsColExi.Edit;
      cdsColExi.FieldByName('ORDCAM').AsInteger := Succ(cdsColExi.FieldByName('ORDCAM').AsInteger);
      cdsColExi.Post;

      If cdsColExi.Locate('COLNAM', strCodAtu, []) Then
      Begin
        cdsColExi.Edit;
        cdsColExi.FieldByName('ORDCAM').AsInteger := Pred(cdsColExi.FieldByName('ORDCAM').AsInteger);
        cdsColExi.Post;
      End;
    End
    Else
    Begin
      cdsColExi.Next;
      cdsColExi.Edit;
      cdsColExi.FieldByName('ORDCAM').AsInteger := Pred(cdsColExi.FieldByName('ORDCAM').AsInteger);
      cdsColExi.Post;

      If cdsColExi.Locate('COLNAM', strCodAtu, []) Then
      Begin
        cdsColExi.Edit;
        cdsColExi.FieldByName('ORDCAM').AsInteger := Succ(cdsColExi.FieldByName('ORDCAM').AsInteger);
        cdsColExi.Post;
      End;
    End;
  Finally
    cdsColExi.EnableControls;
  End;
end;

procedure TfrmConfigExpedicao.pIndexarColunasVisiveis;
  Var
    Column : TColumn;
    intRecNo : Integer;
begin
  cdsColExi.DisableControls;
  intRecNo := cdsColExi.RecNo;
  Try
    cdsColExi.First;
    While Not cdsColExi.Eof Do
    Begin
      Column := fFindColumnByName(dbgVisExp, cdsColExi.FieldByName('COLNAM').AsString);

      If (Column <> Nil) Then
        Column.Index := cdsColExi.FieldByName('ORDCAM').AsInteger - 1;

      cdsColExi.Next;
    End;
    cdsColExi.First;
  Finally
    cdsColExi.RecNo := intRecNo;
    cdsColExi.EnableControls;
  End;
end;

procedure TfrmConfigExpedicao.pMarcarColunasExibicao(blnMarcar: Boolean);
  Var
    intRecNo : Integer;
begin
  With cdsColExi Do
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

        pVisibilidadeColuna;

        Next;
      End;

      First;
    Finally
      RecNo := intRecNo;
      EnableControls;
    End;
  End;
end;

procedure TfrmConfigExpedicao.pAjustaColunasDeExibicao;
  Var
    intCnt : Integer;
    intRecNo : Integer;
begin
  intRecNo := cdsColExi.RecNo;
  cdsColExi.DisableControls;
  Try
    For intCnt := 0 To dbgVisExp.Columns.Count-1 Do
    begin
      If cdsColExi.Locate('COLNAM', dbgVisExp.Columns[intCnt].FieldName, []) Then
      begin
        cdsColExi.Edit;
        cdsColExi.FieldByName('ORDCAM').AsInteger := intCnt + 1;
        cdsColExi.FieldByName('EXIBIR').AsString := IIF(dbgVisExp.Columns[intCnt].Visible, 'S', 'N');
        cdsColExi.Post;
      end;
    end;
  Finally
    cdsColExi.RecNo := intRecNo;
    cdsColExi.EnableControls;
  End;
end;

end.
