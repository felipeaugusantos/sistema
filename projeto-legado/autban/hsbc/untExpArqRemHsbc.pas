unit untExpArqRemHsbc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemHsbc = class(TfrmPai)
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
  private
    qryCadPor      : TUniQuery;
    qryConsultaGen : TUniQuery;

    function fRetEmpresa: String;
    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemHsbc: TfrmExpArqRemHsbc;

implementation

uses untFuncoes, untfuncoesSimples, untFuncAutBan, Data.DB, untConsultas, untTypesSistema,
     untConstantes, untLogCtr;

{$R *.dfm}

procedure TfrmExpArqRemHsbc.FormShow(Sender: TObject);
begin
  inherited;
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG399-' + IntToStr(intCartei), 'PATHREM',''));

  edtNomArquivo.Text  := fStrZero(FormatDateTime('yy',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         fStrZero(FormatDateTime('dd',VS_Date),2);

  edtNomArquivo.Text := edtNomArquivo.Text + 'A' + '.REM';

  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemHsbc.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strNomEmp   : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaEmi   : String;
    strKeyDup   : String;
    strCgcEmp   : String;
    strCgcCli   : String;
    strCodAgen  : String;
    strContCor  : String;
    strCodCar   : String;
    strCpfCgc   : String;
    strDiaPro   : String;
    strInstru1  : String;
    strInstru2  : String;
    strCobReg   : String;
    strCodCden  : String;
    strHorRem   : String;
    strObs001   : String;
    strObs002   : String;
    strObs003   : String;
    strObs004   : String;
    strObs005   : String;
    strRespons  : String;

    strHeader   : String;
    strTransacao: String;
    strRegTipo2 : String;
    strTrailler : String;

    intCodSeq   : Integer;
    fltValAtr   : Double;
    txtTexto    : TextFile;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    strEnvSacAva: String;
    qryRemessa  : TUniQuery;
    strCodRem   : String;

    strFilePath : String;
    strCartei: String;
    strAutoIncremRem: String;
    AstrEndereco : String;
    AstrEndereco38 : String;
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

  strCodBco  := '399';
  strNomBco  := 'HSBC';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);
  strCodAgen := fGetBancoConfig(0, 'CONFIG399-' + IntToStr(intCartei), 'CODAGEN', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG399-' + IntToStr(intCartei), 'CODCART', '');
  strDiaPro  := fGetBancoConfig(0, 'CONFIG399-' + IntToStr(intCartei), 'DIAPROT', '');
  strInstru1 := fGetBancoConfig(0, 'CONFIG399-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2 := fGetBancoConfig(0, 'CONFIG399-' + IntToStr(intCartei), 'INSTRU2', '');
  strCobReg  := fGetBancoConfig(0, 'CONFIG399-' + IntToStr(intCartei), 'CBRAREG', '');
  strCodCden := fGetBancoConfig(0, 'CONFIG399-' + IntToStr(intCartei), 'CODCDEN', '');
  strObs001  := fGetBancoConfig(0, 'CONFIG399-' + IntToStr(intCartei), 'OBSERV1', '');
  strObs002  := fGetBancoConfig(0, 'CONFIG399-' + IntToStr(intCartei), 'OBSERV2', '');
  strObs003  := fGetBancoConfig(0, 'CONFIG399-' + IntToStr(intCartei), 'OBSERV3', '');
  strObs004  := fGetBancoConfig(0, 'CONFIG399-' + IntToStr(intCartei), 'OBSERV4', '');
  strObs005  := fGetBancoConfig(0, 'CONFIG399-' + IntToStr(intCartei), 'OBSERV5', '');
  strRespons := fGetBancoConfig(0, 'CONFIG399-' + IntToStr(intCartei), 'RESPONS', '');
  strCodRem  := fStrZero(fAtuCodSeq('CONFIG399-' + IntToStr(intCartei), 'PROXNUM'), 7);
  strContCor := strCodAgen + fGetBancoConfig(0, 'CONFIG399-' + IntToStr(intCartei), 'NUMCTAC', '');
  strHorRem  := FormatDateTime('hh',fTime()) + FormatDateTime('mm',fTime()) + FormatDateTime('ss',fTime());
  fAtuCodSeq('CONFIG399-' + IntToStr(intCartei), 'PROXNUM');

  If (strCobReg = 'S') Then
    strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date)
  Else
    strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yyyy',VS_Date);

  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG399', 'RELOCAL', '') = 'N' );

  strEnvSacAva := fGetBancoConfig(0, 'CONFIG399-' + IntToStr(intCartei), 'ENVSACAVA', 'S');

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

    qryConsultaGen := fCriaQuery(qryConsultaGen); 

    {***************************************************}
    {* PEGA DADOS DA EMPRESA                           *}
    {************************************************LB*}
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
    strCartei := 'CONFIG399-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriaQuery(Self);

    {***************************************************}
    {* PEGA DADOS DO CLIENTE                           *}
    {************************************************LB*}
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

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************AF*}
      intCodSeq := 1;
      strHeader := '';

      {***************************************************}
      {* HEADER - COBRANCA REGISTRADA                    *}
      {************************************************LB*}
      If (strCobReg = 'S') Then
      Begin
        strHeader := fPadR   ('0'                , 001)      + //001..001
                     fPadR   ('1'                , 001)      + //002..002
                     fPadR   ('REMESSA'          , 007)      + //003..009
                     fPadR   ('01'               , 002)      + //010..011
                     fPadR   ('COBRANCA'         , 015)      + //012..026
                     fPadL   (strCodAgen         , 005, '0') + //027..031
                     fPadR   ('55'               , 002)      + //032..033
                     fPadL   (strContCor         , 011, '0') + //034..044
                     fPadR   (' '                , 002)      + //045..046
                     fPadR   (strNomEmp          , 030)      + //047..076
                     fPadR   (strCodBco          , 003)      + //077..079
                     fPadR   (strNomBco          , 015)      + //080..094
                     fPadR   (strDtaRem          , 006)      + //095..100
                     fPadR   ('01600'            , 005)      + //101..105
                     fPadR   ('BPI'              , 003)      + //106..108
                     fPadR   (' '                , 002)      + //109..110
                     fPadR   ('LANCV08'          , 007)      + //111..117
                     fPadR   (' '                , 277)      + //118..394
                     fStrZero(IntToStr(intCodSeq), 006);       //395..400
      End
      Else
      Begin

        {***************************************************}
        {* HEADER - COBRANCA SEM REGISTRO                  *}
        {************************************************LB*}
        strHeader := fPadR   ('0'                 , 001)      + //001..001
                     fPadR   ('1'                 , 001)      + //002..002
                     fPadR   ('REMESSA'           , 007)      + //003..009
                     fPadR   ('01'                , 002)      + //010..011
                     fPadR   ('COBRANCA CNR'      , 015)      + //012..026
                     fPadL   (LeftStr(strContCor,10), 010, '0') + //027..036
                     fPadR   (' '                 , 010)      + //037..046
                     fPadL   (strNomEmp           , 030)      + //047..076
                     fPadR   (strCodBco           , 003)      + //077..079
                     fPadR   (strNomBco           , 015)      + //080..094
                     fPadR   (strDtaRem           , 008)      + //095..102
                     fPadR   ('01600'             , 005)      + //103..107
                     fPadR   ('BPI'               , 003)      + //108..110
                     fPadR   (strHorRem           , 006)      + //111..116
                     fPadR   ('0000'              , 004)      + //117..120
                     fPadR   ('0'                 , 001)      + //121..121
                     fPadR   (' '                 , 001)      + //122..122
                     fPadR   ('09'                , 002)      + //123..124
                     fPadR   ('0'                 , 001)      + //125..125
                     fPadR   ('1'                 , 001)      + //126..126
                     fPadR   ('0'                 , 001)      + //127..127
                     fPadR   (' '                 , 094)      + //128..221
                     fPadR   (' '                 , 042)      + //222..263
                     fPadR   (' '                 , 042)      + //264..305
                     fPadR   (' '                 , 042)      + //306..347
                     fPadR   ('Y2K'               , 003)      + //348..350
                     fPadR   (' '                 , 044)      + //351..394
                     fStrZero(IntToStr(intCodSeq) , 006);       //395..400
      End;

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************AF*}
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG399-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);

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

          fltValAtr := fFormataFloat((FieldByName('CBI_VALDUP').AsFloat *
                              FieldByName('CBI_PORCEN').AsFloat) / 100, 2);

          If FieldByName('CBI_CGCCPF').AsInteger = 1 Then
            strCpfCgc := '2'
          Else
            strCpfCgc := '1';

          If (strCobReg = 'S') Then
          Begin
            strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                         FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                         FormatDateTime('yy',FieldByName('CBI_DTAVEN').AsDateTime);
          End
          Else
          Begin
            strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                         FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                         FormatDateTime('yyyy',FieldByName('CBI_DTAVEN').AsDateTime);
          End;

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
          AstrEndereco38 := RetornaEnderecoENumeroCom38Caracteres(qryRemessa.FieldByName('ENDERE').AsString, qryRemessa.FieldByName('NUMERO').AsString);

          strCgcEmp := Trim(strCgcEmp);
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

          strCgcCli := Trim(FieldByName('CBI_C_G_C_').AsString);
          strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

          If (strCobReg = 'S') Then
          Begin

            {***************************************************}
            {* DETALHE - COBRANCA REGISTRADA                   *}
            {************************************************LB*}
            strTransacao := fPadR      ('1'                                     , 01)      + //001..001
                            fPadR      ('02'                                    , 02)      + //002..003
                            fPadL      (strCgcEmp                               , 14, '0') + //004..017
                            fPadL      (strCodAgen                              , 05, '0') + //018..022
                            fPadR      ('55'                                    , 02)      + //023..024
                            fPadL      (strContCor                              , 11, '0') + //025..035
                            fPadR      (' '                                     , 02)      + //036..037
                            fPadR      (strKeyDup                               , 25)      + //038..062
                            fPadL      (FieldByName('CBI_NOSNUM').AsString      , 11, '0') + //063..073
                            fStrZero   ('0'                                     , 06)      + //074..079
                            fStrZero   ('0'                                     , 11)      + //080..090
                            fStrZero   ('0'                                     , 06)      + //091..096
                            fStrZero   ('0'                                     , 11)      + //097..107
                            fPadR      (strCodCar                               , 01)      + //108..108
                            fPadR      ('01'                                    , 02)      + //109..110
                            fPadR      (RightStr(FieldByName('CBI_NUMDUP').AsString +
                                                 FieldByName('CBI_PARCEL').AsString, 10), 10)      + //111..120
                            fPadR      (strDtaVen                               , 06)      + //121..126
                            fValNumForm(FieldByName('CBI_VALDUP').AsFloat       , 13)      + //127..139
                            fPadR      (strCodBco                               , 03)      + //140..142
                            fStrZero   ('0'                                     , 05)      + //143..147
                            fPadR      (IIF(strRespons = 'B','09','98')         , 02)      + //148..149
                            fPadR      ('N'                                     , 01)      + //150..150
                            fPadR      (strDtaEmi                               , 06)      + //151..156
                            fPadR      (strInstru1                              , 02)      + //157..158
                            fPadR      (strInstru2                              , 02)      + //159..160
                            fValNumForm(fltValAtr                               , 13)      + //161..173
                            fStrZero   ('0'                                     , 06)      + //174..179
                            fStrZero   ('0'                                     , 13)      + //180..192
                            fStrZero   ('0'                                     , 13)      + //193..205
                            fStrZero   ('0'                                     , 13)      + //206..218
                            fStrZero   (strCpfCgc                               , 02)      + //219..220
                            fPadL      (strCgcCli                               , 14, '0') + //221..234
                            fPadR      (FieldByName('CLI_NOMCLI').AsString      , 40)      + //235..274
                            fPadR      (AstrEndereco38                            , 38)      + //275..312
                            fPadR      (' '                                     , 02)      + //313..314
                            fPadR      (FieldByName('BAIRRO').AsString          , 12)      + //315..326
                            fPadR      (FieldByName('C_E_P_').AsString          , 08, '0') + //327..334
                            fPadR      (FieldByName('CIDADE').AsString          , 15)      + //335..349
                            fPadR      (FieldByName('ESTADO').AsString          , 02)      + //350..351
                            fPadR      (IIF(strEnvSacAva = 'N', '', strNomEmp)  , 39)      + //352..390
                            fPadR      (' '                                     , 01)      + //391..391
                            fStrZero   (strDiaPro                               , 02)      + //392..393
                            fPadR      ('9'                                     , 01)      + //394..394
                            fStrZero   (IntToStr(intCodSeq)                     , 06);       //395..400
          End
          Else
          Begin

            {***************************************************}
            {* DETALHE - COBRANCA NAO REGISTRADA               *}
            {************************************************LB*}
            strTransacao := fPadR      ('1'                                     , 01)      + //001..001
                            fPadR      ('99'                                    , 02)      + //002..003
                            fStrZero   (LeftStr(strContCor,10)                  , 10)      + //004..013
                            fPadR      (' '                                     , 24)      + //014..037
                            fStrZero   ('0'                                     , 03)      + //038..040
                            fStrZero   (FieldByName('CBI_NOSNUM').AsString      , 13)      + //041..053
                            fPadR      (' '                                     , 54)      + //054..107
                            fStrZero   ('0'                                     , 01)      + //108..108
                            fStrZero   ('01'                                    , 02)      + //109..110
                            fStrZero   ('1'                                     , 03)      + //111..113
                            fStrZero   ('1'                                     , 03)      + //114..116
                            fStrZero   ('1'                                     , 03)      + //117..119
                            fPadR      (' '                                     , 01)      + //120..120
                            fPadR      (strDtaVen                               , 08)      + //121..128
                            fValNumForm(FieldByName('CBI_VALDUP').AsFloat       , 12)      + //129..140
                            fPadR      (strCodBco                               , 03)      + //141..143
                            fPadR      (' '                                     , 04)      + //144..147
                            fPadR      ('99'                                    , 02)      + //148..149
                            fPadR      ('N'                                     , 01)      + //150..150
                            fPadR      (' '                                     , 30)      + //151..180
                            fStrZero   ('0'                                     , 12)      + //181..192
                            fStrZero   ('0'                                     , 08)      + //193..200
                            fPadR      (' '                                     , 18)      + //201..218
                            fPadR      ('98'                                    , 02)      + //219..220
                            fPadR      (' '                                     , 06)      + //221..226
                            fPadR      (FieldByName('C_E_P_').AsString          , 08, '0') + //227..234
                            fPadR      (FieldByName('CLI_NOMCLI').AsString      , 40)      + //235..274
                            fPadR      (AstrEndereco                            , 40)      + //275..314
                            fPadR      (FieldByName('BAIRRO').AsString          , 15)      + //315..329
                            fPadR      (' '                                     , 05)      + //330..334
                            fPadR      (FieldByName('CIDADE').AsString          , 15)      + //335..349
                            fPadR      (FieldByName('ESTADO').AsString          , 02)      + //350..351
                            fPadR      (' '                                     , 42)      + //352..393
                            fPadR      (' '                                     , 01)      + //394..394
                            fStrZero   (IntToStr(intCodSeq)                     , 06);       //395..400

          End;

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************AF*}
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

      {***************************************************}
      {* REGISTRO TIPO 2 - OBSERVACAO / SOMENTE PARA     *}
      {* COBRANCA SEM REGISTRO                           *}
      {************************************************LB*}
      If (strCobReg = 'N') Then
      Begin
        Inc(intCodSeq);

        strRegTipo2  := fPadR      ('2'                                     , 01)      + //001..001
                        fPadR      (strObs001                               , 42)      + //002..043
                        fPadR      (strObs002                               , 42)      + //044..085
                        fPadR      (strObs003                               , 42)      + //086..127
                        fPadR      (strObs004                               , 42)      + //128..169
                        fPadR      (strObs005                               , 42)      + //170..211
                        fPadR      (' '                                     , 42)      + //212..253
                        fPadR      (' '                                     , 42)      + //254..295
                        fPadR      (' '                                     , 99)      + //296..394
                        fStrZero   (IntToStr(intCodSeq)                     , 06);       //395..400

        {******************************}
        {* ESCREVE A TRANSACAO NO TXT *}
        {***************************LB*}
        Writeln(txtTexto,strRegTipo2);
      End;

      {************}
      {* TRAILLER *}
      {*********LB*}
      Inc(intCodSeq);
      strTrailler := '';
      strTrailler := '9'                                + //001..001
                     fPadR   (' '                , 393) + //002..394
                     fStrZero(IntToStr(intCodSeq), 006);  //395..400

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
      CloseFile(txtTexto);
      DeleteFile(strFilePath);

      FreeAndNil(qryRemessa);
      FreeAndNil(qryConsultaGen);
      Raise Exception.Create('Ocorreu um erro ao gerar o arquivo de remessa do banco ' + strCodBco + '-' + strNomBco + #13 +
                             'Erro gerado: ' + E.Message);
		End;
  End;

end;

procedure TfrmExpArqRemHsbc.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemHsbc.edtCodPorKeyPress(Sender: TObject;  var Key: Char);
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


function TfrmExpArqRemHsbc.fRetEmpresa: String;
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

  FreeAndnil(qryCadEmp);
end;

function TfrmExpArqRemHsbc.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemHsbc.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

end.
