unit untLibVendasEntrega;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxSplitter,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Vcl.ExtCtrls, Vcl.StdCtrls,
  EditFocus, Vcl.Mask, MaskEditFocus, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, BitBtnLockedIncrem, Uni,
  UniDataSetProvider, UniClientDataSet, cxProgressBar,
  untTypesSistema, dxBarBuiltInMenu, Vcl.Grids, Vcl.DBGrids, DBGridCitel,
  Datasnap.DBClient, Datasnap.Provider, MemDS, DBAccess, cxPC, dxScreenTip,
  dxCustomHint, cxHint, cxButtonEdit, cxCalendar, System.Actions, Vcl.ActnList,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxButtons;

type
  TfrmLibVendasEntrega = class(TfrmPai)
    dtsDados: TDataSource;
    btnEnvPed: TBitBtnLocked;
    btnAtuali: TBitBtnLocked;
    btnMarDes: TBitBtnLocked;
    btnMarTod: TBitBtnLocked;
    btnItensDoPedido: TBitBtnLocked;
    HintControler: TcxHintStyleController;
    btnEnviarMotVei: TBitBtnLocked;
    btnOutrasEntregas: TBitBtnLocked;
    cdsOutrasEntregas: TUniClientDataSet;
    cdsOutrasEntregasNumeroEntrega: TStringField;
    cdsOutrasEntregasDescricaoEntrega: TStringField;
    dtsOutrasEntregas: TDataSource;
    pnlLegendas: TPanel;
    lblDevRom: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    shpLegenda1: TShape;
    shpLegenda2: TShape;
    shpLegenda3: TShape;
    pgcExportacoes: TcxPageControl;
    tbsExpPedidos: TcxTabSheet;
    pnlDados: TPanel;
    pnlGrid: TPanel;
    cxgDados: TcxGridCitel;
    cxgDadosTableView1: TcxGridDBTableViewCitel;
    cxgDadosTableView1DTAENT: TcxGridDBColumn;
    cxgDadosTableView1NUMDOC: TcxGridDBColumn;
    cxgDadosTableView1DOCFAT: TcxGridDBColumn;
    cxgDadosTableView1NOMCLI: TcxGridDBColumn;
    cxgDadosTableView1CODVEN: TcxGridDBColumn;
    cxgDadosTableView1VLRCON: TcxGridDBColumn;
    cxgDadosTableView1NOMCID: TcxGridDBColumn;
    cxgDadosTableView1STAENT: TcxGridDBColumn;
    cxgDadosTableView1MARDES: TcxGridDBColumn;
    cxgDadosTableView1SEMAFORO: TcxGridDBColumn;
    cxgDadosLevel1: TcxGridLevel;
    pnlFiltros: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    lbl1: TLabel;
    Label2: TLabel;
    lblEmpresa: TLabel;
    Label1: TLabel;
    lblNroPedido: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    rdgCtrEnt: TRadioGroup;
    edtCodCli: TEditFocus;
    edtDesCliente: TEditFocus;
    edtCodEmp: TEditFocus;
    edtDesEmpresa: TEditFocus;
    gpbDocumento: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtDocFat: TEditFocus;
    edtEspFat: TEditFocus;
    edtEmpFat: TEditFocus;
    edtCodTra: TEditFocus;
    edtNomTra: TEditFocus;
    edtNroPedido: TEditFocus;
    btnFiltrar: TBitBtnLocked;
    rdgClientes: TRadioGroup;
    btnEnvCli: TBitBtnLocked;
    cxgOutrasEntregas: TcxGrid;
    cxgOutrasEntregasDBTableView1: TcxGridDBTableView;
    cxgOutrasEntregasDBTableView1Column1: TcxGridDBColumn;
    cxgOutrasEntregasDBTableView1Column2: TcxGridDBColumn;
    cxgOutrasEntregasLevel1: TcxGridLevel;
    rdgFiltroData: TRadioGroup;
    cxgDadosTableView1DTAEMI: TcxGridDBColumn;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure btnFiltrarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarDesClick(Sender: TObject);
    procedure btnMarTodClick(Sender: TObject);
    procedure cxgDadosTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnEnvPedClick(Sender: TObject);
    procedure cxgDadosTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnAtualiClick(Sender: TObject);
    procedure btnItensDoPedidoClick(Sender: TObject);
    procedure ApplicationEventsException(Sender: TObject; E: Exception);
    procedure FormShow(Sender: TObject);
    procedure cxgDadosTableView1FocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure edtDocFatExit(Sender: TObject);
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure btnEnviarMotVeiClick(Sender: TObject);
    procedure btnEnvCliClick(Sender: TObject);
    procedure btnOutrasEntregasClick(Sender: TObject);
    procedure cxgOutrasEntregasDBTableView1DataControllerDataChanged(
      Sender: TObject);
  private
    { Private declarations }
    cdsDados : TUniClientDataSet;
    qryDados : TUniQuery;
    dspDados : TUniDataSetProvider;

    function fCarregaDados(pgbStatus: TcxProgressBar): Boolean;
    function fValidarBotoes: Boolean;
    procedure pMarcarDesmarcar;
    procedure pMarcarDesmarcarTodos;
    procedure pAfterOpen(Dataset: TDataSet);
    procedure pMensagemErro(strMsg: String);
  public
    { Public declarations }
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fEnviarMotVei(pgbStatus: TcxProgressBar): Boolean;
    function fEnviarNotas(pgbStatus: TcxProgressBar): Boolean;
    function fEnviarClientes(pgbStatus: TcxProgressBar): Boolean;
    function fStrUnicode(strText: String): String;
  end;


implementation

uses
  untFuncoesSimples, untConsultas, DateUtils, untGravando,
  untMovMeGerar, untCadProFoto, System.UITypes,
  untFuncFat, untConstantes, untFuncoesConsulta,
  untFusionCliente, untFusionVeiculo, untFusionMotoristaAjudante,
  untFusionEntregaServico, untFusionEntregaServicoItens, untFusionEnvio,
  System.Generics.Collections, untMensagemExplicativa, untFatRomOutEntregas,
  StrUtils, untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

procedure TfrmLibVendasEntrega.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
var
  arrEmp: TConsultasArray;
begin
  inherited;
  if fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmpresa, Nil, Key, arrEmp) then
  begin
    if fValidaCampos(edtCodEmp, True) then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmLibVendasEntrega.edtCodTraKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrTransp: TConsultasArray;
