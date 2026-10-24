unit untMovBan;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  Forms, untVersaoProg, cxProgressBar, untLogBan, untTBanTrf, untLogCba, untTBanMca,
{$ENDIF}
  SysUtils, Classes, DB, Uni, Variants, System.Generics.Collections,
  untTypesSistema, StrUtils, DateUtils;

  function fGravaMovBan(strCodCta,
                        strCodPor,
                        strCodOpe: String;
                        dtaDtaLan,
                        horHorLan: TDateTime;
                        strNumDoc,
                        strCreDeb,
                        strCodEmp: String;
                        fltValLan: Double;
                        strHist01,
                        strHist02: String;
                        strCodCli,
                        strCodFor,
                        strNumDup: String;
                        intSeqBai: Integer;
                        strParcel,
                        strEmpDup,
                        strSerie,
                        strCodEve,
                        strDocBai: String;
                        lstLogBan: TList<{$IFDEF LINUX}TClass{$ELSE}TLogBan{$ENDIF}>;
                        intSeqTrf: Integer = 0;           // Sequencial de Transferencia de Caixa
                        intSeqCon: Integer = 0;           // Sequencial de Controle
                        strCompet: String = '';
                        strSeqCtp: String = ''; // Sequencial de Contra-Partida
                        strSeqLan: String = ''; // Se já possuir retornará esse valor/ se não possuir busca e retorna um novo
                        strAutInc: String = '';
                        strCodChq: String = '';
                        strCodCar: String = '';
                        intGerCon: integer = 1;
                        AblnGravaOrigem: Boolean = True;
                        ALogBanDS: {$IFDEF LINUX}String = ''{$ELSE}TList<TLogBanDS> = Nil{$ENDIF};
                        AEmpresaTransferenciaValores: String = '';
                        ATransferenciaLiberada: String = 'S';
                        ASequencialDepositoCheque: String = '';
                        APagamentoAntecipado: Boolean = False): String;

  {$IFNDEF LINUX}
  function fAtualizaCreditoDiretoComMovBan(arrDupSel : TArrDupSel = Nil;strSeqLan: String = '';fltValLan : Double = 0; strNomeFormulario : String = ''): Boolean;

  function RetornaInsertSQLLogCba(ADataset: TDataset): String;
  function RetornaInsertSQLLogCbaConciliacaoExtrato: String;
  function RetornaValorCampo(ACampo: TField): Variant;
  procedure GravaLogCbaDosRegistros(AAutoIncrems,
                                    ANomeArquivoImportacao,
                                    ADescricao,
                                    ANomeFormulario: String;
                                    var pgbStatus: TcxProgressBar);

  procedure GravaLogCbaRegistrosConciliados(AAutoincrem,
                                            ANomeArquivoImportacao,
                                            ADescricao,
                                            ANomeFormulario: String;
                                            ADataConciliacao: TDateTime;
                                            AHoraConciliacao: String;
                                            AOperadorConciliacao: String;
                                        Var ASQLInsert: String);

  function fGetOrigem(lstLogBan: TList<TLogBan>; ALogBanDS: TList<TLogBanDS>): Variant;

  function MovimentacaoBancariaProvenienteDeBaixaDoPix(ASeqLan,
                                                       AOrigemBaixa,
                                                       ACodigoEmpresa: String): Boolean;

  function ExisteRegistroVinculadoNaBanExr(AAutoIncremMovBan: String): Boolean;

  Type
    TMovBanFunc = class
    private
      class function RetornaOrigemEstorno(AOrigem: String): Variant;
    public
      class procedure LimparOrigemPrincipalCtpCon(ASeqconCadPag: Integer;
                                                  AEmpresaBaixa,
                                                  ASeqLan: String);

      class procedure LimparOrigemPrincipalSeqlan(ASeqLan: String);

      class procedure LimparOrigemPrincipalSeqConCTR(ASeqCon: Integer;
                                                     AEmpresaBaixa: String);

      class function RetornaMovBanPorPagCon(ASeqconCadPag: Integer;
                                            AEmpresaBaixa,
                                            ASeqLan: String): TUniQuery;

      class function RetornaMovBanPorSeqLan(ASeqlan: String): TUniQuery;
    end;

  {$ENDIF}
implementation

{$IFDEF LINUX}
{$ELSE}
  uses untFuncoesSimples, untFuncoes, untTestabilidade ;
{$ENDIF}

