unit untLotePrecosEfetivacaoCx;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass, untSalvaConfiguracaoGrid,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView, untCadPro,
  cxGridDBBandedTableView, cxGrid, EditFocus, Vcl.ComCtrls, Vcl.Grids,
  DBGridCitel, DBGrids, untLotePrecos, cxDropDownEdit, cxCurrencyEdit,
  untCfgGrid, untZClient,untILiberacao, untLiberacaoFactory, untMsgLiberacao,
  cxDataControllerConditionalFormattingRulesManagerDialog, untTLock, Uni,
  untGerenciaPropriedadesComponentes, cxTextEdit, untTAvisoAlteracaoPreco,
  cxCalendar, untTypesSistema, untEspelhoNota, untGNRE,
  dxCore, Datasnap.DBClient, UniClientDataSet, cxButtons, untTGridConfigManagerDB;

type
  TfrmLotePrecosEfetivacaoCx = class(TfrmPaiConfirma)
    btnMarcar: TBitBtnLocked;
    btnDesmarcar: TBitBtnLocked;
    pnlHeader: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtCodFor: TEditFocus;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtSerie: TEditFocus;
    edtDtaEnt: TEditFocus;
    edtOpeRes: TEditFocus;
    btnPesLot: TBitBtnLocked;
    pnlTail: TPanel;
    Panel1: TPanel;
    pnlTitPrecos: TPanel;
    pnlLegendas: TPanel;
    dtsPrecos: TDataSource;
    btnPesPed: TBitBtnLocked;
    btnOpcPreVen: TBitBtnLocked;
    btnRecalcMargem: TBitBtnLocked;
    btnMarcarItem: TBitBtnLocked;
    cxgItens: TcxGrid;
    cxbItens: TcxGridDBBandedTableView;
    cxbItensAUTOINCREM: TcxGridDBBandedColumn;
    cxbItensCODITE: TcxGridDBBandedColumn;
    cxbItensColumn2: TcxGridDBBandedColumn;
    cxbItensColumn3: TcxGridDBBandedColumn;
    cxbItensColumn4: TcxGridDBBandedColumn;
    cxbItensColumn5: TcxGridDBBandedColumn;
    cxbItensColumn6: TcxGridDBBandedColumn;
    cxbItensColumn7: TcxGridDBBandedColumn;
    cxbItensITE_UNITAR: TcxGridDBBandedColumn;
    cxbQuantidade: TcxGridDBBandedColumn;
    cxbItensColumn10: TcxGridDBBandedColumn;
    cxbItensLTP_PRECOM: TcxGridDBBandedColumn;
    cxbItensLTP_PRECUS: TcxGridDBBandedColumn;
    cxbItensLTP_MARBR1: TcxGridDBBandedColumn;
    cxbItensLTP_PREVE1: TcxGridDBBandedColumn;
    cxbItensTIPCAL1: TcxGridDBBandedColumn;
    cxbItensLTP_MARBR2: TcxGridDBBandedColumn;
    cxbItensLTP_PREVE2: TcxGridDBBandedColumn;
    cxbItensTIPCAL2: TcxGridDBBandedColumn;
    cxbItensLTP_MARBR3: TcxGridDBBandedColumn;
    cxbItensLTP_PREVE3: TcxGridDBBandedColumn;
    cxbItensTIPCAL3: TcxGridDBBandedColumn;
    cxbItensLTP_MARBR4: TcxGridDBBandedColumn;
    cxbItensLTP_PREVE4: TcxGridDBBandedColumn;
    cxbItensTIPCAL4: TcxGridDBBandedColumn;
    cxbItensLTP_MARBR5: TcxGridDBBandedColumn;
    cxbItensLTP_PREVE5: TcxGridDBBandedColumn;
    cxbItensTIPCAL5: TcxGridDBBandedColumn;
    cxbItensLTP_MARBR6: TcxGridDBBandedColumn;
    cxbItensLTP_PREVE6: TcxGridDBBandedColumn;
    cxbItensTIPCAL6: TcxGridDBBandedColumn;
    cxbItensLTP_MARBR7: TcxGridDBBandedColumn;
    cxbItensLTP_PREVE7: TcxGridDBBandedColumn;
    cxbItensTIPCAL7: TcxGridDBBandedColumn;
    cxbItensLTP_MARBR1_ANT: TcxGridDBBandedColumn;
    cxbItensLTP_MARBR2_ANT: TcxGridDBBandedColumn;
    cxbItensLTP_MARBR3_ANT: TcxGridDBBandedColumn;
    cxbItensLTP_MARBR4_ANT: TcxGridDBBandedColumn;
    cxbItensLTP_MARBR5_ANT: TcxGridDBBandedColumn;
    cxbItensLTP_MARBR6_ANT: TcxGridDBBandedColumn;
    cxbItensLTP_MARBR7_ANT: TcxGridDBBandedColumn;
    cxbItensLTP_PREVE1_ANT: TcxGridDBBandedColumn;
    cxbItensLTP_PREVE2_ANT: TcxGridDBBandedColumn;
    cxbItensLTP_PREVE3_ANT: TcxGridDBBandedColumn;
    cxbItensLTP_PREVE4_ANT: TcxGridDBBandedColumn;
    cxbItensLTP_PREVE5_ANT: TcxGridDBBandedColumn;
    cxbItensLTP_PREVE6_ANT: TcxGridDBBandedColumn;
    cxbItensLTP_PREVE7_ANT: TcxGridDBBandedColumn;
    cxbItensLTP_PRECUS_ANT: TcxGridDBBandedColumn;
    cxbItensDIFCUS: TcxGridDBBandedColumn;
    cxbItensDIFMA1: TcxGridDBBandedColumn;
    cxbItensDIFPR1: TcxGridDBBandedColumn;
    cxbItensDIFMA2: TcxGridDBBandedColumn;
    cxbItensDIFPR2: TcxGridDBBandedColumn;
    cxbItensDIFMA3: TcxGridDBBandedColumn;
    cxbItensDIFPR3: TcxGridDBBandedColumn;
    cxbItensDIFMA4: TcxGridDBBandedColumn;
    cxbItensDIFPR4: TcxGridDBBandedColumn;
    cxbItensDIFMA5: TcxGridDBBandedColumn;
    cxbItensDIFPR5: TcxGridDBBandedColumn;
    cxbItensDIFMA6: TcxGridDBBandedColumn;
    cxbItensDIFPR6: TcxGridDBBandedColumn;
    cxbItensDIFMA7: TcxGridDBBandedColumn;
    cxbItensDIFPR7: TcxGridDBBandedColumn;
    cxbItensColumn8: TcxGridDBBandedColumn;
    cxbItensColumn11: TcxGridDBBandedColumn;
    cxbItensMARID1: TcxGridDBBandedColumn;
    cxbItensPREID1: TcxGridDBBandedColumn;
    cxbItensMARID2: TcxGridDBBandedColumn;
    cxbItensPREID2: TcxGridDBBandedColumn;
    cxbItensMARID3: TcxGridDBBandedColumn;
    cxbItensPREID3: TcxGridDBBandedColumn;
    cxbItensMARID4: TcxGridDBBandedColumn;
    cxbItensPREID4: TcxGridDBBandedColumn;
    cxbItensMARID5: TcxGridDBBandedColumn;
    cxbItensPREID5: TcxGridDBBandedColumn;
    cxbItensMARID6: TcxGridDBBandedColumn;
    cxbItensPREID6: TcxGridDBBandedColumn;
    cxbItensMARID7: TcxGridDBBandedColumn;
    cxbItensPREID7: TcxGridDBBandedColumn;
    cxbItensITEGRU: TcxGridDBBandedColumn;
    cxgItensLevel1: TcxGridLevel;
    btnCfgGri: TcxButton;
    btnCompCusto: TBitBtnLocked;
    cxbItensDESGPR: TcxGridDBBandedColumn;
    cxbItensMAR_DESMAR: TcxGridDBBandedColumn;
    cxbItensDEP_DESCRI: TcxGridDBBandedColumn;
    cxbItensDESABF: TcxGridDBBandedColumn;
    cxbItensVFCPST: TcxGridDBBandedColumn;
    cxbItensVLRFCP: TcxGridDBBandedColumn;
    cxbItensCLAIPI: TcxGridDBBandedColumn;
    cxbItensCLAFIS: TcxGridDBBandedColumn;
    lblCotDol: TLabel;
    edtCotDol: TEditFocus;
    cxbItensPREDOL: TcxGridDBBandedColumn;
    lblCotAnt: TLabel;
    edtCotAnt: TEditFocus;
    Label12: TLabel;
    dtsPrecos2: TDataSource;
    dtsPrecos3: TDataSource;
    edtQtdGrid: TComboBox;
    Panel3: TPanel;
    pgbProgresso: TProgressBar;
    splPrecos: TSplitter;
    ScrollBox1: TScrollBox;
    dbgPrecos: TDBGridCitel;
    pnlSep2: TPanel;
    dbgPrecos3: TDBGridCitel;
    pnlSep1: TPanel;
    dbgPrecos2: TDBGridCitel;
    cxbItensESTRUT: TcxGridDBBandedColumn;
    cxbItensESTRUT_FILHO: TcxGridDBBandedColumn;
    cxbItensITE_ABFPIS: TcxGridDBBandedColumn;
    cxbItensITE_ABFCOF: TcxGridDBBandedColumn;
    cxbItensSALDIS: TcxGridDBBandedColumn;
    cxbItensPREMED: TcxGridDBBandedColumn;
    cxbItensSIT_DESCRI: TcxGridDBBandedColumn;
    cxbItensSIT_CORSIT: TcxGridDBBandedColumn;
    btnMargemLucroGeral: TBitBtnLocked;
    cxbItensIMPULT: TcxGridDBBandedColumn;
    pnlGridItens: TPanel;
    cxbItensNVLGIR: TcxGridDBBandedColumn;
    cxbItensDTAALT: TcxGridDBBandedColumn;
    btnRecalcPreco: TBitBtnLocked;
    btnOpcMargem: TBitBtnLocked;
    btnEspelho: TBitBtnLocked;
    btnCadProduto: TBitBtnLocked;
    lblEmp: TLabel;
    edtCodEmp: TEditFocus;
    cxbItensColumn1: TcxGridDBBandedColumn;
    cxbItensColumn9: TcxGridDBBandedColumn;
    cxbItensColumn12: TcxGridDBBandedColumn;
    cxbItensLTP_RPRENT: TcxGridDBBandedColumn;
    cxbItensITE_APLICA: TcxGridDBBandedColumn;
    btnPromocao: TBitBtnLocked;
    btnRecalcMargIdeal: TBitBtnLocked;
    btnExpProdutos: TBitBtnLocked;
    cxbItensNROITE: TcxGridDBBandedColumn;
    pnlTopo: TPanel;
    btnMarcarPrcRdz: TBitBtnLocked;
    grpCalculoPrecoVenda: TGroupBox;
    cmbPerfil: TComboBox;
    lblPerfilSaida: TLabel;
    lblEstados: TLabel;
    cmbEstado: TComboBox;
    pnlDock: TPanel;
    Label13: TLabel;
    Label11: TLabel;
    lblPromocao: TLabel;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    Shape1: TShape;
    Label8: TLabel;
    Shape2: TShape;
    Shape3: TShape;
    Label14: TLabel;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    edtQtdSel: TEditFocus;
    edtQtdReg: TEditFocus;
    pnlArrMai: TPanel;
    edtDecUni: TEditFocus;
    chkArrMai: TCheckBox;
    btnCarPreMedNaPreCom: TBitBtnLocked;
    cxbItensITE_NIVCRI: TcxGridDBBandedColumn;
    cxButton1: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDesmarcarClick(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
    procedure btnPesLotClick(Sender: TObject);
    procedure cxgItensEnter(Sender: TObject);
    procedure cxgItensExit(Sender: TObject);
    procedure cxbItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgPrecosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgPrecosEnter(Sender: TObject);
    procedure dbgPrecosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxbItensCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnPesPedClick(Sender: TObject);
    procedure btnOpcPreVenClick(Sender: TObject);
    procedure btnOpcMargemClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnRecalcMargemClick(Sender: TObject);
    procedure btnRecalcPrecoClick(Sender: TObject);
    procedure btnMarcarItemClick(Sender: TObject);
    procedure btnCompCustoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtQtdGridChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgPrecos3Exit(Sender: TObject);
    procedure cxbItensKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgPrecosColEnter(Sender: TObject);
    procedure cxbItensLTP_PRECOMPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnMargemLucroGeralClick(Sender: TObject);
    procedure cxbItensDESGPRPropertiesEditValueChanged(Sender: TObject);
    procedure cxbItensEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxbItensEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure btnEspelhoClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnCadProdutoClick(Sender: TObject);
    procedure edtDecUniKeyPress(Sender: TObject; var Key: Char);
    procedure pPercorreGridDePreco(dbGrid: TDBGridCitel);
    procedure chkArrMaiClick(Sender: TObject);
    procedure btnPromocaoClick(Sender: TObject);
    procedure btnRecalcMargIdealClick(Sender: TObject);
    procedure btnExpProdutosClick(Sender: TObject);
    procedure btnMarcarPrcRdzClick(Sender: TObject);
    procedure cmbPerfilChange(Sender: TObject);
    procedure cmbEstadoChange(Sender: TObject);
    procedure btnCarPreMedNaPreComClick(Sender: TObject);
    procedure ConfigurarColunas1Click(Sender: TObject);
    procedure ReiniciarGrid1Click(Sender: TObject);
    procedure cxbItensBandPosChanged(Sender: TcxGridBandedTableView;
      ABand: TcxGridBand);
  private
    { Private declarations }
    strKeyLck: String;
    GridConfigManagerDB: TGridConfigManagerDB;
    GridDefault:  TMemoryStream;
    ControleVisibilidadePorConfiguracao: TControleVisibilidadePorConfiguracao;
    ArrCamposPosicaoOriginal : TArrCamposCfg;

    blnMarNeg,
    blnUTIABR,
    blnATIEMB,
    blnSITPRO: boolean;

    objPreLotes: TLotePrecos;
    objAvisoAlteracaoPreco: TAvisoAlteracaoPreco;
    objLock: TLock;

    objCfgGri: TCfgGrid;
    blnFecharAoConfirmar: Boolean;
    objGerenciaPropriedadesComponentes: TGerenciaPropriedadesComponentes;

    objEspNota : TEspNota;
    objGnreST  : TGnre;
    FblnPedido: Boolean;
    FblnEntradaMercadoria: Boolean;

    qryCadPro: TUniQuery;

    Function fTemMargemNegativa: Boolean;
    Function fGetIndexByText(strBandName: String): integer;
    procedure pSetVisibilidadePorConfiguracao;

    procedure pRetCamposPosicao;

    procedure pFormataDecimais;
    procedure pConfirma;
    procedure pConfirmaBaixa(blnGravaPreIte: Boolean = False; dtaDtaAtu: TDateTime = 0);
    procedure pcdsConsultaAfterScroll(DataSet: TDataSet);
    procedure pMostraComposicaoPrecoCusto(strCodIte: String);
    procedure pAlimentaVisaoSelecionados;
    procedure pIncluiMarNeg(cdsMarNeg: TZClient);


    procedure pLimparTela;
    procedure pCarregaRegistros(blnPedido: Boolean);

    procedure pMostraCotacao;
    function  fSenhaSeItensAlteradoOPreDefinido: Boolean;
    function  fValorUtilizadoDifereteDoDefinido: Boolean;
    function fFormata(AField: TField): String;
    procedure pAddColunaMsg(var objTabela : TRegistroMsgLiberaTabela; var objLinha :TLinhaMsgLibera; AItem: String; ACampo: string; AValorDefinido: String; AValorEntrada: String);
    function fExisteGrupoPreco(strCodGru: String): Boolean;
    procedure pGravaGrupoCadIte(strCodGru, strCodIte: String);
    procedure pAjustaBotaoSair;
    procedure pRecalcularBandas;
    function fGetBanda(AStrCaption: String): TcxGridBand;
    function fGetOrdem(view: TcxGridDBBandedTableView): String;
  public
    strAutoincremGERELE : String;
    strAutoincremMOVGER : String;
    blnFluxoCompra: Boolean;
    procedure pReiniciaGridCfgGrid;
    { Public declarations }
    procedure pSetDocumentoDeEntradaLotePreco(strNumDoc, strEspDoc, strSerie_, strCodFor, strCodOperador: String;  fltCotacao: Double; blnEntradaMercadoria: Boolean = False);
  end;


implementation

{$R *.dfm}

uses  untPai, untFuncoesSimples, untFuncoes, untDllOpeProd, untDllOpeProdFuncoes, System.UITypes,
  untCadProdutosCompCusto, untProdMargemNegativa, untPedeCotacaoMoeda, untLotePrecosMargemLucroGeral,
  cxGridDBDataDefinitions, untConsultas, untFuncIns, untRelEspNotaEnt, untFuncoesRel,
  untEntEtiquetas, System.StrUtils, untGeraExcelHtml;

procedure TfrmLotePrecosEfetivacaoCx.btnMargemLucroGeralClick(Sender: TObject);
var
  frmLotePrecosMargemLucroGeral : TfrmLotePrecosMargemLucroGeral;
begin
  If Pos('S', fCfgSis('TABPRC')) < 0 Then
  Begin
    fMensagem('Atenção', 'Nenhuma tabela de preço selecionada na configuração CFG_TABPRC.', ['&Ok']);
  End
  Else
  If objPreLotes.cdsConsulta.IsEmpty Then
  Begin
    fMensagem('Atenção', 'Não há itens a serem alterados.', ['&Ok']);
  End
  Else
  Begin
    Try
      pCriarFormularios(TfrmLotePrecosMargemLucroGeral, frmLotePrecosMargemLucroGeral);
      frmLotePrecosMargemLucroGeral.objPreLotes := objPreLotes;
      frmLotePrecosMargemLucroGeral.ShowModal;
    Finally
      FreeAndNil(frmLotePrecosMargemLucroGeral);
    End;
  End;
end;

procedure TfrmLotePrecosEfetivacaoCx.pSetVisibilidadePorConfiguracao;
var intIndice: integer;
    cxbBanda : TcxGridBand;
begin
  ControleVisibilidadePorConfiguracao.pInicia;

  For intIndice := 1 To 7 Do
  Begin
    cxbBanda := fGetBanda('Tabela ' + IntToStr(intIndice));
    If Assigned(cxbBanda) Then
    Begin
      cxbBanda.Visible := VS_strTabPrc[intIndice] = 'S';
      if Not cxbBanda.Visible Then
      begin
        cxbBanda.Tag := 66;
        ControleVisibilidadePorConfiguracao.pAddBandaOCultaPorCfg(cxbBanda.Caption);
      end
    End;

    If VS_strTabPrc[intIndice] <> 'S' Then
    Begin
      cxbBanda := fGetBanda('Preço Médio');
      If Assigned(cxbBanda) Then
        cxbBanda.Width := cxbBanda.Width - 140;
    End;
  End;


  btnRecalcMargIdeal.visible := False;
  If fCfgSis('MARIDE', VarBoolean) Then
  Begin
    btnRecalcMargIdeal.visible := True;
    cxbItensMARID1.Visible := VS_strTabPrc[1] = 'S';
    cxbItensPREID1.Visible := VS_strTabPrc[1] = 'S';
    If not cxbItensMARID1.Visible then
    begin
      ControleVisibilidadePorConfiguracao.pAddColunaOCultaPorCfg(cxbItensPREID1.DataBinding.FieldName);
      ControleVisibilidadePorConfiguracao.pAddColunaOCultaPorCfg(cxbItensMARID1.DataBinding.FieldName);
    end;

    cxbItensMARID2.Visible := VS_strTabPrc[2] = 'S';
    cxbItensPREID2.Visible := VS_strTabPrc[2] = 'S';
    If not cxbItensMARID2.Visible then
    begin
      ControleVisibilidadePorConfiguracao.pAddColunaOCultaPorCfg(cxbItensPREID2.DataBinding.FieldName);
      ControleVisibilidadePorConfiguracao.pAddColunaOCultaPorCfg(cxbItensMARID2.DataBinding.FieldName);
    end;

    cxbItensMARID3.Visible := VS_strTabPrc[3] = 'S';
    cxbItensPREID3.Visible := VS_strTabPrc[3] = 'S';
    If not cxbItensMARID3.Visible then
    begin
      ControleVisibilidadePorConfiguracao.pAddColunaOCultaPorCfg(cxbItensPREID3.DataBinding.FieldName);
      ControleVisibilidadePorConfiguracao.pAddColunaOCultaPorCfg(cxbItensMARID2.DataBinding.FieldName);
    end;

    cxbItensMARID4.Visible := VS_strTabPrc[4] = 'S';
    cxbItensPREID4.Visible := VS_strTabPrc[4] = 'S';
    If not cxbItensMARID4.Visible then
    begin
      ControleVisibilidadePorConfiguracao.pAddColunaOCultaPorCfg(cxbItensPREID4.DataBinding.FieldName);
      ControleVisibilidadePorConfiguracao.pAddColunaOCultaPorCfg(cxbItensMARID4.DataBinding.FieldName);
    end;

    cxbItensMARID5.Visible := VS_strTabPrc[5] = 'S';
    cxbItensPREID5.Visible := VS_strTabPrc[5] = 'S';
    If not cxbItensMARID5.Visible then
    begin
      ControleVisibilidadePorConfiguracao.pAddColunaOCultaPorCfg(cxbItensPREID5.DataBinding.FieldName);
      ControleVisibilidadePorConfiguracao.pAddColunaOCultaPorCfg(cxbItensMARID5.DataBinding.FieldName);
    end;

    cxbItensMARID6.Visible := VS_strTabPrc[6] = 'S';
    cxbItensPREID6.Visible := VS_strTabPrc[6] = 'S';
    If not cxbItensMARID6.Visible then
    begin
      ControleVisibilidadePorConfiguracao.pAddColunaOCultaPorCfg(cxbItensPREID6.DataBinding.FieldName);
      ControleVisibilidadePorConfiguracao.pAddColunaOCultaPorCfg(cxbItensMARID6.DataBinding.FieldName);
    end;

    cxbItensMARID7.Visible := VS_strTabPrc[7] = 'S';
    cxbItensPREID7.Visible := VS_strTabPrc[7] = 'S';
    If not cxbItensMARID7.Visible then
    begin
      ControleVisibilidadePorConfiguracao.pAddColunaOCultaPorCfg(cxbItensPREID7.DataBinding.FieldName);
      ControleVisibilidadePorConfiguracao.pAddColunaOCultaPorCfg(cxbItensMARID7.DataBinding.FieldName);
    end;
  End
  Else
  begin
    cxbBanda := fGetBanda('Margem ideal e Preço Ideal');
    If Assigned(cxbBanda) Then
    Begin
      cxbBanda.Visible := False;
      cxbBanda.Tag := 66;
      ControleVisibilidadePorConfiguracao.pAddBandaOCultaPorCfg(cxbBanda.Caption);
    End;
  end;

  cxbItensPREDOL.Visible := fCfgSis('COTDOR', varBoolean);
  If not cxbItensPREDOL.Visible then
     ControleVisibilidadePorConfiguracao.pAddColunaOCultaPorCfg(cxbItensPREDOL.DataBinding.FieldName);


  cxbItensLTP_RPRENT.Visible := (fCfgSis('TPLTPR', varString) = '2');
  If not cxbItensLTP_RPRENT.Visible then
    ControleVisibilidadePorConfiguracao.pAddColunaOCultaPorCfg(cxbItensLTP_RPRENT.DataBinding.FieldName);
  cxbItensSIT_DESCRI.Visible := blnSITPRO;
  cxbItensSIT_CORSIT.Visible := blnSITPRO;
  If not blnSITPRO then
  begin
    ControleVisibilidadePorConfiguracao.pAddColunaOCultaPorCfg(cxbItensSIT_DESCRI.DataBinding.FieldName);
    ControleVisibilidadePorConfiguracao.pAddColunaOCultaPorCfg(cxbItensSIT_CORSIT.DataBinding.FieldName);
  end;


  cxbItensITE_ABFPIS.Visible := blnUTIABR;
  cxbItensITE_ABFCOF.Visible := blnUTIABR;
  If not blnUTIABR then
  begin
    ControleVisibilidadePorConfiguracao.pAddColunaOCultaPorCfg(cxbItensITE_ABFPIS.DataBinding.FieldName);
    ControleVisibilidadePorConfiguracao.pAddColunaOCultaPorCfg(cxbItensITE_ABFCOF.DataBinding.FieldName);
  end;

  For intIndice := 1 To 7 Do
  Begin
    If VS_strTabPrc[intIndice] = 'N' Then
    Begin
      cxbBanda := fGetBanda('Tabela ' + IntToStr(intIndice));
      If Assigned(cxbBanda) Then
      begin
        cxbBanda.Visible := False;
        ControleVisibilidadePorConfiguracao.pAddBandaOCultaPorCfg(cxbBanda.Caption);
      end;
    End;
  End;
end;


procedure TfrmLotePrecosEfetivacaoCx.btnCadProdutoClick(Sender: TObject);
var
  strCodIte: String;
  Key: Word;
begin
  inherited;
  strCodIte := cxbItens.DataController.DataSource.DataSet.FieldByName('ITE_CODITE').AsString;
  Key := VK_INSERT;
  If Not strCodIte.isEmpty Then
    fChamaCadIte(Key, strCodIte)
  Else
    pMensagemOk('Selecione um item para abrir o cadastro');
end;

procedure TfrmLotePrecosEfetivacaoCx.btnCarPreMedNaPreComClick(Sender: TObject);
begin
  inherited;
  objPreLotes.pCarregaPreMedNaPreCom;
end;

procedure TfrmLotePrecosEfetivacaoCx.pRecalcularBandas;
var
  intNumVisiveis,
  X,
  I: Integer;
begin
  For X := 0 To Pred(cxbItens.Bands.Count) Do
  Begin
    intNumVisiveis := 0;
    If cxbItens.Bands[X].Tag = 66 Then
        Continue;

    For I := 0 To Pred(cxbItens.Bands[X].ColumnCount) Do
    Begin
      If cxbItens.Bands[X].Tag = 66 Then
        continue;

      If (cxbItens.Bands[X].Columns[I].Visible) Then
      Begin
        Inc(intNumVisiveis, 1);
        Break;
      End;
    End;

    cxbItens.Bands[X].Visible := intNumVisiveis > 0;
  End;

end;

procedure TfrmLotePrecosEfetivacaoCx.pMostraComposicaoPrecoCusto(strCodIte: String);
Var
    frmCadProdutosCompCusto : TfrmCadProdutosCompCusto;
begin
  Try
    pCriarFormularios(TfrmCadProdutosCompCusto, frmCadProdutosCompCusto);
    frmCadprodutosCompCusto.strCodIte := strCodIte;
    frmCadprodutosCompCusto.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pMostraComposicaoPrecoCusto]');
    End;
  End;
  pFreeAndNil(frmCadprodutosCompCusto);
