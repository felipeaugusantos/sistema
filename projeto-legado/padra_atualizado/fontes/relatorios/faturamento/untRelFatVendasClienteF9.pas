unit untRelFatVendasClienteF9;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  EditFocus, DB, Uni, StrUtils, AppEvnts, MaskUtils, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, Vcl.Mask, MaskEditFocus, untTipoFreteAtc,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, cxProgressBar, untTypesSistema,untZClient,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxCalendar;

type
  TfrmRelFatVendasClienteF9 = class(TfrmPai)
    pnlTotais: TPanel;
    pnlTopo: TPanel;
    lblCliente: TLabel;
    pnlDados: TPanel;
    edtDesItem: TEditFocus;
    Label1: TLabel;
    Label3: TLabel;
    edtMens001: TEditFocus;
    edtMens002: TEditFocus;
    edtCndPgto: TEditFocus;
    lblCndPag: TLabel;
    lblCodCli: TLabel;
    edtCliente: TEditFocus;
    Label5: TLabel;
    edtTransp: TEditFocus;
    pnlVendedor: TPanel;
    edtDesMarca: TEditFocus;
    Label6: TLabel;
    dtsRelVenCli: TDataSource;
    lbl1: TLabel;
    edtFormas: TEditFocus;
    lblNumLot: TLabel;
    edtNumLot: TEditFocus;
    edtCodCnd: TEditFocus;
    pnlProfissional: TPanel;
    lbl2: TLabel;
    edtProfissional: TEditFocus;
    pnlFornecedor: TPanel;
    lblFornecedor: TLabel;
    edtFornecedor: TEditFocus;
    pnlRecebido: TPanel;
    lblNomRec: TLabel;
    edtNomRec: TEditFocus;
    Label2: TLabel;
    edtVendedor: TEditFocus;
    edtPerCom: TEditFocus;
    lblPerCom: TLabel;
    lblEndEtr: TLabel;
    edtEndEtr: TEditFocus;
    pnlTotaisRcxBru: TPanel;
    edtVrBruto: TEditFocus;
    edtVrLiquido: TEditFocus;
    edtVrDesconto: TEditFocus;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    pnlTotais3: TPanel;
    lblTitMar: TLabel;
    lblTitCusto: TLabel;
    edtCusto: TEditFocus;
    edtMargem: TEditFocus;
    pnlPlacaMecanico: TPanel;
    lblPlaca: TLabel;
    edtPlaVei: TMaskEditFocus;
    edtKm_Vei: TMaskEditFocus;
    btnPesquisarMecanico: TBitBtnLocked;
    lblQtdPec: TLabel;
    edtQtdPec: TEditFocus;
    edtComPec: TEditFocus;
    dbgItens: TcxGrid;
    dbgItensDBTableView1: TcxGridDBTableView;
    dbgItensLevel1: TcxGridLevel;
    CODEMP: TcxGridDBColumn;
    DTAENT: TcxGridDBColumn;
    NUMDOC: TcxGridDBColumn;
    DOCORI: TcxGridDBColumn;
    CODITE: TcxGridDBColumn;
    DESCRI: TcxGridDBColumn;
    REFERE: TcxGridDBColumn;
    QTDITE: TcxGridDBColumn;
    VLRSUG: TcxGridDBColumn;
    VLRPRA: TcxGridDBColumn;
    TOTSUG: TcxGridDBColumn;
    TOTPRA: TcxGridDBColumn;
    VLRDES: TcxGridDBColumn;
    PERDES: TcxGridDBColumn;
    ALQIPI: TcxGridDBColumn;
    TOTIPI: TcxGridDBColumn;
    TOTCUS: TcxGridDBColumn;
    MARGEM: TcxGridDBColumn;
    NOMCLI: TcxGridDBColumn;
    btnConfirmar: TBitBtnLocked;
    btnMarDesTodos: TBitBtnLocked;
    MARDES: TcxGridDBColumn;
    shpSelecionados: TShape;
    lblSelecionados: TLabel;
    shpItensServico: TShape;
    lblItensServico: TLabel;
    IDEPRO: TcxGridDBColumn;
    CODACA: TcxGridDBColumn;
    PROMOC: TcxGridDBColumn;
    pnlStatPromoc: TPanel;
    Shape1: TShape;
    Label17: TLabel;
    VENDED: TcxGridDBColumn;
    CODVEN: TcxGridDBColumn;
    UNITAR: TcxGridDBColumn;
    LblCPF: TLabel;
    edtCPF: TEditFocus;
    TOTFRE: TcxGridDBColumn;
    DESACE: TcxGridDBColumn;
    VALRET: TcxGridDBColumn;
    VFCPST: TcxGridDBColumn;
    VLRCON: TcxGridDBColumn;
    pnlMostraDebCtrChq2: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    edtVlrIte: TEditFocus;
    edtVlrIPI: TEditFocus;
    edtVlrCon: TEditFocus;
    edtVlrDesc: TEditFocus;
    edtTipFrete: TEditFocus;
    edtVlrFrete: TEditFocus;
    edtDesAce: TEditFocus;
    Label12: TLabel;
    edtVlrST: TEditFocus;
    Label14: TLabel;
    edtVlrFcp: TEditFocus;
    Label19: TLabel;
    pnlTotais2: TPanel;
    Label13: TLabel;
    lblTotalIPI: TLabel;
    Label20: TLabel;
    lbl3: TLabel;
    lblVlrDes: TLabel;
    lblTipFre: TLabel;
    lblValFre: TLabel;
    edtTotIte: TEditFocus;
    edtTotIpi: TEditFocus;
    edtValTot: TEditFocus;
    edtQtdDoc: TEditFocus;
    edtVlrDes: TEditFocus;
    edtTipFre: TEditFocus;
    edtTotFre: TEditFocus;
    NUMCMP: TcxGridDBColumn;
    COMPLE: TcxGridDBColumn;
    TABPRE: TcxGridDBColumn;
    CODFAB: TcxGridDBColumn;
    edtTotFcpSt: TEditFocus;
    lblTotFcpSt: TLabel;
    edtTotST: TEditFocus;
    lblTotST: TLabel;
    Label23: TLabel;
    edtTotContabil: TEditFocus;
    UNIDAD: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pMostrarProdutos(strNumDoc, strEspDoc, strCodEmp: String; blnSelDocumentosP: Boolean=False; strCodCli: String='';
      blnRcxSelDocumento: Boolean = False);
    procedure pMostrarServicos(strNumDoc, strEspDoc, strCodEmp, strTabela: String;
      blnSelDocumentosP: Boolean=False; strCodCli: String=''; blnRcxSelDocumento: Boolean = False);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnPesquisarMecanicoClick(Sender: TObject);
    procedure dbgItensDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgItensDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnMarDesTodosClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
    QryRel : TUniQuery;
    FRcxSelDocumento: Boolean;
    blnServicos: Boolean;
    function fAtualizaTotal(pgbStatus: TcxProgressBar): Boolean;
    procedure pAtualizaTotal;

    function fAjustandoTela(pgbStatus: TcxProgressBar): Boolean;
    procedure pAjustandoTela;

    procedure pAtualizaDados(DataSet: TDataSet);
    function fRetEnderecoEntrega(strCodCli,strNonCli,strTabela,strAutInc: String): String;
    procedure pSetaVisibilidadeColuna(strFieldName: String; blnVisivel: Boolean);
    procedure pSetaFormatoMonetario(DataSet: TDataSet; strFieldName: String; blnDecUni: Boolean = False);
    procedure pMarcarTodos(blnMarca: Boolean);
    procedure pMarca(blnMarca: Boolean);
    function fMarkup4(strCampoTotIte: String): String;
    procedure pAlterarLayoutForm;
    procedure pAtualizaDadosDoFrete(const DataSet : TDataSet);
  public
    { Public declarations }
    blnSelDocumentos: Boolean;
    blnVeioDoTelemarketing     : Boolean;
    blnVeioDoTablet            : Boolean;
    blnVeioTelaVendas          : Boolean;
    blnMosCom                  : Boolean;
    blnMosVenMtl               : Boolean;
    blnMosPromoc               : Boolean;
    blnMostraDebCtrChq2        : Boolean;
    blnExibirReferenciaUnidade : Boolean;
    strCodRedeLojasCliente: String;
    fIncluirItem: TfIncluiItem;
    cdsRel : TZClient;

    class function fColunasRelFatVendasClienteF9: String;
  end;

var
  frmRelFatVendasClienteF9: TfrmRelFatVendasClienteF9;

implementation

uses untIFuncoes, untRelFatVendasCliente, untFuncoesSimples,
  untGravando, untConstantes, untFuncoesGenerica,
  untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

procedure TfrmRelFatVendasClienteF9.FormShow(Sender: TObject);
begin
  inherited;

  pAtualizaTotal;
  pAjustandoTela;
  pAlterarLayoutForm;

end;

function TfrmRelFatVendasClienteF9.fRetEnderecoEntrega(strCodCli, strNonCli,
  strTabela, strAutInc: String): String;
  Var
    qryEndEnt: TUniQuery;
    strSQL: String;
begin

  Result := '';

  If fEmptyStr(strCodCli) Or fEmptyStr(strNonCli) Or
     fEmptyStr(strTabela) Or fEmptyStr(strAutInc) Then
  Exit;

  qryEndEnt := fCriaQuery(Nil);
  Try
    If fClienteConsumidor(strNonCli, True, True) Then
      strSQL := fRetSQLEnderecoEntregaCliConsumidor(strCodCli, strAutInc, strTabela)
    Else
      strSQL := fRetSQLEnderecoEntregaCli(strTabela);

    qryEndEnt.Close;
    qryEndEnt.SQL.Clear;
    qryEndEnt.SQL.Add(strSQL);
    qryEndEnt.ParamByName('CODCLI').AsString := strCodCli;
    qryEndEnt.ParamByName('SEQGER').AsString := strAutInc;
    qryEndEnt.Open;

    If Not qryEndEnt.IsEmpty Then
    Begin
      Result := qryEndEnt.FieldByName('ETC_ENDENT').AsString + ' - ' +
                qryEndEnt.FieldByName('ETC_BAIENT').AsString + ' - ' +
                fRetNomCidade(qryEndEnt.FieldByName('ETC_CIDENT').AsString) + ' - ' +
                fRetNomCidade(qryEndEnt.FieldByName('ETC_CIDENT').AsString, 1) +
                IfThen(fEmptyStr(qryEndEnt.FieldByName('ETC_REFENT').AsString), '', ' - Referência: ' + qryEndEnt.FieldByName('ETC_REFENT').AsString) +
                IfThen(fEmptyStr(qryEndEnt.FieldByName('ETC_CONENT').AsString), '', ' - Contato: '+ qryEndEnt.FieldByName('ETC_CONENT').AsString);
    End;
  Finally
    FreeAndNil(qryEndEnt);
  End;

end;

{************************************}
{* ATUALIZA O TOTAL DO DESCONTO,    *}
{* MARGEM CUSTO E GERAL             *}
{*********************************AF*}
procedure TfrmRelFatVendasClienteF9.pAtualizaTotal;
  Var
    LfrmGravando: TfrmGravando;
Begin
  pCriarFormularios(TfrmGravando, LfrmGravando);
  Try
    LfrmGravando.fExecutarAcao := fAtualizaTotal;
    LfrmGravando.ShowModal;
  Finally
    pFreeAndNil(LfrmGravando);
  End;
End;

procedure TfrmRelFatVendasClienteF9.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key = VK_Escape Then
    btnSair.Click
  Else If (Shift = []) And (Key = VK_F7) And btnMarDesTodos.Visible Then
    btnMarDesTodos.Click
  Else If (Shift = []) And (Key = VK_F10) And btnConfirmar.Visible Then
    btnConfirmar.Click;
end;

procedure TfrmRelFatVendasClienteF9.pMarca(blnMarca: Boolean);
var
  evnAfterScroll: TDataSetNotifyEvent;
begin
  evnAfterScroll := dtsRelVenCli.DataSet.AfterScroll;
  dtsRelVenCli.DataSet.AfterScroll := nil;

  Try
    dtsRelVenCli.DataSet.Edit;
    dtsRelVenCli.DataSet.FieldByName('MARDES').AsString := IIF(blnMarca, 'M', 'D');
    dtsRelVenCli.DataSet.Post;
  Finally
    dtsRelVenCli.DataSet.AfterScroll := evnAfterScroll;
  End;