begin
  inherited;
  If fPesqTransportadora(conTraSimples, Self, edtCodTra, edtNomTra, Nil, Key,
    arrTransp) Then
  Begin
    If fValidaCampos(edtCodTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLibVendasEntrega.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel : TConsultasArray;
begin
  if fPesqOperador(Self, edtCodVen, edtNomVen, nil, Key, arrSel) then
	begin
		if fValidaCampos(edtCodVen, False) then
  		Self.SelectNext(ActiveControl, True, True);
	end;
end;

procedure TfrmLibVendasEntrega.edtDocFatExit(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(edtDocFat.Text)) Then
    edtDocFat.Text := fStrZero(edtDocFat.Text, edtDocFat.TamCampo);
end;

function TfrmLibVendasEntrega.fCarregaDados(
  pgbStatus: TcxProgressBar): Boolean;
var
  strSQL: String;
begin
  inherited;
  Result := True;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  FGO_CODCLI AS CODCLI, CLI_NOMCLI, CLI_EMAIL_, CLI_EMAIL2, CLI_EMAIL3, ';
  strSQL := strSQL + '  FATGOR.AUTOINCREM, CLI_C_G_C_, CLI_DTACAD, CLI_ULTCOM, CLI_CODEMP, ';
  strSQL := strSQL + '  FGO_DTAENT AS DTAEMI, FGO_DTENTR AS DTAENT, FGO_CODFPG AS CODFPG, FGO_DTAFAT AS DTAFAT, FGO_HORENT AS HORENT, ';
  strSQL := strSQL + '  FGO_NUMDOC AS NUMDOC, FGO_ESPDOC AS ESPDOC, FGO_CODEMP AS EMPDOC, FGO_CODVEN AS VENDOC,';
  strSQL := strSQL + '  CONCAT(FGO_NUMDOC,"-",FGO_ESPDOC,"-",FGO_CODEMP) AS DOCUMENTO, ';
  strSQL := strSQL + '  CONCAT(FGO_CODCLI,"-",CLI_NOMCLI) AS NOMCLI, ';
  strSQL := strSQL + '  CONCAT(FGO_CODVEN,"-",V.OPE_NOMOPE) AS CODVEN, ';
  strSQL := strSQL + '  FGO_VLRCON AS VLRCON, FGO_PESLIQ AS PESLIQ, ';
  strSQL := strSQL + '  EXTGOR.FGO_STAWMS AS STATUS, ';
  strSQL := strSQL + '  TRA_C_G_C_, ATI_DESATI, ';
  strSQL := strSQL + '  CLI_ENDERE, CLI_ENDNUM, CLI_ENDCOM,';

  strSQL := strSQL + ' SUM(D.ITE_EXPALT * D.ITE_EXPLAR * D.ITE_EXPPRO) AS CUBAGEM,';

  strSQL := strSQL + ' IFNULL(E.ETC_ENDENT, E2.ETC_ENDENT) AS ETC_ENDENT, ';
  strSQL := strSQL + ' IFNULL(E.ETC_CEPENT, E2.ETC_CEPENT) AS ETC_CEPENT, ';
  strSQL := strSQL + ' IFNULL(C.CID_NOMCID, C2.CID_NOMCID) AS CID_NOMCID, ';
  strSQL := strSQL + ' IFNULL(C.CID_COIBGE, C2.CID_COIBGE) AS CID_COIBGE, ';
  strSQL := strSQL + ' IFNULL(C.CID_ESTADO, C2.CID_ESTADO) AS CID_ESTADO, ';
  strSQL := strSQL + ' IFNULL(E.ETC_BAIENT, E2.ETC_BAIENT) AS ETC_BAIENT, ';
  strSQL := strSQL + ' SUBSTRING_INDEX(IFNULL(E.ETC_ENDENT, E2.ETC_ENDENT), ",", 1) AS ENDERECO, ';
  strSQL := strSQL + ' SUBSTRING_INDEX(IFNULL(E.ETC_ENDENT, E2.ETC_ENDENT), ",", -1) AS NRO_ENDERECO, ';
  strSQL := strSQL + ' IFNULL(E.ETC_REFENT, E2.ETC_REFENT) AS ETC_REFENT, ';
  strSQL := strSQL + ' IFNULL(E.ETC_TELENT, E2.ETC_TELENT) AS ETC_TELENT, ';

  strSQL := strSQL + ' (CASE EXTGOR.FGO_STAWMS ';
  strSQL := strSQL + '    WHEN "E" THEN "Enviado para entrega"';
	strSQL := strSQL + '   ELSE "Aguardando envio" END) AS STAWMS, ';

  strSQL := strSQL + ' IF(FGO_NUMFAT <> "", CONCAT(FGO_NUMFAT, "-", FGO_TIPFAT, "-", FGO_EMPFAT), ';
  strSQL := strSQL + '   (SELECT CONCAT(FDO_NUMFAT, "-", FDO_TIPFAT, "-", FDO_EMPFAT) FROM FATDOR FDO ';
  strSQL := strSQL + '   WHERE FDO.FDO_SEQGER = FATGOR.AUTOINCREM AND FDO.FDO_NUMFAT IS NOT NULL LIMIT 1)) AS DOCFAT, ';

  strSQL := strSQL + '  IF(FGO_NUMFAT <> "", FGO_NUMFAT, FDO_NUMFAT) AS NUMFAT, ';
  strSQL := strSQL + '  IF(FGO_TIPFAT <> "", FGO_TIPFAT, FDO_TIPFAT) AS TIPFAT, ';
  strSQL := strSQL + '  IF(FGO_EMPFAT <> "", FGO_EMPFAT, FDO_EMPFAT) AS EMPFAT, ';
  strSQL := strSQL + '  IF(FGO_SERIE_ <> "", FGO_SERIE_, FDO_SERIE_) AS SERFAT, ';

  strSQL := strSQL + '  IF(FGO_DTAENT = CURRENT_DATE AND '
                   + '  TIMEDIFF(CURRENT_TIME, FGO_HORENT)/60 <= 30, "VERDE", '
                   + '  IF(FGO_DTAENT = CURRENT_DATE AND '
                   + '  TIMEDIFF(CURRENT_TIME, FGO_HORENT)/60 <= 60, "AMARELO", '
                   + '  "VERMELHO"))'
                   + '  AS SEMAFORO, ';

  strSQL := strSQL + '  "D" AS MARDES, EXTGOR.FGO_STAWMS AS DOC_STAWMS ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '  FATGOR ';
  strSQL := strSQL + '  JOIN CADCLI ON FGO_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  JOIN CADOPE V ON FGO_CODVEN = V.OPE_CODOPE ';

  strSQL := strSQL + '  JOIN FATDOR ON FATGOR.AUTOINCREM = FDO_SEQGER ';
  strSQL := strSQL + '  LEFT JOIN EXTGOR ON FATGOR.AUTOINCREM = FGO_SEQFGO ';
  strSQL := strSQL + '  LEFT JOIN CADITE I ON I.ITE_CODITE = FDO_CODITE ';
  strSQL := strSQL + '  LEFT JOIN DESSIT D ON D.ITE_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '  LEFT JOIN CADGRU ON GRU_CODGRU = ITE_CODGRU ';
  strSQL := strSQL + '  LEFT JOIN CADUNI ON FDO_UNIDAD = UNI_CODUNI ';
  strSQL := strSQL + '  LEFT JOIN AUXGOR ON AUX_SEQGER = FATGOR.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN ENTCLI E ON E.AUTOINCREM = AUX_ENTGER ';
  strSQL := strSQL + '  LEFT JOIN ENTCLI E2 ON E2.ETC_CODCLI = FATGOR.FGO_CODCLI AND E2.ETC_SEQIND = ';
  strSQL := strSQL + '    (SELECT MIN(ETC_SEQIND) FROM ENTCLI WHERE ETC_CODCLI = FATGOR.FGO_CODCLI) ';
  strSQL := strSQL + '  LEFT JOIN CADCID C ON C.CID_CODCID = E.ETC_CIDENT ';
  strSQL := strSQL + '  LEFT JOIN CADCID C2 ON C2.CID_CODCID = E2.ETC_CIDENT ';
  strSQL := strSQL + '  LEFT JOIN CADTRA ON TRA_CODTRA = FGO_CODTRA ';
  strSQL := strSQL + '  LEFT JOIN CADATI ON CLI_CODATI = ATI_CODATI ';

  strSQL := strSQL + ' WHERE ';
  strSQl := strSQl + '   TRUE ';

  If (Not (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)))) And
     (Not (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))))
  Then
  begin
    if rdgFiltroData.ItemIndex = 0 then
      strSQL := strSQL + ' AND FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN '
    else
      strSQL := strSQL + ' AND FGO_DTENTR BETWEEN :DTAINI AND :DTAFIN '
  end;

  If (Not fEmptyStr(edtNroPedido.Text)) then
    strSQL := strSQL + ' AND FGO_NUMDOC = :NUMDOC ';

  If (Not fEmptyStr(edtDocFat.Text)) And
    (Not fEmptyStr(edtEspFat.Text)) and
    (not(fEmptyStr(edtEmpFat.Text)))
  Then
  Begin
    strSQL := strSQL +' AND FGO_NUMFAT = :NUMFAT ';
    strSQL := strSQL +' AND FGO_TIPFAT = :TIPFAT ';
    strSQL := strSQL +' AND FGO_EMPFAT = :EMPFAT ';
  End;

  if not fEmptyStr(edtCodCli.Text) then
    strSQL := strSQL + '  AND CLI_CODCLI = :CODCLI ';

  If Not fEmptyStr(edtCodVen.Text) Then
    strSQL := strSQL + '  AND V.OPE_CODOPE = :CODVEN ';

  If Not fEmptyStr(edtCodEmp.Text) Then
    strSQL := strSQL + '  AND FGO_CODEMP = :CODEMP '
  Else
    strSQL := strSQL + '  AND LOCATE(FGO_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  case rdgCtrEnt.ItemIndex of
    1:
      strSQL := strSQL + '  AND IFNULL(EXTGOR.FGO_STAWMS, "") = "" ';
    2:
      strSQL := strSQL + '  AND EXTGOR.FGO_STAWMS = "E" ';
  end;

  If (Not fEmptyStr(edtCodTra.Text)) Then
    strSQL := strSQL + ' AND FGO_CODTRA = :CODTRA ';

  strSQL := strSQL + '  AND FDO_VLRCON <> 0 ';
  strSQL := strSQL + '  AND FGO_NUMFAT <> "" ';

  strSQL := strSQL + ' GROUP BY ';
  strSQL := strSQL + '  FATGOR.AUTOINCREM ';

  strSQL := strSQL + ' UNION ALL ';

  // ----------------------------------------------------------

  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '  DIG_CODCLI AS CODCLI, CLI_NOMCLI, CLI_EMAIL_, CLI_EMAIL2, CLI_EMAIL3, ';
  strSQL := strSQL + '  OUTDIGX.AUTOINCREM, CLI_C_G_C_, CLI_DTACAD, CLI_ULTCOM, CLI_CODEMP, ';
  strSQL := strSQL + '  DIG_DTAENT AS DTAEMI, DIG_DTAETR AS DTAENT, "1" AS CODFPG, DIG_DTAENT AS DTAFAT, DIG_HORENT AS HORENT, ';
  strSQL := strSQL + '  DIG_NUMDOC AS NUMDOC, DIG_ESPDOC AS ESPDOC, DIG_CODEMP AS EMPDOC, DIG_CODVEN AS VENDOC,';
  strSQL := strSQL + '  DIG_DESCRI AS DOCUMENTO, ';
  strSQL := strSQL + '  CONCAT(DIG_CODCLI,"-",CLI_NOMCLI) AS NOMCLI, ';
  strSQL := strSQL + '  CONCAT(DIG_CODVEN,"-",V.OPE_NOMOPE) AS CODVEN, ';
  strSQL := strSQL + '  0.00 AS VLRCON, 0.00 AS PESLIQ, ';
  strSQL := strSQL + '  DIG_STAWMS AS STATUS, ';
  strSQL := strSQL + '  "" AS TRA_C_G_C_, ATI_DESATI, ';
  strSQL := strSQL + '  CLI_ENDERE, CLI_ENDNUM, CLI_ENDCOM,';

  strSQL := strSQL + ' 0.00 AS CUBAGEM,';

  strSQL := strSQL + ' IFNULL(E.ETC_ENDENT, E2.ETC_ENDENT) AS ETC_ENDENT, ';
  strSQL := strSQL + ' IFNULL(E.ETC_CEPENT, E2.ETC_CEPENT) AS ETC_CEPENT, ';
  strSQL := strSQL + ' IFNULL(C.CID_NOMCID, C2.CID_NOMCID) AS CID_NOMCID, ';
  strSQL := strSQL + ' IFNULL(C.CID_COIBGE, C2.CID_COIBGE) AS CID_COIBGE, ';
  strSQL := strSQL + ' IFNULL(C.CID_ESTADO, C2.CID_ESTADO) AS CID_ESTADO, ';
  strSQL := strSQL + ' IFNULL(E.ETC_BAIENT, E2.ETC_BAIENT) AS ETC_BAIENT, ';
  strSQL := strSQL + ' SUBSTRING_INDEX(IFNULL(E.ETC_ENDENT, E2.ETC_ENDENT), ",", 1) AS ENDERECO, ';
  strSQL := strSQL + ' SUBSTRING_INDEX(IFNULL(E.ETC_ENDENT, E2.ETC_ENDENT), ",", -1) AS NRO_ENDERECO, ';
  strSQL := strSQL + ' IFNULL(E.ETC_REFENT, E2.ETC_REFENT) AS ETC_REFENT, ';
  strSQL := strSQL + ' IFNULL(E.ETC_TELENT, E2.ETC_TELENT) AS ETC_TELENT, ';

  strSQL := strSQL + ' (CASE DIG_STAWMS ';
  strSQL := strSQL + '    WHEN "E" THEN "Enviado para entrega"';
	strSQL := strSQL + '   ELSE "Aguardando envio" END) AS STAWMS, ';

  strSQL := strSQL + ' CONCAT(DIG_NUMDOC,"-",DIG_ESPDOC,"-",DIG_CODEMP) AS DOCFAT, ';

  strSQL := strSQL + '  DIG_NUMDOC AS NUMFAT, ';
  strSQL := strSQL + '  DIG_ESPDOC AS TIPFAT, ';
  strSQL := strSQL + '  DIG_CODEMP AS EMPFAT, ';
  strSQL := strSQL + '  "" AS SERFAT, ';

  strSQL := strSQL + '  IF(DIG_DTAENT = CURRENT_DATE AND '
                   + '  TIMEDIFF(CURRENT_TIME, DIG_HORENT)/60 <= 30, "VERDE", '
                   + '  IF(DIG_DTAENT = CURRENT_DATE AND '
                   + '  TIMEDIFF(CURRENT_TIME, DIG_HORENT)/60 <= 60, "AMARELO", '
                   + '  "VERMELHO"))'
                   + '  AS SEMAFORO, ';

  strSQL := strSQL + '  "D" AS MARDES, DIG_STAWMS AS DOC_STAWMS';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '  OUTDIGX ';
  strSQL := strSQL + '  JOIN CADCLI ON DIG_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  JOIN CADOPE V ON DIG_CODVEN = V.OPE_CODOPE ';
  strSQL := strSQL + '  LEFT JOIN ENTCLI E ON E.ETC_CODCLI = CADCLI.CLI_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN ENTCLI E2 ON E2.ETC_CODCLI = DIG_CODCLI AND E2.ETC_SEQIND = ';
  strSQL := strSQL + '    (SELECT MIN(ETC_SEQIND) FROM ENTCLI WHERE ETC_CODCLI = DIG_CODCLI) ';
  strSQL := strSQL + '  LEFT JOIN CADCID C ON C.CID_CODCID = E.ETC_CIDENT ';
  strSQL := strSQL + '  LEFT JOIN CADCID C2 ON C2.CID_CODCID = E2.ETC_CIDENT ';
  strSQL := strSQL + '  LEFT JOIN CADATI ON CLI_CODATI = ATI_CODATI ';

  strSQL := strSQL + ' WHERE ';
  strSQl := strSQl + '   TRUE ';

  If (Not (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)))) And
     (Not (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))))
  Then
  begin
    if rdgFiltroData.ItemIndex = 0 then
      strSQL := strSQL + ' AND DIG_DTAENT BETWEEN :DTAINI AND :DTAFIN '
    else
      strSQL := strSQL + ' AND DIG_DTAETR BETWEEN :DTAINI AND :DTAFIN '
  end;

  If (Not fEmptyStr(edtNroPedido.Text)) then
    strSQL := strSQL + ' AND DIG_NUMDOC = :NUMDOC ';

  If (Not fEmptyStr(edtDocFat.Text)) And
    (Not fEmptyStr(edtEspFat.Text)) and
    (not(fEmptyStr(edtEmpFat.Text)))
  Then
  Begin
    strSQL := strSQL +' AND DIG_NUMDOC = :NUMFAT ';
    strSQL := strSQL +' AND DIG_ESPDOC = :TIPFAT ';
    strSQL := strSQL +' AND DIG_CODEMP = :EMPFAT ';
  End;

  if not fEmptyStr(edtCodCli.Text) then
    strSQL := strSQL + '  AND CLI_CODCLI = :CODCLI ';

  If Not fEmptyStr(edtCodVen.Text) Then
    strSQL := strSQL + '  AND V.OPE_CODOPE = :CODVEN ';

  If Not fEmptyStr(edtCodEmp.Text) Then
    strSQL := strSQL + '  AND DIG_CODEMP = :CODEMP '
  Else
    strSQL := strSQL + '  AND LOCATE(DIG_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  case rdgCtrEnt.ItemIndex of
    1:
      strSQL := strSQL + '  AND IFNULL(DIG_STAWMS, "") = "" ';
    2:
      strSQL := strSQL + '  AND DIG_STAWMS = "E" ';
  end;

  // ----------------------------------------------------------

  strSQL := strSQL + ' GROUP BY ';
  strSQL := strSQL + '  OUTDIGX.AUTOINCREM ';

  strSQL := strSQL + ' ORDER BY ';

  if rdgFiltroData.ItemIndex = 0 then
    strSQL := strSQL + ' DTAEMI, NUMDOC '
  else
    strSQL := strSQL + ' DTAENT, NUMDOC ';

  With qryDados Do
  Begin
    cdsDados.Close;

    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If (Not (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)))) And
       (Not (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))))
    Then
    begin
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
    end;

    If (Not fEmptyStr(edtNroPedido.Text)) Then
      ParamByName('NUMDOC').AsString := edtNroPedido.Text;

    If (Not fEmptyStr(edtDocFat.Text)) And
      (Not fEmptyStr(edtEspFat.Text)) and
      (not(fEmptyStr(edtEmpFat.Text)))
    Then
    Begin
      ParamByName('NUMFAT').AsString := edtDocFat.Text;
      ParamByName('TIPFAT').AsString := edtEspFat.Text;
      ParamByName('EMPFAT').AsString := edtEmpFat.Text;
    End;

    If Not fEmptyStr(edtCodTra.Text) Then
      ParamByName('CODTRA').AsString := edtCodTra.Text;

    If Not fEmptyStr(edtCodCli.Text) Then
      ParamByName('CODCLI').AsString := edtCodCli.Text;

    If Not fEmptyStr(edtCodVen.Text) Then
      ParamByName('CODVEN').AsString := edtCodVen.Text;

    If Not fEmptyStr(edtCodEmp.Text) Then
      ParamByName('CODEMP').AsString := edtCodEmp.Text;

    Open;

    pSetaClient(qryDados);
    cdsDados.SetProvider(dspDados);
    cdsDados.Open;

    cxgDadosTableView1.ApplyBestFit;

    if cdsDados.RecordCount > 0 then
      pSetFocus(cxgDados);
  End;
