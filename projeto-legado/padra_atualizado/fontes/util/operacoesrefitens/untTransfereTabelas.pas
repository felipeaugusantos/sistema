unit untTransfereTabelas;

interface
{$M+}

Uses
  Uni, SysUtils,
  DB, DBClient, Provider,
  Controls,
  ComCtrls,
  ExtCtrls,
  Classes,
  StrUtils,
  Forms;

Type
  TTransfereTabelas = Class(TObject)
    Private
      FProgresso: TProgressBar;
      FInfo: TPanel;

      Function fSalvaIteger: Boolean;

      Procedure pCopiaTabela(intTabOri, intTabDes: Integer; blnValidaFornecedorPrincipal: Boolean = False);

    Public

      constructor Create(prgProgresso: TProgressBar; pnlInfo: TPanel); Reintroduce;

      Destructor Destroy; override;

      Function fTransferePrecos(intTabOri, intTabDes: Integer; blnValidaFornecedorPrincipal: Boolean = False): Boolean;

    published

  End;

implementation
uses
    untfuncoesSimples;
constructor TTransfereTabelas.Create(prgProgresso: TProgressBar; pnlInfo: TPanel);
Begin
  Inherited Create;

  FProgresso := prgProgresso;
  FInfo      := pnlInfo;

End;

Destructor TTransfereTabelas.Destroy;
Begin
  Inherited;

End;

Function TTransfereTabelas.fSalvaIteger: Boolean;
  Var
    qryIteger: TUniQuery;
Begin
  Try
    qryIteger := fCriaQuery(Nil);

    With qryIteger, SQL Do
    Begin
      Clear;
      Add('CREATE TABLE ITEGER_' + FormatDateTime('YYYYMMDDHHNNSS', fNow()));
      Add('SELECT * FROM ITEGER');
      ExecSQL;
    End;

    FreeAndNil(qryIteger);

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TTransfereTabelas.fSalvaIteger]');
    End;

  End;
End;

Procedure TTransfereTabelas.pCopiaTabela(intTabOri, intTabDes: Integer; blnValidaFornecedorPrincipal: Boolean = False);
  Var
    qryIteger: TUniQuery;
    strTabOri, strTabDes: String;
Begin
  strTabOri := IntToStr(intTabOri);
  strTabDes := IntToStr(intTabDes);
  qryIteger := fCriaQuery(Nil);

  With qryIteger, SQL Do
  Begin
    Clear;
    Add('UPDATE ITEGER');
    If blnValidaFornecedorPrincipal Then
    begin
      Add('  INNER JOIN CADITE C ON C.ITE_CODITE = ITEGER.ITE_CODITE ');
      Add('  INNER JOIN ITEFOR F ON F.ITE_CODTAB = ITEGER.ITE_TABPR' + strTabOri + ' AND F.ITE_CODFOR =  C.ITE_CODFOR AND F.ITE_CODITE = C.ITE_CODITE');
    End;
    Add('SET ');
    Add('  ITE_PREVE' + strTabDes + ' = ITE_PREVE' + strTabOri + ', ');
    Add('  ITE_MARBR' + strTabDes + ' = ITE_MARBR' + strTabOri + ', ');
    Add('  ITE_COMTB' + strTabDes + ' = ITE_COMTB' + strTabOri + ', ');
    Add('  ITE_TABPR' + strTabDes + ' = ITE_TABPR' + strTabOri + '  ');

    ExecSQL;
  End;

  FreeAndNil(qryIteger);
End;

Function TTransfereTabelas.fTransferePrecos(intTabOri, intTabDes: Integer; blnValidaFornecedorPrincipal: Boolean = False): Boolean;
Begin
  Try
    Result := False;

    If intTabOri = intTabDes Then
    Begin
      pMensagemOk('A Tabela Origem deve ser diferente da Tabela Destino!');
      Exit;
    End;

    FInfo.Caption := 'Aguarde. Salvando dados...';
    Application.ProcessMessages;

    Result := fSalvaIteger;

    FInfo.Caption := '';
    Application.ProcessMessages;

    If Result Then
    Begin
      fStartTransaction;
      FInfo.Caption := 'Aguarde. Transferindo dados...';
      Application.ProcessMessages;
      pCopiaTabela(intTabOri, intTabDes);
      fCommit;
      Result := True;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[TTransfereTabelas.fSalvaIteger]');
    End;

  End;

  FInfo.Caption := '';
  Application.ProcessMessages;
End;

end.
