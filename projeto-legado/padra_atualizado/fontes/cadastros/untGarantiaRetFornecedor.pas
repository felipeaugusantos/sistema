unit untGarantiaRetFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask, MaskEditFocus,
  DB, UniClientDataSet, Grids, DBGridCitel, DBGrids, EditFocus, untFuncFat, Uni, untGarant, DBCtrls,
  DBEditFocus, AppEvnts, frxClass, frxDMPExport, frxDBSet, BitBtnLockedIncrem,
  untFuncoesSimples, StrUtils, untTypesSistema, frxExportCSVTestabilidade, untZClient, untMovGer,
  Datasnap.DBClient, untLiberacao, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  untCfgGrid, untSalvaConfiguracaoGrid,
  cxClasses, cxGridCustomView, cxGrid, cxGridCitel, cxGridBandedTableView,
  cxGridDBBandedTableView, cxCurrencyEdit, cxButtonEdit, cxEditRepositoryItems;

type
  {$SCOPEDENUMS ON}
  TenuTipoMarcacaoRegistro = (Marcar, Desmarcar, BaixaRetornoTotal, RefugoTotal);
  {$SCOPEDENUMS OFF}
type
  TenuTipoMarcacaoRegistroTotal = TenuTipoMarcacaoRegistro.BaixaRetornoTotal..TenuTipoMarcacaoRegistro.RefugoTotal;
type
  TfrmGarantiaRetFornecedor = class(TfrmPai)
    pnlFornecedor: TPanel;
    Label1: TLabel;
    edtNomFor: TEditFocus;
    edtCodFor: TEditFocus;
    cdsProdutos: TUniClientDataSet;
    cdsProdutosCODITE: TStringField;
    cdsProdutosDESITE: TStringField;
    cdsProdutosUNIDAD: TStringField;
    cdsProdutosAUTINC: TStringField;
    dtsProdutos: TDataSource;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    cdsProdutosQTDRET: TFloatField;
    cdsProdutosQTDREF: TFloatField;
    cdsProdutosQTDRET_1: TFloatField;
    cdsProdutosQTDREF_1: TFloatField;
    cdsProdutosQTDREQ: TFloatField;
    pnlObs: TPanel;
    lblObs_01: TLabel;
    lblObs_02: TLabel;
    lblObs_03: TLabel;
    lblObs_04: TLabel;
    lblObs_05: TLabel;
    cdsProdutosAGG_QTDRET_1: TAggregateField;
    cdsProdutosAGG_QTDREF_1: TAggregateField;
    cdsProdutosOBSF_1: TStringField;
    cdsProdutosOBSF_2: TStringField;
    cdsProdutosOBSF_3: TStringField;
    cdsProdutosOBSF_4: TStringField;
    cdsProdutosOBSF_5: TStringField;
    dbeObsF_1: TDBEditFocus;
    dbeObsF_2: TDBEditFocus;
    dbeObsF_3: TDBEditFocus;
    dbeObsF_4: TDBEditFocus;
    dbeObsF_5: TDBEditFocus;
    cdsProdutosCODVEN: TStringField;
    cdsProdutosCODCLI: TStringField;
    cdsProdutosCODFOR: TStringField;
    cdsProdutosREFERE: TStringField;
    frxDBGarantiaRF: TfrxDBDataset;
    frxDocRetornoJ: TfrxReport;
    frxDocRetornoM: TfrxReport;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    lblMotivo: TLabel;
    dbeMotivo: TDBEditFocus;
    cdsProdutosMOTIVO: TStringField;
    btnConfirmar: TBitBtnLocked;
    cdsProdutosNUMENV: TStringField;
    cdsProdutosVALITE: TCurrencyField;
    cdsProdutosITEFRA: TStringField;
    cdsProdutosNUMPED: TStringField;
    cdsProdutosNUMENT: TStringField;
    cdsProdutosINCGAE: TStringField;
    cdsProdutosVALUNT: TCurrencyField;
    cdsProdutosINCGAG: TStringField;
    dbgProduto: TcxGridCitel;
    dbgProdutoDBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel;
    dbgProdutoViewNUMENV: TcxGridDBBandedColumn;
    dbgProdutoViewNUMPED: TcxGridDBBandedColumn;
    dbgProdutoViewNUMENT: TcxGridDBBandedColumn;
    dbgProdutoViewCODITE: TcxGridDBBandedColumn;
    dbgProdutoViewDESITE: TcxGridDBBandedColumn;
    dbgProdutoViewUNIDAD: TcxGridDBBandedColumn;
    dbgProdutoViewQTDREQ: TcxGridDBBandedColumn;
    dbgProdutoViewQTDRET: TcxGridDBBandedColumn;
    dbgProdutoViewQTDREF: TcxGridDBBandedColumn;
    dbgProdutoViewQTDRET_1: TcxGridDBBandedColumn;
    dbgProdutoViewQTDREF_1: TcxGridDBBandedColumn;
    dbgProdutoViewREFERE: TcxGridDBBandedColumn;
    dbgProdutoViewSELECIONADO: TcxGridDBBandedColumn;
    dbgProdutoViewCODFAB: TcxGridDBBandedColumn;
    dbgProdutoLevel1: TcxGridLevel;
    cdsProdutosSELECIONADO: TStringField;
    btnMarcaDesmarcaItem: TBitBtnLocked;
    btnMarcaDesmarcaTodos: TBitBtnLocked;
    btnRetornoTotal: TBitBtnLocked;
    btnRefugoTotal: TBitBtnLocked;
    pnlSelXML: TPanel;
    cdsProdutosCODFAB: TStringField;


    dbgProdutoViewCodBAr: TcxGridDBBandedColumn;
    dbgProdutoViewBaremb: TcxGridDBBandedColumn;
    Panel2: TPanel;
    pnlSubGridProdutos: TPanel;
    btnConfiguraDadosAtuais: TBitBtnLocked;
    cdsProdutosCODBAR: TStringField;
    cdsProdutosBAREMB: TStringField;

    splSeparador: TSplitter;
    pnlItensNfe: TPanel;
    cxItens: TcxGridCitel;
    cxvItens: TcxGridDBTableViewCitel;
    cxvItensITE_CODITE: TcxGridDBColumn;
    cxvItensITE_DESITE: TcxGridDBColumn;
    cxvItensITE_QTDXML: TcxGridDBColumn;
    cxvItensITE_QTDRET: TcxGridDBColumn;
    cxvItensITE_QTDREF: TcxGridDBColumn;
    cxlItens: TcxGridLevel;
    Panel4: TPanel;
    Shape1: TShape;
    Label5: TLabel;
    Shape2: TShape;
    Label6: TLabel;
    cxvItensDIVERGENTE: TcxGridDBColumn;
    edtNotEle: TEditFocus;
    dtsitensNf: TDataSource;
    cxEditRepository1: TcxEditRepository;
    cxEditButtonItemVisible: TcxEditRepositoryButtonItem;
    cxEditButtonItemInvisible: TcxEditRepositoryButtonItem;
    cdsProdutosQTDSKU: TIntegerField;
    dbgProdutoViewQTDSKU: TcxGridDBBandedColumn;
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mskDtaFinExit(Sender: TObject);
    procedure dbeObsF_5Exit(Sender: TObject);
    procedure dtsProdutosDataChange(Sender: TObject; Field: TField);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsProdutosBeforePost(DataSet: TDataSet);
    procedure cdsProdutosAfterScroll(DataSet: TDataSet);
    procedure edtCodForExit(Sender: TObject);
    procedure mskDtaIniExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeMotivoExit(Sender: TObject);
    procedure dbgProdutoEnter(Sender: TObject);
    procedure dbgProdutoViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure dbgProdutoViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgProdutoViewKeyPress(Sender: TObject; var Key: Char);
    procedure dbgProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure btnRefugoTotalClick(Sender: TObject);
    procedure btnMarcaDesmarcaItemClick(Sender: TObject);
    procedure btnMarcaDesmarcaTodosClick(Sender: TObject);
    procedure btnRetornoTotalClick(Sender: TObject);
    procedure cdsProdutosAfterCancel(DataSet: TDataSet);
    procedure cdsProdutosAfterPost(DataSet: TDataSet);
    procedure cdsProdutosQTDRET_1Validate(Sender: TField);
    procedure cdsProdutosQTDREF_1Validate(Sender: TField);
    procedure dbgProdutoDBBandedTableViewCitel1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgProdutoDBBandedTableViewCitel1KeyPress(Sender: TObject;
      var Key: Char);
    procedure dbgProdutoDBBandedTableViewCitel1KeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure btnConfiguraDadosAtuaisClick(Sender: TObject);
    procedure pAtualizaGridItensNFE;

    procedure btnNotEleClick(Sender: TObject);
    procedure pCarregaNFE;
    function fGetSQLItensNFEXml: String;
    procedure cxvItensCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure dbgProdutoViewCODFABPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure dbgProdutoViewCODFABGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);

  private
    blnCarregando: Boolean;
    blnDistribuir: Boolean;
    FQuantidadeDistribuir: Double;
    FstrChaveGrid: String;
    cdsItensNFe: TZClient;
    recNotEle: TRecInfoNotaEletronica;

    objCfgGrid: TCfgGrid;
    FblnUsuarioTemPermissaoEnviarRefugo: Boolean;
    { Private declarations }
    blnAlterouRetorno: boolean;
    strNumDocEnt,
    strEspDocEnt : String;

    objMovGag: TMovGag;
    strNumRet: String;
    blnBaixar: Boolean;
    blnConfirma: Boolean;
    qryItePed: TUniQuery;
    cdsGroup : TUniClientDataSet;
    fatVenda : TFatVenda;
    objLiberacao : TLiberacao;
    strCtaCre: String;
    strPorGRF: String;
    blnPermiteCarregarXML: Boolean;
    procedure onCdsItemNFAfterScroll(DataSet: TDataSet);
    procedure pCarregaTabelaProdutos(qryFornec: TUniQuery;
      cdsProdutos: TUniClientDataSet);
    procedure pHabilitaOBS;
    procedure pEscondeOBS;
    procedure pTravaItemFracionadoKey(Sender: TObject; var Key: Char);    
    procedure pCarregaItens;

    procedure pImprimeDocumento;
    //function fRetSequencial: String;
    function fSoRefugo: Boolean;

    function fEntradaNF(var strNumDoc, strEspDoc: string; strCodFor: String; strChaveSEQGAG: String = ''): Boolean;

    function fGravaCreditoFornecedor(strCodFor, strCodCta, strNumGars, strNumDocs, strCodPor: String; fltValDup: Double): Boolean;
    procedure pGetNumDocsGarAndDocsEnvAndCre(var strNumEnt, strNumEnv: String; fltValDup: Double);
    procedure pBaixaPedidos(blnRefugo : Boolean);
    procedure pAfterConfirmaEntrada;
    procedure pAtualizaTotais;
    procedure pMarcaDesmarca(enuTipoMarcacao: TenuTipoMarcacaoRegistro; blnTodos: Boolean = False);
    function fSaldoItem: Double;
    function fConfirmarMarcacaoTotal(enuTipoMarcacaoTotal: TenuTipoMarcacaoRegistroTotal): Boolean;
    procedure pDesabilitarRefugo;
    function fTodosItemNfeAtendido: Boolean;
    procedure pBaixaNotaEletronica(ANumRet: String);
  public
    { Public declarations }

  protected
    FcdsFornecedoresItem: TUniClientDataSet;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pEscapePressed; override;
    procedure pCriarCdsFornecdoresitem;
    procedure pExibirCodigosProdutoFornecedores(const pstrCodIte, pstrCodFor: String);
    function fRetStrChaveGrid: String;virtual;

  end;

