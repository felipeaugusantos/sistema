unit untProximoCodigo;

interface

uses untConnection, untQuery, untFuncoesSimples;

function fAtualizaProCodGenerica(const objConnection: IConnection; const strNomeTabela, strCampoBusca: String; const strTabelaBusca : String = ''; const intQtdCod: Integer = 1; const objFncFmt : TFcnFormataProCod = Nil): String;
function fProximoCodigoFormatado(const blnCodPorEmpresa : Boolean; const intCodigoAtual : Int64; const intQtdCod, intTamCodigo : Integer) : String;
procedure pCadastrarProcodProinc(Var qryProcod : IQuery; Const strSQL, strNomeTabela : String);
function fGetProximoCodigoEmTransacaoFireDac(const strTabela: String; const strCampoBusca : String; const strTabelaBusca : String = ''; const objFncFmt : TFcnFormataProCod = Nil): String;
function fGetProximoCodigoEmTransacaoUniDac(const strTabela : String; const strCampoBusca : String; const strTabelaBusca : String = ''; const objFncFmt : TFcnFormataProCod = Nil): String;
function fGetProximoCodigoEmTransacao(const strTabela : String; const strCampoBusca : String; const strTabelaBusca : String = ''; const objFncFmt : TFcnFormataProCod = Nil): String;
function fUsaFireDacComoConexao(const strTabela: String): Boolean;
function fFieldExists(const strFieldName : String; qryDataSet : IQuery) : Boolean;
procedure pValidaProCodFireDac(const strNomeTabela: String);
Function fRetEmpresaFisicaFireDac(const AConn: IConnection): String;
function fRetAutoIncremFireDac(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1; blnForcaValidaExistencia: Boolean = True): String;
procedure pValidarProximoCodigo(Var intCodigoAtual : Int64; const intTamCodigo : Integer; const blnCodPorEmpresa : Boolean; const intQtdCod : Integer; const strCampoBusca, strTabelaBusca : String; const objConnection : IConnection; const objFncFmt : TFcnFormataProCod);
function fExisteRegistroProcod(const objConnection : IConnection; const strCampoBusca, strTabelaBusca : String; const intCodigoAtual : Int64; const blnCodPorEmpresa : Boolean; const intTamCodigo, intQtdCod : Integer; const objFncFmt : TFcnFormataProCod) : Boolean;

var
  VS_EmpresaFisica: string ;

implementation

uses System.SysUtils, untFireDac, untModulo, Variants, System.DateUtils;

function fFormataAutIncFireDac(const AConn: IConnection; intAutInc: Int64; strCodEmp: String; strProEmp: String = ''): String;
begin
  If fEmptyStr(strProEmp) Then
    strProEmp := fRetEmpresaFisicaFireDac(AConn);

  Result := strProEmp + fPadL(IntToStr(intAutInc) + strCodEmp, 17, '0');
end;