end;

function TfrmLibVendasEntrega.fEnviarClientes(
  pgbStatus: TcxProgressBar): Boolean;
var
  qryCadCli: TUniQuery;

  objFusionCliente: TFusionCliente;
  arrClientes: Array of TFusionCliente;

  strErros: TStringList;
  strRetorno: String;

  intLote: Integer;
begin
  try
    try
      Result := True;

      strErros := TStringList.Create;

      qryCadCli := fCriaQuery;

      with qryCadCli, SQL do
      begin
        Close;
        Clear;
        Append(' SELECT ');
        Append(' CLI_CODCLI, CLI_NOMCLI, CLI_EMAIL_, CLI_EMAIL2, CLI_EMAIL3, ');
        Append(' CLI_C_G_C_, CLI_DTACAD, CLI_ULTCOM, CLI_CODEMP, ');
        Append(' CONCAT(CLI_CODCLI,"-",CLI_NOMCLI) AS NOMCLI, ');
        Append(' CLI_ENDERE, CLI_ENDNUM, CLI_ENDCOM, ');
        Append(' IFNULL(E.ETC_ENDENT, E2.ETC_ENDENT) AS ETC_ENDENT, ');
        Append(' IFNULL(E.ETC_CEPENT, E2.ETC_CEPENT) AS ETC_CEPENT, ');
        Append(' IFNULL(C.CID_NOMCID, C2.CID_NOMCID) AS CID_NOMCID, ');
        Append(' IFNULL(C.CID_COIBGE, C2.CID_COIBGE) AS CID_COIBGE, ');
        Append(' IFNULL(C.CID_ESTADO, C2.CID_ESTADO) AS CID_ESTADO, ');
        Append(' IFNULL(E.ETC_BAIENT, E2.ETC_BAIENT) AS ETC_BAIENT, ');
        Append(' SUBSTRING_INDEX(IFNULL(E.ETC_ENDENT, E2.ETC_ENDENT), ",", 1) AS ENDERECO, ');
        Append(' SUBSTRING_INDEX(IFNULL(E.ETC_ENDENT, E2.ETC_ENDENT), ",", -1) AS NRO_ENDERECO, ');
        Append(' IFNULL(E.ETC_REFENT, E2.ETC_REFENT) AS ETC_REFENT, ');
        Append(' IFNULL(E.ETC_TELENT, E2.ETC_TELENT) AS ETC_TELENT ');

        Append(' FROM CADCLI ');

        Append(' LEFT JOIN ENTCLI E ON E.AUTOINCREM = CADCLI.AUTOINCREM ');
        Append(' LEFT JOIN ENTCLI E2 ON E2.ETC_CODCLI = CLI_CODCLI AND E2.ETC_SEQIND = ');
        Append('   (SELECT MIN(ETC_SEQIND) FROM ENTCLI WHERE ETC_CODCLI = CLI_CODCLI) ');
        Append(' LEFT JOIN CADCID C ON C.CID_CODCID = E.ETC_CIDENT ');
        Append(' LEFT JOIN CADCID C2 ON C2.CID_CODCID = E2.ETC_CIDENT ');

        case rdgClientes.ItemIndex of
          1:
            Append(' WHERE CLI_STATUS = "A" ');
          2:
            Append(' WHERE CLI_STATUS = "I" ');
        end;

        Open;
        intLote := 0;

        While Not qryCadCli.Eof Do
        Begin
          objFusionCliente := TFusionCliente.Create;

          with objFusionCliente do
          begin
            pInformacao(
              Format('Enviando Lote de Clientes (%s/%s)',
               [IntToStr(qryCadCli.RecNo),
               IntToStr(qryCadCli.RecordCount)]), pgbStatus
            );

            codigo_cliente := qryCadCli.FieldByName('CLI_CODCLI').AsString;
            filial_padrao := qryCadCli.FieldByName('CLI_CODEMP').AsString; // Necessário?
            descr_cliente := qryCadCli.FieldByName('CLI_NOMCLI').AsString;
            cnpj_cpf_cliente := fRetSomenteNumeros(qryCadCli.FieldByName('CLI_CODCLI').AsString);
            cliente_cod_rota_erp := '1';
            cep_cliente := qryCadCli.FieldByName('ETC_CEPENT').AsString;
            end_cliente := qryCadCli.FieldByName('ENDERECO').AsString;
            num_end_cliente := qryCadCli.FieldByName('NRO_ENDERECO').AsString;
            bairro_cliente := qryCadCli.FieldByName('ETC_BAIENT').AsString;
            cidade_cliente := qryCadCli.FieldByName('CID_NOMCID').AsString;
            uf_cliente := qryCadCli.FieldByName('CID_ESTADO').AsString;
            email1_cliente := qryCadCli.FieldByName('CLI_EMAIL_').AsString;
            email2_cliente := qryCadCli.FieldByName('CLI_EMAIL2').AsString;
            email3_cliente := qryCadCli.FieldByName('CLI_EMAIL3').AsString;
            tel1_cliente := qryCadCli.FieldByName('ETC_TELENT').AsString;
            tel2_cliente := '';
            tel3_cliente := '';
            data_cadastro_cliente := qryCadCli.FieldByName('CLI_DTACAD').AsDateTime;
            data_ult_compra := qryCadCli.FieldByName('CLI_ULTCOM').AsDateTime;
            horarios_entrega := '';
            prioritario := 'N';

            SetLength(arrClientes, Length(arrClientes)+1);

            arrClientes[Length(arrClientes)-1] := TFusionCliente.Create;
            arrClientes[Length(arrClientes)-1] := objFusionCliente;

            Inc(intLote);

            if (intLote = 100) or
               (qryCadCli.RecNo = qryCadCli.RecordCount)
            then
            begin
              strRetorno :=
                fEnviar(fCfgSis('FUSUSR'), fCfgSis('FUSSEN'), arrClientes);

              intLote := 0;
              SetLength(arrClientes, 0);
            end;
          end;

          qryCadCli.Next;
        end;
      end;

      if strErros.Count = 0 then
        fMensagem('Sucesso!', 'Dados de clientes enviados à API Fusion!', ['&Ok'])
      else
        pMensagemErro(strErros.Text);

    except
      on E: Exception do
      begin
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(qryCadCli);
    FreeAndNil(strErros);
  end;
