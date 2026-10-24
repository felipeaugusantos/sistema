unit untDuplicatasPedido;

interface

Uses
 DB,
 Uni,
 untFuncoesSimples,
 Math,
 SysUtils;

  function fMostraDuplicatasPedido(qrySeqCon, qryDuplic: TUniQuery; strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
  function fSQLSeqCon: String;
  Function fSomaFormasPedido(Var fltValDin, fltValCqP, fltValCqV, fltValCar, fltValOrd, fltValCre: Double;
                              arrPedidos: TarrPedVenda): Boolean;

  Procedure pRetornaFormasPedido(strNumDoc, strEspDoc, strCodEmp, strCodCli: String;
    Var fltValDin, fltValCqP, fltValCqV, fltValCar, fltValOrd, fltValCre: Double);

implementation


function fSQLSeqCon: String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   CTR_SEQCON, ';
  Result := Result + '   CTR_EMPBAI  ';
  Result := Result + ' FROM          ';
  Result := Result + '   CADREC      ';
  Result := Result + ' WHERE         ';
  Result := Result + '   CTR_NUMDUP = :NUMDOC AND ';
  Result := Result + '   CTR_ESPDOC = :ESPDOC AND ';
  Result := Result + '   CTR_CODEMP = :CODEMP AND ';
  Result := Result + '   CTR_DTAREC IS NOT NULL   ';
End;

function fSQLDuplicatasPedido(strSeqCon: String): String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   CONCAT(CTR_NUMDUP, "-", CTR_ESPDOC, "-", CTR_PARCEL) AS CTR_NUMDUP, ';
  Result := Result + '   CTR_DTAREC, ';
  Result := Result + '   CTR_VALREC, ';
  Result := Result + '   CTR_DINHEI, ';
  Result := Result + '   CTR_CHQAVI, ';
  Result := Result + '   CTR_CHQPRE, ';
  Result := Result + '   CTR_CARTAO, ';
  Result := Result + '   CTR_ORDPAG  ';
  Result := Result + ' FROM  ';
  Result := Result + '   CADREC     ';
  Result := Result + ' WHERE         ';
  Result := Result + '   CTR_NUMDUP = :NUMDOC AND ';
  Result := Result + '   CTR_ESPDOC = :ESPDOC AND ';
  Result := Result + '   CTR_CODEMP = :CODEMP AND ';
  Result := Result + '   CTR_DTAREC IS NOT NULL   ';

  If Not fEmptyStr(strSeqCon) Then
  Begin
    Result := Result + '   UNION ALL ';

    Result := Result + ' SELECT ';
    Result := Result + '   CONCAT(CTR_NUMDUP, "-", CTR_ESPDOC, "-", CTR_PARCEL) AS CTR_NUMDUP, ';
    Result := Result + '   CTR_DTAREC, ';
    Result := Result + '   CTR_VALREC, ';
    Result := Result + '   CTR_DINHEI, ';
    Result := Result + '   CTR_CHQAVI, ';
    Result := Result + '   CTR_CHQPRE, ';
    Result := Result + '   CTR_CARTAO, ';
    Result := Result + '   CTR_ORDPAG  ';
    Result := Result + ' FROM  ';
    Result := Result + '   CADREC      ';
    Result := Result + ' WHERE         ';
    Result := Result + '   (CTR_NUMDUP <> :NUMDOC OR ';
    Result := Result + '    CTR_ESPDOC <> :ESPDOC OR ';
    Result := Result + '    CTR_CODEMP <> :CODEMP) AND ';

    Result := Result + '   CTR_DTAREC IS NOT NULL AND ';
    Result := Result + '   CTR_SEQCON = :SEQCON AND   ';
    Result := Result + '   CTR_EMPBAI = :EMPBAI       ';
  End;

  Result := Result + ' ORDER BY   ';
  Result := Result + '   CTR_NUMDUP, CTR_DTAREC ';
End;

Procedure pBuscaSeqComPedido(qrySeqCon: TUniQuery; Var strSeqCom, strEmpBai: String;
                             strNumDoc, strEspDoc, strCodEmp, strCodCli: String);
Begin
  With qrySeqCon Do
  Begin
    Close;

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
//    ParamByName('CODCLI').AsString := strCodCli;

    Open;

    If IsEmpty Then
    Begin
      strSeqCom := '';
      strEmpBai := '';
    End Else
    Begin
      strSeqCom := FieldByName('CTR_SEQCON').AsString;

      If strSeqCom = '0' Then
        strSeqCom := '';

      strEmpBai := FieldByName('CTR_EMPBAI').AsString;
    End;

  End;

End;

function fMostraDuplicatasPedido(qrySeqCon, qryDuplic: TUniQuery; strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
   Var
     strSeqCon,
     strEmpBai: String;
Begin
  strSeqCon := '';
  strEmpBai := '';

  //Quando for gravacao do movmod nao deve buscar pelo seqcon, apenas pelo numero da duplicata (PD)
  If Assigned(qrySeqCon) Then
    pBuscaSeqComPedido(qrySeqCon, strSeqCon, strEmpBai, strNumDoc, strEspDoc, strCodEmp, strCodCli);

  With qryDuplic Do
  Begin

    Close;

    SQL.Text := fSQLDuplicatasPedido(strSeqCon);

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;

    If Not fEmptyStr(strSeqCon) Then
    Begin
      ParamByName('SEQCON').AsString := strSeqCon;
      ParamByName('EMPBAI').AsString := strEmpBai;
    End;

    Open;

    TFloatField(FieldByName('CTR_VALREC')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('CTR_DINHEI')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('CTR_CHQAVI')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('CTR_CHQPRE')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('CTR_CARTAO')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('CTR_ORDPAG')).DisplayFormat := '#,##0.00';

    Result := Not IsEmpty;
  End;
End;

Procedure pRetornaFormasPedido(strNumDoc, strEspDoc, strCodEmp, strCodCli: String;
            Var fltValDin, fltValCqP, fltValCqV, fltValCar, fltValOrd, fltValCre: Double);
  Var
   qryDuplic: TUniQuery;
Begin
  qryDuplic := fCriaQuery;

  If fMostraDuplicatasPedido(nil, qryDuplic, strNumDoc, strEspDoc, strCodEmp, strCodCli) Then
  With qryDuplic Do
  Begin

    First;

    While Not Eof Do
    Begin
      fltValDin := fltValDin + FieldByName('CTR_DINHEI').AsFloat;
      fltValCqP := fltValCqP + FieldByName('CTR_CHQPRE').AsFloat;
      fltValCqV := fltValCqV + FieldByName('CTR_CHQAVI').AsFloat;
      fltValCar := fltValCar + FieldByName('CTR_CARTAO').AsFloat;
      fltValOrd := fltValOrd + FieldByName('CTR_ORDPAG').AsFloat;

      If FieldByName('CTR_VALREC').AsFloat < 0 Then
      Begin
        fltValCre := fltValCre + Abs(FieldByName('CTR_VALREC').AsFloat);
      End;

      Next;
    End;

  End;

  FreeAndNil(qryDuplic);
End;

Function fSomaFormasPedido(Var fltValDin, fltValCqP, fltValCqV, fltValCar, fltValOrd, fltValCre: Double;
  arrPedidos: TarrPedVenda): Boolean;
  Var
    intContador: Integer;
Begin
  fltValDin := 0;
  fltValCqP := 0;
  fltValCqV := 0;
  fltValCar := 0;
  fltValOrd := 0;
  fltValCre := 0;

  For intContador := Low(arrPedidos) To High(arrPedidos) Do
    With arrPedidos[intContador] Do
    pRetornaFormasPedido(strNumPed, strEspPed, strEmpPed, '',
       fltValDin, fltValCqP, fltValCqV, fltValCar, fltValOrd, fltValCre);

  Result := fltValDin + fltValCqP + fltValCqV + fltValCar + fltValOrd + fltValCre <> 0;

End;

end.
