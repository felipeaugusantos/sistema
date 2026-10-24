unit untExpArqRemUnicred400_136;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, frxClass,  Data.DB,
  untTypesSistema, untConsultas, frxExportCSVTestabilidade, untFuncAutban,
  untLogCtr, untFrameDirectoryEditFocus;

type
  TfrmExpArqRemUnicred400_136 = class(TfrmPai)
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
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
   { Private declarations }
    qryRemessa  : TUniQuery;

    {Inforções Carteira}
    strInstru2  : String;
    strInstru1  : String;
    strRespon   : String;
    strNomEmp   : String;
    strCodBco   : String;
    strCartei   : String;
    strCpfCgc   : String;
    strPosicao159 : String;
    strDiaPro   : String;
    strSeqDia : String;
    qryConsultaGen : TUniQuery;
    qryCadPor   : TUniQuery;
    function fRetEmpresa: String;
    function fValidaInstrucao02(strInstrucao01: String): Boolean;
    function fValidacoesParaExportacao:Boolean;
    procedure pValidaInformacoesCarteira;
    procedure pValidaInformacoesRemessa;
    function fCriarQueryRemessa:TUniQuery;
    function fGetSqlRemessa: String;
    procedure pApagarCADCBI;
    procedure pGravarLOGCTR;

    function GeraRegistro7(AObservacoesAExportar: String;
                           var ASequencialArquivo: Integer): String;
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemUnicred400_136: TfrmExpArqRemUnicred400_136;

implementation

uses untFuncoes, untfuncoesSimples;

{$R *.dfm}

procedure TfrmExpArqRemUnicred400_136.FormShow(Sender: TObject);
 Var
   strCodCed : String;
begin
  inherited;
  strCodCed := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(intCartei), 'CODCEDE', '');
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'PATHREM',''));

  If Not fEmptyStr(fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(intCartei),'SEQDIAR','')) Then
  Begin
    If Not fEmptyStr(fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(intCartei),'ULTREME','')) Then
    Begin
      If StrToDate(fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(intCartei),'ULTREME','')) = VS_Date Then
        strSeqDia    := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(intCartei),'SEQDIAR','')
      Else
        strSeqDia    := '01';
    End
    Else
      strSeqDia    := '01';
  End
  Else
    strSeqDia      := '01';

  edtNomArquivo.Text  := 'R400_' +
                         fStrZero(fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'CODCEDE',''), 09) +
                         fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(intCartei), 'DIGCEDE', '')               + '_' +
                         fStrZero(fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'CODAGEN',''), 04) + '_' +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         fStrZero(FormatDateTime('yyyy',VS_Date),4) + '_' +
                         strSeqDia +
                         '.REM';

  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemUnicred400_136.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strNomBco   : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaEmi   : String;
    strKeyDup   : String;
    strNumDup   : String;
    strCgcEmp   : String;
    strCgcCli   : String;
    strCodAge   : String;
    strCntCor   : String;
    strDigCnt   : String;
    strIdeEmp   : String;
    strCodCar   : String;
    strHeader   : String;
    strTransacao: String;
    strTrailler : String;
    intCodSeq   : Integer;
    txtTexto    : TextFile;
    strAutoIncremRem: String;
    AstrEndereco : String;
    strContBco : String;
    strDigCont,
    strCodAgen,
    strDigAgen : String;
    fltValMor : Double;
    fltPerMul : Double;
    strCodRem : String;
    intSeqDia : Integer;
    strNumCont: String;
    intLength : Integer;

    LExportaObservacoes: String;
