unit untTMontaSQLPedidoCompra;

interface

uses System.SysUtils, StrUtils, Classes, Data.DB, Uni;



Type
  TMontaSQLPedidoCompra = Class
  private
    FCampos: TStringList;
    FValues: TStringLIst;
    strSQL: String;
    FstrTabela: String;
    FblnInsere: Boolean;

    Class Function fInsertControleDeColeta(Var intQtdConCol: Integer;
                                     strNumPed,
                                     strCodEmp,
                                     strEspDoc,
                                     strEmpDes: String;
                                     intNumCtn: Integer;
                                     strCodIte,
                                     strAutIncPcd,
                                     strSeqReq: String): String;

  public
    blnReplaceInto: Boolean;

    Constructor Create(strTabela: String; blnInsere: Boolean);
    Destructor Destroy; override;

    Procedure pAdicionaCampo(strNomCam,  Value: Variant; FieldType: TFieldType; blnUltimo: Boolean = False);

    procedure pAdicionaString(strNomCam, Value: String; blnUltimo: Boolean = False);

    function  fSQLInsert: string;
    function  fSQLUpdate: string;
    procedure pReiniciar(strTabela: String; blnInsere: Boolean);

    Class Function fSQLInsertColeta(Var intQtdConCol: Integer;
                                    qryColeta: TUniQuery;
                                    strNumPed,
                                    strCodEmp,
                                    strEspDoc,
                                    strEmpDes: String;
                                    intNumCtn: Integer;
                                    strCodIte,
                                    strAutIncPcd,
                                    strSeqReq: String): String;

     Class Function fInsertControleDeColetaRequisicao(Var intQtdConCol: Integer;
                                                      qryColeta: TUniQuery;
                                                      strNumPed,
                                                      strCodEmp,
                                                      strEspDoc,
                                                      strEmpDes: String;
                                                      intNumCtn: Integer;
                                                      strCodIte,
                                                      strAutIncPcd,
                                                      strAutIncIRQ_comma: String): String;

     Class Function fAjustaAutoIncControleDeColeta(Var intQtdConCol: Integer; strSQL: String): String;

     Class Function fRemoveControleDeColeta(strAutPcd, strAutReq: String): String;

     Class Function fCarregaControleDeColeta(strNumPed,
                                             strEspPed,
                                             strCodEmp: String;
                                             intNumCtn: Integer;
                                             qryColeta: TUniQuery): Boolean;
end;

implementation

{ TMontaSQLPedidoCompra }

Uses
  Variants,
  untFuncoesSimples;

constructor TMontaSQLPedidoCompra.Create(strTabela: String; blnInsere: Boolean);
begin
  FCampos := TStringList.Create;
  FValues := TStringList.Create;
  FstrTabela := strTabela;
  FblnInsere := blnInsere;
  blnReplaceInto := False;
end;

destructor TMontaSQLPedidoCompra.Destroy;
begin
  FreeAndNil(FCampos);
  FreeAndNil(FValues);
end;

procedure TMontaSQLPedidoCompra.pAdicionaCampo(strNomCam, Value: Variant; FieldType: TFieldType; blnUltimo: Boolean);
  var strValorTratado: string;
begin
  FCampos.Add(strNomCam);

  Case FieldType Of
    ftDate:
    Begin
      If (FormatDateTime('YYYY-MM-DD', Value) = '1899-12-30') Or
         (FormatDateTime('YYYY-MM-DD', Value) = '0000-00-00') Then
        strValorTratado:= 'NULL'
      Else
        strValorTratado := QuotedStr(FormatDateTime('YYYY-MM-DD', Value));
    End;
    ftDateTime:
    Begin
      If (FormatDateTime('YYYY-MM-DD hh:mm:ss', Value) = '1899-12-30 00:00:00') Or
         (FormatDateTime('YYYY-MM-DD hh:mm:ss', Value) = '0000-00-00 00:00:00') Then
        strValorTratado := 'NULL'
      Else
        strValorTratado := QuotedStr(FormatDateTime('YYYY-MM-DD hh:mm:ss', Value));
    End;

    ftFloat:   strValorTratado :=  ReplaceStr(Value, ',', '.');
    ftInteger: strValorTratado :=  Value;
    ftString : Begin
                 If Value = '' Then
                   strValorTratado := 'NULL'
                 Else
                   strValorTratado := QuotedStr(Value);
                 End;
  End;
  FValues.Add(strValorTratado);

  If FblnInsere Then
    strSQL := strSQL + '  ' + strNomCam
  Else
    strSQL := strSQL + '  ' + strNomCam + ' = ' + strValorTratado;

  If blnUltimo Then
    strSQL := strSQL + '  '
  Else
    strSQL := strSQL + ', ';
