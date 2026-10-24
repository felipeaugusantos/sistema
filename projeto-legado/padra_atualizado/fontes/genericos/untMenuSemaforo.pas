unit untMenuSemaforo;

interface

uses UnitProfiler, SysUtils, Windows, Classes, Menus, Uni, DB, StrUtils, Forms, PsAPI;

Type
  // Estrutura estendida de memória do processo (equivalente à API do Windows)
  PROCESS_MEMORY_COUNTERS_EX = record
    cb: DWORD;                          // Tamanho da estrutura em bytes (obrigatório preencher antes da chamada)
    PageFaultCount: DWORD;              // Quantidade total de page faults desde o início do processo (Inclui soft + hard faults, é acumulativo)
    PeakWorkingSetSize: SIZE_T;         // Maior valor já atingido pelo Working Set (pico de RAM usada)
    WorkingSetSize: SIZE_T;             // Memória atualmente na RAM (Working Set) (Inclui memória privada + compartilhada (DLLs, etc))
    QuotaPeakPagedPoolUsage: SIZE_T;    // Pico de uso do pool paginado do kernel (uso interno do Windows)
    QuotaPagedPoolUsage: SIZE_T;        // Uso atual do pool paginado do kernel
    QuotaPeakNonPagedPoolUsage: SIZE_T; // Pico do pool não paginado (kernel)
    QuotaNonPagedPoolUsage: SIZE_T;     // Uso atual do pool não paginado (kernel)
    PagefileUsage: SIZE_T;              // Memória comprometida do processo (RAM + pagefile) (Em Delphi antigo, é o melhor "proxy" de memória real usada)
    PeakPagefileUsage: SIZE_T;          // Pico histórico de memória comprometida
    PrivateUsage: SIZE_T;               // Memória privada do processo (não compartilhada) (Melhor métrica para detectar vazamento de memória)
  end;

Type
  TMemSnapshot = record
    WorkingSetKB:    Int64;
    PrivateUsageKB:  Int64;
    PageFaultCount:  Cardinal;
    PagefileUsageKB: Int64;
  end;

Type
  TProcOrdenaMenuItem = reference to procedure(menu: TMenuItem);

Type
  TSemaforo = class(TObject)
  public
    class var intSemaforo: Integer;
    constructor Create;
  End;

  TMenuSemaforo = class(TObject)
  private
    FOrdenaMenuItem: TProcOrdenaMenuItem;
    FAfterExecute: TProc;
    FEvento: TNotifyEvent;
    FSemaforo: TSemaforo;
    FModoRobo: Boolean;
    procedure ThreadSafeAfterConnect(const AConnection : TUniConnection);
  public
    constructor Create(semaforo: TSemaforo; blnModoRobo: Boolean);
    procedure pExecutar(Sender: TObject);
    property Evento: TNotifyEvent Read FEvento Write FEvento;
    property OnAfterExecute: TProc Read FAfterExecute Write FAfterExecute;
    property OnOrdenaMenuItem: TProcOrdenaMenuItem Read FOrdenaMenuItem Write FOrdenaMenuItem;
  End;

  TMenuAcessos = class
  private
    FId: Int64;
    FMenuItem: TMenuItem;
    FModoRobo: Boolean;
    procedure pInsereAcesso;
    procedure pFinalizaAcesso;
  public
    constructor Create(menu: TMenuItem; blnModoRobo: Boolean);
    destructor Destroy; override;
    class function fGetRecentementeAcessados(intUltimos: Integer = 15): TStringList;
  end;

implementation

{ TMenuSemaforo }

uses untFuncoesSimples, untDicionarioResultadoQuerySimples, MadExcept,
  Controller.Faturamento.Interfaces.Cache, untFuncoesGenerica, untThreadUtils,
  untHorarioSistema, untModulo, untReformaTributariaTipos;

function GetProcessHandleCount(hProcess: THandle; var pdwHandleCount: DWORD): BOOL; stdcall; external 'Kernel32.dll' name 'GetProcessHandleCount';

