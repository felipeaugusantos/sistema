unit untTFuncoesAvisosDeCobranca;

interface

Uses System.Classes, System.SysUtils, System.StrUtils, System.DateUtils,
     Uni, untTypesSistema, untConstantes, Data.DB;

Type
  TDeveEnviar = record
    Email,
    SMS,
    WhatsApp: Boolean;
  End;

Type
  TFuncoesAvisosDeCobranca = class
  private
    const MODELOS_A_VENCER: Array[0..9] of String = ('004', '001', '005', '006', '007',
                                                     '016', '018', '019', '020', '021');
    const MODELOS_VENCIDOS: Array[0..10] of String = ('022', '015', '014', '011', '013', '012',
                                                      '003', '010', '002', '009', '008');

    class function RetornaSQLAvisoCobranca(ACodigoModelo: String;
                                           AListaDatas: TStringList;
                                           ADeveEnviar: TDeveEnviar;
                                           AFiltraBlackList: Boolean = False): String;

    class function RetonaFiltroDataVencimento(ACodigoModelo: String;
                                              AListaDatas: TStringList): String;

    class function RetornaFiltrosDasDatasPorTipos(ACodigoModelo: String;
                                                  ADeveEnviar: TDeveEnviar): String;

    class function RetornaFiltrosEspeciesDocumentos(ADeveEnviar: TDeveEnviar;
                                                    AEmpresaCarteira: String): String;

    class function RetornaDiasModelo(ACodigoModelo: String): Integer;

    class procedure GravarLogPesquisa(ADataset: TDataset;
                                      ACodigoModelo: String);
  public
    class function RetornaDatasetAvisoCobranca(ACodigoModelo: String;
                                               AListaDatas: TStringList;
                                               ADeveEnviar: TDeveEnviar;
                                               AFiltraBlackList: Boolean = False;
                                               AGravarLog: Boolean = False): TUniQuery;

    class function RetornaDuplicataAtualizar(AAutoIncremCadRec: String): TUniQuery;

    class function RetornaTipoModelo(ACodigoModelo: String;
                                     ADataVencimento: TDateTime;
                                     AValidaDiaUtil: Boolean): TStatusDisparaEmail;

    class function RetornaDiaEnvioComTolerancia(
          AModelo: TStatusDisparaEmail; ACodigoModelo: String; ADataVencimento: TDateTime):TDateTime;
  end;

implementation
Uses untFuncoesSimples, untCadRec;
{ TFuncoesAvisisDeCobranca }

class procedure TFuncoesAvisosDeCobranca.GravarLogPesquisa(ADataset: TDataset;
  ACodigoModelo: String);
  Const
    SQL_DUP = STR_SQL_NAO_REPLICAR+
              ' INSERT INTO LOG_RETVIEW '+
              '   (RET_VIEW__, '+
              '    RET_DTAENT, '+
              '    RET_DTAHOR, '+
              '    RET_AUTINC, '+
              '    RET_NUMDUP, '+
              '    RET_PARCEL, '+
              '    RET_ESPDOC, '+
              '    RET_CODEMP, '+
              '    RET_CODCLI, '+
              '    RET_DTAVEN, '+
              '    RET_VALDUP, '+
              '    RET_LINDIG, '+
              '    RET_NOSNUM, '+
              '    RET_DTAEMA, '+
              '    RET_DTASMS, '+
              '    RET_DTAWPP, '+
              '    RET_DTABOL, '+
              '    RET_NOMCLI, '+
              '    RET_EMACLI, '+
              '    RET_EMPRESACARTEIRA) ' +
              ' VALUES '+
              '   (:VIEW__, '+
              '    :DTAENT, '+
              '    :DTAHOR, '+
              '    :AUINDU, '+
              '    :NUMDUP, '+
              '    :PARCEL, '+
              '    :ESPDOC, '+
              '    :CODEMP, '+
              '    :CODCLI, '+
              '    :DTAVEN, '+
              '    :VALDUP, '+
              '    :LINDIG, '+
              '    :NOSNUM, '+
              '    :DTAEMA, '+
              '    :DTASMS, '+
              '    :DTAWPP, '+
              '    :DTABOL, '+
              '    :NOMCLI, '+
              '    :EMACLI, '+
              '    :EMPRESACARTEIRA) ';

  Var
    LInserir: TUniQuery;

    LDataHora: TDateTime;
