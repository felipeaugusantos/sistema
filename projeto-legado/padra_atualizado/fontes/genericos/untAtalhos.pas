unit untAtalhos;

interface

Procedure pDesabilitaAtalhos;
Procedure pHabilitaAtalhos;
procedure pControlaTeclado;
procedure pLiberaTeclado;

Procedure pMenuFiscal;

implementation

Uses
  SysUtils,
  Windows,
  untModulo,
  untFuncoesSimples;

Var
  blnAtalhos: Boolean;
  hooTeclado : hHook;
  wpaTeclaAnt: WPARAM;

Procedure pMenuFiscal;
Begin
//  If (Not Assigned(frmMenuFiscal)) And (Not VS_blnCupomAberto) And (VS_strUsaPaf = 'S') And (Not fCfgSis('PAFECF', varBoolean)) Then
//  Begin
//    Try
//      pCriarFormularios(TfrmMenuFiscal,frmMenuFiscal);
//      frmMenuFiscal.ShowModal;
//    Except
//      On E: Exception do
//        pErro(E.Message);
//    End;
//    pFreeAndNil(frmMenuFiscal);
//    frmMenuFiscal := Nil;
//  End;
End;

Function KeyboardProc(intCode: Integer; wpaParam: WPARAM; lpaParam: LPARAM): Lresult; stdcall;
  Const
    TECLA_CTRL = 17;
  Var
    blnHandled: Boolean;
    kbsKeyState: TKeyboardState;
Begin
  blnHandled := False;
  Result := 1;
  If intCode = HC_ACTION then
  Begin
    GetKeyboardState(kbsKeyState);

    If blnAtalhos And (Not frmModulo.GetCurrentConnection.InTransaction) And (kbsKeyState[wpaParam] and $80 <> 0) Then
    Begin
      Case wpaParam of
        VK_F12: If wpaTeclaAnt = TECLA_CTRL Then
                Begin
                  blnHandled := True;
                  pMenuFiscal;
                End;

        Else    blnHandled := False;
      End;
    End;

  End;

  wpaTeclaAnt := wpaParam;

  If Not blnHandled Then
    Result := CallNextHookEx(hooTeclado, intCode, wpaParam, lpaParam);
end;

procedure pControlaTeclado;
begin
  pDesabilitaAtalhos;
  hooTeclado := SetWindowsHookEx(WH_KEYBOARD,
                                 @KeyboardProc,
                                 HInstance,
                                 GetCurrentThreadId());

end;

procedure pLiberaTeclado;
Begin
  UnhookWindowsHookEx(hooTeclado);
End;

Procedure pDesabilitaAtalhos;
Begin
  blnAtalhos := FALSE;
End;

Procedure pHabilitaAtalhos;
Begin
  blnAtalhos := TRUE;
End;

End.