end;

function TfrmLibVendasEntrega.fEnviarMotVei(pgbStatus: TcxProgressBar): Boolean;
var
  qryCadMot: TUniQuery;
  qryCadVei: TUniQuery;

  objMotorista: TFusionMotoristaAjudante;
  objVeiculo: TFusionVeiculo;

  strErros: TStringList;
  strRetorno: String;
begin
  try
    try
      Result := True;

      objMotorista := TFusionMotoristaAjudante.Create;
      objVeiculo := TFusionVeiculo.Create;
      strErros := TStringList.Create;

      qryCadMot := fCriaQuery;
      qryCadVei := fCriaQuery;

      with qryCadMot, SQL do
      begin
        Close;
        Clear;
        Append('SELECT MOT_CODMOT, MOT_NOMMOT, MOT_CPFMOT FROM CADMOT');
        Open;

        while not Eof do
        begin
          pInformacao(
            Format('Enviando Motoristas... (%s/%s)',
            [IntToStr(RecNo), IntToStr(RecordCount)]), pgbStatus
          );

          with objMotorista do
          begin
            codigo_erp := FieldByName('MOT_CODMOT').AsString; //	Codigo do condutor no sistema ERP.
            nome := FieldByName('MOT_NOMMOT').AsString;
            cpf := FieldByName('MOT_CPFMOT').AsString;
            tipo := 'Motorista'; // ** Motorista ou Ajudante

             // Motorista não possui endereço/telefone no Autcom
            cep := '';
            endereco := '';
            cidade := '';
            uf := '';
            telefone := ''; //	telefone para contato, podendo ser celular ou fixo

            strRetorno := fEnviar(fCfgSis('FUSUSR'), fCfgSis('FUSSEN'), objMotorista);

            if strRetorno <> '' then
              strErros.Add('Motorista: ' +codigo_erp +' - ' +strRetorno +sLineBreak);
          end;

          Next;
        end;
      end;

      with qryCadVei, SQL do
      begin
        Close;
        Clear;
        Append('SELECT VEI_PLAVEI, VEI_ANOVEI, CADVEI.AUTOINCREM,');
        Append('CONCAT(MAR_DESMAR, " ", MOD_DESMOD) AS DESCRICAO');
        Append('FROM CADVEI');
        Append('LEFT JOIN MODVEI ON VEI_CODMOD = MOD_CODMOD');
        Append('LEFT JOIN MARVEI ON VEI_CODMAR = MAR_CODMAR');
        Open;

        while not Eof do
        begin
          pInformacao(
            Format('Enviando Veículos... (%s/%s)',
            [IntToStr(RecNo), IntToStr(RecordCount)]), pgbStatus
          );

          with objVeiculo do
          begin
            // FieldByName('').AsString

            codigo_erp :=	FieldByName('AUTOINCREM').AsString; //	código do veiculo no erp
            placa	:= FieldByName('VEI_PLAVEI').AsString; // placa do veiculo
            descricao	:= FieldByName('DESCRICAO').AsString; //	descricao do veiculo
            modelo :=	FieldByName('DESCRICAO').AsString; //	modelo do veiculo
            anoModelo :=	FieldByName('VEI_ANOVEI').AsString; //	ano do modelo do veiculo
            anoFabricacao  :=	FieldByName('VEI_ANOVEI').AsString; //	ano fabricado
            status_inicial :=	'Livre'; // normalmente é vindo com padrão, que o status é Livre

            // Não possui no Autcom
            // Padrão discutido em e-mail
            kmAtual	:= '0';
            qtdMaxEntregas :=	'9999';
            volume_max_entregas	:= '99999';
            qtd_pallets_veiculo	:= '99';

            // Não possui no Autcom
            velocidade_maxima := ''; //	velocidade máxima atingida pelo veículo
            tipo_combustivel :=	''; //	tipo usado pelo combustivel
            peso_max_entregas	:= '';	// peso maximo para entregas no veiculo

            strRetorno := fEnviar(fCfgSis('FUSUSR'), fCfgSis('FUSSEN'), objVeiculo);

            if strRetorno <> '' then
              strErros.Add('Veículo: ' +codigo_erp +' - ' +strRetorno +sLineBreak);
          end;

          Next;
        end;
      end;

      if strErros.Count = 0 then
        fMensagem('Sucesso!', 'Dados de motoristas e veículos enviados à API Fusion!', ['&Ok'])
      else
        pMensagemErro(strErros.Text);

    except
      on E: Exception do
      begin
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FreeAndNil(qryCadMot);
    FreeAndNil(qryCadVei);
    FreeAndNil(strErros);
  end;
