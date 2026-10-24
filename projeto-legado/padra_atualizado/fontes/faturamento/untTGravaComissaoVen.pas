unit untTGravaComissaoVen;

interface

uses SysUtils, Classes, StrUtils, Uni, DateUtils;

Type
  TTipoComissaoDup = (tcdCadRec, tcdCadCHQ, tcdMovCAR);

  TComissaoDup = Record
    tcdTipCom: TTipoComissaoDup;
    strNumDup,
    strEspDoc,
    strParcel,
    strCodEmp,
    strCodCli,
    strCodVen,
    strTabela,
    strTabelaUpdate,
    strAutInc,
    strNumDupAgr,
    strEspDocAgr,
    strParcelAgr,
    strCodEmpAgr,
    strCodCliAgr: String;
    fltValCom: Double;
    intSeqBai: Integer;
  End;

  TComissaoVen = Record
    strCodVen: String;
    fltValCom: Double;
  End;

  TGravaComissaoVen = Class
   private
     FDuplicatas: Array Of TComissaoDup;
     FComissao: Array Of TComissaoVen;
     FErros: TStringList;

     FQryOpe,
     FQryDiv,
     FQryExec: TUniQuery;

     FDtaVen: TDateTime;
     FCodCta,
     FCodPor: String;
     FComProf: Boolean;

     function fCodFor(strCodOpe: String): String;
     function fCodForProf(strCodProf: String): String;
     function fGravaCTP(strCodFor, strCTPCom: String; fltValCom: Double): Boolean;
     function fAtualizaCTPCom(strCodVen, strCTPCom: String): Boolean;
     function fExibeErros: Boolean;

     procedure pAddCom(strCodVen: String; fltValCom: Double);
     procedure pExecSQL(strSQL: String; arrParam: Array Of String);

     procedure InserirRegistroAGRCOM(ADuplicatasAgrupadas: TComissaoDup;
                                     ACTPCom: String);
   public
     constructor Create;
     destructor Destroy; override;

     procedure pSetDtaVen(dtaDtaVen: TDateTime);
     procedure pSetCodCta(strCodCta: String);
     procedure pSetCodPor(strCodPor: String);

     procedure pAddDup(strNumDup, ADuplicataAgrupada, strCodCli, strCodVen, strTabela, ATabelaUpdate: String; fltValCom: Double; ASeqBai: Integer = 0);
     procedure pAddChq(strAutInc, strCodVen, strTabela: String; fltValCom: Double);
     procedure pAddCar(strAutInc, strCodVen: String; fltValCom: Double);

     function fGravaComissao: Boolean;

     property blnComProf: Boolean Read FComProf Write FComProf;
  End;

implementation

uses untFuncoesSimples, untMemo, untCadPag;

{ TGravaComissaoVen }

constructor TGravaComissaoVen.Create;
begin
  FErros := TStringList.Create;

  FQryOpe := fCriaQuery;
  FQryOpe.SQL.Text := 'SELECT * FROM CADOPE';

  FQryDiv := fCriaQuery;
  FQryDiv.SQL.Text := 'SELECT * FROM CADDIV';

  FQryExec := fCriaQuery;
  FComProf := False;
end;

destructor TGravaComissaoVen.Destroy;
begin
  SetLength(FDuplicatas, 0);
  FErros.Free;

  FQryOpe.Free;
  FQryDiv.Free;
  FQryExec.Free;

  inherited;
end;

function TGravaComissaoVen.fAtualizaCTPCom(strCodVen, strCTPCom: String): Boolean;
  Var
    comDup: TComissaoDup;
  Const
    strSQLCadRec = 'UPDATE %S '
                 + '   SET CTR_CTPCOM = :CTPCOM '
                 + ' WHERE CTR_CODEMP = :CODEMP '
                 + '   AND CTR_NUMDUP = :NUMDUP '
                 + '   AND CTR_ESPDOC = :ESPDOC '
                 + '   AND CTR_PARCEL = :PARCEL '
                 + '   AND CTR_CODCLI = :CODCLI '
                 + '   AND CTR_DTAREC IS NOT NULL '
                 + '   AND CTR_CTPCOM IS NULL ';

    strSQLCadRecProf = 'UPDATE %S '
                     + '   SET CTR_CTPCOP = :CTPCOM '
                     + ' WHERE CTR_CODEMP = :CODEMP '
                     + '   AND CTR_NUMDUP = :NUMDUP '
                     + '   AND CTR_ESPDOC = :ESPDOC '
                     + '   AND CTR_PARCEL = :PARCEL '
                     + '   AND CTR_CODCLI = :CODCLI ';

    strSQLCadChq = 'UPDATE %S '
                 + '   SET CHQ_CTPCOM = :CTPCOM '
                 + ' WHERE AUTOINCREM = :AUTINC ';

    strSQLMovCAR = 'UPDATE MOVCAR '
                 + '   SET MCA_CTPCOM = :CTPCOM '
                 + ' WHERE AUTOINCREM = :AUTCIN ';
