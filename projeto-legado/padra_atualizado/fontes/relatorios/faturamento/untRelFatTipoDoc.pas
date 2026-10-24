unit untRelFatTipoDoc;
{ TODO 5 -oALEXANDRE -cRELATORIOS : REFAZER O RELATORIO EM FAST POIS A QUEBRA ESTA COM PROBLEMAS NA TOTALIZAÇÃO }
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, RLFilters, RLDraftFilter, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, Uni, AppEvnts, untTypesSistema, BitBtnLockedIncrem,
  ComCtrls, untExcel, DB, untGeraExcel, frxExportCSVTestabilidade;

type
  TfrmRelFatTipoDoc = class(TfrmPaiRelatorio)
    pgbProgresso: TProgressBar;
    pnlRodape: TPanel;
    Label5: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    lblEmpresa: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    lbl2: TLabel;
    lbl1: TLabel;
    lbl3: TLabel;
    lblVen: TLabel;
    lblDig: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    edtCodCli: TEditFocus;
    edtDesCli: TEditFocus;
    edtCodRed: TEditFocus;
    edtDesRed: TEditFocus;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    mskCodGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    edtCodDig: TEditFocus;
    edtNomDig: TEditFocus;
    lblEspecie: TLabel;
    mskEspecie: TMaskEditFocus;
    rdgEspeciais: TRadioGroup;
    gpbTipo: TGroupBox;
    ColorLabel2: TColorLabel;
    edtTipo: TEditFocus;
    rdgEmpresa: TRadioGroup;
    edtCodDepProd: TEditFocus;
    Label2: TLabel;
    edtDesDepProd: TEditFocus;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtTipoChange(Sender: TObject);
    procedure edtCodRedExit(Sender: TObject);
    procedure edtCodRedKeyPress(Sender: TObject; var Key: Char);
    procedure edtDestinoExit(Sender: TObject);
    procedure mskCodGruKeyPress(Sender: TObject; var Key: Char);
    procedure mskCodGruExit(Sender: TObject);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtCodDigKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDigExit(Sender: TObject);
    procedure edtCodDepProdKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepProdExit(Sender: TObject);
  private
    QryRelatorio : TUniQuery;

    arrCli : TConsultasArray;
    arrRed : TConsultasArray;
    arrDep : TConsultasArray;
    arrGru : TConsultasArray;
    arrEmp : TConsultasArray;
    arrVen : TConsultasArray;
    arrDig : TConsultasArray;
    arrDepProd : TConsultasArray;

    strCli : String;
    strRed : String;
    strDep : String;
    strGru : String;
    strEmp : String;
    strVen : String;
    strDig : String;
    strDepProd : String;

    stlDocumento   : TStringList;
    blnUsaCnd      : Boolean;

    strFiltroEmpresa1 : String;
    strFiltroEmpresa2 : String;
    
    procedure pGeraExcel;
    procedure pMontaTitGru(Excel: TExcel; Dados: TDataSet; Campos: TCampos; Quebra: TRecQuebras);
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    procedure pSomaTotais(var Totais: TTotais; Dados: TDataSet);

    Function fGetCampos(strTipo: String): String;
    Function fGetFrom: String;
    Function fGetWhere: String;
    Procedure pSetUnionAll(Var strSQL: String);
    Function fGetOrderBy(strTipo: String): String;
    Function fGetGroupBy: String;


  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmRelFatTipoDoc: TfrmRelFatTipoDoc;

implementation

uses untFuncoesFactory, untIFuncoes, untQckFatTipoDoc, untConstantes,
  untClassPanelCx;

{$R *.dfm}

procedure TfrmRelFatTipoDoc.FormShow(Sender: TObject);
begin
  inherited;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;

  shpMultSel.Visible := True;

  QryRelatorio := fCriaQuery;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelFatTipoDoc.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtDesEmp, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmRelFatTipoDoc.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatTipoDoc.edtTipoChange(Sender: TObject);
begin
  inherited;
  If edtTipo.Text = 'A' Then
    rdgEmpresa.Enabled := True
  Else Begin
    rdgEmpresa.ItemIndex := 0;
    rdgEmpresa.Enabled   := False;
  End;
end;

procedure TfrmRelFatTipoDoc.pSetUnionAll(Var strSQL: String);
  Var
    str_FF : String;
    str_TR : String;
    str_DV : String;