function fGravaMovBan(strCodCta,
                      strCodPor,
                      strCodOpe: String;
                      dtaDtaLan,
                      horHorLan: TDateTime;
                      strNumDoc,
                      strCreDeb,
                      strCodEmp: String;
                      fltValLan: Double;
                      strHist01,
                      strHist02: String;
                      strCodCli,
                      strCodFor,
                      strNumDup: String;
                      intSeqBai: Integer;
                      strParcel,
                      strEmpDup,
                      strSerie,
                      strCodEve,
                      strDocBai: String;
                      lstLogBan: TList<{$IFDEF LINUX}TClass{$ELSE}TLogBan{$ENDIF}>;
                      intSeqTrf: Integer = 0;
                      intSeqCon: Integer = 0;
                      strCompet: String = '';
                      strSeqCtp: String = ''; // Sequencial de Contra-Partida
                      strSeqLan: String = ''; // Se já possuir retornará esse valor/ se não possuir busca e retorna um novo
                      strAutInc: String = '';
                      strCodChq: String = '';
                      strCodCar: String = '';
                      intGerCon: integer = 1;
                      AblnGravaOrigem: Boolean = True;
                      ALogBanDS: {$IFDEF LINUX}String = ''{$ELSE}TList<TLogBanDS> = Nil{$ENDIF};
                      AEmpresaTransferenciaValores: String = '';
                      ATransferenciaLiberada: String = 'S';
                      ASequencialDepositoCheque: String = '';
                      APagamentoAntecipado: Boolean = False): String;
  Var
    strSQL: String;
    qryGenBan : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
    qryConPor : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
    {$IFNDEF LINUX}
    objLogBan : TLogBan;
    LLogBanDS: TLogBanDS;
    {$ENDIF}
    blnBaiAna : Boolean;