end;

procedure TfrmLotePrecosEfetivacaoCx.btnCompCustoClick(Sender: TObject);
begin
  inherited;

  If objPreLotes.cdsConsulta.IsEmpty Then
    Exit;

  If fVerificaAcessoSistema('VISCUS', strLoginUsuarioLogado) Then
    pMostraComposicaoPrecoCusto(objPreLotes.cdsConsulta.FieldByName('ITE_CODITE').AsString)
  Else
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);

end;

procedure TfrmLotePrecosEfetivacaoCx.btnConfirmaClick(Sender: TObject);
begin
  pConfirma;

end;

procedure TfrmLotePrecosEfetivacaoCx.btnDesmarcarClick(Sender: TObject);
begin
  inherited;
  objPreLotes.pMarcaTodos(False);
  pAlimentaVisaoSelecionados;
end;

procedure TfrmLotePrecosEfetivacaoCx.btnEspelhoClick(Sender: TObject);
  Var frmRelEspNotaEnt: TfrmRelEspNotaEnt;

begin
  {********************************}
  {* VERIFICA PERMISSÃO DE ACESSO *}
  {*****************************RV*}
  If (Not fVerificaAcessoSistema('ESPNFE', strLoginUsuarioLogado)) Or fEmptyStr(strLoginUsuarioLogado) Then
  Begin
    fMensagem('', 'Usuário sem permissão de acesso!', ['&O k']);
    Exit;
  End;


  Try
    pCriarFormularios(TfrmRelEspNotaEnt, frmRelEspNotaEnt);

    objEspNota := TEspNota.Create(Self);

    frmRelEspNotaEnt.objEspNota := objEspNota;
    frmRelEspNotaEnt.objGnre    := objGnreST;
    frmRelEspNotaEnt.blnEntMer  := False;
    frmRelEspNotaEnt.blnLotPre  := True;

    With objPreLotes Do
    Begin
      frmRelEspNotaEnt.strCodFor  := cdsConsulta.FieldByName('LTP_CODFOR').AsString;
      frmRelEspNotaEnt.strNumDoc  := cdsConsulta.FieldByName('LTP_NUMDOC').AsString;
      frmRelEspNotaEnt.strEspDoc  := cdsConsulta.FieldByName('LTP_ESPDOC').AsString;
      frmRelEspNotaEnt.strSerie   := cdsConsulta.FieldByName('LTP_SERIE_').AsString;
      frmRelEspNotaEnt.strDatIni  := cdsConsulta.FieldByName('LTP_DTAENT').AsString;
      frmRelEspNotaEnt.strDatFim  := cdsConsulta.FieldByName('LTP_DTAENT').AsString;
    End;

    frmRelEspNotaEnt.ShowModal;
    FreeAndNil(frmRelEspNotaEnt);
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TfrmEntDadosFiscaisResumo.btnImpEspelhoClick]');

  End;

