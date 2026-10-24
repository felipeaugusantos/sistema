unit untRelPosContabil;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter,
  EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  QColorLabel, Menus, frxDesgn, frxClass, frxDBSet, frxDMPExport, Uni,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, untTypesSistema,
  AppEvnts, ComObj, ComCtrls, untFuncoesFactory,
  DB, untGeraExcel, untExcel, BitBtnLockedIncrem, untFuncoesGenerica,
  frxExportCSVTestabilidade, untIFuncoes, Math, untClassPanelCx, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  DirectoryEditFocus,Windows, 
  untFrameDirectoryEditFocus;

type
  TfrmRelPosContabil = class(TfrmPaiRelatorio)
    Label6: TLabel;
    mskDtaFin: TMaskEditFocus;
    lblDtaFin: TLabel;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    GroupBox1: TGroupBox;
    edtTipo: TEditFocus;
    ColorLabel2: TColorLabel;
    Label1: TLabel;
    edtCodAtividade: TEditFocus;
    edtDesAtividade: TEditFocus;
    GroupBox2: TGroupBox;
    ColorLabel3: TColorLabel;
    edtDescontadas: TEditFocus;
    svdExcel: TSaveDialog;
    chkGerTxt: TCheckBox;
    lblPatExp: TLabel;
    pgbGerTxt: TProgressBar;
    gpbOrdem: TGroupBox;
    lbl1: TColorLabel;
    lbl2: TColorLabel;
    edtOrdem: TEditFocus;
    Label4: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    Label16: TLabel;
    edtCodRede: TEditFocus;
    edtDesRede: TEditFocus;
    lblPortador: TLabel;
    edtCodPor: TEditFocus;
    edtDesPortador: TEditFocus;
    mskEspecie: TMaskEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    mskVenIni: TMaskEditFocus;
    Label5: TLabel;
    Label7: TLabel;
    mskVenFin: TMaskEditFocus;
    Label8: TLabel;
    ColorLabel4: TColorLabel;
    edtNomVen: TEditFocus;
    Label9: TLabel;
    edtCodVen: TEditFocus;
    fraPatExp: TfraDirectoryEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtividadeKeyPress(Sender: TObject; var Key: Char);
    procedure chkGerTxtClick(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedeExit(Sender: TObject);
    procedure edtCodRedeKeyPress(Sender: TObject; var Key: Char);
    procedure pGeraExcel(DataSet: TDataSet);
    procedure pSomaTotais(Var Totais: TTotais; Dados: TDataSet);
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure fraPatExpPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure fraPatExpedtDirectoryChange(Sender: TObject);
  private
    { Private declarations }
    strTipoRel  : String;
    strLinCli   : String;
    strAtividade: String;
    strVendedor : String;
    strPortador : String;
    arrVendedor : TConsultasArray;

    qryResumo: TUniQuery;

    qryRelatorio: TUniQuery;

    FPais: TPais;

    function fGetSqlAnalit: String;

    procedure pGeraResumo(strSelect: String);
    procedure pGeraTxt;
    procedure pHabilitaTxt(blnHabili: Boolean);
    function  fVerificaPermissaoDiretorio(const AName: string): Boolean;

    procedure pCriaQryRelatorio;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
    arrAtividade: TConsultasArray;
    arrClientes : TConsultasArray;
    arrRede     : TConsultasArray;
    arrPortador : TConsultasArray;
  end;

var
  frmRelPosContabil: TfrmRelPosContabil;

implementation

uses untQckPosContabil;

{$R *.dfm}
function TfrmRelPosContabil.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {*********************}
    {* VALIDA DATA FINAL *}
    {******************AF*}
    If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = mskVenIni) Then
    Begin

      mskVenFin.Enabled := Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text));

      If Not mskVenFin.Enabled Then
        mskVenFin.Clear;
    End

    Else If (Sender = mskVenFin) Then
    Begin

      If mskVenFin.Enabled And Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
      Begin

        If fEmptyStr(fTiraCaracEspeciais(mskVenFin.Text)) Then
        Begin
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If StrToDate(mskVenIni.Text) > StrToDate(mskVenFin.Text) Then
          Begin
            fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
            Result := False;
          End;
        End;

      End;

    End

    Else If (Sender = edtTipo) Then
    Begin
      If (fEmptyStr(edtTipo.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Tipo deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (Not (edtTipo.Text = 'A')) And (Not (edtTipo.Text = 'S')) Then
      Begin
        fMensagem('','O campo Tipo deve ser A ou S!',['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodEmpresa) Then
    Begin
      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodAtividade) Then
    Begin
      If fEmptyStr(edtCodAtividade.Text) Then
        edtDesAtividade.Text := 'TODAS'
      Else
        edtDesAtividade.Text := fRetNomAtividade(edtCodAtividade.Text);

      If edtCodAtividade.Text = '000' Then
      Begin
        edtDesAtividade.Text := '+1';
      End
      Else
      If fEmptyStr(edtDesAtividade.Text) Then
      Begin
        fMensagem('AVISO','Código da atividade não encontrado.', ['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtDescontadas) Then
    Begin
      If (fEmptyStr(edtDescontadas .Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Duplicatas descontadas" deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (Not (edtDescontadas.Text = 'S')) And
           (Not (edtDescontadas.Text = 'N')) And
             (Not (edtDescontadas.Text = 'T'))Then
      Begin
        fMensagem('','O campo Duplicatas descontadas deve ser S, N ou T!',['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtOrdem) Then
    Begin
      If fEmptyStr(edtOrdem.Text) Then
      Begin
        fMensagem('','O campo Ordem deve ser preenchido!',['&O k']);
        Result := False;
      End
      Else If Pos(edtOrdem.Text,'CND') <= 0 Then
      Begin
        fMensagem('', 'O campo Ordem deve ser C, D ou N!', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = fraPatExp) Then
    Begin
      If fEmptyStr(fraPatExp.edtDirectory.text) Then
        fraPatExp.edtDirectory.text := 'C:\';
    End

    Else If (Sender = edtCodVen) Then
    Begin
      If fEmptyStr(edtCodVen.Text) Then
        edtNomVen.Text := 'TODOS'
      Else
        edtNomVen.Text := fRetNomeOperador(edtCodVen.Text);

      If edtCodVen.Text = '000' Then
      Begin
        edtNomVen.Text := '+1';
      End
      Else
      If fEmptyStr(edtNomVen.Text) Then
      Begin
        fMensagem('','Código do vendedor não encontrado.', ['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtDestino Then
    Begin
      If fEmptyStr(edtDestino.Text) Then
      Begin
        fMensagem('', 'O Destino do Relatório deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If Pos(edtDestino.Text, 'V_I_E_') <= 0 Then
      Begin
        fMensagem('','O campo Destino deve ser V, I ou E!',['&O k']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelPosContabil.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;

  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  pHabilitaTxt(False);

  inherited;
end;

function TFrmRelPosContabil.fGetSqlAnalit: String;
  Var strSQL : String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  R.*, ';

  {*****************************************}
  {* CAMPOS UTILIZADOS NA GERAÇÃO DO EXCEL *}
  {**************************************RV*}
  If (edtOrdem.Text <> 'D') Then
    strSQL := strSQL + '  R.CTR_CODCLI AS CODCLI, '
  Else
    strSQL := strSQL + '  CONCAT(R.CTR_DTAVEN,R.CTR_CODCLI) AS DTAVEN, ';

  strSQL := strSQL + '  SUM(IF(CTR_DTAREC IS NULL, (CTR_VALDUP - IFNULL(CTR_DESSUJ,0) + IFNULL(CTR_JURSUJ,0) + IFNULL(CTR_DESCOB,0)), (CTR_VALREC - IFNULL(CTR_VALJUR,0) - IFNULL(CTR_VALCOB,0) + IFNULL(CTR_VALDES,0) ))) AS VALGER,';
  strSQL := strSQL + '  CONCAT(C.CLI_CODATI,"-",A.ATI_DESATI) AS CLI_ATIVID, ';
  strSQL := strSQL + '  C.CLI_NOMCLI, ';
  strSQL := strSQL + '  C.CLI_CODATI, ';
  strSQL := strSQL + '  C.CLI_CODRED, ';
  strSQL := strSQL + '  C.CLI_C_G_C_ ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADREC R ';
  strSQL := strSQL + '  JOIN CADCLI C ON CTR_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADPOR P ON CTR_CODPOR = POR_CODPOR ';
  strSQL := strSQL + '  LEFT JOIN CADATI A ON CLI_CODATI = ATI_CODATI ';

  strSQL := strSQL + 'WHERE ';

  {**************************************************}
  {* opção ver dupl. Descontadas/Ñ desc/Todos       *}
  {* opção (T)odos não inclui linha no SELECT       *}
  {******************************************** AM **}

  If edtDescontadas.Text = 'S' Then
    strSQL := strSQL + '  CTR_DESCON = ''S''' + ' AND '
  Else If edtDescontadas.Text = 'N' Then
    strSQL := strSQL + '  CTR_DESCON = ''N''' + ' AND ';

  strSQL := strSQL + fComplementoWhereSQLPosContabilReceber(edtCodEmpresa.Text);

  {**********************************************}
  {* NOVOS FILTROS CLIENTES , REDE DE LOJAS     *}
  {**01/03/2011 - 18:10 **********************DP*}
  strSql := strSQL + fStrLocate(edtCodCli,arrClientes,'CLI_CODCLI','CODCLI');

  If Not fEmptyStr(edtCodRede.Text) Then
      strSQL := strSQL + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');
  
  If Not fEmptyStr(edtCodAtividade.Text) Then
    strSQL := strSQL + fStrLocate(edtCodAtividade,  arrAtividade,  'C.CLI_CODATI', 'CODATI');

  If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
    strSQL := strSQL + ' AND CTR_DTAVEN BETWEEN :VENINI AND :VENFIN ';

  {******************************}
  {* INCLUIU FILTRO DE PORTADOR *}
  {***************************DP*}
  If Not fEmptyStr(edtDesPortador.Text) Then
    strSQL := strSQL + fStrLocate(edtCodPor,  arrPortador,  'CTR_CODPOR', 'CODPOR');

  {*****************************}
  {* INCLUIU FILTRO DE ESPECIE *}
  {**************************DP*}
  If (Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text))) Then
  Begin
    strSQL := strSQL + ' AND LOCATE(CTR_ESPDOC, :ESPDOC) > 0 ';
  End;

  {**********************}
  {* FILTRO DE VENDEDOR *}
  {*******************JU*}
  If Not fEmptyStr(edtNomVen.Text) Then
    strSQL := strSQL + fStrLocate(edtCodVen,  arrVendedor,  'CTR_CODVEN', 'CODVEN');

  strSQL := strSQL + ' GROUP BY ';
  strSQL := strSQL + '   CTR_NUMDUP, CTR_PARCEL, CTR_ESPDOC, CTR_CODCLI, CTR_CODEMP ';

  strSQL := 'SELECT SUM(T.VALGER) AS CTR_VALGER, T.* FROM (' + strSQL + ') AS T ';

  strSQL := strSQL + ' GROUP BY ';
  strSQL := strSQL + '   T.CTR_NUMDUP, T.CTR_PARCEL, T.CTR_ESPDOC, T.CTR_CODCLI, T.CTR_CODEMP ';
  strSQL := strSQL + ' ORDER BY ';

  If (edtOrdem.Text = 'C') Then
    strSQL := strSQL + '   T.CTR_CODCLI, T.CTR_DTAVEN, T.CTR_NUMDUP, T.CTR_PARCEL, T.CTR_CODEMP '

  Else If (edtOrdem.Text = 'N') Then
    strSQL := strSQL + '   CLI_NOMCLI, T.CTR_DTAVEN, T.CTR_NUMDUP, T.CTR_PARCEL, T.CTR_CODEMP '

  Else
    strSQL := strSQL + '   T.CTR_DTAVEN, T.CTR_CODCLI, T.CTR_NUMDUP, T.CTR_PARCEL, T.CTR_CODEMP ';

  Result := strSQL;
end;

procedure TfrmRelPosContabil.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
    strRes: String;

begin
  If (edtDestino.Text = 'E') Then
    blnImprime := fVerificaCampos
  Else
    inherited;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  If blnImprime Then
  Begin

    strTipoRel := edtTipo.Text;
    strRes     := fGetSqlAnalit;

    If (edtTipo.Text = 'A') Then //Analitico
    Begin
      strSQL := strRes;
    End
    Else //Sintético
    Begin

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  R.CTR_CODCLI, ';
      strSQL := strSQL + '  R.CTR_DTACAD, ';
      strSQL := strSQL + '  C.CLI_NOMCLI, ';
      strSQL := strSQL + '  C.CLI_C_G_C_, ';
      strSQL := strSQL + '  CONCAT(C.CLI_CODATI,"-",A.ATI_DESATI) AS CLI_ATIVID, ';
      strSQL := strSQL + '  R.CTR_CODEMP, ';
      strSQL := strSQL + '  SUM(IF(CTR_DTAREC IS NULL, (CTR_VALDUP - IFNULL(CTR_DESSUJ,0) + IFNULL(CTR_JURSUJ,0) + IFNULL(CTR_DESCOB,0)), (CTR_VALREC - IFNULL(CTR_VALJUR,0) - IFNULL(CTR_VALCOB,0) + IFNULL(CTR_VALDES,0) ))) AS CTR_VALGER ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADREC R ';
      strSQL := strSQL + '  JOIN CADCLI C ON CTR_CODCLI = CLI_CODCLI ';
      strSQL := strSQL + '  LEFT JOIN CADPOR P ON CTR_CODPOR = POR_CODPOR ';
      strSQL := strSQL + '  LEFT JOIN CADATI A ON CLI_CODATI = ATI_CODATI ';
      strSQL := strSQL + 'WHERE ';

      {**************************************************}
      {* opção ver dupl. Descontadas/Ñ desc/Todos       *}
      {* opção (T)odos não inclui linha no SELECT       *}
      {******************************************** AM **}

      If edtDescontadas.Text = 'S' Then
        strSQL := strSQL + '  CTR_DESCON = ''S'''+ ' AND '
      Else If edtDescontadas.Text = 'N' Then
        strSQL := strSQL + '  CTR_DESCON = ''N'''+ ' AND ';

      strSQL := strSQL + fComplementoWhereSQLPosContabilReceber(edtCodEmpresa.Text);

      {**********************************************}
      {* NOVOS FILTROS CLIENTES , REDE DE LOJAS     *}
      {**01/03/2011 - 17:52 **********************DP*}
      strSql := strSQL + fStrLocate(edtCodCli,arrClientes,'CLI_CODCLI','CODCLI');

      If Not fEmptyStr(edtCodRede.Text) Then
          strSQL := strSQL + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');

      If Not fEmptyStr(edtCodAtividade.Text) Then
        strSQL := strSQL + fStrLocate(edtCodAtividade,  arrAtividade,  'C.CLI_CODATI', 'CODATI');

      {******************************}
      {* INCLUIU FILTRO DE PORTADOR *}
      {***************************DP*}
      If Not fEmptyStr(edtDesPortador.Text) Then
        strSQL := strSQL + fStrLocate(edtCodPor,  arrPortador,  'CTR_CODPOR', 'CODPOR');

      {*****************************}
      {* INCLUIU FILTRO DE ESPECIE *}
      {**************************DP*}
      If (Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text))) Then
      Begin
        strSQL := strSQL + ' AND LOCATE(CTR_ESPDOC, :ESPDOC) > 0 ';
      End;

      If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
        strSQL := strSQL + ' AND CTR_DTAVEN BETWEEN :VENINI AND :VENFIN ';

      {**********************}
      {* FILTRO DE VENDEDOR *}
      {*******************JU*}
      If Not fEmptyStr(edtCodVen.Text) Then
        strSQL := strSQL + fStrLocate(edtCodVen, arrVendedor, 'CTR_CODVEN', 'CODVEN');

      strSQL := strSQL + ' GROUP BY ';
      strSQL := strSQL + '   R.CTR_CODCLI, C.CLI_NOMCLI, R.CTR_CODEMP ';

      strSQL := ' SELECT SQL_NO_CACHE CTR_CODCLI, CTR_DTACAD, CLI_NOMCLI, CLI_C_G_C_, CLI_ATIVID, ' +
                '        CTR_CODEMP, SUM(CTR_VALGER) AS CTR_VALGER FROM (' + strSQL + ') AS T ';

      strSQL := strSQL + ' GROUP BY ';
      strSQL := strSQL + '   CTR_CODCLI, CLI_NOMCLI, CTR_CODEMP ';
      strSQL := strSQL + ' ORDER BY ';

      If edtOrdem.Text = 'N' Then
        strSQL := strSQL + '   CLI_NOMCLI, CTR_CODCLI, CTR_CODEMP '
      Else
        strSQL := strSQL + '   CTR_CODCLI, CLI_NOMCLI, CTR_CODEMP '

    End;

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
      Begin
        ParamByName('VENINI').AsDate := StrToDate(mskVenIni.Text);
        ParamByName('VENFIN').AsDate := StrToDate(mskVenFin.Text);
      End;
      
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      {***********************************************}
      {* INCLUIDO FILTRO DE CLIENTES E REDE DE LOJAS *}
      {********************************************DP*}
      if Not fEmptyStr(edtCodCli.Text) Then
        pSetaParam(edtCodCli.Text,arrClientes,strLinCli,'CODCLI',qryRelatorio);

      If Not fEmptyStr(edtCodRede.Text) Then
        pSetaParamOR(edtCodRede,arrRede,'CODRED',qryRelatorio);

      If Not fEmptyStr(edtCodAtividade.Text) Then
        pSetaParam(edtCodAtividade.Text, arrAtividade, strAtividade, 'CODATI', qryRelatorio);

      If Not fEmptyStr(edtDesPortador.Text) Then
        pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryRelatorio);

      If (Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text))) Then
        ParamByName('ESPDOC').AsString := mskEspecie.Text;

      If Not fEmptyStr(edtNomVen.Text) Then
        pSetaParam(edtCodVen.Text, arrVendedor, strVendedor, 'CODVEN', qryRelatorio);

      Open;
    End;

    If (chkGerTxt.Checked) Then
    Begin
      pGeraTxt;
    End
    Else
    Begin
      If Not qryRelatorio.IsEmpty Then
      Begin
        Try
          pGeraResumo(strRes);

          pCriarFormularios(TfrmQckPosContabil, frmQckPosContabil);

          frmQckPosContabil.dtsRelatorio.DataSet := qryRelatorio;

          frmQckPosContabil.dtsResumo.DataSet := qryResumo;

          frmQckPosContabil.strTipoRel := strTipoRel;
          frmQckPosContabil.rllNomeRelatorio.Caption := 'RELATORIO DE POSICAO CONTABIL ( CONTAS A RECEBER )';

          If strTipImp = 'M' Then
            frmQckPosContabil.qckPagina.DefaultFilter := rldFiltro
          Else
            frmQckPosContabil.qckPagina.DefaultFilter := Nil;

          If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
            frmQckPosContabil.rllPerVen.Caption := 'PERIODO DE VENCIMENTO: ' + mskVenIni.Text + ' A ' + mskVenFin.Text
          Else
            frmQckPosContabil.rllPerVen.Caption := 'PERIODO DE VENCIMENTO: TODOS';

          frmQckPosContabil.strOrdem := 'DATA FINAL: ' + mskDtaFin.Text;
          frmQckPosContabil.rllEmpresa.Caption    := 'EMPRESA: '   + IfThen(fEmptyStr(edtCodEmpresa.Text),'TODAS',edtCodEmpresa.Text + '-' + edtDesEmpresa.Text);
          frmQckPosContabil.rllAtividade.Caption  := 'ATIVIDADE: ' + IfThen(fEmptyStr(edtCodAtividade.Text),'TODAS',edtCodAtividade.Text + '-' + edtDesAtividade.Text);
          frmQckPosContabil.rllClientes.Caption   := 'CLIENTES: ' + IfThen(fEmptyStr(edtCodCli.Text),'TODOS',edtCodCli.Text + '-' + edtNomCli.Text);
          frmQckPosContabil.rllRedeLoja.Caption   := 'REDE DE LOJAS: ' + IfThen(fEmptyStr(edtCodRede.Text),'TODAS',edtCodRede.Text + '-' + edtDesRede.Text);
          frmQckPosContabil.rllDuplicatas.Caption := 'DUPLICATAS DESCONTADAS: ' + IfThen(edtDescontadas.Text = 'S', 'SIM', IfThen(edtDescontadas.Text = 'N', 'NÃO', 'TODAS'));
          frmQckPosContabil.rllPortador.Caption   := 'PORTADOR: ' + IfThen(fEmptyStr(edtCodPor.Text),'TODOS',edtCodPor.Text + '-' + edtDesPortador.Text);
          frmQckPosContabil.rllEspecie.Caption    := 'ESPECIE: ' + IfThen(fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)),'TODAS',mskEspecie.Text);
          frmQckPosContabil.rllVendedor.Caption   := 'VENDEDOR: ' + IfThen(fEmptyStr(edtCodVen.Text),'TODOS',edtCodVen.Text + '-' + edtNomVen.Text);

          frmQckPosContabil.rllEmpresa1.Caption    := 'EMPRESA: '   + IfThen(fEmptyStr(edtCodEmpresa.Text),'TODAS',edtCodEmpresa.Text + '-' + edtDesEmpresa.Text);
          frmQckPosContabil.rllAtividade1.Caption  := 'ATIVIDADE: ' + IfThen(fEmptyStr(edtCodAtividade.Text),'TODAS',edtCodAtividade.Text + '-' + edtDesAtividade.Text);
          frmQckPosContabil.rllClientes1.Caption   := 'CLIENTES: ' + IfThen(fEmptyStr(edtCodCli.Text),'TODOS',edtCodCli.Text + '-' + edtNomCli.Text);
          frmQckPosContabil.rllRedeLoja1.Caption   := 'REDE DE LOJAS: ' + IfThen(fEmptyStr(edtCodRede.Text),'TODAS',edtCodRede.Text + '-' + edtDesRede.Text);
          frmQckPosContabil.rllDuplicatas1.Caption := 'DUPLICATAS DESCONTADAS: ' + IfThen(edtDescontadas.Text = 'S', 'SIM', IfThen(edtDescontadas.Text = 'N', 'NÃO', 'TODAS'));
          frmQckPosContabil.rllPortador1.Caption   := 'PORTADOR: ' + IfThen(fEmptyStr(edtCodPor.Text),'TODOS',edtCodPor.Text + '-' + edtDesPortador.Text);
          frmQckPosContabil.rllEspecie1.Caption    := 'ESPECIE: ' + IfThen(fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)),'TODAS',mskEspecie.Text);
          frmQckPosContabil.rllVendedor1.Caption   := 'VENDEDOR: ' + IfThen(fEmptyStr(edtCodVen.Text),'TODOS',edtCodVen.Text + '-' + edtNomVen.Text);

          If (edtOrdem.Text <> 'D') Then
            frmQckPosContabil.RLLabel4.Caption := 'Total do Cliente:'
          Else
            frmQckPosContabil.RLLabel4.Caption := 'Total Parcial do Cliente:';

          If edtDestino.Text = 'V' Then
            frmQckPosContabil.qckPagina.PreviewModal
          Else If edtDestino.Text = 'I' Then
            frmQckPosContabil.qckPagina.Print
          Else If edtDestino.Text = 'E' Then
            pGeraExcel(qryRelatorio);

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
          End;
        End;
        pFreeAndNil(frmQckPosContabil);
      End
      Else
      Begin
        pTabelaVazia;
      End;
    End;
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption     := '';
end;

procedure TfrmRelPosContabil.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaFin);
end;

procedure TfrmRelPosContabil.FormCreate(Sender: TObject);
begin
  inherited;
  FPais := fSetaPais;
  qryResumo := fCriaQuery;
end;

procedure TfrmRelPosContabil.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryResumo);
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelPosContabil.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodEmpresa.Text) Then
    edtDesEmpresa.Text := 'TODAS'
  Else
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

  If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtCodEmpresa.Text))  Then
  Begin
    fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
    edtCodEmpresa.Clear;
    pSetFocus(edtCodEmpresa);
  End;