end;

procedure TfrmRelFatVendasClienteF9.pMarcarTodos(blnMarca: Boolean);
var
  intRecNo: Integer;
  evnAfterScroll: TDataSetNotifyEvent;
begin
  With dtsRelVenCli.DataSet Do
  Begin
    intRecNo := RecNo;
    evnAfterScroll := AfterScroll;
    AfterScroll := nil;
    DisableControls;
    Try
      First;
      While Not Eof Do
      Begin
        If (Not fEhItemServico(FieldByName('CODITE').AsString)) And
           (FieldByName('IDEPRO').AsString = 'NOR') And
           (FieldByName('CODACA').IsNull) Then
          pMarca(blnMarca);

        Next;
      End;
    Finally
      RecNo := intRecNo;
      AfterScroll := evnAfterScroll;
      EnableControls;
    End;
  End;
end;

{*******************************************}
{* MOSTRA OS PRODUTOS PERTENCENTES A UM    *}
{* DOCUMENTO DE VENDA                      *}
{****************************************RL*}
procedure TfrmRelFatVendasClienteF9.pMostrarProdutos(strNumDoc, strEspDoc,
  strCodEmp: String; blnSelDocumentosP: Boolean=False; strCodCli: String='';
  blnRcxSelDocumento: Boolean = False);
  Var
    strSQL: String;
    strTotTmp: String;
    intContador: Integer;
    intCampos: Integer;

    Function fRetFatGorAutIncNumCmp(strAlias: String): String;
    Begin
      Result := '';
      Result := Result + '(SELECT FDO_SEQGER FROM FATDOR WHERE TRUE';
      Result := Result + ' AND ' + strAlias + '.DET_NUMDOC = FDO_NUMFAT';
      Result := Result + ' AND ' + strAlias + '.DET_ESPDOC = FDO_TIPFAT';
      Result := Result + ' AND ' + strAlias + '.DET_CODEMP = FDO_EMPFAT';
      Result := Result + ' AND ' + strAlias + '.DET_CODCLI = FDO_CODCLI';
      Result := Result + ' AND ' + strAlias + '.DET_CODITE = FDO_CODITE';
      Result := Result + ' LIMIT 1)';
    End;
