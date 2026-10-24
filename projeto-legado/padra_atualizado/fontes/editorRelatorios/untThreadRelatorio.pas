unit untThreadRelatorio;

interface

Uses
  Classes, SysUtils, Controls, ComCtrls, DB, Uni, UniClientDataSet, untThreadUtils,
  Variants;

Type

  TThreadRelatorio = Class(TSafeThread)
  Private
    FExec: Boolean;

    FDados: TUniQuery;
    FcdsDados: TUniClientDataSet;

  Public
    blnComErro,
    blnTerminou: Boolean;

    strMsgErro: String;

    Constructor Create(qryDados: TUniQuery; cdsDados: TUniClientDataSet; blnExec: Boolean = False);

    Destructor Destroy; override;

    procedure Execute; override;
  End;

implementation

Uses
  untFuncoesSimples;

Constructor TThreadRelatorio.Create(qryDados: TUniQuery; cdsDados: TUniClientDataSet; blnExec: Boolean = False);
Begin
  Try
    strMsgErro := '';
    blnComErro  := False;
    blnTerminou := False;

    inherited Create(True);

    FExec     := blnExec;
    FDados    := qryDados;
    FcdsDados := cdsDados;

  Except
    On E: Exception Do
    Begin

    End;
  End;

End;

Destructor TThreadRelatorio.Destroy;
Begin

  inherited Destroy;
End;

procedure TThreadRelatorio.Execute;
Begin
  pLog('TThreadRelatorio.Execute');

  blnTerminou := False;

  While (Not Terminated) Do
  Begin

    Try
      If FExec Then
        FDados.ExecSQL
      Else
        FDados.Open;

      If Assigned(FcdsDados) Then
      Begin
        pSetaClient(FDados);
        FcdsDados.Open;
      End;

      Break;

    Except
      On E: Exception Do
      Begin
        blnComErro := True;
        strMsgErro := E.Message;
        Break;
      End;
    End;

  End;

  blnTerminou := True;
End;

end.
