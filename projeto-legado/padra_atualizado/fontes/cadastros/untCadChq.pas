unit untCadChq;

interface

uses
  Uni, frxClass, frxDBSet, frxDMPExport, UniClientDataSet, DBClient, DB;

  function fPortador(strCodPor: String): String;

  procedure pDepositaCheque(strCodBco,
                            strNumAge,
                            strConCor,
                            strNumChq,
                            strCodEmp,
                            strCtaDep: String;
                            dtaDtaDep: TDateTime;
                            strDocDep,
                            strPorBai,
                            strCtaBai: String;
                            strHistor: String;
                            strPorDeb: String;
                            strCtaDeb: String;
                            dtaDtaTra: TDateTime;
                            Var strSeqDep: String;
                            strPorCre: String = '';
                            strCtaCre: String = '';
                            ATaxaDescAnt: Double = 0);

  procedure pRepassaCheque(strCodBco,
                           strNumAge,
                           strConCor,
                           strNumChq,
                           strCodEmp,
                           strForRep: String;
                           dtaDtaRep: TDateTime;
                           strObsRep: String;
                           intSeqRCH: Integer = 0);

  procedure pCustodiaCheque(strCodBco,
                            strNumAge,
                            strConCor,
                            strNumChq,
                            strCodEmp,
                            strPorCus: String;
                            dtaDtaCus: TDateTime;
                            strDocCus,
                            strLotCus: String);


  procedure pCancelaRepasse(strCodBco,
                            strNumAge,
                            strConCor,
                            strNumChq,
                            strCodEmp: String);

  procedure pCancelaCustodia(strCodBco,
                             strNumAge,
                             strConCor,
                             strNumChq,
                             strCodEmp: String);

  function fChequeEstaDepositado(AstrCodigoBanco,
                                 AstrNumeroAgencia,
                                 AstrContaCorrente,
                                 AstrNumeroCheque,
                                 AstrCodigoEmpresa: String) : Boolean ;

  function fGravaChqDev(strSeqGer,
                        strNumChq,
                        strConCor,
                        strNumAge,
                        strCodBco,
                        strCtaDep: String;
                        dtaDtaDep: TDateTime;
                        strDocDep,
                        strCodPor,
                        strCodCta: String;
                        dtaDtaDev: TDateTime;
                        strMotDev,
                        strCodEmp: String): Boolean;

  function fGravaCheque(strCodBco,
                        strNumAge,
                        strConCor,
                        strNumChq,
                        strCodCli,
                        strNomEmi,
                        strEndere,
                        strTelEmi,
                        strCgcCpf,
                        strC_g_c_,
                        strHist01,
                        strHist02,
                        strCtaDep,
                        strDocDep,
                        strCodPor,
                        strCodCta,
                        strMotDev,
                        strForRep,
                        strObsRep,
                        strCodEmp,
                        strNumNot,
                        strPorCus,
                        strDocume,
                        strIncCtr: String;
                        dtaDtaCad,
                        dtaDtaVen,
                        dtaDtaDep,
                        dtaDtaDev,
                        dtaDtaRdp,
                        dtaDtaRep,
                        dtaDtaCus: TDateTime;
                        fltValChq: Double;
                        strSeqCom: String;
                        intSeqCon: Integer;
                        strEmpRcx: String;
                        intResCai: Integer;
                        strTelChe,
                        strTelNum,
                        strCodOpe,
                        strCodCmc: String;
                        fltValIpi,
                        fltValRet,
                        fltValAce,
                        fltValFre: Double;
                        strPorChq,
                        strNomFrm,
                        strNaoDep,
                        strCodCid: String;
                        strCodigoCaixa: String = '';
                        strSeqAnt: String = '';
                        strAutIncAdt: String = '';
                        fltValCbs: Double = 0;
                        fltValIbs: Double = 0;
                        fltVal_Is: Double = 0): Boolean;

  function fGravaChequeEmitido(strCodBco,
                               strNumAge,
                               strNumChq,
                               strCodFor,
                               strNumDup,
                               strParCel,
                               strSerie_,
                               strCodEmp: String;
                               intSeqBai: Integer;
                               strOpeBai: String;
                               dtaDtaBai: TDateTime;
                               fltValBai: Double;
                               strAnaSin,
                               strNumDoc,
                               strHistor,
                               strConCor,
                               strBomPar,
                               strFavore,
                               strDtaEmi,
                               strCodPor: String): Boolean;

  function fRetDadPosContabil(strFiltro: String; dtaFin: TDateTime): TUniClientDataSet;

  function fRetCodPorChq(strChaveChq:String):String;

  function fExisteCheque(strCodBco, strNumAge, strConCor, strNumChq: String): Boolean;

  procedure pAcertaHistoricoCadChqPeloDesmembramentoPedido(strNumDoc, strEspDoc, strCodEmp, strAutInc: String);

  function TransferenciaLiberada(AUsaLiberacaoTransferencia,
                                 AVeioResumoCaixa: Boolean;
                                 AChequeLiberado: String): Boolean;

implementation

uses SysUtils, StrUtils, Variants, untFuncoesSimples;

{******************************************}
{* DEPOSITA O CHEQUE QUE ESTA POSICIONADO *}
{* ATUALMENTE                             *}
{***************************************MV*}
procedure pDepositaCheque(strCodBco,
                          strNumAge,
                          strConCor,
                          strNumChq,
                          strCodEmp,
                          strCtaDep: String;
                          dtaDtaDep: TDateTime;
                          strDocDep,
                          strPorBai,
                          strCtaBai: String;
                          strHistor: String;
                          strPorDeb: String;
                          strCtaDeb: String;
                          dtaDtaTra: TDateTime;
                          Var strSeqDep: String;
                          strPorCre: String = '';
                          strCtaCre: String = '';
                          ATaxaDescAnt: Double = 0);
  Var
    strSQL   : String;
    qryGenChq: TUniQuery;
    blnUtilizandoDtaDep2 : Boolean;