begin
  blnServicos      := False;
  blnSelDocumentos := blnSelDocumentosP;
  FRcxSelDocumento := blnRcxSelDocumento;

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  DET_PROMOC AS PROMOC, ';
  strSQL := strSQL + '  "D" AS MARDES, ';
  strSQL := strSQL + '  CLI_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI, ';
  strSQL := strSQL + '  AUX_PLAVEI AS PLAVEI, ';
  strSQL := strSQL + '  AUX_KM_VEI AS KM_VEI, ';
  strSQL := strSQL + '  DET_DTAENT, ';
  strSQL := strSQL + '  DATE_FORMAT(DET_DTAENT,"%d/%m/%y") AS DTAENT, ';
  strSQL := strSQL + '  CONCAT(DET_NUMDOC,"-",DET_ESPDOC) AS NUMDOC, ';
  strSQL := strSQL + '  DET_NUMDOC AS DOCUME, ';
  strSQL := strSQL + '  DET_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '  DET_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  DET_CODITE AS CODITE, ';
  strSQL := strSQL + '  ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '  DET_IDEPRO AS IDEPRO, ';
  strSQL := strSQL + '  DET_CODACA AS CODACA, ';
  strSQL := strSQL + '  IF(IFNULL(DET_CONPAG, "") = "", " ", DET_CONPAG) AS CNDFAT, ';
  strSQL := strSQL + '  MAR_DESMAR AS DESMAR, ';
  strSQL := strSQL + '  DET_DESCRI AS DESCRI, ';
  strSQL := strSQL + '  IF((LOCATE("ITEM ESPECIAL", ITE_DESITE) > 0) OR (DET_IDEPRO <> "NOR") OR (DET_PROACA = "S"), "D", "I") AS CONARQ, ';

  strSQL := strSQL + '  IF((LOCATE("ITEM ESPECIAL", ITE_DESITE) > 0) OR (DET_IDEPRO <> "NOR") OR (DET_PROACA = "S"), DET_REFERE, ITE_REFERE) AS REFERE, ';
  strSQL := strSQL + '  IFNULL(UNI_SIGUNI, "") AS UNIDAD, ';
  strSQL := strSQL + '  TR.DET_COMPLE AS COMPLE, ';
  strSQL := strSQL + '  DET_NUMLOT AS NUMLOT, ';

  strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) < 5, -(DET_DESESP), DET_DESESP) AS DESESP, ';
  strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) < 5, -(DET_UNITAR), DET_UNITAR) AS UNITAR, ';
  strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) < 5, -(DET_QTDITE), DET_QTDITE) AS QTDITE, ';

  strTotTmp :=  '  IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF) ';

  strSQL := strSQL + strTotTmp + ' AS TOTITE, ';
  strSQL := strSQL + '  IFNULL(' + fMarkup4(strTotTmp) + ', 0) AS MAMKP4, ';

  strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTCUS), DET_TOTCUS) AS TOTCUS, ';
  strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) < 5, -(IF(DET_UNITAR > DET_UNIORI, DET_UNITAR, DET_UNIORI)), IF(DET_UNITAR > DET_UNIORI, DET_UNITAR, DET_UNIORI)) * DET_QTDITE AS TOTBRU, ';

  strSQL := strSQL + ' ' + fColunasRelFatVendasClienteF9 + ', ';

  strSQL := strSQL + '  GER_CODS01 AS CODS01, ';
  strSQL := strSQL + '  GER_CODS02 AS CODS02, ';
  strSQL := strSQL + '  GER_CODS03 AS CODS03, ';
  strSQL := strSQL + '  GER_CODS04 AS CODS04, ';
  strSQL := strSQL + '  GER_CODS05 AS CODS05, ';
  strSQL := strSQL + '  GER_CODS06 AS CODS06, ';
  strSQL := strSQL + '  GER_CODS07 AS CODS07, ';
  strSQL := strSQL + '  GER_CODS08 AS CODS08, ';
  strSQL := strSQL + '  GER_CODS09 AS CODS09, ';
  strSQL := strSQL + '  GER_CODS10 AS CODS10, ';
  strSQL := strSQL + '  GER_CODS11 AS CODS11, ';
  strSQL := strSQL + '  GER_CODS12 AS CODS12, ';
  strSQL := strSQL + '  GER_CODS13 AS CODS13, ';
  strSQL := strSQL + '  GER_CODS14 AS CODS14, ';
  strSQL := strSQL + '  GER_CODS15 AS CODS15, ';
  strSQL := strSQL + '  GER_CODS16 AS CODS16, ';
  strSQL := strSQL + '  GER_CODS17 AS CODS17, ';
  strSQL := strSQL + '  GER_CODS18 AS CODS18, ';
  strSQL := strSQL + '  GER_CODS19 AS CODS19, ';
  strSQL := strSQL + '  GER_CODS20 AS CODS20, ';
  strSQL := strSQL + '  GER_CODS21 AS CODS21, ';
  strSQL := strSQL + '  GER_CODS22 AS CODS22, ';
  strSQL := strSQL + '  GER_CODS23 AS CODS23, ';
  strSQL := strSQL + '  GER_CODS24 AS CODS24, ';
  strSQL := strSQL + '  GER_CODS25 AS CODS25, ';
  strSQL := strSQL + '  GER_CODS26 AS CODS26, ';
  strSQL := strSQL + '  GER_CODS27 AS CODS27, ';
  strSQL := strSQL + '  GER_CODS28 AS CODS28, ';
  strSQL := strSQL + '  GER_CODS29 AS CODS29, ';
  strSQL := strSQL + '  GER_CODS30 AS CODS30, ';

  strSQL := strSQL + '  GER_DESS01 AS DESS01, ';
  strSQL := strSQL + '  GER_DESS02 AS DESS02, ';
  strSQL := strSQL + '  GER_DESS03 AS DESS03, ';
  strSQL := strSQL + '  GER_DESS04 AS DESS04, ';
  strSQL := strSQL + '  GER_DESS05 AS DESS05, ';
  strSQL := strSQL + '  GER_DESS06 AS DESS06, ';
  strSQL := strSQL + '  GER_DESS07 AS DESS07, ';
  strSQL := strSQL + '  GER_DESS08 AS DESS08, ';
  strSQL := strSQL + '  GER_DESS09 AS DESS09, ';
  strSQL := strSQL + '  GER_DESS10 AS DESS10, ';
  strSQL := strSQL + '  GER_DESS11 AS DESS11, ';
  strSQL := strSQL + '  GER_DESS12 AS DESS12, ';
  strSQL := strSQL + '  GER_DESS13 AS DESS13, ';
  strSQL := strSQL + '  GER_DESS14 AS DESS14, ';
  strSQL := strSQL + '  GER_DESS15 AS DESS15, ';
  strSQL := strSQL + '  GER_DESS16 AS DESS16, ';
  strSQL := strSQL + '  GER_DESS17 AS DESS17, ';
  strSQL := strSQL + '  GER_DESS18 AS DESS18, ';
  strSQL := strSQL + '  GER_DESS19 AS DESS19, ';
  strSQL := strSQL + '  GER_DESS20 AS DESS20, ';
  strSQL := strSQL + '  GER_DESS21 AS DESS21, ';
  strSQL := strSQL + '  GER_DESS22 AS DESS22, ';
  strSQL := strSQL + '  GER_DESS23 AS DESS23, ';
  strSQL := strSQL + '  GER_DESS24 AS DESS24, ';
  strSQL := strSQL + '  GER_DESS25 AS DESS25, ';
  strSQL := strSQL + '  GER_DESS26 AS DESS26, ';
  strSQL := strSQL + '  GER_DESS27 AS DESS27, ';
  strSQL := strSQL + '  GER_DESS28 AS DESS28, ';
  strSQL := strSQL + '  GER_DESS29 AS DESS29, ';
  strSQL := strSQL + '  GER_DESS30 AS DESS30, ';

  strSQL := strSQL + '  GER_VALS01 AS VALS01, ';
  strSQL := strSQL + '  GER_VALS02 AS VALS02, ';
  strSQL := strSQL + '  GER_VALS03 AS VALS03, ';
  strSQL := strSQL + '  GER_VALS04 AS VALS04, ';
  strSQL := strSQL + '  GER_VALS05 AS VALS05, ';
  strSQL := strSQL + '  GER_VALS06 AS VALS06, ';
  strSQL := strSQL + '  GER_VALS07 AS VALS07, ';
  strSQL := strSQL + '  GER_VALS08 AS VALS08, ';
  strSQL := strSQL + '  GER_VALS09 AS VALS09, ';
  strSQL := strSQL + '  GER_VALS10 AS VALS10, ';
  strSQL := strSQL + '  GER_VALS11 AS VALS11, ';
  strSQL := strSQL + '  GER_VALS12 AS VALS12, ';
  strSQL := strSQL + '  GER_VALS13 AS VALS13, ';
  strSQL := strSQL + '  GER_VALS14 AS VALS14, ';
  strSQL := strSQL + '  GER_VALS15 AS VALS15, ';
  strSQL := strSQL + '  GER_VALS16 AS VALS16, ';
  strSQL := strSQL + '  GER_VALS17 AS VALS17, ';
  strSQL := strSQL + '  GER_VALS18 AS VALS18, ';
  strSQL := strSQL + '  GER_VALS19 AS VALS19, ';
  strSQL := strSQL + '  GER_VALS20 AS VALS20, ';
  strSQL := strSQL + '  GER_VALS21 AS VALS21, ';
  strSQL := strSQL + '  GER_VALS22 AS VALS22, ';
  strSQL := strSQL + '  GER_VALS23 AS VALS23, ';
  strSQL := strSQL + '  GER_VALS24 AS VALS24, ';
  strSQL := strSQL + '  GER_VALS25 AS VALS25, ';
  strSQL := strSQL + '  GER_VALS26 AS VALS26, ';
  strSQL := strSQL + '  GER_VALS27 AS VALS27, ';
  strSQL := strSQL + '  GER_VALS28 AS VALS28, ';
  strSQL := strSQL + '  GER_VALS29 AS VALS29, ';
  strSQL := strSQL + '  GER_VALS30 AS VALS30, ';

  strSQL := strSQL + '  GER_VALS01 AS VALS01, ';
  strSQL := strSQL + '  GER_VALS02 AS VALS02, ';
  strSQL := strSQL + '  GER_VALS03 AS VALS03, ';
  strSQL := strSQL + '  GER_VALS04 AS VALS04, ';
  strSQL := strSQL + '  GER_VALS05 AS VALS05, ';
  strSQL := strSQL + '  GER_VALS06 AS VALS06, ';
  strSQL := strSQL + '  GER_VALS07 AS VALS07, ';
  strSQL := strSQL + '  GER_VALS08 AS VALS08, ';
  strSQL := strSQL + '  GER_VALS09 AS VALS09, ';
  strSQL := strSQL + '  GER_VALS10 AS VALS10, ';
  strSQL := strSQL + '  GER_VALS11 AS VALS11, ';
  strSQL := strSQL + '  GER_VALS12 AS VALS12, ';
  strSQL := strSQL + '  GER_VALS13 AS VALS13, ';
  strSQL := strSQL + '  GER_VALS14 AS VALS14, ';
  strSQL := strSQL + '  GER_VALS15 AS VALS15, ';
  strSQL := strSQL + '  GER_VALS16 AS VALS16, ';
  strSQL := strSQL + '  GER_VALS17 AS VALS17, ';
  strSQL := strSQL + '  GER_VALS18 AS VALS18, ';
  strSQL := strSQL + '  GER_VALS19 AS VALS19, ';
  strSQL := strSQL + '  GER_VALS20 AS VALS20, ';
  strSQL := strSQL + '  GER_VALS21 AS VALS21, ';
  strSQL := strSQL + '  GER_VALS22 AS VALS22, ';
  strSQL := strSQL + '  GER_VALS23 AS VALS23, ';
  strSQL := strSQL + '  GER_VALS24 AS VALS24, ';
  strSQL := strSQL + '  GER_VALS25 AS VALS25, ';
  strSQL := strSQL + '  GER_VALS26 AS VALS26, ';
  strSQL := strSQL + '  GER_VALS27 AS VALS27, ';
  strSQL := strSQL + '  GER_VALS28 AS VALS28, ';
  strSQL := strSQL + '  GER_VALS29 AS VALS29, ';
  strSQL := strSQL + '  GER_VALS30 AS VALS30, ';

  strSQL := strSQL + '  GER_QTDS01 AS QTDS01, ';
  strSQL := strSQL + '  GER_QTDS02 AS QTDS02, ';
  strSQL := strSQL + '  GER_QTDS03 AS QTDS03, ';
  strSQL := strSQL + '  GER_QTDS04 AS QTDS04, ';
  strSQL := strSQL + '  GER_QTDS05 AS QTDS05, ';
  strSQL := strSQL + '  GER_QTDS06 AS QTDS06, ';
  strSQL := strSQL + '  GER_QTDS07 AS QTDS07, ';
  strSQL := strSQL + '  GER_QTDS08 AS QTDS08, ';
  strSQL := strSQL + '  GER_QTDS09 AS QTDS09, ';
  strSQL := strSQL + '  GER_QTDS10 AS QTDS10, ';
  strSQL := strSQL + '  GER_QTDS11 AS QTDS11, ';
  strSQL := strSQL + '  GER_QTDS12 AS QTDS12, ';
  strSQL := strSQL + '  GER_QTDS13 AS QTDS13, ';
  strSQL := strSQL + '  GER_QTDS14 AS QTDS14, ';
  strSQL := strSQL + '  GER_QTDS15 AS QTDS15, ';
  strSQL := strSQL + '  GER_QTDS16 AS QTDS16, ';
  strSQL := strSQL + '  GER_QTDS17 AS QTDS17, ';
  strSQL := strSQL + '  GER_QTDS18 AS QTDS18, ';
  strSQL := strSQL + '  GER_QTDS19 AS QTDS19, ';
  strSQL := strSQL + '  GER_QTDS20 AS QTDS20, ';
  strSQL := strSQL + '  GER_QTDS21 AS QTDS21, ';
  strSQL := strSQL + '  GER_QTDS22 AS QTDS22, ';
  strSQL := strSQL + '  GER_QTDS23 AS QTDS23, ';
  strSQL := strSQL + '  GER_QTDS24 AS QTDS24, ';
  strSQL := strSQL + '  GER_QTDS25 AS QTDS25, ';
  strSQL := strSQL + '  GER_QTDS26 AS QTDS26, ';
  strSQL := strSQL + '  GER_QTDS27 AS QTDS27, ';
  strSQL := strSQL + '  GER_QTDS28 AS QTDS28, ';
  strSQL := strSQL + '  GER_QTDS29 AS QTDS29, ';
  strSQL := strSQL + '  GER_QTDS30 AS QTDS30, ';

  strSQL := strSQL + '  GER_UNIS01 AS UNIS01, ';
  strSQL := strSQL + '  GER_UNIS02 AS UNIS02, ';
  strSQL := strSQL + '  GER_UNIS03 AS UNIS03, ';
  strSQL := strSQL + '  GER_UNIS04 AS UNIS04, ';
  strSQL := strSQL + '  GER_UNIS05 AS UNIS05, ';
  strSQL := strSQL + '  GER_UNIS06 AS UNIS06, ';
  strSQL := strSQL + '  GER_UNIS07 AS UNIS07, ';
  strSQL := strSQL + '  GER_UNIS08 AS UNIS08, ';
  strSQL := strSQL + '  GER_UNIS09 AS UNIS09, ';
  strSQL := strSQL + '  GER_UNIS10 AS UNIS10, ';
  strSQL := strSQL + '  GER_UNIS11 AS UNIS11, ';
  strSQL := strSQL + '  GER_UNIS12 AS UNIS12, ';
  strSQL := strSQL + '  GER_UNIS13 AS UNIS13, ';
  strSQL := strSQL + '  GER_UNIS14 AS UNIS14, ';
  strSQL := strSQL + '  GER_UNIS15 AS UNIS15, ';
  strSQL := strSQL + '  GER_UNIS16 AS UNIS16, ';
  strSQL := strSQL + '  GER_UNIS17 AS UNIS17, ';
  strSQL := strSQL + '  GER_UNIS18 AS UNIS18, ';
  strSQL := strSQL + '  GER_UNIS19 AS UNIS19, ';
  strSQL := strSQL + '  GER_UNIS20 AS UNIS20, ';
  strSQL := strSQL + '  GER_UNIS21 AS UNIS21, ';
  strSQL := strSQL + '  GER_UNIS22 AS UNIS22, ';
  strSQL := strSQL + '  GER_UNIS23 AS UNIS23, ';
  strSQL := strSQL + '  GER_UNIS24 AS UNIS24, ';
  strSQL := strSQL + '  GER_UNIS25 AS UNIS25, ';
  strSQL := strSQL + '  GER_UNIS26 AS UNIS26, ';
  strSQL := strSQL + '  GER_UNIS27 AS UNIS27, ';
  strSQL := strSQL + '  GER_UNIS28 AS UNIS28, ';
  strSQL := strSQL + '  GER_UNIS29 AS UNIS29, ';
  strSQL := strSQL + '  GER_UNIS30 AS UNIS30, ';

  strSQL := strSQL + '  GER_PARS01 AS PARS01, ';
  strSQL := strSQL + '  GER_PARS02 AS PARS02, ';
  strSQL := strSQL + '  GER_PARS03 AS PARS03, ';
  strSQL := strSQL + '  GER_PARS04 AS PARS04, ';
  strSQL := strSQL + '  GER_PARS05 AS PARS05, ';
  strSQL := strSQL + '  GER_PARS06 AS PARS06, ';
  strSQL := strSQL + '  GER_PARS07 AS PARS07, ';
  strSQL := strSQL + '  GER_PARS08 AS PARS08, ';
  strSQL := strSQL + '  GER_PARS09 AS PARS09, ';
  strSQL := strSQL + '  GER_PARS10 AS PARS10, ';
  strSQL := strSQL + '  GER_PARS11 AS PARS11, ';
  strSQL := strSQL + '  GER_PARS12 AS PARS12, ';
  strSQL := strSQL + '  GER_PARS13 AS PARS13, ';
  strSQL := strSQL + '  GER_PARS14 AS PARS14, ';
  strSQL := strSQL + '  GER_PARS15 AS PARS15, ';
  strSQL := strSQL + '  GER_PARS16 AS PARS16, ';
  strSQL := strSQL + '  GER_PARS17 AS PARS17, ';
  strSQL := strSQL + '  GER_PARS18 AS PARS18, ';
  strSQL := strSQL + '  GER_PARS19 AS PARS19, ';
  strSQL := strSQL + '  GER_PARS20 AS PARS20, ';
  strSQL := strSQL + '  GER_PARS21 AS PARS21, ';
  strSQL := strSQL + '  GER_PARS22 AS PARS22, ';
  strSQL := strSQL + '  GER_PARS23 AS PARS23, ';
  strSQL := strSQL + '  GER_PARS24 AS PARS24, ';
  strSQL := strSQL + '  GER_PARS25 AS PARS25, ';
  strSQL := strSQL + '  GER_PARS26 AS PARS26, ';
  strSQL := strSQL + '  GER_PARS27 AS PARS27, ';
  strSQL := strSQL + '  GER_PARS28 AS PARS28, ';
  strSQL := strSQL + '  GER_PARS29 AS PARS29, ';
  strSQL := strSQL + '  GER_PARS30 AS PARS30, ';

  strSQL := strSQL + '  GER_IDES01 AS IDES01, ';
  strSQL := strSQL + '  GER_IDES02 AS IDES02, ';
  strSQL := strSQL + '  GER_IDES03 AS IDES03, ';
  strSQL := strSQL + '  GER_IDES04 AS IDES04, ';
  strSQL := strSQL + '  GER_IDES05 AS IDES05, ';
  strSQL := strSQL + '  GER_IDES06 AS IDES06, ';
  strSQL := strSQL + '  GER_IDES07 AS IDES07, ';
  strSQL := strSQL + '  GER_IDES08 AS IDES08, ';
  strSQL := strSQL + '  GER_IDES09 AS IDES09, ';
  strSQL := strSQL + '  GER_IDES10 AS IDES10, ';
  strSQL := strSQL + '  GER_IDES11 AS IDES11, ';
  strSQL := strSQL + '  GER_IDES12 AS IDES12, ';
  strSQL := strSQL + '  GER_IDES13 AS IDES13, ';
  strSQL := strSQL + '  GER_IDES14 AS IDES14, ';
  strSQL := strSQL + '  GER_IDES15 AS IDES15, ';
  strSQL := strSQL + '  GER_IDES16 AS IDES16, ';
  strSQL := strSQL + '  GER_IDES17 AS IDES17, ';
  strSQL := strSQL + '  GER_IDES18 AS IDES18, ';
  strSQL := strSQL + '  GER_IDES19 AS IDES19, ';
  strSQL := strSQL + '  GER_IDES20 AS IDES20, ';
  strSQL := strSQL + '  GER_IDES21 AS IDES21, ';
  strSQL := strSQL + '  GER_IDES22 AS IDES22, ';
  strSQL := strSQL + '  GER_IDES23 AS IDES23, ';
  strSQL := strSQL + '  GER_IDES24 AS IDES24, ';
  strSQL := strSQL + '  GER_IDES25 AS IDES25, ';
  strSQL := strSQL + '  GER_IDES26 AS IDES26, ';
  strSQL := strSQL + '  GER_IDES27 AS IDES27, ';
  strSQL := strSQL + '  GER_IDES28 AS IDES28, ';
  strSQL := strSQL + '  GER_IDES29 AS IDES29, ';
  strSQL := strSQL + '  GER_IDES30 AS IDES30, ';

  strSQL := strSQL + '  DET_VALIPI AS TOTIPI, ';
  strSQL := strSQL + '  DET_ALQIPI AS ALQIPI, ';
  strSQL := strSQL + '  CONCAT(DET_NUM_PD, "-", DET_ESP_PD) AS DOCORI, ';

  strSQL := strSQL + '  IF(CONCAT(IFNULL((SELECT IF(IFNULL(CMP_NUMCMP,"") <> "", CONCAT(GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR ";"), ";"), "") ';
  strSQL := strSQL + '                   FROM NUMCMP ';
  strSQL := strSQL + '                  WHERE CMP_SEQGER = ' + fRetFatGorAutIncNumCmp('MOVDET') + ' ';
  strSQL := strSQL + '                    AND IFNULL(CMP_NUMCMP, "") <> ""), ""), ';
  strSQL := strSQL + '         IFNULL((SELECT GROUP_CONCAT(DISTINCT FDO_NUMCMP SEPARATOR ";") ';
  strSQL := strSQL + '                   FROM EXTDOR ';
  strSQL := strSQL + '                  WHERE FDO_SEQFDO IN (SELECT AUTOINCREM ';
  strSQL := strSQL + '                                         FROM FATDOR ';
  strSQL := strSQL + '                                        WHERE FDO_SEQGER = ' + fRetFatGorAutIncNumCmp('MOVDET') + ') ';
  strSQL := strSQL + '                    AND IFNULL(FDO_NUMCMP, "") <> ""), "")) = "", IFNULL(TR.DET_NUMCMP, ""), CONCAT(IFNULL((SELECT IF(IFNULL(CMP_NUMCMP,"") <> "", CONCAT(GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR ";"), ";"), "") ';
  strSQL := strSQL + '                   FROM NUMCMP ';
  strSQL := strSQL + '                  WHERE CMP_SEQGER = ' + fRetFatGorAutIncNumCmp('MOVDET') + ' ';
  strSQL := strSQL + '                    AND IFNULL(CMP_NUMCMP, "") <> ""), ""), ';
  strSQL := strSQL + '         IFNULL((SELECT GROUP_CONCAT(DISTINCT FDO_NUMCMP SEPARATOR ";") ';
  strSQL := strSQL + '                   FROM EXTDOR ';
  strSQL := strSQL + '                  WHERE FDO_SEQFDO IN (SELECT AUTOINCREM ';
  strSQL := strSQL + '                                         FROM FATDOR ';
  strSQL := strSQL + '                                        WHERE FDO_SEQGER = ' + fRetFatGorAutIncNumCmp('MOVDET') + ') ';
  strSQL := strSQL + '                    AND IFNULL(FDO_NUMCMP, "") <> ""), ""))) AS NUMCMP, ';

  strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF + DET_VALIPI), DET_TOTITE - DET_DESESP - DET_DESCFF + DET_VALIPI) AS TOTGER, ';

  strSQL := strSQL + '  OPE_NOMOPE AS VENDED, ';
  strSQL := strSQL + '  OPE_CODOPE AS CODVEN, ';
  strSQL := strSQL + '  DET_CONPAG AS CNDPAG, ';
  strSQL := strSQL + '  DET_CODCND AS CNDCOD, ';
  strSQL := strSQL + '  DET_PERCOM AS PERCOM, ';
  strSQL := strSQL + '  G.GER_MEN001 AS MEN001, ';
  strSQL := strSQL + '  G.GER_MEN002 AS MEN002, ';
  strSQL := strSQL + '  CONCAT(G.GER_CODTRA,"-",TRA_NOMTRA) AS TRANSP, ';
  strSQL := strSQL + '  (SELECT IF(IFNULL(R.GER_NOMREC, "") = "", " ", R.GER_NOMREC) FROM ROMGERX R WHERE R.GER_NUMDOC = G.GER_NUMDOC AND ';
  strSQL := strSQL + '                                            R.GER_ESPDOC = G.GER_ESPDOC AND ';
  strSQL := strSQL + '                                            R.GER_CODEMP = G.GER_CODEMP AND ';
  strSQL := strSQL + '                                            R.GER_CODCLI = G.GER_CODCLI AND ';
  strSQL := strSQL + '                                            IFNULL(R.GER_SERIE_, "") = IFNULL(G.GER_SERIE_, "") LIMIT 1) AS NOMREC, ';
  strSQL := strSQL + '  CONCAT(DET_CODDIV, "-", ';
  strSQL := strSQL + '         (SELECT DIV_NOMDIV FROM CADDIV WHERE DIV_CODDIV = DET_CODDIV)) AS NOMDIV, ';
  strSQL := strSQL + '  "MOVGER"     AS TABELA, ';
  strSQL := strSQL + '  G.AUTOINCREM AS AUTINC  ';

  If (blnMosVenMtl) Then Begin
    strSQL := strSQL + ', MD.DET_QTDPEC AS QTDPEC ';
    strSQL := strSQL + ', MD.DET_COMPEC AS COMPEC ';
  End;

  strSQL := strSQL + '     ,DET_TOTFRE AS TOTFRE  ';
  strSQL := strSQL + '     ,DET_DESACE AS DESACE  ';
  strSQL := strSQL + '     ,DET_VALRET AS VALRET  ';
  strSQL := strSQL + '  ,TR.DET_VFCPST AS VFCPST  ';
  strSQL := strSQL + '     ,DET_VLRCON AS VLRCON  ';
  strSQL := strSQL + '     ,DET_TABPRE AS TABPRE  ';
  strSQL := strSQL + '     ,G.GER_TIPFRE AS TIPFRE  ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCLI ';
  strSQL := strSQL + '  JOIN MOVDET   ON IF(IFNULL(DET_CLIFAT,"") = "", DET_CODCLI, DET_CLIFAT) = CLI_CODCLI ';
  strSQL := strSQL + '  JOIN MOVGER G ON G.AUTOINCREM = DET_SEQGER ';
  strSQL := strSQL + '  JOIN CADITE   ON DET_CODITE = ITE_CODITE ';
  strSQL := strSQL + '  JOIN CADMAR   ON ITE_CODMAR = MAR_CODMAR ';
  strSQL := strSQL + '  JOIN CADOPE   ON DET_CODVEN = OPE_CODOPE ';
  strSQL := strSQL + '  LEFT JOIN CADTRA ON TRA_CODTRA = G.GER_CODTRA  ';
  strSQL := strSQL + '  LEFT JOIN AUXMOV    ON AUXMOV.AUX_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN SERMOV SV ON SV.GER_SEQGER     = G.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN CADEMP EP ON EP.EMP_CODEMP = MOVDET.DET_CODEMP ';
  strSQL := strSQL + '  LEFT JOIN CADCID CE ON CE.CID_CODCID = EP.EMP_CODCID     ';
  strSQL := strSQL + '  LEFT JOIN MOVTRI TR ON TR.DET_SEQGER = MOVDET.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN CADUNI UN ON ITE_CODUNI = UN.UNI_CODUNI ';

  If (blnMosVenMtl) Then
    strSQL := strSQL + ' LEFT JOIN MOVMAD MD ON MD.DET_SEQGER = MOVDET.AUTOINCREM ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  DET_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  DET_CODEMP = :CODEMP AND ';
  If Not fEmptyStr(strCodCli) Then
    strSQL := strSQL + '  DET_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';

  strSQL := strSQL + '  (LOCATE(DET_ESPDOC, "TM_ML_PR_RO_") <= 0) AND ';
  strSQL := strSQL + '  DET_PROEMB <> "S" AND ';
  strSQL := strSQL + '  DET_TIP_FC = "C" ';

  strSQL := strSQL + ' UNION ALL ' +  AnsiReplaceStr(
                                      AnsiReplaceStr(
                                      AnsiReplaceStr(strSQL, 'MOVDET', 'NOTDET'),
                                                             'MOVGER', 'NOTGER'),
                                                             'TR.DET_COMPLE AS COMPLE', '"" AS COMPLE');

  With QryRel Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL + ' ORDER BY DET_DTAENT ');

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;

    If Not fEmptyStr(strCodCli) Then
      ParamByName('CODCLI').AsString := strCodCli;

    Open;

    lblCliente.Caption := 'Cliente: ' + FieldByName('CODCLI').AsString + ' - ' +
      FieldByName('NOMCLI').AsString + ' Doc.: ' + FieldByName('NUMDOC').AsString;
  End;

  With cdsRel.qryQuery, SQL Do
  Begin
    cdsRel.Close;
    Close;
    Clear;
    Add(strSQL + ' ORDER BY DET_DTAENT' );
    cdsRel.pSetProvider;
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;

    If Not fEmptyStr(strCodCli) Then
      ParamByName('CODCLI').AsString := strCodCli;
    Open;
    pSetaClient(cdsRel.qryQuery);
    cdsRel.Open;

    For intContador := 1 To 30 Do
    Begin

      If Not (fEmptyStr(QryRel.FieldByName('DESS' + fStrZero(intContador, 2)).AsString)) Then
      With cdsRel Do
      Begin
        Insert;

        For intCampos := 0 To QryRel.FieldCount - 1 do
          Fields[intCampos].Value := QryRel.Fields[intCampos].Value;

        FieldByName('CODITE').AsString := QryRel.FieldByName('CODS' + fStrZero(intContador, 2)).AsString;
        FieldByName('DESCRI').AsString := QryRel.FieldByName('DESS' + fStrZero(intContador, 2)).AsString;
        FieldByName('QTDITE').AsFloat  := QryRel.FieldByName('QTDS' + fStrZero(intContador, 2)).AsFloat;
        FieldByName('VLRSUG').AsFloat  := QryRel.FieldByName('UNIS' + fStrZero(intContador, 2)).AsFloat;
        FieldByName('VLRPRA').AsFloat  := QryRel.FieldByName('UNIS' + fStrZero(intContador, 2)).AsFloat;
        FieldByName('UNITAR').AsFloat  := QryRel.FieldByName('UNIS' + fStrZero(intContador, 2)).AsFloat;

        FieldByName('TOTSUG').AsFloat  := QryRel.FieldByName('VALS' + fStrZero(intContador, 2)).AsFloat;
        FieldByName('TOTPRA').AsFloat  := QryRel.FieldByName('VALS' + fStrZero(intContador, 2)).AsFloat;
        FieldByName('TOTITE').AsFloat  := QryRel.FieldByName('VALS' + fStrZero(intContador, 2)).AsFloat;
        FieldByName('TOTCUS').AsFloat  := QryRel.FieldByName('VALS' + fStrZero(intContador, 2)).AsFloat;
        FieldByName('TOTGER').AsFloat  := QryRel.FieldByName('VALS' + fStrZero(intContador, 2)).AsFloat;
        FieldByName('TOTBRU').AsFloat  := QryRel.FieldByName('VALS' + fStrZero(intContador, 2)).AsFloat;

        Post;
      End;
    End;

    if cdsRel.Locate('CODITE', fCfgSis('ITESER'), []) Or cdsRel.Locate('CODITE', fCfgSis('SERTER'), []) Then
      cdsRel.Delete;
  End;

  dtsRelVenCli.Dataset := cdsRel;

