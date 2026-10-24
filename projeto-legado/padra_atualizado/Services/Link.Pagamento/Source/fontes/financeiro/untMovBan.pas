unit untMovBan;

interface

uses
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types,
  {$ELSE }
  untFuncoesSimples, REST.Client, untFuncoes,
  {$ENDIF LINUX}
  untTypesSistema, untLinkPagamentoCitelRetorno, System.Generics.Collections, untClassesFinanceiro ;

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
                        lstLogBan: TObjectList<TBanCtr>;
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
                        ALogBanDS: String = '';
                        AEmpresaTransferenciaValores: String = '';
                        ATransferenciaLiberada: String = 'S';
                        ASequencialDepositoCheque: String = ''): String;

  function fGetOrigem(lstLogBan: TObjectList<TBanCtr>; ALogBanDS: TList<TLogBanDS>): Variant;
  function fGravaBanCtr(ALogBan: TBanCtr; AstrCodEmp: String; AstrSeqLan: String): Boolean;

implementation

uses System.SysUtils, System.Variants, System.StrUtils ;


function fGravaBanCtr(ALogBan: TBanCtr; AstrCodEmp: String; AstrSeqLan: String): Boolean;
Var
  LstrSQL: String;
  LqryBanCtr : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LblnColSerie_: Boolean ;
begin
  LblnColSerie_ := fCampoExiste('BANCTR', 'CTR_SERIE_') ;

  LstrSQL := '';
  LstrSQL := LstrSQL + 'INSERT INTO ';
  LstrSQL := LstrSQL + ' BANCTR ( ';
  LstrSQL := LstrSQL + '  AUTOINCREM, ';
  LstrSQL := LstrSQL + '  CTB_SEQLAN, ';
  LstrSQL := LstrSQL + '  CTR_CODCLI, ';
  LstrSQL := LstrSQL + '  CTR_CODEMP, ';
  LstrSQL := LstrSQL + '  CTR_ESPDOC, ';
  LstrSQL := LstrSQL + '  CTR_HIST01, ';
  LstrSQL := LstrSQL + '  CTR_HIST02, ';
  LstrSQL := LstrSQL + '  CTR_NUMDUP, ';
  LstrSQL := LstrSQL + '  CTR_PARCEL, ';
  LstrSQL := LstrSQL + '  CTR_SEQBAI, ';
  LstrSQL := LstrSQL + '  CTR_VALREC, ';
  LstrSQL := LstrSQL + '  CTR_VALJUR, ';
  LstrSQL := LstrSQL + '  CTR_VALDES, ';
  LstrSQL := LstrSQL + '  CTR_VALPRI ';
  LstrSQL := LstrSQL + '  '+ifThen(LblnColSerie_, ',CTR_SERIE_', '')+') ';
  LstrSQL := LstrSQL + ' VALUES ( ';
  LstrSQL := LstrSQL + '  :AUTOINCREM, ';
  LstrSQL := LstrSQL + '  :SEQLAN, ';
  LstrSQL := LstrSQL + '  :CODCLI, ';
  LstrSQL := LstrSQL + '  :CODEMP, ';
  LstrSQL := LstrSQL + '  :ESPDOC, ';
  LstrSQL := LstrSQL + '  :HIST01, ';
  LstrSQL := LstrSQL + '  :HIST02, ';
  LstrSQL := LstrSQL + '  :NUMDUP, ';
  LstrSQL := LstrSQL + '  :PARCEL, ';
  LstrSQL := LstrSQL + '  :SEQBAI, ';
  LstrSQL := LstrSQL + '  :VALREC, ';
  LstrSQL := LstrSQL + '  :VALJUR, ';
  LstrSQL := LstrSQL + '  :VALDES, ';
  LstrSQL := LstrSQL + '  :VALPRI ';
  LstrSQL := LstrSQL + '  '+ifThen(LblnColSerie_, ',:SERIE_', '')+') ';

  LqryBanCtr := fCriaQuery;
  LqryBanCtr.Close ;
  LqryBanCtr.SQL.Clear ;
  LqryBanCtr.SQL.Add(LstrSQL) ;
  LqryBanCtr.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('BANCTR', AstrCodEmp) ;
  LqryBanCtr.ParamByName('SEQLAN').AsString := AstrSeqLan ;

  LqryBanCtr.ParamByName('CODCLI').AsString := ALogBan.strCodCli ;
  LqryBanCtr.ParamByName('CODEMP').AsString := ALogBan.strCodEmp ;
  LqryBanCtr.ParamByName('ESPDOC').AsString := ALogBan.strEspDoc ;
  LqryBanCtr.ParamByName('HIST01').AsString := ALogBan.strHist01 ;
  LqryBanCtr.ParamByName('HIST02').AsString := ALogBan.strHist02 ;
  LqryBanCtr.ParamByName('NUMDUP').AsString := ALogBan.strNumDup ;
  LqryBanCtr.ParamByName('PARCEL').AsString := ALogBan.strParcel ;
  LqryBanCtr.ParamByName('SEQBAI').AsInteger := ALogBan.intSeqBai ;
  LqryBanCtr.ParamByName('VALREC').AsFloat := ALogBan.fltValRec ;
  LqryBanCtr.ParamByName('VALJUR').AsFloat := ALogBan.fltValJur ;
  LqryBanCtr.ParamByName('VALDES').AsFloat := ALogBan.fltValDes ;
  LqryBanCtr.ParamByName('VALPRI').AsFloat := ALogBan.fltValPri ;
  if LblnColSerie_ then
    LqryBanCtr.ParamByName('SERIE_').AsString := '' ;
  LqryBanCtr.ExecSQL ;

  Result := True ;

