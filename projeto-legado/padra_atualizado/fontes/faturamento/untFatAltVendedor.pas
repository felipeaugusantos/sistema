unit untFatAltVendedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, AppEvnts, Menus, Buttons,
  ExtCtrls, DB, Uni, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  UniClientDataSet, Vcl.Grids, DBGridCitel, DBGrids, Datasnap.DBClient,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxButtonEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFatAltVendedor = class(TfrmPai)
    pnlBusca: TPanel;
    Label5: TLabel;
    Label3: TLabel;
    edtCodEmp: TEditFocus;
    edtEspDoc: TEditFocus;
    edtDesEmp: TEditFocus;
    pnlDados: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    edtCodCli: TEditFocus;
    edtDtaFat: TEditFocus;
    edtConPag: TEditFocus;
    edtDesCli: TEditFocus;
    Label4: TLabel;
    lblVenAtu: TLabel;
    edtDesVen: TEditFocus;
    Label7: TLabel;
    edtValDoc: TEditFocus;
    edtDocum: TEditFocus;
    btnConfirma: TBitBtnLocked;
    edtCodVen: TEditFocus;
    lblRepAtu: TLabel;
    edtCodRep: TEditFocus;
    edtDesRep: TEditFocus;
    pnlVendedor: TPanel;
    lblVen: TLabel;
    edtCodNew: TEditFocus;
    edtDesNew: TEditFocus;
    rdgOpcAlt: TRadioGroup;
    pnlGrid: TPanel;
    dtsProdutos: TDataSource;
    cdsProdutos: TUniClientDataSet;
    cdsProdutosCODITE: TStringField;
    cdsProdutosDESCRI: TStringField;
    cdsProdutosUNIDAD: TStringField;
    cdsProdutosQTDITE: TFloatField;
    cdsProdutosUNITAR: TFloatField;
    cdsProdutosTOTITE: TFloatField;
    pnlTitulo: TPanel;
    lblTitulo: TLabel;
    cdsProdutosTABELA: TStringField;
    cdsProdutosAUTINC: TStringField;
    cdsProdutosCODVENATU: TStringField;
    cdsProdutosCODVE2ATU: TStringField;
    cdsProdutosCODREPATU: TStringField;
    cdsProdutosCODVEN: TStringField;
    cdsProdutosNOMVEN: TStringField;
    cxGridVendedores: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridVendedoresCodIte: TcxGridDBColumn;
    cxGridVendedoresDescri: TcxGridDBColumn;
    cxGridVendedoresUnidad: TcxGridDBColumn;
    cxGridVendedoresQtdIte: TcxGridDBColumn;
    cxGridVendedoresUnitar: TcxGridDBColumn;
    cxGridVendedoresTotIte: TcxGridDBColumn;
    cxGridVendedoresCodVenNovo: TcxGridDBColumn;
    cxGridVendedoresNomVenNovo: TcxGridDBColumn;
    cdsProdutosCODREP: TStringField;
    cdsProdutosCODVE2: TStringField;
    cdsProdutosNOMREP: TStringField;
    cdsProdutosNOMVE2: TStringField;
    cdsProdutosNOMVENATU: TStringField;
    cdsProdutosNOMREPATU: TStringField;
    cdsProdutosNOMVE2ATU: TStringField;
    cxGridVendedoresCodVenAtual: TcxGridDBColumn;
    cxGridVendedoresNomVenAtual: TcxGridDBColumn;
    cdsProdutosPEDORI: TStringField;
    cxGridVendedoresPedOri: TcxGridDBColumn;
    btnTrocaVendedor: TBitBtnLocked;
    lblVe2Atu: TLabel;
    edtDesVe2: TEditFocus;
    edtCodVe2: TEditFocus;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodNewKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure rdgOpcAltClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure cxGridVendedoresCodVenPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxGridVendedoresCodVenPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnTrocaVendedorClick(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
  private
    { Private declarations }

    strTabAlt,
    strAltAutInc: String;

    blnExbItens, blnAutoCenter, blnMaisDeUmVendedorPedido, blnUsarVendedor2: Boolean;

    procedure pLimpaTela;
    procedure pCarregaDados(qryDados: TUniQuery);
    procedure pAlteraVendedor(strNumDoc, strEspDoc, strCodEmp, strCodCli, strVenAtu, strCodNew, strOpcAlt: String);
    procedure pGeraLogAltVend(strNumDoc, strEspDoc, strCodEmp, strCodCli,
                              strVenAtu, strCodNew, strOpcAlt, strTabela, strAutInc: String);

    function fBuscaDocumento(strNumdoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
    function fPermiteAlterarVendedor: Boolean;
    function fGetCTPCom: String;

    procedure pBeforePost(DataSet: TDataSet);

    procedure pAtualizaVendedoresItens;
    procedure pCarregaGrid(qryDados: TUniQuery);
    procedure pGridValidaVendedor(strValue: String);
    function fInformouVendedor(var strCodVen:String): Boolean;
    function fTeveVendedorItensModificado: Boolean;
    procedure pTrocaVendedor(strCodVen: String);
    function fRetornaCaption: String;
    procedure pPreencheTiposDocumentos(strEspDoc: String);
    procedure pTrocarVendedor2TodosItens(strCodVen: String);
  public
    { Public declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
    procedure pEscapePressed; Override;

  end;

const
  IDX_VEN = 0;
  IDX_REP = 1;
  IDX_VE2 = 2;

implementation

uses StrUtils, untFuncoesSimples, untConsultas, untMemo, untTypesSistema,
  untDigPortador;

{$R *.dfm}

procedure TfrmFatAltVendedor.edtCodCliExit(Sender: TObject);
begin
  inherited;

  rdgOpcAltClick(Sender);
  pSetFocus(edtCodNew);
  blnMudarFoco:=False;
end;

procedure TfrmFatAltVendedor.edtCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCli: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrCli) Then
  Begin
    If fValidaCampos(edtCodCli) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatAltVendedor.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatAltVendedor.edtCodNewKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, edtCodNew, edtDesNew, qryTabela, Key, arrSel) then  
  Begin
    If fValidaCampos(edtCodNew, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFatAltVendedor.fBuscaDocumento(strNumdoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
  Var
    qryGen : TUniQuery;
    strSql,
    strSQLMovGer,
    strSQLNotGer,
    strSQLMovDet,
    strSQLNotDet,
    strSQLFatGor : String;
begin
  pPreencheTiposDocumentos(strEspDoc);
  If (strEspDoc='PD') Then
  Begin
    strSQLFatGor := '';

    If (Not blnExbItens) Then
    Begin
      strSQLFatGor := strSQLFatGor + '  SELECT SQL_NO_CACHE                          ';
      strSQLFatGor := strSQLFatGor + '    "FATGOR" AS TABGER,                        ';
      strSQLFatGor := strSQLFatGor + '    FATGOR.AUTOINCREM AS AUTGER,               ';
      strSQLFatGor := strSQLFatGor + '    FGO_CODCLI AS CODCLI,                      ';
      strSQLFatGor := strSQLFatGor + '    CLI_NOMCLI AS NOMCLI,                      ';
      strSQLFatGor := strSQLFatGor + '    ""         AS CODREP,                      ';
      strSQLFatGor := strSQLFatGor + '    FGO_DTAENT AS DTAENT,                      ';
      strSQLFatGor := strSQLFatGor + '    FGO_VLRCON AS VLRCON,                      ';
      strSQLFatGor := strSQLFatGor + '    FGO_VLRCON AS VALDOC,                      ';
      strSQLFatGor := strSQLFatGor + '    FGO_CONPAG AS CONPAG,                      ';
      strSQLFatGor := strSQLFatGor + '    FGO_CODVEN AS CODVEN,                      ';
      strSQLFatGor := strSQLFatGor + '    OPE_NOMOPE AS NOMVEN,                      ';
      strSQLFatGor := strSQLFatGor + '    ""         AS NOMREP                       ';
      strSQLFatGor := strSQLFatGor + '  FROM                                         ';
      strSQLFatGor := strSQLFatGor + '    FATGOR                                     ';
      strSQLFatGor := strSQLFatGor + '    LEFT JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI';
      strSQLFatGor := strSQLFatGor + '    LEFT JOIN CADOPE ON OPE_CODOPE = FGO_CODVEN';
      strSQLFatGor := strSQLFatGor + '  WHERE                                        ';
      strSQLFatGor := strSQLFatGor + '    FGO_NUMDOC = :NUMDOC AND                   ';
      strSQLFatGor := strSQLFatGor + '    FGO_ESPDOC = :ESPDOC AND                   ';
      strSQLFatGor := strSQLFatGor + '    FGO_CODEMP = :CODEMP AND                   ';
      strSQLFatGor := strSQLFatGor + '    FGO_CODCLI = :CODCLI                       ';
    End
    Else
    Begin
      strSQLFatGor := strSQLFatGor + '  SELECT SQL_NO_CACHE                                      ';
      strSQLFatGor := strSQLFatGor + '    "FATGOR" AS TABGER,                                    ';
      strSQLFatGor := strSQLFatGor + '    FATGOR.AUTOINCREM AS AUTGER,                           ';
      strSQLFatGor := strSQLFatGor + '    "FATDOR" AS TABDET,                                    ';
      strSQLFatGor := strSQLFatGor + '    FATDOR.AUTOINCREM AS AUTDET,                           ';
      strSQLFatGor := strSQLFatGor + '    FDO_CODITE AS CODITE,                                  ';
      strSQLFatGor := strSQLFatGor + '    FDO_DESCRI AS DESCRI,                                  ';
      strSQLFatGor := strSQLFatGor + '    UNI_DESUNI AS UNIDAD,                                  ';
      strSQLFatGor := strSQLFatGor + '    FDO_QTDITE AS QTDITE,                                  ';
      strSQLFatGor := strSQLFatGor + '    FDO_UNITAR AS UNITAR,                                  ';
      strSQLFatGor := strSQLFatGor + '    (FDO_TOTITE - FDO_DESESP) AS TOTITE,                   ';
      strSQLFatGor := strSQLFatGor + '    FDO_CODCLI AS CODCLI,                                  ';
      strSQLFatGor := strSQLFatGor + '    CLI_NOMCLI AS NOMCLI,                                  ';
      strSQLFatGor := strSQLFatGor + '    FDO_DTAENT AS DTAENT,                                  ';
      strSQLFatGor := strSQLFatGor + '    FGO_VLRCON AS VLRCON,                                  ';
      strSQLFatGor := strSQLFatGor + '    FDO_VLRCON AS VALDOC,                                  ';
      strSQLFatGor := strSQLFatGor + '    FDO_CONPAG AS CONPAG,                                  ';
      strSQLFatGor := strSQLFatGor + '     "" AS PEDORI,                                         ';
      strSQLFatGor := strSQLFatGor + '    FGO_CODVEN AS CODVEN,                                  ';
      strSQLFatGor := strSQLFatGor + '    V1.OPE_NOMOPE AS NOMVEN,                               ';
      strSQLFatGor := strSQLFatGor + '    "" AS CODRE1,                                          ';
      strSQLFatGor := strSQLFatGor + '    "" AS NOMRE1,                                          ';
      strSQLFatGor := strSQLFatGor + '    FDO_CODVEN AS CODVE1,                                  ';
      strSQLFatGor := strSQLFatGor + '    V2.OPE_NOMOPE AS NOMVE1,                               ';
      strSQLFatGor := strSQLFatGor + '    FDO_CODVE2 AS CODVE2,                                  ';
      strSQLFatGor := strSQLFatGor + '    V3.OPE_NOMOPE AS NOMVE2,                               ';
      strSQLFatGor := strSQLFatGor + '    "" AS CODREP,                                          ';
      strSQLFatGor := strSQLFatGor + '    "" AS NOMREP                                           ';
      strSQLFatGor := strSQLFatGor + '  FROM                                                     ';
      strSQLFatGor := strSQLFatGor + '    FATDOR                                                 ';
      strSQLFatGor := strSQLFatGor + '    JOIN FATGOR ON (FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER) ';
      strSQLFatGor := strSQLFatGor + '    LEFT JOIN CADUNI    ON FDO_UNIDAD = UNI_CODUNI         ';
      strSQLFatGor := strSQLFatGor + '    LEFT JOIN CADCLI    ON CLI_CODCLI = FDO_CODCLI         ';
      strSQLFatGor := strSQLFatGor + '    LEFT JOIN CADOPE V1 ON V1.OPE_CODOPE = FGO_CODVEN      ';
      strSQLFatGor := strSQLFatGor + '    LEFT JOIN CADOPE V2 ON V2.OPE_CODOPE = FDO_CODVEN      ';
      strSQLFatGor := strSQLFatGor + '    LEFT JOIN CADOPE V3 ON V3.OPE_CODOPE = FDO_CODVE2      ';
      strSQLFatGor := strSQLFatGor + '  WHERE                                                    ';
      strSQLFatGor := strSQLFatGor + '    FDO_NUMDOC = :NUMDOC AND                               ';
      strSQLFatGor := strSQLFatGor + '    FDO_ESPDOC = :ESPDOC AND                               ';
      strSQLFatGor := strSQLFatGor + '    FDO_CODEMP = :CODEMP AND                               ';
      strSQLFatGor := strSQLFatGor + '    FDO_CODCLI = :CODCLI                                   ';
    End;

    strSql := strSQLFatGor;

  End
  Else // Se não for PD (Outros documentos de vendas)
  Begin
    If Not blnExbItens Then
    Begin
      strSQLMovGer := '';
      strSQLMovGer := strSQLMovGer + '  SELECT SQL_NO_CACHE                           ';
      strSQLMovGer := strSQLMovGer + '    "MOVGER" AS TABGER,                         ';
      strSQLMovGer := strSQLMovGer + '    MOVGER.AUTOINCREM AS AUTGER,                ';
      strSQLMovGer := strSQLMovGer + '    GER_CODCLI AS CODCLI,                       ';
      strSQLMovGer := strSQLMovGer + '    CLI_NOMCLI AS NOMCLI,                       ';
      strSQLMovGer := strSQLMovGer + '    GER_CODREP AS CODREP,                       ';
      strSQLMovGer := strSQLMovGer + '    GER_DTAENT AS DTAENT,                       ';
      strSQLMovGer := strSQLMovGer + '    GER_VLRCON AS VALDOC,                       ';
      strSQLMovGer := strSQLMovGer + '    GER_VLRCON AS VLRCON,                       ';
      strSQLMovGer := strSQLMovGer + '    GER_CONPAG AS CONPAG,                       ';
      strSQLMovGer := strSQLMovGer + '    GER_CODVEN AS CODVEN,                       ';
      strSQLMovGer := strSQLMovGer + '    OPE_NOMOPE AS NOMVEN,                       ';
      strSQLMovGer := strSQLMovGer + '    (SELECT OPE_NOMOPE                          ';
      strSQLMovGer := strSQLMovGer + '     FROM                                       ';
      strSQLMovGer := strSQLMovGer + '       CADOPE                                   ';
      strSQLMovGer := strSQLMovGer + '     WHERE OPE_CODOPE = GER_CODREP) AS NOMREP   ';
      strSQLMovGer := strSQLMovGer + '  FROM                                          ';
      strSQLMovGer := strSQLMovGer + '    MOVGER                                      ';
      strSQLMovGer := strSQLMovGer + '    LEFT JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ';
      strSQLMovGer := strSQLMovGer + '    LEFT JOIN CADOPE ON OPE_CODOPE = GER_CODVEN ';
      strSQLMovGer := strSQLMovGer + '  WHERE                                         ';
      strSQLMovGer := strSQLMovGer + '    GER_NUMDOC =:NUMDOC AND                     ';
      strSQLMovGer := strSQLMovGer + '    GER_ESPDOC =:ESPDOC AND                     ';
      strSQLMovGer := strSQLMovGer + '    GER_CODEMP =:CODEMP AND                     ';
      strSQLMovGer := strSQLMovGer + '    GER_CODCLI =:CODCLI AND                     ';
      strSQLMovGer := strSQLMovGer + '    GER_ORIDOC = "V" AND                        ';
      strSQLMovGer := strSQLMovGer + '    GER_TIP_FC = "C"                            ';

      strSQLNotGer := AnsiReplaceStr(strSQLMovGer, 'MOVGER', 'NOTGER');

      strSQLNotGer := AnsiReplaceStr(strSQLNotGer, 'GER_CODREP', '""');
      strSql := strSQLMovGer + ' UNION ALL ' + strSQLNotGer;
    End
    Else
    Begin
      strSQLMovDet := '';
      strSQLMovDet := strSQLMovDet + '  SELECT SQL_NO_CACHE                           ';
      strSQLMovDet := strSQLMovDet + '    "MOVGER" AS TABGER,                         ';
      strSQLMovDet := strSQLMovDet + '    MOVGER.AUTOINCREM AS AUTGER,                ';
      strSQLMovDet := strSQLMovDet + '    "MOVDET" AS TABDET,                         ';
      strSQLMovDet := strSQLMovDet + '    MOVDET.AUTOINCREM AS AUTDET,                ';
      strSQLMovDet := strSQLMovDet + '    DET_CODITE AS CODITE,                       ';
      strSQLMovDet := strSQLMovDet + '    DET_DESCRI AS DESCRI,                       ';
      strSQLMovDet := strSQLMovDet + '    UNI_DESUNI AS UNIDAD,                       ';
      strSQLMovDet := strSQLMovDet + '    DET_QTDITE AS QTDITE,                       ';
      strSQLMovDet := strSQLMovDet + '    DET_UNITAR AS UNITAR,                       ';
      strSQLMovDet := strSQLMovDet + '   (DET_TOTITE - DET_DESESP) AS TOTITE,         ';
      strSQLMovDet := strSQLMovDet + '    DET_CODCLI AS CODCLI,                       ';
      strSQLMovDet := strSQLMovDet + '    CLI_NOMCLI AS NOMCLI,                       ';
      strSQLMovDet := strSQLMovDet + '    DET_DTAENT AS DTAENT,                       ';
      strSQLMovDet := strSQLMovDet + '    GER_VLRCON AS VLRCON,                       ';
      strSQLMovDet := strSQLMovDet + '    DET_VLRCON AS VALDOC,                       ';
      strSQLMovDet := strSQLMovDet + '    DET_CONPAG AS CONPAG,                       ';
      strSQLMovDet := strSQLMovDet + '    CONCAT(DET_NUM_PD,"-",                      ';
      strSQLMovDet := strSQLMovDet + '           DET_ESP_PD,"-",                      ';
      strSQLMovDet := strSQLMovDet + '           DET_EMP_PD) AS PEDORI,               ';

      {**************************************}
      {* CAMPOS QUE SERÃO ALTERADOS DO GRID *}
      {***********************************FC*}
      strSQLMovDet := strSQLMovDet + '    DET_CODVEN AS CODVE1,                       ';
      strSQLMovDet := strSQLMovDet + '    V1.OPE_NOMOPE AS NOMVE1,                    ';
      strSQLMovDet := strSQLMovDet + '    DET_CODREP AS CODRE1,                       ';
      strSQLMovDet := strSQLMovDet + '    R1.OPE_NOMOPE AS NOMRE1,                    ';
      strSQLMovDet := strSQLMovDet + '    DET_CODVE2 AS CODVE2,                       ';
      strSQLMovDet := strSQLMovDet + '    V2.OPE_NOMOPE AS NOMVE2,                    ';

      strSQLMovDet := strSQLMovDet + '    GER_CODVEN AS CODVEN,                       ';
      strSQLMovDet := strSQLMovDet + '    G1.OPE_NOMOPE AS NOMVEN,                    ';
      strSQLMovDet := strSQLMovDet + '    GER_CODREP AS CODREP,                       ';
      strSQLMovDet := strSQLMovDet + '    (SELECT OPE_NOMOPE                          ';
      strSQLMovDet := strSQLMovDet + '     FROM                                       ';
      strSQLMovDet := strSQLMovDet + '       CADOPE                                   ';
      strSQLMovDet := strSQLMovDet + '     WHERE OPE_CODOPE = GER_CODREP) AS NOMREP   ';
      strSQLMovDet := strSQLMovDet + '  FROM                                          ';
      strSQLMovDet := strSQLMovDet + '    MOVDET                                      ';
      strSQLMovDet := strSQLMovDet + '    JOIN MOVGER ON (MOVGER.AUTOINCREM = MOVDET.DET_SEQGER) ';
      strSQLMovDet := strSQLMovDet + '    LEFT JOIN CADUNI ON DET_UNIDAD = UNI_CODUNI ';
      strSQLMovDet := strSQLMovDet + '    LEFT JOIN CADCLI    ON CLI_CODCLI = DET_CODCLI ';
      strSQLMovDet := strSQLMovDet + '    LEFT JOIN CADOPE V1 ON V1.OPE_CODOPE = DET_CODVEN ';
      strSQLMovDet := strSQLMovDet + '    LEFT JOIN CADOPE V2 ON V2.OPE_CODOPE = DET_CODVE2 ';
      strSQLMovDet := strSQLMovDet + '    LEFT JOIN CADOPE R1 ON R1.OPE_CODOPE = DET_CODREP ';
      strSQLMovDet := strSQLMovDet + '    LEFT JOIN CADOPE G1 ON G1.OPE_CODOPE = GER_CODVEN ';
      strSQLMovDet := strSQLMovDet + '  WHERE                                         ';
      strSQLMovDet := strSQLMovDet + '    DET_NUMDOC =:NUMDOC AND                     ';
      strSQLMovDet := strSQLMovDet + '    DET_ESPDOC =:ESPDOC AND                     ';
      strSQLMovDet := strSQLMovDet + '    DET_CODEMP =:CODEMP AND                     ';
      strSQLMovDet := strSQLMovDet + '    DET_CODCLI =:CODCLI AND                     ';
      strSQLMovDet := strSQLMovDet + '    DET_ORIDOC = "V" AND                        ';
      strSQLMovDet := strSQLMovDet + '    DET_TIP_FC = "C"                            ';

      strSQLNotDet := AnsiReplaceStr(AnsiReplaceStr(strSQLMovDet, 'MOVDET', 'NOTDET'), 'MOVGER', 'NOTGER');

      strSQLNotDet := AnsiReplaceStr(strSQLNotDet, 'GER_CODREP', '""');
      strSql := strSQLMovDet + ' UNION ALL ' + strSQLNotDet;
    End;
  End;

  qryGen := fCriaQuery(Nil);

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := strNumdoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;

    Open;

    If IsEmpty Then
      Result := False
    Else
    Begin
      pCarregaDados(qryGen);
      Result := True;
    End;

  End;

  FreeAndNil(qryGen);
end;

function TfrmFatAltVendedor.fGetCTPCom: String;
  Var
    qryCTPCom: TUniQuery;
begin
  qryCTPCom := fCriaQuery;

  Try
    qryCTPCom.SQL.Add('SELECT');
    qryCTPCom.SQL.Add('  CTR_CTPCOM');
    qryCTPCom.SQL.Add('FROM');
    qryCTPCom.SQL.Add('  CADREC');
    qryCTPCom.SQL.Add('WHERE');
    qryCTPCom.SQL.Add('  CTR_CODEMP = :CODEMP AND');
    qryCTPCom.SQL.Add('  CTR_NUMDUP = :NUMDUP AND');
    qryCTPCom.SQL.Add('  CTR_ESPDOC = :ESPDOC AND');
    qryCTPCom.SQL.Add('  CTR_CODCLI = :CODCLI');
    qryCTPCom.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    qryCTPCom.ParamByName('NUMDUP').AsString := edtDocum.Text;
    qryCTPCom.ParamByName('ESPDOC').AsString := edtEspDoc.Text;
    qryCTPCom.ParamByName('CODCLI').AsString := edtCodCli.Text;
    qryCTPCom.Open;

    Result := qryCTPCom.Fields[0].AsString;
  Finally
    FreeAndNil(qryCTPCom);
  End;
end;

procedure TfrmFatAltVendedor.pCarregaDados(qryDados: TUniQuery);
begin
  edtCodVe2.Clear;
  edtDesVe2.Clear;

  edtCodRep.Clear;
  edtDesRep.Clear;

  With qryDados Do
  Begin
    cdsProdutos.EmptyDataSet;

    edtDtaFat.Text := FormatDateTime('DD/MM/YYYY', FieldByName('DTAENT').AsDateTime);
    edtConPag.Text := fFormataCondPag(FieldByName('CONPAG').AsString);

    edtValDoc.Text := FormatFloat('##,#0.00', FieldByName('VLRCON').AsFloat);
    edtCodVen.Text := FieldByName('CODVEN').AsString ;
    edtDesVen.Text := FieldByName('NOMVEN').AsString;

    if Assigned(FindField('CODVE2')) then
      edtCodVe2.Text := FieldByName('CODVE2').AsString;
    if Assigned(FindField('NOMVE2')) then
      edtDesVe2.Text := FieldByName('NOMVE2').AsString;

    if Assigned(FindField('CODREP')) then
      edtCodRep.Text := FieldByName('CODREP').AsString;
    if Assigned(FindField('NOMREP')) then
      edtDesRep.Text := FieldByName('NOMREP').AsString;

    If (rdgOpcAlt.ItemIndex <> IDX_VE2) Then
    Begin
      strTabAlt      := FieldByName('TABGER').AsString;
      strAltAutInc   := FieldByName('AUTGER').AsString;
    End
    Else
    Begin
      strTabAlt      := FieldByName('TABDET').AsString;
      strAltAutInc   := FieldByName('AUTDET').AsString;
    End;

    If blnExbItens Then
      pCarregaGrid(qryDados);

    btnConfirma.Enabled      := True;
    btnTrocaVendedor.Enabled := True;
    pnlBusca.Enabled         := False;
  End;
end;

procedure TfrmFatAltVendedor.pCarregaGrid(qryDados: TUniQuery);
begin
  With qryDados Do
  Begin
    If Not IsEmpty Then
    Begin
      cdsProdutos.BeforePost := Nil;

      First;

      While Not Eof Do
      Begin
        cdsProdutos.Append;
        cdsProdutos.FieldByName('CODITE').AsString    := FieldByName('CODITE').AsString;
        cdsProdutos.FieldByName('DESCRI').AsString    := FieldByName('DESCRI').AsString;
        cdsProdutos.FieldByName('UNIDAD').AsString    := FieldByName('UNIDAD').AsString;
        cdsProdutos.FieldByName('QTDITE').AsFloat     := FieldByName('QTDITE').AsFloat;
        cdsProdutos.FieldByName('UNITAR').AsFloat     := FieldByName('UNITAR').AsFloat;
        cdsProdutos.FieldByName('TOTITE').AsFloat     := FieldByName('TOTITE').AsFloat;

        cdsProdutos.FieldByName('TABELA').AsString    := FieldByName('TABDET').AsString;
        cdsProdutos.FieldByName('AUTINC').AsString    := FieldByName('AUTDET').AsString;

        cdsProdutos.FieldByName('PEDORI').AsString    := FieldByName('PEDORI').AsString;

        cdsProdutos.FieldByName('CODVEN').AsString    := FieldByName('CODVE1').AsString;
        cdsProdutos.FieldByName('CODVE2').AsString    := FieldByName('CODVE2').AsString;
        cdsProdutos.FieldByName('CODREP').AsString    := FieldByName('CODRE1').AsString;

        cdsProdutos.FieldByName('CODVENATU').AsString := FieldByName('CODVE1').AsString;
        cdsProdutos.FieldByName('CODVE2ATU').AsString := FieldByName('CODVE2').AsString;
        cdsProdutos.FieldByName('CODREPATU').AsString := FieldByName('CODRE1').AsString;

        cdsProdutos.FieldByName('NOMVEN').AsString  := fRetNomVendRep(FieldByName('CODVE1').AsString);
        cdsProdutos.FieldByName('NOMREP').AsString  := fRetNomVendRep(FieldByName('CODRE1').AsString);
        cdsProdutos.FieldByName('NOMVE2').AsString  := fRetNomVendRep(FieldByName('CODVE2').AsString);

        cdsProdutos.FieldByName('NOMVENATU').AsString  := cdsProdutos.FieldByName('NOMVEN').AsString;
        cdsProdutos.FieldByName('NOMREPATU').AsString  := cdsProdutos.FieldByName('NOMREP').AsString;
        cdsProdutos.FieldByName('NOMVE2ATU').AsString  := cdsProdutos.FieldByName('NOMVE2').AsString;

        cdsProdutos.Post;

        Next;
      End;

      cdsProdutos.First;
      cdsProdutos.BeforePost := pBeforePost;
    End;
  End;
end;

procedure TfrmFatAltVendedor.pLimpaTela;
  Var
    intIdx: Integer;
begin
  For intIdx := 0 To Self.ComponentCount - 1 Do
  Begin
    If Self.Components[intIdx] Is TEditFocus Then
      (Self.Components[intIdx] As TEditFocus).Clear;
  End;

  strTabAlt    := '';
  strAltAutInc := '';
  cdsProdutos.EmptyDataSet;

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;
  
  btnConfirma.Enabled      := False;
  btnTrocaVendedor.Enabled := False;
  pnlBusca.Enabled         := True;

  pSetFocus(edtDocum);
end;

procedure TfrmFatAltVendedor.pPreencheTiposDocumentos(strEspDoc: String);
begin
  TRadioButton(rdgOpcAlt.Controls[IDX_REP]).Visible := (strEspDoc <> 'PD');
  TRadioButton(rdgOpcAlt.Controls[IDX_VE2]).Visible := blnExbItens;
  rdgOpcAlt.ItemIndex := 0;
end;

function TfrmFatAltVendedor.fPermiteAlterarVendedor: Boolean;
  Var
    strCTPCom, strNumDup, strFornec, strDtaCad, strDtaVen, strValDup: String;
    qryDup: TUniQuery;
begin
  Result := False;

  strCTPCom := fGetCTPCom;

  If Not fEmptyStr(strCTPCom) Then
  Begin
    qryDup := fCriaQueryCadPagCTPCom(strCTPCom);

    Try
      strNumDup := qryDup.FieldByName('CTP_NUMDUP').AsString;
      strFornec := qryDup.FieldByName('FORNECEDOR').AsString;
      strDtaCad := FormatDateTime('dd/mm/yyyy', qryDup.FieldByName('CTP_DTACAD').AsDateTime);
      strDtaVen := FormatDateTime('dd/mm/yyyy', qryDup.FieldByName('CTP_DTAVEN').AsDateTime);
      strValDup := FormatFloat('#,##0.00', qryDup.FieldByName('CTP_VALDUP').AsFloat);

      TfrmMemo.pShowMessage('Este documento não pode ter seu vendedor alterado porque deu origem ao contas a pagar referente a comissão de vendedores.' + #13#10 +
                            'Duplicata: '+ strNumDup +'-A - Fornecedor: '+ strFornec + #13#10 +
                            'Data Cadastro: '+ strDtaCad +' - Data Vencimento:'+ strDtaVen +' - Valor: '+ strValDup + #13#10 +
                            'Primeiro deve ser estornado e cancelado esta conta a pagar para permitir alteração do vendedor deste documento.');
    Finally
      FreeAndNil(qryDup);
    End;

    Exit;
  End;

  Result := True;
end;

function TfrmFatAltVendedor.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    strCodAtu,
    strCodNew: String;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtDocum) Then
    Begin
      If fEmptyStr(edtDocum.Text) Then
      Begin
        fMensagem('','Digite o número do documento !',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtEspDoc) Then
    Begin
      If fEmptyStr(edtEspDoc.Text) Then
      Begin
        fMensagem('','Digite a espécie do documento !',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('','Digite o código da empresa !',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
        If fEmptyStr(edtDesEmp.Text) Then
        Begin
          fMensagem('','Empresa digitada não foi encontrada, verifique !',['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodCli) Then
    Begin
      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('','Digite o código do cliente !',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtDesCli.Text := fRetNomCliente(edtCodCli.Text);
        If fEmptyStr(edtDesCli.Text) Then
        Begin
          fMensagem('','Cliente digitado não foi encontrado, verifique !',['&O K']);
          Result := False;
        End
        Else If blnBuscaPorChave And (Not fBuscaDocumento(edtDocum.Text, edtEspDoc.Text, edtCodEmp.Text, edtCodCli.Text)) Then
        Begin
          fMensagem('','Documento digitado não foi encontrado, verifique !',['&O K']);
          Sender := edtDocum;
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodNew) Then
    Begin
      Begin
        Case rdgOpcAlt.ItemIndex Of
          IDX_VEN: strCodAtu := AnsiLeftStr(edtCodVen.Text, 3);
          IDX_REP: strCodAtu := AnsiLeftStr(edtCodRep.Text, 3);
          IDX_VE2: strCodAtu := AnsiLeftStr(edtCodVe2.Text, 3);
        End;

        strCodNew := edtCodNew.Text;

        If (Not blnExbItens And fEmptyStr(strCodNew)) Or (blnExbItens And fEmptyStr(strCodNew) And (Not fTeveVendedorItensModificado)) Then
        Begin
          If blnExbItens Then
            fMensagem('','Digite o código do '+fRetornaCaption+' do documento ou altere o '+fRetornaCaption+' de pelo menos um item !',['&O K'])
          Else
            fMensagem('','Digite o código do '+fRetornaCaption+' !',['&O K']);
          Result := False;
        End
        Else
        Begin
          edtDesNew.Text := fRetNomVendRep(strCodNew);
          If (Not blnExbItens And fEmptyStr(edtDesNew.Text)) Or (blnExbItens And fEmptyStr(edtDesNew.Text) And (Not fTeveVendedorItensModificado)) Then
          Begin
           fMensagem('',fRetornaCaption+' digitado não foi encontrado, verifique !',['&O K']);
           Result := False;
          End
          Else If strCodAtu = edtCodNew.Text Then
          Begin
            fMensagem('',fRetornaCaption+' digitado é o mesmo vendedor do documento !',['&O K']);
            Result := False;
          End;
        End;

        // verificação para alterar o vendedor2 de todos os itens automaticamente, quando não permite mais de 1 vendedor na venda
        if Result and blnExbItens then
        begin
          if (not blnAutoCenter) and (not blnMaisDeUmVendedorPedido) then
            pTrocarVendedor2TodosItens(edtCodNew.Text);
        end;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatAltVendedor.FormCreate(Sender: TObject);
begin
  inherited;
  cdsProdutos.BeforePost  := pBeforePost;
end;

procedure TfrmFatAltVendedor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) And ((ActiveControl) is TRadioButton) Then
    SelectNext(ActiveControl, True, True)
  Else If (Key = VK_ESCAPE) And ((ActiveControl) is TRadioButton) Then
    pEscapePressed;
end;

procedure TfrmFatAltVendedor.FormShow(Sender: TObject);
begin
  inherited;
  edtDocum.TamCampo  := fTamDocCadRec;
  edtDocum.MaxLength := fTamDocCadRec;

  pSetaCodIte(cdsProdutosCODITE);
  cdsProdutos.CreateDataSet;
  pLimpaTela;

  blnAutoCenter := fCfgSis('AUTCEN', VarBoolean);
  blnMaisDeUmVendedorPedido := fCfgSis('VNDSPD', varString) = 'S';
  blnUsarVendedor2 := fCfgSis('REPVEN', VarBoolean);
  blnExbItens := blnAutoCenter or blnMaisDeUmVendedorPedido or blnUsarVendedor2;

  If blnExbItens Then
    cxGridVendedores.OptionsData.Editing := blnAutoCenter or blnMaisDeUmVendedorPedido
  else
    Self.Height := Self.Height - pnlGrid.Height;

  pnlGrid.Visible := blnExbItens;
  btnTrocaVendedor.Visible := blnAutoCenter or blnMaisDeUmVendedorPedido;

  lblVe2Atu.Visible := blnExbItens;
  edtCodVe2.Visible := blnExbItens;
  edtDesVe2.Visible := blnExbItens;
  if not blnExbItens then
    Self.Height := Self.Height - lblVe2Atu.Height - edtCodVe2.Height;
end;

procedure TfrmFatAltVendedor.btnConfirmaClick(Sender: TObject);
Var
  strVenRep: String;
  strOpcAlt: String;
begin
  inherited;
  case rdgOpcAlt.ItemIndex of
    IDX_VEN: strVenRep := 'Vendedor';
    IDX_REP: strVenRep := 'Representante';
    IDX_VE2: strVenRep := 'Vendedor 2';
  end;

  If fMensagem('','Confirma alteração de ' + strVenRep + ' ?', ['','']) = 2 Then
    Exit;

  If Not fVerificaCampos Then
    Exit
  Else
  Begin
    Try
      If cdsProdutos.State In [dsEdit] Then
        cdsProdutos.Post;
    Except
      Exit;
    End;

    {*******************************************************************}
    {**CONTROLA A OPÇÃO DE ALTERAÇÃO, SE FOR ZERO = ALTERAÇÃO VENDEDOR  }
    {**SENAO = ALTERAÇÃO REPRESENTANTE                                  }
    {*****************************************************************PZ}
    case rdgOpcAlt.ItemIndex of
      IDX_VEN: strOpcAlt := 'V';
      IDX_REP: strOpcAlt := 'R';
      IDX_VE2: strOpcAlt := 'V2';
    end;

    If fPermiteAlterarVendedor Then
    Begin
      If Not fEmptyStr(edtCodNew.Text) Then
      Begin
        pAlteraVendedor(edtDocum.Text,
                        edtEspDoc.Text,
                        edtCodEmp.Text,
                        edtCodCli.Text,
                        Copy(edtCodVen.Text, 0, 3),
                        edtCodNew.Text,
                        strOpcAlt);

        pGeraLogAltVend(edtDocum.Text,
                        edtEspDoc.Text,
                        edtCodEmp.Text,
                        edtCodCli.Text,
                        Copy(edtCodVen.Text, 0, 3),
                        edtCodNew.Text,
                        strOpcAlt,
                        strTabAlt,
                        strAltAutInc);
      End;

      If blnExbItens Then
        pAtualizaVendedoresItens;

      pLimpaTela;
    End;
  End;
end;

procedure TfrmFatAltVendedor.pAlteraVendedor(strNumDoc, strEspDoc, strCodEmp, strCodCli, strVenAtu, strCodNew, strOpcAlt: String);
  Var
     strSqlMovGer,
     strSqlNotGer,
     strSqlMovDet,
     strSqlNotDet,
     strSqlCadRec,
     strSqlFatGor,
     strSqlFatDor,
     strSqlCtrCnf,
     strSqlDupAgr : String;
     strSqlMOVTRI : String;
     strSqlNOTTRI : String;
     QryUpdate    : TUniQuery;

     procedure pGetParam(qryParam: TUniQuery);
     Begin
       Try
         qryParam.ParamByName('CODNEW').AsString := strCodNew;
         qryParam.ParamByName('NUMDOC').AsString := strNumDoc;
         qryParam.ParamByName('ESPDOC').AsString := strEspDoc;
         qryParam.ParamByName('CODEMP').AsString := strCodEmp;
         qryParam.ParamByName('CODCLI').AsString := strCodCli;
       Except
         //
       End;
     End;

begin
  If (strEspDoc='PD') Then
  Begin
    strSqlFatGor := '';
    strSqlFatGor := strSqlFatGor + '   UPDATE                     ';
    strSqlFatGor := strSqlFatGor + '     TABELA                   ';
    strSqlFatGor := strSqlFatGor + '   SET                        ';

    If (strOpcAlt = 'V') Then
      strSqlFatGor := strSqlFatGor + '     FGO_CODVEN =:CODNEW    '
    Else If (strOpcAlt = 'V2') Then
      strSqlFatGor := strSqlFatGor + '     FDO_CODVE2 =:CODNEW    ';

    strSqlFatGor := strSqlFatGor + '   WHERE                      ';
    strSqlFatGor := strSqlFatGor + '     FGO_NUMDOC =:NUMDOC AND  ';
    strSqlFatGor := strSqlFatGor + '     FGO_ESPDOC =:ESPDOC AND  ';
    strSqlFatGor := strSqlFatGor + '     FGO_CODEMP =:CODEMP AND  ';
    strSqlFatGor := strSqlFatGor + '     FGO_CODCLI =:CODCLI      ';

    strSqlFatDor := AnsiReplaceStr(strSqlFatGor, 'FGO_', 'FDO_');

    QryUpdate := fCriaQuery(Nil);

    strSqlFatGor := AnsiReplaceStr(strSqlFatGor,'TABELA','FATGOR');
    strSqlFatDor := AnsiReplaceStr(strSqlFatDor,'TABELA','FATDOR');

    If (strOpcAlt = 'V') Then
    Begin
      QryUpdate.SQL.Clear;
      QryUpdate.SQL.Add(strSqlFatGor);
      pGetParam(QryUpdate);
      QryUpdate.ExecSQL;

      If (not blnExbItens) Then
      Begin
        QryUpdate.SQL.Clear;
        QryUpdate.SQL.Add(strSqlFatDor);
        pGetParam(QryUpdate);
        QryUpdate.ExecSQL;
      End;

    End
    Else If (strOpcAlt = 'V2') Then
    Begin
      QryUpdate.SQL.Clear;
      QryUpdate.SQL.Add(strSqlFatDor);
      pGetParam(QryUpdate);
      QryUpdate.ExecSQL;
    End;
  End
  Else
  Begin
    strSqlMovGer := '';
    strSqlMovGer := strSqlMovGer + '   UPDATE                     ';
    strSqlMovGer := strSqlMovGer + '     TABELA                   ';
    strSqlMovGer := strSqlMovGer + '   SET                        ';
    {*****************************************}
    { SE FOR V = VENDEDOR SENÃO REPRESENTANTE*}
    {***************************************PZ}
    If (strOpcAlt = 'V') Then
      strSqlMovGer := strSqlMovGer + '     GER_CODVEN =:CODNEW    '
    Else If (strOpcAlt = 'V2') Then
      strSqlMovGer := strSqlMovGer + '     DET_CODVE2 =:CODNEW    '
    Else
      strSqlMovGer := strSqlMovGer + '     GER_CODREP =:CODNEW    ';

    strSqlMovGer := strSqlMovGer + '   WHERE                      ';
    strSqlMovGer := strSqlMovGer + '     GER_NUMDOC =:NUMDOC AND  ';
    strSqlMovGer := strSqlMovGer + '     GER_ESPDOC =:ESPDOC AND  ';
    strSqlMovGer := strSqlMovGer + '     GER_CODEMP =:CODEMP AND  ';
    strSqlMovGer := strSqlMovGer + '     GER_CODCLI =:CODCLI AND  ';
    strSqlMovGer := strSqlMovGer + '     GER_TIP_FC = "C"         ';
    {*****************************************}
    { SE FOR V = VENDEDOR                    *}
    {***************************************PZ}
    If (strOpcAlt = 'V') Then
      strSqlNotGer := strSqlMovGer;

    strSqlMovDet := AnsiReplaceStr(strSqlMovGer, 'GER_', 'DET_');
    strSqlNotDet := strSqlMovDet;

    strSqlCadRec := '';
    strSqlCadRec := strSqlCadRec + '   UPDATE                     ';
    strSqlCadRec := strSqlCadRec + '     TABELA                   ';
    strSqlCadRec := strSqlCadRec + '   SET                        ';
    {*****************************************}
    { SE FOR V = VENDEDOR SENÃO REPRESENTANTE*}
    {***************************************PZ}
    If (strOpcAlt = 'V') Then
      strSqlCadRec := strSqlCadRec + '     CTR_CODVEN = :CODNEW      '
    Else
      strSqlCadRec := strSqlCadRec + '     CTR_CODREP = :CODNEW      ';
    strSqlCadRec := strSqlCadRec   + '   WHERE                       ';
    strSqlCadRec := strSqlCadRec   + '     CTR_NUMDUP = :NUMDOC AND  ';
    strSqlCadRec := strSqlCadRec   + '     CTR_ESPDOC = :ESPDOC AND  ';
    strSqlCadRec := strSqlCadRec   + '     CTR_CODEMP = :CODEMP AND  ';
    strSqlCadRec := strSqlCadRec   + '     CTR_CODCLI = :CODCLI      ';

    strSqlCtrCnf := strSqlCtrCnf + '  UPDATE                      ';
    strSqlCtrCnf := strSqlCtrCnf + '    TABELA                    ';
    strSqlCtrCnf := strSqlCtrCnf + '  SET                         ';
    If (strOpcAlt = 'V') Then
      strSqlCtrCnf := strSqlCtrCnf + '  CTR_CODVEN =:CODNEW    '
    Else If (strOpcAlt = 'V2') Then
      strSqlCtrCnf := strSqlCtrCnf + '  CTR_CODVE2 =:CODNEW    '
    Else
      strSqlCtrCnf := strSqlCtrCnf + '  CTR_CODREP =:CODNEW    ';

    strSqlCtrCnf := strSqlCtrCnf + '  WHERE  ';
    strSqlCtrCnf := strSqlCtrCnf   + '     CTR_NUMDUP = :NUMDOC AND  ';
    strSqlCtrCnf := strSqlCtrCnf   + '     CTR_ESPDOC = :ESPDOC AND  ';
    strSqlCtrCnf := strSqlCtrCnf   + '     CTR_CODEMP = :CODEMP AND  ';
    strSqlCtrCnf := strSqlCtrCnf   + '     CTR_CODCLI = :CODCLI      ';

    strSqlDupAgr := strSqlDupAgr + '  UPDATE                      ';
    strSqlDupAgr := strSqlDupAgr + '    TABELA                    ';
    strSqlDupAgr := strSqlDupAgr + '  SET                         ';
    If (strOpcAlt = 'V') Then
      strSqlDupAgr := strSqlDupAgr + '  CTR_CODVEN =:CODNEW    '
    Else If (strOpcAlt = 'V2') Then
      strSqlDupAgr := strSqlDupAgr + '  CTR_CODVE2 =:CODNEW    '
    Else
      strSqlDupAgr := strSqlDupAgr + '  CTR_CODREP =:CODNEW    ';

    strSqlDupAgr := strSqlDupAgr + '  WHERE  ';
    strSqlDupAgr := strSqlDupAgr   + '     CTR_NUMDUP = :NUMDOC AND  ';
    strSqlDupAgr := strSqlDupAgr   + '     CTR_ESPDOC = :ESPDOC AND  ';
    strSqlDupAgr := strSqlDupAgr   + '     CTR_CODEMP = :CODEMP AND  ';
    strSqlDupAgr := strSqlDupAgr   + '     CTR_CODCLI = :CODCLI      ';

    QryUpdate := fCriaQuery(Nil);

    strSqlMovGer := AnsiReplaceStr(strSqlMovGer,'TABELA','MOVGER');
    strSqlNotGer := AnsiReplaceStr(strSqlNotGer,'TABELA','NOTGER');
    strSqlMovDet := AnsiReplaceStr(strSqlMovDet,'TABELA','MOVDET');
    strSqlNotDet := AnsiReplaceStr(strSqlNotDet,'TABELA','NOTDET');
    strSqlCadRec := AnsiReplaceStr(strSqlCadRec,'TABELA','CADREC');
    strSqlCtrCnf := AnsiReplaceStr(strSqlCtrCnf,'TABELA','CTRCNF');
    strSqlDupAgr := AnsiReplaceStr(strSqlDupAgr,'TABELA','DUPAGR');

    If (strOpcAlt <> 'V2')Then
    Begin
      QryUpdate.SQL.Clear;
      QryUpdate.SQL.Add(strSqlMovGer);
      pGetParam(QryUpdate);
      QryUpdate.ExecSQL;
    End;

    {*****************************************}
    { SE FOR V = VENDEDOR                     }
    {***************************************PZ}
    IF (strOpcAlt = 'V') Then
    Begin
      QryUpdate.SQL.Clear;
      QryUpdate.SQL.Add(strSqlNotGer);
      pGetParam(QryUpdate);
      QryUpdate.ExecSQL;
    End;

    If Not blnExbItens Then
    Begin
      QryUpdate.SQL.Clear;
      QryUpdate.SQL.Add(strSqlMovDet);
      pGetParam(QryUpdate);
      QryUpdate.ExecSQL;

      QryUpdate.SQL.Clear;
      QryUpdate.SQL.Add(strSqlNotDet);
      pGetParam(QryUpdate);
      QryUpdate.ExecSQL;
    End;

    If (strOpcAlt <> 'V2')Then
    Begin
      QryUpdate.SQL.Clear;
      QryUpdate.SQL.Add(strSqlCadRec);
      pGetParam(QryUpdate);
      QryUpdate.ExecSQL;
    End;

    QryUpdate.SQL.Clear;
    QryUpdate.SQL.Add(strSqlCtrCnf);
    pGetParam(QryUpdate);
    QryUpdate.ExecSQL;

    QryUpdate.SQL.Clear;
    QryUpdate.SQL.Add(strSqlDupAgr);
    pGetParam(QryUpdate);
    QryUpdate.ExecSQL;

    If (strOpcAlt = 'V') And (fCfgSis('GEMPPD', varInteger) = 2) Then
    Begin
      strSqlMOVTRI := '';
      strSqlMOVTRI := strSqlMOVTRI + ' UPDATE MOVTRI ';
      strSqlMOVTRI := strSqlMOVTRI + '   JOIN MOVDET ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER ';
      strSqlMOVTRI := strSqlMOVTRI + '   JOIN MOVGER ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER ';
      strSqlMOVTRI := strSqlMOVTRI + '   SET MOVTRI.DET_EMPORI = "'+fRetEmpresaOperador(strCodNew)+'" ';
      strSqlMOVTRI := strSqlMOVTRI + ' WHERE MOVGER.GER_NUMDOC = :NUMDOC AND ';
      strSqlMOVTRI := strSqlMOVTRI + '       MOVGER.GER_ESPDOC = :ESPDOC AND ';
      strSqlMOVTRI := strSqlMOVTRI + '       MOVGER.GER_CODEMP = :CODEMP AND ';
      strSqlMOVTRI := strSqlMOVTRI + '       MOVGER.GER_CODCLI = :CODCLI AND ';
      strSqlMOVTRI := strSqlMOVTRI + '       MOVGER.GER_TIP_FC = "C"; ';

      strSqlNOTTRI := strSqlMOVTRI;
      strSqlNOTTRI := AnsiReplaceStr(strSqlNOTTRI, 'MOVTRI', 'NOTTRI');
      strSqlNOTTRI := AnsiReplaceStr(strSqlNOTTRI, 'MOVDET', 'NOTDET');
      strSqlNOTTRI := AnsiReplaceStr(strSqlNOTTRI, 'MOVGER', 'NOTGER');

      QryUpdate.SQL.Clear;
      QryUpdate.SQL.Add(strSqlMOVTRI);
      QryUpdate.ParamByName('NUMDOC').AsString := strNumDoc;
      QryUpdate.ParamByName('ESPDOC').AsString := strEspDoc;
      QryUpdate.ParamByName('CODEMP').AsString := strCodEmp;
      QryUpdate.ParamByName('CODCLI').AsString := strCodCli;
      QryUpdate.ExecSQL;

      QryUpdate.SQL.Clear;
      QryUpdate.SQL.Add(strSqlNOTTRI);
      QryUpdate.ParamByName('NUMDOC').AsString := strNumDoc;
      QryUpdate.ParamByName('ESPDOC').AsString := strEspDoc;
      QryUpdate.ParamByName('CODEMP').AsString := strCodEmp;
      QryUpdate.ParamByName('CODCLI').AsString := strCodCli;
      QryUpdate.ExecSQL;
    End;
  End;
  FreeAndNil(QryUpdate);
end;

procedure TfrmFatAltVendedor.pAtualizaVendedoresItens;
  Var
    strVenAtu: String;
    bkmMarca: TBookmark;

    procedure pUpdate(strCampo: String);
    var qryUpd: TUniQuery;
        strUpd: String;
    begin
      try
        strVenAtu := '';

        strUpd := '';
        strUpd := strUpd + ' UPDATE ' + cdsProdutos.FieldByName('TABELA').AsString;
        If (edtEspDoc.Text='PD') Then
          strUpd := strUpd + ' SET FDO_'+ strCampo +' = :VALOR'
        Else
          strUpd := strUpd + ' SET DET_'+ strCampo +' = :VALOR';
        strUpd := strUpd + ' WHERE AUTOINCREM = :AUTINC ';

        qryUpd := fCriaQuery;
        qryUpd.SQL.Clear;
        qryUpd.SQL.Add(strUpd);
        qryUpd.ParamByName('VALOR').AsString  := cdsProdutos.FieldByName(strCampo).AsString;
        qryUpd.ParamByName('AUTINC').AsString := cdsProdutos.FieldByName('AUTINC').AsString;
        qryUpd.ExecSQL;

        If strCampo = 'CODVEN' Then
        Begin
          pGeraLogAltVend(edtDocum.Text,
                          edtEspDoc.Text,
                          edtCodEmp.Text,
                          edtCodCli.Text,
                          cdsProdutos.FieldByName('CODVENATU').AsString,
                          cdsProdutos.FieldByName('CODVEN').AsString,
                          'V',
                          cdsProdutos.FieldByName('TABELA').AsString,
                          cdsProdutos.FieldByName('AUTINC').AsString);
        End;

        If strCampo = 'CODREP' Then
        Begin
          pGeraLogAltVend(edtDocum.Text,
                          edtEspDoc.Text,
                          edtCodEmp.Text,
                          edtCodCli.Text,
                          cdsProdutos.FieldByName('CODREPATU').AsString,
                          cdsProdutos.FieldByName('CODREP').AsString,
                          'R',
                          cdsProdutos.FieldByName('TABELA').AsString,
                          cdsProdutos.FieldByName('AUTINC').AsString);
        End;

        If strCampo = 'CODVE2' Then
        Begin
          pGeraLogAltVend(edtDocum.Text,
                          edtEspDoc.Text,
                          edtCodEmp.Text,
                          edtCodCli.Text,
                          cdsProdutos.FieldByName('CODVE2ATU').AsString,
                          cdsProdutos.FieldByName('CODVE2').AsString,
                          'V2',
                          cdsProdutos.FieldByName('TABELA').AsString,
                          cdsProdutos.FieldByName('AUTINC').AsString);
        End;


      finally
        FreeAndNil(qryUpd);
      end;
    end;


begin
  With cdsProdutos Do
  Begin
    bkmMarca := GetBookmark;
    DisableControls;

    First;
    While Not Eof Do
    Begin
      If (FieldByName('CODVENATU').AsString <> FieldByName('CODVEN').AsString) Then
         pUpdate('CODVEN');

      If (FieldByName('CODREPATU').AsString <> FieldByName('CODREP').AsString) Then
         pUpdate('CODREP');

      If (FieldByName('CODVE2ATU').AsString <> FieldByName('CODVE2').AsString) Then
         pUpdate('CODVE2');

      Next;
    End;

    GotoBookmark(bkmMarca);
    FreeBookmark(bkmMarca);
    EnableControls;
  End;
end;

procedure TfrmFatAltVendedor.pEscapePressed;
begin
  If ((ActiveControl) = edtCodNew) Or ((ActiveControl) = edtCodEmp) Or ((ActiveControl) = edtEspDoc) Or ((ActiveControl) is TRadioButton) Then
    pLimpaTela
  Else
    inherited;
end;

procedure TfrmFatAltVendedor.pGeraLogAltVend(strNumDoc, strEspDoc, strCodEmp,
  strCodCli, strVenAtu, strCodNew, strOpcAlt, strTabela, strAutInc: String);
  Var
    qryGravaLog: TUniQuery;
    strSQL: String;
begin
  fStartTransaction;
  Try

    qryGravaLog := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' INSERT INTO LOGVEN ( ';
    strSQL := strSQL + '   AUTOINCREM, ';
    strSQL := strSQL + '   LOG_NUMDOC, ';
    strSQL := strSQL + '   LOG_ESPDOC, ';
    strSQL := strSQL + '   LOG_CODCLI, ';
    strSQL := strSQL + '   LOG_CODEMP, ';
    strSQL := strSQL + '   LOG_DTAALT, ';
    strSQL := strSQL + '   LOG_HRAALT, ';
    strSQL := strSQL + '   LOG_OPEALT, ';
    strSQL := strSQL + '   LOG_CPOALT, ';
    strSQL := strSQL + '   LOG_TABELA, ';
    strSQL := strSQL + '   LOG_AUTINC, ';
    strSQL := strSQL + '   LOG_INFANT, ';
    strSQL := strSQL + '   LOG_INFNOV) ';
    strSQL := strSQL + ' VALUES ( ';
    strSQL := strSQL + '   :AUTOIN, ';
    strSQL := strSQL + '   :NUMDOC, ';
    strSQL := strSQL + '   :ESPDOC, ';
    strSQL := strSQL + '   :CODCLI, ';
    strSQL := strSQL + '   :CODEMP, ';
    strSQL := strSQL + '   :DTAALT, ';
    strSQL := strSQL + '   :HRAALT, ';
    strSQL := strSQL + '   :OPEALT, ';
    strSQL := strSQL + '   :CPOALT, ';
    strSQL := strSQL + '   :TABELA, ';
    strSQL := strSQL + '   :AUTINC, ';
    strSQL := strSQL + '   :INFANT, ';
    strSQL := strSQL + '   :INFNOV ) ';

    With qryGravaLog Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('AUTOIN').AsString := fRetAutoIncrem('LOGVEN', VS_strCodEmp);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('DTAALT').AsDate   := VS_Date;
      ParamByName('HRAALT').AsTime   := fTime();
      ParamByName('OPEALT').AsString := strLoginUsuarioLogado;

      If (strOpcAlt = 'V') Then
        ParamByName('CPOALT').AsString := 'VENDEDOR'
      Else If (strOpcAlt = 'R') Then
        ParamByName('CPOALT').AsString := 'REPRESENTANTE'
      Else
        ParamByName('CPOALT').AsString := 'VENDEDOR 2';

      ParamByName('TABELA').AsString := strTabela;
      ParamByName('AUTINC').AsString := strAutInc;

      ParamByName('INFANT').AsString := strVenAtu;
      ParamByName('INFNOV').AsString := strCodNew;

      ExecSQL;
      Close;

    End;

    fCommit;
    FreeAndNil(qryGravaLog);

  Except

    On E : Exception do
    Begin
      FreeAndNil(qryGravaLog);
      fRollBack;
      pMensagensErro(E.Message, '[Erro ao Gravar o Log]');
    End;

  End;
end;

procedure TfrmFatAltVendedor.rdgOpcAltClick(Sender: TObject);
begin
  inherited;
  Case rdgOpcAlt.ItemIndex Of
    IDX_VEN:
      Begin
        lblVen.Caption := 'Vendedor' + IIF(blnExbItens, ' do Documento', '');

        If blnExbItens Then
          lblTitulo.Caption := 'Vendedores dos Itens';
      End;
    IDX_REP:
      Begin
        lblVen.Caption := 'Representante' + IIF(blnExbItens, ' do Documento', '');

        If blnExbItens Then
          lblTitulo.Caption := 'Representantes dos Itens';
      End;
    IDX_VE2:
      Begin
        lblVen.Caption := 'Vendedor 2' + IIF(blnExbItens, ' do Documento', '');

        If blnExbItens Then
          lblTitulo.Caption := 'Vendedores 2 dos Itens';
      End;
  End;

  If blnExbItens Then
  Begin

    btnTrocaVendedor.Caption := '&Trocar ' + fRetornaCaption + ' de todos os itens';

    cdsProdutos.BeforePost := pBeforePost;

    case rdgOpcAlt.ItemIndex of
      IDX_VEN:
        begin
          cxGridVendedoresCodVenAtual.Caption := 'Vend.Atual';
          cxGridVendedoresNomVenAtual.Caption := 'Nome Vendedor Atual';
          cxGridVendedoresCodVenAtual.DataBinding.FieldName := 'CODVENATU';
          cxGridVendedoresNomVenAtual.DataBinding.FieldName := 'NOMVENATU';

          cxGridVendedoresCodVenNovo.Caption := 'Vend.Novo';
          cxGridVendedoresNomVenNovo.Caption := 'Nome Vendedor Novo';
          cxGridVendedoresCodVenNovo.DataBinding.FieldName := 'CODVEN';
          cxGridVendedoresNomVenNovo.DataBinding.FieldName := 'NOMVEN';
        end;
      IDX_REP:
        begin
          cxGridVendedoresCodVenAtual.Caption := 'Rep.Atual';
          cxGridVendedoresNomVenAtual.Caption := 'Nome Representante Atual';
          cxGridVendedoresCodVenAtual.DataBinding.FieldName := 'CODREPATU';
          cxGridVendedoresNomVenAtual.DataBinding.FieldName := 'NOMREPATU';

          cxGridVendedoresCodVenNovo.Caption := 'Rep.Novo';
          cxGridVendedoresNomVenNovo.Caption := 'Nome Representante Novo';
          cxGridVendedoresCodVenNovo.DataBinding.FieldName := 'CODREP';
          cxGridVendedoresNomVenNovo.DataBinding.FieldName := 'NOMREP';
        end;
      IDX_VE2:
        begin
          cxGridVendedoresCodVenAtual.Caption := 'Ven2.Atual';
          cxGridVendedoresNomVenAtual.Caption := 'Nome Vendedor 2 Atual';
          cxGridVendedoresCodVenAtual.DataBinding.FieldName := 'CODVE2ATU';
          cxGridVendedoresNomVenAtual.DataBinding.FieldName := 'NOMVE2ATU';

          cxGridVendedoresCodVenNovo.Caption := 'Ven2 Novo';
          cxGridVendedoresNomVenNovo.Caption := 'Nome Vendedor 2 Novo';
          cxGridVendedoresCodVenNovo.DataBinding.FieldName := 'CODVE2';
          cxGridVendedoresNomVenNovo.DataBinding.FieldName := 'NOMVE2';
        end;
     end;
  End;

  edtCodNew.Clear;
  edtDesNew.Clear;
  pSetFocus(edtCodNew);
end;

procedure TfrmFatAltVendedor.cxGridVendedoresCodVenPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  If AButtonIndex = 0 Then
    pGridValidaVendedor('/');

end;

procedure TfrmFatAltVendedor.cxGridVendedoresCodVenPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var strValue: String;
begin
  inherited;
  strValue := varToStr( DisplayValue );

  If not fEmptyStr(strValue) then
    pGridValidaVendedor( strValue );

end;

procedure TfrmFatAltVendedor.pBeforePost(DataSet: TDataSet);
  Var
    strNomVen,
    strMsg,
    strFieldCod,
    strFieldNom: String;
begin
  With DataSet Do
  Begin
    Case rdgOpcAlt.ItemIndex Of
      IDX_VEN:
        Begin
          strMsg := 'Vendedor';
          strFieldCod := 'CODVEN';
          strFieldNom := 'NOMVEN';
        End;
      IDX_REP:
        Begin
          strMsg := 'Representante';
          strFieldCod := 'CODREP';
          strFieldNom := 'NOMREP';
        End;
      IDX_VE2:
        Begin
          strMsg := 'Vendedor 2';
          strFieldCod := 'CODVE2';
          strFieldNom := 'NOMVE2';
        End;
    End;

    If Not fEmptyStr(FieldByName(strFieldCod).AsString) Then
      FieldByName(strFieldCod).AsString := fStrZero(FieldByName(strFieldCod).AsString, 3);

    strNomVen := fRetNomVendRep(FieldByName(strFieldCod).AsString);

    If fEmptyStr(FieldByName(strFieldCod).AsString) Then
    Begin
      cdsProdutos.FieldByName(strFieldCod).FocusControl;
      fMensagem('ATENÇÃO', 'Defina o ' + strMsg + ' para este item.',['&O K']);
      Cancel;
      Abort;
      Exit;
    End
    Else If fEmptyStr(strNomVen) Then
    Begin
      cdsProdutos.FieldByName(strFieldCod).FocusControl;
      fMensagem('ATENÇÃO', strMsg + ' digitado neste item não foi encontrado, verifique!',['&O K']);
      Cancel;
      Abort;
      Exit;
    End
    Else
      cdsProdutos.FieldByName(strFieldNom).AsString := strNomVen;
  End;
end;

function TfrmFatAltVendedor.fRetornaCaption: String;
Begin
  case rdgOpcAlt.ItemIndex of
    IDX_VEN: Result := 'Vendedor';
    IDX_REP: Result := 'Representante';
    IDX_VE2: Result := 'Vendedor 2';
  end;
End;

procedure TfrmFatAltVendedor.pTrocarVendedor2TodosItens(strCodVen: String);
begin
  With cdsProdutos do
  Begin
    Try
      DisableControls;
      First;
      While not eof do
      Begin
        pTrocaVendedor(strCodVen);
        Next;
      End;
    Finally
      First;
      EnableControls;
    End;
  End;
end;

procedure TfrmFatAltVendedor.pTrocaVendedor(strCodVen:String);
begin
  If cdsProdutos.State = dsBrowse Then
    cdsProdutos.Edit;

  case rdgOpcAlt.ItemIndex of
   IDX_VEN: cdsProdutos.FieldByName('CODVEN').AsString := strCodVen;
   IDX_REP: cdsProdutos.FieldByName('CODREP').AsString := strCodVen;
   IDX_VE2: cdsProdutos.FieldByName('CODVE2').AsString := strCodVen;
  end;

  cdsProdutos.Post;
end;

procedure TfrmFatAltVendedor.pGridValidaVendedor(strValue: String);
Var
  arrOperador: TConsultasArray;
  edtCodigo: TEditFocus;
  Key: Char;

begin
  inherited;

  If Pos(strValue,'/') > 0 Then
  Begin
    Key := '/';

    edtCodigo := TEditFocus.Create(Nil);

    If fPesqOperador(Self, edtCodigo, Nil, Nil, Key, arrOperador) Then
      pTrocaVendedor(edtCodigo.Text);

    FreeAndNil(edtCodigo);
  End
  Else
    pTrocaVendedor(strValue);

End;

procedure TfrmFatAltVendedor.btnTrocaVendedorClick(Sender: TObject);
var strCodVen:String;
begin
  inherited;
  If fInformouVendedor(strCodVen) Then
  Begin
    pTrocarVendedor2TodosItens(strCodVen);
  End;
end;

function TfrmFatAltVendedor.fInformouVendedor(var strCodVen:String): Boolean;
  Var
    frmDigPortador : TfrmDigPortador;
begin
  Result := False;
  Try
    pCriarFormularios(TfrmDigPortador, frmDigPortador);
    frmDigPortador.lbl1.Caption := fRetornaCaption;
    frmDigPortador.edtPorBai.Enabled := False;
    frmDigPortador.edtPorBai.Visible := False;
    frmDigPortador.edtCodPorBai.Enabled := False;
    frmDigPortador.edtCodPorBai.Visible := False;
    frmDigPortador.lblPor.Visible := False;
    frmDigPortador.edtCodVen.Top := frmDigPortador.edtPorBai.Top;
    frmDigPortador.edtNomVen.Top := frmDigPortador.edtCodPorBai.Top;
    frmDigPortador.lbl1.Top := frmDigPortador.lblPor.Top;
    frmDigPortador.Height := frmDigPortador.Height - frmDigPortador.edtPorBai.Height;
    frmDigPortador.ShowModal;

    If (frmDigPortador.blnConfirma) And (Not fEmptyStr(frmDigPortador.edtCodVen.Text)) Then
    Begin
      strCodVen := frmDigPortador.edtCodVen.Text;
      Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmFatAltVendedor.fInformouVendedor]');
    End;
  End;
  pFreeAndNil(frmDigPortador);
end;

function TfrmFatAltVendedor.fTeveVendedorItensModificado: Boolean;
  Var
    cdsClone : TUniClientDataSet;
begin
  cdsClone := TUniClientDataSet.Create(Self);
  Try
    pCloneDataSet(cdsClone, cdsProdutos);
    case rdgOpcAlt.ItemIndex of
      IDX_VEN: cdsClone.Filter := 'CODVENATU <> CODVEN';
      IDX_REP: cdsClone.Filter := 'CODREPATU <> CODREP';
      IDX_VE2: cdsClone.Filter := 'CODVE2ATU <> CODVE2';
    end;
    cdsClone.Filtered := True;
    Result := (Not cdsClone.IsEmpty);
    cdsClone.Close;
  Finally
    FreeAndNil(cdsClone);
  End;
end;

end.