end;

function TfrmLibVendasEntrega.fEnviarNotas(pgbStatus: TcxProgressBar): Boolean;
var
  intFocusedRowIndex: Integer;
  qryItens: TUniQuery;
  qryUpdate: TUniQuery;
  blnEnviado: Boolean;

  objFusionCliente: TFusionCliente;

  objEntregaServico: TFusionEntregaServico;
  objProduto: TFusionEntregaServicoItens;

  strErros: TStringList;
  strRetorno: String;
begin
  Result := True;

  if (fCfgSis('FUSUSR') = '') or (fCfgSis('FUSSEN') = '') then
  begin
    fMensagem('Atenção!',
              'Usuário e senha da API Fusion não definidos nas configurações.' +sLineBreak
                +'Informe os dados e tente novamente',
              ['&Ok']);

    Result := False;
  end
  else if btnEnvPed.Visible then
  begin
    if fValidarBotoes then
    begin
      cdsDados.DisableControls;

      intFocusedRowIndex := cxgDadosTableView1.Controller.FocusedRowIndex;

      qryItens := fCriaQuery;
      qryUpdate := fCriaQuery;
      cdsDados.Filter := 'MARDES = ' + QuotedStr('M');

      cdsDados.Filtered := True;

      if cdsDados.RecordCount > 0 then
      begin
        cdsDados.First;

        while not cdsDados.Eof do
        begin
          if (cdsDados.FieldByName('DOC_STAWMS').AsString = 'E') then
          begin
            fMensagem('Aviso!',
                      Format('O pedido %s não pode ser enviado, pois já consta como %s!'
                            +' Desmarque o pedido e tente novamente',
                            [cdsDados.FieldByName('NUMDOC').AsString, cdsDados.FieldByName('STAWMS').AsString]), ['&Ok']);

            cdsDados.Filtered := False;
            cdsDados.Filter := '';
            cdsDados.EnableControls;
            cxgDadosTableView1.Controller.FocusedRowIndex := intFocusedRowIndex;

            Exit;
          end;

          cdsDados.Next;
        end;

        cdsDados.First;

        // Cria os objetos Fusion
        objFusionCliente := TFusionCliente.Create;
        objEntregaServico := TFusionEntregaServico.Create;
        strErros := TStringList.Create;

        While Not cdsDados.Eof Do
        Begin
          with objFusionCliente do
          begin
            pInformacao(
              Format('Enviando Cliente do Documento %s-%s-%s',
              [cdsDados.FieldByName('NUMFAT').AsString,
               cdsDados.FieldByName('TIPFAT').AsString,
               cdsDados.FieldByName('EMPFAT').AsString]), pgbStatus
            );

            codigo_cliente := cdsDados.FieldByName('CODCLI').AsString;
            filial_padrao := cdsDados.FieldByName('CLI_CODEMP').AsString; // Necessário?
            descr_cliente := cdsDados.FieldByName('CLI_NOMCLI').AsString;
            cnpj_cpf_cliente := fRetSomenteNumeros(cdsDados.FieldByName('CODCLI').AsString);
            cliente_cod_rota_erp := '1';
            cep_cliente := cdsDados.FieldByName('ETC_CEPENT').AsString;
            end_cliente := cdsDados.FieldByName('ENDERECO').AsString;
            num_end_cliente := cdsDados.FieldByName('NRO_ENDERECO').AsString;
            bairro_cliente := cdsDados.FieldByName('ETC_BAIENT').AsString;
            cidade_cliente := cdsDados.FieldByName('CID_NOMCID').AsString;
            uf_cliente := cdsDados.FieldByName('CID_ESTADO').AsString;
            email1_cliente := cdsDados.FieldByName('CLI_EMAIL_').AsString;
            email2_cliente := cdsDados.FieldByName('CLI_EMAIL2').AsString;
            email3_cliente := cdsDados.FieldByName('CLI_EMAIL3').AsString;
            tel1_cliente := cdsDados.FieldByName('ETC_TELENT').AsString;
            tel2_cliente := '';
            tel3_cliente := '';
            data_cadastro_cliente := cdsDados.FieldByName('CLI_DTACAD').AsDateTime;
            data_ult_compra := cdsDados.FieldByName('CLI_ULTCOM').AsDateTime;
            horarios_entrega := '';
            prioritario := 'N';

            strRetorno :=
              fEnviar(fCfgSis('FUSUSR'), fCfgSis('FUSSEN'), objFusionCliente);

            strRetorno := fStrUnicode(strRetorno);

            if strRetorno <> '' then
              strErros.Add('Cliente: ' +cdsDados.FieldByName('CODCLI').AsString +' '
                +strRetorno);
          end;

          if strRetorno = '' then
          begin
            with objEntregaServico do
            begin
              pInformacao(
                Format('Enviando Documentos... (%s/%s)',
                [IntToStr(cdsDados.RecNo), IntToStr(cdsDados.RecordCount)]), pgbStatus
              );

              nf :=	cdsDados.FieldByName('NUMFAT').AsString; //	numero da nota fiscal
              serie := cdsDados.FieldByName('SERFAT').AsString; //	codigo da serie da nota fiscal(nao obrig)
              tipo := cdsDados.FieldByName('TIPFAT').AsString; // da nota fiscal(nao obrig)
              ent_ou_serv := IfThen(cdsDados.FieldByName('ESPDOC').AsString = 'OX', 'Servico', 'Entrega'); // Se for Entrega ou Serviço
              pedido_erp := cdsDados.FieldByName('NUMDOC').AsString; // codigo do pedido no seu sistem(ERP)
              forma_pgto := cdsDados.FieldByName('CODFPG').AsString;
              status := '1'; //	status 1 são normalmente para  coletas. 9 canceladas
              obs := ''; // Caso for um endereço alternativo, pode-se colocar nesse campo @CEP, sendo o cep no formatao 00000-000
              num_ped_conf := cdsDados.FieldByName('NUMDOC').AsString;
              carga := '';
              podeformarcarga := 'S'; //	caso for cancelada, é passado o parametro N
              cubagem := FormatFloat('#0.00', cdsDados.FieldByName('CUBAGEM').AsFloat).Replace(FormatSettings.DecimalSeparator, '.'); //	Sim, mas não precisa ser metro cubico obrigatoriamente. Pode ser qualquer unidade que voce pode trabalhar.
              valor := FormatFloat('#0.00', cdsDados.FieldByName('VLRCON').AsFloat).Replace(FormatSettings.DecimalSeparator, '.'); //	Sim, caso não exista pode passar zero.
              peso := FormatFloat('#0.00', cdsDados.FieldByName('PESLIQ').AsFloat).Replace(FormatSettings.DecimalSeparator, '.');
              valor_st :=	'0';
              empresa_fat := cdsDados.FieldByName('EMPFAT').AsString; //	filial da fatura no ERP
              empresa_log := cdsDados.FieldByName('EMPFAT').AsString; //	filial da logistica no ERP. onde será enviado os produtos.
              empresa_digit := cdsDados.FieldByName('EMPFAT').AsString; //	filial da digitação no ERP.
              pedido_orig := cdsDados.FieldByName('NUMDOC').AsString; //	codigo do pedido do ERP

              dt_list_nf :=
                StrToDateTime(FormatDateTime('dd/mm/yyyy', cdsDados.FieldByName('DTAEMI').AsDateTime) +' '
                  +FormatDateTime('hh:nn:ss', cdsDados.FieldByName('HORENT').AsDateTime)); //	será a data da coleta.

              nf_cod_rota_erp := ''; //	Necessário?
              nf_descricao_rota := ''; //	Necessário?
              descr_cliente := cdsDados.FieldByName('CLI_NOMCLI').AsString; //	descrição do cliente.
              cnpj_cliente :=	fRetSomenteNumeros(cdsDados.FieldByName('CODCLI').AsString); //	sim, pode colocar o cpf
              end_cliente := cdsDados.FieldByName('ENDERECO').AsString; // endereço
              bairro_cliente :=	cdsDados.FieldByName('ETC_BAIENT').AsString; // bairro
              num_end_cliente := cdsDados.FieldByName('NRO_ENDERECO').AsString;
              uf_cliente :=	cdsDados.FieldByName('CID_ESTADO').AsString; // uf do endereço do cliente
              cidade_cliente :=	cdsDados.FieldByName('CID_NOMCID').AsString; // cidade do cliente
              cep_cliente := cdsDados.FieldByName('ETC_CEPENT').AsString; //	cep do cliente
              email1_cliente :=	cdsDados.FieldByName('CLI_EMAIL_').AsString; // email do cliente
              email2_cliente :=	cdsDados.FieldByName('CLI_EMAIL2').AsString; // email do cliente
              email3_cliente :=	cdsDados.FieldByName('CLI_EMAIL3').AsString; // email do cliente
              tel1_cliente :=	cdsDados.FieldByName('ETC_TELENT').AsString;	// telefone do cliente
              tel2_cliente :=	''; // telefone do cliente
              tel3_cliente :=	''; // telefone do cliente
              vlr_credito_cliente := '0'; // Necessário?
              data_cadastro_cliente := cdsDados.FieldByName('CLI_DTACAD').AsDateTime;
              saldo_disp_cliente :=	'0'; // Necessário?
              vlr_tits_vencido_cliente :=	'0';
              vlr_tits_vencer_cliente :=	'0';
              status_cred_cliente := 'C';
              codigo_cliente :=	cdsDados.FieldByName('CODCLI').AsString; //	É o codigo do cliente no erp
              cod_segmento :=	cdsDados.FieldByName('ATI_DESATI').AsString; // Necessário?
              descr_segmento :=	''; // Necessário?
              filial_padrao := cdsDados.FieldByName('EMPDOC').AsString;
              data_ult_compra := cdsDados.FieldByName('CLI_ULTCOM').AsDateTime;
              forma_pgto_cliente :=	'0'; // Necessário?
              retem_icms_cliente :=	'N';
              permite_retira_cliente :=	'N';
              rede_loja_cliente := cdsDados.FieldByName('EMPDOC').AsString; // Necessário?
              cliente_cod_rota_erp :=	'1'; // Codigo da praça no seu ERP
              cliente_descricao_rota :=	cdsDados.FieldByName('DOCUMENTO').AsString; // Necessário?
              vendedor_erp :=	cdsDados.FieldByName('CODVEN').AsString;

              data_pedido :=
                StrToDateTime(FormatDateTime('dd/mm/yyyy', cdsDados.FieldByName('DTAEMI').AsDateTime) +' '
                  +FormatDateTime('hh:nn:ss', cdsDados.FieldByName('HORENT').AsDateTime)); // data do processamento do pedido.

              codigo_endereco_alt := ''; // Necessário?

              if cdsDados.FieldByName('ESPDOC').AsString <> 'OX' then
              begin
                qryItens.Close;
                qryItens.SQL.Clear;
                qryItens.SQL.Append(' SELECT FDO_CODITE, FDO_QTDITE, FDO_UNITAR, ');
                qryItens.SQL.Append(' FDO_TOTITE, ITE_DESITE, UNI_SIGUNI ');
                qryItens.SQL.Append(' FROM FATDOR ');
                qryItens.SQL.Append(' INNER JOIN CADITE ON FDO_CODITE = ITE_CODITE ');
                qryItens.SQL.Append(' LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ');
                qryItens.SQL.Append(' WHERE FDO_SEQGER = ' +cdsDados.FieldByName('AUTOINCREM').AsString);
                qryItens.Open;

                SetLength(arrProdutos, 0);

                while not qryItens.Eof do
                begin
                  objProduto := TFusionEntregaServicoItens.Create;

                  with objProduto do
                  begin
                    cod_produto_erp := qryItens.FieldByName('FDO_CODITE').AsString;
                    descricao	:= qryItens.FieldByName('ITE_DESITE').AsString;
                    qtd := FormatFloat('#0.00', qryItens.FieldByName('FDO_QTDITE').AsFloat).Replace(FormatSettings.DecimalSeparator, '.');
                    preco := FormatFloat('#0.00', qryItens.FieldByName('FDO_UNITAR').AsFloat).Replace(FormatSettings.DecimalSeparator, '.');
                    subtotal := FormatFloat('#0.00', qryItens.FieldByName('FDO_TOTITE').AsFloat).Replace(FormatSettings.DecimalSeparator, '.');
                    unidade := qryItens.FieldByName('UNI_SIGUNI').AsString;

                    SetLength(arrProdutos, Length(arrProdutos)+1);
                    objEntregaServico.arrProdutos[Length(arrProdutos)-1] := objProduto;
                  end;

                  qryItens.Next;
                end;
              end;

              strRetorno :=
                fEnviar(fCfgSis('FUSUSR'), fCfgSis('FUSSEN'), objEntregaServico);

              if strRetorno <> '' then
                strErros.Add(Format('Documento%s: %s-%s-%s ',
                  [IfThen(cdsDados.FieldByName('ESPDOC').AsString = 'OX', ' (OX)', ''),
                   cdsDados.FieldByName('NUMFAT').AsString,
                   cdsDados.FieldByName('TIPFAT').AsString,
                   cdsDados.FieldByName('EMPFAT').AsString]) +strRetorno)
              else
              begin
                fStartTransaction;

                with qryUpdate, SQL do
                begin
                  Close;
                  Clear;

                  if cdsDados.FieldByName('ESPDOC').AsString <> 'OX' then
                  begin
                    Append(' UPDATE EXTGOR SET FGO_STAWMS = "E" ');
                    Append(' WHERE FGO_SEQFGO = :AUTINC ');
                  end
                  else
                  begin
                    Append(' UPDATE OUTDIGX SET DIG_STAWMS = "E" ');
                    Append(' WHERE AUTOINCREM = :AUTINC ');
                  end;

                  ParamByName('AUTINC').AsString := cdsDados.FieldByName('AUTOINCREM').AsString;

                  ExecSQL;
                end;

                fCommit;
              end;
            end;
          end;

          cdsDados.Next;
        End;

        blnEnviado := (strErros.Count = 0);

        if blnEnviado then
        begin
          fMensagem('Sucesso!', 'Dados enviados à API Fusion!', ['&Ok']);

          cdsDados.Filtered := False;
          cdsDados.Filter := '';
          cdsDados.EnableControls;
          cxgDadosTableView1.Controller.FocusedRowIndex := intFocusedRowIndex;

          cdsOutrasEntregas.EmptyDataSet;

          btnAtuali.Click;
        end
        else
          pMensagemErro(strErros.Text);

        cdsDados.Filtered := False;
        cdsDados.Filter := '';
        cdsDados.EnableControls;
        cxgDadosTableView1.Controller.FocusedRowIndex := intFocusedRowIndex;
      end
      else
      begin
        fMensagem('Aviso!', 'Nenhum pedido selecionado! Escolha os pedidos e tente novamente', ['&Ok']);

        cdsDados.Filtered := False;
        cdsDados.Filter := '';
        cdsDados.EnableControls;
        cxgDadosTableView1.Controller.FocusedRowIndex := intFocusedRowIndex;
      end;
    end;
  end;