end;

procedure TfrmRelFatVendasClienteF9.pMostrarServicos(strNumDoc, strEspDoc,
  strCodEmp, strTabela: String; blnSelDocumentosP: Boolean; strCodCli: String;
  blnRcxSelDocumento: Boolean);
  Var
    strSQL: String;
    strNroServ:String;
    intContServ: Integer;

    Function fRetFatGorAutIncNumCmp(strAlias: String): String;
    Begin
      Result := '';
      Result := Result + '(SELECT FDO_SEQGER FROM FATDOR WHERE TRUE';
      Result := Result + ' AND ' + strAlias + '.DET_NUMDOC = FDO_NUMFAT';
      Result := Result + ' AND ' + strAlias + '.DET_ESPDOC = FDO_TIPFAT';
      Result := Result + ' AND ' + strAlias + '.DET_CODEMP = FDO_EMPFAT';
      Result := Result + ' AND ' + strAlias + '.DET_CODCLI = FDO_CODCLI';
      Result := Result + ' AND ' + strAlias + '.DET_CODITE = FDO_CODITE';
      Result := Result + ' LIMIT 1)';
    End;
begin
  blnServicos      := True;
  blnSelDocumentos := blnSelDocumentosP;
  FRcxSelDocumento := blnRcxSelDocumento;

  strSQL := '';
  For intContServ := 1 To 30 Do
  Begin
    If intContServ > 1 Then
      strSQL := strSQL + ' UNION ';

    strNroServ := FormatFloat('00', intContServ);
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  "D" AS MARDES, ';
    strSQL := strSQL + '  CLI_CODCLI AS CODCLI, ';
    strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI, ';
    strSQL := strSQL + '  AUX_PLAVEI AS PLAVEI, ';
    strSQL := strSQL + '  AUX_KM_VEI AS KM_VEI, ';
    strSQL := strSQL + '  DET_DTAENT, ';
    strSQL := strSQL + '  DATE_FORMAT(DET_DTAENT,"%d/%m/%y") AS DTAENT, ';
    strSQL := strSQL + '  CONCAT(DET_NUMDOC,"-",DET_ESPDOC) AS NUMDOC, ';
    strSQL := strSQL + '  DET_NUMDOC AS DOCUME, ';
    strSQL := strSQL + '  DET_ESPDOC AS ESPDOC, ';
    strSQL := strSQL + '  DET_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  GER_CODS'+StrNroServ + ' AS CODITE, ';
    strSQL := strSQL + '  "" AS CODFAB,';
    strSQL := strSQL + '  DET_IDEPRO AS IDEPRO, ';
    strSQL := strSQL + '  DET_CODACA AS CODACA, ';
    strSQL := strSQL + '  IF(IFNULL(DET_CONPAG, "") = "", " ", DET_CONPAG) AS CNDFAT, ';
    strSQL := strSQL + '  "" AS DESMAR, ';
    strSQL := strSQL + '  GER_DESS'+StrNroServ + ' AS DESCRI, ';
    strSQL := strSQL + '  IF((LOCATE("ITEM ESPECIAL", ITE_DESITE) > 0) OR (DET_IDEPRO <> "NOR") OR (DET_PROACA = "S"), "D", "I") AS CONARQ, ';

    strSQL := strSQL + '  IF((LOCATE("ITEM ESPECIAL", ITE_DESITE) > 0) OR (DET_IDEPRO <> "NOR") OR (DET_PROACA = "S"), DET_REFERE, ITE_REFERE) AS REFERE, ';
    strSQL := strSQL + '  TR.DET_COMPLE AS COMPLE, ';
    strSQL := strSQL + '  DET_NUMLOT AS NUMLOT, ';

    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) < 5, -(DET_DESESP), DET_DESESP) AS DESESP, ';
    strSQL := strSQL + '  GER_UNIS'+StrNroServ + ' AS UNITAR, ';
    strSQL := strSQL + '  GER_QTDS'+StrNroServ + ' AS QTDITE, ';
    strSQL := strSQL + '  (GER_UNIS'+StrNroServ + ' * GER_QTDS'+StrNroServ + ') - GER_DECS'+StrNroServ + ' AS TOTITE, ';
    strSQL := strSQL + '  0.00 AS MAMKP4, ';
    strSQL := strSQL + '  0.00 AS TOTCUS, ';
    strSQL := strSQL + '  (GER_UNIS'+StrNroServ + ' * GER_QTDS'+StrNroServ + ') AS TOTBRU, ';
    strSQL := strSQL + '  GER_UNIS'+StrNroServ + ' AS VLRSUG, ';
    strSQL := strSQL + '  (((GER_UNIS'+StrNroServ + ' * GER_QTDS'+StrNroServ + ') - GER_DECS'+StrNroServ + ') / GER_QTDS'+StrNroServ + ') AS VLRPRA, ';
    strSQL := strSQL + '  (GER_UNIS'+StrNroServ + ' * GER_QTDS'+StrNroServ + ') AS TOTSUG, ';
    strSQL := strSQL + '  (GER_UNIS'+StrNroServ + ' * GER_QTDS'+StrNroServ + ' - GER_DECS'+StrNroServ + ') AS TOTPRA, ';
    strSQL := strSQL + '  GER_DECS'+StrNroServ + ' AS VLRDES, ';
    strSQL := strSQL + '  ROUND(GER_DECS'+StrNroServ + ' * 100 / (GER_UNIS'+StrNroServ + ' * GER_QTDS'+StrNroServ + '), 2) AS PERDES, ';
    strSQL := strSQL + '  0.00 AS MARGEM, ';

    strSQL := strSQL + '  0.00 AS TOTIPI, ';
    strSQL := strSQL + '  0.0 AS ALQIPI, ';
    strSQL := strSQL + '  CONCAT(DET_NUM_PD, "-", DET_ESP_PD) AS DOCORI, ';

    strSQL := strSQL + '  IF(CONCAT(IFNULL((SELECT IF(IFNULL(CMP_NUMCMP,"") <> "", CONCAT(GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR ";"), ";"), "") ';
    strSQL := strSQL + '                   FROM NUMCMP ';
    strSQL := strSQL + '                  WHERE CMP_SEQGER = ' + fRetFatGorAutIncNumCmp('MOVDET') + ' ';
    strSQL := strSQL + '                    AND IFNULL(CMP_NUMCMP, "") <> ""), ""), ';
    strSQL := strSQL + '         IFNULL((SELECT GROUP_CONCAT(DISTINCT FDO_NUMCMP SEPARATOR ";") ';
    strSQL := strSQL + '                   FROM EXTDOR ';
    strSQL := strSQL + '                  WHERE FDO_SEQFDO IN (SELECT AUTOINCREM ';
    strSQL := strSQL + '                                         FROM FATDOR ';
    strSQL := strSQL + '                                        WHERE FDO_SEQGER = ' + fRetFatGorAutIncNumCmp('MOVDET') + ') ';
    strSQL := strSQL + '                    AND IFNULL(FDO_NUMCMP, "") <> ""), "")) = "", IFNULL(TR.DET_NUMCMP, ""), CONCAT(IFNULL((SELECT IF(IFNULL(CMP_NUMCMP,"") <> "", CONCAT(GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR ";"), ";"), "") ';
    strSQL := strSQL + '                   FROM NUMCMP ';
    strSQL := strSQL + '                  WHERE CMP_SEQGER = ' + fRetFatGorAutIncNumCmp('MOVDET') + ' ';
    strSQL := strSQL + '                    AND IFNULL(CMP_NUMCMP, "") <> ""), ""), ';
    strSQL := strSQL + '         IFNULL((SELECT GROUP_CONCAT(DISTINCT FDO_NUMCMP SEPARATOR ";") ';
    strSQL := strSQL + '                   FROM EXTDOR ';
    strSQL := strSQL + '                  WHERE FDO_SEQFDO IN (SELECT AUTOINCREM ';
    strSQL := strSQL + '                                         FROM FATDOR ';
    strSQL := strSQL + '                                        WHERE FDO_SEQGER = ' + fRetFatGorAutIncNumCmp('MOVDET') + ') ';
    strSQL := strSQL + '                    AND IFNULL(FDO_NUMCMP, "") <> ""), ""))) AS NUMCMP, ';

    strSQL := strSQL + '  (GER_VALS'+StrNroServ + ' * GER_QTDS'+StrNroServ + ') - GER_DECS'+StrNroServ + ' AS TOTGER, ';

    strSQL := strSQL + '  OPE_NOMOPE AS VENDED, ';
    strSQL := strSQL + '  OPE_CODOPE AS CODVEN, ';
    strSQL := strSQL + '  DET_CONPAG AS CNDPAG, ';
    strSQL := strSQL + '  DET_CODCND AS CNDCOD, ';
    strSQL := strSQL + '  DET_PERCOM AS PERCOM, ';
    strSQL := strSQL + '  G.GER_MEN001 AS MEN001, ';
    strSQL := strSQL + '  G.GER_MEN002 AS MEN002, ';
    strSQL := strSQL + '  CONCAT(G.GER_CODTRA,"-",TRA_NOMTRA) AS TRANSP, ';
    strSQL := strSQL + '  (SELECT IF(IFNULL(R.GER_NOMREC, "") = "", " ", R.GER_NOMREC) FROM ROMGERX R WHERE R.GER_NUMDOC = G.GER_NUMDOC AND ';
    strSQL := strSQL + '                                            R.GER_ESPDOC = G.GER_ESPDOC AND ';
    strSQL := strSQL + '                                            R.GER_CODEMP = G.GER_CODEMP AND ';
    strSQL := strSQL + '                                            R.GER_CODCLI = G.GER_CODCLI AND ';
    strSQL := strSQL + '                                            IFNULL(R.GER_SERIE_, "") = IFNULL(G.GER_SERIE_, "") LIMIT 1) AS NOMREC, ';
    strSQL := strSQL + '  CONCAT(DET_CODDIV, "-", ';
    strSQL := strSQL + '         (SELECT DIV_NOMDIV FROM CADDIV WHERE DIV_CODDIV = DET_CODDIV)) AS NOMDIV, ';
    strSQL := strSQL + '  "MOVGER"     AS TABELA, ';
    strSQL := strSQL + '  G.AUTOINCREM AS AUTINC  ';

    If (blnMosVenMtl) Then Begin
      strSQL := strSQL + ', MD.DET_QTDPEC AS QTDPEC ';
      strSQL := strSQL + ', MD.DET_COMPEC AS COMPEC ';
    End;

    strSQL := strSQL + '     ,DET_TOTFRE AS TOTFRE  ';
    strSQL := strSQL + '     ,DET_DESACE AS DESACE  ';
    strSQL := strSQL + '     ,DET_VALRET AS VALRET  ';
    strSQL := strSQL + '  ,TR.DET_VFCPST AS VFCPST  ';
    strSQL := strSQL + '     ,DET_VLRCON AS VLRCON  ';
    strSQL := strSQL + '     ,DET_TABPRE AS TABPRE  ';
    strSQL := strSQL + '     ,G.GER_TIPFRE AS TIPFRE  ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCLI ';
    strSQL := strSQL + '  JOIN MOVDET   ON IF(IFNULL(DET_CLIFAT,"") = "", DET_CODCLI, DET_CLIFAT) = CLI_CODCLI ';
    strSQL := strSQL + '  JOIN MOVGER G ON G.AUTOINCREM = DET_SEQGER ';
    strSQL := strSQL + '  JOIN CADITE   ON DET_CODITE = ITE_CODITE ';
    strSQL := strSQL + '  JOIN CADMAR   ON ITE_CODMAR = MAR_CODMAR ';
    strSQL := strSQL + '  JOIN CADOPE   ON DET_CODVEN = OPE_CODOPE ';
    strSQL := strSQL + '  LEFT JOIN CADTRA ON TRA_CODTRA = G.GER_CODTRA  ';
    strSQL := strSQL + '  LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = G.AUTOINCREM ';
    strSQL := strSQL + '  LEFT JOIN SERMOV ON SERMOV.GER_SEQGER = G.AUTOINCREM ';
    strSQL := strSQL + '  LEFT JOIN CADEMP EP ON EP.EMP_CODEMP = MOVDET.DET_CODEMP ';
    strSQL := strSQL + '  LEFT JOIN CADCID CE ON CE.CID_CODCID = EP.EMP_CODCID     ';
    strSQL := strSQL + '  LEFT JOIN MOVTRI TR ON TR.DET_SEQGER = MOVDET.AUTOINCREM ';

    If (blnMosVenMtl) Then
      strSQL := strSQL + ' LEFT JOIN MOVMAD MD ON MD.DET_SEQGER = MOVDET.AUTOINCREM ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  DET_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  DET_CODEMP = :CODEMP AND ';
    If Not fEmptyStr(strCodCli) Then
      strSQL := strSQL + '  DET_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';

    strSQL := strSQL + '  (LOCATE(DET_ESPDOC, "TM_ML_PR_RO_") <= 0) AND ';
    strSQL := strSQL + '  DET_PROEMB <> "S" AND ';
    strSQL := strSQL + '  DET_TIP_FC = "C" ';
    strSQL := strSQL + '  AND GER_VALS'+StrNroServ + ' > 0 ';
  End;

  If strTabela = 'NOTGER' Then
    strSQL := AnsiReplaceStr(
              AnsiReplaceStr(
              AnsiReplaceStr(
              AnsiReplaceStr(strSQL, 'MOVDET', 'NOTDET'),
                                     'MOVGER', 'NOTGER'),
                                     'SERMOV', 'SERNOT'),
                                     'TR.DET_COMPLE AS COMPLE', '"" AS COMPLE');

  With QryRel Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL + ' ORDER BY DET_DTAENT ');

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;

    If Not fEmptyStr(strCodCli) Then
      ParamByName('CODCLI').AsString := strCodCli;

    Open;

    lblCliente.Caption := 'Cliente: ' + FieldByName('CODCLI').AsString + ' - ' +
      FieldByName('NOMCLI').AsString + ' Doc.: ' + FieldByName('NUMDOC').AsString;
  End;

  dtsRelVenCli.Dataset := QryRel;
