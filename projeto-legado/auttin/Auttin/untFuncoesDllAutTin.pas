unit untFuncoesDllAutTin;

interface

uses
  untFuncoesSimples, untModuloSPR, untModuloReplicacao, untModulo,
  untModuloCons, untModuloTinta,  SysUtils, Forms, Dialogs, Windows,
  UniClientDataSet, Variants, dxCore, Uni, DB, Vcl.Themes, Vcl.Styles,
  Vcl.SysStyles, untIFuncIns, untFuncInsFactory, untTypesSistema,
  untConfiguracoes, untConstantes, untGravando, untILibTintaFactory,
  untILibTinta, untITintasDeMaquina, untIAuttinMenuItem, Vcl.Menus,
  System.Classes, untFuncTinta, untAuttinWrapper, untGerenciadorMenuAuttinDlls,
  untCreateMenuDireitoAcesso, ComCtrls, System.Generics.Collections;

Type
  TCriarMenuTinta = class(TInterfacedObject)
  Private
    FIdentificadoresProcessados: TStringList;
    dicVersao : TDictionary<string,string>;
    function fRetVersaoTintometrico(strIdePro: String): String;
  Public
    Constructor Create;
    Destructor Destroy; override;
    Procedure ProcessarMenuTintasDll(subMenu: TMenuItem; stlSubMenus: TStringList); Stdcall;
    Procedure ProcessarSubMenus(Menu: IAuttinMenuItem; subMenu: TMenuItem; strNomeTinta: String; strIdePro: String; stlSubMenus: TStringList); Stdcall;
    Procedure ProcessarMenuTintaEspecifica(subMenu: TMenuItem; stlSubMenus: TStringList; const strIdentificador: String);
    procedure mnuGenericDllTintaMenuClick(Sender: TObject);
  End;

function fRetVersionSVNAutTin(): String; Stdcall;
procedure dxInitializeAuttin; Stdcall;
procedure dxFinalizeAuttin; Stdcall;
procedure pInicializaDllAutTin(frmModuloPar: TUniConnection;
                               Handle: HWND;
                               intDebugH: Byte;
                               strUsuario,
                               strEmpAceUsuLogado,
                               strEmpresa: String;
                               objTraceViewer: ITraceViewer;
                               blnUsuarioLogadoUtilizaModoClassico: Boolean); Stdcall;
procedure ProcessaMenuDireitoAcesso(trvMenu: TTreeView); StdCall;
function fMenuTintaToXml(): String; Stdcall;
procedure pOnClickMenuGenericTinta(Const menuName: String); Stdcall;
procedure pConfiguracaoTintaMaquina(); Stdcall;
procedure pEliminaMenuTinta(MenuItem: TMenuItem);
procedure pFinalizandoAutTin;
function fRetornaDicConfigInicialAutTin: TDictionary<string,boolean>; stdcall;
procedure pIniciaFinalizaDicConfigInicialAutTin(const blnFinaliza: Boolean=False); stdcall;
procedure pProcessarTodasTintasParaModoCompleto; Stdcall;

Var
  mnuTinta: TMenuItem;
  stlTinta: TStringList;
  processaMenu: TCriarMenuTinta;

implementation

function fRetVersionSVNAutTin(): String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

procedure dxInitializeAuttin;
Begin
  dxInitialize;
End;

procedure pFinalizandoAutTin;
begin
  StyleServices.ApplyThemeChange;

  If Assigned(frmModulo) Then
  Begin
    frmModulo.Database.AssignConnect(Nil);
    frmModulo.Database.Disconnect;
    FreeAndNil(frmModulo);
  End;

  If Assigned(frmModuloSPR) Then
    FreeAndNil(frmModuloSPR);

  If Assigned(frmModuloReplicacao) Then
    FreeAndNil(frmModuloReplicacao);

  If Assigned(frmModuloTinta) Then
    FreeAndNil(frmModuloTinta);

  If Assigned(processaMenu) Then
  Begin
    TGerenciadorMenuAuttinDlls.DesRegistrar;
    FreeAndNil(processaMenu);
  End;

  If Assigned(untFuncoesSimples.dicConfigInicial) Then
    FreeAndNil(untFuncoesSimples.dicConfigInicial);

  If Assigned(stlTinta) Then
    FreeAndNil(stlTinta);

 If Assigned(mnuTinta) Then
  Begin
    pEliminaMenuTinta(mnuTinta);
    mnuTinta := nil;
  End;
end;

procedure dxFinalizeAuttin;
Begin
  dxFinalize;
  pFinalizandoAutTin;
End;