end;

procedure TfrmLibVendasEntrega.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F2) Then
    btnMarTod.Click
  Else If (Key = VK_F5) Then
    btnAtuali.Click
  Else If (Key = VK_F10) Then
    btnEnvPed.Click
  else if (Key = VK_F11) then
    btnOutrasEntregas.Click
  Else If (Key = VK_F12) Then
    btnItensDoPedido.Click
  else if Key = VK_ESCAPE Then
    Close;
end;

procedure TfrmLibVendasEntrega.FormShow(Sender: TObject);
begin
  inherited;

  pgcExportacoes.ActivePage := tbsExpPedidos;

  qryDados := fCriaQuery(Self);
  dspDados := TUniDataSetProvider.Create(Self);
  cdsDados := TUniClientDataSet.Create(Self);
  cdsDados.SetProvider(dspDados);

  edtCodEmp.Text := VS_strCodEmp;

  if not fEmptyStr(fCfgSis('FUSTRA')) then
  begin
    edtCodTra.Text := fCfgSis('FUSTRA');
    edtNomTra.Text := fRetNomTransportadora(edtCodTra.Text);
  end;

  edtDesEmpresa.Text := fRetNomeEmpresa;
  dtsDados.DataSet := cdsDados;

  dspDados.DataSet := qryDados;

  cdsDados.AfterOpen := pAfterOpen;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy', fNow);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy', fNow);
  pSetFocus(mskDtaIni);

  cdsOutrasEntregas.CreateDataSet;