Const
  MSG_IMPRESSINV = 'Houve um erro ao enviar o documento para a impressora.' + #13#10 +
                   'Verifique se a impressora selecionada é válida ou seu nome está digitado corretamente.';

  REG_SELECIONADO: String = '1';
  REG_NAO_SELECIONADO: String = '0';
  DIRACE_PERMITIR_ENVIAR_REFUGO: String = 'GRPREF';

implementation

uses   untFuncoes, untCfgRel, untConsultas, untEntMercadorias,
       untFatImpressao,
       untFatDigDadosGarantia, untCadPag, untFatDigPrecoCusto,
       untConstantes,
       untFormGrid,
       untFuncoesGenerica,
       untPcmGer, untPanelCxPreNota;


{$R *.dfm}

{*******************************************}
{* VALIDA CAMPOS                           *}
{****************************************RL*}
function TfrmGarantiaRetFornecedor.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA FORNECEDOR                     *}
    {**************************************RL*}
    If Sender = edtCodFor Then
    Begin

      If fEmptyStr(edtCodFor.Text) Then
      Begin
        If Not blnPermiteCarregarXML Then
        begin
          fMensagem('ATENÇÃO!', 'O fornecedor deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
      End

      Else
      Begin

        edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);

        If fEmptyStr(edtNomFor.Text) Then
        Begin
          fMensagem('AVISO','Fornecedor não encontrado!', ['&OK']);
          pSetFocus(edtCodFor);
          Result := False;
        End
        Else
        If (untFuncoesSimples.fCadFor('STATUS', edtCodFor.Text) <> 'A') Then
        Begin
          fMensagem('ATENÇÃO!', 'O fornecedor esta inativo!' , ['&Ok']);
          Result := False;
        End;

      End;

    End

    {***********************}
    {* VALIDA DATA INICIAL *}
    {********************RL*}
    Else If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(recNotEle.strAutInc) Then
      begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&Ok']);
          Result := False;
        End;
      end;

    End

    {*********************}
    {* VALIDA DATA FINAL *}
    {******************RL*}
    Else If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(recNotEle.strAutInc) Then
      begin

        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','A data final deve ser preenchida!', ['&Ok']);
          Result := False;
        End

        Else If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!','A data inicial deve ser menor que a data final!',['&OK']);
          Result := False;
        End;
      End;

    End

    {**************************}
    {* VALIDA MOTIVO DA BAIXA *}
    {***********************PZ*}
    Else If (Sender = dbeMotivo) And (dbeMotivo.Visible) And (dbeMotivo.Enabled) Then
    Begin
      If (fEmptyStr(dbeMotivo.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','O motivo deve ser informado!',['O K']);
        Result := False;
      End;

    End;

  End;

  If Not (Result) Then
    pSetFocus(Sender);

End;

procedure TfrmGarantiaRetFornecedor.dbgProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (Key = '-') Then
    Key := #0;

end;

procedure TfrmGarantiaRetFornecedor.btnMarcaDesmarcaItemClick(Sender: TObject);
begin
  inherited;
  if cdsProdutosSELECIONADO.AsString = REG_SELECIONADO then
    pMarcaDesmarca(TenuTipoMarcacaoRegistro.Desmarcar)
  else
    pMarcaDesmarca(TenuTipoMarcacaoRegistro.Marcar);
end;

procedure TfrmGarantiaRetFornecedor.btnMarcaDesmarcaTodosClick(Sender: TObject);
  Var
    enuTipoMarcacao: TenuTipoMarcacaoRegistro;
begin
  inherited;
  if TWinControl(Sender).Tag = 1 then
  begin
    enuTipoMarcacao := TenuTipoMarcacaoRegistro.Desmarcar;
    TWinControl(Sender).Tag := 0;
  end
  else
  begin
    enuTipoMarcacao := TenuTipoMarcacaoRegistro.Marcar;
    TWinControl(Sender).Tag := 1;
  end;
  pMarcaDesmarca(enuTipoMarcacao, True);
end;

procedure TfrmGarantiaRetFornecedor.btnNotEleClick(Sender: TObject);
var
  chrKey: Char;
  arrPreNota: TConsultasArray;
begin
  chrKey := '/';
  FillChar(recNotEle, SizeOf(recNotEle), #0);
  if fPesqGereleDigPedido(Self, Nil, Nil, recNotEle, chrKey, arrPreNota, True, xmlCFG_IMPXGRGarantiaRetFornecedor) then
  begin
    if Not fEmptyStr(recNotEle.strAutInc) then
      pCarregaNFE;
  end;
end;

procedure TfrmGarantiaRetFornecedor.btnRefugoTotalClick(Sender: TObject);
begin
  inherited;
  if fConfirmarMarcacaoTotal(TenuTipoMarcacaoRegistro.RefugoTotal) then
    pMarcaDesmarca(TenuTipoMarcacaoRegistro.RefugoTotal, True);
end;

procedure TfrmGarantiaRetFornecedor.onCdsItemNFAfterScroll(DataSet: TDataSet);
begin
  cdsProdutos.DisableControls;
  cdsProdutos.Filtered := False;
  cdsProdutos.Filter := 'CODITE = '+ QuotedStr(DataSet.FieldByName('ITE_CODITE').AsString);
  cdsProdutos.Filtered := True;
  cdsProdutos.EnableControls;

end;

procedure TfrmGarantiaRetFornecedor.btnRetornoTotalClick(Sender: TObject);
begin
  inherited;
  if fConfirmarMarcacaoTotal(TenuTipoMarcacaoRegistro.BaixaRetornoTotal) then
    pMarcaDesmarca(TenuTipoMarcacaoRegistro.BaixaRetornoTotal, True);
end;

procedure TfrmGarantiaRetFornecedor.cdsProdutosAfterCancel(DataSet: TDataSet);
begin
  inherited;
  blnAlterouRetorno := False;
  pAtualizaGridItensNFE;
end;

procedure TfrmGarantiaRetFornecedor.pAtualizaGridItensNFE;
begin

  If (Not blnCarregando) And  (Not fEmptyStr(recNotEle.strAutInc)) Then
  begin
    cdsItensNFe.Edit;
    If cdsProdutosAGG_QTDRET_1.Value <> null Then
      cdsItensNFe.FieldByName('ITE_QTDRET').ASFloat := cdsProdutosAGG_QTDRET_1.Value;
    If cdsProdutosAGG_QTDREF_1.Value <> null Then
      cdsItensNFe.FieldByName('ITE_QTDREF').ASFloat := cdsProdutosAGG_QTDREF_1.Value;

    If (cdsItensNFe.FieldByName('ITE_QTDXML').AsFloat -
        cdsItensNFe.FieldByName('ITE_QTDRET').AsFloat -
        cdsItensNFe.FieldByName('ITE_QTDREF').AsFloat) = 0 Then
      cdsItensNFe.FieldByName('DIVERGENTE').AsString := 'N'
    Else
      cdsItensNFe.FieldByName('DIVERGENTE').AsString := 'S';

    cdsItensNFe.Post;
  End;

End;

procedure TfrmGarantiaRetFornecedor.cdsProdutosAfterPost(DataSet: TDataSet);
begin
  inherited;
  blnAlterouRetorno := False;
  pAtualizaGridItensNFE;
end;

procedure TfrmGarantiaRetFornecedor.cdsProdutosAfterScroll(
  DataSet: TDataSet);
begin
  inherited;

  If (cdsProdutosITEFRA.AsString = 'N') Then
    dbgProdutoDBBandedTableViewCitel1.OnKeyPress := pTravaItemFracionadoKey
  Else
    dbgProdutoDBBandedTableViewCitel1.OnKeyPress := dbgProdutosKeyPress;
end;


procedure TfrmGarantiaRetFornecedor.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGarantiaRetFornecedor.mskDtaFinExit(Sender: TObject);
 CONST INCLUIR_CAMPO_SELECIONADO: Boolean = True;
begin
  inherited;

  {*******************************************}
  {* CARREGA PRODUTOS DO FORNECEDOR          *}
  {****************************************RL*}
  If fValidaPanel(pnlFornecedor, False) Then
    pCarregaItens;

end;

{*******************************************}
{* CARREGA TABELA DE PRODUTOS              *}
{****************************************RL*}
procedure TfrmGarantiaRetFornecedor.pCarregaItens;
 Const INCLUIR_CAMPO_SELECIONADO: Boolean = True;
begin
  cdsProdutos.DisableControls;
  Try
    cdsProdutos.EmptyDataSet;

    if Not fEmptyStr(recNotEle.strAutInc) Then
      objMovGag.objMovGad.pCarregaProdutosRetornados(edtCodFor.Text, 0, 0, INCLUIR_CAMPO_SELECIONADO, recNotEle.strAutInc)
    Else
      objMovGag.objMovGad.pCarregaProdutosRetornados(edtCodFor.Text,
                                                     StrToDate(mskDtaIni.Text),
                                                     StrToDate(mskDtaFin.Text),
                                                     INCLUIR_CAMPO_SELECIONADO);

    If objMovGag.objMovGad.qryFornec.IsEmpty Then
    Begin
      fMensagem('', 'Não existem produtos enviados para este fornecedor no período informado!', ['&Ok']);
      pSetFocus(edtCodFor);
    End
    Else
    Begin
      pCarregaTabelaProdutos(objMovGag.objMovGad.qryFornec, cdsProdutos);
      pSetFocus(dbgProduto);
    End;

    objMovGag.objMovGad.qryFornec.Close;

  finally
    cdsProdutos.EnableControls;
  End;

end;

procedure TfrmGarantiaRetFornecedor.pCarregaNFE;
begin
  blnCarregando := True;
  Try
    cxItens.Visible := True;
    pnlItensNfe.Visible := True;
    splSeparador.Visible := True;
    pnlItensNfe.Top := 0;
    pnlItensNfe.Height := 170;
    splSeparador.Top := 100;


    If Assigned(cdsItensNFe) Then
      FreeAndNil(cdsItensNFe);

    cdsItensNFe := TZClient.Create(nil, fGetSQLItensNFEXml);
    cdsItensNFe.fAbreClient(False, 'TfrmGarantiaRetFornecedor.pCarregaNFE');
    dtsitensNf.DataSet := cdsItensNFe;


    edtNotEle.Text := cdsItensNFe.FieldByName('DOCUMENTO').AsString;
    edtCodFor.Text := cdsItensNFe.FieldByName('GER_CODFOR').AsString;
    fValidaCampos(edtCodFor);

    mskDtaIni.Clear;
    mskDtaFin.Clear;

    dbgProdutoDBBandedTableViewCitel1.OptionsView.Footer := True;
    pCarregaItens;

    cdsItensNFe.AfterScroll := onCdsItemNFAfterScroll;
    cdsItensNFe.First;

    btnMarcaDesmarcaItem.Visible := False;
    btnMarcaDesmarcaTodos.Visible := False;
    pnlFornecedor.Enabled := False;

  finally
    blnCarregando := False;
  end;
end;

{*******************************************}
{* CARREGA TABELA DE PRODUTOS              *}
{****************************************RL*}
procedure TfrmGarantiaRetFornecedor.pCarregaTabelaProdutos(
  qryFornec: TUniQuery; cdsProdutos: TUniClientDataSet);
begin

  cdsProdutos.EmptyDataSet;

  With qryFornec Do
  Begin

    While Not Eof Do
    Begin

      cdsProdutos.Append;
      cdsProdutos.FieldByName('SELECIONADO').AsString   := REG_NAO_SELECIONADO;
      cdsProdutos.FieldByName('AUTINC').AsString   := FieldByName('AUTINC').AsString;
      cdsProdutos.FieldByName('INCGAE').AsString   := FieldByName('INCGAE').AsString;
      cdsProdutos.FieldByName('INCGAG').AsString   := FieldByName('INCGAG').AsString;
      cdsProdutos.FieldByName('NUMENT').AsString   := FieldByName('NUMENT').AsString;
      cdsProdutos.FieldByName('CODITE').AsString   := FieldByName('CODITE').AsString;
      cdsProdutos.FieldByName('DESITE').AsString   := FieldByName('DESITE').AsString;
      cdsProdutos.FieldByName('REFERE').AsString   := FieldByName('REFERE').AsString;
      cdsProdutos.FieldByName('UNIDAD').AsString   := FieldByName('UNIDAD').AsString;
      cdsProdutos.FieldByName('ITEFRA').AsString   := FieldByName('ITEFRA').AsString;
      cdsProdutos.FieldByName('QTDREQ').AsFloat    := FieldByName('QTDREQ').AsFloat;
      cdsProdutos.FieldByName('QTDRET').AsFloat    := FieldByName('QTDRET').AsFloat;
      cdsProdutos.FieldByName('QTDREF').AsFloat    := FieldByName('QTDREF').AsFloat;
      cdsProdutos.FieldByName('QTDRET_1').AsFloat  := 0;
      cdsProdutos.FieldByName('QTDREF_1').AsFloat  := 0;
      cdsProdutos.FieldByName('CODVEN').AsString   := FieldByName('CODVEN').AsString;
      cdsProdutos.FieldByName('CODCLI').AsString   := FieldByName('CODCLI').AsString;
      cdsProdutos.FieldByName('CODFOR').AsString   := FieldByName('CODFOR').AsString;
      cdsProdutos.FieldByName('OBSF_1').AsString   := FieldByName('OBSF_1').AsString;
      cdsProdutos.FieldByName('OBSF_2').AsString   := FieldByName('OBSF_2').AsString;
      cdsProdutos.FieldByName('OBSF_3').AsString   := FieldByName('OBSF_3').AsString;
      cdsProdutos.FieldByName('OBSF_4').AsString   := FieldByName('OBSF_4').AsString;
      cdsProdutos.FieldByName('OBSF_5').AsString   := FieldByName('OBSF_5').AsString;
      cdsProdutos.FieldByName('MOTIVO').AsString   := FieldByName('MOTBAI').AsString;
      cdsProdutos.FieldByName('NUMENV').AsString   := FieldByName('NUMENV').AsString;
      cdsProdutos.FieldByName('VALITE').AsFloat    := FieldByName('VALITE').AsFloat;
      cdsProdutos.FieldByName('VALUNT').AsFloat    := FieldByName('VALUNT').AsFloat;
      If fCfgSis('GARMAT', varBoolean) Then
        cdsProdutos.FieldByName('NUMPED').AsString   := FieldByName('NUMPED').AsString;

      cdsProdutos.FieldByName('CODFAB').AsString    := FieldByName('CODFAB').AsString;

      cdsProdutos.FieldByName('CODBAR').AsString   := FieldByName('CODBAR').AsString;
      cdsProdutos.FieldByName('BAREMB').AsString   := FieldByName('BAREMB').AsString;

      IF Assigned(FindField('QTDSKU')) then
        cdsProdutos.FieldByName('QTDSKU').AsInteger  := FieldByName('QTDSKU').AsInteger;

      cdsProdutos.Post;

      Next;
    End;

  End;

  cdsProdutos.First;

end;

procedure TfrmGarantiaRetFornecedor.pDesabilitarRefugo;
begin
  btnRefugoTotal.Visible := False;
  dbgProdutoViewQTDREF_1.Options.Editing := False;
end;

procedure TfrmGarantiaRetFornecedor.FormCreate(Sender: TObject);
begin
  inherited;
  blnCarregando := false;

  pnlFornecedor.Height := 32;
  blnPermiteCarregarXML := fCfgSis('IMPXGR', varBoolean);
  FblnUsuarioTemPermissaoEnviarRefugo := fVerificaAcessoSistema(DIRACE_PERMITIR_ENVIAR_REFUGO, strLoginUsuarioLogado);
  pSetaCodIte(cdsProdutosCODITE);

  cdsProdutos.FieldDefs[0].Size := fTamCodIte;

  objMovGag := TMovGag.Create(Self);

  objLiberacao := TLiberacao.Create;

  cdsProdutos.CreateDataSet;

  cdsGroup           := TUniClientDataSet.Create(Self);
  cdsGroup.FieldDefs := cdsProdutos.FieldDefs;
  cdsGroup.CreateDataSet;

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);

  fatVenda := TFatVenda.CreateInstance('');
  fatVenda.strOpcDocTrue := 'NR';
  blnAlterouRetorno := False;
  strCtaCre := fConverteCentroCusto(fCfgSisL('CTAGAR'));
  strPorGRF := fCfgSis('PORGRF', varString);

  blnBaixar := (fVerificaAcessoSistema('BAIGAR') And (fMensagem('','OPÇÃO',['RETORNO','BAIXA']) = 2));

  FstrChaveGrid := fRetStrChaveGrid;

  objCfgGrid := TCfgGrid.Create(Self,
                                dbgProdutoDBBandedTableViewCitel1,
                                FstrChaveGrid,
                                []{ColunasWidth},
                                strLoginUsuarioLogado,
                                False{blnExibirTodos: Boolean = False},
                                False {blnApllyBestFit},
                                [] {ArrCamposCfg: TArrCamposCfg},
                                True{blnAjustarPosicoes});

  TSalvaConfiguracaoGrid.pCarregaConfiguracoesGrid(dbgProdutoDBBandedTableViewCitel1, FstrChaveGrid);
  dbgProdutoDBBandedTableViewCitel1.OptionsView.Footer := False;

  pCriarCdsFornecdoresitem;
  cxEditButtonItemVisible.Properties.OnButtonClick := dbgProdutoViewCODFABPropertiesButtonClick;
  cxEditButtonItemInvisible.Properties.Buttons[0].Free;
end;

procedure TfrmGarantiaRetFornecedor.FormDestroy(Sender: TObject);
begin
  if Assigned(FcdsFornecedoresItem) then
    FreeAndNil(FcdsFornecedoresItem);
  inherited;

end;
procedure TfrmGarantiaRetFornecedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  TSalvaConfiguracaoGrid.pSalvaConfiguracoesGrid(dbgProdutoDBBandedTableViewCitel1, FstrChaveGrid);

  inherited;

  cdsProdutos.Close;
  FreeAndNil(fatVenda);
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
end;


{*******************************************}
{* HABILITA / DESABILITA EDITS DE OBS.     *}
{****************************************RL*}
procedure TfrmGarantiaRetFornecedor.pHabilitaOBS;
begin

  If (Not blnBaixar) Then
  Begin
    If (cdsProdutos.FieldByName('QTDREF_1').AsFloat > 0) Then
    Begin
      dbeObsF_1.Enabled := True;
      dbeObsF_1.Color   := clWhite;
      dbeObsF_2.Enabled := True;
      dbeObsF_2.Color   := clWhite;
      dbeObsF_3.Enabled := True;
      dbeObsF_3.Color   := clWhite;
      dbeObsF_4.Enabled := True;
      dbeObsF_4.Color   := clWhite;
      dbeObsF_5.Enabled := True;
      dbeObsF_5.Color   := clWhite;
    End
    Else
    Begin
      dbeObsF_1.Enabled := False;
      dbeObsF_1.Color   := $00FFDFB8;
      dbeObsF_2.Enabled := False;
      dbeObsF_2.Color   := $00FFDFB8;
      dbeObsF_3.Enabled := False;
      dbeObsF_3.Color   := $00FFDFB8;
      dbeObsF_4.Enabled := False;
      dbeObsF_4.Color   := $00FFDFB8;
      dbeObsF_5.Enabled := False;
      dbeObsF_5.Color   := $00FFDFB8;
    End;
  End
  Else
  Begin
    If (cdsProdutos.FieldByName('QTDRET_1').AsFloat > 0) Then
    Begin
      dbeMotivo.Enabled := True;
      dbeMotivo.Color   := clWhite;
    End
    Else
    Begin
      dbeMotivo.Enabled := False;
      dbeMotivo.Color   := $00FFDFB8;
    End;
  End;

end;

procedure TfrmGarantiaRetFornecedor.dbeObsF_5Exit(Sender: TObject);
begin
  inherited;

  If cdsProdutos.State = dsEdit Then
    cdsProdutos.Post;

  pSetFocus(dbgProduto);

end;

procedure TfrmGarantiaRetFornecedor.dtsProdutosDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;

  pHabilitaOBS;

  If (cdsProdutos.FieldByName('QTDRET_1').Value > 0) Or
    (cdsProdutos.FieldByName('QTDREF_1').Value > 0) Then
    btnConfirmar.Enabled := True
  Else
    btnConfirmar.Enabled := False;

end;

{*******************************************}
{* CONFIRMA RETORNO DO PRODUTO             *}
{****************************************RL*}
procedure TfrmGarantiaRetFornecedor.btnConfiguraDadosAtuaisClick(
  Sender: TObject);
begin
  inherited;
  objCfgGrid.pConfiguraColunas;
end;

procedure TfrmGarantiaRetFornecedor.btnConfirmarClick(Sender: TObject);
  Var
    strNumEnt,
    strNumEnv,
    strChaveSEQGAG: String;
    fltValDup: Double;
    frmFatDigPrecoCusto : TfrmFatDigPrecoCusto;
    bmkMarca: TBookmark;
    cTotal: Currency;
    blnGravarCredito : Boolean;
begin
  inherited;
  strNumDocEnt    := '';
  blnConfirma     := True;
  blnGravarCredito := False;
  fltValDup := 0;

  If cdsProdutos.State = dsEdit Then
    cdsProdutos.Post;

  If Not fVerificaCampos Then
    Exit;

  If Not fTodosItemNfeAtendido then
  Begin
    pMensagemOk('Verifique os itens com divergência entre a quantidade da nota e as garantias.');
    Exit;
  End;

  If (blnBaixar) Then
  Begin
    If fMensagem('', 'Confirma a baixa dos produtos selecionados enviados para o fornecedor?', ['&Sim', '&Não']) = 2 Then
      Exit;
  End
  Else
  Begin
    If fMensagem('', 'Confirma o retorno dos produtos selecionados enviados para o fornecedor?', ['&Sim', '&Não']) = 2 Then
      Exit;
  End;

  Try
    cdsProdutos.DisableControls;
    cdsProdutos.Filtered := False;
    cdsProdutos.Filter   := ' SELECIONADO = ''1'' AND ((QTDRET_1 > 0) OR (QTDREF_1 > 0))';
    cdsProdutos.Filtered := True;

    Try

      If (Not blnBaixar) Then
      Begin
        Try
          {************************************************************}
          {* SALVA AS QUANTIDADES DE RETORNO QUE SERÃO                *}
          {* ADICIONADAS À TABELA TEMPORÁRIA DA ENTRADA DE DOCUMENTOS *}
          {************************************************************}
          If (not fCfgSis('REFENT', varBoolean)) And (fSoRefugo) Then
          Begin

             fStartTransaction();
             objMovGag.objMovGad.pAtualizaProdutoRetornados(cdsProdutos, strNumRet, False, True);
             //Baixa Qtde em Refugo.
             pBaixaPedidos(True);
             pAtualizaTotais();
             pBaixaNotaEletronica(strNumRet);
             fCommit();

             If Not fImprimirControleGarantia(strNumRet, 'GR', edtCodFor.Text, nil, TZClient(cdsProdutos)) Then
               pImprimeDocumento;
          End
          Else
          Begin

            cdsProdutos.First;
            while Not(cdsProdutos.Eof) do
            Begin
              If strChaveSEQGAG <> '' Then
              Begin
                strChaveSEQGAG:= strChaveSEQGAG+',';
                strChaveSEQGAG:= strChaveSEQGAG + '"'+cdsProdutos.FieldByName('INCGAG').AsString+'"';
              End
              Else
              Begin
                strChaveSEQGAG:= strChaveSEQGAG + '"'+cdsProdutos.FieldByName('INCGAG').AsString+'"';
              End;
              cdsProdutos.Next;
            End;

            objMovGag.objMovGad.pAtualizaProdutoRetornados(cdsProdutos, strNumRet, False, True);
            try
              If not (fEntradaNF(strNumDocEnt, strEspDocEnt, edtCodFor.Text, strChaveSEQGAG)) Then
              Begin
                objMovGag.objMovGad.pApagaMovGau;
                Exit;
              End
              Else
                pBaixaNotaEletronica(strNumDocEnt);
            except
              On E: Exception Do
              begin
                objMovGag.objMovGad.pApagaMovGau;
                raise E;
              end;
            end;

          End;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message,'[TfrmGarantiaRetFornecedor.btnConfirmarClick_1]');
          End;
        End;
      End
      Else
      Begin
        If (fEmptyStr(strCtaCre)) Then
        Begin
          fMensagem('ATENÇÃO!','O Plano de Contas para geração de crédito para o fornecedor não está configurada!' + #13#10 +
                               '"CFG_CTAGAR" - ABA "GARANTIA".', ['&O k']);
          Exit;
        End;

        If (fEmptyStr(strPorGRF)) Then
        Begin
          fMensagem('ATENÇÃO!','O Portador para geração de crédito para operação de "Retorno do Fornecedor" não está configurado!' + #13#10 +
                    '"CFG_PORGRF" - ABA "GARANTIA".', ['&O k']);
          Exit;
        End;


        If fMensagem('ATENÇÃO!', 'Confirma Lançamento de Crédito?', ['&Sim', '&Não']) = 1 Then
        Begin

          Try
            pCriarFormularios(TfrmFatDigPrecoCusto, frmFatDigPrecoCusto);

            bmkMarca := cdsProdutos.GetBookmark;
            cdsProdutos.DisableControls;
            cTotal:= 0;
            cdsProdutos.First;
            while Not(cdsProdutos.Eof) do
            Begin

              cTotal:= cTotal + cdsProdutos.FieldByName('VALUNT').AsCurrency * cdsProdutosQTDRET_1.AsCurrency;
              cdsProdutos.Next;
            End;

            frmFatDigPrecoCusto.tvTipoValor        := tvCreditoFornecedor;
            frmFatDigPrecoCusto.edtPreCus.Text     := FormatFloat('#,#0.00', cTotal);;
            frmFatDigPrecoCusto.strValor           := FormatFloat('#,#0.00', cTotal);;
            frmFatDigPrecoCusto.blnGarantia        := True;

            frmFatDigPrecoCusto.tvTipoValor := tvCreditoFornecedor;

            frmFatDigPrecoCusto.ShowModal;
            fltValDup := fStrToFloat(frmFatDigPrecoCusto.edtPreCus.Text);
          Finally
            cdsProdutos.GotoBookmark(bmkMarca);
            cdsProdutos.FreeBookmark(bmkMarca);
            cdsProdutos.EnableControls;
          End;
          objLiberacao.Clear;

          pGetNumDocsGarAndDocsEnvAndCre(strNumEnt, strNumEnv, fltValDup);

          objLiberacao.strDirAce := 'SENBAI';
          objLiberacao.strSenLib := fCfgSis('SENBAI');
          objLiberacao.strMsgSen := 'Liberação de crédito Fornecedor(Garantia)';
          objLiberacao.strCodOpe := strLoginUsuarioLogado;
          objLiberacao.strCodDig := strLoginUsuarioLogado;

          If (Not fatVenda.fFatMensagemLiberacao(objLiberacao)) Then
            Exit
          Else
            blnGravarCredito := True;

        End;

        if blnGravarCredito then
          fGravaCreditoFornecedor(edtCodFor.Text, strCtaCre, strNumEnt, strNumEnv, strPorGRF, fltValDup);

        objMovGag.objMovGad.pAtualizaProdutoRetornados(cdsProdutos, '', True, True);
        pBaixaPedidos(False);

        pAtualizaTotais();
        fCommit();

      End;


      If blnBaixar Then
      Begin
        If Not fImprimirControleGarantia(strNumRet,  'GR', edtCodFor.Text, nil, TZClient(cdsProdutos), blnBaixar) Then
            pImprimeDocumento;
      End;

      If strNumDocEnt <> '' then
      Begin
        If Not fImprimirControleGarantia(strNumDocEnt, strEspDocEnt, edtCodFor.Text, nil, TZClient(cdsProdutos), false, tpeContGR) Then
          pImprimeDocumento;
      End;

      pFreeAndNil(frmFatDigPrecoCusto);
      edtCodFor.Clear;
      edtNomFor.Clear;
      cdsProdutos.EmptyDataSet;
      pnlFornecedor.Enabled := True;
      if Not fEmptyStr(recNotEle.strAutInc) Then
      begin
        pnlItensNfe.Visible := False;
        splSeparador.Visible := False;
        edtNotEle.Text := '';
        FillChar(recNotEle, SizeOf(recNotEle), #0);
        FreeAndNil(cdsItensNFe);
      End;
      pSetFocus(edtCodFor);

    Except
      On E: Exception Do
      begin
        fRollBack;
        pMensagensErro(E.Message,'[TfrmGarantiaRetFornecedor.btnConfirmarClick_3]');
      end;
    End;

  Finally
    cdsProdutos.Filtered := False;
    cdsProdutos.EnableControls;
    cdsProdutos.Last;
    blnConfirma := False;
  End;
end;

procedure TfrmGarantiaRetFornecedor.pAtualizaTotais();
begin
   {************************************************************}
   {* ATUALIZA O NÚMERO E ESPÉCIE DO DOCUMENTO DE RETORNO      *}
   {************************************************************}
   cdsProdutos.Filtered := False;
   cdsProdutos.Filter   := ' SELECIONADO = ''1'' AND ((QTDRET_1 > 0) OR (QTDREF_1 > 0)) ';
   cdsProdutos.Filtered := True;

   objMovGag.objMovGad.pAtualizaProdutoRetornados(cdsProdutos, strNumRet, blnBaixar)
end;

procedure TfrmGarantiaRetFornecedor.pBaixaNotaEletronica(ANumRet: String);
var qryGerele: TUniQuery;
begin
  If Not fEmptyStr(recNotEle.strAutInc)  Then
  Begin
    qryGerele := fCriaQuery;
    Try
      qryGerele.SQL.Text := 'UPDATE GERELE SET GER_DOCENT = "'+ANumRet+'" WHERE AUTOINCREM = "'+recNotEle.strAutInc+'"';
      qryGerele.ExecSQL;
    Finally
      FreeAndNil(qryGerele)
    End;

  End;
end;

procedure TfrmGarantiaRetFornecedor.pBaixaPedidos(blnRefugo : Boolean);
  Var
    oleItensPedidos : OleVariant;
    blnResult       : Boolean;

    cdsTmpItens     : TUniClientDataSet;
    cdsPedidos      : TUniClientDataSet;

Begin
(*  If Not fCfgSis('GARMAT',varBoolean) Then
    Exit; toda envio esta gravando pedido *)

  Try
    cdsPedidos  := TUniClientDataSet.Create(Self);
    cdsTmpItens := TUniClientDataSet.Create(Self);

    With cdsTmpItens.FieldDefs.AddFieldDef Do
    Begin
      Name := 'AUTOINCREM';
      DataType := ftString;
      Size := 20;
    End;

    With cdsTmpItens.FieldDefs.AddFieldDef Do
    Begin
      Name := 'ENT_CODITE';
      DataType := ftString;
      Size := fTamCodIte;
    End;

    With cdsTmpItens.FieldDefs.AddFieldDef Do
    Begin
      Name := 'ENT_PERIPI';
      DataType := ftFloat;
    End;

    With cdsTmpItens.FieldDefs.AddFieldDef Do
    Begin
      Name := 'ENT_PERSUB';
      DataType := ftFloat;
    End;

    cdsTmpItens.CreateDataSet;

    cdsProdutos.Filtered := False;

    If blnRefugo Then
      cdsProdutos.Filter   := '(QTDREF_1 > 0)'
    Else
      cdsProdutos.Filter   := '(QTDRET_1 > 0)';

    cdsProdutos.Filtered := True;
    cdsProdutos.First;

    While Not cdsProdutos.Eof Do
    Begin
      cdsTmpItens.Insert;
      cdsTmpItens.FieldByName('ENT_CODITE').AsString := cdsProdutos.FieldByName('CODITE').AsString;
      cdsTmpItens.FieldByName('ENT_PERSUB').AsFloat  := 0;
      cdsTmpItens.FieldByName('ENT_PERIPI').AsFloat  := 0;
      If not blnRefugo Then
        cdsTmpItens.FieldByName('AUTOINCREM').AsString := fCampoTabela('AUTOINCREM','MOVDET', ['DET_NUMDOC', 'DET_ESPDOC', 'DET_CODEMP', 'DET_CODFOR'], [strNumDocEnt, strEspDocEnt, VS_strCodEmp, edtCodFor.Text])
      Else
        cdsTmpItens.FieldByName('AUTOINCREM').AsString := '';

      cdsTmpItens.Post;

      cdsProdutos.Next;
    End;

    oleItensPedidos := fDefinePedidosABaixarGarantia(blnResult,
                                                     cdsTmpItens,
                                                     fCfgSis('CNVEMB'),
                                                     IIF(blnRefugo, True, False),
                                                     IIF(blnRefugo, False, True));

    If oleItensPedidos <> Null Then
    Begin
      cdsPedidos.Data := oleItensPedidos;
      cdsPedidos.IndexFieldNames := 'NUMPED;CODEMP;CODITE';
      cdsPedidos.Filtered := False;
      cdsPedidos.First;
    End;

    fBaixaPedidos(oleItensPedidos, cdsPedidos, False);

  Finally
    FreeAndNil(cdsTmpItens);
    FreeAndNil(cdsPedidos);
  End;

End;

procedure TfrmGarantiaRetFornecedor.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case key of
    VK_F10:
      begin
        if btnConfirmar.Enabled then
        begin
          key := 0;
          btnConfirmar.Click;
        end;
      end;
    VK_F5: btnMarcaDesmarcaItem.Click;
    VK_F6: btnMarcaDesmarcaTodos.Click;
    VK_F8: btnRetornoTotal.Click;
    VK_F9:
      begin
        if btnRefugoTotal.Visible then
          btnRefugoTotal.Click;
      end;
  end;

end;

procedure TfrmGarantiaRetFornecedor.pEscapePressed;
begin

  If (dbeObsF_1.Enabled) And ((ActiveControl) <> edtCodFor) Then
    pSetFocus(dbgProduto)
  Else
    inherited;

end;

procedure TfrmGarantiaRetFornecedor.cdsProdutosBeforePost(
  DataSet: TDataSet);

  Function fTestaRetorno: Boolean;
  Begin
    With DataSet Do
    Begin
      If DataSet.FieldByName('QTDRET_1').AsFloat > Abs(FieldByName('QTDREQ').AsFloat -
                                           FieldByName('QTDRET').AsFloat -
                                           FieldByName('QTDREF').AsFloat -
                                           FieldByName('QTDREF_1').AsFloat) Then
      Begin
        FieldByName('QTDRET_1').AsFloat := 0;
        Result := False;
        fMensagem('ATENÇÃO', 'Quantidade de retorno maior que a permitida!', ['&Ok']);

        dbgProdutoViewQTDRET_1.Selected:= True;

      End Else
        Result := True;
    End;

  End;

  Function fTestaRefugo: Boolean;
  Begin
    With DataSet Do
    Begin
      If FieldByName('QTDREF_1').AsFloat > Abs(FieldByName('QTDREQ').AsFloat -
                                           FieldByName('QTDRET').AsFloat -
                                           FieldByName('QTDREF').AsFloat -
                                           FieldByName('QTDRET_1').AsFloat) Then
      Begin
        FieldByName('QTDREF_1').AsFloat := 0;
        Result := False;
        fMensagem('ATENÇÃO', 'Quantidade de refugo maior que a permitida!', ['&Ok']);

        If (ActiveControl) <> dbgProduto Then
          pSetFocus(dbgProduto);


        dbgProdutoViewQTDREF_1.Selected:= True;

      End Else
        Result := True;
    End;
  End;

  Procedure pVeSeLimpaObs;
  Begin
    With DataSet Do
    If FieldByName('QTDREF_1').AsFloat = 0 Then
    Begin
      FieldByName('OBSF_1').Clear;
      FieldByName('OBSF_2').Clear;
      FieldByName('OBSF_3').Clear;
      FieldByName('OBSF_4').Clear;
      FieldByName('OBSF_5').Clear;
    End;
  End;
  Var
    blnResult: Boolean;
    blnSelecionado, blnRetornando: Boolean;
    objProdutosSelecionado: TField;
begin
  inherited;

  If dbgProdutoViewQTDREF_1.Selected Then
    blnResult := fTestaRefugo And fTestaRetorno
  Else
    blnResult := fTestaRetorno And fTestaRefugo;

  if blnResult then
    pVeSeLimpaObs;

  if (DataSet.State = dsInsert) or ((DataSet.State = dsEdit) and (Not blnResult)) then
    exit;


  If (Not blnAlterouRetorno ) then
    Exit;

  objProdutosSelecionado := DataSet.FieldByName('SELECIONADO');
  blnSelecionado := objProdutosSelecionado.AsString = REG_SELECIONADO;
  blnRetornando := (DataSet.FieldByName('QTDREF_1').AsFloat > 0) or (DataSet.FieldByName('QTDRET_1').AsFloat > 0);

  If blnSelecionado and (Not blnRetornando) then
    objProdutosSelecionado.AsString := REG_NAO_SELECIONADO
  else if (Not blnSelecionado) and blnRetornando then
    objProdutosSelecionado.AsString := REG_SELECIONADO;

end;

procedure TfrmGarantiaRetFornecedor.cdsProdutosQTDREF_1Validate(Sender: TField);
begin
  inherited;
  blnAlterouRetorno := cdsProdutos.State = dsEdit;
end;

procedure TfrmGarantiaRetFornecedor.cdsProdutosQTDRET_1Validate(Sender: TField);
begin
  inherited;
  blnAlterouRetorno := cdsProdutos.State = dsEdit;

end;

procedure TfrmGarantiaRetFornecedor.cxvItensCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If VarToStrDef(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  cxvItensDIVERGENTE.Index], 'S') <> 'S' Then
    ACanvas.Brush.Color := clMoneyGreen
  Else
    ACanvas.Brush.Color := Shape2.Brush.Color
end;

procedure TfrmGarantiaRetFornecedor.dbgProdutoDBBandedTableViewCitel1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If Not cdsProdutos.Active Or cdsProdutos.IsEmpty Then
    Exit;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgProdutoViewSELECIONADO.Index]) = '1' Then
    If (AViewInfo.Selected) AND (cdsProdutos.State <> dsEdit) And
      ((ActiveControl) = dbgProduto) Then
      ACanvas.Font.Color := clRed
    Else
      ACanvas.Font.Color := clBlue;


  If (TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName = 'QTDRET_1') Or
     (TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName = 'QTDREF_1') Then
  Begin
    ACanvas.Brush.Color:= clInfoBk;
    ACanvas.Font.Color := clBlack;
  End;