function fRetornaDicConfigInicialAutTin: TDictionary<string,boolean>;
begin
  Result := untFuncoesSimples.dicConfigInicial;
end;

procedure pIniciaFinalizaDicConfigInicialAutTin(const blnFinaliza: Boolean=False);
begin
  If (blnFinaliza) Then
  Begin
    If (Assigned(untFuncoesSimples.dicConfigInicial)) Then
      FreeAndNil(untFuncoesSimples.dicConfigInicial);

    If (Assigned(untFuncoesSimples.dicConfiguracoes)) Then
    Begin
      untFuncoesSimples.dicConfiguracoes.Clear;
      untFuncoesSimples.dicConfiguracoes.TrimExcess;
    End;
  End
  Else
  Begin
    If (Assigned(untFuncoesSimples.dicConfigInicial)) Then
    Begin
      untFuncoesSimples.dicConfigInicial.Clear;
      untFuncoesSimples.dicConfigInicial.TrimExcess;
    End
    Else
      untFuncoesSimples.dicConfigInicial := TDictionary<string,boolean>.Create
  End;
end;

procedure pProcessarTodasTintasParaModoCompleto; Stdcall;
begin
  if Assigned(processaMenu) and Assigned(mnuTinta) and Assigned(stlTinta) then
    processaMenu.ProcessarMenuTintasDll(mnuTinta, stlTinta);
end;

procedure pInicializaDllAutTin(frmModuloPar: TUniConnection;
                               Handle: HWND;
                               intDebugH: Byte;
                               strUsuario,
                               strEmpAceUsuLogado,
                               strEmpresa: String;
                               objTraceViewer: ITraceViewer;
                               blnUsuarioLogadoUtilizaModoClassico: Boolean);