begin
  Try

    qryGenChq := fCriaQuery;

    If fEmptyStr(strSeqDep) Then
    Begin
      strSeqDep := fAtualizaProCod('CADCHQ', 'CHQ_SEQDEP', '', 1, Nil,
        function (const AValue: String) : String
        begin
          Result := fStrZero(RightStr(AValue, 6), 6);
        end
      );
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT * FROM CADCHQ ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CHQ_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  CHQ_NUMAGE = :NUMAGE AND ';
    strSQL := strSQL + '  CHQ_CONCOR = :CONCOR AND ';
    strSQL := strSQL + '  CHQ_NUMCHQ = :NUMCHQ     ';

    Try

      With qryGenChq Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        {*****************************************}
        {* DADOS DO FILTRO                       *}
        {**************************************MV*}
        ParamByName('CODBCO').AsString := strCodBco;
        ParamByName('NUMAGE').AsString := strNumAge;
        ParamByName('CONCOR').AsString := strConCor;
        ParamByName('NUMCHQ').AsString := strNumChq;

        Open;

        Edit;
        If (FieldByName('CHQ_DTADEP').IsNull) And ((FieldByName('CHQ_DEVDEF').IsNull) Or (FieldByName('CHQ_DEVDEF').AsInteger = 0)) Then
        Begin
          FieldByName('CHQ_CTADEP').AsString   := strCtaDep;
          FieldByName('CHQ_DTADEP').AsDateTime := dtaDtaDep;
          blnUtilizandoDtaDep2 := False;
        End
        Else
        Begin
          If (FieldByName('CHQ_DTADEV').IsNull)  Then
            Raise Exception.Create('AUT001 - Não foi possível realizar o depósito, pois o cheque nº ' +
                  strNumChq + ' já foi depositado. Operação cancelada.')
          Else
          Begin
            If (FieldByName('CHQ_DTADP2').IsNull) And ((FieldByName('CHQ_DEVDEF').IsNull) Or (FieldByName('CHQ_DEVDEF').AsInteger = 0)) Then
            Begin
              FieldByName('CHQ_DEPORI').Value := FieldByName('CHQ_CTADEP').Value;
              FieldByName('CHQ_PRCORI').Value := FieldByName('CHQ_CODPOR').Value;
              FieldByName('CHQ_CTCORI').Value := FieldByName('CHQ_CODCTA').Value;
              FieldByName('CHQ_PRDORI').Value := FieldByName('CHQ_PORDEB').Value;
              FieldByName('CHQ_CTDORI').Value := FieldByName('CHQ_CTADEB').Value;

              FieldByName('CHQ_CTADEP').AsString   := strCtaDep;
              FieldByName('CHQ_DTADP2').AsDateTime := dtaDtaDep;
              blnUtilizandoDtaDep2 := True;
            End
            Else
            Begin
              Raise Exception.Create('AUT001 - Não foi possível realizar o depósito, pois o cheque nº ' +
                    strNumChq + ' já foi depositado pela segunda vez. Operação cancelada.');

            End;
          End;
        End;

        If dtaDtaTra <> 0 Then
          FieldByName('CHQ_DTATRA').AsDateTime := dtaDtaTra;

        If (Not fEmptyStr(strHistor)) Then
          FieldByName('CHQ_HISTOR').AsString   := strHistor;

        If (Not fEmptyStr(strPorCre)) Then
          fieldByName('CHQ_PORCRE').AsString   := strPorCre;

        If (Not fEmptyStr(strCtaCre)) Then
          fieldByName('CHQ_CTACRE').AsString   := strCtaCre;

        If (Not fEmptyStr(strCtaDeb)) Then
          FieldByName('CHQ_CTADEB').AsString   := strCtaDeb;

        If (Not fEmptyStr(strPorBai)) Then
          FieldByName('CHQ_CODPOR').AsString   := strPorBai
        Else
          FieldByName('CHQ_CODPOR').Value      := Null;

        {*****************************************************}
        {* GRAVA Null NOS CAMPOS CODPOR/PORDEB/CODCTA/DOCDEB *}
        {* NO CASO DE REPASSE DE CHEQUES                     *}
        {**************************************************AA*}
        If (Not fEmptyStr(strPorDeb)) Then
          FieldByName('CHQ_PORDEB').AsString   := strPorDeb
        Else
          FieldByName('CHQ_PORDEB').Value      := Null;

        If (Not fEmptyStr(strCtaBai)) Then
          FieldByName('CHQ_CODCTA').AsString   := strCtaBai
        Else
          FieldByName('CHQ_CODCTA').Value      := Null;

        If (Not fEmptyStr(strDocDep)) Then
          FieldByName('CHQ_DOCDEP').AsString   := strDocDep
        Else
          FieldByName('CHQ_DOCDEP').Value      := Null;

        FieldByName('CHQ_SEQDEP').AsString   := strSeqDep;
        FieldByName('CHQ_TAXANT').AsFloat    := ATaxaDescAnt;
        FieldByName('CHQ_EMPDEP').AsString   := VS_strCodEmp;

        If dtaDtaDep > 0 Then
        Begin
          If blnUtilizandoDtaDep2 Then
          Begin
             FieldByName('CHQ_DTABA2').AsDateTime := dtaDtaDep;
             FieldByName('CHQ_SEQDP2').AsString   := strDocDep;
          End
          Else
          Begin
             FieldByName('CHQ_DTABA1').AsDateTime := dtaDtaDep;
             FieldByName('CHQ_SEQDP1').AsString   := strDocDep;
          End;
        End;

        Post;

        strHistor := '';
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(qryGenChq);
  End;

end;

procedure pRepassaCheque(strCodBco,
                         strNumAge,
                         strConCor,
                         strNumChq,
                         strCodEmp,
                         strForRep: String;
                         dtaDtaRep: TDateTime;
                         strObsRep: String;
                         intSeqRCH: Integer = 0);
  Var
    strSQL   : String;
    qryGenChq: TUniQuery;
begin
  Try

    qryGenChq := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  CADCHQ ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  CHQ_FORREP = :FORREP, ';
    strSQL := strSQL + '  CHQ_DTAREP = :DTAREP, ';
    strSQL := strSQL + '  CHQ_OBSREP = :OBSREP, ';
    strSQL := strSQL + '  CHQ_SEQRCH = :SEQRCH, ';
    strSQL := strSQL + '  CHQ_EMPRCH = :EMPRCH  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CHQ_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  CHQ_NUMAGE = :NUMAGE AND ';
    strSQL := strSQL + '  CHQ_CONCOR = :CONCOR AND ';
    strSQL := strSQL + '  CHQ_NUMCHQ = :NUMCHQ     ';

    Try

      With qryGenChq Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        {*****************************************}
        {* DADOS QUE SERÃO ATUALIZADOS           *}
        {**************************************MV*}
        If fEmptyStr(strForRep) Then
          ParamByName('FORREP').Value := null
        Else
          ParamByName('FORREP').AsString := strForRep;

        ParamByName('DTAREP').AsDateTime := dtaDtaRep;
        ParamByName('OBSREP').AsString   := strObsRep;

        If intSeqRCH > 0 Then
          ParamByName('SEQRCH').AsInteger := intSeqRCH
        Else ParamByName('SEQRCH').Value  := Null;

        If intSeqRCH > 0 Then
          ParamByName('EMPRCH').AsString := VS_strCodEmp
        Else ParamByName('EMPRCH').Value := Null;

        {*****************************************}
        {* DADOS DO FILTRO                       *}
        {**************************************MV*}
        ParamByName('CODBCO').AsString := strCodBco;
        ParamByName('NUMAGE').AsString := strNumAge;
        ParamByName('CONCOR').AsString := strConCor;
        ParamByName('NUMCHQ').AsString := strNumChq;

        ExecSQL;
        Close;

      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(qryGenChq);
  End;

