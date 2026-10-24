unit untFuncoesBco422;

interface
{$WARN UNIT_PLATFORM OFF}

Uses Windows, Classes, Dialogs, untFuncoes, untFuncoesSimples, Uni, StrUtils,
     SysUtils, Variants, Forms, DB, untFuncoesBoleto, untFuncAutBan,
     UniClientDataSet, FileCtrl, untTCadPag, untTCadPagRepository,
     cxProgressBar;

Type
  TFuncoesBco422 = class
  private
    FblnEnvPro: Boolean;
    FcdsNaoGra: TUniClientDataSet;
    FfrmRetBco: TForm;

    function fRetEmpresa: String;
    { Private Declarations}
  public
    Constructor Create();
    function fExpArqRemCta(strConfig, strArqRem: String): Boolean;
    function fImpRetornoSafraCTP(qryRetCtp: TUniQuery; strPath: String; lstArquivo: TFileListBox; cxgProgresso: TcxProgressBar = nil): Boolean;

    property blnEnvPro: Boolean read FblnEnvPro write FblnEnvPro;
    property cdsNaoGra: TUniClientDataSet read FcdsNaoGra write FcdsNaoGra;
    property frmRetBco: TForm read FfrmRetBco write FfrmRetBco;
  end;


implementation

Uses untRetBco, untLogCtp, untGravando;

{ TFuncoesBco422 }

constructor TFuncoesBco422.Create;
begin
  FblnEnvPro := False;
end;

function TFuncoesBco422.fImpRetornoSafraCTP(qryRetCtp: TUniQuery; strPath: String;
  lstArquivo: TFileListBox; cxgProgresso: TcxProgressBar): Boolean;
  Var
    txtTexto   : TextFile;
    intContador: Integer;
    blnExiste: Boolean;
    strLinha : String;
    strParcel: String;
    strNumCtp: String;
    strDtaOco: String;
    strDtaVen: String;
    strDtaPag: String;
    strNumDup: String;
    strCodFor: String;
    strCodEmp: String;
    strSerie_: String;
    strNomArq: String;
    strCodBco: String;
    strDesCon: String;
    strCodOco: String;
    strValDup: String;
    strValPag: String;
    strJurMor: String;
    strNosNum: String;
    strCodRej: String;
    strMotOco: String;
    dtaDtaArq: TDateTime;
    intQtdDup: Integer;
    strAutInc: String;
    strSeqBai: String;
    strVenCtp: String;

    blnImport: Boolean;

    objPag: TCadPag;
    objRep: TCadPagRepository;
    strGetCodFor: String;

    intLinha : Integer;
    intLinhas: Integer;
