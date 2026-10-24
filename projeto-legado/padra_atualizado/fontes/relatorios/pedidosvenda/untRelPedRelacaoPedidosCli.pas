unit untRelPedRelacaoPedidosCli;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, Mask, MaskEditFocus, RLFilters, RLDraftFilter,
  Menus, StdCtrls, EditFocus, QColorLabel, Buttons, ExtCtrls, frxDesgn,
  frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML, RLReport,
  frxExportXLS, frxExportRTF, AppEvnts, untTypesSistema, untClassPanelCX,
  BitBtnLockedIncrem, Uni, ComCtrls, ComboBoxFocus, UniClientDataSet, strUtils,
  DB, frxExportCSVTestabilidade, untExcel, untGeraExcel;

type
  TfrmRelPedRelacaoPedidosCli = class(TfrmPaiRelatorio)
    Label11: TLabel;
    lblDesDtaIni: TLabel;
    lblDesDtaFin: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    rdgFaturamento: TRadioGroup;
    gpbTipo: TGroupBox;
    ColorLabel2: TColorLabel;
    edtTipo: TEditFocus;
    rdgTipQtd: TRadioGroup;
    rdgTipOpe: TRadioGroup;
    chkItePen: TCheckBox;
    lbl1: TLabel;
    edtCodReg: TEditFocus;
    edtNomReg: TEditFocus;
    pnlFilLib: TPanel;
    gpbLibFin: TGroupBox;
    ColorLabel3: TColorLabel;
    edtLibFin: TEditFocus;
    gpbLibCom: TGroupBox;
    ColorLabel4: TColorLabel;
    edtLibCom: TEditFocus;
    lblCodDig: TLabel;
    edtCodDig: TEditFocus;
    edtNomDig: TEditFocus;
    pgbProgresso: TProgressBar;
    lblTabPre: TLabel;
    cbxTabPre: TComboBoxFocus;
    edtCodCid: TEditFocus;
    lblCodCid: TLabel;
    edtNomCid: TEditFocus;
    Label1: TLabel;
    edtCodVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    Label3: TLabel;
    edtCodMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    chkImpRef: TCheckBox;
    chkImpMar: TCheckBox;
    shaVen: TShape;
    rgbVisItens: TRadioGroup;
    gpbDtaPre: TGroupBox;
    ColorLabel5: TColorLabel;
    edtDtaPre: TEditFocus;
    chkPedImp: TCheckBox;
    pnlOcorrencia: TPanel;
    Label5: TLabel;
    edtCodOco: TEditFocus;
    edtDesOco: TEditFocus;
    chkCliFil: TCheckBox;
    pnlFaseObra: TPanel;
    Label6: TLabel;
    edtCodFase: TEditFocus;
    edtDesFase: TEditFocus;
    Panel1: TPanel;
    chkFreImp: TCheckBox;
    rdgOrigem: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure rdgFaturamentoExit(Sender: TObject);
    procedure chkItePenClick(Sender: TObject);
    procedure rdgFaturamentoClick(Sender: TObject);
    procedure rdgTipQtdClick(Sender: TObject);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDigKeyPress(Sender: TObject; var Key: Char);
    procedure edtDestinoExit(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidExit(Sender: TObject);
    procedure edtCodDigExit(Sender: TObject);
    procedure edtCodRegExit(Sender: TObject);
    procedure edtTipoChange(Sender: TObject);
    procedure edtCodMarcaExit(Sender: TObject);
    procedure edtCodMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVendedorExit(Sender: TObject);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodOcoExit(Sender: TObject);
    procedure edtCodOcoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodFaseExit(Sender: TObject);
    procedure edtCodFaseKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    strTitQtd: String;
    strVended: String;
    blnLiberadoVen: Boolean;
    qryRelatorio: TUniQuery;
    blnUsaDig: Boolean;

		procedure pCriaQryRelatorio;
    procedure pGeraExcel(DataSet: TDataSet);
    procedure pImprimeDetalhes(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
    procedure pCarregaPrecos;
    function fRetTabPre: String;
    function fRetCampoPre: String;
    function fRetornaLinha(arrLinha: TConsultasArray; strText: String): String;
    function fCriaClientDataSetPedidoItens(qryItens: TUniQuery): TUniClientDataSet;
    function fGetSqlPesoLitroKilo(strCampo: String; strTipUni: String): String;
    procedure pVerdeVermelho(edtCodVenRep: TEditFocus; shaVenRep: TShape;
      blnLiberado: Boolean);
    function fGetTituloDtaPrevis: String;
    function fGetWhere : String;
    procedure pAcertaTela(blnOcorrencia: Boolean);
  public
    { Public declarations }
    arrClientes : TConsultasArray;
    arrCidade   : TConsultasArray;
    arrDigitador: TConsultasArray;
    arrRegiao   : TConsultasArray;
    arrMarca    : TConsultasArray;
    arrVendedor : TConsultasArray;
    arrOcorre   : TConsultasArray;
    arrFase     : TConsultasArray;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelPedRelacaoPedidosCli: TfrmRelPedRelacaoPedidosCli;

implementation

uses untPai, untFuncoesFactory, untConstantes, untQckPedRelacaoPedidosCli, untIFuncoes;

{$R *.dfm}

procedure TfrmRelPedRelacaoPedidosCli.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;
  blnLiberadoVen := fVerificaAcessoSistema('RPDCLIVEN');
  pVerdeVermelho(edtCodVendedor, shaVen, blnLiberadoVen);

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  strTitQtd := 'QTDE.';
  If Not fCfgSis('USADIG', varBoolean) Then
  Begin
    lblCodDig.Visible  := False;
    edtCodDig.Visible  := False;
    edtNomDig.Visible  := False;

    Label1.Top         := Label1.Top - 38;
    edtCodVendedor.Top := edtCodVendedor.Top - 38;
    edtDesVendedor.Top := edtDesVendedor.Top - 38;
    shaVen.Top         := shaVen.Top - 38;

    lblCodCid.Top      := lblCodCid.Top - 38;
    edtCodCid.Top      := edtCodCid.Top - 38;
    edtNomCid.Top      := edtNomCid.Top - 38;

    gpbTipo.Top        := gpbTipo.Top - 38;
    gpbDestino.Top     := gpbDestino.Top - 38;

    rdgFaturamento.Top := rdgFaturamento.Top - 38;
    rdgTipQtd.Top      := rdgTipQtd.Top - 38;
    lblTabPre.Top      := lblTabPre.Top - 38;
    cbxTabPre.Top      := cbxTabPre.Top - 38;

    chkItePen.Top      := chkItePen.Top - 38;
    chkImpRef.Top      := chkImpRef.Top - 38;
    chkImpMar.Top      := chkImpMar.Top - 38;
    rdgTipOpe.Top      := rdgTipOpe.Top - 38;

  End;

  rdgFaturamentoClick(rdgFaturamento);
  rgbVisItens.Enabled := (edtTipo.Text = 'A');

  If fCfgSis('FASOBR') = 'S' Then
    pnlFaseObra.Visible := True
  Else
    pnlFaseObra.Visible := False;

  pAcertaTela(False);
  inherited;
end;

procedure TfrmRelPedRelacaoPedidosCli.chkItePenClick(Sender: TObject);
begin
  inherited;
  fValidaCampos(chkItePen, False);
end;

procedure TfrmRelPedRelacaoPedidosCli.edtCodCidExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCid, edtNomCid, arrCidade, fRetNomCidadeSemOpc, nil, 'da Cidade');
end;

procedure TfrmRelPedRelacaoPedidosCli.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCodCid, edtNomCid, Nil, Nil, Key, arrCidade, False) Then
	Begin
		fValidaCampos(edtCodCid, False);
		Self.SelectNext(ActiveControl, True, True);
	End;
end;

procedure TfrmRelPedRelacaoPedidosCli.edtCodClienteExit(Sender: TObject);
begin
  inherited;
  If Not edtCodCliente.ReadOnly Then
    pEdtCodSelectExit(edtCodCliente, edtDesCliente, arrClientes, Nil, fRetNomCliente, 'do cliente');
end;

procedure TfrmRelPedRelacaoPedidosCli.edtCodClienteKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes, False) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelPedRelacaoPedidosCli.edtCodDigExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDig, edtNomDig, arrDigitador, fRetNomVendRep, Nil, 'do digitador');
end;

procedure TfrmRelPedRelacaoPedidosCli.edtCodDigKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodDig, edtNomDig, Nil, Key, arrDigitador, False) Then
  Begin
    If fValidaCampos(edtCodDig, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelPedRelacaoPedidosCli.edtCodFaseExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFase,edtDesFase,arrFase,nil,fRetNomFaseObra,'da fase da obra');
end;

procedure TfrmRelPedRelacaoPedidosCli.edtCodFaseKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFaseObra(Self, edtCodFase, edtDesFase, Nil, Key, arrFase, False) Then
  Begin
    If fValidaCampos(edtCodFase, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelPedRelacaoPedidosCli.edtCodMarcaExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodMarca, edtDesMarca, arrMarca, fRetNomMarca, nil, 'da Marca');
end;

procedure TfrmRelPedRelacaoPedidosCli.edtCodMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqMarcas(Self, edtCodMarca, edtDesMarca, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtCodMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelPedRelacaoPedidosCli.edtCodOcoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodOco,edtDesOco,arrOcorre,nil,fRetDescOcorrencia,'da ocorrência');
end;

procedure TfrmRelPedRelacaoPedidosCli.edtCodOcoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {********************************}
  {* NOVA CONSULTA DE OCORRÊNCIAS *}
  {*****************************RV*}
  If fPesqOcorrencia(Self, edtCodOco, edtDesOco, Nil, Key, arrOcorre) Then
  Begin
    If fValidaCampos(edtCodOco, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelPedRelacaoPedidosCli.edtCodRegExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodReg, edtNomReg, arrRegiao, Nil, fRetNomRegiao, 'da região');
end;

