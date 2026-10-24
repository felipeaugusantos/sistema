unit untRelSituacaoVendasCRM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiRelatorio, Vcl.ExtCtrls, untTypesSistema,
  frxExportCSVTestabilidade, Vcl.AppEvnts, frxDesgn, frxClass, frxDBSet, untZClient,
  frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, strUtils,
  RLFilters, RLDraftFilter, Vcl.Menus, Vcl.StdCtrls, EditFocus, QColorLabel,
  Vcl.Buttons, BitBtnLockedIncrem, ComboBoxFocus, Vcl.Mask, MaskEditFocus,
  Vcl.DBCtrls, DBEditFocus, Data.DB, untGeraExcel, untExcel, Math;

type
  TfrmRelSituacaoVendasCRM = class(TfrmPaiRelatorio)
    lblCliente: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    edtCodCli: TEditFocus;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtProtoc: TEditFocus;
    edtDesCli: TEditFocus;
    edtCodGoc: TEditFocus;
    edtDesGoc: TEditFocus;
    edtDesToc: TEditFocus;
    edtCodToc: TEditFocus;
    edtOpeOco: TEditFocus;
    edtCodOpe: TEditFocus;
    edtDesOpeOco: TEditFocus;
    edtDesCodOpe: TEditFocus;
    cbStatus: TComboBoxFocus;
    Label5: TLabel;
    mskConIni: TMaskEditFocus;
    Label8: TLabel;
    mskConFin: TMaskEditFocus;
    cmbTipRel: TComboBoxFocus;
    Label12: TLabel;
    frxReportCfgImp: TfrxReport;
    Label14: TLabel;
    edtCodSit: TEditFocus;
    edtDesSit: TEditFocus;
    Label4: TLabel;
    cmbSitVen: TComboBoxFocus;
    Label13: TLabel;
    edtCodCid: TEditFocus;
    edtNomCid: TEditFocus;
    Label15: TLabel;
    edtCodAti: TEditFocus;
    edtDesAti: TEditFocus;
    Label25: TLabel;
    edtCodGat: TEditFocus;
    edtDesGat: TEditFocus;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtOpeOcoKeyPress(Sender: TObject; var Key: Char);
    procedure edtOpeOcoExit(Sender: TObject);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOpeExit(Sender: TObject);
    procedure edtCodGocKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodGocExit(Sender: TObject);
    procedure edtCodTocKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTocExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCodSitKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSitExit(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidExit(Sender: TObject);
    procedure edtCodAtiExit(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodGatKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodGatExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    cdsRelatorio : TZClient;

    arrGruAti: TConsultasArray;
    arrCodAti: TConsultasArray;
    arrCodCli: TConsultasArray;
    arrOpeOco: TConsultasArray;
    arrCodOpe: TConsultasArray;
    arrCodGoc: TConsultasArray;
    arrCodToc: TConsultasArray;
    arrCodSit: TConsultasArray;
    arrCodCid: TConsultasArray;

    strCodAti: String;
    strGruAti: String;
    strCodCli: String;
    strOpeOco: String;
    strCodOpe: String;
    strCodGoc: String;
    strCodToc: String;
    strCodSit: String;
    strCodCid: String;

    strTip_FC: String;

    Function fGetSQLAnalitico : String;
    Function fGetSQLSintetico : String;
    function fGetSQLWhere : String;
    Function fAbreDados : Boolean;

    procedure pGeraExcelInterna;

  public
    Class Procedure pAbreRelatorio(strTip_FCP : String);

  protected
    function fValidaCampos(Sender : TWinControl ; blnBuscaPorChave : Boolean):Boolean; Override;
  end;

implementation

{$R *.dfm}

uses untFuncoesConsulta, untConsultas, untFuncoesSimples,
  untQckRelSituacaoVendasCRM;

{ TfrmRelSituacaoVendasCRM }

procedure TfrmRelSituacaoVendasCRM.btnImprimirClick(Sender: TObject);
  Var
    frmQckRelSituacaoVendasCRM: TfrmQckRelSituacaoVendasCRM;
    frxReport : TfrxReport;
begin
  inherited;

  If not blnImprime Then
    Exit;

  If not fAbreDados Then
  Begin
    pTabelaVazia;
    Exit;
  End;

  If edtDestino.Text = 'E' Then
  Begin
    pGeraExcelInterna;
    Exit;
  End;

  Try
    pCriarFormularios(TfrmQckRelSituacaoVendasCRM, frmQckRelSituacaoVendasCRM);
    With frmQckRelSituacaoVendasCRM Do
    Begin
      frxReport := frxAnaliticoJ;

      Case cmbTipRel.ItemIndex Of
        0: frxReport := frxAnaliticoJ;
        1: frxReport := frxSinteticoJ;
      End;

      frxRelatorio.DataSet := cdsRelatorio;

      If cmbTipRel.ItemIndex = 0 Then
        frxReport.Script.Variables['NOMREL'] := 'RELATÓRIO DE SITUAÇÃO DE VENDAS - ANALÍTICO'
      Else
      If cmbTipRel.ItemIndex = 1 Then
        frxReport.Script.Variables['NOMREL'] := 'RELATÓRIO DE SITUAÇÃO DE VENDAS - SINTÉTICO';

      frxReport.Script.Variables['CODCLI'] := fStrTitulo(edtCodCli, edtDesCli   , arrCodCli, strCodCli, IfThen( strTip_FC = 'C', 'CLIENTE', 'PROSPECTO'));
      frxReport.Script.Variables['CODCID'] := fStrTitulo(edtCodCid, edtNomCid   , arrCodCid, strCodCid, 'CIDADE');
      frxReport.Script.Variables['CODATI'] := fStrTitulo(edtCodAti, edtDesAti   , arrCodAti, strCodAti, 'ATIVIDADE');
      frxReport.Script.Variables['CODGAT'] := fStrTitulo(edtCodGat, edtDesGat   , arrGruAti, strGruAti, 'GRUPO DE ATIVIDADE');
      frxReport.Script.Variables['OPEOCO'] := fStrTitulo(edtOpeOco, edtDesOpeOco, arrOpeOco, strOpeOco, 'OPERADOR ORIGEM');
      frxReport.Script.Variables['CODOPE'] := fStrTitulo(edtCodOpe, edtDesCodOpe, arrCodOpe, strCodOpe, 'OPERADOR DESTINO');
      frxReport.Script.Variables['CODGOC'] := fStrTitulo(edtCodGoc, edtDesGoc   , arrCodGoc, strCodGoc, 'GRUPO DE OCORRÊNCIA');
      frxReport.Script.Variables['CODTOC'] := fStrTitulo(edtCodToc, edtDesToc   , arrCodToc, strCodToc, 'TIPO DE OCORRÊNCIA');
      frxReport.Script.Variables['CODSIT'] := fStrTitulo(edtCodSit, edtDesSit   , arrCodSit, strCodSit, 'SITUAÇÃO DA OCORRÊNCIA');
      frxReport.Script.Variables['PROTOC'] := 'PROTOCOLO: ' + IfThen( fEmptyStr(edtProtoc.Text), 'TODOS', edtProtoc.Text );
      frxReport.Script.Variables['SITUAC'] := 'SITUAÇÃO: ' + UpperCase(cbStatus.Text);

      Case cmbSitVen.ItemIndex Of
        0: frxReport.Script.Variables['SITVEN'] := 'SITUAÇÃO DA VENDA: FATURADOS';
        1: frxReport.Script.Variables['SITVEN'] := 'SITUAÇÃO DA VENDA: NÃO FATURADOS';
        2: frxReport.Script.Variables['SITVEN'] := 'SITUAÇÃO DA VENDA: BAIXADOS NÃO FATURADOS';
        3: frxReport.Script.Variables['SITVEN'] := 'SITUAÇÃO DA VENDA: TODOS';
      End;

      frxReport.Script.Variables['DTAINC'] := fStrTituloPeriodo(mskDtaIni, mskDtaFin) + ' (INCLUSÃO)';
      frxReport.Script.Variables['DTACON'] := fStrTituloPeriodo(mskConIni, mskConFin) + ' (CONCLUSÃO)';
      frxReport.Script.Variables['CLITIT'] := IfThen(strTip_Fc = 'C', 'CLIENTE', IfThen(strTip_Fc = 'P', ' PROSPECTO', 'FORNECEDOR'));

      If Assigned(frxReport.FindObject('mmoZebra')) Then
        TfrxMemoView(frxReport.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB', varInteger);

      frxReport.PrintOptions.Printer   := frxReportCfgImp.PrintOptions.Printer;
      frxReport.PreviewOptions.Buttons := frxReportCfgImp.PreviewOptions.Buttons;

      If edtDestino.Text <> 'I' Then
        pPreviewReport(Self.Name, Self.Caption, frxReport)
      Else
      Begin
        frxReport.PrintOptions.ShowDialog := False;
        If frxReport.PrepareReport Then
          pPrintReport(Self.Name, Self.Caption, strNomImp, frxReport);
      End;
    End;

  Finally
    FreeAndNil(frmQckRelSituacaoVendasCRM);
  End;

end;

procedure TfrmRelSituacaoVendasCRM.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti, edtDesAti, arrCodAti, Nil, fRetNomAtividade, 'da atividade');
end;

procedure TfrmRelSituacaoVendasCRM.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, arrCodAti, False) Then
	Begin
		fValidaCampos(edtCodAti, False);
		Self.SelectNext(ActiveControl, True, True);
	End;
end;

procedure TfrmRelSituacaoVendasCRM.edtCodCidExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCid, edtNomCid, arrCodCid, fRetNomCidadeSemOpc, nil, 'da cidade');
end;