end;

function TfrmLibVendasEntrega.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = mskDtaIni) Then
  Begin
    If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
    Begin
      mskDtaFin.Clear;
      mskDtaFin.Enabled := False;
    End
    Else
      mskDtaFin.Enabled := True;
  End
  Else If (Sender = mskDtaFin) Then
  Begin
    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&OK']);
        Sender := mskDtaIni;
        Result := False;
      End
      Else If (Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final deve ser maior que a data inicial!', ['&OK']);
        Result := False;
      End;
    End
    Else
    Begin
      If Not (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final deve ser preenchida!', ['&OK']);
        Sender := mskDtaFin;
        Result := False;
      End
    End;
  End
  Else If (Sender = edtCodCli) Then
  Begin
    If (fEmptyStr(edtCodCli.Text)) Then
      edtDesCliente.Text := 'TODOS'
    Else
    Begin
      edtDesCliente.Text := fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [edtCodCli.Text]);
      If fEmptyStr(edtDesCliente.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&OK']);
        Result := False;
      End;
    End;
  End
  Else If (Sender = edtCodEmp) Then
  Begin
    If (fEmptyStr(edtCodEmp.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa deve ser preenchida!', ['&OK']);
      Result := False;
    End
    Else
    Begin
      edtDesEmpresa.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtCodEmp.Text], False);
      If fEmptyStr(edtDesEmpresa.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&OK']);
        Result := False;
      End;
    End;
  End
  Else If (Sender = edtCodVen) Then
  Begin
    If (fEmptyStr(edtCodVen.Text)) Then
      edtNomVen.Text := 'TODOS'
    Else
    Begin
      edtNomVen.Text := fRetNomVendRep(edtCodVen.Text);
      If fEmptyStr(edtNomVen.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Vendedor não está cadastrado!', ['&OK']);
        Result := False;
      End;
    End;
  End
  Else If (Sender = edtEspFat) Then
  Begin
    If (Not fEmptyStr(edtDocFat.Text)) Then
    Begin
      If (fEmptyStr(edtEspFat.Text)) Then
      Begin
        fMensagem('', 'Espécie do documento deve ser preenchida!', ['&OK']);
        Result := False;
      End;
    End;
  End
  Else If (Sender = edtCodTra) Then
  Begin
    If (fEmptyStr(edtCodTra.Text)) Then
      edtNomTra.Text := 'TODAS'
    Else
    Begin
      edtNomTra.Text := fCampoTabela('TRA_NOMTRA', 'CADTRA', ['TRA_CODTRA'],
        [edtCodTra.Text]);
      If (fEmptyStr(edtNomTra.Text)) Then
      Begin
        fMensagem('ATENÇÃO!',
          'Essa Transportadora não está cadastrada!', ['&OK']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmLibVendasEntrega.fValidarBotoes: Boolean;
begin
  Result := (cdsDados.Active) and (not cdsDados.IsEmpty);
  
  if not Result then
    fMensagem('Atenção!',
              'Nenhum dado listado. Realize uma consulta e tente novamente',
              ['&Ok']);
end;

procedure TfrmLibVendasEntrega.pAfterOpen(Dataset: TDataSet);
begin
  With DataSet Do
  Begin
    (FieldByName('VLRCON') As TFloatField).DisplayFormat := '#,###0.00';
  End;
end;

procedure TfrmLibVendasEntrega.pMarcarDesmarcar;
Var
  strNumDoc: String;
  strEspDoc: String;
  strCodEmp: String;
  blnMarDes: Boolean;
  intFocusedRowIndex: Integer;
begin
  if fValidarBotoes then
  begin
    strNumDoc := cdsDados.FieldByName('NUMDOC').AsString;
    strEspDoc := cdsDados.FieldByName('ESPDOC').AsString;
    strCodEmp := cdsDados.FieldByName('EMPDOC').AsString;
    blnMarDes := (cdsDados.FieldByName('MARDES').AsString = 'D');

    cdsDados.DisableControls;
    intFocusedRowIndex := cxgDadosTableView1.Controller.FocusedRowIndex;
    Try
      cdsDados.Filter := 'NUMDOC = ' + QuotedStr(strNumDoc)
                         + ' AND ESPDOC = ' + QuotedStr(strEspDoc)
                         + ' AND EMPDOC = ' + QuotedStr(strCodEmp);

      cdsDados.Filtered := True;
      cdsDados.First;

      While Not cdsDados.Eof Do
      Begin
        cdsDados.Edit;
        cdsDados.FieldByName('MARDES').AsString := IIF(blnMarDes, 'M', 'D');
        cdsDados.Post;
        cdsDados.Next;
      End;
    Finally
      cdsDados.Filtered := False;
      cdsDados.Filter := '';
      cdsDados.EnableControls;
      cxgDadosTableView1.Controller.FocusedRowIndex := intFocusedRowIndex;
    End;
  end;
end;

procedure TfrmLibVendasEntrega.pMarcarDesmarcarTodos;
Var
  intFocusedRowIndex : Integer;
  blnMarDes : Boolean;
begin
  if fValidarBotoes then
  begin
    btnMarTod.Enabled := False;
    cdsDados.DisableControls;
    intFocusedRowIndex := cxgDadosTableView1.Controller.FocusedRowIndex;
    Try
      If (btnMarTod.Caption = '[F2] Marcar Todos Pedidos') Then
      Begin
        btnMarTod.Caption := '[F2] Desmarcar Todos Pedidos';
        blnMarDes := True;
      End
      Else
      Begin
        btnMarTod.Caption := '[F2] Marcar Todos Pedidos';
        blnMarDes := False;
      End;

      cdsDados.First;
      While Not cdsDados.Eof Do
      Begin
        if cdsDados.FieldByName('DOC_STAWMS').AsString <> 'E' then
        begin
          cdsDados.Edit;
          cdsDados.FieldByName('MARDES').AsString := IIF(blnMarDes, 'M', 'D');
          cdsDados.Post;
        end;

        cdsDados.Next;
      End;
    Finally
      cdsDados.EnableControls;
      cxgDadosTableView1.Controller.TopRowIndex := intFocusedRowIndex;
      btnMarTod.Enabled := True;
    End;
  end;
end;

procedure TfrmLibVendasEntrega.pMensagemErro(strMsg: String);
begin
  Try
    pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
    frmMensagemExplicativa.Caption := 'Atenção!';
    frmMensagemExplicativa.mmoInstru.Font.Size := 12;
    frmMensagemExplicativa.mmoInstru.Font.Style := [];

    frmMensagemExplicativa.mmoInstru.Lines.Add(
      'Ocorreram os seguintes erros ao enviar dados para a API Fusion. ' +
      'Verifique e tente novamente:' +sLineBreak
    );

    frmMensagemExplicativa.mmoInstru.Lines.Add(fStrUnicode(strMsg));
    frmMensagemExplicativa.mmoInstru.Alignment := taCenter;
    frmMensagemExplicativa.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmLibVendasEntrega.pMensagemErro]')
  End;

  pFreeAndNil(frmMensagemExplicativa);
end;

function TfrmLibVendasEntrega.fStrUnicode(strText: String): String;
begin
  Result := strText;

  Result := Result.Replace('\u00e1', 'á');
  Result := Result.Replace('\u00e0', 'à');
  Result := Result.Replace('\u00e2', 'â');
  Result := Result.Replace('\u00e3', 'ã');
  Result := Result.Replace('\u00e4', 'ä');
  Result := Result.Replace('\u00c1', 'Á');
  Result := Result.Replace('\u00c0', 'À');
  Result := Result.Replace('\u00c2', 'Â');
  Result := Result.Replace('\u00c3', 'Ã');
  Result := Result.Replace('\u00c4', 'Ä');
  Result := Result.Replace('\u00e9', 'é');
  Result := Result.Replace('\u00e8', 'è');
  Result := Result.Replace('\u00ea', 'ê');
  Result := Result.Replace('\u00ea', 'ê');
  Result := Result.Replace('\u00c9', 'É');
  Result := Result.Replace('\u00c8', 'È');
  Result := Result.Replace('\u00ca', 'Ê');
  Result := Result.Replace('\u00cb', 'Ë');
  Result := Result.Replace('\u00ed', 'í');
  Result := Result.Replace('\u00ec', 'ì');
  Result := Result.Replace('\u00ee', 'î');
  Result := Result.Replace('\u00ef', 'ï');
  Result := Result.Replace('\u00cd', 'Í');
  Result := Result.Replace('\u00cc', 'Ì');
  Result := Result.Replace('\u00ce', 'Î');
  Result := Result.Replace('\u00cf', 'Ï');
  Result := Result.Replace('\u00f3', 'ó');
  Result := Result.Replace('\u00f2', 'ò');
  Result := Result.Replace('\u00f4', 'ô');
  Result := Result.Replace('\u00f5', 'õ');
  Result := Result.Replace('\u00f6', 'ö');
  Result := Result.Replace('\u00d3', 'Ó');
  Result := Result.Replace('\u00d2', 'Ò');
  Result := Result.Replace('\u00d4', 'Ô');
  Result := Result.Replace('\u00d5', 'Õ');
  Result := Result.Replace('\u00d6', 'Ö');
  Result := Result.Replace('\u00fa', 'ú');
  Result := Result.Replace('\u00f9', 'ù');
  Result := Result.Replace('\u00fb', 'û');
  Result := Result.Replace('\u00fc', 'ü');
  Result := Result.Replace('\u00da', 'Ú');
  Result := Result.Replace('\u00d9', 'Ù');
  Result := Result.Replace('\u00db', 'Û');
  Result := Result.Replace('\u00e7', 'ç');
  Result := Result.Replace('\u00c7', 'Ç');
  Result := Result.Replace('\u00f1', 'ñ');
  Result := Result.Replace('\u00d1', 'Ñ');
  Result := Result.Replace('\u0026', '&');
  Result := Result.Replace('\u0027', '`');
  Result := Result.Replace('\/', '/');
end;

procedure TfrmLibVendasEntrega.edtCodCliKeyPress(Sender: TObject; var Key: Char);
var
  arrCli: TConsultasArray;
begin
  inherited;
  if fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCliente, Nil, Key, arrCli) then
  begin
    if fValidaCampos(edtCodCli, True) then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmLibVendasEntrega.ApplicationEventsException(Sender: TObject;
  E: Exception);
begin
  inherited;
  raise Exception.Create(E.Message);
end;

procedure TfrmLibVendasEntrega.btnAtualiClick(Sender: TObject);
begin
  inherited;

  if btnAtuali.Visible then
  begin
    if fValidarBotoes then
      btnFiltrar.Click
  end;
end;

procedure TfrmLibVendasEntrega.btnEnvCliClick(Sender: TObject);
begin
  if (fCfgSis('FUSUSR') = '') or (fCfgSis('FUSSEN') = '') then
  begin
    fMensagem('Atenção!',
              'Usuário e senha da API Fusion não definidos nas configurações.' +sLineBreak
                +'Informe os dados e tente novamente',
              ['&Ok']);

    Exit;
  end;

  Try
    Try
      fMensagem('Atenção!!',
        'Clientes com dados inválidos (Endereço, CEP, CPF)' +sLineBreak
        +'Não serão exportados!', ['&Ok']);

      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.lblGravando.Caption := 'Aguarde... Enviando dados...';
      frmGravando.strChave := 'ENVCLI';
      frmGravando.pgbStatus.Visible := False;
      frmGravando.fExecutarAcao := fEnviarClientes;
      frmGravando.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmLibVendasEntrega.btnEnvCli]');
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmLibVendasEntrega.btnEnviarMotVeiClick(Sender: TObject);
begin
  if (fCfgSis('FUSUSR') = '') or (fCfgSis('FUSSEN') = '') then
  begin
    fMensagem('Atenção!',
              'Usuário e senha da API Fusion não definidos nas configurações.' +sLineBreak
                +'Informe os dados e tente novamente',
              ['&Ok']);

    Exit;
  end;

  Try
    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.lblGravando.Caption := 'Aguarde... Enviando dados...';
      frmGravando.strChave := 'MOTVEI';
      frmGravando.pgbStatus.Visible := False;
      frmGravando.fExecutarAcao := fEnviarMotVei;
      frmGravando.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmLibVendasEntrega.btnFiltrarClick]');
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmLibVendasEntrega.btnEnvPedClick(Sender: TObject);
begin
  inherited;
  Try
      Try
        pCriarFormularios(TfrmGravando, frmGravando);
        frmGravando.lblGravando.Caption := 'Aguarde... Enviando notas para a API..';
        frmGravando.strChave := 'PEDCOM';
        frmGravando.pgbStatus.Visible := False;
        frmGravando.fExecutarAcao := fEnviarNotas;
        frmGravando.ShowModal;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmLibVendasEntrega.btnFiltrarClick]');
      End;
    Finally
      pFreeAndNil(frmGravando);
    End;