end;

procedure TfrmLotePrecosEfetivacaoCx.btnExpProdutosClick(Sender: TObject);
  var geraExcel: TGeraArquivo;
      qryCadEmp: TUniQuery;
      FontFieldValues,
      FontFieldTitle: TFont;
      i: integer;

  procedure pLeEmpresa;
    Var
      strSQL: String;
  Begin
    qryCadEmp := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_NOMEMP, ';
    strSQL := strSQL + '  CONCAT(EMP_ENDERE, ", ", IFNULL(EMP_ENDNUM,""), "  ", IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP)), " - ", EMP_BAIRRO) AS EMP_ENDERE, ';
    strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, "-", CADCID.CID_ESTADO, "   CEP: ", EMP_C_E_P_) AS EMP_NOMCID, ';
    strSQL := strSQL + '  EMP_FONE01, ';
    strSQL := strSQL + '  EMP_F_A_X_, ';
    strSQL := strSQL + '  EMP_EMAIL_ ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP, ';
    strSQL := strSQL + '  CADCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CADEMP.EMP_CODCID = CADCID.CID_CODCID AND ';
    strSQL := strSQL + '  CADEMP.EMP_CODEMP = :CODEMP ';

    With qryCadEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;

  end;

begin
  geraExcel := TGeraArquivo.create(taHtml, objPreLotes.cdsConsulta, pgbProgresso);
  Try
    geraExcel.protegeEstrutura := false;

    geraExcel.pAddTitulo(fRetNomeEmpresa, TGeraArquivo.fSetFont(14, [fsBold]));
    geraExcel.pAddTitulo(fRetFantasiaEmpresa, TGeraArquivo.fSetFont(14, [fsBold]));
    pLeEmpresa;
    geraExcel.pAddTitulo(qryCadEmp.FieldByName('EMP_ENDERE').AsString, TGeraArquivo.fSetFont());
    geraExcel.pAddTitulo(qryCadEmp.FieldByName('EMP_NOMCID').AsString, TGeraArquivo.fSetFont());
    geraExcel.pAddTitulo('Fone.: ' + qryCadEmp.FieldByName('EMP_FONE01').AsString, TGeraArquivo.fSetFont());
    geraExcel.pAddTitulo('Fax..: ' + qryCadEmp.FieldByName('EMP_F_A_X_').AsString, TGeraArquivo.fSetFont());
    geraExcel.pAddTitulo('Email: ' + qryCadEmp.FieldByName('EMP_EMAIL_').AsString, TGeraArquivo.fSetFont());
    geraExcel.pAddTitulo('Lote de Precos, Documento:' + edtNumDoc.Text + '-' + edtEspDoc.Text + '-' + edtSerie.Text, TGeraArquivo.fSetFont(16, [fsBold]));

    FontFieldValues:= TGeraArquivo.fSetFont(10, [], clBlack);
    FontFieldTitle := TGeraArquivo.fSetFont(10, [], clWhite);

    For i := 0 To cxbItens.ColumnCount -1 do
    begin
      If cxbItens.Bands[cxbItens.Columns[i].Position.bandIndex].Visible Then
        If cxbItens.Columns[i].Visible Then
          geraExcel.AddCampo(cxbItens.Columns[i].DataBinding.FieldName,  cxbItens.Columns[i].Caption, FontFieldTitle, FontFieldValues, '', tahtmlUndef);
    End;

    If geraExcel.fGerarRelatorio(True) Then
      pMensagemOk('Arquivo gerado com sucesso!');
  Finally
    FreeAndNil(GeraExcel);
    FreeAndNil(qryCadEmp);
  End;



end;

procedure TfrmLotePrecosEfetivacaoCx.btnMarcarClick(Sender: TObject);
begin
  inherited;

  objPreLotes.pMarcaTodos(True);
  pAlimentaVisaoSelecionados;
end;

function TfrmLotePrecosEfetivacaoCx.fGetOrdem(view: TcxGridDBBandedTableView): String;
  Var
    intCont: Integer;
    strFieldName: String;
    objDataSet: TDataSet;
    objField: TField;
    strNroIte: String;
Begin
  If view.DataController.FocusedRecordIndex = -1 then
    Exit;
  objDataSet := view.DataController.DataSet;
  objDataSet.DisableControls;
  strNroIte := view.DataController.Values[view.DataController.FocusedRecordIndex, cxbItensNROITE.Index];
  If view.SortedItemCount > 0 Then
  Begin
    Result := '';
    For intCont := 0 To view.SortedItemCount - 1 Do
    Begin
      strFieldName := view.SortedItems[intCont].DataBinding.FilterFieldName.Trim.Replace(' ','');
      objField := objDataSet.FindField(strFieldName);
      If objField <> nil Then
        If objField.FieldKind = fkData then
          pOrdenaDataSet(TUniClientDataSet(objDataSet),
            strFieldName,
            IfThen(view.SortedItems[intCont].SortOrder = soDescending, 'DESC'));
    End;
  End;
  objDataSet.Locate('NROITE',strNroIte,[]);
  objDataSet.EnableControls;
end;

procedure TfrmLotePrecosEfetivacaoCx.btnMarcarItemClick(Sender: TObject);
begin
  inherited;
  If cxbItens.DataController.FocusedRecordIndex < 0 Then
   Exit;

  fGetOrdem(cxbItens);
  objPreLotes.pMarcaDesmarca;
  cxbItensCODITE.Width := cxbItensCODITE.Width + 1;
  cxbItensCODITE.Width := cxbItensCODITE.Width - 1;
  pAlimentaVisaoSelecionados;

end;

procedure TfrmLotePrecosEfetivacaoCx.btnMarcarPrcRdzClick(Sender: TObject);
begin
  objPreLotes.pMarcaTodos(True, True);

  If objPreLotes.stlListSelecao.Count = 0 Then
   pMensagemOk('Não há itens que tiveram Preço de Compra reduzido.');

  pAlimentaVisaoSelecionados;
end;

procedure TfrmLotePrecosEfetivacaoCx.btnOpcMargemClick(Sender: TObject);
var
 intRecNo: Integer;
begin
  inherited;
  intRecNo := cxbItens.DataController.DataSource.DataSet.RecNo;

  objPreLotes.fMarcaOpcCalculo(False);

  pSetFocus(cxgItens);
  cxbItens.DataController.DataSource.DataSet.First;
  cxbItens.DataController.DataSource.DataSet.RecNo := intRecNo;
end;

procedure TfrmLotePrecosEfetivacaoCx.btnOpcPreVenClick(Sender: TObject);
var
 intRecNo: Integer;
begin
  inherited;
  intRecNo := cxbItens.DataController.DataSource.DataSet.RecNo;

  If btnOpcPreVen.Enabled Then
    objPreLotes.fMarcaOpcCalculo(True);

  pSetFocus(cxgItens);
  cxbItens.DataController.DataSource.DataSet.First;
  cxbItens.DataController.DataSource.DataSet.RecNo := intRecNo;
end;


procedure TfrmLotePrecosEfetivacaoCx.pAlimentaVisaoSelecionados;
begin
  If objPreLotes.cdsConsulta.Active Then
  Begin
    edtQtdReg.Text := IntToStr(objPreLotes.cdsConsulta.RecordCount);
    edtQtdSel.Text := IntToStr(objPreLotes.stlListSelecao.Count);
  End;
end;


procedure TfrmLotePrecosEfetivacaoCx.pCarregaRegistros(blnPedido: Boolean);
Begin
  With objPreLotes Do
  Begin
    FblnPedido := blnPedido;
    objPreLotes.cdsConsulta.AfterScroll := Nil;

    objPreLotes.FEstado := cmbEstado.Text;
    objPreLotes.FPerfil := Copy(cmbPerfil.Text, 1, 3);

    If Not fAbreConsulta(blnPedido) Then
      Exit;

    If cdsConsulta.IsEmpty Then
      Exit;

    With cdsConsulta Do
    If (FieldByName('LTP_CODEMP').AsString <> VS_strCodEmp) And
       (Pos(FieldByName('LTP_CODEMP').AsString, fRetEmpresasUsamPrecoMatriz) <= 0) Then
    Begin
      pMensagemOk('A Loja ' + FieldByName('LTP_CODEMP').AsString + '-' + fRetNomeEmpresaSelec(FieldByName('LTP_CODEMP').AsString) +
                  ' está configurada para não utilizar preços da matriz. Verifique o cadastro de empresas ou efetive os preços na própria loja.');

      pLimparTela;
    End Else
    Begin
      objLock.pDestravarTodos;

      strKeyLck := 'LOTE_PRECOS_' + cdsConsulta.FieldByName('LTP_NUMDOC').AsString +
                                    cdsConsulta.FieldByName('LTP_CODEMP').AsString +
                                    cdsConsulta.FieldByName('LTP_ESPDOC').AsString +
                                    cdsConsulta.FieldByName('LTP_CODFOR').AsString +
                                    cdsConsulta.FieldByName('LTP_SERIE_').AsString;

      If Not objLock.fLock_Unlock(strKeyLck, True, False) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse documento está sendo utilizado em outra estação: ' + fGetHostLock(strKeyLck + '%'), ['&Ok']);
        pLimparTela;
      End Else
      Begin
        pSetFocus(dbgPrecos);
        pSetFocus(cxgItens);

        edtNumDoc.Text := cdsConsulta.FieldByName('LTP_NUMDOC').AsString;
        edtEspDoc.Text := cdsConsulta.FieldByName('LTP_ESPDOC').AsString;
        edtSerie.Text  := cdsConsulta.FieldByName('LTP_SERIE_').AsString;
        edtCodFor.Text := cdsConsulta.FieldByName('LTP_CODFOR').AsString;
        edtOpeRes.Text := cdsConsulta.FieldByName('LTP_OPERES').AsString;
        edtDtaEnt.Text := cdsConsulta.FieldByName('LTP_DTAENT').AsString;
        edtCodEmp.Text := cdsConsulta.FieldByName('LTP_CODEMP').AsString;

        edtCodFor.Text := edtCodFor.Text  + '-' + fRetNomFornecedor(edtCodFor.Text);
        edtOpeRes.Text := edtOpeRes.Text  + '-' + fRetNomeOperador(edtOpeRes.Text);
      End;
    End;
  End;

  objPreLotes.cdsConsulta.AfterScroll := pcdsConsultaAfterScroll;
  pcdsConsultaAfterScroll(objPreLotes.cdsConsulta);

  {If objCfgGri.blnAjustouColunasVazio Then
  Begin
    cxbItens.ApplyBestFit;

    objCfgGri.blnAjustouColunasVazio := objPreLotes.cdsConsulta.IsEmpty;;
  End;}

  If ScrollBox1.HorzScrollBar.Visible Then
    ScrollBox1.HorzScrollBar.Position := 0;

  If Not FblnEntradaMercadoria Then
  Begin
    fGetOrdem(cxbItens);
    cxbItens.DataController.DataSource.DataSet.First;
  End
  Else If FblnEntradaMercadoria And (cxbItens.DataController.FocusedRecordIndex > 0) Then
  Begin
    fGetOrdem(cxbItens);
    cxbItens.DataController.DataSource.DataSet.First;
  End;
End;

procedure TfrmLotePrecosEfetivacaoCx.pMostraCotacao;
Begin

  With objPreLotes Do
  If fltCotDol > 0 Then
  Begin
    lblCotDol.Visible := True;
    edtCotDol.Visible := True;
    edtCotDol.Text    := FormatFloat(fMskDigitos(4), fltCotDol);

    lblCotAnt.Visible := True;
    edtCotAnt.Visible := True;
    edtCotAnt.Text    := FormatFloat(fMskDigitos(4), fltCotAnt);
  End Else
  Begin
    lblCotDol.Visible := False;
    edtCotDol.Visible := False;
    edtCotDol.Clear;

    lblCotAnt.Visible := False;
    edtCotAnt.Visible := False;
    edtCotAnt.Clear;
  End;

End;

procedure TfrmLotePrecosEfetivacaoCx.btnPesLotClick(Sender: TObject);
begin
  inherited;

  With objPreLotes Do
  If fPesquisarLotes(Self) Then
  Begin
    pCarregaRegistros(False);

    pMostraCotacao;

  End Else
    pLimparTela;

