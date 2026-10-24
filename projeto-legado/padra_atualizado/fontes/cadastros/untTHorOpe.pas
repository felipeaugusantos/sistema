unit untTHorOpe;

interface

uses StrUtils, SysUtils, Uni, Db, Classes, Forms, Variants, Controls, untTypesSistema,
     UniClientDataSet, UniDataSetProvider, Datasnap.DBClient, System.DateUtils;

Type
  TTipRestricao = (resAcesso, resVenda);

Type
  THorOpe = Class
  Private

  Public

    class function fExisteRestricoesDeAcesso(TipRestricao : TTipRestricao; blnSolicitaTrava1Vez : Boolean = False) : Boolean;

    class function fOperadoresExcecao : String;

    class function fUtilizaControlePermissaoHorario : Boolean;

    class function fOperadorUtilizaDefinicaoHorarioAcesso(strOperador : String) : Boolean;

    class function fValidacoes(cdsDados : TUniClientDataSet) : Boolean;

    class function fGravarHorOpe(cdsDados  : TUniClientDataSet;
                                 strCodOpe : String) : Boolean;

    class function fCarregarHorOpe(cdsDados  : TUniClientDataSet;
                                   strCodOpe : String) : Boolean;

    class function fIsTimeNull(varTime : Variant) : Boolean;

    class function fDiaSemana(NoDia : Integer) : String; Overload;
    class function fDiaSemana(NoDia : String) : String; Overload;

  End;

var
  blnLiberouPorSenha             : Boolean = False;
  hrHoraLiberacao, hrCicloHorOpe : TDateTime;

implementation

uses
  untFuncoesSimples, untLiberacao, untThreadUtils;

{ THorOpe }

class function THorOpe.fCarregarHorOpe(cdsDados  : TUniClientDataSet;
                                       strCodOpe : String): Boolean;
const
  strSQL = 'SELECT * FROM HOROPE WHERE HOR_CODOPE = :CODOPE';
var
  qryAux : TUniQuery;

  procedure pCarregarNovo;
  var
    i : Integer;
  begin

    cdsDados.EmptyDataSet;

    For i := 1 To 7 Do
    Begin
      cdsDados.Append;
      cdsDados.FieldByName('AUTINC').Clear;
      cdsDados.FieldByName('DIASEM').AsString := fDiaSemana(i);
      cdsDados.FieldByName('RESACE').AsString := 'N';
      cdsDados.FieldByName('RESVEN').AsString := 'N';
      cdsDados.FieldByName('HINI_1').Clear;
      cdsDados.FieldByName('HFIN_1').Clear;
      cdsDados.FieldByName('HINI_2').Clear;
      cdsDados.FieldByName('HFIN_2').Clear;
      cdsDados.Post;
    End;

  end;

begin

  If Assigned(cdsDados) And fEmptyStr(strCodOpe) Then
  Begin
    pCarregarNovo;
    Exit(True);
  End;

  Result := True;

  Try

    qryAux := fCriaQuery;

    Try

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(strSQL);
      qryAux.ParamByName('CODOPE').AsString := strCodOpe;
      qryAux.Open;

      {Limpa dados}
      cdsDados.EmptyDataSet;

      If Not qryAux.IsEmpty Then
      Begin

        qryAux.First;
        While Not qryAux.Eof Do
        Begin

          cdsDados.Append;
          cdsDados.FieldByName('AUTINC').AsString := qryAux.FieldByName('AUTOINCREM').AsString;
          cdsDados.FieldByName('DIASEM').AsString := qryAux.FieldByName('HOR_DIASEM').AsString;
          cdsDados.FieldByName('RESACE').AsString := qryAux.FieldByName('HOR_RESACE').AsString;
          cdsDados.FieldByName('RESVEN').AsString := qryAux.FieldByName('HOR_RESVEN').AsString;

          cdsDados.FieldByName('HINI_1').Value := IIF(qryAux.FieldByName('HOR_HINI_1').IsNull, NULL, qryAux.FieldByName('HOR_HINI_1').Value);
          cdsDados.FieldByName('HFIN_1').Value := IIF(qryAux.FieldByName('HOR_HFIN_1').IsNull, NULL, qryAux.FieldByName('HOR_HFIN_1').Value);
          cdsDados.FieldByName('HINI_2').Value := IIF(qryAux.FieldByName('HOR_HINI_2').IsNull, NULL, qryAux.FieldByName('HOR_HINI_2').Value);
          cdsDados.FieldByName('HFIN_2').Value := IIF(qryAux.FieldByName('HOR_HFIN_2').IsNull, NULL, qryAux.FieldByName('HOR_HFIN_2').Value);

          cdsDados.Post;

          qryAux.Next;

        End;

      End
      Else
        pCarregarNovo;

    Finally
      FreeAndNil(qryAux);
    End;

  Except
    Result := False;
  End;