end;

procedure pCustodiaCheque(strCodBco,
                          strNumAge,
                          strConCor,
                          strNumChq,
                          strCodEmp,
                          strPorCus: String;
                          dtaDtaCus: TDateTime;
                          strDocCus,
                          strLotCus: String);
  Var
    strSQL   : String;
    qryGenChq: TUniQuery;

begin
  Try

    qryGenChq := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'UPDATE CADCHQ ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  CHQ_PORCUS = :PORCUS, ';
    strSQL := strSQL + '  CHQ_DTACUS = :DTACUS, ';

    If Not fEmptyStr(strLotCus) Then
      strSQL := strSQL + '  CHQ_LOTCUS = :LOTCUS, ';

    strSQL := strSQL + '  CHQ_DOCCUS = :DOCCUS  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CHQ_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  CHQ_NUMAGE = :NUMAGE AND ';
    strSQL := strSQL + '  CHQ_CONCOR = :CONCOR AND ';
    strSQL := strSQL + '  CHQ_NUMCHQ = :NUMCHQ     ';

    Try

      With qryGenChq Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        {*****************************************}
        {* DADOS QUE SERÃO ATUALIZADOS           *}
        {**************************************MV*}
        ParamByName('PORCUS').AsString   := strPorCus;
        ParamByName('DTACUS').AsDateTime := dtaDtaCus;
        ParamByName('DOCCUS').AsString   := strDocCus;

        If Not fEmptyStr(strLotCus) Then
          ParamByName('LOTCUS').AsString := strLotCus;

        {*****************************************}
        {* DADOS DO FILTRO                       *}
        {**************************************MV*}
        ParamByName('CODBCO').AsString := strCodBco;
        ParamByName('NUMAGE').AsString := strNumAge;
        ParamByName('CONCOR').AsString := strConCor;
        ParamByName('NUMCHQ').AsString := strNumChq;

        ExecSQL;
        Close;

      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(qryGenChq);
  End;

end;


procedure pCancelaRepasse(strCodBco,strNumAge,strConCor,strNumChq,strCodEmp: String);
  Var
    strSQL   : String;
    qryGenChq: TUniQuery;
begin
  Try

    qryGenChq := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'UPDATE CADCHQ ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  CHQ_DTADEP = IF(CHQ_DTADP2 IS NULL, NULL, CHQ_DTADEP), ';
    strSQL := strSQL + '  CHQ_DTADP2 = NULL, ';
    strSQL := strSQL + '  CHQ_CODCTA = NULL, ';
    strSQL := strSQL + '  CHQ_CODPOR = NULL, ';
    strSQL := strSQL + '  CHQ_CTADEP = NULL, ';
    strSQL := strSQL + '  CHQ_DOCDEP = NULL, ';
    strSQL := strSQL + '  CHQ_FORREP = NULL, ';
    strSQL := strSQL + '  CHQ_DTAREP = NULL, ';
    strSQL := strSQL + '  CHQ_CTADEP = NULL, ';
    strSQL := strSQL + '  CHQ_DOCDEP = NULL, ';
    strSQL := strSQL + '  CHQ_PORDEB = NULL, ';
    strSQL := strSQL + '  CHQ_CTADEB = NULL, ';
    strSQL := strSQL + '  CHQ_PORCRE = NULL, ';
    strSQL := strSQL + '  CHQ_CTACRE = NULL, ';
    strSQL := strSQL + '  CHQ_OBSREP = NULL, ';
    strSQL := strSQL + '  CHQ_SEQDEP = NULL ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CHQ_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  CHQ_NUMAGE = :NUMAGE AND ';
    strSQL := strSQL + '  CHQ_CONCOR = :CONCOR AND ';
    strSQL := strSQL + '  CHQ_NUMCHQ = :NUMCHQ     ';

    Try

      With qryGenChq Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        {*****************************************}
        {* DADOS DO FILTRO                       *}
        {**************************************MV*}
        ParamByName('CODBCO').AsString := strCodBco;
        ParamByName('NUMAGE').AsString := strNumAge;
        ParamByName('CONCOR').AsString := strConCor;
        ParamByName('NUMCHQ').AsString := strNumChq;

        ExecSQL;
        Close;

      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(qryGenChq);
  End;

end;

procedure pCancelaCustodia(strCodBco,strNumAge,strConCor,strNumChq,strCodEmp: String);
  Var
    strSQL   : String;
    qryGenChq: TUniQuery;
begin
  Try

    qryGenChq := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'UPDATE CADCHQ ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  CHQ_PORCUS = NULL, ';
    strSQL := strSQL + '  CHQ_DTACUS = NULL, ';
    strSQL := strSQL + '  CHQ_DOCCUS = NULL, ';
    strSQL := strSQL + '  CHQ_LOTCUS = NULL  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CHQ_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  CHQ_NUMAGE = :NUMAGE AND ';
    strSQL := strSQL + '  CHQ_CONCOR = :CONCOR AND ';
    strSQL := strSQL + '  CHQ_NUMCHQ = :NUMCHQ     ';

    Try

      With qryGenChq Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        {*****************************************}
        {* DADOS DO FILTRO                       *}
        {**************************************MV*}
        ParamByName('CODBCO').AsString := strCodBco;
        ParamByName('NUMAGE').AsString := strNumAge;
        ParamByName('CONCOR').AsString := strConCor;
        ParamByName('NUMCHQ').AsString := strNumChq;

        ExecSQL;
        Close;

      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(qryGenChq);
  End;

end;


function fGravaChqDev(strSeqGer,
                      strNumChq,
                      strConCor,
                      strNumAge,
                      strCodBco,
                      strCtaDep: String;
                      dtaDtaDep: TDateTime;
                      strDocDep,
                      strCodPor,
                      strCodCta: String;
                      dtaDtaDev: TDateTime;
                      strMotDev,
                      strCodEmp: String): Boolean;
  Var
    qryTblChqDev: TUniQuery;
    strAutInc: String;