end;

procedure TfrmLotePrecosEfetivacaoCx.btnPesPedClick(Sender: TObject);
begin
  inherited;

  With objPreLotes Do
  If fPesquisarPedidos(Self) Then
  Begin
    pCarregaRegistros(True);
    pMostraCotacao;
  End Else
    pLimparTela;

end;

procedure TfrmLotePrecosEfetivacaoCx.btnPromocaoClick(Sender: TObject);
begin
  inherited;
  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(415, 20279, [],
                        ['DTABAS','CODEMP','CODITE'],
                        [DateToStr(VS_Date), VS_strCodEmp, cxbItens.DataController.DataSource.DataSet.FieldByName('ITE_CODITE').AsString],
                        Sender,
                        nil,
                        True);
  End;
end;

procedure TfrmLotePrecosEfetivacaoCx.btnRecalcMargIdealClick(Sender: TObject);
var intRecNo: Integer;
begin
  inherited;

  If Not btnRecalcMargIdeal.Visible Then
    Exit;

  intRecNo := cxbItens.DataController.DataSource.DataSet.RecNo;

  If fPergunta('Alterar a Margem Bruta de todos os itens com a Margem Ideal?') Then
    objPreLotes.fRecarregaAtual(False, true);

  pSetFocus(cxgItens);
  cxbItens.DataController.DataSource.DataSet.First;
  cxbItens.DataController.DataSource.DataSet.RecNo := intRecNo;

end;

procedure TfrmLotePrecosEfetivacaoCx.btnRecalcMargemClick(Sender: TObject);
var
 intRecNo: Integer;
begin
  inherited;
  intRecNo := cxbItens.DataController.DataSource.DataSet.RecNo;

  fGetOrdem(cxbItens);
  If fPergunta('Confirma a recarga do preço de venda do cadastro e o recálculo da margem para todos os itens?') Then
    objPreLotes.fRecarregaAtual(True);

  pSetFocus(cxgItens);
  cxbItens.DataController.DataSource.DataSet.First;
  cxbItens.DataController.DataSource.DataSet.RecNo := intRecNo;
end;

procedure TfrmLotePrecosEfetivacaoCx.btnRecalcPrecoClick(Sender: TObject);
var
 intRecNo: Integer;
begin
  inherited;

  If Not btnRecalcPreco.Enabled Then
    Exit;

  intRecNo := cxbItens.DataController.DataSource.DataSet.RecNo;

  If fPergunta('Confirma a recarga do margem do cadastro e o recálculo do preço de venda para todos os itens?') Then
    objPreLotes.fRecarregaAtual(False);

  pSetFocus(cxgItens);
  cxbItens.DataController.DataSource.DataSet.First;
  cxbItens.DataController.DataSource.DataSet.RecNo := intRecNo;
end;

procedure TfrmLotePrecosEfetivacaoCx.btnSairClick(Sender: TObject);
begin
  inherited;

  Close;
end;

procedure TfrmLotePrecosEfetivacaoCx.chkArrMaiClick(Sender: TObject);
begin
  inherited;
  If Not(chkArrMai.Checked) Then
    edtDecUni.Text:= '0';
end;

procedure TfrmLotePrecosEfetivacaoCx.cmbEstadoChange(Sender: TObject);
var strAutInc: string;
begin
  inherited;
  if fEmptyStr(cmbEstado.Text) Then
    Exit;
  If objPreLotes.cdsConsulta.IsEmpty Then
    Exit;

  objPreLotes.FEstado := cmbEstado.Text;
  objPreLotes.FPerfil := Copy(cmbPerfil.Text, 1, 3);
  strAutInc := objPreLotes.cdsConsulta.FieldByName('AUTOINCREM').Value;
  objPreLotes.pRecalculaItensPedidoVendaComImpostos;
  If objPreLotes.cdsConsulta.FieldByName('AUTOINCREM').Value <> strAutInc then
    objPreLotes.cdsConsulta.Locate('AUTOINCREM', strAutInc, []);
end;

procedure TfrmLotePrecosEfetivacaoCx.cmbPerfilChange(Sender: TObject);
var strAutInc: string;
begin
  inherited;
  if fEmptyStr(cmbPerfil.Text) Then
    Exit;
  If objPreLotes.cdsConsulta.IsEmpty Then
    Exit;

  objPreLotes.FEstado := cmbEstado.Text;
  objPreLotes.FPerfil := Copy(cmbPerfil.Text, 1, 3);
  strAutInc := objPreLotes.cdsConsulta.FieldByName('AUTOINCREM').Value;
  objPreLotes.pRecalculaItensPedidoVendaComImpostos;
  If objPreLotes.cdsConsulta.FieldByName('AUTOINCREM').Value <> strAutInc then
    objPreLotes.cdsConsulta.Locate('AUTOINCREM', strAutInc, []);
end;

procedure TfrmLotePrecosEfetivacaoCx.ConfigurarColunas1Click(Sender: TObject);
Var index: integer;
begin
  inherited;

  If fVerificaAcessoSistema('GRLTPR', strLoginUsuarioLogado) Then
  begin
    objCfgGri.pConfiguraColunas;
    index:=  fGetIndexByText('Preço Médio');
    if index > -1 then
      cxbItens.Bands[index].Visible := cxbItensPREMED.Visible;
  end
  Else
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
end;

procedure TfrmLotePrecosEfetivacaoCx.cxbItensBandPosChanged(
  Sender: TcxGridBandedTableView; ABand: TcxGridBand);
var posicaoPai: integer;
    ARecCampoCfg: TRecCampoCfg;
    i: integer;
    arrColumns: Array of TcxGridBandedColumn;
    function fLocalizaCampoCfg(ACol: TcxGridBandedColumn) : TRecCampoCfg;
    var lRecCampoCfg: TRecCampoCfg;
    begin
      for lRecCampoCfg in ArrCamposPosicaoOriginal do
        If lRecCampoCfg.Column = ACol then
          Exit(lRecCampoCfg);
    end;
begin
  inherited;
  If Assigned(ABand.ParentBand) then
  begin
    posicaoPai := ABand.ParentBand.Position.ColIndex;
    ABand.Position.BandIndex := -1;
    ABand.Position.ColIndex:= posicaoPai + 1;
    //Realoca os campos
    SetLength(arrColumns, ABand.ColumnCount);
    For i := 0 to ABand.ColumnCount -1 do
      arrColumns[i] := ABand.Columns[i];

    For i := 0 to High(arrColumns) do
    begin
      ARecCampoCfg := fLocalizaCampoCfg(arrColumns[i]);
      arrColumns[i].Position.BandIndex := fGetIndexByText(ARecCampoCfg.Banda.Caption);
    end;

  end;
end;

procedure TfrmLotePrecosEfetivacaoCx.cxbItensCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    blnRed: Boolean;
begin
  inherited;

  blnRed := False;

  If (AViewInfo.Item.Index = cxbItensLTP_PREVE1.Index) Then
    blnRed := fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_PREVE1.Index])) <>
              fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_PREVE1_ANT.Index]))

  Else If AViewInfo.Item.Index = cxbItensLTP_PREVE2.Index Then
    blnRed := fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_PREVE2.Index])) <>
              fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_PREVE2_ANT.Index]))

  Else If AViewInfo.Item.Index = cxbItensLTP_PREVE3.Index Then
    blnRed := fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_PREVE3.Index])) <>
              fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_PREVE3_ANT.Index]))

  Else If AViewInfo.Item.Index = cxbItensLTP_PREVE4.Index Then
    blnRed := fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_PREVE4.Index])) <>
              fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_PREVE4_ANT.Index]))

  Else If AViewInfo.Item.Index = cxbItensLTP_PREVE5.Index Then
    blnRed := fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_PREVE5.Index])) <>
              fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_PREVE5_ANT.Index]))

  Else If AViewInfo.Item.Index = cxbItensLTP_PREVE6.Index Then
    blnRed := fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_PREVE6.Index])) <>
              fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_PREVE6_ANT.Index]))

  Else If AViewInfo.Item.Index = cxbItensLTP_PREVE7.Index Then
    blnRed := fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_PREVE7.Index])) <>
              fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_PREVE7_ANT.Index]))

  Else If AViewInfo.Item.Index = cxbItensLTP_MARBR1.Index Then
    blnRed := fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_MARBR1.Index])) <>
              fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_MARBR1_ANT.Index]))

  Else If AViewInfo.Item.Index = cxbItensLTP_MARBR2.Index Then
    blnRed := fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_MARBR2.Index])) <>
              fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_MARBR2_ANT.Index]))

  Else If AViewInfo.Item.Index = cxbItensLTP_MARBR3.Index Then
    blnRed := fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_MARBR3.Index])) <>
              fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_MARBR3_ANT.Index]))

  Else If AViewInfo.Item.Index = cxbItensLTP_MARBR4.Index Then
    blnRed := fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_MARBR4.Index])) <>
              fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_MARBR4_ANT.Index]))

  Else If AViewInfo.Item.Index = cxbItensLTP_MARBR5.Index Then
    blnRed := fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_MARBR5.Index])) <>
              fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_MARBR5_ANT.Index]))

  Else If AViewInfo.Item.Index = cxbItensLTP_MARBR6.Index Then
    blnRed := fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_MARBR6.Index])) <>
              fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_MARBR6_ANT.Index]))

  Else If AViewInfo.Item.Index = cxbItensLTP_MARBR7.Index Then
    blnRed := fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_MARBR7.Index])) <>
              fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensLTP_MARBR7_ANT.Index]));

  //Item de estrutura
  If fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensESTRUT.Index])) > 0 Then
    ACanvas.Font.Color := clPurple;

  //Item de estrutura
  If fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensESTRUT_FILHO.Index])) > 0 Then
    ACanvas.Font.Color := clPurple;

  If Not fEmptyStr(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensSIT_DESCRI.Index])) Then
    ACanvas.Font.Color  := StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxbItensSIT_CORSIT.Index]),0);

  If blnRed Then
    ACanvas.Brush.Color := clRed

  Else
  With objPreLotes Do
  If (stlListSelecao.IndexOf(QuotedStr(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxbItensAUTOINCREM.Index]))) > -1) Then
  Begin
    ACanvas.Brush.Color := clMoneyGreen;
    If AViewInfo.Selected Then
    Begin
      ACanvas.Font.Color := clBlue;
      ACanvas.Brush.Color := clLime;
    End;
  End;
end;

procedure TfrmLotePrecosEfetivacaoCx.cxbItensDESGPRPropertiesEditValueChanged(
  Sender: TObject);
  Var
    strCodIte: String;
begin
  inherited;
  if fEmptyStr(TcxTextEdit(Sender).Text) then
    exit;

  TcxTextEdit(Sender).Text := fStrZero(TcxTextEdit(Sender).Text, 6);

  If Not fExisteGrupoPreco(fStrZero(TcxTextEdit(Sender).Text, 6)) Then
  Begin
    pMensagemOk('Campo: Gr. Preços não cadastrado!');
    cxbItensDESGPR.Focused:= True;
    TcxTextEdit(Sender).Clear;
    Exit;
  End
  Else
  Begin
     strCodIte:= cxbItens.DataController.DataSource.DataSet.FieldByName('ITE_CODITE').AsString;
     pGravaGrupoCadIte(fStrZero(TcxTextEdit(Sender).Text,6), strCodIte);
  End

end;

procedure TfrmLotePrecosEfetivacaoCx.cxbItensEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  With objPreLotes.cdsConsulta Do
  Begin
   If SameText(TcxGridItemDBDataBinding(AItem.DataBinding).FieldName, 'ITE_DESGPR') Then
    Begin
      if Key = VK_INSERT Then
      Begin
        If State <> dsEdit Then
          Edit;

        FieldByName('ITE_CODGPR').AsString  := untFuncIns.fChamaCadGrupoPrecos(Key);
        FieldByName('ITE_DESGPR').AsString  := fRetNomGrupoPrecos(FieldByName('ITE_CODGPR').AsString);

        Post;
      End;

    End;
  End;
end;

procedure TfrmLotePrecosEfetivacaoCx.cxbItensEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
  Var
    arrGrupoPrecos: TConsultasArray;
begin
  inherited;
  With objPreLotes.cdsConsulta Do
    If SameText(TcxGridItemDBDataBinding(AItem.DataBinding).FieldName, 'ITE_DESGPR') Then
    Begin
    If fEntraCons(key) And fPesqGrupoPrecos(Self, Nil, Nil, Nil, Key, arrGrupoPrecos, False) Then
    Begin
      If State <> dsEdit Then
        Edit;

      FieldByName('ITE_CODGPR').AsString := arrGrupoPrecos[0].strCodigo;
      FieldByName('ITE_DESGPR').AsString := arrGrupoPrecos[0].strDescri;

      Post;

    End;

  End;
end;

procedure TfrmLotePrecosEfetivacaoCx.pGravaGrupoCadIte(strCodGru, strCodIte: String);
  Var
    qryExec : TUniQuery;
Begin

  qryExec := fCriaQuery(Self);
  Try
    qryExec.Close;
    qryExec.SQL.Clear;
    qryExec.SQL.Add(' UPDATE CADITE SET      '+
                    '   ITE_CODGPR = :CODGPR '+
                    ' WHERE ITE_CODITE = :CODITE ');
    qryExec.ParamByName('CODGPR').AsString:= strCodGru;
    qryExec.ParamByName('CODITE').AsString:= strCodIte;

    qryExec.ExecSQL;
  Finally
    FreeAndNil(qryExec);
  End;

End;


function TfrmLotePrecosEfetivacaoCx.fExisteGrupoPreco(strCodGru: String): Boolean;
  Var
    qryCons : TUniQuery;
Begin

  qryCons := fCriaQuery(Self);
  Try
    qryCons.Close;
    qryCons.SQL.Clear;
    qryCons.SQL.Add('SELECT GPR_CODIGO FROM CADGPR WHERE '+
                              ' GPR_CODIGO = :CODIGO AND '+
                              ' GPR_CODEMP = :CODEMP ');

    qryCons.ParamByName('CODIGO').AsString:= strCodGru;
    qryCons.ParamByName('CODEMP').AsString:= VS_strCodEmp;
    qryCons.Open;

    result:= Not(fEmptyStr(qryCons.FieldByName('GPR_CODIGO').AsString));

  Finally
    FreeAndNil(qryCons);
  End;

