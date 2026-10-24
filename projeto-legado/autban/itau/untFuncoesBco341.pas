{***************************}
{* UNIT FUNCOES DO BANCO   *}
{* ITAU                    *}
{************************AJ*}

unit untFuncoesBco341;

interface

Uses Windows, Classes, Dialogs, untFuncoes, untFuncoesSimples, Uni, StrUtils,
     SysUtils, Variants, Forms, DB;

Type
  TFuncoesBco341 = class
  private
    FblnEnvPro: Boolean;

    function fRetEmpresa: String;
    { Private Declarations}
  public
    Constructor Create();
    function fExpArqRem(strConfig, strCodPor, strArqRem: String): Boolean;

    property blnEnvPro: Boolean read FblnEnvPro write FblnEnvPro;
  end;

implementation

{ TArqExpBco341 }

uses untConstantes, untFuncAutBan;

constructor TFuncoesBco341.Create();
Begin
  FblnEnvPro := False;
End;

function TFuncoesBco341.fRetEmpresa: String;
  Var
    intCount  : Integer;
    arrResult : Array Of String;
    qryCadEmp : TUniQuery;

Begin

  qryCadEmp := fCriaQuery();
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

function TFuncoesBco341.fExpArqRem(strConfig, strCodPor, strArqRem: String): Boolean;
Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strNomEmp   : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaMor   : String;
    strDtaEmi   : String;
    strKeyDup   : String;
    strCgcEmp   : String;
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
    strMandMsg  : String;
    strObsAgru  : String;
    strCep      : String;
    strNumDup   : String;

    strHeader   : String;
    strTransacao: String;
    strMensagem : String;
    strTrailler : String;
    strMsg1     : String;
    strMsg2     : String;
    strMsg3     : String;
    strCodFlash : String;
    strCartSeq  : String;
    strFilePath : String;
    strCartei: String;
    strAutoIncremRem: String;

    intCartei   : Integer;

    intCodSeq   : Integer;
    fltValAtr   : Double;
    txtTexto    : TextFile;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    qryRemessa  : TUniQuery;
    qryConsultaGen: TUniQuery;