procedure TfrmRelSituacaoVendasCRM.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCidade(Self, edtCodCid, edtNomCid, Nil, Nil, Key, arrCodCid, False) Then
	Begin
		fValidaCampos(edtCodCid, False);
		Self.SelectNext(ActiveControl, True, True);
	End;
end;

procedure TfrmRelSituacaoVendasCRM.edtCodCliExit(Sender: TObject);
begin
  inherited;
  If strTip_Fc = 'P' Then
    pEdtCodSelectExit(edtCodCli, edtDesCli, arrCodCli, fRetNomProspectoATIVO, nil,  'do cliente prospecto' )
  Else
    pEdtCodSelectExit(edtCodCli, edtDesCli, arrCodCli, nil, fRetNomCliente, 'do cliente' );
end;

procedure TfrmRelSituacaoVendasCRM.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If strTip_Fc = 'P' Then
  Begin
    If fPesqProspecto(Self, edtCodCli, edtDesCli, Nil, Key, arrCodCli, True, True) Then
    Begin
      If fValidaCampos(edtCodCli, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End

  Else
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrCodCli, False ) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelSituacaoVendasCRM.edtCodGatExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodGat, edtDesGat, arrGruAti, fRetDescGrupoAtividade, Nil, 'do Grupo de Atividade');
end;