begin
  Try
    If Not fEmptyStr(strCodPor) Then
    Begin
      qryConPor := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   POR_DTAINI ';
      strSQL := strSQL + ' FROM CADPOR ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   POR_CODPOR = :CODPOR ';

      With qryConPor Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODPOR').AsString := strCodPor;
        Open;
      End;

      If (qryConPor.IsEmpty) Or (qryConPor.FieldByName('POR_DTAINI').AsDateTime > dtaDtaLan) Then
      Begin
        Result := '';
        {$IFNDEF LINUX}
        FreeAndNil(qryConPor);
        {$ENDIF LINUX}
        Raise Exception.Create('Não foi possível gravar a movimentação bancária. A data inicial do portador com código ' +
                               strCodPor + ' tem a data inicial menor que a do lançamento.');
        Exit;

      End;
    End;

    qryGenBan := fCriaQuery;

    If (strSeqLan = '0') Or (fEmptyStr(strSeqLan)) Then
      Result := fSeqContaBanco
    Else
      Result := fStrZero(strSeqLan, 11);

    blnBaiAna := fCfgSis('CTP_AS') = 'A';

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO ';
    strSQL := strSQL + ' MOVBAN ( ';
    strSQL := strSQL + ' CTB_SEQLAN, ';
    strSQL := strSQL + ' CTB_CODCTA, ';
    strSQL := strSQL + ' CTB_CODPOR, ';
    strSQL := strSQL + ' CTB_CODOPE, ';
    strSQL := strSQL + ' CTB_DTALAN, ';
    strSQL := strSQL + ' CTB_HORLAN, ';
    strSQL := strSQL + ' CTB_NUMDOC, ';
    strSQL := strSQL + ' CTB_CREDEB, ';
    strSQL := strSQL + ' CTB_VALLAN, ';
    strSQL := strSQL + ' CTB_HIST01, ';
    strSQL := strSQL + ' CTB_HIST02, ';
    strSQL := strSQL + ' CTB_CODEMP, ';
    strSQL := strSQL + ' AUTOINCREM, ';
    strSQL := strSQL + ' CTB_CODCLI, ';
    strSQL := strSQL + ' CTB_CODFOR, ';
    strSQL := strSQL + ' CTB_NUMDUP, ';
    strSQL := strSQL + ' CTB_SEQBAI, ';
    strSQL := strSQL + ' CTB_PARCEL, ';
    strSQL := strSQL + ' CTB_EMPDUP, ';
    strSQL := strSQL + ' CTB_SERIE_, ';
    strSQL := strSQL + ' CTB_CODEVE, ';
    strSQL := strSQL + ' CTB_DOCBAI, ';
    strSQL := strSQL + ' CTB_COMPET, ';
    strSQL := strSQL + ' CTB_SEQTRF, ';
    strSQL := strSQL + ' CTB_SEQCTP, ';
    strSQL := strSQL + ' CTB_PAGCON, ';
    strSQL := strSQL + ' CTB_ORIGEM, ';
    strSQL := strSQL + ' CTB_CODCHQ, ';
    strSQL := strSQL + ' CTB_CODCAR, ';
    strSQL := strSQL + ' CTB_GERCON, ';
    strSQL := strSQL + ' CTB_EMPTRA, ';
    strSQL := strSQL + ' CTB_TRFLIB, ';
    strSQL := strSQL + ' CTB_SEQDEP) ';
    strSQL := strSQL + 'VALUES ( ';
    strSQL := strSQL + '  :SEQLAN, ';
    strSQL := strSQL + '  :CODCTA, ';
    strSQL := strSQL + '  :CODPOR, ';
    strSQL := strSQL + '  :CODOPE, ';
    strSQL := strSQL + '  :DTALAN, ';
    strSQL := strSQL + '  :HORLAN, ';
    strSQL := strSQL + '  :NUMDOC, ';
    strSQL := strSQL + '  :CREDEB, ';
    strSQL := strSQL + '  :VALLAN, ';
    strSQL := strSQL + '  :HIST01, ';
    strSQL := strSQL + '  :HIST02, ';
    strSQL := strSQL + '  :CODEMP, ';
    strSQL := strSQL + '  :AUTINC, ';
    strSQL := strSQL + '  :CODCLI, ';
    strSQL := strSQL + '  :CODFOR, ';
    strSQL := strSQL + '  :NUMDUP, ';
    strSQL := strSQL + '  :SEQBAI, ';
    strSQL := strSQL + '  :PARCEL, ';
    strSQL := strSQL + '  :EMPDUP, ';
    strSQL := strSQL + '  :SERIE_, ';
    strSQL := strSQL + '  :CODEVE, ';
    strSQL := strSQL + '  :DOCBAI, ';
    strSQL := strSQL + '  :COMPET, ';
    strSQL := strSQL + '  :SEQTRF, ';
    strSQL := strSQL + '  :SEQCTP, ';
    strSQL := strSQL + '  :PAGCON, ';
    strSQL := strSQL + '  :ORIGEM, ';
    strSQL := strSQL + '  :CODCHQ, ';
    strSQL := strSQL + '  :CODCAR, ';
    strSQL := strSQL + '  :GERCON, ';
    strSQL := strSQL + '  :EMPTRA, ';
    strSQL := strSQL + '  :TRFLIB, ';
    strSQL := strSQL + '  :SEQDEP) ';

    With qryGenBan Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQLAN').AsString   := Result;
      ParamByName('GERCON').AsInteger := intGerCon;

      If fEmptyStr(strCodCta) Then
        ParamByName('CODCTA').Value := Null
      Else
        ParamByName('CODCTA').AsString := strCodCta;

      If fEmptyStr(strCodPor) Then
        ParamByName('CODPOR').Value := Null
      Else
        ParamByName('CODPOR').AsString := strCodPor;

      ParamByName('CODOPE').AsString   := strCodOpe;
      ParamByName('DTALAN').AsDateTime := dtaDtaLan;
      ParamByName('HORLAN').AsDateTime := horHorLan;
      ParamByName('NUMDOC').AsString   := RightStr(Trim(strNumDoc), 12);
      ParamByName('CREDEB').AsString   := strCreDeb;
      ParamByName('VALLAN').AsFloat    := Abs(fltValLan);
      ParamByName('HIST01').AsString   := copy(strHist01,1,60);
      ParamByName('HIST02').AsString   := copy(strHist02,1,60);
      ParamByName('CODEMP').AsString   := strCodEmp;

      If fEmptyStr(strAutInc) Then
        ParamByName('AUTINC').AsString := fRetAutoIncrem('MOVBAN', strCodEmp)
      Else
        ParamByName('AUTINC').AsString := strAutInc;

      If (fEmptyStr(strCodCli)) Then
        ParamByName('CODCLI').Value := Null
      Else
        ParamByName('CODCLI').AsString   := strCodCli;

      If (fEmptyStr(strCodFor)) Then
        ParamByName('CODFOR').Value := Null
      Else
        ParamByName('CODFOR').AsString   := strCodFor;

      ParamByName('NUMDUP').AsString   := strNumDup;

      if blnBaiAna then
         ParamByName('SEQBAI').AsInteger  := intSeqBai
      else
         ParamByName('SEQBAI').Value      := Null;

      ParamByName('PARCEL').AsString   := strParcel;

      If fEmptyStr(strEmpDup) Then
        ParamByName('EMPDUP').Value    := Null
      Else
        ParamByName('EMPDUP').AsString := strEmpDup;

      ParamByName('SERIE_').AsString   := strSerie;

      If (fEmptyStr(strCodEve)) Then
        ParamByName('CODEVE').Value := Null
      Else
        ParamByName('CODEVE').AsString := strCodEve;

      If (fEmptyStr(strDocBai)) Then
        ParamByName('DOCBAI').Value := Null
      Else
        ParamByName('DOCBAI').AsString := strDocBai;

      If (fEmptyStr(strCompet)) then
        ParamByName('COMPET').Value := FormatDateTime('mm/YYYY',dtaDtaLan)
      Else
        ParamByName('COMPET').Value := strCompet;

      ParamByName('SEQTRF').AsInteger  := intSeqTrf;
      If intSeqTrf = 0 Then
        ParamByName('SEQTRF').Clear;

      ParamByName('PAGCON').AsInteger  := intSeqCon;
      If intSeqCon = 0 Then
        ParamByName('PAGCON').Clear;

      If fEmptyStr(strSeqCtp) Then
        ParamByName('SEQCTP').Value := Null
      Else
        ParamByName('SEQCTP').AsString := strSeqCtp;

      {$IFNDEF LINUX}
      If ((lstLogBan <> Nil) And (lstLogBan.Count > 0) And (lstLogBan[0] <> Nil)) and (AblnGravaOrigem) Then
        ParamByName('ORIGEM').AsString := TGravaLogBan.fGetOrigem(lstLogBan[0])
      Else
        ParamByName('ORIGEM').Value := fGetOrigem(lstLogBan,ALogBanDS);
      {$ELSE}
        ParamByName('ORIGEM').Value := ALogBanDS ;
      {$ENDIF}


      If APagamentoAntecipado then
        ParamByName('ORIGEM').Value := 'ANT';
      If fEmptyStr(strCodChq) Then
        ParamByName('CODCHQ').Value := Null
      Else
        ParamByName('CODCHQ').AsString := strCodChq;

      If fEmptyStr(strCodCar) Then
        ParamByName('CODCAR').Value := Null
      Else
        ParamByName('CODCAR').AsString := strCodCar;

      ParamByName('EMPTRA').Value := Null;
      If Not AEmpresaTransferenciaValores.IsEmpty Then
        ParamByName('EMPTRA').AsString := AEmpresaTransferenciaValores;

      ParamByName('TRFLIB').AsString := 'S';
      If Not ATransferenciaLiberada.IsEmpty Then
        ParamByName('TRFLIB').AsString := ATransferenciaLiberada;

      ParamByName('SEQDEP').Value := Null;
      If Not ASequencialDepositoCheque.IsEmpty Then
        ParamByName('SEQDEP').AsString := ASequencialDepositoCheque;

      ExecSQL;
      Close;
      {$IFNDEF LINUX}
      TTestabilidade.fGetTestabilidade.pAdicionarMovimentacaoContaBanco(Result, strCodPor, strCodCta, dtaDtaLan, fltValLan);
      {$ENDIF}
    End;

    {$IFNDEF LINUX}
    if (Assigned(lstLogBan)) then
    Begin
      For objLogBan In lstLogBan Do
        TGravaLogBan.fGravaLogBan(objLogBan, strCodEmp, Result);
    End;

    if (Assigned(ALogBanDS)) then
    Begin
      For LLogBanDS In ALogBanDS Do
        TGravaLogBanDS.GravaLogBanDS(LLogBanDS, strCodEmp, Result);
    End;
    {$ENDIF}
  Except
    On E: Exception Do
    Begin
      Result := '';
      Raise Exception.Create(E.Message);
    End;
  End;

  {$IFNDEF LINUX}
  FreeAndNil(qryGenBan);
  {$ENDIF LINUX}

  If Assigned(qryConPor) Then
    {$IFNDEF LINUX}
    FreeAndNil(qryConPor);
    {$ENDIF LINUX}

