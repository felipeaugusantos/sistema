unit untAnaliseMov;

interface

Uses
  Classes, SysUtils, Controls, DB, Uni,
  untFuncoesSimples, untZClient, Math,
  Variants, StrUtils, Vcl.Forms, untLiberacao;

Const
  INT_APROVACAO = 1;
  INT_ACOMPANHAMENTO = 2;
  ARR_TIPRESANA: Array[1..2] Of String = ('Intervalo de Valores','Descrição Aberta');
  ARR_STATUSANA: Array[1..2] Of String = ('APROVADO', 'REPROVADO');
  ARR_DESTIPANA: Array[1..2] Of String = ('APROVAÇÃO', 'ACOMPANHAMENTO');

Type

  TAnaliseMov = Class(TZClient)
    Private
      FSeqGer: String;

      FCadOpe,
      FUpdate,
      FInsert: TUniQuery;
      intQtdAna : Integer;

      Function fSQLRegistros(blnLiberado, blnBaixado: Boolean; strSeqOpb: String = ''; blnInsert: Boolean = False; strSeqOpi: String = ''): String;

      Function fSQLInsert: String;
      Function fSQLUpdate: String;
      Function fSQLLotesSemAnalise(blnQtdLote: Boolean): String;
      Function fSQLUltimaAnalise: String;

      Function fTemAnaliseBaixada(strCodIte, strCodCor, strCodAna, strCodOrd: String;
                                  dtaDtaOrd: TDateTime; qryUltAna: TUniQuery): Boolean;

      Function fTemAnaliseBaixadaDoLote(strSeqOpi, strCodAna: String): Boolean;

      Procedure pUpdateMov;
      Procedure pInsertMov;

      Procedure pBeforePost(dataSet: TDataSet);
      Procedure pAfterScroll(dataSet: TDataSet);



    Public
      qryAnaGer: TUniQuery;

      constructor Create(Owner: TComponent); Reintroduce; Overload;
      Destructor Destroy; override;

      Function fCarregaRegistros(strAutInc, strSeqOpi: String; blnLiberado, blnBaixado: Boolean; strSeqOpb: String = ''; blnInsert: Boolean = False): Boolean;
      Function fSalvaRegistros(strAutInc: String): Boolean;

      Function fTemAnaliseComResultado(intTipAna: Integer): Boolean;
      Function fTemAnaliseReprovada(intTipAna: Integer): Boolean;
      Function fTemAnaliseVencida(intTipAna: Integer): Boolean;
      function fPermiteNovaAnalise(strAutInc: String): boolean;
      Function fTemAnaliseSemSituacaoOuSituacaoVazia(intTipAna: Integer): Boolean;
      Function fLiberaAnaliseSemSituacaoOuSituacaoVazia(AStrSeqAna: String): Boolean;

      Function fProdutoEhComponenteA(strSeqOpi: String): Boolean;

      Property strSeqGer: String Read FSeqGer Write FSeqGer;
  End;

  TTipoResultadoAnalise = (traNull, traIntervaloValores, traDescricaoAberta);

  function fStringToTipoResultadoAnalise(strTipoResultadoAnalise : String ) : TTipoResultadoAnalise;

implementation

Uses
  untAnaliseMovVencidos, untConsultas, untTypesSistema;

constructor TAnaliseMov.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, '');

  intQtdAna :=  fCfgSis('QTDANA', varInteger);
  FCadOpe := fCriaQuery;
End;

function TAnaliseMov.fPermiteNovaAnalise(strAutInc : String) : boolean;
begin
  if intQtdAna = 0 then
      Result := True
  else begin
    if StrToIntDef(fCampoTabela('COUNT(0)', 'ANAGER', ['GER_SEQOPI'], [strAutInc]),0) >= intQtdAna then
    begin
      pMensagemOk('É permitido apenas ' + IntToStr(intQtdAna) + ' análise(s) por ordem de produção!');
      Result := False;
    end
    else
      Result := True;
  end;
end;

Destructor TAnaliseMov.Destroy;
Begin
  FreeAndNil(FCadOpe);
  Inherited;
End;

Function TAnaliseMov.fProdutoEhComponenteA(strSeqOpi: String): Boolean;
CONST
  SQL_CONSULTA = 'SELECT ITE_COMPNA FROM ORDGER '+
                 ' INNER JOIN CADITE ON ITE_CODITE = ORD_CODITE '+
                 ' WHERE ORDGER.AUTOINCREM = :AUTINC';

