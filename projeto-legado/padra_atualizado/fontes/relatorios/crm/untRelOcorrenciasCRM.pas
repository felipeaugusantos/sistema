unit untRelOcorrenciasCRM;

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
  TfrmRelOcorrenciasCRM = class(TfrmPaiRelatorio)
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
    mskConIni: TMaskEditFocus;
    Label8: TLabel;
    mskConFin: TMaskEditFocus;
    cmbTipRel: TComboBoxFocus;
    Label12: TLabel;
    frxReportCfgImp: TfrxReport;
    Label14: TLabel;
    edtCodSit: TEditFocus;
    edtDesSit: TEditFocus;
    cmbTipQue: TComboBoxFocus;
    Label13: TLabel;
    Label5: TLabel;
    edtAutDev: TEditFocus;
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
    procedure cmbTipRelChange(Sender: TObject);
    procedure edtCodSitKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSitExit(Sender: TObject);
    procedure edtCodAtiExit(Sender: TObject);
    procedure edtCodGatExit(Sender: TObject);
    procedure edtCodGatKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    cdsRelatorio : TZClient;
    FTip_Fc  : String;

    arrGruAti: TConsultasArray;
    arrCodAti: TConsultasArray;
    arrCodCli: TConsultasArray;
    arrOpeOco: TConsultasArray;
    arrCodOpe: TConsultasArray;
    arrCodGoc: TConsultasArray;
    arrCodToc: TConsultasArray;
    arrCodSit: TConsultasArray;

    strCodAti: String;
    strGruAti: String;
    strCodCli: String;
    strOpeOco: String;
    strCodOpe: String;
    strCodGoc: String;
    strCodToc: String;
    strCodSit: String;

    Function fGetSQLAnalitico : String;
    Function fGetSQLSintetico : String;
    function fGetSQLWhere : String;
    Function fAbreDados : Boolean;
    function fGetSQLDuracaoEmSegundos: String;

    procedure pGeraExcelInterna;
    function fStrTempo(dtsDados: TDataSet): String;
    function fStrAvgSeg(dtsDados: TDataSet): String;
    function fStrMaxSeg(dtsDados: TDataSet): String;
    function fStrMinSeg(dtsDados: TDataSet): String;
    procedure pSomaResumo(var Totais: TTotais; Dados: TDataSet);
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    function fStrSumSeg(dtsDados: TDataSet): String;

  public
    Class Procedure pAbreRelatorio(strTipFC : String);

  protected
    function fValidaCampos(Sender : TWinControl ; blnBuscaPorChave : Boolean):Boolean; Override;
  end;

implementation

{$R *.dfm}

uses untFuncoesConsulta, untConsultas, untFuncoesSimples,
  untQckRelOcorrenciasCRM;

{ TfrmRelOcorrenciasCRM }