end;


{$IFNDEF LINUX}
function fAtualizaCreditoDiretoComMovBan(arrDupSel : TArrDupSel = Nil;strSeqLan : String = '';fltValLan : Double = 0; strNomeFormulario: String = ''): Boolean;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := True;
  Try
    strSQL := '';
    strSQL := strSQL + ' UPDATE  ';
    strSQL := strSQL + '   BANCTR B     ';
    strSQL := strSQL + ' SET B.CTR_VALREC = :VALLAN ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   B.CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '   B.CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   B.CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   B.CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '   B.CTR_CODCLI = :CODCLI AND';
    strSQL := strSQL + '   B.CTB_SEQLAN = :SEQLAN';
    Try
      qryGen := fCriaQuery;

      With qryGen Do
      Begin
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDUP').AsString := arrDupSel[0].strNumDoc;
        ParamByName('ESPDOC').AsString := arrDupSel[0].strEspDoc;
        ParamByName('CODEMP').AsString := arrDupSel[0].strCodEmp;
        ParamByName('PARCEL').AsString := arrDupSel[0].strParcel;
        ParamByName('CODCLI').AsString := arrDupSel[0].strCodCli;
        ParamByName('SEQLAN').AsString := strSeqLan;
        ParamByName('VALLAN').AsFloat  := fltValLan;

        qryGen.ExecSQL;

        strSQL := '';
        strSQL := strSQL + ' UPDATE  ';
        strSQL := strSQL + '   MOVBAN      ';
        strSQL := strSQL + ' SET CTB_VALLAN = :VALLAN  ';
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   CTB_SEQLAN = :SEQLAN';

        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('SEQLAN').AsString := strSeqLan;
        ParamByName('VALLAN').AsFloat  := Abs(fltValLan);
        qryGen.ExecSQL;

        untLogCba.pGravaLogCba(strSeqLan, 'ALTERACAO', strNomeFormulario);

        Result := True;
      End;

    Except
      On E: Exception Do
      begin
        Raise Exception.Create(E.Message);
        Result := False;
      end;

    End;
  Finally
    FreeAndNil(qryGen);
  End;
End;

function fGetOrigem(lstLogBan: TList<TLogBan>; ALogBanDS: TList<TLogBanDS>): Variant;
  Var
    strOrigem : String;