begin
  For comDup In FDuplicatas Do
  Begin
    If comDup.strCodVen = strCodVen Then
    Begin
      Case comDup.tcdTipCom Of
        tcdCadRec: Begin
                     If (Not FComProf) Then
                     Begin
                       If comDup.strTabelaUpdate <> 'DUPAGR' Then
                         pExecSQL(Format(strSQLCadRec, [comDup.strTabelaUpdate]), [strCTPCom,
                                                                                   comDup.strCodEmp,
                                                                                   comDup.strNumDup,
                                                                                   comDup.strEspDoc,
                                                                                   comDup.strParcel,
                                                                                   comDup.strCodCli])
                       Else
                         InserirRegistroAGRCOM(comDup, strCTPCom);
                     End
                     Else
                       pExecSQL(Format(strSQLCadRecProf, [comDup.strTabela]), [strCTPCom,
                                                                               comDup.strCodEmp,
                                                                               comDup.strNumDup,
                                                                               comDup.strEspDoc,
                                                                               comDup.strParcel,
                                                                               comDup.strCodCli]);
                   End;
        tcdCadCHQ: pExecSQL(Format(strSQLCadChq, [comDup.strTabela]), [strCTPCom,
                                                                 comDup.strAutInc]);

        tcdMovCAR: pExecSQL(strSQLMovCAR, [strCTPCom,
                                           comDup.strAutInc]);
      End;

    End;
  End;

  Result := True;
end;

function TGravaComissaoVen.fCodFor(strCodOpe: String): String;
begin
  If Not FQryOpe.Active Then
    FQryOpe.Open;

  Result := '';

  If FQryOpe.Locate('OPE_CODOPE', strCodOpe, []) Then
    Result := FQryOpe.FieldByName('OPE_CODFOR').AsString
  Else
    Raise Exception.Create('Operador "'+ strCodOpe +'" não localizado!');
end;

function TGravaComissaoVen.fCodForProf(strCodProf: String): String;
begin
  If Not FQryDiv.Active Then
    FQryDiv.Open;

  Result := '';

  If FQryDiv.Locate('DIV_CODDIV', strCodProf, []) Then
    Result := FQryDiv.FieldByName('DIV_CODFOR').AsString
  Else
    Raise Exception.Create('Profissional "'+ strCodProf +'" não localizado!');
end;

function TGravaComissaoVen.fGravaComissao: Boolean;
  Var
    comVen: TComissaoVen;
    strCodFor,
    strCTPCom: String;
begin
  Try
    fStartTransaction;

    For comVen In FComissao Do
    Begin
      If (Not FComProf) Then
        strCodFor := fCodFor(comVen.strCodVen)
      Else
        strCodFor := fCodForProf(comVen.strCodVen);

      If fEmptyStr(strCodFor) Then
      Begin
        FErros.Add('Operador "'+ comVen.strCodVen +'" não possui fornecedor vinculado!');
        Continue;
      End;

      strCTPCom := VS_strCodEmp + fRetSequencial('PROCTP');

      Try

        If Not fGravaCTP(strCodFor, strCTPCom, comVen.fltValCom) Then
        Begin
          FErros.Add('Falha ao inserir conta a pagar para o operador "'+comVen.strCodVen+'"');
          Continue;
        End;

        If Not fAtualizaCTPCom(comVen.strCodVen, strCTPCom) Then
        Begin
          FErros.Add('Falha atualizando contas a receber do operador "'+comVen.strCodVen+'"');
          Continue;
        End;
      Except
        On E:Exception Do
          FErros.Add('Falha: ' + E.Message);
      End;
    End;

  Finally
    Result := Not fExibeErros;

    If Result Then
      fCommit
    Else
      fRollback;
  End;
end;

function TGravaComissaoVen.fGravaCTP(strCodFor, strCTPCom: String; fltValCom: Double): Boolean;
  Var
    strNumDupPag: String;
  Const
    C_PARCEL = 'A';
