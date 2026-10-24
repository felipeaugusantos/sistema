unit untTGerenciaAgendamentoRecebimento;

interface

uses
  untZClient, System.SysUtils, Uni, Data.DB;

type
  {$M+}
  TGerenciaAgendamentoRecebimento = class
    protected
      function fGetSQLConferencia: String;
      function fGetSQLItens: String;
      function fGetSQLAgeilo: String;
      procedure pConfigurarDataSets;
      function fAtualizaAgeIte(AStrNomCam: String; AStrCodIte: String; AFltQtdIte: Double): Boolean;
      function fAtualizaAgeIlo(AStrNomCam, AStrAutIncAgeIlo: String; AFltQtdIte: Double): Boolean;
      function fApagarPlano: Boolean;
    private
      cdsConferencia,
      cdsAgeIlo,
      cdsItens: TZClient;
      qryAux: TUniQuery;
      FStrAutIncRec: String;
      FStrCliFor: String;
      FStrEspDoc: String;
      FStrNumDoc: String;
      FStrSerie: String;
      FStrIdeDig: String;
      FStrOpeDel: String;
      FStrFrmDel: String;
      FStrMotivoDelecao: String;
      FStrOpcSel: String;
      FblnCnfEnd: Boolean;
      FBlnColVal: Boolean;
    public
      Constructor Create(AStrAutIncRec, AStrNumDoc, AStrCliFor, AStrSerie, AStrEspSel, AStrOpeDel, AStrFrmDel, AStrMotivoDel, AStrOpcDel: String);
      Destructor Destroy; Override;
      Function fProcessar: Boolean;
    published
      property strAutIncRec: String read FStrAutIncRec write FStrAutIncRec;
      property strIdeDig: String read FStrIdeDig write FStrIdeDig;
      property strNumDoc: String read FStrNumDoc write FStrNumDoc;
      property strCliFor: String read FStrCliFor write FStrCliFor;
      property strSerie: String read FStrSerie write FStrSerie;
      property strEspDoc: String read FStrEspDoc write FStrEspDoc;
      property strOpeDel: String read FStrOpeDel write FStrOpeDel;
      property strFrmDel: String read FStrFrmDel write FStrFrmDel;
      property strMotDel: String read FStrMotivoDelecao write FStrMotivoDelecao;
  End;

implementation

uses
  untFuncoesSimples;

{ TGerenciaAgendamementoRecebimento }

constructor TGerenciaAgendamentoRecebimento.Create(AStrAutIncRec, AStrNumDoc, AStrCliFor, AStrSerie, AStrEspSel, AStrOpeDel, AStrFrmDel, AStrMotivoDel, AStrOpcDel: String);
begin
  FStrAutIncRec        := AStrAutIncRec;
  FStrIdeDig           := fCampoTabela('ARC_IDEDIG','AGEREC',['AUTOINCREM'], [FStrAutIncRec]);
  FStrCliFor           := AStrCliFor;
  FStrEspDoc           := AStrEspSel;
  FStrNumDoc           := AStrNumDoc;
  FStrSerie            := AStrSerie;
  FStrOpeDel           := AStrOpeDel;
  FStrFrmDel           := AStrFrmDel;
  FStrOpcSel           := AStrOpcDel;
  FStrMotivoDelecao    := AStrMotivoDel;

  FblnCnfEnd := fCfgSis('CNFEND', varBoolean);
  FBlnColVal := fCfgSis('COLVAL', varBoolean);

  qryAux := fCriaQuery;

  pConfigurarDataSets;
end;

procedure TGerenciaAgendamentoRecebimento.pConfigurarDataSets;
begin
  cdsConferencia := TZClient.Create(Nil, fGetSQLConferencia);
  cdsConferencia.fAbreClient(False, 'TGerenciaAgendamementoRecebimento.Create');
  cdsConferencia.IndexFieldNames := 'DIG_CODITE';
  cdsConferencia.LogChanges := False;

  cdsItens := TZClient.Create(Nil, fGetSQLItens);
  cdsItens.fAbreClient(False, 'TGerenciaAgendamementoRecebimento.Create');
  cdsItens.IndexFieldNames := 'AIT_CODITE';
  cdsItens.LogChanges := False;

  cdsAgeIlo := TZClient.Create(Nil, fGetSQLAgeilo);
  cdsAgeIlo.fAbreClient(False, 'TGerenciaAgendamementoRecebimento.Create');
  with cdsAgeIlo.IndexDefs.AddIndexDef do
  begin
    Name := 'IdxQtdIte';
    Fields := 'AIL_QTDITE';
    Options := [ixDescending];
  end;
  cdsAgeIlo.LogChanges := False;
