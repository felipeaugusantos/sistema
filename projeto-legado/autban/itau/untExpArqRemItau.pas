unit untExpArqRemItau;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit,  cxTextEdit, cxMaskEdit,
  cxButtonEdit, DateUtils, FilenameEditFocus,
  cxClasses, cxShellBrowserDialog, dxScreenTip, dxCustomHint, cxHint, 
  untFrameDirectoryEditFocus, untFrameCheckComboBoxEmpresa;

type
  TfrmExpArqRemItau = class(TfrmPai)
    pnlFundo: TPanel;
    lblPathRem: TLabel;
    lblNomArq: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    Label1: TLabel;
    btnGerar: TBitBtnLocked;
    fraPathRemessa: TfraDirectoryEditFocus;
    HintControler: TcxHintStyleController;
    fraCheckComboBoxEmpresa: TfraCheckComboBoxEmpresa;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure fraPathRemessaClick(Sender: TObject);
    procedure fraPathRemessaEnter(Sender: TObject);
    procedure fraPathRemessaExit(Sender: TObject);
    procedure fraPathRemessaMouseEnter(Sender: TObject);
    procedure fraPathRemessaMouseLeave(Sender: TObject);
    procedure fraPathRemessaedtDirectoryChange(Sender: TObject);
    procedure fraPathRemessabtnOpenDirectoryClick(Sender: TObject);
    procedure fraPathRemessaedtDirectoryEnter(Sender: TObject);
    procedure fraPathRemessaedtDirectoryExit(Sender: TObject);
    procedure fraPathRemessaedtDirectoryMouseEnter(Sender: TObject);
    procedure fraPathRemessaedtDirectoryMouseLeave(Sender: TObject);
  private

    qryConsultaGen : TUniQuery;
    qryCadPor      : TUniQuery;
    fltPerMul   : Double;
    dtaDataMulta: TDateTime;
    blnVirtualUI: Boolean;
    FEnviarCaracterEspecial: Boolean;

    function fRetEmpresa: String;
    function fRetornaChavePix(const AAUTOINCREM: String):String;
    procedure pShowHint;
    procedure pHideHint;
    function RetornaCodigoMulta: String;
    function RetornaTextoFormatado(ATexto:String): String;

    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemItau: TfrmExpArqRemItau;

implementation

uses untFuncoes, untFuncoesSimples, untFuncAutBan, DB, untTypesSistema, untConsultas,
     untConstantes, untLogCtr, VirtualUI_SDK, untAtualizaOcorrenciasCRM, untTypesCRM;

{$R *.dfm}

procedure TfrmExpArqRemItau.FormShow(Sender: TObject);
Var
  strCodigoRemessa: String;
begin
  inherited;

  strCodigoRemessa  := fStrZero(InttoStr(StrToInt(fGetBancoProxNum('CONFIG341-' + IntToStr(intCartei))) + 1), 7);

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'B' + strCodigoRemessa +
                         //fStrZero(fGetBancoProxNum('CONFIG341-' + IntToStr(intCartei)), 7) +
                         '.TXT';
  pSetFocus(edtCodPor);

  blnVirtualUI := VirtualUI.Active;

  fraPathRemessa.Enabled  := Not blnVirtualUI;
  lblPathRem.Enabled      := Not blnVirtualUI;

  fraCheckComboBoxEmpresa.chkcbEmpresaFocusChanged(fraCheckComboBoxEmpresa.chkcbEmpresa);
  fraCheckComboBoxEmpresa.SelecionaEmpresaLogada(fGetBancoConfig(0,'CONFIG341', 'RELOCAL', '') = 'S');

end;