end;

procedure TfrmRelPosContabil.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelPosContabil.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If Not edtCodPor.ReadOnly Then
    pEdtCodSelectExit(edtCodPor, edtDesPortador, arrPortador, Nil, fRetNomPortador, 'do portador');
end;

procedure TfrmRelPosContabil.edtCodPorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqPortador(conSimples, Self, edtCodPor, edtDesPortador, nil, Key, arrPortador, False) Then
  Begin
    fValidaCampos(edtCodPor,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelPosContabil.edtCodRedeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede');
end;

procedure TfrmRelPosContabil.edtCodRedeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {**********************************}
  {* NOVA CONSULTA DE REDE DE LOJAS *}
  {*******************************RV*}
  If fPesqRedeLojas(Self, edtCodRede, edtDesRede, Nil, Key, arrRede, False) Then
  Begin
    If fValidaCampos(edtCodRede, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelPosContabil.edtCodVenKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqOperador(Self, edtCodVen, edtNomVen, nil, Key, arrVendedor, False) Then
    Begin
      fValidaCampos(edtCodVen, False);
      Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmRelPosContabil.fraPatExpPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
  Var
  openOD : TFileOpenDialog;
begin
  inherited;

  openOD  := TFileOpenDialog.Create(Self);
  openOD.Options:= [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem];
  openOD.OkButtonLabel := 'Selecionar';
  If openOD.Execute Then
    fraPatExp.edtDirectory.text := openOD.FileName;

end;

procedure TfrmRelPosContabil.edtCodAtividadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, edtCodAtividade, edtDesAtividade, Nil, Key, arrAtividade, False) Then
	Begin
		fValidaCampos(edtCodAtividade, False);
		Self.SelectNext(ActiveControl, True, True);
	End;

end;

procedure TfrmRelPosContabil.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli,edtNomCli,arrClientes,nil,fRetNomCliente,'do Cliente');

  If Not fEmptyStr(edtCodCli.Text) Then
  Begin
    edtCodRede.Enabled := False;
    edtCodRede.Clear;
    pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede');
    pSetFocus(edtCodAtividade);
  End Else
  Begin
    edtCodRede.Enabled := True;
    pSetFocus(edtCodRede);
  End;

