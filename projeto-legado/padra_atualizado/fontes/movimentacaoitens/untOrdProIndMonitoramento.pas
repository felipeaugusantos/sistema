unit untOrdProIndMonitoramento;

interface

Uses
  Classes, SysUtils, Controls, DB,
  untFuncoesSimples, untZClient, Uni,
  untTypesSistema, untConstantes, untLiberacao, untMsgLiberacao;

  Type
  TOrdProIndMonitoramento = Class(TZClient)
    Private
      objLiberacao : TLiberacao;

      Function fSQLFases: String;
      Function fSQLEquipamentos: String;
      Function fSQLOperacoes: String;

      Procedure pCriaFases;
      Procedure pCriaEquipamentos;
      Procedure pMontaMensagemTrava(strAutInc: String);

      Function fCarregaMonitoramento(strAutOPI,
                                     strCodFas,
                                     strCodEqp: String): Boolean;

      Function fTemFaseAnteriorIniciada(strAutOPI,
                                strCodFas: String;
                                Var strFasAnt: String): Boolean;

      Function fTemFasePosteriorIniciada(strAutOPI,
                        strCodFas: String; Var strFasPos: String): Boolean;

      Function fPedeSenha(strAutInc: String): Boolean;

    Public
      qryMonOPI: TUniQuery;

      strIncOPI: String;

      qryEquipamentos: TUniQuery;
      qryFases: TUniQuery;

      cdsOperacoes: TZClient;

      cdsCabIpr: TZClient;
      fltVolume: Double;


      constructor Create(Owner: TComponent); Reintroduce; Overload;
      Destructor Destroy; override;

      Function fCarregaFases(strAutIncOP: String): Boolean;
      Function fCarregaEquipamentos(strCodFas: String): Boolean;
      Function fRetCodFase(intRecNo: Integer): String;


      Function fSQLMonitoramento(strCodEQP: String): String;

      Function fIniciaOperacao(strAutOPI,
                               strOpeIni,
                               strCodFas,
                               strCodEqp: String): Boolean;

      Function fFinalizaOperacao(strAutOPI,
                                 strOpeFin,
                                 strCodFas,
                                 strCodEqp: String): Boolean;

      Function fCarregaOperacoes: Boolean;

      Function fCancelaOperacao(strAutInc, strCodOPI, strCodFas: String; dtaDtaFin: TDateTime): Boolean;

      Function fOPFinalizada(strAutInc: String; Var strMsg: String): Boolean;

      Function fTemOperacaoIniciada(strAutInc: String): Boolean;
      Class Function fTemOperacaoIniciadaDeOPAberta(strCodFas: String = ''): Boolean;
      Function fSQLPosicaoOperacoes: String;
  End;

implementation

Uses
  untFuncFat, untOrdProIndustrialOperacoes;

constructor TOrdProIndMonitoramento.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, '');

  strIncOPI := '';

  pCriaFases;
  pCriaEquipamentos;

  cdsOperacoes := TZClient.Create(Self, fSQLOperacoes);

  objLiberacao := Tliberacao.Create;

  qryMonOPI := fCriaQuery(Self);
End;

Destructor TOrdProIndMonitoramento.Destroy;
Begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  Inherited;
End;

Function TOrdProIndMonitoramento.fSQLOperacoes: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL +  ' SELECT ';

  strSQL := strSQL +  '   T.*, ';

  strSQL := strSQL +  '   (SELECT F.FAS_DESFAS FROM CADFAS F WHERE F.FAS_CODFAS = T.MON_CODFAS) AS FAS_DESFAS, ';
  strSQL := strSQL +  '   (SELECT F.FAS_SEQFAS FROM CADFAS F WHERE F.FAS_CODFAS = T.MON_CODFAS) AS FAS_SEQFAS, ';
  strSQL := strSQL +  '   (SELECT E.EQP_DESCRI FROM CADEQP E WHERE E.EQP_CODEQP = T.MON_CODEQP) AS EQP_DESCRI ';

  strSQL := strSQL +  ' FROM ';

  strSQL := strSQL +  '   MOMORD T ';

  strSQL := strSQL +  ' WHERE ';
  strSQL := strSQL +  '   MON_SEQOPI = :SEQOPI ';
  strSQL := strSQL +  ' ORDER BY ';
  strSQL := strSQL +  '   FAS_SEQFAS, MON_DTAINI, MON_HORINI  ';

  Result := strSQL;