begin
  Result := True;
  strCodBco  := StringReplace(Copy(strConfig, 1, Pos('-', strConfig) - 1), 'CONFIG', EmptyStr, []);
  intCartei  := StrToInt(Copy(strConfig, Pos('-', strConfig) + 1, 1));
  strNomBco  := 'BANCO ITAU SA';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);
  strCodAgen := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'CODAGEN', '');
  strContCor := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'NUMCTAC', '');
  strDigCnt  := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'NUMCART', '');
  strDigCar  := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'CODCART', '');
  strMandMsg := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'MANDMSG', '');
  strInstru1 := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'INSTRU1', '');
  strDiaPro  := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'DIAPROT', '');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);
  blnRemLoc  := (Not( fGetBancoConfig(0, 'CONFIG341', 'RELOCAL', '') = 'N' )) Or (FblnEnvPro);

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
    Result := False;
    Exit;
  End;

  Try
    fStartTransaction;
    strCartei := 'CONFIG341-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
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

    qryRemessa := fCriaQuery();

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
    strSQL := strSQL + '  R.CTR_DTAREC AS CTR_DTAREC, C.CLI_PERDPO, C.CLI_QTDDAV, ';
    strSQL := strSQL + '  R.CTR_DESCOB AS CTR_DESCOB, ';
    strSQL := strSQL + '  R.CTR_JURSUJ AS CTR_JURSUJ, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", CONCAT(C.CLI_ENDERE, ", ", IFNULL(C.CLI_ENDNUM, ""), IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM))), C.CLI_ENDCOB) AS ENDERE, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_BAIRRO, C.CLI_BAICOB) AS BAIRRO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_C_E_P_, C.CLI_CEPCOB) AS C_E_P_, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                  '(SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS CIDADE, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                  '(SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS ESTADO  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCBI B ';
    strSQL := strSQL + '  JOIN CADREC R ON R.CTR_NUMDUP = B.CBI_NUMDUP AND ';
    strSQL := strSQL + '      R.CTR_PARCEL = B.CBI_PARCEL AND ';
    strSQL := strSQL + '      R.CTR_ESPDOC = B.CBI_ESPDOC AND ';
    strSQL := strSQL + '      R.CTR_CODEMP = B.CBI_CODEMP AND ';
    strSQL := strSQL + '      R.CTR_CODCLI = B.CBI_CODCLI     ';
    strSQL := strSQL + '  JOIN CADCLI C ON C.CLI_CODCLI = B.CBI_CODCLI ';
    strSQL := strSQL + 'WHERE ';
    If (Not FblnEnvPro) Then
      strSQL := strSQL + '  B.CBI_CODBCO = :CODBCO '
    Else
      strSQL := strSQL + '  COALESCE(B.CBI_CODBCO, "") = "" ';

    If (Not fEmptyStr(strCodPor)) Then
      strSQL := strSQL + '  AND B.CBI_CODPOR = :CODPOR '
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + ' AND (IFNULL(B.CBI_CODPOR, "") = "" ';
      strSQL := strSQL + ' OR LOCATE(B.CBI_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    strSQL := strSQL + '  AND R.CTR_DTAREC IS NULL ';

    With qryRemessa Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If (Not FblnEnvPro) Then
        ParamByName('CODBCO').AsString := strCodBco;

      If (Not fEmptyStr(strCodPor)) Then
        ParamByName('CODPOR').AsString := strCodPor;

      Open;
    End;

    If Not qryRemessa.IsEmpty Then
    Begin
      //Gerando número da remessa e atualizando carteiras "filhas"
      If (Not FblnEnvPro) Then
      Begin
        strCartSeq := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'SEQCART', '');
        strCodRem  := fStrZero(fAtuCodSeq('CONFIG341-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq), 'PROXNUM'), 7);
        pAtualizaProxNumCartsAutBan('CONFIG341-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq));
      End;

      AssignFile(txtTexto, strArqRem);
      strFilePath := strArqRem;
      Rewrite(txtTexto);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************AF*}
      intCodSeq := 1;
      strHeader := '';
      If (Not FblnEnvPro) Then
      Begin
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
                       fPadR   (strNomEmp          , 030) + //047
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
                       fPadR   (strNomEmp          , 030) + //047
                       fPadR   (strCodBco          , 003) + //077
                       fPadR   (strNomBco          , 015) + //080
                       fPadR   (strDtaRem          , 006) + //095
                       fPadR   (' '                , 294) + //101
                       fStrZero(IntToStr(intCodSeq), 006);  //395
        End;
      End
      Else
      Begin
        {*********************************}
        {* GERAÇÃO REMESSA PARA PROTESTO *}
        {******************************AJ*}
        strHeader := fPadR   ('0'                , 001) + //001
                     fPadR   ('1'                , 001) + //002
                     fPadR   ('REMESSA'          , 007) + //003
                     fPadR   ('01'               , 002) + //010
                     fPadR   ('COBRANCA'         , 015) + //012
                     fStrZero('0'                , 004) + //027
                     fPadR   ('00'               , 002) + //031
                     fStrZero('0'                , 005) + //033
                     fStrZero('0'                , 001) + //038
                     fPadR   (' '                , 008) + //039
                     fPadR   (strNomEmp          , 030) + //047
                     fPadR   (strCodBco          , 003) + //077
                     fPadR   (strNomBco          , 015) + //080
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
      pGravaRemGer(VS_strCodEmp, strCodBco, StrCartei, 0 , strAutoIncremRem);

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

          If (qryRemessa.FieldByName('CBI_ESPDOC').AsString = 'AG') Then
            strObsAgru := 'REF:_' + COPY(qryRemessa.FieldByName('CBI_OBSAG1').AsString,11,23);

          If (strMandMsg = 'S') Then
          Begin
            strObsAgru := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'OBSERV1', '');

            strInstru1 := '93';
            strInstru2 := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'INSTRU2', '');

            strMsg1    := qryRemessa.FieldByName('CBI_OBSAG1').AsString;
            strMsg2    := qryRemessa.FieldByName('CBI_OBSAG2').AsString;
            strMsg3    := qryRemessa.FieldByName('CBI_OBSAG3').AsString;

            If fEmptyStr(fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'CDFLASH', '')) Then
            Begin
              strObsAgru := strObsAgru + ' ' + strMsg1 + ' ' +  strMsg2 + ' ' + strMsg3;
              strCodFlash:= '';
            End
            Else
              strCodFlash:= fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'CDFLASH', '');
          End
          Else
          Begin
            strObsAgru := ' ';
            strInstru1 := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'INSTRU1', '');
            strInstru2 := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'INSTRU2', '');
          End;

          strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTAVEN').AsDateTime);

          strDtaMor := FormatDateTime('ddmmyy', FieldByName('CBI_DTAVEN').AsDateTime+1);

          strDtaEmi := FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTACAD').AsDateTime);

          if not TEspecieParaArquivoRemessa.New.fValidaEspecie(FieldByName('CBI_ESPDOC').AsString) then
          begin
            fRollBack;
            CloseFile(txtTexto);
            If FileExists(strArqRem) Then
              DeleteFile(strArqRem);
            Exit;
          end;