procedure TfrmRelSituacaoVendasCRM.edtCodGatKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoAtividade(Self, edtCodGat, edtDesGat, Nil, Key, arrGruAti, False) Then
  Begin
    fValidaCampos(edtCodGat, True);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelSituacaoVendasCRM.edtCodGocExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodGoc, edtDesGoc, arrCodGoc, Nil, fRetDescGoc, 'da ocorrência');
end;

procedure TfrmRelSituacaoVendasCRM.edtCodGocKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGruposOcorrencias(Self, edtCodGoc, edtDesGoc, nil, Key, arrCodGoc, False) Then
  Begin
    If fValidaCampos(edtCodGoc, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelSituacaoVendasCRM.edtCodOpeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodOpe, edtDesCodOpe, arrCodOpe, fRetNomeOperador, nil, 'do operador');
end;

procedure TfrmRelSituacaoVendasCRM.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fPesqOperador(Self, edtCodOpe, edtDesCodOpe, nil, Key, arrCodOpe, False) then
  Begin
    If fValidaCampos(edtCodOpe, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelSituacaoVendasCRM.edtCodSitExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodSit, edtDesSit, arrCodSit, fRetDesSitOco, nil, 'da situação de ocorrência');
end;

procedure TfrmRelSituacaoVendasCRM.edtCodSitKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqSitOcorrencias(Self, edtCodSit, edtDesSit, Nil, Key, arrCodSit, False, True, edtCodToc.Text ) Then
  Begin
    If fValidaCampos(edtCodSit, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelSituacaoVendasCRM.edtCodTocExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodToc, edtDesToc, arrCodToc, fRetDescTipoOcorrencia, nil, 'do tipo de ocorrência');
end;

procedure TfrmRelSituacaoVendasCRM.edtCodTocKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqTiposOcorrencias(Self, edtCodToc, edtDesToc, nil, Key, arrCodToc, False, edtCodGoc.Text, False) Then
  Begin
    If fValidaCampos(edtCodToc, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelSituacaoVendasCRM.edtOpeOcoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtOpeOco, edtDesOpeOco, arrOpeOco, fRetNomeOperador, nil, 'do operador');
end;