end;

destructor TGerenciaAgendamentoRecebimento.Destroy;
begin
  FreeAndNil(cdsConferencia);
  FreeAndNil(cdsItens);
  FreeAndNil(cdsAgeIlo);

  If Assigned(qryAux) Then
    FreeAndNil(qryAux);
  inherited;
end;

function TGerenciaAgendamentoRecebimento.fApagarPlano: Boolean;
begin
  Result := True;
  Try
    //Era o ultimo documento do agendamento ( AGEDOC ) = Mata o plano ( Elimina AGEILO/AGEITE/AGEREC/DIGELE )
    If qryAux.IsEmpty Then
    Begin
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(' SELECT AGEILO.* FROM AGEILO INNER JOIN AGEITE ON AIL_SEQITE = AGEITE.AUTOINCREM WHERE AIT_SEQGER = :AUTINC ');
      qryAux.ParamByName('AUTINC').AsString := FStrAutIncRec;
      qryAux.Open;
      While Not qryAux.Eof Do
      Begin
        fVerificaIntegridade(FStrFrmDel, 'AGEILO', qryAux, True, False, FStrMotivoDelecao, FStrOpeDel, False, FStrOpcSel);
        qryAux.Delete;
      End;

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(' SELECT * FROM AGEITE WHERE AIT_SEQGER = :AUTINC ');
      qryAux.ParamByName('AUTINC').AsString := FStrAutIncRec;
      qryAux.Open;
      While Not qryAux.Eof Do
      Begin
        fVerificaIntegridade(FStrFrmDel, 'AGEITE', qryAux, True, False, FStrMotivoDelecao, FStrOpeDel, False, FStrOpcSel);
        qryAux.Delete;
      End;

      //Remove as conferencias
      If FBlnColVal Then
      Begin
        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add('SELECT DIGVAL.* FROM DIGVAL INNER JOIN DIGELE ON DIV_SEQELE = DIGELE.AUTOINCREM WHERE DIG_IDEDIG = ' + QuotedStr(FStrIdeDig) + ' AND DIG_CODEMP = ' + QuotedStr(VS_strCodEmp));
        qryAux.Open;

        While Not qryAux.Eof Do
        Begin
          fVerificaIntegridade(FStrFrmDel, 'DIGVAL', qryAux, True, False, FStrMotivoDelecao, FStrOpeDel, False, FStrOpcSel);
          qryAux.Delete;
        End;
      End;

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT * FROM DIGELE WHERE DIG_IDEDIG = ' + QuotedStr(FStrIdeDig) + ' AND DIG_CODEMP = ' + QuotedStr(VS_strCodEmp));
      qryAux.Open;

      While Not qryAux.Eof Do
      Begin
        fVerificaIntegridade(FStrFrmDel, 'DIGELE', qryAux, True, False, FStrMotivoDelecao, FStrOpeDel, False, FStrOpcSel);
        qryAux.Delete;
      End;

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(' SELECT * FROM AGEREC WHERE AUTOINCREM = :AUTINC ');
      qryAux.ParamByName('AUTINC').AsString := FStrAutIncRec;
      qryAux.Open;
      fVerificaIntegridade(FStrFrmDel, 'AGEREC', qryAux, True, False, FStrMotivoDelecao, FStrOpeDel, False, FStrOpcSel);
      qryAux.Delete;
      qryAux.Close;
    End;
  Except On
    E:Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TGerenciaAgendamentoRecebimento.fApagarPlano]');
    End;
  End;
end;

function TGerenciaAgendamentoRecebimento.fAtualizaAgeIlo(AStrNomCam, AStrAutIncAgeIlo: String; AFltQtdIte: Double): Boolean;
begin
  Result := True;
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('UPDATE AGEILO SET ' + AStrNomCam + ' = ' + AStrNomCam + ' - :QTDITE WHERE AUTOINCREM = :AUTINC ');
    qryAux.SQL.Add('/*Dados anteriores: AIL_QTDITE: ' + cdsAgeIlo.FieldByName('AIL_QTDITE').AsString +
                                      ' AIL_LOCFIS: ' + cdsAgeIlo.FieldByName('AIL_LOCFIS').AsString +
                                      ' AIL_ENDERE: ' + cdsAgeIlo.FieldByName('AIL_ENDERE').AsString +'*/ ');
    qryAux.ParamByName('QTDITE').AsFloat  := AFltQtdIte;
    qryAux.ParamByName('AUTINC').AsString := AStrAutIncAgeIlo;
    qryAux.ExecSQL;

  Except On
    E:Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TGerenciaAgendamentoRecebimento.fAtualizaAgeIte]');
    End;
  End;