begin
  inherited;
  If Not fValidacoesParaExportacao Then
    Exit;

  intCodSeq  := 1;
  strCodBco  := '136';
  strNomBco  := 'UNICRED';
  strContBco := fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'CODCEDE', '');
  strDigCont := fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'DIGCEDE', '');
  strCodAgen := fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'CODAGEN', '');
  strDigAgen := fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'DIGAGEN', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'CODCART', '');
  strNumCont := fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'NUMCONT', '');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);
  strInstru1 := fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2 := fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'INSTRU2', '');
  strCodRem  := fStrZero(fAtuCodSeq('CONFIG136_400p-' + IntToStr(intCartei), 'PROXNUM'), 7);
  strRespon  := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(intCartei), 'RESPONS', '');
  fltPerMul  :=  fStrToFloat ( fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'PERMULT', '') );

  LExportaObservacoes := Concat(fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'EXPOBS1', 'N'),
                                fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'EXPOBS2', 'N'),
                                fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'EXPOBS3', 'N'));

  pValidaInformacoesCarteira;

  Try
    qryConsultaGen := fCriaQuery(qryConsultaGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  *  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    qryConsultaGen.Close;
    qryConsultaGen.SQL.Clear;
    qryConsultaGen.SQL.Add(strSQL);
    qryConsultaGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConsultaGen.Open;
    strCgcEmp := qryConsultaGen.FieldByName('EMP_C_G_C_').AsString;
    qryConsultaGen.Close;
  Finally
    pFreeAndNil(qryConsultaGen);
  End;

  Try
    strCartei  := 'CONFIG136_400p-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriarQueryRemessa;
    strCodBco  := '136';
    If qryRemessa.IsEmpty Then
    Begin
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
      Exit;
    End;

    AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
    Rewrite(txtTexto);
    {*********************}
    {* HEADER DO ARQUIVO *}
    {******************AF*}
    strHeader := '';
    strHeader := fPadR   ('0'                , 001)      + //001 001
                 fPadR   ('1'                , 001)      + //002 002
                 fPadR   ('REMESSA'          , 007)      + //003 009
                 fPadR   ('01'               , 002)      + //010 011
                 fPadR   ('COBRANCA'         , 015)      + //012 026
                 fPadL   (strNumCont         , 020, '0') + //027 046
                 fPadR   (strNomEmp          , 030)      + //047 076
                 fPadR   (strCodBco          , 003)      + //077 079
                 fPadR   (strNomBco          , 015)      + //080 094
                 fPadR   (strDtaRem          , 006)      + //095 100
                 fPadR   (' '                , 007)      + //101 107
                 fPadR   ('000'              , 003)      + //108 110
                 fPadR   (strCodRem          , 007, '0') + //111 117
                 fPadR   (' '                , 277)      + //118 394
                 fStrZero(IntToStr(intCodSeq), 006);       //395 400

    {***************************}
    {* ESCREVE O HEADER NO TXT *}
    {************************AF*}
    Writeln(txtTexto,strHeader);
    {*****************************}
    {* GRAVAÇÃO DA TABELA REMGER *}
    {** DADOS GERAIS DA REMESSA **}
    {**************************MO*}
    pGravaRemGer(VS_strCodEmp, '136', 'CONFIG136_400p-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);
    {************************}
    {* TRANSAÇÃO DO ARQUIVO *}
    {*********************AF*}
    strTransacao := '';

    While Not qryRemessa.Eof Do
    Begin

      Inc(intCodSeq);
      Application.ProcessMessages;

      pValidaInformacoesRemessa;

      strDtaVen := FormatDateTime('dd',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime) +
                   FormatDateTime('mm',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime) +
                   FormatDateTime('yy',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime);

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

      intLength := Length(qryRemessa.FieldByName('CBI_PARCEL').AsString);

      strNumDup := fPadL(qryRemessa.FieldByName('CBI_NUMDUP').AsString, (10 - intLength))+
                   fPadR(qryRemessa.FieldByName('CBI_PARCEL').AsString, intLength);

      //AJUSTANDO ENDEREÇO PARA FICAR COMPLETO DENTRO DE 40 CARACTERES
      AstrEndereco := RetornaEnderecoENumeroCom40Caracteres(qryRemessa.FieldByName('ENDERE').AsString, qryRemessa.FieldByName('NUMERO').AsString);

      strCgcEmp := Trim(strCgcEmp);
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

      strCgcCli := Trim(qryRemessa.FieldByName('CBI_C_G_C_').AsString);
      strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
      strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
      strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

      strIdeEmp := '0'                    + //021
                   RightStr(fStrZero(strCodCar, 3), 3) + //022
                   RightStr(fStrZero(strCodAge, 5), 5) + //025
                   RightStr(fStrZero(strCntCor, 7), 7) + //030
                   RightStr(fStrZero(strDigCnt, 1), 1);  //037
      fltValMor := qryRemessa.FieldByName('CBI_PORCEN').AsFloat;

      strTransacao := fPadR      ('1'                                  , 01)      + //001 001
                      fPadL      (strCodAgen                           , 05, '0') + //002 006
                      fPadR      (strDigAgen                           , 01)      + //007 007
                      fPadL      (strContBco                           , 12, '0') + //008 019
                      fPadR      (strDigCont                           , 01)      + //020 020
                      fPadR      ('0'                                  , 01)      + //021 021
                      fPadL      (strCodCar                            , 03, '0') + //022 024
                      fPadL      ('0'                                  , 13, '0') + //025 037
                      fPadR      (strKeyDup                            , 25)      + //038 062
                      fPadR      (strCodBco                            , 03)      + //063 065
                      fPadR      ('00'                                 , 02)      + //066 067
                      fPadL      (' '                                  , 25)      + //068 092
                      fPadR      ('0'                                  , 01)      + //093 093
                      fPadR      ('2'                                  , 01)      + //094 094
                      fValNumForm(fltPerMul                            , 10)      + //095 104
                      fPadR      ('4'                                  , 01)      + //105 105
                      fPadR      ('N'                                  , 01)      + //106 106
                      fPadR      (' '                                  , 02)      + //107 108
                      fPadR      ('01'                                 , 02)      + //109 110
                      fPadL      (strNumDup                            , 10)      + //111 120
                      fPadR      (strDtaVen                            , 06)      + //121 126
                      fValNumForm(qryRemessa.FieldByName('CBI_VALDUP').AsFloat    , 13)      + //127 139
                      fPadR      ('0'                                  , 10, '0') + //140 149
                      fPadR      ('0'                                  , 01)      + //150 150
                      fPadR      (strDtaEmi                            , 06)      + //151 156
                      fPadR      ('0'                                  , 01)      + //157 157
                      fPadR      (strInstru1                           , 01)      + //158 158
                      fPadR      (strInstru2                           , 02)      + //159 160
                      fValNumForm(fltValMor                            , 13)      + //161 173
                      fPadR      ('0'                                  , 06, '0') + //174 179
                      fPadR      ('0'                                  , 13, '0') + //180 192
                      fPadL      (IfThen(strRespon = 'E', qryRemessa.FieldByName('CBI_NOSNUM').AsString, '0')
                                                                       , 11, '0') + //193 203
                      fPadR      ('00'                                 , 02)      + //204 205
                      fPadR      ('0'                                  , 13, '0') + //206 218
                      fPadL      (strCpfCgc                            , 02, '0') + //219 220
                      fPadL      (strCgcCli                            , 14, '0') + //221 234
                      fPadR      (qryRemessa.FieldByName('CLI_NOMCLI').AsString   , 40)      + //235 274
                      fPadR      (AstrEndereco       , 40)      + //275 314
                      fPadR      (qryRemessa.FieldByName('BAIRRO').AsString       , 12)      + //315 326
                      fPadR      (qryRemessa.FieldByName('C_E_P_').AsString       , 08, '0') + //327 334
                      fPadR      (qryRemessa.FieldByName('CIDADE').AsString       , 20)      + //335 354
                      fPadR      (qryRemessa.FieldByName('ESTADO').AsString       , 02)      + //355 356
                      fPadR      (' '                                  , 38)      + //357 394
                      fStrZero   (IntToStr(intCodSeq)                  , 06);        //395 400

      {******************************}
      {* ESCREVE A TRANSACAO NO TXT *}
      {***************************AF*}
      Writeln(txtTexto,strTransacao);

      If Pos('S', LExportaObservacoes) > 0 Then
      Begin
        strTransacao := GeraRegistro7(LExportaObservacoes, intCodSeq);
        Writeln(txtTexto,strTransacao);
      End;

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMDET *}
      {**** DETALHES DA REMESSA ****}
      {**************************MO*}
      pGravaRemDet(strAutoIncremRem,
                   qryRemessa.FieldByName('AUTOINCREM').AsString,
                   qryRemessa.FieldByName('CBI_NOSNUM').AsString,
                   0,
                   qryRemessa.FieldByName('CBI_VALDUP').AsFloat,
                   qryRemessa.FieldByName('CTR_DTAREC').AsDateTime,
                   qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime,
                   VS_Date,
                   strLoginUsuarioLogado,
                   '');

      {****************}
      {* GRAVA LOGCTR *}
      {*************JS*}
      pGravarLOGCTR;
      qryRemessa.Next;
    End;

    strCodBco := '136';
    {************}
    {* TRAILLER *}
    {*********AF*}
    Inc(intCodSeq);
    strTrailler := '';
    strTrailler := '9'                                + //001 001
                   fPadR   (' '                , 393) + //002 394
                   fStrZero(IntToStr(intCodSeq), 006);  //395 400

    {*****************************}
    {* ESCREVE O TRAILLER NO TXT *}
    {**************************AF*}
    Writeln(txtTexto,strTrailler);
    CloseFile(txtTexto);
    pBackupCnfBco;
    fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                 'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);
    intSeqDia := StrToIntDef(strSeqDia, 0);
    Inc(intSeqDia);
    strSeqDia := fPadL(IntToStr(intSeqDia), 02, '0');

    fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(intCartei), 'SEQDIAR', strSeqDia);
    fGetBancoConfig(1, 'CONFIG136_400p-' + IntToStr(intCartei), 'ULTREME', FormatDateTime('dd/mm/yyyy', VS_Date));

    pApagarCADCBI;

  Finally
    FreeAndNil(qryRemessa);
  End;
