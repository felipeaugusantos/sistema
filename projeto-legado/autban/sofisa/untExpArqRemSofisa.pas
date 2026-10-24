unit untExpArqRemSofisa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, DBMemoFocus, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemSofisa = class(TfrmPai)
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

    qryConsultaGen : TUniQuery;
    qryCadPor      : TUniQuery;
    function fRetEmpresa: String;
    function fRetDupAgrupadas(strNumAgr, strCodCli: String): String;
    procedure pAtualizaHistoricoDuplicata(strNumDup, strParcel, strEspDoc,
      strCodEmp, strCodCli: String);
    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemSofisa: TfrmExpArqRemSofisa;

implementation

uses  untFuncoes, untfuncoesSimples, untFuncAutBan, untConstantes, Data.DB, untTypesSistema,
      untConsultas, untLogCtr;

{$R *.dfm}

procedure TfrmExpArqRemSofisa.FormShow(Sender: TObject);
begin
  inherited;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG637-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'RM' +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         fStrZero(FormatDateTime('yy',VS_Date),2) +
                         '.TXT';
  pSetFocus(edtCodPor);

end;

procedure TfrmExpArqRemSofisa.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strContBco  : String;
    strNomEmp   : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaEmi   : String;
    strKeyDup   : String;
    strCgcEmp   : String;
    strCgcCli   : String;
    strCodAgen  : String;
//    strSeqTit   : String;
    strCodCar   : String;
    strCpfCgc   : String;
    strDiaPro   : String;
    strInstru1  : String;
    strInstru2  : String;
    strAgenCob  : String;

    strNosNum   : String;

    strHeader   : String;
    strTransacao: String;
    strTrailler : String;
    strSacAva   : String;
    strDupAgr   : String;
    strEnvDpAg  : String;
    strMensagem : String;

    intCodSeq   : Integer;
    fltValTot   : Double;
    txtTexto    : TextFile;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
//    fltMulAtr   : Double;
//    fltValMor   : Double;
    strCodRem   : String;

    qryRemessa  : TUniQuery;

    strFilePath : String;
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

  strCodBco  := '637';
  strNomBco  := 'BANCO SOFISA SA';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);
  strContBco := fGetBancoConfig(0, 'CONFIG637-' + IntToStr(intCartei), 'IDENTBC', '');
  strCodAgen := fGetBancoConfig(0, 'CONFIG637-' + IntToStr(intCartei), 'CODAGEN', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG637-' + IntToStr(intCartei), 'CODCART', '');
  strDiaPro  := StrToIntDef(fGetBancoConfig(0, 'CONFIG637-' + IntToStr(intCartei), 'DIAPROT', ''), 0).ToString;
  strCodRem  := fStrZero(fAtuCodSeq('CONFIG637-' + IntToStr(intCartei), 'PROXNUM'), 6);
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);

  strInstru1 := fGetBancoConfig(0, 'CONFIG637-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2 := fGetBancoConfig(0, 'CONFIG637-' + IntToStr(intCartei), 'INSTRU2', '');
  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG637', 'RELOCAL', '') = 'N' );
  strAgenCob := IIF(strCodCar = '5',strCodAgen,'00000');

  strSacAva  := fGetBancoConfig(0, 'CONFIG637-' + IntToStr(intCartei), 'MSACAVA', '');
  strEnvDpAg := fGetBancoConfig(0, 'CONFIG637-' + IntToStr(intCartei), 'ENVDPAG', '');

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

  Try
    fStartTransaction;
    strCartei := 'CONFIG637-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
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

{  Finally
    FreeAndNil(qryConsultaGen);
  End;

  Try}

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

      //ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;

    If Not qryRemessa.IsEmpty Then
    Begin
      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      {***************************************}
      {* VERIFICA SE MOSTRA SACADOR AVALISTA *}
      {************************************PZ*}
      If (strSacAva = 'N') Then
        strNomEmp := '';

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************AF*}
      intCodSeq := 1;
      strHeader := '';
      strHeader := fPadR('0'                , 001)      + //001 - 001
                   fPadR('1'                , 001)      + //002 - 002
                   fPadR('REMESSA'          , 007)      + //003 - 009
                   fPadR('01'               , 002)      + //010 - 011
                   fPadR('COBRANCA'         , 015, ' ') + //012 - 026
                   fPadR(strContBco         , 020, ' ') + //027 - 046 - Código do Cedente
                   fPadR(strNomEmp          , 030, ' ') + //047 - 076
                   fPadR(strCodBco          , 003)      + //077 - 079
                   fPadR(strNomBco          , 015, ' ') + //080 - 094
                   fPadR(strDtaRem          , 006)      + //095 - 100
                   fPadR(' '                , 294)      + //101 - 394
                   fPadL(IntToStr(intCodSeq), 006, '0');  //395 - 400

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************AF*}
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG637-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);

      {************************}
      {* TRANSAÇÃO DO ARQUIVO *}
      {*********************AF*}
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

          strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTAVEN').AsDateTime);

          strDtaEmi := FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTACAD').AsDateTime);