End;


procedure TfrmLotePrecosEfetivacaoCx.cxbItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F5) Then
    btnMarcarItem.Click;
   //Seta para cima ou para baixo
   If (Key = 38) Or (Key  = 40) Then
     objPreLotes.cdsConsulta.AfterScroll := nil;

  If (Key = VK_RETURN) And
     (Not (cxbItensLTP_MARBR1.Focused Or
           cxbItensLTP_MARBR2.Focused Or
           cxbItensLTP_MARBR3.Focused Or
           cxbItensLTP_MARBR4.Focused Or
           cxbItensLTP_MARBR5.Focused Or
           cxbItensLTP_MARBR6.Focused Or
           cxbItensLTP_MARBR7.Focused Or
           cxbItensLTP_PREVE1.Focused Or
           cxbItensLTP_PREVE2.Focused Or
           cxbItensLTP_PREVE3.Focused Or
           cxbItensLTP_PREVE4.Focused Or
           cxbItensLTP_PREVE5.Focused Or
           cxbItensLTP_PREVE6.Focused Or
           cxbItensLTP_PREVE7.Focused)) Then
    pSetFocus(dbgPrecos);

    If (Key = VK_INSERT) And Not(cxbItensDESGPR.Focused) Then
    Begin
      If btnCadProduto.Visible Then
        btnCadProduto.Click;
    End;
end;

procedure TfrmLotePrecosEfetivacaoCx.cxbItensKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
   If (Key = 38) Or (Key  = 40) Then
   Begin
     objPreLotes.cdsConsulta.AfterScroll := pcdsConsultaAfterScroll;
     pcdsConsultaAfterScroll(objPreLotes.cdsConsulta);
   End;
end;

procedure TfrmLotePrecosEfetivacaoCx.cxbItensLTP_PRECOMPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  objPreLotes.blnAtualizaPrecomUti := True;
end;

procedure TfrmLotePrecosEfetivacaoCx.cxgItensEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'PRESSIONE [ F5 ] PARA MARCAR/DESMARCAR O PRODUTO...';
end;

procedure TfrmLotePrecosEfetivacaoCx.cxgItensExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmLotePrecosEfetivacaoCx.dbgPrecos3Exit(Sender: TObject);
  var dbgUti: TDbGridCitel;
begin
  inherited;

  dbgUti := TDBGridCitel(Sender);
  If dbgUti.DataSource.DataSet.Active Then
    dbgUti.DataSource.DataSet.First;

  If dbgUti.DataSource.DataSet.Active And
    (dbgUti.DataSource.DataSet.FieldByName('TITULO').AsString = 'S') Then
      dbgPrecos.DataSource.DataSet.Next;

end;

procedure TfrmLotePrecosEfetivacaoCx.dbgPrecosColEnter(Sender: TObject);
begin
  inherited;
  if UpperCase(TDBGrid(Sender).SelectedField.FieldName) = 'UTILIZ' then
    TDBGrid(Sender).Options := TDBGrid(Sender).Options - [dgEditing]
  else
    TDBGrid(Sender).Options := TDBGrid(Sender).Options + [dgEditing];
end;

procedure TfrmLotePrecosEfetivacaoCx.dbgPrecosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  var
    DataSet: TDataSet;
    dbgPrecosUti: TDBGridCitel;
    Check: Integer;
    R: TRect;
begin
  inherited;

  DataSet := TDBGridCitel(Sender).DataSource.DataSet;
  dbgPrecosUti := dbgPrecos;
  If (DataSet = objPreLotes.cdsPrecos) Or
     (DataSet = objPreLotes.cdsPrecos1) Then
    dbgPrecosUti := dbgPrecos
  Else If (DataSet = objPreLotes.cdsPrecos2) then
    dbgPrecosUti := dbgPrecos2
  Else If (DataSet = objPreLotes.cdsPrecos3) then
    dbgPrecosUti := dbgPrecos3;

  If DataSet.FieldByName('TITULO').AsString = 'S' Then
  Begin
    dbgPrecosUti.Canvas.Brush.Color := clSilver;
    dbgPrecosUti.Canvas.FillRect(Rect);
    dbgPrecosUti.Canvas.Font.Color := clBlack;

    If Column.FieldName = 'DESCRI' Then
      dbgPrecosUti.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, DataSet.FieldByName('DESCRI').AsString);
  End
  Else if (Column.FieldName = 'CAMALT') And
          ( Not dbgPrecosUti.Focused) Then
  Begin
    dbgPrecosUti.Canvas.Brush.Color := clWhite;
    dbgPrecosUti.Canvas.FillRect(Rect);
    dbgPrecosUti.Canvas.Font.Color := clBlack;
  End;



  If (Column.FieldName = 'CAMALT') Then
  Begin
    If (DataSet.FieldByName('CAMALT').AsString = 'S') Then
      dbgPrecosUti.Canvas.Brush.Color := clRed;

    dbgPrecosUti.Canvas.FillRect(Rect);
  End;

  If TDBGrid(Sender).DataSource.DataSet.FieldByName('CCUSTO').AsBoolean Then
  Begin
    if(UpperCase(Column.FieldName) = 'UTILIZ') then
    begin
      TDBGrid(Sender).Canvas.FillRect(Rect);
      if (TDBGrid(Sender).DataSource.DataSet.FieldByName('UTILIZ').AsInteger = 1) then
        Check := DFCS_CHECKED
      else
        Check := 0;
      R := Rect;
      InflateRect(R, -2, -2);
      DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON,DFCS_BUTTONCHECK or Check);
    end;
  End;

end;

procedure TfrmLotePrecosEfetivacaoCx.dbgPrecosEnter(Sender: TObject);
var dbgUti: TDbGridCitel;
begin
  inherited;

  dbgUti := TDbGridCitel(Sender);
  If dbgUti.DataSource.DataSet.Active Then
    dbgUti.DataSource.DataSet.First;

  If dbgUti.DataSource.DataSet.Active And
    (dbgUti.DataSource.DataSet.FieldByName('TITULO').AsString = 'S') Then
      dbgPrecos.DataSource.DataSet.Next;

end;

procedure TfrmLotePrecosEfetivacaoCx.dbgPrecosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  var
    dbgUti: TDbGridCitel;
    strAutInc: String;
    intRecNoCns: Integer;
begin
  inherited;

  Case Key Of
    VK_RETURN: Begin

                 if objPreLotes.cdsConsulta.recordcount > 0 then
                 Begin
                   objPreLotes.cdsConsulta.AfterScroll := Nil;

                   If (chkArrMai.Checked) And fEmptyStr(edtDecUni.Text) Then
                     edtDecUni.Text:= '0';

                   objPreLotes.strCasaDecimal:= edtDecUni.Text;

                   objPreLotes.blnArredondaPreco:= chkArrMai.Checked;

                   objPreLotes.blnArredondaPrecoEmLote:= False;

                   strAutInc := objPreLotes.cdsConsulta.FieldByName('AUTOINCREM').Value;

                   intRecNoCns := TDbGridCitel(Sender).DataSource.DataSet.RecNo;
                   Try
                     With objPreLotes Do
                     begin
                       strGrupoPrecoReplica := cdsConsulta.FieldByName('ITE_CODGPR').AsString;
                       pAlterarPrecoMargem(True, cdsConsulta, TDbGridCitel(Sender).DataSource.DataSet, -1, -1, 0, True, 0, False, True);
                     End;
                   Finally
                     objPreLotes.cdsConsulta.AfterScroll := pcdsConsultaAfterScroll;
                     objPreLotes.cdsConsulta.First;
                     If objPreLotes.cdsConsulta.FieldByName('AUTOINCREM').Value <> strAutInc then
                       objPreLotes.cdsConsulta.Locate('AUTOINCREM', strAutInc, []);
                     TDbGridCitel(Sender).DataSource.DataSet.RecNo := intRecNoCns;
                    End;
                 End;
               End;

   VK_DOWN: Begin
              dbgUti := TDbGridCitel(Sender);
              If dbgUti.DataSource.DataSet.RecNo = dbgUti.DataSource.DataSet.RecordCount Then
              Begin
                If (dbgUti = dbgPrecos)And (dbgPrecos2.Visible) Then
                begin
                  If dbgPrecos2.Visible Then
                  Begin
                    pSetFocus(dbgPrecos2);
                    dbgPrecos2.Options := dbgPrecos.Options + [dgAlwaysShowSelection];
                    if (not dbgPrecos2.DataSource.DataSet.Active) then
                      dbgPrecos2.DataSource.DataSet.Open;
                    dbgPrecos2.DataSource.DataSet.First;
                  End;
                End
                Else If (dbgUti = dbgPrecos2) And (dbgPrecos3.Visible) Then
                Begin
                  If dbgPrecos3.Visible Then
                  Begin
                    pSetFocus(dbgPrecos3);
                    dbgPrecos3.Options := dbgPrecos.Options + [dgAlwaysShowSelection];
                    if (not dbgPrecos3.DataSource.DataSet.Active) then
                      dbgPrecos3.DataSource.DataSet.Open;
                    dbgPrecos3.DataSource.DataSet.First;
                  End;
                End
                Else If dbgUti = dbgPrecos3 Then
                Begin
                  pSetFocus(dbgPrecos);
                  if (not dbgPrecos.DataSource.DataSet.Active) then
                    dbgPrecos.DataSource.DataSet.Open;
                  dbgPrecos.DataSource.DataSet.First;
                  dbgPrecos.Options := dbgPrecos.Options + [dgAlwaysShowSelection];

                End;
                dbgUti.Options := dbgPrecos.Options  - [dgAlwaysShowSelection];
              End;
            End;

  VK_SPACE: Begin
              dbgUti := TDbGridCitel(Sender);
              If (dbgUti.DataSource.DataSet.FieldByName('CCUSTO').AsBoolean) And
                 (dbgUti.DataSource.DataSet.FieldByName('VALATU').AsString <> dbgUti.DataSource.DataSet.FieldByName('VALANT').AsString) Then
              begin
                dbgUti.DataSource.DataSet.Edit;
                if(dbgUti.DataSource.DataSet.FieldByName('UTILIZ').AsInteger = 1) then
                   dbgUti.DataSource.DataSet.FieldByName('UTILIZ').AsInteger := 0
                else
                  dbgUti.DataSource.DataSet.FieldByName('UTILIZ').AsInteger := 1;
                dbgUti.DataSource.DataSet.Post;

                If (chkArrMai.Checked) And fEmptyStr(edtDecUni.Text) Then
                  edtDecUni.Text:= '0';

                objPreLotes.strCasaDecimal:= edtDecUni.Text;

                objPreLotes.blnArredondaPreco:= chkArrMai.Checked;

                objPreLotes.blnArredondaPrecoEmLote:= False;

                intRecNoCns := objPreLotes.cdsConsulta.RecNo;

                 With objPreLotes Do
                 Begin
                   strGrupoPrecoReplica := cdsConsulta.FieldByName('ITE_CODGPR').AsString;
                   pAlterarPrecoMargem(True, cdsConsulta, TDbGridCitel(Sender).DataSource.DataSet,
                                       dbgUti.DataSource.DataSet.FieldByName('UTILIZ').AsInteger,
                                       StrToFloat(StringReplace(
                                       IIf(dbgUti.DataSource.DataSet.FieldByName('UTILIZ').AsInteger = 1,
                                       dbgUti.DataSource.DataSet.FieldByName('VALATU').AsString,
                                       dbgUti.DataSource.DataSet.FieldByName('VALANT').AsString), '.', '', [])),
                                       StrToFloat(StringReplace(dbgUti.DataSource.DataSet.FieldByName('VALATU').AsString, '.', '', [])));
                End;

                objPreLotes.cdsConsulta.RecNo := intRecNoCns;

              end;
            End;

     Vk_UP: Begin
              dbgUti := TDbGridCitel(Sender);
              If dbgUti.DataSource.DataSet.RecNo = 1 Then
              Begin
                If dbgUti = dbgPrecos3 Then
                begin
                  If dbgPrecos2.Visible Then
                  Begin
                    pSetFocus(dbgPrecos2);
                    if (not dbgPrecos2.DataSource.DataSet.Active) then
                      dbgPrecos2.DataSource.DataSet.Open;
                    dbgPrecos2.DataSource.DataSet.Last;
                    dbgPrecos2.Options := dbgPrecos.Options + [dgAlwaysShowSelection];
                  End;

                End
                Else If dbgUti = dbgPrecos2 Then
                begin
                  pSetFocus(dbgPrecos);
                  if (not dbgPrecos.DataSource.DataSet.Active) then
                    dbgPrecos.DataSource.DataSet.Open;
                  dbgPrecos.DataSource.DataSet.Last;
                  dbgPrecos.Options := dbgPrecos.Options + [dgAlwaysShowSelection];
                End
                Else If dbgUti = dbgPrecos Then
                Begin
                  If dbgPrecos3.Visible Then
                  Begin
                    pSetFocus(dbgPrecos3);
                    if (not dbgPrecos3.DataSource.DataSet.Active) then
                      dbgPrecos3.DataSource.DataSet.Open;
                    dbgPrecos3.DataSource.DataSet.Last;
                    dbgPrecos3.Options := dbgPrecos.Options + [dgAlwaysShowSelection];
                  End;
                End;
                dbgUti.Options := dbgPrecos.Options  - [dgRowLines];
              End;
            End;
    VK_F5: Begin
             If (Not (ssAlt in Shift)) Then
               btnMarcarItem.Click;
           End;
  End;

end;

