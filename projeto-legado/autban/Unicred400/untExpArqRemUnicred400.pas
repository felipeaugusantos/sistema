unit untExpArqRemUnicred400;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFuncAutban, untFrameDirectoryEditFocus;

type
  TfrmExpArqRemUnicred400 = class(TfrmPai)
    pnlFundo: TPanel;
    lblNomArq: TLabel;
    lblPathRem: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    Label1: TLabel;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    btnGerar: TBitBtnLocked;
    fraPathRemessa: TfraDirectoryEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
    strSeqDia      : String;
    qryCadPor      : TUniQuery;
    qryConsultaGen : TUniQuery;

    function fRetEmpresa: String;

  public
    { Public declarations }
    intCartei  : Integer;
    strNomForm : String;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemUnicred400: TfrmExpArqRemUnicred400;

implementation

uses untFuncoes, untfuncoesSimples, Data.DB, untCfgGenericas_AutBan, untConsultas,
     untTypesSistema, untConstantes, untLogCtr;

{$R *.dfm}

procedure TfrmExpArqRemUnicred400.FormShow(Sender: TObject);
  Var
    strCodCed : String;

begin
  inherited;
  strCodCed := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(intCartei), 'CODCEDE', '');
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG090_400p-' + IntToStr(intCartei), 'PATHREM',''));

  If Not fEmptyStr(fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(intCartei),'SEQDIAR','')) Then
  Begin
    If Not fEmptyStr(fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(intCartei),'ULTREME','')) Then
    Begin
      If StrToDate(fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(intCartei),'ULTREME','')) = VS_Date Then
        strSeqDia    := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(intCartei),'SEQDIAR','')
      Else
        strSeqDia    := '01';
    End
    Else
      strSeqDia    := '01';
  End
  Else
    strSeqDia      := '01';

  edtNomArquivo.Text  := 'R400_' +
                         fStrZero(fGetBancoConfig(0, 'CONFIG090_400p-' + IntToStr(intCartei), 'CODCEDE',''), 09) +
                         fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(intCartei), 'DIGCEDE', '')               + '_' +
                         fStrZero(fGetBancoConfig(0, 'CONFIG090_400p-' + IntToStr(intCartei), 'CODAGEN',''), 04) + '_' +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         fStrZero(FormatDateTime('yyyy',VS_Date),4) + '_' +
                         strSeqDia +
                         '.REM';

  pSetFocus(edtCodPor);

end;