end;

procedure TfrmRelFatVendasClienteF9.pSetaFormatoMonetario(DataSet: TDataSet;
  strFieldName: String; blnDecUni: Boolean = False);
begin
  If (Assigned(DataSet)) And
     (DataSet.Active) And
     (DataSet.FindField(strFieldName) <> Nil) Then
  Begin
    if not blnDecUni then
      (DataSet.FieldByName(strFieldName) As TFloatField).DisplayFormat := '#,##0.00'
    else
      (DataSet.FieldByName(strFieldName) As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  End;
end;

procedure TfrmRelFatVendasClienteF9.pSetaVisibilidadeColuna(
  strFieldName: String; blnVisivel: Boolean);
begin
  dbgItensDBTableView1.GetColumnByFieldName(strFieldName).Visible := blnVisivel;
end;

procedure TfrmRelFatVendasClienteF9.btnConfirmarClick(Sender: TObject);
var
  intRecNo: Integer;
  evnAfterScroll: TDataSetNotifyEvent;
  blnManterPreco: Boolean;
  intOpcao: Integer;
  blnInseriuTodos: Boolean;
begin
  inherited;
  blnManterPreco := fMensagem('ATENÇÃO', 'Deseja manter os preços das vendas selecionadas ou carregar os preços de tabela atuais?', ['Vendas sel.', 'Tabela atual']) = 1;
  blnInseriuTodos := True;

  With dtsRelVenCli.DataSet Do
  Begin
    intRecNo := RecNo;
    evnAfterScroll := AfterScroll;
    AfterScroll := nil;
    DisableControls;
    Try
      First;
      While Not Eof Do
      Begin
        If (FieldByName('MARDES').AsString = 'M') Then
        Begin
          If fIncluirItem(FieldByName('CODITE').AsString,
                          '',
                          FieldByName('QTDITE').AsFloat,
                          IIF(blnManterPreco, FieldByName('VLRPRA').AsFloat, 0.0),
                          '',
                          '',
                          '',
                          0,
                          '',
                          False,
                          '',
                          '',
                          FieldByName('ENTRET').AsString) Then
          Begin
            pMarca(False);
          End
          Else
          Begin
            intOpcao := fMensagem('ATENÇÃO', 'Não foi possível inserir o item ' +
                                             FieldByName('CODITE').AsString + ' - ' +
                                             FieldByName('DESCRI').AsString +
                                             '. O que deseja fazer? Tentar novamente, ignorar e ir para o próximo ou cancelar todos os próximos?',
                                  ['Tentar', 'Ignorar', 'Cancelar']);

            if intOpcao <> 1 Then
              blnInseriuTodos := False;

            Case intOpcao Of
              1: Continue;
              3: Break;
            End;
          End;
        End;

        Next;
      End;

      If blnInseriuTodos Then
        ModalResult := mrOk;

    Finally
      RecNo := intRecNo;
      AfterScroll := evnAfterScroll;
      EnableControls;
    End;
  End;
end;

procedure TfrmRelFatVendasClienteF9.btnMarDesTodosClick(Sender: TObject);
begin
  inherited;
  If btnMarDesTodos.Caption = '[F7] Marcar Todos' Then
  Begin
    pMarcarTodos(True);
    btnMarDesTodos.Caption := '[F7] Desmarcar Todos';
  End
  Else
  Begin
    pMarcarTodos(False);
    btnMarDesTodos.Caption := '[F7] Marcar Todos';
  End;
end;

procedure TfrmRelFatVendasClienteF9.btnPesquisarMecanicoClick(Sender: TObject);
begin

  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(173, 7375, [],
                        ['SEQDET'],
                        [dtsRelVenCli.DataSet.FieldByName('SEQDET').AsString],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmRelFatVendasClienteF9.dbgItensDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strValor: String;
begin
  inherited;
  If blnMostraDebCtrChq2 Then
    If(AViewInfo.Item.DataBinding.FilterFieldName = 'TOTPRA') Or
      (AViewInfo.Item.DataBinding.FilterFieldName = 'VLRDES') Or
      (AViewInfo.Item.DataBinding.FilterFieldName = 'DESACE') Or
      (AViewInfo.Item.DataBinding.FilterFieldName = 'VALRET') Or
      (AViewInfo.Item.DataBinding.FilterFieldName = 'VFCPST') Or
      (AViewInfo.Item.DataBinding.FilterFieldName = 'TOTIPI') Or
      (AViewInfo.Item.DataBinding.FilterFieldName = 'VLRCON') Or
      (AViewInfo.Item.DataBinding.FilterFieldName = 'TOTFRE') Then
    Begin
      ACanvas.Brush.Color:= clMoneyGreen;
    End;

  if blnMosPromoc then
  Begin
    strValor := VarAsType(dbgItensDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[PROMOC.Index], varString);
    if strValor = 'S' then
      ACanvas.Font.Color := clTeal;
  End;

  If Assigned(fIncluirItem) Then
  Begin
    If fEhItemServico(AViewInfo.GridRecord.Values[CODITE.Index]) Or
       (AViewInfo.GridRecord.Values[IDEPRO.Index] <> 'NOR') Or
       (AViewInfo.GridRecord.Values[CODACA.Index] <> NULL) Then
      ACanvas.Font.Color := clRed
    Else If AViewInfo.GridRecord.Values[MARDES.Index] = 'M' Then
      ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmRelFatVendasClienteF9.dbgItensDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Shift = []) And (Key = VK_RETURN) And Assigned(fIncluirItem) Then
  Begin
    If fEhItemServico(dtsRelVenCli.DataSet.FieldByName('CODITE').AsString) Then
      pMensagemOk('Não é permitido selecionar itens de serviço!')
    Else If (dtsRelVenCli.DataSet.FieldByName('IDEPRO').AsString <> 'NOR') Then
      pMensagemOk('Não é permitido selecionar itens tinta de máquina!')
    Else If (Not dtsRelVenCli.DataSet.FieldByName('CODACA').IsNull) Then
      pMensagemOk('Não é permitido selecionar itens que são produtos acabados!')
    Else
      pMarca(dtsRelVenCli.DataSet.FieldByName('MARDES').AsString = 'D');
  End;
end;

function TfrmRelFatVendasClienteF9.fAjustandoTela(pgbStatus: TcxProgressBar): Boolean;
  Var
    strFilter: String;
    blnFiltered: Boolean;
begin
  Result := True;

  pInfoStatusGravacao(pgbStatus, 'Aguarde, Ajustando colunas para exibição...', 0);

  strFilter := dtsRelVenCli.DataSet.Filter;
  blnFiltered:= dtsRelVenCli.DataSet.Filtered;
  Try
    If dtsRelVenCli.DataSet.FindField('AUTINC') <> Nil Then
    Begin
      dtsRelVenCli.DataSet.Filtered := False;
      dtsRelVenCli.DataSet.Filter := 'AUTINC = ' + QuotedStr(dtsRelVenCli.DataSet.FieldByName('AUTINC').AsString);
      dtsRelVenCli.DataSet.Filtered := True;
    End;

    pSetaFormatoMonetario(dtsRelVenCli.DataSet, 'VLRSUG');
    pSetaFormatoMonetario(dtsRelVenCli.DataSet, 'VLRPRA');
    pSetaFormatoMonetario(dtsRelVenCli.DataSet, 'TOTSUG');
    pSetaFormatoMonetario(dtsRelVenCli.DataSet, 'TOTPRA');
    pSetaFormatoMonetario(dtsRelVenCli.DataSet, 'VLRDES');
    pSetaFormatoMonetario(dtsRelVenCli.DataSet, 'QTDITE');
    pSetaFormatoMonetario(dtsRelVenCli.DataSet, 'UNITAR', True);
    pSetaFormatoMonetario(dtsRelVenCli.DataSet, 'TOTCUS');
    pSetaFormatoMonetario(dtsRelVenCli.DataSet, 'MARGEM');
    pSetaFormatoMonetario(dtsRelVenCli.DataSet, 'TOTIPI');
    pSetaFormatoMonetario(dtsRelVenCli.DataSet, 'ALQIPI');
    pSetaFormatoMonetario(dtsRelVenCli.DataSet, 'PERDES');

    pSetaFormatoMonetario(dtsRelVenCli.DataSet, 'TOTFRE');
    pSetaFormatoMonetario(dtsRelVenCli.DataSet, 'DESACE');
    pSetaFormatoMonetario(dtsRelVenCli.DataSet, 'VALRET');
    pSetaFormatoMonetario(dtsRelVenCli.DataSet, 'VFCPST');
    pSetaFormatoMonetario(dtsRelVenCli.DataSet, 'VLRCON');

    If (Not fCfgSis('MARFAT', varBoolean)) Or (Not blnSelDocumentos) Or (blnServicos) Then
    Begin
      dtsRelVenCli.DataSet.FieldByName('TOTCUS').Visible := False;
      dtsRelVenCli.DataSet.FieldByName('MARGEM').Visible := False;
      pSetaVisibilidadeColuna('TOTCUS', False);
      pSetaVisibilidadeColuna('MARGEM', False);
      lblTitCusto.Visible  := False;
      lblTitMar.Visible := False;
      edtCusto.Visible  := False;
      edtMargem.Visible := False;
    End;

    dtsRelVenCli.DataSet.FieldByName('REFERE').Visible := blnExibirReferenciaUnidade;
    pSetaVisibilidadeColuna('REFERE', blnExibirReferenciaUnidade);
    dtsRelVenCli.DataSet.FieldByName('UNIDAD').Visible := blnExibirReferenciaUnidade;
    pSetaVisibilidadeColuna('UNIDAD', blnExibirReferenciaUnidade);

    If Not fCfgSis('IMPREF', varBoolean) Or (blnServicos) Then
    Begin
      dtsRelVenCli.DataSet.FieldByName('REFERE').Visible := False;
      pSetaVisibilidadeColuna('REFERE', False);
    End;

    pnlStatPromoc.Visible        := blnMosPromoc;

    pnlVendedor.Visible          := Not blnVeioDoTablet;
    pnlRecebido.Visible          := Not blnVeioDoTablet;
    pnlFornecedor.Visible        := (Not blnVeioDoTablet) And (Not fCfgSis('OCUFOR', varBoolean));
    pnlProfissional.Visible      := Not blnVeioDoTablet;

    pSetaVisibilidadeColuna('ALQIPI', Not blnVeioDoTablet);
    pSetaVisibilidadeColuna('TOTIPI', Not blnVeioDoTablet);
    pSetaVisibilidadeColuna('DESCRI', Not blnVeioDoTablet);
    pSetaVisibilidadeColuna('NOMCLI', edtCliente.Visible);

    If blnServicos Then
    Begin
      dtsRelVenCli.DataSet.FieldByName('TOTIPI').Visible := False;
      pSetaVisibilidadeColuna('TOTIPI', False);
      dtsRelVenCli.DataSet.FieldByName('ALQIPI').Visible := False;
      pSetaVisibilidadeColuna('ALQIPI', False);
      lblTotalIPI.Visible := False;
      edtTotIpi.Visible   := False;
      lblTotFcpSt.Visible := False;
      edtTotFcpSt.Visible := False;
      lblTotST.Visible := False;
      edtTotST.Visible := False;
    End;

  Finally
    If blnFiltered Then
    Begin
      dtsRelVenCli.DataSet.Filtered := False;
      dtsRelVenCli.DataSet.Filter := strFilter;
      dtsRelVenCli.DataSet.Filtered := True;
    End
    Else
    Begin
      If dtsRelVenCli.DataSet.Filtered Then
      Begin
        dtsRelVenCli.DataSet.Filtered := False;
        dtsRelVenCli.DataSet.Filter := '';
      End;
    End;
  End;

  pAtualizaDados(Nil);
  dtsRelVenCli.DataSet.AfterScroll := pAtualizaDados;

  If Not fCfgSis('USACND', varBoolean) Then
  Begin
    edtCodCnd.Visible := False;
    edtCndPgto.Left   := edtCodCnd.Left;
    edtCndPgto.Width  := edtCndPgto.Width + edtCodCnd.Width + 1;
  End;

  If (Assigned(frmRelFatVendasCliente)) And (frmRelFatVendasCliente.blnFaturamento) Then
  Begin
    Self.Caption := 'Movimentação de Clientes';

    If (Not blnSelDocumentos) Or blnVeioDoTelemarketing Then
    Begin
      lblCliente.Caption := 'Cliente: ' + dtsRelVenCli.DataSet.FieldByName('CODCLI').AsString + '-' +
                                          dtsRelVenCli.DataSet.FieldByName('NOMCLI').AsString;
    End;

    If Not fEmptyStr(strCodRedeLojasCliente) Then
        lblCliente.Caption := 'Rede de Lojas: ' + strCodRedeLojasCliente + ' - ' + fRetNomeRedeLoja(strCodRedeLojasCliente);

    {******************************************************}
    {* CONFIGURA AS COLUNAS Q SÃO VARIÁVEIS DE ACORDO COM *}
    {* A CHAMADA QUE FOI FEITA                            *}
    {**************************************************ER**}
    dbgItensDBTableView1.GetColumnByFieldName('CODITE').Caption := 'Item';
    dbgItensDBTableView1.GetColumnByFieldName('CODITE').DataBinding.FieldName := 'CODITE';
    dbgItensDBTableView1.GetColumnByFieldName('DESCRI').Caption := 'Descrição';
    dbgItensDBTableView1.GetColumnByFieldName('DESCRI').DataBinding.FieldName := 'DESCRI';
  End
  Else If (Assigned(frmRelFatVendasCliente)) And (frmRelFatVendasCliente.blnConsultaItem) Then
  Begin
    Self.Caption := 'Itens Vendidos';

    If Not blnSelDocumentos Then
      lblCliente.Caption := 'Produto: ' + dtsRelVenCli.DataSet.FieldByName('CODITE').AsString + '-' +
        dtsRelVenCli.DataSet.FieldByName('DESCRI').AsString;

    {******************************************************}
    {* CONFIGURA AS COLUNAS Q SÃO VARIÁVEIS DE ACORDO COM *}
    {* A CHAMADA QUE FOI FEITA                            *}
    {**************************************************ER**}
    dbgItensDBTableView1.GetColumnByFieldName('CODITE').Caption := 'Cliente';
    dbgItensDBTableView1.GetColumnByFieldName('CODITE').DataBinding.FieldName := 'CODCLI';
    dbgItensDBTableView1.GetColumnByFieldName('DESCRI').Caption := 'Nome';
    dbgItensDBTableView1.GetColumnByFieldName('DESCRI').DataBinding.FieldName := 'NOMCLI';
  End;

  lblPerCom.Visible := blnMosCom and fVerificaAcessoSistema('EPCTMC'); // Req. 109827
  edtPerCom.Visible := lblPerCom.Visible;

  If blnVeioDoTablet Then
  Begin
    Self.Height       := 500;
    Self.Width        := 620;
    edtDesItem.Width  := 470;
    edtMens001.Width  := 470;
    edtMens002.Width  := 470;
    edtFormas.Width   := 470;
    edtDesMarca.Width := 252;
    edtTransp.Width   := 170;
    edtCndPgto.Width  := 188;
    lblCndPag.Left    := 307;
    edtCodCnd.Left    := 382;
    edtCndPgto.Left   := 413;
  End;

  If ((fCfgSis('RCXBRU', VarBoolean)) And (FRcxSelDocumento)) Then
  Begin
    lblVlrDes.Visible := False;
    edtVlrDes.Visible := False;
  End
  Else
    pnlTotaisRcxBru.Visible := False;

  If (Not edtCusto.Visible)  And
     (Not edtMargem.Visible) Then
    pnlTotais3.Visible := False;

  pnlPlacaMecanico.Visible     := (fCfgSis('AUTCEN', varBoolean));
  btnPesquisarMecanico.Visible := (fCfgSis('AUTCEN', varBoolean));

  lblQtdPec.Visible := blnMosVenMtl;
  edtQtdPec.Visible := blnMosVenMtl;
  edtComPec.Visible := blnMosVenMtl;

  dtsRelVenCli.DataSet.AfterScroll(dtsRelVenCli.DataSet);
  dbgItensDBTableView1.ApplyBestFit;

  btnConfirmar.Visible    := Assigned(fIncluirItem);
  btnMarDesTodos.Visible  := Assigned(fIncluirItem);
  shpSelecionados.Visible := Assigned(fIncluirItem);
  lblSelecionados.Visible := Assigned(fIncluirItem);
  shpItensServico.Visible := Assigned(fIncluirItem);
  lblItensServico.Visible := Assigned(fIncluirItem);
end;

function TfrmRelFatVendasClienteF9.fAtualizaTotal(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    fltValIte: Double;
    fltValMkp: Double;
    fltTotCus: Double;
    fltDesEsp: Double;
    fltTotIpi: Double;
    fltVTotal: Double;
    fltQtdDoc: Double;
    fltTotBru: Double;
    blnMarFat: Boolean;
    strNumDoc: String;
    strMarMkp: String;
    fltVlrDes: Double;
    prcScroll: TprcScroll;
    fltDesAce: Double;
    fltValRet: Double;
    fltVfcPst: Double;
    fltVlrCon: Double;
    fltTotFre: Double;
Begin
  Result := True;

  pInfoStatusGravacao(pgbStatus, 'Aguarde, Realizando totalizações...', dtsRelVenCli.DataSet.RecordCount);
  Try
    fltValIte := 0;
    fltValMkp := 0;
    fltDesEsp := 0;
    fltTotCus := 0;
    fltTotIpi := 0;
    fltVTotal := 0;
    fltQtdDoc := 0;
    fltTotBru := 0;
    fltVlrDes := 0;
    blnMarFat := fCfgSis('MARFAT', varBoolean);
    strMarMkp := fCfgSis('MARMKP');
    fltDesAce := 0;
    fltValRet := 0;
    fltTotFre := 0;
    fltVfcPst := 0;
    fltVlrCon := 0;

    With dtsRelVenCli.DataSet Do
    Begin
      pDisableControls(dtsRelVenCli.DataSet, prcScroll);
      Try
        While Not Eof Do
        Begin
          pStepStatusGravacao(pgbStatus);

          fltValIte := fltValIte + FieldByName('TOTITE').AsFloat;
          fltValMkp := fltValMkp + FieldByName('MAMKP4').AsFloat;
          fltDesEsp := fltDesEsp + Abs(FieldByName('DESESP').AsFloat);
          fltTotCus := fltTotCus + FieldByName('TOTCUS').AsFloat;
          fltTotIpi := fltTotIpi + FieldByName('TOTIPI').AsFloat;
          fltVTotal := fltVTotal + FieldByName('TOTGER').AsFloat;
          fltTotBru := fltTotBru + FieldByName('TOTBRU').AsFloat;

          fltDesAce := fltDesAce + FieldByName('DESACE').AsFloat;
          fltValRet := fltValRet + FieldByName('VALRET').AsFloat;
          fltTotFre := fltTotFre + FieldByName('TOTFRE').AsFloat;
          fltVfcPst := fltVfcPst + FieldByName('VFCPST').AsFloat;
          fltVlrCon := fltVlrCon + FieldByName('VLRCON').AsFloat;

          If (FindField('VLRDES') <> Nil) Then
            fltVlrDes := fltVlrDes + FieldByName('VLRDES').AsFloat;

          If (strNumDoc <> FieldByName('NUMDOC').AsString) Then
            fltQtdDoc := fltQtdDoc + 1;

          strNumDoc := FieldByName('NUMDOC').AsString;

          If (blnMarFat) And (blnSelDocumentos) Then
          Begin
            Edit;
            If strMarMkp = '4' Then
              FieldByName('MARGEM').AsFloat  := fCalculaPrecoVenda(2, FieldByName('TOTCUS').AsFloat,
                                                                   FieldByName('MAMKP4').AsFloat,
                                                                   0,0,0,0,0,strMarMkp)
            Else
              FieldByName('MARGEM').AsFloat  := fCalculaPrecoVenda(2, FieldByName('TOTCUS').AsFloat,
                                                                   FieldByName('TOTITE').AsFloat,
                                                                   0,0,0,0,0,strMarMkp);
            Post;
          End;

          Next;
        End;
      Finally
        pEnableControls(dtsRelVenCli.DataSet, prcScroll);
        First;
      End;

      If fCfgSis('RCXBRU', VarBoolean) And FRcxSelDocumento Then
      Begin
        edtVrBruto.Text    := FormatFloat('#,##0.00', fltTotBru);
        edtVrLiquido.Text  := FormatFloat('#,##0.00', fltValIte);
        edtVrDesconto.Text := FormatFloat('#,##0.00', fStrToFloat(edtVrBruto.Text) - fStrToFloat(edtVrLiquido.Text));
      End;

      {************************************}
      {* VERIFICA SE VAI APARECER O TOTAL *}
      {* DE MARGEM                        *}
      {*********************************AF*}
      If (blnMarFat) And (blnSelDocumentos) Then
      Begin
        lblTitMar.Visible := True;
        edtMargem.Visible := True;
        {*************************************}
        {* VALITE JA ESTA SUBTRAIDO O DESESP *}
        {**********************************AF*}
        If strMarMkp = '4' Then
        Begin
          edtMargem.Text := FloatToStrF(fCalculaPrecoVenda(2,fltTotCus,fltValMkp,0,0,0,0,0),ffFixed,12,2);
        End
        Else
        Begin
          edtMargem.Text := FloatToStrF(fCalculaPrecoVenda(2,fltTotCus,fltValIte,0,0,0,0,0),ffFixed,12,2);
        End;
      End
      Else
      Begin
        lblTitMar.Visible := False;
        edtMargem.Visible := False;
      End;

      edtValTot.Text  := FloatToStrF(fltVTotal, ffFixed, 12, 2);
      edtTotIte.Text  := FloatToStrF(fltValIte,ffFixed,12,2);
      edtVlrIte.Text  := FloatToStrF(fltValIte,ffFixed,12,2);

      edtCusto.Text   := FloatToStrF(fltTotCus,ffFixed,12,2);
      edtTotIpi.Text  := FloatToStrF(fltTotIpi,ffFixed,12,2);
      edtTotFcpSt.Text  := FloatToStrF(fltVfcPst, ffFixed, 12, 2);
      edtTotST.Text  := FloatToStrF(fltValRet, ffFixed, 12, 2);
      edtTotFre.Text := FloatToStrF(fltTotFre, ffFixed, 12, 2);
      edtTotContabil.Text  := FloatToStrF(fltVlrCon, ffFixed, 12, 2);
      edtVlrIpi.Text  := FloatToStrF(fltTotIpi,ffFixed,12,2);
      edtQtdDoc.Text  := FormatFloat('#,##0',fltQtdDoc);
      edtVlrDes.Text  := FloatToStrF(fltVlrDes, ffFixed, 12, 2);
      edtVlrDesc.Text  := FloatToStrF(fltVlrDes, ffFixed, 12, 2);

      edtDesAce.Text  := FloatToStrF(fltDesAce,ffFixed,12,2);
      edtVlrST.Text   := FloatToStrF(fltValRet,ffFixed,12,2);
      edtVlrFcp.Text  := FloatToStrF(fltVfcPst,ffFixed,12,2);
      edtVlrCon.Text  := FloatToStrF(fltVlrCon,ffFixed,12,2);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pAtualizaTotal]');
  End;
end;

class function TfrmRelFatVendasClienteF9.fColunasRelFatVendasClienteF9: String;

  function fVlrPra: String;
  begin
    Result := ' ROUND(((DET_TOTITE - DET_DESESP - DET_DESCFF)/DET_QTDITE),2) ';
  end;

  function fVlrSug: String;
  begin
    Result := ' IF(' + fVlrPra + ' > DET_UNIORI, ' + fVlrPra + ', DET_UNIORI) ';
  end;

  function fTotSug: String;
  begin
    Result := ' IF(' + fVlrPra + ' > DET_UNIORI, DET_TOTITE - DET_DESESP - DET_DESCFF, DET_UNIORI * DET_QTDITE) ';
  end;

  function fVlrDes: String;
  begin
    Result := '  IF(LEFT(DET_CLAFIS,1) < 5, -(' + fTotSug + ' - (DET_TOTITE - DET_DESESP - DET_DESCFF)), ' +
              '                              (' + fTotSug + ' - (DET_TOTITE - DET_DESESP - DET_DESCFF))) ';
  end;

  Var
    strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) < 5, -' + fVlrSug + ', ' + fVlrSug + ') AS VLRSUG ';
  strSQL := strSQL + ' ,IF(LEFT(DET_CLAFIS,1) < 5, -' + fVlrPra + ', ' + fVlrPra + ') AS VLRPRA ';
  strSQL := strSQL + ' ,IF(LEFT(DET_CLAFIS,1) < 5, -' + fTotSug + ', ' + fTotSug + ') AS TOTSUG ';
  strSQL := strSQL + ' ,IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), (DET_TOTITE - DET_DESESP - DET_DESCFF)) AS TOTPRA ';
  strSQL := strSQL + ' ,' + fVlrDes + ' AS VLRDES ';
  strSQL := strSQL + ' ,(' + fVlrDes + '/' + fTotSug + ') * 100 AS PERDES ';

  If Pos(fCfgSis('MARMKP'), '1_5_') > 0 Then
    strSQL := strSQL + ' ,( ( 1 - ( DET_TOTCUS / ( DET_TOTITE - DET_DESESP - DET_DESCFF ) ) ) * 100 ) AS MARGEM '
  Else
    strSQL := strSQL + ' ,( ( ( ( DET_TOTITE - DET_DESESP - DET_DESCFF ) / DET_TOTCUS ) * 100 ) - 100 ) AS MARGEM ';

  Result := strSQL;