function fRetAutoIncremFireDac(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1; blnForcaValidaExistencia: Boolean = True): String;
  Var
    intAutIncAtu: Int64;

    strSQL,
    strProEmp: String;
    qryGenCod: IQuery;
    objFireDacConnection: IConnection;
    strEmpresaFisica: String;
    intTentativas: Integer ;

    function fFaixaReservadaEmLista(const intInicio, intQtd: Integer): String;
      Var
        intSeq: Integer;
    begin
      Result := '';
      For intSeq := intInicio To (intInicio + intQtd - 1) Do
      Begin
        If (Not fEmptyStr(Result)) Then
          Result := Result + ', ';
        Result := Result + QuotedStr(fFormataAutIncFireDac(objFireDacConnection, intAutIncAtu + intSeq, strCodEmp, strProEmp));
      End;
    end;

    function fAutoIncremCadastrado: Boolean;
      Const
        INT_TAM_BLOCO = 50;
      Var
        qryGenTmp : IQuery;
        intIni,
        intQtd: Integer;
    begin
      Result := False;
      qryGenTmp := objFireDacConnection.NewQuery(20000);

      If (intIntervalo <= 1) Then
      Begin
        With qryGenTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT SQL_NO_CACHE AUTOINCREM '+
                  '  FROM ' + strNomeTabela +
                  ' WHERE AUTOINCREM = :AUTINC LIMIT 1');
          ParamByName('AUTINC').AsString := fFormataAutIncFireDac(objFireDacConnection, intAutIncAtu, strCodEmp, strProEmp);
          Open;
          Result := (Not IsEmpty);
          Close;
        End;

        Exit;
      End;

      intIni := 0;

      While (intIni < intIntervalo) And (Not Result) Do
      Begin
        intQtd := INT_TAM_BLOCO;
        If (intQtd > (intIntervalo - intIni)) Then
          intQtd := intIntervalo - intIni;

        With qryGenTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT SQL_NO_CACHE AUTOINCREM '+
                  '  FROM ' + strNomeTabela +
                  ' WHERE AUTOINCREM IN (' + fFaixaReservadaEmLista(intIni, intQtd) + ') LIMIT 1');
          Open;
          Result := (Not IsEmpty);
          Close;
        End;

        intIni := intIni + intQtd;
      End;

    end;

    function fGetUltAutIncPROCOD: Int64;
      Var
        strTmp: String;
        qryTmp: IQuery;
    Begin
      Result := 0;

      strTmp := '';
      strTmp := strTmp + ' SELECT ';
      strTmp := strTmp + '   MAX(MID(AUTOINCREM, 4, 14)) AUTINC ';
      strTmp := strTmp + ' FROM ';
      strTmp := strTmp + '   PROCOD ';
      strTmp := strTmp + ' WHERE ';
      strTmp := strTmp + '   PRO_CODEMP = "' + VS_strCodEmp + '" ';

      Try
        qryTmp := objFireDacConnection.NewQuery(20000);

        With qryTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strTmp);
          Open;

          If Not IsEmpty Then
            Result := FieldByName('AUTINC').AsLargeInt
          Else
            Result := 1;
        End;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[fGetUltAutIncPROCOD]');
      End;

    End;
