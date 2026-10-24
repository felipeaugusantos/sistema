unit untExpArqRemSerrana;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, Data.DB, AppEvnts, BitBtnLockedIncrem,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, frxClass,
  frxExportCSVTestabilidade, untFrameDirectoryEditFocus,
  untFrameCheckComboBoxEmpresa;

type
  TfrmExpArqRemSerrana = class(TfrmPai)
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

    qryConsultaGen,
    qryCadPor     : TUniQuery;

    function fRetEmpresa: String;
    { Private declarations }
  public
    { Public declarations }
    strSimDes: String;
    intCartei: Integer;
    strNomForm : String;

  end;

var
  frmExpArqRemSerrana: TfrmExpArqRemSerrana;

implementation

uses untFuncoes, untfuncoesSimples, untPesqAux, untTypesSistema, untConsultas,
     untLogCtr, untFuncAutban, untAtualizaOcorrenciasCRM, untTypesCRM;

{$R *.dfm}

procedure TfrmExpArqRemSerrana.FormShow(Sender: TObject);
begin
  inherited;
  
  strSimDes := fGetBancoConfig(0, 'CONFIG991-' + IntToStr(intCartei), 'TIPCOBR','');

  If fEmptyStr(strSimDes) Then
    strSimDes := 'S';

  fraPathRemessa.edtDirectory.Text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG991-' + IntToStr(intCartei), 'PATHREM',''));

  edtNomArquivo.Text  := 'DS' +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         'A1.REM';

  If strSimDes = 'S' Then
    edtNomArquivo.Text  := 'CB' +
                           fStrZero(FormatDateTime('dd',VS_Date),2) +
                           fStrZero(FormatDateTime('mm',VS_Date),2) +
                           'A1.REM';

  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemSerrana.btnGerarClick(Sender: TObject);
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
    strExpRem   : String;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;

    fltPerMul,
    fltValDup,
    fltValDpo: Double;

    dtaDtaDpo: TDateTime;

    qryRemessa  : TUniQuery;

    LEndereco,
    strDtaDpo,
    strchkcbEmp,
    strCartei,
    strAutoIncremRem: String;

    blnUsaCnd,
    blnUsaDesPon,
    blnUsaDesPonCli: Boolean;