end;

procedure TfrmRelFatVendasClienteF9.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgItens);
end;

procedure TfrmRelFatVendasClienteF9.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  dtsRelVenCli.DataSet.AfterScroll := Nil;

  If dtsRelVenCli.DataSet.Active Then
    dtsRelVenCli.DataSet.Close;

  if Assigned(QryRel) then
    FreeAndNil(QryRel);

  if Assigned(cdsRel) then
    FreeAndNil(cdsRel);
end;

procedure TfrmRelFatVendasClienteF9.FormCreate(Sender: TObject);
begin
  inherited;

  QryRel := fCriaQuery;
  cdsRel := TZClient.Create(Self);

  blnSelDocumentos := False;
  blnVeioDoTelemarketing := FALSE;
  blnVeioDoTablet        := False;
  blnMosCom              := False;
  blnMosVenMtl           := False;
  strCodRedeLojasCliente := '';
  blnMosPromoc           := False;
  pSetaVisibilidadeColuna('TOTCUS', fVerificaAcessoSistema('MOSVLM'));
  pSetaVisibilidadeColuna('MARGEM', fVerificaAcessoSistema('MOSVLM'));
  fIncluirItem := nil;
end;

procedure TfrmRelFatVendasClienteF9.pAjustandoTela;
  Var
    LfrmGravando: TfrmGravando;