begin

  intTentativas := 1 ;
  objFireDacConnection := TFireDacConnection.Create(fGetParametrosDaConexao, True);
  try
    objFireDacConnection.AfterStartTransaction := pLogStartFireDac ;
    objFireDacConnection.AfterCommit := pLogCommitFireDac ;
    objFireDacConnection.AfterRollback := pLogRollbackFireDac ;
    objFireDacConnection.Connect;

    strEmpresaFisica := fRetEmpresaFisicaFireDac(objFireDacConnection);

    qryGenCod := objFireDacConnection.NewQuery(20000);
    Repeat
      objFireDacConnection.StartTransaction;
      Try
        strSQL := '';
        strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
        strSQL := strSQL + '  PRO_AUTINC AS AUTINC  ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  PROINC ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';
        strSQL := strSQL + ' FOR UPDATE ';

        With qryGenCod Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('NOMARQ').AsString := strNomeTabela;
          Open;
          If IsEmpty Then
          Begin
            If SameText(strNomeTabela, 'PROCOD') Then
            Begin
              Close;
              SQL.Clear;
              SQL.Add(' SELECT * FROM PROCOD');
              Open;

              Insert;
              FieldByName('PRO_NOMARQ').AsString  := 'PROCOD';
              FieldByName('PRO_CODSEQ').AsString  := '001';
              FieldByName('PRO_TAMCOD').AsInteger := 3;
              FieldByName('AUTOINCREM').AsString  := strEmpresaFisica + fPadL(IntToStr(fGetUltAutIncPROCOD) + VS_strCodEmp, 17, '0');
              FieldByName('PRO_CODEMP').AsString  := strEmpresaFisica;
              FieldByName('PRO_CODAUT').AsString  := 'N';
              Post;

              Close;
              SQL.Clear;
              SQL.Add(' SELECT * FROM PROINC');
              Open;

              Insert;
              FieldByName('PRO_NOMARQ').AsString  := 'PROCOD';
              FieldByName('PRO_AUTINC').AsInteger := 1;
              FieldByName('AUTOINCREM').AsString  := strEmpresaFisica + fPadL(IntToStr(fGetUltAutIncPROCOD) + VS_strCodEmp, 17, '0');
              Post;

              Close;
              SQL.Clear;
              SQL.Add(strSQL);
              ParamByName('NOMARQ').AsString := strNomeTabela;
              Open;
            End
            Else
            Begin
              Close;
              Raise Exception.Create('A tabela ' + strNomeTabela + ' não está cadastrada ' +
                                   'na tabela de Próximos Incrementos! Verifique.' + #13#10);
            End;
          End;

          strProEmp := strEmpresaFisica;

          If FieldByName('AUTINC').Value = Null Then
            intAutIncAtu := 1
          Else
            intAutIncAtu := FieldByName('AUTINC').AsLargeInt;

          Close;
        End;
        strSQL := '';
        strSQL := strSQL + 'UPDATE ';
        strSQL := strSQL + '  PROINC ';
        strSQL := strSQL + 'SET ';

        If intIntervalo > 1 Then
        Begin

          If intAutIncAtu = 1 Then
            strSQL := strSQL + '  PRO_AUTINC = ' + IntToStr(intIntervalo + 1)
          Else
            strSQL := strSQL + '  PRO_AUTINC = PRO_AUTINC + ' + IntToStr(intIntervalo);

        End Else
        Begin

          If intAutIncAtu = 1 Then
            strSQL := strSQL + '  PRO_AUTINC = 2 '
          Else
            strSQL := strSQL + '  PRO_AUTINC = PRO_AUTINC + 1 ';

        End;

        strSQL := strSQL + '  WHERE ';
        strSQL := strSQL + '    PRO_NOMARQ = :NOMARQ ';

        With qryGenCod Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('NOMARQ').AsString := strNomeTabela;
          ExecSQL;
          Close;
        End;

        Result :=  strProEmp + fPadL(IntToStr(intAutIncAtu) + strCodEmp, 17, '0');

        objFireDacConnection.Commit;
        If Not blnForcaValidaExistencia Then
          exit;
      Except
        On E: Exception Do
        Begin
          objFireDacConnection.Rollback;
          if (Pos('timeout expired', LowerCase(E.Message)) > 0) and (intTentativas <= 3) then
          begin
            intTentativas := intTentativas + 1 ;
            Sleep(1000);
          end
          else
            Raise ExceptClass(E.ClassType).Create('Não consegui pegar o proximo sequencial de ' + strNomeTabela +
              ' em PROINC. Tente novamente! ' + sLineBreak + '[' + E.Message + ']');
        End;
      End;

    Until (Not fAutoIncremCadastrado);

  Finally
    objFireDacConnection.Disconnect;
  End;
end ;

procedure pValidaProCodFireDac(const strNomeTabela: String);
Var
  objFireDacConnection : IConnection;
  qryGenCod: IQuery;
  strSQL: String ;
  intContador: Integer ;
  intTentativas: Integer ;
begin
  intTentativas := 1 ;
  repeat
    objFireDacConnection := TFireDacConnection.Create(fGetParametrosDaConexao, True);
    try
      objFireDacConnection.AfterStartTransaction := pLogStartFireDac ;
      objFireDacConnection.AfterCommit := pLogCommitFireDac ;
      objFireDacConnection.AfterRollback := pLogRollbackFireDac ;
      objFireDacConnection.Connect;

      qryGenCod := objFireDacConnection.NewQuery(20000);

      objFireDacConnection.StartTransaction;
      Try
        strSQL := '';
        strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
        strSQL := strSQL + '  PRO_NOMARQ ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  PROCOD ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ';

        qryGenCod.Close;
        qryGenCod.SQL.Clear;
        qryGenCod.SQL.Add(strSQL);
        qryGenCod.ParamByName('NOMARQ').AsString := strNomeTabela;
        qryGenCod.Open;
        If qryGenCod.IsEmpty Then
        Begin
          For intContador := 0 To Length(arrProCod) - 1 Do
          Begin
            If (strNomeTabela = arrProCod[intContador].strNomArq)  Then
            Begin
              qryGenCod.Close;
              qryGenCod.SQL.Clear;
              qryGenCod.SQL.Add(' SELECT * FROM PROCOD');
              qryGenCod.Open;
              qryGenCod.Insert;
              qryGenCod.FieldByName('PRO_NOMARQ').AsString  := arrProCod[intcontador].strNomArq;
              qryGenCod.FieldByName('PRO_CODSEQ').AsString  := arrProCod[intcontador].strCodSeq;
              qryGenCod.FieldByName('PRO_TAMCOD').AsInteger := arrProCod[intcontador].intTamCod;
              qryGenCod.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('PROCOD', VS_strCodEmp);
              qryGenCod.FieldByName('PRO_CODEMP').AsString  := fRetEmpresaFisicaFireDac(objFireDacConnection) ;
              qryGenCod.FieldByName('PRO_CODAUT').AsString  := arrProCod[intcontador].strCodAut;
              qryGenCod.Post;
              qryGenCod.Close;

              qryGenCod.SQL.Clear;
              qryGenCod.SQL.Add(' SELECT * FROM PROINC WHERE PRO_NOMARQ = :NOMARQ');
              qryGenCod.ParamByName('NOMARQ').AsString := arrProCod[intcontador].strNomArq;
              qryGenCod.Open;
              If qryGenCod.IsEmpty Then
              Begin
                qryGenCod.Insert;
                qryGenCod.FieldByName('PRO_NOMARQ').AsString  := arrProCod[intcontador].strNomArq;
                qryGenCod.FieldByName('PRO_AUTINC').AsString  := '1';
                qryGenCod.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('PROCOD',VS_strCodEmp);
                qryGenCod.Post;
              End;

              qryGenCod.Close;
              Break;
            End;
          End;

          qryGenCod.SQL.Clear;
          qryGenCod.SQL.Add(strSQL);
          qryGenCod.ParamByName('NOMARQ').AsString := strNomeTabela;
          qryGenCod.Open;
          If qryGenCod.IsEmpty Then
          Begin
            Raise Exception.Create('A Tabela '+strNomeTabela+' não foi encontrada no Vetor PROCOD' + #13#10 +
                                   '[fValidaProcod].');

            qryGenCod.Close;
          End;
        End;

        objFireDacConnection.Commit;
        listValidaProcod.Add(strNomeTabela);
        break ;

      Except
        On E: Exception Do
        Begin
          objFireDacConnection.Rollback;
          if (Pos('timeout expired', LowerCase(E.Message)) > 0) and (intTentativas <= 3) then
          begin
            intTentativas := intTentativas + 1 ;
            Sleep(1000);
          end
          else
            Raise;
        End;
      End;

    finally
      objFireDacConnection.Disconnect;
    end;
  until False ;
end ;

Function fRetEmpresaFisicaFireDac(const AConn: IConnection): String;
var
  qryEmpFisica: IQuery;
Begin
  if VS_EmpresaFisica = '' then
  begin
    qryEmpFisica := AConn.NewQuery(20000);
    qryEmpFisica.Close ;
    qryEmpFisica.SQL.Clear ;
    qryEmpFisica.SQL.Add('SELECT PRO_CODEMP FROM PROCOD WHERE PRO_NOMARQ = :NOMARQ ') ;
    qryEmpFisica.ParamByName('NOMARQ').AsString := 'MOVGER' ;
    qryEmpFisica.Open ;
    VS_EmpresaFisica := qryEmpFisica.FieldByName('PRO_CODEMP').AsString ;
  end ;
  Result := VS_EmpresaFisica ;
End;

function fAtualizaProCodGenerica(const objConnection: IConnection; const strNomeTabela, strCampoBusca: String; const strTabelaBusca : String = ''; const intQtdCod: Integer = 1; const objFncFmt : TFcnFormataProCod = Nil): String;
  Var
    strSQL : String;
    intCodigoAtual : Int64;
    intTamCodigo : Integer;
    blnComita : Boolean;
    qryGenCod : IQuery;
    blnCodPorEmpresa: Boolean;
begin
  pValidaProCod(strNomeTabela);

  qryGenCod := objConnection.NewQuery(20000);

  blnComita := False;

  If Not objConnection.InTransaction Then
  Begin
    objConnection.StartTransaction;
    blnComita := True;
  End;

  Try
    strSQL := fGetSelectProcodDoArquivoForUpdate;
    qryGenCod.Close;
    qryGenCod.SQL.Clear;
    qryGenCod.SQL.Add(strSQL);
    qryGenCod.ParamByName('NOMARQ').AsString := strNomeTabela;
    qryGenCod.Open;

    pCadastrarProcodProinc(qryGenCod, strSQL, strNomeTabela);

    intCodigoAtual := StrToInt64(qryGenCod.FieldByName('CODSEQ').AsString);
    intTamCodigo   := qryGenCod.FieldByName('TAMCOD').AsInteger;
    If (fFieldExists('SEQEMP', qryGenCod)) Then
      blnCodPorEmpresa := (qryGenCod.FieldByName('SEQEMP').AsString = 'S')
    Else
      blnCodPorEmpresa := False;
    qryGenCod.Close;

    pValidarProximoCodigo(intCodigoAtual, intTamCodigo, blnCodPorEmpresa, intQtdCod, strCampoBusca, IIF(fEmptyStr(strTabelaBusca), strNomeTabela, strTabelaBusca), objConnection, objFncFmt);

    strSQL := fGetUpdateProcodDoArquivo;
    qryGenCod.Close;
    qryGenCod.SQL.Clear;
    qryGenCod.SQL.Add(strSQL);
    qryGenCod.ParamByName('CODSEQ').AsString := fPadL(IntToStr(intCodigoAtual+intQtdCod), intTamCodigo, '0');
    qryGenCod.ParamByName('NOMARQ').AsString := strNomeTabela;
    qryGenCod.ExecSQL;

    Result := fProximoCodigoFormatado(blnCodPorEmpresa, intCodigoAtual, intQtdCod, intTamCodigo);

    If (Assigned(objFncFmt)) Then
      Result := objFncFmt(Result);

    If blnComita Then
      objConnection.Commit;
  Except
    On E: Exception Do
    Begin
      If blnComita Then
        objConnection.Rollback;
      Raise ExceptClass(E.ClassType).Create('Não consegui pegar o próximo sequencial de ' + strNomeTabela +
       ' em PROCOD. Tente novamente! ' + sLineBreak + '[' + E.Message + ']');
    End;
  End;
end;

function fProximoCodigoFormatado(const blnCodPorEmpresa : Boolean; const intCodigoAtual : Int64; const intQtdCod, intTamCodigo : Integer) : String;
begin
  If (blnCodPorEmpresa) Then
    Result := fPadL(IntToStr(intCodigoAtual + intQtdCod), intTamCodigo-3, '0') + VS_strCodEmp
  Else
    Result := fPadL(IntToStr(intCodigoAtual), intTamCodigo, '0');
end;

procedure pCadastrarProcodProinc(Var qryProcod : IQuery; Const strSQL, strNomeTabela : String);
  Var
    intContador : integer;
begin
  If Not qryProcod.IsEmpty Then
    Exit;

  qryProcod.Close;

  For intContador := 0 To Length(arrProCod) - 1 Do
  Begin
    If (strNomeTabela <> arrProCod[intContador].strNomArq)  Then
      Continue;
    qryProcod.SQL.Clear;
    qryProcod.SQL.Add(' SELECT * FROM PROCOD');
    qryProcod.Open;
    qryProcod.Insert;
    qryProcod.FieldByName('PRO_NOMARQ').AsString  := arrProCod[intcontador].strNomArq;
    qryProcod.FieldByName('PRO_CODSEQ').AsString  := arrProCod[intcontador].strCodSeq;
    qryProcod.FieldByName('PRO_TAMCOD').AsInteger := arrProCod[intcontador].intTamCod;
    qryProcod.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('PROCOD',VS_strCodEmp);
    qryProcod.FieldByName('PRO_CODEMP').AsString  := fRetEmpresaFisica;
    qryProcod.FieldByName('PRO_CODAUT').AsString  := 'S';
    qryProcod.Post;

    qryProcod.Close;
    qryProcod.SQL.Clear;
    qryProcod.SQL.Add(' SELECT * FROM PROINC WHERE PRO_NOMARQ = :NOMARQ');
    qryProcod.ParamByName('NOMARQ').AsString := arrProCod[intcontador].strNomArq;
    qryProcod.Open;

    If qryProcod.IsEmpty Then
    Begin
      qryProcod.Insert;
      qryProcod.FieldByName('PRO_NOMARQ').AsString  := arrProCod[intcontador].strNomArq;
      qryProcod.FieldByName('PRO_AUTINC').AsString  := '1';
      qryProcod.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('PROCOD',VS_strCodEmp);
      qryProcod.Post;
    End;

    qryProcod.Close;
    Break;
  End;

  qryProcod.SQL.Clear;
  qryProcod.SQL.Add(strSQL);
  qryProcod.ParamByName('NOMARQ').AsString := strNomeTabela;
  qryProcod.Open;

  If qryProcod.IsEmpty Then
  Begin
    qryProcod.Close;
    Raise Exception.Create('A tabela ' + strNomeTabela + ' não está cadastrada ' +
                           'na tabela de Próximos Codigos! Verifique.' + #13#10);
  End;
end;

function fGetProximoCodigoEmTransacaoFireDac(const strTabela: String; const strCampoBusca : String; const strTabelaBusca : String = ''; const objFncFmt : TFcnFormataProCod = Nil): String;
  Var
    objFireDacConnection : TFireDacConnection;
begin
  objFireDacConnection := TFireDacConnection.Create(fGetParametrosDaConexao, True);
  try
    objFireDacConnection.Connect;
    objFireDacConnection.StartTransaction;
    Result := fAtualizaProCodGenerica(objFireDacConnection, strTabela, strCampoBusca, strTabelaBusca, 1, objFncFmt);
    objFireDacConnection.Commit;
    objFireDacConnection.Disconnect;
  finally
    FreeAndNil(objFireDacConnection);
  end;
end;

function fGetProximoCodigoEmTransacaoUniDac(const strTabela : String; const strCampoBusca : String; const strTabelaBusca : String = ''; const objFncFmt : TFcnFormataProCod = Nil): String;
  Var
    objCriarConexao: TCriarConexao;
begin
  objCriarConexao := TCriarConexao.Create('fGetProximoCodigoEmTransacaoUniDac - ' + strTabela);
  Try
    objCriarConexao.objConexao.StartTransaction;
    Result := fAtualizaProCod(strTabela, strCampoBusca, strTabelaBusca, 1, objCriarConexao.objConexao, objFncFmt);
    objCriarConexao.objConexao.Commit;
  Finally
    If Assigned(objCriarConexao) Then
      FreeAndNil(objCriarConexao);
  End;
end;

function fGetProximoCodigoEmTransacao(const strTabela : String; const strCampoBusca : String; const strTabelaBusca : String = ''; const objFncFmt : TFcnFormataProCod = Nil): String;
begin
  If fUsaFireDacComoConexao(strTabela) Then
    Result := fGetProximoCodigoEmTransacaoFireDac(strTabela, strCampoBusca, strTabelaBusca, objFncFmt)
  Else
    Result := fGetProximoCodigoEmTransacaoUniDac(strTabela, strCampoBusca, strTabelaBusca, objFncFmt);
end;

function fUsaFireDacComoConexao(const strTabela: String): Boolean;
begin
  Result := False;
  If fCfgSis('PRCTRA', varString) = 'N' Then
    Exit;
  Result := True;
end;

function fFieldExists(const strFieldName : String; qryDataSet : IQuery) : Boolean;
begin
  Try
    Result := Assigned(qryDataSet.FieldByName(strFieldName));
  Except
    Result := False;
  End;
end;

procedure pValidarProximoCodigo(Var intCodigoAtual : Int64; const intTamCodigo : Integer; const blnCodPorEmpresa : Boolean; const intQtdCod : Integer; const strCampoBusca, strTabelaBusca : String; const objConnection : IConnection; const objFncFmt : TFcnFormataProCod);
  Var
    dtaHraExc : TDateTime;
begin
  If fEmptyStr(strCampoBusca) Then
    Exit;
  If fEmptyStr(strTabelaBusca) Then
    Exit;
  If fCfgSis('VLPRXC', varString) = 'N' Then
    Exit;
  If Not fExisteRegistroProcod(objConnection, strCampoBusca, strTabelaBusca, intCodigoAtual, blnCodPorEmpresa, intTamCodigo, intQtdCod, objFncFmt) Then
    Exit;
  dtaHraExc := Now();
  While True Do
  Begin
    If (SecondsBetween(Now(), dtaHraExc) >= 20) Then
      Exit
    Else
      pNotificaFormGravandoAtivo('O próximo código disponível está demorando mais do que o esperado. Aguarde mais um instante.');
    If (intQtdCod = 1) Then
      intCodigoAtual := intCodigoAtual + 1
    Else
      intCodigoAtual := (intCodigoAtual + intQtdCod) + 1;
    If Not fExisteRegistroProcod(objConnection, strCampoBusca, strTabelaBusca, intCodigoAtual, blnCodPorEmpresa, intTamCodigo, intQtdCod, objFncFmt) Then
      Exit;
    Sleep(100);
  End;
end;

function fExisteRegistroProcod(const objConnection : IConnection; const strCampoBusca, strTabelaBusca : String; const intCodigoAtual : Int64; const blnCodPorEmpresa : Boolean; const intTamCodigo, intQtdCod : Integer; const objFncFmt : TFcnFormataProCod) : Boolean;

  function fProximoCodigoFormatadoFinal(const ACodigoAtual : Int64; const AQtdCodigo : Integer) : String;
  begin
    Result := fProximoCodigoFormatado(blnCodPorEmpresa, ACodigoAtual, AQtdCodigo, intTamCodigo);
    If Not Assigned(objFncFmt) Then
      Exit;
    Result := objFncFmt(Result);
  end;

  function fInProcod : String;
    Var
      strValues : String;
      intCnt : Int64;
      intFaixaInicial : Int64;
      intFaixaFinal : Int64;
  begin
    strValues := '';
    intFaixaInicial := intCodigoAtual;
    intFaixaFinal := intCodigoAtual + intQtdCod;

    For intCnt := intFaixaInicial To intFaixaFinal Do
    Begin
      If fEmptyStr(strValues) Then
        strValues := QuotedStr(fProximoCodigoFormatadoFinal(intCnt, 0))
      Else
        strValues := strValues + ', ' + QuotedStr(fProximoCodigoFormatadoFinal(intCnt, 0));
    End;
    If fEmptyStr(strValues) Then
      strValues := '''';
    Result := strValues;
  end;

  Var
    qryBusca : IQuery;
begin
  qryBusca := objConnection.NewQuery(0);
  qryBusca.Close;
  qryBusca.SQL.Clear;
  If (intQtdCod = 1) Then
  Begin
    qryBusca.SQL.Add(' SELECT ' + strCampoBusca);
    qryBusca.SQL.Add('   FROM ' + strTabelaBusca);
    qryBusca.SQL.Add('  WHERE ' + strCampoBusca + ' = :CODIGO ');
    qryBusca.ParamByName('CODIGO').AsString := fProximoCodigoFormatadoFinal(intCodigoAtual, intQtdCod);
  End
  Else
  Begin
    qryBusca.SQL.Add(' SELECT ' + strCampoBusca);
    qryBusca.SQL.Add('   FROM ' + strTabelaBusca);
    qryBusca.SQL.Add('  WHERE ' + strCampoBusca + ' IN (' + fInProcod + ')' );
  End;
  qryBusca.Open;
  Result := (Not qryBusca.IsEmpty);
end;

initialization
  VS_EmpresaFisica := '';

end.