procedure TfrmLotePrecosEfetivacaoCx.edtDecUniKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Key = #13 Then
  Begin

    If chkArrMai.Checked Then
    Begin
      If (chkArrMai.Checked) And fEmptyStr(edtDecUni.Text) Then
        edtDecUni.Text:= '0';

      objPreLotes.strCasaDecimal:= edtDecUni.Text;

      objPreLotes.blnArredondaPreco:= chkArrMai.Checked;

      objPreLotes.blnArredondaPrecoEmLote:= True;

      If fPergunta('Deseja realmente arredondar o valor do preço de venda?') Then
      Begin
        pPercorreGridDePreco(dbgPrecos);
        pPercorreGridDePreco(dbgPrecos2);
        pPercorreGridDePreco(dbgPrecos3);
      End;

    End
  End;

end;

procedure TfrmLotePrecosEfetivacaoCx.pPercorreGridDePreco(dbGrid: TDBGridCitel);
Var
  strCamAlt: String;
  intRecNoCns: Integer;
Begin

  If dbGrid.Visible Then
  Begin

    intRecNoCns := objPreLotes.cdsConsulta.RecNo;
    dbGrid.DataSource.DataSet.First;
    objPreLotes.cdsConsulta.AfterScroll := Nil;
    strCamAlt := '';
    While Not (dbGrid.DataSource.DataSet.Eof) do
    Begin

      strCamAlt := Copy(dbGrid.DataSource.DataSet.FieldByName('NOMCAM').AsString, 5, 10);

      If (Not fEmptyStr(strCamAlt)) And
         (AnsiStartsStr('PREVE', strCamAlt)) Then
      Begin
        objPreLotes.strGrupoPrecoReplica := objPreLotes.cdsConsulta.FieldByName('ITE_CODGPR').AsString;
        objPreLotes.pAlterarPrecoMargem(True, objPreLotes.cdsConsulta, dbGrid.DataSource.DataSet);
      End;

      dbGrid.DataSource.DataSet.Next;
    End;

   objPreLotes.cdsConsulta.AfterScroll := pcdsConsultaAfterScroll;
   objPreLotes.cdsConsulta.RecNo := intRecNoCns;

  End;

End;

procedure TfrmLotePrecosEfetivacaoCx.edtQtdGridChange(Sender: TObject);
begin
  inherited;
  case edtQtdGrid.ItemIndex + 1 of
    1: Begin
         dtsPrecos.DataSet  := objPreLotes.cdsPrecos;
         dbgPrecos2.Visible := False;
         dbgPrecos3.Visible := False;
       End;

    2: begin
        dtsPrecos.DataSet  := objPreLotes.cdsPrecos1;
        dtsPrecos2.DataSet := objPreLotes.cdsPrecos2;
        dbgPrecos2.Visible := True;
        dbgPrecos3.Visible := False;
       End;
    3: begin
         dtsPrecos.DataSet  := objPreLotes.cdsPrecos1;
         dtsPrecos2.DataSet := objPreLotes.cdsPrecos2;
         dtsPrecos3.DataSet := objPreLotes.cdsPrecos3;
         dbgPrecos2.Visible := True;
         dbgPrecos3.Visible := True;
       End;
    Else
    Begin
      dtsPrecos.DataSet  := objPreLotes.cdsPrecos;
      dbgPrecos2.Visible := False;
      dbgPrecos3.Visible := False;
    End;
  end;

  objPreLotes.intQtdGrid := edtQtdGrid.ItemIndex + 1;

end;

Procedure TfrmLotePrecosEfetivacaoCx.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (Not objPreLotes.cdsConsulta.IsEmpty) And (Not fPergunta('Deseja abandonar a tarefa?')) Then
  Begin
    Action := caNone;
    Exit;
  End;

  FreeAndNil(objLock);
  GridConfigManagerDB.SaveConfig(cxbItens, Self.Name);
  TSalvaConfiguracaoGrid.pSalvaConfiguracoesGrid(cxbItens, Self.Name);
end;


procedure TfrmLotePrecosEfetivacaoCx.FormCreate(Sender: TObject);
var index : integer;
    FForcaApplyBestFit: Boolean;
begin
  inherited;
  GridDefault := TMemoryStream.Create;
  cxbItens.StoreToStream(GridDefault, []);
  cmbEstado.Text := fCadEmp('ESTADO');
  grpCalculoPrecoVenda.Visible := fCfgSis('ALTCVI', varBoolean);
  FblnEntradaMercadoria := False;
  blnFluxoCompra := false;
  objGerenciaPropriedadesComponentes := TGerenciaPropriedadesComponentes.Create(Self, Self.Name, strLoginUsuarioLogado);
  blnUTIABR := fCfgSis('UTIABR', varBoolean);

  objGerenciaPropriedadesComponentes.pAddComponente(pnlTail);
  objGerenciaPropriedadesComponentes.pAddComponente(cmbPerfil);
  objGerenciaPropriedadesComponentes.pAddComponente(cmbEstado);
  objGerenciaPropriedadesComponentes.pAddComponente(edtQtdGrid);

  objGerenciaPropriedadesComponentes.pCarregar(False);


  blnFecharAoConfirmar := False;
  blnMarNeg := fCfgSis('MARNEG', varBoolean);
  blnSITPRO := fCfgSis('SITPRO', varBoolean);

  objPreLotes := TLotePrecos.Create(Self);
  cxbItens.BeginUpdate;
  Try
    cxbItens.DataController.DataSource := objPreLotes.cdsConsulta.dtsSource;
    objPreLotes.cdsConsulta.AfterOpen := objPreLotes.pAfterOpenLotePrecos;
    objPreLotes.cdsConsulta.AfterScroll := pcdsConsultaAfterScroll;
    objLock := TLock.Create;

    dtsPrecos.DataSet := objPreLotes.cdsPrecos;
    dtsPrecos.DataSet  := objPreLotes.cdsPrecos1;
    dtsPrecos2.DataSet := objPreLotes.cdsPrecos2;
    dtsPrecos3.DataSet := objPreLotes.cdsPrecos3;

    qryCadPro := fCriarQuery('SELECT * FROM CADPRO WHERE FALSE', Self);

    objAvisoAlteracaoPreco := TAvisoAlteracaoPreco.Create;

    strAutoincremGERELE := '';
    strAutoincremMOVGER := '';

    pFormataDecimais;

    objPreLotes.fAbreConsulta(False);

    pRetCamposPosicao;

    GridConfigManagerDB := TGridConfigManagerDB.Create('');
    FForcaApplyBestFit := False;
    If not GridConfigManagerDB.LoadConfig(cxbItens, Self.Name) then
      FForcaApplyBestFit := True;

    pSetVisibilidadePorConfiguracao;

    ControleVisibilidadePorConfiguracao.pAddColunasSempreInvisivel(cxbItensESTRUT.DataBinding.FieldName);
    ControleVisibilidadePorConfiguracao.pAddColunasSempreInvisivel(cxbItensESTRUT_FILHO.DataBinding.FieldName);
    objCfgGri := TCfgGrid.Create(Self, cxbItens, 'Ativação de Lote de Preços', True, ControleVisibilidadePorConfiguracao, FForcaApplyBestFit, ArrCamposPosicaoOriginal);


    pLimparTela;

    blnATIEMB := fCfgSis('ATIEMB', varBoolean);
    If Not blnATIEMB Then
    Begin
      dbgPrecos.Width :=  10 + dbgPrecos.Width  - (dbgPrecos.Columns[5].Width + dbgPrecos.Columns[6].Width);
      pnlSep1.Width := 10 + dbgPrecos2.Width - (dbgPrecos2.Columns[5].Width + dbgPrecos2.Columns[6].Width);
      pnlSep2.Width := 10 + dbgPrecos3.Width - (dbgPrecos3.Columns[5].Width + dbgPrecos3.Columns[6].Width);
    end;

    dbgPrecos.Columns[5].Visible := blnATIEMB;
    dbgPrecos.Columns[6].Visible := blnATIEMB;

    dbgPrecos2.Columns[5].Visible := blnATIEMB;
    dbgPrecos2.Columns[6].Visible := blnATIEMB;

    dbgPrecos3.Columns[5].Visible := blnATIEMB;
    dbgPrecos3.Columns[6].Visible := blnATIEMB;


    objCfgGri.pSetaColunas;
    index:=  fGetIndexByText('Preço Médio');
    if index > -1 then
      cxbItens.Bands[index].Visible := cxbItensPREMED.Visible;

    TcxCurrencyEditProperties(cxbQuantidade.Properties).DisplayFormat := fMskDigitos(fCfgSis('DEQTEM', varInteger));
  Finally
    cxbItens.EndUpdate;
  End;

end;

procedure TfrmLotePrecosEfetivacaoCx.FormDestroy(Sender: TObject);
begin
  inherited;
  objGerenciaPropriedadesComponentes.pSalvar;
  FreeAndNil(GridConfigManagerDB);
  FreeAndNil(GridDefault);

  FreeAndNil(objAvisoAlteracaoPreco);
  FreeAndNil(objGerenciaPropriedadesComponentes);
  FreeAndNil(qryCadPro);
end;

procedure TfrmLotePrecosEfetivacaoCx.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If Key = VK_ESCAPE Then
  Begin
    If dbgPrecos.Focused Then
      pSetFocus(cxgItens)

    Else If fCheckParent(ActiveControl, cxgItens) Then
    Begin
      If (Not objPreLotes.cdsConsulta.IsEmpty) And (Not fPergunta('Deseja abandonar a tarefa?')) Then
      Begin
        Key := 0;
        Exit;
      End;

      pLimparTela;

    End

    Else
      inherited;

    Exit;
  End;

  inherited;

  Case Key Of
    VK_F1 : btnPesLot.Click;
    VK_F2 : btnPesPed.Click;

    VK_F3 : btnMargemLucroGeral.Click;

    VK_F4 : btnCompCusto.Click;

    VK_F6 : btnMarcar.Click;

    VK_F7 : If ssAlt in Shift Then
              btnCarPreMedNaPreCom.Click
            Else
              btnDesmarcar.Click;

    VK_F8 : If ssAlt in Shift Then
              btnRecalcMargem.Click
            Else
              btnOpcPreVen.Click;

    VK_F9 : If ssAlt in Shift Then
              btnRecalcPreco.Click
            Else
              btnOpcMargem.Click;

    VK_F10: If ssAlt in Shift Then
              btnRecalcMargIdeal.Click
            Else
              btnConfirma.Click;

    VK_F11: If ssAlt in Shift Then
              btnExpProdutos.Click
            Else
              btnEspelho.Click;

    VK_F12: If ssAlt in Shift Then
              btnMarcarPrcRdz.Click
            Else
              btnPromocao.Click;
    End;

  pAlimentaVisaoSelecionados;

End;


procedure TfrmLotePrecosEfetivacaoCx.FormResize(Sender: TObject);
begin
  inherited;
  pAjustaBotaoSair;
end;

procedure TfrmLotePrecosEfetivacaoCx.FormShow(Sender: TObject);
begin
  inherited;

  if not fEmptyStr(strAutoincremGERELE + strAutoincremMOVGER) then
  begin
    btnPesLot.Enabled := False;
    btnPesPed.Enabled := False;
    blnFecharAoConfirmar := True;
    objPreLotes.blnFiltraResponsavel := Not blnFluxoCompra;
    if objPreLotes.fCarregaNota(strAutoincremGERELE, strAutoincremMOVGER) then
    Begin
      pCarregaRegistros(False);
      pMostraCotacao;
    End
    Else
      pLimparTela;

  end;
  edtQtdGridChange(edtQtdGrid);
  if dbgPrecos2.Visible then
    pSetFocus(dbgPrecos2);

  btnCadProduto.Visible := fVerificaAcessoSistema('frmCadProdutos');
  pAjustaBotaoSair;

  pRecalcularBandas;

  If ScrollBox1.HorzScrollBar.Visible Then
    ScrollBox1.HorzScrollBar.Position := 0;
end;

procedure TfrmLotePrecosEfetivacaoCx.pcdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;

  If DataSet.ControlsDisabled Then
    Exit;

  pnlTitPrecos.Caption := 'PREÇOS DO PRODUTO: ' + DataSet.FieldByName('ITE_DESCRI').AsString;
  objPreLotes.pAtualizaCdsPrecos(DataSet);

  If fEmptyStr(fRetornaCodPro(DataSet.FieldByName('ITE_CODITE').AsString, VS_strCodEmp, vs_Date, qryCadPro)) Then
  Begin
    lblPromocao.Caption := '';
    btnPromocao.Visible := False;
  End
  Else
  Begin
    lblPromocao.Caption := '** Item Possui Promoções **';
    btnPromocao.Visible := True;
  End;

end;

function TfrmLotePrecosEfetivacaoCx.fGetBanda(AStrCaption: String): TcxGridBand;
var
  I:Integer;
begin
  Result := Nil;
  For I := 0 To Pred(cxbItens.Bands.Count) Do
  Begin
    If cxbItens.Bands[I].Caption = AStrCaption Then
      Result := cxbItens.Bands[I];
  End;
end;