begin

  Try
    qryTblChqDev := fCriarQuery('SELECT * FROM CHQDEV WHERE FALSE');

    Try

      strAutInc := fRetAutoIncrem('CHQDEV', VS_strCodEmp);

      If (Not qryTblChqDev.Active) Then
        fAbrirTabela(qryTblChqDev);

      qryTblChqDev.Insert;
      qryTblChqDev.FieldByName('CHQ_SEQGER').AsString   := strSeqGer;
      qryTblChqDev.FieldByName('CHQ_NUMCHQ').AsString   := strNumChq;
      qryTblChqDev.FieldByName('CHQ_CONCOR').AsString   := strConCor;
      qryTblChqDev.FieldByName('CHQ_NUMAGE').AsString   := strNumAge;
      qryTblChqDev.FieldByName('CHQ_CODBCO').AsString   := strCodBco;
      qryTblChqDev.FieldByName('CHQ_CTADEP').AsString   := strCtaDep;
      qryTblChqDev.FieldByName('CHQ_DTADEP').AsDateTime := dtaDtaDep;
      qryTblChqDev.FieldByName('CHQ_DOCDEP').AsString   := strDocDep;
      qryTblChqDev.FieldByName('CHQ_CODPOR').AsString   := strCodPor;

      If fEmptyStr(strCodCta) then
        qryTblChqDev.FieldByName('CHQ_CODCTA').Value := Null
      Else
        qryTblChqDev.FieldByName('CHQ_CODCTA').AsString   := strCodCta;

      qryTblChqDev.FieldByName('CHQ_DTADEV').AsDateTime := dtaDtaDev;
      qryTblChqDev.FieldByName('CHQ_MOTDEV').AsString   := strMotDev;
      qryTblChqDev.FieldByName('AUTOINCREM').AsString   := strAutInc;
      qryTblChqDev.FieldByName('CHQ_CODEMP').AsString   := strCodEmp;
      qryTblChqDev.Post;

      Result := True;

    Except
      On E: Exception Do
      Begin
        Result := False;
        qryTblChqDev.Cancel;
        pMensagensErro(E.Message, '[fGravaChqDev]');
      End;
    End;

  Finally
    FreeAndNil(qryTblChqDev);
  End;

end;

function fGravaCheque(strCodBco,
                      strNumAge,
                      strConCor,
                      strNumChq,
                      strCodCli,
                      strNomEmi,
                      strEndere,
                      strTelEmi,
                      strCgcCpf,
                      strC_g_c_,
                      strHist01,
                      strHist02,
                      strCtaDep,
                      strDocDep,
                      strCodPor,
                      strCodCta,
                      strMotDev,
                      strForRep,
                      strObsRep,
                      strCodEmp,
                      strNumNot,
                      strPorCus,
                      strDocume,
                      strIncCtr: String;
                      dtaDtaCad,
                      dtaDtaVen,
                      dtaDtaDep,
                      dtaDtaDev,
                      dtaDtaRdp,
                      dtaDtaRep,
                      dtaDtaCus: TDateTime;
                      fltValChq: Double;
                      strSeqCom: String;
                      intSeqCon: Integer;
                      strEmpRcx: String;
                      intResCai: Integer;
                      strTelChe,
                      strTelNum,
                      strCodOpe,
                      strCodCmc: String;
                      fltValIpi,
                      fltValRet,
                      fltValAce,
                      fltValFre: Double;
                      strPorChq,
                      strNomFrm,
                      strNaoDep,
                      strCodCid: String;
                      strCodigoCaixa: String = '';
                      strSeqAnt: String = '';
                      strAutIncAdt: String = '';
                      fltValCbs: Double = 0;
                      fltValIbs: Double = 0;
                      fltVal_Is: Double = 0): Boolean;
  Var
    strSQL: String;
    qryGenChq : TUniQuery;