begin
  pCriarFormularios(TfrmGravando, LfrmGravando);
  Try
    LfrmGravando.pgbStatus.Visible := False;
    LfrmGravando.fExecutarAcao := fAjustandoTela;
    LfrmGravando.ShowModal;
  Finally
    pFreeAndNil(LfrmGravando);
  End;
end;

procedure TfrmRelFatVendasClienteF9.pAlterarLayoutForm;
begin
  COMPLE.Visible := fCfgSis('UTIDEF', varBoolean);

 If blnMostraDebCtrChq2 Then
 Begin
   pnlTotais2.Visible := False;
   pnlMostraDebCtrChq2.Visible := True;
   pnlMostraDebCtrChq2.Align := alClient;
 End
 Else
 Begin
   TOTFRE.Visible := False;
   DESACE.Visible := False;
   VALRET.Visible := False;
   VFCPST.Visible := False;
   VLRCON.Visible := False;
 End;
end;

procedure TfrmRelFatVendasClienteF9.pAtualizaDados(DataSet: TDataSet);
  Var
    strFormas : String;
    qryFormas: TUniQuery;
    strNomCli: string;
begin
  If (dtsRelVenCli.DataSet.FindField('TABELA') <> Nil) And
     (dtsRelVenCli.DataSet.FindField('AUTINC') <> Nil) Then
  edtEndEtr.Text := fRetEnderecoEntrega(dtsRelVenCli.DataSet.FieldByName('CODCLI').AsString,
                                        dtsRelVenCli.DataSet.FieldByName('NOMCLI').AsString,
                                        dtsRelVenCli.DataSet.FieldByName('TABELA').AsString,
                                        dtsRelVenCli.DataSet.FieldByName('AUTINC').AsString);

  edtDesItem.Text  := dtsRelVenCli.DataSet.FieldByName('DESCRI').AsString;
  edtDesMarca.Text := dtsRelVenCli.DataSet.FieldByName('DESMAR').AsString;
  edtVendedor.Text := dtsRelVenCli.DataSet.FieldByName('CODVEN').AsString+' - '+
                      dtsRelVenCli.DataSet.FieldByName('VENDED').AsString;

  edtPerCom.Text := '';

  If (dtsRelVenCli.DataSet.FindField('PERCOM') <> Nil) Then
    edtPerCom.Text := FormatFloat('#,##0.00', dtsRelVenCli.DataSet.FieldByName('PERCOM').AsFloat);

  edtMens001.Text  := dtsRelVenCli.DataSet.FieldByName('MEN001').AsString;
  edtMens002.Text  := dtsRelVenCli.DataSet.FieldByName('MEN002').AsString;
  edtTransp.Text   := dtsRelVenCli.DataSet.FieldByName('TRANSP').AsString;
  edtNomRec.Text   := dtsRelVenCli.DataSet.FieldByName('NOMREC').AsString;
  edtCndPgto.Text  := FormatMaskText(MASK_CONPAG,
                                     dtsRelVenCli.DataSet.FieldByName('CNDFAT').AsString);
  edtCodCnd.Text   := dtsRelVenCli.DataSet.FieldByName('CNDCOD').AsString;
  edtCliente.Text  := dtsRelVenCli.DataSet.FieldByName('CODCLI').AsString + ' - ' +
                      dtsRelVenCli.DataSet.FieldByName('NOMCLI').AsString;

  LblCPF.Visible := False;
  edtCPF.Visible := False;
  edtCPF.Text    := '';

  strNomCli := fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [dtsRelVenCli.DataSet.FieldByName('CODCLI').AsString]);

  If fClienteConsumidor(strNomCli, True, True) and
     (edtCliente.Visible) then
  begin
    If (dtsRelVenCli.DataSet.FindField('CGCCON') <> Nil) Then
    begin
      LblCPF.Visible := True;
      edtCPF.Visible := True;
      edtCPF.Text    := fFormataCpfCgc(dtsRelVenCli.DataSet.FindField('CGCCON').AsString, TPais.opcBrasil,'');
    end
    else
    If (dtsRelVenCli.DataSet.FindField('CGCCLI') <> Nil) Then
    begin
      LblCPF.Visible := True;
      edtCPF.Visible := True;
      edtCPF.Text    := fFormataCpfCgc(dtsRelVenCli.DataSet.FindField('CGCCLI').AsString, TPais.opcBrasil,'');
    end;
  end;

  If Not fEmptyStr(dtsRelVenCli.DataSet.FieldByName('NUMLOT').AsString) Then
  Begin
    lblNumLot.Visible := True;
    edtNumLot.Visible := True;
    edtNumLot.Text := dtsRelVenCli.DataSet.FieldByName('NUMLOT').AsString;
  End
  Else
  Begin
    lblNumLot.Visible := False;
    edtNumLot.Visible := False;
  End;

  If (dtsRelVenCli.DataSet.FindField('NOMFOR') <> Nil) Then
  Begin
    edtFornecedor.Text := dtsRelVenCli.DataSet.FieldByName('NOMFOR').AsString
  End
  Else
  Begin
    edtFornecedor.Visible := False;
    lblFornecedor.Visible := False;
    pnlFornecedor.Visible := False;
  End;

  edtProfissional.Text := dtsRelVenCli.DataSet.FieldByName('NOMDIV').AsString;

  qryFormas := fCriaQuery(Self);
  pSomaFormasPagamento(dtsRelVenCli.DataSet.FieldByName('DOCUME').AsString,
                       dtsRelVenCli.DataSet.FieldByName('ESPDOC').AsString,
                       IIF(fClienteConsumidor(strNomCli, True, True),
                          dtsRelVenCli.DataSet.FieldByName('CODEMP').AsString,
                          ''), {req 293708}{req 302130}
                       dtsRelVenCli.DataSet.FieldByName('CODCLI').AsString,
                       qryFormas);
  With qryFormas Do
  Begin
    While Not Eof Do
    Begin
      strFormas := strFormas +
                   FieldByName('DESCRI').AsString + ':' +
                   fPadL(FormatFloat('#0.00', FieldByName('VALMOD').AsFloat), 13) + '  ';
      Next;
    End;
  End;
  FreeAndNil(qryFormas);
  edtFormas.Text := strFormas;

  edtPlaVei.Text := dtsRelVenCli.DataSet.FieldByName('PLAVEI').AsString;

  If (Not fEmptyStr(dtsRelVenCli.DataSet.FieldByName('KM_VEI').AsString))
    And (dtsRelVenCli.DataSet.FieldByName('KM_VEI').AsInteger > 0) Then
    edtKm_Vei.Text := FormatFloat('#,###', dtsRelVenCli.DataSet.FieldByName('KM_VEI').AsInteger)
  Else
    edtKm_Vei.Text := '000.000';

  pAtualizaDadosDoFrete(DataSet);

  If (blnMosVenMtl) Then Begin
    edtQtdPec.Text := FormatFloat('#,##0.00', dtsRelVenCli.DataSet.FieldByName('QTDPEC').AsFloat);
    edtComPec.Text := FormatFloat('#,##0.00', dtsRelVenCli.DataSet.FieldByName('COMPEC').AsFloat);
  End;