begin
  strOrigem := '';
  Result := Null;

  if Assigned(ALogBanDS) And Not Assigned(lstLogBan) Then
    Result := ALogBanDS[0].fGetOrigem;

  If Not fCfgSis('ORIEST', varBoolean) Then
  Begin
    If ((lstLogBan <> Nil) And (lstLogBan.Count > 0) And (lstLogBan[0] <> Nil)) Then
      strOrigem := TGravaLogBan.fGetOrigem(lstLogBan[0]);

    If (strOrigem = 'MCA') Then Result := 'ECR' // ESTORNO DE CARTÃO
    Else If (strOrigem = 'CTR') Then  Result := 'ERC' // ESTORNO DE CONTAS A RECEBER
    Else If (strOrigem = 'CTP') Then  Result := 'EPG' // ESTORNO DE CONTAS A PAGAR
    Else If (strOrigem = 'ADT') Then  Result := 'ADT'  // ESTORNO DE ADIANTAMENTO
    Else If (strOrigem = 'CRC') Then  Result := 'CRC'; // ESTORNO DE CREDITO CONTAS A RECEBER
  End;
end;

procedure GravaLogCbaRegistrosConciliados(AAutoincrem,
                                          ANomeArquivoImportacao,
                                          ADescricao,
                                          ANomeFormulario: String;
                                          ADataConciliacao: TDateTime;
                                          AHoraConciliacao: String;
                                          AOperadorConciliacao: String;
                                      Var ASQLInsert: String);
  Var
    LDataExecutavel: TDateTime;
    LGravarLogCba: TUniQuery;
Begin
  LGravarLogCba := fCriaQuery;
  Try
    If fEmptyStr(ASQLInsert) Then
      ASQLInsert := RetornaInsertSQLLogCbaConciliacaoExtrato;

    Try
      LGravarLogCba.Close;
      LGravarLogCba.SQL.Text := ASQLInsert;
      FileAge(Application.ExeName, LDataExecutavel);

      LGravarLogCba.ParamByName('EXR_EXTINC').AsString   := AAutoincrem;
      LGravarLogCba.ParamByName('CTB_DESCRI').AsString   := ADescricao;
      LGravarLogCba.ParamByName('CTB_DTALOG').AsDateTime := VS_Date;
      LGravarLogCba.ParamByName('CTB_HORLOG').AsTime     := fRetHoraServidor;
      LGravarLogCba.ParamByName('CTB_NOMFRM').AsString   := ANomeFormulario;
      LGravarLogCba.ParamByName('CTB_OPELOG').AsString   := strLoginUsuarioLogado;
      LGravarLogCba.ParamByName('CTB_NOMEXE').AsString   := ExtractFileName(Application.ExeName);
      LGravarLogCba.ParamByName('CTB_DTAEXE').AsDateTime := LDataExecutavel;
      LGravarLogCba.ParamByName('CTB_HOREXE').AsDateTime := EncodeTime(HourOf(LDataExecutavel),
                                                         MinuteOf(LDataExecutavel),
                                                         SecondOf(LDataExecutavel),
                                                         MilliSecondOf(LDataExecutavel));
      LGravarLogCba.ParamByName('CTB_VEREXE').AsString   := TVersaoExecutavel.GetVersaoProduto;
      LGravarLogCba.ParamByName('CTB_ARQIMP').AsString   := ANomeArquivoImportacao;

      LGravarLogCba.ParamByName('CTB_DTACON').AsDateTime   := ADataConciliacao;
      LGravarLogCba.ParamByName('CTB_HORCON').AsString     := AHoraConciliacao;
      LGravarLogCba.ParamByName('CTB_OPECON').AsString     := AOperadorConciliacao;

      LGravarLogCba.ExecSQL;
    Except

      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;

  Finally
    FreeAndNil(LGravarLogCba);
  End;
End;

procedure GravaLogCbaDosRegistros(AAutoIncrems, ANomeArquivoImportacao, ADescricao, ANomeFormulario: String;
  var pgbStatus: TcxProgressBar);
  Var
    LRegistros,
    LGravarLog: TUniQuery;

    LSQL: String;

    LCampo: TField;

    LDataExecutavel: TDateTime;