procedure TfrmRelSituacaoVendasCRM.edtOpeOcoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fPesqOperador(Self, edtOpeOco, edtDesOpeOco, nil, Key, arrOpeOco, False) then
  Begin
    If fValidaCampos(edtOpeOco, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmRelSituacaoVendasCRM.fAbreDados: Boolean;
begin
  Case cmbTipRel.ItemIndex Of
    0 : cdsRelatorio.qryQuery.SQL.Text := fGetSQLAnalitico;
    1,
    2 : cdsRelatorio.qryQuery.SQL.Text := fGetSQLSintetico;
  End;

  pSetaParam(edtCodCli.Text, arrCodCli, strCodCli, 'CODCLI', cdsRelatorio.qryQuery);
  pSetaParam(edtCodCid.Text, arrCodCid, strCodCid, 'CODCID', cdsRelatorio.qryQuery);
  pSetaParam(edtOpeOco.Text, arrOpeOco, strOpeOco, 'OPEOCO', cdsRelatorio.qryQuery);
  pSetaParam(edtCodOpe.Text, arrCodOpe, strCodOpe, 'CODOPE', cdsRelatorio.qryQuery);
  pSetaParam(edtCodGoc.Text, arrCodGoc, strCodGoc, 'CODGOC', cdsRelatorio.qryQuery);
  pSetaParam(edtCodToc.Text, arrCodToc, strCodToc, 'CODTOC', cdsRelatorio.qryQuery);
  pSetaParam(edtCodSit.Text, arrCodSit, strCodSit, 'CODSIT', cdsRelatorio.qryQuery);
  pSetaParamPeriodo(mskDtaIni, mskDtaFin, cdsRelatorio.qryQuery, 'INCINI', 'INCFIN');
  pSetaParamPeriodo(mskConIni, mskConFin, cdsRelatorio.qryQuery, 'CONINI', 'CONFIN');
  pSetaParam(edtCodGat.Text, arrGruAti, strGruAti, 'CODGAT', cdsRelatorio.qryQuery);
  pSetaParam(edtCodAti.Text, arrCodAti, strCodAti, 'CODATI', cdsRelatorio.qryQuery);
  pSetaParam(edtCodGat.Text, arrGruAti, strGruAti, 'CODGAT', cdsRelatorio.qryQuery);
  pSetaParam(edtCodAti.Text, arrCodAti, strCodAti, 'CODATI', cdsRelatorio.qryQuery);

  If not fEmptyStr(edtProtoc.Text) Then
    cdsRelatorio.qryQuery.ParamByName('PROTOC').AsString := edtProtoc.Text;

  cdsRelatorio.fAbreClient(True, 'TfrmRelSituacaoVendasCRM.fAbreDados');

  Result := cdsRelatorio.RecordCount > 0;

end;

function TfrmRelSituacaoVendasCRM.fGetSQLAnalitico: String;
begin
  Result := '';
  Result := Result + ' SELECT OCO_DTAINC,                                                            ';
  Result := Result + '        OCO_HORINC,                                                            ';
  Result := Result + '        OCO_PROTOC,                                                            ';
  Result := Result + '        OCO_CODCLI,                                                            ';

  If strTip_FC = 'P' Then
    Result := Result + '      PRO_NOMCLI AS CLI_NOMCLI,                                              '
  Else
    Result := Result + '      CLI_NOMCLI,                                                            ';

  Result := Result + '        OCO_DTACON,                                                            ';
  Result := Result + '        OCO_HORCON,                                                            ';
  Result := Result + '        OCO_CODOPE,                                                            ';
  Result := Result + '        O.OPE_NOMOPE AS OPE_NOMORI,                                            ';
  Result := Result + '        OCO_OPEOCO,                                                            ';
  Result := Result + '        D.OPE_NOMOPE AS OPE_NOMDES,                                            ';
  Result := Result + '        OCO_CODTOC,                                                            ';
  Result := Result + '        TOC_DESTOC,                                                            ';
  Result := Result + '        OCO_CODSIT,                                                            ';
  Result := Result + '        SIT_DESSIT,                                                            ';
  Result := Result + '        (SELECT DISTINCT(CONCAT(HIS_NUMDOC, "-", HIS_ESPDOC, "-", HIS_CODEMP)) ';
  Result := Result + '         FROM HISOCO                                                           ';
  Result := Result + '         WHERE HIS_CODOCO = OCO_CODOCO                                         ';
  Result := Result + '           AND HIS_ESPDOC = "OR"                                               ';
  Result := Result + '         LIMIT 1                                                               ';
  Result := Result + '        ) AS ORCAMENTO,                                                        ';

  Result := Result + '        (SELECT DISTINCT(CONCAT(HIS_NUMDOC, "-", HIS_ESPDOC, "-", HIS_CODEMP)) ';
  Result := Result + '         FROM HISOCO                                                           ';
  Result := Result + '         WHERE HIS_CODOCO = OCO_CODOCO                                         ';
  Result := Result + '           AND HIS_ESPDOC = "PD"                                               ';
  Result := Result + '         LIMIT 1                                                               ';
  Result := Result + '        ) AS PEDIDO,                                                           ';

  Result := Result + '        (SELECT DISTINCT(CONCAT(HIS_NUMDOC, "-", HIS_ESPDOC, "-", IFNULL(HIS_EMPFAT,HIS_CODEMP))) ';
  Result := Result + '         FROM HISOCO                                                           ';
  Result := Result + '         WHERE HIS_CODOCO = OCO_CODOCO                                         ';
  Result := Result + '           AND HIS_ESPDOC IN ("NF", "IF")                                      ';
  Result := Result + '         LIMIT 1                                                               ';
  Result := Result + '        ) AS DOCVEN,                                                           ';

  Result := Result + '        (SELECT CONCAT(FGO_MOTBAI," - ", IFNULL(OCO_DESOCO,""))                ';
  Result := Result + '         FROM HISOCO                                                           ';
  Result := Result + '         INNER JOIN FATGOR ON FGO_NUMDOC = HIS_NUMDOC                          ';
  Result := Result + '                          AND FGO_ESPDOC = HIS_ESPDOC                          ';
  Result := Result + '                          AND FGO_CODEMP = HIS_CODEMP                          ';
  Result := Result + '                          AND IFNULL(FGO_MOTBAI,"") <> ""                      ';
  Result := Result + '                          AND FGO_JAFATU = 1                                   ';
  Result := Result + ' 	       LEFT JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM                    ';
  Result := Result + ' 	       LEFT JOIN CADOCO C ON C.OCO_CODOCO = EXTGOR.FGO_CODOCO                ';
  Result := Result + '         WHERE HIS_CODOCO = M.OCO_CODOCO                                       ';
  Result := Result + '         LIMIT 1 ) AS BAIXAD                                                   ';

  Result := Result + ' FROM MOVOCO M                                                                 ';
  If strTip_FC = 'P' Then
    Result := Result + ' LEFT JOIN PROSPE   ON PRO_CODPRO = OCO_CODCLI                               '
  Else
    Result := Result + ' LEFT JOIN CADCLI   ON CLI_CODCLI = OCO_CODCLI                               ';

  Result := Result + ' LEFT JOIN CADOPE O ON O.OPE_CODOPE = OCO_CODOPE                               ';
  Result := Result + ' LEFT JOIN CADOPE D ON D.OPE_CODOPE = OCO_OPEOCO                               ';
  Result := Result + ' INNER JOIN CADTOC   ON TOC_CODTOC = OCO_CODTOC                                ';
  Result := Result + ' INNER JOIN CADGOC   ON GOC_CODGOC = TOC_CODGOC                                ';
  Result := Result + ' LEFT  JOIN ADEGER   ON GER_CODOCO = OCO_CODOCO                                ';
  Result := Result + ' LEFT  JOIN SITOCO   ON SIT_CODSIT = OCO_CODSIT                                ';
  If strTip_FC = 'P' Then
    Result := Result + ' LEFT  JOIN CADATI   ON ATI_CODATI = PRO_CODATI                              '
  Else
    Result := Result + ' LEFT  JOIN CADATI   ON ATI_CODATI = CLI_CODATI                              ';

  Result := Result + fGetSQLWhere;

  Result := Result + ' ORDER BY TOC_DESTOC, SIT_DESSIT, CAST(CONCAT(OCO_DTAINC, " ", OCO_HORINC) AS DATETIME) ';

end;

function TfrmRelSituacaoVendasCRM.fGetSQLWhere : String;
Begin
  Result := '';
  Result := Result + ' WHERE TRUE ';

  Result := Result + fStrLocate(edtCodCli, arrCodCli, 'OCO_CODCLI', 'CODCLI');

  If strTip_FC = 'P' Then
    Result := Result + fStrLocate(edtCodCid, arrCodCid, 'PRO_CODCID', 'CODCID')
  Else
    Result := Result + fStrLocate(edtCodCid, arrCodCid, 'CLI_CODCID', 'CODCID');

  Result := Result + fStrLocate(edtOpeOco, arrOpeOco, 'OCO_OPEOCO', 'OPEOCO');
  Result := Result + fStrLocate(edtCodOpe, arrCodOpe, 'OCO_CODOPE', 'CODOPE');
  Result := Result + fStrLocate(edtCodGoc, arrCodGoc, 'GOC_CODGOC', 'CODGOC');
  Result := Result + fStrLocate(edtCodToc, arrCodToc, 'OCO_CODTOC', 'CODTOC');
  Result := Result + fStrLocate(edtCodSit, arrCodSit, 'OCO_CODSIT', 'CODSIT');
  Result := Result + fStrLocate(edtCodGat, arrGruAti, 'ATI_CODGAT', 'CODGAT');
  Result := Result + fStrLocate(edtCodAti, arrCodAti, 'ATI_CODATI', 'CODATI');

  If (Not fEmptyDate(mskDtaIni.Text)) And (Not fEmptyDate(mskDtaFin.Text)) Then
    Result := Result + ' AND OCO_DTAINC BETWEEN :INCINI AND :INCFIN ';

  If (Not fEmptyDate(mskConIni.Text)) And (Not fEmptyDate(mskConFin.Text)) Then
    Result := Result + ' AND OCO_DTACON BETWEEN :CONINI AND :CONFIN ';

  Case cbStatus.ItemIndex Of
    1 : Result := Result + ' AND OCO_DTACON IS NULL     AND OCO_HORCON IS NULL     ';
    2 : Result := Result + ' AND OCO_DTACON IS NOT NULL AND OCO_HORCON IS NOT NULL ';
  End;

  If not fEmptyStr(edtProtoc.Text) Then
    Result := Result + ' AND OCO_PROTOC = :PROTOC ';

  Result := Result + ' AND OCO_TIP_FC = ' + QuotedStr(strTip_FC);

  Case cmbSitVen.ItemIndex Of
    0: Result := Result + ' HAVING DOCVEN IS NOT NULL ';
    1: Result := Result + ' HAVING DOCVEN IS NULL AND BAIXAD IS NULL ';
    2: Result := Result + ' HAVING BAIXAD IS NOT NULL ';
  End;


End;

function TfrmRelSituacaoVendasCRM.fGetSQLSintetico: String;
begin
  Result := '';
  Result := Result + ' SELECT OCO_CODTOC,                                    ';
  Result := Result + '        TOC_DESTOC,                                    ';
  Result := Result + '        OCO_CODSIT,                                    ';
  Result := Result + '        SIT_DESSIT,                                    ';
  Result := Result + '        OCO_OPEOCO,                                    ';
  Result := Result + '        OPE_NOMDES,                                    ';
  Result := Result + '        SUM(IF(ORCAMENTO IS NULL,0, 1)) AS ORCAMENTO,  ';
  Result := Result + '        SUM(IF(PEDIDO IS NULL,0, 1)) AS PEDIDO,        ';
  Result := Result + '        SUM(IF(DOCVEN IS NULL,0, 1)) AS DOCVEN         ';
  Result := Result + ' FROM ( ' + fGetSQLAnalitico + ') AS ANALITICO         ';
  Result := Result + ' GROUP BY OCO_CODTOC, OCO_CODSIT                       ';
  Result := Result + ' ORDER BY TOC_DESTOC, SIT_DESSIT                       ';

end;

procedure TfrmRelSituacaoVendasCRM.FormCreate(Sender: TObject);
begin
  inherited;
  cdsRelatorio := TZClient.Create(Self);
  blnExcel := True;

end;

procedure TfrmRelSituacaoVendasCRM.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsRelatorio);
end;