End;

Function TOrdProIndMonitoramento.fSQLMonitoramento(strCodEQP: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL +  ' SELECT * FROM MOMORD ';
  strSQL := strSQL +  ' WHERE ';
  strSQL := strSQL +  '   MON_SEQOPI = :SEQOPI AND ';
  strSQL := strSQL +  '   MON_CODFAS = :CODFAS AND ';

  If fEmptyStr(strCodEQP) Then
    strSQL := strSQL +  '   MON_CODEQP IS NULL      '
  Else
    strSQL := strSQL +  '   MON_CODEQP = :CODEQP     ';

  Result := strSQL;
End;

Function TOrdProIndMonitoramento.fSQLEquipamentos: String;
  Var
    strSQL: String;
Begin
  strSQL := '/* TOrdProIndMonitoramento.fSQLEquipamentos */ ';

  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   E.EQP_CODEQP,     ';
  strSQL := strSQL + '   E.EQP_DESCRI      ';
  strSQL := strSQL + ' FROM                ';
  strSQL := strSQL + '   CADEQP E          ';
  strSQL := strSQL + ' INNER JOIN EQPFAS T ON T.EQP_CODEQP = E.EQP_CODEQP ';
  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '    T.EQP_CODFAS = :CODFAS ';
  strSQL := strSQL + ' ORDER BY EQP_DESCRI ';

  Result := strSQL;
End;


Function TOrdProIndMonitoramento.fSQLFases: String;
  Var
    strSQL: String;
Begin
  strSQL := '/* TOrdProIndMonitoramento.fSQLFases */ ';

  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   C.FAS_CODFAS,  ';
  strSQL := strSQL + '   C.FAS_DESFAS   ';
  strSQL := strSQL + ' FROM           ';
  strSQL := strSQL + '   FASOPI T     ';
  strSQL := strSQL + ' INNER JOIN CADFAS C ON C.FAS_CODFAS = T.FAS_CODFAS ';
  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '    T.FAS_SEQOPI = :SEQOPI ';
  strSQL := strSQL + ' ORDER BY FAS_SEQFAS ';

  Result := strSQL;
End;

Procedure TOrdProIndMonitoramento.pCriaEquipamentos;
Begin
  qryEquipamentos := fCriaQuery(Self);
  qryEquipamentos.SQL.Text := fSQLEquipamentos;
End;


Procedure TOrdProIndMonitoramento.pCriaFases;
Begin
  qryFases := fCriaQuery(Self);
  qryFases.SQL.Text := fSQLFases;
End;

Function TOrdProIndMonitoramento.fCarregaFases(strAutIncOP: String): Boolean;
Begin
  Try

    With qryFases Do
    Begin
      Close;
      ParamByName('SEQOPI').AsString := strAutIncOP;
      Open;

      Result := Not IsEmpty;

      If Result Then
        strIncOPI := strAutIncOP
      Else
        strIncOPI := '';

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProIndMonitoramento.fCarregaFases]');
    End;
  End;
End;

Function TOrdProIndMonitoramento.fRetCodFase(intRecNo: Integer): String;
Begin
  If intRecNo > 0 Then
  Begin
    qryFases.RecNo := intRecNo;
    Result         := qryFases.FieldByName('FAS_CODFAS').AsString;
  End

  Else Result := '';
End;

Function TOrdProIndMonitoramento.fCarregaEquipamentos(strCodFas: String): Boolean;
Begin
  Try

    With qryEquipamentos Do
    Begin
      Close;
      ParamByName('CODFAS').AsString := strCodFas;
      Open;

      Result := True;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProIndMonitoramento.fCarregaEquipamentos]');
    End;
  End;