Var
  qryConsulta: TUniQuery;
Begin
  qryConsulta:= fCriaQuery();
  Try
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add(SQL_CONSULTA);
    qryConsulta.ParamByName('AUTINC').AsString:= strSeqOpi;
    qryConsulta.Open;

    result:= (qryConsulta.FieldByName('ITE_COMPNA').AsString = 'S');

  Finally
    FreeAndNil(qryConsulta);
  End;
End;

Function TAnaliseMov.fSQLRegistros(blnLiberado, blnBaixado: Boolean; strSeqOpb: String = ''; blnInsert: Boolean = False; strSeqOpi: String = ''): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   D.*,  ';

  strSQL := strSQL + '  (CASE WHEN DET_STATUS = 1 THEN "' + ARR_STATUSANA[1] + '"  ';
  strSQL := strSQL + '        WHEN DET_STATUS = 2 THEN "' + ARR_STATUSANA[2] + '"  ';
  strSQL := strSQL + '        ELSE "" END) AS SITUACAO,                         ';

  strSQL := strSQL + '   ANA_CODANA,  ';
  strSQL := strSQL + '   ANA_DESCRI,  ';
  strSQL := strSQL + '   ANA_TIPANA,  ';
  strSQL := strSQL + '   ANA_TIPRES,  ';

  strSQL := strSQL + '  (CASE WHEN ANA_TIPANA = 1 THEN "' + ARR_DESTIPANA[1] + '"  ';
  strSQL := strSQL + '        WHEN ANA_TIPANA = 2 THEN "' + ARR_DESTIPANA[2] + '"  ';
  strSQL := strSQL + '        ELSE "" END) AS DESTIPANA,                           ';

  strSQL := strSQL + '  (CASE WHEN ANA_TIPRES = 1 THEN "' + ARR_TIPRESANA[1] + '"  ';
  strSQL := strSQL + '        WHEN ANA_TIPRES = 2 THEN "' + ARR_TIPRESANA[2] + '"  ';
  strSQL := strSQL + '        ELSE "" END) AS DESTIPRES,                           ';

  strSQL := strSQL + '   GAN_LIMMIN AS ANA_LIMMIN,  ';
  strSQL := strSQL + '   GAN_LIMMAX AS ANA_LIMMAX,  ';
  strSQL := strSQL + '   GAN_DESRES AS ANA_DESRES,  ';
  strSQL := strSQL + '   CONCAT(OPE_CODOPE, "-", OPE_NOMOPE) AS NOMOPE,      ';

  strSQL := strSQL + '   ANA_PERIOD,   ';
  strSQL := strSQL + '   G.ORD_DTACAD, ';
  strSQL := strSQL + '   G.ORD_CODORD  ';
  strSQL := strSQL + ' FROM ORDGER G  ';
  strSQL := strSQL + ' INNER JOIN GEIMAT M ON GMT_CODITE = G.ORD_CODITE   ';
  strSQL := strSQL + '                    AND GMT_CODCOR = G.ORD_CODCOR   ';
  strSQL := strSQL + '                    AND GMT_FORMUL = G.ORD_FORMUL   ';
  strSQL := strSQL + ' INNER JOIN GEIANA N ON GAN_SEQGMT = M.AUTOINCREM   ';
  strSQL := strSQL + ' INNER JOIN CADANA C ON C.ANA_CODANA = GAN_CODANA   ';
  strSQL := strSQL + ' LEFT  JOIN ANADET D ON D.DET_CODANA = C.ANA_CODANA ';
  strSQL := strSQL + '                    AND D.DET_SEQGER = :AUTINC      ';
  strSQL := strSQL + ' LEFT  JOIN CADOPE O ON O.OPE_CODOPE = DET_CODOPE   ';

  strSQL := strSQL + ' WHERE G.AUTOINCREM  = :SEQOPI ';

  If fCfgSis('ULTCMP', varBoolean) Then //Informa se irá trabalhar com Formulação nos Componentes AB
  Begin

    If fEmptyStr(strSeqOpb) Then
    Begin
      If (fProdutoEhComponenteA(strSeqOpi)) Then
        strSQL := strSQL + ' AND N.GAN_INFOAB <> "AB" '
    End
    Else
      strSQL := strSQL + ' AND N.GAN_INFOAB = "AB" ';

  End;

  If blnBaixado Then
    strSQL := strSQL + ' AND (D.DET_STATUS IS NOT NULL) '

  Else If blnLiberado Then
    strSQL := strSQL + ' AND ((D.DET_STATUS IS NOT NULL) OR (ANA_TIPANA = 2)) ';

  If fCfgSis('ULTCMP', varBoolean) Then
  Begin
    If (strSeqOpb <> '') and Not(blnInsert) Then  {Evita a duplicidade dos itens da analise. Pois o join é feito em cima do codana}
      strSQL := strSQL + 'GROUP BY D.AUTOINCREM ORDER BY D.AUTOINCREM ';
  End;

  Result := strSQL;