begin

  Try

    qryGenChq := fCriaQuery;

    Try
      strSQL := '';
      strSQL := strSQL + ' INSERT INTO CADCHQ ';
      strSQL := strSQL + ' (CHQ_CODBCO, ';
      strSQL := strSQL + '  CHQ_NUMAGE, ';
      strSQL := strSQL + '  CHQ_CONCOR, ';
      strSQL := strSQL + '  CHQ_NUMCHQ, ';
      strSQL := strSQL + '  CHQ_CODCLI, ';
      strSQL := strSQL + '  CHQ_NOMEMI, ';
      strSQL := strSQL + '  CHQ_ENDERE, ';
      strSQL := strSQL + '  CHQ_TELEMI, ';
      strSQL := strSQL + '  CHQ_CGCCPF, ';
      strSQL := strSQL + '  CHQ_C_G_C_, ';
      strSQL := strSQL + '  CHQ_DTACAD, ';
      strSQL := strSQL + '  CHQ_DTAVEN, ';
      strSQL := strSQL + '  CHQ_VALCHQ, ';
      strSQL := strSQL + '  CHQ_HIST01, ';
      strSQL := strSQL + '  CHQ_HIST02, ';
      strSQL := strSQL + '  CHQ_CTADEP, ';
      strSQL := strSQL + '  CHQ_DTADEP, ';
      strSQL := strSQL + '  CHQ_DOCDEP, ';
      strSQL := strSQL + '  CHQ_CODPOR, ';
      strSQL := strSQL + '  CHQ_CODCTA, ';
      strSQL := strSQL + '  CHQ_DTADEV, ';
      strSQL := strSQL + '  CHQ_MOTDEV, ';
      strSQL := strSQL + '  CHQ_DTARDP, ';
      strSQL := strSQL + '  CHQ_FORREP, ';
      strSQL := strSQL + '  CHQ_OBSREP, ';
      strSQL := strSQL + '  CHQ_DTAREP, ';
      strSQL := strSQL + '  CHQ_RESCAI, ';
      strSQL := strSQL + '  CHQ_CODEMP, ';
      strSQL := strSQL + '  CHQ_NUMNOT, ';
      strSQL := strSQL + '  CHQ_DTACUS, ';
      strSQL := strSQL + '  CHQ_PORCUS, ';
      strSQL := strSQL + '  CHQ_DOCUME, ';
      strSQL := strSQL + '  CHQ_INCCTR, ';
      strSQL := strSQL + '  CHQ_SEQCOM, ';
      strSQL := strSQL + '  CHQ_SEQCON, ';
      strSQL := strSQL + '  CHQ_EMPRCX, ';
      strSQL := strSQL + '  CHQ_TELCHE, ';
      strSQL := strSQL + '  CHQ_TELNUM, ';
      strSQL := strSQL + '  CHQ_CODOPE, ';
      strSQL := strSQL + '  CHQ_CODCMC, ';
      strSQL := strSQL + '  CHQ_VALIPI, ';
      strSQL := strSQL + '  CHQ_VALRET, ';
      strSQL := strSQL + '  CHQ_VALACE, ';
      strSQL := strSQL + '  CHQ_VALFRE, ';
      strSQL := strSQL + '  CHQ_VALCBS, ';
      strSQL := strSQL + '  CHQ_VALIBS, ';
      strSQL := strSQL + '  CHQ_VAL_IS, ';
      strSQL := strSQL + '  CHQ_PORCHQ, ';
      strSQL := strSQL + '  CHQ_NOMFRM, ';
      strSQL := strSQL + '  CHQ_NAODEP, ';
      strSQL := strSQL + '  CHQ_CODCID, ';
      strSQL := strSQL + '  CHQ_CODCAX, ';
      strSQL := strSQL + '  CHQ_SEQANT, ';
      strSQL := strSQL + '  CHQ_SEQADT, ';
      strSQL := strSQL + '  AUTOINCREM) ';
      strSQL := strSQL + ' VALUES ';
      strSQL := strSQL + ' (:CODBCO, ';
      strSQL := strSQL + '  :NUMAGE, ';
      strSQL := strSQL + '  :CONCOR, ';
      strSQL := strSQL + '  :NUMCHQ, ';
      strSQL := strSQL + '  :CODCLI, ';
      strSQL := strSQL + '  :NOMEMI, ';
      strSQL := strSQL + '  :ENDERE, ';
      strSQL := strSQL + '  :TELEMI, ';
      strSQL := strSQL + '  :CGCCPF, ';
      strSQL := strSQL + '  :C_G_C_, ';
      strSQL := strSQL + '  :DTACAD, ';
      strSQL := strSQL + '  :DTAVEN, ';
      strSQL := strSQL + '  :VALCHQ, ';
      strSQL := strSQL + '  :HIST01, ';
      strSQL := strSQL + '  :HIST02, ';
      strSQL := strSQL + '  :CTADEP, ';
      strSQL := strSQL + '  :DTADEP, ';
      strSQL := strSQL + '  :DOCDEP, ';
      strSQL := strSQL + '  :CODPOR, ';
      strSQL := strSQL + '  :CODCTA, ';
      strSQL := strSQL + '  :DTADEV, ';
      strSQL := strSQL + '  :MOTDEV, ';
      strSQL := strSQL + '  :DTARDP, ';
      strSQL := strSQL + '  :FORREP, ';
      strSQL := strSQL + '  :OBSREP, ';
      strSQL := strSQL + '  :DTAREP, ';
      strSQL := strSQL + '  :RESCAI, ';
      strSQL := strSQL + '  :CODEMP, ';
      strSQL := strSQL + '  :NUMNOT, ';
      strSQL := strSQL + '  :DTACUS, ';
      strSQL := strSQL + '  :PORCUS, ';
      strSQL := strSQL + '  :DOCUME, ';
      strSQL := strSQL + '  :INCCTR, ';
      strSQL := strSQL + '  :SEQCOM, ';
      strSQL := strSQL + '  :SEQCON, ';
      strSQL := strSQL + '  :EMPRCX, ';
      strSQL := strSQL + '  :TELCHE, ';
      strSQL := strSQL + '  :TELNUM, ';
      strSQL := strSQL + '  :CODOPE, ';
      strSQL := strSQL + '  :CODCMC, ';
      strSQL := strSQL + '  :VALIPI, ';
      strSQL := strSQL + '  :VALRET, ';
      strSQL := strSQL + '  :VALACE, ';
      strSQL := strSQL + '  :VALFRE, ';
      strSQL := strSQL + '  :VALCBS, ';
      strSQL := strSQL + '  :VALIBS, ';
      strSQL := strSQL + '  :VAL_IS, ';
      strSQL := strSQL + '  :PORCHQ, ';
      strSQL := strSQL + '  :NOMFRM, ';
      strSQL := strSQL + '  :NAODEP, ';
      strSQL := strSQL + '  :CODCID, ';
      strSQL := strSQL + '  :CODCAX, ';
      strSQL := strSQL + '  :SEQANT, ';
      strSQL := strSQL + '  :SEQADT, ';
      strSQL := strSQL + '  :AUTINC) ';

      With qryGenChq Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        If fEmptyStr(strCodBco) Then
          ParamByName('CODBCO').AsString  := Null
        Else
          ParamByName('CODBCO').AsString  := strCodBco;

        ParamByName('NUMAGE').AsString  := strNumAge;
        ParamByName('CONCOR').AsString  := strConCor;
        ParamByName('NUMCHQ').AsString  := strNumChq;
        ParamByName('CODCLI').AsString  := strCodCli;
        ParamByName('NOMEMI').AsString  := strNomEmi;

        If fEmptyStr(strEndere) Then
          ParamByName('ENDERE').Value := Null
        Else
          ParamByName('ENDERE').AsString := strEndere;

        If fEmptyStr(strTelEmi) Then
          ParamByName('TELEMI').Value := Null
        Else
          ParamByName('TELEMI').AsString := strTelEmi;

        If fEmptyStr(strCgcCpf) Then
          ParamByName('CGCCPF').Value := Null
        Else
          ParamByName('CGCCPF').AsString := strCgcCpf;

        If fEmptyStr(strC_g_c_) Then
          ParamByName('C_G_C_').Value := Null
        Else
          ParamByName('C_G_C_').AsString := strC_g_c_;

        ParamByName('DTACAD').AsDate  := dtaDtaCad;
        ParamByName('DTAVEN').AsDate  := dtaDtaVen;
        ParamByName('VALCHQ').AsFloat := fltValChq;

        If fEmptyStr(strHist01) Then
          ParamByName('HIST01').Value := Null
        Else
          ParamByName('HIST01').AsString := strHist01;

        If fEmptyStr(strHist02) Then
          ParamByName('HIST02').Value := Null
        Else
          ParamByName('HIST02').AsString := strHist02;

        If fEmptyStr(strCtaDep) Then
          ParamByName('CTADEP').Value := Null
        Else
          ParamByName('CTADEP').AsString := strCtaDep;

        If dtaDtaDep = 0 Then
          ParamByName('DTADEP').Value := Null
        Else
          ParamByName('DTADEP').AsDate := dtaDtaDep;

        If fEmptyStr(strDocDep) Then
          ParamByName('DOCDEP').Value := Null
        Else
          ParamByName('DOCDEP').AsString := strDocDep;

        If fEmptyStr(strCodPor) Then
          ParamByName('CODPOR').Value := Null
        Else
          ParamByName('CODPOR').AsString := strCodPor;

        If fEmptyStr(strCodCta) Then
          ParamByName('CODCTA').Value := Null
        Else
          ParamByName('CODCTA').AsString := strCodCta;

        If dtaDtaDev = 0 Then
          ParamByName('DTADEV').Value := Null
        Else
          ParamByName('DTADEV').AsDate := dtaDtaDev;

        If fEmptyStr(strMotDev) Then
          ParamByName('MOTDEV').Value  := Null
        Else
          ParamByName('MOTDEV').AsString  := strMotDev;

        If dtaDtaRdp = 0 Then
          ParamByName('DTARDP').Value := Null
        Else
          ParamByName('DTARDP').AsDate := dtaDtaRdp;

        If fEmptyStr(strForRep) Then
          ParamByName('FORREP').Value := null
        Else
          ParamByName('FORREP').AsString := strForRep;

        ParamByName('OBSREP').AsString  := strObsRep;

        If dtaDtaRep = 0 Then
          ParamByName('DTAREP').Value := Null
        Else
          ParamByName('DTAREP').AsDate := dtaDtaRep;

        ParamByName('RESCAI').AsInteger := intResCai;
        ParamByName('CODEMP').AsString  := strCodEmp;
        ParamByName('NUMNOT').AsString  := strNumNot;

        If dtaDtaCus = 0 Then
          ParamByName('DTACUS').Value := Null
        Else
          ParamByName('DTACUS').AsDate := dtaDtaCus;

        If fEmptyStr(strPorCus) Then
          ParamByName('PORCUS').Value := Null
        Else
          ParamByName('PORCUS').AsString := strPorCus;

        If fEmptyStr(strDocume) Then
          ParamByName('DOCUME').Value := Null
        Else
          ParamByName('DOCUME').AsString := strDocume;

        If fEmptyStr(strIncCtr) Then
          ParamByName('INCCTR').AsString := 'N'
        Else
          ParamByName('INCCTR').AsString := strIncCtr;

        ParamByName('SEQCOM').AsString := strSeqCom;
        If fEmptyStr(strSeqCom) Then
          ParamByName('SEQCOM').Clear;

        ParamByName('SEQCON').AsInteger := intSeqCon;
        ParamByName('EMPRCX').AsString  := strEmpRcx;

        ParamByName('TELCHE').AsString  := strTelChe;
        ParamByName('TELNUM').AsString  := strTelNum;
        If strTelChe <> 'S' Then
          ParamByName('TELNUM').Clear;

        If fEmptyStr(strCodOpe) Then
          ParamByName('CODOPE').Value := Null
        Else
          ParamByName('CODOPE').AsString := strCodOpe;

        If fEmptyStr(strCodCmc) Then
          ParamByName('CODCMC').Value := Null
        Else
          ParamByName('CODCMC').AsString := strCodCmc;

        ParamByName('VALIPI').AsFloat := fltValIpi;
        ParamByName('VALRET').AsFloat := fltValRet;
        ParamByName('VALACE').AsFloat := fltValAce;
        ParamByName('VALFRE').AsFloat := fltValFre;
        ParamByName('VALCBS').AsFloat := fltValCbs;
        ParamByName('VALIBS').AsFloat := fltValIbs;
        ParamByName('VAL_IS').AsFloat := fltVal_Is;

        If fEmptyStr(strPorChq) Then
          ParamByName('PORCHQ').Value := Null
        Else
          ParamByName('PORCHQ').AsString := strPorChq;

        If fEmptyStr(strCodCid) Then
          ParamByName('CODCID').Value := Null
        Else
          ParamByName('CODCID').AsString := strCodCid;

        ParamByName('NOMFRM').AsString := strNomFrm;
        ParamByName('NAODEP').AsString := strNaoDep;
        ParamByName('AUTINC').AsString := fRetAutoIncrem('CADCHQ',VS_strCodEmp);

        ParamByName('CODCAX').Value := Null;
        If Not strCodigoCaixa.IsEmpty Then
          ParamByName('CODCAX').Value := strCodigoCaixa;

        If fEmptyStr(strSeqAnt) Then
          ParamByName('SEQANT').Value := Null
        Else
          ParamByName('SEQANT').AsString := strSeqAnt;

        If fEmptyStr(strAutIncAdt) Then
          ParamByName('SEQADT').Value := Null
        Else
          ParamByName('SEQADT').AsString := strAutIncAdt;

        ExecSQL;
        Close;
      End;

      Result := True;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fGravaCheque]');
      End;
    End;

  Finally
    FreeAndNil(qryGenChq);
  End;