End;

Function TOrdProIndMonitoramento.fTemFaseAnteriorIniciada(strAutOPI,
                      strCodFas: String; Var strFasAnt: String): Boolean;
  Var
    qryFasOPI: TUniQuery;
Begin
  strFasAnt := '';
  qryFasOPI := fCriaQuery;
  With qryFasOPI, SQL Do
  Begin                         // PROCURA A FASE IMEDIATAMENTE ANTERIOR NO CADASTRO
    Add('SELECT ');
    Add('  C.FAS_CODFAS, C.FAS_DESFAS');
    Add('FROM');
    Add('  FASOPI T ');
    Add('INNER JOIN CADFAS C ON C.FAS_CODFAS = T.FAS_CODFAS');
    Add('WHERE');
    Add('  T.FAS_SEQOPI = :SEQOPI AND');
    Add('  C.FAS_SEQFAS < :SEQFAS ');
    Add('ORDER BY C.FAS_SEQFAS DESC LIMIT 1');

    ParamByName('SEQOPI').AsString  := strAutOPI;
    ParamByName('SEQFAS').AsInteger := fCampoTabela('FAS_SEQFAS', 'CADFAS', ['FAS_CODFAS'], [strCodFas]) ;

    Open;

    If IsEmpty Then
    Begin
      Result := True;  // NÃO HÁ FASES ANTERIORES NO CADASTRO PARA ESSA ORDEM DE PRODUÇÃO
    End Else
    Begin
      strFasAnt := FieldByName('FAS_CODFAS').AsString;

      Close;
      Clear;
      Add(' SELECT * FROM MOMORD ');
      Add(' WHERE ');
      Add('   MON_SEQOPI = :SEQOPI AND ');
      Add('   MON_CODFAS = :CODFAS    ');

      ParamByName('SEQOPI').AsString := strAutOPI;
      ParamByName('CODFAS').AsString := strFasAnt;

      Open;

      Result := Not IsEmpty;
    End;

  End;
  FreeAndNil(qryFasOPI);
End;

Function TOrdProIndMonitoramento.fIniciaOperacao(strAutOPI,
                                                 strOpeIni,
                                                 strCodFas,
                                                 strCodEqp: String): Boolean;
  Var
    strFasAnt: String;
Begin
  Try
    If fCarregaMonitoramento(strAutOPI, strCodFas, strCodEqp) Then
    Begin
      Result := False;

      If Not FieldByName('MON_DTAFIN').IsNull Then
      Begin

        If fEmptyStr(strCodEqp) Then
          pMensagemOk('Essa Fase já foi iniciada e finalizada!')
        Else
          pMensagemOk('Essa Fase já foi iniciada e finalizada para esse equipamento!');

      End Else
      Begin

        If fEmptyStr(strCodEqp) Then
          pMensagemOk('Essa Fase já foi iniciada!')
        Else
          pMensagemOk('Essa Fase já foi iniciada para esse equipamento!');

      End;

    End

    Else If Not fTemFaseAnteriorIniciada(strAutOPI, strCodFas, strFasAnt) Then
    Begin
      Result := False;
      pMensagemOk('Ainda não foi iniciada a produção da fase antetior (' +  strFasAnt + '-' +
                   fRetDescricaoFase(strFasAnt) + ') !');
    End Else

    Begin
      Insert;
      FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('MOMORD', VS_strCodEmp);
      FieldByName('MON_SEQOPI').AsString   := strAutOPI;
      FieldByName('MON_CODFAS').AsString   := strCodFas;

      If Not fEmptyStr(strCodEqp) Then
        FieldByName('MON_CODEQP').AsString := strCodEqp;

      FieldByName('MON_OPEINI').AsString   := strOpeIni;
      FieldByName('MON_DTAINI').AsDateTime := VS_Date;
      FieldByName('MON_HORINI').AsDateTime := fTime();
      Post;
      Result := fSalva;

      EmptyDataSet;
      strIncOPI := '';
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProIndMonitoramento.fIniciaOperacao]');
    End;
  End;