end;

class function THorOpe.fDiaSemana(NoDia: Integer): String;
var
  DiaDaSemana : array [1..7] of String;
begin
  DiaDasemana [1]:= 'DOM';
  DiaDasemana [2]:= 'SEG';
  DiaDasemana [3]:= 'TER';
  DiaDasemana [4]:= 'QUA';
  DiaDasemana [5]:= 'QUI';
  DiaDasemana [6]:= 'SEX';
  DiaDasemana [7]:= 'SAB';
  Result := DiaDasemana[NoDia];
end;

class function THorOpe.fGravarHorOpe(cdsDados  : TUniClientDataSet;
                                     strCodOpe : String): Boolean;
const
  strSQLSel = 'SELECT * FROM HOROPE WHERE HOR_CODOPE = :CODOPE';

  strSQLDel = 'DELETE FROM HOROPE WHERE HOR_CODOPE = :CODOPE';

  strSQLIns = 'INSERT INTO HOROPE ' +
              '  (AUTOINCREM,     ' +
              '   HOR_CODOPE,     ' +
              '   HOR_DIASEM,     ' +
              '   HOR_RESACE,     ' +
              '   HOR_RESVEN,     ' +
              '   HOR_HINI_1,     ' +
              '   HOR_HFIN_1,     ' +
              '   HOR_HINI_2,     ' +
              '   HOR_HFIN_2) VALUES ( ' +
              '   :AUTINC,         ' +
              '   :CODOPE,         ' +
              '   :DIASEM,         ' +
              '   :RESACE,         ' +
              '   :RESVEN,         ' +
              '   :HINI_1,         ' +
              '   :HFIN_1,         ' +
              '   :HINI_2,         ' +
              '   :HFIN_2)';

  strSQLUpd = 'UPDATE HOROPE SET        ' +
              '   HOR_DIASEM = :DIASEM, ' +
              '   HOR_RESACE = :RESACE, ' +
              '   HOR_RESVEN = :RESVEN, ' +
              '   HOR_HINI_1 = :HINI_1, ' +
              '   HOR_HFIN_1 = :HFIN_1, ' +
              '   HOR_HINI_2 = :HINI_2, ' +
              '   HOR_HFIN_2 = :HFIN_2  ' +
              'WHERE                    ' +
              '  AUTOINCREM = :AUTINC   ';

var
  qryHorOpe : TUniQuery;
  qryInsert : TUniQuery;
  qryUpdate : TUniQuery;
