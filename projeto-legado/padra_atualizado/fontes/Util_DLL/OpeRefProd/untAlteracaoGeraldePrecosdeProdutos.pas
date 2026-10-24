unit untAlteracaoGeraldePrecosdeProdutos;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, EditFocus, Menus, StrUtils, DB, AppEvnts,
  QColorLabel, UniDataSetProvider, UniClientDataSet, untFuncoesSimples, ComboBoxFocus,
  untFatorPreco, BitBtnLockedIncrem, Math, MemoFocus, untSalvaDadosInterface,
  Datasnap.Provider, frxClass, frxExportCSVTestabilidade, untZClient,
  cxProgressBar, untGravando, Datasnap.DBClient, untTypesSistema, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxEdit,
  cxDropDownEdit, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxVGrid, cxDBVGrid, cxInplaceContainer, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxEditRepositoryItems, cxDBEditRepository, cxCheckBox, untTEditFocusWithTConsultasArray,
  cxButtonEdit, untSelEmpresas, untTGerenciaItegerPermiteEdicao;

Type
  TRecTabelaPrecos = Record
    fltPreVenNov: Double;
    fltMarBruNov: Double;
    fltComTblNov: Double;
    blnAltPreven: Boolean;
    blnAltMarBru: Boolean;
    blnAltComTbl: Boolean;
  End;

type
  TfrmAlteracaoGeraldePrecosdeProdutos = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    pnlBotoesEnt: TPanel;
    pgbProgresso: TProgressBar;
    cdsAltGlo: TUniClientDataSet;
    cdsAltGloITE_DESCAM: TStringField;
    cdsAltGloITE_VALCAM: TStringField;
    cdsAltGloITE_EMPORI: TStringField;
    cdsAltGloITE_EMPDES: TStringField;
    cdsAltGloITE_MASCAM: TStringField;
    cdsAltGloITE_NOMCAM: TStringField;
    cdsAltGloITE_DESABR: TStringField;
    cdsAltGloITE_LIMCAM: TIntegerField;
    cdsAltGloITE_TIPCAM: TStringField;
    cdsAltGloITE_ALTERA: TStringField;
    dtsAltGlo: TDataSource;
    dspIteGlo: TUniDataSetProvider;
    cdsIteGlo: TUniClientDataSet;
    pnlFiltro1: TPanel;
    Label1: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    Label2: TLabel;
    edtDesIte: TEditFocus;
    Label3: TLabel;
    edtRefere: TEditFocus;
    Label4: TLabel;
    edtCodUni: TEditFocus;
    Label6: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    rdgTipAlt: TRadioGroup;
    rdgTipAltFor: TRadioGroup;
    pnlFiltro2: TPanel;
    Label8: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    Label5: TLabel;
    edtCodAbr: TEditFocus;
    edtDesAbr: TEditFocus;
    edtStatus: TEditFocus;
    ColorLabel1: TColorLabel;
    pnlNotEnt: TPanel;
    Label12: TLabel;
    grpDadosNE: TGroupBox;
    lblDocumento: TLabel;
    lblEspecie: TLabel;
    lblSerie: TLabel;
    lblEmpresa: TLabel;
    lblForNot: TLabel;
    edtDocumento: TEditFocus;
    edtEspecie: TEditFocus;
    edtSerie: TEditFocus;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    chkNotEnt: TCheckBox;
    edtForNot: TEditFocus;
    edtDesForNot: TEditFocus;
    pnlTipAltNota: TPanel;
    btnConfirma: TBitBtnLocked;
    btnSairAlt: TBitBtnLocked;
    Label13: TLabel;
    Label167: TLabel;
    edtPrdGru: TEditFocus;
    edtDesPrdPro: TEditFocus;
    Label14: TLabel;
    edtGruCmp: TEditFocus;
    edtDesGruCmp: TEditFocus;
    Label50: TLabel;
    edtIncPis: TEditFocus;
    ColorLabel2: TColorLabel;
    Label9: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    lblCodGpr: TLabel;
    edtCodGpr: TEditFocus;
    edtDesGpr: TEditFocus;
    shpMultSel: TShape;
    mskDtaEntFin: TMaskEditFocus;
    lblDtaFin: TLabel;
    lblDtaIni: TLabel;
    mskDtaEntIni: TMaskEditFocus;
    cxStyleRepository: TcxStyleRepository;
    cxsCorAzul: TcxStyle;
    cxEditRepository: TcxEditRepository;
    cxeString16: TcxEditRepositoryTextItem;
    cxeString20: TcxEditRepositoryTextItem;
    cdsAltGloITE_PROPER: TStringField;
    cxeString02: TcxEditRepositoryTextItem;
    cxeString03: TcxEditRepositoryTextItem;
    cxeString05: TcxEditRepositoryTextItem;
    cxeString06: TcxEditRepositoryTextItem;
    cxeString07: TcxEditRepositoryTextItem;
    cxeString08: TcxEditRepositoryTextItem;
    cxeString10: TcxEditRepositoryTextItem;
    cxeString25: TcxEditRepositoryTextItem;
    cxeString30: TcxEditRepositoryTextItem;
    cxeString50: TcxEditRepositoryTextItem;
    cxeString70: TcxEditRepositoryTextItem;
    cxeString80: TcxEditRepositoryTextItem;
    cxeString255: TcxEditRepositoryTextItem;
    cxeLocFis: TcxEditRepositoryTextItem;
    cxeLocSup: TcxEditRepositoryTextItem;
    cxeTamLcf: TcxEditRepositoryTextItem;
    cxeLocSep: TcxEditRepositoryTextItem;
    cxeDate: TcxEditRepositoryDateItem;
    cxeInt03: TcxEditRepositoryCurrencyItem;
    cxeInt11: TcxEditRepositoryCurrencyItem;
    cmbSimNao: TcxEditRepositoryLookupComboBoxItem;
    cmbClaCRM: TcxEditRepositoryLookupComboBoxItem;
    cmbNivGir: TcxEditRepositoryComboBoxItem;
    cmbNivCri: TcxEditRepositoryComboBoxItem;
    cmbFrePFU: TcxEditRepositoryLookupComboBoxItem;
    cmbEsMiDg: TcxEditRepositoryLookupComboBoxItem;
    cxeMemo: TcxEditRepositoryMemoItem;
    cxsCombo: TcxStyle;
    cxsAltera: TcxStyle;
    cxeMasFat: TcxEditRepositoryTextItem;
    cxeDecUni: TcxEditRepositoryTextItem;
    cxeDec05: TcxEditRepositoryTextItem;
    cxeDec06: TcxEditRepositoryTextItem;
    cxeMasVal: TcxEditRepositoryTextItem;
    cxeMasPer: TcxEditRepositoryTextItem;
    cxeMasMar: TcxEditRepositoryTextItem;
    cxeMasMBr: TcxEditRepositoryTextItem;
    cxeMasInt: TcxEditRepositoryTextItem;
    cmbTipPro: TcxEditRepositoryLookupComboBoxItem;
    cxsConsulta: TcxStyle;
    cdsAltGloITE_DESCRI: TStringField;
    cxeConsTam8: TcxEditRepositoryTextItem;
    cxeConsTam6: TcxEditRepositoryTextItem;
    cxeConsTam5: TcxEditRepositoryTextItem;
    cxeConsTam3: TcxEditRepositoryTextItem;
    cxeConsTamLse: TcxEditRepositoryTextItem;
    cxeConsTam4: TcxEditRepositoryTextItem;
    cxeConsTam2: TcxEditRepositoryTextItem;
    cxeClassfIPI: TcxEditRepositoryTextItem;
    pnlDadosAlt: TPanel;
    cxgTiposAlt: TcxGrid;
    cxvTiposAlt: TcxGridDBTableView;
    cxvTiposAltALTERA: TcxGridDBColumn;
    cxvTiposAltDESCAM: TcxGridDBColumn;
    cxvTiposAltPROPER: TcxGridDBColumn;
    cxvTiposAltNOMCAM: TcxGridDBColumn;
    cxvTiposAltDESCRI: TcxGridDBColumn;
    cxgTiposAltLevel1: TcxGridLevel;
    Panel2: TPanel;
    cxeConsTam7: TcxEditRepositoryTextItem;
    Label18: TLabel;
    edtAbfPis: TEditFocus;
    edtDesPis: TEditFocus;
    Label19: TLabel;
    edtAbfCof: TEditFocus;
    edtDesCof: TEditFocus;
    dtsPermissaoVenda: TDataSource;
    cmbPerVda: TcxEditRepositoryLookupComboBoxItem;
    cxvTiposAltEmpOrigem: TcxGridDBColumn;
    cxvTiposAltEMPDES: TcxGridDBColumn;
    GroupBox1: TGroupBox;
    Shape3: TShape;
    Label17: TLabel;
    procedure edtAbfCofExit(Sender: TObject);
    procedure edtAbfCofKeyPress(Sender: TObject; var Key: Char);
    procedure edtAbfPisExit(Sender: TObject);
    procedure edtAbfPisKeyPress(Sender: TObject; var Key: Char);
    procedure btnSairAltClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtDesIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAbrKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rdgTipAltClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkNotEntClick(Sender: TObject);
    procedure edtForNotExit(Sender: TObject);
    procedure edtForNotKeyPress(Sender: TObject; var Key: Char);
    procedure rdgTipAltForClick(Sender: TObject);
    procedure edtPrdGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtIncPisKeyPress(Sender: TObject; var Key: Char);
    procedure edtRefereKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodGprExit(Sender: TObject);
    procedure edtCodGprKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure mskLinGruExit(Sender: TObject);
    procedure edtPrdGruExit(Sender: TObject);
    procedure edtGruCmpExit(Sender: TObject);
    procedure edtCodUniExit(Sender: TObject);
    procedure edtCodAbrExit(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure cxvTiposAltVALCAMGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure cxvTiposAltVALCAMStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxvTiposAltDESCAMStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxvTiposAltALTERAPropertiesChange(Sender: TObject);
    procedure cdsAltGloBeforePost(DataSet: TDataSet);
    procedure cxeMasFatPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvTiposAltVALCAMGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxeMasIntPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvTiposAltEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxeMasPerPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxeDatePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxeConsTam2PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxeString03PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxeClassfIPIPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvTiposAltDataControllerFilterChanged(Sender: TObject);

function RemoveAcento(const pText: string): string;
    procedure cxvTiposAltDESCAMGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxvTiposAltFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxvTiposAltEMPDESPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);

  private
    { Private declarations }
    objFatPre: TFatorPreco;

    blnVidroInteiro: Boolean;

    cdsSimNao,
    cdsClaCrm,
    cdsFrePFU,
    cdsEsMiDg,
    cdsTipPro: TZClient;

    intPosMatPreMatInicial,
    intPosMatPreMatFinal: Integer;

    intDecUni: Integer;

    blnBloPre,
    blnValFor: Boolean;
    fltPMarLq : Double;

    strMasVal: String;
    strMasFat: String;
    strMasPer: String;
    strMasInt: String;
    strMasMar: String;
    strMasMBr: String;
    strMasDecUni: String;
    strMasDec06: String;
    strMasDec05: String;

    qryConFor: TUniQuery;
    qryConAbf: TUniQuery;
    qryAbfIcm: TUniQuery;

    blnLiqNeg: Boolean;

    qryConGru: TUniQuery;
    arrCamposGlobal: Array Of TCampoGlobal;
    arrCamposTabela: Array Of TCampoGlobal;
    arrCamposGrid: TArrCampoGlobal;

    qryGenIte: TZClient;
    qryItensEmpOrigem: TUniQuery;

    arrRecTabelasPreco: Array [1..7] Of TRecTabelaPrecos;

    blnAvisoAtivo: Boolean;
    blnSergipe   : Boolean;
    blnIteTbp    : Boolean;
    blnURapel    : Boolean;
    blnMarIde    : Boolean;

    strEstEmp : String;

    strLinGru,
    strMarca ,
    strFornec,
    strPrdGru,
    strGruCmp,
    strCodGpr,
    strCodDep,
    strCodAbr,
    strAbfPis,
    strAbfCof,
    strCodUni : String;

    arrAbfPis,
    arrAbfCof,
    arrLinhaGrupo,
    arrMarca,
    arrFornec,
    arrGrupoPro,
    arrGruCmp,
    arrCodGpr,
    arrCodDep,
    arrCodMon,
    arrCodAbr,
    arrCodUni,
    arrClaIPI : TConsultasArray;

    intLocFis,
    intLocSup,
    intTamLcf,
    intLocSep : Integer;

    objSalInt: TSalvaInterface;

    procedure pVerificaDireitoAcesso;
    procedure pLimparTela;
    procedure pHabilitaNotaEntrada(blnHabilitar: Boolean = False);

    procedure pGeraClient;

    Function fGeraClient(cxProgresso: TcxProgressBar): Boolean;

    procedure pCarregaSelecao;
    procedure pSalvaSelecao;

//    procedure pSalvaDados(strValCam, strDescri: String);

    Procedure pBeforePostMargem(dtsDtaSet: TDataSet);
    Function fCorrigeMargensNegativas: Boolean;

    function fTemConsultaTabela(strNomCam: String): Boolean;

    Function fValidaValor(strValor: String): Boolean;

    function fGeraVetorCampos: Boolean;
    function fGeraVetorCamposAux(pgbProgresso: TcxProgressBar): Boolean;
    procedure pCriaTabelaItens;
    function  fGeraTabelaItens: Boolean;
    function fGeraTabelaItensAux(pgbProgresso2: TcxProgressBar): Boolean;
    function fProdutoComSaldo(strCodIte: String): Boolean;
    function fSelecionaEmpresasEmUso(var AEmpresaDestino: String; var AEmpresaOrigem: String): String;


    procedure pedtCodForKeyPre(edtCodFor: TEditFocus; var Key: Char; blnNomFor: Boolean);

    procedure pAlteraValorTabelaItens(qryItens: TZClient);
    procedure pAtribuiTabelas;

    procedure pAtualizaValorCampo(Var arrCampos: Array Of TCampoGlobal;
      strNomeCampo: String; varValor: Variant; strCodIte: String = ''); overload;
    procedure pAtualizaValorCampo(strNomeCampo: String; varValor: Variant; strCodIte: String = '');overload;


    function fRetornaNumeric(strMascara: String): String;
    function fCampoPorNome(Var arrCampos: Array Of TCampoGlobal;
      strNomeCampo: String): TCampoGlobal;
    procedure pMontaGrid;

    Function fRetDescricaoCadastro(strCodCad: String; blnValidar: Boolean; Var blnErro: Boolean): String;

    function fRetDesAbfPisCofIpi(strTabela, strCod: String): String;

    procedure pAjustaAlteracaoPorNota;

    Procedure pRetProperties(strNomProp: String; var AProperties: TcxCustomEditProperties);


    Procedure pCriaCdsSimNao;
    Procedure pCriaCdsClaCRM;
    Procedure pCriaCdsFrePFU;
    Procedure pCriaCdsEsMiDg;
    Procedure pCriaCdsTipPro;

    Procedure pLimpaListas;
    function fSetaSQL(strEmpOrigem: String = ''; strEmpDestino: String = ''): String;
    procedure pSetaQryItensEmpresa(AQuery: TuniQuery; strEmpOrigem: String = ''; strEmpDestino: String = '');
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnAltPorNota : Boolean;
    strFiltro: string;
  end;

var
  frmAlteracaoGeraldePrecosdeProdutos: TfrmAlteracaoGeraldePrecosdeProdutos;

implementation

uses untPesqAux, untAltPrecoGlobalItens, untConsultas, untFuncoesConsulta,
     untConstantes, untParCalculaPrecoCusto, untTConfiguracao, cxCurrencyEdit,
     cxTextEdit, cxDBLookupComboBox, untAltPrecoGlobalMargemNeg,
     untIcmsSTParteVenda, untIFatReservaSaldo, untTFatReservaSaldo,
     untTipoPermissaoVenda;

{$R *.dfm}

Procedure TfrmAlteracaoGeraldePrecosdeProdutos.pLimpaListas;
Begin
  TcxLookupComboBoxProperties(cmbSimNao.Properties).ListSource := Nil;
  TcxLookupComboBoxProperties(cmbTipPro.Properties).ListSource := Nil;
  TcxLookupComboBoxProperties(cmbClaCRM.Properties).ListSource := Nil;
  TcxLookupComboBoxProperties(cmbFrePFU.Properties).ListSource := Nil;
  TcxLookupComboBoxProperties(cmbEsMiDg.Properties).ListSource := Nil;
End;

Procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCriaCdsSimNao;
Begin
  cdsSimNao := TZClient.Create(Self, 'SELECT "S" AS VALCAM, "Sim" AS DESCAM UNION SELECT "N" AS VALCAM, "Não" AS DESCAM');
  cdsSimNao.fLeDados('TfrmAlteracaoGeraldePrecosdeProdutos.pCriaCdsSimNao');

  TcxLookupComboBoxProperties(cmbSimNao.Properties).ListSource := cdsSimNao.dtsSource;
End;

Procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCriaCdsTipPro;
  Var
    intContador: Integer;
Begin
  cdsTipPro := TZClient.Create(Self, 'SELECT "00" AS VALCAM, CAST("" AS CHAR(40)) AS DESCAM');
  cdsTipPro.fLeDados('TfrmAlteracaoGeraldePrecosdeProdutos.pCriaCdSTipPro');
  cdsTipPro.EmptyDataSet;

  For intContador := Low(TIPO_PRODUTO_SPED) To High(TIPO_PRODUTO_SPED) Do
  Begin
    cdsTipPro.Append;
    cdsTipPro.FieldByName('VALCAM').AsString := TIPO_PRODUTO_SPED[intContador][0];
    cdsTipPro.FieldByName('DESCAM').AsString := TIPO_PRODUTO_SPED[intContador][0] + ' - ' + TIPO_PRODUTO_SPED[intContador][1];
    cdsTipPro.Post;
  End;

  TcxLookupComboBoxProperties(cmbTipPro.Properties).ListSource := cdsTipPro.dtsSource;
End;
Procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCriaCdsClaCRM;
Begin
  cdsClaCrm := TZClient.Create(Self, 'SELECT "C" AS VALCAM, "Consumível" AS DESCAM UNION ' +
                                     'SELECT "P" AS VALCAM, "Principal"  AS DESCAM UNION ' +
                                     'SELECT "A" AS VALCAM, "Acessório"  AS DESCAM');

  cdsClaCrm.fLeDados('TfrmAlteracaoGeraldePrecosdeProdutos.pCriaCdsClaCrm');

  TcxLookupComboBoxProperties(cmbClaCRM.Properties).ListSource := cdsClaCRM.dtsSource;
End;

Procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCriaCdsFrePFU;
Begin
  cdsFrePFU := TZClient.Create(Self, 'SELECT "P" AS VALCAM, "Percentual" AS DESCAM UNION ' +
                                     'SELECT "F" AS VALCAM, "Fixo"       AS DESCAM UNION ' +
                                     'SELECT "U" AS VALCAM, "Unitário"   AS DESCAM');

  cdsFrePFU.fLeDados('TfrmAlteracaoGeraldePrecosdeProdutos.pCriaCdsFrePFU');

  TcxLookupComboBoxProperties(cmbFrePFU.Properties).ListSource := cdsFrePFU.dtsSource;
End;

Procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCriaCdsEsMiDg;
Begin
  cdsEsMiDg := TZClient.Create(Self, 'SELECT "G" AS VALCAM, "Gerado"   AS DESCAM UNION ' +
                                     'SELECT "D" AS VALCAM, "Digitado" AS DESCAM');

  cdsEsMiDg.fLeDados('TfrmAlteracaoGeraldePrecosdeProdutos.pCriaCdsEsMiDg');

  TcxLookupComboBoxProperties(cmbEsMiDg.Properties).ListSource := cdsEsMiDg.dtsSource;
End;


function TfrmAlteracaoGeraldePrecosdeProdutos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNomCam: String;
    strMasCam: String;