End;

Function TAnaliseMov.fCarregaRegistros(strAutInc, strSeqOpi : String; blnLiberado, blnBaixado: Boolean; strSeqOpb: String = ''; blnInsert: Boolean = False): Boolean;
Begin
  Try
    FSeqGer := strAutInc;

    With qryQuery Do
    Begin
      SQL.Text := fSQLRegistros(blnLiberado, blnBaixado, strSeqOpb, blnInsert, strSeqOpi);

      ParamByName('AUTINC').AsString := strAutInc;

      If Params.FindParam('SEQOPI') <> Nil Then
        ParamByName('SEQOPI').AsString := strSeqOpi;

      Result := fAbreClient(True, 'TAnaliseMov.fCarregaRegistros');
    End;

    BeforePost  := pBeforePost;
    AfterScroll := pAfterScroll;

    pAlinhaCampoCentro('ANA_CODANA');
    pAlinhaCampoCentro('SITUACAO');
    pAlinhaCampoCentro('DESTIPANA');
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TAnaliseMov.fCarregaRegistros]');
    End;
  End;
End;

Procedure TAnaliseMov.pUpdateMov;
Begin
  With FUpdate Do
  Begin
    Close;

    ParamByName('AUTINC').AsString := Self.FieldByName('AUTOINCREM').AsString;
    ParamByName('OBSERV').Value    := Self.FieldByName('DET_OBSERV').Value;
    ParamByName('RESULT').Value    := Self.FieldByName('DET_RESULT').Value;
    ParamByName('STATUS').Value    := Self.FieldByName('DET_STATUS').Value;
    ParamByName('OPEANA').Value    := Self.FieldByName('DET_OPEANA').Value;
    ParamByName('DTAANA').Value    := Self.FieldByName('DET_DTAANA').Value;
    ParamByName('HORANA').Value    := Self.FieldByName('DET_HORANA').Value;
    ParamByName('CODOPE').Value    := Self.FieldByName('DET_CODOPE').Value;
    If fEmptyStr(ParamByName('CODOPE').AsString) Then
      ParamByName('CODOPE').Clear;

    ExecSQL;
  End;
End;

Procedure TAnaliseMov.pInsertMov;
Begin
  With FInsert Do
  Begin
    Close;

    ParamByName('SEQGER').AsString := FSeqGer;
    ParamByName('AUTINC').AsString := Self.FieldByName('AUTOINCREM').AsString;
    ParamByName('CODANA').AsString := Self.FieldByName('ANA_CODANA').AsString;
    ParamByName('OBSERV').Value    := Self.FieldByName('DET_OBSERV').Value;
    ParamByName('RESULT').Value    := Self.FieldByName('DET_RESULT').Value;
    ParamByName('STATUS').Value    := Self.FieldByName('DET_STATUS').Value;
    ParamByName('OPEANA').Value    := Self.FieldByName('DET_OPEANA').Value;
    ParamByName('DTAANA').Value    := Self.FieldByName('DET_DTAANA').Value;
    ParamByName('HORANA').Value    := Self.FieldByName('DET_HORANA').Value;
    ParamByName('CODOPE').Value    := Self.FieldByName('DET_CODOPE').Value;
    If fEmptyStr(ParamByName('CODOPE').AsString) Then
      ParamByName('CODOPE').Clear;

    ExecSQL;
  End;
End;