begin

  Result := False;

  If cdsDados.IsEmpty Then
    Exit;

  fStartTransaction();

  Try

    qryHorOpe := fCriaQuery;
    qryInsert := fCriaQuery;
    qryUpdate := fCriaQuery;

    Try

      qryHorOpe.Close;
      qryHorOpe.SQL.Clear;
      qryHorOpe.SQL.Add(strSQLSel);
      qryHorOpe.ParamByName('CODOPE').AsString := strCodOpe;
      qryHorOpe.Open;

      If Not qryHorOpe.IsEmpty Then
      Begin

        qryHorOpe.First;
        While Not qryHorOpe.Eof Do
        Begin

          {Posiciona}
          If cdsDados.Locate('DIASEM', qryHorOpe.FieldByName('HOR_DIASEM').AsString, []) Then
          Begin

            {Valida se houve alterações}
            If (qryHorOpe.FieldByName('HOR_DIASEM').Value <> cdsDados.FieldByName('DIASEM').Value) Or
               (qryHorOpe.FieldByName('HOR_RESACE').Value <> cdsDados.FieldByName('RESACE').Value) Or
               (qryHorOpe.FieldByName('HOR_RESVEN').Value <> cdsDados.FieldByName('RESVEN').Value) Or
               (qryHorOpe.FieldByName('HOR_HINI_1').Value <> cdsDados.FieldByName('HINI_1').Value) Or
               (qryHorOpe.FieldByName('HOR_HFIN_1').Value <> cdsDados.FieldByName('HFIN_1').Value) Or
               (qryHorOpe.FieldByName('HOR_HINI_2').Value <> cdsDados.FieldByName('HINI_2').Value) Or
               (qryHorOpe.FieldByName('HOR_HFIN_2').Value <> cdsDados.FieldByName('HFIN_2').Value) Then
            Begin

              {Atualiza}
              qryUpdate.Close;
              qryUpdate.SQL.Clear;
              qryUpdate.SQL.Add(strSQLUpd);
              qryUpdate.ParamByName('AUTINC').AsString := cdsDados.FieldByName('AUTINC').AsString;
              qryUpdate.ParamByName('DIASEM').AsString := cdsDados.FieldByName('DIASEM').AsString;
              qryUpdate.ParamByName('RESACE').AsString := cdsDados.FieldByName('RESACE').AsString;
              qryUpdate.ParamByName('RESVEN').AsString := cdsDados.FieldByName('RESVEN').AsString;

              qryUpdate.ParamByName('HINI_1').Value := IIF(fIsTimeNull(cdsDados.FieldByName('HINI_1').Value), NULL, cdsDados.FieldByName('HINI_1').Value);
              qryUpdate.ParamByName('HFIN_1').Value := IIF(fIsTimeNull(cdsDados.FieldByName('HFIN_1').Value), NULL, cdsDados.FieldByName('HFIN_1').Value);
              qryUpdate.ParamByName('HINI_2').Value := IIF(fIsTimeNull(cdsDados.FieldByName('HINI_2').Value), NULL, cdsDados.FieldByName('HINI_2').Value);
              qryUpdate.ParamByName('HFIN_2').Value := IIF(fIsTimeNull(cdsDados.FieldByName('HFIN_2').Value), NULL, cdsDados.FieldByName('HFIN_2').Value);

              qryUpdate.ExecSQL;

            End;

          End;

          qryHorOpe.Next;

        End;

      End
      Else
      Begin

        cdsDados.First;
        While Not cdsDados.Eof Do
        Begin

          qryInsert.Close;
          qryInsert.SQL.Clear;
          qryInsert.SQL.Add(strSQLIns);
          qryInsert.ParamByName('AUTINC').AsString := fRetAutoIncrem('HOROPE', VS_strCodEmp);
          qryInsert.ParamByName('CODOPE').AsString := strCodOpe;
          qryInsert.ParamByName('DIASEM').AsString := cdsDados.FieldByName('DIASEM').AsString;
          qryInsert.ParamByName('RESACE').AsString := cdsDados.FieldByName('RESACE').AsString;
          qryInsert.ParamByName('RESVEN').AsString := cdsDados.FieldByName('RESVEN').AsString;

          qryInsert.ParamByName('HINI_1').Value := IIF(fIsTimeNull(cdsDados.FieldByName('HINI_1').Value), NULL, cdsDados.FieldByName('HINI_1').Value);
          qryInsert.ParamByName('HFIN_1').Value := IIF(fIsTimeNull(cdsDados.FieldByName('HFIN_1').Value), NULL, cdsDados.FieldByName('HFIN_1').Value);
          qryInsert.ParamByName('HINI_2').Value := IIF(fIsTimeNull(cdsDados.FieldByName('HINI_2').Value), NULL, cdsDados.FieldByName('HINI_2').Value);
          qryInsert.ParamByName('HFIN_2').Value := IIF(fIsTimeNull(cdsDados.FieldByName('HFIN_2').Value), NULL, cdsDados.FieldByName('HFIN_2').Value);

          qryInsert.ExecSQL;

          cdsDados.Next;

        End;

      End;

    Finally
      FreeAndNil(qryHorOpe);
      FreeAndNil(qryInsert);
      FreeAndNil(qryUpdate);
    End;

    Result := True;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[THorOpe.fGravarHorOpe]');
  End;