begin
  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVDET', 'NOTDET'), 'MOVGER', 'NOTGER'), 'MOVTRI', 'NOTTRI');

  {******************************************************}
  {* TROCA AGORA , FILTRO1 E FILTRO2 , COM AS VARIAVEIS *}
  {***************************************************DP*}
  strSQL := AnsiReplaceStr(strSQL, '<FILTROEMPRESA1>', strFiltroEmpresa1);
  strSQL := AnsiReplaceStr(strSQL, '<FILTROEMPRESA2>', strFiltroEmpresa2);

  str_FF := strSQL;
  str_TR := strSQL;
  str_DV := strSQL;

  {*******************************************}
  {* CASO A OPÇÃO SEJA 2 (FF POR DATA DE CON-*}
  {* FIRMAÇÃO, ACRESCENTA MAIS UM SELECT QUE *}
  {* FILTRA APENAS AS FF       E VAI POR DATA*}
  {* DE CONFIRMAÇÃO. CASO SEJA OPÇÃO 1,      *}
  {* NÃO FILTRA EM LUGAR NENHUM POR FF       *}
  {****************************************DP*}
  If (fCfgSis('COM_FF') = '2') Then
  Begin
    str_FF := AnsiReplaceStr(str_FF, 'DET_DTAENT','DET_DTAFAT');
    str_FF := AnsiReplaceStr(str_FF, 'NOT IN ("FF")','IN ("FF")');

    strSQL := strSQL + ' UNION ALL ' + str_FF;
  End
  Else
    strSQL := AnsiReplaceStr(strSQL, 'NOT IN ("FF")','NOT IN ("")');

  {*******************************************}
  {* CASO A OPÇÃO SEJA 2 (FF POR DATA DE CON-*}
  {* FIRMAÇÃO, ACRESCENTA MAIS UM SELECT QUE *}
  {* FILTRA APENAS AS    TR/DV E VAI POR DATA*}
  {* DE CONFIRMAÇÃO. CASO SEJA OPÇÃO 1,      *}
  {* NÃO FILTRA EM LUGAR NENHUM POR    TR/DV *}
  {****************************************DP*}
  If (fCfgSis('COM_TR') = '2') Then
  Begin
    str_TR := AnsiReplaceStr(str_TR, 'DET_DTAENT','DET_DTAFAT');
    str_TR := AnsiReplaceStr(str_TR, 'NOT IN ("TR")','IN ("TR")');

    strSQL := strSQL + ' UNION ALL ' + str_TR;
  End
  Else
    strSQL := AnsiReplaceStr(strSQL, 'NOT IN ("TR")','NOT IN ("")');

  If (fCfgSis('COM_DV') = '2') Then
  Begin
    str_DV := AnsiReplaceStr(str_DV, 'DET_DTAENT','DET_DTAFAT');
    str_DV := AnsiReplaceStr(str_DV, 'NOT IN ("DV")','IN ("DV")');

    strSQL := strSQL + ' UNION ALL ' + str_DV;
  End
  Else
    strSQL := AnsiReplaceStr(strSQL, 'NOT IN ("DV")','NOT IN ("")');
end;

function TfrmRelFatTipoDoc.fGetCampos(strTipo: String): String;
  Var
    strCampos : String;

  function fSQLInfDigitador:String;
  begin
    Result:='""';

    If lblDig.Visible Then
      Result:= 'IF(IFNULL(DET_CODDIG,"") = "", "", '+
             '   (SELECT CONCAT("   ", "DIGITADOR: ", OPE_CODOPE, "-", OPE_NOMOPE) FROM CADOPE '+
             '               WHERE OPE_CODOPE = DET_CODDIG LIMIT 1)) ';
  end;
begin
  strCampos :=             ' SELECT SQL_NO_CACHE ';
  strCampos := strCampos + '  DET_CODEMP AS CODEMP, ';
  strCampos := strCampos + '  CONCAT("VENDEDOR: ", DET_CODVEN, "-", OPE_NOMOPE, '+fSQLInfDigitador+') AS CODVEN, ';
  strCampos := strCampos + '  CONCAT(DET_CODITE,"-",DET_DESCRI) AS DESITE, ';
  strCampos := strCampos + '  CONCAT(DET_CODCLI,"-",CLI_NOMCLI) AS NOMCLI, ';
  strCampos := strCampos + '  DET_DTAENT AS DTAENT, ';
  strCampos := strCampos + '  DET_HORENT AS HORENT, ';
  strCampos := strCampos + '  DET_ESPDOC AS ESPDOC, ';
  strCampos := strCampos + '  DET_NUMDOC AS DOCUME, ';
  If blnUsaCnd Then
    strCampos := strCampos + '  CONCAT(DET_CONPAG,"-",CND_DESCRI) AS CONPAG, '
  Else
    strCampos := strCampos + '  DET_CONPAG AS CONPAG, ';
  strCampos := strCampos + '  CONCAT(DET_NUMDOC,"-",DET_ESPDOC,"-",DET_CODEMP) AS NUMDOC, ';

  If strTipo = 'S' Then
  Begin
    strCampos := strCampos + '  SUM(DET_UNITAR) AS UNITAR, ';
    strCampos := strCampos + '  SUM(DET_DESESP) AS DESESP, ';
    strCampos := strCampos + '  SUM(DET_TOTITE) AS TOTITE, ';
    strCampos := strCampos + '  SUM((DET_QTDITE * UNI_PESLIT / :LITGAL)) AS LITRAGEM, ';
    strCampos := strCampos + '  SUM(IF(LEFT(DET_CLAFIS,1) < 5,"ENTRADA","SAIDA")) AS ENTSAI, ';
    strCampos := strCampos + '  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_QTDITE), DET_QTDITE))                           AS  QTDITE, ';
    strCampos := strCampos + '  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP), DET_TOTITE - DET_DESESP)) AS  VLRCON  ';
  End
  Else
  Begin
    strCampos := strCampos + '  DET_UNITAR AS UNITAR, ';
    strCampos := strCampos + '  DET_DESESP AS DESESP, ';
    strCampos := strCampos + '  DET_TOTITE AS TOTITE, ';
    strCampos := strCampos + '  (DET_QTDITE * UNI_PESLIT / :LITGAL) AS LITRAGEM, ';
    strCampos := strCampos + '  (IF(LEFT(DET_CLAFIS,1) < 5,"ENTRADA","SAIDA")) AS ENTSAI, ';
    strCampos := strCampos + '  (IF(LEFT(DET_CLAFIS,1) < 5, -(DET_QTDITE), DET_QTDITE))                            AS  QTDITE, ';
    strCampos := strCampos + '  (IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP), DET_TOTITE - DET_DESESP))  AS  VLRCON  ';
  End;
  Result := strCampos;  
end;

function TfrmRelFatTipoDoc.fGetFrom: String;
begin
  Result :=          '  FROM ';
  Result := Result + '   MOVDET ';
  Result := Result + ' INNER JOIN MOVGER G ON G.AUTOINCREM = MOVDET.DET_SEQGER ';
  Result := Result + ' INNER JOIN CADOPE   ON OPE_CODOPE = DET_CODVEN ';
  Result := Result + ' INNER JOIN CADCLI   ON CLI_CODCLI = DET_CODCLI ';
  Result := Result + ' INNER JOIN CADITE   ON ITE_CODITE = DET_CODITE ';
  Result := Result + ' INNER JOIN CADUNI   ON UNI_CODUNI = DET_UNIDAD ';
  If blnUsaCnd Then
    Result := Result + ' LEFT JOIN CADCND ON CND_CODIGO = DET_CODCND ';
  Result := Result + ' LEFT JOIN MOVTRI TRI ON TRI.DET_SEQGER = MOVDET.AUTOINCREM ';
end;

function TfrmRelFatTipoDoc.fGetGroupBy: String;
begin
  Result :=          ' GROUP BY ';
  Result := Result + '   NUMDOC ';
end;

function TfrmRelFatTipoDoc.fGetOrderBy(strTipo: String): String;
begin
  Result := ' ORDER BY ';
  If strTipo = 'A' Then
    Result := Result + ' DOCUME, ESPDOC, DESITE '
  Else
    Result := Result + ' ESPDOC, DOCUME ';
end;

function TfrmRelFatTipoDoc.fGetWhere: String;
  Var
    strSQLWhere : String;
begin
  strSQLWhere := ' WHERE ';
  strSQLWhere := strSQLWhere + ' DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  {********************************}
  {* SISTEMATICA DE CONSIDERAR FF *}
  {*****************************DP*}
  strSQLWhere := strSQLWhere + '  AND DET_ESPDOC NOT IN ("FF") ';
  strSQLWhere := strSQLWhere + '  AND DET_ESPDOC NOT IN ("TR") ';
  strSQLWhere := strSQLWhere + '  AND DET_ESPDOC NOT IN ("DV") ';
  strSQLWhere := strSQLWhere + '  AND IFNULL(DET_PROEMB,"") <> "S" ';

  Case rdgEspeciais.ItemIndex Of
    1: strSQLWhere := strSQLWhere + '  AND GER_NOTESP <> "S" ';
    2: strSQLWhere := strSQLWhere + '  AND GER_NOTESP =  "S" ';
  End;

  {************************************************}
  {* EMPRESA DE FATURAMENTO / EMPRESA DE ORIGEM   *}
  {* FAZ O FILTRO SEPARADO, POIS A QUERY LIGA COM *}
  {* NOTDET E NÃO O CAMPO DET_EMP_PD NA TABELA    *}
  {* EXISTEM DOIS FILTROS ENTAO, 1 PARA MOVDET E  *}
  {* OUTRO PARA NOTDET                            *}
  {*********************************************DP*}
  strSQLWhere := strSQLWhere + '<FILTROEMPRESA1>';
  
  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    Case rdgEmpresa.ItemIndex Of
      0: strFiltroEmpresa1 := strFiltroEmpresa1 + fStrLocate(edtCodEmp, arrEmp, 'DET_CODEMP', 'CODEMP');
      1: strFiltroEmpresa1 := strFiltroEmpresa1 + fStrLocate(edtCodEmp, arrEmp, 'TRI.DET_EMPORI', 'CODEMP');
    End;
  End
  Else
  Begin
    Case rdgEmpresa.ItemIndex Of
      0: strFiltroEmpresa1 := strFiltroEmpresa1 + '  AND LOCATE(DET_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
      1: strFiltroEmpresa1 := strFiltroEmpresa1 + '  AND LOCATE(TRI.DET_EMPORI, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
    End;
  End;

  If Not fEmptyStr(edtCodEmp.Text) Then
    strFiltroEmpresa2 := fStrLocate(edtCodEmp,  arrEmp, 'DET_CODEMP', 'CODEMP')
  Else
    strFiltroEmpresa2 := '  AND LOCATE(DET_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  If Not fEmptyStr(edtCodCli.Text) Then
    strSQLWhere := strSQLWhere + fStrLocate(edtCodCli, arrCli, 'DET_CODCLI', 'CODCLI');

  If Not fEmptyStr(edtCodRed.Text) Then
    strSQLWhere := strSQLWhere + fStrLocate(edtCodRed, arrRed, 'CLI_CODRED', 'CODRED');

  If Not fEmptyStr(edtCodDep.Text) Then
    strSQLWhere := strSQLWhere + fStrLocate(edtCodDep, arrDep, 'OPE_CODDEP', 'CODDEP');

  If Not fEmptyStr(edtCodDepProd.Text) Then
    strSQLWhere := strSQLWhere + fStrLocate(edtCodDepProd, arrDepProd, 'ITE_CODDEP', 'ITEDEP');

  If Not fEmptyStr(edtCodVen.Text) Then
    strSQLWhere := strSQLWhere + fStrLocate(edtCodVen, arrVen, 'DET_CODVEN', 'CODVEN');

  If Not fEmptyStr(edtCodDig.Text) Then
    strSQLWhere := strSQLWhere + fStrLocate(edtCodDig, arrDig, 'DET_CODDIG', 'CODDIG');

  If Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
    strSQLWhere := strSQLWhere + '  AND LOCATE(DET_ESPDOC, :ESPDOC) > 0 '
  Else
    strSQLWhere := strSQLWhere + '  AND LOCATE(DET_ESPDOC, "TM_ML_PR_") <= 0 ';

  If Not fEmptyStr(mskCodGru.Text) Then
  Begin
    strSQLWhere := strSQLWhere + '  AND EXISTS (SELECT ';
    strSQLWhere := strSQLWhere + '                ITE_CODGRU ';
    strSQLWhere := strSQLWhere + '              FROM ';
    strSQLWhere := strSQLWhere + '                CADITE ';
    strSQLWhere := strSQLWhere + '                JOIN MOVDET D ON D.DET_CODITE = ITE_CODITE ';
    strSQLWhere := strSQLWhere + '              WHERE ';
    strSQLWhere := strSQLWhere + '                D.DET_CODEMP = G.GER_CODEMP AND';
    strSQLWhere := strSQLWhere + '                D.DET_SEQGER = G.AUTOINCREM ';
    strSQLWhere := strSQLWhere + fStrLocateLinGru(mskCodGru, arrGru, 'ITE_CODGRU', 'CODGRU');
    strSQLWhere := strSQLWhere + '              )';
  End;

  Result := strSQLWhere + ' ';
end;

procedure TfrmRelFatTipoDoc.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtDesCli, arrCli, Nil, fRetNomCliente, 'do cliente');

  If Not fEmptyStr(edtCodCli.Text) Then
  Begin
    edtCodRed.Enabled := False;
    edtCodRed.Clear;
    pEdtCodSelectExit(edtCodRed, edtDesRed, arrRed, Nil, fRetNomeRedeLoja, 'da rede');
    pSetFocus(edtCodDep);
  End Else
  Begin
    edtCodRed.Enabled := True;
  End;
end;

procedure TfrmRelFatTipoDoc.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrCli, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatTipoDoc.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesDep, arrDep, fRetDescDepartamento, Nil, 'do Departamento');
end;