procedure TfrmExpArqRemItau.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strNomEmp   : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaMor   : String;
    strDtaEmi,
    strDtaMul   : String;
    strKeyDup   : String;
    strCgcEmp   : String;
    strCgcEmpMsg: String;
    strEndEmp   : String;
    strCgcCli   : String;
    strCodAgen  : String;
    strContCor  : String;
    strDigCnt   : String;
    strCodCar   : String;
    strDigCar   : String;
    strCpfCgc   : String;
    strCodRem   : String;
    strInstru1  : String;
    strInstru2  : String;
    strInstruProtestoPers  : String;
    strDiaPro   : String;
    strObsAgru  : String;
    strCep      : String;
    LInstrucaoPF: String;
    LDiasProtestoPF: String;
    LInstrucaoPJ: String;
    LDiasProtestoPJ: String;
    LInstrucao: String;

    strHeader   : String;
    strTransacao: String;
    strMensagem : String;
    strMsgLin1  : String;
    strMsgLin2  : String;
    strMsgLin3  : String;
    strValDup   : String;
    strNumDup   : String;
    strTrailler : String;
    strMsg1     : String;
    strMsg2     : String;
    strMsg3     : String;
    strCodFlash : String;
    strCartSeq  : String;
    strPagador  : String;
    strEndPagador: String;

    intCodSeq   : Integer;
    fltValAtr   : Double;
    txtTexto    : TextFile;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    LEnviarDetalheMulta: Boolean;
    qryRemessa  : TUniQuery;

    strFilePath : String;
    strCartei: String;
    strAutoIncremRem: String;
    strCodOco   : String;

    fltValDpo       : Double;
    strDtaDpo       : String;
    dtaDtaDpo       : TDateTime;
    blnUsaCnd       : Boolean;
    blnUsaDesPonCli : Boolean;

    strRespon: String;

    fltValDup : Double;

    strchkcbEmp : String;
    blnUsaDesPon    : Boolean;
    AstrEndereco    : String;

    strUsaSac   : String;
    strTrans5   : String;
    LEntreguePeloBancoPorEmail : String;

    strBenefi,
    strSacAva,
    strSacEnd,
    strSacBai,
    strSacCEP,
    strSacCid,
    strSacEst   : String;

    LClienteEmail,
    LClienteTipoInscricao,
    LClienteCgc,
    LClienteEndereco,
    LClienteBairro,
    LClienteCEP,
    LClienteCidade,
    LClienteEstado : String;

    LCodigoMulta: String;

    LChavePIX : String;

    procedure pGravaLogctr;
    begin
      qryRemessa.DisableControls;
      qryRemessa.First;
      While Not qryRemessa.Eof Do
      Begin
        {****************}
        {* GRAVA LOGCTR *}
        {*************JS*}
        untLogCtr.GravaLogCtr(qryRemessa.FieldByName('AUTOINCREM').AsString, 'EXPORTAÇÃO DE ARQUIVO DE REMESSA - ' + strCodBco, Self.Name);

        qryRemessa.Next;
      End;
    end;
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  If fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
    Exit;

  If fEmptyStr(fTiraCaracEspeciais(fraPathRemessa.edtDirectory.text)) Then
  Begin
    fMensagem('Path:', 'Diretório p\ exportação deve ser informado!', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
  Begin
    fMensagem('Path:', 'Diretório inválido p\ exportação!', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  strCodBco  := '341';
  strNomBco  := 'BANCO ITAU SA';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);
  strCodAgen := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'CODAGEN', '');
  strContCor := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'NUMCTAC', '');
  strDigCnt  := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'NUMCART', '');
  strDigCar  := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'CODCART', '');
  strInstru1 := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstruProtestoPers := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'INSTPER', '');
  strDiaPro  := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'DIAPROT', '');
  strRespon  := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'RESPONS', '');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);
  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG341', 'RELOCAL', '') = 'N' );
  fltPerMul  :=  fStrToFloat ( fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'PERMULT', '0') );
  FEnviarCaracterEspecial := (Trim(fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'ENVCESP', '')) <> 'N');
  LEnviarDetalheMulta :=  (Trim(fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'DETALHEMULTA', '')) <> 'N');
  LInstrucaoPF    := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'INSTRUCAO_PF', '');
  LDiasProtestoPF := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'DIAS_PROTESTO_PF', '');
  LInstrucaoPJ    := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'INSTRUCAO_PJ', '');
  LDiasProtestoPJ := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'DIAS_PROTESTO_PJ', '');
  LEntreguePeloBancoPorEmail := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'ENTREGUEBANCOEMAIL', '');

  LCodigoMulta   := RetornaCodigoMulta;

  strUsaSac  := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'SACAVAL', '');
  strBenefi  := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'NOMEBEN', '');

  blnUsaCnd := fCfgSis('USACND', VarBoolean);

  If (fCfgSis('DESPON', varBoolean) And (fCfgSis('TDEPON') = '2')) Then
    blnUsaDesPonCli := True
  else
    blnUsaDesPonCli := False;

  If fCfgSis('DESPON', varBoolean) Then
    blnUsaDesPon := True
  Else
    blnUsaDesPon := False;

  //*************************************************//
  // VERIFICA SE EXISTE A CONFIGURACAO PARA A GERA-  //
  // CAO DE REMESSA PARA TODAS AS EMPRESAS OU SOMEN- //
  // TE PARA A EMPRESA ATUAL(LOCAL)                  //
  //**********************************************ED*//
  strNovCodEmp := VS_strCodEmp;

  If Not( blnRemLoc ) Then
    strNovCodEmp := fRetEmpresa;

  strNomEmp := fRetNomeEmpresa(strNovCodEmp);

  If Not fEmptyStr(fCfgSis('NOMCED')) Then
    strNomEmp := fCfgSis('NOMCED');

  //*************************************************//
  // SE OCORRER ALGUM ERRO AO RETORNAR O NOME DA     //
  // EMPRESA, ENTAO DA A MENSAGEM E SKIP A EXPORT.   //
  //**********************************************ED*//
  If fEmptyStr( strNomEmp ) Then
  Begin
    fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!',['&Sim','&Não']);
    Exit;
  End;

  Try
    fStartTransaction;

    qryConsultaGen := fCriaQuery(qryConsultaGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMP_C_G_C_, ';
    strSQL := strSQL + '  EMP_ENDCMP, ';
    strSQL := strSQL + '  EMP_ENDNUM, ';
    strSQL := strSQL + '  CID_NOMCID, ';
    strSQL := strSQL + '  EMP_BAIRRO, ';
    strSQL := strSQL + '  EMP_C_E_P_, ';
    strSQL := strSQL + '  CID_ESTADO, ';
    strSQL := strSQL + '  EMP_ENDERE AS EMPEND, ';
    strSQL := strSQL +  fRetSQLCGCCPFFormatado('1','EMP_C_G_C_') + ' AS EMP_C_G_C_FMT,';
    strSQL := strSQL + '  CONCAT(IFNULL(EMP_ENDERE,""), ", ", IFNULL(EMP_ENDNUM, ""), IF(IFNULL(EMP_ENDCOM, "") = "", "", CONCAT("  ", EMP_ENDCOM)), ';
    strSQL := strSQL + '  CONCAT(IF(IFNULL(EMP_BAIRRO,"")="","",CONCAT(", ", EMP_BAIRRO)), ';
    strSQL := strSQL + '  CONCAT(IF(IFNULL(EMP_C_E_P_,"")="","",CONCAT(" - CEP ",EMP_C_E_P_))), ';
    strSQL := strSQL + '  CONCAT(IF(IFNULL(CID_NOMCID,"")="","",CONCAT(" - ",CID_NOMCID))), ';
    strSQL := strSQL + '  CONCAT(IF(IFNULL(CID_ESTADO,"")="","",CONCAT(" - ",CID_ESTADO))))) AS EMP_ENDERE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + '  JOIN CADCID ON CID_CODCID = EMP_CODCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryConsultaGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      strCgcEmp    := FieldByName('EMP_C_G_C_').AsString;
      strCgcEmpMsg := FieldByName('EMP_C_G_C_FMT').AsString;
      strEndEmp    := FieldByName('EMP_ENDERE').AsString;

      If strUsaSac = 'S' Then
      Begin
        strSacAva :=  fPadR(strNomEmp, 030);
        strSacEnd := fPadR(FieldByName('EMPEND').AsString + ', ' +
                            FieldByName('EMP_ENDNUM').AsString + ' ' +
                            FieldByName('EMP_ENDCMP').AsString, 040);

        strSacBai := fPadR(FieldByName('EMP_BAIRRO').AsString, 012);
        strSacCEP := fPadR(fRetSomenteNumeros(FieldByName('EMP_C_E_P_').AsString), 008, '0');
        strSacCid := fPadR(FieldByName('CID_NOMCID').AsString, 015);
        strSacEst := fPadR(FieldByName('CID_ESTADO').AsString, 002);
      End;

      Close;
    End;

{  Finally
    FreeAndNil(qryConsultaGen);
  ENd;

  Try}
    strCartei := 'CONFIG341-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_EMCOB1, ';
    strSQL := strSQL + '  C.CLI_EMCOB2, ';
    strSQL := strSQL + '  C.CLI_EMAIL_, ';
    strSQL := strSQL + '  C.CLI_EMAIL2, ';
    strSQL := strSQL + '  C.CLI_EMAIL3, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
    strSQL := strSQL + '  R.CTR_DTAREC AS CTR_DTAREC, C.CLI_PERDPO, C.CLI_QTDDAV, C.CLI_CGCCPF, ';
    strSQL := strSQL + '  SUM(R.CTR_DESCOB) AS CTR_DESCOB, ';
    strSQL := strSQL + '  SUM(R.CTR_JURSUJ) AS CTR_JURSUJ, ';
    strSQL := strSQL + '  SUM(R.CTR_DESSUJ) AS CTR_DESSUJ, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDERE, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), C.CLI_ENDERE), C.CLI_ENDCOB) AS ENDERE, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), "")  AS COMPLEMENTO, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IFNULL(C.CLI_ENDNUM, ""), " ") AS NUMERO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_BAIRRO, C.CLI_BAICOB) AS BAIRRO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_C_E_P_, C.CLI_CEPCOB) AS C_E_P_, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                  '(SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS CIDADE, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                  '(SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS ESTADO  ';
    If blnUsaDesPon Then
    Begin
      strSQL := strSQL + '  ,D.CND_PERDPO ';
      strSQL := strSQL + '  ,D.CND_QTDDAV ';
    End;

    strSQL := strSQL + 'FROM              ';
    strSQL := strSQL + '  CADCBI B        ';
    strSQL := strSQL + '  JOIN CADCLI C ON CLI_CODCLI = CBI_CODCLI     ';
    strSQL := strSQL + '  JOIN CADREC R ON CTR_NUMDUP = CBI_NUMDUP AND ';
    strSQL := strSQL + '                   CTR_PARCEL = CBI_PARCEL AND ';
    strSQL := strSQL + '                   CTR_ESPDOC = CBI_ESPDOC AND ';
    strSQL := strSQL + '                   CTR_CODEMP = CBI_CODEMP AND ';
    strSQL := strSQL + '                   CTR_CODCLI = CBI_CODCLI ';

    If blnUsaDesPon Then
      strSQL := strSQL + ' LEFT JOIN CADCND D ON D.CND_CODIGO = B.CBI_CODCND  ';

    strSQL := strSQL + 'WHERE                                                 ';
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO AND                            ';
    strSQL := strSQL + '  ((CTR_DTAREC IS NULL AND (B.CBI_CODOCO IN ("01","71") OR B.CBI_CODOCO = "06")) OR';
    strSQL := strSQL + '  (CTR_DTAREC IS NOT NULL AND B.CBI_CODOCO = "02"))';

    If fraCheckComboBoxEmpresa.chkcbEmpresa.Text <> 'Todas'Then
    Begin
      strchkcbEmp := fraCheckComboBoxEmpresa.chkcbEmpresa.Text;
      strSQL := strSQL + ' AND CBI_EMPGER IN (' + fRetStrToSQLIn(strchkcbEmp,';') + ') ';
    End;

    if (fCfgSis('CONREM', varString) = 'C') THEN
      strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';

    If (Not fEmptyStr(edtCodPor.Text)) Then
      strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR '
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + ' AND (IFNULL(CBI_CODPOR, "") = "" ';
      strSQL := strSQL + ' OR LOCATE(CBI_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    strSQL := strSQL + ' GROUP BY CTR_NUMDUP, CTR_PARCEL, CTR_ESPDOC, CTR_CODEMP, CTR_CODCLI, CTR_SEQCON, CTR_EMPBAI, CTR_DTABAI ' ;

    With qryRemessa Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;

      If (Not fEmptyStr(edtCodPor.Text)) Then
        ParamByName('CODPOR').AsString := edtCodPor.Text;

      if (fCfgSis('CONREM', varString) = 'C') THEN
        ParamByName('CARTEI').AsString := strCartei;

      Open;
    End;

    If Not qryRemessa.IsEmpty Then
    Begin
      //Gerando número da remessa e atualizando carteiras "filhas"
      strCartSeq := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'SEQCART', '');
      strCodRem  := fStrZero(fAtuCodSeq('CONFIG341-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq), 'PROXNUM'), 7);
      pAtualizaProxNumCartsAutBan('CONFIG341-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq));

      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      If LEntreguePeloBancoPorEmail = 'S' Then
      Begin
        LClienteTipoInscricao := IIF(qryRemessa.FieldByName('CBI_CGCCPF').AsString = '2', '01', '02');
        lClienteEmail := fRetornaEmailCliente(qryRemessa);
        LClienteCgc := qryRemessa.FieldByName('CBI_C_G_C_').AsString;
        LClienteEndereco := qryRemessa.FieldByName('ENDERE').AsString;
        LClienteBairro := qryRemessa.FieldByName('BAIRRO').AsString;
        LClienteCEP := qryRemessa.FieldByName('C_E_P_').AsString;
        LClienteCidade := qryRemessa.FieldByName('CIDADE').AsString;
        LClienteEstado := qryRemessa.FieldByName('ESTADO').AsString;
      END;

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************AF*}
      intCodSeq := 1;
      strHeader := '';
      If strCodCar = '358' Then
      Begin
        strHeader := fPadR   ('0'                , 001) + //001
                     fPadR   ('1'                , 001) + //002
                     fPadR   ('REMESSA'          , 007) + //003
                     fPadR   ('04'               , 002) + //010
                     fPadR   ('EMPRESTIMO'       , 015) + //012
                     fStrZero(strCodAgen         , 004) + //027
                     fPadR   ('00'               , 002) + //031
                     fStrZero(strContCor         , 005) + //033
                     fStrZero(strDigCnt          , 001) + //038
                     fPadR   (' '                , 008) + //039
                     fPadR   (IIF(strUsaSac <> 'S', strNomEmp, strBenefi), 030) + //047
                     fPadR   (strCodBco          , 003) + //077
                     fPadR   (strNomBco          , 015) + //080
                     fPadR   (strDtaRem          , 006) + //095
                     fPadR   (' '                , 294) + //101
                     fStrZero(IntToStr(intCodSeq), 006);  //395
      End
      Else
      Begin
        strHeader := fPadR   ('0'                , 001) + //001
                     fPadR   ('1'                , 001) + //002
                     fPadR   ('REMESSA'          , 007) + //003
                     fPadR   ('01'               , 002) + //010
                     fPadR   ('COBRANCA'         , 015) + //012
                     fStrZero(strCodAgen         , 004) + //027
                     fPadR   ('00'               , 002) + //031
                     fStrZero(strContCor         , 005) + //033
                     fStrZero(strDigCnt          , 001) + //038
                     fPadR   (' '                , 008) + //039
                     fPadR   (IIF(strUsaSac <> 'S', strNomEmp, strBenefi), 030) + //047
                     fPadR   (strCodBco          , 003) + //077
                     fPadR   (strNomBco          , 015) + //080
                     fPadR   (strDtaRem          , 006) + //095
                     fPadR   (' '                , 294) + //101
                     fStrZero(IntToStr(intCodSeq), 006);  //395
      End;

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************AF*}
      Writeln(txtTexto,RetornaTextoFormatado(strHeader));

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, StrCartei, StrToInt(strCodRem), strAutoIncremRem);

      {************************}
      {* TRANSAÇÃO DO ARQUIVO *}
      {*********************AF*}

      LChavePIX := fRetornaChavePix(fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'CHAPIX', ''));
      With qryRemessa Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin
          strObsAgru  := '';
          strCodFlash := '';
          strMsg1     := '';
          strMsg2     := '';
          strMsg3     := '';
          Inc(intCodSeq);
          Application.ProcessMessages;

          fltValAtr := fFormataFloat((FieldByName('CBI_VALDUP').AsFloat *
                              FieldByName('CBI_PORCEN').AsFloat) / 100, 2);

          If FieldByName('CBI_CGCCPF').AsInteger = 1 Then
            strCpfCgc := '2'
          Else
            strCpfCgc := '1';

          strInstru1 := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'INSTRU1', '');
          strInstru2 := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'INSTRU2', '');

          If qryRemessa.FieldByName('CLI_CGCCPF').AsString.Equals('2') Then
          Begin
            If Not fEmptyStr(LInstrucaoPF) Then
            Begin
              strInstru2 := LInstrucaoPF;
              strDiaPro  := LDiasProtestoPF;
            End;
          End
          Else If Not fEmptyStr(LInstrucaoPJ) Then
          Begin
            strInstru2 := LInstrucaoPJ;
            strDiaPro  := LDiasProtestoPJ;
          End;

          // INSTRUÇÃO PERSONALIZADA;
          If FieldByName('CBI_PROTES').AsString = 'S' Then
          Begin
            If (Not fEmptyStr(strInstruProtestoPers)) Then
              strInstru2 := strInstruProtestoPers;
          End;

          if (fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'ENVDUPAG', '') = 'S')
             and (strRespon = 'E') And ((Pos(strInstru1,'93_94_') > 0) Or (Pos(strInstru2,'93_94_')>0)) Then
          begin
            If (qryRemessa.FieldByName('CBI_ESPDOC').AsString = 'AG') Then
              strObsAgru := 'REF:_' + COPY(qryRemessa.FieldByName('CBI_OBSAG1').AsString,11,23);
          end;


          if  ((strInstru1 = '93') or (strInstru1 = '94') or (strInstru2 = '93') or (strInstru2 = '94')) then
          begin
            strObsAgru := qryRemessa.FieldByName('CBI_OBSAG1').AsString + ' ' +
                          qryRemessa.FieldByName('CBI_OBSAG2').AsString + ' ' +
                          qryRemessa.FieldByName('CBI_OBSAG3').AsString;

            if fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'OBSERV1', '') <> '' then
            begin
              strMsg1    := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'OBSERV1', '');
              strMsg2    := Copy(strObsAgru, 001, 128);
              strMsg3    := Copy(strObsAgru, 129, 127);
            end
            else
            begin
              strMsg1    := Copy(strObsAgru, 001, 128);
              strMsg2    := Copy(strObsAgru, 129, 128);
              strMsg3    := Copy(strObsAgru, 257, 127);;
            end;

            if fEmptyStr(fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'CDFLASH', '')) Then
            Begin
              strObsAgru := strMsg1    + ' ' + strMsg2 + ' ' + strMsg3;
              strCodFlash:= '';
            End
            Else
            begin
              strCodFlash:= fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'CDFLASH', '');
              strObsAgru := '';
            end;
          end;

          strPagador    := FieldByName('CLI_NOMCLI').AsString;
          strEndPagador := FieldByName('ENDERE').AsString + ', ' +
                           FieldByName('BAIRRO').AsString + ', ' +
                           strCep + ' - ' +
                           FieldByName('CIDADE').AsString + ' - ' +
                           FieldByName('ESTADO').AsString;

          strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTAVEN').AsDateTime);

          strDtaMor := FormatDateTime('ddmmyy', FieldByName('CBI_DTAVEN').AsDateTime +
                                      StrToInt(fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'DIAMORA', '')));

          strDtaEmi := FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTACAD').AsDateTime);

          if not TEspecieParaArquivoRemessa.New.fValidaEspecie(FieldByName('CBI_ESPDOC').AsString) then
          begin
            fRollBack;
            CloseFile(txtTexto);
            If FileExists(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text) Then
              DeleteFile(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
            Exit;
          end;

          strKeyDup := fPadR(FieldByName('CBI_NUMDUP').AsString, 12) +
                       fPadR(FieldByName('CBI_PARCEL').AsString, 03) +
                       fPadR(FieldByName('CBI_ESPDOC').AsString, 02) +
                       fPadR(FieldByName('CBI_CODEMP').AsString, 03);

          //AJUSTANDO ENDEREÇO PARA FICAR COMPLETO DENTRO DE 40 CARACTERES
          AstrEndereco := RetornaEnderecoENumeroCom40Caracteres(qryRemessa.FieldByName('ENDERE').AsString, qryRemessa.FieldByName('NUMERO').AsString);

          strCodOco := FieldByName('CBI_CODOCO').AsString;
          if fEmptyStr(strCodOco) Then
            strCodOco := '01';

          strCgcEmp := Trim(strCgcEmp);
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

          strCgcCli := Trim(FieldByName('CBI_C_G_C_').AsString);
          strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

          strCep := Trim(FieldByName('C_E_P_').AsString);
          strCep := AnsiReplaceStr(strCep, '-', '');

          fltValDup := FieldByName('CBI_VALDUP').AsFloat;

          If fCfgSis('VALIMP', varBoolean) then
          begin
            fltValDup := fltValDup + FieldByName('CTR_JURSUJ').AsFloat +
                                     FieldByName('CTR_DESCOB').AsFloat;
          end;
          
          If fCfgSis('DESBOL', varBoolean) Then          
            fltValDup := fFormataFloat((fltValDup - FieldByName('CTR_DESSUJ').AsFloat),2);

          If blnUsaDesPonCli And blnUsaDesPon Then

          begin
            fltValDpo := ( ( FieldByName('CBI_VALDUP').AsFloat ) * ( FieldByName('CLI_PERDPO').AsFloat / 100 ) );

            If fltValDpo > 0 Then
            Begin
              dtaDtaDpo := FieldByName('CBI_DTAVEN').AsDateTime - FieldByName('CLI_QTDDAV').AsInteger;
              strDtaDpo := FormatDateTime('ddmmyy', dtaDtaDpo);
            End
            Else
              strDtaDpo := '0';
          end
          else
          If blnUsaCnd And blnUsaDesPon Then
          Begin
            fltValDpo := ( ( FieldByName('CBI_VALDUP').AsFloat ) * ( FieldByName('CND_PERDPO').AsFloat / 100 ) );

            If fltValDpo > 0 Then
            Begin
              dtaDtaDpo := FieldByName('CBI_DTAVEN').AsDateTime - FieldByName('CND_QTDDAV').AsInteger;
              strDtaDpo := FormatDateTime('ddmmyy', dtaDtaDpo);
            End
            Else
              strDtaDpo := '0';
          End
          Else
          Begin
            fltValDpo := 0;
            strDtaDpo := '0';
          End;

          If strCodCar = '358' Then
          Begin
            strTransacao := fPadR      ('1'                                     , 01)      + //001
                            fPadR      ('02'                                    , 02)      + //002
                            fPadL      (strCgcEmp                               , 14, '0') + //004
                            fStrZero   (strCodAgen                              , 04)      + //018
                            fPadR      ('00'                                    , 02)      + //022
                            fStrZero   (strContCor                              , 05)      + //024
                            fStrZero   (strDigCnt                               , 01)      + //029
                            fPadR      (' '                                     , 08)      + //030
                            fPadR      (strKeyDup                               , 25)      + //038
                            fPadR      (LeftStr(fStrZero(FieldByName('CBI_NOSNUM').AsString,8),8), 08, '0') + //063
                            fPadL      (' '                                     , 13)      + //071
                            fStrZero   (strCodCar                               , 03)      + //084
                            fPadR      (' '                                     , 21)      + //087
                            fPadR      (strDigCar                               , 01)      + //108
                            fPadR      ('01'                                    , 02)      + //109
                            fPadR      (RightStr(FieldByName('CBI_NUMDUP').AsString +
                                                 FieldByName('CBI_PARCEL').AsString, 10), 10) + //111
                            fPadR      (strDtaVen                               , 06)      + //121
                            fValNumForm(fltValDup                               , 13)      + //127
                            fPadR      (strCodBco                               , 03)      + //140
                            fStrZero   ('0'                                     , 04)      + //143
                            fPadR      ('0'                                     , 01)      + //147
                            fPadR      ('01'                                    , 02)      + //148
                            fPadR      ('N'                                     , 01)      + //150
                            fPadR      (strDtaEmi                               , 06)      + //151
                            fPadR      (strInstru1 {09,10}                      , 02)      + //157
                            fPadR      (' '                                     , 02)      + //159
                            fPadR      (strDtaEmi                               , 06)      + //161
                            fPadR      (' '                                     , 52)      + //167
                            fStrZero   (strCpfCgc                               , 02)      + //219
                            fPadL      (strCgcCli                               , 14, '0') + //221
                            fPadR      (FieldByName('CLI_NOMCLI').AsString      , 30)      + //235
                            fPadR      (' '                                     , 10)      + //265
                            fPadR      (AstrEndereco                            , 40)      + //275
                            fPadR      (FieldByName('BAIRRO').AsString          , 12)      + //315
                            fPadR      (strCep                                  , 08, '0') + //327
                            fPadR      (FieldByName('CIDADE').AsString          , 15)      + //335
                            fPadR      (FieldByName('ESTADO').AsString          , 02)      + //350
                            //Se utilizar sacador avalista, envia o sacador avalista, se não segue a regra abaixo
                            //Quando a instrução 1 ou 2 for 94, a mensagem usa do campo Sacador/Avalista ao campo Data da Mora para ter 40 posições
                            //Se for 93 utiliza apenas as 30 posições do campo Sacador/Avalista
                            IIF(((strInstru1 = '94') or (strInstru2 = '94')) And (strUsaSac <> 'S'),
                                (fPadR(strObsAgru                               , 40)),      //352
                                (fPadR(IIF(strUsaSac <> 'S',strObsAgru, strSacAva), 30)      + //352
                                 fPadR(' '                                      , 04)      + //382
                                 fPadR(strDtaMor                                , 06)))    + //386
                            fStrZero   (strDiaPro                               , 02)      + //392
                            fPadR      (' '                                     , 01)      + //394
                            fStrZero   (IntToStr(intCodSeq)                     , 06);       //395
          End
          Else
          Begin
            strTransacao := fPadR      ('1'                                                                    , 01)      + //001
                            fPadR      ('02'                                                                   , 02)      + //002
                            fPadL      (strCgcEmp                                                              , 14, '0') + //004
                            fStrZero   (strCodAgen                                                             , 04)      + //018
                            fPadR      ('00'                                                                   , 02)      + //022
                            fStrZero   (strContCor                                                             , 05)      + //024
                            fStrZero   (strDigCnt                                                              , 01)      + //029
                            fPadR      (' '                                                                    , 04)      + //030
                            fStrZero   ('0'                                                                    , 04)      + //034
                            fPadR      (strKeyDup                                                              , 25)      + //038
                            fPadR      (LeftStr(fStrZero(FieldByName('CBI_NOSNUM').AsString,8),8)              , 08, '0') + //063
                            fStrZero   ('0'                                                                    , 13)      + //071
                            fStrZero   (strCodCar                                                              , 03)      + //084
                            fPadR      (' '                                                                    , 21)      + //087
                            fPadR      (strDigCar                                                              , 01)      + //108
                            fPadR      (strCodOco                                                              , 02)      + //109
                            fPadR      (RightStr(FieldByName('CBI_NUMDUP').AsString +
                                                 FieldByName('CBI_PARCEL').AsString                            , 10), 10) + //111
                            fPadR      (strDtaVen                                                              , 06)      + //121
                            fValNumForm(fltValDup                                                              , 13)      + //127
                            fPadR      (strCodBco                                                              , 03)      + //140
                            fStrZero   ('0'                                                                    , 05)      + //143
                            fPadR      ('01'                                                                   , 02)      + //148
                            fPadR      ('N'                                                                    , 01)      + //150
                            fPadR      (strDtaEmi                                                              , 06)      + //151
                            fPadR      (strInstru1 {85}                                                        , 02)      + //157
                            fPadR      (strInstru2 {'05'}                                                      , 02)      + //159
                            fValNumForm(fltValAtr                                                              , 13)      + //161
                            fPadR(IIF(fltValDpo > 0,strDtaDpo,IIF(FieldByName('CBI_DESSUJ').AsFloat > 0,strDtaVen, '0')), 06,'0')  + //174
                            IIF(fltValDpo > 0, fValNumForm(fltValDpo, 13), fValNumForm(FieldByName('CBI_DESSUJ').AsFloat, 13))     + //180
                            fStrZero   ('0'                                                                    , 13)      + //193
                            fStrZero   ('0'                                                                    , 13)      + //206
                            fStrZero   (strCpfCgc                                                              , 02)      + //219
                            fPadL      (strCgcCli                                                              , 14, '0') + //221
                            fPadR      (FieldByName('CLI_NOMCLI').AsString                                     , 30)      + //235
                            fPadR      (' '                                                                    , 10)      + //265
                            fPadR      (AstrEndereco                                                           , 40)      + //275
                            fPadR      (FieldByName('BAIRRO').AsString                                         , 12)      + //315
                            fPadR      (strCep                                                                 , 08, '0') + //327
                            fPadR      (FieldByName('CIDADE').AsString                                         , 15)      + //335
                            fPadR      (FieldByName('ESTADO').AsString                                         , 02)      + //350
                            //Se utilizar sacador avalista, envia o sacador avalista, se não segue a regra abaixo
                            //Quando a instrução 1 ou 2 for 94, a mensagem usa do campos Sacador/Avalista ao campo Data da Mora para ter 40 posições
                            //Se for 93 utiliza apenas as 30 posições do campo Sacador/Avalista
                            IIF(((strInstru1 = '94') or (strInstru2 = '94')) And (strUsaSac <> 'S'),
                                (fPadR(strObsAgru                                                              , 40)),      //352
                                (fPadR(IIF(strUsaSac <> 'S',strObsAgru, strSacAva)                             , 30)      + //352
                                 fPadR(' '                                                                     , 04)      + //382
                                 fPadR(strDtaMor                                                               , 06)))    + //386
                            fStrZero   (strDiaPro                                                              , 02)      + //392
                            fPadR      (' '                                                                    , 01)      + //394
                            fStrZero   (IntToStr(intCodSeq)                                                    , 06);       //395
          End;
          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************AF*}
          Writeln(txtTexto,RetornaTextoFormatado(strTransacao));

          if strCodOco = '71' then
          begin
            Inc(intCodSeq);
            strTransacao := '';
            strTransacao := fPadR      ('3'                                                                    , 01)      + //001 - TIPO DE REGISTRO
                            fPadR      (LChavePIX                                                              , 77)      + //002 - 078 : CHAVE PIX   (OPCIONAL)
                            fPadR      (' '                                                                    , 64)      + //079 - 142 : ID LOCATION (OPCIONAL)
                            fPadR      ('02'                                                                   , 02)      + //143 - 144 : CÓDIGO TIPO DE COBRANÇA QR CODE - (01 - COB / 02 - COBV)
                            fPadR      (' '                                                                    , 250)     + //145 - 394 : BRANCOS  -
                            fStrZero   (IntToStr(intCodSeq)                                                    , 06);       //395 - 400 : NÚMERO SEQÜENCIAL

            Writeln(txtTexto,RetornaTextoFormatado(strTransacao));
          end;

          {******************************}
          {* GERANDO REGISTRO DE MULTA  *}
          {***************************KP*}
          if (fltPerMul > 0) And LEnviarDetalheMulta then
          begin
            Inc(intCodSeq);

            dtaDataMulta :=  FieldByName('CBI_DTAVEN').AsDateTime;

            strDtaMul    := FormatDateTime('dd',  dtaDataMulta) +
                            FormatDateTime('mm',  dtaDataMulta) +
                            FormatDateTime('yyyy',dtaDataMulta);

            strTransacao := '';

            strTransacao := fPadR   ('2',                 001) + //001
                            fPadR   ( IIf(fltPerMul>0,LCodigoMulta,'2'), 001) + //002
                            fPadR   (strDtaMul,           008) + //003
                            fValNumForm(fltPerMul,        013) + //011
                            fPadR   (' ',                 371) + //024
                            fStrZero(IntToStr(intCodSeq), 006);  //395

            Writeln(txtTexto,RetornaTextoFormatado(strTransacao));

          end;

          {************************************}
          {* QUANDO UTILIZAR SACADOR/AVALISTA *}
          {*********************************MT*}
          If strUsaSac = 'S' Then
          Begin
            Inc(intCodSeq);

            strTrans5 := fPadR('5'                             ,001)    + //001 - 001
                         fPadR(fRetornaEmailCliente(qryRemessa),120,' ')+ //001 - 121
                         fPadL('02'                            ,002)    + //122 - 123
                         fPadL(fTiraCaracEspeciaisPonto(strCgcEmp)   ,014,'0')+ //124 - 137
                         fPadR(strSacEnd                       ,040,' ')+ //138 - 177
                         fPadR(strSacBai                       ,012,' ')+ //178 - 189
                         fPadL(strSacCep                       ,008,'0')+ //190 - 197
                         fPadR(strSacCid                       ,015,' ')+ //198 - 212
                         fPadR(strSacEst                       ,002,' ')+ //213 - 214
                         fPadR(' '                             ,180,' ')+ //213 - 214
                         fStrZero(IntToStr(intCodSeq)          ,006);    //395 - 400

            Writeln(txtTexto,RetornaTextoFormatado(strTrans5));
          End
          Else If LEntreguePeloBancoPorEmail = 'S' Then
          Begin
            {**********************************************}
            {* QUANDO UTILIZAR BOLETO ENTREGUE PELO BANCO *}
            {*******************************************MT*}
            Inc(intCodSeq);

            strTrans5 := fPadR('5'                             ,001)    + //001 - 001
                         fPadR(LClienteEmail                   ,120,' ')+ //001 - 121
                         fPadL(LClienteTipoInscricao           ,002)    + //122 - 123
                         fPadL(fTiraCaracEspeciaisPonto(LClienteCgc) ,014,'0')+ //124 - 137
                         fPadR(LClienteEndereco                ,040,' ')+ //138 - 177
                         fPadR(LClienteBairro                  ,012,' ')+ //178 - 189
                         fPadL(LClienteCep                     ,008,'0')+ //190 - 197
                         fPadR(LClienteCidade                  ,015,' ')+ //198 - 212
                         fPadR(LClienteEstado                  ,002,' ')+ //213 - 214
                         fPadR(' '                             ,180,' ')+ //213 - 214
                         fStrZero(IntToStr(intCodSeq)          ,006);    //395 - 400

            Writeln(txtTexto,RetornaTextoFormatado(strTrans5));
          End;

          {************************}
          {* REGISTRO 7 MENSAGENS *}
          {*********************JU*}
          If Not fEmptyStr(strCodFlash) Then
          Begin
            Inc(intCodSeq);

            strMensagem := '';
            strMsgLin1  := '';
            strMsgLin2  := '';
            strMsgLin3  := '';

            {********************************************************************************************}
            {********************** CONFORME O GABARITO ENVIADO NO REQUISITO 85317 **********************}
            {********* AS POSIÇÕES 5, 135 E 265 SÃO REFERENTES AS LINHAS DO RECIBO DO PAGADOR ***********}
            {*** ONDE 1 É BENEFICIÁRIO, 3 É CPI, 5 É DATA DO DOCUMENTO, 7 É ENDEREÇO E 8 OBSERVAÇÕES ****}
            {* NESSE CASO EM QUESTÃO ESTOU ENVIANDO FIXO 01 BENEFICIÁRIO, 07 ENDEREÇO DO MESMO E 08 OBS *}
            {*REQ*85317*******************************************************************************MO*}

            strValDup := FormatFloat('#,##0.00', FieldByName('CBI_VALDUP').AsFloat);
            strNumDup := IntToStr(StrToInt64(FieldByName('CBI_NUMDUP').AsString)) + FieldByName('CBI_PARCEL').AsString;
            strDtaVen := FormatDateTime('dd/mm/yyyy', FieldByName('CBI_DTAVEN').AsDateTime);
            strDtaEmi := FormatDateTime('dd/mm/yyyy', FieldByName('CBI_DTACAD').AsDateTime);
            strDtaRem := FormatDateTime('dd/mm/yyyy',VS_Date);

            // 128 posições
            strMsgLin1  := fPadR   (strNomEmp,                                  60) +
                           fPadR   (strCgcEmpMsg,                               20) +
                           fPadR   (strDtaVen,                                  20) +
                           fPadR   (' ',                                        28);

            // 128 posições
            strMsgLin2  := fPadR   (' ',                                        20) +
                           fPadR   (strCodCar,                                   8) +
                           fPadR   ('R$',                                       31) +
                           fPadR   (strValDup,                                  20) +
                           fPadR   (strCodAgen + '/' + strContCor + '-' + strDigCnt,  49);

            // 127 posições
            strMsgLin3  := fPadR   (' ',                                         3) +
                           fPadR   (strDtaEmi,                                  15) +
                           fPadR   (strNumDup,                                  20) +
                           fPadR   ('DMI',                                      15) +
                           fPadR   ('N',                                        10) +
                           fPadR   (strDtaRem,                                  16) +
                           fPadR   (strValDup,                                  34);

            strMensagem := fPadR   ('7',                                       001) + //001
                           fPadR   (strCodFlash,                               003) + //002
                           fPadR   ('01',                                      002) + //005
                           fPadR   (strMsgLin1,                                128) + //007
                           fPadR   ('03',                                      002) + //135
                           fPadR   (strMsgLin2,                                128) + //137
                           fPadR   ('05',                                      002) + //265
                           fPadR   (strMsgLin3,                                127) + //267
                           fPadR   ('1',                                       001) + //394
                           fStrZero(IntToStr(intCodSeq),                       006);  //395

            {************************}
            {* ESCREVE AS MENSAGENS *}
            {*********************JU*}
            Writeln(txtTexto,RetornaTextoFormatado(strMensagem));

            Inc(intCodSeq);

            strMensagem := fPadR   ('7',                                     001) + //001
                           fPadR   (strCodFlash,                             003) + //002
                           fPadR   ('07',                                    002) + //005
                           fPadR   (strEndEmp,                               128) + //007
                           fPadR   ('08',                                    002) + //135
                           fPadR   (strMsg1 + ' ' + strMsg2 + ' ' + strMsg3, 128) + //137
                           fPadR   ('09',                                    002) + //265
                           fPadR   (' ',                                     127) + //267
                           fPadR   ('1',                                     001) + //394
                           fStrZero(IntToStr(intCodSeq),                     006);  //395

            {************************}
            {* ESCREVE AS MENSAGENS *}
            {*********************JU*}
            Writeln(txtTexto,RetornaTextoFormatado(strMensagem));
          End;

          {*****************************}
          {* GRAVAÇÃO DA TABELA REMDET *}
          {**** DETALHES DA REMESSA ****}
          {**************************MO*}
          pGravaRemDet(strAutoIncremRem,
                       FieldByName('AUTOINCREM').AsString,
                       FieldByName('CBI_NOSNUM').AsString,
                       fltPerMul,
                       FieldByName('CBI_VALDUP').AsFloat,
                       FieldByName('CTR_DTAREC').AsDateTime,
                       FieldByName('CBI_DTAVEN').AsDateTime,
                       VS_Date,
                       strLoginUsuarioLogado,
                       '',
                       FieldByName('CBI_PROTES').AsString);

          If fCfgSis('UTICRM', varBoolean) And (Not fEmptyStr(fCfgSis('OCOFIN', varString)))  Then
          Begin
            TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(FieldByName('CBI_NUMDUP').AsString,
                                                     FieldByName('CBI_ESPDOC').AsString,
                                                     FieldByName('CBI_CODEMP').AsString,
                                                     FieldByName('CBI_CODCLI').AsString,
                                                     FieldByName('CBI_PARCEL').AsString,
                                                     strLoginUsuarioLogado,
                                                     fRetCgcCpf(FieldByName('CBI_CODCLI').AsString),
                                                     afcEnviaDuplicataBanco);
          End;

          Next;
        End;

      End;

      {************}
      {* TRAILLER *}
      {*********AF*}
      Inc(intCodSeq);
      strTrailler := '';
      strTrailler := '9'                                + //001
                     fPadR   (' '                , 393) + //002
                     fStrZero(IntToStr(intCodSeq), 006);  //395

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************AF*}
      Writeln(txtTexto,RetornaTextoFormatado(strTrailler));

      CloseFile(txtTexto);

      pDeletaCadCbi(strCodBco, strCartei, edtCodPor.Text);

      pBackupCnfBco;

      If blnVirtualUI Then
        VirtualUI.DownloadFile(strFilePath);

      If fCommit then
      Begin
        {*******************************************}
        {* GRAVA A TABELA LOGCTR FORA DA TRANSAÇÃO *}
        {* POIS ESTAVA CAUSANDO TIMEOUT EM OUTRAS  *}
        {* ROTINAS DO SISTEMA.                     *}
        {*REQ*145737*****************************RP*}
        pGravaLogctr;

		    fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
				          IIF(Not blnVirtualUI, 'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ''), ['&O K']);
      End;

    End
    Else
    Begin
      fRollBack;
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
    End;

		FreeAndNil(qryRemessa);
		FreeAndNil(qryConsultaGen);
		//FreeAndNil(stlMensagem);

	Except
 		On E: Exception Do
		Begin

		  fRollBack;

      Try
        CloseFile(txtTexto);
      Except
        //Caso o erro acontecer após o arquivo já estiver fechado
      End;

      If FileExists(strFilePath) Then
        DeleteFile(strFilePath);

      FreeAndNil(qryRemessa);
      FreeAndNil(qryConsultaGen);

      Raise Exception.Create('Ocorreu um erro ao gerar o arquivo de remessa do banco ' + strCodBco + '-' + strNomBco + #13 +
                             'Erro gerado: ' + E.Message);
		End;
  End;
end;

procedure TfrmExpArqRemItau.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemItau.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var 
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples,
                     Self,
                     edtCodPor,
                     TEditFocus(edtDesPor),
                     nil,
                     Key,
                     arrSel,
                     True,
                     'Consulta de Portadores',
                     '',
                     False,
                     False,
                     '',
                     False,
                     True) then
    Begin
      if fValidaCampos(edtCodPor) then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmExpArqRemItau.fraPathRemessabtnOpenDirectoryClick(
  Sender: TObject);