end;

function TfrmRelFatVendasClienteF9.fMarkup4(strCampoTotIte: String): String;

  function fEhSubstituido: String;
  begin
    Result := ' (LOCATE(DET_CODFIS, ' + QuotedStr(CST_SUBSTITUICAO) + ') > 0) ';
  end;

  function fDentroEstado: String;
  begin
    Result := ' ((DET_ESTADO = CID_ESTADO) OR (IFNULL(AUX_VENPRE, "N") = "S")) ';
  end;

  function fIcmSai: String;
  begin
    Result := ' (IF(' + fEhSubstituido + ' AND ' + fDentroEstado + ' , 0.00, ROUND((IFNULL(DET_ICMSAI,0) / ' + '(' + strCampoTotIte + ')) * 100, 2))) ';
  end;

  function fImpFed: String;
  begin
    Result := ' (ROUND((IFNULL(DET_IMPFED,0) / ' + '(' + strCampoTotIte + ')) * 100, 2)) ';
  end;

  function fDesOpe: String;
  begin
    Result := ' (ROUND((IFNULL(DET_DESOPE,0) / ' + '(' + strCampoTotIte + ')) * 100, 2)) ';
  end;

  function fComTbl: String;
  begin
    Result := ' (0.00) ';
  end;

  function fIcmsST: String;
  begin
    Result := ' (IF(' + fEhSubstituido + ' AND ' + fDentroEstado + ', (IFNULL(DET_ICMPAV, 0)*DET_QTDITE), 0.00)) ';
  end;

begin
  Result := 'ROUND((' + strCampoTotIte + ' * (1 - ((' + fIcmSai + ' + ' + fImpFed + ' + ' + fDesOpe + ' + ' + fComTbl +  ')/100)) - (' + fIcmsST + ')' + '), 2)';
end;

procedure TfrmRelFatVendasClienteF9.pAtualizaDadosDoFrete(const DataSet : TDataSet);
  Var
    strTipFre : String;
begin
  edtTipFre.Text := EmptyStr;
  edtTipFrete.Text := EmptyStr;
  edtVlrFrete.Text := FloatToStrF(0, ffFixed, 12, 2);

  If (Not Assigned(DataSet)) Then
    Exit;

  If (Not DataSet.Active) Then
    Exit;

  If (DataSet.IsEmpty) Then
    Exit;

  If Assigned(DataSet.FindField('TOTFRE')) Then
    edtVlrFrete.Text := FloatToStrF(DataSet.FieldByName('TOTFRE').AsFloat, ffFixed, 12, 2);

  If Assigned(DataSet.FindField('TIPFRE')) Then
  Begin
    If (fEmptyStr(DataSet.FieldByName('TIPFRE').AsString)) Or (DataSet.FieldByName('TIPFRE').AsString = '0') Then
      strTipFre := fDescricaoFrete('9')
    Else
      strTipFre := fDescricaoFrete(DataSet.FieldByName('TIPFRE').AsString);
    edtTipFre.Text := strTipFre;
    edtTipFrete.Text := strTipFre;
  End;
end;

end.