procedure TfrmRelFatTipoDoc.edtCodDepKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE DEPARTAMENTO *}
  {******************************MM*}
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrDep, False) Then
  Begin
    If fValidaCampos(edtCodDep, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatTipoDoc.edtCodDepProdExit(Sender: TObject);
begin
  inherited;
   pEdtCodSelectExit(edtCodDepProd, edtDesDepProd, arrDepProd, fRetDescDepartamento, Nil, 'do Departamento');
end;

procedure TfrmRelFatTipoDoc.edtCodDepProdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE DEPARTAMENTO *}
  {******************************MM*}
  If fPesqDepartamento(Self, edtCodDepProd, edtDesDepProd, Nil, Key, arrDepProd, False) Then
  Begin
    If fValidaCampos(edtCodDepProd, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatTipoDoc.edtCodDigExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDig, edtNomDig, arrDig, fRetNomeOperador, Nil, 'do digitador');
end;

procedure TfrmRelFatTipoDoc.edtCodDigKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodDig, edtNomDig, Nil, Key, arrDig, False) Then
  Begin
    If fValidaCampos(edtCodDig, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatTipoDoc.edtCodRedExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRed, edtDesRed, arrRed, Nil, fRetNomeRedeLoja, 'da rede');
end;

procedure TfrmRelFatTipoDoc.edtCodRedKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {**********************************}
  {* NOVA CONSULTA DE REDE DE LOJAS *}
  {*******************************RV*}
  If fPesqRedeLojas(Self, edtCodRed, edtDesRed, Nil, Key, arrRed, False) Then
  Begin
    If fValidaCampos(edtCodRed, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatTipoDoc.edtCodVenExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVen, edtNomVen, arrVen, fRetNomeOperador, Nil, 'do vendedor');