end;

class function THorOpe.fIsTimeNull(varTime: Variant): Boolean;
begin
  Result := VarIsNull(varTime) Or (varTime = '00:00:00') Or (varTime = '00:00');
end;

class function THorOpe.fOperadoresExcecao: String;
begin
  Result := fCfgSis('OPENHR', varString);
end;

class function THorOpe.fOperadorUtilizaDefinicaoHorarioAcesso(strOperador: String): Boolean;
const
  strSQL = 'SELECT OPE_UTIDEF FROM CADOPE WHERE OPE_CODOPE = :CODOPE';
var
  qryAux : TUniQuery;
begin

  Result := False;

  If fEmptyStr(strOperador) Then
    strOperador := strLoginUsuarioLogado;

  qryAux := fCriaQuery;

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('CODOPE').AsString := strOperador;
    qryAux.Open;

    If Not qryAux.IsEmpty Then
      Result := (qryAux.FieldByName('OPE_UTIDEF').AsString = 'S');

  Finally
    FreeAndNil(qryAux);
  End;

end;

class function THorOpe.fDiaSemana(NoDia: String): String;
begin

  If SameText(NoDia, 'DOM') Then
    Result := 'Domingo'
  Else If SameText(NoDia, 'SEG') Then
    Result := 'Segunda-Feira'
  Else If SameText(NoDia, 'TER') Then
    Result := 'Terça-Feira'
  Else If SameText(NoDia, 'QUA') Then
    Result := 'Quarta-Feira'
  Else If SameText(NoDia, 'QUI') Then
    Result := 'Quinta-Feira'
  Else If SameText(NoDia, 'SEX') Then
    Result := 'Sexta-Feira'
  Else If SameText(NoDia, 'SAB') Then
    Result := 'Sábado';

end;

class function THorOpe.fExisteRestricoesDeAcesso(TipRestricao : TTipRestricao; blnSolicitaTrava1Vez : Boolean = False): Boolean;
const
  strSQLRestricaoAcesso = 'SELECT * FROM HOROPE WHERE HOR_CODOPE = :CODOPE AND HOR_DIASEM = :DIASEM AND HOR_RESACE = ''S''';
  strSQLRestricaoVenda  = 'SELECT * FROM HOROPE WHERE HOR_CODOPE = :CODOPE AND HOR_DIASEM = :DIASEM AND HOR_RESVEN = ''S''';
var
  strDiaDaSemanaAtual,
  strPeriodo1,
  strPeriodo2   : String;
  qryRestricoes : TUniQuery;
  timeHoraAtual : TTime;
  objLiberacao  : TLiberacao;
  blnLibera     : Boolean;