begin
  strNumDupPag := fRetSequencialCadPag;

  Result := fGravaCadPag('untTGravaComissaoVen - fGravaCTP',
                         'INCLUSAO  untTGravaComissaoVen',
                         strCodFor,
                         strNumDupPag,
                         C_PARCEL,
                         VS_strCodEmp,
                         FCodCta,
                         fCfgSis('SERFSC'),
                         0,
                         VS_Date,
                         FDtaVen,
                         fltValCom,
                         fltValCom,
                         'N',
                         'N',
                         'N',
                         'REF. A COMISSÃO DE VENDEDOR',
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         0,
                         0,
                         0,
                         0,
                         '',
                         '',
                         'N',
                         FCodPor,
                         '',
                         0,
                         0,
                         0,
                         False,
                         0,
                         '',
                         0,
                         'N',
                         '',
                         '',
                         strCTPCom,
                         '',
                         '',
                         '',
                         '',
                         '',
                         'N',
                         '',
                         '',
                         '',
                         '',
                         '',
                         0,
                         0,
                         0,
                         0,
                         '',
                         0,
                         0,
                         '',
                         '',
                         '',
                         '',
                         '',
                         '0',
                         '',
                         '',
                         '',
                         '', 
                         'N');
end;

procedure TGravaComissaoVen.InserirRegistroAGRCOM(ADuplicatasAgrupadas: TComissaoDup;
  ACTPCom: String);
  Var
    LInserir: TUniQuery;
begin
  LInserir := fCriaQuery;

  Try
    LInserir.SQL.Text := 'SELECT * FROM AGRCOM WHERE FALSE';
    LInserir.Open;

    LInserir.Append;
    LInserir.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('AGRCOM', VS_strCodEmp);
    LInserir.FieldByName('COM_NUMAGR').AsString := ADuplicatasAgrupadas.strNumDup;
    LInserir.FieldByName('COM_EMPAGR').AsString := ADuplicatasAgrupadas.strCodEmp;
    LInserir.FieldByName('COM_PARAGR').AsString := ADuplicatasAgrupadas.strParcel;
    LInserir.FieldByName('COM_CHADUP').AsString := Concat(ADuplicatasAgrupadas.strNumDupAgr, '-',
                                                          ADuplicatasAgrupadas.strParcelAgr, '-',
                                                          ADuplicatasAgrupadas.strEspDocAgr, '-',
                                                          ADuplicatasAgrupadas.strCodEmpAgr);
    LInserir.FieldByName('COM_CTPCOM').AsString := ACTPCom;
    LInserir.FieldByName('COM_CODCLI').AsString := ADuplicatasAgrupadas.strCodCli;
    LInserir.FieldByName('COM_SEQBAI').AsInteger := ADuplicatasAgrupadas.intSeqBai;
    LInserir.Post;
  Finally
    FreeAndNil(LInserir);
  End;
end;

procedure TGravaComissaoVen.pAddCar(strAutInc, strCodVen: String; fltValCom: Double);
begin
  SetLength(FDuplicatas, Length(FDuplicatas) + 1);

  FDuplicatas[High(FDuplicatas)].tcdTipCom := tcdMovCAR;
  FDuplicatas[High(FDuplicatas)].strAutInc := strAutInc;
  FDuplicatas[High(FDuplicatas)].strCodVen := strCodVen;

  pAddCom(strCodVen, fltValCom);
end;

procedure TGravaComissaoVen.pAddChq(strAutInc, strCodVen, strTabela: String; fltValCom: Double);
begin
  SetLength(FDuplicatas, Length(FDuplicatas) + 1);

  FDuplicatas[High(FDuplicatas)].tcdTipCom := tcdCadCHQ;
  FDuplicatas[High(FDuplicatas)].strAutInc := strAutInc;
  FDuplicatas[High(FDuplicatas)].strCodVen := strCodVen;
  FDuplicatas[High(FDuplicatas)].strTabela := strTabela;

  pAddCom(strCodVen, fltValCom);
end;

procedure TGravaComissaoVen.pAddCom(strCodVen: String; fltValCom: Double);
  Var
    intCom: Integer;
    blnAtu: Boolean;
begin
  blnAtu := false;

  For intCom := 0 To Length(FComissao) -1 Do
  Begin
    If FComissao[intCom].strCodVen = strCodVen Then
    Begin
      FComissao[intCom].fltValCom := FComissao[intCom].fltValCom + fltValCom;
      blnAtu := True;
      Break;
    End;
  End;

  If Not blnAtu Then
  Begin
    SetLength(FComissao, Length(FComissao) + 1);
    FComissao[High(FComissao)].strCodVen := strCodVen;
    FComissao[High(FComissao)].fltValCom := fltValCom;
  End;