Function TAnaliseMov.fSQLInsert: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' INSERT INTO ANADET ';
  strSQL := strSQL + ' (AUTOINCREM, ';
  strSQL := strSQL + '  DET_SEQGER, ';
  strSQL := strSQL + '  DET_CODANA, ';
  strSQL := strSQL + '  DET_RESULT, ';
  strSQL := strSQL + '  DET_OBSERV, ';
  strSQL := strSQL + '  DET_STATUS, ';
  strSQL := strSQL + '  DET_OPEANA, ';
  strSQL := strSQL + '  DET_DTAANA, ';
  strSQL := strSQL + '  DET_HORANA, ';
  strSQL := strSQL + '  DET_CODOPE  ) VALUES ';

  strSQL := strSQL + ' (:AUTINC, ';
  strSQL := strSQL + '  :SEQGER, ';
  strSQL := strSQL + '  :CODANA, ';
  strSQL := strSQL + '  :RESULT, ';
  strSQL := strSQL + '  :OBSERV, ';
  strSQL := strSQL + '  :STATUS, ';
  strSQL := strSQL + '  :OPEANA, ';
  strSQL := strSQL + '  :DTAANA, ';
  strSQL := strSQL + '  :HORANA, ';
  strSQL := strSQL + '  :CODOPE) ';

  Result := strSQL;
End;

Function TAnaliseMov.fSQLUpdate: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE ANADET SET ';

  strSQL := strSQL + '   DET_OBSERV = :OBSERV, ';
  strSQL := strSQL + '   DET_RESULT = :RESULT, ';
  strSQL := strSQL + '   DET_STATUS = :STATUS, ';
  strSQL := strSQL + '   DET_OPEANA = :OPEANA, ';
  strSQL := strSQL + '   DET_DTAANA = :DTAANA, ';
  strSQL := strSQL + '   DET_HORANA = :HORANA, ';
  strSQL := strSQL + '   DET_CODOPE = :CODOPE  ';

  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '   AUTOINCREM = :AUTINC ';

  Result := strSQL;
End;

Function TAnaliseMov.fSalvaRegistros(strAutInc: String): Boolean;
Begin
  Try
    AfterScroll := Nil;

    FUpdate := fCriaQuery(Self);
    FUpdate.SQL.Text := fSQLUpdate;

    FInsert := fCriaQuery(Self);
    FInsert.SQL.Text := fSQLInsert;

    FSeqGer := strAutInc;

    DisableControls;
    First;

    While Not Eof Do
    Begin

      // SER FOR INCLUSAO E O RESULTADO ESTIVER EM BRANDO ENTAO LIMPA
      // A DATA DA PRIMEIRA ANÁLISE
      If fEmptyStr(Self.FieldByName('DET_RESULT').AsString) And
         Self.FieldByName('AUTOINCREM').IsNull Then
      Begin
        Edit;
        Self.FieldByName('DET_OPEANA').Clear;
        Self.FieldByName('DET_DTAANA').Clear;
        Self.FieldByName('DET_HORANA').Clear;
        Post;
      End;

      If FieldByName('AUTOINCREM').IsNull Then
      Begin
        Edit;
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ANAGER', VS_strCodEmp);
        Post;

        pInsertMov;
      End Else
      Begin
        pUpdateMov;
      End;

      Next;
    End;

    Result := True;

    FreeAndNil(FUpdate);
    FreeAndNil(FInsert);

  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TAnaliseMov.fSalvaRegistros]');
    End;
  End;

  EnableControls;
  AfterScroll := pAfterScroll;
End;

Procedure TAnaliseMov.pAfterScroll(dataSet: TDataSet);
Begin

  Case FieldByName('ANA_TIPANA').AsInteger Of
    1:  Self.ReadOnly := Not qryAnaGer.FieldByName('GER_DTABAI').IsNull;
    2:  Self.ReadOnly := Not qryAnaGer.FieldByName('GER_DTAACO').IsNull;
  End;

End;

Procedure TAnaliseMov.pBeforePost(dataSet: TDataSet);
  Var
    chrKey : Char;
    arrSel : TConsultasArray;