end;

function fSeqContaBanco(intQtdCod: Integer = 1): String;
  Var
    strSequen: String;
    blnComita: Boolean;

    function fSequenCadastrado: Boolean;
      Var
        qryGenTmp : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
    begin

      Try
        qryGenTmp := fCriaQuery;

        With qryGenTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT SQL_NO_CACHE CTB_SEQLAN FROM MOVBAN WHERE CTB_SEQLAN = :SEQLAN LIMIT 1');
          ParamByName('SEQLAN').AsString := strSequen;
          Open;
          Result := (Not IsEmpty);
          Close;
        End;

      Finally
        //FreeAndNil(qryGenTmp);
      End;

    end;

begin
  blnComita := False;

  If Not objConnectionsManager.CurrentConnection.InTransaction Then
  Begin
    fStartTransaction;
    blnComita := True;
  End;

  Repeat
    strSequen := VS_strCodEmp + fAtualizaProCod('MOVBAN', Nil, intQtdCod);
  Until (Not fSequenCadastrado);

  Result :=  strSequen;

  If blnComita Then
    fCommit;

end;



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
                      lstLogBan: TObjectList<TBanCtr>;
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
                      ALogBanDS: String = '';
                      AEmpresaTransferenciaValores: String = '';
                      ATransferenciaLiberada: String = 'S';
                      ASequencialDepositoCheque: String = ''): String;
Var
  strSQL: String;
  qryGenBan : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  qryConPor : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  objLogBan : TBanCtr;
  blnBaiAna : Boolean;
