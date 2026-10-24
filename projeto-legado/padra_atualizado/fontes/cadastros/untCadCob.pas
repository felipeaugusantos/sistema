unit untCadCob;

interface

uses
  Classes, Uni, UniClientDataSet, Data.Db;

  function fGravaCadCob(Var strAutInc: String;
                        strCodEmp: String;
                        dtaDtaLan,
                        tmrHorLan,
                        dtaDtaAge,
                        dtaDtaRel: TDateTime;
                        strBaixad,
                        strCodCli,
                        strHisCob: String;
                        cdsInfCob: TUniClientDataSet = Nil;
                        blnVeioMostraDebCtrChq2 : Boolean = False;
                        cdsDupcob: TUniClientDataSet = Nil;
                        strCodCac : String = '' ): Boolean;

  function fRetornaUltHisCob(strCodCli : String): String;

  procedure pGravaDupCob(strAutIncCadCob,
                         strCodEmp: String;
                         cdsInfCob: TUniClientDataSet = Nil);

  procedure pGravaHisCadRec(cdsInfCob: TUniClientDataSet = Nil; strHisCob : String = '');
  function fBuscaHistoricoAnterior(cdsInfCob: TUniClientDataSet = Nil; strHisCob : String = '') : String;

implementation

uses SysUtils, Variants, Forms, untfuncoesSimples;

function fGravaCadCob(var strAutInc: String;
                      strCodEmp: String;
                      dtaDtaLan,
                      tmrHorLan,
                      dtaDtaAge,
                      dtaDtaRel: TDateTime;
                      strBaixad,
                      strCodCli,
                      strHisCob: String;
                      cdsInfCob : TUniClientDataSet = Nil;
                      blnVeioMostraDebCtrChq2 : Boolean = False;
                      cdsDupcob : TUniClientDataSet = Nil;
                      strCodCac : String = '' ): Boolean;
Var
  strNomeTabela : String;
      qryCadCob : TUniQuery;
     cdsAuxDups : TUniClientDataSet;
  strCodCliente : string;