begin
  If AAutoIncrems.IsEmpty Then
    Exit;

  Try
    LRegistros := fCriarQuery('SELECT fRetAutoIncrem("LOGCBA", "' + VS_strCodEmp + '") AS AUTCBA, MOVBAN.* ' +
                              ' FROM MOVBAN WHERE AUTOINCREM IN (' + AAutoIncrems + ') ');

    LRegistros.Open;

    If LRegistros.IsEmpty Then
    Begin
      FreeAndNil(LRegistros);
      Exit;
    End;

    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := LRegistros.RecordCount;

    LSQL := RetornaInsertSQLLogCba(LRegistros);

    FileAge(Application.ExeName, LDataExecutavel);

    LGravarLog := fCriaQuery;
    LGravarLog.SQL.Text := LSQL;

    LGravarLog.ParamByName('CTB_DESCRI').AsString   := ADescricao;
    LGravarLog.ParamByName('CTB_DTALOG').AsDateTime := VS_Date;
    LGravarLog.ParamByName('CTB_HORLOG').AsTime     := fRetHoraServidor;
    LGravarLog.ParamByName('CTB_NOMFRM').AsString   := ANomeFormulario;
    LGravarLog.ParamByName('CTB_OPELOG').AsString   := strLoginUsuarioLogado;
    LGravarLog.ParamByName('CTB_NOMEXE').AsString   := ExtractFileName(Application.ExeName);
    LGravarLog.ParamByName('CTB_DTAEXE').AsDateTime := LDataExecutavel;
    LGravarLog.ParamByName('CTB_HOREXE').AsDateTime := EncodeTime(HourOf(LDataExecutavel),
                                                       MinuteOf(LDataExecutavel),
                                                       SecondOf(LDataExecutavel),
                                                       MilliSecondOf(LDataExecutavel));
    LGravarLog.ParamByName('CTB_VEREXE').AsString   := TVersaoExecutavel.GetVersaoProduto;
    LGravarLog.ParamByName('CTB_ARQIMP').AsString   := ANomeArquivoImportacao;

    LRegistros.First;
    While Not LRegistros.Eof Do
    Begin
      LGravarLog.Close;

      For LCampo In LRegistros.Fields Do
      Begin
        If Not MatchStr(LCampo.FieldName, ['AUTCBA', 'AUTOINCREM']) Then
          LGravarLog.ParamByName(LCampo.FieldName).Value := RetornaValorCampo(LRegistros.FieldByName(LCampo.FieldName));
      End;

      LGravarLog.ParamByName('AUTCBA').AsString := LRegistros.FieldByName('AUTCBA').AsString;

      LGravarLog.ExecSQL;

      pStepStatusGravacao(pgbStatus);

      LRegistros.Next;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

function RetornaInsertSQLLogCbaConciliacaoExtrato: String;
var
  LCampo: TField;
  LConsultaCamposMovBan, LConsultaCamposLogCba: TUniQuery;
  LCamposLogCba: TStringList;
begin
  LConsultaCamposMovBan := fCriarQuery('SELECT * FROM MOVBAN WHERE FALSE');
  LConsultaCamposLogCba := fCriarQuery('SELECT * FROM LOGCBA WHERE FALSE');
  LCamposLogCba := TStringList.Create;

  try
    for LCampo in LConsultaCamposLogCba.Fields do
      LCamposLogCba.Add(UpperCase(LCampo.FieldName));

    Result := 'INSERT INTO LOGCBA (AUTOINCREM';

    for LCampo in LConsultaCamposMovBan.Fields do
    begin
      if (not MatchStr(LCampo.FieldName, ['AUTOINCREM','CTB_DTACON','CTB_HORCON','CTB_OPECON'])) and
         (LCamposLogCba.IndexOf(UpperCase(LCampo.FieldName)) <> -1) then
        Result := Result + ',' + LCampo.FieldName;
    end;

    Result := Result + ',CTB_DESCRI,CTB_DTALOG,CTB_HORLOG,CTB_NOMFRM,CTB_OPELOG,CTB_DTACON,CTB_HORCON,CTB_OPECON';
    Result := Result + ',CTB_NOMEXE,CTB_DTAEXE,CTB_HOREXE,CTB_VEREXE,CTB_ARQIMP ) SELECT fRetAutoIncrem("LOGCBA", "' + VS_strCodEmp + '")';

    for LCampo in LConsultaCamposMovBan.Fields do
    begin
      if (not MatchStr(LCampo.FieldName, ['AUTOINCREM','CTB_DTACON','CTB_HORCON','CTB_OPECON'])) and
         (LCamposLogCba.IndexOf(UpperCase(LCampo.FieldName)) <> -1) then
        Result := Result + ',M.' + LCampo.FieldName;
    end;

    Result := Result + ',:CTB_DESCRI,:CTB_DTALOG,:CTB_HORLOG,:CTB_NOMFRM,:CTB_OPELOG,:CTB_DTACON,:CTB_HORCON,:CTB_OPECON';
    Result := Result + ',:CTB_NOMEXE,:CTB_DTAEXE,:CTB_HOREXE,:CTB_VEREXE,:CTB_ARQIMP';

    Result := Result + ' FROM BANEXR ';
    Result := Result + ' JOIN MOVBAN M ON M.AUTOINCREM = EXR_BANINC  ';
    Result := Result + ' WHERE EXR_EXTINC = :EXR_EXTINC ';
    Result := Result + '   AND M.CTB_DTACON IS NULL ';

  finally
    FreeAndNil(LConsultaCamposMovBan);
    FreeAndNil(LConsultaCamposLogCba);
    FreeAndNil(LCamposLogCba);
  end;
end;

function RetornaInsertSQLLogCba(ADataset: TDataset): String;
  Var
    LCampo: TField;
