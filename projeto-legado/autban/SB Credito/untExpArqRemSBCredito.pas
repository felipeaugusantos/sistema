unit untExpArqRemSBCredito;

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
  TfrmExpArqRemSBCredito = class(TfrmPai)
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

    strCodBco    : String;
    strCartei    : String;
    strNomEmp    : String;
    qryRemessa   : TUniQuery;
    strchkcbEmp  : String;
    blnUsaDesPon : Boolean;
    strObsAgru   : String;

    strMsg1      : String;
    strMsg2      : String;
    strMsg3      : String;
    strCodFlash  : String;
    fltValDup    : Double;
    blnUsaDesPonCli : Boolean;
    blnUsaCnd       : Boolean;

    fltValDpo    : Double;
    dtaDtaDpo    : TDateTime;
    strDtaDpo    : String;

    function fRetEmpresa: String;
    procedure pShowHint;
    procedure pHideHint;
    function fCriarQueryRemessa: TUniQuery;
    procedure fDeletaArquivoPath(strPath: String);
    function fGetSqlRemessa: String;
    function fRetornaChaveNfe(StrChvNfe: String): String;
    function fRetornaCodOcorrencia(AstrCodOco: String): String;
    function fRetornaCpfCgc(IntTipo: Integer): String;
    function fRetornaFoneCliente(strFoneCli01, strFoneCli02: String): String;
    function fRetornaObsAgru(AstrRespon, AstrInstru1, AstrInstru2,
      AstrEspDocCbi, AstrObsAG1Cbi: String): String;
    function fRetornaValDup(AfltValDup, AfltJurSuj, AfltDesCob: Double): Double;
    function fValidacoesParaExportacao: Boolean;
    procedure pGravaLogctr;
    procedure pRetornaDesconto(AfltValDup, AfltPERDPO: Double;
      AdtDTAVEN: TDatetime; AIntQTDDAV: Integer);
    procedure pRetornaMensagens(AstrInstru1, AstrInstru2, AstrObsAg1Cbi,
      AstrObsAg2Cbi, AstrObsAg3Cbi: String);
    procedure pVerifica_VirtualUI(spath: String);
    procedure pVerificaOcorrenciaFinanceiro(strNumDup, strEspDoc, strCodEmp,
      strCodCli, strParcel: String);

    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemSBCredito: TfrmExpArqRemSBCredito;

implementation

uses untFuncoes, untFuncoesSimples, untFuncAutBan, DB, untTypesSistema, untConsultas,
     untConstantes, untLogCtr, VirtualUI_SDK, untAtualizaOcorrenciasCRM, untTypesCRM;

{$R *.dfm}

procedure TfrmExpArqRemSBCredito.FormShow(Sender: TObject);
begin
  inherited;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG988-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'B' +
                          fStrZero(fGetBancoProxNum('CONFIG988-' + IntToStr(intCartei)), 7) +
                         '.TXT';
  pSetFocus(edtCodPor);

  blnVirtualUI := VirtualUI.Active;

  fraPathRemessa.Enabled  := Not blnVirtualUI;
  lblPathRem.Enabled      := Not blnVirtualUI;
end;

function TfrmExpArqRemSBCredito.fValidacoesParaExportacao: Boolean;
  Var
    blnRemLoc   : Boolean;
    strNovCodEmp: String;