begin
  Result := True;
  strNomeTabela := 'CADCOB';
  Try
    strAutInc := fRetAutoIncrem(strNomeTabela, strCodEmp);
    qryCadCob := fcriarquery('SELECT * FROM CADCOB WHERE FALSE');

    If (cdsDupcob = Nil) Then
    Begin

      With qryCadCob Do
      Begin
        If Not Active Then
          Open;

        Insert;
        FieldByName('AUTOINCREM').AsString := strAutInc;
        FieldByName('COB_CODEMP').AsString := strCodEmp;
        FieldByName('COB_DTALAN').AsDateTime := dtaDtaLan;
        FieldByName('COB_HORLAN').AsDateTime := tmrHorLan;

        If (dtaDtaAge = 0) Then
          FieldByName('COB_DTAAGE').Value := Null
        Else
          FieldByName('COB_DTAAGE').AsDateTime := dtaDtaAge;

        If (dtaDtaRel = 0) Then
          FieldByName('COB_DTAREL').Value := Null
        Else
          FieldByName('COB_DTAREL').AsDateTime := dtaDtaRel;

        FieldByName('COB_BAIXAD').AsString := strBaixad;

        {Gravar o operador que realizou a baixa}
        if UpperCase(strBaixad) = 'S' then
          FieldByName('COB_OPEBAI').AsString := strLoginUsuarioLogado;

        {Gravar o operador que realizou o agendamento}
        FieldByName('COB_CODOPE').AsString := strLoginUsuarioLogado;

        FieldByName('COB_CODCLI').AsString := strCodCli;
        FieldByName('COB_HISCOB').AsString := strHisCob;

        If fEmptyStr(strCodCac) Then
           FieldByName('COB_CODCAC').Value := Null
        Else
           FieldByName('COB_CODCAC').AsString := strCodCac;
        Post;
      End;

     {**********************************************
      *QUANDO UTILIZADO O AGENDAMENTO PELA ROTINA  *
      *CONTAS A RECEBER/CADASTRO DE CHEQUES GRAVAR *
      *AS DUPLICATAS SELECIONADAS NA TABELA DUPCOB *
      *********************REQ:106224************MT*}
      If (blnVeioMostraDebCtrChq2 = True) Then
      Begin
        If Assigned(cdsInfCob) Then
        Begin
          If Not(cdsInfCob.IsEmpty) Then
          Begin
            Try
              pGravaDupCob(strAutInc,
                           strCodEmp,
                           cdsInfCob);

              {** GRAVAR HISTORICO DE COBRANÇA *****
               ** NO CAMPO HISTORICO DA CADREC *KM *}
              pGravaHisCadRec(cdsInfCob,
                              strHisCob);

            Finally
              FreeAndNil(cdsInfCob);
            End;
          End;
         End;
      End;

    End
    Else
    Begin

      If Not qryCadCob.Active Then
         qryCadCob.Open;

      cdsInfCob.First;
      While Not cdsInfCob.Eof Do
      Begin
          strAutInc     := fRetAutoIncrem(strNomeTabela, strCodEmp);
          strCodCliente := cdsInfCob.FieldByName('CTR_CODCLI').AsString;
          With qryCadCob Do
          Begin

            Insert;
            FieldByName('AUTOINCREM').AsString := strAutInc;
            FieldByName('COB_CODEMP').AsString := strCodEmp;
            FieldByName('COB_DTALAN').AsDateTime := dtaDtaLan;
            FieldByName('COB_HORLAN').AsDateTime := tmrHorLan;

            If (dtaDtaAge = 0) Then
              FieldByName('COB_DTAAGE').Value := Null
            Else
              FieldByName('COB_DTAAGE').AsDateTime := dtaDtaAge;

            If (dtaDtaRel = 0) Then
              FieldByName('COB_DTAREL').Value := Null
            Else
              FieldByName('COB_DTAREL').AsDateTime := dtaDtaRel;

            FieldByName('COB_BAIXAD').AsString := strBaixad;

            {Gravar o operador que realizou a baixa}
            if UpperCase(strBaixad) = 'S' then
              FieldByName('COB_OPEBAI').AsString := strLoginUsuarioLogado;

            {Gravar o operador que realizou o agendamento}
            FieldByName('COB_CODOPE').AsString := strLoginUsuarioLogado;

            FieldByName('COB_CODCLI').AsString := strCodCliente;

            If UpperCase(strBaixad) = 'S' then
              strHisCob :=  strHisCob+ ' ' +fRetornaUltHisCob(strCodCliente);

            FieldByName('COB_HISCOB').AsString := strHisCob;
            Post;
          End;

          // GRAVA DUPCOB REFERENTE AO CLIENTE SELECIONADO
          If (Not cdsDupcob.IsEmpty) Then
          Begin
             Try
                cdsAuxDups := TUniClientDataSet.Create(Nil);
                pCloneDataSet(cdsAuxDups, cdsDupcob);

                cdsAuxDups.Filtered := False;
                cdsAuxDups.Filter   := 'CTR_CODCLI = ' + QuotedStr(strCodCliente);
                cdsAuxDups.Filtered := True;

                If Not(cdsAuxDups.IsEmpty) Then
                Begin
                   pGravaDupCob(strAutInc,
                                strCodEmp,
                                cdsAuxDups);

                  {** GRAVAR HISTORICO DE COBRANÇA *****
                   ** NO CAMPO HISTORICO DA CADREC *KM *}
                  pGravaHisCadRec(cdsAuxDups,
                                  strHisCob);
                End;
             Finally
                FreeAndNil(cdsAuxDups);
             End;
          End;

          cdsInfCob.Next;
      End;

    End;

  Except
    On E: Exception Do
    Begin
      qryCadCob.Cancel;
      pMensagensErro(E.Message, '[fGravaCadCob]');
      Result := False;
    End;
  End;
  FreeAndNil(qryCadCob);
end;


Function fRetornaUltHisCob(strCodCli : String): String;
  Var
  qryAux : TUniQuery;
  strSQL : String;
  begin
    strSQL :=   '  SELECT COB_HISCOB AS HISCOB                      	  '+
                '  FROM CADCOB                                          '+
                '  JOIN CADCLI ON COB_CODCLI = CLI_CODCLI               '+
                '  JOIN CADOPE ON COB_CODOPE = OPE_CODOPE               '+
                '  WHERE COB_BAIXAD = "N"                               '+
                '  AND COB_CODCLI = :CODCLI                             '+
                '  ORDER BY CLI_NOMCLI,                                 '+
                '  COB_DTALAN DESC,                                     '+
                '  CADCOB.AUTOINCREM                                    ';

    qryAux := fCriaQuery();
    Try
      qryAux.Close;
      qryAux.SQl.Text := strSQL;
      qryAux.ParamByName('CODCLI').AsString := strCodCli;
      qryAux.Open;

	    Result := qryAux.FieldByName('HISCOB').AsString ;

    Finally
      FreeAndNil(qryAux);
    End;
  end;

procedure pGravaDupCob(strAutIncCadCob,
                       strCodEmp: String;
                       cdsInfCob: TUniClientDataSet = Nil);