begin
  If ADataset.IsEmpty Then
    Exit;

  If Not fTabelaExiste('LOG_RETVIEW') Then
    Exit;

  pValidaProCod('LOG_RETVIEW');

  Try
    LInserir := fCriaQuery;

    LDataHora := fRetDtaHraServidor;

    Try
      LInserir.SQL.Text := SQL_DUP;

      ADataset.First;

      While Not ADataset.Eof Do
      Begin
        LInserir.Close;
        LInserir.ParamByName('VIEW__').AsString := ACodigoModelo;
        LInserir.ParamByName('DTAENT').Value := LDataHora;
        LInserir.ParamByName('DTAHOR').Value := LDataHora;
        LInserir.ParamByName('AUINDU').Value := ADataset.FieldByName('AUTOINCREM').Value;
        LInserir.ParamByName('NUMDUP').Value := ADataset.FieldByName('CTR_NUMDUP').Value;
        LInserir.ParamByName('PARCEL').Value := ADataset.FieldByName('CTR_PARCEL').Value;
        LInserir.ParamByName('ESPDOC').Value := ADataset.FieldByName('CTR_ESPDOC').Value;
        LInserir.ParamByName('CODEMP').Value := ADataset.FieldByName('CTR_CODEMP').Value;
        LInserir.ParamByName('CODCLI').Value := ADataset.FieldByName('CTR_CODCLI').Value;
        LInserir.ParamByName('DTAVEN').Value := ADataset.FieldByName('CTR_DTAVEN').Value;
        LInserir.ParamByName('VALDUP').Value := ADataset.FieldByName('CTR_VALDUP').Value;
        LInserir.ParamByName('LINDIG').Value := ADataset.FieldByName('CTR_LINDIG').Value;
        LInserir.ParamByName('NOSNUM').Value := ADataset.FieldByName('CTR_NOSNUM').Value;
        LInserir.ParamByName('DTAEMA').Value := ADataset.FieldByName('CTR_DTAEMA').Value;
        LInserir.ParamByName('DTASMS').Value := ADataset.FieldByName('CTR_DTASMS').Value;
        LInserir.ParamByName('DTAWPP').Value := ADataset.FieldByName('CTR_DTAWPP').Value;
        LInserir.ParamByName('DTABOL').Value := ADataset.FieldByName('CTR_DTABOL').Value;
        LInserir.ParamByName('NOMCLI').Value := ADataset.FieldByName('CLI_NOMCLI').Value;
        LInserir.ParamByName('EMACLI').Value := ADataset.FieldByName('CTR_EMACLI').Value;
        LInserir.ParamByName('EMPRESACARTEIRA').Value := ADataset.FieldByName('EMPRESACARTEIRA').Value;

        LInserir.ExecSQL;

        ADataset.Next;
      End;
    Finally
      ADataset.First;

      LInserir.Close;

      FreeAndNil(LInserir);
    End;
  Except
  End;
end;

class function TFuncoesAvisosDeCobranca.RetonaFiltroDataVencimento(
  ACodigoModelo: String; AListaDatas: TStringList): String;
  Var
    LDiasModelo: Integer;

    LDataSelecionada: String;
begin
  LDiasModelo := RetornaDiasModelo(ACodigoModelo);
  If MatchStr(ACodigoModelo, MODELOS_VENCIDOS) Then
    LDiasModelo := LDiasModelo * (-1);

  Result := 'R.CTR_DTAVEN IN (';

  For LDataSelecionada In AListaDatas Do
    Result := Result + 'DATE_ADD("' + LDataSelecionada + '", INTERVAL ' + LDiasModelo.ToString + ' DAY), ';

  Result := LeftStr(Result, Result.Length - 2) + ') ';
end;

class function TFuncoesAvisosDeCobranca.RetornaDatasetAvisoCobranca(
  ACodigoModelo: String; AListaDatas: TStringList; ADeveEnviar: TDeveEnviar;
  AFiltraBlackList: Boolean = False; AGravarLog: Boolean = False): TUniQuery;