Begin
  pIniciaLogLeak(intDebugH, 'libAuttin');
  VS_APPLICATION_HANDLE := Handle;

  untFuncoesSimples.strLoginUsuarioLogado := Trim(strUsuario);
  untFuncoesSimples.pSetaEmpresaLogada(Trim(strEmpresa));
  untFuncoesSimples.VS_objTraceViewer     := objTraceViewer;
  untFuncoesSimples.blnUsuarioLogadoUtilizaModoClassico := blnUsuarioLogadoUtilizaModoClassico;

  If Not Assigned(frmModulo) Then
  Begin
    frmModulo := TfrmModulo.CreateInstance(Nil, False);
    frmModulo.Database.AssignConnect(frmModuloPar);
  End;

  If Not Assigned(frmModuloSPR) Then
  Begin
    frmModuloSPR        := TfrmModuloSPR.Create(Nil);
    frmModuloSPR.qryRelatorio.Connection := frmModulo.GetCurrentConnection;
  End;

  If Not Assigned(frmModuloReplicacao) Then
    frmModuloReplicacao := TfrmModuloReplicacao.Create(Nil);

  If Not Assigned(frmModuloTinta) Then
    frmModuloTinta := TfrmModuloTinta.Create(Nil);

  If Not blnUsuarioLogadoUtilizaModoClassico Then
  Begin
    Try
      TStyleManager.TrySetStyle(AUTCOM_STYLE_NAME);
      TfrmGravando.CorPadraoTema := AUTCOM_COR_TELA_AGUARDE_TEMA;

      TCustomStyleEngine.UnRegisterSysStyleHook('#32768', TSysPopupStyleHook);

      TCustomStyleEngine.UnRegisterSysStyleHook('#32770', TSysDialogStyleHook);

      TCustomStyleEngine.UnRegisterSysStyleHook('ScrollBar', TSysScrollBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('Button', TSysButtonStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('Edit', TSysEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('ComboBox', TSysComboBoxStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('ListBox', TSysListBoxStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('ComboLBox', TSysListBoxStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('Static', TSysStaticStyleHook);

      TCustomStyleEngine.UnRegisterSysStyleHook('ToolbarWindow32', TSysToolbarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('SysListView32', TSysListViewStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('SysTabControl32', TSysTabControlStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('SysTreeView32', TSysTreeViewStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('msctls_progress32', TSysProgressBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit20A', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit20W', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit30A', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit30W', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit41A', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit41W', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit50A', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit50W', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RebarWindow32', TSysReBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('msctls_statusbar32', TSysStatusBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('msctls_trackbar32', TSysTrackBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('msctls_updown32', TSysUpDownStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('tooltips_class32', TSysTooltipsStyleHook);
    Except
      untFuncoesSimples.blnUsuarioLogadoUtilizaModoClassico := True;
    End;
  End;

  fAjustaDataSistema;
  pCarregaVsTemFil;
  pAtuVarGlobaisSimples;
  untFuncoesSimples.pVerificaPROCOD();

  mnuTinta := TMenuItem.Create(Nil);
  mnuTinta.Name := 'mnuTintaDeMaquina';
  mnuTinta.Hint := 'mnuTintaDeMaquina';
  mnuTinta.Caption := 'Tinta de Máquina';
  mnuTinta.Visible := True;

  stlTinta := TStringList.Create;

  {$WARNINGS OFF}
  pIniciaDllFuncoes(frmModulo.GetCurrentConnection,
                    untFuncoesSimples.strLoginUsuarioLogado,
                    untFuncoesSimples.VS_strCodEmp,
                    DebugHook,
                    TCfgSis.Create(),
                    untFuncoesSimples.VS_objTraceViewer,
                    untFuncoesSimples.VS_Date,
                    untFuncoesSimples.VS_ComputerNetName,
                    untFuncoesSimples.VS_UserFromWindows,
                    untFuncoesSimples.VS_IPAddressAsString,
                    untFuncoesSimples.VS_MacAddress);
  {$WARNINGS ON}

  processaMenu := TCriarMenuTinta.Create();
End;

procedure pConfiguracaoTintaMaquina();
Begin
  Try
    untFuncoesSimples.pVerificaProCod;
    pCriarFormularios(TfrmConfiguracoes, frmConfiguracoes);
    frmConfiguracoes.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pConfiguracaoTintaMaquina]');
    End;
  End;
  pFreeAndNil(frmConfiguracoes);
End;

function fMenuTintaToXml(): String;
Begin
  Result := fMenuToXml(mnuTinta);

  If (Result <> '') Then
    Result := '<?xml version="1.0" encoding="UTF-8"?>' + Result;
End;

procedure pEliminaMenuTinta(MenuItem: TMenuItem);
 Var
   intIdx: Integer;
begin
  If Assigned(MenuItem) Then
  Begin
    For intIdx := MenuItem.Count - 1 Downto 0 Do
      If Assigned(MenuItem.Items[intIdx]) Then
        pEliminaMenuTinta(MenuItem.Items[intIdx]);

    If Assigned(MenuItem.Parent) Then
      MenuItem.Parent.Remove(MenuItem);
    MenuItem.Free;
  End;
End;

procedure pOnClickMenuGenericTinta(Const menuName: String); Stdcall;
Var
  strAjuForm: String;
  intForm: Integer;
  auTTin: TAuttinWrapper;
begin
  intForm := Pos('_', menuName);
  strAjuForm := Copy(menuName, 1, intForm - 1);

  auTTin := TAuttinWrapper.Create;
  If intForm = 0 Then
    TGerenciadorMenuAuttinDlls.Get(menuName).Executar(auTTin)
  Else
    TGerenciadorMenuAuttinDlls.Get(strAjuForm).Executar(auTTin);
end;

procedure ProcessaMenuDireitoAcesso(trvMenu: TTreeView);
Var
  processaMenu: TMenuDireitoAceAutTin;
Begin
  processaMenu := TMenuDireitoAceAutTin.Create();
  processaMenu.ProcessarMenuTintasDll(trvMenu);
End;

{ TCriarMenuTinta }

constructor TCriarMenuTinta.Create;
begin
  inherited;
  FIdentificadoresProcessados := TStringList.Create;
  FIdentificadoresProcessados.Sorted := True;
  FIdentificadoresProcessados.Duplicates := dupIgnore;
end;

destructor TCriarMenuTinta.Destroy;
begin
  if Assigned(dicVersao) then
    FreeAndNil(dicVersao);
  FreeAndNil(FIdentificadoresProcessados);
  inherited;
end;

function TCriarMenuTinta.fRetVersaoTintometrico(strIdePro: String): String;
Var
  qryAux : TUniQuery;

  function pVersao: String;
  begin
    If (Not dicVersao.TryGetValue(strIdePro, Result)) Then
      Result := '';
  end;

begin
  If Assigned(dicVersao) Then
    Result := pVersao
  Else
  Begin
    dicVersao := TDictionary<string,string>.Create;

    qryAux := fCriaQuery;
    Try
      qryAux.Close;
      qryAux.SQL.Text := ' SELECT CFG_IDEPRO AS IDEPRO, TRIM(CFG_VALCFG) AS VALCFG '+
                         '   FROM CFGTIN '+
                         '  WHERE CFG_CODCFG = "VERSAO" '+
                         '    AND CFG_CODEMP = :CODEMP  ';
      qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryAux.Open;
      qryAux.First;

      While Not qryAux.Eof Do
      Begin
        dicVersao.AddOrSetValue(qryAux.FieldByName('IDEPRO').AsString,
                                qryAux.FieldByName('VALCFG').AsString);
        qryAux.Next;
      End;
    Finally
      FreeAndNil(qryAux);
      Result := pVersao;
    End;
  End;
end;

procedure TCriarMenuTinta.mnuGenericDllTintaMenuClick(Sender: TObject);
Var
  strAjuForm: String;
  intForm: Integer;
  auTTin: TAuttinWrapper;
begin
  intForm := Pos('_', TMenuItem(Sender).Name);
  strAjuForm := Copy(TMenuItem(Sender).Name, 1, intForm - 1);

  auTTin := TAuttinWrapper.Create;
  If intForm = 0 Then
    TGerenciadorMenuAuttinDlls.Get(TMenuItem(Sender).Name).Executar(auTTin)
  Else
    TGerenciadorMenuAuttinDlls.Get(strAjuForm).Executar(auTTin);
end;

procedure TCriarMenuTinta.ProcessarMenuTintaEspecifica(subMenu: TMenuItem;
  stlSubMenus: TStringList; const strIdentificador: String);
var
  libTintaFactory: ILibTintaFactory;
  libTinta: ILibTinta;
begin
  if FIdentificadoresProcessados.IndexOf(strIdentificador) >= 0 then
    Exit;

  libTintaFactory := GetLibTintaFactory;
  libTinta := libTintaFactory.GetITintadeMaquina(strIdentificador);
  if Assigned(libTinta) then
  begin
    ProcessarSubMenus(libTinta.Menu, subMenu, libTinta.GetNomeTinta, strIdentificador, stlSubMenus);
    FIdentificadoresProcessados.Add(strIdentificador);
  end;
end;

procedure TCriarMenuTinta.ProcessarMenuTintasDll(subMenu: TMenuItem; stlSubMenus: TStringList);
var
  libTintaFactory: ILibTintaFactory;
  stlIdentificadores: TStringList;
  stlDllsDuplicadas: TStringList;
  intCont: Integer;
begin
  stlIdentificadores := nil;
  stlDllsDuplicadas  := nil;
  Try
    stlIdentificadores := TStringList.Create;
    stlDllsDuplicadas  := TStringList.Create;

    libTintaFactory := GetLibTintaFactory;
    libTintaFactory.GetIdentificadores(stlIdentificadores);
    For intCont := 0 To stlIdentificadores.Count - 1 Do
    Begin
      If stlDllsDuplicadas.IndexOf(stlIdentificadores[intCont]) < 0 then
      Begin
        ProcessarMenuTintaEspecifica(subMenu, stlSubMenus, stlIdentificadores[intCont]);
        stlDllsDuplicadas.Add(stlIdentificadores[intCont]);
      End
      Else
      Begin
        fMensagem('Atenção', 'A tinta de máquina [' + stlIdentificadores[intCont] + '] está com a sua dll duplicada' + #13#10 +
                             'no diretório autcom\auttin\tintas. ' + #13#10 +
                             'Favor entrar em contato com a citel.' + #13#10 +
                             'Obrigado.', ['&Ok']);
      End;
    End;
  Finally
    If Assigned(stlIdentificadores) Then FreeAndNil(stlIdentificadores);
    If Assigned(stlDllsDuplicadas) Then FreeAndNil(stlDllsDuplicadas);
  End;
end;

procedure TCriarMenuTinta.ProcessarSubMenus(Menu: IAuttinMenuItem;
  subMenu: TMenuItem; strNomeTinta, strIdePro: String;  stlSubMenus: TStringList);
var
  intCont      : Integer;
  novo         : TMenuItem;
  strVersao    : String;
begin
  If Not Assigned(menu) Then
    Exit;

  novo := TMenuItem.Create(subMenu);
  strVersao := fRetVersaoTintometrico(strIdePro);

  If (Pos(strNomeTinta, menu.Caption) > 0) And (Not fEmptyStr(strVersao)) Then
    novo.Caption := menu.Caption + ' - '+ strVersao
  Else
    novo.Caption := menu.Caption;

  novo.Name := 'mnu' + GetValidComponentName(Copy(menu.Hint, 4, Length(menu.Hint)));
  novo.Hint := menu.Hint;
  novo.Visible := True;
  subMenu.Add(novo);
  TGerenciadorMenuAuttinDlls.Registrar(novo.Name, menu);

  For intCont := 0 To menu.Cont - 1 Do
    ProcessarSubMenus(menu[intCont], novo, strNomeTinta, strIdepro, stlSubMenus);

  If menu.Cont <> 0 Then
    stlSubMenus.Add(IntToStr(menu.Cont));
End;

end.