begin
  Result := True;

  fAbrirTabela(qryRetCtp);

  blnExiste := False;
  blnImport := False;

  Try

    For intContador := 0 To lstArquivo.Count-1 Do
    Begin

      If lstArquivo.Selected[intContador] Then
      Begin
        {************************}
        {* PEGA DATA DO ARQUIVO *}
        {*********************AF*}
        FileAge(strPath + '\' + lstArquivo.Items.Strings[intContador],dtaDtaArq);

        AssignFile(txtTexto,strPath + '\' + lstArquivo.Items.Strings[intContador]);
        Reset(txtTexto);
        Readln(txtTexto,strLinha);

        intLinhas := fContaLinhasArq(strPath + '\' + lstArquivo.Items.Strings[intContador]);

        If (Copy(strLinha, 3, 7) <> 'RETORNO') Or (Copy(strLinha, 77, 3) <> '422') Or
           (Copy(strLinha, 2, 1) <> '2') Then
          Continue;

        intLinha := 0;

        While Not Eof(txtTexto) Do
        Begin
          Readln(txtTexto,strLinha);

          pProgresso(fInc(intLinha), intLinhas -1, cxgProgresso);

          {*****************************************}
          {* VERIFICA SE FOR ULTIMA LINHA ELE PULA *}
          {**************************************AF*}
          If Eof(txtTexto) Then
            Continue;

          blnImport := True;

          strNomArq := lstArquivo.Items.Strings[intContador];
          strNumCtp := Trim(Copy(strLinha,038,25));
          strAutInc := strNumCtp;

          strNumDup := Copy(strLinha, 080,09);
          strParcel := Copy(strLinha, 089,01);
          strCodFor := '';
          strCodEmp := '';
          strSerie_ := '';


          strDtaOco := Copy(strLinha,111,06);
          If Not fEmptyStr(strDtaOco) And (strDtaOco <> '000000') Then
          Begin
            System.Insert('/',strDtaOco,3);
            System.Insert('/',strDtaOco,6);
          End;

          strDtaVen := Copy(strLinha,99,08);
          If Not fEmptyStr(strDtaVen) And (strDtaVen <> '000000') Then
          Begin
            System.Insert('/',strDtaVen,3);
            System.Insert('/',strDtaVen,6);
          End;

          strCodOco := Copy(strLinha,109,02);

          strDesCon := Copy(strLinha,205,13);
          strValDup := Copy(strLinha,153,13);
          strValPag := Copy(strLinha,218,13);
          strJurMor := Copy(strLinha,166,13);
          strCodBco := '422';
          strCodRej := '';
          strMotOco := '';

          If fStrToFloat(strValPag) > 0 Then
          Begin
            strDtaPag := Copy(strLinha,91,08);
            If Not fEmptyStr(strDtaPag) And (strDtaPag <> '000000') Then
            Begin
              System.Insert('/',strDtaPag,3);
              System.Insert('/',strDtaPag,6);
            End;
          End;

          {********************************************}
          {* VERIFICA SE A DUPLICATA EXISTE NO CADPAG *}
          {*****************************************AJ*}
          If fVerificaExisteDuplicContasPagar(strAutInc, strCodFor, strNumDup, strParcel, strCodEmp, strSeqBai, strSerie_, strVenCtp) Then
          Begin

            If Not blnExiste Then
              pDeletaArqBcoContasPagar('422');;

            pGravaArqBcoContasPagar(strParcel, strNumDup, strCodFor, strCodEmp, strSeqBai, strSerie_,
                                    strCodBco, '', strNosNum, strCodOco, strMotOco, strValDup,
                                    strDesCon, strJurMor, strValPag, strDtaVen, strDtaPag, strNomArq,
                                    strAutInc, dtaDtaArq, qryRetCtp);

            {****************}
            {* GRAVA LOGCTP *}
            {*************JS*}
            objRep := TCadPagRepository.Create;
            objPag := objRep.fRetDuplicata(strAutInc);

            If Assigned(objPag) Then
            begin
              strGetCodFor := objPag.objCodFor.FOR_CODFOR;
              untLogCtp.pGravaLogCtp(objPag, 'IMPORTACAO DO ARQUIVO DE RETORNO - CTP - ' + strCodBco, 'frmRetBco');
            end;

            If Assigned(objRep) Then
              FreeAndNil(objRep);

            blnExiste := True;

          End
          Else
            pIncluiOcor(strNosNum, strCodFor, strNumDup, '', strCodEmp,
                        StrToDateDef(strDtaVen, 0), StrToDateDef(strDtaPag, 0),
                        fStrToFloat(strValDup)/100, fStrToFloat(strValPag)/100, FcdsNaoGra);

        End;// fim do while

        CloseFile(txtTexto);

        If Not cdsNaoGra.IsEmpty Then
          TfrmRetBco(FfrmRetBco).pMostraArqNaoBaixa('SAFRA');

        If Not blnExiste Then
        Begin
          fMensagem('ALERTA','Não foi encontrada nenhuma duplicata referente ao Arquivo de Retorno! Portanto ficará em aberto para análise!',['&OK']);
          Continue;
        End;

        If Not fRenomeiaArquivo(strNomArq) Then
        Begin
          TfrmRetBco(FfrmRetBco).pnlInfo.Caption := '';
          Exit;
        End;

        fMensagem('','Arquivo de retorno importado com sucesso!',['&OK']);

      End;// Fim do If
    End;// fim do For

  Except
    On E: Exception Do
    Begin
      pMensagensErro('Ocorreu um erro na gravação dos arquivos!' + E.Message ,'[Gravação do Arquivo de Retorno]');
    End;
  End;

  If Not blnImport Then
    fMensagem('ATENÇÃO','Nenhum arquivo foi importado!',['&OK']);

  TfrmRetBco(FfrmRetBco).pnlInfo.Caption := '';
  FfrmRetBco.Close;

end;

function TFuncoesBco422.fExpArqRemCta(strConfig, strArqRem: String): Boolean;
Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strNomEmp   : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaPag   : String;
    strKeyDup   : String;
    strCompromi : String;
    strCgcEmp   : String;
    strCgcFor   : String;
    strCodAgen  : String;
    strContCor  : String;
    strContDes  : String;
    strCodCar   : String;
    strCodRem   : String;
    strAgeDest  : String;

    strHeader   : String;
    strTransacao: String;
    strTrailler : String;

    intCodSeq   : Integer;
    txtTexto    : TextFile;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    qryRemessa  : TUniQuery;
    qryConsultaGen: TUniQuery;

    objPag: TCadPag;
    objRep: TCadPagRepository;
    strGetCodFor: String;
begin
  Result := True;
  strCodBco  := '422';
  strNomBco  := 'BANCO SAFRA S/A';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);
  strCodAgen := fGetBancoConfig(0, strConfig, 'CODAGEN', '');
  strContCor := fGetBancoConfig(0, strConfig, 'NUMCTAC', '');
  strCodRem  := fStrZero(fGetBancoConfig(0, strConfig, 'PROXNUM', ''), 6);
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);
  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIGCTA422', 'RELOCAL', '') = 'N' );

  //*************************************************//
  // VERIFICA SE EXISTE A CONFIGURACAO PARA A GERA-  //
  // CAO DE REMESSA PARA TODAS AS EMPRESAS OU SOMEN- //
  // TE PARA A EMPRESA ATUAL(LOCAL)                  //
  //**********************************************ED*//
  strNovCodEmp := VS_strCodEmp;

  If Not( blnRemLoc ) Then
    strNovCodEmp := fRetEmpresa;

  strNomEmp := Copy(fTiraCaracEspeciais(fRemoveAcento(fRetNomeEmpresa(strNovCodEmp))), 1, 30);

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
  ENd;

  Try

    qryRemessa := fCriaQuery();

    strSQL := '';
    strSQL := strSQL + 'SELECT                     ';
    strSQL := strSQL + '  B.*,                     ';
    strSQL := strSQL + '  F.FOR_NOMFOR,            ';
    strSQL := strSQL + '  F.FOR_ENDERE AS ENDERE,  ';
    strSQL := strSQL + '  F.FOR_BAIRRO AS BAIRRO,  ';
    strSQL := strSQL + '  F.FOR_C_E_P_ AS C_E_P_,  ';
    strSQL := strSQL + '  F.FOR_CGCCPF AS CGCCPF,  ';
    strSQL := strSQL + '  F.FOR_C_G_C_,            ';
    strSQL := strSQL + '  C.CID_NOMCID AS CIDADE,  ';
    strSQL := strSQL + '  C.CID_ESTADO AS ESTADO,  ';
    strSQL := strSQL + '  LEFT(PGI_CODBAR, 3) AS CODBAN ';
    strSQL := strSQL + 'FROM                       ';
    strSQL := strSQL + '  CADPGI B                 ';
    strSQL := strSQL + '  LEFT JOIN CADFOR F ON FOR_CODFOR = PGI_CODFOR     ';
    strSQL := strSQL + '  LEFT JOIN CADCID C ON C.CID_CODCID = F.FOR_CODCID ';
    strSQL := strSQL + 'WHERE                      ';
    strSQL := strSQL + '  PGI_CODBCO = :CODBCO     ';

    With qryRemessa Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;
      Open;
    End;

    If Not qryRemessa.IsEmpty Then
    Begin

      AssignFile(txtTexto, strArqRem);
      Rewrite(txtTexto);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************AF*}
      intCodSeq := 1;
      strHeader := '';

      strHeader := fPadR   ('0'                , 001) + //001
                   fPadR   ('1'                , 001) + //002
                   fPadR   ('REMESSA'          , 007) + //003
                   fPadR   ('11'               , 002) + //010
                   fPadR   ('PAGTOS FORNECED'  , 015) + //012
                   fPadL   (strContCor         , 008, '0') + //027
                   fPadR   ('N'                , 001) + //035
                   fPadR   (' '                , 002) + //036
                   fStrZero(strCodAgen         , 007) + //038
                   fPadR   (' '                , 002) + //045
                   fPadR   (strNomEmp          , 030) + //047
                   fPadR   (strCodBco          , 003) + //077
                   fPadR   (strNomBco          , 015) + //080
                   fPadR   (strDtaRem          , 006) + //095
                   fPadR   (' '                , 001) + //101
                   fPadR   (' '                , 002) + //102
                   fPadR   (' '                , 284) + //104
                   fPadR   ('N'                , 001) + //388
                   fStrZero(strCodRem          , 006) + //389
                   fStrZero(IntToStr(intCodSeq), 006);  //395

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************AF*}
      Writeln(txtTexto,strHeader);

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

          pAtribuiDadosBoleto(FieldByName('PGI_CODBAR').AsString, strCodBco, strAgeDest, strCodCar, strContDes, strNosNum, strFatVen);

          strDtaVen := FormatDateTime('dd',FieldByName('PGI_DTAVEN').AsDateTime) +
                       FormatDateTime('mm',FieldByName('PGI_DTAVEN').AsDateTime) +
                       FormatDateTime('yy',FieldByName('PGI_DTAVEN').AsDateTime);


          strDtaPag := FormatDateTime('dd',FieldByName('PGI_DTAPAG').AsDateTime) +
                       FormatDateTime('mm',FieldByName('PGI_DTAPAG').AsDateTime) +
                       FormatDateTime('yy',FieldByName('PGI_DTAPAG').AsDateTime);

          strKeyDup := FieldByName('PGI_AUTOIN').AsString;

          strCompromi := RightStr(fStrZero(FieldByName('PGI_NUMDUP').AsString, 9), 9) +
                         FieldByName('PGI_PARCEL').AsString;

          strCgcEmp := fTiraCaracEspeciaisPonto(Trim(strCgcEmp));

          strCgcFor := fTiraCaracEspeciaisPonto(Trim(FieldByName('FOR_C_G_C_').AsString));

          strTransacao := fPadR      ('1'                                     , 01)      + //001
                          fPadR      ('01'                                    , 02)      + //002
                          fPadL      (strCgcEmp                               , 14, '0') + //004
                          fPadL      (strContCor                              , 08, '0') + //018
                          fPadR      (' '                                     , 03)      + //026
                          fPadL      (strCodAgen                              , 07, '0') + //029
                          fPadR      (' '                                     , 02)      + //036
                          fPadR      (strKeyDup                               , 25)      + //038
                          fPadL      (strCgcFor                               , 14, '0') + //063
                          fPadR      ('DUP'                                   , 03)      + //077
                          fPadR      (strCompromi                             , 10)      + //080
                          fPadR      (' '                                     , 01)      + //090
                          fPadR      (' '                                     , 17)      + //091
                          fPadR      ('C'                                     , 01)      + //108
                          fPadR      ('01'                                    , 02)      + //109
                          fPadR      (strCompromi                             , 10)      + //111
                          fPadR      (strDtaVen                               , 06)      + //121
                          fValNumForm(FieldByName('PGI_VALDUP').AsFloat       , 13)      + //127
                          fPadR      ('COB'                                   , 03)      + //140
                          fPadR      ('422'                                   , 03)      + //143
                          fStrZero   ('0'                                     , 07)      + //146
                          fPadR      ('000'                                   , 03)      + //153
                          fPadR      (' '                                     , 10)      + //156
                          fPadR      (' '                                     , 20)      + //166
                          fPadL      (strCodAgen                              , 07, '0') + //186
                          fPadR      (strNosNum                               , 16)      + //193
                          fPadR      (' '                                     , 39)      + //209
                          fPadR      (strCodBco                               , 03)      + //248
                          fValNumForm(FieldByName('PGI_VALDES').AsFloat       , 13)      + //251
                          fPadR      (Copy(fTiraCaracEspeciais(fRemoveAcento(FieldByName('FOR_NOMFOR').AsString)),1,30)
                                                                              , 30)      + //264
                          fPadR      (' '                                     , 10)      + //294
                          fPadR      (FieldByName('PGI_CODBAR').AsString      , 44)      + //304
                          fValNumForm(FieldByName('PGI_VALJUR').AsFloat       , 13)      + //348
                          fPadR      (strDtaPag                               , 06)      + //361
                          fValNumForm(FieldByName('PGI_VALPAG').AsFloat       , 13)      + //367
                          fPadR      ('REAL'                                  , 04)      + //380
                          fPadR      (' '                                     , 04)      + //384
                          fPadR      (' '                                     , 03)      + //388
                          fPadR      (' '                                     , 04)      + //391
                          fStrZero   (IntToStr(intCodSeq)                     , 06);       //395

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************AF*}
          Writeln(txtTexto,strTransacao);

          {****************}
          {* GRAVA LOGCTP *}
          {*************JS*}
          objRep := TCadPagRepository.Create;
          objPag := objRep.fRetDuplicata(FieldByName('PGI_NUMDUP').AsString,
                                         FieldByName('PGI_PARCEL').AsString,
                                         FieldByName('PGI_SEQBAI').AsInteger,
                                         FieldByName('PGI_CODEMP').AsString,
                                         FieldByName('PGI_CODFOR').AsString,
                                         FieldByName('PGI_SERIE_').AsString);

          If Assigned(objPag) Then
          begin
            strGetCodFor := objPag.objCodFor.FOR_CODFOR;
            untLogCtp.pGravaLogCtp(objPag, 'EXPORTAÇÃO DE ARQUIVO DE REMESSA - CTP - ' + strCodBco, 'frmExpArqRemSafraCta');
          end;

          If Assigned(objRep) Then
            FreeAndNil(objRep);

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

      fAtuCodSeq(strConfig, 'PROXNUM');

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADPGI          ';
      strSQL := strSQL + ' WHERE PGI_CODBCO = :CODBCO ';

      With qryRemessa Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODBCO').AsString := '422';
        ExecSQL;
        Close;

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODBCO').AsString := '422';
        ExecSQL;
        Close;
      End;

      pBackupCnfBco;

      fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                   'Arquivo Gerado: ' + strArqRem, ['&O K']);
    End
    Else
    Begin
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
    End;

  Finally
    FreeAndNil(qryRemessa);
  End;
end;

function TFuncoesBco422.fRetEmpresa: String;
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

  FreeAndNil(qryCadEmp);
end;

end.
