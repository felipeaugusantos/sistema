unit untEnviaImpCheque;

interface

uses SysUtils, DB, untImpCheques;

  procedure pEnviaChequesImpChq(qryChqVis, qryChqPre: TDataset); Overload
  procedure pEnviaChequesImpChq(qryChq: TDataset); Overload
  procedure pImprimeChequeElgin(impCheque: TImpCheques; qryCheque: TDataSet; blnPagar: Boolean = False);

implementation

uses untFuncoesSimples, untConstantes, untTypesSistema;

procedure pEnviaChequesImpChq(qryChqVis, qryChqPre: TDataset);
  Var
    impCheque: TImpCheques;
begin

  Try

    If (qryChqVis.IsEmpty) And (qryChqPre.IsEmpty) Then
      Exit;

    If fMensagem('ATENÇÃO!', 'Deseja realizar a impressão dos cheques?', ['&Sim', '&Não']) = 2 Then
      Exit;

    impCheque := TImpCheques.fCriarImpressora;
    If (Not Assigned(impCheque)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não foi possível carregar as configurações da impressora. Por favor, verifique.', ['&Ok']);
      Exit;
    End;

    If (Not qryChqVis.IsEmpty) Then
    Begin
      qryChqVis.First;
      While (Not qryChqVis.Eof) Do
      Begin
        pImprimeChequeElgin(impCheque, qryChqVis);
        qryChqVis.Next;
      End;
    End;

    If (Not qryChqPre.IsEmpty) Then
    Begin
      qryChqPre.First;
      While (Not qryChqPre.Eof) Do
      Begin
        pImprimeChequeElgin(impCheque, qryChqPre);
        qryChqPre.Next;
      End;
    End;

  Except
    On E: ExceptionAutCom Do
    Begin
      fMensagem('ATENÇÃO!', E.Message, ['&Ok']);
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pEnviaChequesImpChq]');
    End;
  End;

end;

procedure pImprimeChequeElgin(impCheque: TImpCheques; qryCheque: TDataSet; blnPagar: Boolean = False);
  Var
    strMsg: String;
    blnSair: Boolean;
    intRetorno: Integer;
begin
  strMsg := 'Posicione o cheque ' + qryCheque.FieldByName('CHQ_NUMCHQ').AsString + ' ' +
            'do banco ' + qryCheque.FieldByName('CHQ_CODBCO').AsString + '.';

  If fMensagem('ATENÇÃO!', strMsg, ['&Confirmar', 'C&ancelar']) = 2 Then
    Exit;

  impCheque.strNumBco := qryCheque.FieldByName('CHQ_CODBCO').AsString;
  impCheque.strNumChq := qryCheque.FieldByName('CHQ_NUMCHQ').AsString;
  impCheque.dtaDtaChq := qryCheque.FieldByName('CHQ_DTACAD').AsDateTime;

  If blnPagar Then
    impCheque.strNomFav := qryCheque.FieldByName('CHQ_NOMFAV').AsString
  Else
    impCheque.strNomFav := fCadEmp('NOMEMP');

  impCheque.strNomCid := fRetNomCidadeSemOpc(fCadEmp('CODCID'));
  impCheque.fltValChq := qryCheque.FieldByName('CHQ_VALCHQ').AsFloat;

  blnSair := False;
  Repeat

    Try
      impCheque.pImprimirCheque;
      blnSair := True;
    Except
      On E: ExceptionAutCom Do
      Begin
        intRetorno := fMensagem('ATENÇÃO!', E.Message + #13#10 + 'Tentar novamente?', ['&Sim', '&Não']);
        
        If intRetorno = 2 Then
          blnSair := True;
      End;

      On E: Exception Do
      Begin
        Raise;
      End;
    End;

  Until (blnSair);
end;

{*********************************************}
{* SENDO UTILIZADA NA BAIXA DO CONTAS A PAGAR*}
{*******************************************LE}
procedure pEnviaChequesImpChq(qryChq:TDataset);
  Var
    impCheque: TImpCheques;
begin

  Try
    If qryChq.IsEmpty Then
      Exit;

    If fMensagem('ATENÇÃO!', 'Deseja realizar a impressão dos cheques?', ['&Sim', '&Não']) = 2 Then
      Exit;

    impCheque := TImpCheques.fCriarImpressora;
    If (Not Assigned(impCheque)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não foi possível carregar as configurações da impressora. Por favor, verifique.', ['&Ok']);
      Exit;
    End;

    If (Not qryChq.IsEmpty) Then
    Begin
      qryChq.First;
      While (Not qryChq.Eof) Do
      Begin
        pImprimeChequeElgin(impCheque, qryChq, True);
        qryChq.Next;
      End;
    End;

  Except
    On E: ExceptionAutCom Do
    Begin
      fMensagem('ATENÇÃO!', E.Message, ['&Ok']);
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pEnviaChequesImpChqOverload]');
    End;
  End;

end;

end.