end;

procedure TfrmGarantiaRetFornecedor.dbgProdutoDBBandedTableViewCitel1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = Vk_Return) Then
  Begin

    If ((Not(dbgProdutoViewQTDRET_1.Focused)) and (Not(dbgProdutoViewQTDREF_1.Focused))) Then
      dbgProdutoViewQTDRET_1.Focused:= True;

    If (cdsProdutos.State <> dsEdit) Then
    Begin
      dbgProdutoViewQTDRET_1.Focused := True;
      cdsProdutos.Edit;
    End
    Else
    Begin
      If (Not blnBaixar) Then
      Begin

        If dbgProdutoViewQTDRET_1.Focused Then
        Begin
          cdsProdutos.Post;
          cdsProdutos.Edit;
          dbgProdutoViewQTDREF_1.Focused := True;
        End

        Else If dbgProdutoViewQTDREF_1.Focused Then
        Begin

          dbgProdutoViewQTDRET_1.Focused := True;

          cdsProdutos.Post;

          pHabilitaOBS;

          If dbeObsF_1.Enabled Then
          Begin
            cdsProdutos.Edit;
            pSetFocus(dbeObsF_1);
          End;

        End;

      End
      Else
      Begin
        cdsProdutos.Post;
        cdsProdutos.Edit;
        pHabilitaOBS;
        If dbeMotivo.Enabled Then
          pSetFocus(dbeMotivo);
      End;

    End;

  End

  Else If Key = Vk_Escape Then
    pSetFocus(edtCodFor);