end;

function TGerenciaAgendamentoRecebimento.fAtualizaAgeIte(AStrNomCam, AStrCodIte: String; AFltQtdIte: Double): Boolean;
begin
  Result := True;
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('UPDATE AGEITE SET ' + AStrNomCam + ' = ' + AStrNomCam + ' - :QTDITE WHERE AIT_CODITE = :CODITE AND AIT_SEQGER = :SEQGER ');
    qryAux.SQL.Add('/*Dados anteriores: AIT_QTDTOT: ' + cdsItens.FieldByName('AIT_QTDTOT').AsString +
                                      ' AIT_QTDITE: ' + cdsItens.FieldByName('AIT_QTDITE').AsString +
                                      ' AIT_QTDEND: ' + cdsItens.FieldByName('AIT_QTDEND').AsString +
                                      ' AIT_QTDDEV: ' + cdsItens.FieldByName('AIT_QTDDEV').AsString +
                                      ' AIT_DIVEND: ' + cdsItens.FieldByName('AIT_DIVEND').AsString +'*/ ');
    qryAux.ParamByName('CODITE').AsString := AStrCodIte;
    qryAux.ParamByName('QTDITE').AsFloat  := AFltQtdIte;
    qryAux.ParamByName('SEQGER').AsString := FStrAutIncRec;
    qryAux.ExecSQL;

  Except On
    E:Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TGerenciaAgendamentoRecebimento.fAtualizaAgeIte]');
    End;
  End;
end;

function TGerenciaAgendamentoRecebimento.fGetSQLAgeilo: String;
begin
  Result := '';
  Result := Result + ' SELECT AIT_CODITE, AGEILO.*                           ';
  Result := Result + ' FROM AGEILO                                           ';
  Result := Result + ' INNER JOIN AGEITE ON AIL_SEQITE = AGEITE.AUTOINCREM   ';
  Result := Result + ' INNER JOIN AGEREC ON AIT_SEQGER = AGEREC.AUTOINCREM   ';
  Result := Result + ' WHERE TRUE                                            ';
  Result := Result + '   AND AGEREC.AUTOINCREM = ' + QuotedStr(FStrAutIncRec) ;
  Result := Result + '   AND AIL_ENDERE = "N"                                ';
  Result := Result + ' ORDER BY AIL_QTDITE DESC                              ';
end;

function TGerenciaAgendamentoRecebimento.fGetSQLConferencia: String;
begin
  Result := '';
  Result := Result + ' SELECT DIGELE.* FROM DIGELE                            ';
  Result := Result + ' INNER JOIN AGEREC ON ARC_IDEDIG = DIG_IDEDIG           ';
  Result := Result + '                  AND ARC_CODEMP = DIG_CODEMP           ';
  Result := Result + ' WHERE TRUE                                             ';
  Result := Result + '   AND AGEREC.AUTOINCREM = ' + QuotedStr(FStrAutIncRec)  ;
end;

function TGerenciaAgendamentoRecebimento.fGetSQLItens: String;
begin
  Result := '';
  Result := Result + ' SELECT (IFNULL(AIT_QTDTOT,0) -                 ';
  If FblnCnfEnd Then
    Result := Result + '         IFNULL(AIT_QTDEND,0) -                 ';
  Result := Result + '         IFNULL(AIT_QTDDEV,0)) AS QTD_RESTANTE, ';
  Result := Result + ' AGEITE.*                                       ';
  Result := Result + ' FROM AGEITE                                    ';
  Result := Result + ' WHERE AIT_SEQGER =' + QuotedStr(FStrAutIncRec)  ;
end;

function TGerenciaAgendamentoRecebimento.fProcessar: Boolean;
var
  qryMovDet: TUniQuery;
  strCodIte: String;
  fltQtdIte,
  fltQtdRecebida,
  fltQtdEnderecada,
  fltQtdDivEnderecada,
  fltQtdDivLibEnderecada,
  fltQtdAgeIlo,
  fltQtdRestante,
  fltQtdConferida: Double;