Begin
  With DataSet Do
  Begin

    If fEmptyStr(FieldByName('DET_RESULT').AsString) Then
    Begin
      FieldByName('DET_STATUS').Clear;
      FieldByName('DET_OPEANA').Clear;
      FieldByName('SITUACAO').Clear;
      Exit;
    End;

    Case TTipoResultadoAnalise(StrToIntDef(FieldByName('ANA_TIPRES').AsString, 1)) of
      traIntervaloValores :
      begin
        If fStrToFloat(FieldByName('DET_RESULT').AsString, -1) < 0 Then
        Begin
          pMensagemOk('O Resultado deve ser maior ou igual a zero!');
          Cancel;
          Abort;
        End Else
        Begin
          If (RoundTo(fStrToFloat(FieldByName('DET_RESULT').AsString), -4) >= RoundTo(FieldByName('ANA_LIMMIN').AsFloat, -4)) And
             (RoundTo(fStrToFloat(FieldByName('DET_RESULT').AsString), -4) <= RoundTo(FieldByName('ANA_LIMMAX').AsFloat, -4)) Then
            FieldByName('DET_STATUS').AsInteger := 1
          Else
            FieldByName('DET_STATUS').AsInteger := 2;

          FieldByName('SITUACAO').AsString := ARR_STATUSANA[FieldByName('DET_STATUS').AsInteger];
          FieldByName('DET_RESULT').AsString := FormatFloat('#,##0.0000', fStrToFloat(FieldByName('DET_RESULT').AsString, 0));

        end;

      end;

      traDescricaoAberta :
      begin

        If fEmptyStr(FieldByName('DET_RESULT').AsString) Then
        Begin
          pMensagemOk('A descrição do resultado deve ser preenchida!');
          Cancel;
          Abort;
        End
        Else If (not AnsiMatchStr(FieldByName('SITUACAO').AsString, ARR_STATUSANA)) and (FieldByName('SITUACAO').AsString <> 'SEM ANÁLISE')  Then
        Begin
          pMensagemOk('A situação da análise deve ser preenchida!');
          Cancel;
          Abort;
        End;

        FieldByName('DET_STATUS').AsInteger := AnsiIndexStr(FieldByName('SITUACAO').AsString, ARR_STATUSANA) +1;

      end;

    End;

    If FieldByName('DET_DTAANA').IsNull Then
    Begin
      FieldByName('DET_DTAANA').AsDateTime := VS_Date;
      FieldByName('DET_HORANA').AsDateTime := fTime();
      FieldByName('DET_OPEANA').AsString   := strLoginUsuarioLogado;
    End;

    If fCfgSis('OPEANA', varBoolean) Then
    Begin
      If fEmptyStr(FieldByName('DET_CODOPE').AsString) Then
      Begin
        chrKey := '?';
        If fPesqOperador(TForm(Owner), nil, nil, FCadOpe, chrKey, arrSel)Then
        Begin
          FieldByName('DET_CODOPE').AsString := FCadOpe.FieldByName('OPE_CODOPE').AsString;
          FieldByName('NOMOPE').AsString := FCadOpe.FieldByName('OPE_CODOPE').AsString + '-' + FCadOpe.FieldByName('OPE_NOMOPE').AsString;
        End
        Else
        Begin
          pMensagemOk('Informe o operador que realizou a análise!');
          Abort;
        End;
      End;
    End;

  End;
End;

Function TAnaliseMov.fTemAnaliseComResultado(intTipAna: Integer): Boolean;
Begin
  Result := False;

  DisableControls;
  First;

  While Not Eof Do
  Begin
    If (Not fEmptyStr(FieldByName('DET_RESULT').AsString)) And (FieldByName('ANA_TIPANA').AsInteger = intTipAna) Then
    Begin
      Result := True;
      Break;
    End;

    Next;
  End;

  EnableControls;
End;

Function TAnaliseMov.fTemAnaliseReprovada(intTipAna: Integer): Boolean;
Begin
  Result := Locate('ANA_TIPANA;DET_STATUS', VarArrayOf([intTipAna, 2]), []);
End;

Function TAnaliseMov.fSQLLotesSemAnalise(blnQtdLote: Boolean): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                      ';

  If blnQtdLote Then
  Begin
    strSQL := strSQL + ' DISTINCT                   ';
    strSQL := strSQL + '   OG.ORD_CODORD AS CODORD, ';
    strSQL := strSQL + '   OG.ORD_DTACAD AS DTACAD  ';
  End Else
  Begin
    strSQL := strSQL + '   "SEM ANÁLISE" AS SITUACAO, ';
    strSQL := strSQL + '   OG.ORD_CODITE AS CODITE, ';
    strSQL := strSQL + '   OG.ORD_CODCOR AS CODCOR, ';
    strSQL := strSQL + '   OG.ORD_CODORD AS CODORD, ';
    strSQL := strSQL + '   OG.ORD_DTACAD AS DTACAD, ';
    strSQL := strSQL + '   AG.GER_CODIGO AS CODIGO, ';
    strSQL := strSQL + '   AG.GER_DTABAI AS DTABAI, ';
    strSQL := strSQL + '   AG.GER_DTAACO AS DTAACO  ';
  End;

  strSQL := strSQL + ' FROM          ';
  strSQL := strSQL + '   ORDGER OG   ';

  strSQL := strSQL + ' LEFT JOIN ANAGER AG ON OG.AUTOINCREM = AG.GER_SEQOPI  ';

  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '   OG.ORD_CODITE = :CODITE     AND ';
  strSQL := strSQL + '   OG.ORD_CODCOR = :CODCOR     AND ';
  strSQL := strSQL + '   OG.AUTOINCREM <> :SEQOPI    AND ';

  strSQL := strSQL + '   OG.ORD_DTACAD >= :DTAULT    AND ';
  strSQL := strSQL + '   ((OG.ORD_DTACAD > :DTAULT)  OR  ';
  strSQL := strSQL + '    (OG.ORD_CODORD > :CODULT)) AND ';

  strSQL := strSQL + '   OG.ORD_DTACAD <= :DTAORD    AND ';
  strSQL := strSQL + '   ((OG.ORD_DTACAD < :DTAORD)  OR  ';
  strSQL := strSQL + '    (OG.ORD_CODORD < :CODORD))     ';

  strSQL := strSQL + ' ORDER BY                          ';
  strSQL := strSQL + '   OG.ORD_DTACAD, OG.ORD_CODORD    ';

  Result := strSQL;