end;

procedure TfrmGarantiaRetFornecedor.dbgProdutoDBBandedTableViewCitel1KeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
 If (Key = '-') Then
    Key := #0;
end;

procedure TfrmGarantiaRetFornecedor.dbgProdutoEnter(Sender: TObject);
begin
  inherited;
  pHabilitaOBS;

  If cdsProdutos.State = dsEdit Then
    cdsProdutos.Post;

  dbgProduto.Repaint;
  dbgProduto.Refresh;
  Application.ProcessMessages;
end;

procedure TfrmGarantiaRetFornecedor.dbgProdutoViewCODFABGetProperties(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  inherited;
  if ARecord.Values[dbgProdutoViewQTDSKU.Index] > 1 then
    AProperties := cxEditButtonItemVisible.Properties
  else
    AProperties := cxEditButtonItemInVisible.Properties;
end;

procedure TfrmGarantiaRetFornecedor.dbgProdutoViewCODFABPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
Var
  lRecord: TcxCustomGridRecord;
  lstrCodIte: String;
begin
  inherited;
  lRecord := dbgProdutoViewCODFAB.GridView.Controller.FocusedRecord;
  lstrCodIte := VarToStrDef(lRecord.Values[dbgProdutoViewCODITE.Index], '');

  if fEmptyStr(lstrCodIte) then
    Exit;

  if lRecord.Values[dbgProdutoViewQTDSKU.Index] <= 1 then
    Exit;

  pExibirCodigosProdutoFornecedores(cdsProdutosCODITE.AsString, edtCodFor.Text);
end;

procedure TfrmGarantiaRetFornecedor.dbgProdutoViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If Not cdsProdutos.Active Or cdsProdutos.IsEmpty Then
    Exit;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgProdutoViewSELECIONADO.Index]) = '1' Then
    If (AViewInfo.Selected) AND (cdsProdutos.State <> dsEdit) And
      ((ActiveControl) = dbgProduto) Then
      ACanvas.Font.Color := clRed
    Else
      ACanvas.Font.Color := clBlue;


  If (TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName = 'QTDRET_1') Or
     (TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName = 'QTDREF_1') Then
  Begin
    ACanvas.Brush.Color:= clInfoBk;
    ACanvas.Font.Color := clBlack;
  End;