begin
  Result := True;

  Try
    qryAux.SQL.Clear;
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT * FROM AGEDOC WHERE ADC_SEQGER = :SEQGER ');
    qryAux.ParamByName('SEQGER').AsString := FStrAutIncRec;
    qryAux.Open;
    If qryAux.IsEmpty Then
    Begin
      Result := fApagarPlano;
      Exit;
    End;

    qryMovDet := fCriaQuery;
    Try
      qryMovDet.SQL.Clear;
      qryMovDet.SQL.Add('SELECT DET_CODITE, SUM(DET_QTDITE) AS QTDTOT ');
      qryMovDet.SQL.Add(' FROM MOVDET                                 ');
      qryMovDet.SQL.Add(' WHERE TRUE                                  ');
      qryMovDet.SQL.Add('   AND DET_NUMDOC = :NUMDOC                  ');
      qryMovDet.SQL.Add('   AND DET_SERIE_ = :SERIE_                  ');
      qryMovDet.SQL.Add('   AND DET_ESPDOC = :ESPDOC                  ');
      qryMovDet.SQL.Add('   AND DET_CODFOR = :CODFOR                  ');
      qryMovDet.SQL.Add(' GROUP BY DET_CODITE                         ');
      qryMovDet.ParamByName('NUMDOC').AsString := FStrNumDoc;
      qryMovDet.ParamByName('SERIE_').AsString := FStrSerie;
      qryMovDet.ParamByName('ESPDOC').AsString := FStrEspDoc;
      qryMovDet.ParamByName('CODFOR').AsString := FStrCliFor;
      qryMovDet.Open;

      If qryMovDet.IsEmpty Then
        Exit;

      qryMovDet.First;
      While Not qryMovDet.Eof Do
      Begin
        strCodIte := qryMovDet.FieldByName('DET_CODITE').AsString;
        fltQtdIte := qryMovDet.FieldByName('QTDTOT').AsFloat;

        // AGEITE - Itens do plano
        If cdsItens.Locate('AIT_CODITE', strCodIte, []) Then
        Begin
          fltQtdRecebida := cdsItens.FieldByName('QTD_RESTANTE').AsFloat;
          If (fltQtdRecebida > 0) And (fltQtdIte >= fltQtdRecebida) Then
          Begin
            qryAux.SQL.Clear;
            qryAux.SQL.Add('SELECT * FROM AGEITE WHERE AIT_CODITE = :CODITE AND AIT_SEQGER = :SEQGER ');
            qryAux.ParamByName('CODITE').AsString := strCodIte;
            qryAux.ParamByName('SEQGER').AsString := FStrAutIncRec;
            qryAux.Open;
            If Not qryAux.IsEmpty Then
            Begin
              fVerificaIntegridade(FStrFrmDel, 'AGEITE', qryAux, True, False, FStrMotivoDelecao, FStrOpeDel, False, FStrOpcSel);
              qryAux.Delete;
            End;
            cdsAgeIlo.Refresh;
          End
          Else If FblnCnfEnd Then
          Begin
            fltQtdEnderecada := cdsItens.FieldByName('AIT_QTDEND').AsFloat;
            fltQtdDivEnderecada := cdsItens.FieldByName('AIT_DIVEND').AsFloat;
            fltQtdDivLibEnderecada := cdsItens.FieldByName('AIT_DIVLIB').AsFloat;

            If (fltQtdEnderecada > 0) And (fltQtdite < fltQtdEnderecada) Then
              Result := Result And fAtualizaAgeite('AIT_QTDEND', strCodIte, fltQtdite)
            Else If (fltQtdDivEnderecada > 0) And (fltQtdite < fltQtdDivEnderecada) Then
              Result := Result And fAtualizaAgeite('AIT_DIVEND', strCodIte, fltQtdite)
            Else If (fltQtdDivLibEnderecada > 0) And (fltQtdite < fltQtdDivLibEnderecada) Then
              Result := Result And fAtualizaAgeite('AIT_DIVLIB', strCodIte, fltQtdite)
          End;
          Result := Result And fAtualizaAgeite('AIT_QTDTOT', strCodIte, fltQtdite);
          Result := Result And fAtualizaAgeite('AIT_QTDITE', strCodIte, fltQtdite);
        End;

        // DIGELE - Conferencia
        If cdsConferencia.Locate('DIG_CODITE', strCodIte, []) Then
        Begin
          fltQtdConferida := cdsConferencia.FieldByName('DIG_QTDITE').AsFloat;
          If fltQtdIte >= fltQtdConferida Then
          Begin
            If FBlnColVal Then
            Begin
              qryAux.SQL.Clear;
              qryAux.SQL.Add('SELECT * FROM DIGVAL WHERE DIV_SEQELE = :AUTINC ');
              qryAux.ParamByName('AUTINC').AsString := cdsConferencia.FieldByName('AUTOINCREM').AsString;
              qryAux.Open;
              If Not qryAux.IsEmpty Then
              Begin
                fVerificaIntegridade(FStrFrmDel, 'DIGVAL', qryAux, True, False,FStrMotivoDelecao, FStrOpeDel, False, FStrOpcSel);
                qryAux.Delete;
              End;
            End;

            qryAux.SQL.Clear;
            qryAux.SQL.Add('SELECT * FROM DIGELE WHERE DIG_CODITE = :CODITE AND DIG_IDEDIG = :IDEDIG ');
            qryAux.ParamByName('CODITE').AsString := strCodIte;
            qryAux.ParamByName('IDEDIG').AsString := FStrIdeDig;
            qryAux.Open;
            If Not qryAux.IsEmpty Then
            Begin
              fVerificaIntegridade(FStrFrmDel, 'DIGELE', qryAux, True, False,FStrMotivoDelecao, FStrOpeDel, False, FStrOpcSel);
              qryAux.Delete;
            End;
          End
          Else
          Begin
            qryAux.SQL.Clear;
            qryAux.SQL.Add('UPDATE DIGELE SET DIG_QTDITE = DIG_QTDITE - :QTDITE WHERE DIG_CODITE = :CODITE AND DIG_IDEDIG = :IDEDIG ');
            qryAux.SQL.Add('/*Dados anteriores: DIG_QTDITE: ' + cdsConferencia.FieldByName('DIG_QTDITE').AsString + '*/ ');
            qryAux.ParamByName('QTDITE').AsFloat := fltQtdIte;
            qryAux.ParamByName('CODITE').AsString := strCodIte;
            qryAux.ParamByName('IDEDIG').AsString := FStrIdeDig;
            qryAux.ExecSQL;

            If FBlnColVal Then
            Begin
              qryAux.SQL.Clear;
              qryAux.SQL.Add('UPDATE DIGVAL SET DIV_QTDITE = DIV_QTDITE - :QTDITE WHERE DIV_SEQELE = :AUTINC ');
              qryAux.SQL.Add('/*Dados anteriores: DIV_QTDITE: ' + cdsConferencia.FieldByName('DIG_QTDITE').AsString + '*/ ');
              qryAux.ParamByName('AUTINC').AsString := cdsConferencia.FieldByName('AUTOINCREM').AsString;
              qryAux.ParamByName('QTDITE').AsFloat := fltQtdIte;
              qryAux.ExecSQL;
            End;
          End;
        End;

        //AGEILO - Itens x localização
        If cdsAgeIlo.Locate('AIT_CODITE', strCodIte, []) Then
        Begin
          Try
            cdsAgeIlo.Filter := 'AIT_CODITE = ' + QuotedStr(strCodite);
            cdsAgeIlo.Filtered := True;
            cdsAgeIlo.IndexName := 'IdxQtdIte';
            cdsAgeIlo.First;
            fltQtdRestante := fltQtdIte;
            While Not cdsAgeIlo.Eof Do
            Begin
              If fltQtdRestante = 0 Then
              Begin
                cdsAgeIlo.Next;
                Continue;
              End;
              fltQtdAgeIlo := cdsAgeIlo.FieldByName('AIL_QTDITE').AsFloat;
              If (fltQtdAgeIlo > 0) And (fltQtdRestante < fltQtdAgeIlo) Then
              Begin
                fAtualizaAgeIlo('AIL_QTDITE', cdsAgeIlo.FieldByName('AUTOINCREM').AsString, fltQtdRestante);
                fAtualizaAgeIlo('AIL_QTDVEN', cdsAgeIlo.FieldByName('AUTOINCREM').AsString, fltQtdRestante);
              End
              Else
              Begin
                fltQtdRestante := fltQtdRestante - fltQtdAgeIlo;
                qryAux.SQL.Clear;
                qryAux.SQL.Add('SELECT * FROM AGEILO WHERE AUTOINCREM = :AUTINC ');
                qryAux.ParamByName('AUTINC').AsString := cdsAgeIlo.FieldByName('AUTOINCREM').AsString;
                qryAux.Open;
                If Not qryAux.IsEmpty Then
                Begin
                  fVerificaIntegridade(FStrFrmDel, 'AGEILO', qryAux, True, False,FStrMotivoDelecao, FStrOpeDel, False, FStrOpcSel);
                  qryAux.Delete;
                End;
              End;
              cdsAgeIlo.Next;
            End;
          Finally
            cdsAgeIlo.Filter := '';
            cdsAgeIlo.Filtered := False;
          End;
        End;

        qryMovDet.Next;
      End;
    Except On
      E:Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TGerenciaAgendamementoRecebimento.fProcessar]');
      End;
    End;
  Finally
    If Assigned(qryMovDet) Then
      FreeAndNil(qryMovDet);
  End;
end;

end.