procedure TfrmExpArqRemUnicred400.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strContBco  : String;
    strDigCont  : String;
    strNomEmp   : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaEmi   : String;
    strKeyDup   : String;
    strCgcEmp   : String;
    strCgcCli   : String;
    strCodAgen  : String;
    strDigAgen  : String;
    strSeqTit   : String;
    strCodCar   : String;
    strCpfCgc   : String;
    strInstru1  : String;
    strInstru2  : String;
    strParMov   : String;
    dtaDtaVen   : TDateTime;
    strHeader   : String;
    strTransacao: String;
    strTrailler : String;
    intCodSeq   : Integer;
    txtTexto    : TextFile;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    strSeqArq   : String;
    strRespon   : String;
    strDtaIns   : String;
    qryRemessa  : TUniQuery;
    strFilePath : String;
    strNumContr : String;
    fltValMor   : Double;
    intSeqDia   : Integer;
    strBraCrr   : String;
    strNosNum   : String;
    strDigito   : String;
    intIndCar   : Integer;
    strCartei: String;
    strAutoIncremRem: String;
    AstrEndereco    : String;
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

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
  Begin
    fMensagem('Path:', 'Diretório inválido p\ exportação.', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  strCodBco  := '090';
  strNomBco  := 'UNICRED';
  strContBco := fGetBancoConfig(0, 'CONFIG090_400p-' + IntToStr(intCartei), 'CODCEDE', '');
  strDigCont := fGetBancoConfig(0, 'CONFIG090_400p-' + IntToStr(intCartei), 'DIGCEDE', '');
  strCodAgen := fGetBancoConfig(0, 'CONFIG090_400p-' + IntToStr(intCartei), 'CODAGEN', '');
  strDigAgen := fGetBancoConfig(0, 'CONFIG090_400p-' + IntToStr(intCartei), 'DIGAGEN', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG090_400p-' + IntToStr(intCartei), 'CODCART', '');

  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);

  strInstru1 := fGetBancoConfig(0, 'CONFIG090_400p-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2 := fGetBancoConfig(0, 'CONFIG090_400p-' + IntToStr(intCartei), 'INSTRU2', '');
  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG090_400p', 'RELOCAL', '') = 'N');
  strSeqArq  := fStrZero(fAtuCodSeq('CONFIG090_400p-' + IntToStr(intCartei), 'PROXNUM'), 7);
  strRespon  := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(intCartei), 'RESPONS', '');
  strParMov  := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(intCartei), 'PARMMOV', '');
  strNumContr:= fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(intCartei), 'NUMCONT', '');

  strBraCrr  := fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(intCartei), 'CORBRAD', '');

  If Not fEmptyStr(fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(intCartei), 'INDCART', '')) Then
    intIndCar:= StrToInt(fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(intCartei), 'INDCART', ''))
  Else
    intIndCar:= 0;

  //*************************************************//
  // VERIFICA SE EXISTE A CONFIGURACAO PARA A GERA-  //
  // CAO DE REMESSA PARA TODAS AS EMPRESAS OU SOMEN- //
  // TE PARA A EMPRESA ATUAL(LOCAL)                  //
  //**********************************************JU*//
  strNovCodEmp := VS_strCodEmp;

  If Not( blnRemLoc ) Then
    strNovCodEmp := fRetEmpresa;

  strNomEmp := fRetNomeEmpresa(strNovCodEmp);


  //*************************************************//
  // SE OCORRER ALGUM ERRO AO RETORNAR O NOME DA     //
  // EMPRESA, ENTAO DA A MENSAGEM E SKIP A EXPORT.   //
  //**********************************************JU*//
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
    strSQL := strSQL + '  *  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryConsultaGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      strCgcEmp := FieldByName('EMP_C_G_C_').AsString;
      Close;
    End;

    strCartei := 'CONFIG090-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
    strSQL := strSQL + '  R.CTR_DTAREC AS CTR_DTAREC, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDERE, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), C.CLI_ENDERE), C.CLI_ENDCOB) AS ENDERE, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), "")  AS COMPLEMENTO, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IFNULL(C.CLI_ENDNUM, ""), " ") AS NUMERO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_BAIRRO, C.CLI_BAICOB) AS BAIRRO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_C_E_P_, C.CLI_CEPCOB) AS C_E_P_, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                                     '(SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS CIDADE, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                                     '(SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS ESTADO  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCBI B, ';
    strSQL := strSQL + '  CADCLI C, ';
    strSQL := strSQL + '  CADREC R ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  CLI_CODCLI = CBI_CODCLI AND ';
    strSQL := strSQL + '  CTR_NUMDUP = CBI_NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = CBI_PARCEL AND ';
    strSQL := strSQL + '  CTR_ESPDOC = CBI_ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = CBI_CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = CBI_CODCLI AND ';
    strSQL := strSQL + '  CTR_DTAREC IS NULL ';

    if (fCfgSis('CONREM', varString) = 'C') THEN
      strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';

    If (Not fEmptyStr(edtCodPor.Text)) Then
      strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR '
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + ' AND (IFNULL(CBI_CODPOR, "") = "" ';
      strSQL := strSQL + ' OR LOCATE(CBI_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

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
      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      //*************************************************//
      // HEADER DO ARQUIVO                               //
      //**********************************************JU*//
      intCodSeq := 1;
      strHeader := '';

      If strBraCrr <> 'S' Then
        strHeader := fPadR   ('0'                , 001)      + //001 001
                     fPadR   ('1'                , 001)      + //002 002
                     fPadR   ('REMESSA'          , 007)      + //003 009
                     fPadR   ('01'               , 002)      + //010 011
                     fPadR   ('COBRANCA'         , 015)      + //012 026
                     fPadL   (strContBco         , 020, '0') + //027 046
                     fPadR   (strNomEmp          , 030)      + //047 076
                     fPadR   (strCodBco          , 003)      + //077 079
                     fPadR   (strNomBco          , 015)      + //080 094
                     fPadR   (strDtaRem          , 006)      + //095 100
                     fPadR   (' '                , 007)      + //101 107
                     fPadR   (strParMov          , 003)      + //108 110
                     fPadR   (strSeqArq          , 007, '0') + //111 117
                     fPadR   (' '                , 277)      + //118 394
                     fStrZero(IntToStr(intCodSeq), 006)        //395 400
      Else
        strHeader := fPadR   ('0'                , 001)      + //001 001
                     fPadR   ('1'                , 001)      + //002 002
                     fPadR   ('REMESSA'          , 007)      + //003 009
                     fPadR   ('01'               , 002)      + //010 011
                     fPadR   ('COBRANCA'         , 015)      + //012 026
                     fPadL   (strContBco         , 020, '0') + //027 046
                     fPadR   (fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(intCartei), 'DESCORR', ''), 030) + //047 076
                     fPadR   ('237'              , 003)      + //077 079
                     fPadR   ('BRADESCO'         , 015)      + //080 094
                     fPadR   (strDtaRem          , 006)      + //095 100
                     fPadR   (' '                , 008)      + //101 108
                     fPadR   ('MX'               , 002)      + //109 110
                     fPadR   (strSeqArq          , 007, '0') + //111 117
                     fPadR   (' '                , 277)      + //118 394
                     fStrZero(IntToStr(intCodSeq), 006);       //395 400

      //*************************************************//
      // ESCREVE O HEADER NO TXT                         //
      //**********************************************JU*//
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG090_400p-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strSeqArq), strAutoIncremRem);

      //*************************************************//
      // TRANSAÇÃO DO ARQUIVO                            //
      //**********************************************JU*//
      With qryRemessa Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin
          Inc(intCodSeq);
          Application.ProcessMessages;

          If FieldByName('CBI_CGCCPF').AsInteger = 1 Then
            strCpfCgc := '2'
          Else
            strCpfCgc := '1';

          If FieldByName('CBI_DTAVEN').AsDateTime >= FieldByName('CBI_DTACAD').AsDateTime + 7 Then
            strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                         FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                         FormatDateTime('yy',FieldByName('CBI_DTAVEN').AsDateTime)
          Else
          Begin
            dtaDtaVen := FieldByName('CBI_DTACAD').AsDateTime + 7;

            strDtaVen := FormatDateTime('dd',dtaDtaVen) +
                         FormatDateTime('mm',dtaDtaVen) +
                         FormatDateTime('yy',dtaDtaVen) ;
          End;

          strDtaEmi := FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTACAD').AsDateTime) ;

          strDtaIns := FormatDateTime('yyyy',  FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',  FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) ;


          strSeqTit := fStrZero(fAtuCodSeq('CONFIG090_400p', 'PROXNUM'), 7);

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

          strCgcEmp := Trim(strCgcEmp);
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

          strCgcCli := Trim(FieldByName('CBI_C_G_C_').AsString);
          strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

          fltValMor := ((FieldByName('CBI_VALDUP').AsFloat) * (FieldByName('CBI_PORCEN').AsFloat / 100));

          If strBraCrr <> 'S' Then
            strTransacao := fPadR      ('1'                                  , 01)      + //001 001
                            fPadL      (strCodAgen                           , 05, '0') + //002 006
                            fPadR      (strDigAgen                           , 01)      + //007 007
                            fPadL      (strContBco                           , 12, '0') + //008 019
                            fPadR      (strDigCont                           , 01)      + //020 020
                            fPadR      ('0'                                  , 01)      + //021 021
                            fPadL      (strCodCar                            , 03, '0') + //022 024
                            fPadL      (strNumContr                          , 13, '0') + //025 037
                            fPadR      (strKeyDup                            , 25)      + //038 062
                            fPadR      (strCodBco                            , 03)      + //063 065
                            fPadR      ('00'                                 , 02)      + //066 067
                            fPadL      (FieldByName('CBI_NOSNUM').AsString   , 15, '0') + //068 082
                            fPadR      ('0'                                  , 10, '0') + //083 092
                            fPadR      ('0'                                  , 01)      + //093 093
                            fPadR      (' '                                  , 01)      + //094 094
                            fPadR      (' '                                  , 10)      + //095 104
                            fPadR      (' '                                  , 01)      + //105 105
                            fPadR      ('0'                                  , 01)      + //106 106
                            fPadR      (' '                                  , 02)      + //107 108
                            fPadR      ('01'                                 , 02)      + //109 110
                            fPadR      (strKeyDup                            , 10)      + //111 120
                            fPadR      (strDtaVen                            , 06)      + //121 126
                            fValNumForm(FieldByName('CBI_VALDUP').AsFloat    , 13)      + //127 139
                            fPadR      ('0'                                  , 03, '0') + //140 142
                            fPadR      ('0'                                  , 05, '0') + //143 147
                            fPadR      ('00'                                 , 02)      + //148 149
                            fPadR      (' '                                  , 01)      + //150 150
                            fPadR      (strDtaEmi                            , 06)      + //151 156
                            fPadR      (strInstru1                           , 02)      + //157 158
                            fPadR      (strInstru2                           , 02)      + //159 160
                            fValNumForm(fltValMor                            , 13)      + //161 173
                            fPadR      (strDtaVen                            , 06)      + //174 179
                            fPadR      ('0'                                  , 13, '0') + //180 192
                            fPadL      (IfThen(strRespon = 'E', FieldByName('CBI_NOSNUM').AsString, '0')
                                                                             , 11, '0') + //193 203
                            fPadR      ('00'                                 , 02)      + //204 205
                            fPadR      ('0'                                  , 13, '0') + //206 218
                            fPadL      (strCpfCgc                            , 02, '0') + //219 220
                            fPadL      (strCgcCli                            , 14, '0') + //221 234
                            fPadR      (FieldByName('CLI_NOMCLI').AsString   , 40)      + //235 274
                            fPadR      (AstrEndereco                         , 40)      + //275 314
                            fPadR      (FieldByName('BAIRRO').AsString       , 12)      + //315 326
                            fPadR      (FieldByName('C_E_P_').AsString       , 08, '0') + //327 334
                            fPadR      (FieldByName('CIDADE').AsString       , 20)      + //335 354
                            fPadR      (FieldByName('ESTADO').AsString       , 02)      + //355 356
                            fPadR      (' '                                  , 38)      + //357 394
                            fStrZero   (IntToStr(intCodSeq)                  , 06)        //395 400
          Else
          Begin
            If strRespon = 'E' Then
            Begin
              strNosNum := fCalcNossoNumero('237', LeftStr(FieldByName('CBI_NOSNUM').AsString, 11), '237', intIndCar, VS_strCodEmp);
              strDigito := fCalcDigito('237', strNosNum, '237', intIndCar, VS_strCodEmp);
              strNosNum := strNosNum + strDigito;

              strTransacao := fPadR      ('1'                                  , 01)      + //001 001
                              fPadL      (strCodAgen                           , 05, '0') + //002 006
                              fPadR      (strDigAgen                           , 01)      + //007 007
                              fPadL      (strContBco                           , 12, '0') + //008 019
                              fPadR      (strDigCont                           , 01)      + //020 020
                              fPadR      ('0'                                  , 01)      + //021 021
                              fPadL      ('009'                                , 03, '0') + //022 024
                              fPadL      (strCodAgen                           , 05, '0') + //025 029
                              fPadL      (strContBco                           , 07, '0') + //030 036
                              fPadL      (strDigCont                           , 01, '0') + //037 037
                              fPadR      (strKeyDup                            , 25)      + //038 062
                              fPadR      (strCodBco                            , 03)      + //063 065
                              fPadR      ('0'                                  , 01)      + //066 066
                              fPadL      ('0'                                  , 04, '0') + //067 070
                              fPadL      (strNosNum                            , 12, '0') + //071 082
                              fPadR      ('0'                                  , 10, '0') + //083 092
                              fPadR      ('2'                                  , 01)      + //093 093
                              fPadR      (' '                                  , 01)      + //094 094
                              fPadR      (' '                                  , 10)      + //095 104
                              fPadR      (' '                                  , 01)      + //105 105
                              fPadR      ('0'                                  , 01)      + //106 106
                              fPadR      (' '                                  , 02)      + //107 108
                              fPadR      ('01'                                 , 02)      + //109 110
                              fPadR      (strKeyDup                            , 10)      + //111 120
                              fPadR      (strDtaVen                            , 06)      + //121 126
                              fValNumForm(FieldByName('CBI_VALDUP').AsFloat    , 13)      + //127 139
                              fPadR      ('0'                                  , 03, '0') + //140 142
                              fPadR      ('0'                                  , 05, '0') + //143 147
                              fPadR      ('01'                                 , 02)      + //148 149
                              fPadR      ('N'                                  , 01)      + //150 150
                              fPadR      (strDtaEmi                            , 06)      + //151 156
                              fPadR      (strInstru1                           , 02)      + //157 158
                              fPadL      (fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(intCartei), 'DIAPROT', ''), 02, '0') + //159 160
                              fValNumForm(fltValMor                            , 13)      + //161 173
                              fPadR      ('0'                                  , 06, '0') + //174 179
                              fPadR      ('0'                                  , 13, '0') + //180 192
                              fPadL(RightStr(FieldByName('CBI_NOSNUM').AsString, 11), 11, '0') + //193 203
                              fPadR      ('00'                                 , 02)      + //204 205
                              fPadR      ('0'                                  , 13, '0') + //206 218
                              fPadL      (strCpfCgc                            , 02, '0') + //219 220
                              fPadL      (strCgcCli                            , 14, '0') + //221 234
                              fPadR      (FieldByName('CLI_NOMCLI').AsString   , 40)      + //235 274
                              fPadR      (AstrEndereco                         , 40)      + //275 314
                              fPadR      (''                                   , 12)      + //315 326
                              fPadR      (FieldByName('C_E_P_').AsString       , 08, '0') + //327 334
                              fPadR      (FieldByName('BAIRRO').AsString       , 20)      + //335 354
                              fPadR      (FieldByName('CIDADE').AsString       , 38)      + //355 392
                              fPadR      (FieldByName('ESTADO').AsString       , 02)      + //393 394
                              fStrZero   (IntToStr(intCodSeq)                  , 06)        //395 400
            End
            Else
              strTransacao := fPadR      ('1'                                  , 01)      + //001 001
                              fPadL      (strCodAgen                           , 05, '0') + //002 006
                              fPadR      (strDigAgen                           , 01)      + //007 007
                              fPadL      (strContBco                           , 12, '0') + //008 019
                              fPadR      (strDigCont                           , 01)      + //020 020
                              fPadR      ('0'                                  , 01)      + //021 021
                              fPadL      ('009'                                , 03, '0') + //022 024
                              fPadL      (strCodAgen                           , 05, '0') + //025 029
                              fPadL      (strContBco                           , 07, '0') + //030 036
                              fPadL      (strDigCont                           , 01, '0') + //037 037
                              fPadR      (strKeyDup                            , 25)      + //038 062
                              fPadR      (strCodBco                            , 03)      + //063 065
                              fPadR      ('0'                                  , 01)      + //066 066
                              fPadL      ('0'                                  , 04, '0') + //067 070
                              fPadL      ('0'                                  , 12, '0') + //071 082
                              fPadR      ('0'                                  , 10, '0') + //083 092
                              fPadR      ('1'                                  , 01)      + //093 093
                              fPadR      (' '                                  , 01)      + //094 094
                              fPadR      (' '                                  , 10)      + //095 104
                              fPadR      (' '                                  , 01)      + //105 105
                              fPadR      ('0'                                  , 01)      + //106 106
                              fPadR      (' '                                  , 02)      + //107 108
                              fPadR      ('01'                                 , 02)      + //109 110
                              fPadR      (strKeyDup                            , 10)      + //111 120
                              fPadR      (strDtaVen                            , 06)      + //121 126
                              fValNumForm(FieldByName('CBI_VALDUP').AsFloat    , 13)      + //127 139
                              fPadR      ('0'                                  , 03, '0') + //140 142
                              fPadR      ('0'                                  , 05, '0') + //143 147
                              fPadR      ('01'                                 , 02)      + //148 149
                              fPadR      ('N'                                  , 01)      + //150 150
                              fPadR      (strDtaEmi                            , 06)      + //151 156
                              fPadR      (strInstru1                           , 02)      + //157 158
                              fPadL      (fGetBancoConfig(0,'CONFIG090_400p-' + IntToStr(intCartei), 'DIAPROT', ''), 02,'0') + //159 160
                              fValNumForm(fltValMor                            , 13)      + //161 173
                              fPadR      ('0'                                  , 06, '0') + //174 179
                              fPadR      ('0'                                  , 13, '0') + //180 192
                              fPadL      ('0'                                  , 11, '0') + //193 203
                              fPadR      ('00'                                 , 02)      + //204 205
                              fPadR      ('0'                                  , 13, '0') + //206 218
                              fPadL      (strCpfCgc                            , 02, '0') + //219 220
                              fPadL      (strCgcCli                            , 14, '0') + //221 234
                              fPadR      (FieldByName('CLI_NOMCLI').AsString   , 40)      + //235 274
                              fPadR      (AstrEndereco                         , 40)      + //275 314
                              fPadR      (FieldByName('BAIRRO').AsString       , 12)      + //315 326
                              fPadR      (FieldByName('C_E_P_').AsString       , 08, '0') + //327 334
                              fPadL      (fTiraCaracEspeciais(strCgcEmp)       , 15, '0') + //335 349
                              fPadR      (''                                   , 02)      + //350 351
                              fPadR      (strNomEmp                            , 43)      + //352 394
                              fStrZero   (IntToStr(intCodSeq)                  , 06);       //395 400
          End;

          //*************************************************//
          // ESCREVE A TRANSACAO NO TXT                      //
          //**********************************************JU*//
          Writeln(txtTexto,strTransacao);

          {*****************************}
          {* GRAVAÇÃO DA TABELA REMDET *}
          {**** DETALHES DA REMESSA ****}
          {**************************MO*}
          pGravaRemDet(strAutoIncremRem,
                       FieldByName('AUTOINCREM').AsString,
                       FieldByName('CBI_NOSNUM').AsString,
                       0,
                       FieldByName('CBI_VALDUP').AsFloat,
                       FieldByName('CTR_DTAREC').AsDateTime,
                       FieldByName('CBI_DTAVEN').AsDateTime,
                       VS_Date,
                       strLoginUsuarioLogado,
                       '');

          Next;
        End;

      End;

      //*************************************************//
      // TRAILLER                                        //
      //**********************************************JU*//
      Inc(intCodSeq);
      strTrailler := '';


      strTrailler := '9'                                + //001 001
                     fPadR   (' '                , 393) + //002 394
                     fStrZero(IntToStr(intCodSeq), 006);  //395 400


      //*************************************************//
      // ESCREVE O TRAILLER NO TXT                       //
      //**********************************************JU*//
      Writeln(txtTexto,strTrailler);

      CloseFile(txtTexto);

      pDeletaCadCbi(strCodBco, strCartei, edtCodPor.Text);

      intSeqDia := StrToIntDef(strSeqDia, 0);
      Inc(intSeqDia);
      strSeqDia := fPadL(IntToStr(intSeqDia), 02, '0');

      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(intCartei), 'SEQDIAR', strSeqDia);
      fGetBancoConfig(1, 'CONFIG090_400p-' + IntToStr(intCartei), 'ULTREME', FormatDateTime('dd/mm/yyyy', VS_Date));

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

procedure TfrmExpArqRemUnicred400.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemUnicred400.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
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

function TfrmExpArqRemUnicred400.fRetEmpresa: String;
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
    Open;

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

  FreeAndNil(qryCadEmp);
end;

function TfrmExpArqRemUnicred400.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemUnicred400.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemUnicred400.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

end.