End;

Function TAnaliseMov.fSQLUltimaAnalise: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                     ';


  strSQL := strSQL + '  (CASE WHEN DET_STATUS = 1 THEN "' + ARR_STATUSANA[1] + '"  ';
  strSQL := strSQL + '        WHEN DET_STATUS = 2 THEN "' + ARR_STATUSANA[2] + '"  ';
  strSQL := strSQL + '        ELSE "NÃO ANALISADO" END) AS SITUACAO,              ';

  strSQL := strSQL + '   OG.ORD_CODITE AS CODITE, ';
  strSQL := strSQL + '   OG.ORD_CODCOR AS CODCOR, ';
  strSQL := strSQL + '   OG.ORD_CODORD AS CODORD, ';
  strSQL := strSQL + '   OG.ORD_DTACAD AS DTACAD, ';
  strSQL := strSQL + '   AG.GER_CODIGO AS CODIGO, ';
  strSQL := strSQL + '   AG.GER_DTABAI AS DTABAI, ';
  strSQL := strSQL + '   AG.GER_DTAACO AS DTAACO  ';

  strSQL := strSQL + ' FROM          ';
  strSQL := strSQL + '   ORDGER OG   ';

  strSQL := strSQL + ' INNER JOIN ANAGER AG ON OG.AUTOINCREM = AG.GER_SEQOPI AND  ';
  strSQL := strSQL + '                         AG.GER_DTABAI IS NOT NULL          ';

  strSQL := strSQL + ' INNER JOIN ANADET AD ON AD.DET_SEQGER = AG.AUTOINCREM AND  ';
  strSQL := strSQL + '                         AD.DET_CODANA = :CODANA AND        ';
  strSQL := strSQL + '                         AD.DET_RESULT IS NOT NULL          ';

  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '   OG.ORD_CODITE = :CODITE AND   ';
  strSQL := strSQL + '   OG.ORD_CODCOR = :CODCOR AND   ';

  strSQL := strSQL + '   OG.ORD_DTACAD <= :DTAORD    AND ';
  strSQL := strSQL + '   ((OG.ORD_DTACAD < :DTAORD)  OR  ';
  strSQL := strSQL + '    (OG.ORD_CODORD < :CODORD))     ';

  strSQL := strSQL + ' ORDER BY                        ';
  strSQL := strSQL + '   OG.ORD_DTACAD DESC, OG.ORD_CODORD DESC ';

  strSQL := strSQL + ' LIMIT 1 ';

  Result := strSQL;
End;

Function TAnaliseMov.fTemAnaliseBaixada(strCodIte,
                                        strCodCor,
                                        strCodAna,
                                        strCodOrd: String;
                                        dtaDtaOrd: TDateTime;
                                        qryUltAna: TUniQuery): Boolean;
Begin
  With qryUltAna Do
  Begin
    Close;

    ParamByName('CODITE').AsString   := strCodIte;
    ParamByName('CODCOR').AsString   := strCodCor;
    ParamByName('CODANA').AsString   := strCodAna;
    ParamByName('DTAORD').AsDateTime := dtaDtaOrd;
    ParamByName('CODORD').AsString   := strCodOrd;

    Open;

    Result := Not IsEmpty;
  End;
End;