begin
  strNomCam := '';
  strMasCam := '';
  Result    := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtDesIte) Then
    Begin
    End

    Else If (Sender = edtRefere) Then
    Begin
    End

    Else If (Sender = edtCodFor)  Then
    Begin
      If fEmptyStr(edtCodFor.Text) Then
          edtNomFor.Text := 'TODOS';


    End

    Else If (Sender = edtDocumento) Then
    Begin

      If chkNotEnt.Checked Then
      Begin
        mskDtaEntFin.Enabled := fEmptyStr(edtDocumento.Text);
        mskDtaEntIni.Enabled := fEmptyStr(edtDocumento.Text);
        lblDtaFin.Enabled := fEmptyStr(edtDocumento.Text);
        lblDtaIni.Enabled := fEmptyStr(edtDocumento.Text);
        If Not mskDtaEntFin.Enabled Then
        Begin
          mskDtaEntFin.Text := '';
          mskDtaEntIni.Text := '';
        End;
      End;

    End

    Else If (Sender = edtCodEmpresa) Then
    Begin

      If chkNotEnt.Checked Then
      Begin
        If fEmptyStr(edtCodEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O código da empresa deve ser informado!', ['&O k']);
          Result := False;
        End
        else
        Begin

          edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

          If fEmptyStr(edtDesEmpresa.Text) Then
          Begin
            fMensagem('ATENÇÃO', 'Código da empresa não encontrado!', ['&O K']);
            Result := False;
          End
        End;
      End;
    End

    {***********************************}
    {* VALIDA O OPERADOR DA EXPRESSÃO  *}
    {********************************PZ*}

    Else If (Sender = edtForNot) Then
    Begin

      If fEmptyStr(edtForNot.Text) And blnAltPorNota Then
      Begin
        fMensagem('', 'Informe o código do Fornecedor!', ['&O K']);
        Result := False;
      End

      Else If Not fEmptyStr(edtForNot.Text) Then
      Begin

        edtDesForNot.Text := fRetNomFornecedor(edtForNot.Text);

        If fEmptyStr(edtDesForNot.Text) Then
        Begin
          fMensagem('','Fornecedor não encontrado!', ['&O K']);
          Result := False;
        End;

      End

      Else edtDesForNot.Clear;

    End

    Else If (Sender = mskDtaEntIni) And (not fEmptyDate(mskDtaEntIni.Text)) Then
    Begin
      If StrToDateDef(mskDtaEntIni.Text, 0) <= 0 Then
      Begin
        pMensagemOk('Data Inicial Inválida!');
        Result := False;
      End;


    End
    Else
    If (Sender = mskDtaEntFin) And (not fEmptyDate(mskDtaEntFin.Text)) Then
    Begin
      if StrToDateDef(mskDtaEntFin.Text, 0) <= 0 Then
      Begin
        pMensagemOk('Data Final Inválida!');
        Result := False;
      End;

      If Result Then
      Begin
        If StrToDateDef(mskDtaEntFin.Text, 0) < StrToDateDef(mskDtaEntIni.Text, 0) Then
        Begin
          pMensagemOk('A Data Final deve ser Maior ou Igual a Inicial!');
          Result := False;
        End;
      End;
    End
    //Se estiver marcado para informar nota fiscal deve ser informado o documento ou um periodo
    Else
    If (Sender = mskDtaEntFin) And (chkNotEnt.Checked) And (fEmptyStr(edtDocumento.Text)) And (fEmptyDate(mskDtaEntIni.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O número do documento deve ser informado ou um periodo de entrada de nota.', ['&O k']);
      Result := False;
    End

    Else If Sender = edtStatus Then
    Begin

      If Pos(edtStatus.Text, 'S_N_T_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Ativo deve ser S, N ou T!', ['&O k']);
        Result := False;
      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru, edtDesGru, arrLinhaGrupo, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.mskLinGruKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinGru, edtDesGru, qryConGru, Key, arrLinhaGrupo, False) Then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pGeraClient;
  Var
    frmGravando: TfrmGravando;
Begin
  TfrmGravando.fExecuta(fGeraClient, frmGravando, 'Criando dados para alteração...', True, True);
End;

Function TfrmAlteracaoGeraldePrecosdeProdutos.fGeraClient(cxProgresso: TcxProgressBar): Boolean;
  Var
    intContador: Integer;
begin
  Result := True;

  cdsAltGlo.DisableControls;

  If cdsAltGlo.Active Then
    cdsAltGlo.EmptyDataSet;

  cdsAltGlo.Open;
  pSetaClient(cdsAltGlo);

  cxProgresso.Properties.Max := Length(arrCamposGlobal);

  With cdsAltGlo Do
  For intContador := 0 To Length(arrCamposGlobal) -1 Do
  Begin
    cxProgresso.Position := cxProgresso.Position  + 1;
    Application.ProcessMessages;


    If ((Pos('ITE_COMTB', arrCamposGlobal[intContador].strNomCam) > 0) Or
        (Pos('ITE_MINTB', arrCamposGlobal[intContador].strNomCam) > 0)) And
       (VS_strTabPrc[StrToIntDef(RightStr(arrCamposGlobal[intContador].strNomCam, 1), 0)] <> 'S') Then
    Begin
      Continue;
    End;

    If ((Pos('ITE_PREVE', arrCamposGlobal[intContador].strNomCam) > 0) Or
        (Pos('ITE_MARBR', arrCamposGlobal[intContador].strNomCam) > 0)) And
       blnBloPre Then
    Begin
      Continue;
    End;

    If (rdgTipAlt.ItemIndex = 0)                                      And
       (Pos('ITE_PREVE', arrCamposGlobal[intContador].strNomCam) > 0) Then
    Begin
      Continue;
    End;

    If (rdgTipAlt.ItemIndex In [1,2])                                 And
       (Pos('ITE_MARBR', arrCamposGlobal[intContador].strNomCam) > 0) Then
    Begin
      Continue;
    End;

    If (Pos('ITE_QTPPRO', arrCamposGlobal[intContador].strNomCam) > 0) And
       (Pos(fCfgSis('TCOPRO'), '3_4_') <= 0) Then
      Continue;

    If (Pos(arrCamposGlobal[intContador].strNomCam, 'ITE_MARLQ1_ITE_MARLQ2_ITE_MARLQ3_ITE_MARLQ4_ITE_MARLQ5_ITE_MARLQ6_ITE_MARLQ7_') > 0) Then
      Continue;

    If (Not Assigned(objFatPre)) Or
       (Pos(arrCamposGlobal[intContador].strNomCam,
        'ITE_PREVE2_ITE_PREVE3_ITE_PREVE4_ITE_PREVE5_ITE_PREVE6_ITE_PREVE7_' +
        'ITE_MARBR2_ITE_MARBR3_ITE_MARBR4_ITE_MARBR5_ITE_MARBR6_ITE_MARBR7_' +
        'ITE_COMTB2_ITE_COMTB3_ITE_COMTB4_ITE_COMTB5_ITE_COMTB6_ITE_COMTB7_') <= 0) Then
    Begin
      Append;
      FieldByName('ITE_DESCAM').AsString  := arrCamposGlobal[intContador].strDesCam + '|' +
                                             RemoveAcento(arrCamposGlobal[intContador].strDesCam);
      FieldByName('ITE_PROPER').AsString  := arrCamposGlobal[intContador].strProper;
      FieldByName('ITE_VALCAM').Value     := Null;
      FieldByName('ITE_MASCAM').AsString  := arrCamposGlobal[intContador].strMasCam;
      FieldByName('ITE_NOMCAM').AsString  := arrCamposGlobal[intContador].strNomCam;
      FieldByName('ITE_DESABR').AsString  := arrCamposGlobal[intContador].strDesAbr;
      FieldByName('ITE_LIMCAM').AsInteger := arrCamposGlobal[intContador].intLimCam;
      FieldByName('ITE_TIPCAM').AsString  := arrCamposGlobal[intContador].strTipCam;
      FieldByName('ITE_EMPORI').AsString  := VS_StrCodEmp;
      FieldByName('ITE_EMPDES').AsString  := arrCamposGlobal[intContador].strEmpDes;
      FieldByName('ITE_ALTERA').AsString  := 'N';

      Post;
    End;

  End;

  cdsAltGlo.First;

  cdsAltGlo.EnableControls;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pAtribuiTabelas;
begin
  qryAbfIcm := fCriaQuery(Self);

  qryConGru := fCriarQuery('SELECT * FROM CADGRU WHERE FALSE', Self);
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConAbf := qryAbfIcm;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.btnSairAltClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  pLimpaListas;

  pSalvaSelecao;

  FreeAndNil(qryGenIte);
  FreeAndNil(qryItensEmpOrigem);
  FreeAndNil(qryAbfIcm);

  FreeAndNil(cdsAltGlo);
  FreeAndNil(cdsIteGlo);
end;

Procedure TfrmAlteracaoGeraldePrecosdeProdutos.pBeforePostMargem(dtsDtaSet: TDataSet);

  function fPrecoVenda(intOpc, intTabPrc: Integer; blnAplicaPerPreVen : Boolean = False): Double;
    Var
      fltIcmsST : Double;
      blnCalcSt : Boolean;
      strCodSit : String;
      fltPreComLiq : Double;
  begin
    With dtsDtaSet Do
    Begin
      fltPreComLiq := fCalculaPrecoCompraLiq(FieldByName('ITE_PRECOM_NOV').AsFloat,
                                             FieldByName('ITE_DESF01_NOV').AsFloat,
                                             FieldByName('ITE_DESF02_NOV').AsFloat,
                                             FieldByName('ITE_DESF03_NOV').AsFloat,
                                             FieldByName('ITE_DESF04_NOV').AsFloat,
                                             FieldByName('ITE_DESF05_NOV').AsFloat,
                                             FieldByName('ITE_DESF06_NOV').AsFloat,
                                             FieldByName('DECUNI').AsInteger,
                                             (FieldByName('ITE_PREDOL_NOV').AsString = 'S'));

      strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [FieldByName('ITE_CODABF').AsString, FieldByName('EMP_ESTEMP').AsString]);
      fltIcmsST := fGetIcmsSTParteVenda(FieldByName('ITE_CODABF').AsString,
                                        '_SAI_CCO', strCodSit, FieldByName('EMP_ESTEMP').AsString,
                                        fltPreComLiq, FieldByName('ITE_IPIENT_NOV').AsFloat,
                                        FieldByName('ITE_ICMSAI_NOV').AsFloat,
                                        strEstEmp, blnCalcSt);

      Result := fCalculaPrecoVenda(intOpc, FieldByName('ITE_PRECUS_NOV').AsFloat +
                                           FieldByName('ITE_OUTVAL_NOV').AsFloat,
                                           FieldByName('ITE_PREVE' + IntToStr(intTabPrc) + '_NOV').AsFloat * IIF(blnAplicaPerPreVen, fltPMarLq, 1),
                                           FieldByName('ITE_MARBR' + IntToStr(intTabPrc) + '_NOV').AsFloat,
                                           FieldByName('ITE_ICMSAI_NOV').AsFloat,
                                           FieldByName('ITE_IMPFED_NOV').AsFloat,
                                           FieldByName('ITE_DESOPE_NOV').AsFloat,
                                           FieldByName('ITE_COMTB' + IntToStr(intTabPrc) + '_NOV').AsFloat,
                                           FieldByName('MARMKP').AsString,
                                           FieldByName('PCMPRO').AsString,
                                           FieldByName('DECUNI').AsInteger,
                                           fltIcmsST,
                                           blnCalcSt);
    End;
  end;

  Var
    intTabPrc: Integer;
Begin
  For intTabPrc := 1 To 7 Do
  With dtsDtaSet Do
  Begin
    FieldByName('ITE_PREVE' + IntToStr(intTabPrc) + '_NOV').AsFloat := fPrecoVenda(1, intTabPrc, False);
    FieldByName('ITE_MARLQ' + IntToStr(intTabPrc) + '_NOV').AsFloat := fPrecoVenda(2, intTabPrc, True);
  End;

End;

Function TfrmAlteracaoGeraldePrecosdeProdutos.fCorrigeMargensNegativas: Boolean;

  Function fRetFiltroNegativos: String;
    Var
      intContador: Integer;
  Begin
    Result := '';

    For intContador := 1 To 7 Do
      if VS_strTabPrc[intContador] = 'S' Then
      Begin
        If Not fEmptyStr(Result) Then
          Result := Result + ' OR ';

        Result := Result + ' (ITE_MARLQ' + IntToStr(intContador) + '_NOV < 0) ';
      End
  End;

  Procedure pMarcaNegativos;
  Begin
    With cdsIteGlo Do
    Begin
      First;
      While Not Eof Do
      Begin
        Edit;
        FieldByName('MARNEG').AsInteger := 1;
        Post;

        Next;
      End;

      Filter   := 'MARNEG = 1';
      Filtered := True;

      First;
    End;
  End;

Begin
  If Not blnLiqNeg Then
  Begin
    Result := True;
    Exit;
  End;

  Try
    With cdsIteGlo Do
    Begin
      DisableControls;

      Filter   := fRetFiltroNegativos;
      Filtered := True;

      If IsEmpty  Then
      Begin
        Result   := True;
        Filter   := '';
        Filtered := False;
      End Else
      Begin

        pMarcaNegativos;

        BeforePost := pBeforePostMargem;

        EnableControls;

        pCriarFormularios(TfrmAltPrecoGlobalMargemNeg, frmAltPrecoGlobalMargemNeg);

        frmAltPrecoGlobalMargemNeg.cdsIteGlo := cdsIteGlo;

        frmAltPrecoGlobalMargemNeg.strFilter := fRetFiltroNegativos;

        Result := frmAltPrecoGlobalMargemNeg.ShowModal = mrOk;

        FreeAndNil(frmAltPrecoGlobalMargemNeg);
      End;

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmAlteracaoGeraldePrecosdeProdutos.fCorrigeMargensNegativas]');
      Result := False;
    End;
  End;

  With cdsIteGlo Do
  Begin
    EnableControls;
    Filter   := '';
    Filtered := False;
    BeforePost := Nil;
  End;

End;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.btnConfirmaClick(Sender: TObject);
  Var
    blnConfirma: Boolean;
    blnBlockMarLq : Boolean;
begin
  inherited;

  If (Not btnConfirma.Enabled) Then
    Exit;

  If Not fVerificaCampos Then
    Exit;

  blnConfirma := False;

  Screen.Cursor := crHourGlass;

  btnConfirma.Enabled    := False;
  btnSairAlt.Enabled     := False;

  If cdsIteGlo.Active Then
    cdsIteGlo.EmptyDataSet;


  If (Not fGeraVetorCampos) Then
  Begin
    fMensagem('', 'É necessário marcar pelo menos um campo para alteração!', ['&O k']);
    btnConfirma.Enabled    := True;
    btnSairAlt.Enabled     := True;
    Screen.Cursor          := crDefault;
    Exit;
  End;

  pCriaTabelaItens;

  blnBlockMarLq := False;
  If fGeraTabelaItens And fCorrigeMargensNegativas Then
  Begin

    Try
      pCriarFormularios(TfrmAltPrecoGlobalItens, frmAltPrecoGlobalItens);


      if blnBlockMarLq Then
      Begin
        frmAltPrecoGlobalItens.btnConfirma.Enabled := False;
        fMensagem('', 'Não será possível atualizar os itens devido a Margem Líquida Negativa!', ['&OK'])
      End;

      frmAltPrecoGlobalItens.dtsItens.DataSet := cdsIteGlo;
      frmAltPrecoGlobalItens.arrCamposGrid := arrCamposGrid;
      frmAltPrecoGlobalItens.lblAvisoAtivo.Visible := blnAvisoAtivo;
      frmAltPrecoGlobalItens.blnGeral := True;
      frmAltPrecoGlobalItens.showModal;

      blnConfirma := frmAltPrecoGlobalItens.blnConfirma;

    Except
      On E: Exception Do
      Begin
        blnConfirma := False;
        pMensagensErro(E.Message, '[frmAlteracaoGeraldePrecosdeProdutos.btnConfirmaClick]');
      End;
    End;

    pFreeAndNil(frmAltPrecoGlobalItens);

  End;

  btnConfirma.Enabled    := True;
  btnSairAlt.Enabled     := True;
  Screen.Cursor          := crDefault;

  If blnConfirma Then
  Begin
    pLimparTela;
  End;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCriaTabelaItens;
  Var
    strSQL: String;
    qryGen: TUniQuery;
    intCorre: Integer;

begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';


  strSQL := strSQL + '  0 AS MARNEG, ';
  strSQL := strSQL + '  G.ITE_CODEMP, ';
  strSQL := strSQL + '  I.ITE_CODGRU, ';
  strSQL := strSQL + '  I.ITE_CODFOR, ';

  strSQL := strSQL + '  G.ITE_TCIFCU, ';
  strSQL := strSQL + '  G.ITE_TCIFCU AS "ITE_TCIFCU_NOV", ';
  strSQL := strSQL + '  G.ITE_TSCUST, ';
  strSQL := strSQL + '  G.ITE_TSCUST AS "ITE_TSCUST_NOV", ';
  strSQL := strSQL + '  G.ITE_DEPICO, ';
  strSQL := strSQL + '  G.ITE_DEPICO AS "ITE_DEPICO_NOV", ';
  strSQL := strSQL + '  G.ITE_DEICMS, ';
  strSQL := strSQL + '  G.ITE_DEICMS AS "ITE_DEICMS_NOV", ';
  strSQL := strSQL + '  G.ITE_FATREG, ';
  strSQL := strSQL + '  G.ITE_FATREG AS "ITE_FATREG_NOV", ';

  strSQL := strSQL + '  MARMKP.SIS_VALCFG  AS MARMKP, ';
  strSQL := strSQL + '  DECUNI.SIS_VALCFG  AS DECUNI, ';
  strSQL := strSQL + '  PCMPRO.SIS_VALCFG  AS PCMPRO, ';
  strSQL := strSQL + '  CADCID.CID_ESTADO  AS EMP_ESTEMP, ';

  strSQL := strSQL + '  I.ITE_CODITE, ';
  strSQL := strSQL + '  I.ITE_DESITE, ';
  strSQL := strSQL + '  0.00 AS ITE_SALDOS, ';

  strSQL := strSQL + '  G.ITE_SAL_ML, ';
  strSQL := strSQL + '  I.ITE_CNV_ML, ';
  If fCfgSis('TPABPC') = '1' Then
  Begin
    strSQL := strSQL + '  I.ITE_ABFPIS, ';
    strSQL := strSQL + '  I.ITE_ABFPIS AS "ITE_ABFPIS_NOV", ';
    strSQL := strSQL + '  I.ITE_ABFCOF, ';
    strSQL := strSQL + '  I.ITE_ABFCOF AS "ITE_ABFCOF_NOV", ';
    strSQL := strSQL + '  I.ITE_ABFIPI, ';
    strSQL := strSQL + '  I.ITE_ABFIPI AS "ITE_ABFIPI_NOV", ';
  End
  Else
  Begin
    strSQL := strSQL + '  G.ITE_ABFPIS, ';
    strSQL := strSQL + '  G.ITE_ABFPIS AS "ITE_ABFPIS_NOV", ';
    strSQL := strSQL + '  G.ITE_ABFCOF, ';
    strSQL := strSQL + '  G.ITE_ABFCOF AS "ITE_ABFCOF_NOV", ';
    strSQL := strSQL + '  G.ITE_ABFIPI, ';
    strSQL := strSQL + '  G.ITE_ABFIPI AS "ITE_ABFIPI_NOV", ';
  End;


  If fCfgSis('ENTFUT', varBoolean) And MatchStr(fCfgSis('CALSAL'), ['1', '3', '4', '5']) Then
    strSQL := strSQL + '  ROUND((G.ITE_SALDOS * IF(IFNULL(ITE_CNV_ML,0) <= 0, 1, ITE_CNV_ML)) + G.ITE_QTEF_A + G.ITE_QTEF_F + G.ITE_QTEF_P, 3) AS "SaldoNumerico", '
  Else
    strSQL := strSQL + '  ROUND((G.ITE_SALDOS * IF(IFNULL(ITE_CNV_ML,0) <= 0, 1, ITE_CNV_ML)), 3) AS "SaldoNumerico", ';

  strSQL := strSQL + '  IFNULL(G.ITE_PREDOL, "N") AS ITE_PREDOL, ';
  strSQL := strSQL + '  IFNULL(G.ITE_PREDOL, "N") AS ITE_PREDOL_NOV, ';

  strSQL := strSQL + '  G.ITE_PRAMIN, ';
  strSQL := strSQL + '  G.ITE_PRAMIN AS "ITE_PRAMIN_NOV", ';

  strSQL := strSQL + '  G.ITE_IMPLIS, ';
  strSQL := strSQL + '  G.ITE_IMPLIS AS "ITE_IMPLIS_NOV", ';

  strSQL := strSQL + '  G.ITE_SITPRO, ';
  strSQL := strSQL + '  G.ITE_SITPRO AS "ITE_SITPRO_NOV", ';

  If blnValFor Then
  Begin
    strSQL := strSQL + '  G.ITE_DTAVAL, ';
    strSQL := strSQL + '  G.ITE_DTAVAL AS "ITE_DTAVAL_NOV", ';
  End;

  strSQL := strSQL + '  G.ITE_CPRCEN, ';
  strSQL := strSQL + '  G.ITE_CPRCEN AS "ITE_CPRCEN_NOV", ';
  strSQL := strSQL + '  G.ITE_ABAMLT, ';
  strSQL := strSQL + '  G.ITE_ABAMLT AS "ITE_ABAMLT_NOV", ';
  strSQL := strSQL + '  G.ITE_DESCHK, ';
  strSQL := strSQL + '  G.ITE_PRECOM, ';
  strSQL := strSQL + '  G.ITE_PRECOM AS "ITE_PRECOM_NOV", ';
  strSQL := strSQL + '  G.ITE_PREVE1, ';
  strSQL := strSQL + '  G.ITE_PREVE1 AS "ITE_PREVE1_NOV", ';
  strSQL := strSQL + '  G.ITE_PREVE2, ';
  strSQL := strSQL + '  G.ITE_PREVE2 AS "ITE_PREVE2_NOV", ';
  strSQL := strSQL + '  G.ITE_PREVE3, ';
  strSQL := strSQL + '  G.ITE_PREVE3 AS "ITE_PREVE3_NOV", ';
  strSQL := strSQL + '  G.ITE_PREVE4, ';
  strSQL := strSQL + '  G.ITE_PREVE4 AS "ITE_PREVE4_NOV", ';
  strSQL := strSQL + '  G.ITE_PREVE5, ';
  strSQL := strSQL + '  G.ITE_PREVE5 AS "ITE_PREVE5_NOV", ';
  strSQL := strSQL + '  G.ITE_PREVE6, ';
  strSQL := strSQL + '  G.ITE_PREVE6 AS "ITE_PREVE6_NOV", ';
  strSQL := strSQL + '  G.ITE_PREVE7, ';
  strSQL := strSQL + '  G.ITE_PREVE7 AS "ITE_PREVE7_NOV", ';
  strSQL := strSQL + '  G.ITE_DESF01, ';
  strSQL := strSQL + '  G.ITE_DESF01 AS "ITE_DESF01_NOV", ';
  strSQL := strSQL + '  G.ITE_DESF02, ';
  strSQL := strSQL + '  G.ITE_DESF02 AS "ITE_DESF02_NOV", ';
  strSQL := strSQL + '  G.ITE_DESF03, ';
  strSQL := strSQL + '  G.ITE_DESF03 AS "ITE_DESF03_NOV", ';
  strSQL := strSQL + '  G.ITE_DESF04, ';
  strSQL := strSQL + '  G.ITE_DESF04 AS "ITE_DESF04_NOV", ';
  strSQL := strSQL + '  G.ITE_DESF05, ';
  strSQL := strSQL + '  G.ITE_DESF05 AS "ITE_DESF05_NOV", ';
  strSQL := strSQL + '  G.ITE_DESF06, ';
  strSQL := strSQL + '  G.ITE_DESF06 AS "ITE_DESF06_NOV", ';
  strSQL := strSQL + '  G.ITE_ICMENT, ';
  strSQL := strSQL + '  G.ITE_ICMENT AS "ITE_ICMENT_NOV", ';
  strSQL := strSQL + '  G.ITE_SUBFED, ';
  strSQL := strSQL + '  G.ITE_SUBFED AS "ITE_SUBFED_NOV", ';
  strSQL := strSQL + '  G.ITE_IPIENT, ';
  strSQL := strSQL + '  G.ITE_IPIENT AS "ITE_IPIENT_NOV", ';
  strSQL := strSQL + '  G.ITE_IPISAI, ';
  strSQL := strSQL + '  G.ITE_IPISAI AS "ITE_IPISAI_NOV", ';
  strSQL := strSQL + '  G.ITE_FREENT, ';
  strSQL := strSQL + '  G.ITE_FREENT AS "ITE_FREENT_NOV", ';
  strSQL := strSQL + '  G.ITE_VALFRE, ';
  strSQL := strSQL + '  G.ITE_VALFRE AS "ITE_VALFRE_NOV", ';
  strSQL := strSQL + '  G.ITE_ACRFIN, ';
  strSQL := strSQL + '  G.ITE_ACRFIN AS "ITE_ACRFIN_NOV", ';
  strSQL := strSQL + '  G.ITE_SUBSTI, ';
  strSQL := strSQL + '  G.ITE_SUBSTI AS "ITE_SUBSTI_NOV", ';
  strSQL := strSQL + '  G.ITE_DESADB, ';
  strSQL := strSQL + '  G.ITE_DESADB AS "ITE_DESADB_NOV", ';
  strSQL := strSQL + '  G.ITE_IMPFED, ';
  strSQL := strSQL + '  G.ITE_IMPFED AS "ITE_IMPFED_NOV", ';
  strSQL := strSQL + '  G.ITE_DESOPE, ';
  strSQL := strSQL + '  G.ITE_DESOPE AS "ITE_DESOPE_NOV", ';
  strSQL := strSQL + '  G.ITE_ICMSAI, ';
  strSQL := strSQL + '  G.ITE_ICMSAI AS "ITE_ICMSAI_NOV", ';

  If Not blnIteTbp Then
  Begin
    strSQL := strSQL + '  G.ITE_DESMAX, ';
    strSQL := strSQL + '  G.ITE_DESMAX AS "ITE_DESMAX_NOV", ';
    strSQL := strSQL + '  G.ITE_DESMGE, ';
    strSQL := strSQL + '  G.ITE_DESMGE AS "ITE_DESMGE_NOV", ';
    strSQL := strSQL + '  G.ITE_DESMSU, ';
    strSQL := strSQL + '  G.ITE_DESMSU AS "ITE_DESMSU_NOV", ';
  End
  Else
  Begin
    For intCorre := 1 To Length(VS_strTabPrc) Do
      strSQL := strSQL + fAddIteTbp(intCorre);
  End;

  strSQL := strSQL + '  G.ITE_PRECUS, ';
  strSQL := strSQL + '  G.ITE_PRECUS AS "ITE_PRECUS_NOV", ';
  strSQL := strSQL + '  G.ITE_OUTVAL, ';
  strSQL := strSQL + '  G.ITE_OUTVAL AS "ITE_OUTVAL_NOV", ';
  strSQL := strSQL + '  G.ITE_MARBR1, ';
  strSQL := strSQL + '  G.ITE_MARBR1 AS "ITE_MARBR1_NOV", ';
  strSQL := strSQL + '  G.ITE_MARBR2, ';
  strSQL := strSQL + '  G.ITE_MARBR2 AS "ITE_MARBR2_NOV", ';
  strSQL := strSQL + '  G.ITE_MARBR3, ';
  strSQL := strSQL + '  G.ITE_MARBR3 AS "ITE_MARBR3_NOV", ';
  strSQL := strSQL + '  G.ITE_MARBR4, ';
  strSQL := strSQL + '  G.ITE_MARBR4 AS "ITE_MARBR4_NOV", ';
  strSQL := strSQL + '  G.ITE_MARBR5, ';
  strSQL := strSQL + '  G.ITE_MARBR5 AS "ITE_MARBR5_NOV", ';
  strSQL := strSQL + '  G.ITE_MARBR6, ';
  strSQL := strSQL + '  G.ITE_MARBR6 AS "ITE_MARBR6_NOV", ';
  strSQL := strSQL + '  G.ITE_MARBR7, ';
  strSQL := strSQL + '  G.ITE_MARBR7 AS "ITE_MARBR7_NOV", ';

  strSQL := strSQL + ' 0.00 AS ITE_MARLQ1, ';
  strSQL := strSQL + ' 0.00 AS "ITE_MARLQ1_NOV", ';
  strSQL := strSQL + ' 0.00 AS ITE_MARLQ2, ';
  strSQL := strSQL + ' 0.00 AS "ITE_MARLQ2_NOV", ';
  strSQL := strSQL + ' 0.00 AS ITE_MARLQ3, ';
  strSQL := strSQL + ' 0.00 AS "ITE_MARLQ3_NOV", ';
  strSQL := strSQL + ' 0.00 AS ITE_MARLQ4, ';
  strSQL := strSQL + ' 0.00 AS "ITE_MARLQ4_NOV", ';
  strSQL := strSQL + ' 0.00 AS ITE_MARLQ5, ';
  strSQL := strSQL + ' 0.00 AS "ITE_MARLQ5_NOV", ';
  strSQL := strSQL + ' 0.00 AS ITE_MARLQ6, ';
  strSQL := strSQL + ' 0.00 AS "ITE_MARLQ6_NOV", ';
  strSQL := strSQL + ' 0.00 AS ITE_MARLQ7, ';
  strSQL := strSQL + ' 0.00 AS "ITE_MARLQ7_NOV", ';

  If fCfgSis('MARIDE', VarBoolean) Then
  Begin
    strSQL := strSQL + '  G.ITE_MARID1, ';
    strSQL := strSQL + '  G.ITE_MARID1 AS "ITE_MARID1_NOV", ';
    strSQL := strSQL + '  G.ITE_MARID2, ';
    strSQL := strSQL + '  G.ITE_MARID2 AS "ITE_MARID2_NOV", ';
    strSQL := strSQL + '  G.ITE_MARID3, ';
    strSQL := strSQL + '  G.ITE_MARID3 AS "ITE_MARID3_NOV", ';
    strSQL := strSQL + '  G.ITE_MARID4, ';
    strSQL := strSQL + '  G.ITE_MARID4 AS "ITE_MARID4_NOV", ';
    strSQL := strSQL + '  G.ITE_MARID5, ';
    strSQL := strSQL + '  G.ITE_MARID5 AS "ITE_MARID5_NOV", ';
    strSQL := strSQL + '  G.ITE_MARID6, ';
    strSQL := strSQL + '  G.ITE_MARID6 AS "ITE_MARID6_NOV", ';
    strSQL := strSQL + '  G.ITE_MARID7, ';
    strSQL := strSQL + '  G.ITE_MARID7 AS "ITE_MARID7_NOV", ';
  End;

  strSQL := strSQL + '  G.ITE_COMTB1, ';
  strSQL := strSQL + '  G.ITE_COMTB1 AS "ITE_COMTB1_NOV", ';
  strSQL := strSQL + '  G.ITE_COMTB2, ';
  strSQL := strSQL + '  G.ITE_COMTB2 AS "ITE_COMTB2_NOV", ';
  strSQL := strSQL + '  G.ITE_COMTB3, ';
  strSQL := strSQL + '  G.ITE_COMTB3 AS "ITE_COMTB3_NOV", ';
  strSQL := strSQL + '  G.ITE_COMTB4, ';
  strSQL := strSQL + '  G.ITE_COMTB4 AS "ITE_COMTB4_NOV", ';
  strSQL := strSQL + '  G.ITE_COMTB5, ';
  strSQL := strSQL + '  G.ITE_COMTB5 AS "ITE_COMTB5_NOV", ';
  strSQL := strSQL + '  G.ITE_COMTB6, ';
  strSQL := strSQL + '  G.ITE_COMTB6 AS "ITE_COMTB6_NOV", ';
  strSQL := strSQL + '  G.ITE_COMTB7, ';
  strSQL := strSQL + '  G.ITE_COMTB7 AS "ITE_COMTB7_NOV", ';
  strSQL := strSQL + '  G.ITE_COMVAR, ';
  strSQL := strSQL + '  G.ITE_COMVAR AS "ITE_COMVAR_NOV", ';
  strSQL := strSQL + '  G.ITE_COMATA, ';
  strSQL := strSQL + '  G.ITE_COMATA AS "ITE_COMATA_NOV", ';
  strSQL := strSQL + '  G.ITE_COMDIS, ';
  strSQL := strSQL + '  G.ITE_COMDIS AS "ITE_COMDIS_NOV", ';
  strSQL := strSQL + '  G.ITE_COMDIG, ';
  strSQL := strSQL + '  G.ITE_COMDIG AS "ITE_COMDIG_NOV", ';
  strSQL := strSQL + '  G.ITE_COMMEC, ';
  strSQL := strSQL + '  G.ITE_COMMEC AS "ITE_COMMEC_NOV", ';
  strSQL := strSQL + '  G.ITE_COMPRO, ';
  strSQL := strSQL + '  G.ITE_COMPRO AS "ITE_COMPRO_NOV", ';
  strSQL := strSQL + '  G.ITE_QTPPRO, ';
  strSQL := strSQL + '  G.ITE_QTPPRO AS "ITE_QTPPRO_NOV", ';

  strSQL := strSQL + '  G.ITE_LOCFIS, ';
  strSQL := strSQL + '  G.ITE_LOCFIS AS "ITE_LOCFIS_NOV", ';
  strSQL := strSQL + '  G.ITE_TAMLCF, ';
  strSQL := strSQL + '  G.ITE_TAMLCF AS "ITE_TAMLCF_NOV", ';
  strSQL := strSQL + '  G.ITE_LOCSUP, ';
  strSQL := strSQL + '  G.ITE_LOCSUP AS "ITE_LOCSUP_NOV", ';
  strSQL := strSQL + '  G.ITE_TAMLCS, ';
  strSQL := strSQL + '  G.ITE_TAMLCS AS "ITE_TAMLCS_NOV", ';
  strSQL := strSQL + '  G.ITE_CODLSE, ';
  strSQL := strSQL + '  G.ITE_CODLSE AS "ITE_CODLSE_NOV", ';
  strSQL := strSQL + '  G.ITE_MARMIN, ';
  strSQL := strSQL + '  G.ITE_MARMIN AS "ITE_MARMIN_NOV", ';
  strSQL := strSQL + '  G.ITE_MARMSG, ';
  strSQL := strSQL + '  G.ITE_MARMSG AS "ITE_MARMSG_NOV", ';
  strSQL := strSQL + '  G.ITE_MARMGE, ';
  strSQL := strSQL + '  G.ITE_MARMGE AS "ITE_MARMGE_NOV", ';

  strSQL := strSQL + '  G.ITE_CPESOB, ';
  strSQL := strSQL + '  G.ITE_CPESOB AS "ITE_CPESOB_NOV", ';

  strSQL := strSQL + '  G.ITE_RECDEV, ';
  strSQL := strSQL + '  G.ITE_RECDEV AS "ITE_RECDEV_NOV", ';


  strSQL := strSQL + '  G.ITE_NIVCRI, ';
  strSQL := strSQL + '  G.ITE_NIVCRI AS "ITE_NIVCRI_NOV", ';


  strSQL := strSQL + '  DE.ITE_DESSIT, ';
  strSQL := strSQL + '  DE.ITE_DESSIT AS "ITE_DESSIT_NOV", ';

  strSQL := strSQL + '  DE.ITE_CRODOC, ';
  strSQL := strSQL + '  DE.ITE_CRODOC AS "ITE_CRODOC_NOV", ';

  strSQL := strSQL + ' IF((SELECT COUNT(1) FROM ITEEMB ';
  strSQL := strSQL + '      WHERE ITB_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '      AND ITB_CODEMP = G.ITE_CODEMP) > 0,"Sim","Não") ';
  strSQL := strSQL + ' AS ITE_POSEMB, ';

  strSQL := strSQL + '  I.ITE_CODUNI, ';
  strSQL := strSQL + '  I.ITE_CODUNI AS "ITE_CODUNI_NOV", ';

  strSQL := strSQL + '  I.ITE_UNICOM, ';
  strSQL := strSQL + '  I.ITE_UNICOM AS "ITE_UNICOM_NOV", ';

  strSQL := strSQL + '  DE.ITE_EXPALT, ';
  strSQL := strSQL + '  DE.ITE_EXPALT AS "ITE_EXPALT_NOV", ';

  strSQL := strSQL + '  DE.ITE_EXPLAR, ';
  strSQL := strSQL + '  DE.ITE_EXPLAR AS "ITE_EXPLAR_NOV", ';

  strSQL := strSQL + '  DE.ITE_EXPPRO, ';
  strSQL := strSQL + '  DE.ITE_EXPPRO AS "ITE_EXPPRO_NOV", ';


  strSQL := strSQL + '  G.ITE_MINTB1, ';
  strSQL := strSQL + '  G.ITE_MINTB1 AS "ITE_MINTB1_NOV", ';
  strSQL := strSQL + '  G.ITE_MINTB2, ';
  strSQL := strSQL + '  G.ITE_MINTB2 AS "ITE_MINTB2_NOV", ';
  strSQL := strSQL + '  G.ITE_MINTB3, ';
  strSQL := strSQL + '  G.ITE_MINTB3 AS "ITE_MINTB3_NOV", ';
  strSQL := strSQL + '  G.ITE_MINTB4, ';
  strSQL := strSQL + '  G.ITE_MINTB4 AS "ITE_MINTB4_NOV", ';
  strSQL := strSQL + '  G.ITE_MINTB5, ';
  strSQL := strSQL + '  G.ITE_MINTB5 AS "ITE_MINTB5_NOV", ';
  strSQL := strSQL + '  G.ITE_MINTB6, ';
  strSQL := strSQL + '  G.ITE_MINTB6 AS "ITE_MINTB6_NOV", ';
  strSQL := strSQL + '  G.ITE_MINTB7, ';
  strSQL := strSQL + '  G.ITE_MINTB7 AS "ITE_MINTB7_NOV", ';

  {******************}
  {* ESTOQUE MÍNIMO *}
  {***************RV*}
  strSQL := strSQL + '  G.ITE_ESTMIN, ';
  strSQL := strSQL + '  G.ITE_ESTMIN AS "ITE_ESTMIN_NOV", ';
  {******************}
  {* ESTOQUE MÁXIMO *}
  {***************RV*}
  strSQL := strSQL + '  G.ITE_ESTMAX, ';
  strSQL := strSQL + '  G.ITE_ESTMAX AS "ITE_ESTMAX_NOV", ';

  strSQL := strSQL + '  G.ITE_TIPPRO, ';
  strSQL := strSQL + '  G.ITE_TIPPRO AS "ITE_TIPPRO_NOV",  ';

  strSQL := strSQL + '  G.ITE_PESOBR, ';
  strSQL := strSQL + '  G.ITE_PESOBR AS "ITE_PESOBR_NOV",  ';

  strSQL := strSQL + '  "M" AS ITE_MARDES                 ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + '  JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE ' +
                     '               AND G.ITE_CODEMP IS NULL ';

  strSQL := strSQL + '  JOIN CADEMP ON EMP_CODEMP = G.ITE_CODEMP ';
  strSQL := strSQL + '  JOIN CADCID ON CID_CODCID = EMP_CODCID ';
  strSQL := strSQL + '  JOIN CFGSIS MARMKP ON MARMKP.SIS_CODCFG = "CFG_MARMKP" AND MARMKP.SIS_CODEMP = G.ITE_CODEMP ';
  strSQL := strSQL + '  JOIN CFGSIS DECUNI ON DECUNI.SIS_CODCFG = "CFG_DECUNI" AND DECUNI.SIS_CODEMP = G.ITE_CODEMP ';
  strSQL := strSQL + '  JOIN CFGSIS PCMPRO ON PCMPRO.SIS_CODCFG = "CFG_PCMPRO" AND PCMPRO.SIS_CODEMP = G.ITE_CODEMP ';

  strSQL := strSQL + '  LEFT JOIN DESSIT DE ON I.ITE_CODITE = DE.ITE_CODITE ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  I.ITE_CODITE IS NULL ';

  qryGen := fCriarQuery(strSQL, Self);
  qryGen.Open;
  pSetaClient(qryGen);
  dspIteGlo.DataSet := qryGen;

  cdsIteGlo.Close;
  cdsIteGlo.Open;
  pSetaClient(cdsIteGlo);

  TFloatField(cdsIteGlo.FieldByName('ITE_SALDOS')).DisplayFormat := '#,##0.000';


  FreeAndNil(qryGen);
end;

function TfrmAlteracaoGeraldePrecosdeProdutos.fRetornaNumeric(strMascara: String): String;
  Var
    intPrecisao: Integer;
begin
  strMascara := AnsiReplaceStr(strMascara, '#', '');
  strMascara := AnsiReplaceStr(strMascara, ',', '');

  intPrecisao := Length(Copy(strMascara, Pos('.', strMascara)+1, Length(strMascara)));

  Result := 'NUMERIC(12, ' + IntToStr(intPrecisao) + ')';
end;

function TfrmAlteracaoGeraldePrecosdeProdutos.fCampoPorNome(Var arrCampos: Array Of TCampoGlobal;
  strNomeCampo: String): TCampoGlobal;
  Var
    intContador: Integer;
    intTamMat: Integer;
begin
  Fillchar(Result, SizeOf(Result), #0);
  intContador := 0;
  intTamMat := Length(arrCampos);

  While intContador < intTamMat Do
  Begin
    If arrCampos[intContador].strNomCam = strNomeCampo Then
    Begin
      Result := arrCampos[intContador];
      Break;
    End;
    Inc(intContador);
  End;
end;

function TfrmAlteracaoGeraldePrecosdeProdutos.fGeraTabelaItens: Boolean;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    With frmGravando Do
    Begin
      frmGravando.blnTempoRestante := True;
      fExecutarAcao := fGeraTabelaItensAux;
      lblGravando.Caption := 'Aguarde, selecionando itens...';
      ShowModal;
      Result := blnConfirma;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmAltPrecoIndividual.fGeraTabelaItens]');
      Result := False;
    End;
  End;

  FreeAndNil(frmGravando);
End;

{******************************************}
{* GERA A TABELA TEMPORARIA COM OS CAMPOS *}
{* ALTERADOS E SEUS NOVOS VALORES         *}
{***************************************MV*}

function TfrmAlteracaoGeraldePrecosdeProdutos.fSelecionaEmpresasEmUso(var AEmpresaDestino: String; var AEmpresaOrigem: String): String;
var Lista: TStringList;
    I : Integer;
begin
  cdsAltGlo.DisableControls;
  Try
    cdsAltGlo.Filtered := False;
    cdsAltGlo.Filter := 'ITE_ALTERA = ' + QuotedStr('S');
    cdsAltGlo.Filtered := True;
    cdsAltGlo.First;
    while not cdsAltGlo.Eof Do
    Begin
      AEmpresaOrigem := AEmpresaOrigem + ',' + cdsAltGloITE_EMPORI.AsString;
      AEmpresaDestino := AEmpresaDestino + ',' + cdsAltGloITE_EMPDES.AsString;
      cdsAltGlo.Next;
    End;
    Lista := TStringList.Create;
    Lista.Delimiter :=  ',';
    Lista.CommaText := AEmpresaDestino;

    AEmpresaDestino := '';

    For i := 0 To Lista.Count - 1 do
    Begin
      If Lista[i] <> '' Then
        If pos(Lista[i], AEmpresaDestino) <= 0 Then
          AEmpresaDestino := AEmpresaDestino + QuotedStr(Lista[i]) + ',';
    End;
    Delete(AEmpresaDestino, Length(AEmpresaDestino), 1);

    Lista.CommaText := AEmpresaOrigem;
    AEmpresaOrigem := '';
    For i := 0 To Lista.Count - 1 do
    Begin
      If Lista[i] <> '' Then
        If pos(Lista[i], AEmpresaOrigem) <= 0 Then
          AEmpresaOrigem := AEmpresaOrigem + QuotedStr(Lista[i]) + ',';
    End;
    Delete(AEmpresaOrigem, Length(AEmpresaOrigem), 1);

    //Insere quoted para usar no sql;
{    AEmpresaDestino := QuotedStr('') +  Trim(StringReplace(AEmpresaDestino, ',', QuotedStr(','), [])) + QuotedStr('');
    AEmpresaOrigem  := QuotedStr('') +  Trim(StringReplace(AEmpresaOrigem , ',', QuotedStr(','), [])) + QuotedStr('');}

  Finally
    cdsAltGlo.First;
    cdsAltGlo.Filtered := False;
    cdsAltGlo.EnableControls;
  End;
end;