end;

procedure TGravaComissaoVen.pAddDup(strNumDup, ADuplicataAgrupada, strCodCli, strCodVen, strTabela, ATabelaUpdate: String; fltValCom: Double; ASeqBai: Integer = 0);
begin
  SetLength(FDuplicatas, Length(FDuplicatas) + 1);

  // 000000252583-A-NF-025-0
  // DDDDDDDDDDDD-P-SS-EEE-S
  //
  // D = NumDup
  // P = Parcel
  // S = EspDoc
  // E = CodEmp
  // S = Seq


  FDuplicatas[High(FDuplicatas)].strNumDup := LeftStr(strNumDup, Pos('-', strNumDup) -1);
  System.Delete(strNumDup, 1, Pos('-', strNumDup));

  FDuplicatas[High(FDuplicatas)].strParcel := MidStr(strNumDup, 1, Pos('-', strNumDup) -1);
  System.Delete(strNumDup, 1, Pos('-', strNumDup));

  FDuplicatas[High(FDuplicatas)].strEspDoc := MidStr(strNumDup, 1, Pos('-', strNumDup) -1);
  System.Delete(strNumDup, 1, Pos('-', strNumDup));

  FDuplicatas[High(FDuplicatas)].strCodEmp := RightStr(strNumDup, 3);

  FDuplicatas[High(FDuplicatas)].tcdTipCom := tcdCadRec;
  FDuplicatas[High(FDuplicatas)].strCodCli := strCodCli;
  FDuplicatas[High(FDuplicatas)].strCodVen := strCodVen;
  FDuplicatas[High(FDuplicatas)].strTabela := strTabela;
  FDuplicatas[High(FDuplicatas)].strTabelaUpdate := ATabelaUpdate;
  FDuplicatas[High(FDuplicatas)].fltValCom := fltValCom;
  FDuplicatas[High(FDuplicatas)].intSeqBai := ASeqBai;


  If Not ADuplicataAgrupada.IsEmpty Then
  Begin
    FDuplicatas[High(FDuplicatas)].strNumDupAgr := LeftStr(ADuplicataAgrupada, Pos('-', ADuplicataAgrupada) -1);
    System.Delete(ADuplicataAgrupada, 1, Pos('-', ADuplicataAgrupada));

    FDuplicatas[High(FDuplicatas)].strParcelAgr := MidStr(ADuplicataAgrupada, 1, Pos('-', ADuplicataAgrupada) -1);
    System.Delete(ADuplicataAgrupada, 1, Pos('-', ADuplicataAgrupada));

    FDuplicatas[High(FDuplicatas)].strEspDocAgr := MidStr(ADuplicataAgrupada, 1, Pos('-', ADuplicataAgrupada) -1);
    System.Delete(ADuplicataAgrupada, 1, Pos('-', ADuplicataAgrupada));

    FDuplicatas[High(FDuplicatas)].strCodEmpAgr := RightStr(ADuplicataAgrupada, 3);

    FDuplicatas[High(FDuplicatas)].strCodCliAgr := strCodCli;
  End;

  pAddCom(strCodVen, fltValCom);
end;

procedure TGravaComissaoVen.pExecSQL(strSQL: String; arrParam: array of String);
  Var
    intParam: Integer;
begin
  FQryExec.SQL.Text := strSQL;

  Try
    For intParam := 0 To Length(arrParam) -1 Do
      FQryExec.Params[intParam].AsString := arrParam[intParam];
  Except
    FErros.Add('Número errado de parâmetros em [pExecSQL]');
  End;

  Try
    FQryExec.ExecSQL;
  Except
    FErros.Add('Falha ao executar SQL [pExecSQL]');
  End;
end;

function TGravaComissaoVen.fExibeErros: Boolean;
begin
  Result := False;
  
  If FErros.Count = 0 Then
    Exit;

  FErros.Add('** CONTAS A PAGAR NÃO FORAM GERADAS **');

  TfrmMemo.pShowMessage(FErros);
  
  Result := True;
end;

procedure TGravaComissaoVen.pSetCodCta(strCodCta: String);
begin
  FCodCta := strCodCta;
end;

procedure TGravaComissaoVen.pSetCodPor(strCodPor: String);
begin
  FCodPor := strCodPor;
end;

procedure TGravaComissaoVen.pSetDtaVen(dtaDtaVen: TDateTime);
begin
  FDtaVen := dtaDtaVen;
end;

end.