function GetMemSnapshot: TMemSnapshot;
var
  PMC: PROCESS_MEMORY_COUNTERS_EX;
begin
  ZeroMemory(@PMC, SizeOf(PMC));
  PMC.cb := SizeOf(PMC);

  if GetProcessMemoryInfo(GetCurrentProcess, @PMC, SizeOf(PMC)) then
  begin
    Result.WorkingSetKB    := PMC.WorkingSetSize div 1024;
    Result.PrivateUsageKB  := PMC.PrivateUsage div 1024;
    Result.PageFaultCount  := PMC.PageFaultCount;
    Result.PagefileUsageKB := PMC.PagefileUsage div 1024;
  end
  else
  begin
    Result.WorkingSetKB    := 0;
    Result.PrivateUsageKB  := 0;
    Result.PageFaultCount  := 0;
    Result.PagefileUsageKB := 0;
  end;
end;

function GetOpenHandles: DWORD;
begin
 if not GetProcessHandleCount(GetCurrentProcess,Result) then
   RaiseLastOSError;
end;

constructor TMenuSemaforo.Create(semaforo: TSemaforo; blnModoRobo: Boolean);
begin
  Self.FSemaforo := semaforo;
  FModoRobo := blnModoRobo;
end;

procedure TMenuSemaforo.pExecutar(Sender: TObject);
Const
  arrIgnorarRecentes: Array Of String = ['mnuGerLayoutBan', 'mnuTintaDeMaquina'];
Var
  objAcesso: TMenuAcessos;

  function fIncluirMnuAce: Boolean;
    Var
      strMnuName: String;
  begin
    Result := False;

    If Sender Is TMenuItem Then
    Begin
      Result := True;

      strMnuName := TMenuItem(Sender).Name;
      If Pos('_PopUp_', strMnuName) > 0 Then
        strMnuName := LeftStr(strMnuName, Pos('_PopUp_', strMnuName) - 1);

      If MatchText(strMnuName, arrIgnorarRecentes) Then
        Result := False;

      If TMenuItem(Sender).Count > 0 Then
        Result := False;
    End;
  end;

begin
  If InterlockedIncrement(FSemaforo.intSemaforo) = 0 Then
  Begin
    Try
      objAcesso := Nil;
      Try
        If Sender Is TMenuItem Then
        Begin
          If Assigned(OnOrdenaMenuItem) Then
            OnOrdenaMenuItem(TMenuItem(Sender));
        End;

        TLimparCaches.Execute;
        TRefTribCache.pLimpar;

        untThreadUtils.TSafeThread.EnableLogging := fCfgSis('SFTLOG', VarBoolean);
        untThreadUtils.TSafeThread.MaxThreads    := fCfgSis('SFTMAX', VarInteger);
        untThreadUtils.TSafeThread.PrcAfterConnect := ThreadSafeAfterConnect;

        If fIncluirMnuAce Then
          objAcesso := TMenuAcessos.Create((Sender As TMenuItem), Self.FModoRobo);

        Evento(Sender);
      Finally
        If Assigned(objAcesso) Then
          FreeAndNil(objAcesso);

        If Assigned(OnAfterExecute) Then
          OnAfterExecute;

        TLimparCaches.Execute;
        TRefTribCache.pLimpar;
      End;

      InterlockedDecrement(FSemaforo.intSemaforo);
    Except
      On E: Exception Do
      Begin
        InterlockedDecrement(FSemaforo.intSemaforo);
        pGravaLogErrArquivoLocal(E.ClassName + ' - ' + E.Message, fRetornaStack, 'TMenuSemaforo.pExecutar');
        Raise;
      End;
    End;
  End
  Else
    InterlockedDecrement(FSemaforo.intSemaforo);
end;

procedure TMenuSemaforo.ThreadSafeAfterConnect(
  const AConnection: TUniConnection);