end;

procedure TfrmRelFatTipoDoc.edtCodVenKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodVen, edtNomVen, Nil, Key, arrVen, False) Then
  Begin
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatTipoDoc.edtDestinoExit(Sender: TObject);
begin
  If edtDestino.Text <> 'E' Then
    inherited;
end;

function TfrmRelFatTipoDoc.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
  Var
    intCnt : Integer;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnValidaIndividual)) Then
  Begin

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

    Else
    If (Sender = edtTipo) Then
    Begin
      If (edtTipo.Text <> 'A') AND (edtTipo.Text <> 'S') Then
      Begin
        fMensagem('','O Campo Tipo deve conter A OU S ',['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If Not fEmptyStr(edtCodEmp.Text) Then
      Begin
        If edtCodEmp.Text <> '000' Then
        Begin
          If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&OK']);
            Result := False;
          End;
        End
        Else
        Begin
          For intCnt := Low(arrEmp) To High(arrEmp) Do
          Begin
            If Pos(arrEmp[intCnt].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&OK']);
              Result := False;
              Break;
            End; 
          End;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelFatTipoDoc.mskCodGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskCodGru, edtDesGru, arrGru, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
end;

procedure TfrmRelFatTipoDoc.mskCodGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskCodGru, edtDesGru, Nil, Key, arrGru, False) Then
  Begin
    If fValidaCampos(mskCodGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatTipoDoc.btnImprimirClick(Sender: TObject);
  Var 
    strSQL : String;
begin
  pnlInfo.Caption := 'Gerando Relatório...';
  blnUsaCnd := fCfgSis('USACND', varBoolean);
  pnlInfo.Repaint;

  strFiltroEmpresa1 := '';
  strFiltroEmpresa2 := '';
  
  strCli := '';
  strRed := '';
  strDep := '';
  strGru := '';
  strEmp := '';

  inherited;
                                         
  If blnImprime Then
  Begin

    {******************************}
    {* SELECT RELATORIO ANALITICO *}
    {***************************LB*}
    If edtTipo.Text = 'A' Then
    Begin
      strSQL := '';
      strSQL := strSQL + fGetCampos(edtTipo.Text);
      strSQL := strSQL + fGetFrom;
      strSQL := strSQL + fGetWhere;
      pSetUnionAll(strSQL);
      strSQL := strSQL + fGetOrderBy(edtTipo.Text);
    End    
    {******************************}
    {* SELECT RELATORIO SINTETICO *}
    {***************************LB*}
    Else
    Begin 
      strSQL := '';
      strSQL := strSQL + fGetCampos(edtTipo.Text);
      strSQL := strSQL + fGetFrom;
      strSQL := strSQL + fGetWhere;
      strSQL := strSQL + fGetGroupBy;
      pSetUnionAll(strSQL);
      strSQL := strSQL + fGetOrderBy(edtTipo.Text);
    End;

    With QryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

      If Not fEmptyStr(edtCodEmp.Text) Then
        pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', QryRelatorio);

      If Not fEmptyStr(edtCodCli.Text) Then
        pSetaParam(edtCodCli.Text, arrCli, strCli, 'CODCLI', QryRelatorio);

      If Not fEmptyStr(edtCodRed.Text) Then
        pSetaParam(edtCodRed.Text, arrRed, strRed, 'CODRED', QryRelatorio);

      If Not fEmptyStr(edtCodDep.Text) Then
        pSetaParam(edtCodDep.Text, arrDep, strDep, 'CODDEP', QryRelatorio);

      If Not fEmptyStr(edtCodDepProd.Text) Then
        pSetaParam(edtCodDepProd.Text, arrDepProd, strDepProd, 'ITEDEP', QryRelatorio);

      If Not fEmptyStr(mskCodGru.Text) Then
        pSetaParam(mskCodGru.Text, arrGru, strGru, 'CODGRU', QryRelatorio);

      If Not fEmptyStr(edtCodVen.Text) Then
        pSetaParam(edtCodVen.Text, arrVen, strVen, 'CODVEN', QryRelatorio);

      If Not fEmptyStr(edtCodDig.Text) Then
        pSetaParam(edtCodDig.Text, arrDig, strDig, 'CODDIG', QryRelatorio);

      If Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
        ParamByName('ESPDOC').AsString := mskEspecie.Text;

      If Params.FindParam('LITGAL') <> Nil Then
      Begin
        If SameText(fCfgSis('LITGAL'), 'L') Then
          ParamByName('LITGAL').AsFloat := 1
        Else
          ParamByName('LITGAL').AsFloat := FLT_LITRO_GALAO;
      End;

      Open;
    End;

    If Not QryRelatorio.IsEmpty Then
    Begin
      If edtDestino.Text = 'E' Then
        pGeraExcel
      Else
      Begin
        Try
          pCriarFormularios(TfrmQckFatTipoDoc,frmQckFatTipoDoc);

          If strTipImp = 'M' Then
            frmQckFatTipoDoc.qckPagina.DefaultFilter := rldFiltro
          Else
            frmQckFatTipoDoc.qckPagina.DefaultFilter := Nil;

          {********************}
          {* CABEÇALHO DO QCK *}
          {*****************LB*}

          frmQckFatTipoDoc.strOrdem := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

          frmQckFatTipoDoc.rllEmpresa.Caption    := IfThen(rdgEmpresa.ItemIndex = 0, 'EMPRESA (FATURAMENTO): ', 'EMPRESA (ORIGEM): ') + Copy(fStrTitulo(edtCodEmp.Text, edtDesEmp, arrEmp, strEmp, '', True), 2, 500);
          frmQckFatTipoDoc.rllCliente.Caption    := fStrTitulo(edtCodCli.Text, edtDesCli, arrCli, strCli, 'CLIENTE');
          frmQckFatTipoDoc.rllRedeLoja.Caption   := fStrTitulo(edtCodRed.Text, edtDesRed, arrRed, strRed, 'REDE DE LOJAS', True);
          frmQckFatTipoDoc.rllDepart.Caption     := fStrTitulo(edtCodDep.Text, edtDesDep, arrDep, strDep, 'DEPTO. OPEDERADORES');
          frmQckFatTipoDoc.rllDepartProd.Caption := fStrTitulo(edtCodDepProd.Text, edtDesDepProd, arrDepProd, strDepProd, 'DEPTO. PRODUTOS');
          frmQckFatTipoDoc.rllLinhaGrupo.Caption := fStrTitulo(mskCodGru.Text, edtDesGru, arrGru, strGru, 'LINHA/GRUPO');
          frmQckFatTipoDoc.rllVen.Caption        := fStrTitulo(edtCodVen.Text, edtNomVen, arrVen, strVen, 'VENDEDOR');

          frmQckFatTipoDoc.rllDig.Visible:=False;
          If lblDig.Visible then
          Begin
            frmQckFatTipoDoc.rllDig.Visible := True;
            frmQckFatTipoDoc.rllDig.Caption := fStrTitulo(edtCodDig.Text, edtNomDig, arrDig, strDig, 'DIGITADOR');
          End;

          If (Not fEmptyStr(frmQckFatTipoDoc.rllLinhaGrupo.Caption)) And (frmQckFatTipoDoc.rllLinhaGrupo.Caption <> 'LINHA/GRUPO: TODOS') Then
            frmQckFatTipoDoc.rllLinhaGrupo.Caption := frmQckFatTipoDoc.rllLinhaGrupo.Caption + ' (* Filtra docs. que contenham ao menos 1 item do grupo *) ';

          If fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
            frmQckFatTipoDoc.rllEspecie.Caption := 'ESPECIE: TODAS '
          Else
            frmQckFatTipoDoc.rllEspecie.Caption := 'ESPECIE: ' + mskEspecie.Text;

          Case rdgEspeciais.ItemIndex Of
            0: frmQckFatTipoDoc.rllEspeciais.Caption := 'EXIBIR TODAS AS NOTAS ';
            1: frmQckFatTipoDoc.rllEspeciais.Caption := 'NAO EXIBIR NOTA ESPECIAL E CUPOM ESPECIAL';
            2: frmQckFatTipoDoc.rllEspeciais.Caption := 'EXIBIR APENAS NOTA ESPECIAL E CUPOM ESPECIAL';
          End;

          If edtTipo.Text = 'A' Then
          Begin
            frmQckFatTipoDoc.rllNomeRelatorio.Caption := 'RELATORIO POR ESPECIE DE DOCUMENTO - ANALITICO ';
            frmQckFatTipoDoc.rlbTitulo.Visible := True;
            frmQckFatTipoDoc.rlbGrupo.Visible := True;
          End
          Else
          Begin
            frmQckFatTipoDoc.rllNomeRelatorio.Caption := 'RELATORIO POR ESPECIE DE DOCUMENTO - SINTETICO ';
            frmQckFatTipoDoc.rlbTituloSintetico.Visible := True;
            frmQckFatTipoDoc.rlbDetalhe.Visible := True;
            frmQckFatTipoDoc.rlbTotalGeral.Borders.DrawTop := True;
          End;

          frmQckFatTipoDoc.rllNomeRelatorio.Caption := frmQckFatTipoDoc.rllNomeRelatorio.Caption;

          frmQckFatTipoDoc.dtsRelatorio.DataSet := QryRelatorio;

          If edtDestino.Text = 'V' Then
            frmQckFatTipoDoc.qckPagina.PreviewModal
          Else
            frmQckFatTipoDoc.qckPagina.Print;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
          End;
        End;
        pFreeAndNil(frmQckFatTipoDoc);
      End;
    End
    Else
    Begin
      pTabelaVazia;
    End;
    btnImprimir.Enabled := True;
    pnlInfo.Caption := ''
  End;
end;

procedure TfrmRelFatTipoDoc.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  inherited;
  if Assigned(QryRelatorio) then
    FreeAndNil(QryRelatorio);
end;

procedure TfrmRelFatTipoDoc.FormCreate(Sender: TObject);
  Var
    intDif:Integer;
begin
  inherited;

  lblDig.Visible:=fCfgSis('USADIG', varBoolean);
  edtCodDig.Visible:=lblDig.Visible;
  edtNomDig.Visible:=lblDig.Visible;

  If Not lblDig.Visible Then
  Begin
    intDif:=pnlRodape.Top-lblDig.Top;

    pnlRodape.Top  := pnlRodape.Top-intDif;
    gpbDestino.Top := gpbDestino.Top-intDif;
    Self.Height    := Self.Height-intDif;
  End;

end;

procedure TfrmRelFatTipoDoc.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If ActiveControl Is TRadioButton Then
                 self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatTipoDoc.pMontaTitGru(Excel: TExcel;
  Dados: TDataSet; Campos: TCampos; Quebra: TRecQuebras);
begin
  With Excel, Dados Do
  Begin
    If Quebra.NomeCampo = 'NUMDOC' Then
    Begin
      Escrever(ProximaLinha, 01, 'DOCUMENTO - EMPRESA: ' + FieldByName('NUMDOC').AsString + ' ' +
                                                           FieldByName('CODVEN').AsString );

      Escrever(ProximaLinha,  01, 'DATA EMISSÃO: '+ FieldByName('DTAENT').AsString + ' ' +
                                  'CLIENTE: '     + FieldByName('NOMCLI').AsString + ' ' +
                                  'COND. PAGTO: ' + FieldByName('CONPAG').AsString );

      Negrito (LinhaAtual   , 01, True);
      Negrito (LinhaAtual -1, 01, True);

      Mesclar ('A' + IntToStr(LinhaAtual -1), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual -1));
      Mesclar ('A' + IntToStr(LinhaAtual   ), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual   ));

      CorFundo('A' + IntToStr(LinhaAtual -1), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Verde_Mar);
      CorFonte('A' + IntToStr(LinhaAtual -1), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Branco);
      Bordas  ('A' + IntToStr(LinhaAtual -1), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True, True, False, False);
    End;
  End;
end;

procedure TfrmRelFatTipoDoc.pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
  Var
    strTotal: String;
begin
  With Excel Do
  Begin
    If (Quebra.NomeCampo = 'NUMDOC') Then
    Begin
      stlDocumento.Add(fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
      strTotal := strTotal +
                  'NÚMERO DE ITENS: ' + fPadL(FormatFloat('##,#0', Quebra.Totais['NUMITE']), 14) + '   ' +
                  'QUANTIDADE TOTAL:  ' + fPadL(FormatFloat('##,#0.0000', Quebra.Totais['QTDITE'] ), 14) + '   ' +
                  'DESCONTO ESPECIAL:   ' + fPadL(FormatFloat('##,#0.00', Quebra.Totais['DESESP']  ), 14);
      Escrever(ProximaLinha, 01, strTotal);
      Mesclar    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
      Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
      CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
      CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
      Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
      Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);

      strTotal := 'TOTAL DOCUMENTO:   ' + fPadL(FormatFloat('##,#0.00', Quebra.Totais['VLRCON']  ), 14);
      Escrever(ProximaLinha, 01, strTotal);
      Mesclar    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
      Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
      CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
      CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
      Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
      Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);
    End
    Else
    Begin
    If (edtTipo.Text = 'A') Then
      strTotal := 'NÚMERO DE DOCUMENTOS: ' + fPadL(FormatFloat('##,#0', stlDocumento.Count), 14) + '   ' +
                  'TOTAL GERAL:   ' + fPadL(FormatFloat('##,#0.00', Quebra.Totais['TOTGER']  ), 14)
    Else
      strTotal := 'NÚMERO DE DOCUMENTOS: ' + fPadL(FormatFloat('##,#0', Quebra.Totais['TOTDOC']  ), 14) + '   ' +
                  'TOTAL GERAL:   ' + fPadL(FormatFloat('##,#0.00', Quebra.Totais['TOTGER']  ), 14);
      Escrever(ProximaLinha, 01, strTotal);
      Mesclar    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
      Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
      CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
      CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
      Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
      Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);
    End;
  End;