End;

Function TOrdProIndMonitoramento.fFinalizaOperacao(strAutOPI,
                                                   strOpeFin,
                                                   strCodFas,
                                                   strCodEqp: String): Boolean;
Begin
  Try
    Result := False;

    If fCarregaMonitoramento(strAutOPI, strCodFas, strCodEqp) Then
    Begin

      If Not FieldByName('MON_DTAFIN').IsNull Then
      Begin
        pMensagemOk('Essa Fase já foi finalizada para esse equipamento!');
      End Else
      Begin
        Edit;
        FieldByName('MON_OPEFIN').AsString   := strOpeFin;
        FieldByName('MON_DTAFIN').AsDateTime := VS_Date;
        FieldByName('MON_HORFIN').AsDateTime := fTime();
        Post;

        Result := fSalva;

        If Result Then
        Begin
          EmptyDataSet;
          strIncOPI := '';
        End;
      End;

    End Else
    Begin
      pMensagemOk('Essa Fase ainda não foi iniciada para esse Equipamento!');
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProIndMonitoramento.fFinalizaOperacao]');
    End;
  End;
End;

Function TOrdProIndMonitoramento.fCarregaMonitoramento(strAutOPI,
                                                       strCodFas,
                                                       strCodEqp: String): Boolean;
Begin
  Try

    With qryQuery Do
    Begin
      SQL.Text := fSQLMonitoramento(strCodEQP);

      ParamByName('SEQOPI').AsString := strAutOPI;
      ParamByName('CODFAS').AsString := strCodFas;

      If Not fEmptyStr(strCodEqp) Then
        ParamByName('CODEQP').AsString := strCodEqp;

      Result := fAbreClient(True) And (Not Self.IsEmpty);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProIndMonitoramento.fCarregaMonitoramento]');
    End;
  End;
End;

Function TOrdProIndMonitoramento.fCarregaOperacoes: Boolean;
Begin
  With cdsOperacoes, qryQuery Do
  Begin
    ParamByName('SEQOPI').AsString := strIncOPI;

    Result := fAbreClient(True);

    If Result Then
    Begin
      pAlinhaCampoCentro('MON_OPEINI');
      pAlinhaCampoCentro('MON_DTAINI');
      pAlinhaCampoCentro('MON_HORINI');
      pAlinhaCampoCentro('MON_DTAFIN');
      pAlinhaCampoCentro('MON_HORFIN');
    End;

  End;
End;

Function TOrdProIndMonitoramento.fTemFasePosteriorIniciada(strAutOPI,
                          strCodFas: String; Var strFasPos: String): Boolean;
  Var
    qryFasOPI: TUniQuery;
Begin
  strFasPos := '';
  qryFasOPI := fCriaQuery;
  With qryFasOPI, SQL Do
  Begin
    Clear;
    Add('SELECT C.FAS_CODFAS FROM MOMORD T');
    Add('INNER JOIN CADFAS C ON C.FAS_CODFAS = T.MON_CODFAS');
    Add('WHERE ');
    Add('  T.MON_SEQOPI = :SEQOPI AND ');
    Add('  C.FAS_SEQFAS > :SEQFAS     ');

    ParamByName('SEQOPI').AsString  := strAutOPI;
    ParamByName('SEQFAS').AsInteger := fCampoTabela('FAS_SEQFAS', 'CADFAS', ['FAS_CODFAS'], [strCodFas]) ;;

    Open;

    Result := Not IsEmpty;

    If Result Then
      strFasPos := FieldByName('FAS_CODFAS').AsString;

  End;
  FreeAndNil(qryFasOPI);
End;