end;

procedure TMontaSQLPedidoCompra.pAdicionaString(strNomCam, Value: String; blnUltimo: Boolean = False);
  var strValorTratado: string;
begin
//  If fEmptyStr(Value) Then
//    Raise Exception.Create('Descrição do produto em branco!');

  FCampos.Add(strNomCam);

  strValorTratado := QuotedStr(Value);

  FValues.Add(strValorTratado);

  If FblnInsere Then
    strSQL := strSQL + '  ' + strNomCam
  Else
    strSQL := strSQL + '  ' + strNomCam + ' = ' + strValorTratado;

  If blnUltimo Then
    strSQL := strSQL + '  '
  Else
    strSQL := strSQL + ', ';
end;

procedure TMontaSQLPedidoCompra.pReiniciar(strTabela: String;
  blnInsere: Boolean);
begin
  FCampos.Clear;
  FValues.Clear;
  FstrTabela := strTabela;
  FblnInsere := blnInsere;
end;

function TMontaSQLPedidoCompra.fSQLInsert: string;
  Var
    intContador: Integer;
begin
  Result := '';
  If blnReplaceInto Then
    Result := Result + ' REPLACE INTO ' + FstrTabela + ' ('
  Else
    Result := Result + ' INSERT INTO ' + FstrTabela + ' (';

  Result := Result + strSQL + ') VALUES ( ';
  Result := Result + FValues[0];

  For intContador := 1 To FCampos.Count - 1 Do
    Result := Result + ', ' + FValues[intContador];

  Result := Result + ')';
end;

function TMontaSQLPedidoCompra.fSQLUpdate: string;
begin
  Result  := '';
  Result := Result + ' UPDATE ' + FstrTabela + ' SET ';
  Result := Result + strSQL;
end;

Class Function TMontaSQLPedidoCompra.fInsertControleDeColeta(Var intQtdConCol: Integer;
                                                             strNumPed,
                                                             strCodEmp,
                                                             strEspDoc,
                                                             strEmpDes: String;
                                                             intNumCtn: Integer;
                                                             strCodIte,
                                                             strAutIncPcd,
                                                             strSeqReq: String): String;
  Var
    strSQL: String;
begin
  Inc(intQtdConCol);

  If strEmpDes.IsEmpty Then
    strEmpDes := strCodEmp;

  strSQL := '';
  strSQL := strSQL + ' INSERT INTO CONCOL (';
  strSQL := strSQL + '   AUTOINCREM, ';
  strSQL := strSQL + '   CON_AUTDET, ';
  strSQL := strSQL + '   CON_NUMPED, ';
  strSQL := strSQL + '   CON_ESPDOC, ';
  strSQL := strSQL + '   CON_CODEMP, ';
  strSQL := strSQL + '   CON_EMPDES, ';
  strSQL := strSQL + '   CON_NUMCTN, ';
  strSQL := strSQL + '   CON_CODITE, ';
  strSQL := strSQL + '   CON_AUTREQ, ';
  strSQL := strSQL + '   CON_ULTALT, ';
  strSQL := strSQL + '   CON_HORALT, ';
  strSQL := strSQL + '   CON_CODOPE, ';
  strSQL := strSQL + '   CON_BAIXAD) VALUES (';

  strSQL := strSQL + '   AUTOINCREM_CONCOL_' + intQtdConCol.ToString + ', ';

  strSQL := strSQL + QuotedStr(strAutIncPcd) + ', ';
  strSQL := strSQL + QuotedStr(strNumPed)    + ', ';
  strSQL := strSQL + QuotedStr(strEspDoc)    + ', ';
  strSQL := strSQL + QuotedStr(strCodEmp)    + ', ';
  strSQL := strSQL + QuotedStr(strEmpDes)    + ', ';
  strSQL := strSQL + intNumCtn.ToString      + ', ';
  strSQL := strSQL + QuotedStr(strCodIte)    + ', ';

  If strSeqReq.IsEmpty Then
    strSQL := strSQL + ' NULL, '
  Else
    strSQL := strSQL + QuotedStr(strSeqReq)    + ', ';

  strSQL := strSQL + '   CURDATE(), ';
  strSQL := strSQL + '   CURTIME(), ';
  strSQL := strSQL + QuotedStr(strLoginUsuarioLogado) + ', ';
  strSQL := strSQL + '   "N"); ';

  Result := strSQL;