begin

  Result := True;

  {Controle habilitado?}
  If Not fUtilizaControlePermissaoHorario Then
    Exit(False);

  {Usuário logado utiliza definição?}
  If Not fOperadorUtilizaDefinicaoHorarioAcesso(strLoginUsuarioLogado) Then
    Exit(False);

  {Já liberou com senha? Então deve aguardar!}
  If (blnLiberouPorSenha) Then
  Begin
    If MinutesBetween(hrHoraLiberacao, fRetHoraServidor) < fCfgSis('TMPHOR', varInteger) Then
      Exit(False);
  End;

  {Tela ainda aberta!}
  If Application.FindComponent('frmFatLiberacaoCliente') <> Nil Then
    Exit(False);

  strDiaDaSemanaAtual := fDiaSemana(DayOfWeek(fRetDataServidor));

  qryRestricoes := fCriaQuery();

  Try

    qryRestricoes.Close;
    qryRestricoes.SQL.Clear;

    If (TipRestricao = resAcesso) Then
      qryRestricoes.SQL.Add(strSQLRestricaoAcesso)
    Else
    If (TipRestricao = resVenda) Then
      qryRestricoes.SQL.Add(strSQLRestricaoVenda);

    qryRestricoes.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryRestricoes.ParamByName('DIASEM').AsString := strDiaDaSemanaAtual;
    qryRestricoes.Open;

    {Sem restrições cadastradas!}
    If qryRestricoes.IsEmpty Then
      Result := False
    Else Begin

      timeHoraAtual := fRetHoraServidor;

      {Horário 1 - Acessou dentro do horário permitido?}
      strPeriodo1 := '';
      If Not qryRestricoes.FieldByName('HOR_HINI_1').IsNull Then
      Begin

        strPeriodo1 := qryRestricoes.FieldByName('HOR_HINI_1').AsString + ' às ' + qryRestricoes.FieldByName('HOR_HFIN_1').AsString;

        If (timeHoraAtual >= qryRestricoes.FieldByName('HOR_HINI_1').Value) And
           (timeHoraAtual <= qryRestricoes.FieldByName('HOR_HFIN_1').Value) Then
          Result := False;

      End;

      {Horário 2 - Acessou dentro do horário permitido?}
      strPeriodo2 := '';
      If Not qryRestricoes.FieldByName('HOR_HINI_2').IsNull Then
      Begin

        strPeriodo2 := qryRestricoes.FieldByName('HOR_HINI_2').AsString + ' às ' + qryRestricoes.FieldByName('HOR_HFIN_2').AsString;

        If (timeHoraAtual >= qryRestricoes.FieldByName('HOR_HINI_2').Value) And
           (timeHoraAtual <= qryRestricoes.FieldByName('HOR_HFIN_2').Value) Then
          Result := False;

      End;

      {Foi identificado restrição}
      If (Result) Then
      Begin

        objLiberacao := TLiberacao.create;

        Try

          objLiberacao.Clear;
          objLiberacao.strDirAce := 'LIBHOR';
          objLiberacao.strMsgSen := 'Restrição de Horário';
          objLiberacao.strCodOpe := strLoginUsuarioLogado;

          If (TipRestricao = resAcesso) Then
            objLiberacao.objMsgLibera.pAddTexto('Existe restrição de horário para utilização do sistema para este operador.')
          Else
          If (TipRestricao = resVenda) Then
            objLiberacao.objMsgLibera.pAddTexto('Existe restrição de horário para realização de qualquer operação de faturamento.');

          objLiberacao.objMsgLibera.pAddTexto('Operador: ' + strLoginUsuarioLogado + '-' + fRetNomeOperador(strLoginUsuarioLogado));

          If fEmptyStr(strPeriodo1) And fEmptyStr(strPeriodo2) Then
            objLiberacao.objMsgLibera.pAddTexto(fDiaSemana(strDiaDaSemanaAtual) + ', bloqueio total no dia.')
          Else
            objLiberacao.objMsgLibera.pAddTexto(fDiaSemana(strDiaDaSemanaAtual) + ', ' + strPeriodo1 + IIF(fEmptyStr(strPeriodo2), '.', ', e das ' + strPeriodo2 + '.'));

          objLiberacao.objMsgLibera.pAddQuebra;
          objLiberacao.objMsgLibera.pAddTexto('Liberar por mais ' + fCfgSis('TMPHOR', varString) + ' minutos.');

          blnLibera := False;

          {Solicita liberação 1 vez}
          If (blnSolicitaTrava1Vez) Then
            blnLibera := objLiberacao.fLibera
          Else
          Begin

            While Not blnLibera Do
            Begin

              blnLibera := objLiberacao.fLibera;

              If Not blnLibera Then
              Begin
                If fMensagem('AVISO', 'Deseja sair do sistema?', ['', '']) = 1 Then
                Begin
                  TThreadFinalizarAutcomMonitor.Monitorar;
                  Application.Terminate;
                  Exit;
                End;
              End;

            End;

          End;

          {Liberou restrição}
          If (blnLibera) Then
          Begin

            Result := False;

            blnLiberouPorSenha := True;
            hrHoraLiberacao    := fRetHoraServidor;
            hrCicloHorOpe      := fTime();

          End;
  
        Finally
          FreeAndNil(objLiberacao);
        End;

      End;

    End;

  Finally
    FreeAndNil(qryRestricoes);
  End;