Function TAnaliseMov.fTemAnaliseBaixadaDoLote(strSeqOpi, strCodAna: String): Boolean;
  Var
    qryMovAna: TUniQuery;
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT COUNT(*) AS QTD  ';

  strSQL := strSQL + ' FROM          ';
  strSQL := strSQL + '   ORDGER OG   ';

  strSQL := strSQL + ' INNER JOIN ANAGER AG ON OG.AUTOINCREM = AG.GER_SEQOPI AND  ';
  strSQL := strSQL + '                         AG.GER_DTABAI IS NOT NULL          ';

  strSQL := strSQL + ' INNER JOIN ANADET AD ON AD.DET_SEQGER = AG.AUTOINCREM AND  ';
  strSQL := strSQL + '                         AD.DET_CODANA = :CODANA AND        ';
  strSQL := strSQL + '                         AD.DET_RESULT IS NOT NULL          ';

  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '   OG.AUTOINCREM = :SEQOPI AND   ';
  strSQL := strSQL + '   AD.DET_CODANA = :CODANA       ';

  qryMovAna := fCriaQuery;
  With qryMovAna Do
  Begin
    SQL.Text := strSQL;

    ParamByName('CODANA').AsString   := strCodAna;
    ParamByName('SEQOPI').AsString   := strSeqOpi;

    Open;

    Result := FieldByName('QTD').AsInteger > 0;

  End;
  FreeAndNil(qryMovAna);
End;

Function TAnaliseMov.fTemAnaliseVencida(intTipAna: Integer): Boolean;
  Var
    cdsQtdLot,
    cdsOrdPro: TZClient;
    strCodOrd,
    strCodIte,
    strCodCor: String;
    dtaDtaOrd: TdateTime;
    qryUltAna: TUniQuery;
    frmAnaliseMovVencidos : TfrmAnaliseMovVencidos;
   Procedure pInsereUltimaAnalise;
      Var
        intContador: Integer;
   Begin
     cdsOrdPro.Insert;

     For intContador := 0 To cdsOrdPro.Fields.Count - 1 Do
       cdsOrdPro.Fields[intContador].Value := qryUltAna.FieldByName(cdsOrdPro.Fields[intContador].FieldName).Value;

     cdsOrdPro.Post;
   End;

    Procedure pSetaParametrosLotes(cdsOrdPro: TZClient);
    Begin
      With cdsOrdPro, qryQuery Do
      Begin
        ParamByName('SEQOPI').AsString   := qryAnaGer.FieldByName('GER_SEQOPI').AsString;

        ParamByName('DTAORD').AsDateTime := dtaDtaOrd;
        ParamByName('CODORD').AsString   := strCodOrd;

        ParamByName('CODITE').AsString   := strCodIte;
        ParamByName('CODCOR').AsString   := strCodCor;

        ParamByName('CODULT').AsString   := qryUltAna.FieldByName('CODORD').AsString;
        ParamByName('DTAULT').AsDateTime := qryUltAna.FieldByName('DTACAD').AsDateTime;
      End;
    End;

