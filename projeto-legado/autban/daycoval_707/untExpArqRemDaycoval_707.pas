unit untExpArqRemDaycoval_707;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit,  cxTextEdit, cxMaskEdit,
  cxButtonEdit, DateUtils, untTCadRec, untTCadRecRepository, FilenameEditFocus,
  cxClasses, cxShellBrowserDialog,
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemDaycoval_707 = class(TfrmPai)
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
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private

    qryConsultaGen : TUniQuery;
    qryCadPor      : TUniQuery;
    fltPerMul   : Double;
    blnVirtualUI: Boolean;

    //Carteira
    strCartei    : String;
    blnUsaDesPon : Boolean;
    blnUsaCnd    : Boolean;
    blnDesPon    : Boolean;
    strNomEmp    : String;
    strCodBco    : String;
    qryRemessa   : TUniQuery;
    strInstru1   : String;
    strInstru2   : String;
    strMsg1      : String;
    strMsg2      : String;
    strMsg3      : String;
    strObsAgru   : String;
    strCodFlash  : String;
    fltValDup    : Double;
    fltValDpo    : Double;
    strDtaDpo    : String;
    //end;

    function fRetEmpresa: String;
    function fRetSequencialDiaArquivo: Integer;
    function fValidacoesParaExportacao : Boolean;
    function fGetSqlRemessa : String;
    function fCriarQueryRemessa:TUniQuery;
    procedure pValidaInformacoesRemessa;
    procedure pGravaLogctr;
    procedure pApagaCADCBI;
    function fMenssagemNoBoleto : Boolean;
    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;

  end;

var
  frmExpArqRemDaycoval_707: TfrmExpArqRemDaycoval_707;

implementation

uses untFuncoes, untFuncoesSimples, untFuncAutBan, DB, untTypesSistema, untConsultas,
     untConstantes, untLogCtr;

{$R *.dfm}

procedure TfrmExpArqRemDaycoval_707.FormShow(Sender: TObject);
  Var
    FPrefixo : String;
begin
  inherited;
  FPrefixo := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(intCartei), 'NOMPREF','') ;
  FPrefixo := IIF(fEmptyStr(FPrefixo),'2HY',FPrefixo);


  fraPathRemessa.edtDirectory.Text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG707-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  :=  FPrefixo +
                          FormatDateTime('dd', VS_Date) +
                          FormatDateTime('mm', VS_Date) +
                          fRetSequencialDiaArquivo.ToString() +
                         '.TXT';
  pSetFocus(edtCodPor);

  fraPathRemessa.edtDirectory.Enabled  := Not blnVirtualUI;
  lblPathRem.Enabled      := Not blnVirtualUI;
end;

procedure TfrmExpArqRemDaycoval_707.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strNomBco   : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaMor   : String;
    strDtaEmi,
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
    strDiaPro   : String;
    strCep      : String;
    strHeader   : String;
    strTransacao: String;
    strMensagem : String;
    strMsgLin1  : String;
    strMsgLin2  : String;
    strMsgLin3  : String;
    strValDup   : String;
    strNumDup   : String;
    strTrailler : String;
    strCartSeq  : String;
    strPagador  : String;
    strEndPagador: String;
    strIdenBan  : String;
    strNota     : String;
    strEndereco : String;
    intCodSeq   : Integer;
    txtTexto    : TextFile;
    strFilePath : String;
    strAutoIncremRem: String;
    fltValAtr : Double;
