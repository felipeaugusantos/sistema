unit untProcessaPitStop;

interface

uses
  Winapi.Windows, Forms, System.Classes, System.SysUtils, Dialogs, Winapi.Messages,
  System.UITypes;

  procedure pIniciaProcessoPitStop;

implementation

uses
  untFuncoesSimples, untUtilMonitor, untLogAut, untBuscaCotacaoPitStop,
  PitStop.Comunicacao;

function fEncerrarSemExecutar:Boolean;
begin  
  Result := False;

  If (fConexaoAtiva) Then
    If (fCfgSis('LXRBSL', varString) = 'S') Then
      Result := True;
end;

procedure pMensagemErroLocal(strMessage: String);
begin
  If (fConexaoAtiva) Then
    pMensagensErro(strMessage,'')
  Else
    MessageDlg(strMessage, mtError, [mbOK], 0);
end;

procedure pIniciaProcessoPitStop;
var
  BuscaCotacaoPitStop: TBuscaCotacaoPitStop;
begin


  Try
    Try
      pDefinirEmpresa;
      pConectarModulos;
      pDefinirUsuario;
      pIniciarVariaveis;
      fAjustaDataSistema;
    Except
      On E: Exception Do
      Begin
        pMensagemErroLocal(E.Message);
        Exit;
      End;
    End;

    If (fEncerrarSemExecutar) Then
      Exit;

    Try
      TLogAut.New().pLogin();

      BuscaCotacaoPitStop := TBuscaCotacaoPitStop.Create;
      Try
        BuscaCotacaoPitStop.processaRetorno;
        If UpperCase(ParamStr(3)) = 'TRUE' Then
          BuscaCotacaoPitStop.pIniciaProcessosQuePerderamConexao;

      Finally
        FreeAndNil(BuscaCotacaoPitStop);
      End


    Finally
//      TUtilMonitor.fRemoveLockMonitor(spIdMonitorAudit);
      TLogAut.New().pLogout();
      pFinalizarModulos;
    End;

  Finally
    If Not TerminateProcess(GetCurrentProcess, 0) Then
      Application.Terminate;
  End;

end;

end.