end;

procedure TfrmGarantiaRetFornecedor.dbgProdutoViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = Vk_Return) Then
  Begin

    If ((Not(dbgProdutoViewQTDRET_1.Focused)) and (Not(dbgProdutoViewQTDREF_1.Focused))) Then
      dbgProdutoViewQTDRET_1.Focused:= True;

    If (cdsProdutos.State <> dsEdit) Then
    Begin
      dbgProdutoViewQTDRET_1.Focused := True;
      cdsProdutos.Edit;
    End
    Else
    Begin
      If (Not blnBaixar) Then
      Begin

        If dbgProdutoViewQTDRET_1.Focused Then
        Begin
          cdsProdutos.Post;
          cdsProdutos.Edit;
          dbgProdutoViewQTDREF_1.Focused := True;
        End

        Else If dbgProdutoViewQTDREF_1.Focused Then
        Begin

          dbgProdutoViewQTDRET_1.Focused := True;

          cdsProdutos.Post;

          pHabilitaOBS;

          If dbeObsF_1.Enabled Then
          Begin
            cdsProdutos.Edit;
            pSetFocus(dbeObsF_1);
          End;

        End;

      End
      Else
      Begin
        cdsProdutos.Post;
        cdsProdutos.Edit;
        pHabilitaOBS;
        If dbeMotivo.Enabled Then
          pSetFocus(dbeMotivo);
      End;

    End;

  End

  Else If Key = Vk_Escape Then
    pSetFocus(edtCodFor);

end;

procedure TfrmGarantiaRetFornecedor.dbgProdutoViewKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (Key = '-') Then
    Key := #0;
end;

procedure TfrmGarantiaRetFornecedor.edtCodForExit(Sender: TObject);
begin
  inherited;        
  If (ActiveControl) <> btnSair Then
    fValidaCampos(edtCodFor, True);
end;

procedure TfrmGarantiaRetFornecedor.mskDtaIniExit(Sender: TObject);
begin
  inherited;

  If (ActiveControl) <> btnSair Then
    fValidaCampos(mskDtaIni, True);