end;

procedure TfrmRelFatTipoDoc.pSomaTotais(var Totais: TTotais;
  Dados: TDataSet);
begin
  Totais['NUMITE'] := Totais['NUMITE'] + 1;
  Totais['QTDITE'] := Totais['QTDITE'] + Dados.FieldByName('QTDITE').AsFloat;
  Totais['DESESP'] := Totais['DESESP'] + Dados.FieldByName('DESESP').AsFloat;
  Totais['VLRCON'] := Totais['VLRCON'] + Dados.FieldByName('VLRCON').AsFloat;
  Totais['TOTGER'] := Totais['TOTGER'] + Dados.FieldByName('VLRCON').AsFloat;
  Totais['TOTDOC'] := Totais['TOTDOC'] + 1;
end;

procedure TfrmRelFatTipoDoc.pGeraExcel;
  Var
    objGeraExcel: TGeraExcel;
begin
  stlDocumento := TStringList.Create;
  stlDocumento.Sort;
  objGeraExcel := TGeraExcel.Create(QryRelatorio, pgbProgresso);
  With objGeraExcel Do
  Begin
    strNomRel := 'RELATÓRIO POR ESPÉCIE DE DOCUMENTO -' +
                              IfThen(edtTipo.Text = 'A', ' ANALÍTICO ', ' SINTÉTICO ');
    AddFiltro('');

    AddFiltro(IfThen(rdgEmpresa.ItemIndex = 0, 'EMPRESA (FATURAMENTO): ', 'EMPRESA (ORIGEM): ') + Copy(fStrTitulo(edtCodEmp.Text, edtDesEmp, arrEmp, strEmp, '', True), 2, 500));
    AddFiltro(fStrTitulo(edtCodCli.Text, edtDesCli, arrCli, strCli, 'CLIENTE'));
    AddFiltro(fStrTitulo(edtCodRed.Text, edtDesRed, arrRed, strRed, 'REDE DE LOJAS', True));
    AddFiltro(fStrTitulo(edtCodDep.Text, edtDesDep, arrDep, strDep, 'DEPTO.OPERADORES'));
    AddFiltro(fStrTitulo(edtCodDepProd.Text, edtDesDepProd, arrDepProd, strDepProd, 'DEPTO.PRODUTOS'));
    AddFiltro(fStrTitulo(mskCodGru.Text, edtDesGru, arrGru, strGru, 'LINHA/GRUPO'));
    AddFiltro(fStrTitulo(edtCodVen.Text, edtNomVen, arrVen, strVen, 'VENDEDOR'));
    If lblDig.Visible then
      AddFiltro(fStrTitulo(edtCodDig.Text, edtNomDig, arrDig, strDig, 'DIGITADOR'));

    If fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
      AddFiltro('ESPECIE: TODAS ')
    Else
      AddFiltro('ESPECIE: ' + mskEspecie.Text);

    Case rdgEspeciais.ItemIndex Of
      0: AddFiltro('EXIBIR TODAS AS NOTAS ');
      1: AddFiltro('NAO EXIBIR NOTA ESPECIAL E CUPOM ESPECIAL');
      2: AddFiltro('EXIBIR APENAS NOTA ESPECIAL E CUPOM ESPECIAL');
    End;

    AddFiltro('REFERENTE AO PERÍODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text);

    If (edtTipo.Text = 'A') Then
    Begin
      AddCampo('DESITE', 'CÓDIGO / DESCRIÇÃO DO PRODUTO');
      AddCampo('ENTSAI', 'ENTRADA / SAÍDA');
      AddCampo('QTDITE', 'QUANTIDADE');
      AddCampo('LITRAGEM', 'LITROS/KILOS');
      AddCampo('UNITAR', 'PRECO UNIT.');
      AddCampo('TOTITE', 'VR. TOTAL');
      AddQuebra('NUMDOC', 'DOCUMENTO - EMPRESA: ', False);
    End
    Else
    Begin
      AddCampo('NUMDOC', 'DOCUMENTO');
      AddCampo('CODEMP', 'EMPRESA');
      AddCampo('DTAENT', 'DATA EMISSAO');
      AddCampo('HORENT', 'HORA EMISSAO');
      AddCampo('NOMCLI', 'CODIGO  /  NOME DO CLIENTE');
      AddCampo('CONPAG', 'COND. PAGTO');
      AddCampo('VLRCON', 'VR. TOTAL');
    End;
    
    OnImpTitGrupo := pMontaTitGru;
    OnMontaResumo := pMontaResumo;
    OnSomaResumo  := pSomaTotais;

    If fGerarRelatorio Then
      pMensagemOk('Geração concluída com sucesso!');
  End;

  FreeAndNil(objGeraExcel);
  FreeAndNil(stlDocumento);
end;

end.