procedure TfrmRelOcorrenciasCRM.btnImprimirClick(Sender: TObject);
  Var
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
    pCriarFormularios(TfrmQckRelOcorrenciasCRM, frmQckRelOcorrenciasCRM);
    With frmQckRelOcorrenciasCRM Do
    Begin
      frxRelatorio.DataSet := cdsRelatorio;

      If cmbTipRel.ItemIndex = 0 Then
      Begin
        frxReport := frxAnaliticoJ;
        frxReport.Script.Variables['NOMREL'] := 'RELATÓRIO DE OCORRÊNCIAS - ANALÍTICO POR ' + UpperCase(cmbTipQue.Text);

        If cmbTipQue.ItemIndex = 0 Then
        Begin
          TfrxMemoView(frxReport.FindObject('rllGrupoOcorrencia')).Text := 'GRUPO DE OCORRÊNCIA';
          TfrxMemoView(frxReport.FindObject('mmoGrupoOcorrencia')).Text := '[frxRelatorio."GOC_CODGOC"] - [frxRelatorio."GOC_DESGOC"]';
        End
        Else
        If cmbTipQue.ItemIndex = 1 Then
        Begin
          TfrxMemoView(frxReport.FindObject('rllOpeOrigem')).Text := IfThen(FTip_Fc = 'C', 'CLIENTE', IfThen(FTip_Fc = 'P', ' PROSPECTO', 'FORNECEDOR'));
          TfrxMemoView(frxReport.FindObject('mmoOpeOrigem')).Text := '[frxRelatorio."OCO_CODCLI"] - [frxRelatorio."CLI_NOMCLI"]';
        End
        Else
        If cmbTipQue.ItemIndex = 2 Then
        Begin
          TfrxMemoView(frxReport.FindObject('rllOpeDestino')).Text := IfThen(FTip_Fc = 'C', 'CLIENTE', IfThen(FTip_Fc = 'P', ' PROSPECTO', 'FORNECEDOR'));
          TfrxMemoView(frxReport.FindObject('mmoOpeDestino')).Text := '[frxRelatorio."OCO_CODCLI"] - [frxRelatorio."CLI_NOMCLI"]';
        End
        Else
        If cmbTipQue.ItemIndex = 3 Then
        Begin
          TfrxMemoView(frxReport.FindObject('rllGrupoOcorrencia')).Text := IfThen(FTip_Fc = 'C', 'CLIENTE', IfThen(FTip_Fc = 'P', ' PROSPECTO', 'FORNECEDOR'));
          TfrxMemoView(frxReport.FindObject('mmoGrupoOcorrencia')).Text := '[frxRelatorio."OCO_CODCLI"] - [frxRelatorio."CLI_NOMCLI"]';
        End
        Else
        If cmbTipQue.ItemIndex = 4 Then
        Begin
          TfrxMemoView(frxReport.FindObject('rllGrupoOcorrencia')).Text := IfThen(FTip_Fc = 'C', 'CLIENTE', IfThen(FTip_Fc = 'P', ' PROSPECTO', 'FORNECEDOR'));
          TfrxMemoView(frxReport.FindObject('mmoGrupoOcorrencia')).Text := '[frxRelatorio."OCO_CODCLI"] - [frxRelatorio."CLI_NOMCLI"]';
        End;

      End
      Else
      Begin
        If cmbTipRel.ItemIndex = 1 Then
        Begin
          frxReport := frxSinteticoJ;
          frxReport.Script.Variables['NOMREL'] := 'RELATÓRIO DE OCORRÊNCIAS - SINTÉTICO POR TIPO DE OCORRÊNCIA'
        End
        Else
        Begin
          frxReport := frxSinteticoJ_Situacao;
          frxReport.Script.Variables['NOMREL'] := 'RELATÓRIO DE OCORRÊNCIAS - SINTÉTICO POR SITUAÇÃO DA OCORRÊNCIA';
        End;

      End;

      if FTip_Fc = 'P' Then
        frxReport.Script.Variables['CODCLI'] := fStrTitulo(edtCodCli, edtDesCli   , arrCodCli, strCodCli, 'CLIENTE PROSPECTO')
      Else
      if FTip_Fc = 'C' Then
        frxReport.Script.Variables['CODCLI'] := fStrTitulo(edtCodCli, edtDesCli   , arrCodCli, strCodCli, 'CLIENTE')
      Else
        frxReport.Script.Variables['CODCLI'] := fStrTitulo(edtCodCli, edtDesCli   , arrCodCli, strCodCli, 'FORNECEDOR');

      frxReport.Script.Variables['CODATI'] := fStrTitulo(edtCodAti, edtDesAti   , arrCodAti, strCodAti, 'ATIVIDADE');
      frxReport.Script.Variables['CODGAT'] := fStrTitulo(edtCodGat, edtDesGat   , arrGruAti, strGruAti, 'GRUPO DE ATIVIDADE');
      frxReport.Script.Variables['OPEOCO'] := fStrTitulo(edtOpeOco, edtDesOpeOco, arrOpeOco, strOpeOco, 'OPERADOR ORIGEM');
      frxReport.Script.Variables['CODOPE'] := fStrTitulo(edtCodOpe, edtDesCodOpe, arrCodOpe, strCodOpe, 'OPERADOR DESTINO');
      frxReport.Script.Variables['CODGOC'] := fStrTitulo(edtCodGoc, edtDesGoc   , arrCodGoc, strCodGoc, 'GRUPO DE OCORRÊNCIA');
      frxReport.Script.Variables['CODTOC'] := fStrTitulo(edtCodToc, edtDesToc   , arrCodToc, strCodToc, 'TIPO DE OCORRÊNCIA');
      frxReport.Script.Variables['CODSIT'] := fStrTitulo(edtCodSit, edtDesSit   , arrCodSit, strCodSit, 'SITUAÇÃO DA OCORRÊNCIA');
      frxReport.Script.Variables['PROTOC'] := 'PROTOCOLO: ' + IfThen( fEmptyStr(edtProtoc.Text), 'TODOS', edtProtoc.Text );
      frxReport.Script.Variables['SITUAC'] := 'SITUAÇÃO: ' + UpperCase(cbStatus.Text);
      frxReport.Script.Variables['AD'    ] := 'AD: ' + IfThen( fEmptyStr(edtAutDev.Text), 'TODOS', edtAutDev.Text );
      frxReport.Script.Variables['DTAINC'] := fStrTituloPeriodo(mskDtaIni, mskDtaFin) + ' (INCLUSÃO)';
      frxReport.Script.Variables['DTACON'] := fStrTituloPeriodo(mskConIni, mskConFin) + ' (CONCLUSÃO)';

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
    FreeAndNil(frmQckRelOcorrenciasCRM);
  End;


end;

procedure TfrmRelOcorrenciasCRM.cmbTipRelChange(Sender: TObject);
begin
  inherited;
  cmbTipQue.Enabled := cmbTipRel.ItemIndex = 0;
end;