Function TOrdProIndMonitoramento.fCancelaOperacao(strAutInc, strCodOPI, strCodFas: String; dtaDtaFin: TDateTime): Boolean;
  Var
    qryMonOrd: TUniQuery;
    strFasPos: String;
Begin
  Try
    qryMonOrd := fCriaQuery;
    With qryMonOrd, SQL Do
    Begin

      If dtaDtaFin > 0 Then
      Begin

        If fPedeSenha(strAutInc) Then
        Begin
          Clear;
          Add('UPDATE MOMORD SET ');
          Add('  MON_DTAFIN = (NULL), ');
          Add('  MON_HORFIN = (NULL), ');
          Add('  MON_OPEFIN = (NULL)  ');
          Add('WHERE ');
          Add('  AUTOINCREM = :AUTINC ');

          ParamByName('AUTINC').AsString := strAutInc;

          ExecSQL;

          Result := True;
        End

        Else Result := False;

      End

      Else If fTemFasePosteriorIniciada(strCodOPI, strCodFas, strFasPos) Then
      Begin
        Result := False;
        pMensagemOk('A Fase posterior (' +  strFasPos + '-' + fRetDescricaoFase(strFasPos) +
                    ') já foi iniciada e deve ser cancelada primeiro!');

      End Else
      Begin

        If fPedeSenha(strAutInc) Then
        Begin
          Clear;
          Add('DELETE FROM MOMORD     ');
          Add('WHERE ');
          Add('  AUTOINCREM = :AUTINC ');

          ParamByName('AUTINC').AsString := strAutInc;

          ExecSQL;

          Result := True;
        End

        Else Result := False;

      End;

    End;

    FreeAndNil(qryMonOrd);
  Except
    on E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProIndMonitoramento.fCancelaOperacao]');
    End;
  End;
End;

{
         .------------------------------------------------------------------------------------------------------------.
         |                CANCELAMENTO DAS INFORMACOES DE MONITORAMENTO DE PROCESSOS DE PRODUCAO                      |
         |------------------------------------------------------------------------------------------------------------|
         | Produto: MASSA ACRILICA EMB METALICA ALESSI                   Volume(LT): 999.999,999                      |
         | OP-001 13/01/2015          MASSA ACRILIA BRANCO RN            Lote: 130115-001                             |
         |------------------------------------------------------------------------------------------------------------|
         | FASE                       | EQUIPAMENTO             | OPE | INICIO DO PROCESSO    | FINAL DO PROCESSO     |
         |------------------------------------------------------------------------------------------------------------|
         | TANQUE DE DISPERSAO        | TANQUE 10000L           | A01 | 13/01/2015 | 15:12:33 | 13/01/2015 | 15:48:21 |
         | SEPARACAO DA MATERIA PRIMA |                         | A09 | 13/01/2015 | 17:05:00 |*14/01/2015 | 09:25:01*|
         | DISPERSAO                  | TANQUE DE DISPERSAO     | A09 | 14/01/2015 | 10:05:00 |            |          |
         | ANALISE LABORATORIO 1      |                         | A27 | 14/01/2015 | 13:12:20 |            |          |
         .------------------------------------------------------------------------------------------------------------.
         (*) Indica o cancelamento que o operador esta´ solicitando liberacao.
}

Procedure TOrdProIndMonitoramento.pMontaMensagemTrava(strAutInc: String);
  Var
    intRecNo: Integer;
    objTabela : TRegistroMsgLiberaTabela;
   	objLinha  : TLinhaMsgLibera;
    strAux :String;