{          strKeyDup := fPadR(FieldByName('CBI_NUMDUP').AsString, 12) +
                       fPadR(FieldByName('CBI_PARCEL').AsString, 03) +
                       fPadR(FieldByName('CBI_ESPDOC').AsString, 02) +
                       fPadR(FieldByName('CBI_CODEMP').AsString, 03) +
                       fPadR(FieldByName('CBI_SERIE_').AsString, 03);}

          strNumDup := (FieldByName('CBI_NUMDUP').AsString) + (FieldByName('CBI_PARCEL').AsString);

          strKeyDup := fPadR(FieldByName('CBI_NUMDUP').AsString, 12) +
                       fPadR(FieldByName('CBI_PARCEL').AsString, 03) +
                       fPadR(FieldByName('CBI_ESPDOC').AsString, 02) +
                       fPadR(FieldByName('CBI_CODEMP').AsString, 03);

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

          If (not FblnEnvPro) Then
          Begin
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
                                                   FieldByName('CBI_PARCEL').AsString, 10), 10)      + //111
                              fPadR      (strDtaVen                               , 06)      + //121
                              fValNumForm(FieldByName('CBI_VALDUP').AsFloat       , 13)      + //127
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
                              fPadR      (FieldByName('ENDERE').AsString          , 40)      + //275
                              fPadR      (FieldByName('BAIRRO').AsString          , 12)      + //315
                              fPadR      (strCep                                  , 08, '0') + //327
                              fPadR      (FieldByName('CIDADE').AsString          , 15)      + //335
                              fPadR      (FieldByName('ESTADO').AsString          , 02)      + //350
                              fPadR      (strObsAgru                              , 30)      + //352
                              fPadR      (' '                                     , 04)      + //382
                              fPadR      (strDtaMor                               , 06)      + //386
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
                              fPadR      (LeftStr(fStrZero(FieldByName('CBI_NOSNUM').AsString,8),8)                         , 08, '0') + //063
                              fStrZero   ('0'                                                                    , 13)      + //071
                              fStrZero   (strCodCar                                                              , 03)      + //084
                              fPadR      (' '                                                                    , 21)      + //087
                              fPadR      (strDigCar                                                              , 01)      + //108
                              fPadR      ('01'                                                                   , 02)      + //109
                              fPadR      (RightStr(FieldByName('CBI_NUMDUP').AsString +
                                                   FieldByName('CBI_PARCEL').AsString, 10), 10)      + //111
                              fPadR      (strDtaVen                                                              , 06)      + //121
                              fValNumForm(FieldByName('CBI_VALDUP').AsFloat                                      , 13)      + //127
                              fPadR      (strCodBco                                                              , 03)      + //140
                              fStrZero   ('0'                                                                    , 05)      + //143
                              fPadR      ('01'                                                                   , 02)      + //148
                              fPadR      ('N'                                                                    , 01)      + //150
                              fPadR      (strDtaEmi                                                              , 06)      + //151
                              fPadR      (strInstru1 {85}                                                        , 02)      + //157
                              fPadR      (strInstru2 {'05'}                                                      , 02)      + //159
                              fValNumForm(fltValAtr                                                              , 13)      + //161
                              fStrZero   ('0'                                                                    , 06)      + //174
                              fStrZero   ('0'                                                                    , 13)      + //180
                              fStrZero   ('0'                                                                    , 13)      + //193
                              fStrZero   ('0'                                                                    , 13)      + //206
                              fStrZero   (strCpfCgc                                                              , 02)      + //219
                              fPadL      (strCgcCli                                                              , 14, '0') + //221
                              fPadR      (FieldByName('CLI_NOMCLI').AsString                                     , 30)      + //235
                              fPadR      (' '                                                                    , 10)      + //265
                              fPadR      (FieldByName('ENDERE').AsString                                         , 40)      + //275
                              fPadR      (FieldByName('BAIRRO').AsString                                         , 12)      + //315
                              fPadR      (strCep                                                                 , 08, '0') + //327
                              fPadR      (FieldByName('CIDADE').AsString                                         , 15)      + //335
                              fPadR      (FieldByName('ESTADO').AsString                                         , 02)      + //350
                              fPadR      (strObsAgru                                                             , 30)      + //352
                              fPadR      (' '                                                                    , 04)      + //382
                              fPadR      (strDtaMor                                                              , 06)      + //386
                              fStrZero   (strDiaPro                                                              , 02)      + //392
                              fPadR      (' '                                                                    , 01)      + //394
                              fStrZero   (IntToStr(intCodSeq)                                                    , 06);       //395
            End;
          End
          Else
          Begin
            {*********************************}
            {* GERAÇÃO REMESSA PARA PROTESTO *}
            {******************************AJ*}
            strTransacao := fPadR      ('1'                                                                    , 01)      + //001
                            fPadR      ('02'                                                                   , 02)      + //002
                            fPadL      (strCgcEmp                                                              , 14, '0') + //004
                            fStrZero   ('0'                                                                    , 04)      + //018
                            fPadR      ('00'                                                                   , 02)      + //022
                            fStrZero   ('0'                                                                    , 05)      + //024
                            fStrZero   ('0'                                                                    , 01)      + //029
                            fPadR      (' '                                                                    , 04)      + //030
                            fStrZero   ('0'                                                                    , 04)      + //034
                            fPadR      (strKeyDup                                                              , 25)      + //038
                            fPadR      (LeftStr(fStrZero(FieldByName('CBI_NOSNUM').AsString,8),8)              , 08, '0') + //063
                            fStrZero   ('0'                                                                    , 13)      + //071
                            fStrZero   ('0'                                                                    , 03)      + //084
                            fPadR      (' '                                                                    , 21)      + //087
                            fPadR      ('0'                                                                    , 01)      + //108
                            fPadR      ('01'                                                                   , 02)      + //109
                            fPadR      (RightStr(FieldByName('CBI_NUMDUP').AsString +
                                                 FieldByName('CBI_PARCEL').AsString, 10), 10)      + //111
                            fPadR      (strDtaVen                                                              , 06)      + //121
                            fValNumForm(FieldByName('CBI_VALDUP').AsFloat                                      , 13)      + //127
                            fPadR      (strCodBco                                                              , 03)      + //140
                            fStrZero   ('0'                                                                    , 05)      + //143
                            fPadR      ('01'                                                                   , 02)      + //148
                            fPadR      ('N'                                                                    , 01)      + //150
                            fPadR      (strDtaEmi                                                              , 06)      + //151
                            fPadR      (strInstru1 {85}                                                        , 02)      + //157
                            fPadR      (strInstru2 {'05'}                                                      , 02)      + //159
                            fValNumForm(fltValAtr                                                              , 13)      + //161
                            fStrZero   ('0'                                                                    , 06)      + //174
                            fStrZero   ('0'                                                                    , 13)      + //180
                            fStrZero   ('0'                                                                    , 13)      + //193
                            fStrZero   ('0'                                                                    , 13)      + //206
                            fStrZero   (strCpfCgc                                                              , 02)      + //219
                            fPadL      (strCgcCli                                                              , 14, '0') + //221
                            fPadR      (FieldByName('CLI_NOMCLI').AsString                                     , 30)      + //235
                            fPadR      (' '                                                                    , 10)      + //265
                            fPadR      (FieldByName('ENDERE').AsString                                         , 40)      + //275
                            fPadR      (FieldByName('BAIRRO').AsString                                         , 12)      + //315
                            fPadR      (strCep                                                                 , 08, '0') + //327
                            fPadR      (FieldByName('CIDADE').AsString                                         , 15)      + //335
                            fPadR      (FieldByName('ESTADO').AsString                                         , 02)      + //350
                            fPadR      (' '                                                                    , 30)      + //352
                            fPadR      (' '                                                                    , 04)      + //382
                            fPadR      (strDtaMor                                                              , 06)      + //386
                            fStrZero   (strDiaPro                                                              , 02)      + //392
                            fPadR      (' '                                                                    , 01)      + //394
                            fStrZero   (IntToStr(intCodSeq)                                                    , 06);       //395
          End;


          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************AF*}
          Writeln(txtTexto,strTransacao);

          {************************}
          {* REGISTRO 7 MENSAGENS *}
          {*********************JU*}
          If (Not fEmptyStr(strCodFlash)) And (Not FblnEnvPro) Then
          Begin
            Inc(intCodSeq);

            strMensagem := '';

            strMensagem := fPadR   ('7',                 001) + //001
                           fPadR   (strCodFlash,         003) + //002
                           fPadR   ('01',                002) + //005
                           fPadR   (strMsg1,             128) + //007
                           fPadR   ('02',                002) + //135
                           fPadR   (strMsg2,             128) + //137
                           fPadR   ('03',                002) + //265
                           fPadR   (strMsg3,             127) + //267
                           fPadR   ('1',                 001) + //394
                           fStrZero(IntToStr(intCodSeq), 006);  //395

            {************************}
            {* ESCREVE AS MENSAGENS *}
            {*********************JU*}
            Writeln(txtTexto,strMensagem);
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
      strTrailler := '9'                                + //001
                     fPadR   (' '                , 393) + //002
                     fStrZero(IntToStr(intCodSeq), 006);  //395

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************AF*}
      Writeln(txtTexto,strTrailler);

      CloseFile(txtTexto);

      //Atualiza Data de Protesto na CADREC
      If FblnEnvPro Then
      Begin
        strSQL := '';
        strSQL := strSQL + 'UPDATE CADREC SET ';
        strSQL := strSQL + '  CTR_DTAPRO = ' + fCurrentDate + ' ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + ' (CTR_NUMDUP, CTR_PARCEL, CTR_ESPDOC, CTR_CODEMP, CTR_CODCLI) ';
        strSQL := strSQL + ' IN (SELECT CBI_NUMDUP,CBI_PARCEL, CBI_ESPDOC, CBI_CODEMP, CBI_CODCLI ';
        strSQL := strSQL + '     FROM CADCBI WHERE COALESCE(CBI_CODBCO, "") = "") ';

        With qryRemessa Do
        Begin
          Close;
          SQL.Text := strSQL;
          ExecSQL;
          Close;
        End;
      End;

      //Apaga os registros da CADCBI
      strSQL := '';
      strSQL := strSQL + 'DELETE FROM ';
      strSQL := strSQL + '  CADCBI ';
      strSQL := strSQL + 'WHERE ';

      If Not FblnEnvPro Then
        strSQL := strSQL + 'CBI_CODBCO = :CODBCO '
      Else
        strSQL := strSQL + 'COALESCE(CBI_CODBCO, "") = "" ';

      If (Not fEmptyStr(strCodPor)) Then
        strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR ';

      With qryRemessa Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        If Not FblnEnvPro Then
          ParamByName('CODBCO').AsString := strCodBco;

        If (Not fEmptyStr(strCodPor)) Then
          ParamByName('CODPOR').AsString := strCodPor;

        ExecSQL;
        Close;
      End;

      pBackupCnfBco;

      If fCommit then
		    fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
				          'Arquivo Gerado: ' + strArqRem, ['&O K']);
    End
    Else
    Begin
      fRollback;
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
    End;

  Finally
    FreeAndNil(qryRemessa);
		FreeAndNil(qryConsultaGen);
  End;
end;

end.