Var
  qryDupCob: TUniQuery;
  strAutIncDupCob: String;
Begin
  Try
    qryDupCob := fcriarquery('SELECT * FROM DUPCOB WHERE FALSE');
    With qryDupCob do
    Begin
      If Not Active Then
      Begin
        Open;
      End;
      cdsInfCob.First;
      While Not cdsInfCob.Eof Do
      Begin
        strAutIncDupCob := fRetAutoIncrem('DUPCOB', strCodEmp);
        Insert;
        FieldByName('DUP_SEQCOB').AsString   := strAutIncCadCob;
        FieldByName('DUP_DTAVEN').AsDateTime := cdsInfCob.FieldByName('CTR_DTAVEN').AsDateTime;
        FieldByName('AUTOINCREM').AsString   := strAutIncDupCob;
        FieldByName('DUP_VALORI').AsFloat    := cdsInfCob.FieldByName('CTR_VALORI').AsFloat;
        FieldByName('DUP_VALCAL').AsFloat    := cdsInfCob.FieldByName('CTR_VALCAL').AsFloat;
        FieldByName('DUP_VALJUR').AsFloat    := cdsInfCob.FieldByName('CTR_VALJUR').AsFloat;
        FieldByName('DUP_SEQDUP').AsString   := cdsInfCob.FieldByName('AUTOINCREM').AsString;
        FieldByName('DUP_CODOPE').AsString   := strLoginUsuarioLogado;
        Application.ProcessMessages;
        Post;
        cdsInfCob.Next;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[pGravaDupCob]');
    End;

  End;
  pFreeAndNil(qryDupCob);
End;


procedure pGravaHisCadRec(cdsInfCob: TUniClientDataSet = Nil; strHisCob : String = '');
{******************************************************************************}
{* GRAVA O HISTORICO DE COBRANÇA NO HISTÓRICO DA CADREC (DUPLICATA A RECEBER) *}
{* CONCATENANDO COM O CONTEÚDO QUE JÁ EXISTE, GRAVADO EM OUTRAS ORIGENS       *}
{***************************************************************KM - REQ 178801}
Var
  qryHisCadRec: TUniQuery;
  strSQL   : String;

begin
  {** SOMENTE SE HISTORICO DE COBRANÇA NÃO FOR VAZIO **}
  if strHisCob <> '' then
  begin
    {** VERIFICANDO A CONFIGURAÇÃO CFG_HISCOB **}
    If fCfgSis('HISCOB', varBoolean)  Then
    begin
      qryHisCadRec := fCriaQuery;
      Try
        strSQL := '';
        strSQL := strSQL + ' UPDATE CADREC '
                         + ' SET CTR_HIST01   = CONCAT(IFNULL(CTR_HIST01,""),:COB_HISCOB)'
                         + ' WHERE AUTOINCREM = :AUTOINCREM ';

        cdsInfCob.First;
        While Not cdsInfCob.Eof Do
        Begin
          With qryHisCadRec Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('COB_HISCOB').AsString := fBuscaHistoricoAnterior(cdsInfCob,strHisCob);
            ParamByName('AUTOINCREM').AsString := cdsInfCob.FieldByName('AUTOINCREM').AsString;
            ExecSQL;
            Close;
          End;
          cdsInfCob.Next;
        End;
      Except
        On E: Exception Do
        Begin
          fRollBack;
          pMensagensErro(E.Message, '[fGravaHisCadRec]');
        End;
      End;
      FreeAndNil(qryHisCadRec);
    end;
  end;
end;


function fBuscaHistoricoAnterior(cdsInfCob: TUniClientDataSet = Nil; strHisCob : String = '') : String;
Var qryHistAnt : TUniQuery;
begin
  {BUSCANDO O HISTORICO GRAVADO PARA TRATAR A CONCATENAÇÃO}
  qryHistAnt := fcriarquery('SELECT CTR_HIST01 FROM CADREC WHERE AUTOINCREM = :AUTOINCREM');
  With qryHistAnt do
  Begin
    Close;
    ParambyName('AUTOINCREM').AsString :=  cdsInfCob.FieldByName('AUTOINCREM').AsString;
    Open;

    if not IsEmpty then
    begin
      if qryHistAnt.FieldByName('CTR_HIST01').AsString <> '' then
        Result := #13#10 + 'REF. INF.COB.: ' + strHisCob
      else
        Result := 'REF. INF.COB.: ' + strHisCob;
    end
    else
      Result := 'REF. INF.COB.: ' + strHisCob;
  End;
end;

end.