function TfrmAlteracaoGeraldePrecosdeProdutos.fGeraTabelaItensAux(pgbProgresso2: TcxProgressBar): Boolean;
  Var
    strEmpresasDestino,
    strEmpresasOrigem: String;

    intIndice       : Integer;
    fltPreCusNov: Double;
    blnProcessado: Boolean;
    blnAltPreven,
    blnAltMarBru,
    blnJaAdicionouCampos_PREVE_MARBR,
    blnUtilizarConversorDeMoedas,
    blnAltPrecus: Boolean;
    intTblPrc : Integer;

    cpcParams : TParCalculaPrecoCusto;

    objConversor: IConversorMoedaCusto;

    procedure pAdicionaCampoGrid(strNomeCampo: String);
      Var
        intTamMatCampos: Integer;
        intContadorLocal: integer;
        recGlobal: TCampoGlobal;
    begin
      recGlobal := fCampoPorNome(arrCamposGlobal, strNomeCampo);

      If Not recGlobal.strNomCam.IsEmpty Then
      Begin
        intTamMatCampos := Length(arrCamposGrid);

        For intContadorLocal := 0 To intTamMatCampos -1 Do
          If arrCamposGrid[intContadorLocal].strNomCam = strNomeCampo Then
            Exit;

        SetLength(arrCamposGrid, intTamMatCampos+1);
        arrCamposGrid[intTamMatCampos] := recGlobal;
      End;
    end;

    function fTRataCampoValorNovo(AField: String): Variant;
    begin
      If qryGenIte.FieldByName(AField + '_NOV').IsNull Then
      Begin
        If qryGenIte.FieldByName(AField).DataType = ftFloat Then
          Result := qryGenIte.FieldByName(AField).AsFloat
        Else
          Result := qryGenIte.FieldByName(AField).AsString;
      End
      Else
      Begin
        If qryGenIte.FieldByName(AField + '_NOV').DataType = ftFloat Then
          Result := qryGenIte.FieldByName(AField + '_NOV').AsFloat
        Else
          Result := qryGenIte.FieldByName(AField + '_NOV').AsString;
       End
    end;

    function fPrecoVenda(intOpc, intTabPrc: Integer; blnAplicaPerPreVen : Boolean = False): Double;
      Var
        fltPreComLiq : Double;
        strCodSit : String;
        fltIcmsST : Double;
        blnCalcSt : Boolean;
    begin
      fltPreComLiq := fCalculaPrecoCompraLiq(fTrataCampoValorNovo('ITE_PRECOM'),
                                             fTrataCampoValorNovo('ITE_DESF01'),
                                             fTrataCampoValorNovo('ITE_DESF02'),
                                             fTrataCampoValorNovo('ITE_DESF03'),
                                             fTrataCampoValorNovo('ITE_DESF04'),
                                             fTrataCampoValorNovo('ITE_DESF05'),
                                             fTrataCampoValorNovo('ITE_DESF06'),
                                             qryGenIte.FieldByName('DECUNI').AsInteger,
                                             fTrataCampoValorNovo('ITE_PREDOL') = 'S');

      strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [qryGenIte.FieldByName('ITE_CODABF').AsString, qryGenIte.FieldByName('EMP_ESTEMP').AsString]);

      fltIcmsST := fGetIcmsSTParteVenda(qryGenIte.FieldByName('ITE_CODABF').AsString,
                                        '_SAI_CCO',
                                        strCodSit,
                                        qryGenIte.FieldByName('EMP_ESTEMP').Asstring,
                                        fltPreComLiq,
                                        fTrataCampoValorNovo('ITE_IPIENT'),
                                        fTrataCampoValorNovo('ITE_ICMSAI'),
                                        qryGenIte.FieldByName('EMP_ESTEMP').AsString,
                                        blnCalcSt,
                                        qryGenIte.FieldByName('MARMKP').Asstring);


      Result := fCalculaPrecoVenda(intOpc, fTrataCampoValorNovo('ITE_PRECUS') +
                                           fTrataCampoValorNovo('ITE_OUTVAL'),
                                           fTrataCampoValorNovo('ITE_PREVE' + IntToStr(intTabPrc)) * IIF(blnAplicaPerPreVen, fltPMarLq, 1),
                                           fTrataCampoValorNovo('ITE_MARBR' + IntToStr(intTabPrc)),
                                           fTrataCampoValorNovo('ITE_ICMSAI'),
                                           fTrataCampoValorNovo('ITE_IMPFED'),
                                           fTrataCampoValorNovo('ITE_DESOPE'),
                                           fTrataCampoValorNovo('ITE_COMTB' + IntToStr(intTabPrc)),
                                           qryGenIte.FieldByName('MARMKP').AsString,
                                           qryGenIte.FieldByName('PCMPRO').AsString,
                                           qryGenIte.FieldByName('DECUNI').AsInteger,
                                           fltIcmsST,
                                           blnCalcSt);
    end;

    function fPrecoVendaOld(intOpc, intTabPrc: Integer; blnAplicaPerPreVen : Boolean = False): Double;
      Var
        fltPreComLiq : Double;
        strCodSit : String;
        fltIcmsST : Double;
        blnCalcSt : Boolean;
    begin
      fltPreComLiq := fCalculaPrecoCompraLiq(qryGenIte.FieldByName('ITE_PRECOM').AsFloat,
                                             qryGenIte.FieldByName('ITE_DESF01').AsFloat,
                                             qryGenIte.FieldByName('ITE_DESF02').AsFloat,
                                             qryGenIte.FieldByName('ITE_DESF03').AsFloat,
                                             qryGenIte.FieldByName('ITE_DESF04').AsFloat,
                                             qryGenIte.FieldByName('ITE_DESF05').AsFloat,
                                             qryGenIte.FieldByName('ITE_DESF06').AsFloat,
                                             qryGenIte.FieldByName('DECUNI').AsInteger,
                                             (qryGenIte.FieldByName('ITE_PREDOL').AsString = 'S'));

      strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [qryGenIte.FieldByName('ITE_CODABF').AsString, qryGenIte.FieldByName('EMP_ESTEMP').Asstring]);

      fltIcmsST := fGetIcmsSTParteVenda(qryGenIte.FieldByName('ITE_CODABF').AsString,
                                        '_SAI_CCO', strCodSit, qryGenIte.FieldByName('EMP_ESTEMP').Asstring,
                                        fltPreComLiq, qryGenIte.FieldByName('ITE_IPIENT').AsFloat,
                                        qryGenIte.FieldByName('ITE_ICMSAI').AsFloat,
                                        qryGenIte.FieldByName('EMP_ESTEMP').Asstring,
                                        blnCalcSt,
                                        qryGenIte.FieldByName('MARMKP').Asstring);

      Result := fCalculaPrecoVenda(intOpc, qryGenIte.FieldByName('ITE_PRECUS').AsFloat +
                                           qryGenIte.FieldByName('ITE_OUTVAL').AsFloat,
                                           qryGenIte.FieldByName('ITE_PREVE' + IntToStr(intTabPrc)).AsFloat * IIF(blnAplicaPerPreVen, fltPMarLq, 1),
                                           qryGenIte.FieldByName('ITE_MARBR' + IntToStr(intTabPrc)).AsFloat,
                                           qryGenIte.FieldByName('ITE_ICMSAI').AsFloat,
                                           qryGenIte.FieldByName('ITE_IMPFED').AsFloat,
                                           qryGenIte.FieldByName('ITE_DESOPE').AsFloat,
                                           qryGenIte.FieldByName('ITE_COMTB' + IntToStr(intTabPrc)).AsFloat,
                                           '',
                                           '',
                                           -1,
                                           fltIcmsST,
                                           blnCalcSt);
    end;

    Procedure pAtualizaPrecosFator(fltNovPreVen: Double);
      Var
        intIndice: Integer;
    Begin
      If Not Assigned(objFatPre) Then
        Exit;

      For intIndice := 2 To 7 Do
      Begin
        If objFatPre.fTabelaAtiva(intIndice) Then
        Begin
          pAtualizaValorCampo('ITE_PREVE' + IntToStr(intIndice), objFatPre.fCalculaPrecoVendaFator(fTrataCampoValorNovo('ITE_PREVE' + IntToStr(intIndice)), intIndice));
          pAtualizaValorCampo('ITE_MARBR' + IntToStr(intIndice), fPrecoVenda(2, intIndice));
          pAdicionaCampoGrid('ITE_MARBR' + IntToStr(intIndice));
          pAdicionaCampoGrid('ITE_PREVE' + IntToStr(intIndice));
        End;
      End;

    End;

    procedure pAtualizaMargemLiquida(intTabPre : Integer);
    Begin
      if VS_strTabPrc[intTabPre] <> 'S' Then
        Exit;

      If Not blnLiqNeg Then
        Exit;

      pAtualizaValorCampo('ITE_MARLQ' + IntToStr(intTblPrc), fPrecoVenda(2, intTabPre, True) );
      pAtualizaValorCampo('ITE_MARLQ' + IntToStr(intTblPrc), fPrecoVendaOld(2, intTabPre, True) );

      pAdicionaCampoGrid('ITE_MARLQ' + IntToStr(intTblPrc));
    End;

    function  fCampoExigeRecalculoCusto(Acoluna: String): Boolean;
    Begin
      Result := (AColuna = 'ITE_PRECOM')Or
                (AColuna = 'ITE_DESF01')Or
                (AColuna = 'ITE_DESF02')Or
                (AColuna = 'ITE_DESF03')Or
                (AColuna = 'ITE_DESF04')Or
                (AColuna = 'ITE_DESF05')Or
                (AColuna = 'ITE_DESF06')Or
                (AColuna = 'ITE_ICMENT')Or
                (AColuna = 'ITE_IPIENT')Or
                (AColuna = 'ITE_FREENT')Or
                (AColuna = 'ITE_ACRFIN')Or
                (AColuna = 'ITE_SUBSTI')Or
                (AColuna = 'ITE_VALFRE')Or
                (AColuna = 'ITE_DESADB')Or
                (AColuna = 'ITE_SUBFED')OR
                (AColuna = 'ITE_TCIFCU')Or
                (AColuna = 'ITE_TSCUST')Or
                (AColuna = 'ITE_DEPICO')Or
                (AColuna = 'ITE_DEICMS')Or
                (AColuna = 'ITE_FATREG');
    End;
begin
  Try

    pgbProgresso2.Position       := 0;
    pgbProgresso2.Properties.Max := 0;
    Application.ProcessMessages;

    fSelecionaEmpresasEmUso(strEmpresasDestino, strEmpresasOrigem);
    cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

    Result := True;

    pSetaQryItensEmpresa(qryItensEmpOrigem, strEmpresasOrigem);
    pSetaQryItensEmpresa(qryGenIte.qryQuery , '', strEmpresasDestino);

    qryGenIte.fAbreClient(True, '[TfrmAlteracaoGeraldePrecosdeProdutos.fGeraTabelaItensAux]');


    cdsAltGlo.Filtered := False;
    cdsAltGlo.Filter := 'ITE_ALTERA = ' + QuotedStr('S');
    cdsAltGlo.Filtered := True;



    If qryItensEmpOrigem.IsEmpty Then
    Begin
      Result := False;
      fMensagem('', 'Não há itens para serem alterados!', ['&O k']);
      Exit;
    End;

    qryItensEmpOrigem.KeyFields := 'ITE_CODEMP;ITE_CODITE';
    qryItensEmpOrigem.IndexFieldNames := 'ITE_CODEMP;ITE_CODITE';
    qryGenIte.IndexFieldNames:= 'ITE_CODEMP;ITE_CODITE';

    qryGenIte.First;
    cdsAltGlo.DisableControls;

    pgbProgresso2.Properties.Max := qryGenIte.RecordCount;
    blnJaAdicionouCampos_PREVE_MARBR := False;

    While not qryGenIte.Eof do
    Begin
      cdsAltGlo.First;
      blnAltPrecus := False;
      blnAltPreven := False;
      blnAltMarBru := False;
      blnProcessado := False;
      while not cdsAltGlo.Eof Do
      Begin
        If (qryGenIte.FieldByName('ITE_CODEMP').AsString <> cdsAltGloITE_EMPORI.AsString) And
           (pos(qryGenIte.FieldByName('ITE_CODEMP').AsString, cdsAltGloITE_EMPDES.AsString)> 0) Then
        Begin
          qryItensEmpOrigem.First;
          If qryItensEmpOrigem.Locate('ITE_CODEMP;ITE_CODITE', varArrayOf([cdsAltGloITE_EMPORI.AsString,
                                                                           qryGenIte.FieldByName('ITE_CODITE').AsString]), []) Then
          Begin
            qryGenIte.Edit;
            qryGenIte.FieldByName(cdsAltGloITE_NOMCAM.AsString + '_NOV').Value := qryItensEmpOrigem.FieldByName(cdsAltGloITE_NOMCAM.AsString).Value;
            qryGenIte.Post;
            blnAltPrecus := fCampoExigeRecalculoCusto(cdsAltGloITE_NOMCAM.AsString);
            If blnAltPrecus Or (Pos(cdsAltGloITE_NOMCAM.AsString, 'ITE_ICMSAI_ITE_IMPFED_ITE_DESOPE_ITE_OUTVAL') > 0) Then
            Begin
              If (rdgTipAlt.ItemIndex In [0,2]) Then
                blnAltPreven := True
              Else
                blnAltMarBru := True;
            End;



            If (Pos('ITE_MARBR', cdsAltGloITE_NOMCAM.AsString) > 0) And (Length(cdsAltGloITE_NOMCAM.AsString) = 10) Then
            Begin
              blnAltPreven := True;
              intTblPrc := StrToInt(RightStr(cdsAltGloITE_NOMCAM.AsString, 1));
              pAtualizaMargemLiquida(intTblPrc);
            End;

            If (Pos('ITE_MARID', cdsAltGloITE_NOMCAM.AsString) > 0) And (Length(cdsAltGloITE_NOMCAM.AsString) = 10) Then
              blnAltPreven := True;

            If (Pos('ITE_COMTB', cdsAltGloITE_NOMCAM.AsString) > 0) And (Length(cdsAltGloITE_NOMCAM.AsString) = 10) Then
            Begin
              If (rdgTipAlt.ItemIndex = 0) Then
                 blnAltPreven := True;
              If (rdgTipAlt.ItemIndex In [1,2]) Then
                 blnAltMarBru := True;
            End;

            If (Pos('ITE_VALFRE', cdsAltGloITE_NOMCAM.AsString) > 0) And (Length(cdsAltGloITE_NOMCAM.AsString) = 10) Then
            Begin
              If (rdgTipAlt.ItemIndex = 0) Then
                 blnAltPreven := True;
              If (rdgTipAlt.ItemIndex In [1,2]) Then
                 blnAltMarBru := True;
            End;


            If Not(blnJaAdicionouCampos_PREVE_MARBR) And (Pos('ITE_PREVE', cdsAltGloITE_NOMCAM.AsString) > 0) And (Length(cdsAltGloITE_NOMCAM.AsString) = 10) Then
            Begin
              For intIndice := 2 To 7 Do
              Begin
                pAdicionaCampoGrid('ITE_MARBR' + IntToStr(intIndice));
                pAdicionaCampoGrid('ITE_PREVE' + IntToStr(intIndice));
                blnJaAdicionouCampos_PREVE_MARBR := True;
              End;
            End;
          End;
          blnProcessado:= True;
        End;

        cdsAltGlo.Next;
      End;

      //Recalcular o custo
      If blnProcessado Then
      Begin
        If blnAltPrecus Then
        Begin

          pAdicionaCampoGrid('ITE_PRECUS');

          {**********************************}
          {* CALCULA PREÇOS DE CUSTO        *}
          {*******************************JB*}
          With cpcParams Do
          Begin
            curPreCom := fTRataCampoValorNovo('ITE_PRECOM');
            curDesF01 := fTRataCampoValorNovo('ITE_DESF01');
            curDesF02 := fTRataCampoValorNovo('ITE_DESF02');
            curDesF03 := fTRataCampoValorNovo('ITE_DESF03');
            curDesF04 := fTRataCampoValorNovo('ITE_DESF04');
            curDesF05 := fTRataCampoValorNovo('ITE_DESF05');
            curDesF06 := fTRataCampoValorNovo('ITE_DESF06');
            curICMSEnt:= fTRataCampoValorNovo('ITE_ICMENT');
            curIPIEnt := fTRataCampoValorNovo('ITE_IPIENT');
            curFrete  := fTRataCampoValorNovo('ITE_FREENT');
            curAcrFin := fTRataCampoValorNovo('ITE_ACRFIN');
            curSubsti := fTRataCampoValorNovo('ITE_SUBSTI');
            curValFre := fTRataCampoValorNovo('ITE_VALFRE');
            curDesAdb := fTRataCampoValorNovo('ITE_DESADB');
            curSubFed := fTRataCampoValorNovo('ITE_SUBFED');
            if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString, qryGenIte.FieldByName('ITE_CODEMP').AsString) = '4') then
            begin
              curTCIFCu := fTRataCampoValorNovo('ITE_TCIFCU');
              curTSCust := fTRataCampoValorNovo('ITE_TSCUST');
              curDePiCo := fTRataCampoValorNovo('ITE_DEPICO');
              curDeICMS := fTRataCampoValorNovo('ITE_DEICMS');
              curFatReg := fTRataCampoValorNovo('ITE_FATREG');
            end
            else
            begin
              curTCIFCu := 0;
              curTSCust := 0;
              curDePiCo := 0;
              curDeICMS := 0;
              curFatReg := 0;
            end;
          End;
          blnUtilizarConversorDeMoedas := False;
          objConversor := Nil;
          If fTRataCampoValorNovo('ITE_PREDOL') = 'S' Then
            blnUtilizarConversorDeMoedas := True;

          fltPreCusNov := cpcParams.fCalculaPrecoCusto(blnUtilizarConversorDeMoedas);
          pAtualizaValorCampo('ITE_PRECUS', fltPreCusNov);
        End;



        {************************************************}
        {* ALTERA O PREÇO DE VENDA, MARGEM SE NECESSÁRIO*}
        {*********************************************MV*}
        For intTblPrc := 1 To Length(arrRecTabelasPreco) Do
        Begin
          If blnAltPreven Then
          Begin
            pAdicionaCampoGrid('ITE_PREVE' + IntToStr(intTblPrc));

            If ((Not Assigned(objFatPre) Or (Assigned(objFatPre) And (Not objFatPre.fTabelaAtiva(intTblPrc))))) Or (intTblPrc = 1) Then
            Begin
              pAtualizaValorCampo('ITE_PREVE' + IntToStr(intTblPrc), fPrecoVenda(1, intTblPrc));
              If Assigned(objFatPre) Then
                pAtualizaPrecosFator(qryGenIte.FieldByName('ITE_PREVE' + IntToStr(intTblPrc) + '_NOV').Value);
            End Else
            Begin
              pAtualizaValorCampo('ITE_PREVE' + IntToStr(intTblPrc), objFatPre.fCalculaPrecoVendaFator(fTRataCampoValorNovo('ITE_PREVE' + IntToStr(intTblPrc)), intTblPrc));

              pAdicionaCampoGrid('ITE_MARBR' + IntToStr(intTblPrc));
              pAtualizaValorCampo('ITE_MARBR' + IntToStr(intTblPrc), fPrecoVenda(2, intTblPrc));
            End;

  {          pAtualizaValorCampo('ITE_PREVE' + IntToStr(intTblPrc) + '_NOV', fArredonda(fTRataCampoValorNovo('ITE_PREVE' + IntToStr(intTblPrc)),
                                                                                       intTblPrc,
                                                                                       fTRataCampoValorNovo('ITE_MARBR' + IntToStr(intTblPrc))));}

          End;

          If blnAltMarBru Then
          Begin
            pAdicionaCampoGrid('ITE_MARBR' + IntToStr(intTblPrc));
            pAtualizaValorCampo('ITE_MARBR' + IntToStr(intTblPrc), fPrecoVenda(2, intTblPrc));
          End;

          pAtualizaMargemLiquida(intTblPrc);
        End;
        pAlteraValorTabelaItens(qryGenIte);
      End; // If blnProcessado Then

      qryGenIte.Next;
      pgbProgresso2.Position := qryGenIte.RecNo;
      Application.ProcessMessages;
    End;


    cdsAltGlo.First;

    While not cdsAltGlo.Eof do
    Begin
      pAdicionaCampoGrid(cdsAltGloITE_NOMCAM.AsString);
      cdsAltGlo.Next;
    End;
   // pgbProgresso.Position := 0;
   // pgbProgresso.Visible  := False;

  Finally
    cdsAltGlo.EnableControls;
    cdsAltGlo.Filtered := False;


    FreeAndNil(cpcParams);
  End;
end;

function TfrmAlteracaoGeraldePrecosdeProdutos.fProdutoComSaldo(strCodIte: String): Boolean;
  Var
    qryTmpIteger: TUniQuery;
    strSQL      : String;
begin
  qryTmpIteger := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + ' ITE_CODEMP, ITE_SALDOS ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ITEGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '  ITE_SALDOS > 0 ';
  strSQL := strSQL + 'GROUP BY ';
  strSQL := strSQL + '  ITE_CODEMP ';

  With qryTmpIteger Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodIte;
    Open;

    Result := Not IsEmpty;

    Close;
    FreeAndNil(qryTmpIteger);

  End;

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pAtualizaValorCampo(strNomeCampo: String; varValor: Variant; strCodIte: String = '');
begin
 If SameText(strNomeCampo, 'ITE_ITEATI_NOV') And (Not fEmptyStr(strCodIte)) And fProdutoComSaldo(strCodIte) Then
 Begin
   varValor := 'S';
   blnAvisoAtivo := True;
 End;

 qryGenIte.Edit;
 qryGenIte.FieldByName(strNomeCampo+ '_NOV').Value := varValor;
 qryGenIte.Post;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pAtualizaValorCampo(Var arrCampos: Array Of TCampoGlobal;
  strNomeCampo: String; varValor: Variant; strCodIte: String = '');
  Var
    intContador: Integer;
    intTamMat: Integer;
begin
  intContador := 0;

  intTamMat := Length(arrCampos);

  While intContador < intTamMat Do
  Begin
    If arrCampos[intContador].strNomCam = strNomeCampo Then
    Begin
      If SameText(strNomeCampo, 'ITE_ITEATI_NOV') And (Not fEmptyStr(strCodIte)) And
         fProdutoComSaldo(strCodIte) Then
      Begin
        varValor := 'S';
        blnAvisoAtivo := True;
      End;

      arrCampos[intContador].varValCam := varValor;
      Break;
    End;
    Inc(intContador);
  End;
end;

function TfrmAlteracaoGeraldePrecosdeProdutos.fGeraVetorCampos: Boolean;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    With frmGravando Do
    Begin
      blnTempoRestante := True;
      fExecutarAcao := fGeraVetorCamposAux;
      lblGravando.Caption := 'Aguarde, carregando dados...';
      ShowModal;
      Result := blnConfirma;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmAltPrecoIndividual.fGeraVetorCamposAux]');
      Result := False;
    End;
  End;

  FreeAndNil(frmGravando);
End;

function TfrmAlteracaoGeraldePrecosdeProdutos.fGeraVetorCamposAux(pgbProgresso: TcxProgressBar): Boolean;
  Var
    intTamMat: Integer;
begin
  SetLength(arrCamposTabela, 0);
  SetLength(arrCamposGrid,   0);

  With cdsAltGlo Do
  Begin
    DisableControls;

    pgbProgresso.Position       := 0;
    pgbProgresso.Properties.Max := RecordCount;
    Application.ProcessMessages;

    First;

    While Not Eof Do
    Begin

      If blnAltPorNota And (FieldByName('ITE_NOMCAM').AsString = 'ITE_PRECOM') Then
      Begin
        Edit;
        FieldByName('ITE_ALTERA').AsString :=  'S';
        Post;
      End;


      If (FieldByName('ITE_ALTERA').AsString <> 'S') Then
      Begin
        Next;
        Continue;
      End;

      pAtualizaValorCampo(arrCamposGlobal, FieldByName('ITE_NOMCAM').AsString, FieldByName('ITE_VALCAM').Value);

      intTamMat := Length(arrCamposTabela);
      SetLength(arrCamposTabela, intTamMat+1);

      arrCamposTabela[intTamMat].strDesCam := FieldByName('ITE_DESCAM').AsString;
      arrCamposTabela[intTamMat].strProper := FieldByName('ITE_PROPER').AsString;
      arrCamposTabela[intTamMat].varValCam := FieldByName('ITE_VALCAM').Value;
      arrCamposTabela[intTamMat].strMasCam := FieldByName('ITE_MASCAM').AsString;
      arrCamposTabela[intTamMat].strNomCam := FieldByName('ITE_NOMCAM').AsString;
      arrCamposTabela[intTamMat].strDesAbr := FieldByName('ITE_DESABR').AsString;
      arrCamposTabela[intTamMat].intLimCam := FieldByName('ITE_LIMCAM').AsInteger;
      arrCamposTabela[intTamMat].strTipCam := FieldByName('ITE_TIPCAM').AsString;

      Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    EnableControls;
  End;

  Result := (Length(arrCamposTabela) > 0);
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pAlteraValorTabelaItens(qryItens: TZClient);
var i: Integer;
    strListaCampos: String;
begin

  With cdsIteGlo Do
  Begin
    Append;
    For i := 0 To cdsIteGlo.Fields.Count-1 Do
    Begin
      If cdsIteGlo.Fields[i].FieldName <> 'ITE_MARDES' Then
      Try
        cdsIteGlo.Fields[i].Value := qryItens.FieldByName(cdsIteGlo.Fields[i].FieldName).Value;
      Except
        strListaCampos := strListaCampos + '_'+cdsIteGlo.Fields[i].FieldName;
      end;
    End;
    FieldByName('ITE_MARDES').AsString := 'M';
    Post;
  End;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtCodUniExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodUni, nil, arrCodUni ,fRetNomUnidade, Nil, 'da Unidade');
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtCodUniKeyPress(Sender: TObject;  var Key: Char);
begin
  inherited;
  If fPesqUnidade(Self, edtCodUni, nil, nil, nil, Key, arrCodUni, False) Then
  Begin
    if fValidaCampos(edtCodUni, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar, edtDesMar, arrMarca, fRetNomMarca, nil, 'da Marca');
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtCodMarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;


