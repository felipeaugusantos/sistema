unit untCfgRel;

interface

  uses Uni, Registry, Windows, Data.DB;

  procedure pCarregaConfImpr(Var   qryCfgRel   : TUniQuery;
                             Const strNomeForm : String;
                                   strCodEmp   : String = '';
                                   strNomeFila : String = '');

  function fObtemVariavelAmbiente(const strNome: String): String;
  function fGetImpPadraoWindows: String;
  procedure pSetPrinter(strNomImp: String);

  function fPreImpressao(    qryCfgRel   : TUniQuery;
                         Var strNomeFila : String;
                         Var strTipImp   : String;
                             blnLocal    : Boolean;
                             strDirImp   : String = '';
                             blnPedTipImp: boolean = True ): Boolean;

  function fPerguntaTipo(qryCfgRel: TUniQuery): Boolean;

  Var
    strNomFormTmp : String;

implementation

uses SysUtils, StrUtils, Printers, untTypesSistema, untFuncoesSimples;

procedure pCarregaConfImpr(Var   qryCfgRel   : TUniQuery;
                           Const strNomeForm : String;
                                 strCodEmp   : String = '';
                                 strNomeFila : String = '');
  Var
    strSQL: String;
begin

  strNomFormTmp := strNomeForm;

  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CFGREL ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  REL_NOMPRO = :NOMPRO AND ';
  strSQL := strSQL + '  REL_CODEMP = :CODEMP ';

  If Not fEmptyStr(strNomeFila) Then
    strSQL := strSQL + '  AND REL_NOMFIL = :NOMFIL ';

  With qryCfgRel Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NOMPRO').AsString := strNomeForm;
    ParamByName('CODEMP').AsString := strCodEmp;

    If Not fEmptyStr(strNomeFila) Then
      ParamByName('NOMFIL').AsString := strNomeFila;

    Open;
  End;

End;

function fObtemVariavelAmbiente(const strNome: String): String;
Begin
  With TRegistry.Create do
    Try
      RootKey := HKEY_CURRENT_USER;
      OpenKey('Environment', False);
      Result := ReadString(strNome);
    Finally
      Free
    End;
End;

function fGetImpPadraoWindows: String;
  Var
    Device: Array[0..255] Of Char;
    Driver: Array[0..255] Of Char;
    Port  : Array[0..255] Of Char;
    Handle: THandle;
begin
  try
    Printer.PrinterIndex := -1;
  except
    On E: Exception Do
    Begin
      If E.Message = 'System Error.  Code: 1722.'#$D#$A'O servidor RPC não está disponível' Then
      Begin
        fMensagem('','Spooler de Impressão do Windows não está iniciado ou está com erro. É necessário reiniciá-lo em Serviços do Windows.' ,['&OK']);
        Exit;
      End;
    End;
  end;

  Printer.GetPrinter(Device, Driver, Port, Handle);

  Result := Device;
end;

procedure pSetPrinter(strNomImp: String);
  Var
    buffer1 : Array[0..250] Of Char;
    buffer2 : Array[0..250] Of Char;
    buffer3 : Array[0..250] Of Char;
    ADevice, ADriver, APort : PChar;
    hDm :  THandle;
begin
  ADevice := buffer1;
  ADriver := buffer2;
  APort   := buffer3;
  Printer.GetPrinter(ADevice, ADriver, APort, hDm);
  printer.SetPrinter(PChar(strNomImp), ADriver, APort, hDm);
end;

function fPreImpressao(    qryCfgRel   : TUniQuery;
                       Var strNomeFila : String;
                       Var strTipImp   : String;
                           blnLocal    : Boolean;
                           strDirImp   : String = '';
                           blnPedTipImp: boolean = True ): Boolean;
  Var
    blnMostraFila: Boolean;
    intContador  : Integer;
    strNomFilTmp : String;

    {*****************************************}
    {* VARIAVEIS DE IMPRESSORA DEFAULT       *}
    {**************************************AF*}
    Device: Array[0..255] Of Char;
    Driver: Array[0..255] Of Char;
    Port  : Array[0..255] Of Char;
    Handle: THandle;