begin
  DefinirTimeZoneEmSessaoMySql(AConnection, VS_strCodEmp, True);
  TDiretivasDaConexao.DefineIsolationLevel(AConnection);
end;

{ TSemaforo }

constructor TSemaforo.Create;
begin
  intSemaforo := -1;
end;

{ TMenuAcessos }

constructor TMenuAcessos.Create(menu: TMenuItem; blnModoRobo: Boolean);
begin
  FId := 0;
  FMenuItem := menu;
  FModoRobo := blnModoRobo;
  pInsereAcesso;
end;

destructor TMenuAcessos.Destroy;
begin
  pFinalizaAcesso;
  inherited;
end;

class function TMenuAcessos.fGetRecentementeAcessados(intUltimos: Integer = 15): TStringList;
Var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;

  qryGen.SQL.Text := ' SELECT ACE_NOMMNU, MAX(ACE_HORINI) AS ULTIMO_ACESSO ' +
    ' FROM MNUACE WHERE ACE_CODEMP = ' + QuotedStr(Vs_strCodEmp) + ' AND ACE_CODOPE = ' +
    QuotedStr(strLoginUsuarioLogado) + ' GROUP BY ACE_NOMMNU ORDER BY ULTIMO_ACESSO DESC LIMIT ' +
    intUltimos.ToString;

  qryGen.Open;

  Result := TStringList.Create;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    Result.Add(qryGen.FieldByName('ACE_NOMMNU').AsString);
    qryGen.Next;
  End;

  FreeAndNil(qryGen);
end;

procedure TMenuAcessos.pFinalizaAcesso;
Var
  recMemory: TMemSnapshot;

  qryGen: TUniQuery;

  fltPercentualUsoGDI,
  fltPercentualUsoOBJ: Double;

  intDifHDL,
  intDifGDI,
  intDifOBJ,

  intCountHDLIni,
  intCountHDLFin,
  intCountGDIIni,
  intCountGDIFin,
  intCountOBJIni,
  intCountOBJFin: Integer;

  strText : String;