Begin
  With cdsOperacoes Do
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('CANCELAMENTO DAS INFORMACOES DE MONITORAMENTO DE PROCESSOS DE PRODUCAO', alCentro, teAmbos, '', 112);
    objLiberacao.objMsgLibera.pAddSeparador(112);

    objLiberacao.objMsgLibera.pAddTextoCaption('Produto'    ,cdsCabIpr.FieldByName('DESITE').AsString);
    objLiberacao.objMsgLibera.pAddTextoCaption('Volume(LT)' , FormatFloat('#,00#0.00', fltVolume));

    objLiberacao.objMsgLibera.pAddTexto(cdsCabIpr.FieldByName('NUMOPE').AsString);
    objLiberacao.objMsgLibera.pAddTexto(Copy(cdsCabIpr.FieldByName('DESETI').AsString, 1, 112));
    objLiberacao.objMsgLibera.pAddTextoCaption('Lote',cdsCabIpr.FieldByName('NUMLOT').AsString);

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'FASE'               , 26 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'EQUIPAMENTO'        , 23 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'OPE'                , 4  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'INICIO DO PROCESSO' , 24 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'FINAL DO PROCESSO'  , 24 , alEsquerda  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    DisableControls;
    intRecNo := RecNo;
    First;

    While Not Eof Do
    Begin
      If FieldByName('MON_DTAFIN').IsNull And (strAutInc = FieldByName('AUTOINCREM').AsString) Then
        strAux := '*'
      else
        strAux := '';

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('FASE'                   , FieldByName('FAS_DESFAS').AsString , 26 , alEsquerda );
      objLinha.pAddColuna('EQUIPAMENTO'            , FieldByName('EQP_DESCRI').AsString , 23 , alEsquerda );
      objLinha.pAddColuna('OPE'                    , FieldByName('MON_OPEINI').AsString , 4  , alCentro   );
      objLinha.pAddColuna('DT. INICIO DO PROCESSO' , strAux + FormatDateTime('DD/MM/YYYY', FieldByName('MON_DTAINI').AsDateTime) , 12 , alEsquerda );
      objLinha.pAddColuna('HR. INICIO DO PROCESSO' , FormatDateTime('HH:NN:SS',   FieldByName('MON_HORINI').AsDateTime) + strAux , 10 , alEsquerda );

      If FieldByName('MON_DTAFIN').IsNull Then
      begin
        objLinha.pAddColuna('DT. FINAL DO PROCESSO'  , '' , 12 , alEsquerda );
        objLinha.pAddColuna('HR. FINAL DO PROCESSO'  , '' , 10 , alEsquerda );
      end
      else
      begin
        If (strAutInc = FieldByName('AUTOINCREM').AsString) Then
          strAux := '*'
        else
          strAux := '';

        objLinha.pAddColuna('DT. FINAL DO PROCESSO'  , strAux + FormatDateTime('DD/MM/YYYY', FieldByName('MON_DTAFIN').AsDateTime) , 12 , alEsquerda );
        objLinha.pAddColuna('HR. FINAL DO PROCESSO'  , FormatDateTime('HH:NN:SS',   FieldByName('MON_HORFIN').AsDateTime) + strAux , 10 , alEsquerda );
      end;
      objTabela.lstLinhas.Add(objLinha);

      Next;
    End;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    objLiberacao.objMsgLibera.pAddTexto('(*) Indica o cancelamento que o operador esta´ solicitando liberacao.');

    RecNo := intRecNo;
    EnableControls;
  End;
End;

Function TOrdProIndMonitoramento.fPedeSenha(strAutInc: String): Boolean;
Begin
  pMontaMensagemTrava(strAutInc);

  objLiberacao.strDirAce := 'LIBOPEORD';
  objLiberacao.strMsgSen := 'CANCELAMENTO DE OPERAÇÃO DA ORDEM DE PRODUÇÃO';
  objLiberacao.blnMosMen := True;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;
  objLiberacao.blnUsarSenhaFixa := False;
  objLiberacao.blnSempreVariavelUsuario := True;
  objLiberacao.tipCliFor := cfFornecedor;


  Result := objLiberacao.fLibera;

End;