procedure TfrmRelOcorrenciasCRM.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti, edtDesAti, arrCodAti, Nil, fRetNomAtividade, 'da atividade');
end;

procedure TfrmRelOcorrenciasCRM.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, arrCodAti, False) Then
	Begin
		fValidaCampos(edtCodAti, False);
		Self.SelectNext(ActiveControl, True, True);
	End;

end;

procedure TfrmRelOcorrenciasCRM.edtCodCliExit(Sender: TObject);
begin
  inherited;
  If FTip_Fc = 'P' Then
    pEdtCodSelectExit(edtCodCli, edtDesCli, arrCodCli, fRetNomProspectoATIVO, nil,  'do cliente prospecto' )
  Else
  If FTip_Fc = 'C' Then
    pEdtCodSelectExit(edtCodCli, edtDesCli, arrCodCli, nil, fRetNomCliente, 'do cliente' )
  Else
    pEdtCodSelectExit(edtCodCli, edtDesCli, arrCodCli, fRetNomFornecedor, nil, 'do fornecedor' );
end;

procedure TfrmRelOcorrenciasCRM.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If FTip_Fc = 'P' Then
  Begin
    If fPesqProspecto(Self, edtCodCli, edtDesCli, Nil, Key, arrCodCli, True, True) Then
    Begin
      If fValidaCampos(edtCodCli, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End

  Else
  If FTip_Fc = 'C' Then
  Begin
    If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrCodCli, False ) Then
    Begin
      If fValidaCampos(edtCodCli, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End

  Else
  Begin
    If fPesqFornecedor(conForSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrCodCli, False) Then
    Begin
      If fValidaCampos(edtCodCli, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmRelOcorrenciasCRM.edtCodGatExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodGat, edtDesGat, arrGruAti, fRetDescGrupoAtividade, Nil, 'do Grupo de Atividade');
end;

procedure TfrmRelOcorrenciasCRM.edtCodGatKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoAtividade(Self, edtCodGat, edtDesGat, Nil, Key, arrGruAti, False) Then
  Begin
    fValidaCampos(edtCodGat, True);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelOcorrenciasCRM.edtCodGocExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodGoc, edtDesGoc, arrCodGoc, Nil, fRetDescGoc, 'da ocorrência');
end;

procedure TfrmRelOcorrenciasCRM.edtCodGocKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGruposOcorrencias(Self, edtCodGoc, edtDesGoc, nil, Key, arrCodGoc, False) Then
  Begin
    If fValidaCampos(edtCodGoc, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelOcorrenciasCRM.edtCodOpeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodOpe, edtDesCodOpe, arrCodOpe, fRetNomeOperador, nil, 'do operador');
end;

procedure TfrmRelOcorrenciasCRM.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fPesqOperador(Self, edtCodOpe, edtDesCodOpe, nil, Key, arrCodOpe, False) then
  Begin
    If fValidaCampos(edtCodOpe, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelOcorrenciasCRM.edtCodSitExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodSit, edtDesSit, arrCodSit, fRetDesSitOco, nil, 'da situação de ocorrência');
end;

procedure TfrmRelOcorrenciasCRM.edtCodSitKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqSitOcorrencias(Self, edtCodSit, edtDesSit, Nil, Key, arrCodSit, False, True, edtCodToc.Text ) Then
  Begin
    If fValidaCampos(edtCodSit, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelOcorrenciasCRM.edtCodTocExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodToc, edtDesToc, arrCodToc, fRetDescTipoOcorrencia, nil, 'do tipo de ocorrência');
end;

procedure TfrmRelOcorrenciasCRM.edtCodTocKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqTiposOcorrencias(Self, edtCodToc, edtDesToc, nil, Key, arrCodToc, False, edtCodGoc.Text, False) Then
  Begin
    If fValidaCampos(edtCodToc, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelOcorrenciasCRM.edtOpeOcoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtOpeOco, edtDesOpeOco, arrOpeOco, fRetNomeOperador, nil, 'do operador');
end;