begin
  blnMostraFila := True;
  VS_blnDlgPri  := True;

  Result := True;

  Printer.Refresh;

  Try
    Printer.GetPrinter(Device, Driver, Port, Handle);
  Except
    On E: Exception Do
    Begin
      {*******************************************}
      {* TRATAMENTO QUANDO SPOOLER ESTIVER PARADO*}
      {* System Error.  Code: 1722.              *}
      {* O servidor RPC não está disponível.     *}
      {****************************************NC*}
      If Printer.Printers.Count = 0 Then
      Begin
        WinExec(PAnsiChar('cmd /c net start spooler'), SW_HIDE);
        Sleep(5000);
        Printer.Refresh;

        If Printer.Printers.Count <= 0 Then
        Begin
          If E.Message = 'System Error.  Code: 1722.'#$D#$A'O servidor RPC não está disponível' Then
          Begin
            fMensagem('','Spooler de Impressão do Windows não está iniciado ou está com erro. É necessário reiniciá-lo em Serviços do Windows.' ,['&OK']);
            Result := False;
            Exit;
          End;
        End;
      End;

      Try
        Printer.PrinterIndex := -1;
      Except
        On E: Exception Do
        Begin
          If E.Message = 'System Error.  Code: 1722.'#$D#$A'O servidor RPC não está disponível' Then
          Begin
            fMensagem('','Spooler de Impressão do Windows não está iniciado ou está com erro. É necessário reiniciá-lo em Serviços do Windows.' ,['&OK']);
            Result := False;
            Exit;
          End;
        End;
      End;
      Printer.GetPrinter(Device, Driver, Port, Handle);
    End;
  End;

  strNomFilTmp := fObtemVariavelAmbiente(strNomFormTmp);

  If (Not fEmptyStr(qryCfgRel.FieldByName('REL_NOMFIL').AsString)) Or
     (Not fEmptyStr(strNomFilTmp)) Then
  Begin
    blnMostraFila := False;
  End;

  If ((blnMostraFila) Or (blnLocal)) And (Result) Then
  Begin

    If qryCfgRel.FieldByName('REL_IMPPAD').AsString = 'S' Then
    Begin
      //Carrega a Impressora Padrao do Windows
      strNomeFila  := fGetImpPadraoWindows();

      If fEmptyStr(strNomeFila) Then
      Begin
        fMensagem('','Relatório está configurado para utilizar impressora padrão do Windows e '+
                     'não existe uma impressora padrão definida. É necessário definir uma impressora padrão '+
                     'em Disposistivos e Impressoras.' ,['&OK']);
        Result := False;
        Exit;
      End;
      pSetPrinter(strNomeFila);
      VS_blnDlgPri := False;
    End;

    If (Pos(strDirImp, 'V_E_G_') > 0) Then
    Begin
      VS_blnDlgPri := False;
    End
    Else If (qryCfgRel.FieldByName('REL_IMPPAD').AsString = 'N') Or (qryCfgRel.FieldByName('REL_IMPPAD').AsString = '') Then
    Begin
        If fEmptyStr(strNomeFila) Then
        Begin
          Result := False;
          Exit;
        End
        Else
        Begin
          pSetPrinter(strNomeFila);
          VS_blnDlgPri := False;
        End;

    End;

  End
  Else
  Begin
    pRetFilasImpressao(arrFilas);
    strNomeFila := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

    If Not fEmptyStr(strNomFilTmp) Then
      strNomeFila := strNomFilTmp;

    If (Copy(strNomeFila, 1, 2) <> '\\') Then
      strNomeFila := '\\' + fRetNomeRede + '\' + strNomeFila;

    For intContador := 0 To Length(arrFilas) -1 Do
    Begin

      If AnsiLowerCase(LeftStr(arrFilas[intContador].strNomeFila, Length(strNomeFila))) = AnsiLowerCase(strNomeFila) Then
      Begin
        pSetPrinter(AnsiReplaceStr(LeftStr(arrFilas[intContador].strNomeFila, Length(strNomeFila)),'\\' + fRetNomeRede + '\',''));
        VS_blnDlgPri := False;
      End;

    End;

  End;

  strNomeFila := AnsiReplaceStr(strNomeFila,'\\' + fRetNomeRede + '\','');

  if blnPedTipImp then
  begin
    If Not fPerguntaTipo(qryCfgRel) Then
    Begin

      If qryCfgRel.FieldByName('REL_IDEIMP').AsString = 'P' Then
      Begin
        strTipImp := fCfgSis('TIPIMP');
      End
      Else
      Begin
        strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
      End;

    End
    Else
    Begin
      strTipImp := '';
    End;
  end;


end;

function fPerguntaTipo(qryCfgRel: TUniQuery): Boolean;
begin
  Result := True;
  If (fEmptyStr(qryCfgRel.FieldByName('REL_PERGUN').AsString)) Or
     (qryCfgRel.FieldByName('REL_PERGUN').AsString = 'N')      Then
  Begin
    Result := False;
  End;
end;

end.