end;

procedure TfrmLibVendasEntrega.btnFiltrarClick(Sender: TObject);
begin
  btnFiltrar.Enabled := False;

  Try
    If (Not fVerificaCampos) Then
      Exit;

    Try
      Try
        pCriarFormularios(TfrmGravando, frmGravando);
        frmGravando.lblGravando.Caption := 'Aguarde... Carregando.';
        frmGravando.strChave := 'PEDCOM';
        frmGravando.pgbStatus.Visible := False;
        frmGravando.fExecutarAcao := fCarregaDados;
        frmGravando.ShowModal;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmLibVendasEntrega.btnFiltrarClick]');
      End;
    Finally
      pFreeAndNil(frmGravando);
    End;
  Finally
    btnFiltrar.Enabled := True;
  End;
end;

procedure TfrmLibVendasEntrega.btnItensDoPedidoClick(Sender: TObject);
begin

  if btnItensDoPedido.Visible then
  begin

    if fValidarBotoes then
    begin

      If cxgDadosTableView1.Controller.FocusedRow.ClassName = 'TGridDataRowCitel' Then
      Begin

        If (not fncExecutaRelatorio(187, 7462, [],
                                    ['NUMDOC','ESPDOC','CODEMP'],
                                    [cdsDados.FieldByName('NUMDOC').AsString,
                                    cdsDados.FieldByName('ESPDOC').AsString,
                                    cdsDados.FieldByName('EMPDOC').AsString],
                                    nil, nil, True, False)) Then
        Begin
          fMensagem('Atenção!', 'Nenhum item encontrado para o pedido', ['&Ok']);
        End;

      end;

    End
    Else
    Begin
      fMensagem('Atenção!', 'Deve selecionar uma nota para exibir seus respectivos itens', ['&Ok']);
    end;

  end;

end;

procedure TfrmLibVendasEntrega.btnMarDesClick(Sender: TObject);
begin
  inherited;

  if btnMarDes.Enabled then
    pMarcarDesmarcar;
end;

procedure TfrmLibVendasEntrega.btnMarTodClick(Sender: TObject);
begin
  inherited;
  pMarcarDesmarcarTodos;
end;

procedure TfrmLibVendasEntrega.btnOutrasEntregasClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TFrmFatRomOutEntregas, frmFatRomOutEntregas);
    frmFatRomOutEntregas.Caption := 'Digitação de Outras Entregas - WMS';
    frmFatRomOutEntregas.ShowModal;

    btnFiltrar.Click;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmFatRomaneio.btnOutEntClick]');
  End;
  pFreeAndNil(frmFatRomOutEntregas);
end;

procedure TfrmLibVendasEntrega.cxgDadosTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  With cdsDados Do
  Begin
    If (Not Active) Or (IsEmpty) Then
      Exit;

    If (FindField('MARDES') = Nil) Then
      Exit;

    If (FindField('STAWMS') = Nil) Then
      Exit;

    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgDadosTableView1MARDES.Index]) = 'M' Then
    Begin
      If ACanvas.Brush.Color = clHighlight Then
        ACanvas.Font.Color := clLime
      Else
        ACanvas.Font.Color := clBlue;
    End;

    if ACanvas.Brush.Color <> clHighlight then
    begin
      if VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgDadosTableView1SEMAFORO.Index]) = 'VERDE' then
        ACanvas.Brush.Color := clWebLightGreen
      else if VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgDadosTableView1SEMAFORO.Index]) = 'AMARELO' then
        ACanvas.Brush.Color := clWebKhaki
      else
        ACanvas.Brush.Color := clWebSalmon;
    end;
  End;
end;

procedure TfrmLibVendasEntrega.cxgDadosTableView1FocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;

  // Desabilita a marcação se a nota já tiver sido enviada
  // ainda respeitando o direito de acesso 'LIBWMS'
  btnMarDes.Enabled := (cdsDados.FieldByName('STATUS').AsString <> 'E');
  btnMarDes.Refresh;
end;

procedure TfrmLibVendasEntrega.cxgDadosTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    btnMarDes.Click;
end;

procedure TfrmLibVendasEntrega.cxgOutrasEntregasDBTableView1DataControllerDataChanged(
  Sender: TObject);
begin
  inherited;

  if cdsOutrasEntregas.Active then
    cxgOutrasEntregas.Visible := (cdsOutrasEntregas.RecordCount > 0);
end;

end.