procedure TfrmAlteracaoGeraldePrecosdeProdutos.pedtCodForKeyPre(edtCodFor: TEditFocus; var Key: Char; blnNomFor: Boolean);
begin
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, qryConFor, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrFornec, fRetNomFornecedor, nil, 'do Fornecedor');
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtCodForKeyPress(Sender: TObject;  var Key: Char);
begin
  inherited;
  If Not edtCodFor.ReadOnly Then
    pedtCodForKeyPre(edtCodFor,key,TRUE);
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtCodGprExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodGpr, edtDesGpr,    arrCodGpr, fRetNomeGrupoPrecos, Nil, 'do Grupo de Preço');
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtCodGprKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqGrupoPrecos(Self, edtCodGpr, edtDesGpr, Nil, Key, arrCodGpr, False) Then
  Begin
    If fValidaCampos(edtCodGpr, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

(*
procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCodGprKeyPress;
  Var
    chrKey: Char;
    arrGrupo: TConsultasArray;
begin
  {************************************}
  {* NOVA CONSULTA DE GRUPO DE PREÇOS *}
  {*********************************RV*}
  chrKey := '/';
  If fPesqGrupoPrecos(Self, edtCamAlt, Nil, Nil, chrKey, arrGrupo) Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCodPrdGruKeyPress;
  Var
    chrKey: Char;
    arrGrupo: TConsultasArray;
begin
  {************************************}
  {* NOVA CONSULTA DE GRUPO DE PREÇOS *}
  {*********************************RV*}
  chrKey := '/';
  If fPesqGrupoProduto(Self, edtCamAlt, Nil, Nil, chrKey, arrGrupo) Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;


procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCodGrupoCompraKeyPress;
  Var
    chrKey: Char;
    arrGru: TConsultasArray;
begin
  chrKey := '/';
  If fPesqGrupoCompra(Self, edtCamAlt, Nil, Nil, chrKey, arrGru) Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
End;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCodDepKeyPress;
  Var
    chrKey: Char;
    arrDep: TConsultasArray;
begin
  chrKey := '/';
  If fPesqDepartamento(Self, edtCamAlt, Nil, Nil, chrKey, arrDep) Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCodAbfKeyPress;
  Var
    arrSel : TConsultasArray;
    chrKey : Char;

begin
  inherited;

  chrKey := '/';

  If fPesqAbrevFiscal(Self, edtCamAlt, nil, qryConAbf, chrKey, arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCodAbfPisPress;
  Var
    arrSel : TConsultasArray;
    chrKey : Char;
begin
  inherited;

  chrKey := '/';

  If fPesqPISSAI(Self, edtCamAlt, Nil, Nil, chrKey, arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCodAbfCofPressf;
  Var
    arrSel : TConsultasArray;
    chrKey : Char;
begin
  inherited;

  chrKey := '/';

  If fPesqCOFSAI(Self, edtCamAlt, Nil, Nil, chrKey, arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCodAbfIPIPress;
  Var
    arrSel : TConsultasArray;
    chrKey : Char;
begin
  inherited;

  chrKey := '/';

  If fPesqIPISAI(Self, edtCamAlt, Nil, chrKey, arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

end;


procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCodMarcaKeyPress;
 var
   chrKey: Char;
   arrSel: TConsultasArray;

begin
  inherited;
  chrKey := '/';

  If fPesqMarcas(Self, edtCamAlt, nil, nil, chrKey, arrSel)  Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCodSituacaoKeyPress;
 var
   chrKey: Char;
   arrSel: TConsultasArray;
begin
  inherited;
  chrKey := '/';

  If fPesqSituacaoProduto(Self, edtCamAlt, nil, nil, chrKey, arrSel)  Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCodMontadoraKeyPress;
 var
   chrKey: Char;
   arrSel: TConsultasArray;
begin
  inherited;
  chrKey := '/';

  If fPesqMontadora(Self, edtCamAlt, nil, nil, chrKey, arrSel)  Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCodOnuKeyPress;
  Var
    chrKey: Char;
    arrOnu: TConsultasArray;
begin
  chrKey := '/';
  If fPesqClassificacaoOnu(Self, edtCamAlt, Nil, Nil, chrKey, arrOnu) Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCodDicKeyPress;
  Var
    chrKey: Char;
    arrDic: TConsultasArray;
begin
  chrKey := '/';
  If fPesqDic(Self, edtCamAlt, Nil, Nil, chrKey, arrDic) Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCodUnidadeKeyPress;
 var
   chrKey: Char;
   arrSel: TConsultasArray;

begin
  inherited;
  chrKey := '/';

  If fPesqUnidade(Self, edtCamAlt, nil, nil, nil, chrKey, arrSel) Then
  Begin
    if fvalidaCampos(edtCamAlt,False) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCodGrupoKeyPress(var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqGrupo(Self, edtCamAlt, nil, nil, Key, arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCodLseKeyPress;
  Var
    chrKey: Char;
    arrLse: TConsultasArray;
begin
  chrKey := '/';
  If fPesqLocSep(Self, edtCamAlt, Nil, Nil, chrKey, arrLse) Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;
*)

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtPrdGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtPrdGru, edtDesPrdPro, arrGrupoPro, fRetNomeGrupoProduto, nil, 'do Grupo de Produtos', edtPrdGru.MaxLength);
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtPrdGruKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqGrupoProduto(Self, edtPrdGru, edtDesPrdPro, Nil, Key, arrGrupoPro, False) Then
  Begin
    If fValidaCampos(edtPrdGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtRefereKeyPress(Sender: TObject; var Key: Char);
  Var
    qryTabela : TUniQuery;
    arrProduto: TConsultasArray;
begin
  inherited;

  qryTabela := fCriaQuery(Self);

  If fPesqItem(conIteSimples, Self, Nil, Nil, qryTabela, Key, arrProduto, True, nil, 'Consulta de Itens', '1') Then
  Begin
    edtRefere.Text := qryTabela.FieldByName('ITE_REFERE').AsString;
    self.SelectNext(ActiveControl, True, True);
  End;

  FreeAndNil(qryTabela)
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.FormShow(Sender: TObject);
begin
  inherited;

  pAtribuiTabelas;

  pMontaGrid;

  qryGenIte := TZClient.Create(Self, '');
  qryItensEmpOrigem := fCriaQuery(Self);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

  pAjustaAlteracaoPorNota;

  pVerificaDireitoAcesso;

  pSetFocus(mskLinGru);


  pCarregaSelecao;

  pHabilitaNotaEntrada(chkNotEnt.Checked);

  cxvTiposAlt.NavigatorButtons.First.Click;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pAjustaAlteracaoPorNota;
Begin
  pnlTipAltNota.Visible := blnAltPorNota;

  If blnAltPorNota  Then
  Begin
    pnlFiltro1.Visible        := False;
    pnlFiltro2.Visible        := False;
    pnlCabecalho.ClientHeight := pnlNotEnt.Height + 5;

    pnlDadosAlt.Visible       := False;

    Self.WindowState          := wsNormal;
    Self.ClientHeight         := pnlCabecalho.Height + pnlBotoesEnt.Height + pnlStatus.Height;

    chkNotEnt.Checked := True;
    chkNotEnt.Visible := False;
    pHabilitaNotaEntrada(True);

    pSetFocus(edtDocumento);

  End;

End;


procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtDesIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

    If fPesqItem(conIteSimples, Self, nil, edtDesIte, nil, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then
    Begin
      pSetFocus(edtRefere);
    End;

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtForNotExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtForNot.Text) Then
    edtDesForNot.Clear
  Else
  Begin
    edtDesForNot.Text := fRetNomFornecedor(edtForNot.Text);

    If fEmptyStr(edtDesForNot.Text) Then
    Begin
      fMensagem('AVISO','Código do Fornecedor não encontrado.', ['&O K']);
      edtForNot.Clear;
      pSetFocus(edtForNot);
    End;
  End;

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtForNotKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtForNot, edtDesForNot, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtForNot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtGruCmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, arrGruCmp, Nil, fRetDescGrupoCompra, 'do Grupo de Compra');
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtGruCmpKeyPress(Sender: TObject; var Key: Char);
begin
  {************************************}
  {* NOVA CONSULTA DE GRUPO DE COMPRA *}
  {*********************************RV*}
  If fPesqGrupoCompra(Self, edtGruCmp, edtDesGruCmp, Nil, Key, arrGruCmp, False) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtIncPisKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (Not CharInSet(UpperCase(Key)[1],['S', 'N', 'T'])) Then
    Key := #0;

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtCodAbrExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAbr, edtDesAbr, arrCodAbr, fRetDesAbfIcm, Nil, 'da Abreviação Fiscal');
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtCodAbrKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqAbrevFiscal(Self, edtCodAbr, edtDesAbr, qryAbfIcm, Key, arrCodAbr, False) Then
    Begin
      If fValidaCampos(edtCodAbr, True) Then
      Begin
        SelectNext(ActiveControl, True, True);
      End;
    End;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesDep, arrCodDep, fRetNomDep, nil, 'do Departamento');
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtCodDepKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrCodDep, False) Then
  Begin
    If fValidaCampos(edtCodDep, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtCodEmpresaExit(Sender: TObject);
Var
  arrEmp: TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresasAtivas(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pMontaGrid;
  Var
    intPosMat: Integer;
    intTabPre: Integer;
    GerenciaItegerPermiteEdicao : TGerenciaItegerPermiteEdicao;
  function fSoma(Var intVal : Integer; intSoma : Integer = 1) : Integer;
  Begin
    intVal := intVal + intSoma;
    Result := intVal + 1;
  End;

begin
  GerenciaItegerPermiteEdicao := TGerenciaItegerPermiteEdicao.Create;
  Try
    GerenciaItegerPermiteEdicao.pSetaEmpresa(VS_StrCodEmp, '');

    blnAvisoAtivo := False;
    strMasVal := '#,##0.0000';
    strMasFat := '#,##0.0000';
    strMasMar := '#,##0.000';
    strMasMBr := '#,##0.000';
    strMasPer := '#,##0.00';
    strMasInt := '#,##0';

    If fRetPrecisaoMargemItem > 2 Then
      strMasMBr := fMskDigitos(fRetPrecisaoMargemItem);

    strMasDecUni := fMskDigitos(fCfgSis('DECUNI', VarInteger));
    strMasDec06  := fMskDigitos(6);
    strMasDec05  := fMskDigitos(5);

    {******************************************}
    {* CARREGA MATRIZ COM OS CAMPOS QUE PODEM *}
    {* SER ALTERADOS                          *}
    {***************************************JB*}
    intPosMat := 0;
    SetLength(arrCamposGlobal, 1);

    intPosMatPreMatInicial := intPosMat;
    If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_PRECOM') Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := 'Preço de Compra';
      arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
      arrCamposGlobal[intPosMat].strProper := 'cxeDecUni';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_PRECOM';
      arrCamposGlobal[intPosMat].strDesAbr := 'Preço de Compra';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    {*******************************************}
    {* DESCONTOS / OUTRAS COLUNAS              *}
    {****************************************MV*}
    If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF01') Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 01';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF01';
      arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 01';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF02') Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 02';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF02';
      arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 02';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF03') Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 03';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF03';
      arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 03';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF04') Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 04';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF04';
      arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 04';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF05') Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 05';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF05';
      arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 05';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF06') Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 06';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF06';
      arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 06';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_ICMENT') Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% ICMS Entrada';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_ICMENT';
      arrCamposGlobal[intPosMat].strDesAbr := '% ICMS Entrada';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_SUBFED') Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% Impostos Federais (-)';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_SUBFED';
      arrCamposGlobal[intPosMat].strDesAbr := '% Imp. Federais (-)';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_IPIENT') Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% IPI de Entrada';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_IPIENT';
      arrCamposGlobal[intPosMat].strDesAbr := '% IPI Entrada';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_IPISAI') Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% IPI de Saída';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_IPISAI';
      arrCamposGlobal[intPosMat].strDesAbr := '% IPI Saída';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_FREENT') Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% Frete de Entrada';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_FREENT';
      arrCamposGlobal[intPosMat].strDesAbr := '% Frete Entrada';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_VALFRE') Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := fCfgSis('DESVFR');
      arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
      arrCamposGlobal[intPosMat].strProper := 'cxeDecUni';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_VALFRE';
      arrCamposGlobal[intPosMat].strDesAbr := fCfgSis('DESVFR');
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_ACRFIN') Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% Acréscimo Financeiro';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_ACRFIN';
      arrCamposGlobal[intPosMat].strDesAbr := '% Acresc.Financ.';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_SUBSTI') Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% Substituição Tributária';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_SUBSTI';
      arrCamposGlobal[intPosMat].strDesAbr := '% Subst. Tributária';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESADB') Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% ' + fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + ')';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESADB';
      arrCamposGlobal[intPosMat].strDesAbr := '% ' + fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + ')';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_IMPFED') Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% Impostos Federais';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_IMPFED';
      arrCamposGlobal[intPosMat].strDesAbr := '% Impostos Fed.';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESOPE') Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% Despesas Operacionais';
      arrCamposGlobal[intPosMat].strDesAbr := '% Despesas Oper.';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESOPE';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_ICMSAI') Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% ICMS de Saída';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_ICMSAI';
      arrCamposGlobal[intPosMat].strDesAbr := '% ICMS Saída';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    {*************************************************************}
    {* OUTROS VALORES                                            *}
    {**********************************************************JC*}
    If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_OUTVAL') Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := fCfgSis('DOVCPP') + ' (+)';
      arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
      arrCamposGlobal[intPosMat].strProper := 'cxeDecUni';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_OUTVAL';
      arrCamposGlobal[intPosMat].strDesAbr := fCfgSis('DOVCPP') + ' (+)';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    {*******************************************}
    {* MARGEM BRUTA PARA TABELAS DE PRECO      *}
    {****************************************JB*}
    For intTabPre := 1 To Length(VS_strTabPrc) Do
    Begin
      If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_MARBR' + IntToStr(intTabPre)) Then
      Begin
        arrCamposGlobal[intPosMat].strDesCam := '% Margem Bruta ' + IntToStr(intTabPre);
        arrCamposGlobal[intPosMat].strMasCam := strMasMBr;
        arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMBr);
        arrCamposGlobal[intPosMat].strProper := 'cxeMasMBr';

        arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARBR' + IntToStr(intTabPre);
        arrCamposGlobal[intPosMat].strDesAbr := '% Margem Bruta ' + IntToStr(intTabPre);
        arrCamposGlobal[intPosMat].intLimCam := 12;
        arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
        SetLength(arrCamposGlobal, fSoma(intPosMat));
      End;

      If blnLiqNeg Then
      Begin
        arrCamposGlobal[intPosMat].strDesCam := '% Margem Líquida ' + IntToStr(intTabPre);
        arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
        arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMar);
        arrCamposGlobal[intPosMat].strProper := 'cxeDecUni';

        arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARLQ' + IntToStr(intTabPre);
        arrCamposGlobal[intPosMat].strDesAbr := '% Margem Liq. ' + IntToStr(intTabPre);
        arrCamposGlobal[intPosMat].intLimCam := 12;
        arrCamposGlobal[intPosMat].strNomArq := '';
        SetLength(arrCamposGlobal, fSoma(intPosMat));
      End;
    End;

    If fCfgSis('MARIDE', VarBoolean) Then
    For intTabPre := 1 To Length(VS_strTabPrc) Do
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% Margem Ideal ' + IntToStr(intTabPre);
      arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMar);
      arrCamposGlobal[intPosMat].strProper := 'cxeDecUni';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARID' + IntToStr(intTabPre);
      arrCamposGlobal[intPosMat].strDesAbr := '% Margem Ideal ' + IntToStr(intTabPre);
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    {*************************************************************}
    {* COMISSAO DO PRODUTO GERAL OU INDIVIDUAL POR TABELA PRECO  *}
    {**********************************************************JC*}
    If fCfgSis('PCMPRO') = '2' Then
    Begin
      For intTabPre := 1 To Length(VS_strTabPrc) Do
      Begin
        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_COMTB' + IntToStr(intTabPre)) Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := '% Comissão ' + IntToStr(intTabPre);
          arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeDecUni';
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_COMTB' + IntToStr(intTabPre);
          arrCamposGlobal[intPosMat].strDesAbr := '% Comissão ' + IntToStr(intTabPre);
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

      End;
    End;

    {*******************************************}
    {* PREÇO 1 - CASO ESTEJA NA CONFIGURAÇÃO   *}
    {****************************************JB*}
    For intTabPre := 1 To Length(VS_strTabPrc) Do
    Begin
      If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_PREVE' + IntToStr(intTabPre)) Then
      Begin
        arrCamposGlobal[intPosMat].strDesCam := 'Preço de Venda ' + IntToStr(intTabPre);
        arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
        arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
        arrCamposGlobal[intPosMat].strProper := 'cxeDecUni';
        arrCamposGlobal[intPosMat].strNomCam := 'ITE_PREVE' + IntToStr(intTabPre);
        arrCamposGlobal[intPosMat].strDesAbr := 'Preço de Venda ' + IntToStr(intTabPre);
        arrCamposGlobal[intPosMat].intLimCam := 12;
        arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
        SetLength(arrCamposGlobal, fSoma(intPosMat));
      End;
    End;

    {*************************************}
    {* QTDE MÍNIMA POR TABELA DE PREÇOS  *}
    {**********************************JB*}
    For intTabPre := 1 To Length(VS_strTabPrc) Do
    Begin
      arrCamposGlobal[intPosMat].strDesCam := 'Qtde Mínima Tabela ' + IntToStr(intTabPre);
      arrCamposGlobal[intPosMat].strMasCam := '#,##0.0000';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_MINTB' + IntToStr(intTabPre);
      arrCamposGlobal[intPosMat].strDesAbr := 'Qtde Mínima Tabela ' + IntToStr(intTabPre);
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric('#,##0.0000');
      arrCamposGlobal[intPosMat].strProper := 'cxeMasVal';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    If Not blnIteTbp then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% Desconto Máximo Vendedor';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESMAX';
      arrCamposGlobal[intPosMat].strDesAbr := '% Desc.Maximo Vendedor';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));

      arrCamposGlobal[intPosMat].strDesCam := '% Desconto Máximo Gerente';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESMGE';
      arrCamposGlobal[intPosMat].strDesAbr := '% Desc.Maximo Ger.';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));

      arrCamposGlobal[intPosMat].strDesCam := '% Desconto Máximo Sub-Gerente';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESMSU';
      arrCamposGlobal[intPosMat].strDesAbr := '% Desc.Maximo Sub-Ger.';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End
    Else
    Begin
      For intTabPre := 1 To Length(VS_strTabPrc) Do
      Begin
        arrCamposGlobal[intPosMat].strDesCam := '% Desconto Máximo Vendedor Tab. ' + IntToStr(intTabPre) ;
        arrCamposGlobal[intPosMat].strMasCam := strMasPer;
        arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESMA' + IntToStr(intTabPre);
        arrCamposGlobal[intPosMat].strDesAbr := '% Desc.Maximo Vendedor Tab. ' + IntToStr(intTabPre) ;
        arrCamposGlobal[intPosMat].intLimCam := 12;
        arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
        arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
        arrCamposGlobal[intPosMat].strNomArq := 'ITETBP';
        SetLength(arrCamposGlobal, fSoma(intPosMat));

        arrCamposGlobal[intPosMat].strDesCam := '% Desconto Máximo Gerente Tab. ' + IntToStr(intTabPre) ;
        arrCamposGlobal[intPosMat].strMasCam := strMasPer;
        arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESMG' + IntToStr(intTabPre);
        arrCamposGlobal[intPosMat].strDesAbr := '% Desc.Maximo Ger. Tab. ' + IntToStr(intTabPre) ;
        arrCamposGlobal[intPosMat].intLimCam := 12;
        arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
        arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
        arrCamposGlobal[intPosMat].strNomArq := 'ITETBP';
        SetLength(arrCamposGlobal, fSoma(intPosMat));

        arrCamposGlobal[intPosMat].strDesCam := '% Desconto Máximo Sub-Gerente Tab. ' + IntToStr(intTabPre) ;
        arrCamposGlobal[intPosMat].strMasCam := strMasPer;
        arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESMS' + IntToStr(intTabPre);
        arrCamposGlobal[intPosMat].strDesAbr := '% Desc.Maximo Sub-Ger. Tab. ' + IntToStr(intTabPre) ;
        arrCamposGlobal[intPosMat].intLimCam := 12;
        arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
        arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
        arrCamposGlobal[intPosMat].strNomArq := 'ITETBP';
        SetLength(arrCamposGlobal, fSoma(intPosMat));
      End;
    End;

    arrCamposGlobal[intPosMat].strDesCam := '% Margem Mínima Vendedor';
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARMIN';
    arrCamposGlobal[intPosMat].strDesAbr := '% Margem Mín. Vend.';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    SetLength(arrCamposGlobal, fSoma(intPosMat));

    arrCamposGlobal[intPosMat].strDesCam := '% Margem Mínima Sub Gerente';
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARMSG';
    arrCamposGlobal[intPosMat].strDesAbr := '% Margem Mín. Sub Gerente';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    SetLength(arrCamposGlobal, fSoma(intPosMat));

    arrCamposGlobal[intPosMat].strDesCam := '% Margem Mínima Gerente';
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARMGE';
    arrCamposGlobal[intPosMat].strDesAbr := '% Margem Mín. Gerente';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    SetLength(arrCamposGlobal, fSoma(intPosMat));

    intPosMatPreMatFinal := Pred(intPosMat);
    If fCfgSis('PCMPRO') = '1' Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% Comissão Vendedor Interno';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_COMVAR';
      arrCamposGlobal[intPosMat].strDesAbr := '% Comis.Vend.Int.';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));

      arrCamposGlobal[intPosMat].strDesCam := '% Comissão Repres. Ext.  Loja';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_COMATA';
      arrCamposGlobal[intPosMat].strDesAbr := '% Comis.Repr.Ext.Loja';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));

      arrCamposGlobal[intPosMat].strDesCam := '% Comissão Repres. Ext. Distrib.';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_COMDIS';
      arrCamposGlobal[intPosMat].strDesAbr := '% Comis.Repr.Ext.Distrib.';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));

      If (fCfgSis('USADIG', varBoolean)) Then
      Begin
        arrCamposGlobal[intPosMat].strDesCam := '% Comissão Digitador';
        arrCamposGlobal[intPosMat].strMasCam := strMasPer;
        arrCamposGlobal[intPosMat].strNomCam := 'ITE_COMDIG';
        arrCamposGlobal[intPosMat].strDesAbr := '% Comis.Digitador';
        arrCamposGlobal[intPosMat].intLimCam := 12;
        arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
        arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
        arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
        SetLength(arrCamposGlobal, fSoma(intPosMat));
      End;
    End;

    If (fCfgSis('AUTCEN', VarBoolean)) And
       (fCfgSis('OPCMEC', VarString ) = 'CPS') Then //Opcao de Comissao Mecanico: (C)adastro de (P)rodutos/(S)ervicos
    Begin
      arrCamposGlobal[intPosMat].strDesCam := 'Comissão Mecânico (R$ ou %)';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_COMMEC';
      arrCamposGlobal[intPosMat].strDesAbr := 'Com.Mec. (R$ ou %)';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    If (fCfgSis('ORIPRO') = '2') Or (fCfgSis('TCOPRO') = '4') Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% Comissão do Profissional';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_COMPRO';
      arrCamposGlobal[intPosMat].strDesAbr := '% Comis.Vend.Profiss.';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    If (Pos(fCfgSis('TCOPRO'), '3_4_') > 0) Then
    Begin
      If fCfgSis('TCOPRO') = '4' Then
        arrCamposGlobal[intPosMat].strDesCam := 'Pontos Por Valor'
      Else
        arrCamposGlobal[intPosMat].strDesCam := 'Quantidade de Pontos para Profissional';
      arrCamposGlobal[intPosMat].strMasCam := '#0.00';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_QTPPRO';
      If fCfgSis('TCOPRO') = '4' Then
        arrCamposGlobal[intPosMat].strDesAbr := 'Pontos Por Valor'
      Else
        arrCamposGlobal[intPosMat].strDesAbr := 'Qtd.Pont.Profiss.';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(14,2)';
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    arrCamposGlobal[intPosMat].strDesCam := 'Imprime Lista?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_IMPLIS';
    arrCamposGlobal[intPosMat].strDesAbr := 'Imp. Lista?';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(01)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    SetLength(arrCamposGlobal, fSoma(intPosMat));

    If Not fCfgSis('CADLOC', varBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Localização Física';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_LOCFIS';
      arrCamposGlobal[intPosMat].strDesAbr := 'Local. Fisica';
      arrCamposGlobal[intPosMat].intLimCam := intLocFis;
      arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR('+IntToStr(intLocFis)+')';
      arrCamposGlobal[intPosMat].strProper := 'cxeLocFis';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    End;

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Capacidade da Localização Física';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_TAMLCF';
    arrCamposGlobal[intPosMat].strDesAbr := 'Capacidade Loc. Fisica';
    arrCamposGlobal[intPosMat].intLimCam := 30;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(30)';
    arrCamposGlobal[intPosMat].strProper := 'cxeString30';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    If Not fCfgSis('CADLOC', varBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Localização Super Estoque';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_LOCSUP';
      arrCamposGlobal[intPosMat].strDesAbr := 'Loc. Sup. Estoque';
      arrCamposGlobal[intPosMat].intLimCam := 10;
      arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(10)';
      arrCamposGlobal[intPosMat].strProper := 'cxeString10';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    End;

    If fCfgSis('GRUSEP', varBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Localização de Separação';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_CODLSE';
      arrCamposGlobal[intPosMat].strDesAbr := 'Localização de Separação';
      arrCamposGlobal[intPosMat].intLimCam := fTamCodLse;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(' + IntToStr(fTamCodLse) + ')';
      arrCamposGlobal[intPosMat].strProper := 'cxeConsTamLse';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    End;

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Capacidade da Localização Super Estoque';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_TAMLCS';
    arrCamposGlobal[intPosMat].strDesAbr := 'Capacidade Loc. Sup. Estoque';
    arrCamposGlobal[intPosMat].intLimCam := 30;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(30)';
    arrCamposGlobal[intPosMat].strProper := 'cxeString30';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Situação do Produto';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_SITPRO';
    arrCamposGlobal[intPosMat].strDesAbr := 'Situação';
    arrCamposGlobal[intPosMat].intLimCam := 3;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(03)';
    arrCamposGlobal[intPosMat].strProper := 'cxeConsTam3';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    If blnValFor Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Data Validade Preço';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_DTAVAL';
      arrCamposGlobal[intPosMat].strDesAbr := 'Dt. Validade Preço';
      arrCamposGlobal[intPosMat].intLimCam := 10;
      arrCamposGlobal[intPosMat].strTipCam := 'DATE';
      arrCamposGlobal[intPosMat].strProper := 'cxeDate';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    End;


    If fCfgSis('PESLIQ') = 'SOMA' Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Peso Liq.';

      arrCamposGlobal[intPosMat].strMasCam := '###,#0.000';
      arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(14,3)';
      arrCamposGlobal[intPosMat].strProper := 'cxeMasMar';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_PESLIQ';
      arrCamposGlobal[intPosMat].strDesAbr := 'Peso Liq.';
      arrCamposGlobal[intPosMat].intLimCam := 14;
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;
    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Produto com compra centralizada?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_CPRCEN';
    arrCamposGlobal[intPosMat].strDesAbr := 'Compra centralizada?';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Abast.Filiais, Abastece com Múlt.Compras?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_ABAMLT';
    arrCamposGlobal[intPosMat].strDesAbr := 'Abast. Múlt. Compras?';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Nível Criticidade Estoque';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_NIVCRI';
    arrCamposGlobal[intPosMat].strDesAbr := 'Niv.Crit.Estoque';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbNivCri';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    {******************}
    {* ESTOQUE MÍNIMO *}
    {***************RV*}
    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Estoque Mínimo';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_ESTMIN';
    arrCamposGlobal[intPosMat].strDesAbr := 'Estoque Mínimo';
    arrCamposGlobal[intPosMat].intLimCam := 14;
    arrCamposGlobal[intPosMat].strMasCam := '###,#0.000';
    arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(14,3)';
    arrCamposGlobal[intPosMat].strProper := 'cxeMasMar';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    {******************}
    {* ESTOQUE MÁXIMO *}
    {***************RV*}
    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Estoque Máximo';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_ESTMAX';
    arrCamposGlobal[intPosMat].strDesAbr := 'Estoque Máximo';
    arrCamposGlobal[intPosMat].intLimCam := 14;
    arrCamposGlobal[intPosMat].strMasCam := '###,#0.000';
    arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(14,3)';
    arrCamposGlobal[intPosMat].strProper := 'cxeMasMar';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    If fCfgSis('PRAMIN', VarBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Prazo médio mínimo para cálculo de juros';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_PRAMIN';
      arrCamposGlobal[intPosMat].strDesAbr := 'Prazo médio mínimo para cálculo de juros';
      arrCamposGlobal[intPosMat].intLimCam := 3;
      arrCamposGlobal[intPosMat].strTipCam := 'INTEGER';
      arrCamposGlobal[intPosMat].strProper := 'cxeInt03';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    End;

    if fCfgSis('MOEXSI') <> '0' then
    begin
      {************************************}
      {* DESCONTO PARA SITE               *}
      {*********************************LS*}
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := '% Desconto para Site';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESSIT';
      arrCamposGlobal[intPosMat].strDesAbr := '% Desconto para Site';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(14,3)';
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'DESSIT';

      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Altura/Cm (Site)';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_EXPALT';
      arrCamposGlobal[intPosMat].strDesAbr := 'Altura (Site)';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(12,2)';
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'DESSIT';

      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Largura/Cm (Site)';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_EXPLAR';
      arrCamposGlobal[intPosMat].strDesAbr := 'Largura (Site)';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(12,2)';
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'DESSIT';

      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Profundidade/Cm (Site)';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_EXPPRO';
      arrCamposGlobal[intPosMat].strDesAbr := 'Profundidade (Site)';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(12,2)';
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'DESSIT';

      {************************************}
      {* PRODUTO EM CROSS DOKING          *}
      {*********************************LS*}
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Produto em Cross Doking';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_CRODOC';
      arrCamposGlobal[intPosMat].strDesAbr := 'Produto em Cross Doking';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'DESSIT';
    end;


    {************************************}
    {* TIPO DO FRETE - SAIDA            *}
    {*********************************LS*}
    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Tipo de produto (SPED)';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_TIPPRO';
    arrCamposGlobal[intPosMat].strDesAbr := 'Tipo de produto';
    arrCamposGlobal[intPosMat].intLimCam := 7;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(2)';
    arrCamposGlobal[intPosMat].strProper := 'cmbTipPro';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Opção para o Estoque Mínimo';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_ESMIDG';
    arrCamposGlobal[intPosMat].strDesAbr := 'Opção para o Estoque Mínimo';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbEsMiDg';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Permite Receber Devolução';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_RECDEV';
    arrCamposGlobal[intPosMat].strDesAbr := 'Permite Receber Devolução';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    If (fCfgSis('PESOBR', varBoolean)) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Controlar pesagem obrigatória ( Saída ) ?';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_PESOBR';
      arrCamposGlobal[intPosMat].strDesAbr := 'Controlar pesagem obrigatória ( Saída )';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(01)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    End;

    If (fCfgSis('CPESOB', varBoolean)) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Controlar pesagem obrigatória ( Entrada ) ?';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_CPESOB';
      arrCamposGlobal[intPosMat].strDesAbr := 'Controlar pesagem obrigatória ( Entrada ) ?';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    End;

    If fCfgSis('ITECFO', varBoolean) And fCfgSis('DESCHK', varBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Desobrigar conferência no check-out?';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESCHK';
      arrCamposGlobal[intPosMat].strDesAbr := 'Desobrigar conferência no check-out?';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    End;


    pGeraClient;

    {***********************************************************************************}
    {* PREÇO DE CUSTO                                                                  *}
    {* ESTE CAMPO DEVE SER CRIADO APÓS AS ATUALIZAÇÕES ACIMA PARA NÃO APARECER NO GRID *}
    {********************************************************************************LU*}
    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Preço de Custo';
    arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
    arrCamposGlobal[intPosMat].strProper := 'cxeDecUni';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_PRECUS';
    arrCamposGlobal[intPosMat].strDesAbr := 'Preço Custo';
    arrCamposGlobal[intPosMat].intLimCam := -1;
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
  Finally
    FreeAndNil(GerenciaItegerPermiteEdicao);
  End;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  {If (Key = VK_Return) And (ActiveControl.Name = '') And pnlCabecalho.Visible Then
  Begin
    pSetFocus(chkArrMai);
  End
  Else If (Key = VK_Return) And (ActiveControl.Name = '') Then
  Begin
    pSetFocus(edtClaIpi);
  End;}

 Case Key Of
    VK_ESCAPE : If Not mskLinGru.Focused Then
                  pSetFocus(mskLinGru)
                Else
                  Close;

    VK_RETURN: If fCheckParent(ActiveControl, cxgTiposAlt) And (cdsAltGlo.State = dsEdit) And
                  (Not SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_APLICA')) Then
               Begin
                 cdsAltGlo.Post;
                 cxvTiposAlt.NavigatorButtons.Next.Click;
               End;

    VK_F10 : Begin
               btnConfirma.Click;
               Key := 0;
             End;

  End;

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.rdgTipAltClick(Sender: TObject);
begin
  inherited;
  pMontaGrid;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.rdgTipAltForClick(Sender: TObject);
begin
  inherited;
  rdgTipAlt.ItemIndex := rdgTipAltFor.ItemIndex;
end;


function TfrmAlteracaoGeraldePrecosdeProdutos.RemoveAcento(const pText: string): string;
  type
    USAscii20127 = type AnsiString(20127);
begin
  Result := string(USAscii20127(pText));
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pHabilitaNotaEntrada(blnHabilitar: Boolean);
Begin
  If blnHabilitar Then
  Begin
    lblDocumento.Enabled  := True;
    lblEspecie.Enabled    := True;
    lblSerie.Enabled      := True;
    lblForNot.Enabled     := True;
    lblEmpresa.Enabled    := True;

    edtDocumento.Enabled  := True;
    edtEspecie.Enabled    := True;
    edtSerie.Enabled      := True;
    edtForNot.Enabled     := True;
    edtCodEmpresa.Enabled := True;
  End
  Else
  Begin
    edtDocumento.Clear;
    edtEspecie.Text := 'NF';
    edtSerie.Clear;
    edtForNot.Clear;
    edtDesForNot.Clear;
    edtCodEmpresa.Text := VS_strCodEmp;
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(VS_strCodEmp);

    lblDocumento.Enabled  := False;
    lblEspecie.Enabled    := False;
    lblSerie.Enabled      := False;
    lblForNot.Enabled     := False;
    lblEmpresa.Enabled    := False;

    edtDocumento.Enabled  := False;
    edtEspecie.Enabled    := False;
    edtSerie.Enabled      := False;
    edtForNot.Enabled     := False;
    edtCodEmpresa.Enabled := False;

  End;

  mskDtaEntFin.Enabled := blnHabilitar And fEmptyStr(edtDocumento.Text);
  mskDtaEntIni.Enabled := blnHabilitar And fEmptyStr(edtDocumento.Text);
  lblDtaFin.Enabled    := blnHabilitar And fEmptyStr(edtDocumento.Text);
  lblDtaIni.Enabled    := blnHabilitar And fEmptyStr(edtDocumento.Text);

  If Not blnHabilitar Then
  Begin
    mskDtaEntFin.Text := '';
    mskDtaEntIni.Text := '';
  End;

End;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pLimparTela;
//  Var
//    IntCont: Integer;
begin
 (*
  For IntCont := 0 To Self.ComponentCount - 1 Do
  Begin
    If Self.Components[IntCont] Is TEditFocus Then
      (Self.Components[IntCont] As TEditFocus).Clear;
  End;

  mskLinGru.Clear;
  edtStatus.Text    := 'T';
  edtIncPis.Text    := 'T';

  If Not blnAltPorNota Then
  Begin
    chkNotEnt.Checked := False;
    pHabilitaNotaEntrada(chkNotEnt.Checked);
  End;
*)

  pGeraClient;

//  rdgTipAlt.ItemIndex := 0;

  pVerificaDireitoAcesso;
  pMontaGrid;

  pSetFocus(mskLinGru);
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pVerificaDireitoAcesso;
Begin
  TRadioButton(rdgTipAlt.Components[0]).Enabled := fVerificaAcessoSistema('ALTGCUSVEN', strLoginUsuarioLogado);
  TRadioButton(rdgTipAlt.Components[1]).Enabled := fVerificaAcessoSistema('ALTGCUSMAR', strLoginUsuarioLogado);
  TRadioButton(rdgTipAlt.Components[2]).Enabled := fVerificaAcessoSistema('ALTGVENMAR', strLoginUsuarioLogado);

  If TRadioButton(rdgTipAlt.Components[0]).Enabled Then
    TRadioButton(rdgTipAlt.Components[0]).Checked := True

  Else If TRadioButton(rdgTipAlt.Components[1]).Enabled Then
    TRadioButton(rdgTipAlt.Components[1]).Checked := True

  Else If TRadioButton(rdgTipAlt.Components[2]).Enabled Then
    TRadioButton(rdgTipAlt.Components[2]).Checked := True;

  blnBloPre := fCfgSis('BLOPRE', varBoolean);

  If blnBloPre Then
  Begin
    rdgTipAlt.Controls[0].Enabled := False;
    rdgTipAlt.Controls[2].Enabled := False;

    If rdgTipAlt.Controls[1].Enabled Then
      rdgTipAlt.ItemIndex := 1;

    If rdgTipAltFor.Visible Then
    Begin
      rdgTipAltFor.ItemIndex := 1;
      rdgTipAltFor.Controls[0].Enabled := False;
    End;

  End;

End;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  dtsPermissaoVenda.DataSet := TTipoPermissaoVenda.Dataset;
  cxeConsTamLse.Properties.MaxLength := fTamCodLse;
  edtCodAbr.MaxLength :=  IIf(fCfgSis('USASAN') = 'S', 7, 3);
  intDecUni := fCfgSis('DECUNI', varInteger);

  pCriaCdsSimNao;
  pCriaCdsClaCRM;
  pCriaCdsFrePFU;
  pCriaCdsEsMiDg;
  pCriaCdsTipPro;

  blnVidroInteiro := (fCfgSis('VENVID', varBoolean)) And (Not fCfgSis('DECVID', varBoolean));

  blnLiqNeg := fCfgSis('LIQNEG', varBoolean);

  If blnLiqNeg Then
    fltPMarLq := fCfgSis('PMARLQ', varDouble)
  Else
    fltPMarLq := 1;

  blnAltPorNota    := False;
  blnSergipe       := (fCadEmp('ESTADO') = 'SE');
  blnURapel        := fCfgSis('URAPEL', varBoolean);
  blnIteTbp        := fCfgSis('ITETBP', varBoolean);

  cdsAltGlo.CreateDataSet;

  If fCfgSis('FATPRE', varBoolean) Then
    objFatPre := TFatorPreco.Create
  Else
    objFatPre := Nil;


  edtDocumento.MaxLength := fTamNumDoc();
  edtDocumento.TamCampo  := edtDocumento.MaxLength;

  blnValFor := fCfgSis('VALFOR', VarBoolean);
  blnMarIde := fCfgSis('MARIDE', VarBoolean);

  strEstEmp := fCadEmp('ESTADO');

  objSalInt := TSalvaInterface.Create(Self);
  objSalInt.blnDeleteNaoEncontrados := False;

  pTamanhoCamposLocFis(intLocFis, intLocSup, intTamLcf, intLocSep);

  TcxTextEditProperties(cxeLocFis.Properties).MaxLength := intLocFis;
  TcxTextEditProperties(cxeLocSup.Properties).MaxLength := intLocSup;
  TcxTextEditProperties(cxeLocSep.Properties).MaxLength := intLocSep;
  TcxTextEditProperties(cxeTamLcf.Properties).MaxLength := intTamLcf;

  TcxTextEditProperties(cxeClassfIPI.Properties).MaxLength := MAX_CLAIPI;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCarregaSelecao;
Begin
  objSalInt.fCarregaDados('', Self, Self.Name + IIF(blnAltPorNota, '_Nota', ''), strLoginUsuarioLogado);

  objSalInt.pCarregaMultiSelecao(arrLinhaGrupo, 'CODGRU');
  objSalInt.pCarregaMultiSelecao(arrMarca,      'CODMAR');
  objSalInt.pCarregaMultiSelecao(arrFornec,     'CODFOR');
  objSalInt.pCarregaMultiSelecao(arrGrupoPro,   'PRDGRU');
  objSalInt.pCarregaMultiSelecao(arrGruCmp,     'GRUCMP');
  objSalInt.pCarregaMultiSelecao(arrCodGpr,     'CODGPR');
  objSalInt.pCarregaMultiSelecao(arrCodDep,     'CODDEP');
  objSalInt.pCarregaMultiSelecao(arrCodMon,     'CODMON');
  objSalInt.pCarregaMultiSelecao(arrCodAbr,     'CODABF');
  objSalInt.pCarregaMultiSelecao(arrCodUni,     'CODUNI');
  objSalInt.pCarregaMultiSelecao(arrClaIPI,     'CLAIPI');
End;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.pSalvaSelecao;
Begin
  objSalInt.pAddMultiSelecao(arrLinhaGrupo, 'CODGRU');
  objSalInt.pAddMultiSelecao(arrMarca,      'CODMAR');
  objSalInt.pAddMultiSelecao(arrFornec,     'CODFOR');
  objSalInt.pAddMultiSelecao(arrGrupoPro,   'PRDGRU');
  objSalInt.pAddMultiSelecao(arrGruCmp,     'GRUCMP');
  objSalInt.pAddMultiSelecao(arrCodGpr,     'CODGPR');
  objSalInt.pAddMultiSelecao(arrCodDep,     'CODDEP');
  objSalInt.pAddMultiSelecao(arrCodMon,     'CODMON');
  objSalInt.pAddMultiSelecao(arrCodAbr,     'CODABF');
  objSalInt.pAddMultiSelecao(arrCodUni,     'CODUNI');
  objSalInt.pAddMultiSelecao(arrClaIPI,     'CLAIPI');

  objSalInt.fSalvaDados('', Self.Name + IIF(blnAltPorNota, '_Nota', ''), strLoginUsuarioLogado, True);
End;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.FormDestroy(Sender: TObject);
begin
  inherited;

  If Assigned(objFatPre) Then
    FreeAndNil(objFatPre);
end;



Function TfrmAlteracaoGeraldePrecosdeProdutos.fRetDescricaoCadastro(strCodCad: String; blnValidar: Boolean; Var blnErro: Boolean): String;
Begin
  With cdsAltGlo Do
  Begin
    Result  := '';
    blnErro := False;

    If fEmptyStr(strCodCad) Then
      Exit;

    If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODFOR') Then
    Begin
      Result := fRetNomFornecedor(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODGPR') Then
    Begin
      Result := fRetNomeGrupoPrecos(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_PRDGRU') Then
    Begin
      Result := fRetNomeGrupoProduto(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODABF') Then
    Begin
      Result := fRetDesAbfIcm(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_ABFPIS') Then
    Begin
      Result := fRetDesAbfPisCofIpi('PISSAI', strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_ABFCOF') Then
    Begin
      Result := fRetDesAbfPisCofIpi('COFSAI', strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_ABFIPI') Then
    Begin
      Result := fRetDesAbfPisCofIpi('IPISAI', strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODMAR') Then
    Begin
      Result := fRetNomMarca(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODMON') Then
    Begin
      Result := fRetNomMontadora(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODUNI') Then
    Begin
      Result := fRetNomUnidade(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_UNICOM') Then
    Begin
      Result := fRetNomUnidade(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_UNITRI') Then
    Begin
      Result := fRetNomUnidade(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODGRU') Then
    Begin

      If blnValidar And (RightStr(strCodCad, 3) = '000') Then
      Begin
        pMensagemOk('Linha não permitida!');
        Result := '';
      End
      Else
        Result := fRetNomeSoGrupo(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODDEP') Then
    Begin
      Result := fCampoTabela('DEP_DESCRI','CADDEP',['DEP_CODIGO'], [strCodCad]);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_GRUCMP') Then
    Begin
      Result := fRetDescGrupoCompra(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODONU') Then
    Begin
      Result := fRetDescClassificacaoOnu(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODDIC') Then
    Begin
      Result := fRetDesDic(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODLSE') Then
    Begin
      Result := fRetLocSep(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CDCEST') Then
    Begin
      Result := fCampoTabela('CES_DESCRI','CDCEST',['CES_CDCEST'], [strCodCad]);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_SITPRO') Then
    Begin
      Result := fRetNomSituacaoProduto(strCodCad);
    End;

    If blnValidar And fEmptyStr(Result) Then
    Begin
      pMensagemOk('Código não encontrado!');
      blnErro := True;
    End;

  End;

End;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.cdsAltGloBeforePost(DataSet: TDataSet);
begin
  inherited;
  If (Not fEmptyStr(DataSet.FieldByName('ITE_EMPDES').AsString)) And (DataSet.FieldByName('ITE_ALTERA').AsString = 'N') Then
    DataSet.FieldByName('ITE_ALTERA').AsString := 'S'
  Else If fEmptyStr(DataSet.FieldByName('ITE_EMPDES').AsString) Then
    DataSet.FieldByName('ITE_ALTERA').AsString := 'N';

  If Not fEmptyStr(DataSet.FieldByName('ITE_EMPORI').AsString) Then
  Begin
    If fRetNomeEmpresaSelec(DataSet.FieldByName('ITE_EMPORI').AsString) = '' Then
    Begin
      pMensagemOk('Código da Empresa inválido!');
      DataSet.FieldByName('ITE_EMPORI').AsString := '';
    End

    Else If Not fEmpresaAtiva(DataSet.FieldByName('ITE_EMPORI').AsString) Then
    Begin
      pMensagemOk('Empresa inativa no Cadastro de Empresas!');
      DataSet.FieldByName('ITE_EMPORI').AsString := '';
    End
  End;

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.chkNotEntClick(Sender: TObject);
begin
  inherited;

  pHabilitaNotaEntrada(chkNotEnt.Checked);

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.cxeClassfIPIPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  If Not fEmptyStr(DisplayValue) Then
  Begin

    If Length(DisplayValue) <> MAX_CLAIPI Then
    Begin
      Error := True;
      ErrorText := '';
      fMensagem('', 'A Classificação de IPI deve ter ' + IntToStr(MAX_CLAIPI) +  ' caracteres!', ['&OK']);
    End;

  End;

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.cxeConsTam2PropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  Var
    strCodigo: String;
begin
  inherited;

  strCodigo := DisplayValue;

  If (Not fEmptyStr(strCodigo)) And (TcxTextEdit(Sender).Properties.MaxLength > 0) Then
    DisplayValue := fStrZero(strCodigo, TcxTextEdit(Sender).Properties.MaxLength);

  fRetDescricaoCadastro(DisplayValue, True, Error);

  If Error Then
    ErrorText := '';
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.cxeDatePropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  If Not fEmptyStr(DisplayValue) Then
  Begin

    If (Pos(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_DTAVAL') > 0) And
       (StrToDate(DisplayValue) < VS_DATE) Then
    Begin
      Error := True;
      ErrorText := '';
      fMensagem('','Data da Validade de Preço precisa ser maior ou igual a data atual!',['&OK']);
    End;

  End;

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.cxeMasFatPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  Var
    blnfStrToFloat: Boolean;
begin
  inherited;

  If fEmptyStr(DisplayValue) Then
    Exit;

  try
    blnfStrToFloat := true;
    fStrToFloat(DisplayValue);
  except
    on EConvertError do
      blnfStrToFloat := false;
  end;

  If not blnfStrToFloat Then
  Begin
    Error := True;
    ErrorText := '';
  End Else
  Begin

    If Not fValidaValor(DisplayValue) Then
    Begin
      Error := True;
      ErrorText := '';
    End

    Else If Pos(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString,
           'ITE_PRECOM_ITE_PREVE1_ITE_PREVE2_ITE_PREVE3_ITE_PREVE4_ITE_PREVE5_ITE_PREVE6_ITE_PREVE7_' +
           'ITE_MINTB1_ITE_MINTB2_ITE_MINTB3_ITE_MINTB4_ITE_MINTB5_ITE_MINTB6_ITE_MINTB7_ITE_EMBALA_') > 0 Then
    Begin
    End;

  End;

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.cxeMasIntPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  Var
    intValor: Integer;
begin
  inherited;

  If fEmptyStr(DisplayValue) Then
    Exit;

  If Not TryStrToInt(DisplayValue, intValor) Then
  Begin
    Error := True;
    ErrorText := '';
  End

  Else If Not fValidaValor(DisplayValue) Then
  Begin
    Error := True;
    ErrorText := '';
  End;

end;

Function TfrmAlteracaoGeraldePrecosdeProdutos.fValidaValor(strValor: String): Boolean;
Begin

  Result := True;

  If (Pos(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_FATUTR') > 0) And
     (fStrToFloat(strValor) <= 0) Then
  Begin
    Result := False;
    pMensagemOk('O ' + cdsAltGlo.FieldByName('ITE_DESCAM').AsString + ' deve se maior que zero!');
  End

 (* Else If (Pos(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString,
          'ITE_IPISAI-ITE_FATCMP-ITE_DIAFOR-ITE_PRAMIN-ITE_TMPGAR-ITE_MESGIR-ITE_PRAVAL_' +
          'ITE_VLCFRE-ITE_DENSID-ITE_LARVID-ITE_ALTVID-ITE_LAMAVI-ITE_ALMAVI') > 0) And
          (fStrToFloat(strValor) < 0) Then *)

  Else If (Pos('MARBR', cdsAltGlo.FieldByName('ITE_NOMCAM').AsString) = 0) And
          (fStrToFloat(strValor) < 0) Then
  Begin
    Result := False;

    pMensagemOk('O ' + cdsAltGlo.FieldByName('ITE_DESCAM').AsString + ' deve se maior ou igual a zero!');
  End;

End;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.cxeMasPerPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  Var
    blnfStrToFloat: Boolean;
begin
  inherited;

  If fEmptyStr(DisplayValue) Then
    Exit;

  try
    blnfStrToFloat := true;
    fStrToFloat(DisplayValue);
  except
    on EConvertError do
      blnfStrToFloat := false;
  end;

  If Not blnfStrToFloat Then
  Begin
    Error := True;
    ErrorText := '';
  End Else
  Begin

    If Not fValidaValor(DisplayValue) Then
    Begin
      Error := True;
      ErrorText := '';
    End

    Else If (Pos(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString,
            'ITE_PER_CI-ITE_COMDIG-ITE_IMPFED-ITE_DESSIT-ITE_DESOPE') > 0) And
            (Not fValidaEscala(DisplayValue, 0, 100)) Then
    Begin
      Error := True;
      ErrorText := '';

      pMensagemOk('O ' + cdsAltGlo.FieldByName('ITE_DESCAM').AsString + ' deve estar entre 0 e 100!');
    End;

  End;

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.cxeString03PropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  If Not fEmptyStr(DisplayValue) Then
  Begin

    If (Pos(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_EXCIPI') > 0) And
       (StrToIntDef(DisplayValue, -1) <= 0) Or
       (StrToIntDef(DisplayValue, -1) > 11) Then
    Begin
      fMensagem('', 'O campo EX IPI deve ser (vazio) ou estar na faixa de 1 até 11!', ['&OK']);
      Error := True;
      ErrorText := '';
    End;

 End;

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.cxvTiposAltALTERAPropertiesChange(Sender: TObject);
begin
  {inherited;

  If cdsAltGlo.FieldByName('ITE_ALTERA').AsString = 'N' Then
  Begin
    If cdsAltGlo.State <> dsEdit Then
      cdsAltGlo.Edit;

    cdsAltGlo.FieldByName('ITE_VALCAM').Clear;

    cdsAltGlo.Post;

  End Else
  Begin

    cxvTiposAltVALCAM.Focused := True;

  End;
   }
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.cxvTiposAltDataControllerFilterChanged(
  Sender: TObject);
  var
  I: Integer;
  S: string;
begin
  inherited;

  If cxvTiposAlt.ViewData.FilterRow.Focused then
  begin
    for I := 0 to cxvTiposAlt.ColumnCount - 1 do
    begin
      S := VarToStr(cxvTiposAlt.ViewData.FilterRow.Values[I]);
      if (Length(S)> 0) and (S[1] <> '%') then
        cxvTiposAlt.ViewData.FilterRow.Values[I] := '%' + S;
    end;
  end;
  strFiltro := cxvTiposAlt.DataController.Filter.FilterText;
end;


procedure TfrmAlteracaoGeraldePrecosdeProdutos.cxvTiposAltDESCAMGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  AText := Copy(AText, 1, pos('|', AText) -1);
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.cxvTiposAltDESCAMStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;

  If Not (Assigned(ARecord)) Then
    Exit;

  If (ARecord.Values[cxvTiposAltALTERA.Index] <> Null) And
      (VarToString(ARecord.Values[cxvTiposAltALTERA.Index]) = 'S') Then
    AStyle := cxsAltera;

end;

(*
procedure TfrmAlteracaoGeraldePrecosdeProdutos.pSalvaDados(strValCam, strDescri: String);
Begin
  If cdsAltGlo.State <> dsEdit Then
     cdsAltGlo.Edit;

  cdsAltGlo.FieldByName('ITE_ALTERA').AsString := 'S';
  cdsAltGlo.FieldByName('ITE_VALCAM').AsString := strValCam;
  cdsAltGlo.FieldByName('ITE_DESCRI').AsString := strDescri;

  cdsAltGlo.Post;
End;
*)

procedure TfrmAlteracaoGeraldePrecosdeProdutos.cxvTiposAltEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
  Var
    arrSelecao: TConsultasArray;
    qryDados: TUniQuery;

  Procedure pSalva(strDado: String);
  Begin
    Key := #0;
    AEdit.EditValue := strDado;
    AEdit.PostEditValue;
    Key := #0;

    Keybd_Event(VK_RETURN, 0, 0, 0);
  End;

begin
  inherited;

  If (fEntraCons(Key)) And (AItem = cxvTiposAltEmpOrigem) Then
  Begin
    Try
      qryDados := fCriaQuery;
      If (fPesqEmpresasAtivas(conEmpSimples, Self, Nil, Nil, qryDados, Key, arrSelecao)) And
         (Not fEmptyStr(qryDados.FieldByName('EMP_CODEMP').AsString)) Then
      Begin
        cdsAltGlo.Edit;
        cdsAltGlo.FieldByname('ITE_EMPORI').AsString := qryDados.FieldByName('EMP_CODEMP').AsString;
        cdsAltGlo.Post;
        Exit;
      End;
    Finally
      FreeAndNil(qryDados);
    End;
  End;

  IF (AItem = cxvTiposAltEMPDES) Then
  Begin
    If Key = #8 Then
      Exit;

    pMensagemOk('Utilize o botão da celula para selecionar as empresas');
    Key := #0;
    Exit;
  End;

  If blnVidroInteiro And
     (Pos(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_LARVID_ITE_ALTVID_ITE_LAMAVI_ITE_ALMAVI') > 0) And
     CharInSet(Key, [',','.','-']) Then
  Begin
    Key := #0;
    Exit;
  End;

  If fEntraCons(Key) And
     fTemConsultaTabela(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString) Then
  Begin

    qryDados := fCriaQuery;

    If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODFOR') And
       fPesqFornecedor(conForSimples, Self, Nil, Nil, qryDados, Key, arrSelecao, True) And
       (Not fEmptyStr(qryDados.FieldByName('FOR_CODFOR').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('FOR_CODFOR').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODGPR') And
            fPesqGrupoPrecos(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('GPR_CODIGO').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('GPR_CODIGO').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_PRDGRU') And
            fPesqGrupoProduto(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('PRD_CODGRU').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('PRD_CODGRU').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODABF') And
            fPesqAbrevFiscal(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('ABF_CODABF').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('ABF_CODABF').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_ABFPIS') And
            fPesqPISSAI(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('APC_CODAPC').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('APC_CODAPC').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_ABFCOF') And
            fPesqCOFSAI(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('APC_CODAPC').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('APC_CODAPC').AsString);

    End


    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_ABFIPI') And
            fPesqIPISAI(Self, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('APC_CODAPC').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('APC_CODAPC').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODMAR') And
            fPesqMarcas(Self, Nil, nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('MAR_CODMAR').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('MAR_CODMAR').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_SITPRO') And
            fPesqSituacaoProduto(Self, Nil, nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('SIT_CODIGO').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('SIT_CODIGO').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODMON') And
            fPesqMontadora(Self, Nil, nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('MON_CODMON').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('MON_CODMON').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODUNI') And
            fPesqUnidade(Self, Nil, nil, nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('UNI_CODUNI').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('UNI_CODUNI').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_UNICOM') And
            fPesqUnidade(Self, Nil, nil, nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('UNI_CODUNI').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('UNI_CODUNI').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_UNITRI') And
            fPesqUnidade(Self, Nil, nil, nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('UNI_CODUNI').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('UNI_CODUNI').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODGRU') And
            fPesqGrupo(Self, Nil, nil, qryDados, Key, arrSelecao, False, False, True) And
            (Not fEmptyStr(qryDados.FieldByName('GRU_CODGRU').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('GRU_CODGRU').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODDEP') And
            fPesqDepartamento(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('DEP_CODIGO').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('DEP_CODIGO').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_GRUCMP') And
            fPesqGrupoCompra(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('GRU_CODIGO').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('GRU_CODIGO').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODONU') And
            fPesqClassificacaoOnu(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('ONU_CODONU').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('ONU_CODONU').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODDIC') And
            fPesqDic(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('DIC_CODDIC').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('DIC_CODDIC').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODLSE') And
            fPesqLocSep(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('LSE_CODIGO').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('LSE_CODIGO').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CDCEST') And
            fPesqCest(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('CES_CDCEST').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('CES_CDCEST').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_SITPRO') And
            fPesqSituacaoProduto(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('SIT_CODIGO').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('CES_CDCEST').AsString);

    End;

    FreeAndNil(qryDados);
  End;

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.cxvTiposAltEMPDESPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  var frmSelEmpresas:  TfrmSelEmpresas;
begin
  inherited;
  pCriarFormularios(TfrmSelEmpresas, frmSelEmpresas);
  Try
    frmSelEmpresas.strCodEmp := dtsAltGlo.DataSet.FieldByName('ITE_EMPORI').AsString;
    dtsAltGlo.DataSet.Edit;
    dtsAltGlo.DataSet.FieldByName('ITE_EMPDES').AsString := frmSelEmpresas.fRetEmpresasSel(dtsAltGlo.DataSet.FieldByName('ITE_EMPDES').AsString);
    dtsAltGlo.DataSet.Post;
  Finally
    FReeAndNil(frmSelEmpresas);
  End;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.cxvTiposAltFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;
//  TcxButtonEditProperties(cxvTiposAltEMPDES.Properties).Buttons[0].Caption :=  cxvTiposAltEMPDES.EditValue;
end;

function TfrmAlteracaoGeraldePrecosdeProdutos.fTemConsultaTabela(strNomCam: String): Boolean;
Begin
  Result := Pos(strNomCam, 'ITE_CODFOR_ITE_CODGPR_ITE_PRDGRU_ITE_CODABF_ITE_ABFPIS_ITE_ABFCOF_ITE_ABFIPI_' +
                           'ITE_CODMAR_ITE_NOMCAM_ITE_CODMON_ITE_CODUNI_ITE_UNICOM_ITE_UNITRI_ITE_CODGRU_' +
                           'ITE_CODDEP_ITE_GRUCMP_ITE_CODONU_ITE_CODDIC_ITE_CODLSE_ITE_CDCEST_ITE_SITPRO') > 0;
End;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.cxvTiposAltVALCAMGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;

  If Not (Assigned(ARecord)) Then
    Exit;

  If fEmptyStr(AText) Then
    Exit;

  If SameText(VarToString(ARecord.Values[cxvTiposAltPROPER.Index]), 'cxeMasFat') Then
    AText := FormatFloat(strMasFat, fStrToFloat(AText))

  Else If SameText(VarToString(ARecord.Values[cxvTiposAltPROPER.Index]), 'cxeDecUni') Then
    AText := FormatFloat(strMasDecUni, fStrToFloat(AText))

  Else If SameText(VarToString(ARecord.Values[cxvTiposAltPROPER.Index]), 'cxeDec05') Then
    AText := FormatFloat(strMasDec05, fStrToFloat(AText))

  Else If SameText(VarToString(ARecord.Values[cxvTiposAltPROPER.Index]), 'cxeDec06') Then
    AText := FormatFloat(strMasDec06, fStrToFloat(AText))

  Else If SameText(VarToString(ARecord.Values[cxvTiposAltPROPER.Index]), 'cxeMasPer') Then
    AText := FormatFloat(strMasPer, fStrToFloat(AText))

  Else If SameText(VarToString(ARecord.Values[cxvTiposAltPROPER.Index]), 'cxeMasMar') Then
    AText := FormatFloat(strMasMar, fStrToFloat(AText))

  Else If SameText(VarToString(ARecord.Values[cxvTiposAltPROPER.Index]), 'cxeMasMBr') Then
    AText := FormatFloat(strMasMBr, fStrToFloat(AText))

  Else If SameText(VarToString(ARecord.Values[cxvTiposAltPROPER.Index]), 'cxeMasVal') Then
    AText := FormatFloat(strMasVal, fStrToFloat(AText))

  Else If SameText(VarToString(ARecord.Values[cxvTiposAltPROPER.Index]), 'cxeMasInt') Then
    AText := FormatFloat(strMasInt, fStrToFloat(AText))

  Else If fTemConsultaTabela(VarToString(ARecord.Values[cxvTiposAltNOMCAM.Index])) And
          (Not fEmptyStr(AText)) Then
    AText := AText + ' - ' + VarToString(ARecord.Values[cxvTiposAltDESCRI.Index]);

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.cxvTiposAltVALCAMGetProperties(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
  Var
    intIdx: Integer;
begin
  inherited;


  If Not (Assigned(ARecord)) Then
    Exit;

  intIdx := cxvTiposAltPROPER.Index;

  If (ARecord.Values[intIdx] <> Null) Then
    pRetProperties(VarToString(ARecord.Values[intIdx]), AProperties);

end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.cxvTiposAltVALCAMStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;


  If Not (Assigned(ARecord)) Then
    Exit;

  If (ARecord.Values[cxvTiposAltPROPER.Index] <> Null) And
     AnsiStartsStr ('cmb', VarToString(ARecord.Values[cxvTiposAltPROPER.Index])) Then
    AStyle := cxsCombo

  Else If fTemConsultaTabela(VarToString(ARecord.Values[cxvTiposAltNOMCAM.Index])) Then
    AStyle := cxsConsulta;

end;

Procedure TfrmAlteracaoGeraldePrecosdeProdutos.pRetProperties(strNomProp: String; var AProperties: TcxCustomEditProperties);
Begin
  If Assigned(FindComponent(strNomProp)) Then
    AProperties := TcxEditRepositoryItem(FindComponent(strNomProp)).Properties;
End;

function TfrmAlteracaoGeraldePrecosdeProdutos.fRetDesAbfPisCofIpi(strTabela, strCod: String): String;
  Var
    qryAbf: TUniQuery;
begin
  qryAbf := fCriaQuery(Self);
  qryAbf.SQL.Add('SELECT APC_DESCRI FROM ' + strTabela +  ' WHERE APC_CODAPC = :CODAPC');
  qryAbf.ParamByName('CODAPC').AsString := strCod;
  qryAbf.Open;

  Result := qryAbf.FieldByName('APC_DESCRI').AsString;

  FreeAndNil(qryAbf);
end;

(*
procedure TfrmAlteracaoGeraldePrecosdeProdutos.pCDCESTKeyPress;
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
begin
  chrKey := '/';
  If fPesqCest(Self, edtCamAlt, Nil, Nil, chrKey, arrSel) Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;
*)


procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtAbfCofExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtAbfCof, edtDesCof, arrAbfCof, fRetDesAbfCof, Nil, 'da abreviação de COFINS');
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtAbfCofKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCofSai(Self, edtAbfCof, edtDesCof, Nil, Key, arrAbfCof, False) Then
  Begin
    If fValidaCampos(edtAbfCof, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtAbfPisExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtAbfPis, edtDesPis, arrAbfPis, fRetDesAbfPis, Nil, 'da abreviação de PIS');
end;

procedure TfrmAlteracaoGeraldePrecosdeProdutos.edtAbfPisKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqPisSai(Self, edtAbfPis, edtDesPis, Nil, Key, arrAbfPis, False) Then
  Begin
    If fValidaCampos(edtCodGpr, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;


function TfrmAlteracaoGeraldePrecosdeProdutos.fSetaSQL(strEmpOrigem: String = ''; strEmpDestino: String = ''): String;
var intCorre: Integer;
Begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE ';

  Result := Result + '  0 AS MARNEG, ';
  Result := Result + '  G.ITE_CODEMP, ';

  Result := Result + '  I.ITE_CODGRU, ';
  Result := Result + '  I.ITE_CODFOR, ';
  Result := Result + '  I.ITE_CODITE, ';
  Result := Result + '  I.ITE_DESITE, ';
  Result := Result + '  0.00 AS ITE_SALDOS, ';

  Result := Result + '  G.ITE_TCIFCU, ';
  Result := Result + '  G.ITE_TCIFCU AS "ITE_TCIFCU_NOV", ';
  Result := Result + '  G.ITE_TSCUST, ';
  Result := Result + '  G.ITE_TSCUST AS "ITE_TSCUST_NOV", ';
  Result := Result + '  G.ITE_DEPICO, ';
  Result := Result + '  G.ITE_DEPICO AS "ITE_DEPICO_NOV", ';
  Result := Result + '  G.ITE_DEICMS, ';
  Result := Result + '  G.ITE_DEICMS AS "ITE_DEICMS_NOV", ';
  Result := Result + '  G.ITE_FATREG, ';
  Result := Result + '  G.ITE_FATREG AS "ITE_FATREG_NOV", ';

  Result := Result + '  G.ITE_SAL_ML, ';
  Result := Result + '  I.ITE_CNV_ML, ';
  Result := Result + '  IF(TIPABF.SIS_VALCFG = "1", I.ITE_CODABF, G.ITE_CODABF) AS ITE_CODABF, ';
  Result := Result + '  IF(TPABPC.SIS_VALCFG = "1", I.ITE_ABFPIS, G.ITE_ABFPIS) AS ITE_ABFPIS, ';
  Result := Result + '  IF(TPABPC.SIS_VALCFG = "1", I.ITE_ABFCOF, G.ITE_ABFCOF) AS ITE_ABFCOF, ';
  Result := Result + '  IF(TPABPC.SIS_VALCFG = "1", I.ITE_ABFIPI, G.ITE_ABFIPI) AS ITE_ABFIPI, ';


  If fCfgSis('ENTFUT', varBoolean) And MatchStr(fCfgSis('CALSAL'), ['1', '3', '4', '5']) Then
    Result := Result + '  ROUND((G.ITE_SALDOS * IF(IFNULL(ITE_CNV_ML,0) <= 0, 1, ITE_CNV_ML)) + ' + fGetSQLSomaCamposEntregaFutura() + ', 3) AS "SaldoNumerico", '
  Else
    Result := Result + '  ROUND((G.ITE_SALDOS * IF(IFNULL(ITE_CNV_ML,0) <= 0, 1, ITE_CNV_ML)), 3) AS "SaldoNumerico", ';

  Result := Result + '  IFNULL(G.ITE_PREDOL, "N") AS ITE_PREDOL, ';
  Result := Result + '  IFNULL(G.ITE_PREDOL, "N") AS ITE_PREDOL_NOV, ';

  Result := Result + '  G.ITE_PRAMIN, ';
  Result := Result + '  G.ITE_PRAMIN AS "ITE_PRAMIN_NOV", ';

  Result := Result + '  G.ITE_IMPLIS, ';
  Result := Result + '  G.ITE_IMPLIS AS "ITE_IMPLIS_NOV", ';

  Result := Result + '  G.ITE_SITPRO, ';
  Result := Result + '  G.ITE_SITPRO AS "ITE_SITPRO_NOV", ';

  If blnValFor Then
  Begin
    Result := Result + '  G.ITE_DTAVAL, ';
    Result := Result + '  G.ITE_DTAVAL AS "ITE_DTAVAL_NOV", ';
  End;

  Result := Result + '  G.ITE_CPRCEN, ';
  Result := Result + '  G.ITE_CPRCEN AS "ITE_CPRCEN_NOV", ';
  Result := Result + '  G.ITE_ABAMLT, ';
  Result := Result + '  G.ITE_ABAMLT AS "ITE_ABAMLT_NOV", ';
  Result := Result + '  G.ITE_DESCHK, ';
  Result := Result + '  G.ITE_DESCHK AS "ITE_DESCHK_NOV", ';
  Result := Result + '  G.ITE_PRECOM, ';
  Result := Result + '  G.ITE_PRECOM AS "ITE_PRECOM_NOV", ';
  Result := Result + '  G.ITE_PREVE1, ';
  Result := Result + '  G.ITE_PREVE1 AS "ITE_PREVE1_NOV", ';
  Result := Result + '  G.ITE_PREVE2, ';
  Result := Result + '  G.ITE_PREVE2 AS "ITE_PREVE2_NOV", ';
  Result := Result + '  G.ITE_PREVE3, ';
  Result := Result + '  G.ITE_PREVE3 AS "ITE_PREVE3_NOV", ';
  Result := Result + '  G.ITE_PREVE4, ';
  Result := Result + '  G.ITE_PREVE4 AS "ITE_PREVE4_NOV", ';
  Result := Result + '  G.ITE_PREVE5, ';
  Result := Result + '  G.ITE_PREVE5 AS "ITE_PREVE5_NOV", ';
  Result := Result + '  G.ITE_PREVE6, ';
  Result := Result + '  G.ITE_PREVE6 AS "ITE_PREVE6_NOV", ';
  Result := Result + '  G.ITE_PREVE7, ';
  Result := Result + '  G.ITE_PREVE7 AS "ITE_PREVE7_NOV", ';
  Result := Result + '  G.ITE_DESF01, ';
  Result := Result + '  G.ITE_DESF01 AS "ITE_DESF01_NOV", ';
  Result := Result + '  G.ITE_DESF02, ';
  Result := Result + '  G.ITE_DESF02 AS "ITE_DESF02_NOV", ';
  Result := Result + '  G.ITE_DESF03, ';
  Result := Result + '  G.ITE_DESF03 AS "ITE_DESF03_NOV", ';
  Result := Result + '  G.ITE_DESF04, ';
  Result := Result + '  G.ITE_DESF04 AS "ITE_DESF04_NOV", ';
  Result := Result + '  G.ITE_DESF05, ';
  Result := Result + '  G.ITE_DESF05 AS "ITE_DESF05_NOV", ';
  Result := Result + '  G.ITE_DESF06, ';
  Result := Result + '  G.ITE_DESF06 AS "ITE_DESF06_NOV", ';
  Result := Result + '  G.ITE_ICMENT, ';
  Result := Result + '  G.ITE_ICMENT AS "ITE_ICMENT_NOV", ';
  Result := Result + '  G.ITE_SUBFED, ';
  Result := Result + '  G.ITE_SUBFED AS "ITE_SUBFED_NOV", ';
  Result := Result + '  G.ITE_IPIENT, ';
  Result := Result + '  G.ITE_IPIENT AS "ITE_IPIENT_NOV", ';
  Result := Result + '  G.ITE_IPISAI, ';
  Result := Result + '  G.ITE_IPISAI AS "ITE_IPISAI_NOV", ';
  Result := Result + '  G.ITE_FREENT, ';
  Result := Result + '  G.ITE_FREENT AS "ITE_FREENT_NOV", ';
  Result := Result + '  G.ITE_VALFRE, ';
  Result := Result + '  G.ITE_VALFRE AS "ITE_VALFRE_NOV", ';
  Result := Result + '  G.ITE_ACRFIN, ';
  Result := Result + '  G.ITE_ACRFIN AS "ITE_ACRFIN_NOV", ';
  Result := Result + '  G.ITE_SUBSTI, ';
  Result := Result + '  G.ITE_SUBSTI AS "ITE_SUBSTI_NOV", ';
  Result := Result + '  G.ITE_DESADB, ';
  Result := Result + '  G.ITE_DESADB AS "ITE_DESADB_NOV", ';
  Result := Result + '  G.ITE_IMPFED, ';
  Result := Result + '  G.ITE_IMPFED AS "ITE_IMPFED_NOV", ';
  Result := Result + '  G.ITE_DESOPE, ';
  Result := Result + '  G.ITE_DESOPE AS "ITE_DESOPE_NOV", ';
  Result := Result + '  G.ITE_ICMSAI, ';
  Result := Result + '  G.ITE_ICMSAI AS "ITE_ICMSAI_NOV", ';

  if not blnIteTbp Then
  Begin
    Result := Result + '  G.ITE_DESMAX, ';
    Result := Result + '  G.ITE_DESMAX AS "ITE_DESMAX_NOV", ';
    Result := Result + '  G.ITE_DESMGE, ';
    Result := Result + '  G.ITE_DESMGE AS "ITE_DESMGE_NOV", ';
    Result := Result + '  G.ITE_DESMSU, ';
    Result := Result + '  G.ITE_DESMSU AS "ITE_DESMSU_NOV", ';
  End
  Else
  Begin
    For intCorre := 1 To Length(VS_strTabPrc) Do
          Result := Result + fAddIteTbp(intCorre);
  End;

  Result := Result + '  G.ITE_PRECUS, ';
  Result := Result + '  G.ITE_PRECUS AS "ITE_PRECUS_NOV", ';
  Result := Result + '  G.ITE_OUTVAL, ';
  Result := Result + '  G.ITE_OUTVAL AS "ITE_OUTVAL_NOV", ';

  Result := Result + '  G.ITE_MARBR1, ';
  Result := Result + '  G.ITE_MARBR1 AS "ITE_MARBR1_NOV", ';
  Result := Result + '  G.ITE_MARBR2, ';
  Result := Result + '  G.ITE_MARBR2 AS "ITE_MARBR2_NOV", ';
  Result := Result + '  G.ITE_MARBR3, ';
  Result := Result + '  G.ITE_MARBR3 AS "ITE_MARBR3_NOV", ';
  Result := Result + '  G.ITE_MARBR4, ';
  Result := Result + '  G.ITE_MARBR4 AS "ITE_MARBR4_NOV", ';
  Result := Result + '  G.ITE_MARBR5, ';
  Result := Result + '  G.ITE_MARBR5 AS "ITE_MARBR5_NOV", ';
  Result := Result + '  G.ITE_MARBR6, ';
  Result := Result + '  G.ITE_MARBR6 AS "ITE_MARBR6_NOV", ';
  Result := Result + '  G.ITE_MARBR7, ';
  Result := Result + '  G.ITE_MARBR7 AS "ITE_MARBR7_NOV", ';

  Result := Result + ' 0.00 AS ITE_MARLQ1, ';
  Result := Result + ' 0.00 AS "ITE_MARLQ1_NOV", ';
  Result := Result + ' 0.00 AS ITE_MARLQ2, ';
  Result := Result + ' 0.00 AS "ITE_MARLQ2_NOV", ';
  Result := Result + ' 0.00 AS ITE_MARLQ3, ';
  Result := Result + ' 0.00 AS "ITE_MARLQ3_NOV", ';
  Result := Result + ' 0.00 AS ITE_MARLQ4, ';
  Result := Result + ' 0.00 AS "ITE_MARLQ4_NOV", ';
  Result := Result + ' 0.00 AS ITE_MARLQ5, ';
  Result := Result + ' 0.00 AS "ITE_MARLQ5_NOV", ';
  Result := Result + ' 0.00 AS ITE_MARLQ6, ';
  Result := Result + ' 0.00 AS "ITE_MARLQ6_NOV", ';
  Result := Result + ' 0.00 AS ITE_MARLQ7, ';
  Result := Result + ' 0.00 AS "ITE_MARLQ7_NOV", ';

  If fCfgSis('MARIDE', VarBoolean) Then
  Begin
    Result := Result + '  G.ITE_MARID1, ';
    Result := Result + '  G.ITE_MARID1 AS "ITE_MARID1_NOV", ';
    Result := Result + '  G.ITE_MARID2, ';
    Result := Result + '  G.ITE_MARID2 AS "ITE_MARID2_NOV", ';
    Result := Result + '  G.ITE_MARID3, ';
    Result := Result + '  G.ITE_MARID3 AS "ITE_MARID3_NOV", ';
    Result := Result + '  G.ITE_MARID4, ';
    Result := Result + '  G.ITE_MARID4 AS "ITE_MARID4_NOV", ';
    Result := Result + '  G.ITE_MARID5, ';
    Result := Result + '  G.ITE_MARID5 AS "ITE_MARID5_NOV", ';
    Result := Result + '  G.ITE_MARID6, ';
    Result := Result + '  G.ITE_MARID6 AS "ITE_MARID6_NOV", ';
    Result := Result + '  G.ITE_MARID7, ';
    Result := Result + '  G.ITE_MARID7 AS "ITE_MARID7_NOV", ';
  End;

  Result := Result + '  G.ITE_COMTB1, ';
  Result := Result + '  G.ITE_COMTB1 AS "ITE_COMTB1_NOV", ';
  Result := Result + '  G.ITE_COMTB2, ';
  Result := Result + '  G.ITE_COMTB2 AS "ITE_COMTB2_NOV", ';
  Result := Result + '  G.ITE_COMTB3, ';
  Result := Result + '  G.ITE_COMTB3 AS "ITE_COMTB3_NOV", ';
  Result := Result + '  G.ITE_COMTB4, ';
  Result := Result + '  G.ITE_COMTB4 AS "ITE_COMTB4_NOV", ';
  Result := Result + '  G.ITE_COMTB5, ';
  Result := Result + '  G.ITE_COMTB5 AS "ITE_COMTB5_NOV", ';
  Result := Result + '  G.ITE_COMTB6, ';
  Result := Result + '  G.ITE_COMTB6 AS "ITE_COMTB6_NOV", ';
  Result := Result + '  G.ITE_COMTB7, ';
  Result := Result + '  G.ITE_COMTB7 AS "ITE_COMTB7_NOV", ';
  Result := Result + '  G.ITE_COMVAR, ';
  Result := Result + '  G.ITE_COMVAR AS "ITE_COMVAR_NOV", ';
  Result := Result + '  G.ITE_COMATA, ';
  Result := Result + '  G.ITE_COMATA AS "ITE_COMATA_NOV", ';
  Result := Result + '  G.ITE_COMDIS, ';
  Result := Result + '  G.ITE_COMDIS AS "ITE_COMDIS_NOV", ';
  Result := Result + '  G.ITE_COMDIG, ';
  Result := Result + '  G.ITE_COMDIG AS "ITE_COMDIG_NOV", ';
  Result := Result + '  G.ITE_COMMEC, ';
  Result := Result + '  G.ITE_COMMEC AS "ITE_COMMEC_NOV", ';
  Result := Result + '  G.ITE_COMPRO, ';
  Result := Result + '  G.ITE_COMPRO AS "ITE_COMPRO_NOV", ';
  Result := Result + '  G.ITE_QTPPRO, ';
  Result := Result + '  G.ITE_QTPPRO AS "ITE_QTPPRO_NOV", ';

  Result := Result + '  G.ITE_LOCFIS, ';
  Result := Result + '  G.ITE_LOCFIS AS "ITE_LOCFIS_NOV", ';
  Result := Result + '  G.ITE_TAMLCF, ';
  Result := Result + '  G.ITE_TAMLCF AS "ITE_TAMLCF_NOV", ';
  Result := Result + '  G.ITE_LOCSUP, ';
  Result := Result + '  G.ITE_LOCSUP AS "ITE_LOCSUP_NOV", ';
  Result := Result + '  G.ITE_TAMLCS, ';
  Result := Result + '  G.ITE_TAMLCS AS "ITE_TAMLCS_NOV", ';
  Result := Result + '  G.ITE_CODLSE, ';
  Result := Result + '  G.ITE_CODLSE AS "ITE_CODLSE_NOV", ';
  Result := Result + '  G.ITE_MARMIN, ';
  Result := Result + '  G.ITE_MARMIN AS "ITE_MARMIN_NOV", ';
  Result := Result + '  G.ITE_MARMSG, ';
  Result := Result + '  G.ITE_MARMSG AS "ITE_MARMSG_NOV", ';
  Result := Result + '  G.ITE_MARMGE, ';
  Result := Result + '  G.ITE_MARMGE AS "ITE_MARMGE_NOV", ';

  Result := Result + '  G.ITE_CPESOB, ';
  Result := Result + '  G.ITE_CPESOB AS "ITE_CPESOB_NOV", ';

  Result := Result + '  G.ITE_RECDEV, ';
  Result := Result + '  G.ITE_RECDEV AS "ITE_RECDEV_NOV", ';

  Result := Result + '  G.ITE_NIVCRI, ';
  Result := Result + '  G.ITE_NIVCRI AS "ITE_NIVCRI_NOV", ';

  Result := Result + '  DE.ITE_DESSIT, ';
  Result := Result + '  DE.ITE_DESSIT AS "ITE_DESSIT_NOV", ';

  Result := Result + '  DE.ITE_CRODOC, ';
  Result := Result + '  DE.ITE_CRODOC AS "ITE_CRODOC_NOV",  ';

  Result := Result + '  DE.ITE_EXPALT, ';
  Result := Result + '  DE.ITE_EXPALT AS "ITE_EXPALT_NOV", ';

  Result := Result + '  DE.ITE_EXPLAR, ';
  Result := Result + '  DE.ITE_EXPLAR AS "ITE_EXPLAR_NOV", ';

  Result := Result + '  DE.ITE_EXPPRO, ';
  Result := Result + '  DE.ITE_EXPPRO AS "ITE_EXPPRO_NOV", ';



  Result := Result + '  G.ITE_MINTB1, ';
  Result := Result + '  G.ITE_MINTB1 AS "ITE_MINTB1_NOV", ';
  Result := Result + '  G.ITE_MINTB2, ';
  Result := Result + '  G.ITE_MINTB2 AS "ITE_MINTB2_NOV", ';
  Result := Result + '  G.ITE_MINTB3, ';
  Result := Result + '  G.ITE_MINTB3 AS "ITE_MINTB3_NOV", ';
  Result := Result + '  G.ITE_MINTB4, ';
  Result := Result + '  G.ITE_MINTB4 AS "ITE_MINTB4_NOV", ';
  Result := Result + '  G.ITE_MINTB5, ';
  Result := Result + '  G.ITE_MINTB5 AS "ITE_MINTB5_NOV", ';
  Result := Result + '  G.ITE_MINTB6, ';
  Result := Result + '  G.ITE_MINTB6 AS "ITE_MINTB6_NOV", ';
  Result := Result + '  G.ITE_MINTB7, ';
  Result := Result + '  G.ITE_MINTB7 AS "ITE_MINTB7_NOV", ';

  {******************}
  {* ESTOQUE MÍNIMO *}
  {***************RV*}
  Result := Result + '  G.ITE_ESTMIN, ';
  Result := Result + '  G.ITE_ESTMIN AS "ITE_ESTMIN_NOV", ';
  {******************}
  {* ESTOQUE MÁXIMO *}
  {***************RV*}
  Result := Result + '  G.ITE_ESTMAX, ';
  Result := Result + '  G.ITE_ESTMAX AS "ITE_ESTMAX_NOV",  ';

  Result := Result + '  G.ITE_TIPPRO, ';
  Result := Result + '  G.ITE_TIPPRO AS "ITE_TIPPRO_NOV",  ';

  Result := Result + '  G.ITE_PESOBR, ';
  Result := Result + '  G.ITE_PESOBR AS "ITE_PESOBR_NOV",   ';

  Result := Result + '  MARMKP.SIS_VALCFG  AS MARMKP, ';
  Result := Result + '  DECUNI.SIS_VALCFG  AS DECUNI, ';
  Result := Result + '  PCMPRO.SIS_VALCFG  AS PCMPRO, ';
  Result := Result + '  CADCID.CID_ESTADO  AS EMP_ESTEMP ';



  Result := Result + 'FROM ';
  Result := Result + '  ITEGER  G ';
  Result := Result + '  JOIN  CADITE I ON G.ITE_CODITE = I.ITE_CODITE ';
  Result := Result + '  JOIN CADEMP ON EMP_CODEMP = G.ITE_CODEMP ';
  Result := Result + '  JOIN CADCID ON CID_CODCID = EMP_CODCID ';
  Result := Result + '  JOIN CFGSIS MARMKP ON MARMKP.SIS_CODCFG = "CFG_MARMKP" AND MARMKP.SIS_CODEMP = G.ITE_CODEMP ';
  Result := Result + '  JOIN CFGSIS TIPABF ON TIPABF.SIS_CODCFG = "CFG_TIPABF" AND TIPABF.SIS_CODEMP = G.ITE_CODEMP ';
  Result := Result + '  JOIN CFGSIS TPABPC ON TPABPC.SIS_CODCFG = "CFG_TPABPC" AND TPABPC.SIS_CODEMP = G.ITE_CODEMP ';
  Result := Result + '  JOIN CFGSIS DECUNI ON DECUNI.SIS_CODCFG = "CFG_DECUNI" AND DECUNI.SIS_CODEMP = G.ITE_CODEMP ';
  Result := Result + '  JOIN CFGSIS PCMPRO ON PCMPRO.SIS_CODCFG = "CFG_PCMPRO" AND PCMPRO.SIS_CODEMP = G.ITE_CODEMP ';



  Result := Result + '  LEFT JOIN DESSIT DE ON G.ITE_CODITE = DE.ITE_CODITE ';

  If chkNotEnt.Checked Then
  Begin
    Result := Result + ' JOIN MOVDET D ON D.DET_CODITE = I.ITE_CODITE ';
    If (Not fEmptyStr(edtDocumento.Text)) Then
      Result := Result + '              AND D.DET_NUMDOC = :NUMDOC      '
    Else
      Result := Result + '              AND D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN  ';

    If Not fEmptyStr(edtSerie.Text) Then
      Result := Result + '              AND D.DET_SERIE_ = :SERDOC      ';
    If Not fEmptyStr(edtCodEmpresa.Text) Then
      Result := Result + '              AND D.DET_CODEMP = :EMPDOC      ';
    If Not fEmptyStr(edtEspecie.Text) Then
      Result := Result + '              AND D.DET_ESPDOC = :ESPDOC      ';


    If Not fEmptyStr(edtForNot.Text) Then
      Result := Result + ' AND D.DET_CODFOR = :FORNOT ';
    Result := Result + '              AND IFNULL(DET_ORIDOC, "") = "" ';

  End;

  Result := Result + 'WHERE TRUE ';

  Result := Result + fStrLocateLinGru(mskLinGru, arrLinhaGrupo, 'ITE_CODGRU','CODGRU');

  If Not fEmptyStr(edtDesIte.Text) Then
  Begin
    Result := Result + ' AND I.ITE_DESITE LIKE :DESITE ';
  End;

  If Not fEmptyStr(edtRefere.Text) Then
  Begin
    Result := Result + ' AND I.ITE_REFERE LIKE :REFERE ';
  End;

  Result := Result + fStrLocate(edtCodUni , arrCodUni  , 'I.ITE_CODUNI', 'CODUNI');
  Result := Result + fStrLocate(edtCodMar , arrMarca   , 'I.ITE_CODMAR', 'CODMAR');
  Result := Result + fStrLocate(edtPrdGru , arrGrupoPro, 'I.ITE_PRDGRU', 'PRDGRU');
  Result := Result + fStrLocate(edtCodGpr , arrCodGpr  , 'I.ITE_CODGPR', 'CODGPR');
  Result := Result + fStrLocate(edtGruCmp , arrGruCmp  , 'I.ITE_GRUCMP', 'GRUCMP');
  Result := Result + fStrLocate(edtCodDep , arrCodDep  , 'I.ITE_CODDEP', 'CODDEP');

  If (Pos(edtIncPis.Text, 'SN') > 0) Then
    Result := Result + ' AND I.ITE_INCPIS = :INCPIS ';

  If Not fEmptyStr(edtCodFor.Text) Then
  Begin
    Result := Result + fStrLocate(edtCodFor, arrFornec, 'I.ITE_CODFOR', 'CODFOR');
  End;

  If fCfgSIs('TIPABF') = '1' Then
    Result := Result + fStrLocate(edtCodAbr , arrCodAbr , 'I.ITE_CODABF', 'CODABF')
  Else
    Result := Result + fStrLocate(edtCodAbr , arrCodAbr , 'G.ITE_CODABF', 'CODABF');

  If fCfgSIs('TPABPC') = '1' Then
    Result := Result + fStrLocate(edtAbfPis, arrAbfPis, 'I.ITE_ABFPIS', 'ABFPIS')
  Else
    Result := Result + fStrLocate(edtAbfPis, arrAbfPis, 'G.ITE_ABFPIS', 'ABFPIS');

  If fCfgSIs('TPABPC') = '1' Then
    Result := Result + fStrLocate(edtAbfCof, arrAbfCof, 'I.ITE_ABFCOF', 'ABFCOF')
  Else
    Result := Result + fStrLocate(edtAbfCof, arrAbfCof, 'G.ITE_ABFCOF', 'ABFCOF');


  If (Pos(edtStatus.Text, 'SN') > 0) Then
    Result := Result + '  AND I.ITE_ITEATI = :ITEATI ';

  If strEmpOrigem <> '' Then
  Begin
    Result := Result + '  AND G.ITE_CODEMP IN ('+ strEmpOrigem +')';
  End;

  If strEmpDestino <> '' Then
  Begin
    Result := Result + '  AND G.ITE_CODEMP IN ('+ strEmpDestino +')';
  End;


  Result := Result + ' GROUP BY G.ITE_CODITE, G.ITE_CODEMP ';


End;


procedure TfrmAlteracaoGeraldePrecosdeProdutos.pSetaQryItensEmpresa(AQuery: TuniQuery; strEmpOrigem: String = ''; strEmpDestino: String = '');
Begin
  With AQuery Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(fSetaSQL(strEmpOrigem, strEmpDestino));

    pSetaParam(mskLinGru.Text   , arrLinhaGrupo, strLinGru, 'CODGRU', AQuery);

    If Not fEmptyStr(edtDesIte.Text) Then
    Begin
      ParamByName('DESITE').AsString := edtDesIte.Text + '%';
    End;

    If Not fEmptyStr(edtRefere.Text) Then
    Begin
      ParamByName('REFERE').AsString := edtRefere.Text + '%';
    End;

    pSetaParam(edtCodUni.Text   , arrCodUni,     strCodUni, 'CODUNI', AQuery);
    pSetaParam(edtCodMar.Text   , arrMarca,      strMarca , 'CODMAR', AQuery);
    pSetaParam(edtPrdGru.Text   , arrGrupoPro,   strPrdGru, 'PRDGRU', AQuery);
    pSetaParam(edtCodDep.Text   , arrCodDep,     strCodDep, 'CODDEP', AQuery);
    pSetaParam(edtGruCmp.Text   , arrGruCmp,     strGruCmp, 'GRUCMP', AQuery);
    pSetaParam(edtCodGpr.Text   , arrCodGpr,     strCodGpr, 'CODGPR', AQuery);
    pSetaParam(edtAbfPis.Text   , arrAbfPis,     strAbfPis, 'ABFPIS', AQuery);
    pSetaParam(edtAbfCof.Text   , arrAbfCof,     strAbfCof, 'ABFCOF', AQuery);

    If (Pos(edtIncPis.Text, 'SN') > 0) Then
      ParamByName('INCPIS').AsString := edtIncPis.Text;


    If Not fEmptyStr(edtCodFor.Text) Then
    Begin
      pSetaParam(edtCodFor.Text   , arrFornec,     strFornec, 'CODFOR', AQuery);
    End;

    pSetaParam(edtCodAbr.Text   , arrCodAbr,     strCodAbr, 'CODABF', AQuery);


    If chkNotEnt.Checked Then
    Begin
      If (Not fEmptyStr(edtDocumento.Text)) Then
        ParamByName('NUMDOC').AsString := edtDocumento.Text
      Else
      Begin
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaEntIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaEntFin.Text);
      End;
      If Not fEmptyStr(edtSerie.Text) Then
        ParamByName('SERDOC').AsString := edtSerie.Text;
      If Not fEmptyStr(edtCodEmpresa.Text) Then
        ParamByName('EMPDOC').AsString := edtCodEmpresa.Text;
      If Not fEmptyStr(edtEspecie.Text) Then
        ParamByName('ESPDOC').AsString := edtEspecie.Text;
      If Not fEmptyStr(edtForNot.Text) Then
        ParamByName('FORNOT').AsString := edtForNot.Text;
    End;


    If (Pos(edtStatus.Text, 'SN') > 0) Then
      ParamByName('ITEATI').AsString := edtStatus.Text;

    Open;
    TFloatField(FieldByName('ITE_SALDOS')).DisplayFormat := '#,##0.000';

    pSetaClient(AQuery);
  End;
End;

end.