end;

procedure TfrmGarantiaRetFornecedor.pImprimeDocumento;
  Var
    strNomImp: String;
    strTipImp: String;
    frxDoc: TfrxReport;
Begin

  pCarregaConfImpr(qryCfgRel, Self.Name);
  strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;

  cdsProdutos.DisableControls;
  cdsProdutos.Filter   := '(QTDRET_1 > 0) OR (QTDREF_1 > 0)';
  cdsProdutos.Filtered := True;

  cdsGroup.EmptyDataSet;

  With cdsProdutos Do
  Begin
    DisableControls;
    First;

    While Not Eof Do
    Begin
      cdsGroup.Close;
      cdsGroup.Open;

      If Not cdsGroup.Locate('CODITE', FieldByName('CODITE').AsString, []) Then
      Begin
        cdsGroup.Insert;
        cdsGroup.FieldByName('AUTINC').AsString   := FieldByName('AUTINC').AsString;
        cdsGroup.FieldByName('NUMENT').AsString   := FieldByName('NUMENT').AsString;
        cdsGroup.FieldByName('CODITE').AsString   := FieldByName('CODITE').AsString;
        cdsGroup.FieldByName('DESITE').AsString   := FieldByName('DESITE').AsString;
        cdsGroup.FieldByName('REFERE').AsString   := FieldByName('REFERE').AsString;
        cdsGroup.FieldByName('UNIDAD').AsString   := FieldByName('UNIDAD').AsString;
        cdsGroup.FieldByName('ITEFRA').AsString   := FieldByName('ITEFRA').AsString;
        cdsGroup.FieldByName('QTDREQ').AsFloat    := FieldByName('QTDREQ').AsFloat;
        cdsGroup.FieldByName('QTDRET').AsFloat    := FieldByName('QTDRET').AsFloat;
        cdsGroup.FieldByName('QTDREF').AsFloat    := FieldByName('QTDREF').AsFloat;
        cdsGroup.FieldByName('QTDRET_1').AsFloat  := FieldByName('QTDRET_1').AsFloat;
        cdsGroup.FieldByName('QTDREF_1').AsFloat  := FieldByName('QTDREF_1').AsFloat;
        cdsGroup.FieldByName('CODVEN').AsString   := FieldByName('CODVEN').AsString;
        cdsGroup.FieldByName('CODCLI').AsString   := FieldByName('CODCLI').AsString;
        cdsGroup.FieldByName('CODFOR').AsString   := FieldByName('CODFOR').AsString;
        cdsGroup.FieldByName('OBSF_1').AsString   := FieldByName('OBSF_1').AsString;
        cdsGroup.FieldByName('OBSF_2').AsString   := FieldByName('OBSF_2').AsString;
        cdsGroup.FieldByName('OBSF_3').AsString   := FieldByName('OBSF_3').AsString;
        cdsGroup.FieldByName('OBSF_4').AsString   := FieldByName('OBSF_4').AsString;
        cdsGroup.FieldByName('OBSF_5').AsString   := FieldByName('OBSF_5').AsString;
        cdsGroup.FieldByName('MOTIVO').AsString   := FieldByName('MOTIVO').AsString;
        cdsGroup.FieldByName('NUMENV').AsString   := FieldByName('NUMENV').AsString;
        If fCfgSis('GARMAT', varBoolean) Then
          cdsGroup.FieldByName('NUMPED').AsString   := FieldByName('NUMPED').AsString;
        cdsGroup.Post;
      End
      Else
      Begin
        cdsGroup.Edit;
        cdsGroup.FieldByName('QTDREQ').AsFloat    := cdsGroup.FieldByName('QTDREQ').AsFloat +
                                                     FieldByName('QTDREQ').AsFloat;
        cdsGroup.FieldByName('QTDRET_1').AsFloat  := cdsGroup.FieldByName('QTDRET_1').AsFloat +
                                                     FieldByName('QTDRET_1').AsFloat;
        cdsGroup.FieldByName('QTDREF_1').AsFloat  := cdsGroup.FieldByName('QTDREF_1').AsFloat +
                                                     FieldByName('QTDREF_1').AsFloat;
        cdsGroup.Post;
      End;

      Next;
    End;

    EnableControls;
  End;

  Try
    Try

      dtsProdutos.DataSet := cdsGroup;    

      If strTipImp = 'M' Then
        frxDoc := frxDocRetornoM
      Else
        frxDoc := frxDocRetornoJ;

      frxDoc.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
      frxDoc.Script.Variables['TOTQTD'] := IntToStr(cdsProdutos.RecordCount);
      frxDoc.Script.Variables['NOMOPE'] := strDescriUsuarioLogado;
      frxDoc.Script.Variables['NOMFOR'] := Copy(edtNomFor.Text,1,25);
      frxDoc.Script.Variables['NOMFRM'] := Self.Name;
      frxDoc.Script.Variables['NUMRET'] := strNumRet;
      frxDoc.Script.Variables['DTARET'] := VS_Date;
      frxDoc.Script.Variables['BAIXAR'] := IIF(blnBaixar, 'S', 'N');

      If Not fEmptyStr(strNomImp) Then
      Begin
        frxDoc.PrintOptions.Printer    := strNomImp;
        frxDoc.PrintOptions.PrintMode  := pmDefault;
        frxDoc.PrintOptions.ShowDialog := False;

        if frxDoc.PrepareReport Then
          pPrintReport(Self.Name, 'Garantia - ' + Self.Caption, strNomImp, frxDoc);
      End
      Else
        pPreviewReport(Self.Name, 'Garantia - ' + Self.Caption, frxDoc);

    Except
      On E: Exception Do
      Begin
				pMensagensErro(E.Message,'[TfrmGarantiaRetFornecedor.pImprimeDocumento]');
      End;
    End;

  Finally
    pnlInfo.Caption := '';
    cdsProdutos.Filter   := '';
    cdsProdutos.Filtered := False;
    cdsProdutos.EnableControls;
    dtsProdutos.DataSet := cdsProdutos;
  End;

End;

procedure TfrmGarantiaRetFornecedor.pMarcaDesmarca(enuTipoMarcacao: TenuTipoMarcacaoRegistro; blnTodos: Boolean = False);
  Var
    blnCancelar: Boolean;
begin
  if cdsProdutos.State = dsEdit then
    cdsProdutos.Post;
  if cdsProdutos.IsEmpty then
    Exit;
  if blnTodos then
  begin
    Try
      blnDistribuir := False;
      FQuantidadeDistribuir:= 0;

      cdsProdutos.DisableControls;
      If fEmptyStr(recNotEle.strAutInc) Then
      begin
        cdsProdutos.Filtered := False;
        cdsProdutos.Filter := EmptyStr;
      End;

      If fEmptyStr(recNotEle.strAutInc) Then
      begin
        cdsProdutos.First;
        While Not cdsProdutos.Eof do
        begin
          pMarcaDesmarca(enuTipoMarcacao, False);
          cdsProdutos.Next;
        end;
      End
      Else
      begin
        cdsItensNFe.First;
        while not cdsItensNFe.Eof do
        Begin
          If enuTipoMarcacao in [TenuTipoMarcacaoRegistro.BaixaRetornoTotal, TenuTipoMarcacaoRegistro.RefugoTotal] Then
          begin
            blnDistribuir := True;
            FQuantidadeDistribuir:= cdsItensNFe.FieldByName('ITE_QTDXML').AsFloat;
          End;

          blnCarregando := True;
          cdsProdutos.First;
          While Not cdsProdutos.Eof do
          begin
            pMarcaDesmarca(enuTipoMarcacao, False);
            cdsProdutos.Next;
          end;
          blnCarregando := False;
          pAtualizaGridItensNFE;
          cdsItensNFe.Next;
        End;
      End;
    Finally
      If fEmptyStr(recNotEle.strAutInc)  Then
      begin
        cdsProdutos.Filtered := False;
        cdsProdutos.Filter := EmptyStr;
      End;
      cdsProdutos.First;
      cdsProdutos.EnableControls;
    End;
  end
  else begin
    blnCancelar := false;
    cdsProdutos.Edit;

    case enuTipoMarcacao of
      TenuTipoMarcacaoRegistro.Marcar :
        begin
          blnCancelar := ((cdsProdutosQTDRET_1.AsFloat = 0) and (cdsProdutosQTDREF_1.AsFloat = 0));
          if (Not blnCancelar) then
           cdsProdutosSELECIONADO.AsString := REG_SELECIONADO;
        end;

      TenuTipoMarcacaoRegistro.Desmarcar : cdsProdutosSELECIONADO.AsString := REG_NAO_SELECIONADO;

      TenuTipoMarcacaoRegistro.BaixaRetornoTotal :
        begin
          cdsProdutosQTDREF_1.AsFloat := 0;
          If blnDistribuir Then
          begin
           If FQuantidadeDistribuir >= fSaldoItem Then
           Begin
             cdsProdutosQTDRET_1.AsFloat := fSaldoItem;
             FQuantidadeDistribuir := FQuantidadeDistribuir - cdsProdutosQTDRET_1.AsFloat;
           End
           Else If fSaldoItem > FQuantidadeDistribuir Then
           begin
             cdsProdutosQTDRET_1.AsFloat := FQuantidadeDistribuir;
             FQuantidadeDistribuir := 0;
           End
           Else
             cdsProdutosQTDRET_1.AsFloat := 0;
          End
          Else
            cdsProdutosQTDRET_1.AsFloat := fSaldoItem;
        end;

      TenuTipoMarcacaoRegistro.RefugoTotal :
        begin
         cdsProdutosQTDRET_1.AsFloat := 0;
         If blnDistribuir Then
         begin
           If FQuantidadeDistribuir >= fSaldoItem Then
           Begin
             cdsProdutosQTDREF_1.AsFloat := fSaldoItem;
             FQuantidadeDistribuir := FQuantidadeDistribuir - cdsProdutosQTDREF_1.AsFloat;
           End
           Else If fSaldoItem > FQuantidadeDistribuir Then
           begin
             cdsProdutosQTDREF_1.AsFloat := FQuantidadeDistribuir;
             FQuantidadeDistribuir := 0;
           End
           Else
             cdsProdutosQTDREF_1.AsFloat := 0;

         End
         Else
            cdsProdutosQTDREF_1.AsFloat := fSaldoItem;
        end;
    end;
    if blnCancelar then
      cdsProdutos.Cancel
	else
    	cdsProdutos.Post;
  end;
end;

procedure TfrmGarantiaRetFornecedor.pTravaItemFracionadoKey(Sender: TObject;
  var Key: Char);
begin

  If CharInSet(Key, [',','.','-']) Then
    Key := #0;

end;