begin
  inherited;
  fraPathRemessaClick(sender);
  fraPathRemessa.btnOpenDirectoryClick(Sender);

end;

procedure TfrmExpArqRemItau.fraPathRemessaClick(Sender: TObject);
begin
  fraPathRemessa.DefaultFolder := fraPathRemessa.edtDirectory.text;
  inherited;
end;

procedure TfrmExpArqRemItau.fraPathRemessaEnter(Sender: TObject);
begin
  inherited;
  pShowHint;
end;

procedure TfrmExpArqRemItau.pShowHint;
begin
  HintControler.ShowHint(Self.Left + fraPathRemessa.Left,
                         Self.Top + fraPathRemessa.Top,
                         'Atenção',
                         'Para navegar em outros diretórios'+ #13 +
                         'altere o conteúdo deste campo.');
end;

procedure TfrmExpArqRemItau.pHideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmExpArqRemItau.fraPathRemessaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmExpArqRemItau.fraPathRemessaMouseEnter(Sender: TObject);
begin
  inherited;
  pShowHint;
end;

procedure TfrmExpArqRemItau.fraPathRemessaMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

function TfrmExpArqRemItau.fRetEmpresa: String;
  Var
    intCount  : Integer;
    arrResult : Array Of String;
    qryCadEmp : TUniQuery;