begin
  Try
    If Not fEmptyStr(strCodPor) Then
    Begin
      qryConPor := fCriaQuery;
      try
        strSQL := '';
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   POR_DTAINI ';
        strSQL := strSQL + ' FROM CADPOR ';
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   POR_CODPOR = :CODPOR ';

        qryConPor.Close;
        qryConPor.SQL.Clear;
        qryConPor.SQL.Add(strSQL);
        qryConPor.ParamByName('CODPOR').AsString := strCodPor;
        qryConPor.Open;

        If (qryConPor.IsEmpty) Or (qryConPor.FieldByName('POR_DTAINI').AsDateTime > dtaDtaLan) Then
        Begin
          Result := '';
          Raise Exception.Create('Não foi possível gravar a movimentação bancária. A data inicial do portador com código ' +
                                 strCodPor + ' tem a data inicial menor que a do lançamento.');
          Exit;

        End;
      finally
        {$IFNDEF LINUX} FreeAndNil(qryConPor) ; {$ENDIF LINUX}
      end;
    End;

    qryGenBan := fCriaQuery;
    try
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

      qryGenBan.Close;
      qryGenBan.SQL.Clear;
      qryGenBan.SQL.Add(strSQL);
      qryGenBan.ParamByName('SEQLAN').AsString   := Result;
      qryGenBan.ParamByName('GERCON').AsInteger := intGerCon;

      If fEmptyStr(strCodCta) Then
        qryGenBan.ParamByName('CODCTA').Value := Null
      Else
        qryGenBan.ParamByName('CODCTA').AsString := strCodCta;

      If fEmptyStr(strCodPor) Then
        qryGenBan.ParamByName('CODPOR').Value := Null
      Else
        qryGenBan.ParamByName('CODPOR').AsString := strCodPor;

      qryGenBan.ParamByName('CODOPE').AsString   := strCodOpe;
      qryGenBan.ParamByName('DTALAN').AsDateTime := dtaDtaLan;
      qryGenBan.ParamByName('HORLAN').AsDateTime := horHorLan;
      qryGenBan.ParamByName('NUMDOC').AsString   := RightStr(Trim(strNumDoc), 12);
      qryGenBan.ParamByName('CREDEB').AsString   := strCreDeb;
      qryGenBan.ParamByName('VALLAN').AsFloat    := Abs(fltValLan);
      qryGenBan.ParamByName('HIST01').AsString   := copy(strHist01,1,60);
      qryGenBan.ParamByName('HIST02').AsString   := copy(strHist02,1,60);
      qryGenBan.ParamByName('CODEMP').AsString   := strCodEmp;

      If fEmptyStr(strAutInc) Then
        qryGenBan.ParamByName('AUTINC').AsString := fRetAutoIncrem('MOVBAN', strCodEmp)
      Else
        qryGenBan.ParamByName('AUTINC').AsString := strAutInc;

      If (fEmptyStr(strCodCli)) Then
        qryGenBan.ParamByName('CODCLI').Value := Null
      Else
        qryGenBan.ParamByName('CODCLI').AsString   := strCodCli;

      If (fEmptyStr(strCodFor)) Then
        qryGenBan.ParamByName('CODFOR').Value := Null
      Else
        qryGenBan.ParamByName('CODFOR').AsString   := strCodFor;

      qryGenBan.ParamByName('NUMDUP').AsString   := strNumDup;

      if blnBaiAna then
         qryGenBan.ParamByName('SEQBAI').AsInteger  := intSeqBai
      else
         qryGenBan.ParamByName('SEQBAI').Value      := Null;

      qryGenBan.ParamByName('PARCEL').AsString   := strParcel;

      If fEmptyStr(strEmpDup) Then
        qryGenBan.ParamByName('EMPDUP').Value    := Null
      Else
        qryGenBan.ParamByName('EMPDUP').AsString := strEmpDup;

      qryGenBan.ParamByName('SERIE_').AsString   := strSerie;

      If (fEmptyStr(strCodEve)) Then
        qryGenBan.ParamByName('CODEVE').Value := Null
      Else
        qryGenBan.ParamByName('CODEVE').AsString := strCodEve;

      If (fEmptyStr(strDocBai)) Then
        qryGenBan.ParamByName('DOCBAI').Value := Null
      Else
        qryGenBan.ParamByName('DOCBAI').AsString := strDocBai;

      If (fEmptyStr(strCompet)) then
        qryGenBan.ParamByName('COMPET').Value := FormatDateTime('mm/YYYY',dtaDtaLan)
      Else
        qryGenBan.ParamByName('COMPET').Value := strCompet;

      qryGenBan.ParamByName('SEQTRF').AsInteger  := intSeqTrf;
      If intSeqTrf = 0 Then
        qryGenBan.ParamByName('SEQTRF').Clear;

      qryGenBan.ParamByName('PAGCON').AsInteger  := intSeqCon;
      If intSeqCon = 0 Then
        qryGenBan.ParamByName('PAGCON').Clear;

      If fEmptyStr(strSeqCtp) Then
        qryGenBan.ParamByName('SEQCTP').Value := Null
      Else
        qryGenBan.ParamByName('SEQCTP').AsString := strSeqCtp;

      qryGenBan.ParamByName('ORIGEM').Value := ALogBanDS ;

      If fEmptyStr(strCodChq) Then
        qryGenBan.ParamByName('CODCHQ').Value := Null
      Else
        qryGenBan.ParamByName('CODCHQ').AsString := strCodChq;

      If fEmptyStr(strCodCar) Then
        qryGenBan.ParamByName('CODCAR').Value := Null
      Else
        qryGenBan.ParamByName('CODCAR').AsString := strCodCar;

      qryGenBan.ParamByName('EMPTRA').Value := Null;
      If Not AEmpresaTransferenciaValores.IsEmpty Then
        qryGenBan.ParamByName('EMPTRA').AsString := AEmpresaTransferenciaValores;

      qryGenBan.ParamByName('TRFLIB').AsString := 'S';
      If Not ATransferenciaLiberada.IsEmpty Then
        qryGenBan.ParamByName('TRFLIB').AsString := ATransferenciaLiberada;

      qryGenBan.ParamByName('SEQDEP').Value := Null;
      If Not ASequencialDepositoCheque.IsEmpty Then
        qryGenBan.ParamByName('SEQDEP').AsString := ASequencialDepositoCheque;

      qryGenBan.ExecSQL;
      qryGenBan.Close;


      if (Assigned(lstLogBan)) then
      Begin
        For objLogBan In lstLogBan Do
          fGravaBanCtr(objLogBan, strCodEmp, Result);
      End;

    finally
      {$IFNDEF LINUX} FreeAndNil(qryGenBan); {$ENDIF LINUX}
    end;


  Except
    On E: Exception Do
    Begin
      Result := '';
      Raise Exception.Create(E.Message);
    End;
  End;

end;

function fGetOrigem(lstLogBan: TObjectList<TBanCtr>; ALogBanDS: TList<TLogBanDS>): Variant;
  Var
    strOrigem : String;
begin
  strOrigem := '';
  Result := 'CTR';

  if Assigned(ALogBanDS) And Not Assigned(lstLogBan) Then
    Result := ALogBanDS[0].fGetOrigem;

  If Not fCfgSis('ORIEST', varBoolean) Then
  Begin
    If ((lstLogBan <> Nil) And (lstLogBan.Count > 0) And (lstLogBan[0] <> Nil)) Then
      strOrigem := 'CTR';

    If (strOrigem = 'MCA') Then Result := 'ECR' // ESTORNO DE CARTÃO
    Else If (strOrigem = 'CTR') Then  Result := 'ERC' // ESTORNO DE CONTAS A RECEBER
    Else If (strOrigem = 'CTP') Then  Result := 'EPG'; // ESTORNO DE CONTAS A PAGAR
  End;
end;


end.