begin
  Result := Nil;
  Try
    Result := fCriaQuery;

    Result.SQL.Text := RetornaSQLAvisoCobranca(ACodigoModelo,
                                               AListaDatas,
                                               ADeveEnviar,
                                               AFiltraBlackList);

    Result.Open;

    Result.Filter := 'EMPRESACARTEIRA=' + VS_strCodEmp.QuotedString;
    Result.Filtered := True;

    If AGravarLog Then
      GravarLogPesquisa(Result, ACodigoModelo);
  Except
    If Assigned(Result) Then
      FreeAndNilDatasets(Result);
    Raise;
  End;
end;

class function TFuncoesAvisosDeCobranca.RetornaDiasModelo(
  ACodigoModelo: String): Integer;
begin
  Result := 0;

  Case StrToInt(ACodigoModelo) Of
    8, 4:   Result := 1;
    9, 1:   Result := 2;
    2, 5:   Result := 3;
    10, 6:  Result := 4;
    3, 7:   Result := 5;
    12, 16: Result := 6;
    13, 18: Result := 7;
    11, 19: Result := 8;
    14, 20: Result := 9;
    15, 21: Result := 10;
    22: Result := 30;
  End;
end;

class function TFuncoesAvisosDeCobranca.RetornaDuplicataAtualizar(
  AAutoIncremCadRec: String): TUniQuery;
begin
  Result := fCriaQuery;

  Try
    Result.SQL.Text := 'SELECT AUTOINCREM, ' +
                       '       CTR_CODCLI, ' +
                       '       CTR_DTACAD, ' +
                       '       CTR_DTAVEN, ' +
                       '       CTR_DTAEMA, ' +
                       '       CTR_DTASMS, ' +
                       '       CTR_DTAWPP  ' +
                       'FROM CADREC        ' +
                       'WHERE AUTOINCREM=:AUTOIN';

    Result.ParamByName('AUTOIN').AsString := AAutoIncremCadRec;
    Result.Open;
  Except
    Raise;
  End;
end;

class function TFuncoesAvisosDeCobranca.RetornaFiltrosDasDatasPorTipos(
  ACodigoModelo: String; ADeveEnviar: TDeveEnviar): String;
  Var
    LDiasModelo: Integer;
begin
  LDiasModelo := RetornaDiasModelo(ACodigoModelo);
  If MatchStr(ACodigoModelo, MODELOS_A_VENCER) Then
    LDiasModelo := LDiasModelo * (-1);

  Result := '(';

  If ADeveEnviar.Email Then
    Result := Result + ' (R.CTR_DTAEMA IS NULL OR ' +
                       '  (R.CTR_DTAEMA < DATE_ADD(R.CTR_DTAVEN, INTERVAL ' + LDiasModelo.ToString + ' DAY) AND ' +
                       '   R.CTR_DTAEMA < CURRENT_DATE)) OR ';

  If ADeveEnviar.SMS Then
    Result := Result + ' (R.CTR_DTASMS IS NULL OR ' +
                       '  (R.CTR_DTASMS < DATE_ADD(R.CTR_DTAVEN, INTERVAL ' + LDiasModelo.ToString + ' DAY) AND ' +
                       '  R.CTR_DTASMS < CURRENT_DATE)) OR ';

  If ADeveEnviar.Whatsapp Then
    Result := Result + ' (R.CTR_DTAWPP IS NULL OR ' +
                       '  (R.CTR_DTAWPP < DATE_ADD(R.CTR_DTAVEN, INTERVAL ' + LDiasModelo.ToString + ' DAY) AND ' +
                       '  R.CTR_DTAWPP < CURRENT_DATE)) OR ';

  Result := LeftStr(Result, Result.Length - 3) + ') ';
end;

class function TFuncoesAvisosDeCobranca.RetornaFiltrosEspeciesDocumentos(
  ADeveEnviar: TDeveEnviar; AEmpresaCarteira: String): String;
  Const
    ESPECIES_DOC: String = '"NF","IF","MI","FF","AG","NV","NS","CV","SV",' +
                           '"CO","AC","NP","CT","RL","PD","TR","PA"';
