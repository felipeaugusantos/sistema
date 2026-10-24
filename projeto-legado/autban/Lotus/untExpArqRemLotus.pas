unit untExpArqRemLotus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus, untFrameCheckComboBoxEmpresa,untFuncAutban, untGravando,
  System.DateUtils,untTIntegracaoExtrant,Data.DB,cxProgressBar;

Type
  TDadosExtrant = Record
    FQueryRemessa: TUniQuery;
    FAutoIncremRemGer: String;
  End;


type
  TfrmExpArqRemLotus = class(TfrmPai)
    pnlFundo: TPanel;
    lblPathRemessa: TLabel;
    lblNomArq: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    Label1: TLabel;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    btnGerar: TBitBtnLocked;
    fraPathRemessa: TfraDirectoryEditFocus;
    fraCheckComboBoxEmpresa: TfraCheckComboBoxEmpresa;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    qryConsultaGen : TUniQuery;
    qryCadPor   : TUniQuery;

    function fRetEmpresa: String;

    { Private declarations }
  public
    { Public declarations }
    strSimDes: String;
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemLotus: TfrmExpArqRemLotus;

implementation

uses untFuncoes, untfuncoesSimples, untConsultas,
     untTypesSistema, untConstantes, untLogCtr, untAtualizaOcorrenciasCRM, untTypesCRM;

{$R *.dfm}

procedure TfrmExpArqRemLotus.FormShow(Sender: TObject);
  Var
    LVariante : String;