begin
  inherited;

  If fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
    Exit;

  fraPathRemessa.edtDirectory.Text := fVerBarraFinal(fraPathRemessa.edtDirectory.Text);

  If Not DirectoryExists(fraPathRemessa.edtDirectory.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'Pasta inválida para a exportação.', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa.edtDirectory);
    Exit;
  End;

  intCodSeq  := 1;
  strCodBco  := '991';
  strNomBco  := 'BRADESCO';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);
  strCodRem  := fStrZero(fAtuCodSeq('CONFIG991-' + IntToStr(intCartei), 'PROXNUM'), 7);

  strNumAut  := fGetBancoConfig(0, 'CONFIG991-' + IntToStr(intCartei), 'NUMAUTO', '');
  strCodAge  := fGetBancoConfig(0, 'CONFIG991-' + IntToStr(intCartei), 'CODAGEN', '');
  strEmpBco  := fGetBancoConfig(0, 'CONFIG991-' + IntToStr(intCartei), 'CODEMPR', '');
  strCntCor  := RightStr(fStrZero(fGetBancoConfig(0, 'CONFIG991-' + IntToStr(intCartei), 'NUMCTAC', ''), 7), 7);
  strDigCnt  := fGetBancoConfig(0, 'CONFIG991-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG991-' + IntToStr(intCartei), 'CODCART', '');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);

  strInstru1 := fGetBancoConfig(0, 'CONFIG991-' + IntToStr(intCartei), 'INSTRU1', '');

  If (strInstru1 = '06') Or (strInstru1 = '05') Or (strInstru1 = '18') Then
    strInstru2 := fStrZero(fGetBancoConfig(0, 'CONFIG991-' + IntToStr(intCartei), 'DIAPROT', ''),2)
  Else
    strInstru2 := fGetBancoConfig(0, 'CONFIG991-' + IntToStr(intCartei), 'INSTRU2', '');

  strObserv  := fGetBancoConfig(0, 'CONFIG991-' + IntToStr(intCartei), 'OBSERV1', '');
  blnRemLoc  := Not( fGetBancoConfig(0,'CONFIG991', 'RELOCAL', '') = 'N' );

  fltPerMul  :=  fStrToFloat ( fGetBancoConfig(0, 'CONFIG991-' + IntToStr(intCartei), 'PERMULT', '') );

  blnUsaCnd := fCfgSis('USACND', VarBoolean);

  blnUsaDesPonCli := fCfgSis('DESPON', varBoolean);
  If  blnUsaDesPonCli Then
    blnUsaDesPonCli := fCfgSis('TDEPON') = '2';

  blnUsaDesPon := fCfgSis('DESPON', varBoolean);

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
  If (fGetBancoConfig(0, 'CONFIG991-' + IntToStr(intCartei), 'RESPONS', '') = 'E') Then
    strRespon := '2';

  strDiaPro := '00';
  If strSimDes = 'S' Then
    strDiaPro := fStrZero(fGetBancoConfig(0, 'CONFIG991-' + IntToStr(intCartei), 'DIAPROT', ''),2);

  //*************************************************//
  // FOI CRIADO UM CAMPO NA CONFIGURACAO DO SERRANA //
  // POIS SEGUNDO OS ATENDENTES EXISTEM 2 SITUACOES  //
  // PARA A GERACAO DE REMESSA BANCARIA              //
  //**********************************************ED*//
  strExpRem := fGetBancoConfig(0, 'CONFIG991-' + IntToStr(intCartei), 'EXPOREM', '');
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
    fStartTransaction;
    strCartei  := 'CONFIG991-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
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
                                                  '(SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS ESTADO  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCBI B ';
    strSQL := strSQL + '  JOIN CADCLI C ON C.CLI_CODCLI = B.CBI_CODCLI ';
    strSQL := strSQL + '  JOIN CADREC R ON CTR_NUMDUP = CBI_NUMDUP AND ';
    strSQL := strSQL + '                   CTR_PARCEL = CBI_PARCEL AND ';
    strSQL := strSQL + '                   CTR_ESPDOC = CBI_ESPDOC AND ';
    strSQL := strSQL + '                   CTR_CODEMP = CBI_CODEMP AND ';
    strSQL := strSQL + '                   CTR_CODCLI = CBI_CODCLI     ';

    If blnUsaDesPon Then
      strSQL := strSQL + ' LEFT JOIN CADCND D ON D.CND_CODIGO = B.CBI_CODCND ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  B.CBI_CODBCO = :CODBCO ';

    If fraCheckComboBoxEmpresa.chkcbEmpresa.Text <> 'Todas'Then
    Begin
      strchkcbEmp := fraCheckComboBoxEmpresa.chkcbEmpresa.Text;
      strSQL := strSQL + ' AND CBI_EMPGER IN (' + fRetStrToSQLIn(strchkcbEmp,';') + ') ';
    End;

    if (fCfgSis('CONREM', varString) = 'C') THEN
      strSQL := strSQL + '  AND B.CBI_CARTEI = :CARTEI ';

    If (Not fEmptyStr(edtCodPor.Text)) Then
      strSQL := strSQL + '  AND B.CBI_CODPOR = :CODPOR '
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + ' AND (B.CBI_CODPOR IS NULL ';
      strSQL := strSQL + ' OR B.CBI_CODPOR IN (' + fRetStrToSQLIn(strPortadoresOperador) + ')) ';
    End;

    qryRemessa.SQL.Text := strSQL;
    qryRemessa.ParamByName('CODBCO').AsString := '991';

    if (fCfgSis('CONREM', varString) = 'C') THEN
      qryRemessa.ParamByName('CARTEI').AsString := strCartei;

    If (Not fEmptyStr(edtCodPor.Text)) Then
      qryRemessa.ParamByName('CODPOR').AsString := edtCodPor.Text;

    qryRemessa.Open;

    strCodBco  := '237';
    If Not qryRemessa.IsEmpty Then
    Begin
      AssignFile(txtTexto, fraPathRemessa.edtDirectory.Text + edtNomArquivo.Text);
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
                     fPadR   (strNomEmp          , 030)      + //047
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
                     fPadR   (strNomEmp          , 030)      + //047
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

      //*************************************************//
      // FOI CRIADO UM CAMPO NA CONFIGURACAO DO SERRANA //
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
      pGravaRemGer(VS_strCodEmp, strCodBco, strCartei, StrToInt(strCodRem), strAutoIncremRem);

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
            strObserv  := fGetBancoConfig(0, 'CONFIG991-' + IntToStr(intCartei), 'OBSERV1', '');

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

          strKeyDup := fPadR(FieldByName('CBI_NUMDUP').AsString, 12) +
                       fPadR(FieldByName('CBI_PARCEL').AsString, 03) +
                       fPadR(FieldByName('CBI_ESPDOC').AsString, 02) +
                       fPadR(FieldByName('CBI_CODEMP').AsString, 03);

          LEndereco := RetornaEnderecoENumeroCom40Caracteres(qryRemessa.FieldByName('ENDERE').AsString, qryRemessa.FieldByName('NUMERO').AsString);

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
                            fPadR      (' '                                       , 01)      + //106
                            fPadR      (' '                                       , 02)      + //107
                            fPadR      ('01'                                      , 02)      + //109
                            fPadR      (LeftStr(strKeyDup, 09)                    , 10)      + //111
                            fPadR      (strDtaVen                                 , 06)      + //121
                            fValNumForm(fltValDup                                 , 13)      + //127
                            fStrZero   ('0'                                       , 03)      + //140
                            fStrZero   ('0'                                       , 05)      + //143
                            fPadR      ('01'                                      , 02)      + //148
                            fPadR      ('N'                                       , 01)      + //150
                            fPadR      (strDtaEmi                                 , 06)      + //151
                            fPadR      (strInstru1                                , 02)      + //157
                            fPadR      (IIF(strInstru1 = '06',strDiaPro,strInstru2) , 02)    + //159 Protesto
                            fValNumForm(fltValAtr                                 , 13)      + //161
                            fPadR(IIF(fltValDpo > 0,strDtaDpo,IIF(FieldByName('CBI_DESSUJ').AsFloat > 0,strDtaVen, '0')), 06,'0')  + //174
                            IIF(fltValDpo > 0, fValNumForm(fltValDpo, 13), fValNumForm(FieldByName('CBI_DESSUJ').AsFloat, 13))     + //180
                            fStrZero   ('0'                                       , 13)      + //193
                            fStrZero   ('0'                                       , 13)      + //206
                            fStrZero   (strCpfCgc                                 , 02)      + //219
                            fPadL      (strCgcCli                                 , 14, '0') + //221
                            fPadR      (FieldByName('CLI_NOMCLI').AsString        , 40)      + //235
                            fPadR      (LEndereco                                 , 40)      + //275
                            fPadR      (' '                                       , 12)      + //315
                            fPadL      (LeftStr(FieldByName('C_E_P_').AsString,5) , 05, '0') + //327
                            fPadL      (RightStr(FieldByName('C_E_P_').AsString,3), 03, '0') + //332
                            fPadR      (strObserv                                 , 60)      + //335
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
                            fPadR      (LeftStr(strKeyDup, 09)                    , 10)      + //111
                            fPadR      (strDtaVen                                 , 06)      + //121
                            fValNumForm(fltValAtr                                 , 13)      + //127
                            fPadR      (' '                                       , 08)      + //140
                                        '01'                                                 + //148
                            fPadR      (' '                                       , 01)      + //150
                            fStrZero   ('0'                                       , 68)      + //151
                            fStrZero   (strCpfCgc                                 , 02)      + //219
                            fPadL      (strCgcCli                                 , 14, '0') + //221
                            fPadR      (FieldByName('CLI_NOMCLI').AsString        , 40)      + //235
                            fPadR      (LEndereco                                 , 40)      + //275
                            fPadR      (' '                                       , 12)      + //315
                            fPadL      (LeftStr(FieldByName('C_E_P_').AsString,5) , 05, '0') + //327
                            fPadL      (RightStr(FieldByName('C_E_P_').AsString,3), 03, '0') + //332
                            fPadR      (strObserv                                 , 60)      + //335
                            fStrZero   (IntToStr(intCodSeq)                       , 06);       //395

            {******************************}
            {* ESCREVE A TRANSACAO NO TXT *}
            {***************************AF*}
            Writeln(txtTexto,strTransacao);

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
                       '');

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

      strCodBco := '991';
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

      If fCommit Then
      Begin
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

        fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                     'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.Text + edtNomArquivo.Text, ['&O K']);
      End;

    End
    Else
    Begin
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
    End;

    FreeAndNil(qryRemessa);
  Except
    On E: Exception Do
		Begin

		  fRollBack;

      Try
        CloseFile(txtTexto);
      Except
        //Caso o erro acontecer após o arquivo já estiver fechado
      End;

      If FileExists(fraPathRemessa.edtDirectory.Text + edtNomArquivo.Text) Then
        DeleteFile(fraPathRemessa.edtDirectory.Text + edtNomArquivo.Text);

      FreeAndNil(qryRemessa);

      Raise Exception.Create('Ocorreu um erro ao gerar o arquivo de remessa do banco ' + strCodBco + '-' + strNomBco + #13 +
                             'Erro gerado: ' + E.Message);
		End;
  End;

end;

procedure TfrmExpArqRemSerrana.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS'
  Else
    edtDesPor.Text := fRetNomPortador(edtCodPor.Text);

  If Not CarregaPortador(edtCodPor.Text) Then
     pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemSerrana.edtCodPorKeyPress(Sender: TObject;
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
      If fValidaCampos(edtCodPor, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

function TfrmExpArqRemSerrana.fRetEmpresa: String;
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


procedure TfrmExpArqRemSerrana.FormCreate(Sender: TObject);
begin
  inherited;
   qryCadPor := fCriaQuery(Self); 
end;

end.