procedure TfrmRelSituacaoVendasCRM.FormShow(Sender: TObject);
begin
  inherited;
  If strTip_FC = 'P' Then
  Begin
    lblCliente.Caption := 'Prospecto:';
  End;
end;

function TfrmRelSituacaoVendasCRM.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = edtCodCli) Then
    Begin
      pDesmarcaLista(edtCodCli, arrCodCli);
    End

    Else
    If (Sender = edtCodCid) Then
    Begin
      pDesmarcaLista(edtCodCid, arrCodCid);
    End

    Else
    If (Sender = edtCodAti) Then
    Begin
      pDesmarcaLista(edtCodAti, ArrCodAti);
    End

    Else
    If (Sender = edtCodGat) Then
    Begin
      pDesmarcaLista(edtCodGat, arrGruAti);
    End

    Else
    If (Sender = edtOpeOco) Then
    Begin
      pDesmarcaLista(edtOpeOco, arrOpeOco);
    End

    Else
    If (Sender = edtCodOpe) Then
    Begin
      pDesmarcaLista(edtCodOpe, arrCodOpe);
    End

    Else
    If (Sender = edtCodGoc) Then
    Begin
      pDesmarcaLista(edtCodGoc, arrCodGoc);
    End

    Else
    If (Sender = edtCodToc) Then
    Begin
      pDesmarcaLista(edtCodToc, arrCodToc);
    End

    Else
    If (Sender = edtCodSit) Then
    Begin
      pDesmarcaLista(edtCodSit, arrCodSit);
    End

    Else
    If (Sender = mskDtaIni) Then
    Begin
      If Not fEmptyDate(mskDtaIni.Text) Then
      Begin
        mskDtaIni.Text := DateToStr(StrToDateDef(mskDtaIni.Text, 0 ));
        If StrToDateDef(mskDtaIni.Text, 0 ) <= 0 Then
          mskDtaIni.Clear;
      End;

      mskDtaFin.Enabled := Not fEmptyDate(mskDtaIni.Text);
      If not mskDtaFin.Enabled Then
        mskDtaFin.Clear;

    End

    Else
    If (Sender = mskDtaFin) And (mskDtaFin.Enabled) Then
    Begin

      If Not fEmptyDate(mskDtaFin.Text) Then
      Begin
        mskDtaFin.Text := DateToStr(StrToDateDef(mskDtaFin.Text, 0 ));

        If StrToDateDef(mskDtaFin.Text, 0 ) <= 0 Then
        Begin
          mskDtaFin.Clear;
          Result := False;
          fMensagem('ATENÇÃO', 'Informe uma data válida!', ['&OK']);
        End

        Else
        If StrToDateDef(mskDtaFin.Text, 0 ) < StrToDateDef(mskDtaIni.Text, 0 ) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO', 'A data final deve ser maior ou igual a data inicial!', ['&OK']);
        End;

      End
      Else
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'Preencha a data inicial e final!', ['&OK']);
      End;

    End

    Else
    If (Sender = mskConIni) Then
    Begin
      If Not fEmptyDate(mskConIni.Text) Then
      Begin
        mskConIni.Text := DateToStr(StrToDateDef(mskConIni.Text, 0 ));
        If StrToDateDef(mskConIni.Text, 0 ) <= 0 Then
          mskConIni.Clear;
      End;

      mskConFin.Enabled := Not fEmptyDate(mskConIni.Text);
      If not mskConFin.Enabled Then
        mskConFin.Clear;

    End

    Else
    If (Sender = mskConFin) And (mskConFin.Enabled) Then
    Begin

      If Not fEmptyDate(mskConFin.Text) Then
      Begin
        mskConFin.Text := DateToStr(StrToDateDef(mskConFin.Text, 0 ));

        If StrToDateDef(mskConFin.Text, 0 ) <= 0 Then
        Begin
          mskConFin.Clear;
          Result := False;
          fMensagem('ATENÇÃO', 'Informe uma data válida!', ['&OK']);
        End

        Else
        If StrToDateDef(mskConFin.Text, 0 ) < StrToDateDef(mskConIni.Text, 0 ) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO', 'A data final deve ser maior ou igual a data inicial!', ['&OK']);
        End;

      End
      Else
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'Preencha a data inicial e final!', ['&OK']);
      End;

    End;


  End;

  If Not Result Then
    pSetFocus(Sender);