procedure TfrmRelOcorrenciasCRM.edtOpeOcoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fPesqOperador(Self, edtOpeOco, edtDesOpeOco, nil, Key, arrOpeOco, False) then
  Begin
    If fValidaCampos(edtOpeOco, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmRelOcorrenciasCRM.fAbreDados: Boolean;
begin
  Case cmbTipRel.ItemIndex Of
    0 : cdsRelatorio.qryQuery.SQL.Text := fGetSQLAnalitico;
    1,
    2 : cdsRelatorio.qryQuery.SQL.Text := fGetSQLSintetico;
  End;

  pSetaParam(edtCodCli.Text, arrCodCli, strCodCli, 'CODCLI', cdsRelatorio.qryQuery);
  pSetaParam(edtOpeOco.Text, arrOpeOco, strOpeOco, 'OPEOCO', cdsRelatorio.qryQuery);
  pSetaParam(edtCodOpe.Text, arrCodOpe, strCodOpe, 'CODOPE', cdsRelatorio.qryQuery);
  pSetaParam(edtCodGoc.Text, arrCodGoc, strCodGoc, 'CODGOC', cdsRelatorio.qryQuery);
  pSetaParam(edtCodToc.Text, arrCodToc, strCodToc, 'CODTOC', cdsRelatorio.qryQuery);
  pSetaParam(edtCodSit.Text, arrCodSit, strCodSit, 'CODSIT', cdsRelatorio.qryQuery);
  pSetaParamPeriodo(mskDtaIni, mskDtaFin, cdsRelatorio.qryQuery, 'INCINI', 'INCFIN');
  pSetaParamPeriodo(mskConIni, mskConFin, cdsRelatorio.qryQuery, 'CONINI', 'CONFIN');
  pSetaParam(edtCodGat.Text, arrGruAti, strGruAti, 'CODGAT', cdsRelatorio.qryQuery);
  pSetaParam(edtCodAti.Text, arrCodAti, strCodAti, 'CODATI', cdsRelatorio.qryQuery);

  If not fEmptyStr(edtAutDev.Text) Then
    cdsRelatorio.qryQuery.ParamByName('CODADE').AsString := edtAutDev.Text;

  If not fEmptyStr(edtProtoc.Text) Then
    cdsRelatorio.qryQuery.ParamByName('PROTOC').AsString := edtProtoc.Text;

  cdsRelatorio.fAbreClient(True, 'TfrmRelOcorrenciasCRM.fAbreDados');

  Result := cdsRelatorio.RecordCount > 0;

end;

function TfrmRelOcorrenciasCRM.fGetSQLAnalitico: String;
begin
  Result := '';
  Result := Result + ' SELECT OCO_DTAINC,                                              ';
  Result := Result + '        OCO_HORINC,                                              ';
  Result := Result + '        OCO_DTACON,                                              ';
  Result := Result + '        OCO_HORCON,                                              ';
  Result := Result + '        OCO_PROTOC,                                              ';
  Result := Result + '        GER_CODADE,                                              ';
  Result := Result + '        OCO_CODEMP,                                              ';
  //Campos utilizador no order by deve existir no select para funcionar a ordenação automatico no clientdataset.
  Result := Result + '        CAST(CONCAT(OCO_DTAINC, " ", OCO_HORINC) AS DATETIME) AS DTAHRA, ';
  Case cmbTipQue.ItemIndex Of
    0: Begin
         If FTip_Fc = 'P' Then
           Result := Result + ' PRO_NOMCLI, '
         Else
         If FTip_Fc = 'C' Then
           Result := Result + ' CLI_NOMCLI, '
         Else
           Result := Result + ' FOR_NOMFOR, ';
       End;

    1: Result := Result + ' OCO_OPEOCO, ';
    2: Result := Result + ' OCO_CODOPE, ';
    3: Result := Result + ' GOC_DESGOC, ';
    4: Result := Result + ' SIT_DESSIT, ';
  End;


  Case cmbTipQue.ItemIndex Of
    0: Begin
        If FTip_Fc = 'P' Then
          Result := Result + ' CONCAT(OCO_CODCLI, " - ", PRO_NOMCLI) AS QUEBRA,        '
        Else
        If FTip_Fc = 'C' Then
          Result := Result + ' CONCAT(OCO_CODCLI, " - ", CLI_NOMCLI) AS QUEBRA,        '
        Else
          Result := Result + ' CONCAT(OCO_CODCLI, " - ", FOR_NOMFOR) AS QUEBRA,        ';
       End;

    1: Result := Result + ' CONCAT(OCO_OPEOCO, " - ",  O.OPE_NOMOPE) AS QUEBRA,        ';
    2: Result := Result + ' CONCAT(OCO_CODOPE, " - ",  C.OPE_NOMOPE) AS QUEBRA,        ';
    3: Result := Result + ' CONCAT(GOC_CODGOC, " - ",  GOC_DESGOC  ) AS QUEBRA,        ';
    4: Result := Result + ' CONCAT(SIT_CODSIT, " - ",  SIT_DESSIT  ) AS QUEBRA,        ';

  End;

  Result := Result + '        OCO_CODCLI,                                              ';

  If FTip_Fc = 'P' Then
    Result := Result + '        PRO_NOMCLI AS CLI_NOMCLI,                              '
  Else
  If FTip_Fc = 'C' Then
    Result := Result + '        CLI_NOMCLI,                                            '
  Else
    Result := Result + '        FOR_NOMFOR AS CLI_NOMCLI,                              ';

  Result := Result + '        GOC_CODGOC,                                              ';
  Result := Result + '        GOC_DESGOC,                                              ';

  Result := Result + '        OCO_CODTOC,                                              ';
  Result := Result + '        TOC_DESTOC,                                              ';

  Result := Result + '        OCO_OPEOCO,                                              ';
  Result := Result + '        O.OPE_NOMOPE AS N_OPEOCO,                                ';

  Result := Result + '        OCO_CODOPE,                                              ';
  Result := Result + '        C.OPE_NOMOPE AS N_CODOPE,                                ';

  Result := Result + fGetSQLDuracaoEmSegundos + 'AS DURACA                             ';

  Result := Result + ' FROM MOVOCO                                                     ';

  If FTip_Fc = 'P' Then
  Begin
    Result := Result + ' INNER JOIN PROSPE ON PRO_CODPRO = OCO_CODCLI                  ';
    Result := Result + ' LEFT  JOIN CADATI ON ATI_CODATI = PRO_CODATI                  ';
  End
  Else
  If FTip_Fc = 'C' Then
  Begin
    Result := Result + ' INNER JOIN CADCLI ON CLI_CODCLI = OCO_CODCLI                  ';
    Result := Result + ' LEFT  JOIN CADATI ON ATI_CODATI = CLI_CODATI                  ';
  End
  Else
  Begin
    Result := Result + ' INNER JOIN CADFOR ON FOR_CODFOR = OCO_CODCLI                  ';
    Result := Result + ' LEFT  JOIN CADATI ON ATI_CODATI = FOR_CODATI                  ';
  End;

  Result := Result + ' INNER JOIN CADTOC   ON TOC_CODTOC = OCO_CODTOC                  ';
  Result := Result + ' INNER JOIN CADGOC   ON GOC_CODGOC = TOC_CODGOC                  ';
  Result := Result + ' LEFT  JOIN ADEGER   ON GER_CODOCO = OCO_CODOCO                  ';
  Result := Result + ' LEFT  JOIN CADOPE O ON O.OPE_CODOPE = OCO_OPEOCO                ';
  Result := Result + ' LEFT  JOIN CADOPE C ON C.OPE_CODOPE = OCO_CODOPE                ';
  Result := Result + ' LEFT  JOIN SITOCO   ON SIT_CODSIT = OCO_CODSIT                  ';

  Result := Result + fGetSQLWhere;

  Result := Result + ' ORDER BY ';
  Case cmbTipQue.ItemIndex Of
    0: Begin
         If FTip_Fc = 'P' Then
           Result := Result + ' PRO_NOMCLI '
         Else
         If FTip_Fc = 'C' Then
           Result := Result + ' CLI_NOMCLI '
         Else
           Result := Result + ' FOR_NOMFOR ';
       End;

    1: Result := Result + ' N_OPEOCO ';
    2: Result := Result + ' N_CODOPE ';
    3: Result := Result + ' GOC_DESGOC   ';
    4: Result := Result + ' SIT_DESSIT ';
  End;

  Result := Result + ' , DTAHRA ';

end;

function TfrmRelOcorrenciasCRM.fGetSQLWhere : String;
Begin
  Result := '';
  Result := Result + ' WHERE OCO_TIP_FC = ' + QuotedStr(FTip_Fc);

  Result := Result + fStrLocate(edtCodCli, arrCodCli, 'OCO_CODCLI', 'CODCLI');
  Result := Result + fStrLocate(edtCodGat, arrGruAti, 'ATI_CODGAT', 'CODGAT');
  Result := Result + fStrLocate(edtCodAti, arrCodAti, 'ATI_CODATI', 'CODATI');
  Result := Result + fStrLocate(edtOpeOco, arrOpeOco, 'OCO_OPEOCO', 'OPEOCO');
  Result := Result + fStrLocate(edtCodOpe, arrCodOpe, 'OCO_CODOPE', 'CODOPE');
  Result := Result + fStrLocate(edtCodGoc, arrCodGoc, 'GOC_CODGOC', 'CODGOC');
  Result := Result + fStrLocate(edtCodToc, arrCodToc, 'OCO_CODTOC', 'CODTOC');
  Result := Result + fStrLocate(edtCodSit, arrCodSit, 'OCO_CODSIT', 'CODSIT');

  If (Not fEmptyDate(mskDtaIni.Text)) And (Not fEmptyDate(mskDtaFin.Text)) Then
    Result := Result + ' AND OCO_DTAINC BETWEEN :INCINI AND :INCFIN ';

  If (Not fEmptyDate(mskConIni.Text)) And (Not fEmptyDate(mskConFin.Text)) Then
    Result := Result + ' AND OCO_DTACON BETWEEN :CONINI AND :CONFIN ';

  Case cbStatus.ItemIndex Of
    1 : Result := Result + ' AND OCO_DTACON IS NULL     AND OCO_HORCON IS NULL     ';
    2 : Result := Result + ' AND OCO_DTACON IS NOT NULL AND OCO_HORCON IS NOT NULL ';
  End;

  If not fEmptyStr(edtAutDev.Text) Then
    Result := Result + ' AND GER_CODADE = :CODADE ';

  If not fEmptyStr(edtProtoc.Text) Then
    Result := Result + ' AND OCO_PROTOC = :PROTOC ';

End;

function TfrmRelOcorrenciasCRM.fGetSQLDuracaoEmSegundos : String;
Begin
  Result := '';
  Result := Result + '        IFNULL(TIMESTAMPDIFF(SECOND,                             ';
  Result := Result + '          CAST(CONCAT(OCO_DTAINC, " ", OCO_HORINC) AS DATETIME), ';
  Result := Result + '          CAST(CONCAT(OCO_DTACON, " ", OCO_HORCON) AS DATETIME)  ';
  Result := Result + '        ) ,0)                                                    ';
End;

function TfrmRelOcorrenciasCRM.fGetSQLSintetico: String;
begin
  Result := '';
  If cmbTipRel.ItemIndex = 1 Then
  Begin
    Result := Result + ' SELECT MAX(GOC_CODGOC) AS GOC_CODGOC,                           ';
    Result := Result + '        MAX(GOC_DESGOC) AS GOC_DESGOC,                           ';
    Result := Result + '        MAX(OCO_CODTOC) AS OCO_CODTOC,                           ';
    Result := Result + '        TOC_DESTOC,                                              ';
  End
  Else
  Begin
    Result := Result + ' SELECT OCO_CODSIT,                                              ';
    Result := Result + '        CONCAT(IFNULL(OCO_CODSIT,""), " - ", IFNULL(SIT_DESSIT,"")) AS SIT_DESSIT, ';
    Result := Result + '        OCO_CODTOC,                                              ';
    Result := Result + '        TOC_DESTOC,                                              ';
  End;

  Result := Result + ' COUNT( 0 ) AS QTDSEG,                                           ';
  Result := Result + ' SUM( ' + fGetSQLDuracaoEmSegundos + ' ) AS SUMSEG,              ';
  Result := Result + ' AVG( ' + fGetSQLDuracaoEmSegundos + ' ) AS AVGSEG,              ';
  Result := Result + ' MIN( ' + fGetSQLDuracaoEmSegundos + ' ) AS MINSEG,              ';
  Result := Result + ' MAX( ' + fGetSQLDuracaoEmSegundos + ' ) AS MAXSEG               ';

  Result := Result + ' FROM MOVOCO                                                     ';

  Result := Result + ' INNER JOIN CADTOC   ON TOC_CODTOC = OCO_CODTOC                  ';
  Result := Result + ' INNER JOIN CADGOC   ON GOC_CODGOC = TOC_CODGOC                  ';
  Result := Result + ' LEFT  JOIN ADEGER   ON GER_CODOCO = OCO_CODOCO                  ';
  If cmbTipRel.ItemIndex = 2 Then
    Result := Result + ' LEFT  JOIN SITOCO ON SIT_CODSIT = OCO_CODSIT                  ';

  If FTip_Fc = 'P' Then
  Begin
    Result := Result + ' INNER JOIN PROSPE ON PRO_CODPRO = OCO_CODCLI                  ';
    Result := Result + ' LEFT  JOIN CADATI ON ATI_CODATI = PRO_CODATI                  ';
  End
  Else
  If FTip_Fc = 'C' Then
  Begin
    Result := Result + ' INNER JOIN CADCLI ON CLI_CODCLI = OCO_CODCLI                  ';
    Result := Result + ' LEFT  JOIN CADATI ON ATI_CODATI = CLI_CODATI                  ';
  End
  Else
  Begin
    Result := Result + ' INNER JOIN CADFOR ON FOR_CODFOR = OCO_CODCLI                  ';
    Result := Result + ' LEFT  JOIN CADATI ON ATI_CODATI = FOR_CODATI                  ';
  End;

  Result := Result + fGetSQLWhere;

  If cmbTipRel.ItemIndex = 1 Then
  Begin
    Result := Result + ' GROUP BY OCO_CODTOC ';
    Result := Result + ' ORDER BY GOC_DESGOC, TOC_DESTOC ';
  End
  Else
  Begin
    Result := Result + ' GROUP BY OCO_CODSIT, OCO_CODTOC ';
    Result := Result + ' ORDER BY SIT_DESSIT, OCO_CODSIT, TOC_DESTOC ';
  End;

end;

procedure TfrmRelOcorrenciasCRM.FormCreate(Sender: TObject);
begin
  inherited;
  FTip_Fc:= 'C';
  cdsRelatorio := TZClient.Create(Self);
  blnExcel := True;

end;

procedure TfrmRelOcorrenciasCRM.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsRelatorio);
end;