Function TOrdProIndMonitoramento.fSQLPosicaoOperacoes: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL +  ' SELECT ';
  strSQL := strSQL +  '   MON_DTAINI, ';
  strSQL := strSQL +  '   MON_HORINI, ';
  strSQL := strSQL +  '   MON_DTAFIN, ';
  strSQL := strSQL +  '   MON_HORFIN, ';
  strSQL := strSQL +  '   MON_OPEINI, ';

  strSQL := strSQL +  '   IF(MON_DTAINI IS NULL, "S", "N") AS SEMINI, ';
  strSQL := strSQL +  '   IF(MON_DTAFIN IS NULL, "S", "N") AS SEMFIN, ';

  strSQL := strSQL +  '   F.FAS_DESFAS AS FAS_DESFAS, ';
  strSQL := strSQL +  '   F.FAS_SEQFAS AS FAS_SEQFAS, ';
  strSQL := strSQL +  '   E.EQP_DESCRI AS EQP_DESCRI ';
  strSQL := strSQL +  ' FROM ';
  strSQL := strSQL +  '   FASOPI T ';
  strSQL := strSQL +  '   INNER JOIN CADFAS F ON F.FAS_CODFAS = T.FAS_CODFAS ';
  strSQL := strSQL +  '   LEFT JOIN MOMORD M ON M.MON_SEQOPI = T.FAS_SEQOPI AND M.MON_CODFAS = T.FAS_CODFAS ';
  strSQL := strSQL +  '   LEFT JOIN CADEQP E ON E.EQP_CODEQP = MON_CODEQP ';
  strSQL := strSQL +  ' WHERE ';
  strSQL := strSQL +  '   T.FAS_SEQOPI = :SEQOPI ';
  strSQL := strSQL +  ' ORDER BY ';
  strSQL := strSQL +  '   F.FAS_SEQFAS, MON_DTAINI, MON_HORINI  ';

  Result := strSQL;
End;

Function TOrdProIndMonitoramento.fOPFinalizada(strAutInc: String;
            Var strMsg: String): Boolean;
Begin
  Try
    strMsg := '';

    With qryMonOPI Do
    Begin
      Close;

      SQL.Text := fSQLPosicaoOperacoes;

      ParamByName('SEQOPI').AsString := strAutInc;

      Open;

      If Locate('SEMFIN', 'S', []) Then
      Begin
        Result := False;
        strMsg := 'Há Fases não finalizadas para essa ordem de produção!';
      End

      Else If Locate('SEMINI', 'S', []) Then
      Begin
        Result := False;
        strMsg := 'Há Fases não iniciadas para essa ordem de produção!';
      End

      Else Result := True;

    End;

  Except
    on E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TOrdProIndMonitoramento.fOPFinalizada]');
    End;
  End;
End;

Function TOrdProIndMonitoramento.fTemOperacaoIniciada(strAutInc: String): Boolean;
  Var
    qryMonOPI: TUniQuery;
Begin
  qryMonOPI := fCriaQuery;
  With qryMonOPI, SQL Do
  Begin
    Add('SELECT * FROM MOMORD');
    Add('WHERE');
    Add('  MON_SEQOPI = :AUTINC');

    ParamByName('AUTINC').AsString := strAutInc;

    Open;

    Result := Not IsEmpty;
  End;
  FreeAndNil(qryMonOPI)
End;

Class Function TOrdProIndMonitoramento.fTemOperacaoIniciadaDeOPAberta(strCodFas: String = ''): Boolean;
  Var
    qryMonOPI: TUniQuery;
Begin
  qryMonOPI := fCriaQuery;
  With qryMonOPI, SQL Do
  Begin
    Add('SELECT COUNT(*) AS QTDREG FROM MOMORD M ');
    Add('INNER JOIN ORDGER G ON G.AUTOINCREM = M.MON_SEQOPI');
    Add('WHERE');
    Add('  G.ORD_DTABAI IS NULL');

    If Not fEmptyStr(strCodFas) Then
    Begin
      Add('  AND MON_CODFAS = :CODFAS');
      ParamByName('CODFAS').AsString := strCodFas;
    End;

    Open;

    Result := FieldByName('QTDREG').AsInteger > 0;
  End;
  FreeAndNil(qryMonOPI)
End;

end.