Begin
  Result := 'INSERT INTO LOGCBA (AUTOINCREM';
  For LCampo In ADataset.Fields Do
  Begin
    If Not MatchStr(LCampo.FieldName, ['AUTCBA', 'AUTOINCREM']) Then
      Result := Result + ',' + LCampo.FieldName;
  End;

  Result := Result + ',CTB_DESCRI,CTB_DTALOG,CTB_HORLOG,CTB_NOMFRM,CTB_OPELOG';
  Result := Result + ',CTB_NOMEXE,CTB_DTAEXE,CTB_HOREXE,CTB_VEREXE,CTB_ARQIMP) VALUES (:AUTCBA';
  For LCampo In ADataset.Fields Do
  Begin
    If Not MatchStr(LCampo.FieldName, ['AUTCBA', 'AUTOINCREM']) Then
      Result := Result + ',:' + LCampo.FieldName;
  End;
  Result := Result + ',:CTB_DESCRI,:CTB_DTALOG,:CTB_HORLOG,:CTB_NOMFRM,:CTB_OPELOG';
  Result := Result + ',:CTB_NOMEXE,:CTB_DTAEXE,:CTB_HOREXE,:CTB_VEREXE,:CTB_ARQIMP)';
End;

function RetornaValorCampo(ACampo: TField): Variant;
Begin
  Result := Null;

  If Not ACampo.IsNull Then
    Result := ACampo.Value;
End;

function MovimentacaoBancariaProvenienteDeBaixaDoPix(ASeqLan, AOrigemBaixa,
  ACodigoEmpresa: String): Boolean;
  Var
    LConsulta: TUniQuery;
Begin
  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          'FROM MOVPIX ' +
                          'WHERE MPX_DOCBAI="' + ASeqLan + '" ';
    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;

    If Result Then
      Exit;

    If AOrigemBaixa = 'CTR' Then
    Begin
      LConsulta.Close;
      LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                            'FROM MOVPIX ' +
                            'WHERE MPX_CODEMP="' + ACodigoEmpresa + '" ' +
                            '  AND MPX_SEQCON IN ' +
                            '        (SELECT DISTINCT CTR_SEQCON ' +
                            '         FROM CADREC ' +
                            '         WHERE CTR_DOCBAI="' + ASeqLan + '"' +
                            '           AND CTR_RECPIX="S")';

      LConsulta.Open;

      Result := Not LConsulta.IsEmpty;

      If Result Then
        Exit;

      If fCfgSis('JURSEP', varBoolean) Then
      Begin
        LConsulta.Close;
        LConsulta.SQL.Text := 'SELECT PX.AUTOINCREM ' +
                              'FROM MOVCTR M ' +
                              'JOIN CADREC C ON C.AUTOINCREM=M.MOV_AUTCTR ' +
                              '             AND C.CTR_RECPIX="S" ' +
                              'JOIN MOVPIX PX ON PX.MPX_SEQCON=C.CTR_SEQCON ' +
                              '              AND PX.MPX_CODEMP=C.CTR_EMPBAI ' +
                              'WHERE M.MOV_SEQCTB="' + ASeqLan + '"';

        LConsulta.Open;

        Result := Not LConsulta.IsEmpty;
      End;
    End;
  Finally
    FreeAndNil(LConsulta);
  End;
End;

function ExisteRegistroVinculadoNaBanExr(AAutoIncremMovBan: String): Boolean;
  Var
    LConsulta: TUniQuery;
Begin
  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT R.AUTOINCREM ' +
                          'FROM BANEXR R ' +
                          'JOIN MOVBAN M ON M.AUTOINCREM=R.EXR_BANINC ' +
                          'JOIN CADPOR P ON P.POR_CODPOR=M.CTB_CODPOR ' +
                          'WHERE R.EXR_BANINC="' + AAutoIncremMovBan + '" ' +
                          '  AND P.POR_CCAAUT IS NOT NULL ' +
                          '  AND P.POR_CONOFX="S" ' +
                          'LIMIT 1 ';
    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
End;
{$ENDIF}

{ TMovBanFunc }

{ TMovBanFunc }
{$IFNDEF LINUX}
class procedure TMovBanFunc.LimparOrigemPrincipalCtpCon(ASeqconCadPag: Integer;
  AEmpresaBaixa, ASeqLan: String);
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    If MatchStr(ASeqconCadPag.ToString, [EmptyStr, '0']) Then
      Exit;

    LConsulta.SQL.Text := 'SELECT * ' +
                          'FROM MOVBAN ' +
                          'WHERE CTB_PAGCON=:PAGCON ' +
                          '  AND CTB_CODEMP=:CODEMP ';

    If Not ASeqLan.IsEmpty Then
    Begin
      LConsulta.SQL.Add('  AND CTB_SEQLAN=:SEQLAN');
      LConsulta.ParamByName('SEQLAN').AsString := ASeqLan;
    End;

    LConsulta.ParamByName('PAGCON').AsInteger := ASeqconCadPag;
    LConsulta.ParamByName('CODEMP').AsString := AEmpresaBaixa;

    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit;

    While Not LConsulta.Eof Do
    Begin
      LConsulta.Edit;
      LConsulta.FieldByName('CTB_ORIGEM').Value := RetornaOrigemEstorno(LConsulta.FieldByName('CTB_ORIGEM').AsString);
      LConsulta.Post;

      LConsulta.Next;
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