begin
  inherited;

  strSimDes := fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'TIPCOBR','');
  LVariante := fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'VARNOMREM','');


  If fEmptyStr(strSimDes) Then
    strSimDes := 'S';

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'PATHREM',''));

  If strSimDes = 'S' Then
  Begin

    If fEmptyStr(LVariante) Then
      LVariante := 'A' + IntToStr(intCartei);

    edtNomArquivo.Text  := 'CB' +
                           fStrZero(FormatDateTime('dd',VS_Date),2) +
                           fStrZero(FormatDateTime('mm',VS_Date),2) + LVariante  + '.REM';
  End
  Else
  Begin
    edtNomArquivo.Text  := 'DS' +
                           fStrZero(FormatDateTime('dd',VS_Date),2) +
                           fStrZero(FormatDateTime('mm',VS_Date),2) + 'A' + IntToStr(intCartei) + '.REM';
  End;

  If (fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'DSNAME','') = 'S') Then
  Begin
    edtNomArquivo.Text := 'COBN_' + fPadL(fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'CODEMPR', ''),07)+ '.REM';
  End;


  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemLotus.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strNomEmp   : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaEmi   : String;
    strKeyDup   : String;
    strNumDup   : String;
    strCgcEmp   : String;
    strCgcCli   : String;
    strCodRem   : String;
    strCpfCgc   : String;
    strEmpBco   : String;
    strNumAut   : String;
    strCodAge   : String;
    strCntCor   : String;
    strDigCnt   : String;
    strIdeEmp   : String;
    strCodCar   : String;
    strDiaPro   : String;
    strInstru1  : String;
    strObserv   : String;
    strEmpAgr   : String;
    strCodCli   : String;
    strUsaSac   : String;

    strHeader   : String;
    strTransacao: String;
    strTrans2   : String;
    strTrailler : String;
    strTrans7   : String;

    intCodSeq   : Integer;
    fltValAtr   : Double;
    txtTexto    : TextFile;
    strRespon   : String;
    strNosNum   : String;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    strEnvMsg   : String;
    strObsAgr   : WideString;
    strCartSeq  : String;
    strBenefi,
    strSacAva,
    strSacEnd,
    strSacCEP,
    strSacCid,
    strSacEst   : String;
    strCartei: String;
    strCcDigito : String;
    strCodOco   : String;

    fltPerMul   : Double;

    qryRemessa  : TUniQuery;

    strFilePath : String;
    strAutoIncremRem: String;

    fltValDup : Double;

    fltValDpo       : Double;
    strDtaDpo       : String;
    dtaDtaDpo       : TDateTime;
    blnUsaCnd       : Boolean;
    blnUsaDesPonCli : Boolean;
    blnUsaDesPon    : Boolean;
    strchkcbEmp     : String;
    AstrEndereco    : String;
    LDescontoSugerido : Double;

    LApresentarEspecieDocumento: Boolean;

    strInstruProtestoPers : String;

    procedure pListaDupAgr(strNumAgr: String);
      Var
        qryDupAgr: TUniQuery;
        strSQL   : String;
    Begin

      qryDupAgr := fCriaQuery(Self);
      strObsAgr := '';

      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   CTR_NUMAGR, ';
      strSQL := strSQL + '   CTR_NUMDUP, ';
      strSQL := strSQL + '   CTR_PARCEL, ';
      strSQL := strSQL + '   CTR_ESPDOC, ';
      strSQL := strSQL + '   CTR_CODEMP, ';
      strSQL := strSQL + '   CTR_CODCLI, ';
      strSQL := strSQL + '   CTR_DTACAD, ';
      strSQL := strSQL + '   CTR_VALDUP  ';
      strSQL := strSQL + ' FROM          ';
      strSQL := strSQL + '   DUPAGR      ';
      strSQL := strSQL + ' WHERE         ';
      strSQL := strSQL + '   CTR_NUMAGR = :NUMAGR AND ';
      strSQL := strSQL + '   CTR_EMPAGR = :EMPAGR AND ';
      strSQL := strSQL + '   CTR_CODCLI = :CODCLI ';
      strSQL := strSQL + ' ORDER BY               ';
      strSQL := strSQL + '   CTR_DTACAD, CTR_CODEMP, CTR_ESPDOC, CTR_NUMDUP, CTR_PARCEL ';

      With qryDupAgr Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMAGR').AsString := strNumAgr;
        ParamByName('EMPAGR').AsString := strEmpAgr;
        ParamByName('CODCLI').AsString := strCodCli;
        Open;

        First;

        While Not Eof Do
        Begin
          strObsAgr := strObsAgr + FormatDateTime('dd/mm/yy',FieldByName('CTR_DTACAD').AsDateTime) +
                                 ' DOC:' + FieldByName('CTR_NUMDUP').AsString +
                                 FieldByName('CTR_PARCEL').AsString +
                                 FieldByName('CTR_ESPDOC').AsString +
                                 '-' + FieldByName('CTR_CODEMP').AsString +
                                 ' V:' + FormatFloat('#,##0.00', FieldByName('CTR_VALDUP').AsFloat) + ' ';

          Next;
        End;

      End;

      FreeAndNil(qryDupAgr);

    End;

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
  strNumDup := '';

  If Not fVerificaCampos Then
    Exit;

  If fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
    Exit;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
  Begin
    fMensagem('Path:', 'Diretório inválido p\ exportação.', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  intCodSeq  := 1;
  strCodBco  := '976';
  strNomBco  := 'BRADESCO';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);

  strNumAut  := fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'NUMAUTO', '');
  strCodAge  := fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'CODAGEN', '');
  strEmpBco  := fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'CODEMPR', '');
  strCntCor  := RightStr(fStrZero(fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'NUMCTAC', ''), 7), 7);
  strDigCnt  := fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'CODCART', '');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);

  strInstru1 := fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstruProtestoPers := fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'INSTPER', '');
  strObserv  := fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'OBSERV1', '');
  blnRemLoc  := Not( fGetBancoConfig(0,'CONFIG976', 'RELOCAL', '') = 'N' );
  strEnvMsg  := fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'MANDMSG', '');
  strUsaSac  := fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'SACAVAL', '');
  strBenefi  := fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'NOMEBEN', '');

  LApresentarEspecieDocumento := (fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'ESPDOCBOL', '') = 'S');

  fltPerMul  :=  fStrToFloat ( fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'PERMULT', '') );

  blnUsaCnd := fCfgSis('USACND', VarBoolean);

  If (fCfgSis('DESPON', varBoolean) And (fCfgSis('TDEPON') = '2')) Then
    blnUsaDesPonCli := True
  Else
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

  //*************************************************//
  // SE OCORRER ALGUM ERRO AO RETORNAR O NOME DA     //
  // EMPRESA, ENTAO DA A MENSAGEM E SKIP A EXPORT.   //
  //**********************************************ED*//
  If fEmptyStr( strNomEmp ) Then
  Begin
    fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!',['&Sim','&Não']);
    Exit;
  End;

  strRespon := '1';
  If (fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'RESPONS', '') = 'E') Then
    strRespon := '2';

  If strSimDes = 'S' Then
    strDiaPro := IIF(Pos(strInstru1, '06_05_07_18_') > 0, fStrZero(fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'DIAPROT', ''),2), '00')
  Else
    strDiaPro := '00';

  Try
    fStartTransaction;
    strCartei  := 'CONFIG976-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryConsultaGen := fCriaQuery(qryConsultaGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  E.*,  C.CID_NOMCID, C.CID_ESTADO ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP E ';
    strSQL := strSQL + '  LEFT JOIN CADCID C ON C.CID_CODCID = E.EMP_CODCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryConsultaGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strNovCodEmp;
      Open;
      strCgcEmp := FieldByName('EMP_C_G_C_').AsString;

      If strUsaSac = 'S' Then
      Begin
        strSacAva := fPadL(fTiraCaracEspeciaisPonto(strCgcEmp), 015, '0') + '  ' + fPadR(strNomEmp, 043);
        strSacEnd := fPadR(FieldByName('EMP_ENDERE').AsString + ', ' +
                            FieldByName('EMP_ENDNUM').AsString + ' ' +
                            FieldByName('EMP_BAIRRO').AsString, 045);
        strSacCEP := fPadR(fRetSomenteNumeros(FieldByName('EMP_C_E_P_').AsString), 008, '0');
        strSacCid := fPadR(FieldByName('CID_NOMCID').AsString, 020);
        strSacEst := fPadR(FieldByName('CID_ESTADO').AsString, 002);
      End;

      Close;
    End;

    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';

    //If LUtilizaExtrant Then
   //   strSQL := strSQL + '  FIS_ACESSO, NFE_ARQXML, ';

    strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
    strSQL := strSQL + '  R.CTR_DTAREC AS CTR_DTAREC, C.CLI_PERDPO, C.CLI_QTDDAV, ';
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

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCBI B  ';
    strSQL := strSQL + '  JOIN CADCLI C ON CLI_CODCLI = CBI_CODCLI     ';
    strSQL := strSQL + '  JOIN CADREC R ON CTR_NUMDUP = CBI_NUMDUP AND ';
    strSQL := strSQL + '                   CTR_PARCEL = CBI_PARCEL AND ';
    strSQL := strSQL + '                   CTR_ESPDOC = CBI_ESPDOC AND ';
    strSQL := strSQL + '                   CTR_CODEMP = CBI_CODEMP AND ';
    strSQL := strSQL + '                   CTR_CODCLI = CBI_CODCLI     ';

   {If LUtilizaExtrant Then
    Begin
      strSQL := strSQL + '  LEFT JOIN CADFIS ON FIS_NUMDOC = CTR_NUMDUP AND ';
      strSQL := strSQL + '                      FIS_ESPDOC = CTR_ESPDOC AND ';
      strSQL := strSQL + '                      FIS_CODEMP = CTR_CODEMP AND ';
      strSQL := strSQL + '                      FIS_FORCLI = CTR_CODCLI AND ';
      strSQL := strSQL + '                      FIS_TIP_FC = "C"        AND ';
      strSQL := strSQL + '                      FIS_ORIDOC = "V"            ';
      strSQL := strSQL + '  LEFT JOIN XMLNFE ON FIS_ACESSO = NFE_ACESSO     ';
    End;}

    If blnUsaDesPon Then
      strSQL := strSQL + ' LEFT JOIN CADCND D ON D.CND_CODIGO = B.CBI_CODCND ';

    strSQL := strSQL + 'WHERE                                       ';
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO AND                  ';
    strSQL := strSQL + '  ((CTR_DTAREC IS NULL AND (B.CBI_CODOCO = "01" OR B.CBI_CODOCO = "06" OR B.CBI_CODOCO = "19" OR B.CBI_CODOCO = "20")) OR';
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

      if (fCfgSis('CONREM', varString) = 'C') THEN
        ParamByName('CARTEI').AsString := strCartei;

      If (Not fEmptyStr(edtCodPor.Text)) Then
        ParamByName('CODPOR').AsString := edtCodPor.Text;

      Open;
    End;

    If Not qryRemessa.IsEmpty Then
    Begin
      //Gerando número da remessa e atualizando carteiras "filhas"
      strCartSeq := fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'SEQCART', '');
      strCodRem  := fStrZero(fAtuCodSeq('CONFIG976-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq), 'PROXNUM'), 7);
      pAtualizaProxNumCartsAutBan('CONFIG976-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq));

      strEmpAgr := qryRemessa.FieldByName('CBI_CODEMP').AsString;
      strCodCli := qryRemessa.FieldByName('CBI_CODCLI').AsString;


      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************AF*}
      strHeader := '';

      If strSimDes = 'S' Then
      Begin
        strHeader := fPadR   ('0'                , 001)      + //001
                     fPadR   ('1'                , 001)      + //002
                     fPadR   ('REMESSA'          , 007)      + //003
                     fPadR   ('01'               , 002)      + //010
                     fPadR   ('COBRANCA'         , 015)      + //012
                     fPadL   (strEmpBco          , 020, '0') + //027
                     fPadR   (IIF(strUsaSac <> 'S', strNomEmp, strBenefi), 030)      + //047
                     fPadR   (strCodBco          , 003)      + //077
                     fPadR   (strNomBco          , 015)      + //080
                     fPadR   (strDtaRem          , 006)      + //095
                     fPadR   (' '                , 008)      + //101
                     fPadR   ('MX'               , 002)      + //109
                     fPadR   (strCodRem          , 007)      + //111
                     fPadR   (' '                , 277)      + //118
                     fStrZero('1'                , 006);       //395
      End
      Else
      Begin
        strHeader := fPadR   ('0'                , 001)      + //001
                     fPadR   ('1'                , 001)      + //002
                     fPadR   ('REMESSA'          , 007)      + //003
                     fPadR   ('01'               , 002)      + //010
                     fPadR   ('COBRANCA'         , 015)      + //012
                     fPadL   (strEmpBco          , 020, '0') + //027
                     fPadR   (IIF(strUsaSac <> 'S', strNomEmp, strBenefi), 030)      + //047
                     fPadR   (strCodBco          , 003)      + //077
                     fPadR   (strNomBco          , 015)      + //080
                     fPadR   (strDtaRem          , 006)      + //095
                     fPadR   (' '                , 008)      + //101
                     fPadR   ('MX'               , 002)      + //109
                     fPadR   (strCodRem          , 007)      + //111
                     fPadR   (' '                , 249)      + //118
                     fPadR   ('DESC'             , 004)      + //367
                     fPadR   (strNumAut          , 004)      + //371
                     RightStr(fStrZero(strCodAge, 005), 005) + //375
                     RightStr(fStrZero(strCntCor, 007), 007) + //380
                     fPadR   (strDigCnt          , 001)      + //387
                     fPadR   (' '                , 007)      + //388
                     fStrZero('1'                , 006);       //395
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
      With qryRemessa Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin

          strInstru1 := fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'INSTRU1', '');

          If FieldByName('CBI_PROTES').AsString = 'S' Then
          Begin
             If (Not fEmptyStr(strInstruProtestoPers)) and (strInstruProtestoPers <> '00') Then
                strInstru1 := strInstruProtestoPers;
          End;

          strObserv  := fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'OBSERV1', '');

          //Req 108135
          If (fEmptyStr(strObserv)) And
             (strSimDes = 'S')      And
             (Pos(strInstru1, '06_05_07_18_') > 0) Then
            strObserv := 'PROTESTAR APOS ' + strDiaPro + IIF(StrToInt(strDiaPro) = 1,' DIA ', ' DIAS ') + 'DO VENCIMENTO';

          Inc(intCodSeq);
          Application.ProcessMessages;

          fltValAtr := fFormataFloat((FieldByName('CBI_VALDUP').AsFloat *
                              FieldByName('CBI_PORCEN').AsFloat) / 100, 2);

          If FieldByName('CBI_CGCCPF').AsInteger = 0 Then
            strCpfCgc := '99'
          Else If FieldByName('CBI_CGCCPF').AsInteger = 1 Then
            strCpfCgc := '2'
          Else
            strCpfCgc := '1';

          strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTAVEN').AsDateTime);

          strDtaEmi := FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTACAD').AsDateTime);

          strNumDup := (FieldByName('CBI_NUMDUP').AsString) + FieldByName('CBI_PARCEL').AsString;

          If LApresentarEspecieDocumento Then
            strNumDup := RightStr(strNumDup, strNumDup.Length - 2) + FieldByName('CBI_ESPDOC').AsString;

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

          fltValDup := FieldByName('CBI_VALDUP').AsFloat;

          If fCfgSis('VALIMP', varBoolean) then
          begin
            fltValDup := fltValDup + FieldByName('CTR_JURSUJ').AsFloat +
                                     FieldByName('CTR_DESCOB').AsFloat;
          end;

          LDescontoSugerido := qryRemessa.FieldByName('CBI_DESSUJ').AsFloat;

          If fCfgSis('DESBOL', varBoolean) Then
          Begin
            fltValDup := fFormataFloat((fltValDup - qryRemessa.FieldByName('CTR_DESSUJ').AsFloat),2);
            LDescontoSugerido := 0.00;
          End;

          If blnUsaDesPonCli And blnUsaDesPon Then

          Begin
            fltValDpo := ( ( FieldByName('CBI_VALDUP').AsFloat ) * ( FieldByName('CLI_PERDPO').AsFloat / 100 ) );

            If fltValDpo > 0 Then
            Begin
              dtaDtaDpo := FieldByName('CBI_DTAVEN').AsDateTime - FieldByName('CLI_QTDDAV').AsInteger;
              strDtaDpo := FormatDateTime('ddmmyy', dtaDtaDpo);
            End
            Else
              strDtaDpo := '0';
          End
          Else
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

          {*******************************************}
          {* SE BANCO EMITE BOLETO                   *}
          {****************************************MV*}
          strNosNum := FieldByName('CBI_NOSNUM').AsString;
          If (strRespon = '1') Then
            strNosNum := '0';


          If strSimDes = 'S' Then
          Begin

            strIdeEmp := '0'                    + //021
                         RightStr(fStrZero(strCodCar, 3), 3) + //022
                         RightStr(fStrZero(strCodAge, 5), 5) + //025
                         RightStr(fStrZero(strCntCor, 7), 7) + //030
                         RightStr(fStrZero(strDigCnt, 1), 1);  //037

             strTransacao := fPadR     ('1'                                       , 01)      + //001
                            fStrZero   ('0'                                       , 05)      + //002
                            fStrZero   ('0'                                       , 01)      + //007
                            fStrZero   ('0'                                       , 05)      + //008
                            fStrZero   ('0'                                       , 07)      + //013
                            fStrZero   ('0'                                       , 01)      + //020
                            fPadR      (strIdeEmp                                 , 17)      + //021
                            fPadR      (strKeyDup                                 , 25)      + //038
                            fPadR      ('000'                                     , 03)      + //063
                            fPadR      (IIF(fltPerMul > 0, '2', '0')              , 01)      + //066 (2) P\ CONSIDERAR O PERCENTUAL DE MULTA
                            fValNumForm(fltPerMul                                 , 04)      + //067 PERCENTUAL DE MULTA A SER CONSIDERADO
                            fStrZero   (strNosNum                                 , 12)      + //071
                            fStrZero   ('0'                                       , 10)      + //083
                            fPadR      (strRespon                                 , 01)      + //093
                            fPadR      (' '                                       , 01)      + //094
                            fPadR      (' '                                       , 10)      + //095
                            fPadR      (' '                                       , 01)      + //105
                            fPadR      ('2'                                       , 01)      + //106
                            fPadR      (' '                                       , 02)      + //107
                            fPadR      (strCodOco                                 , 02)      + //109
                            fPadR      (RightStr(strNumDup, 10)                   , 10)      + //111
                            fPadR      (strDtaVen                                 , 06)      + //121
                            fValNumForm(fltValDup                                 , 13)      + //127
                            fStrZero   ('0'                                       , 03)      + //140
                            fStrZero   ('0'                                       , 05)      + //143
                            fPadR      ('01'                                      , 02)      + //148
                            fPadR      ('N'                                       , 01)      + //150
                            fPadR      (strDtaEmi                                 , 06)      + //151
                            fPadR      (strInstru1                                , 02)      + //157
                            fPadR      (strDiaPro                                 , 02)      + //159
                            fValNumForm(fltValAtr                                 , 13)      + //161
                            fPadR(IIF(fltValDpo > 0,strDtaDpo,IIF(LDescontoSugerido > 0,strDtaVen, '0')), 06,'0')  + //174
                            IIF(fltValDpo > 0, fValNumForm(fltValDpo, 13), fValNumForm(LDescontoSugerido, 13))     + //180
                            fStrZero   ('0'                                       , 13)      + //193
                            fStrZero   ('0'                                       , 13)      + //206
                            fStrZero   (strCpfCgc                                 , 02)      + //219
                            fPadL      (strCgcCli                                 , 14, '0') + //221
                            fPadR      (FieldByName('CLI_NOMCLI').AsString        , 40)      + //235
                            fPadR      (AstrEndereco                              , 40)      + //275
                            fPadR      (' '                                       , 12)      + //315
                            fPadL      (LeftStr(FieldByName('C_E_P_').AsString,5) , 05, '0') + //327
                            fPadL      (RightStr(FieldByName('C_E_P_').AsString,3), 03, '0') + //332
                            fPadR      (IIF(strUsaSac = 'S', strSacAva,
                                                             strObserv)           , 60)      + //335
                            fStrZero   (IntToStr(intCodSeq)                       , 06);       //395

            {******************************}
            {* ESCREVE A TRANSACAO NO TXT *}
            {***************************AF*}
            Writeln(txtTexto,strTransacao);

          End
          Else
          Begin

            strIdeEmp := '0000'                 + //021
                         '070'                  + //022
                         fStrZero(strCodAge, 5) + //025
                         fStrZero(strCntCor, 7) + //030
                         fStrZero(strDigCnt, 1);  //037

            strTransacao := fPadR      ('1'                                       , 01)      + //001
                            fStrZero   ('02'                                      , 02)      + //002
                            fStrZero   (strCgcEmp                                 , 14)      + //004
                            fStrZero   (strIdeEmp                                 , 20)      + //018
                            fPadR      (' '                                       , 25)      + //038
                            fStrZero   ('0'                                       , 08)      + //063
                            fStrZero   ('0'                                       , 12)      + //071
                            fStrZero   ('0'                                       , 10)      + //083
                            fPadR      (' '                                       , 16)      + //093
                                        '11'                                                 + //109
                            fPadR      (RightStr(strNumDup, 10)                   , 10)      + //111
                            fPadR      (strDtaVen                                 , 06)      + //121
                            fValNumForm(fltValAtr                                 , 13)      + //127
                            fPadR      (' '                                       , 08)      + //140
                                        '01'                                                 + //148
                            fPadR      (' '                                       , 01)      + //150
                            fStrZero   ('0'                                       , 68)      + //151
                            fStrZero   (strCpfCgc                                 , 02)      + //219
                            fPadL      (strCgcCli                                 , 14, '0') + //221
                            fPadR      (FieldByName('CLI_NOMCLI').AsString        , 40)      + //235
                            fPadR      (AstrEndereco                              , 40)      + //275
                            fPadR      (' '                                       , 12)      + //315
                            fPadL      (LeftStr(FieldByName('C_E_P_').AsString,5) , 05, '0') + //327
                            fPadL      (RightStr(FieldByName('C_E_P_').AsString,3), 03, '0') + //332
                            fPadR      (IIF(strUsaSac = 'S', strSacAva,
                                                             strObserv)           , 60)      + //335
                            fStrZero   (IntToStr(intCodSeq)                       , 06);       //395

            {******************************}
            {* ESCREVE A TRANSACAO NO TXT *}
            {***************************AF*}
            Writeln(txtTexto,strTransacao);

          End;

          strTrans2 := '';

          If (strEnvMsg = 'S') And
             (FieldByName('CBI_ESPDOC').AsString = 'AG') And
             (strRespon = '1') Then
          Begin

            Inc(intCodSeq);

            pListaDupAgr(FieldByName('CBI_NUMDUP').AsString);
            strCcDigito := strCntCor + strDigCnt;

            strTrans2 := '2'                                + //001 - 001
                         fPadR(strObsAgr             , 320) + //002 - 321
                         fPadR('0' , 006             , '0') + //322 - 327
                         fPadL('0' , 013             , '0') + //328 - 340
                         fPadR('0' , 006             , '0') + //341 - 346
                         fPadL('0' , 013             , '0') + //347 - 359
                         fPadR(' '                   , 007) + //360 - 366
                         fPadL(strCodCar, 003        , '0') + //367 - 369
                         fPadL(strCodAge, 005        , '0') + //370 - 374
                         fPadL(strCcDigito, 008      , '0') + //375 - 382
                         fPadL(strNosNum, 012        , '0') + //383 - 394
                         fStrZero(IntToStr(intCodSeq), 06);   //395 - 400

            Writeln(txtTexto,strTrans2);
          End;

          {************************************}
          {* QUANDO UTILIZAR SACADOR/AVALISTA *}
          {*********************************AJ*}
          If strUsaSac = 'S' Then
          Begin
            Inc(intCodSeq);

            strTrans7 := fPadR('7'                    , 001) + //001 - 001
                         fPadR(strSacEnd              , 045) + //001 - 046
                         fPadL(strSacCep, 008         , '0') + //047 - 054
                         fPadR(strSacCid              , 020) + //055 - 074
                         fPadR(strSacEst              , 002) + //075 - 076
                         fPadL(' '                    , 290) + //077 - 366
                         fPadL(strCodCar, 003         , '0') + //367 - 369
                         fPadL(strCodAge, 005         , '0') + //370 - 374
                         RightStr(fStrZero(strCntCor, 7), 7) +
                         RightStr(fStrZero(strDigCnt, 1), 1) +
                         fPadL(strNosNum, 012         , '0') + //383 - 394
                         fStrZero(IntToStr(intCodSeq) , 006);  //395 - 400
            Writeln(txtTexto,strTrans7);
          End;

          {*****************************}
          {* GRAVAÇÃO DA TABELA REMDET *}
          {**** DETALHES DA REMESSA ****}
          {**************************MO*}
          pGravaRemDet(strAutoIncremRem,
                       FieldByName('AUTOINCREM').AsString,
                       strNosNum,
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
      Writeln(txtTexto,strTrailler);

      CloseFile(txtTexto);

{      fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                   'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);
 }

      pDeletaCadCbi(strCodBco, strCartei, edtCodPor.Text);

      pBackupCnfBco;

      If fCommit then
      Begin
        {*******************************************}
        {* GRAVA A TABELA LOGCTR FORA DA TRANSAÇÃO *}
        {* POIS ESTAVA CAUSANDO TIMEOUT EM OUTRAS  *}
        {* ROTINAS DO SISTEMA.                     *}
        {*REQ*145737*****************************RP*}
        pGravaLogctr;

			  fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
					        'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);

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

procedure TfrmExpArqRemLotus.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemLotus.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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
        Self.SelectNext((Sender As TWinControl), True, True);
    End;
  End;
end;

function TfrmExpArqRemLotus.fRetEmpresa: String;
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
    SQL.Add('SELECT * FROM CADEMP ');
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
  {**************}
  {* 14/01/2011 *}
  {***********RV*}
  intCount := 1;

  If Length(arrResult) > 1 Then
    intCount := fGetMenu('Selecione a Empresa', arrResult, 0);

  Result   := LeftStr(arrResult[intCount -1], 3);

  FreeAndNil(qryCadEmp);
end;

function TfrmExpArqRemLotus.fValidaCampos(Sender: TWinControl;
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


procedure TfrmExpArqRemLotus.FormCreate(Sender: TObject);
begin
  inherited;
   qryCadPor := fCriaQuery(Self); 
end;

end.