begin
  Result := '(';

  If ADeveEnviar.Email Then
    Result := Result + #13 + 'IF(IFNULL(fCfgSis("CFG_AVIREB", ' + AEmpresaCarteira + '), "1") = "1", ' +
                             '   R.CTR_NOSNUM IS NOT NULL AND R.CTR_DTABOL IS NOT NULL AND R.CTR_LINDIG IS NOT NULL AND R.CTR_ESPDOC IN(' + ESPECIES_DOC + '), ' +
                             '   R.CTR_DTACAD <> R.CTR_DTAVEN) OR ';

  If ADeveEnviar.Whatsapp Then
  Begin
    Result := Result + #13 + 'IF(IFNULL(fCfgSis("CFG_AVIREW", ' + AEmpresaCarteira + '), "1") = "1", ' +
                             '   R.CTR_NOSNUM IS NOT NULL AND R.CTR_DTABOL IS NOT NULL AND R.CTR_LINDIG IS NOT NULL AND R.CTR_ESPDOC IN(' + ESPECIES_DOC + '), ' +
                             '   FALSE) OR ';

    Result := Result + #13 + 'IF(IFNULL(fCfgSis("CFG_AVIREW", ' + AEmpresaCarteira + '), "1") = "2", ' +
                             '   R.CTR_DTACAD <> R.CTR_DTAVEN, ' +
                             '   FALSE) OR ';

    Result := Result + #13 + 'IF(IFNULL(fCfgSis("CFG_AVIREW", ' + AEmpresaCarteira + '), "1") = "3", ' +
                             '   LOCATE(R.CTR_ESPDOC,fCfgSis("CFG_AVIRWS", ' + AEmpresaCarteira + ')), ' +
                             '   FALSE) OR ';
  End;

  If ADeveEnviar.SMS Then
  Begin
    Result := Result + #13 + 'IF(IFNULL(fCfgSis("CFG_AVIRES", ' + AEmpresaCarteira + '), "1") = "1", ' +
                             '   R.CTR_NOSNUM IS NOT NULL AND R.CTR_DTABOL IS NOT NULL AND R.CTR_LINDIG IS NOT NULL AND R.CTR_ESPDOC IN(' + ESPECIES_DOC + '), ' +
                             '   FALSE) OR ';

    Result := Result + #13 + 'IF(IFNULL(fCfgSis("CFG_AVIRES", ' + AEmpresaCarteira + '), "1") = "2", ' +
                             '   R.CTR_DTACAD <> R.CTR_DTAVEN, ' +
                             '   FALSE) OR ';

    Result := Result + #13 + 'IF(IFNULL(fCfgSis("CFG_AVIRES", ' + AEmpresaCarteira + '), "1") = "3", ' +
                             '   LOCATE(R.CTR_ESPDOC,fCfgSis("CFG_AVIRWS", ' + AEmpresaCarteira + ')), ' +
                             '   FALSE) OR ';
  End;

  Result := LeftStr(Result, Result.Length - 3) + ')';
end;

class function TFuncoesAvisosDeCobranca.RetornaSQLAvisoCobranca(
  ACodigoModelo: String; AListaDatas: TStringList; ADeveEnviar: TDeveEnviar;
  AFiltraBlackList: Boolean = False): String;
  CONST
    EMPRESACARTEIRA: String = 'IF(IFNULL(R.CTR_CARTEI,"") = "", R.CTR_CODEMP, RIGHT(R.CTR_CARTEI,3))';