begin
  inherited;

  If Not fValidacoesParaExportacao Then
    Exit;

  strCodBco  := '707';
  strNomBco  := 'BANCO DAYCOVAL';
  strCodAgen := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(intCartei), 'CODAGEN', '');
  strContCor := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(intCartei), 'NUMCTAC', '');
  strDigCnt  := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(intCartei), 'NUMCART', '');
  strDigCar  := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(intCartei), 'CODCART', '');
  strDiaPro  := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(intCartei), 'DIAPROT', '');
  strIdenBan := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(intCartei), 'IDENTBC', '');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);
  fltPerMul  :=  fStrToFloat ( fGetBancoConfig(0, 'CONFIG707-' + IntToStr(intCartei), 'PERMULT', '0') );

  blnUsaCnd := fCfgSis('USACND', VarBoolean);
  blnDesPon := fCfgSis('DESPON', VarBoolean);

  blnUsaDesPon := IIF(blnDesPon,True,False);


  Try
    fStartTransaction;

    qryConsultaGen := fCriaQuery(qryConsultaGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMP_C_G_C_, ';
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
    qryConsultaGen.Close;


    strCartei := 'CONFIG707-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriarQueryRemessa;

    If Not qryRemessa.IsEmpty Then
    Begin
      //Gerando número da remessa e atualizando carteiras "filhas"
      strCodRem  := fStrZero(fAtuCodSeq('CONFIG707-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq), 'PROXNUM'), 7);
      AssignFile(txtTexto, fraPathRemessa.edtDirectory.Text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.Text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************AF*}
      intCodSeq := 1;
      strHeader := '';
      strHeader := fPadR   ('0'                , 001) + //001 001
                   fPadR   ('1'                , 001) + //002 002
                   fPadR   ('REMESSA'          , 007) + //003 009
                   fPadR   ('01'               , 002) + //010 011
                   fPadR   ('COBRANCA'         , 015) + //012 026
                   fPadR   (strIdenBan         , 020) + //027 046
                   fPadR   (strNomEmp          , 030) + //047 076
                   fPadR   (strCodBco          , 003) + //077 079
                   fPadR   (strNomBco          , 015) + //080 094
                   fPadR   (strDtaRem          , 006) + //095 100
                   fPadR   (' '                , 294) + //101 394
                   fStrZero(IntToStr(intCodSeq), 006);  //395 400

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************AF*}
      Writeln(txtTexto,fRetirarCaracteresEspeciais(strHeader));

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, '707', StrCartei, StrToInt(strCodRem), strAutoIncremRem);

    {************************}
    {* TRANSAÇÃO DO ARQUIVO *}
    {*********************AF*}
      strTransacao := '';

      While Not qryRemessa.Eof Do
      Begin
        strObsAgru  := '';
        strCodFlash := '';
        strMsg1     := '';
        strMsg2     := '';
        strMsg3     := '';
        Inc(intCodSeq);
        Application.ProcessMessages;

        strCpfCgc := IIF((qryRemessa.FieldByName('CBI_CGCCPF').AsInteger = 1),'2','1');

        strObsAgru := IIF((fGetBancoConfig(0, 'CONFIG707-' + IntToStr(intCartei), 'ENVDUPAG', '') = 'S') AND
                         (qryRemessa.FieldByName('CBI_ESPDOC').AsString = 'AG'),'REF:_' + Copy(qryRemessa.FieldByName('CBI_OBSAG1').AsString,11,23),strObsAgru);

        strInstru1 := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(intCartei), 'INSTRU1', '0');
        strInstru2 := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(intCartei), 'INSTRU2', '0');

        pValidaInformacoesRemessa;

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
                                    StrToInt(fGetBancoConfig(0, 'CONFIG707-' + IntToStr(intCartei), 'DIAMORA', '')));

        strDtaEmi := FormatDateTime('dd',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime) +
                     FormatDateTime('mm',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime) +
                     FormatDateTime('yy',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime);

        strKeyDup := qryRemessa.FieldByName('CBI_NUMDUP').AsString +
                     qryRemessa.FieldByName('CBI_PARCEL').AsString +
                     qryRemessa.FieldByName('CBI_ESPDOC').AsString +
                     qryRemessa.FieldByName('CBI_CODEMP').AsString +
                     qryRemessa.FieldByName('CBI_CODCLI').AsString;

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

       if not TEspecieParaArquivoRemessa.New.fValidaEspecie(qryRemessa.FieldByName('CBI_ESPDOC').AsString) then
        begin
          fRollBack;
          CloseFile(txtTexto);
          If FileExists(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text) Then
            DeleteFile(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
          Exit;
        end;


        fltValDup   := qryRemessa. FieldByName('CBI_VALDUP').AsFloat;

        //AJUSTANDO ENDEREÇO PARA FICAR COMPLETO DENTRO DE 40 CARACTERES
        strEndereco := RetornaEnderecoENumeroCom40Caracteres(qryRemessa.FieldByName('ENDERE').AsString, qryRemessa.FieldByName('NUMERO').AsString);

        fltValAtr := fFormataFloat((qryRemessa.FieldByName('CBI_VALDUP').AsFloat *
                                    qryRemessa.FieldByName('CBI_PORCEN').AsFloat) / 100, 2);

        strTransacao := fPadR      ('1'                                                                    , 01)      + //001
                        fPadR      ('02'                                                                   , 02)      + //002
                        fPadL      (strCgcEmp                                                              , 14, '0') + //004
                        fPadR      (strIdenBan                                                             , 20)      + //018
                        fPadR      (strKeyDup                                                              , 25)      + //038
                        fPadR      (RightStr(fStrZero(qryRemessa.FieldByName('CBI_NOSNUM').AsString,9)  ,9), 08, '0') + //063
                        fPadR      (' '                                                                    , 13)      + //071
                        fPadR      (' '                                                                    , 24)      + //084
                        fPadR      ('6'                                                                    , 01)      + //108
                        fPadR      (strInstru1                                                             , 02)      + //109
                        fPadR      (RightStr(qryRemessa.FieldByName('CBI_NUMDUP').AsString, 09) + qryRemessa.FieldByName('CBI_PARCEL').AsString, 10) + //111
                        fPadR      (strDtaVen                                                              , 06)      + //121
                        fValNumForm(fltValDup                                                              , 13)      + //127
                        fPadR      (strCodBco                                                              , 03)      + //140
                        fStrZero   ('0'                                                                    , 05)      + //143
                        fPadR      ('01'                                                                   , 02)      + //148
                        fPadR      ('N'                                                                    , 01)      + //150
                        fPadR      (strDtaEmi                                                              , 06)      + //151
                        fPadR      ('00'                                                                   , 02)      + //157
                        fPadR      ('00'                                                                   , 02)      + //159
                        fValNumForm(fltValAtr                                                              , 13)      + //161
                        fPadR(IIF(fltValDpo > 0,strDtaDpo,IIF(qryRemessa.FieldByName('CBI_DESSUJ').AsFloat > 0,strDtaVen, '0')), 06,'0')  + //174
                        IIF(fltValDpo > 0, fValNumForm(fltValDpo, 13), fValNumForm(qryRemessa.FieldByName('CBI_DESSUJ').AsFloat, 13))     + //180
                        fStrZero   ('0'                                                                    , 13)      + //193
                        fStrZero   ('0'                                                                    , 13)      + //206
                        fStrZero   (strCpfCgc                                                              , 02)      + //219
                        fPadL      (strCgcCli                                                              , 14, '0') + //221
                        fPadR      (qryRemessa.FieldByName('CLI_NOMCLI').AsString                          , 30)      + //235
                        fPadR      (' '                                                                    , 10)      + //265
                        fPadR      (strEndereco                                                            , 40)      + //275
                        fPadR      (qryRemessa.FieldByName('BAIRRO').AsString                              , 12)      + //315
                        fPadR      (strCep                                                                 , 08, '0') + //327
                        fPadR      (qryRemessa.FieldByName('CIDADE').AsString                              , 15)      + //335
                        fPadR      (qryRemessa.FieldByName('ESTADO').AsString                              , 02)      + //350
                        fPadR      (strNomEmp                                                              , 30)      + //352
                        fPadR      (' '                                                                    , 04)      + //382
                        fPadR      (' '                                                                    , 06)      + //386
                        fStrZero   (strDiaPro                                                              , 02)      + //392
                        fPadR      ('0'                                                                    , 01)      + //394
                        fStrZero   (IntToStr(intCodSeq)                                                    , 06);       //395

        {******************************}
        {* ESCREVE A TRANSACAO NO TXT *}
        {***************************AF*}
        Writeln(txtTexto,fRetirarCaracteresEspeciais(strTransacao));

        If Not fEmptyStr(qryRemessa.FieldByName('NFE_ACESSO').AsString) Then
        Begin
          Inc(intCodSeq);

          strNota   := qryRemessa.FieldByName('GER_NUMDOC').AsString + '-' + qryRemessa.FieldByName('GER_SERIE_').AsString;
          strDtaEmi := FormatDateTime('ddmmyyyy', qryRemessa.FieldByName('GER_DTADOC').AsDateTime);

          strMensagem  := fPadR('4'                                                       , 001) + // 001 - 001
                          fPadR(strNota                                                   , 015) + // 002 - 016
                          fValNumForm(fltValDup                                           , 013) + // 017 - 029
                          fPadR(strDtaEmi                                                 , 008) + // 030 - 037
                          fPadR(qryRemessa.FieldByName('NFE_ACESSO').AsString             , 044) + // 038 - 081
                          fPadR(' '                                                       , 313) + // 082 - 394
                          fPadL(IntToStr(intCodSeq)                                   , 06, '0');  // 395 - 400

          Writeln(txtTexto,fRetirarCaracteresEspeciais(strMensagem));
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


          strValDup := FormatFloat('#,##0.00', qryRemessa.FieldByName('CBI_VALDUP').AsFloat);
          strNumDup := IntToStr(StrToInt64(qryRemessa.FieldByName('CBI_NUMDUP').AsString)) + qryRemessa.FieldByName('CBI_PARCEL').AsString;
          strDtaVen := FormatDateTime('dd/mm/yyyy', qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime);
          strDtaEmi := FormatDateTime('dd/mm/yyyy', qryRemessa.FieldByName('CBI_DTACAD').AsDateTime);
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
          Writeln(txtTexto,fRetirarCaracteresEspeciais(strMensagem));

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
          Writeln(txtTexto,fRetirarCaracteresEspeciais(strMensagem));
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
      Writeln(txtTexto,fRetirarCaracteresEspeciais(strTrailler));

      CloseFile(txtTexto);

      pApagaCADCBI;

      If fCommit then
      Begin
		    fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
				          IIF(Not blnVirtualUI, 'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.Text + edtNomArquivo.Text, ''), ['&O K']);
        {*******************************************}
        {* GRAVA A TABELA LOGCTR FORA DA TRANSAÇÃO *}
        {* POIS ESTAVA CAUSANDO TIMEOUT EM OUTRAS  *}
        {* ROTINAS DO SISTEMA.                     *}
        {*REQ*145737*****************************RP*}
        pGravaLogctr;
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

procedure TfrmExpArqRemDaycoval_707.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS'
  Else
  Begin
    edtDesPor.Text := fRetNomPortador(edtCodPor.Text);

    If Not CarregaPortador(edtCodPor.Text) Then
       pSetFocus(edtCodPor)
    Else
    If fEmptyStr(edtDesPor.Text) Then
    Begin
      fMensagem('', 'Portador não cadastrado!', ['&Ok']);
      pSetFocus(edtCodPor);
    End
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
      Begin
        fMensagem('', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&Ok']);
        pSetFocus(edtCodPor);
      End;
    End;

  End;

end;

procedure TfrmExpArqRemDaycoval_707.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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
      Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

function TfrmExpArqRemDaycoval_707.fCriarQueryRemessa: TUniQuery;
begin
  Result := Nil;
  Try
    Result:= fCriaQuery(Self);
    Result.Close;
    Result.SQL.Clear;
    Result.SQL.Add(fGetSqlRemessa);
    Result.ParamByName('CODBCO').AsString := '707';

    If (Not fEmptyStr(edtCodPor.Text)) Then
      Result.ParamByName('CODPOR').AsString := edtCodPor.Text;

    if (fCfgSis('CONREM', varString) = 'C') THEN
      Result.ParamByName('CARTEI').AsString := strCartei;

    Result.Open;
  Except
  On E: Exception Do
   Begin
     pMensagensErro(E.Message, '[TfrmExpArqRemDaycoval_707.fCriarQueryRemessa]');
   End;
  End
end;

function TfrmExpArqRemDaycoval_707.fGetSqlRemessa: String;
  Var
    strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  B.*, ';
  strSQL := strSQL + '  C.CLI_NOMCLI, ';
  strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
  strSQL := strSQL + '  R.CTR_DTAREC AS CTR_DTAREC, ';
  strSQL := strSQL + '  R.CTR_DESCOB AS CTR_DESCOB, ';
  strSQL := strSQL + '  R.CTR_JURSUJ AS CTR_JURSUJ, ';
  strSQL := strSQL + '  G.GER_DTADOC, ';
  strSQL := strSQL + '  G.GER_NUMDOC, ';
  strSQL := strSQL + '  G.GER_SERIE_, ';
  strSQL := strSQL + '  L.NFE_ACESSO, ';
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
  strSQL := strSQL + '  LEFT JOIN LOGNFE L ON L.NFE_NUMDOC = B.CBI_NUMDUP AND ';
  strSQL := strSQL + '                        L.NFE_ESPDOC = B.CBI_ESPDOC AND ';
  strSQL := strSQL + '                        L.NFE_CODEMP = B.CBI_CODEMP AND ';
  strSQL := strSQL + '                        L.NFE_CODCLI = B.CBI_CODCLI AND ';
  strSQL := strSQL + '                        L.NFE_TIP_FC = "C" ';
  strSQL := strSQL + '  LEFT JOIN CTRCNF F ON F.CTR_DOCCNF = R.CTR_NUMDUP AND ';
  strSQL := strSQL + '                        F.CTR_ESPCNF = R.CTR_ESPDOC AND ';
  strSQL := strSQL + '                        F.CTR_EMPCNF = R.CTR_CODEMP AND ';
  strSQL := strSQL + '                        F.CTR_CODCLI = R.CTR_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN MOVGER G ON G.GER_NUMDOC = R.CTR_NUMDUP AND ';
  strSQL := strSQL + '                        G.GER_ESPDOC = R.CTR_ESPDOC AND ';
  strSQL := strSQL + '                        G.GER_CODEMP = R.CTR_CODEMP AND ';
  strSQL := strSQL + '                        G.GER_CODCLI = R.CTR_CODCLI ';

  If blnUsaDesPon Then
    strSQL := strSQL + ' LEFT JOIN CADCND D ON D.CND_CODIGO = B.CBI_CODCND  ';


  strSQL := strSQL + 'WHERE                                                 ';
  strSQL := strSQL + '  CBI_CODBCO = :CODBCO AND                            ';
  strSQL := strSQL + '  R.CTR_DTAREC IS NULL                                ';

  If (Not fEmptyStr(edtCodPor.Text)) Then
    strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR ';

  if (fCfgSis('CONREM', varString) = 'C') THEN
    strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';

  strSQL := strSQL + '  GROUP BY R.AUTOINCREM ';

  Result := strSQL;
end;

function TfrmExpArqRemDaycoval_707.fRetEmpresa: String;
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

  SetLength(arrResult,  qryCadEmp.RecordCount);
  intCount := 0;

  While Not qryCadEmp.Eof Do
  Begin
    arrResult[intCount] := fStrZero( qryCadEmp.FieldByName('EMP_CODEMP').AsString, 3) + ' - ' +  qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
     qryCadEmp.Next;
    Inc(intCount);
  End;

  intCount := 1;

  If Length(arrResult) > 1 Then
    intCount := fGetMenu('Selecione a Empresa', arrResult, 0);

  Result   := LeftStr(arrResult[intCount -1], 3);

  FreeAndnil(qryCadEmp);
end;


function TfrmExpArqRemDaycoval_707.fRetSequencialDiaArquivo: Integer;
var
  qryCons: TUniQuery;
begin
  qryCons := fCriaQuery();
  qryCons.Sql.Clear;
  qryCons.Sql.Text := ' SELECT * FROM REMGER WHERE ' +
                      '   GER_CODBCO = :CODBCO AND ' +
                      '   GER_CODEMP = :CODEMP AND ' +
                      '   GER_CARTEI = :CARTEI AND ' +
                      '   GER_DTACAD = :DTACAD ';

  qryCons.ParamByName('CODBCO').AsString := '707';
  qryCons.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryCons.ParamByName('CARTEI').AsString := 'CONFIG707-' + IntToStr(intCartei)+ '-' + VS_strCodEmp;
  qryCons.ParamByName('DTACAD').AsDateTime := VS_Date;

  qryCons.Open;

  Result := qryCons.RecordCount + 1;

  FreeAndNil(qryCons);
end;

function TfrmExpArqRemDaycoval_707.fValidacoesParaExportacao: Boolean;
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
  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG707', 'RELOCAL', '') = 'N' );

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

procedure TfrmExpArqRemDaycoval_707.pApagaCADCBI;
  Var
   qryAux : TUniQuery;
   strSQL : String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  CADCBI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + 'CBI_CODBCO = :CODBCO ';
    If (Not fEmptyStr(edtCodPor.Text)) Then
      strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR ';
    if (fCfgSis('CONREM', varString) = 'C') THEN
       strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';

    qryAux := fCriaQuery(Self);
    Try
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(strSQL);
      qryAux.ParamByName('CODBCO').AsString := strCodBco;

      If (Not fEmptyStr(edtCodPor.Text)) Then
        qryAux.ParamByName('CODPOR').AsString := edtCodPor.Text;

      if (fCfgSis('CONREM', varString) = 'C') THEN
         qryAux.ParamByName('CARTEI').AsString := StrCartei;

      qryAux.ExecSQL;
      qryAux.Close;
    Except
    On E: Exception Do
      Begin
         pMensagensErro(E.Message, '[TfrmExpArqRemDaycoval_707.pApagaCADCBI]');
      End;
    End;
  Finally
    pFreeAndNil(qryAux);
  End;
end;

procedure TfrmExpArqRemDaycoval_707.pGravaLogctr;
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

function TfrmExpArqRemDaycoval_707.fMenssagemNoBoleto : Boolean;
Begin
  Result := False;
  If (strInstru1 = '93') Then
    Result := True
  Else If (strInstru1 = '94') Then
    Result := True
  Else If (strInstru2 = '93') Then
    Result := True
  Else If (strInstru2 = '94') Then
    Result := True;
End;

procedure TfrmExpArqRemDaycoval_707.pValidaInformacoesRemessa;
begin
  if fMenssagemNoBoleto then
  begin
    strObsAgru := qryRemessa.FieldByName('CBI_OBSAG1').AsString + ' ' +
                  qryRemessa.FieldByName('CBI_OBSAG2').AsString + ' ' +
                  qryRemessa.FieldByName('CBI_OBSAG3').AsString;

    if fGetBancoConfig(0, 'CONFIG707-' + IntToStr(intCartei), 'OBSERV1', '') <> '' then
    begin
      strMsg1    := fGetBancoConfig(0, 'CONFIG707-' + IntToStr(intCartei), 'OBSERV1', '');
      strMsg2    := Copy(strObsAgru, 001, 128);
      strMsg3    := Copy(strObsAgru, 129, 127);
    end
    else
    begin
      strMsg1    := Copy(strObsAgru, 001, 128);
      strMsg2    := Copy(strObsAgru, 129, 128);
      strMsg3    := Copy(strObsAgru, 257, 127);;
    end;

    if fEmptyStr(fGetBancoConfig(0, 'CONFIG707-' + IntToStr(intCartei), 'CDFLASH', '')) Then
    Begin
      strObsAgru := strMsg1    + ' ' + strMsg2 + ' ' + strMsg3;
      strCodFlash:= '';
    End
    Else
    begin
      strCodFlash:= fGetBancoConfig(0, 'CONFIG707-' + IntToStr(intCartei), 'CDFLASH', '');
      strObsAgru := '';
    end;
  end;


  If fCfgSis('VALIMP', varBoolean) then
  begin
    fltValDup := fltValDup + qryRemessa.FieldByName('CTR_JURSUJ').AsFloat +
                             qryRemessa.FieldByName('CTR_DESCOB').AsFloat;
  end;

  If blnUsaCnd Then
  Begin
    If Not blnUsaDesPon Then
      Exit;

    fltValDpo := ( ( qryRemessa.FieldByName('CBI_VALDUP').AsFloat ) * ( qryRemessa.FieldByName('CND_PERDPO').AsFloat / 100 ) );
    strDtaDpo := IIF((fltValDpo > 0), FormatDateTime('ddmmyy', (qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime - qryRemessa.FieldByName('CND_QTDDAV').AsInteger)),'0');

  End
  Else
  Begin
    fltValDpo := 0;
    strDtaDpo := '0';
  End;

end;

procedure TfrmExpArqRemDaycoval_707.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemDaycoval_707.FormCreate(Sender: TObject);
begin
  inherited;
     qryCadPor := fCriaQuery(Self);
end;

end.