end;

function fGravaChequeEmitido( strCodBco,
                              strNumAge,
                              strNumChq,
                              strCodFor,
                              strNumDup,
                              strParCel,
                              strSerie_,
                              strCodEmp: String;
                              intSeqBai: Integer;
                              strOpeBai: String;
                              dtaDtaBai: TDateTime;
                              fltValBai: Double;
                              strAnaSin,
                              strNumDoc,
                              strHistor,
                              strConCor,
                              strBomPar,
                              strFavore,
                              strDtaEmi,
                              strCodPor: String ): Boolean;
  Var
    strSQL : String;
    qryChequeEmitido : TUniQuery;
begin

  Try

    Try

      Result := True;

      qryChequeEmitido := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + ' INSERT INTO CHQEMI ';
      strSQL := strSQL + ' ( AUTOINCREM,  ';
      strSQL := strSQL + '   EMI_CODBCO,  ';
      strSQL := strSQL + '   EMI_NUMAGE,  ';
      strSQL := strSQL + '   EMI_NUMCHQ,  ';
      strSQL := strSQL + '   EMI_CODFOR,  ';
      strSQL := strSQL + '   EMI_NUMDUP,  ';
      strSQL := strSQL + '   EMI_PARCEL,  ';
      strSQL := strSQL + '   EMI_CODEMP,  ';
      strSQL := strSQL + '   EMI_SEQBAI,  ';
      strSQL := strSQL + '   EMI_SERIE_,  ';
      strSQL := strSQL + '   EMI_OPEBAI,  ';
      strSQL := strSQL + '   EMI_DTABAI,  ';
      strSQL := strSQL + '   EMI_VALBAI,  ';
      strSQL := strSQL + '   EMI_ANASIN,  ';
      strSQL := strSQL + '   EMI_NUMDOC,  ';
      strSQL := strSQL + '   EMI_HISTOR,  ';
      strSQL := strSQL + '   EMI_CONCOR,  ';
      strSQL := strSQL + '   EMI_BOMPAR,  ';
      strSQL := strSQL + '   EMI_FAVORE,  ';
      strSQL := strSQL + '   EMI_CODPOR,  ';
      strSQL := strSQL + '   EMI_DTAEMI)  ';
      strSQL := strSQL + '   VALUES       ';
      strSQL := strSQL + ' ( :AUTOIN,     ';
      strSQL := strSQL + '   :CODBCO,     ';
      strSQL := strSQL + '   :NUMAGE,     ';
      strSQL := strSQL + '   :NUMCHQ,     ';
      strSQL := strSQL + '   :CODFOR,     ';
      strSQL := strSQL + '   :NUMDUP,     ';
      strSQL := strSQL + '   :PARCEL,     ';
      strSQL := strSQL + '   :CODEMP,     ';
      strSQL := strSQL + '   :SEQBAI,     ';
      strSQL := strSQL + '   :SERIE_,     ';
      strSQL := strSQL + '   :OPEBAI,     ';
      strSQL := strSQL + '   :DTABAI,     ';
      strSQL := strSQL + '   :VALBAI,     ';
      strSQL := strSQL + '   :ANASIN,     ';
      strSQL := strSQL + '   :NUMDOC,     ';
      strSQL := strSQL + '   :HISTOR,     ';
      strSQL := strSQL + '   :CONCOR,     ';
      strSQL := strSQL + '   :BOMPAR,     ';
      strSQL := strSQL + '   :FAVORE,     ';
      strSQL := strSQL + '   :CODPOR,     ';
      strSQL := strSQL + '   :DTAEMI)     ';

      With qryChequeEmitido Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('AUTOIN').AsString  := fRetAutoIncrem('CHQEMI',VS_strCodEmp);
        ParamByName('CODBCO').AsString  := strCodBco;
        ParamByName('NUMAGE').AsString  := strNumAge;
        ParamByName('NUMCHQ').AsString  := strNumChq;

        If Not fEmptyStr(strCodFor) Then
          ParamByName('CODFOR').AsString := strCodFor
        Else ParamByName('CODFOR').Value := Null;

        ParamByName('NUMDUP').AsString  := strNumDup;
        ParamByName('PARCEL').AsString  := strParCel;
        ParamByName('CODEMP').AsString  := strCodEmp;
        ParamByName('SEQBAI').AsInteger := intSeqBai;
        ParamByName('SERIE_').AsString  := strSerie_;
        ParamByName('OPEBAI').AsString  := strOpeBai;
        ParamByName('DTABAI').AsDate    := dtaDtaBai;
        ParamByName('VALBAI').AsFloat   := fltValBai;
        ParamByName('ANASIN').AsString  := strAnaSin;
        ParamByName('NUMDOC').AsString  := strNumDoc;
        ParamByName('HISTOR').AsString  := strHistor;
        ParamByName('CONCOR').AsString  := strConCor;

        If fEmptyStr(strBomPar) Then
          ParamByName('BOMPAR').IsNull
        Else
          ParamByName('BOMPAR').AsDate    := StrToDate(strBomPar);

        If fEmptyStr(strDtaEmi) Then
          ParamByName('DTAEMI').IsNull
        Else
          ParamByName('DTAEMI').AsDate    := StrToDate(strDtaEmi);

        If fEmptyStr(strCodPor) Then
          ParamByName('CODPOR').Value := Null
        Else
          ParamByName('CODPOR').AsString := strCodPor;

        ParamByName('FAVORE').AsString  := strFavore;

        ExecSQL;
        Close;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        FreeAndNil(qryChequeEmitido);
        pMensagensErro(E.Message, '[fGravaChequeEmitido]');
      End;

    End;

  Finally
    FreeAndNil(qryChequeEmitido);
  End;