Begin

  qryCadEmp := fCriaQuery(Self);
  With qryCadEmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM CADEMP');
    SQL.Add('ORDER BY EMP_CODEMP ');
    Open;
    First;

    SetLength(arrResult, RecordCount);
    intCount := 0;

    While Not Eof Do
    Begin
      arrResult[intCount] := fStrZero(FieldByName('EMP_CODEMP').AsString, 3) + ' - ' + FieldByName('EMP_NOMEMP').AsString;
      Next;
      Inc(intCount);
    End;
  End;


  intCount := 1;

  If Length(arrResult) > 1 Then
    intCount := fGetMenu('Selecione a Empresa', arrResult, 0);


  Result   := LeftStr(arrResult[intCount -1], 3);

  FreeAndnil(qryCadEmp);
end;

function TfrmExpArqRemItau.fRetornaChavePix(const AAUTOINCREM: String): String;
var
  qryChavePix : TUniQuery;
begin
  Try
    Result := '';
    try
      qryChavePix := fCriaQuery(Self);
      qryChavePix.Close;
      qryChavePix.SQL.Clear;
      qryChavePix.SQL.Text := 'SELECT                               '+
                              '  P.PIX_CHAVE_                       '+
                              'FROM                                 '+
                              '  CCAPIX P                           '+
                              '  JOIN CADCCA C                      '+
                              '    ON C.AUTOINCREM = P.PIX_SEQCCA   '+
                              'WHERE P.AUTOINCREM = :AUTOINCREM     ';
      qryChavePix.ParamByName('AUTOINCREM').AsString := AAUTOINCREM;
      qryChavePix.Open;
      if not qryChavePix.isEmpty then
        Result := qryChavePix.FieldByName('PIX_CHAVE_').AsString;
    finally
      FreeAndnil(qryChavePix);
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmExpArqRemItau.fRetornaChavePix]');
    End;
  End;