procedure TfrmRelOcorrenciasCRM.FormShow(Sender: TObject);
begin
  inherited;
  If FTip_Fc = 'P' Then
  Begin
    lblCliente.Caption := 'Prospecto:';
    cmbTipQue.Items[0] := 'Prospecto';
  End
  Else
  If FTip_FC = 'F' Then
  Begin
    lblCliente.Caption := 'Fornecedor:';
    cmbTipQue.Items[0] := 'Fornecedor';
  End;
end;

function TfrmRelOcorrenciasCRM.fValidaCampos(Sender: TWinControl;
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

class procedure TfrmRelOcorrenciasCRM.pAbreRelatorio(strTipFC: String);
  var
    frmRel: TfrmRelOcorrenciasCRM;
begin
  Try
    pCriarFormularios(TfrmRelOcorrenciasCRM, frmRel);
    frmRel.FTip_Fc := strTipFC;
    frmRel.ShowModal;
  Finally
    FreeAndNil(frmRel);
  End;

end;

procedure TfrmRelOcorrenciasCRM.pGeraExcelInterna;
  Var
    objExcel : TGeraExcel;
begin
  objExcel := TGeraExcel.Create(cdsRelatorio, Nil);
  With objExcel Do
  Begin

    If cmbTipRel.ItemIndex = 0 Then
      strNomRel := 'RELATÓRIO DE OCORRÊNCIAS - ANALÍTICO POR ' + UpperCase(cmbTipQue.Text)
    Else
    If cmbTipRel.ItemIndex = 1 Then
      strNomRel := 'RELATÓRIO DE OCORRÊNCIAS - SINTÉTICO POR TIPO DE OCORRÊNCIA'
    Else
      strNomRel := 'RELATÓRIO DE OCORRÊNCIAS - SINTÉTICO POR SITUAÇÃO DA OCORRÊNCIA';

    If FTip_Fc = 'P' Then
      AddFiltro(fStrTitulo(edtCodCli, edtDesCli   , arrCodCli, strCodCli, 'CLIENTE PROSPECTO'))
    Else
    If FTip_Fc = 'C' Then
      AddFiltro(fStrTitulo(edtCodCli, edtDesCli   , arrCodCli, strCodCli, 'CLIENTE'))
    Else
      AddFiltro(fStrTitulo(edtCodCli, edtDesCli   , arrCodCli, strCodCli, 'FORNECEDOR'));

    AddFiltro( fStrTitulo(edtCodAti, edtDesAti   , arrCodAti, strCodAti, 'ATIVIDADE'));
    AddFiltro( fStrTitulo(edtCodGat, edtDesGat   , arrGruAti, strGruAti, 'GRUPO DE ATIVIDADE'));
    AddFiltro( fStrTitulo(edtOpeOco, edtDesOpeOco, arrOpeOco, strOpeOco, 'OPERADOR ORIGEM'));
    AddFiltro( fStrTitulo(edtCodOpe, edtDesCodOpe, arrCodOpe, strCodOpe, 'OPERADOR DESTINO'));
    AddFiltro( fStrTitulo(edtCodGoc, edtDesGoc   , arrCodGoc, strCodGoc, 'GRUPO DE OCORRÊNCIA'));
    AddFiltro( fStrTitulo(edtCodToc, edtDesToc   , arrCodToc, strCodToc, 'TIPO DE OCORRÊNCIA'));
    AddFiltro( fStrTitulo(edtCodSit, edtDesSit   , arrCodSit, strCodSit, 'SITUAÇÃO DA OCORRÊNCIA'));
    AddFiltro( 'PROTOCOLO: ' + IfThen( fEmptyStr(edtProtoc.Text), 'TODOS', edtProtoc.Text ));
    AddFiltro( 'SITUAÇÃO: ' + UpperCase(cbStatus.Text));
    AddFiltro( 'AD: ' + IfThen( fEmptyStr(edtAutDev.Text), 'TODOS', edtAutDev.Text ));
    AddFiltro( fStrTituloPeriodo(mskDtaIni, mskDtaFin) + ' (INCLUSÃO)');
    AddFiltro( fStrTituloPeriodo(mskConIni, mskConFin) + ' (CONCLUSÃO)');

    If cmbTipRel.ItemIndex = 0 Then
    Begin
      AddCampo('OCO_DTAINC', 'DATA INCLUSÃO');
      AddCampo('OCO_HORINC', 'HORA INCLUSÃO');
      AddCampo('OCO_PROTOC', 'PROTOCOLO');
      AddCampo('GOC_DESGOC', 'GRUPO DE OCORRÊNCIA');
      AddCampo('TOC_DESTOC', 'TIPO DE OCORRÊNCIA');
      AddCampo('OCO_DTACON', 'DATA CONCLUSÃO');
      AddCampo('OCO_HORCON', 'HORA CONCLUSÃO');

      AddCampo (fStrTempo, 'DURACAO' , 'TEMPO');

      AddCampo('N_OPEOCO', 'OPERADOR ORIGEM');
      AddCampo('N_CODOPE', 'OPERADOR DESTINO');
      AddCampo('OCO_CODEMP', 'EMPRESA');
      AddCampo('GER_CODADE', 'AD1');

      Case cmbTipQue.ItemIndex Of
        0: Begin
            If FTip_Fc = 'P' Then
              AddQuebra('QUEBRA', 'CLIENTE PROSPECTO ')
            Else
            If FTip_Fc = 'C' Then
              AddQuebra('QUEBRA', 'CLIENTE ')
            Else
              AddQuebra('QUEBRA', 'FORNECEDOR ');
           End;

        1: AddQuebra('QUEBRA', 'OPERADOR ORIGEM ');
        2: AddQuebra('QUEBRA', 'OPERADOR DESTINO ');
        3: AddQuebra('QUEBRA', 'GRUPO DE OCORRÊNCIA ');
        4: AddQuebra('QUEBRA', 'SITUAÇÃO DA OCORRÊNCIA ');
      End;

    End
    Else
    Begin
      AddCampo('TOC_DESTOC', 'TIPO DE OCORRÊNCIA');
      AddCampo(fStrSumSeg, 'SUMSEG', 'TEMPO DE FINALIZAÇÃO'); //*
      AddCampo('QTDSEG', 'QTD. DE OCORRÊNCIAS', 2);  //*
      AddCampo(fStrAvgSeg, 'AVGSEG', 'TEMPO MÉDIO'); //*
      AddCampo(fStrMinSeg, 'MINSEG', 'MENOR TEMPO');
      AddCampo(fStrMaxSeg, 'MAXSEG', 'MAIOR TEMPO');

      If cmbTipRel.ItemIndex = 1 Then
        AddQuebra('GOC_DESGOC', 'GRUPO DA OCORRÊNCIA ')
      Else
        AddQuebra('SIT_DESSIT', 'SITUAÇÃO DA OCORRÊNCIA ');

      AddTotais('SUMSEG');
      AddTotais('QTDSEG');
      AddTotais('AVGSEG');

      OnSomaResumo := pSomaResumo;
      OnMontaResumo:= pMontaResumo;

    End;

    If fGerarRelatorio Then
      fMensagem('','Arquivo gerado com sucesso!', ['&OK']);

  End;

end;

procedure TfrmRelOcorrenciasCRM.pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
Begin
  With Excel Do
  Begin
    ProximaLinha;
    If Quebra.NomeCampo = 'SIT_DESSIT' Then
      Escrever(LinhaAtual, Campos.ColunaPorNome['TOC_DESTOC'].Coluna, 'TOTAIS ' + Quebra.ValorAtual + ':')
    Else
      Escrever(LinhaAtual, Campos.ColunaPorNome['TOC_DESTOC'].Coluna, 'TOTAL GERAL:');
    Escrever(LinhaAtual, Campos.ColunaPorNome['SUMSEG'].Coluna, fSegToTempoStr( Trunc(RoundTo(Quebra.Totais['SUMSEG'],0)) ));
    Escrever(LinhaAtual, Campos.ColunaPorNome['QTDSEG'].Coluna, FormatFloat('#0', Quebra.Totais['QTDSEG']));
    Escrever(LinhaAtual, Campos.ColunaPorNome['AVGSEG'].Coluna, fSegToTempoStr( Trunc(RoundTo(Quebra.Totais['SUMSEG'] / Quebra.Totais['AVGSEG'],0)) ));

    Mesclar    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.ColunaPorNome['TOC_DESTOC'].Coluna) + IntToStr(LinhaAtual));
    Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
    CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
    CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
    Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));

  End;