//          strSeqTit := fStrZero(fAtuCodSeq('CONFIG637', 'PROXNUM'), 7);

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

          If strCodCar = '6' Then
            strNosNum := FieldByName('CBI_NOSNUM').AsString
          else strNosNum := '00000000';

          strCgcEmp := Trim(strCgcEmp);
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

          strCgcCli := Trim(FieldByName('CBI_C_G_C_').AsString);
          strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

          {**********************************}
          {* CALCULA O VALOR DA MORA DIARIA *}
          {*******************************JB*}
          fltValTot := FieldByName('CBI_VALDUP').AsFloat * (FieldByName('CBI_PORCEN').AsFloat / 100);

          strTransacao := fPadR      ('1'                                  , 01)      + //001 - 001
                          fPadR      ('02'                                 , 02)      + //002 - 003
                          fPadL      (strCgcEmp                            , 14, '0') + //004 - 017

                          fPadR      (strContBco                           , 20, ' ') + //018 - 037 - Código do Cedente
//                        fPadL      (strCodAgen                           , 04, '0') + //018 - 021
                          fPadR      (strKeyDup                            , 25, ' ') + //038 - 062
                          fStrZero   (strNosNum                            , 08)      + //063 - 070
                          fPadR      (' '                                  , 13)      + //071 - 083 - Cobrança Direta Tit Corr.
                          fPadR      (' '                                  , 03)      + //084 - 086 - Nro Cart. no correspondente
                          fPadR      (' '                                  , 21)      + //087 - 107
                          fPadR      (strCodCar                            , 01)      + //108 - 108
                          fPadR      ('01'                                 , 02)      + //109 - 110
                          fPadR      (RightStr(FieldByName('CBI_NUMDUP').AsString +
                                               FieldByName('CBI_PARCEL').AsString, 10), 10)      + //111 - 120
                          fPadR      (strDtaVen                            , 06)      + //121 - 126
                          fValNumForm(FieldByName('CBI_VALDUP').AsFloat    , 13)      + //127 - 139
                          fPadR      (strCodBco                            , 03)      + //140 - 142
                          fPadL      (strAgenCob                           , 05, '0') + //143 - 147
                          fPadR      ('01'                                 , 02)      + //148 - 149
                          fPadR      ('N'                                  , 01)      + //150 - 150
                          fPadR      (strDtaEmi                            , 06)      + //151 - 156
                          fPadL      (strInstru1                           , 02, '0') + //157 - 158
                          fPadL      (strInstru2                           , 02, '0') + //159 - 160
                          //fValNumForm(FieldByName('CBI_PORCEN').AsFloat    , 13)      + //161 - 173
                          fValNumForm(fltValTot                            , 13)      + //161 - 173
                          fStrZero   ('0'                                  , 06)      + //174 - 179
                          fStrZero   ('0'                                  , 13)      + //180 - 192
                          fStrZero   ('0'                                  , 13)      + //193 - 205
                          fStrZero   ('0'                                  , 13)      + //206 - 218
                          fPadL      (strCpfCgc                            , 02, '0') + //219 - 220
                          fPadL      (strCgcCli                            , 14, '0') + //221 - 234
                          fPadR      (FieldByName('CLI_NOMCLI').AsString   , 30, ' ') + //235 - 264
                          fPadR      (' '                                  , 10)      + //265 - 274
                          fPadR      (AstrEndereco                         , 40, ' ') + //275 - 314
                          fPadR      (FieldByName('BAIRRO').AsString       , 12, ' ') + //315 - 326
                          fPadL      (FieldByName('C_E_P_').AsString       , 08, '0') + //327 - 334
                          fPadR      (FieldByName('CIDADE').AsString       , 15, ' ') + //335 - 349
                          fPadR      (FieldByName('ESTADO').AsString       , 02, ' ') + //350 - 351
                          fPadR      (strNomEmp                            , 30, ' ') + //352 - 381
                          fPadR      (' '                                  , 04)      + //382 - 385
                          fPadR      (' '                                  , 06)      + //386 - 391
                          fPadL      (strDiaPro                            , 02, '0') + //392 - 393
                          fPadL      ('0'                                  , 01)      + //394 - 394
                          fPadL      (IntToStr(intCodSeq)                  , 06, '0');  //395 - 400

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************AF*}
          Writeln(txtTexto,strTransacao);

          {******************************}
          {* DADOS DA MENSAGEM VARIÁVEL *}
          {***************************RV*}
          If (strEnvDpAg = 'S') Then
          Begin
            strMensagem := '';
            Inc(intCodSeq);

            {***********************************************}
            {* SE FOR AGRUPAMENTO, INSERE OS NUMEROS DAS   *}
            {* DUPLICATAS AGRUPADAS, SENÃO DEIXA EM BRANCO *}
            {********************************************RV*}
            If (FieldByName('CBI_ESPDOC').AsString = 'AG') Then
            Begin
              strDupAgr := fRetDupAgrupadas(FieldByName('CBI_NUMDUP').AsString, FieldByName('CBI_CODCLI').AsString);
            End
            Else
            Begin
              strDupAgr := '';
            End;

            strMensagem := fPadR   ('2'                                  , 01)      + //001 - 001
                           fPadR   ('0'                                  , 01)      + //002 - 002
                           fPadR   (strDupAgr                            , 69)      + //003 - 071
                           fPadR   (' '                                  , 69)      + //072 - 140
                           fPadR   (' '                                  , 69)      + //141 - 209
                           fPadR   (' '                                  , 69)      + //210 - 278
                           fPadR   (' '                                  , 69)      + //279 - 347
                           fPadR   (' '                                  , 47)      + //348 - 394
                           fPadL   (IntToStr(intCodSeq)                  , 06, '0');  //395 - 400

            {**************************************}
            {* ESCREVE A MENSAGEM VARIAVEL NO TXT *}
            {***********************************RV*}
            Writeln(txtTexto, strMensagem);

          End;

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

      {************}
      {* TRAILLER *}
      {*********AF*}
      Inc(intCodSeq);
      strTrailler := '';
      strTrailler := '9'                                  + //001 - 001
                     fPadR(' '                , 393)      + //002 - 394
                     fPadL(IntToStr(intCodSeq), 006, '0');  //395 - 400

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************AF*}
      Writeln(txtTexto,strTrailler);

      CloseFile(txtTexto);

      qryRemessa.First;

      While Not qryRemessa.Eof Do
      Begin
        pAtualizaHistoricoDuplicata(qryRemessa.FieldByName('CBI_NUMDUP').AsString,
                                    qryRemessa.FieldByName('CBI_PARCEL').AsString,
                                    qryRemessa.FieldByName('CBI_ESPDOC').AsString,
                                    qryRemessa.FieldByName('CBI_CODEMP').AsString,
                                    qryRemessa.FieldByName('CBI_CODCLI').AsString);
        qryRemessa.Next;
      End;

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
//      fFecharTabela(frmModuloSPR.qryGen005);
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