begin
  recMemory := GetMemSnapshot;
  pInicializaVariaveisContadoresObjetos;

  qryGen := fCriaQuery;
  Try
    qryGen.SQL.Text := 'SELECT * FROM MNUACE WHERE ACE_CODIGO = ' + IntToStr(FId);
    qryGen.Open;

    strText := '';
    fltPercentualUsoGDI := 0;
    fltPercentualUsoOBJ := 0;

    intCountHDLIni := 0;
    intCountHDLFin := 0;
    intCountGDIIni := 0;
    intCountGDIFin := 0;
    intCountOBJIni := 0;
    intCountOBJFin := 0;

    If Not qryGen.IsEmpty Then
    Begin
      qryGen.Edit;
      qryGen.FieldByName('ACE_HORFIN').AsDateTime := VS_Date + fTime();

      If qryGen.FindField('ACE_PHCFIN') <> Nil Then
      Begin
        qryGen.FindField('ACE_PHCFIN').AsInteger := GetOpenHandles;
        intCountHDLIni := qryGen.FindField('ACE_PHCINI').AsInteger;
        intCountHDLFin := qryGen.FindField('ACE_PHCFIN').AsInteger;
      End;

      If qryGen.FindField('ACE_GDIFIN') <> Nil Then
      Begin
        qryGen.FindField('ACE_GDIFIN').AsInteger := GetGuiResources(GetCurrentProcess, GR_GDIOBJECTS);
        intCountGDIIni := qryGen.FindField('ACE_GDIINI').AsInteger;
        intCountGDIFin := qryGen.FindField('ACE_GDIFIN').AsInteger;
      End;

      If qryGen.FindField('ACE_USOFIN') <> Nil Then
      Begin
        qryGen.FindField('ACE_USOFIN').AsInteger := GetGuiResources(GetCurrentProcess, GR_USEROBJECTS);
        intCountOBJIni := qryGen.FindField('ACE_USOINI').AsInteger;
        intCountOBJFin := qryGen.FindField('ACE_USOFIN').AsInteger;
      End;

      If qryGen.FindField('ACE_MEMFIN') <> Nil Then
        qryGen.FindField('ACE_MEMFIN').AsLargeInt := recMemory.PrivateUsageKB;

      intDifHDL := intCountHDLFin-intCountHDLIni;
      intDifGDI := intCountGDIFin-intCountGDIIni;
      intDifOBJ := intCountOBJFin-intCountOBJIni;

      If VS_GDIObjects<>0 Then
        fltPercentualUsoGDI := fFormataFloat(((intCountGDIFin/VS_GDIObjects)*100), 2);

      If VS_USEObjects<>0 Then
        fltPercentualUsoOBJ := fFormataFloat(((intCountOBJFin/VS_USEObjects)*100), 2);

      If (intDifHDL >= 500) Or
         (intDifGDI >= 500) Or
         (intDifOBJ >= 500) Or
         (fltPercentualUsoGDI > 80) Or
         (fltPercentualUsoOBJ > 80) Then
      Begin
        If qryGen.FindField('ACE_STACK_') <> Nil Then
        Begin
          strText :=
            'Versão Arquivo...: ' + fRetornaVersao(Application.ExeName, False) + #13 +
            'Versão Produto...: ' + fRetornaVersao(Application.ExeName, True)  + #13 +
            'Exec. date/time..: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', FileDateToDateTime(FileAge(ParamStr(0)))) + #13 +
            'Path do Arquivo..: ' + ExtractFilePath(Application.ExeName) + #13 +
            'Connection ID....: ' + fGetConnectionID() + #13 +
            'Process handle...: ' + fPadR(intCountHDLIni.ToString, 5)+'> '+fPadR(intCountHDLFin.ToString, 5)+' Incremento de:' + fPadL(IIF(intDifHDL<0,'','+') + intDifHDL.ToString, 8) + #13 +
            'GDI objects......: ' + fPadR(intCountGDIIni.ToString, 5)+'> '+fPadR(intCountGDIFin.ToString, 5)
                                  + ' Incremento de:' + fPadL(IIF(intDifGDI<0,'','+') + intDifGDI.ToString, 8) + ' '
                                  + ' Percentual de uso: ' + fPadL(fltPercentualUsoGDI.ToString + '%', 8) + ' '
                                  + ' Disponível: ' + VS_GDIObjects.ToString +#13 +
            'User objects.....: ' + fPadR(intCountOBJIni.ToString,5)+'> '+fPadR(intCountOBJFin.ToString,5)
                                  + ' Incremento de:' + fPadL(IIF(intDifOBJ<0,'','+') + intDifOBJ.ToString, 8) + ' '
                                  + ' Percentual de uso: ' + fPadL(fltPercentualUsoOBJ.ToString + '%', 8) + ' '
                                  + ' Disponível: ' + VS_USEObjects.ToString + #13 +
            'Logado no........: ' + IIF(blnUsuarioLogadoUtilizaModoClassico, 'Modo Clássico', 'Modo Skin');

          strText := strText + #10#13 + fGetNomeFormularios + #10#13 + fRetornaStack;

          qryGen.FindField('ACE_STACK_').Text := strText;
        End;
      End;

      qryGen.Post;

      DumpStats(qryGen.Connection, fGetConnectionID(qryGen.Connection), VS_ProcessId, IntToStr(FId));
    End;


    If (Not Self.FModoRobo) And (strText <> '') Then
    Begin
      If fEhAdministrador(strLoginUsuarioLogado) Then
      Begin
        fMensagem('', 'Atenção programador/implantador. A operação que acabou de fazer consumiu mais que 500 recursos de "Objetos do Usuário" ou "Objetos GDI" em uma só operação!' +#10#13+
                      'Lembre-se de tudo que fez nessa tela (menu que clicou, janela que abriu, etc), saia do Autcom e repetia a operação. '+
                      'Se essa mensagem persistir, abra o Gerenciador de Tarefas habilite as colunas "Objetos do Usuário e "Objetos GDI" na aba "Detalhes" '+
                      'deixe-o sempre visível, repita novamente o processo e tente identificar qual é a operação que fez os recursos serem consumidos.'+#10#13+
                      'Estamos fazendo isso buscando deixar o Autcom cada vez mais estável. Qualquer dúvida falar com a equipe de faturamento!', ['&Ok'],
                      1, False, 1, 0, False, 0, False, False, False, 0, 0, 8);
      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TMenuAcessos.pInsereAcesso;
  Var
    recMemory: TMemSnapshot;
    qryGen: TUniQuery;