procedure TfrmLotePrecosEfetivacaoCx.pSetDocumentoDeEntradaLotePreco(strNumDoc, strEspDoc, strSerie_, strCodFor, strCodOperador: String; fltCotacao: Double; blnEntradaMercadoria: Boolean = False);
begin
  FblnEntradaMercadoria := blnEntradaMercadoria;
  objPreLotes.strNumDoc := strNumDoc;
  objPreLotes.strEspDoc := strEspDoc;
  objPreLotes.strSerie  := strSerie_;
  objPreLotes.strCodEmp := VS_StrCodEmp;
  objPreLotes.strCodFor := strCodFor;
  objPreLotes.strOpeRes := strCodOperador;

   If fCfgSis('COTDOR', varBoolean) And
    objPreLotes.fTemProdutosEmDolar(objPreLotes.strCodFor,
                                    objPreLotes.strNumDoc,
                                    objPreLotes.strEspDoc,
                                    objPreLotes.strSerie,
                                    objPreLotes.strCodEmp,
                                    fltCotacao) Then
  Begin
    objPreLotes.pSetCotDol(fltCotacao);
    If Not ((objPreLotes.fltCotDol > 0) Or (TfrmPedeCotacaoMoeda.fPedeCotacaoMoeda(fltCotacao, infoItemEmDolar))) Then
      Exit;
   End;


  pCarregaRegistros(False);
  blnFecharAoConfirmar := True;

  If fCfgSis('BLOPRE', varBoolean) Then
  Begin
    cxbItensTIPCAL1.Options.Editing := False;
    cxbItensTIPCAL2.Options.Editing := False;
    cxbItensTIPCAL3.Options.Editing := False;
    cxbItensTIPCAL4.Options.Editing := False;
    cxbItensTIPCAL5.Options.Editing := False;
    cxbItensTIPCAL6.Options.Editing := False;
    cxbItensTIPCAL7.Options.Editing := False;

    cxbItensLTP_MARBR1.Options.Editing := False;
    cxbItensLTP_PREVE1.Options.Editing := False;

    cxbItensLTP_MARBR2.Options.Editing := False;
    cxbItensLTP_PREVE2.Options.Editing := False;

    cxbItensLTP_MARBR3.Options.Editing := False;
    cxbItensLTP_PREVE3.Options.Editing := False;

    cxbItensLTP_MARBR4.Options.Editing := False;
    cxbItensLTP_PREVE4.Options.Editing := False;

    cxbItensLTP_MARBR5.Options.Editing := False;
    cxbItensLTP_PREVE5.Options.Editing := False;

    cxbItensLTP_MARBR6.Options.Editing := False;
    cxbItensLTP_PREVE6.Options.Editing := False;

    cxbItensLTP_MARBR7.Options.Editing := False;
    cxbItensLTP_PREVE7.Options.Editing := False;

    btnOpcPreVen.Enabled   := False;
    btnRecalcPreco.Enabled := False;
  End;
end;

procedure TfrmLotePrecosEfetivacaoCx.ReiniciarGrid1Click(Sender: TObject);
begin
  inherited;
  pReiniciaGridCfgGrid;
end;

procedure TfrmLotePrecosEfetivacaoCx.pReiniciaGridCfgGrid;
begin
  TSalvaConfiguracaoGrid.pApagaConfiguracoes(Self.Name);
  GridDefault.Position := 0;
  cxbItens.RestoreFromStream(GridDefault);
  objCfgGri.pSetaColunas;
  cxbItens.ApplyBestFit();
end;

procedure TfrmLotePrecosEfetivacaoCx.pFormataDecimais;
  Var
    intDecUni: Integer;
Begin
  intDecUni := fCfgSis('DECUNI', varInteger);

  TcxCurrencyEditProperties(cxbItensITE_UNITAR.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxbItensLTP_PRECOM.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxbItensLTP_PRECUS.Properties).DecimalPlaces := intDecUni;

  TcxCurrencyEditProperties(cxbItensLTP_PREVE1.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxbItensLTP_PREVE2.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxbItensLTP_PREVE3.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxbItensLTP_PREVE4.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxbItensLTP_PREVE5.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxbItensLTP_PREVE6.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxbItensLTP_PREVE7.Properties).DecimalPlaces := intDecUni;

  TcxCurrencyEditProperties(cxbItensLTP_PREVE1_ANT.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxbItensLTP_PREVE2_ANT.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxbItensLTP_PREVE3_ANT.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxbItensLTP_PREVE4_ANT.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxbItensLTP_PREVE5_ANT.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxbItensLTP_PREVE6_ANT.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxbItensLTP_PREVE7_ANT.Properties).DecimalPlaces := intDecUni;
End;

procedure TfrmLotePrecosEfetivacaoCx.pConfirma;
  Var
    strOpcoes: String;
    dtaDtaAtu: TDateTime;
    intOpcaoSel: Integer;
begin
  If (objPreLotes.cdsConsulta.RecordCount = 0) Or
     (objPreLotes.stlListSelecao.Count    = 0) Then
  Begin
    fMensagem('','Nenhum Registro Selecionado!',['&O K']);
    Exit;
  End;

  If Not objPreLotes.fValidaMargens then
  Begin
    fMensagem('Atenção','Existe margem com valor menor ou igual a zero!',['&O K']);
    Exit;
  End;


  If fCfgSis('MONPRC', varBoolean) Then
  Begin
    objAvisoAlteracaoPreco.FcdsDados := cxbItens.DataController.DataSource.DataSet;
    objAvisoAlteracaoPreco.FlstMarcadosEfetivacao := objPreLotes.stlListSelecao;
    If Not objAvisoAlteracaoPreco.fVerificaOscilacao(tpLotPre) Then
      Exit;
  End;

  strOpcoes := '';
  strOpcoes := strOpcoes + fPadR('Selecione a opção desejada:', 60) + #13#10;
  strOpcoes := strOpcoes + fPadR('', 60) + #13#10;
  strOpcoes := strOpcoes + fPadR('Efetivar: Realiza a baixa agendando a atualização preço.', 63) + #13#10;
  strOpcoes := strOpcoes + fPadR('Baixar..: Realiza a baixa sem realizar alteração de preço.', 63) + #13#10;
  strOpcoes := strOpcoes + fPadR('Cancelar: Cancela a operação e volta a tela anterior.', 63);

  intOpcaoSel := fMensagem('',strOpcoes, ['&Efetivar','&Baixar', '&Cancelar'], 1, False, 2);

  dtaDtaAtu := VS_Date;

  Case intOpcaoSel Of

    1: Begin
         If ffrmData(dtaDtaAtu, '', 'Digite a Data para a Atualização de Preços', VS_Date) Then
           pConfirmaBaixa(True, dtaDtaAtu);
       End;

    2: pConfirmaBaixa;

  End;

end;

function TfrmLotePrecosEfetivacaoCx.fValorUtilizadoDifereteDoDefinido: Boolean;
begin
  Result := False;
  If Not SameText(objPreLotes.cdsConsulta.FieldByName('LTP_PRECOM_UTI').AsString, objPreLotes.cdsConsulta.FieldByName('LTP_PRECOM_ATU').AsString) Then
    Exit(True)
  Else If Not SameText(objPreLotes.cdsConsulta.FieldByName('LTP_DESF01_UTI').AsString, objPreLotes.cdsConsulta.FieldByName('LTP_DESF01_ATU').AsString) Then
    Exit(True)
  Else If Not SameText(objPreLotes.cdsConsulta.FieldByName('LTP_DESF02_UTI').AsString, objPreLotes.cdsConsulta.FieldByName('LTP_DESF02_ATU').AsString) Then
    Exit(True)
  Else If Not SameText(objPreLotes.cdsConsulta.FieldByName('LTP_DESF03_UTI').AsString, objPreLotes.cdsConsulta.FieldByName('LTP_DESF03_ATU').AsString) Then
    Exit(True)
  Else If Not SameText(objPreLotes.cdsConsulta.FieldByName('LTP_DESF04_UTI').AsString, objPreLotes.cdsConsulta.FieldByName('LTP_DESF04_ATU').AsString) Then
    Exit(True)
  Else If Not SameText(objPreLotes.cdsConsulta.FieldByName('LTP_DESF05_UTI').AsString, objPreLotes.cdsConsulta.FieldByName('LTP_DESF05_ATU').AsString) Then
    Exit(True)
  Else If Not SameText(objPreLotes.cdsConsulta.FieldByName('LTP_DESF06_UTI').AsString, objPreLotes.cdsConsulta.FieldByName('LTP_DESF06_ATU').AsString) Then
    Exit(True)
  Else If Not SameText(objPreLotes.cdsConsulta.FieldByName('LTP_ICMENT_UTI').AsString, objPreLotes.cdsConsulta.FieldByName('LTP_ICMENT_ATU').AsString) Then
    Exit(True)
  Else If Not SameText(objPreLotes.cdsConsulta.FieldByName('LTP_SUBFED_UTI').AsString, objPreLotes.cdsConsulta.FieldByName('LTP_SUBFED_ATU').AsString) Then
    Exit(True)
  Else If Not SameText(objPreLotes.cdsConsulta.FieldByName('LTP_IPIENT_UTI').AsString, objPreLotes.cdsConsulta.FieldByName('LTP_IPIENT_ATU').AsString) Then
    Exit(True)
  Else If Not SameText(objPreLotes.cdsConsulta.FieldByName('LTP_FREENT_UTI').AsString, objPreLotes.cdsConsulta.FieldByName('LTP_FREENT_ATU').AsString) Then
    Exit(True)
  Else If Not SameText(objPreLotes.cdsConsulta.FieldByName('LTP_VALFRE_UTI').AsString, objPreLotes.cdsConsulta.FieldByName('LTP_VALFRE_ATU').AsString) Then
    Exit(True)
  Else If Not SameText(objPreLotes.cdsConsulta.FieldByName('LTP_ACRFIN_UTI').AsString, objPreLotes.cdsConsulta.FieldByName('LTP_ACRFIN_ATU').AsString) Then
    Exit(True)
  Else If Not SameText(objPreLotes.cdsConsulta.FieldByName('LTP_SUBSTI_UTI').AsString, objPreLotes.cdsConsulta.FieldByName('LTP_SUBSTI_ATU').AsString) Then
    Exit(True)
  Else If Not SameText(objPreLotes.cdsConsulta.FieldByName('LTP_DESADB_UTI').AsString, objPreLotes.cdsConsulta.FieldByName('LTP_DESADB_ATU').AsString) Then
    Exit(True)
  Else If Not SameText(objPreLotes.cdsConsulta.FieldByName('LTP_OUTVAL_UTI').AsString, objPreLotes.cdsConsulta.FieldByName('LTP_OUTVAL_ATU').AsString) Then
    Exit(True)
  Else If Not SameText(objPreLotes.cdsConsulta.FieldByName('LTP_IMPFED_UTI').AsString, objPreLotes.cdsConsulta.FieldByName('LTP_IMPFED_ATU').AsString) Then
    Exit(True)
  Else If Not SameText(objPreLotes.cdsConsulta.FieldByName('LTP_DESOPE_UTI').AsString, objPreLotes.cdsConsulta.FieldByName('LTP_DESOPE_ATU').AsString) Then
    Exit(True)
  Else If Not SameText(objPreLotes.cdsConsulta.FieldByName('LTP_ICMSAI_UTI').AsString, objPreLotes.cdsConsulta.FieldByName('LTP_ICMSAI_ATU').AsString) Then
    Exit(True)
end;


procedure TfrmLotePrecosEfetivacaoCx.pAddColunaMsg(var objTabela : TRegistroMsgLiberaTabela;var objLinha :TLinhaMsgLibera; AItem: String; ACampo: string; AValorDefinido: String; AValorEntrada: String);
begin
  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlValor;
  objLinha.pAddColuna('Item'            , AItem , 7  , alEsquerda );
  objLinha.pAddColuna('Campo'  , ACampo, 55 , alEsquerda );
  objLinha.pAddColuna('Valor Definido'  , AValorDefinido , 15 , alDireita );
  objLinha.pAddColuna('Valor Entrada'   , AValorEntrada  , 15 , alDireita );
  objTabela.lstLinhas.Add(objLinha);
End;

procedure TfrmLotePrecosEfetivacaoCx.pAjustaBotaoSair;
begin
    btnSair.Left := Width - btnSair.Width - 20;
end;

function TfrmLotePrecosEfetivacaoCx.fFormata(AField: TField): String;
Begin
  Result := FormatFloat(TFloatField(AField).DisplayFormat, AField.AsFloat);
End;


function TfrmLotePrecosEfetivacaoCx.fGetIndexByText(
  strBandName: String): integer;
  var i: integer;
begin
  for i := 0 to  cxbItens.Bands.Count -1 do
    if cxbItens.Bands[i].Caption = strBandName  then
      exit(cxbItens.Bands[i].position.colIndex);
  result := -1;
end;

function TfrmLotePrecosEfetivacaoCx.fSenhaSeItensAlteradoOPreDefinido: Boolean;
  var
    objLiberacao : ILiberacao;
    objTabela : TRegistroMsgLiberaTabela;
  	objLinha  : TLinhaMsgLibera;
    blnTrava: Boolean;
    IntContador: Integer;
    fltPrecus,
    fltPreLiq: Double;