begin
  Result := True;

  If Not fVerificaCampos Then
  Begin
    Result := False;
    Exit;
  End;

  If fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
  Begin
    Result := False;
    Exit;
  End;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
  Begin
    fMensagem('Path:', 'Diretório inválido p\ exportação.', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Result := False;
    Exit;
  End;

  {***************************************************
   * VERIFICA SE EXISTE A CONFIGURACAO PARA A GERA-  *
   * CAO DE REMESSA PARA TODAS AS EMPRESAS OU SOMEN- *
   * TE PARA A EMPRESA ATUAL(LOCAL)                  *
   ***********************************************ED*}
  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG988', 'RELOCAL', '') = 'N' );

  strNovCodEmp := VS_strCodEmp;
  If Not( blnRemLoc ) Then
    strNovCodEmp := fRetEmpresa;  //Abre bloco para escolher a empresa
  strNomEmp := fRetNomeEmpresa(strNovCodEmp);

  If Not fEmptyStr(fCfgSis('NOMCED')) Then
    strNomEmp := fCfgSis('NOMCED');

  If fEmptyStr( strNomEmp ) Then
  Begin
    fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!',['&Sim','&Não']);
    Result := False;
    Exit;
  End;

end;

function TfrmExpArqRemSBCredito.fCriarQueryRemessa: TUniQuery;
begin
  Result := Nil;

  Try
    Result:= fCriaQuery(Self);
    Result.Close;
    Result.SQL.Clear;
    Result.SQL.Add(fGetSqlRemessa);
    Result.ParamByName('CODBCO').AsString := '988';

    If (Not fEmptyStr(edtCodPor.Text)) Then
      Result.ParamByName('CODPOR').AsString := edtCodPor.Text;

    if (fCfgSis('CONREM', varString) = 'C') THEN
      Result.ParamByName('CARTEI').AsString := strCartei;

    Result.Open;
  Except
  On E: Exception Do
   Begin
     pMensagensErro(E.Message, '[TfrmExpArqRemSBCredito.fCriarQueryRemessa]');
   End;
  End;

end;

function TfrmExpArqRemSBCredito.fGetSqlRemessa: String;
  Var
    strSQL : String;
begin

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_EMCOB1, ';
    strSQL := strSQL + '  C.CLI_EMCOB2, ';
    strSQL := strSQL + '  C.CLI_EMAIL_, ';
    strSQL := strSQL + '  C.CLI_EMAIL2, ';
    strSQL := strSQL + '  C.CLI_EMAIL3, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  C.CLI_FONE01, ';
    strSQL := strSQL + '  C.CLI_FONE02, ';
    strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
    strSQL := strSQL + '  R.CTR_DTAREC AS CTR_DTAREC, C.CLI_PERDPO, C.CLI_QTDDAV, ';
    strSQL := strSQL + '  R.CTR_DESCOB AS CTR_DESCOB, ';
    strSQL := strSQL + '  R.CTR_JURSUJ AS CTR_JURSUJ, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDERE, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), C.CLI_ENDERE), C.CLI_ENDCOB) AS ENDERE, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), "")  AS COMPLEMENTO, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IFNULL(C.CLI_ENDNUM, ""), " ") AS NUMERO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_BAIRRO, C.CLI_BAICOB) AS BAIRRO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_C_E_P_, C.CLI_CEPCOB) AS C_E_P_, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                  '(SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS CIDADE, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                  '(SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS ESTADO,  ';

    strSQL := strSQL + '  L.NFE_ACESSO ';

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

    strSQL := strSQL + '  LEFT JOIN LOGNFE L ON L.NFE_NUMDOC = B.CBI_NUMDUP AND ';
    strSQL := strSQL + '                        L.NFE_ESPDOC = B.CBI_ESPDOC AND ';
    strSQL := strSQL + '                        L.NFE_CODEMP = B.CBI_CODEMP AND ';
    strSQL := strSQL + '                        L.NFE_CODCLI = B.CBI_CODCLI AND ';
    strSQL := strSQL + '                        L.NFE_TIP_FC = "C" ';

    strSQL := strSQL + 'WHERE                                                 ';
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO AND                            ';
    strSQL := strSQL + '  ((CTR_DTAREC IS NULL AND (B.CBI_CODOCO = "01" OR B.CBI_CODOCO = "06")) OR';
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

    Result := strSQL;

End;

Function TfrmExpArqRemSBCredito.fRetornaFoneCliente(strFoneCli01, strFoneCli02 : String) : String;
Begin
  Result := '';
  If Not FEmptyStr(strFoneCli01) Then
     Result := fRetSomenteNumeros(strFoneCli01)
  Else
     Result := fRetSomenteNumeros(strFoneCli02);
End;

Function TfrmExpArqRemSBCredito.fRetornaCpfCgc(IntTipo : Integer) : String;
Begin

  If IntTipo = 1 Then
     Result := '2'
  Else
     Result := '1';

End;

Function TfrmExpArqRemSBCredito.fRetornaObsAgru(AstrRespon, AstrInstru1, AstrInstru2, AstrEspDocCbi, AstrObsAG1Cbi : String) : String;
Begin

  If (fGetBancoConfig(0, 'CONFIG988-' + IntToStr(intCartei), 'ENVDUPAG', '') = 'S')
     and (AstrRespon = 'E') And ((Pos(AstrInstru1,'93_94_') > 0) Or (Pos(AstrInstru2,'93_94_')>0)) Then
  begin
    If (AstrEspDocCbi = 'AG') Then
        strObsAgru := 'REF:_' + Copy(AstrObsAG1Cbi,11,23);
  end;

End;

Procedure TfrmExpArqRemSBCredito.pRetornaMensagens( AstrInstru1, AstrInstru2, AstrObsAg1Cbi, AstrObsAg2Cbi, AstrObsAg3Cbi : String);
Begin

    If MatchStr(AstrInstru1, ['93','94']) or MatchStr(AstrInstru2, ['93','94']) Then
    begin
      strObsAgru := AstrObsAg1Cbi + ' ' +
                    AstrObsAg2Cbi + ' ' +
                    AstrObsAg3Cbi;

      if fGetBancoConfig(0, 'CONFIG988-' + IntToStr(intCartei), 'OBSERV1', '') <> '' then
      begin
        strMsg1    := fGetBancoConfig(0, 'CONFIG988-' + IntToStr(intCartei), 'OBSERV1', '');
        strMsg2    := Copy(strObsAgru, 001, 128);
        strMsg3    := Copy(strObsAgru, 129, 127);
      end
      else
      begin
        strMsg1    := Copy(strObsAgru, 001, 128);
        strMsg2    := Copy(strObsAgru, 129, 128);
        strMsg3    := Copy(strObsAgru, 257, 127);;
      end;

      if fEmptyStr(fGetBancoConfig(0, 'CONFIG988-' + IntToStr(intCartei), 'CDFLASH', '')) Then
      Begin
        strObsAgru := strMsg1 + ' ' + strMsg2 + ' ' + strMsg3;
        strCodFlash:= '';
      End
      Else
      begin
        strCodFlash:= fGetBancoConfig(0, 'CONFIG988-' + IntToStr(intCartei), 'CDFLASH', '');
        strObsAgru := '';
      end;
    end;

End;

Function TfrmExpArqRemSBCredito.fRetornaCodOcorrencia( AstrCodOco : String) : String;
Var
    strCodOco : String;
Begin

   strCodOco := AstrCodOco;
   If fEmptyStr(strCodOco) Then
      strCodOco := '01';

   Result := strCodOco;

End;

Function TfrmExpArqRemSBCredito.fRetornaValDup( AfltValDup, AfltJurSuj, AfltDesCob : Double) : Double;
 Var
     vlr : double;
Begin

  vlr := AfltValDup;

  If fCfgSis('VALIMP', varBoolean) then
  Begin
     vlr := vlr + AfltJurSuj + AfltDesCob;
  End;

  Result := vlr;

End;

Procedure TfrmExpArqRemSBCredito.pRetornaDesconto( AfltValDup, AfltPERDPO: Double; AdtDTAVEN : TDatetime; AIntQTDDAV : Integer);
Begin

    If blnUsaDesPonCli And blnUsaDesPon Then
    begin
      fltValDpo := ( ( AfltValDup ) * ( AfltPERDPO / 100 ) );

      If fltValDpo > 0 Then
      Begin
        dtaDtaDpo := AdtDTAVEN - AIntQTDDAV;
        strDtaDpo := FormatDateTime('ddmmyy', dtaDtaDpo);
      End
      Else
        strDtaDpo := '0';
    end
    else
    If blnUsaCnd And blnUsaDesPon Then
    Begin
      fltValDpo := ( ( AfltValDup ) * ( AfltPERDPO / 100 ) );

      If fltValDpo > 0 Then
      Begin
        dtaDtaDpo := AdtDTAVEN - AIntQTDDAV;
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

End;

Function TfrmExpArqRemSBCredito.fRetornaChaveNfe(StrChvNfe : String) : String;
Begin

  Result := '';

  If (Not fEmptyStr(StrChvNfe)) then
     Result := fPadL(StrChvNfe, 044, '0'); //401 - 444 CHAVE DA NF-E

End;

procedure TfrmExpArqRemSBCredito.pVerifica_VirtualUI(spath : String );
Begin

   If blnVirtualUI Then
      VirtualUI.DownloadFile(spath);

End;

procedure TfrmExpArqRemSBCredito.fDeletaArquivoPath(strPath : String);
Begin

   If FileExists(strPath) Then
      DeleteFile(strPath);

End;

procedure TfrmExpArqRemSBCredito.pGravaLogctr;
begin
  {****************}
  {* GRAVA LOGCTR *}
  {*************JS*}
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

procedure TfrmExpArqRemSBCredito.pVerificaOcorrenciaFinanceiro(strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel : String);
begin

   If fCfgSis('UTICRM', varBoolean) And (Not fEmptyStr(fCfgSis('OCOFIN', varString)))  Then
   Begin
      TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(strNumDup,
                                               strEspDoc,
                                               strCodEmp,
                                               strCodCli,
                                               strParcel,
                                               strLoginUsuarioLogado,
                                               fRetCgcCpf(strCodCli),
                                               afcEnviaDuplicataBanco);
   End;

End;

procedure TfrmExpArqRemSBCredito.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strNomBco   : String;
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
    strDiaPro   : String;
    strCep      : String;

    strHeader   : String;
    strTransacao: String;
    strTrailler : String;
    strCartSeq  : String;
    strPagador  : String;
    strEndPagador: String;

    intCodSeq   : Integer;
    fltValAtr   : Double;
    txtTexto    : TextFile;

    strFilePath : String;
    strAutoIncremRem: String;
    strCodOco   : String;

    strRespon: String;

    AstrEndereco    : String;

    strUsaSac   : String;
    strTrans5   : String;

    strBenefi,
    strSacAva,
    strSacEnd,
    strSacBai,
    strSacCEP,
    strSacCid,
    strSacEst   : String;

    strSacFone  : String;

begin
  inherited;

  If Not fValidacoesParaExportacao Then
     Exit;

  strSacFone := '';

  strCodBco  := '988';
  strNomBco  := 'SB CREDITO';//'BANCO ITAU SA';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);
  strCodAgen := fGetBancoConfig(0, 'CONFIG988-' + IntToStr(intCartei), 'CODAGEN', '');
  strContCor := fGetBancoConfig(0, 'CONFIG988-' + IntToStr(intCartei), 'NUMCTAC', '');
  strDigCnt  := fGetBancoConfig(0, 'CONFIG988-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG988-' + IntToStr(intCartei), 'NUMCART', '');
  strDigCar  := fGetBancoConfig(0, 'CONFIG988-' + IntToStr(intCartei), 'CODCART', '');
  strInstru1 := fGetBancoConfig(0, 'CONFIG988-' + IntToStr(intCartei), 'INSTRU1', '');
  strDiaPro  := fGetBancoConfig(0, 'CONFIG988-' + IntToStr(intCartei), 'DIAPROT', '');
  strRespon  := fGetBancoConfig(0, 'CONFIG988-' + IntToStr(intCartei), 'RESPONS', '');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);
  fltPerMul  :=  fStrToFloat ( fGetBancoConfig(0, 'CONFIG988-' + IntToStr(intCartei), 'PERMULT', '0') );

  strUsaSac  := fGetBancoConfig(0, 'CONFIG988-' + IntToStr(intCartei), 'SACAVAL', '');
  strBenefi  := fGetBancoConfig(0, 'CONFIG988-' + IntToStr(intCartei), 'NOMEBEN', '');

  blnUsaCnd := fCfgSis('USACND', VarBoolean);

  blnUsaDesPonCli := (fCfgSis('DESPON', varBoolean) And (fCfgSis('TDEPON') = '2'));

  blnUsaDesPon    :=  fCfgSis('DESPON', varBoolean);

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

    qryConsultaGen.Close;
    qryConsultaGen.SQL.Clear;
    qryConsultaGen.SQL.Add(strSQL);
    qryConsultaGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConsultaGen.Open;
    strCgcEmp    := qryConsultaGen.FieldByName('EMP_C_G_C_').AsString;
    strCgcEmpMsg := qryConsultaGen.FieldByName('EMP_C_G_C_FMT').AsString;
    strEndEmp    := qryConsultaGen.FieldByName('EMP_ENDERE').AsString;

    If strUsaSac = 'S' Then
    Begin
      strSacAva := fPadR(strNomEmp, 030);
      strSacEnd := fPadR(qryConsultaGen.FieldByName('EMPEND').AsString + ', ' +
                         qryConsultaGen.FieldByName('EMP_ENDNUM').AsString + ' ' +
                         qryConsultaGen.FieldByName('EMP_ENDCMP').AsString, 040);

      strSacBai := fPadR(qryConsultaGen.FieldByName('EMP_BAIRRO').AsString, 012);
      strSacCEP := fPadR(fRetSomenteNumeros(qryConsultaGen.FieldByName('EMP_C_E_P_').AsString), 008, '0');
      strSacCid := fPadR(qryConsultaGen.FieldByName('CID_NOMCID').AsString, 015);
      strSacEst := fPadR(qryConsultaGen.FieldByName('CID_ESTADO').AsString, 002);
    End;

    qryConsultaGen.Close;


    strCartei := 'CONFIG988-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriarQueryRemessa;

    If Not qryRemessa.IsEmpty Then
    Begin
      //Gerando número da remessa e atualizando carteiras "filhas"
      strCartSeq := fGetBancoConfig(0, 'CONFIG988-' + IntToStr(intCartei), 'SEQCART', '');
      strCodRem  := fStrZero(fAtuCodSeq('CONFIG988-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq), 'PROXNUM'), 7);
      pAtualizaProxNumCartsAutBan('CONFIG988-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq));

      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

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
                     fPadR   ('341'              , 003) + //077
                     fPadR   ('BANCO ITAU SA'    , 015) + //080
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
                     fPadR   ('341'              , 003) + //077
                     fPadR   ('BANCO ITAU SA'    , 015) + //080
                     fPadR   (strDtaRem          , 006) + //095
                     fPadR   (' '                , 294) + //101
                     fStrZero(IntToStr(intCodSeq), 006);  //395
      End;

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************AF*}
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, StrCartei, StrToInt(strCodRem), strAutoIncremRem);

      {************************}
      {* TRANSAÇÃO DO ARQUIVO *}
      {*********************AF*}
      strTransacao := '';

      While Not qryRemessa.Eof Do
      Begin
        strSacFone  := '';
        strObsAgru  := '';
        strCodFlash := '';
        strMsg1     := '';
        strMsg2     := '';
        strMsg3     := '';
        Inc(intCodSeq);
        Application.ProcessMessages;

        strSacFone := fRetornaFoneCliente(qryRemessa.FieldByName('CLI_FONE01').AsString, qryRemessa.FieldByName('CLI_FONE02').AsString);

        fltValAtr := fFormataFloat((qryRemessa.FieldByName('CBI_VALDUP').AsFloat *
                                    qryRemessa.FieldByName('CBI_PORCEN').AsFloat) / 100, 2);

        strCpfCgc := fRetornaCpfCgc( qryRemessa.FieldByName('CBI_CGCCPF').AsInteger );

        strInstru1 := fGetBancoConfig(0, 'CONFIG988-' + IntToStr(intCartei), 'INSTRU1', '');
        strInstru2 := fGetBancoConfig(0, 'CONFIG988-' + IntToStr(intCartei), 'INSTRU2', '');

        strObsAgru := fRetornaObsAgru( strRespon, strInstru1, strInstru2,
                                       qryRemessa.FieldByName('CBI_ESPDOC').AsString,
                                       qryRemessa.FieldByName('CBI_OBSAG1').AsString );

        pRetornaMensagens( strInstru1, strInstru2,
                           qryRemessa.FieldByName('CBI_OBSAG1').AsString,
                           qryRemessa.FieldByName('CBI_OBSAG2').AsString,
                           qryRemessa.FieldByName('CBI_OBSAG3').AsString );

        strPagador    := qryRemessa.FieldByName('CLI_NOMCLI').AsString;
        strEndPagador := qryRemessa.FieldByName('ENDERE').AsString + ', ' +
                         qryRemessa.FieldByName('BAIRRO').AsString + ', ' +
                         strCep + ' - ' +
                         qryRemessa.FieldByName('CIDADE').AsString + ' - ' +
                         qryRemessa.FieldByName('ESTADO').AsString;

        strDtaVen := FormatDateTime('dd',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime) +
                     FormatDateTime('mm',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime) +
                     FormatDateTime('yy',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime);

        strDtaMor := FormatDateTime('ddmmyy', qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime +
                                    StrToInt(fGetBancoConfig(0, 'CONFIG988-' + IntToStr(intCartei), 'DIAMORA', '')));

        strDtaEmi := FormatDateTime('dd',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime) +
                     FormatDateTime('mm',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime) +
                     FormatDateTime('yy',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime);

        if not TEspecieParaArquivoRemessa.New.fValidaEspecie(qryRemessa.FieldByName('CBI_ESPDOC').AsString) then
        begin
          fRollBack;
          CloseFile(txtTexto);
          If FileExists(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text) Then
            DeleteFile(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
          Exit;
        end;

        strKeyDup := fPadR(qryRemessa.FieldByName('CBI_NUMDUP').AsString, 12) +
                     fPadR(qryRemessa.FieldByName('CBI_PARCEL').AsString, 03) +
                     fPadR(qryRemessa.FieldByName('CBI_ESPDOC').AsString, 02) +
                     fPadR(qryRemessa.FieldByName('CBI_CODEMP').AsString, 03);

        //AJUSTANDO ENDEREÇO PARA FICAR COMPLETO DENTRO DE 40 CARACTERES
        AstrEndereco := RetornaEnderecoENumeroCom40Caracteres(qryRemessa.FieldByName('ENDERE').AsString, qryRemessa.FieldByName('NUMERO').AsString);

        strCodOco := fRetornaCodOcorrencia(qryRemessa.FieldByName('CBI_CODOCO').AsString);

        strCgcEmp := Trim(strCgcEmp);
        strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
        strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
        strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

        strCgcCli := Trim(qryRemessa.FieldByName('CBI_C_G_C_').AsString);
        strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
        strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
        strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

        strCep := Trim(qryRemessa.FieldByName('C_E_P_').AsString);
        strCep := AnsiReplaceStr(strCep, '-', '');

        fltValDup := fRetornaValDup( qryRemessa.FieldByName('CBI_VALDUP').AsFloat,
                                     qryRemessa.FieldByName('CTR_JURSUJ').AsFloat,
                                     qryRemessa.FieldByName('CTR_DESCOB').AsFloat );

        pRetornaDesconto( fltValDup,
                          qryRemessa.FieldByName('CLI_PERDPO').AsFloat,
                          qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime,
                          qryRemessa.FieldByName('CLI_QTDDAV').AsInteger );

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
                          fPadR      (LeftStr(fStrZero(qryRemessa.FieldByName('CBI_NOSNUM').AsString,8),8), 08, '0') + //063
                          fPadL      (' '                                     , 13)      + //071
                          fStrZero   (strCodCar                               , 03)      + //084
                          fPadR      (' '                                     , 21)      + //087
                          fPadR      (strDigCar                               , 01)      + //108
                          fPadR      ('01'                                    , 02)      + //109
                          fPadR      (RightStr(qryRemessa.FieldByName('CBI_NUMDUP').AsString +
                                               qryRemessa.FieldByName('CBI_PARCEL').AsString, 10), 10) + //111
                          fPadR      (strDtaVen                               , 06)      + //121
                          fValNumForm(fltValDup                               , 13)      + //127
                          fPadR      ('341'                                   , 03)      + //140
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
                          fPadR      (qryRemessa.FieldByName('CLI_NOMCLI').AsString      , 30)      + //235
                          fPadR      (' '                                     , 10)      + //265
                          fPadR      (AstrEndereco                            , 40)      + //275
                          fPadR      (qryRemessa.FieldByName('BAIRRO').AsString          , 12)      + //315
                          fPadR      (strCep                                  , 08, '0') + //327
                          fPadR      (qryRemessa.FieldByName('CIDADE').AsString          , 15)      + //335
                          fPadR      (qryRemessa.FieldByName('ESTADO').AsString          , 02)      + //350
                          //Se utilizar sacador avalista, envia o sacador avalista, se não segue a regra abaixo
                          //Quando a instrução 1 ou 2 for 94, a mensagem usa do campo Sacador/Avalista ao campo Data da Mora para ter 40 posições
                          //Se for 93 utiliza apenas as 30 posições do campo Sacador/Avalista
                          IIF(((strInstru1 = '94') or (strInstru2 = '94')) And (strUsaSac <> 'S'),
                              (fPadR(strObsAgru                               , 40)),      //352
                              (fPadR(IIF(strUsaSac <> 'S',strObsAgru, strSacFone), 30)      + //352
                               fPadR(' '                                      , 04)      + //382
                               fPadR(strDtaMor                                , 06)))    + //386
                          fStrZero   (strDiaPro                               , 02)      + //392
                          fPadR      (' '                                     , 01)      + //394
                          fStrZero   (IntToStr(intCodSeq)                     , 06);       //395

          strTransacao := strTransacao + fRetornaChaveNfe( qryRemessa.FieldByName('NFE_ACESSO').AsString ); //401 - 444 CHAVE DA NF-E

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
                          fPadR      (LeftStr(fStrZero(qryRemessa.FieldByName('CBI_NOSNUM').AsString,8),8)              , 08, '0') + //063
                          fStrZero   ('0'                                                                    , 13)      + //071
                          fStrZero   (strCodCar                                                              , 03)      + //084
                          fPadR      (' '                                                                    , 21)      + //087
                          fPadR      (strDigCar                                                              , 01)      + //108
                          fPadR      (strCodOco                                                              , 02)      + //109
                          fPadR      (RightStr(qryRemessa.FieldByName('CBI_NUMDUP').AsString +
                                               qryRemessa.FieldByName('CBI_PARCEL').AsString                            , 10), 10) + //111
                          fPadR      (strDtaVen                                                              , 06)      + //121
                          fValNumForm(fltValDup                                                              , 13)      + //127
                          fPadR      ('341'                                                                  , 03)      + //140
                          fStrZero   ('0'                                                                    , 05)      + //143
                          fPadR      ('01'                                                                   , 02)      + //148
                          fPadR      ('N'                                                                    , 01)      + //150
                          fPadR      (strDtaEmi                                                              , 06)      + //151
                          fPadR      (strInstru1 {85}                                                        , 02)      + //157
                          fPadR      (strInstru2 {'05'}                                                      , 02)      + //159
                          fValNumForm(fltValAtr                                                              , 13)      + //161
                          fPadR(IIF(fltValDpo > 0,strDtaDpo,IIF(qryRemessa.FieldByName('CBI_DESSUJ').AsFloat > 0,strDtaVen, '0')), 06,'0')  + //174
                          IIF(fltValDpo > 0, fValNumForm(fltValDpo, 13), fValNumForm(qryRemessa.FieldByName('CBI_DESSUJ').AsFloat, 13))     + //180
                          fStrZero   ('0'                                                                    , 13)      + //193
                          fStrZero   ('0'                                                                    , 13)      + //206
                          fStrZero   (strCpfCgc                                                              , 02)      + //219
                          fPadL      (strCgcCli                                                              , 14, '0') + //221
                          fPadR      (qryRemessa.FieldByName('CLI_NOMCLI').AsString                                     , 30)      + //235
                          fPadR      (' '                                                                    , 10)      + //265
                          fPadR      (AstrEndereco                                                           , 40)      + //275
                          fPadR      (qryRemessa.FieldByName('BAIRRO').AsString                                         , 12)      + //315
                          fPadR      (strCep                                                                 , 08, '0') + //327
                          fPadR      (qryRemessa.FieldByName('CIDADE').AsString                                         , 15)      + //335
                          fPadR      (qryRemessa.FieldByName('ESTADO').AsString                                         , 02)      + //350
                          //Se utilizar sacador avalista, envia o sacador avalista, se não segue a regra abaixo
                          //Quando a instrução 1 ou 2 for 94, a mensagem usa do campos Sacador/Avalista ao campo Data da Mora para ter 40 posições
                          //Se for 93 utiliza apenas as 30 posições do campo Sacador/Avalista
                          IIF(((strInstru1 = '94') or (strInstru2 = '94')) And (strUsaSac <> 'S'),
                              (fPadR(strObsAgru                                                              , 40)),      //352
                              //(fPadR(IIF(strUsaSac <> 'S',strObsAgru, strSacAva)                           , 30)      + //352
                              (fPadR(IIF(strUsaSac <> 'S',strObsAgru, strSacFone)                            , 30)      + //352
                               fPadR(' '                                                                     , 04)      + //382
                               fPadR(strDtaMor                                                               , 06)))    + //386
                          fStrZero   (strDiaPro                                                              , 02)      + //392
                          fPadR      (' '                                                                    , 01)      + //394
                          fStrZero   (IntToStr(intCodSeq)                                                    , 06);       //395

          strTransacao := strTransacao + fRetornaChaveNfe( qryRemessa.FieldByName('NFE_ACESSO').AsString ); //401 - 444 CHAVE DA NF-E

        End;

        {******************************}
        {* ESCREVE A TRANSACAO NO TXT *}
        {***************************AF*}
        Writeln(txtTexto,strTransacao);


        {******************************}
        {* GERANDO REGISTRO DE MULTA  *}
        {***************************KP*}
        if fltPerMul > 0 then
        begin
          Inc(intCodSeq);

          dtaDataMulta := qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime;

          strDtaMul    := FormatDateTime('dd',  dtaDataMulta) +
                          FormatDateTime('mm',  dtaDataMulta) +
                          FormatDateTime('yyyy',dtaDataMulta);

          strTransacao := '';

          strTransacao := fPadR   ('2',                 001) + //001
                          fPadR   ('2',                 001) + //002
                          fPadR   (strDtaMul,           008) + //003
                          fValNumForm(fltPerMul,        013) + //011
                          fPadR   (' ',                 371) + //024
                          fStrZero(IntToStr(intCodSeq), 006);  //395

          Writeln(txtTexto,strTransacao);

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

          Writeln(txtTexto,strTrans5);
        End;

        {*****************************}
        {* GRAVAÇÃO DA TABELA REMDET *}
        {**** DETALHES DA REMESSA ****}
        {**************************MO*}
        pGravaRemDet(strAutoIncremRem,
                     qryRemessa.FieldByName('AUTOINCREM').AsString,
                     qryRemessa.FieldByName('CBI_NOSNUM').AsString,
                     fltPerMul,
                     qryRemessa.FieldByName('CBI_VALDUP').AsFloat,
                     qryRemessa.FieldByName('CTR_DTAREC').AsDateTime,
                     qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime,
                     VS_Date,
                     strLoginUsuarioLogado,
                     '');

        pVerificaOcorrenciaFinanceiro(qryRemessa.FieldByName('CBI_NUMDUP').AsString,
                                      qryRemessa.FieldByName('CBI_ESPDOC').AsString,
                                      qryRemessa.FieldByName('CBI_CODEMP').AsString,
                                      qryRemessa.FieldByName('CBI_CODCLI').AsString,
                                      qryRemessa.FieldByName('CBI_PARCEL').AsString);

        qryRemessa.Next;
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
      Writeln(txtTexto,strTrailler);

      CloseFile(txtTexto);

      pDeletaCadCbi(strCodBco, strCartei, edtCodPor.Text);

      pBackupCnfBco;

      pVerifica_VirtualUI(strFilePath);

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

	Except
 		On E: Exception Do
		Begin

		  fRollBack;

      Try
        CloseFile(txtTexto);
      Except
        //Caso o erro acontecer após o arquivo já estiver fechado
      End;

      fDeletaArquivoPath(strFilePath);

      FreeAndNil(qryRemessa);
      FreeAndNil(qryConsultaGen);

      Raise Exception.Create('Ocorreu um erro ao gerar o arquivo de remessa do banco ' + strCodBco + '-' + strNomBco + #13 +
                             'Erro gerado: ' + E.Message);
		End;
  End;
end;

procedure TfrmExpArqRemSBCredito.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemSBCredito.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmExpArqRemSBCredito.fraPathRemessabtnOpenDirectoryClick(
  Sender: TObject);
begin
  inherited;
  fraPathRemessaClick(sender);
  fraPathRemessa.btnOpenDirectoryClick(Sender);

end;

procedure TfrmExpArqRemSBCredito.fraPathRemessaClick(Sender: TObject);
begin
  fraPathRemessa.DefaultFolder := fraPathRemessa.edtDirectory.text;
  inherited;
end;

procedure TfrmExpArqRemSBCredito.fraPathRemessaEnter(Sender: TObject);
begin
  inherited;
  pShowHint;
end;

procedure TfrmExpArqRemSBCredito.pShowHint;
begin
  HintControler.ShowHint(Self.Left + fraPathRemessa.Left,
                         Self.Top + fraPathRemessa.Top,
                         'Atenção',
                         'Para navegar em outros diretórios'+ #13 +
                         'altere o conteúdo deste campo.');
end;

procedure TfrmExpArqRemSBCredito.pHideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmExpArqRemSBCredito.fraPathRemessaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmExpArqRemSBCredito.fraPathRemessaMouseEnter(Sender: TObject);
begin
  inherited;
  pShowHint;
end;

procedure TfrmExpArqRemSBCredito.fraPathRemessaMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

function TfrmExpArqRemSBCredito.fRetEmpresa: String;
  Var
    intCount  : Integer;
    arrResult : Array Of String;
    qryCadEmp : TUniQuery;

Begin

  qryCadEmp := fCriaQuery(Self);

  qryCadEmp.Close;
  qryCadEmp.SQL.Clear;
  qryCadEmp.SQL.Add('SELECT * FROM CADEMP');
  qryCadEmp.SQL.Add('ORDER BY EMP_CODEMP ');
  qryCadEmp.Open;
  qryCadEmp.First;

  SetLength(arrResult, qryCadEmp.RecordCount);
  intCount := 0;

  While Not qryCadEmp.Eof Do
  Begin
    arrResult[intCount] := fStrZero(qryCadEmp.FieldByName('EMP_CODEMP').AsString, 3) + ' - ' + qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
    qryCadEmp.Next;
    Inc(intCount);
  End;

  intCount := 1;

  If Length(arrResult) > 1 Then
    intCount := fGetMenu('Selecione a Empresa', arrResult, 0);


  Result   := LeftStr(arrResult[intCount -1], 3);

  FreeAndnil(qryCadEmp);
end;

function TfrmExpArqRemSBCredito.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemSBCredito.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemSBCredito.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
end;

procedure TfrmExpArqRemSBCredito.fraPathRemessaedtDirectoryChange(Sender: TObject);
begin
//  //#Asimov#
//  Revisar Eventos: //fraPathRemessaClick;
//                   //fraPathRemessaEnter;
//                   //fraPathRemessaExit;
//                   //fraPathRemessaMouseEnter;
//                   //fraPathRemessaMouseLeave
end;

procedure TfrmExpArqRemSBCredito.fraPathRemessaedtDirectoryEnter(Sender: TObject);
begin
  inherited;
  fraPathRemessaEnter(sender);
end;

procedure TfrmExpArqRemSBCredito.fraPathRemessaedtDirectoryExit(Sender: TObject);
begin
  inherited;
  fraPathRemessaExit(sender);
end;

procedure TfrmExpArqRemSBCredito.fraPathRemessaedtDirectoryMouseEnter(
  Sender: TObject);
begin
  inherited;
  fraPathRemessaMouseEnter(sender);
end;

procedure TfrmExpArqRemSBCredito.fraPathRemessaedtDirectoryMouseLeave(
  Sender: TObject);
begin
  inherited;
  fraPathRemessaMouseLeave(sender);
end;

end.