begin
  recMemory := GetMemSnapshot;
  qryGen := fCriaQuery;
  try
    ClearStats;

    qryGen.SQL.Text := 'SELECT * FROM MNUACE WHERE FALSE';
    qryGen.Open;

    qryGen.Append;
    qryGen.FieldByName('ACE_CODOPE').AsString := strLoginUsuarioLogado;
    qryGen.FieldByName('ACE_CODEMP').AsString := Vs_strCodEmp;

    If Pos('_PopUp_', FMenuItem.Name) > 0 Then
    Begin
      qryGen.FieldByName('ACE_NOMMNU').AsString :=
        LeftStr(FMenuItem.Name, Pos('_PopUp_', FMenuItem.Name) - 1);

      If Assigned(Application.MainForm) And Assigned(Application.MainForm.menu) And
        Assigned(fFindMenu(qryGen.FieldByName('ACE_NOMMNU').AsString, Application.MainForm.menu.Items)) Then
      Begin
        qryGen.FieldByName('ACE_DESMNU').AsString :=
          fGetMenuPath(fFindMenu(qryGen.FieldByName('ACE_NOMMNU').AsString,
          Application.MainForm.menu.Items));
      End
      Else
        qryGen.FieldByName('ACE_DESMNU').AsString := fGetMenuPath(FMenuItem);
    End
    Else
    Begin
      qryGen.FieldByName('ACE_NOMMNU').AsString := FMenuItem.Name;
      qryGen.FieldByName('ACE_DESMNU').AsString := fGetMenuPath(FMenuItem);
    End;

    qryGen.FieldByName('ACE_DESMNU').AsString := qryGen.FieldByName('ACE_DESMNU').AsString.Replace('>  >', '>');
    qryGen.FieldByName('ACE_HORINI').AsDateTime := VS_Date + fTime();

    If qryGen.FindField('ACE_PHCINI') <> Nil Then
      qryGen.FindField('ACE_PHCINI').AsInteger := GetOpenHandles;

    If qryGen.FindField('ACE_GDIINI') <> Nil Then
      qryGen.FindField('ACE_GDIINI').AsInteger := GetGuiResources(GetCurrentProcess, GR_GDIOBJECTS);

    If qryGen.FindField('ACE_USOINI') <> Nil Then
      qryGen.FindField('ACE_USOINI').AsInteger := GetGuiResources(GetCurrentProcess, GR_USEROBJECTS);

    If qryGen.FindField('ACE_CON_ID') <> Nil Then
      qryGen.FindField('ACE_CON_ID').AsInteger := fGetConnectionID.ToInteger;

    If qryGen.FindField('ACE_MEMINI') <> Nil Then
      qryGen.FindField('ACE_MEMINI').AsLargeInt := recMemory.PrivateUsageKB;

    qryGen.Post;

    FId := qryGen.FieldByName('ACE_CODIGO').AsLargeInt;

    qryGen.Edit;
    qryGen.FieldByName('AUTOINCREM').AsString := '000' + fStrZero(FId, 14) + '000';
    qryGen.Post;

    VS_strLastMenuName := qryGen.FieldByName('ACE_NOMMNU').AsString;
    VS_strLastMenuCaption := qryGen.FieldByName('ACE_DESMNU').AsString;
  finally
    FreeAndNil(qryGen);
  end;
end;

end.