procedure TfrmRelPedRelacaoPedidosCli.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE REGIOES *}
  {*************************DP*}
  If fPesqRegiao(Self, edtCodReg, edtNomReg, Nil, Key, arrRegiao, False) Then
  Begin
    if fValidaCampos(edtCodReg, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelPedRelacaoPedidosCli.edtCodVendedorExit(Sender: TObject);
begin
  inherited;
  If blnLiberadoVen Then
    pEdtCodSelectExit(edtCodVendedor, edtDesVendedor, arrVendedor, fRetNomVendRep, nil, 'do Vendedor');
end;

procedure TfrmRelPedRelacaoPedidosCli.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (blnLiberadoVen) And fPesqOperador(Self, edtCodVendedor, edtDesVendedor, nil, Key, arrVendedor, False) Then
  Begin
    fValidaCampos(edtCodVendedor, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelPedRelacaoPedidosCli.edtDestinoExit(Sender: TObject);
begin
  //inherited;
end;

procedure TfrmRelPedRelacaoPedidosCli.edtTipoChange(Sender: TObject);
begin
  inherited;
  rgbVisItens.Enabled := (edtTipo.Text = 'A');

  if (not rgbVisItens.Enabled) then
    rgbVisItens.ItemIndex := 0;

  chkImpRef.Enabled := (edtTipo.Text = 'A');
  chkImpRef.Checked := (edtTipo.Text = 'A');
  chkImpMar.Enabled := (edtTipo.Text = 'A');
  chkImpMar.Checked := (edtTipo.Text = 'A');
end;

procedure TfrmRelPedRelacaoPedidosCli.btnImprimirClick(Sender: TObject);
  Var
    strSQL      : String;
    strClientes : String;
    strDigitador: String;
    strRegiao   : String;
    strOcorre   : String;
    strMarca    : String;
    strTabFut   : String;
    strVendedor : String;
    strFase     : String;
    blnTemRegistros: Boolean;
    cdsItensAna: TUniClientDataSet;

  function fRetTotIte : String;
  Begin
    If chkFreImp.Checked Then
      Result := ' FDO_TOTITE + FDO_VALIPI + FDO_VALRET + FDO_TOTFRE' + fRelSqlValorReformaFdoRef('D.AUTOINCREM') + ' - FDO_DESESP '
    Else
      Result := ' FDO_TOTITE - FDO_DESESP ';
  End;

  function fRetornaSQLDescricaoServ: String;
    Var
      i: Integer;
      sDesSer, sValSer: String;
  begin
    sDesSer := '  CONCAT("     ", ';

    If strTipImp = 'M' Then
      sDesSer := sDesSer + '  CONCAT("Codigo  ", RPAD("Descricao", 80, " "), '
    Else
      sDesSer := sDesSer + '  CONCAT("Código  ", RPAD("Descrição", 80, " "), ';

    sDesSer := AnsiUpperCase(sDesSer) + '"<<csq>>"), ';

    For i := 1 To 30 Do Begin
      sDesSer := sDesSer + 'IF(IFNULL(FGO_CODS' + FormatFloat('##00', i) + ', "") = "", "", ';
      sDesSer := sDesSer + '  IF((FDO_CODITE = :SERTER) AND ((SELECT SER_TERCER FROM CADSER WHERE SER_CODSER = FGO_CODS' + FormatFloat('##00', i) + ') = "S"), ';
      sDesSer := sDesSer + '    CONCAT("     ", FGO_CODS' + FormatFloat('##00', i) + ', " - ", RPAD(FGO_DESS' + FormatFloat('##00', i) + ', 80, " "), "<<csq>>"), ';
      sDesSer := sDesSer + '      IF((FDO_CODITE = :ITESER) AND ((SELECT SER_TERCER FROM CADSER WHERE SER_CODSER = FGO_CODS' + FormatFloat('##00', i) + ') = "N"), ';
      sDesSer := sDesSer + '        CONCAT("     ", FGO_CODS' + FormatFloat('##00', i) + ', " - ", RPAD(FGO_DESS' + FormatFloat('##00', i) + ', 80, " "), "<<csq>>"), "")))';

      If (i < 30) Then sDesSer := sDesSer + ', ';
    End;

    sDesSer := sDesSer + ') AS DESSER, ';

    sValSer := sValSer + '  CONCAT( ';

    If strTipImp = 'M' Then
      sValSer := sValSer + '  CONCAT(LPAD("Qtd.", 26, " "), " ", LPAD("Unit.", 19, " ") , " ", LPAD("Total", 19, " "), '
    Else
      sValSer := sValSer + '  CONCAT(LPAD("Qtd.", 26, " "), " ", LPAD("Unit.", 19, " ") , " ", LPAD("Total", 19, " "), ';

    sValSer := AnsiUpperCase(sValSer) + '"<<csq>>"), ';

    For i := 1 To 30 Do Begin
      sValSer := sValSer + 'IF(IFNULL(FGO_CODS' + FormatFloat('##00', i) + ', "") = "", "", ';
      sValSer := sValSer + '  IF((FDO_CODITE = :SERTER) AND ((SELECT SER_TERCER FROM CADSER WHERE SER_CODSER = FGO_CODS' + FormatFloat('##00', i) + ') = "S"), ';

      If (edtDestino.Text <> 'E') And (strTipImp <> 'M') Then Begin
        sValSer := sValSer + '    CONCAT(LPAD(FORMAT(FGO_QTDS' + FormatFloat('##00', i) + ', 2), 27, " "), " ", LPAD(FORMAT(FGO_UNIS' + FormatFloat('##00', i) + ', 2), 20, " "), " ", ';
        sValSer := sValSer + '      LPAD(FORMAT(FGO_VALS' + FormatFloat('##00', i) + ', 2), 21, " "), "<<csq>>"), IF((FDO_CODITE = :ITESER) AND ( ';
      End Else Begin
        sValSer := sValSer + '    CONCAT(LPAD(FORMAT(FGO_QTDS' + FormatFloat('##00', i) + ', 2), 26, " "), " ", LPAD(FORMAT(FGO_UNIS' + FormatFloat('##00', i) + ', 2), 19, " "), " ", ';
        sValSer := sValSer + '      LPAD(FORMAT(FGO_VALS' + FormatFloat('##00', i) + ', 2), 19, " "), "<<csq>>"), IF((FDO_CODITE = :ITESER) AND ( ';
      End;

      sValSer := sValSer + '      (SELECT SER_TERCER FROM CADSER WHERE SER_CODSER = FGO_CODS' + FormatFloat('##00', i) + ') = "N"), ';

      If (edtDestino.Text <> 'E') And (strTipImp <> 'M') Then Begin
        sValSer := sValSer + '    CONCAT(LPAD(FORMAT(FGO_QTDS' + FormatFloat('##00', i) + ', 2), 27, " "), " ", LPAD(FORMAT(FGO_UNIS' + FormatFloat('##00', i) + ', 2), 20, " "), " ", ';
        sValSer := sValSer + '      LPAD(FORMAT(FGO_VALS' + FormatFloat('##00', i) + ', 2), 21, " "), "<<csq>>"), ""))) ';
      End Else Begin
        sValSer := sValSer + '    CONCAT(LPAD(FORMAT(FGO_QTDS' + FormatFloat('##00', i) + ', 2), 26, " "), " ", LPAD(FORMAT(FGO_UNIS' + FormatFloat('##00', i) + ', 2), 19, " "), " ", ';
        sValSer := sValSer + '      LPAD(FORMAT(FGO_VALS' + FormatFloat('##00', i) + ', 2), 19, " "), "<<csq>>"), ""))) ';
      End;

      If (i < 30) Then sValSer := sValSer + ', ';
    End;

    sValSer := sValSer + ') AS VALSER ';

    Result := sDesSer + sValser;
  end;

begin
  inherited;
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  If blnImprime Then
  Begin
    strTabFut := fGetMemoryTableNameEntregaFutura;
    fCriaMemoryTableEntregaFutura(strTabFut, VS_strCodEmp, '', '', False, False, True);

    {************************}
    {* VERIFICA RELATORIO   *}
    {* ANALITICO/SINTETICO  *}
    {*********************JB*}
    If SameText(edtTipo.Text, 'A') Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  FDO_CODCLI AS CODCLI, ';
      strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', '"SIM"', '"NAO"') + ' AS CLICON, ';
      strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', 'FGO_NOMCON', 'CLI_NOMCLI') + ' AS RAZCLI, ';
      strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', 'FGO_NOMCON', 'CLI_FANSOB') + ' AS FANCLI, ';
      strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', 'FGO_TELCON', 'CLI_FONE01') + ' AS FONE01, ';
      strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', 'CONCAT(FDO_CODCLI,"-",FGO_NOMCON)', 'CONCAT(FDO_CODCLI,"-",CLI_NOMCLI)') + ' AS NOMCLI, ';
      strSQL := strSQL + '  FDO_NUMDOC AS NUMDOC, ';
      strSQL := strSQL + '  FDO_DTAENT AS DTAENT, ';
      strSQL := strSQL + '  FDO_CONPAG AS CONPAG, ';
      strSQL := strSQL + '  FDO_CODVEN AS CODVEN, ';
      strSQL := strSQL + '  CONCAT(LEFT(GRU_CODGRU,3),".",RIGHT(GRU_CODGRU,3),".",FDO_CODITE) AS CODITE, ';
      strSQL := strSQL + '  FDO_CODEMP AS CODEMP, ';      
      strSQL := strSQL + '  FDO_DESCRI AS DESCRI, ';
      strSQL := strSQL + '  FDO_UNIDAD AS UNIDAD, ';
      strSQL := strSQL + '  UNI_SIGUNI AS SIGUNI, ';
      strSQL := strSQL + '  FDO_REFERE AS REFERE, ';
      strSQL := strSQL + '  FDO_UNITAR - (IF(FDO_DESESP = 0.00, 0.00, (FDO_DESESP / FDO_QTDITE))) AS UNITAR, ';
      strSQL := strSQL + fRetCampoPre + ' AS SUGERI, ';

      strSQL := strSQL + '  FDO_QTDITE AS QTDORI, ';
      strSQL := strSQL + '  CONCAT(FGO_MOTBAI," ",IF(IFNULL(FGO_CODOCO,0) = 0,"",CONCAT("OCORRÊNCIA: ", OCO_DESOCO))) AS MOTBAI, ';

      If (fCfgSis('BEFTRG', VarBoolean)) Then
        strSQL := strSQL + '  G.ITE_SALDOS AS SALDOS,  '
      Else
        strSQL := strSQL + '  G.ITE_SALDOS + IFNULL(QTDPEN, 0) AS SALDOS,  ';

     if rdgOrigem.ItemIndex <> 1 then
        strSQL := strSQL + '  FGO_NUMPOK AS NUMPOK, DATAIMPORTACAO, HORAIMPORTACAO, '
     else
        strSQL := strSQL + '  "" AS NUMPOK, "" AS DATAIMPORTACAO, "" AS HORAIMPORTACAO, ' ;

      Case rdgFaturamento.ItemIndex Of
        0: strSQL := strSQL + ' FDO_QTDITE AS QTDITE, ';

        1: If rdgTipQtd.ItemIndex = 0 Then
             strSQL := strSQL + ' IF(FDO_JAFATU = 1 AND FDO_QTDBAI = 0, FDO_QTDITE, FDO_QTDBAI) AS QTDITE, '
           Else
             strSQL := strSQL + ' IF(FDO_JAFATU = 1, 0, (FDO_QTDITE - FDO_QTDBAI)) AS QTDITE, ';

        2,
        3: strSQL := strSQL + ' (FDO_QTDITE - FDO_QTDBAI) AS QTDITE, ';
      End;

      Case rdgFaturamento.ItemIndex Of
        0:
        Begin
          strSQL := strSQL + ' FDO_QTDITE * IFNULL(UNI_PESLIT, 0) / :LITGAL AS LITRAG, ';

          {******************************************************}
          {* SOMATÓRIA DOS PESOS EM KILO E LITROS SEPARADAMENTE *}
          {****************************************************FC}
          strSQL := strSQL + fGetSqlPesoLitroKilo('FDO_QTDITE * IFNULL(UNI_PESLIT, 0) / :LITGAL', 'L') + ' AS TOTLIT, ';
          strSQL := strSQL + fGetSqlPesoLitroKilo('FDO_QTDITE * IFNULL(UNI_PESLIT, 0) / :LITGAL', 'K') + ' AS TOTKIL, ';
        End;
        1:
        Begin
          If rdgTipQtd.ItemIndex = 0 Then
          Begin
            strSQL := strSQL + ' IF(FDO_JAFATU = 1 AND FDO_QTDBAI = 0, FDO_QTDITE, FDO_QTDBAI) * IFNULL(UNI_PESLIT, 0) / :LITGAL AS LITRAG, ';

            {******************************************************}
            {* SOMATÓRIA DOS PESOS EM KILO E LITROS SEPARADAMENTE *}
            {****************************************************FC}
            strSQL := strSQL + fGetSqlPesoLitroKilo('IF(FDO_JAFATU = 1 AND FDO_QTDBAI = 0, FDO_QTDITE, FDO_QTDBAI) * IFNULL(UNI_PESLIT, 0) / :LITGAL', 'L') + ' AS TOTLIT, ';
            strSQL := strSQL + fGetSqlPesoLitroKilo('IF(FDO_JAFATU = 1 AND FDO_QTDBAI = 0, FDO_QTDITE, FDO_QTDBAI) * IFNULL(UNI_PESLIT, 0) / :LITGAL', 'K') + ' AS TOTKIL, ';
          End
          Else
          Begin
            strSQL := strSQL + ' IF(FDO_JAFATU = 1, 0, (FDO_QTDITE - FDO_QTDBAI)) * IFNULL(UNI_PESLIT, 0) / :LITGAL AS LITRAG, ';

            {******************************************************}
            {* SOMATÓRIA DOS PESOS EM KILO E LITROS SEPARADAMENTE *}
            {****************************************************FC}
            strSQL := strSQL + fGetSqlPesoLitroKilo('IF(FDO_JAFATU = 1, 0, (FDO_QTDITE - FDO_QTDBAI)) * IFNULL(UNI_PESLIT, 0) / :LITGAL', 'L') + ' AS TOTLIT, ';
            strSQL := strSQL + fGetSqlPesoLitroKilo('IF(FDO_JAFATU = 1, 0, (FDO_QTDITE - FDO_QTDBAI)) * IFNULL(UNI_PESLIT, 0) / :LITGAL', 'K') + ' AS TOTKIL, ';
          End;
        End;
        2,
        3:
        Begin
          strSQL := strSQL + ' (FDO_QTDITE - FDO_QTDBAI) * IFNULL(UNI_PESLIT, 0) / :LITGAL AS LITRAG, ';

          {******************************************************}
          {* SOMATÓRIA DOS PESOS EM KILO E LITROS SEPARADAMENTE *}
          {****************************************************FC}
          strSQL := strSQL + fGetSqlPesoLitroKilo('(FDO_QTDITE - FDO_QTDBAI) * IFNULL(UNI_PESLIT, 0) / :LITGAL', 'L') + ' AS TOTLIT, ';
          strSQL := strSQL + fGetSqlPesoLitroKilo('(FDO_QTDITE - FDO_QTDBAI) * IFNULL(UNI_PESLIT, 0) / :LITGAL', 'K') + ' AS TOTKIL, ';
        End;
      End;

      Case rdgFaturamento.ItemIndex Of
        0: strSQL := strSQL + ' (' + fRetTotIte + ') AS TOTITE, ';

        1: If rdgTipQtd.ItemIndex = 0 Then
             strSQL := strSQL + ' (IF(FDO_JAFATU = 1 AND FDO_QTDBAI = 0, FDO_QTDITE, FDO_QTDBAI) * ((' + fRetTotIte + ') / FDO_QTDITE)) AS TOTITE, '
           Else
             strSQL := strSQL + ' (IF(FDO_JAFATU = 1, 0, (FDO_QTDITE - FDO_QTDBAI)) * ((' + fRetTotIte + ') / FDO_QTDITE)) AS TOTITE, ';

        2,
        3: strSQL := strSQL + ' ((FDO_QTDITE - FDO_QTDBAI) * ((' + fRetTotIte + ') / FDO_QTDITE)) AS TOTITE, ';
      End;

      strSQL := strSQL + '  (SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '    SUM(IF(CTR_SEQBAI = 0, CTR_VALDUP, CTR_VALORI)) ';
      strSQL := strSQL + '   FROM ';
      strSQL := strSQL + '    CADREC  ';
      strSQL := strSQL + '   WHERE ';
      strSQL := strSQL + '    CTR_NUMDUP = FGO_NUMDOC AND ';
      strSQL := strSQL + '    CTR_ESPDOC = FGO_ESPDOC AND ';
      strSQL := strSQL + '    CTR_CODEMP = FGO_CODEMP) AS PGAANT, ';

      strSQL := strSQL + '  MAR_DESMAR AS DESMAR, ';

      {**************************}
      {* DADOS DO FATURAMENTO   *}
      {***********************JC*}
      strSQL := strSQL + '  (SELECT GROUP_CONCAT(DISTINCT CONCAT(" ", DET_NUMDOC, "-", ';
      strSQL := strSQL + '                                            DET_ESPDOC, "-", ';
      strSQL := strSQL + '                                            DET_CODEMP, " ", ';
      strSQL := strSQL + '                                            DATE_FORMAT(DET_DTADOC, "%d/%m/%Y"), " ", ';
      strSQL := strSQL + '                                            CONCAT(DET_CODVEN,"-",(SELECT OPE_NOMOPE FROM CADOPE WHERE DET_CODVEN = OPE_CODOPE)))) FROM MOVDET ';
      strSQL := strSQL + '    WHERE DET_NUM_PD = FDO_NUMDOC AND          ';
      strSQL := strSQL + '          DET_ESP_PD = FDO_ESPDOC AND          ';
      strSQL := strSQL + '          DET_EMP_PD = FDO_CODEMP) AS DOCFAT,  ';
      {*************************************************}
      {* PESO BRUTO E MOTIVO DE BLOQUEIO COMERCIAL     *}
      {**********************************************RV*}
      strSQL := strSQL + '  FGO_PESBRU AS PESBRU, ';
      strSQL := strSQL + '  FGO_MOTLIB AS MOTLIB, ';
      strSQL := strSQL + '  CONCAT(FDO_CODVEN,"-",OPE_NOMOPE) AS DESVEN, ';
      strSQL := strSQL + fRetornaSQLDescricaoServ();
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  FATDOR D ';
      strSQL := strSQL + '  INNER JOIN CADCLI ON FDO_CODCLI = CLI_CODCLI ';
      strSQL := strSQL + '  INNER JOIN CADOPE ON FDO_CODVEN = OPE_CODOPE ';
      strSQL := strSQL + '  INNER JOIN CADMAR ON FDO_CODMAR = MAR_CODMAR ';
      strSQL := strSQL + '  INNER JOIN FATGOR ON FDO_NUMDOC = FGO_NUMDOC ';
      strSQL := strSQL + '                   AND FDO_ESPDOC = FGO_ESPDOC ';
      strSQL := strSQL + '                   AND FDO_CODCLI = FGO_CODCLI ';
      strSQL := strSQL + '                   AND FDO_CODEMP = FGO_CODEMP ';
      strSQL := strSQL + '  INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
      strSQL := strSQL + '  INNER JOIN CADITE C ON C.ITE_CODITE = FDO_CODITE ';
      strSQL := strSQL + '  INNER JOIN ITEGER G ON G.ITE_CODITE = FDO_CODITE ';
      strSQL := strSQL + '                     AND G.ITE_CODEMP = FDO_CODEMP ';

      {*********************************************}
      {* OBTENDO A QTDE PENDENTA DA ENTREGA FUTURA *}
      {*******************************************FC}
      strSQL := strSQL + '  LEFT  JOIN ' + strTabFut + ' AS DETFUT ON DETFUT.DET_CODITE = G.ITE_CODITE ';
      strSQL := strSQL + '                                        AND DETFUT.DET_CODEMP = G.ITE_CODEMP ';

      strSQL := strSQL + '  INNER JOIN CADGRU ON GRU_CODGRU = C.ITE_CODGRU ';
      strSQL := strSQL + '  LEFT  JOIN CADUNI ON D.FDO_UNIDAD = UNI_CODUNI ';
      strSQL := strSQL + '  LEFT  JOIN CADOCO ON EXTGOR.FGO_CODOCO = CADOCO.OCO_CODOCO ';
      strSQL := strSQL + '  LEFT JOIN SERGOR ON SERGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
      if rdgOrigem.ItemIndex <> 1 then
        strSQL := strSQL + '  LEFT JOIN FSPEDIDOCAB ON NUMEROPEDIDO = FGO_NUMPOK ';
      strSQL := strSQL + fGetWhere;
    End
    Else
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  SUM(' + IfThen(rdgTipQtd.ItemIndex = 0, ' FDO_QTDITE', ' IF(FDO_JAFATU = 1, 0, (FDO_QTDITE - FDO_QTDBAI)) ') + ' * IFNULL(UNI_PESLIT, 0) / :LITGAL) AS LITRAG, ';

      {******************************************************}
      {* SOMATÓRIA DOS PESOS EM KILO E LITROS SEPARADAMENTE *}
      {****************************************************FC}
      strSQL := strSQL + fGetSqlPesoLitroKilo(IfThen(rdgTipQtd.ItemIndex = 0, ' FDO_QTDITE', ' IF(FDO_JAFATU = 1, 0, (FDO_QTDITE - FDO_QTDBAI)) ') + ' * IFNULL(UNI_PESLIT, 0) / :LITGAL', 'L') + ' AS TOTLIT, ';
      strSQL := strSQL + fGetSqlPesoLitroKilo(IfThen(rdgTipQtd.ItemIndex = 0, ' FDO_QTDITE', ' IF(FDO_JAFATU = 1, 0, (FDO_QTDITE - FDO_QTDBAI)) ') + ' * IFNULL(UNI_PESLIT, 0) / :LITGAL', 'K') + ' AS TOTKIL, ';

      strSQL := strSQL + '  FDO_CODCLI AS CODCLI, ';
      strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', '"SIM"', '"NAO"') + ' AS CLICON, ';
      strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', 'FGO_NOMCON', 'CLI_NOMCLI') + ' AS RAZCLI, ';
      strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', 'FGO_NOMCON', 'CLI_FANSOB') + ' AS FANCLI, ';
      strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', 'FGO_TELCON', 'CLI_FONE01') + ' AS FONE01, ';
      strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', 'CONCAT(FDO_CODCLI,"-",FGO_NOMCON)', 'CONCAT(FDO_CODCLI,"-",CLI_NOMCLI)') + ' AS NOMCLI, ';
      strSQL := strSQL + '  FDO_CODVEN AS CODVEN, ';
      strSQL := strSQL + '  FDO_NUMDOC AS NUMDOC, ';
      strSQL := strSQL + '  FDO_DTAENT AS DTAENT, ';
      strSQL := strSQL + '  FDO_CONPAG AS CONPAG, ';

      if rdgOrigem.ItemIndex <> 1 then
         strSQL := strSQL + '  FGO_NUMPOK AS NUMPOK, DATAIMPORTACAO, HORAIMPORTACAO, '
      else
         strSQL := strSQL + '  "" AS NUMPOK, "" AS DATAIMPORTACAO, "" AS HORAIMPORTACAO, ' ;

      {**************************}
      {* DADOS DO FATURAMENTO   *}
      {***********************JC*}

      strSQL := strSQL + '  (SELECT GROUP_CONCAT(DISTINCT CONCAT(" ", DET_NUMDOC, "-", ';
      strSQL := strSQL + '                                            DET_ESPDOC, "-", ';
      strSQL := strSQL + '                                            DET_CODEMP, " ", ';
      strSQL := strSQL + '                                            DATE_FORMAT(DET_DTADOC, "%d/%m/%Y"), " ", ';
      strSQL := strSQL + '                                            CONCAT(DET_CODVEN,"-",(SELECT OPE_NOMOPE FROM CADOPE WHERE DET_CODVEN = OPE_CODOPE)))) FROM MOVDET ';
      strSQL := strSQL + '    WHERE DET_NUM_PD = FDO_NUMDOC AND          ';
      strSQL := strSQL + '          DET_ESP_PD = FDO_ESPDOC AND          ';
      strSQL := strSQL + '          DET_EMP_PD = FDO_CODEMP) AS DOCFAT,  ';
      {*************************************************}
      {* PESO BRUTO E MOTIVO DE BLOQUEIO COMERCIAL     *}
      {**********************************************RV*}
      strSQL := strSQL + '  FGO_PESBRU AS PESBRU, ';
      strSQL := strSQL + '  FGO_MOTLIB AS MOTLIB, ';
      strSQL := strSQL + '  CONCAT(FGO_MOTBAI," ",IF(IFNULL(FGO_CODOCO,0) = 0,"",CONCAT("OCORRÊNCIA: ", OCO_DESOCO))) AS MOTBAI, ';

      Case rdgFaturamento.ItemIndex Of
        0: strSQL := strSQL + ' SUM(' + fRetTotIte + ') AS TOTITE, ';

        1: If rdgTipQtd.ItemIndex = 0 Then
             strSQL := strSQL + ' SUM(IF(FDO_JAFATU = 1 AND FDO_QTDBAI = 0, FDO_QTDITE, FDO_QTDBAI) * ((' + fRetTotIte + ') / FDO_QTDITE)) AS TOTITE, '
           Else
             strSQL := strSQL + ' SUM(IF(FDO_JAFATU = 1, 0, (FDO_QTDITE - FDO_QTDBAI)) * ((' + fRetTotIte + ') / FDO_QTDITE)) AS TOTITE, ';

        2,
        3: strSQL := strSQL + ' SUM((FDO_QTDITE - FDO_QTDBAI) * ((' + fRetTotIte + ') / FDO_QTDITE)) AS TOTITE, ';
      End;

      strSQL := strSQL + '  CONCAT(FDO_CODVEN,"-",OPE_NOMOPE)   AS DESVEN, ';
      strSQL := strSQL + '  CONCAT(FGO_CODDIG,"-",( SELECT OPE_NOMOPE FROM CADOPE WHERE OPE_CODOPE = FGO_CODDIG)) AS DESDIG, ';
      strSQL := strSQL + '  "" AS DESSER, ';
      strSQL := strSQL + '  "" AS VALSER  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  FATDOR D ';
      strSQL := strSQL + '  INNER JOIN CADCLI ON FDO_CODCLI = CLI_CODCLI ';
      strSQL := strSQL + '  INNER JOIN CADOPE ON FDO_CODVEN = OPE_CODOPE ';
      strSQL := strSQL + '  INNER JOIN CADMAR ON FDO_CODMAR = MAR_CODMAR ';
      strSQL := strSQL + '  INNER JOIN FATGOR ON FDO_NUMDOC = FGO_NUMDOC ';
      strSQL := strSQL + '                   AND FDO_ESPDOC = FGO_ESPDOC ';
      strSQL := strSQL + '                   AND FDO_CODCLI = FGO_CODCLI ';
      strSQL := strSQL + '                   AND FDO_CODEMP = FGO_CODEMP ';
      strSQL := strSQL + '  INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
      strSQL := strSQL + '  INNER JOIN CADITE C ON C.ITE_CODITE = FDO_CODITE ';
      strSQL := strSQL + '  INNER JOIN ITEGER G ON G.ITE_CODITE = FDO_CODITE ';
      strSQL := strSQL + '                     AND G.ITE_CODEMP = FDO_CODEMP ';
      strSQL := strSQL + '  LEFT  JOIN CADUNI ON D.FDO_UNIDAD = UNI_CODUNI ';
      strSQL := strSQL + '  LEFT  JOIN CADOCO ON EXTGOR.FGO_CODOCO = CADOCO.OCO_CODOCO ';
      if rdgOrigem.ItemIndex <> 1 then
        strSQL := strSQL + '  LEFT JOIN FSPEDIDOCAB ON NUMEROPEDIDO = FGO_NUMPOK ';
      strSQL := strSQL + fGetWhere;

      strSQL := strSQL + 'GROUP BY      ';
      strSQL := strSQL + '  FDO_CODCLI, FDO_NUMDOC, FDO_DTAENT, FDO_CONPAG, FDO_CODVEN  ';
    End;

    strSQL := 'SELECT * FROM ('+strSQL+') AS VW_FINAL ORDER BY NOMCLI, NUMDOC';

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

      pSetaParam(edtCodCliente.Text, arrClientes,  strClientes,  'CODCLI', qryRelatorio);
      pSetaParam(edtCodDig.Text,     arrDigitador, strDigitador, 'CODDIG', qryRelatorio);

      {*********************************}
      {* FILTRO POR MARCA              *}
      {*******************************FC}
      If Not fEmptyStr(edtCodMarca.Text) Then
        pSetaParam(edtCodMarca.Text, arrMarca, strMarca, 'CODMAR', qryRelatorio);

      {*********************************}
      {* FILTRO POR VENDEDOR           *}
      {*******************************FC}
      If blnLiberadoVen Then
        pSetaParam(edtCodVendedor.Text, arrVendedor, strVendedor, 'CODOPE', qryRelatorio)
      Else If Not fEmptyStr(edtCodVendedor.Text) Then
        ParamByName('CODOPE').AsString := strVended;

      {*********************************}
      {* FILTRO POR REGIÃO             *}
      {******************************RV*}
      If Not fEmptyStr(edtCodReg.Text) Then
        pSetaParam(edtCodReg.Text, arrRegiao, strRegiao, 'CODREG', qryRelatorio);

      {*********************************}
      {* FILTRO POR OCORRÊNCIA         *}
      {******************************MM*}
      If Not fEmptyStr(edtCodOco.Text) Then
        pSetaParam(edtCodOco.Text, arrOcorre, strOcorre, 'CODOCO', qryRelatorio);

      {*********************************}
      {* FILTRO POR FASE DA OBRA       *}
      {******************************NC*}
      If Not fEmptyStr(edtCodFase.Text) Then
        pSetaParam(edtCodFase.Text, arrFase, strFase, 'CODFAS', qryRelatorio);

      {*********************************}
      {* FILTRO POR CIDADE             *}
      {******************************RV*}
      If Not fEmptyStr(edtCodCid.Text) Then
        ParamByName('CODCID').AsString := edtCodCid.Text;

      If Params.FindParam('LITGAL') <> Nil Then
      Begin
        If SameText(fCfgSis('LITGAL'), 'L') Then
          ParamByName('LITGAL').AsFloat := 1
        Else
          ParamByName('LITGAL').AsFloat := FLT_LITRO_GALAO;
      End;

      If SameText(edtTipo.Text, 'A') Then Begin
        ParamByName('ITESER').AsString := fCfgSis('ITESER', varString);
        ParamByName('SERTER').AsString := fCfgSis('SERTER', varString);
      End;

      Open;
    End;

    If (edtTipo.Text = 'A') And (rgbVisItens.ItemIndex <> 0) Then
    Begin
      cdsItensAna := fCriaClientDataSetPedidoItens(qryRelatorio);
      blnTemRegistros := Not cdsItensAna.IsEmpty;
    End
    Else
      blnTemRegistros := Not qryRelatorio.IsEmpty;

    If blnTemRegistros Then
    Begin
      Try
        If (Pos(edtDestino.Text, 'V_I_') > 0) Then
        Begin
          pCriarFormularios(TfrmQckPedRelacaoPedidosCli,frmQckPedRelacaoPedidosCli);
          frmQckPedRelacaoPedidosCli.intTipRel := rdgFaturamento.ItemIndex;

          With frmQckPedRelacaoPedidosCli Do
          Begin
            If (edtTipo.Text = 'A') And (rgbVisItens.ItemIndex <> 0) Then
              frmQckPedRelacaoPedidosCli.dtsRelatorio.DataSet := cdsItensAna
            Else
              frmQckPedRelacaoPedidosCli.dtsRelatorio.DataSet := qryRelatorio;

            frmQckPedRelacaoPedidosCli.rllTitQtd.Caption := strTitQtd;

            If SameText(edtTipo.Text, 'S') Then
            Begin
              rlbTitulo.Visible    := False;
              rlbTituloSin.Visible := True;

              rllCorpoAna.Visible  := False;
              rllCorpo2Ana.Visible := False;

              rllCorpoSin.Visible  := True;

              rllSubTotAna.Visible := False;

              frmQckPedRelacaoPedidosCli.rllNomeRelatorio.Caption := 'RELATORIO DE PEDIDOS POR CLIENTE' + IfThen(chkCliFil.Checked, ' FILIAL', '') + ' - SINTETICO';

              if (Not blnUsaDig) then
              begin
                rllTitDig.Visible := False;
                rllDesDig.Visible := False;
              end;
            End
            Else
            Begin
              rllTitDig.Visible := False;
              rllDesDig.Visible := False;

              {***********************************************************************}
              {* CONFIGURA O TAMANHO DOS CAMPOS PARA AUMENTAR A DESCRICAO DO PRODUTO *}
              {*********************************************************************FC}
              If (Not chkImpRef.Checked) And (Not chkImpMar.Checked) Then
              Begin
                rllProdTit.Width := 297;
                rldProd.Width := 297;

                rllRefTit.Visible := False;
                rldRef.Visible := False;

                rllMarTit.Visible := False;
                rldMar.Visible := False;
              End
              Else If (Not chkImpRef.Checked) And (chkImpMar.Checked) Then
              Begin
                rllProdTit.Width := 227;
                rldProd.Width := 227;

                rllRefTit.Visible := False;
                rldRef.Visible := False;

                rllMarTit.Visible := True;
                rldMar.Visible := True;
              End
              Else If (chkImpRef.Checked) And (Not chkImpMar.Checked) Then
              Begin
                rllProdTit.Width := 215;
                rldProd.Width := 215;

                rllRefTit.Visible := True;
                rllRefTit.Left := 286;
                rldRef.Visible := True;
                rldRef.Left := 286;
                
                rllMarTit.Visible := False;
                rldMar.Visible := False;
              End;
              
              rlbTitulo.Visible    := True;
              rlbTituloSin.Visible := False;

              rllCorpoAna.Visible  := True;
              rllCorpo2Ana.Visible := True;

              rllCorpoSin.Visible  := False;

              rllSubTotAna.Visible := True;

              frmQckPedRelacaoPedidosCli.rllNomeRelatorio.Caption := 'RELATORIO DE PEDIDOS POR CLIENTE' + IfThen(chkCliFil.Checked, ' FILIAL', '') + ' - ANALITICO';
              frmQckPedRelacaoPedidosCli.intTipQtd := rdgFaturamento.ItemIndex;
            End;
          End;

          If (strTipImp = 'M') Then
            frmQckPedRelacaoPedidosCli.qckPagina.DefaultFilter := rldFiltro
          Else
            frmQckPedRelacaoPedidosCli.qckPagina.DefaultFilter := Nil;

          {********************}
          {* CABEÇALHO DO QCK *}
          {*****************LB*}
          frmQckPedRelacaoPedidosCli.strOrdem := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

          If (chkPedImp.Checked) Then
            TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllPedImp')).Caption := 'APENAS PEDIDOS JÁ IMPRESSOS'
          Else
            TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllPedImp')).Caption := '';

          {*********************************}
          {* FILTRO POR REGIÃO             *}
          {******************************RV*}
          If Not fEmptyStr(edtCodReg.Text) Then
            TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllRegiao')).Caption := 'REGIAO: ' + edtCodReg.Text + '-' + edtNomReg.Text
          Else
            TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllRegiao')).Caption := 'REGIAO: TODAS ';

          {*********************************}
          {* FILTRO POR OCORRÊNCIA             *}
          {******************************RV*}
          If Not fEmptyStr(edtCodOco.Text) Then
            TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllOcorrencia')).Caption := 'OCORRÊNCIA: ' + edtCodOco.Text + '-' + edtDesOco.Text
          Else
            TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllOcorrencia')).Caption := 'OCORRÊNCIA: TODAS ';

          {*********************************}
          {* FILTRO POR FASE DA OBRA       *}
          {******************************NC*}
          If fCfgSis('FASOBR') = 'S' Then
          Begin
            If Not fEmptyStr(edtCodFase.Text) Then
              TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllFaseObra')).Caption := 'FASE DA OBRA: ' + edtCodFase.Text + '-' + edtDesFase.Text
            Else
              TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllFaseObra')).Caption := 'FASE DA OBRA: TODAS ';
          End
          Else
            TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllFaseObra')).Caption := '';

          TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllDigitador')).Caption := fStrTitulo(edtCodDig.Text, edtNomDig, arrDigitador, fRetornaLinha(arrDigitador, edtCodDig.Text +' - '+edtNomDig.Text ), 'DIGITADOR');

          {********************************}
          {* FILTRO POR MARCA             *}
          {******************************FC}
          If Not fEmptyStr(edtCodMarca.Text) Then
            TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllMarca')).Caption := 'MARCA: ' + edtCodMarca.Text + '-' + edtDesMarca.Text
          Else
            TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllMarca')).Caption := 'MARCA: TODAS ';

          {********************************}
          {* FILTRO POR VENDEDOR          *}
          {******************************FC}
          If Not fEmptyStr(edtCodMarca.Text) Then
            TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllVendedor')).Caption := 'VENDEDOR: ' + edtCodVendedor.Text + '-' + edtDesVendedor.Text
          Else
            TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllVendedor')).Caption := 'VENDEDOR: TODOS ';

          {*********************************}
          {* FILTRO POR CIDADE             *}
          {******************************RV*}
          If Not fEmptyStr(edtCodCid.Text) Then
            TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllCidade')).Caption := 'CIDADE: ' + edtCodCid.Text + '-' + edtNomCid.Text
          Else
            TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllCidade')).Caption := 'CIDADE: TODAS ';

          If (edtLibFin.Text = 'S') Then
            TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllLibFin')).Caption := 'LIBERADO PELO DEP. FINANCEIRO: ' + 'SIM'
          Else If (edtLibFin.Text = 'N') Then
            TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllLibFin')).Caption := 'LIBERADO PELO DEP. FINANCEIRO: ' + 'NAO'
          Else If (edtLibFin.Text = 'T') Then
            TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllLibFin')).Caption := 'LIBERADO PELO DEP. FINANCEIRO: ' + 'TODOS';

          If (edtLibCom.Text = 'S') Then
            TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllLibCom')).Caption := 'LIBERADO PELO DEP. COMERCIAL: ' + 'SIM'
          Else If (edtLibCom.Text = 'N') Then
            TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllLibCom')).Caption := 'LIBERADO PELO DEP. COMERCIAL: ' + 'NAO'
          Else If (edtLibCom.Text = 'T') Then
            TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllLibCom')).Caption := 'LIBERADO PELO DEP. COMERCIAL: ' + 'TODOS';

          TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllDtaPrevis')).Caption := fGetTituloDtaPrevis;

          {**********************************************}
          {* EXIBIR/OCULTAR FILTRO DE PEDIDOS LIBERADOS *}
          {*******************************************RV*}
          TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllLibCom')).Visible := fCfgSis('AGDLIB', varBoolean);
          TRLLabel(frmQckPedRelacaoPedidosCli.FindComponent('rllLibFin')).Visible := fCfgSis('LPPDBL', varBoolean);

          If SameText(fCfgSis('LITGAL'), 'G') Then
            frmQckPedRelacaoPedidosCli.rllLitragem.Caption := 'GALONAGEM'
          Else
            frmQckPedRelacaoPedidosCli.rllLitragem.Caption := 'LITROS/KILOS';

          frmQckPedRelacaoPedidosCli.rllCliente.Caption := fStrTitulo(edtCodCliente.Text, edtDesCliente, arrClientes, strClientes, 'CLIENTE');

          frmQckPedRelacaoPedidosCli.rllOrigem.Caption := 'ORIGEM: ' + AnsiUpperCase(rdgOrigem.Items.Strings[rdgOrigem.ItemIndex]);

          If (edtDestino.Text = 'V') Then
            frmQckPedRelacaoPedidosCli.qckPagina.PreviewModal
          Else If (edtDestino.Text = 'I') Then
            frmQckPedRelacaoPedidosCli.qckPagina.Print;
        End
        Else
        Begin
          If (edtTipo.Text = 'A') And (rgbVisItens.ItemIndex <> 0) Then
            pGeraExcel(cdsItensAna)
          Else
            pGeraExcel(qryRelatorio);
        End;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;
      pFreeAndNil(frmQckPedRelacaoPedidosCli);
    End
    Else
      pTabelaVazia;

    fDropTable(strTabFut);      
  End;

  If Assigned(cdsItensAna) Then
    FreeAndNil(cdsItensAna);

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
End;

function TfrmRelPedRelacaoPedidosCli.fRetCampoPre: String;
begin
  If fEmptyStr(fRetTabPre) Then
    Result := 'FDO_UNIORI'
  Else
    Result := 'ITE_PREVE' + fRetTabPre;
end;

function TfrmRelPedRelacaoPedidosCli.fRetornaLinha(arrLinha: TConsultasArray;
  strText: String): String;
  Var
    intContador : integer;
    strLinha : String;
Begin

  strLinha := '';
  If Length(arrLinha) > 1 Then
  Begin
    For intContador := 0 To Length(arrLinha)-1 Do
    Begin
      strLinha := strLinha + arrLinha[intContador].strCodigo + '_';
    End;
  End
  Else
    strLinha := strText;

  Result := strLinha;
end;

function TfrmRelPedRelacaoPedidosCli.fRetTabPre: String;
begin
  If (cbxTabPre.ItemIndex = 0) Then
    Result := ''
  Else
    Result := Copy(cbxTabPre.Text, 8, 1);
end;

function TfrmRelPedRelacaoPedidosCli.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  {*********************}
  {* VALIDA DATAS      *}
  {******************LU*}
  If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
      Result := False;
      If (Sender = mskDtaFin) Then
        Sender := mskDtaIni;
    End
    Else
    Begin
      If (Sender = mskDtaFin) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
          Begin
            fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
            Result := False;
          End;
        End;
      End
    End;

  End

  {****************************}
  {* VALIDA CAMPO FATURAMENTO *}
  {*************************RV*}
  Else If (Sender = rdgFaturamento) Then
  Begin
    If (rdgFaturamento.ItemIndex = 1) Then
      chkItePen.Enabled := True
    Else
      chkItePen.Enabled := False;
  End

  Else If (Sender = edtLibFin) Then
  Begin
    If fEmptyStr(edtLibFin.Text) Or (Pos(edtLibFin.Text, 'S_N_T_') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Tipo de Liberação deve ser "S", "N" ou "T"!', ['&O k']);
      Result := False;
    End;
  End

  Else If (Sender = edtLibCom) Then
  Begin
    If fEmptyStr(edtLibCom.Text) Or (Pos(edtLibCom.Text, 'S_N_T_') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Tipo de Liberação deve ser "S", "N" ou "T"!', ['&O k']);
      Result := False;
    End;
  End

  Else If (Sender = edtTipo) Then
  Begin
    If fEmptyStr(edtTipo.Text) Or (Pos(edtTipo.Text, 'A_S') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Tipo de Relatório deve ser "A" ou "S"!', ['&O k']);
      Result := False;
    End;
  End

  Else If (Sender = edtDestino) Then
  Begin
    If fEmptyStr(edtDestino.Text) Or (Pos(edtDestino.Text, 'V_I_E_') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Destino do Relatório deve ser "V", "I" ou "E"!', ['&O k']);
      Result := False;
    End;
  End

  Else If (Sender = edtCodVendedor) Then
  Begin
    If blnLiberadoVen Then
    Begin
      pDesmarcaLista(edtCodVendedor, arrVendedor);

    End
    Else If Not fEmptyStr(edtCodVendedor.Text) Then
    Begin
      strVended := fRetCodVendedor(edtCodVendedor.Text);

      If Not fEmptyStr(strVended) Then
        edtDesVendedor.Text := fRetNomVendRep(strVended)
      Else
      Begin
        Result := False;
        fMensagem('', 'Vendedor não encontrado.', ['&O k']);
      End;

    End
    Else
    Begin
      fMensagem('', 'O campo Vendedor deve ser preenchido!', ['&O k']);
      Result := False;
    End;

  End

  Else If (Sender = edtDtaPre) Then
  Begin
    If (Pos(edtDtaPre.Text, 'SNT') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!','O campo Pedidos faturados acima da data de previsão deve ser S, N ou T!',['&O K']);
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelPedRelacaoPedidosCli.pAcertaTela(blnOcorrencia: Boolean);
begin
  If blnOcorrencia Then
  Begin
    If fCfgSis('FASOBR') = 'S' Then
    Begin
      If Not fCfgSis('USADIG', varBoolean) Then
        Self.Height := 620 + pnlFaseObra.Height + pnlOcorrencia.Height
      Else
        Self.Height := 620 + pnlFaseObra.Height + pnlOcorrencia.Height + 40; //40 do digitador
    End
    Else
    Begin
      If Not fCfgSis('USADIG', varBoolean) Then
        Self.Height := 620 + pnlOcorrencia.Height
      Else
        Self.Height := 660 + pnlOcorrencia.Height;//Tela + 40 do digitador
    End;
  End
  Else
  Begin
    If fCfgSis('FASOBR') = 'S' Then
    Begin
      If Not fCfgSis('USADIG', varBoolean) Then
        Self.Height := 620 + pnlFaseObra.Height
      Else
        Self.Height := 620 + pnlFaseObra.Height + 40; //Tela + fase obra + 40 do digitador
    End
    Else
    Begin
      If Not fCfgSis('USADIG', varBoolean) Then
        Self.Height := 620
      Else
        Self.Height := 660;//Tela + 40 do digitador
    End;
  End;
end;

procedure TfrmRelPedRelacaoPedidosCli.pCarregaPrecos;
  Var
    intIndex: Integer;
Begin
  cbxTabPre.Items.Clear;
  cbxTabPre.Items.Add('Sugerido na Venda');

  For intIndex := 1 To Length(VS_strTabPrc) Do
    if VS_strTabPrc[intIndex] = 'S' Then
      cbxTabPre.Items.Add('Tabela ' + IntToStr(intIndex));

  cbxTabPre.ItemIndex := 0;    
end;

procedure TfrmRelPedRelacaoPedidosCli.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelPedRelacaoPedidosCli.pGeraExcel(DataSet: TDataSet);
  Var
    objGeraExcel: TGeraExcel;
begin
  objGeraExcel := TGeraExcel.Create(DataSet, pgbProgresso);
  With objGeraExcel Do
  Begin
    strNomRel := 'RELATORIO DE PEDIDOS POR CLIENTE (' + IfThen(edtTipo.Text = 'A', 'ANALITICO', 'SINTETICO') + ')';

    If (rdgFaturamento.ItemIndex = 0) Then
      AddFiltro('FATURAMENTO: TODOS OS PEDIDOS')
    Else If (rdgFaturamento.ItemIndex = 1) Then
      AddFiltro('FATURAMENTO: PEDIDOS FATURADOS')
    Else If (rdgFaturamento.ItemIndex = 2) Then
      AddFiltro('FATURAMENTO: PEDIDOS NAO FATURADOS')
    Else
      AddFiltro('FATURAMENTO: PEDIDOS BAIXADOS QUE NÃO FORAM ENTREGUES');

    If (rdgTipOpe.ItemIndex = 0) Then
      AddFiltro('TIPO DE OPERACAO: VENDAS')
    Else If (rdgTipOpe.ItemIndex = 1) Then
      AddFiltro('TIPO DE OPERACAO: BONIFICACAO')
    Else If (rdgTipOpe.ItemIndex = 2) Then
      AddFiltro('TIPO DE OPERACAO: CONTA E ORDEM')
    Else
      AddFiltro('TIPO DE OPERACAO: TODAS');

    AddFiltro('PERIODO: DE ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaIni.Text)) + ' A ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaFin.Text)));
    AddFiltro('CLIENTE: '    + IfThen(fEmptyStr(edtCodCliente.Text), 'TODOS', edtCodCliente.Text + '-' + edtDesCliente.Text));
    AddFiltro('MARCA: '      + IfThen(fEmptyStr(edtCodMarca.Text), 'TODAS', edtCodMarca.Text + '-' + edtDesMarca.Text));
    AddFiltro('REGIAO: '     + IfThen(fEmptyStr(edtCodReg.Text), 'TODAS', edtCodReg.Text + '-' + edtNomReg.Text));
    AddFiltro('OCORRÊNCIA: ' + IfThen(fEmptyStr(edtCodOco.Text), 'TODAS', edtCodOco.Text + '-' + edtDesOco.Text));
    AddFiltro(fStrTitulo(edtCodDig.Text, edtNomDig, arrDigitador, fRetornaLinha(arrDigitador, edtCodDig.Text + ' - '+ edtNomDig.Text), 'DIGITADOR'));
    AddFiltro('VENDEDOR: '   + IfThen(fEmptyStr(edtCodVendedor.Text), 'TODOS', edtCodVendedor.Text + '-' + edtDesVendedor.Text));
    AddFiltro('CIDADE: '     + IfThen(fEmptyStr(edtCodCid.Text), 'TODAS', edtCodCid.Text + '-' + edtNomCid.Text));

    If fCfgSis('FASOBR') = 'S' Then
      AddFiltro('FASE DA OBRA:' + IfThen(fEmptyStr(edtCodFase.Text), 'TODAS', edtCodFase.Text + '-' + edtDesFase.Text));

    AddFiltro('ORIGEM: ' + AnsiUpperCase(rdgOrigem.Items.Strings[rdgOrigem.ItemIndex]));

    If fCfgSis('LPPDBL', varBoolean) Then
    Begin
      If (edtLibFin.Text = 'S') Then
        AddFiltro('LIBERADO PELO DEP. FINANCEIRO: ' + 'SIM')
      Else If (edtLibFin.Text = 'N') Then
        AddFiltro('LIBERADO PELO DEP. FINANCEIRO: ' + 'NAO')
      Else If (edtLibFin.Text = 'T') Then
        AddFiltro('LIBERADO PELO DEP. FINANCEIRO: ' + 'TODOS');
    End;

    If fCfgSis('AGDLIB', varBoolean) Then
    Begin
      If (edtLibCom.Text = 'S') Then
        AddFiltro('LIBERADO PELO DEP. COMERCIAL: ' + 'SIM')
      Else If (edtLibCom.Text = 'N') Then
        AddFiltro('LIBERADO PELO DEP. COMERCIAL: ' + 'NAO')
      Else If (edtLibCom.Text = 'T') Then
        AddFiltro('LIBERADO PELO DEP. COMERCIAL: ' + 'TODOS');
    End;

    AddFiltro(fGetTituloDtaPrevis);

    If (edtTipo.Text = 'A') Then
    Begin
      AddCampo( 'CODCLI', 'CODIGO');
      AddCampo( 'RAZCLI', 'RAZAO SOCIAL');
      AddCampo( 'FANCLI', 'NOME FANTASIA');
      AddCampo( 'DTAENT', 'DTA. PEDIDO');
      AddCampo( 'NUMDOC', 'PEDIDO');
      AddCampo( 'CONPAG', 'COND. PAGTO.');
      If (rdgFaturamento.ItemIndex In [0, 1]) Then
        AddCampo( 'DOCFAT', 'DOC. FAT.');
      If (rdgFaturamento.ItemIndex In [0, 3]) Then
        AddCampo( 'MOTBAI', 'MOT. BAI.');
      AddCampo( 'CODVEN', 'VEN.');
      AddCampo( 'CODITE', 'PRODUTO');
      AddCampo( 'DESCRI', 'DESCRICAO');

      If chkImpRef.Checked Then
        AddCampo( 'REFERE', 'REFERENCIA');

      If chkImpMar.Checked Then
        AddCampo( 'DESMAR', 'MARCA');

      AddCampo( 'SIGUNI', 'UNID.');

      Case rdgFaturamento.ItemIndex Of
        0: Begin
             AddCampo('QTDITE', 'QTD.');
           End;
        1: Begin
             AddCampo('QTDORI', 'QTD. ORIG.');
             AddCampo('QTDITE', UpperCase(rdgTipQtd.Items[rdgTipQtd.ItemIndex]));
           End;
        2: Begin
             AddCampo('QTDORI', 'QTD. ORIG.');
             AddCampo('QTDITE', 'PENDENTE');
           End;
        3: Begin
             AddCampo('QTDORI', 'QTD. ORIG.');
             AddCampo('QTDITE', 'N. ENTREG.');
           End;
      End;

      If SameText(fCfgSis('LITGAL'), 'G') Then
        AddCampo( 'LITRAG', 'GALONAGEM')
      Else
        AddCampo( 'LITRAG', 'LITROS/KILOS');

      AddCampo( 'UNITAR', 'VALOR UNIT.');
      AddCampo( 'TOTITE', 'VALOR PEDIDO');

     AddCampo( 'NUMPOK',         'NUMERO DO PEDIDO NO TABLET/SITE');
     AddCampo( 'DATAIMPORTACAO', 'DATA IMPORTACAO');
     AddCampo( 'HORAIMPORTACAO', 'HORA IMPORTACAO');

    End
    Else
    Begin
      AddCampo( 'CODCLI', 'CODIGO');
      AddCampo( 'RAZCLI', 'RAZAO SOCIAL');
      AddCampo( 'FANCLI', 'NOME FANTASIA');
      AddCampo( 'DTAENT', 'DTA. PEDIDO');
      AddCampo( 'NUMDOC', 'PEDIDO');
      AddCampo( 'CONPAG', 'COND. PAGTO.');
      If (rdgFaturamento.ItemIndex In [0, 1]) Then
        AddCampo( 'DOCFAT', 'DOC. FAT.');
      If (rdgFaturamento.ItemIndex In [0, 3]) Then
        AddCampo( 'MOTBAI', 'MOT. BAI.');
      AddCampo( 'DESVEN', 'VENDEDOR');

      if ( blnUsaDig ) then
        AddCampo( 'DESDIG', 'DIGITADOR');

      AddCampo( 'TOTITE', 'VALOR PEDIDO');

     AddCampo( 'NUMPOK',         'NUMERO DO PEDIDO NO TABLET/SITE');
     AddCampo( 'DATAIMPORTACAO', 'DATA IMPORTACAO');
     AddCampo( 'HORAIMPORTACAO', 'HORA IMPORTACAO');
    End;

    If (edtTipo.Text = 'A') Then
      OnImpDetalhes := pImprimeDetalhes;
  End;

  If objGeraExcel.fGerarRelatorio Then
    fMensagem('','Arquivo gerado com sucesso!', ['&OK']);

  FreeAndNil(objGeraExcel);
end;

procedure TfrmRelPedRelacaoPedidosCli.pImprimeDetalhes(Excel: TExcel;
  Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
  Var
    i: Integer;
    sTemp: String;
    stlDesSer, stlValSer: TStringList;

  procedure pDefineCor(); begin
    Excel.CorFundo('A' + IntToStr(Excel.LinhaAtual), 'Q' + IntToStr(Excel.LinhaAtual), CorFundo);
  End;

begin
  With Excel Do Begin
    If (edtTipo.Text = 'A') Then Begin
      If (Length(Dados.FieldByName('DESSER').AsString) > 100)
        And (Length(Dados.FieldByName('VALSER').AsString) > 55) Then Begin
        Try
          stlDesSer  := TStringList.Create();
          stlValSer  := TStringList.Create();

          sTemp := AnsiReplaceStr(Copy(Dados.FieldByName('DESSER').AsString, 1,
            Length(Dados.FieldByName('DESSER').AsString) - 7), STRING_QUEBRA, STRING_ENTER);
          stlDesSer.Text := sTemp;

          sTemp := Copy(Dados.FieldByName('VALSER').AsString, 1, Length(Dados.FieldByName('VALSER').AsString) - 7);
          sTemp := Copy(sTemp, 1, 55) + AnsiReplaceStr(Copy(sTemp, 56, Length(sTemp)), '.', '#');
          sTemp := Copy(sTemp, 1, 55) + AnsiReplaceStr(Copy(sTemp, 56, Length(sTemp)), ',', '.');
          sTemp := Copy(sTemp, 1, 55) + AnsiReplaceStr(Copy(sTemp, 56, Length(sTemp)), '#', ',');
          stlValSer.Text := AnsiReplaceStr(sTemp, STRING_QUEBRA, STRING_ENTER);

          For i := 0 To stlDesSer.Count - 1 Do Begin
            ProximaLinha;
            Mesclar('A' + IntToStr(LinhaAtual), 'Q' + IntToStr(LinhaAtual));
            pDefineCor();

            Escrever(LinhaAtual, 1, stlDesSer[i] + stlValSer[i]);
          End;
        Finally
          FreeAndNil(stlDesSer);
          FreeAndNil(stlValSer);
        End;
      End;
    End;
  End;
end;

procedure TfrmRelPedRelacaoPedidosCli.rdgFaturamentoClick(Sender: TObject);
begin
  inherited;

  Case rdgFaturamento.ItemIndex Of
    0: Begin
         rdgTipQtd.Items[0]    := 'Original';
         rdgTipQtd.ItemIndex   := 0;
         rdgTipQtd.Enabled     := False;
         strTitQtd             := 'QTDE.';
         rgbVisItens.ItemIndex := 0;
         rgbVisItens.Enabled   := False;
         pnlOcorrencia.Visible := False;
         pAcertaTela(False);
       End;
    1: Begin
         rdgTipQtd.Items[0]    := 'Baixado';
         rdgTipQtd.Enabled     := True;
         strTitQtd             := UpperCase(rdgTipQtd.Items[rdgTipQtd.ItemIndex]);
         rgbVisItens.ItemIndex := 0;
         rgbVisItens.Enabled   := False;
         pnlOcorrencia.Visible := False;
         pAcertaTela(False);
       End;
    2: Begin
         rdgTipQtd.Items[0]    := 'Original';
         rdgTipQtd.ItemIndex   := 1;
         rdgTipQtd.Enabled     := False;
         strTitQtd             := 'PENDENTE';
         rgbVisItens.ItemIndex := 0;
         rgbVisItens.Enabled   := True;
         pnlOcorrencia.Visible := False;
         pAcertaTela(False);
       End;
    3: Begin
         rdgTipQtd.Items[0]    := 'Original';
         rdgTipQtd.ItemIndex   := 0;
         rdgTipQtd.Enabled     := False;
         strTitQtd             := 'N. ENTREG.';
         rgbVisItens.ItemIndex := 0;
         rgbVisItens.Enabled   := False;
         pnlOcorrencia.Visible := True;
         pAcertaTela(True);
       End;
  End;
  chkItePen.Enabled := (rdgFaturamento.ItemIndex = 1);
  gpbDtaPre.Enabled := (rdgFaturamento.ItemIndex = 1);
  edtDtaPre.Enabled := (rdgFaturamento.ItemIndex = 1);
  ColorLabel5.Enabled := (rdgFaturamento.ItemIndex = 1);
end;

procedure TfrmRelPedRelacaoPedidosCli.rdgFaturamentoExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(rdgFaturamento, False);
end;

procedure TfrmRelPedRelacaoPedidosCli.rdgTipQtdClick(Sender: TObject);
begin
  inherited;
  If rdgFaturamento.ItemIndex = 1 Then
    strTitQtd := UpperCase(rdgTipQtd.Items[rdgTipQtd.ItemIndex]);
end;

procedure TfrmRelPedRelacaoPedidosCli.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
  Begin
    If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
    Begin
      Close;
    End
    Else
    Begin
      SelectNext(ActiveControl, False, True);
    End;
  End;
end;

procedure TfrmRelPedRelacaoPedidosCli.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

procedure TfrmRelPedRelacaoPedidosCli.FormCreate(Sender: TObject);
begin
  inherited;
  shpMultSel.Visible := True;
  pCarregaPrecos;

  blnUsaDig := (fCfgSis('USADIG') = 'S');
end;

procedure TfrmRelPedRelacaoPedidosCli.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

function TfrmRelPedRelacaoPedidosCli.fCriaClientDataSetPedidoItens(qryItens: TUniQuery): TUniClientDataSet;
  var
    cdsSaldos : TUniClientDataSet;
    blnUltReg : Boolean;
    blnFindKey: Boolean;
    strEmpRes : String;
    strIteRes : String;
    blnTotRes : Boolean;
begin
  cdsSaldos := TUniClientDataSet.Create(Self);

  cdsSaldos.FieldDefs.Add('CODITE', ftString, 15);
  cdsSaldos.FieldDefs.Add('CODEMP', ftString, 03);
  cdsSaldos.FieldDefs.Add('SALDOS', ftFloat );
  cdsSaldos.FieldDefs.Add('SALRES', ftFloat );
  cdsSaldos.FieldDefs.Add('ACUMUL', ftFloat );

  cdsSaldos.IndexFieldNames := 'CODITE;CODEMP;';

  cdsSaldos.CreateDataSet;

  blnTotRes := (fCfgSis('CTESPV', varBoolean)) And (fCfgSis('PRCTPV') = '2');

  Result := fCriaClientDatset(qryItens);

  With Result Do
  Begin
    First;
    While Not Eof Do
    Begin
      blnUltReg := (RecordCount = RecNo);

      blnFindKey := cdsSaldos.FindKey([FieldByName('CODITE').AsString,
                                       FieldByName('CODEMP').AsString]);

      If blnFindKey Then
      Begin
        cdsSaldos.Edit;
        cdsSaldos.FieldByName('ACUMUL').Value := cdsSaldos.FieldByName('ACUMUL').Value + FieldByName('QTDITE').AsFloat;
      End
      Else
      Begin
        strEmpRes := FieldByName('CODEMP').AsString;
        strIteRes := RightStr(FieldByName('CODITE').AsString, fTamCodIte);

        cdsSaldos.Append;
        cdsSaldos.FieldByName('CODITE').Value := FieldByName('CODITE').AsString;
        cdsSaldos.FieldByName('CODEMP').Value := FieldByName('CODEMP').AsString;
        cdsSaldos.FieldByName('SALDOS').Value := FieldByName('SALDOS').AsFloat;
        cdsSaldos.FieldByName('ACUMUL').Value := FieldByName('QTDITE').AsFloat;

        cdsSaldos.FieldByName('SALRES').Value := fRetornaSalRes(strEmpRes, False, '', strIteRes, strEmpRes, '', '', '',
                                                                False, False, Not fEmptyStr(strEmpRes), 0, blnTotRes);
      End;

      {***********************************************}
      {* SE O USUARIO QUISER VISUALIZAR OS ITENS QUE *}
      {* PODEM SER ATENDIDOS                         *}
      {*********************************************FC}
      If rgbVisItens.ItemIndex = 1 Then
      Begin
        {****************************************************************************************}
        {* CASO NAO HAJA SALDO SUFICIENTE PARA ATENDER TODOS OS PEDIDOS, EXCLUI O PRODUTO.      *}
        {* CASO HAJA SALDO SUFICIENTE PARA PARA ATENDER TODOS OS PEDIDOS, VAI PARA O PROXIMO.   *}
        {*************************************************************************************JC*}
        {If blnTotRes And (cdsSaldos.FieldByName('SALDOS').Value < cdsSaldos.FieldByName('SALRES').Value) Then
        Begin
          cdsSaldos.Post;
          Result.Delete;
        End }

        {****************************************************************************************}
        {* CASO NAO HAJA SALDO SUFICIENTE PARA O PRODUTO, EXCLUI O MESMO E NAO ACUMULA A QTDE.  *}
        {* CASO HAJA SALDO SUFICIENTE PARA O PRODUTO, ACUMULA A QUANTIDADE E VAI PARA O PROXIMO.*}
        {*************************************************************************************JC*}
        {Else If (Not blnTotRes) And (cdsSaldos.FieldByName('ACUMUL').Value > cdsSaldos.FieldByName('SALDOS').Value) Then
        Begin
          cdsSaldos.Cancel;
          Result.Delete;
        End
        Else
        Begin
          cdsSaldos.Post;
          Next;
        End;}

        If cdsSaldos.FieldByName('ACUMUL').Value > cdsSaldos.FieldByName('SALDOS').Value Then
        Begin
          cdsSaldos.Cancel;
          Result.Delete;
        End
        Else
        Begin
          cdsSaldos.Post;
          Next;
        End;

      End
      Else
      Begin
        {*************************************************}
        {* CASO O USUÁRIO QUEIRA VISUALIZAR OS ITENS QUE *}
        {* NÃO PODEM SER ATENDIDOS                       *}
        {***********************************************FC}
        {If blnTotRes And (cdsSaldos.FieldByName('SALDOS').Value >= cdsSaldos.FieldByName('SALRES').Value) Then
        Begin
          cdsSaldos.Post;
          Result.Delete;
        End
        Else If blnTotRes And (cdsSaldos.FieldByName('SALDOS').Value < cdsSaldos.FieldByName('SALRES').Value) Then
        Begin
          cdsSaldos.Cancel;
          Next;
        End

        Else If (Not blnTotRes) And (cdsSaldos.FieldByName('ACUMUL').Value <= cdsSaldos.FieldByName('SALDOS').Value) Then
        Begin
          cdsSaldos.Post;
          Result.Delete;
        End
        Else If (Not blnTotRes) And (cdsSaldos.FieldByName('ACUMUL').Value > cdsSaldos.FieldByName('SALDOS').Value) Then
        Begin
          cdsSaldos.Cancel;
          Next;
        End;}


        If cdsSaldos.FieldByName('ACUMUL').Value <= cdsSaldos.FieldByName('SALDOS').Value Then
        Begin
          cdsSaldos.Post;
          Result.Delete;
        End
        Else
        Begin
          cdsSaldos.Cancel;
          Next;
        end;
      End;

      If blnUltReg Then
        Break;
    End;
    First;
  End;

  FreeAndNil(cdsSaldos);
end;

function TfrmRelPedRelacaoPedidosCli.fGetSqlPesoLitroKilo(strCampo, strTipUni: String): String;
begin
  Result := IfThen(edtTipo.Text = 'S', ' SUM(', ' ') +
            'IF(COALESCE(IF(TRIM(UNI_KILLIT) = "", "L", UNI_KILLIT), "L") = "' + strTipUni + '", ' + strCampo + ', 0)' +
            IfThen(edtTipo.Text = 'S', ') ', ' ');
end;

function TfrmRelPedRelacaoPedidosCli.fGetTituloDtaPrevis: String;
begin
  Result := 'PEDIDOS FATURADOS ACIMA DA DATA DE PREVISÃO: TODOS ';

  If gpbDtaPre.Enabled Then
  Begin
    If SameText(edtDtaPre.Text, 'S') Then
      Result := 'PEDIDOS FATURADOS ACIMA DA DATA DE PREVISÃO: SIM '
    Else If SameText(edtDtaPre.Text, 'N') Then
      Result := 'PEDIDOS FATURADOS ACIMA DA DATA DE PREVISÃO: NÃO ';
  End;

  If (edtDestino.Text <> 'E') And (strTipImp = 'M') Then
    Result := fRemoveAcento(Result);
end;

function TfrmRelPedRelacaoPedidosCli.fGetWhere: String;
  Var
    strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '  FDO_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
  strSQL := strSQL + '  FDO_ESPDOC = "PD" AND ';
  strSQL := strSQL + '  FGO_CODEMP = "' + VS_strCodEmp + '" ';

  strSql := strSQL + fStrLocate(edtCodCliente, arrClientes,  'CLI_CODCLI', 'CODCLI');
  strSql := strSQL + fStrLocate(edtCodDig,     arrDigitador, 'FGO_CODDIG', 'CODDIG');

  {*********************************}
  {* FILTRO POR MARCA              *}
  {*******************************FC}
  If Not fEmptyStr(edtCodMarca.Text) Then
    strSQL := strSQL + fStrLocate(edtCodMarca, arrMarca, 'MAR_CODMAR', 'CODMAR');

  {*********************************}
  {* FILTRO POR VENDEDOR           *}
  {*******************************FC}
  If blnLiberadoVen Then
    strSQL := strSQL + fStrLocate(edtCodVendedor, arrVendedor, 'OPE_CODOPE', 'CODOPE')
  Else If Not fEmptyStr(edtCodVendedor.Text) Then
    strSQL := strSQL + '  AND OPE_CODOPE = :CODOPE ';

  {*********************************}
  {* FILTRO POR REGIÃO             *}
  {******************************RV*}
  If Not fEmptyStr(edtCodReg.Text) Then
    strSQL := strSQL + fStrLocate(edtCodReg, arrRegiao, 'CLI_CODREG', 'CODREG');

  {*********************************}
  {* FILTRO POR OCORRÊNCIA         *}
  {******************************MM*}
  If Not fEmptyStr(edtCodOco.Text) Then
    strSQL := strSQL + fStrLocate(edtCodOco, arrOcorre, 'FGO_CODOCO', 'CODOCO');

  {*********************************}
  {* FILTRO POR FASE DA OBRA       *}
  {******************************NC*}
  If Not fEmptyStr(edtCodFase.Text) Then
    strSQL := strSQL + fStrLocate(edtCodFase, arrFase, 'EXTGOR.FGO_FASOBR','CODFAS');

  {*********************************}
  {* FILTRO POR CIDADE             *}
  {******************************RV*}
  If Not fEmptyStr(edtCodCid.Text) Then
    strSQL := strSQL + '  AND CLI_CODCID = :CODCID ';

  {*********************************}
  {* FILTRO POR LIB. FINANCEIRO    *}
  {******************************RV*}
  If (edtLibFin.Text = 'S') Then
    strSQL := strSQL + '  AND FGO_LIBERA > 0 '
  Else If (edtLibFin.Text = 'N') Then
    strSQL := strSQL + '  AND FGO_LIBERA = 0 ';

  {*********************************}
  {* FILTRO POR LIB. COMERCIAL     *}
  {******************************RV*}
  If (edtLibCom.Text = 'S') Then
    strSQL := strSQL + '  AND FGO_LIBCOM > 0 '
  Else If (edtLibCom.Text = 'N') Then
    strSQL := strSQL + '  AND FGO_LIBCOM = 0 ';

  Case rdgFaturamento.ItemIndex Of
    1: Begin
         strSQL := strSQL + ' AND ((EXISTS (SELECT                          ';
         strSQL := strSQL + '      DET_NUMDOC                               ';
         strSQL := strSQL + '    FROM                                       ';
         strSQL := strSQL + '      MOVDET                                   ';
         strSQL := strSQL + '    WHERE                                      ';
         strSQL := strSQL + '      DET_NUM_PD = FDO_NUMDOC AND              ';
         strSQL := strSQL + '      DET_ESP_PD = FDO_ESPDOC AND              ';
         strSQL := strSQL + '      DET_EMP_PD = FDO_CODEMP AND              ';
         strSQL := strSQL + '      DET_CODITE = FDO_CODITE                  ';
         strSQL := strSQL + '    LIMIT 1))           ';
         strSQL := strSQL + ' OR (FDO_QTDBAI > 0 AND FGO_MOTBAI IS NULL)    ';
         strSQL := strSQL + ' OR (FDO_JAFATU = 1 AND FGO_MOTBAI IS NULL))   ';

         If chkItePen.Checked Then
           strSQL := strSQL + '  AND ((FDO_JAFATU = 0) AND (FDO_QTDBAI < FDO_QTDITE)) ';
       End;

    2: strSQl := strSQL + ' AND ((FDO_JAFATU = 0) AND (FDO_QTDBAI < FDO_QTDITE)) ';
    3: strSQl := strSQL + ' AND ((FDO_JAFATU = 1) AND (FGO_MOTBAI IS NOT NULL))  ';
  End;

  Case rdgTipOpe.ItemIndex Of
    0: strSQL := strSQL + ' AND FGO_TIPOPE = "V" ';
    1: strSQL := strSQL + ' AND FGO_TIPOPE = "B" ';
    2: strSQL := strSQL + ' AND FGO_TIPOPE = "C" ';
  End;

  If gpbDtaPre.Enabled Then
  Begin
    If SameText(edtDtaPre.Text, 'S') Then
      strSQL := strSQL + ' AND FGO_DTAFAT > FGO_PREVIS '
    Else If SameText(edtDtaPre.Text, 'N') Then
      strSQL := strSQL + ' AND FGO_DTAFAT <= FGO_PREVIS ';
  End;

  If (chkPedImp.Checked) Then
    strSQL := strSQL + ' AND FGO_PEDIMP = "S" ';

  If (chkCliFil.Checked) Then
    strSQL := strSQL + ' AND FGO_CODCLI IN (' + VS_strCliFil + ') ';

  strSQL := strSQL + ' AND FDO_VLRCON <> 0 ';

  Case rdgOrigem.ItemIndex Of
    1: strSQL := strSQL + ' AND ((FGO_NUMPOK = "") OR (FGO_NUMPOK IS NULL)) ';
    2: strSQL := strSQL + ' AND (FGO_NUMPOK <> "") ';
  End;

  Result := strSQL;
end;

procedure TfrmRelPedRelacaoPedidosCli.pVerdeVermelho(edtCodVenRep: TEditFocus; shaVenRep: TShape; blnLiberado: Boolean);
Begin
  If (Not blnLiberado) Then
  Begin
    edtCodVenRep.MaxLength := 10;
    edtCodVenRep.TamCampo  := 10;
    edtCodVenRep.CompZeros := False;
    edtCodVenRep.PasswordChar := '*';
    edtCodVenRep.TipoTexto := ttAlfanumerico;
    shaVenRep.Brush.Color  := clRed;
  End
  Else
  Begin
    shaVenRep.Brush.Color  := clGreen;
  End;
End;

end.