end;

procedure TfrmExpArqRemUnicred400_136.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemUnicred400_136.edtCodPorKeyPress(Sender: TObject;
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
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

function TfrmExpArqRemUnicred400_136.fCriarQueryRemessa: TUniQuery;
begin
  Result := Nil;
  Try
    Result:= fCriaQuery(Self);
    Result.Close;
    Result.SQL.Clear;
    Result.SQL.Add(fGetSqlRemessa);
    Result.ParamByName('CODBCO').AsString := strCodBco;

    If (Not fEmptyStr(edtCodPor.Text)) Then
      Result.ParamByName('CODPOR').AsString := edtCodPor.Text;

    // comentado req: 178704
    //IF fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
    //  Result.ParamByName('CARTEI').AsString := StrCartei;

    If (fCfgSis('CONREM', varString) = 'C') THEN
       Result.ParamByName('CARTEI').AsString := StrCartei;

    Result.Open;
  Except
  On E: Exception Do
   Begin
     pMensagensErro(E.Message, '[TfrmExpArqRemUnicred400_136.fCriarQueryRemessa]');
   End;
  End
end;

function TfrmExpArqRemUnicred400_136.fGetSqlRemessa: String;
  Var
    strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  B.*, ';
  strSQL := strSQL + '  C.CLI_NOMCLI, ';
  strSQL := strSQL + '  C.CLI_FONE01, ';
  strSQL := strSQL + '  I.CID_NOMCID, ';
  strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
  strSQL := strSQL + '  L.NFE_ACESSO, ';
  strSQL := strSQL + '  L.NFE_STATUS, ';
  strSQL := strSQL + '  L.NFE_NUMDOC, ';
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
  strSQL := strSQL + '  CADCBI B ';
  strSQL := strSQL + '  JOIN CADREC R ON R.CTR_NUMDUP = B.CBI_NUMDUP AND ';
  strSQL := strSQL + '                   R.CTR_PARCEL = B.CBI_PARCEL AND ';
  strSQL := strSQL + '                   R.CTR_ESPDOC = B.CBI_ESPDOC AND ';
  strSQL := strSQL + '                   R.CTR_CODEMP = B.CBI_CODEMP AND ';
  strSQL := strSQL + '                   R.CTR_CODCLI = B.CBI_CODCLI ';
  strSQL := strSQL + '  JOIN CADCLI C ON C.CLI_CODCLI = R.CTR_CODCLI ';
  strSQL := strSQL + '  JOIN CADCID I ON I.CID_CODCID = C.CLI_CODCID ';
  strSQL := strSQL + '  LEFT JOIN LOGNFE L ON L.NFE_NUMDOC = B.CBI_NUMDUP AND ';
  strSQL := strSQL + '                        L.NFE_ESPDOC = B.CBI_ESPDOC AND ';
  strSQL := strSQL + '                        L.NFE_CODEMP = B.CBI_CODEMP AND ';
  strSQL := strSQL + '                        L.NFE_CODCLI = B.CBI_CODCLI AND ';
  strSQL := strSQL + '                        L.NFE_TIP_FC = "C" ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  B.CBI_CODBCO = :CODBCO AND ';
  strSQL := strSQL + '  R.CTR_DTAREC IS NULL ';

  // comentado req: 178704
  //If fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'RESPONS', '') = 'E'  Then
  //   strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';

  If (fCfgSis('CONREM', varString) = 'C') Then
      strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';

  If (Not fEmptyStr(edtCodPor.Text)) Then
    strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR '
  Else If fCfgSis('DACPOR', varBoolean) Then
  Begin
    strSQL := strSQL + ' AND (CBI_CODPOR IS NULL OR CBI_CODPOR = "" OR ';
    strSQL := strSQL + ' CBI_CODPOR IN (' + fRetStrToSQLIn(strPortadoresOperador) + ')) ';
  End;

  Result := strSQL;
end;

function TfrmExpArqRemUnicred400_136.fRetEmpresa: String;
  Var
    intCount  : Integer;
    arrResult : Array Of String;
    qryCadEmp : TUniQuery;
Begin
  qryCadEmp := fCriaQuery(Self);

  qryCadEmp.Close;
  qryCadEmp.SQL.Clear;
  qryCadEmp.SQL.Add('SELECT * FROM CADEMP');
  qryCadEmp.Open;

  SetLength(arrResult, qryCadEmp.RecordCount);
  intCount := 0;

  While Not qryCadEmp.Eof Do
  Begin
    arrResult[intCount] := fStrZero(qryCadEmp.FieldByName('EMP_CODEMP').AsString, 3) + ' - ' + qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
    qryCadEmp.Next;
    Inc(intCount);
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

function TfrmExpArqRemUnicred400_136.fValidaCampos(Sender: TWinControl;
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
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmExpArqRemUnicred400_136.pValidaInformacoesCarteira;
begin
  strInstru2 :='00';
  If fValidaInstrucao02(strInstru1) Then
    strInstru2 := fStrZero(fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'DIAPROT', ''),2);
end;

procedure TfrmExpArqRemUnicred400_136.pValidaInformacoesRemessa;
begin

  If qryRemessa.FieldByName('CBI_CGCCPF').AsInteger = 0 Then
    strCpfCgc := '99'
  Else If qryRemessa.FieldByName('CBI_CGCCPF').AsInteger = 1 Then
    strCpfCgc := '2'
  Else
    strCpfCgc := '1';

  strPosicao159 := IIF(strInstru1 = '06',strDiaPro,strInstru2);
end;

function TfrmExpArqRemUnicred400_136.fValidaInstrucao02(strInstrucao01: String): Boolean;
begin
  Result := False;
  If (strInstrucao01 = '1') Then
    Result:=True
  Else If (strInstrucao01 = '2')Then
    Result := True
end;

function TfrmExpArqRemUnicred400_136.GeraRegistro7(
  AObservacoesAExportar: String; var ASequencialArquivo: Integer): String;
  Var
    LContador,
    LPosicaoExportacao,
    LTamanhoFiler: Integer;
begin
  Inc(ASequencialArquivo);

  Result := '7'  +
            '   ';

  LPosicaoExportacao := 7;

  LTamanhoFiler := 8;

  For LContador := 1 To 3 Do
  Begin
    If Copy(AObservacoesAExportar, LContador, 1) = 'N' Then
      Continue;

    If LPosicaoExportacao > 136 Then
      LTamanhoFiler := 7;

    Result := Concat(Result,
                     '00',
                     fPadR(LeftStr(fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'OBSERV' + (LContador).ToString, ''), 40), 80, ' '),
                     fPadR('', LTamanhoFiler, ' '),
                     fPadR(LeftStr(fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'OBSERV' + (LContador).ToString, ''), 40), 40, ' '));

    LPosicaoExportacao := LPosicaoExportacao + 128;
  End;

  While (LPosicaoExportacao < 266) Do
  Begin
    If LPosicaoExportacao > 136 Then
      LTamanhoFiler := 7;

    Result := Concat(Result,
                     '00',
                     fPadR('', 80, ' '),
                     fPadR('', LTamanhoFiler, ' '),
                     fPadR('', 40, ' '));

    LPosicaoExportacao := LPosicaoExportacao + 128;
  End;

  Result := Concat(Result,
                   ' ',
                   fStrZero(ASequencialArquivo.ToString, 6));