class procedure TMovBanFunc.LimparOrigemPrincipalSeqConCTR(ASeqCon: Integer;
  AEmpresaBaixa: String);
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    If MatchStr(ASeqCon.ToString, [EmptyStr, '0']) Then
      Exit;

    LConsulta.SQL.Text := 'SELECT * ' +
                          'FROM MOVBAN ' +
                          'WHERE CTB_SEQBAI=:SEQCON ' +
                          '  AND CTB_CODEMP=:CODEMP ';

    LConsulta.ParamByName('SEQCON').AsInteger := ASeqCon;
    LConsulta.ParamByName('CODEMP').AsString := AEmpresaBaixa;
    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit;

    While Not LConsulta.Eof Do
    Begin
      LConsulta.Edit;
      LConsulta.FieldByName('CTB_ORIGEM').Value := RetornaOrigemEstorno(LConsulta.FieldByName('CTB_ORIGEM').AsString);
      LConsulta.Post;

      LConsulta.Next;
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

class procedure TMovBanFunc.LimparOrigemPrincipalSeqlan(ASeqLan: String);
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    If ASeqLan.IsEmpty Then
      Exit;

    LConsulta.SQL.Text := 'SELECT * ' +
                          'FROM MOVBAN ' +
                          'WHERE CTB_SEQLAN=:SEQLAN';

    LConsulta.ParamByName('SEQLAN').AsString := ASeqLan;
    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit;

    While Not LConsulta.Eof Do
    Begin
      LConsulta.Edit;
      LConsulta.FieldByName('CTB_ORIGEM').Value := RetornaOrigemEstorno(LConsulta.FieldByName('CTB_ORIGEM').AsString);
      LConsulta.Post;

      LConsulta.Next;
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

class function TMovBanFunc.RetornaMovBanPorPagCon(ASeqconCadPag: Integer;
  AEmpresaBaixa, ASeqLan: String): TUniQuery;
begin
  Result := fCriaQuery;

  Try
    If MatchStr(ASeqconCadPag.ToString, [EmptyStr, '0']) Then
    Begin
      Result.SQL.Text := 'SELECT * ' +
                         'FROM MOVBAN ' +
                         'WHERE FALSE';

      Result.Open;

      Exit;
    End;

    Result.SQL.Text := 'SELECT * ' +
                       'FROM MOVBAN ' +
                       'WHERE CTB_PAGCON=:PAGCON ' +
                       '  AND CTB_CODEMP=:CODEMP ';

    If Not ASeqLan.IsEmpty Then
    Begin
      Result.SQL.Add('  AND CTB_SEQLAN=:SEQLAN');
      Result.ParamByName('SEQLAN').AsString := ASeqLan;
    End;

    Result.ParamByName('PAGCON').AsInteger := ASeqconCadPag;
    Result.ParamByName('CODEMP').AsString := AEmpresaBaixa;

    Result.Open;
  Except
    Raise;
  End;
end;

class function TMovBanFunc.RetornaMovBanPorSeqLan(
  ASeqlan: String): TUniQuery;
begin
  Result := fCriaQuery;

  Try
    If ASeqlan.IsEmpty Then
    Begin
      Result.SQL.Text := 'SELECT * ' +
                         'FROM MOVBAN ' +
                         'WHERE FALSE';

      Result.Open;

      Exit;
    End;

    Result.SQL.Text := 'SELECT * ' +
                       'FROM MOVBAN ' +
                       'WHERE CTB_SEQLAN=:SEQLAN';

    Result.ParamByName('SEQLAN').AsString := ASeqlan;

    Result.Open;
  Except
    Raise;
  End;
end;

class function TMovBanFunc.RetornaOrigemEstorno(AOrigem: String): Variant;
begin
  Result := Null;

  If fCfgSis('ORIEST', varBoolean) Then
    Exit;

  If MatchStr(AOrigem, ['MCA', 'ECR']) Then
    Result := 'ECR'  // ESTORNO DE CARTÃO
  Else If MatchStr(AOrigem, ['CTR', 'ERC']) Then
    Result := 'ERC'  // ESTORNO DE CONTAS A RECEBER
  Else If MatchStr(AOrigem, ['CTP', 'EPG']) Then
    Result := 'EPG'  // ESTORNO DE CONTAS A PAGAR
  Else If MatchStr(AOrigem, ['ADT']) Then
    Result := 'ADT'  // ESTORNO DE ADIANTAMENTO
  Else If  MatchStr(AOrigem, ['CRC']) Then
    Result := 'CRC'; // ESTORNO DE CREDITO CONTAS A RECEBER
end;
{$ENDIF}
end.