End;

procedure TfrmRelOcorrenciasCRM.pSomaResumo(Var Totais: TTotais; Dados: TDataSet);
Begin
  Totais['SUMSEG'] := Totais['SUMSEG'] + Dados.FieldByName('SUMSEG').AsInteger;
  Totais['QTDSEG'] := Totais['QTDSEG'] + Dados.FieldByName('QTDSEG').AsInteger;
  Totais['AVGSEG'] := Totais['AVGSEG'] + 1;
End;

function TFrmRelOcorrenciasCRM.fStrTempo(dtsDados: TDataSet): String;
Begin
  Result := '';
  If dtsDados.FieldByName('OCO_HORCON').AsDateTime > 0 Then
    Result := fSegToTempoStr( dtsDados.FieldByName('DURACA').AsInteger );
End;

function TFrmRelOcorrenciasCRM.fStrAvgSeg(dtsDados: TDataSet): String;
Begin
  Result := fSegToTempoStr( dtsDados.FieldByName('AVGSEG').AsInteger );
End;

function TFrmRelOcorrenciasCRM.fStrMinSeg(dtsDados: TDataSet): String;
Begin
  Result := fSegToTempoStr( dtsDados.FieldByName('MINSEG').AsInteger );
End;

function TFrmRelOcorrenciasCRM.fStrMaxSeg(dtsDados: TDataSet): String;
Begin
  Result := fSegToTempoStr( dtsDados.FieldByName('MAXSEG').AsInteger );
End;

function TFrmRelOcorrenciasCRM.fStrSumSeg(dtsDados: TDataSet): String;
Begin
  Result := fSegToTempoStr( dtsDados.FieldByName('SUMSEG').AsInteger );
End;

end.