begin
  Result := 'SELECT R.AUTOINCREM, ' +
            '       R.CTR_NUMDUP, ' +
            '       R.CTR_PARCEL, ' +
            '       R.CTR_ESPDOC, ' +
            '       R.CTR_CODCLI, ' +
            '       R.CTR_CODEMP, ' +
            '       R.CTR_DTAVEN, ' +
            '       R.CTR_VALDUP, ' +
            '       R.CTR_LINDIG, ' +
            '       R.CTR_DTAEMA, ' +
            '       R.CTR_DTASMS, ' +
            '       R.CTR_DTAWPP, ' +
            '       R.CTR_DTABOL, ' +
            '       R.CTR_NOSNUM, ' +
            '       R.CTR_CARTEI, ' +
            '       C.CLI_NOMCLI, ' +
            '       ' + EMPRESACARTEIRA + ' AS EMPRESACARTEIRA, ' +
            '       ' + untCadRec.RetornaSQLEmailCliente +
            'FROM CADREC R ' +
            'JOIN CADCLI C ON C.CLI_CODCLI = R.CTR_CODCLI ' +
            'WHERE ' + RetonaFiltroDataVencimento(ACodigoModelo, AListaDatas) +
            '  AND R.CTR_DTAREC IS NULL ' +
            '  AND R.CTR_VALDUP > 0 ' +
            '  AND ' + RetornaFiltrosDasDatasPorTipos(ACodigoModelo, ADeveEnviar) +
            '  AND ' + RetornaFiltrosEspeciesDocumentos(ADeveEnviar, EMPRESACARTEIRA) +
            '  AND fCfgSis("CFG_BOLAVI", ' + EMPRESACARTEIRA + ') = "S" ' +
            '  AND NOT R.CTR_CODCLI IN (SELECT CLINEN.NEN_CODCLI ' +
            '                           FROM CLINEN ' +
            '                           WHERE CLINEN.NEN_CODGRU = "009" ' +
            '                             AND CLINEN.NEN_CODIGO = "' + ACodigoModelo + '") ';

  If AFiltraBlackList Then
    Result := Result +  '  AND (SELECT COUNT(BLK_EMAIL_) ' +
                        '       FROM EMABLK ' +
                        '       WHERE BLK_CODCLI=R.CTR_CODCLI ' +
                        '         AND LOCATE(BLK_EMAIL_, ' + untCadRec.RetornaSQLEmailCliente.Replace('AS CTR_EMACLI', EmptyStr) + ') > 0) = 0 ';

  Result := Result + 'ORDER BY R.CTR_DTAVEN, C.CLI_NOMCLI ';
end;

class function TFuncoesAvisosDeCobranca.RetornaTipoModelo(
  ACodigoModelo: String; ADataVencimento: TDateTime; AValidaDiaUtil: Boolean): TStatusDisparaEmail;
  Var
    LDiasModelo: Integer;
begin
  Result := staNenhumaAcao;

  Case StrToIntDef(ACodigoModelo, 0) Of
    22: Result := sta30DiasVencido;
    15: Result := sta10DiasVencido;
    14: Result := sta9DiasVencido;
    11: Result := sta8DiasVencido;
    13: Result := sta7DiasVencido;
    12: Result := sta6DiasVencido;
    3:  Result := sta5DiasVencido;
    10: Result := sta4DiasVencido;
    2:  Result := sta3DiasVencido;
    9:  Result := sta2DiasVencido;
    8:  Result := sta1DiaVencido;

    4:  Result := sta1DiaVencer;
    1:  Result := sta2DiasVencer;
    5:  Result := sta3DiasVencer;
    6:  Result := sta4DiasVencer;
    7:  Result := sta5DiasVencer;
    16: Result := sta6DiasVencer;
    18: Result := sta7DiasVencer;
    19: Result := sta8DiasVencer;
    20: Result := sta9DiasVencer;
    21: Result := sta10DiasVencer;
  End;

  If Not AValidaDiaUtil Then
    Exit;

  If Result = staNenhumaAcao Then
    Exit;

  LDiasModelo := RetornaDiasModelo(ACodigoModelo);
  If MatchStr(ACodigoModelo, MODELOS_A_VENCER) Then
    LDiasModelo := LDiasModelo * (-1);

  If IncDay(ADataVencimento, LDiasModelo) = VS_Date Then
    Exit

  Else If ADataVencimento >= VS_Date Then
    Exit(staAVencerProximoDiaUtil)
  Else
    Exit(staVencidoProximoDiaUtil);
end;

class function TFuncoesAvisosDeCobranca.RetornaDiaEnvioComTolerancia(
  AModelo: TStatusDisparaEmail; ACodigoModelo: String; ADataVencimento: TDateTime):TDateTime;
  Var
    LDiasModelo: Integer;
    LDataEnvio: TDateTime;
begin
  LDiasModelo := RetornaDiasModelo(ACodigoModelo);

  If (AModelo = staVencidoProximoDiaUtil) Then
      LDataEnvio := IncDay(ADataVencimento, LDiasModelo)
  Else
      LDataEnvio := IncDay(ADataVencimento, -LDiasModelo);

  While fDiaDeFolga(LDataEnvio) Do
  Begin
    LDataEnvio := IncDay(LDataEnvio, 1);
  End;

  LDataEnvio := IncDay(LDataEnvio, fCfgSis('AVITOL', varInteger));

  result := LDataEnvio;
End;

end.