end;

procedure TfrmRelPosContabil.edtCodCliKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes, False) Then
  Begin                                                            
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelPosContabil.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;

end;

procedure TfrmRelPosContabil.pGeraExcel(DataSet: TDataSet);
  Var
    objGeraExcel: TGeraExcel;
begin

  objGeraExcel := TGeraExcel.Create(DataSet, pgbGerTxt);

  objGeraExcel.strNomRel := 'RELATORIO DE POSIÇÃO CONTÁBIL ( CONTAS A RECEBER ) - ' +
                            IfThen(edtTipo.Text = 'A', 'ANALITICO ', 'SINTETICO ');

  objGeraExcel.AddFiltro('DATA FINAL: ' + FormatDateTime('dd/MM/yyyy', StrToDate(mskDtaFin.Text)));
  objGeraExcel.AddFiltro('EMPRESA: ' + IfThen(fEmptyStr(edtCodEmpresa.Text),'TODAS',edtCodEmpresa.Text + '-' + edtDesEmpresa.Text));
  objGeraExcel.AddFiltro('ATIVIDADE: ' + IfThen(fEmptyStr(edtCodAtividade.Text),'TODAS',edtCodAtividade.Text + '-' + edtDesAtividade.Text));
  objGeraExcel.AddFiltro('CLIENTE: ' + IfThen(fEmptyStr(edtCodCli.Text),'TODOS',edtCodCli.Text + '-' + edtNomCli.Text));
  objGeraExcel.AddFiltro('DUPLICATAS DESCONTADAS: ' + IfThen(edtDescontadas.Text = 'S', 'SIM', IfThen(edtDescontadas.Text = 'N', 'NÃO', 'TODAS')));
  objGeraExcel.AddFiltro('VENDEDOR: ' + IfThen(fEmptyStr(edtCodVen.Text),'TODOS',edtCodVen.Text + '-' + edtNomVen.Text));

  objGeraExcel.AddCampo('CTR_CODCLI', 'CODIGO');
  objGeraExcel.AddCampo('CLI_NOMCLI', 'NOME DO CLIENTE');
  objGeraExcel.AddCampo('CLI_ATIVID', 'ATIVIDADE');
  objGeraExcel.AddCampo('CLI_C_G_C_', 'CNPJ/CPF');

  If edtTipo.Text = 'A' Then
  Begin
    objGeraExcel.AddCampo('CTR_DESCON', 'DESC.');
    objGeraExcel.AddCampo('CTR_NUMDUP', 'DUPLICATA');
    objGeraExcel.AddCampo('CTR_CODEMP', 'LOJA');
    objGeraExcel.AddCampo('CTR_DTACAD', 'CADASTRO');
    objGeraExcel.AddCampo('CTR_DTAVEN', 'VENCIMENTO');
    objGeraExcel.AddCampo('CTR_VALGER', 'VALOR');
  End
  Else
    objGeraExcel.AddCampo('CTR_VALGER', 'VALOR');

  If (edtTipo.Text = 'A') Then
  Begin
    If (edtOrdem.Text <> 'D') Then
      objGeraExcel.AddQuebra('CODCLI', '', False)
    Else
      objGeraExcel.AddQuebra('DTAVEN', '', False);
  End;

  objGeraExcel.AddTotais('CTR_VALGER');

  objGeraExcel.OnMontaResumo := pMontaResumo;
  objGeraExcel.OnSomaResumo  := pSomaTotais;

  If objGeraExcel.fGerarRelatorio Then
    fMensagem('','Arquivo gerado com sucesso!', ['&OK']);

  FreeAndNil(objGeraExcel);