{*****************************************}
{* RETORNA O SEQUENCIAL DE GARANTIA PARA *}
{* O RETORNO DO DOCUMENTO DO FORNECEDOR  *}
{**************************************IV*}
{function TfrmGarantiaRetFornecedor.fRetSequencial: String;
  Var
    strSQL   : String;
    qryCadGen: TUniQuery;
begin
  Try
    qryCadGen := fCriaQuery(nil);

    Try
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   SIS_VALCFG AS VALOR ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   CFGSIS ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   SIS_CODCFG = ' + QuotedStr('CFG_PROGRF') + ' AND ';
      strSQL := strSQL + '   SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);

      With qryCadGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        If FieldByName('VALOR').IsNull Then
          strSQL := '0'
        Else
          strSQL := FieldByName('VALOR').AsString;

        Close;
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create('Não consegui pegar o proximo sequencial. Tente novamente!');
      End;
    End;

    Result := fStrZero(strSQL, 6);
    If StrToInt(Result) = 0 Then
      Result := fStrZero(IntToStr(StrToInt(Result)+1), 6);

    fAtuSequencial(fStrZero(IntToStr(StrToInt(Result)+1), 6));

  Finally
    FreeAndNil(qryCadGen);
  End;

End;}

function TfrmGarantiaRetFornecedor.fRetStrChaveGrid: String;
begin
  if blnBaixar then
    Result := Self.Name+'_Baixa'
  else
    Result := self.Name+'_Retorno';
end;

function TfrmGarantiaRetFornecedor.fSaldoItem: Double;
begin
  Result := cdsProdutosQTDREQ.AsFloat - (cdsProdutosQTDRET.AsFloat+ cdsProdutosQTDREF.AsFloat);
end;

function TfrmGarantiaRetFornecedor.fSoRefugo: Boolean;
begin
  Result := False;

  If (cdsProdutos.Active) And (Not cdsProdutos.IsEmpty) Then
  Begin
    cdsProdutos.First;
    While Not cdsProdutos.Eof Do
    Begin
      If (cdsProdutos.FieldByName('QTDRET_1').Value <> 0) Then
      Begin
        Exit(False);
      End
      Else
      Begin
        Result := True;
        cdsProdutos.Next;
      End;
    End;
  End;
end;

function TfrmGarantiaRetFornecedor.fTodosItemNfeAtendido: Boolean;
begin
  Result := True;
  If Not fEmptyStr(recNotEle.strAutInc) Then
  Begin
    cdsItensNFe.Filtered := False;
    cdsItensNFe.Filter := 'DIVERGENTE = ' + QuotedStr('S');
    cdsItensNFe.Filtered := True;

    Result := (cdsItensNFe.RecordCount = 0);
    cdsItensNFe.Filtered := False;
    cdsItensNFe.Filter := '';
  End;
end;

function TfrmGarantiaRetFornecedor.fConfirmarMarcacaoTotal(
  enuTipoMarcacaoTotal: TenuTipoMarcacaoRegistroTotal): Boolean;
  const
    MSG_PADRAO: String = 'A QUANTIDADE DE %s DE TODOS OS ITENS SELECIONADOS SERÁ '
                         +slineBreak+' ATUALIZADA  COM A SUA RESPECTIVA QUANTIDADE ENVIADA. CONFIRMA?';

  Var
    strMsg: String;
begin
  if enuTipoMarcacaoTotal = TenuTipoMarcacaoRegistro.RefugoTotal then
    strMsg := Format(MSG_PADRAO,['REFUGO'])
  else
    strMsg := Format(MSG_PADRAO,[ifthen(blnBaixar,'BAIXA','RETORNO')]);

  Result := fMensagem('Confirmação',strMsg,['&Sim','&Não']) = 1;
end;

function TfrmGarantiaRetFornecedor.fEntradaNF(var strNumDoc, strEspDoc: string; strCodFor: String; strChaveSEQGAG: String = ''): Boolean;
  Var
    strOrdIte,
    strClaFis : String;
    intCont,
    intDigCla: Integer;
    lstrEstFor: String;
    frmEntMercadorias : TfrmEntMercadorias;
begin
  Result := True;
  lstrEstFor := fEstadoFornecedor(edtCodFor.Text);

  strNumDoc := '';
  strEspDoc := '';
  If fEmptyStr(fCfgSis('CLARGR')) Then
  Begin
    pMensagemOK('A(s) classificação(ões) fiscal(ais) de Retorno para Conserto não foi(ram) configurada(s).');
    Result := False;
    Exit;
  End
  Else
  Begin

    intCont   := 1;
    While intCont < Length(AnsiReplaceStr(VS_strClaRGR,'_','')) Do
    Begin
      strClaFis := Copy(AnsiReplaceStr(VS_strClaRGR,'_',''),intCont,4);

      If (Not fClaFisCadastrada(strClaFis)) Then
      Begin
        pMensagemOK('A CFOP ' + strClaFis + ' não esta cadastrada!' + #13#10 +'Favor cadastrá-la.');
        Result := False;
        Exit;
      End
      Else
      Begin
        intDigCla := StrToInt(Copy(strClaFis, 1, 1));
        {* VERIFICA CFOP INVÁLIDO PARA ENTRADA     *}
        If (intDigCla >= 5) Then
        Begin
          pMensagemOK('Classificação '+ strClaFis + ' não permitida para nota de entrada, '+#13#10+
                      'Permitido apenas classificações de entradas. ' +#13#10+
                      'Necessário ajustar a configuração CFG_CLARGR');
          Result := False;
          Exit;
        End
      End;

      intCont := intCont + 4;
    End;
  End;

  If (Length(fCfgSis('CLARGR')) = 4) Then
    strClaFis := fCfgSis('CLARGR')
  Else
  Begin
    Try
      pCriarFormularios(TfrmFatDigDadosGarantia, frmFatDigDadosGarantia);
      frmFatDigDadosGarantia.strOpcDoc         := 'GR';
      frmFatDigDadosGarantia.edtClaFis.Enabled := True;
      frmFatDigDadosGarantia.edtDesCla.Enabled := True;
      frmFatDigDadosGarantia.blnOperacaoInterEstadual := Not SameText(lstrEstFor, fCadEmp('ESTADO'));
      frmFatDigDadosGarantia.ShowModal;

      Result := frmFatDigDadosGarantia.ModalResult = mrOk;

      If (Result) Then
        strClaFis := frmFatDigDadosGarantia.edtClaFis.Text;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '');
      End;
    End;
    pFreeAndNil(frmFatDigDadosGarantia);
  End;
  Result :=  Result And fCarregaItensGarantia(VS_strCodEmp,qryItePed,False,'', True, '',strChaveSEQGAG, edtCodFor.Text);
  If Result Then
  Begin
    Result := False;
    Try
      pCriarFormularios(TfrmEntMercadorias, frmEntMercadorias);
      frmEntMercadorias.onAfterConfirmaEntrada := pAfterConfirmaEntrada;

      frmEntMercadorias.strClaFisGar   := strClaFis;
      frmEntMercadorias.strClaFisSub   := strClaFis;
      frmEntMercadorias.qryItePed      := qryItePed;
      frmEntMercadorias.blnSemInc      := False;
      frmEntMercadorias.strCodFor      := edtCodFor.Text;
      frmEntMercadorias.strOrdIte      := strOrdIte;
      frmEntMercadorias.blnGarantia    := True;

      if Not fEmptyStr(Self.recNotEle.strAutInc) then
        frmEntMercadorias.recNotEle      := Self.recNotEle;

      //frmEntMercadorias.blnRetornoForn := True;

      frmEntMercadorias.edtEspDoc.Text := 'NF';
      frmEntMercadorias.showModal;

      if frmEntMercadorias.blnConfirma then
        Result := True;

      strNumRet := frmEntMercadorias.strNumDoc;
      strNumDoc := frmEntMercadorias.edtNumDoc.Text;
      strEspDoc := frmEntMercadorias.edtEspDoc.Text;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[frmGarantiaRetFornecedor -> fEntradaNF]');
      End;
    End;
    pFreeAndNil(frmEntMercadorias);
  End;
end;

procedure TfrmGarantiaRetFornecedor.pAfterConfirmaEntrada();
begin
  pBaixaPedidos(True);
  pAtualizaTotais();
end;

function TfrmGarantiaRetFornecedor.fGravaCreditoFornecedor(strCodFor,
  strCodCta, strNumGars, strNumDocs, strCodPor: String; fltValDup: Double): Boolean;
  Var
    strNumDup: String;
begin
  strNumDup := fRetSequencialCadPag;

  Result := fGravaCadPag('frmGarantiaRetFornecedor',
                         'INCLUSAO CRÉDITO FORNECEDOR (GARANTIA)',
                         strCodFor,
                         strNumDup,
                         'A',
                         VS_strCodEmp,
                         strCodCta,
                         '1',
                         0,
                         VS_Date,
                         fNow(),
                         -fltValDup,
                         -fltValDup,
                         'N',
                         'N',
                         'N',
                         'REF. A CRÉDITO DO FORNECEDOR NA BAIXA DE ITENS DA GARANTIA Nº(S) ' + strNumGars + ' DOS DOC.(S) ' + strNumDocs,
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         0,
                         0,
                         0,
                         0,
                         '',
                         '',
                         'N',
                         strCodPor,
                         '',
                         0.0,
                         0.0,
                         0,
                         False,
                         0,
                         '',
                         0,
                         'N',
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         'N',
                         '',
                         '',
                         '',
                         '',
                         '',
                         0,
                         0,
                         0,
                         0,
                         '',
                         0,
                         0,
                         '',
                         '',
                         '',
                         '',
                         '',
                         '0',
                         '',
                         '',
                         '',
                         '',
                         'N');

end;

procedure TfrmGarantiaRetFornecedor.pCriarCdsFornecdoresitem;
Var
  lFieldDef: TFieldDef;
  lField: TField;
begin
  If Assigned(FcdsFornecedoresItem) Then
    FreeAndNil(FcdsFornecedoresItem);
  FcdsFornecedoresItem := TUniClientDataSet.Create(Self);

  lFieldDef := FcdsFornecedoresItem.FieldDefs.AddFieldDef;
  lFieldDef.Name := 'ITE_CODITE';
  lFieldDef.DataType := ftString;
  lFieldDef.Size := fTamCodIte;
  lField := lFieldDef.CreateField(FcdsFornecedoresItem);
  lField.Visible := False;
  lField.DisplayLabel := 'Código';

  lFieldDef := FcdsFornecedoresItem.FieldDefs.AddFieldDef;
  lFieldDef.Name := 'ITE_CODFOR';
  lFieldDef.DataType := ftString;
  lFieldDef.Size := 8;
  lField := lFieldDef.CreateField(FcdsFornecedoresItem);
  lField.Visible := False;

  lFieldDef := FcdsFornecedoresItem.FieldDefs.AddFieldDef;
  lFieldDef.Name := 'FOR_NOMFOR';
  lFieldDef.DataType := ftString;
  lFieldDef.Size := 60;
  lField := lFieldDef.CreateField(FcdsFornecedoresItem);
  lField.Visible := False;

  lFieldDef := FcdsFornecedoresItem.FieldDefs.AddFieldDef;
  lFieldDef.Name := 'CID_NOMCID';
  lFieldDef.DataType := ftString;
  lFieldDef.Size := 40;
  lField := lFieldDef.CreateField(FcdsFornecedoresItem);
  lField.Visible := False;

  lFieldDef := FcdsFornecedoresItem.FieldDefs.AddFieldDef;
  lFieldDef.Name := 'CID_ESTADO';
  lFieldDef.DataType := ftString;
  lFieldDef.Size := 2;
  lField := lFieldDef.CreateField(FcdsFornecedoresItem);
  lField.Visible := False;

  lFieldDef := FcdsFornecedoresItem.FieldDefs.AddFieldDef;
  lFieldDef.Name := 'FOR_FONE01';
  lFieldDef.DataType := ftString;
  lFieldDef.Size := 15;
  lField := lFieldDef.CreateField(FcdsFornecedoresItem);
  lField.Visible := False;

  lFieldDef := FcdsFornecedoresItem.FieldDefs.AddFieldDef;
  lFieldDef.Name := 'ITE_CODITF';
  lFieldDef.DataType := ftString;
  lFieldDef.Size := TAM_CODIGO_FABRICA;
  lField := lFieldDef.CreateField(FcdsFornecedoresItem);
  lField.Visible := True;
  lField.DisplayLabel := 'Código Item Fornec.';

  lFieldDef := FcdsFornecedoresItem.FieldDefs.AddFieldDef;
  lFieldDef.Name := 'ITE_CODCNA';
  lFieldDef.DataType := ftString;
  lFieldDef.Size := 20;
  lField := lFieldDef.CreateField(FcdsFornecedoresItem);
  lField.Visible := True;
  lField.DisplayLabel := 'Código CNA';

  FcdsFornecedoresItem.CreateDataSet;
  FcdsFornecedoresItem.IndexFieldNames := 'ITE_CODITF';