end;

class procedure TfrmRelSituacaoVendasCRM.pAbreRelatorio;
  var
    frmRel: TfrmRelSituacaoVendasCRM;
begin
  Try
    pCriarFormularios(TfrmRelSituacaoVendasCRM, frmRel);
    frmRel.strTip_FC := strTip_FCP;
    frmRel.ShowModal;
  Finally
    FreeAndNil(frmRel);
  End;

end;

procedure TfrmRelSituacaoVendasCRM.pGeraExcelInterna;
  Var
    objExcel : TGeraExcel;
begin
  objExcel := TGeraExcel.Create(cdsRelatorio, Nil);
  With objExcel Do
  Begin

    If cmbTipRel.ItemIndex = 0 Then
      strNomRel := 'RELATÓRIO DE SITUAÇÃO DE VENDAS - ANALÍTICO'
    Else
    If cmbTipRel.ItemIndex = 1 Then
      strNomRel := 'RELATÓRIO DE SITUAÇÃO DE VENDAS - SINTÉTICO';

    AddFiltro( fStrTitulo(edtCodCli, edtDesCli   , arrCodCli, strCodCli, IfThen( strTip_FC = 'C', 'CLIENTE', 'PROSPECTO')));
    AddFiltro( fStrTitulo(edtCodCid, edtNomCid   , arrCodCid, strCodCid, 'CIDADE'));
    AddFiltro( fStrTitulo(edtCodAti, edtDesAti   , arrCodAti, strCodAti, 'ATIVIDADE'));
    AddFiltro( fStrTitulo(edtCodGat, edtDesGat   , arrGruAti, strGruAti, 'GRUPO DE ATIVIDADE'));
    AddFiltro( fStrTitulo(edtOpeOco, edtDesOpeOco, arrOpeOco, strOpeOco, 'OPERADOR ORIGEM'));
    AddFiltro( fStrTitulo(edtCodOpe, edtDesCodOpe, arrCodOpe, strCodOpe, 'OPERADOR DESTINO'));
    AddFiltro( fStrTitulo(edtCodGoc, edtDesGoc   , arrCodGoc, strCodGoc, 'GRUPO DE OCORRÊNCIA'));
    AddFiltro( fStrTitulo(edtCodToc, edtDesToc   , arrCodToc, strCodToc, 'TIPO DE OCORRÊNCIA'));
    AddFiltro( fStrTitulo(edtCodSit, edtDesSit   , arrCodSit, strCodSit, 'SITUAÇÃO DA OCORRÊNCIA'));
    AddFiltro( 'PROTOCOLO: ' + IfThen( fEmptyStr(edtProtoc.Text), 'TODOS', edtProtoc.Text ));
    AddFiltro( 'SITUAÇÃO: ' + UpperCase(cbStatus.Text));

    Case cmbSitVen.ItemIndex Of
      0: AddFiltro('SITUAÇÃO DA VENDA: FATURADOS');
      1: AddFiltro('SITUAÇÃO DA VENDA: NÃO FATURADOS');
      2: AddFiltro('SITUAÇÃO DA VENDA: BAIXADOS NÃO FATURADOS');
      3: AddFiltro('SITUAÇÃO DA VENDA: TODOS');
    End;

    AddFiltro( fStrTituloPeriodo(mskDtaIni, mskDtaFin) + ' (INCLUSÃO)');
    AddFiltro( fStrTituloPeriodo(mskConIni, mskConFin) + ' (CONCLUSÃO)');

    If cmbTipRel.ItemIndex = 0 Then
    Begin
      AddQuebra('TOC_DESTOC', 'TIPO DE OCORRÊNCIA');
      AddQuebra('SIT_DESSIT', 'SITUAÇÃO DA OCORRÊNCIA');

      AddCampo('OCO_DTAINC', 'DATA DA INCLUSÃO');
      AddCampo('OCO_HORINC', 'HORA DA INCLUSÃO');
      AddCampo('OCO_PROTOC', 'PROTOCOLO');
      AddCampo('OCO_CODCLI', 'CÓD. ' + IfThen( strTip_FC = 'C', 'CLIENTE', 'PROSPECTO'));
      AddCampo('CLI_NOMCLI', 'CLIENTE' + IfThen(strTip_FC = 'P',' PROSPECTO' ,'') );
      AddCampo('OCO_DTACON', 'DATA DA CONCLUSÃO');
      AddCampo('OCO_HORCON', 'HORA DA CONCLUSÃO');
      AddCampo('OCO_CODOPE', 'CÓD. OPE. ORIGEM');
      AddCampo('OPE_NOMORI', 'OPERADOR ORIGEM');
      AddCampo('OCO_OPEOCO', 'CÓD. OPE. DESTINO');
      AddCampo('OPE_NOMDES', 'OPERADOR DESTINO');
      AddCampo('ORCAMENTO' , 'ORÇAMENTO');
      AddCampo('PEDIDO'    , 'PEDIDO');
      AddCampo('DOCVEN'    , 'DOC. VENDA');
      AddCampo('BAIXAD'    , 'BAIXADO NÃO ENTREGUE');

    End
    Else
    Begin
      AddCampo('OCO_CODTOC','CÓD. TIPO DE OCORRÊNCIA');
      AddCampo('TOC_DESTOC','TIPO DE OCORRÊNCIA');
      AddCampo('OCO_CODSIT','CÓD. SITUACAO DA OCORRÊNCIA');
      AddCampo('SIT_DESSIT','SITUACAO DA OCORRÊNCIA');
      AddCampo('OCO_OPEOCO','CÓD. OPE. DESTINO');
      AddCampo('OPE_NOMDES','OPERADOR DESTINO');
      AddCampo('ORCAMENTO' ,'QTD.ORÇAMENTOS');
      AddCampo('PEDIDO'    ,'QTD.PEDIDOS');
      AddCampo('DOCVEN'    ,'QTD.VENDAS');
    End;

    If fGerarRelatorio Then
      fMensagem('','Arquivo gerado com sucesso!', ['&OK']);

  End;

end;

end.