procedure TfrmExpArqRemSofisa.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemSofisa.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

function TfrmExpArqRemSofisa.fRetDupAgrupadas(strNumAgr,
  strCodCli: String): String;
Var
  strSQL   : String;
  strDupAgr: String;
  strInsBar: String;
  intQtdDup: Integer;
  qryAgr   : TUniQuery;
begin

  Try

    Try

      qryAgr := fCriaQuery(Self);

      strSQL := '';
      strSQL := strSQL + 'SELECT   ';
      strSQL := strSQL + '  CONCAT(CTR_NUMDUP, CTR_PARCEL) AS NUMDUP ';
      strSQL := strSQL + 'FROM     ';
      strSQL := strSQL + '  DUPAGR ';
      strSQL := strSQL + 'WHERE    ';
      strSQL := strSQL + '  CTR_NUMAGR = :NUMAGR AND ';
      strSQL := strSQL + '  CTR_CODCLI = :CODCLI     ';

      With qryAgr Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('NUMAGR').AsString := strNumAgr;
        ParamByName('CODCLI').AsString := strCodCli;

        Open;

        strDupAgr := '';
        intQtdDup := 1;
        strInsBar := 'N';

        While Not Eof Do
        Begin
          {***************************************}
          {* LIMITA A QUANTIDADE DE 8 DUPLICATAS *}
          {* PARA NÃO EXCEDER A QTDE DE CARACTER *}
          {* DISPONÍVEL.(TOTAL = 69)             *}
          {************************************IV*}
          If (intQtdDup <= 8) Then
          Begin
            If (strInsBar = 'N') Then
            Begin
              strDupAgr := FieldByName('NUMDUP').AsString;
              strInsBar := 'S';
            End
            Else
            Begin
              strDupAgr := strDupAgr + '/' + FieldByName('NUMDUP').AsString;
            End;
          End;

          Inc(intQtdDup);

          Next;
        End;

        Result := strDupAgr;

      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[TfrmExpArqRemSantander.fRetDupAgrupadas]');
    End;

  Finally
    FreeAndNil(qryAgr);
  End;
end;

function TfrmExpArqRemSofisa.fRetEmpresa: String;
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

function TfrmExpArqRemSofisa.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemSofisa.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemSofisa.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

procedure TfrmExpArqRemSofisa.pAtualizaHistoricoDuplicata(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli: String);
begin
  fExecutaSQL(' UPDATE CADREC ' +
              ' SET CTR_HIST01 = ' +
              '         CONCAT("REMESSA: ", ' +
              '               ' + QuotedStr(edtNomArquivo.Text) + ', ' +
              '               ' + QuotedStr(STRING_QUEBRA) + ', IFNULL(CTR_HIST01, "")) ' +
              ' WHERE ' +
              '   CTR_NUMDUP = ' + QuotedStr(strNumDup) + ' AND ' +
              '   CTR_PARCEL = ' + QuotedStr(strParcel) + ' AND ' +
              '   CTR_ESPDOC = ' + QuotedStr(strEspDoc) + ' AND ' +
              '   CTR_CODEMP = ' + QuotedStr(strCodEmp) + ' AND ' +
              '   CTR_CODCLI = ' + QuotedStr(strCodCli) );
end;

end.