Begin
  Result := False;

  Try
    qryUltAna := fCriaQuery;
    qryUltAna.SQL.Text := fSQLUltimaAnalise;

    strCodIte := fCampoTabela('ORD_CODITE', 'ORDGER', ['AUTOINCREM'], [qryAnaGer.FieldByName('GER_SEQOPI').AsString]);
    strCodCor := fCampoTabela('ORD_CODCOR', 'ORDGER', ['AUTOINCREM'], [qryAnaGer.FieldByName('GER_SEQOPI').AsString]);
    strCodOrd := fCampoTabela('ORD_CODORD', 'ORDGER', ['AUTOINCREM'], [qryAnaGer.FieldByName('GER_SEQOPI').AsString]);
    dtaDtaOrd := fCampoTabela('ORD_DTACAD', 'ORDGER', ['AUTOINCREM'], [qryAnaGer.FieldByName('GER_SEQOPI').AsString]);

    cdsOrdPro := TZClient.Create(Self, fSQLLotesSemAnalise(False));
    cdsQtdLot := TZClient.Create(Self, fSQLLotesSemAnalise(True));

    DisableControls;
    First;

    While Not Eof Do
    Begin
      If (fEmptyStr(FieldByName('DET_RESULT').AsString)) And

         (FieldByName('ANA_TIPANA').AsInteger = intTipAna) And

         (Not fTemAnaliseBaixadaDoLote(qryAnaGer.FieldByName('GER_SEQOPI').AsString,
                                       FieldByName('ANA_CODANA').AsString)) And

         fTemAnaliseBaixada(strCodIte,
                            strCodCor,
                            FieldByName('ANA_CODANA').AsString,
                            strCodOrd,
                            dtaDtaOrd,
                            qryUltAna) Then
      Begin

        With cdsOrdPro  Do
        Begin
          pSetaParametrosLotes(cdsOrdPro);
          pSetaParametrosLotes(cdsQtdLot);

          If fAbreClient(True, '') And
             cdsQtdLot.fAbreClient(True, '') And
             (cdsQtdLot.RecordCount >= Self.FieldByName('ANA_PERIOD').AsInteger - 1) Then
          Begin
            pInsereUltimaAnalise;

            pAlinhaCampoCentro('CODITE');
            pAlinhaCampoCentro('CODCOR');
            pAlinhaCampoCentro('CODORD');
            pAlinhaCampoCentro('DTACAD');
            pAlinhaCampoCentro('CODIGO');
            pAlinhaCampoCentro('DTABAI');
            pAlinhaCampoCentro('DTAACO');
            pAlinhaCampoCentro('SITUACAO');

            pCriarFormularios(TfrmAnaliseMovVencidos, frmAnaliseMovVencidos);

            If Self.FieldByName('ANA_PERIOD').AsInteger > 1 Then
              frmAnaliseMovVencidos.mmoMsg.Lines.Add('                               Há lotes não analisados ou suas análises ainda não foram finalizadas.');

            frmAnaliseMovVencidos.edtCodAna.Text := Self.FieldByName('ANA_CODANA').AsString + ' - ' + Self.FieldByName('ANA_DESCRI').AsString;
            frmAnaliseMovVencidos.edtPeriod.Text := Self.FieldByName('ANA_PERIOD').AsString;
            frmAnaliseMovVencidos.dtsLotes.DataSet := cdsOrdPro;
            frmAnaliseMovVencidos.ShowModal;
            FreeAndNil(frmAnaliseMovVencidos);
            Result := True;
            Break;
          End;
        End;

      End;

      Next;
    End;

    FreeAndNil(cdsOrdPro);
    FreeAndNil(cdsQtdLot);
    FreeAndNil(qryUltAna);
  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TAnaliseMov.fTemAnaliseVencida]');
    End;
  End;

  EnableControls;
End;

function fStringToTipoResultadoAnalise(strTipoResultadoAnalise : String ) : TTipoResultadoAnalise;
begin
  Result := TTipoResultadoAnalise(AnsiIndexStr(strTipoResultadoAnalise, ARR_TIPRESANA)+1);
end;

function TAnaliseMov.fLiberaAnaliseSemSituacaoOuSituacaoVazia(AStrSeqAna: String): Boolean;
var
  objLiberacao : TLiberacao;
begin
  objLiberacao := Nil;
  Try
    objLiberacao := TLiberacao.Create;
    objLiberacao.clear;

    objLiberacao.objMsgLibera.pAddTexto('Trava de liberação de finalização de análise');
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTextoCaption('Motivo', 'Liberação para finalizar Análise de Amostras sem situação informada (aprovado, reprovado)');
    objLiberacao.objMsgLibera.pAddTextoCaption('Código da análise', AStrSeqAna);
    objLiberacao.objMsgLibera.pAddTextoCaption('Ordem de produção industrial', Self.FieldByName('ORD_CODORD').AsString + ' - ' +FormatDateTime('dd/mm/yyyy', Self.FieldByName('ORD_DTACAD').AsDateTime) );

    objLiberacao.strDirAce := 'GANASR';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.blnUsarSenhaFixa := False;
    objLiberacao.blnSempreVariavelUsuario := True;

    Result := objLiberacao.fLibera;
  Finally
    If Assigned(objLiberacao) Then
    FreeAndNil(objLiberacao);
  End;
end;

Function TAnaliseMov.fTemAnaliseSemSituacaoOuSituacaoVazia(intTipAna: Integer): Boolean;
var
  intRecNoBkp: Integer;
Begin
  Result := False;
  If IsEmpty Then
    Exit;

  intRecNoBkp := RecNo;
  DisableControls;
  Try
    First;
    While Not Eof Do
    Begin
      If (FieldByName('ANA_TIPANA').AsString = IntToStr(intTipAna)) And fEmptyStr(FieldByName('DET_STATUS').AsString) Then
        Exit(True);
      Next;
    End;
  Finally
    RecNo := intRecNoBkp;
    EnableControls;
  End;
End;

end.