End;

Class Function TMontaSQLPedidoCompra.fSQLInsertColeta(Var intQtdConCol: Integer;
                                                      qryColeta: TUniQuery;
                                                      strNumPed,
                                                      strCodEmp,
                                                      strEspDoc,
                                                      strEmpDes: String;
                                                      intNumCtn: Integer;
                                                      strCodIte,
                                                      strAutIncPcd,
                                                      strSeqReq: String): String;
Begin
  If (Not Assigned(qryColeta)) Or
     (Not qryColeta.Active) Or
     (Not qryColeta.FindKey([strAutIncPcd, IIF(strSeqReq.IsEmpty, Null, strSeqReq)])) Then
    Result := fInsertControleDeColeta(intQtdConCol,
                                      strNumPed,
                                      strCodEmp,
                                      strEspDoc,
                                      strEmpDes,
                                      intNumCtn,
                                      strCodIte,
                                      strAutIncPcd,
                                      strSeqReq)
  Else
    Result := '';
End;

Class Function TMontaSQLPedidoCompra.fInsertControleDeColetaRequisicao(Var intQtdConCol: Integer;
                                                                       qryColeta: TUniQuery;
                                                                       strNumPed,
                                                                       strCodEmp,
                                                                       strEspDoc,
                                                                       strEmpDes: String;
                                                                       intNumCtn: Integer;
                                                                       strCodIte,
                                                                       strAutIncPcd,
                                                                       strAutIncIRQ_comma: String): String;
  Var
    stlAutIncIRQ: TStringList;
    strSeqReq: String;
Begin
  Result := '';
  stlAutIncIRQ := TStringList.Create;
  stlAutIncIRQ.CommaText := strAutIncIRQ_comma;

  For strSeqReq In stlAutIncIRQ Do
    Result := Result + fSQLInsertColeta(intQtdConCol,
                                        qryColeta,
                                        strNumPed,
                                        strCodEmp,
                                        strEspDoc,
                                        strEmpDes,
                                        intNumCtn,
                                        strCodIte,
                                        strAutIncPcd,
                                        strSeqReq);

  FreeAndNil(stlAutIncIRQ);
End;

Class Function TMontaSQLPedidoCompra.fAjustaAutoIncControleDeColeta(Var intQtdConCol: Integer; strSQL: String): String;
  Var
    intContador: Integer;
    strAutInc: String;
Begin
  Result := strSQL;

  If intQtdConCol > 0 Then
  Begin
    strAutInc := fRetAutoIncrem('CONCOL', VS_strCodEmp, intQtdConCol);

    For intContador := intQtdConCol downto 1 Do
    Begin
      Result := AnsiReplaceStr(Result, 'AUTOINCREM_CONCOL_' + intContador.ToString, QuotedStr(strAutInc));
      strAutInc := fNextAutoIncrem(strAutInc);
    End;

    intQtdConCol := 0;
  End;
End;

Class Function TMontaSQLPedidoCompra.fRemoveControleDeColeta(strAutPcd, strAutReq: String): String;
Begin
  Result := ' DELETE FROM CONCOL WHERE CON_AUTDET = ' + QuotedStr(strAutPcd) + ' AND CON_AUTREQ = ' +  QuotedStr(strAutReq) + '; ';
End;

Class Function TMontaSQLPedidoCompra.fCarregaControleDeColeta(strNumPed,
                                                              strEspPed,
                                                              strCodEmp: String;
                                                              intNumCtn: Integer;
                                                              qryColeta: TUniQuery): Boolean;
Begin
  Try
    qryColeta.SQL.Text := 'SELECT * FROM CONCOL WHERE CON_CODEMP = :CODEMP AND CON_NUMPED = :NUMPED AND CON_ESPDOC = :ESPDOC AND CON_NUMCTN = :NUMCTN';
    qryColeta.ParamByName('NUMPED').AsString  := strNumPed;
    qryColeta.ParamByName('CODEMP').AsString  := strCodEmp;
    qryColeta.ParamByName('ESPDOC').AsString  := strEspPed;
    qryColeta.ParamByName('NUMCTN').AsInteger := intNumCtn;
    qryColeta.IndexFieldNames := 'CON_AUTDET;CON_AUTREQ';
    qryColeta.KeyFields := 'CON_AUTDET;CON_AUTREQ';

    qryColeta.Open;
    qryColeta.First;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TMontaSQLPedidoCompra.fCarregaControleDeColeta');
    End;
  End;
End;


end.