end;

class function THorOpe.fUtilizaControlePermissaoHorario: Boolean;
begin
  Result := fCfgSis('UTIHOR', varBoolean);
end;

class function THorOpe.fValidacoes(cdsDados: TUniClientDataSet): Boolean;

  function fRetCampo(strNome : String) : TField;
  begin
    Result := cdsDados.FieldByName(strNome);
  end;

begin

  Result := True;

  If Not cdsDados.IsEmpty Then
  Begin

    cdsDados.DisableControls;

    Try

      cdsDados.First;
      While Not cdsDados.Eof Do
      Begin

        If ((Not fIsTimeNull(fRetCampo('HINI_1').Value)) And (fIsTimeNull(fRetCampo('HFIN_1').Value))) Or
           ((Not fIsTimeNull(fRetCampo('HFIN_1').Value)) And (fIsTimeNull(fRetCampo('HINI_1').Value))) Then
        Begin
          fMensagem('Aviso', 'Informe os horários "Hora Inicial 1" e "Hora Final 1" corretamente!',['&OK']);
          Result := False;
          Break;
        End;

        If ((Not fIsTimeNull(fRetCampo('HINI_2').Value)) And (fIsTimeNull(fRetCampo('HFIN_2').Value))) Or
           ((Not fIsTimeNull(fRetCampo('HFIN_2').Value)) And (fIsTimeNull(fRetCampo('HINI_2').Value))) Then
        Begin
          fMensagem('Aviso', 'Informe os horários "Hora Inicial 2" e "Hora Final 2" corretamente!',['&OK']);
          Result := False;
          Break;
        End;

        If Not fIsTimeNull(fRetCampo('HINI_1').Value) Then
          If (fRetCampo('HINI_1').AsDateTime > fRetCampo('HFIN_1').AsDateTime) Then
          Begin
            fMensagem('Aviso', 'O campo "Hora Inicial 1" não pode ser maior que "Hora Final 1"!',['&OK']);
            Result := False;
            Break;
          End;

        If Not fIsTimeNull(fRetCampo('HINI_2').Value) Then
          If (fRetCampo('HINI_2').AsDateTime > fRetCampo('HFIN_2').AsDateTime) Then
          Begin
            fMensagem('Aviso', 'O campo "Hora Inicial 2" não pode ser maior que "Hora Final 2"!',['&OK']);
            Result := False;
            Break;
          End;

        cdsDados.Next;

      End;

    Finally
      cdsDados.EnableControls;
    End;

  End;

end;

end.