end;

function fPortador(strCodPor: String): String;
  Var
    qryPortador: TUniQuery;
begin

  Try
    qryPortador := fCriaQuery;

    With qryPortador Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT POR_NOMPOR FROM CADPOR WHERE POR_CODPOR = :CODPOR');

      ParamByName('CODPOR').AsString := strCodPor;

      Open;

      Result := strCodPor + ' - ' + FieldByName('POR_NOMPOR').AsString;
    End;

  Finally
    FreeAndNil(qryPortador);
  End;

end;

function fRetDadPosContabil(strFiltro: String; dtaFin: TDateTime): TUniClientDataSet;
  Var
    qryGen: TUniQuery;
    strSQL: String;

  procedure pInsere(dtaData: TDateTime; cdsData: TUniClientDataSet; fltFator: Double = 1);
  Begin
    cdsData.Insert;
    cdsData.FieldByName('DTAREL').AsDateTime := dtaData;
    cdsData.FieldByName('VALREL').AsFloat    := qryGen.FieldByName('CHQ_VALCHQ').AsFloat * fltFator;
    cdsData.FieldByName('DTACUS').AsDateTime := qryGen.FieldByName('CHQ_DTACUS').AsDateTime;
    cdsData.FieldByName('DTAREP').AsDateTime := qryGen.FieldByName('CHQ_DTAREP').AsDateTime;
    cdsData.Post;
  End;