end;

function TfrmGarantiaRetFornecedor.fGetSQLItensNFEXml: String;
begin
  Result := '';
  Result := Result + 'SELECT DET_CODITE AS ITE_CODITE, ';
  Result := Result + '       CAST("" AS CHAR(20)) AS "INCDET", ';
  Result := Result + '       ITE_DESITE, ';
  Result := Result + '       GER_CODFOR, ';
  Result := Result + '       CONCAT("NFe:", B08_NNF, " Serie:", B07_SERIE, " Fornecedor:", GER_CODFOR, " Empresa:", GER_CODEMP ) AS DOCUMENTO, ';
  Result := Result + '       I10_QCOM AS ITE_QTDXML, ';
  Result := Result + '       0 AS ITE_QTDRET, ';
  Result := Result + '       0 AS ITE_QTDREF, ';
  Result := Result + '       "S" AS DIVERGENTE ';
  Result := Result + '  FROM GERELE ';
  Result := Result + ' INNER JOIN DETELE ON DETELE.DET_SEQGER = GERELE.AUTOINCREM ';
  Result := Result + ' INNER JOIN CADITE ON ITE_CODITE = DET_CODITE ';
  Result := Result + ' WHERE GERELE.AUTOINCREM = "'+recNotEle.strAutInc+'" ';
  Result := Result + '   AND GER_TIPXML = 10 ';
end;

procedure TfrmGarantiaRetFornecedor.FormShow(Sender: TObject);
begin
  inherited;
  blnConfirma := False;

  dbgProdutoViewNUMPED.Visible:= fCfgSis('GARMAT', varBoolean);

  If blnBaixar Then
  Begin
    dbeMotivo.Top   := 5;
    lblMotivo.Top   := 14;
    pnlObs.Height   := 40;

    dbgProdutoViewQTDREF_1.Visible:= False;
    dbgProdutoViewQTDRET_1.Caption:= 'Qtde Baixar';
    dbgProdutoViewQTDRET_1.Visible:= True;
    dbgProdutoViewQTDRET_1.Width := 70;

    btnConfirmar.Caption := '[ F10 ]Confirmar Baixa';
    pEscondeOBS;

    btnRetornoTotal.Caption := '[F8] Baixa Total';
    btnRefugoTotal.Visible := False;
  End
  Else
  Begin
    If blnPermiteCarregarXML Then
    begin
      pnlFornecedor.Height := 65;
      pnlSelXML.Visible := True;
    end;

    lblMotivo.Visible := False;
    dbeMotivo.Visible := False;
    pnlObs.Height := pnlObs.Height - dbeMotivo.Height;
  End;

  if (Not FblnUsuarioTemPermissaoEnviarRefugo) then
    pDesabilitarRefugo;

end;

procedure TfrmGarantiaRetFornecedor.pEscondeOBS;
begin
  dbeObsF_1.Visible := False;
  dbeObsF_2.Visible := False;
  dbeObsF_3.Visible := False;
  dbeObsF_4.Visible := False;
  dbeObsF_5.Visible := False;
  lblObs_01.Visible := False;
  lblObs_02.Visible := False;
  lblObs_03.Visible := False;
  lblObs_04.Visible := False;
  lblObs_05.Visible := False;
end;

procedure TfrmGarantiaRetFornecedor.pGetNumDocsGarAndDocsEnvAndCre(var strNumEnt,
  strNumEnv: String; fltValDup: Double);
  Var
    bmkMarca: TBookmark;
begin
  With cdsProdutos Do
  Begin
    bmkMarca := GetBookmark;
    DisableControls;

    strNumEnv := '';
    strNumEnt := '';

    First;

    objLiberacao.objMsgLibera.pAddTexto('Geração de crédito para Fornecedor (Garantia)');
    objLiberacao.objMsgLibera.pAddQuebra;

    objLiberacao.objMsgLibera.pAddTextoCaption('Total do crédito', FormatFloat('#,##0.00', fltValDup));
    objLiberacao.objMsgLibera.pAddQuebra;

    While Not Eof Do
    Begin
      If Pos(strNumEnt, FieldByName('NUMENT').AsString) <= 0 Then
        strNumEnt := strNumEnt + FieldByName('NUMENT').AsString + ',';

      If Pos(strNumEnv, FieldByName('NUMENV').AsString) <= 0 Then
        strNumEnv := strNumEnv + FieldByName('NUMENV').AsString + ',';

      objLiberacao.objMsgLibera.pAddTexto(FieldByName('CODITE').AsString + '-' + FieldByName('DESITE').AsString);
      objLiberacao.objMsgLibera.pAddTextoCaption('Crédito sobre o item R$', FormatFloat('#,##0.00', cdsProdutos.FieldByName('VALUNT').AsCurrency * cdsProdutosQTDRET_1.AsCurrency));
      objLiberacao.objMsgLibera.pAddSeparador(62);


      Next;
    End;

    If Not fEmptyStr(Trim(strNumEnt)) Then
    Begin
      If strNumEnt[Length(strNumEnt)] = ',' Then
      Begin
        strNumEnt[Length(strNumEnt)] := ' ';
        strNumEnt := Trim(strNumEnt);
      End;
    End;

    If Not fEmptyStr(Trim(strNumEnv)) Then
    Begin
      If strNumEnv[Length(strNumEnv)] = ',' Then
      Begin
        strNumEnv[Length(strNumEnv)] := ' ';
        strNumEnv := Trim(strNumEnv);
      End;
    End;

    GotoBookmark(bmkMarca);
    FreeBookmark(bmkMarca);
    EnableControls;
  End;
end;

procedure TfrmGarantiaRetFornecedor.pExibirCodigosProdutoFornecedores(const pstrCodIte, pstrCodFor: String);
Var
  lstrSQL: String;
  lQry: TUniQuery;
  lfrm: TfrmGrid;
begin
  lstrSQL := '';
  lstrSQL := lstrSQL + ' SELECT SQL_NO_CACHE ';
  lstrSQL := lstrSQL + '   ITE_CODITE, ';
  lstrSQL := lstrSQL + '   ITE_CODFOR, ';
  lstrSQL := lstrSQL + '   ITE_CODITF, ';
  lstrSQL := lstrSQL + '   ITE_CODCNA, ';
  lstrSQL := lstrSQL + '   FOR_NOMFOR, ';
  lstrSQL := lstrSQL + '   FOR_FONE01, ';
  lstrSQL := lstrSQL + '   CID_NOMCID, ';
  lstrSQL := lstrSQL + '   CID_ESTADO ';
  lstrSQL := lstrSQL + ' FROM ';
  lstrSQL := lstrSQL + '   ITEFOR ';
  lstrSQL := lstrSQL + '   JOIN CADFOR ON (ITE_CODFOR=FOR_CODFOR) ';
  lstrSQL := lstrSQL + '   JOIN CADCID ON (FOR_CODCID=CID_CODCID) ';
  lstrSQL := lstrSQL + ' WHERE ';
  lstrSQL := lstrSQL + '       ITE_CODITE = :CODITE ';
  lstrSQL := lstrSQL + '  AND  ITE_CODFOR = :CODFOR ';
  lstrSQL := lstrSQL + ' ORDER BY ';
  lstrSQL := lstrSQL + ' FOR_NOMFOR';

  lQry := fCriaQuery(Self);
  Try
    lQry.Close;
    lQry.SQL.Clear;
    lQry.SQL.Add(lstrSQL);
    lQry.ParamByName('CODITE').AsString := pstrCodIte;
    lQry.ParamByName('CODFOR').AsString := pstrCodFor;
    lQry.Open;

    FcdsFornecedoresItem.EmptyDataSet;
    if lQry.IsEmpty Then
    begin
      pMensagemOk('Fornecedor do item não encontrado.');
      Exit;
    end
    else
    begin
      if lQry.RecordCount = 1 then
      begin
        pMensagemOk('Item não possui códigos adicionais para o mesmo fornecedor.');
        Exit;
      end;
    end;

    lQry.First;

    While Not lQry.Eof Do
    Begin
      FcdsFornecedoresItem.Insert;
      FcdsFornecedoresItem.FieldByName('ITE_CODITE').AsString := lQry.fieldbyname('ITE_CODITE').AsString;
      FcdsFornecedoresItem.FieldByName('ITE_CODITF').AsString := lQry.fieldbyname('ITE_CODITF').AsString;
      FcdsFornecedoresItem.FieldByName('ITE_CODCNA').AsString := lQry.fieldbyname('ITE_CODCNA').AsString;
      FcdsFornecedoresItem.FieldByName('ITE_CODFOR').AsString := lQry.fieldbyname('ITE_CODFOR').AsString;
      FcdsFornecedoresItem.FieldByName('FOR_NOMFOR').AsString := lQry.fieldbyname('FOR_NOMFOR').AsString;
      FcdsFornecedoresItem.FieldByName('CID_NOMCID').AsString := lQry.fieldbyname('CID_NOMCID').AsString;
      FcdsFornecedoresItem.FieldByName('CID_ESTADO').AsString := lQry.fieldbyname('CID_ESTADO').AsString;
      FcdsFornecedoresItem.FieldByName('FOR_FONE01').AsString := lQry.fieldbyname('FOR_FONE01').AsString;
      FcdsFornecedoresItem.Post;
      lQry.Next;
    End;

    TStringField(FcdsFornecedoresItem.FieldByName('FOR_FONE01')).EditMask := fRetMascaraFonePais;

    pCriarFormularios(TfrmGrid, lfrm);
    lfrm.DataSet := FcdsFornecedoresItem;
    lfrm.Caption := 'Códigos do item do fornecedor para produto '+ pstrCodite;
    lfrm.ShowModal;

  Finally
    if Assigned(lfrm) then
      pFreeAndNil(lfrm);

    FcdsFornecedoresItem.EmptyDataSet;
    FreeAndNil(lQry);
  End;
end;

procedure TfrmGarantiaRetFornecedor.dbeMotivoExit(Sender: TObject);
begin
  inherited;
  If (Not fValidaCampos(dbeMotivo)) Then
    Exit;

  If cdsProdutos.State = dsEdit Then
    cdsProdutos.Post;

  pSetFocus(dbgProduto);
end;

End.