end;

procedure TfrmExpArqRemUnicred400_136.pGravarLOGCTR;
begin
  untLogCtr.GravaLogCtr(qryRemessa.FieldByName('AUTOINCREM').AsString, 'EXPORTAÇÃO DE ARQUIVO DE REMESSA - 136', Self.Name);
end;

procedure TfrmExpArqRemUnicred400_136.pApagarCADCBI;
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

    //Req: 178704
    //IF fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
    //  strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';

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

      //Req: 178704
      //IF fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
      //  qryAux.ParamByName('CARTEI').AsString := StrCartei;

      if (fCfgSis('CONREM', varString) = 'C') THEN
         qryAux.ParamByName('CARTEI').AsString := StrCartei;

      qryAux.ExecSQL;
      qryAux.Close;
    Except
    On E: Exception Do
      Begin
         pMensagensErro(E.Message, '[TfrmExpArqRemUnicred400_136.fCriarQueryRemessa]');
      End;
    End;
  Finally
    pFreeAndNil(qryAux);
  End;
end;

function TfrmExpArqRemUnicred400_136.fValidacoesParaExportacao: Boolean;
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
  blnRemLoc  := Not( fGetBancoConfig(0,'CONFIG136_400p', 'RELOCAL', '') = 'N' );;
  strNomEmp  := Trim(fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(intCartei), 'NOMBENE', ''));
  If Not fEmptyStr(strNomEmp) Then
  Begin
    strNomEmp  := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(intCartei), 'NOMBENE', '');
    Exit;
  End;

  strNovCodEmp := VS_strCodEmp;
  If Not( blnRemLoc ) Then
    strNovCodEmp := fRetEmpresa;  //Abre bloco para escolher a empresa
  strNomEmp := fRetNomeEmpresa(strNovCodEmp);
  If fEmptyStr( strNomEmp ) Then
  Begin
    fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!',['&Sim','&Não']);
    Result := False;
    Exit;
  End;
end;

procedure TfrmExpArqRemUnicred400_136.FormCreate(Sender: TObject);
begin
  inherited;
   qryCadPor := fCriaQuery(Self);
end;

end.