begin
  Result := true;
    pgbProgresso.Position := 0;
    pgbProgresso.Max := objPreLotes.stlListSelecao.Count;

    objLiberacao := TLiberacaoFactory.fGetLiberacao;
    objLiberacao.Clear;

    objLiberacao.objMsgLibera.pAddTexto('LIBERAÇÃO DE PRODUTOS QUE NÃO UTILIZAM O CÁLCULADO NA ENTRADA');

    objTabela := TRegistroMsgLiberaTabela.Create;
    objLinha  := TLinhaMsgLibera.Create;

    objLinha.enuTipoLinha := tlCabecalho;

    objLinha.pAddColuna(''  , 'Item'                            , 7  , alEsquerda  , teAutcom);
    objLinha.pAddColuna(''  , 'Campo'                  , 55 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Valor Definido'                  , 15 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'Valor Entrada'                   , 15 , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);
    blnTrava := False;
    For intContador := 0 To objPreLotes.stlListSelecao.Count -1 Do
    Begin
      If (objPreLotes.cdsConsulta.Locate('AUTOINCREM', Copy(objPreLotes.stlListSelecao[IntContador], 2, 20), [])) And  fValorUtilizadoDifereteDoDefinido Then
      Begin
        blnTrava := True;
        pAddColunaMsg (objTabela, objLinha, objPreLotes.cdsConsulta.FieldByName('ITE_CODITE').AsString, 'Preço de Compra', fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_PRECOM_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_PRECOM_ATU')));
        pAddColunaMsg (objTabela, objLinha, '', '(-) % Desc. Forn. 1', fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_DESF01_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_DESF01_ATU')));
        pAddColunaMsg (objTabela, objLinha, '', '(-) % Desc. Forn. 2', fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_DESF02_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_DESF02_ATU')));
        pAddColunaMsg (objTabela, objLinha, '', '(-) % Desc. Forn. 3', fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_DESF03_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_DESF03_ATU')));
        pAddColunaMsg (objTabela, objLinha, '', '(-) % Desc. Forn. 4', fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_DESF04_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_DESF04_ATU')));
        pAddColunaMsg (objTabela, objLinha, '', '(-) % Desc. Forn. 5', fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_DESF05_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_DESF05_ATU')));
        pAddColunaMsg (objTabela, objLinha, '', '(-) % Desc. Forn. 6', fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_DESF06_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_DESF06_ATU')));

        fltPreLiq :=  untFuncoesSimples.fCalculaPrecoCompraLiq(objPreLotes.cdsConsulta.FieldByName('LTP_PRECOM_ATU').AsFloat,
                                                               objPreLotes.cdsConsulta.FieldByName('LTP_DESF01_ATU').AsFloat,
                                                               objPreLotes.cdsConsulta.FieldByName('LTP_DESF02_ATU').AsFloat,
                                                               objPreLotes.cdsConsulta.FieldByName('LTP_DESF03_ATU').AsFloat,
                                                               objPreLotes.cdsConsulta.FieldByName('LTP_DESF04_ATU').AsFloat,
                                                               objPreLotes.cdsConsulta.FieldByName('LTP_DESF05_ATU').AsFloat,
                                                               objPreLotes.cdsConsulta.FieldByName('LTP_DESF06_ATU').AsFloat);

        pAddColunaMsg (objTabela, objLinha, '', 'Preço de Compra Líquido', fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_COMLIQ')), FormatFloat('#0.00', fltPreLiq));

        pAddColunaMsg (objTabela, objLinha, '', '(-) % Icms Entrada'     , fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_ICMENT_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_ICMENT_ATU')));
        pAddColunaMsg (objTabela, objLinha,'', '(-) % Impostos Federais', fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_SUBFED_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_SUBFED_ATU')));
        pAddColunaMsg (objTabela, objLinha,'', '(+) % IPI Entrada'      , fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_IPIENT_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_IPIENT_ATU')));
        pAddColunaMsg (objTabela, objLinha,'', '(+) % Frete'            , fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_FREENT_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_FREENT_ATU')));
        pAddColunaMsg (objTabela, objLinha,'', '(+) ' + fCfgSis('DESVFR'), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_VALFRE_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_VALFRE_ATU')));
        pAddColunaMsg (objTabela, objLinha,'', '(+) % Acr. Financ.'     , fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_ACRFIN_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_ACRFIN_ATU')));
        pAddColunaMsg (objTabela, objLinha,'', '(+) % Sub. Tributária'  , fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_SUBSTI_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_SUBSTI_ATU')));
        pAddColunaMsg (objTabela, objLinha,'', '(' + fCfgSis('OPEADI') + ') % ' + fCfgSis('DESADI'),
                                                      fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_DESADB_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_DESADB_ATU')));

        if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
        begin
          pAddColunaMsg(objTabela, objLinha,'', '(+) % TCIF'                 ,  fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_TCIFCU_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_TCIFCU_ATU')));
          pAddColunaMsg(objTabela, objLinha,'', '(+) % TS'                   ,  fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_TSCUST_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_TSCUST_ATU')));
          pAddColunaMsg(objTabela, objLinha,'', '(-) % Desconto PIS/COFINS'  ,  fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_DEPICO_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_DEPICO_ATU')));
          pAddColunaMsg(objTabela, objLinha,'', '(-) % Desconto ICMS'        ,  fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_DEICMS_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_DEICMS_ATU')));
          pAddColunaMsg(objTabela, objLinha,'', '(+) % Fator Regional'       ,  fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_FATREG_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_FATREG_ATU')));
        end;

        fltPrecus := objPreLotes.fCalculaPrecoCusto(objPreLotes.cdsConsulta, True);

        pAddColunaMsg (objTabela, objLinha,'', 'Preço de Custo'         , fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_PRECUS')), FormatFloat('#0.00', fltPrecus));
        pAddColunaMsg (objTabela, objLinha,'', '(+) '+ fCfgSis('DOVCPP'), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_OUTVAL_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_OUTVAL_ATU')));
        pAddColunaMsg (objTabela, objLinha,'', '(+) Icms Saída'         , fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_ICMSAI_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_ICMSAI_ATU')));
        pAddColunaMsg (objTabela, objLinha,'', '(+) Impostos Federais'  , fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_IMPFED_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_IMPFED_ATU')));
        pAddColunaMsg (objTabela, objLinha,'', '(+) Despesas Operac.'   , fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_DESOPE_UTI')), fFormata(objPreLotes.cdsConsulta.FieldByName('LTP_DESOPE_ATU')));
        pAddColunaMsg (objTabela, objLinha,'', 'Preço de Custo Real'    , fFormata(objPreLotes.cdsConsulta.FieldByName('ITE_CUSREA')), FormatFloat('#0.00', fCalculaCustoReal(fltPrecus,
                                                                                                                                        objPreLotes.cdsConsulta.FieldByName('LTP_ICMSAI_ATU').AsFloat,
                                                                                                                                        objPreLotes.cdsConsulta.FieldByName('LTP_IMPFED_ATU').AsFloat,
                                                                                                                                        objPreLotes.cdsConsulta.FieldByName('LTP_DESOPE_ATU').AsFloat,
                                                                                                                                        objPreLotes.cdsConsulta.FieldByName('LTP_OUTVAL_ATU').AsFloat)));
      End;
      pgbProgresso.Position := Succ(intContador);
      Application.ProcessMessages;
    End;

    If blnTrava Then
    Begin
      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
      objLiberacao.strDirAce := 'ALPDCE';
      objLiberacao.strMsgSen := 'Liberação Ativação lote de preço desconsiderando cálculo da entrada';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;

      Result :=  objLiberacao.fLibera;
    End;

end;


Function TfrmLotePrecosEfetivacaoCx.fTemMargemNegativa: Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  With objPreLotes.cdsConsulta Do
  For intContador := 1 To Length(VS_strTabPrc) Do
    If (VS_strTabPrc[intContador] = 'S') And (FieldByName('LTP_MARBR' + IntToStr(intContador)).AsFloat < 0) Then
    Begin
      Result := True;
      Exit;
    End;

End;

procedure TfrmLotePrecosEfetivacaoCx.pIncluiMarNeg(cdsMarNeg: TZClient);
  Var
    intCont: Integer;
Begin
  with cdsMarNeg, objPreLotes Do
  Begin
    Append;

    FieldByName('ITE_CODITE').AsString := cdsConsulta.FieldByName('ITE_CODITE').AsString;
    FieldByName('ITE_DESITE').AsString := cdsConsulta.FieldByName('ITE_DESCRI').AsString;
    FieldByName('ITE_SIGUNI').AsString := cdsConsulta.FieldByName('ITE_SIGUNI').AsString;

    FieldByName('ITE_PRECUS').AsFloat  := cdsConsulta.FieldByName('LTP_PRECUS').AsFloat;

    For intCont := 1 To Length(VS_strTabPrc) Do
    Begin
      FieldByName('ITE_MARBR' + IntToStr(intCont)).AsFloat := cdsConsulta.FieldByName('LTP_MARBR' + IntToStr(intCont)).AsFloat;
      FieldByName('ITE_PREVE' + IntToStr(intCont)).AsFloat := cdsConsulta.FieldByName('LTP_PREVE' + IntToStr(intCont)).AsFloat;
    End;

    Post;
  End;
End;

procedure TfrmLotePrecosEfetivacaoCx.pConfirmaBaixa(blnGravaPreIte: Boolean = False; dtaDtaAtu: TDateTime = 0);
  Var
    intContador : Integer;
    strProPri: String;
    pAfterScroll: TDataSetNotifyEvent;
    cdsMarNeg: TZClient;
    blnConfirma: Boolean;
    stlItens: TStringList;
begin
  blnConfirma := True;

  objPreLotes.cdsConsulta.DisableControls;
  Try

    pnlInfo.Caption   := 'Processando registros, aguarde...';
    pnlBotoes.Enabled := False;

    Application.ProcessMessages;

    pgbProgresso.Visible := True;

    With objPreLotes, cdsConsulta Do
    Begin
      pAfterScroll := AfterScroll;
      AfterScroll := Nil;

      If blnGravaPreIte Then
        strProPri := fRetSequencial('PROPRI', VS_strCodEmp)
      Else
        strProPri := '';

      //*****************************************//
      If blnMarNeg And blnGravaPreIte Then
      Begin
        pgbProgresso.Position := 0;
        pgbProgresso.Max := stlListSelecao.Count;

        cdsMarNeg := TProdMargemNegativa.fCriaDadosItem('');

        For intContador := 0 To stlListSelecao.Count -1 Do
        Begin
          If (Locate('AUTOINCREM', Copy(stlListSelecao[IntContador], 2, 20), [])) And
             fTemMargemNegativa Then
            pIncluiMarNeg(cdsMarNeg);


          pgbProgresso.Position := Succ(intContador);
          Application.ProcessMessages;
        End;

        If Not cdsMarNeg.IsEmpty Then
          blnConfirma := TProdMargemNegativa.fLiberaMargemNegativa(cdsMarNeg, cdsMarNeg, rotEfetivacaoLotePrecos);

        FreeAndNil(cdsMarNeg);
      End;
      //*****************************************//

      If blnGravaPreIte And (Not fSenhaSeItensAlteradoOPreDefinido) Then
        blnConfirma := False;

      If blnConfirma Then
      Begin

        pgbProgresso.Position := 0;
        pgbProgresso.Max := stlListSelecao.Count;

        For intContador := 0 To stlListSelecao.Count -1 Do
        Begin
          If Locate('AUTOINCREM', Copy(stlListSelecao[IntContador], 2, 20), []) Then
              objPreLotes.pBaixarLotePrecos(cdsConsulta, strProPri, blnGravaPreIte, dtaDtaAtu);

          pgbProgresso.Position := Succ(intContador);

          Application.ProcessMessages;
        End;

      End;

      Filter   := '';
      Filtered := False;

      AfterScroll := pAfterScroll;
    End;

    pnlInfo.Caption   := '';
    pnlBotoes.Enabled := True;

    pgbProgresso.Visible := False;

    If blnConfirma Then
    Begin
      If fCfgSis('ABREFE', varBoolean) Then
      Begin
        fMensagem('', 'Operação concluída com sucesso!', ['&Ok']);

        If blnGravaPreIte And (dtaDtaAtu <= VS_Date) Then
          pOpeProd(AltEfetivacaoPrecos);
      End
      Else
      Begin

        If blnGravaPreIte And (dtaDtaAtu <= VS_Date) Then
        Begin
          If fConfirmaEfetivacaoPreco(dtaDtaAtu) Then
            fMensagem('', 'Operação concluída com sucesso!', ['&Ok'])
          Else
            fMensagem('', 'Ocorreu problemas ao efetivar os preços. Execute a confirmação da efetivação de preços!', ['&Ok']);
        End
        Else
          fMensagem('', 'Operação concluída com sucesso!', ['&Ok']);
      End;


      If fCfgSis('ETILOT') = 'S' Then
      Begin
        stlItens := TStringList.Create;
        stlItens.Delimiter := ',';
        Try
          cxbItens.DataController.DataSource.DataSet.First;
          while not cxbItens.DataController.DataSource.DataSet.Eof do
          begin
            If objPreLotes.stlListSelecao.IndexOf(QuotedStr(cxbItens.DataController.DataSource.DataSet.FieldByname('AUTOINCREM').AsString)) > -1 Then
              stlItens.Add(QuotedStr(cxbItens.DataController.DataSource.DataSet.FieldByname('ITE_CODITE').AsString));
            cxbItens.DataController.DataSource.DataSet.Next;
          End;
          stlItens.CommaText := stlItens.Text;

          If stlItens.Count > 0 Then
          begin
            If FblnPedido Then
              TfrmEntEtiquetas.pImpEtiPedidoDeCompra(edtNumDoc.Text,
                                                    edtEspDoc.Text,
                                                    objPreLotes.strCodFor,
                                                    stlItens)
            Else
              TfrmEntEtiquetas.pImpEtiEntradaMercadorias(edtNumDoc.Text,
                                                        edtEspDoc.Text,
                                                        objPreLotes.strCodFor,
                                                        edtSerie.Text,
                                                        False,
                                                        tpeItensControladosLaser,
                                                        stlItens);
          End;
        Finally
         FreeAndNil(stlItens);
        End;
      End;


      pLimparTela;

      If blnFecharAoConfirmar Then
        Close;

    End;
  Finally
    objPreLotes.cdsConsulta.EnableControls;
  End;

end;

procedure TfrmLotePrecosEfetivacaoCx.pLimparTela;
begin
  pnlTitPrecos.Caption := 'PREÇOS DO PRODUTO:';

  edtNumDoc.Clear;
  edtEspDoc.Clear;
  edtSerie.Clear;
  edtDtaEnt.Clear;
  edtOpeRes.Clear;
  edtCodFor.Clear;
  edtQtdSel.Clear;
  edtQtdReg.Clear;
  edtCodEmp.Clear;

  lblCotDol.Visible := False;
  edtCotDol.Visible := False;
  edtCotDol.Clear;

  With objPreLotes Do
  Begin
    If cdsConsulta.Active Then
    Begin
      cdsConsulta.EmptyDataSet;
      pAtualizaCdsPrecos(cdsConsulta);
    End;

    pMarcaTodos(False);
    cdsConsulta.EmptyDataSet;

    objLock.pDestravarTodos;

    pSetFocus(btnPesLot);
  End;
end;


procedure TfrmLotePrecosEfetivacaoCx.pRetCamposPosicao;
Var
  i: Integer;
begin
  SetLength(ArrCamposPosicaoOriginal, cxbItens.ColumnCount);
  For i := 0 To cxbItens.ColumnCount -1 Do
  Begin
    ArrCamposPosicaoOriginal[i].NomCam :=  cxbItens.Columns[i].DataBinding.FieldName;
    ArrCamposPosicaoOriginal[i].colIndex :=  cxbItens.Columns[i].Position.ColIndex;
    ArrCamposPosicaoOriginal[i].BandIndex :=  cxbItens.Columns[i].Position.BandIndex;
    ArrCamposPosicaoOriginal[i].Column :=  cxbItens.Columns[i];
    ArrCamposPosicaoOriginal[i].Banda := cxbItens.Columns[i].Position.Band;
  End;
end;


end.