end;

function TfrmExpArqRemItau.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodPor) Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) Then
      Begin
        edtDesPor.Text := fRetNomPortador(edtCodPor.Text);

        If Not CarregaPortador(edtCodPor.Text) Then
           Result := False
        Else
        If fEmptyStr(edtDesPor.Text) Then
        Begin
          fMensagem('', 'Portador não cadastrado!', ['&Ok']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmExpArqRemItau.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemItau.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
end;

procedure TfrmExpArqRemItau.fraPathRemessaedtDirectoryChange(Sender: TObject);
begin
//  //#Asimov#
//  Revisar Eventos: //fraPathRemessaClick;
//                   //fraPathRemessaEnter;
//                   //fraPathRemessaExit;
//                   //fraPathRemessaMouseEnter;
//                   //fraPathRemessaMouseLeave
end;

procedure TfrmExpArqRemItau.fraPathRemessaedtDirectoryEnter(Sender: TObject);
begin
  inherited;
  fraPathRemessaEnter(sender);
end;

procedure TfrmExpArqRemItau.fraPathRemessaedtDirectoryExit(Sender: TObject);
begin
  inherited;
  fraPathRemessaExit(sender);
end;

procedure TfrmExpArqRemItau.fraPathRemessaedtDirectoryMouseEnter(
  Sender: TObject);
begin
  inherited;
  fraPathRemessaMouseEnter(sender);
end;

procedure TfrmExpArqRemItau.fraPathRemessaedtDirectoryMouseLeave(
  Sender: TObject);
begin
  inherited;
  fraPathRemessaMouseLeave(sender);
end;

{1 - Valor Fixo}
{2 - Percentual}
function TfrmExpArqRemItau.RetornaCodigoMulta: String;
begin
  Result := StrToIntDef(fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'CODIGOMULTA', ''),2).ToString;

  If Not MatchStr(Result,['1','2'])Then
    Result := '2';
end;

function TfrmExpArqRemItau.RetornaTextoFormatado(ATexto: String): String;
begin
  Result := ATexto;

  If Not FEnviarCaracterEspecial Then
    Result := fRetirarCaracteresEspeciais(Result);
end;

end.