Begin

  Try
    Result := TUniClientDataSet.Create(Nil);
    Result.AggregatesActive := True;

    With Result.FieldDefs.AddFieldDef Do Begin Name := 'DTAREL'; DataType := ftDate;  Required := False; End;
    With Result.FieldDefs.AddFieldDef Do Begin Name := 'VALREL'; DataType := ftFloat; Required := False; End;
    With Result.FieldDefs.AddFieldDef Do Begin Name := 'DTACUS'; DataType := ftDate;  Required := False; End;
    With Result.FieldDefs.AddFieldDef Do Begin Name := 'DTAREP'; DataType := ftDate;  Required := False; End;

    With TAggregateField.Create(Result) Do
    Begin
      FieldName := 'TOT_VALREL'; DataSet := Result;
      Expression := 'SUM(VALREL)'; Active := True;
    End;

    Result.CreateDataSet;
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;

      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   CHQ_DTACAD, CHQ_DTADEV, ';
      strSQL := strSQL + '   CHQ_DTADEP, CHQ_DTADP2, ';
      strSQL := strSQL + '   CHQ_DTADV2, CHQ_DTACUS, ';
      strSQL := strSQL + '   CHQ_DTAREP, CHQ_VALCHQ FROM CADCHQ  ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + strFiltro;
      strSQL := strSQL + '   AND CHQ_DTACAD <= :DTAFIN ';
      SQL.Add(strSQL);
      ParamByName('DTAFIN').AsDateTime := dtaFin;
      Open;
    End;

    While Not qryGen.Eof Do
    Begin

      If (qryGen.FieldByName('CHQ_DTACAD').AsDateTime <> 0) And (qryGen.FieldByName('CHQ_DTACAD').AsDateTime <= dtaFin) Then
        pInsere(qryGen.FieldByName('CHQ_DTACAD').AsDateTime, Result);

      If (qryGen.FieldByName('CHQ_DTADEP').AsDateTime <> 0) And (qryGen.FieldByName('CHQ_DTADEP').AsDateTime <= dtaFin) Then
        pInsere(qryGen.FieldByName('CHQ_DTADEP').AsDateTime, Result, -1);

      If (qryGen.FieldByName('CHQ_DTADV2').IsNull) Or (Not qryGen.FieldByName('CHQ_DTADP2').IsNull) Then
      Begin
        If (qryGen.FieldByName('CHQ_DTADEV').AsDateTime <> 0) And (qryGen.FieldByName('CHQ_DTADEV').AsDateTime <= dtaFin) Then
          pInsere(qryGen.FieldByName('CHQ_DTADEV').AsDateTime, Result);
      End;

      If (qryGen.FieldByName('CHQ_DTADP2').AsDateTime <> 0) And (qryGen.FieldByName('CHQ_DTADP2').AsDateTime <= dtaFin) Then
        pInsere(qryGen.FieldByName('CHQ_DTADP2').AsDateTime, Result, -1);

      qryGen.Next;
    End;

  Except
    On E: Exception Do
    Begin
      FreeAndNil(Result);
      pMensagensErro(E.Message,'');
    End;
  End;

End;

function fRetCodPorChq(strChaveChq:String):String;
Var
  qryConsulta:TUniQuery;
  strRetCheque:String;
begin
  qryConsulta := fCriaQuery(nil);
  qryConsulta.SQL.Add(' SELECT CHQ_PORCHQ FROM CADCHQ WHERE AUTOINCREM = :CHAVECHQ ');
  qryConsulta.ParamByName('CHAVECHQ').AsString := strChaveChq;
  qryConsulta.Open;
  strRetCheque := qryConsulta.Fields[0].AsString;
  result := strRetCheque;
  FreeAndNil(qryConsulta);
end;

function fChequeEstaDepositado(AstrCodigoBanco, AstrNumeroAgencia, AstrContaCorrente,
  AstrNumeroCheque, AstrCodigoEmpresa: String) : Boolean ;
Var
  SQuery : TUniQuery;
begin
  Result := False;
  SQuery := fCriaQuery;

  Try
    Try
      SQuery.SQL.Add(
        ' SELECT Q.CHQ_NUMCHQ '+
        '   FROM CADCHQ Q '+
        '  WHERE Q.CHQ_CODBCO = :CHQ_CODBCO '+
        '    AND Q.CHQ_NUMAGE = :CHQ_NUMAGE '+
        '    AND Q.CHQ_CONCOR = :CHQ_CONCOR '+
        '    AND Q.CHQ_NUMCHQ = :CHQ_NUMCHQ '+
        '    AND Q.CHQ_CODEMP = :CHQ_CODEMP '+
        '    AND Q.CHQ_DTAREP IS NULL '+
        '    AND (Q.CHQ_DTADEV IS NULL OR Q.CHQ_DTADV2 IS NULL) '+
        '    AND (NOT ((Q.CHQ_DTADEP IS NULL) OR ((Q.CHQ_DTADP2 IS NULL) AND (Q.CHQ_DTADEV IS NOT NULL)))) ');
      SQuery.ParamByName('CHQ_CODBCO').AsString := AstrCodigoBanco;
      SQuery.ParamByName('CHQ_NUMAGE').AsString := AstrNumeroAgencia;
      SQuery.ParamByName('CHQ_CONCOR').AsString := AstrContaCorrente;
      SQuery.ParamByName('CHQ_NUMCHQ').AsString := AstrNumeroCheque;
      SQuery.ParamByName('CHQ_CODEMP').AsString := AstrCodigoEmpresa;
      SQuery.Open;
      Result := not SQuery.IsEmpty;
      SQuery.Close;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(SQuery);
  End;

end;

function fExisteCheque(strCodBco, strNumAge, strConCor, strNumChq: String): Boolean;
  Var
    strSQL   : String;
    qryGenChq: TUniQuery;
begin
  Try

    Result := False;

    qryGenChq := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + ' CADCHQ ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CHQ_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  CHQ_NUMAGE = :NUMAGE AND ';
    strSQL := strSQL + '  CHQ_CONCOR = :CONCOR AND ';
    strSQL := strSQL + '  CHQ_NUMCHQ = :NUMCHQ     ';

    With qryGenChq Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;
      ParamByName('NUMAGE').AsString := strNumAge;
      ParamByName('CONCOR').AsString := strConCor;
      ParamByName('NUMCHQ').AsString := strNumChq;
      Open;
      If FieldByName('QTD').AsInteger > 0 Then
        Result := True;
      Close;
    End;

  Finally
    FreeAndNil(qryGenChq);
  End;
end;

procedure pAcertaHistoricoCadChqPeloDesmembramentoPedido(strNumDoc, strEspDoc, strCodEmp, strAutInc: String);
var
  qryHist: TUniQuery;
begin
  qryHist := fCriaQuery;

  try
    qryHist.Close;
    qryHist.SQL.Clear;
    qryHist.SQL.Add('UPDATE CADCHQ SET CHQ_HIST02 = CONCAT(IFNULL(CHQ_HIST02, " "), " ", :HIST02) WHERE CHQ_SEQADT = :AUTINC');
    qryHist.ParamByName('HIST02').AsString := 'REF. AO DOC. '+strNumDoc+'-'+strEspDoc+'-'+strCodEmp+'';
    qryHist.ParamByName('AUTINC').AsString := strAutInc;
    qryHist.ExecSQL;
  finally
    FreeAndNil(qryHist);
  end;
end;

function TransferenciaLiberada(AUsaLiberacaoTransferencia,
                               AVeioResumoCaixa: Boolean;
                               AChequeLiberado: String): Boolean;
Begin
  Result := True;

  If Not AUsaLiberacaoTransferencia Then
    Exit;

  If Not AVeioResumoCaixa Then
    Exit;

  Result := AChequeLiberado <> 'N';
End;

end.