end;

procedure TfrmRelPosContabil.chkGerTxtClick(Sender: TObject);
begin
  inherited;
  If (chkGerTxt.Checked) Then
  Begin
    pHabilitaTxt(True);
  End
  Else
  Begin
    pHabilitaTxt(False);
  End;
end;

procedure TfrmRelPosContabil.pGeraTxt;
Var
  txtTexto : TextFile;
  strNomArq: String;
  strCliAtu: String;
  strTransacao: String;

  fltTotCli: Double;
  fltTotGer: Double;
  blnPerm  : Boolean;

  procedure pGravaLinha(strTransacao: String);
  Begin
    Writeln(txtTexto,strTransacao);
  End;

  procedure pGravaTraco;
  Var
    intContador: Integer;
    intTamMax  : Integer;
    strGraTra  : String;
  Begin

   intTamMax := IfThen(edtTipo.Text = 'A', 172, 114);

    For intContador := 0 To intTamMax Do
    Begin
      strGraTra := strGraTra + '-';
    End;

    Writeln(txtTexto,strGraTra);
  End;
begin
  If (Not qryRelatorio.IsEmpty) Then
  Begin

    strNomArq := 'POSCTB.TXT';

    blnPerm := fVerificaPermissaoDiretorio(fraPatExp.edtDirectory.text);
    If Not blnPerm Then
    Begin
      fMensagem('','Sem permissão de gravação no diretório selecionado!',['&O k']);
      Exit;
    End;

    AssignFile(txtTexto, fraPatExp.edtDirectory.text + '\' +  strNomArq);
    Rewrite(txtTexto);

    With qryRelatorio Do
    Begin
      pgbGerTxt.Min := 0;
      pgbGerTxt.Max := RecordCount;
      DisableControls;

      strTransacao := '';
      fltTotCli    := 0;
      fltTotGer    := 0;

      {****************************}
      {* ESCREVE CABEÇALHO NO TXT *}
      {*************************PZ*}
      strTransacao := fPadC(fRetNomeEmpresa                                  , IfThen(edtTipo.Text = 'A', 172, 114));
      pGravaLinha(strTransacao);
      strTransacao := fPadC('RELATORIO DE POSICAO CONTABIL(CONTAS A RECEBER) - ' +
                            IfThen(edtTipo.Text = 'A', 'ANALÍTICO','SINTÉTICO') , IfThen(edtTipo.Text = 'A', 172, 114));
      pGravaLinha(strTransacao);
      strTransacao := fPadC('DATA FINAL: ' + mskDtaFin.Text                  , IfThen(edtTipo.Text = 'A', 172, 114));
      pGravaLinha(strTransacao);
      pGravaTraco;

      {***************************************}
      {* ESCREVE O TITULO DAS COLUNAS NO TXT *}
      {************************************PZ*}
      If (edtTipo.Text = 'A') Then
      Begin
        strTransacao := fPadR  ('CODIGO - NOME DO CLIENTE', 70) +
                        fPadR  ('CNPJ/CPF'                , 30) +
                        fPadC  ('DESC'                    , 08) +
                        fPadR  ('DUPLIC.'                 , 20) +
                        fPadR  ('LOJ.'                    , 15) +
                        fPadR  ('DTA.VENC.'               , 15) +
                        fPadL  ('VALOR'                   , 15);



        pGravaLinha(strTransacao);
      End
      Else If (edtTipo.Text = 'S') Then
      Begin
        strTransacao := fPadR  ('CODIGO - NOME DO CLIENTE', 70) +
                        fPadR  ('CNPJ/CPF'                , 30) +
                        fPadL  ('VALOR'                   , 15);

        pGravaLinha(strTransacao);
      End;

      pGravaTraco;

      While Not Eof Do
      Begin
        Application.ProcessMessages;

        {********************}
        {* SE FOR ANALÍTICO *}
        {*****************PZ*}
        If (edtTipo.Text = 'A') Then
        Begin
          strTransacao := fPadR  (FieldByName('CTR_CODCLI').AsString +
                                  '-' + FieldByName('CLI_NOMCLI').AsString                          , 70) + //CODIGO-NOME CLIENTE
                          fPadR  (fFormataCpfCgc(FieldByName('CLI_C_G_C_').AsString, FPais)         , 30) + //CNPJ/CPF
                          fPadC  (FieldByName('CTR_DESCON').AsString                                , 08) + //DESC.
                          fPadR  (FieldByName('CTR_NUMDUP').AsString +
                                  FieldByName('CTR_PARCEL').AsString +
                                  '-'                                +
                                  FieldByname('CTR_ESPDOC').AsString                                , 20) + //DUPLIC
                          fPadR  (FieldByName('CTR_CODEMP').AsString                                , 15) + //LOJ
                          fPadR  (FormatDateTime('DD/MM/YYYY', FieldByName('CTR_DTAVEN').AsDateTime), 15) + // DTA.VENC
                          fPadL  (FormatFloat('#,##0.00', FieldByName('CTR_VALGER').AsFloat)        , 15);  //VALOR
        End
        {********************}
        {* SE FOR SINTÉTICO *}
        {*****************PZ*}
        Else If (edtTipo.Text = 'S') Then
        Begin
          strTransacao := fPadR  (FieldByName('CTR_CODCLI').AsString +
                                  '-' + FieldByName('CLI_NOMCLI').AsString                     , 70) + //CODIGO-NOME CLIENTE
                          fPadR  (fFormataCpfCgc(FieldByName('CLI_C_G_C_').AsString, FPais)    , 30) + //CNPJ/CPF                                                          , 20) +
                          fPadL  (FormatFloat('#,##0.00', FieldByName('CTR_VALGER').AsFloat)   , 15);  //VALOR
        End;

        {******************************}
        {* ESCREVE A TRANSACAO NO TXT *}
        {***************************PZ*}
        pGravaLinha(strTransacao);

        {*****************************************}
        {* PEGA O CODIGO DO CLIENTE E VALOR ATUA *}
        {**************************************PZ*}
        strCliAtu := FieldByName('CTR_CODCLI').AsString;

        {************************************}
        {* TOTALIZA O VALOR PARCIAL E GERAL *}
        {*********************************PZ*}
        fltTotCli := fltTotCli + FieldByName('CTR_VALGER').AsFloat;
        fltTotGer := fltTotGer + FieldByName('CTR_VALGER').AsFloat;

        Next;

        {*****************************************************************}
        {* CONTROLA A GRAVAÇÃO TOTAL PARCIAL DO CLIENTE SE FOR ANALÍTICO *}
        {**************************************************************PZ*}
        If (strCliAtu <> FieldByName('CTR_CODCLI').AsString) And (edtTipo.Text = 'A') Then
        Begin

          strTransacao :=  fPadL  ('Total Parcial do Cliente: '         , 162) + // TOTAL PARCIAL DO CLIENTE
                           fPadL  (FormatFloat('#,##0.00', fltTotCli)   , 15);   // TOTAL PARCIAL DO CLIENTE

          {*********************************************}
          {* ESCREVE O TOTAL PARCIAL DO CLIENTE NO TXT *}
          {******************************************PZ*}
          pGravaLinha(strTransacao);
          pGravaTraco;

          fltTotCli := 0;
        End;

        pgbGerTxt.Position := RecNo;
      End;

      {*************************************}
      {* ESCREVE O TOTAL PARCIAL DO ULTIMO *}
      {* CLIENTE NO TXT, SE FOR ANALÍTICO  *}
      {**********************************PZ*}
      If (edtTipo.Text = 'A') Then
      Begin
        strTransacao :=  fPadL  ('Total Parcial do Cliente: '         , 162) + // TOTAL PARCIAL DO CLIENTE
                         fPadL  (FormatFloat('#,##0.00', fltTotCli)   , 15);   // TOTAL PARCIAL DO CLIENTE

        pGravaLinha(strTransacao);
        pGravaTraco;
      End;

      strTransacao :=  fPadL  ('Total Geral: '                      , IfThen(edtTipo.Text = 'A', 162, 104)) + // TOTAL GERAL
                       fPadL  (FormatFloat('#,##0.00', fltTotGer)   , 17);                                 // TOTAL GERAL

      {********************************}
      {* ESCREVE O TOTAL GERAL NO TXT *}
      {*****************************PZ*}
      pGravaLinha(strTransacao);

      EnableControls;
    End;
    CloseFile(txtTexto);
    fMensagem('','O arquivo ' + strNomArq + ' foi gerado com Sucesso em: ' + fraPatExp.edtDirectory.text, ['&O k']);
    pgbGerTxt.Position := 0;
  End
  Else
    fMensagem('ATENÇÃO!','Não existe dados para geração do TXT.',['&O k']);
end;

procedure TfrmRelPosContabil.pHabilitaTxt(blnHabili: Boolean);
begin
  lblPatExp.Enabled := blnHabili;
  fraPatExp.Enabled := blnHabili;
end;

procedure TfrmRelPosContabil.pMontaResumo(Excel: TExcel; Campos: TCampos;
  Quebra: TRecQuebras);
  Var
    strTotal: String;
begin
  With Excel Do
  Begin
    If (Quebra.NomeCampo = 'CODCLI') Then
      strTotal := 'TOTAL CLIENTE:'
    Else If (Quebra.NomeCampo = 'DTAVEN') Then
      strTotal := ' TOTAL PARCIAL DO CLIENTE:'
    Else
      strTotal := '  TOTAL GERAL:';
    If (strTotal <> '') Then
    Begin
      ProximaLinha;

      strTotal := strTotal + fPadL(FormatFloat('##,#0.00', Quebra.Totais['CTR_VALGER']), 14);

      Escrever(LinhaAtual, 01, strTotal);
      Mesclar('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));

      Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
      CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
      CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
      Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
      Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);
    End;
  End;
end;

procedure TfrmRelPosContabil.pSomaTotais(var Totais: TTotais; Dados: TDataSet);
begin
  Totais['CTR_VALGER'] := Totais['CTR_VALGER'] + Dados.FieldByName('CTR_VALGER').AsFloat
end;

procedure TfrmRelPosContabil.pGeraResumo(strSelect: String);
  Var
    strSQL: String;
begin

  Try
    strSQL := '';

    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  "VENCIDOS" AS GRUPO, ';
    strSQL := strSQL + '  CONCAT("ULTIMOS 30 DIAS (",DATE_FORMAT(ADDDATE(:DTAFIN,-30),"%d/%m/%Y")," A ",DATE_FORMAT(:DTAFIN,"%d/%m/%Y"),")") AS TITULO, ';
    strSQL := strSQL + '  IFNULL(SUM(CTR_VALGER),0) AS VTOTAL ';
    strSQL := strSQL + 'FROM ( ' + strSelect + ' ) AS AUX     ';
    strSQL := strSQL + 'WHERE CTR_DTAVEN BETWEEN ADDDATE(:DTAFIN, -30) AND :DTAFIN ';

    {**********************************}
    {* NÃO TINHA OS FILTROS NO RESUMO *}
    {*******************************JU*}
    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + '  AND LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    strSQL := strSQL + fStrLocate(edtCodCli,arrClientes,'CTR_CODCLI','CODCLI');

    If Not fEmptyStr(edtCodRede.Text) Then
        strSQL := strSQL + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');

    If Not fEmptyStr(edtCodAtividade.Text) Then
      strSQL := strSQL + fStrLocate(edtCodAtividade,  arrAtividade,  'CLI_CODATI', 'CODATI');

    If Not fEmptyStr(edtDesPortador.Text) Then
      strSQL := strSQL + fStrLocate(edtCodPor,  arrPortador,  'CTR_CODPOR', 'CODPOR');

    If (Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text))) Then
    Begin
      strSQL := strSQL + ' AND LOCATE(CTR_ESPDOC, :ESPDOC) > 0 ';
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
      strSQL := strSQL + ' AND CTR_DTAVEN BETWEEN :VENINI AND :VENFIN ';

    If Not fEmptyStr(edtCodVen.Text) Then
      strSQL := strSQL + fStrLocate(edtCodVen, arrVendedor, 'CTR_CODVEN', 'CODVEN');

    strSQL := strSQL + ' UNION ALL ';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  "VENCIDOS" AS GRUPO, ';
    strSQL := strSQL + '  CONCAT("ENTRE 31 E 180 DIAS (",DATE_FORMAT(ADDDATE(:DTAFIN,-180),"%d/%m/%Y")," A ",DATE_FORMAT(ADDDATE(:DTAFIN,-31),"%d/%m/%Y"),")") AS TITULO, ';
    strSQL := strSQL + '  IFNULL(SUM(CTR_VALGER),0) AS VTOTAL ';
    strSQL := strSQL + 'FROM ( ' + strSelect + ' ) AS AUX     ';
    strSQL := strSQL + 'WHERE CTR_DTAVEN BETWEEN ADDDATE(:DTAFIN, -180) AND ADDDATE(:DTAFIN, -31) ';

    {**********************************}
    {* NÃO TINHA OS FILTROS NO RESUMO *}
    {*******************************JU*}
    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + '  AND LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    strSQL := strSQL + fStrLocate(edtCodCli,arrClientes,'CTR_CODCLI','CODCLI');

    If Not fEmptyStr(edtCodRede.Text) Then
        strSQL := strSQL + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');

    If Not fEmptyStr(edtCodAtividade.Text) Then
      strSQL := strSQL + fStrLocate(edtCodAtividade,  arrAtividade,  'CLI_CODATI', 'CODATI');

    If Not fEmptyStr(edtDesPortador.Text) Then
      strSQL := strSQL + fStrLocate(edtCodPor,  arrPortador,  'CTR_CODPOR', 'CODPOR');

    If (Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text))) Then
    Begin
      strSQL := strSQL + ' AND LOCATE(CTR_ESPDOC, :ESPDOC) > 0 ';
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
      strSQL := strSQL + ' AND CTR_DTAVEN BETWEEN :VENINI AND :VENFIN ';

    If Not fEmptyStr(edtCodVen.Text) Then
      strSQL := strSQL + fStrLocate(edtCodVen, arrVendedor, 'CTR_CODVEN', 'CODVEN');

    strSQL := strSQL + ' UNION ALL ';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  "VENCIDOS" AS GRUPO, ';
    strSQL := strSQL + '  CONCAT("ENTRE 181 E 360 DIAS (",DATE_FORMAT(ADDDATE(:DTAFIN,-360),"%d/%m/%Y")," A ",DATE_FORMAT(ADDDATE(:DTAFIN,-181),"%d/%m/%Y"),")") AS TITULO, ';
    strSQL := strSQL + '  IFNULL(SUM(CTR_VALGER),0) AS VTOTAL ';
    strSQL := strSQL + 'FROM ( ' + strSelect + ' ) AS AUX     ';
    strSQL := strSQL + 'WHERE CTR_DTAVEN BETWEEN ADDDATE(:DTAFIN, -360) AND ADDDATE(:DTAFIN, -181) ';

    {**********************************}
    {* NÃO TINHA OS FILTROS NO RESUMO *}
    {*******************************JU*}
    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + '  AND LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    strSQL := strSQL + fStrLocate(edtCodCli,arrClientes,'CTR_CODCLI','CODCLI');

    If Not fEmptyStr(edtCodRede.Text) Then
        strSQL := strSQL + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');

    If Not fEmptyStr(edtCodAtividade.Text) Then
      strSQL := strSQL + fStrLocate(edtCodAtividade,  arrAtividade,  'CLI_CODATI', 'CODATI');

    If Not fEmptyStr(edtDesPortador.Text) Then
      strSQL := strSQL + fStrLocate(edtCodPor,  arrPortador,  'CTR_CODPOR', 'CODPOR');

    If (Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text))) Then
    Begin
      strSQL := strSQL + ' AND LOCATE(CTR_ESPDOC, :ESPDOC) > 0 ';
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
      strSQL := strSQL + ' AND CTR_DTAVEN BETWEEN :VENINI AND :VENFIN ';

    If Not fEmptyStr(edtCodVen.Text) Then
      strSQL := strSQL + fStrLocate(edtCodVen, arrVendedor, 'CTR_CODVEN', 'CODVEN');

    strSQL := strSQL + ' UNION ALL ';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  "VENCIDOS" AS GRUPO, ';
    strSQL := strSQL + '  CONCAT("A 361 DIAS OU MAIS (MAIOR QUE ",DATE_FORMAT(ADDDATE(:DTAFIN,-361),"%d/%m/%Y"),")") AS TITULO, ';
    strSQL := strSQL + '  IFNULL(SUM(CTR_VALGER),0) AS VTOTAL ';
    strSQL := strSQL + 'FROM ( ' + strSelect + ' ) AS AUX     ';
    strSQL := strSQL + 'WHERE CTR_DTAVEN <= ADDDATE(:DTAFIN, -361) ';

    {**********************************}
    {* NÃO TINHA OS FILTROS NO RESUMO *}
    {*******************************JU*}
    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + '  AND LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    strSQL := strSQL + fStrLocate(edtCodCli,arrClientes,'CTR_CODCLI','CODCLI');

    If Not fEmptyStr(edtCodRede.Text) Then
        strSQL := strSQL + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');

    If Not fEmptyStr(edtCodAtividade.Text) Then
      strSQL := strSQL + fStrLocate(edtCodAtividade,  arrAtividade,  'CLI_CODATI', 'CODATI');

    If Not fEmptyStr(edtDesPortador.Text) Then
      strSQL := strSQL + fStrLocate(edtCodPor,  arrPortador,  'CTR_CODPOR', 'CODPOR');

    If (Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text))) Then
    Begin
      strSQL := strSQL + ' AND LOCATE(CTR_ESPDOC, :ESPDOC) > 0 ';
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
      strSQL := strSQL + ' AND CTR_DTAVEN BETWEEN :VENINI AND :VENFIN ';

    If Not fEmptyStr(edtCodVen.Text) Then
      strSQL := strSQL + fStrLocate(edtCodVen, arrVendedor, 'CTR_CODVEN', 'CODVEN');

    strSQL := strSQL + ' UNION ALL ';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  "A VENCER" AS GRUPO, ';
    strSQL := strSQL + '  CONCAT("PROXIMOS 30 DIAS (",DATE_FORMAT(ADDDATE(:DTAFIN,1),"%d/%m/%Y")," A ",DATE_FORMAT(ADDDATE(:DTAFIN,30),"%d/%m/%Y"),")") AS TITULO, ';
    strSQL := strSQL + '  IFNULL(SUM(CTR_VALGER),0) AS VTOTAL ';
    strSQL := strSQL + 'FROM ( ' + strSelect + ' ) AS AUX     ';
    strSQL := strSQL + 'WHERE CTR_DTAVEN BETWEEN ADDDATE(:DTAFIN, 1) AND ADDDATE(:DTAFIN, 30) ';

    {**********************************}
    {* NÃO TINHA OS FILTROS NO RESUMO *}
    {*******************************JU*}
    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + '  AND LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    strSQL := strSQL + fStrLocate(edtCodCli,arrClientes,'CTR_CODCLI','CODCLI');

    If Not fEmptyStr(edtCodRede.Text) Then
        strSQL := strSQL + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');

    If Not fEmptyStr(edtCodAtividade.Text) Then
      strSQL := strSQL + fStrLocate(edtCodAtividade,  arrAtividade,  'CLI_CODATI', 'CODATI');

    If Not fEmptyStr(edtDesPortador.Text) Then
      strSQL := strSQL + fStrLocate(edtCodPor,  arrPortador,  'CTR_CODPOR', 'CODPOR');

    If (Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text))) Then
    Begin
      strSQL := strSQL + ' AND LOCATE(CTR_ESPDOC, :ESPDOC) > 0 ';
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
      strSQL := strSQL + ' AND CTR_DTAVEN BETWEEN :VENINI AND :VENFIN ';

    If Not fEmptyStr(edtCodVen.Text) Then
      strSQL := strSQL + fStrLocate(edtCodVen, arrVendedor, 'CTR_CODVEN', 'CODVEN');

    strSQL := strSQL + ' UNION ALL ';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  "A VENCER" AS GRUPO, ';
    strSQL := strSQL + '  CONCAT("ENTRE 31 E 180 DIAS (",DATE_FORMAT(ADDDATE(:DTAFIN,31),"%d/%m/%Y")," A ",DATE_FORMAT(ADDDATE(:DTAFIN,180),"%d/%m/%Y"),")") AS TITULO, ';
    strSQL := strSQL + '  IFNULL(SUM(CTR_VALGER),0) AS VTOTAL ';
    strSQL := strSQL + 'FROM ( ' + strSelect + ' ) AS AUX     ';
    strSQL := strSQL + 'WHERE CTR_DTAVEN BETWEEN ADDDATE(:DTAFIN, 31) AND ADDDATE(:DTAFIN, 180) ';

    {**********************************}
    {* NÃO TINHA OS FILTROS NO RESUMO *}
    {*******************************JU*}
    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + '  AND LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    strSQL := strSQL + fStrLocate(edtCodCli,arrClientes,'CTR_CODCLI','CODCLI');

    If Not fEmptyStr(edtCodRede.Text) Then
        strSQL := strSQL + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');

    If Not fEmptyStr(edtCodAtividade.Text) Then
      strSQL := strSQL + fStrLocate(edtCodAtividade,  arrAtividade,  'CLI_CODATI', 'CODATI');

    If Not fEmptyStr(edtDesPortador.Text) Then
      strSQL := strSQL + fStrLocate(edtCodPor,  arrPortador,  'CTR_CODPOR', 'CODPOR');

    If (Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text))) Then
    Begin
      strSQL := strSQL + ' AND LOCATE(CTR_ESPDOC, :ESPDOC) > 0 ';
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
      strSQL := strSQL + ' AND CTR_DTAVEN BETWEEN :VENINI AND :VENFIN ';

    If Not fEmptyStr(edtCodVen.Text) Then
      strSQL := strSQL + fStrLocate(edtCodVen, arrVendedor, 'CTR_CODVEN', 'CODVEN');

    strSQL := strSQL + ' UNION ALL ';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  "A VENCER" AS GRUPO, ';
    strSQL := strSQL + '  CONCAT("ENTRE 181 E 360 DIAS (",DATE_FORMAT(ADDDATE(:DTAFIN,181),"%d/%m/%Y")," A ",DATE_FORMAT(ADDDATE(:DTAFIN,360),"%d/%m/%Y"),")") AS TITULO, ';
    strSQL := strSQL + '  IFNULL(SUM(CTR_VALGER),0) AS VTOTAL ';
    strSQL := strSQL + 'FROM ( ' + strSelect + ' ) AS AUX     ';
    strSQL := strSQL + 'WHERE CTR_DTAVEN BETWEEN ADDDATE(:DTAFIN, 181) AND ADDDATE(:DTAFIN, 360) ';

    {**********************************}
    {* NÃO TINHA OS FILTROS NO RESUMO *}
    {*******************************JU*}
    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + '  AND LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    strSQL := strSQL + fStrLocate(edtCodCli,arrClientes,'CTR_CODCLI','CODCLI');

    If Not fEmptyStr(edtCodRede.Text) Then
        strSQL := strSQL + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');

    If Not fEmptyStr(edtCodAtividade.Text) Then
      strSQL := strSQL + fStrLocate(edtCodAtividade,  arrAtividade,  'CLI_CODATI', 'CODATI');

    If Not fEmptyStr(edtDesPortador.Text) Then
      strSQL := strSQL + fStrLocate(edtCodPor,  arrPortador,  'CTR_CODPOR', 'CODPOR');

    If (Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text))) Then
    Begin
      strSQL := strSQL + ' AND LOCATE(CTR_ESPDOC, :ESPDOC) > 0 ';
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
      strSQL := strSQL + ' AND CTR_DTAVEN BETWEEN :VENINI AND :VENFIN ';

    If Not fEmptyStr(edtCodVen.Text) Then
      strSQL := strSQL + fStrLocate(edtCodVen, arrVendedor, 'CTR_CODVEN', 'CODVEN');

    strSQL := strSQL + ' UNION ALL ';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  "A VENCER" AS GRUPO, ';
    strSQL := strSQL + '  CONCAT("EM 361 DIAS OU MAIS (MAIOR QUE ",DATE_FORMAT(ADDDATE(:DTAFIN,361),"%d/%m/%Y"),")") AS TITULO, ';
    strSQL := strSQL + '  IFNULL(SUM(CTR_VALGER),0) AS VTOTAL ';
    strSQL := strSQL + 'FROM ( ' + strSelect + ' ) AS AUX     ';
    strSQL := strSQL + 'WHERE CTR_DTAVEN >= ADDDATE(:DTAFIN, 361) ';

    {**********************************}
    {* NÃO TINHA OS FILTROS NO RESUMO *}
    {*******************************JU*}
    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + '  AND LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    strSQL := strSQL + fStrLocate(edtCodCli,arrClientes,'CTR_CODCLI','CODCLI');

    If Not fEmptyStr(edtCodRede.Text) Then
        strSQL := strSQL + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');

    If Not fEmptyStr(edtCodAtividade.Text) Then
      strSQL := strSQL + fStrLocate(edtCodAtividade,  arrAtividade,  'CLI_CODATI', 'CODATI');

    If Not fEmptyStr(edtDesPortador.Text) Then
      strSQL := strSQL + fStrLocate(edtCodPor,  arrPortador,  'CTR_CODPOR', 'CODPOR');

    If (Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text))) Then
    Begin
      strSQL := strSQL + ' AND LOCATE(CTR_ESPDOC, :ESPDOC) > 0 ';
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
      strSQL := strSQL + ' AND CTR_DTAVEN BETWEEN :VENINI AND :VENFIN ';

    If Not fEmptyStr(edtCodVen.Text) Then
      strSQL := strSQL + fStrLocate(edtCodVen, arrVendedor, 'CTR_CODVEN', 'CODVEN');    

    With qryResumo Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
      Begin
        ParamByName('VENINI').AsDate := StrToDate(mskVenIni.Text);
        ParamByName('VENFIN').AsDate := StrToDate(mskVenFin.Text);
      End;

      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      if Not fEmptyStr(edtCodCli.Text) Then
        pSetaParam(edtCodCli.Text,arrClientes,strLinCli,'CODCLI',qryResumo);

      If Not fEmptyStr(edtCodRede.Text) Then
        pSetaParamOR(edtCodRede,arrRede,'CODRED',qryResumo);

      If Not fEmptyStr(edtCodAtividade.Text) Then
        pSetaParam(edtCodAtividade.Text, arrAtividade, strAtividade, 'CODATI', qryResumo);

      If Not fEmptyStr(edtDesPortador.Text) Then
        pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryResumo);

      If (Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text))) Then
        ParamByName('ESPDOC').AsString := mskEspecie.Text;

      If Not fEmptyStr(edtNomVen.Text) Then
        pSetaParam(edtCodVen.Text, arrVendedor, strVendedor, 'CODVEN', qryResumo);

      Open;

      (FieldByName('VTOTAL') As TFloatField).DisplayFormat := '#,##0.00';
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

{**********************************}
{* VERIFICA PERMISSÃO DO DIRETORIO*}
{*REQ***************************LE*}
function TfrmRelPosContabil.fVerificaPermissaoDiretorio(const AName: string): Boolean;
  Var
  FileName: String;
  H: THandle; // Handle é para que o Windows saiba quem é que você está querendo manipular.
begin
  //Recebe o caminho
  FileName := IncludeTrailingPathDelimiter(AName) + 'arqv.tmp';
  //Aqui ele verifica se o diretorio tem permissão de escrita
  //(criando um arquivo temporario)
  H := CreateFile(PChar(FileName), GENERIC_READ or GENERIC_WRITE, 0, nil,
    CREATE_NEW, FILE_ATTRIBUTE_TEMPORARY or FILE_FLAG_DELETE_ON_CLOSE, 0);
  Result := H <> INVALID_HANDLE_VALUE; // SE FOI DIFERENTE DE UM HANDLE INVALIDO.
  
  If Result Then 
    CloseHandle(H);
end;

procedure TfrmRelPosContabil.fraPatExpedtDirectoryChange(Sender: TObject);
begin
  //#Asimov#
  Revisar Eventos: fraPatExpPropertiesButtonClick
end;


end.
