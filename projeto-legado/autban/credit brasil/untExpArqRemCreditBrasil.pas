unit untExpArqRemCreditBrasil;

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
  TfrmExpArqRemCreditBrasil = class(TfrmPai)
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

    qryConsultaGen : TUniQuery;
    qryCadPor   : TUniQuery;

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
  frmExpArqRemCreditBrasil: TfrmExpArqRemCreditBrasil;

implementation

uses untFuncoes, untfuncoesSimples;

{$R *.dfm}

procedure TfrmExpArqRemCreditBrasil.FormShow(Sender: TObject);
begin
  inherited;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG992-' + IntToStr(intCartei), 'PATHREM',''));

  edtNomArquivo.Text  := 'CB' +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         'A.REM';

  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemCreditBrasil.btnGerarClick(Sender: TObject);
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
    strInstru2  : String;
    strObserv   : String;

    strHeader   : String;
    strTransacao: String;
    strTrailler : String;

    intCodSeq   : Integer;
    fltValAtr   : Double;
    txtTexto    : TextFile;
    strRespon   : String;
    strNosNum   : String;
//    strExpBol   : String;
    strExpRem   : String;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    strCartei: String;

    fltPerMul   : Double;

    qryRemessa  : TUniQuery;

    strAutoIncremRem: String;
    AstrEndereco : String;
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

  intCodSeq  := 1;
  strCodBco  := '992';
  strNomBco  := 'BRADESCO';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);
  strCodRem  := fStrZero(fAtuCodSeq('CONFIG992-' + IntToStr(intCartei), 'PROXNUM'), 7);

  strNumAut  := fGetBancoConfig(0, 'CONFIG992-' + IntToStr(intCartei), 'NUMAUTO', '');
  strCodAge  := fGetBancoConfig(0, 'CONFIG992-' + IntToStr(intCartei), 'CODAGEN', '');
  strEmpBco  := fGetBancoConfig(0, 'CONFIG992-' + IntToStr(intCartei), 'CODEMPR', '');
  strCntCor  := RightStr(fStrZero(fGetBancoConfig(0, 'CONFIG992-' + IntToStr(intCartei), 'NUMCTAC', ''), 7), 7);
  strDigCnt  := fGetBancoConfig(0, 'CONFIG992-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG992-' + IntToStr(intCartei), 'CODCART', '');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);

  strInstru1 := fGetBancoConfig(0, 'CONFIG992-' + IntToStr(intCartei), 'INSTRU1', '');

  If (strInstru1 = '06') Or (strInstru1 = '05') Or (strInstru1 = '18') Then
    strInstru2 := fStrZero(fGetBancoConfig(0, 'CONFIG992-' + IntToStr(intCartei), 'DIAPROT', ''),2)
  Else
    strInstru2 := fGetBancoConfig(0, 'CONFIG992-' + IntToStr(intCartei), 'INSTRU2', '');

  strObserv  := fGetBancoConfig(0, 'CONFIG992-' + IntToStr(intCartei), 'OBSERV1', '');
  blnRemLoc  := Not( fGetBancoConfig(0,'CONFIG992', 'RELOCAL', '') = 'N' );

  fltPerMul  :=  fStrToFloat ( fGetBancoConfig(0, 'CONFIG992-' + IntToStr(intCartei), 'PERMULT', '') );

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
  If (fGetBancoConfig(0, 'CONFIG992-' + IntToStr(intCartei), 'RESPONS', '') = 'E') Then
    strRespon := '2';

  strDiaPro := '00';

  strExpRem := fGetBancoConfig(0, 'CONFIG992-' + IntToStr(intCartei), 'EXPOREM', '');
  If fEmptyStr( strExpRem ) Then
    strExpRem := '1';

  Try
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

  Finally
    FreeAndNil(qryConsultaGen);
  End;

  Try
    strCartei  := 'CONFIG992-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
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
    strSQL := strSQL + '  CADCBI B ';
    strSQL := strSQL + '  JOIN CADREC R ON R.CTR_NUMDUP = B.CBI_NUMDUP AND ';
    strSQL := strSQL + '                   R.CTR_PARCEL = B.CBI_PARCEL AND ';
    strSQL := strSQL + '                   R.CTR_ESPDOC = B.CBI_ESPDOC AND ';
    strSQL := strSQL + '                   R.CTR_CODEMP = B.CBI_CODEMP AND ';
    strSQL := strSQL + '                   R.CTR_CODCLI = B.CBI_CODCLI ';
    strSQL := strSQL + '  JOIN CADCLI C ON C.CLI_CODCLI = R.CTR_CODCLI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  B.CBI_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  R.CTR_DTAREC IS NULL ';

    IF fGetBancoConfig(0, 'CONFIG992-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
      strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';

    If (Not fEmptyStr(edtCodPor.Text)) Then
      strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR '
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + ' AND (CBI_CODPOR IS NULL OR CBI_CODPOR = "" OR ';
      strSQL := strSQL + ' CBI_CODPOR IN (' + fRetStrToSQLIn(strPortadoresOperador) + ')) ';
    End;

    With qryRemessa Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;

      If (Not fEmptyStr(edtCodPor.Text)) Then
        ParamByName('CODPOR').AsString := edtCodPor.Text;

      IF fGetBancoConfig(0, 'CONFIG992-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
        ParamByName('CARTEI').AsString := StrCartei;

      Open;
    End;

    strCodBco  := '237';
    If Not qryRemessa.IsEmpty Then
    Begin
      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      Rewrite(txtTexto);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************AF*}
      strHeader := '';


      strHeader := fPadR   ('0'                , 001)      + //001
                   fPadR   ('1'                , 001)      + //002
                   fPadR   ('REMESSA'          , 007)      + //003
                   fPadR   ('01'               , 002)      + //010
                   fPadR   ('COBRANCA'         , 015)      + //012
                   fPadL   (strEmpBco          , 020, '0') + //027
                   fPadR   (strNomEmp          , 030)      + //047
                   fPadR   (strCodBco          , 003)      + //077
                   fPadR   (strNomBco          , 015)      + //080
                   fPadR   (strDtaRem          , 006)      + //095
                   fPadR   (' '                , 008)      + //101
                   fPadR   ('MX'               , 002)      + //109
                   fPadR   (strCodRem          , 007)      + //111
                   fPadR   (' '                , 277)      + //118
                   fStrZero('1'                , 006);       //395

      //*************************************************//
      // FOI CRIADO UM CAMPO NA CONFIGURACAO DO CreditBrasil //
      // POIS SEGUNDO OS ATENDENTES EXISTEM 2 SITUACOES  //
      // PARA A GERACAO DE REMESSA BANCARIA.             //
      // O HEADER NAO MUDA.  ....VER ACIMA               //
      //**********************************************ED*//
      If strExpRem = '2' Then
        strEmpBco := strCntCor + strDigCnt;     

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************AF*}
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, '992', 'CONFIG992-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);


      {************************}
      {* TRANSAÇÃO DO ARQUIVO *}
      {*********************AF*}
      With qryRemessa Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin

          If FieldByName('CBI_ESPDOC').AsString = 'AG' Then
            strObserv  := Trim(Copy(FieldByName('CBI_OBSAG1').AsString, 11, 60))
          Else
            strObserv  := fGetBancoConfig(0, 'CONFIG992-' + IntToStr(intCartei), 'OBSERV1', '');

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

          {*******************************************}
          {* SE BANCO EMITE BOLETO                   *}
          {****************************************MV*}
          strNosNum := FieldByName('CBI_NOSNUM').AsString;
          If (strRespon = '1') Then
            strNosNum := '0';

          strIdeEmp := '0'                    + //021
                       RightStr(fStrZero(strCodCar, 3), 3) + //022
                       RightStr(fStrZero(strCodAge, 5), 5) + //025
                       RightStr(fStrZero(strCntCor, 7), 7) + //030
                       RightStr(fStrZero(strDigCnt, 1), 1);  //037

           strTransacao := fPadR     ('1'                                       , 01)      + //001
                          fStrZero   ('0'                                       , 05)      + //002
                          fPadR      (' '                                       , 01)      + //007
                          fStrZero   ('0'                                       , 05)      + //008
                          fStrZero   ('0'                                       , 07)      + //013
                          fPadR      (' '                                       , 01)      + //020
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
                          fPadR      ('01'                                      , 02)      + //109
                          fPadR      (RightStr(FieldByName('CBI_NUMDUP').AsString, 09)+
                                      FieldByName('CBI_PARCEL').AsString        , 10)      + //111
                          fPadR      (strDtaVen                                 , 06)      + //121
                          fValNumForm(FieldByName('CBI_VALDUP').AsFloat         , 13)      + //127
                          fStrZero   ('0'                                       , 03)      + //140
                          fStrZero   ('0'                                       , 05)      + //143
                          fPadR      ('01'                                      , 02)      + //148
                          fPadR      ('N'                                       , 01)      + //150
                          fPadR      (strDtaEmi                                 , 06)      + //151
                          fPadR      (strInstru1                                , 02)      + //157
                          fPadR      (IIF(strInstru1 = '06',strDiaPro,strInstru2) , 02)    + //159 Protesto
                          fValNumForm(fltValAtr                                 , 13)      + //161
                          fPadR      (strDtaVen                                 , 06)      + //174
                          fValNumForm(FieldByName('CBI_DESSUJ').AsFloat         , 13)      + //180
                          fStrZero   ('0'                                       , 13)      + //193
                          fStrZero   ('0'                                       , 13)      + //206
                          fStrZero   (strCpfCgc                                 , 02)      + //219
                          fPadL      (strCgcCli                                 , 14, '0') + //221
                          fPadR      (FieldByName('CLI_NOMCLI').AsString        , 40)      + //235
                          fPadR      (AstrEndereco                              , 40)      + //275
                          fPadR      (' '                                       , 12)      + //315
                          fPadL      (LeftStr(FieldByName('C_E_P_').AsString,5) , 05, '0') + //327
                          fPadL      (RightStr(FieldByName('C_E_P_').AsString,3), 03, '0') + //332
                          fPadR      (strObserv                                 , 60)      + //335
                          fStrZero   (IntToStr(intCodSeq)                       , 06);       //395

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

          {****************}
          {* GRAVA LOGCTR *}
          {*************JS*}
          untLogCtr.GravaLogCtr(FieldByName('AUTOINCREM').AsString, 'EXPORTAÇÃO DE ARQUIVO DE REMESSA - 992', Self.Name);

          Next;
        End;

      End;

      strCodBco := '992';
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

      pBackupCnfBco;

      fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                   'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM ';
      strSQL := strSQL + '  CADCBI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + 'CBI_CODBCO = :CODBCO ';

      If (Not fEmptyStr(edtCodPor.Text)) Then
        strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR ';

      IF fGetBancoConfig(0, 'CONFIG992-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
        strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';

      With qryRemessa Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODBCO').AsString := strCodBco;

        If (Not fEmptyStr(edtCodPor.Text)) Then
          ParamByName('CODPOR').AsString := edtCodPor.Text;

        IF fGetBancoConfig(0, 'CONFIG992-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
          ParamByName('CARTEI').AsString := StrCartei;

        ExecSQL;
        Close;
      End;

    End
    Else
    Begin
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
    End;

  Finally
    FreeAndNil(qryRemessa);
  End;

end;

procedure TfrmExpArqRemCreditBrasil.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemCreditBrasil.edtCodPorKeyPress(Sender: TObject;
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

function TfrmExpArqRemCreditBrasil.fRetEmpresa: String;
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
  {**************}
  {* 14/01/2011 *}
  {***********RV*}
  intCount := 1;

  If Length(arrResult) > 1 Then
    intCount := fGetMenu('Selecione a Empresa', arrResult, 0);

  Result   := LeftStr(arrResult[intCount -1], 3);

  FreeAndNil(qryCadEmp);
end;

function TfrmExpArqRemCreditBrasil.fValidaCampos(Sender: TWinControl;
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
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmExpArqRemCreditBrasil.FormCreate(Sender: TObject);
begin
  inherited;
   qryCadPor := fCriaQuery(Self); 
end;

end.
